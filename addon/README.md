# addon/

The in-game side of Polestar: Lua 5.1 addons for World of Warcraft: Forever
(`## Interface: 16001`). Each folder here is one addon, installed into the
game's `Interface/AddOns` by `node tools/polestar.js install`. The contract
between the modules is [docs/ARCHITECTURE.md](../docs/ARCHITECTURE.md); this
page says which part is which.

## The addons

| Folder | What it holds | Built by | In git | Ships |
|---|---|---|---|---|
| `Polestar` | The addon: guide engine, waypoint arrow and travel planner, quest markers, gear advice, world map, quality of life, Lookup, Dungeons, Rares, Talents, Characters and every window. | Hand-written, apart from the generated files listed below | yes | yes, in `Polestar-<version>.zip` |
| `Polestar_Guides` | Polestar's own guide pack (pack id `guides`): the guides under `guides/` compiled to Lua, those for both factions here and each faction's own in its part (below). Loads with Polestar. | `forge guide compile`, from `guides/` | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_Guides_<Faction>`, `Polestar_Guides_<Race>` | The guide pack's parts: each faction's own guides, its leveling routes, class guides and the rest (`Polestar_Guides_Alliance`, `Polestar_Guides_Horde`), and per race the baked walks of the leveling guides that race plays (`Legs.lua`, `Polestar_Guides_Dwarf` … `Polestar_Guides_Troll`). Loaded on demand for the player's faction and race only. | `forge guide compile` (`Legs.lua` from `guides/legs.json`, baked by `forge guide bake`) | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_ItemDB` | Item stats for the gear advice (`Items.lua`) and Forever item stats with quest reward choices (`Forever.lua`). Loaded on demand. | `forge data itemdb`, then `forge data gear` | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_<locale>` | One language folder per client language (`deDE` … `zhTW`): Polestar's interface strings in that language (`Interface.lua`, kept by translators and `forge i18n sync`), our guides' texts in that language (`Texts.lua`, from `guides/locales/<locale>/`) and the quest, NPC, object and item names of Polestar's guides, quest database and Codex in it (`Names.lua`, from the client's tables, DingDB and pfQuest: `LICENSE-DATA.txt`, Ding's `CREDITS.md`). Loaded on demand by `Core/Locale.lua` while Polestar loads, only the client's own; none on an English client. Before 0.3.0 these were two folders per language, `Polestar_Guides_<locale>` and `Polestar_Names_<locale>`. | `forge guide compile` (`Texts.lua`) and `forge data names` (`Names.lua`); both write the same TOC, which lists `Interface.lua` too | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_QuestDB` | The quest database behind the quest markers, available-quest markers, tooltips and nameplate icons. Loaded on demand. | `forge data questdb`, from `data/forever` | no (gitignored, built locally) | yes, in `Polestar-<version>.zip` when built |
| `Polestar_Codex` | Lookup's Codex: items, mounts, pets, recipes, NPCs, rares, quests, zones, dungeons and treasures with where each comes from; also the Dungeons and Rares data. Loaded on demand. | `forge data codex` | no (gitignored, built locally) | no: `install` copies it when built, `pack` never packages it |
| `Polestar_Nav` | The arrow's walking routes: Polestar's walking router (`Routing/`, started from [Shortest Path Forever](https://github.com/cjber/shortest-path-forever)'s by Cillian Berragan, GPL-3.0-or-later, used with his permission, and Polestar's since 2026-10-16; `CREDITS.md`), pricing each step by its ground class and the player's faction (`Routing/Costs.lua`), on the walking maps of Eastern Kingdoms, Kalimdor and Zephras Isle (maps format 5: Leffe's navigation maps, with the walk's chokepoints and our floors' area names; format 3 from our grid without `--leffe`). `API.lua` hands the engine to Polestar as `Polestar_NavEngine`; it reads only its own maps (`PolestarPathData`), also with Shortest Path Forever installed. Loaded on demand at login. | the router hand-written; `forge nav pack --leffe` (the maps and `Chokepoints.lua`, `PACK.json`); the maps never edited by hand | yes (the maps generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_Nav_EK`, `Polestar_Nav_Kalimdor` | Each continent's map parts of Leffe's maps; Polestar_Nav's router loads the player's continent's the first time it searches there (never in combat). | `forge nav pack --leffe` | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_Travel` | Zone crossings for the travel planner, from the optional local crossings file `data/local/crossings.json`. Loads with Polestar. | `travel build` | no (gitignored, built locally) | no: `install` copies it when built, `pack` never packages it |
| `Polestar_Recorder` | An optional, standalone recorder (no dependency on Polestar): quests, routes, world data and, while Polestar runs, guide progress, as compact records into `PolestarRecorderDB` (schema 2, [docs/RECORDING.md](../docs/RECORDING.md)). Off until turned on (`/psrec on`, or Polestar Client's share flag: sharing is on by default in the client; `/psrec off` always wins). Polestar Client sends it; `forge record import` reads what it wrote. `Ack.lua` is the client's acknowledgement and share flag, shipped empty. | Hand-written | yes | yes, as its own `Polestar_Recorder-<version>.zip`; `install --recorder` |

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

`Polestar.toc` loads `ClientInfo.lua` first (what Polestar Client knows of
Polestar's releases: the release ships it empty, the Client rewrites it after
each check for updates, and `Core/Update.lua` reads it), then thirteen XML
manifests, one per module, and each manifest lists that module's files, in
the order below, which is the load order. The addon's
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
| 1 | Core | `Core/Core.xml` | `Polestar` itself, `Compat`, `Data`, `Hooks`, `Guides`, `Search`, `Engine`, `Automation`, `Bindings`, `Update` and the smaller ones below | Namespace, lifecycle, events, settings, client API wrapper, guide registry and guide texts, import strings, guide engine and hand-in planning, quest automation, slash commands, update notices |
| 2 | Theme | `Theme/Theme.xml` | `Theme`, `Anim`, `Widgets` | Colours, fonts, media, the game's own skins, tweens and the widget kit every window is built from |
| 3 | Nav | `Nav/Nav.xml` | `Nav`, `Pins`, `Regions`, `Transit` | The navigation target, map and minimap pins for every module, the waypoint arrow and its walking paths, the travel planner, journeys, Nearby services and transport alerts |
| 4 | Quests | `Quests/Quests.xml` | `QuestDB`, `NewQuests`, `Timed`, `Party`, `PartyChat` | Quest database access, quest markers, quest tooltip lines and bag marks, quest levels in titles, timed quests, party sync and party chat |
| 5 | Gear | `Gear/Gear.xml` | `ItemDB`, `Gear` | Item stats, stat weights (Pawn scales too), upgrade advice, gear tooltip lines, reward picks |
| 6 | Maps | `Maps/Maps.xml` | `Maps`, `RouteLines`, `RouteStrokes`, `RouteSparkle` | World map without fog of war, zone level ranges, coordinates, the minimap button, dungeon, travel and service pins, route lines, flight timer, instance tracker |
| 7 | QoL | `QoL/QoL.xml` | `QoL` | Quality of life helpers: action buttons and Quick Keybind Mode, quest-starting loot, bags, XP and pace, Boosted Rest, merchant and restock, trainers and spell ranks, reward marks and gear, flight masters, gossip, death and breath, toggles, requests from other players, class quest offers, dungeon quests in dungeons |
| 8 | Lookup | `Lookup/Lookup.xml` | `Codex`, `Lookup` | The Codex reader, where things come from, generated guides, mount spotting |
| 9 | Dungeons | `Dungeons/Dungeons.xml` | `Dungeons` | A quest journal per dungeon and raid, the guides that pick up and hand in a dungeon's quests, attunements, quest XP and the dungeons' pictures |
| 10 | UI | `UI/UI.xml` | `UI`, `Gamepad` | The guide window and its step browser, cards and panels, the hub and its Guides, Lookup, Dungeons and Import sections, zone art, route choice, welcome, what's new, guide end, problem report, options, the gamepad |
| 11 | Rares | `Rares/Rares.xml` | `Rares` | Rare NPCs and treasures: detection, pins, alerts and the hub's Rares section |
| 12 | Talents | `Talents/Talents.xml` | `Talents` | Talent plans for every class: the hub's Talents section, marks and tooltip lines on the talent frame, a reminder when a point waits. Paused since 0.3.1 (`Talents.SOON`): the section says "Coming soon" and nothing else shows |
| 13 | Alts | `Alts/Alts.xml` | `Alts` | A snapshot of each character on the account and the hub's Characters section |

`Bindings.xml` at the addon root declares the key bindings, in a Polestar
section of their own in the game's Options > Keybindings; it calls into
`Core/Commands.lua`. Fonts are in `Media/Fonts`, sounds in `Media/Sounds`,
textures in `Media/Map`, `Media/Nav` and `Media/UI`.

### Core

| File | Public table | What it does |
|---|---|---|
| `Init.lua` | `Polestar` (`ns`) | The namespace and shared plumbing: lifecycle (`OnInit`, `OnLogin`), message bus (`On`, `Off`, `Fire`), game events, settings (`Get`, `Set`, `RegisterDefaults`), per-character state, the `/polestar` and `/pole` commands and `/rl` (reloads the interface); translations (`L`, `LC`; filled by the language folder `Locale.lua` loads), game terms in the client's words (`StandingName`, `QualityName`, `FactionName`) and `AI_LOCALES`; hiding everything Polestar shows (`SetHidden`, `ToggleHidden`) |
| `Compat.lua` | `Compat` | Every quest, map and unit client call, in one place, so tests can swap it for a fake; also the one copy of the client helpers every module shares: `IsSecret` and `Readable` (secret values from combat-restricted APIs), `Now` (the server clock) and `MapName` (the client's map name, else the Codex zone's) |
| `Data.lua` | `Data` | Loads the load-on-demand data addons (`Data.Pack(name)`) |
| `LuaChunks.lua` | `LuaChunks` | Records the data addons keep as text in long-string chunks, found by id and decoded on first read |
| `Credits.lua` | `Credits` | Generated: the supporters, contributors and bug reporters on the Guiding Stars page |
| `Names.lua` | `Names` | Quest, NPC, object and item names in the client's language: the client's own, else its language folder `Polestar_<locale>`'s `Names.lua`, loaded on demand; nil (English) on an English client |
| `Hooks.lua` | `Hooks` | The one owner of the tooltip and item-click hooks; modules add lines and handle clicks through it |
| `GuideTexts.lua` | `GuideTexts` | A compiled guide's words in the client's language: the game's names in them are tokens, filled in for that language |
| `Locale.lua` | – | Loads the client's language folder `Polestar_<locale>` (interface strings, names, guide texts) right after `GuideTexts.lua`, before any file reads `L` at load; nothing on an English client, English when the folder is missing |
| `Guides.lua` | `Guides` | The guide registry: packs, guides and map frames registered at load time, and the queries behind the guide menu (lists, suggestions) |
| `LegacySteps.lua` | (registers data) | Generated: the steps earlier releases' leveling guides had, so an update keeps a player's check-offs and skips on the step that now holds the same goal; built only when an update changed a saved guide |
| `Levels.lua` | `Levels` | How far a route takes this character: the XP of its quests (and a guide's kills) in route order, and the level that leaves them at |
| `Import.lua` | `Import` | Import strings: reads and checks a guide shared as one line of text (`/polestar import`) |
| `Search.lua` | `Search` | One search over guides and every Codex entity, for the hub's search box and Lookup |
| `FieldRoute.lua` | `FieldRoute` | The order of a step's independent field goals: the shortest way round them, so the rest of the trip doesn't backtrack |
| `Engine.lua` | `Engine` | The guide engine: the current step, each goal's status, where the waypoint points; progress recomputed from live client state |
| `RoutePlan.lua` | `RoutePlan` | Read-only hand-in planning over the guide chain: where the route hands each quest in, and which quests in the log it never needs (Clean up quest log) |
| `ClassTrainers.lua` | (registers data) | Generated: one class trainer per town and class, for the class-training reminder |
| `Closes.lua` | `Closes` | Quests that taking another one closes for good, for the missable-quest warning |
| `Unlocks.lua` | `Unlocks` | What doing a quest opens up (its follow-ups), for the guide window's quest tooltips |
| `Automation.lua` | `Automation` | Accepts and turns in the quests the guide wants right now |
| `Commands.lua` | `Bindings` | Guide slash commands and key binding labels |
| `Update.lua` | `Update` | Update notices: what Polestar knows of a newer release (from Polestar Client, party and guild members, and players of your faction it asks) and when to say so; `/polestar update` |

### Theme

| File | Public table | What it does |
|---|---|---|
| `GameArt.lua` | `GameArt` | Generated: where the client's own art for the game skins sits in its atlases |
| `Theme.lua` | `Theme` | Colour schemes, fonts, media paths and frame skins |
| `GameSkins.lua` | `Theme` | The game's own skins (WoW Forever, Blizzard, Classic): Polestar's windows drawn in the client's art |
| `Anim.lua` | `Anim` | Short property tweens (fade, slide, pop, fill) on one driver frame |
| `Widgets.lua` | `Widgets` | The widget kit: the Polestar shell, setting controls, rows; also defines the options registry `RegisterOptions` |

### Nav

| File | Public table | What it does |
|---|---|---|
| `Nav.lua` | `Nav` | The point being guided to and where it is relative to the player |
| `Baked.lua` | `Nav` | Baked legs: the walk into each guide step, routed when the guides are built and shipped with them, decoded for the arrow (`Nav.BakedLeg`) |
| `MapCanvas.lua` | `MapCanvas` | Drawing on Blizzard's map frames (world map, battlefield map) with Polestar's own frames, the maps only read |
| `Pins.lua` | `Pins` | Map and minimap icons for every module, in named layers |
| `Regions.lua` | `Regions` | Spawn spots grouped into soft areas, for the step's spawn areas and the quest objective areas |
| `Arrow.lua` | `Nav.arrow` | The waypoint arrow: turning, distance, label, arrival ring |
| `Layers.lua` | (local) | Nav's own pins: the target, its area, the points where the travel route changes mode |
| `Upcoming.lua` | `Nav.upcoming` | Numbered pins for the steps ahead (Map options, off by default) |
| `Bridges.lua` | `Nav` | Mirrors the target to other waypoint addons and to the game's own waypoint |
| `Transit.lua` | `Transit` | When boats, zeppelins, the Deeprun Tram and lifts leave, and which class teleports the character can cast now |
| `Danger.lua` | `Nav.danger` | How much dearer a walk through a zone far above the character is |
| `Travel.lua` | `Nav` | The travel planner: walking, flights, boats, hearth, crossings, as a shortest-path search |
| `Follow.lua` | `Nav.follow` | The arrow's path follower: how far along a walk the player is and where the arrow points |
| `Walk.lua` | `Nav.walk` | Walking paths on the ground, from the router in `Polestar_Nav` (or a baked leg), for the arrow and the route lines |
| `TravelData.lua` | (registers data) | Generated: the flight network, transports and inns for the planner |
| `Journey.lua` | `Nav.journey`, `Nav.API` | Journeys anywhere: Shift- and Alt-click on a map, the API other addons steer the arrow with, the TomTom stand-in and `/way` |
| `Nearby.lua` | `Nav.nearby` | Nearby services: the nearest trainer, vendor, inn, bank and the like by travel time (`/polestar near`) |
| `Prompts.lua` | `Nav.prompts` | The travel button under the arrow (the route's Hearthstone or teleport) and skipping a leg |
| `Alerts.lua` | `Nav.alerts` | Transport alerts before a boat, zeppelin or tram comes in |
| `Handoff.lua` | `Nav.handoff` | Handing the guiding to Shortest Path Forever when asked, and stepping aside while it runs a journey of its own |

### Quests

| File | Public table | What it does |
|---|---|---|
| `NewQuests.lua` | `NewQuests` | Which quests Forever added, and the small ∞ mark beside their names (Mark quests new in Forever) |
| `NewQuestIds.lua` | (registers data) | Generated: the ids of the quests Forever added |
| `QuestDB.lua` | `QuestDB` | Reads `Polestar_QuestDB` and answers lookups |
| `Tracker.lua` | `QuestDB` | Quest markers on the map: objectives, turn-ins and quest givers with quests available now |
| `Tooltips.lua` | `QuestDB` | Quest lines on unit, item and object tooltips; quest icons on nameplates |
| `BagMarks.lua` | `QuestDB` | A quest mark on bag items a quest still needs, until the hand-in |
| `DeleteWarning.lua` | `QuestDB` | "Needed for" on the game's delete confirmation when the item is one a quest still needs |
| `SellWarning.lua` | `QuestDB` | Offers to buy back a sold item a quest still needs |
| `QuestLevels.lua` | (local) | Quest levels before quest titles wherever the client draws a title without one |
| `Timed.lua` | `Timed` | Timed quests: the time left on their goals, the row at the top of the guide window for a timed quest the guide doesn't hand in, and the alerts at 5 and 1 minutes left and on failure |
| `Options.lua` | `QuestDB.OPTIONS` | The quest settings and the `/polestar questdb` command |
| `Party.lua` | `Party` | Party sync: quest progress shared with party members who run Polestar (hidden addon messages, quest ids and counts only) |
| `PartyChat.lua` | `PartyChat` | Party chat lines about your finished objectives, ready quests and quest-starting loot |

### Gear

| File | Public table | What it does |
|---|---|---|
| `ItemDB.lua` | `ItemDB` | Reads `Polestar_ItemDB`; entries are parsed on first lookup |
| `Weights.lua` | `Gear` | Leveling stat weights per class and spec, and what each class can wear |
| `SpecData.lua` | `Gear` | Generated: stat weight bands per spec and level, racial gear traits |
| `PawnStats.lua` | `Gear` | Pawn's stat names mapped to Polestar's, for importing a scale string |
| `Pawn.lua` | `Gear.Pawn` | Custom stat weights from Pawn scale strings |
| `Gear.lua` | `Gear` | Upgrade advice: an item's score and whether it is an upgrade |
| `Tooltip.lua` | `Gear` | Upgrade lines on item tooltips |
| `Bags.lua` | `Gear.Bags` | The upgrade arrow on bag items, in the game's bags and Baganator |
| `Rewards.lua` | `Gear` | Ranks quest reward choices |
| `Picks.lua` | `Gear` | The reward to take at a turn-in, for the guide window and tooltips |
| `Options.lua` | (registers options) | The gear settings (Questing, Rewards & gear) |

### Maps

| File | Public table | What it does |
|---|---|---|
| `Maps.lua` | `Maps` | The module's settings, options page and shared helpers |
| `WorldMap.lua` | `Maps` | Zone level ranges on continent maps and the world map's info bar |
| `ZoneLevels.lua` | (registers data) | Generated: each zone's level range |
| `Reveal.lua` | `Maps` | The world map without fog of war |
| `Coords.lua` | `Maps` | The player's coordinates under the minimap |
| `MinimapButton.lua` | `Maps` | The Polestar button on the minimap's edge (on by default): a click hides or shows everything Polestar shows, a right-click opens its menu |
| `Dungeons.lua` | `Maps` | Dungeon entrance pins on the world map |
| `TravelPins.lua` | `Maps` | Flight master and transport pins |
| `ServiceData.lua` | `Maps` | Town services (trainers, vendors, mailboxes and more) read from the Codex for the service pins |
| `ServiceClusters.lua` | `Maps` | A town's service pins grouped into one on region maps, with a menu to pick an NPC |
| `Services.lua` | `Maps` | Service NPCs and mailboxes on the maps (Map options, off by default) |
| `FlightPaths.lua` | (registers data) | Generated: what each flight flies, for the route lines |
| `RouteStrokes.lua` | `RouteStrokes` | Route lines as geometry: paths and a view in, strokes out, no frames |
| `RouteSparkle.lua` | `RouteSparkle` | The sparkle line style: sparkles placed along the route and their twinkle |
| `RouteLines.lua` | `RouteLines` | The route lines on the world map and the minimap |
| `FlightTimer.lua` | `Maps` | Destination and time left while on a flight |
| `Instances.lua` | `Maps` | Instance entries against the hourly cap, run stats, raid lockouts |

### QoL

| File | Public table | What it does |
|---|---|---|
| `QoL.lua` | `QoL` | What the helpers share: settings, the out-of-combat queue |
| `Data.lua` | (registers data) | Generated: spirit healers and flight masters |
| `Keep.lua` | `QoL` | Items a later step needs: never sold as junk, locked in the bags, named on their tooltip |
| `Marks.lua` | `QoL.Marks` | Junk and keep marks (Ctrl+Alt-click an item) |
| `Space.lua` | `QoL.Space` | Bag space: the free slots, the cheapest junk and the bag button that deletes it (`/polestar bags`) |
| `QuickBind.lua` | `QoL.QuickBind` | Binding Polestar's buttons from the game's Quick Keybind Mode |
| `QuestLoot.lua` | `QoL.QuestLoot` | Quest-starting loot on the quest item button, glowing until it is clicked or the quest is taken |
| `Buttons.lua` | `QoL.Buttons` | The quest item, Hearthstone, target, rare and bag buttons |
| `BagGlow.lua` | `QoL.BagGlow` | The step's item glowing in the bags |
| `Hearth.lua` | `QoL` | Hearthstone cooldown and bind location |
| `XP.lua` | `QoL.XP` | XP per hour, time to level, per-level splits |
| `XPMark.lua` | `QoL.XPMark` | The guide's level on the game's XP bar |
| `Rest.lua` | `QoL.Rest` | How long the campfire's Boosted Rest lasts and whether the Cozy Sleeping Bag is ready, under the guide window's XP line; the party's Boosted Rest in the party panel |
| `Vendor.lua` | `QoL.Vendor` | Sells grey items and repairs at a merchant |
| `Buy.lua` | `QoL.Buy` | Buys what the step's buy goals still need (off by default) |
| `Restock.lua` | `QoL.Restock` | The Restock button: drinks, food, ammunition and other items topped up to your amounts |
| `Trainer.lua` | `QoL.Trainer` | The class trainer: the Train All button, and Auto-learn new spells (off by default) |
| `Spells.lua` | `QoL.Spells` | The class spells new at a level, and the spells on your action bars that are a lower rank than your spellbook's |
| `ClassSpells.lua` | (registers data) | Generated: each class's trainer spells by level, with their cost and rank |
| `Rewards.lua` | `QoL.Rewards` | Marks on the game's quest reward choices, and an optional automatic pick |
| `Equip.lua` | `QoL.Equip` | Puts on a quest reward that is an upgrade (off by default) |
| `Wear.lua` | `QoL.Wear` | Offers to put on gear upgrades from loot or a merchant |
| `Flight.lua` | `QoL.Flight` | Opens the flight map from the gossip, marks the node the route flies to, and takes that flight when Take the marked flight is on |
| `Bind.lua` | `QoL.Bind` | Binds the Hearthstone at the guide's inn |
| `Gossip.lua` | `QoL.Gossip` | Picks the chat option the step asks for at its NPC |
| `Death.lua` | `QoL.Death` | As a ghost: run back or use the nearest Spirit Healer, whichever is faster |
| `Breath.lua` | `QoL.Breath` | The breath warning under water (off by default) |
| `Toggles.lua` | `QoL.Toggles` | Small questing toggles, each inert while off |
| `Social.lua` | `QoL.Social` | Summons, resurrections, invitations and duels |
| `Riding.lua` | `QoL.Riding` | The riding reminder at 40 and 60 |
| `ClassQuests.lua` | `QoL.ClassQuests` | Offers a Class guide in a tab when it opens to the character |
| `InstanceTrack.lua` | `QoL.InstanceTrack` | Inside a dungeon or raid, only its quests in the quest tracker and on the maps (Track only dungeon quests in dungeons) |
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
| `XP.lua` | `Dungeons` | How far a dungeon's quests take this character, for the dungeon page's level chip |
| `Art.lua` | `Dungeons` | Each dungeon's loading-screen picture, cropped for the dungeon heads-up |

### UI

| File | Public table | What it does |
|---|---|---|
| `UI.lua` | `UI` | What the windows share: `ui.*` defaults, goal text formatting, command routing |
| `Gamepad.lua` | `Gamepad` | Playing Polestar with a gamepad: button names, bindings and chords, and moving through every Polestar window |
| `ZoneArt.lua` | `UI.ZoneArt` | A zone's world map painting, drawn from the player's own client |
| `ZoneArtOverlays.lua` | (registers data) | Generated: every world map overlay of every zone map |
| `NameTargets.lua` | `UI.NameTargets` | Objective rows and NPC headings that target their NPC when clicked (Click objectives to target) |
| `GuideFrame.lua` | `UI.GuideFrame` | The guide window |
| `StepList.lua` | `UI.StepList` | Browse all steps: every step of the guide in the guide window, opened from the step number |
| `Launcher.lua` | `UI.Launcher` | The optional floating Polestar button: hide or show Polestar, menu, drag |
| `GameMenu.lua` | `UI.GameMenu` | The Polestar button in the game menu (Esc) |
| `WhileHere.lua` | `UI.WhileHereToast` | The "While you're here" card for a new suggestion while the guide window is hidden |
| `PartyPanel.lua` | `UI.PartyPanel` | The party panel: each party member who runs Polestar, their step and what they still need (`/polestar party`) |
| `PartyLoot.lua` | `UI.PartyLoot` | A line under quest loot a party member still needs |
| `ClassRewards.lua` | (registers data) | Generated: what each class quest chain gives, for the class-quest card |
| `ClassCard.lua` | `UI.ClassCard` | The class-quest card above a class quest's goals |
| `ClassToast.lua` | `UI.ClassToast` | The class quest heads-up on the guide window, and the card the other heads-ups share |
| `DungeonToast.lua` | `UI.DungeonToast` | The dungeon heads-up when a dungeon's quests open to the character |
| `SpellCards.lua` | `UI.SpellCards` | The new spells card at level-up and the old ranks card after training |
| `UpdateCard.lua` | `UI.UpdateCard` | The update card and the guide window's update line |
| `JourneyPanel.lua` | `UI.JourneyPanel` | The journey: the travel route's steps in the guide window |
| `GamepadGuide.lua` | `Gamepad` | Browsing the guide window with the gamepad, and the options' Gamepad page |
| `GearPick.lua` | `UI.GearPick` | The reward pick under a turn-in goal |
| `LevelTip.lua` | `UI.LevelTip` | What a route is worth in levels: the chip and its panel |
| `Picker.lua` | `UI.Picker` | The hub: its section rail, sidebar and search, and its built-in Guides section (the guide menu); defines `UI.RegisterSection` |
| `QuestLinks.lua` | (local) | Quest log and objective tracker menu entries: open the guide search at that quest, with its matching steps |
| `Lookup.lua` | `UI.Lookup` | The hub's Lookup section |
| `Dungeons.lua` | `UI.DungeonsSection` | The hub's Dungeons section |
| `RouteChoice.lua` | `UI.RouteChoice` | "Choose your path": one card per zone where a guide offers several next guides |
| `GuideEnd.lua` | `UI.GuideEnd` | The window at the end of a leveling guide: the next guide, and the quests carried to later guides |
| `Welcome.lua` | `UI.Welcome` | The welcome a character sees the first time Polestar meets it |
| `WhatsNew.lua` | `UI.WhatsNew` | What's new: the release's notes, once per account on the first login after an update |
| `Copy.lua` | `UI.ShowCopy` | A small window holding text to copy |
| `QuestRoom.lua` | `UI` | Clean up quest log: the quests in the log the route doesn't need, each with an Abandon button that asks first |
| `GearScales.lua` | `UI.ScalesView` | The custom stat weights window (Pawn scale strings) |
| `Report.lua` | `UI.Report` | "Report a problem" (the guide window's bug button, `/polestar report`): a report on the step on screen to copy for the Polestar Discord; `UI.ShowDiscord`, the invite on its own |
| `Packs.lua` | `UI.Packs` | The Community guides page of the options window |
| `Import.lua` | `UI.Import` | The hub's Import page, at the foot of its rail (`/polestar import`) |
| `Thanks.lua` | `UI.Thanks` | Guiding Stars: the supporters, contributors and bug reporters, and the "Special thanks to" line |
| `Options.lua` | `UI.Options` | The options window: pages, tabs, sections, settings search |
| `LineStyle.lua` | `UI` | The route lines' style window (the gear beside Route lines) |
| `QuestieTurnIns.lua` | `QuestieTurnIns` | Polestar's turn-in step on completed quests in the community quest database's tracker (Integrations options, off by default) |

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
| `Talents.lua` | `Talents` | Settings, the chosen plan, plan progress, the snapshot checked against the live tree, the unspent-point reminder; `Talents.SOON` pauses the plans (the section says "Coming soon") |
| `Builds.lua` | (registers plans) | Generated by `forge data talents build`: the plans and the tree they were checked against |
| `Overlay.lua` | `Talents.Overlay` | Marks and tooltip lines on the client's talent frame |
| `Options.lua` | (registers options) | The talent settings |
| `View.lua` | `UI.TalentsSection` | The hub's Talents section |

### Alts

| File | Public table | What it does |
|---|---|---|
| `Snapshot.lua` | `Alts` | The per-character snapshots, the events that write them, rested XP projection, the `alts` command |
| `Options.lua` | (registers options) | The Characters setting |
| `View.lua` | `UI.AltsSection` | The hub's Characters section |

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
| Characters | 60 | `Alts/View.lua` |
| Import | 90, at the rail's foot above Options | `UI/Import.lua` |

Lookup, Dungeons and Import keep their screens in `UI/`; Rares, Talents and Characters keep their
screens in their own modules, which works because `Rares.xml`,
`Talents.xml` and `Alts.xml` load after `UI.xml`. A new
section registers the same way, from a file that loads after `UI/Picker.lua`
(`foot = true` puts it at the rail's foot).

## Generated files: do not edit

These files are written by a command. Edit the command's inputs and run it
again; [tools/README.md](../tools/README.md) lists every input and the order
to rebuild in.

| File | Command |
|---|---|
| `Polestar/Core/ClassTrainers.lua` | `forge data trainers` |
| `Polestar/Core/Credits.lua` | `forge release credits` |
| `Polestar/Core/LegacySteps.lua` | `node tools/legacy-steps.js` |
| `Polestar/Theme/GameArt.lua` | `node tools/polestar.js media game-art` |
| `Polestar/Nav/TravelData.lua`, `Polestar/Maps/FlightPaths.lua` | `node tools/polestar.js travel build` |
| `Polestar/Quests/NewQuestIds.lua` | `forge data newquests` |
| `Polestar/Gear/SpecData.lua`, `Polestar/Gear/LICENSE-DATA.txt` | `forge data gear` |
| `Polestar/Maps/ZoneLevels.lua` | `forge data maps build` |
| `Polestar/QoL/Data.lua` | `node tools/polestar.js qol build` |
| `Polestar/QoL/ClassSpells.lua` | `forge data classspells` |
| `Polestar/UI/ZoneArtOverlays.lua` | `forge data maps overlays` |
| `Polestar/UI/ClassRewards.lua` | `node tools/polestar.js classrewards build` |
| `Polestar/Talents/Builds.lua` | `forge data talents build` |
| `Polestar/Media/Map/*.tga`, `Polestar/Media/Nav/*.tga`, `Polestar/Media/UI/*.tga` | `node tools/polestar.js media` |
| `Polestar_Guides/*` (TOC, `Pack.lua`, `MapFrames.lua`, `Guides.lua`, `LICENSE-DATA.txt`) | `forge guide compile` |
| `Polestar_Guides_<Faction>/*`, `Polestar_Guides_<Race>/*` (TOC, `Guides.lua`, `Legs.lua`, `LICENSE-DATA.txt`) | `forge guide compile` (the legs from `guides/legs.json`, which `forge guide bake` writes) |
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
