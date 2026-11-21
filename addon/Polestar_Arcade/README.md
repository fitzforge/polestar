# Freedoom Arcade

![Freedoom Arcade](curseforge/logo.png)

A World of Warcraft addon that plays Freedoom, a free Doom-engine game, in a window inside the game.

The engine is a port of id Software's linuxdoom-1.10 to plain Lua 5.1. It uses floats instead of fixed point, and a renderer that draws with ordinary WoW textures:

- **Walls and sky** are one texture strip per screen column.
- **Floors and ceilings** are one strip per horizontal span, with texture coordinates interpolated along the span.
- **Sprites and masked mid-textures** are quads clipped into column runs, each on its own frame level so they sort back to front.

It ships with [Freedoom](https://freedoom.github.io/) Phase 1 (all 36 maps).

## How it was made

This project was built with AI. The code was written by Claude (Opus 5.5) via a harness.

## Installing

1. Download `FreedoomArcade-v0.3.0.zip` from the [latest release](https://github.com/petllama/FreedoomArcade/releases/latest).
2. Unzip it and copy the five folders (`FreedoomArcade`, `FreedoomArcade_E1` .. `FreedoomArcade_E4`) into `World of Warcraft/<flavor>/Interface/AddOns/`.
3. Enable Freedoom Arcade in the AddOns list, log in, and click the Doom face on your minimap (or type `/arcade`).

Everything the game needs is in the zip. The release also has `freedoom1.wad`, the original Freedoom data it was built from, if you want to rebuild the assets yourself.

## Building

Requirements: Python 3, `ffmpeg` (for sound conversion), and a copy of the linuxdoom source (for the state/thing tables).

```sh
# 1. get Freedoom and id's source
curl -LO https://github.com/freedoom/freedoom/releases/download/v0.13.0/freedoom-0.13.0.zip
unzip freedoom-0.13.0.zip -d wad
git clone https://github.com/id-Software/DOOM.git ref/DOOM

# 2. convert the WAD into textures (TGA), sounds (OGG), maps and info tables
python tools/build_assets.py wad/freedoom-0.13.0/freedoom1.wad build/FreedoomArcade ref/DOOM/linuxdoom-1.10

# 3. copy the Lua sources in
sh tools/deploy.sh
```

Then copy `build/FreedoomArcade` and `build/FreedoomArcade_E1` .. `FreedoomArcade_E4` into `World of Warcraft/<flavor>/Interface/AddOns/`.

The `FreedoomArcade_E*` addons hold the map data and load on demand when you enter an episode.

## Playing

Type `/arcade` (or `/freedoom`, `/arcade`) in game.

| Action | Keys |
|---|---|
| Move | W / S |
| Strafe | A / D |
| Turn | arrows or Q / E, or hold right mouse and drag |
| Fire | Ctrl or left click |
| Use | Space or F |
| Weapons | 1 – 7 |
| Walk (always-run is on) | Shift |
| Pause | P |
| Automap | Tab or M (zoom with + / - or mouse wheel) |
| Quick save / load | F6 / F9 |
| Menu | Esc |

Slash commands:

- `/arcade size <400-1600>` sets the window width.
- `/arcade detail high|low` switches between 320 and 160 render columns.
- `/arcade sens <n>` sets mouse turn speed.
- `/arcade run` toggles always-run.
- `/arcade sound` toggles sound effects.
- `/arcade fps` shows an FPS counter.
- `/arcade warp e1m5 [skill]` jumps to a map.
- `/arcade save` / `/arcade load` quick save and load.
- `/arcade save <1-5>` / `/arcade load <1-5>` use five named save slots.
- Minimap button: left-click opens or closes the game. Right-click opens a menu with quick save/load and the five save slots, each showing its map and time. Drag the button to move it.
- `/arcade minimap` shows or hides the minimap button.
- `/arcade aggro` toggles pause-on-aggro (on by default). When your character enters combat, the game quick-saves, pauses and closes so the keyboard goes back to WoW. `/arcade` brings it back, and P resumes.

## Releasing

Releases are automated by `.github/workflows/release.yml`.

1. Bump `## Version` in `src/FreedoomArcade.toc`.
2. Add a matching `## x.y.z` section to `CHANGELOG.md`.
3. Push a tag `vx.y.z`.

The workflow then:

1. Downloads Freedoom and id's source.
2. Builds the assets.
3. Runs the tests.
4. Creates the GitHub release.
5. Uploads the zip to CurseForge.

One-time CurseForge setup:

1. Create the project on CurseForge.
2. Add the repository **variable** `CF_PROJECT_ID`, the numeric id from the project page.
3. Add the repository **secret** `CF_API_TOKEN`, from https://authors.curseforge.com/#/settings/api-tokens.
4. Optionally add the variable `CF_GAME_VERSIONS`, e.g. `12.1.0,1.15.7`, to override the versions read from the toc.

Without the token, the CurseForge upload step is skipped.

`curseforge/` holds the project description and the art:

- `logo_square.png` / `avatar.png` (400x400 project avatar)
- `logo.png` (1200x400 banner)

Both images are made by `tools/make_logo.py` from Freedoom's logo, big font and face.

## Testing offline

`tools/mock_wow.lua` is a small mock of the WoW UI API plus a software rasterizer for the textures it creates. It lets the real addon code run and take screenshots under LuaJIT:

```sh
export WOWDOOM_ADDONS="$(pwd)/build"
luajit tools/test_specials.lua   # every map, doors, lifts, exits, death/respawn
luajit tools/test_game.lua       # scripted play with screenshots in shots/
luajit tools/bench.lua 1 high    # per-frame cost
```

## Not implemented

- Music
- Distance-based sound volume. Distant sounds are culled instead, because WoW can't set per-sound volume.

## License

Freedoom Arcade was formerly called WoWDoom. The game code is derived from id Software's Doom source and is licensed under the GNU GPL v2 (see `LICENSE`). Freedoom assets are BSD-licensed. The Freedoom WAD and the generated assets are not stored in this repo.
