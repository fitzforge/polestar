-- Transport alerts: a heads-up before your boat, zeppelin or tram comes in,
-- for anyone waiting away from the keyboard.
--
-- Adapted from Shortest Path Forever by Cillian Berragan (GPL-3.0-or-later,
-- used with permission), UI/Alert.lua: the two moments (waiting at the dock,
-- AT_DOCK seconds before a timed arrival; riding, ON_BOARD seconds before the
-- next dock), the once-per-visit rule, no alerts for lifts or in combat, and
-- the sound each transport makes in the game itself, on the Master channel so
-- it is heard with the game in the background. Polestar shows its own banner
-- in place of the raid-warning text.
-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
--
-- Timings come from ns.Transit (Nav/Transit.lua):
--   ns.Transit.Now()                                  server seconds
--   ns.Transit.NextArrival(kind, id, now, side)       -> arriveIn, departIn, timed
--   ns.Transit.Riding(now)                            -> { kind, route, dock, arriveIn } | nil
-- Waiting means the route's current leg is a ride (leg.transport, leg.side)
-- and you stand within RADIUS yards of its dock (leg.from).
--
-- Each part has its own switch: nav.alerts (all), nav.alertBanner,
-- nav.alertSound, nav.alertFlash (the taskbar icon, FlashClientIcon).
-- Checked on Nav's once-a-second tick; nothing runs per frame except the
-- banner's countdown while it is shown.
-- The banner's size, opacity, type, ground, entrance, how long it stays
-- after the arrival and its place (toasts.transport.*) are the player's
-- (Options > Alerts & toasts, UI/Looks/Toasts.lua);
-- Alerts.NewBanner/FillBanner draw a sandbox one for its preview.

local ADDON, ns = ...
local Nav = ns.Nav
local L = ns.L

local type, floor, format, sqrt = type, math.floor, string.format, math.sqrt

local Alerts = {}
Nav.alerts = Alerts

ns.RegisterDefaults("nav", { alerts = true, alertBanner = true, alertSound = true, alertFlash = true })

local AT_DOCK = 30    -- seconds before a timed arrival, waiting at the dock
local ON_BOARD = 20   -- seconds before the next dock, riding
local WINDOW = 5      -- an alert is due for this long after its lead time
local RADIUS = 120    -- yards from the dock that count as waiting there
local REPEAT = 120    -- seconds before the same visit may alert again
local LINGER = 6      -- the banner stays this long after the arrival
Alerts.AT_DOCK, Alerts.ON_BOARD, Alerts.RADIUS = AT_DOCK, ON_BOARD, RADIUS

-- Lifts come round every few seconds, so they never alert.
local ARRIVES = {
	boat = L["Boat to %s"],
	zeppelin = L["Zeppelin to %s"],
	tram = L["Tram to %s"],
}
-- What the game plays for each (FileDataIDs, sound/doodad/): the bell a ship
-- rings as it docks (boatdockedwarning.ogg), the zeppelin's horn
-- (zeppelinhorn.ogg), the tram pulling in (subwaystop.ogg).
local SOUND = { boat = 566652, zeppelin = 566719, tram = 566056 }
Alerts.SOUND = SOUND

-- [route .. ":" .. dock] = GetTime() of its alert.
local alerted = {}

function Alerts.Due(seconds, lead)
	return type(seconds) == "number" and seconds <= lead and seconds > lead - WINDOW
end

function Alerts.Countdown(seconds)
	seconds = floor((seconds or 0) + 0.5)
	if seconds < 0 then seconds = 0 end
	return format("%d:%02d", floor(seconds / 60), seconds % 60)
end

---------------------------------------------------------------------------
-- The banner: a small window in the rare alert's chrome, centred near the
-- top: the gold rim (W.Rim) over a compact night band (the band, and in the
-- house style a scrim-to-ground gradient and the haze), the transport's glyph
-- in a ring, what is coming in Title and a live countdown in Small textDim,
-- a 2px accent line draining to the arrival. A click dismisses it.
--
-- Alerts.ShowNotice puts one of Polestar's own heads-ups in the same banner
-- (UI/GuideFrame.lua: the window hiding in an instance): the emblem in an
-- accent ring, a title, a fixed line in Small textDim that wraps to three
-- lines (the banner grows with it), the line draining over its time.
---------------------------------------------------------------------------

local WIDTH, HEIGHT, PAD = 320, 56, 16
local RING = 32
local TEXT_WIDTH = WIDTH - PAD - RING - 12 - PAD
local NOTICE_LINES = 3
local DEFAULT_Y = -72
local banner

-- The ring's glyph and colour: a transport's (icon-boat, place), or the
-- emblem in the accent, which wears its own colours.
local function paintRing(f)
	local Theme, W = ns.Theme, ns.Widgets
	local skin = Theme.SkinKey()
	local color = f.psNotice and "accent" or "place"
	f.Glyph:SetTexture(Theme.Media(f.psNotice and "logo" or "icon-boat"))
	f.Glyph:SetSize(f.psNotice and 20 or 16, f.psNotice and 20 or 16)
	if skin == "polestar" then
		f.Ring:SetTexture(Theme.Media("qol-ring"))
		f.Ring:SetSize(RING, RING)
		W.Color(f.Ring, color)
	else
		local size = skin == "halo" and 30 or RING
		f.Ring:SetTexture(Theme.Media("skin-ring"))
		f.Ring:SetSize(size * 60 / 48, size * 60 / 48)
		if skin == "halo" then W.Color(f.Ring, "accent") else W.Uncolor(f.Ring); f.Ring:SetVertexColor(0.78, 0.612, 0.243, 1) end
	end
	if f.psNotice then
		-- The emblem in its own colours: W.Uncolor only stops the theme following it.
		W.Uncolor(f.Glyph)
		f.Glyph:SetVertexColor(1, 1, 1, 1)
	else
		W.Color(f.Glyph, skin == "polestar" and "place" or "accent")
	end
end

-- One line (a countdown) or a notice's wrapping line; the banner grows by
-- the extra lines (and by a title the player made larger, Alerts & toasts)
-- and the text block stays centred on the ring.
local function layout(f)
	local wrap = f.psNotice and true or false
	f.When:SetWordWrap(wrap)
	f.When:SetMaxLines(wrap and NOTICE_LINES or 1)
	local extra = wrap and math.max(0, f.When:GetStringHeight() - f.When:GetLineHeight()) or 0
	extra = extra + math.max(0, f.Title:GetStringHeight() + f.When:GetLineHeight() + 28 - HEIGHT)
	local height = HEIGHT + extra
	f:SetHeight(height)
	f.Title:SetPoint("BOTTOMLEFT", f.Ring, "RIGHT", 12, 1 + extra / 2)
	f.When:SetPoint("TOPLEFT", f.Ring, "RIGHT", 12, -3 + extra / 2)
	f.Band:SetTexCoord(ns.Theme.BandCoords(WIDTH - 2, height - 2))
end

-- The look's settings (UI/Looks/Toasts.lua), when that file is loaded.
local function looks() return ns.UI and ns.UI.Toasts end

-- The banner's own place: toasts.transport.point (the movers), else centred
-- near the top; or its place in the line of alerts while they stack.
local function ownPlace()
	local p = ns.Get("toasts.transport.point")
	if type(p) ~= "table" or type(p[1]) ~= "string" then p = { "TOP", 0, DEFAULT_Y } end
	ns.Anim.Anchor(banner, p[1], UIParent, p[1], tonumber(p[2]) or 0, tonumber(p[3]) or 0)
end

local function place()
	local TS = looks()
	if TS and TS.Place("transport", banner, ownPlace) then return end
	ownPlace()
end

-- The banner, drawn into `parent`: the live one (build) or a sandbox one for
-- the options' preview (Alerts.NewBanner): no countdown of its own, and a
-- click does nothing.
local function newBanner(parent, name, sandbox)
	local Theme, W = ns.Theme, ns.Widgets
	local f = CreateFrame("Frame", name, parent)
	f:SetSize(WIDTH, HEIGHT)
	f:EnableMouse(true)
	-- A toast: the game's looks give it the guide window's light frame.
	f.psLight = true
	Theme.Skin(f, "window")

	-- The night band under everything the banner says.
	local head = CreateFrame("Frame", nil, f)
	head:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
	head:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
	f.Head = head
	f.Night = head:CreateTexture(nil, "BACKGROUND", nil, -8)
	f.Night:SetTexture(Theme.Media("white"))
	f.Night:SetAllPoints(head)
	W.Painter(f.Night, function(t)
		t:SetShown(Theme.SkinKey() == "polestar")
		local tr, tg, tb = Theme.Color("scrim")
		local br, bg, bb = Theme.Color("bg")
		if t.SetGradient and CreateColor then
			t:SetVertexColor(1, 1, 1, 1)
			t:SetGradient("VERTICAL", CreateColor(br, bg, bb, 1), CreateColor(tr, tg, tb, 1))
		else
			t:SetVertexColor(br, bg, bb, 1)
		end
	end)
	if W.Haze then f.Haze = W.Haze(head, { height = HEIGHT, sub = -6 }) end
	f.Band = Theme.Band(head, "BACKGROUND", -5)
	f.Band:SetAllPoints(head)
	f.Band:SetTexCoord(Theme.BandCoords(WIDTH - 2, HEIGHT - 2))

	f.Ring = W.Tex(head, "ARTWORK", "qol-ring", "place")
	f.Ring:SetSize(RING, RING)
	f.Ring:SetPoint("LEFT", f, "LEFT", PAD, 0)
	f.Glyph = W.Tex(head, "OVERLAY", "icon-boat", "place")
	f.Glyph:SetSize(16, 16)
	f.Glyph:SetPoint("CENTER", f.Ring, "CENTER", 0, 0)

	-- In the skins (DIRECTION_B_HALO.md §3, DIRECTION_A_BLIZZARD.md §5): Halo's
	-- 30-unit ring in the accent; Hearth's and the game's looks' 32-unit ring
	-- edged #C79C3E, their title in gold.
	W.Painter(f.Ring, function() paintRing(f) end)
	f.Title = W.Text(head, "title", "title")
	f.Title:SetPoint("BOTTOMLEFT", f.Ring, "RIGHT", 12, 1)
	f.Title:SetWidth(TEXT_WIDTH)
	f.Title:SetJustifyH("LEFT")
	f.Title:SetWordWrap(false)
	f.When = W.Text(head, "small", "textDim")
	f.When:SetPoint("TOPLEFT", f.Ring, "RIGHT", 12, -3)
	f.When:SetWidth(TEXT_WIDTH)
	f.When:SetJustifyH("LEFT")
	f.When:SetWordWrap(false)
	-- Text on the band: the deeper shade under it, as on the rare alert.
	for _, fs in ipairs({ f.Title, f.When }) do
		W.Painter(fs, function(t)
			local r, g, b = Theme.Color("shade")
			t:SetShadowOffset(0, -1)
			t:SetShadowColor(r, g, b, 0.85)
		end)
	end

	f.Timer = W.ProgressLine(head, 2)
	f.Timer:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)
	f.Timer:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
	-- The rim's light kept inside the banner.
	if W.Rim then W.Rim(f, { height = HEIGHT }) end
	local TS = looks()
	if TS then TS.Attach("transport", f, { titles = { f.Title }, bodies = { f.When }, sandbox = sandbox, relayout = layout }) end
	return f
end

-- A sandbox banner for the options' preview, and its paint: a transport's
-- countdown (notice false) or one of Polestar's notices, `frac` of its line
-- left.
function Alerts.NewBanner(parent) return newBanner(parent, nil, true) end
function Alerts.FillBanner(f, notice, title, line, frac)
	f.psNotice = notice and true or false
	f.Title:SetText(title)
	f.When:SetText(line)
	paintRing(f)
	layout(f)
	ns.Widgets.SetProgress(f.Timer, frac or 1, WIDTH - 2)
end

local function build()
	local W, Anim = ns.Widgets, ns.Anim
	local f = newBanner(UIParent, "PolestarAlert")
	f:SetFrameStrata("HIGH")
	f:SetClampedToScreen(true)
	f:SetScript("OnMouseUp", function(self) self:Hide() end)
	f:SetScript("OnUpdate", ns.Safe(function(self)
		local left = self.arriveAt - GetTime()
		if left <= -self.linger then
			self:Hide()
			return
		end
		if self.whenFormat then
			local shown = left > 0 and floor(left + 0.5) or 0
			if shown ~= self.lastShown then
				self.lastShown = shown
				self.When:SetText(left > 0 and format(self.whenFormat, Alerts.Countdown(left)) or L["Arriving now"])
			end
		end
		W.SetProgress(self.Timer, left > 0 and left / self.total or 0, WIDTH - 2)
	end))
	f:Hide()
	f.Anim = Anim
	banner = f
	Alerts.banner = f
end

local function present(notice, seconds)
	banner.psNotice = notice
	paintRing(banner)
	layout(banner)
	banner.total = seconds > 0 and seconds or 1
	banner.arriveAt = GetTime() + seconds
	banner.lastShown = nil
	local wasShown = banner:IsShown()
	place()
	banner:Show()
	if not wasShown then
		-- Its entrance, speed and opacity are the player's (Alerts & toasts); a fade by default.
		local TS = looks()
		if TS then
			TS.Enter("transport", banner, 12, banner.Anim.FAST)
		else
			banner.Anim.To(banner, "alpha", 0, 1, banner.Anim.FAST, "out")
		end
	end
end

-- How long the banner stays after the arrival (Alerts & toasts), else LINGER.
local function linger()
	local TS = looks()
	local v = TS and tonumber(TS.Get("transport", "linger"))
	return v and v >= 0 and v or LINGER
end

-- title: what is coming; whenFormat: "Arrives in %s" or the like.
local function showBanner(title, whenFormat, seconds)
	if not (ns.Theme and ns.Widgets and ns.Anim) then return end
	if not banner then build() end
	banner.Title:SetText(title)
	banner.whenFormat = whenFormat
	banner.linger = linger()
	banner.When:SetText(format(whenFormat, Alerts.Countdown(seconds)))
	present(false, seconds)
end
Alerts.ShowBanner = showBanner

-- One of Polestar's own heads-ups: title, a fixed line (wrapping), gone
-- after `seconds` or a click.
function Alerts.ShowNotice(title, line, seconds)
	if not (ns.Theme and ns.Widgets and ns.Anim) then return end
	if not banner then build() end
	banner.Title:SetText(title)
	banner.whenFormat = nil
	banner.linger = 0
	banner.When:SetText(line)
	present(true, seconds)
end

-- Takes a notice down (the window it pointed to is back); a transport's
-- countdown stays.
function Alerts.HideNotice()
	if banner and banner.psNotice and banner:IsShown() then banner:Hide() end
end

---------------------------------------------------------------------------
-- Checking
---------------------------------------------------------------------------

local function alert(key, kind, title, whenFormat, seconds)
	local now = GetTime()
	local last = alerted[key]
	if last and now - last < REPEAT then return false end
	alerted[key] = now
	if ns.Get("nav.alertBanner") then showBanner(title, whenFormat, seconds) end
	if ns.Get("nav.alertSound") and PlaySoundFile then PlaySoundFile(SOUND[kind], "Master") end
	if ns.Get("nav.alertFlash") and FlashClientIcon then FlashClientIcon() end
	ns.Fire("NAV_TRANSIT_ALERT", kind, title, seconds)
	return true
end

local function yards(c1, x1, y1, c2, x2, y2)
	if c1 ~= c2 then return math.huge end
	local dx, dy = x1 - x2, y1 - y2
	return sqrt(dx * dx + dy * dy)
end

local function rideLeg()
	if not Nav.GetRoute then return nil end
	local legs, ci = Nav.GetRoute()
	local leg = type(legs) == "table" and ci and legs[ci]
	if leg and ARRIVES[leg.kind] then return leg end
	return nil
end

-- One check; returns true when it alerted. Shortest Path Forever announces
-- its own rides while the target is handed to it (Nav/Handoff.lua).
function Alerts.Check()
	if not ns.Get("nav.alerts") or not ns.GuideShown() or Nav.HandedOff() then return false end
	if InCombatLockdown and InCombatLockdown() then return false end
	local X = ns.Transit
	if type(X) ~= "table" then return false end
	local now = X.Now and X.Now() or (GetServerTime and GetServerTime()) or 0

	local ride = X.Riding and X.Riding(now)
	if type(ride) == "table" then
		if ARRIVES[ride.kind] and ride.dock and Alerts.Due(ride.arriveIn, ON_BOARD) then
			return alert(tostring(ride.route) .. ":" .. ride.dock, ride.kind,
				format(L["Arriving at %s"], ride.dock), L["Docks in %s"], ride.arriveIn)
		end
		return false
	end

	local leg = rideLeg()
	if not (leg and leg.from and X.NextArrival) then return false end
	local C = ns.Compat
	local pc, px, py
	if C and C.GetPlayerWorldPosition then pc, px, py = C.GetPlayerWorldPosition() end
	local from = leg.from
	if not pc or yards(pc, px, py, from.c, from.wx, from.wy) > RADIUS then return false end
	local id = type(leg.transport) == "table" and leg.transport.id or leg.transport
	if not id then return false end
	local arriveIn, _, timed = X.NextArrival(leg.kind, id, now, leg.side)
	if timed == false or not arriveIn or arriveIn <= 0 or not Alerts.Due(arriveIn, AT_DOCK) then return false end
	local T = Nav.travel
	local to = leg.to and ((T and T.PlaceName and T.PlaceName(leg.to)) or leg.to.name) or ""
	return alert(tostring(id) .. ":" .. tostring(leg.side or from.name or "?"), leg.kind,
		format(ARRIVES[leg.kind], to), L["Arrives in %s"], arriveIn)
end

-- Nav's once-a-second tick.
function Alerts:Refresh() Alerts.Check() end
Nav.RegisterModule(Alerts)
ns.On("NAV_TRANSIT", function() Alerts.Check() end)
-- Moved from elsewhere (reset, the movers): the banner on screen follows.
ns.On("SETTING_CHANGED", function(path)
	if (path == "toasts.transport.point" or path == "toasts" or path == "") and banner and banner:IsShown() then place() end
end)

-- A sample, from the options page.
function Alerts.ShowSample()
	showBanner(format(ARRIVES.boat, L["Menethil Harbor"]), L["Arrives in %s"], AT_DOCK)
	if ns.Get("nav.alertSound") and PlaySoundFile then PlaySoundFile(SOUND.boat, "Master") end
end

---------------------------------------------------------------------------
-- Options: Guide > Arrow & routes > Along the route; the alerts' switch also
-- on Quality of Life > Travel > Along the route (one setting, a fresh control
-- per page: the registry keeps per-control state).
---------------------------------------------------------------------------

if ns.OnOptions then ns.OnOptions(function()
	local function off() return not ns.Get("nav.alerts") end
	local H = Nav.HandoffOption
	local function alerts()
		return H({ kind = "toggle", key = "nav.alerts", label = L["Transport alerts"],
			search = "boat, ship, zeppelin, tram, transport, departure, arrival, warning",
			help = L["Before your boat, zeppelin or tram comes in: 30 seconds ahead at the dock, 20 before the next stop on board. Never for lifts or in combat."] })
	end
	local ok, err = ns.RegisterOptions({
		page = L["Guide"], tab = L["Arrow & routes"], section = L["Along the route"],
		controls = {
			alerts(),
			H({ kind = "toggle", key = "nav.alertBanner", label = L["Show a banner"], disabled = off,
				help = L["A small card near the top of the screen with a countdown. Click it to dismiss."] }),
			H({ kind = "toggle", key = "nav.alertSound", label = L["Play the transport's sound"], disabled = off,
				help = L["The ship's bell, the zeppelin's horn or the tram, on the Master channel so you hear it with the game in the background."] }),
			H({ kind = "toggle", key = "nav.alertFlash", label = L["Flash the taskbar icon"], disabled = off,
				help = L["The game's icon flashes while the game is in the background."] }),
			{ kind = "button", button = L["Show"], label = L["Show a sample alert"], disabled = off,
				help = L["See the banner and hear the boat's bell."],
				onClick = function() Alerts.ShowSample() end },
		},
	})
	if not ok and geterrorhandler then geterrorhandler()(err) end
	ok, err = ns.RegisterOptions({ page = L["Quality of Life"], tab = L["Travel"], section = L["Along the route"], controls = { alerts() } })
	if not ok and geterrorhandler then geterrorhandler()(err) end
end) end
