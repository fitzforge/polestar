-- The options window, in the Polestar shell (Polestar.Widgets.Shell): pages
-- in the sidebar, tabs under the header band, sections of 40px label/control
-- rows in a two-column grid, action tiles for consequential actions, a
-- settings search, and a footer with Reset page, Reload UI and Close.
--
-- Built-in pages come first; other modules add theirs with
-- Polestar.RegisterOptions (docs/ARCHITECTURE.md, UI -> "Options
-- registry"), which may run before this file loads: the registry replays
-- every registration to us. A control whose settings key has no registered
-- default is left out rather than shown dead.
--
-- A Blizzard Settings category ("Polestar") opens this window.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, min, ipairs, pairs, type = math.floor, math.max, math.min, ipairs, pairs, type

local SH = W.SHELL
local GAP = 24 -- between the two grid columns
local TILE_GAP = 12 -- between lines of button tiles

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

local function add(spec, builtin)
	local p = pageOf(spec.page, spec.icon, spec.order, builtin, spec.key)
	if spec.subtitle then p.subtitle = spec.subtitle end
	if spec.custom then p.custom = spec.custom end
	if spec.dot then p.dot = spec.dot end
	if spec.empty then p.empty = spec.empty end
	local s = sectionOf(tabOf(p, spec.tab), spec.section)
	for _, c in ipairs(spec.controls or {}) do
		c.page, c.tab, c.section = p, spec.tab, spec.section
		s.controls[#s.controls + 1] = c
	end
	-- A page or tab already on screen picks up late registrations.
	if win and win:IsShown() then
		if current == p then
			if p.views then for _, v in pairs(p.views) do v:Hide() end end
			p.views = nil
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
-- setting: follow the guide (Guide), make Polestar look their way
-- (Appearance), choose what the maps show (Map), quest (Questing), find
-- things (Discovery: Lookup, the dungeon journal, rares), small
-- conveniences (Quality of Life), other addons Polestar works with
-- (Integrations); the author's Recorder and About close the
-- list. Modules still register their own controls; the pages they fill are
-- declared here with their tabs and sections in order, and the modules
-- register into them by name (docs/ARCHITECTURE.md, "Options registry").
---------------------------------------------------------------------------

local GUIDE, LOOK, MAP, QUESTING, DISCOVERY, QOL, REC, ABOUT =
	L["Guide"], L["Appearance"], L["Map"], L["Questing"], L["Discovery"], L["Quality of Life"], L["Recorder"], L["About"]

local function resetPositions()
	ns.Set("ui.pos", nil)
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

local function borderOff() return not ns.Get("ui.border") end
-- Settings of the house style alone: every other skin brings its own grounds,
-- no starlit band and no drop shadow (Theme.lua, "Skins").
local function houseOnly() return Theme.SkinKey() ~= "polestar" end
local function px(v) return string.format(L["%d px"], floor(v + 0.5)) end
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

local BUILTIN = {
	-- Following the guide: the window, the arrow and routes, automation.
	{ page = GUIDE, key = "guide", icon = "window", order = 10, tab = L["Window"], section = L["What it shows"],
		subtitle = L["The guide window, the arrow and its routes, and what Polestar does for you."], controls = {
		{ kind = "toggle", key = "ui.shown", label = L["Show the window"], help = L["Also /polestar, or the key binding."] },
		{ kind = "toggle", key = "ui.compact", label = L["Compact mode"], help = L["Only the header and the current step's goals."] },
		{ kind = "toggle", key = "ui.showNotes", label = L["Step tips"], help = L["The author's tip under the goals, one line until clicked."] },
		{ kind = "toggle", key = "ui.notesOpen", label = L["Expand step tips"], help = L["Start each step with its tip in full instead of one line."],
			disabled = function() return not ns.Get("ui.showNotes") end },
		{ kind = "slider", key = "ui.upcoming", label = L["Upcoming steps"], min = 0, max = 6, step = 1, format = "%d", help = L["How many steps the Up next list holds; 0 turns it off."] },
		{ kind = "toggle", key = "ui.upcomingOpen", label = L["Expand Up next"], help = L["Start with the upcoming steps listed instead of collapsed."] },
	} },
	{ page = GUIDE, tab = L["Window"], section = L["Combat"], controls = {
		{ kind = "dropdown", key = "ui.combat", label = L["In combat"], help = L["What the window does while you fight."],
			choices = { { value = "show", label = L["Keep visible"] }, { value = "fade", label = L["Fade out"] }, { value = "hide", label = L["Hide"] } } },
	} },
	{ page = GUIDE, tab = L["Window"], section = L["Dungeons"], controls = {
		{ kind = "dropdown", key = "ui.instance", label = L["In dungeons"], help = L["What the window does in dungeons and raids. /polestar or the key binding opens it there until you leave."],
			choices = { { value = "show", label = L["Keep visible"] }, { value = "hide", label = L["Hide"] } } },
	} },
	{ page = GUIDE, tab = L["Window"], section = L["Position"], controls = {
		{ kind = "toggle", key = "ui.locked", label = L["Lock window"], help = L["Prevents moving and resizing."] },
		{ kind = "toggle", key = "ui.lockHud", label = L["Lock arrow and buttons"],
			help = L["Stops stray drags on the arrow, the action buttons and the flight and instance timers. Shift-drag still moves them."] },
		{ kind = "toggle", key = "ui.growUp", label = L["Grow upward"], help = L["Keep the bottom edge in place, so longer steps extend the window up."] },
		{ kind = "toggle", key = "ui.barsBottom", label = L["Bar at the bottom"], help = L["With Grow upward, put the tabs and the step bar at the bottom edge, next to where the window is pinned."],
			disabled = function() return not ns.Get("ui.growUp") end },
		{ kind = "button", icon = "reset", label = L["Reset position"], help = L["Put the guide window back in its corner."], onClick = function() ns.Set("ui.pos", nil) end },
	} },
	{ page = GUIDE, tab = L["Arrow & routes"], section = L["Arrow"], controls = {
		H({ kind = "toggle", key = "nav.arrow", label = L["Show arrow"], help = L["Points to the current goal. Its look and colours are under Appearance, Arrow."] }),
		H({ kind = "toggle", key = "nav.arrowEta", label = L["Arrival time"], help = L["Estimated time under the distance."] }),
		{ kind = "dropdown", key = "nav.distanceUnit", label = L["Distances"], help = L["How the arrow, map tooltips, rares and the death helper show distances."],
			choices = { { value = "yards", label = L["Yards (the game's unit)"] }, { value = "metres", label = L["Metres"] } } },
		H({ kind = "toggle", key = "nav.arrivalSound", label = L["Arrival sound"], help = L["A soft chime when you reach a waypoint."] }),
		H({ kind = "button", icon = "reset", label = L["Reset arrow position"], help = L["Back to the top of the screen. Drag the arrow to move it."],
			onClick = function() if ns.Nav and ns.Nav.ResetArrowPosition then ns.Nav.ResetArrowPosition() end end,
			needs = function() return ns.Nav and ns.Nav.ResetArrowPosition end }),
	} },
	{ page = GUIDE, tab = L["Arrow & routes"], section = L["Routes"], controls = {
		H({ kind = "toggle", key = "nav.travel", label = L["Plan travel routes"], help = L["Flights, boats and your hearthstone when they are faster. Off: the arrow points straight at the goal."] }),
		H({ kind = "toggle", key = "nav.navRouting", label = L["Walk real paths"], help = L["The arrow follows paths on the ground around cliffs, water and walls, on Polestar's walking maps, with Shortest Path Forever's router by Cillian Berragan. Off: it points straight at each stop."] }),
		H({ kind = "toggle", key = "nav.routeLines", label = L["Route lines"], help = L["The way to the goal on the world map and the minimap: dots where you walk, lines where you fly, sail or ride, the legs after this one fainter. Drawn as Shortest Path Forever by Cillian Berragan draws them."],
			gear = { tip = L["Line style"], onClick = function() if UI.ShowLineStyle then UI.ShowLineStyle() end end } }),
		H({ kind = "toggle", key = "nav.teleports", label = L["Class teleports"], help = L["Routes may start with a Teleport spell you know (a mage's city teleports, a druid's Moonglade) when it is faster. A city teleport needs a Rune of Teleportation in your bags."],
			disabled = function() return not ns.Get("nav.travel") end }),
		{ kind = "toggle", key = "nav.shareTransit", label = L["Share boat times"], help = L["Riding a boat, zeppelin, tram or lift times it; your guild and group get those times and you get theirs, so the arrow can say when the next one leaves."] },
	} },
	{ page = GUIDE, tab = L["Arrow & routes"], section = L["Other waypoints"], controls = {
		H({ kind = "toggle", key = "nav.blizzardWaypoint", label = L["Blizzard waypoint"], help = L["Also set the game's own map pin and tracking."] }),
		H({ kind = "toggle", key = "nav.tomtom", label = L["Mirror to TomTom"], help = L["Adds the target as a TomTom waypoint when TomTom is loaded."] }),
		H({ kind = "toggle", key = "nav.useTomTomArrow", label = L["Use TomTom's arrow"], help = L["Hides Polestar's arrow in favour of TomTom's."],
			disabled = function() return not ns.Get("nav.tomtom") end }),
	} },
	{ page = GUIDE, tab = L["Automation"], section = L["Quests"], controls = {
		{ kind = "toggle", key = "behavior.autoAccept", label = L["Accept guide quests"], help = L["Only quests in the next steps of your open guides. Hold Shift to skip."] },
		{ kind = "toggle", key = "behavior.autoTurnin", label = L["Turn in guide quests"], help = L["Never picks between rewards. Hold Shift to skip."] },
		{ kind = "toggle", key = "behavior.closeSkipped", label = L["Close offers the guide skips"], help = L["After Polestar accepts or turns in a quest, closes the quest window the NPC opens next when the guide skips its quests. Hold Shift to keep it open."] },
		{ kind = "toggle", key = "behavior.warnClosing", label = L["Warn about missable quests"], help = L["Before you take a quest that closes another for good, says which in chat and leaves the accept to you."] },
		{ kind = "toggle", key = "behavior.skipGrey", label = L["Skip grey quests"], help = L["Leaves out grey quests and their turn-ins, unless a later quest needs them first."] },
		-- The answer at a group quest (`when group`) not answered one by one
		-- (Discovery > Group quests): ask at each, or do or skip them all.
		{ kind = "dropdown", key = "behavior.groupQuests", label = L["Group quests"],
			help = L["Elite and escort quests the guides mark for a group. Ask at each, or answer them all: with a group (a party levelling together) or skip them (solo). Discovery, Group quests changes one."],
			choices = { { value = "ask", label = L["Ask me at each"] }, { value = "do", label = L["Do them with a group"] }, { value = "skip", label = L["Skip them"] } },
			needs = function() local E = ns.Engine; return E and E.GroupQuests and #E.GroupQuests() > 0 end },
	} },
	{ page = GUIDE, tab = L["Automation"], section = L["Guides"], controls = {
		{ kind = "toggle", key = "behavior.autoSelectGuide", label = L["Pick a guide for me"], help = L["Opens the suggested guide when no tab is open."] },
		{ kind = "toggle", key = "behavior.autoNextGuide", label = L["Continue to the next guide"], help = L["Loads the follow-up guide in the same tab when one finishes."] },
		{ kind = "dropdown", key = "behavior.routeChoice", label = L["Where to level next"], help = L["Where a guide offers more than one zone to continue in (/polestar path)."],
			choices = { { value = "ask", label = L["Let me choose"] }, { value = "recommended", label = L["Take the recommended zone"] } } },
		{ kind = "dropdown", key = "behavior.trainReminder", label = L["Trainer reminders"], help = L["A note in the guide window, with the nearest trainer of your class, when new skills are waiting."],
			choices = { { value = "2", label = L["Every 2 levels"] }, { value = "1", label = L["Every level"] }, { value = "off", label = L["Off"] } } },
		{ kind = "toggle", key = "behavior.offerClassQuests", label = L["Offer class quests"],
			help = L["When one of your class's Class guides opens (your level, its first quest), the guide window offers to open it in a tab."] },
		{ kind = "button", icon = "reset", label = L["Reset guide progress"], help = L["Manual check-offs and skips, current guide."], confirm = true,
			onClick = function() if ns.Engine and ns.Engine.ResetProgress then ns.Engine.ResetProgress() end end,
			needs = function() return ns.Engine and ns.Engine.ResetProgress end },
	} },

	-- How everything looks: colour and type, the windows' frames and the
	-- guide window's own look, the arrow. Every change repaints live. The
	-- accent's sources sit together in their own section, so "Class colour"
	-- shares a row with the accent swatch it drives.
	{ page = LOOK, key = "appearance", icon = "palette", order = 20, tab = L["Colour & type"], section = L["Accent"],
		subtitle = L["Colours, type, window frames and the arrow. Everything repaints as you change it; right-click a setting to reset it."], controls = {
		{ kind = "color", key = "ui.accent", label = L["Accent colour"], linked = { "ui.matchAccent", "ui.classAccent" },
			help = L["Click to pick your own, right-click to go back to the scheme's."],
			shown = function() return Theme.Accent() end,
			source = function()
				if Theme.FollowsClassAccent() then return (UnitClass and UnitClass("player")) or L["Class colour"] end
				return Theme.FollowsEllesmereAccent() and "EllesmereUI" or L["Polestar gold"]
			end },
		{ kind = "toggle", key = "ui.classAccent", label = L["Class colour"],
			help = L["The accent follows your class: warlock purple, shaman blue, druid orange. Picking your own accent turns this off."] },
	} },
	{ page = LOOK, tab = L["Colour & type"], section = L["Background"], controls = {
		{ kind = "dropdown", key = "ui.scheme", label = L["Colour scheme"], disabled = houseOnly,
			help = L["How deep the night runs. Dusk is the default, Night the darkest, Graphite a neutral grey; EllesmereUI takes its panel colour and accent."],
			choices = function() return Theme.SchemeChoices() end },
		{ kind = "color", key = "ui.bgColor", label = L["Background colour"], disabled = houseOnly,
			help = L["The ground of every Polestar window. Right-click to go back to the scheme's. Text always stays legible: a colour too light for it is darkened."],
			shown = function() return Theme.Color("bg") end,
			source = function() return O.SchemeLabel() end },
		{ kind = "slider", key = "ui.brightness", label = L["Brightness"], disabled = houseOnly, min = -1, max = 1, step = 0.05, format = O.Signed,
			help = L["Lifts or lowers every background together. Right-click to reset."] },
		{ kind = "slider", key = "ui.bgOpacity", label = L["Background opacity"], min = 0, max = 1, step = 0.05, format = percent,
			help = L["The background opacity of every Polestar window: how much of the world shows through. Right-click to reset."] },
	} },
	{ page = LOOK, tab = L["Colour & type"], section = L["Type & motion"], controls = {
		{ kind = "dropdown", key = "ui.font", label = L["Font"], help = L["The skin's font (the default: the game's own, Fira Sans in Halo), the game's, Inter, Fira Sans, or EllesmereUI's."],
			choices = function()
				local list = { { value = "skin", label = L["The skin's font"] }, { value = "game", label = L["Game font"] },
					{ value = "inter", label = "Inter" }, { value = "fira", label = "Fira Sans" } }
				if Theme.IsEllesmere() then list[#list + 1] = { value = "ellesmere", label = "EllesmereUI" } end
				return list
			end,
			get = function() return Theme.FollowsEllesmereFont() and "ellesmere" or ns.Get("ui.font") end,
			set = function(v)
				if v == "ellesmere" then
					ns.Set("ui.matchFont", true)
					return
				end
				ns.Set("ui.font", v)
				if Theme.IsEllesmere() then ns.Set("ui.matchFont", false) end
			end },
		{ kind = "toggle", key = "ui.reduceMotion", label = L["Reduce motion"], help = L["No sliding or popping; fades stay short."] },
	} },
	{ page = LOOK, tab = L["Windows"], section = L["Frame"], controls = {
		{ kind = "dropdown", key = "ui.skin", label = L["Skin"],
			help = L["Polestar's own look (the default), Halo (no frame, a soft dark veil, Fira Sans), Hearth (warm game colours), or the game's own art: WoW Forever, Blizzard and Classic. Style, compact mode and the colours you pick work in each."],
			choices = function()
				local list = {}
				for i, c in ipairs(Theme.SkinChoices()) do list[i] = { value = c.value, label = c.text } end
				return list
			end },
		{ kind = "toggle", key = "ui.border", label = L["Window border"], help = L["The line around every Polestar window."] },
		{ kind = "color", key = "ui.borderColor", label = L["Border colour"], linked = { "ui.borderAccent" }, disabled = borderOff,
			help = L["Click to pick your own, right-click to go back to the scheme's hairline."],
			shown = function() return Theme.Color("windowBorder") end,
			source = function() return ns.Get("ui.borderAccent") and L["Accent"] or L["Hairline"] end },
		{ kind = "toggle", key = "ui.borderAccent", label = L["Accent border"], disabled = borderOff,
			help = L["The border takes your accent colour. Picking your own border colour turns this off."] },
		{ kind = "slider", key = "ui.borderSize", label = L["Border thickness"], min = 1, max = 4, step = 1, format = px, disabled = borderOff,
			help = L["In screen pixels; a thicker border grows outward. Right-click to reset."] },
		{ kind = "toggle", key = "ui.band", label = L["Starlit band"], disabled = houseOnly, help = L["The night sky with its stars across the top of every window. Off: the plain background."] },
		{ kind = "toggle", key = "ui.shadow", label = L["Window shadow"], disabled = houseOnly, help = L["The soft shadow under every window."] },
	} },
	{ page = LOOK, tab = L["Windows"], section = L["Guide window"], controls = {
		{ kind = "dropdown", key = "ui.style", label = L["Style"], help = L["Transparent drops every background and border; text is outlined and the controls appear when you hover the window."],
			choices = { { value = "standard", label = L["Standard"] }, { value = "transparent", label = L["Transparent"] } } },
		{ kind = "slider", key = "ui.scale", label = L["Window scale"], min = 0.6, max = 1.6, step = 0.05, format = percent },
		{ kind = "slider", key = "ui.width", label = L["Width"], min = 260, max = 560, step = 10, format = "%d" },
		{ kind = "slider", key = "ui.opacity", label = L["Window opacity"], min = 0.3, max = 1, step = 0.05, format = percent,
			help = L["The whole guide window, text included. The background's own opacity is under Colour & type."] },
	} },
	{ page = LOOK, tab = L["Windows"], section = L["Menus"], controls = {
		{ kind = "slider", key = "ui.menuScale", label = L["Menu scale"], min = 0.7, max = 1.4, step = 0.05, format = percent, release = true,
			help = L["The guide menu and this window; applies when you let go. Right-click to reset."] },
	} },
	{ page = LOOK, tab = L["Arrow"], section = L["Arrow"], controls = {
		H({ kind = "dropdown", key = "nav.arrowStyle", label = L["Arrow style"], choices = { { value = "skin", label = L["The skin's arrow"] }, { value = "3d", label = L["3D"] }, { value = "flat", label = L["Flat"] },
			{ value = "halo", label = L["Halo"] }, { value = "hearth", label = L["Hearth"] } } }),
		H({ kind = "slider", key = "nav.arrowScale", label = L["Arrow scale"], min = 0.5, max = 2, step = 0.05, format = percent }),
		H({ kind = "slider", key = "nav.arrowAlpha", label = L["Arrow opacity"], min = 0.2, max = 1, step = 0.05, format = percent }),
	} },
	{ page = LOOK, tab = L["Arrow"], section = L["Colours"], controls = {
		{ kind = "color", key = "nav.arrowColor", label = L["Arrow colour"],
			help = L["The arrow on its way; the target's pin on the maps and the route's stops wear it too. Right-click to go back to the accent."],
			shown = function() return Theme.Color("arrow") end,
			source = function() return L["Accent"] end },
		{ kind = "color", key = "nav.arrowNearColor", label = L["Arrival colour"],
			help = L["The arrow as it closes on the target, and the ring when you arrive. Right-click to go back to jade."],
			shown = function() return Theme.Color("arrowNear") end,
			source = function() return L["Jade"] end },
	} },

	-- Everything Polestar draws on the world map and the minimap, in one
	-- place. The sections are declared here, in this order; the Quests,
	-- Rares and Maps modules register their controls into them by name.
	{ page = MAP, key = "map", icon = "icon-explore", order = 30, tab = L["Guide & quests"], section = L["Guide"],
		subtitle = L["What Polestar draws on the world map and the minimap. Quest, rare and travel icons start off."], controls = {
		{ kind = "toggle", key = "nav.worldPins", label = L["Guide pins on the world map"],
			help = L["The arrow's target, the stops of its travel route, the step's other goals, the areas their mobs and objects spawn in, and the route lines."] },
		{ kind = "toggle", key = "nav.minimapPins", label = L["Guide pin on the minimap"], help = L["The arrow's target, the areas it spawns in, and the route line."] },
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
-- Dungeons and Rares on Discovery; QoL and Maps on Quality of Life.
for _, list in ipairs({
	declare(QUESTING, "questing", "icon-accept", 40, L["Quest information, rewards and gear advice, and the quest buttons."], {
		{ L["Quests"], { L["Quest database"], L["Tooltips and quest log"], L["Faster questing"] } },
		{ L["Rewards & gear"], { L["Quest rewards"], L["Gear advice"], L["Comparison"] } },
		{ L["Talents"], { L["Talent plan"] } },
		{ L["Buttons"], { L["Action buttons"] } },
	}),
	declare(DISCOVERY, "discovery", "search", 50, L["Lookup, the dungeon journal and rares: finding things in the world."], {
		{ L["Lookup"], { L["How to get anything"] } },
		{ L["Dungeons"], { ENCOUNTER_JOURNAL, L["Dungeons in leveling guides"] } },
		{ L["Rares"], { L["When a rare shows up"], L["How rares are noticed"], L["History"] } },
	}),
	declare(QOL, "qualityoflife", "qol-toggles", 60, L["Small conveniences: travel, invitations, merchants and trackers."], {
		{ L["Travel"], { L["Flight masters"], L["Hearthstone"], L["Flight timer"], L["Death"] } },
		{ L["Social"], { L["Requests"], L["Blocking"] } },
		{ L["Vendors"], { L["Merchants"] } },
		{ L["Trackers"], { L["Experience"], L["Instances"], L["Instance limits"] } },
	}),
}) do
	for _, spec in ipairs(list) do BUILTIN[#BUILTIN + 1] = spec end
end

for _, spec in ipairs(BUILTIN) do add(spec, true) end

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

---------------------------------------------------------------------------
-- Custom pages: Recorder status and About
---------------------------------------------------------------------------

local function recorderState()
	local loaded = C_AddOns and C_AddOns.IsAddOnLoaded and C_AddOns.IsAddOnLoaded("Polestar_Recorder")
	local db = PolestarRecorderDB
	if not loaded then return { installed = false } end
	local out = { installed = true, enabled = false, sessions = 0, events = 0 }
	if type(db) == "table" then
		out.enabled = db.enabled == true -- opt-in: off until the player starts it
		if type(db.sessions) == "table" then
			for _, s in pairs(db.sessions) do out.sessions = out.sessions + 1 end
			local cur = db.current and db.sessions[db.current]
			if type(cur) == "table" and type(cur.events) == "table" then
				out.events = #cur.events
				out.char = type(cur.char) == "table" and cur.char.name or nil
			end
		end
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
		sessions = W.InfoRow(view, L["Sessions stored"], L["Kept in SavedVariables until imported with the toolchain."]),
		events = W.InfoRow(view, L["Events this session"]),
		char = W.InfoRow(view, L["Character"]),
	}
	local header = W.SectionHeader(view)
	W.SetSection(header, L["Session"])
	local actions = W.SectionHeader(view)
	W.SetSection(actions, L["Actions"])
	local toggle = W.ActionTile(view, "record", L["Start recording"], L["Write quests, routes and world data for guide authors. Off until you start it."], function(self)
		recorderCommand(self.psOn and "off" or "on")
		view.Refresh()
	end)
	local status = W.ActionTile(view, "info", L["Print status"], L["Counts and the current session in chat."], function() recorderCommand("status") end)
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
			actions:Hide(); toggle:Hide(); status:Hide()
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
		rows.sessions.Value:SetText(st.sessions)
		rows.events.Value:SetText(st.events)
		rows.char.Value:SetText(st.char or "\226\128\147")
		y = y + placePair(view, { rows.status, rows.sessions }, y, cw, W.LayoutRow)
		y = y + placePair(view, { rows.events, rows.char }, y, cw, W.LayoutRow)
		actions:ClearAllPoints()
		actions:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
		actions:SetWidth(win.BodyWidth)
		actions:Show()
		y = y + 44 + 4
		toggle.psOn = st.enabled
		toggle.Title:SetText(st.enabled and L["Stop recording"] or L["Start recording"])
		toggle.psTitle = toggle.Title:GetText()
		toggle.Desc:SetText(st.enabled and L["Nothing more is written until you start it again."] or L["Write quests, routes and world data for guide authors. Off until you start it."])
		return y + placePair(view, { toggle, status }, y, cw, W.LayoutTile) + 24
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
		if kb >= 1024 then return string.format("%s  \194\183  %.1f MB", v, kb / 1024) end
		return string.format("%s  \194\183  %d KB", v, floor(kb + 0.5))
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
	local credH, credText = block(L["Credits"], L["Inter typeface by The Inter Project Authors, SIL Open Font License 1.1."] .. "\n"
		.. L["Wordmark set in Cinzel by The Cinzel Project Authors, SIL Open Font License 1.1."] .. "\n"
		.. L["Quest and map data includes pfQuest by shagu (MIT License)."] .. "\n"
		.. L["Discord and its logo are trademarks of Discord Inc.; the logo marks the link to the Polestar Discord."] .. "\n"
		.. L["With EllesmereUI installed, Polestar can follow its accent, font and panel colour through its public skinning API."])
	local maintH = W.SectionHeader(view)
	W.SetSection(maintH, L["Maintenance"])
	local resetAll = W.ActionTile(view, "reset", L["Reset all settings"], L["Every Polestar setting back to default. Progress is kept."],
		function() if ns.ResetSettings then ns.ResetSettings() end end, { confirm = true, danger = true })
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
			-- The welcome again, under the commands that it introduces.
			if pair[1] == cmdH then
				y = y + 4
				welcome:ClearAllPoints()
				welcome:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
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
add({ page = L["Guiding Stars"], key = "thanks", icon = "star", order = 80, subtitle = L["Celebrating the supporters and contributors behind Polestar."],
	custom = UI.Thanks.Build }, true)
add({ page = REC, key = "recorder", icon = "record", order = 90, subtitle = L["The data recorder for guide authors."], custom = buildRecorder }, true)
add({ page = ABOUT, key = "about", icon = "info", order = 100, subtitle = L["Why Polestar exists, its commands and its credits."], custom = buildAbout }, true)

-- Page keys from before the pages were regrouped (and older section names)
-- reach the page, and the tab, that holds those settings now.
local ALIASES = {
	guidewindow = { "guide", L["Window"] }, general = { "guide", L["Window"] }, window = { "guide", L["Window"] },
	navigation = { "guide", L["Arrow & routes"] }, nav = { "guide", L["Arrow & routes"] }, arrow = { "guide", L["Arrow & routes"] },
	groundtrail = { "appearance", L["Ground trail"] }, worldtrail = { "appearance", L["Ground trail"] },
	automation = { "guide", L["Automation"] }, behavior = { "guide", L["Automation"] }, behaviour = { "guide", L["Automation"] },
	quests = { "questing", L["Quests"] }, gear = { "questing", L["Rewards & gear"] }, talents = { "questing", L["Talents"] },
	lookup = { "discovery", L["Lookup"] }, dungeons = { "discovery", L["Dungeons"] }, rares = { "discovery", L["Rares"] },
	look = { "appearance" }, qol = { "qualityoflife" },
}

---------------------------------------------------------------------------
-- Controls and the grid
---------------------------------------------------------------------------

local function available(c)
	if c.needs and not c.needs() then return false end
	if c.kind == "button" then return true end
	if c.kind == "binding" then return ns.Gamepad ~= nil and ns.Gamepad.BindingRow ~= nil end
	-- A toggle with get/set and no key holds state that is no setting (per character).
	if c.kind == "toggle" and not c.key and c.get and c.set then return true end
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
	for i, ch in ipairs(list or {}) do out[i] = { value = ch.value, text = ch.text or ch.label or tostring(ch.value) } end
	return out
end

local function makeControl(parent, c)
	local w
	if c.kind == "toggle" then
		w = W.Toggle(parent, labelOf(c), c.key, c.help, nil, (c.gear or c.get or c.set) and { gear = c.gear, get = c.get, set = c.set } or nil)
	elseif c.kind == "slider" then
		w = W.Slider(parent, c.label, c.key, c.min or 0, c.max or 1, c.step or 0.1, c.format, c.help, nil, c.release and { release = true } or nil)
	elseif c.kind == "dropdown" then
		local choices = type(c.choices) == "function" and function() return choicesOf(c) end or choicesOf(c)
		w = W.Dropdown(parent, c.label, c.key, choices, c.help, nil, (c.get or c.set) and { get = c.get, set = c.set } or nil)
	elseif c.kind == "color" then
		w = W.Swatch(parent, c.label, c.key, c.help, { shown = c.shown, source = c.source, linked = c.linked })
	elseif c.kind == "button" then
		w = W.ActionTile(parent, c.icon or "bolt", c.label, c.help, c.onClick, { confirm = c.confirm, danger = c.danger })
		w.psTile = true
		if c.disabled then
			w.Refresh = function(self)
				local ok, off = pcall(c.disabled)
				off = ok and off
				self:SetAlpha(off and 0.45 or 1)
				if off then self:Disable() else self:Enable() end
			end
			W.SetDisabledWhen(w, c.disabled)
		end
		return w
	elseif c.kind == "binding" then
		w = ns.Gamepad.BindingRow(parent, c)
		w.psControl = c
		return w
	end
	if c.disabled then W.SetDisabledWhen(w, c.disabled) end
	w.psControl = c
	return w
end
-- A control from its spec, as the pages make them (UI/LineStyle.lua).
O.Control = makeControl

-- Lay controls out in a two-column grid from y; settings rows are 40px,
-- button tiles 60px, and a line grows to the tallest of its two (a label
-- or description that wraps). `cache` maps control spec -> widget. -> new y
function O.Grid(view, controls, y, cache)
	local cw = (win.BodyWidth - GAP) / 2
	local i, n = 1, #controls
	while i <= n do
		local tiles = controls[i].kind == "button"
		while i <= n and (controls[i].kind == "button") == tiles do
			local pair = {}
			while #pair < 2 and i <= n and (controls[i].kind == "button") == tiles do
				local c = controls[i]
				if not cache[c] then cache[c] = makeControl(view, c) end
				pair[#pair + 1] = cache[c]
				i = i + 1
			end
			y = y + placePair(view, pair, y, cw, tiles and W.LayoutTile or W.LayoutRow) + (tiles and TILE_GAP or 0)
		end
		y = y + (tiles and 4 or 8)
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

-- A view = one page tab rendered into its own frame (built once).
local function buildView(p, t)
	local view = CreateFrame("Frame", nil, win.Body)
	view:SetPoint("TOPLEFT", win.Body, "TOPLEFT", 0, 0)
	view:SetPoint("RIGHT", win.Body, "RIGHT", 0, 0)
	view.cache, view.headers = {}, {}
	if p.custom then
		p.custom(view)
	else
		view.Refresh = function()
			local y = 8
			local any = false
			local hi = 0
			for _, s in ipairs(t.sections) do
				local list = visible(s)
				if #list > 0 then
					any = true
					if s.name ~= "" then
						hi = hi + 1
						local h = view.headers[hi]
						if not h then
							h = W.SectionHeader(view)
							view.headers[hi] = h
						end
						W.SetSection(h, s.name)
						h:ClearAllPoints()
						h:SetPoint("TOPLEFT", view, "TOPLEFT", SH.pad, -y)
						h:SetWidth(win.BodyWidth)
						h:Show()
						y = y + 44
					end
					y = O.Grid(view, list, y, view.cache)
				end
			end
			for i = hi + 1, #view.headers do view.headers[i]:Hide() end
			if not any then
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
			return y + 16
		end
	end
	return view
end

---------------------------------------------------------------------------
-- Search: every searchable control across pages, as one page of results.
---------------------------------------------------------------------------

local searchView

local function matches(c, words)
	local hay = ((labelOf(c) or "") .. " " .. (c.help or "") .. " " .. (c.page and c.page.name or "") .. " " .. (c.tab or "") .. " " .. (c.section or "")):lower()
	for _, w in ipairs(words) do
		if not hay:find(w, 1, true) then return false end
	end
	return true
end

-- -> { { title = "Page · Tab", controls = { ... } }, ... }, count
function O.Search(q)
	local words = {}
	for w in (q or ""):lower():gmatch("%S+") do words[#words + 1] = w end
	local groups, count = {}, 0
	if #words == 0 then return groups, 0 end
	for _, p in ipairs(pageList) do
		for _, t in ipairs(p.tabs) do
			local list = {}
			for _, s in ipairs(t.sections) do
				for _, c in ipairs(s.controls) do
					if available(c) and matches(c, words) then list[#list + 1] = c end
				end
			end
			if #list > 0 then
				groups[#groups + 1] = { title = t.name ~= "" and (p.name .. "  \194\183  " .. t.name) or p.name, controls = list }
				count = count + #list
			end
		end
	end
	return groups, count
end

local function renderSearch()
	if not searchView then
		searchView = CreateFrame("Frame", nil, win.Body)
		searchView:SetPoint("TOPLEFT", win.Body, "TOPLEFT", 0, 0)
		searchView:SetPoint("RIGHT", win.Body, "RIGHT", 0, 0)
		searchView.cache, searchView.headers = {}, {}
		searchView.Empty = W.Text(searchView, "note", "textMuted")
	end
	for _, w in pairs(searchView.cache) do w:Hide() end
	local groups, count = O.Search(query)
	local y = 8
	for i, g in ipairs(groups) do
		local h = searchView.headers[i]
		if not h then
			h = W.SectionHeader(searchView)
			searchView.headers[i] = h
		end
		W.SetSection(h, g.title)
		h:ClearAllPoints()
		h:SetPoint("TOPLEFT", searchView, "TOPLEFT", SH.pad, -y)
		h:SetWidth(win.BodyWidth)
		h:Show()
		y = O.Grid(searchView, g.controls, y + 44, searchView.cache)
	end
	for i = #groups + 1, #searchView.headers do searchView.headers[i]:Hide() end
	searchView.Empty:SetShown(count == 0)
	if count == 0 then
		searchView.Empty:SetText(string.format(L["No settings match \226\128\156%s\226\128\157."], query))
		searchView.Empty:ClearAllPoints()
		searchView.Empty:SetPoint("TOPLEFT", searchView, "TOPLEFT", SH.pad, -24)
		y = 80
	end
	W.ShellTitle(win, L["Search"], count == 1 and L["1 setting matches"] or string.format(L["%d settings match"], count))
	W.ShellTabs(win, nil)
	searchView:Show()
	W.ShellBody(win, y + 16)
	O.results = { groups = groups, count = count }
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

local function navItems()
	local items = {}
	for _, p in ipairs(pageList) do
		if pageShown(p) or p == current then items[#items + 1] = { key = p.key, label = p.name, icon = p.icon, dot = p.dot and p.dot() or nil } end
	end
	return items
end

function O.RefreshNav()
	if win then W.ShellNav(win, navItems(), query == "" and current and current.key or nil, function(k) O.Select(k) end) end
end

-- -> page, the tab an old page key points at (nil: the page's first). A
-- page's own key wins over an alias of the same name.
local function pageByKey(key)
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

local function renderFooter(p)
	local left = {}
	if p and #pageKeys(p) > 0 then
		left[#left + 1] = { label = L["Reset page"], onClick = function() O.ResetPage(p) end, opts = { icon = "reset", confirm = true } }
	end
	left[#left + 1] = { label = L["Reload UI"], onClick = function() if ReloadUI then ReloadUI() end end, opts = { icon = "reload" } }
	W.ShellFooter(win, left, { { label = L["Close"], onClick = function() win:Hide() end } })
end

function O.ResetPage(p)
	for _, key in ipairs(pageKeys(p)) do ns.Set(key, nil) end
	-- Toggles of state that is no setting go back to their default too.
	for _, t in ipairs(p.tabs) do
		for _, s in ipairs(t.sections) do
			for _, c in ipairs(s.controls) do
				if c.kind == "toggle" and not c.key and c.set and available(c) then c.set(nil) end
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
	W.ShellNav(win, navItems(), p.key, function(k) O.Select(k) end)
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
	if query == "" then
		O.Select(current and current.key, currentTab and currentTab.name)
		return
	end
	hideViews()
	W.ShellNav(win, navItems(), nil, function(k) O.Select(k) end)
	renderSearch()
	renderFooter(nil)
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

-- The settings are the hub's Options section in their own shell: the same
-- rail, Options marked, so any section is one click back.
local function build()
	win = W.Shell("PolestarOptions", {
		rail = true, title = GUIDE, scalePath = "ui.menuScale", searchPlaceholder = L["Search settings"],
		onSearch = function(text)
			if (text or "") == query then return end
			O.SetQuery(text)
		end,
	})
	O.frame = win
	UI.Report.SidebarLink(win)
	UI.Thanks.HeaderLink(win)
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

local function renderRail()
	local P = UI.Picker
	local foot = P and P.FootItems and P.FootItems() or { { key = "Options", label = L["Options"], icon = "sliders", tip = L["Options"] } }
	W.ShellRail(win, P and P.RailItems and P.RailItems() or {}, foot, "Options", function(key)
		if P and P.ShowSection then P.ShowSection(key) end
		UI.ShowPicker()
	end)
end

function UI.ShowOptions(section)
	if not win then build() end
	local hub = UI.Picker and UI.Picker.frame
	if hub and hub:IsShown() then
		if not win:IsShown() then UI.Picker.TakePlace(win, hub) end
		hub:Hide()
	end
	renderRail()
	win:Show()
	O.Select(section or (current and current.key) or pageList[1].key)
end

-- A new font measures every label, value and description anew: the rail,
-- the sidebar and the page on screen are laid out again where they are
-- (other tabs lay out when selected).
W.OnFontChanged(function()
	if not (win and win:IsShown()) then return end
	renderRail()
	if query ~= "" then
		W.ShellNav(win, navItems(), nil, function(k) O.Select(k) end)
		renderSearch()
		return
	end
	O.RefreshNav()
	local view = O.view
	if view and view:IsShown() and view.Refresh then
		local h = view.Refresh()
		view:SetHeight(h)
		W.ShellBody(win, h)
	end
end)

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
			out[#out + 1] = { name = p.name, key = p.key, builtin = p.builtin and true or false, tabs = tabs }
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
