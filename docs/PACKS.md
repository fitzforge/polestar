# Writing community addons

A community addon is your own guides for Polestar, published as your own
addon. Players install it next to Polestar, and its guides appear in
Polestar's guide menu under **Community guides**, with your name on them.
You write guides as plain text (`.guide` files,
[GUIDE_FORMAT.md](GUIDE_FORMAT.md)), and Polestar's tools check them, play
them to the end without the game, and build the addon. A community addon is
built from a pack: a folder with a `pack.json` and `.guide` files.

> [!TIP]
> New here? [GUIDE_PACKS.md](GUIDE_PACKS.md) is the short version: what a
> community addon is, the steps from `new` to publishing, and what we ask of
> authors. This page is the full handbook; the exact files the tools write
> are in [PACK_FORMAT.md](PACK_FORMAT.md).

| On this page | |
|---|---|
| **Get going** | [Setup](#setup) · [A first pack in 15 minutes](#a-first-pack-in-15-minutes) |
| **Write guides** | [By playing](#by-playing) · [From the simulator](#from-the-simulator) · [By hand](#by-hand) · [With an AI assistant](#with-an-ai-assistant) |
| **Ship it** | [Testing](#testing) · [Publishing](#publishing) · [One guide as an import string](#one-guide-as-an-import-string) · [Updating](#updating) |
| **Fix a problem** | [In game: statuses and problems](#in-game-statuses-and-problems) · [Import strings that are turned down](#import-strings-that-are-turned-down) · [Lint messages](#lint-messages) |
| **Reference** | [Where things are](#where-things-are) |

## Setup

A pack lives in its own folder (usually its own git repository). The tools
come from a clone of Polestar:

```sh
git clone <Polestar's repository URL> polestar
cd polestar
npm link                 # puts `polestar` on your PATH; the tools have no npm dependencies
polestar doctor          # checks everything below and prints the fix for each
cd ..                    # back out: your pack gets its own folder beside the clone, not inside it
```

Without `npm link`, run `node <polestar clone>/tools/polestar.js <command>`
wherever this page says `polestar <command>`.

You need:

| | Windows | macOS | Linux |
|---|---|---|---|
| Node 24 or newer (every command) | `winget install OpenJS.NodeJS.LTS`, then a new terminal | `brew install node` | your package manager, or `nvm install 24` |
| Lua 5.1 or LuaJIT (`play`, `playtest`, `record import`) | `winget install DEVCOM.LuaJIT`, then a new terminal | `brew install luajit` | `sudo apt install lua5.1` (Debian, Ubuntu), `sudo pacman -S lua51` (Arch), `sudo dnf install luajit` (Fedora; or `sudo dnf install compat-lua`, then `export LUA=lua-5.1`) |
| The reference data, `data/forever/` in the clone (every guide command) | `node tools/polestar.js data build` in the clone | same | same |
| The game's AddOns folder (`install`, `dev`) | found automatically, or set `WOW_FOREVER_ADDONS`, or pass `--dest` | same | same (Wine, Proton, Lutris, Bottles and Faugus prefixes are searched) |

`$LUA` picks a Lua interpreter when you have several. `polestar doctor` exits
with code 1 when Node or the reference data is missing, since every command
needs them. Without the reference data (the folder missing, or holding none of
its core files) `lint`, `compile`, `dev`, `install`, `pack` and `play` stop
before reading any guide, with one error naming the folder, and exit with
code 1; `dev` then does not start watching. `playtest` stops too, with an
error naming the missing files. A folder missing only some of the core files
is a warning naming them, and the guides are checked.

The reference data is what fills in quest titles, givers and coordinates.
`data build` assembles it from the sources listed in Polestar's
[THIRD_PARTY.md](../THIRD_PARTY.md) (`polestar help data` names them); until
Polestar ships the open data, it reads some of them from addons installed
with your game.

**Codespaces.** A pack made by `polestar new` from a Polestar clone whose
origin is an http(s) or SSH URL carries `.devcontainer/devcontainer.json`: open the pack's
repository in GitHub Codespaces and you get Node 24, Lua 5.1, the tools
linked and the reference data built, with nothing to install. (`install`
and `dev` need the game, so in a codespace use `play` and `playtest`
instead.)

## A first pack in 15 minutes

```sh
# in the folder that holds your Polestar clone, not inside the clone
polestar new joes-routes          # asks for the id, title, author and licence
cd joes-routes
polestar dev --play               # lint and build on every save, with the playground
```

1. **`polestar new [dir]`** asks for the pack id, title, author and licence
   (or takes `--id`, `--title`, `--author`, `--license`; `--yes` accepts the
   defaults: the id from the folder name, the title from the id, the author
   from `git config user.name`, CC-BY-4.0). Without a terminal to ask in (a
   script, a CI job) it writes nothing and exits 1 unless all four or `--yes`
   are given. It refuses a folder that is not empty, and a folder holding
   only `.git` counts as not empty: run `new` first, then `git init` in the
   folder. It writes:
   - `pack.json` (the manifest, PACK_FORMAT.md) and `guides/example.guide`, a
     short guide that lints clean, plays to the end and hands over to one of
     Polestar's guides (it has no `author` line: a guide without one takes
     the pack's author);
   - `README.md` for players (install, credits) and for you (build, test);
   - `LICENSE` for the licence you chose: for MIT the full text with your
     name and the year; for GPL-3.0-only your pack's title, `Copyright (c)
     <year> <author>` and the short GPL notice, then the licence text; for
     CC-BY-4.0 and CC0-1.0 the name and official address; for any other
     licence a one-line reminder to paste its full text;
   - `.gitignore` (`dist/`, `drafts/`);
   - `.vscode/tasks.json`: lint as the default build task, so VS Code
     underlines the lines with problems, and playtest as a test task;
   - `AGENTS.md`, and `CLAUDE.md` pointing to it: how a coding agent works in
     the pack (below, "With an AI assistant"), and the polestar-guide-pack
     skill in `.agents/skills/` and `.claude/skills/`;
   - `.github/workflows/pack.yml` (lint and playtest on every push and pull
     request, with read-only access to your repository; on a version tag the
     same job builds the zip, and a second job, run only once that passes,
     attaches it to a GitHub release: the only job allowed to write) and
     `.devcontainer/` (Codespaces). Both clone Polestar and build its
     reference data with `polestar data build --no-web-xp --no-wowhead`: that
     skips the quest lookups on community web sites (Forever XP databases)
     and the Wowhead cache (a fresh clone has none), but the build still
     clones pfQuest and downloads the client tables from wago.tools. So they
     need the address of Polestar's public repository. `new` reads it from
     your clone's `git remote get-url origin` and writes it as https, quoted: an
     SSH address (`git@host:owner/repo.git`, `ssh://`) or an `http://` one
     becomes its https form, and any user name, password, query (`?…`) or
     fragment (`#…`) is dropped. With no origin, or one that is neither
     http(s) nor SSH (a local path, say), it leaves both out and says why.
2. **`polestar dev`** watches `pack.json` and the `.guide` files. On every
   save it lints (printing the problems) and, without errors, builds the pack
   into the game's AddOns folder (`--dest <dir>` picks another; `--no-game`
   skips it). With `--play` it also starts the playground and reloads it on
   every build. In AddOns it never writes over a folder it did not build
   for this pack (the folder rule, below).
3. **`polestar play`** (or `dev --play`) runs the real Polestar against a
   simulated world, with your pack loaded after our guides, and prints the
   address to open in your browser: open the guide menu, find your pack under "Community guides", load a guide
   and play it with the side panel. Options > Community guides shows your pack's row
   and any problems.
4. **`polestar install`** inside the pack (or `polestar install <dir>`
   from anywhere) builds it and installs it into the game, when you are not
   running `dev`.
5. **In game:** the first time, restart the game so the client sees the new
   addon; after that, `/reload` shows every change. Open the guide menu
   (`/polestar guides`) and pick your guide under "Community guides".

## Four ways to write guides

[GUIDE_FORMAT.md](GUIDE_FORMAT.md) is the language, with a cookbook of
examples; [GUIDE_CHEATSHEET.md](GUIDE_CHEATSHEET.md) puts every line of it on
one page. Whatever way you start, finish with lint and playtest (below).

### By playing

Record your own play and turn it into a draft:

```sh
polestar install --recorder        # in the Polestar clone (not the pack): installs Polestar_Recorder with Polestar
# in game: /psrec on, play the route, then log out
polestar record import             # copies the sessions out of SavedVariables
polestar record list
polestar record draft <session>    # writes drafts/<faction>-<race>-<date>-<time>.guide
```

Inside a pack, `record draft` writes into the pack's `drafts/` folder with a
guide id under `<pack id>/draft/`. A draft carries `coords live` (your
recorded positions are in the client's own map frame). Edit it, give it a
proper id, move it out of `drafts/` into your guides, and lint it. Drafts are
compiled only with `--include-drafts`.

### From the simulator

`polestar sim export --result <file> --out <dir>` turns a simulator route
into skeleton guides, one per zone visit, with a `visits.json`. Their ids
are `sim/<faction>/<race>/NN-zone`, which lint refuses in a pack: rename each
under `<pack id>/` and update the `next` lines that chain them. The best
routes Polestar's simulator has found ship with Polestar once its open data
lands; until then a result exists only where you ran the simulator yourself
(docs/SIMULATION.md).

### By hand

Look up every id instead of guessing it:

```sh
polestar find "westfall stew"
#   accept 36  # Westfall Stew, level 10: Verna Furlbrow, Westfall 59.9,19.4
#   turnin 36  # Westfall Stew: Salma Saldean, Westfall 56.4,30.5
polestar find "kobold camp cleanup"
#   accept 7  # Kobold Camp Cleanup, level 2: Marshal McBride, Elwynn Forest 48.9,41.6
#   turnin 7  # Kobold Camp Cleanup: Marshal McBride, Elwynn Forest 48.9,41.6
#   # 7.1 = kill Kobold Vermin x10
polestar find Hogger --kind npc --faction Alliance
polestar find westfall --kind guide --race Human   # our guides a Human can follow, for `next`
polestar find 36 --json                 # ids, levels, zones, coordinates as JSON
polestar find --kind inn                # every inn, as `sethome` and `hearth` name it
#   sethome "Goldshire"  # Innkeeper Farley (npc 295), Elwynn Forest 43.8,65.8
polestar find --kind flight --faction Alliance   # every flight point, as `getfp` and `fly` name it
#   getfp "Sentinel Hill"  # Sentinel Hill, Westfall, Alliance: Thor (npc 523), Westfall 56.6,52.7
```

`find` searches quests, NPCs, objects, items, inns, flight points and
Polestar's guides; a number matches ids exactly. Each result is a guide line
ready to paste. A quest also prints its turn-in line and its objectives, `7.1
= kill Kobold Vermin x10`: write `quest 7.1` on the goal that works it (`kill
6 x10 quest 7.1`). A guide prints its level range, who it is for
(`Alliance`, `Dwarf/Gnome only`, `Alliance Paladin only`) and its own `next`.
An inn prints the location `sethome` and `hearth` take (and the other names
the game may report for it), a flight point the town `getfp` and `fly` take
(the flight map picks the node by it; where the landing area is named
differently, a `fly` goal checks off only through a later goal of its step);
a text also matches their zone, and `--kind inn` or `--kind flight` without
a text lists them all. `--faction`, `--race` and `--class` keep what such a
character can use.

`--json` prints the results as one JSON array, and `lint --format
json|github` its problems, for editors, scripts and CI. Every result has
`kind`, `id`, `name` and `line` (the guide line); quests always, and guides
and inns when there is something to say, also `notes` (the comment lines
printed under it); besides:

| Kind | Fields |
|---|---|
| `quest` | `level`, `zone`, `x`, `y` (where it starts), `starts` and `ends` (`kind`, `id`, `name`, `zone`, `x`, `y` of the NPC, object or item), `turnin` (the turn-in line), `objectives` (`index`, `kind`: `kill`, `item`, `object` or `event`, `id`, `name`, `count`; `id` and `count` may be `null`) |
| `npc` | `level`, `zone`, `x`, `y` (its first spawn) |
| `object` | `zone`, `x`, `y` |
| `item` | — |
| `guide` | `level` (its first), `levels` (`min`, `max`), `zone`, `faction`, `races` and `classes` (`null` when the guide names none), `next` (the guide ids its `next` offers: several are a route choice) |
| `inn` | `id` and `npc` (the innkeeper), `npcName`, `names` (every bind location the game may report; the first is `name`), `zone`, `map`, `x`, `y` |
| `flight` | `id` (the flight point), `node` (its full name, `name` is its town), `faction` (`Alliance`, `Horde`, or `null` for both), `npc`, `npcName`, `zone`, `map`, `x`, `y` |

Fields with nothing to say are left out (a quest with no starter has no `x`),
except a quest's `objectives` and `notes`, which are empty lists.

In game, **`/polestar where`** prints where you stand as two guide lines and
puts them in a box to copy:

```
zone map 1429
goto 42.11,65.93 live
```

`live` marks the coordinates as the client's own map frame. Typed
coordinates are read in the Era frame unless marked (GUIDE_FORMAT.md,
`coords`), and Forever moved some zones, so keep the `live`. For any other
goal, add the `@x,y live` form chat prints (`kill 299 @42.11,65.93 live`). A
guide written mostly from `/polestar where` can say `coords live` in its
header once instead.

A pack's guide may hand over to any of Polestar's guides with `next`
(GUIDE_FORMAT.md, "Handing over to our guides"). Pick one every character of
your guide can follow: check its races, classes and levels with `polestar find
--kind guide <zone> --race <Race>` (and `--class <Class>` for a class guide).
Lint stops a `next` that no character of the guide can follow.

### With an AI assistant

An AI assistant can help you turn **your own material** into guides: your
notes, routes you played, guides you wrote. Two ways work well:

- **A chat assistant.** Give it [GUIDE_FORMAT.md](GUIDE_FORMAT.md) (or
  [GUIDE_CHEATSHEET.md](GUIDE_CHEATSHEET.md)) and your material, and ask for
  `.guide` text. Paste the result into your pack and run `polestar lint`.
- **A coding agent in the pack folder.** `polestar new` writes `AGENTS.md`
  (and `CLAUDE.md`, which points to it): look up every id, name and
  coordinate with `polestar find --json` and never guess one; repeat
  `polestar lint --format json` and `polestar playtest` until both pass;
  write only from the author's own material. It also writes the
  polestar-guide-pack skill (the workflow and the guide format on one page)
  into `.agents/skills/` and `.claude/skills/`; for an older pack, copy
  `skills/polestar-guide-pack/` from your Polestar clone into both, or run
  `npx skills add fitzforge/polestar --skill polestar-guide-pack` in the
  pack folder.

**The ground rule:** an assistant's quest ids, NPC ids, place names and
coordinates are guesses until `find`, lint and playtest confirm them.
Assistants write plausible numbers that are wrong. Check every id with
`find`, and do not publish until lint has no errors and playtest plays every
guide to the end.

## Testing

Every command below works on the pack in the folder you run it in (or the
nearest parent holding `pack.json`); give a pack folder as its one argument
(`polestar lint ../joes-routes`, the same as `--pack ../joes-routes`) to work
on another.

| Command | What it checks |
|---|---|
| `polestar lint` | every check `compile` makes, writing nothing; exit code 1 on errors. `--format json` prints one document on stdout and no summary: `{ "ok", "errors", "warnings", "diagnostics" }`, `ok` true without errors, `errors` and `warnings` the counts, and `diagnostics` one object per problem with `file`, `line`, `severity` (`error` or `warning`), `message` and, when there is one, `hint`. `--quiet` leaves the warnings out of the list (text, JSON and annotations alike); the JSON counts still include them. `--format github` prints workflow annotations. `--include-drafts` checks `drafts/` too. `--no-data` checks without reference data: the guides must give every quest title, NPC name and place themselves (`compile`, `dev`, and `install` and `pack` on a pack take it too; it cannot be combined with `--data`, `--context-data` or `--sim`) |
| `polestar playtest [--filter text] [--class C] [--group do\|skip]` | plays every guide (every group quest, `when group`, skipped, the solo route, or with `--group do` done) (with `--filter`, those whose file or id contains the text) to the end in the real addon against a simulated world, once per class it branches on plus one it never names, as each race that can reach it (only race and class pairs the game has); Polestar's guides join where yours hand over. Prints per guide, race and class `ok  joe/elwynn (Human Warrior)`, `stuck … at step N "title": goal M (…) stays active`, `fail …` (a problem found while playing, such as a goal with no location) or, for a hand-over that does not land on the next guide with something to do or lands on one the character cannot follow (`no Human can follow it`), a `stuck` line naming the hand-over; exit code 1 when any is stuck or fails, when nothing played, or when the pack does not compile |
| `polestar play` | the playground: your guides, your row on the Community guides page and its problems, in the browser |
| `polestar sim compare --faction F [--race R]` | inside a pack: scores your leveling chain beside Polestar's under the simulator's model (hours to level 10, 20 … 60); a chain starting above level 1 is scored after Polestar's own chain up to the level yours starts at, and a chain whose guides name no race is scored for every race of the faction. Needs the simulator's world (docs/SIMULATION.md) |
| `polestar doctor` | the setup, and the pack's `pack.json` |

Lint and compile read Polestar's guides as context, so your `next` is
checked against them, and so are quests across the hand-over: a quest your
guide accepts counts as turned in when our guide you hand over to turns it
in, but your guide cannot turn in a quest that only our guides accept (that
is the "never accepted earlier" error). Problems in our own guides are not
shown.

## Publishing

```sh
polestar pack       # lints, builds and writes dist/<folder>-<version>.zip
```

The zip holds the addon folder (the TOC, `Pack.lua`, `MapFrames.lua`,
`Guides.lua`, `LICENSE-DATA.txt` and the picture file of every `image` line,
GUIDE_FORMAT.md "Pictures"), byte for byte reproducible, with the pack's
`LICENSE` as `LICENSE.txt` when the pack folder has one.

The TOC places the community addon in the game's AddOns list for you:
titled "Polestar Community: <title>" (your title as it is when it already
starts with that), grouped with Polestar, in the Quests category, with your
`notes` as its description, or "Community addon for Polestar by <author>"
when `pack.json` has none. Polestar's own menus and the Community guides
page show your title as you wrote it. Community addons built before this
name read "Polestar Pack: <title>" until rebuilt; Polestar reads both.

Upload the zip to:

- **CurseForge** and **Wago**: a new addon project for World of Warcraft:
  Forever (the Classic game version matching the TOC's Interface). Mark
  **Polestar as a required dependency** on the listing, so the app installs it
  with your pack.
- **GitHub**: with the template's workflow, push a version tag (`v1.2.0`) and
  the workflow builds the zip and attaches it to a release.

Raise `version` in `pack.json` for every release. The guides' licence is the
one in `pack.json` (`license`, and the `LICENSE` file `new` wrote, which the
zip ships). For a licence `new` has no text for, it writes one placeholder
line into `LICENSE`; lint warns until you replace it with the licence's text.
Polestar's [LICENSE-EXCEPTION.md](../LICENSE-EXCEPTION.md) lets you
distribute packs built by its compiler, including the reference data the
compiler places in them, under terms of your choice; the pack's
`LICENSE-DATA.txt` names that data's sources. It does not cover guide text
copied from Polestar's own guides.

Players see your title, author, version, licence, guide count, website and
`source` on the Community guides page, and "By <author> · <pack title> <version> ·
<licence>" in each guide's details. Each pack is made and supported by its
author: put where to report problems in your README and on the listing.

Polestar suggests the next guide from its own guides unless the player picks
your pack under **Suggest guides from** (Options > Community guides); only packs
with Leveling guides are offered there. With your pack picked, Polestar's
guides still fill in wherever yours have nothing for the character (another
race, another level range).

### One guide as an import string

A single small guide (a quest chain, an item, a mount, an errand) can go to
players as one line of text instead of a zip. They paste it on Polestar's
Import page (`/polestar import`, or **Import** above Options in the hub);
nothing to install, no restart.

```sh
polestar lint && polestar playtest            # the same checks as for an addon
polestar export guides/cozy-sleeping-bag.guide > cozy.txt
```

Share the line in `cozy.txt` on Discord, GitHub, a forum or your listing.

- The guide stays in your pack: `export` finds the `pack.json` above the
  file, and the guide id starts with your pack id
  (`yendi/cozy-sleeping-bag`). The string carries your pack's `license`; its
  author is the guide's `author`, else the pack's.
- `export` lints the pack first and refuses a guide with errors. It prints
  only the string on stdout.
- Limits: 60 steps, 100 goals per step, 128 candidates per goal, 50,000
  characters for the string. A bigger guide, or a set of guides, is a
  community addon.
- A `next` or route choice may lead only to one of Polestar's guides or a
  guide the player has already imported; `export` names the guides to import
  first.
- Pictures (`image` lines) are not carried: an imported guide shows none.
- In `polestar play <pack>` (and `polestar dev --play`), **Copy import
  string** beside the guide picker gives the string of the guide picked.

**Updating** an import string: raise the guide's `version`, export again and
share the new line. Players paste it and press **Update**; their progress
stays where the steps did not change. Keep the guide id.

The comparison with a community addon is in [GUIDE_PACKS.md, "Import
strings"](GUIDE_PACKS.md#import-strings); the string's format in
[PACK_FORMAT.md, "Import strings"](PACK_FORMAT.md#import-strings). Strings
are covered by the same [licence exception](../LICENSE-EXCEPTION.md) as
community addons.

## Updating

- Change the guides, raise `version`, run `polestar pack` and upload.
- Players' progress is keyed to guide ids: keep a guide's id when you revise
  it. Removing a guide only closes its tabs; a player's tabs come back if it
  returns.
- **After a game patch** raises the client's interface number, the game
  marks every addon built for the old one out of date. Update your Polestar
  clone (`git pull`), rebuild (`polestar pack`) and upload: the TOC takes the
  interface number from Polestar's. Until then players can tick **Load out of
  date AddOns** in the game's AddOns list.
- When Polestar adds a new pack format, packs in the old one keep working
  (PACK_FORMAT.md, "Versioning").

## In game: statuses and problems

Options > **Community guides** (`/polestar packs`) lists every pack the game
has installed, ours first. The rules behind the statuses and problems below are
in PACK_FORMAT.md, "Rules Polestar enforces". Each row has a status:

| Status | The row says | Fix |
|---|---|---|
| `on` | the switch on, the guide count | — |
| `off` | the switch off: the player hid the pack's guides | switch it on; its tabs come back |
| `disabled` | "turned off in the AddOns list", with **Enable and reload** | press it, or enable the addon in the AddOns list |
| `not-loaded` | "not loaded: <the client's reason>" (out of date, a dependency missing), or "not loaded" when the client gives none | out of date: rebuild with an updated clone, or tick "Load out of date AddOns"; dependency missing: install or enable the addons on the pack's `## Dependencies` line (the AddOns list names them) |
| `too-new` | "needs Polestar <version> or newer", or "needs a newer Polestar" when its TOC gives no `X-Polestar-Needs` | update Polestar |
| `refused` | "refused: <reason>" | one of the pack problems below |
| `broken` | "broken: registered no guides" | see `no-guides` below |

While any pack has problems, the page's entry in the Options sidebar carries a
dot, and the row shows "<n> problems" with **Show** (the list) and **Copy
report** (the pack, its version, Polestar's version, the client build and
every problem, selected for copying: players can paste it into a bug report).
Problems have three kinds:

| Kind | Message | Fix |
|---|---|---|
| `pack-refused` | Pack id <id> is not valid: 2 to 32 lower-case letters, digits or hyphens, starting with a letter or digit. | fix `id` in `pack.json` and rebuild |
| `pack-refused` | Pack id <id> is reserved for Polestar. — plus " 1 guide dropped." or " <n> guides dropped." when it dropped any | pick another id |
| `pack-refused` | Pack id <id> is already taken by <addon>; <addon> was refused. — plus " 1 guide dropped." or " <n> guides dropped." when it dropped any | the refused pack's guides stay out, even under the holder's ids. Two installed addons claim one id: pick an id of your own (`<author>-<name>`); players remove one of the two |
| `pack-refused` | The pack is missing format. / The pack is missing <field>. | rebuild with `polestar compile`; a hand-written `Pack.lua` needs every field (PACK_FORMAT.md) |
| `pack-refused` | Needs Polestar <version> or newer. / Needs a newer Polestar. (no `X-Polestar-Needs` in the TOC) | the player updates Polestar |
| `pack-refused` | Only Polestar's own Lookup pack may register as internal. — plus the dropped guides, as above, when its id is also reserved or taken | remove `internal` from `RegisterPack` |
| `guide-refused` | Guide <id> was refused: its id must start with <prefix>. | start every guide id with `<pack id>/` |
| `guide-refused` | Guide <id> was refused: it was registered before its pack. | `Pack.lua` must load first: rebuild with `polestar compile` |
| `guide-refused` | Guide <id> was refused: <reason> (`missing title`, `no steps`, `step 3 has no goals`, `step 3 goal 2: unknown verb …`, `step 3 goal 2: kill needs target`, `step 3 goal 2: coordinates outside 0-100`, …). | the guide's table breaks the format: rebuild with `polestar compile`, which never writes such a table; with your own tools, PACK_FORMAT.md |
| `no-guides` | Registered no guides. | the addon loaded but registered nothing, usually a Lua error in its files: turn on `/console scriptErrors 1`, `/reload`, and read the error; rebuilding with `polestar compile` fixes a damaged folder |

Nothing goes to chat: every refusal happens while the packs load or in the
scan at login, so the row's **Show** and **Copy report** are where to read
them.

Below the list, **Suggest guides from** picks where suggestions come from
(Publishing, above), and **About community guides** tells players in plain
words what a community addon is, with a **Read more:** link to
[GUIDE_PACKS.md](GUIDE_PACKS.md). A pack's website and that link open the
copy window, with the address selected to copy.

### Import strings that are turned down

The Import page reads a pasted string and shows what it holds before
anything is saved. A string it cannot take is turned down with one of these
messages, and nothing is saved:

| Message | Fix |
|---|---|
| This is not a Polestar import string. / This import string is damaged or incomplete. Copy the whole string again. | the player copied part of the line, or something else: copy the whole line again (spaces and line breaks in it are fine; Polestar drops them) |
| This import string needs a newer Polestar. / This import string holds a field Polestar does not read (<field>). It may need a newer Polestar. | the player updates Polestar; if they already have the latest, rebuild the string with an updated clone |
| This import string is too long: Polestar reads up to 50000 characters. / This import string holds too much: Polestar reads up to 256 KB of guide data. | split the guide, or publish it as a community addon |
| Its guide has <n> steps; an import string holds 60 at most. A bigger guide comes as a community addon. / Its guide has <n> goals in step <s>; an import string holds 100 per step at most. / Its guide has <n> candidates in a goal; an import string holds 128 per goal at most. | shorten the guide or the step, or publish a community addon |
| This import string holds a text longer than Polestar reads (<field>): 4096 characters at most. | shorten that tip or text |
| Its guide id <id> must start with its author's own id, as in yendi/cozy-sleeping-bag. | start the guide id with your pack id and export again |
| Guides under <id>/ come from the community addon <addon>, which is installed. | that id belongs to an installed addon: pick a pack id of your own |
| It leads on to <id>, which is neither one of Polestar's guides nor an imported one: import that guide first. | the player imports that guide first (`export` lists them), or drop the `next` |
| Guide <id> was refused: <reason>. / Its guide has a spot coordinate outside 0-100. (and the other map-frame and coordinate messages) / Its guide has more than one direct turn-in for quest <q> in step <s>. | the guide breaks a rule a community addon's guide would too (PACK_FORMAT.md, "Rules Polestar enforces"): fix it, lint, export again. `polestar export` never writes such a string |
| This import string holds no guide. | export again with `polestar export <file.guide>` |
| This game client cannot read import strings. | the client lacks the decoding Polestar needs (`C_EncodingUtil`): publish a community addon for that client |

`/polestar import delete <guide-id>` removes one imported guide, and
`/polestar import clear` removes them all; the Import page's **Delete**
buttons do the same.

## Lint messages

Every message comes with `file:line: error|warning: message` (`file:` alone
when it is about a whole file or folder), and most with a `hint:` line saying
how to fix it. Errors stop `compile`, `pack`, `install`, `dev`, `play` and
`playtest`; warnings print. These are the ones about packs, plus the guide
checks authors meet most; the rest are listed in GUIDE_FORMAT.md
("Validation").

| Message | Fix |
|---|---|
| no reference data: the folder does not exist / the folder holds none of quests.json, npcs.json, …, so no quest, NPC or place can be looked up | run `polestar data build` in the clone, or point `--data <dir>` at a built folder (and `--context-data <dir>` when our guides' data is missing too); `--no-data` checks guides that give every quest title, name and place themselves |
| missing <file>.json, … (warning) | the reference data is partly built: run `polestar data build` again |
| no pack.json in <dir> | create `pack.json` with `id`, `title`, `author`, `version` and `license` (or run `polestar new`) |
| pack.json is not valid JSON (…) | a missing value, quote or comma; JSON allows no trailing commas or comments |
| pack.json must hold one JSON object | write `{ "id": "...", "title": "...", "author": "...", "version": "...", "license": "..." }` |
| missing `<key>` | add the key with your own value |
| `<key>` must be a string | put the value in quotes |
| `<key>` contains control characters (line breaks, tabs or other invisible characters) | keep the value on one line |
| `<key>` is N characters long; at most M fit | shorten it |
| pack id "<id>" is malformed: 2 to 32 lowercase letters, digits and dashes, starting with a letter or digit | pick an id like `<author>-<name>`, e.g. `joe-routes` |
| pack id "<id>" is reserved for Polestar ("guides", "forever", "lookup", "draft", "polestar" are) | pick another id |
| version "<v>" is malformed: one word of letters, digits, ".", "+" and "-", at most 32 characters | write a version like `1.2.0` |
| website "<url>" must start with https:// or http:// | write the full address |
| folder "<name>" is malformed: 1 to 64 letters, digits, "_" and "-" / folder "<name>" looks like one of Polestar's own addons | pick a folder like `PolestarPack_JoesRoutes`, or leave `folder` out |
| unknown key `<key>` (ignored) (warning) | remove it; `pack.json` takes the keys in PACK_FORMAT.md |
| `<key>` contains "\|", which prints literally in game (warning; the same for a guide's title, folder, pitch, pros, cons and author, step titles and tips, goal texts and notes, and names given in quotes) | drop the `\|`: Polestar shows text as written, so colour and link codes do not work |
| guide id "<id>" is outside pack "<pack>": its guide ids start with <prefix> | start the id with `<pack id>/` |
| `next` points to unknown guide "<id>" | a guide of your pack or one of Polestar's: list ours with `polestar find --kind guide <text>` |
| `next` offers <faction> guide "<id>" after a <faction> guide | hand over to a guide of the same faction |
| no <races> character can follow <id> (it is for <its races> only) | the `next` guide's `race` or `class` leaves out every character of yours: pick one for the same races (or classes) with `polestar find --kind guide <zone> --race <Race>` |
| LICENSE still holds the placeholder line `polestar new` writes, not the licence text (warning) | replace the line with the full text of your licence |
| map <id>: this pack's Era frame differs from the one Polestar's guides register; in game Polestar's wins, so coordinates on this map may be off (warning) | mark the coordinates on that map `live` or retake them with `/polestar where` |
| `kill` npc <id> (<name>) is elite; … / <item> drops only from elites (<names>); … / quest <id> (<title>) is elite … (warning in packs) | Polestar's own house rule (errors in our guides): in a Leveling guide put the goal in a step with `when group <quest>` (the player chooses it; the quest's goals elsewhere go with its accept) or make it `optional`, with the tip "<name> is elite: grouping up is advised." |
| quest <id> (<title>) needs <Profession> <rank>, and the guide does not train it before here: characters without it never see this goal (warning, Leveling guides) | the quest giver offers it only to characters with that profession, and Polestar hides its goals from the others: make the goal `optional`, or `train <Profession>` (and `skill <Profession> <rank>` above rank 1) earlier in the guide |
| sethome/hearth/getfp/fly "<location>": no inn has that bind location / no inn stands there (an inn's area or the zone it is in) / no flight point has that name / no flight point lands there (its town, an inn's area or the zone it is in); the game never reports that name, so the goal never checks off by itself (warning) | write the place as the game names it: the hint offers the closest known names (`did you mean "Grom'gol Base Camp"?`); `polestar find --kind inn` and `polestar find --kind flight` list them all. Checked against the inns and flight points of `data/forever/travel.json` (GUIDE_FORMAT.md, "Validation") |

The folder rule (PACK_FORMAT.md, "TOC fields"): `compile`, `install` and
`dev` write a pack folder only when it is absent, empty, or built for the
same pack id (its TOC carries the "Generated by `node tools/polestar.js
compile`" line); anything else is refused. (`pack` writes only the zip, and
`play` builds into a fresh temporary folder, so the rule never stops them.)
`compile` and `dev` print `refusing to write into <dir>: <reason>`.
`install` lints and builds the pack, then checks the AddOns folder before it
writes or copies anything and prints `refusing to install:
<AddOns>/<folder>: <reason>`; it then writes the build into
`<pack>/dist/<folder>` before copying, so the same rule there prints
`install failed: refusing to write into <pack>/dist/<folder>: <reason>`. The
reasons are the same everywhere:

| Message | Fix |
|---|---|
| refusing to write into <dir>: it is not a generated community addon (no TOC with the "Generated by …" line); move it away first | a folder of the same name that Polestar did not write is in the way (in AddOns or `dist/`): move or rename it, or set `folder` in `pack.json` |
| refusing to write into <dir>: it holds the community addon "<other id>", not "<id>"; set "folder" in pack.json to a folder name of your own | another pack builds into the same folder name (folder names come from titles, so two packs titled alike collide): set `folder` in `pack.json` |
| refusing to write into <dir>: it is not a folder / refusing to install: <AddOns>/<folder> exists and is not a folder | a file has the pack folder's name: move or rename it, or set `folder` in `pack.json` |

## Where things are

- [GUIDE_FORMAT.md](GUIDE_FORMAT.md): the guide language, its checks and a
  cookbook.
- [GUIDE_CHEATSHEET.md](GUIDE_CHEATSHEET.md): every line of the guide
  language on one page, with an example each.
- [PACK_FORMAT.md](PACK_FORMAT.md): the pack rules: `pack.json`, ids, the
  folder rule, the TOC and Lua the compiler writes, what Polestar refuses and
  the statuses it shows.
- `polestar help <command>`: every option of every command.
