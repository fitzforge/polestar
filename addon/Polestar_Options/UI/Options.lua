-- Polestar's settings window, in the Polestar shell (Polestar.Widgets.Shell):
-- big (1680 x 946 screen pixels at the default scale), resizable by its
-- corner grip (ui.optionsSize) and scaled by the Menu scale in its header.
-- The sidebar is a tree of groups (Guiding, Look, Setup, About), each
-- folding away (PolestarDB.optionsNav), with its pages; tabs under the
-- header band; a page tab's live preview pinned between the tabs and the
-- rows, which scroll under it; sections of setting rows in one or two
-- columns (each row with its description, each section in a panel, a
-- Reset section while one of its settings is off its default); a search in
-- the header whose dropdown (UI/SearchDropdown.lua) and results page jump
-- to their row; a footer with Reset page,
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
-- This file is the settings window's own addon, Polestar_Options (load on
-- demand): Polestar/UI/OptionsLoader.lua loads it on the first
-- UI.ShowOptions (and holds ui.optionsSize's default and the Blizzard
-- Settings category), so none of this is in memory before the window opens.

local ns = Polestar
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, min, ipairs, pairs, type = math.floor, math.max, math.min, ipairs, pairs, type

local SH = W.SHELL
-- Sizes (one table, so the main chunk stays within the locals budget): GAP between the two columns of the
-- Recorder's and About's tiles, HERO_H the About hero's height, KIDS_X how far a parent's open children
-- (c.children) stand in from its rows; the window's own (BASE_W ... EDGE) with its size below.
local SIZE = { GAP = 24, HERO_H = 96, KIDS_X = 24 }

local O = {}
UI.Options = O

local win
local pages, pageList = {}, {} -- name -> page; ordered list
local current, currentTab
local query = ""
-- The settings' indexes (one table: this file keeps Lua 5.1's spare locals):
-- spec, the specs by key and the sections holding each (Index.get; nil after
-- a registration); search, the words of every control (collect's).
local Index = { search = { version = 0 } }
local seq = 0
-- The window out of the way without closing (O.Fold, O.Peek, Shift + the
-- wheel; below): state = while it is folded to its header, { h, hidden =
-- { frame, ... } }.
local Fold = {}

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

-- Pages that close the list whatever registers after them: About, Guiding
-- Stars, then the author's Recorder.
local pageOf
do
	local TAIL = { [L["About"]] = 1, [L["Guiding Stars"]] = 2, [L["Recorder"]] = 3 }

	-- key: the page's stable key (`/polestar options <key>`, O.Select), the
	-- spec's own or else made from the name. Built-in pages give theirs, so a
	-- translated title does not move them.
	function pageOf(name, icon, order, builtin, key)
		local p = pages[name]
		if not p then
			seq = seq + 1
			p = { name = name, key = keyOf(key or name), icon = icon or "gear", order = order or 100, builtin = builtin, seq = seq, tabs = {} }
			pages[name] = p
			pageList[#pageList + 1] = p
			-- By order (built-in pages first on a tie), About, Guiding Stars and Recorder last.
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
	local s = { name = name, controls = {}, psTab = t }
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
	Index.spec = nil
	local p = pageOf(spec.page, spec.icon, spec.order, builtin, spec.key)
	p.psNewList = nil
	if spec.subtitle then p.subtitle = spec.subtitle end
	if spec.custom then p.custom = spec.custom end
	if spec.dot then p.dot = spec.dot end
	if spec.empty then p.empty = spec.empty end
	if spec.group then p.group = spec.group end
	if spec.general then p.general = true end
	local tab = tabOf(p, spec.tab)
	-- The page's lead tab (Essentials): first, whatever registered before it.
	if spec.lead and not tab.lead then
		tab.lead = true
		for i, t in ipairs(p.tabs) do
			if t == tab then table.remove(p.tabs, i) break end
		end
		table.insert(p.tabs, 1, tab)
	end
	-- preview(host) -> frame with :Layout(width) -> height: the tab's live
	-- preview, pinned over its rows (W.ShellPreview).
	if spec.preview then tab.preview = spec.preview end
	-- link = { text, page, tab, to }: a row over the tab's sections that sends to the page holding the rest of its
	-- subject (`text`, then `to` as a link to that page's tab).
	if spec.link then tab.link = spec.link end
	local s = sectionOf(tab, spec.section)
	s.psOff = nil
	-- jump = { tab, section }: a More link in the section's header that opens
	-- that tab of the page and lights that section (Essentials).
	if spec.jump then s.jump = spec.jump end
	-- columns = { left, right }: a caption over each half of the section's
	-- rows (two places taking the same settings: world map | minimap).
	if spec.columns then s.columns = spec.columns end
	-- move = a frame's mover key (UI/Movers.lua): a Move in the section's
	-- header opens Move frames with that frame picked (O.MoveFrame).
	if spec.move then s.move = spec.move end
	local function place(c, owner)
		c.page, c.tab, c.section, c.psSection, c.psOwner = p, spec.tab, spec.section, s, owner
		for _, e in ipairs(c.extras or {}) do place(e, c) end
		for _, m in ipairs(c.more or {}) do place(m, c) end
	end
	-- The section's on/off, in its card's header.
	if spec.toggle then
		place(spec.toggle)
		s.toggle = spec.toggle
	end
	-- shown() -> false hides the section's whole card (a mode's settings while
	-- another mode is on); worked out again as settings change.
	if spec.shown then s.shown = spec.shown end
	for _, c in ipairs(spec.controls or {}) do
		place(c)
		-- A child depends on the setting before it that is none.
		if c.child then c.psParent = s.psLastParent else s.psLastParent = c end
		s.controls[#s.controls + 1] = c
		-- Its children (c.children): rows of the section right after it, each
		-- a setting of its own (search, Reset, the changed marks and the
		-- grouped layout see them as any row), shown under it while it is on
		-- (layoutRows).
		if c.children then
			c.psKids = c.children
			local lastKid
			for _, k in ipairs(c.children) do
				place(k)
				-- A child with child = true also waits on the child before it
				-- that is none (Play a sound over its Sound): nested.
				k.psChildOf, k.psParent = c, k.child and lastKid or c
				if not k.child then lastKid = k end
				s.controls[#s.controls + 1] = k
			end
		end
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
-- The pages follow what the player came to do, in the order a player meets
-- it, not which module owns a setting: follow the guide (Guide), quest
-- (Questing), choose what the maps show (Map), small conveniences (Quality
-- of Life), find things now and then (Discovery: Lookup, the dungeon
-- journal, rares, your characters), other addons Polestar works with
-- (Integrations); About, Guiding Stars and the author's Recorder close the
-- list. How everything looks has a page per surface in the Look group
-- (Theme, Guide window, Arrow, Map pins, ...), registered by the modules
-- that draw them. Modules still register their own controls; the pages they
-- fill are declared here with their tabs and sections in order, and the
-- modules register into them by name (docs/ARCHITECTURE.md, "Options
-- registry").
---------------------------------------------------------------------------

local GUIDE, MAP, QUESTING, DISCOVERY, QOL, REC, ABOUT =
	L["Guide"], L["Map"], L["Questing"], L["Discovery"], L["Quality of Life"], L["Recorder"], L["About"]
-- Guide's first tab: what Polestar does while you play (Dynamic Questing, pause).
local WHILE_YOU_PLAY = L["While you play"]

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

-- The trainer reminders: their home is Quality of Life > Leveling > Trainers;
-- Guide > Automation shows a reference.
local function trainReminder()
	return { kind = "dropdown", key = "behavior.trainReminder", label = L["Trainer reminders"], help = L["A note in the guide window, with the nearest trainer of your class, when new skills are waiting."],
		search = "train, trainer, new spells, skills, abilities, level up, class trainer",
		choices = { { value = "2", label = L["Every 2 levels"] }, { value = "1", label = L["Every level"] }, { value = "off", label = L["Off"] } } }
end

local BUILTIN = {
	-- Core/Engine.lua, Dynamic Questing (Own.hereBuild): quick objectives of later steps close by, in the guide
	-- window's "While you're here" panel. The setting keys keep their behavior.whileHere* names.
	-- Its switch in the section's header. While you play opens the page (following the guide: what Polestar does
	-- while you play, automation, the arrow and routes); everything about the guide window itself, showing and
	-- hiding Polestar and where its frames sit among it, is on Look > Guide window, which its first row links to.
	{ page = GUIDE, key = "guide", icon = "icon-note", order = 10, tab = WHILE_YOU_PLAY, section = L["Dynamic Questing"],
		subtitle = L["The guide window, the arrow and its routes, and what Polestar does for you."],
		link = { text = L["What the window shows, when it hides and where it sits:"], page = "guidewindow", tab = L["Window"],
			to = L["Look"] .. " \226\128\186 " .. L["Guide window"] },
		toggle = { kind = "toggle", key = "behavior.whileHere", label = L["Dynamic Questing"],
			help = L["Suggests objectives from later steps when you are near them, from your quest log and what is around you. They show under the step in a \"While you're here\" panel: click one to point the arrow there; right-click to dismiss it around here (dismissed twice, it stays away for the zone)."],
			search = "while you're here, nearby objective, grab it now, on the way, later step, opportunistic, detour" },
		controls = {
		{ kind = "slider", key = "behavior.whileHereRadius", label = L["How close"], min = 60, max = 400, step = 10,
			format = function(v) return ns.FormatDistance(v) end,
			help = L["How near the middle of its spawn area you must be for a suggestion to show. It goes again a little further out."],
			disabled = function() return not ns.Get("behavior.whileHere") end },
		{ kind = "toggle", key = "behavior.whileHereTurnins", label = L["Include nearby hand-ins"],
			help = L["Also a quest ready to hand in whose NPC is a little out of your way, when the guide hands it in later."],
			disabled = function() return not ns.Get("behavior.whileHere") end,
			children = {
				{ kind = "slider", key = "behavior.whileHereTurninSeconds", label = L["Hand-ins: how far out of your way"], min = 0, max = 60, step = 5,
					format = function(v) return L["%d s"]:format(v) end,
					help = L["The seconds of extra walking a hand-in may cost, to its NPC and back on your way. One in the town you are in always shows; 0 keeps to those."],
					search = "hand in, turn in, detour, out of the way, seconds, nearby hand-ins",
					disabled = function() return not (ns.Get("behavior.whileHere") and ns.Get("behavior.whileHereTurnins")) end },
			} },
		-- 0.3.7's flight paths you pass (Engine Own.hereBuild).
		{ kind = "toggle", key = "behavior.whileHereFlights", label = L["Flight paths you pass"],
			help = L["Also a friendly flight master near you whose flight path you haven't learned yet. Learning it ticks the guide's later step for it too."],
			search = "flight path, flight master, taxi, learn, discover, getfp",
			disabled = function() return not ns.Get("behavior.whileHere") end },
		-- 0.4.0's gathering spots (Engine Own.hereGather, Core/Gather.lua): off by default.
		{ kind = "toggle", key = "behavior.whileHereGather", label = L["Gathering spots"], new = "0.4.0",
			help = L["Also a spot near you where a herb, ore vein or fishing pool you can gather can spawn: one may be up there, or gathered already. With Find Herbs or Find Minerals on, the line says so; it says one is up when the Interact Key picks it."],
			search = "herbs, herbalism, ore, mining, fishing pools, nodes, gathering, farm, spots, tracking, find herbs, find minerals, interact key",
			disabled = function() return not ns.Get("behavior.whileHere") end },
		-- 0.4.0's sell and repair reminders (Engine Own.hereVendor, #2344): on by default.
		{ kind = "toggle", key = "behavior.whileHereVendors", label = L["Sell and repair reminders"], new = "0.4.0",
			help = L["When the guide is about to head out of town with your bags nearly full or your gear worn, a merchant or repairer on the way, once per visit. Click it to point the arrow there."],
			search = "sell, repair, vendor, merchant, repairer, durability, broken gear, bags full, bag space, free slots, junk, before heading out",
			disabled = function() return not ns.Get("behavior.whileHere") end,
			children = {
				{ kind = "slider", key = "behavior.whileHereSellSlots", label = L["Sell: fewer free bag slots than"], min = 0, max = 16, step = 1, new = "0.4.0",
					format = function(v) return string.format(v == 1 and L["%d slot"] or L["%d slots"], math.floor(v + 0.5)) end,
					help = L["Reminds you to sell when fewer bag slots are free than this, or than the items the next steps collect. 0 counts those items alone."],
					search = "sell, free slots, bag space, bags full, threshold",
					disabled = function() return not (ns.Get("behavior.whileHere") and ns.Get("behavior.whileHereVendors")) end },
				{ kind = "slider", key = "behavior.whileHereRepairPercent", label = L["Repair: gear worn below"], min = 0, max = 90, step = 5, new = "0.4.0",
					format = function(v) return v < 1 and L["Off"] or ("%d%%"):format(v) end,
					help = L["Reminds you to repair when a piece of your gear is below this share of its durability. 0: never."],
					search = "repair, durability, broken, worn, gear, threshold",
					disabled = function() return not (ns.Get("behavior.whileHere") and ns.Get("behavior.whileHereVendors")) end },
			} },
		{ kind = "toggle", key = "behavior.whileHereSound", label = L["Sound for a new suggestion"],
			help = L["A soft chime for each new suggestion (once when several come together), at the game's sound effects volume."],
			search = "chime, sound, audio, ding, alert",
			disabled = function() return not ns.Get("behavior.whileHere") end },
		-- The toast that says a new suggestion while the guide window is hidden (UI/WhileHere.lua): how long it
		-- stays. It has no look of its own (the theme's, the shared toast style).
		{ kind = "slider", key = "toasts.whilehere.seconds", label = L["Suggestion stays for"], min = 3, max = 30, step = 1, new = "0.3.8", move = "whileHere",
			format = function(v) return L["%d s"]:format(v) end,
			help = L["How long the toast stays while the guide window is hidden. Hovering it holds it."],
			search = "duration, how long, seconds, time on screen, stays, timeout, toast, while you're here, dynamic questing",
			disabled = function() return not ns.Get("behavior.whileHere") end },
		{ kind = "toggle", key = "behavior.whileHereStepKey", label = L["Step key targets their mobs"],
			help = L["The step key also targets the mobs of the suggestions, nearest first, after the current step's own. It changes only out of combat."],
			search = "step key, target, targetexact, keybind, binding",
			disabled = function() return not ns.Get("behavior.whileHere") end },
	} },
	-- Pause (Core/Init.lua, Core/Pause.lua): per character, like hiding; its two extras are
	-- account settings. A section of its own, so its rows stay together.
	{ page = GUIDE, tab = WHILE_YOU_PLAY, section = L["Pause"], controls = {
		{ kind = "toggle", label = L["Pause"],
			help = L["The arrow, the guide window and its nudges step aside. Polestar resumes by itself when you leave a dungeon alive. Your quest progress keeps following your log. This character only."],
			search = "pause, pause the guide, resume, dungeon, raid, instance, run, group, step aside, hide arrow",
			get = function() return ns.Paused() ~= nil end, set = function(on) ns.SetPaused(on, "hand") end },
		{ kind = "toggle", key = "pause.map", label = L["Hide the step's map pins while paused"],
			help = L["While paused, the pins of the step's goals, their areas, While you're here and the upcoming steps go from the maps as well."],
			search = "pause the guide, paused, map pins, minimap, world map", child = true },
		{ kind = "toggle", key = "pause.automation", label = L["No quest automation while paused"],
			help = L["While paused, quests are not accepted or turned in for you, no reward is picked, and flight masters do not open the flight map or fly you off, until Polestar resumes."],
			search = "pause the guide, paused, automation, flight, taxi, flight master", child = true },
		{ kind = "binding", action = "POLESTAR_PAUSE", label = L["Pause the guide"],
			help = L["A key or gamepad button that pauses Polestar or resumes it. It also resumes by itself when you leave a dungeon alive."] },
	} },
	{ page = GUIDE, tab = L["Automation"], section = L["Guides"], controls = {
		{ kind = "toggle", key = "behavior.autoSelectGuide", label = L["Pick a guide for me"], help = L["Opens the suggested guide when no tab is open."], search = "auto guide, choose guide, suggested guide" },
		{ kind = "dropdown", key = "behavior.guideEnd", label = L["When a leveling guide ends"], help = L["Ask me: a window says the guide is done and offers the next one. Continue automatically: the next guide loads in the same tab."],
			choices = { { value = "ask", label = L["Ask me"] }, { value = "continue", label = L["Continue automatically"] } } },
		-- The guide window's "You have outlevelled this guide" notice (UI/GuideFrameBanner.lua, #3585).
		{ kind = "toggle", key = "ui.outlevelNotice", label = L["Say when I've outlevelled a guide"], new = "0.4.3",
			help = L["A notice in the guide window, once per guide each session, when your level is past the guide's, with a guide that fits your level. Off: no notice; the guide stays as it is."],
			search = "outlevelled, outleveled, too high, level, notice, banner, jump to" },
		{ kind = "dropdown", key = "behavior.routeChoice", label = L["Where to level next"], help = L["Where a guide offers more than one zone to continue in (/polestar path)."],
			choices = { { value = "ask", label = L["Let me choose"] }, { value = "recommended", label = L["Take the recommended zone"] } } },
		-- Polestar's experimental guides (Polestar/Experimental/; Core/Guides.lua, Guides.OWN_EXTRA): on until switched off.
		-- Mount Hyjal is the one left there: the Riverglades and Shen'dralas are in the leveling route since 0.4.0.
		{ kind = "toggle", key = "behavior.experimentalGuides", label = L["Show experimental guides"], new = "0.4.0",
			help = L["Polestar's guides for Forever's new zones, still being tested: listed in the guide menu under Leveling with an Experimental chip. They are never picked for you; a route choice offers their zone where it fits either way."],
			search = "experimental, alpha, new zones, mount hyjal, polestar experimental" },
		-- `die` steps (Core/Engine.lua, Own.deathskips): the player's choice, never in Hardcore.
		{ kind = "toggle", key = "behavior.deathskips", label = L["Use deathskips"], search = "death skip, die on purpose, corpse run, spirit healer",
			help = L["Where dying on purpose and taking the Spirit Healer's resurrection gets you there sooner, the guide shows a step for it. It costs durability and, from level 11, resurrection sickness. Always off on Hardcore characters."],
			get = function() return ns.Get("behavior.deathskips") and not O.Hardcore() end,
			disabled = function() return O.Hardcore() end },
		W.Ref("dropdown", "behavior.trainReminder"),
		{ kind = "toggle", key = "behavior.offerClassQuests", label = L["Offer class quests"],
			help = L["When one of your class's Class guides opens (your level, its first quest), the guide window offers to open it in a tab."] },
		{ kind = "button", icon = "reset", button = L["Reset"], danger = true, label = L["Reset guide progress"], help = L["Manual check-offs and skips, current guide, from your last quest progress on."], confirm = true,
			confirmTitle = L["Reset guide progress?"], confirmAction = L["Reset progress"],
			confirmText = function()
				local g = ns.Engine and ns.Engine.GetGuide and ns.Engine.GetGuide()
				local name = g and (g.title or g.id)
				if name then return string.format(L["Your manual check-offs and skipped steps in %s are cleared from your last quest progress on. Quests you have done stay done, and the guide stays where they put you."], name) end
				return L["Your manual check-offs and skipped steps in the current guide are cleared from your last quest progress on. Quests you have done stay done, and the guide stays where they put you."]
			end,
			onClick = function() if ns.Engine and ns.Engine.ResetProgress then ns.Engine.ResetProgress() end end,
			needs = function() return ns.Engine and ns.Engine.ResetProgress end },
	} },
	{ page = GUIDE, tab = L["Automation"], section = L["Quests"], controls = {
		{ kind = "toggle", key = "behavior.closeSkipped", label = L["Close offers the guide skips"], help = L["After Polestar accepts or turns in a quest, closes the quest window the NPC opens next when the guide skips its quests. Hold Shift to keep it open."],
			search = "close quest window, auto close, skip quests" },
		{ kind = "toggle", key = "behavior.warnClosing", label = L["Warn about missable quests"], help = L["Before you take a quest that closes another for good, says which in chat and leaves the accept to you."],
			search = "missable, exclusive quests, breadcrumb, warning" },
		{ kind = "toggle", key = "behavior.skipGrey", label = L["Skip grey quests"], help = L["Leaves out grey quests, and quests behind you that pay less than full XP when going back for them costs more time than they give. A quest still paying full XP stays, and so does one a later quest needs. The guide window says what it left out."],
			search = "gray quests, low level quests, trivial, skip easy quests, green quests, reduced xp, left out" },
		-- A quest the route had passed that leaves the log (Engine Own.holdLost,
		-- #1365): the guide window asks, or the answer is always the same.
		{ kind = "dropdown", key = "behavior.lostQuests", label = L["When you abandon a guide quest"],
			help = L["Ask me: the guide stays on its step, leads you back to the quest giver, and the guide window asks. Or always go back for the quest, or always skip it and the quests that follow from it; chat says which."],
			choices = { { value = "ask", label = L["Ask me"] }, { value = "back", label = L["Always go back for it"] }, { value = "skip", label = L["Always skip it"] } },
			search = "abandon, abandoned quest, dropped quest, failed quest, quest log, go back, skip" },
		-- The answer at a group quest (`when group`) not answered one by one
		-- (Discovery > Group quests): ask at each, or do or skip them all.
		{ kind = "dropdown", key = "behavior.groupQuests", label = L["Group quests"],
			help = L["Elite and escort quests the guides mark for a group. Ask at each, or answer them all: with a group (a party levelling together) or skip them (solo). Discovery, Group quests changes one."],
			choices = { { value = "ask", label = L["Ask me at each"] }, { value = "do", label = L["Do them with a group"] }, { value = "skip", label = L["Skip them"] } },
			needs = function() local E = ns.Engine; return E and E.GroupQuests and #E.GroupQuests() > 0 end },
		-- Dungeons in the route (`when dungeon`, Own.dungeonAnswer): the answer for every dungeon a
		-- character has not answered one by one (Discovery > Dungeons, the guide window's question).
		-- Not shown while dungeons in the route are held back (ns.dungeonRoute: GuideDungeons lists none).
		{ kind = "dropdown", key = "behavior.dungeons", label = L["Dungeons in my route"], new = "0.4.0",
			help = L["Leveling guides can take you through the dungeons on your way, for a group of five: they pick up the quests on stops they make anyway, send you to the door at the right level and hand the quests in after. Skip them: the solo route. Ask me: the guide asks at each dungeon. Discovery, Dungeons changes one."],
			choices = { { value = "skip", label = L["Skip them"] }, { value = "ask", label = L["Ask me"] }, { value = "run", label = L["Run them"] } },
			search = "dungeon, dungeons, instance, group, run, deadmines, wailing caverns, zul'farrak, blackrock depths",
			needs = function() local E = ns.Engine; return ns.dungeonRoute and E and E.GuideDungeons and next(E.GuideDungeons()) ~= nil end },
	} },
	-- Gather, buy or mix (Core/Materials.lua, UI/Materials.lua): a profession guide's materials. Each guide's own
	-- answer is the player's, per character (its card, the guide window's menu, the Materials window, which the
	-- last row opens); this is the way of a guide never answered.
	-- In Automation, after the leveling guides' own choices (a tab of its own held two keys).
	{ page = GUIDE, tab = L["Automation"], section = L["Profession guides"], controls = {
		{ kind = "dropdown", key = "professions.materials", label = L["Materials in profession guides"], new = "0.4.0",
			help = L["How a profession guide gets a material it can gather or buy, until you answer for that guide. Ask me: a card asks when the guide opens and Mix applies meanwhile. Mix gathers what your level and professions allow and buys the rest at the Auction House. Vendor goods stay vendor steps."],
			search = "materials, reagents, gather, farm, buy, auction house, mix, crafting, professions, tailoring, shopping",
			choices = { { value = "ask", label = L["Ask me"] }, { value = "mix", label = L["Mix"] }, { value = "gather", label = L["Gather"] }, { value = "buy", label = L["Buy"] } } },
		{ kind = "toggle", key = "professions.altMaterials", label = L["Count my other characters' materials"], new = "0.4.0",
			help = L["What your other characters of this realm and side hold counts toward what is still to get. Their counts show under a material either way; mail them over yourself."],
			search = "alts, other characters, bank, mail, materials, reagents, count" },
		{ kind = "button", button = L["Show"], label = L["Materials window"], new = "0.4.0",
			help = L["Show how the profession guide gets its materials"],
			search = "materials window, shopping list, reagents, gather, buy, mix, prices, /polestar materials",
			onClick = function() ns.UI.Materials.Show() end,
			needs = function() return ns.UI and ns.UI.Materials end },
	} },
	{ page = GUIDE, tab = L["Arrow & routes"], section = L["Arrow"], controls = {
		H({ kind = "toggle", key = "nav.arrow", label = L["Show arrow"], move = "arrow", help = L["Points to the current goal. Off hides only the arrow: the route lines have their own switch, under Routes. Its look and colours are on the Arrow page."],
			search = "arrow, waypoint, pointer, direction, compass, navigation, hud, show arrow, hide arrow",
			children = {
				H({ kind = "toggle", key = "nav.hideArrowWithGuide", label = L["Hide the arrow with the guide"], help = L["When the guide window is hidden, hide the arrow too."],
					search = "hide with guide, guide hidden, window closed" }),
			} }),
		H({ kind = "toggle", key = "nav.arrowEta", label = L["Arrival time"], help = L["Estimated time under the distance."], search = "eta, time left, travel time, minutes, show arrival time" }),
		{ kind = "dropdown", key = "nav.distanceUnit", label = L["Distances"], help = L["How the arrow, map tooltips, rares and the death helper show distances."], search = "units, yards, metres, meters, metric, distance, distances",
			choices = { { value = "yards", label = L["Yards (the game's unit)"] }, { value = "metres", label = L["Metres"] } } },
		H({ kind = "toggle", key = "nav.arrivalSound", label = L["Arrival sound"], help = L["A soft chime when you reach a waypoint."], search = "sound, chime, audio, ding, arrival sound" }),
		H({ kind = "button", button = L["Reset"], label = L["Reset arrow position"], help = L["Back to the top of the screen. Drag the arrow to move it."],
			onClick = function() if ns.Nav and ns.Nav.ResetArrowPosition then ns.Nav.ResetArrowPosition() end end,
			needs = function() return ns.Nav and ns.Nav.ResetArrowPosition end }),
	} },
	-- The route: how it is planned and drawn. Nav adds its style and the journey's steps (Nav/Options.lua,
	-- UI/GuideOptions.lua).
	{ page = GUIDE, tab = L["Arrow & routes"], section = L["Routes"], controls = {
		H({ kind = "toggle", key = "nav.travel", label = L["Plan travel routes"], help = L["Flights, boats and your hearthstone when they are faster. Off: the arrow points straight at the goal."],
			search = "flight, taxi, flight path, boat, zeppelin, hearth, hearthstone, route planning, fastest way, fps, frame rate, performance, lag, stutter, cpu, slow",
			children = {
				H({ kind = "toggle", key = "nav.teleports", label = L["Class teleports"], help = L["Routes may start with a Teleport spell you know when it is faster: a mage's city teleports, a druid's Moonglade, or a shaman's Astral Recall (like a second Hearthstone). A city teleport needs a Rune of Teleportation in your bags, unless a talent does away with it (Reagent Economy)."],
					search = "teleport, portal, mage, druid, moonglade, shaman, astral recall" }),
				-- 0.3.7's detour captions in the journey (Nav/Journey.lua).
				H({ kind = "toggle", key = "nav.detourCaption", label = L["Detour captions"], help = L["Under a walk in the journey, say when it goes round a town of the other faction: \"Detour around Southshore\". It only says so: the route and the arrow stay as they are."],
					search = "detour, enemy town, hostile town, avoid, go round, journey" }),
			} }),
		H({ kind = "toggle", key = "nav.routeLines", label = L["Route lines"], help = L["The way to the goal on the world map and the minimap, with the arrow on or off: a line or dots where you walk, lines where you fly, sail or ride, the legs after this one fainter. Drawn as Shortest Path Forever by Cillian Berragan draws them."],
			search = "path line, route on map, show route, hide route, sparkles, dots, trail",
			gear = { tip = L["Line style"], onClick = function() UI.ShowOptions("routelines") end },
			children = {
				H({ kind = "dropdown", key = "nav.lineStyle", label = L["Line style"],
					help = L["How the route lines are drawn: one solid line, Polestar's dots, or sparkles that drift along the way to the goal (dots while Reduce motion is on)."],
					search = "route style, line style, solid line, path line, dots, sparkles, breadcrumbs, look",
					choices = ns.RouteLines and ns.RouteLines.STYLE_CHOICES or {},
					needs = function() return ns.RouteLines end }),
			} }),
		H({ kind = "toggle", key = "nav.navRouting", label = L["Walk real paths"], help = L["The arrow follows paths on the ground around cliffs, water and walls, on Polestar's walking maps, with Shortest Path Forever's router by Cillian Berragan. Off: it points straight at each stop."],
			search = "pathfinding, pathing, router, walking, avoid cliffs, mountains, fps, frame rate, performance, lag, stutter, cpu, slow" }),
	} },
	-- Filled by Nav's travel button and transport alerts (Nav/Options.lua).
	{ page = GUIDE, tab = L["Arrow & routes"], section = L["Along the route"], controls = {} },
	-- Ways round the world beside the arrow: boat times shared, a map click to go
	-- somewhere, the nearest services (Nav adds those, Nav/Options.lua).
	{ page = GUIDE, tab = L["Arrow & routes"], section = L["Getting around"], controls = {
		{ kind = "toggle", key = "nav.shareTransit", label = L["Share boat times"], help = L["Riding a boat, zeppelin, tram or lift times it; your guild and group get those times and you get theirs, so the arrow can say when the next one leaves."],
			search = "boat, zeppelin, tram, ship, transport, schedule" },
	} },
	{ page = GUIDE, tab = L["Arrow & routes"], section = L["Other waypoints"], controls = {
		H({ kind = "toggle", key = "nav.blizzardWaypoint", label = L["Blizzard waypoint"], help = L["Also set the game's own map pin and tracking."], search = "map pin, waypoint, user waypoint, supertrack" }),
		H({ kind = "toggle", key = "nav.arrowToFollower", label = L["Let a following addon show the way"], help = L["Hides Polestar's arrow while another addon shows Polestar's target itself, as Naowh Forever's Waypoint Pin does with Follow Polestar on. That addon also sets the game's map pin then."],
			search = "naowh, waypoint pin, navigator bar, hide arrow, follow polestar" }),
	} },

	-- Everything Polestar draws on the world map and the minimap, in one
	-- place. The sections are declared here, in this order; the Quests,
	-- Rares and Maps modules register their controls into them by name. The
	-- second tab holds the rest of the map: rares, travel, services and zones.
	{ page = MAP, key = "map", icon = "icon-explore", order = 40, tab = L["Guide & quests"], section = L["Guide"],
		subtitle = L["What Polestar draws on the world map and the minimap. Quest, rare and travel icons start off."], controls = {
		{ kind = "toggle", key = "nav.worldPins", label = L["Guide pins on the world map"], search = "map pins, icons, markers, waypoint, world map, guide pins, target, on the world map",
			help = L["The arrow's target, the stops of its travel route, the step's other goals, the areas their mobs and objects spawn in, and the route lines."] },
		{ kind = "toggle", key = "nav.minimapPins", label = L["Guide pin on the minimap"], help = L["The arrow's target, the areas it spawns in, and the route line."], search = "map pins, icons, markers, waypoint, minimap, guide pins, target, on the minimap" },
		H({ kind = "toggle", key = "nav.minimapRoute", label = L["Route line on the minimap"],
			help = L["The way to the goal on the minimap. Off keeps the guide pin there and the line on the world map. Its colour, opacity and size: the gear beside Guide > Arrow & routes > Route lines."],
			search = "route line, path, dots, minimap, herbs, gathering, mining, clutter, route on the minimap, radar",
			disabled = function() return not ns.Get("nav.minimapPins") end }),
		{ kind = "toggle", key = "nav.upcomingPins", label = L["Numbered pins for the steps ahead"],
			search = "upcoming, next steps, numbers, numbered pins, step pins, ahead, preview, plan",
			help = L["A small pin with its step number where each of the next steps takes you, fainter the further ahead. As many as Up next shows, else five."] },
		-- The trail stands in for route lines: shown while they are off, as on Map pins.
		H({ kind = "toggle", key = "nav.trailDots", label = L["Trail dots along the travel route"],
			search = "trail dots, path, route, breadcrumbs",
			help = L["Moving dots from you to the target on the world map and the minimap, along the travel route, while route lines are off."],
			needs = function() return not ns.Get("nav.routeLines") end }),
	} },
	{ page = MAP, tab = L["Guide & quests"], section = L["Quest markers"], controls = {} },
	{ page = MAP, tab = L["Rares, travel & zones"], section = L["Rares and treasures"], controls = {} },
	{ page = MAP, tab = L["Rares, travel & zones"], section = L["Dungeons and travel"], controls = {} },
	{ page = MAP, tab = L["Rares, travel & zones"], section = L["NPC services"], controls = {} },
	{ page = MAP, tab = L["Rares, travel & zones"], section = L["Zones and coordinates"], controls = {} },
}

-- Pages filled by modules alone: Quests, QoL, Gear and Talents on Questing; Lookup,
-- Alts, Dungeons and Rares on Discovery; QoL, Nav and Maps on Quality of Life.
-- Each in the order a player meets its settings (docs/superpowers/specs/
-- 2026-11-17-settings-ia-review.md, section 4).
for _, list in ipairs({
	declare(QUESTING, "questing", "icon-accept", 30, L["Quest information, rewards and gear advice, and the quest buttons."], {
		-- Quest data: the quest database's switch (Quests/Options.lua), its card folding with it; what it gives tooltips
		-- and nameplates under it. Quest items: what bags and buying do with quest items.
		{ L["Quests"], { L["Faster questing"], L["Quest log"], L["Quest data"], L["Quest items"] } },
		{ L["Rewards & gear"], { L["Quest rewards"], L["Gear advice"] } },
		-- Talents: { L["Talents"], { L["Talent plan"] } } here once the plans are back (Talents.lua, T.SOON).
		{ L["Buttons"], { L["Action buttons"], L["Targeting"] } },
		{ L["Group"], { L["Group"], L["Party chat"] } },
	}),
	declare(DISCOVERY, "discovery", "search", 60, L["Lookup, the dungeon journal and rares: finding things in the world."], {
		-- The dungeon journal and the characters, each its module's switch in its card's header.
		{ L["Lookup"], { L["How to get anything"], ENCOUNTER_JOURNAL or L["Dungeons"], L["Characters"] } },
		{ L["Dungeons"], { L["Dungeons in leveling guides"] } },
		{ L["Rares"], { L["When a rare shows up"], L["How rares are noticed"] } },
	}),
	declare(QOL, "qualityoflife", "qol-toggles", 50, L["Small conveniences: questing, travel, invitations, merchants, bags and trackers."], {
		-- References to conveniences whose home is Questing: players look for them here (Fitz, 2026-11-05).
		{ L["Quests"], { L["Faster questing"], L["Rewards, buttons and tracker"] } },
		{ L["Vendors"], { L["Merchants"], L["Restock"], L["Bags"] } },
		{ L["Travel"], { L["Flights"], L["Death"], L["Hearth and travel"] } },
		-- What changes as you level: the XP bar's marks, the XP tracker (its switch in its card's header), the
		-- trainers and the instance cap.
		{ L["Leveling"], { L["Experience"], L["XP tracker"], L["Trainers"], L["Instances"] } },
		{ L["Social"], { L["Requests"], L["Blocking"] } },
		-- The game's own options (QoL/Options.lua): image quality, no Polestar setting behind it, and second homes.
		{ L["Game"], { L["Game options"] } },
	}),
}) do
	for _, spec in ipairs(list) do BUILTIN[#BUILTIN + 1] = spec end
end

for _, spec in ipairs(BUILTIN) do add(spec, true) end
-- The quests Forever added (Quests/NewQuests.lua): their mark shows in the guide, the Codex and quest tooltips alike,
-- so it sits with the quest log.
add({ page = QUESTING, tab = L["Quests"], section = L["Quest log"], controls = {
	{ kind = "toggle", key = "ui.newInForever", label = L["Mark quests new in Forever"],
		help = L["A small infinity mark beside the name of a quest Forever added, in the guide, While you're here, the Codex and quest tooltips."],
		search = "new in forever, infinity, new quest, forever quest, mark, badge" },
} }, true)
add({ page = QOL, tab = L["Leveling"], section = L["Trainers"], controls = { trainReminder() } }, true)

-- Integrations: a section per supported addon, each registered by its
-- module with needs = the addon is present (Compat.AddOnPresent), so only
-- installed addons show. The page stays in the list with none (`empty`:
-- the line it shows then).
add({ page = L["Integrations"], key = "integrations", icon = "plug", order = 65,
	subtitle = L["Settings for other addons Polestar works with, shown when they are installed."],
	empty = L["None of the addons Polestar works with is installed."] }, true)
-- EllesmereUI's skinning contract, or ErgoBars' under its own name
-- (Theme.SkinProvider): the section and its two switches name the suite
-- (EllesmereUI's strings kept as they were, so their translations stay).
do
	local ergo = Theme.SkinProvider() == "ErgoBars"
	add({ page = L["Integrations"], section = ergo and "ErgoBars" or "EllesmereUI", controls = {
		{ kind = "toggle", key = "ui.matchAccent", label = ergo and L["Match ErgoBars accent"] or L["Match EllesmereUI accent"],
			help = ergo and L["Follow ErgoBars' accent, live. Picking your own accent turns this off."]
				or L["Follow EllesmereUI's accent, live. Picking your own accent turns this off."],
			needs = function() return Theme.IsEllesmere() end },
		{ kind = "toggle", key = "ui.matchFont", label = ergo and L["Match ErgoBars font"] or L["Match EllesmereUI font"],
			help = ergo and L["Follow ErgoBars' font, live. Choosing another font turns this off."]
				or L["Follow EllesmereUI's font, live. Choosing another font turns this off."],
			needs = function() return Theme.IsEllesmere() end },
	} }, true)
end
add({ page = L["Integrations"], section = "Spoken", controls = {
	{ kind = "toggle", key = "behavior.spokenDelay", label = L["Wait for Spoken"],
		help = L["Waits 200 ms before each automatic quest accept, turn-in and reward pick, so Spoken has time to notice the window and read it."],
		search = "voice, narration, read aloud, dialogue, delay",
		needs = function() return ns.Compat.AddOnPresent("Spoken_Quests") end },
} }, true)

---------------------------------------------------------------------------
-- Custom pages: Recorder status and About
---------------------------------------------------------------------------

-- The Recorder's state and command stay in here with its page (the main
-- chunk's locals budget).
local placePair, buildRecorder
do
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
function placePair(view, pair, y, cw, layout)
	local h = 0
	for col, w in ipairs(pair) do
		w:ClearAllPoints()
		w:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad + (col - 1) * (cw + SIZE.GAP), -y)
		w:Show()
		h = max(h, layout(w, cw))
	end
	for _, w in ipairs(pair) do w:SetHeight(h) end
	return h
end

function buildRecorder(view)
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
		local cw = (win.BodyWidth - SIZE.GAP) / 2
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
end

-- Install (UI/Welcome.lua) as a control, so the search finds it ("install",
-- "setup", "wizard", "first run"): at home on Setup > Profiles, in the Install
-- & updates card (UI/Profiles.lua draws it). About keeps its Install tile.
-- Held back (ns.dungeonRoute), Install's groups page has no dungeon question, so neither text names dungeons.
local INSTALL = { kind = "button", icon = "palette", button = L["Install"], label = L["Set Polestar up again"],
	help = ns.dungeonRoute and L["Install's pages: questing, groups and dungeons, your route and your look, a page at a time. Each choice works at once."]
		or L["Install's pages: questing, groups, your route and your look, a page at a time. Each choice works at once."],
	search = "install, setup, set up, wizard, first run, first time, welcome, getting started, start again, onboarding",
	onClick = function() ns.Fire("SHOW_WELCOME") end }

-- Core/Update.lua's notices (0.3.7), at home on Setup > Profiles beside Install: shown once the setting is
-- registered.
local UPDATE = { kind = "toggle", key = "update.card", label = L["Tell me when a newer Polestar is out"],
	help = L["At login, a card on the guide window says a newer Polestar is out and how to update; Got it keeps it away for a day. A line in the guide window stays until you update. Two or more updates behind, both show even with this off (the card at most once a day)."],
	search = "update, new version, outdated, old version, release, curseforge, polestar client, upgrade" }

-- The Language setting (#3643; Core/Locale.lua keeps it, account-wide, in
-- PolestarLanguage): Follow the game, English, or a language Polestar ships,
-- each named in the language shown now. The strings are read as the files
-- load, so a change asks for a /reload (Later keeps the choice for the next one).
local LANGUAGE = { kind = "dropdown", label = L["Language"], new = "0.4.3",
	help = L["The language of Polestar's windows and guides. Follow the game: your game's language. Takes effect after a /reload."],
	search = "language, languages, english, german, deutsch, french, spanish, russian, korean, chinese, portuguese, translation, translated, locale",
	get = function() return ns.Language and ns.Language.Get() or "game" end,
	set = function(v)
		local Lang = ns.Language
		if not Lang then return end
		v = v or "game"
		if v == Lang.Get() or not Lang.Set(v) then return end
		W.Modal({ title = L["Reload now?"], icon = "reload", action = L["Reload UI"], cancel = L["Later"],
			text = L["Polestar shows the new language after a /reload."], onAccept = function() if ReloadUI then ReloadUI() end end })
	end,
	choices = function()
		local names = {
			game = L["Follow the game"], enUS = L["English"], deDE = L["German"], esES = L["Spanish (Spain)"], esMX = L["Spanish (Latin America)"],
			frFR = L["French"], koKR = L["Korean"], ptBR = L["Portuguese (Brazil)"], ruRU = L["Russian"], zhCN = L["Simplified Chinese"],
			zhTW = L["Traditional Chinese"],
		}
		local list = {}
		for _, code in ipairs(ns.Language and ns.Language.CHOICES or {}) do list[#list + 1] = { value = code, label = names[code] or code } end
		return list
	end }

-- The About hero: the sidebar's lockup at full size. The emblem (64, its ink
-- on the 32 edge, in its glow), then the wordmark (Media/UI/wordmark.tga,
-- 1:1, its ink 3px into the box and on rows 4-27), the tagline under it, and
-- the version with the release stage's chip.
local function buildAbout(view)
	local hero = CreateFrame("Frame", nil, view)
	hero:SetHeight(SIZE.HERO_H)
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
		.. hex .. "/polestar install|r   " .. L["set Polestar up again, a page at a time"] .. "\n"
		.. hex .. "/polestar report|r   " .. L["report a problem with a step on the Polestar Discord"] .. "\n"
		.. hex .. "/polestar arcade|r   " .. L["play Freedoom Arcade by petllama"] .. "\n"
		.. hex .. "/polestar jewels|r   " .. L["play Sky Jewels by RikyZ90"] .. "\n"
		.. hex .. "/polestar tetris|r   " .. L["play Tetris by beemerwt"] .. "\n"
		.. hex .. "/polestar help|r   " .. L["every command"])
	-- Install (UI/Welcome.lua) and what's new, first under the hero: the
	-- setup a new character gets, again whenever the player wants it.
	local install = W.ActionTile(view, "palette", L["Install"],
		ns.dungeonRoute and L["Set Polestar up again, a page at a time: questing, groups and dungeons, your route, your look. Each choice works at once."]
			or L["Set Polestar up again, a page at a time: questing, groups, your route, your look. Each choice works at once."],
		function() ns.Fire("SHOW_WELCOME") end)
	view.Install = install
	local whatsNew = W.ActionTile(view, "star", L["What's new"], L["What this version of Polestar changed for you."],
		function() ns.Fire("SHOW_WHATSNEW") end)
	view.WhatsNew = whatsNew
	local credH, credText = block(L["Credits"], L["Inter typeface by The Inter Project Authors, SIL Open Font License 1.1."] .. "\n"
		.. L["Wordmark set in Cinzel by The Cinzel Project Authors, SIL Open Font License 1.1."] .. "\n"
		.. L["Quest and map data includes pfQuest by shagu (MIT License)."] .. "\n"
		.. L["Freedoom Arcade by petllama (GPL-2.0 or later) plays three levels of Freedoom by the Freedoom project (BSD License), from the Polestar_Arcade folder."] .. "\n"
		.. L["Discord and its logo are trademarks of Discord Inc.; the logo marks the link to the Polestar Discord."] .. "\n"
		.. L["With EllesmereUI installed, Polestar can follow its accent, font and panel colour through its public skinning API."] .. "\n"
		.. L["Gear scores from Forever Leveling BiS by Timearc when it is installed, through its public API."])
	-- Special thanks (UI/Thanks.lua), under the credits: one supporter or
	-- contributor a time the page opens, a link to Guiding Stars.
	local thanksLead = W.Text(view, "note", "textDim")
	thanksLead:SetText(L["Special thanks to:"])
	local thanks = W.Link(view, "", function() O.Select("thanks") end, { role = "note" })
	thanks.psTip, thanks.psTipLines = L["Guiding Stars"], { L["Everyone who supports Polestar and helps build it."] }
	view.ThanksLead, view.Thanks = thanksLead, thanks
	local maintH = W.SectionHeader(view)
	W.SetSection(maintH, L["Maintenance"])
	-- The profile in use is what goes back: the dialog says whose it is, and
	-- one the whole account or a class uses asks for a word first.
	local resetAll = W.ActionTile(view, "reset", L["Reset all settings"], L["Every Polestar setting back to default. Progress is kept."],
		function()
			local P = ns.Profiles
			local name = P and P.Active and P.Active()
			local label = name and P.Label and P.Label(name) or ""
			local account = name ~= nil and P.AccountProfile and P.AccountProfile() == name
			local classes = 0
			local map = ns.DB().classProfiles
			for _, n in pairs(type(map) == "table" and map or {}) do if n == name then classes = classes + 1 end end
			local text
			if account then
				text = string.format(L["Every setting of the profile %s goes back to its default, for every character on the account that uses it. Your guides and progress are kept."], label)
			elseif classes > 0 then
				text = string.format(L["Every setting of the profile %s goes back to its default, for every character of the classes that use it. Your guides and progress are kept."], label)
			else
				text = string.format(L["Every setting of the profile %s, this character's, goes back to its default. Your guides and progress are kept."], label)
			end
			W.Modal({ title = L["Reset all settings?"], icon = "reset", danger = true, action = L["Reset all"], text = text,
				typeToConfirm = (account or classes > 0) and L["RESET"] or nil,
				onAccept = function() if ns.ResetSettings then ns.ResetSettings() end end })
		end, { danger = true })
	local resetPos = W.ActionTile(view, "window", L["Reset positions"], L["Guide window, arrow and these windows."], resetPositions)
	view.ResetAll = resetAll
	view.Refresh = function()
		ver:SetText(versionLine())
		W.SetStageChip(stage)
		local width = win.BodyWidth
		local cw = (width - SIZE.GAP) / 2
		local y = 12
		hero:ClearAllPoints()
		hero:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		hero:SetWidth(width)
		y = y + SIZE.HERO_H
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
		y = y + placePair(view, { install, whatsNew }, y, cw, W.LayoutTile) + 12
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
		end
		local name = UI.Thanks.PickName()
		thanksLead:SetShown(name ~= nil)
		thanks:SetShown(name ~= nil)
		if name then
			W.SetLinkText(thanks, ns.EscapeText and ns.EscapeText(name) or name)
			thanksLead:ClearAllPoints()
			thanksLead:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -(y + 2))
			thanks:ClearAllPoints()
			thanks:SetPoint("LEFT", thanksLead, "RIGHT", 4, 0)
			y = y + 20 + 8
		end
		maintH:ClearAllPoints()
		maintH:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		maintH:SetWidth(width)
		y = y + 44 + 4
		return y + placePair(view, { resetAll, resetPos }, y, cw, W.LayoutTile) + 24
	end
end

add({ page = L["Community guides"], key = "guidepacks", icon = "guides", order = 70, subtitle = L["Guides made by other players: switch them on or off, and choose where suggestions come from."],
	custom = UI.Packs.Build, dot = UI.Packs.HasProblems }, true)
add({ page = L["Guiding Stars"], key = "thanks", icon = "star", order = 80, subtitle = L["Celebrating the supporters, contributors and bug reporters behind Polestar."],
	custom = UI.Thanks.Build }, true)
add({ page = REC, key = "recorder", icon = "record", order = 90, subtitle = L["The data recorder for guide authors."], custom = buildRecorder }, true)
add({ page = ABOUT, key = "about", icon = "info", order = 100, subtitle = L["Why Polestar exists, its commands and its credits."], custom = buildAbout }, true)
-- Setup > General (key "language": the old key "general" still reaches Look > Guide window, ALIASES).
add({ page = L["General"], key = "language", icon = "icon-talk", order = 63, group = "setup", subtitle = L["The language Polestar shows."],
	section = L["Language"], controls = { LANGUAGE } }, true)
-- Install and the update notices: Setup > Profiles' Install & updates card, where a first install and
-- troubleshooting look (UI/Profiles.lua draws the card; the page's own registration there).
add({ page = L["Profiles"], key = "profiles", icon = "layers", order = 64, group = "setup", tab = L["Profiles"],
	section = L["Install & updates"], controls = { INSTALL, UPDATE } }, true)

-- Page keys from before the pages were regrouped (and older section names)
-- reach the page, and the tab, that holds those settings now. A page's own
-- key wins: "arrow" and "guidewindow" open the Look pages where those exist.
local ALIASES = {
	general = { "guidewindow", L["Window"] }, window = { "guidewindow", L["Window"] },
	navigation = { "guide", L["Arrow & routes"] }, nav = { "guide", L["Arrow & routes"] }, arrow = { "guide", L["Arrow & routes"] },
	automation = { "guide", L["Automation"] }, behavior = { "guide", L["Automation"] }, behaviour = { "guide", L["Automation"] },
	quests = { "questing", L["Quests"] }, gear = { "questing", L["Rewards & gear"] },
	lookup = { "discovery", L["Lookup"] }, dungeons = { "discovery", L["Dungeons"] }, rares = { "discovery", L["Rares"] },
	characters = { "discovery", L["Lookup"] }, alts = { "discovery", L["Lookup"] },
	appearance = { "theme" }, look = { "theme" }, qol = { "qualityoflife" },
	-- The target list's Polestar mark (QoL/Buttons.lua): Questing > Buttons, where Targeting is.
	targeting = { "questing", L["Buttons"] },
}

---------------------------------------------------------------------------
-- Controls and the grid
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- References (Essentials). A control with `ref = true` stands for the
-- control registered under its key elsewhere (its home, on a deep tab of
-- the page, else of any page): it takes every field of its home's (kind,
-- range, format, choices, help, search, disabled, needs, extras, ...) but
-- the home's cog and New mark, and the fields given beside `ref` win (a
-- shorter label, other extras). Resolved when first needed, so the order of
-- registration does not matter; with no home registered it is left out.
-- Search, the profiles' checks and O.AllControls see the homes alone.
---------------------------------------------------------------------------

-- What a reference never takes from its home: where it stands, its own
-- state (ps* fields), the home's cog, Move and New mark.
local homeOf
do
	local REF_OWN = { page = true, tab = true, section = true, more = true, move = true, new = true, child = true }

	-- -> the home of reference c, or nil (c is no reference, or has no home yet)
	function homeOf(c)
		local home = rawget(c, "psHome")
		if home or not rawget(c, "ref") then return home end
		local same, other
		local function look(x, onPage)
			if same then return end
			if x ~= c and not rawget(x, "ref") and x.key == c.key then
				if onPage then same = x elseif not other then other = x end
			end
			for _, e in ipairs(rawget(x, "extras") or {}) do look(e, onPage) end
			local m = rawget(x, "more")
			for _, y in ipairs(type(m) == "table" and m or {}) do look(y, onPage) end
		end
		for _, p in ipairs(pageList) do
			local onPage = p == rawget(c, "page")
			for _, t in ipairs(p.tabs) do
				for _, s in ipairs(t.sections) do
					if s.toggle then look(s.toggle, onPage) end
					for _, x in ipairs(s.controls) do look(x, onPage) end
				end
			end
		end
		home = same or other
		if not home then return nil end
		rawset(c, "psHome", home)
		setmetatable(c, { __index = function(_, k)
			if REF_OWN[k] or (type(k) == "string" and k:sub(1, 2) == "ps") then return nil end
			return home[k]
		end })
		return home
	end
end
O.HomeOf = homeOf

-- A reference for a page's spec: kind and key (what RegisterOptions checks),
-- `ref`, and any fields given (a shorter label, other extras): W.Ref
-- (Polestar/Theme/Widgets.lua).
O.Ref = W.Ref

local function available(c)
	if rawget(c, "ref") and not homeOf(c) then return false end
	if c.needs and not c.needs() then return false end
	if c.kind == "button" then return true end
	if c.kind == "binding" then return ns.Gamepad ~= nil and ns.Gamepad.BindingRow ~= nil end
	-- A toggle, slider, dropdown or cards with get/set and no key holds state
	-- that is no setting (per character, or a preset the cards' get recognises).
	if (c.kind == "toggle" or c.kind == "slider" or c.kind == "dropdown" or c.kind == "cards") and not c.key and c.get and c.set then return true end
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
	-- limit = n: the first n choices, then the one in use if it is past them (an Essentials reference).
	local limit = tonumber(c.limit)
	local cur
	if limit then
		if c.get then cur = c.get() elseif c.key then cur = ns.Get(c.key) end
	end
	for i, ch in ipairs(list or {}) do
		if not limit or i <= limit or ch.value == cur then
			out[#out + 1] = { value = ch.value, text = ch.text or ch.label or tostring(ch.value), font = ch.font, draw = ch.draw,
				disabled = ch.disabled, note = ch.note, tag = ch.tag, tagTip = ch.tagTip, tip = ch.tip, preview = ch.preview, group = ch.group }
		end
	end
	return out
end

local watching = setmetatable({}, { __mode = "k" }) -- widget -> the settings it shows (c.watch)

local function makeControl(parent, c)
	local w
	local getset = (c.get or c.set) and { get = c.get, set = c.set } or nil
	if c.kind == "toggle" then
		w = W.Toggle(parent, labelOf(c), c.key, c.help, nil, (c.gear or c.get or c.set) and { gear = c.gear, get = c.get, set = c.set } or nil)
	elseif c.kind == "slider" then
		local opts
		if c.release or c.get or c.set or c.parse then opts = { release = c.release, get = c.get, set = c.set, parse = c.parse } end
		w = W.Slider(parent, labelOf(c), c.key, c.min or 0, c.max or 1, c.step or 0.1, c.format, c.help, nil, opts)
	elseif c.kind == "dropdown" or c.kind == "font" then
		local choices = type(c.choices) == "function" and function() return choicesOf(c) end or choicesOf(c)
		local opts = getset
		if c.kind == "font" then opts = { get = c.get, set = c.set, faces = true } end
		-- State that is no setting: a right-click puts back its default through set(nil), as Reset does.
		if c.kind == "dropdown" and not c.key and c.get and c.set then opts = { get = c.get, set = c.set, reset = true } end
		w = W.Dropdown(parent, labelOf(c), c.key, choices, c.help, nil, opts)
	elseif c.kind == "cards" then
		local choices = type(c.choices) == "function" and function() return choicesOf(c) end or choicesOf(c)
		w = W.Cards(parent, labelOf(c), c.key, choices, c.help, { get = getset and getset.get, set = getset and getset.set, art = c.art, grid = c.grid })
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
	if c.watch then watching[w] = c.watch end
	return w
end
-- A control from its spec, as the pages make them.
O.Control = makeControl

-- A widget that shows several settings (c.watch = { [key] = true }: the
-- presets' cards) repaints when one of them changes, or all of them do.
ns.On("SETTING_CHANGED", function(path)
	for w, keys in pairs(watching) do
		if (path == nil or path == "" or keys[path] or not path:find(".", 1, true)) and w:IsVisible() and w.Refresh then w:Refresh() end
	end
end)

---------------------------------------------------------------------------
-- New settings. A control's `new` (the release it came in: "0.3.8") puts a
-- quiet accent ring in its row's gutter, and one on its page's row in the
-- sidebar (no count) until the page is opened. PolestarDB.optionsSeen[page key] holds the newest
-- release whose settings the player has seen on that page (account-wide,
-- not a setting), and ["*"] the newest seen on every page: a fresh install's
-- (core's UI/OptionsLoader.lua marks it true, the window's first opening
-- takes it as the newest release among its settings). The rows keep their badges through the session a page is
-- first opened in: they read the seen state as it was when the window
-- first opened.
---------------------------------------------------------------------------

-- Is version a newer than b ("0.3.10" > "0.3.7"; nil is oldest)? Each pair
-- is worked out once (the sidebar asks for every setting on each change).
local newerOf = {} -- a -> b -> boolean
local function newer(a, b)
	if type(a) ~= "string" then return false end
	if type(b) ~= "string" then return true end
	local row = newerOf[a]
	if not row then
		row = {}
		newerOf[a] = row
	end
	local known = row[b]
	if known ~= nil then return known end
	local ia, ib = a:gmatch("%d+"), b:gmatch("%d+")
	while true do
		local x, y = ia(), ib()
		if not x and not y then
			known = false
			break
		end
		x, y = tonumber(x) or 0, tonumber(y) or 0
		if x ~= y then
			known = x > y
			break
		end
	end
	row[b] = known
	return known
end
O.Newer = newer

local seenAtOpen
local function seenTable()
	local db = ns.DB()
	if type(db.optionsSeen) ~= "table" then db.optionsSeen = {} end
	local seen = db.optionsSeen
	if seen["*"] == true then
		local top
		for _, p in ipairs(pageList) do
			for _, x in ipairs(Index.newList(p)) do
				if newer(x.new, top) then top = x.new end
			end
		end
		seen["*"] = top
	end
	if not seenAtOpen then
		seenAtOpen = {}
		for k, v in pairs(db.optionsSeen) do seenAtOpen[k] = v end
	end
	return db.optionsSeen
end

local function rowIsNew(c)
	if not (c.new and c.page) then return false end
	seenTable()
	return newer(c.new, seenAtOpen[c.page.key]) and newer(c.new, seenAtOpen["*"])
end

---------------------------------------------------------------------------
-- Rows and sections (DESIGN.md "The Row Rule", "Body"). A section is a card
-- across the body: a 36px header (its title; at the right, right to left,
-- its on/off (the spec's `toggle`), Reset while a setting in it is off its
-- default) over rows of 36px, each
-- two halves split by a hairline (one half below HALVES_MIN, `wide` and
-- picture cards across both). A half is a setting's label and control, its
-- `extras` inline before the control and its `more` behind a cog; its help is
-- the tooltip. While a section's toggle is off, its rows dim and stop.
---------------------------------------------------------------------------

local SECTION_GAP, HALVES_MIN, MORE_W, MORE_ROW = 24, 760, 300, 30
-- The search results' chevron gutter, inside the card left of each row.
local SEARCH_GUTTER = 28

-- The visible controls of a section.
local function visible(section)
	local out = {}
	for _, c in ipairs(section.controls) do
		if available(c) then out[#out + 1] = c end
	end
	return out
end

-- fn(x) for a control and every setting it holds: its extras, its cog's.
local function eachSetting(c, fn)
	fn(c)
	for _, e in ipairs(c.extras or {}) do fn(e) end
	for _, m in ipairs(c.more or {}) do eachSetting(m, fn) end
end

-- Every available setting of a section (its toggle, its controls and what
-- they hold), or of the controls given. -> list
local function sectionSettings(s, controls)
	local out = {}
	if s and s.toggle and available(s.toggle) then out[#out + 1] = s.toggle end
	for _, c in ipairs(controls or (s and visible(s)) or {}) do
		eachSetting(c, function(x) if x == c or available(x) then out[#out + 1] = x end end)
	end
	return out
end

-- Every setting spec of a section, available or not: its toggle, its
-- controls and what they hold. -> list
local function allSettings(s)
	local out = {}
	if s.toggle then out[1] = s.toggle end
	for _, c in ipairs(s.controls) do eachSetting(c, function(x) out[#out + 1] = x end) end
	return out
end

-- Every setting of a section that is a home: no reference (Essentials) and
-- nothing a reference shows of its home's (its extras). -> list
local function homeSettings(s)
	local out = {}
	if s.toggle and not rawget(s.toggle, "ref") then out[1] = s.toggle end
	for _, c in ipairs(s.controls) do
		if not rawget(c, "ref") then
			eachSetting(c, function(x) if not rawget(x, "ref") then out[#out + 1] = x end end)
		end
	end
	return out
end

-- Whether setting spec x is off its default: one with a value of its own
-- stored (a value at its default is never stored: the rest read theirs).
local function offDefault(x)
	return x.key ~= nil and x.kind ~= "button" and x.kind ~= "binding" and ns.GetStored(x.key) ~= nil and W.Modified(x.key)
end

-- The settings of a list that are off their default. -> count
local function modifiedCount(controls)
	local n = 0
	for _, c in ipairs(controls) do
		if offDefault(c) then n = n + 1 end
	end
	return n
end
O.ModifiedCount = modifiedCount

-- Whether c's extras or what its cog holds, each while available, hold a
-- setting off its default (the stored value asked first, availability last).
local function heldOff(c)
	local ex = c.extras
	if ex then
		for _, e in ipairs(ex) do
			if offDefault(e) and available(e) then return true end
		end
	end
	local more = c.more
	if more then
		for _, m in ipairs(more) do
			if (offDefault(m) and available(m)) or heldOff(m) then return true end
		end
	end
	return false
end

-- Whether c or anything it holds, available or not, is off its default.
local function anyOff(c)
	if offDefault(c) then return true end
	local ex = c.extras
	if ex then
		for _, e in ipairs(ex) do
			if offDefault(e) then return true end
		end
	end
	local more = c.more
	if more then
		for _, m in ipairs(more) do
			if anyOff(m) then return true end
		end
	end
	return false
end

-- Whether a section holds a setting off its default, as
-- modifiedCount(sectionSettings(s)) > 0 says, without making the lists. Only
-- its controls holding a setting off its default can (anyOff), so those are
-- kept per section (s.psOff), worked out again when one of the section's
-- settings changes (O.SettingMoved) or every setting may have.
local function sectionModified(s)
	local off = s.psOff
	if not off then
		local toggle = s.toggle and offDefault(s.toggle) or false
		for _, c in ipairs(s.controls) do
			if anyOff(c) then
				off = off or { toggle = toggle }
				off[#off + 1] = c
			end
		end
		-- (Most sections hold nothing off: one shared empty list for them.)
		if not off then
			Index.noneOff = Index.noneOff or { toggle = false }
			off = toggle and { toggle = true } or Index.noneOff
		end
		s.psOff = off
	end
	if off.toggle and available(s.toggle) then return true end
	for i = 1, #off do
		local c = off[i]
		if (offDefault(c) or heldOff(c)) and available(c) then return true end
	end
	return false
end

-- The footer's Undo for what a reset changed (filled in further down).
local Undo = {}

-- What a list of controls holds off its default, for Undo: { path, value }
-- per setting (as stored), { get, set, value } per state that is no
-- setting; each setting once.
function Undo.holdings(controls)
	local out, seen = {}, {}
	for _, c in ipairs(controls) do
		if c.key and c.kind ~= "button" and c.kind ~= "binding" then
			if not seen[c.key] then
				seen[c.key] = true
				local was = ns.GetStored(c.key)
				if was ~= nil then out[#out + 1] = { path = c.key, value = was } end
			end
		elseif (c.kind == "toggle" or c.kind == "slider" or c.kind == "dropdown" or c.kind == "cards") and not c.key and c.set and c.get then
			out[#out + 1] = { get = c.get, set = c.set, value = c.get() }
		end
	end
	return out
end

-- Every setting of a list back to its default (state that is no setting
-- too, through its set(nil)); the footer offers to undo it.
function O.ResetSection(controls)
	local held = Undo.holdings(controls)
	ns.Batch(function()
		for _, c in ipairs(controls) do
			if c.key and c.kind ~= "button" and c.kind ~= "binding" then
				if ns.GetStored(c.key) ~= nil then ns.Set(c.key, nil) end
			elseif (c.kind == "toggle" or c.kind == "slider" or c.kind == "dropdown" or c.kind == "cards") and not c.key and c.set then
				c.set(nil)
			end
		end
	end)
	local view = O.view
	if view and view.cache then
		for _, c in ipairs(controls) do
			local w = view.cache[c]
			if w and not c.key and w.Refresh then w:Refresh() end
		end
	end
	Undo.offer(held)
end

-- Is a section's on/off (its header's toggle) off?
local function sectionOff(s)
	local t = s and s.toggle
	return t ~= nil and t.key ~= nil and available(t) and not ns.Get(t.key)
end

-- Whether a parent's children (c.children) are open: its open() says, else
-- its switch (get(), else its setting) is on.
local function kidsOpen(c)
	local fn = c.open or c.get
	if fn then
		local ok, v = pcall(fn)
		return ok and v and true or false
	end
	return c.key ~= nil and ns.Get(c.key) and true or false
end
O.KidsOpen = kidsOpen

-- Whether a parent's children, while closed, hold a setting off its default
-- (its row's hollow ring says so).
function Index.kidsHidden(c)
	local kids = rawget(c, "psKids")
	if not kids or kidsOpen(c) then return false end
	for _, k in ipairs(kids) do
		if offDefault(k) and available(k) then return true end
	end
	return false
end

-- Is a section on screen? Its spec's shown() says (none: always).
local function sectionShown(s)
	if not s.shown then return true end
	local ok, v = pcall(s.shown)
	return not ok or v ~= false and v ~= nil
end

-- Which of a tab's sections with a shown() are on screen, and which of its
-- parents have their children open, as a string: when it moves, the tab lays
-- out again.
local function shownSig(t)
	local sig = ""
	for _, s in ipairs(t and t.sections or {}) do
		if s.shown then sig = sig .. (sectionShown(s) and "1" or "0") end
		for _, c in ipairs(s.controls or {}) do
			if rawget(c, "psKids") then sig = sig .. (kidsOpen(c) and "+" or "-") end
		end
	end
	return sig
end

-- A setting is off while its section's toggle is, or its own `disabled` says.
local function disabledOf(c)
	return function()
		local s = c.psSection
		if s and s.toggle ~= c and sectionOff(s) then return true end
		-- A child, while its parent is off (search results show it so).
		local parent = rawget(c, "psChildOf")
		if parent and not kidsOpen(parent) then return true end
		if c.disabled then
			local ok, off = pcall(c.disabled)
			if ok and off then return true end
		end
		return false
	end
end

-- Why a setting is off, for its tooltip: its section's toggle, or the
-- on/off it depends on (the parent a child follows, the row an extra is on).
local function whyOff(c)
	-- A row that says why its own test turns it off (c.offWhy).
	if c.offWhy and c.disabled then
		local ok, off = pcall(c.disabled)
		if ok and off then return type(c.offWhy) == "function" and c.offWhy() or c.offWhy end
	end
	local s = c.psSection
	if s and s.toggle ~= c and sectionOff(s) then return string.format(L["Turn on %s first."], labelOf(s.toggle) or "") end
	local kidOf = rawget(c, "psChildOf")
	if kidOf and not kidsOpen(kidOf) then return string.format(L["Turn on %s first."], labelOf(kidOf) or "") end
	local parent = c.psParent or c.psOwner
	if parent and parent.kind == "toggle" and parent.key and not ns.Get(parent.key) then
		return string.format(L["Turn on %s first."], labelOf(parent) or "")
	end
	return nil
end

-- Where a setting lives: "Page · Tab · Section" (a search result's tooltip).
local function pathOf(c)
	local parts = { c.page and c.page.name or nil }
	if c.tab and c.tab ~= "" then parts[#parts + 1] = c.tab end
	if c.section and c.section ~= "" then parts[#parts + 1] = c.section end
	return table.concat(parts, "  \194\183  ")
end

-- A setting's tooltip lines: its help, where its colour comes from while it
-- follows one, why it is off, that right-click resets it, and where it
-- lives (search results, and a reference: its home's page, tab and section).
local function tipOf(c, withPath)
	return function(w)
		local lines = {}
		if type(c.help) == "string" and c.help ~= "" then lines[#lines + 1] = c.help end
		if c.source and c.key and not W.Modified(c.key) then
			local ok, src = pcall(c.source)
			if ok and src and src ~= "" then lines[#lines + 1] = { string.format(L["From: %s"], src), Theme.Color("textDim") } end
		end
		local on = W.Enabled(w)
		if not on then
			local why = whyOff(c)
			if why then lines[#lines + 1] = { why, Theme.Color("warning") } end
		end
		if on and c.key and W.Modified(c.key) then lines[#lines + 1] = { L["Right-click to reset."], Theme.Color("textMuted") } end
		-- The ring shows while the setting is at its default: its tooltip says what the ring means.
		if rowIsNew(c) and not (c.key and W.Modified(c.key)) then
			lines[#lines + 1] = { string.format(L["New in %s"], c.new), Theme.Color("accent") }
		end
		if Index.kidsHidden(c) then lines[#lines + 1] = { L["A setting under it is changed: turn it on to see it."], Theme.Color("textMuted") } end
		local home = homeOf(c)
		if withPath or home then lines[#lines + 1] = { pathOf(home or c), Theme.Color("textMuted") } end
		return lines
	end
end
O.TipOf = tipOf

-- An inline control or cog: dimmed while it is off, unless the row it sits
-- on is (the row dims it already).
local function inlineRefresh(self)
	local on = W.Enabled(self)
	local row = self:GetParent()
	local rowOff = row and row.IsEnabled and not row:IsEnabled()
	self:SetAlpha((on or rowOff) and 1 or 0.4)
	if on then self:Enable() else self:Disable() end
end

-- Tell the preview on screen which setting the pointer is on: its frame's
-- optional f:Focus(key) (a preview that scrolls to the part it draws). Off a
-- row (nil) the lights go out FOCUS_GRACE later, unless the pointer lands on
-- another row first: crossing the gap between two rows, columns or sections
-- hands the lights over without them blinking out. One timer at a time, no
-- closure per hover.
do
	local FOCUS_GRACE = 0.15
	local offAt, offView, waiting
	local function lightsOut()
		waiting = nil
		if not offAt then return end
		local left = offAt - GetTime()
		if left > 0.001 then
			waiting = true
			C_Timer.After(left, lightsOut)
			return
		end
		local view = offView
		offAt, offView = nil, nil
		UI.Preview.Focus(view, nil)
	end
	function O.PreviewFocus(key)
		if key == nil then
			offAt, offView = GetTime() + FOCUS_GRACE, O.view
			if not waiting then
				waiting = true
				C_Timer.After(FOCUS_GRACE, lightsOut)
			end
			return
		end
		-- A row of another tab: the one left goes dark now.
		if offView and offView ~= O.view then UI.Preview.Focus(offView, nil) end
		offAt, offView = nil, nil
		UI.Preview.Focus(O.view, key)
	end
end

-- A row's Move glyph, in its extras' Move column, whose setting places a
-- frame (`move`, the frame's mover key in UI/Movers.lua): O.MoveFrame. Off
-- while the frame has no box (its feature off) or its setting is.
local function moveButton(parent, key, label, offFn, onClick)
	local b = W.IconButton(parent, "move", W.RowParts.COMPACT_CHIP, L["Move"], onClick, 13)
	b.psMove, b.psInline, b.psLabel = true, true, L["Move"]
	b.psTipLines = { string.format(L["Opens Move frames with %s picked; the settings come back when you are done."], label or "") }
	b.Refresh = inlineRefresh
	W.SetDisabledWhen(b, function()
		local M = ns.Movers
		if not (M and M.Movable and M.Movable(key)) then return true end
		return offFn and offFn() or false
	end)
	return b
end

-- A setting's half, built once per view (view: a page tab's, the search
-- results', the cog popup's), with its extras, its cog and its Move.
local function rowOf(view, c)
	local w = view.cache[c]
	if w then return w end
	w = makeControl(view, c)
	W.SetDisabledWhen(w, disabledOf(c))
	-- Shift + the wheel over a slider scales the window, as anywhere on it.
	if rawget(w, "Slider") and O.WheelScales then O.WheelScales(w.Slider) end
	local extras
	for _, e in ipairs(c.extras or {}) do
		if available(e) then
			local x
			if e.kind == "color" then
				x = W.InlineSwatch(w, e.key, labelOf(e), tipOf(e, view.psSearch), { alpha = e.alpha, shown = e.shown, linked = e.linked })
			else
				x = W.InlineToggle(w, e.key, labelOf(e), tipOf(e, view.psSearch))
			end
			x.psControl = e
			-- A reference's row shows its home's extras: these stand for them too.
			if rawget(c, "ref") and not rawget(c, "extras") then x.psViaRef = true end
			W.SetDisabledWhen(x, disabledOf(e))
			extras = extras or {}
			extras[#extras + 1] = x
			view.extras[e] = x
		end
	end
	local cog
	if c.more and #c.more > 0 then
		cog = W.Cog(w, string.format(L["More: %s"], labelOf(c) or ""), function(self) O.ShowMore(self, c) end)
		cog.psControl = c
		cog.Refresh = inlineRefresh
		W.SetDisabledWhen(cog, disabledOf(c))
		view.cogs[c] = cog
	end
	-- Move: a glyph in the extras' Move column, after the cog's.
	if c.move and ns.Movers and ns.Movers.Unlock then
		local move = moveButton(w, c.move, labelOf(c), disabledOf(c), function() O.MoveFrame(c.move, w) end)
		w.MoveButton = move
		extras = extras or {}
		extras[#extras + 1] = move
	end
	-- Picture cards named as their section need no label of their own: the
	-- card's header says it.
	local bare = c.kind == "cards" and not view.psSearch and labelOf(c) == c.section
	W.CompactRow(w, { tip = tipOf(c, view.psSearch), info = c.info, extras = extras, cog = cog,
		height = view.psRowH, bare = bare })
	-- New to the player: a 6px accent ring in the label's gutter, the changed
	-- mark's place (markSections shows the one that applies).
	if rowIsNew(c) and rawget(w, "ModDot") then
		w.NewRing = W.Tex(w, "ARTWORK", "ring", "accent")
		w.NewRing:SetSize(6, 6)
		w.NewRing:SetPoint("CENTER", w.ModDot, "CENTER", 0, 0)
	end
	-- The pointer on the row, an extra or the cog: the tab's preview lights
	-- the parts that setting changes and may show the part it draws
	-- (f:Focus(key), optional); off them, the lights go out.
	if not view.psSearch then
		local function off() O.PreviewFocus(nil) end
		w:HookScript("OnEnter", function() O.PreviewFocus(c.key) end)
		w:HookScript("OnLeave", off)
		for _, x in ipairs(extras or {}) do
			-- Move stands for the row's own setting.
			x:HookScript("OnEnter", function(self) O.PreviewFocus(self.psControl and self.psControl.key or c.key) end)
			x:HookScript("OnLeave", off)
		end
		if cog then
			cog:HookScript("OnEnter", function() O.PreviewFocus(c.key) end)
			cog:HookScript("OnLeave", off)
		end
	end
	view.cache[c] = w
	return w
end

-- The vertical hairline between two halves (pooled per view), on a layer of
-- its own over the section cards' grounds.
local function midRule(view, n)
	local t = view.mids[n]
	if not t then
		local layer = rawget(view, "MidLayer")
		if not layer then
			layer = CreateFrame("Frame", nil, view)
			layer:SetAllPoints(view)
			layer:SetFrameLevel(view:GetFrameLevel() + 2)
			view.MidLayer = layer
		end
		t = W.Divider(layer, true)
		view.mids[n] = t
	end
	return t
end

-- A parent's open children stand under its line on a 2px accent rule at
-- their left (pooled per view, like the halves' hairlines).
function Index.kidRule(view, n)
	local pool = rawget(view, "psKidRules")
	if not pool then
		pool = {}
		view.psKidRules = pool
	end
	local t = pool[n]
	if not t then
		local layer = rawget(view, "MidLayer")
		if not layer then
			layer = CreateFrame("Frame", nil, view)
			layer:SetAllPoints(view)
			layer:SetFrameLevel(view:GetFrameLevel() + 2)
			view.MidLayer = layer
		end
		t = W.Tex(layer, "ARTWORK", nil, "accent")
		W.Color(t, "accent", 0.5)
		pool[n] = t
	end
	return t
end

-- layoutRows' working state, one table per view kept from call to call, and
-- its steps as functions of it: no closure or table per call (the search
-- lays out every result's section on each keystroke). S: the view, the grid
-- (two, x, width, half), the pen (y), the open line's left half and its
-- height (bl, blH), the top of the run of halves (run), the last line's rows
-- (lineRows), the rows placed so far (placed, only where children nest) and
-- the children waiting for their parent's line (waiting).
local layoutRows
do
	local Lay = {}

	-- A new line: the last line's rows are no longer the last.
	function Lay.newLine(S)
		local rows = S.lineRows
		for i = #rows, 1, -1 do rows[i] = nil end
	end

	function Lay.place(S, w, px, pw, indent)
		local view = S.view
		w.psColumns = view.psColumns
		w.psIndent = indent > 0 and indent or nil
		w:ClearAllPoints()
		w:SetPoint("TOPLEFT", view, "TOPLEFT", px, -S.y)
		w:Show()
		if w.Refresh then w:Refresh() end
		w.psTop = S.y
		if w.Rule then w.Rule:Show() end
		S.lineRows[#S.lineRows + 1] = w
		return W.LayoutRow(w, pw)
	end

	-- The hairline down the run of halves that ends at y.
	function Lay.endRun(S)
		local run, view = S.run, S.view
		if run and S.y > run then
			view.psMid = (view.psMid or 0) + 1
			local m = midRule(view, view.psMid)
			m:ClearAllPoints()
			m:SetPoint("TOPLEFT", view, "TOPLEFT", S.x + S.half, -run)
			m:SetSize(1, S.y - run)
			m:Show()
		end
		S.run = nil
	end

	-- A row in the next half of the grid, `indent` into its column (w.psCol:
	-- "L" or "R"). -> true when it closed a line
	function Lay.pair(S, w, indent)
		local x, half = S.x, S.half
		if not S.two then
			Lay.newLine(S)
			w.psCol = "L"
			S.y = S.y + Lay.place(S, w, x + indent, S.width - indent, indent)
		elseif S.bl then
			local bl = S.bl
			w.psCol = "R"
			local h = Lay.place(S, w, x + half + indent, S.width - half - indent, indent)
			-- The two halves stand as tall as the taller one (a label on two
			-- lines), so their hairlines meet.
			local lineH = max(S.blH, h)
			bl:SetHeight(lineH)
			w:SetHeight(lineH)
			bl.psPair, w.psPair = w, bl
			S.y, S.bl = S.y + lineH, nil
			return true
		else
			Lay.newLine(S)
			S.run = S.run or S.y
			S.bl, w.psCol = w, "L"
			S.blH = Lay.place(S, w, x + indent, half - indent, indent)
		end
	end

	function Lay.close(S)
		if S.bl then S.y, S.bl = S.y + S.blH, nil end
	end

	-- A column's accent rule beside a block of children, from..to.
	function Lay.kidRule(S, colX, from, to)
		local view = S.view
		view.psKidRule = (view.psKidRule or 0) + 1
		local t = Index.kidRule(view, view.psKidRule)
		t:ClearAllPoints()
		t:SetPoint("TOPLEFT", view, "TOPLEFT", colX + SIZE.KIDS_X - 10, -(from + 6))
		t:SetSize(2, max(1, to - from - 12))
		t:Show()
	end

	-- The children waiting for their parent's line to close: a block per
	-- parent (both halves of a line may be parents), in their order.
	function Lay.openKids(S)
		local blocks = S.waiting
		if not blocks then return end
		S.waiting = nil
		Lay.close(S)
		for _, kids in ipairs(blocks) do
			local from, rightTo = S.y, nil
			for _, k in ipairs(kids) do
				-- A right half closes its line: the right rule reaches its foot.
				if Lay.pair(S, rowOf(S.view, k), SIZE.KIDS_X) then rightTo = S.y end
			end
			Lay.close(S)
			Lay.kidRule(S, S.x, from, S.y)
			if rightTo then Lay.kidRule(S, S.x + S.half, from, rightTo) end
		end
	end

	-- A list of controls as rows of halves from y, across `width` at x (all
	-- across with `whole`). The view keeps its rows (view.cache). The halves
	-- stand on one grid: a left column at x, a right one at x + half, split by
	-- one hairline down each run of halves (a row across ends a run). A parent's
	-- children (c.children) follow it: while it is on, they wait for the
	-- parent's line to close (its half beside it stays), then stand under it in
	-- halves of their own on the same grid, each SIZE.KIDS_X into its column,
	-- an accent rule at the same place in each column they use; while it is
	-- off, they are made but hidden. Search results and filtered lists
	-- (view.psSearch, view.psFlat) show them as any row, dimmed while their
	-- parent is off. -> height
	function layoutRows(view, controls, top, x, width, whole)
		local S = rawget(view, "psLay")
		-- Busy (a row's layout laying out this view again): a state of its own.
		if not S or S.view then
			S = { lineRows = {}, placed = {} }
			if not rawget(view, "psLay") then view.psLay = S end
		end
		S.view, S.x, S.width = view, x, width
		S.two = not whole and width >= HALVES_MIN
		S.half = floor(width / 2)
		S.y, S.run, S.bl, S.blH, S.waiting = top, nil, nil, 0, nil
		Lay.newLine(S)
		local nest = not (rawget(view, "psSearch") or rawget(view, "psFlat"))
		local placed = S.placed
		if nest then for c in pairs(placed) do placed[c] = nil end end
		for _, c in ipairs(controls) do
			local parent = nest and rawget(c, "psChildOf")
			if parent and placed[parent] then
				if kidsOpen(parent) then
					local waiting = S.waiting or {}
					S.waiting = waiting
					local last = waiting[#waiting]
					if not (last and last.psFor == parent) then
						last = { psFor = parent }
						waiting[#waiting + 1] = last
					end
					last[#last + 1] = c
				else
					-- Made, not placed: hidden until its parent opens.
					rowOf(view, c):Hide()
				end
			else
				if nest then placed[c] = true end
				local w = rowOf(view, c)
				if not S.two or c.wide or c.kind == "cards" then
					Lay.close(S)
					Lay.openKids(S)
					Lay.endRun(S)
					Lay.newLine(S)
					w.psCol = nil
					S.y = S.y + Lay.place(S, w, x, width, 0)
				else
					-- A row starting a line: the children before it open first.
					if not S.bl then Lay.openKids(S) end
					if Lay.pair(S, w, 0) then Lay.openKids(S) end
				end
			end
		end
		Lay.close(S)
		Lay.openKids(S)
		Lay.endRun(S)
		-- The last line's hairline would double the card's edge.
		for _, w in ipairs(S.lineRows) do if w.Rule then w.Rule:Hide() end end
		S.view = nil
		return S.y - top
	end
end

-- Header widgets, right to left from the 16 edge: the toggle, Move, More,
-- Reset, New. A Legend card (the new page's, card.psLegend): its title, the
-- module's pill, "N changed" and Reset in the card's top border.
local function placeHeader(card)
	if card.psLegend then
		-- A group's own count, Reset and lead link (the Changed view's page cards).
		local count = rawget(card, "psCount") or (card.psSettings and modifiedCount(card.psSettings) or 0)
		card.Legend:Set({ title = card.psName, count = count, onReset = rawget(card, "psReset") or card.psOnReset,
			toggle = card.psToggle, extras = { card.Move, card.More, rawget(card, "psLead") } })
		return
	end
	local x = 16
	local function put(f)
		f:ClearAllPoints()
		f:SetPoint("RIGHT", card.Header, "RIGHT", -x, 0)
		x = x + f:GetWidth() + 12
	end
	local sw = card.psToggle
	if sw and sw:IsShown() then put(sw) end
	if card.Move:IsShown() then put(card.Move) end
	if card.More:IsShown() then put(card.More) end
	if card.Reset:IsShown() then put(card.Reset) end
end

-- Open a page's tab with a section of it scrolled under the top of the body
-- and lit (an Essentials section's More link). -> the section's card, or nil
function O.ShowSection(pageKey, tabName, sectionName)
	O.Select(pageKey, tabName)
	local view = O.view
	if not (view and view.cards) then return nil end
	for _, card in ipairs(view.cards) do
		if card:IsShown() and card.psName == sectionName then
			W.ScrollTo(win.Scroll, max(0, (card.psTop or 0) - 16))
			O.Flash(card)
			return card
		end
	end
	return nil
end

-- An Essentials section's way to the rest of its part's settings: "More"
-- and a chevron in the label role, textDim (text under the cursor).
local function moreLink(card)
	local b = CreateFrame("Button", nil, card.Header)
	b.Label = W.Text(b, "label", "textDim")
	b.Label:SetText(L["More"])
	b.Label:SetPoint("LEFT", b, "LEFT", 0, 0)
	b.Chevron = W.Tex(b, "ARTWORK", "chevron-right", "textDim")
	b.Chevron:SetSize(9, 9)
	b.Chevron:SetPoint("LEFT", b.Label, "RIGHT", 4, 0)
	b:SetSize(floor(b.Label:GetStringWidth() + 13 + 0.5), 20)
	b:SetScript("OnEnter", function(self)
		W.Color(self.Label, "text")
		W.Color(self.Chevron, "text")
		local j = card.psSection and card.psSection.jump
		if j then W.Tooltip(self, "ANCHOR_TOP", string.format(L["Every setting of %s"], j.tab or "")) end
	end)
	b:SetScript("OnLeave", function(self)
		W.Color(self.Label, "textDim")
		W.Color(self.Chevron, "textDim")
		W.HideTooltip(self)
	end)
	b:SetScript("OnClick", function()
		local s = card.psSection
		local j = s and s.jump
		if j and current then O.ShowSection(current.key, j.tab, j.section or s.name) end
	end)
	b:Hide()
	return b
end

-- A section's Reset: more than three settings ask first.
local function sectionReset(card)
	local list = card.psSettings
	if not list then return end
	local n = modifiedCount(list)
	if n > 3 then
		W.Modal({ title = L["Reset this section?"], icon = "reset", danger = true, action = L["Reset section"],
			text = string.format(L["%d settings in %s go back to their defaults."], n, card.psName or ""),
			onAccept = function() O.ResetSection(list) end })
	else
		O.ResetSection(list)
	end
end

local function cardOf(view, n)
	local card = view.cards[n]
	if card then return card end
	card = W.SectionCard(view)
	card.Reset = W.Button(card.Header, L["Reset"], function() sectionReset(card) end, { ghost = true, height = 22 })
	card.Reset.psTight = true
	W.SetButtonText(card.Reset, L["Reset"])
	-- A gamepad moves row to row: Y resets a row, the footer's Reset page the page.
	card.Reset.psPadSkip = true
	card.Reset:Hide()
	-- The Legend header's Reset (the new page) asks as this one does.
	card.psOnReset = function() sectionReset(card) end
	card.More = moreLink(card)
	-- The section's Move (its `move`): the frame the section sets.
	card.Move = W.Button(card.Header, L["Move"], function()
		local s = card.psSection
		if s and s.move then O.MoveFrame(s.move, card) end
	end, { ghost = true, height = 22 })
	card.Move.psTight = true
	W.SetButtonText(card.Move, L["Move"])
	card.Move.Refresh = inlineRefresh
	card.Move:SetScript("OnEnter", function(self)
		W.Tooltip(self, "ANCHOR_TOP", L["Move"], { string.format(L["Opens Move frames with %s picked; the settings come back when you are done."], card.psName or "") })
	end)
	W.SetDisabledWhen(card.Move, function()
		local s, M = card.psSection, ns.Movers
		if not (s and s.move and M and M.Movable and M.Movable(s.move)) then return true end
		return sectionOff(s)
	end)
	card.Move:Hide()
	view.cards[n] = card
	return card
end

-- A section's caption row (s.columns): each half's caption in the caption
-- role, textMuted, on a faint shade under the header. Made once per card.
local COLUMNS_H = 24
local function columnsOf(card)
	local c = rawget(card, "Columns")
	if c then return c end
	c = CreateFrame("Frame", nil, card)
	c.Shade = W.Tex(c, "BACKGROUND", nil, "shade")
	c.Shade:SetAllPoints(c)
	W.Color(c.Shade, "shade", 0.14)
	c.Left = W.Text(c, "caption", "textMuted")
	c.Left:SetPoint("LEFT", c, "LEFT", 16, 0)
	c.Right = W.Text(c, "caption", "textMuted")
	card.Columns = c
	return c
end

-- Show each card's Reset, each cog's dot and each row's new ring (none on a
-- row off its default: its reset stands there), as the settings stand.
local function markSections(view)
	for c, w in pairs(view.cache or {}) do
		local ring = rawget(w, "NewRing")
		if ring then ring:SetShown(not rawget(w, "psModified")) end
		-- A parent whose closed children hold a change: a hollow ring in its
		-- changed dot's place.
		local hidden = rawget(c, "psKids") and not rawget(w, "psModified") and Index.kidsHidden(c)
		if hidden and not rawget(w, "KidsRing") and rawget(w, "ModDot") then
			w.KidsRing = W.Tex(w, "ARTWORK", "ring", "accent")
			w.KidsRing:SetSize(7, 7)
			w.KidsRing:SetPoint("CENTER", w.ModDot, "CENTER", 0, 0)
		end
		if rawget(w, "KidsRing") then w.KidsRing:SetShown(hidden and true or false) end
	end
	for _, card in ipairs(view.cards or {}) do
		if card:IsShown() and card.psSettings then
			card.Reset:SetShown(card.psHeader and not card.psLegend and modifiedCount(card.psSettings) > 0)
			placeHeader(card)
		end
	end
	for c, cog in pairs(view.cogs or {}) do
		-- A cog pointed out (its first-use cue) keeps its dot while it pulses.
		if cog:IsVisible() and not rawget(cog, "psPulsing") then
			local off = false
			for _, m in ipairs(c.more) do
				if anyOff(m) then
					off = true
					break
				end
			end
			W.SetCogDot(cog, off)
		end
	end
end

-- A Legend card's module switch (the new page): the pill, made once per view
-- (view.psPills), in the card's Legend header. Right-click its default.
local function pillOf(view, t, card)
	local pills = rawget(view, "psPills")
	if not pills then
		pills = {}
		view.psPills = pills
	end
	local p = pills[t]
	if not p then
		p = W.PillSwitch(card.Legend, function() return ns.Get(t.key) end, function(v) ns.Set(t.key, v) end, labelOf(t))
		p.psControl, p.psHeaderSwitch = t, true
		if type(t.help) == "string" and t.help ~= "" then p.psTipLines = { t.help } end
		p:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		local flip = p:GetScript("OnClick")
		p:SetScript("OnClick", function(self, button)
			if button ~= "RightButton" then return flip(self, button) end
			if W.Enabled(self) then W.ResetSetting(t.key) end
		end)
		if t.disabled then W.SetDisabledWhen(p, t.disabled) end
		W.Bind(p, t.key)
		pills[t] = p
	end
	if p:GetParent() ~= card.Legend then p:SetParent(card.Legend) end
	p:Show()
	return p
end

-- The header switch of a section's toggle, made once per view (a Legend
-- card's: its pill).
local function toggleOf(view, t, card, legend)
	if legend then return pillOf(view, t, card) end
	local sw = view.extras[t]
	if not sw then
		sw = W.HeaderSwitch(card.Header, t.key, labelOf(t), tipOf(t, view.psSearch))
		sw.psControl = t
		if t.disabled then W.SetDisabledWhen(sw, t.disabled) end
		view.extras[t] = sw
	end
	if sw:GetParent() ~= card.Header then sw:SetParent(card.Header) end
	sw:Show()
	return sw
end

-- The extras' columns some row of these sections uses (W.LayoutCompact):
-- one no row needs takes no room from the labels. -> { swatch, switch, cog, move }
local function extrasColumns(groups)
	local cols = {}
	for _, g in ipairs(groups) do
		for _, c in ipairs(g.controls) do
			for _, e in ipairs(c.extras or {}) do
				if available(e) then cols[e.kind == "color" and "swatch" or "switch"] = true end
			end
			if c.more and #c.more > 0 then cols.cog = true end
			if c.move and ns.Movers and ns.Movers.Unlock then cols.move = true end
		end
	end
	return cols
end

-- Sections from y, one card each across the body. groups: { { name,
-- controls, section, settings }, ... } (`settings`: what its Reset resets;
-- a Legend card's group may bring its own `count`, `onReset()` and
-- `lead(card)`, a widget made once per card for the header's right side);
-- opts.whole: every row across (search results); opts.gutter: room left of
-- the rows inside the card (the search results' chevrons). Rows not placed
-- are hidden. opts.legend (the new page): each titled card has the Legend
-- header (W.LegendHeader), and a card whose module switch is off folds to
-- that header and one grey line; the rows of it a jump asked for
-- (view.psReveal: control -> true), or every one in the search results,
-- stand dimmed under the line.
-- -> new y
-- OFF_NOTE_H: the folded card's line's least room (its text's height and 8
-- either side, when that is more); OFF_ALPHA: a row shown in it, at most.
local OFF_NOTE_H, OFF_NOTE_PAD, OFF_ALPHA = 32, 8, 0.5

-- A folded Legend card's line: "<Module> is off. Turn it on to change its
-- settings." Made once per card.
local Note = {}
function Note.of(card, field)
	local note = rawget(card, field)
	if not note then
		note = W.Text(card, "note", "textMuted")
		note:SetWordWrap(true)
		card[field] = note
	end
	return note
end

-- A card's one muted line in its body (the folded card's, or the help of a
-- section that is only its header switch): placed under the header, wrapped
-- to the card. -> the room it takes.
function Note.place(card, note, text, width, gutter)
	note:SetText(text)
	note:ClearAllPoints()
	note:SetWidth(max(1, width - gutter - 32))
	-- A wrapped line (a longer translation) takes the room it needs.
	local textH = math.ceil(note:GetStringHeight() or 0)
	local room = max(OFF_NOTE_H, textH + 2 * OFF_NOTE_PAD)
	note:SetPoint("TOPLEFT", card, "TOPLEFT", gutter + 16, -(card.RowsTop + (room - textH) / 2))
	note:SetHeight(max(1, textH))
	note:Show()
	return room
end

local function layoutSections(view, groups, y, opts)
	for _, w in pairs(view.cache) do w:Hide() end
	for _, sw in pairs(view.extras) do if rawget(sw, "psHeaderSwitch") then sw:Hide() end end
	for _, p in pairs(rawget(view, "psPills") or {}) do p:Hide() end
	local dimmed = rawget(view, "psDimmed")
	if dimmed then
		-- Its own refresh then puts back a disabled row's alpha.
		for w in pairs(dimmed) do
			w:SetAlpha(1)
			if w.Refresh then w:Refresh() end
		end
		view.psDimmed = nil
	end
	for _, m in ipairs(view.mids) do m:Hide() end
	for _, t in ipairs(rawget(view, "psKidRules") or {}) do t:Hide() end
	view.psMid, view.psKidRule = 0, 0
	view.psColumns = extrasColumns(groups)
	local width = win.BodyWidth
	local n = 0
	for _, g in ipairs(groups) do
		n = n + 1
		local card = cardOf(view, n)
		local s = g.section
		local t = s and s.toggle and available(s.toggle) and s.toggle or nil
		local header = g.name ~= "" or t ~= nil
		local legend = header and opts and opts.legend or false
		card.psHeader, card.psName, card.psSettings, card.psSection = header, g.name, g.settings, g.section
		card.psLegend = legend or nil
		card:SetTitle(g.name)
		card.Header:SetShown(header and not legend)
		card.Rule:SetShown(header and not legend)
		card.RowsTop = header and W.CARD_HEADER + 1 or 0
		local lg = rawget(card, "Legend")
		if legend then
			if not lg then
				lg = W.LegendHeader(card, {})
				card.Legend = lg
			end
			lg:Show()
			-- The rows start under the border's half of the header, past the
			-- card's own room inside its border (W.LEGEND.ROOM).
			card.RowsTop = W.LEGEND.H / 2 + 6 + W.LEGEND.ROOM / 2
			-- The title stands above the card's top edge: room for it.
			y = y + W.LEGEND.H / 2
		elseif lg then
			lg:Hide()
		end
		-- More and Move stand in whichever header the card has.
		local hp = legend and lg or card.Header
		if card.More:GetParent() ~= hp then card.More:SetParent(hp) end
		if card.Move:GetParent() ~= hp then card.Move:SetParent(hp) end
		card.psToggle = t and toggleOf(view, t, card, legend) or nil
		card.psCount, card.psReset = legend and g.count or nil, legend and g.onReset or nil
		local lead = legend and g.lead and g.lead(card) or nil
		local was = rawget(card, "psLead")
		if was and was ~= lead then was:Hide() end
		if lead and lg then
			if lead:GetParent() ~= lg then lead:SetParent(lg) end
			lead:Show()
		end
		card.psLead = lead
		-- A module that is off: the card folds to its header and one line.
		local folded = legend and t ~= nil and sectionOff(s)
		local controls = g.controls
		local noteH = 0
		if folded then
			local reveal = view.psSearch or rawget(view, "psReveal")
			controls = {}
			if reveal then
				for _, c in ipairs(g.controls) do
					if reveal == true or reveal[c] then controls[#controls + 1] = c end
				end
			end
			noteH = Note.place(card, Note.of(card, "OffNote"), string.format(L["%s is off. Turn it on to change its settings."], labelOf(t) or ""),
				width, (opts.gutter or 0) + (legend and W.LEGEND.ROOM or 0))
		elseif rawget(card, "OffNote") then
			card.OffNote:Hide()
		end
		-- A section that is only its header switch: the switch's help in the
		-- body as one muted line, not an empty strip under the header.
		local lone = t ~= nil and not folded and #g.controls == 0 and type(t.help) == "string" and t.help ~= ""
		if lone then
			noteH = Note.place(card, Note.of(card, "HelpNote"), t.help, width, (opts and opts.gutter or 0) + (legend and W.LEGEND.ROOM or 0))
		elseif rawget(card, "HelpNote") then
			card.HelpNote:Hide()
		end
		card.More:SetShown(header and not view.psSearch and s ~= nil and s.jump ~= nil)
		card.Move:SetShown(header and not view.psSearch and s ~= nil and s.move ~= nil and ns.Movers ~= nil and ns.Movers.Unlock ~= nil)
		if card.Move:IsShown() then card.Move:Refresh() end
		-- A Legend card keeps W.LEGEND.ROOM of its ground between its border
		-- and the rows on the left and right, and under the last row.
		local room = legend and W.LEGEND.ROOM or 0
		local gutter = (opts and opts.gutter or 0) + room
		local whole = opts and opts.whole
		-- A caption over each half (s.columns), while the rows stand in halves.
		local capH = 0
		local cols = s and s.columns
		if cols and not whole and not folded and width - gutter - room >= HALVES_MIN then
			capH = COLUMNS_H
			local c = columnsOf(card)
			local half = floor((width - gutter - room) / 2)
			c:ClearAllPoints()
			c:SetPoint("TOPLEFT", card, "TOPLEFT", gutter, -card.RowsTop)
			c:SetSize(width - gutter - room, COLUMNS_H)
			c.Left:SetText(cols[1] or "")
			c.Right:SetText(cols[2] or "")
			c.Right:ClearAllPoints()
			c.Right:SetPoint("LEFT", c, "LEFT", half + 16, 0)
			c:Show()
		elseif rawget(card, "Columns") then
			card.Columns:Hide()
		end
		local before
		if folded and #controls > 0 then
			before = {}
			for _, w in pairs(view.cache) do if w:IsShown() then before[w] = true end end
		end
		local rowsH = layoutRows(view, controls, y + card.RowsTop + capH + noteH, SH.pad + gutter, width - gutter - room, whole)
		-- The rows of a folded card a jump or the search shows: dimmed.
		if before then
			view.psDimmed = rawget(view, "psDimmed") or {}
			for _, w in pairs(view.cache) do
				if w:IsShown() and not before[w] then
					w:SetAlpha(math.min(w:GetAlpha() or 1, OFF_ALPHA))
					view.psDimmed[w] = true
				end
			end
		end
		card.psTop = y
		y = y + card:Place(SH.pad, y, width, rowsH + capH + noteH + room) + SECTION_GAP
	end
	for i = n + 1, #view.cards do view.cards[i]:Hide() end
	markSections(view)
	return y - (n > 0 and SECTION_GAP or 0)
end

-- A view's tables: rows, inline extras and header switches, cogs, cards and
-- the halves' hairlines.
local function viewTables(view)
	view.cache, view.extras, view.cogs, view.cards, view.mids = {}, {}, {}, {}, {}
	view.headers, view.panels = {}, {}
	return view
end

---------------------------------------------------------------------------
-- The cog's popup: a row's detail settings (its `more`) in a compact panel by
-- the cog: the row's label as its title over single-column rows of 30px,
-- 300 wide. It closes on Escape, a click outside it, or another page.
---------------------------------------------------------------------------

local more

local function buildMore()
	more = CreateFrame("Frame", "PolestarOptionsMore", ns.UIParent)
	more:SetFrameStrata("FULLSCREEN_DIALOG")
	more:SetFrameLevel(10)
	more:SetClampedToScreen(true)
	more:EnableMouse(true)
	-- A popup over the page: its ground never see-through (Theme's menuBg).
	more.psMenu = true
	Theme.Skin(more, "panel")
	viewTables(more)
	more.psRowH = MORE_ROW
	more.Title = W.Text(more, "heading", "text")
	more.Title:SetPoint("TOPLEFT", more, "TOPLEFT", 16, -12)
	more.Title:SetWordWrap(false)
	more.Rule = W.Divider(more)
	more.Rule:SetPoint("TOPLEFT", more, "TOPLEFT", 1, -W.CARD_HEADER)
	more.Rule:SetPoint("TOPRIGHT", more, "TOPRIGHT", -1, -W.CARD_HEADER)
	local catcher = CreateFrame("Button", nil, ns.UIParent)
	catcher:SetAllPoints(UIParent)
	catcher:SetFrameStrata("FULLSCREEN_DIALOG")
	catcher:SetFrameLevel(1)
	catcher:RegisterForClicks("AnyUp")
	catcher:SetScript("OnClick", function() more:Hide() end)
	catcher:Hide()
	more.Catcher = catcher
	more:SetScript("OnHide", function()
		catcher:Hide()
		if W.ClosePicker then W.ClosePicker() end
	end)
	more:Hide()
	ns.CloseOnEscape("PolestarOptionsMore")
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(more, { back = function() more:Hide() end })
	end
end

-- Open (or, from its own cog, close) the popup of control c's `more`.
function O.ShowMore(cog, c)
	if not more then buildMore() end
	-- A cog opened: its first-use cue has nothing left to say.
	ns.DB().optionsCogHint = true
	local cue = win and rawget(win, "psCallout")
	if cue and cue.psCog then cue:Hide() end
	if more:IsShown() and more.psFor == c then
		more:Hide()
		return
	end
	more.psFor = c
	W.HideMenu()
	for _, w in pairs(more.cache) do w:Hide() end
	more.Title:SetText(labelOf(c) or "")
	more.Title:SetWidth(MORE_W - 32)
	local list = {}
	for _, m in ipairs(c.more or {}) do if available(m) then list[#list + 1] = m end end
	local h = layoutRows(more, list, W.CARD_HEADER + 1, 0, MORE_W, true)
	more:SetSize(MORE_W, W.CARD_HEADER + 1 + h + 2)
	if win then more:SetScale(win:GetEffectiveScale() / UIParent:GetEffectiveScale()) end
	more:ClearAllPoints()
	more:SetPoint("TOPRIGHT", cog, "BOTTOMRIGHT", 0, -4)
	more.Catcher:Show()
	more:Show()
	more:Raise()
	markSections(more)
	Anim.To(more, "alpha", 0, 1, Anim.FAST, "out")
	return more
end

function O.HideMore()
	if more then more:Hide() end
end

-- The settings of the open cog popup (tests): key -> widget.
function O.MoreControls()
	local out = {}
	if not (more and more:IsShown()) then return out end
	for c, w in pairs(more.cache) do if w:IsShown() and c.key then out[c.key] = w end end
	for c, w in pairs(more.extras) do if c.key then out[c.key] = w end end
	return out
end

---------------------------------------------------------------------------
-- The pinned preview, its bands and its hotspots are UI/Preview.lua's
-- (UI.Preview); here, what it asks of the window.
---------------------------------------------------------------------------

-- The specs by key, built once (in page order) and again after a
-- registration (add drops it): byKey[key] = { c, page, tab, ... } of every
-- control holding the key (not a reference); home[key] = its home control
-- (O.AllControls' first); sections[key] = the sections holding it.
function Index.get()
	if Index.spec then return Index.spec end
	local byKey, home, sections = {}, {}, {}
	for _, p in ipairs(pageList) do
		for _, t in ipairs(p.tabs) do
			for _, s in ipairs(t.sections) do
				for _, c in ipairs(allSettings(s)) do
					local key = c.key
					if key ~= nil then
						local of = sections[key]
						if not of then
							of = {}
							sections[key] = of
						end
						if of[#of] ~= s then of[#of + 1] = s end
					end
					if key ~= nil and not rawget(c, "ref") then
						local list = byKey[key]
						if not list then
							list = {}
							byKey[key] = list
						end
						list[#list + 1] = c
						list[#list + 1] = p
						list[#list + 1] = t
					end
				end
				for _, c in ipairs(homeSettings(s)) do
					if c.key ~= nil and home[c.key] == nil then home[c.key] = c end
				end
			end
		end
	end
	Index.spec = { byKey = byKey, home = home, sections = sections }
	return Index.spec
end

-- A setting changed (live or not; "" or a section's name: every setting may
-- have): the sections holding it work out again which of their controls are
-- off their defaults (sectionModified).
function O.SettingMoved(path)
	local of = type(path) == "string" and path:find(".", 1, true) and Index.get().sections[path]
	if of then
		for i = 1, #of do of[i].psOff = nil end
		return
	end
	for _, p in ipairs(pageList) do
		for _, t in ipairs(p.tabs) do
			for _, s in ipairs(t.sections) do s.psOff = nil end
		end
	end
end
ns.On("SETTING_CHANGED", O.SettingMoved)

-- The setting `key`'s control spec: on the page and tab on screen first,
-- then the page, then anywhere; a reference to a control on another tab
-- (c.ref) leads to that control itself. -> spec | nil
-- Asked on every hover of a preview's part: through the index.
function O.ControlByKey(key)
	local list = key ~= nil and Index.get().byKey[key]
	if not list then return nil end
	local best, rank
	for i = 1, #list, 3 do
		local c, p, t = list[i], list[i + 1], list[i + 2]
		if available(c) then
			local r = (p == current and t == currentTab) and 1 or (p == current and 2 or 3)
			if not rank or r < rank then best, rank = c, r end
		end
	end
	return best
end

-- The home control of setting `key` (its row on a deep tab, references
-- aside, available or not). -> spec | nil
function O.HomeControl(key)
	return key ~= nil and Index.get().home[key] or nil
end
O.LabelOf = labelOf

-- A part of a preview that a click takes to its setting (UI.Preview.Hotspot).
function O.PreviewHotspot(frame, region, key) return UI.Preview.Hotspot(frame, region, key) end

-- Lay the shown tab's preview out across the main column and pin it.
-- fresh: a setting's change, after which a band shown has laid itself out
-- already (its watch, the theme's refresh): placed as it stands.
local function placePreview(view, t, fresh)
	local width = win.psMainW or (win.BodyWidth + SH.pad * 2)
	local room = win:GetHeight() - SH.header - SH.tabs - SH.footer
	UI.Preview.Place(win, view, t, width, room, fresh)
end

-- The tab's cross-link row (its spec's `link`): a link glyph, the lead in
-- Note textMuted, then where the rest is ("Look › Guide window") as a link
-- that opens that page's tab. -> the room it takes at y
local LINK_H = 32
local function linkRoom(view, link, y)
	local row = rawget(view, "XLink")
	if not link then
		if row then row:Hide() end
		return 0
	end
	if not row then
		row = CreateFrame("Frame", nil, view)
		row:SetHeight(LINK_H)
		row.Icon = W.Tex(row, "ARTWORK", "link", "textMuted")
		row.Icon:SetSize(12, 12)
		row.Icon:SetPoint("LEFT", row, "LEFT", 16, 0)
		row.Text = W.Text(row, "note", "textMuted")
		row.Text:SetPoint("LEFT", row.Icon, "RIGHT", 8, 0)
		row.Link = W.Link(row, "", function() O.Select(link.page, link.tab) end, { role = "note" })
		row.Link.psTip = nil
		row.Link:SetPoint("LEFT", row.Text, "RIGHT", 4, 0)
		view.XLink = row
	end
	row.Text:SetText(link.text)
	W.SetLinkText(row.Link, link.to)
	row:ClearAllPoints()
	row:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
	row:SetWidth(win.BodyWidth)
	row:Show()
	return LINK_H + 8
end

-- A view = one page tab rendered into its own frame (built once).
-- opts (the new page's views): { lead(s) -> a row to put first in section
-- s, or nil; legend: the Legend card headers }.
local function buildView(p, t, opts)
	local view = CreateFrame("Frame", nil, win.Body)
	view:SetPoint("TOPLEFT", win.Body, "TOPLEFT", 0, 0)
	view:SetPoint("RIGHT", win.Body, "RIGHT", 0, 0)
	viewTables(view)
	view.psTab = t
	if p.custom then
		p.custom(view)
	else
		view.Refresh = function()
			local y = 16
			y = y + linkRoom(view, t.link, y)
			local groups = {}
			view.psShownSig = shownSig(t)
			for _, s in ipairs(t.sections) do
				local list = visible(s)
				if sectionShown(s) and (#list > 0 or (s.toggle and available(s.toggle))) then
					local settings = sectionSettings(s, list)
					local lead = opts and opts.lead and opts.lead(s)
					if lead then table.insert(list, 1, lead) end
					groups[#groups + 1] = { name = s.name, controls = list, section = s, settings = settings }
				end
			end
			if #groups == 0 then
				for _, w in pairs(view.cache) do w:Hide() end
				for _, card in ipairs(view.cards) do card:Hide() end
				for _, m in ipairs(view.mids) do m:Hide() end
				for _, r in ipairs(rawget(view, "psKidRules") or {}) do r:Hide() end
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
			y = layoutSections(view, groups, y, opts and opts.legend and { legend = true } or nil)
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
-- character, has no floor); filler words ("the", "turn", "off", and the
-- words of a question: "how do I", "where is") only add to a match; a word
-- matching nothing tries its English stem, then its synonyms. The label counts most, then the search terms and key, then the
-- section, tab and page, then the help; typos and inside-a-word matches least.
-- A query starting with a page's name looks on that page for the rest
-- (scopeOf). The dropdown asks O.Matches and O.MatchSpans (further down).
---------------------------------------------------------------------------

local searchView
local byte, find = string.byte, string.find

-- Folding: ASCII lower case, Latin accents dropped (é -> e, ß -> ss), Cyrillic capitals lowered.
local fold
do
	local FOLD = {}
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

	function fold(s)
		return (s:lower():gsub("[\195\197\208][\128-\191]", FOLD))
	end
end

-- American spellings and short forms, read as the words the labels use.
local SPELLING = { color = "colour", colors = "colours", gray = "grey", meter = "metre", meters = "metres",
	center = "centre", behavior = "behaviour", favorite = "favourite", coords = "coordinates" }

-- Words a question or a request carries ("how do I turn off the tracker?",
-- "where is the arrow size", "why does it close quest windows", "can you
-- show me ..."): they add to a control's score when one of its words is the
-- same, and are not required. English always (players type it on every
-- client), and the client's own language's question words (QUESTION, below).
-- A contraction's pieces ("don't": don, t) are filler too.
local FILLER = {}
for w in ([[a an the of to in on at and or for my me i is it how do can turn off enable disable toggle set setting settings
	option options where want show does did are am be was what why when which who make get change find stop go there way you your
	we us please would could should will need just this that its from anymore s t m d ll re ve don doesn didn won isn aren
	cant dont doesnt wont isnt im ive]]):gmatch("%S+") do FILLER[w] = true end
-- Those asking to switch something on or off: a toggle comes before a
-- slider or a choice that matches as well (scoreOf, WEIGHT.SWITCH).
for w in ("off enable disable toggle stop show"):gmatch("%S+") do FILLER[w] = "switch" end

-- Hint words a player types for a kind of change, and the words settings
-- use for it: a query word that matches nothing of a control's own tries
-- the others of its group ("bigger pins" finds Numbered pin size; "see
-- through" finds an opacity). Counted below a word's own match.
local SYN = {}
do
local SYNONYMS = {
	"bigger big larger large size sizes scale huge tiny smaller small enlarge shrink zoom grow",
	"colour colours tint hue tone",
	"transparent transparency opacity alpha seethrough translucent faint fade faded",
	"font fonts text letters typeface type writing",
	"move moving position positions drag unlock anchor place placement reposition",
	"pin pins marker markers icon icons numbered mark marks medallion blip blips",
	"border borders edge edges frame outline",
	"background backing ground bg backdrop",
	"sound sounds audio chime ding noise mute muted quiet silence silent",
	"hide hidden show shown visible visibility",
	"animation animations motion animated effects",
	"arrow pointer compass dart",
	"line lines route routes path trail dots",
	"spacing padding gap gaps margin",
	"toast toasts alert alerts notification notifications popup banner",
	"thickness thick thicker thin width wider",
	"glow shine light",
}
for _, group in ipairs(SYNONYMS) do
	local words = {}
	for w in group:gmatch("%S+") do words[#words + 1] = w end
	for _, w in ipairs(words) do
		local list = SYN[w] or {}
		for _, o in ipairs(words) do if o ~= w then list[#list + 1] = o end end
		SYN[w] = list
	end
end
end
-- Phrases read as one hint word. First the punctuation a question carries
-- outside ASCII (¿ ¡ « » quotes, dashes, the ellipsis, CJK ？！，。、：；
-- and brackets) as spaces, so "¿cómo" is "como" and "箭头？" is "箭头".
local PHRASES = { { "\194[\161\171\183\187\191]", " " }, { "\226\128[\147\148\152\153\156\157\158\166]", " " },
	{ "\227\128[\129\130]", " " }, { "\239\188[\129\136\137\140\154\155\159]", " " },
	{ "see%W*through", "seethrough" }, { "step%W*numbers?", "numbered" },
	{ "%f[%w]get%W+rid%W+of%f[%W]", "hide" }, { "%f[%w]show%W+me%f[%W]", "me" }, { "%f[%w]turn%W*in(s?)%f[%W]", "turnin%1" } }
-- The question and request words of each client language Polestar is
-- translated into, folded as the matcher folds (lower case, Latin accents
-- off: "où" is "ou", "können" "konnen"), filler on that client. Chinese
-- writes no spaces: its question words (`split`) are taken out of the query
-- before it is cut into words, the longest first, so "箭头在哪里" asks for
-- "箭头". docs/ARCHITECTURE.md, "Settings search", lists them.
do
	local spanish = [[como donde por porque que cual cuales cuando puedo puede puedes se yo me mi mis el la los las lo un una
		unos unas de del al es esta estan hay hago hace hacer quiero quisiera cambiar poner encontrar activar desactivar y o en con para]]
	local QUESTION = {
		deDE = [[wie wo warum wieso weshalb was welche welcher welches wann kann kannst konnen konnte ich mich mir mein meine meinen
			meinem meiner man ist sind gibt es der die das den dem des ein eine einen einem einer zu um mal bitte will mochte soll
			muss andern einstellen finden finde machen mache schalte schalten aus an ab ausschalten abschalten einschalten
			aktivieren deaktivieren und oder im in am auf fur von]],
		frFR = [[comment ou pourquoi quand quel quelle quels quelles que qu quoi est ce c je j me m moi mon ma mes on peut peux
			puis pouvoir il y t faire fait changer modifier regler trouver mettre veux voudrais faut le la les l un une des du de d
			au aux en pour sur dans et activer desactiver]],
		esES = spanish, esMX = spanish,
		ptBR = [[como onde por porque que qual quais quando posso pode eu me meu minha meus minhas o os as um uma de do da dos
			das no na nos nas e esta fica faco faz fazer quero mudar alterar trocar achar encontrar ativar desativar ligar
			desligar em com para]],
		ruRU = [[как где почему зачем что чтобы какой какая какие когда я мне меня мой моя моё мои можно могу ли это сделать
			изменить поменять найти хочу включить выключить отключить настроить и в на у с к по для а]],
		koKR = [[어떻게 어디 어디에 어디서 어디에서 어디있나요 왜 무엇 뭐 무슨 언제 내 나 제 저 수 있나요 있어요 있습니까
			있을까요 하나요 해요 하려면 하는 방법 좀]],
		zhCN = { split = [[在哪里 在哪儿 为什么 能不能 怎么样 怎么办 怎么 怎样 如何 哪里 哪儿 在哪 为啥 什么 我的 可以 能否 请问
			一下 吗 呢 我 把]] },
		zhTW = { split = [[在哪裡 在哪兒 為什麼 能不能 怎麼樣 怎麼辦 怎麼 怎樣 如何 哪裡 哪兒 在哪 為啥 什麼 我的 可以 能否 請問
			一下 嗎 呢 我 把]] },
	}
	local own = QUESTION[GetLocale and GetLocale() or "enUS"]
	if type(own) == "string" then
		for w in own:gmatch("%S+") do FILLER[w] = true end
	elseif own then
		for w in own.split:gmatch("%S+") do PHRASES[#PHRASES + 1] = { w, " " } end
	end
end
-- On and off words read as the toggle's own word, at the word's own weight:
-- "hide the arrow" asks for Show arrow, off.
local OPPOSITE = { hide = "show shown", hidden = "shown show", hiding = "show shown", unhide = "show shown" }
-- A synonym's match counts SYN of the word's own, a filler word's (scoreOf)
-- FILLER; a control whose label's words were all asked about (the label is
-- the answer, not a longer one holding the words) COVER more. A toggle, asked
-- to switch something on or off, SWITCH more. One table to keep the main
-- chunk's locals in budget.
local WEIGHT = { SYN = 0.6, FILLER = 0.1, COVER = 50, SWITCH = 30 }

-- A searchable word's field (one table, for the main chunk's locals budget).
local FIELD = { LABEL = 1, KEY = 2, TERMS = 3, PLACE = 4, HELP = 5 }
-- By field, the score of a match inside a word, a typo off, the word's start, the whole word.
local SCORE = { { 12, 30, 80, 100 }, { 10, 25, 65, 75 }, { 10, 25, 60, 70 }, { 8, 20, 45, 50 }, { 5, 0, 35, 40 } }
-- Two query words that are one of the control's joined pairs ("minimap
-- icon" for a "minimap icon" term) add this, by kind of match.
SCORE.PHRASE = { 0, 10, 20, 40 }

-- Translated text -> its English (the keys of L), built at the first search.
local englishOf
do
	local english
	function englishOf(s)
		if not english then
			english = {}
			for en, tr in pairs(L) do
				if type(en) == "string" and type(tr) == "string" and tr ~= en then english[tr] = en end
			end
		end
		return s and english[s]
	end
end

-- Neighbours are joined within a comma's part ("tiny text, bigger" joins no
-- "textbigger").
local function addWords(words, fields, text, field, join)
	if type(text) ~= "string" or text == "" then return end
	for part in fold(text):gmatch("[^,]+") do
		local prev
		for word in part:gmatch("[%w\128-\255]+") do
			local w = SPELLING[word] or word
			words[#words + 1], fields[#fields + 1] = w, field
			if join and prev then words[#words + 1], fields[#fields + 1] = prev .. w, field end
			prev = w
		end
	end
end

-- A control's searchable words and the field of each, kept on the control
-- until its label changes (a label function's name for the client).
local function searchTokens(c)
	local label = labelOf(c) or ""
	local s = c.psFind
	if s and s.label == label then return s end
	s = { label = label, words = {}, fields = {}, covers = {} }
	local w, f = s.words, s.fields
	addWords(w, f, label, FIELD.LABEL, true)
	-- What names it whole (scoreOf's WEIGHT.COVER): its label's words, its English
	-- label's and each of its search terms' of two words or more (one word is
	-- a hint, not a name), filler aside.
	local function cover(text, least)
		local list = {}
		for word in fold(text):gmatch("[%w\128-\255]+") do
			word = SPELLING[word] or word
			if not FILLER[word] then list[#list + 1] = word end
		end
		if #list >= least then s.covers[#s.covers + 1] = list end
	end
	cover(label, 1)
	if englishOf(label) then cover(englishOf(label), 1) end
	if type(c.search) == "string" then
		for term in c.search:gmatch("[^,]+") do cover(term, 2) end
	end
	addWords(w, f, c.search, FIELD.TERMS, true)
	if type(c.key) == "string" then addWords(w, f, (c.key:match("[^.]+$"):gsub("(%l)(%u)", "%1 %2")), FIELD.KEY, true) end
	addWords(w, f, englishOf(label), FIELD.TERMS, true)
	addWords(w, f, c.section, FIELD.PLACE, true)
	addWords(w, f, c.tab, FIELD.PLACE, true)
	addWords(w, f, c.page and c.page.name, FIELD.PLACE, true)
	addWords(w, f, c.help, FIELD.HELP, false)
	c.psFind = s
	Index.search.dirty = true
	return s
end

-- Optimal string alignment distance (a swap of two neighbours is one edit)
-- between the bytes qb[1..lq] and the word t; cap + 1 once it is over cap.
local distance
do
	local DIST_ROWS = { {}, {}, {}, {} } -- three rows and the word's bytes, reused
	function distance(qb, lq, t, cap)
		local lt = #t
		if lt - lq > cap or lq - lt > cap then return cap + 1 end
		local r0, r1, r2, tb = DIST_ROWS[1], DIST_ROWS[2], DIST_ROWS[3], DIST_ROWS[4]
		for j = 1, lt do tb[j] = byte(t, j) end
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

local qwords, qfiller, qpairs, qsyn, qstem, seen = {}, {}, {}, {}, {}, {}
-- A word's other forms, then its synonyms (formSays).
local qforms = { qstem, qsyn }

-- The query's words into qwords (memos) and qfiller, each word joined to
-- the one before into qpairs, a hint word's synonyms into qsyn, its other
-- forms into qstem: the word its English ending comes off ("accepting"
-- accept, "stopping" stop, "sounds" sound, "closed" clos) and its OPPOSITE.
-- -> count
local function parseQuery(q)
	local n, needed, prev = 0, 0, nil
	qwords.onoff = false
	local text = fold(q or "")
	for _, ph in ipairs(PHRASES) do text = text:gsub(ph[1], ph[2]) end
	for word in text:gmatch("[%w\128-\255]+") do
		local w = SPELLING[word] or word
		n = n + 1
		qwords[n], qfiller[n] = wordMemo(w), FILLER[w] or false
		qpairs[n] = prev and wordMemo(prev .. w) or false
		local stem = #w >= 5 and not find(w, "[\128-\255]") and (w:match("^(.+)ing$") or w:match("^(.+)ed$")) or nil
		if stem then
			local base, last = stem:match("^(.+)(%a)%2$")
			if base then stem = base .. last end
		elseif #w >= 5 and not find(w, "[\128-\255]") then
			stem = w:match("^(.+[^s])s$")
		end
		if stem and #stem < 3 then stem = nil end
		local forms = {}
		if stem then forms[1] = wordMemo(stem) end
		for o in (OPPOSITE[w] or ""):gmatch("%S+") do forms[#forms + 1] = wordMemo(o) end
		qstem[n] = forms[1] and forms or false
		local syn = SYN[w] or (stem and (SYN[stem] or SYN[stem .. "e"]))
		if syn then
			local list = {}
			for i, o in ipairs(syn) do list[i] = wordMemo(o) end
			qsyn[n] = list
		else
			qsyn[n] = false
		end
		if not FILLER[w] then needed = needed + 1 end
		if FILLER[w] == "switch" or OPPOSITE[w] then qwords.onoff = true end
		prev = w
	end
	if needed == 0 then
		for i = 1, n do qfiller[i] = false end
	end
	return n
end

-- A word's best match through its synonyms (or its stem): a whole word or a
-- word's start of the control's own (its help aside), at `share` of the score.
local function synonymScore(list, tw, tf, share)
	local best = 0
	for _, sm in ipairs(list) do
		for j = 1, #tw do
			if tf[j] ~= FIELD.HELP then
				local k = kindOf(sm, tw[j])
				if k >= 3 then
					local v = floor(SCORE[tf[j]][k] * share)
					if v > best then best = v end
				end
			end
		end
	end
	return best
end

-- Does query word i say word t through its other forms or synonyms (whole
-- or its start)?
local function formSays(i, t)
	for _, list in ipairs(qforms) do
		local forms = list[i]
		if forms then
			for _, sm in ipairs(forms) do
				if kindOf(sm, t) >= 3 then return true end
			end
		end
	end
	return false
end

-- A control's score for the query, 0 when a word it needs matches nothing;
-- what its words alone make of it (no WEIGHT.COVER or WEIGHT.SWITCH: the page scope's
-- fair match); and the part of the score its filler words gave (they only break ties).
local function scoreOf(c, nw)
	local s = searchTokens(c)
	local tw, tf = s.words, s.fields
	local total, bonus, fill = 0, qwords.onoff and c.kind == "toggle" and WEIGHT.SWITCH or 0, 0
	for i = 1, nw do
		local m, filler, best, phrase = qwords[i], qfiller[i], 0, 0
		local pair = qpairs[i]
		for j = 1, #tw do
			local k = kindOf(m, tw[j])
			if k == 4 or (k > 0 and not filler) then
				local v = SCORE[tf[j]][k]
				if v > best then best = v end
			end
			if pair and tf[j] ~= FIELD.HELP then
				local pk = SCORE.PHRASE[kindOf(pair, tw[j])] or 0
				if pk > phrase then phrase = pk end
			end
		end
		-- Its other forms whole beat the word's own typo ("sounds": sound, not a typo of it).
		if not filler and qstem[i] then
			local v = synonymScore(qstem[i], tw, tf, 1)
			if v > best then best = v end
		end
		if best == 0 and not filler and qsyn[i] then best = synonymScore(qsyn[i], tw, tf, WEIGHT.SYN) end
		if best == 0 and not filler then return 0 end
		-- A filler word's match, and a pair with one in it, count WEIGHT.FILLER:
		-- they tell two settings apart, never outrank the words asked about
		-- ("the" in "Hide the arrow with the guide").
		if filler then best = floor(best * WEIGHT.FILLER) end
		if filler or (i > 1 and qfiller[i - 1]) then phrase = floor(phrase * WEIGHT.FILLER) end
		total = total + best + phrase
		if filler then fill = fill + best end
		if filler or (i > 1 and qfiller[i - 1]) then fill = fill + phrase end
	end
	-- Named whole: each word of its label, or of one of its search terms,
	-- one a query word asks for (whole or its start, or through the word's
	-- other forms or synonyms; a typo is too loose: "slow" is not "Glow").
	for _, cover in ipairs(s.covers) do
		local all = true
		for _, cw in ipairs(cover) do
			local said = false
			for i = 1, nw do
				if not qfiller[i] and (kindOf(qwords[i], cw) >= 3 or formSays(i, cw)) then
					said = true
					break
				end
			end
			if not said then
				all = false
				break
			end
		end
		if all then return total + bonus + WEIGHT.COVER, total, fill end
	end
	return total + bonus, total, fill
end

-- The best match of the words asked about first (psCore: the score less its
-- filler words' part, and half a point for a setting of a page for all of
-- Polestar that a module's of the same label ties: collect), then the filler
-- words; one its section's on/off stops after an equal one that works.
local function byScore(a, b)
	if a.psCore ~= b.psCore then return a.psCore > b.psCore end
	if a.psScore ~= b.psScore then return a.psScore > b.psScore end
	if a.psStopped ~= b.psStopped then return not a.psStopped end
	return a.psOrder < b.psOrder
end

local function byBest(a, b)
	if a.core ~= b.core then return a.core > b.core end
	if a.best ~= b.best then return a.best > b.best end
	if a.off ~= b.off then return not a.off end
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
					if not rawget(c, "ref") and available(c) then
						local s = searchTokens(c)
						local total = 0
						for i = 1, nw do
							local m = qwords[i]
							if not qfiller[i] and m.n >= 3 then
								local cap, best = math.max(1, floor(m.n / 2)), 0
								for j = 1, #s.words do
									if s.fields[j] ~= FIELD.HELP then
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

-- The controls a query word may match at all, from an index of every
-- control's words (built once per set of pages: add drops it, a label that
-- changed builds it again): those with a word it matches (kindOf > 0) or one
-- of its other forms or synonyms names whole (>= 3). A control without such
-- a word scores 0 for a word it needs (scoreOf), so it is not scored at all.
-- Each word's set is kept on its memo, across keystrokes. Index.prepare(nw)
-- for a parsed query; Index.scoreHeld(c, c, nw) then puts the best of c and
-- what it holds (its extras, what its cog holds, each while available) into
-- Index.found (no closure or list per control).
do
	local S = Index.search
	local function wordIndex()
		if S.words and not S.dirty and S.built == Index.spec then return S.words end
		local words, last = {}, {}
		for _, p in ipairs(pageList) do
			for _, t in ipairs(p.tabs) do
				for _, s in ipairs(t.sections) do
					for _, c in ipairs(allSettings(s)) do
						for _, w in ipairs(searchTokens(c).words) do
							if last[w] ~= c then
								last[w] = c
								local list = words[w]
								if not list then
									list = {}
									words[w] = list
								end
								list[#list + 1] = c
							end
						end
					end
				end
			end
		end
		S.words, S.dirty = words, false
		S.built = Index.get()
		S.version = S.version + 1
		return words
	end
	local function candidatesOf(i)
		local m = qwords[i]
		local words = wordIndex()
		if m.cands and m.candsVersion == S.version then return m.cands end
		local set = {}
		for t, list in pairs(words) do
			local hit = kindOf(m, t) > 0
			if not hit then
				for _, forms in ipairs(qforms) do
					local said = forms[i]
					if said then
						for _, sm in ipairs(said) do
							if kindOf(sm, t) >= 3 then hit = true break end
						end
					end
					if hit then break end
				end
			end
			if hit then
				for k = 1, #list do set[list[k]] = true end
			end
		end
		m.cands, m.candsVersion = set, S.version
		return set
	end

	local found, cands = {}, {}
	Index.found = found
	function Index.prepare(nw)
		for i = 1, #cands do cands[i] = nil end
		for i = 1, nw do cands[i] = not qfiller[i] and candidatesOf(i) or false end
	end
	local function matchable(x, nw)
		for i = 1, nw do
			local cs = cands[i]
			if cs and not cs[x] then return false end
		end
		return true
	end
	local function scoreHeld(x, c, nw)
		if matchable(x, nw) and (x == c or available(x)) then
			local v, w, f = scoreOf(x, nw)
			if v > found.score then found.score, found.words, found.via, found.fill = v, w or 0, x, f or 0 end
		end
		if x.extras then
			for _, e in ipairs(x.extras) do
				if matchable(e, nw) and available(e) then
					local v, w, f = scoreOf(e, nw)
					if v > found.score then found.score, found.words, found.via, found.fill = v, w or 0, e, f or 0 end
				end
			end
		end
		if x.more then
			for _, m in ipairs(x.more) do scoreHeld(m, c, nw) end
		end
	end
	Index.scoreHeld = scoreHeld
end

-- Every control the parsed query matches, grouped by page, tab and section
-- (only: one page's), each control once (a setting shown on two pages, under
-- the first), the best first in its group. -> groups (unsorted), count
local function collect(nw, only)
	local groups, count = {}, 0
	for k in pairs(seen) do seen[k] = nil end
	Index.prepare(nw)
	local found = Index.found
	local order = 0
	for _, p in ipairs(pageList) do if not only or p == only then
		for _, t in ipairs(p.tabs) do
			for _, s in ipairs(t.sections) do if sectionShown(s) then
				-- The section's toggle is a result of its own; a control is
				-- found by its words and by those of its extras and cog. A
				-- reference (Essentials) is found at its home.
				local list, best, fair
				local n = #s.controls
				for ci = (s.toggle and 0 or 1), n do
					local c = ci == 0 and s.toggle or s.controls[ci]
					if not rawget(c, "ref") then
						order = order + 1
						if available(c) and not (c.key and seen[c.key]) then
							found.score, found.words, found.via, found.fill = 0, 0, nil, 0
							Index.scoreHeld(c, c, nw)
							local score, words, via, fill = found.score, found.words, found.via, found.fill
							found.via = nil
							if score > 0 then
								if c.key then seen[c.key] = true end
								-- psVia: an extra or a cog's setting that matched better than the row's own.
								c.psScore, c.psOrder, c.psVia = score, order, via ~= c and via or nil
								c.psCore = score - fill
								-- Stopped by its section's on/off: after the ones that work.
								c.psStopped = s.toggle ~= c and sectionOff(s)
								list = list or {}
								list[#list + 1] = c
								if not best or score > best then best = score end
								if not fair or words > fair then fair = words end
							end
						end
					end
				end
				if list then
					-- Where they live: page, tab, section.
					local title = p.name
					if t.name ~= "" then title = title .. "  \194\183  " .. t.name end
					if s.name ~= "" and s.name ~= t.name then title = title .. "  \194\183  " .. s.name end
					groups[#groups + 1] = { title = title, controls = list, best = best, general = p.general == true, fair = fair, order = #groups + 1, section = s }
					count = count + #list
				end
			end end
		end
	end end
	-- A setting of a page for all of Polestar (`general`: Theme's Text size) whose label a module's setting found
	-- too wears (a toast's Text size) comes before it when the words asked about match both alike: half a point.
	local shared = {}
	for _, g in ipairs(groups) do
		if not g.general then for _, c in ipairs(g.controls) do shared[c.psFind and c.psFind.label or ""] = true end end
	end
	for _, g in ipairs(groups) do
		local core
		for _, c in ipairs(g.controls) do
			if g.general and shared[c.psFind and c.psFind.label or ""] then c.psCore = c.psCore + 0.5 end
			if not core or c.psCore > core then core = c.psCore end
		end
		table.sort(g.controls, byScore)
		g.core, g.off = core, g.controls[1].psStopped and true or false
	end
	return groups, count
end

-- A name's words as a query says them (folded, filler left out).
local function nameWords(name)
	local out = {}
	for word in fold(name or ""):gmatch("[%w\128-\255]+") do
		local w = SPELLING[word] or word
		if not FILLER[w] then out[#out + 1] = w end
	end
	return out
end

-- Where the parsed query ends a page's name it starts with: the name's
-- words in order (filler between them aside) or run together ("mappins").
-- -> the index of the query word that ends it, or nil
local function nameEnds(words, nw)
	local i = 1
	while i <= nw and qfiller[i] do i = i + 1 end
	if i > nw or #words == 0 then return nil end
	if #words > 1 and qwords[i].q == table.concat(words) then return i end
	local k = 1
	while i <= nw do
		if qwords[i].q == words[k] then
			if k == #words then return i end
			k = k + 1
		elseif not qfiller[i] then
			return nil
		end
		i = i + 1
	end
	return nil
end

-- A query that starts with a page's name and goes on ("arrow size",
-- "quality of life loot") looks on that page alone: the name stands whole
-- at the start (on a translated client its English name too) and a word
-- that is not filler follows it; the longest name wins. -> the page and the
-- rest of the query, or nil
local function scopeOf(nw)
	if nw < 2 then return nil end
	local page, ends, size
	for _, p in ipairs(pageList) do
		for _, name in ipairs({ p.name, englishOf(p.name) or p.name }) do
			local words = nameWords(name)
			local at = nameEnds(words, nw)
			if at and (not size or #words > size) then
				for j = at + 1, nw do
					if not qfiller[j] then
						page, ends, size = p, at, #words
						break
					end
				end
			end
		end
	end
	if not page then return nil end
	local rest = {}
	for j = ends + 1, nw do rest[#rest + 1] = qwords[j].q end
	return page, table.concat(rest, " ")
end

-- -> { { title = "Page · Tab", controls = { ... } }, ... }, count, suggestions, page
-- Each control once (a setting shown on two pages, under the first), the
-- best first in its group, the group with the best match first. A query
-- that starts with a page's name looks on that page (`page`, the fourth
-- result) for the rest of its words, everywhere when nothing there matches
-- them fairly. With no match, suggestions: up to three labels near the query.
function O.Search(q)
	-- A page's own results stand when its best one is a fair match by its
	-- words alone (no WEIGHT.COVER or WEIGHT.SWITCH): on average each word
	-- whole in the setting's place, or its start in the setting's own words.
	-- A word found only in a help text, or a typo, looks everywhere.
	local SCOPE_FLOOR = 50
	local nw = parseQuery(q)
	if nw == 0 then return {}, 0 end
	local page, rest = scopeOf(nw)
	if page then
		local rw = parseQuery(rest)
		local needed = 0
		for i = 1, rw do if not qfiller[i] then needed = needed + 1 end end
		local groups, count = collect(rw, page)
		if count > 0 then
			table.sort(groups, byBest)
			local fair = 0
			for _, g in ipairs(groups) do fair = max(fair, g.fair) end
			if fair >= SCOPE_FLOOR * max(1, needed) then return groups, count, nil, page end
		end
		nw = parseQuery(q)
	end
	local groups, count = collect(nw)
	if count == 0 then return groups, 0, suggest(nw) end
	table.sort(groups, byBest)
	return groups, count
end

-- A word's folded bytes back to the word's own: at[i] and stop[i], the
-- first and last byte of the character folded byte i came from.
local function foldMap(word)
	local at, stop, n, i = {}, {}, 0, 1
	while i <= #word do
		local b = byte(word, i)
		local len = b >= 240 and 4 or b >= 224 and 3 or b >= 192 and 2 or 1
		for _ = 1, #fold(word:sub(i, i + len - 1)) do
			n = n + 1
			at[n], stop[n] = i, i + len - 1
		end
		i = i + len
	end
	return at, stop
end

-- Where in `text` the query's words match, by the matcher's own test (a word
-- whole, its start, a typo off or inside it; two of its words run together;
-- its stem or a hint word's synonym when the word itself matches nothing), filler words
-- aside: byte ranges of `text`, { { from, to }, ... } in order. The search's
-- dropdown lights them in a label (UI/SearchDropdown.lua).
function O.MatchSpans(text, q)
	local out = {}
	if type(text) ~= "string" or text == "" then return out end
	local nw = parseQuery(q)
	if nw == 0 then return out end
	local words, marks, hit = {}, {}, {}
	for s, w, e in text:gmatch("()([%w\128-\255]+)()") do
		local f = fold(w)
		words[#words + 1] = { s = s, e = e - 1, raw = w, f = SPELLING[f] or f, spelled = SPELLING[f] ~= nil }
	end
	for _, wd in ipairs(words) do
		for i = 1, nw do
			local m = qwords[i]
			local k = not qfiller[i] and kindOf(m, wd.f) or 0
			if k > 0 then
				hit[i] = true
				if (k == 3 or k == 1) and not wd.spelled then
					-- Its start or the part inside: those characters only.
					local from = k == 3 and 1 or find(wd.f, m.q, 1, true)
					local at, stop = foldMap(wd.raw)
					marks[#marks + 1] = { wd.s + at[from] - 1, wd.s + stop[min(from + m.n - 1, #stop)] - 1 }
				else
					marks[#marks + 1] = { wd.s, wd.e }
				end
			end
		end
	end
	-- Two words run together ("autoloot" for "Auto loot"): the query word
	-- reaches into the second.
	for j = 2, #words do
		local joined = words[j - 1].f .. words[j].f
		for i = 1, nw do
			local m = qwords[i]
			if not qfiller[i] and m.n > #words[j - 1].f and kindOf(m, joined) >= 3 then
				hit[i] = true
				marks[#marks + 1] = { words[j - 1].s, words[j].e }
			end
		end
	end
	for i = 1, nw do
		if not hit[i] and not qfiller[i] and (qstem[i] or qsyn[i]) then
			for _, wd in ipairs(words) do
				if formSays(i, wd.f) then marks[#marks + 1] = { wd.s, wd.e } end
			end
		end
	end
	table.sort(marks, function(a, b) return a[1] < b[1] end)
	for _, m in ipairs(marks) do
		local last = out[#out]
		if last and m[1] <= last[2] + 1 then
			if m[2] > last[2] then last[2] = m[2] end
		else
			out[#out + 1] = { m[1], m[2] }
		end
	end
	return out
end

-- `text` with the words `q` matches (O.MatchSpans) in the colour `token`.
function O.LitText(text, q, token)
	local spans = O.MatchSpans(text, q)
	if #spans == 0 then return text end
	local open, out, at = "|c" .. Theme.Hex(token or "accent"), {}, 1
	for _, sp in ipairs(spans) do
		out[#out + 1] = text:sub(at, sp[1] - 1)
		out[#out + 1] = open .. text:sub(sp[1], sp[2]) .. "|r"
		at = sp[2] + 1
	end
	out[#out + 1] = text:sub(at)
	return table.concat(out)
end

local function renderSearch()
	if not searchView then
		searchView = CreateFrame("Frame", nil, win.Body)
		searchView:SetPoint("TOPLEFT", win.Body, "TOPLEFT", 0, 0)
		searchView:SetPoint("RIGHT", win.Body, "RIGHT", 0, 0)
		viewTables(searchView)
		searchView.psSearch = true
		searchView.Empty = W.Text(searchView, "note", "textMuted")
		searchView.Hint = W.Text(searchView, "note", "textMuted")
		searchView.Hint:SetText(L["Did you mean:"])
		searchView.Links = {}
	end
	local groups, count, suggestions = O.Search(query)
	local sections = {}
	for i, g in ipairs(groups) do
		-- A result stopped by its section's on/off: that switch in the header.
		local s
		if g.section and g.section.toggle then
			local stopped, listed = false, false
			for _, c in ipairs(g.controls) do
				if c.psStopped then stopped = true end
				if c == g.section.toggle then listed = true end
			end
			if stopped and not listed then s = g.section end
		end
		sections[i] = { name = g.title, controls = g.controls, section = s, settings = sectionSettings(nil, g.controls) }
	end
	-- The new page: Legend card headers (a module that is off shows its hits
	-- dimmed under its line), and the typed words lit in each result's label,
	-- in the accent.
	local newPage = O.Grouped and O.Grouped.On() or false
	local y = layoutSections(searchView, sections, 16, { whole = true, gutter = SEARCH_GUTTER, legend = newPage or nil })
	for c, w in pairs(searchView.cache) do
		local label = rawget(w, "Label")
		if label and type(c) == "table" and (newPage or rawget(w, "psLit")) then
			local text = labelOf(c) or ""
			w.psLit = newPage or nil
			label:SetText(newPage and O.LitText(text, query, "accent") or text)
		end
	end
	-- Each result's way to its page: a chevron in the card's gutter left of
	-- the row opens the page and tab it lives on, the row scrolled into view
	-- and lit (O.Jump).
	for c, w in pairs(searchView.cache) do
		local j = rawget(w, "psJump")
		if w:IsShown() then
			if not j then
				j = W.IconButton(w, "chevron-right", 20, L["Show on its page"], function(self) O.Jump(self.psControl) end, 12)
				j:SetPoint("LEFT", w, "LEFT", -(SEARCH_GUTTER - 4), 0)
				w.psJump = j
			end
			j.psControl = c
			j:Show()
		end
	end
	searchView.Empty:SetShown(count == 0)
	-- The new page's no-hit view: Clear empties the box and goes back.
	if newPage and count == 0 and not rawget(searchView, "Clear") then
		searchView.Clear = W.Button(searchView, L["Clear"], function()
			O.SetQuery("")
			win.Search:SetText("")
		end)
	end
	if rawget(searchView, "Clear") then searchView.Clear:SetShown(newPage and count == 0) end
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
		if newPage then
			searchView.Clear:ClearAllPoints()
			searchView.Clear:SetPoint("TOPLEFT", searchView, "TOPLEFT", SH.pad, -(y - 16))
			y = y + 40
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
		if sectionShown(s) and s.toggle and available(s.toggle) then return true end
		for _, c in ipairs(sectionShown(s) and s.controls or {}) do
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

-- The page's settings new since the player last opened it, its sections'
-- toggles, its controls, their extras and what their cogs hold (references
-- aside), each while available. -> count
-- Only those marked new in some release can count, so they are listed once
-- per page (p.psNewList; a registration drops it).
function Index.newList(p)
	local list = p.psNewList
	if list then return list end
	list = {}
	local function put(x)
		if not rawget(x, "ref") and x.new then list[#list + 1] = x end
	end
	local function walk(c)
		put(c)
		for _, e in ipairs(c.extras or {}) do put(e) end
		for _, m in ipairs(c.more or {}) do walk(m) end
	end
	for _, t in ipairs(p.tabs) do
		for _, s in ipairs(t.sections) do
			if s.toggle then put(s.toggle) end
			for _, c in ipairs(s.controls) do
				if not rawget(c, "ref") then walk(c) end
			end
		end
	end
	p.psNewList = list
	return list
end
local function pageNew(p)
	local seen = seenTable()
	local seenNow, seenAll = seen[p.key], seen["*"]
	local n = 0
	for _, x in ipairs(Index.newList(p)) do
		if newer(x.new, seenNow) and newer(x.new, seenAll) and available(x) then n = n + 1 end
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
			for _, c in ipairs(homeSettings(s)) do
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
			if sectionModified(s) then return true end
		end
	end
	return false
end

local function navItems()
	if O.Grouped and O.Grouped.On() then return O.Grouped.NavItems() end
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
					-- One quiet mark a page: a ring while it holds settings new to the player, else a dot while one is off
					-- its default; no count.
					local new = pageNew(p) > 0
					local changed = not new and pageChanged(p)
					items[#items + 1] = { key = p.key, label = p.name, icon = p.icon, indent = true, dot = p.dot and p.dot() or nil,
						new = new or nil, changed = changed or nil,
						markTip = new and L["New settings on this page"] or changed and L["Settings on this page changed from their default"] or nil }
				end
			end
		end
	end
	return items
end

-- A sidebar click: a group's header folds or opens it, a page opens. The
-- grouped layout's tree takes its own keys (a tab, a pin, the profile).
local function navSelect(key)
	if O.Grouped and O.Grouped.NavSelect(key) then return end
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
	if win then W.ShellNav(win, navItems(), O.Grouped and O.Grouped.NavKey() or (query == "" and current and current.key or nil), navSelect) end
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

-- The settings Reset page puts back: every one a control of the page writes,
-- its row on screen or not. A row a mode hides keeps its setting all the
-- same (the trail dots while route lines are on; Dungeons in my route while
-- no guide has a dungeon), and the page is all at its defaults after, as its
-- dialog says. A reference counts where its home is, on this page or not at
-- all; a key with no default (its module not loaded) holds nothing to put
-- back. -> keys, the controls of state that is no setting (toggles,
-- sliders, dropdowns and cards with no key)
local pageKeys
do
	-- Whether setting spec c, met on page p, is another page's: a reference
	-- with no home yet or its home on another page, or a home's extra a
	-- reference shows (Reset page leaves it to that page; a reference to a
	-- row of its own page, Essentials, counts).
	local function elsewhere(c, p)
		if rawget(c, "ref") then
			local home = homeOf(c)
			return not home or rawget(home, "page") ~= p
		end
		local at = rawget(c, "page")
		return at ~= nil and at ~= p
	end

	function pageKeys(p)
		local keys, state = {}, {}
		for _, t in ipairs(p.tabs) do
			for _, s in ipairs(t.sections) do
				for _, c in ipairs(allSettings(s)) do
					if not elsewhere(c, p) then
						if c.key then
							if ns.GetDefault(c.key) ~= nil then keys[#keys + 1] = c.key end
						elseif (c.kind == "toggle" or c.kind == "slider" or c.kind == "dropdown" or c.kind == "cards") and c.set and available(c) then
							state[#state + 1] = c
						end
					end
				end
			end
		end
		return keys, state
	end
end

-- Does the page show a setting now (the footer offers Reset page)? A page
-- whose rows all wait on something missing (Integrations with none of its
-- addons installed) has nothing to reset in sight.
local function pageShowsSetting(p)
	for _, t in ipairs(p.tabs) do
		for _, s in ipairs(t.sections) do
			for _, c in ipairs(allSettings(s)) do
				if c.key and available(c) then return true end
			end
		end
	end
	return false
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
		-- Its key (the Profiles page sets one) in its tooltip.
		local key = ns.Profiles.Key and ns.Profiles.Key(name)
		local keyText = key and (UI.Profiles and UI.Profiles.KeyName and UI.Profiles.KeyName(key) or key)
		items[#items + 1] = { text = profileLabel(name), checked = name == active, tip = keyText and string.format(L["Key: %s"], keyText) or nil, onClick = function()
			if name == active then return end
			local ok, why = ns.Profiles.Switch(name)
			if not ok and why and ns.Print then ns.Print(why) end
		end }
	end
	items[#items + 1] = { separator = true }
	items[#items + 1] = { text = L["Manage profiles"], icon = "layers", onClick = function() O.Select("profiles") end }
	W.ShowMenu(button, items, { point = "BOTTOMRIGHT", relPoint = "TOPRIGHT", y = 4, current = true })
end

---------------------------------------------------------------------------
-- One step of undo for resets (a row's right-click, a section's Reset, the
-- page's): what the settings held before is kept, and a chip in the footer
-- says what was reset with an Undo for Undo.S seconds. A new reset takes
-- its place; Undo puts every one back at once.
---------------------------------------------------------------------------

Undo.S = 10
Undo.list, Undo.seq = nil, 0

function Undo.same(a, b)
	if type(a) == "table" and type(b) == "table" then
		for k, v in pairs(a) do if not Undo.same(v, b[k]) then return false end end
		for k in pairs(b) do if a[k] == nil then return false end end
		return true
	end
	if type(a) == "number" and type(b) == "number" then return math.abs(a - b) < 1e-6 end
	return a == b
end

-- The rows a reset put back (Undo.paths: path -> true), each with an Undo
-- link after its label while the chip shows on the new page.
Undo.links = {}
function Undo.rowLinks(on)
	for w in pairs(Undo.links) do w.UndoB:Hide() end
	Undo.links = {}
	if not (on and Undo.paths) then return end
	local view = O.view
	for c, w in pairs(view and view.cache or {}) do
		if type(c) == "table" and c.key and Undo.paths[c.key] and w:IsShown() and rawget(w, "Label") then
			local b = rawget(w, "UndoB")
			if not b then
				b = W.Link(w, L["Undo"], function() O.Undo() end)
				b.psTip, b.psTipLines = L["Undo"], { L["Puts back what that reset changed."] }
				b.Icon = W.Tex(b, "ARTWORK", "reset", "accent")
				b.Icon:SetSize(10, 10)
				b.Icon:SetPoint("LEFT", b, "LEFT", 0, 0)
				b.Label:ClearAllPoints()
				b.Label:SetPoint("LEFT", b, "LEFT", 14, 0)
				b:SetWidth(b:GetWidth() + 14)
				b:SetFrameLevel(w:GetFrameLevel() + 4)
				w.UndoB = b
			end
			b:ClearAllPoints()
			b:SetPoint("LEFT", w.Label, "LEFT", math.ceil(w.Label:GetStringWidth()) + 8, 0)
			b:Show()
			Undo.links[w] = true
		end
	end
end

-- Where the chip stands while it shows: in the footer, left of its
-- right-hand buttons (the current page); in the header beside the page's
-- crumb (the new page), and then on each row the reset put back too.
function O.UndoAnchor(frame)
	frame = frame or win
	local chip = frame and rawget(frame, "UndoChip")
	if not chip then return end
	local new = O.Grouped and O.Grouped.On() or false
	local parent = new and frame.Header or frame.Footer
	if chip:GetParent() ~= parent then
		chip:SetParent(parent)
		chip:SetFrameLevel(parent:GetFrameLevel() + 5)
	end
	Undo.rowLinks(new and chip:IsShown())
	if not chip:IsShown() then return end
	chip:SetWidth(12 + 6 + math.ceil(chip.Text:GetStringWidth()) + 4 + chip.Undo:GetWidth())
	chip:ClearAllPoints()
	if new then
		chip:SetPoint("LEFT", frame.Title, "RIGHT", 16, 0)
		-- The description after it makes room.
		if rawget(frame, "HeaderTools") then frame.HeaderTools.Place() end
		return
	end
	local anchor
	for _, fb in ipairs(frame.footerButtons.right) do if fb:IsShown() then anchor = fb end end
	if anchor then chip:SetPoint("RIGHT", anchor, "LEFT", -16, 0) else chip:SetPoint("RIGHT", frame.Footer, "RIGHT", -SH.pad, 0) end
end

function Undo.place() O.UndoAnchor(win) end

function Undo.hide()
	Undo.rowLinks(false)
	local chip = rawget(win, "UndoChip")
	if not (chip and chip:IsShown()) then return end
	chip:Hide()
	if chip:GetParent() == win.Header and rawget(win, "HeaderTools") then win.HeaderTools.Place() end
end

function Undo.chip()
	local chip = rawget(win, "UndoChip")
	if chip then return chip end
	chip = CreateFrame("Frame", nil, win.Footer)
	chip:SetHeight(28)
	chip:SetFrameLevel(win.Footer:GetFrameLevel() + 5)
	chip.Icon = W.Tex(chip, "ARTWORK", "reset", "textDim")
	chip.Icon:SetSize(12, 12)
	chip.Icon:SetPoint("LEFT", chip, "LEFT", 0, 0)
	chip.Text = W.Text(chip, "label", "textDim")
	chip.Text:SetPoint("LEFT", chip.Icon, "RIGHT", 6, 0)
	chip.Undo = W.Button(chip, L["Undo"], function() O.Undo() end, { ghost = true, height = 22 })
	chip.Undo.psTight = true
	W.SetButtonText(chip.Undo, L["Undo"])
	W.Color(chip.Undo.Label, "accent")
	chip.Undo.psTip, chip.Undo.psTipLines = L["Undo"], { L["Puts back what that reset changed."] }
	chip.Undo:SetPoint("LEFT", chip.Text, "RIGHT", 4, 0)
	chip:Hide()
	win.UndoChip = chip
	return chip
end

-- list: what a reset changed (holdings, W.OnReset's records). Offered only
-- while the window is up, and only what the reset did change.
function Undo.offer(list)
	if not (win and win:IsShown()) then return end
	local kept = {}
	for _, u in ipairs(list or {}) do
		if u.path or not Undo.same(u.get(), u.value) then kept[#kept + 1] = u end
	end
	if #kept == 0 then return end
	Undo.list = kept
	Undo.paths = {}
	for _, u in ipairs(kept) do if u.path then Undo.paths[u.path] = true end end
	Undo.seq = Undo.seq + 1
	local seq = Undo.seq
	local chip = Undo.chip()
	local c = #kept == 1 and kept[1].path and O.ControlByKey(kept[1].path)
	if c then
		chip.Text:SetText(string.format(L["%s reset."], labelOf(c) or ""))
	elseif #kept == 1 then
		chip.Text:SetText(L["One setting reset."])
	else
		chip.Text:SetText(string.format(L["%d settings reset."], #kept))
	end
	chip:Show()
	Undo.place()
	Anim.To(chip, "alpha", 0, 1, Anim.FAST, "out")
	ns.After(Undo.S, function()
		if Undo.seq ~= seq or not chip:IsShown() then return end
		Anim.To(chip, "alpha", 1, 0, Anim.SLOW, "out", function()
			if Undo.seq == seq then
				Undo.list, Undo.paths = nil, nil
				Undo.hide()
			end
		end)
	end)
end

-- Put back what the last reset changed. -> true when there was one
function O.Undo()
	local list = Undo.list
	if not list then return false end
	Undo.list, Undo.paths = nil, nil
	Undo.seq = Undo.seq + 1
	Undo.hide()
	-- State that is no setting first: a preset's cards write the settings they
	-- name (none matched: the first preset's), so each setting put back after
	-- them, as it was stored, has the last word.
	local function put()
		for _, u in ipairs(list) do
			if u.set then u.set(u.value) end
		end
		for _, u in ipairs(list) do
			if not u.set then ns.Set(u.path, u.value) end
		end
	end
	-- One batch: the look and the window worked out again once (ns.Batch).
	ns.Batch(put)
	-- State that is no setting repaints itself.
	local view = O.view
	for _, w in pairs(view and view.cache or {}) do
		if w.psControl and not w.psControl.key and w.Refresh then w:Refresh() end
	end
	return true
end

local footerProfile
local function renderFooter(p)
	-- The new settings page has no footer (W.ShellSetFooter): Reload UI and
	-- the resets are in its header.
	if rawget(win, "psNoFooter") then
		local _, active = profileNames()
		footerProfile = active
		Undo.place()
		return
	end
	local left = {}
	if p and pageShowsSetting(p) then
		left[#left + 1] = { label = L["Reset page"], opts = { ghost = true }, onClick = function()
			W.Modal({ title = L["Reset this page?"], icon = "reset", danger = true, action = L["Reset page"],
				text = string.format(L["Every setting on %s goes back to its default."], p.name),
				onAccept = function() O.ResetPage(p) end })
		end }
	end
	left[#left + 1] = { label = L["Reload UI"], onClick = function() if ReloadUI then ReloadUI() end end, opts = { icon = "reload", ghost = true } }
	local right = { { label = L["Close"], onClick = function() win:Hide() end } }
	local names, active = profileNames()
	footerProfile = active
	if names then
		right[#right + 1] = { label = string.format(L["Profile: %s"], profileLabel(active)), opts = { icon = "layers", ghost = true }, onClick = profileMenu }
	end
	W.ShellFooter(win, left, right)
	Undo.place()
	if Fold.state then win.Footer:Hide() end
end

function O.ResetPage(p)
	-- What the page holds, for Undo, before anything changes: a setting's reset
	-- can move state that is no setting (the guide window shown again resumes
	-- a pause).
	local held = {}
	local keys, state = pageKeys(p)
	for _, c in ipairs(state) do
		if c.get then held[#held + 1] = { get = c.get, set = c.set, value = c.get() } end
	end
	-- One batch: the look, the rows and the preview worked out again once at
	-- its end (ns.Batch), not once per setting; a setting at its default
	-- already is left alone.
	ns.Batch(function()
		for _, key in ipairs(keys) do
			local was = ns.GetStored(key)
			if was ~= nil then
				held[#held + 1] = { path = key, value = was }
				ns.Set(key, nil)
			end
		end
		-- Toggles, sliders, dropdowns and cards of state that is no setting go back to their default too.
		for _, c in ipairs(state) do c.set(nil) end
	end)
	for _, v in pairs(p.views or {}) do
		for _, w in pairs(v.cache or {}) do
			if w.psControl and not w.psControl.key and w.Refresh then w:Refresh() end
		end
	end
	Undo.offer(held)
end

-- Asked first, naming the page: every setting on it back to its default.
-- -> whether it asked (a page that shows no setting has nothing to reset)
function O.AskResetPage(p)
	if not (p and pageShowsSetting(p)) then return false end
	W.Modal({ title = L["Reset this page?"], icon = "reset", danger = true, action = L["Reset page"],
		text = string.format(L["Every setting on %s goes back to its default. Other pages keep theirs."], p.name or ""),
		onAccept = function() O.ResetPage(p) end })
	return true
end

-- What the profile in use holds off its default, as Undo holds it:
-- { { path, value } } by path. A list (a colour) is one setting; any other
-- table (a section, a record) is its fields. A value stored equal to
-- its default is left out.
local function storedSettings()
	local out = {}
	local function walk(t, prefix, depth)
		for k, v in pairs(t) do
			if type(k) == "string" then
				local path = prefix and (prefix .. "." .. k) or k
				-- Off its default as the Changed filter counts it (offDefault):
				-- a value stored equal to its default is nothing to reset.
				local off = ns.GetDefault(path) == nil or W.Modified(path)
				if type(v) ~= "table" then
					if off then out[#out + 1] = { path = path, value = v } end
				elseif next(v) ~= nil then
					-- A section (its defaults a table of fields too) or a record with no default: its fields.
					local d = ns.GetDefault(path)
					if depth < 8 and v[1] == nil and (d == nil or (type(d) == "table" and d[1] == nil)) then
						walk(v, path, depth + 1)
					elseif off then
						out[#out + 1] = { path = path, value = v }
					end
				end
			end
		end
	end
	walk(ns.DB().settings, nil, 0)
	table.sort(out, function(a, b) return a.path < b.path end)
	return out
end

-- Every setting of the profile in use back to its default (other profiles
-- and the account's window state are kept). -> what it held, for Undo.offer
function O.ResetAll()
	local held = storedSettings()
	if ns.ResetSettings then ns.ResetSettings() end
	return held
end

-- Asked first: the profile in use is what goes back, and the dialog says
-- whose it is; one the whole account or a class uses asks for a word first.
-- With nothing changed it says so and offers no reset.
function O.AskResetAll()
	local P = ns.Profiles
	local name = P and P.Active and P.Active()
	local label = name and P.Label and P.Label(name) or ""
	if #storedSettings() == 0 then
		W.Modal({ title = L["Reset all settings?"], icon = "reset", text = L["Nothing to reset"], noAction = true, cancel = L["Close"] })
		return
	end
	local account = name ~= nil and P.AccountProfile and P.AccountProfile() == name
	local classes = 0
	local map = ns.DB().classProfiles
	for _, n in pairs(type(map) == "table" and map or {}) do if n == name then classes = classes + 1 end end
	local text
	if account then
		text = string.format(L["Every setting of the profile %s goes back to its default, for every character on the account that uses it. Your guides and progress are kept."], label)
	elseif classes > 0 then
		text = string.format(L["Every setting of the profile %s goes back to its default, for every character of the classes that use it. Your guides and progress are kept."], label)
	else
		text = string.format(L["Every setting of the profile %s, this character's, goes back to its default. Your guides and progress are kept."], label)
	end
	W.Modal({ title = L["Reset all settings?"], icon = "reset", danger = true, action = L["Reset all"], text = text,
		typeToConfirm = (account or classes > 0) and L["RESET"] or nil,
		onAccept = function() Undo.offer(O.ResetAll()) end })
end

-- The tab last opened on each page (PolestarDB.optionsTab, account-wide,
-- not a setting): the page opens there again. -> name | nil
local function tabMemory()
	local db = ns.DB()
	if type(db.optionsTab) ~= "table" then db.optionsTab = {} end
	return db.optionsTab
end

-- The lead tab (Essentials) of the tab row: the star before its label, a
-- short upright hairline after it, the other tabs moved along to make room.
-- Run after every W.ShellTabs, which lays the row out afresh (the game's
-- tab looks keep their label's anchor: the shift made here comes off first).
local markLead
do
	local LEAD = { STAR = 11, GAP = 4, RULE = 17 }
	function markLead(list, active)
		local first = win.tabButtons and win.tabButtons[1]
		if not first then return end
		local grow = LEAD.STAR + LEAD.GAP
		local lp, lrel, lrp, lx, ly = first.Label:GetPoint(1)
		lx = lx or 0
		if first.psLeadX and math.abs(lx - first.psLeadX) < 0.01 then lx = lx - grow / 2 end
		first.psLeadX = nil
		local lead = first:IsShown() and list[1] and list[1].lead and #list > 1 and true or false
		local star, rule = rawget(first, "psStar"), rawget(win, "psLeadRule")
		if star then star:SetShown(lead) end
		if rule then rule:SetShown(lead) end
		if lp then
			first.Label:ClearAllPoints()
			first.Label:SetPoint(lp, lrel or first, lrp or lp, lead and lx + grow / 2 or lx, ly or 0)
		end
		if not lead then return end
		first.psLeadX = lx + grow / 2
		if not star then
			star = W.Tex(first, "ARTWORK", "star", "textMuted")
			star:SetSize(LEAD.STAR, LEAD.STAR)
			first.psStar = star
		end
		W.Color(star, list[1] == active and "accent" or "textMuted")
		star:ClearAllPoints()
		star:SetPoint("RIGHT", first.Label, "LEFT", -LEAD.GAP, 0)
		star:Show()
		first:SetWidth(first:GetWidth() + grow)
		if not rule then
			rule = W.Divider(win.TabRow, true)
			win.psLeadRule = rule
		end
		-- 8 either side of the hairline.
		local _, _, _, fx = first:GetPoint(1)
		rule:ClearAllPoints()
		rule:SetSize(1, 16)
		rule:SetPoint("LEFT", win.TabRow, "BOTTOMLEFT", (fx or 0) + first:GetWidth() + 8, SH.tabs / 2)
		rule:Show()
		local shift = grow + LEAD.RULE
		for i = 2, #win.tabButtons do
			local t = win.tabButtons[i]
			if t:IsShown() then
				local p, rel, rp, x, y = t:GetPoint(1)
				t:ClearAllPoints()
				t:SetPoint(p, rel, rp, (x or 0) + shift, y or 0)
			end
		end
	end
end

---------------------------------------------------------------------------
-- The first-use cue of a row's cog: the first change ever (on the account,
-- PolestarDB.optionsCogHint) of a setting whose row has a cog pulses the
-- cog's dot and says in a callout by it that more of that setting's
-- settings are behind it; once, and never after a cog has been opened.
---------------------------------------------------------------------------

do
	local function pulseDot(cog)
		local dot = cog.Dot
		local n = 3
		cog.psPulsing = true
		local function beat()
			if n <= 0 or not cog:IsVisible() then
				dot:SetSize(6, 6)
				cog.psPulsing = nil
				markSections(O.view)
				return
			end
			n = n - 1
			dot:Show()
			Anim.To(dot, "size", 6, 10, Anim.BASE, "out", function()
				Anim.To(dot, "size", 10, 6, Anim.SLOW, "inout", beat)
			end)
		end
		beat()
	end

	function O.CogCue(path)
		local db = ns.DB()
		if db.optionsCogHint or query ~= "" or not (win and win:IsShown() and O.view) then return end
		for c, cog in pairs(O.view.cogs or {}) do
			if c.key == path and cog:IsVisible() then
				db.optionsCogHint = true
				pulseDot(cog)
				local cue = W.Callout(win, { title = L["More settings here"], width = 260,
					text = string.format(L["%s has more settings behind its gear."], labelOf(c) or ""),
					anchor = cog, point = "TOPRIGHT", relPoint = "BOTTOMRIGHT", x = 8, y = -6 })
				cue.psCog = cog
				return
			end
		end
	end
end

---------------------------------------------------------------------------
-- Out of the way without closing: Peek (held down, its eye in the header)
-- fades the whole window so what it covers shows through; Fold leaves only
-- its header, the page kept, and Unfold (or going to another page, or a
-- search) brings the rest back. Shift and the wheel anywhere on the window
-- step its scale, the scale control lit so the change can be traced.
---------------------------------------------------------------------------

Fold.peekAlpha = 0.15

function O.Peek(on)
	if not win then return end
	on = on and win:IsShown() or false
	if (win.psPeek or false) == on then return end
	win.psPeek = on or nil
	Anim.To(win, "alpha", win:GetAlpha(), on and Fold.peekAlpha or 1, Anim.FAST, "out")
end

function Fold.paint()
	local b = rawget(win, "FoldButton")
	if not b then return end
	W.SetIcon(b, Fold.state and "chevron-down" or "chevron-up")
	b.psTip = Fold.state and L["Unfold"] or L["Fold"]
	b.psTipLines = { Fold.state and L["The whole window back, as you left it."] or L["Folds the window to its header, so it stops covering the screen. Nothing closes."] }
end

-- on: fold the window to its header (its top-left kept where it is), every
-- other part away; off: back as it was. -> true while folded
function O.Fold(on)
	if not win then return false end
	if on and not Fold.state then
		local left, top = win:GetLeft(), win:GetTop()
		if left and top then
			win:ClearAllPoints()
			win:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
		end
		Fold.state = { h = win:GetHeight(), hidden = {} }
		local function away(f)
			if f and f:IsShown() then
				f:Hide()
				Fold.state.hidden[#Fold.state.hidden + 1] = f
			end
		end
		for _, c in ipairs({ win.Main:GetChildren() }) do if c ~= win.Header then away(c) end end
		for _, c in ipairs({ win.Sidebar:GetChildren() }) do away(c) end
		away(win.Status)
		away(rawget(win, "Grip"))
		O.HideMore()
		W.HideMenu()
		win:SetHeight(SH.header + 2)
	elseif not on and Fold.state then
		local f = Fold.state
		Fold.state = nil
		win:SetHeight(f.h)
		for _, c in ipairs(f.hidden) do c:Show() end
	end
	Fold.paint()
	return Fold.state ~= nil
end

-- Shift + the wheel: the window's scale steps as its control's wheel does.
-- -> true when it took the wheel
function Fold.shiftScale(delta)
	if not (IsShiftKeyDown and IsShiftKeyDown()) then return false end
	local t = rawget(win, "HeaderTools")
	local s = t and rawget(t, "Slider")
	local fn = s and s:GetScript("OnMouseWheel")
	if not fn then return false end
	fn(s, delta)
	O.Flash(t)
	return true
end

-- A frame of the window whose wheel Shift turns into the window's scale.
function Fold.wheelScales(frame)
	local own = frame:GetScript("OnMouseWheel")
	frame:EnableMouseWheel(true)
	frame:SetScript("OnMouseWheel", function(self, delta)
		if Fold.shiftScale(delta) then return end
		if own then own(self, delta) end
	end)
end
O.WheelScales = Fold.wheelScales

-- The header box's text, with its placeholder and clear button (a text set
-- from code: the box's own change may not run first).
local function setBoxText(text)
	local box = win.Search
	if (box:GetText() or "") ~= text then box:SetText(text) end
	box.Placeholder:SetShown(text == "")
	box.Clear:SetShown(text ~= "")
end
O.SetBoxText = setBoxText

-- Show page `key` (and tab name), or the search results when searching.
function O.Select(key, tabName)
	if not win then return end
	if Fold.state then O.Fold(false) end
	local cue = rawget(win, "psCallout")
	if cue and cue.psCog then cue:Hide() end
	-- The grouped layout (UI/Grouped.lua), while the player has it on.
	if O.Grouped and O.Grouped.Select(key, tabName) then return end
	local p, aliasTab = pageByKey(key)
	p = p or pageList[1]
	tabName = tabName or aliasTab or tabMemory()[p.key]
	current = p
	W.HideMenu()
	O.HideMore()
	O.Dropdown.Hide()
	hideViews()
	-- Leaving the search: its words go from the box, searched or only typed.
	if query ~= "" or (win.Search:GetText() or "") ~= "" then
		query = ""
		setBoxText("")
	end
	local list = shownTabs(p)
	local t
	for _, tt in ipairs(list) do if tt.name == tabName then t = tt end end
	t = t or list[1]
	currentTab = t
	if #list > 1 then tabMemory()[p.key] = t.name end
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
	markLead(list, t)
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
	if Fold.state then O.Fold(false) end
	-- A query from code (a link, What's New, the dropdown's See all) shows in
	-- the header's box; the box's own change then finds it the same and does
	-- nothing more.
	setBoxText(query)
	if query == "" then
		O.Select(current and current.key, currentTab and currentTab.name)
		return
	end
	O.Dropdown.Hide()
	hideViews()
	if O.Grouped then O.Grouped.Searching() end
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
	if O.Grouped and O.Grouped.On() then return O.Grouped.Jump(c) end
	O.Select(p.key, c.tab or "")
	local view = O.view
	if not (view and view.cache) then return nil end
	-- An extra or a cog's setting: the row it is on.
	local row = c
	while row.psOwner do row = row.psOwner end
	local w, top = view.cache[row], nil
	-- A child while its parent is off: the parent's row.
	local kidOf = rawget(row, "psChildOf")
	if kidOf and not (w and w:IsShown()) and view.cache[kidOf] then w = view.cache[kidOf] end
	if w then
		top = w.psTop
	elseif view.extras[c] then
		-- A section's toggle: its card's header.
		w = view.extras[c]:GetParent()
		top = w:GetParent().psTop
	end
	if not (w and w:IsShown()) then return nil end
	W.ScrollTo(win.Scroll, max(0, (top or 0) - 40))
	O.Flash(w)
	return w
end

-- Open the window on setting `key`'s row (its home control, O.ControlByKey),
-- scrolled into view and lit (a mover's menu, What's New). -> the row, or nil
function O.JumpTo(key)
	UI.ShowOptions()
	local c = key and O.ControlByKey(key)
	return c and O.Jump(c) or nil
end

-- A setting's Move (a row's or a section's): the window steps aside, Move
-- frames opens with that frame's box picked and pulsing (ns.Movers.Unlock),
-- and when it ends the window comes back where it was (the page and tab,
-- the search, the scroll), `lit` (the row or section) lit. Without the
-- window up (a control pressed elsewhere), Move frames just opens on that
-- frame's box. -> ok
function O.MoveFrame(key, lit)
	local M = ns.Movers
	if not (M and M.Unlock) then return false end
	if not (win and win:IsShown()) then return M.Unlock(key, { pulse = true }) end
	local p, q, scroll = current, query, win.Scroll:GetVerticalScroll()
	win:Hide()
	local ok = M.Unlock(key, { pulse = true, back = function()
		UI.ShowOptions(p and p.key)
		if q ~= "" then O.SetQuery(q) end
		W.ScrollTo(win.Scroll, scroll)
		if lit and lit:IsVisible() then O.Flash(lit) end
	end })
	if not ok then win:Show() end
	return ok
end

-- The next (delta 1) or previous tab, running on into the next page's
-- first tab or the previous page's last (LB / RB on a gamepad).
function O.StepTab(delta)
	if not win then return end
	if O.Grouped and O.Grouped.StepTab(delta) then return end
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
-- What the search's dropdown (UI/SearchDropdown.lua) shows for a query and
-- what a row of it opens: the places the query names (a page, a tab, a
-- section) and the settings it finds, the best first.
---------------------------------------------------------------------------

-- MAX: the places a row may name at most. NAMED: a place whose whole name the
-- query says (every word, whole or its start) comes before one it only partly
-- names. One table to keep the main chunk's locals in budget.
local PLACE = { MAX = 3, NAMED = 50 }

-- A page's, tab's or section's name as the matcher reads it (its English
-- one too on a translated client), kept with it.
local placeTokens = setmetatable({}, { __mode = "k" })

-- How well the parsed query names a place: every word that is not filler
-- is one of the name's words, whole, its start or a typo off (inside a word
-- is too loose to name a place), three letters in all at least. -> score, 0
-- for none
local function placeScore(obj, name, nw)
	local d = placeTokens[obj]
	if not d or d.label ~= name then
		d = { label = name }
		placeTokens[obj] = d
	end
	local s = searchTokens(d)
	local tw, tf = s.words, s.fields
	local total, letters = 0, 0
	for i = 1, nw do
		local m, filler, best = qwords[i], qfiller[i], 0
		for j = 1, #tw do
			local k = kindOf(m, tw[j])
			if k == 4 or (k >= 2 and not filler) then
				local v = SCORE[tf[j]][k]
				if v > best then best = v end
			end
		end
		if best == 0 and not filler then return 0 end
		if not filler then letters = letters + m.n end
		total = total + best
	end
	if letters < 3 then return 0 end
	for _, w in ipairs(nameWords(name)) do
		local said = false
		for i = 1, nw do
			if kindOf(qwords[i], w) >= 3 then
				said = true
				break
			end
		end
		if not said then return total end
	end
	return total + PLACE.NAMED
end

-- Does a shown section hold a setting of its own (not only references to
-- settings at home elsewhere, an Essentials tab's)?
local function ownsSettings(s)
	if not sectionShown(s) then return false end
	if s.toggle and available(s.toggle) and not rawget(s.toggle, "ref") then return true end
	for _, c in ipairs(visible(s)) do
		if not rawget(c, "ref") then return true end
	end
	return false
end

-- The places the parsed query names, the best first, PLACE.MAX at most: a
-- tab named as its page is the page, a section named as its tab the tab, a
-- section of references (Essentials) is its settings' homes.
-- -> { { kind = "page"|"tab"|"section", text, where, page, tab, section }, ... }
local function places(nw)
	local list = {}
	local function add(kind, rank, obj, name, where, p, t, s)
		if not name or name == "" then return end
		local v = placeScore(obj, name, nw)
		if v > 0 then
			list[#list + 1] = { kind = kind, rank = rank, score = v, order = #list, text = name, where = where, page = p, tab = t, section = s }
		end
	end
	for _, p in ipairs(pageList) do
		if pageShown(p) then
			local group = groupOf(p)
			for _, g in ipairs(GROUPS) do if g.key == group then group = g.label end end
			add("page", 1, p, p.name, group, p)
			for _, t in ipairs(shownTabs(p)) do
				local tabName = t.name ~= "" and t.name or p.name
				if fold(tabName) ~= fold(p.name) then add("tab", 2, t, t.name, p.name, p, t) end
				for _, s in ipairs(t.sections or {}) do
					if s.name ~= "" and fold(s.name) ~= fold(tabName) and ownsSettings(s) then
						add("section", 3, s, s.name, t.name ~= "" and (p.name .. "  \194\183  " .. t.name) or p.name, p, t, s)
					end
				end
			end
		end
	end
	table.sort(list, function(a, b)
		if a.score ~= b.score then return a.score > b.score end
		if a.rank ~= b.rank then return a.rank < b.rank end
		return a.order < b.order
	end)
	for i = #list, PLACE.MAX + 1, -1 do list[i] = nil end
	return list
end

-- What query q finds, for the dropdown: -> {
--   places = { { kind, text, where, page, tab, section }, ... },
--   settings = { { control, text, where = "Page · Tab" }, ... }, places and
--     settings n at most together, the settings in score order (O.Search's);
--   count = how many settings it finds in all, suggestions = { label, ... }
--   (none found), page = the page it looks on (a query starting with its name) }
function O.Matches(q, n)
	n = n or 8
	local groups, count, suggestions, page = O.Search(q)
	local out = { places = {}, settings = {}, count = count, suggestions = suggestions, page = page }
	local nw = parseQuery(q)
	if nw == 0 then return out end
	out.places = places(nw)
	local flat = {}
	for gi, g in ipairs(groups) do
		for ci, c in ipairs(g.controls) do flat[#flat + 1] = { c = c, g = gi, i = ci } end
	end
	table.sort(flat, function(a, b)
		local x, y = a.c, b.c
		if x.psCore ~= y.psCore then return x.psCore > y.psCore end
		if x.psScore ~= y.psScore then return x.psScore > y.psScore end
		if x.psStopped ~= y.psStopped then return not x.psStopped end
		if a.g ~= b.g then return a.g < b.g end
		return a.i < b.i
	end)
	-- Each the setting that matched (an extra or a cog's on its row, when it
	-- matched better: "the arrow's colour" is Arrow colour, on the Size row),
	-- once.
	local listed = {}
	for _, f in ipairs(flat) do
		if #out.settings >= n - #out.places then break end
		local c = f.c.psVia or f.c
		if not (c.key and listed[c.key]) then
			if c.key then listed[c.key] = true end
			local where = c.page and c.page.name or ""
			if c.tab and c.tab ~= "" then where = where .. "  \194\183  " .. c.tab end
			out.settings[#out.settings + 1] = { control = c, text = labelOf(c) or "", where = where }
		end
	end
	return out
end

-- Open what a dropdown row stands for: a setting on its page, its row
-- scrolled into view and lit (O.Jump); a page at the tab last shown; a tab;
-- a section's card, scrolled into view, its header lit. -> the frame lit, or nil
function O.Go(d)
	if d.control then return O.Jump(d.control) end
	if not (win and d.page) then return nil end
	if d.kind == "page" then
		O.Select(d.page.key)
		return nil
	end
	O.Select(d.page.key, d.tab and d.tab.name or "")
	if d.kind ~= "section" then return nil end
	for _, card in ipairs(O.view and O.view.cards or {}) do
		if card:IsShown() and card.psSection == d.section then
			W.ScrollTo(win.Scroll, max(0, (card.psTop or 0) - 40))
			O.Flash(card.Header)
			return card
		end
	end
	return nil
end

---------------------------------------------------------------------------
-- The window's size: 1680 x 946 screen pixels (and more on a screen taller
-- than 1440 pixels, in 5 % steps) at the default Menu scale, whatever the UI
-- scale, until the player drags the grip (ui.optionsSize: { w, h } in the
-- window's own units; false: the default).
-- Never past the screen, never under SIZE.MIN_W x SIZE.MIN_H (the screen allowing).
---------------------------------------------------------------------------

SIZE.MIN_W, SIZE.MIN_H, SIZE.EDGE = W.SHELL_MIN_W, W.SHELL_MIN_H, 16

-- -> the default size, in UIParent units (W.ShellDefaultSize)
function O.DefaultSize()
	return W.ShellDefaultSize()
end

-- -> minW, minH, maxW, maxH in the window's units (its Menu scale applied)
local function sizeBounds()
	local s = win:GetScale() or 1
	if s <= 0 then s = 1 end
	local maxW = floor(UIParent:GetWidth() / s - 2 * SIZE.EDGE)
	local maxH = floor(UIParent:GetHeight() / s - 2 * SIZE.EDGE)
	return min(SIZE.MIN_W, maxW), min(SIZE.MIN_H, maxH), maxW, maxH
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

-- Lay everything on screen out again where it is (a new size or font): the
-- sidebar, the page on screen and its preview, the scroll kept.
local function relayout()
	if not (win and win:IsShown()) then return end
	W.ShellLayout(win)
	O.RefreshNav()
	if query ~= "" then
		renderSearch()
		return
	end
	if O.Grouped and O.Grouped.Relayout() then return end
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
O.Relayout = relayout

-- While shown, a setting's change updates the marks it moves: the
-- sections' Reset, the sidebar's changed dots (redrawn only when they
-- moved), the preview's height, the profile in the footer.
local navSig
local function refreshMarks()
	if query == "" and O.view and O.view:IsShown() then markSections(O.view) end
	local items = navItems()
	local sig = {}
	for i, it in ipairs(items) do
		sig[i] = (it.key or "") .. (it.changed and "*" or "") .. (it.new == true and "+" or tonumber(it.new) or "") .. (it.dot and "!" or "") .. (it.folded and "-" or "")
			.. (it.count ~= nil and ("#" .. tostring(it.count)) or "") .. (it.label or "")
	end
	sig = table.concat(sig, "|")
	if sig ~= navSig then
		navSig = sig
		W.ShellNav(win, items, O.Grouped and O.Grouped.NavKey() or (query == "" and current and current.key or nil), navSelect)
	end
	-- The new page places its tab's preview in its side card (UI/Grouped.lua).
	local newPage = O.Grouped and O.Grouped.On()
	if query == "" and not newPage and O.view and O.view:IsShown() and O.view.psTab and O.view.psTab.preview then
		placePreview(O.view, O.view.psTab, true)
	end
	local _, active = profileNames()
	if active ~= footerProfile then renderFooter(query == "" and current or nil) end
end

-- The settings window is a window of its own, beside the hub, not in its
-- place: no hub rail, the lockup with "Settings" under it, its own tree;
-- dragged by its header (or sidebar), kept on the screen.
local function build()
	win = W.Shell("PolestarOptions", {
		-- The box takes a question as well as a word: the longest wording that fits shows.
		title = GUIDE, tagline = L["Settings"], scalePath = "ui.menuScale", scaleBase = W.SETTINGS_SCALE_BASE,
		scaleLabel = L["Settings scale"], scaleTip = L["The settings window only; applies when you let go. Right-click to reset."],
		searchPlaceholder = { L["Ask or search: how do I hide the arrow?"], L["Ask or search settings"], L["Search settings"], L["Search"] },
		headerSearch = true,
		-- Typing opens the dropdown under the box; the page stays until a row
		-- is picked, or Enter or See all opens the results page. An emptied
		-- box closes the dropdown and leaves the results page.
		onSearch = function(text, typing)
			text = text or ""
			if text == "" then
				O.Dropdown.Hide()
				if query ~= "" then O.SetQuery("") end
			elseif typing then
				O.Dropdown.Show(text)
			end
		end,
		resizable = {
			onResized = function(w, h) ns.Set("ui.optionsSize", { floor(w + 0.5), floor(h + 0.5) }) end,
			onReset = function() ns.Set("ui.optionsSize", nil) end,
		},
	})
	O.frame = win
	O.Dropdown.Attach(win)
	applySize()
	UI.Report.SidebarLink(win)
	-- Special thanks is on About (under the credits), not in the footer, where
	-- it pulled the eye from the page.
	-- A row's right-click reset (W.ResetSetting) offers its Undo too.
	W.OnReset(Undo.offer)
	-- Peek (held down) and Fold in the header, between the search and the
	-- scale (W.HeaderScale lays the header's tools out right to left).
	-- The header's icon tools: one 24 box, one 16 glyph (W.HEAD_GLYPH, UI/Kit.lua), so
	-- their ink reads at one size (a 12 or 14 glyph shrinks the 32px art past
	-- half, and its strokes break up).
	local peekB = W.IconButton(win.Header, "eye", 24, L["Peek"], nil, W.HEAD_GLYPH)
	peekB.psTipLines = { L["Hold it down to see what the window covers."] }
	peekB:HookScript("OnMouseDown", function(_, button) if button == "LeftButton" then O.Peek(true) end end)
	peekB:HookScript("OnMouseUp", function() O.Peek(false) end)
	-- A hold has no gamepad press: the gamepad passes it by.
	peekB.psPadSkip = true
	-- Peek and Fold a pair, close together.
	peekB.psHeadGap = 4
	win.PeekButton = peekB
	local foldB = W.IconButton(win.Header, "chevron-up", 24, L["Fold"], function() O.Fold(not Fold.state) end, W.HEAD_GLYPH)
	win.FoldButton = foldB
	Fold.paint()
	win.psHeadTools = win.psHeadTools or {}
	table.insert(win.psHeadTools, 1, foldB)
	table.insert(win.psHeadTools, 2, peekB)
	-- Move frames, left of Peek: unlock mode (ns.Movers) with no frame
	-- picked. The window steps aside and comes back where it was when the
	-- mode ends (O.MoveFrame).
	if ns.Movers and ns.Movers.Unlock then
		local moveB = W.IconButton(win.Header, "move", 24, L["Move frames"], function() O.MoveFrame(nil) end, W.HEAD_GLYPH)
		moveB.psTipLines = { L["Drag the guide window, the arrow, the cards and the alerts where you want them. This window steps aside until you press Save and exit. Also /polestar unlock."] }
		moveB.psHeadGap = 4
		win.MoveButton = moveB
		table.insert(win.psHeadTools, 3, moveB)
	end
	if rawget(win, "HeaderTools") then win.HeaderTools.Place() end
	win:HookScript("OnHide", function()
		O.Peek(false)
		O.Fold(false)
	end)
	-- Shift + the wheel over the window, its body, its sidebar: its scale.
	Fold.wheelScales(win)
	Fold.wheelScales(win.Scroll)
	Fold.wheelScales(win.NavScroll)
	-- The body and the sidebar glide to where the wheel sends them (W.Scroll).
	win.Scroll.psGlide, win.NavScroll.psGlide = true, true
	-- The sidebar's nudge: a chevron at its foot while more of it lies below;
	-- a click glides to the bottom. In the sidebar's foot, on the version line
	-- left of the Discord mark (UI/Report.lua's R.SidebarLink), so it covers
	-- neither the list's last row nor a game look's scroll bar arrow.
	local side = win.NavScroll:GetParent()
	local nudge = W.IconButton(side, "chevron-down", 20, L["More below"], function() W.GlideTo(win.NavScroll, math.huge) end, 11)
	nudge:SetPoint("RIGHT", side, "BOTTOMRIGHT", -(SH.side + 28), SH.foot + 7)
	nudge:SetFrameLevel(win.NavScroll:GetFrameLevel() + 10)
	nudge:Hide()
	win.NavMore = nudge
	win.NavScroll.psOnScroll = function(_, cur, range) nudge:SetShown(range > 0 and cur < range - 1) end
	-- Install (UI/Welcome.lua) is on About ("Set Polestar up again") and in the
	-- search, not in the header, where it read as installing the addon.
	-- After the shell's own scale handler: the size follows the scale's room.
	ns.On("SETTING_CHANGED", function(path)
		-- A live change (a slider dragged) settles with a plain one: the marks, the
		-- sections' shown() and the window's size wait for it.
		if ns.SettingLive() then return end
		if path == "ui.optionsSize" or path == "ui.menuScale" or path == "" or path == "ui" then
			if applySize() then relayout() end
		end
		if win:IsShown() then
			if type(path) == "string" and path ~= "" then O.CogCue(path) end
			-- A section's shown() turned: the page lays out again.
			local v = O.view
			if query == "" and v and v:IsShown() and rawget(v, "psShownSig") and v.psShownSig ~= shownSig(v.psTab) then
				relayout()
			end
			refreshMarks()
		end
	end)
	-- A profile made, renamed or switched: the footer's switch says so.
	ns.On("PROFILES_CHANGED", function()
		if win:IsShown() then renderFooter(query == "" and current or nil) end
	end)
	-- A gamepad moves through the page (UI/Gamepad.lua); LB / RB step the tabs.
	win:HookScript("OnHide", function() O.HideMore() end)
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(win, {
			-- The window's widgets in order, each row's inline extras and cog
			-- after it (a row is one widget to the gamepad, its parts too).
			rows = function()
				local out = {}
				for _, w in ipairs(ns.Gamepad.Collect(win)) do
					out[#out + 1] = w
					for _, x in ipairs(rawget(w, "psExtras") or {}) do
						if x:IsShown() then out[#out + 1] = x end
					end
					local cog = rawget(w, "Cog")
					if cog and cog:IsShown() then out[#out + 1] = cog end
				end
				return out
			end,
			initial = function(rows)
				for i, w in ipairs(rows) do if ns.Gamepad.Within(w, win.Body) then return i end end
			end,
			prevTab = function() O.StepTab(-1) end,
			nextTab = function() O.StepTab(1) end,
		})
	end
end

-- Open the settings window (the hub, open or not, stays where it is), with
-- a question asked (`ask`, /polestar ask) in its search box.
function UI.ShowOptions(section, ask)
	if not win then build() end
	applySize()
	win:Show()
	O.Select(section or (current and current.key) or pageList[1].key)
	if ask then O.Ask(ask) end
end

-- A question asked from chat: its words in the header's box, which takes
-- the keyboard, and the dropdown open on what they find, as if typed (no
-- words: the box ready to type in).
function O.Ask(q)
	if not win then return end
	q = tostring(q or ""):match("^%s*(.-)%s*$")
	setBoxText(q)
	win.Search:SetFocus()
	if q ~= "" then O.Dropdown.Show(q) end
end

-- A new font measures every label, value and description anew: the
-- sidebar and the page on screen are laid out again where they are
-- (other tabs lay out when selected).
W.OnFontChanged(relayout)

-- The widgets on a page tab (tests and preview): key -> widget. Over a whole
-- page a setting's home row wins over a reference to it (Essentials).
function O.Controls(key, tabName)
	local p = pageByKey(key)
	local out, byRef = {}, {}
	if not p or not p.views then return out end
	local function put(c, k, w)
		local ref = rawget(c, "ref") or rawget(w, "psViaRef")
		if out[k] and not byRef[k] and ref then return end
		out[k], byRef[k] = w, ref and true or nil
	end
	for name, view in pairs(p.views) do
		if not tabName or name == tabName then
			for c, w in pairs(view.cache) do
				if c.key then put(c, c.key, w) else out[labelOf(c)] = w end
			end
			-- Inline extras and the sections' header toggles, by their keys.
			for c, w in pairs(view.extras or {}) do
				if c.key then put(c, c.key, w) end
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
-- Homes only: a reference (Essentials) is in O.References.
function O.AllControls()
	local out = {}
	for _, p in ipairs(pageList) do
		for _, t in ipairs(p.tabs) do
			for _, s in ipairs(t.sections) do
				for _, c in ipairs(homeSettings(s)) do out[#out + 1] = c end
			end
		end
	end
	return out
end

-- Every reference (Essentials rows and section switches), in page order.
function O.References()
	local out = {}
	for _, p in ipairs(pageList) do
		for _, t in ipairs(p.tabs) do
			for _, s in ipairs(t.sections) do
				if s.toggle and rawget(s.toggle, "ref") then out[#out + 1] = s.toggle end
				for _, c in ipairs(s.controls) do
					if rawget(c, "ref") then out[#out + 1] = c end
				end
			end
		end
	end
	return out
end

-- Every module's registrations, now and later.
W.OnOptionsRegistered(function(spec) add(spec, false) end)

-- What the grouped layout (UI/Grouped.lua) draws the same rows with: the
-- registry and this file's own pieces, so its pages are these rows in
-- other places, never copies.
O.Kit = {
	pages = pageList, pageList = pageList, groups = GROUPS, shownTabs = shownTabs, available = available, labelOf = labelOf, visible = visible, sectionSettings = sectionSettings,
	sectionShown = sectionShown, shownSig = shownSig, whyOff = whyOff, disabledOf = disabledOf, choicesOf = choicesOf, rowIsNew = rowIsNew, newer = newer,
	seenTable = seenTable, homeSettings = homeSettings, groupOf = groupOf, viewTables = viewTables,
	layoutSections = layoutSections, rowOf = rowOf, introRoom = introRoom, buildView = buildView, hideViews = hideViews,
	renderFooter = renderFooter, pageByKey = function(key) return pageByKey(key) end,
	window = function() return win end, query = function() return query end,
	searchView = function() return searchView end,
	pageShowsSetting = pageShowsSetting,
	clearQuery = function()
		if query ~= "" or (win.Search:GetText() or "") ~= "" then
			query = ""
			setBoxText("")
		end
	end,
	current = function() return current, currentTab end,
	profileNames = profileNames, profileLabel = profileLabel, profileMenu = profileMenu,
	setCurrent = function(p, t) current, currentTab = p, t end,
}

-- Polestar resumes by itself on the way out (Core/Pause.lua), maybe
-- with a page open: the toggles of state that is no setting repaint, as
-- O.ResetPage repaints them.
ns.On("POLESTAR_PAUSED", function()
	for _, p in ipairs(pageList) do
		for _, v in pairs(p.views or {}) do
			for _, w in pairs(v.cache or {}) do
				if w.psControl and not w.psControl.key and w.Refresh then w:Refresh() end
			end
		end
	end
end)
