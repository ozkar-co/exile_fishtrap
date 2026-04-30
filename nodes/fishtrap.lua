minetest.register_node("tech:fishtrap", {
    description = "Primitive Fishtrap",
    drawtype = "nodebox",
    tiles = { "tech_wattle.png" },
    node_box = {
        type = "fixed",
        fixed = {
            --big square
            { -0.25, -0.5, -0.4375, 0.1875, -0.4375, -0.375 }, -- main_bottom
            { -0.25, 0.125, -0.4375, 0.1875, 0.1875, -0.375 }, -- main_top
            { -0.375, -0.375, -0.4375, -0.3125, 0.0625, -0.375 }, -- main_right
            { 0.25, -0.4375, -0.4375, 0.3125, 0.0625, -0.375 }, -- main_left
            { -0.3125, 0.0625, -0.4375, -0.25, 0.125, -0.375 }, -- right_top
            { -0.3125, -0.4375, -0.4375, -0.25, -0.375, -0.375 }, -- right_bot
            { 0.1875, 0.0625, -0.4375, 0.25, 0.125, -0.375 }, -- left_top
            { 0.1875, -0.4375, -0.4375, 0.25, -0.375, -0.375 }, -- left_bot

            --net
            { 0.125, 0.0625, -0.5, 0.1875, 0.125, -0.125 }, -- top_a1
            { 0, 0.0625, -0.5, 0.0625, 0.125, -0.125 }, -- top_a2
            { -0.125, 0.0625, -0.5, -0.0625, 0.125, -0.125 }, -- top_a3
            { -0.25, 0.0625, -0.5, -0.1875, 0.125, -0.125 }, -- top_a4

            { 0.0625, 0, -0.125, 0.125, 0.0625, 0.125 }, -- top_b1
            { -0.0625, 0, -0.125, 0, 0.0625, 0.125 }, -- top_b2
            { -0.1875, 0, -0.125, -0.125, 0.0625, 0.125 }, -- top_b3

            { 0, -0.0625, 0.125, 0.0625, 0, 0.4375 }, -- top_c1
            { -0.125, -0.0625, 0.125, -0.0625, 0, 0.4375 }, -- top_c2

            { 0.125, -0.4375, -0.5, 0.1875, -0.375, -0.125 }, -- bot_a1
            { 0, -0.4375, -0.5, 0.0625, -0.375, -0.125 }, -- bot_a2
            { -0.125, -0.4375, -0.5, -0.0625, -0.375, -0.125 }, -- bot_a3
            { -0.25, -0.4375, -0.5, -0.1875, -0.375, -0.125 }, -- bot_a4

            { 0.0625, -0.375, -0.125, 0.125, -0.3125, 0.125 }, -- bot_b1
            { -0.0625, -0.375, -0.125, 0, -0.3125, 0.125 }, -- bot_b2
            { -0.1875, -0.375, -0.125, -0.125, -0.3125, 0.125 }, -- bot_b3

            { 0, -0.3125, 0.125, 0.0625, -0.25, 0.4375 }, -- bot_c1
            { -0.125, -0.3125, 0.125, -0.0625, -0.25, 0.4375 }, -- bot_c2

            { -0.3125, -0.375, -0.5, -0.25, -0.3125, -0.125 }, -- lef_a1
            { -0.3125, -0.25, -0.5, -0.25, -0.1875, -0.125 }, -- lef_a2
            { -0.3125, -0.125, -0.5, -0.25, -0.0625, -0.125 }, -- lef_a3
            { -0.3125, 0, -0.5, -0.25, 0.0625, -0.125 }, -- left_a4

            { -0.25, -0.0625, -0.125, -0.1875, 0, 0.125 }, -- lef_b1
            { -0.25, -0.1875, -0.125, -0.1875, -0.125, 0.125 }, -- lef_b2
            { -0.25, -0.3125, -0.125, -0.1875, -0.25, 0.125 }, -- lef_b3

            { -0.1875, -0.25, 0.125, -0.125, -0.1875, 0.4375 }, -- lef_c1
            { -0.1875, -0.125, 0.125, -0.125, -0.0625, 0.4375 }, -- lef_c2

            { 0.1875, -0.375, -0.5, 0.25, -0.3125, -0.125 }, -- rig_a1
            { 0.1875, -0.25, -0.5, 0.25, -0.1875, -0.125 }, -- rig_a2
            { 0.1875, -0.125, -0.5, 0.25, -0.0625, -0.125 }, -- rig_a3
            { 0.1875, 0, -0.5, 0.25, 0.0625, -0.125 }, -- rig_a4

            { 0.125, -0.0625, -0.125, 0.1875, 0, 0.125 }, -- rib_b1
            { 0.125, -0.1875, -0.125, 0.1875, -0.125, 0.125 }, -- rig_b2
            { 0.125, -0.3125, -0.125, 0.1875, -0.25, 0.125 }, -- rig_b3

            { 0.0625, -0.25, 0.125, 0.125, -0.1875, 0.4375 }, -- rig_c1
            { 0.0625, -0.125, 0.125, 0.125, -0.0625, 0.4375 }, -- rig_c2

            -- small square
            { -0.0625, -0.125, 0.3125, 0.0625, -0.0625, 0.375 }, -- bak_top
            { -0.125, -0.25, 0.3125, 0, -0.1875, 0.375 }, -- bak_bot
            { 0, -0.25, 0.3125, 0.0625, -0.125, 0.375 }, -- bal_rig
            { -0.125, -0.1875, 0.3125, -0.0625, -0.0625, 0.375 }, -- bak_lef
        },
    },
    selection_box = {
        type = "fixed",
        fixed = { -0.375, -0.4375, -0.4375, 0.3125, 0.1875, 0.4375 },
    },
    paramtype = "light",
    paramtype2 = "facedir",
    stack_max = minimal.stack_max_bulky,
    groups = { snappy = 3, falling_node = 1 },
    sounds = nodes_nature.node_sound_leaves_defaults(),
    drowning = 1,

    on_construct = function(pos)
        -- Get the metadata of the node
        local meta = minetest.get_meta(pos)

        -- Get the node and the node above that
        local node_above = minetest.get_node({ x = pos.x, y = pos.y + 1, z = pos.z })

        meta:set_int("catched_fishes", 0)
        minimal.infotext_set_key(pos, "Contents", "0 fish")
        minimal.infotext_set_key(pos, "Status", "Disabled")

        -- Only start the timer if placed in a block of water under water
        if node_above.name == "nodes_nature:salt_water_source" then
            minetest.get_node_timer(pos):start(fishtrap_timer)
            minimal.infotext_set_key(pos, "Status", "Operational")
        else
            minimal.infotext_set_key(pos, "Note", "Put on sea to start catching fish")
        end
    end,

    on_timer = function(pos, elapsed)
        local meta = minetest.get_meta(pos)
        local catched_fishes = meta:get_int("catched_fishes")

        if math.random() < probability_catch_fish then
            catched_fishes = catched_fishes + 1

            if catched_fishes > max_catched_fishes then
                catched_fishes = max_catched_fishes
            end

            meta:set_int("catched_fishes", catched_fishes)
            minimal.infotext_set_key(pos, "Contents", catched_fishes .. " fish")

            -- Stop the timer if catched fish reaches the max
            if catched_fishes >= max_catched_fishes then
                minimal.infotext_set_key(pos, "Status", "Full")
                return false
            end
        end

        -- Continue the timer until a fish is caught
        return true
    end,

    on_destruct = function(pos)
        -- drops its contents when broken
        local meta = minetest.get_meta(pos)
        local catched_fishes = meta:get_int("catched_fishes")
        if catched_fishes > 0 then
            minetest.add_item(pos, { name = "animals:carcass_fish_small", count = catched_fishes })
        end
    end,
})
