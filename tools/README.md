# tools/

Polestar's toolchain: Node 24 or newer, with no npm dependencies. Every command
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
`travel route`); `node tools/polestar.js doctor` checks what
is installed. The contract the tools write to is in
[docs/ARCHITECTURE.md](../docs/ARCHITECTURE.md), "Toolchain".

## Commands

### Playing and previewing

| Command | What it does |
|---|---|
| `doctor` | Checks Node, Lua, the reference data, the AddOns folder and a pack's `pack.json` |
| `install` | Copies (or with `--link`, symlinks) the addons into the game's AddOns folder; given a pack, builds and installs its community addon |
| `play` | The playground: the real addon in the browser against a simulated world |
| `planner` | The route planner: a guide played on the real map with its clock, XP and quest log, its walks routed on the navigation grid when `nav build` has built it (`--nav <dir>`), edited in place; it fetches the game icons its page shows from wago.tools as they are first asked for (cached in `data/local/planner/icons/`); `planner art` builds its map art, `planner mcp` serves its commands to AI agents |
| `preview` | Renders the guide window, the hub and the options to `docs/preview/*.svg` |

### Writing guides and packs

| Command | What it does |
|---|---|
| `new` | Starts a pack (the source of a community addon) in a new folder from `tools/templates/pack` |
| `lint`, `compile` | Moved to forge: `forge guide lint` checks a pack's `.guide` files without writing anything, `forge guide compile` compiles a pack into its addon folder (ours into `addon/Polestar_Guides`); the old commands print the forge command and exit 2 |
| `export` | Prints one community guide as an import string (lints its pack first) |
| `dev` | Rebuilds a pack into the game, and optionally the playground, on every save |
| `playtest` | Plays a pack's guides to the end for every class they branch on; `--honest` plays them from their lines and the data only, with nothing free |
| `guidecheck` | Moved to forge: `forge guide check <dir>` reads written guides as a player would and gives a repair for each line that lacks what it needs (`--fix` writes them); `polestar guidecheck` prints the forge command and exits 2 |
| `find` | Looks up quests, NPCs, objects, items, inns, flight points and guides, printed as guide lines |
| `draft` | Drafts a leveling route (`.guide`) from the reference data |
| `record` | Recorded sessions (from `forge record import` / `forge record pull`): `list`, `draft` a guide from one, `trail`, `report` on recorded play |
| `sim` | `sim compare`: score a pack's or Polestar's chain under the earlier JS route model; every other `sim` subcommand was retired for Forge (`forge sim`, `forge walks`, `forge build`; [docs/FORGE.md](../docs/FORGE.md)) and prints its replacement ([docs/legacy/SIMULATION-js.md](../docs/legacy/SIMULATION-js.md)) |

### Building data

These need the game client's tables, installed addons or other local
sources, so they run on a maintainer's machine, never in Polestar's CI. A
pack's CI (the template's `pack.yml`) runs
`forge data build --no-web-xp --no-web-zones`: pfQuest and the client tables,
without QuestieDB. The data builders themselves moved to forge
([docs/forge/data.md](../docs/forge/data.md)); the retired commands below print their forge
command and exit 2.

| Command | What it does |
|---|---|
| `data build`, `data check` | Moved to forge: `forge data build` builds the reference data, `data/forever/*.json` (`forge data sources` fills `data/sources` first), behind the statistics gate `forge data check` reruns |
| `dungeons build` | Moved to forge: `forge data dungeons` imports dungeon data into `data/forever/dungeons.json` |
| `profession build` / `draft` / `gathering` | `profession build` moved to forge (`forge data professions`: `data/forever/professions.json`); `profession draft <Profession>` drafts a 1-300 crafting guide; `profession gathering build` / `check` writes or checks the six generated gathering and secondary guides |
| `exploration build` / `exploration check` | Writes or checks the exploration guides in `guides/forever/exploration` |
| `trainers build` | Moved to forge: `forge data trainers` builds `data/forever/trainers.json` and `Core/ClassTrainers.lua` |
| `talents build` / `talents check` | Moved to forge: `forge data talents build` / `check` writes or checks `Talents/Builds.lua`: the plans in `talents/forever/` (one file per class) resolved by name on the Forever trait tree and replayed under its rules |
| `travel build` | Builds the travel network: `data/forever/travel.json`, `Nav/TravelData.lua` (with the boat, zeppelin, tram and lift timetables, walk-in portals and class teleports `Nav/Transit.lua` reads), the flights' tracks (`Maps/FlightPaths.lua`), `Polestar_Travel`; `travel route` runs the in-game planner between two points; `travel chain` drafts an approach chain from recorded walks |
| `nav build` / `nav path` | The navigation grid in `data/local/nav`: where a character can walk, climb, fall, swim and ride lifts, built from the Forever client's terrain, water and model collision (local only); `nav path` prints the route between two map points |
| `nav aids` | The arrow's zone crossings, open borders and approach chains generated from the navigation grid (`nav build`; `--dir` another grid) into `aids.json` in the grid's folder (`data/local/nav/aids.json` by default, `--out` another file; crossings schema); `--report` measures the arrow on every guide leg without and with them; `--lua <file>` writes a Crossings.lua for a local test |
| `nav layers roads` / `nav layers hubs` | Moved to forge: `forge nav layers roads` (the roads layer in `data/local/nav-layers/roads`, from the client's tex0 ADTs and the allowlist `data/road-textures.json`) / `forge nav layers hubs` (the hostile hubs layer `data/local/nav-layers/hubs.json`); see [docs/forge/nav.md](../docs/forge/nav.md#the-ground-layers-forge-nav-layers) |
| `maps build` / `maps overlays` | Moved to forge: `forge data maps build` / `overlays`: zone level ranges (`Maps/ZoneLevels.lua`) / zone art overlays (`UI/ZoneArtOverlays.lua`) |
| `qol build` | Spirit healers, flight masters and reagent vendors (`QoL/Data.lua`) |
| `itemdb build` | Moved to forge: `forge data itemdb` writes the `Polestar_ItemDB` item stats (`Items.lua`) |
| `gear fetch` | Refreshes the cached sims; `gear build` moved to forge (`forge data gear`: Forever item stats, reward choices and stat weight bands) |
| `questdb build` | Retired: `forge data questdb` writes the `Polestar_QuestDB` data addon |
| `codex build` | Moved to forge: `forge data codex` writes `data/forever/codex/*.json` and the `Polestar_Codex` data addon; with `--local-extras`, the Codex with this machine's local-only extras in `data/local/codex-extras` |
| `codex parity` | The release Codex against the last `--local-extras` build, per kind: `data/local/codex-parity.{json,md}` |
| `nav pack` / `nav check` | Moved to forge: `forge nav pack` writes Polestar's walking maps into `addon/Polestar_Nav`, `forge nav check` holds them to `PACK.json`; see [docs/forge/nav.md](../docs/forge/nav.md#the-walking-maps-forge-nav-pack-forge-nav-check) |
| `nav eval` | The walking router run standalone on a folder's maps (`--nav`, default `addon/Polestar_Nav`): the route corpus with each route's metrics and expectations, `--sweep` the guide goals per zone and side, `--baseline` another folder or report with the acceptance checks A1-A8, `--style fastest\|balanced\|roads` (default balanced) the route style every search is priced in (the summary line names it), `--out` the whole report |
| `media` | Regenerates the addon's textures from `tools/media/*.js` |
| `readme brand` / `readme charts` | Redraws the README's art: the banners, emblem, logo, download and CurseForge buttons and the CurseForge avatar / the route charts (needs `data/sim`); both also export the CurseForge listing's PNGs when `rsvg-convert` is installed |

### Translating

| Command | What it does |
|---|---|
| `i18n` | `fit`, translated text the windows cut ([docs/TRANSLATING.md](../docs/TRANSLATING.md)); `status`, `check`, `sync`, `keys`, `import`, `leaks` and `guides` are `forge i18n`, `names` is `forge data names` (each prints that and exits 2) |

### Releasing

Building and releasing the addon moved to Forge: `forge release version|pack|notes|credits` and
`forge changelog add|check|show|build` ([docs/forge/release.md](../docs/forge/release.md)); the old
`version`, `pack`, `changelog`, `release` and `credits` commands print the forge command and exit 2.
`forge release pack` also writes a community pack's zip, given the pack folder.

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
| `templates/pack/` | What `new` copies into a new pack |
| `discord-bot/` | The bug bot, a service rather than a command: files the Discord #bugs forum's posts as GitHub issues and tells the threads when a fix opens, and when they are fixed or shipped; lists each issue's pull requests on the issue (`links.js`); setup in [discord-bot/README.md](discord-bot/README.md) |

### tools/lib

| Path | What it is |
|---|---|
| `addons.js` | Finds World of Warcraft: Forever installs and their AddOns and WTF folders; every command that reads or writes them goes through it (`$WOW_FOREVER_ADDONS` first, then the detected clients, live first) |
| `cli.js` | The shared argument parser and diagnostics printer of the commands |
| `codex/` | `codex parity` and `attune`, and the JS tests still on them: the Codex JSON, the Dungeons journal and the `Polestar_Codex` writer |
| `consume/` | Readers for installed addons' data, all through one Lua reader, and for the sims' stat weights |
| `data/` | What the JS tools still read of the data build (its port is `rust/crates/forge-data`): areas, corrections, prereqs, recordings and spawns, pfQuest and the shared CSV and wago.tools loaders |
| `dsl/` | The guide compiler: lexer, parser, resolver, validation, emitter; project and pack layout; parsing a guide's class, race and faction conditions |
| `exploration/` | `exploration build`: the exploration guide generator |
| `find.js` | `find`'s search |
| `generated.js` | Writes or checks a command's generated files |
| `game/` | The game's rules, once for every tool: `xp.js` (XP to level, quest and kill XP, the client's QuestXP table) and `races.js` (races, classes and their mask bits) |
| `i18n/` | What the JS tools still read (the rest is `forge i18n`, rust/crates/forge-i18n): the locales (`locales.js`), the AddOns-list texts (`toc.js`), reading locale files (`files.js`, with `keys.js`'s tokenizer), a pack's guide texts for the JS compiler (`guides.js`), adapted from Ding! by Yendi; `names.js`: the names addons' folder prefix, the same-as-English file and the ids Polestar's data names (`forge data names` builds the addons) |
| `lua.js` | Runs Lua 5.1 for the tools (reading SavedVariables and other addons' data) |
| `maps/` | The zone level heuristic the sim reads and the overlay builder the planner's art reads (`forge data maps` writes the addon files) |
| `nav/` | `nav build`: `geom/` reads the client's terrain, liquids and WMO/M2 collision per map tile; `grid/` rasterises them into walkable surfaces, walls, links (steps, slopes, falls, swims, lifts), regions and the per-tile graph; `path.js` snaps points and routes on it; `move.js` the movement profiles; `aids.js` and `arrow.js` the arrow's generated crossings and their measurement. `nav pack`: `pack.js` (maps format 2: ground classes and per-faction graph costs, grown from a port of Shortest Path Forever's `gen_nav.py` and `pack_nav.py`), `costs.js` (the router's `Costs.lua` table), `roadmask.js` (the road columns) and `chokepoints.js`; `nav check`: `pack.js` `checkPack`, the maps against `PACK.json`. `nav layers`: `layers/` (`tex0.js` the terrain's texture layers and alpha maps, `listfile.js` the community listfile, `roads.js` the roads layer, `hubs.js` the hostile hubs layer) |
| `pack/` | The pack contract: which pack a command works on, `pack.json`, building a pack and the format constants |
| `paths.js` | The repository's folders (`ROOT`, `DATA` for `data/forever`, `SOURCES` for `data/sources`); every tool resolves paths from them |
| `planner/` | The route planner's library: `geo.js` (world and map coordinates), `timeline.js` (the playback clock, XP, quest log and track; walk legs and the hops between spawns through a route provider, flights along their taxi path points), `source.js` and `goalfmt.js` (structured edits of `.guide` text), `art/` (wago.tools CASC cache, BLP and BC1, the minimap pyramid and zone art) |
| `playtest.js` | The guide simulator behind `playtest` and `tests/guides.test.js`; `playtest-honest.js` is `playtest --honest` |
| `professions/` | `profession draft` (and the client-table reader its tests and `exploration` use); `gathering/` is the gathering and secondary profession guide generator behind `profession gathering` |
| `questdb/` | The spawn clustering the route tools use (`cluster.js`); the database is `forge data questdb` |
| `recording/` | `record`: draft, trail, report |
| `route/` | `draft`: the first-draft route planner and its geometry and tour helpers |
| `sim/` | The earlier route model behind `sim compare`, `readme charts` and `lint`'s solo filter: world model, walks reader, evaluation, baselines |
| `tga.js` | Draws textures in code and writes TGA files |
| `travel/` | `travel build`, `travel route` and `travel chain`: flights, transports, inns, paths, crossings |

## Generated files

Every file a tool writes, with what it is built from. "Local" means
gitignored: it stays on the machine that built it. To tell whether a
committed file is stale, run its command again and look at `git status`: a
changed file was stale. The checks named in the last column do that for you
where they exist.

Every generated text file starts with the same line, a comment in the
file's language written by `header()` in `lib/generated.js` (forge's: `forge_guide::emit::header`):
``Generated by `node tools/polestar.js <command>` from <sources>. Do not edit: rebuild with that command.``,
or `` Generated by `forge <command>` `` for the files forge writes.

| Output | Command | Inputs | In git | Staleness check |
|---|---|---|---|---|
| `data/forever/*.json` (quests, npcs, objects, items, zones, map-frames, factions, races, meta) | `forge data build` | pfQuest, QuestieDB from the installed client, client tables from wago.tools, CMaNGOS classic-db's `quest_template` objective counts (kept as `quest_counts.json` beside the dump in `data/sources/cmangos/`), `data/recordings/*.json`; cached in `data/sources/` | local | `meta.json` records the sources and when |
| `data/forever/spawnz.json` | `forge data build` | CMaNGOS classic-db's `creature` and `gameobject` spawns on maps 0 and 1 (the pinned dump, cached in `data/sources/cmangos/`, the rows kept as `spawnz.json` beside it); left out with one warning when `--offline` has no cached dump | local | `meta.json` records classic-db's revision; `compile` reads it for the heights (`z`) of NPC and object goals, their spawn spots and smart targets' candidates, and prints how many of each got one; `trainers build` for the class trainers' |
| `data/forever/training.json` | `forge data build` | CMaNGOS classic-db's class spell costs (the pinned dump, cached in `data/sources/cmangos/`, kept as `training.json` beside it); left out with one warning when classic-db is unavailable | local | the simulator's class training costs per level (`world.training`) |
| `data/forever/dungeons.json` | `forge data dungeons` | the installed dungeon journal addon, `data/forever` | local | none |
| `data/forever/professions.json` | `forge data professions` | Forever client tables (Classic Era fills their gaps), `data/forever` items, npcs, objects | local | none |
| `data/forever/trainers.json` | `forge data trainers` | `train` goals under `guides/`, `data/recordings`, the curated list, `npcs.json` | local | none |
| `addon/Polestar/Core/ClassTrainers.lua` | `forge data trainers` | the same, and `data/forever/spawnz.json` for each trainer's height | yes | rerun |
| `addon/Polestar/Talents/Builds.lua` | `forge data talents build` | `talents/forever/*.json`, Forever trait tables from wago.tools (build pinned in `rust/crates/forge-data/src/talents.rs`) | yes | `forge data talents check`; forge-data's talents tests run it when the tables are cached |
| `data/forever/travel.json` | `travel build` | client tables (Era and Forever), the newest cached Forever AreaTable (`data/sources/wago/`, the inns' areas), CMaNGOS classic-db (`data/sources/cmangos/`), `data/forever` map-frames, zones, npcs, objects, spawnz (the dock NPCs' heights), `data/recordings`, the navigation grid (`data/local/nav4`: the ends' board points and heights) | local | none |
| `addon/Polestar/Nav/TravelData.lua` | `travel build` | the same | yes | rerun; `tests/travel-build.test.js` loads the committed file; `tests/nav-transit.test.js` builds and loads the timetables |
| `addon/Polestar/Maps/FlightPaths.lua` | `travel build` | client TaxiPathNode | yes | rerun; `rust/crates/forge-addontest/tests/addontest/nav-route-lines.rs` loads the committed file |
| `addon/Polestar_Travel/` | `travel build` | the local crossings file `data/local/crossings.json` | local | `tests/travel-crossings.test.js` validates the crossings file |
| `addon/Polestar/Maps/ZoneLevels.lua` | `forge data maps build` | `data/forever` npcs, zones, map-frames | yes | forge-data's zonelevels tests ("up to date", with the data) |
| `addon/Polestar/UI/ZoneArtOverlays.lua` | `forge data maps overlays` | Forever client tables (wago.tools) | yes | rerun |
| `addon/Polestar/QoL/Data.lua` | `qol build` | `data/forever` npcs, map-frames | yes | rerun |
| `addon/Polestar_ItemDB/Items.lua`, its TOC | `forge data itemdb` | Classic Era client item tables | yes | rerun; forge-addontest's data-addons test loads it within its size budget |
| `addon/Polestar_ItemDB/Forever.lua` and `LICENSE-DATA.txt`, `addon/Polestar/Gear/SpecData.lua` and `LICENSE-DATA.txt`; `data/forever/gear/report.json` | `forge data gear`, after `forge data itemdb` | the installed ForeverLevelingBiS, the sims cached in `data/sources/wowsims` (`gear fetch`) | yes; the report is local | rerun |
| `addon/Polestar_QuestDB/` | `forge data questdb` | `data/forever` quests, npcs, objects, items, map-frames | local; ships in the release zip when built | forge-addontest `questdb-memory` loads it within its budget |
| `data/forever/codex/*.json`, `addon/Polestar_Codex/` (with `LICENSE-DATA.txt`) | `forge data codex` (`--local-extras` for the local extras) | the installed ForeverLevelingBiS; `data/forever` including instances, trainers and professions; Forever and Era client tables; our guides. `--local-extras` adds AtlasLoot, RareScanner and `dungeons.json` (local-only) | local; always in the release zip (`pack` fails without a release-safe one) | `rust/crates/forge-addontest/tests/addontest/lookup-codex.rs` loads it in game |
| `addon/Polestar_Nav/Nav/Nav0*.lua`, `Nav1*.lua`, `Nav2991*.lua`, `Chokepoints.lua`, `PACK.json`, `Nav/Nav.xml` | `forge nav pack` | the navigation grid (`data/local/nav4`, tile version 4 for the slope classes), its `aids.json` and `lifts.json`, the roads and hubs layers (`data/local/nav-layers`), `data/forever` map-frames and zones, the newest cached AreaTable | yes (always in the release zip) | `nav check` / `nav pack --check` (sha256 in `PACK.json`); its headers name the grid's client build and the date; rerun after `nav build`, `nav aids` or `nav layers` |
| `guides/forever/exploration/*.guide` (7) | `exploration build` | client map tables, `data/forever` zones, map-frames, travel | yes | `exploration check`; `tests/exploration.test.js` |
| `guides/forever/professions/` mining, herbalism, skinning, cooking, first-aid, fishing | `profession gathering build` | `data/forever` professions, items, npcs, objects | yes | `profession gathering check`; `tests/profession-gathering.test.js` |
| `guides/forever/professions/` alchemy, blacksmithing, enchanting, engineering, leatherworking, tailoring | `profession draft <Profession> --out` | `data/forever` including professions | yes | rerun |
| `addon/Polestar_Guides/`, `addon/Polestar_<locale>/Texts.lua` (9) | `forge guide compile` | `guides/**/*.guide`, `guides/pack.json`, `guides/locales/`, `data/forever` (including trainers, travel, professions, factions, races; never `dungeons.json`), the newest cached Forever AreaTable in `data/sources/wago/` (place areas) | yes | rerun; `tests/guides-parse.test.js` fails when a guide is added, renamed or removed without `forge guide compile` |
| `addon/Polestar_<locale>/Names.lua` (9, with `LICENSE-DATA.txt`, `CREDITS.md`; the folder's TOC is written alike by both commands) | `forge data names` | DingDB pinned in `rust/crates/forge-data/src/names_sources.rs` (cloned into `data/sources/ding`), pfQuest's `db/<locale>` (`data/sources/pfQuest`), the ids of `addon/Polestar_Guides/Guides.lua`, `addon/Polestar_QuestDB/` and `data/forever/codex/` | yes (always in the release zip) | rerun after `compile`, `forge data questdb` or `forge data codex` add ids; forge-data's `names` test |
| `addon/Polestar/Media/Nav/*.tga`, `addon/Polestar/Media/UI/*.tga` | `media` | `tools/media/*.js`, `tools/lib/tga.js`, `tools/media/fonts` (no data) | yes | rerun: the output is byte-identical; CI checks that it builds; `tests/media-refs.test.js` checks the addon names every texture |
| `docs/preview/*.svg` | `preview` | the addon's Lua (Core, Theme, Nav, Quests, Gear, Maps, QoL, Lookup, Dungeons, Rares, UI), its generated files included; `tests/lua` (the client stubs, `stub_ui.lua`'s sample guides), `tests/fixtures`, among them six compiled Horde guides frozen in `tests/fixtures/preview/guides.lua`; no reference data and not the shipped `addon/Polestar_Guides`, so a guide recompile never changes the renders. `POLESTAR_CLIENT_ART` (with `POLESTAR_DUNGEONS_PACK`) renders local art and data into its own folder, never here | yes | rerun: the output is byte-identical; CI checks that it builds; a full run removes the renders of scenes that are gone |
| `addon/Polestar/Core/Credits.lua` | `forge release credits` | `data/credits.json`, the repository's merged pull requests (GitHub, `gh` logged in) | yes | rerun before a release |
| `docs/assets/{banner-dark,banner-light,emblem,logo,download,curseforge,avatar}.svg` | `readme brand` | the emblem geometry, the wordmark fonts, the CurseForge mark | yes | rerun |
| `docs/curseforge/images/{logo-1024,logo-400,banner,starts,levels}.png` | `readme brand` (all five), `readme charts` (the charts), with `rsvg-convert` (librsvg) installed; without it they print the `rsvg-convert` commands to run | `docs/assets/avatar.svg`, `banner-dark.svg`, `charts/{starts,levels}.svg` | yes | rerun |
| `docs/assets/charts/{levels,starts}.svg` | `readme charts --draft v0.1.0` | `data/sim`, `guides/`, the guides of the first release (tag `v0.1.0`) | yes | rerun |
| `data/sim/` | `forge walks world` / `forge walks walks` (world, walks) and `forge sim calibrate` (params.json) | `data/forever` | local | `lint` notes a cached world built from other data and skips its check |
| `data/rules.json` | none: hand-maintained data, not generated | game facts players reported (timers, gates, purchases, patrols, rides), each with its source refs and credit ([docs/legacy/SIMULATION-js.md](../docs/legacy/SIMULATION-js.md) "Rules") | yes | `tests/sim-rules.test.js` checks every rule's shape, and checks the rules against each faction's world when built; forge reads the file |
| `tests/fixtures/sim/cases/reported.json` | none: hand-maintained data, not generated | every reported route problem as a property of a route, with its source refs and credit ([docs/legacy/SIMULATION-js.md](../docs/legacy/SIMULATION-js.md) "Acceptance cases") | yes | `rust/crates/forge-judge/tests/cases_parity.rs` loads it and runs every case |
| `data/local/planner/art/` (`index.json`, BC1 terrain tiles, zone PNGs) | `planner art` | the Forever client's minimap blocks and world map art (files by fileDataID from wago.tools, cached in `data/sources/casc/<product>/<build>/`), its Map, UiMap and map art tables, `data/forever` map-frames | local, never distributed | `index.json` records the client build; rerun after a new build |
| `data/local/planner/icons/` (`<kind>/<key>.png`, `.miss` markers, `paths.json`) | `planner` (the icons its page asks for) | the Forever client's icon and UI textures (files by fileDataID from wago.tools, cached in `data/sources/casc/<product>/<build>/`), its Item, SpellMisc, SkillLine and ChrClasses tables (`data/sources/wago/<build>/`), wago.tools' file name search | local, never distributed | none; delete the folder to fetch again after a new client build |
| `data/local/nav/` (`index.json`, `lifts.json`, `tiles/<c>/<col>_<row>.nav.gz`, `.walls.gz` and `.hpa.gz` (the tile's part of the abstract graph, a build cache), `graph/<c>.bin.gz`) | `nav build` | the Forever client's map tiles (root and obj0 ADTs), WMO and M2 models, Map, LiquidType, LiquidMaterial, LiquidObject and TransportAnimation tables (files by fileDataID from wago.tools, cached in `data/sources/casc/` and `data/sources/wago/`), `data/forever` objects (elevators), map-frames | local, never distributed | `index.json` records the client build and the build time; rerun after a new client build |
| `data/local/nav/routes-<build>.jsonl` | `planner` (walks it routes) | the navigation grid of `nav build` and the route code (`tools/lib/nav`) | local | the file name holds the grid's build id (a hash of its `index.json`, `lifts.json` and the route code): a rebuilt grid or changed costs start a new file; old ones can be deleted |
| `data/local/nav/aids.json`, `aids-report.json`, `aids-report.md` (in the `--dir` grid's folder when given) | `nav aids` (`--report` for the report) | the navigation grid, `data/forever` zones, quests, npcs, objects, trainers, travel; the AreaTable of the grid's client build (`data/sources/wago/<build>/`); `guides/`; `data/codex/entrances.json`; the reference `data/local/crossings.json` (compared, never changed) | local, never distributed | `build` in the file names the grid's client build; rerun after `nav build` |
| `data/local/nav-layers/roads/` (`index.json`, `<c>/<col>_<row>.bin`: one byte per grid column) | `forge nav layers roads` | the Forever client's tex0 ADTs and WDTs (files by fileDataID from wago.tools, cached in `data/sources/casc/`), the Map table, the community listfile (`data/sources/listfile/`), `data/road-textures.json` | local, never distributed | `index.json` records the client build; rerun after a new client build or an allowlist change |
| `data/local/nav-layers/hubs.json` | `forge nav layers hubs` | CMaNGOS classic-db's `creature` spawns (`spawnz.json`) and `creature_template` rows (kept as `creature_template.json` beside the dump in `data/sources/cmangos/`), the FactionTemplate and AreaTable of the grid's client build (`data/sources/wago/<build>/`), the grid's area ids (`data/local/nav4`) | local, never distributed | the file records the client build and classic-db's revision; rerun after a new client build or grid |
| `data/recordings/*.json` (and `raw/<install>/<seq>.txt`, `.pull-state.json`) | `forge record import` / `forge record pull` | the Recorder's SavedVariables, or the recording server's export | local | none |
| `dist/` | `forge release pack` | `addon/`, `guides/` | local | none |

## Rebuild order after a data change

Each step reads only the data the steps above it wrote. After a new client
build, new recordings or a change to an installed source addon:

1. `forge data build --kb` (it fills `data/sources` first: `forge data sources`; `--offline` skips that)
2. `forge data dungeons`
3. `forge data professions` (after `forge data sources --only builders`)
4. `forge data trainers` (and `forge data talents build` after a new client build)
5. `node tools/polestar.js travel build`
6. `forge data maps build` and `forge data maps overlays`
7. `node tools/polestar.js qol build`
8. `forge data itemdb`, then `forge data gear`
9. `forge data questdb`
10. `forge data codex` (`forge data codex --local-extras` for this machine; reads `professions.json`, `trainers.json` and the recorded `instances.json`; `dungeons.json` only with `--local-extras`)
11. The generated guides: `node tools/polestar.js exploration build` (reads `travel.json`), `node tools/polestar.js profession gathering build` and `node tools/polestar.js profession draft <Profession> --out` for each crafting profession (read `professions.json`)
12. `forge guide lint`, then `forge guide compile`
13. `node tools/polestar.js preview`: it reads no reference data and no compiled guides, but the addon Lua that steps 4 to 8 write is part of what it draws

`forge data maps overlays`, `forge data itemdb` and `media` read no reference data: they
only need rerunning when the client's tables or `tools/media` change. The
README charts need the sim world (`forge walks world`) on the new data first.
