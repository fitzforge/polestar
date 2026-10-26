# addon/

The in-game side of Polestar: Lua 5.1 addons for World of Warcraft: Forever
(`## Interface: 16001`). Each folder here is one addon, installed into the
game's `Interface/AddOns` by `node tools/polestar.js install`. The contract
between the modules is [docs/ARCHITECTURE.md](../docs/ARCHITECTURE.md); this
page says which part is which.

## The addons

| Folder | What it holds | Built by | In git | Ships |
|---|---|---|---|---|
| `Polestar` | The addon: guide engine, waypoint arrow and travel planner, quest markers, gear advice, world map, quality of life, Lookup, Dungeons, Rares, Talents and every window. | Hand-written, apart from the generated files listed below | yes | yes, in `Polestar-<version>.zip` |
| `Polestar_Guides` | Polestar's own guide pack (pack id `guides`): every guide under `guides/`, compiled to Lua. Loads with Polestar. | `compile`, from `guides/` | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_ItemDB` | Item stats for the gear advice (`Items.lua`) and Forever item stats with quest reward choices (`Forever.lua`). Loaded on demand. | `forge data itemdb`, then `forge data gear` | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_<locale>` | One language folder per client language (`deDE` … `zhTW`): our guides' texts in that language (`Texts.lua`, from `guides/locales/<locale>/`) and the quest, NPC, object and item names of Polestar's guides, quest database and Codex in it (`Names.lua`, from the client's tables, DingDB and pfQuest: `LICENSE-DATA.txt`, Ding's `CREDITS.md`). Loaded on demand by `Core/GuideTexts.lua` and `Core/Names.lua`, only the client's own; none on an English client. Before 0.3.0 these were two folders per language, `Polestar_Guides_<locale>` and `Polestar_Names_<locale>`. | `forge guide compile` (`Texts.lua`) and `forge data names` (`Names.lua`); both write the same TOC | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_QuestDB` | The quest database behind the quest markers, available-quest markers, tooltips and nameplate icons. Loaded on demand. | `forge data questdb`, from `data/forever` | no (gitignored, built locally) | yes, in `Polestar-<version>.zip` when built |
| `Polestar_Codex` | Lookup's Codex: items, mounts, pets, recipes, NPCs, rares, quests, zones, dungeons and treasures with where each comes from; also the Dungeons and Rares data. Loaded on demand. | `forge data codex` | no (gitignored, built locally) | no: `install` copies it when built, `pack` never packages it |
| `Polestar_Nav` | The arrow's walking routes: Polestar's walking router (`Routing/`, started from [Shortest Path Forever](https://github.com/cjber/shortest-path-forever)'s by Cillian Berragan, GPL-3.0-or-later, used with his permission, and Polestar's since 2026-10-16; `CREDITS.md`), pricing each step by its ground class and the player's faction (`Routing/Costs.lua`), on the walking maps of Eastern Kingdoms, Kalimdor and Zephras Isle (maps format 5: Leffe's navigation maps, with the walk's chokepoints and our floors' area names; format 3 from our grid without `--leffe`). `API.lua` hands the engine to Polestar as `Polestar_NavEngine`; it reads only its own maps (`PolestarPathData`), also with Shortest Path Forever installed. Loaded on demand at login. | the router hand-written; `forge nav pack --leffe` (the maps and `Chokepoints.lua`, `PACK.json`); the maps never edited by hand | yes (the maps generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_Nav_EK`, `Polestar_Nav_Kalimdor` | Each continent's map parts of Leffe's maps; Polestar_Nav's router loads the player's continent's the first time it searches there (never in combat). | `forge nav pack --leffe` | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_Travel` | Zone crossings for the travel planner, from the optional local crossings file `data/local/crossings.json`. Loads with Polestar. | `travel build` | no (gitignored, built locally) | no: `install` copies it when built, `pack` never packages it |
| `Polestar_Recorder` | An optional, standalone recorder (no dependency on Polestar): quests, routes, world data and, while Polestar runs, guide progress, into `PolestarRecorderDB`. Off until turned on (`/psrec on`). `record import` reads what it wrote. | Hand-written | yes | yes, as its own `Polestar_Recorder-<version>.zip`; `install --recorder` |

The data addons Polestar can do without: with `Polestar_QuestDB`,
`Polestar_Codex` or `Polestar_ItemDB` missing, the features that read them say
what is missing instead of failing; without its `Polestar_<locale>` a
client reads the guides in English with English names; without `Polestar_Nav` the arrow points
straight at each stop. Which inputs may be redistributed, and so
which data addons may ship, is in [THIRD_PARTY.md](../THIRD_PARTY.md).

Every folder carries `## Category: Polestar` and every folder but `Polestar`
`## Group: Polestar`: the game's AddOns list (the client's
`Blizzard_AddOnList`) shows them as one collapsible "Polestar" heading, the
folders indented under Polestar's own line. Only a category folds there (a
group only indents), and the client reads the category of a group's parent,
so the heading comes from `Polestar.toc`; whether it is folded is the
player's choice, remembered per machine (`g_addonCategoriesCollapsed`).

## Polestar, module by module

`Polestar.toc` loads eleven XML manifests, one per module, and each manifest
lists that module's files. The order below is the load order. The addon's
namespace is one table, `ns` inside the addon and the global `Polestar`
outside it (`Core/Init.lua`: `Polestar = ns`), so `ns.Engine` and
`Polestar.Engine` are the same table. "Public table" is the table a file
defines or adds to.

Fields Polestar adds to a game frame (`row.psRecord`, `button.psTip`,
`frame.psSkin`) start with `ps`, so they never clash with the frame's own keys
or with fields other addons set on shared frames. They live only on the frame,
never in saved variables.

| # | Module | Manifest | Public tables | What it is |
|---|---|---|---|---|
| 1 | Core | `Core/Core.xml` | `Polestar` itself, `Compat`, `Data`, `Hooks`, `Guides`, `Search`, `Engine`, `Automation`, `Bindings` | Namespace, lifecycle, events, settings, client API wrapper, guide registry, guide engine, quest automation, slash commands |
| 2 | Theme | `Theme/Theme.xml` | `Theme`, `Anim`, `Widgets` | Colours, fonts, media, tweens and the widget kit every window is built from |
| 3 | Nav | `Nav/Nav.xml` | `Nav`, `Pins` | The navigation target, map and minimap pins for every module, the waypoint arrow, the travel planner |
| 4 | Quests | `Quests/Quests.xml` | `QuestDB` | Quest database access, quest markers, quest tooltip lines, quest levels in titles |
| 5 | Gear | `Gear/Gear.xml` | `ItemDB`, `Gear` | Item stats, stat weights, upgrade advice, gear tooltip lines, reward picks |
| 6 | Maps | `Maps/Maps.xml` | `Maps` | World map without fog of war, zone level ranges, coordinates, dungeon and travel pins, flight timer, instance tracker |
| 7 | QoL | `QoL/QoL.xml` | `QoL` | Quality of life helpers: action buttons, XP and pace, merchant, reward marks, flight masters, death helper, toggles, requests from other players |
| 8 | Lookup | `Lookup/Lookup.xml` | `Codex`, `Lookup` | The Codex reader, where things come from, generated guides, mount spotting |
| 9 | Dungeons | `Dungeons/Dungeons.xml` | `Dungeons` | A quest journal per dungeon and raid, and the guide that picks up a dungeon's quests |
| 10 | UI | `UI/UI.xml` | `UI` | The guide window, the hub and its Guides, Lookup and Dungeons sections, zone art, route choice, welcome, problem report, options |
| 11 | Rares | `Rares/Rares.xml` | `Rares` | Rare NPCs and treasures: detection, pins, alerts and the hub's Rares section |
| 12 | Talents | `Talents/Talents.xml` | `Talents` | Talent plans for every class: the hub's Talents section, marks and tooltip lines on the talent frame, a reminder when a point waits |

`Bindings.xml` at the addon root declares the key bindings; it calls into
`Core/Commands.lua`. Fonts are in `Media/Fonts`, textures in `Media/Nav` and
`Media/UI`.

### Core

| File | Public table | What it does |
|---|---|---|
| `Init.lua` | `Polestar` (`ns`) | The namespace and shared plumbing: lifecycle (`OnInit`, `OnLogin`), message bus (`On`, `Off`, `Fire`), game events, settings (`Get`, `Set`, `RegisterDefaults`), per-character state, the `/polestar` and `/pole` commands; translations (`L`, `LC`; `Locales/<locale>.lua` loads right after it from Core.xml), game terms in the client's words (`StandingName`, `QualityName`, `FactionName`) and `AI_LOCALES` |
| `Compat.lua` | `Compat` | Every quest, map and unit client call, in one place, so tests can swap it for a fake; also the one copy of the client helpers every module shares: `IsSecret` and `Readable` (secret values from combat-restricted APIs), `Now` (the server clock) and `MapName` (the client's map name, else the Codex zone's) |
| `Data.lua` | `Data` | Loads the load-on-demand data addons (`Data.Pack(name)`) |
| `Names.lua` | `Names` | Quest, NPC, object and item names in the client's language: the client's own, else its language folder `Polestar_<locale>`'s `Names.lua`, loaded on demand; nil (English) on an English client |
| `Hooks.lua` | `Hooks` | The one owner of the tooltip and item-click hooks; modules add lines and handle clicks through it |
| `Guides.lua` | `Guides` | The guide registry: packs, guides and map frames registered at load time, and the queries behind the guide menu (lists, suggestions) |
| `Search.lua` | `Search` | One search over guides and every Codex entity, for the hub's search box and Lookup |
| `Engine.lua` | `Engine` | The guide engine: the current step, each goal's status, where the waypoint points; progress recomputed from live client state |
| `ClassTrainers.lua` | (registers data) | Generated: one class trainer per town and class, for the class-training reminder |
| `Automation.lua` | `Automation` | Accepts and turns in the quests the guide wants right now |
| `Commands.lua` | `Bindings` | Guide slash commands and key binding labels |

### Theme

| File | Public table | What it does |
|---|---|---|
| `Theme.lua` | `Theme` | Colour schemes, fonts, media paths and frame skins |
| `Anim.lua` | `Anim` | Short property tweens (fade, slide, pop, fill) on one driver frame |
| `Widgets.lua` | `Widgets` | The widget kit: the Polestar shell, setting controls, rows; also defines the options registry `RegisterOptions` |

### Nav

| File | Public table | What it does |
|---|---|---|
| `Nav.lua` | `Nav` | The point being guided to and where it is relative to the player |
| `MapCanvas.lua` | `MapCanvas` | Drawing on Blizzard's map frames (world map, battlefield map) with Polestar's own frames, the maps only read |
| `Pins.lua` | `Pins` | Map and minimap icons for every module, in named layers |
| `Arrow.lua` | `Nav.arrow` | The waypoint arrow: turning, distance, label, arrival ring |
| `Layers.lua` | (local) | Nav's own pins: the target, its area, the points where the travel route changes mode |
| `Bridges.lua` | `Nav` | Mirrors the target to other waypoint addons and to the game's own waypoint |
| `Travel.lua` | `Nav` | The travel planner: walking, flights, boats, hearth, crossings, as a shortest-path search |
| `TravelData.lua` | (registers data) | Generated: the flight network, transports and inns for the planner |

### Quests

| File | Public table | What it does |
|---|---|---|
| `QuestDB.lua` | `QuestDB` | Reads `Polestar_QuestDB` and answers lookups |
| `Tracker.lua` | `QuestDB` | Quest markers on the map: objectives, turn-ins and quest givers with quests available now |
| `Tooltips.lua` | `QuestDB` | Quest lines on unit, item and object tooltips; quest icons on nameplates |
| `QuestLevels.lua` | (local) | Quest levels before quest titles wherever the client draws a title without one |
| `Options.lua` | `QuestDB.OPTIONS` | The quest settings and the `/polestar questdb` command |

### Gear

| File | Public table | What it does |
|---|---|---|
| `ItemDB.lua` | `ItemDB` | Reads `Polestar_ItemDB`; entries are parsed on first lookup |
| `Weights.lua` | `Gear` | Leveling stat weights per class and spec, and what each class can wear |
| `SpecData.lua` | `Gear` | Generated: stat weight bands per spec and level, racial gear traits |
| `Gear.lua` | `Gear` | Upgrade advice: an item's score and whether it is an upgrade |
| `Tooltip.lua` | `Gear` | Upgrade lines on item tooltips |
| `Bags.lua` | `Gear.Bags` | The upgrade arrow on bag items, in the game's bags and Baganator |
| `Rewards.lua` | `Gear` | Ranks quest reward choices |
| `Picks.lua` | `Gear` | The reward to take at a turn-in, for the guide window and tooltips |
| `Options.lua` | (registers options) | The Gear options page |

### Maps

| File | Public table | What it does |
|---|---|---|
| `Maps.lua` | `Maps` | The module's settings, options page and shared helpers |
| `WorldMap.lua` | `Maps` | Zone level ranges on continent maps and the world map's info bar |
| `ZoneLevels.lua` | (registers data) | Generated: each zone's level range |
| `Reveal.lua` | `Maps` | The world map without fog of war |
| `Coords.lua` | `Maps` | The player's coordinates under the minimap |
| `MinimapButton.lua` | `Maps` | The optional Polestar button on the minimap's edge |
| `Dungeons.lua` | `Maps` | Dungeon entrance pins on the world map |
| `TravelPins.lua` | `Maps` | Flight master and transport pins |
| `FlightTimer.lua` | `Maps` | Destination and time left while on a flight |
| `Instances.lua` | `Maps` | Instance entries against the hourly cap, run stats, raid lockouts |

### QoL

| File | Public table | What it does |
|---|---|---|
| `QoL.lua` | `QoL` | What the helpers share: settings, the out-of-combat queue |
| `Data.lua` | (registers data) | Generated: spirit healers and flight masters |
| `Buttons.lua` | `QoL.Buttons` | The quest item, Hearthstone and target buttons |
| `Hearth.lua` | `QoL` | Hearthstone cooldown and bind location |
| `XP.lua` | `QoL.XP` | XP per hour, time to level, per-level splits |
| `Vendor.lua` | `QoL.Vendor` | Sells grey items and repairs at a merchant |
| `Rewards.lua` | `QoL.Rewards` | Marks on the game's quest reward choices, and an optional automatic pick |
| `Flight.lua` | `QoL.Flight` | Opens the flight map from the gossip and marks the node the route flies to |
| `Death.lua` | `QoL.Death` | As a ghost: run back or use the nearest Spirit Healer, whichever is faster |
| `Toggles.lua` | `QoL.Toggles` | Small questing toggles, each inert while off |
| `Social.lua` | `QoL.Social` | Summons, resurrections, invitations and duels |
| `Options.lua` | (registers options) | The Questing and Quality of Life settings |

### Lookup

| File | Public table | What it does |
|---|---|---|
| `Codex.lua` | `Codex` | Reads `Polestar_Codex`, chunk by chunk |
| `Sources.lua` | `Lookup` | Where an item, mount or pet comes from (and where an NPC, quest, dungeon or treasure is), ranked for this character |
| `Guide.lua` | `Lookup` | Opens the curated guide for an item, or builds one from a ranked source |
| `Spotter.lua` | `Lookup` | What mount another player rides; where-from lines on tooltips |
| `Options.lua` | (registers options) | The Lookup settings |

### Dungeons

| File | Public table | What it does |
|---|---|---|
| `Dungeons.lua` | `Dungeons` | A journal page per dungeon and raid: quests, bosses in kill order, entrance |
| `Pickup.lua` | `Dungeons` | Which of a dungeon's quests this character can take before the run, and a guide that collects them |
| `Handin.lua` | `Dungeons` | After the run: a guide to where the dungeon's finished quests are turned in, and the follow-ups taken there |
| `Attune.lua` | `Dungeons` | Attunements and keys: this character's progress through each, and a guide through what is left |

### UI

| File | Public table | What it does |
|---|---|---|
| `UI.lua` | `UI` | What the windows share: `ui.*` defaults, goal text formatting, command routing |
| `ZoneArt.lua` | `UI.ZoneArt` | A zone's world map painting, drawn from the player's own client |
| `ZoneArtOverlays.lua` | (registers data) | Generated: every world map overlay of every zone map |
| `GuideFrame.lua` | `UI.GuideFrame` | The guide window |
| `GearPick.lua` | `UI.GearPick` | The reward pick under a turn-in goal |
| `Picker.lua` | `UI.Picker` | The hub: its section rail, sidebar and search, and its built-in Guides section (the guide menu); defines `UI.RegisterSection` |
| `QuestLinks.lua` | (local) | Quest log and objective tracker menu entries: open the guide search at that quest, with its matching steps |
| `Lookup.lua` | `UI.Lookup` | The hub's Lookup section |
| `Dungeons.lua` | `UI.DungeonsSection` | The hub's Dungeons section |
| `RouteChoice.lua` | `UI.RouteChoice` | "Choose your path": one card per zone where a guide offers several next guides |
| `Welcome.lua` | `UI.Welcome` | The welcome a character sees the first time Polestar meets it |
| `Copy.lua` | `UI.ShowCopy` | A small window holding text to copy |
| `Report.lua` | `UI.Report` | "Report a problem" (the guide window's bug button, `/polestar report`): a report on the step on screen to copy for the Polestar Discord; `UI.ShowDiscord`, the invite on its own |
| `Packs.lua` | `UI.Packs` | The Community guides page of the options window |
| `Options.lua` | `UI.Options` | The options window: pages, tabs, sections, settings search |

### Rares

| File | Public table | What it does |
|---|---|---|
| `Rares.lua` | `Rares` | Settings and the "last seen" history |
| `Detect.lua` | `Rares.Detect` | What the client reports about rares and treasures nearby |
| `Pins.lua` | `Rares` | Rares and treasures on the world map and minimap |
| `Toast.lua` | `Rares.Toast` | The rare alert |
| `Options.lua` | (registers options) | The rares settings |
| `View.lua` | `UI.RaresSection` | The hub's Rares section |

### Talents

| File | Public table | What it does |
|---|---|---|
| `Talents.lua` | `Talents` | Settings, the chosen plan, plan progress, the snapshot checked against the live tree, the unspent-point reminder |
| `Builds.lua` | (registers plans) | Generated by `forge data talents build`: the plans and the tree they were checked against |
| `Overlay.lua` | `Talents.Overlay` | Marks and tooltip lines on the client's talent frame |
| `Options.lua` | (registers options) | The talent settings |
| `View.lua` | `UI.TalentsSection` | The hub's Talents section |

### Where a hub screen lives

The hub is the window `UI/Picker.lua` builds. Guides is its built-in section;
every other section registers itself with `UI.RegisterSection({ key, label,
icon, order, build, render, ... })` from its own file:

| Section | Order | File |
|---|---|---|
| Guides | 10 | `UI/Picker.lua` (built in) |
| Lookup | 20 | `UI/Lookup.lua` |
| Dungeons | 30 | `UI/Dungeons.lua` |
| Talents | 40 | `Talents/View.lua` |
| Rares | 50 | `Rares/View.lua` |

Lookup and Dungeons keep their screens in `UI/`; Rares and Talents keep their
screens in their own modules, which works because `Rares.xml` and
`Talents.xml` load after `UI.xml`. A new
section registers the same way, from a file that loads after `UI/Picker.lua`.

## Generated files: do not edit

These files are written by a command. Edit the command's inputs and run it
again; [tools/README.md](../tools/README.md) lists every input and the order
to rebuild in.

| File | Command |
|---|---|
| `Polestar/Core/ClassTrainers.lua` | `forge data trainers` |
| `Polestar/Nav/TravelData.lua` | `node tools/polestar.js travel build` |
| `Polestar/Gear/SpecData.lua`, `Polestar/Gear/LICENSE-DATA.txt` | `forge data gear` |
| `Polestar/Maps/ZoneLevels.lua` | `forge data maps build` |
| `Polestar/UI/ZoneArtOverlays.lua` | `forge data maps overlays` |
| `Polestar/QoL/Data.lua` | `node tools/polestar.js qol build` |
| `Polestar/Media/Nav/*.tga`, `Polestar/Media/UI/*.tga` | `node tools/polestar.js media` |
| `Polestar_Guides/*` (TOC, `Pack.lua`, `MapFrames.lua`, `Guides.lua`, `LICENSE-DATA.txt`) | `forge guide compile` |
| `Polestar_ItemDB/Items.lua` | `forge data itemdb` |
| `Polestar_ItemDB/Forever.lua`, `Polestar_ItemDB/LICENSE-DATA.txt` | `forge data gear` |
| `Polestar_ItemDB/Polestar_ItemDB.toc` | `forge data itemdb`, then `forge data gear` adds `Forever.lua` to it |
| `Polestar_<locale>/Names.lua`, `LICENSE-DATA.txt`, `CREDITS.md` | `forge data names` |
| `Polestar_<locale>/Texts.lua` | `forge guide compile` |
| `Polestar_<locale>/Polestar_<locale>.toc` | either of the two, alike |
| `Polestar_QuestDB/*` (local) | `forge data questdb` |
| `Polestar_Codex/*` (local) | `forge data codex` |
| `Polestar_Travel/*` (local) | `node tools/polestar.js travel build` |

The `## Version` line of every TOC is set by `forge release version
<x.y.z>`. The generated Lua files say on their first lines which command
wrote them.
