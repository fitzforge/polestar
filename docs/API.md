# Polestar's API for other addons

Another addon can build guides on the fly and play them in Polestar's guide
window: a story guide that plans its own route from the quests the character
has, for example. The calls on this page are the ones such an addon may rely
on. Everything else in the `Polestar` table is internal and may change in any
release.

Writing guides by hand as `.guide` files? A community addon is the way
([GUIDE_PACKS.md](GUIDE_PACKS.md), [PACKS.md](PACKS.md)). The arrow and the
travel planner have their own versioned table, `Polestar.Nav.API`
([ARCHITECTURE.md, "Nav API"](ARCHITECTURE.md#nav-api--journeys-for-players-and-other-addons)).

## Versioning

`Polestar.API.version` is an integer, now 1. While it stays the same, every
call below keeps its arguments, its returns and the messages it fires. A
release that changes one in a way that can break a caller (removes or renames
it, changes what an argument or a return means, stops firing a message)
raises the version by one, and its changelog says what changed under "For
guide authors". New calls and new optional arguments keep the version.

Load after Polestar (`## Dependencies: Polestar` in your TOC, or
`## OptionalDeps: Polestar` when your addon also works without it) and check
the version before you use anything:

```lua
local API = Polestar and Polestar.API
if not (API and API.version == 1) then return end -- an older Polestar, or one this code was not written for
```

## The calls

```lua
Polestar.API.version                                    -- 1
Polestar.Lookup.RegisterPlanner(kind, build)
Polestar.Lookup.BuildGuide(kind, id) -> guide | nil, reason
Polestar.RegisterGuide(guide) -> true | false, reason
Polestar.Engine.SetGuide(guideId) -> true | false
Polestar.API.ReplaceSteps(guideId, steps) -> true | false, reason
Polestar.Compat.IsOnQuest(questID) -> boolean
Polestar.Compat.IsQuestCompleted(questID) -> boolean
Polestar.Compat.IsQuestReadyForTurnIn(questID) -> boolean
Polestar.On(message, handler) -> handle
Polestar.Off(handle)
```

None of them needs the guide window: they work with it closed or hidden.

### A guide your addon builds

`Polestar.Lookup.RegisterPlanner(kind, build)` gives Polestar a kind of guide
your addon builds. `kind` is letters only (`story`) and your own: Lookup's
kinds (`item`, `mount`, `pet`, `recipe`, `tabard`, `spell`, `npc`, `rare`,
`object`, `treasure`, `quest`, `instance`, `zone`) and Dungeons' (`pickup`,
`handin`, `attune`) are taken, and a kind registered again replaces the
earlier `build`. A `kind` that is not letters only, or a `build` that is not a
function, is ignored. `build(id)` returns `{ title = ..., steps = { ... } }`
(any other guide field may come with it), or `nil, reason`. Returns nothing,
fires nothing.

`Polestar.Lookup.BuildGuide(kind, id)` calls your `build(id)` and returns the
guide ready to register: its id is `lookup/<kind>/<id>`, its pack `lookup`,
its category `Lookup` unless yours gave one, and its `lookup` field
`{ kind = kind, id = id }`. It returns `nil, reason` with your reason,
`nil, "noguide"` for a guide without steps and `nil, "unknown"` for an `id`
of nil. It registers and opens nothing, and fires nothing.

`Polestar.RegisterGuide(guide)` registers a guide: one from `BuildGuide`, or
one of your own pack's (`Polestar.RegisterPack`; the guide table and the
pack's rules are in [PACK_FORMAT.md](PACK_FORMAT.md)). It returns `true`, or
`false, reason` ("missing title", "no steps", "step 2 has no goals", ...) and
registers nothing. Registering an id again replaces that guide in the guide
menu, but a tab that shows it keeps the steps it opened with: give an open
guide new steps with `ReplaceSteps`. Polestar keeps the table (it escapes `|`
in its text, among other things), so build a new one for each call. Fires
nothing.

`Polestar.Engine.SetGuide(guideId)` shows a registered guide in the active
tab of the guide window, opening a first tab when none is open; a guide open
in another tab is selected instead. The guide it replaces goes to the closed
tabs, where the player can reopen it. Returns `true`, or `false` for an id
that is not registered or whose pack the player switched off. Fires
`GUIDE_CHANGED(guideId)` when the active tab's guide changes, then
`STEP_CHANGED` as the step follows; nothing for the guide already shown.
Before `PLAYER_LOGIN` it only saves the choice, and the tab opens at login.

### New steps for an open guide

`Polestar.API.ReplaceSteps(guideId, steps)` gives a registered guide new
steps in place: the same id, in the same tab, for the session. Call it each
time your plan changes. `steps` is a step list as in a guide, and Polestar
keeps its tables.

- A step is known by its goals: each goal's verb and the quest, NPC, object,
  item or zone it names. A step of the new list with the same goals as an old
  one is that step: it keeps the player's ticks and skip wherever the list
  puts it. Two `goto` steps that name nothing but the same zone read alike;
  the later of them pairs with the later.
- The player stays where they are: the step they were on stays the live step
  while the new list has it and nothing new before it is left to do, and the
  step they were looking at stays in view. The guide is not placed afresh
  from the quest log.
- The steps the player has done stay: done or skipped steps before the live
  step that the new list leaves out keep their place at the top. Send only
  what is left to do, or the whole guide again: either works.
- A step after the live step that the new list leaves out is gone, with its
  ticks and skip; a new step comes in where the list puts it.
- For a guide in no tab, the new list is the whole guide, and its saved ticks
  and skips move the same way.

It returns `true`, or `false, reason` and changes nothing: "unknown guide"
(not registered, or its pack switched off), "Polestar's own guide" (the
guides Polestar ships), "no steps" or a step's problem as `RegisterGuide`
reports it ("step 2 has no goals"), and "busy" when called from inside a
Polestar message handler (see below). Fires `GUIDE_CHANGED(guideId)` once
when the guide is in the active tab, and `STEP_CHANGED` when the step shown
changes; for a guide in another tab only `TABS_CHANGED`. After a `/reload`
the guide is what your addon registers again, and the ticks and skips saved
on it carry over to the steps it kept, as for any guide that changed.

### Quest state

`Polestar.Compat.IsOnQuest(questID)`: the quest is in the quest log.
`Polestar.Compat.IsQuestCompleted(questID)`: the character has handed it in.
`Polestar.Compat.IsQuestReadyForTurnIn(questID)`: it is in the log with its
objectives done, ready to hand in. Each returns `true` or `false`, never
`nil` (`false` on a client without the call), and reads the game itself: no
data addon has to be loaded.

### Messages

`Polestar.On(message, handler)` calls `handler(...)` each time Polestar fires
`message` and returns a handle; `Polestar.Off(handle)` stops it. A handler's
error is reported and does not stop the other handlers. The messages this
page promises:

| Message | Arguments | Fired when |
|---|---|---|
| `GUIDE_CHANGED` | guideId, or nil with no tab open | the active tab's guide changed: `SetGuide`, `ReplaceSteps`, the player picking or closing a tab, a finished guide handing over to the next |
| `STEP_CHANGED` | the step's index, or nil once the guide is done | the step the guide window shows changed |
| `TABS_CHANGED` | the tabs (each with its `guideId` and `stepIndex`), the active tab's index | a tab opened, closed or moved, or a tab's step or steps changed |

`ReplaceSteps` called from inside a handler of any Polestar message returns
`false, "busy"`, since the `GUIDE_CHANGED` it fires would call that handler
again. Call it from your own game event handler, or a moment later
(`C_Timer.After(0, ...)`).

## Example

```lua
local API = Polestar and Polestar.API
if not (API and API.version == 1) then return end
local Lookup = Polestar.Lookup

local function plan(chapter)
	local steps = {}
	-- ... the steps left to do, from the quest state (Polestar.Compat)
	return { title = "Chapter " .. chapter, steps = steps }
end
Lookup.RegisterPlanner("story", plan)

local guideId, chapter
local function start(n)
	chapter = n
	local guide = assert(Lookup.BuildGuide("story", n))
	assert(Polestar.RegisterGuide(guide))
	guideId = guide.id
	Polestar.Engine.SetGuide(guideId)
end

-- The plan changes when a quest is handed in: same guide, same tab.
local events = CreateFrame("Frame")
events:RegisterEvent("QUEST_TURNED_IN")
events:SetScript("OnEvent", function()
	if guideId then API.ReplaceSteps(guideId, plan(chapter).steps) end
end)
```

For contributors: forge-addontest's `api.rs` pins this page. It calls each
call listed above as written here and checks what it returns and fires, so a
change that breaks one fails it until the version goes up and this page says
what changed.
