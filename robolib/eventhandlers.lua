require("util")
require("config.config") -- config for squad control mechanics - important for anyone using
require("robolib.util") -- some utility functions not necessarily related to robot army mod
require("robolib.robotarmyhelpers") -- random helper functions related to the robot army mod
require("robolib.SquadControl") -- allows us to control squads, add entities to squads, etc.
require("prototypes.DroidUnitList") -- so we know what is spawnable
require("stdlib/log/logger")
require("stdlib/game")


function runOnceCheck(game_forces)
    if not global.runOnce then
        LOGGER.log("Running the runOnce function to reset recipes and tech to ensure all are correct...")
        --force reset every force's recipes and techs. I'm sick of it not doing this for me!
        for _, force in pairs(game_forces) do
            force.reset_recipes()
            force.reset_technologies()
        end
        global.runOnce = true
    end
end


function processSquadUpdatesForTick(force_name, tickProcessIndex)
    --for the current tick, look at the global table for that tick (mod 60) and any squad references in there.
    --LOGGER.log(string.format("Processing AI for AI tick %d of 60", tickProcessIndex))
    local forceTickTable = global.updateTable[force_name]
    local squadTable = global.Squads[force_name]
    for i, squadref in pairs(forceTickTable[tickProcessIndex]) do
        if squadref and squadTable[squadref] then
            -- local squad = global.Squads[force_name][squadref]
            -- if not squad.force then squad.force = force
            updateSquad(squadTable[squadref])
        else
            -- the squad has been deleted at some point, so let's stop looping over it here.
            LOGGER.log(string.format("Removing nil squad %d from tick table", squadref))
            global.updateTable[force_name][tickProcessIndex][i] = nil
        end
    end
end



function reportSelectedUnits(event, alt)
	if (event.item == "droid-selection-tool") then
		local player = game.players[event.player_index]
		local area = event.area;

		-- ensure the area is non-zero
		area.left_top.x = area.left_top.x - 0.1
		area.left_top.y = area.left_top.y - 0.1
		area.right_bottom.x = area.right_bottom.x + 0.1
		area.right_bottom.y = area.right_bottom.y + 0.1

		local clickPosition = {x = (area.right_bottom.x + area.left_top.x) / 2 , y = (area.right_bottom.y + area.left_top.y)/ 2}
		--Game.print_all(string.format("point %d,%d, middle of box %d,%d and %d,%d", clickPosition.x, clickPosition.y, area.left_top.x, area.left_top.y, area.right_bottom.x, area.right_bottom.y))
		if not alt then -- add units to selection table

			--local select_entities = player.surface.find_entities_filtered{ area = area, type = "unit", force = player.force}
			--local numberOfSelected = table.countNonNil(select_entities)

			local squad = getClosestSquadToPos(global.Squads[player.force.name], clickPosition, SQUAD_CHECK_RANGE) --get nearest squad within SQUAD_CHECK_RANGE amount of tiles radius from click point.

			if squad then
                
                -- if there's a currently selected squad, deselect them! 
                --DESELECT LOGIC
				if global.selected_squad and global.selected_squad[player.index] and global.selected_squad[player.index] ~= nil then
					if global.Squads[player.force.name][global.selected_squad[player.index]] then  --if the squad still exists, even though we have the ID still in selection
						Game.print_all(string.format("De-selected Squad ID %d", global.selected_squad[player.index]) )
						for _, member in pairs(global.Squads[player.force.name][global.selected_squad[player.index]].unitGroup.members) do
							local unitBox = member.bounding_box
							unitBox.left_top.x = unitBox.left_top.x - 0.1
							unitBox.left_top.y = unitBox.left_top.y - 0.1
							unitBox.right_bottom.x = unitBox.right_bottom.x + 0.1
							unitBox.right_bottom.y = unitBox.right_bottom.y + 0.1

							for _,e in pairs(member.surface.find_entities_filtered{type="sticker", area=unitBox}) do
							  e.destroy()
							end
						end
					end
				end
                
                
				Game.print_all(string.format("Squad ID %d selected! Droids in squad: %d", squad.squadID, squad.numMembers) )
				--Game.print_all(string.format("Tool %s Selected area! Player ID %d, box %d,%d and %d,%d, droids in squad %d ",  event.item , event.player_index, area.left_top.x, area.left_top.y, area.right_bottom.x, area.right_bottom.y, squad.numMembers ) )


				--make sure we have the global table..
				if not global.selected_squad then global.selected_squad = {} end

				global.selected_squad[player.index] = {}
				global.selected_squad[player.index] = squad.squadID

				for _, member in pairs(global.Squads[player.force.name][squad.squadID].unitGroup.members) do

					 global.Squads[player.force.name][squad.squadID].unitGroup.surface.create_entity{name = "selection-sticker", position = member.position , target = member}

				end

			else
				--no squad was nearby the click point!
				--make sure we have the global table..
				if not global.selected_squad then global.selected_squad = {} end

				--DESELECT LOGIC
				if global.selected_squad[player.index] ~= nil then
					if global.Squads[player.force.name][global.selected_squad[player.index]] then  --if the squad still exists, even though we have the ID still in selection
						Game.print_all(string.format("De-selected Squad ID %d", global.selected_squad[player.index]) )
						for _, member in pairs(global.Squads[player.force.name][global.selected_squad[player.index]].unitGroup.members) do
							local unitBox = member.bounding_box
							unitBox.left_top.x = unitBox.left_top.x - 0.1
							unitBox.left_top.y = unitBox.left_top.y - 0.1
							unitBox.right_bottom.x = unitBox.right_bottom.x + 0.1
							unitBox.right_bottom.y = unitBox.right_bottom.y + 0.1

							for _,e in pairs(member.surface.find_entities_filtered{type="sticker", area=unitBox}) do
							  e.destroy()
							end
						end
					end
				else

					global.selected_squad[player.index] = nil
				end

			end



		else --command selected units to move to position clicked.
			if global.selected_squad and global.selected_squad[event.player_index] then
			local squad = global.Squads[player.force.name][(global.selected_squad[event.player_index])]
				if(squad) then
					--Game.print_all(string.format("Tool %s Selected alt-selected-area! Player ID %d, box %d,%d and %d,%d, droids in squad %d ", event.item, event.player_index, area.left_top.x,area.left_top.y, area.right_bottom.x, area.right_bottom.y, squad.numMembers ) )
					--Game.print_all(string.format("Commanding Squad ID %d ...", global.selected_squad[event.player_index]))
					squad.command.type = commands.guard
					orderSquadToAttack(squad, clickPosition)
				end
			end

		end

	else --if it's a pickup tool maybe?

		if (event.item == "droid-pickup-tool") then

			local player = game.players[event.player_index]
			local area = event.area;

			-- ensure the area is non-zero
			area.left_top.x = area.left_top.x - 0.01
			area.left_top.y = area.left_top.y - 0.01
			area.right_bottom.x = area.right_bottom.x + 0.01
			area.right_bottom.y = area.right_bottom.y + 0.01

			local unitList = player.surface.find_entities_filtered{	area = area, type = "unit",	force = player.force }

			--Game.print_all(string.format( "number of units in area selected %d", #unitList) )

			for _ , unit in pairs(unitList) do

				--Game.print_all(string.format( "Trying to pick up unit type %s, unit name %s" , unit.type, unit.name ) )
				local nameOfUnit = convertToMatchable(unit.name)
				--if it's one of our droids, kill it!  Note, the spawnable table comes from DroidUnitList.lua in prototypes folder.
				local removed = false
				for _, droidname in pairs(spawnable) do
					local comparableDroidName = convertToMatchable(droidname)
					--Game.print_all(string.format( "Trying to compare names: unit name  %s, spawnable droid list name %s" , nameOfUnit, comparableDroidName ) )
					if not removed and (string.find(nameOfUnit, comparableDroidName)) then
						removed = true

						player.insert{name= unit.name, count=1}
						unit.destroy()
					end
				end

			end

		end

	end
end


function processSpawnedDroid(droid, guard, guardPos, manuallyPlaced)
    local force = droid.force
    --player.print(string.format("Processing new entity %s spawned by player %s", droid.name, player.name) )
    local position = droid.position

    --if this is the first time we are using the player's tables, make it
    if not global.Squads[force.name] then
        global.Squads[force.name] = {}
    end

    local squad = getClosestSquadToPos(global.Squads[force.name], droid.position, SQUAD_CHECK_RANGE)
    if squad and getSquadSurface(squad) ~= droid.surface then
        squad = nil  --we cannot allow a squad to be joined if it's on the wrong surface
    end

    if not squad then
        --if we didnt find a squad nearby, create one
        squad = createNewSquad(global.Squads[force.name], droid)
        if not squad then
            Game.print_force(force, "Failed to create squad for newly spawned droid!!")
        end
    end

    addMemberToSquad(squad, droid)
    if manuallyPlaced then
        LOGGER.log(string.format(" # # # # Manually placed droid causing squad %d to request new orders.",
                                 squad.squadID))
        squad.command.state_changed_since_last_command = true
    end

    -- code to handle adding new member to a squad that is guarding/patrolling
    if guard == true or squad.command.type == commands.guard then
        if squad.command.type ~= commands.guard then
            squad.command.type = commands.guard
            squad.home = guardPos
            --game.players[1].print(string.format("Setting guard squad to wander around %s", event.guardPos))

            --check if the squad it just joined is patrolling,
            -- if it is, don't force any more move commands because it will be disruptive!
            if not squad.patrolState or
                (squad.patrolState and squad.patrolState.currentWaypoint == -1)
            then
                --Game.print_force(droid.force, "Setting move command to squad home..." )
                orderSquadToWander(squad, squad.home, true)
            end
        end
    end
end


function processDroidAssemblers(force)
    if global.DroidAssemblers and global.DroidAssemblers[force.name] then
        --for each building in their list using name as key
        for index, assembler in pairs(global.DroidAssemblers[force.name]) do
            if assembler and assembler.valid and assembler.force == force then
                local player = assembler.last_user
                local inv = assembler.get_output_inventory() --gets us a LuaInventory
                -- checks list of spawnable droid names, returns nil if none found. otherwise we get a spawnable entity name
                local spawnableDroidName = containsSpawnableDroid(inv)
                if (spawnableDroidName ~= nil and type(spawnableDroidName) == "string") then
                    -- uses assmbler pos, direction, and spawns droid at an offset +- random amount. Does a final "find_non_colliding_position" before returning

                    -- check surrounding area to see if we have reached a limit of spawned droids, to prevent a constantly spawning situation
                    local nearby = countNearbyDroids(assembler.position, assembler.force, 30)
                    if (nearby <= (getSquadHuntSize(assembler.force)*1.5))  then
                        local droidPos =  getDroidSpawnLocation(assembler)
                        if droidPos then
                            local returnedEntity = assembler.surface.create_entity(
                                {name = spawnableDroidName,
                                 position = droidPos,
                                 direction = defines.direction.east,
                                 force = assembler.force })
                            if returnedEntity then
                                processSpawnedDroid(returnedEntity)
                            end
                            inv.clear() --clear output slot
                        end
                    else
                        --Game.print_force(force, "Cannot spawn droid, too many droids or obstructions around droid assembler!")
                    end
                end
            end
        end
    end
end


function processDroidGuardStations(force)
    --handle guard station spawning here
    if global.droidGuardStations and global.droidGuardStations[force.name] then
        for _, station in pairs(global.droidGuardStations[force.name]) do
            if station and station.valid and station.force == force then
                local inv = station.get_output_inventory() --gets us a luainventory
                local player = station.last_user
                local spawnableDroidName = containsSpawnableDroid(inv)
                local nearby = countNearbyDroids(station.position, station.force, 30) --inputs are position, force, and radius
                --if we have a spawnable droid ready, and there is not too many droids nearby, lets spawn one!
                if (spawnableDroidName ~= nil and type(spawnableDroidName) == "string") and nearby < getSquadGuardSize(station.force) then
                    local droidPos =  getGuardSpawnLocation(station) -- uses station pos
                    if droidPos ~= -1 then
                        local returnedEntity = station.surface.create_entity({name = spawnableDroidName , position = droidPos, direction = defines.direction.east, force = station.force })
                        if returnedEntity then
                            processSpawnedDroid(returnedEntity, true, station.position)
                        end
                        inv.clear() --clear output slot
                    end
                end
            end
        end
    end
end

function updateSelectionCircles(force)
	global.selection_circles = global.selection_circles or {}
	global.selection_circles[force.name] = global.selection_circles[force.name] or {}

	if not global.selected_squad or global.selected_squad[force.name] then return end

	local squad_id = global.selected_squad[force.name]
	if(squad_id) then
		local squad = global.Squads[force.name][squad_id]
		for _, unit in pairs(squad.unitGroup.members) do
			if unit and unit.valid then
				if not global.selection_circles[force.name][unit.unit_number] then
				   -- make it
				   --unit.surface.create_entity( name = "selection-sticker", position = unit.position , target= unit)
				end
			else
			 --remove the sticker
				for _,e in pairs(unit.surface.find_entities_filtered{type="sticker", area=unit.bounding_box}) do
					e.destroy()
				end

			end

		end

	end

end

function tickForces(forces, tick)
    for _, force in pairs(forces) do
        if force.name ~= "enemy" and force.name ~= "neutral" then
            if tick % ASSEMBLER_UPDATE_TICKRATE == 0 then
                processDroidAssemblers(force)
                processDroidGuardStations(force)
            end
            processDroidAssemblersForTick(force, tick)
            processSquadUpdatesForTick(force.name, tick % 60 + 1)
            if tick % 1200 == 0 then
                log_session_statistics(force)
            end

			updateSelectionCircles(force)

        end
    end
end


CHECK_FOR_NEAREST_ENEMY_TO_ASSEMBLER_EVERY = 3600 -- in ticks

function processDroidAssemblersForTick(force, tick)
    local forceAssemblerRetreatTable = global.AssemblerRetreatTables[force.name]
    if not forceAssemblerRetreatTable then return end -- Checks if the assembler retreat table for that force actually exists
    for assemblerIdx, squads in pairs(forceAssemblerRetreatTable) do
        if assemblerIdx % ASSEMBLER_MERGE_TICKRATE == tick % ASSEMBLER_MERGE_TICKRATE then
            local assembler = global.DroidAssemblers[force.name][assemblerIdx]
            if assembler then
                if (not assembler.valid or not checkRetreatAssemblerForMergeableSquads(assembler, squads)) then
                    -- don't iterate over this assembler again until it is 'recreated'
                    -- by a squad trying to retreat to it
                    forceAssemblerRetreatTable[assemblerIdx] = nil
                end
                if GLOBAL_TARGETING_TYPE == targetingTypes.hybridKeepRadiusClear then
                    if assembler.valid then
                        local ANEtable = global.AssemblerNearestEnemies[force.name][assemblerIdx]
                        if game.tick > ANEtable.lastChecked + CHECK_FOR_NEAREST_ENEMY_TO_ASSEMBLER_EVERY then
                            findAssemblerNearestEnemies(assembler, ANEtable)
                        end
                    else
                        global.AssemblerNearestEnemies[force.name][assemblerIdx] = nil
                    end
                end
            else
                -- clean up assembler that no longer exists
                global.DroidAssemblers[force.name][assemblerIdx] = nil
                forceAssemblerRetreatTable[assemblerIdx] = nil
            end
        end
    end
end

-- ACTUAL HANDLERS START HERE   vvvvv


function handleOnBuiltEntity(event)
    local entity = event.created_entity

    if(entity.name == "droid-assembling-machine") or (entity.name == "marine-barracks") then
        handleDroidAssemblerPlaced(event)
    elseif(entity.name == "droid-guard-station") then
        handleGuardStationPlaced(event)
    elseif(entity.name == "droid-counter") then
        handleBuiltDroidCounter(event)
    elseif(entity.name == "droid-settings") then
        handleBuiltDroidSettings(event)
    elseif entity.name == "loot-chest" then
        handleBuiltLootChest(event)
    elseif entity.name == "rally-beacon" then
        handleBuiltRallyBeacon(event)
    elseif entity.type == "unit" and table.contains(squadCapable, entity.name) then --squadCapable is defined in DroidUnitList.
        processSpawnedDroid(entity, false, nil, true) --this deals with droids spawning
    end
end -- handleOnBuiltEntity


function handleOnRobotBuiltEntity(event)
    local entity = event.created_entity
    if(entity.name == "droid-assembling-machine") or (entity.name == "marine-barracks") then
        handleDroidAssemblerPlaced(event)
    elseif(entity.name == "droid-guard-station") then
        handleGuardStationPlaced(event)
    elseif(entity.name == "droid-counter") then
        handleBuiltDroidCounter(event)
    elseif(entity.name == "droid-settings") then
        handleBuiltDroidSettings(event)
    elseif entity.name == "rally-beacon" then
        handleBuiltRallyBeacon(event)
    elseif entity.name == "loot-chest" then
        handleBuiltLootChest(event)
    end
end -- handleOnRobotBuiltEntity


-- MAIN ENTRY POINT IN-GAME
-- during the on-tick event, lets check if we need to update squad AI, spawn droids from assemblers, or update bot counters, etc
function handleTick(event)
    local forces = game.forces

    tickForces(forces, event.tick)

    if (event.tick % BOT_COUNTERS_UPDATE_TICKRATE == 0) then
        doCounterUpdate()
        checkSettingsModules()
    end



    --once every 3 seconds on the 5th tick, run the rally pole command for each force that has them active.
    if (event.tick % 180 == 5) then
        doRallyBeaconUpdate()
    end
end -- handleTick


function handleForceCreated(event)
    force = event.force
    LOGGER.log(string.format("New force detected... %s",force.name) )
    global.DroidAssemblers = global.DroidAssemblers or {}
    global.DroidAssemblers[force.name] = {}

    global.AssemblerNearestEnemies = global.AssemblerNearestEnemies or {}
    global.AssemblerNearestEnemies[force.name] = {}
	
    global.Squads = global.Squads or {}
    global.Squads[force.name] = {}

    global.uniqueSquadId = global.uniqueSquadId or {}
    global.uniqueSquadId[force.name] = 1

    global.lootChests = global.lootChests or {}
    global.lootChests[force.name] = {}

    global.droidCounters = global.droidCounters or {}
    global.droidCounters[force.name] = {}

    global.droidGuardStations = global.droidGuardStations or {}
    global.droidGuardStations[force.name] = {}

    global.rallyBeacons = global.rallyBeacons or {}
    global.rallyBeacons[force.name] = {}

     --set up the tick tables for this new force
    global.updateTable = global.updateTable or {}
    if not global.updateTable[force.name] then global.updateTable[force.name] = {} end

       --check if the table has the 1st tick in it. if not, then go through and fill the table
    if not global.updateTable[force.name][1] then
        fillTableWithTickEntries(global.updateTable[force.name]) -- make sure it has got the 1-60 tick entries initialized
    end
    global_ensureTablesExist()
    global_fixupTickTablesForForceName(force.name) -- run this at the end just to make sure all other tables I missed are added properly.. mostly for tick and retreat handling

    LOGGER.log("New force handler finished...")
end
