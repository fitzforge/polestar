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
-- turns the heading every frame, allocating nothing. The damping works on
-- the target's bearing on the map, capped at MAX_TURN, and the player's
-- facing is taken off every frame: a new aim point swings the arrow round
-- smoothly, while turning the camera moves it at once. Hidden states (no
-- target, taxi, instance) are re-checked by Nav's once-a-second ticker. It
-- goes with the guide window only with nav.hideArrowWithGuide on, and never
-- on the way back to your corpse (Nav.HiddenWithGuide).
--
-- The look (glow, arrival ring and pulse, text size, face, outline, colours
-- and position, opacity in combat, the faint ring with no goal) is the
-- nav.arrow* settings below, on Settings > Arrow (Nav/ArrowOptions.lua). The
-- regions are built by buildDial and painted by functions that take a dial,
-- so that page's preview paints sandbox dials with this same code.

local ADDON, ns = ...
local Nav = ns.Nav
local L = ns.L

local exp, sin, abs, floor, min, max, pi = math.exp, math.sin, math.abs, math.floor, math.min, math.max, math.pi
local wrap = Nav.WrapAngle
local MEDIA = Nav.MEDIA

local SAMPLE_INTERVAL = 0.05 -- seconds between world samples
-- Rotation stiffness (1/s; higher = snappier), nav.arrowTurn: how fast the
-- arrow on screen eases toward the bearing, never where it points.
local DAMPING = { snappy = 24, smooth = 12, gentle = 6 }
local MAX_TURN = 3.5         -- radians a second the bearing may swing (about 200°)
local CLOSE_RANGE = 250      -- yards over which the colour shifts toward success (nav.arrowNearRange)
local DIAL = 64

-- Sprite sheet layout; must match tools/media/nav/arrow3d.js LAYOUT.
local FRAMES, COLS, CELL, SHEET = 100, 10, 102, 1024
local TWO_PI = 2 * pi
local STEP = TWO_PI / FRAMES
local SPRITE = DIAL * 1.5

ns.RegisterDefaults("nav", {
	arrowStyle = "skin",
	-- The arrow's look (Settings > Arrow, Nav/ArrowOptions.lua); every
	-- default draws the arrow as it always looked. Colours: false follows
	-- the theme (the arrival colour, text, the skin's label colour).
	arrowRingColor = false,   -- the arrival ring and its glow
	arrowDistColor = false,   -- the distance on the way
	arrowLabelColor = false,  -- the target's name or the route's leg
	arrowGlow = true,         -- the flat arrow's glow and the halo behind the ring
	arrowGlowStrength = 1,
	arrowPulse = true,        -- the ring breathes; the skins' check follows the ring
	arrowNearRange = CLOSE_RANGE,
	arrowTurn = "smooth",     -- DAMPING
	arrowDistance = true,     -- the distance on the way
	arrowDistSize = 1, arrowLabelSize = 1, arrowEtaSize = 1,
	arrowFont = "theme",      -- "theme": Polestar's text font; else a family (Theme.FacePath)
	arrowOutline = "OUTLINE",
	arrowTextPos = "below",   -- "below" | "above" the dial
	arrowLabelLines = 2,      -- 0 hides the label
	arrowCombatAlpha = 1,     -- opacity in combat, times nav.arrowAlpha
	arrowNoTarget = "hide",   -- "hide" | "dim": a faint ring keeps the arrow's place
	arrowEtaColor = false,    -- the arrival time; false: text at 80%
	arrowLabelWidth = 200,    -- how wide the label may run before it wraps (the frame's WIDTH)
	arrowBacking = false,     -- a dark plate behind the text
	arrowBackingAlpha = 0.5,
})

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

local WIDTH, TEXT_H = 200, 66 -- the frame: the dial, and the distance and label under it

local function clamp(v, lo, hi, default)
	v = tonumber(v) or default
	return min(hi, max(lo, v))
end

---------------------------------------------------------------------------
-- The look settings (nav.arrow*), read into a table: the live arrow's
-- `look`, and the settings preview's own (Arrow.ReadLook).
---------------------------------------------------------------------------

local OUTLINES = { NONE = "", OUTLINE = "OUTLINE", THICKOUTLINE = "THICKOUTLINE" }

local function pickedColor(v)
	if type(v) == "table" and type(v[1]) == "number" and type(v[2]) == "number" and type(v[3]) == "number" then return v end
	return nil
end

local function readLook(t)
	t.glow = ns.Get("nav.arrowGlow") ~= false
	t.glowStrength = clamp(ns.Get("nav.arrowGlowStrength"), 0, 2, 1)
	t.pulse = ns.Get("nav.arrowPulse") ~= false
	t.nearRange = clamp(ns.Get("nav.arrowNearRange"), 0, 1000, CLOSE_RANGE)
	t.damping = DAMPING[ns.Get("nav.arrowTurn")] or DAMPING.smooth
	t.distance = ns.Get("nav.arrowDistance") ~= false
	t.distSize = clamp(ns.Get("nav.arrowDistSize"), 0.5, 2.5, 1)
	t.labelSize = clamp(ns.Get("nav.arrowLabelSize"), 0.5, 2.5, 1)
	t.etaSize = clamp(ns.Get("nav.arrowEtaSize"), 0.5, 2.5, 1)
	local font = ns.Get("nav.arrowFont")
	t.font = type(font) == "string" and font ~= "" and font or "theme"
	t.outline = OUTLINES[ns.Get("nav.arrowOutline")] or "OUTLINE"
	t.above = ns.Get("nav.arrowTextPos") == "above"
	t.lines = floor(clamp(ns.Get("nav.arrowLabelLines"), 0, 2, 2) + 0.5)
	t.ringColor = pickedColor(ns.Get("nav.arrowRingColor"))
	t.distColor = pickedColor(ns.Get("nav.arrowDistColor"))
	t.labelColor = pickedColor(ns.Get("nav.arrowLabelColor"))
	t.etaColor = pickedColor(ns.Get("nav.arrowEtaColor"))
	t.labelWidth = clamp(ns.Get("nav.arrowLabelWidth"), 120, 400, WIDTH)
	t.backing = ns.Get("nav.arrowBacking") and true or false
	t.backingAlpha = clamp(ns.Get("nav.arrowBackingAlpha"), 0, 1, 0.5)
	return t
end

---------------------------------------------------------------------------
-- A dial: the arrow's regions on `parent` (WIDTH x DIAL + TEXT_H). The live
-- arrow builds its one at load; the settings preview and its picture cards
-- build their own (Arrow.BuildDial) and paint them with the same functions
-- below, which take a dial. Construction only: no scripts, no state.
---------------------------------------------------------------------------

local UI_DIR = "Interface\\AddOns\\" .. ADDON .. "\\Media\\UI\\"

local function buildDial(parent)
	local d = { frame = parent, style = "3d", shownFrame = -1, near = false }

	local dial = CreateFrame("Frame", nil, parent)
	dial:SetSize(DIAL, DIAL)
	dial:SetPoint("TOP", parent, "TOP", 0, 0)
	d.dial = dial

	local glow = dial:CreateTexture(nil, "BACKGROUND")
	glow:SetTexture(MEDIA .. "arrow-glow")
	glow:SetSize(DIAL * 1.25, DIAL * 1.25)
	glow:SetPoint("CENTER")
	glow:SetBlendMode("ADD")
	d.glow = glow

	local body = dial:CreateTexture(nil, "ARTWORK")
	body:SetTexture(MEDIA .. "arrow")
	body:SetAllPoints()
	d.body = body

	local facet = dial:CreateTexture(nil, "ARTWORK", nil, 1)
	facet:SetTexture(MEDIA .. "arrow-facet")
	facet:SetAllPoints()
	d.facet = facet

	local sheet = dial:CreateTexture(nil, "ARTWORK")
	sheet:SetTexture(MEDIA .. "arrow3d")
	sheet:SetSize(SPRITE, SPRITE)
	sheet:SetPoint("CENTER")
	d.sheet = sheet

	local sheetSpec = dial:CreateTexture(nil, "ARTWORK", nil, 2)
	sheetSpec:SetTexture(MEDIA .. "arrow3d-spec")
	sheetSpec:SetSize(SPRITE, SPRITE)
	sheetSpec:SetPoint("CENTER")
	sheetSpec:SetBlendMode("ADD")
	d.sheetSpec = sheetSpec

	local halo = dial:CreateTexture(nil, "BACKGROUND")
	halo:SetTexture(MEDIA .. "glow")
	halo:SetSize(DIAL * 1.4, DIAL * 1.4)
	halo:SetPoint("CENTER")
	halo:SetBlendMode("ADD")
	d.halo = halo

	local ring = dial:CreateTexture(nil, "ARTWORK")
	ring:SetTexture(MEDIA .. "arrived")
	ring:SetSize(DIAL, DIAL)
	ring:SetPoint("CENTER")
	d.ring = ring

	-- The skins' darts and arrival (Media/UI: dart, dart-edge, dart-gold,
	-- skin-ring, skin-check, circle).
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
	d.dart, d.dartEdge, d.skinDisc, d.skinRing, d.skinCheck = dart, dartEdge, skinDisc, skinRing, skinCheck

	-- A travel instruction (hearth, teleport, fly, take a boat or a lift) has no
	-- direction to point at: the dial shows what to do instead, the leg's glyph in the accent.
	local legIcon = dial:CreateTexture(nil, "ARTWORK")
	legIcon:SetSize(DIAL * 0.6, DIAL * 0.6)
	legIcon:SetPoint("CENTER")
	legIcon:Hide()
	d.legIcon = legIcon

	local distText = parent:CreateFontString(nil, "OVERLAY")
	distText:SetPoint("TOP", dial, "BOTTOM", 0, -12) -- clear of the dart's tip and the 3D arrow's shadow
	distText:SetJustifyH("CENTER")
	d.distText = distText

	local labelText = parent:CreateFontString(nil, "OVERLAY")
	labelText:SetPoint("TOP", distText, "BOTTOM", 0, -5)
	labelText:SetWidth(WIDTH)
	labelText:SetJustifyH("CENTER")
	labelText:SetWordWrap(true)
	labelText:SetMaxLines(2)
	d.labelText = labelText

	local etaText = parent:CreateFontString(nil, "OVERLAY")
	etaText:SetPoint("TOP", labelText, "BOTTOM", 0, -4)
	etaText:SetJustifyH("CENTER")
	d.etaText = etaText

	-- The plate behind the text (nav.arrowBacking), over the mover's wash.
	local backing = parent:CreateTexture(nil, "BACKGROUND", nil, -7)
	backing:SetColorTexture(1, 1, 1, 1)
	backing:Hide()
	d.backing = backing
	return d
end

---------------------------------------------------------------------------
-- Painting a dial: the live arrow's and the preview's alike.
---------------------------------------------------------------------------

local function isSkin(s) return s == "halo" or s == "hearth" end

local function dialRotate(d, a)
	local s = d.style
	if isSkin(s) then
		d.dart:SetRotation(a)
		d.dartEdge:SetRotation(a)
	elseif s == "3d" then
		local f = Nav.ArrowFrame(a)
		if f ~= d.shownFrame then
			d.shownFrame = f
			local l, r, t, b = Nav.ArrowFrameCoords(f)
			d.sheet:SetTexCoord(l, r, t, b)
			d.sheetSpec:SetTexCoord(l, r, t, b)
		end
	else
		d.body:SetRotation(a)
		d.facet:SetRotation(a)
		d.glow:SetRotation(a)
	end
end

-- Which arrow textures are up while travelling, for the dial's style.
local function dialShowArrow(d, on, lk)
	local s = d.style
	local flat = on and s == "flat"
	local solid = on and s == "3d"
	local own = on and isSkin(s)
	d.body:SetShown(flat)
	d.facet:SetShown(flat)
	d.glow:SetShown(flat and lk.glow)
	d.sheet:SetShown(solid)
	d.sheetSpec:SetShown(solid)
	d.dart:SetShown(own)
	d.dartEdge:SetShown(own)
end

local function dialTint(d, r, g, b, lk)
	d.body:SetVertexColor(r, g, b, 1)
	d.glow:SetVertexColor(r, g, b, min(1, 0.45 * lk.glowStrength))
	d.sheet:SetVertexColor(r, g, b, 1)
	local s = d.style
	if isSkin(s) then
		-- Hearth's far dart is its baked gold, unless the player picked
		-- their own arrow colour; up close (and Halo's always) it is tinted.
		local own = type(ns.Get("nav.arrowColor")) == "table"
		local gold = s == "hearth" and not d.near and not own
		d.dart:SetTexture(UI_DIR .. (gold and "dart-gold" or "dart"))
		if gold then d.dart:SetVertexColor(1, 1, 1, 1) else d.dart:SetVertexColor(r, g, b, 1) end
		local e = EDGE[s == "halo" and (d.near and "haloNear" or "halo") or "hearth"]
		d.dartEdge:SetVertexColor(e[1], e[2], e[3], 1)
	end
end

-- The colour at `dist` yards from a target of `radius`: the far colour away,
-- the near colour up close, smoothstep over nav.arrowNearRange; the skins'
-- darts turn to the near colour within 40 m (scaled with the range).
-- -> r, g, b, near (the skins' arrival colour is on)
local function blend(style, dist, radius, lk)
	local range = lk.nearRange
	if isSkin(style) then
		local near = dist <= (range == CLOSE_RANGE and DART_NEAR or DART_NEAR * range / CLOSE_RANGE)
		local r, g, b = Nav.RGB(near and "arrowNear" or "arrow")
		return r, g, b, near
	end
	local t
	if range > 0 then t = 1 - (dist - radius) / range else t = dist <= radius and 1 or 0 end
	if t < 0 then t = 0 elseif t > 1 then t = 1 end
	t = t * t * (3 - 2 * t)
	local ar, ag, ab = Nav.RGB("arrow")
	local sr, sg, sb = Nav.RGB("arrowNear")
	return ar + (sr - ar) * t, ag + (sg - ag) * t, ab + (sb - ab) * t, false
end

-- The arrival on a dial (`done`): the house ring and the halo behind it, or
-- the skins' ring, the disc under it (Halo's veil) and the check once the
-- arrival has shown (dialPulse: SKIN_CHECK_AFTER; at once without the
-- pulse). -> whether the skin's arrival is up
local SKIN_CHECK_AFTER = 0.6
local function dialArrival(d, done, lk)
	local s = d.style
	local own = done and isSkin(s)
	d.skinRing:SetShown(own)
	d.skinDisc:SetShown(own and s == "halo")
	d.skinCheck:SetShown(own and not lk.pulse)
	d.ring:SetShown(done and not own)
	d.halo:SetShown(done and not own and lk.glow)
	if done then
		local r, g, b
		local c = lk.ringColor
		if c then r, g, b = c[1], c[2], c[3] else r, g, b = Nav.RGB("arrowNear") end
		d.ring:SetVertexColor(r, g, b, 1)
		d.ring:SetSize(DIAL, DIAL)
		d.halo:SetVertexColor(r, g, b, min(1, 0.5 * lk.glowStrength))
		d.halo:SetAlpha(0.475)
		d.skinRing:SetVertexColor(r, g, b, 1)
		d.skinCheck:SetVertexColor(r, g, b, 1)
		d.skinDisc:SetVertexColor(0.031, 0.024, 0.016, 0.45)
	end
	return own
end

-- The arrival's animation, `t` seconds in: the house ring breathes, the
-- skins' check comes after the ring.
local function dialPulse(d, t)
	if isSkin(d.style) then
		if t >= SKIN_CHECK_AFTER and not d.skinCheck:IsShown() then d.skinCheck:Show() end
		return
	end
	local s = 1 + 0.06 * sin(t * 4)
	d.ring:SetSize(DIAL * s, DIAL * s)
	d.halo:SetAlpha(0.35 + 0.25 * (0.5 + 0.5 * sin(t * 4)))
end

-- HUD text: a face at a size chosen for reading over the 3D world, outlined
-- (nav.arrowOutline) so it survives bright terrain; the shadow stays dark.
-- nav.arrowFont "theme" takes Polestar's text font for the role.
local function hudFont(fs, role, weight, size, lk)
	local T = ns.Theme
	local path
	if lk.font ~= "theme" and T and T.FacePath then
		local ok, p = pcall(T.FacePath, lk.font, weight)
		if ok and type(p) == "string" then path = p end
	end
	if T and T.SetFace and T.FontSpec then
		T.SetFace(fs, path or (T.FontSpec(role)), size, lk.outline)
	else
		fs:SetFont(path or STANDARD_TEXT_FONT, size, lk.outline)
	end
	local r, g, b = Nav.RGB("shade")
	fs:SetShadowColor(r, g, b, 0.8)
	fs:SetShadowOffset(1, -1)
end

local function textSize(base, k) return floor(base * k * 2 + 0.5) / 2 end

-- The text's faces and sizes and the label's colour. The skins' darts take
-- the handoff's arrow text: distance Display 20, name 12, line 11.
local function dialText(d, lk)
	local skin = isSkin(d.style)
	hudFont(d.distText, "number", "semibold", textSize(skin and 20 or 16, lk.distSize), lk)
	hudFont(d.labelText, "body", "medium", textSize(12, lk.labelSize), lk)
	hudFont(d.etaText, "small", "medium", textSize(skin and 11 or 12, lk.etaSize), lk)
	local c = lk.labelColor
	if c then d.labelText:SetTextColor(c[1], c[2], c[3]) else d.labelText:SetTextColor(Nav.RGB(skin and "npc" or "text")) end
	d.labelText:SetMaxLines(max(1, lk.lines))
	d.labelText:SetWidth(lk.labelWidth)
	local e = lk.etaColor
	if e then
		d.etaText:SetTextColor(e[1], e[2], e[3], 1)
	else
		-- The ETA / secondary line: text at 80%, a step behind the distance.
		local r, g, b = Nav.RGB("text")
		d.etaText:SetTextColor(r, g, b, 0.8)
	end
end

-- Where the text sits: under the dial, or over it (nav.arrowTextPos) with
-- the distance next to the dial either way; a hidden line takes no room.
local function dialLayout(d, lk, showDist)
	local dial, dist, label, eta = d.dial, d.distText, d.labelText, d.etaText
	local showLabel = lk.lines > 0
	dist:SetShown(showDist)
	label:SetShown(showLabel)
	local edge, away, sign = "TOP", "BOTTOM", -1
	if lk.above then edge, away, sign = "BOTTOM", "TOP", 1 end
	dial:ClearAllPoints()
	dial:SetPoint(edge, d.frame, edge, 0, 0)
	dist:ClearAllPoints()
	label:ClearAllPoints()
	eta:ClearAllPoints()
	local prev, gap = dial, 12 -- clear of the dart's tip and the 3D arrow's shadow
	if showDist then
		dist:SetPoint(edge, prev, away, 0, sign * gap)
		prev, gap = dist, 5
	end
	if showLabel then
		label:SetPoint(edge, prev, away, 0, sign * gap)
		prev, gap = label, 4
	end
	eta:SetPoint(edge, prev, away, 0, sign * gap)
	-- The plate covers the text's side of the frame.
	local plate = d.backing
	plate:SetShown(lk.backing)
	if lk.backing then
		local r, g, b = Nav.RGB("shade")
		plate:SetVertexColor(r, g, b, lk.backingAlpha)
		plate:ClearAllPoints()
		if lk.above then
			plate:SetPoint("TOPLEFT", d.frame, "TOPLEFT", 0, 0)
			plate:SetPoint("BOTTOMRIGHT", d.frame, "BOTTOMRIGHT", 0, DIAL + 4)
		else
			plate:SetPoint("TOPLEFT", d.frame, "TOPLEFT", 0, -DIAL - 4)
			plate:SetPoint("BOTTOMRIGHT", d.frame, "BOTTOMRIGHT", 0, 0)
		end
	end
end

---------------------------------------------------------------------------
-- The live arrow
---------------------------------------------------------------------------

local frame = CreateFrame("Frame", "PolestarNavArrow", UIParent)
frame:SetSize(WIDTH, DIAL + TEXT_H)
frame:SetFrameStrata("MEDIUM")
frame:SetClampedToScreen(true)
frame:SetMovable(true)
frame:EnableMouse(true) -- always movable: drag the arrow anywhere (Shift-drag with ui.lockHud on)
frame:RegisterForDrag("LeftButton")
frame:Hide()

local D = buildDial(frame)
local dial, glow, body, facet, sheet, sheetSpec, halo, ring = D.dial, D.glow, D.body, D.facet, D.sheet, D.sheetSpec, D.halo, D.ring
local dart, dartEdge, skinDisc, skinRing, skinCheck, legIcon = D.dart, D.dartEdge, D.skinDisc, D.skinRing, D.skinCheck, D.legIcon
local distText, labelText, etaText = D.distText, D.labelText, D.etaText
local look = readLook({}) -- the live arrow's look (OnSettings, OnTheme)

-- Shown behind the part that takes the mouse while hovering it, so it reads
-- as movable.
local mover = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
mover:SetColorTexture(Nav.Wash("mover"))
mover:Hide()

-- Only the dial takes the mouse: the text under (or over) it would otherwise
-- catch drags meant for the world, more so at a large scale. Without the
-- dial (another continent, no position) the text is all there is, so it does.
local grabOnDial = true
local function grabArea(onDial)
	grabOnDial = onDial
	local side = onDial and (WIDTH - DIAL) / 2 or 0
	local top, bottom = onDial and 0 or DIAL, onDial and TEXT_H or 0
	if look.above then top, bottom = bottom, top end
	frame:SetHitRectInsets(side, side, top, bottom)
	mover:ClearAllPoints()
	if onDial then
		mover:SetAllPoints(dial)
	elseif look.above then
		mover:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		mover:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, DIAL)
	else
		mover:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -DIAL)
		mover:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
	end
end
grabArea(true)

local UI_MEDIA = UI_DIR
local LEG_ICON = { hearth = "icon-hearth", teleport = "icon-use", fly = "icon-fly", boat = "icon-boat", zeppelin = "icon-boat",
	tram = "icon-boat", portal = "icon-gate", lift = "icon-lift" }

-- The catch-up's hourglass (Arrow.SetBusy; Media/UI hourglass and
-- hourglass-sand, tools/media/ui.js): while the guide window goes over the
-- steps, it stands in the dial's place and turns over and over, the glass
-- in text and its sand in the arrow's colour, with the text under the dial
-- hidden.
local HOURGLASS_HOLD, HOURGLASS_TURN = 0.45, 0.4 -- seconds upright, then turning over
local glass = CreateFrame("Frame", nil, frame)
glass:SetSize(DIAL, DIAL)
glass:SetPoint("CENTER", dial, "CENTER")
glass:Hide()
local glassBody = glass:CreateTexture(nil, "ARTWORK", nil, 1)
glassBody:SetTexture(UI_MEDIA .. "hourglass")
glassBody:SetSize(DIAL * 0.8, DIAL * 0.8)
glassBody:SetPoint("CENTER")
local glassSand = glass:CreateTexture(nil, "ARTWORK")
glassSand:SetTexture(UI_MEDIA .. "hourglass-sand")
glassSand:SetAllPoints(glassBody)
local glassTime = 0
glass:SetScript("OnUpdate", ns.Safe(function(_, elapsed)
	glassTime = glassTime + elapsed
	local c = glassTime % (HOURGLASS_HOLD + HOURGLASS_TURN)
	local a = 0
	if c > HOURGLASS_HOLD then
		local p = (c - HOURGLASS_HOLD) / HOURGLASS_TURN
		p = p < 0.5 and 4 * p * p * p or 1 - (2 - 2 * p) ^ 3 / 2
		a = pi * p
	end
	glassBody:SetRotation(a)
	glassSand:SetRotation(a)
end))

-- Up or down to the target's floor (Nav.FloorHint), left of the distance.
local floorIcon = frame:CreateTexture(nil, "OVERLAY")
floorIcon:SetSize(12, 12)
floorIcon:SetPoint("RIGHT", distText, "LEFT", -3, 0)
floorIcon:Hide()

local Arrow = {
	frame = frame, dial = dial, mover = mover, body = body, facet = facet, glow = glow, sheet = sheet, sheetSpec = sheetSpec,
	ring = ring, halo = halo, legIcon = legIcon, distText = distText, labelText = labelText, etaText = etaText, floorIcon = floorIcon,
	dart = dart, dartEdge = dartEdge, skinRing = skinRing, skinCheck = skinCheck, skinDisc = skinDisc,
	glass = glass, glassBody = glassBody, glassSand = glassSand, backing = D.backing,
}
Nav.arrow = Arrow

---------------------------------------------------------------------------
-- State (all scalars: nothing is allocated per frame)
---------------------------------------------------------------------------

local mode            -- "travel" | "arrived" | "search" | "far" | "instruction" | "nopos" | "idle" | nil
local accum = 0       -- time since the last world sample
local curAngle = 0    -- displayed rotation (bearing less facing)
local goalAngle = 0   -- bearing (or, without a facing, rotation) the damping moves toward
local curBearing = 0  -- the damped bearing
local hasAngle = false
local byBearing = false -- goalAngle and curBearing are map bearings (the facing is known)

local function facing()
	local C = ns.Compat
	return C and C.GetPlayerFacing and C.GetPlayerFacing() or nil
end
local lastYards, lastEta
local floorShown -- the floor glyph's hint ("up" | "down") or nil
local lastDist, closeSpeed = nil, 0
local pulse = 0
local showEta = true
local routeSeen = -1  -- Travel.version the label shows; -1 = the target's own label
local loneSeen = -1   -- Travel.version a lone walk's warning was last asked for
local WARN_SECONDS = 8 -- a walk's "Hostile town" warning stays under its step this long
local warning, warnUntil -- the warning being said (Travel.TakeWarning) and until when (GetTime)
local style = "3d"    -- nav.arrowStyle (D.style)

-- A target's own warning (Nav.SetTarget's `warning`: a dungeon whose way in
-- lies in the other faction's land) stays under the label while it is the
-- target; the walk's hostile-town warning (`warning`) comes after it.
local function withTargetWarning(text)
	local t = Nav.GetTarget()
	local tw = t and t.warning
	if not tw then return text end
	return text ~= "" and (text .. "\n" .. tw) or tw
end

-- The route's label line: the current leg's instruction, and under it the
-- walk's "Hostile town" warning while it is being said.
local function routeLabel(T)
	local text = withTargetWarning(T.CurrentLabel() or "")
	if not warning then return text end
	return text ~= "" and (text .. "\n" .. warning) or warning
end

local tintR, tintG, tintB = Nav.RGB("arrow")

-- The ETA / secondary line: text at 80%, or the player's (dialText).
local function etaColor()
	local e = look.etaColor
	if e then
		etaText:SetTextColor(e[1], e[2], e[3], 1)
	else
		local r, g, b = Nav.RGB("text")
		etaText:SetTextColor(r, g, b, 0.8)
	end
end

local function skinStyle() return isSkin(style) end

local function setRotation(a) dialRotate(D, a) end

local function showArrow(on) dialShowArrow(D, on, look) end

-- The distance's colour on the way: text, or the player's (nav.arrowDistColor).
local function travelDistColor()
	local c = look.distColor
	if c then distText:SetTextColor(c[1], c[2], c[3]) else distText:SetTextColor(Nav.RGB("text")) end
end

local function setMode(m)
	if m == mode then return end
	mode = m
	local travel, done, act, idle = m == "travel", m == "arrived" or m == "search", m == "instruction", m == "idle"
	dial:SetShown(travel or done or act or idle)
	grabArea(travel or done or act or idle)
	showArrow(travel)
	dialArrival(D, done, look)
	if act then halo:SetShown(look.glow) end
	legIcon:SetShown(act)
	dialLayout(D, look, not travel or look.distance)
	lastYards, lastEta = nil, nil
	lastDist, closeSpeed = nil, 0
	etaText:Hide()
	if done then
		pulse = 0
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
		halo:SetVertexColor(r, g, b, min(1, 0.45 * look.glowStrength))
		distText:SetTextColor(Nav.RGB("arrowText"))
		distText:SetText(T and T.CurrentLabel() or "")
		local target = Nav.GetTarget()
		labelText:SetText(target and target.label or "")
		etaColor()
	elseif idle then
		-- No target, with nav.arrowNoTarget "dim": a faint ring keeps the
		-- arrow's place on screen.
		local r, g, b = Nav.RGB("textDim")
		local own = skinStyle()
		local t = own and skinRing or ring
		t:SetVertexColor(r, g, b, 0.35)
		ring:SetSize(DIAL, DIAL)
		t:Show()
		distText:SetTextColor(r, g, b)
		distText:SetText(L["No waypoint"])
	else
		travelDistColor()
		etaColor()
		local T = Nav.travel
		if T and T.Active() then labelText:SetText(routeLabel(T)) end
	end
end

local function tint(r, g, b)
	tintR, tintG, tintB = r, g, b
	dialTint(D, r, g, b, look)
end

-- The far colour away, the near colour up close (blend).
local function applyColor(dist, radius)
	local r, g, b, near = blend(style, dist, radius, look)
	D.near = near
	tint(r, g, b)
end

-- nav.arrowStyle changed: swap textures in place, keeping heading and colour.
local function applyStyle(new)
	if new == style then return end
	style = new
	D.style = new
	D.shownFrame = -1
	showArrow(mode == "travel")
	setRotation(curAngle)
	tint(tintR, tintG, tintB)
end

-- The look settings changed (or the theme): the text, where it sits, the
-- glow and the arrival, in place; heading, target and timing stay.
local function applyLook()
	readLook(look)
	dialText(D, look)
	dialLayout(D, look, mode ~= "travel" or look.distance)
	grabArea(grabOnDial)
	etaColor()
	if mode == "travel" then
		showArrow(true)
		tint(tintR, tintG, tintB)
		travelDistColor()
	elseif mode == "arrived" or mode == "search" or mode == "instruction" or mode == "idle" then
		local m = mode
		mode = nil
		setMode(m)
	end
end

-- Shortest Path Forever's own arrow guides while the target is handed to it (Nav/Handoff.lua),
-- TomTom's while it is used and can point at the target (Nav.TomTomArrowGuides).
local function shouldShow()
	return ns.Get("nav.arrow") and not Nav.HiddenWithGuide() and Nav.GetTarget() ~= nil and not Nav.TomTomArrowGuides() and not Nav.HandedOff()
end

-- With no target and nav.arrowNoTarget "dim", the arrow stays as a faint
-- ring (mode "idle") where it would show: not on a taxi or in an instance.
local function idleShown()
	if ns.Get("nav.arrowNoTarget") ~= "dim" or not ns.Get("nav.arrow") or Nav.GetTarget() ~= nil or Nav.HiddenWithGuide() then return false end
	local C = ns.Compat
	if C and ((C.IsInInstance and C.IsInInstance()) or (C.IsOnTaxi and C.IsOnTaxi())) then return false end
	return true
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
		local text = withTargetWarning(target and target.label or "")
		if warning then text = text ~= "" and (text .. "\n" .. warning) or warning end
		labelText:SetText(text)
	end
end

-- One world sample; returns false when the arrow has hidden itself.
local function sample(elapsed)
	if not shouldShow() then
		if idleShown() then
			setMode("idle")
			return true
		end
		frame:Hide()
		return false
	end
	local state, dist, angle, _, _, measured = Nav.Sample()
	if Nav.IsHiddenState(state) then
		frame:Hide()
		return false
	end
	local hint = state == "travel" and Nav.FloorHint and Nav.FloorHint() or nil
	if hint ~= floorShown then
		floorShown = hint
		if hint then
			floorIcon:SetTexture(UI_MEDIA .. (hint == "up" and "chevron-up" or "chevron-down"))
			floorIcon:SetVertexColor(Nav.RGB("text"))
		end
		floorIcon:SetShown(hint ~= nil)
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
		local f = facing()
		local bearing = f and wrap(angle + f) or angle
		if not hasAngle or byBearing ~= (f ~= nil) then
			byBearing = f ~= nil
			curBearing, hasAngle = bearing, true
			curAngle = angle
			setRotation(curAngle)
		end
		goalAngle = bearing
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

frame:SetScript("OnUpdate", ns.Safe(function(_, elapsed)
	-- The faint ring with no target is still: target changes, settings and
	-- zone events bring the arrow back (Refresh).
	if mode == "idle" then return end
	accum = accum + elapsed
	if accum >= SAMPLE_INTERVAL then
		local step = accum
		accum = 0
		if not sample(step) then return end
	end
	if mode == "travel" and hasAngle then
		local diff = wrap(goalAngle - curBearing)
		if abs(diff) > 1e-4 then
			local step = diff * (1 - exp(-elapsed * look.damping))
			local cap = MAX_TURN * elapsed
			if step > cap then step = cap elseif step < -cap then step = -cap end
			curBearing = wrap(curBearing + step)
		end
		local f = byBearing and facing()
		local shown = f and wrap(curBearing - f) or curBearing
		if abs(wrap(shown - curAngle)) > 1e-4 then
			curAngle = shown
			setRotation(curAngle)
		end
	elseif (mode == "arrived" or mode == "search") and look.pulse then
		pulse = pulse + elapsed
		dialPulse(D, pulse)
	end
end))

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

-- Opacity: nav.arrowAlpha, times nav.arrowCombatAlpha in combat.
local inCombat = InCombatLockdown and InCombatLockdown() and true or false
local function applyAlpha()
	local a = clamp(ns.Get("nav.arrowAlpha"), 0.1, 1, 1)
	if inCombat then a = a * clamp(ns.Get("nav.arrowCombatAlpha"), 0, 1, 1) end
	frame:SetAlpha(a)
end
ns.RegisterEvent("PLAYER_REGEN_DISABLED", function() inCombat = true; applyAlpha() end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function() inCombat = false; applyAlpha() end)

function Arrow:OnSettings()
	frame:SetScale(clamp(ns.Get("nav.arrowScale"), 0.5, 2, 1))
	applyAlpha()
	lastYards = nil -- nav.distanceUnit: redraw the distance on the next sample
	showEta = ns.Get("nav.arrowEta") and true or false
	if not showEta and mode == "travel" then etaText:Hide() end
	applyStyle(Arrow.StyleFor(ns.Get("nav.arrowStyle")))
	applyLook()
	applyPosition()
	self:Refresh()
end

-- The style a setting stands for: "skin" takes the skin's.
function Arrow.StyleFor(v)
	if v == "skin" or v == nil then
		local Theme = ns.Theme
		-- A registered skin's own pick first (docs/SKINS-API.md), else the look it extends.
		local own = Theme and Theme.SkinArrowStyle and Theme.SkinArrowStyle()
		if own then return own end
		return SKIN_ARROW[Theme and Theme.SkinKey and Theme.SkinKey() or "polestar"] or "3d"
	end
	if v == "flat" or v == "halo" or v == "hearth" then return v end
	return "3d"
end

function Arrow:OnTheme()
	applyStyle(Arrow.StyleFor(ns.Get("nav.arrowStyle")))
	readLook(look)
	dialText(D, look)
	etaColor()
	mover:SetColorTexture(Nav.Wash("mover"))
	local m = mode
	mode = nil
	if m then setMode(m) end
	local Theme = ns.Theme
	if Theme and Theme.SkinHook then Theme.SkinHook("arrow", frame, style) end
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
	elseif idleShown() then
		frame:Show()
		sample(0)
	end
end

-- The catch-up (the guide window's CATCH_UP): the hourglass in the dial's
-- place, or the arrow back.
function Arrow.SetBusy(on)
	on = on and true or false
	if on == glass:IsShown() then return end
	if on then
		glassTime = 0
		glassBody:SetVertexColor(Nav.RGB("text"))
		glassSand:SetVertexColor(Nav.RGB("arrow"))
	end
	glass:SetShown(on)
	local a = on and 0 or 1
	dial:SetAlpha(a)
	distText:SetAlpha(a)
	labelText:SetAlpha(a)
	etaText:SetAlpha(a)
end

function Arrow.IsBusy()
	return glass:IsShown()
end

ns.On("CATCH_UP", function(on) Arrow.SetBusy(on) end)

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
	if style ~= "3d" or D.shownFrame < 0 then return nil end
	return D.shownFrame
end

---------------------------------------------------------------------------
-- Sandbox dials (the settings' preview and style cards, Nav/ArrowOptions.lua):
-- the same construction and paint as the live arrow, on the caller's frame,
-- with no sampling, target, OnUpdate or Nav hook.
---------------------------------------------------------------------------

Arrow.DIAL, Arrow.WIDTH, Arrow.HEIGHT = DIAL, WIDTH, DIAL + TEXT_H
Arrow.BuildDial = buildDial          -- (parent) -> dial: `parent` is WIDTH x HEIGHT
Arrow.ReadLook = readLook            -- (t) -> t: the look settings as the live arrow reads them
Arrow.PulseDial = dialPulse          -- (dial, seconds): one frame of the arrival's animation

-- Paint a sandbox dial in one state: "travel" (pointing `angle` radians,
-- `dist` yards from a goal of the default radius, with `eta` seconds) or
-- "arrived". `style` as Arrow.StyleFor gives it.
function Arrow.PaintDial(d, lk, s, state, angle, dist, label, eta)
	if s ~= d.style then d.style, d.shownFrame = s, -1 end
	local travel = state == "travel"
	d.dial:Show()
	dialText(d, lk)
	dialLayout(d, lk, not travel or lk.distance)
	dialShowArrow(d, travel, lk)
	dialArrival(d, not travel, lk)
	d.legIcon:Hide()
	if travel then
		local r, g, b, near = blend(s, dist, Nav.DEFAULT_RADIUS or 8, lk)
		d.near = near
		dialRotate(d, angle or 0)
		dialTint(d, r, g, b, lk)
		d.distText:SetText(ns.FormatDistance(floor(dist + 0.5)))
		local c = lk.distColor
		if c then d.distText:SetTextColor(c[1], c[2], c[3]) else d.distText:SetTextColor(Nav.RGB("text")) end
	else
		d.distText:SetTextColor(Nav.RGB("arrowNearText"))
		d.distText:SetText(L["Arrived"])
	end
	d.labelText:SetText(label or "")
	if travel and eta and ns.Get("nav.arrowEta") then
		d.etaText:SetFormattedText("%d:%02d", floor(eta / 60), eta % 60)
		d.etaText:Show()
	else
		d.etaText:Hide()
	end
end

Nav.RegisterModule(Arrow)
