data:extend( { {
    type = "unit",
    name = "basic-tank",
    icon = "__base__/graphics/icons/tank.png",
    icon_size = 32,
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
    minable = {mining_time = 0.5, result = "basic-tank"},
    mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg"},
    max_health = 2000,
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(-4, -13),
    immune_to_tree_impacts = true,
    energy_per_hit_point = 0.5,

    pollution_to_join_attack = 0.0,
    distraction_cooldown = 0,
    movement_speed = 0.3,
    vision_distance = 30,
    distance_per_frame = 0.04,

    resistances =
    {
        {
            type = "fire",
            decrease = 15,
            percent = 60
        },
        {
            type = "physical",
            decrease = 15,
            percent = 60
        },
        {
            type = "impact",
            decrease = 50,
            percent = 80
        },
        {
            type = "explosion",
            decrease = 15,
            percent = 70
        },
        {
            type = "acid",
            decrease = 0,
            percent = 50
        }
    },
    collision_box = {{-0.9, -1.3}, {0.9, 1.3}},
    selection_box = {{-0.9, -1.3}, {0.9, 1.3}},
    drawing_box = {{-1.8, -1.8}, {1.8, 1.5}},
    effectivity = 0.9,
    braking_power = "400kW",
    burner =
    {
        fuel_category = "chemical",
        effectivity = 1,
        fuel_inventory_size = 2,
        smoke =
        {
            {
                name = "tank-smoke",
                deviation = {0.25, 0.25},
                frequency = 50,
                position = {0, 1.5},
                starting_frame = 0,
                starting_frame_deviation = 60
            }
        }
    },
    consumption = "600kW",
    terrain_friction_modifier = 0.2,
    friction = 0.002,
    light =
    {
        {
            type = "oriented",
            minimum_darkness = 0.3,
            picture =
            {
                filename = "__core__/graphics/light-cone.png",
                priority = "extra-high",
                flags = { "light" },
                scale = 2,
                width = 200,
                height = 200
            },
            shift = {-0.6, -14},
            size = 2,
            intensity = 0.6,
            color = {r = 0.9, g = 1.0, b = 1.0}
        },
        {
            type = "oriented",
            minimum_darkness = 0.3,
            picture =
            {
                filename = "__core__/graphics/light-cone.png",
                priority = "extra-high",
                flags = { "light" },
                scale = 2,
                width = 200,
                height = 200
            },
            shift = {0.6, -14},
            size = 2,
            intensity = 0.6,
            color = {r = 0.9, g = 1.0, b = 1.0}
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
        sound = make_heavy_shot_sounds(),
        animation =
        {
            filename = "__base__/graphics/entity/player/level1_idle_gun.png",
            priority = "very-low",
            width = 56,
            height = 64,
            --tint = unit_tint,
            direction_count = 8,
            frame_count = 12,
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
                            damage = { amount = 25 , type = "physical"}
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
                priority = "low",
                width = 135,
                height = 106,
                frame_count = 1,
                direction_count = 64,
                shift = util.by_pixel(-4.5, -10),
                animation_speed = 8,
                max_advance = 1,
                stripes =
                {
                    {
                        filename = "__base__/graphics/entity/tank/tank-base-1.png",
                        width_in_frames = 2,
                        height_in_frames = 16
                    },
                    {
                        filename = "__base__/graphics/entity/tank/tank-base-2.png",
                        width_in_frames = 2,
                        height_in_frames = 16
                    },
                    {
                        filename = "__base__/graphics/entity/tank/tank-base-3.png",
                        width_in_frames = 2,
                        height_in_frames = 16
                    },
                    {
                        filename = "__base__/graphics/entity/tank/tank-base-4.png",
                        width_in_frames = 2,
                        height_in_frames = 16
                    }
                },
                hr_version =
                {
                    priority = "low",
                    width = 269,
                    height = 212,
                    frame_count = 1,
                    direction_count = 64,
                    shift = util.by_pixel(-4.75, -10),
                    animation_speed = 8,
                    max_advance = 1,
                    stripes =
                    {
                        {
                            filename = "__base__/graphics/entity/tank/hr-tank-base-1.png",
                            width_in_frames = 2,
                            height_in_frames = 16
                        },
                        {
                            filename = "__base__/graphics/entity/tank/hr-tank-base-2.png",
                            width_in_frames = 2,
                            height_in_frames = 16
                        },
                        {
                            filename = "__base__/graphics/entity/tank/hr-tank-base-3.png",
                            width_in_frames = 2,
                            height_in_frames = 16
                        },
                        {
                            filename = "__base__/graphics/entity/tank/hr-tank-base-4.png",
                            width_in_frames = 2,
                            height_in_frames = 16
                        }
                    },
                    scale = 0.5
                }
            },
            {
                priority = "low",
                width = 104,
                height = 84,
                frame_count = 1,
                apply_runtime_tint = true,
                direction_count = 64,
                shift = util.by_pixel(-5, -21),
                max_advance = 1,
                line_length = 2,
                stripes = util.multiplystripes(2,
                    {
                        {
                            filename = "__base__/graphics/entity/tank/tank-base-mask-1.png",
                            width_in_frames = 1,
                            height_in_frames = 22
                        },
                        {
                            filename = "__base__/graphics/entity/tank/tank-base-mask-2.png",
                            width_in_frames = 1,
                            height_in_frames = 22
                        },
                        {
                            filename = "__base__/graphics/entity/tank/tank-base-mask-3.png",
                            width_in_frames = 1,
                            height_in_frames = 20
                        }
                    }),
                hr_version =
                {
                    priority = "low",
                    width = 207,
                    height = 166,
                    frame_count = 1,
                    apply_runtime_tint = true,
                    direction_count = 64,
                    shift = util.by_pixel(-4.75, -21),
                    max_advance = 1,
                    line_length = 2,
                    stripes = util.multiplystripes(2,
                        {
                            {
                                filename = "__base__/graphics/entity/tank/hr-tank-base-mask-1.png",
                                width_in_frames = 1,
                                height_in_frames = 22
                            },
                            {
                                filename = "__base__/graphics/entity/tank/hr-tank-base-mask-2.png",
                                width_in_frames = 1,
                                height_in_frames = 22
                            },
                            {
                                filename = "__base__/graphics/entity/tank/hr-tank-base-mask-3.png",
                                width_in_frames = 1,
                                height_in_frames = 20
                            }
                        }),
                    scale = 0.5
                }
            },
            {
                priority = "low",
                width = 151,
                height = 98,
                frame_count = 1,
                draw_as_shadow = true,
                direction_count = 64,
                shift = util.by_pixel(17.5, 7),
                max_advance = 1,
                stripes = util.multiplystripes(2,
                    {
                        {
                            filename = "__base__/graphics/entity/tank/tank-base-shadow-1.png",
                            width_in_frames = 1,
                            height_in_frames = 16
                        },
                        {
                            filename = "__base__/graphics/entity/tank/tank-base-shadow-2.png",
                            width_in_frames = 1,
                            height_in_frames = 16
                        },
                        {
                            filename = "__base__/graphics/entity/tank/tank-base-shadow-3.png",
                            width_in_frames = 1,
                            height_in_frames = 16
                        },
                        {
                            filename = "__base__/graphics/entity/tank/tank-base-shadow-4.png",
                            width_in_frames = 1,
                            height_in_frames = 16
                        }
                    }),
                hr_version =
                {
                    priority = "low",
                    width = 301,
                    height = 194,
                    frame_count = 1,
                    draw_as_shadow = true,
                    direction_count = 64,
                    shift = util.by_pixel(17.75, 7),
                    max_advance = 1,
                    stripes = util.multiplystripes(2,
                        {
                            {
                                filename = "__base__/graphics/entity/tank/hr-tank-base-shadow-1.png",
                                width_in_frames = 1,
                                height_in_frames = 16
                            },
                            {
                                filename = "__base__/graphics/entity/tank/hr-tank-base-shadow-2.png",
                                width_in_frames = 1,
                                height_in_frames = 16
                            },
                            {
                                filename = "__base__/graphics/entity/tank/hr-tank-base-shadow-3.png",
                                width_in_frames = 1,
                                height_in_frames = 16
                            },
                            {
                                filename = "__base__/graphics/entity/tank/hr-tank-base-shadow-4.png",
                                width_in_frames = 1,
                                height_in_frames = 16
                            }
                        }),
                    scale = 0.5
                }
            },
            {
                filename = "__base__/graphics/entity/tank/tank-turret.png",
                priority = "low",
                line_length = 8,
                width = 90,
                height = 67,
                frame_count = 1,
                max_advance = 1,
                direction_count = 64,
                shift = util.by_pixel(-5, -34.5),
                animation_speed = 8,
                hr_version =
                {
                    filename = "__base__/graphics/entity/tank/hr-tank-turret.png",
                    priority = "low",
                    line_length = 8,
                    width = 179,
                    height = 132,
                    frame_count = 1,
                    max_advance = 1,
                    direction_count = 64,
                    shift = util.by_pixel(-4.75, -34.5),
                    animation_speed = 8,
                    scale = 0.5
                }
            },
            {
                filename = "__base__/graphics/entity/tank/tank-turret-mask.png",
                priority = "low",
                line_length = 8,
                width = 36,
                height = 33,
                frame_count = 1,
                max_advance = 1,
                apply_runtime_tint = true,
                direction_count = 64,
                shift = util.by_pixel(-5, -35.5),
                hr_version =
                {
                    filename = "__base__/graphics/entity/tank/hr-tank-turret-mask.png",
                    priority = "low",
                    line_length = 8,
                    width = 72,
                    height = 66,
                    frame_count = 1,
                    max_advance = 1,
                    apply_runtime_tint = true,
                    direction_count = 64,
                    shift = util.by_pixel(-5, -35.5),
                    scale = 0.5
                }
            },
            {
                filename = "__base__/graphics/entity/tank/tank-turret-shadow.png",
                priority = "low",
                line_length = 8,
                width = 97,
                height = 67,
                frame_count = 1,
                max_advance = 1,
                draw_as_shadow = true,
                direction_count = 64,
                shift = util.by_pixel(51.5, 6.5),
                hr_version =
                {
                    filename = "__base__/graphics/entity/tank/hr-tank-turret-shadow.png",
                    priority = "low",
                    line_length = 8,
                    width = 193,
                    height = 134,
                    frame_count = 1,
                    max_advance = 1,
                    draw_as_shadow = true,
                    direction_count = 64,
                    shift = util.by_pixel(51.25, 6.5),
                    scale = 0.5
                }
            }
        }
    },
    turret_rotation_speed = 0.35 / 60,
    turret_return_timeout = 300,
    stop_trigger_speed = 0.2,
    sound_no_fuel =
    {
        {
            filename = "__base__/sound/fight/tank-no-fuel-1.ogg",
            volume = 0.6
        }
    },
    stop_trigger =
    {
        {
            type = "play-sound",
            sound =
            {
                {
                    filename = "__base__/sound/car-breaks.ogg",
                    volume = 0.6
                }
            }
        }
    },
    sound_minimum_speed = 0.15;
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
        sound =
        {
            filename = "__base__/sound/fight/tank-engine.ogg",
            volume = 0.6
        },
        activate_sound =
        {
            filename = "__base__/sound/fight/tank-engine-start.ogg",
            volume = 0.6
        },
        deactivate_sound =
        {
            filename = "__base__/sound/fight/tank-engine-stop.ogg",
            volume = 0.6
        },
        match_speed_to_activity = true
    },
    open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.7 },
    close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.7 },
    rotation_speed = 0.0035,
    tank_driving = true,
    weight = 20000,
    inventory_size = 80,
},


} )

data:extend({
    {
        type = "item-subgroup",
        name = "marine-vehicles",
        group = "combat",
        order = "h1"
    },
    {
        type = "item",
        name = "basic-tank",
        icon = "__base__/graphics/icons/tank.png",
        icon_size = 32,
        order = "z[marine]",
        subgroup = "marine-vehicles",
        place_result = "basic-tank",
        stack_size = 25
    },
    {
        type = "recipe",
        name = "basic-tank",
        enabled = false,
        energy_required = 10,
        ingredients =
        {
            {"tank", 1},
        },
        result = "basic-tank"
    },

    {
        type = "recipe",
        name = "basic-tank-deploy",
        icon = "__base__/graphics/icons/tank.png",
        icon_size = 32,
        enabled = false,
        category = "marines",
        subgroup = "robotArmyDummy",
        energy_required = 6,
        main_product = "",
        ingredients =
        {
            {"basic-tank", 1},
        },
        result = "basic-tank"
    },
})