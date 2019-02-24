
--this file contains the event handlers for each button press/action, and for modifying the GUI based on events happening.

local function handle_squad_command(event_name, squadId, squads, player)

    local squad = squads[squadId]

    if event_name == "squad_follow" then

        Game.print_all( event_name.." "..squadId )

    elseif event_name == "squad_guard" then
        -- orderSquadToWander(squad, position, player.guard)

    elseif event_name == "squad_hunt" then


    elseif event_name == "squad_attack" then
        -- orderSquadToAttack(squad, player.position)
    end

end

--testing GUI events
function on_gui_click(event)
	local player = game.players[event.player_index]
    local event_name = event.element.name
    
	Game.print_all( string.format("on_gui_click %s %s", player.name, event_name ))

    if global.selected_squad ~= nil then
        local squadId = global.selected_squad[event.player_index]
        if squadId ~= nil then

            local squads = global.Squads[player.force.name]

            handle_squad_command(event_name, squadId, squads, player)
        end
    end

end



function on_gui_render(event)

    if game.tick % 20 ~= 0 then
        return
    end

    for i,p in pairs(game.players) do

        local roba = p.gui.left.roba

        if global.selected_squad ~= nil then
            if global.selected_squad[i] ~= nil then
                roba.flow.squadId.caption = tostring(global.selected_squad[i])
            end
        end
    end

end