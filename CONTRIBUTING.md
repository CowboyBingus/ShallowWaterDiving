# Build from source

Use Windows x64, Python 3.10 or newer, Visual Studio C++ Build Tools with an x64 Windows SDK, and the LuaJIT revision recorded in `dependencies.json`.

Fetch and pin the compiler source:

```powershell
git clone https://github.com/LuaJIT/LuaJIT.git tools/src/LuaJIT
git -C tools/src/LuaJIT checkout 24c20c94e7db195b640854619577441f9b4bc6be
```

In an x64 Native Tools Command Prompt, build the game's Windows x64, non-GC64 bytecode compiler:

```bat
cd tools\src\LuaJIT\src
msvcbuild.bat nogc64
```

From this repository's root:

```powershell
python -B scripts/build.py
```

The builder checks the supported installation's EXE and game.dll hashes, compiles the module, runs the Lua regression tests and verifies the installable ZIP. Output is `releases/Shallow-Water-Diving-v3.1.zip`; intermediate files and reports stay in ignored `build/`. Building does not install or launch the game.

Set `HD2_GAME_ROOT` for a nonstandard game installation, or `HD2_LUAJIT` to an existing compatible compiler executable. No parent repository, extracted boot/Wwise resource, research capture or private build tool is required.

The behavioral tests can run independently of the game files:

```powershell
tools/src/LuaJIT/src/luajit.exe tests/test_dive.lua src
tools/src/LuaJIT/src/luajit.exe tests/test_loader.lua src
```

Before publishing, run `python -B scripts/privacy_audit.py --zip releases/Shallow-Water-Diving-v3.1.zip`. Only the scanner's explicit source inventory belongs in Git. Keep game files, memory captures, logs, profiles, dependency checkouts and build output outside source control. The privacy report uses relative paths and file hashes; it does not print matching sensitive text.

The `mods/cowboybingus/shallow_water_dive` resource, runtime singleton and mod-manager GUID are compatibility identifiers. Preserve them when changing the display name. The shared loader is maintained separately.
