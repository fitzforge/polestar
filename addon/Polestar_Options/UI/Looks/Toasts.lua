-- Alerts & toasts: the options page for how each of Polestar's toasts looks
-- and moves (Options > Look > Alerts & toasts, key `alerts`), and its pinned
-- previews. The toasts' look itself is core (Polestar/UI/Toasts.lua,
-- UI.Toasts); this file is part of the settings window's addon.
--
--   UI.Toasts.Preview(view, tab)           the options' pinned preview (sandbox toasts)
--   UI.Toasts.NewStage(view), .FitInto(stage, frame, w, h, scale)   a preview's stage (the trackers' too)
--   UI.Toasts.Hot(stage, region, key)      a click target on a preview that jumps to its row
--
-- Previews draw the toasts' own builders in a sandbox (Rares.Toast.NewCard,
-- Nav.alerts.NewBanner, WhileHereToast.NewCard, ClassToast.NewCard,
-- ClassCard.NewCard) fed made-up content: no event, no waypoint, no sound
-- unless the player presses Play. Nothing is built before the page shows;
-- nothing runs while it is hidden (a change then is applied when it shows).

local ns = Polestar
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local floor, max, min, format, type, ipairs, pairs, tonumber = math.floor, math.max, math.min, string.format, type, ipairs, pairs, tonumber

local TS = UI.Toasts
local NEW = "0.3.8"

local function stackOn() return ns.Get("toasts.stack") and true or false end

local stages = setmetatable({}, { __mode = "k" }) -- preview stages -> true
local markStages

-- A toasts setting changed: the stages repaint (now when shown, else when
-- they show); the toasts themselves follow in UI.Toasts.
ns.On("SETTING_CHANGED", function(path)
	if path ~= "" and path ~= "toasts" and path:sub(1, 7) ~= "toasts." then return end
	if path:match("^toasts%.[^.]+%.point$") then return end
	markStages()
end)

---------------------------------------------------------------------------
-- Previews
---------------------------------------------------------------------------

local STAGE_H = 210
local SOUND_HERE = "Interface\\AddOns\\Polestar\\Media\\Sounds\\while-here.ogg"

local function classChime()
	local CC = UI.ClassCard
	if ns.Get("ui.classCardSound") and CC and CC.GameSoundOn() and PlaySound then
		pcall(PlaySound, (SOUNDKIT and SOUNDKIT.IG_QUEST_LIST_COMPLETE) or 878, "SFX")
	end
end

-- Play: each toast's own sound, when it is on.
local SOUNDS = {
	rare = function()
		local R = ns.Rares
		if R and R.PlaySound then R.PlaySound() end
	end,
	transport = function()
		local A = ns.Nav and ns.Nav.alerts
		if ns.Get("nav.alertSound") and A and A.SOUND and PlaySoundFile then PlaySoundFile(A.SOUND.boat, "Master") end
	end,
	whilehere = function()
		if ns.Get("behavior.whileHereSound") and PlaySoundFile then PlaySoundFile(SOUND_HERE, "SFX") end
	end,
	headsup = classChime,
	classcard = classChime,
}

-- The made-up content each preview shows.
local function demoRare()
	local Lv = ns.Levels
	local p = Lv and Lv.Player and Lv.Player() or {}
	return { kind = "rare", id = 61, name = L["Thuros Lightfingers"], level = max(1, p.level or 10), elite = false, yards = 85,
		zone = L["Elwynn Forest"], map = 1429, x = 50, y = 50, source = "preview" }
end

local function demoHeadsUp()
	local LT = UI.LevelTip
	local m = { icon = Theme.Media("icon-dungeon"), iconColor = "dungeon", titleColor = "text" }
	m.head = format(L["LEVEL %d · DUNGEON"], 18)
	m.title = format(L["%s is open to you"], L["The Deadmines"])
	m.giver = format(L["%d quests to pick up"], 4) .. "  \194\183  " .. L["Westfall"]
	if LT and LT.Text then m.badge = LT.Text(1.4):upper() end
	m.act = { label = L["Pick up the quests"] }
	m.more = { label = L["Open in Dungeons"] }
	m.off = { label = L["Turn these off"] }
	return m
end

local function demoClassCard()
	local p = ns.Levels and ns.Levels.Player and ns.Levels.Player() or {}
	local class = p.class or "WARLOCK"
	local name = UI.ClassName and UI.ClassName(class) or class
	return { class = class, head = format(L["%s · LEVEL %d"], name:upper(), 10), title = L["The Binding"],
		learn = format(L["Learn %s"], L["Summon Voidwalker"]), badge = L["NEW PET"], icon = Theme.Media("icon-learn"),
		trip = L["Durotar"] .. "  \226\128\186  " .. L["Orgrimmar"] .. "  \194\183  " .. format(L["%d steps"], 4) }
end

-- Nav's alerts as this file loads (UI loads after Nav): a test client that
-- swaps ns.Nav for a stand-in later still reaches the banner's builder.
local NAV_ALERTS = ns.Nav and ns.Nav.alerts

-- The sandbox toast of each kind, built into `parent` and painted. -> frame
-- (nil: its module is not loaded), its own width and height.
local BUILD = {
	rare = function(parent)
		local T = ns.Rares and ns.Rares.Toast
		if not (T and T.NewCard) then return nil end
		local c = T.NewCard(parent)
		T.FillCard(c, demoRare())
		return c
	end,
	transport = function(parent)
		local A = ns.Nav and ns.Nav.alerts or NAV_ALERTS
		if not (A and A.NewBanner) then return nil end
		local c = A.NewBanner(parent)
		A.FillBanner(c, false, format(L["Boat to %s"], L["Menethil Harbor"]), format(L["Arrives in %s"], "0:24"), 0.8)
		return c
	end,
	whilehere = function(parent)
		local T = UI.WhileHereToast
		if not (T and T.NewCard) then return nil end
		local c = T.NewCard(parent)
		T.FillCard(c, { t = "kill", hereText = format(L["Kill %s"], L["Kobold Vermin"]) .. "  8/10", yards = 50 })
		return c
	end,
	headsup = function(parent)
		local T = UI.ClassToast
		if not (T and T.NewCard) then return nil end
		local c = T.NewCard(parent)
		T.FillCard(c, demoHeadsUp(), 340)
		return c
	end,
}

-- The relayout the toast's own look does after a change of type size, then
-- the card's paint for its demo again (a sandbox heads-up keeps its width).
local REFILL = {
	headsup = function(c) local T = UI.ClassToast; if T and c.psModel then T.FillCard(c, c.psModel, 340) end end,
}

-- A stage `height` tall (STAGE_H by default): a toast's own height and room
-- for the window's "Preview" over it and Play under it, no more. The
-- settings window's preview stage (UI.Preview.Stage): the toast over the
-- world it shows in, the zone you stand in. Its caption: how much it had to
-- shrink the toast to fit, or why it is empty.
local function newStage(view, height)
	local s = UI.Preview.Stage(view, { height = height or STAGE_H, backdrop = "world" })
	s.Paint = function(self) if self.Refresh then self:Refresh() end end
	stages[s] = true
	return s
end

function markStages()
	for s in pairs(stages) do
		if s:IsVisible() then s:Refresh() else s.psDirty = true end
	end
end

-- Fit a toast of size w x h (its own units) at its scale into the stage's
-- room under the chrome, over Play, on a whole pixel; says so when it had to
-- shrink it. Its place is its entrance's (Anim.Anchor).
local function fitInto(s, card, kind, w, h, scale)
	UI.Preview.Fit(s, card, w, h, scale or TS.Scale(kind), { bottom = 42, anchor = Anim.Anchor })
end

TS.NewStage = newStage
TS.STAGE_H = STAGE_H
function TS.FitInto(s, frame, w, h, k) fitInto(s, frame, nil, w, h, k) end

-- A click target on a part of the preview that jumps to its setting's row
-- (the options window's hotspots; nothing without them).
function TS.Hot(stage, region, key)
	local O = UI.Options
	if not (region and O and O.PreviewHotspot) then return nil end
	local b = O.PreviewHotspot(stage, region, key)
	local hots = rawget(stage, "Hots")
	if not hots then
		hots = {}
		stage.Hots = hots
	end
	hots[key] = b
	return b
end

-- One toast kind's stage: its sandbox toast, Play (the entrance again, and
-- the sound when it is on).
local HEIGHT = { rare = 190, transport = 150, whilehere = 140, headsup = 210 }

local function toastStage(view, kind)
	local s = newStage(view, HEIGHT[kind])
	local card = BUILD[kind](s)
	s.Card = card
	if not card then
		s.psNote = (L["Not loaded"])
		function s:Refresh() end
		function s:Layout(width)
			self:SetWidth(width)
			self.psWidth = width
			return self.psHeight
		end
		return s
	end
	card:Show()
	card:SetAlpha(TS.Alpha(kind))
	-- The card finds its look's rows; its title and other lines their sizes.
	local t, k = card.psToast, "toasts." .. kind .. "."
	TS.Hot(s, card, k .. "scale")
	TS.Hot(s, t.titles[1], k .. "titleSize")
	TS.Hot(s, t.bodies[1], k .. "bodySize")
	function s:Refresh()
		local fill = REFILL[kind]
		TS.ApplyLook(card, true)
		if fill then fill(card) end
		fitInto(self, card, kind, card:GetWidth(), card:GetHeight())
		if not Anim.IsRunning(card, "alpha") then card:SetAlpha(TS.Alpha(kind)) end
	end
	s.Play = W.Button(s, L["Play"], function()
		TS.Enter(kind, card, kind == "headsup" and card:GetHeight() or 18, kind == "transport" and Anim.FAST or Anim.SLOW * 1.5)
		local play = SOUNDS[kind]
		if play then play() end
	end, { height = 22 })
	s.Play:SetPoint("BOTTOMRIGHT", s, "BOTTOMRIGHT", -12, 10)
	function s:Layout(width)
		self:SetWidth(width)
		self.psWidth = width
		self:Refresh()
		return self.psHeight
	end
	return s
end

-- The class quest card on a guide window's ground, as the guide window draws it.
local CARD_W = 360
local function classCardStage(view)
	local s = newStage(view)
	local CC = UI.ClassCard
	if not (CC and CC.NewCard) then
		s.psNote = (L["Not loaded"])
		function s:Refresh() end
		function s:Layout(width) self:SetWidth(width) self.psWidth = width return self.psHeight end
		return s
	end
	local ground = CreateFrame("Frame", nil, s)
	ground.psGuide = true
	Theme.Skin(ground, "window")
	local card = CC.NewCard(ground)
	s.Card, s.Ground = card, ground
	local demo = demoClassCard()
	-- Its type sizes, as the guide window's card has them.
	TS.Attach("classcard", card, { titles = { card.Title }, bodies = { card.Head, card.Learn, card.Trip, card.Only }, inline = true, sandbox = true })
	TS.Hot(s, card.Glow, "toasts.classcard.glow")
	TS.Hot(s, card.Stripe, "toasts.classcard.stripe")
	TS.Hot(s, card.Title, "toasts.classcard.titleSize")
	TS.Hot(s, card.Trip, "toasts.classcard.bodySize")
	function s:Refresh()
		TS.ApplyLook(card)
		local h = CC.FillDemo(card, demo, CARD_W)
		ground:SetSize(CARD_W, h)
		UI.Preview.Fit(self, ground, CARD_W, h, 1, { bottom = 42 })
	end
	s.Play = W.Button(s, L["Play"], function()
		if CC.Shine then CC.Shine(card) end
		classChime()
	end, { height = 22 })
	s.Play:SetPoint("BOTTOMRIGHT", s, "BOTTOMRIGHT", -12, 10)
	function s:Layout(width)
		self:SetWidth(width)
		self.psWidth = width
		self:Refresh()
		return self.psHeight
	end
	return s
end

-- tab: "rare" | "transport" | "whilehere" | "headsup" | "classcard"
function TS.Preview(view, tab)
	if tab == "classcard" then return classCardStage(view) end
	return toastStage(view, tab)
end

---------------------------------------------------------------------------
-- The options page
---------------------------------------------------------------------------

if not ns.RegisterOptions then return end

local PAGE = L["Alerts & toasts"]
local function pct(v) return floor(v * 100 + 0.5) .. "%" end
local function secs(v) return format(L["%d s"], floor(v + 0.5)) end
local function px(v) return format(L["%d px"], floor(v + 0.5)) end

local function register(spec)
	spec.page, spec.key, spec.icon, spec.order, spec.group = PAGE, "alerts", "info", 26, "look"
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

-- The card every toast has, in its anatomy's order: size and opacity, its
-- ground and border (each with its colour), its type, its entrance. The
-- class quest card, inside the guide window, has its type alone, in its own
-- section (TS.TextRows).
local function textRows(k, what)
	return {
		{ kind = "slider", key = k .. "titleSize", label = L["Title size"], min = 0.7, max = 1.6, step = 0.05, format = pct, new = NEW,
			help = L["The size of its title against Polestar's text size."],
			search = "font size, title, heading, bigger text, smaller text, readability, " .. what },
		{ kind = "slider", key = k .. "bodySize", label = L["Text size"], min = 0.7, max = 1.6, step = 0.05, format = pct, new = NEW,
			help = L["The size of its other lines against Polestar's text size."],
			search = "font size, body, lines, bigger text, smaller text, readability, " .. what },
	}
end

local function cardSection(tab, kind, what, opts)
	opts = opts or {}
	local k = "toasts." .. kind .. "."
	local card = {}
	for _, c in ipairs(opts.lead or {}) do card[#card + 1] = c end
	for _, c in ipairs({
		{ kind = "slider", key = k .. "scale", label = L["Scale"], min = 0.5, max = 2, step = 0.05, format = pct, new = NEW,
			help = format(L["The whole %s, larger or smaller."], what) .. (opts.scaleNote or ""),
			search = "size, bigger, larger, smaller, scale, huge, tiny, zoom, " .. what },
		{ kind = "slider", key = k .. "alpha", label = L["Opacity"], min = 0.2, max = 1, step = 0.05, format = pct, new = NEW,
			help = format(L["How solid the %s is, text and all."], what),
			search = "opacity, transparency, alpha, see through, faint, fade, " .. what },
		{ kind = "slider", key = k .. "bgAlpha", label = L["Background"], min = 0, max = 1, step = 0.05, format = pct, new = NEW,
			help = L["Its background's opacity against every Polestar window's (Theme), and its own colour (the swatch). 0 leaves the text on the world."],
			search = "background, backing, ground, transparent, see through, opacity, colour, tint, " .. what,
			extras = {
				{ kind = "color", key = k .. "bg", label = L["Background colour"], new = NEW,
					help = L["Its own background colour; the theme's when reset."],
					search = "background colour, backing, ground, tint, " .. what,
					shown = function() return Theme.Color("bg") end, source = function() return L["Theme"] end },
			} },
		{ kind = "slider", key = k .. "borderSize", label = L["Border"], min = 0, max = 4, step = 1, new = NEW,
			format = function(v) return v < 0.5 and L["Theme"] or px(v) end,
			help = L["Its border's thickness in screen pixels (Theme: the windows' own), and its own colour (the swatch), shown even with the windows' border off."],
			search = "border, thickness, width, outline, edge, frame colour, " .. what,
			extras = {
				{ kind = "color", key = k .. "border", label = L["Border colour"], new = NEW,
					help = L["A border of its own colour, even with the windows' border off; the theme's when reset."],
					search = "border colour, outline, edge, frame colour, " .. what,
					shown = function() return Theme.Color("windowBorder") end, source = function() return L["Theme"] end },
			} },
	}) do card[#card + 1] = c end
	for _, c in ipairs(textRows(k, what)) do card[#card + 1] = c end
	card[#card + 1] = { kind = "dropdown", key = k .. "enter", label = L["Entrance"], new = NEW,
		help = L["How it comes in: slides into place as it fades in, only fades in, or simply appears. Reduce motion (Theme) keeps slides to a fade."],
		search = "animation, slide, fade, pop, motion, appear, entrance, " .. what,
		choices = { { value = "slide", label = L["Slide in"] }, { value = "fade", label = L["Fade in"] }, { value = "none", label = L["Appear"] } } }
	card[#card + 1] = { kind = "slider", key = k .. "speed", label = L["Speed"], min = 0.25, max = 3, step = 0.25, format = pct, new = NEW,
		help = L["How fast it comes in and goes, against Polestar's own pace."],
		search = "animation speed, slow, fast, quick, motion, " .. what,
		disabled = function() return TS.Get(kind, "enter") == "none" end }
	for _, c in ipairs(opts.tail or {}) do card[#card + 1] = c end
	register({ tab = tab, section = L["Card"], preview = opts.preview, controls = card })
end

local function raresOff() return not (ns.Get("rares.enabled") and ns.Get("rares.alerts")) end
local function rareSounds()
	local out = {}
	for i, s in ipairs(ns.Rares and ns.Rares.SOUNDS or {}) do out[i] = { value = s.value, label = s.label } end
	return out
end
local function rares() return ns.Rares end

-- Rare alert: when it comes, its card, then the line the alerts may share.
local RARE = L["Rare alert"]
register({ tab = RARE, section = L["Rare alert"], preview = function(view) return TS.Preview(view, "rare") end,
	subtitle = L["The rare alert, the transport banner, While you're here, the heads-up card and the class quest card: their size, look, motion, sound and time on screen."],
	toggle = { kind = "toggle", key = "rares.alerts", label = L["Alert for rares"], needs = rares,
		search = "rare alert, rare spawn, notification, warning, popup",
		help = L["A card with its name, level and distance, and a waypoint to it."] },
	controls = {
		{ kind = "slider", key = "rares.toastSeconds", label = L["Stays for"], min = 5, max = 60, step = 1, format = secs, disabled = raresOff, needs = rares,
			search = "duration, how long, seconds, time on screen, stays, timeout",
			help = L["How long the alert stays. Hovering it holds it."] },
		{ kind = "toggle", key = "rares.treasureAlerts", label = L["Treasures"], disabled = raresOff, needs = rares,
			search = "treasure, chest, alert",
			help = L["Also for treasures the client marks on the minimap."] },
		{ kind = "dropdown", key = "rares.soundKit", label = L["Sound"], choices = rareSounds, needs = rares,
			disabled = function() return raresOff() or not ns.Get("rares.sound") end,
			search = "sound, audio, chime, ding, alert sound, which sound",
			help = L["The sound with each alert, through the Master channel; the switch turns it off."],
			extras = {
				{ kind = "toggle", key = "rares.sound", label = L["Play a sound"], disabled = raresOff,
					search = "sound, audio, chime, ding, alert sound", help = L["One sound with each alert."] },
			} },
		{ kind = "toggle", key = "rares.combatAlerts", label = L["Alert in combat"], disabled = raresOff, needs = rares,
			search = "combat, fight, in combat, visibility",
			help = L["Alert during combat. Off: an alert waits for the fight to end, if the rare was seen in the last minute."] },
	} })
-- Where it goes: lined up with the banner and While you're here (the line's
-- details behind the cog; they only matter with it on), and the movers.
cardSection(RARE, "rare", L["rare alert"], { tail = {
	{ kind = "toggle", key = "toasts.stack", label = L["Line up alerts"], new = NEW, info = true,
		help = L["The rare alert, the transport banner and While you're here line up one under the other from one place, instead of each at its own place where they can overlap. Which way they grow, the gap and how many: the cog."],
		search = "stack, stacking, line up, overlap, column, list, grow, anchor, position",
		more = {
			{ kind = "dropdown", key = "toasts.growth", label = L["New alerts go"], new = NEW,
				disabled = function() return not stackOn() end,
				help = L["Below: the line hangs from its top and grows down. Above: it stands on its bottom and grows up."],
				search = "growth, direction, grow up, grow down, stack direction",
				choices = { { value = "down", label = L["Below"] }, { value = "up", label = L["Above"] } } },
			{ kind = "slider", key = "toasts.spacing", label = L["Spacing"], min = 0, max = 40, step = 1, format = px, new = NEW,
				disabled = function() return not stackOn() end,
				help = L["The gap between two alerts in the line."],
				search = "spacing, gap, padding, distance, stack" },
			{ kind = "slider", key = "toasts.max", label = L["At most"], min = 1, max = 3, step = 1, format = "%d", new = NEW,
				disabled = function() return not stackOn() end,
				help = L["How many alerts the line shows at once; a new one sends the oldest away."],
				search = "maximum, max shown, how many, limit, stack" },
		} },
	{ kind = "button", button = L["Move"], label = L["Placement"], new = NEW,
		help = L["Move the alerts (or their line) on the screen in unlock mode, as /polestar unlock does."],
		search = "move, position, place, drag, unlock, anchor, alerts",
		needs = function() return ns.Movers and ns.Movers.Unlock end,
		onClick = function() ns.Movers.Unlock() end },
} })

-- Transport alert
local TRANSPORT = L["Transport alert"]
local function bannerOff() return not (ns.Get("nav.alerts") and ns.Get("nav.alertBanner")) end
register({ tab = TRANSPORT, section = L["Transport alert"], preview = function(view) return TS.Preview(view, "transport") end,
	toggle = { kind = "toggle", key = "nav.alerts", label = L["Transport alerts"],
		search = "boat, ship, zeppelin, tram, transport, departure, arrival, warning",
		help = L["Before your boat, zeppelin or tram comes in: 30 seconds ahead at the dock, 20 before the next stop on board. Never for lifts or in combat."] },
	controls = {
		{ kind = "toggle", key = "nav.alertBanner", label = L["Banner"],
			search = "banner, card, countdown, popup",
			help = L["A small card near the top of the screen with a countdown. Click it to dismiss."] },
		{ kind = "slider", key = "toasts.transport.linger", label = L["Stays after"], min = 0, max = 30, step = 1, format = secs, new = NEW, disabled = bannerOff,
			help = L["How long the banner stays once the boat, zeppelin or tram is in. Click it to dismiss it sooner."],
			search = "duration, how long, seconds, time on screen, linger, stays, banner" },
		{ kind = "toggle", key = "nav.alertSound", label = L["Sound"],
			search = "sound, audio, bell, horn",
			help = L["The ship's bell, the zeppelin's horn or the tram, on the Master channel so you hear it with the game in the background."] },
		{ kind = "toggle", key = "nav.alertFlash", label = L["Flash taskbar"],
			search = "flash, taskbar, background, alt tab",
			help = L["The game's icon flashes while the game is in the background."] },
	} })
cardSection(TRANSPORT, "transport", L["transport banner"])

-- While you're here: the toast of Dynamic Questing (Guide > Window), which
-- this page only shows or hides.
local HERE = L["While you're here"]
register({ tab = HERE, section = L["While you're here"], preview = function(view) return TS.Preview(view, "whilehere") end, controls = {
	{ kind = "toggle", key = "behavior.whileHere", label = L["While you're here"],
		search = "while you're here, nearby objective, dynamic questing, suggestion",
		help = L["Dynamic Questing (Guide, Window): objectives from later steps when you are near them. With the guide window hidden, each new one comes as this toast."] },
	{ kind = "slider", key = "toasts.whilehere.seconds", label = L["Stays for"], min = 3, max = 30, step = 1, format = secs, new = NEW,
		help = L["How long the toast stays while the guide window is hidden. Hovering it holds it."],
		search = "duration, how long, seconds, time on screen, stays, timeout, while you're here, dynamic questing" },
	{ kind = "toggle", key = "behavior.whileHereSound", label = L["Chime"],
		help = L["A soft chime for each new suggestion (once when several come together), at the game's sound effects volume."],
		search = "chime, sound, audio, ding, alert" },
	{ kind = "color", key = "toasts.whilehere.accent", label = L["Accent"], new = NEW,
		help = L["The toast's edge, glyph and heading; the accent when reset."],
		search = "accent, colour, highlight, edge, while you're here toast",
		shown = function() return Theme.Accent() end, source = function() return L["Accent"] end },
} })
cardSection(HERE, "whilehere", L["While you're here toast"])

-- Heads-up card
local HEADS = L["Heads-up card"]
cardSection(HEADS, "headsup", L["heads-up card"], { scaleNote = " " .. L["It sits on the guide window, at the window's scale times this."],
	preview = function(view) return TS.Preview(view, "headsup") end, lead = {
	{ kind = "slider", key = "toasts.headsup.seconds", label = L["Goes after"], min = 0, max = 120, step = 5, new = NEW,
		format = function(v) return v < 1 and L["Never"] or secs(v) end,
		help = L["The card for a class quest or a dungeon that opened up stays on the guide window until you answer it; set a time and it goes by itself, as Later does."],
		search = "duration, how long, seconds, dismiss, timeout, class quest, dungeon, heads up" },
	{ kind = "toggle", key = "dungeons.headsUp", label = L["Dungeons"],
		help = L["A card on the guide window when a dungeon's quests open to you."],
		search = "dungeon, heads up, notification, card", disabled = function() return not ns.Get("dungeons.enabled") end },
	{ kind = "dropdown", key = "toasts.headsup.place", label = L["Place"], new = NEW,
		help = L["Where the card goes: on the guide window's top edge (under the window when the screen has no room above), under its bottom edge (over it when there is no room below), or on a spot of its own that you move with Move frames."],
		search = "position, place, where, above, below, under, over the tracker, detach, detached, own spot, move, heads up, card, class quest, dungeon, suggestion",
		choices = { { value = "above", label = L["Above the window"] }, { value = "below", label = L["Below the window"] },
			{ value = "free", label = L["Its own spot"] } } },
	{ kind = "toggle", key = "toasts.headsup.compact", label = L["Compact"], new = NEW,
		help = L["One line: its icon, its title and its button. Hover it for the rest; its other choices are in its menu."],
		search = "compact, small, smaller, slim, one line, minimal, heads up, card, class quest, dungeon, suggestion" },
	{ kind = "button", button = L["Move"], label = L["Its spot"], new = NEW,
		help = L["Move the card in unlock mode, as /polestar unlock does. With Place on Its own spot."],
		search = "move, position, drag, unlock, own spot, heads up, card",
		disabled = function() return TS.Get("headsup", "place") ~= "free" end,
		needs = function() return ns.Movers and ns.Movers.Unlock end,
		onClick = function() ns.Movers.Unlock("headsUp") end },
} })

-- Class quest card (in the guide window: its scale, ground and opacity are the window's)
local CARD = L["Class quest card"]
local card = {
	{ kind = "slider", key = "toasts.classcard.glow", label = L["Glow"], min = 0, max = 2, step = 0.1, format = pct, new = NEW,
		help = L["The class colour's soft glow across the card."],
		search = "glow, class colour, brightness, highlight, class quest card" },
	{ kind = "slider", key = "toasts.classcard.stripe", label = L["Stripe"], min = 0, max = 10, step = 1, new = NEW,
		format = function(v) return v < 0.5 and L["Off"] or px(v) end,
		help = L["The class colour's stripe down its left edge."],
		search = "stripe, edge, bar, class colour, thickness, class quest card" },
}
for _, c in ipairs(textRows("toasts.classcard.", L["class quest card"])) do card[#card + 1] = c end
for _, c in ipairs({
	{ kind = "toggle", key = "toasts.classcard.shine", label = L["Shine"], new = NEW,
		help = L["A band of light crosses the card the first time a chain's card shows."],
		search = "shine, animation, flash, sparkle, motion, class quest card" },
	{ kind = "toggle", key = "toasts.classcard.note", label = L["Note"], new = NEW,
		help = L["The line under the trip: only you see the card, and the guide carries the quest."],
		search = "note, only you see this, text, line, hint, class quest card" },
	{ kind = "toggle", key = "ui.classCardSound", label = L["Chime"],
		disabled = function() return not (UI.ClassCard and UI.ClassCard.GameSoundOn()) end,
		search = "sound, chime, audio, class quest, heads up",
		help = L["A short chime the first time a class quest chain's card or heads-up shows. Off while the game's sound effects are off."] },
}) do card[#card + 1] = c end
register({ tab = CARD, section = L["Card"], preview = function(view) return TS.Preview(view, "classcard") end, controls = card })
