# {{title}}

A community addon for Polestar, the leveling guide addon for World of
Warcraft: Forever, by {{author}}. It is a separate addon with {{author}}'s own
guides; it is not made by Polestar.

## For players

1. Install Polestar first.
2. Download `{{folder}}-<version>.zip` from this project's releases and unzip
   it into the game's `Interface/AddOns/` folder, next to `Polestar`.
3. Restart the game. Its guides appear in Polestar's guide menu
   (`/polestar guides`) under Community guides; Options > Community guides
   (`/polestar packs`) turns the addon on or off.

Credits: {{author}}. Licence: {{license}} (see `LICENSE`).

This addon is supported by {{author}}, not by Polestar: report its problems
here.

## For authors

This addon is built from a pack: a folder with a `pack.json` and `.guide`
files. This pack was started with `polestar new`, which needs an empty folder: for
your next pack, run `polestar new` first and `git init` in the folder after
(a folder holding only `.git` counts as not empty).

You need Node 24 or newer, Lua 5.1 and a Polestar clone with `npm link`
run in it (`polestar doctor` checks all of it). From this folder:

- `polestar find <text>`: look up quest, NPC, object, item and guide ids, and
  the inn and flight point names `sethome`, `hearth`, `getfp` and `fly` take.
- `polestar lint`: check the guides (in VS Code: the default build task).
- `polestar playtest`: play every guide to the end in the real addon.
- `polestar dev`: copy the pack into the game's AddOns folder while you work.
- `polestar pack`: write the release zip to `dist/`.

Polestar's source describes the guide format on one page in
docs/GUIDE_CHEATSHEET.md, in full in docs/GUIDE_FORMAT.md, and packs in
docs/GUIDE_PACKS.md (what a community addon is, what the tools require, what is asked
of authors) and docs/PACKS.md (the full handbook). Start from
`guides/example.guide`.
