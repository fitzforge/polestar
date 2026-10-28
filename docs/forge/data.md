# Forge data: from the game to `data/forever`

This page covers everything Forge knows about the game before it plans a route: where the facts
come from, how they are merged, how we fix them, how sure we are of each one, and what a
contributor without our local files gets instead. It is for contributors who want to build the data,
fix a wrong fact, or find out why a quest is missing from a route.

The rest of the pipeline is described in [FORGE.md](../FORGE.md). The model that reads this data is
in [model.md](model.md), the walking maps in [nav.md](nav.md), and the routes and their skip lists
in [routes.md](routes.md).

In the examples, `forge` is the binary built by `cargo build --release -p forge` in `rust/`
(`rust/target/release/forge`). Run the commands from inside a Polestar checkout: most of them find
the checkout by looking for `forever-db/corrections/quests.json` (or `data/sources`) in the folders
above the current one. Pass `--root DIR` when you are somewhere else.

## The short version

1. Forge reads **the game's data** straight from your installed World of Warcraft client: maps,
   areas, factions, races, flight paths, items, spells and many other tables.
2. It merges them with **Forever's quest data** (read from the addon in your Forever client), an open
   quest database, our **recordings** (our own in-game recordings) and our **corrections**.
3. The result is `data/forever/`: a folder of JSON files that every later stage reads.
4. Optionally, a **knowledge base** compares every source fact by fact, records how sure we are of
   each fact, and lists what someone should check in game.
5. A contributor without our local sources downloads the public **data pack** instead.
6. To fix a fact, edit our committed files and check the edit with `forge data check-corrections`:
   see [Changing the data](#changing-the-data).

Nothing here touches the network except `forge data fetch`.

## Reading the game's data

The `forge-gamedata` crate reads the client's own data tables from the client's local storage. It
is read-only: it never writes into the game folder, and it keeps no copy of Blizzard's files.

### How it works

The client keeps its files in **CASC**, a content-addressed storage in the game folder's `Data/`
directory. Forge reads it in these steps:

1. `.build.info` names the installed products and their builds, and points to a build configuration.
2. The **index files** (`Data/data/*.idx`) map a file's key to a place in one of the `data.NNN`
   archives.
3. The **encoding file** maps a file's content to its key, and the **root file** maps a numeric file
   ID to its content, per language.
4. Each file is wrapped in **BLTE**, a chunked container: chunks are plain, zlib-compressed, nested,
   or encrypted.
5. A data table is a **DB2** file (versions WDC3, WDC4 and WDC5). Forge decodes its records, strings,
   packed fields, copy tables and relationship data.

The code is in `rust/crates/forge-gamedata/src/`: `casc.rs`, `blte.rs`, `db2.rs`, `dbd.rs` and
`csv.rs`. It was written from the public format documentation; see
[rust/NOTICE.md](../../rust/NOTICE.md).

**Table definitions are read at runtime.** A DB2 file does not name its columns. Forge reads the
column names and types from an open set of table definitions, kept as a local checkout in
`data/sources/wowdbdefs` (or `--defs DIR`). Nothing from that set is copied into Polestar; it is
credited in [rust/NOTICE.md](../../rust/NOTICE.md). When the checkout is missing, `forge gamedata`
stops and prints the exact `git clone` command to get it. When a new game build changes a table's
layout, update that checkout.

**Encrypted sections are skipped.** Some sections of some tables are encrypted with keys Forge does
not have. Forge reads their bytes as zeros, skips the rows in them, and adds a note such as
`section 3: encrypted with TACT key …; 46 records skipped`. Every other row is read. This is expected,
not an error.

**What it does not do:**

- It does not apply the client's hotfix cache. A value the server has hotfixed shows as it was
  shipped in the build.
- It reads only the installed build. Asking for another build fails.
- It reads only text languages that are installed (`enUS` by default). Another locale fails with
  "not in the local storage (is the deDE text locale installed?)".

### Finding the client

Forge uses the first of these that exists:

1. `--wow DIR` on the command line.
2. The `POLESTAR_WOW_DIR` environment variable.
3. The folder Forge remembered: any command given `--wow` saves it as a `wow = "<folder>"` line in
   Forge's config file `polestar-forge/config.toml` in your config
   folder (`$XDG_CONFIG_HOME` or `~/.config` on Linux, `~/Library/Application Support` on macOS,
   `%APPDATA%` on Windows), or the file named by `POLESTAR_FORGE_CONFIG`. `forge doctor --forget`
   clears it.
4. A search of the usual Wine, Lutris, Bottles and Steam prefixes in your home folder, then the
   native install folders.

The folder must hold `.build.info`. Several products share one game folder. The default product is
`wow_classic_beta`, the product Forever's tables are published under; `--product wowf` reads the
`_forever_` client instead.

`forge doctor` prints which folder was used and how, every build in it and every other install
found.

### Is the install complete?

A launcher can leave files out: still downloading, a streaming install, or index entries whose space
was reused for another file. Reading the game's data then misses those files without an error until
something needs them, and a walking grid built from such an install is wrong where they are.

```sh
forge gamedata check --maps 0,1,2991
```

checks every file the named maps use (no `--maps`: every map): each map's WDT, its tiles' terrain and
object files, the models and buildings placed on it and the buildings' parts. It prints, per map,
how many files are missing and how many tiles they touch, and exits 1 when any are. `forge doctor`
runs the same check for the leveling maps (Eastern Kingdoms, Kalimdor, Zephras Isle). The fix is
the launcher's **Scan and Repair**; let it finish and check again.

### Inspecting tables

```sh
forge gamedata list                                         # every table and its file ID
forge gamedata export --table AreaTable --out AreaTable.csv
forge gamedata export --table Map --product wowf            # no --out: to stdout
```

Common options: `--wow <dir>`, `--product <name>`, `--build auto|X.Y.Z.B` (must be the installed
build), `--locale enUS`, `--defs <dir>`. The first line on stderr names the product, build and folder
that were opened. Notes about skipped encrypted sections go to stderr too.

### The client's caches

```sh
forge gamedata cache --out wdb.json                          # quests, creatures, objects the server described
forge gamedata cache --kind quest --out quests.json
forge gamedata hotfix                                        # DBCache.bin: entries per table and status
forge gamedata hotfix --table <name> --out rows.csv --db2     # one table's rows, compared with the installed table
```

`cache` reads the client's WDB files (`Cache/WDB/<locale>` in the product's client folder, or
`--cache <dir>`); `hotfix` reads its hotfix file (`Cache/ADB/<locale>/DBCache.bin`, or
`--cache <file>`). Both only read; the files stay on your machine.

## The data stage: `forge data build`

`forge data build` writes `data/forever/*.json`. It first fills the source cache `data/sources` the
way `forge data sources` does (below), then builds from it; `--offline` reads the cache only and
fetches nothing. The code is `rust/crates/forge-data`; the command line is
`rust/crates/forge/src/cli/data.rs`.

### The source cache: `forge data sources`

`forge data sources` downloads what the builders read into `data/sources`, in the layout they read
it from. A cached file is never fetched again: client-table builds and pinned commits do not change.
`--only LIST` takes some of the parts (comma-separated):

| Part | What it fetches |
|---|---|
| `wago` | the game's tables `forge data build` reads, as CSV (wago.tools): the Classic Era build's map and faction tables, the Forever build's when no client is installed, the QuestXP table |
| `builders` | the other builders' tables: itemdb's Classic Era item tables, the Codex's, professions' and travel's, and the pinned builds of the talent trees and the map overlays |
| `pfquest` | the open quest database's checkout, at its pinned commit |
| `eglink`, `forever-vo` | players' game caches and dialog captures, at their pinned commits (read by `--kb`) |
| `cmangos` | the open Classic server database dump, checked against its pinned sha256 |
| `webxp` | the web quest XP of the quests `--data` (default `data/forever`) has none for |
| `wowdbdefs` | the table definitions the installed client is read with (only when a client is found) |

`--build` and `--forever-build` pick the builds (default: the newest wago.tools lists).

<!-- ci -->
```sh
forge data sources --help
```

### Validation: the statistics gate and `forge data check`

`forge data build` makes the build in `<out>.staging/` first, computes its field statistics (quests
with a giver and an ender, ids that resolve, givers spawning in the quest's zone, race and class
masks, spawns, the area rows the compiler reads, our guides compiled on it: name tokens per kind,
errors, warnings, names the deDE names addon has), and compares them with the last good build's
(`<out>/stats-good.json`). A shift past a field's limit stops the build: `<out>` is left as it was,
the report names the fields, and the new build stays in `<out>.staging/` to look at. Rerun with
`--accept` when the change is intended. A good build replaces `<out>` and becomes the last good one;
the first build, with no last good one, is taken.

`forge data check` compares the data as it is against its last good statistics and exits 1 on a
shift; `--accept` makes them the last good ones, `--all` lists every field.

<!-- ci -->
```sh
forge data check --help
```

### What it reads

| Input | Where | Notes |
|---|---|---|
| The game's data | the installed client, through `forge-gamedata` | maps, areas, factions, races, items, spells and more; without a client or table definitions, the cached copies of the tables under `data/sources` |
| Forever's quest data | the addon in your Forever client's AddOns folder (found automatically; `--questie DIR` to point at it, `--no-questie` to leave it out) | quest givers, objectives, XP and more for Forever |
| An open quest database | `data/sources` (`--pfquest DIR`) | the base layer: quests, NPCs, objects, items for Classic; read through a built-in Lua 5.1 |
| Cached facts | `data/sources` | spawn heights and objective counts from an open Classic server database, web quest XP |
| Recordings | `data/recordings/*.json` (`--recordings DIR`) | our own in-game recordings |
| Corrections | `forever-db/corrections/` (`--corrections PATH`) | our own fixes, see [Corrections](#corrections) |

Each source's name, version and licence is recorded in `data/forever/meta.json` under `sources`.
For the full credits and licences, see [rust/NOTICE.md](../../rust/NOTICE.md) and
[THIRD_PARTY.md](../../THIRD_PARTY.md).

### How the merge works

The build goes in layers. A later layer wins over an earlier one:

1. The open quest database gives the base tables, renumbered to the game's map IDs.
2. Forever's quest data is merged over it. Lists such as an item's droppers are unions of both.
3. Our corrections are applied, with or without Forever's quest data.
4. Cached quest XP fills XP that is still missing.
5. Our recordings are applied last: what we saw in game beats everything else.

Spawn points are thinned to at most 24 per NPC or object per map (`--cap N`), spread evenly over
the area they cover.

### What it writes

Without `--kb`, `data/forever/` gets:

| File | What it holds |
|---|---|
| `quests.json` | every quest: level, givers and turn-ins, objectives, prerequisites, XP, races and classes, and the sources each record came from |
| `npcs.json`, `objects.json` | names, levels, ranks, factions, roles, spawn points per map |
| `items.json` | where each item comes from: drops (with chances), vendors, containers |
| `zones.json`, `map-frames.json` | zone names and levels; how map percentages convert to world coordinates |
| `factions.json`, `races.json`, `instances.json` | factions and reactions, races and classes, dungeon and raid areas |
| `spawnz.json` | spawn heights (z) for NPCs and objects |
| `moves.json` | the ground each walking NPC's spawn covers (classic-db's random and waypoint movement): its centre and radius |
| `meta.json` | the sources, their versions and licences, counts, and the build time |

`--built-at ISO` (or `SOURCE_DATE_EPOCH`) fixes the timestamp in `meta.json`, so two builds of the same
inputs give the same bytes. `POLESTAR_DATA_TIMES=1` prints how long each phase took.

### `--kb`: the knowledge base build

With `--kb`, the build adds the knowledge base stage (below) and writes three more files:

| File | What it holds |
|---|---|
| `training.json` | class training costs per class and level |
| `mechanics.json` | how quests work beyond their objectives (for example: an item summons the target, the giver offers the quest a few seconds after another hand-in), each with a confidence and whether it **drives** the route; the committed public layer `data/mechanics-public.json` (`--mechanics FILE`) is merged in, see [Changing the data](#changing-the-data) |
| `trainers.json` | class trainers, updated when the knowledge base finds more |

It also writes the knowledge base itself to `data/local/kb/forever-kb.sqlite` (`--kb-file`) and the
list of facts to check in game to `data/local/kb/verify-in-game.json` (`--verify-file`). Both stay on
your machine. `--local DIR` moves the whole `data/local` input folder.

```sh
forge data build                       # data/forever from the client and local sources
forge data build --kb                  # plus the knowledge base
forge data build --out other-forever   # write somewhere else, e.g. to compare two builds
```

<!-- ci -->
```sh
forge data build --help
```

### Choosing the table source

By default `forge data build` reads the Forever tables from the installed client when it finds both a
client and the table definitions. Otherwise it says so on stderr and uses the cached copies under
`data/sources`. `--forever-tables client` insists on the client and fails when there is none;
`--forever-tables saved` reads the copy `forge build` saved under `data/sources/client-tables/<build>/`.
`--wow`, `--product` and `--defs` work as in `forge gamedata`. `--no-forever` builds without the Forever
tables.

`forge build`'s data stage never reads whatever client happens to be installed: it reads the tables of
the build the walking grid was built from (the grid's `index.json`), saved under
`data/sources/client-tables/<build>/` (`<Table>.csv` as wago.tools writes them, and `source.json`
naming the product, build and folder they were read from). `forge build --forever-tables client`
refreshes that copy from the installed client (`wow_classic_beta` or `wowf` at the grid's build; each
table is checked to read back as the client's rows, and an unchanged copy is left as it is);
`--forever-tables wago` reads the wago.tools cache at the grid's build. The log names the source and
build; tables of another build than the grid's stop the build unless `--allow-build-mismatch`, and so
does a source that cannot be read (no silent fallback to Classic Era's zones). `forge doctor` says
whether the grid's build is saved.

## The other builders

Each builder is a `forge data` subcommand. All of them read `data/forever`, so run `forge data build`
first.

| Command | Writes | Reads |
|---|---|---|
| `forge data trainers` | `data/forever/trainers.json`, `addon/Polestar/Core/ClassTrainers.lua` | a curated list of class trainers, every `train <npc> only <Class>` step in `guides/`, and recorded trainer visits |
| `forge data travel` | `data/forever/travel.json`, `addon/Polestar/Nav/TravelData.lua`, `addon/Polestar/Maps/FlightPaths.lua`; the local `Polestar_Travel` addon when `data/local/crossings.json` exists | flight paths, boats and zeppelins with their timetables, inns, zone crossings (`data/crossings.json`), recorded paths, and the walking grid (`--grid DIR`, or `--grid none`) |
| `forge data professions` | `data/forever/professions.json` (or `--out FILE`) | the game's profession tables, items, NPCs and vendor stock |
| `forge data dungeons` | `data/forever/dungeons.json` (or `--out FILE`) | a dungeon journal addon installed in your client (`--source DIR`); only facts (ids, names, levels, places, rewards, chains), none of its text |
| `forge data codex` | `data/forever/codex/*.json` and `addon/Polestar_Codex` | `data/forever`, the game's tables, Polestar's guides and curated tables, installed addons (`--addons DIR`) |
| `forge data gear` | `addon/Polestar_ItemDB/…`, `addon/Polestar/Gear/SpecData.lua`, `data/forever/gear/report.json` | an installed gear addon (`--addons DIR`), Polestar's item database and weights |
| `forge data sim-inputs --out DIR` | the game-table and server-fact files the simulator's world reads beside `data/forever`, in the `data/sources` layout | the installed client (or the cached tables) and the cached server facts |
| `forge data extracts --out DIR` | the server-fact extracts, rebuilt from the pinned database dump in `data/sources` | for checking the cached extracts |
| `forge data itemdb` | `addon/Polestar_ItemDB/Items.lua` and its TOC (size budget 1 MiB) | the Classic Era item tables (ItemSparse, Item, ItemEffect, SpellEffect) |
| `forge data names [<locale>...]` | `Names.lua`, `LICENSE-DATA.txt`, `CREDITS.md` and the TOC in the language folders `addon/Polestar_<locale>` (committed; our guides' `Texts.lua` there is left alone): the data's names in each client language; `--offline`, `--no-questie`, `--no-tables`, `--build`, `--sources`, `--ding`, `--pfquest`, `--guides`, `--questdb`, `--codex`, `--travel`, `--chokepoints`, `--out`, `--json` (`polestar i18n names` retired) | the client's tables (wago.tools, cached), the cached web quest database names, DingDB (pinned), pfQuest; the ids of the compiled guides, `addon/Polestar_QuestDB`, `data/forever/codex`, the travel data and the chokepoints |
| `forge data questdb` | `addon/Polestar_QuestDB` (local; in the release zip when built): each kind's records as LuaChunks strings, decoded when read; `--radius YD`, `--droppers N`, `--json` | `data/forever` (quests, npcs, objects, items, map-frames) |
| `forge data talents build` | `addon/Polestar/Talents/Builds.lua`; `check` fails when it is out of date or a plan breaks a rule | the plans in `talents/forever/*.json` and the Forever client's trait tables at a pinned build |
| `forge data maps build` | `addon/Polestar/Maps/ZoneLevels.lua` | `data/forever` (npcs, zones, map frames) |
| `forge data maps overlays` | `addon/Polestar/UI/ZoneArtOverlays.lua` | the Forever client's map-art tables at a pinned build |

`itemdb`, `talents` and `maps overlays` fetch a missing table into `data/sources` unless `--offline`;
`codex`, `professions` and `travel` read the cache only: `forge data sources --only builders` fills it.

Codex and gear are addon side products. They are not route inputs.

`forge data codex --local-extras` builds a Codex for your machine only. On top of the release
inputs it merges the installed AtlasLoot (GPL-2.0) and RareScanner (no redistribution) and
`data/forever/dungeons.json`, and it skips the cached web facts. It writes to
`data/local/codex-extras` and `data/local/codex-extras/Polestar_Codex` unless you pass `--out` and
`--pack`. Its meta says `localExtras`, its `LICENSE-DATA.txt` says not to share it, and `forge pack`
refuses it. A release build compares itself with this build when it exists (`meta.parity`).

`forge build` runs the data stage itself: it runs the data build, then the travel, trainers and
professions builders over the result. It does not build `dungeons.json`, `gear/` or `codex/`; when
your checkout's `data/forever` has them, it copies them across and names them in its log. The data
stage is skipped when none of its inputs changed: the client's `.build.info`, Forever's quest data,
`forever-db/corrections`, the shipped crossings, `data/sources`, `data/recordings`, the grid and the guides.

## Corrections

`forever-db/corrections/` is Polestar's own list of fixes to the merged data: one file per section
(`quests.json`, `npcs.json`, `objects.json`, `items.json`, `mechanics.json`), each keyed by id. It is
committed, reviewed like code, and ranks above every other source except our recordings. It lives in
the public database's folder ([below](#the-public-database-forever-db)), whose README documents
every section for contributors. `--corrections` also reads one `corrections.json` in the old
single-file form, and a checkout without the folder still has its
`tools/lib/data/corrections.json` read, for one release.

| Section (file) | Keyed by | What an entry can do |
|---|---|---|
| `quests` | quest ID | `set`: replace fields (races, classes, prerequisites, objectives, …); `escort`: `true` or `false` when the quest's own text gets it wrong |
| `npcs`, `objects` | NPC or object ID | `set`: replace fields (an elite or rare `rank`; an object's `lock: { item }`, the key that opens it); `addSpawns`: `{ "<uiMapID>": { f, pts } }` adds a map's spawn points, or replaces that map's points |
| `items` | item ID | `removeDrops`: `{ npc: [ids], object: [ids] }`; `removeVendors`: `[ids]` (drop wrong sources the merge kept) |
| `mechanics` | quest ID | `params`: `[{ kind, … }]` adds or replaces a mechanic (for example `delayed-offer` with `after`, `npc`, `sec`); `steps`: `{ "<n>": { set } }` changes step `n` |

In `addSpawns`, `pts` are `[x, y]` map percentages and `f` names the map frame they are in (`e` for the
Classic frame, `l` for Forever's). Every entry has a `source`, the evidence for what it sets (`{ kind,
ref }` or a list of them; `kind` one of `recording`, `in-game-check`, `client`, `eg`, `cmangos`, `tdb`,
`questie`, `pfquest`, `factoruide`; `forge data check-corrections` fails without it), and a `note` that
says what is wrong and how it was checked, in our own words. Cite issues, recordings and in-game
checks, never a website. An entry in `npcs.json`:

```json
"1738": {
  "addSpawns": { "1420": { "f": "e", "pts": [[61.4, 53.4]] } },
  "source": { "kind": "in-game-check", "ref": "issue 512" },
  "note": "Deathguard Terrence, who gives The Argent Emissary (96895), stands at 61.4,53.4 on map 1420; replaces the map's other points."
}
```

Rules:

- One entry per fact, with its source. A fix whose only support is a source Polestar does not
  publish goes in the maintainer's private overlay (`data/local/corrections-private.json`, same
  shape; its mechanics may also sit under `mechanics.quests`), which `data build` merges over the
  public files when present.
- Corrections are applied whether or not Forever's quest data was read. A build without it has
  fewer records; a correction for a record the build does not have becomes that record when it can
  stand alone (a quest with `title`, `start` and `end`; an NPC or object with `name` and spawns).
  Otherwise the build names it in `meta.json`'s warnings (`correction not applied: …`). An item
  correction never stands alone: it only removes sources.
- Every corrected record gets the source `polestar-correction`, so you can see it in the output.
- Mechanics corrections are applied last, and they always drive the route.
- `tests/data-corrections.test.js` checks that every prerequisite correction really blocks the
  quest.

After editing, run `forge data check-corrections`, then `forge data build`, and look at the changed
record in `data/forever`.

## Changing the data

Three committed files hold the facts contributors change. Each is reviewed like code, and each
entry says where its fact comes from: an in-game check, a recording, a player report with its issue
number, or the game's data. Write facts in your own words, with ids and positions; never copy text
from a website.

| You want to change | File | Picked up by |
|---|---|---|
| A quest fact: who gives or ends it, what it needs first, its objectives, races, XP; an NPC's or object's rank, key or place; a wrong drop or vendor | `forever-db/corrections/{quests,npcs,objects,items}.json` | `forge data build` (and `forge build`'s data stage) |
| A hand-checked fix of how a quest is done, over every layer | `forever-db/corrections/mechanics.json` | `forge data build --kb` |
| A quest step's or note's wording, place or confidence in the public database | `forever-db/corrections/notes.json` | `forge data publish` |
| How a quest is done beyond its objectives: an item summons the target, an object must be clicked, the giver offers the next quest after a short scene | `data/mechanics-public.json` | `forge data build --kb` (`mechanics.json`), then `forge build` and `forge data pack` |
| Whether the route takes a quest: always (`include`), never (`skip`), or undo one of the cut's edits (`revert`); an order players asked for (`deliberate`) | `data/route-fixes.json` | the routes stage, from the checkout being built (or the file `POLESTAR_ROUTE_FIXES` names) |

A data mistake belongs in the data files, not in the overrides: every tool then sees the fix.

### Check an edit

```sh
forge data check-corrections
```

It reads the corrections folder, the public mechanics and the route fixes (`--corrections`,
`--mechanics`, `--route-fixes` to check others) and the
built data (`--data`, default `data/forever`), and reports, with the JSON path of each entry:

- the shape: unknown sections or fields, wrong types, map points outside 0 to 100, a missing `note`,
  `source` (or a `source.kind` outside the list) or `reason`; the note-fix records in `notes.json`;
- ids: every quest, NPC, object and item an entry names must be in the built data, or be created by
  a correction in the same file;
- conflicts: a key written twice in one object (JSON keeps only the last), a quest both included and
  skipped, a step reverted for a skipped quest, a public mechanic that a correction overrides.

Errors make it exit 1; warnings (an unknown mechanics kind, a map without a frame) do not. Without
`data/forever` it checks the shapes only and says so. `--json` prints one finding per line.

<!-- ci -->
```sh
forge data check-corrections --help
```

### A quest fact: `forever-db/corrections/quests.json`

The Silverpine quest Return to Quinn (Again) (91921) comes after Wild Eyes (91920), and the merged
data has no prerequisite. Add to `quests.json`:

```json
"91921": {
  "set": { "pre": [91920], "preAny": [91920] },
  "source": { "kind": "in-game-check", "ref": "issue NNN" },
  "note": "Return to Quinn (Again) is offered only after Wild Eyes (91920) is handed in."
}
```

`set` replaces whole fields, so give the full list. Run `forge data check-corrections`, then
`forge data build`: `quests.json` shows the new `pre` and `polestar-correction` in the record's
`source`. The next `forge build` (or the routes stage) uses it; the build's stage key includes
the corrections folder, so the data stage reruns by itself.

### How a quest works: `data/mechanics-public.json`

The file is empty to start with; its `_about` field documents the format. Each quest has `kinds`
(what sort of mechanic), `params` (its details) and `steps` (the steps in our own words), and a
`note`. William Pestle offers The Escape (114) only after a short scene that follows the hand-in of
Collecting Kelp (112):

```json
"quests": {
  "114": {
    "kinds": [{ "kind": "delayed-offer", "confidence": "high" }],
    "params": [{ "kind": "delayed-offer", "after": 112, "npc": 253, "sec": 10 }],
    "note": "<how it was checked>"
  }
}
```

It is merged over the private mechanics layers by their rules: the kind gains the source `public`;
it drives the route when it is high or another source agrees; the server's data can refute a kind,
and a refuted kind is not added. A step with the same `n` as a known step replaces it.

Hand-checked fixes that win over every layer and always drive the route live in
`forever-db/corrections/mechanics.json`, by quest id, each with its `source` and `note`: `params`
replace ours of the same kind and item (or are added, with their kind at high confidence), and
`steps` { "<n>": { "set": { ... } } } replace fields of step n (The Escape's delayed offer, 114, is
one). `forge data check-corrections` refuses a `corrections` section in this file. `forge data build --kb` writes the result to
`data/forever/mechanics.json` and the knowledge base (the source `public`); it works without
`data/local`. `forge build` then carries that `mechanics.json` into its build (its data stage reruns
when `data/forever` changes), and `forge data pack` keeps the layer's rows in the pack's public
knowledge base, since the file is already public.

### Whether the route takes a quest: `route-fixes.json`

When the guides should keep a quest the cut leaves out (players take it here, issue #647), add to
`overrides` in `data/route-fixes.json`:

```json
"include": [{ "q": 940, "reason": "players take it here", "issue": 647 }]
```

`skip` keeps a quest out; `revert` undoes one of the cut's edits, and the edits ledger prints the
exact `revert` line for each edit. An order players asked for (this before that, these together)
goes under `deliberate`. The next routes stage honours them;
[routes.md](routes.md#11-overrides) has the full format.

## The knowledge base

The knowledge base (KB) is what `--kb` adds. For every fact, one row per (kind, id, field), such as
"quest 26, races", it collects the value each source gives. It picks one winner by a single
precedence, keeps the others as alternatives, and writes the winners back into the tables. So
`data/forever` is the KB's choice. The code is `rust/crates/forge-data/src/kb.rs`.

### Precedence

From first to last:

1. Our recordings and our corrections.
2. The server's own records of spawns, objectives, trainers and drops.
3. Other observations of what the server answers, such as EG Link's records of players' quest
   answers.
4. Forever's quest data.
5. The game's data tables.
6. Factoruide's facts.
7. Classic references and the open quest database.

A missing value is filled from the best source that has one, whatever its rank. Junk text never
wins. For quest XP, a value captured in game ranks with rank 3, and two values within max(5, 3%) of
each other count as equal.

**Facts to verify in game.** Who can take a quest (races, classes, side), how an NPC reacts, where
things spawn, and whether a quest exists are decided only by the top ranks. When a lower source
disagrees on one of these, the KB does not guess. It keeps the current value and lists the
disagreement in `verify-in-game.json`, quests that matter to the routes first.

### Confidence

Every fact gets a confidence:

- **high**: the winner is from ranks 1 or 2, or at least one other source agrees with it;
- **medium**: the winner is from ranks 3 or 4 and nobody agrees;
- **low**: the winner is from rank 5 or below and nobody agrees. A value only the game's tables or
  an old reference give, with nobody agreeing, is low.

The `facts` table stores the value, the winning source, the confidence, and how many sources agree out
of how many have a value (`agree`, `total`).

A mechanic or a quest step **drives** the route when it is high confidence, or when two independent
groups of sources agree. Only driving entries change the simulated world. The rest are tips.

### What "missing info" means

When the route search could add a quest but leaves it out because the data is not good enough, the
skip list gives the reason `missing-info`. That happens when:

- the quest giver's or turn-in NPC's place is unknown;
- an objective's place is unknown;
- an item the quest needs has no known source;
- a quest fact is only low or medium confidence in the KB;
- sources disagree on the quest and it is listed to verify in game;
- a mechanic that would drive the route is below high confidence.

Each `missing-info` row says what is missing, which file a fix goes into (for example
`forever-db/corrections/quests.json: <id>.set.<field>`, or `npcs.json or objects.json: set spawns`), and the
deciding source by its public name: game data, server data, data corrections, a player report, or
mechanics facts. A quest v1 already takes is kept whatever the KB says. Only quests the search would
add must be certain.

To list them across every start (a "help us with these quests" list):

```sh
forge sim skips --reason missing-info --dir out/routes
```

`out/routes` is the `routes/` folder of a `forge build --out out` run (or set `POLESTAR_ROUTES`). The
simulator reads the KB from `data/local/kb/forever-kb.sqlite`, or the file named by `POLESTAR_KB`, fresh
on every run: a correction shows up in the next route. See [routes.md](routes.md) for the skip
list and its other reasons.

## The public data pack

Most contributors do not have our `data/sources` and `data/local` folders. The **data pack** gives them
the public part, so `forge build` works without them. The code is `rust/crates/forge/src/pack.rs` and
`fetch.rs`. The list of what goes in is `rust/crates/forge/src/pack-spec.json`.

**No public data pack has been published yet.** Once it is, `forge data fetch` downloads it from
the `data-pack` release of the Polestar repository. Until then, `forge data fetch` says so; build
from your own game client instead (`forge build --wow <path>`).

### What is in it

- the game's data tables the build reads, as cached copies, and the WoWDBDefs table definitions
  (CC BY-SA 4.0, with their licence file and credit);
- an open quest database and extracts from an open Classic server database, used as facts;
- EG Link's quest answers (CC BY 4.0);
- Polestar's own files: the corrections (`forever-db/corrections`), the availability rules, the simulator's calibration,
  the nav map list, the shipped zone crossings;
- the KB's public part (below), including Factoruide's facts (its databases are GPL-2.0-or-later, taken
  under GPL-3.0);
- the walks answered on Leffe's navigation maps (`walks/store-leffe-*.psbn`, published with his
  permission; see [nav.md](nav.md)): walking times between the world's points, per faction. His maps
  themselves are private and never in the pack: the private-data guard refuses a pack holding them.
  Our grid's walk stores are not packed: they are keyed by the grid they were built on, and every
  contributor builds their own grid.

Every file's source, licence and credit is in the pack's `manifest.json`. That file, with
[rust/NOTICE.md](../../rust/NOTICE.md) and [THIRD_PARTY.md](../../THIRD_PARTY.md), is the place for
credits.

**The KB's public part** keeps the same tables (`facts`, `mechanics`, `steps`, `verify_in_game`,
`sources`) with only:

- facts from public sources that are high confidence or where two sources agree;
- uncertain quest facts as markers: the row says the fact is uncertain, without its value (source
  `kb`);
- mechanics on their public sources only (`forever-data`, `server`, `correction`; the page snapshot's
  readings, its quest text and comments, the web and ForeverDB dropped): two public sources keep the
  row, one keeps its status at medium (the KB's own rule: high needs two), none leaves a driving
  mechanic as a marker without its status;
- quest steps of high confidence from a public source that quote none of the site's text (no
  comment, description, objectives, completion or progress evidence; the evidence column left
  empty);
- the fields that disagree in `verify_in_game`, without the values.

So a pack user's routes leave out the same uncertain quests, and their skip list shows the same
`missing-info` rows.

**Not in the pack**, and listed under `requires` in the manifest:

- **The navigation grid.** It is built from your own client's map tiles: `forge build` makes it from
  the game (the grid stage), or takes `--grid DIR` (or `POLESTAR_GRID`). The walks on your grid are
  routed on your machine; the pack's Leffe walks answer every walk they hold.
- **Forever's quest data** (Questie and QuestieDB, https://github.com/Questie: no data licence stated; used with credit, with the Questie maintainers' agreement. Questie's code is moving to GPL-3.0). Neither its files nor facts from it are
  packed. Forge reads it from your installed addon. Without it the data has fewer quest facts and the
  report says so.

### `forge data fetch`

```sh
forge data fetch
forge data fetch --dest ~/polestar-pack
forge data fetch --url ./dist/polestar-data-pack.json   # a local or test pack
```

1. It reads the index, `polestar-data-pack.json`: by default from the `data-pack` release, or
   `$POLESTAR_DATA_PACK_URL`, or `--url` (a URL, a local path, or `file://`).
2. It downloads the archive next to the index, `polestar-data-pack.tar.gz`, and each separate asset
   the index lists (none today).
3. It checks each archive's size and **BLAKE3** checksum against the index, and refuses an archive that
   does not match ("not the published pack").
4. It unpacks into a temporary folder next to the destination, and refuses any path outside it.
5. It checks every file against `manifest.json`: size and BLAKE3, no file missing, no file extra. The
   archive's manifest must equal the index's.
6. Only then does it replace the previous pack. A failed fetch leaves the old pack as it was.
7. It prints what the pack needs but does not hold (the grid, Forever's quest data).

The destination is `--dest DIR`, else `$POLESTAR_DATA_PACK`, else `polestar/data-pack` in your data
folder (`$XDG_DATA_HOME` or `~/.local/share` on Linux, `~/Library/Application Support` on macOS,
`%LOCALAPPDATA%` on Windows). Unpacked, most of the pack is walk stores.

### How `forge build` uses it

`forge build` uses the pack when its root has no `data/sources` folder:

```sh
forge data fetch
forge build --guides guides --out out
```

It looks for the pack at `--pack DIR`, else at the default fetch destination. It stops with a clear
message when there is no pack ("run `forge data fetch`"), or when it finds neither a game client to
build the grid from nor a built grid (`--grid`). It logs
`no local sources in …: using the data pack …`, then builds the grid and the data from your client
and the pack's files, with your installed Forever's quest data when it finds it. Without Leffe's
maps (private) it runs the hybrid on the pack's saved Leffe walks (nav.md, "Without his maps: his
saved walks"). The report says which data sources the build ran on, so a
public-data route is never mistaken for the official build.

### `forge data pack` (maintainers)

```sh
forge data pack --out dist --walks-from out
```

- `--root DIR`: the checkout to pack from (default: the nearest folder above with `data/sources`).
- `--walks-from DIR`: a `forge build` output whose `walks/store-*.psbn` go in. Without it, no walk
  stores.
- `--grid DIR`: the grid those stores were built on (default `data/local/nav4`). Its content hash is
  recorded in the manifest. Set `POLESTAR_NAV_FP` to the walk model fingerprint of that build.

Build the `--walks-from` output with Leffe's maps (`--leffe`), so its `store-leffe-*.psbn` hold his
walks and each place's zone on his maps. Never pass his maps to the pack: they are private.

It writes `dist/polestar-data-pack.tar.gz`, a `.blake3` file
beside it, and the index `dist/polestar-data-pack.json`. The archives are deterministic: the same
files give the same bytes.

**The private-data guard.** Before writing any archive, `forge data pack` scans everything it gathered:

- every path against the spec's `never` list;
- the text of every file, and every text cell of every SQLite table, against `neverText`;
- every source column of the KB for a private source name.

If anything matches, it writes nothing and lists each hit
(`the pack holds private data; nothing written: …`). Fix the source of the hit. Do not loosen the
guard. The only exemption is the corrections' section files (`textScanExempt`): they are already public. The guard is
tested in `rust/crates/forge/tests/pack.rs`.

To add a file to the pack, add it to a source in `pack-spec.json` with its title, credit, licence and
URL. A file that is not under a source with a licence does not go in.

## The public database (forever-db)

`forever-db/` at the repository's root is Polestar's open quest database for World of Warcraft:
Forever: the values an independent source holds, in a clean schema of our own, without per-value
source names. It is self-contained (nothing in it names a path outside it), so it can move to a
repository of its own later. Its README is the contributor guide; this section is the
maintainer's.

| in forever-db/ | what | written by |
|---|---|---|
| `data/<table>.jsonl`, `schema/`, `datapackage.json`, `index.json`, `CHANGELOG.md`, `corrections/LEDGER.md` | the tables, their JSON Schemas, the package, version and coverage, the change log, the note-fix ledger | `forge data publish` (committed, never hand-edited) |
| `corrections/{quests,npcs,objects,items,mechanics}.json`, `corrections/notes.json` | the corrections and the note-fix records | contributors |
| `README.md`, `NOTICE.md`, `LICENSE` (GPL-3.0, the database), `LICENSE-CC-BY-4.0.txt` (our layer) | | maintainers (`publish` seeds them when absent and never overwrites them) |

Never committed: the private provenance sidecar (`data/local/publish/provenance.sqlite`, every
published value's sources), the zip and the sqlite file, and the library.

### Building it

```sh
forge data publish --out forever-db \
  --date 2026-10-23 --producer-commit "$(git rev-parse HEAD)"   # the maintainer's full build
forge data publish --check forever-db                           # the guard
```

- With the KB (`--kb`, default `data/local/kb/forever-kb.sqlite`) the values come from the KB under
  the independent-source rule; without one, from public data builds alone, with corrections applied
  only when their `source.kind` names an independent check.
- A re-run replaces only the generated files, and the same inputs give the same bytes: the version
  is `--version`, else the one already in the folder (`--previous DIR` gives the next one), the date
  is `--date` (or `SOURCE_DATE_EPOCH`), and `producerCommit` is `--producer-commit` (or
  `PRODUCER_COMMIT`, else forge's git HEAD). `CHANGELOG.md` keeps the earlier versions' sections.
- `index.json` and `CHANGELOG.md` give coverage. A field most entities lack is counted over the
  entities the full data knows one for: prerequisites over the known chain links, spawns over the
  NPCs and objects with a known spawn, drop sources over the items with a known dropper.
- `--zip` writes `forever-db-<version>.zip` beside the folder (the folder under `forever-db/`),
  `--sqlite FILE` the tables as one sqlite file, `--lua DIR` the library; `--from DIR` writes these
  from an existing release without rebuilding it.

### Step and note ids, and note fixes

Steps and notes are regenerated every release, so each row carries a stable id:
`<quest>:s:<h>` for a step, `<quest>:n:<h>` for a note, `h` the first 8 hex digits of the sha1 of the
row's identity: a step's action, its targets (type:id) and items, sorted, and its place's target; a
note's kind, the ids it names and its place's target. The text and the order are not part of it, so
a reworded or reordered row keeps its id; rows sharing an identity get `-2`, `-3` in generation order.

The release's steps come from the KB's steps today. `--notes quest-notes.json` (the rewritten
notes: per quest `steps` and `notes` with `basis` game-data or community) makes them come from that
file and adds `note.jsonl`; it is off until the notes' verify-and-trim pass is done.

`corrections/notes.json` holds the note-fix records, keyed by the id they fix: `set` (fact, basis,
place, count or kind; an optional `was` makes it conflict when the row changed since), `drop`,
`add` (a new row, its id from the same rule) or `promote: "game-data"`, each with
`source { kind, ref }` and a `note` in our own words. `publish` applies them after the tables and
writes `corrections/LEDGER.md`: applied, stale (the row is gone, or already says it: the record can
go) or conflicting. `publish --check` fails on a conflicting record and warns on a stale one.

### The library: LibForeverData

`forge data publish --from forever-db --lua <dir>` writes `<dir>/LibForeverData/`: a TOC for the
Forever client (Interface 16001) with the licences and credits, `Core.lua` with the read API, and
`Data/*.lua`. The API keeps LibDingDB's call shapes where they overlap: `Get(kind, id)` (a fresh
table, with LibDingDB's field names beside ours), `Name(kind, id)`, `Ids(kind)`; plus
`Spawns(kind, id)` in world yards, `ToUiMap(map, x, y)` (uiMapID and map percent, from the release's
map frames), `Quest(id)`, `Steps(questId)`, `Notes(questId)`, `.version`, `.clientBuild` and `.api`.

Records are text in long-string chunks of 500, decoded on first read into a weak cache; no table is
built per record at load, and spawn points take 11 characters each. The encoder and its Lua reader
are shared with Polestar's own data packs: `forge-core`'s `luachunks.rs` and `luachunks.lua`.
Measured on the 2026.10.1 release (Lua 5.1, the AddonSizeOptimisation method: two full collects
around the load): 3.6 MiB on disk, 3.6 MiB resident after loading, 5.5 MiB with 1,000 random
records held, 0.01 s to load. `tests/lua/libforeverdata_test.lua` checks a library against its
release's tables; `cargo test -p forge-data --test publish` runs it.

### Releases

- `data-vYYYY.MM.N` (`.github/workflows/data-release.yml`): the tag must equal `index.json`'s
  version; the guard runs, and `forever-db-<version>.zip` and `forever-db-<version>.sqlite.zst` are
  attached to a GitHub release.
- `lib-v<api>.<version>` (`.github/workflows/lib-release.yml`), for example `lib-v1.2026.10.1`: the
  library is generated from the committed folder, its Lua test runs, and
  `LibForeverData-<version>.zip` is attached.
- Polestar's own `v*` releases are unchanged and stay the repository's latest.
- A pull request that touches `forever-db/` runs `data-corrections.yml`: the edit's check, a public
  release from the base branch's corrections and from the pull request's, the guard on both, and the
  value diff as the job summary.

## What stays local, and why

| What | Where | Why |
|---|---|---|
| The game's files | your game folder | Blizzard's. Forge reads them in place and never copies them; `forge gamedata export` writes only the file you ask for. |
| `data/forever/` | your checkout (git-ignored) | built from your sources in seconds; too big and too derived to commit |
| `data/sources/` | your checkout (git-ignored) | caches of other people's data; credited and shared through the pack where the licence allows |
| The full KB, mechanics evidence, private captures and notes | `data/local/` | Some facts are checked against sources we may not share. They never leave your machine. When one of them settles a fact, the fact enters the repository as a correction in our own words, or as a KB fact. |
| The navigation grid | `data/local/nav4` | built from your own client's map tiles |
| Forever's quest data | your Forever client's AddOns | Questie and QuestieDB: no data licence stated; used with credit, with the Questie maintainers' agreement; read from your install |
| `dungeons.json` | `data/forever` | built from an installed addon with no licence; facts only, kept local |
| `codex/`, `gear/` | `data/forever` | addon side products built from installed addons; not route inputs |

Some local evidence is read only when `forge-data` is built with the `local-sources` feature, which is
off by default.

## What can go wrong

| Message or symptom | What it means | What to do |
|---|---|---|
| `no checkout (forever-db/corrections/quests.json) above the current folder; pass --root` | you ran `forge data build` outside a checkout | `cd` into the checkout, or pass `--root DIR` |
| the data build says it is building without Forever's quest data, or the report says the data was built without it | no Forever client with the quest data addon was found | install it, or pass `--questie <AddOns folder>`. Without it, quest facts are fewer; corrections still apply. |
| `warning: correction not applied: quests <id>: no such record, and the correction lacks …` | the build has no such record and the correction cannot stand alone | add the fields it names (`title`, `start`, `end`; or `name` and `addSpawns`), or check the id |
| `forge data check-corrections` reports errors | an edit to corrections, the public mechanics or the overrides is malformed or names a missing id | fix the entry at the JSON path it prints |
| stderr says the Forever tables come from the cached copies | no client found, or no table definitions in `data/sources/wowdbdefs` | set `POLESTAR_WOW_DIR` or pass `--wow`; get the definitions (`forge gamedata list` prints the clone command) |
| `no World of Warcraft folder found; pass --wow or set POLESTAR_WOW_DIR` | the search found no `.build.info` | pass `--wow` with the folder that holds `.build.info` |
| `--build …: the installed … is …` | you asked for a build that is not installed | use `--build auto`; the local storage holds only the installed build |
| `… not in the local storage (is the deDE text locale installed?)` | that text language is not installed | use `--locale enUS`, or install the language in the launcher |
| `section N: encrypted with TACT key …; K records skipped` | encrypted rows were skipped | nothing; this is expected |
| one table fails to decode, other tables are fine | the table definitions do not match this build | update `data/sources/wowdbdefs` |
| a value differs from what you see in game | a hotfix, a wrong source, or a merge choice | look at the record's `source` list in `data/forever`; with `--kb`, at its row in `forever-kb.sqlite` (`facts` and `alternatives`); then add a correction with a note |
| `warning: curated <Class> trainer "<name>" not found on map …` | a curated trainer is missing from `npcs.json` | check the NPC's spawns; add them with `addSpawns` |
| `warning: <dungeon>: quest … has no … position` (`forge data dungeons`) | the journal has no place for that quest | usually harmless; the quest is not in solo routes |
| `run forge data fetch (or pass --root <checkout>)` | no `data/sources` and no pack | fetch the pack, or point at a checkout with sources |
| `the data pack has no navigation grid (it is built from your own client) and no client … was found` | a pack build found no game client to build the grid from | pass `--wow <client>`, or `--grid <dir>` with a grid you built ([nav.md](nav.md)) |
| `…: not the published pack` | the download is incomplete or changed | fetch again; check `--url` and `POLESTAR_DATA_PACK_URL` |
| `…: in the pack but not in its manifest`, or a file's BLAKE3 differs | the unpacked pack does not match its manifest | fetch again; the old pack is untouched |
| `the pack holds private data; nothing written` | the guard found something private | remove it from the pack's sources; never exempt it |
| a quest you expect is not in a route | it may be skipped for `missing-info` | `forge sim skips --reason missing-info --dir out/routes`, then fix the data the row names |
