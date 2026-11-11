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
| `Polestar_Guides` (`addon/Polestar_Guides/`, with `Polestar_Guides_Alliance` and `Polestar_Guides_Horde`) | Polestar's own pack (pack id `guides`): the factionless guides, and each faction's in a part loaded on demand, the player's faction's with the pack (PACK_FORMAT, "Format 8") | `compile`, from `guides/` | yes (generated) | yes |
| community addons | Addons by other authors (`X-Polestar-Pack` in their TOC; `docs/PACKS.md`, `docs/PACK_FORMAT.md`) | the same compiler, from their own repositories | in their own repositories | by their authors |
| `Polestar_ItemDB` (`addon/Polestar_ItemDB/`) | Item stats and Forever reward choices for the gear advice; loaded on demand | `forge data itemdb` (`Items.lua`), then `forge data gear` (`Forever.lua`) | yes (generated) | yes |
| `Polestar_<locale>` (`addon/Polestar_deDE/` … `zhTW/`) | The language folder of one client language: Polestar's interface strings (`Interface.lua`, for `Polestar.L`; translators and `forge i18n sync`), our guides' texts (`Texts.lua`, for `Polestar.GuideTexts`) and the quest, NPC, object and item names (`Names.lua`, for `Polestar.Names`); loaded on demand by `Core/Locale.lua`, only the client's own, never in English. It replaced `Polestar_Guides_<locale>` and `Polestar_Names_<locale>` in 0.3.0 | `forge guide compile` (`Texts.lua`) and `forge data names` (`Names.lua`, from the client's tables, DingDB (pinned) and pfQuest); each writes the one TOC alike (`forge_guide::toc::language_toc`) and leaves the other's file alone | yes (generated) | yes |
| `Polestar_QuestDB` (`addon/Polestar_QuestDB/`) | The quest database behind quest markers and tooltips; loaded on demand | `forge data questdb` | no (local, gitignored) | yes, when built |
| `Polestar_Codex` (`addon/Polestar_Codex/`) | Lookup's Codex, and the Dungeons and Rares data; loaded on demand | `forge data codex`, from release-safe inputs (`--local-extras` builds a local-only one) | no (generated, gitignored) | yes, always: `pack` fails without it |
| `Polestar_Nav` (`addon/Polestar_Nav/`) | Polestar's walking router (started from Shortest Path Forever v1.16.0 by Cillian Berragan, GPL-3.0-or-later; Polestar's since 2026-10-16) with the walking maps of Eastern Kingdoms, Kalimdor and Zephras Isle (maps format 5: Leffe's navigation maps, his surfaces, graph, jumps and drops, with our area names and chokepoints; format 3 from our grid when packed without `--leffe`) and the walk's chokepoints, for the arrow's walking routes; loaded on demand at login, never while an installed Shortest Path Forever guides (the target handed to it, or a journey of its own running; Nav, "In-game walking routes (Polestar_Nav)", "Hand-off to Shortest Path Forever") | the router hand-written (`Routing/`); `forge nav pack --leffe` (the maps, `PACK.json`, from Leffe's navigation maps, the navigation grid and the ground layers) | yes | yes, always |
| `Polestar_Nav_EK`, `Polestar_Nav_Kalimdor` (`addon/Polestar_Nav_EK/`, `addon/Polestar_Nav_Kalimdor/`) | The map parts of each continent's walking maps when they are Leffe's (maps format 5; their metadata stays in Polestar_Nav); loaded on demand by Polestar_Nav's router the first time it searches that continent (Polestar searches only the player's continent and those already loaded), never in combat ("Leffe's navigation maps in game") | `forge nav pack --leffe` | yes | yes, when written |
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

`addon/Polestar/Polestar.toc` loads thirteen XML manifests in this order. Each
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
Alts\Alts.xml           Characters: a snapshot of each character on the account, the hub section
```

Manifests use only `<Script file="..."/>` and `<Include file="..."/>` (paths
relative to the XML file, backslashes allowed). The test harness parses the
TOC and these manifests, so tests always load exactly what the client loads.

### Globals

Only these globals may be assigned anywhere under `addon/` (enforced by
`rust/crates/forge-addontest/tests/addontest/syntax.rs` via `luac -l`):

`Polestar`, `PolestarDB`, `PolestarCharDB`, `PolestarRecorderDB`,
`SLASH_POLESTAR<n>`, `SLASH_POLESTARREC<n>`, `SLASH_POLESTARWAY<n>` (`/way`,
claimed only while no addon has it), `BINDING_TAG_POLESTAR`,
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
| `STEP_SKIPPED` | fromStep, toStep or nil, `{ { quest, title, reason, text }, ... }` | Engine, active tab, just before `STEP_CHANGED` (or `STEP_UPDATED`): the live step, or the step the player looks at as it follows forward, moved past a step whose open quest goals became unavailable (reasons as in "Unavailable quests"); while the player looks at another step the notice waits and fires once they are back on the live step, toStep being it |
| `PLAYER_SKIPPED_STEP` | guideId, stepIndex | Engine, after `Skip()` (the window, the menu, `/polestar skip`): the guide window offers the undo |
| `PLAYER_SKIPPED_QUEST` | questID, title or nil | Engine, after `SkipQuest(questID)` (a quest's line, right-clicked): the guide window offers the undo |
| `WAYPOINT_CHANGED` | waypoint or nil | Engine (and Nav when an override is set/cleared) |
| `GUIDE_COMPLETED` | guideId | Engine |
| `GUIDE_END` | guideId, `{ guideId, undone, live, next, choose }` | Engine, after the evaluation, with `behavior.guideEnd = "ask"` (default): the player reached the end of a leveling guide (its last step for the character done, whatever was skipped or left open before it), once per guide per character (`CharState().guideEnds`); `undone` the open steps left, `live` the live step (nil when all are done), `next` the guide the hand-off goes to (nil with none or a choice to make), `choose` a route choice the player makes. The guide-end window asks (UI/GuideEnd.lua); see "End of a leveling guide" |
| `GUIDE_CONTINUED` | fromId, toId, carried | Engine, after the evaluation, with `behavior.guideEnd = "continue"`: a finished leveling guide handed off by itself (the guide window's banner says so, chat while it is hidden; `carried`: Engine.CarriedQuests(fromId), said in chat) |
| `GUIDE_PLACED` | guideId, stepIndex or nil, `{ guideId, ... }` | Engine, active tab, once placement of a guide just opened ends (see "Placement"; not for a guide a login or /reload brings back): where the guide resumes, and the guides passed whole on the way; the guide window goes over the steps before it, titles and count rolling (`GF.PlayCatchUp`, after `PLAYER_ENTERING_WORLD`) |
| `CATCH_UP` | true \| false | Guide window, while its catch-up goes over the steps (`GF.PlayCatchUp`): the arrow shows an hourglass turning over in its dial's place (`Arrow.SetBusy`; Media/UI `hourglass`, `hourglass-sand`, tools/media/ui.js) |
| `SETTING_CHANGED` | path, value | Core settings |
| `TOGGLE_FRAME` / `SHOW_FRAME` | — | commands, keybinds → UI (from a hidden Polestar both show it again, the window with it) |
| `POLESTAR_HIDDEN` | hidden (true \| false) | Core, `Polestar.SetHidden` (and true again as "Keep the arrow when hidden" changes while hidden): see "Hiding Polestar" |
| `SHOW_PICKER` | — | commands → UI |
| `SHOW_OPTIONS` | section or nil | commands → UI |
| `SHOW_WELCOME` | page or nil | About's "Show the welcome again", `/polestar welcome` → UI/Welcome.lua |
| `SHOW_WHATSNEW` | — | About's "What's new", `/polestar whatsnew` → UI/WhatsNew.lua |
| `WELCOME_CLOSED` | — | UI/Welcome.lua, the welcome closed (not stepped aside) → UI/WhatsNew.lua |
| `SHOW_COPY` | title, text | `/polestar where` → UI/Copy.lua |
| `SHOW_REPORT` | — | `/polestar report` → UI/Report.lua |
| `SHOW_DISCORD` | — | `/polestar discord` → UI/Report.lua |
| `SHOW_QUEST_ROOM` | — | `/polestar questlog`, the full-log banner's Make room → UI/QuestRoom.lua |
| `SHOW_IMPORT` | — | `/polestar import` (Core/Import.lua) → UI/Import.lua: the hub at Import |
| `TOGGLE_PICKER` / `TOGGLE_OPTIONS` | — | key bindings and gamepad chords (`POLESTAR_MENU`, `POLESTAR_OPTIONS`) → UI: open, or close when open |
| `TOGGLE_FOCUS` | — | `POLESTAR_FOCUS` → UI/GamepadGuide.lua (focus mode) |

`UPDATE_KNOWN` (latest version) is fired by Core/Update.lua when a newer
release than any known becomes known during a session (a party or guild
member's version): the guide window's update line and the update card look
again ("Update notices", under UI). The update line lays the guide window
out again (`GF.Layout`) only when its text would change, never for the login
check alone.

Modules fire their own (`TABS_CHANGED`, `ROUTE_*`, `TRAIN_DUE`,
`CLASS_TRAINED`, `GUIDE_OUTLEVELED`, `QUESTDB_*`, `CODEX_LOADED`,
`ITEMDB_LOADED`, `GEAR_UPDATED`, `FLIGHT_STARTED`/`FLIGHT_ENDED`,
`FLIGHT_MARK_CHANGED`, `QOL_HEARTH_CHANGED`, `QOL_XP_UPDATED`, `MOUNT_SPOTTED`, `RARE_SPOTTED`,
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

`PolestarDB = { schema = 1, settings = { [section] = { ... } }, packs = { [packId] = { off = true } }, imports = { [guideId] = { format, license, guide, frames } }, welcomeSeen = 1, gamepad = { chords = { [action] = "PADRSHOULDER+PADDUP" } } }`
`PolestarCharDB = { schema = 1, guide = id|nil, tabs = { guideId, ... }, activeTab = n, absentAt = { [guideId] = place }, closedTabs = { { id, at }, ... }, manual = { [guideId] = { ["s:g"] = true|"tick" } }, skipped = { [guideId] = { [stepIndex] = true, ["s:g"] = true } }, pins = { [guideId] = { step, done } }, offers = { [questID] = true }, skippedQuests = { [questID] = true }, shapes = { [guideId] = shape }, stepKeys = { [guideId] = { hash, ... } }, flags = { fp = { [name] = true }, ... }, dungeons = { [mapId] = true }, welcomeSeen = 0|1 }`

`packs[<id>].off` hides a pack's guides account-wide (the Community guides page's
switch). `imports` holds the guides pasted on the Import page, as decoded
("The guide registry", imported guides). `welcomeSeen` (UI/Welcome.lua) is the version of the welcome last
seen: in `PolestarDB`, the account has had its welcome (later characters skip
its Set up and Route style pages); in `PolestarCharDB`, this character has (0 while due).
`whatsNewSeen` (`PolestarDB`, UI/WhatsNew.lua) is the version of the release notes last shown; a fresh
install (`ns.IsNewAccount()`: no saved `PolestarDB` as Polestar loaded) is set to the newest without them.
`update` (`PolestarDB`, Core/Update.lua) is what the update notices keep: `firstRun` (when this account
first ran Polestar; 0 for one from before), `since = { version, at }` (when this build was first run),
`peer`, `peerAt` (a player's newer release and when it was heard), `snooze` (Got it, until), `shown`,
`shownAt` (the card's last version and time), `helloAt`, `replyAt` (the guild hello's), `probed` (the
version probe's players, name -> when, at most 300), `heard` (players' answers to our probes, name -> `{ v,
at }`, at most 50, 7 days).
`dungeons` (per character) holds the dungeons this character runs in leveling
guides, by the instance's Map id (`Engine.ChooseDungeon`, `when dungeon`).
`behavior.suggestFrom` (default `"guides"`) is the pack suggestions come from.
Modules keep their own keys beside these (`rares`, `instances`, `names`, `alts` account-wide;
`ui`, `routes`, `classTrainLevel`, `classTrainVisit`, `qol`, `flightTimes`,
`flightNow`, `instanceRuns` per character), each described in its section or file header.

`manual` holds the player's ticks (`"tick"`, any goal but a note) **and**
latched results (`true`): NPC interactions (talk/train/vendor) are latched
during their step, and conditions that can stop holding later (goto,
sethome, hearth, fly, getfp, buy, bag-count collect, `money`, `train class` with
nothing to learn) are latched once the route moves past their step, so
leaving a zone, rebinding the hearthstone or levelling up never drags the
guide backwards. A hearth or fly that landed is also latched within its step
while that step is the live one, even while the player looks at another
step, so walking out of the arrival's subzone does not send the player back
to the flight master (#362); a step only looked at ahead never latches it,
and stepping back (Prev) keeps it. Quest goals are never latched, but for a `direct` turn-in's
QUEST_TURNED_IN during its step (a repeatable is never flagged completed): abandoning a
quest reopens its step (unless the player ticked it). `skipped` holds the
steps the player skipped (step number) and the optional goals they skipped
(`"s:g"`). `pins` is the step the player was looking at when it is not the
live one (Prev/Next/Goto). (Older saves also hold `offers`, the quests a
giver did not offer; login drops it: no such mark is kept, #741.) All of
them are keyed by step position: `stepKeys` (a hash per step of its verbs and
ids) lets a pack update carry them to the steps it kept (see "Placement"),
and, for a step it changed, to the step that has the same goal now: the
changed step's goals come from `ns.LegacySteps` (Core/LegacySteps.lua,
written by `tools/legacy-steps.js` from earlier releases' guides), so a
check-off goes to the goal with the same verb and quest (or item, landing),
a skip and the saved view to the step sharing most of its quest goals
(`Own.remap`, `Own.legacyMaps`). `shapeVersions` holds the pack version a
guide's shape was saved with, `ownShapes` the shape of the guide as
registered (never as planned for the character) then.
An update never moves a player back (#1353 upgrade): when a guide's shape
came from another version of its pack and the guide itself changed (its own
shape, the guide as registered, differs from `ownShapes`: `Own.updated`; a
guide a pack update left as it was keeps everything as is, though its shape
as planned for the character differs), `Own.noteAdded` notes what the update
added (steps none of whose quest goals the old guide had there, goals it did
not have or had only further on, and goals of a carried quest an earlier
release had optional only: `required` in LegacySteps.lua), and the first
placement with the quest log in passes what of it lies behind the player's
place (`Own.passAdded`: the first step that holds for content the old guide
had, by the step's own rule, `Own.holds`: a vendor check-off beside other
work never holds it), as `gone` steps and goals that no longer apply; nothing shows as
skipped. A quest the player carries whose remaining work is among them (its
hand-in ahead or not: a hand-in is no work, #1595) is
noted `behind`: the guide window lists it under the step as "Still to do"
(`Engine.GetBehind`; a click points the arrow, a right-click skips or
abandons it) and While-here offers its objectives nearby; the place stays. A
quest ahead that needed something passed is planned again (`Own.replan`,
`Own.goneSource`): the passed step comes back just before it when it is on
the way (the catch-up's local rule), else the quest drops out with what
follows. Safety: the mapping runs once per saved guide (the save is stamped
with the pack version, `shapeVersions`); it runs under `Own.safely`, so an
error puts the save back, restores it by kept steps alone, and writes one
line to the debug log (`/polestar report`) instead of a Lua error;
LegacySteps.lua is a function whose table is built only for that mapping and
dropped at the first `QUEST_LOG_UPDATE`; Reset progress clears `gone` and
`behind`, and none of them binds the step arrows, Skip or the guide list.
What earlier updates passed stays passed through the next one (0.3.5 ->
0.3.6 -> 0.3.7): `Own.noteAdded` sets the save's `gone` and `behind` aside
(`passedBefore`), and the new pass starts from them and adds to them; of
them it drops only a step at or after the player's place whose passed quest
work is open and whose quest is not handed in (`Own.backInPlay`). Passes are
noted by step key, so a passed step the new update changed takes its passes
along: what was passed in the old step (its goals from LegacySteps.lua) is
passed in the new steps of the stretch it became (`Own.carryGone`). A save
from before `ownShapes` existed counts a version change as an update of each
of its guides once, as before, and keeps its passes.
A saved tab of a leveling guide that kept fewer than half of those steps
(`Own.reworked`: an update reused the id for another part of the route, as
0.3.5 did for Horde 04-06, #1328) moves, at the first `QUEST_LOG_UPDATE`
after it comes back, to the pack's leveling guide with the most quests of
the log to work on (`Guides.FollowLog`; never one open already), and chat
says so.

### Commands

```lua
Polestar.RegisterCommand(name, fn(argString), help, quiet)
```

`/polestar` and `/pole`. No argument fires `TOGGLE_FRAME`. `help` lists
registered commands with their `help` lines (already translated:
`L["..."]`). A command typed while Polestar is hidden brings it back first
(`SetHidden(false)`), as it asks to see something, unless it is registered
`quiet`: one that only prints or sets (`hide`, `status`, `tabs`, `debug`,
`arrow`, `way`, `near`, `route`, `skipleg`, `xp`, `bags`, `questdb`,
`instances`, `restock`). Core registers (Core/Commands.lua): `guides`,
`options`, `show` (`SHOW_FRAME`), `hide` (hides or shows all of Polestar;
`hide arrow` toggles "Keep the arrow when hidden", see "Hiding Polestar"),
`next`, `prev` (look at the next/previous step; nothing changes), `skip`
(skip the step shown, for good), `reset` (clear ticks, latches, skips and
the saved view for the current guide), `guide <id>`, `status`, `tabs`,
`tab <n>`, `close`, `path` (the route choice), `welcome` (`SHOW_WELCOME`),
`packs` (Options at Community guides), `gamepad` (Options at Gamepad), `where`, `questlog` (`SHOW_QUEST_ROOM`), `report` (`SHOW_REPORT`),
`discord` (`SHOW_DISCORD`), `debug`; Nav adds `arrow`, `way` and `route`;
modules add theirs (`xp`, `gear`, `instances`, `dungeons`, `lookup`, `mount`,
`rares`, `talents`, `alts`, `questdb`, `import` (`SHOW_IMPORT`, Core/Import.lua),
`update` (the update card, Core/Update.lua)).

`where` prints the player's map and position as two guide lines, `zone map
<uiMapID>` and `goto <x>,<y> live` (two decimals, the client's live frame,
marked `live` because typed coordinates are read in the Era frame), then "For
another goal, add @x,y live", and fires `SHOW_COPY` with the two lines. In an
instance or on a map without a position it prints why instead.

### Caught errors and the Polestar Discord

```lua
Polestar.SafeCall(fn, ...)    -- runs fn; an error is noted, then handed to the error handler (the same message at most once every 30 s)
Polestar.Safe(fn) -> fn'      -- fn through SafeCall (nil stays nil): every OnUpdate script's handler
Polestar.After(s, fn) / NewTicker(s, fn, n) / NewTimer(s, fn)   -- C_Timer's, the callback through Safe; every timer of the addon's
Polestar.Log(text)            -- a line into the rolling log (the last 200, "HH:MM:SS text"), kept whether or not debug is on
Polestar.DebugLog(n?) -> { line, ... }   -- its last n lines, oldest first
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

OnUpdate scripts and timer callbacks are run by the client, not the bus:
each goes through `Polestar.Safe` / `Polestar.After`, so their errors are
noted and passed on like a handler's. An error handed on is passed to the
game's handler at most once every 30 seconds per message (a loop that keeps
failing would flood it); every one is still noted and counted. The rolling
log holds `Polestar.Debug` lines, caught errors and blocked calls whether or
not `/polestar debug` prints them; the report ends its details with its last
five lines under "Log:", before anything else gives way to Discord's 2000
characters, after the quest log ("Quest log 12/40: 783 1/3, 7 done, …") and
the settings turned away from their defaults ("Settings: path=value, …"),
each left out when empty.

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
minimap, the quest reward and talent buttons, the XP bar, and the frames
under those), is made through `CreateFrameUnder`; frames under Polestar's
own windows, which hang off `Polestar.UIParent` (see "Hiding Polestar"), are made with `CreateFrame`. No
`CreateFramePool` with a game frame either: it calls `CreateFrame` with its
parent. `tests/lua/wow_stub.lua`'s `CreateFrame` raises on a call from addon
code whose parent is, or is under, a frame addon code did not make
(`stub.underGameFrames`), and `rust/crates/forge-addontest/tests/addontest/nav-mapcanvas.rs`,
`rust/crates/forge-addontest/tests/addontest/qol.rs` (the reward marks, the XP bar mark) and
`rust/crates/forge-addontest/tests/addontest/talents.rs` (the talent marks) check that none was made.

### Hiding Polestar

```lua
Polestar.UIParent                  -- PolestarUIParent: the layer every Polestar frame on the screen hangs off
Polestar.Hidden() -> bool          -- Polestar is hidden (this character, kept through a /reload)
Polestar.SetHidden(on) / Polestar.ToggleHidden()
Polestar.HideKeepsArrow() -> bool  -- "Keep the arrow when hidden" (this character)
Polestar.SetHideKeepsArrow(on)
Polestar.ArrowHidden() -> bool     -- hidden and not keeping the arrow: the arrow, its travel button and arrival chime go
Polestar.GuideShown() -> bool      -- the guide window's state shown and Polestar not hidden
Polestar.GuideWindowOn() -> bool   -- the window's own state (ui.shown, the instance wait), hidden or not
Polestar.PlaySound(kit, channel, arrow) / Polestar.PlaySoundFile(file, channel, arrow)
```

One switch per character hides everything Polestar shows and brings it back
as it was: a click on the minimap button (`Maps/MinimapButton.lua`), on the
floating button (`UI/Launcher.lua`) or on Polestar's row in the addon
compartment, the `POLESTAR_HIDE` binding ("Hide/show Polestar"; a gamepad
chord too, `UI/Gamepad.lua`) and `/polestar hide`. `SetHidden` keeps it in
`PolestarCharDB.hidden` (read as the addon loads, so a `/reload` or the next
login starts hidden and nothing flashes up), then fires `POLESTAR_HIDDEN`
(hidden), and `GUIDE_SHOWN` when `GuideShown()` changes with it. The engine,
party sync, the Recorder, the vendor and delete guards, the quest automation
and the navigation's own state run on, so Polestar comes back on the step the
player reached; nothing it would have shown meanwhile is kept for later (no
toast, alert, sound or ping waits).

How each surface hides:

- Frames on the screen: every Polestar frame that would hang off `UIParent`
  is made with `Polestar.UIParent` as its parent (anchored to `UIParent` as
  before). The layer is a plain frame the screen's size at `UIParent`'s frame
  level; hiding is its `Hide()`, so each window, card, toast and panel keeps
  its own shown state, their OnUpdate scripts stop, and they come back as
  they were. A window whose OnHide closes or resets it checks
  `self:IsShown()` first (an ancestor's hide fires it too). While hidden, the
  windows under the layer leave `UISpecialFrames` (`CloseOnEscape` keeps the
  list): the client's `CloseSpecialWindows` hides a listed window that
  `IsShown`, seen or not, and Escape would close one out of sight instead of
  opening the game menu.
- Not under the layer: the secure buttons (the quest item, target, step,
  Hearthstone, bag, travel, rare and name-target buttons; a protected child would
  make the layer protected in a fight): each follows `GuideShown()` or
  `ArrowHidden()` and changes out of combat, as before, so in a fight the
  rest goes at once and they go when it ends (back the same way). The arrow
  (`Nav/Arrow.lua`, `shouldShow`: `not ArrowHidden()`), which "Keep the arrow
  when hidden" may keep, and the ways back: the minimap button (dimmed:
  `Maps.PaintHidden`, its tooltip says how to show Polestar), the floating
  button and the menu they open.
- The maps: every drawing on a map canvas is made under the view's frame
  (`view.frame`, MapCanvas), which `POLESTAR_HIDDEN` hides on every map; its
  listeners get "hide", and "show" with fresh values when it comes back. The
  world map's info bar and the instance and coordinates readouts check
  `Hidden()` too.
- The minimap (its children are the game's, and the route lines, pins, pings
  and trail draw there): `Pins` and `RouteLines` draw nothing and sample
  nothing while hidden (their drivers hang off the layer, so their OnUpdate
  stops), and redraw on `POLESTAR_HIDDEN`; pings due while hidden are marked
  played, not sounded on the way back.
- Marks on the game's frames and lines in its tooltips and menus: the bag
  arrows and glow, the quest bag marks, quest levels, nameplate icons, the
  turn-in captions in another addon's quest tracker, the talent overlay, the
  XP bar mark, the reward marks, the flight map's node mark (the step key
  still flies there), the restock button, tooltip lines (`Hooks.decorate`),
  item clicks, and Polestar's
  entries in the quest log, map tracking and minimap menus: each asks
  `Hidden()` and redraws on `POLESTAR_HIDDEN`. The Quick Keybind Mode shows
  none of Polestar's buttons while it is hidden (`mayForce`), and its key
  catcher hangs off the layer.
- Sounds go through `Polestar.PlaySound` / `PlaySoundFile`: silent while
  hidden; one passed `arrow` (the arrival chime) is silent only while
  `ArrowHidden()`. Toasts and banners showing as Polestar hides are taken
  down (the rare and while-here toasts, the transport banner and notices,
  open menus), and none shows while hidden (a rare spotted, a while-here
  line, a notice: `Alerts`' `present` returns at once).
- `ArrowHidden()` also stops the arrow's mirrors (TomTom's and the game's
  waypoint, `Nav/Bridges.lua`) and the hand-off to Shortest Path Forever
  (`Nav/Handoff.lua`); the cast prompt (`Nav/Prompts.lua`) goes with the
  arrow. `/polestar arrow`, `way` and `near` say why the arrow does not show
  (`Nav.SayGuideHidden`).

"Keep the arrow when hidden" (`PolestarCharDB.hideKeepsArrow`, off by
default): the minimap button's menu, Options (Guide, Window, Show and hide)
and `/polestar hide arrow`. Changed while hidden, it takes effect at once
(`POLESTAR_HIDDEN` true again). The menu also has the guide window
(`TOGGLE_FRAME`) and the arrow (`nav.arrow`, `Nav.ToggleArrow`) on their own.

Opening a window brings Polestar back first: the toggle and show of the
guide window (`TOGGLE_FRAME`, `SHOW_FRAME`: hidden, they show Polestar and
turn `ui.shown` on), the menu's Guides, Lookup and Options, the bindings
for the guide menu, the options, focus and the report, the game menu's
Polestar button, and every command not registered `quiet`.

`rust/crates/forge-addontest/tests/addontest/hide-all.rs` hides and shows a
loaded Polestar with every surface up (the round trip restores each frame's
shown state, nothing draws or plays while hidden, a `/reload` keeps it, a
fight holds only the secure buttons back), and keeps a registry of every
frame parented to `UIParent`, the minimap or a game frame and every sound
call: a new one fails the test until it is listed, so a new surface is
decided on. New frames on the screen take `Polestar.UIParent` as their
parent, new sounds go through `Polestar.PlaySound`, new toasts check
`Polestar.Hidden()`, and new map drawings hang off `view.frame`.

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
  taint. The minimap button (`maps.minimapButton`, on by default) and
  the key bindings open Polestar; the Recorder page calls
  `PolestarRecorder_Command`;
- adds no entry to the world map and minimap tracking menus
  (`Menu.ModifyMenu`, Nav/Nearby) or to the quest log and objective
  tracker menus (UI/QuestLinks);
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
`rust/crates/forge-addontest/tests/addontest/gamepad-ui.rs` loads Polestar with each style, and lists every
line of addon code that reaches into the game's UI (slash commands,
`UISpecialFrames`, menus, panels, popups, the world map's tables, the error
frame's settings, override bindings, the gamepad's managers): a new one fails
there until it is guarded and listed.

### Localisation

`Polestar.L[key]`: a key is the English text, and a missing key returns
itself, so a client without a translation reads English. The translations
are `Interface.lua` in each language folder `Polestar_<locale>` (one per
language of forge-guide's `locales.rs`; load on demand), so a client compiles
only its own language's. `Core/Locale.lua` loads the client's folder
(`C_AddOns.LoadAddOn`, not `Data.Pack`: never refused in combat, and a failure
is not kept, so Names and Guide texts still try the folder later) right after
`Core/GuideTexts.lua`: the folder's `Names.lua` and `Texts.lua` fill
`Polestar.Names` and `GuideTexts` as it loads, and every file after it may
read `L` at load. The files before it, Init.lua included, read `L` only when
they print (the commands register in Core/Commands.lua). An English client
loads nothing; a missing or disabled folder leaves the interface in English,
and when the folder of a language Polestar ships is still not loaded at
login, one English chat line says so ("the German language files
(Polestar_deDE) are missing or turned off in the AddOns list…").
If the early load fails and Names' or Guide texts' later one succeeds, `L`
fills then: what was read at load (key binding names, the options' labels)
stays English, the rest is translated. To try this load on an English
client, `tools/dev/!PolestarLocaleTest` makes Polestar's own files see
another `GetLocale()` (its .lua says how).
docs/TRANSLATING.md describes the files and `forge i18n`.

A word with more than one meaning gets a key per meaning:
`Polestar.LC(context, text)` is the translation of `"<context>: <text>"`, and
`text` while there is none: a dungeon boss that is a chest is
`LC("boss", "Chest")`.

A quest named in running text is set in the client's quote marks:
`Polestar.Quoted(name)` fills `LC("quote marks", "“%s”")` (deDE „…“,
frFR « … » with no-break spaces, esES and ruRU «…», koKR ‘…’, zhTW 「…」,
the others “…”), and leaves a name that holds double quotes, guillemets or
corner brackets of its own as it is. The Engine quotes the quest of an
accept, turn-in, complete or abandon goal in its `text` (so in the arrow's
label and the waypoint handed to TomTom) but not in its `subject`, the
"for <quest>" detail, the notices (`Requires <quest> first`, the `when`
lines, While here's "Hand in"), and the UI its banners, tooltips' prose and
warnings. A quest name standing alone (a card or row title, the quest
tooltip's Quest line) and NPC and item names stay bare; a quest link keeps
its brackets (#1368).

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
where it appears, so `forge i18n keys` and a translator find every key: a table of
labels holds `L["Home"]`, not `"Home"` translated later through
`L[VIEW_LABEL[v]]`. `L[variable]` is left only for text that comes from data
(a guide's category, race and class names, profession and spec names, the
talent plans' spec names, the release stage), each listed in `DATA_KEYS`
(`rust/crates/forge-i18n/src/keys.rs`, which also reads Gear/Weights.lua's spec labels,
Talents/Builds.lua's `specs` and the Dungeons attunement notes of
`data/codex/attunements.json`). Generated files carry their prose as
literal keys too: `forge data talents build` writes the plan summary and per-level notes
as `L["..."]` in `Talents/Builds.lua`. Data that names a game thing carries
its id instead, and the display asks `Polestar.Names` (quests, NPCs, objects,
items, spells, factions, instances, areas, flight points, encounters). The
optional Recorder has its own `ns.L` and `Locales/<locale>.lua` (listed in
its TOC); `forge i18n check` and `sync` cover it too.

`Polestar.AI_LOCALES` names the languages whose translation is AI-made
(`status: "ai"` in locales.rs; the forge-i18n tests keep the two equal). On
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
Names.PackName() -> "Polestar_<locale>" | nil   -- the language folder
Names.AddChunk(locale, kind, lo, hi, text)   -- the pack's files only; any kind
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
  language, `Names.lua` in the language folder `Polestar_<GetLocale()>`,
  in since `Core/Locale.lua` loaded the folder; when that failed, loaded
  through `Data.Pack` on the first ask (refused in combat, it loads when
  combat ends, fires `NAMES_LOADED` and redraws the guide window once; a
  missing folder is final for the session and harmless). Then nil. On an English client every answer is nil and nothing
  loads.
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
- **The packs.** One load-on-demand language folder per language,
  `addon/Polestar_<locale>/`, shared with our guides' texts (Guide texts)
  and the interface strings (`Interface.lua`, Localisation):
  `Names.lua` handing `Names.AddChunk`
  each kind's names as LuaChunks text, `"<id>\t<name>"` lines of up to 500
  names a chunk, cut out when a name is asked (about 1 MB resident instead
  of 3 to 4), `LICENSE-DATA.txt`, Ding's `CREDITS.md`, and the folder's TOC,
  which `forge data names` and `forge guide compile` write alike (each leaves
  the other's files alone; `forge data names` removes the folder only once
  no `Texts.lua` or `Interface.lua` is left in it, and the old `Polestar_Names_<locale>`),
  committed and shipped. Kinds: `quest`, `npc`, `object`, `item`, and `map`
  (instance maps), `encounter` (DungeonEncounter ids), `faction`, `taxi`
  (TaxiNodes ids) and `objective` (the objective text of the dungeon quests
  whose objective is an event). `forge data names` builds
  them, per id the first source with a name winning: the client's own
  tables in that language (wago.tools with `&locale=`: Forever's ItemSparse,
  Map, DungeonEncounter, Faction and TaxiNodes, then the Era client's
  ItemSparse for the items Forever's lacks; the newest build holding every
  one in English and each language, and none stops the build), Forever's
  quest data in that language (read from `data/sources/web/names`;
  without that cache this source is empty; a bracketed name is no translation), DingDB (cloned into
  `data/sources/ding`, pinned to a commit and its files' sha256s: `ding_pin` in
  `rust/crates/forge-data/src/names_sources.rs`), then pfQuest's `db/<locale>` (no esMX). A name
  equal to the English one, from any source, is never stored: a translation
  from a later source wins, else the English shows as it would; a name
  marking unused content (`[PH]`, `[UNUSED]`, `(DNT)`, `<NYI>`, `(test)`
  and their translations) is none. Areas need no pack: the client names
  them by id (`Compat.GetAreaName`). Only the ids the compiled guides, the
  quest database, the Codex's data and the travel data name are kept.
  `--no-questie` leaves DingDB out. `Data.CheckInstall` checks the client's
  language folder like the other optional data packs: never missing, named
  when its version differs. It also lists the languages whose old folders,
  `Polestar_Guides_<locale>` or `Polestar_Names_<locale>` (before 0.3.0),
  are still installed: Polestar never loads them, and at login one line asks
  the player to delete them.

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
GuideTexts.TextsAddon(addon) -> "<addon>_<locale>" | nil   -- nil on English; our pack's "Polestar_<locale>"
GuideTexts.PackText(packId, text) -> translation | text
Polestar.RegisterGuideTexts(locale, packId, { pack = {...}, guides = { [id] = {...} } })
```

- **Loading.** The translations of a pack are its texts addon for the
  client's language, `<pack addon>_<locale>` (load on demand, generated by
  `compile` from the pack's `locales/<locale>/` files; our own pack's,
  `Polestar_Guides`, are `Texts.lua` in the language folder `Polestar_<locale>`
  beside the game's names, so one load brings both, and `Core/Locale.lua`
  has loaded it before our pack registers): only that one loads,
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
- `Data.CheckInstall` checks the client's language folder once, for our
  pack's texts and the names alike: never missing, named when its version differs.

### Compat — the client's game data goes through here

UI, Nav and Engine read the client's quests, map, units and items through
`Polestar.Compat`, with these exceptions that call the client themselves:
Nav's Blizzard user waypoint (`C_Map`, `C_SuperTrack`, and Waypoint UI's
`WaypointUIAPI.Navigation` when that addon is loaded; `Nav/Bridges.lua`),
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
`TaxiRouteMap`; the step key's flight: `TaxiNodeCost`, `TakeTaxiNode`;
`QoL/Flight.lua`), and the transit sync's addon messages and
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
services' tracking menus (`Menu.ModifyMenu`, `Nav/Nearby.lua`), the quest
log and objective tracker menus (`Menu.ModifyMenu`, `GetMouseFoci`;
`UI/QuestLinks.lua`) and the
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
`rust/crates/forge-addontest/tests/addontest/compat.rs` rejects any other code that opens or moves the world
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
Compat.GetUnitMapPosition(unit) -> uiMapID, x, y | nil      (a party unit's place, 0-100; nil in instances / unknown)
Compat.GetUnitZone(unit)        -> zone uiMapID | nil        (its best map climbed to Enum.UIMapType.Zone)
Compat.GetPlayerFacing()        -> radians | nil   (0 = north, counter-clockwise positive)
Compat.GetZoneText()            -> zone, subzone
Compat.IsQuestCompleted(questID)       -> bool   (flagged completed / turned in)
Compat.IsOnQuest(questID)              -> bool
Compat.IsQuestReadyForTurnIn(questID)  -> bool
Compat.GetQuestObjectives(questID)     -> { { text, type, finished, numFulfilled, numRequired }, ... } | nil
Compat.GetQuestTitle(questID)          -> string | nil (client cache; may be nil)
Compat.GetOfferedQuests(source)        -> { questID, ... } | nil   (source "gossip" | "greeting" | "detail")
Compat.GossipHasChat()                 -> bool   (the open gossip has an option that is no goods, training, bind or flight one)
Compat.IsQuestTrivial(qlvl, level)     -> bool   (grey for that level)
Compat.GetItemCount(itemID, includeBank) -> number   (includeBank: the bank's too)
Compat.GetItemQuality(itemID)          -> 0..7 | nil (nil while not cached)
Compat.ItemTipColor(itemID)            -> r, g, b | nil (its tooltip's title colour; nil until loaded)
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
Compat.IsInInstance()                  -> bool, instanceType ("party" | "raid" | "pvp" | ... inside)
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
Polestar.Data.CheckInstall() -> missing, stale, retired   -- stale: "name version" of every Polestar_* folder (loaded or not, Polestar_Recorder aside) whose known version differs from Polestar's
Polestar.Data.InstallLine() -> string|nil   -- a mixed install in one English line for the report ("mixed: Polestar 0.3.5, Polestar_Guides 0.3.4")

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

Measured with the real pack (lua5.1, `rust/crates/forge-addontest/tests/addontest/lookup-codex.rs` setup):
the pack loads in about 20 ms (4.4 MB; it never loads at login), the first
query costs 7 ms (guide headers), a keystroke 1.5–4 ms (1 to 8 letters), a
detail page (`Lookup.Sources`) 0.1 ms for a mount up to 10 ms for an item
with 40 drop sources.

### Guide data (compiled Lua) — the toolchain/Engine contract

Generated by `forge guide compile` from `.guide` sources
(`docs/GUIDE_FORMAT.md`) into the pack's addon folder: the generated TOC,
`Pack.lua`, `MapFrames.lua`, `Guides.lua` (one `RegisterGuide` per guide, each
built in its own function) and `LICENSE-DATA.txt`, plus `LICENSE.txt` (the
pack's `LICENSE`) when the pack folder has one. Ours is
`addon/Polestar_Guides/`; a community pack's is `<pack>/dist/<folder>/`. Our
faction parts (`Polestar_Guides_Alliance`, `Polestar_Guides_Horde`) carry the
same `LICENSE-DATA.txt`, and `forge release pack` refuses a guide part
without one, as it refuses a data addon without its notice. The
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
      when = { { k = "level", op = "<", n = 6 }, { k = "onquest", q = { 788 } } },  -- optional (format 4): conditions checked during play, all must hold
      along = "camp",              -- optional (format 4): true or a later step's label; the route passes over the step
      label = "camp",              -- optional (format 4): the step's name, unique in the guide
      skipto = { { to = "camp", when = { k = "turnedin", q = 1235 } } },  -- optional (format 5): jumps to a later step's label, checked when the route reaches the step
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
places carries spawn areas, `spots = { { x, y, r, n, alt }, ... }` (in
Polestar's own pack one string, `spotsPacked`, built into these tables on the
goal's first read of `spots`, shared by every goal with the same string on the
same map and frame; PACK_FORMAT, "Format 8"): cluster
centre in the goal's `map` and frame, radius in yards, spawn count; together
they cover every spawn of the target on that map. Camps nearest to the goal's
`x`/`y` first, at most 6 (a target with 6 spawns or fewer gets a spot at every
place it spawns); with `spread = true` (an area objective, or a few places far
apart) up to 12 spread over the whole area, as a walk from `x`/`y`. The other
places follow with `alt = true`; a hand-placed point is the first spot, the
data's places its alternatives (GUIDE_FORMAT, "Spawn areas"). A `loop` step's
goals carry its `goto` points instead, in order, with `spread = true` and no
`n` or alternatives (compile-time: `resolve.js` applyLoop). `x`/`y` stay the
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
`tools/lib/dsl/escort.js`. The Engine carries it into the goal view as
`escort` and the guide window says it under the goal (`UI.EscortLine`:
"Escort: if the NPC is not there, wait for it to respawn"), once per card.
While you're here never takes an escort's accept ahead of its own step
(`Own.aheadOk`: no "Take X: saves a trip back" line, no early auto-accept),
since the NPC walks off the moment it is taken (#1618). Older Polestar
ignores it.

A dungeon's way in: the goal view's `entrance` is set on a dungeon guide's
"Enter <dungeon>" goal (Dungeons pick-up and attunement guides, Lookup's
instance and entrance guides: the generated goal's `entrance = true`) and
on every goal of a leveling guide's dungeon run (`when dungeon`,
`Own.dungeonStep`). The guide window says under it, once per card
(`UI.FinderLine`), "Need a group? Press I for the group finder." with the
player's key for the client's TOGGLEGROUPFINDER binding (`GetBindingKey`,
named by `GetBindingText`), or "Need a group? Open the group finder."
without one; never inside an instance or in a full party.

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
| `accept` | `quest`, `title` | `npc`/`npcName`, `object`/`objName`, `item`/`itemName`, `minLevel`, `qlvl`, `limit`, `pre`, `preAll`, `closedBy`, `parent`, `preTitles` | on quest **or** completed (or abandoned by the guide); a hand tick never stands for it (#739): the accept stays open with `noticeText` "<title> isn't in your quest log", and its quest's later goals stay (never orphaned by the tick) |
| `turnin` | `quest`, `title` | `npc`/`npcName`, `object`/`objName`, `rewards = { choices = { { item, itemName, quality } }, items = { ... }, xp, money }` (copper), `direct` | completed; `direct` (never accepted, so never orphaned): its QUEST_TURNED_IN during the step (latched) or the completed flag, not the session's turn-ins, so one hand-in of a repeatable closes one goal |
| `complete` | `quest`, `title` | — | ready for turn-in or completed |
| `kill` | `target` | `npc`, `count`, `quest`, `oi` | its objective finished (the quest-log line named after `target`, else line `oi`), or quest ready/completed (not while the log lists no objectives yet, right after the accept); without `quest`: manual |
| `collect` | `item`, `itemName` | `count`, `quest`, `oi` | objective finished (the line named after the item, else `oi`) / quest ready (as `kill`) / completed; without `quest`: item count ≥ `count`, or, for a single item the step's next `accept … item` starts its quest with (paired as in the step view), that quest in the log or done (accepting uses the item up) |
| `goto` | `map`, `x`, `y` | `text`, `r` (default 8 yd), `area` (its name in the client's language shows instead of `text`) | within radius, **or** gone into its `area` (subzone text equals the client's name of it, not the zone's, while indoors, after being seen elsewhere since the step came up; not for a goto after one into the same area in the step), **or** any later goal in the step is done, **or**, when only gotos, notes and goals that do not apply follow it in the step, the next step that applies is done with a quest goal of it done (`Own.nextStepDone`, counted as anchorStep counts: not a skipped step or one with `only`, not a goal with `only`; a cave's mouth or a dock ahead of work done ahead of the guide, #240) |
| `talk` | `npc`, `npcName` | — | the player acts at that NPC during this step: a gossip option picked (`C_GossipInfo.SelectOption`/`SelectOptionByIndex`, `SelectGossipOption`, post-hooked), a quest accepted, completed or handed in there (`AcceptQuest`, `CompleteQuest`, `GetQuestReward`, QUEST_ACCEPTED / QUEST_TURNED_IN while its window is open or within 2 s of it closing), or its trainer, merchant or flight window opened; a gossip or quest window only opened is no check-off (#741); else manual |
| `interact` | `object`, `objName` | `quest`, `oi` | objective state if `quest` (the line named after the object, else `oi`); else manual |
| `use` | `item`, `itemName` | `quest`, `oi` | objective state if `quest`; else manual |
| `sethome` | `location` | `npc`, `npcName`, `area` | bound at the goal's inn (`npc`'s, else the inn `location` names, in Nav/Travel.lua's data), by any of: the inn Travel finds for `GetBindLocation()` (`Nav.BoundInn`: the innkeeper learned at bind time in `flags.inn`, else the inn whose `area` the client names so, else its names); `GetBindLocation()` equal to the client's name of that inn's or the goal's `area` (`Compat.GetAreaName`); last, equal to `location` (case-insensitive). Binding at that innkeeper during the step latches it: on `HEARTHSTONE_BOUND` the innkeeper is the `npc` unit, else the open NPC window, else the last one closed within 2 minutes (the bind confirmation closes the innkeeper's window before the event, #1298). `Engine.IsSethomeInnkeeper(goal, npc)` says whether `npc` is that innkeeper (for `sethome nearest`, one of its candidates); QoL's bind helper asks it |
| `hearth` | `location` | `area` | zone or subzone equals the client's name of `area` (without one, `location`), else manual; latched once it lands in its live step. A step whose only goals are `hearth` is hidden and passed over (`Own.hearthOnly`, see "Steps the character has"). Its view's `hearthText` (`Own.hearthPlan`): with the Hearthstone waiting or missing, the time left and, where `Nav.EstimateTravel(nil, inn, nil, true)` knows the trip, "set off now" (trip ≤ wait + its 15 s cast) or "wait for it"; ready, "travel there" when the trip is within `Nav.HEARTH_SECONDS + Nav.HEARTH_MARGIN` or under `Nav.HEARTH_MIN_TRIP` (the planner's own long-haul rule), the arrow then leading to the inn as while it waits |
| `die` | `location`, `map`, `x`, `y` | — | back alive (never a ghost) within `Own.DIE_RADIUS` (40 yd) of the Spirit Healer; applies only while `Own.deathskips()`: `behavior.deathskips` on (Options, Automation > Guides, "Use deathskips"; off by default) and not Hardcore (`C_GameRules.IsHardcoreActive`), else its step passes |
| `getfp` | `location` | `npc`, `npcName`, `node`, `area` | with `node`: that taxi node among the known ones (`flags.taxi`, recorded by Nav/Travel.lua from the flight map); without: taxi map opened at a flight master of that name (persisted in `flags.fp`); else manual |
| `fly` | `location` | `area`, `node` | as `hearth`, including the in-step latch (`node`: the flight point, named in the client's language where no `area` names the place). On a travel step (`Own.transitKind`: open goals all `fly`/`goto`) its last open `fly` or `goto` goal's view carries `purposeText` (0.3.7, #1588, `Own.travelPurpose`), shown under it: the first of the next `PURPOSE_STEPS` (6) steps with open quest work for the character, "For Sputtervalve's quests" (one NPC or object taking or handing in), "For quests from X and Y" (two; "X, Y and more"), else the quests whose objectives it does ("For “The Tear of the Moons”"); only on the live or viewed step |
| `enter` | `location` | `area`, `map`, `x`, `y` | zone or subzone equals the client's name of `area` (without one, `location`), as `hearth` without the hearthstone: the in-step latch keeps it once its live step had it (`latchable`, so passing it keeps it too); the coordinates only make its waypoint |
| `train` | — | `npc`, `npcName`, `text` | a spell learned (LEARNED_SPELL_IN_SKILL_LINE) while the trainer's window is open during this step: that NPC (`npc`), one of the candidates for the character's class (`candidates` with `classes`), or, for `train class`, a class trainer of the character's class; the window opening alone is no check-off (Fitz); else manual |
| `buy` | `item`, `itemName` | `count`, `npc`, `npcName` | item count ≥ `count` (default 1) |
| `vendor` | — | `npc`, `npcName`, `text` | that merchant's window (`npc`, or one of the `candidates`; a plain `vendor`, any merchant) opened during this step; a window still open when the step comes up does not count (no carry-over for any NPC window); else manual. Beside other goals that hold the step and apply to the character it is a stop on the way, never holding the step (`Own.sideVendor`, `Own.holds`; its view's `side = true`): the step is done when those are, sold or not. A step of only vendor goals waits for the window, a tick or a skip |
| `level` | `level` | `frac` | player level > `level`, or = `level` with XP / XPMax ≥ `frac` (no `frac`: level ≥ `level`); its view's `xpLeft` is the XP still to earn (`Own.xpLeft`: the client's XP to level for the level the character is at, the 1.12 table past it), shown "1,240 XP to go" |
| `wait` | `seconds` | `text` | that many seconds after its countdown began: once every goal before it in the step that holds the route is done (`Own.startWaits`, `Own.waitStart`, for the session); its view's progress is `{ cur = seconds left, max = seconds, kind = "wait" }`, drawn as a draining line "0:23 left" (`UI.GoalBar`); `Own.watchWait` evaluates each second while one counts; latched on the live step |
| `note` | `text` | — | never blocks (informational) |
| `skill` | `skill` (name), `level` | `skillLine` | skill rank ≥ `level` |
| `learn` | `spell`, `spellName` | `skillLine`, `npc`/`npcName` (trainer), `item` (recipe item) | spell known |
| `cast` | `spell`, `spellName` | `map`, `x`, `y` | ticked by `Own.latchCast` on the player's `UNIT_SPELLCAST_SUCCEEDED` for `spell` (values read with `Compat.Readable`) while the goal is open: the live step, the step in view, or an along step listed under them; stored as a check-off (`CharState().manual`), so it is kept like the player's own tick; else manual |
| `craft` | `spell`, `spellName` | `item`/`itemName` (created), `count`, `untilSkill`, `skillLine`, `reagents = { { item, itemName, count } }` | skill ≥ `untilSkill` if set, else created-item count ≥ `count`, else manual |
| `rep` | `faction`, `factionName`, `standing` (1–8) | — | standing ≥ `standing` |
| `explore` | `map`, `x`, `y` | `text` (area name) | area at that point explored; else arrival (latched) |
| `achieve` | `achievement`, `achievementName` | `criteria` (index) | achievement (or that criterion) completed |

Objective index `oi` is 1-based, matching `C_QuestLog.GetQuestObjectives`.
Field names `npc`, `object`, `item`, `quest` always hold numeric IDs.
Objective goals also carry the quest's `title`; `accept` carries `minLevel`
from the data when the author gave none, `qlvl` (quest level), `limit` (a
timed quest's seconds once taken, quests.json `limit`: the Forever TDB's
TimeAllowed, a Forever quest's from a correction), the blocking
prerequisites `pre` (one of) and `preAll` (every one), `closedBy` (the quest
its breadcrumb leads to and the quests exclusive with it: once any of them is
taken or done the giver never offers it again), `parent` (a child quest's
parent, the data's `parent`: its giver offers it only while the parent is in
the log, #1661) and `preTitles` (titles of the
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
applies the same ones (`rust/crates/forge-addontest/tests/addontest/packs-parity.rs`). Where `Core/Guides.lua`
implements them:

- Ids: `Guides.RESERVED` (reserved pack ids) and `Guides.OwnsId` (which
  prefix a pack owns: `forever/` and `draft/` for `guides`, `lookup/` for the
  internal `lookup` pack, registered with `internal = true` and never listed
  or switchable, every `<author>/` that is a valid, unreserved pack id for
  `imported` (below), `<id>/` for every other pack). An id another pack's
  guide holds is refused, so an imported guide never takes a pack's place.
- Clashes: guides and map frames a refused pack's files register are dropped
  until that addon's `ADDON_LOADED`; guides registered before their pack are
  refused, their ids kept in a per-pack list and listed as `guide-refused`
  problems when it comes.
- Format: `Guides.FORMATS` (the formats this Polestar reads, `1` to `4`);
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
`license`, `website`, `source`, `notes`, `official` (ours), `imported` (the
imported guides' pack), `status` (the
statuses of PACK_FORMAT rule 9; `off` from `PolestarDB.packs[id].off`),
`reason`, `needs`, `problems`, `guides` (ids), `guideCount`.

```lua
Polestar.RegisterPack(meta) -> ok, err
Polestar.RegisterGuide(def) -> ok, err      -- def.pack must be registered and own def.id; validates shape
Polestar.RegisterMapFrames(frames, packId)
Polestar.Guides.Packs() -> { record, ... }  -- every pack but internal ones and `imported`, ours first, then by title
Polestar.Guides.Pack(id) -> record | nil
Polestar.Guides.PackShown(id) -> bool
Polestar.Guides.SetPackShown(id, shown)     -- PolestarDB.packs[id].off; fires PACKS_CHANGED(id)
Polestar.Guides.ProblemCount() -> n         -- over every listed pack (the Options dot)
Polestar.Guides.OwnsId(packId, guideId) -> bool
Polestar.Guides.SuggestSources() -> { packId, ... }  -- "guides", then shown packs with leveling guides (never `imported`)
Polestar.Guides.SuggestSource() -> packId   -- behavior.suggestFrom when it can, else "guides"
Polestar.Guides.OfferedBy(id) -> { guide, ... }      -- shown guides whose route choice offers id now (Engine.RouteOffered)
Polestar.Guides.DropImported(id) -> bool    -- takes an imported guide out (Import.Delete), nothing else
```

**Imported guides** (`Core/Import.lua`; the string's format: PACK_FORMAT.md,
"Import strings"). A guide shared as one line of text and pasted on the
Import page belongs to the reserved pack `imported`, which Import.lua
registers (`imported = true`) as its file loads, before any pack can. Its
guides keep their authors' ids (`yendi/cozy-sleeping-bag`), carry
`license` (the string's) and are kept in `PolestarDB.imports[id]` as
decoded. Guides.lua's login handler calls `Import.Load` after
`ScanInstalled` and before `GUIDES_REGISTERED`, so every stored guide goes
through the same checks as a pasted string with every community addon
known. The reader: the client's `C_EncodingUtil.DecodeBase64` and
`DecompressString` (zlib, as `Polestar_Nav`'s maps; a client without them
is told it cannot read strings), Adler-32 over the payload, a JSON parser of
its own (no `null`, 12 levels deep at most), then the guide built field by
field from a fixed schema of the compiler's keys and types (`Import.KEYS`;
`rust/crates/forge-addontest/tests/addontest/import.rs` holds it to emit.js's key lists), then the id,
prefix, `next`, step-cap and `Guides.Validate` checks. Nothing in a string
is run. The record is never listed on the Community guides page (`Packs`)
nor a suggestion source; the guide menu lists it as "Imported" under
Community guides, and `P.Credits` takes the guide's own `license`. Saving or
deleting fires `PACKS_CHANGED("imported")`; a guide registered again in its
place is taken by its open tab where it stands (Engine, `PACKS_CHANGED`:
`restoredTab`, so ticks and skips follow the steps it kept).

```lua
Polestar.Import.Decode(text) -> entry | nil, reason   -- entry = { format, license, guide, frames }
Polestar.Import.Preview(text) -> info | nil, reason   -- info: entry, id, title, author, version, steps, minLevel, maxLevel, faction, license, state ("new"|"update"|"same"|"older"), have
Polestar.Import.Save(entry) -> ok, reason             -- checks again, registers, stores
Polestar.Import.Delete(id) -> bool
Polestar.Import.List() -> { { id, title, author, version, license, steps, problem }, ... }  -- by title
Polestar.Import.Load()                                -- at login
Polestar.Import.LIMITS                                -- { length = 50000, steps = 60, payload = 262144, text = 4096 }
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
Polestar.Engine.GetSection(i) -> { index, title, skill, skillLine, from, to, rank, state } | nil   -- the skill range step i of a profession guide is under (GUIDE_FORMAT.md, "Sections"): title "First Aid 1-40" (the client's profession name), state "done" (the player's skill reached `to`), "current" (the first range it has not) or "ahead"; the view's `section`. The steps of a done range are done unless one trains a rank the player lacks, and a range's counted collect/buy goals ask for their count less what its `craft … until` goals would have used from `from` to the skill (Own.needOf)
Polestar.Engine.Next() / Prev() / Goto(i)    -- look at another step; changes nothing (Goto un-skips its target)
Polestar.Engine.Skip() -> stepIndex         -- skip the step shown, saved; fires PLAYER_SKIPPED_STEP
Polestar.Engine.Unskip(i) -> bool           -- undo a skip
Polestar.Engine.SkipUpTo(i) -> n             -- party sync accepted: skip the open steps from the live one up to i (ticks, skips kept); one undo of the first takes all back
Polestar.Engine.GetLiveStep() -> i | nil    -- the first open step, whatever step is shown
Polestar.Engine.LevelTarget(level?) -> N, stepIndex, frac | nil   -- the first `level N` goal from the step shown for this character (step `only`/`when`, goal `only`; skips left out) with N above `level` (default: the character's), or a point inside that level (`frac`) not reached yet; QoL's XP bar mark
Polestar.Engine.KeptItems() -> { [itemID] = stepIndex }   -- items the active guide still needs in the bags (see "Items kept for later"); built once per evaluation, read only
Polestar.Engine.StartGate(id) -> gate | nil -- a Class guide this character cannot start yet: { level } or { pre, preTitle }, with giver, map (see "Not yet available")
Polestar.Engine.AwayStart(id) -> away | nil -- another race's starting zone the player has not reached: { races, zone, zoneName } (see "Another race's starting zone")
Polestar.Engine.GoalDone(stepIndex, goalIndex) -> bool     -- the goal is done (live state, arrival or check-off); Nav/Walk.lua's FollowsGoto asks it of a guide `goto`
Polestar.Engine.ToggleGoal(stepIndex, goalIndex) -> bool   -- tick any goal but a note done, or clear its check-off
Polestar.Engine.SkipGoal(stepIndex, goalIndex) -> bool     -- skip an optional goal, or bring it back
Polestar.Engine.SkipQuest(questID, on) -> bool               -- skip a quest and what follows from it, in every guide; on = false brings it back
Polestar.Engine.IsQuestSkipped(questID) -> bool
Polestar.Engine.SkipLoses(questID?) -> { { id, title }, ... } | nil   -- the open accepts of this guide (other quests, other steps) that skipping questID, or with none the live step, would leave out; tried on the saved state and put back (see "Quests the player skipped")
Polestar.Engine.SkippedOut() -> { step, title } | nil   -- with no live step, the player's step skip that left the rest of the guide out (see "Quests the player skipped")
Polestar.Engine.AcceptGate(stepIndex, goalIndex) -> { level, short, needs = { text, ... } } | nil   -- what the game asks before it offers an accept (its tooltip's Level and Needs lines, #1247): the quest's minimum level above 1 (`short`: the character is below it) and, until the quest is taken or done, the prerequisites not handed in yet (each missing `preAll` by name; a `pre` list none of which is done as one "A or B" entry); from the compiled goal, else from the quest database when it is loaded (never loads it); nil for a goal that is no accept or one with nothing known
Polestar.Engine.LostQuestion() -> questID, title | nil      -- a quest the route had passed that left the log, held for the player's answer (see "Quests that leave the log")
Polestar.Engine.AnswerLost(questID, "back" | "skip")        -- go back to its giver, or skip it and what follows (SkipQuest)
Polestar.Engine.AimGoal(stepIndex, goalIndex) -> bool[, "accept", title]  -- lead the arrow to a goal of the current step (a click on its line, on the step's header for the header group's first open goal, or on its map pin: #1653, so the arrow keeps its spots); a goal whose quest waits for its accept in the step leaves the arrow on that accept: false, "accept", the quest's title (the window says "Take <quest> first")
Polestar.Engine.GetAlong() -> { { index, title, untilStep?, goals = { goal view, ... } }, ... }  -- open goals of along steps behind the live step; untilStep: an `along until` step's labelled step
Polestar.Engine.AimAlong(stepIndex, goalIndex) -> bool     -- lead the arrow to one of them (row click); holds while it is listed
Polestar.Engine.GetWaypoint() -> waypoint | nil
Polestar.Engine.GetProgress() -> doneSteps, totalSteps
Polestar.Engine.StepNumber(i) -> number, hidden     -- step i of the active guide as the player counts it (see "Steps the character has")
Polestar.Engine.StepTotal() -> number               -- the steps the player sees
Polestar.Engine.StepNumberOf(guide, i) -> number, hidden; Polestar.Engine.StepTotalOf(guide) -> number  -- the same for any guide
Polestar.Engine.StepHiddenFor(step, who?) -> bool  -- no step of its own for who = { class, race, faction } (default: the player); party sync counts the steps both have
```

#### Smart logic

- **Candidate goals.** A compiled goal may carry `candidates = { { npc, npcName, map, x, y, z?, f, faction = "A"|"H"|"AH", races?, classes? }, ... }`
  (from `train <Profession>`, `train class`, `buy … nearest`, `vendor nearest`, `sethome nearest`; see GUIDE_FORMAT).
  The Engine filters by the character's faction (and races/classes when given),
  then picks the cheapest by `Polestar.Nav.EstimateTravel(from, to)` seconds when
  Nav provides it, else world distance on the same continent with a large penalty
  across continents. A candidate in a zone whose level range (`Maps.GetZoneLevels`)
  starts more than 10 levels above the character comes after every other
  choice, other continents included. A `train class` goal carries its step's zone
  (`zone`, a uiMapID): when that map has a candidate for the character, every
  candidate off it comes after all of the map's, unless it stands within 100 yards of the
  player, so the step's town wins wherever the step comes up (#1357). It re-picks on step start, zone change and landing, never per
  frame. The goal view then carries the chosen `npc`, `npcName`, `map`, `x`, `y`,
  `f`, plus `alternatives = n`; `Polestar.Engine.CycleCandidate(stepIndex, goalIndex)`
  moves to the next-best one. Profession `train` goals are done when the
  profession's max rank reaches that rank's cap (75/150/225/300), so a trainer
  anywhere counts. `train class` is done on a spell learned at a candidate
  of the character's class (its `classes`) during the step, or when there is
  nothing new to learn: the character last learned a spell at its class
  trainer, or opened one whose list had no "available" service
  (`classTrainVisit`, on TRAINER_SHOW and TRAINER_UPDATE; not with the
  list's "available" filter off), at this level, or at the even level below an
  odd one, since class trainers teach on even levels only. Opening a
  trainer's window that lists a spell to learn is no check-off (Fitz).
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
  so the spots form a circuit. Dwell (Fitz, 2026-11-09): when the player has
  stood within the arrival radius of the waypoint's place (a camp, a searched
  spot, a field goal's point) for 7 s (`Spots.DWELL`), moving at most 10 yd
  (`Spots.STILL`: running across a wide camp never counts), out of combat, with no
  progress on the goal (`Own.workSign`: its count, a level goal's XP; a change
  or a fight starts the count again), and with no fight or progress noted
  within its radius and 40 yd around it in the last 300 s (`Spots.noteWork`
  keeps where the player fought or progressed, by position, so the ground
  counts for every goal with a place there; `Own.workedNear`: a camp being
  cleared keeps the arrow through the drink and the walk to the next pull,
  and moving on never picks it again), the place is left (`Spots.left`, for
  `Spots.FORGET`; work inside it later brings it back): the arrow moves on to the nearest place not left, never
  back to one left while another is open (all left: the one left longest
  ago). Among a step's several field goals (the tour, see "Current goal and
  waypoint"), a place of the tour that is left has the tour planned again
  without it, and a goal whose places are all left measures no distance and
  leaves the tour, so one of the step's other open field goals takes over
  (`Own.nearestField`). A
  spot picked by hand is not counted until reached. The automatic picks (a
  goal's spot, the tour's stop) hold while the player fights
  and 5 s after a fight or progress (`Spots.busy`, `Spots.SETTLE`): the arrow
  never moves under a fight or right after a kill. Spots with `alt` are never
  picked by these rules; they are reached by hand and, once picked, hold like
  any current spot (camps: until another spot is 40 yd nearer). Levels (#827): a kill or
  collect goal's spot carries `lvl`, the highest level of the mobs spawning in
  it (compiled from the data; with a level for every spot, the goal's own `lvl`
  is the one most share and a spot carries `lvl` only when it differs; a
  `loop` step's points carry none). While a goal
  has a spot whose mobs are at most one level above the player
  (`Spots.ABOVE`) and one above that, these rules leave the higher spots as
  they leave alternatives (a current one above is left at once); with none at
  the player's level every spot counts. A step with several open field goals
  likewise tours only the goals that have such a spot, by those spots (a spot
  without `lvl`, or a goal without spots, counts as at the player's level),
  and only with none all of them by every spot; a level up plans the tour
  again. `Engine.CycleSpot(stepIndex,
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
  A click on the step's header (its group's first open located goal) or on a
  step goal's map pin (Nav/Layers) aims the arrow at that goal (`AimGoal`)
  rather than setting a point by hand (#1653): `Nav.NextSpot`, a click on the
  arrow, only moves the Engine's waypoint on, so a point by hand held the
  arrow on one spot. An Along the way goal's pin still sets a point.
  Cycling a goal of the current step (spots or candidates) aims the arrow at
  that goal (`AimGoal`), whichever goal it pointed at before, and the window
  releases any point picked by hand (`Nav.ReleaseTarget`), so the arrow moves
  to the chosen spot at once. `Engine.SpotIndexOf(goal)` gives the index of
  the spot the arrow takes for a guide goal (the chosen one, else the nearest
  to the player), changing nothing: a collect with `fromNpcsAt` has the
  target button name that spot's own mobs (#1616).
- **Race names.** `"Scourge"` and `"Undead"` are the same race everywhere a race is
  compared (Forever's client name is unconfirmed).
- **Context-aware Suggest.** `Guides.Suggestions()` orders the leveling guides
  that fit faction/race/class and level: the one whose zone is the player's
  current zone first, then the nearest by travel; ties keep the race's own
  chain. `Suggest()` is its first. The hub's Home lists all of them under
  "Suggested for you", open ones included (marked with their tab), then an
  open guide's follow-up once the player is one level below it (0.3.7; it
  was two).
- **Out-levelled guides.** When the player's level exceeds the active guide's
  `maxLevel` by 2 or more, the Engine fires `GUIDE_OUTLEVELED(guideId,
  suggestedId)` once per guide per session, once the guide is placed (a
  catch-up may pass it whole first); the UI offers the jump. Setting
  `behavior.skipGrey` (default off; leveling guides only, see "Every step")
  auto-skips `accept` goals for quests already grey for the character (and
  `turnin ... direct` goals, which the compiler gives their quest's level
  too), and with them the quests' turn-ins and objectives,
  unless the quest is a prerequisite (`pre`, `preAll`) of a quest later in the
  guide or its chain that is not grey, directly or through other grey ones.
- **Class-training reminder.** Class trainers ship in the core:
  `Core/ClassTrainers.lua` (generated by `forge data trainers`,
  one trainer per town and class, with the Era frames of their maps) calls
  `Polestar.RegisterClassTrainers({ { npc, npcName, map, x, y, f, faction, classes }, ... })`,
  then `Polestar.RegisterClassTrainerIds({ WARRIOR = { npcId, ... }, ... })`
  with every class trainer in `trainers.json`, not only one per town.
  `Engine.NearestClassTrainer()` returns the best one for the character (same
  ranking as candidate goals) or nil; `Engine.IsClassTrainer(npc)` whether an
  npc is any class trainer of the character's class, from the full id list
  (training reminders only; players buy spells themselves).
  Opening the trainer window of one of the character's class stores
  `CharState().classTrainLevel = level` and fires
  `CLASS_TRAINED(level)`; a character first seen without a stored level counts
  as trained at that level. With `behavior.trainReminder` `"2"` (default; even
  levels only), `"1"` or `"off"`, the Engine fires `TRAIN_DUE(level, trainer)`
  once per level when `level - classTrainLevel >= N`, unless the active tab's
  live step (not the one on screen) or its next applicable steps (4 in all) hold an applicable class
  `train` goal (an npc in the registry or `train class`). The trainer named is
  the one with the least detour on the guide's route (the first open goal with
  coordinates of each of the next 8 applicable steps from the live step,
  `Engine.NearestClassTrainer(true)`);
  straight lines shortlist 4 trainers of the best continent and zone-level tier
  and the route planner (`ns.TravelCost`) prices each one's best leg; a trainer
  within 15 seconds of a nearer one loses to it, and a guide with no route
  ahead gets the nearest one. The UI shows a slim
  banner with Show (temporary `Nav.SetTarget`) and Later, cleared by
  `CLASS_TRAINED`; Options → Guide → Automation → "Trainer reminders". What
  the banner names comes from `Engine.TrainingAdvice()`, live at each layout
  (the level-up spell card asks the same function, so the two always
  agree): when the guide's own training stop (`Engine.GuideTrainStop`) is at
  most `Engine.TRAIN_GUIDE_NEAR` (10) applicable steps ahead, the banner
  names that ("The guide trains you in 10 steps (Orgrimmar).", or "Your
  guide's current step trains you.") and no other trainer, without Show;
  otherwise the planner's pick above (the notice's trainer when the engine
  has none). The route planner prices a walk it has not measured as a
  straight line × 1.25 (`Nav.EstimateTravel`: walks into a live target are
  measured by the walking engine, candidates' are not), so a straight line
  across the Barrens–Durotar river canyon once named Jen'shan in the Valley
  of Trials to a Tauren at the Crossroads whose guide trained in Orgrimmar.
  With `behavior.offerClassQuests` (default on; QoL/ClassQuests.lua), a
  Class guide that opens for the character (`GuideMatches`, its gate gone,
  `Engine.StartGate`, nothing of it under way) fires `CLASS_QUEST_READY`
  on level-up, a turn-in or login, and the banner offers it in a tab (Later:
  again at a higher level; dismissed: never; `CharState().flags.classOffered`),
  one at a time; Options → Guide → Automation → "Offer class quests". Since
  0.3.7 it waits for one level below the chain's first quest's level
  (`ClassQuests.QUEST_MARGIN`; the accept's compiled `qlvl`), not for the
  game's first offer 3-5 levels earlier; the guide list opens it from its
  gate as before.
- **Conditions checked during play.** A step with `when` (format 4;
  GUIDE_FORMAT, "Conditions checked during play") applies only while every
  predicate holds (`Own.whenFails`, `Own.predicateHolds`): the level, quests
  in the log, ready to turn in, handed in or available (an accept's own
  test: level, `pre`/`preAll` through `missingPre`, `closedBy`), the money
  held (`Compat.GetMoney`, copper), an item count in the bags, the zone or subzone text, the bind location (place
  names as the area's name in the client's language, `Compat.GetAreaName`,
  else as written), the dungeons the player chose to run
  (`Engine.DungeonChosen(map)`: `CharState().dungeons[map]`, set by
  `Engine.ChooseDungeon(map, on)` from the Options' "Dungeons in leveling
  guides", none by default; a predicate without `map` never holds),
  Polestar's gear advice on an item (`Own.isUpgrade`: `Gear.IsUpgrade`,
  counted as an upgrade when the advice is off or cannot judge the item), a
  profession's rank (`Compat.GetSkillRank` by skill line, else by name; not
  learned is 0), and an item or spell on cooldown (`Own.onCooldown`: longer
  than the global cooldown and not run out; it times an update for when it
  ends, and `BAG_UPDATE_COOLDOWN`/`SPELL_UPDATE_COOLDOWN` update once a guide
  has asked), whether the character knows a spell (`Compat.IsSpellKnown`,
  else `Compat.IsPlayerSpell`; `SPELLS_CHANGED` updates), and the player's
  answer at a group quest (`Own.groupAnswer`:
  `CharState().groupQuests[q]`, "do" or "skip", set by `Engine.AnswerGroup`
  from the guide window's banner or Options, Discovery, Group quests;
  `Engine.GroupQuests` lists a character's; a quest not answered takes
  `behavior.groupQuests`, "do" or "skip" for all of them, or "ask", none,
  re-evaluated on `SETTING_CHANGED`; Options, Guide, Automation, "Group
  quests", shown while `GroupQuests` lists one). An unanswered `group` predicate
  holds and `stepDone` is false while `Own.groupPending` names its quest (not
  on an along step), so the route waits at the step; `Engine.GroupQuestion`
  gives the banner the quest, and `Own.wantsFrom` keeps automation off it. `stepApplies` reads them, so such a step counts as one
  for other characters while they fail, and a turn-in whose only accept sits
  there goes with it (`orphaned`). When the route moves past a step
  (`latchPassed`), its outcome is stored per character (`Own.latchWhen`): a
  `when` that held in `CharState().when[guideId][step]`, one that failed as
  a skip in `CharState().skipped`, read from then on (`Own.whenHolds`): a
  step passed because its condition failed never comes back when the
  condition changes, one that applied stays applied, and `Unskip` brings a
  wrongly stored step back (storing it as held). Nothing is stored before
  `QUEST_LOG_UPDATE` (`logReady`; the log lags `PLAYER_LOGIN`):
  `Own.latchCaughtUp` stores the steps passed meanwhile once it can.
  `ResetProgress` forgets them; a pack update moves them with the steps
  (`Own.remap`). The live state they read already re-evaluates the guide
  (quest log, `BAG_UPDATE_DELAYED`, zone changes, `PLAYER_LEVEL_UP`,
  `PLAYER_XP_UPDATE`, `HEARTHSTONE_BOUND`, `PLAYER_MONEY`, `GEAR_UPDATED`), and `Engine.ChooseDungeon`
  asks for an update itself. A `level` predicate with `frac`
  (`when level>=12.5`) compares the level plus the share of it done
  (XP / XPMax) with `n + frac`.
- **Along the way.** A step with `along` (format 4; GUIDE_FORMAT, "Along
  the way") counts as done (`stepDone`), so the route passes over it and
  latches it like any passed step (a `when` on it is stored then). While the
  live step is past it, it applies and was not skipped, `Own.alongListed`
  holds and `Engine.GetAlong` lists its open goals (status `active`), until
  they are done or, with `along = "<label>"`, until the live step reaches
  the step labelled so (`Own.marksOf`: labels and along steps per guide).
  Their statuses are in the step signature, so progress fires
  `STEP_UPDATED`. `Engine.AimAlong` sets `aim` to such a goal: `findWaypoint`
  leads there (`waypointOf` with the goal's own step) while it is listed and
  open, and a step change keeps it. When the current goal is a `turnin` of
  a quest that is not ready while listed along steps hold its work
  (`Own.alongWork`: goals past their label kept by `Own.alongHeld`, #853),
  `findWaypoint` leads to the nearest of those with a place
  (`Own.alongAim`) instead, until the quest is ready; that turn-in's goal
  view has `pinOpen = "along"`. The guide window lists them under "Then:"
  ("Along the way", `fillAlong`, at most six rows, not in compact mode);
  "Then:" and Up next skip along steps (`GetStepView(i).along`).
- **Pinned quests** (#644). The player pins a quest of the log as along the
  way (`Engine.PinQuest`, from the window menu's step entries `GF.PinItems`
  and the quest log's `MENU_QUEST_MAP_LOG_TITLE` menu); pins are per
  character (`CharState().pinnedQuests`, quest id -> true) and a quest
  turned in drops its pin (`Own.pinList`). While the quest is in the log
  with a line open, `Engine.GetAlong` lists one goal per open line after
  the along steps (`Own.pinGoals`): the guide's first open objective goal
  bound to that line (`Own.objectiveLine`), else one built from the quest
  database (`Own.pinBuild`: its mob, item or object at that one's spawns on
  the player's map, else the map with most, as `spots`; without a record,
  the log's label by the line's type) at step `Own.PIN_STEP` (0), goal
  `quest * 100 + line`. Each listed goal view carries `step`, and
  `Engine.AlongGoal(step, goal)` returns its goal: `AimAlong` accepts it
  (`Own.pinListed`), and the map's goal marks and spawn areas (Nav/Layers)
  and the target button (QoL/Buttons `TargetNames`) take the Along the way
  goals after the step's. Their statuses are in the step signature. A
  `turnin` at or after the current step of a pinned quest whose lines are
  open has `pinOpen` (true) in its goal view: its row and its Up next line
  show in the warning colour and say so ("along": the same, without
  "Pinned").
- **Ticked objectives** (#1135). A quest objective goal (kill, collect,
  interact or use with `quest`) the player ticked by hand
  (`Engine.ToggleGoal`, `"tick"` in `CharState().manual`) is done for the
  route, which moves on, but never for its quest: while the game still
  counts it open and the quest is in the log not ready (`Own.tickedOpen`),
  the quest's `turnin` keeps its step (it still blocks) yet takes no focus
  (`stepGroups` counts it as held), so the arrow does not lead to the
  ender; its goal view has `pinOpen = "ticked"` and the window says to
  finish the objectives first.
- **Background goals** (#1135; GUIDE_FORMAT, "Background goals"). A
  `background` along step is compiled as the along step it is: the
  `background` line only drives the lint (a finish step before the
  hand-in) and the writer.
- **Dynamic Questing (While you're here).** While the player works the live step, an open
  objective of a later step whose quest is already in the log, close by,
  becomes a line under the step, up to `HERE_SHOW` (3) at once
  (`Engine.GetWhileHereList`, nearest first, `Engine.GetWhileHere` its
  first: each the goal view of its later step with `step`, `here` = "work" |
  "turnin", `left`, `yards` and `hereText`, "Kill Kobold Vermin, 2 more";
  `Engine.AimWhileHere(i)` and `Engine.DismissWhileHere(i)` take the line's
  place in the list, 1 by default). `Own.hereBuild` builds the
  candidates (`Own.hereAll`, route order) in `evaluate` only when something
  changed them (`Own.hereDirty`: a step change of the active tab, another
  guide, the quest log, the level, a new zone, the `behavior.whileHere*`
  settings): the open kill, collect, interact and use goals with a place on
  the player's continent, whatever zone map it is on, in every step of the
  loaded guide after the live step (a trip away and back, a flight or a hearth
  in between change nothing; never another tab's guide or the next guide; Fitz,
  0.3.6: no zone of the guide stops it), each for a quest in the log and not ready, for
  the character (`stepApplies`, `goalApplies`), not skipped, not shown
  already (an open goal for the same objective in a listed along step,
  background goals included, `Own.hereShown`, or a pinned quest: Along the
  way lists them; a later along step not listed yet counts like any step),
  not an objective the live step works itself, with mobs at most
  `HERE_ABOVE` levels over the player, whatever is left (no size cap: the
  player is there already). One objective is one line however many steps
  hold it (`Own.hereGroups`, by `Own.hereKey`: the quest's objective `oi`,
  else the item collected or the mob killed; Fitz, 0.3.6: Raptor Horns read
  three times, from steps 21, 34 and 45): each step's copy stays a candidate
  with its own places, in one group (`e.group`); only one shows, measured to
  the nearest copy (`Own.hereNearest` hands the line over, its serial kept),
  its row naming the earliest step (the view's `firstStep`, `later` from it);
  a dismiss or an expiry is for the whole group. A hand-in or a pick-up keeps
  only its first step. With `behavior.whileHereTurnins`, a later
  `turnin` of a ready quest counts too, weighed by what it costs rather than
  by its distance (a hand-in is a short walk to one NPC and a click): its
  detour (`Own.hereDetour`, on every poll: the seconds of extra walking to
  visit the NPC and go on to where the waypoint leads, against going there
  straight; straight lines `HERE_WINDING` (1.25, Nav's `WALK_DETOUR`) times
  longer at `HERE_SPEED`, as the router counts open ground; headed nowhere
  or to another continent, there and back) at most
  `behavior.whileHereTurninSeconds` (0 to 60, 20 by default, Options'
  "Hand-ins: how far out of your way", apart from "How close"; 0: in town
  only), or any detour for an NPC within `HERE_TOWN` (100) yards while the
  player rests in a town (`IsResting`: an inn's or a city's rest area, the
  same town); never past `HERE_FAR` (250) yards, however little the detour.
  It shows once the walk confirms it (`Own.hereTurninOk`, in
  `Own.hereMayShow`): not on another floor (the goal's `z` against Nav's
  walking floor, more than `HERE_FLOOR` (8) yards apart: Undercity's
  levels, a Thunder Bluff rise), in town a walk at most `HERE_WALK` times
  the straight line, else the router's detour (`Nav.EstimateTravel` there,
  on to the waypoint, less the waypoint straight from here) within the
  seconds: an NPC across a river is minutes out of the way. One turned away
  (`Own.hereWalked`) is weighed again `HERE_RECHECK` (15) s on, after
  `HERE_REPICK` yards moved, at another waypoint or a new setting, never
  quiet for the zone. It goes once out of town with its detour past
  `HERE_CLEAR` times the seconds and `HERE_SLACK` (10) more, or past
  `HERE_CLEAR` times `HERE_FAR`. One the route walks to about now is left
  to the guide (`Own.hereSoon`, by walking since 0.3.7, no longer "the next
  2 steps": the Dynamic Questing audits counted 27 hand-ins held back while
  the route walked 150 yd and more away first): following the open goals
  with a place from the live step on, in order, the route gets to the
  hand-in's own step or an open goal at the same NPC or object with every
  place on the way within `HERE_SOON_NEAR` (100) yards of the NPC, at most
  `HERE_SOON_SECONDS` (60) of walking between them, within
  `HERE_SOON_STEPS` (8) steps; a place further out or on another continent,
  or an open `level`, `fly`, `hearth`, `wait` or `die` goal with no place
  (`HERE_SOON_AWAY`), leads away first. The guide sends the player there in
  a moment, unless the player stands
  at the NPC: within `HERE_AT` (30) yards a hand-in shows whatever its step
  or detour (0.3.5's reach; with the seconds above 0 or in town), and stays
  while there (`Own.hereAt`); a "soon" one goes past `HERE_CLEAR` times
  `HERE_AT`. Fitz on 0.3.6 walked past Seer Graytongue with Rites of the
  Earthmother ready while the guide sent him 411 yd north to Grull and
  then back to the Seer: the route led away, so the hand-in is no "soon"
  one. A hand-in whose NPC the route comes back to in its next `AHEAD` (5)
  steps is the whole visit there when every open goal of that step is a
  hand-in ready now or an accept there that may be taken now
  (`Own.hereVisit`, `Own.aheadOk`, below): one line "Hand in X to Y, then
  take A, B: saves a trip back", its seconds raised by the trip back it
  saves (`visit.credit`: the route's walk from its last place before that
  step to the NPC and on to the first place after it, less the walk that
  skips the NPC; straight lines `HERE_WINDING` longer at `HERE_SPEED`; not
  with the seconds at 0). When waiting costs XP (`Own.hereXpLoss`: at the
  guide's hand-in the character will be more levels over the quest than now,
  past the 5 that keep its full reward, `Levels.Share`; that level from the
  guide's `level` goals on the way and, with the Codex, `Levels.ForGuide`
  of the steps between, `Own.herePlanned`), it may be `HERE_XP` (2) times
  the seconds out of the way.
  Accepts ahead (`Own.aheadWants`, Automation): at an NPC's window,
  auto-accept also takes an accept of that NPC (`npc`) in any later step of
  the loaded guide for the character, so the route need not come back; the
  goal then reads done, the live step and the arrow stay. Only when
  `Own.aheadOk`: the step and goal apply and are not skipped, no unanswered
  group question in the step, no `optional` accept, a `group` (elite,
  dungeon) one only after the player said "do", the quest not skipped,
  closed, dropped by an `abandon` of the guide, below its `minLevel` or more
  than `HERE_ABOVE` (2) levels over the character (`qlvl`), the log keeping
  `LOG_SPARE` (2) slots free (`Own.logRoom`, of `Compat.GetLogCap`: Forever's
  client answers 0 to `GetMaxNumQuestsCanAccept`, and its log holds 40), and
  a timed quest (`limit`) only in the route's next `AHEAD` (5) steps and when
  the route's walk from the NPC to its hand-in (open goals with a place in
  order, `GOAL_SECONDS` (10) each) fits `LIMIT_SHARE` (0.6) of its time
  (`Own.aheadLimitOk`; no hand-in in the guide or one on another continent:
  not taken). The same check runs on the window the game opens after a
  hand-in (a follow-up: Thork's The Disruption Ends after Disrupt the
  Attacks). Each quest a gossip, greeting or quest window offers that
  auto-accept leaves gets a debug-log line saying why (`Engine.AcceptRefusal`).
  Pick-ups (Fitz on 0.3.6, walking past Thork with The Disruption Ends open
  since Disrupt the Attacks went in earlier): with
  `behavior.whileHereTurnins`, whatever the auto-accept setting, such an
  accept whose prerequisites are done (`Own.READY_NONE`), never a timed one,
  is a line of its own, kind "take": "Take X from Y: saves a trip back",
  weighed as a hand-in (the same seconds, town, `HERE_FAR`, `Own.hereSoon` and
  walk rules), one per quest and none an NPC's whole visit names, at most
  `HERE_TAKES` (2) of the `HERE_SHOW` lines. Clicked, the arrow points at
  the NPC; with auto-accept on, talking to them takes it (`Own.hereWants`
  "take"); taken, the line goes. A turn-in (`QUEST_TURNED_IN`) builds the
  candidates again, so the follow-up comes up where the player stands.
  Lines of the route's next `AHEAD` steps (`near`) rank and list before
  those further on, which read "Step N, later in this guide".
  A build reads the goals on the player's continent: `Own.hereGoalsOn`
  indexes each guide's goals with a quest and a place by continent once
  (weak per guide; again `HERE_INDEX_RETRY` (10) s on while a goal's map is
  not known yet).
  Flight paths passed (0.3.7, Fitz; `behavior.whileHereFlights`, on by
  default, Options' "Flight paths you pass"): a friendly flight master
  (`Nav.UnknownTaxiOn`: the travel data's nodes on the player's continent
  for the character's faction or neutral, and its class, that Nav does not
  know, those learnt while Polestar was off included, #1308) within the
  radius is a line of its own, kind "flight": "Learn the flight path at
  Thelsamar" (the node's name in the client's language before the comma),
  under it the later step whose `getfp` learns it ("Step 25"), else "Flight
  path"; a click leads the arrow there (the waypoint's step is `FLY_STEP`,
  -2, which no guide step has). One at a time, after the quest lines (it
  joins only while fewer than `HERE_SHOW` show), measured to the flight
  master as an objective is (`HERE_RADIAL`: the radius, `HERE_CLEAR`, the
  walk check), with the lines' dismiss, expiry and blocks; not while a timed
  quest's clock runs. Candidates: `Own.hereFly` (`Own.hereFlyBuild`, with
  each build), each travel-data node's goal (at the node's own world point)
  and entry kept while the node is (`Own.hereFlyOf`, weak by node), so a
  dismiss holds across builds. Learning it (the flight map, "New flight path
  discovered", `TAXI_NODE_STATUS_CHANGED`: Nav marks the node known, a build
  follows) ends the line and ticks the guide's later `getfp` goal for that
  flight master (`fpKnown`), as an early pick-up does; the live step stays.
  The arrival poll measures at most `HERE_MAX` of them (`Own.hereList`): all
  when that many fit, else the nearest (`Own.herePick`, again each
  `HERE_REPICK` yards the player moves). It (`Own.hereTick`, allocation-free:
  cached world points, no tables, a message only when the shown distance
  moves by `HERE_STEP`) measures from the player, wherever the live step's
  target is: of those within `behavior.whileHereRadius` yards of the centre
  of a place the target spawns (`Spots.dist`, never an area's edge: a zone-wide
  area's edge was in reach while its spot, where the arrow leads, was 393 yd
  off; once aimed, the spot the arrow leads to, so the row and the arrow say
  the same yards) at the player's level (every spot, `alt` ones included: Fitz
  stood among Zhevra Runners in an alternative camp 33 yd off while the
  nearest picked spot was 94 yd away), or with one of their mobs in sight
  (`Own.hereSaw`: a nameplate, the target, the mouseover for `HERE_MOUSE`
  s; the goal's `npc`, its named drop source and, with the quest database
  loaded, every creature that drops its item, `Own.hereNpcsOf`; it counts as
  `HERE_SEEN` yards and skips the walk check), the one whose target spawns in
  the fewest places on the map (`places`, its spots with the alternatives;
  a point counts 1), then the nearest, ranks first; while fewer than
  `HERE_SHOW` lines show, the best in reach join in that order (with all
  shown, the poll measures only them; each keeps its own time, distance and
  dismiss). The rows read nearest first: a new one takes its place by
  distance, and a row moves up past the one above it only once `HERE_ORDER`
  (30) yards nearer, so rows do not jump. The ranking picks which show, so a pool or camp
  wins over mobs found all over the zone, after one budgeted walk check
  (`Own.hereMayShow`: not on a boat, and `Nav.EstimateTravel` at most
  `HERE_WALK` times the straight line); it goes past `HERE_CLEAR` times that
  radius (at most `HERE_CLEAR_MAX`, 600 yd; the radius is 180 by default, 60
  to 400), once done, after `HERE_SECONDS` out of reach while still inside
  that clear distance (in reach, a spawn area near or one of its mobs in
  sight, it never expires: Fitz went AFK among the Zhevra Runners and the
  line went), or on `Engine.DismissWhileHere`.
  Nothing appears, and nothing goes by distance or time, during a fight. A
  dismissed line is muted (`Own.hereMuted`): it may come again once
  `HERE_MUTE` (2 minutes) have passed and the player has been
  `HERE_DISMISS_AWAY` (100) yards from where they stood when dismissing it,
  then in its reach anywhere, the same spawn area too (the Fungal Spores grow at one pool).
  Dismissed a second time in the zone stay it stays quiet for the
  rest of it (`Own.hereStrikes`, `Own.hereQuiet`; all emptied when
  `GetRealZoneText` changes). An expired one comes again once in reach,
  `HERE_AGAIN` s on at the earliest (`Own.hereAgain`). Never in an instance, on a taxi,
  while a Hearthstone or Astral Recall is cast, or while the live step
  escorts (`Own.hereBlocked`): there the lines shown
  hide and wait (`Own.hereHeld`; nothing new, nothing goes or counts as
  left), and back they show as they were, their time starting anew, with no
  chime or ping (their `appeared` unchanged). With a quest timer running
  (not ready, not failed) only the timed quest's own lines come; the others
  wait parked as they were (`Own.herePark`) and show again, in their places
  by distance, once the clock stops (`Own.hereUnpark`). A timed quest's line
  (`Own.hereTimed`: `Compat.QuestTimers`, or Quests/Timed.lua's clock for a
  delivery the client does not report) ranks before every other
  (`Own.hereBefore`).
  The line never takes
  the arrow: `Engine.AimWhileHere` sets `aim` to its goal (`findWaypoint`
  leads there while it shows, a step change keeps it), and when the line
  goes `aim` is cleared and the arrow returns to the guide. Messages:
  `WHILE_HERE_CHANGED` (a line came, its count changed, it went) and
  `WHILE_HERE_MOVED(yards, i)`. The window draws them between the step's goals and
  "Then:" (`GF.FillHere`, in every mode and style), the toast says it with the window hidden
  (UI/WhileHere.lua), and a line that appears (a new `appeared`, a line
  coming back too, whichever row it takes) plays a soft chime, "star twinkle"
  (`behavior.whileHereSound`, `Media/Sounds/while-here.ogg`, our own
  synthesized file, `tools/sounds/while-here-chime.py`, on the SFX channel, at least 5 s apart so several at once chime once; a line already up never chimes again). Nav/Layers
  draws each line's mark and spawn areas in the accent on both surfaces (layers
  `nav.here`, an edge layer, and `nav.hereAreas`) until the arrow leads
  there; each mark carries its line's `appeared` as its Pins `ping`, so it
  pings once on the minimap as the line appears. The quest item button falls back to its item
  (QoL/Buttons `ChooseQuestItem`). The target button names the lines' kill
  and collect mobs after the step's own mobs (or alone), one from each line
  nearest first, the arrow's line first (QoL/Buttons `TargetNames` with
  `here`; #1441). On a step whose goals are NPCs they come after the NPCs
  while the player is within `behavior.whileHereRadius` of one of them, and
  before the NPCs farther off (`npcSpots`/`npcsFar`; #1623); a check each
  second re-orders them as the player crosses the radius, and each name takes
  its own kind's mark and ping. The step key, while it targets or has nothing
  else to do, takes the same names alone (`HereNames`) after the step's own,
  as many as fit its macro, and on an NPC goal after or before the NPC the
  same way (`StepAction`; `behavior.whileHereStepKey`, on by default; #1316,
  #1623). Both macros change only out of combat (`QoL.Secure`). An item keeps the step key, including the
  first line's item that `ChooseQuestItem` falls back to (its `use` item or
  its quest's log item). Done early, the later step is done or shorter
  when the route gets there, as any objective done ahead.
- **Timed quests** (Quests/Timed.lua, 0.3.6). While a timer runs, its quest's
  open goals in the window (card, full and compact, and the While-here
  rows: `UI.GoalLine`, `UI.HereText`) end in "M:SS left" after an hourglass,
  warning colour under `Timed.WARN` (120 s), danger under `Timed.DANGER`
  (60); `QUEST_TIMER` each second repaints them (`GF.TimerTick`). The clock
  is `Compat.QuestTimers` (the old `GetQuestTimers` with
  `GetQuestIndexForTimer`, else `C_QuestLog.GetTimeAllowed` total less
  elapsed, ready quests included: the hand-in is timed too), else the
  accept's server time plus the `limit` of the guide's accept, else of the
  quest database (`QuestDB.TimeLimit`: Polestar_QuestDB's 20th quest field,
  quests.json's `limit`; 0.3.7) (`CharState().timedAccepts`); each deadline only moves earlier. A chat line
  and a Master-channel sound at 5 and 1 minutes left and when the quest
  fails (`qol.questTimerAlerts`); the shown step's turn-in of the quest (else
  its last goal of it) carries "The way to X takes about N min, longer than
  the time left" when `Nav.EstimateTravel` to the route's hand-in says so
  (every `Timed.READ_EVERY` s). An open accept with a `limit` says "Timed:
  N min once accepted" (`UI.GoalSubline`). The arrow shows the same
  countdown between its distance and its label (`Arrow.SyncTimer` on
  `QUEST_TIMER` and a new target): its target's quest's (the Engine
  waypoint's `quest`), else the timer that ends first (a flight or walk on
  the way to a hand-in has no quest). A failed quest (`C_QuestLog.IsFailed`)
  loses its countdown at once (`Timed.Countdown`; goals the Engine greys,
  `lost`, never carry one); the Engine's "failed: abandon it and take it
  again" and the failure alert say the same thing. A running timer whose
  hand-in the active guide does not make from the live step on (0.3.7:
  Apothecary Zamah on the Barrens route) opens the While-here panel with a
  row of its own above the others (`Timed.OffRoute`, `GF.FillHere`):
  "<quest>  M:SS left", under it "<zone> ~N min · this guide doesn't go
  there" (the Codex ender's nearest spawn, `Lookup.QuestEnd`;
  `Nav.EstimateTravel` each `Timed.READ_EVERY` s; danger colour when longer
  than the time left); the panel's label reads "Timed quest" when no other
  row shows. A click points the arrow there (`Timed.AimOff`: `Nav.SetTarget`
  with the spawn's `z`), a right-click hides it until the timer ends
  (`Timed.MuteOff`). In combat such rows never come or go (`GF.offs` is
  kept; `PLAYER_REGEN_ENABLED` catches up).
- **Jumps.** A step with `skipto` (format 5; GUIDE_FORMAT, "Jumps") is
  checked when `computeCurrent` reaches it as the first open step, once the
  quest log can be read (`logReady`): `Own.jump` takes the first jump whose
  predicate holds (`Own.predicateHolds`) and saves the step and every step
  before the labelled one as `"jump"` in `CharState().skipped` (a skip already
  there stays), and `computeCurrent` goes on from there. A step done before
  the route reaches it never jumps. `Unskip`, and `Goto` on a jumped step with
  `skipto`, mark it in `CharState().when` (`Own.keep`), so it takes no second
  jump. A `done` predicate (`Own.labelDone`) holds when the labelled step
  applies, is not skipped and its goals are done (`Own.goalsDone`, which is
  `stepDone` without the along pass).
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
  Shadowbreaker, not the Dwarf's). So does one the guide does not turn in
  for the character that the player holds, unless they skipped it: another
  giver's version of a breadcrumb the guide takes elsewhere, handed in at
  the same NPC (a Tauren Shaman's Call of Water from Thunder Bluff where the
  Barrens takes Orgrimmar's: Islen's next part stays open, not "Requires
  Call of Water first", #1372). A child quest's `accept` (`parent`: Valik,
  offered only while Infiltration is in the log, #1661) is closed for good
  the same way once its parent is handed in (reason `"closed"`, "Only
  before <parent> is handed in"), and marked `"pre"` ("Only with <parent>
  in your quest log") while the parent is not in the log and the guide no
  longer brings it (the same "still turns in" test). Prerequisites the data lacks (issue #51)
  mark nothing in advance; the giver's window covers them. The mark is live:
  it does not hold the step, the focus or the arrow, and it goes the moment
  the prerequisite is done (the guide then goes back to it), not
  on an unrelated turn-in. Every guide stands on its own (#1353): where
  the missing quest is given by an earlier guide of the route (a fresh start
  at the guide's level, a skipped guide, an older route order), the guide's
  steps are planned for the character (`Own.withFeeders`: each time a tab
  opens it afresh, a route hands over to it or a reworked tab follows the
  log, and once for the saved tabs at the first `QUEST_LOG_UPDATE`; planned
  from the guide as registered). `Own.feederPlan` follows each such accept
  to the quest it lacks that the guide does not bring, then down that
  quest's chain in the guides leading here (`next` or a route choice, back
  8 guides; a quest in the log only handed in). A chain goes in when it
  opens an accept that is not grey, all its places are in the guide's own
  zones, and, done before the first accept it opens, it costs at most 5
  minutes (`Own.feedCost`: a straight-run detour there and back from the
  nearest place the guide and the feeder steps already in go before that
  accept, plus 90 s per objective); its source steps, with its goals only,
  go after the guide's nearest step before that accept. Every other such
  accept is left out with all of its quest's goals, and a step left with no
  quest goal goes (`Own.rebuilt`: a new guide table in the registry,
  `Guides.Replace`, with `feeders`, `hidden`, `fromBase`, baked legs kept
  where the way in is unchanged). A missing quest no guide leading here
  gives is a gap of the route and keeps its "Requires" line. Nothing shows in
  the guide window; the report names the planned steps (`[feeder from <id>
  step N]`) and the quests left out (`[hidden: needs <quest> from <guide>]`).
  `checkShape` carries saved check-offs and skips to the new step numbers; a
  feeder step the player skips keeps its quests out of later plans
  (`CharState().feedSkips`). A giver's window that offers the quest (this
  session) beats the data: no mark in advance after that. Beyond
  that, when a gossip/greeting/detail window opens on an `accept` goal's NPC
  (any tab's current step) and the quest is neither offered, listed as active
  by that window (just accepted: the window refreshes before the quest log),
  in the log, nor
  completed, the Engine marks that accept unavailable for the session when
  the data gives a reason: `"level"` (below minLevel) or `"pre"` (a `pre`
  quest not done, title given). A refusal the data does not explain is never
  a skip (Fitz, #741: a giver the server lacks would otherwise take the quest
  and its later steps out of the guide): the accept stays open, the focus and
  the arrow stay on that giver, and its view's `noticeText` reads "Not
  offered by <giver>? Report it with /polestar" (`Own.notListed`, for the
  session, until that giver's window lists the quest or it is taken; never
  saved). From a gossip window with a chat option (`Compat.GossipHasChat`:
  an option whose icon is not the goods, training, bind or flight one) it
  reads "Not in <giver>'s quest list: try a chat option, or report it with
  /polestar if none offers it": the quest can sit behind that option (Sovik
  gives Chief Engineer Scooty only from his, #1762), and the quest's detail
  window opened from it clears the line. The player can still skip it (Skip
  this quest). Nor is a refusal
  while the missing prerequisite is in the log ready to hand in
  (`Own.preReady`): the window shows before the hand-in that opens the quest
  (Regthar Deathgate offers Verog the Dervish once Kolkar Leaders is in,
  #998), so nothing is marked or reported. A detail window
  says nothing about the NPC's other
  quests when it opens within 30 s of that NPC's gossip/greeting list, reward
  panel or turn-in (the quest picked from the list, or the follow-up the
  client pops after a turn-in), or when an item starts it. An unavailable
  accept and the goals of that quest in the
  guide (objectives, complete, turnin) count as skipped, so the guide moves on
  instead of stalling. The session marks clear on level-up and on any quest
  turn-in (either can open a quest whose prerequisite the data lacks). In
  steps a tab has moved past, a mark clears only once the data says the
  quest is open (level reached, prerequisites done: the guide goes back to
  it) and otherwise stays with its reason brought up to date. Every mark goes
  for the quest itself when it is accepted, when its giver's window offers it
  (also from a later step: the guide then goes back to it, the player
  standing at that giver) or lists it as active. No mark is saved across a
  logout. The view carries `unavailable = reason` and `unavailableText`.
  When such marks move the guide past a step during play, the Engine fires
  `STEP_SKIPPED`; the guide window's banner then reads "Skipped <quest>  ·
  <reason>" (one line per quest) until the step changes again, it is
  dismissed, or 20 seconds pass. With the window hidden it goes to chat
  instead. Passed while the player looks at another step (Prev, Next,
  Goto), it waits for their return to the live step (`Own.skipQueue`), so no
  quest is passed over unsaid. Placement at load never fires it.
- **Quests the player skipped** (`Engine.SkipQuest`, a quest's line
  right-clicked in the guide window: Skip this quest): saved per character
  by quest id (`skippedQuests`), so in every guide. Until the quest is done,
  each of its goals (accept, objectives, turn-in) has the unavailable mark
  `"skipped"` ("You skipped this quest"), even with the quest in the log, so
  its steps pass and the automation neither takes nor hands it in
  (`WantsQuest`). Its follow-ups go with it, their prerequisite no longer
  coming (`Own.preBlocked`), here and in the guides after. The other quests
  of the step stay. Done anyway, the quest counts as done and its follow-ups
  come back. The window's banner (`PLAYER_SKIPPED_QUEST`), the accept's Undo
  or a right-click on the line bring it back (`SkipQuest(questID, false)`).
  A follow-up left out because of such a skip carries `skippedWith` in its
  goal view: the title of the quest the player skipped, directly or down the
  chain (`Own.skipRoot`: the skipped quest, or a step the player skipped
  that held its accept or turn-in; a step with a `when` does not count, its
  failed condition being stored as a skip too). Before any skip,
  `Engine.SkipLoses` names what it would take with it: it sets the skip in
  the saved state, lists the open accepts that are no longer open, and puts
  the state back, with nothing evaluated or fired (the guide window's Skip
  button and the Skip this quest menu item: "Skipping also skips: …").
  After a skip, a guide that is no leveling guide (`Own.everyStep`: a class
  quest, a dungeon, a profession…) with no live step whose undo would open a
  later step (`Engine.SkippedOut`: the first step skipped by hand, not a
  `when` or `skipto` one, whose skip left out the steps that follow from it)
  is not complete: no `GUIDE_COMPLETED` and no hand-off, "started" in the
  guide list, and the window says the rest follows from the skipped step,
  with Undo the skip (`Engine.Unskip`) and Choose a guide; taking that
  step's quests by hand brings the rest back too (#1372). A leveling guide
  skipped to its end finishes, hands off and asks as before. With no step
  open, the guide menu's Skip this step is off and `/polestar skip` says
  there is nothing to skip.
- **Quests that leave the log** after the route has passed their accept
  (abandoned, failed): the live step does not jump back to the giver
  unasked. A quest that left the log this session (`QUEST_REMOVED`, until it
  is taken again: `Own.removed`) whose open accept would pull the live step
  back is held (`Own.holdLost`, saved per character and guide as
  `lostQuests[guideId][questID] = the live step`): its accepts before that
  step read done, so the step stays. While it is held, the quest's other
  goals (kills, collects, its turn-in: `Own.lostGoal`) read as skipped in the
  step views without being skipped: greyed, saying the quest is not in the
  log, never the current goal, the focus, a map pin or the arrow's; the step
  still waits on them. On the live step the arrow leads back to the giver
  instead (`Own.lostAim`: its first accept that applies before the held
  step), where Go back for it would take the route (#1365). The guide
  window's banner asks, and is
  answered rather than dismissed: Go back for it (`AnswerLost(q, "back")`,
  the route returns to the giver) or Skip it and what follows (`"skip"`,
  `SkipQuest`, with its usual undo). Setting `behavior.lostQuests` ("ask",
  the default; "back"; "skip": Options, Guide, Automation, "When you abandon
  a guide quest") gives that answer at once instead of holding: "back"
  holds nothing, "skip" marks the quest skipped, and either is said in chat
  (`Own.lostSaid`; a skip also fires `PLAYER_SKIPPED_QUEST` for its undo).
  Choosing an always answer answers a question already up. Taking the
  quest again, finishing it
  or skipping it otherwise forgets the hold (`Own.pruneLost`). A step the
  player brings back (Unskip, Goto) asks nothing unless its quest left the
  log.
- **Quests that failed in the log** (an escort lost, a timer run out, an
  event's NPC killed: `Compat.IsQuestFailed`, C_QuestLog.IsFailed, which
  Forever answers: the Recorder's `fail` events) can't be done until they
  are abandoned and taken again. Their goals other than the accept read as
  lost (`Own.lostGoal` via `Own.failedQuest`): greyed with "<quest> failed:
  abandon it and take it again", never the current goal, the focus, a map
  pin, the arrow's or a While-you're-here line; the step still waits on
  them. Other open work of the step leads; with none, the arrow leads to the
  quest's giver (`Own.failedAim`: its accept nearest before the step).
  Abandoning it (`Own.wasFailed`) sends the route back to the giver without
  asking, whatever `behavior.lostQuests` says, with the chat line.
- **Room in the quest log** (`Core/RoutePlan.lua`; nothing is ever
  abandoned for the player). `RoutePlan.Unneeded()` lists the log's quests
  the selected route never hands in (`GetTurnIn` status `missed`, `skipped`
  or `unplanned`) and the grey ones it doesn't hand in in this chapter
  (status `grey`, which also replaces those three: `Compat.IsQuestTrivial`
  on `Compat.GetQuestLevel`, the client's `GetQuestDifficultyLevel`, at the
  character's level; a grey quest the route hands in later in this chapter
  stays, still worth its reward or its chain; one a later chapter hands in
  stays unless that chapter leaves it out too: `Engine.GreyLeftOut`, Skip
  grey quests on and nothing on its chain needing it, and every guide down
  that chain loaded, so an unknown need keeps it), or nil while the plan
  cannot say (no guide, a route choice to make, a guide not loaded). A quest
  the route's quest work marks `carriedTo` a later guide (the compiler's,
  GUIDE_FORMAT.md "Quests carried to a later guide") is status `later` at
  that guide even where the plan cannot reach it, never `unplanned`.
  `RoutePlan.LogOverflow()` is
  `{ take, free, drop }` when the live step's open accepts outnumber the
  free slots (`Compat.GetLogCap`: the client's `GetMaxNumQuestsCanAccept`,
  else Forever's 40): `drop` names enough quests to make room, the unneeded
  ones first, then the ones handed in last, never one of the live step's,
  and each once.
  The guide window's banner says so on the live step ("Quest log full …",
  dismissed per step) and its Make room opens `UI/QuestRoom.lua`
  (`/polestar questlog`, `SHOW_QUEST_ROOM`; also the guide window menu's
  "Clean up quest log (N)", shown while `Unneeded()` lists any, and the
  button under Questing > Quests > Tooltips and quest log): the unneeded
  quests, each with its reason and
  an Abandon button that asks through the game's own confirmation
  (`Compat.AskAbandonQuest`: `C_QuestLog.SetSelectedQuest`,
  `SetAbandonQuest`, then the `ABANDON_QUEST` popup).
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
- **What a quest unlocks** (`Core/Unlocks.lua`, the guide window's quest
  tooltips). `Unlocks.For(q)` lists `q`'s follow-ups for this character: the
  guide accepts whose `pre`/`preAll` names `q`, across every shown guide
  (indexed once with each quest's accepts and turn-ins, rebuilt on
  `GUIDES_REGISTERED` and `PACKS_CHANGED`), then, with the quest database
  loaded, the quests whose `pre`/`preAll` lists `q` (`QuestDB.FollowUps`,
  read from the follow-up's side, built on the first ask). Left out: quests
  done or in the log, and ones the character can never take (as in
  `Closes.For`). Each names its giver when someone other than `q`'s ender
  gives it. `q`'s chain is walked back while each prerequisite is the only
  one and carries on to the next quest, and on while the quest carried on to
  has the last as its only prerequisite; a quest carries on to its only
  follow-up, or at a branch to the only one with its own title (a series'
  next part: The Defias Brotherhood part 6 also opens Red Silk Bandanas).
  Found whole (a first quest needing nothing, a last opening nothing, three
  quests or more), the next part leads the list, numbered ("part 2 of 7"),
  and the chain's last quest follows with its reward (a guide's turn-in
  `rewards`, else the Codex's when Lookup has it loaded; a tooltip never
  loads it). A branch it cannot follow stops the count.
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
- **Another race's starting zone** (Fitz, 2026-10-30). A character may follow
  another race's start of their own faction (`Guides.OtherStart`: a Leveling
  guide from level 1 with `races` they are not, their faction, their class;
  the one exception to `Guides.GuideMatches`, and no other race-locked guide
  is one). Polestar does not guide them there: while the player is outside the
  guide's `zone` and nothing of it is played (as above), `Engine.AwayStart(id)`
  gives `{ races, zone, zoneName }` and the guide window shows "Another race's
  starting zone" with where to make their own way to and that the class
  trainer may be elsewhere, in place of the live step, with no waypoint; it
  is part of the step signature, so arriving re-renders the window and lifts
  it, and once a quest of it is taken it does not come back. In such a guide
  a goal whose quest the character can never take (the quest database's race,
  class or faction: the Human class letters for a Night Elf Warrior) does not
  apply, like another class's (`Own.barred`, in `goalApplies` and the
  orphaned turn-in check; without the database those goals stay); steps for
  the guide's race only (`only Human`) never applied. No class steps are made
  for classes the guide's race does not play. Its `next` hand-off is unchanged:
  the shared route it leads to fits every race of the faction.
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

#### Steps the character has

Some steps are not the character's (#942, Fitz; `Own.hiddenStep`): an
`along` step, whose goals read under "Along the way" of the steps after it,
a step whose `only` leaves out the character's class, race or faction,
or every goal's `only` does (the Druids' Moonglade steps for a Mage), and a
step whose only goals for them are `hearth` (0.3.3, Fitz; `Own.hearthOnly`):
hearthing is no step of its own, the route passes over it like an along
step (`stepDone`), and the arrow's route to the next step's work takes the
Hearthstone when it pays (see the travel planner's long-haul rule).
`sethome` stays a step, and so does a hearth beside another goal. Such a
step does not exist for them: Next, Prev and Goto never land on it
(`Own.lookable`), it has no number, it counts in no progress, and nothing
explains it; a view of it saved before (`CharState().pins`) opens on the
next step they can look at. `Engine.StepNumber(i)` gives step i's number as
the player counts it (a hidden step reads as the next shown step's number,
with `hidden` true) and `Engine.StepTotal()` how many they see
(`Own.numbersOf`, per guide and character). Every place that shows a step
number uses them; the bug report adds the guide's own index ("Step 7 of 33
(guide step 9)"). A step that depends on what the player does (`when`) is
theirs: it keeps its number and says why it does not apply now
(`Own.stepWhy`).

#### Flight steps and the travel route

A travel step holds, for the character, nothing open but gotos and a `fly`
(a flight step: the walk to a flight master and the flight) or gotos alone
(a walk): it is a way to the work after it (#1191, #1212; `Own.transitKind`).
With the travel planner leading on Polestar's own arrow (`nav.travel` and
`nav.arrow` on, not TomTom's arrow, not handed off; `Own.plannerFlies`) and the flight's end
a node the character knows (`Nav.GetTaxiNode`, `Nav.GetKnownTaxiNodes`):

- a flight step's arrow leads to the flight's end (`Own.flyAim`) and the
  window marks the flight, so the route flies there in one flight from the
  flight master that reaches it soonest, not via the one the step names;
- a travel step passes (`stepDone`, `Own.flightOn`) when the next open step
  after it, past walks on the same continent, is another flight step: the
  stop between holds nothing left for the character (its work done, skipped,
  unavailable or for other characters), so the route flies on directly;
- a flight step whose next open step is work is judged once when the route
  reaches it (`Own.flightJudged`, never on a taxi): it passes, with the walks
  between, when `Nav.EstimateTravel` reaches that work at least
  `Own.FLY_MARGIN` (60 s) or `Own.FLY_SHARE` (10%) sooner than landing at
  the flight's end first (a nearer flight path the character knows, or a stop
  whose own work is behind them). The verdict holds until the character
  learns a flight path (`Own.flyVerdicts`).

A walk passes too, whatever comes after it, when the stop it leads to holds
nothing for the character (#1596; `stepDone`, `Own.stopEmpty`; planner leading,
quest log read): their own steps after it that are written with work (a
hand-in, a flight path, training) are, up to their next travel step, all done,
skipped or not applying now (a false `when`, a flight path known). A skipped
step counts like one that does not apply: passing a stop stores the `when` that
failed there as a skip (`Own.latchWhen`), so the stop reads the same on the
next evaluation and after a reload. Open optional work (a riding trainer) keeps
the stop. Steps for other classes or races, and steps of notes alone, are no
stop: a walk followed only by those holds (it is the way on), as does one with
no travel step after its stop (the guide's end).
Standing in Camp Taurajo with nothing to do in Thunder Bluff, Ashenvale &
Thousand Needles' walk up to Thunder Bluff passes and The Tear of the Moons
leads; the 'Fly to Camp Taurajo' step reads done there, so no flight follows
for `Own.flightOn`.

With the planner off the steps hold as written. `forge guide lint` reports a
flight to a stop with nothing to do followed by another flight
(`check_flight_hops`, a house rule).

A travel step the planner passed (`Own.flightOn`, a verdict) stays passed once
the route moves beyond it: its gotos and flight are latched like any travel
goal the route passes (`latchPassed`), so the landing never reopens it. Before
that (#1768), landing at the flight's end left nothing to fly on to, the walk
before it read open again and the arrow sent the player back (Camp Taurajo to
Thunder Bluff's rise, then the flight to Camp Taurajo again).

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
  step (the group's header, an area) only when nothing else is open. Where
  that first blocking goal is a field goal (`kill`, `collect`, `interact`
  with a place, no candidates; `Own.isField`) and two or more are open, the
  first stop of a tour through them takes its place (`Own.nearestField`,
  `Own.routedField`; the tour is `Core/FieldRoute.lua`, plain geometry with
  no game calls):
  - *Which goals.* The group's open blocking field goals in written order up
    to its next open blocking goal of another kind (a talk, a wait, a goto:
    the barrier, `Own.currentGoal`). Work after the barrier waits for it, so
    a tour never crosses a required interaction; a goto that gives way to a
    grind (`Own.grindAfter`) is no barrier. With a place at the player's
    level (`Spots.ABOVE`, see "Spawn areas") only the goals that have one.
  - *Their places.* One per goal, taken when the tour is planned and kept
    for its life (`Own.fieldPoint`): the eligible camp nearest the player
    (alternatives, camps left after a dwell and, with a place at the
    player's level, higher camps left out), since the arrow re-picks a
    goal's camp from where the player stands when its turn comes; the chosen
    camp for the current stop and for a camp picked by hand; a goal without
    spots, its point. A camp chosen only for a row of the window does not
    count: it was picked where the player stood when the step was first
    shown.
  - *The order.* The shortest open walk from the player through every place
    (straight lines; it does not return), ending towards the finish hint
    when there is one, plus the level delay. Up to 8 goals
    (`FieldRoute.EXACT`) it is the best order there is (Held-Karp); up to 32
    (`FieldRoute.LIMIT`) a 2-opt improvement of nearest-first, written order
    and four other starts, never worse than nearest-first. A goal with no
    place to measure (every place left after a dwell, another continent) is
    left out until it has one; with fewer than two goals to tour, or more
    than 32, the nearest-goal rule below.
  - *The finish hint* (`Own.fieldExit`): the place of the first goal still
    blocking after the tour's (later in its group, else in the groups after
    it, else in the next step when that step applies; notes, optional and
    done goals are passed over), a cost for the last leg only, never a stop.
    None when that goal is a flight, a hearth or an entrance, has no place,
    has candidates or spots with none chosen yet, or is on another
    continent.
  - *The level delay* (`Own.fieldDelay`): a goal whose quest is more than
    one level (`Spots.ABOVE`) above the player costs 40 yd
    (`Own.DELAY_YARDS`) times the levels above that, squared, capped at 10
    levels (`Own.DELAY_LEVELS`), for every stop made after it: 40 at two
    levels above, 160 at three, 360 at four. So a hard quest moves one place
    later whenever that costs fewer extra yards than its delay, and is never
    excluded. The quest's level is the client's (`Compat.GetQuestLevel`),
    else the goal's `qlvl`, else its accept's; with none, no delay. An
    estimate, not tuned on recordings.
  - *When the stop changes.* The tour is kept per step (`Own.fieldTours`)
    and the arrival poll only checks it; it is planned again when a goal in
    it is done, skipped or has no place left to measure (or has one again),
    when the player's level or a quest's changes, when a goal's place in it
    is left after a dwell, on another continent, and on a detour: 80 yd
    walked (`Own.DETOUR`) with less than half of it made good towards the
    current stop, unless the player is at the stop (within its arrival
    radius and 40 yd, `Spots.SWITCH`, of one of its camps). Walking to the
    stop, or between its camps, plans nothing. A new plan moves the arrow
    off an open current stop (`Own.nearPick`) only when the whole trip from
    where the player stands then scores under 75% of the trip that keeps it
    and 40 yd less (`Own.NEAR_SHARE`, `Own.NEAR_YARDS`; yards plus delay);
    the stop is never changed while the player fights or for 5 s after a
    fight or progress (`Spots.busy`).
  - *The nearest-goal rule*, where no tour can be planned: the nearest of
    them takes its place (the player's distance to each one's nearest spawn
    area, alternatives left out, else its point), at the player's level
    first. Sticky per step: another takes over only once it is at most 75%
    of the current one's distance and 40 yd nearer, or the current one is
    done; never in a fight. No position or nothing measurable: written
    order.

  The goal list keeps written order either way, and a `loop`
  step's spots still form the circuit, its first pick the spot nearest the
  player. A grind (`level N grind <npc>`, `Own.isGrind`: the compiler placed
  it at the mob's spawn areas) is a field goal too, and a goto before it in
  its group, with only notes, optional or done goals between, gives way to it
  (`Own.grindAfter`): the arrow leads to the mob's nearest spawn area, the
  goto only when the mob has no known spawns (the goal has no place); the goto
  is done with the level, as any goto before a done goal. The
  arrow goes to the goal the player chose in the current step (`AimGoal`, a
  cycled spot or candidate) while it is open and its quest is not waiting for
  its accept in the step (#1385: a row click there says "Take <quest> first",
  and the waypoint keys pass it), else the current goal's own
  place (its coordinates, its spawn area, the source of its item), else the
  header's, else the focus group's first open located goal (blocking, then
  optional, then notes), else a quest's current goal at the place of the
  focus group (a goto already reached) or of the nearest group before it for
  the same quest (the giver of a bare `complete`), never of a later group;
  nil on a done step (no focus). An along step is never looked at
  (`Own.lookable`, see "Steps the character has"), so neither the arrow, the
  route line nor the target pin leads to it; its goals lead only when chosen
  from Along the way (`AimAlong`) or before a turn-in that is not ready
  (`Own.alongAim`), and their spawn areas show on the map. Reaching the place of
  any other goal of the step arrives at its header. A focus change fires
  `STEP_UPDATED(step)` and `WAYPOINT_CHANGED` like any other progress.
- Out-of-order play still counts: finishing a later person's goals marks that
  group done; the focus stays on the first open group.

#### Route choice ("Choose your path")

A guide whose `next` lists several guides compiles to `next` (the author's
default, the first) plus `nextChoices` (all of them, in order); each option may
carry `pitch`, `pros`, `cons` (see GUIDE_FORMAT). `next <id> when ...` adds
`nextWhen` (format 4: option id -> predicates, as a step's `when`), and
`nextChoices` then lists the options even when there is one.

```lua
Polestar.Engine.GetRouteChoice(fromId) -> { from, fromTitle, recommended, chosen, joinsAt,
    options = { { id, title, zoneName, minLevel, maxLevel, pitch, pros, cons, seconds,
                  quests, steps, recommended, chosen, outleveled, open }, ... } } | nil
Polestar.Engine.ChooseRoute(fromId, toId) -> bool   -- remembers, loads, fires ROUTE_CHOSEN
Polestar.Engine.PendingRouteChoice() -> fromId | nil -- the active tab's finished guide waiting for a choice
Polestar.Engine.RouteChoiceFor(id) -> fromId | nil  -- the choice that offers guide `id` to this character
Polestar.Engine.RouteOffered(fromId, toId) -> bool  -- fromId's `next` names toId and its `when`, if any, holds now
Polestar.Engine.NextGuide(fromId) -> id | nil       -- where the hand-off goes now; nil: none offered, or the player chooses
Polestar.Engine.OfferRouteChoice() -> fromId | nil  -- /polestar path: fires ROUTE_CHOICE
Polestar.Engine.GuideFocus(id) -> x, y | nil       -- live-frame percent of where the guide is for this character, for the
                                                    -- guide menu's zone art: open in a tab and unfinished, the current
                                                    -- step's first goal on the guide's zone map (`zone`); else (or when
                                                    -- that step is elsewhere) its first goal on it: a route option's focusX/Y
```

- **Options** are the `nextChoices` that fit the character (faction, race,
  class) and are offered now: an option with `nextWhen` only while its
  predicates hold (`Own.optionHolds`, `Own.predicateHolds` on the live state,
  checked each time the options are listed: `routeOptions`, `ChooseRoute`,
  `RouteOffered`, so `Guides.OfferedBy`, the guide menu's "Next" line and its
  suggested follow-ups, and "Up next" on a finished guide); nothing is stored.
  `outleveled` when the level is at or past the option's maxLevel.
  `seconds` is `TravelCost` from the player to the option's first located goal;
  `quests` counts the accepts this character gets there; `joinsAt` names the
  guide every option continues to, when they share one.
- **Recommended:** not outlevelled, then the quickest to reach (1-minute
  bands), then the author's order.
- **At completion** (the guide either auto-loaded or seen incomplete; a
  leveling guide only with `behavior.guideEnd = "continue"`, else see "End
  of a leveling guide"): the remembered choice
  (`CharState().routes[fromId]`), else the only option offered, else with
  `behavior.routeChoice = "recommended"` the recommended one. With none
  offered (every option's `when` fails) the guide ends there, as without
  `next`. Otherwise the finished guide stays in its tab and
  `ROUTE_CHOICE(fromId)` fires once, after the evaluation.
- **Fresh start:** with no saved tabs, when the suggested guide is an option of
  a choice the character fits, and the character is at most one level into
  that guide's range, login also fires `ROUTE_CHOICE` (the suggested route
  stays loaded meanwhile).
- **ChooseRoute** loads the option in place of the finished guide, else of an
  open option of the same choice (changing route), else in the active tab.
- **Never-had quests:** a turn-in, complete or objective goal for a quest the
  character neither has nor has done, and that its guide does not accept (for
  this character) at or before that step, does not apply (status `na`): it was
  picked up on another route, or skipped. `chainNeeds` follows every route
  option but one whose `when` can no longer hold (`Own.optionClosed`: a
  `level<N` or `level<=N` the character is past, a `!turnedin` quest handed
  in); the chain is built again once a kept conditional option closes. The
  hand-in plan (`Core/RoutePlan.lua`) treats a guide with a conditional
  option like a choice not made yet, unless the remembered choice is an
  unconditional option.
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

#### End of a leveling guide

```lua
Polestar.Engine.GuideEnded(id) -> bool       -- the player reached the end of leveling guide `id` (this character)
Polestar.Engine.StartNext(fromId) -> bool    -- the guide after fromId (NextGuide) in fromId's tab, as the hand-off;
                                             -- false with none or a route choice to make first
```

`behavior.guideEnd` ("When a leveling guide ends", Options → Guide →
Automation): `"ask"` (default) or `"continue"`. It applies to leveling
guides (category Leveling or none: the starting zones and community leveling
guides); every other guide hands off by itself as before. It replaced the
`behavior.autoNextGuide` toggle in 0.3.1; the stored toggle is dropped at load
and both of its values start on `"ask"`.

- **The end** (`Own.noteEnd`): every step done, or the guide's last step
  with work for everyone (`Own.lastWork`: it applies, is not an `along`
  step, and has a goal that applies and is neither a note nor optional;
  trailing steps that only offer, such as riding at 40, are not the end;
  nor is a class's or a race's own step, `Own.forSome`: its `only`, or that
  of each goal of its work, names classes or races, or the quest database
  says its quest is a class quest, as Cat Form closing The Barrens for
  Druids, done in the class guide too)
  done ahead of the live step, whatever steps before it were skipped or left
  open. With the live step past that step, such own steps still to come are
  no end; the end comes with them (completion). It counts once the guide
  was seen unfinished after placement this
  session (`Own.endOpen`), and for the last step done ahead, that same step
  seen open (`Own.lastOpen`), so a guide opened, or brought back by a login,
  already at its end does not ask, nor does a last step that reads done from
  the start (its quest not offered yet) until the rest is done; and once per
  guide per character (`CharState().guideEnds`). The last step's work must
  be really done (`Own.endWorkDone`, #998): a goal only passed over as
  unavailable for now (a level, a missing prerequisite, a giver's refusal)
  comes back, so it is no end; out for good (closed, skipped by the player)
  passes, but a step of nothing else is void.
- **The record** (`CharState().guideEnds`) is not the end itself: with a live
  step it stands only while the end still holds (`Own.endHolds`, judged as
  above at every evaluation); one that no longer does (a quest of the last
  step abandoned) is forgotten, and reached again it asks again. Reset guide
  progress (`Engine.ResetProgress`) forgets it, so does a pack update that
  changes the guide's steps (checkShape), and every record saved before
  0.3.6 is dropped once on load (`guideEndsV`): 0.3.5 reused guide ids and
  ended guides by where the player stood.
- **Ahead of the live step** (`Own.endDoneAhead`), by what the game keeps:
  quest state, level, bags, flight paths, spells. Never by where the player
  is or has been, nor by an NPC's window (`Own.byPresence`: goto, explore,
  fly, hearth, enter, die; train, vendor, sethome, a talk with no quest):
  0.3.5 ended Hillsbrad Foothills & Arathi Highlands (30-32) at step 2 when
  the player walked into the Undercity, where it flies at the end and stops
  on the way. Such a goal counts once its step is on screen, when it is
  ticked, or when work after it in the step is done (the walk to the last
  turn-in). tests/addontest/guides-end.rs plays every leveling guide's last
  step ahead (with the reference data), a class's or race's own last steps
  first (no end), and lists the guides whose last step is a place
  (no end ahead); guides-end-early.rs plays every one in order, each
  hand-in after its giver's window and each move in its map's zone (no end
  while a step is live), optionally as a character with an older route's
  quests done (`GUIDES_END_HISTORY`).
- **Ask:** no hand-off by itself (the catch-up still passes guides done
  whole); `GUIDE_END` fires after the evaluation and the guide-end window
  (`UI/GuideEnd.lua`, frame `PolestarGuideEnd`) says "You've completed
  <guide>" or "You've reached the end of <guide>" with the open steps left,
  and offers Start <next> (`StartNext`), Choose where to go next (the route
  choice window) or Pick a guide (the guide menu); the second button (Not now,
  Back to step N, Close) keeps the guide. While steps are open the guide
  window's banner then offers the next guide (`GF.EndOffer`) until dismissed;
  a finished guide's completed state offers it as before.
- **Continue:** the hand-off at completion as under "At completion", and
  `GUIDE_CONTINUED(fromId, toId, carried)`: the guide window's banner reads
  "Durotar complete — continuing with The Barrens" for 20 seconds (chat while
  the window is hidden), and chat names the quests still in the log that a
  later guide hands in (`carried`, `Engine.CarriedQuests(fromId)`).
- **Carried quests:** `Engine.CarriedQuests(id)` -> `{ { quest, title,
  guideId } }`, the guide's quests still in the log whose quest work carries
  `carriedTo` for this character, in step order; the guide-end window lists
  them under "Carried to later guides". On the step view a goal's `carriedTo`
  is set once per quest and step (`Own.carriedTo`: its last such goal there
  that applies), and `UI.CarriedLine` reads "Keep this: you hand it in later
  in <guide> (<levels>)" (`UI.GuideLabel`, as the guide-end window names
  guides), on its own line after the goal's subline (`UI.GoalSubline`).

#### Tabs (several guides at once)

```lua
Polestar.Engine.GetTabs([counts]) -> { { guideId, title, category, stepIndex, stepCount, done, total, complete }, ... }, activeIndex
                                     -- done, total only with counts (the done rules over each tab's steps: the tab tooltip, the guide menu)
Polestar.Engine.OpenTab(guideId [, activate])  -> index   -- already open: just activates it (when activate ~= false)
Polestar.Engine.CloseTab(index [, quiet])                  -- the last tab may be closed (no guide); quiet: Polestar's own close
Polestar.Engine.ClosedTabs() -> { { guideId, title, at }, ... }   -- newest first, registered and not open
Polestar.Engine.ReopenClosedTab([guideId]) -> index | nil -- the last closed (or guideId's), at its old place, active
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
tab only. Automation considers the live step of **every** open
tab. The hand-off replaces the finished guide within its own tab. On login,
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

**Closed tabs come back.** The player's close (`CloseTab(index)`) and a
guide loaded over a tab (`SetGuide`, a route changed with `ChooseRoute`;
`Own.replaceTab`) keep the guide among the closed ones (newest first, at
most 10), saved as `CharState().closedTabs = { { id, at }, ... }` with their
saved views (`pins`, which `persist` used to drop on close), and `CloseTab`
fires `TAB_CLOSED(guideId)`. Opening a closed guide again by any way
(`ReopenClosedTab`, `OpenTab`, `SetGuide`, `ChooseRoute`) takes it out of the
list and opens it as a reload restores a saved tab: at the step the player
was looking at (`Own.takeClosed`, the pin carried by `checkShape` to the
steps as planned now), placed from the quest log. Ticks and skips are per
guide and never went with the tab.
`CloseTab(index, true)` is Polestar closing a tab it is done with (a finished
dungeon pick-up or class guide, a generated Lookup guide reopening rebuilt):
not kept, no `TAB_CLOSED`. The guide window offers "Closed <guide> · Reopen"
for 10 seconds (also with no tab left); its menu and the tab menu have
"Reopen closed tab"; `/polestar reopen` and the `POLESTAR_REOPEN_TAB` binding
reopen the last one; the guide menu's Recent leads with Recently closed.

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
      manual = true | false,               -- UI shows a checkbox when true (a `task` always: done only by the tick)
      optional = false, note = nil,
      side = nil,                          -- true: a vendor check-off beside other work, which does not hold the step
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

Current step = first step, in order, that is applicable (`only` matches
and, with `when`, its predicates hold), not skipped, and not done. A step is done when every applicable,
non-optional goal is done, a `vendor` beside other such goals aside (`Own.holds`); a step of only notes/optional goals is done at
once, and so is an `along` step. Step views for indices before the current step report `done`,
`skipped` or `na`; after it, `upcoming` or `na`. A view carries the step's
`along` and `label`.

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
- **A walk's "Go to" named only by its zone** (the guide writer's label for
  a point on the way through a zone, "Go to Mulgore"), in a step of gotos
  and notes alone, reads while the zone text is that zone's name "On through
  Mulgore to The Earthen Ring": the title of the next step for the character
  (not along, not skipped) that is not titled after the zone, so it never
  reads as done to a player already in the zone (#1334,
  `Own.onThroughZone`). Elsewhere, or with no such step, it reads as written.
  The row and the arrow's label only: the goto completes as before.

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
- An accept waiting for the character's level is no task in the step view
  (status "na", no "Requires level" line: Fitz, 0.3.6, no level text on
  pick-ups); the route passes it as below and the level-up brings it back.
  The goals of its quest further on keep their "Requires level" line. Where
  the route waits on it instead (`Own.waitsOnLevel`: computeCurrent's own
  rule, the level hold with nothing else open there and the next open step
  held behind it, i.e. a guide that is no leveling guide or a chosen dungeon
  run ahead) it keeps its "Requires level" line, the one thing that step
  says (without it the Orgrimmar reputation guide's Crossroads hub sat
  empty and never moved on). The Rust port's step view (forge-judge
  `Sim::view`) does the same.
- The last quest progress (`anchorStep`) counts only goals of quests the
  guide offers at or before that goal (or `direct` hand-ins): progress on a
  quest taken in another guide is no sign of where the player is in this
  one (Fitz, 0.3.6: Tincho at 28.7, carrying Dangerous! from the 22-24
  Hillsbrad visit, was put past Orgrimmar, training and the Undercity in
  Hillsbrad 29-32, at every load). And a soft step behind it passes only
  when the quest work it leads to (the next quest goal for the character
  after it they can do, not waiting for a level or a prerequisite) is done or
  under way, or left out by the catch-up (`leadsToDone`): progress on a quest
  done before this guide (an earlier visit, an earlier guide offering it
  too) is no sign of the travel before the work still to do (SkipAheadSweep:
  Stranglethorn's flight to Darkshire, Feralas' zeppelin, Darkshore's boat).
  The judge's Rust engine (forge-judge `place`, `anchor_step`,
  `leads_to_done`) mirrors it.
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

**The catch-up** (`Own.catchUp`, with `behavior.skipGrey` on, in a guide that
does not do every step): before the start is worked out, the accepts behind
the last quest progress that are more than 2 levels below the character
(green or lower) and not taken yet are left out, unless a quest worth doing
needs them first (`Own.needsFrom` down `pre`/`preAll`, over the guide and the
guides after it: `Own.chainOf`). Worth doing: an accept that is not grey,
behind the anchor only from 2 levels below up. A quest in the log goes by the
same rules (`"log"`): left out while not done, kept once it only has to be
handed in. Left out (`Own.leftOut[guideId]`, for the session; each
placement works it out again), an accept no longer applies, with its turn-in
and objectives; taking the quest by hand brings it back. In a guide the
character is past (`maxLevel` + 2, as the out-levelled banner counts) going
back is a detour: every grey or green accept not taken yet is left out,
anywhere in the guide, unless at least `Own.CHAIN_WORTH` (3) accepts from
yellow up need it down the chain (`Own.catchUpPast`); a quest in the log
too, until it only has to be handed in. Grey accepts anywhere go by `behavior.skipGrey`'s own rule (greyNeed).
Travel goals (goto, fly, hearth, explore) before the start also pass in a
step before the last left-out or grey-skipped accept: the way to what was
left out goes with it. A flight path, a hearth, training or a purchase there
still holds unless it is behind the last quest progress: the character may
never have been there. A guide the character is past (an accept left out or
grey-skipped, or `maxLevel` reached) with no start, no accept waiting for a
level (a missing prerequisite is often a grey quest it left out, which never
comes) and the quest log read passes whole (`Own.passedWhole`), its travel
too. Only a guide just opened for the player (`Own.opened` with
`autoChain`: the login's pick, Start guide, a guide chained to) then chains
to `next` as a finished one does (`Own.placedThrough`); its flight paths,
hearths and training ahead of the last quest progress pass for the session
only (`Own.passedNow`), never stored as done. A guide the player opens by
hand, or a login or /reload brings back, stays where placement puts it: at
such a step, or finished. With every quest of a guide done
(`Own.allQuestsDone`) all its soft goals pass and are latched. Start guide
(`Engine.StartGuide`: the guide window with no guide, the welcome) opens
`StartingGuide()` for the player (`OpenTab(id, true, true)`, `autoChain`), so
it goes on through such guides as the login's pick does. The next guide is
placed the same way, even when it finished earlier in the session (another
try): only a guide passed on the same run stops it (`Own.chainSeen`), against
a loop of `next`. The picker's "done" check (`GetGuideState`) for a guide
placement passed whole needs every quest the character can take in it turned
in, so a guide passed with grey quests never done is not checked; a guide
finished in play is done as before. Where it offers a route choice, the
catch-up takes the option with the most quest work done
(`Own.likeliestRoute`, `Own.doneIn`), the recommended one among equals. With
no tab open at login (`behavior.autoSelectGuide`), a character who did quests
in their race's first guide (`Guides.FirstGuide()`: the suggestion at level
1) starts there and goes through the guides to where they are; one with
nothing done there gets `Guides.Suggest()`, as before. `GUIDE_PLACED(guideId,
step, passed)` fires for the active tab once placement of a guide just
opened ends, with the guides passed whole.

**Every step** (`Own.everyStep`): any guide but a leveling one (category
`Leveling` or none) does every step: no grey quest is left out and nothing
is caught up (an item, a mount, a reputation, a profession, a class chain is
done whole).

Ticks and stored check-offs keep counting. After placement soft steps hold
as usual, so a quest taken out of order during play never jumps a training
stop. A turn-in or objective of a quest whose accept sits in a skipped step
(and that the player neither has nor has done) no longer applies. A reload
asks every giver afresh: no "not offered" mark is saved.
A pack update that changes a guide's shape matches the old and new steps by
`stepKeys` (longest common run of equal step hashes) and moves ticks, skips
and the saved view with them; saves from before step keys existed lose them.

Navigation: `Next`, `Prev` and `Goto` only change the step on screen (the
pin); `Skip` is the only way to skip a step (saved, undone by `Unskip`;
`Goto` to a skipped step un-skips it). A skip moves the live step past more
steps than the one skipped, and the route stores what it finds there (their
`when` outcomes, `skipto` jumps); the skip records those, and the feeder
quests it left out (`feedSkips`), in `CharState().skipStored[guideId][step]`,
and its undo (`Unskip`, `Goto`) takes them back with it, so a step passed at
level 19 for `when level>=20` comes back at 20 once the skip is undone
(`Own.skipStore`, `Own.skipRestore`; a step the player keeps meanwhile,
`Own.keep`, stays). The pin is saved (`pins`), so a reload
shows the step the player was looking at; it is released at the live step,
and while the step it shows gets done it follows forward (behind the live
step up to it, ahead of it to the next open step, latching the step's
transient goals). `Prev` and `Next` walk the same applicable steps, done,
skipped or open. NPC interactions count for the live step too while another
step is shown.

Reset guide progress (`Engine.ResetProgress`) clears the guide's check-offs,
skips, kept `when` steps, skip records, update passes and recorded end, then
places the guide again as if just opened. What it clears starts at the last
step with quest progress the game shows (`anchorStep`, read with every mark
gone); the player's own marks and skips before it stay, so a step skipped
long ago, its quests never taken, does not become the start and send the
guide back (#1764); `Goto` brings one back. With the quest log not read yet,
everything is cleared.

Waypoint:

```lua
{ map = 1429, x = 47.6, y = 35.1, f = nil, label = "Kill Kobold Vermin", stepIndex = 3, goalIndex = 2, kind = "kill", r = 8 }
```

= the goal of the current step the player aimed at (`AimGoal`) while it is
open and its quest is not waiting for its accept in the step; else the current goal (the focus group's first open blocking goal, or
the first stop of the tour through its open field goals when it has two or more, else its first
open optional one, else its header); else the focus group's first open goal
with coordinates (blocking, then optional, then notes). A done step has none.
Re-evaluation is event-driven and coalesced (≤ 10 per second); `goto` and
`explore` arrival is polled only while some tab's current step has one open,
while the waypoint's goal has spots, or while the active step picks among
several open field goals (the same poll checks their tour, and plans it
again only on the events under "Current goal and waypoint").

Automation (setting `behavior.autoAccept`, `behavior.autoTurnin`, default
on; holding Shift suppresses): accept only quests that are `accept` goals, and
turn in only quests that are `turnin` goals, of the live step (Fitz:
never a step the player is only looking at with
Prev/Next/Goto; `Engine.WantsQuest` evaluates first when a change is
pending, so a hand-in that finished the step counts the next one as live;
a `direct` one is picked from the gossip or greeting list of offered
quests, and only while its goal is not done: the giver of a repeatable keeps
offering it); a While-you're-here hand-in line up in the active tab
(`Own.hereWants`, #1408: the guide shows it to be handed in now; never one
held, of a group quest not answered for, of a quest the group waits on or
one left out); and an accept of the next steps at the NPC whose window is
open (`Own.aheadWants`, "While you're here" above, with its guards); never choose among
multiple rewards; with `behavior.warnClosing` on,
never accept a quest that closes another for good (Missable quests).

After its own accept or turn-in, the game often opens the NPC's next window
by itself: the follow-up of the quest just handed in, or the NPC's other
quests (#360). With `behavior.closeSkipped` (default on) Automation closes
that window (`CloseQuest`, `C_GossipInfo.CloseGossip`) on the next frame when
it shows nothing the guide takes: no `accept` goal not yet taken, no quest in
the log with a `turnin` goal, no `direct` goal, in the live step,
whatever the automation settings. Only the first quest or gossip
window at the same NPC within 2 seconds of Polestar's accept or turn-in
counts; a later window, one at another NPC or one the player opens from a
list stays. Never in combat, with Shift held, on a progress or reward
window, or on a gossip window with options of its own (a vendor, trainer or
innkeeper). A quest the guide still wants at that NPC is taken on the next
talk.

With `behavior.spokenDelay` on (the default; Options, Integrations, Spoken,
shown and honoured only while Spoken Quests is installed) each quest or
gossip window waits 200 ms before automation acts on it, and `QoL/Rewards.lua`'s reward pick waits the same
(`Automation.Delay`). Spoken Quests records a quest page in its own handler of
the event that opened the window; it loads after Polestar, so an accept made
in Polestar's handler leaves it nothing to record and the page is never read.
Everything is decided when the wait ends, so Shift held then skips the action.
A newer window replaces the wait, and only a close of its own kind drops it:
`QUEST_FINISHED` for a quest window, `GOSSIP_CLOSED` for a gossip window, since
picking a quest in a gossip window ends that window and its `GOSSIP_CLOSED` may
come after the quest window it opened. The test is the events, not
`QuestFrame`: DialogueUI and the like keep that frame hidden.

## Theme — used by UI and Nav

```lua
Polestar.Theme.Accent() -> r, g, b
Polestar.Theme.ClassColor(classFile) -> r, g, b | nil     -- the client's colour for a class file; nil: the player's class
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
Polestar.Theme.FontKey() -> "opensans" | "game" | "inter" | "fira"   -- ui.font, "skin" resolved
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
- its fonts (`ui.font` "skin", the default: the game's in the house style,
  Fira Sans in Halo, the game's in Hearth and the game's looks), its type sizes and text shadow;
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
  `ui.font` (`skin` by default: the skin's | `opensans` | `game` | `inter` |
  `fira`; CJK clients use the game font for bundled faces). A string holding Hangul, kana or Chinese
  characters on a client whose locale does not draw that script (a player's
  name in Chinese on an English client) takes the client's font for it
  (`Theme.ScriptFont`: Fonts\2002.TTF, Fonts\ARKai_T.ttf), checked again
  whenever the text changes.
- Text size: `ui.textSize` (0.8–1.4, default 1; Look > Colour & type) scales
  every role's size in `Theme.FontSpec` (`Theme.TextScale()`, rounded to half
  a point), apart from `ui.scale`; a change repaints every fonted string at
  once (it is one of the looks `Theme.Refresh` follows).
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
                                                        -- z: the height of the NPC or object there, optional (the walk ends on its floor);
                                                        -- returns the override (the target table) or false
Polestar.Nav.ClearTarget()
Polestar.Nav.ReleaseTarget()                           -- the point picked by hand lets go; the engine waypoint is guided to again
Polestar.Nav.IsOverride() -> bool                      -- the arrow is on a point picked by hand ("your own waypoint")
Polestar.Nav.StartTrip(target, name, label, ends) -> trip | nil   -- SetTarget's target becomes a trip (below); ends "arrive" (default) | "instance"
Polestar.Nav.Trip() -> { target, name, label, ends, inside } | nil   -- the trip under way, while its target is the one shown
Polestar.Nav.EndTrip(arrived) -> ok                    -- back to the guide: the trip's target lets go
Polestar.Nav.BackToGuide() -> ok                       -- any point picked by hand lets go (a trip as EndTrip); false on the guide's own
Polestar.Nav.MoveTarget(target, map, x, y) -> ok       -- a point of your own that moves (a party member): the same target, its arrival kept (one chime)
Polestar.Nav.Hold(map, x, y, label, f) -> target | nil  -- the arrow held there over every other target until Unhold (the death helper)
Polestar.Nav.Unhold()
Polestar.Nav.IsHeld() -> bool
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

A target with a height (`z`: a guide goal, candidate or spawn area at an NPC
or object) is not arrived at while the player stands a floor away: within
`max(2r, 20)` yards of it, `Walk.Floor` more than 8 yards above or below the
target's height sets `Nav.FloorHint()` to "down" or "up", holds "arrived"
off (and ends one), and the arrow shows a chevron of that way left of its
distance. Without a known floor nothing changes.

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
groups a goal's spots once per goal (cached by the compiled goal table)
through `Polestar.Regions.Of(cs, xs, ys, rs [, work])` (`Nav/Regions.lua`,
shared with the quest objective areas): each
spot's disc (its radius covers its spawns, at least 15 yd, plus 10 yd) joins
the spots on its continent whose discs come within 90 yd, nearest first, while the region stays
at most 700 yd across (a coast of spawns is a chain of regions, not one hull
over the sea). A region is the polygon whose sides touch the convex hull of
its discs from outside (16 sides, 8 under 200 yd), so it covers every spawn
of its spots (`members`: their indexes); `alt` when all its spots are. A grouping past
50,000 pair checks (`Regions.WORK`; only a crafted guide) draws no regions. `nav.areas` holds the target's
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

`Nav.Hold` sits above both: the death helper (`QoL/Death.lua`) holds the
arrow on the corpse (or the Spirit Healer, the dungeon's entrance) for as
long as the character is a ghost (#1382). A step change, the Engine's next
waypoint, a point picked by hand and another addon's `SetTarget` all go on
underneath without touching the arrow (no replan, no `WAYPOINT_CHANGED`);
`Nav.Unhold` once alive shows what is underneath then (a picked point only
while the step is still the one it was picked on, as an override always is).
While held, `Nav.HiddenWithGuide()` is false.

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
Polestar.Nav.nearby.Go(kind, skillLine) -> ok           -- weapon: skillLine is the weapon skill's line, or nil for any
Polestar.Nav.nearby.Weapons() -> { { line, label, known, level }, ... }   -- the weapons the class can use that a master of its side teaches
Polestar.Nav.nearby.MenuItems() -> items                  -- the guide window button's list (vendor first; a weapons page)
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
  away; while the death helper holds the arrow (`Nav.Hold`) the owner's target
  waits underneath and is theirs again once it lets go.
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
  never mirrors into it, nor into Shortest Path Forever's own stand-in (the
  global while it is installed and TomTom is not): a waypoint there starts a
  journey of its own, which Polestar steps aside for (#306). Default off: the
  stand-in has methods only, so an addon that finds the global and reads
  TomTom's settings (`TomTom.db`, its profile) would error; the option ("Let
  other addons set waypoints", Options, Integrations, TomTom) says so. With it
  off nothing sets `TomTom` and `/way` is not claimed.
- **Following TomTom** (`nav.followTomTom`, off; real TomTom only): hooks on
  TomTom's table: `SetCrazyArrow(uid)` points Polestar's arrow at that
  waypoint (not `corpse`, not `from = "Polestar"`), `RemoveWaypoint` and
  `ClearWaypoint` of it let it go ("Remove all waypoints" clears through
  `ClearWaypoint` alone). Waypoints TomTom restores at login are followed one
  frame after `PLAYER_ENTERING_WORLD`, the one its arrow was left on, unless
  something is picked already. A followed waypoint is not mirrored back.
- **TomTom's arrow** (`nav.useTomTomArrow`, off; real TomTom with
  `nav.tomtom`): `Nav/Bridges.lua` mirrors the target with `crazy` and
  Polestar's arrow hides while `Nav.TomTomArrowGuides()`: the player and the
  target on one continent, or either unknown. TomTom's arrow measures no
  distance to a waypoint on another continent and hides itself there, so on
  the way to one Polestar's own arrow and its route guide (#1325), and give
  way to TomTom's on arriving (`ZONE_CHANGED_NEW_AREA`, `Nav.Refresh`).
- **`/way`** (with `nav.answerTomTom`): claimed at login (`SLASH_POLESTARWAY1`)
  only when TomTom is not loaded and no `SLASH_*` global spells `/way`.
  `/way [#mapID | zone] x y [title]`: the zone is any name under the player's
  world, exactly, the one zone it begins, else the one it is part of
  ("barrens"); several print their names. `/way reset` clears.
- **Nearby services** (`/polestar near <kind> [profession]`; `nav.nearbyMenu`
  adds a "Nearby services" submenu to `MENU_WORLD_MAP_TRACKING` and
  `MENU_MINIMAP_TRACKING`): kinds trainer (profession, by skill line, or any),
  class, weapon (a weapon skill's line, or any), repair, reagents, vendor,
  food, general, arrows, bullets, ranged, innkeeper, bank, mailbox, auction,
  flight, stable. Food, arrows, bullets and ranged are vendors by what they sell:
  `forge data codex` gives every NPC an item lists as its vendor a role from
  the item's class and subclass (`sells_role` in forge-data's
  `codex/merge.rs`, with `sellsRole` in `tools/lib/codex/build.js` in step:
  `sells:food` 0/5, `sells:arrows` 6/2, `sells:bullets` 6/3, `sells:ranged`
  2/2, 2/3, 2/18). General goods go by the vendor's title instead
  (`is_general_goods`, `sells:general`), as no item tells them apart: cooks
  sell the same flint and wood. Vendor and these kinds
  leave out NPCs that are also trainers (`without`: the data lists Forever's
  Junior trainers as vendors, and they sell the player nothing), and their
  target names the NPC's title ("Keina (Bowyer)", `titled`). Weapon masters are the NPCs of
  `WEAPON_MASTERS` (the weapon skills each teaches, noted by hand) of the
  player's side. Mailboxes are the Codex's objects with the mailbox flag
  (`object`: `Codex.Each("object")` and `Codex.Object(id).mailbox`, walked
  once and cached), of the player's side or of both; one with no known side
  never counts.
  Places are the Codex's NPCs with that role (`Codex.WithRole`, loaded on
  demand, never in combat), friendly to the player's faction and outside
  instances; reagents are vendors listed in `QoL.data.reagentVendors` (`qol
  build`: a vendor whose subtitle names reagents); the class trainer is
  `Engine.NearestClassTrainer()`. The nearest spawn of each NPC by straight
  line (the player's continent first), the six nearest of those estimated by
  `Journey.Estimate`, the quickest becomes the target and one chat line names
  it, its zone and the time.
- **The guide window's button** (`nav.nearbyButton`, on: Options, Guide,
  Arrow & routes): an icon left of the bug, Skip left of it (left of the bug
  when it is off). Its menu is `Nearby.MenuItems()`: the services, a trainer
  per profession the character has, Vendor, a page of `Nearby.VendorPage()`
  (Nearest, Food & drink, and Arrows, Bullets, Bows & guns only for a class
  that can use a bow or crossbow, a gun, or either: `Nearby.Fits`, by
  `Gear.PROFICIENCY`; the map menus' Vendor submenu lists the same), and
  Weapon master, a page of
  `Nearby.Weapons()` (a known weapon, by `Compat.IsPlayerSpell` on its
  skill's spell, and polearms before level 20 are listed and off); off in
  combat.
- **The trip back to the guide.** `Go` starts a trip (`Nav.StartTrip`, the
  service's name and kind). `Nav` fires `NAV_ARRIVED(target)` once per
  arrival; on the trip's target, `Nav.EndTrip(true)` releases it and the
  arrow is back on the guide's step. Any other target (a goal clicked, a map
  click) ends the trip quietly. `NAV_TRIP(trip)` fires as a trip starts and
  `NAV_TRIP(nil)` as it ends. On the way, the guide window shows a banner
  and the button's list a first entry, both "Back to the guide"
  (`Nav.EndTrip()`).
- **Trips are Nav's** (#1686), for every "take me there": nearby services,
  a dungeon's entrance (the Dungeons page's "Guide me to the entrance" and
  the world map's dungeon pins, `ends = "instance"`: it ends through the
  instance's portal, going in, or coming out when it was started inside;
  reaching the door is not the goal), the training and riding banners'
  Show (`Class trainer`, `Riding trainer`), the class card's Show me (a
  quest giver) and a party member picked on the party panel (`Party`: one
  target moved with them by `Nav.MoveTarget`, so standing by them is one
  arrival and one chime; it also ends once they leave the party, go offline
  or have no place the client gives), which end on arrival. A point set on
  the map, by `/way`, another addon or a goal of another step is the
  player's own and stays until the step changes or they let it go: the
  arrow's menu (right-click, or a click on the journey's current step) and
  the journey panel's header x both say "Back to the guide"
  (`Nav.BackToGuide`).

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

Tested by `rust/crates/forge-addontest/tests/addontest/nav-handoff.rs` against a fake API written to its
`docs/api.md` (v1.16.0).

### MapCanvas — drawing on Blizzard's map frames

```lua
local view = Polestar.MapCanvas.Watch(map, fn)  -- map: WorldMapFrame or BattlefieldMapFrame; one view per map frame
-- fn(view, what, elapsed): what = "show" | "map" | "size" | "scale" | "alpha" | "hide" | "tick"
-- view.map, view.canvas, view.frame, view.shown, view.mapID, view.width, view.height, view.scale, view.zoom, view.pinScale, view.alpha
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
frames are under `map:GetCanvas()` (parenting is the client's, in C:
the scroll frame clips them, they show and hide with the map): the view's
own frame (`view.frame`) is the canvas's child and every drawing is made
under it, so hiding Polestar hides them all at once (see "Hiding
Polestar"). Each is made
with no parent and then set under its parent (`CreateFrameUnder`, Core,
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
`rust/crates/forge-addontest/tests/addontest/nav-mapcanvas.rs` runs every drawing with the maps' tables
guarded (`stub.guardMap`: any write of addon code fails), pins the list
of what is read and checks that no frame was made with a parent on the maps
or the minimap.

### Pins — map and minimap icons for every module

```lua
Polestar.Pins.SetLayer(layer, pins, opts)   -- replace a layer; opts = { world = true, minimap = true, edge = false, scale = 1,
                                            --   minimapAreas = false, minMapType = nil, worldLayout = nil }
Polestar.Pins.ClearLayer(layer)
Polestar.Pins.SetLayerVisible(layer, visible)
-- pin = { map, x, y, f, icon (Theme.Media name, texture path, or "map:<name>": a map mark), size, minimapSize,
--         color = { r, g, b, a }, tooltip = string | function(tooltip), onClick = function(button, owner), priority,
--         glow (soft halo), ring = { r, g, b } (ring round the disc), backdrop (scrim disc), area (yards),
--         hull = { wx1, wy1, ... } (a convex region in world yards on the pin's continent `c`),
--         areaOnly (only the area or hull draws, no pin), text (a few characters on the pin, outlined),
--         map marks only: ring2 = { r, g, b } (dashed ring further out), badge = n | "?" (accent capsule,
--         top right), state = "focus" | "dim", medal = false (the glyph alone), medalSize (px),
--         ping = n (a number new for each event: plays once on the minimap, Pins.StartPing) }
```

Map marks (`icon = "map:<name>"`) are the map's own glyph family: white masks
in `Media/Map/icon-<name>` (`tools/media/map.js`, 64 px over 27 units of a
24-unit grid, a relief and a black contour baked in, so the tint keeps both),
drawn at 27/24 of the mark's size, tinted with the pin's colour. Each sits in
a medallion 1.4 times the mark (rounded to even), the one untinted piece: the
icon pack's (`nav.mapIcons`; `Pins.IconPack()`: "skin", the default, takes
Polestar's, Halo's, or Hearth's for Hearth and the game's looks; "bare"
draws no medallion). The kit is tinted too: `ring` 5 px and `ring2` 11 px
wider than the medallion, the glow 2.3 times it (only where a pin asks:
the guide's target, a focused quest turn-in), the badge 14 px high. A mark
clamped to the minimap's rim keeps medallion and glyph, its medallion at the
rim, the edge pointer on its side toward the target. A city group of services
(`Maps/ServiceClusters.lua`) is one 30 px medallion with up to three glyphs at
0.4 of it and a badge with its count.

A pin with `ping` plays once on the minimap frame that shows it, the first
time that number is drawn (`Pins.PING.played`): three rings in its colour
expand to 3.4 times the mark, 0.22 s apart, each over 0.7 s with a strong
ease-out, fading as they grow (`Pins.PING_SECONDS`, 1.14 s), behind the
mark; clamped to the rim, they ring the edge pointer there. One `ns.Anim`
"value" tween drives them, so nothing runs once it ends; a released frame
stops its ping. Under `ui.reduceMotion` one ring 1.8 times the mark flashes
and fades over 0.5 s instead (no movement).

A pin's size (`size`, `minimapSize`, times the layer's `scale`) is its own;
the surfaces draw it smaller as the view widens, so a mark matches the game's
own at the default zoom (`PIN_ZOOM` in `Nav/Pins.lua`).
On the world map the frame's scale is `view:PinScale(0.7, 0.9)`, a map pin
under `SetScalingLimits(1, 0.7, 0.9)` (a 16 px mark's 22 px medallion at 15.4
on screen zoomed out, the game's 16 px POI icons; 19.8 zoomed in); on the
minimap the size is 0.7 of it at zoom 0 (the widest, the default: a 14 px
mark's medallion at 14) up to all of it at the closest zoom
(`Minimap:GetZoom()` of `GetZoomLevels()`), the look laid out again when the
zoom changes. The player's `nav.minimapIconSize` (default 1, Options ›
Appearance › Arrow › Map icons) scales minimap sizes and their cap. A medallion is held to
28 on the world map's screen and 24 px (times that setting) on the minimap,
and a pin takes the mouse over its medallion and at least 20 (world map, on
screen) or 14 px (minimap), through `SetHitRectInsets`.

The game draws the player's arrow as part of the Minimap itself, under every
frame parented to it, so no pin can go under the arrow. A minimap pin fades
instead (frame alpha), the more of the arrow (a disc of `ARROW_R` = 9 px at
the centre) its footprint covers: in full while clear, 0.3 (`ARROW_FADE`)
once one of the two lies inside the other.

Pins are drawn on the world map for the map being viewed (converted through Compat
for other maps). Optional `worldLayout(projected, view)` receives this layer's
`{ pin, x, y }` entries in viewed-map percentages and returns its world-map
layout; map and canvas-size changes run it again. It never changes minimap
pins. `minMapType` hides world pins on broader views.

The steps ahead (`Nav/Upcoming.lua`, layer `nav.upcoming`, `nav.upcomingPins`
off by default, Map > Guide & quests): `Nav.upcoming.Build()` takes the steps
after the live one that are for the character and not done or skipped, as
many as `ui.upcoming` (else five), each at its first open goal with a place:
one small pin in the accent with the step's number as its `text`, its alpha
falling from 1 to 0.35 with how far ahead the step is. A step whose place is
within 0.6 map percent of an earlier pin's joins it ("4+", every step in the
tooltip). Rebuilt on step, guide and tab changes and the two settings.

Pins are projected on the minimap; `edge = true` clamps that layer's
out-of-range pins to the minimap rim. On the world map they are Polestar's own
frames on the canvas, at the frame levels the map gives its own pins (MapCanvas,
below): pins at `PIN_FRAME_LEVEL_SUPER_TRACKED_QUEST`, scaled as a map pin
with `SetScalingLimits(1, 0.7, 0.9)` is (above), tooltip and click, the right button
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
(`PIN_FRAME_LEVEL_QUEST_BLOB`, no mouse, the box in canvas units), drawn when
any of it lies on the viewed map (the view's world-to-percent transform, the
trail's) inside a window around what the map's scroll frame shows: the view
and half its size again on every side. A pan or zoom out past the window, a
zoom in to a quarter of its width, or a zoom that changes the rim's width by a
quarter draws the hulls again for the view as it is then, so a zoomed-in map,
or OpenMap's stitched map over a whole continent, holds only the hulls near
the screen (#1622).
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
On OpenMap's stitched world map (`OpenMapAPI`, OpenMap's `docs/api.md`; an
optional dependency), the world map frame shows only the map under the view's
centre while OpenMap draws the rest, so the trail goes through OpenMap's own
placement instead: each run's continent yards to the shown map's percent through
a reference map on that continent (the shown map, or on the world map its
children), placed by `OpenMapAPI.WorldFromMap` / `MapFromWorld`; clipped to what
the map's scroll frame shows (and 4% past it), not to the map; every max(15,
view width / 60) yd rounded up to 15 yd times a power of two, so dots keep their
places through a zoom within a step; redrawn when a pan or zoom moves the view
(the canvas's and its scroll frame's place, read each frame) and when OpenMap
switches its map on or off (`OpenMap_StitchedChanged`). `nav.openmapDots`
(default on) is a switch of Polestar's in OpenMap's menu; it hides the dots on
OpenMap's map only. Only OpenMap's table is called; the map frame is only read.
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
  surface; `nav.minimapRoute` (default on, Options > Map > Guide & quests,
  "Route line on the minimap") takes the line, and the trail that stands in
  for it, off the minimap and keeps the guide pin (`surfaces()` here,
  `updateTrail` in `Nav/Layers.lua`).
- `nav.dotColor` (default `"route"`, the colours above) paints the walks one
  of `RouteLines.DOT_COLORS` (cyan, magenta, white: apart from the minimap's
  yellow herb and ore blips and gold quest marks) on both maps; flights,
  boats and the rest keep their own colours, so a walk and a flight never
  read as one line. `nav.minimapRouteAlpha` (20-100%) fades the minimap's line, either
  style; each style's own size (`RouteLines.SIZE_KEYS`: `nav.minimapLineSize`
  50 %, `nav.minimapDotsSize` 80 %, `nav.minimapSparkleSize` 150 %, Fitz's
  tuning for 0.3.6; 50-150 %) scales it, dots, spacing and the gap at the pin
  together (the strokes are laid out at the frame's scale divided by it).
  The line style window's "Minimap size" slider (key `nav.minimapRouteSize`)
  reads and sets the chosen style's; a size saved there before the sizes
  were per style became each style's own (`splitSize`). Both in the line
  style window, the world map keeping its own. The
  minimap frame sits at the minimap's level + 3, under Polestar's trail and
  pins: the client draws its tracking blips and quest marks into the
  minimap's own picture, under every frame on it, so no frame level puts the
  line beneath them. The player's arrow is drawn there too, so nothing is
  drawn within 9 px of the minimap's centre (`Strokes.PLAYER_GAP`: lines and
  strokes are cut there, the dots keep clear of it as of a stop's pin). On
  the minimap the dots keep their size, rim and 9 px spacing (screen pixels,
  so the same at every zoom, scaled by the minimap size) and flow: counted
  back from the walk's end and moved toward the goal at the sparkles' default
  pace (`view.phase`, the painter's 20 Hz driver; still under
  `ui.reduceMotion`); the world map's dots are 0.3.5's (tested against their
  recorded strokes). Dots and the line join the walk at the player while the player is on it (within 15
  yd, Follow.lua's BODY); only beside it do they run straight from the player
  to the point the arrow holds in sight (`joinPoint`). Sparkles always start
  abreast of the player.
- Line style (`nav.lineStyle`, `RouteLines.STYLE_CHOICES`): `"line"`,
  `"dots"` (the above) or `"sparkle"`, chosen on the welcome's setup page
  (`UI/Welcome.lua`, three cards each previewing its style), in Options
  (Guide, Arrow & routes, under "Route lines") and in the window the gear
  beside "Route lines" opens (`UI/LineStyle.lua`; the gear is `W.Toggle`'s
  `opts.gear`). The default is the line; an account Polestar knew before the
  line (`ns.IsNewAccount` false: a saved `PolestarDB` at load) with no style
  of its own gets `"dots"` written once (`PolestarDB.lineStyleKept`), so
  nobody's map changes unasked. Under `ui.reduceMotion` sparkles are drawn as
  dots (`RouteLines.Style()` is the style drawn).
- The line (`RouteStrokes`, `view.style "line"`): the walk's path in pieces
  at least 8 px long (points nearer the last one kept are passed over), each
  one line `nav.lineWidth` px thick (2-8, default 4; one less on continent maps)
  over a soft shadow 3 px wider on each side (`Media/Nav/line-soft`, even
  along x and feathered across y, as a client Line stretches its texture;
  the scrim at 75%); a bend sharper than about 14 degrees gets a round joint
  (the dot texture, the line's width across, no outline); a piece joined at a
  bend starts half the width back along its way, so the outer side of the
  bend has no notch. Chevrons every 90 px (`view.chevrons`) are in the code
  but the painters leave them off: on a 4 px line they read as notches.
  The walk being walked fades out behind the player over 120 px (12 px
  pieces from 45% down). Flights are dashed (7 px on, 5 off, 2 px, carried
  across their bends), rides stay solid, and a walk drawn straight with no
  walking path known (the geometry's `straight`, set by `Nav/Walk.lua` for
  its straight fallback; display only) is dashed as thick as the line at
  55%. A route to a new goal draws in from the player over 0.6 s (each
  paint shows that share of the strokes, both surfaces repainting 30 times
  a second meanwhile; not under `ui.reduceMotion`, not for sparkles, not for
  the same goal drawn again). Drawing only: no style, thickness or switch
  changes the route, the target or the arrow (tested).
- Sparkles (`Maps/RouteSparkle.lua`, `nav.lineStyle "sparkle"`), set in the
  same window. Sparkles (ported from Forever Sparkle Trail)
  sit along the same draw paths, measured in yards and split by continent:
  evenly spaced on screen at any zoom (`nav.sparkleDensity`, 36 px at 1 to
  9 px at 10), each a `Media/Nav/sparkle` star over `Media/Nav/glow`,
  additive and tinted (`nav.sparkleColor`: loot gold and four others, or
  each leg's dot colour), twinkling on its own hash and drifting toward the
  goal (`nav.sparkleFlow`); `nav.sparkleIntensity`, `nav.sparkleSubtlety`,
  `nav.sparkleSize`, `nav.sparkleMax` (per surface) and `nav.sparkleLater`
  (the legs after this one, at 40%), with three presets
  (`RouteLines.ApplySparklePreset`). They are painted on the same two frames
  from their own pools, redrawn 30 times a second while shown; the leg being
  travelled starts at the player (within 60 yd, checked every 0.25 s). A
  draw emits only along the stretches of each run whose segments reach the
  minimap's face (within radius × √2 of the player, plus a sparkle's jitter)
  or the map's canvas (`Sparkle.Spans`, over the run projected once per
  route, map, canvas size or OpenMap change), at most 4000 places per
  surface, and sets a texture's colour or shows it only when that changes:
  its cost follows the sparkles shown, not the route's length. With
  OpenMap's stitched world map on (`OpenMapAPI.IsStitched`), the world map
  places them with `OpenMapAPI.CanvasFromWorldPos` and lifts the frame above
  `OpenMapAPI.ArtTopLevel()`.
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
Polestar.Nav.EstimateTravel(from, to, budgeted, noHearth) -> seconds | nil[, "busy"] -- same planner, cached; budgeted (the API's): no new plan past 25 ms a frame; noHearth: the way without the Hearthstone (the Engine's `hearth` goal weighs the two)
Polestar.Nav.RegisterTravelData(d, replace)        -- TravelData.lua: flight masters, flights, transports, portals, inns
Polestar.Nav.AddTravelPaths(chunk)                 -- learned walking paths (nodes: c, wx, wy, gateway, uiMap)
Polestar.Nav.RegisterCrossings(d)                  -- zone crossings (merges; ids seen before are skipped)
Polestar.Nav.travel.SkipLeg() -> bool              -- leave this hearth/teleport/flight/ride out for the target; else the next leg
Polestar.Nav.travel.SkipReplans(leg) -> bool      -- skipping it replans (the prompts' "Skip this leg"), else "Mark this leg done"
Polestar.Nav.travel.RestoreWalk(c, x, y) -> bool  -- the path to (c, x, y) failed or was cleared: the walk's straight estimate again
Polestar.Nav.travel.WalkUnreachable(c, x, y) -> bool -- no walk joins the player to (c, x, y): a portal taken there is left out (#568)
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
class teleports, learned path nodes and crossing waypoints. A flight master
of the player's faction not learnt yet, on the start's or the target's
continent, is a vertex too: walked to, learnt there (5 s) and flown from to
known ones, never flown to and never walked on from (no walk measure from it;
otherwise Rut'theran's would beat the Darnassus portal, #989) (#1174:
Ironforge's, beside a player who knows Menethil Harbor). The known flight
masters (`flags.taxi`) come from the flight map when one opens, the game's
"New flight path discovered", and the world map's flight points
(`C_TaxiMap.GetTaxiNodesForMap`, a node's `isUndiscovered`), read on every
loading screen and on `TAXI_NODE_STATUS_CHANGED`, so a flight path learnt
while Polestar was not running counts before the next flight map (#1308);
a client that reads no node as undiscovered is not trusted. It orders by
a cost (the Hearthstone carries a `HEARTH_MARGIN` of 120 s on top of its
time, a teleport 10 s) and keeps the real seconds of every leg apart, so
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
The Hearthstone's hour-long cooldown is spent once a trip is long enough for
it to clearly pay (#1096, Fitz; 0.3.3's 8 and 5 minutes walked where a
hearth was better): a route `Nav.PlanRoute` chose with a
hearth leg is planned again without it (`noHearth`) and kept only while the
way without it takes at least `HEARTH_MIN_TRIP` (180 s) and the hearth saves
at least `HEARTH_MARGIN` (120 s) after its cast and loading screen
(`HEARTH_SECONDS`, 15 s); its label then says what it saves ("Hearth to
Sentinel Hill: saves 6 min"). It plans from wherever the Hearthstone is
bound (`bindInn`), for any target. `Nav.EstimateTravel` and the Engine's
`hearth` goal (`Own.hearthPlan`, via `Nav.HEARTH_*`) weigh it the same way.
While a quest timer runs (`Compat.QuestTimerRunning`: a log quest with
`C_QuestLog.GetTimeAllowed`, not ready and not failed), the route and the
player's own estimates leave out the Hearthstone and the class teleports: a
player's teleport reset Trial of the Lake (#1327), and a hearth leaves an
escort behind. `QUEST_LOG_UPDATE` marks the state to read again on the next
`Refresh`, which plans again when it changed.
A class teleport whose landing lies in the zone the player stands in
(its point's `map` equals the plan's `map`, the player's zone) is never
planned: a Mage in Stormwind is not sent to Teleport: Stormwind to cross the
city (#1515).
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
`Nav.Sample` follows it with `Nav/Follow.lua`, which knows nothing of where
the path came from (the walking engine today, a guide leg's polyline later):
`Follow.Step(xs, ys, zs, left, n, state, px, py, stop, join, sight, hill)`. The player's place
on the path is their projection onto it: the nearest point on a segment
from the current one to 60 yd further along, so a point passed to one side
counts as passed, and coming at the path at an angle or walking beside a
road never holds the arrow on a node. The projection only moves forward;
a later segment that is not the next one takes over only when 4 yd nearer
(the far side of a hairpin), and it never moves past a blocking point the
player has not come within 5 yd of: a point on another floor than the one
before it (stairs, a ramp, a lift's landing), and,
on a piece of a split walk, every point after the last one before its
chokepoint (`Travel.Aim` passes `leg.seg` as `stop`). Another floor is more
than 6 yd (`FLOOR_STEP`) above or below; outdoors (`Walk.Aim` passes `hill`)
it must also be steeper than 45° (`FLOOR_GRADE`, 1 yd up or down per yard
across from the point it is measured against). 0.3.7 (Fitz in Desolace: "it
gets stuck on a point and fixates on it"): the paths are corners joined by
long straight pieces, so the 6 yd rule alone took a hillside between two
corners for a floor (14,244 of its 14,588 floors on the baked legs, in 70% of
them), held the arrow on the first until the player came within 5 yd, and
left it pointing back at it when they cut it. Indoors any 6 yd is a floor, as
before; a drop, a lift, a climb and a floor straight overhead are steeper.
A path that lands late (a search asked when the player strayed, from where
they stood then) is followed from the player's place on it (`Follow.Catch`,
called by `Walk.Aim` with the yards walked since the ask): the nearest point
within those yards plus 60 along and 25 yd of the player, never past `stop`,
and within 10 yd of their floor when it is known. 0.3.7 (Fitz walking down a
steep slope: the arrow pointed back until he stopped): each late path started
behind him with steep corners between, the follower held at the first, he
strayed again, and the next late path did the same. The arrow's own search is
urgent (`job.urgent`, Routing/PathJobs.lua): it is sliced before every other
search but a finished one's answer, never sharing the frame budget with the
later legs'. From the projection the
arrow aims at the furthest point along the path within 35 yd of the player
(`RADIUS`) and 45 yd along it (`AHEAD`), between points, so it slides along
the path as the player moves. Every path point on the way lies within
12 yd (`PAD`) of the line from the projection to it, so a road's wiggles stay
inside; a real corner stops the aim where the line cuts inside it by 6 yd
(`CORNER_PAD`), and it comes round as the player does. Where points are 8 yd
or less apart on both sides, the aim slides along the path smoothed over each
point's neighbours, so a zigzag either side of the road cancels out. It never
aims onto another floor, past the path's end (the leg's goal: crossings,
approach chains and guide gotos are legs of their own) or past `stop`. When
no path ahead lies within 35 yd (the player has wandered off), it points back
to the path 10 yd ahead of their place on it. Beside the path in open ground
(0.3.5; Fitz, 0.3.4, running parallel to the path up a Tirisfal hillside: the
arrow pointed 90° back to it while the target lay ahead) the corridor is
wider: outdoors, with the floor under the player known, `Walk.Aim` passes
`sight`, and a player more than 15 yd (`BODY`) and at most 100 yd (`OPEN`)
off the path, or within 50 yd (`join`) of a fresh path's start (a search from
where they stand runs straight across to a road first), aims at the furthest
point along it, up to 150 yd past their place on it, that they can walk to in
a straight line: `Path.Sight` (Routing/PathGrid.lua) walks the grid cells
of the line as the drawn line's straightening does, following the surface
from the one under the player, and refuses a closed step (a wall, a cliff
edge), another floor, water, indoor or indoor city ground and a town hostile
to the player's faction; it reads decoded clusters only (unknown otherwise),
decodes nothing, puts back the use stamps it moved and allocates nothing.
The candidates run from the furthest in, ever closer together, so a look
costs one line in open ground and about ten at most, and it is made again
only after the player moves 2 yd. Where nothing ahead is in sight (beside a
cliff, a river crossed by a bridge, a building's walls) the aim is the
corridor's above: tight. The aim never runs back along the path: a point
found in sight stays the aim until the player passes it, a further one is
found, or they have moved 12 yd (`SIGHT_HOLD`) without seeing it again (on
the real maps the grid closes a step at a lamp post or a fence post between
two looks), and within 15 yd of the path (the road's join) the corridor's aim
wins whenever it lies further along. A point held ahead keeps the arrow on it
until the player comes within 10 yd of the path (`SIGHT_NEAR`), not 15, and
nearer still it stays the aim, not looked for again, while it lies further
along than the corridor's (0.3.6: a player following it back toward the path
wobbled across 15 yd, and the arrow flipped 37-57° between the two aims at
every crossing). While a point ahead is in sight
(`state.sighted`) the player has not strayed: no new search. The route line's walk then starts
from the player toward that point (`Walk.SightAim`, Maps/RouteLines.lua), not
straight across to the nearest one. The yards it reports are
the yards left along the path (straight to the end of the segment the player
is on, then along it); with the arrow on a point in sight beside the path,
straight to that point, then along the path from it (0.3.6: beside the path
the segment's end could lie behind the player, and the yards counted up while
they closed on the target). `Travel.Aim` returns those
yards as a fifth value, and `Walk.Progress(c, x, y)` gives the yards along
the path to the player's place on it and the yards between them. The arrow
eases into each new direction (`Nav/Arrow.lua`'s `DAMPING`, swinging at most
`MAX_TURN`, about 200 degrees a second), on the target's bearing on the map:
turning the camera moves it at once.
A new goal (more than 1 yd away from the searched one) cancels the search
in flight and drops the path; more than 25 yd off the path asks again, unless
the aim is in sight as above (at
most every 2 s, every 10 s while more than 2,000 yd of the walk are left:
each ask searches the whole walk; the old path kept meanwhile); a failed search (`nodata`,
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
board point, a tram, zeppelin or portal end's floor: "End heights" below)
carries that one the same way; walks to other leg ends go
without a height (docs/NAV_QA.md Z1-Z3). A later walk from a board point
(off the boat) starts at the deck's height (`from.z`; asked once more with
neither height when that fails), and the measure into the target gives each
dock place its deck height (`FindMany`'s per-target `z`). An end without a
height (a map-click waypoint, a hand-set target) whose walk finds nothing is
walked again from each other surface of its cell, lowest first, the start's
then the goal's, six tries at most (`Routing/Path.lua` `runAny`, for `Find`
and `FindCost`): the surface a search without a height picks can be a pocket
no walk leaves (William MacGregor's house in Westfall: the ground's surface
4 yd over the house floor).
**The player's floor (#234, Ruling 36).** Forever's `UnitPosition` gives no
height (Compat reads its 0 as none), and `Path.Find` from a point without one
starts from the cheapest surface within a cell of it: a roof, rock top,
bridge or upper floor above the player (at the Den's camp in the Valley of
Trials, the rock top over the Den, whence Fastest crossed the hill to
Hana'zua). So `Walk.lua` follows the height of the surface under the player:
`Walk.Aim` checks at most every 0.25 s and reads the cell's surfaces
(`Path.SurfacesAt`, into one reused table) only after moving 1 yd. Unknown,
it seeds where the cell's surfaces lie within 10 yd (the router's `ZTOL`:
the lowest), or, when `Compat.IsIndoors()` says indoors and the surfaces
differ in indoor-ness (class indoor or indoor city against the rest), on the
indoor ones when they lie within 10 yd (off the Undercity's lifts: the city
under Tirisfal's outdoor ground). Outdoors says nothing: a city's streets and
gates are of the indoor city class under the open sky (Stormwind's Trade
District over its canal level, Ironforge's gate under the mountain), so the
one outdoor surface there is the ground below or above; it never overrides a followed floor with
the indoor state. Where seed cannot tell (the Undercity: every cell has indoor
layers more than 10 yd apart), each surface read (indoors: the indoor ones) is
a candidate floor that follows the surface within 10 yd of it at each read; one
with none there two reads in a row is gone, and while any are followed they
decide instead of seed; the last one left is the floor (a few dozen yards on
the Trade Quarter's ring rule out the entrance hall above it). Some never come
down to one (the canal ring: canal and walkway under every step); while the
client says indoors, a search from the player with the floor unknown starts
only on the candidate floors (`Path.Find`'s `from.floors`, the player's place
in `Walk.Measure` too): the canals and streets, never the roofs or the Ruins'
ground over them. On a map whose surfaces carry their area (`Path.AreaFormat`:
each WMO group's WMOAreaTable row, `Path.SurfacesAt`'s fifth argument), the
surfaces the client's subzone names (the Undercity's "The Canals", its
quarters, the hall's "Ruins of Lordaeron"; the rows' English names,
`Path.AreaName`: an English client only until Polestar_Names carries
WMOAreaTable names) are the floor at once when they lie within 10 yd; on
several levels (the hall and its gallery; the Trade Quarter's ring, walkway
and canal) they keep the candidate floors to those levels (`Walk.Floors`: a
chain node then holds the start when one of them is on its floor and none
lies more than 20 yd below it; the plan is made again once the floor or the
floors are known). They come before the seed and the candidates, and a single
named level corrects a followed floor on another level. `Walk.Floor`
gives the planner that floor (the client's height first): a crossing end with
a height (`z`) is reached, and a leading walk to it dropped, only with the
floor within 20 yd of it, or with the floor unknown within 5 yd; a crossing's
walk begun near its end with the floor then found off it plans again. Known, it follows the surface nearest it, never more than
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
Hand-made walks win: a crossing's own walk from end to end (but one between
ends whose heights, `z`, lie 20 yd or more apart: a lift, which the engine
rides), a walk between chain neighbours, to a chain node past its mouth, or
from inside a chain (`leg.handmade`: the data's own links), and a
guide goal whose last located goal before it, across steps, is a `goto`
(the author's way in: a cave's mouth, a building's door; the goto itself is
walked; goals within 3 yd of the target, another quest of the same NPC,
are looked past) keep the straight arrow, so a target underground is never
routed over the hill above it, nor one upstairs onto a ledge outside its
floor (#1338). `nav.navRouting` (default on, Guide > Arrow & routes) off, the
engine missing, or Polestar_Nav not loaded: the straight arrow everywhere.
`GetRouteGeometry` (rebuilt on `NAV_ROUTE_GEOMETRY`, which fires on every
plan, leg change, target change and path arrival) gives the map lines the
legs from the current one on: the current walk as the engine's points once
in, else its search's sketch (below) until then, else player (or leg start)
to leg end; a later walk as its own searched path once in, else its sketch
(below), else straight; a crossing the arrow walks straight, current or
later, as its own searched path or sketch when that is at most twice the
straight line's length, else straight; a flight as its hop nodes; a ride or
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
each 100 yd piece of the line, of `danger[Path.ZoneAt(...)]` (1 elsewhere);
the table is the plan's level's without the player's and the target's zones,
and a line's own ends count like any other ground (a walk between two zone
crossings inside Western Plaguelands is a walk through it, #566) (`Travel.Replan` and
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
estimate, except a portal's end: it walks to the target by no route (#989),
and neither does any place walked to from it (Rut'theran's boat pier beside
the portal's landing, #1564) until a ride, a flight or the Hearthstone takes
the player off that ground; a place farther or beyond the nearest 16 keeps it too; a target
within 400 yd of the player is not measured at all (its plan keeps the
straight estimates, the arrow its own search: a batch is about a second of
router work, and a guide sets such a waypoint at every turn-in); the
player's measure holds within 50 yd of where it was taken. Farther, the
player's walk counts as missing from the measure, so the next plan (at most
once per replan) measures it again: alone (a batch of one from the target,
at the height and with the opts the measure found its walks with, the other
places' walks kept, as a batch prices each place's walk on its own) when
every other place is in the measure, else in a whole batch; meanwhile it is that measure less the
yards moved (its cost scaled alike), never less than the straight distance (x1.0), so a walk never
gets dearer for coming closer. Within 400 yd of the target, where it is not measured again, the
player's walk keeps the straight estimate (#1053: a winding walk measured from the Barrens, less
the yards moved, still counted thousands of yards beside Hamuul Runetotem on Thunder Bluff's Elder
Rise, and the route went to the north lift's top and back). A walk on from a crossing's far end or a
chain's mouth is no hand-made walk: the arrow and the route lines follow the
engine's path on it like any other. Measures
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

**Every walk's shape at once.** A search from a cold start is mostly its
endpoint and lift-landing grid searches and the clusters it decodes (Mulgore
below Thunder Bluff to the Barrens: about 0.5 s of CPU, 2-3 s at a 60 fps
frame budget), and the later walks wait for the planner's measure besides.
So as soon as a route is planned (`ROUTE_CHANGED`, `ROUTE_ADVANCED`) every
later walk leg that will be searched (below), and a crossing the arrow walks
straight, is sketched with `Path.FindCoarse`, one at a time, ahead of the
measure (a drawn job) and whatever else runs: an A* over the entrance graph
alone (Routing/Path.lua `sketch`: no grid decoded or searched, the ends and
lift landings joined to their cluster's entrances at straight yards), a few
milliseconds a walk, whose line is the start, each border crossing and lift
landing on the way, and the goal. Sketches go first; then, once the arrow's
own search is in, the walks inside one cluster, which have no entrance route,
are searched whole (their path
is then kept as the walk's own, priced like a searched one). The arrow's own
search sends a sketch beside it, drawn until its path is in. A sketch
prices nothing (`Walk.LegPath` reads only searched paths) and is replaced by
the walk's path when that lands; on the shipped maps its stretches stay
within about 150 yd of that path.

**Every later walk's path.** Once the plan has settled (no measure running)
and the arrow's own search for the walk it is on has answered (checked on
every `ROUTE_CHANGED` and `ROUTE_ADVANCED`: the current walk's goal must be
the one searched, with a path or a failure; a flight, a ride or a hand-made
walk has none to wait for), each later walk leg that is not hand-made (a
crossing is searched, for its line only: never priced by it), not
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
`goto` end leave the hand-made caption alone (K8), but a lift the path rides
(its height changes 20 yd or more there) is always a step, whatever its
floor guard or the ends near it. Captions: a passage names
the area on the side the path reaches 25 yd past it ("Cross the bridge to
Lakeshire", "Through the gate into Orgrimmar"); a cave or building its
name ("Walk to the Frostmane Hold cave mouth"); without a name, the kind and
the zone ("Through the gate in Durotar"); never empty or "Unknown" (K1). A
lift is a walk to the landing the path reaches first ("Walk to The Great
Lift, Bottom": the side comes from the path's direction, K4) and a `lift`
leg to its paired landing ("Ride the elevator up" boarded at the bottom,
"Ride the elevator down" at the top), timed and captioned by
`Transit.NextDeparture`/`Caption("lift", ...)` (30 s without); within 30 yd
of the landing the walk's label already reads as the ride; other steps
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
keep their path times. A search that fails as `unreachable` (the player and
the walk's end lie on parts of the maps no walk joins) also goes to
`Travel.WalkUnreachable(c, x, y)`: when a portal is taken at that end, the
portal is noted for the target and the way planned again, and the plan leaves
it out while the engine's measure has a walk from the player to the target
(the top of Teldrassil and the Rut'theran portal, #568). A boat, zeppelin or
tram keeps its walk: a deck need not join its pier on the maps.

**Zone crossings.** Without crossing data a continent walks as it always
did: straight lines between any two points on it (x1.25 detour) plus learned
paths. With full crossing data for a continent (`complete = true`), a straight
walk stays inside one zone; between zones it goes only through

- a crossing: two waypoints, one in each zone, at a tunnel, pass, bridge, gate
  or lift, each with an arrival radius and optionally the height of its floor
  (`z`: a walk to that end ends there, the Undercity's entrance hall rather
  than the city under it), joined by an explicit walk link, with a
  caption per direction (`ab`, `ba`; else "Walk to <zone>", "Go to <zone>" before 0.3.7), optionally one way;
- an open-ground pair: two zones whose shared border is walkable anywhere
  (optionally one way);
- an approach chain: ordered nodes with radius and caption (a cave, a climb, a
  dungeon approach). Only the mouth (and with `open = "both"` the last node)
  links to its zone; the other nodes link only to their chain neighbours. A
  start or target within max(2 x radius, 30) yd of such a node is inside the
  chain and attaches only to the nearest node and its neighbours, so routes
  enter at the mouth and leave the way they came ("Follow the path out", or the
  node's `back` caption). A node may carry its floor's height (`z`): a start
  (with the player's floor, `Walk.Floor`, known and within 20 yd of it) or a
  target (or one with no height at all) is then inside only on that floor. A
  hop between neighbouring nodes whose floors lie 20 yd or more apart within
  15 yd on the map is a lift: a `lift` leg ("Ride the elevator up/down",
  Transit's lift id and timetable), the walk to it "Walk to the lift". The
  Undercity's way in and out is one such chain, `undercity-south-lift` (from
  Fitz's own walk): Tirisfal's front door, the corridor and the entrance hall
  to the south lift's top and bottom landings, both ends mouths; the other
  lifts serve walks inside the city.

A point's zone is its uiMap when the crossing data knows that zone; a zone
the data lists as `wild` (no crossing data, e.g. the zones only Forever has)
walks as before. The player on a continent's map (the client puts them on no
zone's in some caves and instance entrances: the cave before Blackfathom
Deeps, #1359) is placed by the zone under that spot of the continent map
(`Journey.ZonePoint`, as the world map places it). Any other map (a
continent map, an instance) takes the walking maps' zone at the point
(`Nav.danger.ZoneAt`: the zone field of Polestar_Nav's maps, the client's
area chunk by chunk) when the data knows it, else the smallest known zone
frame holding the point (Forever's frame where Forever redrew the map,
Stormwind City with its harbour, else Era's). The frames are rectangles that
overlap widely, so they are the last resort: the Blackfathom Deeps entrance
lies in Ashenvale's and in Felwood's, and Felwood's is the smaller. Walk
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
of both continents (`complete = true`): `data/crossings.json`,
committed, written by `node tools/polestar.js travel import --carbonite
<ZoneConnections.lua> --source <text>` from Carbonite's Classic Era zone
connections (GPL-3.0; `tools/lib/travel/carbonite.js`): its walks between
two zones of one continent, both ways unless Carbonite marks one way, every
end with a 30 yd arrival radius (Carbonite gives none); its boats, zeppelins,
tram and portals are TravelData's own transports and are left out. Its
`open` pairs are not Carbonite's: borders the navigation grid finds walkable
along their length (`nav aids` open pairs; Elwynn Forest and Duskwood,
Duskwood and Westfall, whose river the walking engine swims), so a walk
across them is not sent round to a road crossing (#371, #421); a re-import
keeps them and its `source` says so. `travel
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

**End heights.** An end on dry ground gets a height instead
(`transports.js` `endHeight`; with no grid, none): the surface of its
column nearest the height of what stands there, within 10 yd, by the same
region and open rules. That height is the Deeprun Tram's AreaTrigger in
Stormwind and Ironforge, a portal's AreaTrigger and its classic-db
destination, or the spawn of the dock NPC an end is placed at (zeppelin
masters, wharfmasters: `data/forever/spawnz.json`, within 15 yd of the
end); never a ship's stop (the ship's origin: a zeppelin's lies about 17 yd
above its tower). Without it the walk ended on the cheapest surface of the
cell: the roof above the tram's entrance, 417 yd round by the Keep where
the entrance is 131 yd away (#338), or the foot of Orgrimmar's zeppelin
tower. travel.json carries it as the end's `z`, TravelData.lua as the
end's tenth field (a number, where a board point is a table); an end with
a source height and no surface near it warns (the Undercity tower's top
under Hin Denburg is not open both ways on the grid).

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
    | untimed "Boat: average wait 2:55"
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
Village, area triggers; Zephras Isle's shrine portal up to the Rohashi
Spires and the Portal to Valanaar back down, game objects whose teleport
targets are server-side, so their landings come from players' recordings,
#1674; 5 s each) are one-way links a -> b for the planner.

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
grown from his map format, `forge nav pack`; format 3 adds each floor's WMO group
area, the WMOAreaTable row whose name is the client's subzone there, from the
grid's `<tile>.area.gz` sidecars and `areas.json`: `Path.SurfacesAt`'s areas,
`Path.AreaName`, for telling a city's levels apart); Polestar's travel planner (above) keeps choosing
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
hostile hub's rim. A walk that starts or ends in a hostile town (`Path.HubAt`
at its start, its goal, or the player's place in a measure; `opts.homeHub`,
set by `Nav/Walk.lua`) is priced as for no profile (`costNone`, no hub
multiplier), so it leaves or enters by the town's streets and gate: priced
as hostile, the shortest way off the town's ground won (a Tauren at
Stormwind's Deeprun Tram walked 3,700 yd over the walls and round the
mountains instead of 750 to the gate). Its drawn line still names the towns
it enters for the profile (`job.hubs`); other towns on such a walk are not
kept out of. A map of format 1 (0.2.4's, no class field) is class 0
everywhere, has one edge cost for every profile and keeps the 1.0
heuristic, so it routes and straightens exactly as before classes, for any
profile and style.

**Zone danger.** Each map tile of the walking maps carries the zone of its
16 x 16 chunks (the metadata's `zone` field, `forge nav pack`: the grid's chunk
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
    Nav0*.lua, Nav1*.lua, Nav2991*.lua  ours: `forge nav pack` from the grid (128 cells a tile, 4.17 yd), listed in PACK.json
    Chokepoints.lua       ours: PolestarNavChokepoints[map] for the walk's named steps
  Routing\Costs.lua     ours: Polestar_NavCosts, the ground classes' multipliers and the faction profiles
  Routing\PathGrid.lua  ours from his: decoded clusters and ground classes, memory ceilings, frame slicing, string-pulling
  Routing\Path.lua      ours from his: HPA* between clusters, the grid inside them priced by class, FindMany's Dijkstra;
                        lifts: Chokepoints.lua's lift landings (bottom, pair = its top) as abstract vertices, the ride
                        175 (25 s at run speed) either way, joined to their cluster's entrances and to a start or goal
                        there by grid searches (a few numbers a landing kept, 64 at most)
  Routing\PathJobs.lua  ours from his: the coroutine queue sharing Path.budget (3 ms) a frame
  API.lua               Polestar_NavEngine = the Path table, plus Available(map); the memory ceilings
```

**Memory.** The packed maps (format 2, all three) are 33.9 MB of files; loaded,
the Lua heap holds about 34 MB (0.2.4's format 1 maps 28 MB; his own three maps were about 12 MB). On Leffe's
maps (maps format 5) Polestar_Nav holds 1.4 MB and a continent's part 17 / 21 MB (Eastern Kingdoms / Kalimdor);
only the player's continent's part loads (below). A search decodes the clusters (ADT tiles) it crosses into a
few byte strings each (`PathGrid.lua` decodeGrid: kind = walkable value and class, moves, heights, each cell's
floors, step masks and one list of the other moves and arcs, read with `string.byte`; nothing per node in a
table): 0.2-0.45 MB a cluster on Leffe's maps, where four tables a node field took 2-10 MB. The decoder's
scratch arrays are reused until `Idle`; an endpoint tree a connection gives up goes to a pool for the next one,
and at most 4 trees and 65,536 nodes between them stay (`Path.lua` connect); a decoded graph keeps only its
entrance lists and graph strings (`metadata` reads an entrance's cell, layer and component from the string).
`API.lua` sets `Path.cacheKB` 8 MB of grids and `Path.graphKB` 16 MB of graph while a search runs, and
`Path.graphRestKB` 1 MB at rest. Measured by `nav-memory.rs` (Lua 5.1, the walks and the 16-place batch there,
2026-10-25), Eastern Kingdoms / Kalimdor: 18.3 / 22.4 MB loaded, 39.8 / 29.2 MB at most while searching, 91.4 /
7.9 MB allocated in all, 19.8 / 22.5 MB at rest (the grid's maps, both continents: 35.3, 84.5, 163.6 and 40.7).
Since the walking floor (#234) the cluster `Path.SurfacesAt` reads (the player's) stays decoded at rest while
the arrow runs: one cluster; none without a target or 2 s after the arrow's last update. Its surfaces' areas
(maps format 3) are read from the cluster's area string from a checkpoint every 256 nodes (`PathGrid.lua`
`areaMarks`, built under the frame budget by the `Path.Prefetch` that decodes the cluster, dropped with it), not
from the string's start: a city cluster's floor nodes lie tens of thousands of nodes in, and the scan from the start
cost 2-15 ms a read in Orgrimmar and the Undercity (up to 40 ms), every quarter second while the player walked
indoors (#1682).

**A walk inside one cluster** (`Path.lua` run) skips the start's endpoint tree when it can. Each end's tree is a
Dijkstra over its whole cluster to the entrances; the goal's is kept (`connect`), but the arrow asks again from a
new start every few steps, and a moving start never reused its own: each ask flooded the cluster again, 15,000 to
60,000 expansions for a quest objective a few yards off (measured in game, 0.3.5). Any walk that leaves the cluster
comes back through an entrance e, so it costs at least the straight yards from a start surface's own cell to e at
the cheapest yard (the abstract search's lower bound) plus the goal tree's exact cost from e. With no lift in the
cluster, each start surface's A* to the goal runs first with the least of those as its limit (`search`'s `limit`:
it stops once past it); when every surface reaches the goal under it, that walk's cost is the cheapest there is and
the full search is skipped. A surface that cannot (a rock top the grid cannot leave, which its tree would move:
`settle`) sends the search the full way. The cost is always the full search's; a tie between the direct walk and
one through an entrance on it may draw the other line (`Path.direct = false` runs the full search always:
`nav-maps.rs`, eleven asks walking in from 60 yards, 236,359 expansions down to about 20,500 from cold caches).

A short walk across a cluster border (up to `BOUNDED_YARDS`, 400: most round the Crossroads, where four clusters
meet) keeps the goal's full tree but grows the start's only as far as it must: each surface's Dijkstra stops past a
cost R (`connectWithin`, `search`'s `limit` without a goal), the abstract search runs on the entrances it met, and a
walk it finds for at most R stands (any other leaves through an entrance beyond R, so costs more). R starts at 1.25
times the straight yards plus 25; a walk dearer than R gets one more try with R that cost, and none found or a second
miss takes the full tree, so a far or unreachable goal never pays a growing tree. A surface whose tree is complete
and met no entrance goes through `connect` (settle) as in `connectPoint`. The trees are the job's own (`trees.B`, in
the scratch `pump` swaps): searches take turns, and one job's tree is never rewritten under another's. Measured with
`Path.direct = false` as the reference: 80 random walks of 150-1,650 yd on both continents in every style cost the
same, at 1 % fewer expansions (2 of 80 over 5 % more, the worst 38,715 to 59,379); the arrow's re-asks round
objectives take a few hundred to a few thousand instead of 20,000-60,000 (`nav-maps.rs`: three asks across the
Crossroads border under 25,000 against 78,944; walks queued together taking turns; starts without a height).

**A map is used whole.** `API.lua` drops a map whose packed tables hold
fewer entries than its `counts` (a part file missing from the folder, or one
that failed to load), and every map when the client lacks
`C_EncodingUtil.DecodeBase64` or `DecompressString`: the engine then has no
data for it and the arrow points straight, where it would otherwise raise a
Lua error the first time a search reads a missing cluster's graph
(`rust/crates/forge-addontest/tests/addontest/nav-load.rs`). A grid block that fails to decode is the
engine's own case: that cluster counts as empty. The bytes of the shipped
blocks are not checked at load; `forge nav check` pins them by sha256.

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
Path.FindCoarse(map, from, to, callback, opts, whole) -> job  -- callback(points, cost, job): the entrance-graph sketch (points.coarse); inside one cluster the drawn path with whole, else (nil, "cluster", job)
Path.FindMany(map, from, targets, callback, opts, reverse, progress) -> job  -- costs[i] or false; job.yards[i]
Path.ReuseMany(job, point, profile, style, danger) -> bool  -- may a batch from job's source serve one from point for profile in style with danger
Path.ZoneAt(map, x, y) -> uiMapID | nil  -- a point's zone (the maps' zone field)
Path.HubAt(map, x, y, profile) -> id, name | nil  -- the town hostile to profile whose ground (a hubs disk) holds the point
Path.SurfacesAt(map, x, y, out) -> n | nil  -- the cell's walkable surfaces: out[i] height, out[-i] marks (1 water, 2 indoor); nil: its cluster not decoded (a Prefetch is queued)
Path.Prefetch(map, x, y) -> job | nil  -- decode that cluster under the frame budget for SurfacesAt (one job at a time)
Path.ReleaseSurfaces()  -- cancel a pending Prefetch; the cluster SurfacesAt reads may go at rest
Path.Sight(map, x1, y1, z1, x2, y2, z2, profile) -> bool | nil  -- a straight walk from one point to the other over decoded clusters (no closed step, floor change, water, indoor ground or town hostile to profile); nil: a cluster not decoded or off the data (decodes nothing, allocates nothing)
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
slices of `Path.budget` ms (3 ms at any frame rate; 0.3.1 grew it to 8 ms at
100 fps, halving the frame rate while a search ran) and wait out combat. A
decode yields at its slice points to its very end. Once the queue is empty
the router rests: `Rest` trims the decoded graph to `Path.graphRestKB`, and
decoded clusters, the decoder's scratch and the endpoint trees stay for the
next search (a walk from nearby reads the same clusters: 0.3.1 decoded them
again for every search); after `Path.restSeconds` (60) with no search `Idle`
drops them, except the one `Path.SurfacesAt` reads (the player's floor, until
`Path.ReleaseSurfaces`). The search scratch (the abstract A*'s tables, keyed
by entrance ids, the heap and the grid trees: a finished search's or
batch's is the next one's) stays `Path.spareSeconds` (15): until 0.3.4 every
emptied queue dropped it, so a walk re-asked every few seconds grew those
tables again every time. `Path.cacheKB` and `Path.graphKB` cap them
meanwhile, all set in `API.lua`.
The maps are base64 zlib blocks decoded per cluster with `C_EncodingUtil`.
`forge nav check` holds the maps to `PACK.json` (grid build, cells, date, sizes,
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
Path Forever"); `rust/crates/forge-addontest/tests/addontest/nav-maps.rs`
trims a stand-in for his tables after every frame of one of our searches and
checks the route is unchanged.

**Updating.** The router (`Routing/`) is Polestar's code: it is edited here,
tested by `rust/crates/forge-addontest/tests/addontest/nav-router.rs` (synthetic maps with and without the
class field; format 1 against the router before classes, from git) and the
real-map tests, and no tool copies it from upstream any more; its three
files that began as his keep his copyright and the GPL notice under a header
line saying where it started. The maps are Polestar's too (Zephras Isle's
since 2026-10-16, no longer copied from his repository): `forge nav pack`
writes all three from the grid, and `forge nav check` and
`rust/crates/forge-addontest/tests/addontest/nav-maps.rs` hold them to `PACK.json`; the test also loads the
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
change to the tracked quest log. Record layouts: `rust/crates/forge-data/src/questdb.rs`;
the records stay LuaChunks text (`Core/LuaChunks.lua`) and are decoded when read, so the
loaded database costs about 1.2 MiB, not the 6.6 MiB of tables it took (#693).
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
under the higher-ranked glyph: kill > interact > collect > vendor). Spread
objective clusters (kill, loot, object) carry their spawns' spread as `radius`.
Objective spots (#1085): each objective's spread pins are grouped by
`Polestar.Regions.Of` (as the guide's spawn regions; up to 250,000 pair
checks, which Salve via Mining's 3,136 ore spots need, about 198,000; past it
the objective keeps its markers), and two objectives on the same spots share
one region. A marker rebuild only marks the regions stale: they are gathered
when the objective layer is next published on a map with areas to draw, so
with the objective markers off they cost nothing. A grouping is kept per
objective with the pin keys it was made from, so a quest log change groups
only the objectives that came; a region's area and centre pin are kept by its
spots' keys and reused. A step change or a setting only restyles.
`qol.objectiveSpots` picks the look:
`groups` (default) draws a region of `Q.GROUP_MIN` (3) or more spots as one
`hull` pin (`areaOnly`) in the accent at `qol.objectiveAreaAlpha` (0.2–1,
default 0.6; times the dim 0.6 when its marker is dimmed) and one marker at
its centre (`spots` = its spot count, the members' names as header, every
objective they serve in its tooltip) in place of its members; `icons` draws
every spot's marker and no area; `areas` draws every region as an area and no
objective marker (vendors and event points stay markers). The layer is set
with `minimapAreas` unless `icons`, so the areas follow it onto the minimap.
Over the shipped database `groups` cuts every quest's objective markers from
about 122,000 to 41,000. `qol.questMarkerSize` (0.6–1.6) scales every quest
marker on both surfaces. Markers
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
gets a 16px objective icon (14–20) 3px from the health bar the player
sees: EllesmereUI Nameplates' unit frame, Plater/ElvUI/oUF, KuiNameplates or
Threat Plates when present, else the shown child of the base plate holding
the largest status bar, else Blizzard's health bar, else the plate itself;
parented to that frame so it follows its fading and scaling. Which side is
`qol.nameplateIconSide` (#995, for another addon's icon at the bar's left
end): `left` (default) left of the bar; `right` right of it, past Blizzard's
level badge (`PlayerLevelDiffFrame` or `LevelFrame`) when shown; `above` over
the unit's `.name` when shown, else over the bar. A change re-anchors the
icons already shown. Beside the icon, on the side away from the bar (left
for `left`, right otherwise), a font string of the icon frame (`.count`)
shows the progress of the open objectives with a count above 1
(`Q.ProgressText`, by quest, joined with " · "), re-read on every
`QUESTDB_UPDATED`; hidden when none has one. Every access is guarded;
`Quests.NameplateIcon(unit)` returns the icon and `Quests.NameplateCount(unit)`
the progress shown (tests).

Settings (`qol.*`, Questing → Quests; the markers under Map → Guide & quests →
Quest markers): `questDB`, `availableQuests`,
`questLevelWindow` (0–10, 10 = any; default 5), `lowLevelQuests`,
`mapObjectives`, `objectiveSpots` (`groups` | `icons` | `areas`),
`objectiveAreaAlpha`, `turnInMarkers`, `minimapObjectives`, `questMarkerSize`,
`guideHighlight`, `guideDim`, `questTooltips`, `nameplateIcons`,
`nameplateIconSide` (`left` | `right` | `above`), `questLevels`.
The four marker layers (`availableQuests`, `mapObjectives`, `turnInMarkers`,
`minimapObjectives`) default to off (Map → Guide & quests → Quest markers);
`guideHighlight` only restyles markers those layers draw.

### Party: where each member is on the guide, and group play — Quests/Party.lua

```lua
Polestar.Party.EncodeHello(reply) / DecodeHello(text)  -- "1H|<version>" hello, "1Y|<version>" its bare answer -> "H"|"Y", version
Polestar.Party.Spoke(key) -> bool                  -- the member has spoken Polestar
Polestar.Party.EncodePos(pos) / DecodePos(text)  -- "1P|<live step>|<Polestar version>|<pack id>|<pack version>|<guide id>"
Polestar.Party.EncodeUnit(u) / DecodeUnit(text)  -- "2U|<level>|<XP %>|<class id>|<race id>|<Polestar version>" (0.3.6 and older: no version); later fields ignored
Polestar.Party.EncodeDone(ids) / DecodeDone(text)  -- "2D|<quest>,<quest>,...": quests handed in around the live step -> { [q] = true }
Polestar.Party.EncodeRest(left) / DecodeRest(text)  -- "2B|<seconds left>", "2B|*" (on, no end), "2B|0" (ended) -> seconds | true | false; later fields ignored
Polestar.Party.EncodeAt(pos, request) / DecodeAt(text)  -- "2P|<step key>|<guide id>" (where you are), "2G|" (sync request) -> at, request
Polestar.Party.EncodeAnswer(code) / DecodeAnswer(text)  -- "2A|<y|n|x|=>": accepted, declined, cannot, already there
Polestar.Party.StepKey(g, i) / StepAt(g, key)      -- a step's identity: the hash of its goals' kinds and ids, ".<n>" for the nth alike
Polestar.Party.SharedSteps(g, a, b, who) -> n       -- b's place minus a's, counting steps both you and `who` have (Engine.StepHiddenFor)
Polestar.Party.MyPos() -> { step, key, addon, pack, packVersion, guide } | nil
Polestar.Party.MyUnit() -> { level, xp, class, race, version }
Polestar.Party.MyDone() -> { q, ... }              -- quests of the steps from 20 before the live step to 5 after it you handed in, nearest first
Polestar.Party.Newer(a, b) -> bool                 -- dotted versions; a dev build compares as neither
Polestar.Party.StepLine() -> text, holding | nil   -- the guide window's party row; holding: the group waits on the step
Polestar.Party.RequestSync() -> bool               -- "Sync to my guide": the party panel's button, /polestar party sync
Polestar.Party.SyncOffer(at) -> offer | nil; SyncPrompt(name, offer) -> text  -- what accepting would do here
Polestar.Party.AcceptSync(req) / DeclineSync(req) -> bool  -- the prompt's buttons
Polestar.Party.Waiting(goal) -> { { name, cur, max }, ... } | nil  -- members the group waits for short of goal's line
Polestar.Party.HoldsQuest(q) -> bool                -- a member the group waits for has q unfinished
Polestar.Party.StepWait() -> names, ready | nil     -- the live step's wait
Polestar.Party.GoOn()                              -- "Go on without them": the live step's quests stop waiting
Polestar.Party.Lacking(q) -> { { name, unit, key, why, blocked }, ... }  -- Missing(q) gives the names
Polestar.Party.ShareFor(goal) -> names | nil        -- who a row's Share reaches; Share(q) shares
Polestar.Party.UnitInfo(unit, key) -> { level, xp, class, race }
Polestar.Party.Roster() -> rows                      -- the party panel's (UI/PartyPanel.lua)
Polestar.Party.PointAt(unit) -> bool                 -- a trip to a member (Nav.StartTrip, label "Party"), moved with them every 3 s (Nav.MoveTarget);
                                                     -- ends on arrival, "Back to the guide", or once they leave, go offline or have no place
Polestar.Party.ItemNeeds(itemID) -> { { name, unit, need }, ... }; NeedText(e)  -- UI/PartyLoot.lua
Polestar.Party.IsLive() -> bool                     -- PARTY_LIVE (on) fires when it changes
Polestar.Party.Debug() -> lines                      -- /polestar party debug: prefix, last send and result, messages heard, roster keys
Polestar.Compat.UnitFullName(unit) -> full, first | nil | false  -- "Ana Smith" on Forever, "Ana"/"Ana-OtherRealm" elsewhere
Polestar.Compat.SenderName(sender) / SenderIsUnit(sender, unit) / SenderIsMe(sender)
```

- The handshake: group play runs only with party members who also run
  Polestar. A roster read that finds someone who has not spoken Polestar
  (joining a party, login or reload in one, a new member, the settings back
  on) sends one "1H|" hello, 3-6 s later; a refused one is tried again
  10 s later (up to 5 times) and when a member's quest log changes. A member is `spoken`
  once any valid message of theirs arrives (hello, "1Y|", a snapshot, a
  position, a unit). Nothing of ours (snapshot, changes, position, unit)
  goes out before one has (`sharing()`); a hello is answered by a sharer
  with its snapshot asking theirs ("1R|"), by anyone else with "1Y|"; a
  member first heard otherwise gets our snapshot. Everything shown (party
  line, holds, arrow, lacking and Share, panel rows, loot lines, the
  one-time notice) is of spoken members only; one who leaves is forgotten at
  once, holds and all. Older versions drop "1H|"/"1Y|" as malformed.
- Names (#1018): Forever's characters carry a surname. Its UnitName gives a
  party member's as the second return (where other clients give the realm),
  the player's whole or split (UnitNameUnmodified splits it), and senders
  read "Ana Smith" with "-Realm" from another realm. The roster is keyed by
  `Compat.UnitFullName` and a sender matched by `Compat.SenderName`; one not
  found re-reads the roster, then asks the client (`Compat.SenderIsUnit`,
  UnitIsUnit with the sender as a unit id). Secret values are dropped. The
  same full name keys the Characters page (`Alts.Key`, an entry under the
  first name alone moves to it) and the instance log, and the Recorder
  scrubs it.
- Settings (Questing → Quests → Group): `party.share`, `party.show`,
  `party.waitForGroup`, `party.lootNeeds`, `party.chat` and `party.chatLoot`
  (Quests/PartyChat.lua, below, with its `party.chatEcho`,
  `party.chatHideOthers` and `party.chatOnlyNeeded`, off by default) and
  `party.panel` on by default (the panel opens by itself once a
  member is heard; closing it stores `false`),
  `party.panelPos`. A player who turned one off has `false` stored (Set
  stores what differs from the default), so it stays off. Solo, only
  `GROUP_ROSTER_UPDATE` and `GROUP_LEFT` are registered; in a party
  (`wantLive`) the addon channel, the quest log, XP and level, connections
  and zone changes, and a 5 s look at who holds the wait (sends nothing). The
  first time a member's progress is kept to show (`memberFor`: counts, a
  position, a unit) with `party.share` and `party.show` both on, chat says
  once per account (`PolestarDB.partySyncTold`) that you and your party see
  each other's progress and that Options turns it off; a player who turned
  either off is not told. The options carry `search`, more words the
  settings search reads.
- With `party.share`, the position goes out with every snapshot and, two
  seconds after `STEP_CHANGED`/`STEP_UPDATED`/`GUIDE_CHANGED`, only when it
  changed: "1P|", then "2P|" with the live step's key (`Party.StepKey`: a
  hash of its goals' kinds and ids, never text, so every client language
  agrees; a goto by its map and whole coordinates), then "2D|" (`MyDone`:
  the quests of the steps from 20 before the live step to 5 after it that
  `Compat.IsQuestCompleted`, nearest first, as many as fit 255 bytes and 40
  at most) when it changed; a snapshot makes the receiver drop the last
  "2D|", so an empty one goes out only to clear a list the party holds.
  Older clients drop "1P|" as malformed, 0.3.5 every "2P|"/"2G|"/"2A|", and
  0.3.6 "2D|". "2U|" goes out with every snapshot and, two seconds after
  `PLAYER_XP_UPDATE`/`PLAYER_LEVEL_UP`, when its text changed (a whole
  percent); version 1 decoders drop it. From 0.3.7 it ends in the sender's
  Polestar version, a field 0.3.6's DecodeUnit ignores (it reads nothing
  past the race). "2B|" (Boosted Rest, QoL/Rest) goes out two seconds after
  `QOL_REST_UPDATED` with a real change and with every snapshot while it is
  on, an end only to a party told it was on, never with `qol.boostedRest`
  off; a message of its own, so every older decoder (versions 1 and 2, and
  0.3.6) drops it. The member's row (`Party.Roster().rest`) counts it down
  from when it arrived.
- Versions: a member's Polestar version comes with their hello ("1H|",
  "1Y|"), "1P|" and "2U|". With `party.show`, one on another release than
  yours (both dotted numbers; a dev build counts as unknown) prints once
  per member and version a session "Ana is on Polestar 0.3.6: your guides
  can differ." (`noticeVersion`), ending in "A newer version is out." when
  theirs is newer; a member with a newer version of a guide pack you have
  prints once a session per pack (`noticePack`).
- With `party.show`, a member's position and unit are kept beside their
  counts. The guide window's party row (`GF.party`, over the XP row, not in
  compact mode) reads `StepLine`: "Ana: 3 steps ahead", "Ben: 1 step
  behind", "Cy: on this step" for members on your guide whose step key is in
  your copy of it (any pack version) or, from a member who sends no "2P|"
  (0.3.5), whose step number is on the same pack version; the count takes
  only steps both of you have (`Party.SharedSteps`: neither a class, race or
  hearth-only step of one of you, `Engine.StepHiddenFor` with the member's
  class and race), so a Warrior on his Warrior-only step and a Mage on the
  next step are on the same step. "Dee: other guide" on another; then the
  wait ("Waiting on Ana",
  "Everyone's ready"), or with nobody holding the step "Still at it: Ana" (a
  hint). A click toggles the party panel; while the step is held, "Go on
  without them" sits at its end.
- Sync to my guide (`Party.RequestSync`: the party panel's header button,
  `/polestar party sync`): "2G|<step key>|<guide id>" to the party, once per
  30 s; answers ("2A|") from the members asked count for 5 minutes and are
  said in chat. A member's request, once per 30 s per member and never
  accepted for the player, opens a StaticPopup (`POLESTAR_PARTY_SYNC`) from
  `Party.SyncOffer`: the guide to switch to when it is not the active one,
  their step, the turn-ins the move passes that you have not done ("Ana is
  past these"), and those you did already that the guide passes there. One
  you cannot follow (no such guide, not for your character, a copy without
  the step) answers "x" and says so in chat; one you are on already answers
  "=" with no prompt. Accept (`Party.AcceptSync`) opens the guide
  (`Engine.OpenTab`) and calls `Engine.SkipUpTo(step)`: every open,
  applicable, unskipped step from the live step up to it skipped, ticks and
  earlier skips untouched, stored with the first one's skip so the window's
  undo (`PLAYER_SKIPPED_STEP`) takes the whole sync back; nothing moves
  back when you are past their step. Decline answers "n" and changes
  nothing.
- The wait (`party.waitForGroup`): the members the group waits for are
  those in your zone (`Compat.GetUnitZone`; unknown counts as here) and
  those offline under 2 minutes (kept apart from `Members`). The Engine asks
  `Party.Waiting` for the live step only (`computeCurrent`: a done step that
  `Own.partyHold` holds stays live), refuses a held quest's turn-in to
  Automation (`Own.wantsFrom`), and with every goal of the step done but held
  turn-ins aims at the nearest objective a member still needs
  (`Own.partyAim`, `Own.nearestField`, label "For Ana: ..."). It
  re-evaluates on `PARTY_PROGRESS`.
- Goal rows (`Party.Line`): "Ana 5/8", "Ben done", on a collect "Ana still
  needs 2 Boar Ribs", done for you "Waiting on Ana: 3/8 Boar Ribs"; on a
  turn-in ready for you "Waiting on Ana" or "Everyone's ready"; on a quest
  you have, "Not on this quest: Ben (level 8, needs 10)" with the reason
  when known: the game's answer to a share (`ERR_QUEST_PUSH_*_S` on
  `CHAT_MSG_SYSTEM`, read 10 s after `Party.Share`), else the member's
  "2D|" ("already done"), else the quest database's class and race masks
  and minimum level against the member's (`UnitClass`/`UnitRace`/`UnitLevel`,
  else "2U|"). A member whose class or race rules the quest out (either
  source) is left off the line: their guide never has it. The row's Share button
  (`r.Share`, once per card) shows for members with no reason against
  (`Party.ShareFor`), through `Compat.ShareQuest` (`C_QuestLog.SetSelectedQuest`,
  `QuestLogPushQuest`, after `IsPushableQuest` when the client has it).
- The party panel (UI/PartyPanel.lua, `Maps.CompactFrame` at
  `party.panelPos`): a row per party member who has spoken Polestar, from
  `Party.Roster`; opens by itself with `party.panel` (on by default) while
  `Party.IsLive()` and there is such a member, hidden with the guide and in
  combat under `ui.combat` "hide". The party line's click and `/polestar
  party` close an open panel (`party.panel` false, kept) or open a closed
  one, and say in chat why it cannot show yet (sync off, no party, guide
  hidden, nobody heard); `/polestar party debug` prints `Party.Debug()`.
  It repaints on `PARTY_PROGRESS` and on `PARTY_PANEL`, which a "2U|" that
  moves only the member's XP percent fires instead (the same 0.5 s delay):
  the XP shows only here, so the guide window and the engine skip that
  update; a "2U|" that changes nothing fires neither.
- Loot (UI/PartyLoot.lua, `party.lootNeeds`): on `LOOT_OPENED` and
  `START_LOOT_ROLL`, a line per item a member's counts are short of while
  yours are not (the item's log line from the active guide's collect goals,
  else the quest database's objectives when they number as the member's
  counts), under the loot window.
- A member on a newer Polestar, or a newer version of a guide pack you have,
  is said once a session each in chat; the Polestar line is left out when
  the update card has said that version is out, or will this session
  (`Update.Covers`). Every member's Polestar version (the hello's, `1P|`'s)
  goes to `Update.NotePeer` ("Update notices", under UI).

### Party chat: quest progress said in the party — Quests/PartyChat.lua

The one part of group play every party member sees, Polestar or not: plain
chat lines. Nothing of Party.lua's addon messages reaches chat; this file
asks Party.lua only whether every member runs Polestar.

- Lines, each starting with the marker `L["{rt1} Polestar: "]` (frFR
  `"{rt1} Polestar : "`, ruRU `"{звезда} Polestar: "`: Forever's ruRU
  GlobalStrings list `RAID_TARGET_1` "Звезда" among the chat's star tags):
  `{rt1}` is the chat token every client draws as the Star raid icon.
  - `LC("party chat", "%s %s")` with the quest's link and its objectives
    finished within 3 s, each as "Plagued Hide 5/5" (`Compat.ObjectiveLabel`
    of the log's text, then the counts), joined by `LC("party chat", ", ")`:
    `[Plagued Lands] Plagued Hide 5/5, Rabid Wolves 8/8`.
  - `L["%s is ready to turn in"]` with the quest's link.
  - `L["looted %s, which starts %s"]` with the item's link from the client's
    `CHAT_MSG_LOOT` line for your loot (`LOOT_ITEM_SELF_MULTIPLE`,
    `LOOT_ITEM_SELF` made into patterns) and the quest's link: the first
    quest `QuestDB.StartedBy(itemID)` names (the start items of the quest
    database, as the item tooltip's "Starts a quest" line) that is neither
    done nor in the log, once a session per quest. Nothing while the quest
    database is not loaded.
  The quest link is the client's `GetQuestLink(questID)` (what a shift-click
  on the quest puts in chat, Mainline QuestMapFrame; for the loot line asked
  0.5 s after `Compat.RequestQuest`), else the title as plain text. Square
  brackets go out only inside links (the server turns plain ones into
  parentheses), so titles and objective texts lose theirs. Nothing goes out
  when no title can be read, nor for an objective whose text is a secret
  value. A line stays within 255 bytes: the objective list keeps the whole
  objectives that fit and ends in ", …" (a single objective too long is cut
  on a UTF-8 boundary, then "…"); a ready or loot line that would not fit is
  dropped. Sent with `C_ChatInfo.SendChatMessage` (the bare
  `SendChatMessage` is only Blizzard_DeprecatedChatInfo's fallback) as
  `INSTANCE_CHAT` in an instance group
  (`IsInGroup(LE_PARTY_CATEGORY_INSTANCE)`), else `PARTY`; never solo or in
  a raid.
- Settings `party.chat` (objectives and ready quests) and `party.chatLoot`
  (the loot line), on by default. With either on, `GROUP_ROSTER_UPDATE` and
  `GROUP_LEFT` are registered; in a party also, for `party.chat`,
  `QUEST_LOG_UPDATE` (one read 0.5 s after a burst) and
  `PLAYER_ENTERING_WORLD`, and for `party.chatLoot` `CHAT_MSG_LOOT`. Leaving
  the party drops what it knew and any line waiting. `party.chatOnlyNeeded`
  (off): while `Party.AllRunPolestar()` (every member online has spoken
  Polestar; never with sharing and showing both off, which hear nobody) the
  lines waiting are dropped instead of sent.
- A read walks the log (`C_QuestLog.GetInfo`, `Compat.GetQuestObjectives`)
  and keeps per quest which objectives are `finished` (the client's verdict:
  Forever can report 1/1 on one not done yet) and whether
  `Compat.IsQuestReadyForTurnIn`. A quest first seen is learned, never said
  (taken with the items already in the bags, or seen at login). Both are
  sticky while the quest stays in the log, so a count that drops and comes
  back says nothing; a quest gone from the log (`IsOnQuest` false) is
  forgotten and starts over if taken again. Objectives newly finished wait
  3 s from the first for more of the same quest, then go out as one line;
  the read in which the quest becomes ready gives the ready line alone and
  drops the objectives still waiting.
- For 5 s after it starts listening (login, reload, joining a party, the
  setting turned on) and after every `PLAYER_ENTERING_WORLD`, reads only
  learn: the client fills counts in after login, and a loading screen can
  read them as 0 for a moment.
- Lines go out 1.5 s apart, at most 5 waiting. While
  `C_ChatInfo.InChatMessagingLockdown()` (the client's chat restrictions in
  encounters) a line waits, looked at every 2 s, and one older than 120 s is
  dropped. The first line sent prints once per account
  (`PolestarDB.partyChatTold`) where to change it.
- A message filter (`ChatFrameUtil.AddMessageEventFilter`, else
  `ChatFrame_AddMessageEventFilter`) on `CHAT_MSG_PARTY`,
  `CHAT_MSG_PARTY_LEADER`, `CHAT_MSG_INSTANCE_CHAT` and
  `CHAT_MSG_INSTANCE_CHAT_LEADER` knows a Polestar line by any language's
  marker (`PartyChat.MarkerToken`: `{rt1}` or `{звезда}`, then
  " Polestar: " or " Polestar : ") and shows it with Polestar's logo
  (`Media/UI/logo`, `|T…:0|t`) in place of the token. Your own lines are
  dropped unless `party.chatEcho` is on; with `party.chatHideOthers` on,
  other players' are dropped too. Every other line passes untouched.

## Gear — item stats, stat weights, upgrade tooltips, reward picks

Gear's part in quest reward choices: QoL, "Quest reward marks".

### Bag upgrade arrows — Gear/Bags.lua

```lua
Polestar.Gear.Bags.IsUpgrade(link) -> bool   -- what an arrow shows: Gear.IsUpgrade, with gear advice and gear.bagArrows on
Polestar.Gear.Bags.Redraw()                  -- repaint the shown bags; GEAR_UPDATED schedules it, at most every 0.2 s
```

- **The client's bags.** Each container frame's `UpdateItems` (Mainline
  `ContainerFrame.lua`, which Forever loads) is post-hooked on the frame
  itself: `ContainerFrameContainer.ContainerFrames` and
  `ContainerFrameCombinedBags`. The mixin's functions are copied onto each
  frame as it is made, so a hook on `ContainerFrameMixin` would miss them.
  The arrow (`qol-upgrade`, success, 20px) is a texture on the item button,
  top-left where the client's own unused `UpgradeIcon` sits, at OVERLAY
  sublevel 3: over the icon overlays, under the search overlay, so a bag
  search dims it with the icon. Textures only (the gamepad interface hooks
  `CreateFrame`, not `CreateTexture`), and nothing is written into the
  button's table: Bags.lua keeps the arrows by button. A closed bag is
  repainted by the client's own update as it opens.
- **Baganator.** A corner widget (`Baganator.API.RegisterCornerWidget`, id
  `polestar_upgrade`, top-left at priority 1, the way Baganator shows Pawn's
  arrow), registered as Bags.lua loads or on Baganator's `ADDON_LOADED`. New
  verdicts ask it for an item-widget refresh (`RequestItemButtonsRefresh`).
  Baganator also shows other characters' bags; the arrow there is this
  character's verdict, as the tooltip line is.
- Other bag addons draw their own buttons and get no arrow; the tooltip line
  still shows on them.

## Maps — the world map

Each feature is a setting on the Map page (Rares & travel, Zones), and none of
them makes a frame or loads data until it's on. The icon layers (dungeon
entrances, flight masters `maps.taxiPins`, docks `maps.dockPins`, inns
`maps.innPins`, NPC services `maps.servicePins`, and `maps.travelMinimap` for
the minimap) default to off. The
flight timer and the instance tracker are set under Quality of Life.

- NPC services (`maps.servicePins`, off; `Maps/Services.lua`): one pin per
  friendly NPC spawn, with all its services in the tooltip and click-to-navigate.
  The layer's `minMapType = UIMapType.Zone` hides it on world and continent
  maps, while keeping zone, city and minimap icons. Vendors use the native
  Banker tracking bag; bankers use the native treasure chest icon.
  `Maps/ServiceClusters.lua` groups service points belonging to the same
  detail map, only while an outdoor region in the existing zone-level catalog
  is viewed. Map parentage and the native click lookup `GetMapInfoAtPosition`,
  rather than `IsCityMap`, cover cities and other areas with a detail map,
  including cities registered as siblings of their region. The catalog keeps
  detail views individual even when opened directly, without visiting a region.
  Groups use up to three native icons; totals stay in the tooltip, with no map badge. The area's own map,
  services outside detail areas and minimap pins stay individual. Clicking a
  group opens the existing widget menu: category, then NPCs with their original
  coordinates (ten per page). Choosing an NPC sets a waypoint at its exact
  spawn; it does not change the viewed map. Native clicks on the city/area
  still open its detail map. Map/zoom/filter changes close the menu, while
  unrelated layer updates leave it open. The map's right click passes through.
  `maps.serviceFilters` selects the 11 categories (class trainers and mailboxes
  on, the rest opt-in); flight masters and inns are not among them, and an NPC
  with either role is left to the travel layers (`maps.taxiPins`,
  `maps.innPins`) so nothing is drawn twice. `maps.serviceMinimap` opts
  into minimap icons. Both tracking menus have a Polestar service submenu;
  the same settings live under Map, Rares & travel, NPC services. Class trainers
  are restricted to the character's class. A repair vendor has one icon, using
  the first enabled category it offers, and remains a vendor when repair is off.
  `Maps/ServiceData.lua` reads the bundled Codex role index and mailbox objects,
  separately from NPC IDs. QuestieDB facts are imported only at build time;
  no external database addon is needed during play. The data importer keeps
  mailbox roles and friendly sides from faction templates; faction ID zero
  means both sides, matching Questie's mailbox lists. Unknown nonzero templates
  and templates hostile to both sides are omitted. The Codex retains the
  titles of service NPCs only (no other NPC carries one, to keep the pack
  small) and every service/mailbox spawn (`pts` and `more`), without
  clustering or caps. English trainer titles supplement class roles; displayed
  names remain localized. Repeated mailbox
  observations within 10 world yards share one icon at an original point;
  the other physical mailboxes keep their own pins. Codex spawn frame tags
  are retained for coordinate projection and navigation. Optional escaped
  `t<title>` NPC and `m<faction>` mailbox tails extend the packed records;
  older readers skip these comma-free fields, and older packs stay readable.
  Reads run in batches of 100 outside combat, the first time the world map
  opens with the layer on (at once when its minimap icons are on), never at
  login, so the Codex stays unloaded until then; filters reuse the records
  (slim copies of the friendly ones: id, name, title, side, roles, spawns),
  and a Codex/name-pack load invalidates them. Missing data
  produces an explanatory message and is retried when the dependency loads.

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
- Minimap button (`maps.minimapButton`, on by default for every account;
  turning it off stores `false`, so it stays off; `undoMinimapButtonKept` in
  `Maps/Maps.lua` clears, once, the `false` the 0.3.6 test builds stored with
  `PolestarDB.minimapButtonKept`; `Maps/MinimapButton.lua`):
  click hides or shows all of Polestar (`Polestar.ToggleHidden`, see "Hiding
  Polestar"; while hidden its icon is dimmed, `Maps.PaintHidden`, and its
  tooltip, `Maps.ButtonTip`, says a click shows it), right-click opens
  `Maps.ShowMenu` (Guide window, ticked while the window shows, `GuideShown()`,
  fires `TOGGLE_FRAME`; Hide arrow or Show arrow, `nav.arrow`; Hide Polestar
  or Show Polestar; Keep the arrow when hidden, ticked when on; then Guides, Lookup,
  Options, Report a problem, which bring a hidden Polestar back and fire the
  existing event), a drag moves it
  around the minimap's edge and saves `maps.minimapButtonAngle` (degrees, 0 =
  east). A square minimap (`GetMinimapShape`) puts it on the square's edge,
  and a resized one (`OnSizeChanged`) moves it to the new edge.
  Minimap button collectors gather it like any addon's (a `Button` named
  `PolestarMinimapButton`, a `Minimap` child, its icon at `.Icon`). Once one
  has reparented it or anchored it elsewhere (`ours()`: parent and last
  anchor no longer what `place()` set), neither a drag nor a resize moves
  it back to the edge; clicks work as before.
  No frame exists until the setting is first on. The addon
  compartment (clients with `AddonCompartmentFrame`) gets the same through
  the .toc's `AddonCompartmentFunc*` globals (`Polestar_OnAddonCompartment*`):
  click hides or shows Polestar, right-click opens the menu, hover the tooltip.
- Zone level ranges (`maps.zoneLevels`): labels on continent maps, and the
  hovered zone's range in the info bar. The ranges come from `forge data maps build`
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

### Clickable objectives

`qol.guideNameTarget` is off by default. Enabling it extends objective-row
navigation clicks to target the objective's NPC. Marking uses the existing
`qol.markTarget`, `qol.markMob` and `qol.markNpc` settings, including their
shared icon cycle. Opt-in is a product decision:
existing navigation clicks should not unexpectedly replace the player's
target. The default can be changed independently of the targeting code.
`QoL.Buttons.GuideNameMacro` resolves one NPC belonging to that
goal, never a collect item's name or another objective, then delegates to
`Buttons.TargetMacro({ name }, 1, Buttons.MarkLine(kind))`. Kill and collect
goals use the mob icon; NPC verbs and headings use the NPC icon. The shared
name validation and literal macro commands are the same as the Target
button's, and the result must fit within 255 bytes. It clears the previous
target and dead matches before optional marking. For a collect with two
named sources, it uses the primary source; the hover tooltip identifies
that NPC. The client determines
targeting range and marker permission. An exact-name search can select a
nearer corpse instead of a living namesake; clearing that corpse does not
make the macro search farther.

The command sequence is checked against Forever 1.60.1 (70450):
[exact targeting and clearing](https://github.com/Gethe/wow-ui-source/blob/172a387e3ab85b26e6640d3058d5ec1e6ccd4c63/Interface/AddOns/Blizzard_ChatFrameBase/Shared/SlashCommands.lua#L489),
and [marker commands](https://github.com/Gethe/wow-ui-source/blob/172a387e3ab85b26e6640d3058d5ec1e6ccd4c63/Interface/AddOns/Blizzard_ChatFrameBase/Shared/SlashCommands.lua#L1451).

`UI/NameTargets.lua` pools secure buttons over objective rows (and the NPC
heading's text), independently of the guide's frame tree. Absolute UIParent
positions follow the guide's layout, animation and dragging. A secure
visibility driver hides the buttons
in combat; no protected attributes or geometry change under lockdown, and a
combat reload defers button creation. The normal guide remains interactive.
After combat the buttons use the latest displayed goals. Left clicks retain
arrow navigation; the quest's right-click menu, non-quest completion and
adjacent controls keep working.
A left-click that finds no living target reports the NPC name through
`UIErrorsFrame` (chat fallback), before navigation can reuse the button.
The overlay sets `type1`, so a Shift-, Ctrl- or Alt-click runs no macro: it
is only the ordinary row click, with no report and no mark-cycle advance.

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

### Gossip the step asks for — QoL/Gossip

`qol.stepGossip` (on; Questing → Quests → Faster questing), on `GOSSIP_SHOW` after the flight and bind
helpers, not with Shift held nor while the NPC has quest business (`QoL.HasQuestBusiness`). At the NPC
(`Compat.GetNpcID("npc")`, the goal's `npc` or a candidate's) of an open goal of the live step
(`Engine.GetLiveStep`, never a step looked at): a goal's `gossip` (`talk`, `vendor`, `train`) picks the
option with that `gossipOptionID`; else a `buy` or `vendor` goal picks the option whose icon is 132060
(VendorGossipIcon), a `train` goal 132058 (TrainerGossipIcon), never by text (`QoL.SelectGossip`). One
pick per gossip window (until `GOSSIP_CLOSED`). The talk goal then counts from the pick (`Own.talkAct`).
`Gossip.Wanted(options, npc)` is the pure choice.

### Binding at the guide's inn — QoL, asks the Engine

`QoL/Bind.lua`, behind `qol.autoBind` (Quality of Life → Travel →
Hearthstone; off by default, as it binds for the player). It does one thing:
while the active tab's current step has an open `sethome` goal, it binds the
Hearthstone at the innkeeper that goal names, and nowhere else.

```lua
Polestar.QoL.Bind.Wanted(npc) -> bool        -- an open sethome goal of the current step binds at npc (Engine.IsSethomeInnkeeper), and the character is not bound at that innkeeper's inn (Nav.BoundInn)
Polestar.QoL.Bind.BinderOption(options) -> option | nil  -- the gossip's bind option: icon or overrideIconID 132052 (BinderGossipIcon)
Polestar.QoL.Bind.OnGossip() -> bool         -- GOSSIP_SHOW (Toggles.lua: after the flight helper, before skipGossip): picked the bind option
```

- **Gossip.** At such an innkeeper, the bind option is picked by its icon,
  never its text (`QoL.SelectGossip`: by `gossipOptionID`, else
  `orderIndex`). Not with Shift held, and not while the gossip has a quest to
  pick up or hand in (`QoL.HasQuestBusiness`, which the flight helper shares):
  the quest automation goes first and the gossip shows again after it.
- **Confirmation.** Picking the option fires `CONFIRM_BINDER(areaName)`,
  registered only while the setting is on (`QoL.WhileOn`). While the
  innkeeper (`"npc"`, else the last gossip's NPC: the client may have closed
  the gossip) is still `Wanted`, whether the helper or the player picked the
  option, and Shift was held neither at that gossip nor now, it answers on
  the next frame (unless the interaction ended meanwhile:
  `IsValidNPCInteraction(Binder)`, the popup's own test) as the popup's
  Accept does
  (`C_PlayerInteractionManager.ConfirmationInteraction(Enum.PlayerInteractionType.Binder)`,
  then `ClearInteraction(Binder)`; Blizzard_StaticPopup_Game
  GameDialogDefs.lua) and closes the "CONFIRM_BINDER" popup one frame later
  (`QoL.ClosePopup`, as for summons; left to the player under the gamepad
  interface style). Answered inside the event, Forever's client drops the
  first bind at an innkeeper: the popup goes, the Hearthstone stays, and only
  a second visit binds. "Bound your Hearthstone to <area>." waits for the
  game's `HEARTHSTONE_BOUND` within 5 seconds of the answer. The Engine
  completes the goal from the bind as it does for one by hand
  (`HEARTHSTONE_BOUND`).

### The step key on the flight map — QoL/Flight, QoL/Buttons

```lua
Polestar.QoL.Flight.TakeSlot() -> slot, cost | nil   -- the marked node the step key flies to: map open, the window on the live step, the node reachable (TaxiNodeGetType), cost from TaxiNodeCost
Polestar.QoL.Flight.Take() -> bool                   -- the press: TakeTaxiNode(slot) when GetMoney covers the cost, else prints what it costs
Polestar.QoL.Flight.AutoTake() -> bool               -- qol.flightAutoTake: Take() as the map opens, once per open
```

- By default the flight is only taken by a press of the player's: while the
  flight map is open and its node is marked (`qol.flightHighlight`), the
  step key (`PolestarStepButton`) has no secure action and its PostClick
  takes the marked flight. Looking at another step than the live one, an
  unreachable node or no mark leaves the key to the step's own action.
- The one exception is `qol.flightAutoTake` (Travel → Flight masters, off
  by default, #1621, a child of `qol.flightHighlight`): on `TAXIMAP_OPENED`,
  after the mark, `Flight.AutoTake` presses for the player once per open
  (`Flight.Take`: the marked node, the live step, reachable, the cost
  covered, else the price printed). Shift held now or when a flight
  master's gossip opened leaves the map to the player; a replan while it is
  open never flies.
- `Flight.Highlight` fires `FLIGHT_MARK_CHANGED(slot | nil)` after every
  mark (the map opening, a replan while it is open) and on
  `TAXIMAP_CLOSED`; the buttons refresh on it.

### The step key's interact stage — QoL/Buttons

```lua
Polestar.QoL.Buttons.InteractStage(view?, raw?) -> "interact" | "accept" | "continue" | "complete" | nil
```

Behind `qol.stepInteract` (Questing → Buttons, off by default) and the
client's interact binding (`BINDING_NAME_INTERACTTARGET`), never with the
gamepad interface, and only while the window shows the live step. In a quest
window (`QUEST_DETAIL`, `QUEST_PROGRESS`, `QUEST_COMPLETE` until
`QUEST_FINISHED`, the quest by `GetQuestID`) of the live step's open accept
or turn-in, the stage is that window's button: accept, continue, or complete
(not while several rewards are on offer: the player picks). Else, while the
target is the live step's NPC (an open accept, turn-in, talk, train, vendor,
buy, sethome, getfp or learn goal's, by NPC id or name, not attackable, not a
player), "interact"; on the corpse of one of the step's mobs (a name the
target button would use), "interact" too, which loots. The keys bound to the
step key (`GetBindingKey("CLICK PolestarStepButton:LeftButton")`) are bound
over, owned by the step button: `SetOverrideBinding(..., "INTERACTTARGET")`
or `SetOverrideBindingClick` on `QuestFrameAcceptButton`,
`QuestFrameCompleteButton` or `QuestFrameCompleteQuestButton`; with no stage
`ClearOverrideBindings` gives the keys back. Every change goes through
`QoL.Secure`, so in a fight the keys keep what they did until it ends
(`PLAYER_REGEN_ENABLED` re-reads the stage: a mob killed in a fight is looted
by the press after it). Re-read on target, quest-window, binding and step
changes and `LOOT_CLOSED`.

### Quick Keybind Mode — QoL/QuickBind, QoL/Buttons, Nav/Prompts

```lua
Polestar.QoL.QuickBind.Add(button, { force?, enabled?, wanted?, icon? })
Polestar.QoL.QuickBind.Hover(button) -> true when the mode took the hover
Polestar.QoL.QuickBind.Active() -> bool
```

The game's Quick Keybind Mode (`QuickKeybindFrame`, Blizzard_QuickKeybind;
opened from Options > Keybindings or an action bar addon's `/kb`) binds a key
to the button under the cursor. The game's own action buttons join it through
`QuickKeybindButtonTemplateMixin`, called from secure code; addon code calling
that mixin starts the window's `KeybindListener` tainted (its `ProcessInput`
runs `RunBinding("SCREENSHOT")`, protected). So Polestar's buttons join the
mode with code of their own, on the same signals and the same binding rules:
`EventRegistry` callbacks `QuickKeybindFrame.QuickKeybindModeEnabled` /
`...Disabled` open and close it; each registered button wears the mode's
highlight (atlas `UI-HUD-ActionBar-IconFrame-Mouseover`, 0.5 idle, 1
hovered, as `DoModeChange` and `QuickKeybindButtonOnEnter` set it; an accent
wash without the atlas). Hovering one (`Hover`, first thing in the button's
`OnEnter`, which then skips its own tooltip) lays a plain frame
(FULLSCREEN_DIALOG, above the window's DIALOG) over it that reads the
keyboard, mouse buttons and wheel, and shows `QuickKeybindTooltip` as the
mixin does (`GetBindingName`, `GetBindingKeyForAction`, `ESCAPE_TO_UNBIND` /
`NOT_BOUND` + `PRESS_KEY_TO_BIND`). A key there follows `ProcessInput`:
`GetConvertedKeyOrButton`, `IsKeyPressIgnoredForBinding` (a bare modifier),
`CreateKeyChordStringUsingMetaKeyState`, the action's keys cleared, the key
taken from what it ran (`KEY_UNBOUND_ERROR` / `PRIMARY_KEY_UNBOUND_ERROR`
in the window's line when that action is left without it), the new key bound
first and the old second key after it (`KEY_BOUND`); all in the action's
`C_KeyBindings.GetBindingContextForAction` context. Escape clears the first
key (`ClearActionPrimaryBinding`); left and right clicks bind nothing
(`QuickKeybindButtonOnClick`); the screenshot key takes one (`Screenshot()`).
Nothing saves: the window's Okay runs `SaveBindings(GetCurrentBindingSet())`
(its character-specific box picks the set), Cancel `LoadBindings`. The frame
consumes what it reads and never runs in a fight: `PLAYER_REGEN_DISABLED`
hides it.

`force` buttons (the quest item, Hearthstone, Target, rare and bag buttons;
each only while its option is on, `enabled`, and never while Polestar is
hidden, see "Hiding Polestar") show while the window is open
even when the guide hides them (`wanted`: a secure `type` attribute, the bag
button's `junk`), at 0.45 alpha, with `icon()` standing in for an item icon
and the binding's name as the label. A 0.2 s check while the window is open
re-shows one the guide hides and gives one the guide shows its own look
back (the label only while it is still the binding's name). Closing restores
the labels and hides those buttons through `QoL.Secure` (a fight holds
them, dimmed, until it ends). The travel button joins unforced (it is made
for a cast leg and bindable while it shows). The step key has no button on
screen; Options > Keybindings binds it.

### Breath warning — QoL/Breath

Behind `qol.breathWarning` (off by default; Quality of Life → Travel →
Death), registered only while on (`QoL.WhileOn`): `MIRROR_TIMER_START` for
`"BREATH"` running down (scale below 0) starts a 0.25 s ticker reading
`GetMirrorTimerProgress("BREATH")`; with 10 seconds left, and again with 4,
it plays `SOUNDKIT.RAID_WARNING`, flashes the taskbar (`FlashClientIcon`) and
shows a red edge round the screen that pulses (still under
`ui.reduceMotion`). Breath filling back up says nothing; `MIRROR_TIMER_STOP`
or the setting turned off clears it.

### A death in a dungeon — QoL/Death

At `PLAYER_DEAD` inside a dungeon or raid (`Compat.IsInInstance` "party" or
"raid"), the instance's map ID (`Compat.GetInstanceMapID`, GetInstanceInfo's
eighth value) is kept per character (`QoL.State().diedIn`) until the
character is alive again. Released outside it, the client answers for the
corpse on no map, so the death helper stands the instance's entrance in for
the corpse (`Death.EntranceOf(map)`: the Codex instance record with that
`map`, read while the Codex is loaded or Lookup is on, found once per
instance): the run is weighed against the Spirit Healer as for a corpse, the
arrow and the pin read "<dungeon> (your corpse is inside)" and the note "Run
back to <dungeon>, your corpse is inside: …".

### Quest-starting loot on the item button — QoL/QuestLoot

```lua
Polestar.QoL.QuestLoot.Current() -> itemID, questID | nil   -- the oldest starter waiting; nil with qol.questLoot off
Polestar.QoL.QuestLoot.Used(itemID)                        -- clicked on the button: passed over while it stays in the bags
Polestar.QoL.QuestLoot.Scan()                              -- read the bags now; fires QUEST_LOOT_CHANGED(itemID | nil) on a change
```

Behind `qol.questLoot` (on by default; Questing → Buttons → Action buttons,
under the quest item button, and on Quality of Life). A bag slot holds a
starter when the client says its item begins a quest that is not in the log
(`C_Container.GetContainerItemQuestInfo`: `questID`, `isActive`;
`QoL.Client.SlotStartsQuest`), or else the quest database names the quests
the item starts (`QuestDB.StartedBy`), and `QuestDB.CheckAvailable` (with
`lowLevel`) says this character can take that quest now: faction, race,
class, level, not done, not in the log, prerequisites. Race and class are
only known there, so `questLoot` is one of the settings that load the quest
database (`QuestDB.IsWanted`), and with it not loaded nothing is offered. An
item whose minimum level (`GetItemInfo`) is above the character's is passed
over. Scans run on the next frame after `BAG_UPDATE_DELAYED`,
`QUEST_ACCEPTED`, `QUEST_REMOVED`, `QUEST_TURNED_IN`, `PLAYER_LEVEL_UP`
(registered only while on, `QoL.WhileOn`) and `QUESTDB_LOADED`. Per
character (`QoL.State().questLoot`): `seen` numbers each starter the first
time a scan finds it, in bag order, and the lowest unread number is
`Current`; `used` holds the ones clicked on the button. Both drop an item once
it leaves the bags (`seen` also once its quest can no longer be taken).

The quest item button (QoL/Buttons `refresh`) shows the step's item
(`ChooseQuestItem`) first and `QuestLoot.Current()` only when that gives
none. A starter on the button glows: the theme's soft glow in the accent
behind it, pulsing unless `ui.reduceMotion`. The glow follows the item the
button holds (a texture, so it may change in combat), while the item itself
changes through `QoL.Secure` as before. A release on the button with a
starter on it (`PostClick`, not mid-drag) marks it used, so the next one
takes its place; the tooltip adds "You can take the quest this item starts.
Click to read it."

### Dungeon quests only — QoL/InstanceTrack

```lua
Polestar.QoL.InstanceTrack.Update()   -- read where the character is and apply (next frame after the events)
Polestar.QoL.InstanceTrack.Saved()    -- { key, watched = { questID, ... } } kept from before the instance, or nil
Polestar.Dungeons.ForMap(mapID) -> key | nil
Polestar.QuestDB.SetTracked(set | nil) ; Polestar.QuestDB.Tracked()
```

Behind `qol.instanceTrack` (on by default; Questing → Quests → Tooltips and
quest log, and on Quality of Life). Inside a dungeon or raid
(`Compat.IsInInstance` "party" or "raid") whose instance map
(`Compat.GetInstanceMapID`) a Dungeons summary carries (`Dungeons.ForMap`),
the instance's quests are its journal page's (`Dungeons.Quests(key)`). On
the way in, the game's watch list (`C_QuestLog.GetNumQuestWatches`,
`GetQuestIDForQuestWatchIndex`) is kept per character
(`QoL.State().instanceTrack`), every other quest's watch goes
(`C_QuestLog.RemoveQuestWatch`) and the instance's quests in the log are
watched (`C_QuestLog.AddQuestWatch`), once per instance and session: a
quest watched by hand inside stays. Polestar's quest markers follow
(`QuestDB.SetTracked(set)`: Quests/Tracker.lua builds objective and turn-in
markers for those quests only; available-quest markers, tooltips and
nameplates are untouched). Outside an instance, in a battleground, or with
the setting turned off, the kept list comes back exactly: every watch goes,
then the kept quests still in the log are watched again in their order, and
the record is cleared. The record is SavedVariables, so a /reload inside
keeps it and leaving still restores it; the restore waits until the quest
log has loaded (`C_QuestLog.GetNumQuestLogEntries` above 0) when the list
isn't empty. Inside an instance not named yet (the Codex refused in combat,
a hidden map) nothing changes; `PLAYER_REGEN_ENABLED` and `QUEST_LOG_UPDATE`
retry. An instance whose page lists no quests is left alone too. Events:
`PLAYER_ENTERING_WORLD`, `ZONE_CHANGED_NEW_AREA` (while on),
login, and the `qol.instanceTrack` and `dungeons.enabled` settings.

### Guide level on the XP bar — QoL/XPMark

```lua
Polestar.QoL.XPMark.Label(level, target, frac?) -> text | nil   -- pure: "Guide: 11" (the next level), "Guide: 14 (4 levels)", "Guide: 40% of this level", "Guide: 12 (40%)"; nil when target < level, or target = level without frac
Polestar.QoL.XPMark.Refresh()                            -- show, move or hide the mark now
Polestar.QoL.XPMark.frame                                -- the mark, once made
```

- **Target** (`qol.xpTargetMark`, on by default; Quality of Life >
  Trackers > Experience): `Engine.LevelTarget(level)`, the level the guide
  holds you to before it moves on. A whole level, or a point inside a later
  level, is the end of this level's bar: a 2px accent tick at the bar's
  right edge, standing 2px above and below it, with the label left of it in
  the accent colour (outlined `small` text). A point inside this level
  (`level 12.4` while level 12) moves the tick to that share of the bar,
  and again when the bar resizes. Nothing when the option is off, no guide
  is open, no `level` goal lies ahead, or you are at the maximum level.
- **The game's bar is only read.** The experience bar is the one of
  `StatusTrackingBarManager.barContainers` whose
  `bars[StatusTrackingBarInfo.BarsEnum.Experience]` is shown
  (Blizzard_StatusTrackingBar). The mark is Polestar's own frame made under
  that bar through `CreateFrameUnder`, spanning its `StatusBar` one level
  above its `OverlayFrame` (MEDIUM strata, like the bar's own text), so it
  fades, hides and resizes with the bar and its gamepad width. It takes no
  mouse: the bar's tooltip stays. No scripts, methods or hooks on the bar;
  no bar shown (another addon replaced or hid it, the maximum level): no
  mark, and no error. A bar that is shown but not visible (a whole-UI addon
  parents the game's bars to a hidden frame) counts as none: the refresh
  stops before `Engine.LevelTarget`, so an XP gain scans nothing for it.
- **Updates**, coalesced to the next frame (after the game's bar and the
  engine took the same event): `PLAYER_XP_UPDATE` and
  `PLAYER_ENTERING_WORLD` while the option is on (`QoL.WhileOn`),
  `PLAYER_LEVEL_UP` (its level: `UnitLevel` can lag the event), step
  changes (`QoL.OnStep`), the setting, and the theme's accent.
- **Pace against the route** (`Levels.Pace`, Core/Levels.lua): where the
  character stands, from the live step, against the guide's next level
  target (`Engine.LevelTarget`: level N, its step, and the fraction of a
  `level N.f` goal; the guide holds you at that step until you have it) or,
  with no `level` goal ahead in a leveling guide, its own end level (the
  `levels` top, where the next guide starts, at its last step shown), and
  what the steps up to there give (`Levels.ForGuide(id, p, live, step)`:
  their turn-ins' XP from the Codex, their kills and loot at the mobs'
  levels, from where the character is). A span's entries are kept, by the
  guide's table, the span and who the character is (level, class, race,
  faction), until a turn-in, a level or a guide change (`Levels.Invalidate`):
  the line is asked on every `PLAYER_XP_UPDATE`, and a kill's XP only reruns
  `Levels.Run` over them. Each step's own rows (its turn-ins' records, its
  kills' and loot's mobs, from the Codex) are kept per guide and class, race
  and faction until a guide, pack or Codex change, for the last 8 of them: a
  step change moves every span's start, and a new span only sums those rows
  (whether a quest is done is asked then). It also looks for the first open
  quest before the target (not a turn-in or a talk) that will be 3 or more
  levels above the character when the route gets there (`hard`; its level
  from the guide's `qlvl`, else the Codex, else the client). The guide
  window's XP row (`GF.PaceText(stats)`) always says one of: "On pace for
  level 14 by step 32" (on pace, ahead, or up to `GF.PACE_SLACK`, one
  level, short: Fitz, 0.3.6, players read a few bars short as being behind);
  "Behind by 1.2 levels: step 32 grinds to level 14 (~12m)" (a `level` goal
  ahead makes up the gap, said plainly); in the warning colour, "Behind by
  2.4 levels for level 24 by step 21: grind ~1h 10m before then" ("and no
  grind step ahead" without a rate). The hard quest is named only on its own
  step: calmly, "On pace, but Ashenvale Outrunners (24) at step 4 is hard:
  you're 21.3; reach 22 first", or past the slack, in the warning colour,
  "Behind: Missing In Action (25) at step 20, you're 21.0; grind ~1h 10m
  first" ("reach 23 first" without an XP rate). Grinding time is the XP
  short over the QoL tracker's XP an hour. Nothing without the Codex
  (Lookup), at 60, or with no target (a guide that is not a leveling one
  with no `level` goal ahead). Re-read with the XP row and on
  `STEP_CHANGED`.
- **A quest well over your level, on its step** (`Levels.StepHint(i)`): a
  step with work (not an accept, a hand-in or a talk: taking a quest early
  is normal) on an open quest 3 or more levels above the character says so
  under its header, "Level 25 quest: you're 19.7" (your level and share of
  it, cut to one place), in a calm colour, never red.

### Boosted Rest status — QoL/Rest

```lua
Polestar.QoL.Rest.Left() -> seconds | true | nil      -- Boosted Rest left; true: on without an end given; nil: off
Polestar.QoL.Rest.BagLeft() -> nil | 0 | seconds      -- Cozy Sleeping Bag: not carried, ready, cooldown left
Polestar.QoL.Rest.Parts() -> { text, ... }            -- its line under the XP row; one reused table; empty with the option off or nothing to say
Polestar.QoL.Rest.Refresh(force)                      -- read the aura and the bag again
-- message QOL_REST_UPDATED(changed): changed false for the minute redraws
```

- **What** (`qol.boostedRest`, on by default; Quality of Life > Trackers >
  Experience): the campfire's Boosted Rest (spell 1229451, the buff the
  Great Outdoors quests ask you to /sit for) and the Cozy Sleeping Bag
  (item 211527), on a short line of their own under the guide window's XP
  line (`GF.xp.Rest`; the row grows by `GF.XPROW.restH`), so the pace note
  that almost always shows never pushes them out of sight:
  "Boosted Rest: 42m" (minutes rounded up; "Boosted Rest: on" when the
  aura gives no end), then "Sleeping bag ready" or "Sleeping bag: 12m" when
  the bag is in your bags. "Boosted Rest: off" only beside the bag, so the
  line never shows just to say it; with no XP line it takes that line's
  place; the row's hover repeats it; nothing at the maximum level.
- **Reads**: `C_UnitAuras.GetPlayerAuraBySpellID` (`expirationTime`) on
  `UNIT_AURA` for the player, the bag's count and cooldown (Compat) on
  `BAG_UPDATE_COOLDOWN` and `BAG_UPDATE_DELAYED`, registered only while the
  option is on (`QoL.WhileOn`), and at login and on the setting. A cooldown
  of 1.5 s or less is the global cooldown: ready.
- **Redraws**: while a minute count shows, one `C_Timer.After` to the next
  whole minute fires `QOL_REST_UPDATED(false)` from the times already read
  (no client call); a newer read replaces it.
- **The party**: party sync sends it as "2B|" (Quests/Party.lua), and the
  party panel adds "Boosted Rest 42m" to a member's level line.

### Items kept for later — QoL/Keep, asks the Engine

```lua
Polestar.QoL.Kept(itemID) -> stepIndex | nil                 -- Engine.KeptItems()[itemID]
Polestar.QoL.KeptLine(itemID) -> text, r, g, b | nil          -- its tooltip line
Polestar.QoL.KeptToSell() -> { { item, link }, ... }          -- kept items in the bags a merchant buys, once each
```

- **What is kept** (`Engine.KeptItems`, rebuilt once per evaluation for the
  active tab's guide): from the live step on, the item of a `use`,
  `collect` or `buy` goal, a `craft`'s reagents and the item an `accept`
  starts from; before the live step, a quest `collect` whose quest is still
  in the log, kept for the first later step that hands it in. Steps and
  goals for another character, and those the player skipped, keep nothing.
- **Never sold:** QoL/Vendor.lua's grey selling passes over a kept item.
- **Marked:** its tooltip (Hooks.ItemLines, owner "keep") reads "Kept for
  the guide: step N needs it" in the accent colour, and "Don't sell: the
  guide needs it at step N" in the warning colour while a merchant is open;
  in the bags (QoL/BagGlow.lua, under `qol.bagGlow`) a kept item a merchant
  would buy gets a small lock in its top-left corner (Baganator: a top-left
  corner widget), unless it is the glowing step item.
- **Warned:** opening a merchant with kept items that sell in the bags
  prints them in chat first ("Keep <items>: later steps of the guide need
  them.").

### Bag space, junk and keep marks — QoL/Space, QoL/Marks

```lua
Polestar.QoL.Marks.Get(itemID) -> "junk" | "keep" | nil   -- the player's own mark (QoL.State().marks)
Polestar.QoL.Marks.Set(itemID, mark)                      -- "junk", "keep" or nil; fires ITEM_MARKS(itemID, mark)
Polestar.QoL.Marks.Protected(itemID) -> bool              -- marked keep, or QoL.Kept(itemID) (a later step needs it)
Polestar.QoL.Marks.Junk(itemID) -> bool                   -- marked junk and not protected
Polestar.QoL.Space.Count() -> free, total                 -- slots of bags whose family is 0 (no quivers, soul or profession bags)
Polestar.QoL.Space.Cheapest() -> { bag, slot, id, count, value, link } | nil
Polestar.QoL.Space.Low() -> bool                          -- qol.bagSpace on and free <= qol.bagsLow (2)
Polestar.QoL.Space.Press() -> "armed" | "deleted" | "none" | "busy" | "off"
Polestar.QoL.Space.Banner() -> { free, junk, armed } | nil -- while low and the live step has an open collect goal
Polestar.QoL.Space.Dismiss()                              -- the banner, until the bags have room again
```

- **Marks** (`qol.itemMarks`, on): Ctrl+Alt (no Shift) on a modified item
  click (`Hooks.ItemClick`: bag slots, loot slots, chat links) cycles none →
  junk → keep → none and says it in chat; the tooltip line comes from
  `Hooks.ItemLines`. Per character, by item ID.
- **Selling** (`QoL/Vendor.lua`): a slot sells when it is grey or marked
  junk, has a vendor price, and is not protected, needed by a quest, or a
  quest's item or quest starter (`Client.SlotQuest`, from
  `C_Container.GetContainerItemQuestInfo`; #1557). The slot is re-read right
  before it sells, as before.
- **Junk to delete**: a grey item, or a junk-marked one of common quality or
  below (an uncommon one sells instead), never a protected one nor a quest's
  item or quest starter (`Client.SlotQuest`). Cheapest by
  vendor price × stack; no value is 0, an uncached price goes last.
- **Two presses.** `Press` arms the cheapest junk for 5 s; a second `Press`
  while that same slot still holds that same item (read again) picks it up
  and calls `DeleteCursorItem` (restricted: only from a press, as the
  client's own delete dialog does). Nothing on the cursor beforehand, or the
  pickup would swap it in. A changed slot or a late second press arms again.
  The bag button (`PolestarBagButton`, bindable as
  `CLICK PolestarBagButton:LeftButton`) and the banner's "Delete it" link
  both call it; the button's action runs in its `PostClick`, with no secure
  attribute.
- **Bag button position.** Apart from the quest item, Hearthstone, target
  and rare buttons (one holder, `QoL.State().buttonPos`), the bag button has
  its own spot, `QoL.State().bagButtonPos` (per character; unset: two slots
  above the quest item's default spot, `CENTER` 260, -52, where it sat in the
  set), at the same `qol.buttonScale`. A drag on it moves only it, with the
  set's rules (out of combat; with `ui.lockHud` only a Shift-drag,
  `ns.DragLocked`), and a drag on the set leaves it. Reset button positions
  clears both. Once per character (`bagButtonOwn`), a set moved before the
  bag button had its own spot hands it that old slot (the set's position
  plus 88), so it stays where it was on screen.
- **Updates**: `BAG_UPDATE_DELAYED` and `ITEM_MARKS`, coalesced; the free
  count always, the cheapest junk only while the bags are low. `BAG_SPACE`
  goes out when the count, the junk or the armed state changes (the button
  and the guide window listen).

### Gear from loot and merchants — QoL/Wear

```lua
Polestar.QoL.Wear.Offer() -> { id, link, slot, pct } | nil   -- the oldest standing offer
Polestar.QoL.Wear.Take()                                     -- EquipItemByName(link, slot), through QoL.Secure
Polestar.QoL.Wear.Decline()                                  -- QoL.State().wearDeclined[id] = true
Polestar.QoL.Wear.Dismiss()                                  -- drop this copy only
Polestar.QoL.Equip.Placement(Gear, link) -> slot, pct | nil  -- shared with the quest rewards (QoL/Equip.lua)
```

- **What counts** (`qol.wearOffer`, on; nothing with Gear advice off): a
  bag scan on `BAG_UPDATE_DELAYED` compares item counts with the last scan
  (the first, at login or after the option or Gear advice was off, only
  records them; the two count tables are reused in turn). A new copy of an
  item with an equip location (not a bag) that was not worn at the last
  scan is placed as a quest reward is; an upgrade becomes an offer. Left
  alone: declined items, `QoL.Kept` items, junk-marked items, and a turn-in
  item `Equip.Pending` says QoL/Equip.lua is putting on.
- **Offers** stand until taken, declined or dismissed, or until the item
  leaves the bags or stops being an upgrade (each scan re-places them).
  `WEAR_OFFER` fires when the first one changes. The guide window shows it
  as a banner after the Class guide offer: "Wear it", "Not this one", close.
  An item that binds when worn still shows the client's own confirmation.

### Restock — QoL/Restock

```lua
Polestar.QoL.Restock.Get(kind) / Set(kind, n)        -- "drink", "food", "ammo"; QoL.State().restock
Polestar.QoL.Restock.GetItem(id) / SetItem(id, n)    -- any item (reagents): restock.items[id]
Polestar.QoL.Restock.KindOf(itemID, shoots) -> "drink" | "food" | "ammo" | nil
Polestar.QoL.Restock.Plan() -> buy, left             -- { i, id, name, need, items, cost, price, perStack }, { name, need, cost, why }
Polestar.QoL.Restock.Run()                           -- the button's press: Buy.Purchase each, print what is left
```

- **Kinds.** A consumable is a drink or food when its use spell's name
  (`C_Item.GetItemSpell`) equals the client's name of spell 430 or 433,
  the use spells of Refreshing Spring Water (159) and Tough Hunk of Bread
  (4540) in cmangos classicdb's `item_template`. Ammunition is item class
  6, subclass 2 (arrows) for a worn bow or crossbow, 3 (shot) for a gun.
  Everything of a kind in the bags counts towards its amount; the
  merchant's best of that kind (highest usable level, then dearest) is
  bought. Items set by hand count by their own ID.
- **Buying** reuses `QoL/Buy.lua`: `Buy.Plan` (whole purchases, stock,
  money), `Buy.OnTheWay` (bought, not landed), `Buy.Purchase` (stack-limit
  splits, landing reports) and `Buy.MAX_SPEND` per press. Goods for other
  currencies, unusable goods and unpriced goods are skipped.
- **The button** (`qol.restock`, on) is a text button under `MerchantFrame`
  (top-right to its bottom-right), shown while the plan buys something,
  with the total on it and the items in its tooltip; updated on
  `MERCHANT_SHOW`, `MERCHANT_UPDATE`, `BAG_UPDATE_DELAYED` and
  `RESTOCK_CHANGED` while the merchant is open. The options page's sliders
  hold per-character state through `get`/`set` (no settings key), which
  `W.Slider` and the options registry accept as they do for toggles;
  `/polestar restock [drink|food|ammo|<item>] <amount>` sets any of them.

## Lookup — Codex, sources, generated guides, mount spotting

`addon/Polestar/Lookup/` (`Lookup.xml`: Codex, Sources, Guide, Spotter,
Options). Everything is off with `lookup.enabled`; `lookup.tooltip`,
`lookup.altClick` and `lookup.mounts` switch the parts (Discovery → Lookup).

```lua
Polestar.Codex.Load() / IsLoaded() / Meta()       -- the local Polestar_Codex pack through Data.Pack; CODEX_LOADED(meta)
Polestar.Codex.Item(id) / Npc(id) / Object(id) / Quest(id) / Instance(key) / Zone(id) / Faction(id) / Spell(spellId)
Polestar.Codex.Name(kind, id) ; Codex.WithRole(role) ; Codex.Loot(kind, id) ; Codex.Each(kind, fn(id, name, quality, status))

Polestar.Lookup.Sources(kind, id, direct) -> rows, entity  -- ranked for this character; direct: straight-line travel, no route plan (tooltips)
   -- row = { type, src, label, detail, zone, map, x, y, f, travel, effort, cost, available, why, whyText,
   --         chance, price, standing, guideable }
Polestar.Lookup.CuratedGuide(kind, id) -> guideId | nil
Polestar.Lookup.BuildGuide(kind, id, ranked) -> def | nil, reason
Polestar.Lookup.Guide(kind, id, index) -> guideId | nil, reason   -- reason "mount": a mount without a curated guide
Polestar.Lookup.IsMount(record) -> bool              -- a Codex item or spell record of the Codex's "mount" kind
Polestar.Lookup.UnitMount(unit) -> { spell, item, name, icon, class } | nil
Polestar.Lookup.Show(query, kind, id)                 -- SHOW_LOOKUP(query, kind, id) for UI/Lookup.lua
Polestar.Lookup.RegisterPlanner(kind, build)          -- build(id) -> { title, steps, ... } | nil, reason: another module's guide kind
Polestar.Lookup.QuestChain(questId, player) -> { quest, ... }  -- every open prerequisite first, the quest last
Polestar.Lookup.QuestStep(quest, from) -> step         -- accept, objectives, turn-in
Polestar.Lookup.AcceptPre(goal, quest) -> goal         -- the accept with the quest's pre (preAll), preAny (pre, the character's own) and preTitles
```

- **Quest steps** (`Lookup.QuestStep`): a collect goal names who gives the
  item as a compiled goal does (`from`, `fromId`, `fromKind`, `fromRank`,
  `fromFaction`, `fromAlso`, `fromAlsoId`): of the Codex sources with a
  spawn, both when there are at most two, else one at 50% or more (and a
  second of its kind at 50%), so Hidden Enemies reads "Kill Burning Blade
  Fanatic or Burning Blade Apprentice for Lieutenant's Insignia" (#1589). A
  talk objective's step note says to click through the NPC's dialogue until
  the quest's line is done (#1590, Neeru Fireblade).
- **Codex records** use the field names of `data/forever/codex/*.json` (see
  Toolchain, "Codex"); the pack holds one compact string per record plus an
  id → name table per group, so search never decodes records, and decoded
  records are cached weakly. The pack writes each chunk's lines in id order,
  so a number id is found by halving the chunk (a string id, or a chunk not
  in that form, by a plain find), and an id a group lacks is remembered as
  absent until its chunks change.
- **Ranking.** A row is unavailable (kept, dimmed, `why` = `faction`, `race`,
  `class`, `level`, `profession`, `reputation`, `done` or `retired`) when the character
  cannot use it now; available rows come first, then by `cost` = travel
  (`ns.TravelCost` from the player to the nearest spawn, giver or dungeon
  entrance; Nav's planner when present) + effort (expected kills from the drop
  chance and the mob's level, a dungeon run per boss kill, a rare's respawn,
  quest objectives and prerequisites, reagents and missing skill, hours for
  reputation and PvP). Race and class masks are Era masks: a race without a
  bit is never excluded. Item tooltips call `Sources` with `direct`: travel is
  the straight-line estimate, never a route plan per spawn (a hover must not
  hitch), so the tooltip's "From …" can name another source than the Lookup
  window's or Alt-click's routed pick (boats and flights).
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
  (`Engine.OpenTab`; with six tabs open nil, `"tabs"`, and the caller says
  "Six tabs is the limit": the active tab is never replaced); a saved tab
  holding one is rebuilt at `ADDON_LOADED`.
  A mount (`Lookup.IsMount`: the Codex's `mount` kind, items teaching a spell
  of the client's Mount table; the one test of "is it a mount") is never built
  from its best source (`Guide` without an index returns nil, `"mount"`): such
  a guide would leave out level 40, riding and the gold, and read a rare drop
  as a plain kill. Only a curated mount guide is offered; a source picked on
  the Lookup page (an index) still builds its guide there.
  A planner kind (`RegisterPlanner`, letters only; Dungeons' `pickup`, `handin` and `attune`) is
  built by its module's `build(id)` through the same `BuildGuide`/`Guide`
  path (no curated guide, not gated by `lookup.enabled`), registered and
  reopened the same way.
- **Tooltips and clicks.** Item tooltips get the best one or two sources and
  "Alt-click: guide me" when Alt-click would guide (for a mount, only with a
  curated guide); Alt-clicking an item link, bag item, loot item or a Rares
  loot row opens its guide (Lookup when there is none). The Codex loads
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
that Forever's dungeon and raid quest lists place in it (`quests.json`'s
`web.zone`, counted only when QuestieDB's Forever store has the quest,
which keeps out `<UNUSED>`, `<NYI>` and retired quests), whose start item drops
or lies inside one instance (that page too, even when the quest has an area),
or that end its story (a follow-up with the same title, no objectives, taken
where the quest ends: Hidden Enemies, The Lord of Blackrock); plus, with
`--local-extras`, `dungeons.json`'s. An objective item that is sold, crafted,
or dropped or held outside every instance ties no quest to a dungeon (the
false-positive rule: Murloc Poachers, Craftsman's Writs), nor does a stray
drop, one only the web lists record and under 5% (The Ectoplasmic
Distiller's Greater Eternal Essence from Gri'lek and Maexxna); a quest of a
game event (pfQuest's `event`: the Darkmoon Faire, the holidays, the war
efforts) is on a page only where QuestieDB or Forever's quest data files it (Copper
Modulator, Rinling's Faire turn-in, is on none). What no rule can catch is
in the cited table `data/codex/journal-quests.json` (Shards of the
Felvine). Each quest has giver and ender and their positions, its objective
facts (`objectives`: kind, NPC, item or object id, count and the English
name; the escorts' and events' text), composed at run time into our own
objective line in the client's language (`Dungeons.ObjectiveText`:
`L["Kill %d %s"]`, `L["Collect %d %s"]`, `L["Use %s"]` with the names from
`Polestar.Names`; an event's line is the quest's own objective summary from
the names pack, kind `objective`), chain (every prerequisite and breadcrumb of the quest's side,
all of `pre` and `preAny`, oldest first, at most 20), rewards (items with
quality, count and choice from recordings, else
the quest list's rewards, choice versus fixed as the list files them; XP from
`forever-db/data/quest.jsonl`, else `quests.json`; money, else the list's; reputation from the list's rewards, its
"+1" placeholders left out, never the standing a quest asks for) and, with
`--local-extras`, DungeonJournal's audited shareability; bosses in kill order
with the quests tied to them (an encounter's boss carries its DungeonEncounter
id, `encounter`, for its name in every language); entrances from the Codex, else the client's Map
table (the corpse point, placed on its zone); and the page's `attunement`
list (below). No loot tables. The page also carries the instance's Map id
(`map`): the list shows the dungeon's name in the client's language
(`Names.Instance`) and its zone's (`C_Map`); attunement notes are our prose,
read through `L[note]` (`forge i18n keys` lists them from
`data/codex/attunements.json`). `codex attune` writes the local comparison with
the Attune addon (`tools/lib/codex/questaudit.js`,
`tools/lib/consume/attune.js`; `data/local/dungeon-quests-audit.md` and
`.json`, then the attunements report). Runtime: `addon/Polestar/Dungeons/Dungeons.lua`
(`Polestar.Dungeons`: List, Get, Entrance, Quests, Quest, ObjectiveText, Bosses, Open,
GuideTo, GuideToPoint, ShowOnMap; `SHOW_DUNGEON`). `dungeons build` writes no
guides.

The pick-up guide is built in game (`addon/Polestar/Dungeons/Pickup.lua`):
`Dungeons.PickupPlan(key, offer)` takes the page's quests that apply to the character
(faction, race and class masks through `Lookup.QuestBlock`, the page's class
list), not done, not in the log (those are `carried`), not closed for good (a
quest of the page's `closedBy` done or in the log: a breadcrumb whose quest is
taken, such as Klockmort's Essentials once Essential Artificials is; each
accept carries `closedBy` too, so the Engine passes it once taken on the way,
and its quest's prerequisites (`Lookup.AcceptPre`: `preAll`, `pre`,
`preTitles`, as a compiled accept, and so do `Lookup.QuestStep`'s and the
hand-in guide's follow-up accepts): when the step that does one is skipped,
the accept reads "Requires ... first" and the guide moves on rather than
sending the player to a giver who does not offer it, #1406),
open by max(level, the dungeon's lowest level), picked up outside from an NPC or object
(not inside) or from an item that drops outside (`Dungeons.DropPoint`: a mob
or object with spawns outside the dungeon that gives it 25% of the time or
more, once the quest's own prerequisites are done; the step collects the item
at the nearest spawn, then takes the quest from it: the Damp Note from
Blackfathom Deeps' tunnel naga, #1380), and not a follow-up of another quest of the
page -- unless the quests before it here are errands (no objectives, any
standing they name held, given (not by an item, unless the item drops outside
as above) and turned in outside by an
NPC or object this character may use: Hamuul Runetotem and Nara Wildmane
before Leaders of the Fang; Allegiance to the Old Gods, the Damp Note handed to
Je'neu Sancrea, before her quest for Lorgus Jett), which are then done on the way as its prerequisites; a quest done on the way
to another is neither a take of its own nor carried; one with a prerequisite the
guide cannot start out here (not in the log, and started by an item neither in
the bags, nor given by a quest before it in the chain, nor dropped outside as
above, or with no placed giver or turn-in: The Unsent Letter, Edwin VanCleef's
drop, before Bazil Thredd; Finkle Einhorn inside Blackrock Spire) is not taken
before the run, nor counted as `later` (that is the level's); each with its open
prerequisites (`Lookup.QuestChain`: all of `pre`, one
of `preAny` this character can take, in the order they are done, the whole
chain however long: each quest once, so a cycle in the data ends the walk), and
the open breadcrumbs of the page's chain, each right before the prerequisite it
leads to (a chain quest no quest of the chain names as a prerequisite, an errand
this character can take now, turned in at that prerequisite's giver; The
Greenwarden from Menethil Harbor before Tramping Paws, #1226; its accept carries
`closedBy`, the quest it leads to, in `plan.closedBy`). A breadcrumb to a quest
the plan takes anyway (a quest of the plan with no objectives that none of its
quests names as a prerequisite, turned in where another quest of the plan is
given) is then left out of `take` and of `pre` when it is a detour: its giver on
a continent no other stop is on (where the player stands, the entrance, the
other givers and chain turn-ins), or its cheapest insertion on the way from any
of those stops to its target, min T(A, giver) + T(giver, target) - T(A, target),
over 300 seconds (Castpipe's Task in Stonetalon and Klockmort's Essentials in
Darnassus for a Stormwind player's Gnomeregan quests; the sweep's taken
breadcrumbs cost at most 185 s, its detours at least 479 s), or over 150
seconds when it is a delivery across the sea (its giver on another continent
than every one of its targets): from Stonetalon Peak, Castpipe's Task costs
200 s and is left out (#1402); Tabetha's Task at the Undercity's mage trainer,
100 s for a player in the Undercity, stays. `plan.breadcrumbs` says how each
was judged (`detour`, `far`, `sea`, `taken`). The giver
is `Dungeons.Giver(pq, from)`: the page keeps one (the Codex's first), so a
quest several NPCs give goes to the one of the character's side nearest the
player (`Lookup.QuestEnd`, which takes an NPC of the other side only when no
other is known and marks it `hostile`; Tabetha's Task: the mage trainers of
both sides), never to one of the other side; the quest card and the map's
giver markers show the same giver.
`Dungeons.PickupGuide(key)` orders them as the cheapest path by
`ns.TravelCost` from where the player stands, through every stop, to the
entrance (`Dungeons.PlanStops(stops, from, finish, travel) -> order, cost`:
the stops at hand first, those no more than `AT_HAND` (15 s) of travel from
the player, nearest-next, as a stop beside the player costs at most twice
that over the cheapest path (#1593: out of Ragefire Chasm beside Neeru
Fireblade, the hand-in guide went to Thunder Bluff first); then an exact
search over the stops done and the last one, up to 12 stops; above
that nearest-next, then single stops moved while the path gets shorter). A
nearest-next walk with the entrance only appended left a city and came back
to it (Thunder Bluff, Orgrimmar, the Undercity, back to Orgrimmar for
Ragefire Chasm); the planned path goes Thunder Bluff, the Undercity,
Orgrimmar and in. Stops: each prerequisite once, after the one before it in
its chain (a full quest step, `Lookup.QuestStep`, from its giver nearest the
player; the player then stands at its turn-in), and a giver once per set of
prerequisites its quests wait on (one step with an accept per quest; the
giver comes up again for a quest still waiting, and visits to the same giver
in a row are one step). The last step names the carried quests in one line,
its note (#1591: not a row each above the way in), goes to the entrance and
says where the hand-in guide is (a note naming
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
objectives, or only talk lines left: each open quest-log line a talk
objective of the Codex quest at a placed NPC of the character's side, kept
as `talks` with the line's `oi`, as The Glowing Shard's Sputtervalve in
Ratchet, #1326; turned in outside at the page's ender, else the Codex ender
nearest the player), `unfinished` (any other line open), `inside` (turned
in inside the dungeon) and `unplaced`; it searches no follow-ups, so the
page can ask for it on every render. `Dungeons.HandinFollowUps(plan)` adds
the quests the `hand` quests open (`Codex.FollowUps(id)`: the quests whose
`pre` or `preAny` name
it, one scan of the quest records per id, kept until the quest chunks
change): every `pre` done or handed in here and one of `preAny` likewise,
takeable now (`Lookup.QuestBlock`: faction, race, class, level), not done or
in the log, from the NPC or object a quest it waits on is turned in to or
one within 60 seconds of it (`ns.TravelCost`). `Dungeons.HandinGuide(key)`
makes a stop per turn-in place (its turn-ins, then the follow-ups that same
NPC gives), per NPC a `talks` line is at (a talk goal on that line, before
the turn-in place of its quest) and per other follow-up giver (after the
turn-ins it waits on),
ordered by `Dungeons.OrderStops` with no fixed end (`CharState().dungeonHandin[key]`);
the last step lists the rest as notes ("Not finished yet: …", "Turned in
inside the dungeon: …"). Nothing routable: nil, "nothing", and
`Dungeons.HandinText(plan)` says why in one line. `Dungeons.HandIn` puts the
guide in the tab of the dungeon's pick-up guide when that one is finished or
at its last step (its job ends at the entrance; with six tabs open that tab
is closed first to make room), else in a new tab. A
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
    { kind = "toggle",   key = "qol.mapObjectives", label = "Objective markers", help = "One line.",
      search = "map pins, icons, markers" },                            -- optional: English words players may search with
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
registered labels and help are searchable (below, "Settings search"). A `label` may be a function, asked
when the control is drawn or searched (a name in the client's language that
is not loaded at registration, `Names.Instance`). A toggle with `get()` and
`set(on)` and no `key` holds state that is no setting (per character): it
reads and writes through them, right-click and Reset page call `set(nil)`.
Discovery → Dungeons → "Dungeons in leveling guides" is one: a toggle per
Classic dungeon (`Dungeons.ROUTE`, Map id and English name, from the Codex's
instances), all off, writing `Engine.ChooseDungeon`. Registered toggles are
fixed, so the list is not built from the dungeons the loaded guides name. Pages sort by `order`; Recorder and
About always close the list. A page or tab with no available control is left
out of the sidebar and tab row. Every row resets to its default on right-click.

One setting may show on two pages: a convenience on its home page and on
Quality of Life, where players look for it (the quest automation toggles,
Faster auto-loot, the quest item button, the minimap button, …). Each page
gets its own control table for the same key (a function that returns a
fresh one, `C.*` in QoL/Options.lua), as the registry keeps per-control
state; both read and write the one setting.

**Settings search** (`O.Search`, UI/Options.lua) finds a setting from a
vague or misspelled hint. Each control's words are worked out once and kept
on it (`psFind`, again only when a label function names it anew): its label;
its key's words (`autoAccept`: auto, accept); its `search` terms and, on a
translated client, its English label (the key of `L` it was looked up
with); its section, tab and page; its help. Words are folded (lower case,
Latin accents dropped, Cyrillic capitals lowered, a few American spellings
read as the labels' British ones), and each two neighbours are also kept
joined ("auto loot" gives "autoloot"). A query word matches a word whole,
as its start, a typo off (optimal string alignment distance 1 for 4-7
letters, 2 for 8 or more; not against help) or inside it (4 bytes or more,
so "lag" is not found in "flag"; a query word still holding non-ASCII text
after folding, such as one Chinese, Korean or Cyrillic letter, has no floor); filler words
("the", "how", "turn", "off") only add to a match, the others must each
match something. Scores, highest first: the label's whole word 100 and start
80, the key 75/65, search terms and English label 70/60, section, tab and
page 50/45, help 40/35, typos 30 to 20, inside a word 12 to 5; two query
words that are one joined pair of the control's add up to 40. Results keep
their page and tab groups, the best first in each and the group with the
best match first; a setting on two pages comes once, under the first. What
a query word makes of each word is remembered while it is typed on
(64 words at most). With no match the page says so and offers up to three
labels nearest the query as links that search for them.

The built-in pages are grouped by what the player is doing: **Guide** (10:
Window, Arrow & routes, Automation), **Appearance** (20: Colour & type,
Windows, Arrow), **Map** (30), **Questing** (40: Quests, Rewards & gear,
Talents, Buttons), **Discovery** (50: Lookup, Dungeons, Rares, Characters), **Quality of Life** (60:
Quests, Travel, Social, Vendors, Trackers, Map), **Community guides** (70, a custom page:
`UI/Packs.lua`), **Gamepad** (75, registered by `UI/GamepadGuide.lua`:
Navigation, Key bindings), **Guiding Stars** (80, key `thanks`, a custom page:
`UI/Thanks.lua`: three columns, the top supporter, the top contributor and the
top bug reporter on podiums, each over its list (the contributors' merged pull
requests and the bug reporters' confirmed or fixed reports as bare counts, named
in the list's note), from `Core/Credits.lua`, generated by `forge release credits` from
`data/credits.json` (Ko-fi supporters in rank order, no amounts; the page
names them only, with no donation link or request, per Blizzard's add-on
policy rule 5), the merged pull requests on GitHub and its issues (the top 40
reporters; which reports count: docs/forge/release.md); `UI.Thanks.HeaderLink` puts "Special thanks
to: <name>", a name drawn anew at each open, at the top right of the hub's
and the options' headers, opening the page), Recorder, About. The options window
declares every tab and section of the module-filled pages, in order, and the
modules register their controls into them by name (`page = L["Questing"]`,
`tab = L["Rewards & gear"]`, `section = L["Gear advice"]`): Quests, QoL,
Gear and Talents fill Questing; Lookup, Dungeons, Rares and Characters fill Discovery; QoL, Maps
(flight timer, instances, coordinates, minimap button), Nav (travel button, transport alerts, nearby
services) and the options window (trainer reminders) fill Quality of Life. On the **Map** page (Guide &
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
a new selection is scrolled into view, and a redraw with the same one (a
refresh, a guide picked in the list) keeps the place the player scrolled to.
The hub shares it. Its items are
`{ key, label, icon, count, dot }`: `dot` puts a warning dot at the row's
right edge instead of the count (a page spec's `dot = function() end`, the
Community guides page while a pack has problems), and `{ heading = true, label }`
is a muted heading over the rows after it, not a choice (the menu's "Community
guides").

The settings window is a rail shell like the hub (`W.Shell` with `rail`): it
shows the hub's sections (`UI.Picker.RailItems()`, and at its foot
`UI.Picker.FootItems()`) with Options marked, and a
section reopens the hub there. Switching between the two places the window
being opened at the other's top-left corner (`UI.Picker.TakePlace`), so the
rail does not move.

### Guide window, guide menu and zone art

Reading flow: `docs/DESIGN.md` ("Intent" and "The Guide Window").

- **Guide window** (`UI/GuideFrame.lua`): tab strip (each tab's close button
  faint at rest, full under the pointer; right-click for Choose guide, Close
  tab, Move left/right; middle-click closes), a slim navigator (prev,
  step number, next, Skip, the bug that opens the report window, menu), one
  focus header from the step view's `groups`/`focus` (the person to talk to
  now, or a field step's place) over that group's open goals (#843), counters
  right after the goal text (in text, success once complete; the accent is
  kept for the current goal's glyph, the arrow's target mark, tabs, primary
  buttons and the progress fill). A `complete` goal reads as its quest's
  objectives, a line each with its own counter (the goal view's
  `objectiveLines`: the quest log's lines in the game's words, counts cut
  off by `Compat.ObjectiveLabel`; before the quest is in the log the
  compiled `objs`), "Use <item>:" first while the item its quest hands over
  (`startItem`) is in the bags and usable (`useItem`), and "Complete
  <quest>" only with neither (#942). Every other group of the step is a
  summary line in written order: a later person "Then: <name> · 1 hand-in, 2
  quests" (the name in the NPC or object colour, open goals that apply
  counted by verb in the order they come: quests, hand-ins, tasks), the
  field work "Then out here: 7 kills and items" (kills, items, else goals; a
  "Go to" counts only when nothing else is open), a later group already
  done "✓ <name>". With one or two goals open the line names them instead
  of counting ("Then: Marleth Barleybrew · Accept Bitter Rivals", "Then out
  here: Kill Snow Leopards"; `UI.GoalText`, the quest in its colour). A
  line too wide wraps to a second line, its row growing by it, and only
  past two lines ends in "…"; opened, it is only "Then: <name>" or "Then out
  here", since its goals are the rows under it (#1021). Along the way and
  Up next rows wrap the same way. Past the first three such lines, the rest
  share one "+ N more people · X quests, Y tasks" line (`CARD.ahead`,
  always counts). A person whose goals another person's goal splits
  (Auberdine's Thundris Windweaver, a vendor, Thundris again) is one line,
  at their first group after the focus, listing all their goals in written
  order, their groups done before the focus too. The groups done before the
  focus share one "✓ <name>, <name>" line, so a quest taken, handed in or
  not offered stays on the card when the focus moves on (#741/#739). The
  focus person's own groups on the same visit, with only persons between
  (Thundris the focus, a vendor, Thundris again; not a hand-in after field
  work), read with the focus, in written order (#942).
  Under the header, a step that depends on what the player does says in one
  line why it holds nothing for them now: the step view's `why`
  (`Own.stepWhy`: the `when` condition that fails, else the group quest it
  waits on, "Only if you do Book Return with a group"; #942). Steps that are
  not the character's (an along step, another class's or race's) are never
  shown, numbered or explained: the navigator's "N / M", the step list,
  Up next, the numbered pins, "Then:", "Back to step N", the XP pace line,
  the bug report ("Step 7 of 33 (guide step 9)"), the tabs and menus all use
  `Engine.StepNumber`/`StepTotal` (`UI.StepNo`, `UI.StepTotal`). An along
  step's goals read under "Along the way" of the steps after it, its heading
  "Along the way, until step N" when every row ends at the same labelled
  step (`GetAlong` entries' `untilStep`).
  A goal's tooltip lists its detail, then Quest, NPC, Item and Location; an
  accept's adds Level ("Requires level 29", in danger while the character
  is below it) and Needs (the prerequisites not handed in yet, "A or B" for
  any one of several, in danger), both from `Engine.AcceptGate` and left out
  when it knows nothing (#1247).
  The "While you're here" panel (`GF.FillHere`, `Engine.GetWhileHereList`)
  sits between the step's goals and "Then:": a ground of the accent dulled
  into the window ground (`Theme.AccentGround`, repainted on a look change)
  with a 2 px accent edge and a "While you're here" label in the accent, then
  one goal row per line (`GF.HereRow`): the verb's glyph, `UI.GoalLine` of
  the later step's goal (a hand-in its `hereText`), wrapping, "Step N" under
  it, the distance in textMuted and a close button. The panel slides 8 px in
  from the left as it fades in (`Anim.BASE`, ease-out) and slides back and
  fades faster (`Anim.FAST`) when its last line goes, before the window
  closes the gap; rows coming and going inside it do not slide it; under
  `ui.reduceMotion` it only fades. A row's left-click:
  `Engine.AimWhileHere(i)`; right-click or its close button:
  `Engine.DismissWhileHere(i)`; `WHILE_HERE_MOVED(yards, i)` moves its
  distance. In the compact window the rows drop their "Step N" line; in the
  transparent style the ground is the accent alone at `GF.HERE_CLEAR` (0.18)
  under the outlined text. With the window hidden, the toast (UI/WhileHere.lua,
  `UI.WhileHereToast`) says a new line once, slides down into place as it
  fades in, and leaves after 8 s (held under the cursor) or with the line.
  An object named like one of its quests while it gives another too (one
  poster for two WANTED quests) is headed by the first goal note that names
  it, else "The object here" (`UI.GroupName`, #942). A click
  on a line lists what it stands for under it (goals,
  stepped back in textDim; the "more" line its persons' lines) and a second
  click folds them; a new focus or step closes every line and the new focus
  shows in full. Finished goals of the focus fold into a "✓ N done" line at
  the top of its goals (`model.folded`, per guide, step and focus): a goal
  already done when the focus came is counted at once; one that turns done
  while it shows pops its check, holds 0.75 s, then folds shut over 0.3 s
  (cubic ease-out; its text and glyph fade in the first 60 %), the rows
  below gliding up because each row is anchored under the one before, and
  the count goes up with its text glowing from the accent back to textDim
  over 0.6 s. Goals done together start 80 ms apart; the first fold of a
  focus grows the done line in as its row shuts. One driver frame
  (`fold.driver`) runs every fold and the glow and drops its OnUpdate when
  none is left; a frame only sets heights, alphas, colours and the points of
  the frames under the card (`fitGoals`), and a fold that lands refills the
  card once. Under `ui.reduceMotion` a fold is the hold, a 0.2 s fade and the
  count, with no height motion or glow. A click on the done line lists the
  finished goals, dimmed. "Show the whole step" (`ui.wholeStep`, off) lists
  every goal of the step instead, as before #843 (the other persons' named on
  their rows), with the "Then:" line and "Person n of N"; a done step (no
  focus) always lists its goals. Otherwise the "Then: <next person>" line
  shows only once no group of the step is open after the focus (it names the
  next step's first person). The goals sit in a scroll area (`W.Scroll`)
  between the header and the tip: the window never grows past `ui.maxHeight`
  of the screen's height (0.5; 0.3 to 0.9 in Options > Guide > Window, in
  the window's own units, so its scale and the UI scale count), the goals
  area giving up the difference (never below 72 px), the header, the tip
  and everything under the card staying whole. Past the cap the goals area
  ends on a whole goal or line, never inside one (a wrapped goal's second
  line was cut in half under the tip): the bottom of the last one that fits,
  or, where that is under the 72 px floor, the bottom of the one the cap
  cuts (unless that passes the cap by more than 72 px); while goals fold it
  keeps its height and settles once they are done. With Grow upward the cap is
  also the height from the pinned bottom edge to the top of the screen (the
  game would otherwise move the window down, bottom edge and all, #666);
  when even the shortest goals area does not fit there, the body clips its
  lower lines at the bars (at least 40 px of it stays). Past the cap the wheel
  scrolls the goals (48 px a notch; without more to see the wheel stays the
  camera's), a thin bar shows and fades out 1.5 s after the last scroll or
  hover, and the current goal glides into sight when the focus or the
  current goal changes (from the top on a new focus). A row scrolled out of
  sight or folding has no name target. The resize grip and every width
  change keep to the cap. Tips fold to one line (an opened tip
  shows the step's `image` under it: the texture in its pack's addon folder,
  as wide as the text column, its aspect kept, at most 160 high; none for a
  pack without an addon folder, or a file the client cannot load), and the
  guide's progress bar with percent. Up next is off by default (`ui.upcoming = 0`).
  Transparent mode fades the whole navigator (step number with its chevrons)
  until hovered and keeps the progress track as a faint ink line.
  The step number scrubs: each wheel notch over it looks one step back (up)
  or on (down), ten with Shift (`GF.Scrub`, through `GF.LookAt`: Prev and
  Next, so a skipped step is never un-skipped), and four seconds after the
  last notch the window is back on the live step unless the player moved
  on from there or did some of that step's work meanwhile (a goal's status
  or count changed: then it stays, as after Next); in combat it waits for
  the fight to end. A click on it opens the step browser (Step browser,
  below) in place of the card; a second click closes it.
- **Class-quest card** (`UI/ClassCard.lua`): over the person and goals of
  a step whose accept (else turn-in) is one of the character's class quests:
  `UI/ClassRewards.lua` limits the quest to a few classes, the character's
  among them. A step or goal `only <Class>` is a route choice and a Class
  guide carries open errands, so neither makes a class quest. No card for a
  chain whose reward the character already knows or owns
  (`ClassToast.RewardKnown`). In the class colour
  (`Theme.ClassColor`; text lifted with `Theme.Legible`): border, 4 px
  stripe, a left-to-right glow; the chain's reward icon in a ring
  (`GetSpellTexture` on the reward spell, else the first item's
  `GetItemIcon`, else the class icon); "<CLASS> · LEVEL <n>", the quest
  name, "Learn <spell>" or "Earn <item>" (a choice: "Earn the Whirlwind Axe,
  Sword or Warhammer"); a NEW ABILITY / PET / MOUNT / WEAPON / ARMOR badge;
  the zones the chain's remaining steps cross and their count; "Only you see
  this". The step's quest names take the class colour (`UI.GoalLine`'s
  `questHex`). Compact keeps the head, name and reward line. The first time
  a chain's card shows on a character (`classCardSeen`) a band of the class
  colour crosses it once (under `ui.reduceMotion` the glow brightens and
  settles instead) and, with `ui.classCardSound` and the game's sound effects
  on, a chime plays on the SFX channel. `classrewards build` writes the data:
  each class quest's class mask, chain (the quest links' connected part; a
  class guide's unlinked quests join its giver's) and reward, the nearest
  quest from it on along the links that teaches a spell (TDB RewardSpell, a
  "teach" spell resolved through SpellEffect), else the nearest that gives a
  weapon, armour or totem; a class guide's first `reward` line goes on the
  guide quest that gives it, else its last quest.
  The step's class accept folds into the card ("Accept from <giver>, <zone>"
  with the step's tick box, `ClassCard.Fold`); GuideFrame lists no row for it.
  A step that also hands in another class quest still in the log (Brine in
  Call of Water: turn in 1530, accept 1535, every part named "Call of
  Water") has the card for that turn-in until it is handed in, the accept a
  row of its own: an open tick box for the next part read as though the
  quest in the log were not taken (#1372). A hand tick shows ticked and the
  card reads the accept's notice ("<quest> isn't in your quest log": a tick
  never stands for the quest; "This <quest> isn't in your quest log yet:
  the one you have is another quest of that name" while another quest of
  the guide by that name is in the log).
- **Class quest heads-up** (`UI/ClassToast.lua`, `PolestarClassToast`): a
  card that lives on the guide window: as wide as it, in its panel, border,
  fonts and buttons, the class colour only on the stripe, the icon ring and
  the small header. It slides up from behind the window's top edge (a fade
  under `ui.reduceMotion`), follows the window, flips below it when the
  screen has no room above (rechecked after a drag) and hides with it. It
  shows for a chain of the character's class whose start has a giver for
  its race and side (`starts[q].r`, "<race>:<A|H>"), not a level-1 one (learned
  at the start), opening at the new level (PLAYER_LEVEL_UP) or in the last
  two levels (login), its reward not known or owned (IsPlayerSpell /
  IsSpellKnown; GetItemCount with the bank), no quest of its chain done or in
  the log, once per chain per character (`classToastSeen`; the same reward
  from another giver counts as told). "<reward> ready" ("Voidwalker ready": a summon by what it summons), "Get it
  from <giver>, <zone>." and "Your route takes you there at <step>." when the
  loaded leveling guide has a step for the chain ahead. It always offers an
  action: "Open in a new tab" when a Class guide takes the chain
  (Engine.OpenTab, the guide menu's path, then `Engine.Goto` to the first
  step accepting the quest, else the first open goal of its chain; the tab
  it came from is kept in `classReturn`, and the finished guide offers
  "Close and return"), else "Show me" (Nav.SetTarget on the giver). "Later"
  and the close button dismiss. Chime with `ui.classCardSound`.
  `/polestar classtoast [quest]` shows it again. `classrewards build` writes
  `starts`: each rewarded chain's first quest with its givers, and for each
  race and side the start and giver it takes for the reward: a giver in the
  race's home (its starting zone or capital), else one in no race's home,
  else one in another race's (Skyborne use the Night Elves' and Tauren's).
- **Dungeon heads-up** (`UI/DungeonToast.lua`, #836): the class quest
  heads-up's card (`UI.ClassToast.ShowCard(model)`, a model with its own
  `act`, `more` and `off` buttons and no class: the accent's stripe, ring and
  header; on a window too narrow for them, the chip goes under the header,
  Later and the "stop" button take a row under the actions, and a button
  that still doesn't fit starts the next row) for a dungeon whose quests
  have opened to this character: in its ring the dungeon's own picture
  (`Dungeons.Art(key)`, `Dungeons/Art.lua`: the instance's loading screen
  from the client's Map and LoadingScreens tables, by Map id, a square crop
  as texture coordinates; the model's `art`, filling the ring inside a 2px
  rim of the accent; a dark one's `lift` adds the picture over itself at
  that alpha, `ADD` blend, so it reads at 36 px), or for a dungeon without one the dungeon glyph small
  on the ring's disc (an `icon` tinted `iconColor` is a glyph), "LEVEL
  20 · DUNGEON", "<name> is open to you", "<n> quests to pick up · Levels
  17–24 · <zone>", what they are worth in the accent chip (`LevelTip.Text`
  of `Dungeons.QuestXP`), **Pick up the quests** (`Dungeons.PickUp`: the
  pickup guide in a new tab), **Open in Dungeons** (`Dungeons.Open`: its
  page in the hub), **Later** and **Turn these off**
  (`dungeons.headsUp` off; also under Options > Discovery > Dungeons). It
  tells a dungeon, not a raid, with quests for the character's faction, the
  character's level in its range, whose pickup plan by the offer rule
  (`Dungeons.PickupPlan(key, true)`: a quest more than one level above the
  character waits for its level less one, `Dungeons.OfferLevel`; 0.3.7, the
  game gives many 3-5 levels early) has a quest to take now
  and none left for later levels or at least 3 to take; once per dungeon per
  character (`CharState().dungeonToastSeen`, set once the card is on screen
  or dismissed: a card waiting for the hidden guide window is told when the
  window shows it); of several, the one that came due last (its range's
  start or its first quest's offer level). Its **Pick up the quests** opens
  the guide by the same rule (`Dungeons.PickUp(key, true)`, kept in
  `CharState().pickupOffer` for the rebuild after /reload); the page's own
  button picks up everything the game gives. It checks 1.5 s after `PLAYER_LEVEL_UP`, so the class quest
  heads-up has the card first; 4 s after login, then only for a dungeon
  that came due within the last two levels; and 1.5 s after
  `QUEST_TURNED_IN` of a quest on a dungeon's page (a prerequisite whose
  follow-ups there may open), then only for that dungeon. Only the level-up
  check loads the Codex: the login one waits for `CODEX_LOADED` (a level-up
  in the meantime covers it) and a hand-in before the Codex is loaded is
  told at the next level-up. In combat (the Codex may
  have to load) or while another card is shown it waits for
  `PLAYER_REGEN_ENABLED` or `HEADS_UP_HIDDEN` (fired by `UI.ClassToast.Hide`);
  the waiting checks run in order until one shows a card.
  `/polestar dungeontoast [dungeon]` shows it again ("Nothing to pick up" for
  a dungeon with no quest to take now).
- **Class spells** (`QoL/Spells.lua`, the cards in `UI/SpellCards.lua` on
  `UI.ClassToast.ShowCard`; Options > Quality of Life > Vendors > Trainers,
  `qol.levelUpSpells` and `qol.oldRanks`, both on). `QoL/ClassSpells.lua`
  (generated by `forge data classspells` from the TDB extract's sniffed class
  training lists and the Forever client's SpellName, Spell and
  SkillLineAbility) packs, per class, one string of
  `<level>=<spell>:<cost>:<rank>[:<previous rank>[:<race mask>]]`, unpacked
  only for the character's class. **Level-up**: 2 s after
  `PLAYER_LEVEL_UP`, `Spells.NewAt(level)` keeps the spells at exactly that
  level for the character's race (`UnitRace`'s id against the mask), not
  known, and for a higher rank only when the rank below is known or trainable
  by then (a talent's higher ranks need the talent); any left fire
  `LEVELUP_SPELLS` { level, spells, cost, money }. Nothing in an instance; in combat it
  waits for `PLAYER_REGEN_ENABLED`. The card: "LEVEL 12 · PRIEST", "3 new
  spells to train", a row of up to 8 icons ("+N more") with the game's spell
  tooltip (`W.SpellTip` with `CT.PlaceTip`: beside the card, on its side
  facing the screen's middle, never over its lines) and the training cost, the
  total (`SpellCards.Money`: `GetMoneyString`, zero units left out) in the
  success colour when affordable, the warning colour with the balance when
  not; then where to train, from `Engine.TrainingAdvice()` as the training
  reminder banner says it (Class-training reminder above): the guide's own
  training stop when it is within 10 steps ("The guide trains you in 6
  steps (Orgrimmar).", no button: `m.noAct`, Later leads the row), else the
  planner's class trainer and **Show me** (`Nav.SetTarget`, as the banner's
  Show), and no
  trainer line at all while the guide window's training reminder banner is up;
  quiet (`m.quiet`: no chime), hidden after 30 s (`m.hideAfter`, not while
  the pointer is on it). The old-ranks card lists one spell per line in plain
  text ("Renew: rank 2 to 3"; the game's fonts have no arrow), 4 at most then
  "+N more" (`SpellCards.RANK_LINES`). **Old ranks**: `Spells.OldRanks()` reads action slots
  1-180 (every page, the stance and form bars, the side bars, and bar addons
  that use the game's slots); a `spell` action whose name has a higher
  "Rank N" in the player's spellbook (`C_SpellBook`, the pet's left out) is
  listed; macros, items and rankless spells never. Left alone: a spell kept
  from the card's right-click (`QoL.State().keptRanks`), and a slot the
  player filled with a lower rank while knowing a higher one
  (`ACTIONBAR_SLOT_CHANGED` to a spell other than the one last seen there, not
  one just picked up off another slot: `QoL.State().keptSlots`, kept even
  after a higher rank is learned). `OLD_RANKS` fires a second after the last
  `LEARNED_SPELL_IN_TAB` / `SPELLS_CHANGED` and 6 s after login, once per
  distinct list per session (nil when none is left: the card goes).
  **Upgrade** (`Spells.Upgrade`, through `QoL.Secure`, so in combat after
  `PLAYER_REGEN_ENABLED`): with nothing on the cursor, for each listed slot
  still holding that rank `PickupSpell(highest)`, `PlaceAction(slot)`,
  `ClearCursor()` (the old rank comes back on the cursor), the slot read back
  and counted. "Forget kept ranks" lists the kept ones again. Both cards wait
  for another heads-up on the card (`HEADS_UP_HIDDEN`).
- **Update notices** (`Core/Update.lua`, `UI/UpdateCard.lua`). What is known
  of a newer release, most trusted first: Polestar Client's
  `PolestarClientInfo` (the Polestar folder's `ClientInfo.lua`, shipped as
  `nil`; docs/RECORDING.md "Client info": `latest`, `released`, `checked`,
  `releases`); a party member's version (Party.lua's hello, `1P|` and `2U|`), a
  guild member's (the guild hello below) or a stranger's (the version probe
  below), counted when it parses as x.y.z,
  is newer than ours and at most one minor version ahead (`9.9.9`, `999.0`,
  `0.3.8-rc1` and `dev` never count), kept 7 days, overruled by a Client
  check made after it was heard. `Update.Latest()` gives the newest, how
  many releases behind (the Client's `releases` newer than ours; else from
  the numbers: 0.3.5 to 0.3.7 is 2, a new minor version its patch + 1) and
  its source. Our own dev build hears nothing. With nothing known and no
  Client check of the last 7 days vouching for this build, one first run 21
  days ago or more (`update.since`) is "old".
  The card is the class quest heads-up's (`UI.ClassToast.ShowCard`, the
  model's `later = { label, run }` renaming Later): "POLESTAR UPDATE",
  "Polestar 0.3.7 is out", "You're on 0.3.6." (two or more behind: "You're
  on 0.3.5, 2 updates behind: fixes for the quests and arrow issues players
  report are in the newer versions."), how to update (with `ClientInfo.lua`
  present: Polestar Client can do it), **What's new** (the release's GitHub
  page in the copy window; the game's own notes are this build's) and **Got
  it** (`update.snooze`, 24 h). It shows at every login, 10 s in, while a
  newer release is known, or once one becomes known later in the session
  (`UPDATE_KNOWN`); once a session; never in combat, in an instance, over
  another heads-up or in the first 120 s of a fresh install
  (`update.firstRun`): it waits for `PLAYER_REGEN_ENABLED`,
  `PLAYER_ENTERING_WORLD`, `HEADS_UP_HIDDEN` or the end of those seconds.
  `update.card` (Options > Guide > Window, on by default) turns it off,
  except two or more behind: then it shows at most once a day
  (`update.shownAt`). The guide window's last banner (`update`, shown with
  no guide open too): "Polestar 0.3.7 is out: you're on 0.3.6." with
  **Update** (the card, at any time), closable for the session one behind,
  never two or more behind, when `update.card` is off hidden only one
  behind; the old build's "This Polestar is 3 weeks old: updates come often,
  check for a newer one." with **How to update** (the card's how-to),
  closable, off with `update.card`. The report window (UI/Report.lua) opens
  with "You're on an old Polestar (0.3.6): please update first, your problem
  may already be fixed." and its version line reads "0.3.6 Beta (outdated:
  latest 0.3.7)" while a newer release is known. `/polestar update` shows
  the card. The guild hello: in a guild, with `party.share` on, a release
  build sends `1H|<version>` on the GUILD addon channel (Party's prefix;
  Party.lua reads only PARTY) 20 s after login, at most every 30 min
  (`update.helloAt`); a member on a newer release answers `1Y|<version>`
  after 2-12 s unless an answer with that version or newer came first, at
  most every 5 min (`update.replyAt`). Only the version goes out.
  The version probe (no addon can tell another runs Polestar without
  asking): on `PLAYER_TARGET_CHANGED` and `UPDATE_MOUSEOVER_UNIT` (never
  nameplates, which flood in crowds), a player (`UnitIsPlayer`, not you) of
  your faction, not in your party, raid or guild, whose name and GUID are not
  secret, while you are out of combat, outside instances, outside cities,
  inns and other rest areas (`IsResting`) and outside the messaging lockdown
  (`C_ChatInfo.InChatMessagingLockdown`), is asked once:
  `C_ChatInfo.RequestCanLocalWhisperTarget(guid)` first where the client has
  it, and only on `CAN_LOCAL_WHISPER_TARGET_RESPONSE` status 0 (CanWhisper,
  so no "not found" line shows) the addon whisper `PSV1?<version>` on the
  `Polestar` prefix (unique among Forever's addons), to the unit's own name
  as the game's Whisper builds it (`Compat.UnitFullName`: "Ana Smith" with
  the client's `CHARACTERNAME_SURNAME_SEPARATOR`; `RegionalUniqueNamesEnabled()`
  is not read, as other addons found it off on Forever). Its own handler
  reads WHISPER only (Party.lua reads PARTY only), and only
  `^PSV1([%?=])(%d+)%.(%d+)%.(%d+)$` at most 24 bytes with major ≤ 99, minor
  and patch ≤ 999; anything else is dropped silently. A `?` is answered
  `PSV1=<version>` after 0.5-2.5 s, once per sender per 60 s and 20 times a
  session at most (by
  `Compat.SenderName`), to the `sender` string as it arrived, never our own
  echo; its version is not kept. A `=` counts only from a player probed in
  the last 60 s, once (the entry goes with the answer). A newer release
  heard this way is kept per player (`update.heard`) and told as a peer's
  version (`NotePeer`) only once two different players answered with newer
  releases: the lower of the two highest. Older Polestars don't answer
  whispers, so silence means nothing. Limits: one probe per player per 7 days
  (`update.probed`, 300 players, the oldest dropped), one per 30 s, 10 a
  session. Once those are spent or a newer release is known, the target and
  mouseover events are unregistered until the next login; while registered,
  a mouseover inside the 30 s returns at its first comparison (1,000 of them
  allocate nothing: `ui-update.rs`). Any result but Success (a throttle, the
  lockdown, an offline target, a trial account) is skipped quietly and not
  retried. Off, no probes and no answers: `party.share` off, `update.probe`
  off (on by default; Options > Questing > Quests > Group, under sharing), a
  build that isn't a release, or Polestar Client's kill switch
  (`PolestarClientInfo.probe = false`, written when the newest release's
  notes carry `<!-- polestar: probe off -->`). No SAY, YELL or CHANNEL addon
  messages: Forever's Mainline client refuses the first two and a custom
  channel shows in the channel list.
  `CHAT_MSG_ADDON` is registered for the guild in a guild and for whispers
  while probing is on (`PLAYER_GUILD_UPDATE`, `SETTING_CHANGED`); the prefix
  is registered with either. Solo with probing off, nothing listens.
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
  A section registered with `foot = true` sits at the rail's foot, above
  Options, instead of among the sections (`P.FootItems(onOptions)`: Options,
  then each foot section, from the bottom up).
- **Import** (`UI/Import.lua`, a foot section, order 90; `/polestar import`
  and `SHOW_IMPORT` open it). The two ways to bring someone else's guides
  into Polestar side by side (an import string for one small guide, a
  community addon for a route or a set), then a single-line box: what is
  pasted is read at once (`Import.Preview`) and shown before anything is
  saved ("Title · by Author · N steps · levels a–b · faction · licence"),
  with Import (Update when an older version is imported; nothing for the
  same or a newer one, with a line saying so) and Cancel, or the reason it
  is refused. Enter imports. Below, "Your imported guides" (title, "By
  author · version · licence", why a stored guide did not register,
  Delete with a second click to confirm), then "Want more than one guide?"
  (community addons in three steps and the GUIDE_PACKS.md link).
- **Guide menu** (the Guides section): three panes. Left: the categories with
  counts. Middle: Home (continue and suggested), Browse, Current (open tabs),
  Recent (the tabs closed, newest first, then the last guides loaded) tabs
  over one line per guide,
  `Title (min–max)`, in folders (a guide's `folder` when set, else leveling by
  faction and band, other guides by category); search also matches `folder`
  and `keywords`. The faction filter (`ui.pickerFaction`, default this
  character's) on the player's own faction lists only the guides this
  character can follow (`Guides.GuideMatches`: no other race's or class's
  guides), except the other races' starting zones of that faction
  (`Guides.OtherStart`), which go in an "Other starting zones" folder right
  after the player's levels 1–30; the other faction and All list every guide
  in its usual folder. Right: the
  selected guide's zone art, facts (led by a guide's `reward` tiles and
  `why`, "Guide data"), progress, pitch, pros and cons, a favourite
  star, "Load guide" and "Open in new tab". Selecting never loads; the buttons,
  a double-click or Enter do. The list's scroll area (and its bar) ends at
  the details' edge (the hidden footer marks the column); a redraw (a tab's
  progress, a selection, a guide registering) keeps the list where it is,
  and the details' pitch, pros and cons keep their place until another
  guide or quest search is shown.
  Home's Continue cards (one per open tab) show one row: as many as fit at
  220px (two at the default width), the active tab first, then the most
  recently used (`recentGuides`), then the rest in tab order; "Show all (N)"
  lays out every tab and "Show fewer" folds them again (kept for the
  session, not saved). A card closes its tab (`Engine.CloseTab`, which hands
  the active tab over) from the close button in its corner (under the
  pointer), its right-click menu (Close tab, Move left, Move right) or Y on
  a gamepad.
  `UI.Picker.ShowQuest(questID)` opens this search with the client's quest
  title, matching the exact ID in applicable guide goals. Its details put
  those steps and their tips before the pitch; selecting loads nothing.
  `UI/QuestLinks.lua` adds this action to the native quest log and objective
  tracker menus through `Menu.ModifyMenu`, only with the keyboard and mouse
  interface. It works without the Codex; only installed guides are searched.
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
  `Lookup.Guide`; nothing guides to an unobtainable entity, and a mount
  without a curated guide has no "Guide me", only a note pointing at its
  sources and their "Guide". Guide results
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
  with one for the filter's side), Bosses n, Map. Quests: a card (panel ground,
  a rule under its head) per quest planned from the
  data (the objective measured on one shared string) so only the cards in
  view are drawn (`DS.PaintQuests` on scroll): the title in the client's
  difficulty colour (`GetQuestDifficultyColor`, else `QuestDifficultyColors`
  by level gap) lifted to 4.5:1, the state from `Compat.IsQuestCompleted`,
  `IsOnQuest`, `IsQuestReadyForTurnIn` and the level, level, requirement,
  classes, picked up inside (an item that starts it: when every known source
  of the item is inside, `Dungeons.StartDrops`; else the page's flag),
  shareable; Objective, Starts/Ends with pins
  (`Dungeons.GuideToPoint`); the Starts line names what drops a starting
  item (the boss, else the two likeliest mobs or objects, inside the dungeon
  or out) and is one link to
  `Dungeons.GiverTarget`: the giver of the first prerequisite still to do
  (its turn-in when that one is in the log), else the quest's giver (for an
  item start, the nearest mob or object outside that drops it), its
  tooltip saying which; the Chain (`Dungeons.Quest` per id, a pin each; the
  steps still to do numbered, the next one on an accent ground),
  Choose one / You get item tiles (border and name in the colour of the
  item's tooltip, else its quality, the client's then the page's, painted
  again when the item loads; hover `GameTooltip:
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
- **Welcome** (`UI/Welcome.lua`, `SHOW_WELCOME`): centred, 600 wide, four
  pages each under its own night hero, the gold rim (`W.Rim`) on top, with
  Skip (Back on the last page), the step dots (not buttons), Back and Next
  in the footer: Hello, <name> (the suggested guide's zone painting engraved
  faintly into the night; what Polestar does, then three cards with
  miniatures built from frames: a goal row of the suggested guide, the gold
  dart going to its first walk's place, the library's Leveling, Professions
  and Reputation counts); Set up (quest automation, the guide at login, the
  colour scheme as preview cards in each scheme's colours that apply live;
  Skip keeps them); Route style (polestar.guide's route demo, the same for everyone: the
  Elwynn Forest painting, Northshire Abbey to the Westfall bridge, the
  chosen style's illustrated walk as the site draws it; a switch leaves the
  last one as a faint dashed ghost and replays the trail, at once under
  reduced motion; `nav.routeStyle`, the setting Options' Route style dropdown
  writes, as three rows, Fastest,
  Balanced with its Recommended tag and Roads, each saying what it does: a
  click sets it live and Nav/Walk.lua searches again, right-click or the
  gamepad's Y puts Balanced back, and the pick follows the setting however
  it changes; a line on what every style keeps you away from); Start (the guide
  `Guides.Suggest()` picks on its zone painting, with its level range and
  pitch; what Start guide does; the beta note while `ns.routesBeta`; the
  Discord invite as a link to the copy window; community guides with a
  Browse guides link to the guide menu; then Start guide, or Choose a guide
  without one). The window takes its tallest page's height; a shorter page's body is centred in the room under its hero. Once
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
- **What's new** (`UI/WhatsNew.lua`, frame `PolestarWhatsNew`, `SHOW_WHATSNEW`):
  the welcome's look from its building blocks (`UI.Welcome.Kit`): 600 wide,
  centred, a compact night hero with "What's new in Polestar <version>", the
  newest entry of `NOTES` as note rows (glyph, heading, line under a
  hairline), and a footer with "Full notes: polestar.guide" (text), "Open the
  guide list" (the guide list's home view, with Suggested for you) and "Got
  it". Once per account on the first login after an update
  (`PolestarDB.whatsNewSeen` differs from the newest notes' version; missing
  on an account from before the window), 3 s after login, marked as it
  opens; never on a fresh install, in combat, during a cinematic, in an
  instance or battleground, over the route choice, or while the welcome is
  up or due (`UI.Welcome.Busy`, then `WELCOME_CLOSED`). A release with notes
  adds an entry at the top of `NOTES`. About's "What's new" and `/polestar
  whatsnew` open it again.
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
  went wrong (`UI.Report.DESC_MAX`, 1000 letters, in a box that grows from
  three lines to seven, then scrolls); the report is `UI.Report.Text(description,
  details, spot)`: their words after "**What went wrong:**", then as bold
  lines under it the right spot when one is marked ("**Right spot:**") and
  the other addons that are loaded, names only, quest, map and guide addons
  first, then A to Z ("**Addons:**", left out when there are none), then
  `UI.Report.Details()` in a code block, one fact a line, taken when the
  window opens: Polestar's version and stage, the client build and locale;
  race, class, level (XP %) and faction (never the name or realm); the guide
  (title, id, pack and version); "Step n of N: title", with "the guide is at
  step m" while another step is looked at, or "skipped"; each goal (the first
  six, then "... k more goals") as `[>]` the window's current goal, `[→]` the
  arrow's when the player picked another (a row click, the waypoint keys),
  `[x]` done, `[-]` skipped, `[n/a]` not for this character or `[ ]` open, its line and count,
  `quest`, `npc`, `item`, `object` ids, `map <id> @x,y` as a guide writes it
  (`live` unless in the Era frame) and `spot i of n` for the arrow's spawn
  spot; the arrow's target and distance (and "your own waypoint" with its
  position when the player set it, the position alone while it is held on the
  way back to the corpse); where the player stands (zone, subzone,
  `map <id> @x,y live`); "Routes:" with the route style (`nav.routeStyle`:
  `fastest`, `balanced` or `roads`, in English) and only the routing settings
  away from their defaults (`real paths off`, `travel planner off`, `handed
  to Shortest Path Forever`), after Where so the bug bot still finds Arrow and
  Where by position and reads this line by its style word; "While here:"
  (`Engine.WhileHereState`, English words) with the line shown (its text,
  quest, step, yards) or "none", the radius, a hand-in's seconds out of the
  way ("hand-ins 20 s", or off) and the count of candidates, and
  without a line the nearest candidate's quest, step and yards (a hand-in's
  detour too) and why it does not show (out of radius, out of the way,
  turned away by the walk, quiet, in combat, an instance, a flight, an
  escort, no candidates, off); other packs that are on; and the errors
  (`Polestar.Errors()`, plus with !BugGrabber its errors this session in
  Polestar's files, `BugGrabber:GetDB()`) by their path from the AddOns
  folder, and the calls the game blocked (`Polestar.Blocked()`) as "blocked
  in <addon>: <function> (<time>)": the newest three of both together, by
  `seq` (!BugGrabber's count as the newest), each counted. Above the code
  block, under the player's words, bold lines for the right spot when one
  is marked and the other addons that are loaded (quest, map and guide
  addons first, then A to Z). Every line is cut at 100 bytes, and when the
  report is still longer than one Discord message (2000 characters) it
  gives up, in order, the log's oldest lines, the Addons line (shortened,
  then dropped), Settings, Packs, the goals other than the current one, the
  two after it and the arrow's (furthest first), the quest log, the errors
  but the newest, then the planned and hidden lines, While here, Install,
  Routes and the newest error, and closes the block with "(trimmed to fit
  Discord)". The description is never cut, nor the versions, character,
  guide, step, current goal, Arrow, Where or Errors lines the bot reads. The
  Discord bot (`tools/discord-bot`) takes the code block for the details
  and everything above it, the bold lines included, as the description it
  quotes in the issue.
  "Mark the right spot" hides the window behind a bar (`PolestarMark`) while
  the player walks to where the step should have sent them; "Mark here"
  keeps `ns.WhereLines()` as the right spot, and "Clear mark" takes it out.
  Under it, the way to send the report: Discord's mark, "Report it on
  Discord", three numbered lines (press Copy report then Ctrl+C, open #bugs
  and press New Post, paste and post: the bot files it), "Copy report",
  which shows the report box under it selected (a view of the report that
  scrolls, as tall as the window has room for inside a 720-unit screen,
  #1753), and "Get the invite", which
  opens the invite (`Polestar.DiscordURL`) in the copy window. Last, for a
  player with a GitHub account, "Open on GitHub" opens in the copy window a
  link to a new issue on Polestar's GitHub,
  `UI.Report.IssueURL(description, details, spot)`, whose query fills the
  issue form's fields by their ids: a "Wrong step" issue (`wrong-step.yml`:
  title, guide, step, character, the right spot, the report) when the
  player marked a spot, a "Bug report" (`bug-report.yml`) otherwise, both
  with the version and the addons. The report in the issue leaves out the
  Addons line and, in a Wrong step issue, the Right spot line: each has its
  own field. The whole link stays under `UI.Report.LINK_MAX` (GitHub
  refuses one much longer): the report gives up details in the same order,
  ending "(trimmed to fit the link)", then is cut from its end (the
  description only when it alone is longer than the link holds: a long
  Cyrillic or Chinese one, 6 or 9 characters a letter once encoded), and
  the addons field lists as many as fit after a line that
  counts them. Copy report and Open on GitHub wait until the description
  holds `UI.Report.DESC_MIN` characters. The game opens no links and has no
  clipboard for addons, so every text to take away is selected for Ctrl+C
  (`W.SelectCopy`: focused and selected, then again a frame later, once a
  box shown inside a scroll view is laid out); Ctrl+A (Cmd+A) or a click in
  a copy box selects it all again.
  A gamepad starts on "Copy report", or on "Mark the right spot" while it
  waits. The details, the issue's fields and the right spot are taken when
  the window opens or the spot is marked, so the guide moving on changes
  neither. What the player typed and the right spot stay while the window
  is reopened on the same step. The hub's and the settings' sidebars carry
  the Discord's mark at the end of the version line
  (`UI.Report.SidebarLink(shell)`), which opens the invite like
  `/polestar discord` (`UI.ShowDiscord`, `SHOW_DISCORD`).
- **Per-character UI state** in `CharState().ui`: `recentGuides` (ids, newest
  first, at most 10), `favoriteGuides` (id -> true), `pickerSelected` (id).

### Step browser

`UI/StepList.lua` (`UI.StepList`) lists every step of the guide in the
guide window, in place of the step card, the "Then:" lines and the journey,
in every look and in compact mode. A click on the step number opens it
(`StepList.Toggle`); a second click, a click on a card or Escape
(`PolestarStepList` in `UISpecialFrames`) closes it. A hide the layout did
not ask for (Escape) closes it; a hide of the whole window (Alt-Z, combat)
does not: the list hides its own frame too, so the next Escape is not spent
on it, and comes back with the window. Under the gamepad UI Escape does not
reach it (`ns.CloseOnEscape` adds nothing there); the step number closes it.
The guide finishing or another guide opening closes it, so the next guide
opens on its card. The open state is not saved. `GuideFrame.Layout` asks `StepList.Place(body, steps)` for its frame
and stacks it at `StepList.Layout(width, room)`, as tall as its cards up to
the window's cap (`ui.maxHeight`, the screen's top with Grow upward).
`StepList.Fill` reads `Engine.GetStepView` for each step not hidden for this
character (`UI.StepHidden`) and not `na`: all of them when the guide, the
step on screen, the live step or the progress moved, else only the live and
the viewed step's cards; the cards are measured again only when what one
says, the width, the style or the font changed. A card is a "N · title"
header, then a line per person and goal in written order as the step card
words them (`UI.GroupName`, `UI.GoalLine`, `UI.ReadingGoal`), a first goal the
title already says left out, six lines at most then "+N more". A finished step
other than the one on screen is its header alone. A click on a card looks at
that step (`GF.LookAt`, so nothing is un-skipped). On opening the step on
screen (else the live one) scrolls to the top. In a profession guide each
skill range (`section`, the view's `section` from `Engine.GetSection`) is a
heading over the first card under it, the range the player's skill is in
(`state` "current") in the accent colour, the others muted.

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
kind's words and where it ends, never "Unknown") and its time. Consecutive
walks with the same caption and the same hostile-town and detour lines are
one row, their times and yards added (0.3.7, `JP.Rows`; Fitz saw "Go to
Durotar" twice, the walk to a zone crossing and the walk across it): its
number is its place among the route's rows, a walk half done keeps its row,
and the arrow still walks each leg. Boats,
zeppelins, the tram and lifts add a line, "average wait 0:15 · ride 0:10"
("leaves in" once a ride timed the loop; "on board · 0:42" while riding).
A walk whose engine path enters the other faction's towns (`leg.hubs`) adds
"Hostile town: Southshore" (names joined by commas) in the warning colour.
The current row wears the accent glyph and the 2px selection bar; a click
on it opens the skip menu (`Nav.prompts.OpenMenu`), which also has "Back to
the guide" while the arrow is on a point of the player's own
(`Nav.IsOverride`). For that point the header carries an x as well, "Back
to the guide" (`Nav.BackToGuide`): the point lets go and the journey ends
(#1686). Marking a leg done is no way to end one: the route is planned from
where the player stands, so a leg not yet walked comes back.

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
setting exists. Non-secure frames only. Tests: `rust/crates/forge-addontest/tests/addontest/ui-journey.rs`;
render: `docs/preview/journey.svg`.

### Showing and hiding the window: rules, the floating button, the instance hint

`GuideFrame.ApplyVisibility` shows the window when `ui.shown` is on and its
own rules don't hide it now (`GuideFrame.RulesHide`): a fight with
`ui.combat` "hide", or a dungeon, raid, battleground or arena with
`ui.instance` "hide" (the default) until the player opens the window there
(`GuideFrame.ToggleInside`: Guide window in the minimap button's menu, the
key binding, `/polestar`).
Each call fires `GUIDE_VISIBILITY`.

- The floating button (`UI/Launcher.lua`, `ui.launcher`, off by default;
  Options, Guide, Window, Show and hide, beside the minimap button's own
  toggle): a 32px `PolestarLauncher` on `UIParent` in the minimap button's
  look, and works as it does: click hides or shows all of Polestar
  (`Polestar.ToggleHidden`, dimmed while hidden), right-click opens `Maps.ShowMenu`, a drag
  (`StartMoving`; with `ui.lockHud` only a Shift-drag, `ns.DragLocked`) saves
  its centre in `ui.launcherPos` (from the screen's bottom-left; unset: beside
  the window's default corner, `TOPRIGHT` -440, -256). It refreshes on
  `GUIDE_VISIBILITY` and its settings and hides while `RulesHide()` holds, so
  it goes in a fight or an instance as the window does and stays when the
  player hid the window. No frame exists until the setting is first on.
- The instance hint: the first time on the account (`PolestarDB.instanceHint`)
  the window hides itself on the way into an instance (not while Polestar is
  hidden, see "Hiding Polestar": the hint waits), `Nav.alerts.ShowNotice`
  puts "Polestar is hidden here" at the top of the screen for 12 s with
  `GuideFrame.HowToShow()`: the toggle's key (`GetBindingKey("POLESTAR_TOGGLE")`,
  named by `GetBindingText`) when bound, and Guide window in the minimap
  button's menu when the button is on, else `/polestar` (never with the
  gamepad interface). One chat line repeats
  it with where the setting is. `GUIDE_SHOWN` true takes the notice down.
  Accounts told by the older chat-only line (`instanceHideTold`, cleared now)
  see the notice once.
- `Nav/Alerts.lua`'s banner (`PolestarAlert`) carries both the transport
  countdown (`ShowBanner`) and these notices (`ShowNotice`, `HideNotice`): a
  notice wears the emblem in an accent ring, its line wraps to three lines
  and the banner grows by the extra lines; no linger after its time.

Tests: `ui.rs` (`in_dungeons_and_battlegrounds_*`, `floating_button_*`),
`nav-prompts.rs` (`alerts_a_notice_*`); render: `docs/preview/instance-hint.svg`.

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
  `_PREV`, `_NEXT_WAYPOINT` and `_PREV_WAYPOINT` (`Engine.CycleWaypoint(1 |
  -1)`: a goal with spawn spots moves to its next or previous spot through
  `CycleSpot`, else the arrow moves to the step's next or previous open
  goal that has a place, round the step), `_FOCUS`, `_MENU`
  (`TOGGLE_PICKER`), `_OPTIONS` (`TOGGLE_OPTIONS`), `_REPORT`, and the quest
  buttons' `CLICK` bindings; `Polestar.Bindings` runs them, and every one but
  the `CLICK` bindings takes a chord. Every binding (the Recorder's too) has
  `category="Polestar"`: Options > Keybindings lists them in a section of
  their own after AddOns (the game shows a category that is no global string
  as itself; `_G.Polestar` is the addon's table), so their names are short
  (the column fits ~22 characters) and say no "Polestar". The settings search
  matches names and search tags, never the section, so each has
  `searchTags="BINDING_TAG_POLESTAR"` (`"Polestar"`, set in Core/Commands.lua
  and the Recorder's Panel.lua). Bindings are saved by name, so moving the
  section keeps every key. Nothing is bound unasked. A chord
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
Polestar.Rares.FOUNDER                              -- "Fitz Polestar", the founder's character
Polestar.Rares.IsFounder(name) -> bool              -- that full name exactly ("-Realm" allowed)
Polestar.Rares.DecideFounder(ctx) -> action, reason -- pure; "alert" | "skip"
Polestar.Rares.FounderSighting(unit, source, guid)  -- a player unit from Detect
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
  is looked at once per 3 s, except a confirmed alive-to-dead transition;
  unchanged dead observations remain throttled. The full vignette scan runs
  at most every 2 s and never in combat. Nothing is detected inside instances.
- **The decision**: off, instance, path off, players and pets, not a rare →
  skip; muted (`rares.ignored`) → skip; dead, alerts off, treasure alerts
  off, or alerted within `rares.cooldown` minutes → recorded only; in combat
  without `rares.combatAlerts` → held until `PLAYER_REGEN_ENABLED` (dropped
  after a minute); otherwise the alert fires immediately (`RARE_SPOTTED(alert)`,
  sound `rares.soundKit` when `rares.sound`). Release rechecks the decision
  against current settings, instance and cooldown state before marking it
  alerted. An observed death cancels a held sighting only when both have the
  same known creature GUID; historical deaths and NPC ids alone never cancel it.
- **History**: account-wide per realm, `PolestarDB.rares.history[realm][key]`
  (`"rare:<npc>"`, `"treasure:<object>"`, `"name:<name>"` without an id), at
  most 400 entries; the cooldown reads `alerted` (epoch seconds), so it
  survives a reload. Losing it only resets cooldowns and the Seen list.
- **Toast** (`PolestarRareToast`): name, "Level n Rare · 85 yd · Zone"
  (vignettes: the distance; units: "in sight"; a vignette without a position:
  "known spawn 120 yd"), "Set waypoint" (the vignette's position, asked again
  on the click and on parent maps when the player's map lacks it; a unit:
  where it was seen; else the nearest known spawn on the player's continent,
  or no waypoint), "Show rare" (the section) and, for a rare, "Target": a
  secure button (`PolestarRareCardTarget`, on UIParent, registered for press
  and release with `useOnKeyDown` false so it acts once, on the release,
  whatever `ActionButtonUseKeyDown` says) over the card's own
  runs `QoL.Buttons.RareCardMacro` (`/targetexact` the name, `/ping
  [@target]` where the client has `SLASH_PING1`, always, as the rare button
  does; the Target button and step key ping mobs only with `qol.pingTarget`,
  off by default, never for a raid member without lead or assist:
  `Buttons.QuestPingLine`; the mob's `/tm` with `qol.markTarget`); for the founder it runs `Buttons.FounderMacro`. Its
  macro and its anchor to the card are set only out of combat;
  `PLAYER_REGEN_DISABLED` (before the lockdown) lets go of it, so the card
  can still move and close in a fight, where Target shows disabled with a
  tooltip naming the rare button and its key. `rares.toastSeconds` with a
  drain line, held under the cursor, draggable (`rares.toastPoint`).
- **The founder** (`rares.founder`, on; Discovery → Rares → When a rare
  shows up): a player unit on the nameplate, target or mouseover path goes
  to `FounderSighting`, which matches `Compat.UnitFullName(unit)` (Forever's
  names carry a surname: `UnitName` gives first name and surname, or the
  two in one string) against `Rares.FOUNDER` exactly; "Fitz Poletsar" or
  "Fitz" alone never match. `DecideFounder`: module or option off, the
  player is the founder (his own client), an instance (battlegrounds and
  arenas too) or combat → skip; after an alert, skip while he is still
  listed (`stillHere`) or within 24 hours (`cooldown`; account-wide,
  `PolestarDB.rares.founderAt` in `time()` seconds, so /reload and relog
  keep it; a saved time in the future is ignored; this session's `GetTime`
  alert counts too). The alert is `RARE_SPOTTED` with `kind = "founder"`
  (`enemy` when his faction differs; both factions get it): the toast shows
  his crest alone (`founder-emblem`, 40 px, untinted, no ring; the others keep their tinted glyph in the ring), "The Polestar founder is nearby!", his name and zone, a
  nudge to wave (another line for the other faction), the card's Target
  button (it waves) and no waypoint or section button. Nothing enters the
  history. He is listed in `Nearby()`
  for the rare button while shown (looked at every 45 s), and the button's
  macro for him is `Buttons.FounderMacro`: `/cleartarget [nocombat]`,
  `/targetexact Fitz Polestar`, `/targetexact [noexists] Fitz` (Forever's
  own unit menu targets a surnamed player by first name when regional
  unique names are off), `/wave`. Only the player's click runs it.
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
`Builds.lua` (generated by `forge data talents build`), `Overlay.lua` (the talent frame),
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
  `forge data talents build` writes them all into `Builds.lua`, one `T.Register` per
  class, sorted by class. `T.Register` keeps only the player's class
  (`UnitClass("player")`): the other classes' plans are dropped unexpanded,
  so a character holds one class's plans, not all nine. The tool finds each class's tree by its class skill
  line (`CLASSES` in `rust/crates/forge-data/src/talents.rs`) and leaves out a stray
  copy of a talent far off the grid (1.60.1.70374 and 1.60.1.70450: Hunter node 104982,
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
  `rust/crates/forge-data/src/talents.rs` (`PREREQ_RULE`, default `"full"`, unconfirmed in game);
  `Builds.lua` carries it as `prereq` and `Talents.Replay` follows it.
- **Overlay.** Post-hooks only: the frame's `OnShow` and EventRegistry's
  `TalentFrameBase.ButtonsUpdated` / `ConfigUpdated`, and each button's
  `OnEnter` (`HookScript`) for the tooltip line. Marks are our own child
  frames: a ring on the next pick while a point is unspent, the pick number
  of each talent's next planned rank (an order, never a level), a flag on
  ranks off the plan; the tooltip line says "pick #N". Staged ranks count. Nothing is drawn while inspecting or for a
  loadout that is not the active one; in combat the redraw waits for
  `PLAYER_REGEN_ENABLED`.

## Alts — the Characters page

`addon/Polestar/Alts/` (`Alts\Alts.xml`, loaded after `Talents\Talents.xml`):
`Snapshot.lua` (`Polestar.Alts`: the saved snapshots, the events that write
them, the `alts` command), `Options.lua` (Discovery → Characters),
`View.lua` (the hub section, order 60).

```
Polestar.Alts.Key() -> "Name-Realm"                         -- as Maps/Instances.lua files its entries
Polestar.Alts.List(sortBy) -> entries                       -- the playing character first, then "seen" (default) | "rested" | "level"
Polestar.Alts.Forget(key) -> boolean                        -- never the playing character
Polestar.Alts.Write(silent, touch) -> boolean               -- the playing character's entry (touch: only `seen`); false with alts.enabled off
Polestar.Alts.ProjectRested(entry, now) -> xp | nil         -- no saved state; nil at the level cap (now defaults to the server time)
Polestar.Alts.Rested(entry, now) -> xp | nil                -- live for the playing character, else projected
Polestar.Alts.IsCurrent(entry), Polestar.Alts.MaxLevel(), Polestar.Alts.Enabled()
```

- **Store.** `PolestarDB.alts.chars["Name-Realm"]`, one small entry per
  character: name, realm, class, race, faction, level, xp, xpMax, rested,
  resting, zone, bind, money, profs (skill line to rank), tabs (up to six
  `{ id, title, step, count, complete }` from `Engine.GetTabs`) with `active`, `seen`
  (server time), `key`. Values that equal nothing are left out. An alt's
  entry is as of its last write, normally its logout.
- **Writes.** All in the world: at login (after five seconds, once the tabs
  exist), on resting changes at once, on level-ups, XP, zone, money, skill and
  tab changes coalesced into one write every ten seconds (a single pending
  timer) while not resting, and at once while `IsResting()` reads true, and at
  once when the player asks to leave (`PLAYER_CAMPING` / `PLAYER_QUITING`
  where the client has them). `Logout` and `Quit` are protected functions and
  are not hooked; writing at once while resting (an inn or city, where an
  instant logout is possible) is what leaves the saved entry current when
  they are used. Also when the Characters page is drawn (so the playing
  character is current there) and when `alts.enabled` is turned on. A write merges into the entry: a field that does not
  read keeps its saved value; the zone is the zone-type map above the player's
  map, not an indoor area's name. `PLAYER_LEAVING_WORLD` and `PLAYER_LOGOUT`
  read nothing and only move `seen`: the client answers wrongly while the
  world goes (resting false, no gold, no map, the indoor area for the zone),
  plausibly enough that nothing could tell, so those reads would overwrite
  good values. `ALTS_UPDATED` follows a write. `alts.enabled` (default on)
  off: no events registered, no writes; saved entries are still listed, and
  can be forgotten.
- **Rested XP.** `ProjectRested` uses Classic's rules as named constants
  (`REST_PER_8H`, `AWAY_FACTOR`, `REST_CAP`); Forever's rates are unverified,
  so an alt's figure is an estimate.
- **Section.** One `Button` row per character (so the gamepad can focus it),
  sorted by `alts.sort` (the hub tabs: Last played, Most rested, Level); the
  sidebar has an entry per character, which selects and scrolls to its row; the instance count, in the subtitle, is `Maps.GetInstanceStatus()`.
  Forget uses `W.Confirm`. `SHOW_ALTS` opens it (`/pole alts`).

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
| `export <file.guide>` | lints the file's pack (the nearest `pack.json` above it) and prints its one guide as an import string (`tools/lib/pack/importstring.js`; PACK_FORMAT.md, "Import strings"); refuses a file with errors, of several guides, of Polestar's own, over 60 steps or 50,000 characters. `play` and `dev --play` give the same string (`POST /api/import`, the page's Copy import string) |
| `doctor` | Node, Lua, reference data, AddOns folder, `pack.json` |
| `find` | quests, NPCs, objects, items, inns, flight points and our guides as guide lines (`--json`); `--kind inn\|flight` without a text lists every inn or flight point (from `travel.json`) |
| `playtest` | every guide to the end per class (`tools/lib/playtest.js`, also behind `tests/guides.test.js`); a guide starts with the prerequisites of its accepts that the guides chaining into it turn in already done, and those they leave for it only to hand in in the log, as for a player arriving on the route. Plays run on a pool of long-lived lua5.1 processes (`tools/lib/luapool.js`, `tests/lua/pool.lua`; `POLESTAR_PLAY_WORKERS`, default 8): each play in a fresh environment, the addon's and the pack's files parsed once per process. `--honest` (`tools/lib/playtest-honest.js`, no Lua) plays each `next` chain (the main route; a catch-up alone) from the compiled lines and the data only, carrying the log, bags, flight paths and hearth, with nothing free: R1 travel (continent and zone changes, flight paths, hearth), R2 accept (giver at the place, item starts), R3 items (a source near the goal, quest-only drops), R4 NPCs (giver or ender, step titles, several givers), R5 turn-in (objectives credited, the required steps of `data/local/kb/forever-kb.sqlite` when present); `--format json` for agents; exit 1 on any fail |
| `forge guide check <dir>` (was `guidecheck`) | every chain of `.guide` files under `<dir>` (one folder, in file-name order; catch-ups left out) read as the player does, line by line, against the reference data (`rust/crates/forge-guide/src/guidecheck.rs`). It reads the parsed and resolved lines and the data they touch into facts, derives the failures from them by the rules once written as answer set programming (they are stratified, so plain Rust), and gives each failure the cheapest of the repairs it may take (equally cheap ones: a fixed choice). Rules: `itemStart` (an item-started accept before anything gives its item), `useBefore`, `unsourced` (no source in the data or the guide), `bagBefore` (a quest-only drop bagged before its quest is held), `giver`/`ender` (an NPC who does not give or take the quest, or none named when several do), `objective` (a turn-in with a part never worked since the accept), `noAccept`, `travel` (a new zone with no line that moves the player; a capital and its zone are one place), `continent` (no boat, zeppelin, portal or hearth). `--fix` runs the repairs (`guidecheck_repair.rs`; `travel` and `continent` are left to the writer's travel pass in `forge build`): names the NPC, adds the item's source (its best dropper's or object's spawn nearest the route's point, or a vendor), gates a rare start on `when has`, adds a missing goal or accept, copies a later collect before a use, and an order pass (a stable topological sort: every line after the nearest line that gives what it needs, moving no more than 150 lines; a step caught in a cycle is split per goal; a step whose sticky `zone` changed says it again). `--json` |
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
(`rust/crates/forge-addontest/tests/addontest/packs-parity.rs`); our house rules (elites in Leveling guides)
are warnings in other packs.

### Zone art overlays (`maps overlays`)

`forge data maps overlays [--build <ver>] [--offline]` writes
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

`forge data codex [--build <version>] [--out <dir>] [--pack <dir>] [--recordings <dir>]` (the release build;
`--local-extras [--addons <dir>]` adds the local extras)
merges `data/forever/*.json` (pfQuest, QuestieDB facts, recordings,
corrections, web quest list and web XP facts), the Forever client's tables
(wago.tools, cached under `data/sources/wago/<build>/`: the newest 1.60+
`wow_classic_beta` build wago.tools lists, as `data build` picks its
`--forever-build` (`pickBuild` in `tools/lib/data/wago.js`); `--build`
names one; offline or with wago.tools unreachable, the newest cached build
holding every table the Codex reads; `meta.json` records it), the item
sources players' recordings show (`data/codex/recorded.json`) and Polestar's
own guides into
`data/forever/codex/*.json`, then emits the load-on-demand pack
`addon/Polestar_Codex/` (`tools/lib/codex/pack.js`) with its
`LICENSE-DATA.txt`, which lists every source with its version and licence.
Both are build products (gitignored); the pack is part of the release:
`pack` puts it in the zip and fails without it, `install` copies it when
built. A release build reads no installed addon: ForeverLevelingBiS, once an
input, went when its author relicensed it (2026-11); the shipped 0.3.2 Codex
was already built without it.

- Recorded item sources (`codex/recorded.rs`): `data/codex/recorded.json` is a
  committed snapshot of what players' Recorder sessions saw, so every machine
  builds the same Codex; `--recordings <dir>` (the maintainer's local archive,
  or `data/recordings`) rewrites it before the build. Only players that count
  go in, by the data build's own rule (`recordings::read_recordings`: an
  Ingest contributor once established, 3 days of history and uploads on 3
  days; the maintainer's own and vouched-for files always; `config.json`'s
  `minBuild`, `minVoters`), and only facts without who saw them: per NPC or
  object the items its loot windows held (NPC loot from a gathering skill
  left out), with a chance (the median of each player's own share) only
  when `minVoters` players with 10 loot windows each back it; per NPC its
  merchant window's items (which also gives it the `vendor` and `sells:*`
  roles); per quest the reward list most players' accept windows showed
  (`trusted` when `minVoters` agree). Provenance `recordings`, ranked first.
  A trusted reward list stands in for the web quest lists' for that quest;
  an untrusted one only fills a quest no other input gives rewards for.
- Curated vendors (`curated_vendors`): in a guide that `collects` an item,
  each `buy <item> ... npc <id>` step is a vendor source (provenance
  `guides`), whatever races the step is for: the Forever-only racial mounts
  (the Reins of the Striped Dawnsaber, the White Kodo, the Black Skeletal
  Horse) have no vendor in the quest data.
- Release-safe by default. `--local-extras` also merges three inputs that
  may not be redistributed: AtlasLoot (GPL-2.0, incompatible with
  Polestar's GPL-3.0-only), RareScanner (All Rights Reserved) and
  `data/forever/dungeons.json` (DungeonJournal, no licence). That build's
  `meta.json` and `Meta.lua` carry `localExtras = true`, its
  `LICENSE-DATA.txt` says not to share it, and `pack` refuses it, as it
  refuses a pack whose sources name any of the three
  (`releaseRefusal` in `tools/lib/codex/pack.js`). It exists for comparison
  on the developer's machine.
- Importers for `--local-extras`, one per installed addon, all reading through
  `rust/crates/forge-data/src/gear/addonlua.rs` (`read_addon_lua`,
  `addon_version_in`: the installed addon's files run sandboxed in Lua 5.1
  with the namespace the client passes them): `codex/atlasloot.rs`
  (DungeonsAndRaids incl. `forever.lua` and `droprate.lua`, Collections,
  Crafting, Factions, PvP) and `codex/rarescanner.rs` (rares, their loot,
  treasures, mount and pet items). Each returns plain JSON with a `meta`
  naming its source, version and licence.
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
  drops at 1% or more or at an unknown rate, and its web database drops outside
  the world-drop pool at any rate (Thermaplugg's schematics, Dextren Ward's
  plans); then the web database's `commondrop` rows (world books, world blues) at 1%
  or more, so those no longer crowd out a boss's own loot (Onyxia's Sacks
  of Gems); each part best chance first. The entrance (`chooseEntrance`): a recorded one
  (Recorder `enter`, `data/forever/instances.json`), else the curated table
  `data/codex/entrances.json` (per instance key: the point on the zone
  map where one walks in, `{ key, instance, map, x, y, source, note }`, each
  with its public source, checked against the corpse point and our guides'
  gotos; every dungeon and raid in the Codex, Forever's own included, from
  QuestieDB's Forever dungeon table, warcraft.wiki.gg and Forever's quest data),
  else a guide's `goto x,y "<instance name> ..."`, else the `Map` Corpse
  point (where a ghost comes back: near the way in, not at it; the
  Deadmines' is the portal deep in the Moonbrook mine, 200 yd from the
  Defias Hideout one walks in at) on the zone holding it, marked
  `approx: true` (packed as a fifth entrance field `a`, read as
  `Codex.Instance(key).entrance.approx`). `AreaTrigger` rows name no instance
  and the trigger nearest a Corpse point is as often an inn or city trigger,
  so they are not used. Every
  NPC placed in an instance (`npcs.json` `instances`, from QuestieDB and
  recordings, or the web database's `location` naming an `AreaTable` area of the
  instance's map) belongs to it: its drops carry the instance. An instance's
  boss or mob the data ranks rare is not a rare unless RareScanner lists it.
  `--local-extras` takes the instances from AtlasLoot and `dungeons.json`
  instead.
- Forever's web data per entity (`tools/lib/codex/web.js`, release build
  only, lowest precedence). `codex build` reads the Forever web facts
  cached under `data/sources/web/codex/`, and builds without them when
  there are none. The cache holds the NPC, object
  and item list rows by id range (`lists/<type>.json`: id, name, levels,
  classification, boss flag, `location` and `envChange`, how Forever differs
  from Classic) and each fetched entity's facts
  (`<npc|object|item|spell>/<id>.json`). `codex build` reads the NPC rows
  for one fact only: the level of an NPC neither our data nor a page gives
  one (286 NPCs); a row's rank, boss flag and place are no page's, so rares,
  bosses and parity's verdicts read only pages. From the pages: an NPC's
  level, rare rank and spawns where ours lack them (and the rares only
  the web data places), drops and object contents with chance = looted count /
  looted kills, an NPC's or object's `location` (the areas its page entry
  names) and the web data's boss flag, and the reputation ("Requires <Faction> -
  <Standing>") and PvP rank ("(Rank N)") an item's Forever tooltip asks for.
  An instance also lists, after
  its encounters and by level, the NPCs placed inside that the data or
  the web data ranks rare or boss (or flags boss), or that alone drop an item of
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
  the cited table `data/codex/attunements.json` names per Codex instance
  each attunement's goal only (the quests that end it, one of them with
  `any`, or the key item), whether everyone entering needs it or one in the
  group, and our one-line note, each entry with its public sources (Forever's
  quest data, warcraft.wiki.gg). The steps come from the Codex: every
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
  its Forever quest data entry (Marshal Windsor, the Monument of Franclorn
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
  internal build names that Forever's web data confirms, for about 215 KB of
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
  (with `pre` = every blocking prerequisite, `preAny`, rewards from recordings,
  the curated tables and the web quest lists, `xp` = the full XP reward from `data/forever/quests.json`
  where known (what a guide or dungeon is worth in levels: Core/Levels.lua),
  and `web` on each quest Forever's zone,
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
  sources place outside every instance (the web data's `location` or spawns off the
  instance maps' areas: Techbot, Maraudon's Desolace caves) or rank an
  ordinary NPC (no web boss flag, not rare, no green or better item
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
  different (QuestieDB's Ironforge 27.6,47.8, where players'
  reports put the quest givers near the entrance, against 43.5,52) until
  a recording settles it; AtlasLoot's extra bosses (the Ring of
  Law's fighters, rare spawns, chests) are not `DungeonEncounter` rows;
  reputation standings that vendors gate in gossip, and battleground rewards
  AtlasLoot files as PvP, are in no client table (`ItemSparse` carries no
  `MinFactionID` or `RequiredPVPRank` for them, and Forever's web data Sells
  standing is that same `MinReputation`). A vendor's, giver's or quest's gate
  comes from the cited table `data/codex/repgates.json`
  (`loadRepGateTable`, provenance `curated`: rows `{ item, name, faction,
  standing, npcs: [vendors or givers] | quest (+ choice), source, note? }`,
  one per item and faction, each citing warcraft.wiki.gg, else classic
  reputation guides or QuestieDB; the Alterac Valley and Warsong
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
  Forever's spell data in the cache) hands it out: a `gift { npc,
  spell }` source (Duke
  Hydraxis's Aqual and Eternal Quintessence). 26 Forever rares no
  database ranks yet. The 251 confirmed drop chances the release lacks are
  all cut by an item's 10-dropper cap (the internal build keeps AtlasLoot's
  instance trash past it; every dropper of every item would be 1.6 million
  sources against 74 thousand).

### Reference data (`data/forever/`, built by `forge data build`, gitignored)

```
quests.json   { "<id>": { id, title, level, minLevel, races, classes, start: { npc: [], object: [], item: [] },
                          end: { npc: [], object: [] }, pre: [ids], excl: [ids], next, objectives: [
                          { type: "kill"|"item"|"object"|"event"|"talk", id, count, text } ], objectiveText, zone, xp,
                          rewards?: { items: [ids], choices: [ids], money }, source: [] } }   (rewards: recorded only;
              count: the objective text's, else pfQuest's, else CMaNGOS classic-db quest_template's for the same id or the
              quest's one objective of that kind, else null; rust/crates/forge-data/src/merge.rs)
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
              CharBaseInfo; written only when those tables are cached; see rust/crates/forge-data/src/factions.rs)
spawnz.json   { npc: { "<id>": [[instanceMap, x, y, z], ...] }, object: { ... } }   (CMaNGOS classic-db creature and
              gameobject spawns on maps 0 and 1, UnitPosition's frame (x north, y west), 0.1 yd, each id's spawns sorted;
              one id per line; the compiler's goal `z`, tools/lib/dsl/heights.js; left out, with one warning, when
              --offline has no cached dump; tools/lib/travel/cmangos.js loadSpawnHeights)
moves.json    { npc: { "<id>": [[instanceMap, x, y, cx, cy, r], ...] } }   (CMaNGOS classic-db: each creature spawn on maps
              0 and 1 that walks, its random movement within `spawndist` or its waypoint path, by spawn (`creature_movement`)
              else by creature (`creature_movement_template` path 0): the spawn's x, y, then the centre and radius in
              yards of the ground the walk covers; walks under 20 yd left out; one id per line; a goal at an NPC
              whose spawn walks there gets the walk as its spawn spot, forge-guide walks.rs, and the writer's
              "walks around" note)
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
Codex), except the ones that mark where an entity spawns, which read `pts` and
`more`, every known spawn: the guide compiler's spawn areas and near-spawn lint,
QuestDB's marker clusters and the profession generators' node and farm routes.

Gathering nodes (objects with the `herb`, `mine` or `fishing` role) also take the
Forever TrinityCore world DB's sniffed spawns (VerifiedBuild >= 70000) that no
other source has, in every `data build`, not only the knowledge-base stage: the
nodes of Forever's new zones (Zephras Isle's Copper Veins and herbs) and nodes
Forever moved. Add-only (a sniff covers a few maps, so a node it does not show is
not gone); a sniffed spawn within 10 yd of one we have is that one; placement as
the knowledge base places sniffed spawns, never on a system map
(`rust/crates/forge-data/src/place.rs`). The TDB is read through its cached extract
`<sources>/forever-tdb/extract.json` (re-extracted from
`data/local/forever-tdb/world.sqlite` or `$FOREVER_TDB` when that changed); without
either, the build goes on without it, and meta.json credits it only when it added
something.

`dungeons.json` is built by `forge data dungeons` (`rust/crates/forge-data/src/dungeons.rs`)
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

`professions.json` is built by `forge data professions` from the Forever client's
DB2 (`wow_classic_beta` 1.60+ via wago.tools: SkillLine, SkillLineAbility,
SpellName, SpellEffect, SpellReagents, ItemSparse, Item, ItemEffect,
ItemXItemEffect, ...; `tools/lib/professions/tables.js`). Forever changed
recipe thresholds, reagents and names from Classic (issue #109), so Classic
Era only fills gaps: a table wago.tools has no Forever export of (SpellTotems,
SpellCastingRequirements, SpellFocusObject) comes whole from the newest Era
build, and the spells and items the Forever tables lack come from Era's rows.
Each profession also carries `mainTrainer { Alliance,
Horde }`, `trainerSkill { npcId: skill }` (the skill a trainer's "Train me." option asks for, from
the world DB's conditions on its trainer menu option, the extract's `professionTrainerSkill`: Doctor
Herbert Halsey trains Alchemy from 125, a city trainer such as Yelmak from 50; the guide compiler's
`train` and `learn` goals leave out a trainer whose skill is above the rank's `minSkill` or the
recipe's `learnedAt`, #1708) and `materials { itemId: { name, buy, buyCount, sell, quality,
vendors { A, H }, limitedVendors { A, H }, currencyVendors { A, H }, bop, madeBy, gather { herb, mine, fishing },
drops, dropCount } }` (`bop`: the client's ItemSparse binds it when picked
up, so the Auction House never has it; `currencyVendors`: the world DB's sniffed vendor rows with an
extended cost, which sell for a currency such as Merchant's Favor rather than gold, and a recipe
whose item only they sell has `source: "currency"` and no `cost`); ranks carry `minSkill`, `spell`, `trainers { A, H }`, `cost`
(copper, the sniffed trainer lists' price of the spell that teaches the rank; the rank's
`trainers` also gain every spawned creature whose sniffed list teaches it, such as Zephras Isle's) and,
for secondary skills, `book`/`quest`; recipes may carry `enchant`,
`learnedAtEstimated`, `learnedAtFrom`, `requires` (specialisation), `reputation { faction,
standing }`, `tools`, `focus`, `races`, `classes`, `skillUps`. A trainer recipe's
`learnedAt` and `cost` come from the Forever TrinityCore world DB's sniffed
profession trainer lists (the extract's `professionSpells`: the lowest skill and
price any sniffed list asks), when one teaches it (a sniffed list beats a recipe item for the
same spell: Elixir of Minor Fortitude) and the client does not give it
with the skill (`AcquireMethod` 1); else the skill seen on Forever, for the few recipes in
forge-data's `CHECKED_LEARN` (`learnedAtFrom`: `"in-game"` a player's trainer window, Thick Leather,
Cured Thick Hide and Thick Armor Kit at 175, #1553; `"recordings"` the skill players learned it at,
Forever's leather armor and pants patterns 5 below their yellow, Magenta Dye 120; `"classic"`
Classic's list where Forever kept the colours and no world DB list has it, Goldthorn Tea 175); else,
when an older (Classic) list in the same DB teaches it (`professionSpellsClassic`: the highest skill
any Classic list asks, as CMaNGOS's; a stray low list put Thick Leather at 155, #1553), Classic's
learn skill moved by as much as Forever moved the recipe's yellow rank from Era's
(`learnedAtEstimated`, `learnedAtFrom: "classic"`, no `cost`: the sniffed lists keep Classic's
learn-to-yellow distance on 126 of the 129 recipes they share, but not its prices); else
`learnedAtEstimated` (the yellow rank). `HOTFIXES` carries what an official hotfix changed after the
client tables (`learnedAtFrom: "hotfix"`: the Tanning Rack at 125, yellow 125, grey 130).
Season of
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
table is cached; the timed-item lint reads it). An NPC a client spell summons (the Forever
client's SpellEffect SUMMON rows: the camp Reagent Bot and Repair Bot, Field Repair Bot 74A) is
no vendor: it has no `vendor` or `repair` role and is in no item's `vendors`, since its sniffed
spawns are camps long gone. A drop chance is `null` when QuestieDB lists the
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

#### Validation (`rust/crates/forge-data/src/stats.rs`)

A data build can go wrong silently. Without `data/sources` beside `data/forever`, for example,
the compiler has no AreaTable: every `{area:N}` name token becomes an object (Sentinel Hill,
`{area:108}`, became `{object:81}` in every Westfall guide), and nothing failed. So each build
is checked against the last good one's field statistics before it replaces the data:

- the counts of quests, NPCs, objects, items and zones; the share of quests with a giver and
  with an ender, whose giver and ender ids and objective ids the data has, whose NPC giver
  spawns on the quest's zone map; race- and class-limited quests and the quests per race mask;
  NPCs and objects with spawns;
- the AreaTable rows the compiler gets from `data/sources`;
- what the sim's leveling reads: quests with a reward spell, quests with XP and their XP added
  up, the quest XP values the knowledge base changed, our corrections applied, class training
  rows, riding trainers and mount vendors;
- our guides compiled on the build: name tokens per kind (`{area:N}`, `{object:N}`...),
  errors and warnings, and the share of the tokens the deDE names addon names.

`forge data build` writes the build to `<out>.staging/` (the new files over links to `<out>`'s other
entries), computes these, and compares them with `<out>/stats-good.json`. A shift past a field's
limit (counts ±2%, shares ±0.02, tokens per kind ±5%, AreaTable rows ±1%, the XP sum ±0.5%,
KB XP changes ±5%, any new compile error, any change in corrections or riding) stops the build:
`<out>` is left as it was, the report names the fields, and the new
build stays in `<out>.staging/` to look at; `--accept` takes it when the change is intended.
A good build replaces `<out>`, and its statistics become the last good ones (`stats.json`,
`stats-good.json`; neither is a world input). `data check` compares the data as it is, read as
the compiler reads it, against its last good statistics (exit 1 on a shift; `--accept`
blesses them). Run in a copy without `data/sources`, it names `sources.areas` 1375 → 0,
`tokens.area` 4385 → 0 and `tokens.object` 790 → 1518.

#### Sources and precedence

`data build` reads, lowest precedence first:

1. **pfQuest** (MIT, git clone cached in `data/sources/pfQuest`): Classic Era
   quests, npcs, objects, items, drop chances, Era-frame coordinates.
2. **QuestieDB's Forever store** (`questie-forever`): the `QuestieDB_Forever.toc`
   that Questie for Forever installs. `--questie <dir>`, else auto-detected in
   the Forever client the way `install` finds it (client detection lives in
   `tools/lib/addons.js`: `detectAddonsDirs`, `foreverKind`). It's read in place
   (`rust/crates/forge-data/src/questie.rs` ports QuestieDB's `src/meta/codec.lua`,
   `src/read/baked.lua` and `normalize.default`). Field layouts come from the
   installed `src/meta/*Meta.lua`, and support data from `support/Forever/*`:
   QuestXP, DropTables (chance = manual correction, else cmangos, else
   the web database, as `DropDB.GetItemDroprate`), Zones (AreaID → UiMapID). It adds
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
3. **Forever's change notes** (`rust/crates/forge-data/src/extras.rs`,
   `--no-web-zones` skips them, as does a build without QuestieDB): the quest
   list of every zone and city page and of the nine class pages (class
   quests are filed there, not under a zone) of Forever's quest data, read from
   `data/sources/web/zones.json`; without that cache this step adds
   nothing. A quest the list marks updated with "Experience
   X instead of Y", "Level X instead of Y" or "Requires level X instead of Y"
   gets X where its value is still the old Y (for XP, also where it has none),
   and one marked "Renamed from Y" gets Forever's name where its title
   is still Y (Chastise, formerly A Lack of Fear); any other value is left
   alone, and the quest's `source` gains `web:xp`, `web:level`,
   `web:minLevel` or `web:title`. Only rows whose category is the
   zone's area count: the web database answers an unknown zone path with a generic list.
   Its Forever database also lists datamined quests that are not live (`<NYI>`
   placeholders, Season of Discovery leftovers), so presence there is not
   evidence that a quest is in the game.
4. **Polestar corrections** (`forever-db/corrections/<section>.json`, committed):
   facts QuestieDB or pfQuest get wrong or lack, each with the independent
   evidence for it in `source` (`{ kind, ref }` or a list; kind `recording`,
   `in-game-check`, `client`, `eg`, `cmangos`, `tdb`, `questie`, `pfquest` or
   `factoruide`, `SOURCE_KINDS` in `forge-data`'s `corrections.rs`) and what it
   fixes in a `note`:
   quest fields (`set`), item sources to drop (`removeDrops`, `removeVendors`) or
   add (`addDrops`, droppers every source missed, with no rate),
   npc/object fields (`set`: the Forever elite and rare ranks QuestieDB's
   Forever store lacks, since it gives every Forever npc rank 0, and renamed
   Era records) and npc/object spawn maps (`addSpawns`). A fix whose only
   support is a source we don't publish lives in the private overlay
   `data/local/corrections-private.json` (same shape, not in the repository),
   which `data build` merges over the public file entry by entry when it is
   there (`--corrections-private <file>`, `--no-corrections-private`). The
   build prints `private corrections: N applied from <path>` or `private
   corrections: none found (public corrections only)`, the latter as a
   warning when the web quest-list cache or `data/local/kb` or
   `data/local/factcheck` is present, and records N in `meta.json` counts
   `correctionsPrivate`. They are
   applied after the merge, only in a build that reads QuestieDB, and the
   record's `source` gains `polestar-correction`. One
   cleanup is general rather than per quest: `pre`, `preAll` and `preAny`
   never contain the quest itself or an id from its `excl`. QuestieDB
   preQuestSingle sometimes lists the whole exclusive group.
5. **Recordings** (`data/recordings`), which win over all of the above;
   finds (rares, kills, loot, treasures, instances; "Recordings" below) follow
   the rules of their own paragraph there.

`source` on every quest, npc, object and item lists its contributors in
that order: `pfquest`, `questie-forever`, `web:*` (change notes), `polestar-correction`, the web XP tag, `recorder` (a record only recordings have), then the recordings' per-field tags: `recorder:<field>` (a field trusted recorded evidence set or confirmed; `recorder:xp-*` for XP) or `recorder-gap:<field>` (a gap one counted player filled). The knowledge base labels a field `recorder` (tier 0) only by its own `recorder:<field>` tag or the whole-record `recorder`; `recorder-gap:<field>` is `recorder.gap`, which backs nothing in the public tier.

#### Knowledge base (`rust/crates/forge-data/src/kb.rs`, `data/local/kb/forever-kb.sqlite`)

After the merge above, `forge data build --kb` runs the knowledge base (without
`--kb` the stage is skipped). It reads every source's value of each
fact, picks one by a single precedence, writes the winners back into the
tables, and only then are the files serialized. So data/forever is the
KB's choice, and a fact no source changes stays byte-identical. The KB
itself is a local SQLite file: `facts` (kind, id, field, value, source,
confidence), `alternatives` (the other sources' values, `agrees`), typed
tables `quests`, `objectives`, `givers`, `npcs`, `objects`, `items`,
`spawns`, `drops`, `vendors`, `trainers`, `training`, `mechanics`, `steps`,
plus `verify_in_game` and `changes` (every field it changed in data/forever,
old and new value, deciding source).

Precedence, lowest tier wins, one order for every fact kind:

| Tier | Source |
|---|---|
| 0 | Polestar recordings and corrections (`corrections.json`, hand-verified) |
| 1 | Forever TrinityCore world DB, sniffed rows (VerifiedBuild >= 70000: advocaite/TrinityCore `forever` plus the Sakhwoow/WoWForever 2026-10-20 sniffs; `rust/crates/forge-data/src/tdb.rs` reads `data/local/forever-tdb/world.sqlite`) |
| 1 | `client`: the installed Forever client's tables with the server's hotfix rows (DBCache.bin) applied, for what the game draws from them only: quest map areas (`start_place`, `end_place`, `objective_place:<n>`), area triggers of event objectives (`objective_trigger:<i>`), QuestV2 (`in_client`: the quest exists; never a removal), item names, durations, start quests and the quest-item class, placed game objects (`placement`) |
| 1.4 | EG Link output: observed turn-in XP |
| 1.5 | EG Link output (JIVESCORP/eg-link-output-wowf, CC BY 4.0): players' game caches, the server's quest answers (`rust/crates/forge-data/src/players.rs`); captured in-game XP (ForeverDB, Factoruide's collector) ranks here for XP only |
| 1.5 | `client.cache`: the installed client's own WDB caches, the same server answers (quest title, levels, XP from QuestXP x the multiplier, races, objectives; NPC name, subtitle, rank; object name), read like an EG record |
| 2 | the web quest-database pages (givers and enders: it wins over QuestieDB and Factoruide) |
| 3 | ForeverDB: seen data, game cache, vendors, captures; forever-vo dialog captures (`rust/crates/forge-data/src/players.rs`) |
| 4 | QuestieDB (Questie-Forever) |
| 6 | Factoruide |
| 6.5 | web verdicts (`data/local/mechanics/web-verdicts.json`) |
| 7 | CMaNGOS, VMaNGOS, the TDB's inherited rows, ForeverDB's Classic reference |
| 8 | pfQuest |

The web quest-database pages, ForeverDB and Factoruide come from the fact check's
`data/local/factcheck/facts.sqlite` when it is present; every local source is
optional. Rules on top of the order:

- A missing value is filled from the best source that has one, whatever its tier.
- Classes and races change only by tier <= 1.5 (the server's own answers),
  positions and NPC sides only by tier 1. Every other disagreement on class,
  race, side, position or visibility (Factoruide's "removed") goes to
  `data/local/kb/verify-in-game.json`, grouped by entity and ranked:
  quest-relevant entities of the sim's v2 worlds first.
- What players saw (EG, forever-vo, ForeverDB's seen data, the collector)
  adds givers and enders but never removes one; the sniffs, the page and
  corrections replace a list. A quest both factions share never loses the
  other faction's NPC. A giver without spawns is not applied (verify list).
- XP within max(5 XP, 3 %) of a capture or game cache is the same value. The
  page's XP (and Factoruide's, which copies it) lowers ours only when an
  independent source agrees: its dungeon, battleground and repeatable XP is
  often the pre-change or level-capped value.
- Placeholder text (`<NYI>`, `[UNUSED]`, "Reuse Me") never wins; titles change
  only by tier <= 3; levels and XP of 0 count as missing.
- Confidence: high = tier <= 1, or two sources agree; medium = one source of
  tier 2-4; low otherwise.

The TDB also gives (gap fills only, unless sniffed): objective counts, `next`,
`pre` (sniffed PrevQuestID where a quest has no prerequisite data), quest
`limit` (TimeAllowed, seconds), quest `rewardSpell` (the spell the turn-in grants:
RewardSpell, else RewardDisplaySpell1), sniffed spawns of Forever-only NPCs and objects
(ours replaced when none lies within 300 yd of a sniffed spawn, else the
sniffed spawns without a point of ours within 40 yd added; `spawnz.json` gets
their heights), sniffed drop rates (a sniff's k of n kills shrunk towards the
default with 2 kills at it; placeholder rows never), the TDB row's own rate for a
dropper an item's server-scale table leaves unrated (`dropScale` server or none:
Red Leather Bandana's Defias Trappers), new spawned droppers of
quest items, class trainers our list lacks (`trainers.json`) and the sniffed
class lists' cost per level (`training.json`). EG and the client's caches give
`next`, objectives for quests with none and quest-tied drop rates (EG) the same way.
`forge data build --kb` reads the client found (`--wow`, `--product`) unless
`--no-client`; `--client-cache DIR` and `--client-tables DIR` (table CSVs) name
other folders. The release build never reads it.

`data/forever/mechanics.json` ({ schema, sources, quests: { id: { kinds,
params, server, steps, gotchas } } }) holds the quest mechanics
(data/local/mechanics, checked against the TDB layer and the web verdicts).
A kind, parameter or step `drives` routing only when it is of high confidence
or two independent source groups agree (page reading, CMaNGOS chain, our data,
TDB, web); a step drives when it is high and structured, or its kind is
confirmed by two groups. The rest, and every gotcha, are tips. The sim world
reads the driving ones (`limit`, `mech`, summon and use-at-place work points).
Tier 0 applies last: `data/mechanics-public.json` `corrections`, by quest id, replaces or
adds `params` (same kind and item) and sets fields of `steps` by number; both
then drive. One kind exists only there so far: `delayed-offer` { after, npc,
sec }, a giver who offers the quest about `sec` seconds after `after` is
handed in (a scripted scene), so a route can fill the wait elsewhere.

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
Forever's "Experience X instead of Y" notes applied where it still has the old
value (above). corrections.json `xp` replaces both: Forever about doubled the
XP of many dungeon quests, and QuestXP still has the Classic value for some
(issue #394), so those take the XP shown by in-game evidence dated after the
1 October 2026 change that halved dungeon quests' extra XP (build 70170; a
client's quest cache gives difficulty and multiplier, its XP is QuestXP ×
multiplier, while web databases built from the DB2s give only the Classic
base), or an undated capture at the dated post-change rate (XP / base) of a
quest in the same dungeon: the extra XP was twice as much before the change,
so such a value can't be a pre-change one. Then, for quests
still without XP, the Forever web databases
(`--no-web-xp` skips them; results are cached in
`data/sources/webxp/quest-xp.json`): the Forever client's quest cache (tag
`webcache:xp`), else Forever's quest chain data (the quest's reward,
`webdb:xp`, or its quest-chain list, `webdb:xp-chain`), else
the XP on Forever's zone quest list
(`web:xp`). `meta.counts` gives `questXpFromWeb`, `questXpFromWebZones` and
`webZonesChanged` ({ xp, level, minLevel, title }).

### Recordings (`data/recordings/<session>.json`)

What the Recorder collects, its SavedVariables, chunk and record format, the
upload API and the trust rules are the contract in
[docs/RECORDING.md](RECORDING.md) (schema 2). The library that reads it is
`rust/crates/polestar-recording` (shared by the Polestar Client, the ingest server and
forge; `forge record import` (this PC's game: every account of every Forever
install, or `--wtf <path>`) and `forge record pull` (the server's
`GET /v1/export`, after the last line in `data/recordings/.pull-state.json`)
archive every chunk per contributor as
`data/recordings/raw/<contributor>/<install>/<seq>.txt` (with `install.json`
beside it: the contributor owning the folder and the install's map table; a
pulled line whose folder names another contributor is skipped), then normalise
every (contributor, install) that got a chunk again from its whole archive
(`normalize::sessions`). One contributor claiming another's install id lands in
its own folder and its own sessions. A session is the consecutive chunks of one
(contributor, install, character id) with gaps under 30 minutes; a session file
the new normalisation no longer has (a late chunk joined two sessions) is
removed. Imported text has the account's character names replaced with `$N`.
A `Polestar_Recorder.lua` outside this PC's own game folders (a file a player
sent in) needs `--vouch <name>` (contributor `sent-<name>`, the name the
maintainer's choice) or `--anonymize` (contributor `anon-<16 hex digits of the
install id's SHA-256>`). Pull reads export pages until one comes back empty
(the server ends a page at 1,000 lines or 8 MiB). `.pull-state.json` keeps the
export's `instance` (the server database's id): when it changes (a restored
or recreated database) pull says so and starts again from the first id
(archived chunks are deduplicated). Pull then fetches `GET /v1/export/tombstones` since the
last one purged and moves those contributors' archives to
`raw/.purged/<UTC date>/<contributor>/` (deleted after 30 days) and removes their
sessions. Server contributors first seen more than `expireDays` (config.json,
default 30) days ago that are still not established are quarantined the same
way; a chunk that would take one contributor's archive past `maxContributorMB`
(default 200) is skipped and reported. Last,
with everything on disk, pull sends `POST /v1/export/ack` with the last id it
pulled; the server deletes chunks up to there once they are past its retention
(the server is a buffer, `data/recordings` the archive). Pull refuses an
`http://` server other than localhost, times its requests out and caps answer
bodies (16 MiB an export page). `.pull-state.json`, `raw/contributors.json`,
`install.json` and chunk files are written whole (a temporary file renamed);
one that exists but doesn't parse stops the pull. A
folder of the older layout (`raw/<install>/`) is moved under its contributor
(an old `sent-<16 hex>` becomes `anon-<16 hex>`) and its sessions rewritten.

```
{ schema: 2, session: "<YYYYMMDDTHHMMSSZ>-[<contributor>-]<install>-<charId>",
  contributor, install, charId, [cohort, received, contributorSince, contributorChunks, uploadDays,]
  build, interface, locale, region, ruleset, versions: { recorder, polestar },
  packs: [ { id, version } ], guide, char: { id, race, class, faction, sex, level },
  started, ended, chunks: [seq], events: [ { t, e, ...fields } ],
  maps: { "<uiMapID>": { type, parent, c, left, right, top, bottom } } }
```

No names, realms or account names: `char.id` is the addon's random character
id. `contributor` is `local` for the maintainer's own imports (the session id
then leaves it out), `sent-<name>` or `anon-<16 hex>` for files sent in, else
the server's contributor id, with its registration `cohort` when the server
exported one (the data build counts players by cohort). `t` = seconds since
`started` (one decimal); `map`, `x`, `y` = uiMapID and percent (two decimals).
The kinds and fields keep schema
1's names where the meaning is unchanged, so the data build, the travel build,
the trainer list, `forge sim calibrate` and `record report|draft` read both
schemas (records -> events):

- `accept {q, title, npc|object|item, map, x, y, lvl, rewardXp, rewardMoney,
  items: [id], choices: [id], itemCounts, choiceCounts}` (`title` from the
  character's `text` record of the quest), `turnin {q, npc|object, map, x, y,
  lvl, xpReward, money, chosen}`, `progress {q, oi, cur, max, map, x, y, type,
  text}` (`type` and `text` = "<objective>: cur/max" from the `objectives`
  record), `complete {q}`, `abandon {q}`, `level {lvl, map, x, y, played}`,
  `zone {map, x, y, zone, subzone}`, `pos {map, x, y, flags, speed (yd/s),
  mounted, swimming, indoors, flying, falling, dead, trail}`, `death {map, x, y,
  killer, killerLvl}`, `revive {map, x, y, how}`, `combat {on, map, x, y}`,
  `afk {on}`, `mark {text, map, x, y}`, `taxi {fromNode, toNode}` (node ids
  now), `fp {npc, map, x, y, node, known: [node]}` (the `flightmaster` record),
  `bind {npc, map, x, y}`, `trainer {npc, map, x, y, services: [{ spell, cost,
  reqLevel, state, name }]}`, `vendor {npc, map, x, y, items: [{ item, price,
  stack, qty }]}`, `gossip {npc|object, map, x, y, option, optionText}` (an
  option chosen; schema 1's gossip window is `offer` now), `rep {faction,
  standing, value, delta}`, `skill {skillLine, rank, max}`, `explore {areaID,
  xp, map, x, y}`, `learn {spell}`, `craft {spell, item, count}`,
  `achieve {id}`.
- Finds: every creature killed is a `kill {npc, npcLvl, cls, map, x, y, xp,
  rested, denied, q, oi, inst}` (schema 1's `slain` and quest `kill` in one;
  `cls` normal, elite, rare, rareelite, worldboss), every loot window a
  `drop {npc|object|item, gather (herb, mine, skin, fish), items: [{ item,
  count, q, oi }], wanted: [{ q, oi }], map, x, y, inst}` (an item's `q`/`oi`
  when an item objective ticked within 3 s, which also adds a schema 1 style
  `loot {item, count, q, oi, map, x, y}`), `unit {npc, npcLvl, cls, react, src,
  map, x, y, inst}`, `rare {npc, npcLvl, cls, src, map, x, y, inst}`,
  `treasure {object, map, x, y, inst}`, `enter {inst, instType, difficulty, map,
  x, y}`, `encounter {enc, ok, difficulty, size, inst}` (`inst`: the instance
  entered last, until a record has a position again).
- New: `session {lvl}` (login, reload, each chunk), `xp {xp, xpMax, rested}`,
  `dropped {count}`, `ride {on, map, x, y}`, `land {node, seconds, map, x, y}`,
  `rest {kind, seconds}`, `offer {npc|object|item, map, x, y, available, active,
  log, done, notOffered}`, `detail {q, npc|object|item, map, x, y, startItem}`,
  `text {q, title, objectiveText, detailText}`, `objectives {q, objectives:
  [{ type, max, text }]}`, `cast {spell, item, map, x, y, targetNpc|...}`,
  `escort {q, on, map, x, y}`.
- Route telemetry: `step {guide, step, reason, how, map, x, y, lvl, xp, xpMax,
  rested, combat}`: `how` is the record's reason, `reason` what `record report`
  reads (`done` -> `complete`, `pick` -> `guide`, else `step`); `lvl`, `xp`,
  `xpMax`, `rested` and `combat` are the latest `session`/`level`/`xp`/`combat`
  records'.

The data build's overlay (`forge-data/src/recordings.rs`) leaves out sessions
whose `build` is older than `data/recordings/config.json`'s `minBuild`, and
every session whose player doesn't count. A player (voter) is the server's
cohort, resolved per contributor from its latest session, else the
contributor. `local` and `sent-*` always count, `anon-*` never does, and
neither do the contributors `config.json`'s `exclude` lists (the maintainer's
audit of manipulated or suspect uploads; they also never make their cohort
count). A server
contributor counts once established: first seen at least `minContributorDays`
(3) days before its newest session arrived, `minContributorChunks` (20) chunks
on `minContributorUploadDays` (3) distinct upload days as the server counted
them (`uploadDays`; the client's own session times count for nothing), and at
least `minContributorPos` (10) positions and `minContributorKills` (5) kills.
Every value a recording writes goes through one rule. A quest's title, level,
givers, enders, objectives (count and order), rewards and XP, an NPC's name,
level, rank, roles, instances and encounter, a spawn, a drop chance, a
trainer's class or a learned walking path (`travel/paths.rs`) changes another
source's value only on trusted evidence: `minVoters` (config.json, default 3)
distinct counted players, or `local` or `sent-*` recordings (for a drop
chance, each with 10 kills of their own). A gap no source fills is filled by
any counted player. Where players disagree, the value most of them back wins;
a number is the lower median of each player's own value (an objective's
count: the highest each saw). New quests, NPCs, objects, items, factions and
zones come only from `local` or `sent-*` recordings. Names from a session
whose locale is not enUS only fill a missing name. Recorded map bounds are
used only from `local` recordings and only for maps `map-frames.json` lacks
(`travel/paths.rs` `live_frames_of`); walks are placed by those frames, never
by a recording's own. Schema 1 sessions (no contributor, no locale) count as
`local` and enUS. Our corrections stay the last word: the overlay puts every
corrected value back when it is done (`corrections::reassert`), whatever the
recordings' evidence, and the build warns with each value the recordings
disagreed with; the knowledge base ranks `correction` (0) above `recorder`
(0.5). `forge record resession` normalises every archive in `raw/` again, for
record kinds an older forge skipped.

`record trail <session|file> [--out file.json]` writes a session's `/psrec
trail` runs as `[{ label, start, end, reason, points: [{ t, map, x, y, speed,
mounted, swimming, falling, indoors, flying }] }]`: the `pos` events with
`trail` (flag 64) between a `mark` "trail on: <label>" and its "trail off:
<label> (<n> points, <yd> yd, <reason>)".

Schema 1 (the Recorder before the recording program) wrote whole sessions with
the character's name and realm; its JSON (`{ schema: 1, build, session, char:
{ name, realm, race, class, faction }, started, ended, events, maps }`) is still
read by the data build and `record report|draft`; nothing writes it any more.

The Recorder window (`Panel.lua`; `/psrec ui`, Polestar's Options > Recorder
and its guide menu; drawn with Polestar's Theme and Widgets when Polestar is
loaded, else the game's templates) turns recording on and off, starts and
stops a trail (also the key binding "Recorder: trail on/off", `/psrec trail
toggle`), marks a point, lists this session's trails
and has Save now (a /reload). Its spot list is `Spots.lua`, generated once
from the maintainers' trail list (spots up to level 30, in each faction's tour
order); the label box offers the first spot not done that the player's level
allows, and a trail whose label is a spot's label, or starts with `#<id>`,
ticks it in `PolestarRecorderDB.spots` (`{ [id] = epochSeconds }`) when it
stops with at least one point. The window's place is `PolestarRecorderDB.panel`.

#### Measuring routes

Recording is off until turned on (`PolestarRecorderDB.enabled == true`, set
by `/psrec on`, Options > Recorder, or Polestar Client's share flag, which is
on by default in the client unless the player stops sharing or typed
`/psrec off`, docs/RECORDING.md "Ack file"); while it is off the Recorder writes nothing, not even a
session. Testers turn it on, play with Polestar, run `forge record import`
(or `forge record pull` for the server's), then `record report [--guide <text>]
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

`node tools/polestar.js planner [<pack dir>...] [--port 8078] [--nav <dir>] [--guides <dir>]` serves a local
page (127.0.0.1 only) that plays a guide route on the game's map and edits its
`.guide` sources. Inspired by Nivek_Gaming (@Nivek_Gaming on X), whose idea
the planner and the navigation grid both come from. `--guides` plays and
edits another guide set in place of our `guides/` (a route writer's output,
`scratch/Routes/c12w/guides/Undead`). A link opens a place in a route:
`/?start=<guide id>&race=<race file>&cls=<CLASS>&step=<n>&marks=1` (`step`
as the steps list numbers it, `marks=1` turns the Quest marks layer on).

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
- **Quest marks** (`tools/planner/hubview.js`, command `hub_view`, the
  page's Quest marks layer and panel, `ui/hubview.js`): at the selected step,
  the marks the game shows the character at every quest giver and ender
  within 320 yd of the hub (yellow `!` takeable now: level, prerequisites
  (`tools/lib/data/prereqs.js`), not taken or done, nothing closing it taken,
  side, race and class; grey `!` up to 2 levels away; yellow `?` a hand-in
  with its work done, grey `?` one not done), read from the timeline's
  events (which carry the goal they happen in, `g`), and the walk through
  the hub with the rules of forge-sim `hubs.rs` and forge-judge
  `check/hub.rs`: a hub is the route's NPC places linked within 120 yd, a
  visit a run of goals at it, left at 200 yd from every place; a walked
  track segment within 50 yd of a mark due then (an accept also at its
  quest level - 5) is walked past when the route does it only after leaving
  it 200 yd behind (or never); marks due at the hub's NPCs when a visit ends
  are left ready. The panel lists them with the hub's visits, our numbered
  stops and the ideal loop: the shortest straight walk from where the walk
  enters the area through the visit's stops and the marks it left ready to
  where it leaves, each quest's own order kept (Held-Karp up to 12 stops),
  a step against the clock costing 12% more. Givers are friendly NPCs and
  objects; unused, seasonal, profession, repeatable and reputation quests
  get no mark. A quest that would show but for a prerequisite not handed
  in yet is a faint `!` (`locked`, `after` naming it), never a problem. The
  map draws the game's own textures (`icons.js` ui keys: the minimap's
  `interface/minimap/objecticons` cells for yellow `!`, yellow `?` and the
  dimmed `!`, the gossip window's grey `?`), outlined, sized by zoom, ready
  ones over everything and problem ones in a red ring; a mark's tooltip
  lists its quests. Playback starts a level 1 route at the race's
  playercreateinfo spawn (`playtest.js` HOME).
- **Review mode** (`/?review=1&start=…&race=…&cls=…&visit=N`, `ui/review.js`,
  commands `review_screens`, `review_screen`, `review_note_add`,
  `review_note_delete`; notes in `tools/planner/review.js`): the route a
  screen at a time without the editing UI: one per visit to a town
  (consecutive route hubs of one name joined, and so are visits the walk
  never left 200 yd from in between, errands included) and one per run of
  field work in a zone between them; by default only the screens with a
  problem (a ready mark walked past or left, or the walk over 15% longer
  than the ideal loop) are paged. The map shows only the marks, our numbered
  path and the ideal loop faint; the panel lists the stops in plain words,
  the walked-past and left-ready counts and the share over the ideal loop,
  and the problems. A click on a mark, a stop or the path saves a sentence as a
  note in `data/local/route-feedback/review-notes.jsonl` (start, character,
  screen, step, guide file:line, target quest and NPC, map point, text,
  time) and, when the local dashboard is there, a needs-you
  `feedback-route-<id>` item with Fitz's comment on its thread. "Advanced"
  shows the normal planner at the screen.

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
  Reviewed openings (`geom/openings.json`): a WMO door narrower than about
  three yards can lose to the columns when a jamb's moulding or reveal lies
  on its column centre lines, so each listed portal (by WMO and MOPT index,
  in every placement of that WMO) is cut out after rasterising: the columns
  whose centre lies within its span and `depth` yards of its plane lose
  their spans and walls from just above its bottom to its top (Brill's town
  hall, whose only way in is a 2.9 yd door into its tower room, #366).
  Reviewed walkways (`geom/walkways.json`): a model face between WALK_MAX
  and WALL_MIN is a span where it crosses a column's centre line, so on a
  narrow model deck the rails' leaning faces can cover the deck's own
  columns and cut it in two; every placement of a listed M2 keeps its faces
  steeper than WALK_MAX as walls instead (Darkcloud Pinnacle's rope bridge,
  whose two placements at 0.71 and 0.74 scale were closed, #374).
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
- **Packing for the in-game engine** (`forge nav pack`, `rust/crates/forge-nav/src/pack` (first `tools/lib/nav/pack.js`),
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
  and the hubs layer (`forge nav layers`, a hub bit on every cell a hub disk
  touches); `Routing/Costs.lua` (mirrored in `tools/lib/nav/costs.js`)
  prices a step by it, per faction, and every graph edge carries its cost
  for Alliance, Horde and no profile and its yards. `chokepoints.js` adds `Chokepoints.lua`
  (`PolestarNavChokepoints[map]`: lift landings, bridges, gates at passages,
  tunnels, cave and building mouths, passes, each named by its AreaTable
  area) for the journey's named walk steps.
- **Leffe's navigation maps in game** (`forge nav pack --leffe <dir>`, `pack/leffe.rs`, maps format 5): the
  walking maps taken from Leffe's navigation maps (format 4, private, never shipped as files) instead of our grid.
  His grid, height, floor and class fields already are the in-game encodings and pass through (the steps his flags
  leave open past the walkable slope, which his reader closes, are closed); his zones too. His entrance graph is
  re-encoded as the graph field (an entrance on one of his refined ports becomes the surface owning it; an entrance
  keeps its 63 cheapest edges; an edge may be one way: an entrance lists only the edges it can walk). His motion
  stream reduces, at 4.17 yd cells, to steps inside one surface, steps his cells make, and his jumps, drops and
  climbs, each to the same or a neighbouring cell: those inside a cluster are the new `arc` field (one-way moves
  between the surfaces owning their ends, once per pair), those across a border are already his graph's. Each of his
  surfaces takes the named WMOAreaTable row of our grid's surface in its cell nearest in height (within 6 yd), so the
  Undercity's floor names carry over; the chokepoints stay ours. The router steps along an arc like a grid step of its
  length, and a search out of a goal steps along them backwards (`Routing/Path.lua` search, `PathGrid.lua`
  decodeArcs). `--leffe-maps` picks the maps taken from his; the rest stay the grid's, byte for byte.
  About a fifth of his floors no walk can use (no step or link out, none in, no jump or entrance at them, not on a
  cluster border): they are dropped and the nodes after them renumbered (floor, class, area, arc and graph
  fields alike). Each continent of his ships its map parts in a load-on-demand addon beside Polestar_Nav
  (`Polestar_Nav_EK`, `Polestar_Nav_Kalimdor`; its metadata, with `part = "<addon>"`, stays in Polestar_Nav), which
  `PathGrid.lua` loads the first time a search needs that map, never in combat (`EnsurePart`; a part that fails
  to load drops its map: the straight arrow there). Its blocks are the zlib bytes themselves in the string
  literals (`blocks = "zlib"`; only `\0 \n \r ^Z " \` escaped), a quarter less than base64 on disk and in memory;
  `--literals base64` keeps base64. A session on one continent holds Polestar_Nav and that continent's part:
  Polestar searches and measures walks only on the player's continent and on continents already in memory
  (`Nav/Walk.lua` canSearch, `Path.Resident`), so a journey to the other continent keeps the planner's straight
  estimate for the walks there (their danger unweighed, `Nav/Danger.lua`) until the player arrives and that part loads
  with the first search there.
  The router gives up on a walk past 8 times the straight line plus 2000 yd (`Path.lua` DETOUR): a start on
  ground his maps join to the world only far away no longer searches most of a continent.

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
