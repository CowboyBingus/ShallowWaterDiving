# v3.7

- Fixes the mod stopping itself in missions on Steam build 25480438 ("Native dive timeout changed"): the dive-timeout constant moved with the two stance constants and is now read at its new location, with the old one as a fallback. If it is ever missing, the log names where 2.0 was found nearby.
- Outside a dive, reads only the player identity and dive records; the water, stance, movement and settings records are still read and validated on every dive frame before any write.
- Decodes fields without copying the rest of each buffer and reuses one read buffer. Dives and the shallow-water correction were confirmed live.

# v3.6

- Update the two relocated shallow-water constants for Steam build 25480438.
- Preserve the lower-shin water limit and normal deeper-water behavior.
- Offline builds and package checks pass; live gameplay validation remains pending.

# v3.5

- Update compatibility for game build 25327279.
- Restore dive assistance in shallow water.
- Limit assistance to lower-shin water; deeper water keeps normal game behavior.

# v3.1

- Enables shallow-water dive corrections on defense and other supported mission types.
- Moves logs to `%LOCALAPPDATA%\CowboyBingus\Helldivers2\Logs`.
- Requires Bingus Shared Loader v14 for the shared log folder.
