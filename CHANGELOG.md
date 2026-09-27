# v3.8

- Adds a Max Dive Water Depth slider under SHALLOW WATER DIVING in [Mod Options Menu](https://github.com/CowboyBingus/ModOptionsMenu) (optional). Dives can start in water from 0.20 (lower shin; the previous fixed limit and still the default) up to 1.30, where the Helldiver starts swimming; deeper water keeps the game's normal behavior. The value applies with the menu's Apply (Tab). Without Mod Options Menu the limit stays 0.20.
- Checks the water record's memory page once per record table instead of before every write. In game a protection query costs about 0.2-0.3 ms; v3.7 made four at every dive start and two at every landing. Now the first assisted dive after loading into a mission makes one, and later dives and landings make none. The check is redone after loading screens, deaths, a changed Helldiver or record table, a failed write, and at shutdown. Writes and page checks reuse their buffers.
- Per-frame checks allocate no memory (the previous build made about 1.9 KB of garbage per frame on the ship) and read less. Outside a mission only one check runs per frame (2 reads). In a mission, between full identity checks (14 reads, every 31st check) each check reads only your dive controller (1 read) to see whether a dive started; a dive frame reads 31 records instead of 46, because records of one object are read together. The game.dll constants are verified on the first dive of a session instead of every dive frame. Measured in recorded play: 0.022 -> 0.006 ms per frame aboard the ship and 0.141 -> 0.009 ms per frame in missions.
- The log is written at startup, at shutdown and when the mod stops, instead of on every status change (several times per dive). Set `CowboyBingusDiagnostics = true` for updates during play.
- Requires Bingus Shared Loader v18, which raises the LuaJIT code cache that the game and every mod share.

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
