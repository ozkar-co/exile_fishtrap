-- time range to catch fish

fishtrap_timer = 60

-- probability to catch a fish
probability_catch_fish = 0.1

-- probability (per cycle) that one trapped fish rots
probability_rotten_fish = 0.01

-- probability (per cycle) that an operational trap becomes damaged
probability_faulty_trap = 0.01

-- when full, trap gets a one-shot aging timer (seconds)
fishtrap_full_decay_time = 30 * 60

-- max fishes in the trap
max_catched_fishes = minimal.stack_max_heavy
