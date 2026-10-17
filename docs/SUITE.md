# Polestar suite

The goal: every inch of WoW: Forever covered by guides, and anything a
player sees in the world (a mount, an item, an NPC, a quest) answerable from
inside Polestar with "how do I get that?". This document sets what each
module covers, what is out of scope and the rules for the inputs; the
contracts between the modules are in [docs/ARCHITECTURE.md](ARCHITECTURE.md).

## Modules

| Module | What it does |
|---|---|
| Guides (core) | Leveling 1-60 (proven routes, `docs/SIMULATION.md`; class quests as class-only steps inside them), professions, reputations, exploration, Legacy, collectibles (one guide per mount/pet) |
| Navigation (core) | Arrow, travel planner, waypoints; `/polestar way <x> <y> [label]` (or `/pole way`) points the arrow at a spot on the current map; Shift-click a map to go there; `/polestar near <service>` for the quickest trainer, vendor, inn, bank...; other addons' TomTom waypoints and `/way` without TomTom; `Polestar.Nav.API` for addon authors |
| Quests | Map and minimap pins for available quests, objective areas, quest givers (off by default, Map options); tooltip lines on mobs and items that a quest needs; quest levels in the log; a quest icon beside the health bar of nameplates of mobs a quest needs (replacement nameplates included) |
| Lookup (Codex) | One search over guides and entities (items, mounts, pets, recipes, tabards, quests, NPCs, rares, treasures, dungeons, zones). "How to get" for any item, mount or pet: sources ranked for this character, one click to a guide (curated when one exists, otherwise built on the spot). Tooltip source lines; Alt-click an item link to guide; target or mouse over a player to see their mount and how to get it. Search only: no browse-everything lists |
| Dungeons | A journal page per dungeon: every quest with where to get it, its objective, its chain and its rewards (item choices, XP, money, reputation), plus bosses and the entrance on the map, with "guide me" to givers and the entrance; attunements and keys (Molten Core, Onyxia's Lair, Blackwing Lair, Naxxramas, Scholomance, Blackrock Depths, the City of Dalaran...) with this character's progress and a guide through what is left. No loot tables |
| Upgrades | Upgrade indicator on item tooltips and the best pick on quest reward choices, from stat weights per spec (detected from the client's talent points) and level band |
| Rares | Rare NPC and treasure database with locations and loot, map pins (off by default, Map options), alerts (only through APIs the Forever client has) |
| Maps | World map without fog of war (the zone-art overlay table), coordinates, zone level ranges, dungeon entrance and travel pins (off by default, Map options) |
| QoL | Quality of life helpers: action buttons, XP and pace, merchant, reward marks, flight masters, death helper, toggles, requests from other players |
| Talents (planned) | Where your next talent points go, level by level, on the talent panel, per class and spec. The trees are read from the client; the builds are written by contributors |

Out of scope: a full UI suite (Polestar integrates with EllesmereUI through its
public skinning API), boss and combat warnings, aura tracking, best-in-slot
lists and loot browsing. Polestar keeps the dungeon quest journal and the
upgrade indicator on tooltips.

Every module can be switched off in options, and none costs memory until it is
used: modules load their data packs on demand. No surface lists a whole data
set: lists are search results or bounded groups, built a page at a time, so
opening or typing never stalls a frame.

## Consuming other addons and sites

Inputs are read from the installed copies under
`<client>/_classic_beta_/Interface/AddOns/`, from the client's own files
(CASC/DB2), and from public sites (the Forever databases
wowforevertalents.com, foreverchanges.pro; Wowhead's database pages as cached
in `data/sources/wowhead/`). Polestar itself is GPL-3.0; each input keeps its own licence,
and the rules follow it:

| Input | What may enter the repository and the releases |
|---|---|
| MIT (pfQuest, ForeverLevelingBiS, wowsims) | Derived data, with attribution (THIRD_PARTY.md) |
| QuestieDB (no licence file; its maintainers ask that it be treated as all rights reserved) | Facts only, credited, in the shipped packs (the compiled guides, `Polestar_QuestDB`, `Polestar_Codex`); `data build --no-questie` builds without them if the maintainers ask |
| Web sources (Wowhead's Forever database, warcraft.wiki.gg, the Forever databases) | Facts only, each with its source: corrections, `entrances.json`, `repgates.json`, `attunements.json`, `journal-quests.json`, the Wowhead caches in `data/sources/wowhead/` (incl. its dungeon and raid quest lists) |
| GPL-2.0, no licence or All Rights Reserved addons (AtlasLoot, DungeonJournal, RareScanner, Attune) | Nothing: the importer code only, read by `codex build --local-extras` for the parity comparison (Attune: by `codex attune`, the local comparison of dungeon quests and attunements); its output stays local and `pack` refuses it |

Always facts (ids, names, levels, coordinates, drop rates, sources, rewards),
never another addon's prose, art or code. Every output records its sources and
their versions in its `meta`.

## Data layer

- Importers: `tools/lib/consume/<addon>.js` for the Codex and gear sources
  (AtlasLoot, ForeverLevelingBiS, RareScanner, wowsims), sharing one
  Lua-literal reader (`lua.js`); QuestieDB is read by `data build`,
  DungeonJournal by `dungeons build`. Each returns plain JSON. Web sources are
  cached under `data/sources/` and only fetched when asked.
- `node tools/polestar.js codex build` merges ForeverLevelingBiS,
  `data/forever/*.json` and the Forever client's tables into
  `data/forever/codex/*.json` and the `Polestar_Codex` pack, which ships in
  every release (release-safe inputs only; ARCHITECTURE, "Codex"). With
  `--local-extras` it also merges AtlasLoot, RareScanner and DungeonJournal:
  a local-only build that `pack` refuses.
- Precedence for a fact found in several places: recordings > the Forever
  client's tables > Forever-specific sources (QuestieDB Forever, DungeonJournal,
  the Forever sites) > Era sources (pfQuest, AtlasLoot Era tables) > Wowhead
  Classic.

## In-game packs

| Pack | Built from | Committed | Loaded |
|---|---|---|---|
| `Polestar` | the core | yes | always |
| `Polestar_Guides` | `guides/**` | yes | always |
| `Polestar_ItemDB` | client item tables | yes | on demand |
| `Polestar_QuestDB` | `data/forever` (includes QuestieDB) | no (local) | on demand |
| `Polestar_Codex` | `data/forever/codex` (release-safe inputs) | no (generated); in every release zip | on demand (first search, tooltip or lookup) |
| `Polestar_Travel` | a local crossings file (`travel build`) | no (local) | always, when built |
| community addons (`PolestarPack_*` by default) | a pack's `.guide` files, by its author (`docs/PACKS.md`) | in the author's repository | always, when installed |

Local packs are generated into gitignored folders and installed by
`node tools/polestar.js install` like the rest. Without them the core still
works: Lookup, Dungeons and Rares say the Codex is not installed (get the
release zip, not GitHub's "Source code") or turned off (enable it) instead of failing. Every addon, what it holds and how it is built: [ARCHITECTURE, "Overview"](ARCHITECTURE.md#overview).

Packs (ours and the community addons) register through one registry
(`Core/Guides.lua`, ARCHITECTURE "The guide registry"; the rules in
PACK_FORMAT.md): each owns its guide-id prefix,
a refusal is recorded against its pack and shown on Options > Community guides, and
a pack the player switches off hides its guides everywhere (`PACKS_CHANGED`).
The tools treat every pack alike (`new`, `doctor`, `lint`, `compile`,
`playtest`, `play`, `dev`, `pack`, `install`, `sim compare --pack`);
`docs/PACK_FORMAT.md` is the contract.

## Runtime services (core)

Their contracts are in docs/ARCHITECTURE.md, "Core services: Data, Hooks,
Search" and "Lookup"; in short:

- `Data`: `Data.Pack(name)` loads a pack on demand (`C_AddOns.LoadAddOn`) and
  reports memory; modules never touch another module's tables directly.
- `Search`: one index over guides and Codex entities; the hub's guide search
  and its Lookup section share it.
- `Lookup.Sources(kind, id)`: the sources of an item, mount or pet, ranked for
  this character (faction, level, professions, reputation, distance via Nav).
  `Lookup.Guide(kind, id)` opens the curated guide when one `collects` it,
  otherwise registers a generated guide (same guide table as compiled guides,
  not saved) and opens it in a new tab.
- `Hooks`: item and unit tooltips, chat item links, target and mouseover. One
  handler per hook, so modules add lines instead of fighting over the tooltip.
- `Guides`: the guide registry: packs and their statuses (`Guides.Packs()`),
  the guides of packs that are on, suggestions from the chosen source
  (`behavior.suggestFrom`, our guides filling in).

## UI

One hub, grown from the guide menu: Guides, Lookup, Dungeons and Rares as
top-level sections, Options at the rail's foot, all in Polestar's world
([`docs/DESIGN.md`](DESIGN.md)). New surfaces extend that world;
they never introduce another look.

Small windows outside the hub share its look: the guide window, the route
choice, the welcome for new characters (`UI/Welcome.lua`), the copy window
(`UI/Copy.lua`, `PolestarCopy`: text to copy, such as `/polestar where`'s
lines), the report window (`UI/Report.lua`, `PolestarReport`: the guide
window's bug writes a report on the step on screen to paste on the Polestar
Discord) and the rare alert. Options carries a Community guides page
(`UI/Packs.lua`) and a Gamepad page (`UI/GamepadGuide.lua`); every window
answers a gamepad while it is open (`UI/Gamepad.lua`, ported from Ding! by
Yendi).
