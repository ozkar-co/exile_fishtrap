# exile_fishtrap

Adds a primitive fish trap for passive fish collection.

## How it works

- Craft a fish trap and place it so the node above it is sea water (`nodes_nature:salt_water_source`).
- If placement is valid, the trap starts its timer and becomes operational.
- Every timer cycle (60s), it has a 10% chance to catch 1 small fish.
- Caught fish are stored internally and shown in infotext (`Contents`).
- When capacity is reached, status changes to `Full` and the timer stops.
- Breaking the trap drops all stored fish (`animals:carcass_fish_small`).

## Recipe

- Craft type: `crafting_spot`
- Output: `exile_fishtrap:fishtrap`
- Ingredients: `tech:stick 36`

## Current limits

- The trap only checks placement conditions when constructed.
- If water conditions change later, it does not auto-disable or re-enable.
- The trap only catches fish from sea-water setup (not freshwater).
