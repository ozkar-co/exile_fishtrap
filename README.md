# exile_fishtrap

Adds a primitive fish trap for passive fish collection.

## How it works

- Craft a fish trap and place it in sea water.
- A valid setup requires sea water above the trap and on all four horizontal sides.
- Every timer cycle (60s), it has a 10% chance to catch 1 small fish.
- Once per cycle, if at least one fish is trapped, there is a 1% chance that one fish rots.
- Caught and rotten fish are stored internally and shown in infotext (`Contents`).
- The trap continuously re-validates setup conditions while running.

## Contents limit

- Maximum total contents are limited by `max_catched_fishes` (default: `minimal.stack_max_heavy`).
- The limit applies to `fish + rotten fish` together.

## Statuses (shown when pointing at the node)

- `Properly set`: setup is valid and the trap can catch fish.
- `Faulty`: setup is invalid (land placement, missing water above, or missing water on one or more sides).
- `Full`: maximum stored fish reached; timer stops.

## Break behavior

- Breaking the trap always drops stored fish (`animals:carcass_fish_small`).
- Breaking the trap always drops stored rotten fish (`exile_fishtrap:rotten_fish`).
- If broken while `Faulty`, it also drops between 24 and 36 sticks.

## Recipe

- Craft type: `crafting_spot`
- Output: `exile_fishtrap:fishtrap`
- Ingredients: `tech:stick 36`

## Current limits

- The trap only catches fish from sea-water setup (`nodes_nature:salt_water_source`).
