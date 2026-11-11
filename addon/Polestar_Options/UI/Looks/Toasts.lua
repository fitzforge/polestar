-- Alerts & toasts: the options page for how each of Polestar's toasts looks
-- and moves (Options > Look > Alerts & toasts, key `alerts`), and its pinned
-- previews. The toasts' look itself is core (Polestar/UI/Toasts.lua,
-- UI.Toasts); this file is part of the settings window's addon.
--
--   UI.Toasts.Preview(view, tab)           the options' pinned preview (sandbox toasts at
--                                          their true size; "all": every one, Essentials)
--   UI.Toasts.NewStage(view[, height])     a preview's stage (the trackers' too)
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

-- A stage `height` tall (STAGE_H by default) until the window lays it out
-- for its hero. The settings window's preview stage (UI.Preview.Stage): the
-- toasts over the world they show in, the zone you stand in. Its caption:
-- how much it had to shrink them to fit, or why it is empty.
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

TS.NewStage = newStage
TS.STAGE_H = STAGE_H

-- A sandbox toast of `kind` built into parent and painted, as the previews
-- draw it (the Theme page's scene has two); nil when its module is not
-- loaded. TS.Refill: its paint again after a change of type size.
function TS.Sandbox(kind, parent) return BUILD[kind] and BUILD[kind](parent) end
function TS.Refill(kind, card)
	local fill = REFILL[kind]
	if fill then fill(card) end
end

-- A toast as one of stage s's surfaces (s:SideBySide): at its true size (its
-- Scale on the game's UI scale), its place its entrance's (Anim.Anchor).
local function cardItem(s, kind, card, caption)
	local k0 = TS.Scale(kind) * s:TrueScale()
	return { w = card:GetWidth() * k0, h = card:GetHeight() * k0, foot = card, caption = caption,
		place = function(k, left, top)
			local g = k0 * k
			card:SetScale(g)
			Anim.Anchor(card, "TOPLEFT", s, "TOPLEFT", left / g, -top / g)
		end }
end

-- What lights each toast with a setting's row: its whole card (scale,
-- opacity, ground, border, when and how long it shows), its lines (type),
-- Play (its sound, and the entrance Play runs again).
local CARD_KEYS = { "scale", "alpha", "bgAlpha", "bg", "borderSize", "border", "enter", "speed" }
local OWN_KEYS = {
	rare = { card = { "rares.alerts", "rares.toastSeconds", "rares.treasureAlerts", "rares.combatAlerts",
		"toasts.stack", "toasts.growth", "toasts.spacing", "toasts.max" }, play = { "rares.soundKit", "rares.sound" } },
	transport = { card = { "nav.alerts", "nav.alertBanner", "toasts.transport.linger" }, play = { "nav.alertSound", "nav.alertFlash" } },
	whilehere = { card = { "behavior.whileHere", "toasts.whilehere.seconds", "toasts.whilehere.accent" }, play = { "behavior.whileHereSound" } },
	headsup = { card = { "dungeons.headsUp", "toasts.headsup.seconds", "toasts.headsup.place", "toasts.headsup.compact", "ui.classCardSound" } },
}

local function lightCard(s, kind, card, play)
	local t, k = card.psToast, "toasts." .. kind .. "."
	for _, key in ipairs(CARD_KEYS) do s:Light(k .. key, card) end
	s:Light(k .. "titleSize", unpack(#t.titles > 0 and t.titles or { card }))
	s:Light(k .. "bodySize", unpack(#t.bodies > 0 and t.bodies or { card }))
	local own = OWN_KEYS[kind] or {}
	for _, key in ipairs(own.card or {}) do s:Light(key, card) end
	for _, key in ipairs(own.play or {}) do s:Light(key, play or card) end
	if play then
		s:Light(k .. "enter", play)
		s:Light(k .. "speed", play)
	end
end

local function emptyStage(s)
	s.psNote = L["Not loaded"]
	function s:Refresh() end
	function s:Layout(width, height)
		self:SetWidth(width)
		self.psWidth, self.psHeight = width, height or self.psHeight
		return self.psHeight
	end
	return s
end

-- One toast kind's stage: its sandbox toast at its true size on a soft
-- shadow, Play (the entrance again, and the sound when it is on). The
-- single alerts stand in the world they come up in (SCENE): the card at the
-- top of the screen, where the game shows it; under it the arrow toward
-- what it is about; the guide window at the screen's right, its edge in the
-- hero, running on past it (none for While you're here, which comes as a
-- toast while the window is hidden); the mobs it names, in the world
-- (UI.Preview.Mob). A page too narrow or too low for a part leaves it out.
local HEIGHT = { rare = 190, transport = 150, whilehere = 140, headsup = 210 }
local PLAY_ROOM = 40 -- Play's line at the stage's foot
local SCENE = {
	rare = { guide = true, arrow = { 1.35, 85, L["Thuros Lightfingers"] }, left = L["Thuros Lightfingers"] },
	transport = { guide = true, arrow = { 0.3, 240, L["Menethil Harbor"] } },
	whilehere = { pair = L["Kobold Vermin"] },
}
-- The guide window's edge in the hero (px at true size), the room either
-- side of its box for its shadow, the gaps between the parts.
local GUIDE_SHOW, SHADOW_ROOM, GAP, ARROW_GAP = 210, 40, 36, 12

-- The scene's parts on stage s: the guide window, the arrow, the mobs.
local function buildWorld(s, kind)
	local sc, P = SCENE[kind], UI.Preview
	local w = { sc = sc }
	local lv = ns.Levels and ns.Levels.Player and ns.Levels.Player() or {}
	lv = max(1, lv.level or 18)
	if sc.guide and UI.GuideWindowScene then w.G = UI.GuideWindowScene(s) end
	local A = ns.Nav and ns.Nav.arrow
	if sc.arrow and A and A.BuildDial then
		local holder = CreateFrame("Frame", nil, s)
		holder:SetSize(A.WIDTH, A.HEIGHT)
		w.A, w.arrow = A, { holder = holder, dial = A.BuildDial(holder), look = {} }
		s.psWatch = { "nav.arrow" }
	end
	if sc.left then
		w.left = P.Mob(s, { name = sc.left, level = lv, health = 1, ring = { Theme.Color("rare") } })
		s:Light("rares.alerts", w.left)
	end
	if sc.pair then
		w.pair = { P.Mob(s, { name = sc.pair, level = max(1, lv - 2), health = 0.7, target = true }),
			P.Mob(s, { name = sc.pair, level = max(1, lv - 2), health = 1 }) }
		s:Light("behavior.whileHere", unpack(w.pair))
	end
	return w
end

-- The scene laid out across stage s (its psWidth x psHeight): the card at
-- the top of the room left of the guide window's edge, at its true size
-- (smaller only where it would not fit, and the caption says so).
local function layWorld(s, kind, card, w)
	local width, height, t, snap = s.psWidth, s.psHeight, s:TrueScale(), UI.Preview.Snap
	local top, bottom, pad = UI.Preview.CHROME + 6, PLAY_ROOM, 28
	local k0 = TS.Scale(kind) * t
	local cw, ch = card:GetWidth() * k0, card:GetHeight() * k0
	-- The guide window's edge at the right, while the room left of it holds
	-- the card.
	local G = w.G
	local edge = G and GUIDE_SHOW * t or 0
	if G and width - 2 * pad - edge - GAP < cw then edge = 0 end
	if G then G:SetShown(edge > 0) end
	s:SetCutRight(edge > 0)
	local roomR = width - pad - (edge > 0 and edge + GAP or 0)
	-- A mob at the left, while the room beside the card holds it.
	local mobW = w.left and 2 * w.left.HALF * t or 0
	if w.left and roomR - pad - mobW - GAP < cw then mobW = 0 end
	if w.left then w.left:SetShown(mobW > 0) end
	local roomL = pad + (mobW > 0 and mobW + GAP or 0)
	local k = min(1, (roomR - roomL) / max(1, cw), (height - top - bottom) / max(1, ch))
	local g = k0 * k
	local cx = (roomL + roomR) / 2
	card:SetScale(g)
	Anim.Anchor(card, "TOPLEFT", s, "TOPLEFT", snap(card, (cx - cw * k / 2) / g), snap(card, -top / g))
	s:Floor(card)
	s.psNote = k < 0.995 and format(L["Shown at %d%% to fit"], floor(k * 100 + 0.5)) or ""
	local below = top + ch * k + ARROW_GAP
	-- The arrow under the card, at its true size while the room holds it.
	local ar, A = w.arrow, w.A
	if ar then
		local ak = t * min(1, (height - bottom - below) / A.HEIGHT)
		ar.holder:SetShown(ak >= t * 0.6)
		if ak >= t * 0.6 then
			local a = w.sc.arrow
			A.ReadLook(ar.look)
			A.PaintDial(ar.dial, ar.look, A.StyleFor(ns.Get("nav.arrowStyle")), "travel", a[1], a[2], a[3], 40)
			ar.holder:SetScale(ak)
			ar.holder:ClearAllPoints()
			ar.holder:SetPoint("TOP", s, "TOPLEFT", snap(ar.holder, cx / ak), snap(ar.holder, -below / ak))
			s:Floor(ar.holder, -floor(max(0, A.WIDTH * ak - 150) / 2))
		end
	end
	-- The rare in the world at the left, level with the arrow's middle (it
	-- points there); While you're here's pair either side under the toast.
	if w.left and mobW > 0 then
		w.left:Tint(Theme.Color("rare"))
		w.left:Stand(pad + mobW / 2, min(height - bottom - 4, below + (w.left.UP + 10) * t), t)
	end
	if w.pair then
		-- Your target near, lower left; another further off, right and higher.
		local foot = height - bottom - 4
		local near, far = w.pair[1], w.pair[2]
		local show = foot - below >= near.UP * t
		near:SetShown(show)
		far:SetShown(show)
		if show then
			near:Stand(cx - cw * k / 2 + 40 * t, min(foot, below + (near.UP + 60) * t), t)
			far:Stand(cx + cw * k / 2 - 10 * t, min(foot - 24 * t, below + (far.UP * 0.85 + 12) * t), t * 0.85)
		end
	end
	if G and edge > 0 then
		local scale = (tonumber(ns.Get("ui.scale")) or 1) * t
		local winW = 340 * scale
		G:Layout(winW + 2 * SHADOW_ROOM, height)
		winW = G.Window:GetWidth() * scale
		local gtop = top + 18
		G:ClearAllPoints()
		G:SetPoint("TOPLEFT", s, "TOPLEFT", snap(s, width - edge - SHADOW_ROOM), -snap(s, gtop))
		G:SetSize(winW + 2 * SHADOW_ROOM, max(1, height - gtop))
		G:Layout(winW + 2 * SHADOW_ROOM, max(1, height - gtop))
	end
end

local function toastStage(view, kind)
	local s = newStage(view, HEIGHT[kind])
	local card = BUILD[kind](s)
	s.Card = card
	if not card then return emptyStage(s) end
	card:Show()
	card:SetAlpha(TS.Alpha(kind))
	local world = SCENE[kind] and buildWorld(s, kind)
	s.World = world
	-- The card finds its look's rows; its title and other lines their sizes.
	local t, k = card.psToast, "toasts." .. kind .. "."
	s:Hot(card, k .. "scale")
	s:Hot(t.titles[1], k .. "titleSize")
	s:Hot(t.bodies[1], k .. "bodySize")
	function s:Refresh()
		local fill = REFILL[kind]
		TS.ApplyLook(card, true)
		if fill then fill(card) end
		if world then
			layWorld(self, kind, card, world)
		else
			self:SideBySide({ cardItem(self, kind, card) }, { bottom = PLAY_ROOM })
		end
		if not Anim.IsRunning(card, "alpha") then card:SetAlpha(TS.Alpha(kind)) end
	end
	s.Play = W.Button(s, L["Play"], function()
		TS.Enter(kind, card, kind == "headsup" and card:GetHeight() or 18, kind == "transport" and Anim.FAST or Anim.SLOW * 1.5)
		local play = SOUNDS[kind]
		if play then play() end
	end, { height = 22 })
	-- Bottom left in a scene (the guide window takes the right).
	if world then
		s.Play:SetPoint("BOTTOMLEFT", s, "BOTTOMLEFT", 12, 10)
	else
		s.Play:SetPoint("BOTTOMRIGHT", s, "BOTTOMRIGHT", -12, 10)
	end
	s.Play:SetFrameLevel(s:GetFrameLevel() + 30)
	lightCard(s, kind, card, s.Play)
	function s:Layout(width, height)
		self:SetWidth(width)
		self.psWidth, self.psHeight = width, height or HEIGHT[kind]
		self:Refresh()
		return self.psHeight
	end
	return s
end

-- The class quest card on a guide window's ground, as the guide window
-- draws it, at the window's scale.
local CARD_W = 360
local function classCardStage(view)
	local s = newStage(view)
	local CC = UI.ClassCard
	if not (CC and CC.NewCard) then return emptyStage(s) end
	local ground = CreateFrame("Frame", nil, s)
	ground.psGuide = true
	Theme.Skin(ground, "window")
	local card = CC.NewCard(ground)
	s.Card, s.Ground = card, ground
	local demo = demoClassCard()
	-- Its type sizes, as the guide window's card has them.
	TS.Attach("classcard", card, { titles = { card.Title }, bodies = { card.Head, card.Learn, card.Trip, card.Only }, inline = true, sandbox = true })
	s:Hot(card.Glow, "toasts.classcard.glow")
	s:Hot(card.Stripe, "toasts.classcard.stripe")
	s:Hot(card.Title, "toasts.classcard.titleSize")
	s:Hot(card.Trip, "toasts.classcard.bodySize")
	function s:Refresh()
		TS.ApplyLook(card)
		local h = CC.FillDemo(card, demo, CARD_W)
		ground:SetSize(CARD_W, h)
		local k0 = (tonumber(ns.Get("ui.scale")) or 1) * self:TrueScale()
		self:SideBySide({ { w = CARD_W * k0, h = h * k0, foot = ground,
			place = function(k, left, top)
				local g = k0 * k
				ground:SetScale(g)
				ground:ClearAllPoints()
				ground:SetPoint("TOPLEFT", self, "TOPLEFT", left / g, -top / g)
			end } }, { bottom = PLAY_ROOM })
	end
	s.Play = W.Button(s, L["Play"], function()
		if CC.Shine then CC.Shine(card) end
		classChime()
	end, { height = 22 })
	s.Play:SetPoint("BOTTOMRIGHT", s, "BOTTOMRIGHT", -12, 10)
	s:Light("toasts.classcard.glow", card)
	s:Light("toasts.classcard.stripe", card.Stripe)
	s:Light("toasts.classcard.titleSize", card.Title)
	s:Light("toasts.classcard.bodySize", card.Head, card.Learn, card.Trip, card.Only)
	s:Light("toasts.classcard.shine", card, s.Play)
	s:Light("toasts.classcard.note", card.Only)
	s:Light("ui.classCardSound", s.Play)
	function s:Layout(width, height)
		self:SetWidth(width)
		self.psWidth, self.psHeight = width, height or STAGE_H
		self:Refresh()
		return self.psHeight
	end
	return s
end

-- Essentials: every alert and card side by side, each with its name, the
-- rare alert, the transport banner and While you're here in one column
-- while alerts line up (toasts.stack: its growth and spacing).
local KINDS = { "rare", "transport", "whilehere", "headsup" }
local NAMES = { rare = L["Rare alert"], transport = L["Transport alert"], whilehere = L["While you're here"], headsup = L["Heads-up card"] }
local LINED = { rare = true, transport = true, whilehere = true }

local function allStage(view)
	local s = newStage(view)
	local cards, caps = {}, {}
	for _, kind in ipairs(KINDS) do
		local card = BUILD[kind](s)
		if card then
			card:Show()
			cards[kind] = card
			caps[kind] = W.Text(s, "small", "textMuted")
			caps[kind]:SetJustifyH("CENTER")
			caps[kind]:SetText(NAMES[kind])
			lightCard(s, kind, card)
		end
	end
	s.Cards = {}
	for _, kind in ipairs(KINDS) do s.Cards[#s.Cards + 1] = cards[kind] end
	s.Lined = W.Text(s, "small", "textMuted")
	s.Lined:SetJustifyH("CENTER")
	s.Lined:SetText(L["Line up alerts"])
	function s:Refresh()
		local items, column = {}, {}
		local lined = stackOn()
		for _, kind in ipairs(KINDS) do
			local card = cards[kind]
			if card then
				local fill = REFILL[kind]
				TS.ApplyLook(card, true)
				if fill then fill(card) end
				card:SetAlpha(TS.Alpha(kind))
				caps[kind]:SetShown(not (lined and LINED[kind]))
				local it = cardItem(self, kind, card, caps[kind])
				if lined and LINED[kind] then column[#column + 1] = it else items[#items + 1] = it end
			end
		end
		if #column > 0 then
			-- One column, newest at the top or the bottom as they grow, the
			-- line's own spacing between them; its shadow under the lowest.
			local gap = tonumber(ns.Get("toasts.spacing")) or 8
			if ns.Get("toasts.growth") == "up" then
				local rev = {}
				for i = #column, 1, -1 do rev[#rev + 1] = column[i] end
				column = rev
			end
			local w, h = 0, 0
			for i, it in ipairs(column) do
				w, h = max(w, it.w), h + it.h + (i > 1 and gap or 0)
			end
			table.insert(items, 1, { w = w, h = h, foot = column[#column].foot, caption = self.Lined,
				place = function(k, left, top)
					local y = top
					for _, it in ipairs(column) do
						it.place(k, left + (w - it.w) * k / 2, y)
						y = y + (it.h + gap) * k
					end
				end })
		end
		self.Lined:SetShown(#column > 0)
		self:SideBySide(items, { gap = 32 })
	end
	function s:Layout(width, height)
		self:SetWidth(width)
		self.psWidth, self.psHeight = width, height or STAGE_H
		self:Refresh()
		return self.psHeight
	end
	return s
end

-- tab: "rare" | "transport" | "whilehere" | "headsup" | "classcard" | "all"
function TS.Preview(view, tab)
	if tab == "classcard" then return classCardStage(view) end
	if tab == "all" then return allStage(view) end
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

---------------------------------------------------------------------------
-- Essentials (the page's lead tab): four ways the alerts can be, as picture
-- cards, then the ten settings players change most, each a reference to its
-- row on the alerts' own tabs.
---------------------------------------------------------------------------

local O = UI.Options
if O and O.PresetCards and O.Ref then
	local R = O.Ref
	local KINDS4 = { "rare", "transport", "whilehere", "headsup" }
	-- A preset's card: the rare alert as the preset paints it (its own card
	-- code, Rares' NewCard and TS.ApplyLook, at a share of its scale so a
	-- bigger one shows bigger), the transport banner under it while alerts
	-- line up, and a Silent chip while no alert makes a sound.
	local function drawAlertCard(art, _, values)
		local cw, ch = art:GetWidth(), art:GetHeight()
		if not (cw and cw > 0) then cw = W.CARD_W - 2 end
		if not (ch and ch > 0) then ch = W.CARD_ART end
		if art.psBuilt == nil then
			W.Fill(art, "scrim", "BACKGROUND", -6)
			art.psRare, art.psBoat = BUILD.rare(art), BUILD.transport(art)
			art.psSilent = W.Chip(art)
			W.SetChip(art.psSilent, L["Silent"], "muted")
			art.psBuilt = true
		end
		local rare, boat = art.psRare, art.psBoat
		O.WithSettings(values, function()
			local lined = ns.Get("toasts.stack") and true or false
			local silent = not (ns.Get("rares.sound") or ns.Get("nav.alertSound") or ns.Get("behavior.whileHereSound"))
			art.psSilent:ClearAllPoints()
			art.psSilent:SetPoint("BOTTOMRIGHT", art, "BOTTOMRIGHT", -6, 6)
			art.psSilent:SetShown(silent)
			local list = { rare }
			if lined and boat then list[2] = boat end
			if boat then boat:SetShown(lined) end
			local gap = (tonumber(ns.Get("toasts.spacing")) or 8)
			local total, sizes = 0, {}
			for i, c in ipairs(list) do
				if c then
					TS.ApplyLook(c, true)
					local kind = i == 1 and "rare" or "transport"
					local k = 0.34 * TS.Scale(kind)
					sizes[i] = { k, c:GetWidth() * k, c:GetHeight() * k }
					total = total + sizes[i][3] + (i > 1 and gap * 0.34 or 0)
				end
			end
			-- Fitted to the card when the column would not fit.
			local fit = 1
			for _, s in pairs(sizes) do fit = min(fit, (cw - 12) / max(1, s[2])) end
			fit = min(fit, (ch - 10) / max(1, total))
			local y = (ch - total * fit) / 2
			for i, c in ipairs(list) do
				if c and sizes[i] then
					local s = sizes[i]
					c:SetScale(max(0.05, s[1] * fit))
					c:SetAlpha(TS.Alpha(i == 1 and "rare" or "transport"))
					c:ClearAllPoints()
					c:SetPoint("TOP", art, "TOP", 0, -(y / (s[1] * fit)))
					c:Show()
					y = y + s[3] * fit + gap * 0.34 * fit
				end
			end
		end)
	end
	local quiet = { ["rares.sound"] = false, ["nav.alertSound"] = false, ["nav.alertFlash"] = false, ["behavior.whileHereSound"] = false,
		["ui.classCardSound"] = false }
	local large = {}
	for _, k in ipairs(KINDS4) do
		quiet["toasts." .. k .. ".enter"] = "fade"
		large["toasts." .. k .. ".scale"], large["toasts." .. k .. ".titleSize"], large["toasts." .. k .. ".bodySize"] = 1.25, 1.15, 1.15
	end
	local PRESETS = {
		{ value = "polestar", label = L["Polestar"], set = {}, draw = drawAlertCard },
		{ value = "quiet", label = L["Quiet"], set = quiet, draw = drawAlertCard,
			help = L["No sounds and no taskbar flash; the alerts fade in instead of sliding."] },
		{ value = "large", label = L["Large"], set = large, draw = drawAlertCard,
			help = L["Every alert and card bigger, its text with it."] },
		{ value = "lined", label = L["Lined up"], set = { ["toasts.stack"] = true }, draw = drawAlertCard,
			help = L["The rare alert, the transport banner and While you're here line up one under the other."] },
	}
	local ESSENTIALS = L["Essentials"]
	register({ tab = ESSENTIALS, lead = true, section = L["Presets"], preview = function(view) return TS.Preview(view, "all") end,
		controls = { O.PresetCards({ presets = PRESETS }) } })
	register({ tab = ESSENTIALS, section = L["Alerts"], jump = { tab = RARE, section = L["Rare alert"] }, controls = {
		R("toggle", "rares.alerts", { label = L["Rares"] }), R("toggle", "nav.alerts", { label = L["Transport"] }),
		R("toggle", "behavior.whileHere"), R("toggle", "dungeons.headsUp"),
		R("toggle", "toasts.stack"), R("dropdown", "toasts.growth"),
	} })
	register({ tab = ESSENTIALS, section = L["Sound"], jump = { tab = RARE, section = L["Rare alert"] }, controls = {
		R("dropdown", "rares.soundKit"), R("toggle", "nav.alertSound", { label = L["Transport sound"] }),
		R("toggle", "behavior.whileHereSound", { label = L["Nearby chime"] }), R("toggle", "ui.classCardSound", { label = L["Class quest chime"] }),
	} })
end
