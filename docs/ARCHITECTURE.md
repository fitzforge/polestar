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
| `Polestar_Guides` (`addon/Polestar_Guides/`) | Polestar's own guide pack (pack id `guides`) | `compile`, from `guides/` | yes (generated) | yes |
| community guide packs | Addons by other authors (`X-Polestar-Pack` in their TOC; `docs/PACKS.md`, `docs/PACK_FORMAT.md`) | the same compiler, from their own repositories | in their own repositories | by their authors |
| `Polestar_ItemDB` (`addon/Polestar_ItemDB/`) | Item stats and Forever reward choices for the gear advice; loaded on demand | `itemdb build` (`Items.lua`), then `gear build` (`Forever.lua`) | yes (generated) | yes |
| `Polestar_QuestDB` (`addon/Polestar_QuestDB/`) | The quest database behind quest markers and tooltips; loaded on demand | `questdb build` | no (local, gitignored) | yes, when built |
| `Polestar_Codex` (`addon/Polestar_Codex/`) | Lookup's Codex, and the Dungeons and Rares data; loaded on demand | `codex build`, from release-safe inputs (`--local-extras` builds a local-only one) | no (generated, gitignored) | yes, always: `pack` fails without it |
| `Polestar_Travel` (`addon/Polestar_Travel/`) | Zone crossings for the travel planner, from an optional local crossings file; loaded with Polestar | `travel build` | no (local, gitignored) | no, never packaged (Nav, "Travel planner and zone crossings") |
| `Polestar_Recorder` (`addon/Polestar_Recorder/`) | The optional standalone recorder of play sessions, for authoring | hand-written | yes | yes, as its own zip |

A guide goes from a `.guide` file to the game in four steps. An author
writes it in a guide pack (`guides/` for Polestar's own). `lint` and
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
```

Manifests use only `<Script file="..."/>` and `<Include file="..."/>` (paths
relative to the XML file, backslashes allowed). The test harness parses the
TOC and these manifests, so tests always load exactly what the client loads.

### Globals

Only these globals may be assigned anywhere under `addon/` (enforced by
`tests/syntax.test.js` via `luac -l`):

`Polestar`, `PolestarDB`, `PolestarCharDB`, `PolestarRecorderDB`,
`SLASH_POLESTAR<n>`, `SLASH_POLESTARREC<n>`, `BINDING_HEADER_POLESTAR`,
`BINDING_NAME_POLESTAR_*`.

Everything else is `local` or lives on the `Polestar` table. Named frames must
be prefixed `Polestar`.

## Core

`local ADDON, ns = ...` in every file; `Polestar = ns` is set once in
`Core/Init.lua` (first file loaded). Guide packs reach it as the global.

### Lifecycle

```lua
Polestar.OnInit(fn)    -- ADDON_LOADED("Polestar"). Settings defaults are merged.
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
| `STEP_UPDATED` | stepIndex | Engine (goal status/progress changed, same step) |
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

`PolestarDB = { schema = 1, settings = { [section] = { ... } }, packs = { [packId] = { off = true } }, welcomeSeen = 1 }`
`PolestarCharDB = { schema = 1, guide = id|nil, tabs = { guideId, ... }, activeTab = n, absentAt = { [guideId] = place }, manual = { [guideId] = { ["s:g"] = true|"tick" } }, skipped = { [guideId] = { [stepIndex] = true, ["s:g"] = true } }, pins = { [guideId] = { step, done } }, offers = { [questID] = level }, shapes = { [guideId] = shape }, stepKeys = { [guideId] = { hash, ... } }, flags = { fp = { [name] = true }, ... }, welcomeSeen = 0|1 }`

`packs[<id>].off` hides a pack's guides account-wide (the Guide packs page's
switch). `welcomeSeen` (UI/Welcome.lua) is the version of the welcome last
seen: in `PolestarDB`, the account has had its welcome (later characters skip
its Set up page); in `PolestarCharDB`, this character has (0 while due).
`behavior.suggestFrom` (default `"guides"`) is the pack suggestions come from.
Modules keep their own keys beside these (`rares`, `instances` account-wide;
`ui`, `routes`, `classTrainLevel`, `qol`, `flightTimes`, `flightNow`,
`instanceRuns` per character), each described in its section or file header.

`manual` holds the player's ticks (`"tick"`, any goal but a note) **and**
latched results (`true`): NPC interactions (talk/train/vendor) are latched
during their step, and conditions that can stop holding later (goto,
sethome, hearth, fly, getfp, buy, bag-count collect) are latched once the
route moves past their step, so leaving a zone or rebinding the hearthstone
never drags the guide backwards. Quest goals are never latched: abandoning a
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
registered commands. Core registers: `guides`, `options`, `show`, `hide`,
`next`, `prev` (look at the next/previous step; nothing changes), `skip`
(skip the step shown, for good), `reset` (clear ticks, latches, skips and
the saved view for the current guide), `guide <id>`, `status`, `tabs`,
`tab <n>`, `close`, `path` (the route choice), `welcome` (`SHOW_WELCOME`),
`packs` (Options at Guide packs), `where`, `report` (`SHOW_REPORT`),
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
Polestar.Errors() -> { { msg, count }, ... }   -- this session's, oldest first, the last 5 kept
Polestar.DiscordURL           -- the Polestar Discord's invite
```

Every message and game-event handler, init and login callback and command
runs through `SafeCall`, and Hooks' callbacks through their own `pcall`, so
the errors Polestar catches are noted by their first line, counted, for the
report a player copies (UI, "Reporting a problem"). Polestar never replaces
the game's error handler: wrapping it would shift the stack the game and
!BugGrabber show for every error.

### Localisation

`Polestar.L[key]` (enUS only for now; missing keys return the key).

### Compat — every client API call goes through here

UI, Nav and Engine never call quest/map/unit client APIs directly; they call
`Polestar.Compat`. That keeps Forever specifics in one file and lets other
modules' tests replace Compat with a fake.

Coordinates: map percent `x, y` in **0–100**. World coordinates follow
`C_Map.GetWorldPosFromMapPos`: `wx` is the north–south axis (larger is north),
`wy` is the east–west axis (larger is west), in yards.

```lua
Compat.IsSecret(v)              -> bool   (a secret value: comparing, indexing or parsing it throws)
Compat.Readable(v)              -> v | nil (a secret value reads as unknown)
Compat.Now()                    -> seconds since the epoch, server clock
Compat.GetPlayerInfo()          -> { name, realm, guid, level, xp, xpMax, race, class, faction }
                                   -- race = raceFile ("Human","Scourge",...), class = classFile ("WARRIOR"), faction = "Alliance"|"Horde"|"Neutral"
Compat.GetPlayerMapPosition()   -> uiMapID, x, y | nil      (nil in instances / unknown)
Compat.GetPlayerWorldPosition() -> continentID, wx, wy | nil  (via MapToWorld of the above)
Compat.MapToWorld(uiMapID, x, y, frame) -> continentID, wx, wy | nil
                                   -- frame "e": use registered Era frame for uiMapID (see Map frames); nil: live client
Compat.WorldToMap(continentID, wx, wy, uiMapID) -> x, y | nil
Compat.GetMapName(uiMapID)      -> string | nil
Compat.MapName(uiMapID)         -> string | nil   (the client's name, else the Codex zone's)
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
Compat.GetItemCount(itemID)            -> number
Compat.GetItemQuality(itemID)          -> 0..7 | nil (nil while not cached)
Compat.ItemQualityHex(quality)         -> "ffrrggbb" | nil
Compat.GetBindLocation()               -> string | nil
Compat.IsOnTaxi()                      -> bool
Compat.GetCurrentTaxiNode()            -> name of the open taxi map's node | nil
Compat.GetNpcID(unit)                  -> number | nil   (from UnitGUID)
Compat.InCombat()                      -> bool
Compat.IsInInstance()                  -> bool
Compat.IsShiftKeyDown()                -> bool
Compat.Supports(feature)               -> bool   ("skill" | "spell" | "faction" | "explore" | "achievement")
Compat.GetSkillRank(skillLineOrName)   -> rank, maxRank | nil  (profession/secondary skill)
Compat.IsSpellKnown(spellID)           -> bool
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
default point.

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

| `t` | Required | Optional | Done when (Engine) |
|---|---|---|---|
| `accept` | `quest`, `title` | `npc`/`npcName`, `object`/`objName`, `item`/`itemName`, `minLevel`, `qlvl`, `pre`, `preAll`, `closedBy`, `preTitles` | on quest **or** completed |
| `turnin` | `quest`, `title` | `npc`/`npcName`, `object`/`objName`, `rewards = { choices = { { item, itemName, quality } }, items = { ... }, xp, money }` (copper) | completed |
| `complete` | `quest`, `title` | — | ready for turn-in or completed |
| `kill` | `target` | `npc`, `count`, `quest`, `oi` | objective `oi` finished, or quest ready/completed; without `quest`: manual |
| `collect` | `item`, `itemName` | `count`, `quest`, `oi` | objective finished / quest ready / completed; without `quest`: item count ≥ `count` |
| `goto` | `map`, `x`, `y` | `text`, `r` (default 8 yd) | within radius, **or** any later goal in the step is done |
| `talk` | `npc`, `npcName` | — | gossip/quest frame opened with that NPC during this step; else manual |
| `interact` | `object`, `objName` | `quest`, `oi` | objective state if `quest`; else manual |
| `use` | `item`, `itemName` | `quest`, `oi` | objective state if `quest`; else manual |
| `sethome` | `location` | `npc`, `npcName` | `GetBindLocation()` equals `location` (case-insensitive) |
| `hearth` | `location` | — | zone or subzone equals `location`, else manual |
| `getfp` | `location` | `npc`, `npcName` | taxi map opened at that flight master (persisted in `flags.fp`), else manual |
| `fly` | `location` | — | zone or subzone equals `location`, else manual |
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
quests those name, for the reason texts). `only !Class` compiles to the list of
the other eight classes, so compiled guides never contain negations.

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
  until that addon's `ADDON_LOADED`; guides registered before their pack wait
  in a per-pack list until it comes.
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
Polestar.Engine.ToggleGoal(stepIndex, goalIndex) -> bool   -- tick any goal but a note done, or clear its check-off
Polestar.Engine.SkipGoal(stepIndex, goalIndex) -> bool     -- skip an optional goal, or bring it back
Polestar.Engine.AimGoal(stepIndex, goalIndex) -> bool      -- lead the arrow to a goal of the current step (row click)
Polestar.Engine.GetWaypoint() -> waypoint | nil
Polestar.Engine.GetProgress() -> doneSteps, totalSteps
```

#### Smart logic

- **Candidate goals.** A compiled goal may carry `candidates = { { npc, npcName, map, x, y, f, faction = "A"|"H"|"AH", races?, classes? }, ... }`
  (from `train <Profession>`, `train class`, `buy … nearest`, `vendor nearest`, `sethome nearest`; see GUIDE_FORMAT).
  The Engine filters by the character's faction (and races/classes when given),
  then picks the cheapest by `Polestar.Nav.EstimateTravel(from, to)` seconds when
  Nav provides it, else world distance on the same continent with a large penalty
  across continents. It re-picks on step start, zone change and landing, never per
  frame. The goal view then carries the chosen `npc`, `npcName`, `map`, `x`, `y`,
  `f`, plus `alternatives = n`; `Polestar.Engine.CycleCandidate(stepIndex, goalIndex)`
  moves to the next-best one. Profession `train` goals are done when the
  profession's max rank reaches that rank's cap (75/150/225/300), so a trainer
  anywhere counts. `train class` is done on opening a trainer window for any
  candidate during the step.
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
  grey for the character unless a later goal in the guide or its chain needs them.
- **Class-training reminder.** Class trainers ship in the core:
  `Core/ClassTrainers.lua` (generated by `node tools/polestar.js trainers build`,
  one trainer per town and class, with the Era frames of their maps) calls
  `Polestar.RegisterClassTrainers({ { npc, npcName, map, x, y, f, faction, classes }, ... })`.
  `Engine.NearestClassTrainer()` returns the best one for the character (same
  ranking as candidate goals) or nil. Opening the trainer window of one of the
  character's class stores `CharState().classTrainLevel = level` and fires
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
  taken, or one version of an exclusive chain when another was taken. Beyond
  that, when a gossip/greeting/detail window opens on an `accept` goal's NPC
  (any tab's current step) and the quest is neither offered, in the log, nor
  completed, the Engine marks that accept unavailable for the session, with a
  reason: `"level"` (below minLevel), `"pre"` (a `pre` quest not done, title
  given) or `"offer"`. An unavailable accept and the goals of that quest in the
  guide (objectives, complete, turnin) count as skipped, so the guide moves on
  instead of stalling. The session marks clear on level-up and on any quest
  turn-in. The view carries `unavailable = reason` and `unavailableText`.
  When such marks move the guide past a step during play, the Engine fires
  `STEP_SKIPPED`; the guide window's banner then reads "Skipped <quest>  ·
  <reason>" (one line per quest) until the step changes again, it is
  dismissed, or 20 seconds pass. With the window hidden it goes to chat
  instead. Placement at load never fires it.
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
NPC) is "here". So a hub step reads person by person, and a field step (goto
the camp, kill, collect) stays one group. A goal that does not apply to the
character (`only`, grey-skipped, never-had) joins the group around it instead
of starting one, so a class-only line between two goals at the same person
never splits that person's group.

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
it from the quest log:

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
  on level-up or a turn-in), a soft goal (goto, fly, getfp, train, vendor,
  hearth, sethome, talk, non-quest kill/collect/buy) in a step before the last
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

= the first goal in the current step that has coordinates and is `active` or
`pending`. Re-evaluation is event-driven and coalesced (≤ 10 per second);
`goto` arrival is polled only while the current step has an active `goto`.

Automation (setting `behavior.autoAccept`, `behavior.autoTurnin`, default
on; holding Shift suppresses): accept only quests that are `accept` goals, and
turn in only quests that are `turnin` goals, in the current or next two
steps; never choose among multiple rewards.

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
```

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
  `ui.font` (`game` by default | `inter`; CJK clients always the game font).
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
Polestar.Nav.SetTarget(map, x, y, label, f)   -- user picked a goal; overrides the engine waypoint until the step changes
Polestar.Nav.ClearTarget()
Polestar.Nav.GetTarget() -> waypoint | nil
Polestar.Nav.GetDistance() -> yards | nil      -- to an area target's edge, 0 inside it
```

Settings live under `nav.*`; `nav.distanceUnit` (`"yards"`, the default, or
`"metres"`) sets how distances read, and the arrow redraws its distance as
soon as it changes. Nav hides itself in instances, on taxis, and when
the target is on another continent (shows the zone name instead).

An area target (a waypoint with `area`, yards: a spawn area) is reached
anywhere within `area + r` of its centre; outside, the distance shown is to
the area's edge. A camp then shows the arrived state with the goal label. An
area objective (`search`) never says arrived: `Nav.Sample` returns "search"
and the arrow says "Search here", the goal label, and "Click the arrow for the
next spot". A left click on the arrow (not a drag) calls
`Nav.NextSpot([index])`, which asks the Engine (`CycleSpot`) for the next spot
while the target is the Engine's waypoint with `spots`. The `nav.target` pin
carries the `area`, so the world map draws the area's soft disc under the
target pin; the `nav.spots` layer (world map, under `nav.worldPins`) marks
every other spot of the target as a small pin (an `alt` spot smaller and
fainter, its tooltip "It also spawns here"); clicking one searches there next
(`Nav.NextSpot(i)`). TomTom's arrival distance is `area + r`.

While a `SetTarget` override is active the Engine keeps announcing its own
waypoint; `Nav.GetTarget()` is the point actually being guided to. Nav fires
`WAYPOINT_CHANGED` when it sets or drops an override. `ClearTarget` hides the
Engine's waypoint until the Engine announces a different one or the step changes.

### Pins — map and minimap icons for every module

```lua
Polestar.Pins.SetLayer(layer, pins, opts)   -- replace a layer; opts = { world = true, minimap = true, edge = false, scale = 1 }
Polestar.Pins.ClearLayer(layer)
Polestar.Pins.SetLayerVisible(layer, visible)
-- pin = { map, x, y, f, icon (Theme.Media name or texture path), size, minimapSize, color = { r, g, b, a },
--         tooltip = string | function(tooltip), onClick = function(button), priority,
--         glow (soft halo), ring = { r, g, b } (ring round the disc), backdrop (scrim disc), area (yards) }
```

Pins are drawn on the world map for the map being viewed (converted through Compat
for other maps) and projected on the minimap; `edge = true` clamps that layer's
out-of-range pins to the minimap rim. Pooled frames, distance-filtered, minimap
updates throttled; layers with hundreds of pins must cost nothing per frame when
the player stands still. Each layer indexes its pins by continent and 500-yard
grid square when it is set, so a minimap redraw visits only the pins around the
player; layer changes made in one frame share one minimap redraw on the next
(`GetMinimapFrames` runs a pending one first). Nav's own target pins are one layer. A pin's `area`
draws a soft disc of that radius (`Media/Nav/area`, the pin's colour at 0.32
alpha) under every pin on the world map (`PIN_FRAME_LEVEL_QUEST_BLOB`, own
pool, no mouse, sized in canvas units so it scales with the terrain); the
minimap shows the pin only.

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
map width / 60) yd, clipped to the map, 6 px under the pins in their own
no-mouse pool, at most 300. One 20 Hz driver runs only while dots show.
`nav.trailDots` (default on) with `nav.worldPins` / `nav.minimapPins` per surface.

### Travel planner and zone crossings

```lua
Polestar.Nav.PlanRoute(p) -> legs | nil, reason   -- pure; Nav/Travel.lua
Polestar.Nav.GetRoute() -> legs, ci               -- the live route and its current leg
Polestar.Nav.EstimateTravel(from, to) -> seconds   -- same planner, cached briefly
Polestar.Nav.RegisterTravelData(d, replace)        -- TravelData.lua: flight masters, flights, transports, inns
Polestar.Nav.AddTravelPaths(chunk)                 -- learned walking paths (nodes: c, wx, wy, gateway, uiMap)
Polestar.Nav.RegisterCrossings(d)                  -- zone crossings (merges; ids seen before are skipped)
-- leg = { kind = "walk"|"fly"|"boat"|"zeppelin"|"tram"|"hearth", from, to, label, seconds, rest,
--         radius (arrival yards at `to`), waypoint (true: `to` is a crossing or chain node) }
```

The planner is Dijkstra over the player, the target, known flight masters,
docks, the bound inn, learned path nodes and crossing waypoints. It orders by
a cost (the Hearthstone carries a 120 s margin on top of its time) and keeps
the real seconds of every leg apart, so `seconds`/`rest` (the arrow's ETA)
stay honest. Caps: 20000 pops, 40 ms, 1500 path nodes.

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
the data lists as `wild` (no crossing data, e.g. maps Forever added) walks as
before; any other map (a continent map, an instance) is placed in the
smallest known zone frame holding the point. Walk legs end at every crossing
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
inns from the client tables, learned paths, and crossings learned from zone
changes in recordings, `tools/lib/travel/crossings.js` `recordedCrossings`,
registered with `complete = false`: they refine a continent that has full
crossing data and change nothing elsewhere). Full crossing data comes from an
optional local crossings file, `data/local/crossings.json` (gitignored),
which the build validates and writes into the local data addon
`addon/Polestar_Travel` (gitignored; `## Dependencies: Polestar`, registers
with `RegisterCrossings` at load; installed when built, never packaged).
Without the file nothing is written and TravelData.lua never holds it.

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
  one `MapCanvasDataProviderMixin` provider per map frame (the world map, and
  the battlefield map once Blizzard loads it) added with `AddDataProvider`.
  `ZoneArt.FullOverlays` returns the overlay table only when it was built for
  the art the client shows (art ID and tile size). `Maps.UnexploredOverlays`
  subtracts the client's explored list (`GetExploredMapTextures`, matched on
  offset and size, since it returns no overlay IDs). An explored overlay is
  always left to Blizzard, so `isShownByMouseOver` overlays stay hover-only.
  The tiles are split by `ZoneArt.EachOverlayTile`, as
  `MapExplorationDataProvider` splits them, onto one frame at the exploration
  pin frame level. `tint` multiplies them by the Theme token `mapUnexplored`.
  The provider repaints on `MAP_EXPLORATION_UPDATED` and on theme changes.
- Coordinates: the world map's info bar shows the player and the cursor
  (`maps.coords`, `Maps/WorldMap.lua`). `maps.minimapCoords` adds a readout at
  the bottom of the minimap (`Maps/Coords.lua`, 5 Hz, repainted only when the
  tenth changes). Both use `Maps.FormatCoords`.
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
  `qol-upgrade` (success) on every upgrade, `qol-coin` (accent) on the best
  when nothing is an upgrade, a 2px accent frame with a shade keyline around
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
  A planner kind (`RegisterPlanner`, letters only; Dungeons' `pickup`) is
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

## Dungeons — dungeon quest journal and pick-up guide

The dungeon pages come from the Codex's instances (Toolchain, "Codex"): in a
release build the Forever client's tables and `data/forever/*.json`; with
`--local-extras` also `dungeons.json` (DungeonJournal).

The Dungeons section of the hub reads them through the Codex: `codex build` always runs
`tools/lib/codex/journal.js`, which writes one page per Codex instance into the
pack as `Dungeons1.lua` (a summary table per dungeon for the list, and the page
as Lua source compiled only when opened): the quests QuestieDB files under the
instance's areas (the areas on the instance's map and the outdoor areas of its
name, as the solo filter's instance classification reads them,
`tools/lib/sim/solo.js`) or whose objectives or starting item point into it
(plus, with `--local-extras`, `dungeons.json`'s), each with giver and ender
and their positions, our own objective line, chain, rewards (items with
quality and choice from recordings and ForeverLevelingBiS, XP from
`quests.json`, money, reputation) and, with `--local-extras`, DungeonJournal's
audited shareability; bosses in kill order with the quests tied to them;
entrances from the Codex, else the client's Map table (the corpse point, placed
on its zone). No loot tables. Runtime: `addon/Polestar/Dungeons/Dungeons.lua`
(`Polestar.Dungeons`: List, Get, Entrance, Quests, Quest, Bosses, Open,
GuideTo, GuideToPoint, ShowOnMap; `SHOW_DUNGEON`). `dungeons build` writes no
guides.

The pick-up guide is built in game (`addon/Polestar/Dungeons/Pickup.lua`):
`Dungeons.PickupPlan(key)` takes the page's quests that apply to the character
(faction, race and class masks through `Lookup.QuestBlock`, the page's class
list), not done, not in the log (those are `carried`), open by
max(level, the dungeon's lowest level), picked up outside from an NPC or object
(not from an item, not inside), and not a follow-up of another quest of the
page; each with its open prerequisites (`Lookup.QuestChain`: all of `pre`, one
of `preAny` this character can take, in the order they are done).
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
in a row are one step). The last step lists the carried quests as notes and
goes to the entrance. Nothing to take: nil, "nothing". The route is kept per
character (`CharState().dungeonPickup[key]`, the stop keys in order) and used
when the guide is rebuilt without a position. It is a Lookup planner kind
(`Lookup.RegisterPlanner("pickup", build)`): `Dungeons.PickUp(key)` ->
`Lookup.Guide("pickup", key)` registers it as `lookup/pickup/<key>` (pack
"lookup") and opens it in a new tab, and a saved tab of it is rebuilt at
ADDON_LOADED like Lookup's own; it is gated by `dungeons.enabled`, not
`lookup.enabled`.

## UI — guide window, hub and options

### Options registry

Any module adds settings to the options window without touching UI files:

```lua
Polestar.RegisterOptions({
  page = "Quests", icon = "icon-accept", order = 30,      -- sidebar page (created on first use)
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
    { kind = "keybind",  command = "CLICK PolestarTargetButton:LeftButton", label = "Target quest mob", help = "One line." },
      -- the key bound to a binding command: click, then press a key; right-click clears it
  },
})
```

Controls read and write `Polestar.Get/Set` (a keybind row sets the game's key
binding for its command instead, and saves the binding set);
`disabled = function() return bool end` is optional; registered labels and
help are searchable. Pages sort by `order`; Recorder and
About always close the list. A page or tab with no available control is left
out of the sidebar and tab row. Every row resets to its default on right-click.

The built-in pages are grouped by what the player is doing: **Guide** (10:
Window, Arrow & routes, Automation), **Appearance** (20: Colour & type,
Windows, Arrow), **Map** (30), **Questing** (40: Quests, Rewards & gear,
Buttons), **Discovery** (50: Lookup, Dungeons, Rares), **Quality of Life** (60:
Travel, Social, Vendors, Trackers), **Guide packs** (70, a custom page:
`UI/Packs.lua`), Recorder, About. The options window
declares every tab and section of the module-filled pages, in order, and the
modules register their controls into them by name (`page = L["Questing"]`,
`tab = L["Rewards & gear"]`, `section = L["Gear advice"]`): Quests, QoL and
Gear fill Questing; Lookup, Dungeons and Rares fill Discovery; QoL and Maps
(flight timer, instances) fill Quality of Life. On the **Map** page (Guide &
quests: Guide, Quest markers; Rares & travel: Rares and treasures, Dungeons and
travel; Zones: Zones, Coordinates) Nav, Quests, Rares and Maps place every map
and minimap setting. Old page keys (`guidewindow`, `navigation`, `automation`,
`quests`, `gear`, `lookup`, `dungeons`, `rares`, …) reach the page and tab that
now hold their settings (`ALIASES` in UI/Options.lua); a page's own key wins
over an alias.

The sidebar's page list is its own scroll area (`f.NavScroll`, `W.ShellNav`)
from 12px under the search to the footer bar's line, so the version and stage
chip below it are never crowded, whatever the page count, font or menu scale;
the selected row is scrolled into view. The hub shares it. Its items are
`{ key, label, icon, count, dot }`: `dot` puts a warning dot at the row's
right edge instead of the count (a page spec's `dot = function() end`, the
Guide packs page while a pack has problems), and `{ heading = true, label }`
is a muted heading over the rows after it, not a choice (the menu's "Guide
packs").

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
  selected guide's zone art, facts, progress, pitch, pros and cons, a favourite
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
  to left from the band's corner with the primary first: while
  `Dungeons.PickupPlan` holds quests to take, "Pick up the quests"
  (`DS.PickUp` -> `Dungeons.PickUp`: the guide opens in a new tab and the hub
  steps aside; the tooltip counts the quests and those in the log), then
  "Guide me to the entrance" (`Dungeons.GuideTo`) and "Show on map"
  (`Dungeons.ShowOnMap`); with none left, "Guide me to the entrance" leads
  and "Nothing to pick up" (shown while the page has quests for this side)
  says why in its tooltip and, clicked, in chat (`DS.NothingText`); no guide
  is built. Tabs Quests n, Bosses n, Map. Quests: a block per quest planned from the
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
  which starts", "Part of"), a line opening the quest. Map: the entrance and
  the quest givers on its zone painting. Blocks, rows, tiles, chips and cards
  are pooled; quest states refresh on QUEST_ACCEPTED, QUEST_REMOVED,
  QUEST_TURNED_IN and PLAYER_LEVEL_UP. `UI.DungeonsSection` exposes
  `Open`, `Home`, `SetBand`, `SetTab`, `SetFaction`, `ShowQuest`, `Shown`
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
- **Guide packs in the menu.** Our categories (Leveling, Professions, …)
  list only our guides; All, Favourites, Current, Recent and search cover every
  shown guide. A "Guide packs" heading in the sidebar (a `W.ShellNav` heading
  row), present only while a shown pack has guides, lists one entry per such
  pack (`pack:<id>`, "<title> · <author>"), its guides grouped as ours are.
  Pack guides carry their pack's title in rows and results; the details pane
  has a credits line for every guide ("By <author> · <pack title> <version> ·
  <licence>", plus the pack's `source`; ours "By Polestar"). The empty states
  name both Polestar Guides and guide packs.
- **Guide packs page** (`UI/Packs.lua`, Options order 70, `/polestar
  packs`): one row per `Guides.Packs()` record: title, credits, guide count,
  website as a `W.Link` (the address without its scheme; the click opens
  `UI.ShowCopy("<title> website", <address>)`), source, and a `W.Switch` (`Guides.SetPackShown`) or
  the status text ("turned off in the AddOns list" with **Enable and reload**,
  "not loaded[: <reason>]", "needs Polestar <v> or newer" (or "needs a newer
  Polestar"), "broken: registered
  no guides", "refused: <reason>"); with problems a warning chip, **Show**
  (the list) and **Copy report** (`P.Report`: pack, versions, client build,
  every problem). Then **Suggest guides from** (`behavior.suggestFrom`,
  `Guides.SuggestSources()`), what a guide pack is, and "Read more:" with a
  `W.Link` to docs/GUIDE_PACKS.md opening `UI.ShowCopy("Guide packs,
  explained", <address>)` (`ns.DocsURL()` with `GUIDE_PACKS.md` for
  `PACKS.md`: the TOC's `X-Website` + `/blob/HEAD/docs/GUIDE_PACKS.md`, else
  "docs/GUIDE_PACKS.md in Polestar's source"). While `Guides.ProblemCount() > 0` the page's sidebar row carries
  the warning dot (a page spec's `dot`). Nothing goes to chat.
- **Welcome** (`UI/Welcome.lua`, `SHOW_WELCOME`): centred, three pages under
  a starlit hero, with step dots, Skip, Back and Next in the footer: Hello,
  <name> (what Polestar does, then the guide window, the arrow and
  `/polestar guides`); Set up (quest automation, the guide at login, the
  colour scheme as cards that apply live); Start (the guide
  `Guides.Suggest()` picks on its zone painting, with its level range and
  pitch; the beta note while `ns.routesBeta`; the Discord invite in a copy
  box; what guide packs are; then Start guide, or Choose a guide without
  one, and Browse guides). Once
  per new character (`PolestarCharDB.welcomeSeen`: 0 for a character with no
  saved `PolestarCharDB` as Polestar loaded, `ns.IsNewCharacter()`; set seen
  silently for one with saved data and no flag), 2 s after login, never in
  combat, during a cinematic or over the route choice; a due welcome that never opened stays due
  for the next login, and one that opened is marked on the character as it
  opens (a /reload or logout with it up does not repeat it); one the intro
  cinematic closes comes back on its page when the cinematic ends. Set up is in it only while the account has not had its
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
  `map <id> @x,y live`); other guide packs that are on; and the errors
  (`Polestar.Errors()`, plus with !BugGrabber its errors this session in
  Polestar's files, `BugGrabber:GetDB()`), the newest three, counted, by
  their path from the AddOns folder. Every line is cut at 100 bytes, so at
  its longest the report fits one Discord message (2000 characters). Under
  it, Discord's mark, "Polestar on Discord" and "Get the invite", which opens
  the invite (`Polestar.DiscordURL`) in the copy window: the game opens no
  links for addons, so the report is the only text a member copies. What the
  player typed stays while the window is reopened on the same step. The
  hub's and the settings' sidebars carry the Discord's mark at the end of
  the version line (`UI.Report.SidebarLink(shell)`), which opens the invite like
  `/polestar discord` (`UI.ShowDiscord`, `SHOW_DISCORD`).
- **Per-character UI state** in `CharState().ui`: `recentGuides` (ids, newest
  first, at most 10), `favoriteGuides` (id -> true), `pickerSelected` (id).

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
  (vignettes: the distance; units: "in sight"), "Set waypoint" (the vignette's
  position, else the nearest known spawn) and "Show rare" (the section),
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

### Guide packs (pack mode)

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
| `playtest` | every guide to the end per class (`tools/lib/playtest.js`, also behind `tests/guides.test.js`) |
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
draws it (the menu and the route cards work without any guide pack), and it
registers through `ZoneArt.RegisterOverlays` the way `MapFrames.lua` and
`Maps/ZoneLevels.lua` register their generated tables.

### Codex (`codex build`)

`node tools/polestar.js codex build [--addons <dir>] [--offline] [--out <dir>] [--local-extras]`
merges `data/forever/*.json` (pfQuest, QuestieDB facts, recordings,
corrections, Wowhead and web XP facts), the Forever client's tables
(wago.tools, cached under `data/sources/wago/<build>/`), the installed
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
  whose name starts with it or is within two letters of it; "A and B"
  encounters name both). A boss's loot is its `items.json` drops at 1% or
  more, best chance first. The entrance (`chooseEntrance`): a recorded one
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
  recordings) belongs to it: its drops carry the instance. An instance's
  boss or mob the data ranks rare is not a rare unless RareScanner lists it.
  `--local-extras` takes the instances from AtlasLoot and `dungeons.json`
  instead.
- Wowhead Forever per entity (`tools/lib/codex/wowhead.js`, release build
  only, lowest precedence): `codex wowhead` fetches the NPC and object pages
  and item tooltips of what `data/local/codex-parity.json` lists as missing
  or different, and of our instances' bosses, one request at a time (1.5 s
  apart, a growing pause on 403/429), and caches each entity's facts under
  `data/sources/wowhead/codex/<npc|object|item>/<id>.json` for 14 days;
  `codex build` only reads the cache. From them: an NPC's level, rare rank and
  spawns where ours lack them (and the rares only Wowhead places), drops and
  object contents with chance = looted count / looted kills, and the
  reputation ("Requires <Faction> - <Standing>") and PvP rank ("(Rank N)") an
  item's Forever tooltip asks for. An instance also lists, after its
  encounters and by level, the NPCs placed inside that the data or Wowhead
  ranks rare or boss, or that alone drop an item of quality 2 or better at 5% or more.
- Rares and treasures: NPCs ranked rare (4) or rare elite (2) in `npcs.json`
  (pfQuest, QuestieDB, recordings), with their spawns and every drop the
  Codex knows; treasures are objects with the `chest` role, with their loot.
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
  and ForeverLevelingBiS), `instances.json`, `zones.json`, `factions.json`,
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
  `meta.parity`; without the internal build it claims none. `codex parity
  [--ours <dir>] [--against <dir>]` reruns the comparison. The report also
  lists what only play can fill and the Recorder event that fills it
  (Forever instances and their entrances: `enter`, `encounter`; Forever
  rares: `rare`, `slain` + `drop`; quest givers, enders, rewards: `accept`,
  `turnin`). On 2026-10-14 (Forever client 1.60.1.70338, the same
  `data/forever`):

  | Kind | Internal | Release matching | Match |
  |---|---:|---:|---:|
  | instances | 44 | 37 | 84.1% |
  | instance levels | 29 | 29 | 100.0% |
  | instance entrances | 14 | 13 | 92.9% |
  | bosses | 373 | 272 | 72.9% |
  | bosses with loot | 265 | 262 | 98.9% |
  | boss loot items | 2066 | 1671 | 80.9% |
  | drop chances | 20707 | 17770 | 85.8% |
  | rares | 413 | 387 | 93.7% |
  | rare positions | 363 | 357 | 98.3% |
  | rare levels | 387 | 387 | 100.0% |
  | rare loot | 14016 | 13816 | 98.6% |
  | treasures | 65 | 60 | 92.3% |
  | treasure positions | 31 | 31 | 100.0% |
  | treasure loot | 1548 | 1508 | 97.4% |
  | items with a source | 15967 | 15901 | 99.6% |
  | items: drop | 8806 | 8666 | 98.4% |
  | items: quest | 2092 | 2091 | 100.0% |
  | items: vendor | 2248 | 2248 | 100.0% |
  | items: object | 3288 | 3287 | 100.0% |
  | items: world | 4152 | 4145 | 99.8% |
  | items: craft | 1797 | 1797 | 100.0% |
  | items: container | 2095 | 2095 | 100.0% |
  | tabards | 40 | 40 | 100.0% |
  | mounts | 135 | 134 | 99.3% |
  | items: rep | 689 | 484 | 70.2% |
  | pets | 89 | 87 | 97.8% |
  | items: pvp | 763 | 451 | 59.1% |
  | journal quests | 929 | 880 | 94.7% |
  | quest givers | 641 | 628 | 98.0% |
  | quest enders | 680 | 671 | 98.7% |
  | quest rewards | 552 | 547 | 99.1% |
  | quest XP | 731 | 722 | 98.8% |
  | quest chains | 489 | 469 | 95.9% |

  The gaps: seven Forever instances AtlasLoot lists ahead of release are not
  in the client (no `Map` row); the Hall of Thanes' entrance stays
  different (QuestieDB's Ironforge 27.6,47.8, where Wowhead Forever's
  comments put the quest givers "near the entrance", against 43.5,52) until
  a recording settles it; AtlasLoot's extra bosses (the Ring of
  Law's fighters, rare spawns, chests) are not `DungeonEncounter` rows;
  reputation standings that vendors gate in gossip, and battleground rewards
  AtlasLoot files as PvP, are in no client table (`ItemSparse` carries no
  `MinFactionID` or `RequiredPVPRank` for them); 26 Forever rares no
  database ranks yet.

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

`professions.json` is built by `profession build` from Blizzard's Era DB2
(SkillLine, SkillLineAbility, SpellName, SpellEffect, SpellReagents, ItemSparse,
Item, ItemEffect, ...). Each profession also carries `mainTrainer { Alliance,
Horde }` and `materials { itemId: { name, buy, buyCount, sell, quality,
vendors { A, H }, limitedVendors { A, H }, madeBy, gather { herb, mine, fishing },
drops, dropCount } }`; ranks carry `minSkill`, `spell`, `trainers { A, H }` and,
for secondary skills, `book`/`quest`; recipes may carry `enchant`,
`learnedAtEstimated`, `requires` (specialisation), `reputation { faction,
standing }`, `tools`, `focus`, `races`, `classes`, `skillUps`. Season of
Discovery recipes (spell id ≥ 400000) are excluded.

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
`xpSamples` (how many recorded observations back `xp`); event objectives `map`,
`f`, `x`, `y`; npcs `levelMax`, `rank`, `roles` (flightmaster, innkeeper,
vendor, trainer, ...), `subName`; objects `roles` (herb, mine, chest, ...); items
`containers` (items that contain it), `questItem: true` (QuestieDB item class 12:
drops only while on the quest). A drop chance is `null` when QuestieDB lists the
dropper but no source has a rate. From QuestieDB, each only when it has a
value: quests `preAll` (all must be done; preQuestGroup), `preAny` (any one
suffices; preQuestSingle), `breadcrumbFor` (the quest this optional breadcrumb
leads to), `breadcrumbs` (breadcrumbs leading here), `parent` (must be active;
parentQuest), `children` (childQuests), `requiredItems` (needed, not
objectives), `sourceItem` (handed over at accept), `maxLevel`, `skillLevel`,
`repeatable`, `reputation { faction, value }` (an objective), `area` (AreaTable id
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
   `--no-wowhead` skips them): the quest list of every zone and city page and
   of the nine class pages (class quests are filed there, not under a zone) on
   wowhead.com/forever (cached a day in `data/sources/wowhead/zones.json`;
   `--offline` reads the cache). A quest Wowhead marks updated with "Experience
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
   after the merge, and the record's `source` gains `polestar-correction`. One
   cleanup is general rather than per quest: `pre`, `preAll` and `preAny`
   never contain the quest itself or an id from its `excl`. QuestieDB
   preQuestSingle sometimes lists the whole exclusive group.
5. **Recordings** (`data/recordings`), which win over all of the above;
   finds (rares, kills, loot, treasures, instances; "Recordings" below) follow
   the rules of their own paragraph there.

`source` on every quest, npc, object and item lists its contributors in
that order: `pfquest`, `questie-forever`, `wowhead:*`, `polestar-correction`, `recorder`, plus the XP source tag.
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
