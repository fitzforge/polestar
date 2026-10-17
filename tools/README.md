# tools/

Polestar's toolchain: Node 24 or newer, no npm dependencies. Every command
runs through one entry point:

```sh
node tools/polestar.js help              # the list of commands
node tools/polestar.js help <command>    # one command's options
node tools/polestar.js <command> --help  # the same; -h too
```

Asking for help never runs a command: `--help` or `-h` anywhere after the
command name prints its usage and exits, so nothing is built, rendered,
downloaded or imported. `package.json` has one script, `npm test`; every
other command runs as `node tools/polestar.js <command>` (or `polestar
<command>` after `npm link`).

Some commands also need a Lua 5.1 interpreter (`play`, `playtest`,
`record import`, `travel route`); `node tools/polestar.js doctor` checks what
is installed. The contract the tools write to is in
[docs/ARCHITECTURE.md](../docs/ARCHITECTURE.md), "Toolchain".

## Commands

### Playing and previewing

| Command | What it does |
|---|---|
| `doctor` | Checks Node, Lua, the reference data, the AddOns folder and a pack's `pack.json` |
| `install` | Copies (or with `--link`, symlinks) the addons into the game's AddOns folder; given a guide pack, builds and installs that pack |
| `play` | The playground: the real addon in the browser against a simulated world |
| `planner` | The route planner: a guide played on the real map with its clock, XP and quest log, its walks routed on the navigation grid when `nav build` has built it (`--nav <dir>`), edited in place; it fetches the game icons its page shows from wago.tools as they are first asked for (cached in `data/local/planner/icons/`); `planner art` builds its map art, `planner mcp` serves its commands to AI agents |
| `preview` | Renders the guide window, the hub and the options to `docs/preview/*.svg` |

### Writing guides and packs

| Command | What it does |
|---|---|
| `new` | Starts a guide pack in a new folder from `tools/templates/pack` |
| `lint` | Checks a pack's `.guide` files without writing anything |
| `compile` | Compiles a pack into its addon folder (ours into `addon/Polestar_Guides`) |
| `dev` | Rebuilds a pack into the game, and optionally the playground, on every save |
| `playtest` | Plays a pack's guides to the end for every class they branch on |
| `find` | Looks up quests, NPCs, objects, items, inns, flight points and guides, printed as guide lines |
| `draft` | Drafts a leveling route (`.guide`) from the reference data |
| `record` | Recorder sessions: `import`, `watch`, `list`, `draft` a guide from one, `report` on recorded play |
| `sim` | The route simulator: `world`, `calibrate`, `run`, `robust`, `compare`, `bench`, `export`, `consensus` ([docs/SIMULATION.md](../docs/SIMULATION.md)) |

### Building data

These need the game client's tables, installed addons or other local
sources, so they run on a maintainer's machine, never in Polestar's CI. A
pack's CI (the template's `pack.yml`) runs
`data build --no-web-xp --no-wowhead`: pfQuest and the client tables,
without QuestieDB.

| Command | What it does |
|---|---|
| `data build` | Builds the reference data, `data/forever/*.json` |
| `dungeons build` | Imports dungeon data into `data/forever/dungeons.json` |
| `profession build` | Builds `data/forever/professions.json`; `profession draft <Profession>` drafts a 1-300 crafting guide; `profession gathering build` / `check` writes or checks the six generated gathering and secondary guides |
| `exploration build` / `exploration check` | Writes or checks the exploration guides in `guides/forever/exploration` |
| `trainers build` | Builds `data/forever/trainers.json` and `Core/ClassTrainers.lua` |
| `talents build` / `talents check` | Writes or checks `Talents/Builds.lua`: the plans in `talents/forever/` (one file per class) resolved by name on the Forever trait tree and replayed under its rules |
| `travel build` | Builds the travel network: `data/forever/travel.json`, `Nav/TravelData.lua` (with the boat, zeppelin, tram and lift timetables, walk-in portals and class teleports `Nav/Transit.lua` reads), the flights' tracks (`Maps/FlightPaths.lua`), `Polestar_Travel`; `travel route` runs the in-game planner between two points; `travel chain` drafts an approach chain from recorded walks |
| `nav build` / `nav path` | The navigation grid in `data/local/nav`: where a character can walk, climb, fall, swim and ride lifts, built from the Forever client's terrain, water and model collision (local only); `nav path` prints the route between two map points |
| `nav aids` | The arrow's zone crossings, open borders and approach chains generated from the navigation grid (`nav build`) into `data/local/nav/aids.json` (crossings schema); `--report` measures the arrow on every guide leg without and with them; `--lua <file>` writes a Crossings.lua for a local test |
| `maps build` / `maps overlays` | Zone level ranges (`Maps/ZoneLevels.lua`) / zone art overlays (`UI/ZoneArtOverlays.lua`) |
| `qol build` | Spirit healers, flight masters and reagent vendors (`QoL/Data.lua`) |
| `itemdb build` | The `Polestar_ItemDB` item stats (`Items.lua`) |
| `gear build` / `gear fetch` | Forever item stats, reward choices and stat weight bands / refresh the cached sims |
| `questdb build` | The `Polestar_QuestDB` data addon |
| `codex build` | Lookup's Codex: `data/forever/codex/*.json` and the `Polestar_Codex` data addon |
| `codex parity` | The release Codex against the last `--local-extras` build, per kind: `data/local/codex-parity.{json,md}` |
| `nav pack` | Polestar's walking maps of Eastern Kingdoms and Kalimdor from the navigation grid in Shortest Path Forever's map format, with the walk's chokepoints, into `addon/Polestar_Nav` (`Nav/Nav0*.lua`, `Nav/Nav1*.lua`, `Nav/Chokepoints.lua`, `PACK.json`, `Nav/Nav.xml`); `--cells` (default 128), `--date` (the headers' date: the same grid, cells and date give the same bytes), `--check` compares the folder with `PACK.json` |
| `nav vendor <checkout>` / `nav check` | `addon/Polestar_Nav` from a Shortest Path Forever checkout (Cillian Berragan's walking router and his map of Zephras Isle, GPL-3.0-or-later): `Routing/`, `Nav/Nav2991*.lua`, `UPSTREAM.json`, `Nav/Nav.xml` / checks the folder against `UPSTREAM.json` and `PACK.json` |
| `media` | Regenerates the addon's textures from `tools/media/*.js` |
| `readme brand` / `readme charts` | Redraws the README's art: the banners, emblem, logo, download and CurseForge buttons and the CurseForge avatar / the route charts (needs `data/sim`); both also export the CurseForge listing's PNGs when `rsvg-convert` is installed |

### Translating

| Command | What it does |
|---|---|
| `i18n` | The interface translations ([docs/TRANSLATING.md](../docs/TRANSLATING.md)): `status`, `check`, `sync`, `keys`, `import`; and `names`, the names addons `addon/Polestar_Names_<locale>` |

### Releasing

| Command | What it does |
|---|---|
| `version` | Shows, or sets, the version in `package.json`, `guides/pack.json` and every addon TOC |
| `pack` | Writes the release zips and `SHA256SUMS` to `dist/`; given a guide pack, that pack's zip |
| `changelog add` / `check` / `show` / `build <version>` | The changelog fragments in `changes/`: writes one from `--text` or stdin / checks every fragment (CI) / prints them as the release will / assembles them into CHANGELOG.md under `## <version> (<date>)` and deletes them; `--root` works on another checkout |
| `release scope` | Lists the paths since the last `vX.Y.Z` tag (or `--base`, or `--files -`) that a patch release may not carry; exit 1 when there are any. The `Base branch` check runs it on pull requests into `hotfix/` |
| `release patch <version> --root <checkout>` | A patch release's build in a `hotfix/` checkout, with that checkout's tools: scope, the last release's data addons back, version, lint, compile, and the compiled guides that changed |
| `release notes <version>` | Drafts the GitHub, CurseForge and Discord notes from the version's CHANGELOG.md section into `dist/` |

The release steps are in [docs/RELEASING.md](../docs/RELEASING.md).

## What is in tools/

| Path | What it is |
|---|---|
| `polestar.js` | The entry point: dispatches to `commands/<name>.js` |
| `commands/` | One module per command: `{ name, summary, usage, run }` |
| `lib/` | The library the commands share (below) |
| `media/` | Texture generators run by `media`: `nav.js`, `qol.js`, `ui.js`; the wordmark fonts in `media/fonts` |
| `preview/` | `preview`'s renderer: a geometry-recording client stub (`stub.lua`), font outlines, SVG drawing, and a zlib encoder of its own for the textures (`deflate.js`), so the renders are byte-identical on any Node |
| `play/` | The playground: server, Lua session, driver and the page in `play/public` |
| `planner/` | The route planner: server, workspace (packs, sources, edits, undo, lint), the command registry shared by HTTP, MCP and WebMCP, the MCP bridge, the walk routes on the navigation grid (`navpool.js`: worker pool, route cache, Walkable tiles) and the page in `planner/public` (WebGL2 map in `public/map`) |
| `readme/` | The README's art, drawn by `readme`: `brand.js` (banners, emblem, logo, download and CurseForge buttons, CurseForge avatar) with the wordmark outlines of `outline.js`, `charts.js` (route charts) and `png.js` (the listing's PNG copies, through `rsvg-convert`) |
| `templates/pack/` | What `new` copies into a new guide pack |
| `discord-bot/` | The bug bot, a service rather than a command: files the Discord #bugs forum's posts as GitHub issues and tells the threads when they are fixed or shipped; setup in [discord-bot/README.md](discord-bot/README.md) |

### tools/lib

| Path | What it is |
|---|---|
| `addons.js` | Finds World of Warcraft: Forever installs and their AddOns and WTF folders; every command that reads or writes them goes through it (`$WOW_FOREVER_ADDONS` first, then the detected clients, live first) |
| `cli.js` | The shared argument parser and diagnostics printer of the commands |
| `codex/` | `codex build`: the Codex JSON, the Dungeons journal and the `Polestar_Codex` writer |
| `consume/` | Readers for installed addons' data, all through one Lua reader, and for the sims' stat weights |
| `data/` | `data build`: sources, merging, spawns, races, the dungeon import; also the shared CSV and wago.tools loaders |
| `dsl/` | The guide compiler: lexer, parser, resolver, validation, emitter; project and pack layout; parsing a guide's class, race and faction conditions |
| `exploration/` | `exploration build`: the exploration guide generator |
| `find.js` | `find`'s search |
| `generated.js` | Writes or checks a command's generated files |
| `game/` | The game's rules, once for every tool: `xp.js` (XP to level, quest and kill XP, the client's QuestXP table) and `races.js` (races, classes and their mask bits) |
| `gear/` | `gear build`: Forever item stats, reward choices, weight bands |
| `i18n/` | `i18n`: the locales (`locales.js`), key extraction (`keys.js`), the format check (`check.js`), reading and editing locale files (`files.js`), the glossary (`glossary.js`, `glossary/<locale>.json`) and each locale's state (`project.js`), adapted from Ding! by Yendi; the names addons (`names.js`: DingDB's pin, the ids Polestar's data names, the merge with pfQuest's locale files and the emitted addons) |
| `itemdb/` | `itemdb build`: item stats from the client tables |
| `lua.js` | Runs Lua 5.1 for the tools (reading SavedVariables and other addons' data) |
| `maps/` | `maps build` (zone levels) and `maps overlays` |
| `nav/` | `nav build`: `geom/` reads the client's terrain, liquids and WMO/M2 collision per map tile; `grid/` rasterises them into walkable surfaces, walls, links (steps, slopes, falls, swims, lifts), regions and the per-tile graph; `path.js` snaps points and routes on it; `move.js` the movement profiles; `aids.js` and `arrow.js` the arrow's generated crossings and their measurement. `nav pack`: `pack.js` (a port of Shortest Path Forever's `gen_nav.py` and `pack_nav.py`) and `chokepoints.js`. `nav vendor`: `vendor.js`, the mechanical transform of Shortest Path Forever's router and maps, and the `UPSTREAM.json` check |
| `pack/` | The pack contract: which pack a command works on, `pack.json`, building a pack and the format constants |
| `paths.js` | The repository's folders (`ROOT`, `DATA` for `data/forever`, `SOURCES` for `data/sources`); every tool resolves paths from them |
| `planner/` | The route planner's library: `geo.js` (world and map coordinates), `timeline.js` (the playback clock, XP, quest log and track; walk legs and the hops between spawns through a route provider, flights along their taxi path points), `source.js` and `goalfmt.js` (structured edits of `.guide` text), `art/` (wago.tools CASC cache, BLP and BC1, the minimap pyramid and zone art) |
| `playtest.js` | The guide simulator behind `playtest` and `tests/guides.test.js` |
| `professions/` | `profession build` and `draft`; `gathering/` is the gathering and secondary profession guide generator behind `profession gathering` |
| `questdb/` | `questdb build`, and the spawn clustering the compiler also uses |
| `recording/` | `record`: import, watch, draft, report |
| `route/` | `draft`: the first-draft route planner and its geometry and tour helpers |
| `sim/` | The route simulator: world model, evaluation, search, calibration, export, baselines |
| `tga.js` | Draws textures in code and writes TGA files |
| `travel/` | `travel build`, `travel route` and `travel chain`: flights, transports, inns, paths, crossings |
| `zip.js` | A deterministic ZIP writer and reader for `pack` |

## Generated files

Every file a tool writes, with what it is built from. "Local" means
gitignored: it stays on the machine that built it. To tell whether a
committed file is stale, run its command again and look at `git status`: a
changed file was stale. The checks named in the last column do that for you
where they exist.

Every generated text file starts with the same line, a comment in the
file's language written by `header()` in `lib/generated.js`:
``Generated by `node tools/polestar.js <command>` from <sources>. Do not edit: rebuild with that command.``

| Output | Command | Inputs | In git | Staleness check |
|---|---|---|---|---|
| `data/forever/*.json` (quests, npcs, objects, items, zones, map-frames, factions, races, meta) | `data build` | pfQuest, QuestieDB from the installed client, client tables from wago.tools, `data/recordings/*.json`; cached in `data/sources/` | local | `meta.json` records the sources and when |
| `data/forever/spawnz.json` | `data build` | CMaNGOS classic-db's `creature` and `gameobject` spawns on maps 0 and 1 (the pinned dump, cached in `data/sources/cmangos/`, the rows kept as `spawnz.json` beside it); left out with one warning when `--offline` has no cached dump | local | `meta.json` records classic-db's revision; `compile` reads it for goal heights (`z`) and prints how many goals got one |
| `data/forever/dungeons.json` | `dungeons build` | the installed dungeon journal addon, `data/forever` | local | none |
| `data/forever/professions.json` | `profession build` | Forever client tables (Classic Era fills their gaps), `data/forever` items, npcs, objects | local | none |
| `data/forever/trainers.json` | `trainers build` | `train` goals under `guides/`, `data/recordings`, the curated list, `npcs.json` | local | none |
| `addon/Polestar/Core/ClassTrainers.lua` | `trainers build` | the same | yes | rerun |
| `addon/Polestar/Talents/Builds.lua` | `talents build` | `talents/forever/*.json`, Forever trait tables from wago.tools (build pinned in `tools/commands/talents.js`) | yes | `talents check`; `tests/talents-build.test.js` runs it when the tables are cached |
| `data/forever/travel.json` | `travel build` | client tables (Era and Forever), the newest cached Forever AreaTable (`data/sources/wago/`, the inns' areas), CMaNGOS classic-db (`data/sources/cmangos/`), `data/forever` map-frames, zones, npcs, objects, `data/recordings` | local | none |
| `addon/Polestar/Nav/TravelData.lua` | `travel build` | the same | yes | rerun; `tests/travel-build.test.js` loads the committed file; `tests/nav-transit.test.js` builds and loads the timetables |
| `addon/Polestar/Maps/FlightPaths.lua` | `travel build` | client TaxiPathNode | yes | rerun; `tests/nav-route-lines.test.js` loads the committed file |
| `addon/Polestar_Travel/` | `travel build` | the local crossings file `data/local/crossings.json` | local | `tests/travel-crossings.test.js` validates the crossings file |
| `addon/Polestar/Maps/ZoneLevels.lua` | `maps build` | `data/forever` npcs, zones | yes | `tests/maps-zonelevels.test.js` ("up to date") |
| `addon/Polestar/UI/ZoneArtOverlays.lua` | `maps overlays` | Forever client tables (wago.tools) | yes | rerun |
| `addon/Polestar/QoL/Data.lua` | `qol build` | `data/forever` npcs, map-frames | yes | rerun |
| `addon/Polestar_ItemDB/Items.lua`, its TOC | `itemdb build` | Classic Era client item tables | yes | rerun; `tests/itemdb.test.js` loads it within its size budget |
| `addon/Polestar_ItemDB/Forever.lua` and `LICENSE-DATA.txt`, `addon/Polestar/Gear/SpecData.lua` and `LICENSE-DATA.txt`; `data/forever/gear/report.json` | `gear build`, after `itemdb build` | the installed ForeverLevelingBiS, the sims cached in `data/sources/wowsims` (`gear fetch`) | yes; the report is local | rerun |
| `addon/Polestar_QuestDB/` | `questdb build` | `data/forever` quests, npcs, objects, items, map-frames | local; ships in the release zip when built | `tests/questdb.test.js` loads it within its budget |
| `data/forever/codex/*.json`, `addon/Polestar_Codex/` (with `LICENSE-DATA.txt`) | `codex build` | the installed ForeverLevelingBiS; `data/forever` including instances, trainers and professions; Forever and Era client tables; our guides. `--local-extras` adds AtlasLoot, RareScanner and `dungeons.json` (local-only) | local; always in the release zip (`pack` fails without a release-safe one) | `tests/lookup-codex.test.js` loads it in game |
| `addon/Polestar_Nav/Routing/`, `Nav/Nav2991*.lua`, `UPSTREAM.json` | `nav vendor <checkout>` | a git checkout of https://github.com/cjber/shortest-path-forever | yes (vendored; always in the release zip) | `nav check`; `tests/nav-vendor.test.js` |
| `addon/Polestar_Nav/Nav/Nav0*.lua`, `Nav1*.lua`, `Chokepoints.lua`, `PACK.json`, `Nav/Nav.xml` | `nav pack` | the navigation grid (`data/local/nav`, current tile version), its `aids.json` and `lifts.json`, `data/forever` map-frames and zones, the newest cached AreaTable | yes (always in the release zip) | `nav check` / `nav pack --check` (sha256 in `PACK.json`); its headers name the grid's client build and the date; rerun after `nav build` or `nav aids` |
| `guides/forever/exploration/*.guide` (7) | `exploration build` | client map tables, `data/forever` zones, map-frames, travel | yes | `exploration check`; `tests/exploration.test.js` |
| `guides/forever/professions/` mining, herbalism, skinning, cooking, first-aid, fishing | `profession gathering build` | `data/forever` professions, items, npcs, objects | yes | `profession gathering check`; `tests/profession-gathering.test.js` |
| `guides/forever/professions/` alchemy, blacksmithing, enchanting, engineering, leatherworking, tailoring | `profession draft <Profession> --out` | `data/forever` including professions | yes | rerun |
| `addon/Polestar_Guides/` | `compile` | `guides/**/*.guide`, `guides/pack.json`, `data/forever` (including trainers, travel, professions, factions, races; never `dungeons.json`), the newest cached Forever AreaTable in `data/sources/wago/` (place areas) | yes | rerun; `tests/guides-parse.test.js` fails when a guide is added, renamed or removed without `compile` |
| `addon/Polestar_Names_<locale>/` (9) | `i18n names` | DingDB pinned in `tools/lib/i18n/names.js` (cloned into `data/sources/ding`), pfQuest's `db/<locale>` (`data/sources/pfQuest`), the ids of `addon/Polestar_Guides/Guides.lua`, `addon/Polestar_QuestDB/` and `data/forever/codex/` | yes (always in the release zip) | rerun after `compile`, `questdb build` or `codex build` add ids; `tests/i18n-names.test.js` |
| `addon/Polestar/Media/Nav/*.tga`, `addon/Polestar/Media/UI/*.tga` | `media` | `tools/media/*.js`, `tools/lib/tga.js`, `tools/media/fonts` (no data) | yes | rerun: the output is byte-identical, and CI fails when it differs from the committed files; `tests/media-refs.test.js` checks the addon names every texture |
| `docs/preview/*.svg` | `preview` | the addon's Lua (Core, Theme, Nav, Quests, Gear, Maps, QoL, Lookup, Dungeons, Rares, UI), its generated files included; `tests/lua` (the client stubs, `stub_ui.lua`'s sample guides), `tests/fixtures`, among them six compiled Horde guides frozen in `tests/fixtures/preview/guides.lua`; no reference data and not the shipped `addon/Polestar_Guides`, so a guide recompile never changes the renders. `POLESTAR_CLIENT_ART` (with `POLESTAR_DUNGEONS_PACK`) renders local art and data into its own folder, never here | yes | rerun: the output is byte-identical, and CI fails when it differs from the committed files or a render is missing; a full run removes the renders of scenes that are gone |
| `docs/assets/{banner-dark,banner-light,emblem,logo,download,curseforge,avatar}.svg` | `readme brand` | the emblem geometry, the wordmark fonts, the CurseForge mark | yes | rerun |
| `docs/curseforge/images/{logo-1024,logo-400,banner,starts,levels}.png` | `readme brand` (all five), `readme charts` (the charts), with `rsvg-convert` (librsvg) installed; without it they print the `rsvg-convert` commands to run | `docs/assets/avatar.svg`, `banner-dark.svg`, `charts/{starts,levels}.svg` | yes | rerun |
| `docs/assets/charts/{levels,starts}.svg` | `readme charts --draft v0.1.0` | `data/sim`, `guides/`, the guides of the first release (tag `v0.1.0`) | yes | rerun |
| `data/sim/` | `sim world`, `sim run` and the other `sim` commands | `data/forever` | local | `lint` notes a cached world built from other data and skips its check |
| `data/local/planner/art/` (`index.json`, BC1 terrain tiles, zone PNGs) | `planner art` | the Forever client's minimap blocks and world map art (files by fileDataID from wago.tools, cached in `data/sources/casc/<product>/<build>/`), its Map, UiMap and map art tables, `data/forever` map-frames | local, never distributed | `index.json` records the client build; rerun after a new build |
| `data/local/planner/icons/` (`<kind>/<key>.png`, `.miss` markers, `paths.json`) | `planner` (the icons its page asks for) | the Forever client's icon and UI textures (files by fileDataID from wago.tools, cached in `data/sources/casc/<product>/<build>/`), its Item, SpellMisc, SkillLine and ChrClasses tables (`data/sources/wago/<build>/`), wago.tools' file name search | local, never distributed | none; delete the folder to fetch again after a new client build |
| `data/local/nav/` (`index.json`, `lifts.json`, `tiles/<c>/<col>_<row>.nav.gz`, `.walls.gz` and `.hpa.gz` (the tile's part of the abstract graph, a build cache), `graph/<c>.bin.gz`) | `nav build` | the Forever client's map tiles (root and obj0 ADTs), WMO and M2 models, Map, LiquidType, LiquidMaterial, LiquidObject and TransportAnimation tables (files by fileDataID from wago.tools, cached in `data/sources/casc/` and `data/sources/wago/`), `data/forever` objects (elevators), map-frames | local, never distributed | `index.json` records the client build and the build time; rerun after a new client build |
| `data/local/nav/routes-<build>.jsonl` | `planner` (walks it routes) | the navigation grid of `nav build` and the route code (`tools/lib/nav`) | local | the file name holds the grid's build id (a hash of its `index.json`, `lifts.json` and the route code): a rebuilt grid or changed costs start a new file; old ones can be deleted |
| `data/local/nav/aids.json`, `aids-report.json`, `aids-report.md` | `nav aids` (`--report` for the report) | the navigation grid, `data/forever` zones, quests, npcs, objects, trainers, travel; the AreaTable of the grid's client build (`data/sources/wago/<build>/`); `guides/`; `tools/lib/codex/entrances.json`; the reference `data/local/crossings.json` (compared, never changed) | local, never distributed | `build` in the file names the grid's client build; rerun after `nav build` |
| `data/recordings/*.json` | `record import` / `record watch` | the Recorder's SavedVariables | local | none |
| `dist/` | `pack` | `addon/`, `guides/` | local | none |

## Rebuild order after a data change

Each step reads only the data the steps above it wrote. After a new client
build, new recordings or a change to an installed source addon:

1. `node tools/polestar.js data build`
2. `node tools/polestar.js dungeons build`
3. `node tools/polestar.js profession build`
4. `node tools/polestar.js trainers build` (and `talents build` after a new client build)
5. `node tools/polestar.js travel build`
6. `node tools/polestar.js maps build` and `node tools/polestar.js maps overlays`
7. `node tools/polestar.js qol build`
8. `node tools/polestar.js itemdb build`, then `node tools/polestar.js gear build`
9. `node tools/polestar.js questdb build`
10. `node tools/polestar.js codex build` (reads `professions.json`, `trainers.json` and the recorded `instances.json`; `dungeons.json` only with `--local-extras`)
11. The generated guides: `node tools/polestar.js exploration build` (reads `travel.json`), `node tools/polestar.js profession gathering build` and `node tools/polestar.js profession draft <Profession> --out` for each crafting profession (read `professions.json`)
12. `node tools/polestar.js lint`, then `node tools/polestar.js compile`
13. `node tools/polestar.js preview`: it reads no reference data and no compiled guides, but the addon Lua that steps 4 to 8 write is part of what it draws

`maps overlays`, `itemdb build` and `media` read no reference data: they
only need rerunning when the client's tables or `tools/media` change. The
README charts need a simulator run (`data/sim`) on the new data first.
