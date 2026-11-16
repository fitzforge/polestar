# addon/

The in-game side of Polestar: Lua 5.1 addons for World of Warcraft: Forever
(`## Interface: 16001`). Each folder here is one addon, installed into the
game's `Interface/AddOns` by `node tools/polestar.js install`. The contract
between the modules is [docs/ARCHITECTURE.md](../docs/ARCHITECTURE.md); this
page says which part is which.

## The addons

| Folder | What it holds | Built by | In git | Ships |
|---|---|---|---|---|
| `Polestar` | The addon: guide engine, waypoint arrow and travel planner, quest markers, gear advice, world map, quality of life, Lookup, Dungeons, Rares, Talents, Characters and every window but the settings window (`Polestar_Options`). | Hand-written, apart from the generated files listed below | yes | yes, in `Polestar-<version>.zip` |
| `Polestar_Guides` | Polestar's own guide pack (pack id `guides`): every guide under `guides/`, compiled to Lua: the factionless guides here, each faction's leveling guides in its faction part. Loads with Polestar. | `compile`, from `guides/` | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_Guides_Alliance`, `Polestar_Guides_Horde` | Each faction's guides of `Polestar_Guides` (`Guides.lua`); the player's faction's loads with the pack, on demand. | `forge guide compile` | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_Guides_<Race>` (`Human`, `Dwarf`, `Gnome`, `NightElf`, `Skyborne`, `Orc`, `Troll`, `Tauren`, `Scourge`) | The baked walks into every leveling step for that race (`Legs.lua`, `Polestar.RegisterLegs`), loaded on demand for a character of that race. | `forge guide compile`, from `guides/legs.json` (`forge guide bake`) | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_Experimental` | Polestar's experimental guides (pack id `polestar-experimental`): guides for Forever's new zones in testing (alpha), from `experimental/`; for now Mount Hyjal (Alliance, 57-60). Loaded at login unless the player switches it off (Options > Guide > Show experimental guides, on by default); listed with Polestar's guides under Leveling with a purple Experimental chip; never suggested, picked or put in a route for the player, though "Choose your path" may offer its zone. | `forge guide compile experimental` and `forge release pack`, from `experimental/` | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_ItemDB` | Item stats for the gear advice (`Items.lua`) and Forever item stats with quest reward choices (`Forever.lua`). Loaded on demand. | `forge data itemdb`, then `forge data gear` | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_<locale>` | One language folder per client language (`deDE` … `zhTW`): Polestar's interface strings in that language (`Interface.lua`, kept by translators and `forge i18n sync`), our guides' texts in that language (`Texts.lua`, from `guides/locales/<locale>/`) the quest, NPC, object and item names of Polestar's guides, quest database and Codex in it (`Names.lua`, from the client's tables, DingDB and pfQuest: `LICENSE-DATA.txt`, Ding's `CREDITS.md`) and the walking maps' areas named as the client names the subzone there (`Subzones.lua`, from the client's tables, for the arrow's floor by subzone). Loaded on demand by `Core/Locale.lua` while Polestar loads, only the client's own; none on an English client. Before 0.3.0 these were two folders per language, `Polestar_Guides_<locale>` and `Polestar_Names_<locale>`. | `forge guide compile` (`Texts.lua`), `forge data names` (`Names.lua`) and `forge data subzones` (`Subzones.lua`); each writes the same TOC, which lists `Interface.lua` too | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_QuestDB` | The quest database behind the quest markers, available-quest markers, tooltips and nameplate icons. Loaded on demand. | `forge data questdb`, from `data/forever` | no (gitignored, built locally) | yes, in `Polestar-<version>.zip` when built |
| `Polestar_Codex` | Lookup's Codex: items, mounts, pets, recipes, NPCs, rares, quests, zones, dungeons and treasures with where each comes from; also the Dungeons and Rares data. Loaded on demand. | `forge data codex`, from release-safe inputs (`--local-extras` builds a local-only one) | no (gitignored, built locally) | yes, always: `forge release pack` refuses to go without it |
| `Polestar_Nav` | The arrow's walking routes: Polestar's walking router (`Routing/`, started from [Shortest Path Forever](https://github.com/cjber/shortest-path-forever)'s by Cillian Berragan, GPL-3.0-or-later, used with his permission, and Polestar's since 2026-10-16; `CREDITS.md`), pricing each step by its ground class and the player's faction (`Routing/Costs.lua`), on the walking maps of Eastern Kingdoms, Kalimdor and Zephras Isle (maps format 5: Leffe's navigation maps, with the walk's chokepoints and our floors' area names; format 3 from our grid without `--leffe`). `API.lua` hands the engine to Polestar as `Polestar_NavEngine`; it reads only its own maps (`PolestarPathData`), also with Shortest Path Forever installed. Loaded on demand at login. | the router hand-written; `forge nav pack --leffe` (the maps and `Chokepoints.lua`, `PACK.json`); the maps never edited by hand | yes (the maps generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_Nav_EK`, `Polestar_Nav_Kalimdor` | Each continent's map parts of Leffe's maps; Polestar_Nav's router loads the player's continent's the first time it searches there (never in combat). | `forge nav pack --leffe` | yes (generated) | yes, in `Polestar-<version>.zip` |
| `Polestar_Travel` | Zone crossings for the travel planner, from the optional local crossings file `data/local/crossings.json`. Loads with Polestar. | `travel build` | no (gitignored, built locally) | no: `install` copies it when built, `pack` never packages it |
| `Polestar_Options` | The settings window: its pages, the Look pages with their previews and presets, the Profiles page and profile strings, Move frames. Loaded on demand the first time the settings open (`UI/OptionsLoader.lua` in `Polestar` is its door). | Hand-written | yes | yes, in `Polestar-<version>.zip` |
| `Polestar_Looks` | The game looks (WoW Forever, Blizzard, Classic: `GameSkins.lua`, `GameArt.lua`, `Parts.lua` with their own arrow and map pins) and Hearth's painters (`Hearth.lua`). Loaded on demand the first time one of them is painted. | Hand-written; `GameArt.lua` by `media game-art` | yes | yes, in `Polestar-<version>.zip` |
| `Polestar_SkinAPI` | The Skin API's checks for a skin or colour scheme from another addon (`SkinCheck.lua`). Loaded on demand the first time another addon registers one. | Hand-written | yes | yes, in `Polestar-<version>.zip` |
| `Polestar_Skin_<Name>` (`Vellum`, `Lumen`, `Beacon`, `Aurora`, `Hairline`, `Umbra`, `Waymark`, `Lanterns`, `Sheen`) | The nine skins that ship with Polestar, each an addon of its own on the Skin API (`## X-Polestar-Skin` in its TOC), listed under Settings > Look > Theme and loaded only when picked. | Hand-written | yes | yes, in `Polestar-<version>.zip` |
| `Polestar_Recorder` | An optional, standalone recorder (no dependency on Polestar): quests, routes, world data and, while Polestar runs, guide progress, as compact records into `PolestarRecorderDB` (schema 2, [docs/RECORDING.md](../docs/RECORDING.md)). Off until turned on (`/psrec on`, or Polestar Client's share flag: sharing is on by default in the client; `/psrec off` always wins). Polestar Client sends it; `forge record import` reads what it wrote. `Ack.lua` is the client's acknowledgement and share flag, shipped empty. | Hand-written | yes | yes, as its own `Polestar_Recorder-<version>.zip`; `install --recorder` |
| `Polestar_Skin_Example` | The Skin API's example ([docs/SKINS-API.md](../docs/SKINS-API.md)): "Moonlit", a colour scheme and a skin registered from an addon of its own, for skin authors to copy. Depends on Polestar. | Hand-written | yes | no: never packed or installed; copy it into `Interface/AddOns` by hand to try it |

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

`Polestar.toc` loads thirteen XML manifests, one per module, and each manifest
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
| 10 | UI | `UI/UI.xml` | `UI` | The guide window, the hub and its Guides, Lookup and Dungeons sections, zone art, route choice, Install, problem report, heads-up cards, the settings window's door (the window itself is `Polestar_Options`) |
| 11 | Rares | `Rares/Rares.xml` | `Rares` | Rare NPCs and treasures: detection, pins, alerts and the hub's Rares section |
| 12 | Talents | `Talents/Talents.xml` | `Talents` | Talent plans for every class: the hub's Talents section, marks and tooltip lines on the talent frame, a reminder when a point waits |
| 13 | Alts | `Alts/Alts.xml` | `Alts` | A snapshot of each character on the account and the hub's Characters section |

`Bindings.xml` at the addon root declares the key bindings; it calls into
`Core/Commands.lua`. Fonts are in `Media/Fonts`, textures in `Media/Nav` and
`Media/UI`.

### Core

| File | Public table | What it does |
|---|---|---|
| `Init.lua` | `Polestar` (`ns`) | The namespace and shared plumbing: lifecycle (`OnInit`, `OnLogin`), message bus (`On`, `Off`, `Fire`), game events, settings (`Get`, `Set`, `RegisterDefaults`), per-character state, the `/polestar` and `/pole` commands; translations (`L`, `LC`; filled by the language folder `Locale.lua` loads), game terms in the client's words (`StandingName`, `QualityName`, `FactionName`) and `AI_LOCALES` |
| `Compat.lua` | `Compat` | Every quest, map and unit client call, in one place, so tests can swap it for a fake; also the one copy of the client helpers every module shares: `IsSecret` and `Readable` (secret values from combat-restricted APIs), `Now` (the server clock) and `MapName` (the client's map name, else the Codex zone's) |
| `Data.lua` | `Data` | Loads the load-on-demand data addons (`Data.Pack(name)`) |
| `Locale.lua` | – | Loads the client's language folder `Polestar_<locale>` (interface strings, names, guide texts) right after `GuideTexts.lua`, before any file reads `L` at load; nothing on an English client, English when the folder is missing |
| `Names.lua` | `Names` | Quest, NPC, object and item names in the client's language: the client's own, else its language folder `Polestar_<locale>`'s `Names.lua`, loaded on demand; the walking maps' areas as the client names the subzone there (kind `subzone`, the folder's `Subzones.lua`); nil (English) on an English client |
| `Hooks.lua` | `Hooks` | The one owner of the tooltip and item-click hooks; modules add lines and handle clicks through it |
| `Guides.lua` | `Guides` | The guide registry: packs, guides and map frames registered at load time, and the queries behind the guide menu (lists, suggestions) |
| `Search.lua` | `Search` | One search over guides and every Codex entity, for the hub's search box and Lookup |
| `Engine.lua` | `Engine` | The guide engine: the current step, each goal's status, where the waypoint points; progress recomputed from live client state |
| `API.lua` | `API` | What other addons may build on, versioned by `API.version` ([docs/API.md](../docs/API.md)); `ReplaceSteps` gives a registered guide new steps in its own tab |
| `Materials.lua` | `Materials` | A profession guide's materials gathered or bought, one way at a time (Gather, Buy or Mix per character and guide), what the character holds (bags, bank, mail, purchases on their way, other characters), prices, and the Auction House search |
| `Gather.lua` | `Gather` | While you're here's gathering spots: where each herb, ore vein and fishing pool the character gathers can spawn, the minimap's tracking and the Interact Key's pick |
| `GatherData.lua` | (registers data) | Generated: each gathering node kind's spots and the skill it asks |
| `ClassTrainers.lua` | (registers data) | Generated: one class trainer per town and class, for the class-training reminder |
| `Automation.lua` | `Automation` | Accepts and turns in the quests the guide wants right now |
| `Closes.lua` | `Closes` | Quests that taking another one closes for good: a breadcrumb once its quest is taken, the rest of an exclusive group |
| `Unlocks.lua` | `Unlocks` | What doing a quest opens up (the quests that need it, its follow-ups), for the guide window's quest tooltips |
| `Levels.lua` | `Levels` | How far a route takes this character: its quests' and kills' XP in route order, and the level that leaves them at |
| `RoutePlan.lua` | `RoutePlan` | Read-only hand-in planning over the guide chains open in tabs: which finished quests a route ahead hands in, which none does |
| `FieldRoute.lua` | `FieldRoute` | The order to do one field's independent goals in (an open travelling-salesman route, world coordinates only) |
| `GuideTexts.lua` | `GuideTexts` | A compiled guide's prose in the client's language |
| `LegacySteps.lua` | `LegacyMovedIn`, `LegacyStepsLoad` | Generated by `tools/legacy-steps.js`: earlier releases' steps, so an update mid-guide keeps your check-offs and skips |
| `LuaChunks.lua` | (local) | Records kept as text in long-string chunks, decoded on first read |
| `Import.lua` | `Import` | Import strings: a small guide shared as one line of text |
| `Profiles.lua` | `Profiles` | Named sets of settings, the settings keys' migrations, and profile strings |
| `Pause.lua` | `Polestar` | Pause: its watcher, chat lines and the `pause` and `resume` commands |
| `Update.lua` | `Update` | What Polestar knows of a newer release, and when to say so (the card is `UI/UpdateCard.lua`) |
| `Credits.lua` | `Credits` | Generated by `forge release credits`: Guiding Stars' supporters, contributors, reporters and translators |
| `Commands.lua` | `Bindings` | Guide slash commands and key binding labels |

### Theme

| File | Public table | What it does |
|---|---|---|
| `Theme.lua` | `Theme` | Resolves every look: colour schemes, fonts, media paths and frame skins |
| `House.lua` | `House` | Polestar's own look: Polestar gold, the status and subject colours, the colour schemes (Dusk, Night, Graphite), the type ladder |
| `SkinApi.lua` | `Theme` | The Skin API: other addons' colour schemes and skins ([docs/SKINS-API.md](../docs/SKINS-API.md)); their checks load from `Polestar_SkinAPI` |
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
| `Regions.lua` | `Regions` | Spawn spots grouped into soft areas, for the step's spawn regions and the quest objective areas |
| `Upcoming.lua` | `Nav` | The steps after the live one on the map, one numbered pin each (off by default) |
| `Bridges.lua` | `Nav` | Mirrors the target to other waypoint addons and to the game's own waypoint |
| `Travel.lua` | `Nav` | The travel planner: walking, flights, boats, hearth, crossings, as a shortest-path search |
| `Transit.lua` | `Transit` | When boats, zeppelins, the Deeprun Tram and lifts leave, and which class teleports the character can cast now |
| `Danger.lua` | `Nav` | How much dearer a walk through a zone far above the character is |
| `Walk.lua` | `Nav` | Walking paths from `Polestar_Nav`'s router instead of a straight line |
| `Baked.lua` | `Nav` | Baked legs: the walk into a guide step, routed offline and shipped in the race parts |
| `Follow.lua` | `Nav` | The arrow's path follower: how far along the path the player is and where the arrow points |
| `Journey.lua` | `Nav.API` | Going anywhere (Shift- and Alt-click on the maps) and letting other addons steer the arrow |
| `Handoff.lua` | `Nav` | Hand-off to Shortest Path Forever, so the two never guide at once |
| `Nearby.lua` | `Nav` | Nearby services: the nearest trainer, vendor, inn, bank and the like, by travel time |
| `Prompts.lua` | `Nav` | Travel prompts: the route's cast button and the manual leg step |
| `Alerts.lua` | `Nav` | Transport alerts: a heads-up before your boat, zeppelin or tram comes in |
| `TravelData.lua` | (registers data) | Generated: the flight network, transports and inns for the planner |

### Quests

| File | Public table | What it does |
|---|---|---|
| `QuestDB.lua` | `QuestDB` | Reads `Polestar_QuestDB` and answers lookups |
| `Tracker.lua` | `QuestDB` | Quest markers on the map: objectives, turn-ins and quest givers with quests available now |
| `Tooltips.lua` | `QuestDB` | Quest lines on unit, item and object tooltips; quest icons on nameplates |
| `QuestLevels.lua` | (local) | Quest levels before quest titles wherever the client draws a title without one |
| `NewQuestIds.lua`, `NewQuests.lua` | `NewQuests` | Which quests Forever added (the first generated by `forge data newquests`), and their "New in Forever" mark |
| `Timed.lua` | `Timed` | Timed quests: time left on their goals and the arrow, alerts, the way to the hand-in against the clock |
| `Party.lua` | `Party` | Party sync: quest progress shared with party members who run Polestar |
| `PartyChat.lua` | `PartyChat` | Tell my party: plain party chat lines about your quests |
| `BagMarks.lua`, `DeleteWarning.lua`, `SellWarning.lua` | `QuestDB` | A quest mark on bag items a quest still needs, a line on the delete confirmation, and a buy-back offer when one is sold |
| `QuestLogLink.lua` | `Polestar` | "Show in quest log": the game's quest log opened at a quest |
| `AuctionBuys.lua` | `AuctionBuys` | Which quest items of the running guide and the quest log an auction house can sell: tradeable, sold by no merchant, a long farm or dropped by nothing |

### Gear

| File | Public table | What it does |
|---|---|---|
| `ItemDB.lua` | `ItemDB` | Reads `Polestar_ItemDB`; entries are parsed on first lookup |
| `Weights.lua` | `Gear` | Leveling stat weights per class and spec, and what each class can wear |
| `SpecData.lua` | `Gear` | Generated: stat weight bands per spec and level, racial gear traits |
| `PawnStats.lua`, `Pawn.lua` | `Gear.Pawn`, `Gear.Scales` | Custom stat weights from Pawn scale strings |
| `Adjust.lua` | `Gear.Adjust` | The player's own changes to the built-in weights, with Revert to default (#1529) |
| `FLB.lua` | `Gear.FLB` | Forever Leveling BiS's public API when it is installed (its bag arrows; from its version 2 its gains, scores, weights and spec), every call guarded |
| `Gear.lua` | `Gear` | Upgrade advice: an item's score and whether it is an upgrade |
| `Tooltip.lua` | `Gear` | Upgrade lines on item tooltips |
| `Bags.lua` | `Gear.Bags` | The upgrade arrow on bag items, in the game's bags and Baganator |
| `Rewards.lua` | `Gear` | Ranks quest reward choices |
| `Picks.lua` | `Gear` | The reward to take at a turn-in, for the guide window and tooltips |

### Maps

| File | Public table | What it does |
|---|---|---|
| `Maps.lua` | `Maps` | The module's settings, options page and shared helpers |
| `WorldMap.lua` | `Maps` | Zone level ranges on continent maps and the world map's info bar |
| `ZoneLevels.lua` | (registers data) | Generated: each zone's level range |
| `Reveal.lua` | `Maps` | The world map without fog of war |
| `Coords.lua` | `Maps` | The player's coordinates under the minimap |
| `MinimapButton.lua` | `Maps` | The Polestar button on the minimap's edge (on by default) |
| `Dungeons.lua` | `Maps` | Dungeon entrance pins on the world map |
| `TravelPins.lua` | `Maps` | Flight master and transport pins |
| `FlightTimer.lua` | `Maps` | Destination and time left while on a flight |
| `Instances.lua` | `Maps` | Instance entries against the hourly cap, run stats, raid lockouts |
| `Services.lua`, `ServiceData.lua`, `ServiceClusters.lua` | `Maps` | NPC services and mailboxes on the zone and city maps (off by default), from the Codex, grouped on region maps |
| `RouteLines.lua`, `RouteStrokes.lua`, `RouteSparkle.lua` | `RouteLines`, `RouteStrokes`, `RouteSparkle` | Route lines on the world map and the minimap: the painters, the strokes worked out as plain Lua, and the sparkle style |
| `FlightPaths.lua` | `FlightTracks` | Generated by `travel build`: what each flight flies, so the route line follows the flight master's path |

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
| `Space.lua` | `QoL.Space` | Free bag slots and a way to make room (`/polestar bags`) |
| `Restock.lua` | `QoL.Restock` | Drinks, food, ammunition and other items topped up at merchants (`/polestar restock`) |
| `Buy.lua` | `QoL.Buy` | Buys what the step's buy goals still need (off by default) |
| `Keep.lua` | `QoL` | Items the guide keeps for later, never sold |
| `Marks.lua` | `QoL.Marks` | Junk and keep marks on items |
| `BagGlow.lua` | `QoL.BagGlow` | The step's item glows in the bags |
| `QuestLoot.lua` | `QoL.QuestLoot` | Quest-starting loot on the quest item button |
| `Equip.lua`, `Wear.lua` | `QoL.Equip`, `QoL.Wear` | Quest rewards and loot worth wearing: put on, or offered on the guide window's banner |
| `Spells.lua`, `ClassSpells.lua` | `QoL.Spells` | New spells at level-up and old ranks on the action bars; the class training lists generated by `forge data classspells` |
| `ClassQuests.lua` | `QoL.ClassQuests` | Fires the class quest heads-up when a class guide opens |
| `Riding.lua` | `QoL.Riding` | The riding reminder at levels 40 and 60 |
| `Bind.lua` | `QoL.Bind` | Binds the Hearthstone at the guide's inn (off by default) |
| `Gossip.lua` | `QoL.Gossip` | The gossip option the guide asks for |
| `InstanceTrack.lua` | `QoL.InstanceTrack` | Inside a dungeon, the quest tracker holds only its quests |
| `Rest.lua` | `QoL.Rest` | Boosted Rest and the Cozy Sleeping Bag's cooldown |
| `XPMark.lua` | `QoL.XPMark` | The guide's level on the game's XP bar |
| `Breath.lua` | `QoL.Breath` | The breath warning under water (off by default) |
| `QuickBind.lua` | `QoL.QuickBind` | Polestar's buttons in the game's Quick Keybind Mode |

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
| `Mark.lua` | `Dungeons` | The dungeon glyph after a quest's name when it belongs to a dungeon or leads to one |
| `XP.lua` | `Dungeons` | How far a dungeon's quests take this character, for the page's level chip |
| `Art.lua` | `Dungeons` | Each dungeon's loading screen art, cropped for the dungeon heads-up |

### UI

| File | Public table | What it does |
|---|---|---|
| `UI.lua` | `UI` | What the windows share: `ui.*` defaults, goal text formatting, command routing |
| `ZoneArt.lua` | `UI.ZoneArt` | A zone's world map painting, drawn from the player's own client |
| `ZoneArtOverlays.lua` | (registers data) | Generated: every world map overlay of every zone map |
| `GuideFrame.lua` | `UI.GuideFrame` | The guide window |
| `GuideFrameBanner.lua`, `GuideFrameHere.lua`, `GuideFrameLayout.lua`, `GuideFrameLook.lua`, `GuideFrameMenu.lua`, `GuideFrameStatus.lua`, `GuideFrameTabs.lua`, `GuideFrameWindow.lua` | `UI.GuideFrame` | The guide window's parts: the banner, While you're here, the layout, the transparent style and skins, the menu and Nearby services button, the XP and party lines, the tab strip, where and when it shows |
| `StepList.lua` | `UI.StepList` | The step browser: every step of the guide as a card |
| `JourneyPanel.lua` | `UI.JourneyPanel` | The travel route's steps in the guide window |
| `WhileHere.lua` | `UI.WhileHereToast` | The "While you're here" toast |
| `NameTargets.lua` | `UI.NameTargets` | Clickable objectives and NPC headers, and the target list |
| `GuideEnd.lua` | `UI.GuideEnd` | The end of a leveling guide: the next guide, the quests carried to later guides and those not part of your route |
| `QuestRoom.lua` | `UI` | Make room in the quest log: the quests no open route hands in, each with Abandon (`/polestar questlog`) |
| `LevelTip.lua` | `UI.LevelTip` | What a route is worth in levels, as a chip and its tooltip |
| `ClassToast.lua`, `DungeonToast.lua`, `SpellCards.lua`, `UpdateCard.lua` | `UI.ClassToast`, `UI.DungeonToast`, `UI.SpellCards`, `UI.UpdateCard` | The heads-up cards on the guide window: class quests, a dungeon opening up, new spells and old ranks, a newer Polestar |
| `ClassCard.lua`, `ClassRewards.lua` | `UI.ClassCard`, `ClassRewards` | The class-quest card above a class quest's step, and what each chain gives (generated by `classrewards build`) |
| `PartyPanel.lua`, `PartyLoot.lua` | `UI.PartyPanel`, `UI.PartyLoot` | The party panel, and the line on loot a party member still needs |
| `QuickSettings.lua` | `UI.QuickSettings` | Quick settings from the guide window's menu |
| `Toasts.lua`, `Trackers.lua` | `UI.Toasts`, `UI.Trackers` | How the toasts and the small trackers look and when they show (their pages are in `Polestar_Options`) |
| `Movers.lua` | `Movers` | `/polestar unlock` and `lock`; the Move frames mode itself is in `Polestar_Options` |
| `GameMenu.lua` | `UI.GameMenu` | The Polestar button in the game menu (Esc) |
| `Gamepad.lua`, `GamepadGuide.lua` | `Gamepad` | Playing Polestar with a gamepad (adapted from Ding! by Yendi, GPL-3.0) |
| `Import.lua` | `UI.Import` | The Import page at the foot of the hub's rail |
| `QuestieTurnIns.lua` | `QuestieTurnIns` | Optional captions on Questie's tracker (Options > Integrations, off by default) |
| `Thanks.lua` | `UI.Thanks` | Guiding Stars: the people behind Polestar, an options page |
| `Launcher.lua` | `UI.Launcher` | The optional floating Polestar button: show or hide the window, menu, drag |
| `GearPick.lua` | `UI.GearPick` | The reward pick under a turn-in goal |
| `GearScales.lua` | `UI.ShowScales` | The custom stat weights window |
| `GearAdjust.lua` | `UI.ShowAdjust` | The Adjust weights window |
| `Picker.lua` | `UI.Picker` | The hub: its section rail, sidebar and search, and its built-in Guides section (the guide menu); defines `UI.RegisterSection` |
| `QuestLinks.lua` | (local) | Quest log and objective tracker menu entries: open the guide search at that quest, with its matching steps |
| `Lookup.lua` | `UI.Lookup` | The hub's Lookup section |
| `Dungeons.lua` | `UI.DungeonsSection` | The hub's Dungeons section |
| `RouteChoice.lua` | `UI.RouteChoice` | "Choose your path": one card per zone where a guide offers several next guides |
| `Welcome.lua` | `UI.Welcome` | Install: the setup a character gets the first time Polestar meets it, a page at a time (`/polestar install`) |
| `WhatsNew.lua` | `UI.WhatsNew` | What's new: the release's notes, once per account on the first login after an update |
| `Copy.lua` | `UI.ShowCopy` | A small window holding text to copy |
| `AuctionBuys.lua` | `UI.AuctionBuys` | Auction house buys on screen: the card when a guide opens, the reminder in a town with an auction house, the list (`/polestar ah`, the guide window's menu) with the profession guide's materials, beside the Auction House while it is open |
| `Materials.lua` | `UI.Materials` | Gather, buy or mix on screen: the card a profession guide shows once, the Materials window (`/polestar materials`), the guide window's menu rows |
| `Report.lua` | `UI.Report` | "Report a problem" (the guide window's bug button, `/polestar report`): a report on the step on screen to copy for the Polestar Discord; `UI.ShowDiscord`, the invite on its own |
| `Packs.lua` | `UI.Packs` | The Community guides page of the options window |
| `OptionsLoader.lua` | `UI.ShowOptions` | The settings window's door: loads `Polestar_Options` the first time the settings open |

### Rares

| File | Public table | What it does |
|---|---|---|
| `Rares.lua` | `Rares` | Settings and the "last seen" history |
| `Detect.lua` | `Rares.Detect` | What the client reports about rares and treasures nearby |
| `Pins.lua` | `Rares` | Rares and treasures on the world map and minimap |
| `Toast.lua` | `Rares.Toast` | The rare alert |
| `View.lua` | `UI.RaresSection` | The hub's Rares section |

### Talents

| File | Public table | What it does |
|---|---|---|
| `Talents.lua` | `Talents` | Settings, the chosen plan, plan progress, the snapshot checked against the live tree, the unspent-point reminder |
| `Builds.lua` | (registers plans) | Generated by `forge data talents build`: the plans and the tree they were checked against |
| `Overlay.lua` | `Talents.Overlay` | Marks and tooltip lines on the client's talent frame |
| `Options.lua` | (registers options) | The talent settings |
| `View.lua` | `UI.TalentsSection` | The hub's Talents section |

### Alts

| File | Public table | What it does |
|---|---|---|
| `Snapshot.lua` | `Alts` | The per-character snapshots, the events that write them, rested XP projection, the `alts` command |
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

Lookup and Dungeons keep their screens in `UI/`; Rares, Talents and Characters keep their
screens in their own modules, which works because `Rares.xml`,
`Talents.xml` and `Alts.xml` load after `UI.xml`. A new
section registers the same way, from a file that loads after `UI/Picker.lua`.

## Polestar_Options, the settings window

The settings window and everything only it uses load from their own addon
the first time the settings open (`UI/OptionsLoader.lua` in `Polestar` is
the door), so a session that never opens them never loads them. Its folders
mirror `Polestar`'s modules:

| File | What it does |
|---|---|
| `UI/Options.lua` | The settings window: the sidebar's groups (Guiding, Look, Setup, About) and pages, tabs, sections, the search, Reset page and Undo |
| `UI/SearchDropdown.lua` | The search's dropdown: the best matching settings as you type, questions understood |
| `UI/Controls.lua` | The window's own widgets: colour rows with hex, opacity and favourites, typed values |
| `UI/Presets.lua` | Essentials' presets: a Look page's named looks as picture cards |
| `UI/Preview.lua` | The live previews every Look page goes through |
| `UI/Profiles.lua`, `Core/ProfileStrings.lua` | The Profiles page (Profiles and Share tabs) and profile strings, read back as a preview before anything changes |
| `UI/Movers.lua` | Move frames (unlock mode): every movable Polestar frame at once, with Revert and Save |
| `UI/Looks/Theme.lua`, `UI/Looks/GuideWindow.lua`, `UI/Looks/Toasts.lua`, `UI/Looks/Trackers.lua` | The Look pages: Theme, Guide window, Alerts & toasts, Trackers |
| `Nav/ArrowOptions.lua`, `Nav/PinsOptions.lua`, `Maps/RouteOptions.lua`, `QoL/ButtonsOptions.lua` | The Look pages: Arrow, Map pins, Route lines, Buttons |
| `Theme/SkinPicker.lua` | The skin picker's picture cards of every look, skin and scheme |
| `UI/GuideOptions.lua` | The guide window's modules' rows and the Gamepad page |
| `Alts/`, `Dungeons/`, `Gear/`, `Lookup/`, `Maps/`, `Nav/`, `QoL/`, `Quests/`, `Rares/`, `Talents/` `Options.lua` | Each module's rows on the Guiding pages; the settings themselves stay in `Polestar` |

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
| `Polestar/QoL/ClassSpells.lua` | `forge data classspells` |
| `Polestar/Quests/NewQuestIds.lua` | `forge data newquests` |
| `Polestar/Maps/FlightPaths.lua` | `node tools/polestar.js travel build` |
| `Polestar/Core/GatherData.lua` | `node tools/polestar.js profession gathering spots` |
| `Polestar/Core/LegacySteps.lua` | `node tools/legacy-steps.js` |
| `Polestar/Core/Credits.lua` | `forge release credits` |
| `Polestar/UI/ClassRewards.lua` | `node tools/polestar.js classrewards build` |
| `Polestar_Looks/GameArt.lua` | `node tools/polestar.js media game-art` |
| `Polestar/Media/Nav/*.tga`, `Polestar/Media/UI/*.tga` | `node tools/polestar.js media` |
| `Polestar_Guides/*` (TOC, `Pack.lua`, `MapFrames.lua`, `Guides.lua`, `LICENSE-DATA.txt`) | `forge guide compile` |
| `Polestar_Guides_Alliance/*`, `Polestar_Guides_Horde/*` (TOC, `Guides.lua`, `LICENSE-DATA.txt`) | `forge guide compile` |
| `Polestar_Guides_<Race>/*` (TOC, `Legs.lua`) | `forge guide compile`, from `guides/legs.json` (`forge guide bake`) |
| `Polestar_Experimental/*` (TOC, `Pack.lua`, `MapFrames.lua`, `Guides.lua`, `LICENSE-DATA.txt`) | `forge guide compile experimental` (and `forge release pack`), from `experimental/` |
| `Polestar_ItemDB/Items.lua` | `forge data itemdb` |
| `Polestar_ItemDB/Forever.lua`, `Polestar_ItemDB/LICENSE-DATA.txt` | `forge data gear` |
| `Polestar_ItemDB/Polestar_ItemDB.toc` | `forge data itemdb`, then `forge data gear` adds `Forever.lua` to it |
| `Polestar_<locale>/Names.lua`, `LICENSE-DATA.txt`, `CREDITS.md` | `forge data names` |
| `Polestar_<locale>/Subzones.lua` | `forge data subzones` |
| `Polestar_<locale>/Texts.lua` | `forge guide compile` |
| `Polestar_<locale>/Polestar_<locale>.toc` | any of the three, alike |
| `Polestar_QuestDB/*` (local) | `forge data questdb` |
| `Polestar_Codex/*` (local) | `forge data codex` |
| `Polestar_Travel/*` (local) | `node tools/polestar.js travel build` |

The `## Version` line of every TOC is set by `forge release version
<x.y.z>`. The generated Lua files say on their first lines which command
wrote them.
