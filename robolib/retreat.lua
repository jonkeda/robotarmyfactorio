require("config.config")
require("util")
require("robolib.Squad")
require("robolib.util")
require("stdlib/log/logger")
require("stdlib/game")

-- this efficient AND reliable retreat logic has gotten so large that it really deserves its own file.


function orderSquadToRetreat(squad)
	local assembler = nil
	local distance = 999999
	if squad.retreatToAssembler and squad.retreatToAssembler.valid then
		assembler = squad.retreatToAssembler
		distance = util.distance(squad.unitGroup.position, assembler.position)
	else
		assembler, distance = findClosestAssemblerToPosition(
			global.DroidAssemblers[squad.force.name], squad.unitGroup.position)
	end

	if assembler then
		local lastPos = squad.unitGroup.position

		if distance > AT_ASSEMBLER_RANGE then
			-- don't give orders to retreat to a location we are already making progress towards
			local makingProgress = isSquadMovingAwayFromLastPosition(squad)
			if not makingProgress or assembler ~= squad.retreatToAssembler then
				-- issue an actual retreat command
				debugSquadOrder(squad, "RETREAT TO ASSEMBLER", assembler.position)
				orderToAssembler(squad.unitGroup, assembler, not makingProgress)
				squad.unitGroup.start_moving()
			end
		elseif squad.command == commands.hunt then
			-- we're close enough already, and we haven't checked recently.
			-- check for nearby squads to merge
			squad.command = commands.assemble -- so we don't check again soon
			attemptToMergeSquadWithNearbyAssemblingSquad(
				squad, global.RetreatingSquads[squad.force.name], AT_ASSEMBLER_RANGE * 2)

			-- this last function call may actually invalidate the squad
			if squad.deleted then return end
		end

		-- new assemblers may have been placed since the last retreat order,
		-- so re-add to retreat tables just in case
		addSquadToRetreatTables(squad, assembler)
		squad.lastBattleOrderTick = game.tick
		squad.lastBattleOrderPos = lastPos
	end
end


function addSquadToRetreatTables(squad, targetAssembler)
	-- look for nearby assemblers and add squad to those tables as well
	retreatAssemblers = findNearbyAssemblers(global.DroidAssemblers[squad.force.name],
											 targetAssembler.position, AT_ASSEMBLER_RANGE)
	for i=1, #retreatAssemblers do -- cool/faster iteration syntax for list-like table
		local assembler = retreatAssemblers[i]
		LOGGER.log(string.format("Adding squad %d to retreat table of assembler at (%d,%d)",
								 squad.squadID, assembler.position.x, assembler.position.y))
		if not global.AssemblerRetreatTables[squad.force.name][assembler] then
			global.AssemblerRetreatTables[squad.force.name][assembler] = {}
		end
		global.AssemblerRetreatTables[squad.force.name][assembler][squad.squadID] = squad
		global.RetreatingSquads[squad.force.name][squad.squadID] = squad
	end
	squad.retreatToAssembler = targetAssembler
end


function checkRetreatAssemblersForMergeableSquads(assemblerRetreatTable)
	for assembler, squads in pairs(assemblerRetreatTable) do
		if not assembler.valid then
			assemblerRetreatTable[assembler] = nil -- don't iterate over this one again
		else -- assembler is still valid; proceed
			local mergeableSquad = nil
			local mergeableSquadDist = nil
			LOGGER.log(string.format("Trying to merge retreating squads near assembler at (%d,%d)",
									 assembler.position.x, assembler.position.y))
			local squadCount = 0
			local squadCloseCount = 0
			for squadID, squad in pairs(squads) do
				if not squadStillExists(squad) or shouldHunt(squad) then
					squads[squadID] = nil
				else
					squadCount = squadCount + 1
					local dist = util.distance(squad.unitGroup.position,
											   assembler.position)
					if dist < MERGE_RANGE then
						-- then this squad is close enough to be merged, if it is still valid
						if validateSquadIntegrity(squad) then
							squadCloseCount = squadCloseCount + 1
							-- LOGGER.log(string.format(
							-- 			   " ---- Squad %d sz %d is near its retreating assembler.",
							-- 			   squad.squadID, squad.numMembers))
							if mergeableSquad then -- we already found a mergeable squad nearby
								-- are we close enough to this other squad to merge?
								if util.distance(mergeableSquad.unitGroup.position,
												 squad.unitGroup.position) < MERGE_RANGE
								then
									mergeableSquad = mergeSquads(squad, mergeableSquad)
									if shouldHunt(mergeableSquad) then
										squads[squadID] = nil
										mergeableSquad = nil
										mergeableSquadDist = nil
									end
								elseif mergeableSquadDist > dist then
									-- our previous 'mergeableSquad' is a little too far away,
									-- and may have retreated to a different, nearby assembler.
									-- Since this merge was not okay, we will instead choose the current
									-- squad, which is closer to the assembler, as the 'mergeableSquad' for
									-- any future merge attempts.
									mergeableSquad = squad
									mergeableSquadDist = dist
								end
							else -- set first 'mergeable squad'
								mergeableSquad = squad
								mergeableSquadDist = dist
							end
						else
							-- squad is invalid. don't check again
							squads[squadID] = nil
						end
					end
				end
			end
			if squadCount == 0 then
				-- don't iterate over this assembler again until it is 'recreated'
				-- by a squad trying to retreat to it
				assemblerRetreatTable[assembler] = nil
			end
			LOGGER.log(string.format("Assembler merge examined %d squads, of which %d were near this assembler at (%d,%d)",
									 squadCount, squadCloseCount, assembler.position.x, assembler.position.y))
		end
	end
end