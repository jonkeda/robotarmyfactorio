require("mod-gui")

function gui_init(player)

--	if mod_gui.get_button_flow(player)["but-test1"] then
--		return
--	end

--	mod_gui.get_button_flow(player).add
--	{
--		type = "sprite-button",
--		name = "but-test1",
--		sprite = "sprite_test1",
--		style = mod_gui.button_style
--	}
--	mod_gui.get_button_flow(player).add
--	{
--		type = "sprite-button",
--		name = "but-test2",
--		sprite = "sprite_test2",
--		style = mod_gui.button_style
--	}

	local root = nil
	if player.gui.left.roba then
		root = player.gui.left.roba
		player.gui.left.roba.clear()
	else
		root = player.gui.left.add{
			type = "frame",
			name = "roba",
			direction = "vertical", --horizontal
			column_count = 1
		}
		root.style.top_padding = 4
		root.style.bottom_padding = 4
		--root.style.minimal_width = 230
	end

	local flow = root.add{
		type = "table",
		name = "flow",
		column_count = 16
	}

	-- squad id
	flow.add{
		type = "sprite",
		name = "lblSquads",
		tooltip = {"property.selectedsquad"},
		sprite = "squad-sprite"
	}

	flow.add{
		type = "label",
		name = "squadId",
		tooltip = {"property.squadid"},
		caption = "0"
	}

	flow.add{
		type = "sprite-button",
		name = "squad_follow",
		tooltip = {"property.squad_follow"},
		sprite = "squad-follow",
		style = mod_gui.button_style
	}

	flow.add{
		type = "sprite-button",
		name = "squad_guard",
		tooltip = {"property.squad_guard"},
		sprite = "squad-patrol",
		style = mod_gui.button_style
	}

	flow.add{
		type = "sprite-button",
		name = "squad_hunt",
		tooltip = {"property.squad_hunt"},
		sprite = "squad-attack",
		style = mod_gui.button_style
	}

end
