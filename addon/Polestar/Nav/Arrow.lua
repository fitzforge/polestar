-- The waypoint arrow: turns smoothly toward the target, with distance, label
-- and ETA underneath. It shifts from its far colour to its near colour as
-- you close in and becomes a pulsing ring on arrival. On another continent
-- it shows the target's zone instead; where the client gives no player
-- position (the Deeprun Tram) it says so over the label, or keeps showing the
-- route's ride, until a position returns.
--
-- Colour comes from Theme through Nav.RGB / Nav.Wash (repainted in OnTheme):
-- the arrow in "arrow" far away and "arrowNear" up close and on arrival (the
-- accent and success unless the player picked their own, nav.arrowColor /
-- nav.arrowNearColor), text in those colours in their legible *Text forms;
-- the distance in text, the label in text, the ETA line 12px in text at 80%,
-- outlines and shadows in shade, the hover wash that says "movable" in the
-- ink "mover" wash. No colour literals.
--
-- Styles (nav.arrowStyle; "skin", the default, takes the skin's: 3D in the
-- house style, the Halo dart in Halo, the Hearth dart in Hearth and the
-- game's looks):
--   "3d"   a pre-rendered arrow lying on the ground in front of you: one
--          sprite-sheet frame per heading (tools/media/nav/arrow3d.js), the
--          body tinted with SetVertexColor and an untinted specular sheet
--          added on top; the heading picks the frame
--   "flat" a faceted dart rotated with SetRotation
--   "halo", "hearth"  the skins' darts (DIRECTION_B_HALO.md §3,
--          DIRECTION_A_BLIZZARD.md §5; tools/media/skins.js): a 54-unit dart
--          with a dark 2-unit edge, rotated; Halo's in the accent, Hearth's
--          gold gradient baked in; both turn to the arrival colour within
--          40 m. Arrival: a 48-unit ring (stroke 3), then a check (stroke 5).
--
-- Work happens only while shown: OnUpdate samples the world at 20 Hz and
-- damps the heading every frame, allocating nothing. Hidden states (no
-- target, taxi, instance) are re-checked by Nav's once-a-second ticker.

local ADDON, ns = ...
local Nav = ns.Nav
local L = ns.L

local exp, sin, abs, floor, min, max, pi = math.exp, math.sin, math.abs, math.floor, math.min, math.max, math.pi
local wrap = Nav.WrapAngle
local MEDIA = Nav.MEDIA

local SAMPLE_INTERVAL = 0.05 -- seconds between world samples
local DAMPING = 12           -- rotation stiffness (1/s); higher = snappier
local CLOSE_RANGE = 250      -- yards over which the colour shifts toward success
local DIAL = 64

-- Sprite sheet layout; must match tools/media/nav/arrow3d.js LAYOUT.
local FRAMES, COLS, CELL, SHEET = 100, 10, 102, 1024
local TWO_PI = 2 * pi
local STEP = TWO_PI / FRAMES
local SPRITE = DIAL * 1.5

ns.RegisterDefaults("nav", { arrowStyle = "skin" })

-- The style a skin's arrow takes ("skin" in nav.arrowStyle).
local SKIN_ARROW = { polestar = "3d", halo = "halo", hearth = "hearth", forever = "hearth", blizzard = "hearth", classic = "hearth" }
local DART = 54          -- the skins' dart, in the 64-unit dial
local DART_NEAR = 43.7   -- 40 m, in yards: the skins' darts turn to the arrival colour
local SKIN_RING = 48     -- the skins' arrival ring
-- The darts' dark edge: Halo #17130E (near #0B1A0C), Hearth #2A1A00.
local EDGE = { halo = { 0.09, 0.075, 0.055 }, haloNear = { 0.043, 0.102, 0.047 }, hearth = { 0.165, 0.102, 0 } }

-- Sheet frame for a heading (radians, counter-clockwise, 0 = straight ahead):
-- frame i shows the arrow turned i * 360 / FRAMES degrees.
function Nav.ArrowFrame(angle)
	return floor((angle % TWO_PI) / STEP + 0.5) % FRAMES
end

-- Texture coordinates of a frame: left, right, top, bottom.
function Nav.ArrowFrameCoords(index)
	local col = index % COLS
	local row = (index - col) / COLS
	return col * CELL / SHEET, (col + 1) * CELL / SHEET, row * CELL / SHEET, (row + 1) * CELL / SHEET
end

local WIDTH, TEXT_H = 200, 52 -- the frame: the dial, and the distance and label under it

local frame = CreateFrame("Frame", "PolestarNavArrow", UIParent)
frame:SetSize(WIDTH, DIAL + TEXT_H)
frame:SetFrameStrata("MEDIUM")
frame:SetClampedToScreen(true)
frame:SetMovable(true)
frame:EnableMouse(true) -- always movable: drag the arrow anywhere (Shift-drag with ui.lockHud on)
frame:RegisterForDrag("LeftButton")
frame:Hide()

local dial = CreateFrame("Frame", nil, frame)
dial:SetSize(DIAL, DIAL)
dial:SetPoint("TOP", frame, "TOP", 0, 0)

-- Shown behind the part that takes the mouse while hovering it, so it reads
-- as movable.
local mover = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
mover:SetColorTexture(Nav.Wash("mover"))
mover:Hide()

-- Only the dial takes the mouse: the text under it would otherwise catch
-- drags meant for the world, more so at a large scale. Without the dial
-- (another continent, no position) the text is all there is, so it does.
local function grabArea(onDial)
	local side = onDial and (WIDTH - DIAL) / 2 or 0
	frame:SetHitRectInsets(side, side, onDial and 0 or DIAL, onDial and TEXT_H or 0)
	mover:ClearAllPoints()
	if onDial then
		mover:SetAllPoints(dial)
	else
		mover:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -DIAL)
		mover:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
	end
end
grabArea(true)

local glow = dial:CreateTexture(nil, "BACKGROUND")
glow:SetTexture(MEDIA .. "arrow-glow")
glow:SetSize(DIAL * 1.25, DIAL * 1.25)
glow:SetPoint("CENTER")
glow:SetBlendMode("ADD")

local body = dial:CreateTexture(nil, "ARTWORK")
body:SetTexture(MEDIA .. "arrow")
body:SetAllPoints()

local facet = dial:CreateTexture(nil, "ARTWORK", nil, 1)
facet:SetTexture(MEDIA .. "arrow-facet")
facet:SetAllPoints()

local sheet = dial:CreateTexture(nil, "ARTWORK")
sheet:SetTexture(MEDIA .. "arrow3d")
sheet:SetSize(SPRITE, SPRITE)
sheet:SetPoint("CENTER")

local sheetSpec = dial:CreateTexture(nil, "ARTWORK", nil, 2)
sheetSpec:SetTexture(MEDIA .. "arrow3d-spec")
sheetSpec:SetSize(SPRITE, SPRITE)
sheetSpec:SetPoint("CENTER")
sheetSpec:SetBlendMode("ADD")

local halo = dial:CreateTexture(nil, "BACKGROUND")
halo:SetTexture(MEDIA .. "glow")
halo:SetSize(DIAL * 1.4, DIAL * 1.4)
halo:SetPoint("CENTER")
halo:SetBlendMode("ADD")

local ring = dial:CreateTexture(nil, "ARTWORK")
ring:SetTexture(MEDIA .. "arrived")
ring:SetSize(DIAL, DIAL)
ring:SetPoint("CENTER")

-- The skins' darts and arrival (Media/UI: dart, dart-edge, dart-gold,
-- skin-ring, skin-check, circle).
local UI_DIR = "Interface\\AddOns\\" .. ADDON .. "\\Media\\UI\\"
local dart = dial:CreateTexture(nil, "ARTWORK")
dart:SetTexture(UI_DIR .. "dart")
dart:SetSize(DART, DART)
dart:SetPoint("CENTER")
local dartEdge = dial:CreateTexture(nil, "ARTWORK", nil, 1)
dartEdge:SetTexture(UI_DIR .. "dart-edge")
dartEdge:SetAllPoints(dart)
local skinDisc = dial:CreateTexture(nil, "BACKGROUND")
skinDisc:SetTexture(UI_DIR .. "circle")
skinDisc:SetSize(SKIN_RING - 2, SKIN_RING - 2)
skinDisc:SetPoint("CENTER")
local skinRing = dial:CreateTexture(nil, "ARTWORK")
skinRing:SetTexture(UI_DIR .. "skin-ring")
skinRing:SetSize(SKIN_RING * 60 / 48, SKIN_RING * 60 / 48) -- the ring is 48 of the texture's 60 units
skinRing:SetPoint("CENTER")
local skinCheck = dial:CreateTexture(nil, "ARTWORK", nil, 1)
skinCheck:SetTexture(UI_DIR .. "skin-check")
skinCheck:SetAllPoints(skinRing)
for _, t in ipairs({ dart, dartEdge, skinDisc, skinRing, skinCheck }) do t:Hide() end

-- A travel instruction (hearth, teleport, fly, take a boat or a lift) has no
-- direction to point at: the dial shows what to do instead, the leg's glyph in the accent.
local UI_MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\UI\\"
local LEG_ICON = { hearth = "icon-hearth", teleport = "icon-use", fly = "icon-fly", boat = "icon-boat", zeppelin = "icon-boat",
	tram = "icon-boat", portal = "icon-gate", lift = "icon-lift" }
local legIcon = dial:CreateTexture(nil, "ARTWORK")
legIcon:SetSize(DIAL * 0.6, DIAL * 0.6)
legIcon:SetPoint("CENTER")
legIcon:Hide()

local distText = frame:CreateFontString(nil, "OVERLAY")
distText:SetPoint("TOP", dial, "BOTTOM", 0, -2)
distText:SetJustifyH("CENTER")

local labelText = frame:CreateFontString(nil, "OVERLAY")
labelText:SetPoint("TOP", distText, "BOTTOM", 0, -3)
labelText:SetWidth(200)
labelText:SetJustifyH("CENTER")
labelText:SetWordWrap(true)
labelText:SetMaxLines(2)

local etaText = frame:CreateFontString(nil, "OVERLAY")
etaText:SetPoint("TOP", labelText, "BOTTOM", 0, -2)
etaText:SetJustifyH("CENTER")

local Arrow = {
	frame = frame, dial = dial, mover = mover, body = body, facet = facet, glow = glow, sheet = sheet, sheetSpec = sheetSpec,
	ring = ring, halo = halo, legIcon = legIcon, distText = distText, labelText = labelText, etaText = etaText,
	dart = dart, dartEdge = dartEdge, skinRing = skinRing, skinCheck = skinCheck, skinDisc = skinDisc,
}
Nav.arrow = Arrow

---------------------------------------------------------------------------
-- State (all scalars: nothing is allocated per frame)
---------------------------------------------------------------------------

local mode            -- "travel" | "arrived" | "search" | "far" | "instruction" | "nopos" | nil
local accum = 0       -- time since the last world sample
local curAngle = 0    -- displayed rotation
local goalAngle = 0   -- rotation the damping moves toward
local hasAngle = false
local lastYards, lastEta
local lastDist, closeSpeed = nil, 0
local pulse = 0
local showEta = true
local routeSeen = -1  -- Travel.version the label shows; -1 = the target's own label
local loneSeen = -1   -- Travel.version a lone walk's warning was last asked for
local WARN_SECONDS = 8 -- a walk's "Hostile town" warning stays under its step this long
local warning, warnUntil -- the warning being said (Travel.TakeWarning) and until when (GetTime)
local style = "3d"    -- nav.arrowStyle
local shownFrame = -1 -- sheet frame on screen (-1 = none yet)

-- The route's label line: the current leg's instruction, and under it the
-- walk's "Hostile town" warning while it is being said.
local function routeLabel(T)
	local text = T.CurrentLabel() or ""
	if not warning then return text end
	return text ~= "" and (text .. "\n" .. warning) or warning
end

local tintR, tintG, tintB = Nav.RGB("arrow")

-- The ETA / secondary line: text at 80%, a step behind the distance.
local function etaColor()
	local r, g, b = Nav.RGB("text")
	etaText:SetTextColor(r, g, b, 0.8)
end

local function skinStyle() return style == "halo" or style == "hearth" end

local function setRotation(a)
	if skinStyle() then
		dart:SetRotation(a)
		dartEdge:SetRotation(a)
	elseif style == "3d" then
		local f = Nav.ArrowFrame(a)
		if f ~= shownFrame then
			shownFrame = f
			local l, r, t, b = Nav.ArrowFrameCoords(f)
			sheet:SetTexCoord(l, r, t, b)
			sheetSpec:SetTexCoord(l, r, t, b)
		end
	else
		body:SetRotation(a)
		facet:SetRotation(a)
		glow:SetRotation(a)
	end
end

-- Which arrow textures are up while travelling, for the current style.
local function showArrow(on)
	local flat = on and style == "flat"
	local solid = on and style == "3d"
	local own = on and skinStyle()
	body:SetShown(flat)
	facet:SetShown(flat)
	glow:SetShown(flat)
	sheet:SetShown(solid)
	sheetSpec:SetShown(solid)
	dart:SetShown(own)
	dartEdge:SetShown(own)
end

-- The skins' arrival: the ring, the disc under it (Halo's veil), and the
-- check once the arrival has shown (Arrow's OnUpdate: SKIN_CHECK_AFTER).
local SKIN_CHECK_AFTER = 0.6
local function showSkinArrival(on)
	local own = on and skinStyle()
	skinRing:SetShown(own)
	skinDisc:SetShown(own and style == "halo")
	skinCheck:SetShown(false)
	return own
end

local function setMode(m)
	if m == mode then return end
	mode = m
	local travel, done, act = m == "travel", m == "arrived" or m == "search", m == "instruction"
	dial:SetShown(travel or done or act)
	grabArea(travel or done or act)
	showArrow(travel)
	local skinDone = showSkinArrival(done)
	ring:SetShown(done and not skinDone)
	halo:SetShown((done and not skinDone) or act)
	legIcon:SetShown(act)
	lastYards, lastEta = nil, nil
	lastDist, closeSpeed = nil, 0
	etaText:Hide()
	if done then
		pulse = 0
		local r, g, b = Nav.RGB("arrowNear")
		ring:SetVertexColor(r, g, b, 1)
		halo:SetVertexColor(r, g, b, 0.5)
		skinRing:SetVertexColor(r, g, b, 1)
		skinCheck:SetVertexColor(r, g, b, 1)
		skinDisc:SetVertexColor(0.031, 0.024, 0.016, 0.45)
		distText:SetTextColor(Nav.RGB("arrowNearText"))
		-- An area objective is never done by standing somewhere: look around,
		-- then move on (a click on the arrow, or the next spot comes up by itself).
		distText:SetText(m == "search" and L["Search here"] or L["Arrived"])
		if m == "search" then
			etaColor()
			etaText:SetText(L["Click the arrow for the next spot"])
			etaText:Show()
		end
	elseif m == "far" then
		local r, g, b = Nav.RGB("place")
		distText:SetTextColor(r, g, b, 1)
		distText:SetText(Nav.GetTargetZoneName() or L["Unknown zone"])
		etaColor()
		etaText:SetText(L["On another continent"])
		etaText:Show()
	elseif m == "nopos" then
		-- Nothing to point at or measure; the label (target or route leg) stays.
		distText:SetTextColor(Nav.RGB("textDim"))
		distText:SetText(L["No position here"])
	elseif act then
		-- Act here: "Fly to Lakeshire", "Take the zeppelin to Undercity", "Hearth to Goldshire".
		local T = Nav.travel
		local leg = T and T.CurrentLeg and T.CurrentLeg()
		legIcon:SetTexture(UI_MEDIA .. (leg and LEG_ICON[leg.kind] or "icon-goto"))
		local r, g, b = Nav.RGB("arrow")
		legIcon:SetVertexColor(r, g, b, 1)
		halo:SetVertexColor(r, g, b, 0.45)
		distText:SetTextColor(Nav.RGB("arrowText"))
		distText:SetText(T and T.CurrentLabel() or "")
		local target = Nav.GetTarget()
		labelText:SetText(target and target.label or "")
		etaColor()
	else
		distText:SetTextColor(Nav.RGB("text"))
		etaColor()
		local T = Nav.travel
		if T and T.Active() then labelText:SetText(routeLabel(T)) end
	end
end

local nearShown -- the skins' darts: whether the arrival colour is on

local function tint(r, g, b)
	tintR, tintG, tintB = r, g, b
	body:SetVertexColor(r, g, b, 1)
	glow:SetVertexColor(r, g, b, 0.45)
	sheet:SetVertexColor(r, g, b, 1)
	if skinStyle() then
		-- Hearth's far dart is its baked gold, unless the player picked
		-- their own arrow colour; up close (and Halo's always) it is tinted.
		local own = type(ns.Get("nav.arrowColor")) == "table"
		local gold = style == "hearth" and not nearShown and not own
		dart:SetTexture(UI_DIR .. (gold and "dart-gold" or "dart"))
		if gold then dart:SetVertexColor(1, 1, 1, 1) else dart:SetVertexColor(r, g, b, 1) end
		local e = EDGE[style == "halo" and (nearShown and "haloNear" or "halo") or "hearth"]
		dartEdge:SetVertexColor(e[1], e[2], e[3], 1)
	end
end

-- The far colour away, the near colour up close; smoothstep over CLOSE_RANGE.
local function applyColor(dist, radius)
	if skinStyle() then
		-- The skins' darts: the far colour, then the arrival colour within 40 m.
		nearShown = dist <= DART_NEAR
		tint(Nav.RGB(nearShown and "arrowNear" or "arrow"))
		return
	end
	local t = 1 - (dist - radius) / CLOSE_RANGE
	if t < 0 then t = 0 elseif t > 1 then t = 1 end
	t = t * t * (3 - 2 * t)
	local ar, ag, ab = Nav.RGB("arrow")
	local sr, sg, sb = Nav.RGB("arrowNear")
	tint(ar + (sr - ar) * t, ag + (sg - ag) * t, ab + (sb - ab) * t)
end

-- nav.arrowStyle changed: swap textures in place, keeping heading and colour.
local function applyStyle(new)
	if new == style then return end
	style = new
	shownFrame = -1
	showArrow(mode == "travel")
	setRotation(curAngle)
	tint(tintR, tintG, tintB)
end

-- Shortest Path Forever's own arrow guides while the target is handed to it (Nav/Handoff.lua).
local function shouldShow()
	return ns.Get("nav.arrow") and Nav.GetTarget() ~= nil and not Nav.UsingTomTomArrow() and not Nav.HandedOff()
end

local function showSeconds(secs)
	secs = floor(secs + 0.5)
	if secs ~= lastEta then
		lastEta = secs
		etaText:SetFormattedText(L["%d:%02d total"], floor(secs / 60), secs % 60)
	end
	etaText:Show()
end

-- The label line follows the route: the current leg's instruction while a
-- route is active, the target's label otherwise. A walk entering the other
-- faction's towns says so once, as it starts (Travel.TakeWarning), for
-- WARN_SECONDS: under the step, or under the target's label when the walk
-- is the whole route.
local function syncLabel(T, routed)
	local leg = not routed and T ~= nil and T.CurrentLeg and T.CurrentLeg()
	local lone = leg and leg.kind == "walk" or false
	if warning and (not (routed or lone) or GetTime() >= warnUntil) then
		warning = nil
		routeSeen = -2
	end
	if routed then
		if T.version ~= routeSeen then
			routeSeen = T.version
			local w = T.TakeWarning and T.TakeWarning()
			if w then warning, warnUntil = w, GetTime() + WARN_SECONDS end
			labelText:SetText(routeLabel(T))
			if mode == "instruction" then mode = nil end
		end
		return
	end
	if lone and T.version ~= loneSeen then
		loneSeen = T.version
		local w = T.TakeWarning and T.TakeWarning()
		if w then warning, warnUntil, routeSeen = w, GetTime() + WARN_SECONDS, -2 end
	end
	if routeSeen ~= -1 then
		routeSeen = -1
		local target = Nav.GetTarget()
		local text = target and target.label or ""
		if warning then text = text ~= "" and (text .. "\n" .. warning) or warning end
		labelText:SetText(text)
	end
end

-- One world sample; returns false when the arrow has hidden itself.
local function sample(elapsed)
	if not shouldShow() then
		frame:Hide()
		return false
	end
	local state, dist, angle, _, _, measured = Nav.Sample()
	if Nav.IsHiddenState(state) then
		frame:Hide()
		return false
	end
	local T = Nav.travel
	local routed = T ~= nil and T.Active() or false
	syncLabel(T, routed)
	if state == "far" or state == "arrived" or state == "search" or state == "nopos" then
		setMode(state)
		return true
	end
	if state == "instruction" then
		setMode("instruction")
		local secs = showEta and T.Remaining(nil)
		if secs then showSeconds(secs) else etaText:Hide() end
		return true
	end

	setMode("travel")
	if angle then
		goalAngle = angle
		if not hasAngle then
			curAngle, hasAngle = angle, true
			setRotation(curAngle)
		end
	end

	local yards = floor(dist + 0.5)
	if yards ~= lastYards then
		lastYards = yards
		distText:SetText(ns.FormatDistance(yards))
	end
	local target = Nav.GetTarget()
	applyColor(dist, target and target.r or Nav.DEFAULT_RADIUS)

	if showEta then
		if routed then
			-- Whole-route time: legs ahead plus this walk (`measured`: dist is along a path).
			local secs = T.Remaining(dist, measured)
			if secs then showSeconds(secs) else etaText:Hide() end
			return true
		end
		-- Only timed samples move the reference point: an out-of-band Refresh
		-- (sample(0)) would otherwise shorten the next interval's distance
		-- without shortening its time, underestimating the closing speed.
		if elapsed > 0 then
			if lastDist then
				local v = (lastDist - dist) / elapsed
				closeSpeed = closeSpeed + (v - closeSpeed) * min(1, elapsed * 2)
			end
			lastDist = dist
		end
		if closeSpeed > 1.5 then
			local secs = floor(dist / closeSpeed + 0.5)
			if secs ~= lastEta then
				lastEta = secs
				etaText:SetFormattedText("%d:%02d", floor(secs / 60), secs % 60)
			end
			etaText:Show()
		else
			lastEta = nil
			etaText:Hide()
		end
	end
	return true
end

frame:SetScript("OnUpdate", function(_, elapsed)
	accum = accum + elapsed
	if accum >= SAMPLE_INTERVAL then
		local step = accum
		accum = 0
		if not sample(step) then return end
	end
	if mode == "travel" and hasAngle then
		local diff = wrap(goalAngle - curAngle)
		if abs(diff) > 1e-4 then
			curAngle = wrap(curAngle + diff * (1 - exp(-elapsed * DAMPING)))
			setRotation(curAngle)
		end
	elseif (mode == "arrived" or mode == "search") and skinStyle() then
		pulse = pulse + elapsed
		if pulse >= SKIN_CHECK_AFTER and not skinCheck:IsShown() then skinCheck:Show() end
	elseif mode == "arrived" or mode == "search" then
		pulse = pulse + elapsed
		local s = 1 + 0.06 * sin(pulse * 4)
		ring:SetSize(DIAL * s, DIAL * s)
		halo:SetAlpha(0.35 + 0.25 * (0.5 + 0.5 * sin(pulse * 4)))
	end
end)

frame:SetScript("OnShow", function()
	accum, hasAngle = 0, false
end)

---------------------------------------------------------------------------
-- Moving, settings
---------------------------------------------------------------------------

local function applyPosition()
	frame:ClearAllPoints()
	local pos = ns.Get("nav.arrowPos")
	if type(pos) == "table" and type(pos.point) == "string" then
		frame:SetPoint(pos.point, UIParent, pos.relPoint or pos.point, tonumber(pos.x) or 0, tonumber(pos.y) or 0)
	else
		frame:SetPoint("TOP", UIParent, "TOP", 0, -140)
	end
end

function Nav.ResetArrowPosition()
	ns.Set("nav.arrowPos", nil)
end

local moving = false
frame:SetScript("OnDragStart", function(self)
	if ns.DragLocked() then return end
	moving = true
	self:StartMoving()
end)

frame:SetScript("OnDragStop", function(self)
	if not moving then return end
	moving = false
	self:StopMovingOrSizing()
	local point, _, relPoint, x, y = self:GetPoint(1)
	if point then ns.Set("nav.arrowPos", { point = point, relPoint = relPoint, x = x, y = y }) end
end)

frame:SetScript("OnEnter", function(self)
	mover:SetShown(not ns.DragLocked())
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	GameTooltip:SetText(L["Polestar arrow"])
	GameTooltip:AddLine(ns.Get("ui.lockHud") and L["Shift-drag to move."] or L["Drag to move."], Nav.RGB("text"))
	local target = Nav.GetTarget()
	if target and target.spots then GameTooltip:AddLine(L["Click for the next spot."], Nav.RGB("text")) end
	GameTooltip:Show()
end)

frame:SetScript("OnLeave", function()
	mover:Hide()
	GameTooltip:Hide()
end)

-- A click (not a drag) on an area objective's arrow moves on to its next spot.
local dragged = false
frame:SetScript("OnMouseDown", function() dragged = false end)
frame:HookScript("OnDragStart", function() dragged = true end)
frame:SetScript("OnMouseUp", function(_, button)
	if button == "LeftButton" and not dragged then Nav.NextSpot() end
end)

local function clamp(v, lo, hi, default)
	v = tonumber(v) or default
	return min(hi, max(lo, v))
end

function Arrow:OnSettings()
	frame:SetScale(clamp(ns.Get("nav.arrowScale"), 0.5, 2, 1))
	frame:SetAlpha(clamp(ns.Get("nav.arrowAlpha"), 0.1, 1, 1))
	lastYards = nil -- nav.distanceUnit: redraw the distance on the next sample
	showEta = ns.Get("nav.arrowEta") and true or false
	if not showEta and mode == "travel" then etaText:Hide() end
	applyStyle(Arrow.StyleFor(ns.Get("nav.arrowStyle")))
	applyPosition()
	self:Refresh()
end

-- The style a setting stands for: "skin" takes the skin's.
function Arrow.StyleFor(v)
	if v == "skin" or v == nil then
		local Theme = ns.Theme
		return SKIN_ARROW[Theme and Theme.SkinKey and Theme.SkinKey() or "polestar"] or "3d"
	end
	if v == "flat" or v == "halo" or v == "hearth" then return v end
	return "3d"
end

function Arrow:OnTheme()
	applyStyle(Arrow.StyleFor(ns.Get("nav.arrowStyle")))
	if skinStyle() then
		-- The handoff's arrow text: distance Display 20, name 12, line 11.
		Nav.SetHudFont(distText, "number", 20)
		Nav.SetHudFont(labelText, "body", 12)
		Nav.SetHudFont(etaText, "small", 11)
		labelText:SetTextColor(Nav.RGB("npc"))
	else
		Nav.SetHudFont(distText, "number", 16)
		Nav.SetHudFont(labelText, "body", 12)
		Nav.SetHudFont(etaText, "small", 12)
		labelText:SetTextColor(Nav.RGB("text"))
	end
	etaColor()
	mover:SetColorTexture(Nav.Wash("mover"))
	local m = mode
	mode = nil
	if m then setMode(m) end
end

function Arrow:OnTarget(target)
	labelText:SetText(target and target.label or "")
	mode, hasAngle, routeSeen, loneSeen, warning = nil, false, -1, -1, nil
	self:Refresh()
end

-- Show/hide from outside OnUpdate (target change, events, ticker).
function Arrow:Refresh()
	if frame:IsShown() then
		sample(0)
	elseif shouldShow() then
		local state = Nav.Sample()
		if not Nav.IsHiddenState(state) then
			frame:Show()
			sample(0)
		end
	end
end

function Arrow.GetMode()
	return frame:IsShown() and mode or nil
end

function Arrow.GetAngle()
	return curAngle
end

function Arrow.GetStyle()
	return style
end

-- Sheet frame on screen in the 3D style (nil in the flat style).
function Arrow.GetFrame()
	if style ~= "3d" or shownFrame < 0 then return nil end
	return shownFrame
end

Nav.RegisterModule(Arrow)
