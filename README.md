# exile_fishtrap

Adds a primitive fish trap for passive fish collection.

## How it works

- Craft a fish trap and place it in sea water.
- A valid setup requires sea water above the trap and on all four horizontal sides.
- Every timer cycle (60s), it has a 10% chance to catch 1 small fish.
- Once per cycle, if at least one fish is trapped, there is a 1% chance that one fish rots.
- While operational, there is also a configurable chance each cycle that the trap becomes damaged (`Faulty`).
- Caught and rotten fish are stored internally and shown in infotext (`Contents`).
- The trap continuously re-validates setup conditions while running.

## Contents limit

- Maximum total contents are limited by `max_catched_fishes` (default: `minimal.stack_max_heavy`).
- The limit applies to `fish + rotten fish` together.

## Statuses (shown when pointing at the node)

- `Properly set`: setup is valid and empty, ready to catch fish.
- `Loaded`: setup is valid and it already has fish/rotten contents, still catching.
- `Misplaced`: setup is invalid (land placement, missing water above, or missing side water).
- `Faulty`: damaged trap state (not caused by placement). It stops catching fish.
- `Full`: maximum contents reached. A one-shot 30 minute aging timer starts.
- `Too old and deteriorated`: full timer expired; only rotten fish remains.

## Break behavior

- `Faulty`: drops only 24-36 sticks.
- `Too old and deteriorated`: drops only rotten fish (`exile_fishtrap:rotten_fish`).
- Any non-faulty/non-deteriorated state: drops stored fish and rotten fish.

## Full aging rule

- When the trap becomes `Full`, a single 30 minute timer is armed.
- If the timer completes, trapped contents are replaced by rotten fish only.
- Rotten amount is randomized between 5 and `max_catched_fishes`.

## Recipe

- Craft type: `crafting_spot`
- Output: `exile_fishtrap:fishtrap`
- Ingredients: `tech:stick 36`

## Current limits

- The trap only catches fish from sea-water setup (`nodes_nature:salt_water_source`).
