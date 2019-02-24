data:extend({
    {
        type = "technology",
        name = "basic-marines",
        icon = "__colonistsarmy__/graphics/icons/marine.png",
        icon_size = 64,
        prerequisites =
        {
            "military"
        },
        effects =
        {
            {type = "unlock-recipe", recipe = "droid-selection-tool"},
            {type = "unlock-recipe", recipe = "droid-pickup-tool"},
            {type = "unlock-recipe", recipe = "marine-barracks"},
            {type = "unlock-recipe", recipe = "basic-marine"},
            {type = "unlock-recipe", recipe = "basic-marine-deploy"},
        },
        unit =
        {
            time = 30,
            count = 5,
            ingredients =
            {
                {"science-pack-1", 1},
            },
        },
        order = "w",
    },

    {
        type = "technology",
        name = "medium-marines",
        icon = "__colonistsarmy__/graphics/icons/marine.png",
        icon_size = 64,
        prerequisites =
        {
            "basic-marines"
        },
        effects =
        {
            {type = "unlock-recipe", recipe = "medium-marine"},
            {type = "unlock-recipe", recipe = "medium-marine-deploy"},
        },
        unit =
        {
            time = 30,
            count = 5,
            ingredients =
            {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
            },
        },
        order = "w",
    },

    {
        type = "technology",
        name = "heavy-marines",
        icon = "__colonistsarmy__/graphics/icons/marine.png",
        icon_size = 64,
        prerequisites =
        {
            "medium-marines", "power-armor"
        },
        effects =
        {
            {type = "unlock-recipe", recipe = "heavy-marine"},
            {type = "unlock-recipe", recipe = "heavy-marine-deploy"},
        },
        unit =
        {
            time = 30,
            count = 5,
            ingredients =
            {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
                {"military-science-pack", 1},
            },
        },
        order = "w",
    },

--    {
--        type = "technology",
--        name = "basic-droids",
--        icon = "__colonistsarmy__/graphics/icons/droid_smg.png",
--        icon_size = 32,
--        prerequisites =
--        {
--            "military", "basic-marines"
--        },
--        effects =
--        {
--            {type = "unlock-recipe", recipe = "droid-rifle"},
--            {type = "unlock-recipe", recipe = "droid-rifle-deploy"},
--            {type = "unlock-recipe", recipe = "droid-assembling-machine"},
--            {type = "unlock-recipe", recipe = "droid-guard-station"},
--            {type = "unlock-recipe", recipe = "patrol-pole"},
--        },
--        unit =
--        {
--            time = 30,
--            count = 5,
--            ingredients =
--            {
--                {"science-pack-1", 1},
--            },
--        },
--        order = "w1",
--    },
--
--    {
--        type = "technology",
--        name = "medium-droids",
--        icon = "__colonistsarmy__/graphics/icons/droid_flame.png",
--        icon_size = 32,
--        prerequisites =
--        {
--            "military-2", "basic-droids", "steel-processing"
--        },
--        effects =
--        {
--            {type = "unlock-recipe", recipe = "droid-smg-deploy"},
--            {type = "unlock-recipe", recipe = "droid-smg"},
--            {type = "unlock-recipe", recipe = "droid-rocket-deploy"},
--            {type = "unlock-recipe", recipe = "droid-rocket"},
--            {type = "unlock-recipe", recipe = "droid-flame-deploy"},
--            {type = "unlock-recipe", recipe = "droid-flame"},
--        },
--        unit =
--        {
--            time = 30,
--            count = 10,
--            ingredients =
--            {
--                {"science-pack-1", 1},
--                {"science-pack-2", 1},
--
--            },
--        },
--        order = "w2",
--    },
--
--    {
--        type = "technology",
--        name = "heavy-droids",
--        icon = "__colonistsarmy__/graphics/icons/terminator.png",
--        icon_size = 32,
--        prerequisites =
--        {
--            "military-3", "medium-droids", "steel-processing"
--        },
--        effects =
--        {
--            {type = "unlock-recipe", recipe = "terminator-deploy"},
--            {type = "unlock-recipe", recipe = "terminator"},
--        },
--        unit =
--        {
--            time = 30,
--            count = 15,
--            ingredients =
--            {
--                {"science-pack-1", 1},
--                {"science-pack-2", 1},
--                {"military-science-pack", 1},
--            },
--        },
--        order = "w3",
--    },
--
--    {
--        type = "technology",
--        name = "flying-droids",
--        icon = "__colonistsarmy__/graphics/icons/distractor.png",
--        icon_size = 32,
--        prerequisites =
--        {
--            "combat-robotics", "basic-marines"
--        },
--        effects =
--        {
--            {type = "unlock-recipe", recipe = "defender-unit"},
--            {type = "unlock-recipe", recipe = "defender-unit-deploy"},
--            {type = "unlock-recipe", recipe = "distractor-unit"},
--            {type = "unlock-recipe", recipe = "distractor-unit-deploy"},
--            {type = "unlock-recipe", recipe = "destroyer-unit"},
--            {type = "unlock-recipe", recipe = "destroyer-unit-deploy"},
--        },
--        unit =
--        {
--            time = 30,
--            count = 15,
--            ingredients =
--            {
--                {"science-pack-1", 1},
--                {"science-pack-2", 1},
--                {"military-science-pack", 1},
--            },
--        },
--        order = "w3",
--    },


})