-- Polestar's settings window, in the Polestar shell (Polestar.Widgets.Shell):
-- big (EllesmereUI's options' size at the default scale), resizable by its
-- corner grip (ui.optionsSize) and scaled by the Menu scale in its header.
-- The sidebar is a tree of groups (Guiding, Look, Setup, About), each
-- folding away (PolestarDB.optionsNav), with its pages; tabs under the
-- header band; a page tab's live preview pinned between the tabs and the
-- rows, which scroll under it; sections of setting rows in one or two
-- columns (each row with its description, each section in a panel, a
-- Reset section while one of its settings is off its default); a search in
-- the header whose results jump to their row; a footer with Reset page,
-- Reload UI, Move frames, the profile in use and Close. Consequential
-- actions ask in the shared dialog (W.Modal).
--
-- Built-in pages come first; other modules add theirs with
-- Polestar.RegisterOptions (docs/ARCHITECTURE.md, UI -> "Options
-- registry"), which may run before this file loads: the registry replays
-- every registration to us. A control whose settings key has no registered
-- default is left out rather than shown dead. Nothing is built before the
-- window first opens, a page tab only when first shown.
--
-- A Blizzard Settings category ("Polestar") opens this window.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, min, ipairs, pairs, type = math.floor, math.max, math.min, ipairs, pairs, type

local SH = W.SHELL
local GAP = 24 -- between the two columns of the Recorder's and About's tiles

local O = {}
UI.Options = O

local win
local pages, pageList = {}, {} -- name -> page; ordered list
local current, currentTab
local query = ""
local seq = 0

local function percent(v) return floor(v * 100 + 0.5) .. "%" end
-- "+20%" / "0%" / "-35%"
function O.Signed(v)
	local p = v < 0 and math.ceil(v * 100 - 0.5) or floor(v * 100 + 0.5)
	return (p > 0 and "+" or "") .. p .. "%"
end

-- The name of the colour scheme in use.
function O.SchemeLabel()
	local key = Theme.SchemeKey()
	for _, c in ipairs(Theme.SchemeChoices()) do
		if c.value == key then return c.text end
	end
	return key
end

-- A Hardcore character (C_GameRules): deathskips are off for good.
function O.Hardcore()
	local rules = C_GameRules
	return rules and rules.IsHardcoreActive and rules.IsHardcoreActive() and true or false
end

local function keyOf(name) return (name:lower():gsub("[^%w]+", "")) end

---------------------------------------------------------------------------
-- The page model: page -> tabs -> sections -> controls
---------------------------------------------------------------------------

-- Pages that close the list whatever registers after them: the author's
-- Recorder, then About.
local TAIL = { [L["Recorder"]] = 1, [L["About"]] = 2 }

-- key: the page's stable key (`/polestar options <key>`, O.Select), the
-- spec's own or else made from the name. Built-in pages give theirs, so a
-- translated title does not move them.
local function pageOf(name, icon, order, builtin, key)
	local p = pages[name]
	if not p then
		seq = seq + 1
		p = { name = name, key = keyOf(key or name), icon = icon or "gear", order = order or 100, builtin = builtin, seq = seq, tabs = {} }
		pages[name] = p
		pageList[#pageList + 1] = p
		-- By order (built-in pages first on a tie), Recorder and About last.
		table.sort(pageList, function(a, b)
			local ta, tb = TAIL[a.name] or 0, TAIL[b.name] or 0
			if ta ~= tb then return ta < tb end
			if a.order ~= b.order then return a.order < b.order end
			if (a.builtin and true or false) ~= (b.builtin and true or false) then return a.builtin and true or false end
			return a.seq < b.seq
		end)
	else
		if icon and not p.builtin then p.icon = icon end
	end
	return p
end

local function tabOf(p, name)
	name = name or ""
	for _, t in ipairs(p.tabs) do if t.name == name then return t end end
	local t = { name = name, sections = {} }
	p.tabs[#p.tabs + 1] = t
	return t
end

local function sectionOf(t, name)
	name = name or ""
	for _, s in ipairs(t.sections) do if s.name == name then return s end end
	local s = { name = name, controls = {} }
	t.sections[#t.sections + 1] = s
	return s
end

-- A page tab's views, dropped so they are built again (a registration came
-- in for a page on screen); their pinned previews go with them.
local function dropViews(p)
	if not p.views then return end
	for _, v in pairs(p.views) do
		v:Hide()
		if rawget(v, "PreviewHost") then v.PreviewHost:Hide() end
	end
	p.views = nil
end

local function add(spec, builtin)
	local p = pageOf(spec.page, spec.icon, spec.order, builtin, spec.key)
	if spec.subtitle then p.subtitle = spec.subtitle end
	if spec.custom then p.custom = spec.custom end
	if spec.dot then p.dot = spec.dot end
	if spec.empty then p.empty = spec.empty end
	if spec.group then p.group = spec.group end
	local tab = tabOf(p, spec.tab)
	-- preview(host) -> frame with :Layout(width) -> height: the tab's live
	-- preview, pinned over its rows (W.ShellPreview).
	if spec.preview then tab.preview = spec.preview end
	local s = sectionOf(tab, spec.section)
	for _, c in ipairs(spec.controls or {}) do
		c.page, c.tab, c.section = p, spec.tab, spec.section
		s.controls[#s.controls + 1] = c
	end
	-- A page or tab already on screen picks up late registrations.
	if win and win:IsShown() then
		if current == p then
			dropViews(p)
			O.Select(p.key, currentTab and currentTab.name)
		elseif O.RefreshNav then
			O.RefreshNav()
		end
	end
end

---------------------------------------------------------------------------
-- Built-in pages
--
-- The pages follow what the player came to do, not which module owns a
-- setting: follow the guide (Guide), choose what the maps show (Map), quest
-- (Questing), find things (Discovery: Lookup, the dungeon journal, rares,
-- your characters), small conveniences (Quality of Life), other addons
-- Polestar works with (Integrations); the author's Recorder and About close
-- the list. How everything looks has a page per surface in the Look group
-- (Theme, Guide window, Arrow, Map pins, ...), registered by the modules
-- that draw them. Modules still register their own controls; the pages they
-- fill are declared here with their tabs and sections in order, and the
-- modules register into them by name (docs/ARCHITECTURE.md, "Options
-- registry").
---------------------------------------------------------------------------

local GUIDE, MAP, QUESTING, DISCOVERY, QOL, REC, ABOUT =
	L["Guide"], L["Map"], L["Questing"], L["Discovery"], L["Quality of Life"], L["Recorder"], L["About"]

-- Every movable frame back in its place: the Movers' reset of all they hold
-- (UI/Movers.lua), and the guide window, party panel and arrow whether or
-- not their modules registered a mover; these windows centred.
local function resetPositions()
	if ns.Movers and ns.Movers.ResetAll then ns.Movers.ResetAll() end
	ns.Set("ui.pos", nil)
	-- The party panel re-places itself on the change (UI/PartyPanel.lua).
	ns.Set("party.panelPos", nil)
	if ns.Nav and ns.Nav.ResetArrowPosition then ns.Nav.ResetArrowPosition() end
	if win then
		win:ClearAllPoints()
		win:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
	end
	if UI.Picker and UI.Picker.frame then
		UI.Picker.frame:ClearAllPoints()
		UI.Picker.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
	end
end
O.ResetPositions = resetPositions

-- Guidance options with no effect while Shortest Path Forever guides (Nav/Handoff.lua).
local function H(c)
	local N = ns.Nav
	return N and N.HandoffOption and N.HandoffOption(c) or c
end

-- A page's tabs and sections in their order, for modules to fill.
local function declare(page, key, icon, order, subtitle, tabs)
	local out = {}
	for _, t in ipairs(tabs) do
		for _, section in ipairs(t[2]) do
			out[#out + 1] = { page = page, key = key, icon = icon, order = order, subtitle = subtitle, tab = t[1], section = section, controls = {} }
		end
	end
	return out
end

-- Guide > Automation's trainer reminders, also on Quality of Life > Vendors >
-- Trainers: one setting, a fresh control per page (the registry keeps
-- per-control state).
local function trainReminder()
	return { kind = "dropdown", key = "behavior.trainReminder", label = L["Trainer reminders"], help = L["A note in the guide window, with the nearest trainer of your class, when new skills are waiting."],
		search = "train, trainer, new spells, skills, abilities, level up, class trainer",
		choices = { { value = "2", label = L["Every 2 levels"] }, { value = "1", label = L["Every level"] }, { value = "off", label = L["Off"] } } }
end

local BUILTIN = {
	-- Following the guide: the window, the arrow and routes, automation.
	{ page = GUIDE, key = "guide", icon = "window", order = 10, tab = L["Window"], section = L["What it shows"],
		subtitle = L["The guide window, the arrow and its routes, and what Polestar does for you."], controls = {
		{ kind = "toggle", key = "ui.shown", label = L["Show the window"], help = L["Also /polestar, or the key binding."], search = "show guide, hide guide, toggle window, open window" },
		{ kind = "toggle", key = "ui.compact", label = L["Compact mode"], help = L["Only the header and the current step's goals."], search = "minimal, small, smaller window, simple" },
		{ kind = "toggle", key = "ui.wholeStep", label = L["Show the whole step"],
			help = L["Every goal of the step at once, finished ones kept, instead of one person at a time with the others on one line each."] },
		{ kind = "slider", key = "ui.maxHeight", label = L["Maximum height"], min = 0.3, max = 0.9, step = 0.05, format = percent,
			help = L["How tall the window may grow, as a share of the screen. A longer step scrolls."] },
		{ kind = "toggle", key = "ui.showNotes", label = L["Step tips"], help = L["The author's tip under the goals, one line until clicked."] },
		{ kind = "toggle", key = "ui.notesOpen", label = L["Expand step tips"], help = L["Start each step with its tip in full instead of one line."],
			child = true, disabled = function() return not ns.Get("ui.showNotes") end },
		{ kind = "slider", key = "ui.upcoming", label = L["Upcoming steps"], min = 0, max = 6, step = 1, format = "%d", help = L["How many steps the Up next list holds; 0 turns it off."] },
		{ kind = "toggle", key = "ui.upcomingOpen", label = L["Expand Up next"], help = L["Start with the upcoming steps listed instead of collapsed."] },
		{ kind = "toggle", key = "ui.newInForever", label = L["Mark quests new in Forever"],
			help = L["A small infinity mark beside the name of a quest Forever added, in the guide, While you're here, the Codex and quest tooltips."],
			search = "new in forever, infinity, new quest, forever quest, mark, badge" },
	} },
	-- Core/Engine.lua, Dynamic Questing (Own.hereBuild): quick objectives of later steps close by, in the guide
	-- window's "While you're here" panel. The setting keys keep their behavior.whileHere* names.
	{ page = GUIDE, tab = L["Window"], section = L["Dynamic Questing"], controls = {
		{ kind = "toggle", key = "behavior.whileHere", label = L["Dynamic Questing"],
			help = L["Suggests objectives from later steps when you are near them, from your quest log and what is around you. They show under the step in a \"While you're here\" panel: click one to point the arrow there; right-click to dismiss it around here (dismissed twice, it stays away for the zone)."],
			search = "while you're here, nearby objective, grab it now, on the way, later step, opportunistic, detour" },
		{ kind = "slider", key = "behavior.whileHereRadius", label = L["How close"], min = 60, max = 400, step = 10,
			format = function(v) return ns.FormatDistance(v) end,
			help = L["How near its spawn area must be for a suggestion to show. It goes again a little further out."],
			child = true, disabled = function() return not ns.Get("behavior.whileHere") end },
		{ kind = "toggle", key = "behavior.whileHereTurnins", label = L["Include nearby hand-ins"],
			help = L["Also a quest ready to hand in whose NPC is a little out of your way, when the guide hands it in later."],
			child = true, disabled = function() return not ns.Get("behavior.whileHere") end },
		{ kind = "slider", key = "behavior.whileHereTurninSeconds", label = L["Hand-ins: how far out of your way"], min = 0, max = 60, step = 5,
			format = function(v) return L["%d s"]:format(v) end,
			help = L["The seconds of extra walking a hand-in may cost, to its NPC and back on your way. One in the town you are in always shows; 0 keeps to those."],
			search = "hand in, turn in, detour, out of the way, seconds, nearby hand-ins",
			child = true, disabled = function() return not (ns.Get("behavior.whileHere") and ns.Get("behavior.whileHereTurnins")) end },
		{ kind = "toggle", key = "behavior.whileHereSound", label = L["Sound for a new suggestion"],
			help = L["A soft chime for each new suggestion (once when several come together), at the game's sound effects volume."],
			search = "chime, sound, audio, ding, alert",
			child = true, disabled = function() return not ns.Get("behavior.whileHere") end },
		{ kind = "toggle", key = "behavior.whileHereStepKey", label = L["Step key targets their mobs"],
			help = L["The step key also targets the mobs of the suggestions, nearest first, after the current step's own. It changes only out of combat."],
			search = "step key, target, targetexact, keybind, binding",
			child = true, disabled = function() return not ns.Get("behavior.whileHere") end },
	} },
	{ page = GUIDE, tab = L["Window"], section = L["Combat"], controls = {
		{ kind = "dropdown", key = "ui.combat", label = L["In combat"], help = L["What the window does while you fight."], search = "hide in combat, fade in combat, fighting",
			choices = { { value = "show", label = L["Keep visible"] }, { value = "fade", label = L["Fade out"] }, { value = "hide", label = L["Hide"] } } },
	} },
	{ page = GUIDE, tab = L["Window"], section = L["Dungeons and battlegrounds"], controls = {
		{ kind = "dropdown", key = "ui.instance", label = L["In dungeons and battlegrounds"],
			help = L["What the window, its buttons and alerts do in dungeons, raids, battlegrounds and arenas. The minimap button, the key binding or /polestar opens it there until you leave."],
			search = "dungeon, raid, battleground, arena, instance, hide, pvp, healer",
			choices = { { value = "show", label = L["Keep visible"] }, { value = "hide", label = L["Hide"] } } },
	} },
	-- Ways to show and hide the window without typing: UI/Launcher.lua's floating button, and the minimap
	-- button (Maps/MinimapButton.lua; also on Map and Quality of Life), next to the rules above.
	{ page = GUIDE, tab = L["Window"], section = L["Show and hide"], controls = {
		{ kind = "toggle", key = "ui.launcher", label = L["Floating button"],
			help = L["A small Polestar button you can put anywhere on the screen. Click to show or hide the guide, right-click for a menu, drag to move it. It hides with the window in combat and in dungeons when those are set to Hide."],
			search = "launcher, floating icon, floating button, show, hide, toggle, open polestar, quick" },
		{ kind = "toggle", key = "maps.minimapButton", label = L["Minimap button"],
			help = L["A Polestar button on the edge of the minimap. Click to show or hide the guide, right-click for settings, drag to move it."],
			search = "minimap icon, minimap button, hide button, launcher" },
	} },
	{ page = GUIDE, tab = L["Window"], section = L["Position"], controls = {
		{ kind = "toggle", key = "ui.locked", label = L["Lock window"], help = L["Prevents moving and resizing."], search = "lock, move, drag, resize, unlock" },
		{ kind = "toggle", key = "ui.lockHud", label = L["Lock arrow and buttons"],
			help = L["Stops stray drags on the arrow, the action buttons and the flight and instance timers. Shift-drag still moves them."] },
		{ kind = "toggle", key = "ui.growUp", label = L["Grow upward"], help = L["Keep the bottom edge in place, so longer steps extend the window up."] },
		{ kind = "toggle", key = "ui.barsBottom", label = L["Bar at the bottom"], help = L["With Grow upward, put the tabs and the step bar at the bottom edge, next to where the window is pinned."],
			child = true, disabled = function() return not ns.Get("ui.growUp") end },
		{ kind = "button", icon = "reset", button = L["Reset"], label = L["Reset position"], help = L["Put the guide window back in its corner."], onClick = function() ns.Set("ui.pos", nil) end },
	} },
	{ page = GUIDE, tab = L["Arrow & routes"], section = L["Arrow"], controls = {
		H({ kind = "toggle", key = "nav.arrow", label = L["Show arrow"], help = L["Points to the current goal. Its look and colours are on the Arrow page."],
			search = "arrow, waypoint, pointer, direction, compass, navigation, hud" }),
		H({ kind = "toggle", key = "nav.hideArrowWithGuide", label = L["Hide the arrow with the guide"], help = L["When the guide window is hidden, hide the arrow too."],
			child = true, disabled = function() return not ns.Get("nav.arrow") end }),
		H({ kind = "toggle", key = "nav.arrowEta", label = L["Arrival time"], help = L["Estimated time under the distance."], search = "eta, time left, travel time" }),
		{ kind = "dropdown", key = "nav.distanceUnit", label = L["Distances"], help = L["How the arrow, map tooltips, rares and the death helper show distances."], search = "units, yards, metres, metric, distance",
			choices = { { value = "yards", label = L["Yards (the game's unit)"] }, { value = "metres", label = L["Metres"] } } },
		H({ kind = "toggle", key = "nav.arrivalSound", label = L["Arrival sound"], help = L["A soft chime when you reach a waypoint."], search = "sound, chime, audio, ding" }),
		H({ kind = "button", icon = "reset", button = L["Reset"], label = L["Reset arrow position"], help = L["Back to the top of the screen. Drag the arrow to move it."],
			onClick = function() if ns.Nav and ns.Nav.ResetArrowPosition then ns.Nav.ResetArrowPosition() end end,
			needs = function() return ns.Nav and ns.Nav.ResetArrowPosition end }),
	} },
	{ page = GUIDE, tab = L["Arrow & routes"], section = L["Routes"], controls = {
		H({ kind = "toggle", key = "nav.travel", label = L["Plan travel routes"], help = L["Flights, boats and your hearthstone when they are faster. Off: the arrow points straight at the goal."],
			search = "flight, taxi, flight path, boat, zeppelin, hearth, hearthstone, route planning, fastest way, fps, frame rate, performance, lag, stutter, cpu, slow" }),
		H({ kind = "toggle", key = "nav.teleports", label = L["Class teleports"], help = L["Routes may start with a Teleport spell you know (a mage's city teleports, a druid's Moonglade) when it is faster. A city teleport needs a Rune of Teleportation in your bags."],
			search = "teleport, portal, mage, druid, moonglade",
			child = true, disabled = function() return not ns.Get("nav.travel") end }),
		H({ kind = "toggle", key = "nav.navRouting", label = L["Walk real paths"], help = L["The arrow follows paths on the ground around cliffs, water and walls, on Polestar's walking maps, with Shortest Path Forever's router by Cillian Berragan. Off: it points straight at each stop."],
			search = "pathfinding, pathing, router, walking, avoid cliffs, mountains, fps, frame rate, performance, lag, stutter, cpu, slow" }),
		H({ kind = "toggle", key = "nav.routeLines", label = L["Route lines"], help = L["The way to the goal on the world map and the minimap: a line or dots where you walk, lines where you fly, sail or ride, the legs after this one fainter. Drawn as Shortest Path Forever by Cillian Berragan draws them."],
			search = "path line, route on map, sparkles, dots",
			gear = { tip = L["Line style"], onClick = function() UI.ShowOptions("routelines") end } }),
		H({ kind = "dropdown", key = "nav.lineStyle", label = L["Line style"],
			help = L["How the route lines are drawn: one solid line, Polestar's dots, or sparkles that drift along the way to the goal (dots while Reduce motion is on)."],
			search = "route style, solid line, path line, dots, sparkles, breadcrumbs",
			choices = ns.RouteLines and ns.RouteLines.STYLE_CHOICES or {},
			needs = function() return ns.RouteLines end,
			child = true, disabled = function() return not ns.Get("nav.routeLines") end }),
		{ kind = "toggle", key = "nav.shareTransit", label = L["Share boat times"], help = L["Riding a boat, zeppelin, tram or lift times it; your guild and group get those times and you get theirs, so the arrow can say when the next one leaves."],
			search = "boat, zeppelin, tram, ship, transport, schedule" },
	} },
	{ page = GUIDE, tab = L["Arrow & routes"], section = L["Other waypoints"], controls = {
		H({ kind = "toggle", key = "nav.blizzardWaypoint", label = L["Blizzard waypoint"], help = L["Also set the game's own map pin and tracking."], search = "map pin, waypoint, user waypoint, supertrack" }),
		H({ kind = "toggle", key = "nav.tomtom", label = L["Mirror to TomTom"], help = L["Adds the target as a TomTom waypoint when TomTom is loaded."], search = "waypoints, tomtom" }),
		H({ kind = "toggle", key = "nav.useTomTomArrow", label = L["Use TomTom's arrow"], help = L["Hides Polestar's arrow in favour of TomTom's, except on the way to another continent, where TomTom's arrow cannot point."],
			child = true, disabled = function() return not ns.Get("nav.tomtom") end }),
	} },
	{ page = GUIDE, tab = L["Automation"], section = L["Quests"], controls = {
		{ kind = "toggle", key = "behavior.closeSkipped", label = L["Close offers the guide skips"], help = L["After Polestar accepts or turns in a quest, closes the quest window the NPC opens next when the guide skips its quests. Hold Shift to keep it open."],
			search = "close quest window, auto close, skip quests" },
		{ kind = "toggle", key = "behavior.warnClosing", label = L["Warn about missable quests"], help = L["Before you take a quest that closes another for good, says which in chat and leaves the accept to you."],
			search = "missable, exclusive quests, breadcrumb, warning" },
		{ kind = "toggle", key = "behavior.skipGrey", label = L["Skip grey quests"], help = L["Leaves out grey quests and their turn-ins, unless a later quest needs them first."],
			search = "gray quests, low level quests, trivial, skip easy quests" },
		-- The answer at a group quest (`when group`) not answered one by one
		-- (Discovery > Group quests): ask at each, or do or skip them all.
		{ kind = "dropdown", key = "behavior.groupQuests", label = L["Group quests"],
			help = L["Elite and escort quests the guides mark for a group. Ask at each, or answer them all: with a group (a party levelling together) or skip them (solo). Discovery, Group quests changes one."],
			choices = { { value = "ask", label = L["Ask me at each"] }, { value = "do", label = L["Do them with a group"] }, { value = "skip", label = L["Skip them"] } },
			needs = function() local E = ns.Engine; return E and E.GroupQuests and #E.GroupQuests() > 0 end },
		-- A quest the route had passed that leaves the log (Engine Own.holdLost,
		-- #1365): the guide window asks, or the answer is always the same.
		{ kind = "dropdown", key = "behavior.lostQuests", label = L["When you abandon a guide quest"],
			help = L["Ask me: the guide stays on its step, leads you back to the quest giver, and the guide window asks. Or always go back for the quest, or always skip it and the quests that follow from it; chat says which."],
			choices = { { value = "ask", label = L["Ask me"] }, { value = "back", label = L["Always go back for it"] }, { value = "skip", label = L["Always skip it"] } },
			search = "abandon, abandoned quest, dropped quest, failed quest, quest log, go back, skip" },
	} },
	{ page = GUIDE, tab = L["Automation"], section = L["Guides"], controls = {
		{ kind = "toggle", key = "behavior.autoSelectGuide", label = L["Pick a guide for me"], help = L["Opens the suggested guide when no tab is open."], search = "auto guide, choose guide, suggested guide" },
		{ kind = "dropdown", key = "behavior.guideEnd", label = L["When a leveling guide ends"], help = L["Ask me: a window says the guide is done and offers the next one. Continue automatically: the next guide loads in the same tab."],
			choices = { { value = "ask", label = L["Ask me"] }, { value = "continue", label = L["Continue automatically"] } } },
		{ kind = "dropdown", key = "behavior.routeChoice", label = L["Where to level next"], help = L["Where a guide offers more than one zone to continue in (/polestar path)."],
			choices = { { value = "ask", label = L["Let me choose"] }, { value = "recommended", label = L["Take the recommended zone"] } } },
		-- `die` steps (Core/Engine.lua, Own.deathskips): the player's choice, never in Hardcore.
		{ kind = "toggle", key = "behavior.deathskips", label = L["Use deathskips"], search = "death skip, die on purpose, corpse run, spirit healer",
			help = L["Where dying on purpose and taking the Spirit Healer's resurrection gets you there sooner, the guide shows a step for it. It costs durability and, from level 11, resurrection sickness. Always off on Hardcore characters."],
			get = function() return ns.Get("behavior.deathskips") and not O.Hardcore() end,
			disabled = function() return O.Hardcore() end },
		trainReminder(),
		{ kind = "toggle", key = "behavior.offerClassQuests", label = L["Offer class quests"],
			help = L["When one of your class's Class guides opens (your level, its first quest), the guide window offers to open it in a tab."] },
		{ kind = "button", icon = "reset", button = L["Reset"], danger = true, label = L["Reset guide progress"], help = L["Manual check-offs and skips, current guide."], confirm = true,
			confirmTitle = L["Reset guide progress?"], confirmAction = L["Reset progress"],
			confirmText = function()
				local g = ns.Engine and ns.Engine.GetGuide and ns.Engine.GetGuide()
				local name = g and (g.title or g.id)
				if name then return string.format(L["Your manual check-offs and skipped steps in %s are cleared. Quests you have done stay done."], name) end
				return L["Your manual check-offs and skipped steps in the current guide are cleared. Quests you have done stay done."]
			end,
			onClick = function() if ns.Engine and ns.Engine.ResetProgress then ns.Engine.ResetProgress() end end,
			needs = function() return ns.Engine and ns.Engine.ResetProgress end },
	} },

	-- Everything Polestar draws on the world map and the minimap, in one
	-- place. The sections are declared here, in this order; the Quests,
	-- Rares and Maps modules register their controls into them by name.
	{ page = MAP, key = "map", icon = "icon-explore", order = 30, tab = L["Guide & quests"], section = L["Guide"],
		subtitle = L["What Polestar draws on the world map and the minimap. Quest, rare and travel icons start off."], controls = {
		{ kind = "toggle", key = "nav.worldPins", label = L["Guide pins on the world map"], search = "map pins, icons, markers, waypoint, world map",
			help = L["The arrow's target, the stops of its travel route, the step's other goals, the areas their mobs and objects spawn in, and the route lines."] },
		{ kind = "toggle", key = "nav.minimapPins", label = L["Guide pin on the minimap"], help = L["The arrow's target, the areas it spawns in, and the route line."], search = "map pins, icons, markers, waypoint, minimap" },
		H({ kind = "toggle", key = "nav.minimapRoute", label = L["Route line on the minimap"],
			help = L["The way to the goal on the minimap. Off keeps the guide pin there and the line on the world map. Its colour, opacity and size: the gear beside Guide > Arrow & routes > Route lines."],
			search = "route line, path, dots, minimap, herbs, gathering, mining, clutter",
			disabled = function() return not ns.Get("nav.minimapPins") end }),
		{ kind = "toggle", key = "nav.upcomingPins", label = L["Numbered pins for the steps ahead"],
			help = L["A small pin with its step number where each of the next steps takes you, fainter the further ahead. As many as Up next shows, else five."] },
		H({ kind = "toggle", key = "nav.trailDots", label = L["Trail dots along the travel route"],
			help = L["Moving dots from you to the target on the world map and the minimap, along the travel route, while route lines are off."],
			disabled = function() return ns.Get("nav.routeLines") end }),
	} },
	{ page = MAP, tab = L["Guide & quests"], section = L["Quest markers"], controls = {} },
	{ page = MAP, tab = L["Rares & travel"], section = L["Rares and treasures"], controls = {} },
	{ page = MAP, tab = L["Rares & travel"], section = L["Dungeons and travel"], controls = {} },
	{ page = MAP, tab = L["Rares & travel"], section = L["NPC services"], controls = {} },
	{ page = MAP, tab = L["Zones"], section = L["Zones"], controls = {} },
	{ page = MAP, tab = L["Zones"], section = L["Coordinates"], controls = {} },
}

-- Pages filled by modules alone: Quests, QoL, Gear and Talents on Questing; Lookup,
-- Dungeons, Rares and Characters on Discovery; QoL and Maps on Quality of Life.
for _, list in ipairs({
	declare(QUESTING, "questing", "icon-accept", 40, L["Quest information, rewards and gear advice, and the quest buttons."], {
		{ L["Quests"], { L["Quest database"], L["Tooltips and quest log"], L["Faster questing"] } },
		{ L["Rewards & gear"], { L["Quest rewards"], L["Loot and merchants"], L["Gear advice"], L["Comparison"] } },
		-- Talents: { L["Talents"], { L["Talent plan"] } } here once the plans are back (Talents.lua, T.SOON).
		{ L["Buttons"], { L["Action buttons"] } },
	}),
	declare(DISCOVERY, "discovery", "search", 50, L["Lookup, the dungeon journal and rares: finding things in the world."], {
		{ L["Lookup"], { L["How to get anything"] } },
		{ L["Dungeons"], { ENCOUNTER_JOURNAL, L["Dungeons in leveling guides"] } },
		{ L["Rares"], { L["When a rare shows up"], L["How rares are noticed"], L["History"] } },
		{ L["Characters"], { L["Characters"] } },
	}),
	declare(QOL, "qualityoflife", "qol-toggles", 60, L["Small conveniences: questing, travel, invitations, merchants, bags, trackers and the map."], {
		-- Conveniences that also live on their home pages (Questing, Guide, Map): players look for them here (Fitz, 2026-11-05).
		{ L["Quests"], { L["Faster questing"], L["Quest rewards"], L["Action buttons"], L["Tooltips and quest log"] } },
		{ L["Travel"], { L["Flight masters"], L["Hearthstone"], L["Flight timer"], L["Along the route"], L["Nearby services"], L["Death"] } },
		{ L["Social"], { L["Requests"], L["Blocking"] } },
		{ L["Vendors"], { L["Merchants"], L["Restock"], L["Bags"], L["Trainers"] } },
		{ L["Trackers"], { L["Experience"], L["Instances"], L["Instance limits"] } },
		{ L["Map"], { L["Minimap"], L["Coordinates"] } },
	}),
}) do
	for _, spec in ipairs(list) do BUILTIN[#BUILTIN + 1] = spec end
end

for _, spec in ipairs(BUILTIN) do add(spec, true) end
add({ page = QOL, tab = L["Vendors"], section = L["Trainers"], controls = { trainReminder() } }, true)

-- Integrations: a section per supported addon, each registered by its
-- module with needs = the addon is present (Compat.AddOnPresent), so only
-- installed addons show. The page stays in the list with none (`empty`:
-- the line it shows then).
add({ page = L["Integrations"], key = "integrations", icon = "plug", order = 65,
	subtitle = L["Settings for other addons Polestar works with, shown when they are installed."],
	empty = L["None of the addons Polestar works with is installed."] }, true)
add({ page = L["Integrations"], section = "EllesmereUI", controls = {
	{ kind = "toggle", key = "ui.matchAccent", label = L["Match EllesmereUI accent"],
		help = L["Follow EllesmereUI's accent, live. Picking your own accent turns this off."],
		needs = function() return Theme.IsEllesmere() end },
	{ kind = "toggle", key = "ui.matchFont", label = L["Match EllesmereUI font"],
		help = L["Follow EllesmereUI's font, live. Choosing another font turns this off."],
		needs = function() return Theme.IsEllesmere() end },
} }, true)
add({ page = L["Integrations"], section = "Spoken", controls = {
	{ kind = "toggle", key = "behavior.spokenDelay", label = L["Wait for Spoken"],
		help = L["Waits 200 ms before each automatic quest accept, turn-in and reward pick, so Spoken has time to notice the window and read it."],
		search = "voice, narration, read aloud, dialogue, delay",
		needs = function() return ns.Compat.AddOnPresent("Spoken_Quests") end },
} }, true)

---------------------------------------------------------------------------
-- Custom pages: Recorder status and About
---------------------------------------------------------------------------

-- The Recorder's state from its SavedVariables (schema 2, docs/RECORDING.md):
-- the chunks waiting for the uploader, their size, the last one it confirmed.
local function recorderState()
	local loaded = C_AddOns and C_AddOns.IsAddOnLoaded and C_AddOns.IsAddOnLoaded("Polestar_Recorder")
	local db = PolestarRecorderDB
	if not loaded then return { installed = false } end
	local out = { installed = true, enabled = false, chunks = 0, bytes = 0, acked = 0 }
	if type(db) == "table" then
		out.enabled = db.enabled == true -- opt-in: off until the player starts it
		if type(db.chunks) == "table" then
			for _, text in pairs(db.chunks) do
				out.chunks = out.chunks + 1
				if type(text) == "string" then out.bytes = out.bytes + #text end
			end
		end
		if type(db.acked) == "number" then out.acked = db.acked end
	end
	return out
end
O.RecorderState = recorderState

local function recorderCommand(arg)
	if PolestarRecorder_Command then PolestarRecorder_Command(arg) end
end

-- Two widgets side by side in the body's columns at y, sized by
-- layout(widget, width) -> height and both as tall as the taller. -> height
local function placePair(view, pair, y, cw, layout)
	local h = 0
	for col, w in ipairs(pair) do
		w:ClearAllPoints()
		w:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad + (col - 1) * (cw + GAP), -y)
		w:Show()
		h = max(h, layout(w, cw))
	end
	for _, w in ipairs(pair) do w:SetHeight(h) end
	return h
end

local function buildRecorder(view)
	local rows = {
		status = W.InfoRow(view, L["Status"]),
		chunks = W.InfoRow(view, L["Waiting to upload"], L["Chunks the Polestar Uploader has not sent yet."]),
		size = W.InfoRow(view, L["Stored"]),
		acked = W.InfoRow(view, L["Last uploaded chunk"]),
	}
	local header = W.SectionHeader(view)
	W.SetSection(header, L["Recordings"])
	local actions = W.SectionHeader(view)
	W.SetSection(actions, L["Actions"])
	local toggle = W.ActionTile(view, "record", L["Start recording"], L["Write quests, routes and world data for guide authors. Off until you start it."], function(self)
		recorderCommand(self.psOn and "off" or "on")
		view.Refresh()
	end)
	local status = W.ActionTile(view, "info", L["Print status"], L["Chunks waiting, the last upload and the install id, in chat."], function() recorderCommand("status") end)
	local window = W.ActionTile(view, "record", L["Recorder window"], L["Position trails, marks and the list of spots to walk, in a small window."], function() recorderCommand("ui") end)
	local note = W.Text(view, "note", "textDim")
	note:SetWordWrap(true)
	note:SetSpacing(3)
	note:SetJustifyV("TOP")
	view.Refresh = function()
		local st = recorderState()
		local cw = (win.BodyWidth - GAP) / 2
		local y = 8
		header:ClearAllPoints()
		header:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		header:SetWidth(win.BodyWidth)
		y = y + 44
		if not st.installed then
			for _, r in pairs(rows) do r:Hide() end
			actions:Hide(); toggle:Hide(); status:Hide(); window:Hide()
			note:SetText(L["The Polestar Recorder addon is not loaded. Enable it in the AddOns list on the character screen to record your play for guide authoring."])
			note:SetWidth(win.BodyWidth)
			note:ClearAllPoints()
			note:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y - 6)
			note:Show()
			return y + note:GetStringHeight() + 24
		end
		note:Hide()
		rows.status.Value:SetText(st.enabled and L["Recording"] or L["Off"])
		W.Color(rows.status.Value, st.enabled and "success" or "textDim")
		rows.chunks.Value:SetText(st.chunks)
		rows.size.Value:SetText(string.format(L["%d KiB"], floor(st.bytes / 1024 + 0.5)))
		rows.acked.Value:SetText(st.acked > 0 and st.acked or "\226\128\147")
		y = y + placePair(view, { rows.status, rows.chunks }, y, cw, W.LayoutRow)
		y = y + placePair(view, { rows.size, rows.acked }, y, cw, W.LayoutRow)
		actions:ClearAllPoints()
		actions:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		actions:SetWidth(win.BodyWidth)
		actions:Show()
		y = y + 44 + 4
		toggle.psOn = st.enabled
		toggle.Title:SetText(st.enabled and L["Stop recording"] or L["Start recording"])
		toggle.psTitle = toggle.Title:GetText()
		toggle.Desc:SetText(st.enabled and L["Nothing more is written until you start it again."] or L["Write quests, routes and world data for guide authors. Off until you start it."])
		y = y + placePair(view, { toggle, status }, y, cw, W.LayoutTile) + 8
		return y + placePair(view, { window }, y, cw, W.LayoutTile) + 24
	end
end

-- The About hero: the sidebar's lockup at full size. The emblem (64, its ink
-- on the 32 edge, in its glow), then the wordmark (Media/UI/wordmark.tga,
-- 1:1, its ink 3px into the box and on rows 4-27), the tagline under it, and
-- the version with the release stage's chip.
local HERO_H = 96
local function buildAbout(view)
	local hero = CreateFrame("Frame", nil, view)
	hero:SetHeight(HERO_H)
	local emblem = W.Tex(hero, "ARTWORK", "emblem", "accent")
	emblem:SetSize(64, 64)
	emblem:SetPoint("TOPLEFT", hero, "TOPLEFT", -9, -16)
	local glow = W.Tex(hero, "BACKGROUND", "glow")
	glow:SetSize(150, 150)
	glow:SetPoint("CENTER", emblem, "CENTER", 0, 0)
	W.Painter(glow, function(t) local r, g, b = Theme.Accent(); t:SetVertexColor(r, g, b, 0.12) end)
	local TEXT_X = 66 -- 20px after the emblem's ink
	local word = W.Tex(hero, "ARTWORK", "wordmark", "text")
	word:SetSize(256, 32)
	word:SetPoint("TOPLEFT", hero, "TOPLEFT", TEXT_X - 3, -10)
	local tag = W.Text(hero, "note", "textDim")
	tag:SetText(L["A community project"] .. "  \194\183  " .. L["Leveling guides for World of Warcraft: Forever."])
	tag:SetPoint("TOPLEFT", hero, "TOPLEFT", TEXT_X, -45)
	local ver = W.Text(hero, "small", "textMuted")
	local function versionLine()
		local v = L["Version"] .. " " .. tostring(ns.version or "dev")
		local kb = W.AddonMemory()
		if not kb then return v end
		if kb >= 1024 then return v .. "  \194\183  " .. string.format(L["%.1f MB"], kb / 1024) end
		return v .. "  \194\183  " .. string.format(L["%d KB"], floor(kb + 0.5))
	end
	ver:SetText(versionLine())
	ver:SetPoint("TOPLEFT", hero, "TOPLEFT", TEXT_X, -68)
	local stage = W.Chip(hero)
	stage:SetPoint("LEFT", ver, "RIGHT", 8, 0)
	view.Stage = stage
	-- On a client reading an AI-made translation (ns.AITranslation), a line
	-- under the hero says so, with the Discord invite where players help fix it.
	local aiNote = W.Text(view, "note", "textDim")
	aiNote:SetWordWrap(true)
	aiNote:SetJustifyH("LEFT")
	aiNote:SetText(L["This translation was made with AI. Help improve it on Discord."])
	local aiLink = W.Link(view, (ns.DiscordURL:gsub("^%a+://", "")), function() UI.ShowDiscord() end)
	view.AINote, view.AILink = aiNote, aiLink
	local function block(title, text)
		local h = W.SectionHeader(view)
		W.SetSection(h, title)
		local fs = W.Text(view, "note", "textDim")
		fs:SetWordWrap(true)
		fs:SetSpacing(4)
		fs:SetJustifyV("TOP")
		fs:SetText(text)
		return h, fs
	end
	local hex = "|c" .. Theme.Hex("text")
	-- Why Polestar: the manifesto, right under the hero. Body type so it reads
	-- as the page's lead; what Polestar does not claim stands out in text
	-- colour; the closing line apart in Title and text. The beta paragraph
	-- goes with the release stage.
	local whyH = W.SectionHeader(view)
	W.SetSection(whyH, L["Why Polestar"])
	local paras = {
		L["Leveling guides have become a business: the best routes sit behind subscriptions and paywalls. Polestar goes the other way. It is free, open source under the GPL-3.0, and built by the community that plays it."],
		hex .. L["Polestar doesn't claim to be the fastest guide, or the smoothest. It is a free alternative, and it gets better with time."] .. "|r",
		L["Anyone can read the code, fix a step, sharpen a route or write a new guide, and contributions are welcome. The GPL keeps it that way: every copy and every fork stays open."],
	}
	if ns.stage then
		paras[#paras + 1] = L["It is young and still in beta, so expect the odd wrong step, waypoint or quest. Every report and every fix tunes it, and together we'll get it where it should be."]
	end
	local whyText = W.Text(view, "body", "textDim")
	whyText:SetWordWrap(true)
	whyText:SetSpacing(4)
	whyText:SetJustifyH("LEFT")
	whyText:SetJustifyV("TOP")
	whyText:SetText(table.concat(paras, "\n\n"))
	local whyClose = W.Text(view, "title", "text")
	whyClose:SetText(L["Open source and free is the future."])
	local cmdH, cmdText = block(L["Commands"], hex .. "/polestar|r   " .. L["show or hide the guide window"] .. "\n"
		.. hex .. "/polestar guides|r   " .. L["choose a guide"] .. "\n"
		.. hex .. "/polestar next, prev, skip|r   " .. L["move through steps"] .. "\n"
		.. hex .. "/polestar report|r   " .. L["report a problem with a step on the Polestar Discord"] .. "\n"
		.. hex .. "/polestar help|r   " .. L["every command"])
	local welcome = W.Button(view, L["Show the welcome again"], function() ns.Fire("SHOW_WELCOME") end)
	view.Welcome = welcome
	local whatsNew = W.Button(view, L["What's new"], function() ns.Fire("SHOW_WHATSNEW") end)
	view.WhatsNew = whatsNew
	local credH, credText = block(L["Credits"], L["Inter typeface by The Inter Project Authors, SIL Open Font License 1.1."] .. "\n"
		.. L["Wordmark set in Cinzel by The Cinzel Project Authors, SIL Open Font License 1.1."] .. "\n"
		.. L["Quest and map data includes pfQuest by shagu (MIT License)."] .. "\n"
		.. L["Discord and its logo are trademarks of Discord Inc.; the logo marks the link to the Polestar Discord."] .. "\n"
		.. L["With EllesmereUI installed, Polestar can follow its accent, font and panel colour through its public skinning API."])
	local maintH = W.SectionHeader(view)
	W.SetSection(maintH, L["Maintenance"])
	local resetAll = W.ActionTile(view, "reset", L["Reset all settings"], L["Every Polestar setting back to default. Progress is kept."],
		function()
			W.Modal({ title = L["Reset all settings?"], icon = "reset", danger = true, action = L["Reset all"],
				text = L["Every Polestar setting goes back to its default. Your guides and progress are kept."],
				onAccept = function() if ns.ResetSettings then ns.ResetSettings() end end })
		end, { danger = true })
	local resetPos = W.ActionTile(view, "window", L["Reset positions"], L["Guide window, arrow and these windows."], resetPositions)
	view.ResetAll = resetAll
	view.Refresh = function()
		ver:SetText(versionLine())
		W.SetStageChip(stage)
		local width = win.BodyWidth
		local cw = (width - GAP) / 2
		local y = 12
		hero:ClearAllPoints()
		hero:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		hero:SetWidth(width)
		y = y + HERO_H
		local ai = ns.AITranslation()
		aiNote:SetShown(ai)
		aiLink:SetShown(ai)
		if ai then
			aiNote:SetWidth(width)
			aiNote:ClearAllPoints()
			aiNote:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
			y = y + aiNote:GetStringHeight() + 4
			aiLink:ClearAllPoints()
			aiLink:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
			y = y + aiLink:GetHeight() + 12
		end
		whyH:ClearAllPoints()
		whyH:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		whyH:SetWidth(width)
		y = y + 44 + 6
		whyText:SetWidth(width)
		whyText:ClearAllPoints()
		whyText:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		y = y + whyText:GetStringHeight() + 22
		whyClose:ClearAllPoints()
		whyClose:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		y = y + whyClose:GetStringHeight() + 8
		for _, pair in ipairs({ { cmdH, cmdText }, { credH, credText } }) do
			pair[1]:ClearAllPoints()
			pair[1]:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
			pair[1]:SetWidth(width)
			y = y + 44 + 6
			pair[2]:SetWidth(width)
			pair[2]:ClearAllPoints()
			pair[2]:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
			y = y + pair[2]:GetStringHeight() + 8
			-- The welcome and what's new again, under the commands that
			-- they introduce.
			if pair[1] == cmdH then
				y = y + 4
				welcome:ClearAllPoints()
				welcome:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
				whatsNew:ClearAllPoints()
				whatsNew:SetPoint("LEFT", welcome, "RIGHT", 8, 0)
				y = y + welcome:GetHeight() + 12
			end
		end
		maintH:ClearAllPoints()
		maintH:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		maintH:SetWidth(width)
		y = y + 44 + 4
		return y + placePair(view, { resetAll, resetPos }, y, cw, W.LayoutTile) + 24
	end
end

add({ page = L["Community guides"], key = "guidepacks", icon = "layers", order = 70, subtitle = L["Guides made by other players: switch them on or off, and choose where suggestions come from."],
	custom = UI.Packs.Build, dot = UI.Packs.HasProblems }, true)
add({ page = L["Guiding Stars"], key = "thanks", icon = "star", order = 80, subtitle = L["Celebrating the supporters, contributors and bug reporters behind Polestar."],
	custom = UI.Thanks.Build }, true)
add({ page = REC, key = "recorder", icon = "record", order = 90, subtitle = L["The data recorder for guide authors."], custom = buildRecorder }, true)
add({ page = ABOUT, key = "about", icon = "info", order = 100, subtitle = L["Why Polestar exists, its commands and its credits."], custom = buildAbout }, true)

-- Page keys from before the pages were regrouped (and older section names)
-- reach the page, and the tab, that holds those settings now. A page's own
-- key wins: "arrow" and "guidewindow" open the Look pages where those exist.
local ALIASES = {
	guidewindow = { "guide", L["Window"] }, general = { "guide", L["Window"] }, window = { "guide", L["Window"] },
	navigation = { "guide", L["Arrow & routes"] }, nav = { "guide", L["Arrow & routes"] }, arrow = { "guide", L["Arrow & routes"] },
	automation = { "guide", L["Automation"] }, behavior = { "guide", L["Automation"] }, behaviour = { "guide", L["Automation"] },
	quests = { "questing", L["Quests"] }, gear = { "questing", L["Rewards & gear"] },
	lookup = { "discovery", L["Lookup"] }, dungeons = { "discovery", L["Dungeons"] }, rares = { "discovery", L["Rares"] },
	characters = { "discovery", L["Characters"] }, alts = { "discovery", L["Characters"] },
	appearance = { "theme" }, look = { "theme" }, qol = { "qualityoflife" },
}

---------------------------------------------------------------------------
-- Controls and the grid
---------------------------------------------------------------------------

local function available(c)
	if c.needs and not c.needs() then return false end
	if c.kind == "button" then return true end
	if c.kind == "binding" then return ns.Gamepad ~= nil and ns.Gamepad.BindingRow ~= nil end
	-- A toggle or slider with get/set and no key holds state that is no setting (per character).
	if (c.kind == "toggle" or c.kind == "slider") and not c.key and c.get and c.set then return true end
	return ns.GetDefault and ns.GetDefault(c.key) ~= nil
end

-- A control's label: a string, or a function that names it when it is drawn
-- (a name in the client's language that is not loaded at registration).
local function labelOf(c)
	if type(c.label) == "function" then return c.label() or "" end
	return c.label
end

local function choicesOf(c)
	local out = {}
	local list = c.choices
	if type(list) == "function" then list = list() end
	for i, ch in ipairs(list or {}) do
		out[i] = { value = ch.value, text = ch.text or ch.label or tostring(ch.value), font = ch.font, draw = ch.draw,
			disabled = ch.disabled, note = ch.note, tip = ch.tip }
	end
	return out
end

local function makeControl(parent, c)
	local w
	local getset = (c.get or c.set) and { get = c.get, set = c.set } or nil
	if c.kind == "toggle" then
		w = W.Toggle(parent, labelOf(c), c.key, c.help, nil, (c.gear or c.get or c.set) and { gear = c.gear, get = c.get, set = c.set } or nil)
	elseif c.kind == "slider" then
		local opts
		if c.release or c.get or c.set then opts = { release = c.release, get = c.get, set = c.set } end
		w = W.Slider(parent, labelOf(c), c.key, c.min or 0, c.max or 1, c.step or 0.1, c.format, c.help, nil, opts)
	elseif c.kind == "dropdown" or c.kind == "font" then
		local choices = type(c.choices) == "function" and function() return choicesOf(c) end or choicesOf(c)
		local opts = getset
		if c.kind == "font" then opts = { get = c.get, set = c.set, faces = true } end
		w = W.Dropdown(parent, labelOf(c), c.key, choices, c.help, nil, opts)
	elseif c.kind == "cards" then
		local choices = type(c.choices) == "function" and function() return choicesOf(c) end or choicesOf(c)
		w = W.Cards(parent, labelOf(c), c.key, choices, c.help, getset)
	elseif c.kind == "color" then
		w = W.Swatch(parent, labelOf(c), c.key, c.help, { shown = c.shown, source = c.source, linked = c.linked, alpha = c.alpha })
	elseif c.kind == "button" then
		-- A row with its button at the right; a consequential one (confirm)
		-- asks first, in the shared dialog.
		w = W.ActionRow(parent, labelOf(c), c.help, c.button or L["Run"], function()
			if not c.confirm then return c.onClick() end
			local text = c.confirmText
			if type(text) == "function" then text = text() end
			W.Modal({ title = c.confirmTitle or labelOf(c), text = text or c.help, icon = c.icon or "reset",
				action = c.confirmAction or c.button or labelOf(c), danger = true, onAccept = c.onClick })
		end, { icon = c.icon, danger = c.danger })
	elseif c.kind == "binding" then
		w = ns.Gamepad.BindingRow(parent, c)
		w.psControl = c
		return w
	end
	if c.disabled then W.SetDisabledWhen(w, c.disabled) end
	w.psControl = c
	return w
end
-- A control from its spec, as the pages make them.
O.Control = makeControl

---------------------------------------------------------------------------
-- New settings. A control's `new` (the release it came in: "0.3.7") puts a
-- New badge on its row, and its page's row in the sidebar counts them until
-- the page is opened. PolestarDB.optionsSeen[page key] holds the newest
-- release whose settings the player has seen on that page (account-wide,
-- not a setting). The rows keep their badges through the session a page is
-- first opened in: they read the seen state as it was when the window
-- first opened.
---------------------------------------------------------------------------

-- Is version a newer than b ("0.3.10" > "0.3.7"; nil is oldest)?
local function newer(a, b)
	if type(a) ~= "string" then return false end
	if type(b) ~= "string" then return true end
	local ia, ib = a:gmatch("%d+"), b:gmatch("%d+")
	while true do
		local x, y = ia(), ib()
		if not x and not y then return false end
		x, y = tonumber(x) or 0, tonumber(y) or 0
		if x ~= y then return x > y end
	end
end
O.Newer = newer

local seenAtOpen
local function seenTable()
	local db = ns.DB()
	if type(db.optionsSeen) ~= "table" then db.optionsSeen = {} end
	if not seenAtOpen then
		seenAtOpen = {}
		for k, v in pairs(db.optionsSeen) do seenAtOpen[k] = v end
	end
	return db.optionsSeen
end

local function rowIsNew(c)
	if not (c.new and c.page) then return false end
	seenTable()
	return newer(c.new, seenAtOpen[c.page.key])
end

---------------------------------------------------------------------------
-- Rows and sections
---------------------------------------------------------------------------

-- A section's controls in one column from y, each row showing its
-- description under its label and marking a setting off its default, a New
-- badge on a new one. In the house style they sit in one panel (its ground
-- and inner hairline, a hairline between rows). A child (c.child: a setting
-- that depends on the one above it) is indented on a connector, dimmed
-- while that one is off. `cache` maps control spec -> widget; `panel` is
-- the section's (W.RowPanel) or nil; x and width: the column (the body's
-- by default). -> new y
local ROW_INSET, CHILD_INSET, SECTION_GAP, COL_GAP, TWO_COL_MIN = 16, 40, 22, 24, 904
function O.Rows(view, controls, y, cache, panel, x, width)
	x = x or SH.pad
	width = width or win.BodyWidth
	local top = y
	for i, c in ipairs(controls) do
		local w = cache[c]
		if not w then
			w = makeControl(view, c)
			W.RowDetails(w, { inset = c.child and CHILD_INSET or ROW_INSET, child = c.child })
			cache[c] = w
		end
		W.SetRowBadge(w, rowIsNew(c) and L["New"] or nil)
		w:ClearAllPoints()
		w:SetPoint("TOPLEFT", view, "TOPLEFT", x, -y)
		w:Show()
		if w.Refresh then w:Refresh() end
		w.psTop = y
		y = y + W.LayoutRow(w, width)
		if w.Rule then w.Rule:SetShown(i < #controls) end
	end
	if panel then
		panel:ClearAllPoints()
		panel:SetPoint("TOPLEFT", view, "TOPLEFT", x, -top)
		panel:SetSize(width, max(1, y - top))
		panel:SetShown(Theme.SkinKey() == "polestar")
	end
	return y
end

-- The visible controls of a section.
local function visible(section)
	local out = {}
	for _, c in ipairs(section.controls) do
		if available(c) then out[#out + 1] = c end
	end
	return out
end

-- The settings of a list of controls that are off their default. -> count
local function modifiedCount(controls)
	local n = 0
	for _, c in ipairs(controls) do
		if c.key and c.kind ~= "button" and c.kind ~= "binding" and W.Modified(c.key) then n = n + 1 end
	end
	return n
end
O.ModifiedCount = modifiedCount

-- Every setting of a section back to its default (state that is no setting
-- too, through its set(nil)).
function O.ResetSection(controls)
	for _, c in ipairs(controls) do
		if c.key and c.kind ~= "button" and c.kind ~= "binding" then
			ns.Set(c.key, nil)
		elseif (c.kind == "toggle" or c.kind == "slider") and not c.key and c.set then
			c.set(nil)
		end
	end
	local view = O.view
	if view and view.cache then
		for _, c in ipairs(controls) do
			local w = view.cache[c]
			if w and not c.key and w.Refresh then w:Refresh() end
		end
	end
end

-- A section's Reset: right of its heading while one of its settings is off
-- its default; more than three ask first.
local function sectionReset(h)
	local controls = h.psControls
	if not controls then return end
	local n = modifiedCount(controls)
	if n > 3 then
		W.Modal({ title = L["Reset this section?"], icon = "reset", danger = true, action = L["Reset section"],
			text = string.format(L["%d settings in %s go back to their defaults."], n, h.psName or ""),
			onAccept = function() O.ResetSection(controls) end })
	else
		O.ResetSection(controls)
	end
end

local function headerOf(view, n)
	local h = view.headers[n]
	if h then return h end
	h = W.SectionHeader(view, { plain = true })
	h.Reset = W.Button(h, L["Reset section"], function(self) sectionReset(self:GetParent()) end, { ghost = true, icon = "reset", height = 22 })
	h.Reset.psTight = true
	-- A gamepad moves row to row: Y resets a row, the footer's Reset page the page.
	h.Reset.psPadSkip = true
	W.SetButtonText(h.Reset, L["Reset section"])
	h.Reset:SetPoint("BOTTOMRIGHT", h, "BOTTOMRIGHT", 0, 4)
	h.Reset:Hide()
	view.headers[n] = h
	return h
end

-- Show each section's Reset as its settings stand.
local function markSections(view)
	for _, h in ipairs(view.headers or {}) do
		local r = rawget(h, "Reset")
		if r then r:SetShown(h:IsShown() and h.psControls ~= nil and modifiedCount(h.psControls) > 0) end
	end
end

-- How many picture cards fit a column `width` wide.
local function cardsAcross(width)
	return max(1, floor((width - ROW_INSET - 12 + 12) / (W.CARD_W + 12)))
end

-- A section too wide for half the body: a row of more picture cards than
-- fit there, or one that asks (c.wide).
local function wideSection(controls, colW)
	for _, c in ipairs(controls) do
		if c.wide then return true end
		if c.kind == "cards" then
			local list = c.choices
			if type(list) == "function" then list = list() end
			if #(list or {}) > cardsAcross(colW) then return true end
		end
	end
	return false
end

-- Sections from y: each its plain heading over its panel of rows. On a body
-- at least TWO_COL_MIN wide (opts.columns), sections run in two columns, each
-- into the shorter one in reading order, a wide one across both under them.
-- groups: { { name, controls, reset = true }, ... }; the view keeps its
-- headers and panels (view.headers, view.panels). Controls not placed are
-- hidden. -> new y
local function layoutSections(view, groups, y, opts)
	for _, w in pairs(view.cache) do w:Hide() end
	local width = win.BodyWidth
	local two = opts and opts.columns and width >= TWO_COL_MIN
	local colW = two and floor((width - COL_GAP) / 2) or width
	local colY = { y, y }
	local n = 0
	for _, g in ipairs(groups) do
		n = n + 1
		local h = headerOf(view, n)
		local panel = view.panels[n]
		if not panel then
			panel = W.RowPanel(view)
			view.panels[n] = panel
		end
		local col, x, w, top
		if two and not wideSection(g.controls, colW) then
			col = colY[1] <= colY[2] and 1 or 2
			x, w, top = SH.pad + (col - 1) * (colW + COL_GAP), colW, colY[col]
		else
			x, w, top = SH.pad, width, max(colY[1], colY[2])
		end
		local yy = top
		h.psControls = g.reset and g.controls or nil
		h.psName = g.name
		if g.name ~= "" then
			W.SetSection(h, g.name)
			h:ClearAllPoints()
			h:SetPoint("TOPLEFT", view, "TOPLEFT", x, -yy)
			h:SetWidth(w)
			h:Show()
			yy = yy + W.PLAIN_SECTION_H
		else
			h:Hide()
		end
		yy = O.Rows(view, g.controls, yy, view.cache, panel, x, w) + SECTION_GAP
		if col then
			colY[col] = yy
		else
			colY[1], colY[2] = yy, yy
		end
	end
	for i = n + 1, #view.headers do view.headers[i]:Hide() end
	for i = n + 1, #view.panels do view.panels[i]:Hide() end
	markSections(view)
	return max(colY[1], colY[2]) - (n > 0 and SECTION_GAP or 0)
end

---------------------------------------------------------------------------
-- The pinned preview. A page tab's `preview(host)` -> frame f with
-- f:Layout(width) -> height is built the first time the tab shows, into its
-- own host in the shell's preview slot, and laid out across the main
-- column; the slot's chrome lies over it: "Preview" and the frame's caption
-- (f.caption: a string or a function) at the top left, the Live mark at the
-- top right. At most PREVIEW_MAX of the body's height; it clips past that.
---------------------------------------------------------------------------

local PREVIEW_MAX = 0.45

local function previewHost(view, t)
	local host = rawget(view, "PreviewHost")
	if host then return host end
	host = CreateFrame("Frame", nil, W.ShellPreviewSlot(win))
	if host.SetClipsChildren then host:SetClipsChildren(true) end
	view.PreviewHost = host
	local ok, f = pcall(t.preview, host)
	if not ok then
		if geterrorhandler then geterrorhandler()(f) end
		f = nil
	end
	host.Frame = f
	if f then
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", host, "TOPLEFT", 0, 0)
	end
	-- The chrome, over the preview.
	local chrome = CreateFrame("Frame", nil, host)
	chrome:SetAllPoints(host)
	chrome:SetFrameLevel(host:GetFrameLevel() + 30)
	host.Label = W.Text(chrome, "caption", "text")
	host.Label:SetText(L["Preview"])
	host.Label:SetPoint("TOPLEFT", chrome, "TOPLEFT", 16, -12)
	host.Caption = W.Text(chrome, "small", "textDim")
	host.Caption:SetPoint("LEFT", host.Label, "RIGHT", 8, 0)
	host.Live = W.Text(chrome, "small", "textMuted")
	host.Live:SetText(L["Live"])
	host.Live:SetPoint("TOPRIGHT", chrome, "TOPRIGHT", -16, -12)
	local dot = W.Tex(chrome, "ARTWORK", "circle", "success")
	dot:SetSize(6, 6)
	dot:SetPoint("RIGHT", host.Live, "LEFT", -6, 0)
	host:Hide()
	return host
end

-- Lay the shown tab's preview out across the main column and pin it.
local function placePreview(view, t)
	if not (t and t.preview) or view.empty then
		W.ShellPreview(win, nil)
		return
	end
	local host = previewHost(view, t)
	local f = host.Frame
	if not f then
		W.ShellPreview(win, nil)
		return
	end
	local width = win.psMainW or (win.BodyWidth + SH.pad * 2)
	local ok, h = pcall(f.Layout, f, width)
	if not ok then
		if geterrorhandler then geterrorhandler()(h) end
		h = 0
	end
	h = tonumber(h) or 0
	f:SetWidth(width)
	f:Show()
	local cap = f.caption
	if type(cap) == "function" then cap = cap() end
	host.Caption:SetText(cap or "")
	local room = win:GetHeight() - SH.header - SH.tabs - SH.footer
	W.ShellPreview(win, host, min(h, floor(room * PREVIEW_MAX)))
end

-- A view = one page tab rendered into its own frame (built once).
local function buildView(p, t)
	local view = CreateFrame("Frame", nil, win.Body)
	view:SetPoint("TOPLEFT", win.Body, "TOPLEFT", 0, 0)
	view:SetPoint("RIGHT", win.Body, "RIGHT", 0, 0)
	view.cache, view.headers, view.panels = {}, {}, {}
	view.psTab = t
	if p.custom then
		p.custom(view)
	else
		view.Refresh = function()
			local y = 16
			local groups = {}
			for _, s in ipairs(t.sections) do
				local list = visible(s)
				if #list > 0 then groups[#groups + 1] = { name = s.name, controls = list, reset = true } end
			end
			if #groups == 0 then
				for _, w in pairs(view.cache) do w:Hide() end
				for _, h in ipairs(view.headers) do h:Hide() end
				for _, pn in ipairs(view.panels) do pn:Hide() end
				if not rawget(view, "Empty") then
					view.Empty = W.Text(view, "note", "textMuted")
					view.Empty:SetWordWrap(true)
				end
				view.Empty:SetText(p.empty or L["Nothing to set here yet: the module behind this page is not loaded."])
				view.Empty:SetWidth(win.BodyWidth)
				view.Empty:ClearAllPoints()
				view.Empty:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -24)
				view.Empty:Show()
				view.empty = true
				return 80
			end
			view.empty = false
			if rawget(view, "Empty") then view.Empty:Hide() end
			y = layoutSections(view, groups, y, { columns = true })
			return y + 24
		end
	end
	return view
end

---------------------------------------------------------------------------
-- Search: every searchable control across pages, as one page of results.
--
-- Forgiving, so a vague or misspelled hint still finds the setting
-- (docs/ARCHITECTURE.md, "Options registry"). A control's words are worked
-- out once (searchTokens): its label; its `search` terms (English synonyms)
-- and its key's words ("autoAccept": auto, accept), with the English label
-- on a translated client; its section, tab and page; its help. They are
-- folded (lower case, accents off) and each two neighbours are also joined
-- ("auto loot" gives "autoloot"). Every query word must match one of them, as
-- the whole word, its start, a typo off (one letter for 4-7 letters, two for
-- 8 or more) or inside it (4 bytes for ASCII: "lag" is not in "flag"; a
-- query word still holding non-ASCII text after folding, such as one Chinese
-- character, has no floor); filler words ("the", "turn", "off") only add to a
-- match. The label counts most, then the search terms and key, then the
-- section, tab and page, then the help; typos and inside-a-word matches least.
---------------------------------------------------------------------------

local searchView
local byte, find = string.byte, string.find

-- Folding: ASCII lower case, Latin accents dropped (é -> e, ß -> ss), Cyrillic capitals lowered.
local FOLD = {}
do
	local function span(from, to, out)
		for b = from, to do FOLD[string.char(195, b)] = out end
	end
	span(128, 133, "a"); span(134, 134, "ae"); span(135, 135, "c"); span(136, 139, "e"); span(140, 143, "i")
	span(144, 144, "d"); span(145, 145, "n"); span(146, 150, "o"); span(152, 152, "o"); span(153, 156, "u")
	span(157, 157, "y"); span(158, 158, "th"); span(159, 159, "ss")
	span(160, 165, "a"); span(166, 166, "ae"); span(167, 167, "c"); span(168, 171, "e"); span(172, 175, "i")
	span(176, 176, "d"); span(177, 177, "n"); span(178, 182, "o"); span(184, 184, "o"); span(185, 188, "u")
	span(189, 189, "y"); span(190, 190, "th"); span(191, 191, "y")
	FOLD["\197\146"], FOLD["\197\147"] = "oe", "oe"
	for b = 144, 159 do FOLD[string.char(208, b)] = string.char(208, b + 32) end -- А-П
	for b = 160, 175 do FOLD[string.char(208, b)] = string.char(209, b - 32) end -- Р-Я
	FOLD["\208\129"] = "\209\145" -- Ё
end

local function fold(s)
	return (s:lower():gsub("[\195\197\208][\128-\191]", FOLD))
end

-- American spellings and short forms, read as the words the labels use.
local SPELLING = { color = "colour", colors = "colours", gray = "grey", meter = "metre", meters = "metres",
	center = "centre", behavior = "behaviour", favorite = "favourite", coords = "coordinates" }

-- Words a question carries ("how do I turn off the tracker"): they add to a
-- control's score when one of its words is the same, and are not required.
local FILLER = {}
for w in ("a an the of to in on at and or for my me i is it how do can turn off enable disable toggle set setting settings option options where want"):gmatch("%S+") do FILLER[w] = true end

-- Hint words a player types for a kind of change, and the words settings
-- use for it: a query word that matches nothing of a control's own tries
-- the others of its group ("bigger pins" finds Numbered pin size; "see
-- through" finds an opacity). Counted below a word's own match.
local SYNONYMS = {
	"bigger big larger large size sizes scale huge tiny smaller small enlarge shrink zoom grow",
	"colour colours tint hue tone",
	"transparent transparency opacity alpha seethrough translucent faint fade faded",
	"font fonts text letters typeface type writing",
	"move moving position positions drag unlock anchor place placement reposition",
	"pin pins marker markers icon icons numbered mark marks medallion blip blips",
	"border borders edge edges frame outline",
	"background backing ground bg backdrop",
	"sound sounds audio chime ding noise",
	"hide hidden show shown visible visibility",
	"animation animations motion animated effects",
	"arrow pointer compass dart",
	"line lines route routes path trail dots",
	"spacing padding gap gaps margin",
	"toast toasts alert alerts notification notifications popup banner",
	"thickness thick thicker thin width wider",
	"glow shine light",
}
local SYN = {}
for _, group in ipairs(SYNONYMS) do
	local words = {}
	for w in group:gmatch("%S+") do words[#words + 1] = w end
	for _, w in ipairs(words) do
		local list = SYN[w] or {}
		for _, o in ipairs(words) do if o ~= w then list[#list + 1] = o end end
		SYN[w] = list
	end
end
-- Phrases read as one hint word.
local PHRASES = { { "see%W*through", "seethrough" }, { "step%W*numbers?", "numbered" } }
-- A synonym's match counts this share of the word's own.
local SYN_SHARE = 0.6

local LABEL, KEY, TERMS, PLACE, HELP = 1, 2, 3, 4, 5
-- By field, the score of a match inside a word, a typo off, the word's start, the whole word.
local SCORE = { { 12, 30, 80, 100 }, { 10, 25, 65, 75 }, { 10, 25, 60, 70 }, { 8, 20, 45, 50 }, { 5, 0, 35, 40 } }
-- Two query words that are one of the control's joined pairs ("minimap
-- icon" for a "minimap icon" term) add this, by kind of match.
local PHRASE = { 0, 10, 20, 40 }

-- Translated text -> its English (the keys of L), built at the first search.
local english
local function englishOf(s)
	if not english then
		english = {}
		for en, tr in pairs(L) do
			if type(en) == "string" and type(tr) == "string" and tr ~= en then english[tr] = en end
		end
	end
	return s and english[s]
end

local function addWords(words, fields, text, field, join)
	if type(text) ~= "string" or text == "" then return end
	local prev
	for word in fold(text):gmatch("[%w\128-\255]+") do
		local w = SPELLING[word] or word
		words[#words + 1], fields[#fields + 1] = w, field
		if join and prev then words[#words + 1], fields[#fields + 1] = prev .. w, field end
		prev = w
	end
end

-- A control's searchable words and the field of each, kept on the control
-- until its label changes (a label function's name for the client).
local function searchTokens(c)
	local label = labelOf(c) or ""
	local s = c.psFind
	if s and s.label == label then return s end
	s = { label = label, words = {}, fields = {} }
	local w, f = s.words, s.fields
	addWords(w, f, label, LABEL, true)
	addWords(w, f, c.search, TERMS, true)
	if type(c.key) == "string" then addWords(w, f, (c.key:match("[^.]+$"):gsub("(%l)(%u)", "%1 %2")), KEY, true) end
	addWords(w, f, englishOf(label), TERMS, true)
	addWords(w, f, c.section, PLACE, true)
	addWords(w, f, c.tab, PLACE, true)
	addWords(w, f, c.page and c.page.name, PLACE, true)
	addWords(w, f, c.help, HELP, false)
	c.psFind = s
	return s
end

-- Optimal string alignment distance (a swap of two neighbours is one edit)
-- between the bytes qb[1..lq] and the word t; cap + 1 once it is over cap.
local rowA, rowB, rowC, tb = {}, {}, {}, {}
local function distance(qb, lq, t, cap)
	local lt = #t
	if lt - lq > cap or lq - lt > cap then return cap + 1 end
	for j = 1, lt do tb[j] = byte(t, j) end
	local r0, r1, r2 = rowA, rowB, rowC
	for j = 0, lt do r1[j] = j end
	for i = 1, lq do
		local a, low = qb[i], i
		r2[0] = i
		for j = 1, lt do
			local b = tb[j]
			local v = r1[j - 1] + (a == b and 0 or 1)
			if r1[j] + 1 < v then v = r1[j] + 1 end
			if r2[j - 1] + 1 < v then v = r2[j - 1] + 1 end
			if i > 1 and j > 1 and a == tb[j - 1] and qb[i - 1] == b and r0[j - 2] + 1 < v then v = r0[j - 2] + 1 end
			r2[j] = v
			if v < low then low = v end
		end
		if low > cap then return cap + 1 end
		r0, r1, r2 = r1, r2, r0
	end
	return r1[lt]
end

-- A query word and what it made of each word met so far (kinds), kept
-- across keystrokes: typing on changes only the last word.
local memo, memoCount = {}, 0
local function wordMemo(q)
	local m = memo[q]
	if m then return m end
	if memoCount >= 64 then memo, memoCount = {}, 0 end
	local qb = {}
	for i = 1, #q do qb[i] = byte(q, i) end
	m = { q = q, qb = qb, n = #q, cap = #q >= 8 and 2 or 1, nonAscii = find(q, "[\128-\255]") ~= nil, kinds = {} }
	memo[q], memoCount = m, memoCount + 1
	return m
end

-- 4 the whole word, 3 its start, 2 a typo off, 1 inside it, 0 no match.
local function kindOf(m, t)
	local k = m.kinds[t]
	if k then return k end
	local q, lq = m.q, m.n
	if t == q then
		k = 4
	elseif #t > lq and find(t, q, 1, true) == 1 then
		k = 3
	elseif lq >= 4 and distance(m.qb, lq, t, m.cap) <= m.cap then
		k = 2
	elseif (lq >= 4 or m.nonAscii) and find(t, q, 1, true) then
		k = 1
	else
		k = 0
	end
	m.kinds[t] = k
	return k
end

local qwords, qfiller, qpairs, qsyn, seen = {}, {}, {}, {}, {}

-- The query's words into qwords (memos) and qfiller, each word joined to
-- the one before into qpairs, a hint word's synonyms into qsyn. -> count
local function parseQuery(q)
	local n, needed, prev = 0, 0, nil
	local text = fold(q or "")
	for _, ph in ipairs(PHRASES) do text = text:gsub(ph[1], ph[2]) end
	for word in text:gmatch("[%w\128-\255]+") do
		local w = SPELLING[word] or word
		n = n + 1
		qwords[n], qfiller[n] = wordMemo(w), FILLER[w] or false
		qpairs[n] = prev and wordMemo(prev .. w) or false
		local syn = SYN[w]
		if syn then
			local list = {}
			for i, o in ipairs(syn) do list[i] = wordMemo(o) end
			qsyn[n] = list
		else
			qsyn[n] = false
		end
		if not FILLER[w] then needed = needed + 1 end
		prev = w
	end
	if needed == 0 then
		for i = 1, n do qfiller[i] = false end
	end
	return n
end

-- A word's best match through its synonyms: a whole word or a word's start
-- of the control's own (its help aside), at SYN_SHARE of the score.
local function synonymScore(list, tw, tf)
	local best = 0
	for _, sm in ipairs(list) do
		for j = 1, #tw do
			if tf[j] ~= HELP then
				local k = kindOf(sm, tw[j])
				if k >= 3 then
					local v = floor(SCORE[tf[j]][k] * SYN_SHARE)
					if v > best then best = v end
				end
			end
		end
	end
	return best
end

-- A control's score for the query, 0 when a word it needs matches nothing.
local function scoreOf(c, nw)
	local s = searchTokens(c)
	local tw, tf = s.words, s.fields
	local total = 0
	for i = 1, nw do
		local m, filler, best, phrase = qwords[i], qfiller[i], 0, 0
		local pair = qpairs[i]
		for j = 1, #tw do
			local k = kindOf(m, tw[j])
			if k == 4 or (k > 0 and not filler) then
				local v = SCORE[tf[j]][k]
				if v > best then best = v end
			end
			if pair and tf[j] ~= HELP then
				local pk = PHRASE[kindOf(pair, tw[j])] or 0
				if pk > phrase then phrase = pk end
			end
		end
		if best == 0 and not filler and qsyn[i] then best = synonymScore(qsyn[i], tw, tf) end
		if best == 0 and not filler then return 0 end
		total = total + best + phrase
	end
	return total
end

local function byScore(a, b)
	if a.psScore ~= b.psScore then return a.psScore > b.psScore end
	return a.psOrder < b.psOrder
end

local function byBest(a, b)
	if a.best ~= b.best then return a.best > b.best end
	return a.order < b.order
end

-- Up to three labels nearest a query nothing matched: each word scores as
-- in a search, and a word further off than a typo by how close it comes to
-- one of the control's words (help aside).
local function suggest(nw)
	local list = {}
	for _, p in ipairs(pageList) do
		for _, t in ipairs(p.tabs) do
			for _, sec in ipairs(t.sections) do
				for _, c in ipairs(sec.controls) do
					if available(c) then
						local s = searchTokens(c)
						local total = 0
						for i = 1, nw do
							local m = qwords[i]
							if not qfiller[i] and m.n >= 3 then
								local cap, best = math.max(1, floor(m.n / 2)), 0
								for j = 1, #s.words do
									if s.fields[j] ~= HELP then
										local k, v = kindOf(m, s.words[j]), 0
										if k >= 2 then
											v = SCORE[s.fields[j]][k]
										else
											local d = distance(m.qb, m.n, s.words[j], cap)
											if d <= cap then v = 10 - floor(10 * d / (cap + 1)) end
										end
										if v > best then best = v end
									end
								end
								total = total + best
							end
						end
						if total > 0 then list[#list + 1] = { label = s.label, score = total, order = #list } end
					end
				end
			end
		end
	end
	table.sort(list, function(a, b)
		if a.score ~= b.score then return a.score > b.score end
		return a.order < b.order
	end)
	local out, named = {}, {}
	for _, e in ipairs(list) do
		if #out == 3 then break end
		if e.label ~= "" and not named[e.label] then
			named[e.label] = true
			out[#out + 1] = e.label
		end
	end
	return out
end

-- -> { { title = "Page · Tab", controls = { ... } }, ... }, count, suggestions
-- Each control once (a setting shown on two pages, under the first), the
-- best first in its group, the group with the best match first. With no
-- match, suggestions: up to three labels near the query.
function O.Search(q)
	local groups, count = {}, 0
	local nw = parseQuery(q)
	if nw == 0 then return groups, 0 end
	for k in pairs(seen) do seen[k] = nil end
	local order = 0
	for _, p in ipairs(pageList) do
		for _, t in ipairs(p.tabs) do
			local list, best
			for _, s in ipairs(t.sections) do
				for _, c in ipairs(s.controls) do
					order = order + 1
					if available(c) and not (c.key and seen[c.key]) then
						local score = scoreOf(c, nw)
						if score > 0 then
							if c.key then seen[c.key] = true end
							c.psScore, c.psOrder = score, order
							list = list or {}
							list[#list + 1] = c
							if not best or score > best then best = score end
						end
					end
				end
			end
			if list then
				table.sort(list, byScore)
				groups[#groups + 1] = { title = t.name ~= "" and (p.name .. "  \194\183  " .. t.name) or p.name, controls = list, best = best, order = #groups + 1 }
				count = count + #list
			end
		end
	end
	if count == 0 then return groups, 0, suggest(nw) end
	table.sort(groups, byBest)
	return groups, count
end

local function renderSearch()
	if not searchView then
		searchView = CreateFrame("Frame", nil, win.Body)
		searchView:SetPoint("TOPLEFT", win.Body, "TOPLEFT", 0, 0)
		searchView:SetPoint("RIGHT", win.Body, "RIGHT", 0, 0)
		searchView.cache, searchView.headers, searchView.panels = {}, {}, {}
		searchView.Empty = W.Text(searchView, "note", "textMuted")
		searchView.Hint = W.Text(searchView, "note", "textMuted")
		searchView.Hint:SetText(L["Did you mean:"])
		searchView.Links = {}
	end
	local groups, count, suggestions = O.Search(query)
	local sections = {}
	for i, g in ipairs(groups) do sections[i] = { name = g.title, controls = g.controls } end
	local y = layoutSections(searchView, sections, 16)
	-- Each result's way to its page: a chevron in the gutter opens the page
	-- and tab it lives on, the row scrolled into view and lit (O.Jump).
	for c, w in pairs(searchView.cache) do
		local j = rawget(w, "psJump")
		if w:IsShown() then
			if not j then
				j = W.IconButton(w, "chevron-right", 20, L["Show on its page"], function(self) O.Jump(self.psControl) end, 12)
				j:SetPoint("RIGHT", w, "LEFT", -6, 0)
				w.psJump = j
			end
			j.psControl = c
			j:Show()
		end
	end
	searchView.Empty:SetShown(count == 0)
	local links = searchView.Links
	local shown = count == 0 and suggestions and #suggestions or 0
	searchView.Hint:SetShown(shown > 0)
	if count == 0 then
		searchView.Empty:SetText(string.format(L["No settings match \226\128\156%s\226\128\157."], query))
		searchView.Empty:ClearAllPoints()
		searchView.Empty:SetPoint("TOPLEFT", searchView, "TOPLEFT", SH.pad, -24)
		y = 80
		if shown > 0 then
			searchView.Hint:ClearAllPoints()
			searchView.Hint:SetPoint("TOPLEFT", searchView, "TOPLEFT", SH.pad, -56)
			-- Each suggestion a link that searches for it.
			for i = 1, shown do
				local link = links[i]
				if not link then
					link = W.Link(searchView, "", function(self)
						win.Search:SetText(self.psQuery)
						O.SetQuery(self.psQuery)
					end)
					link.psTip = nil
					links[i] = link
				end
				link.psQuery = suggestions[i]
				W.SetLinkText(link, suggestions[i])
				link:ClearAllPoints()
				link:SetPoint("TOPLEFT", searchView, "TOPLEFT", SH.pad, -(56 + 24 * i))
				link:Show()
			end
			y = 56 + 24 * shown + 32
		end
	end
	for i = shown + 1, #links do links[i]:Hide() end
	W.ShellTitle(win, L["Search"], count == 1 and L["1 setting matches"] or string.format(L["%d settings match"], count))
	W.ShellTabs(win, nil)
	W.ShellPreview(win, nil)
	searchView:Show()
	W.ShellBody(win, y + 16)
	O.results = { groups = groups, count = count, suggestions = suggestions }
	return groups, count
end

---------------------------------------------------------------------------
-- Selection and rendering
---------------------------------------------------------------------------

-- A tab with nothing to show (its module is not loaded, or every control
-- needs something missing) is left out of the tab row, and a page with no
-- such tab out of the sidebar; declared pages fill as modules register.
local function tabHasControls(t)
	for _, s in ipairs(t.sections) do
		for _, c in ipairs(s.controls) do
			if available(c) then return true end
		end
	end
	return false
end

local function shownTabs(p)
	if p.custom then return p.tabs end
	local out = {}
	for _, t in ipairs(p.tabs) do
		if tabHasControls(t) then out[#out + 1] = t end
	end
	if #out == 0 then out[1] = p.tabs[1] end
	return out
end

local function pageShown(p)
	if p.custom or p.empty then return true end
	for _, t in ipairs(p.tabs) do
		if tabHasControls(t) then return true end
	end
	return false
end

local pageByKey

-- The sidebar's tree: the groups in order, a page in the group it names
-- (spec.group) or that its order puts it in. Pages of the Look group are
-- 20-29; Setup 63-79 (Profiles, Integrations, Community guides, Gamepad);
-- About from 80 (Guiding Stars, Recorder, About); Guiding the rest.
local GROUPS = {
	{ key = "guiding", label = L["Guiding"] },
	{ key = "look", label = L["Look"] },
	{ key = "setup", label = L["Setup"] },
	{ key = "about", label = L["About"] },
}
local GROUP_KEY = {}
for _, g in ipairs(GROUPS) do GROUP_KEY[g.key] = true end
local GROUP_PREFIX = "group:"

local function groupOf(p)
	if p.group and GROUP_KEY[p.group] then return p.group end
	local o = p.order or 100
	if o >= 20 and o < 30 then return "look" end
	if o >= 80 then return "about" end
	if o >= 63 then return "setup" end
	return "guiding"
end
O.GroupOf = function(key)
	local p = pageByKey(key)
	return p and groupOf(p)
end

-- The groups folded away, per account (PolestarDB.optionsNav.folded).
local function navState()
	local db = ns.DB()
	if type(db.optionsNav) ~= "table" then db.optionsNav = {} end
	if type(db.optionsNav.folded) ~= "table" then db.optionsNav.folded = {} end
	return db.optionsNav
end

-- The page's settings new since the player last opened it. -> count
local function pageNew(p)
	local seenNow = seenTable()[p.key]
	local n = 0
	for _, t in ipairs(p.tabs) do
		for _, s in ipairs(t.sections) do
			for _, c in ipairs(s.controls) do
				if c.new and newer(c.new, seenNow) and available(c) then n = n + 1 end
			end
		end
	end
	return n
end
O.PageNew = function(key)
	local p = pageByKey(key)
	return p and pageNew(p) or 0
end

-- The newest release among the page's settings. -> version | nil
local function pageNewest(p)
	local top
	for _, t in ipairs(p.tabs) do
		for _, s in ipairs(t.sections) do
			for _, c in ipairs(s.controls) do
				if c.new and newer(c.new, top) then top = c.new end
			end
		end
	end
	return top
end

-- Does the page hold a setting off its default?
local function pageChanged(p)
	for _, t in ipairs(p.tabs) do
		for _, s in ipairs(t.sections) do
			if modifiedCount(visible(s)) > 0 then return true end
		end
	end
	return false
end

local function navItems()
	local folded = navState().folded
	local byGroup = {}
	for _, p in ipairs(pageList) do
		if pageShown(p) or p == current then
			local g = groupOf(p)
			byGroup[g] = byGroup[g] or {}
			table.insert(byGroup[g], p)
		end
	end
	local items = {}
	for _, g in ipairs(GROUPS) do
		local list = byGroup[g.key]
		if list then
			local fold = folded[g.key] and true or false
			items[#items + 1] = { group = true, key = GROUP_PREFIX .. g.key, label = g.label, folded = fold }
			for _, p in ipairs(list) do
				-- A folded group still shows the page on screen.
				if not fold or p == current then
					local n = pageNew(p)
					items[#items + 1] = { key = p.key, label = p.name, icon = p.icon, indent = true, dot = p.dot and p.dot() or nil,
						new = n > 0 and n or nil, changed = pageChanged(p) or nil }
				end
			end
		end
	end
	return items
end

-- A sidebar click: a group's header folds or opens it, a page opens.
local function navSelect(key)
	if type(key) == "string" and key:sub(1, #GROUP_PREFIX) == GROUP_PREFIX then
		local folded = navState().folded
		local g = key:sub(#GROUP_PREFIX + 1)
		folded[g] = (not folded[g]) or nil
		O.RefreshNav()
		return
	end
	O.Select(key)
end

function O.RefreshNav()
	if win then W.ShellNav(win, navItems(), query == "" and current and current.key or nil, navSelect) end
end

-- -> page, the tab an old page key points at (nil: the page's first). A
-- page's own key wins over an alias of the same name.
function pageByKey(key)
	key = key and keyOf(key)
	for _, p in ipairs(pageList) do
		if p.key == key then return p end
	end
	local alias = key and ALIASES[key]
	if not alias then return nil end
	for _, p in ipairs(pageList) do
		if p.key == alias[1] then return p, alias[2] end
	end
end

local function hideViews()
	for _, p in ipairs(pageList) do
		if p.views then for _, v in pairs(p.views) do v:Hide() end end
	end
	if searchView then searchView:Hide() end
end

local function pageKeys(p)
	local keys = {}
	for _, t in ipairs(p.tabs) do
		for _, s in ipairs(t.sections) do
			for _, c in ipairs(s.controls) do
				if c.key and available(c) then keys[#keys + 1] = c.key end
			end
		end
	end
	return keys
end

-- The profiles (ns.Profiles, UI/Profiles.lua): their names and the one in use.
local function profileNames()
	local P = ns.Profiles
	if not (P and P.List and P.Active and P.Switch) then return nil end
	local ok, list = pcall(P.List)
	if not ok or type(list) ~= "table" then return nil end
	local out = {}
	for i, e in ipairs(list) do out[i] = type(e) == "table" and (e.name or e[1]) or e end
	local okA, active = pcall(P.Active)
	if type(active) == "table" then active = active.name end
	return out, okA and active or nil
end

-- A profile's name as shown (ns.Profiles.Label: "Default" translated).
local function profileLabel(name)
	local P = ns.Profiles
	if P and P.Label then
		local ok, text = pcall(P.Label, name)
		if ok and text then return text end
	end
	return tostring(name or "")
end

-- The footer's profile switch: the profile in use, a menu of the others.
local function profileMenu(button)
	local names, active = profileNames()
	if not names then return end
	if W.MenuShown(button) then return W.HideMenu() end
	local items = {}
	for _, name in ipairs(names) do
		items[#items + 1] = { text = profileLabel(name), checked = name == active, onClick = function()
			if name == active then return end
			local ok, why = ns.Profiles.Switch(name)
			if not ok and why and ns.Print then ns.Print(why) end
		end }
	end
	items[#items + 1] = { separator = true }
	items[#items + 1] = { text = L["Manage profiles"], icon = "layers", onClick = function() O.Select("profiles") end }
	W.ShowMenu(button, items, { point = "BOTTOMRIGHT", relPoint = "TOPRIGHT", y = 4 })
end

local footerProfile
local function renderFooter(p)
	local left = {}
	if p and #pageKeys(p) > 0 then
		left[#left + 1] = { label = L["Reset page"], opts = { icon = "reset", ghost = true }, onClick = function()
			W.Modal({ title = L["Reset this page?"], icon = "reset", danger = true, action = L["Reset page"],
				text = string.format(L["Every setting on %s goes back to its default."], p.name),
				onAccept = function() O.ResetPage(p) end })
		end }
	end
	left[#left + 1] = { label = L["Reload UI"], onClick = function() if ReloadUI then ReloadUI() end end, opts = { icon = "reload", ghost = true } }
	-- Unlock mode (ns.Movers): every movable frame shows a mover to drag.
	if ns.Movers and ns.Movers.Unlock then
		-- Unlocking hides this window and brings it back on Lock (UI/Movers.lua).
		left[#left + 1] = { label = L["Move frames"], opts = { icon = "lock", ghost = true }, onClick = function()
			ns.Movers.Unlock()
		end }
	end
	local right = { { label = L["Close"], onClick = function() win:Hide() end } }
	local names, active = profileNames()
	footerProfile = active
	if names then
		right[#right + 1] = { label = string.format(L["Profile: %s"], profileLabel(active)), opts = { icon = "layers", ghost = true }, onClick = profileMenu }
	end
	W.ShellFooter(win, left, right)
	if rawget(win, "PlaceThanks") then win.PlaceThanks() end
end

function O.ResetPage(p)
	for _, key in ipairs(pageKeys(p)) do ns.Set(key, nil) end
	-- Toggles and sliders of state that is no setting go back to their default too.
	for _, t in ipairs(p.tabs) do
		for _, s in ipairs(t.sections) do
			for _, c in ipairs(s.controls) do
				if (c.kind == "toggle" or c.kind == "slider") and not c.key and c.set and available(c) then c.set(nil) end
			end
		end
	end
	for _, v in pairs(p.views or {}) do
		for _, w in pairs(v.cache or {}) do
			if w.psControl and not w.psControl.key and w.Refresh then w:Refresh() end
		end
	end
end

-- Show page `key` (and tab name), or the search results when searching.
function O.Select(key, tabName)
	if not win then return end
	local p, aliasTab = pageByKey(key)
	p = p or pageList[1]
	tabName = tabName or aliasTab
	current = p
	W.HideMenu()
	hideViews()
	if query ~= "" then
		win.Search:SetText("")
		query = ""
	end
	local list = shownTabs(p)
	local t
	for _, tt in ipairs(list) do if tt.name == tabName then t = tt end end
	t = t or list[1]
	currentTab = t
	p.views = p.views or {}
	local view = p.views[t.name]
	if not view then
		view = buildView(p, t)
		p.views[t.name] = view
	end
	-- Opened: its new settings are seen (the rows keep their badges this session).
	local seenT = seenTable()
	local newest = pageNewest(p)
	if newest and newer(newest, seenT[p.key]) then seenT[p.key] = newest end
	W.ShellNav(win, navItems(), p.key, navSelect)
	local tabs
	if #list > 1 or (list[1] and list[1].name ~= "") then
		tabs = {}
		for i, tt in ipairs(list) do tabs[i] = { key = tt.name, label = tt.name } end
	end
	W.ShellTabs(win, tabs, t.name, function(name) O.Select(p.key, name) end)
	W.ShellTitle(win, p.name, p.subtitle)
	local h = view.Refresh()
	view:SetHeight(h)
	view:Show()
	placePreview(view, t)
	W.ScrollTo(win.Scroll, 0)
	W.ShellBody(win, h)
	renderFooter(p)
	-- Switching pages is frequent: a short fade, no movement.
	Anim.To(view, "alpha", 0, 1, Anim.FAST, "out")
	O.page, O.view = p, view
end

function O.SetQuery(text)
	query = text or ""
	if not win then return end
	-- A query from code (a link, What's New) shows in the header's box; the
	-- box's own change then finds it the same and does nothing more.
	local box = win.Search
	if (box:GetText() or "") ~= query then
		box:SetText(query)
		box.Placeholder:SetShown(query == "")
		box.Clear:SetShown(query ~= "")
	end
	if query == "" then
		O.Select(current and current.key, currentTab and currentTab.name)
		return
	end
	hideViews()
	W.ShellNav(win, navItems(), nil, navSelect)
	renderSearch()
	renderFooter(nil)
end

-- Light a row a moment (a search result's jump): the accent wash fades in,
-- holds and fades out (shorter with Reduce motion); nothing runs after.
function O.Flash(w)
	local f = rawget(w, "psFlash")
	if not f then
		f = W.Tex(w, "BACKGROUND", nil, nil, 2)
		f:SetAllPoints(w)
		W.Painter(f, function(t)
			local r, g, b = Theme.Accent()
			t:SetVertexColor(r, g, b, 0.16)
		end)
		w.psFlash = f
	end
	f:SetAlpha(0)
	f:Show()
	local hold = Anim.Reduced() and 0.5 or 1.1
	Anim.To(f, "alpha", 0, 1, Anim.FAST, "out", function()
		C_Timer.After(hold, function()
			Anim.To(f, "alpha", 1, 0, Anim.SLOW, "out", function() f:Hide() end)
		end)
	end)
end

-- Open a control's page and tab, scroll its row into view (40px under the
-- top of the body) and light it. -> the row, or nil
function O.Jump(c)
	local p = c and c.page
	if not (win and p) then return nil end
	O.Select(p.key, c.tab or "")
	local view = O.view
	local w = view and view.cache and view.cache[c]
	if not (w and w:IsShown()) then return nil end
	W.ScrollTo(win.Scroll, max(0, (w.psTop or 0) - 40))
	O.Flash(w)
	return w
end

-- The next (delta 1) or previous tab, running on into the next page's
-- first tab or the previous page's last (LB / RB on a gamepad).
function O.StepTab(delta)
	if not win then return end
	local list, at = {}, nil
	for _, p in ipairs(pageList) do
		if pageShown(p) then
			for _, t in ipairs(shownTabs(p)) do
				list[#list + 1] = { p.key, t.name }
				if p == current and t == currentTab then at = #list end
			end
		end
	end
	local to = list[(at or 0) + delta]
	if to then O.Select(to[1], to[2]) end
end

---------------------------------------------------------------------------
-- The window's size: EllesmereUI's options panel (1300 x 946 screen pixels,
-- and more on a screen taller than 1440 pixels, in 5 % steps) at the default
-- Menu scale, whatever the UI scale, until the player drags the grip
-- (ui.optionsSize: { w, h } in the window's own units; false: the default).
-- Never past the screen, never under MIN_W x MIN_H (the screen allowing).
---------------------------------------------------------------------------

local BASE_W, BASE_H, MIN_W, MIN_H, EDGE = 1300, 946, 860, 560, 16
ns.RegisterDefaults("ui", { optionsSize = false })

-- -> the default size, in UIParent units
function O.DefaultSize()
	local _, ph = 0, 0
	if GetPhysicalScreenSize then _, ph = GetPhysicalScreenSize() end
	local uh = UIParent:GetHeight()
	local perUnit = (ph and ph > 0 and uh and uh > 0) and ph / uh or 1
	local k = max(1, floor((ph or 0) / 1440 * 20 + 0.5) / 20)
	return floor(BASE_W * k / perUnit + 0.5), floor(BASE_H * k / perUnit + 0.5)
end

-- -> minW, minH, maxW, maxH in the window's units (its Menu scale applied)
local function sizeBounds()
	local s = win:GetScale() or 1
	if s <= 0 then s = 1 end
	local maxW = floor(UIParent:GetWidth() / s - 2 * EDGE)
	local maxH = floor(UIParent:GetHeight() / s - 2 * EDGE)
	return min(MIN_W, maxW), min(MIN_H, maxH), maxW, maxH
end

-- Size the window from the setting, within the screen. -> true when it changed
local function applySize()
	local saved = ns.Get("ui.optionsSize")
	local w, h
	if type(saved) == "table" and tonumber(saved[1]) and tonumber(saved[2]) then
		w, h = tonumber(saved[1]), tonumber(saved[2])
	else
		w, h = O.DefaultSize()
	end
	local minW, minH, maxW, maxH = sizeBounds()
	w = floor(min(maxW, max(minW, w)) + 0.5)
	h = floor(min(maxH, max(minH, h)) + 0.5)
	if win.SetResizeBounds then
		win:SetResizeBounds(minW, minH, maxW, maxH)
	elseif win.SetMinResize then
		win:SetMinResize(minW, minH)
		win:SetMaxResize(maxW, maxH)
	end
	if win:GetWidth() == w and win:GetHeight() == h then return false end
	win:SetSize(w, h)
	W.ShellLayout(win)
	return true
end

local function renderRail()
	local P = UI.Picker
	local foot = P and P.FootItems and P.FootItems() or { { key = "Options", label = L["Options"], icon = "sliders", tip = L["Options"] } }
	W.ShellRail(win, P and P.RailItems and P.RailItems() or {}, foot, "Options", function(key)
		if P and P.ShowSection then P.ShowSection(key) end
		UI.ShowPicker()
	end)
end

-- Lay everything on screen out again where it is (a new size or font): the
-- rail, the sidebar, the page on screen and its preview, the scroll kept.
local function relayout()
	if not (win and win:IsShown()) then return end
	W.ShellLayout(win)
	renderRail()
	O.RefreshNav()
	if query ~= "" then
		renderSearch()
		return
	end
	local view = O.view
	if view and view:IsShown() and view.Refresh then
		local scroll = win.Scroll:GetVerticalScroll()
		local h = view.Refresh()
		view:SetHeight(h)
		placePreview(view, view.psTab)
		W.ShellBody(win, h)
		W.ScrollTo(win.Scroll, scroll)
	end
end

-- While shown, a setting's change updates the marks it moves: the
-- sections' Reset, the sidebar's changed dots (redrawn only when they
-- moved), the preview's height, the profile in the footer.
local navSig
local function refreshMarks()
	if query == "" and O.view and O.view:IsShown() then markSections(O.view) end
	local items = navItems()
	local sig = {}
	for i, it in ipairs(items) do
		sig[i] = (it.key or "") .. (it.changed and "*" or "") .. (it.new or "") .. (it.dot and "!" or "") .. (it.folded and "-" or "")
	end
	sig = table.concat(sig, "|")
	if sig ~= navSig then
		navSig = sig
		W.ShellNav(win, items, query == "" and current and current.key or nil, navSelect)
	end
	if query == "" and O.view and O.view:IsShown() and O.view.psTab and O.view.psTab.preview then
		placePreview(O.view, O.view.psTab)
	end
	local _, active = profileNames()
	if active ~= footerProfile then renderFooter(query == "" and current or nil) end
end

-- The settings are the hub's Options section in their own shell: the same
-- rail, Options marked, so any section is one click back.
local function build()
	win = W.Shell("PolestarOptions", {
		rail = true, title = GUIDE, scalePath = "ui.menuScale", searchPlaceholder = L["Search settings"],
		headerSearch = true,
		onSearch = function(text)
			if (text or "") == query then return end
			O.SetQuery(text)
		end,
		resizable = {
			onResized = function(w, h) ns.Set("ui.optionsSize", { floor(w + 0.5), floor(h + 0.5) }) end,
			onReset = function() ns.Set("ui.optionsSize", nil) end,
		},
	})
	O.frame = win
	applySize()
	UI.Report.SidebarLink(win)
	-- "Special thanks to" sits in the footer, left of its right-hand buttons:
	-- the header holds the search.
	win.psPlaceThanks = function(b)
		local anchor
		for _, fb in ipairs(win.footerButtons.right) do if fb:IsShown() then anchor = fb end end
		if anchor then
			b:SetPoint("RIGHT", anchor, "LEFT", -16, 0)
		else
			b:SetPoint("RIGHT", win.Footer, "RIGHT", -SH.pad, 0)
		end
	end
	UI.Thanks.HeaderLink(win)
	-- After the shell's own scale handler: the size follows the scale's room.
	ns.On("SETTING_CHANGED", function(path)
		if path == "ui.optionsSize" or path == "ui.menuScale" or path == "" or path == "ui" then
			if applySize() then relayout() end
		end
		if win:IsShown() then refreshMarks() end
	end)
	-- A profile made, renamed or switched: the footer's switch says so.
	ns.On("PROFILES_CHANGED", function()
		if win:IsShown() then renderFooter(query == "" and current or nil) end
	end)
	-- A gamepad moves through the page (UI/Gamepad.lua); LB / RB step the tabs.
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(win, {
			initial = function(rows)
				for i, w in ipairs(rows) do if ns.Gamepad.Within(w, win.Body) then return i end end
			end,
			prevTab = function() O.StepTab(-1) end,
			nextTab = function() O.StepTab(1) end,
		})
	end
end

function UI.ShowOptions(section)
	if not win then build() end
	local hub = UI.Picker and UI.Picker.frame
	if hub and hub:IsShown() then
		if not win:IsShown() then UI.Picker.TakePlace(win, hub) end
		hub:Hide()
	end
	applySize()
	win:Show()
	renderRail()
	O.Select(section or (current and current.key) or pageList[1].key)
end

-- A new font measures every label, value and description anew: the rail,
-- the sidebar and the page on screen are laid out again where they are
-- (other tabs lay out when selected).
W.OnFontChanged(relayout)

-- The widgets on a page tab (tests and preview): key -> widget.
function O.Controls(key, tabName)
	local p = pageByKey(key)
	local out = {}
	if not p or not p.views then return out end
	for name, view in pairs(p.views) do
		if not tabName or name == tabName then
			for c, w in pairs(view.cache) do
				if c.key then out[c.key] = w else out[labelOf(c)] = w end
			end
		end
	end
	return out
end

-- The pages and tabs the sidebar and tab row show, in order.
function O.Pages()
	local out = {}
	for _, p in ipairs(pageList) do
		if pageShown(p) then
			local tabs = {}
			for j, t in ipairs(shownTabs(p)) do tabs[j] = t.name end
			out[#out + 1] = { name = p.name, key = p.key, builtin = p.builtin and true or false, tabs = tabs, group = groupOf(p) }
		end
	end
	return out
end

-- Every control of every page, built-in ones included, in page order, each
-- with its page (c.page), tab and section (profiles: labels, validation).
function O.AllControls()
	local out = {}
	for _, p in ipairs(pageList) do
		for _, t in ipairs(p.tabs) do
			for _, s in ipairs(t.sections) do
				for _, c in ipairs(s.controls) do out[#out + 1] = c end
			end
		end
	end
	return out
end

-- Every module's registrations, now and later.
W.OnOptionsRegistered(function(spec) add(spec, false) end)

---------------------------------------------------------------------------
-- Blizzard Settings: a "Polestar" entry under AddOns that opens our window.
---------------------------------------------------------------------------

local function registerSettingsCategory()
	if not (Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory) then return end
	local canvas = CreateFrame("Frame")
	canvas:Hide()
	-- The About lockup at 48: the emblem's ink on the canvas's 16 edge, the
	-- wordmark (1:1) and the tagline centred on it, then the pitch.
	local emblem = W.Tex(canvas, "ARTWORK", "emblem", "accent")
	emblem:SetSize(48, 48)
	emblem:SetPoint("TOPLEFT", canvas, "TOPLEFT", 16 - 7, -16)
	local word = W.Tex(canvas, "ARTWORK", "wordmark", "text")
	word:SetSize(256, 32)
	word:SetPoint("TOPLEFT", canvas, "TOPLEFT", 66 - 3, -14)
	local tag = W.Text(canvas, "note", "textDim")
	tag:SetText(L["A community project"])
	tag:SetPoint("TOPLEFT", canvas, "TOPLEFT", 66, -48)
	local stage = W.Chip(canvas)
	stage:SetPoint("LEFT", tag, "RIGHT", 8, 0)
	W.SetStageChip(stage)
	local sub = W.Text(canvas, "note", "textDim")
	sub:SetText(L["Leveling guides for World of Warcraft: Forever."])
	sub:SetPoint("TOPLEFT", canvas, "TOPLEFT", 16, -80)
	local open = W.Button(canvas, L["Open Polestar settings"], function()
		-- Closing the game's Settings panel is protected in combat: from addon
		-- code it would fail and blame Polestar. Leave it open then, and with
		-- the gamepad interface, whose focus a panel closed from addon code
		-- leaves blocked (ns.GamepadUI): B closes it.
		local panel = SettingsPanel
		if panel and panel.IsShown and panel:IsShown() and HideUIPanel then
			if ns.GamepadUI() then
				ns.Print(L["Close the game menu to see Polestar's settings."])
			elseif InCombatLockdown and InCombatLockdown() then
				ns.Print(L["Close the game menu to see Polestar's settings (it cannot be closed for you in combat)."])
			else
				HideUIPanel(panel)
			end
		end
		UI.ShowOptions()
	end, { primary = true })
	open:SetPoint("TOPLEFT", sub, "BOTTOMLEFT", 0, -16)
	local ok, category = pcall(Settings.RegisterCanvasLayoutCategory, canvas, "Polestar")
	if ok and category then
		pcall(Settings.RegisterAddOnCategory, category)
		UI.settingsCategory = category
	end
end

ns.OnInit(registerSettingsCategory)
