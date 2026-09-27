![Shallow Water Diving](assets/banner.png)

# Shallow Water Diving

Fixes dives that immediately cancel in shallow water. During the airborne dive, your Helldiver uses the standing water reference; the normal prone reference returns when landing begins, the dive ends, or deeper water is reached. The result is a valid dive from shallow water onto dry land. Ordinary prone input keeps the game's existing water restrictions.

> Release **v3.8.1** for Steam build 25480438 / EXE 1.8.46015.0. Offline checks passed; dives, the shallow-water correction and the depth slider were confirmed in live play. Multiplayer and a visual check of the lower-shin default remain open.

**Maximum dive depth.** With [Mod Options Menu](https://github.com/CowboyBingus/ModOptionsMenu/releases/latest) installed, MODS > SHALLOW WATER DIVING > Max Dive Water Depth sets the deepest water a dive can start in, from 0.20 (about lower-shin depth, the default) up to 1.30, where the Helldiver starts swimming. Press Apply (Tab) to use a new value. Without Mod Options Menu the limit stays 0.20.

## Install

Close the game, import `Shallow-Water-Diving-v3.8.1.zip` and `Bingus-Shared-Loader-v18.zip` into Arsenal or HD2MM, enable both and Purge / Deploy. Under Arsenal's default priority, put the loader last. [Bingus Shared Loader](https://github.com/CowboyBingus/BingusSharedLoader/releases/latest) is a separate required download; installation does not need Consistent Vaulting or other gameplay mods. Formerly **Shallow Water Dive**: the mod-manager ID and loader resource name are unchanged, so replace the old package rather than enabling both.

## What it changes

The mod changes two local runtime floats at most: a temporary drowning-reference offset and, when necessary, a one-time reset of the first prone frame's submersion timer. It changes no executable instructions, shared component settings, dive impulse, stamina cost, teammate data, swimming flag or drowning-enable flag. Measured in recorded play it costs about 0.006 ms per frame aboard the ship and 0.009 ms per frame in missions, without allocating.

`%LOCALAPPDATA%/CowboyBingus/Helldivers2/Logs/ShallowWaterDiving.log` records observations, protected launches, startup resets and short dive endings. It is written when the game starts and shuts down and whenever the mod stops; set `CowboyBingusDiagnostics = true` before initialization for updates during play. See [implementation and verification](docs/TECHNICAL.md).

## Build

`python -B scripts/build.py` builds `releases/Shallow-Water-Diving-v3.8.1.zip`. Building does not install or launch the game. See [build instructions](CONTRIBUTING.md).

[Changes](CHANGELOG.md) · [Release notes](docs/RELEASE_NOTES.md) · [Validation](docs/MIGRATION_VALIDATION.md) · [Privacy review](docs/PRIVACY.md) · [Artwork](assets/ARTWORK.md)

Developed with assistance from GPT-6 Astra and Claude Opus 5.5.
