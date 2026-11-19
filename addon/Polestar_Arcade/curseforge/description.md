# Freedoom Arcade

**Summary:** Play all 36 levels of Freedoom, a free Doom-engine shooter, in a window inside the game.

---

Freedoom Arcade puts a complete first-person shooter in your UI, for the inn, a long flight path or a queue. It's a full port of the classic Doom engine to Lua. It plays the free, open-source **Freedoom: Phase 1** campaign (4 episodes, 36 levels) with its monsters, weapons, doors, lifts, secrets and sound effects.

Everything is drawn with the game's own UI textures, and nothing outside the addon is needed.

## Features

- **The whole Freedoom: Phase 1 campaign**: 4 episodes and 36 levels, at 5 skill levels.
- **Faithful gameplay**: monster AI, weapons, pickups, doors, lifts, crushers, teleporters, switches and secrets all work as in Doom.
- **Status bar and automap**: the classic status bar with face, ammo, armor and keys. **Tab** shows the automap.
- **Save anywhere**: F6 quick-saves and F9 quick-loads. There are also five named save slots, and saves persist across reloads and logouts.
- **Pause on aggro**: when your character enters combat, the game saves, pauses and closes, so your keyboard is back on your character instantly. Type `/arcade` to return and press **P** to resume. `/arcade aggro` turns this off.
- **Minimap button**: left-click to play. Right-click for quick save, quick load and the save slots.
- **Adjustable**: window size, low-detail mode for slower machines, mouse turning sensitivity and an FPS counter.

## How to play

Type `/arcade` (or `/freedoom` or `/doom`), or click the marine's face on your minimap.

| Action | Keys |
|---|---|
| Move | W / S |
| Strafe | A / D |
| Turn | Arrow keys or Q / E, or hold right mouse and drag |
| Fire | Ctrl or left click |
| Use / open | Space or F |
| Weapons | 1 – 7 |
| Walk (always-run is on) | Shift |
| Automap | Tab (zoom with + / - or the mouse wheel) |
| Quick save / load | F6 / F9 |
| Pause | P |
| Menu | Esc |

While the game window is open it takes over the keyboard, so close it (Esc, then Quit) to chat or move your character.

### Settings

- `/arcade size 1000`: window width in pixels.
- `/arcade detail low`: half-resolution rendering for more FPS.
- `/arcade sens 1.5`: mouse turn speed.
- `/arcade fps`: show the frame rate.
- `/arcade run`: toggle always-run.
- `/arcade sound`: toggle sound effects.
- `/arcade save 1` / `/arcade load 1`: save slots 1–5.
- `/arcade warp e2m1 4`: jump to a level, with an optional skill 1–5.
- `/arcade minimap`: hide or show the minimap button.

## Known limitations

- **No music.** Sound effects only.
- **No distance fade for sounds.** Faraway sounds are cut off instead of fading, because the game can't set per-sound volume.
- **Frame rate:** depends on your machine and how busy the view is. Try `/arcade detail low` if it stutters.

## Credits and licenses

- **Freedoom** game data (levels, graphics, sounds) by the [Freedoom project](https://freedoom.github.io/), BSD license. The license is included as `FREEDOOM-COPYING.txt`.
- **Engine code** derived from id Software's Doom source code, released under the GNU GPL v2. The license is included as `LICENSE.txt`. The full source, asset converter and tests are on GitHub.
- Doom is a trademark of id Software. This project is not affiliated with or endorsed by id Software, Bethesda or Blizzard.
