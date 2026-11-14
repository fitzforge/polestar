# Polestar Arcade: credits

The game in this folder is **Freedoom Arcade by petllama**
([github.com/petllama/FreedoomArcade](https://github.com/petllama/FreedoomArcade)):
a port of id Software's DOOM engine (linuxdoom-1.10) to plain Lua 5.1 that
plays Freedoom in a window inside the game. petllama said yes to bringing it
into Polestar so players can play it on a flight, and his own code may be
used under the GPL, version 2 or (at your option) any later version. Thank
you, petllama.

The whole game, all 36 Freedoom levels, is his addon
[Freedoom Arcade](https://www.curseforge.com/wow/addons/freedoom-arcade).
When it is installed and enabled, Polestar opens that one and never loads
this folder.

## What is here

- **The engine**, `src/`: Freedoom Arcade v0.3.0 (commit
  [5c157e0](https://github.com/petllama/FreedoomArcade/commit/5c157e065246e52f468a5632fbcc3187e2400e9b)),
  brought in with its history (`git subtree`), so his commits keep his name.
  Copyright (C) 2026 petllama; derived from id Software's linuxdoom-1.10,
  Copyright (C) 1993-1996 id Software, Inc., released under the GNU GPL.
  Licence: `LICENSE` (GPL version 2).
- **Three levels of Freedoom Phase 1** (E1M1 to E1M3, every skill), with
  the textures, flats, sprites and sounds they use, built from
  `freedoom1.wad` 0.13.0 by his `tools/build_assets.py` and cut down by
  `tools/subset.py`. Copyright (C) 2001-2024 Contributors to the Freedoom
  project, BSD licence: `FREEDOOM-COPYING.txt`
  ([freedoom.github.io](https://freedoom.github.io/)).
- **His tools and README**, as he wrote them.

## What Polestar changed

Each change is a commit of its own on top of his, under
`addon/Polestar_Arcade/` in Polestar's repository:

- Runs from its own folder (`Polestar_Arcade`), with its own saved
  variables (`Polestar_ArcadeDB`) and window name, so it never meets the
  standalone addon's; it registers `/doom`, `/arcade` and `/freedoom` only
  when nothing else has; its minimap button starts hidden (Polestar's flight
  timer, its guide window menu and `/polestar arcade` open the game).
- Holds three levels: the menu says it is a 3-level selection of Freedoom
  Phase 1, and the game ends after the third.
- The window's title reads "Freedoom Arcade by petllama".
- `FreedoomArcadeAPI` (version 1: `Open()`, `Close(saveAndPause)`,
  `IsOpen()`, `OnWindow(fn)`), which Polestar uses to put the game away
  before a landing.

## Building it again

```sh
python tools/build_assets.py freedoom1.wad build/FreedoomArcade DOOM/linuxdoom-1.10
python tools/subset.py freedoom1.wad build/FreedoomArcade E1M1,E1M2,E1M3
# then copy build/FreedoomArcade/{data,maps,tex,snd} here
```
