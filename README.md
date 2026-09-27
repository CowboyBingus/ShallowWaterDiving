> Release for Steam build 25480438 / EXE 1.8.46015.0. Offline checks passed; checked in live play.

Depth slider v3.8: with [Mod Options Menu](https://github.com/CowboyBingus/ModOptionsMenu/releases/latest) installed, MODS > SHALLOW WATER DIVING > Max Dive Water Depth sets the deepest water a dive can start in, from 0.20 (lower shin; the default and the previous fixed limit) up to 1.30, where the Helldiver starts swimming. Press Apply (Tab) to use a new value. Without Mod Options Menu the limit stays 0.20. The water record's memory page is now checked once per record table instead of before every write (one protection query for the first assisted dive of a mission, none after), and the per-frame checks allocate no memory and read less: outside a mission one check per frame, and in a mission one read of your dive controller per check between full identity checks.

Water-depth adjustment v3.6: lowers the assistance cutoff from 0.30 to 0.20 game units above the native root, following the reported knee-depth behavior. Dry or deeper water is excluded; crossing the cutoff restores the original settings. Visual lower-shin confirmation remains pending.

Mission repair v3.7: Reads the relocated native dive-timeout constant for the current build, so the mod no longer stops itself in missions. Dives and the shallow-water correction were confirmed live.

![Shallow Water Diving](assets/banner.png)

# Shallow Water Diving

A candidate fix for dives that immediately cancel in shallow water. During the airborne dive, the local avatar uses the standing water reference. The normal prone reference returns when landing begins, the dive ends, or deeper water is reached. The intended result is a valid dive from shallow water onto dry land. Ordinary prone input retains the game's existing water restrictions.

**data-v3 gameplay candidate. Requires Bingus Shared Loader loader-v5 or newer / API 1 or newer.** Supported Steam build: 25480438; EXE 1.8.46015.0. Offline tests pass; in-game timing and behavior still require validation.

[Download data-v3](https://github.com/CowboyBingus/ShallowWaterDiving/releases/tag/data-v3) · [Download the required loader-v5](https://github.com/CowboyBingus/BingusSharedLoader/releases/tag/loader-v5).

[Bingus Shared Loader](https://github.com/CowboyBingus/BingusSharedLoader) is a separate dependency and is not included in this repository. Use a compatible loader build; an earlier loader will not activate this module.

data-v3 accepts newer shared-loader APIs and retains the data-v2 startup recovery: the module waits for native managers and avatar records to initialize instead of permanently stopping on a missing pointer. Replace the gameplay ZIP; an already installed loader-v5 or newer can stay.

Import `Shallow-Water-Diving-v3.8.zip` and the updated `Bingus-Shared-Loader-v18.zip` into Arsenal or HD2MM. With the game closed, enable both and Purge / Deploy. Under Arsenal's default priority, put the loader last. Installation does not require Consistent Vaulting or other gameplay mods.

The package changes two local runtime floats at most: a temporary drowning-reference offset and, when necessary, a one-time reset of the first prone frame's submersion timer. It changes no executable instructions, shared component settings, dive impulse, stamina cost, teammate data, swimming flag or drowning-enable flag.

This candidate must observe the first dive frame before native swimming consumes it. A loaded module is not proof that this scheduling window was reached. `%LOCALAPPDATA%/CowboyBingus/Helldivers2/Logs/ShallowWaterDiving.log` records observations, protected launches, startup resets and short dive endings. It is written when the game starts and shuts down and whenever the mod stops; set `CowboyBingusDiagnostics = true` before initialization for updates during play. See [implementation and verification](docs/TECHNICAL.md).

Formerly **Shallow Water Dive**. The mod-manager ID and loader resource name remain unchanged, so replace the old package rather than enabling both.

Build with `python -B scripts/build.py`. The output is `releases/Shallow-Water-Diving-v3.8.zip`. Building does not install or launch the game. See [build instructions](CONTRIBUTING.md).

[Release notes](docs/RELEASE_NOTES.md) · [Privacy review](docs/PRIVACY.md) · [Artwork](assets/ARTWORK.md)

Developed with assistance from GPT-6 Astra.

Current version: **v3.8**, for game build **25480438**. See [changes](CHANGELOG.md) and [validation coverage](docs/MIGRATION_VALIDATION.md).
