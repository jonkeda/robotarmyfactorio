require("robolib.eventhandlers")

--this file contains the event handlers for each button press/action, and for modifying the GUI based on events happening.

local function handle_squad_command(event_name, squadId, squads, player)

    local squad = squads[squadId]

    if event_name == "squad_follow" then
        -- todo
        Game.print_all( event_name.." "..squadId )

    elseif event_name == "squad_guard" then
        -- orderSquadToWander(squad, player.position, true)

    elseif event_name == "squad_hunt" then


    elseif event_name == "squad_attack" then
        -- orderSquadToAttack(squad, player.position)
    end
-- sendSquadHome(squad)

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

local function setManualSelectionTool(player)
    player.cursor_stack.set_stack({name="manual-selection-tool", count=1 })

    local inv = player.get_inventory(defines.inventory.player_main)
    if inv.remove( {name="manual-selection-tool", count=1 } ) ~= 1 then
        inv = player.get_inventory(defines.inventory.player_quickbar)
        inv.remove( {name="manual-selection-tool", count=1 } )
    end
end

local function onSelectSquad(event)

    local player = game.players[event.player_index]
    local entity = player.selected

    if entity == nil then
        return false
    end

    local squad = findSquadByEntity(entity, event.player_index)

    if squad == nil then
        return false
    end

    selectSquad(squad, player)

    if player.cursor_stack.valid_for_read then
        if player.cursor_stack.name ~= "manual-selection-tool" then
            setManualSelectionTool(player)
        end
    else
        setManualSelectionTool(player)
    end

    return true

end

local function on_squad_left_Click(event)

    if onSelectSquad(event) then
        return
    end

end

--local function on_squad_right_Click(event)
--
--    Game.print_all( "right click" )
--
--end


function guid_event_init()

    script.on_event(defines.events.on_gui_click, on_gui_click)
    script.on_event("squad-click-1", on_squad_left_Click)
    -- script.on_event("squad-click-2", on_squad_right_Click)

end
