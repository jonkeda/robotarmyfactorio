data:extend( {
    {
        type = "unit",
        name = "basic-car",
        icon = "__base__/graphics/icons/car.png",
        icon_size = 32,
        flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-flammable"},
        minable = {mining_time = 0.4, result = "basic-car"},
        mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg"},
        max_health = 450,
        corpse = "medium-remnants",
        dying_explosion = "medium-explosion",
        alert_icon_shift = util.by_pixel(0, -13),
        energy_per_hit_point = 1,

        pollution_to_join_attack = 0.0,
        distraction_cooldown = 0,
        movement_speed = 0.3,
        vision_distance = 30,
        distance_per_frame = 0.04,

        crash_trigger = crash_trigger(),
        resistances =
        {
            {
                type = "fire",
                percent = 50
            },
            {
                type = "impact",
                percent = 30,
                decrease = 50
            },
            {
                type = "acid",
                percent = 20
            },
        },
        collision_box = {{-0.7, -1}, {0.7, 1}},
        selection_box = {{-0.7, -1}, {0.7, 1}},
        effectivity = 0.6,
        braking_power = "200kW",

        burner =
        {
            fuel_category = "chemical",
            effectivity = 1,
            fuel_inventory_size = 1,
            smoke =
            {
                {
                    name = "car-smoke",
                    deviation = {0.25, 0.25},
                    frequency = 200,
                    position = {0, 1.5},
                    starting_frame = 0,
                    starting_frame_deviation = 60
                }
            }
        },
        consumption = "150kW",
        friction = 2e-3,
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
                color = {r = 0.92, g = 0.77, b = 0.3}
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
                color = {r = 0.92, g = 0.77, b = 0.3}
            }
        },
        render_layer = "object",
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
                    width = 102,
                    height = 86,
                    frame_count = 1,
                    direction_count = 64,
                    shift = {0, -0.1875},
                    animation_speed = 8,
                    max_advance = 0.2,
                    stripes =
                    {
                        {
                            filename = "__base__/graphics/entity/car/car-1.png",
                            width_in_frames = 2,
                            height_in_frames = 22
                        },
                        {
                            filename = "__base__/graphics/entity/car/car-2.png",
                            width_in_frames = 2,
                            height_in_frames = 22
                        },
                        {
                            filename = "__base__/graphics/entity/car/car-3.png",
                            width_in_frames = 2,
                            height_in_frames = 20
                        }
                    },
                    hr_version =
                    {
                        priority = "low",
                        width = 201,
                        height = 172,
                        frame_count = 1,
                        scale = 0.5,
                        direction_count = 64,
                        shift = util.by_pixel(0+2, -11.5+8.5),
                        animation_speed = 8,
                        max_advance = 0.2,
                        stripes =
                        {
                            {
                                filename = "__base__/graphics/entity/car/hr-car-1.png",
                                width_in_frames = 2,
                                height_in_frames = 11
                            },
                            {
                                filename = "__base__/graphics/entity/car/hr-car-2.png",
                                width_in_frames = 2,
                                height_in_frames = 11
                            },
                            {
                                filename = "__base__/graphics/entity/car/hr-car-3.png",
                                width_in_frames = 2,
                                height_in_frames = 11
                            },
                            {
                                filename = "__base__/graphics/entity/car/hr-car-4.png",
                                width_in_frames = 2,
                                height_in_frames = 11
                            },
                            {
                                filename = "__base__/graphics/entity/car/hr-car-5.png",
                                width_in_frames = 2,
                                height_in_frames = 11
                            },
                            {
                                filename = "__base__/graphics/entity/car/hr-car-6.png",
                                width_in_frames = 2,
                                height_in_frames = 9
                            }
                        }
                    }
                },
                {
                    priority = "low",
                    width = 100,
                    height = 75,
                    frame_count = 1,
                    apply_runtime_tint = true,
                    direction_count = 64,
                    max_advance = 0.2,
                    line_length = 2,
                    shift = {0, -0.171875},
                    stripes = util.multiplystripes(2,
                        {
                            {
                                filename = "__base__/graphics/entity/car/car-mask-1.png",
                                width_in_frames = 1,
                                height_in_frames = 22
                            },
                            {
                                filename = "__base__/graphics/entity/car/car-mask-2.png",
                                width_in_frames = 1,
                                height_in_frames = 22
                            },
                            {
                                filename = "__base__/graphics/entity/car/car-mask-3.png",
                                width_in_frames = 1,
                                height_in_frames = 20
                            }
                        }),
                    hr_version =
                    {
                        priority = "low",
                        width = 199,
                        height = 147,
                        frame_count = 1,
                        apply_runtime_tint = true,
                        scale = 0.5,
                        axially_symmetrical = false,
                        direction_count = 64,
                        max_advance = 0.2,
                        shift = util.by_pixel(0+2, -11+8.5),
                        line_length = 1,
                        stripes = util.multiplystripes(2,
                            {
                                {
                                    filename = "__base__/graphics/entity/car/hr-car-mask-1.png",
                                    width_in_frames = 1,
                                    height_in_frames = 13
                                },
                                {
                                    filename = "__base__/graphics/entity/car/hr-car-mask-2.png",
                                    width_in_frames = 1,
                                    height_in_frames = 13
                                },
                                {
                                    filename = "__base__/graphics/entity/car/hr-car-mask-3.png",
                                    width_in_frames = 1,
                                    height_in_frames = 13
                                },
                                {
                                    filename = "__base__/graphics/entity/car/hr-car-mask-4.png",
                                    width_in_frames = 1,
                                    height_in_frames = 13
                                },
                                {
                                    filename = "__base__/graphics/entity/car/hr-car-mask-5.png",
                                    width_in_frames = 1,
                                    height_in_frames = 12
                                }
                            })
                    }
                },
                {
                    priority = "low",
                    width = 114,
                    height = 76,
                    frame_count = 1,
                    draw_as_shadow = true,
                    direction_count = 64,
                    shift = {0.28125, 0.25},
                    max_advance = 0.2,
                    stripes = util.multiplystripes(2,
                        {
                            {
                                filename = "__base__/graphics/entity/car/car-shadow-1.png",
                                width_in_frames = 1,
                                height_in_frames = 22
                            },
                            {
                                filename = "__base__/graphics/entity/car/car-shadow-2.png",
                                width_in_frames = 1,
                                height_in_frames = 22
                            },
                            {
                                filename = "__base__/graphics/entity/car/car-shadow-3.png",
                                width_in_frames = 1,
                                height_in_frames = 20
                            }
                        })
                },
                {
                    filename = "__base__/graphics/entity/car/car-turret.png",
                    priority = "low",
                    line_length = 8,
                    width = 36,
                    height = 29,
                    frame_count = 1,
                    direction_count = 64,
                    max_advance = 0.2,
                    shift = {0.03125, -0.890625},
                    animation_speed = 8,
                    hr_version =
                    {
                        priority = "low",
                        width = 71,
                        height = 57,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 64,
                        max_advance = 0.2,
                        shift = util.by_pixel(0+2, -33.5+8.5),
                        animation_speed = 8,
                        scale = 0.5,
                        stripes =
                        {
                            {
                                filename = "__base__/graphics/entity/car/hr-car-turret-1.png",
                                width_in_frames = 1,
                                height_in_frames = 32
                            },
                            {
                                filename = "__base__/graphics/entity/car/hr-car-turret-2.png",
                                width_in_frames = 1,
                                height_in_frames = 32
                            }
                        }
                    }
                },
                {
                    filename = "__base__/graphics/entity/car/car-turret-shadow.png",
                    priority = "low",
                    line_length = 8,
                    width = 46,
                    height = 31,
                    frame_count = 1,
                    draw_as_shadow = true,
                    max_advance = 0.2,
                    direction_count = 64,
                    shift = {0.875, 0.359375}
                }
            }
        },
        turret_rotation_speed = 0.35 / 60,
        sound_no_fuel =
        {
            {
                filename = "__base__/sound/fight/car-no-fuel-1.ogg",
                volume = 0.6
            }
        },
        stop_trigger_speed = 0.2,
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
        sound_minimum_speed = 0.2;
        vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
        working_sound =
        {
            sound =
            {
                filename = "__base__/sound/car-engine.ogg",
                volume = 0.6
            },
            activate_sound =
            {
                filename = "__base__/sound/car-engine-start.ogg",
                volume = 0.6
            },
            deactivate_sound =
            {
                filename = "__base__/sound/car-engine-stop.ogg",
                volume = 0.6
            },
            match_speed_to_activity = true
        },
        open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.7 },
        close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.7 },
        rotation_speed = 0.015,
        weight = 700,
        inventory_size = 80
    },

} )

data:extend({

    {
        type = "item",
        name = "basic-car",
        icon = "__base__/graphics/icons/car.png",
        icon_size = 32,
        order = "z[marine]",
        subgroup = "marine-vehicles",
        place_result = "basic-car",
        stack_size = 25
    },
    {
        type = "recipe",
        name = "basic-car",
        enabled = false,
        energy_required = 10,
        ingredients =
        {
            {"car", 1},
        },
        result = "basic-car"
    },

    {
        type = "recipe",
        name = "basic-car-deploy",
        icon = "__base__/graphics/icons/car.png",
        icon_size = 32,
        enabled = false,
        category = "marines",
        subgroup = "robotArmyDummy",
        energy_required = 6,
        main_product = "",
        ingredients =
        {
            {"basic-car", 1},
        },
        result = "basic-car"
    },
})