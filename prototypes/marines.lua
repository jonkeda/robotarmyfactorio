
unit_scale = 1.0
unit_tint =  {r=0.8, g=0.2, b=0.2, a=1}
unitMapColour = {r = .05, g = .70, b = .29}


function make_light_gunshot_sounds(volume)
    return
    {
        {
            filename = "__base__/sound/fight/light-gunshot-1.ogg",
            volume = 0.7
        },
        {
            filename = "__base__/sound/fight/light-gunshot-2.ogg",
            volume = 0.7
        },
        {
            filename = "__base__/sound/fight/light-gunshot-3.ogg",
            volume = 0.7
        }
    }
end
local function make_heavy_shot_sounds(volume)
    return {
        {
            filename = "__base__/sound/fight/heavy-gunshot-1.ogg",
            volume = 0.45
        },
        {
            filename = "__base__/sound/fight/heavy-gunshot-2.ogg",
            volume = 0.45
        },
        {
            filename = "__base__/sound/fight/heavy-gunshot-3.ogg",
            volume = 0.45
        },
        {
            filename = "__base__/sound/fight/heavy-gunshot-4.ogg",
            volume = 0.45
        }
    }
end


local basic_marine = {
    type = "unit",
    name = "basic-marine",
    icon = "__robotarmy__/graphics/icons/marine.png",
    icon_size = 64,
    flags = {"breaths-air", "placeable-player", "player-creation","placeable-enemy", "placeable-off-grid"},
    subgroup="creatures",
    order="e-a-b-d",
    max_health = 65,
    alert_when_damaged = false,
    healing_per_tick = 0.01,
    collision_box = {{-0.8*unit_scale, -0.8*unit_scale}, {0.8*unit_scale, 0.8*unit_scale}},
    selection_box = {{-0.8*unit_scale, -0.8*unit_scale}, {0.8, 0.8*unit_scale}},
    sticker_box = {{-0.8, -0.8}, {0.8, 0.8}},
    vision_distance = 30,
    movement_speed = 0.1,
    minable = {hardness = 0.2, mining_time = 0.5},
    pollution_to_join_attack = 0.0,
    distraction_cooldown = 0,
    distance_per_frame = 0.04,
    friendly_map_color = unitMapColour,
    dying_explosion = "blood-explosion-small",
    tint = unit_tint,
    scale = unit_scale,
    resistances =
    {
        {
            type = "physical",
            decrease = 1,
            percent = 30
        },
        {
            type = "explosion",
            decrease = 10,
            percent = 30
        },
        {
            type = "acid",
            decrease = 1,
            percent = 30
        },
        {
            type = "fire",
            percent = 75
        }
    },
    attack_parameters =
    {
        type = "projectile",
        ammo_category = "bullet",
        shell_particle =
        {
            name = "shell-particle",
            direction_deviation = 0.1,
            speed = 0.1,
            speed_deviation = 0.03,
            center = {0, 0.1},
            creation_distance = -0.5,
            starting_frame_speed = 0.4,
            starting_frame_speed_deviation = 0.1
        },
        cooldown = 20,
        projectile_center = {0, 1},
        projectile_creation_distance = 0.6,
        range = 13,
        sound = make_light_gunshot_sounds(),
        animation =
        {
            filename = "__base__/graphics/entity/player/level1_idle_gun.png",
            priority = "very-low",
            width = 56,
            height = 64,
            --tint = unit_tint,
            direction_count = 8,
            frame_count = 22,
            animation_speed = 0.15,
            axially_symmetrical = true,
            shift = {-0.015625, -0.53125}
        },
        ammo_type =
        {
            category = "bullet",
            action =
            {
                type = "direct",
                action_delivery =
                {
                    type = "instant",
                    source_effects =
                    {
                        type = "create-explosion",
                        entity_name = "explosion-gunshot-small"
                    },
                    target_effects =
                    {
                        {
                            type = "create-entity",
                            entity_name = "explosion-hit"
                        },
                        {
                            type = "damage",
                            damage = { amount = 5 , type = "physical"}
                        }
                    }
                }
            }
        }
    },
    run_animation =
    {
        layers =
        {
            {
                filename = "__base__/graphics/entity/player/level1_running_gun.png",
                width = 56,
                height = 68,
                shift = util.by_pixel(3.0,-20.0),
                frame_count = 22,
                direction_count = 18,
                animation_speed = 0.6,
                hr_version =
                {
                    filename = "__base__/graphics/entity/player/hr-level1_running_gun.png",
                    width = 108,
                    height = 136,
                    shift = util.by_pixel(2.5,-19.5),
                    frame_count = 22,
                    direction_count = 18,
                    animation_speed = 0.6,
                    scale = 0.5
                }
            },
            {
                filename = "__base__/graphics/entity/player/level1_running_gun_mask.png",
                width = 34,
                height = 50,
                shift = util.by_pixel(1.0,-23.0),
                frame_count = 22,
                direction_count = 18,
                animation_speed = 0.6,
                apply_runtime_tint = true,
                tint = unit_tint,
                hr_version =
                {
                    filename = "__base__/graphics/entity/player/hr-level1_running_gun_mask.png",
                    width = 66,
                    height = 100,
                    shift = util.by_pixel(1.0,-23.0),
                    frame_count = 22,
                    direction_count = 18,
                    animation_speed = 0.6,
                    apply_runtime_tint = true,
                    tint = unit_tint,
                    scale = 0.5
                }
            },
            {
                filename = "__base__/graphics/entity/player/level1_running_gun_shadow.png",
                width = 60,
                height = 48,
                shift = util.by_pixel(4.0,1.0),
                frame_count = 22,
                direction_count = 18,
                animation_speed = 0.6,
                draw_as_shadow = true,
                hr_version =
                {
                    filename = "__base__/graphics/entity/player/hr-level1_running_gun_shadow.png",
                    width = 120,
                    height = 96,
                    shift = util.by_pixel(4.5,1.0),
                    frame_count = 22,
                    direction_count = 18,
                    animation_speed = 0.6,
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        }
    }
}



data:extend( { basic_marine } )

data:extend({
    {
        type = "item-subgroup",
        name = "marines",
        group = "combat",
        order = "h"
    },
    {
        type = "item",
        name = "basic-marine",
        icon = "__robotarmy__/graphics/icons/marine.png",
        icon_size = 64,
        flags = {"goes-to-quickbar"},
        order = "z[marine]",
        subgroup = "marines",
        place_result = "basic-marine",
        stack_size = 25
    },
    {
        type = "recipe",
        name = "basic-marine",
        enabled = false,
        energy_required = 10,
        ingredients =
        {
            {"copper-plate", 3},
            {"electronic-circuit", 3},
            {"submachine-gun", 1},
            {"light-armor", 1}
        },
        result = "basic-marine"
    },

    {
        type = "recipe",
        name = "basic-marine-deploy",
        enabled = false,
        category = "droids",
        subgroup = "robotArmyDummy",
        energy_required = 6,
        ingredients =
        {
            {"basic-marine", 1}

        },
        result = "basic-marine"
    },

})

