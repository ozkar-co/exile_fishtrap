local rotten_fish_box = {
    { -0.125, -0.5, -0.1875, 0.125, -0.4375, 0.1875 },
    { -0.0625, -0.4375, -0.1875, 0.0625, -0.375, 0.1875 },
    { -0.0625, -0.5, -0.3125, 0.0625, -0.4375, -0.1875 },
    { -0.0625, -0.5, 0.1875, 0.0625, -0.4375, 0.375 },
    { 0.125, -0.5, -0.125, 0.1875, -0.4375, 0.125 },
    { -0.1875, -0.5, -0.125, -0.125, -0.4375, 0.125 },
}

minetest.register_node("exile_fishtrap:rotten_fish", {
    description = "Rotten Fish",
    tiles = { "exile_fishtrap_rotten_fish.png" },
    drawtype = "nodebox",
    paramtype = "light",
    node_box = {
        type = "fixed",
        fixed = rotten_fish_box,
    },
    stack_max = minimal.stack_max_medium,
    groups = { snappy = 3, dig_immediate = 3, falling_node = 1, temp_pass = 1, compost = 1 },
    sounds = nodes_nature.node_sound_defaults(),
})