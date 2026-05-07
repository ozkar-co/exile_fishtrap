# exile_fishtrap

Adds a primitive fish trap for passive fish collection.

## How it works

- Craft a fish trap and place it in sea water.
- A valid setup requires sea water above the trap and on all four horizontal sides.
- Every timer cycle (60s), it has a 10% chance to catch 1 small fish.
- Once per cycle, if at least one fish is trapped, there is a 1% chance that one fish rots.
- While operational, there is also a configurable chance each cycle that the trap becomes damaged (`Faulty`).
- Caught and rotten fish are stored internally and shown in infotext with a vague hint (`Contents`).
- The trap continuously re-validates setup conditions while running.

## Contents limit

- Maximum total contents are limited by `max_catched_fishes` (default: 24).
- The limit applies to `fish + rotten fish` together.

## Statuses (shown when pointing at the node)

- Internal state `proper`: `Status: Still waters` / `Note: Waiting`
- Internal state `loaded`: `Status: Something stirs within` / `Note: Patience`
- Internal state `full`: `Status: Bulging at the seams` / `Note: Best not to leave it much longer`
- Internal state `misplaced`: `Status: Feels wrong here` / `Note: The currents don't seem right`
- Internal state `faulty`: `Status: Looks worse for wear` / `Note: Probably not worth tending to`
- Internal state `deteriorated`: `Status: Something smells off` / `Note: Whatever was here has seen better days`

## Contents Hint (shown when pointing at the node)

- `Contents: nothing visible` when total stored is `0`
- `Contents: some movement inside` when total stored is below half capacity
- `Contents: quite active` when total stored is at least half capacity

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
