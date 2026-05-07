local function fishtrap_get_capacity()
    local capacity = tonumber(max_catched_fishes)
    if not capacity then
        capacity = (minimal and tonumber(minimal.stack_max_heavy)) or 99
    end
    return math.max(1, math.floor(capacity))
end

local function fishtrap_get_contents(meta)
    local fish = meta:get_int("catched_fishes")
    local rotten = meta:get_int("rotten_fishes")
    return fish, rotten, fish + rotten
end

-- Valid setup requires sea water above and on all four horizontal sides.
local function fishtrap_is_properly_set(pos)
    local checks = {
        { x = 0, y = 1, z = 0 },
        { x = 1, y = 0, z = 0 },
        { x = -1, y = 0, z = 0 },
        { x = 0, y = 0, z = 1 },
        { x = 0, y = 0, z = -1 },
    }

    for _, off in ipairs(checks) do
        local n = minetest.get_node_or_nil({ x = pos.x + off.x, y = pos.y + off.y, z = pos.z + off.z })
        if not n or n.name ~= "nodes_nature:salt_water_source" then
            return false
        end
    end

    return true
end

local function fishtrap_set_state(pos, meta, state)
    local catched_fishes, rotten_fishes = fishtrap_get_contents(meta)
    local capacity = fishtrap_get_capacity()

    meta:set_string("fishtrap_state", state)
    minimal.infotext_set_key(
        pos,
        "Contents",
        catched_fishes .. " fish, " .. rotten_fishes .. " rotten / " .. capacity
    )

    if state == "full" then
        minimal.infotext_set_key(pos, "Status", "Full")
        minimal.infotext_set_key(pos, "Note", "Aging started (30 min)")
        return
    end

    if state == "loaded" then
        minimal.infotext_set_key(pos, "Status", "Loaded")
        minimal.infotext_set_key(pos, "Note", "Has fish, still catching")
        return
    end

    if state == "proper" then
        minimal.infotext_set_key(pos, "Status", "Properly set")
        minimal.infotext_set_key(pos, "Note", "Operational")
        return
    end

    if state == "misplaced" then
        minimal.infotext_set_key(pos, "Status", "Misplaced")
        minimal.infotext_set_key(pos, "Note", "Needs sea water above and on all sides")
        return
    end

    if state == "faulty" then
        minimal.infotext_set_key(pos, "Status", "Faulty")
        minimal.infotext_set_key(pos, "Note", "Damaged trap: no longer operational")
        return
    end

    if state == "deteriorated" then
        minimal.infotext_set_key(pos, "Status", "Too old and deteriorated")
        minimal.infotext_set_key(pos, "Note", "Only rotten fish remains")
        return
    end

    minimal.infotext_set_key(pos, "Status", "Unknown")
    minimal.infotext_set_key(pos, "Note", "")
end

local function fishtrap_arm_full_decay_timer(pos, meta)
    if meta:get_int("full_decay_armed") == 1 then
        return
    end
    meta:set_int("full_decay_armed", 1)
    local decay_time = tonumber(fishtrap_full_decay_time) or (30 * 60)
    minetest.get_node_timer(pos):start(decay_time)
end

local function fishtrap_refresh_state(pos, meta)
    local current = meta:get_string("fishtrap_state")
    if current == "faulty" or current == "deteriorated" then
        fishtrap_set_state(pos, meta, current)
        return current
    end

    local _, _, total = fishtrap_get_contents(meta)
    local capacity = fishtrap_get_capacity()

    if total >= capacity then
        fishtrap_set_state(pos, meta, "full")
        fishtrap_arm_full_decay_timer(pos, meta)
        return "full"
    end

    meta:set_int("full_decay_armed", 0)

    if fishtrap_is_properly_set(pos) then
        if total > 0 then
            fishtrap_set_state(pos, meta, "loaded")
            return "loaded"
        end
        fishtrap_set_state(pos, meta, "proper")
        return "proper"
    end

    fishtrap_set_state(pos, meta, "misplaced")
    return "misplaced"
end

minetest.register_node("exile_fishtrap:fishtrap", {
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
        local meta = minetest.get_meta(pos)
        meta:set_int("catched_fishes", 0)
        meta:set_int("rotten_fishes", 0)
        meta:set_int("full_decay_armed", 0)
        meta:set_string("fishtrap_state", "misplaced")
        fishtrap_refresh_state(pos, meta)
        minetest.get_node_timer(pos):start(fishtrap_timer)
    end,

    on_timer = function(pos, elapsed)
        local meta = minetest.get_meta(pos)
        local state = meta:get_string("fishtrap_state")

        if state == "full" then
            local capacity = fishtrap_get_capacity()
            local min_rotten = math.min(5, capacity)
            local rotten_amount = math.random(min_rotten, capacity)
            meta:set_int("catched_fishes", 0)
            meta:set_int("rotten_fishes", rotten_amount)
            meta:set_int("full_decay_armed", 0)
            fishtrap_set_state(pos, meta, "deteriorated")
            return false
        end

        if state == "faulty" or state == "deteriorated" then
            fishtrap_set_state(pos, meta, state)
            return false
        end

        state = fishtrap_refresh_state(pos, meta)

        if state == "full" then
            return false
        end

        if state == "misplaced" then
            return true
        end

        local p_faulty = tonumber(probability_faulty_trap) or 0
        if math.random() < p_faulty then
            fishtrap_set_state(pos, meta, "faulty")
            return false
        end

        local catched_fishes, rotten_fishes, total = fishtrap_get_contents(meta)
        local capacity = fishtrap_get_capacity()

        local p_catch = tonumber(probability_catch_fish) or 0
        if math.random() < p_catch then
            if total < capacity then
                catched_fishes = catched_fishes + 1
                meta:set_int("catched_fishes", catched_fishes)
            end
        end

        -- Once per cycle, one trapped fish can rot.
        local p_rotten = tonumber(probability_rotten_fish) or 0
        if catched_fishes > 0 and math.random() < p_rotten then
            meta:set_int("catched_fishes", catched_fishes - 1)
            meta:set_int("rotten_fishes", rotten_fishes + 1)
        end

        state = fishtrap_refresh_state(pos, meta)

        if state == "full" then
            return false
        end

        return true
    end,

    on_destruct = function(pos)
        local meta = minetest.get_meta(pos)
        local state = meta:get_string("fishtrap_state")
        local catched_fishes = meta:get_int("catched_fishes")
        local rotten_fishes = meta:get_int("rotten_fishes")

        if state == "deteriorated" then
            if rotten_fishes > 0 then
                minetest.add_item(pos, { name = "exile_fishtrap:rotten_fish", count = rotten_fishes })
            end
            return
        end

        if state == "faulty" then
            minetest.add_item(pos, { name = "tech:stick", count = math.random(24, 36) })
            return
        end

        if catched_fishes > 0 then
            minetest.add_item(pos, { name = "animals:carcass_fish_small", count = catched_fishes })
        end
        if rotten_fishes > 0 then
            minetest.add_item(pos, { name = "exile_fishtrap:rotten_fish", count = rotten_fishes })
        end
    end,
})
