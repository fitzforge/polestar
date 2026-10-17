# Polestar: architecture and contracts

Polestar is a leveling-guide system for **World of Warcraft: Forever** (client
1.60.1, `## Interface: 16001`, install folder `_classic_beta_` during beta).
This file is the contract between modules: the code follows it, and a change
to a contract changes this file with it.

Reference material, checked out locally (gitignored):

- `.ref/wow-ui-source-forever/` — Blizzard's Forever UI source (Gethe/wow-ui-source,
  branch `forever`). `Interface/AddOns/Blizzard_APIDocumentationGenerated/*.lua`
  declares every C API function and event with argument types. **Verify every
  client API you call against it**; a retail or Era assumption is not evidence.
- The live client's AddOns folder, as found by `tools/lib/addons.js`
  (`$WOW_FOREVER_ADDONS`, then the detected clients:
  `<client>/_classic_beta_/Interface/AddOns/`; read-only for reference;
  EllesmereUI's `SKINNING_API.md` lives there).

## Overview

Polestar is a set of addons, a folder of guides and the Node tools that turn
one into the other. The addons:

| Addon | What it holds | Built by (`node tools/polestar.js …`) | In git | Ships |
|---|---|---|---|---|
| `Polestar` (`addon/Polestar/`) | The addon: engine, navigation, quests, gear, maps, quality of life, Lookup, Dungeons, Rares and every window | hand-written, plus a few generated data files | yes | yes |
| `Polestar_Guides` (`addon/Polestar_Guides/`) | Polestar's own pack (pack id `guides`) | `compile`, from `guides/` | yes (generated) | yes |
| community addons | Addons by other authors (`X-Polestar-Pack` in their TOC; `docs/PACKS.md`, `docs/PACK_FORMAT.md`) | the same compiler, from their own repositories | in their own repositories | by their authors |
| `Polestar_ItemDB` (`addon/Polestar_ItemDB/`) | Item stats and Forever reward choices for the gear advice; loaded on demand | `itemdb build` (`Items.lua`), then `gear build` (`Forever.lua`) | yes (generated) | yes |
| `Polestar_Names_<locale>` (`addon/Polestar_Names_deDE/` … `zhTW/`) | Quest, NPC, object and item names in one client language, for `Polestar.Names`; loaded on demand, only the client's own, never in English | `i18n names`, from DingDB (pinned) and pfQuest | yes (generated) | yes |
| `Polestar_QuestDB` (`addon/Polestar_QuestDB/`) | The quest database behind quest markers and tooltips; loaded on demand | `questdb build` | no (local, gitignored) | yes, when built |
| `Polestar_Codex` (`addon/Polestar_Codex/`) | Lookup's Codex, and the Dungeons and Rares data; loaded on demand | `codex build`, from release-safe inputs (`--local-extras` builds a local-only one) | no (generated, gitignored) | yes, always: `pack` fails without it |
| `Polestar_Nav` (`addon/Polestar_Nav/`) | Polestar's walking router (started from Shortest Path Forever v1.16.0 by Cillian Berragan, GPL-3.0-or-later; Polestar's since 2026-10-16) with Polestar's walking maps of Eastern Kingdoms, Kalimdor and Zephras Isle (maps format 2, grown from his format) and the walk's chokepoints, for the arrow's walking routes; loaded on demand at login, never while an installed Shortest Path Forever guides (the target handed to it, or a journey of its own running; Nav, "In-game walking routes (Polestar_Nav)", "Hand-off to Shortest Path Forever") | the router hand-written (`Routing/`); `nav pack` (the maps, `PACK.json`, from the navigation grid and the ground layers) | yes | yes, always |
| `Polestar_Travel` (`addon/Polestar_Travel/`) | Zone crossings for the travel planner, from an optional local crossings file; loaded with Polestar | `travel build` | no (local, gitignored) | no, never packaged (Nav, "Travel planner and zone crossings") |
| `Polestar_Recorder` (`addon/Polestar_Recorder/`) | The optional standalone recorder of play sessions, for authoring | hand-written | yes | yes, as its own zip |

A guide goes from a `.guide` file to the game in four steps. An author
writes it in a pack (`guides/` for Polestar's own). `lint` and
`compile` parse it and fill in names, places and coordinates from the
reference data in `data/forever`. `compile` writes the result as Lua into the
pack's addon folder (`addon/Polestar_Guides` for ours). `install` copies that
folder into the game, where the pack registers its guides with
`Core/Guides.lua` at load time and the Engine plays them ("Guide data" and
"Engine" below).

Where to look next: [docs/README.md](README.md) maps every document;
[addon/README.md](../addon/README.md) lists every addon file with its public
table; [tools/README.md](../tools/README.md) lists the commands, every
generated file and the rebuild order; [tests/README.md](../tests/README.md)
describes the test layers and the fake client.

`addon/Polestar/Polestar.toc` loads eleven XML manifests in this order. Each
module's manifest lists that module's files.
The module sections below follow this order.

```
Core\Core.xml           Core: namespace, lifecycle, events, settings, Compat, guide registry, Engine, automation, commands
Theme\Theme.xml         Theme + widget kit
Nav\Nav.xml             Waypoint arrow, map/minimap pins, travel planner, TomTom bridge
Quests\Quests.xml       Quest database access, markers, tooltips, quest levels
Gear\Gear.xml           Item stats, stat weights, upgrade tooltips, reward picks
Maps\Maps.xml           World map: no fog of war, coordinates, zone levels, dungeon and travel pins, instances
QoL\QoL.xml             Quality-of-life helpers
Lookup\Lookup.xml       Codex, sources, generated guides, mount spotting
Dungeons\Dungeons.xml   Dungeon quest journal data
UI\UI.xml               Guide window, guide menu, zone art, Lookup and Dungeons views, route choice, options
Rares\Rares.xml         Rare NPCs and treasures: detection, pins, alerts, view
Talents\Talents.xml     Talent plans: the hub section, talent frame marks, reminder
```

Manifests use only `<Script file="..."/>` and `<Include file="..."/>` (paths
relative to the XML file, backslashes allowed). The test harness parses the
TOC and these manifests, so tests always load exactly what the client loads.

### Globals

Only these globals may be assigned anywhere under `addon/` (enforced by
`tests/syntax.test.js` via `luac -l`):

`Polestar`, `PolestarDB`, `PolestarCharDB`, `PolestarRecorderDB`,
`SLASH_POLESTAR<n>`, `SLASH_POLESTARREC<n>`, `SLASH_POLESTARWAY<n>` (`/way`,
claimed only while no addon has it), `BINDING_HEADER_POLESTAR`,
`BINDING_NAME_POLESTAR_*`, in `Polestar_Nav` only `Polestar_NavEngine`
(the engine's handoff), `PolestarPathData` (the walking maps) and, in
`Routing/Costs.lua` only, `Polestar_NavCosts` (the router's ground-class
costs), and in `Nav/Journey.lua` only `TomTom` (its stand-in, set while TomTom is not
installed and cleared when it stands down; "Nav API").

Everything else is `local` or lives on the `Polestar` table. Named frames must
be prefixed `Polestar`.

## Core

`local ADDON, ns = ...` in every file; `Polestar = ns` is set once in
`Core/Init.lua` (first file loaded). Packs reach it as the global.

### Lifecycle

```lua
Polestar.OnInit(fn)    -- ADDON_LOADED("Polestar"). Saved settings are loaded; Get falls back to defaults.
Polestar.OnLogin(fn)   -- PLAYER_LOGIN, in registration order. Player info valid.
```

**SavedVariables may come back nil after a cold client restart** on Forever
beta builds (reproduced by Questie, build 69913, file on disk intact). Never
derive guide progress from saved state alone: the current step is always
recomputed from live quest state. Saved state only holds preferences, the
chosen guide, and manual check-offs; losing it must degrade gracefully.

### Message bus

```lua
local h = Polestar.On(msg, fn)   -- fn(...) ; returns handle
Polestar.Off(h)
Polestar.Fire(msg, ...)
Polestar.RegisterEvent(event, fn)    -- game events, one shared hidden frame; fn(event, ...)
Polestar.UnregisterEvent(event, fn)
```

Messages:

| Message | Args | Fired by |
|---|---|---|
| `GUIDES_REGISTERED` | — | Core, once at PLAYER_LOGIN after packs registered (and installed packs scanned) |
| `PACKS_CHANGED` | packId | `Guides.SetPackShown`: a pack's guides were hidden or shown |
| `GUIDE_CHANGED` | guideId or nil | Engine |
| `STEP_CHANGED` | stepIndex | Engine |
| `STEP_UPDATED` | stepIndex | Engine (goal status/progress changed, same step); Names (names arrived) |
| `NAMES_LOADED` | — | Names, when the names pack loads after a refusal in combat (the quest tracker reads its names again) |
| `NAME_LEARNED` | kind ("npc" \| "object"), id | Names, when a name learned in play is new or changed (the Codex, Dungeons and ItemDB caches drop their copy) |
| `STEP_SKIPPED` | fromStep, toStep or nil, `{ { quest, title, reason, text }, ... }` | Engine, active tab, just before `STEP_CHANGED`: the computed step moved past a step whose open quest goals became unavailable (reasons as in "Unavailable quests") |
| `PLAYER_SKIPPED_STEP` | guideId, stepIndex | Engine, after `Skip()` (the window, the menu, `/polestar skip`): the guide window offers the undo |
| `WAYPOINT_CHANGED` | waypoint or nil | Engine (and Nav when an override is set/cleared) |
| `GUIDE_COMPLETED` | guideId | Engine |
| `SETTING_CHANGED` | path, value | Core settings |
| `TOGGLE_FRAME` / `SHOW_FRAME` / `HIDE_FRAME` | — | commands, keybinds → UI |
| `SHOW_PICKER` | — | commands → UI |
| `SHOW_OPTIONS` | section or nil | commands → UI |
| `SHOW_WELCOME` | page or nil | About's "Show the welcome again", `/polestar welcome` → UI/Welcome.lua |
| `SHOW_COPY` | title, text | `/polestar where` → UI/Copy.lua |
| `SHOW_REPORT` | — | `/polestar report` → UI/Report.lua |
| `SHOW_DISCORD` | — | `/polestar discord` → UI/Report.lua |
| `TOGGLE_PICKER` / `TOGGLE_OPTIONS` | — | key bindings and gamepad chords (`POLESTAR_MENU`, `POLESTAR_OPTIONS`) → UI: open, or close when open |
| `TOGGLE_FOCUS` | — | `POLESTAR_FOCUS` → UI/GamepadGuide.lua (focus mode) |

Modules fire their own (`TABS_CHANGED`, `ROUTE_*`, `TRAIN_DUE`,
`CLASS_TRAINED`, `GUIDE_OUTLEVELED`, `QUESTDB_*`, `CODEX_LOADED`,
`ITEMDB_LOADED`, `GEAR_UPDATED`, `FLIGHT_STARTED`/`FLIGHT_ENDED`,
`QOL_HEARTH_CHANGED`, `QOL_XP_UPDATED`, `MOUNT_SPOTTED`, `RARE_SPOTTED`,
`RARES_HISTORY`, `SHOW_LOOKUP`, `SHOW_DUNGEON`, `SHOW_RARES`), documented
with their module.

### Settings

```lua
Polestar.RegisterDefaults(section, tbl)  -- at file load; section = "ui" | "nav" | "behavior" | ...
Polestar.Get("ui.scale")                 -- dotted path; falls back to defaults
Polestar.Set("ui.scale", 1.1)            -- writes PolestarDB.settings, fires SETTING_CHANGED
Polestar.CharState()                      -- PolestarCharDB, always a table
Polestar.IsNewCharacter()                 -- true when there was no saved PolestarCharDB as the addon loaded
Polestar.FormatDistance(yards, opts)      -- "120 yd", or "110 m" / "1.2 km" under nav.distanceUnit = "metres"
```

Every distance a player reads goes through `FormatDistance` (the arrow, the
map target's tooltip, the death helper, the rares' toasts and view); text
that embeds one takes the formatted string (`%s`). `opts.round = 5` rounds to
the nearest 5, `opts.compact` writes yards from 1000 as "1.2k yd"
(`Rares.YardsText`); metres turn to kilometres from 1000 m. The bug report
keeps yards for whoever reads it.

`PolestarDB = { schema = 1, settings = { [section] = { ... } }, packs = { [packId] = { off = true } }, welcomeSeen = 1, gamepad = { chords = { [action] = "PADRSHOULDER+PADDUP" } } }`
`PolestarCharDB = { schema = 1, guide = id|nil, tabs = { guideId, ... }, activeTab = n, absentAt = { [guideId] = place }, manual = { [guideId] = { ["s:g"] = true|"tick" } }, skipped = { [guideId] = { [stepIndex] = true, ["s:g"] = true } }, pins = { [guideId] = { step, done } }, offers = { [questID] = true }, shapes = { [guideId] = shape }, stepKeys = { [guideId] = { hash, ... } }, flags = { fp = { [name] = true }, ... }, welcomeSeen = 0|1 }`

`packs[<id>].off` hides a pack's guides account-wide (the Community guides page's
switch). `welcomeSeen` (UI/Welcome.lua) is the version of the welcome last
seen: in `PolestarDB`, the account has had its welcome (later characters skip
its Set up and Route style pages); in `PolestarCharDB`, this character has (0 while due).
`behavior.suggestFrom` (default `"guides"`) is the pack suggestions come from.
Modules keep their own keys beside these (`rares`, `instances`, `names` account-wide;
`ui`, `routes`, `classTrainLevel`, `classTrainVisit`, `qol`, `flightTimes`,
`flightNow`, `instanceRuns` per character), each described in its section or file header.

`manual` holds the player's ticks (`"tick"`, any goal but a note) **and**
latched results (`true`): NPC interactions (talk/train/vendor) are latched
during their step, and conditions that can stop holding later (goto,
sethome, hearth, fly, getfp, buy, bag-count collect, `train class` with
nothing to learn) are latched once the route moves past their step, so
leaving a zone, rebinding the hearthstone or levelling up never drags the
guide backwards. Quest goals are never latched, but for a `direct` turn-in's
QUEST_TURNED_IN during its step (a repeatable is never flagged completed): abandoning a
quest reopens its step (unless the player ticked it). `skipped` holds the
steps the player skipped (step number) and the optional goals they skipped
(`"s:g"`). `pins` is the step the player was looking at when it is not the
live one (Prev/Next/Goto), `offers` the quests their giver did not offer
(saved at logout, restored while the character is still that level). All of
them are keyed by step position: `stepKeys` (a hash per step of its verbs and
ids) lets a pack update carry them to the steps it kept (see "Placement").

### Commands

```lua
Polestar.RegisterCommand(name, fn(argString), help)
```

`/polestar` and `/pole`. No argument fires `TOGGLE_FRAME`. `help` lists
registered commands with their `help` lines (already translated:
`L["..."]`). Core registers (Core/Commands.lua): `guides`, `options`, `show`, `hide`,
`next`, `prev` (look at the next/previous step; nothing changes), `skip`
(skip the step shown, for good), `reset` (clear ticks, latches, skips and
the saved view for the current guide), `guide <id>`, `status`, `tabs`,
`tab <n>`, `close`, `path` (the route choice), `welcome` (`SHOW_WELCOME`),
`packs` (Options at Community guides), `gamepad` (Options at Gamepad), `where`, `report` (`SHOW_REPORT`),
`discord` (`SHOW_DISCORD`), `debug`; Nav adds `arrow`, `way` and `route`;
modules add theirs (`xp`, `gear`, `instances`, `dungeons`, `lookup`, `mount`,
`rares`, `questdb`).

`where` prints the player's map and position as two guide lines, `zone map
<uiMapID>` and `goto <x>,<y> live` (two decimals, the client's live frame,
marked `live` because typed coordinates are read in the Era frame), then "For
another goal, add @x,y live", and fires `SHOW_COPY` with the two lines. In an
instance or on a map without a position it prints why instead.

### Caught errors and the Polestar Discord

```lua
Polestar.SafeCall(fn, ...)    -- runs fn; an error is noted, then handed to the error handler
Polestar.NoteError(err)       -- notes an error Polestar caught (SafeCall, Hooks' callbacks)
Polestar.Errors() -> { { msg, count, seq }, ... }   -- this session's, oldest first, the last 5 kept
Polestar.NoteBlocked(addon, fn)   -- notes a protected call the game blocked from Polestar or Polestar_*
Polestar.Blocked() -> { { addon, fn, count, at, seq }, ... }   -- this session's, oldest first, the last 5 kept
Polestar.DiscordURL           -- the Polestar Discord's invite
```

Every message and game-event handler, init and login callback and command
runs through `SafeCall`, and Hooks' callbacks through their own `pcall`, so
the errors Polestar catches are noted by their first line, counted, for the
report a player copies (UI, "Reporting a problem"). Polestar never replaces
the game's error handler: wrapping it would shift the stack the game and
!BugGrabber show for every error. Taint is no Lua error: `ADDON_ACTION_BLOCKED`
and `ADDON_ACTION_FORBIDDEN` (the addon blamed, then the function) go to
`NoteBlocked`, which keeps those blaming Polestar or a `Polestar_*` addon
with the addon, how often and the time it last came (`%H:%M:%S`), so a
report on a broken gamepad or button does not read "Errors: none". `seq`,
one counter for both lists, says which came last.

### Frames under the game's UI

```lua
Polestar.CreateFrameUnder(kind, name, parent, template) -> frame   -- CreateFrame with no parent, then SetParent(parent)
```

Forever's gamepad interface hooks `CreateFrame`
(`Blizzard_GamepadSmartNavigation`, `SetupFrameHooks`): when the parent is,
or is under, one of its open panels (the world map, the quest frame, the
talents, the settings...), it rebuilds that panel's button groups inside the
caller's code. Called from Polestar, the panel's tables are left tainted and
the next gamepad action there is blocked ("An action was blocked because of
taint from Polestar"; seen in game as a quest reward was taken, then on every
panel after it). `SetParent` is not hooked. So every frame of Polestar's
whose parent is a game frame, or is under one (the map canvases, the
minimap, the quest reward and talent buttons, and the frames under those),
is made through `CreateFrameUnder`; frames under Polestar's own windows,
which hang off `UIParent`, are made with `CreateFrame`. No `CreateFramePool`
with a game frame either: it calls `CreateFrame` with its parent.
`tests/lua/wow_stub.lua`'s `CreateFrame` raises on a call from addon code
whose parent is, or is under, a frame addon code did not make
(`stub.underGameFrames`), and `tests/nav-mapcanvas.test.js`,
`tests/qol.test.js` (the reward marks) and `tests/talents.test.js` (the
talent marks) check that none was made.

### Gamepad interface

```lua
Polestar.GamepadUI() -> bool   -- Forever's Gamepad interface style is on (read once, as the addon loads)
Polestar.CloseOnEscape(name)   -- add a Polestar window to UISpecialFrames, except with the gamepad interface
Polestar.RunCommand(msg)       -- what /polestar runs; registered as a slash command only with the keyboard and mouse
```

With Forever's Gamepad interface on (Options, Gamepad, Enable Gamepad UI;
`C_InputInterfaceStyle`, which decides: the CVar `InputDeviceInterfaceStyle`
can stay at Gamepad with the keyboard and mouse, so it is read only on a
client without the API), its navigation
(`Blizzard_GamepadSmartNavigation`, `FrameControlsManager`) opens, closes
and focuses the game's windows, popups, menus and chat box from Blizzard's
code, and in the same execution makes protected calls
(`SetPreferredGamepadInteractTarget`, `RunBinding`, `DescendStop`). Addon
code running in that flow gets them blocked, and the "AddOn blocked"
popup's own gamepad handling blocks the next one, thousands of times, until
the client freezes. An addon whose only code is an empty slash command
reproduces it (Blizzard forum threads 2367777 and 2370253). Other Forever
addons (EllesmereUI, Olympus, Questie) do the same as Polestar: with the
gamepad interface on, they keep to their own windows.

`GamepadUI()` reads the style once, as `Core/Init.lua` loads (the client
reloads the UI when it changes). With it on, Polestar:

- registers no slash command: `/polestar`, `/pole`, `/way` (Nav/Journey)
  and `/psrec` (Polestar_Recorder, which reads the style itself). The chat
  box calls a command's function, then closes itself in that function's
  taint. The minimap button, on by default then (`maps.minimapButton`), and
  the key bindings open Polestar; the Recorder page calls
  `PolestarRecorder_Command`;
- adds no entry to the world map and minimap tracking menus
  (`Menu.ModifyMenu`, Nav/Nearby);
- puts no window in `UISpecialFrames` (`CloseOnEscape`), which the
  gamepad's menus read and close;
- opens no world map (`Compat.OpenWorldMap`; a dungeon page has no "Show
  on map") and adds no canvas click handler to it (Nav/Journey);
- never closes the game's Settings panel for "Open Polestar settings"
  (UI/Options: the chat says to close it);
- hooks no button the gamepad's navigation moves over: no Polestar line on
  talent tooltips (Talents/Overlay), no route on the flight map
  (QoL/Flight; the node keeps its mark), no quest levels in the game's
  quest windows (Quests/QuestLevels, whose surfaces lay out windows the
  gamepad manages);
- leaves the game's request dialogs for the player (QoL/Social) and the
  error-message setting off (QoL/Toggles, which writes the game's
  `BLACK_LISTED_MESSAGE_TYPES`);
- sets no override binding on the gamepad's buttons: a Polestar window
  holding the gamepad reads them through its own frame only; binds no chord
  unasked and names every chord on LB or RB as the game's own; and only
  reads the gamepad's focused window, never calls into its managers
  (UI/Gamepad, see [Gamepad](#gamepad-uigamepadlua-uigamepadguidelua)).

Frames under the game's frames are made through `CreateFrameUnder` and the
maps are only read (MapCanvas) with either style. The quest automation, the
vendor and the trainer stay on: they call the game's API, never its
windows, and the game opens and closes those from its own event handlers.
`tests/gamepad-ui.test.js` loads Polestar with each style, and lists every
line of addon code that reaches into the game's UI (slash commands,
`UISpecialFrames`, menus, panels, popups, the world map's tables, the error
frame's settings, override bindings, the gamepad's managers): a new one fails
there until it is guarded and listed.

### Localisation

`Polestar.L[key]`: a key is the English text, and a missing key returns
itself, so a client without a translation reads English. A locale file
(`Locales/<locale>.lua`, one per language of `tools/lib/i18n/locales.js`,
loaded by `Core/Core.xml` right after `Core/Init.lua` and returning at once on
another client) fills `L` for its client, so every file after it may read `L`
at load; Init.lua, which loads before it, reads `L` only when it prints (the
commands register in Core/Commands.lua). docs/TRANSLATING.md describes the
files and `node tools/polestar.js i18n`.

A word with more than one meaning gets a key per meaning:
`Polestar.LC(context, text)` is the translation of `"<context>: <text>"`, and
`text` while there is none: a dungeon boss that is a chest is
`LC("boss", "Chest")`.

A game term the client names itself is shown in the client's words and has no
key: reputation standings (`Polestar.StandingName(n)`,
`FACTION_STANDING_LABELn` in the character's gender through `GetText`), item
qualities (`Polestar.QualityName(q)`, `ITEM_QUALITYn_DESC`), the factions
(`Polestar.FactionName(f)`, `FACTION_ALLIANCE`, `FACTION_HORDE`), gear slots
(`Gear.SlotName`, `HEADSLOT`…) and the Dungeon Journal (`ENCOUNTER_JOURNAL`).
The test client (`tests/lua/wow_stub.lua`) holds their English values.
Class and race names come from the client too, keeping their keys only as the
fallback: `UI.ClassName` reads `LOCALIZED_CLASS_NAMES_MALE`, `UI.RaceName`
reads `C_CreatureInfo.GetRaceInfo` by the Era races' ChrRaces IDs. Skyborne
reads its key: the client names it only per side ("High Order Skyborne",
"Windshaper Skyborne").

Every player-facing string is written as a literal `L["..."]` or `LC(...)`
where it appears, so `i18n keys` and a translator find every key: a table of
labels holds `L["Home"]`, not `"Home"` translated later through
`L[VIEW_LABEL[v]]`. `L[variable]` is left only for text that comes from data
(a guide's category, race and class names, profession and spec names, the
talent plans' spec names, the release stage), each listed in `DATA_KEYS`
(`tools/lib/i18n/keys.js`, which also reads Gear/Weights.lua's spec labels,
Talents/Builds.lua's `specs` and the Dungeons attunement notes of
`tools/lib/codex/attunements.json`). Generated files carry their prose as
literal keys too: `talents build` writes the plan summary and per-level notes
as `L["..."]` in `Talents/Builds.lua`. Data that names a game thing carries
its id instead, and the display asks `Polestar.Names` (quests, NPCs, objects,
items, spells, factions, instances, areas, flight points, encounters). The
optional Recorder has its own `ns.L` and `Locales/<locale>.lua` (listed in
its TOC); `i18n check` and `sync` cover it too.

`Polestar.AI_LOCALES` names the languages whose translation is AI-made
(`status: "ai"` in locales.js; `tests/i18n.test.js` keeps the two equal). On
such a client with its file loaded, `Polestar.AITranslation()` is true and
Options > About says so, with the Discord invite.

### Names

`Polestar.Names` (`Core/Names.lua`) names quests, NPCs, objects, items,
spells, factions, areas, instances, flight points and dungeon encounters in
the client's language. The guides and data packs keep their English; where a
name is shown or matched, the caller asks Names first and keeps its English
when the answer is nil:

```
Names.Quest(id) / Names.Npc(id) / Names.Object(id) / Names.Item(id) -> name | nil
Names.Spell(id) / Names.Faction(id) / Names.Area(areaID) / Names.Instance(mapID)
  / Names.Taxi(id) / Names.Encounter(id) -> name | nil
Names.Get(kind, id) -> name | nil      -- the above by kind: quest npc object item
                                       -- spell faction area map taxi encounter,
                                       -- else the kind's pack table
Names.Cached(kind, id) -> name | nil   -- never asks the server; items from the pack only
Names.Learn(unit) -> name | nil        -- keeps the name the client shows for unit
Names.Localised() -> bool              -- false on enUS and enGB
Names.Ready() -> bool                  -- the pack is in, or will not load this session
Names.PackName() -> "Polestar_Names_<locale>" | nil
Names.Add(locale, kind, { [id] = name })   -- the pack's files only; any kind
```

- **Order.** The client's own name first, where the client has an API by id:
  a quest's title (`Compat.GetQuestTitle`, `C_QuestLog.GetTitleForQuestID`),
  an item's name (`Compat.GetItemName`, `C_Item.GetItemNameByID`), a spell's
  (`C_Spell.GetSpellName`, `GetSpellInfo`), a faction's (`C_Reputation`,
  `GetFactionInfoByID`; a faction the character has not met falls to the
  pack) and an area's (`Compat.GetAreaName`). An instance is the pack's
  first (`map`, Map.csv), then `GetRealZoneText(mapID)` when that names
  somewhere other than the current zone (an older client ignores the
  argument). Flight points (`taxi`) and encounters are the pack's only.
  Then the names pack of the client's
  language, `Polestar_Names_<GetLocale()>`, loaded through `Data.Pack` on the
  first ask (refused in combat, it loads when combat ends, fires
  `NAMES_LOADED` and redraws the guide window once; a missing
  folder is final for the session and harmless). Then nil. On an English
  client every answer is nil and nothing loads.
- **Learned in play.** The client has no API for NPC or object names by id,
  but it names the units it shows: on `PLAYER_TARGET_CHANGED`,
  `UPDATE_MOUSEOVER_UNIT`, `NAME_PLATE_UNIT_ADDED` and the NPC windows
  (`GOSSIP_SHOW`, `QUEST_GREETING`, `QUEST_DETAIL`, `QUEST_PROGRESS`,
  `QUEST_COMPLETE`, `MERCHANT_SHOW`, `TRAINER_SHOW`: the `npc` unit, a
  quest-giving object's GUID too) `Names.Learn` keeps the unit's name by its
  GUID's id in `PolestarDB.names[<locale>].npc` / `.object` (account-wide,
  per client language, read through `ns.DB()` each time; player-controlled
  units are skipped; a name equal to the pack's is not kept; at most 2,000
  ids, `order` oldest first, the oldest tenth dropped past the cap).
  `Names.Npc` and `Names.Object` answer a learned name before the pack's. A
  new or changed one fires `NAME_LEARNED(kind, id)`, and redraws the guide
  window once when the current or next step names that id. The Codex's
  decoded records, the open dungeon page and ItemDB's parsed quests and
  sources drop their copies on `NAME_LEARNED` and on `NAMES_LOADED`.
- **Asking the server.** A quest or item the client has not cached is asked
  for once a session (`Compat.RequestQuest`, `Compat.RequestItem`); the
  pack's name, or the English, shows meanwhile. When asked names arrive
  (`QUEST_DATA_LOAD_RESULT`, `ITEM_DATA_LOAD_RESULT`), one `STEP_UPDATED`
  per burst refills the guide window's rows.
- **Consumers.** The guide window's labels (`Engine` `describe`, the quest
  title order: on a non-English client the client's title before the guide's
  English one; skill goals' professions through `L`, learn and craft goals'
  spells and rep goals' factions by id; the class trainer of
  `Engine.NearestClassTrainer`), the target button's `/targetexact`
  (`QoL/Buttons.lua`), the
  quest database's names (`QuestDB.GetQuestTitle`, `EntityName`, `GetNpc`,
  `GetItem`, `GetItemDroppers`, `GetObjectiveMobs`: tooltips and the target
  button's droppers), objective matching (`Quests/Tracker.lua`: a client line
  is matched on the translated name before falling back to order, and object
  tooltips find their objectives by the translated name), the Codex's
  records (`Codex.Item/Npc/Object/Quest`, an instance's bosses and
  `Codex.Name` for those kinds: so Lookup, its sources, the item-tooltip
  spotter and Rares read them translated), a dungeon page as it is decoded
  (`Dungeons/Dungeons.lua`: quest titles, start and finish points, reward and
  starting items, keys, bosses by encounter, NPC or object, attunement
  names), the gear advice's leveling data (`ItemDB.ItemName`, `Quest`,
  `Sources`), and `Search`: on a
  non-English client each Codex kind's index gets, once, a line per id whose
  translated name (or, for zones, the client's map name) differs, a match
  counts an id once and is listed under its translated name. The collect
  goals' compiled sources carry their ids (`fromId`, `fromAlsoId`, of kind
  `fromKind`), so the goal line names them in the client's language;
  `from` and `fromAlso` are the English for older packs and English clients.
- **The packs.** One load-on-demand addon per language
  (`addon/Polestar_Names_<locale>/`: `Names.lua` calling `Names.Add` per
  1,000 names and kind, the TOC, `LICENSE-DATA.txt`, Ding's `CREDITS.md`),
  committed and shipped. Kinds: `quest`, `npc`, `object`, `item`, and `map`
  (instance maps), `encounter` (DungeonEncounter ids), `faction`, `taxi`
  (TaxiNodes ids) and `objective` (the objective text of the dungeon quests
  whose objective is an event). `node tools/polestar.js i18n names` builds
  them, per id the first source with a name winning: the client's own
  tables in that language (wago.tools with `&locale=`: Forever's ItemSparse,
  Map, DungeonEncounter, Faction and TaxiNodes, then the Era client's
  ItemSparse for the items Forever's lacks; the newest build holding every
  one in English and each language, and none stops the build), Wowhead's
  Forever database in that language (read from `data/sources/wowhead/names`;
  without that cache this source is empty; a bracketed name is no translation), DingDB (cloned into
  `data/sources/ding`, pinned to a commit and its files' sha256s: `DING` in
  `tools/lib/i18n/names.js`), then pfQuest's `db/<locale>` (no esMX). A name
  equal to the English one, from any source, is never stored: a translation
  from a later source wins, else the English shows as it would; a name
  marking unused content (`[PH]`, `[UNUSED]`, `(DNT)`, `<NYI>`, `(test)`
  and their translations) is none. Areas need no pack: the client names
  them by id (`Compat.GetAreaName`). Only the ids the compiled guides, the
  quest database, the Codex's data and the travel data name are kept.
  `--no-questie` leaves DingDB out. `Data.CheckInstall` checks the client's
  pack like the other optional data packs: never missing, named when its
  version differs.

### Guide texts

`Polestar.GuideTexts` (`Core/GuideTexts.lua`) shows a guide's own words in
the client's language. A compiled guide's texts (its `title`, `why`, `pitch`,
`pros`, `cons` and reward `text`; each step's `title` and `note`; each goal's
`note` and `text`) carry the game's names as tokens, `{kind:id}`, and the
guide's `names` hold each token's English (tools/lib/dsl/tokens.js;
docs/PACK_FORMAT.md, "Format 3"). `RegisterGuide` hands each guide to
`GuideTexts.Prepare` before escaping it, which rewrites every text in place
as the pack's translation into the client's language (else the English)
with each token filled: `Names.Cached` for quests, NPCs, objects and items
(never asking the server), `Names.Get` for spells, factions and areas, the
client's map name for a zone, `L` for a profession; else the token's
English. A guide's `folder` and the pack's title and notes are the pack's own
texts; a folder named after a class reads as `LOCALIZED_CLASS_NAMES_MALE`'s.

```
GuideTexts.Prepare(def, live) / GuideTexts.Refresh(def) -> changed
GuideTexts.Load(addon) -> "loaded" | "combat" | nil
GuideTexts.TextsAddon(addon) -> "<addon>_<locale>" | nil   -- nil on English
GuideTexts.PackText(packId, text) -> translation | text
Polestar.RegisterGuideTexts(locale, packId, { pack = {...}, guides = { [id] = {...} } })
```

- **Loading.** The translations of a pack are its texts addon for the
  client's language, `<pack addon>_<locale>` (load on demand, generated by
  `compile` from the pack's `locales/<locale>/` files): only that one loads,
  only on that client, through `Data.Pack`, at the pack's own
  `ADDON_LOADED`. While the pack's files load, its guides show their English
  names (asking Names then would load the names pack in the middle of
  another addon's files); at its `ADDON_LOADED` `Core/Guides.lua` loads the
  texts addon and refreshes the pack's guides, their headers and the pack's
  title and notes, with the names. A texts addon refused in combat loads on
  `PLAYER_REGEN_ENABLED`; a names pack landing late (`NAMES_LOADED`)
  refreshes every guide; a refresh after login fires `GUIDES_REGISTERED`, so
  the guide window, the menus and search read the new texts.
- **English clients** fill the tokens once at registration and keep nothing
  else; no texts addon loads. A text in the guide's `written` (one spelling
  a name otherwise than its token's English, "Dendrite" for Dendrite
  Starblaze) reads as the author's words there.
- `Data.CheckInstall` checks the client's texts addon of our pack like the
  names pack: never missing, named when its version differs.

### Compat — the client's game data goes through here

UI, Nav and Engine read the client's quests, map, units and items through
`Polestar.Compat`, with these exceptions that call the client themselves:
Nav's Blizzard user waypoint (`C_Map`, `C_SuperTrack`; `Nav/Bridges.lua`),
the minimap's radius, shape, rotation and indoors state (`Nav/Pins.lua`;
`Maps/RouteLines.lua` reads them through `Pins.MinimapView()`), the gamepad's
map cursor and A (`SoftCursor`, `IsKeyDown`; `Nav/Pins.lua`), the map frames
Polestar draws on (only read; `Nav/MapCanvas.lua`),
the run speed, taxi nodes, hearthstone cooldown and ghost state (`GetUnitSpeed`,
`C_TaxiMap`, item cooldown, `UnitIsGhost`; `Nav/Travel.lua`), the player's
height for the walking engine (`Compat.GetPlayerUnitPosition`, `Nav/Walk.lua`), the zone art's map art
layers and exploration (`UI/ZoneArt.lua`), the class name in the options
(`UnitClass`, `UI/Options.lua`), quest level colours
(`GetQuestDifficultyColor`, `UI/Dungeons.lua`), item names, icons and
quality colours (`C_Item`; `UI/Dungeons.lua`, `UI/GearPick.lua`,
`UI/Lookup.lua`, `Rares/View.lua`), the game's item and spell tooltips
and modified clicks on Polestar's item and spell buttons
(`GameTooltip:SetHyperlink`, `SetSpellByID`, `HandleModifiedItemClick`,
`ChatFrameUtil.InsertLink`; `W.ItemTip`, `W.SpellTip`, `W.ItemClick`,
`W.SpellClick` in `Theme/Widgets.lua`), the
travel button's secure action button
(`SecureActionButtonTemplate`, `CooldownFrameTemplate`), its item and spell
icons, names and cooldowns (`C_Item.GetItemIconByID`, `GetItemIcon`,
`C_Spell.GetSpellName`, `GetSpellInfo`, `C_Spell.GetSpellTexture`,
`GetSpellTexture`, `C_Container.GetItemCooldown`, `GetItemCooldown`) and
`IsPlayerSpell` when Compat has no `IsSpellKnown` (`Nav/Prompts.lua`), the
transport alerts' game sound and taskbar flash (`PlaySoundFile` on the Master
channel, `FlashClientIcon`; `Nav/Alerts.lua`), and the flight map's node
slots and hop lines (`GetTaxiMapID`, `C_TaxiMap.GetAllTaxiNodes`,
`TaxiNodeGetType`, `GetNumRoutes`, `TaxiGetNodeSlot`, `DrawLine` on
`TaxiRouteMap`; `QoL/Flight.lua`), and the transit sync's addon messages and
who hears them (`C_ChatInfo.RegisterAddonMessagePrefix`,
`C_ChatInfo.SendAddonMessage`, `CHAT_MSG_ADDON`, `IsInGuild`, `IsInGroup`,
`IsInRaid`, `IsInInstance`, `GetNormalizedRealmName`, `UnitName`, `Ambiguate`; `Nav/Transit.lua`), the hand-off to Shortest Path Forever
(`ShortestPathForever.API`, `UnitIsDeadOrGhost`; `Nav/Handoff.lua`), map clicks, `/way`
and the TomTom stand-in (`Nav/Journey.lua`: `IsShiftKeyDown`, `IsAltKeyDown`,
`IsControlKeyDown`, `GetMouseFoci` or `GetMouseFocus`, the open chat box
through `ChatFrameUtil.GetActiveWindow` or `ChatEdit_GetActiveWindow`,
`WorldMapFrame:AddCanvasClickHandler` (kept in Blizzard_MapCanvasSecureUtil's
registry, which calls addon handlers through `securecallfunction`),
`GetNormalizedCursorPosition`, `ScrollContainer:IsMouseOver`, the
`GLOBAL_MOUSE_DOWN` event, `Minimap:HookScript("OnMouseUp")`,
`C_Map.GetMapInfo`, `C_Map.GetMapInfoAtPosition`, `C_Map.GetBestMapForUnit`,
`C_Map.GetMapChildrenInfo`, `hooksecurefunc` on TomTom's own table, the
`TomTom` global and `SlashCmdList`), the cursor on the minimap
(`GetCursorPosition`; `Pins.MinimapCursor()`, `Nav/Pins.lua`), the nearby
services' tracking menus (`Menu.ModifyMenu`, `Nav/Nearby.lua`) and the
gamepad and key binding API (`C_GamePad`, `C_InputInterfaceStyle`,
`C_KeyBindings`, `SetBinding`, `GetBindingKey`, `SetOverrideBindingClick`,
`IsKeyDown`; `UI/Gamepad.lua`). Frame and system calls (`GetTime`, `GetServerTime`, `C_Timer`,
`InCombatLockdown`, the cursor, CVars, addon loading, the build and locale)
are not routed either. `Polestar_Nav` is a separate addon whose router
(started from Shortest Path Forever's) has no Compat, so it calls the client directly:
`C_EncodingUtil.DecodeBase64` and `C_EncodingUtil.DecompressString` with
`Enum.CompressionMethod.Zlib` (decoding a map cluster, `Routing/PathGrid.lua`),
`debugprofilestop` (the frame budget), `C_Timer.After`, `InCombatLockdown`
with a `CreateFrame` frame waiting for `PLAYER_REGEN_ENABLED`, and
`geterrorhandler` (`Routing/PathJobs.lua`). The world map is opened only
through `Compat.OpenWorldMap(uiMapID)` (`C_Map.OpenWorldMap`, the global
`OpenWorldMap` only on a client without it, never in combat;
`Compat.CanOpenWorldMap()` says whether it can): the global opener called
from addon code taints the map frame (NAV_QA C3), and
`tests/compat.test.js` rejects any other code that opens or moves the world
map. Routing the rest keeps Forever specifics in few places and lets other modules' tests
replace Compat with a fake.

Coordinates: map percent `x, y` in **0–100**. World coordinates follow
`C_Map.GetWorldPosFromMapPos`: `wx` is the north–south axis (larger is north),
`wy` is the east–west axis (larger is west), in yards.

```lua
Compat.IsSecret(v)              -> bool   (a secret value: comparing, indexing or parsing it throws)
Compat.Readable(v)              -> v | nil (a secret value reads as unknown)
Compat.Now()                    -> seconds since the epoch, server clock
Compat.GetPlayerInfo()          -> { name, realm, guid, level, xp, xpMax, race, class, faction }
                                   -- race = raceFile ("Human","Scourge",...), class = classFile ("WARRIOR"), faction = "Alliance"|"Horde"|"Neutral"
Compat.GetPlayerFaction()       -> "Alliance" | "Horde" | nil  (UnitFactionGroup; nil when neutral, unread or secret;
                                   -- the walking router's profile, Nav/Walk.lua)
Compat.GetPlayerMapPosition()   -> uiMapID, x, y | nil      (nil in instances / unknown)
Compat.GetPlayerWorldPosition() -> continentID, wx, wy | nil  (via MapToWorld of the above)
Compat.GetPlayerUnitPosition()  -> wx, wy, z | nil, instanceID | nil  (UnitPosition; the one place it is read; nil while secret;
                                   -- z nil also when the client reports exactly 0, as Forever's does)
Compat.MapToWorld(uiMapID, x, y, frame) -> continentID, wx, wy | nil
                                   -- frame "e": use registered Era frame for uiMapID (see Map frames); nil: live client
Compat.WorldToMap(continentID, wx, wy, uiMapID) -> x, y | nil
Compat.GetMapName(uiMapID)      -> string | nil
Compat.MapName(uiMapID)         -> string | nil   (the client's name, else the Codex zone's)
Compat.GetAreaName(areaID)      -> string | nil   (C_Map.GetAreaInfo: the area's name in the client's language)
Compat.GetContinentMap(uiMapID) -> continent uiMapID | nil
Compat.GetPlayerFacing()        -> radians | nil   (0 = north, counter-clockwise positive)
Compat.GetZoneText()            -> zone, subzone
Compat.IsQuestCompleted(questID)       -> bool   (flagged completed / turned in)
Compat.IsOnQuest(questID)              -> bool
Compat.IsQuestReadyForTurnIn(questID)  -> bool
Compat.GetQuestObjectives(questID)     -> { { text, type, finished, numFulfilled, numRequired }, ... } | nil
Compat.GetQuestTitle(questID)          -> string | nil (client cache; may be nil)
Compat.GetOfferedQuests(source)        -> { questID, ... } | nil   (source "gossip" | "greeting" | "detail")
Compat.IsQuestTrivial(qlvl, level)     -> bool   (grey for that level)
Compat.GetItemCount(itemID, includeBank) -> number   (includeBank: the bank's too)
Compat.GetItemQuality(itemID)          -> 0..7 | nil (nil while not cached)
Compat.ItemQualityHex(quality)         -> "ffrrggbb" | nil
Compat.ItemIcon(itemID)                -> icon | nil (C_Item.GetItemIconByID; no cache needed)
Compat.SpellIcon(spellID)              -> icon | nil
Compat.ItemLink(itemID)                -> link | nil (nil while not cached)
Compat.RequestItem(itemID)             -> bool   (cached; else requested: GET_ITEM_INFO_RECEIVED follows)
Compat.SpellLink(spellID)              -> link | nil
Compat.RequestSpell(spellID)           -> bool   (cached; else requested: SPELL_DATA_LOAD_RESULT follows)
Compat.GetBindLocation()               -> string | nil
Compat.IsOnTaxi()                      -> bool
Compat.GetCurrentTaxiNode()            -> name of the open taxi map's node | nil
Compat.GetNpcID(unit)                  -> number | nil   (from UnitGUID)
Compat.InCombat()                      -> bool
Compat.IsInInstance()                  -> bool
Compat.IsIndoors()                     -> bool | nil (the client's indoor state; nil without IsIndoors or when secret)
Compat.IsShiftKeyDown()                -> bool
Compat.AddOnPresent(name)              -> bool   (installed and enabled: loaded, or loadable after Polestar)
Compat.Supports(feature)               -> bool   ("skill" | "spell" | "faction" | "explore" | "achievement")
Compat.GetSkillRank(skillLineOrName)   -> rank, maxRank | nil  (profession/secondary skill)
Compat.IsSpellKnown(spellID)           -> bool
Compat.GetSpellCooldown(spellID)       -> start, duration (GetTime seconds; 0, 0 when ready or secret)
Compat.GetFactionStanding(factionID)   -> standingID (1 Hated .. 8 Exalted), value, barMin, barMax, name | nil
Compat.IsAreaExploredAt(uiMapID, x, y) -> bool | nil   (C_MapExplorationInfo)
Compat.GetAchievement(id)              -> { completed, name, criteria = { { text, completed, cur, max }, ... } } | nil
```

#### Map frames

Guide coordinates from Era-sourced data are in the **Era map frame**. Four
Forever maps changed frame versus Era (QuestieDB evidence: Mulgore, Eastern
Plaguelands, Redridge Mountains, Stormwind City), and more may. Packs embed
the Era world bounds for every map they reference:

```lua
Polestar.RegisterMapFrames({ era = { [uiMapID] = { c = continentMapID, left = wy0, right = wy1, top = wx0, bottom = wx1 }, ... } }, packId)
```

`packId` nil is Polestar itself (its data addons, class trainers). Frames from
Polestar and our pack (`guides`) win for a map both cover, whatever the load
order; another pack only adds maps they lack (lint warns where its frame
differs).

For frame `"e"`: `wx = top + (bottom - top) * y/100`, `wy = left + (right - left) * x/100`.
`Compat.MapToWorld(map, x, y, "e")` uses that; everything downstream (distance,
arrow, pins) works in world coordinates and converts back to live map percent
with `Compat.WorldToMap`. Coordinates without `f` are live-frame (recorded in
Forever) and use `C_Map.GetWorldPosFromMapPos` directly.

### Core services: Data, Hooks, Search

Shared by every module (summarised in `docs/SUITE.md`, "Runtime services");
each file's header lists its full API.

```lua
Polestar.Data.Pack(name) -> loaded, reason|nil   -- C_AddOns.LoadAddOn once per session; never in combat ("combat", retried later)
Polestar.Data.Info(name) -> { loaded, reason, memoryKB }

Polestar.Hooks.ItemLines(owner, fn(tooltip, link, itemID))       -- GameTooltip, ItemRefTooltip
Polestar.Hooks.UnitLines(owner, fn(tooltip, unit))               -- GameTooltip
Polestar.Hooks.ObjectLines(owner, fn(tooltip, objectID, name))   -- GameTooltip; either may be nil
Polestar.Hooks.ItemClick(owner, fn(link, itemID))                -- modified clicks on chat links, bag and loot items
Polestar.Hooks.AddLine(tooltip, left, right?, r, g, b, rr, rg, rb)

Polestar.Search.Query(text, opts) -> results, counts, more   -- opts = { kinds, limit = 60, perKind, offset, subtitles = false }
   -- result = { kind, id, title, subtitle, quality, score, status, curated }; exact > prefix > word prefix > substring
Polestar.Search.Subtitle(result) ; Search.KINDS ; Search.Status() -> codexLoaded, reason
```

`Hooks` owns the client hooks: `TooltipDataProcessor.AddTooltipPostCall`
(Item, Unit, Object) and a `hooksecurefunc` post-hook of
`HandleModifiedItemClick`, which bag buttons, loot buttons and chat links
(`SetItemRef`) all reach. One entry per owner, callbacks in registration order,
each in its own `pcall`; forbidden tooltips and secret values are skipped.
`Search` matches guides (titles, `keywords`, folded once per guide list) and
the Codex kinds through the pack's prebuilt index (`Codex.Index(kind)`: one
string of folded names per kind), so a keystroke is a few plain `string.find`
calls and never decodes a record. Each kind reads at most 200 candidates per
query, best tiers first (`more[kind]` says there were more); a one-letter
query matches name prefixes only. Only the results returned are named, and
subtitles are filled per shown row (`Search.Subtitle`). Generated `lookup/`
guides are not listed.

Measured with the real pack (lua5.1, `tests/lookup-codex.test.js` setup):
the pack loads in about 20 ms (4.4 MB; it never loads at login), the first
query costs 7 ms (guide headers), a keystroke 1.5–4 ms (1 to 8 letters), a
detail page (`Lookup.Sources`) 0.1 ms for a mount up to 10 ms for an item
with 40 drop sources.

### Guide data (compiled Lua) — the toolchain/Engine contract

Generated by `tools/polestar.js compile` from `.guide` sources
(`docs/GUIDE_FORMAT.md`) into the pack's addon folder: the generated TOC,
`Pack.lua`, `MapFrames.lua`, `Guides.lua` (one `RegisterGuide` per guide, each
built in its own function) and `LICENSE-DATA.txt`, plus `LICENSE.txt` (the
pack's `LICENSE`) when the pack folder has one. Ours is
`addon/Polestar_Guides/`; a community pack's is `<pack>/dist/<folder>/`. The
full contract for pack authors' tools is `docs/PACK_FORMAT.md`.

```lua
local ADDON = ...
Polestar.RegisterPack({ addon = ADDON, id = "guides", format = 2, title = "Polestar Guides",
  author = "Polestar", version = "0.2.0", license = "GPL-3.0-only" })   -- optional: website, source, notes

Polestar.RegisterGuide({
  id = "forever/alliance/human/01-elwynn-forest",
  pack = "guides",
  title = "Elwynn Forest",
  faction = "Alliance",            -- "Alliance" | "Horde" | nil (either)
  races = { "Human" },             -- raceFile list or nil (any)
  classes = nil,                   -- classFile list or nil (any)
  minLevel = 1, maxLevel = 13,
  category = "Leveling",
  zone = 1429, zoneName = "Elwynn Forest",
  next = "forever/alliance/02-westfall",   -- or nil
  author = "Polestar", version = 1,
  group = true,                    -- or nil: a goal of the route (not optional) needs a group
  reward = { { spell = 23161, spellName = "Summon Dreadsteed" } },  -- or nil: what the goal gives (format 2)
  why = "...",                     -- or nil: one line on why it is worth doing (format 2)
  steps = {
    {
      title = "Deputy Willem",     -- optional
      note = "...",                -- optional, player-facing
      only = { classes = { "WARRIOR" }, races = { "Human" }, factions = { "Alliance" } },  -- optional, AND across keys, OR within
      goals = { goal, ... },       -- at least one
    },
  },
})
```

Goal fields. Common: `t` (verb), `text` (display override), `note`,
`optional` (true = never blocks the step), `only` (same shape as step `only`),
`map`, `x`, `y` (0–100), `f` (`"e"` = Era frame, absent = live), `r` (arrival
radius in yards), `group` (group content, below). A goal placed at an NPC or
object that spawns at several
places carries spawn areas, `spots = { { x, y, r, n, alt }, ... }`: cluster
centre in the goal's `map` and frame, radius in yards, spawn count; together
they cover every spawn of the target on that map. Camps nearest to the goal's
`x`/`y` first, at most 6 (a target with 6 spawns or fewer gets a spot at every
place it spawns); with `spread = true` (an area objective, or a few places far
apart) up to 12 spread over the whole area, as a walk from `x`/`y`. The other
places follow with `alt = true`; a hand-placed point is the first spot, the
data's places its alternatives (GUIDE_FORMAT, "Spawn areas"). `x`/`y` stay the
default point. `z` (optional, 0.2.4) is the height of the NPC or object the
goal's `x`/`y` stands for (the compiler's, from `spawnz.json`: GUIDE_FORMAT,
"Heights"); a spot and a smart target's candidate may carry their own `z`
(0.2.5, #180), by the same rule from their own point. The Engine puts the
height of the place it leads to on the waypoint (`posOf`: the chosen
candidate's `z`, else the chosen spot's, else the goal's while the waypoint is
the goal's own point), and on the step view's goals and groups, so a click on
a goal's row, header or map pin and the training reminder's and Nearby's class
trainer (`Nav.SetTarget`'s `z`) keep it; the walk to it is searched with it
("Walking paths" under Nav). Packs stay format 2: an older Polestar ignores it.

Group content (format 2; GUIDE_FORMAT, "Group content"): `group = { kind =
"elite", rank = 1|2|3 }`, `{ kind = "dungeon"|"raid", name = "Dire Maul" }` or
`{ kind = "group", size = 3 }` (`size` optional), derived by
`tools/lib/dsl/group.js` (elite work; the solo filter's instance rule,
`tools/lib/sim/solo.js`) unless the author wrote `group [N]`. Display only:
the Engine carries it into the goal view as `party` (the view's `group` is
the goal's field group) and the guide window says it under the goal
(`UI.GroupLine`: "Elite: group advised", "Dungeon: Dire Maul", "Group of 3
advised"), once per card. The guide's `group = true` (some non-optional goal
has `group`) is the guide menu's "Group" chip.

Escort quests (GUIDE_FORMAT, "Escort quests"): `escort = true` on an escort
quest's accept, `complete` and objective goals, derived by
`tools/lib/dsl/escort.js`. Display only: the Engine carries it into the goal
view as `escort` and the guide window says it under the goal
(`UI.EscortLine`: "Escort: if the NPC is not there, wait for it to
respawn"), once per card. Older Polestar ignores it.

A guide's `reward` (format 2; GUIDE_FORMAT, `reward`) lists what its goal
gives: `{ item, itemName, quality, choice }`, `{ spell, spellName }` or
`{ text }`; its `why` is one line on why. Display only: the guide menu's
details lead their facts with them (UI/Picker.lua): the entries given
outright under "Reward", the `choice` ones under "Choose one", each a tile
with the item's or spell's icon (`Compat.ItemIcon`, `Compat.SpellIcon`; a
glyph for words and unknown ids), an item's name in its quality colour
(the client's when cached, else the compiled `quality`) and the game's item
or spell tooltip on hover (`W.ItemTip`, `W.SpellTip`: set again when an
uncached item or spell arrives while the tile still owns the tooltip; the
pane requests its items and spells as it paints them); a modified click acts
as on a bag item (`W.ItemClick`: Shift links, Ctrl tries it on, Alt guides;
`W.SpellClick`: Shift links the spell); then "Why".

| `t` | Required | Optional | Done when (Engine) |
|---|---|---|---|
| `accept` | `quest`, `title` | `npc`/`npcName`, `object`/`objName`, `item`/`itemName`, `minLevel`, `qlvl`, `pre`, `preAll`, `closedBy`, `preTitles` | on quest **or** completed |
| `turnin` | `quest`, `title` | `npc`/`npcName`, `object`/`objName`, `rewards = { choices = { { item, itemName, quality } }, items = { ... }, xp, money }` (copper), `direct` | completed; `direct` (never accepted, so never orphaned): its QUEST_TURNED_IN during the step (latched) or the completed flag, not the session's turn-ins, so one hand-in of a repeatable closes one goal |
| `complete` | `quest`, `title` | — | ready for turn-in or completed |
| `kill` | `target` | `npc`, `count`, `quest`, `oi` | objective `oi` finished, or quest ready/completed (not while the log lists no objectives yet, right after the accept); without `quest`: manual |
| `collect` | `item`, `itemName` | `count`, `quest`, `oi` | objective finished / quest ready (as `kill`) / completed; without `quest`: item count ≥ `count` |
| `goto` | `map`, `x`, `y` | `text`, `r` (default 8 yd), `area` (its name in the client's language shows instead of `text`) | within radius, **or** gone into its `area` (subzone text equals the client's name of it, not the zone's, while indoors, after being seen elsewhere since the step came up; not for a goto after one into the same area in the step), **or** any later goal in the step is done, **or**, when only gotos, notes and goals that do not apply follow it in the step, the next step that applies is done with a quest goal of it done (`Own.nextStepDone`, counted as anchorStep counts: not a skipped step or one with `only`, not a goal with `only`; a cave's mouth or a dock ahead of work done ahead of the guide, #240) |
| `talk` | `npc`, `npcName` | — | gossip/quest frame opened with that NPC during this step; else manual |
| `interact` | `object`, `objName` | `quest`, `oi` | objective state if `quest`; else manual |
| `use` | `item`, `itemName` | `quest`, `oi` | objective state if `quest`; else manual |
| `sethome` | `location` | `npc`, `npcName`, `area` | bound at the goal's inn (`npc`'s, else the inn `location` names, in Nav/Travel.lua's data), by any of: the inn Travel finds for `GetBindLocation()` (`Nav.BoundInn`: the innkeeper learned at bind time in `flags.inn`, else the inn whose `area` the client names so, else its names); `GetBindLocation()` equal to the client's name of that inn's or the goal's `area` (`Compat.GetAreaName`); last, equal to `location` (case-insensitive). Binding at that innkeeper during the step latches it |
| `hearth` | `location` | `area` | zone or subzone equals the client's name of `area` (without one, `location`), else manual |
| `getfp` | `location` | `npc`, `npcName`, `node`, `area` | with `node`: that taxi node among the known ones (`flags.taxi`, recorded by Nav/Travel.lua from the flight map); without: taxi map opened at a flight master of that name (persisted in `flags.fp`); else manual |
| `fly` | `location` | `area`, `node` | as `hearth` (`node`: the flight point, named in the client's language where no `area` names the place) |
| `train` | — | `npc`, `npcName`, `text` | trainer window opened during this step, else manual |
| `buy` | `item`, `itemName` | `count`, `npc`, `npcName` | item count ≥ `count` (default 1) |
| `vendor` | — | `npc`, `npcName`, `text` | merchant window opened during this step, else manual |
| `level` | `level` | — | player level ≥ `level` |
| `note` | `text` | — | never blocks (informational) |
| `skill` | `skill` (name), `level` | `skillLine` | skill rank ≥ `level` |
| `learn` | `spell`, `spellName` | `skillLine`, `npc`/`npcName` (trainer), `item` (recipe item) | spell known |
| `craft` | `spell`, `spellName` | `item`/`itemName` (created), `count`, `untilSkill`, `skillLine`, `reagents = { { item, itemName, count } }` | skill ≥ `untilSkill` if set, else created-item count ≥ `count`, else manual |
| `rep` | `faction`, `factionName`, `standing` (1–8) | — | standing ≥ `standing` |
| `explore` | `map`, `x`, `y` | `text` (area name) | area at that point explored; else arrival (latched) |
| `achieve` | `achievement`, `achievementName` | `criteria` (index) | achievement (or that criterion) completed |

Objective index `oi` is 1-based, matching `C_QuestLog.GetQuestObjectives`.
Field names `npc`, `object`, `item`, `quest` always hold numeric IDs.
Objective goals also carry the quest's `title`; `accept` carries `minLevel`
from the data when the author gave none, `qlvl` (quest level), the blocking
prerequisites `pre` (one of) and `preAll` (every one), `closedBy` (the quest
its breadcrumb leads to and the quests exclusive with it: once any of them is
taken or done the giver never offers it again) and `preTitles` (titles of the
quests those name, for the reason texts). Every goal of a quest only
characters with a profession can take (quests.json `skill`, `skillLevel`:
QuestieDB's Forever `requiredSkill`; pfQuest's Classic skill is not used for
a quest the Forever store lists)
carries `profLine` (skill line), `profName` and `profRank` (1 when the data
has no level): the Engine treats the goal as not this character's (status
`"na"`, like another class's goal) while `Compat.GetSkillRank` reports no rank
or a lower one, unless the quest is in the log or done or the client cannot
read skills, and checks again on `SKILL_LINES_CHANGED`. `only !Class` compiles
to the list of the other eight classes, so compiled guides never contain
negations.

### The guide registry (`Core/Guides.lua`)

Every guide belongs to a registered pack. The rules a pack meets (ids, no
overrides, clashes, map frames, format, problems, literal text, packs on disk
and their statuses) are in PACK_FORMAT.md, "Rules Polestar enforces"; lint
applies the same ones (`tests/packs-parity.test.js`). Where `Core/Guides.lua`
implements them:

- Ids: `Guides.RESERVED` (reserved pack ids) and `Guides.OwnsId` (which
  prefix a pack owns: `forever/` and `draft/` for `guides`, `lookup/` for the
  internal `lookup` pack, registered with `internal = true` and never listed
  or switchable, `<id>/` for every other pack).
- Clashes: guides and map frames a refused pack's files register are dropped
  until that addon's `ADDON_LOADED`; guides registered before their pack are
  refused, their ids kept in a per-pack list and listed as `guide-refused`
  problems when it comes.
- Format: `Guides.FORMATS` (the formats this Polestar reads, `1` and `2`);
  `Guides.Validate` checks each guide against the `REQUIRED` verb table
  (`Guides.VERBS`).
- Problems: each refusal goes on the pack's record,
  `problems = { { kind = "pack-refused"|"guide-refused"|"no-guides", guide?, message } }`,
  and to `ns.Debug`.
- Literal text: `ns.EscapeText` (`|` doubled), ids excepted.
- Packs on disk: `Guides.ScanInstalled`, at login before `GUIDES_REGISTERED`,
  gives every addon whose TOC has `X-Polestar-Pack` and never registered a
  record from its TOC.

A pack record: `id`, `addon`, `format`, `title`, `author`, `version`,
`license`, `website`, `source`, `notes`, `official` (ours), `status` (the
statuses of PACK_FORMAT rule 9; `off` from `PolestarDB.packs[id].off`),
`reason`, `needs`, `problems`, `guides` (ids), `guideCount`.

```lua
Polestar.RegisterPack(meta) -> ok, err
Polestar.RegisterGuide(def) -> ok, err      -- def.pack must be registered and own def.id; validates shape
Polestar.RegisterMapFrames(frames, packId)
Polestar.Guides.Packs() -> { record, ... }  -- every pack but internal ones, ours first, then by title
Polestar.Guides.Pack(id) -> record | nil
Polestar.Guides.PackShown(id) -> bool
Polestar.Guides.SetPackShown(id, shown)     -- PolestarDB.packs[id].off; fires PACKS_CHANGED(id)
Polestar.Guides.ProblemCount() -> n         -- over every listed pack (the Options dot)
Polestar.Guides.OwnsId(packId, guideId) -> bool
Polestar.Guides.SuggestSources() -> { packId, ... }  -- "guides", then shown packs with leveling guides
Polestar.Guides.SuggestSource() -> packId   -- behavior.suggestFrom when it can, else "guides"
Polestar.Guides.OfferedBy(id) -> { guide, ... }      -- shown guides whose route choice offers id
```

Only guides of shown packs (`on`, plus the internal `lookup`) are visible to
`Get`, `List`, `Suggestions`, `Suggest`, `OfferedBy`, search and
`Lookup.CuratedGuide`. `PACKS_CHANGED` refreshes the picker, search, the guide
window, Lookup and the Engine's tabs ("Tabs", absent guides).

### Engine

```lua
Polestar.Guides.Get(id) -> guide | nil
Polestar.Guides.List() -> { header, ... }   -- header = guide without steps, plus stepCount
Polestar.Guides.Suggestions() -> { id, ... } -- the leveling guides of the suggestion source (Guides.SuggestSource) for the player's faction/race/class/level, best first; ours fill in where it has none; none fits: the nearest upcoming one alone
Polestar.Guides.Suggest() -> id | nil       -- the first of Suggestions()

Polestar.Engine.GetGuide() -> guide | nil
Polestar.Engine.SetGuide(id)                -- persists CharState().guide, recomputes, fires GUIDE_CHANGED
Polestar.Engine.GetStepIndex() -> i | nil
Polestar.Engine.GetStepCount() -> n
Polestar.Engine.GetStepView(i) -> view | nil
Polestar.Engine.Next() / Prev() / Goto(i)    -- look at another step; changes nothing (Goto un-skips its target)
Polestar.Engine.Skip() -> stepIndex         -- skip the step shown, saved; fires PLAYER_SKIPPED_STEP
Polestar.Engine.Unskip(i) -> bool           -- undo a skip
Polestar.Engine.GetLiveStep() -> i | nil    -- the first open step, whatever step is shown
Polestar.Engine.StartGate(id) -> gate | nil -- a Class guide this character cannot start yet: { level } or { pre, preTitle }, with giver, map (see "Not yet available")
Polestar.Engine.ToggleGoal(stepIndex, goalIndex) -> bool   -- tick any goal but a note done, or clear its check-off
Polestar.Engine.SkipGoal(stepIndex, goalIndex) -> bool     -- skip an optional goal, or bring it back
Polestar.Engine.AimGoal(stepIndex, goalIndex) -> bool      -- lead the arrow to a goal of the current step (row click)
Polestar.Engine.GetWaypoint() -> waypoint | nil
Polestar.Engine.GetProgress() -> doneSteps, totalSteps
```

#### Smart logic

- **Candidate goals.** A compiled goal may carry `candidates = { { npc, npcName, map, x, y, z?, f, faction = "A"|"H"|"AH", races?, classes? }, ... }`
  (from `train <Profession>`, `train class`, `buy … nearest`, `vendor nearest`, `sethome nearest`; see GUIDE_FORMAT).
  The Engine filters by the character's faction (and races/classes when given),
  then picks the cheapest by `Polestar.Nav.EstimateTravel(from, to)` seconds when
  Nav provides it, else world distance on the same continent with a large penalty
  across continents. A candidate in a zone whose level range (`Maps.GetZoneLevels`)
  starts more than 10 levels above the character comes after every other
  choice, other continents included. It re-picks on step start, zone change and landing, never per
  frame. The goal view then carries the chosen `npc`, `npcName`, `map`, `x`, `y`,
  `f`, plus `alternatives = n`; `Polestar.Engine.CycleCandidate(stepIndex, goalIndex)`
  moves to the next-best one. Profession `train` goals are done when the
  profession's max rank reaches that rank's cap (75/150/225/300), so a trainer
  anywhere counts. `train class` is done on opening a trainer window for any
  candidate during the step, or when there is nothing new to learn: the
  character last visited its class trainer (`classTrainVisit`) at this level,
  or at the even level below an odd one, since class trainers teach on even
  levels only.
- **Spawn areas.** A goal with `spots` is positioned at one spot, distances
  measured to each area's edge (`Compat.GetPlayerWorldPosition`). Camps: the
  spot nearest the player; a different spot takes over only once it is 40 yd
  (`Spots.SWITCH`) nearer than the current one, so the waypoint never flaps
  between two camps and never moves while the player is inside the current
  area. Area objectives (`spread`): a spot counts as visited once the player
  has been within its arrival radius (`r` past its edge); the current spot
  stays while the player is within `r` + 4 yd of it, then the nearest spot not
  visited in the last 300 s (`Spots.FORGET`) takes over (the one the player
  stands in counts as not visited; all visited: the one visited longest ago),
  so the spots form a circuit. Spots with `alt` are never picked by these
  rules; they are reached by hand and, once picked, hold like any current spot
  (camps: until another spot is 40 yd nearer). `Engine.CycleSpot(stepIndex,
  goalIndex[, index])` moves on by hand to the nearest spot not visited lately,
  alternatives included (the current spot counts as visited), or to spot
  `index`; a spot picked that way holds until the player reaches it. It returns
  the new spot's index, or nil. Without a player position the first spot is
  used. The goto-arrival poll (0.5 s) re-picks the spot while the waypoint's
  goal has spots; a change re-evaluates (`STEP_UPDATED`, `WAYPOINT_CHANGED`). The goal
  view's `map`/`x`/`y` follow the chosen spot and it carries `spots` (count)
  and `spread`; the waypoint carries `area` (the spot's radius in yards) next
  to `r`, and with several spots `spots` (the goal's list) and `spot` (the
  current index), plus `search = true` for an area objective. The guide
  window's "Other" button cycles spots (CycleSpot) when the goal has no
  candidates; an area objective's subline reads "<mobs> all over this area: N spots".
  Cycling a goal of the current step (spots or candidates) aims the arrow at
  that goal (`AimGoal`), whichever goal it pointed at before, and the window
  releases any point picked by hand (`Nav.ReleaseTarget`), so the arrow moves
  to the chosen spot at once.
- **Race names.** `"Scourge"` and `"Undead"` are the same race everywhere a race is
  compared (Forever's client name is unconfirmed).
- **Context-aware Suggest.** `Guides.Suggestions()` orders the leveling guides
  that fit faction/race/class and level: the one whose zone is the player's
  current zone first, then the nearest by travel; ties keep the race's own
  chain. `Suggest()` is its first. The hub's Home lists all of them under
  "Suggested for you", open ones included (marked with their tab), then an
  open guide's follow-up once the player is within two levels of it.
- **Out-levelled guides.** When the player's level exceeds the active guide's
  `maxLevel` by 2 or more, the Engine fires `GUIDE_OUTLEVELED(guideId,
  suggestedId)` once per guide per session; the UI offers the jump. Setting
  `behavior.skipGrey` (default off) auto-skips `accept` goals for quests already
  grey for the character, and with them the quests' turn-ins and objectives,
  unless the quest is a prerequisite (`pre`, `preAll`) of a quest later in the
  guide or its chain that is not grey, directly or through other grey ones.
- **Class-training reminder.** Class trainers ship in the core:
  `Core/ClassTrainers.lua` (generated by `node tools/polestar.js trainers build`,
  one trainer per town and class, with the Era frames of their maps) calls
  `Polestar.RegisterClassTrainers({ { npc, npcName, map, x, y, f, faction, classes }, ... })`,
  then `Polestar.RegisterClassTrainerIds({ WARRIOR = { npcId, ... }, ... })`
  with every class trainer in `trainers.json`, not only one per town.
  `Engine.NearestClassTrainer()` returns the best one for the character (same
  ranking as candidate goals) or nil; `Engine.IsClassTrainer(npc)` whether an
  npc is any class trainer of the character's class, from the full id list
  (QoL learns spells only there).
  Opening the trainer window of one of the character's class stores
  `CharState().classTrainLevel = level` (and `classTrainVisit`, which a first
  sight never sets) and fires
  `CLASS_TRAINED(level)`; a character first seen without a stored level counts
  as trained at that level. With `behavior.trainReminder` `"2"` (default; even
  levels only), `"1"` or `"off"`, the Engine fires `TRAIN_DUE(level, trainer)`
  once per level when `level - classTrainLevel >= N`, unless the active tab's
  current step or its next applicable steps (4 in all) hold an applicable class
  `train` goal (an npc in the registry or `train class`). The UI shows a slim
  banner with Show (temporary `Nav.SetTarget`) and Later, cleared by
  `CLASS_TRAINED`; Options → Guide → Automation → "Trainer reminders".
- **Unavailable quests.** An `accept` whose `closedBy` names a quest that is
  in the log or done is unavailable before any visit (reason `"closed"`,
  "No longer offered: you took <quest>"): a breadcrumb whose follow-up is
  taken, or one version of an exclusive chain when another was taken. An
  `accept` that lacks a prerequisite the route no longer brings is
  unavailable before any visit too (reason `"pre"`, "Requires <quest>
  first"): one of `preAll`, or of `pre` when none of those is done, that is
  not done and that this guide does not still turn in (issue #70: Jorn
  Skyseer at the Crossroads needs The Angry Scytheclaws, the end of Sergra's
  chain in the previous Barrens guide). "Still turns in" is a `turnin` of
  that quest anywhere in the guide, before the accept or after it, that is
  not optional, applies to the character, is not in a skipped step, not
  skipped or ticked itself, and not unavailable in turn (followed down the
  chain of prerequisites, at most 8 deep): that prerequisite is the route's
  own business, so a chain the guide does later (or one lint warns about,
  taken before its prerequisite is handed in) keeps its accept, and its
  giver's window decides as below. So does a prerequisite whose goals in the
  guide are all for other characters (`only`): another race's or class's
  version of the chain, whose own the data does not list (the paladin
  charger's Emphasis on Sacrifice names the Human's Lord Grayson
  Shadowbreaker, not the Dwarf's). Prerequisites the data lacks (issue #51)
  mark nothing in advance; the giver's window covers them. The mark is live:
  it does not hold the step, the focus or the arrow, and it goes the moment
  the prerequisite is done (the guide then goes back to it), not
  on an unrelated turn-in. A giver's window that offers the quest (this
  session) beats the data: no mark in advance after that. Beyond
  that, when a gossip/greeting/detail window opens on an `accept` goal's NPC
  (any tab's current step) and the quest is neither offered, listed as active
  by that window (just accepted: the window refreshes before the quest log),
  in the log, nor
  completed, the Engine marks that accept unavailable for the session, with a
  reason: `"level"` (below minLevel), `"pre"` (a `pre` quest not done, title
  given) or `"offer"`. A detail window says nothing about the NPC's other
  quests when it opens within 30 s of that NPC's gossip/greeting list, reward
  panel or turn-in (the quest picked from the list, or the follow-up the
  client pops after a turn-in), or when an item starts it. An unavailable
  accept and the goals of that quest in the
  guide (objectives, complete, turnin) count as skipped, so the guide moves on
  instead of stalling. The session marks clear on level-up and on any quest
  turn-in (either can open a quest whose prerequisite the data lacks). In
  steps a tab has moved past, a `"level"` or `"pre"` mark clears only once
  the data says the quest is open (level reached, prerequisites done: the
  guide goes back to it) and otherwise stays with its reason brought up to
  date; an `"offer"` mark stays (#161), keeping the step passed, so the
  guide never goes back to a giver who said no for no reason the data
  knows. Every mark goes for the quest itself when it is accepted, when its
  giver's window offers it (also from a later step: the guide then goes
  back to it, the player standing at that giver) or lists it as active.
  `"offer"` marks are saved at logout (not for a quest in the log) and
  restored at login at any level. The view carries `unavailable = reason`
  and `unavailableText`.
  When such marks move the guide past a step during play, the Engine fires
  `STEP_SKIPPED`; the guide window's banner then reads "Skipped <quest>  ·
  <reason>" (one line per quest) until the step changes again, it is
  dismissed, or 20 seconds pass. With the window hidden it goes to chat
  instead. Placement at load never fires it.
- **Missable quests** (`Core/Closes.lua`, setting `behavior.warnClosing`,
  default off). `Closes.For(q, title)` lists what taking `q` closes for good
  for this character: the guide accepts whose `closedBy` names `q`, across
  every shown guide (indexed once, rebuilt on `GUIDES_REGISTERED` and
  `PACKS_CHANGED`), and, with the quest database loaded, the quests whose
  `excl` lists `q` (`QuestDB.ClosedBy`; `excl` is one-way for about one link
  in fifteen, so it is read from the closed quest's side). Left out: quests
  done or in the log, an accept whose guide is not for this character
  (`Guides.GuideMatches`: faction, race, class), the accept's `only` or the
  database's faction, race and class not matching, a quest one of its own
  `closedBy`/`excl` already closed,
  and other versions of `q` (the same title). On `QUEST_DETAIL` (not a quest
  the game accepted itself) the setting prints "Taking <quest> closes <quests>
  for good." and Automation leaves that accept to the player.
- **Not yet available.** A Class guide (`category = "Class"`) the character
  has not played (no step skipped, no goal ticked, none of its quests in the
  log or done) whose opening, the first step for this character with an
  accept or a `level` goal, waits on them (a `level` goal above their level,
  or accepts none of which they can take yet: the lowest `minLevel`, else a
  missing `pre`/`preAll`) holds at that step without placing: no waypoint, no
  unavailable marks moving it on, never complete. `Engine.StartGate(id)`
  gives the gate from the guide's data (no table kept by hand); the guide
  window shows "Available from level N" (or "Not available yet" and the
  quest to finish first) with who starts it, in place of the step, and the
  guide menu's row dims with "From level N". Next still looks at the steps.
  The gate is part of the step signature, so a level-up or turn-in that opens
  it re-renders the window and the guide starts by itself. Leveling and other
  guides are unchanged.
- **Farm spots.** `collect <item> xN nearest` (no quest) compiles `candidates` of
  farm spots `{ map, x, y, f, faction, npcName, lvl = { min, max }, rate, spawns }`
  (clustered item droppers; `faction` is zone safety; no `npc`). Among the
  spots the character's faction may use, the Engine drops those whose weakest
  mobs (`lvl.min`) are 3+ levels above the player, unless every spot is: then
  it keeps them all and ranks the smallest level gap first. Spots rank (after
  the continent tier, as for other candidates) by travel seconds plus farm
  seconds `missing / (rate * killsPerMinute) * 60`, where `missing` is `count`
  minus the items in the bags (at least 1) and killsPerMinute, from the
  middle mob level, is 1.0 for 1+ levels above, 1.5 for 0 to -4, 2.0 below
  that, 2.5 for grey, scaled by `min(1, spawns / 8)` (missing `rate` = 1,
  missing `spawns` = 8). A goal with a usable spot always has a target; the
  view carries the chosen spot's `map`, `x`, `y`, `f`, `npcName`, `lvl` and
  `alternatives`, and `CycleCandidate` walks the ranking.

#### Focus: one person at a time

A step's goals form **groups**, walked in authored order: a goal joins the
current group when it has the same "who", else starts a new one. "Who" is the
goal's NPC (`npc`, or the chosen candidate's for smart goals) or object
(`object`) for accept, turnin, talk, train, vendor, sethome, getfp, learn,
buy and interact goals; every other goal (goto, kill, collect, use, complete,
explore, level, skill, craft, rep, achieve, note, and NPC verbs without an
NPC) is "here". An interact for a quest objective (`quest`: totems, mounds,
cages, braziers) is "here" too: it is field work beside the kills, not a
visit, so it shows with them instead of waiting behind them; a plain interact
(no quest) is still a visit. So a hub step reads person by person, and a field
step (goto the camp, kill, collect) stays one group. A goal that does not
apply to the character (`only`, grey-skipped, never-had) joins the group
around it instead of starting one, so a class-only line between two goals at
the same person never splits that person's group.

- **Done:** a group is done when none of its applicable goals still blocks
  (done, `na`, skipped or optional). **Focus** is the first group that is not
  done; nil when the step is done.
- **View:** `GetStepView(i)` adds `groups = { { kind = "npc"|"object"|"here",
  npc, object, name, map, x, y, f, goals = { goalIndex, ... }, done,
  pending }, ... }` (`pending`: blocking goals still open) and `focus =
  groupIndex`; each goal view carries `group = groupIndex`. `name` is the
  NPC's or object's name (nil for "here"); map/x/y/f its position (the first
  located goal of the group).
- **Current goal and waypoint:** the view's `current` is the goal the window
  marks and the arrow leads to: in the focus group, the first open blocking
  goal, else the first open optional one (not skipped); a "Go to" naming the
  step (the group's header, an area) only when nothing else is open. The
  arrow goes to the goal the player chose in the current step (`AimGoal`, a
  cycled spot or candidate) while it is open, else the current goal's own
  place (its coordinates, its spawn area, the source of its item), else the
  header's, else the focus group's first open located goal (blocking, then
  optional, then notes); nil on a done step (no focus). Reaching the place of
  any other goal of the step arrives at its header. A focus change fires
  `STEP_UPDATED(step)` and `WAYPOINT_CHANGED` like any other progress.
- Out-of-order play still counts: finishing a later person's goals marks that
  group done; the focus stays on the first open group.

#### Route choice ("Choose your path")

A guide whose `next` lists several guides compiles to `next` (the author's
default, the first) plus `nextChoices` (all of them, in order); each option may
carry `pitch`, `pros`, `cons` (see GUIDE_FORMAT).

```lua
Polestar.Engine.GetRouteChoice(fromId) -> { from, fromTitle, recommended, chosen, joinsAt,
    options = { { id, title, zoneName, minLevel, maxLevel, pitch, pros, cons, seconds,
                  quests, steps, recommended, chosen, outleveled, open }, ... } } | nil
Polestar.Engine.ChooseRoute(fromId, toId) -> bool   -- remembers, loads, fires ROUTE_CHOSEN
Polestar.Engine.PendingRouteChoice() -> fromId | nil -- the active tab's finished guide waiting for a choice
Polestar.Engine.RouteChoiceFor(id) -> fromId | nil  -- the choice that offers guide `id` to this character
Polestar.Engine.OfferRouteChoice() -> fromId | nil  -- /polestar path: fires ROUTE_CHOICE
Polestar.Engine.GuideFocus(id) -> x, y | nil       -- live-frame percent of where the guide is for this character, for the
                                                    -- guide menu's zone art: open in a tab and unfinished, the current
                                                    -- step's first goal on the guide's zone map (`zone`); else (or when
                                                    -- that step is elsewhere) its first goal on it: a route option's focusX/Y
```

- **Options** are the `nextChoices` that fit the character (faction, race,
  class); `outleveled` when the level is at or past the option's maxLevel.
  `seconds` is `TravelCost` from the player to the option's first located goal;
  `quests` counts the accepts this character gets there; `joinsAt` names the
  guide every option continues to, when they share one.
- **Recommended:** not outlevelled, then the quickest to reach (1-minute
  bands), then the author's order.
- **At completion** (with `behavior.autoNextGuide`, and the guide either
  auto-loaded or seen incomplete): the remembered choice
  (`CharState().routes[fromId]`), else the only fitting option, else with
  `behavior.routeChoice = "recommended"` the recommended one. Otherwise the
  finished guide stays in its tab and `ROUTE_CHOICE(fromId)` fires once, after
  the evaluation.
- **Fresh start:** with no saved tabs, when the suggested guide is an option of
  a choice the character fits, and the character is at most one level into
  that guide's range, login also fires `ROUTE_CHOICE` (the suggested route
  stays loaded meanwhile).
- **ChooseRoute** loads the option in place of the finished guide, else of an
  open option of the same choice (changing route), else in the active tab.
- **Never-had quests:** a turn-in, complete or objective goal for a quest the
  character neither has nor has done, and that its guide does not accept (for
  this character) at or before that step, does not apply (status `na`): it was
  picked up on another route, or skipped. `chainNeeds` follows every route option.
- **UI** (`UI/RouteChoice.lua`, frame `PolestarRouteChoice`): one card per
  option. Each card opens on the zone's art (`UI.ZoneArt`, below) framed on
  `focusX/focusY` (where the route starts), lightly desaturated, fading into
  the card with the zone's name on it. Polestar ships no zone art; without the
  API or art for the map, a stretch of the night band stands in. Straight
  under the art, at the same y on every card, the stat row: levels (in text),
  travel time and quest count. Then the state chip, the pitch, at most 3 pros
  and 2 cons one line each (the full lists in the card's tooltip), on a grid
  every card shares so rules and lists line up; the recommended card has the
  accent ring and the primary button; "From now on, take the recommended zone"
  sets `behavior.routeChoice`; "Decide later" and the header ✕ close. It
  waits out combat. The guide window's completed state and the out-levelled
  banner open it when a choice applies; Options → Guide → Automation →
  "Where to level next".
  `POLESTAR_CLIENT_ART=<folder>` lets `preview` draw real map art from a local
  cache of decoded client tiles (base and overlay tiles, `maps.json` with each
  map's `artID`); those renders go to `<folder>/preview/`, never into `docs/`.

#### Tabs (several guides at once)

```lua
Polestar.Engine.GetTabs() -> { { guideId, title, category, stepIndex, stepCount, done, total, complete }, ... }, activeIndex
Polestar.Engine.OpenTab(guideId [, activate])  -> index   -- already open: just activates it (when activate ~= false)
Polestar.Engine.CloseTab(index)                            -- the last tab may be closed (no guide)
Polestar.Engine.SelectTab(index)
Polestar.Engine.MoveTab(from, to)
```

Up to 6 tabs per character, persisted as `CharState().tabs = { guideId, ... }` and
`CharState().activeTab`. Every single-guide call above (`GetGuide`, `SetGuide`,
`GetStepIndex`, `GetStepView`, `Next`, ..., `GetWaypoint`, `GetProgress`) acts
on the **active** tab; `SetGuide(id)` replaces the active tab's guide (opening a
first tab when none exist). Each tab keeps its own step state; per-guide manual
and skip state stays keyed by guide id. Selecting a tab fires `GUIDE_CHANGED`
(and `STEP_CHANGED`, `WAYPOINT_CHANGED`) for the newly active guide; any tab
change fires `TABS_CHANGED(tabs, activeIndex)`. The waypoint follows the active
tab only. Automation considers the current and next two steps of **every** open
tab. `autoNextGuide` replaces the finished guide within its own tab. On login,
saved tabs reopen; `Guides.Suggest()` opens a first tab only when none survive
(SavedVariables can come back nil). Each tab in the guide window reads
`Title (min–max)` like the menu's rows; a narrow tab cuts the title, never the
range (DESIGN, Guide-window tabs).

**Absent guides keep their place.** A saved tab whose guide is not
registered (its pack missing) or hidden (its pack switched off) is **absent**:
it is not opened, but it stays in `CharState().tabs` after the open ones, with
its place in `CharState().absentAt = { [guideId] = place }`, and its saved
view (`pins`) is kept. At login and on `PACKS_CHANGED`, an absent guide that is
shown again reopens at its old place, up to the tab limit; on
`PACKS_CHANGED`, open tabs whose guide is gone close together and become
absent (the active one hands over to its right neighbour, as `CloseTab`).
Check-offs are keyed by guide id and survive regardless.

Step view (render-ready; the UI never re-derives status):

```lua
{
  index = 3, title = "Kobold Camp", note = "...",
  status = "current" | "done" | "skipped" | "upcoming" | "na",
  goals = {
    {
      index = 1, t = "kill",
      status = "done" | "active" | "pending" | "na",
      text = "Kill Kobold Vermin",        -- plain default rendering, no color codes
      verb = "Kill", subject = "Kobold Vermin",
      subjectKind = "quest" | "npc" | "item" | "place" | "object" | "level" | "text",
      detail = "for Kobold Camp Cleanup",  -- or nil
      progress = { cur = 3, max = 10 } | nil,
      manual = true | false,               -- UI shows a checkbox when true
      optional = false, note = nil,
      map = 1429, x = 47.6, y = 35.1, f = nil,   -- when the goal has coordinates
      quest = 7, npc = 6, item = nil,
      -- A collect's compiled source (GUIDE_FORMAT "What the compiler fills
      -- in"): enemy = an NPC not of the character's faction.
      source = { name, kind = "npc" | "object", rank, enemy } | nil,
      -- The compiled `group` (group content), shown as the goal's group line.
      party = { kind = "elite" | "dungeon" | "raid" | "group", rank, name, size } | nil,
      -- The reading flow (below): starterOf, starter, folded, header.
    },
  },
}
```

Current step = first step, in order, that is applicable (`only` matches),
not skipped, and not done. A step is done when every applicable,
non-optional goal is done; a step of only notes/optional goals is done at
once. Step views for indices before the current step report `done`,
`skipped` or `na`; after it, `upcoming` or `na`.

The reading flow shows one line per thing to do; the view flags what folds,
statuses and verbs unchanged (the Engine and every other reader still see
each goal):
- **A quest started by an item** (an `accept` with an `item` and no giver,
  after a `collect` of that item outside a quest objective, in the same
  group) is one line, the quest. Until the item is in the bags the collect
  stands for it: `starterOf = <accept's index>` and `starter = { item,
  source, note }`; the accept is `folded`. The window words the collect's
  row as the accept (`UI.ReadingGoal`) and keeps its index, waypoint and
  spots. Then (item held, quest taken or out of reach) the collect is
  `folded` and the accept carries `starter` (`held = true` until taken).
  The line under it: "Runed Scroll: kill Aean Swiftriver (rare elite)", then
  "Runed Scroll: in your bags, right-click it".
- **A "Go to" naming the step's own place** in a field group is
  `header = true`: the group's header already says it, so the window shows
  no row for it while the group has others, and the header carries the
  arrow's mark while it is the target.

Placement: when a tab loads a guide (login and reload, `SetGuide`/`OpenTab`,
auto-chaining to `next`, `/polestar reset`), the evaluations until the quest
log is readable (the first `QUEST_LOG_UPDATE` of the session), at most 10 s,
and ended early by the player's own Next/Prev/Skip/Goto or check-off, place
it from the quest log (a Class guide not yet available is not placed: it
holds at its opening, see "Not yet available"):

- **Start** = the first open step with work the player has *started* (an open
  goal of a quest in the log: objectives in progress, ready to turn in) or
  *can do now* (an accept their level and prerequisites allow). Skipped steps
  are never the start, even with their quest in the log, and ticked or
  skipped goals are no open work: a reload never pulls the player back to
  what they chose to pass. (Before this rule, a saved skip on a step with its
  quest in the log was dropped at every load, so a player who had skipped
  ahead with › was sent back to the first such step on every reload.)
- Before the start (with no start: before the last quest progress), a step
  passes when every open goal is an accept the character cannot take yet
  (level, prerequisite; marked unavailable for the session, so it comes back
  once the level is reached or the prerequisite done), a soft goal (goto,
  fly, getfp, train, vendor, hearth, sethome, talk, non-quest
  kill/collect/buy) in a step before the last
  step with live quest progress (a done quest goal or an objective with some
  progress; class or race steps and goals, and optional goals, are no
  evidence), or a travel goal (goto, fly, hearth, explore) while the player
  stands within 150 yd of the start step's work. Soft goals passed are
  latched. Any other open goal holds the step.

Ticks and stored check-offs keep counting. After placement soft steps hold
as usual, so a quest taken out of order during play never jumps a training
stop. A turn-in or objective of a quest whose accept sits in a skipped step
(and that the player neither has nor has done) no longer applies. Quests
their giver did not offer stay marked across a reload (`offers`, while the
character is still that level), so the guide does not return to that giver.
A pack update that changes a guide's shape matches the old and new steps by
`stepKeys` (longest common run of equal step hashes) and moves ticks, skips
and the saved view with them; saves from before step keys existed lose them.

Navigation: `Next`, `Prev` and `Goto` only change the step on screen (the
pin); `Skip` is the only way to skip a step (saved, undone by `Unskip`;
`Goto` to a skipped step un-skips it). The pin is saved (`pins`), so a reload
shows the step the player was looking at; it is released at the live step,
and while the step it shows gets done it follows forward (behind the live
step up to it, ahead of it to the next open step, latching the step's
transient goals). `Prev` and `Next` walk the same applicable steps, done,
skipped or open. NPC interactions count for the live step too while another
step is shown.

Waypoint:

```lua
{ map = 1429, x = 47.6, y = 35.1, f = nil, label = "Kill Kobold Vermin", stepIndex = 3, goalIndex = 2, kind = "kill", r = 8 }
```

= the goal of the current step the player aimed at (`AimGoal`) while it is
open; else the current goal (the focus group's first open blocking goal, else
its first open optional one, else its header); else the focus group's first
open goal with coordinates (blocking, then optional, then notes). A done step
has none. Re-evaluation is event-driven and coalesced (≤ 10 per second);
`goto` and `explore` arrival is polled only while some tab's current step has
one open, or while the waypoint's goal has spots.

Automation (setting `behavior.autoAccept`, `behavior.autoTurnin`, default
on; holding Shift suppresses): accept only quests that are `accept` goals, and
turn in only quests that are `turnin` goals, in the current or next two
steps (a `direct` one is picked from the gossip or greeting list of offered
quests, and only while its goal is not done: the giver of a repeatable keeps
offering it); never choose among multiple rewards; with `behavior.warnClosing` on,
never accept a quest that closes another for good (Missable quests).

## Theme — used by UI and Nav

```lua
Polestar.Theme.Accent() -> r, g, b
Polestar.Theme.Color(name) -> r, g, b, a
   -- grounds "bg","panel","panelAlt","sidebar","footer","sky"; text "text","textDim","textMuted";
   -- "accent","ink" (hairlines/washes),"star","shade" (wells, text shadows, art fades),
   -- "scrim" (dark grounds on zone art),"onAccent" (text on accent fills),"shadow";
   -- "success","warning","danger","quest","npc","item","place","object","level","skill",...,
   -- "dungeon" (dungeon and raid entrances); "mapUnexplored" (tint multiplied onto unexplored
   -- world map overlays: game art, the same in every scheme, outside the legibility guard);
   -- "discord" (Discord's Blurple, on its own mark only, outside the legibility guard)
Polestar.Theme.Wash(role) -> r, g, b, a     -- ink at the role's alpha: "border","divider","hover",
   -- "selected","progress","track","toggle","box","thumb","swatch","chip","watermark","mover"
Polestar.Theme.Hex(name) -> "ffrrggbb"     -- for |c escapes
Polestar.Theme.Palette() -> { name = { r, g, b, a }, ..., scheme = key }  -- resolved, read-only
Polestar.Theme.SchemeKey() -> "dusk" | "night" | "graphite" | "ellesmere"
Polestar.Theme.Band(parent, layer, sub) -> sky texture  -- the night-sky band (sky mask + stars)
Polestar.Theme.GroundAlpha() -> a          -- ui.bgOpacity, every Polestar window's ground
Polestar.Theme.Font(fontString, role)     -- role: "hero","display","title","heading","body","label","note","small","number","caption","goal","name","mono"
Polestar.Theme.FontSpec(role) -> path, size, flags
Polestar.Theme.Skin(frame, kind)          -- "window","panel","inset","button","editbox","checkbox","dropdown","scrollbar","tab","close"
Polestar.Theme.Media(name) -> texturePath -- e.g. "icon-accept", "check", "white", "glow"
Polestar.Theme.OnChanged(fn)              -- fn() on any scheme/colour/font change
Polestar.Theme.IsEllesmere() -> bool
Polestar.Theme.SkinKey() -> "polestar" | "halo" | "blizzard"   -- ui.skin
Polestar.Theme.SkinChoices() -> { { value, text }, ... }
Polestar.Theme.Metric(key, house) -> n   -- a size in the skin in use; `house` in the house style
Polestar.Theme.Icon(name) -> name        -- a glyph a skin draws its own way ("bug" -> "flag")
Polestar.Theme.FontKey() -> "game" | "inter" | "fira"   -- ui.font, "skin" resolved
```

**Skins** (`ui.skin`, Appearance > Windows > Frame): `polestar`, the house
style everything below describes (the default); the two directions of the
design handoff, `halo` (Forever · Halo: no frame, a dark veil with soft edges,
an off-white ladder, the game's gold, Fira Sans) and `hearth` (Forever ·
Hearth: warm game colours, a brown gradient window, the client's buttons, font
and text colours); and the game's own looks, `forever`, `blizzard` and
`classic` (below). `Theme.GameSkin()` is true for Hearth and the game's looks:
the client's check boxes, sliders and red buttons, its font and hard shadow. A
skin brings:
- its palette (`Theme.SKIN_PALETTES`: the handoff's tokens as given, washes
  included); the scheme, ground colour, brightness, band and shadow are the
  house style's (their options are greyed out in a skin); the player's own
  accent, window border and arrow colours win in every skin. Tokens the skins
  added (`textOff`, `title`, `link`, `todo`, `later`, `manual`, `skipped`,
  `arrive`, `veil`, `veilWindow`, `menuBg`, `inputBg`, `control`,
  `accentLine`, `padSelect`, `chipAccent`, `separator`, `rowLine`, `icon`,
  `iconHover`, `buttonText`, `personName`, `tabRest`) exist in the house
  style too, as their house equivalents;
- its paints (`Theme.SKIN_PAINT`, falling back to the house paint): Halo's
  veil (Media/UI/veil-soft, nine slices laid 24 units out); Hearth's flat
  brown gradient windows edged by the window border setting (a #5C4518
  hairline by default; no game frame) and the game's `UI-Panel-Button-*`. A
  frame painted in another skin is cleared first, so a switch and back leaves it
  as it was;
- its fonts (`ui.font` "skin", the default: the game's in the house style and
  Hearth and the game's looks, Fira Sans in Halo), its type sizes and text shadow;
- its sizes (`Theme.Metric`): setting rows, buttons, menus, dropdowns,
  sliders, the guide window (`readMetrics` / `GF.ApplySkin`), the shell
  (`W.SHELL` reads them) and the guide menu. The big windows take them as they
  are built.

The arrow follows the skin (`nav.arrowStyle` "skin", the default: 3D in the
house style, the `halo` dart in Halo, the `hearth` dart in Hearth and the
game's looks; Nav/Arrow.lua). The skins' textures are drawn by
`tools/media/skins.js`.

**The game's looks** (Theme/GameSkins.lua) draw Polestar in the client's art,
the three looks EllesmereUI offers on the Forever client (its visual spec
only; nothing of that addon is used), composed as the client's own FrameXML
composes its windows: SharedUIPanelTemplates (ButtonFrameTemplateNoPortrait,
InsetFrameTemplate, UIPanelButtonTemplate, UIPanelCloseButton), the
NineSliceLayouts with the Forever client's offset overrides, and the Settings
panel's controls (MinimalTab, the minimal check box, MinimalSliderWithSteppers,
WowStyle2Dropdown, MinimalScrollBar, the MenuStyle1 menu ground). Each look is
a kit of parts by role (`Theme.KITS`), drawn by `Theme.Kit*` helpers the
widgets and the guide window call, and kept in `frame.psSkin.kit` so a skin
change hides them:
- the big windows (shells, dialogs) are the template's Bg: its metal frame
  lies outside them, with the title bar above (a drag strip and the title on
  it) and the close button on its corner; rock under the content, the
  sidebar an inset, gold setting labels and list rows (`rowLabel`,
  `navRest`);
- the guide window and the toasts (`psLight`) keep EllesmereUI's small-window
  looks: Forever's bronze micro menu line, Blizzard's black body under a fade
  with the damage meter's header bar, Classic's tooltip tile under the chat
  tab's rim;
- atlases the client draws sliced (UiTextureAtlasElementSliceData) are cut at
  the same margins (`ns.GameArtSlice`).

Sources: `forever` names atlas elements (the Forever client draws its own
-c60 art for them); `blizzard` draws the same elements in their retail art,
which still ships with the client but which SetAtlas does not draw there, by
file ID and coordinates from `Theme/GameArt.lua` (generated with the slice
margins by `node tools/polestar.js media game-art`, tools/media/game-art.js);
`classic` names the vanilla files (the dialog box and tooltips through
BackdropTemplate).

No client art is copied into the addon; the kits name files and atlases. With
POLESTAR_CLIENT_ART holding the client's UI textures decoded to <fileID>.tga
plus atlases.json and files.json, `node tools/polestar.js preview` draws them
(SetAtlas, GetAtlasInfo and file paths resolve) and renders the local-only
`skins-game-*` scenes into that folder.

**Colour schemes** (`ui.scheme`, `Theme.SCHEMES`): Dusk (default: Night's
navy lifted to dusk), Night (the original deep navy-black, values unchanged),
Graphite (neutral, lighter), and EllesmereUI (offered only while it is
installed; grounds derived from its `S.GetPanelColor()`, its accent). A scheme
is data: the grounds, the text ladder, ink, shade, scrim, onAccent and shadow;
the subject and status colours are shared. No light scheme ships: transparent
mode and the arrow draw text straight on the game world, where it must be a
light ladder with a dark outline, and the starfield band has no daylight form,
so a light scheme could not reach every surface.

**Resolution** (`Theme.Palette()`, rebuilt on any look setting change), per
colour: the user's own value > "Match EllesmereUI" (installed and on) > the
scheme.
- Accent: `ui.accent` (`false` or `{ r, g, b }`) > the class colour when
  `ui.classAccent` (default off; `C_ClassColor`/`RAID_CLASS_COLORS`, moved
  toward the text colour until it reads at 4.5:1 on the panel) > EllesmereUI's
  when `ui.matchAccent` (default on) or the EllesmereUI scheme > Polestar gold.
  One source at a time: turning one of `ui.accent`, `ui.classAccent`,
  `ui.matchAccent` on turns the other two off.
- Grounds: `ui.bgColor` (`false` or `{ r, g, b }`; every ground derived from it
  by Dusk's lightness steps in OKLab) > the scheme; then `ui.brightness`
  (-1..1, every ground's OKLab lightness by up to ±0.2); then the legibility
  guard: if any ground would carry primary text under 7:1, secondary or muted
  text under 4.5:1, or a subject/status colour under 4.5:1 (not on the sky),
  every ground is darkened together by the least lightness that restores it.
- Ground opacity: `ui.bgOpacity` for every window skin.
- Font: EllesmereUI's when `ui.matchFont` (default off) and installed, else
  `ui.font` (`skin` by default: the skin's | `game` | `inter` | `fira`; CJK
  clients always the game font).
- Settings from before schemes: a stored accent equal to the old gold default
  is dropped at load (Theme.lua's `migrate`); any other stays the user's own.
- Window frame (the `window` skin of every top-level window, live):
  `ui.border` (default on) and its thickness `ui.borderSize` (1–4 physical
  pixels, growing outward; `Theme.WindowBorder()`), its colour the
  `windowBorder` token: `ui.borderColor` (`false` or `{ r, g, b }`) > the
  accent at 80% when `ui.borderAccent` > the scheme's `border` hairline (the
  two sources turn each other off); `ui.shadow` (default on) for the drop
  shadow; `ui.band` (default on, `Theme.ShowsBand()`) paints every header band
  clear when off (a band standing in for missing zone art stays).
- The arrow: the `arrow` token is `nav.arrowColor` > the accent; `arrowNear`
  is `nav.arrowNearColor` > success. Their `arrowText` / `arrowNearText` forms
  carry the arrow's text, lifted toward the text colour until they read at
  4.5:1 on the lightest ground (`Theme.Legible`'s rule); the arrow, its ring,
  the map target pin and the route stops wear the colours unchanged.

EllesmereUI is read only through its documented skinning API
(`EllesmereUI.RegisterSkin`, `S.GetAccentColor`, `S.GetPanelColor`, `S.GetFont`,
`S.OnLooksChanged`); its frame primitives are not applied. Every surface paints
from tokens (`W.Color`, `W.Painter`, `Theme.Skin`, `Theme.Band`), so a scheme or
colour change repaints live without a reload.

## Nav

```lua
Polestar.Nav.SetTarget(map, x, y, label, f, stop, z)   -- user picked a goal; overrides the engine waypoint until the step changes;
                                                        -- stop: what stands there ("dungeon", "trainer", ...), for the hand-off below;
                                                        -- z: the height of the NPC or object there, optional (the walk ends on its floor)
Polestar.Nav.ClearTarget()
Polestar.Nav.GetTarget() -> waypoint | nil
Polestar.Nav.GetDistance() -> yards | nil      -- to an area target's edge, 0 inside it
```

Settings live under `nav.*`; `nav.distanceUnit` (`"yards"`, the default, or
`"metres"`) sets how distances read, and the arrow redraws its distance as
soon as it changes. Nav hides itself in instances, on taxis, and when
the target is on another continent (shows the zone name instead). Where the
client gives no player position (the Deeprun Tram is a map of its own, Map
369, with no UiMap), `Nav.Sample` returns "instruction" while the route's
current leg is a ride, flight or hearth, so the arrow keeps that leg's glyph
and caption ("Take the tram to Stormwind"), and "nopos" otherwise: the arrow
says "No position here" over its label. It points again as soon as a
position returns.

An area target (a waypoint with `area`, yards: a spawn area) is reached
anywhere within `area + r` of its centre; outside, the distance shown is to
the area's edge. A camp then shows the arrived state with the goal label. An
area objective (`search`) never says arrived: `Nav.Sample` returns "search"
and the arrow says "Search here", the goal label, and "Click the arrow for the
next spot". A left click on the arrow (not a drag) calls
`Nav.NextSpot([index])`, which asks the Engine (`CycleSpot`) for the next spot
while the target is the Engine's waypoint with `spots`. A guide goal's area
shows as its spawn regions (below); any other area target's `nav.target` pin
carries the `area`, so the world map and the minimap draw the area's soft disc
under the target pin. The `nav.spots` layer (world map, under `nav.worldPins`)
marks every other spot of the target as a small pin (an `alt` spot smaller and
fainter, its tooltip "It also spawns here"); clicking one searches there next
(`Nav.NextSpot(i)`). TomTom's arrival distance is `area + r`.

Every place the current step's open goals spawn is a region on the map
(`Layers.lua`, read from `Engine.GetGuide().steps[step].goals[i].spots` for
the goals `GetStepView` shows active or pending). `Layers.Regions(goal)`
groups a goal's spots once per goal (cached by the compiled goal table): each
spot's disc (its radius covers its spawns, at least 15 yd, plus 10 yd) joins
the spots whose discs come within 90 yd, nearest first, while the region stays
at most 700 yd across (a coast of spawns is a chain of regions, not one hull
over the sea). A region is the polygon whose sides touch the convex hull of
its discs from outside (16 sides, 8 under 200 yd), so it covers every spawn
of its spots; `alt` when all its spots are. `nav.areas` holds the target's
goal's regions as `hull` pins in the arrow's colour (alpha 1, `alt` 0.6), on
the world map and the minimap (`nav.worldPins`, `nav.minimapPins`);
`nav.goalAreas` the step's other goals' regions in `place` at 0.6 (`alt`
0.35), on the world map only. A point picked by hand (`SetTarget`) leaves
every goal's regions in `nav.goalAreas`. The layers are set again only when
what they show changed (step, open goals, the arrow's goal, colours,
surfaces), so route and progress updates redraw nothing.

While a `SetTarget` override is active the Engine keeps announcing its own
waypoint; `Nav.GetTarget()` is the point actually being guided to. Nav fires
`WAYPOINT_CHANGED` when it sets or drops an override. `ClearTarget` hides the
Engine's waypoint until the Engine announces a different one or the step changes.

### Nav API — journeys for players and other addons

`Nav/Journey.lua` and `Nav/Nearby.lua` (adapted from Shortest Path Forever by
Cillian Berragan, GPL-3.0-or-later, with permission). Every target they set
is a `Nav.SetTarget` override, so it is routed (and timed) like any goal and
dropped when the guide's step changes.

```lua
-- Public, for other addons. Points: a uiMapID and x, y as 0-1 fractions (as TomTom and C_Map).
Polestar.Nav.API.version                      -- 1
Polestar.Nav.API.Estimate(fromMap, fromX, fromY, toMap, toX, toY) -> seconds | nil, "invalid" | "unknown" | "busy"
    -- the travel planner's estimate (Nav.EstimateTravel: flights, boats, timetables, cached a few
    -- seconds per start cell and destination), else a straight run on one continent; fromMap nil:
    -- from the player, the Hearthstone counted. An uncached call runs a full route plan
    -- (up to its 40 ms cap). Once a frame has spent 25 ms planning estimates (Polestar's own
    -- included) no new plan starts for the API and the answer is nil, "busy": ask again next frame
Polestar.Nav.API.Navigate(owner, map, x, y, title) -> true | false   -- owner: a non-empty string
Polestar.Nav.API.Cancel(owner) -> true | false  -- that owner's target, while it is the one shown, lets go
Polestar.Nav.API.Active() -> active, owner      -- anything guided to; owner while an API caller's target shows
-- Internal
Polestar.Nav.journey.PlanTo(map, x, y, label, f) -> ok   -- onto the zone under a continent spot; refuses open sea
Polestar.Nav.journey.Estimate(from, to, budgeted) -> seconds | nil[, "busy"] -- from, to = { map, x, y, f } (percent); from nil: the player; "busy" only when budgeted (the API)
Polestar.Nav.nearby.Find(kind, skillLine) -> place, seconds | nil, "kind" | "codex" | "combat" | "none"
Polestar.Nav.nearby.Go(kind, skillLine) -> ok
Polestar.Pins.MinimapCursor() -> dNorth, dWest | nil      -- yards from the player to the cursor on the minimap
```

- **Plan to anywhere** (`nav.mapPlan`, on): Shift-click empty space on the
  world map (a canvas click handler, so it takes the click before the map
  zooms) or the minimap; Alt-click anywhere on the world map, its icons
  included (`GLOBAL_MOUSE_DOWN`; the icon's name labels the target), except
  Polestar's own clickable pins. The label is "Zone x, y". Shift- or
  Alt-clicking within 1.5% of the map's width (8% of the minimap's radius) of
  the shown pick, or Shift-clicking its pin (`Pins.OnWorldClick`; Polestar's
  pins are its own frames, `Pins.WorldPinOf` tells them under the mouse),
  lets it go. With a chat edit box
  open Shift-click stays Blizzard's (links into chat). A spot on no zone (open
  sea, the world map, the minimap's corner) prints one line and plans nothing.
- **Ownership**: a target replaced by another is not the owner's while it is
  away; the same spot and label set again (the death helper hands a picked
  point back once you are alive, `QoL/Death.lua`) is theirs again.
- **TomTom stand-in** (`nav.answerTomTom`, off): while TomTom is neither loaded
  nor enabled in the AddOns list, the global `TomTom` answers `AddWaypoint`,
  `AddMFWaypoint`, `AddZWaypoint` (0-100), `AddWaypointToCurrentZone`,
  `RemoveWaypoint`, `ClearWaypoint`, `ClearAllWaypoints`, `SetCrazyArrow`,
  `IsValidWaypoint`, `WaypointExists`, `GetDistanceToWaypoint`, `GetKey` and
  `SetClosestWaypoint` through `API.Navigate("TomTom", ...)`, one waypoint at a
  time; `corpse` waypoints (the death helper's job) and `from = "Polestar"`
  ones are refused. Any other method name with an upper-case first letter
  (TomTom's style) is a no-op returning nil, so an addon calling more of
  TomTom's API never errors; fields (`TomTom.db`, profiles) are not provided
  and read as nil. The global is taken at login, once every addon has loaded,
  so an addon bringing its own TomTom-compatible global keeps it; it is given
  back (cleared) when the setting goes off or TomTom loads. `Nav/Bridges.lua`
  never mirrors into it. Default off: the stand-in has methods only, so an
  addon that finds the global and reads TomTom's settings (`TomTom.db`, its
  profile) would error; the option ("Let other addons set waypoints",
  Options, Integrations, TomTom) says so. With it off nothing sets
  `TomTom` and `/way` is not claimed.
- **Following TomTom** (`nav.followTomTom`, off; real TomTom only): hooks on
  TomTom's table: `SetCrazyArrow(uid)` points Polestar's arrow at that
  waypoint (not `corpse`, not `from = "Polestar"`), `RemoveWaypoint` and
  `ClearWaypoint` of it let it go ("Remove all waypoints" clears through
  `ClearWaypoint` alone). Waypoints TomTom restores at login are followed one
  frame after `PLAYER_ENTERING_WORLD`, the one its arrow was left on, unless
  something is picked already. A followed waypoint is not mirrored back.
- **`/way`** (with `nav.answerTomTom`): claimed at login (`SLASH_POLESTARWAY1`)
  only when TomTom is not loaded and no `SLASH_*` global spells `/way`.
  `/way [#mapID | zone] x y [title]`: the zone is any name under the player's
  world, exactly, the one zone it begins, else the one it is part of
  ("barrens"); several print their names. `/way reset` clears.
- **Nearby services** (`/polestar near <kind> [profession]`; `nav.nearbyMenu`
  adds a "Nearby services" submenu to `MENU_WORLD_MAP_TRACKING` and
  `MENU_MINIMAP_TRACKING`): kinds trainer (profession, by skill line, or any),
  class, repair, reagents, vendor, innkeeper, bank, auction, flight, stable.
  Places are the Codex's NPCs with that role (`Codex.WithRole`, loaded on
  demand, never in combat), friendly to the player's faction and outside
  instances; reagents are vendors listed in `QoL.data.reagentVendors` (`qol
  build`: a vendor whose subtitle names reagents); the class trainer is
  `Engine.NearestClassTrainer()`. The nearest spawn of each NPC by straight
  line (the player's continent first), the six nearest of those estimated by
  `Journey.Estimate`, the quickest becomes the target and one chat line names
  it, its zone and the time.

### Hand-off to Shortest Path Forever

`Nav/Handoff.lua` (`Nav.handoff`; loaded after the other Nav modules). With
[Shortest Path Forever](https://github.com/cjber/shortest-path-forever)
installed (its global `ShortestPathForever.API`, `version` 1, with `Cancel`
and `NavigateRoute` or `Navigate`; every other function checked before it is
called, as its `minor` grows) the two never guide at once:

- **Hand-off** (`nav.spfHandoff` on; an option, off by default since 0.2.5:
  Options, Integrations, Shortest Path Forever: "Hand guiding to Shortest
  Path Forever", shown only with it installed): Polestar's target is guided
  by it and Polestar's own guidance steps aside.
- **Yield** (the option off, the default): Polestar guides, and steps aside
  exactly as it does when handing off while Shortest Path Forever runs a
  journey that is not Polestar's (`Active()` true and no
  `CurrentStop("Polestar")`: one the player started there, or another
  addon's). It looks on `Subscribe`'s news (else on Nav's once-a-second
  tick), at `PLAYER_ENTERING_WORLD` and when the option is turned off; never
  in combat (the news waits for `PLAYER_REGEN_ENABLED`). When that journey
  ends Polestar guides again (`Nav.Reapply()`, the TomTom stand-in with it).
  `Nav.SayHandedOff()` then says "Shortest Path Forever is guiding a journey
  of its own. Polestar's arrow comes back when it ends."
  A journey of Polestar's left running in it from 0.2.4 (which handed off by
  default) is cancelled once with the option off, at the first
  `PLAYER_ENTERING_WORLD` (in combat, when combat ends; until then Polestar
  steps aside as if yielding, since that journey may still guide).
  `Subscribe` is called at `PLAYER_ENTERING_WORLD` and when the option
  changes, never in combat (then once combat ends); turning the option off in
  combat cancels Polestar's journey there once combat ends.

```lua
Polestar.Nav.HandedOff() -> bool   -- the one predicate: handing off (installed, on, the last stop not refused, and it guides that stop), or yielding
Polestar.Nav.Reapply()             -- (Nav.lua) re-plan and tell every module the same target again, unannounced
Polestar.Nav.handoff.Available() -> bool
Polestar.Nav.handoff.Yielding() -> bool  -- the option off and a journey not Polestar's runs in it
```

- **What steps aside.** While `Nav.HandedOff()`: the arrow hides
  (`Arrow.lua`); the travel planner plans no route (`Travel.Replan`), so there
  are no route lines, journey steps (`UI/JourneyPanel.lua`), travel button
  (`Nav/Prompts.lua`) or leg alerts; the trail is cleared (`Layers.lua`);
  transport alerts are off (`Alerts.Check`); `Nav/Walk.lua` neither loads
  `Polestar_Nav` (`Data.Pack` is never called) nor searches; Shift/Alt map
  clicks plan nothing, the TomTom stand-in is not installed and `/way` is not
  claimed (`Nav/Journey.lua`, at login and when the setting changes; the
  addon then claims its own); `Nav/Bridges.lua` mirrors into neither TomTom
  (its stand-in would start a second journey) nor Blizzard's user waypoint.
  The guide window, the target pin, spawn regions, every other pin and the
  Engine's own arrival checks stay. When the predicate flips,
  `Nav.Reapply()` brings each surface back or sends it away again.
- **The stop.** One stop through `NavigateRoute("Polestar", { stop })`
  (`Navigate` with title and kind when only that exists): the target's live
  map point (`Nav.LiveCoords`, as 0-1), its label as the title, and a kind:
  the hand-set target's `stop` (Dungeons' entrances, Nearby's trainers, inns
  and flight masters, the trainer banner), else the goal's verb (`accept`
  pickup, `turnin` turnin, `kill`/`collect`/`use`/`interact`/`complete`
  objective, `train` trainer, `sethome` innkeeper, `getfp`/`fly`
  flightmaster), else the place it stands at from the travel data (a
  transport landing within 30 yd: its boat, zeppelin, lift or tram; a portal,
  flight master or inn within 15 yd). A `kill`, `collect`, `use` or `interact`
  waypoint with a spawn `area` is held: `hold = true`, `radius = area + r`,
  `shapes` = every spot of the goal as a circle (spot radius + `r`, live
  frame), `questID` the goal's quest and `questIDs` too when other open
  objectives of the step (`GetStepView`) have spawn spots overlapping it, so
  the stop never arrives and directions pause inside the area.
- **When it is sent.** On each target change and at the first
  `PLAYER_ENTERING_WORLD`, only when the stop differs from the last one taken
  (every field compared), so re-announced targets, ticks and settings never
  churn. In combat, without a position or in an instance nothing is called and
  the stop waits (`PLAYER_REGEN_ENABLED`, `PLAYER_ENTERING_WORLD`,
  `ZONE_CHANGED_NEW_AREA`); a call refused because combat began waits the
  same way. No target: `Cancel("Polestar")` while its journey runs. Dead or a
  ghost (`UnitIsDeadOrGhost`): no call at all, as it guides corpse runs
  itself; alive again the target goes as it is (the same stop is not resent).
- **Not fighting.** `Subscribe` (else Nav's once-a-second tick) reads
  `Ended("Polestar")` and `CurrentStop`: once the journey arrived or was
  cleared or replaced it is left ended, nothing is resent and no `Cancel`
  is called, until Polestar's target changes.
- **Refused.** A stop refused out of combat (its Journeys off, or a point it
  cannot place) and a target with no live point: Polestar guides that target
  itself (`Nav.HandedOff()` false) and cancels its earlier journey; the next
  target, or a zone change, offers a stop again, and the first one taken hands
  back.
- **No way there.** A stop it took that it then guides nothing to (its
  `CurrentStop("Polestar")` set but `Active()` false: its search found no
  way, `StopGuide` in its `Journey.lua`, the tracker saying "No way there
  from here."; or its guidance turned off in its tracker): Polestar guides
  that target itself (`Nav.HandedOff()` false), leaving its journey in place
  and sending nothing. It is read on `Subscribe`'s news (else Nav's tick) and
  at death and coming back; it is never set while dead or a ghost (its corpse
  run). Polestar goes on guiding after that journey ends, and steps aside as
  soon as it guides anything again (that journey, the player's own, another
  addon's, its corpse run); the next stop taken hands back.
- **Off.** Turning `nav.spfHandoff` off cancels the journey and Polestar
  guides again (`Polestar_Nav` loads then), unless a journey not Polestar's
  runs (yield, above); on again sends the stop anew.
- **Options and commands.** `Nav.HandoffOption(control)` wraps every option
  that has no effect while handing off: its `disabled` also answers
  `Nav.HandedOff()` and its help ends "Greyed out while Shortest Path Forever
  guides: it does this itself." (the arrow, its arrival time, chime, look and
  position; travel routes, walking paths, route lines, class teleports, trail
  dots, journey steps, the travel button, transport alerts; map clicks, other
  addons' waypoints, the Blizzard and TomTom mirrors and TomTom's arrow).
  Distances, boat-time sharing, map pins, following TomTom and the nearby
  menu still act and stay. `Nav.SayHandedOff()` prints one line ("Shortest
  Path Forever is guiding. Turn off "Hand guiding to Shortest Path Forever"
  ...", or the yield's line above) instead of `/polestar arrow show`
  (or the bare toggle turning it on), `/polestar route` and
  `/polestar skipleg`. Polestar's arrival chime is silent meanwhile.

Tested by `tests/nav-handoff.test.js` against a fake API written to its
`docs/api.md` (v1.16.0).

### MapCanvas — drawing on Blizzard's map frames

```lua
local view = Polestar.MapCanvas.Watch(map, fn)  -- map: WorldMapFrame or BattlefieldMapFrame; one view per map frame
-- fn(view, what, elapsed): what = "show" | "map" | "size" | "scale" | "alpha" | "hide" | "tick"
-- view.map, view.canvas, view.shown, view.mapID, view.width, view.height, view.scale, view.zoom, view.pinScale, view.alpha
view:Level(levelType)              -- the frame level the map gives its pins of that level type
view:PinScale(startScale, endScale) -- a map pin's scale under SetScalingLimits(1, startScale, endScale)
Polestar.MapCanvas.Get(map) -> view | nil
```

The world map and the battlefield map are Lua (`Blizzard_MapCanvas`,
`Blizzard_WorldMap`), and Forever's gamepad interface reads them from secure
code as they open and close (`MapCanvasMixin:OnHide` walks the pins its gamepad
cursor hovered, then `FrameControlsManager` refreshes its focus and
`Blizzard_GamepadActionBars` calls the protected
`SetPreferredGamepadInteractTarget`). A value an addon wrote into the map's
tables taints that code and the game blocks the call ("An action was blocked
because of taint from Polestar"). So every module draws on the maps through
`Nav/MapCanvas.lua` and never writes into them: no data provider, no pin
pool, no `AcquirePin`, no map method that writes, no hook on the map. Its
frames are children of `map:GetCanvas()` (parenting is the client's, in C:
the scroll frame clips them, they show and hide with the map), each made
with no parent and then set under the canvas (`CreateFrameUnder`, Core,
"Frames under the game's UI"), positioned
from map percent times the canvas size, and the map is only read through
`GetMapID`, `GetCanvas`, `GetCanvasScale`, `HasZoomLevels`,
`GetCanvasZoomPercent`, `GetGlobalPinScale`, `GetGlobalAlpha`,
`GetPinFrameLevelsManager():GetValidFrameLevel(levelType)` (each returns a
field or works one out, writing nothing; not `GetViewRect`, which caches) and
the canvas's `GetWidth` / `GetHeight`; Maps' info bar also reads
`GetNormalizedCursorPosition`, `IsCanvasMouseFocus` and `ScrollContainer`
(to sit at its foot), and Pins the canvas's `GetLeft`, `GetTop` and
`GetEffectiveScale` and the gamepad cursor's place (`SoftCursor:IsShown`,
`GetCenter`, `GetEffectiveScale`). Frames on the canvas carry no field the client's code
reads on the frames it finds there (`owningMap` on the mouse focus,
`smartNavigation*` and the other SmartNavigation keys on the buttons it
scans), and none is a button to the gamepad's navigation: as the gamepad
interface focuses the map, `SmartNavigation_CanFocusFrame` takes a Button,
an EditBox or a frame with an OnMouseDown or OnMouseUp script for one and
reads that script back (`GetScript`), which put Polestar's function in its
secure code (seen in game: the map's `FocusGamepad` registered its callbacks
tainted). Polestar's world map pins take the mouse with OnEnter and OnLeave
only; a click is a `GLOBAL_MOUSE_DOWN` and a `GLOBAL_MOUSE_UP` of one button
(not the right one, which passes through to the map) on the pin. A view is a frame of Polestar's on the canvas whose OnUpdate runs
only while the map is shown; each frame it compares the map ID, the canvas
size, scale and zoom, the pin scale and the alpha, and tells its listeners
what changed ("show" with fresh values on the map's first frame open).
`tests/nav-mapcanvas.test.js` runs every drawing with the maps' tables
guarded (`stub.guardMap`: any write of addon code fails), pins the list
of what is read and checks that no frame was made with a parent on the maps
or the minimap.

### Pins — map and minimap icons for every module

```lua
Polestar.Pins.SetLayer(layer, pins, opts)   -- replace a layer; opts = { world = true, minimap = true, edge = false, scale = 1,
                                            --   minimapAreas = false }
Polestar.Pins.ClearLayer(layer)
Polestar.Pins.SetLayerVisible(layer, visible)
-- pin = { map, x, y, f, icon (Theme.Media name or texture path), size, minimapSize, color = { r, g, b, a },
--         tooltip = string | function(tooltip), onClick = function(button), priority,
--         glow (soft halo), ring = { r, g, b } (ring round the disc), backdrop (scrim disc), area (yards),
--         hull = { wx1, wy1, ... } (a convex region in world yards on the pin's continent `c`),
--         areaOnly (only the area or hull draws, no pin) }
```

Pins are drawn on the world map for the map being viewed (converted through Compat
for other maps) and projected on the minimap; `edge = true` clamps that layer's
out-of-range pins to the minimap rim. On the world map they are Polestar's own
frames on the canvas, at the frame levels the map gives its own pins (MapCanvas,
below): pins at `PIN_FRAME_LEVEL_SUPER_TRACKED_QUEST`, counter-scaled as a map
pin with `SetScalingLimits(1, 1, 1.25)` is, tooltip and click, the right button
passed through to the map (`SetPassThroughButtons`, restricted in combat: set
once per frame, for frames made in combat once it ends). The gamepad
interface's map cursor (`SoftCursor`, no mouse) hovers them as the map hovers
its own pins: every 0.05 s while it shows, the nearest pin with a tooltip or a
click within 12 UI units (its place from its map percent and the canvas's
`GetLeft`, `GetTop` and `GetEffectiveScale`) shows its tooltip, and a press of
A (`GAMEPAD_FACE_BOTTOM`, polled with `IsKeyDown` so the press still reaches
the map) clicks it; a redraw hands every
frame back the pin it showed, higher priorities on top; layer changes while the
map is open are drawn once, on its next frame (`GetWorldFrames(kind)` runs a
pending draw first). Pooled frames, distance-filtered, minimap
updates throttled; layers with hundreds of pins must cost nothing per frame when
the player stands still. Each layer indexes its pins by continent and 500-yard
grid square when it is set, so a minimap redraw visits only the pins around the
player; layer changes made in one frame share one minimap redraw on the next
(`GetMinimapFrames` runs a pending one first). Nav's own target pins are one layer. A pin's `area`
draws a soft disc of that radius (`Media/Nav/area`, the pin's colour at 0.32
alpha) under every pin on the world map (`PIN_FRAME_LEVEL_QUEST_BLOB`, frames
of their own, no mouse, sized in canvas units so it scales with the terrain). On the
minimap only a layer with `minimapAreas` draws its areas (Nav's target and
`nav.areas`; quest objective areas stay on the world map): textures on one
no-mouse frame under the trail and the pins, every area whose disc reaches
into the view (the layer's grid is searched out to the view plus its widest
area), sized 2 × area × the minimap's pixels per yard, and masked to the
minimap's shape (a round minimap: `Media/Nav/pin-fill`'s disc over the
minimap's width; a square one: a plain square), so a disc is cut at the rim.
A client without mask textures draws only the discs that fit inside.
`GetMinimapAreas(layer)` lists the drawn discs (tests).

A pin's `hull` is a region: a convex polygon cut from solid textures
(`WHITE8X8`) whose quads `SetVertexOffset` bends into place, with pixel
snapping off, so pieces that share an edge are rasterised without a seam or
an overlap. The polygon inset by the rim is filled with quads fanned from its
first point (the pin's colour at 0.2 alpha), the rim is one quad per side
(0.7), 1.5 UI units wide on screen. Every piece shares the polygon's box
around its centre. On the world map a hull is a frame of its own
(`PIN_FRAME_LEVEL_QUEST_BLOB`, no mouse, the box in canvas units; the rim is
laid out again when zooming changes its width by a quarter), drawn when any of
it lies on the viewed map (the view's world-to-percent transform, the trail's).
On the minimap a `minimapAreas` layer's hulls sit with the discs, masked the
same way; a hull is laid out again only when its pin, the zoom, the minimap's
size or (rotating) the facing changed, and walking moves only the first
piece, which the others are anchored to. `GetMinimapHulls(layer)` lists the
drawn hulls with their outlines (tests); `AreaStats()` counts hulls, pieces
and discs per surface (in game: `/dump Polestar.Pins.AreaStats()`).

```lua
Polestar.Pins.SetTrail(runs, opts)   -- runs = { { live = true?, { c, wx, wy }, ... }, ... }; opts = { world, minimap, color }
Polestar.Pins.ClearTrail()
Polestar.Pins.TrailDots(points, spacing, phase, rect, cap) -> count, positions   -- pure placement (tests)
```

The trail: animated dots along straight lines between consecutive points
(Nav publishes the travel route: the player, then each leg's start where the
mode changes and its end, a new run after a Hearthstone; without a route,
player -> target). A live run starts at the player's current position. Runs
break where the continent changes. Dots are anchored to each run's end, so
they stay put as the player walks and crawl toward the destination (one
spacing per 1.5 s; still with `ui.reduceMotion`). Minimap: every 40 yd, only
inside the visible disc or square, 5 px, at most 40. World map: every max(15,
map width / 60) yd, clipped to the map, 6 px (counter-scaled like the pins)
under the pins, textures on one no-mouse frame, at most 300. One 20 Hz driver runs only while dots show.
`nav.trailDots` (default on) with `nav.worldPins` / `nav.minimapPins` per surface.
The trail stands in only while route lines draw nothing (`nav.routeLines` off):
`Nav/Layers.lua` clears it while `Polestar.RouteLines.Active()`.

### Route lines (`Maps/RouteStrokes.lua`, `Maps/RouteLines.lua`)

The way to the target on the world map and the minimap, from
`Nav.GetRouteGeometry()` (legs from the current one: `{ kind, pts = { { c, wx, wy }, ... }, current }`,
`NAV_ROUTE_GEOMETRY` on change). The geometry and the painters are ported
from Shortest Path Forever's `UI/Strokes.lua`, `UI/FlightLines.lua` and
`UI/Route.lua` (v1.15.0, Cillian Berragan, GPL-3.0-or-later, with his
permission; `addon/Polestar_Nav/CREDITS.md`).

- `RouteStrokes.lua` is pure: draw paths and a view in, strokes out, into a
  buffer of parallel arrays rewritten in place (no allocation per draw).
  Walks are breadcrumbs (`Media/Nav/pin-fill` on a line one dot long over a
  dark one): 4 px every 9 px on zone maps, 3 px every 7 px on continent maps,
  the spacing carried across bends, none within 2 px of a stop's pin (the
  route's stops and the target). Flights follow their tracks
  (`Maps/FlightPaths.lua`, `travel build`: TaxiPathNode simplified to 10 yd),
  corners cut three times, flight masters kept as the ends; a flight leg's
  points are matched to taxi nodes by position. Boats and zeppelins between
  two docks bow gently off the straight line; the tram, lifts and the rest
  are straight 2 px strokes over a 4 px outline. Hearthstone, teleport and
  portal legs draw nothing (their pins mark them). Legs after the current one
  are at 40%. Lines are clipped to the map (segments, not points) and to the
  minimap's disc or square. Every buffer is bounded (4096 strokes; the
  minimap's 600), so the pools of lines, which the client cannot destroy,
  are too.
- `RouteLines.lua` builds the draw paths once per `NAV_ROUTE_GEOMETRY` and
  paints: one frame of Polestar's on the world map's canvas (MapCanvas, Nav),
  the canvas's size, at `PIN_FRAME_LEVEL_QUEST_BLOB`, no mouse, redrawn on
  map, zoom, size, route, setting and
  theme changes, and one frame over the minimap under Pins' frames, redrawn
  by a 10 Hz driver only when the player, facing, zoom or route changed
  (`Pins.MinimapView()` for the view). The walk being walked starts at the
  player (the nearest point ahead within 60 yd; progress only moves on).
  Colours are Theme tokens per kind, as the travel pins': walk `arrow`,
  flight `success`, boat `npc`, zeppelin `place`, tram and lift `object`;
  outlines `scrim` at 50%.
- `nav.routeLines` (default on) with `nav.worldPins` / `nav.minimapPins` per
  surface.
- Chokepoints: a Travel leg ending at one carries `choke = { kind, name }`;
  `Nav/Layers.lua` gives its route stop (`nav.route`) the kind's glyph on a
  scrim disc in the accent (`icon-lift`; `icon-gate` for gates and building
  doors; `icon-bridge`; `icon-cave` for caves and tunnels; `icon-pass`) and
  the name in its tooltip. Hand-made stops (chain nodes, guide gotos) carry
  no `choke` and keep the plain disc. The route lines' dots leave their gap
  round every stop alike.

### Travel planner and zone crossings

```lua
Polestar.Nav.PlanRoute(p) -> legs | nil, reason   -- pure; Nav/Travel.lua
Polestar.Nav.GetRoute() -> legs, ci               -- the live route and its current leg
Polestar.Nav.EstimateTravel(from, to, budgeted) -> seconds | nil[, "busy"] -- same planner, cached; budgeted (the API's): no new plan past 25 ms a frame
Polestar.Nav.RegisterTravelData(d, replace)        -- TravelData.lua: flight masters, flights, transports, portals, inns
Polestar.Nav.AddTravelPaths(chunk)                 -- learned walking paths (nodes: c, wx, wy, gateway, uiMap)
Polestar.Nav.RegisterCrossings(d)                  -- zone crossings (merges; ids seen before are skipped)
Polestar.Nav.travel.SkipLeg() -> bool              -- leave this hearth/teleport/flight/ride out for the target; else the next leg
Polestar.Nav.travel.SkipReplans(leg) -> bool      -- skipping it replans (the prompts' "Skip this leg"), else "Mark this leg done"
Polestar.Nav.travel.RestoreWalk(c, x, y) -> bool  -- the path to (c, x, y) failed or was cleared: the walk's straight estimate again
Polestar.Nav.travel.Remeasured() -> bool          -- Walk.Measure landed: plan again, take it only if it goes another way
Polestar.Nav.travel.PricePaths() -> bool          -- a later walk's path landed (Walk.LegPath): its legs take its yards and hubs
Polestar.Nav.travel.WalkCostHook(fn)              -- fn(walk, cost) -> cost: a planner rule scaling walk costs, never times
Polestar.Nav.travel.HubText(leg) -> text | nil     -- "Hostile town: <names>" for a walk with leg.hubs
Polestar.Nav.travel.TakeWarning() -> text | nil    -- the current walk's hostile towns, once per walk (the arrow says it)
Polestar.Nav.walk.Measure(c, x, y, water, places) -- one reversed Path.FindMany from the target to the plan's places
Polestar.Nav.walk.Measured(c, x, y, water) -> walkCost | nil -- the planner's p.walkCost for that target: walkCost(c, wx, wy, start) -> cost, yards
Polestar.Nav.walk.LegPath(from, to) -> yards, hubs | nil -- a later walk's searched path: Find's job.yards and job.hubs
Polestar.Nav.travel.Progress() -> seconds, yards   -- the current leg's rest (allocation-free, always finite; rides count down)
Polestar.Nav.GetRouteGeometry() -> { legs = { { kind, pts = { { c, wx, wy }, ... }, current, choke }, ... } } | nil
-- leg = { kind = "walk"|"fly"|"boat"|"zeppelin"|"tram"|"portal"|"hearth"|"teleport"|"lift", from, to, label,
--         seconds, rest, yards, radius (arrival yards at `to`), waypoint (true: `to` is a crossing or chain node),
--         handmade (a walk the crossing data lays out), crossing, side (a crossing walked from end a|b),
--         step ("crossing"|"chain"|"goto", or a chokepoint kind), choke = { kind, name } (ends at a chokepoint),
--         stops (fly: every taxi node hopped), transport, side (the ride or portal and the end boarded),
--         lift, side (a lift ride: Transit's lift id, "top"|"bottom" boarded),
--         item (hearth: 6948), spell (teleport), parent, seg, tail (pieces of a split walk),
--         engine ("cost": a walk into the target priced by the engine's measure; "path": by its own path),
--         hubs = { { id, name, areaId }, ... } (a walk whose engine path enters the other faction's towns) }
```

The planner is Dijkstra over the player, the target, known flight masters,
docks, walk-in portals (one way, `portals` in TravelData), the bound inn,
class teleports, learned path nodes and crossing waypoints. It orders by
a cost (the Hearthstone carries a 120 s margin on top of its time, a
teleport 10 s) and keeps the real seconds of every leg apart, so
`seconds`/`rest` (the arrow's ETA) stay honest. Caps: 20000 pops, 40 ms,
1500 path nodes. With `Nav/Transit.lua` loaded, a ride's wait is the
timetable's (`Transit.NextDeparture(kind, id, now, side)`) for the moment
the player reaches the dock (plan time plus the seconds walked and flown to
it; timetabled rides are first-in first-out, so Dijkstra stays exact), else
the data's average. The call is wrapped in `pcall` and its answer checked
(finite, not negative): a broken timetable only falls back to the average
wait, never stops planning. `Transit.Teleports(now)` lists the castable teleports,
planned like the Hearthstone from the start. While a ride waits, the leg's
caption gains `Transit.Caption` ("Next boat in 1:20"), refreshed every
second; a crossing at a lift (`Transit.LiftNear`) the same.
A transport end is its ship's stop; where the ship lies in the water off
its pier, the end carries a board point on the deck (TravelData's `board`,
below), and the dock vertex is there: the walk to the boat ends on the
deck, with its height, and the boarding (60 yd), leaving (90 yd) and
arrival (120 yd) checks measure from it. The ride, its caption and its
timetable stay the transport's (`Nav.GetTravelData()` ends keep the stop,
`end.board` the deck).
`NAV_TRANSIT(changed, own)` plans again at once for the player's own rides
and teleport changes (`own`, or `changed` nil); a shared time from another
player only when a leg from the current one on uses a changed service
(`changed[leg.transport.id]` or `changed[leg.lift]`), at most every 20 s
(a held-back one runs on the next Refresh after that). A ghost
(`UnitIsGhost`) plans walking only. `SkipLeg` leaves the current hearth,
teleport spell, flight (its departure flight master), ride or portal out of
every plan for this target (another target may use it again) and plans
again; a walk or lift step just moves on. `Progress` counts a ride, flight,
hearth or teleport down from when it became current (a flight from take-off,
when the player is first on the taxi); `Remaining`, the arrow's ETA on those
legs, counts down the same way. `EstimateTravel`
evicts its oldest cached answer when 64 are held. A budgeted call (only
`API.Estimate`'s) starts no new plan once the frame has spent 25 ms planning
estimates (`debugprofilestop`) and answers `nil, "busy"` until the next
frame; the plan it does start may still run to its 40 ms cap. Polestar's own
callers (`ns.TravelCost`, `Nearby.Rank`, the item sources, the dungeon
pickup order) are never refused, so a ranking compares full plans only; their
own caps and the cache bound them. The arrow's ETA adds the 1.25 detour only to straight distances
(`Nav.Sample`'s sixth value `measured` is true along a path).

**Walking paths.** `Nav/Walk.lua` lets the arrow follow real paths on the
ground with Shortest Path Forever's walking engine ("In-game walking routes
(Polestar_Nav)" below). The planner above stays synchronous; its walks into
the target are priced by the engine's measure (below), its other walks by
straight lines until their paths are searched. The walk the arrow is
on is searched first: player to the current walk leg's end, or to the target,
with `Path.Find` on the player's continent (from the player's height,
`Compat.GetPlayerUnitPosition`; a ghost with `waterWalking`). Until the answer, and
whenever there is none, the arrow points straight as before. With a path,
`Nav.Sample` aims at its next point (passed within 5 yd; the nearest
segment among the next 12 decides how far along the player is) and reports
the yards left along it; `Travel.Aim` returns those yards as a fifth value.
A new goal (more than 1 yd away from the searched one) cancels the search
in flight and drops the path; more than 25 yd off the path asks again (at
most every 2 s, the old path kept meanwhile); a failed search (`nodata`,
`outside`, `offmesh`, `unreachable`, `error`, `Path.Available(map)` false,
or `Find` raising) is asked again only after 15 s and 25 yd. Nothing is
asked for in combat (the engine's own queue waits out combat as well).
The walk to the target's own point carries the target's height: the Engine
waypoint's `z` (a guide goal at an NPC or object, Guide data), which
`Nav.GetTargetWorld()` returns fourth (a target set with `Nav.SetTarget` has
none). It goes to `Path.Find` as `to.z`, so the path ends on that floor; a
search with it that fails, or whose path's last engine point before the goal
lies more than 30 yd above or below it, is asked once more without it, and
that answer stands for the goal (later searches for it, after straying, go
without it too). A walk to a leg's end with a height of its own (a dock's
board point) carries that one the same way; walks to other leg ends go
without a height (docs/NAV_QA.md Z1-Z3). A later walk from a board point
(off the boat) starts at the deck's height (`from.z`; asked once more with
neither height when that fails), and the measure into the target gives each
dock place its deck height (`FindMany`'s per-target `z`).
**The player's floor (#234, Ruling 36).** Forever's `UnitPosition` gives no
height (Compat reads its 0 as none), and `Path.Find` from a point without one
starts from the cheapest surface within a cell of it: a roof, rock top,
bridge or upper floor above the player (at the Den's camp in the Valley of
Trials, the rock top over the Den, whence Fastest crossed the hill to
Hana'zua). So `Walk.lua` follows the height of the surface under the player:
`Walk.Aim` checks at most every 0.25 s and reads the cell's surfaces
(`Path.SurfacesAt`, into one reused table) only after moving 1 yd. Unknown,
it seeds where the cell's surfaces lie within 10 yd (the router's `ZTOL`:
the lowest), or, when `Compat.IsIndoors()` answers and the surfaces differ
in indoor-ness (class indoor or indoor city against the rest), on those that
match it when they lie within 10 yd (off the Undercity's lifts: the city
under Tirisfal's outdoor ground); it never overrides a followed floor with
the indoor state. Known, it follows the surface nearest it, never more than
4 yd above (a ramp or stairs at mount speed, plus a jump); any drop is a
fall; none is unknown. It is unknown again on another continent, after more
than 30 yd from where it was last read (a hearth, teleport, landing, loading
screen), after moving with no check for 2 s, on a taxi or a transport
(`Transit.Riding`), within 8 yd of a lift (`Transit.LiftNear`: it changes
level without moving), on a ghost state change, and on a read that raises.
The read never decodes: a cell whose cluster is not decoded reads nil and
queues `Path.Prefetch`, which decodes it under the router's frame budget as a
search's clusters are (not in combat); meanwhile the floor is kept, checked
but not read, and followed from there once the cluster is in. The arrow's
search starts from the client's height when it gives one, else from the
floor when known, checked within 2 s and read within 5 yd of the player
(`from.z`); a search with it that finds nothing is asked once more without it,
keeping the goal's height (one that ends off the goal's floor drops the
goal's height, Z2, keeping the start), and that answer stands. The player's
place in `Walk.Measure` takes the same height. Unknown, every search is as
before; when the floor then becomes known within 5 s of a search sent
without a start height (an arrival: login, hearth, a landing; ambiguous
ground walked off), it is asked once more from the floor (Ruling 36b), once
per such search and never in combat. The router keeps the one cluster the
floor reads decoded, through `Idle` too: the one the player stands in (a read
of another decoded cluster takes the slot at once; a `Path.Prefetch` that
lands after the player walked back keeps out of it). `Path.ReleaseSurfaces()`
cancels a pending prefetch and drops it: the target cleared or no `Walk.Aim`
for 2 s (`Walk:Refresh`), never a style change, a level-up or a hand-made
walk, which only clear the walk.
Hand-made walks win: a walk leg from a crossing or chain waypoint, to a
chain node past its mouth, or from inside a chain (`leg.handmade`), and a
guide goal whose last located goal before it, across steps, is a `goto`
(the author's way in: a cave's mouth; the goto itself is walked) keep the
straight arrow, so a target underground is never routed over the hill
above it. `nav.navRouting` (default on, Guide > Arrow & routes) off, the
engine missing, or Polestar_Nav not loaded: the straight arrow everywhere.
`GetRouteGeometry` (rebuilt on `NAV_ROUTE_GEOMETRY`, which fires on every
plan, leg change, target change and path arrival) gives the map lines the
legs from the current one on: the current walk as the engine's points once
in, else player (or leg start) to leg end; a later walk as its own searched
path once in (below), else straight; a flight as its hop nodes; a ride or
portal as its two ends; a hearth or teleport as from and to.

**Route style.** `nav.routeStyle` (Guide > Arrow & routes > Routes, "Route
style"; `"fastest"`, `"balanced"` (the default) or `"roads"`) goes as
`opts.style` with every search Walk.lua makes: the arrow's own walk, the
planner's measure (`FindMany`) and every later walk. It is sent as saved;
the router (`Costs.Style`) reads anything else (an older build's value, a
typo, nil) as Balanced. A change (`Walk:OnSettings`, which notes the style
at the first settings pass) drops every walk priced in the old style: the
arrow's path (`Walk.Clear`, straight until the new one is in), the
measure in flight and the kept measures, the later walk in flight and the
kept later paths; then `Travel.Replan` plans at once, its plan measures the
walks into the target again and the arrow and the later walks are searched
again, all in the new style. No line drawn in the old style stays.

**Zone danger.** Every search Walk.lua makes also goes with `opts.danger`,
`Nav.danger.Table(level, startZone, goalZone)` (`Nav/Danger.lua`): every zone
with a level range (`Maps.EachZoneLevels`) whose lowest level is at least the
player's + 4 (x3) or more than + 10 (x20, the other faction's towns' strength), `Nav.danger.Mult`; a zone without a
range (a city, an unknown one) never counts, and nil when none does. The
idea and its 4-level threshold come from Ding! (Yendi, `ding-travel`
2bccf01). The zones a walk starts and ends in are left out (`Path.ZoneAt` at
its two ends: the player and the arrow's goal, a later walk's from and to),
so a quest inside a dangerous zone is still walked to; the planner's measure
(`FindMany`, one opts for all its places) leaves out the target's zone only,
so a place inside a dangerous zone is priced through it. A table is built
once per level and zone pair (the router keys its caches by its signature).
The level is `Nav.danger.Level()`: `Compat.GetPlayerInfo().level`, or
`PLAYER_LEVEL_UP`'s when higher (the client's can lag the event; Danger.lua's
own handler keeps it, registered before Walk.lua's). A level-up drops every
walk priced at the old level and re-plans at once, as a style change does.

The journey planner's straight estimates take the same rule
(`Nav.danger.Along(danger, map, x1, y1, x2, y2)`, `p.walkDanger`): a straight
walk's cost (never its time) is multiplied by the mean, over the middle of
each 100 yd piece of the line, of `danger[Path.ZoneAt(...)]` (1 elsewhere),
the zones of its two ends never counting; the table is the plan's level's
without the player's and the target's zones (`Travel.Replan` and
`Nav.EstimateTravel` alike; the latter's 5 s cache is keyed by the level
too). A walk half through a far-above zone costs x10.5, half through a
dangerous one x2. The zones read are kept per chunk (16 to a tile) for the
session's `Path.ZoneAt`, so later plans between the same places ask the
router nothing. With `nav.navRouting` off or the guiding handed to Shortest
Path Forever (`Nav.HandedOff()`), the next plan's estimates are today's at
once, even though the loaded engine stays; likewise without `Path.ZoneAt` (no
maps), its zone field or a dangerous zone. A measured walk (`p.walkCost`)
already carries the router's pricing.

**Walks priced by the engine.** A straight line x1.25 cannot tell a walk
round a ridge from one over it, so the planner would land at a flight master
whose straight walk crosses a mountain. On a continent the engine covers
(`Path.Available`), each plan hands Walk.lua the places a walk to the target
can start from (`p.places`: the player, known flight masters, docks and
portal ends, the bound inn, teleport landings, crossing ends and chain
mouths), and `Walk.Measure` runs one `Path.FindMany` from the target (at the
target's height, `Nav.GetTargetWorld`'s fourth value, so a walk into an
Undercity quarter is measured to its floor; a batch with it that finds
nothing is asked once more without it) to the nearest 16 of them within
3000 yd, reversed (`reverse = true`), so each cost is that place's walk to
the target (after Shortest Path Forever's goal batch,
`Journey/JourneySearch.lua`, v1.16.0), with its yards beside it
(`job.yards[i]`). The next plans take `p.walkCost` (`Walk.Measured`: cost,
yards) and order those walks by the cost and time them by the yards, at run
speed, with no detour;
their legs carry `engine = "cost"` (a target inside an approach chain is
reached by the chain's straight link and keeps its straight price). Rules: a
place the engine finds no walk from (`false`: Thunder Bluff's flight
master, on a tower it cannot snap from) and every place when none has a walk
(the target snapped off the ground) or the batch failed keep the straight
estimate; a place farther or beyond the nearest 16 keeps it too; the
player's measure holds within 50 yd of where it was taken. Farther, the
player's walk counts as missing from the measure, so the next plan (at most
once per replan) measures it again; meanwhile it is that measure less the
yards moved (its cost scaled alike), never less than the straight distance (x1.0), so a walk never
gets dearer for coming closer. A walk from a crossing end stays hand-made
(drawn straight, never searched); only its price is the engine's. Measures
are fixed per target (the last 4 targets are kept), so plans never
flip-flop on them; a target is measured again only when a plan has a place
its measure lacks (a flight master learned, a new bind, the player come
within reach or walked away). When a measure lands, `Travel.Remeasured`
plans once more and takes the new plan only if it goes another way (other
flights, rides, portals, hearth, teleports, crossings or chain waypoints);
the same way keeps the route and its progress, and its later walks take the
fresh plan's prices (a walk already priced by its own path keeps that). On a
flight it waits for the landing (which plans again), on a boat for the next
Refresh after the ride. One batch runs at a time; a new target cancels the
old one's; none starts in combat (owed until it ends; the engine's queue
pauses a running one), with `nav.navRouting` off, or while handed off to
Shortest Path Forever (`Walk:Refresh` cancels one in flight). The planner
itself never waits: the first plan is straight, the measured one follows a
few frames later.

**Every later walk's path.** Once the plan has settled (no measure running)
and the arrow's own search for the walk it is on has answered (checked on
every `ROUTE_CHANGED` and `ROUTE_ADVANCED`: the current walk's goal must be
the one searched, with a path or a failure; a flight, a ride or a hand-made
walk has none to wait for), each later walk leg that is not hand-made, not
a piece of a split walk and not the walk on from a guide `goto` (the arrow
goes straight from the mouth) is searched once with `Path.Find`, one at a
time, the last walk to the target's height (once more without it, as Z2),
kept by its ends and water mode (the last 32; a failure is kept too and
stays straight). When it lands the route lines draw that leg along it and
`Travel.PricePaths` gives it the path's yards (`Find`'s `job.yards`), run-speed seconds and hostile towns (`leg.hubs`)
(`engine = "path"`), so the journey panel's times follow the ground; the
boats, zeppelins and trams after it are timed again by their timetables from
the new arrival (the current leg counts whole). A fresh plan through the
same walk takes the kept path at once. A search whose leg leaves the route
is cancelled; none starts in combat, with `nav.navRouting` off, or while
handed off (`Walk:Refresh` cancels one in flight).

**Chokepoint steps.** When the path arrives, the walk the arrow is on is
split into legs where the path passes a chokepoint. It splits at the
lifts `Transit.Lifts()` knows when Polestar_Nav has no chokepoints, plus the crossings, approach chains and guide
`goto`s the planner already makes legs of, and Polestar_Nav's
`PolestarNavChokepoints[map]` table (`Nav/Chokepoints.lua`, generated by `nav
pack`: lifts, gates, bridges, tunnels, passes, cave and building mouths, each
with a radius), read instead of the Transit lifts. A chokepoint counts within its radius of the path, snapped to the
nearest point on the path (the step ends there, so no leg runs out and back:
K5); ones within 20 yd of the player, the walk's end or the step before are
dropped (K7), and ones within 30 yd of a crossing, chain node or a guide
`goto` end leave the hand-made caption alone (K8). Captions: a passage names
the area on the side the path reaches 25 yd past it ("Cross the bridge to
Lakeshire", "Through the gate into Orgrimmar"); a cave or building its
name ("Walk to the Frostmane Hold cave mouth"); without a name, the kind and
the zone ("Through the gate in Durotar"); never empty or "Unknown" (K1). A
lift is a walk to the landing the path reaches first ("Walk to The Great
Lift, Bottom": the side comes from the path's direction, K4) and a `lift`
leg to its paired landing ("Take The Great Lift"), timed and captioned by
`Transit.NextDeparture`/`Caption("lift", ...)` (30 s without); other steps
carry no wait (K3). The names in the captions are the client's, in its
language: each chokepoint carries the AreaTable ids of its name, zone and
sides (`area`, `zoneArea`, read with `Names.Area`) and a lift its
GameObject (`liftObject`, the names pack's object name, else the Transit
lift's area name); the English names are kept for enUS and as the fallback.
The pieces' seconds are whole seconds of the path at run
speed that add up exactly to the walk (K6), and every piece keeps `parent`
(the whole walk), `seg` (the path segment its end lies on) and `tail` (path
yards after it): the arrow keeps following the one path to the whole walk's
end and moves to the next piece within its radius or once past its segment.
The split runs once per path (`Travel.SplitWalk`, `ROUTE_CHANGED`) and again
after a fresh plan of the same walk from the path already in, so the steps
stay the same as the player walks (K2). A walk with no stops on its path
stays one leg and takes the path's measure: `yards` the path from the
player to its end, `seconds` that at run speed (the planner's pace), its
straight estimate kept in `straightYards`/`straightSeconds`; `ROUTE_CHANGED`
fires as for a split, so the journey's legs, `Progress`, `Remaining` and the
panel header agree. When that path's search fails or the path is cleared
(`Walk.Clear`: no target, `nav.navRouting` off, a hand-made leg),
`Travel.RestoreWalk(c, x, y)` puts the straight estimate back. Split pieces
keep their path times.

**Zone crossings.** Without crossing data a continent walks as it always
did: straight lines between any two points on it (x1.25 detour) plus learned
paths. With full crossing data for a continent (`complete = true`), a straight
walk stays inside one zone; between zones it goes only through

- a crossing: two waypoints, one in each zone, at a tunnel, pass, bridge, gate
  or lift, each with an arrival radius, joined by an explicit walk link, with a
  caption per direction (`ab`, `ba`; else "Go to <zone>"), optionally one way;
- an open-ground pair: two zones whose shared border is walkable anywhere
  (optionally one way);
- an approach chain: ordered nodes with radius and caption (a cave, a climb, a
  dungeon approach). Only the mouth (and with `open = "both"` the last node)
  links to its zone; the other nodes link only to their chain neighbours. A
  start or target within max(2 x radius, 30) yd of such a node is inside the
  chain and attaches only to the nearest node and its neighbours, so routes
  enter at the mouth and leave the way they came ("Follow the path out", or the
  node's `back` caption).

A point's zone is its uiMap when the crossing data knows that zone; a zone
the data lists as `wild` (no crossing data, e.g. the zones only Forever has)
walks as before; any other map (a continent map, an instance) is placed in
the smallest known zone frame holding the point (Forever's frame where
Forever redrew the map, Stormwind City with its harbour, else Era's). Walk
legs end at every crossing
or chain waypoint and carry its caption and radius; the arrow shows the
current leg's caption and points at its waypoint ("Enter Orgrimmar" at the
gate, then the target's own label).

**Re-planning.** On target, zone and subzone changes, landing, the
Hearthstone coming off cooldown, binding, the flight map opening, a flight
path learned (`UI_INFO_MESSAGE` `ERR_NEWTAXIPATH`: the flight master within
60 yd is marked known), and, with crossing data, on arriving at a crossing or
chain waypoint and on moving more than 50 yd from where a plan at least 30 s
old was made (checked at most once a second). `ROUTE_CHANGED` (legs) fires on
every plan, `ROUTE_ADVANCED` (legs, ci) when the current leg moves on.

**Data.** `node tools/polestar.js travel build` writes TravelData.lua
(committed: flight masters and flight times, boats, zeppelins, the tram and
inns from the client tables, learned paths, the shipped zone crossings, and
crossings learned from zone changes in recordings,
`tools/lib/travel/crossings.js` `recordedCrossings`, registered with
`complete = false`: they refine a continent that has full crossing data and
change nothing elsewhere). Names the player reads come from the client in
its language: a flight master by its TaxiNodes id (`Travel.TaxiName`, the
names pack's `taxi`), a dock, portal end, teleport landing or inn by the
AreaTable area each carries (`Travel.PlaceName`, `Names.Area`), a boat's
route from its two ends' areas, the tram and the lifts by their area
(`L["%s, east lift"]` and its kin), a class teleport by its spell; the
English names stay for enUS, logs and matching. The shipped crossings are the full crossing data
of both continents (`complete = true`): `tools/lib/travel/crossings.json`,
committed, written by `node tools/polestar.js travel import --carbonite
<ZoneConnections.lua> --source <text>` from Carbonite's Classic Era zone
connections (GPL-3.0; `tools/lib/travel/carbonite.js`): its walks between
two zones of one continent, both ways unless Carbonite marks one way, every
end with a 30 yd arrival radius (Carbonite gives none); its boats, zeppelins,
tram and portals are TravelData's own transports and are left out. `travel
build --shipped none` builds without them (the test fixtures). An optional
local crossings file, `data/local/crossings.json` (gitignored), adds to them:
the build validates it and writes it into the local data addon
`addon/Polestar_Travel` (gitignored; `## Dependencies: Polestar`, registers
with `RegisterCrossings` at load, which merges; installed when built, never
packaged). Without the file nothing is written and TravelData.lua never holds
it.

**Board points.** A boat's stop (its TaxiPathNode stop) is where the ship
lies, 12-14 yd off its pier in open water at most docks. `travel build`
reads the navigation grid (`--grid <dir>`, default `data/local/nav4`;
`--grid none` or no grid: no board points, one warning) and gives every end
whose point is not on dry walkable ground (a grid column with a surface
that is not swum, not blocked and above the water there) a board point
`{ wx, wy, z }` (`tools/lib/travel/transports.js` `boardPoint`): the
nearest such surface within 30 yd, in a region of at least `SNAP_REGION`
surfaces and open both ways (path.js's snap rules: not a piling or a pocket
under a floor), at equal distance the larger region (the one the town is
in), then the lower surface; an end with none warns. travel.json carries it
as the end's `board`, TravelData.lua as the end's tenth field (after its
AreaTable area). Zeppelin and tram ends stand on their platforms and get
none.

The crossings file (schema 1, Era map percent):

```json
{ "schema": 1, "frame": "e",
  "crossings": [ { "id": "durotar--orgrimmar",
                   "a": { "map": 1411, "x": 45.5, "y": 12.1, "radius": 15 },
                   "b": { "map": 1454, "x": 52.5, "y": 84.8, "radius": 15 },
                   "ab": "Enter Orgrimmar", "ba": "Leave Orgrimmar", "oneWay": false } ],
  "open": [ { "a": 1429, "b": 1431, "oneWay": false } ],
  "chains": [ { "id": "a-cave", "name": "A Cave", "open": "mouth",
                "nodes": [ { "map": 1413, "x": 45.9, "y": 36.2, "radius": 20, "caption": "Enter the cave" },
                           { "map": 1413, "x": 46.2, "y": 34.9, "radius": 15, "caption": "Follow the path", "back": "Climb out" } ] } ] }
```

Validation (every error names its entry, e.g. `crossings[3] (id).a: radius
500 outside 3-100 yd`): no unknown keys; ids lower-case, unique across
crossings and chains; maps with an Era frame; x, y in 0-100 unless the point
says `"offMap": true` (then -50-150); radius 3-100 yd; a crossing's ends on one
continent, in different zones, at most 1000 yd apart; open pairs distinct,
on one continent, not repeated; chains of 2+ nodes on one continent with hops
of at most 600 yd; captions plain text of at most 160 characters (no `|`
escape codes). `travel route` runs the addon planner and includes
Polestar_Travel when it is built (`--crossings-lua none` leaves it out).

**Chains from recordings.** `travel chain --to <map,x,y> [--name <place>]`
drafts an approach chain from the recorded walks that pass within 30 yd of a
target, for a person to check in game before it goes into the crossings
file (`--session <id>`, repeatable, keeps only those sessions' walks). Each
pass by the target is an approach on the way in and, with `--reverse`, on the
way out reversed (a way out is not always a way in), followed back `--within`
yd (300); a shorter one does not count. It leaves the straight line where it has walked 20 yd more than a straight walk
to the target would have, and its path from there to the target, simplified
into nodes (Douglas-Peucker, `--tolerance` 8 yd), is its chain. Walks from
different sides meet at the real mouth, so the shortest chain is printed,
with every approach's departure point beside it. An approach that keeps to
the straight line is reported with a warning but does not stop the draft:
recordings have no height, so a walk that followed the arrow onto the hill
above a cave looks straight too; only when every approach is straight is
there no chain. Radii are at most 15 yd at
the mouth and 10 inside, and under half the shortest hop; captions are
left unset, so the addon's translated "Follow the path" applies (the mouth's
is "Go to <place>" with `--name`). A single
walk from the side away from the mouth starts the chain where it turned off
the straight line, around the mountain: a walk from the open side, or the
reviewer, moves the mouth. The walks are `tools/lib/travel/paths.js`
`recordedWalks`, the ones learned paths are built from; the chain is
`crossings.js` `recordedChain`.

**Aids from the navigation grid.** `node tools/polestar.js nav aids`
(`tools/lib/nav/aids.js`; the grid is described under "Navigation grid")
generates a file in this schema from the grid (`nav build`) with
no per-place rule: a surface's zone is its chunk's area id walked up
ParentAreaID to a zone map with an Era frame (Ironforge and Undercity, whose
chunks belong to the zones around them, stay `wild`); a zone's open ground
is its largest component over gentle links (up to 35°, jumps, swims, lift
rides) inside the zone; a zone pair is `open` when at least 60% of its land
border joins the two open grounds, no blocked stretch passes 400 yd and most
probes across route easily (no steep ground or climbs, at most x1.6 the
straight line's time); otherwise every walkable passage (border links and
falls between the open grounds, joined within 40 yd, cut at 200 yd) that an
easy route crosses is a crossing (ends 25-60 yd inside each zone along that
route, radius half the passage's width, one way when only falls cross it;
captions for tunnels, model bridges over liquid or air, and lifts). Every
place the guides, quest givers and enders, flight masters, inns, trainers and
dungeon entrances use is tested for a pocket: when most straight lines from
up to 12 open-ground points around it are not walkable and 75% of the routes
from them share their last 40 yd or more, through a cave (indoor under
terrain), a building, a lift, a climb or a narrow way, that stretch becomes
an approach chain (targets on one chain's way join it). It writes
`aids.json` in the grid's folder (`data/local/nav/aids.json` by default,
`--out` another file; `source` and `build`, the grid's client build,
on top) and with `--report` `aids-report.{json,md}`: every consecutive pair
of located goals in the guides planned by `tools/lib/nav/arrow.js` (many
PlanRoute calls in one Lua process) without and with the aids, and how many
walk legs cross ground the grid cannot walk (`nav.los`), plus a comparison
with the local crossings file (never changed). `--lua <file>` writes the
aids as a Crossings.lua; `node tools/polestar.js travel build --offline
--crossings data/local/nav/aids.json --travel-addon <test folder> --json
<test folder>/travel.json --lua <test folder>/TravelData.lua` builds a test
copy of the data addon from them without touching `addon/Polestar_Travel` or
the committed travel files. Shipping them is the owner's call.
**Timetables, portals and teleports (`Nav/Transit.lua`).** Ported from
Shortest Path Forever by Cillian Berragan (GPL-3.0-or-later, used with
permission: his `Transport/Model.lua`, `Timetable.lua`, `Observer.lua`,
`Sync.lua`, `Teleports.lua` and `tools/gen_routes.py`, `gen_transit.py`).

```lua
Polestar.Transit.Now() -> server seconds with a fraction
Polestar.Transit.NextDeparture(kind, id, now, side) -> wait, ride, timed | nil
    -- id: TravelData transport id (or the entry), or a lift id; side "a"|"b", "top"|"bottom", nil = soonest;
    -- now: when you reach the dock. wait until it leaves with you aboard (its `board` seconds early
    -- enough), ride until you are off; untimed: the expected values, timed = false
Polestar.Transit.NextArrival(kind, id, now, side) -> arriveIn (0 = there), departIn | nil while untimed
Polestar.Transit.Caption(kind, id, now, side) -> "Next boat in 1:20" | "Boat docked, leaves in 0:40"
    | untimed "Next boat in about 2:55"
Polestar.Transit.Riding(now) -> { kind, route, dock, arriveIn } | nil   -- the ride the observer identified
Polestar.Transit.Lifts() -> { { id, name, c, wx, wy, top, bottom }, ... };  LiftNear(c, wx, wy [, yards]) -> id, name
Polestar.Transit.Teleports(now) -> { { spell, name, cast, ready, to = point | nil, bind }, ... }
-- NAV_TRANSIT fires when a sighting changes a timing or the usable teleports change.
```

Every transport runs a fixed loop, but where in it the loop is depends on
the server's uptime, which no API tells. The data gives each loop (`routes`)
its period, stops (arrive and depart, ms into the loop) and track frames;
each `services` entry (a TravelData transport, the tram, a lift) the loops
serving its two ends, its boarding margin (boats and zeppelins 10 s, the
tram 5 s, lifts 2 s), the tram's loading screen and walk in and out
(`pre`, `post`: 15 s each) and its expected wait and ride while untimed.
A *sighting* dates a loop (`epoch`: server ms at phase 0, kept modulo the
period; phase = (now - epoch) % period). The observer samples the player's
`UnitPosition` (through Compat) once a second; moving at least the loop's
fit speed (12 yd/s for boats, 6-8 for lifts) within 40 yd of a moving leg
(10 yd for lifts) gives the phases there; the phase offset most samples of
one ride agree on (within 8 s, 2 s for lifts), spanning at least the fit
span (30 s, lifts 2-4 s; a bystander's offsets drift a second per second),
dates the loop, once the ride clearly fits one loop (1.25x the runner-up:
loops sharing a lane both fit). It fits every 10 samples and when 30 s pass
without one or the player leaves the world; a new sighting prints "Timed the
<route> from your ride" unless one of yours is under 10 minutes old.
Sightings are kept per realm in `PolestarDB.transit[realm][route] = { epoch,
seen, source }` and dropped after 6 hours (a restart resets the loops).
Sharing is opt-in: with `nav.shareTransit` (off by default; Options, Arrow &
routes, "Share boat times") a new sighting of yours goes to the guild and
group as an addon message (`PolestarT1`: `S<route>:<seen s>:<phase ms at
seen>;...`; never to a raid in a battleground or arena). A guild query (`Q`,
sent 15 s after login) is answered after a random 2-12 s, at most every 30 s
per channel, with your own fresh sightings no other reply on that channel
has carried as new meanwhile. Incoming ones count only from guild, party
and raid (never whispers, instance chat or a battleground raid), from a
sender on this realm (a name with another realm is dropped), when valid (a
known loop, phase inside it, at most 5 s in the future, then dated now,
under 6 hours old) and newer than the one held. Your own ride always
replaces another player's sighting; another player's never replaces your
own under an hour old. Your own rides fire `NAV_TRANSIT(changed, true)` at
once; shared sightings are gathered and fire `NAV_TRANSIT(changed)` at most
every 20 s, `changed` naming the transports and lifts retimed, so the
planner replans only when its legs use one. A departure counts only if it leaves at least `board` seconds
after you reach the dock; a docked visit leaving sooner gives way to the
next. The ride is to the next arrival at the other end. A service whose
loops are untimed costs its expected wait: over a uniform phase (and
independent phases for its several loops, Thunder Bluff's two cars and the
tram's two trains), board + the integral of the chance every loop is still
to leave, about half a loop for a single departure; its ride is the
gap-weighted mean. The planner (`Nav/Travel.lua`) costs a ride with
`NextDeparture` at the time it reaches the dock and captions the current
unboarded ride with `Caption`. `Teleports` lists the class teleports
(`nav.teleports`, default on) the character knows (`Compat.IsSpellKnown`)
with their reagents in the bags (a Rune of Teleportation for a mage's city),
`ready` the seconds of cooldown left (`Compat.GetSpellCooldown`; the global
cooldown does not count); Astral Recall is a `bind` teleport to the bound
inn. Walk-in portals (TravelData `portals`: Darnassus <-> Rut'theran
Village, 5 s) are one-way links a -> b for the planner.

`travel build` makes this data (`tools/lib/travel/timetable.js`, after
Shortest Path Forever's generators). Boats and zeppelins: the CMaNGOS
mangos-classic transport model (`TransportMgr::GenerateWaypoints`:
Catmull-Rom spline lengths sampled three times a segment, 30 yd/s with
1 yd/s² acceleration and braking, each stop's TaxiPathNode `Delay` docked)
over the loop's client TaxiPathNode points, stretched onto the period CMaNGOS
classic-db sniffed from the original servers (TaxiPaths 241, 285, 292, 293,
295, 301, 302, 303; the Forever-added loops by the mean of those
corrections, about 0.05%). A sniffed loop the model misses by more than
0.5%, or one too short to model, keeps the distance estimate with a
warning; otherwise its expected wait and ride replace the transport's
`ab`/`ba`/`waitA`/`waitB`. Lifts and the tram: the Forever client's
`TransportAnimation` (offset from the spawn by time index, Y reversed as
CMaNGOS `ElevatorTransport::Update` reads it), placed at the classic-db
`gameobject` spawn of each car (seven lifts, by entry and spawn guid; cars
sharing a period share one loop) and of the trams' two lead trains, whose
stations split at y = 1200 in the tram instance. Portals: the Era client's
`AreaTrigger` 527 and 542 to their classic-db `areatrigger_teleport`
destinations. Teleports: `SpellEffect` teleport effects (5 or 252) to a
`spell_target_position` (implicit target 17) or the bind point (9), learned
by a class (`SkillLineAbility.ClassMask`), named by `SpellName`, cast time
from `SpellMisc` + `SpellCastTimes`, reagents from `SpellReagents`; the
Hearthstone stays the planner's own leg, and a destination on no mapped
zone (Teleport: Dalaran) is skipped. The classic-db dump (pinned commit
22b5146, ~13 MB) is fetched once to `data/sources/cmangos/<rev>/`, and only
the rows used are kept beside it in `transit.json`; the client tables are
cached with the others. Without those sources the boats and zeppelins are
still timetabled and the rest is skipped with a warning.

### In-game walking routes (Polestar_Nav)

The arrow's walks follow real paths thanks to Shortest Path Forever by
Cillian Berragan (https://github.com/cjber/shortest-path-forever,
GPL-3.0-or-later, used with his permission). Polestar's walking router
started from Shortest Path Forever v1.16.0 by Cillian Berragan, with thanks;
Polestar maintains it since 2026-10-16. `addon/Polestar_Nav` holds that
router, running on Polestar's own walking maps of Eastern Kingdoms,
Kalimdor and Zephras Isle (packed from our navigation grid in maps format 2,
grown from his map format, `nav pack`); Polestar's travel planner (above) keeps choosing
flights, rides and the Hearthstone, and the walking is the router's: the
arrow's walk, every later walk's path, and the measure of the walks into the
target the planner prices (`Path.Find` and one reversed `Path.FindMany` per
target, "Walks priced by the engine" above). On a map of format 2 (a ground
class byte per node: road, gentle or steep slope, indoor, indoor city, and the
Alliance and Horde hub bits) a grid step costs its length times
`Costs.Mult(class, profile, style)` (`Routing/Costs.lua`), times the swim
factor in water. The route style (`Costs.Style`: `"fastest"`, `"balanced"`
or `"roads"`; nil or any other value is Balanced) picks the multipliers by
base class, and a hub hostile to the profile multiplies its ground x20 in
every style:

| style | normal | road | gentle | steep | indoor | indoor city | smallest |
|---|---|---|---|---|---|---|---|
| Fastest | 1.0 | 1.0 | 1.0 | 1.2 | 2.0 | 1.0 | 1.0 |
| Balanced (default) | 1.0 | 0.8 | 1.3 | 2.5 | 2.0 | 1.0 | 0.8 |
| Roads | 1.0 | 0.5 | 1.6 | 4.0 | 2.0 | 1.0 | 0.5 |

Fastest walks the shortest way (steep ground at 1.2 breaks near ties);
Balanced takes a road up to 1.25 times the straight way; Roads up to 2
times, and climbs less. Each graph edge carries one cost per profile
(`costAlliance`, `costHorde`, `costNone`), baked by the packer at Balanced's
numbers (`Costs.MULT`, `Costs.HUB`, mirrored in `tools/lib/nav/costs.js`),
and its yards (the record layout is at `PathGrid.lua`'s `adjacent`): the
walking maps are the same for every style. The style prices every grid step
(the searches inside a cluster, the connections of the ends to the graph,
the refinement of each crossed cluster) and the straightening; the graph
edges keep Balanced's costs in every style, so which tiles a very long walk
crosses follows Balanced, and the style shapes the walk inside them. The A*
heuristics scale by the smallest multiplier they may meet: a search on the
grid alone by the style's, one that crosses graph edges (and
`Path.LowerBound(map, from, to, style)`) by the smaller of the style's and
`Costs.MIN` (0.8), so they stay admissible; Balanced searches exactly as
before styles. The drawn line straightens the found path
(`PathGrid.lua`'s `smooth`) only over ground no costlier for the profile in
the style than the path stretch it replaces, and into a hostile hub only
where that stretch already entered one, so it never cuts a road's bend or a
hostile hub's rim. A map of format 1 (0.2.4's, no class field) is class 0
everywhere, has one edge cost for every profile and keeps the 1.0
heuristic, so it routes and straightens exactly as before classes, for any
profile and style.

**Zone danger.** Each map tile of the walking maps carries the zone of its
16 x 16 chunks (the metadata's `zone` field, `nav pack`: the grid's chunk
area up its AreaTable parents to a zone of `zones.json`, as its uiMapID; the
layout in `pack.js`'s HEADER). A search's `opts.danger`, a table
`{ [uiMapID] = multiplier }` its caller builds, multiplies a grid step into a
node by its chunk's zone's multiplier, on top of its class, profile and
style; a graph edge costs its baked cost times the larger of its two ends'
multipliers; straightening compares the same products, so the drawn line
never cuts back into a zone the path went round. No zone is closed: when the
only way crosses one, the walk takes it at that price. Multipliers are at
least 1, so the heuristics and `Path.LowerBound` stay admissible; entries of
1 or less are dropped. The searches' cache tags carry the table's signature
(`uiMap=mult` by uiMapID), so two tables never share a cached connection or
path, and `Path.ReuseMany` reuses a batch only for the same signature.
Without `danger` (nil, `{}`, or on a map without the field) every search is
byte-identical to before (tested against the router before it, from git).
`Path.ZoneAt(map, x, y)` reads a point's zone from the same field (nil
outside it), without decoding any cluster. The field is 29 KB of `Nav0.lua`
(675 tiles), 40 KB of `Nav1.lua` (928) and 3 KB of `Nav2991.lua` (72); the
packer needs no map frame for it, so Forever's own zones (Riverglades, Mount
Hyjal, Shen'dralas, Zephras Isle) are there too; loaded, about 0.1 MB.

```
Polestar_Nav.toc        LoadOnDemand, Dependencies: Polestar
  Nav\Nav.xml           the walking maps -> PolestarPathData[map], then the chokepoints
    Nav0*.lua, Nav1*.lua, Nav2991*.lua  ours: `nav pack` from the grid (128 cells a tile, 4.17 yd), listed in PACK.json
    Chokepoints.lua       ours: PolestarNavChokepoints[map] for the walk's named steps
  Routing\Costs.lua     ours: Polestar_NavCosts, the ground classes' multipliers and the faction profiles
  Routing\PathGrid.lua  ours from his: decoded clusters and ground classes, memory ceilings, frame slicing, string-pulling
  Routing\Path.lua      ours from his: HPA* between clusters, the grid inside them priced by class, FindMany's Dijkstra
  Routing\PathJobs.lua  ours from his: the coroutine queue sharing Path.budget (2 ms) a frame
  API.lua               Polestar_NavEngine = the Path table, plus Available(map); the memory ceilings
```

**Memory.** The packed maps (format 2, all three) are 33.9 MB of files; loaded,
the Lua heap holds about 34 MB (0.2.4's format 1 maps 28 MB; his own three maps were about 12 MB). A search decodes the clusters (ADT tiles) it
crosses: by the engine's own accounting (`PathGrid.lua` gridSize, an upper
bound) about 3.3 MB a cluster on average: 15.8 MB for Kharanos to
Thelsamar (6 clusters), 28.5 MB for Razor Hill to the Valley of Strength
through Orgrimmar (4), 46.4 MB and 4.9 MB of graph for a 7,700 yd walk from
the Crossroads to Tanaris (17 clusters, none evicted); the decoded graph of a
whole continent is 4.2 MB (Eastern Kingdoms) or 4.9 MB (Kalimdor). His
ceilings, 24 MB of grids and 4 MB of graph, were sized for his 8 yd cells, so
`API.lua` sets `Path.cacheKB` 48 MB and `Path.graphKB` 16 MB while a search
runs (maps format 2's longest corpus walk decodes 40.9 MB of grids and 15.7 MB
of graph) and `Path.graphRestKB` 6 MB at rest. With no search queued (`Idle`)
the decoded grids go and the decoded graph is trimmed to 6 MB: measured
standalone (Task 15, LuaJIT heap at the router's callbacks), 33.8 MB with the
maps loaded and no search, 38.3 MB after the six longest corpus walks and
`Idle` (0.2.4: 27.8 MB and 33.4 MB), and a peak of 79.2 MB seen during those
walks. Since the walking floor (#234) the cluster `Path.SurfacesAt`
reads (the player's) stays decoded at rest while the arrow runs: one cluster,
3.3 MB on average by the engine's accounting (3.1 MB allocated decoding the
Den's camp's under LuaJIT); none without a target or 2 s after the arrow's
last update.

**A map is used whole.** `API.lua` drops a map whose packed tables hold
fewer entries than its `counts` (a part file missing from the folder, or one
that failed to load), and every map when the client lacks
`C_EncodingUtil.DecodeBase64` or `DecompressString`: the engine then has no
data for it and the arrow points straight, where it would otherwise raise a
Lua error the first time a search reads a missing cluster's graph
(`tests/nav-load.test.js`). A grid block that fails to decode is the
engine's own case: that cluster counts as empty. The bytes of the shipped
blocks are not checked at load; `nav check` pins them by sha256.

**The handoff.** Polestar loads the addon with `Data.Pack("Polestar_Nav")`
at login or later, never at its own `ADDON_LOADED` (decoding nothing, it
still builds about 34 MB of packed strings) and never in combat; with
`nav.navRouting` off it is not loaded. `API.lua` sets the global
`Polestar_NavEngine` to the router's Path table; `Nav/Walk.lua` keeps it as
`Nav.Path`. The calls are Shortest Path Forever's, with the fifth argument
widened:

```lua
Path.Find(map, from, to, callback, opts) -> job      -- callback(points, cost, job) or (nil, reason, job); job.yards, job.hubs
Path.FindCost(map, from, to, callback, opts) -> job  -- callback(cost, reason, job), no drawing points; job.yards
Path.FindMany(map, from, targets, callback, opts, reverse, progress) -> job  -- costs[i] or false; job.yards[i]
Path.ReuseMany(job, point, profile, style, danger) -> bool  -- may a batch from job's source serve one from point for profile in style with danger
Path.ZoneAt(map, x, y) -> uiMapID | nil  -- a point's zone (the maps' zone field)
Path.SurfacesAt(map, x, y, out) -> n | nil  -- the cell's walkable surfaces: out[i] height, out[-i] marks (1 water, 2 indoor); nil: its cluster not decoded (a Prefetch is queued)
Path.Prefetch(map, x, y) -> job | nil  -- decode that cluster under the frame budget for SurfacesAt (one job at a time)
Path.ReleaseSurfaces()  -- cancel a pending Prefetch; the cluster SurfacesAt reads may go at rest
Path.Cancel(job) ; Path.Busy() -> bool ; Path.Available(map) -> bool
-- opts: a boolean is waterWalking (as every caller passed it before profiles), or
-- { waterWalking = boolean, profile = "Alliance" | "Horde" | nil (Costs.Profile(UnitFactionGroup)),
--   style = "fastest" | "balanced" | "roads" | nil (Costs.Style: anything else is Balanced),
--   danger = { [uiMapID] = multiplier >= 1 } | nil (Zone danger, above) }
```

`map` is the instance map ID (`UnitPosition`'s fourth value: 0 Eastern
Kingdoms, 1 Kalimdor, 2991 Zephras Isle); points are `{ x, y, z }` in
`UnitPosition`'s frame (x north, y west, z optional: it picks the floor).
Results are `{ map, x, y, z }` from start to goal, `points.wet` the yards over
water; cost is running yards with a swum yard counting the map's `swim`
(3) unless `waterWalking`, and on a map with classes each yard times its
class's multiplier for `profile` in `style` (graph edges at Balanced's). Beside the cost every result carries
yards: `Find`'s `job.yards` is the drawn line's flat length; `FindCost`'s
and `FindMany`'s are a second label along the cost-best path (grid step
lengths and the edges' yards), on a format 1 map the cost itself (its edges
carry no yards). `Find`'s `job.hubs` = `{ { id, name, areaId }, ... }` lists the hubs
of the map's `hubs` metadata (`{ id, side, name, areaId, disks = { { x, y, r }, ...
} }`) hostile to `profile` that the drawn line enters, each once, in path
order (`{}` without a profile or hubs). Reasons: `nodata`, `outside`, `offmesh`,
`unreachable`, `error`. Searches run as coroutines in `C_Timer.After(0)`
slices of `Path.budget` ms, wait out combat, and drop decoded clusters once
the queue is empty, except the one `Path.SurfacesAt` reads (the player's
floor, until `Path.ReleaseSurfaces`). `Path.cacheKB` and `Path.graphKB` cap
them meanwhile, and `Idle` trims the decoded graph to `Path.graphRestKB`, all
set in `API.lua`.
The maps are base64 zlib blocks decoded per cluster with `C_EncodingUtil`.
`nav check` holds the maps to `PACK.json` (grid build, cells, date, sizes,
the sha256 of every file), and `Nav.xml` to it.

**Polestar's side: the faction, cost and yards, hostile towns**
(`Nav/Walk.lua`, `Nav/Travel.lua`). Every search goes with opts
`{ waterWalking, profile, style, danger }`, `profile` the player's faction from
`Compat.GetPlayerFaction()` (none when neutral or unread: the router then
prices no hub hostile and still routes), `style` the Route style option
(`nav.routeStyle`, above), `danger` the zones far above the player (Zone
danger, above), so roads are preferred (x0.8 in Balanced), the other
faction's towns avoided (x20) and dangerous zones x3 or x20. On format 2 maps a walk's cost is no
longer its yards, so the two are kept apart: the cost chooses, yards are
what is shown and timed.

- The planner's `p.walkCost(c, wx, wy, start)` (`Walk.Measured`) returns the
  measured walk's cost and its yards (`FindMany`'s `job.yards[i]`): the
  Dijkstra orders by the cost (at run speed), the leg's `seconds` and `yards`
  come from the yards. Those are the no-profile path's yards per graph edge,
  so a measured walk that goes round a hostile town inside one cluster reads
  a little short until its own path is searched (one yards value per edge,
  for every profile); the reversed batch reads outbound edge costs, off by
  at most one entered step at each end.
- The arrow's walk is measured along its path's points (the drawn line,
  whose length is `Find`'s `job.yards`); every later walk takes `Find`'s
  `job.yards` (`Walk.LegPath`, `Travel.PricePaths`). An engine `cost` is
  never shown as a distance.
- `Travel.WalkCostHook(fn(walk, cost) -> cost)` registers a planner rule
  (zone danger is built in, `p.walkDanger`, above; a hook sees its cost): every
  walk the planner weighs is handed to each hook with `walk = { from = { c,
  wx, wy }, to = { c, wx, wy }, seconds }` (one reused table) and its cost in
  the planner's seconds; a number >= 0 back replaces the cost, the time stays.
- Hostile towns: `Find`'s `job.hubs` goes on the walk's leg as `leg.hubs`
  (`Travel.SplitWalk` for the arrow's walk: the unsplit leg, or
  on every piece of a split one; `Travel.PricePaths` for later walks; a fresh search with the same towns, by id, changes nothing). The journey panel shows
  "Hostile town: <name>" (names joined by commas, each name once: two towns
  can share one) under the step in the warning colour, and the arrow says it
  once under its label for 8 s when the walk starts (`Travel.TakeWarning`:
  once per walk end and towns, until the target changes): under the step's
  instruction on a route, under the target's label when the walk is the whole
  route (no journey panel then). A walk whose target is inside a hostile town
  warns too: the router enters it because it must, and the player is told.
  `Travel.HubText` names each town in the client's language by its area:
  `Compat.GetAreaName(areaId)` (`C_Map.GetAreaInfo`; the hub record's
  AreaTable id), else the packed English name, as goto labels and
  `Compat.MapName` do; the "each name once" rule works on the shown name.

**Our own maps, always.** The engine reads only `PolestarPathData`, never an
installed Shortest Path Forever's `ShortestPathForeverPathData`, even when it
holds the same bake: his engine evicts and resets the decoded entries of its
tables (`PathGrid.lua` trimming, eviction, `Idle`, `Reset`) while ours may be
in the middle of a search that already counts a cluster as decoded, which
would end in a Lua error (docs/NAV_QA.md H1). With both
addons installed and not handing off, each holds its own maps in memory
(handing off, `Polestar_Nav` is not loaded: "Hand-off to Shortest
Path Forever"); `tests/nav-maps.test.js`
trims a stand-in for his tables after every frame of one of our searches and
checks the route is unchanged.

**Updating.** The router (`Routing/`) is Polestar's code: it is edited here,
tested by `tests/nav-router.test.js` (synthetic maps with and without the
class field; format 1 against the router before classes, from git) and the
real-map tests, and no tool copies it from upstream any more; its three
files that began as his keep his copyright and the GPL notice under a header
line saying where it started. The maps are Polestar's too (Zephras Isle's
since 2026-10-16, no longer copied from his repository): `nav pack`
writes all three from the grid, and `nav check` and
`tests/nav-maps.test.js` hold them to `PACK.json`; the test also loads the
addon with the real maps (`tests/lua/stub_encoding.lua` decodes them in
plain Lua), walks Goldshire to the Fargodeep Mine mouth and holds the engine
to NAV_QA C2 (a cancelled search never calls back), C6 (Stormwind's flight
master to the Mage Quarter never doubles back) and C17 (searches sliced over
frames). Never edit a map by hand: change the grid, the layers or the packer
and re-pack.

**Measuring the maps.** `node tools/polestar.js nav eval`
(`tools/lib/nav/eval/`) runs the engine outside the client: `harness.lua`
(LuaJIT, else Lua 5.1) loads a folder's maps and router in the client's
order (`tests/lua/stub_encoding.lua` decodes them), drives `Path.Find` and
`Path.FindMany` with the frame pump in hand, and answers one JSON line per
query (cost, the router's yards and hubs when it gives them, points, the
drawn line's yards per zone by `Path.ZoneAt`, cold and warm milliseconds, Lua
memory; an error reported through the client's error handler during a query
fails that query, and the next starts clean). A route with a `level` is
priced with zone danger as the addon prices it: the harness builds the
danger table from each zone's lowest level (`tools/lib/maps/zonelevels.js`),
the start's and the goal's zones (`Path.ZoneAt`) exempt.
`run.js` resolves the route corpus
(`routes.json`: 0.2.4's measured routes, the #98 and #195 reports,
hostile-hub, road, building and slope routes; zone-map ends through
`map-frames.json`, live frame or Era) and, with `--sweep`, one FindMany per
zone with located guide goals and
per side, from the zone's flight master; `metrics.js` measures each drawn
line (the share our grid at `data/local/nav3` cannot walk straight, as
0.2.4's maps were measured; the steepest climb; off-road share and yards in
hostile hubs from `data/local/nav-layers` once built; indoor yards, and
whether an end lies indoors, from the `FLAG.INDOOR` surfaces of the grid at
`data/local/nav4`, the capitals apart as the packer's indoor city class);
`compare.js` judges a candidate folder against `--baseline` (a folder, or
an earlier `--out` report, its indoor yards measured again) on the acceptance
checks A1-A8. A5 holds the building routes (Stormwind's streets, a line
through Goldshire's inn) and every route found with both ends outdoors to no
indoor yards; like A4's climbs, each route with some is listed beside the
baseline's yards, and the baseline's own, for a person to judge the only-way
ones (a tunnel 0.2.4 walks too).

**Licence.** The folder is GPL-3.0-or-later with his copyright (`LICENSE`,
`CREDITS.md`). It is code and data of a GPL program, not reference data:
Polestar's guide-pack exception does not cover it, and nothing from it goes
into a pack.

**Quality.** Every problem reported against Shortest Path Forever that
touches what Polestar uses from it (the router, the maps, route lines,
timetables, map clicks, TomTom, the travel prompts) is listed in
[docs/NAV_QA.md](NAV_QA.md) with the check Polestar holds itself to; test
names cite its ids (rows 1-16, C1-C17, H1-H6, K1-K8, Z1-Z3).

## Quests — quest database, markers, tooltips, quest levels

`addon/Polestar/Quests/` loads the load-on-demand data addon
`Polestar_QuestDB` through `Data.Pack` (≈ 1.3 MB of Lua, ≈ 6.4 MB resident)
at login, and only while `qol.questDB` is on and at least one feature that
needs it is (`QuestDB.IsWanted()`: map/minimap objectives, available quests,
turn-ins, tooltips, nameplates); turning the first one on later loads it then,
and a load refused in combat is retried when combat ends. It fires
`QUESTDB_LOADED`, then `QUESTDB_STARTED`; `QUESTDB_UPDATED` follows every
change to the tracked quest log. Record layouts: `tools/lib/questdb/build.js`.
An entity's spawn clusters (70 yd) cover every known spawn on each map (the
reference data's `pts` and `more`), with no cap on how many.

```lua
Polestar.QuestDB.IsLoaded() / IsEnabled() / IsRunning() / IsWanted()
Polestar.QuestDB.GetQuest(id)  -> { id, title, level, minLevel, races, classes, faction, start = { npc, object, item },
                                    finish = { npc, object }, pre (any-of), preAll, excl, zone, skill, holiday,
                                    objectives = { { kind = "kill"|"item"|"object"|"event", id, count, map, x, y, f } } } | nil
Polestar.QuestDB.GetNpc(id) / GetObject(id) -> { id, name, spawns = { { map, x, y, r (yd), f } } } | nil
Polestar.QuestDB.GetItem(id)   -> { id, name, droppers = { { id, name, chance } }, objects = { ... }, vendors = { { id, name } } } | nil
Polestar.QuestDB.GetItemDroppers(itemID) -> { { id, name, chance }, ... } | nil   -- best chance first
Polestar.QuestDB.GetObjectiveMobs(questID, oi) -> { name, ... } | nil            -- kill target or item droppers
Polestar.QuestDB.CheckAvailable(id, ctx, isDone, isOn, opts) -> ok, reason      -- opts: lowLevel, levelAbove, skillRank
Polestar.QuestDB.EachAvailabilityRef(id, fn) -> needsSkill                       -- fn(q) per quest whose done/in-log state CheckAvailable reads
Polestar.QuestDB.GetAvailableQuests() -> { questID, ... } ; IsAvailable(q) ; WhyUnavailable(q) -> reason | nil
   -- reasons: "eligibility" (faction, race incl. Skyborne high bits, class, holiday), "done", "active", "level"
   -- (minLevel), "grey", "high" (beyond qol.questLevelWindow), "prerequisite", "exclusive", "skill"
Polestar.QuestDB.ObjectivesForNpc(id) / ObjectivesForItem(id) / ObjectivesForObject(id)
                               -> { { q, kind, id, name, cur, max, done, entry = { q, title, ready } }, ... } | nil  -- quests in the log
Polestar.QuestDB.GetMarkers(map [, "objectives"|"turnin"|"available"]) -> { pin, ... }
Polestar.QuestDB.IsGuideQuest(q) -> bool                                         -- in the active guide's current step
```

"Done" comes from `C_QuestLog.GetAllCompletedQuestIDs` (one call per available
scan), else `C_QuestLog.IsQuestFlaggedCompleted` per quest. A scan rechecks every
candidate only after a level-up, a skill change, a filter setting or without the
bulk call; otherwise only the candidates that read a quest whose done or in-log
state moved since the last scan (`EachAvailabilityRef`), plus those needing a
profession skill.

Pins layers: `quests.objectives`, `quests.turnin`, `quests.available`, one pin
per entity spawn cluster and layer (a mob two objectives need carries both
under the higher-ranked glyph: kill > interact > collect > vendor). Objective
clusters at least `MIN_AREA` (12 yd) wide carry their radius as `area`. Markers
and the tooltip/nameplate indexes are rebuilt only when what they show
changed (a quest came or went, got ready or changed title, an objective was
done or undone); a progress count alone only fires `QUESTDB_UPDATED`, since
tooltips and nameplates read counts live. A rebuild reuses the pin tables
the last one kept for the same cluster, with their world position (`c`,
`wx`, `wy`) worked out once, so `Pins.SetLayer` converts only new pins. Look is
applied at publish: while a Polestar guide runs, pins of quests in its current
step (`Engine.GetGuide().steps[Engine.GetStepIndex()].goals[*].quest`, re-read on
`STEP_CHANGED`/`GUIDE_CHANGED`) are 1.3× inside an accent ring and on top;
with `qol.guideDim` every other quest pin drops to 0.6 alpha (`Q.DIM_ALPHA`).

Tooltips go through `Polestar.Hooks` (owner `"quests"`: UnitLines, ItemLines,
ObjectLines, registered only while running) with the suite's quest line,
`Hooks.AddLine(tt, "<Quest>:", "<what> cur/max", quest, textDim | success)`:
"Kill Kobold Vermin 3/10" on the target, "Large Candle 3/8" on a dropper, "3/8"
on the item; quest-starting items get "Starts a quest: <title>".
`Quests/QuestLevels.lua` prefixes "[12]" (and "+" for elite) to quest titles
the client lists without one (gossip, greeting, details; camelot's own log and
tracker already show it, so it adds there only when missing).
(camelot is Forever's game type in Blizzard's UI source: the files the Forever client loads carry `AllowLoadGameType camelot`, and its own overrides sit in `Camelot/` folders.)

Nameplate icons (`qol.nameplateIcons`): a mob an open objective still needs
gets a 16px objective icon (14–20) 3px left of the health bar the player
sees: EllesmereUI Nameplates' unit frame, Plater/ElvUI/oUF, KuiNameplates or
Threat Plates when present, else the shown child of the base plate holding
the largest status bar, else Blizzard's health bar, else the plate itself;
parented to that frame so it follows its fading and scaling. Every access is
guarded; `Quests.NameplateIcon(unit)` returns the icon (tests).

Settings (`qol.*`, Questing → Quests; the markers under Map → Guide & quests →
Quest markers): `questDB`, `availableQuests`,
`questLevelWindow` (0–10, 10 = any; default 5), `lowLevelQuests`,
`mapObjectives`, `objectiveAreas`, `turnInMarkers`, `minimapObjectives`,
`guideHighlight`, `guideDim`, `questTooltips`, `nameplateIcons`, `questLevels`.
The four marker layers (`availableQuests`, `mapObjectives`, `turnInMarkers`,
`minimapObjectives`) and `objectiveAreas` default to off (Map → Guide & quests →
Quest markers); `guideHighlight` only restyles markers those layers draw.

## Gear — item stats, stat weights, upgrade tooltips, reward picks

Gear's part in quest reward choices: QoL, "Quest reward marks".

## Maps — the world map

Each feature is a setting on the Map page (Rares & travel, Zones), and none of
them makes a frame or loads data until it's on. The icon layers (dungeon
entrances, flight masters `maps.taxiPins`, docks `maps.dockPins`, inns
`maps.innPins`, and `maps.travelMinimap` for the minimap) default to off. The
flight timer and the instance tracker are set under Quality of Life.

- Unexplored areas (`maps.reveal`: `off` | `on` | `tint`, `Maps/Reveal.lua`):
  textures on one frame of Polestar's on each map frame's canvas (the world
  map, and the battlefield map once Blizzard loads it), watched through
  MapCanvas (Nav) once the setting is first on, faded with the map's global
  alpha (the battlefield map's opacity).
  `ZoneArt.FullOverlays` returns the overlay table only when it was built for
  the art the client shows (art ID and tile size). `Maps.UnexploredOverlays`
  subtracts the client's explored list (`GetExploredMapTextures`, matched on
  offset and size, since it returns no overlay IDs). An explored overlay is
  always left to Blizzard, so `isShownByMouseOver` overlays stay hover-only.
  The tiles are split by `ZoneArt.EachOverlayTile`, as
  `MapExplorationDataProvider` splits them, onto one frame at the exploration
  pin frame level. `tint` multiplies them by the Theme token `mapUnexplored`.
  The tiles are painted again as the map opens or changes, on
  `MAP_EXPLORATION_UPDATED` and on theme changes.
- Coordinates: the world map's info bar shows the player and the cursor
  (`maps.coords`, `Maps/WorldMap.lua`). `maps.minimapCoords` adds a readout at
  the bottom of the minimap (`Maps/Coords.lua`, 5 Hz, repainted only when the
  tenth changes). Both use `Maps.FormatCoords`.
- Minimap button (`maps.minimapButton`, off by default; `Maps/MinimapButton.lua`):
  click fires `TOGGLE_FRAME`, right-click `SHOW_OPTIONS`, a drag moves it
  around the minimap's edge and saves `maps.minimapButtonAngle` (degrees, 0 =
  east). A square minimap (`GetMinimapShape`) puts it on the square's edge,
  and a resized one (`OnSizeChanged`) moves it to the new edge.
  No frame exists until the setting is first turned on.
- Zone level ranges (`maps.zoneLevels`): labels on continent maps, and the
  hovered zone's range in the info bar. The ranges come from `maps build`
  (`tools/lib/maps/zonelevels.js`). Forever-only zones (maps with Forever
  frames and no Era frames in `map-frames.json`) are held to the sparse
  thresholds, because every source records them thinly.
- Dungeon entrances (`maps.dungeonPins`, `Maps/Dungeons.lua`): a Pins layer
  `maps.dungeons` built from the Codex pack's instances, since `dungeons.json`
  isn't licence-clean and the core ships no entrances. The Codex is loaded the
  first time the world map opens with the setting on, or the layer is built
  on `CODEX_LOADED`. A click opens the dungeon's page in the hub
  (`Polestar.Dungeons.Open(key)`); with the Dungeons module off, or on
  Shift-click, it sets a Nav waypoint.

## QoL — quality-of-life helpers

### Quest reward marks — QoL, reads Gear

One system marks the client's reward choices: `QoL/Rewards.lua`. Gear only
judges items (`Gear.IsUpgrade(link) -> upgrade, delta, pct`) and ranks
choices for the guide's own reward pick (`Gear.RankChoices`, used by
`Gear/Picks.lua`); it draws nothing on the reward panel.

```lua
Polestar.QoL.Rewards.ReadChoices(fromLog) -> { { index, link, itemID, count, value, upgrade, delta } }, complete
Polestar.QoL.Rewards.Rank(choices) -> { index, ... } (best first), "upgrade" | "value"
Polestar.QoL.Rewards.Mark() -> true | false | nil   -- draw the marks; whether the best was marked (nil: no best)
Polestar.QoL.Rewards.best, .reason                -- auto-pick's settled answer on QUEST_COMPLETE
```

- **Best** = the largest Gear upgrade (delta > 0, Gear enabled); with none,
  the highest vendor value (sell price × stack). Auto-pick
  (`qol.rewardAutoPick`, Shift suppresses, never when the quest costs money)
  takes it; the marks frame it.
- **Marks** (`qol.rewardHighlight`), on each `type == "choice"` button of
  `QuestInfoFrame.rewardsFrame.RewardButtons`, anchored to its `Icon`:
  `qol-upgrade` (success) on every upgrade in the icon's top-left corner,
  `qol-coin` (accent) in its top-right corner on the most valuable of two or
  more choices (every price known; ties all), a 2px accent frame with a shade keyline around
  the best of two or more. Drawn after `QuestInfo_Display` (detail, reward and
  quest-log pages), and redrawn on `GET_ITEM_INFO_RECEIVED`, `GEAR_UPDATED`
  and the setting; cleared on `QUEST_FINISHED`. An uncached choice is judged
  from its item ID; the best waits for complete data (or auto-pick's answer).
- **Tooltips**: the client's `SetQuestItem` / `SetQuestLogItem` run the item
  post-calls, so Gear's comparison line ("+12% upgrade · Head") shows on a
  hovered choice through `Polestar.Hooks`. Gear's "Best pick" line
  (`gear.pickTooltip`) appears only when its pick is an upgrade, so it never
  contradicts the coin. `gear.rewards` is the guide window's pick line only.

## Lookup — Codex, sources, generated guides, mount spotting

`addon/Polestar/Lookup/` (`Lookup.xml`: Codex, Sources, Guide, Spotter,
Options). Everything is off with `lookup.enabled`; `lookup.tooltip`,
`lookup.altClick` and `lookup.mounts` switch the parts (Discovery → Lookup).

```lua
Polestar.Codex.Load() / IsLoaded() / Meta()       -- the local Polestar_Codex pack through Data.Pack; CODEX_LOADED(meta)
Polestar.Codex.Item(id) / Npc(id) / Object(id) / Quest(id) / Instance(key) / Zone(id) / Faction(id) / Spell(spellId)
Polestar.Codex.Name(kind, id) ; Codex.WithRole(role) ; Codex.Loot(kind, id) ; Codex.Each(kind, fn(id, name, quality, status))

Polestar.Lookup.Sources(kind, id) -> rows, entity     -- ranked for this character
   -- row = { type, src, label, detail, zone, map, x, y, f, travel, effort, cost, available, why, whyText,
   --         chance, price, standing, guideable }
Polestar.Lookup.CuratedGuide(kind, id) -> guideId | nil
Polestar.Lookup.BuildGuide(kind, id, ranked) -> def | nil, reason
Polestar.Lookup.Guide(kind, id, index) -> guideId | nil, reason
Polestar.Lookup.UnitMount(unit) -> { spell, item, name, icon, class } | nil
Polestar.Lookup.Show(query, kind, id)                 -- SHOW_LOOKUP(query, kind, id) for UI/Lookup.lua
Polestar.Lookup.RegisterPlanner(kind, build)          -- build(id) -> { title, steps, ... } | nil, reason: another module's guide kind
Polestar.Lookup.QuestChain(questId, player) -> { quest, ... }, truncated  -- open prerequisites first, the quest last
Polestar.Lookup.QuestStep(quest, from) -> step         -- accept, objectives, turn-in
```

- **Codex records** use the field names of `data/forever/codex/*.json` (see
  Toolchain, "Codex"); the pack holds one compact string per record plus an
  id → name table per group, so search never decodes records, and decoded
  records are cached weakly.
- **Ranking.** A row is unavailable (kept, dimmed, `why` = `faction`, `race`,
  `class`, `level`, `profession`, `reputation`, `done` or `retired`) when the character
  cannot use it now; available rows come first, then by `cost` = travel
  (`ns.TravelCost` from the player to the nearest spawn, giver or dungeon
  entrance; Nav's planner when present) + effort (expected kills from the drop
  chance and the mob's level, a dungeon run per boss kill, a rare's respawn,
  quest objectives and prerequisites, reagents and missing skill, hours for
  reputation and PvP). Race and class masks are Era masks: a race without a
  bit is never excluded.
- **Obtainability.** An item's `status` is `retired` (no longer obtainable:
  shown for reference, its rows unavailable, never guided; its tooltip says so)
  or `nosource`. Search ranks, within a kind, items a curated guide `collects`
  first, then the rest, then retired and source-less ones, each by name match;
  results carry `status` and `curated`, and the UI shows a muted chip and no
  "Guide me" for the unobtainable.
- **Guides.** `Lookup.Guide` opens the curated guide whose `collects` holds the
  item (for a class mount's spell, a guide with the spell's name among its
  `keywords`). Otherwise `BuildGuide` writes the same guide table compiled
  guides use from the chosen source: vendor (goto, buy), drop (goto, kill,
  collect; a dungeon's entrance first), object (goto, interact, collect),
  quest reward (every blocking prerequisite, one of the any-of ones, then
  accept, objectives and turn-in, each with coordinates), craft (train, skill,
  learn, craft at the profession's trainer), reputation (rep, then buy from
  the quartermaster). It is registered in pack `lookup`, category `Lookup`, id
  `lookup/<kind>/<id>`, never saved, and opened in a new tab
  (`Engine.OpenTab`); a saved tab holding one is rebuilt at `ADDON_LOADED`.
  A planner kind (`RegisterPlanner`, letters only; Dungeons' `pickup`, `handin` and `attune`) is
  built by its module's `build(id)` through the same `BuildGuide`/`Guide`
  path (no curated guide, not gated by `lookup.enabled`), registered and
  reopened the same way.
- **Tooltips and clicks.** Item tooltips get the best one or two sources and
  "Alt-click: guide me"; Alt-clicking an item link, bag item or loot item opens
  its guide (Lookup when no source can be guided). The Codex loads
  on the first tooltip that needs it out of combat.
- **Mounts.** `Lookup.UnitMount` reads a player unit's helpful auras with
  `C_UnitAuras.GetAuraDataByIndex` (in `pcall`: `RequiresUnitAuraAccess`; any
  secret value stops the scan, as `SecretWhenUnitAuraRestricted` makes them in
  combat, encounters and PvP matches) and matches the spell against the
  Codex's mount spells (the client's `ItemEffect`: aura spell → item, class
  mounts with their class), else `C_MountJournal.GetMountFromSpell`. The unit
  tooltip gets "Mount: <name>" and its best source; `MOUNT_SPOTTED(unit, info)`
  fires on target change and mouseover; `/polestar mount` opens Lookup at the
  target's (else the mouseover's) mount, `/polestar lookup [text]` searches.

## Dungeons — dungeon quest journal, pick-up and hand-in guides

The dungeon pages come from the Codex's instances (Toolchain, "Codex"): in a
release build the Forever client's tables and `data/forever/*.json`; with
`--local-extras` also `dungeons.json` (DungeonJournal).

The Dungeons section of the hub reads them through the Codex: `codex build` always runs
`tools/lib/codex/journal.js`, which writes one page per Codex instance into the
pack as `Dungeons1.lua` (a summary table per dungeon for the list, and the page
as Lua source compiled only when opened): the quests QuestieDB files under the
instance's areas (the areas on the instance's map and the outdoor areas of its
name, as the solo filter's instance classification reads them,
`tools/lib/sim/solo.js`), whose objectives or starting item point into it,
that Wowhead Forever's dungeon and raid quest lists place in it (`quests.json`'s
`wowhead.zone`, counted only when QuestieDB's Forever store has the quest,
which keeps out `<UNUSED>`, `<NYI>` and retired quests), whose start item drops
or lies inside one instance (that page too, even when the quest has an area),
or that end its story (a follow-up with the same title, no objectives, taken
where the quest ends: Hidden Enemies, The Lord of Blackrock); plus, with
`--local-extras`, `dungeons.json`'s. An objective item that is sold, crafted,
or dropped or held outside every instance ties no quest to a dungeon (the
false-positive rule: Murloc Poachers, Craftsman's Writs), nor does a stray
drop, one only Wowhead's lists record and under 5% (The Ectoplasmic
Distiller's Greater Eternal Essence from Gri'lek and Maexxna); a quest of a
game event (pfQuest's `event`: the Darkmoon Faire, the holidays, the war
efforts) is on a page only where QuestieDB or Wowhead files it (Copper
Modulator, Rinling's Faire turn-in, is on none). What no rule can catch is
in the cited table `tools/lib/codex/journal-quests.json` (Shards of the
Felvine). Each quest has giver and ender and their positions, its objective
facts (`objectives`: kind, NPC, item or object id, count and the English
name; the escorts' and events' text), composed at run time into our own
objective line in the client's language (`Dungeons.ObjectiveText`:
`L["Kill %d %s"]`, `L["Collect %d %s"]`, `L["Use %s"]` with the names from
`Polestar.Names`; an event's line is the quest's own objective summary from
the names pack, kind `objective`), chain (every prerequisite and breadcrumb of the quest's side,
all of `pre` and `preAny`, oldest first, at most 20), rewards (items with
quality, count and choice from recordings and ForeverLevelingBiS, else
Wowhead's list rewards, choice versus fixed as Wowhead files them; XP from
`quests.json`; money, else Wowhead's; reputation from Wowhead's rewards, its
"+1" placeholders left out, never the standing a quest asks for) and, with
`--local-extras`, DungeonJournal's audited shareability; bosses in kill order
with the quests tied to them (an encounter's boss carries its DungeonEncounter
id, `encounter`, for its name in every language); entrances from the Codex, else the client's Map
table (the corpse point, placed on its zone); and the page's `attunement`
list (below). No loot tables. The page also carries the instance's Map id
(`map`): the list shows the dungeon's name in the client's language
(`Names.Instance`) and its zone's (`C_Map`); attunement notes are our prose,
read through `L[note]` (`i18n keys` lists them from
`tools/lib/codex/attunements.json`). `codex attune` writes the local comparison with
the Attune addon (`tools/lib/codex/questaudit.js`,
`tools/lib/consume/attune.js`; `data/local/dungeon-quests-audit.md` and
`.json`, then the attunements report). Runtime: `addon/Polestar/Dungeons/Dungeons.lua`
(`Polestar.Dungeons`: List, Get, Entrance, Quests, Quest, ObjectiveText, Bosses, Open,
GuideTo, GuideToPoint, ShowOnMap; `SHOW_DUNGEON`). `dungeons build` writes no
guides.

The pick-up guide is built in game (`addon/Polestar/Dungeons/Pickup.lua`):
`Dungeons.PickupPlan(key)` takes the page's quests that apply to the character
(faction, race and class masks through `Lookup.QuestBlock`, the page's class
list), not done, not in the log (those are `carried`), open by
max(level, the dungeon's lowest level), picked up outside from an NPC or object
(not from an item, not inside), and not a follow-up of another quest of the
page; each with its open prerequisites (`Lookup.QuestChain`: all of `pre`, one
of `preAny` this character can take, in the order they are done). The giver
is `Dungeons.Giver(pq, from)`: the page keeps one (the Codex's first), so a
quest several NPCs give goes to the one of the character's side nearest the
player (`Lookup.QuestEnd`, which takes an NPC of the other side only when no
other is known and marks it `hostile`; Tabetha's Task: the mage trainers of
both sides), never to one of the other side; the quest card and the map's
giver markers show the same giver.
`Dungeons.PickupGuide(key)` orders them as the cheapest path by
`ns.TravelCost` from where the player stands, through every stop, to the
entrance (`Dungeons.PlanStops(stops, from, finish, travel) -> order, cost`:
an exact search over the stops done and the last one, up to 12 stops; above
that nearest-next, then single stops moved while the path gets shorter). A
nearest-next walk with the entrance only appended left a city and came back
to it (Thunder Bluff, Orgrimmar, the Undercity, back to Orgrimmar for
Ragefire Chasm); the planned path goes Thunder Bluff, the Undercity,
Orgrimmar and in. Stops: each prerequisite once, after the one before it in
its chain (a full quest step, `Lookup.QuestStep`, from its giver nearest the
player; the player then stands at its turn-in), and a giver once per set of
prerequisites its quests wait on (one step with an accept per quest; the
giver comes up again for a quest still waiting, and visits to the same giver
in a row are one step). The last step lists the carried quests as notes,
goes to the entrance and says where the hand-in guide is (a note naming
`/polestar dungeons <name>`). Nothing to take: nil, "nothing". The route is
kept per character (`CharState().dungeonPickup[key]`, the stop keys in
order) and used when the guide is rebuilt without a position
(`Dungeons.OrderStops(stops, from, finish, field, key)`, shared with the
hand-in guide). It is a Lookup planner kind
(`Lookup.RegisterPlanner("pickup", build)`): `Dungeons.PickUp(key)` ->
`Lookup.Guide("pickup", key)` registers it as `lookup/pickup/<key>` (pack
"lookup") and opens it in a new tab, and a saved tab of it is rebuilt at
ADDON_LOADED like Lookup's own; it is gated by `dungeons.enabled`, not
`lookup.enabled`.

The hand-in guide is the run's other half (`addon/Polestar/Dungeons/Handin.lua`,
planner kind `handin`, `lookup/handin/<key>`, `Dungeons.HandIn(key)`).
`Dungeons.HandinPlan(key)` sorts the page's quests in the log: `hand`
(objectives done, by `Compat.IsQuestReadyForTurnIn`, or a delivery with no
objectives; turned in outside at the page's ender, else the Codex ender
nearest the player), `unfinished`, `inside` (turned in inside the dungeon)
and `unplaced`; it searches no follow-ups, so the page can ask for it on
every render. `Dungeons.HandinFollowUps(plan)` adds the quests the `hand`
quests open (`Codex.FollowUps(id)`: the quests whose `pre` or `preAny` name
it, one scan of the quest records per id, kept until the quest chunks
change): every `pre` done or handed in here and one of `preAny` likewise,
takeable now (`Lookup.QuestBlock`: faction, race, class, level), not done or
in the log, from the NPC or object a quest it waits on is turned in to or
one within 60 seconds of it (`ns.TravelCost`). `Dungeons.HandinGuide(key)`
makes a stop per turn-in place (its turn-ins, then the follow-ups that same
NPC gives) and per other follow-up giver (after the turn-ins it waits on),
ordered by `Dungeons.OrderStops` with no fixed end (`CharState().dungeonHandin[key]`);
the last step lists the rest as notes ("Not finished yet: …", "Turned in
inside the dungeon: …"). Nothing routable: nil, "nothing", and
`Dungeons.HandinText(plan)` says why in one line. `Dungeons.HandIn` puts the
guide in the tab of the dungeon's pick-up guide when that one is finished or
at its last step (its job ends at the entrance), else in a new tab. A
finished pick-up guide's "Guide complete" panel (UI/GuideFrame.lua) offers
"Hand in the quests" while the dungeon has quests in the log.

Attunements and keys (`addon/Polestar/Dungeons/Attune.lua`, planner kind
`attune`, `lookup/attune/<key>:<id>`). A page's `attunement` list (Codex,
"Dungeons and raids": `tools/lib/codex/attunements.js`) is read by
`Dungeons.Attunements(key, faction)` (faction "A" | "H" | nil: the entries
of that side and the side-free ones). `Dungeons.AttunementState(a)` gives
this character's state per step: a quest `done`, `ready`, `log`, `open`,
`locked` (a step it waits on, `after` all, `afterAny` one, is not done),
`level`, `rep` (the quest's standing, `Compat.GetFactionStanding`), `na`
(faction, race or class through `Lookup.QuestBlock`) or `skip` (an
alternative not taken: of `any` goals the one whose standing fits best, the
highest first; a `preAny` sibling of a done one); a drop, chest or gift is
`done` once its item is owned (`Compat.GetItemCount(id, true)`, the bank
included) or the quest it starts is taken; a standing once reached. The
attunement is `done` when its item is owned (a key, the Drakefire Amulet,
Aqual Quintessence) or, item-less, when its goals are done (one of them with
`any`); `goalDone` with no item says the key was lost. `Dungeons.AttuneGuide(key, id)`
makes a stop per quest still to do (`Lookup.QuestStep`, with any open
prerequisite `Lookup.QuestChain` finds that the list lacks), each after the
stops it waits on, ordered by `Dungeons.OrderStops` from where the player
stands with no fixed end (`CharState().dungeonAttune["<key>:<id>"]`). Each
quest step is whole (accept, objectives, turn-in): `Lookup.QuestStep`'s
`opts.inside` places a giver, target, chest or turn-in without a spawn at
the entrance of the instance it is in (the Codex NPC's `instance`, else the
attunement's `inside` from the cited table) and the step's note says what is
inside where; without it such a quest would be a lone "First do the quest"
note, which the Engine passes as done. An accept above the character's
level stays, the Engine's detail adding "from level N". A drop
or chest is a collect step at its NPC or object (inside an instance: at its
entrance, with a note naming it), a standing a rep step, a gift a talk step,
each after the quest before it in the list; the last step holds the note and
the entrance. Nothing left: nil, "done"; the other side's attunement: nil,
"nothing". `Dungeons.Attune(key, id)` opens it in a new tab.

## UI — guide window, hub and options

### Options registry

Any module adds settings to the options window without touching UI files:

```lua
Polestar.RegisterOptions({
  page = "Quests", icon = "icon-accept", order = 30,      -- sidebar page (created on first use), its title as shown
  key = "quests",                                           -- optional: the page's stable key (default: made from page)
  tab = "Map", section = "Markers",                         -- tab row entry and section header
  controls = {
    { kind = "toggle",   key = "qol.mapObjectives", label = "Objective markers", help = "One line." },
    { kind = "slider",   key = "qol.markerScale", label = "Marker size", min = 0.5, max = 2, step = 0.05, format = "%.2f\195\151", -- example key
      release = true },                                                 -- optional: write when the drag ends
    { kind = "dropdown", key = "gear.spec", label = "Weights", choices = { { value = "auto", label = "Automatic" }, ... } }, -- example key (the real one is gear.spec.<CLASS>)
      -- choices may be a function (choices that come and go); get()/set(v) may stand in for the path
    { kind = "color",    key = "qol.markerColor", label = "Marker colour", -- example key
      shown = function() return r, g, b end, source = function() return "Scheme" end, linked = { "other.key" } }, -- example key
      -- shown: the colour in effect while the key holds none; source: where it comes from;
      -- linked: paths a cancelled pick restores too. Right-click resets (sliders too).
    { kind = "button",   label = "Reset lockouts", help = "One line.", onClick = function() end },
    { kind = "binding",  action = "POLESTAR_NEXT", label = "Next step", help = "One line." }, -- a key binding row (UI/GamepadGuide.lua)
  },
})
```

Controls read and write `Polestar.Get/Set`; `disabled = function() return bool end` is optional;
registered labels and help are searchable. Pages sort by `order`; Recorder and
About always close the list. A page or tab with no available control is left
out of the sidebar and tab row. Every row resets to its default on right-click.

The built-in pages are grouped by what the player is doing: **Guide** (10:
Window, Arrow & routes, Automation), **Appearance** (20: Colour & type,
Windows, Arrow), **Map** (30), **Questing** (40: Quests, Rewards & gear,
Talents, Buttons), **Discovery** (50: Lookup, Dungeons, Rares), **Quality of Life** (60:
Travel, Social, Vendors, Trackers), **Community guides** (70, a custom page:
`UI/Packs.lua`), **Gamepad** (75, registered by `UI/GamepadGuide.lua`:
Navigation, Key bindings), Recorder, About. The options window
declares every tab and section of the module-filled pages, in order, and the
modules register their controls into them by name (`page = L["Questing"]`,
`tab = L["Rewards & gear"]`, `section = L["Gear advice"]`): Quests, QoL,
Gear and Talents fill Questing; Lookup, Dungeons and Rares fill Discovery; QoL and Maps
(flight timer, instances) fill Quality of Life. On the **Map** page (Guide &
quests: Guide, Quest markers; Rares & travel: Rares and treasures, Dungeons and
travel; Zones: Zones, Coordinates) Nav, Quests, Rares and Maps place every map
and minimap setting.

A page is opened by its key (`/polestar options <key>`, `UI.ShowOptions(key)`,
`Options.Select`), not its title: the built-in pages give English keys
(`guide`, `appearance`, `map`, `questing`, `discovery`, `qualityoflife`,
`guidepacks`, `recorder`, `about`) so a translated title does not move them;
a registered page without `key` takes one made from its title. Old page keys
(`guidewindow`, `navigation`, `automation`, `quests`, `gear`, `lookup`,
`dungeons`, `rares`, …) reach the page and tab that now hold their settings
(`ALIASES` in UI/Options.lua); a page's own key wins over an alias.

The sidebar's page list is its own scroll area (`f.NavScroll`, `W.ShellNav`)
from 12px under the search to the footer bar's line, so the version and stage
chip below it are never crowded, whatever the page count, font or menu scale;
the selected row is scrolled into view. The hub shares it. Its items are
`{ key, label, icon, count, dot }`: `dot` puts a warning dot at the row's
right edge instead of the count (a page spec's `dot = function() end`, the
Community guides page while a pack has problems), and `{ heading = true, label }`
is a muted heading over the rows after it, not a choice (the menu's "Community
guides").

The settings window is a rail shell like the hub (`W.Shell` with `rail`): it
shows the hub's sections (`UI.Picker.RailItems()`) with Options marked, and a
section reopens the hub there. Switching between the two places the window
being opened at the other's top-left corner (`UI.Picker.TakePlace`), so the
rail does not move.

### Guide window, guide menu and zone art

Reading flow: `docs/DESIGN.md` ("Intent" and "The Guide Window").

- **Guide window** (`UI/GuideFrame.lua`): tab strip, a slim navigator (prev,
  step number, next, Skip, the bug that opens the report window, menu), one
  focus block from the step view's `groups`/`focus` (the person to talk to
  now with only their goals, or a field step's objectives), counters right
  after the goal text (in text, success once complete; the accent is kept
  for the current goal's glyph, the arrow's target mark, tabs, primary
  buttons and the progress fill), a "Then: <next
  person>" line with "Person n of N", tips folded to one line, and the guide's
  progress bar with percent. Up next is off by default (`ui.upcoming = 0`).
  Transparent mode fades the whole navigator (step number with its chevrons)
  until hovered and keeps the progress track as a faint ink line.
- **Hub** (`UI/Picker.lua`, `UI.ShowPicker(opts)`; the window the guide menu
  grew into, `docs/SUITE.md` "UI"). A section rail (`W.Shell` with
  `rail = true`, `W.ShellRail`) at the window's left: the emblem, then one
  button per section from the 160 line (glyph over label, 56px rows; eight fit
  at 680 tall), Options at its foot. The sidebar holds the wordmark, the hub
  search and the active section's index (`W.ShellNav`). Guides is the built-in
  section; every other module registers:

  ```lua
  UI.RegisterSection({
    key = "Dungeons", label = L["Dungeons"], icon = "icon-dungeon", order = 30,
    build = function(parent, hub) end,  -- once; parent spans the list and details panes
    render = function() end,            -- every hub render while shown (W.ShellTitle/W.ShellTabs on hub)
    nav = function() return items, activeKey end, -- its index in the sidebar ({ key, label, icon, count })
    onNav = function(key) end,           -- set the state, then UI.Picker.Render()
    search = function(text) end, enter = function() end, step = function(delta) end, -- optional
    searchPlaceholder = "...",           -- optional; or a list of wordings, longest first: the first that fits the box shows
  })
  ```

  `UI.Picker.ShowSection(key)` shows one ("Guides" returns to the guide
  list), `P.Section()` names it, `P.Query()` is the search text. A section's
  top-level divisions go in `nav`, not in a tab row; `W.ShellTabs` on the hub
  is for views inside one division, and the section's frame starts under it.
- **Guide menu** (the Guides section): three panes. Left: the categories with
  counts. Middle: Home (continue and suggested), Browse, Current (open tabs),
  Recent tabs over one line per guide,
  `Title (min–max)`, in folders (a guide's `folder` when set, else leveling by
  faction and band, other guides by category); search also matches `folder`
  and `keywords`. The faction filter (`ui.pickerFaction`, default this
  character's) on the player's own faction lists only the guides this
  character can follow (`Guides.GuideMatches`: no other race's or class's
  guides); the other faction and All list every guide. Right: the
  selected guide's zone art, facts (led by a guide's `reward` tiles and
  `why`, "Guide data"), progress, pitch, pros and cons, a favourite
  star, "Load guide" and "Open in new tab". Selecting never loads; the buttons,
  a double-click or Enter do.
  Its search also lists Codex matches under the guides (`UI.LookupRows`,
  `UI.LookupCount`, `UI.LookupTotal` from `UI/Lookup.lua`): an "In the
  Codex" folder with up to three per kind and a "Look up everything" line;
  picking one opens the Lookup section at it.
- **Lookup** (`UI/Lookup.lua`, the hub section "Lookup", order 20;
  `UI.ShowLookup({ query, kind, id })` and `SHOW_LOOKUP(query, kind, id)` open
  the hub at it). Search only, never browsing: the hub's search box drives it
  (`Search.Query`, run when typing pauses for 0.15 s; the section's `search`,
  `enter`, `step` hooks); an empty search lists the recent lookups
  (`CharState().ui.recentLookups`, newest first, at most 10, kept when the
  player opens a page) and a hint. Sidebar (its `nav`): Everything and the
  kinds the search found, with counts; a kind filters the results only.
  Left: the results grouped by kind (five per kind under Everything with a
  "Show all" line; under one kind pages of 50, `opts.offset` for "Show more"),
  one line each (item icon or kind glyph in the gutter, the name in its
  quality colour lifted to 4.5:1 or its subject colour, a muted "No longer
  obtainable" / "No known source" chip for `status`, the subtitle right);
  only the rows in view are drawn, and only they get a subtitle
  (`Search.Subtitle`). Lookup has no tabs, so no tab row: it comes back only
  to say why the Codex is not there to search ("Loading the Codex…"
  re-queries on `CODEX_LOADED`); Enter is named in each row's tooltip. Right: the selection
  on a band (the zone art of its best located source), facts, the ranked
  sources of `Lookup.Sources` (asked once per selection; label, detail,
  travel, chance / price / standing; ones this character cannot use dimmed
  with `whyText`), a "Guide" button on the selected source, and pinned
  "Guide me" ("Open guide" when `Lookup.CuratedGuide` has one) calling
  `Lookup.Guide`; nothing guides to an unobtainable entity. Guide results
  open in a new tab or among the guides; dungeons also open under Dungeons
  ("Open dungeon", `Dungeons.Open(key)`). Without the Codex pack
  (`Search.Status`) it says what is missing and still searches guides.
  Up/Down walk the results, Enter acts, Escape closes the hub.
- **Dungeons** (`UI/Dungeons.lua`, the hub section "Dungeons", order 30;
  `SHOW_DUNGEON(key)` from `Polestar.Dungeons.Open(key)` opens the hub at a
  page, nil at Home). A dungeon quest journal: dungeons grouped by level, a
  page per dungeon (`docs/DESIGN.md`, "Intent"). Sidebar (`nav`): For your
  level, All dungeons, 10–20 … 50–60, Raids, with counts; the faction filter
  (`CharState().ui.dungeonsFaction`, default this character's) as segments at
  the right of the tab row. Home: two cards per line in level order, the zone
  painting centred on the entrance (`List()` carries it; Home never decodes a
  page), name, levels, zone, quests for the filter, Forever and Your level
  chips; only the cards in view get their painting, the rest as they scroll
  in. The hub search filters the cards by name; Enter opens the first. A page:
  the painting in the header band with the title drawn on it (the hub's own
  Title, Subtitle and Band are faded/hidden while a page shows and restored
  on Home and when the section hides), a back chevron and the actions, right
  to left from the band's corner with the primary first, three at most (by
  priority; "Show on map" gives way first). The primary is "Hand in the
  quests" while `Dungeons.HandinPlan` holds a finished quest (`DS.HandIn` ->
  `Dungeons.HandIn`; the tooltip counts them and names what is not finished),
  then "Pick up the quests" while `Dungeons.PickupPlan` holds quests to take
  (`DS.PickUp` -> `Dungeons.PickUp`: the guide opens in a new tab and the hub
  steps aside; the tooltip counts the quests and those in the log), else
  "Guide me to the entrance" (`Dungeons.GuideTo`). After the primary: the
  other of the two guides ("Hand in the quests" is shown while any of the
  page's quests is in the log; with none finished its tooltip and, clicked,
  chat say what is open, `Dungeons.HandinText`), "Guide me to the entrance"
  and "Show on map" (`Dungeons.ShowOnMap`); with nothing to pick up or hand
  in, "Nothing to pick up" (shown while the page has quests for this side)
  says why in its tooltip and, clicked, in chat (`DS.NothingText`); no guide
  is built. Tabs Quests n, Attunement (Keys when each is a key; only on pages
  with one for the filter's side), Bosses n, Map. Quests: a block per quest planned from the
  data (the objective measured on one shared string) so only the blocks in
  view are drawn (`DS.PaintQuests` on scroll): the title in the client's
  difficulty colour (`GetQuestDifficultyColor`, else `QuestDifficultyColors`
  by level gap) lifted to 4.5:1, the state from `Compat.IsQuestCompleted`,
  `IsOnQuest`, `IsQuestReadyForTurnIn` and the level, level, requirement,
  classes, picked up inside, shareable; Objective, Starts/Ends with pins
  (`Dungeons.GuideToPoint`); the Starts line (pin and text) is one link to
  `Dungeons.GiverTarget`: the giver of the first prerequisite still to do
  (its turn-in when that one is in the log), else the quest's giver, its
  tooltip saying which; the Chain (`Dungeons.Quest` per id, a pin each),
  Choose one / You get item tiles (quality border; hover `GameTooltip:
  SetHyperlink`, where Gear adds its upgrade line; modified clicks through
  `HandleModifiedItemClick`), XP, money and reputation chips. Bosses: kill
  order, name, level, each tied quest ("Kill it for", "Drops X for", "Drops X,
  which starts", "Part of"), a line opening the quest. Attunement
  (`Dungeons.Attunements`, `Dungeons.AttunementState`): per entry a head
  (state glyph, the name in quest or item colour, a chip: Done, "Not in your
  bags" for a key whose chain is done, "n of m done"; the facts: kind, who
  needs it, level, side; our note; the item tile with "You have it" or "Not
  in your bags or bank"; "Guide me through it" while something is left, which
  opens `Dungeons.Attune` in a new tab as the pick-up guide does) and a row per
  step of the filter's side (state glyph, the quest in its difficulty colour
  or what drops it, its state, giver and zone or chance and instance; a click
  sets the arrow there); the other side's entries carry no state. Map: the entrance and
  the quest givers on its zone painting. Blocks, rows, tiles, chips and cards
  are pooled; quest states refresh on QUEST_ACCEPTED, QUEST_REMOVED,
  QUEST_TURNED_IN and PLAYER_LEVEL_UP, the Attunement tab also on
  BAG_UPDATE_DELAYED and UPDATE_FACTION. `UI.DungeonsSection` exposes
  `Open`, `Home`, `SetBand`, `SetTab`, `SetFaction`, `ShowQuest`, `Attune`, `Shown`
  (`shown.attune`: per entry its id, done, chip, guide, owned and step states)
  for tests and the preview.
- **Zone art** (`UI/ZoneArt.lua`): `UI.ZoneArt.Create(parent, width, height
  [, fadeColor])` and `UI.ZoneArt.Paint(art, uiMapID, focusX, focusY, index) ->
  painted, reveal`. The zone's world map painting from the player's own
  client, drawn the way the world map draws it: the base layer
  (`C_Map.GetMapArtLayers` / `GetMapArtLayerTextures`, layer 1, tiles
  row-major), then every overlay over it, so the zone shows whole, without
  fog of war. The client only lists the overlays this character has explored
  (`C_MapExplorationInfo.GetExploredMapTextures`), so the full list is
  generated: `UI/ZoneArtOverlays.lua` (`maps overlays`, below) registers
  `ZoneArt.RegisterOverlays(build, { [uiMapArtID] = { tileWidth, tileHeight,
  { textureWidth, textureHeight, offsetX, offsetY, fileDataID, ... }, ... } })`.
  It is drawn only when `C_Map.GetMapArtID(uiMapID)` is the art it was built
  for (and the tile size matches); otherwise the explored overlays are
  (`reveal` "explored", "full" with the table). Overlays split into tiles,
  the last column and row cropped from a power-of-two file, exactly as
  `MapExplorationDataProvider` places them, at the same desaturation, above
  the base. The place (`focusX/Y`, live-frame percent) lands mid-band
  horizontally and vertically mid-way between the top shade and the bottom
  fade (`art.psFocusY`), where nothing covers it; near an edge the painting
  zooms in up to `ZA.REFRAME` times so the place can stay there, and it never
  shows past the painting's edges. Only the base and overlay tiles the band
  shows get a texture, from per-band pools. Used by the route choice cards
  and the menu; the night band stands in without the art.
- **Community guides in the menu.** Our categories (Leveling, Professions, …)
  list only our guides; All, Favourites, Current, Recent and search cover every
  shown guide. A "Community guides" heading in the sidebar (a `W.ShellNav` heading
  row), present only while a shown pack has guides, lists one entry per such
  pack (`pack:<id>`, "<title> · <author>"), its guides grouped as ours are.
  Pack guides carry their pack's title in rows and results; the details pane
  has a credits line for every guide ("By <author> · <pack title> <version> ·
  <licence>", plus the pack's `source`; ours "By Polestar"). The empty states
  name both Polestar Guides and community addons.
- **Community guides page** (`UI/Packs.lua`, Options order 70, `/polestar
  packs`): one row per `Guides.Packs()` record: title, credits, guide count,
  website as a `W.Link` (the address without its scheme; the click opens
  `UI.ShowCopy("<title> website", <address>)`), source, and a `W.Switch` (`Guides.SetPackShown`) or
  the status text ("turned off in the AddOns list" with **Enable and reload**,
  "not loaded[: <reason>]", "needs Polestar <v> or newer" (or "needs a newer
  Polestar"), "broken: registered
  no guides", "refused: <reason>"); with problems a warning chip, **Show**
  (the list) and **Copy report** (`P.Report`: pack, versions, client build,
  every problem). Then **Suggest guides from** (`behavior.suggestFrom`,
  `Guides.SuggestSources()`), what a community addon is, and "Read more:" with a
  `W.Link` to docs/GUIDE_PACKS.md opening `UI.ShowCopy("Community guides,
  explained", <address>)` (`ns.DocsURL()` with `GUIDE_PACKS.md` for
  `PACKS.md`: the TOC's `X-Website` + `/blob/HEAD/docs/GUIDE_PACKS.md`, else
  "docs/GUIDE_PACKS.md in Polestar's source"). While `Guides.ProblemCount() > 0` the page's sidebar row carries
  the warning dot (a page spec's `dot`). Nothing goes to chat.
- **Welcome** (`UI/Welcome.lua`, `SHOW_WELCOME`): centred, four pages under
  a starlit hero, with step dots, Skip, Back and Next in the footer: Hello,
  <name> (what Polestar does, then the guide window, the arrow and
  `/polestar guides`); Set up (quest automation, the guide at login, the
  colour scheme as cards that apply live); Route style (`nav.routeStyle`,
  the setting Options' Route style dropdown writes, as three cards, Fastest,
  Balanced with its Recommended tag and Roads, each saying what it does: a
  click sets it live and Nav/Walk.lua searches again, right-click or the
  gamepad's Y puts Balanced back, and the pick follows the setting however
  it changes; a line on what every style keeps you away from); Start (the guide
  `Guides.Suggest()` picks on its zone painting, with its level range and
  pitch; the beta note while `ns.routesBeta`; the Discord invite in a copy
  box; what community guides are; then Start guide, or Choose a guide without
  one, and Browse guides). Once
  per new character (`PolestarCharDB.welcomeSeen`: 0 for a character with no
  saved `PolestarCharDB` as Polestar loaded, `ns.IsNewCharacter()`; set seen
  silently for one with saved data and no flag), 2 s after login, never in
  combat, during a cinematic or over the route choice; a due welcome that never opened stays due
  for the next login, and one that opened is marked on the character as it
  opens (a /reload or logout with it up does not repeat it); one the intro
  cinematic closes comes back on its page when the cinematic ends. Set up and Route style are in it only while the account has not had its
  welcome (`PolestarDB.welcomeSeen`); the page set is fixed when a showing
  starts. Any close marks the account (and the character). About's "Show the
  welcome again" and `/polestar welcome` open it with every page.
- **Copy window** (`UI/Copy.lua`, frame `PolestarCopy`, `UI.ShowCopy(title,
  text)` or `SHOW_COPY`): a small window with the band, a title, a read-only
  `W.CopyBox` holding the text, selected and focused, and how to copy it; ✕
  and Escape close it. `/polestar where` uses it. `opts` (`UI.ShowCopy(title,
  text, opts)`): `icon` and `iconColor` put a mark before the title, `hint`
  replaces the line above the box; the Polestar Discord's invite
  (`UI.ShowDiscord`) comes with Discord's mark.
- **Reporting a problem** (`UI/Report.lua`, frame `PolestarReport`,
  `UI.ShowReport()` or `SHOW_REPORT`): the guide window's bug (in the
  navigator while a guide is open), its menu's "Report a problem" and
  `/polestar report` open it on the step on screen. The player types what
  went wrong (250 letters); the report box holds `UI.Report.Text(description,
  details)`: their words after "**What went wrong:**", then
  `UI.Report.Details()` in a code block, one fact a line, taken when the
  window opens: Polestar's version and stage, the client build and locale;
  race, class, level (XP %) and faction (never the name or realm); the guide
  (title, id, pack and version); "Step n of N: title", with "the guide is at
  step m" while another step is looked at, or "skipped"; each goal (the first
  six, then "... k more goals") as `[>]` the arrow's, `[x]` done, `[-]`
  skipped, `[n/a]` not for this character or `[ ]` open, its line and count,
  `quest`, `npc`, `item`, `object` ids, `map <id> @x,y` as a guide writes it
  (`live` unless in the Era frame) and `spot i of n` for the arrow's spawn
  spot; the arrow's target and distance (and "your own waypoint" with its
  position when the player set it); where the player stands (zone, subzone,
  `map <id> @x,y live`); "Routes:" with the route style (`nav.routeStyle`:
  `fastest`, `balanced` or `roads`, in English) and only the routing settings
  away from their defaults (`real paths off`, `travel planner off`, `handed
  to Shortest Path Forever`), after Where so the bug bot still finds Arrow and
  Where by position and reads this line by its style word; other packs that
  are on; and the errors
  (`Polestar.Errors()`, plus with !BugGrabber its errors this session in
  Polestar's files, `BugGrabber:GetDB()`) by their path from the AddOns
  folder, and the calls the game blocked (`Polestar.Blocked()`) as "blocked
  in <addon>: <function> (<time>)": the newest three of both together, by
  `seq` (!BugGrabber's count as the newest), each counted. Every line is cut
  at 100 bytes, so at its longest the report fits one Discord message (2000
  characters). Under it, Discord's mark, "Polestar on Discord" and "Get the
  invite", which opens the invite (`Polestar.DiscordURL`) in the copy
  window: the game opens no links for addons, so the report is the only text
  a member copies. What the player typed stays while the window is reopened
  on the same step. The hub's and the settings' sidebars carry the Discord's
  mark at the end of the version line (`UI.Report.SidebarLink(shell)`),
  which opens the invite like `/polestar discord` (`UI.ShowDiscord`,
  `SHOW_DISCORD`).
- **Per-character UI state** in `CharState().ui`: `recentGuides` (ids, newest
  first, at most 10), `favoriteGuides` (id -> true), `pickerSelected` (id).

### Journey panel

`UI/JourneyPanel.lua` (`UI.JourneyPanel`; adapted from Shortest Path
Forever's journey tracker with Cillian Berragan's permission) shows the
travel route's steps in the guide window, right under the focus they lead
to and above "Then:": a header ("Journey", the remaining time and distance,
a chevron; a click collapses it, `nav.journeyOpen`), "To <destination>"
(the target's label, in the place colour), then one row per leg from the
current one on (at most eight, then "3 more steps"): the leg's number in
the route, its glyph (by `leg.kind`, or `leg.step` for a walk's chokepoint:
lift, gate, bridge, cave, pass), its caption (`leg.label`; without one the
kind's words and where it ends, never "Unknown") and its time. Boats,
zeppelins, the tram and lifts add a line, "leaves in about 0:15 · ride 0:10"
("leaves in" once a ride timed the loop; "on board · 0:42" while riding).
A walk whose engine path enters the other faction's towns (`leg.hubs`) adds
"Hostile town: Southshore" (names joined by commas) in the warning colour.
The current row wears the accent glyph and the 2px selection bar; a click
on it opens the skip menu (`Nav.prompts.OpenMenu`).

Data: `Nav.GetRoute()` (legs, current index), `Nav.travel.Active()` (more
than one leg: a lone walk is the arrow's own distance and time, so the panel
stays away), `Nav.travel.Progress()` (a current walk's seconds and yards
left along its path; any other current leg, a flight, hearth or teleport,
counts its planned time down from when it became current, stamped on every
route event even while the window is closed), `leg.seconds`, `leg.yards` and
`ns.Transit.NextDeparture(kind, id, at, side)` asked at the time the route
reaches the dock; standing at the dock (60 yd), `Transit.NextArrival` too,
so a visit leaving within the boarding window shows its own wait rather than
the next loop. A departure line appears only where a departure is known.
Times are whole seconds rounded up, unreadable numbers count 0, and the
header adds up the rows. Steps are repainted on `ROUTE_CHANGED`,
`ROUTE_ADVANCED` and settings; a 1 s `C_Timer` ticker, running only while
the panel is on screen, changes the times alone (`SetFormattedText`), so the
window is laid out on a tick only when a departure line comes or goes.
`GuideFrame.Layout` places it (`JourneyPanel.Layout`
returns its height); never in compact mode. Off with `nav.journeySteps`
(Options, Arrow & routes, Routes, "Show the journey"); without Nav neither
setting exists. Non-secure frames only. Tests: `tests/ui-journey.test.js`;
render: `docs/preview/journey.svg`.

### Gamepad (`UI/Gamepad.lua`, `UI/GamepadGuide.lua`)

Ported from Ding! by Yendi (@moust4ki), GPL-3.0, and rebuilt on the Theme.
No Polestar window takes a button from the game while it is merely shown:
a window holds the gamepad only while it is the newest one open, out of
combat, with a gamepad active (the game's gamepad interface, or
`gamepad.withMouse` on with the keyboard and mouse) and `gamepad.navigate` on (focus mode needs
only a gamepad), through a frame that reads the buttons first
(`PolestarPadInput`, `OnGamePadButtonDown`), so neither the game's gamepad
interface nor another addon's overrides (Easy Controller, ConsolePort) go
before it; any other button goes on to the game. With the keyboard and
mouse interface, temporary override bindings (`SetOverrideBindingClick` on
the hidden buttons `PolestarPad<KEY>`) sit under the frame for a client where
the frame gets nothing. With Forever's gamepad interface on
(`Polestar.GamepadUI()`, see [Gamepad interface](#gamepad-interface)) none
is set: the game's own bindings on those buttons stay as its binding stack
left them, and the frame alone reads the window's buttons. Both are cleared
when the window closes. At `PLAYER_REGEN_DISABLED` (before the lockdown:
nothing is set in a fight) the window lets go first, then a binding row's
capture ends, each step in its own `pcall`, so an error in a row's callback
cannot leave the frame shown or a binding set for the fight; until
`PLAYER_REGEN_ENABLED` no window takes the gamepad, then the newest open one
takes it again. A button already down when a window takes the gamepad stays
the game's until released (`G.heldKeys`); a press that opened the window
stays Polestar's.

A window that shows by itself waits to be asked: the welcome at login (or
back after a fight or the route choice) and the route choice the engine
offers (`spec.unasked()`) take no button, unless a Polestar window held the
gamepad as they came. The focus binding (`POLESTAR_FOCUS`) gives the newest
waiting window the gamepad (`G.TakeWaiting`) before it starts focus mode,
and the waiting window's hint bar shows that binding's button when it has
one. Opened by the player (a binding, a chord, a click, A in another
window), every window takes the gamepad at once.

```lua
Polestar.Gamepad.Register(frame, spec)  -- navigation while `frame` is shown (the contract every window uses)
-- spec = { unasked = fn -> bool (this showing came by itself: wait for the focus binding),
--          rows = fn -> { widget, ... } (default G.Collect(frame): every shown, enabled, clickable
--          widget, the outermost one), initial = fn(rows) -> index, back = fn (B, Start; default Hide),
--          prevTab / nextTab = fn (LB / RB), reset = fn(w) -> handled (Y; default: a setting row's
--          right-click), x = fn(w) (X), activate = fn(w) -> handled (A; default w:Click()),
--          key = fn(key, w, isRepeat) -> handled, onFocus = fn(w),
--          close = button | false (where B's chip sits; default frame.Close),
--          actionLabel / xLabel / resetLabel = fn(w) -> text, backLabel, tabsLabel = text }
Polestar.Gamepad.IsActive() -> bool        -- Polestar.GamepadUI(); with the keyboard and mouse only with gamepad.withMouse on (off by default) and C_GamePad / GamePadEnable with a device plugged in
Polestar.Gamepad.Style() -> "xbox" | "playstation"  -- gamepad.glyphs, "auto" reads C_GamePad's labelStyle ("Shapes")
Polestar.Gamepad.ButtonName(button), KeyName(key) -> text   -- "A" / "Cross", "LT + A", "LB + D-pad up", "Ctrl + N"
Polestar.Gamepad.Glyph(parent[, name]) -> frame             -- frame:SetKeys(key or { button, ... }) -> width
Polestar.Gamepad.BindingKeys(action), ShownKeys(action[, pad]), KeyText(action), Bind(action, key), Unbind(action[, pad])
Polestar.Gamepad.WhoUses(action, key) -> { kind = "binding"|"addon"|"gamepad", name, action } | nil
Polestar.Gamepad.Capture(opts)                              -- a key, a button or a chord for a binding row
Polestar.Gamepad.StartFocus(), StopFocus(), ToggleFocus(), IsFocusing()   -- the guide window's focus mode
Polestar.Gamepad.TakeWaiting() -> bool                      -- the newest window waiting to be asked takes the gamepad
Polestar.Gamepad.HasWindow() -> bool                        -- a Polestar window holds the gamepad (for other gamepad addons)
```

- **Navigation.** Where widgets have places (a client; the test and preview
  stubs place none) the D-pad goes to the nearest widget that way (its
  distance plus twice how far it sits off the line), scrolling a list on at
  its edge; without, it walks `rows` in order. Left / right step a slider
  (`row.Slider`'s wheel handler) or a dropdown's choices instead. The D-pad
  repeats while held (0.4 s, then every 0.12 s). Until the player presses a
  button the focus follows `spec.initial` (a window fills its page after it
  shows); LB / RB start the new page on it again. Registered: the options
  (LB / RB: `Options.StepTab`, every page's tabs in order), the hub (LB / RB:
  `Picker.StepSection`, the rail's sections; X loads the focused guide), the
  shared menu (`PolestarMenu`, B closes it and the window under it has the
  gamepad back where it was), the welcome (LB / RB its pages), the route
  choice, the report and copy windows.
- **The look** (docs/DESIGN.md, "Gamepad"): one focus ring (`PolestarPadRing`,
  the focused widget's child: the hover wash under a 2px accent ring at 90%),
  one hint bar under the window holding the gamepad (`PolestarPadHints`, the
  panel skin, clamped to the screen, wrapping to the window's width, 300 at
  least) and one B chip left of its close button (`PolestarPadBadge`; the
  bar then leaves B out: each action shown once). The bar lists the D-pad,
  what A, X and Y do on the focused widget, LB / RB and B. `gamepad.hints`
  turns the bar and the chip off. Without a gamepad none of it exists.
- **Chips** (`G.Glyph`): a 20px circle per face button (Xbox's letter in
  Caption, PlayStation's shape: `pad-cross`, `pad-circle`, `pad-square`,
  `pad-triangle` in `Media/UI`) and D-pad direction (the chevrons), a capsule
  for the rest ("LB", "Ctrl"), "+" between the buttons of a combination; the
  chip wash, the name in text.
- **Focus mode** (`POLESTAR_FOCUS`, `TOGGLE_FOCUS`; a window waiting to be
  asked takes the gamepad first): `G.Open` of the guide
  window with its own spec: rows are its widgets (tabs, navigator, banner,
  person, goal lines, tip, up next), the first open goal first; A on a goal
  line aims the arrow (`rowClick`), or on the quest item's line (the item
  button `QoL.Buttons.item` shows the goal's `item`, or a `use` goal) is
  redirected to the secure binding `CLICK PolestarQuestItemButton`
  (`G.Redirect`, an override binding: not with the gamepad interface, where
  A clicks that line like any other); X runs the line's `OnEnter` (its
  tooltip) and again its `OnLeave`; LB / RB `Engine.Prev/Next`; Y sets
  `ui.compact` and ends the mode; B ends it; hiding the window or
  `GAMEPAD_COMBAT` ends it.
- **Bindings and chords.** Bindings.xml: `POLESTAR_TOGGLE`, `_NEXT`,
  `_PREV`, `_FOCUS`, `_MENU` (`TOGGLE_PICKER`), `_OPTIONS`
  (`TOGGLE_OPTIONS`), `_REPORT`, and the quest buttons' `CLICK` bindings;
  `Polestar.Bindings` runs them. Nothing is bound unasked. A chord
  (`"PADLSHOULDER+PADDUP"`) is Polestar's own, in
  `PolestarDB.gamepad.chords[action]` (account-wide, outside the settings,
  so "Reset all settings" keeps it), never bound: while chords exist and a
  gamepad is active, the driver reads their first buttons (`IsKeyDown`,
  the chords parsed once per `GAMEPAD_BINDINGS_CHANGED`) every 0.05 s, and
  every frame while one is held; then, out of combat, `PolestarPadChords`
  reads the gamepad first and keeps the second button from the game; any
  other button goes on. A chord does nothing in a fight (`chordsFree`, and
  `runChord` itself: its window could not take the gamepad, and the button
  reached the game as well), while a Polestar window holds the gamepad, a
  binding row waits, the chat has the keyboard or a game window the
  gamepad's focus (`GamepadMode.FrameControlsManager.focusedFrame`, the
  field read, never a call), nor with another shoulder or trigger held
  (LB + RB + Up is not RB + Up). With the gamepad interface, LB and RB are
  its targeting modifiers (held, the D-pad and face buttons pick, mark and
  assist; both held, the D-pad pages the bars and opens the quest tracker
  or the chat): `G.WhoUses` names any chord on them as the game's. The
  quest buttons' secure clicks take no chord: a combination is the game's,
  with a button it makes a modifier (`GamePadEmulateShift` / `Ctrl` /
  `Alt`). Polestar never changes the game's gamepad settings.
- **Binding rows**: the registry's `binding` control (`G.BindingRow`). A (a
  click) captures (`G.Capture`): a gamepad button on its release, two
  buttons as a chord, a keyboard key with its modifiers; B tapped cancels, B
  held a second binds B, Escape cancels, so do a fight and 20 s idle. A key
  someone else has (`G.WhoUses`: another binding or chord, another addon's
  override, Easy Controller's own chord read from its saved settings, the
  game's gamepad interface) is named in danger and bound by a second A within
  5 s. Y (right-click) unbinds what the row shows: the gamepad's keys while a
  gamepad is active, else the keyboard's.
- Messages: `GAMEPAD_BINDINGS_CHANGED`, `GAMEPAD_CHANGED(active)`
  (`GAME_PAD_CONNECTED` / `DISCONNECTED` / `ACTIVE_CHANGED`),
  `GAMEPAD_COMBAT` (the gamepad went back at `PLAYER_REGEN_DISABLED`).

## Rares — rare NPCs and treasures

`addon/Polestar/Rares/` (`Rares\Rares.xml`, loaded after `UI\UI.xml`):
`Rares.lua` (settings `rares.*`, history, the decision), `Detect.lua` (client
events), `Pins.lua` (map layers), `Toast.lua` (the alert), `Options.lua`
(Discovery → Rares: When a rare shows up, How rares are noticed, History; Map
→ Rares & travel → Rares and treasures), `View.lua` (the hub section).
Everything is off with `rares.enabled`; a detection path that is off has no
event registered.

```lua
Polestar.Rares.Decide(s, ctx) -> action, reason   -- pure; "alert" | "hold" | "record" | "skip"
Polestar.Rares.Sighting(s, where) -> action, reason -- decide, record, alert (RARE_SPOTTED)
Polestar.Rares.History() -> { [key] = { kind, id, name, level, t, first, n, map, x, y, src, alerted, dead } }
Polestar.Rares.Info(kind, id) -> { kind, id, name, level, levelMax, elite, instance, spawns, loot } | nil
Polestar.Rares.BuildPins(o) -> pins                 -- pure pin selection
Polestar.Rares.Show(kind, id)                       -- SHOW_RARES: the hub section at it
```

- **Detection** (APIs verified against `.ref/wow-ui-source-forever`, 1.60.1):
  vignettes (`VIGNETTE_MINIMAP_UPDATED`, `VIGNETTES_UPDATED`,
  `C_VignetteInfo.GetVignetteInfo` / `GetVignettePosition`; Forever's world
  map adds `VignetteDataProvider`): a creature behind a vignette is a rare, a
  game object a treasure, with its exact position; nameplates
  (`NAME_PLATE_UNIT_ADDED` + `UnitClassification` "rare" | "rareelite"),
  target (`PLAYER_TARGET_CHANGED`) and mouseover (`UPDATE_MOUSEOVER_UNIT`).
  A unit counts when the client calls it rare or the Codex (if loaded) knows
  its NPC as one. Secret values read as unknown. Event payloads only: a GUID
  is looked at once per 3 s, the full vignette scan runs at most every 2 s
  and never in combat. Nothing is detected inside instances.
- **The decision**: off, instance, path off, players and pets, not a rare →
  skip; muted (`rares.ignored`) → skip; dead, alerts off, treasure alerts
  off, or alerted within `rares.cooldown` minutes → recorded only; in combat
  without `rares.combatAlerts` → held until `PLAYER_REGEN_ENABLED` (dropped
  after a minute); else the alert (`RARE_SPOTTED(alert)`, sound
  `rares.soundKit` when `rares.sound`).
- **History**: account-wide per realm, `PolestarDB.rares.history[realm][key]`
  (`"rare:<npc>"`, `"treasure:<object>"`, `"name:<name>"` without an id), at
  most 400 entries; the cooldown reads `alerted` (epoch seconds), so it
  survives a reload. Losing it only resets cooldowns and the Seen list.
- **Toast** (`PolestarRareToast`): name, "Level n Rare · 85 yd · Zone"
  (vignettes: the distance; units: "in sight"; a vignette without a position:
  "known spawn 120 yd"), "Set waypoint" (the vignette's position, asked again
  on the click and on parent maps when the player's map lacks it; a unit:
  where it was seen; else the nearest known spawn on the player's continent,
  or no waypoint) and "Show rare" (the section),
  `rares.toastSeconds` with a drain line, held under the cursor, draggable
  (`rares.toastPoint`).
- **Pins**: layers `rares.rare` and `rares.treasure` through `Polestar.Pins`,
  world map and minimap per kind (`rares.worldRares`, `worldTreasures`,
  `minimapRares`, `minimapTreasures`; all off by default, Map → Rares & travel →
  Rares and treasures); one pin per distinct spawn (spawns of
  one rare within 1.5 map percent share it), rares at grey levels left out
  with `rares.hideGrey`, elites ringed, ones seen in the last two hours
  glowing. Click: the section; Shift-click: waypoint. The Codex loads when
  the world map opens with a world kind on, or after login with a minimap
  kind on. A layer is due once its minimap kind is on, or its world kind is
  on and the world map has opened; only then are its records decoded, 40 per
  frame, never inside `Codex.Load` (`CODEX_LOADED` only schedules a refresh
  for the next frame), so a search or tooltip that loads the Codex pays
  nothing for the pins.
- **Section** (hub, order 50): nav Rares / Treasures / Seen with counts, the
  hub search filters by name or zone; list by zone (the player's first) or,
  under Seen, newest first; the selection shows Drops (its signature drop
  from `Codex.Loot`: the best quality, then the highest item level; no loot
  table, no drop rates; click opens Lookup, Alt-click `Lookup.Guide`), Where (`Lookup.Sources(kind, id)`: spawns with travel; a
  click sets the waypoint) and Seen. "Look up" opens it in Lookup.

## Talents — talent plans

`addon/Polestar/Talents/` (`Talents\Talents.xml`, loaded after `Rares\Rares.xml`):
`Talents.lua` (settings `talents.*`, the plan per character in
`PolestarCharDB.talents.build`, progress, validation, the unspent-point reminder),
`Builds.lua` (generated by `talents build`), `Overlay.lua` (the talent frame),
`Options.lua` (Questing → Talents → Talent plan), `View.lua` (the hub section,
order 40).

```
Polestar.Talents.Current() -> { data, build, live, valid, level, granted, state, staged } | nil, reason
Polestar.Talents.State(build, ranks, level, granted) -> { status, done, total, next, nodeNext, offPlan, spent, points, unspent, source }  -- pure
Polestar.Talents.Replay(data, build) -> errors              -- pure; the snapshot's rules
Polestar.Talents.Validate(data, live) -> { map, back, moved, missing, ok }
Polestar.Talents.Choose(key | "auto")                       -- per character; "auto" follows Gear's spec, else the column with most points
Polestar.Talents.Show()                                     -- SHOW_TALENTS; /pole talents
```

- **Client.** Forever's talents are one C_Traits tree per class (Paladin:
  TraitTree 1100), three spec columns, tier gates on points spent in a
  column, seven arrows. Every call goes through `Talents.Client`
  (`C_ClassTalents.GetActiveConfigID`, `C_Traits.GetTreeNodes`,
  `GetNodeInfo`, `GetEntryInfo`, `GetDefinitionInfo`, `GetTreeCurrencyInfo`). Refreshes are queued
  to one per frame on `TRAIT_CONFIG_UPDATED`, `TRAIT_NODE_CHANGED`,
  `TRAIT_TREE_CURRENCY_INFO_UPDATED`, `ACTIVE_TALENT_GROUP_CHANGED`,
  `PLAYER_TALENT_UPDATE` and Gear's spec changes; `TALENTS_UPDATED` follows.
- **Classes.** One plan file per class (`talents/forever/<class>.json`);
  `talents build` writes them all into `Builds.lua`, one `T.Register` per
  class, sorted by class. The tool finds each class's tree by its class skill
  line (`CLASSES` in `tools/lib/talents/build.js`) and leaves out a stray
  copy of a talent far off the grid (1.60.1.70374: Hunter node 104982,
  Lightning Reflexes again; Priest node 105865, Holy Specialization again).
- **Validation.** `Builds.lua` carries the tree the plans were replayed on.
  At run time each node is matched by ID (same rank count and name), else by
  name and rank count (a moved ID); a planned talent not found makes the plan
  out of date: the section says so and the frame gets no marks.
- **Points.** A plan is an ordered sequence of picks, not a schedule: the
  addon never assumes when a point arrives (a Legacy talent such as
  Talented (Adventure) grants them from level 5). Granted points (spent plus
  unspent) come from the tree's currency (`C_Traits.GetTreeCurrencyInfo`, as
  the Recorder reads it); one point a level from 10 is the fallback only when
  the client gives none. Whenever a point is unspent the next pick is marked
  and the reminder names it; nothing is muted for the level cap. Levels in a
  plan's notes are shown as approximate ("Around level N").
- **Rules.** The source plans are written one point a level from 10 (the
  replay's order); a pick is the next rank of its
  talent; gates and arrows as the tree has them. Of several arrows into one
  talent any one opens it (the client's SufficientForAvailability edges: the
  Hunter's Intimidation, from Bestial Swiftness or Bestial Wrath); a line
  the client only draws (TraitEdge type 0) is no arrow. Whether an arrow needs its
  source at full rank or one rank is `PREREQ_RULE` in
  `tools/lib/talents/build.js` (default `"full"`, unconfirmed in game);
  `Builds.lua` carries it as `prereq` and `Talents.Replay` follows it.
- **Overlay.** Post-hooks only: the frame's `OnShow` and EventRegistry's
  `TalentFrameBase.ButtonsUpdated` / `ConfigUpdated`, and each button's
  `OnEnter` (`HookScript`) for the tooltip line. Marks are our own child
  frames: a ring on the next pick while a point is unspent, the pick number
  of each talent's next planned rank (an order, never a level), a flag on
  ranks off the plan; the tooltip line says "pick #N". Staged ranks count. Nothing is drawn while inspecting or for a
  loadout that is not the active one; in combat the redraw waits for
  `PLAYER_REGEN_ENABLED`.

## Toolchain (Node ≥ 24, zero npm dependencies)

`node tools/polestar.js <command> [args]`. Each command is a module
`tools/commands/<name>.js` exporting:

```js
module.exports = { name, summary, usage, async run(argv) { return 0 /* exit code */ } }
```

The dispatcher discovers them; adding a command never edits a shared file.
Shared helpers: `tools/lib/paths.js` (the repository's folders), `tools/lib/cli.js`
(argument parsing, diagnostics), `tools/lib/game/` (XP rules, races and
classes), `tools/lib/lua.js` (run Lua 5.1, convert Lua data to JSON),
`tools/lib/tga.js` (anti-aliased TGA textures).

Every command, every generated file and the rebuild order: [tools/README.md](../tools/README.md).

### Packs (pack mode)

The guide commands work on a pack: the folder given as their one argument
or in `--pack <dir>` (one of the two; it must hold `pack.json`), else the
nearest folder holding a `pack.json` (this one or a parent), else our
`guides/` (`tools/lib/pack/locate.js`). `tools/lib/pack/manifest.js` reads and
checks `pack.json`; `tools/lib/pack/format.js` holds the contract constants
(`FORMAT`, `NEEDS`, the id rule, reserved ids, the generated-folder marker);
`tools/lib/pack/build.js` builds a pack's files; `tools/lib/dsl/project.js`
loads a pack with our guides as context (their `next` targets and chains seen,
their own diagnostics not reported).

What `compile` writes into a pack's folder: Core, "Guide data (compiled Lua)".

| Command | In a pack |
|---|---|
| `new [dir]` | writes a pack from `tools/templates/pack/` (the CI workflow and devcontainer only when the clone has an `origin`) |
| `lint`, `compile` | checks with our guides as context; writes `<pack>/dist/<folder>/`; `--format text\|json\|github` |
| `doctor` | Node, Lua, reference data, AddOns folder, `pack.json` |
| `find` | quests, NPCs, objects, items, inns, flight points and our guides as guide lines (`--json`); `--kind inn\|flight` without a text lists every inn or flight point (from `travel.json`) |
| `playtest` | every guide to the end per class (`tools/lib/playtest.js`, also behind `tests/guides.test.js`); a guide starts with the prerequisites of its accepts that the guides chaining into it turn in already done, and those they leave for it only to hand in in the log, as for a player arriving on the route |
| `play`, `dev` | the playground with the pack built into a temp folder; `dev` watches and builds into AddOns |
| `install`, `pack` | builds and installs the pack; writes `<pack>/dist/<folder>-<version>.zip` |
| `record draft`, `sim compare` | drafts into `<pack>/drafts/` under `<id>/draft/`; scores the pack's chain beside ours |

`lint`, `compile`, `dev`, `play`, `install` and `pack` build a pack through
`buildPack` (`tools/lib/pack/build.js`). When the data folder is missing or holds none of
the core files, it reads no guide and returns one error (`noReferenceData`)
with `noData` set; the command prints that error and exits 1, and `dev`
checks this once at start instead of watching. `--no-data` (`lint`, `compile`,
`dev`, and `install` and `pack` on a pack) builds with empty data instead and
cannot be combined with `--data`, `--context-data` or `--sim`.

The folder rule (PACK_FORMAT.md, "TOC fields") is `packDirRefusal` in
`tools/lib/dsl/project.js`. Lint's pack rules mirror the runtime's
(`tests/packs-parity.test.js`); our house rules (elites in Leveling guides)
are warnings in other packs.

### Zone art overlays (`maps overlays`)

`node tools/polestar.js maps overlays [--build <ver>] [--offline]` writes
`addon/Polestar/UI/ZoneArtOverlays.lua` (`tools/lib/maps/overlays.js`) from
the client's DB2 tables, as wago.tools CSV cached under
`data/sources/wago/<build>/`: `UiMapXMapArt` (every art a map shows, any
phase), `UiMapArt` → `UiMapArtStyleLayer` (layer 0's tile size), then each
`WorldMapOverlay` of those arts (texture size, offset) with its
`WorldMapOverlayTile` files (layer 0) in row-major order; `UiMap` names
the comments. Keyed by UiMapArtID so the addon can tell whether the client
shows the art it was built for. Empty (0 x 0) rows are dropped; a row whose
tiles do not fill its grid is dropped with a warning. The default build is
the Forever client's (1.60.1.70338, product `wow_classic_beta`). It lives in
the core addon, loaded right after `UI/ZoneArt.lua`, because the core is what
draws it (the menu and the route cards work without any pack), and it
registers through `ZoneArt.RegisterOverlays` the way `MapFrames.lua` and
`Maps/ZoneLevels.lua` register their generated tables.

### Codex (`codex build`)

`node tools/polestar.js codex build [--addons <dir>] [--build <version>] [--offline] [--out <dir>] [--local-extras]`
merges `data/forever/*.json` (pfQuest, QuestieDB facts, recordings,
corrections, Wowhead and web XP facts), the Forever client's tables
(wago.tools, cached under `data/sources/wago/<build>/`: the newest 1.60+
`wow_classic_beta` build wago.tools lists, as `data build` picks its
`--forever-build` (`pickBuild` in `tools/lib/data/wago.js`); `--build`
names one; offline or with wago.tools unreachable, the newest cached build
holding every table the Codex reads; `meta.json` records it), the installed
ForeverLevelingBiS (MIT) and Polestar's own guides into
`data/forever/codex/*.json`, then emits the load-on-demand pack
`addon/Polestar_Codex/` (`tools/lib/codex/pack.js`) with its
`LICENSE-DATA.txt`, which lists every source with its version and licence.
Both are build products (gitignored); the pack is part of the release:
`pack` puts it in the zip and fails without it, `install` copies it when
built.

- Release-safe by default. `--local-extras` also merges three inputs that
  may not be redistributed: AtlasLoot (GPL-2.0, incompatible with
  Polestar's GPL-3.0-only), RareScanner (All Rights Reserved) and
  `data/forever/dungeons.json` (DungeonJournal, no licence). That build's
  `meta.json` and `Meta.lua` carry `localExtras = true`, its
  `LICENSE-DATA.txt` says not to share it, and `pack` refuses it, as it
  refuses a pack whose sources name any of the three
  (`releaseRefusal` in `tools/lib/codex/pack.js`). It exists for comparison
  on the developer's machine.
- Importers, one per installed addon, all reading through
  `tools/lib/consume/lua.js` (`addonVersion`, `readAddonLua`: the installed
  addon's files, found with `tools/lib/addons.js`, run sandboxed in Lua 5.1
  with the namespace the client passes them): `foreverlevelingbis.js` (item
  sources: quest rewards, drops, crafts); with `--local-extras` also
  `atlasloot.js` (DungeonsAndRaids incl. `forever.lua` and `droprate.lua`,
  Collections, Crafting, Factions, PvP) and `rarescanner.js` (rares, their
  loot, treasures, mount and pet items). Each returns plain JSON with a
  `meta` naming its source, version and licence.
- Client tables: `Item`, `ItemSparse` (names, quality, levels, prices, the
  reputation and PvP rank an item requires: rep and pvp sources), `ItemEffect`,
  `ItemXItemEffect`, `SpellEffect`, `SpellName`, `SkillLine`,
  `SkillLineAbility`, `Mount` and `BattlePetSpecies` (the summon spells that
  make an item a mount or a companion), and for the dungeons `Map`,
  `AreaTable`, `DungeonEncounter`, `LFGDungeons`, `MapDifficulty`,
  `ContentTuning`; the Classic Era `Item`, `ItemSparse`, `ItemEffect` and `Map`
  fill items Forever's tables lack and tell Forever's own instances apart.
- Dungeons and raids (`tools/lib/codex/instances.js`, release build): every
  `Map` instance that Forever's dungeon finder (`LFGDungeons`) names, or that
  belongs to the original game (map id below 1000) and has `DungeonEncounter`
  rows; Season of Discovery maps the client also carries stay out. `forever`
  = absent from the Era client's `Map`. Levels `[entry, min, max]`: the
  `MapDifficulty` "at least level N" message, the `ContentTuning` minimum of
  its dungeon-finder entries, the highest boss level (at most 60). Bosses:
  the `DungeonEncounter` rows of the normal difficulty in `OrderIndex` order,
  each matched to `npcs.json` (a recorded encounter's NPCs, else the same name
  among NPCs placed in the instance, else the same name preferring elites
  without open-world spawns at the instance's level, else one spawnless NPC
  whose name starts with it or is within two letters of it, of several the
  one placed inside (Kirtonos the Herald, not its spell visual); "A and B"
  encounters name both; an encounter naming no NPC takes the chest placed
  inside whose name ends with its name, The Seven: Chest of The Seven). A
  boss's loot (at most 30 items) is its own table first: its `items.json`
  drops at 1% or more or at an unknown rate, and its Wowhead drops outside
  the world-drop pool at any rate (Thermaplugg's schematics, Dextren Ward's
  plans); then Wowhead's `commondrop` rows (world books, world blues) at 1%
  or more, so those no longer crowd out a boss's own loot (Onyxia's Sacks
  of Gems); each part best chance first. The entrance (`chooseEntrance`): a recorded one
  (Recorder `enter`, `data/forever/instances.json`), else the curated table
  `tools/lib/codex/entrances.json` (per instance key: the point on the zone
  map where one walks in, `{ key, instance, map, x, y, source, note }`, each
  with its public source, checked against the corpse point and our guides'
  gotos; every dungeon and raid in the Codex, Forever's own included, from
  QuestieDB's Forever dungeon table, warcraft.wiki.gg and Wowhead Forever),
  else a guide's `goto x,y "<instance name> ..."`, else the `Map` Corpse
  point (where a ghost comes back: near the way in, not at it; the
  Deadmines' is the portal deep in the Moonbrook mine, 200 yd from the
  Defias Hideout one walks in at) on the zone holding it, marked
  `approx: true` (packed as a fifth entrance field `a`, read as
  `Codex.Instance(key).entrance.approx`). `AreaTrigger` rows name no instance
  and the trigger nearest a Corpse point is as often an inn or city trigger,
  so they are not used. Every
  NPC placed in an instance (`npcs.json` `instances`, from QuestieDB and
  recordings, or Wowhead's `location` naming an `AreaTable` area of the
  instance's map) belongs to it: its drops carry the instance. An instance's
  boss or mob the data ranks rare is not a rare unless RareScanner lists it.
  `--local-extras` takes the instances from AtlasLoot and `dungeons.json`
  instead.
- Wowhead Forever per entity (`tools/lib/codex/wowhead.js`, release build
  only, lowest precedence). `codex build` reads the Wowhead Forever facts
  cached under `data/sources/wowhead/codex/`, and builds without them when
  there are none. The cache holds Wowhead's NPC, object
  and item list rows by id range (`lists/<type>.json`: id, name, levels,
  classification, boss flag, `location` and `envChange`, how Forever differs
  from Classic) and each fetched entity's facts
  (`<npc|object|item|spell>/<id>.json`). `codex build` reads the NPC rows
  for one fact only: the level of an NPC neither our data nor a page gives
  one (286 NPCs); a row's rank, boss flag and place are no page's, so rares,
  bosses and parity's verdicts read only pages. From the pages: an NPC's
  level, rare rank and spawns where ours lack them (and the rares only
  Wowhead places), drops and object contents with chance = looted count /
  looted kills, an NPC's or object's `location` (the areas its page entry
  names) and Wowhead's boss flag, and the reputation ("Requires <Faction> -
  <Standing>") and PvP rank ("(Rank N)") an item's Forever tooltip asks for.
  An instance also lists, after
  its encounters and by level, the NPCs placed inside that the data or
  Wowhead ranks rare or boss (or flags boss), or that alone drop an item of
  quality 2 or better at 5% or more, each with a `role`: `rare` (ranked
  rare), `event` (pfQuest and QuestieDB know no static spawn: summoned or
  scripted, the Ring of Law's fighters, the Tier 0.5 summons), else
  `optional`; then the chests placed inside (no gathering node) that hold
  more than one item (one is a quest object) and alone an item of
  quality 2 or better (at 5% or more, or an unknown rate), as bosses with an
  `object` and no `npc` (role `optional`). A boss is `{ name, npc, items }`,
  plus `object` and `role` when set; the pack writes its ref as the npc id,
  or `o<object>`, then `r`/`e`/`x` for the role (an old pack's bare npc id
  still reads), and the Dungeons Bosses tab says Chest and the role beside
  the level.
- Attunements and keys (`tools/lib/codex/attunements.js`, release-safe):
  the cited table `tools/lib/codex/attunements.json` names per Codex instance
  each attunement's goal only (the quests that end it, one of them with
  `any`, or the key item), whether everyone entering needs it or one in the
  group, and our one-line note, each entry with its public sources (Wowhead
  Forever, warcraft.wiki.gg). The steps come from the Codex: every
  prerequisite of a goal (all of `pre`, the `preAny` of the entry's side),
  oldest first, each with `after`/`afterAny`; a quest only an item starts
  gets that item's drops before it (Blackhand's Command from the Scarshield
  Quartermaster); an item goal adds the item's own sources (a dropped key's
  drops and chests, best chance first, three at most; Aqual Quintessence's
  standing and the NPC handing it out). `links` add a prerequisite our quest
  data lacks, with its source (Forever's City of Dalaran: Blood in the
  Streets after Dalaran Patrols and Key to the City, Heart of Disruption
  after it). `inside` places an NPC or object of a chain that has no
  open-world spawn and no Codex instance in the instance it is in, each with
  its Wowhead Forever page (Marshal Windsor, the Monument of Franclorn
  Forgewright and the Core Fragment in Blackrock Depths; the Inconspicuous
  Documents and Drakkisath's Brand in Blackrock Spire; Doan's Strongbox in
  Scarlet Monastery); each attunement carries the entries its steps meet as
  `inside: [{ kind, id, instance }]`. `removed` lists what Forever took out,
  with its evidence (the Seal of Ascension: 4743 no longer rewards it, no
  Forever `ItemSparse` row), read only by the local comparison. Covered: Molten Core (Attunement
  to the Core; Aqual Quintessence), Onyxia's Lair (the Drakefire Amulet,
  each side's chain), Blackwing Lair (Blackhand's Command), Naxxramas (one
  of the three Dread Citadel quests), Scholomance (the Skeleton Key, each
  side), Blackrock Depths (the Shadowforge and Prison Cell keys), Stratholme
  (Key to the City), Dire Maul (Crescent Key), Gnomeregan (Workshop Key),
  Scarlet Monastery (The Scarlet Key), the City of Dalaran (the Horde's
  Dalaran Sewer Key). A goal the Codex lacks drops its entry with a warning
  (`codex build` prints it); an instance the build lacks has none. The
  journal puts each list on its page as `attunement` and counts them
  (`meta.counts.attunements`, the summary's `attune = { A, H }`).
  `auditReport(journal, attune, codex)` writes the local comparison with
  Attune (`codex attune`, `data/local/attunements-audit.md`): per Attune
  entry the attunement of ours sharing most quests, the quests only one side
  lists and why ours has or lacks them (in our chain, a follow-up of our
  goal, not a prerequisite in our data, not in our Codex), then our verdicts
  on which source is right, kept in `data/local/attunements-verdicts.md` so
  a rerun keeps them.
- Rares and treasures: NPCs ranked rare (4) or rare elite (2) in `npcs.json`
  (pfQuest, QuestieDB, recordings), with their spawns and loot; treasures are
  objects with the `chest` role, with their loot. Loot (`Codex.Loot`, where
  the Rares view picks a signature drop) is every drop or object candidate
  naming it, its own first (items no other NPC or object drops or holds:
  Bayne's Bite, Serrated Shadowclaw), then best chance first, at most 150 (a
  rare's candidates run to hundreds, median 286; 150 keeps every drop the
  internal build names that Wowhead Forever confirms, for about 215 KB of
  pack). An item keeps its 10 likeliest droppers (6 objects, 10 vendors) plus
  the drops of its instances' bosses.
- Precedence for a fact found in several places follows `docs/SUITE.md`;
  sources are deduplicated by type and id, keep their `from` provenance and the
  best-known drop chance.
- Output: `meta.json` (`sources`, `localExtras`, `counts` by kind, `coverage`
  = items with at least one source, `pack` = files, bytes and measured
  memory), `items.json`
  (`{ id, name, quality, kind: item|mount|pet|recipe|tabard, spell, reqLevel,
  repFaction, repStanding, reqSkill, reqSkillRank, status, sources }`; a source
  is `{ type: vendor|drop|object|quest|craft|rep|pvp|
  container|world, from, ... }`), `npcs.json`, `objects.json`, `quests.json`
  (with `pre` = every blocking prerequisite, `preAny`, rewards from recordings
  and ForeverLevelingBiS, and `wowhead` on each quest Wowhead Forever's zone,
  dungeon and raid lists carry: `{ zone, type, side, choices, items, money,
  rep }`, the zone or instance category and the list's rewards, read by the
  journal), `instances.json`, `zones.json`, `factions.json`,
  `spells.json` (mount and pet aura spell → item, class), `frames.json` (Era
  bounds for the pack's maps), `journal.json` (the Dungeons pages).
  An item's `status` is `nosource` without a source, and `retired` for a mount
  or pet whose every source is an Era vendor row (pfQuest provenance) and,
  in a release build, whose summon spell's `Mount` row the Forever client
  flags hidden until known (`Flags` 0x40: kept only for those who already
  have it; the still-sold Black Stallion is not flagged), or, with
  `--local-extras`, that AtlasLoot Forever's collection lists do not name: the
  stock the pre-1.4 epic mounts were retired from. A curated guide's
  `collects` keeps an item obtainable, and Forever-only rows are trusted.
  Companions have no such client flag: a release build retires none.

- Parity (`tools/lib/codex/parity.js`): a release build compares itself,
  entity by entity, with the last `--local-extras` build in
  `data/local/codex-extras` (when there is one), writes
  `data/local/codex-parity.json` and `.md` (per kind: total, matching,
  missing and different rows; a difference whose value comes from a
  better-evidenced input says so and counts as a match; a corpse point is
  never taken for an entrance) and records the match per kind in its
  `meta.parity`; without the internal build it claims none. A confirmed
  missing drop or loot row that the build knows but a cap left out (the
  merge's `evidence.cut`, not shipped) says so ("cut by a cap") and is
  counted on its own line. A chest boss matches the internal row named after
  its object (Chest of The Seven); a confirmed missing boss that Forever's
  sources place outside every instance (Wowhead `location` or spawns off the
  instance maps' areas: Techbot, Maraudon's Desolace caves) or rank an
  ordinary NPC (no Wowhead boss flag, not rare, no green or better item
  only it drops at 5% or more) says so, counted as "no boss of it in
  Forever's sources". `codex parity
  [--ours <dir>] [--against <dir>]` reruns the comparison. The report also
  lists what only play can fill and the Recorder event that fills it
  (Forever instances and their entrances: `enter`, `encounter`; Forever
  rares: `rare`, `slain` + `drop`; quest givers, enders, rewards: `accept`,
  `turnin`). On 2026-10-15 (Forever client 1.60.1.70374, the same
  `data/forever`):

  | Kind | Internal | Release matching | Match |
  |---|---:|---:|---:|
  | instances | 44 | 37 | 84.1% |
  | instance levels | 29 | 29 | 100.0% |
  | instance entrances | 14 | 13 | 92.9% |
  | bosses | 373 | 333 | 89.3% |
  | bosses with loot | 326 | 324 | 99.4% |
  | boss loot items | 2306 | 1977 | 85.7% |
  | drop chances | 20707 | 17533 | 84.7% |
  | rares | 413 | 411 | 99.5% |
  | rare positions | 387 | 384 | 99.2% |
  | rare levels | 406 | 406 | 100.0% |
  | rare loot | 51604 | 50787 | 98.4% |
  | treasures | 65 | 60 | 92.3% |
  | treasure positions | 31 | 31 | 100.0% |
  | treasure loot | 4502 | 4498 | 99.9% |
  | items with a source | 16205 | 16187 | 99.9% |
  | items: drop | 8806 | 8743 | 99.3% |
  | items: quest | 2429 | 2429 | 100.0% |
  | items: vendor | 2248 | 2248 | 100.0% |
  | items: object | 3288 | 3287 | 100.0% |
  | items: world | 4152 | 4150 | 100.0% |
  | items: craft | 1797 | 1797 | 100.0% |
  | items: container | 2095 | 2095 | 100.0% |
  | tabards | 40 | 40 | 100.0% |
  | mounts | 136 | 136 | 100.0% |
  | items: rep | 980 | 975 | 99.5% |
  | pets | 90 | 90 | 100.0% |
  | items: pvp | 763 | 763 | 100.0% |
  | journal quests | 833 | 823 | 98.8% |
  | quest givers | 582 | 568 | 97.6% |
  | quest enders | 618 | 608 | 98.4% |
  | quest XP | 698 | 689 | 98.7% |
  | quest chains | 481 | 474 | 98.5% |
  | quest rewards | 582 | 577 | 99.1% |

  The gaps: seven Forever instances AtlasLoot lists ahead of release are not
  in the client (no `Map` row); the Hall of Thanes' entrance stays
  different (QuestieDB's Ironforge 27.6,47.8, where Wowhead Forever's
  comments put the quest givers "near the entrance", against 43.5,52) until
  a recording settles it; AtlasLoot's extra bosses (the Ring of
  Law's fighters, rare spawns, chests) are not `DungeonEncounter` rows;
  reputation standings that vendors gate in gossip, and battleground rewards
  AtlasLoot files as PvP, are in no client table (`ItemSparse` carries no
  `MinFactionID` or `RequiredPVPRank` for them, and Wowhead Forever's Sells
  standing is that same `MinReputation`). A vendor's, giver's or quest's gate
  comes from the cited table `tools/lib/codex/repgates.json`
  (`loadRepGateTable`, provenance `curated`: rows `{ item, name, faction,
  standing, npcs: [vendors or givers] | quest (+ choice), source, note? }`,
  one per item and faction, each citing warcraft.wiki.gg, else Wowhead
  Classic's reputation guides or QuestieDB; the Alterac Valley and Warsong
  Gulch supply officers, Argent Dawn quartermasters, Timbermaw Hold, Duke
  Hydraxis, Rin'wosho the Trader's barter quests, which the row also makes
  the item's quest source since QuestieDB lists no rewards for them), from a
  curated guide that collects the item and reaches the standing before its
  `buy` (`curatedRepGates`, provenance `guides`: the Winterspring
  Frostsaber, the Stormpike Battle Charger, the Frostwolf Howler), and a
  quest's from QuestieDB (`minRep` or a reputation objective, the higher: a
  `rep` source naming no vendor, and the quest's `repFaction`/`repStanding`,
  which blocks its reward row in Lookup; a table row's standing replaces it,
  with a warning when they differ). Precedence: client, then the table, then
  a guide. A rep source at an item's vendor or giver sets its
  `repFaction`/`repStanding`; Lookup gates each vendor or giver row by the
  rep source standing at that npc, else (a purchase) by the item's own,
  unless that is the other side's faction and a gate of the npc's side exists
  (`Lookup.PurchaseRep`: Alterac Valley wares both sides' supply officers
  sell). A table row whose item, vendor or quest the Codex lacks is a build
  warning. What stays missing: the Insignia of the Dawn and of the Crusade
  (quest rewards and turn-ins, no standing), the Bloodsail Shirt, Sash and
  Pants (in the Buccaneer's Uniform, whose quest, Dressing the Part, carries
  the Neutral gate) and the world-drop Warbear patterns 15742 and 15754
  (Timbermaw Hold sells 20253 and 20254, gated in `ItemSparse`). An NPC that
  casts a spell creating an item (client `SpellEffect` 24; who casts it,
  Wowhead Forever's spell page in the cache) hands it out: a `gift { npc,
  spell }` source (Duke
  Hydraxis's Aqual and Eternal Quintessence). 26 Forever rares no
  database ranks yet. The 251 confirmed drop chances the release lacks are
  all cut by an item's 10-dropper cap (the internal build keeps AtlasLoot's
  instance trash past it; every dropper of every item would be 1.6 million
  sources against 74 thousand).

### Reference data (`data/forever/`, built by `data build`, gitignored)

```
quests.json   { "<id>": { id, title, level, minLevel, races, classes, start: { npc: [], object: [], item: [] },
                          end: { npc: [], object: [] }, pre: [ids], excl: [ids], next, objectives: [
                          { type: "kill"|"item"|"object"|"event", id, count, text } ], objectiveText, zone, xp,
                          rewards?: { items: [ids], choices: [ids], money }, source: [] } }   (rewards: recorded only)
npcs.json     { "<id>": { id, name, level, levelMax?, rank?, faction, roles?, spawns: { "<uiMapID>": { f: "e"|"l", pts: [[x, y], ...],
                          more?: [[x, y], ...] } }, instances?: [instance map ids], encounter?: DungeonEncounter id, source: [] } }
objects.json  { "<id>": { id, name, roles?, spawns: { ... same ... }, instances?: [instance map ids], source: [] } }
items.json    { "<id>": { id, name, drops: { npc: { "<id>": chance }, object: { "<id>": chance } }, vendors: [ids], source: [],
                          seen?: { npc|object: { "<id>": { n, of } } } } }   (chance in percent; seen: recorded loot counts)
zones.json    { "<uiMapID>": { id, name, areaId, parent, type } }
map-frames.json { era: { "<uiMapID>": { c, left, right, top, bottom } }, forever: { ... same, Forever client bounds ... } }
professions.json { "<skillLineID>": { id, name, kind: "primary"|"gathering"|"secondary", ranks: [ { name, max, minLevel } ],
                  trainers: { Alliance: [npcIds], Horde: [npcIds] }, recipes: [ { spell, name, item, itemCount, reagents: [ { item, count } ],
                  learnedAt, yellow, green, grey, source: "trainer"|"vendor"|"drop"|"quest"|"item", recipeItem, cost } ] } }
factions.json { "<factionID>": { id, name, side: "Alliance"|"Horde"|null, parent, source: [] } }   (Forever Faction table wins by id, Era fills)
races.json    { "<raceFile>": { "<Alliance|Horde>": { id, bit, classes: [classFiles] } } }   (Forever client ChrRaces, ChrClasses,
              CharBaseInfo; written only when those tables are cached; see tools/lib/data/races.js)
spawnz.json   { npc: { "<id>": [[instanceMap, x, y, z], ...] }, object: { ... } }   (CMaNGOS classic-db creature and
              gameobject spawns on maps 0 and 1, UnitPosition's frame (x north, y west), 0.1 yd, each id's spawns sorted;
              one id per line; the compiler's goal `z`, tools/lib/dsl/heights.js; left out, with one warning, when
              --offline has no cached dump; tools/lib/travel/cmangos.js loadSpawnHeights)
meta.json     { builtAt, sources: [ { name, url, revision, license } ], counts: { ... }, liveFrameMaps: [uiMapIDs],
                questie: { notInStore: [quest ids], changedFields: { field: count } } }
dungeons.json { source: { name, addon, title, version, author, license }, dungeons: [ { key, name, levels: { min, max },
                zone, zoneName, entrance: { map, x, y, f }, abbreviations, factions, bosses: [ { name, npc, level, rare,
                loot: [ { item, name, slot, quality } ] } ], quests: [ quest ], chainQuests: { "<id>": quest } } ] }
                quest = { id, title, faction, level, minLevel, classes, xp, xpSource, money, rewards: { items, choices },
                start, end: { map, x, y, f, source: "data"|"data-npc"|"dj"|"web"|"entrance", kind, id?, item?, name, inDungeon? },
                chain, followUps, startItem, startBoss, startNear, bosses, hidden?, inData }
```

Spawn points per entity per map: `pts` holds at most 24 (`data build --cap`),
spread evenly over the entity's spawns (farthest-point sampling); `more` the
distinct points the cap left out, sorted by x then y, only when there are any.
Every consumer reads the evenly spread `pts` (the simulator, zone levels,
Codex, the profession generators), except the ones that mark where an entity
spawns, which read `pts` and `more`, every known spawn: the guide compiler's
spawn areas and near-spawn lint, and QuestDB's marker clusters.

`dungeons.json` is built by `dungeons build` (`tools/lib/data/dungeonjournal.js`)
from the installed DungeonJournal addon (no licence: local only, see
THIRD_PARTY.md). Bosses are in kill order; `entrance` and DungeonJournal
positions are live frame (`f: "l"`). Quest positions take our data first (the
quest's giver/ender with spawns, DungeonJournal's map picking the spawn; else a
spawning NPC of the named giver), then DungeonJournal's maps, then positions
researched by hand (`WEB_POSITIONS`, with a reference); a giver inside the
instance gets the entrance and `inDungeon`. `chain` is DungeonJournal's
prerequisite list with our data's `pre` added in doing order; `xp` is our
data's, else DungeonJournal's observed Forever XP. The guide compiler reads
nothing from `dungeons.json` (its facts stay local, THIRD_PARTY.md): a quest
only it knows needs its title (and level) written in the guide.

The hub's Dungeons section and the pick-up guide built from it: "Dungeons" above.

`professions.json` is built by `profession build` from the Forever client's
DB2 (`wow_classic_beta` 1.60+ via wago.tools: SkillLine, SkillLineAbility,
SpellName, SpellEffect, SpellReagents, ItemSparse, Item, ItemEffect,
ItemXItemEffect, ...; `tools/lib/professions/tables.js`). Forever changed
recipe thresholds, reagents and names from Classic (issue #109), so Classic
Era only fills gaps: a table wago.tools has no Forever export of (SpellTotems,
SpellCastingRequirements, SpellFocusObject) comes whole from the newest Era
build, and the spells and items the Forever tables lack come from Era's rows.
Each profession also carries `mainTrainer { Alliance,
Horde }` and `materials { itemId: { name, buy, buyCount, sell, quality,
vendors { A, H }, limitedVendors { A, H }, madeBy, gather { herb, mine, fishing },
drops, dropCount } }`; ranks carry `minSkill`, `spell`, `trainers { A, H }` and,
for secondary skills, `book`/`quest`; recipes may carry `enchant`,
`learnedAtEstimated`, `requires` (specialisation), `reputation { faction,
standing }`, `tools`, `focus`, `races`, `classes`, `skillUps`. Season of
Discovery recipes (spell id ≥ 400000 that the Era client's SkillLineAbility
lists too; Forever's own recipes, past 1,000,000, it does not) and the ones Forever
retired (`AcquireMethod` 3, such as Alchemy's healing potions, which Forever
teaches in First Aid) are excluded. A crafting profession whose last points no
trainer or vendor recipe reaches (Forever Tailoring past 295: Spinning Wheel,
Loom) is drafted as far as they go, with a last step naming what is left.

`races`/`classes` are Blizzard bitmasks (Human 1, Orc 2, Dwarf 4, NightElf 8,
Undead 16, Tauren 32, Gnome 64, Troll 128; Warrior 1, Paladin 2, Hunter 4,
Rogue 8, Priest 16, Shaman 64, Mage 128, Warlock 256, Druid 1024), `null`
means unrestricted. pfQuest masks are **Era** masks: Skyborne has no bit there,
so never read an Era-only mask as excluding Skyborne. QuestieDB masks add
Forever's Skyborne bits 2^32 (High Order, Alliance) and 2^33 (Windshapers,
Horde), past 32-bit `bit.band`: split them arithmetically (`races % 2^32`,
`floor(races / 2^32)`). `Polestar_QuestDB` keeps the low 32 bits. Spawn `f` is the frame of
those points (`"e"` Era, `"l"` live Forever). A frame's `c` is the instance map id (0 Eastern
instances.json { "<instance map id>": { id, name, type: "party"|"raid", entrances: [ { map, x, y, n } ],
                 encounters: { "<DungeonEncounter id>": { name, npcs: [ids], kills } }, source: ["recorder"] } }   (recorded only; {} without)
Kingdoms, 1 Kalimdor; 2991, 2997 for Forever's new islands): the `continentID`
`C_Map.GetWorldPosFromMapPos` returns.

Optional extras: quests `skill` (profession requirement), `event` (holiday),
`escort` (true or false, only from corrections.json: whether it is an escort
where its own text does not say so right; tools/lib/dsl/escort.js),
`xpSamples` (how many recorded observations back `xp`); event objectives `map`,
`f`, `x`, `y`; npcs `levelMax`, `rank`, `roles` (flightmaster, innkeeper,
vendor, trainer, ...), `subName`; objects `roles` (herb, mine, chest, ...); items
`containers` (items that contain it), `questItem: true` (QuestieDB item class 12:
drops only while on the quest), `duration` (seconds the item lasts once the
player has it: the Forever client's ItemSparse DurationInInventory, when that
table is cached; the timed-item lint reads it). A drop chance is `null` when QuestieDB lists the
dropper but no source has a rate. From QuestieDB, each only when it has a
value: quests `preAll` (all must be done; preQuestGroup), `preAny` (any one
suffices; preQuestSingle), `breadcrumbFor` (the quest this optional breadcrumb
leads to), `breadcrumbs` (breadcrumbs leading here), `parent` (must be active;
parentQuest), `children` (childQuests), `requiredItems` (needed, not
objectives), `sourceItem` (handed over at accept), `maxLevel`, `skillLevel`,
`repeatable`, `reputation { faction, value }` (an objective), `minRep { faction,
value }` (requiredMinRep: the reputation value, 3000 Friendly, a character needs
to take it), `area` (AreaTable id
of the quest's zone or dungeon, QuestieDB zoneOrSort > 0); kill objectives
`credit` (every npc id that gives the kill credit). `pre` keeps pfQuest's
meaning (any one suffices, optional breadcrumbs included) for every quest
pfQuest has; Forever-only quests take `preAny`, else `preAll`. `excl` is the
exclusive group: pfQuest `close` united with QuestieDB `exclusiveTo`.

#### Sources and precedence

`data build` reads, lowest precedence first:

1. **pfQuest** (MIT, git clone cached in `data/sources/pfQuest`): Classic Era
   quests, npcs, objects, items, drop chances, Era-frame coordinates.
2. **QuestieDB's Forever store** (`questie-forever`): the `QuestieDB_Forever.toc`
   that Questie for Forever installs. `--questie <dir>`, else auto-detected in
   the Forever client the way `install` finds it (client detection lives in
   `tools/lib/addons.js`: `detectAddonsDirs`, `foreverKind`). It's read in place
   (`tools/lib/data/questie.js` ports QuestieDB's `src/meta/codec.lua`,
   `src/read/baked.lua` and `normalize.default`). Field layouts come from the
   installed `src/meta/*Meta.lua`, and support data from `support/Forever/*`:
   QuestXP, DropTables (chance = manual correction, else cmangos, else
   Wowhead, as `DropDB.GetItemDroprate`), Zones (AreaID → UiMapID). It adds
   Forever-only quests, npcs, objects and items. On shared ones QuestieDB wins
   on every scalar field it has a value for (titles, levels, masks, objectives,
   spawns), and pfQuest-only fields stay. **Source lists are unions**: item
   droppers, drop objects and vendors, npc `roles`, and quest givers and enders
   list QuestieDB's entries first. Its values win on conflicts (a drop chance), and
   pfQuest's extra entries are kept. A missing QuestieDB entry is not evidence
   that Forever removed something. Real removals, or wrong pfQuest sources, go in
   corrections.json. Exceptions: npc `faction` stays pfQuest's, because QuestieDB's
   friendlyToFaction means "not hostile", so wildlife reads "AH". `pre` also
   stays pfQuest's (see above). pfQuest copies of a spawn on another map (a
   city and its zone) are kept when they lie within 30 yards of a QuestieDB
   spawn. QuestieDB's Static Corrections are folded into the store. Its Dynamic
   (per-character) Corrections are not applied. Questie and QuestieDB ship no
   licence file (CurseForge says GPL-3.0; the maintainers say to treat them as
   all rights reserved, Questie issue #4447). The data stays in `data/`, and
   only the importer is in this repository.
3. **Wowhead Forever's change notes** (`tools/lib/data/wowhead.js`,
   `--no-wowhead` skips them, as does a build without QuestieDB): the quest
   list of every zone and city page and of the nine class pages (class
   quests are filed there, not under a zone) on wowhead.com/forever, read from
   `data/sources/wowhead/zones.json`; without that cache this step adds
   nothing. A quest Wowhead marks updated with "Experience
   X instead of Y", "Level X instead of Y" or "Requires level X instead of Y"
   gets X where its value is still the old Y (for XP, also where it has none),
   and one marked "Renamed from Y" gets Wowhead's Forever name where its title
   is still Y (Chastise, formerly A Lack of Fear); any other value is left
   alone, and the quest's `source` gains `wowhead:xp`, `wowhead:level`,
   `wowhead:minLevel` or `wowhead:title`. Only rows whose category is the
   zone's area count: Wowhead answers an unknown zone path with a generic list.
   Its Forever database also lists datamined quests that are not live (`<NYI>`
   placeholders, Season of Discovery leftovers), so presence there is not
   evidence that a quest is in the game.
4. **Polestar corrections** (`tools/lib/data/corrections.json`, committed):
   facts QuestieDB or pfQuest get wrong or lack, each with its source in a `note`:
   quest fields (`set`), item sources to drop (`removeDrops`, `removeVendors`),
   npc/object fields (`set`: the Forever elite and rare ranks QuestieDB's
   Forever store lacks, since it gives every Forever npc rank 0, and renamed
   Era records) and npc/object spawn maps (`addSpawns`). They are applied
   after the merge, only in a build that reads QuestieDB, and the record's
   `source` gains `polestar-correction`. One
   cleanup is general rather than per quest: `pre`, `preAll` and `preAny`
   never contain the quest itself or an id from its `excl`. QuestieDB
   preQuestSingle sometimes lists the whole exclusive group.
5. **Recordings** (`data/recordings`), which win over all of the above;
   finds (rares, kills, loot, treasures, instances; "Recordings" below) follow
   the rules of their own paragraph there.

`source` on every quest, npc, object and item lists its contributors in
that order: `pfquest`, `questie-forever`, `wowhead:*` (change notes), `polestar-correction`, the web XP tag, `recorder`, then the recorded XP tag (`recorder:xp-*`).
Blizzard map tables come from wago.tools: Classic Era (`wow_classic_era`) for
the Era frames pfQuest's coordinates use, and the Forever client
(`wow_classic_beta` builds 1.60+, `--forever-build`, `--no-forever`) for
Forever zones and `map-frames.json` `forever`. Forever zone names win.

**Coordinate frames.** QuestieDB's store holds **Forever-frame** percentages.
For the evidence, compare its points with pfQuest's Era points for the same
entity. On Mulgore, Eastern Plaguelands, Redridge and Stormwind, QuestieDB's
points match pfQuest only after inverting QuestieDB's own `EraToForever`
transform (`src/support/eraToForever.lua`). Median distance to the nearest
pfQuest point, in map percent, raw vs inverted:

| Map | npcs | objects |
|---|---|---|
| Mulgore | 2.57 vs 0.61 | 5.10 vs 1.28 |
| EPL | 7.93 vs 0.08 | 8.52 vs 2.58 |
| Redridge | 4.25 vs 0.07 | 5.09 vs 1.40 |
| Stormwind | 14.02 vs 0.05 | 11.14 vs 0.05 |

Per entity on those four maps, 1244 were clearly closer inverted, 0 closer raw
and 114 ambiguous. On unchanged maps (Elwynn, Durotar) raw and inverted agree
(0.1-0.2 median for npcs), as they must when the frames are equal.
So QuestieDB points are tagged `"l"` on maps whose Forever bounds differ from
the Era bounds by more than 1 yard (with Forever tables; otherwise the maps
eraToForever lists) and on maps without Era bounds (Forever-only: Zephras Isle
2521, Darkspear Islands 2524, Riverglades 2548, Shen'dralas 2652, Mount Hyjal
2482). Everywhere else they are `"e"`, the same point in both frames.
`meta.liveFrameMaps` lists the changed maps.

Quest `xp`: recordings first (`rewardXpBase` wins; otherwise the largest
`rewardXp` or turn-in `xpReward` observed while the player was at most 5 levels
above the quest, since Classic reduces XP beyond that, so an over-levelled
observation never overwrites a full one; `source` names `recorder:xp-base`,
`recorder:xp-log` or `recorder:xp-turnin`). Then QuestieDB's QuestXP, with
Wowhead's "Experience X instead of Y" notes applied where it still has the old
value (above). Then, for quests still without XP, the Forever web databases
(`--no-web-xp` skips them; results are cached in
`data/sources/webxp/quest-xp.json`): wowforevertalents.com (Forever beta client
cache, tag `wowforevertalents:xp`), else foreverchanges.pro (Wowhead's Forever
database: the quest's reward, `foreverchanges:xp`, or its quest-chain list,
`foreverchanges:xp-chain`), else the XP on Wowhead's zone quest list
(`wowhead:xp`). `meta.counts` gives `questXpFromWeb`, `questXpFromWowhead` and
`wowheadChanged` ({ xp, level, minLevel, title }).

### Recordings (`data/recordings/<session>.json`)

Normalised from `PolestarRecorderDB` by `record import`:

```
{ schema: 1, build, session, char: { name, realm, race, class, faction }, started, ended,
  events: [ { t, e, ...fields } ], maps: { "<uiMapID>": { name, type, parent, c, left, right, top, bottom } } }
```

`record import --anonymize` (a file a player sent in) sets `char.name` and
`char.realm` to null and adds `char.id`, 8 hex digits of a SHA-256 of
"name-realm", which also replaces the name in the session key; no raw copy is
archived.

`t` = seconds since session start. Event kinds and fields:
`accept {q, title, qlvl, lvl, xp, map, x, y, npc, npcName, object}`,
`turnin {q, xpReward, money, lvl, map, x, y, npc, npcName}`,
`progress {q, oi, text, cur, max, map, x, y}`, `complete {q}`, `abandon {q}`,
`level {lvl, map, x, y}`, `zone {map, zone, subzone}`, `pos {map, x, y}`,
`kill {npc, npcName, map, x, y}`, `loot {item, itemName, count, map, x, y}`,
`gossip {npc, npcName, available: [q], active: [q], map, x, y}`,
`fp {location, npc, npcName, map, x, y}`, `taxi {from, to}`,
`bind {location, map, x, y}`, `trainer {npc, npcName, map, x, y}`,
`vendor {npc, npcName, map, x, y}`, `death {map, x, y}`, `mark {text, map, x, y}`.

Additive fields: `progress.type`; `kill`/`loot` may carry `q` and `oi`;
`accept`/`turnin` carry `object`/`objName` for game-object givers; `accept.item`
for item-started quests; `accept.rewardXp`/`rewardXpBase` (from the client's
`GetQuestLogRewardXP`, when cached); a `reward {q, rewardXp, rewardXpBase, lvl}`
event when the reward was not cached at accept, or for quests already in the log
at login; a session may carry `dropped: { kind: n }` when caps
were hit. Forever restricts `COMBAT_LOG_EVENT_UNFILTERED` to secure code, so
kills come from `UNIT_DIED`/`PARTY_KILL` correlated with objective progress.

Character progress: `skill {skill, skillLine, rank, max, map, x, y}`,
`rep {faction, factionName, standing, value, delta, map, x, y}`,
`explore {map, x, y, area, areaID, xp}`, `craft {spell, item, count, skill}`,
`learn {spell, name}`, `achieve {id, name, already}`. Session dumps from
`/psrec factions|skills|legacy`: `factions: { "<id>": { name, order, parent,
header, headerRep, standing, value, min, max, atWar, canToggleAtWar } }`,
`skills: { "<skillLine>": { name, order, rank, max, category, categoryID } }`,
`legacy: { categories, achievements, majorFactions, trees }`, each time-stamped
in `dumped: { kind: epochSeconds }`.

Route telemetry (`v = 1`), recorded while Polestar runs: `step {v, reason,
guide, step, title, guideTitle, time, lvl, xp, xpMax, rested, money, combat,
map, x, y}` with `reason` = `login` (session start or /reload), `step`
(`STEP_CHANGED`), `guide` (`GUIDE_CHANGED`: tab switch or new guide) or
`complete` (`GUIDE_COMPLETED`; no `step`). Only the active tab is snapshotted.
Also, with or without Polestar: `combat {on}` (`PLAYER_REGEN_DISABLED/ENABLED`),
`afk {on}`, `revive` (alive again after a `death`).

#### Measuring routes

Recording is opt-in (`PolestarRecorderDB.enabled == true`, set by `/psrec on` or
Options > Recorder); while it is off the Recorder writes nothing, not even a
session. Testers turn it on, play with Polestar, run `record import`
(or keep `record watch` running), then `record report [--guide <text>]
[--json] [--top n]`. The report rebuilds step passes from every session and
character:

- Play time between consecutive events counts up to 5 minutes; time flagged
  AFK counts zero; time between sessions counts nothing. A `/reload` costs its
  few seconds and continues the step.
- Per character and guide, a frontier step: a later step closes its pass and
**Instances.** npcs and objects inside a dungeon or raid get `instances`
(instance map ids). QuestieDB gives them no coordinates, only their areas
(`{ [areaId] = { { -1, -1 } } }`): an area's instance is its Forever
`AreaTable` ContinentID when that `Map` row is InstanceType 1 (party) or 2
(raid); without the `Map` table (an optional Forever table), an area no UiMap
shows on a continent other than 0 and 1. Recorded `inst` fields add to them.

  opens the next; returning to it (tab switch, reload, new session) continues
  the pass; an earlier step (Prev, Goto back, a step un-done) is a revisit,
  reported apart. Completion closes the last pass; passes still open are
  shown as `open` and kept out of the statistics.
- XP from the snapshots, as cumulative XP (recorded `xpMax` per level, else
  the 1.12 table), so level-ups inside a step count in full.

Per step: passes, median/p75 time, XP, XP/hr, combat share (the rest is
mostly travel), deaths, turn-ins, travel yards (taxis and jumps faster than
40 yd/s excluded), revisits. Per guide: time (completed runs), levels gained,
XP/hr. Then three lists: slowest steps by XP/hr; steps at least twice and
2 minutes over the guide's median step time (compiled packs carry no time
estimate to compare against); detours, steps with 600+ yd of median travel and
no XP or a third of the guide's XP per yard.

### Route planner (`planner`)

`node tools/polestar.js planner [<pack dir>...] [--port 8078] [--nav <dir>]` serves a local
page (127.0.0.1 only) that plays a guide route on the game's map and edits its
`.guide` sources. Inspired by Nivek_Gaming (@Nivek_Gaming on X), whose idea
the planner and the navigation grid both come from.

- **Coordinates** (`tools/lib/planner/geo.js`): world `{ c, wx, wy }` (the
  client's yards, `c` the instance map), map percent per frame (`f = "e"` Era,
  else live), and the renderer's plane `X = -wy`, `Y = -wx`.
- **Map art** (`planner art`, `tools/lib/planner/art/`): the Forever client's
  minimap blocks (WDT `MAID`, 8th field; ADT tile `(col, row)` =
  `map<col>_<row>.blp` = WDT entry `row * 64 + col`) and zone map art (UiMapArtTile plus
  every WorldMapOverlay), fetched by fileDataID from wago.tools into
  `data/sources/casc/<product>/<build>/`, built into `data/local/planner/art/`:
  `index.json`, a BC1 pyramid of 512 px tiles with 8 mips each (level 0 one
  ADT block, level 6 the whole grid; missing blocks in the map's sea colour),
  and one unfogged PNG per zone over its live frame. Local only, never shipped.
- **Playback** (`tools/lib/planner/timeline.js`): plays compiled guides goal
  by goal for one character with the simulator's priors (walk x detour, kill
  time by level gap and class, talk and use times, drop rates, flights over
  `travel.json` legs at 30 yd/s, boats with their waits, hearth with its
  cooldown, `levelOverhead` per level) and `tools/lib/game/xp.js`. The
  Timeline holds per step its times, split (travel, combat, interact, wait),
  levels, XP, goal places and spawn areas, the character's state at its start,
  plus a position track and events.
- **Edits** (`tools/lib/planner/source.js`, `goalfmt.js`): the parser records
  each goal's token spans (`goal.spans`, non-enumerable, so nothing compiled
  changes); edit operations rewrite only the tokens they change, regenerate a
  goal line from its fields when a form changes it, move steps and goals with
  their comments, and add an explicit `zone` line wherever a move would
  change the zone a goal's coordinates are read in. A result that parses worse
  than its input is refused.
- **Commands** (`tools/planner/commands.js`): one registry served as
  `POST /api/cmd`, as MCP tools (`planner mcp`: stdio JSON-RPC that proxies to
  a running planner or starts one) and, where the browser has it, WebMCP.
  Edits name the file's hash and are refused when it changed; they write the
  file at once, keep an undo history and are pushed to the page over
  `GET /api/events` (SSE), as are external changes (fs.watch). A full lint
  runs in a worker thread 600 ms after changes; `pack_compile` writes the
  addon folder as `compile` does. The server answers only requests naming it
  in Host, runs only JSON POSTs from no Origin or its own, refuses an icon
  GET (which may fetch from wago.tools) that the browser marks as another
  site's, and forbids framing (`X-Frame-Options: DENY`,
  `frame-ancestors 'none'`).
- **Navigation** (`tools/planner/navpool.js`; the grid itself: "Navigation
  grid" below): with a navigation grid (`data/local/nav`, `nav build`) every
  walk of the playback is routed on it with the character's movement profile
  (`tools/lib/nav/move.js` `profileFor`: mount from `mountLevel`, Ghost Wolf,
  Travel and Aquatic Form, Cheetah, indoor rules): the legs (to a goal's
  place, a boat, a flight master, a spawn pool away from the character) and
  the hops between spawn points inside a kill, collect or interact area
  (picked nearest first as before; kill and loot time stay the priors').
  `buildTimeline({ routes })` takes a synchronous route provider: a routed
  walk takes the route's seconds, its track follows the route's points (a
  leg with a mode per segment: swim, fall, climb, lift, indoor; a hop in
  fight mode), and the goal records `route { yards, byClass, falls }`; a
  walk the grid cannot route, or one not computed yet, keeps the
  straight-line estimate (a hop the spacing model's walk) and marks the goal
  (`estimate`, `routeReason`) and its step. Totals count `legs`, `routed`,
  `hops`, `hopsRouted`, `routeSeconds` and `estimateSeconds`. Flights keep
  their time and, with `flightPaths` (the Era client's TaxiPathNode points of
  each travel.json taxi leg, read from the cached
  `data/sources/wago/<build>/TaxiPathNode.csv`), their track follows the
  points the flight takes. The workspace builds a
  timeline with the cache as provider; the legs it misses (ends quantised to
  1 yd, plus the profile's speeds) are computed in a `worker_threads` pool
  (one Nav per worker; CPUs - 1, at most one per 4 GiB) while `timeline_get`
  answers at once with the straight legs and `routing { pending, done }`
  (SSE `routing` each second); when they are all in, the cached timeline is
  dropped and SSE `changed { timeline: true }` makes a page whose timeline is
  still being routed ask again (as does an SSE reconnect, and, when no
  `routing` event for its timeline arrives within 10 s, the page itself).
  Routes are appended to `data/local/nav/routes-<build>.jsonl`, `build`
  being a hash of the grid's `index.json`, `lifts.json` and the route code,
  so restarts are warm and a rebuilt grid (or edited costs) starts afresh;
  the timeline cache key holds the build. The choice between walking and a
  boat or a flight master still compares straight-line times.
  `nav_route` routes one walk for an agent; `GET /nav/index.json` lists the
  grid's tiles, `GET /nav/tile/<c>/<col>_<row>.png` draws an ADT tile's
  Walkable layer (per column: nothing walkable, steep, climb, swim only,
  indoor only; plain ground clear), and `GET /nav/aids.json` serves the
  arrow aids (`nav aids`, crossings schema) as world points.

### Navigation grid (`nav build`)

`node tools/polestar.js nav build [--continents 0,1] [--force] [--offline]`
builds `data/local/nav` from the Forever client's own files, fetched by
fileDataID from wago.tools into `data/sources/casc` (local, never shipped):

- **Geometry** (`tools/lib/nav/geom`): per map tile, the root ADT's terrain
  (heights, low- and high-res holes, area ids) and MH2O liquids, and the obj0
  ADT's WMO and M2 placements, each model's collision (WMO faces by the
  collision and render flags, indoor groups; M2 collision triangles) and WMO
  liquids, placed with the client's transform (checked against MODF extents).
- **Grid** (`tools/lib/nav/grid`, constants and file layout in `format.js`):
  2.0833 yd columns (256 per tile), walkable surfaces with 1.6 yd clearance,
  walls (model faces of 80° and steeper) stored per column side; links for
  steps, slopes (terrain to 35° plain, 35-50° and 50-60° slow, 60-80° climbed
  upward only; models to 50°), WMO staircases (treads under the upper
  column's top rising at most 1 yd walk as a slope to 45°; steps whose top
  rise is up to 1.6 yd over treads rising at most 1 yd, 2.6 yd in all, are
  a jump: the Ruins of Lordaeron's throne room into the Undercity's lift
  halls), jumps to 1.6 yd, falls (free under 14.57 yd,
  then the servers' damage share `0.018 h - 0.2426`; at most 30 yd onto
  ground and 60 yd into water; landing only on stable ground), swims and
  lifts (elevator objects of `data/forever` at their car's travel from the
  client's TransportAnimation); regions; a per-tile graph per movement class.
  Fatigue water is never swum: MH2O's deep quads (the server's fatigue; a
  chunk of ocean without attributes is deep throughout, `geom/mh2o.js`)
  give a blocked swim surface (`SWIM | BLOCKED`), so no route crosses open
  sea while swims along a coast and across shallow water stay.
- **Routes** (`tools/lib/nav/path.js`, API in its header; `move.js` the
  profiles): `snap` picks the surface for a map point (without a height, a
  point over an indoor floor takes that floor or one level with it beside
  it: an innkeeper behind a counter gets the inn's floor, not its roof or
  the terrain under the city, never the storey below; then indoor floors
  before terrain, never a ledge one only falls onto), `route` minimises time for a
  character (run, swim, mounts, Travel Form, Ghost Wolf, Cheetah, indoor
  rules, slope, fall and lift costs) with a direct search for near ends and
  the per-tile graph otherwise, then smooths the path; `los` tests a
  straight walkable line. `nav path` prints one route.
- **Packing for the in-game engine** (`nav pack`, `tools/lib/nav/pack.js`,
  rules in its header): the grid as Polestar's walking maps (format 2,
  grown from Shortest Path Forever's walking-map format: his baker's HPA*
  and encodings, ported), which the router in `Polestar_Nav` (started from
  his engine) routes on. Each SPF cell (128 per tile by default, 4.17
  yd) holds the connected pieces of our surfaces in its columns (base plus
  floors; a wall inside a cell keeps its sides apart); a step between cells
  is open only where one of our links crosses it, so walls and cliffs close
  it; falls and lifts stay out (lifts are his transports), and so do
  climbs (60-80°, one way up). Faces are held back: steep links (50-60°)
  and terrain links inside a run of triangles over 50° (Forever's client
  slides off them) rising more than a jump, or on ground steeper than 50°
  measured 8 yd across. His steps are two-way and cost
  their flat length, so a face packed as steps was a straight line up it
  (Fitz's report: the Raptor Horns slope in the Barrens, 61.66,35.46 to
  61.00,33.70, where the columns and cells averaged 51-56° triangles to
  under 50°). A face link is opened again only when it is the only way
  between two parts of the map (union-find over every other join, then the
  face links gentlest first), so nothing reachable before is lost and a
  face with a way round is walked round; closing them all cut off 84 guide
  goals. A cluster (one tile) border gets his entrances, one in every run
  of crossings between the same two regions (~38 crossings at 128 cells, a
  cell crossing straight and both ways diagonally, so about every 54 yd on
  open ground), and one more on every road crossing it with none of his
  within 8 yd: every walk across a border goes through an entrance, and
  where the border crossed Ratchet's north-east road 35 yd from the main
  road with the one entrance on the main road, walks left the road along
  the border (Fitz's report, 2026-10-16). A run of dry crossings (ground
  on both sides, no swim surface) that no entrance crosses dry gets one
  too: land and the water it wades into are one region, so his entrance
  can fall in the water beside a beach or a pier's root, and walks from
  Auberdine to its boats swam 200 yd across the bay to the pier because
  the beach crossed the tile border x = 6400 with no dry entrance
  (Fitz's report, 2026-10-17). An intra-cluster edge is pruned only for a two-hop path whose
  hops are both shorter (gen_nav.py's 2% rule let two entrances a few yards
  apart at the end of a long walk prune each other's edge, cutting a region
  in two; it cut 14 guide goals off with faces held back, Thunder Bluff's
  among them). A route down a face goes round as well. Every surface
  carries a ground class byte (normal, road, gentle slope, steep slope,
  indoor, indoor city, plus an Alliance and a Horde hub bit): the steepest
  terrain triangle under it (grid format 4's tslope) against the slope
  bands, the indoor flag (indoor city where the chunk's area or the zone
  map around it is a capital, AreaTable `Flags_0 & 0x100`), the roads layer
  and the hubs layer (`nav layers`, a hub bit on every cell a hub disk
  touches); `Routing/Costs.lua` (mirrored in `tools/lib/nav/costs.js`)
  prices a step by it, per faction, and every graph edge carries its cost
  for Alliance, Horde and no profile and its yards. `chokepoints.js` adds `Chokepoints.lua`
  (`PolestarNavChokepoints[map]`: lift landings, bridges, gates at passages,
  tunnels, cave and building mouths, passes, each named by its AreaTable
  area) for the journey's named walk steps.

## Tests

Layers, stubs, helpers and the tests that need local data: [tests/README.md](../tests/README.md).

`npm test` = `node --test "tests/**/*.test.js"`. Lua runs under real `lua5.1` through
`tests/helpers/lua.js`, which loads `tests/lua/wow_stub.lua` and then the
addon files listed by the TOC/XML manifests. Extend the stub per module in
`tests/lua/stub_<module>.lua`; `wow_stub.lua` holds only the generic client
pieces every module shares. Keep tests deterministic and behavioural.

Performance is tested, not assumed. `tests/perf.test.js` loads the whole addon
with every module on and the local data packs, and holds these budgets of addon
CPU time (event handlers, message listeners, OnUpdate scripts, timers): a
`accept`/`turnin` also carry the quest frame's rewards when it shows any:
`items` and `choices` (item ids, `GetQuestItemInfo`) and `rewardMoney`.

Finds (`Finds.lua`), for what the client tables cannot give the Codex:

- `rare {npc, npcName, cls, npcLvl, src, map, x, y, inst}`: a unit whose
  `UnitClassification` is `rare`, `rareelite` or `worldboss` (`src`
  `nameplate`, `target` or `mouseover`, the player's position), or the
  creature behind a vignette (`src` `vignette`, the vignette's position, `cls`
  only when the unit was seen). Once per npc per 50 yards per session.
- `treasure {object, objName, src, map, x, y}`: the game object behind a
  vignette, de-duplicated the same way.
- `slain {npc, npcName, cls, npcLvl, map, x, y, inst, diff, denied?}`: a
  creature the player or pet killed (`PARTY_KILL`), or whose corpse the
  player looted; `denied` when `CanLootUnit` a second later says it has loot
  the player may not take (tapped, round-robin).
- `drop {npc|object, npcName, items: [ { item, n, q? } ], gather?, inst,
  diff, map, x, y}`: one loot window per source (`GetLootSourceInfo`, else
  the dead target), each corpse or object once per session; `q` marks quest
  items, `gather` (`herb`, `mine`, `skin`) a window a gathering cast opened.
  Fishing is left out.
- `enter {inst, instName, instType, diff, map, x, y}`: zoning into a dungeon
  or raid (`GetInstanceInfo`), with the last outdoor position (taken at
  `PLAYER_LEAVING_WORLD`) as the entrance.
- `encounter {enc, encName, diff, size, ok, inst, npcs, map, x, y}`:
  `ENCOUNTER_END`; `npcs` are the bosses its `encounterUnitStatus` lists,
  else the creatures that died since `ENCOUNTER_START`.

`data build` reads every session's finds together, so counts merge across
sessions (`tools/lib/data/recordings.js`, `createFinds`):

- npc `rank` from the latest classification (`rare` 4, `rareelite` 2,
  `elite` 1, `worldboss` 3, `normal` 0); levels widen `level`/`levelMax` to
  what was seen; rares and vignette creatures get the `rare` role.
- Drop chance (items `drops`, percent, two decimals) = windows holding the
  item / kills of the npc (`slain` without `denied`, never fewer than its
  windows); for objects, windows holding it / windows opened. From 10 kills
  or opens up it replaces pfQuest's or QuestieDB's chance, below that it only
  fills a missing or unknown (`null`) one; `seen` keeps `{ n, of }` either way. Skinning windows
  are no drops.
- An object whose window held a non-quest item, or seen behind a vignette,
  gets the `chest` role; gathering windows give `herb` or `mine`.
- Sighting and opening positions join the entity's spawns: a map without
  spawns gets them as `"l"`, a live-frame map takes them in, and so does an
  Era map whose frame Forever kept (`meta.liveFrameMaps`). Kill positions
  only fill a map without spawns.
- `inst` adds to `instances`; encounter bosses get `encounter`; entries and
  encounters fill `instances.json` (entrances clustered within 1.5 map
  percent, the most used first; encounters with their bosses and wins).
- Quest `rewards` from the frames, a turn-in's over an accept's.

`meta.counts` gives `recordedKills`, `recordedLoots`, `recordedSightings`,
`recordedDropChances`, `recordedTreasures`, `recordedInstances` and
`recordedEncounters`.
burst of 50 `QUEST_LOG_UPDATE` and 50 `BAG_UPDATE` in one frame under 4 ms, a
walking frame under 1 ms, `SetGuide` and every step change of a leveling
guide under 8 ms (with what they schedule), and a gathering guide played to
the end in under 15 s. When one fails, `node tests/helpers/profile.js
<guide> [race] [class] --packs [--sample=1000]` plays a guide with every
handler timed by module (`tests/lua/profile.lua`) and, with `--sample`, a
stack sampler for the functions and lines that cost the time.
