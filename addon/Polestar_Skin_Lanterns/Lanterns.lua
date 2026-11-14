-- Lanterns: a pack of moods for Polestar through its Skin API (docs/skins
-- in the Polestar repository). Ten moods, each a pair of colours: the
-- first tints every ground a little toward it and is the accent, the
-- second answers it from the far corner. Every window is rounded and hangs
-- two soft lights in opposite corners in the mood's pair (the "lanterns");
-- tabs and buttons are pills, the selected tab a pool of light; the
-- progress line runs from one colour into the other.
-- The player picks the mood under the skin's card (Plain has no lights).
--
-- What this skin shows:
--   * `variants`: one skin in ten colourings, each with its tokens;
--   * the `accent2` token (the mood's second colour) and `kit.glow`;
--   * a gradient across the progress line in the `guideProgress` hook;
--   * painters that replace Polestar's square frames with art of the
--     skin's own (a rounded nine-slice, pills), and `shadow` for the window.
-- Nothing here touches Polestar's own files.

local ADDON = ...

local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and (Theme.API_VERSION or 0) >= 2) then return end

local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

---------------------------------------------------------------------------
-- The moods: id, name, the first colour (accent, tint), the second (the
-- far lantern; nil for a mood with no lights), a line for the picker.
---------------------------------------------------------------------------

local MOODS = {
	{ "forge", "Forge", "#ff8a3d", "#ffd36b", "Ember and gold: a warm forge glow." },
	{ "tidepool", "Tidepool", "#3fc8c0", "#4f86ff", "Teal and blue: deep, still water." },
	{ "glade", "Glade", "#6fd36a", "#cfe85a", "Leaf and lime: light through a canopy." },
	{ "hoarfrost", "Hoarfrost", "#8fd6ff", "#ffffff", "Ice and white: a clear winter morning." },
	{ "duskrose", "Dusk Rose", "#ff7aa8", "#8a4fd6", "Rose and plum: the last of the sunset." },
	{ "starfall", "Starfall", "#ffd36b", "#5b6cff", "Gold and indigo: a meteor over the sea." },
	{ "ashen", "Ashen", "#b8b2aa", "#6f6a66", "Warm greys: embers gone cold." },
	{ "highsun", "Highsun", "#ffd93d", "#ff8c3d", "Yellow and orange: noon on the plains." },
	{ "gloam", "Gloam", "#9b6cff", "#3fc8c0", "Violet and teal: the hour after dusk." },
	{ "plain", "Plain", "#d9d9e0", nil, "Neutral, no lights: just the grounds." },
}

-- "#rrggbb" -> r, g, b in 0-1.
local function rgb(hex)
	return tonumber(hex:sub(2, 3), 16) / 255, tonumber(hex:sub(4, 5), 16) / 255, tonumber(hex:sub(6, 7), 16) / 255
end

-- `base` moved `k` of the way toward `toward`, as a colour table.
local function tint(base, toward, k, alpha)
	local r, g, b = rgb(base)
	local tr, tg, tb = rgb(toward)
	return { r + (tr - r) * k, g + (tg - g) * k, b + (tb - b) * k, alpha or 1 }
end

-- A mood's tokens: every ground tinted a little toward its first colour,
-- the pair as accent and accent2, the first on the pins' rims and the
-- arrow's glow.
local function moodTokens(a, second)
	return {
		bg = tint("#0b0c12", a, 0.1, 0.97), panel = tint("#10121a", a, 0.1, 0.98), panelAlt = tint("#161925", a, 0.1),
		sidebar = tint("#07080c", a, 0.08), footer = tint("#090a10", a, 0.08), sky = tint("#141626", a, 0.16),
		text = tint("#f6f6fa", a, 0.04), textDim = tint("#c4c6d4", a, 0.06), textMuted = tint("#979aac", a, 0.08),
		ink = tint("#ffffff", a, 0.15), star = tint("#ffffff", a, 0.3), shade = "#000004", scrim = tint("#04050a", a, 0.1),
		onAccent = "#0b0c12", shadow = "#00000499",
		accent = a, accent2 = second or a, pinRing = a, glow = a,
	}
end

---------------------------------------------------------------------------
-- The lights: two soft radial glows, the first colour at the top left and
-- the second at the bottom right, added to the ground. None in Plain
-- (accent2 equal to the accent).
---------------------------------------------------------------------------

local function pair()
	local r, g, b = Theme.Accent()
	local r2, g2, b2 = Theme.Color("accent2")
	local same = math.abs(r - r2) + math.abs(g - g2) + math.abs(b - b2) < 0.01
	return { r, g, b, 1 }, not same and { r2, g2, b2, 1 } or nil
end

local function lights(frame, kit)
	local own = kit.store(frame)
	local first, second = pair()
	if not second then
		if own.lit then
			for _, k in ipairs({ "glow:near", "glow:far" }) do if own[k] then own[k]:Hide() end end
			own.lit = nil
		end
		return
	end
	-- Each light is the quarter of a radial glow that has its centre in the
	-- window's corner, spread over that corner's quarter of the window: the
	-- brightest at the corner, gone by the middle, nothing outside the
	-- window, and it follows the window as it is resized. Over the band's
	-- sky and stars (Theme.Band's BACKGROUND -5 and -4), under the rest.
	first[4], second[4] = 0.24, 0.2
	local near = kit.glow(frame, { key = "near", color = first, layer = "BACKGROUND", sub = -3 })
	near:ClearAllPoints()
	near:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
	near:SetPoint("BOTTOMRIGHT", frame, "CENTER", 0, 0)
	near:SetTexCoord(0.5, 1, 0.5, 1)
	local far = kit.glow(frame, { key = "far", color = second, layer = "BACKGROUND", sub = -3 })
	far:ClearAllPoints()
	far:SetPoint("TOPLEFT", frame, "CENTER", 0, 0)
	far:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
	far:SetTexCoord(0, 0.5, 0, 0.5)
	own.lit = true
end

---------------------------------------------------------------------------
-- Rounded frames: the window and the panels as a nine-slice of the skin's
-- own rounded corner (Media/corner, corner-rim: a 16-unit radius), filled
-- with the ground and edged with the window border's colour, in place of
-- Polestar's square ground. Tabs and buttons are pills (Media/cap, cap-rim):
-- the selected tab a pool of the mood's light, its glow spilling below it.
---------------------------------------------------------------------------

local HOME = "Interface\\AddOns\\" .. ADDON .. "\\Media\\"
local WHITE = Theme.Media("white")
local R = 12 -- the corner's radius, in units

-- Texture coordinates of the top-left corner art turned to each corner.
local CORNER = {
	TOPLEFT = { 0, 1, 0, 1 }, TOPRIGHT = { 1, 0, 0, 1 }, BOTTOMLEFT = { 0, 1, 1, 0 }, BOTTOMRIGHT = { 1, 0, 1, 0 },
}

-- The nine pieces of a rounded rectangle on `frame`, kept in its store
-- under `key`: corners from `art`, the edges and the middle plain. With
-- `rim`, only the outline: the corners' rim art and one-unit edges.
local function rounded(frame, kit, key, art, rim, layer, sub)
	local own = kit.store(frame)
	local set = own[key]
	if not set then
		set = {}
		local function tex(file)
			local t = frame:CreateTexture(nil, layer, nil, sub)
			t:SetTexture(file)
			set[#set + 1] = t
			return t
		end
		for corner, tc in pairs(CORNER) do
			local t = tex(HOME .. art)
			t:SetSize(R, R)
			t:SetPoint(corner, frame, corner, 0, 0)
			t:SetTexCoord(tc[1], tc[2], tc[3], tc[4])
		end
		local function edge(p1, x1, y1, p2, x2, y2, w, h)
			local t = tex(WHITE)
			t:SetPoint(p1, frame, p1, x1, y1)
			t:SetPoint(p2, frame, p2, x2, y2)
			if w then t:SetWidth(w) end
			if h then t:SetHeight(h) end
		end
		local line = rim and 1 or nil
		-- Top and bottom between the corners, left and right between them.
		edge("TOPLEFT", R, 0, "TOPRIGHT", -R, 0, nil, line or R)
		edge("BOTTOMLEFT", R, 0, "BOTTOMRIGHT", -R, 0, nil, line or R)
		edge("TOPLEFT", 0, -R, "BOTTOMLEFT", 0, R, line or R, nil)
		edge("TOPRIGHT", 0, -R, "BOTTOMRIGHT", 0, R, line or R, nil)
		if not rim then
			local t = tex(WHITE)
			t:SetPoint("TOPLEFT", frame, "TOPLEFT", R, -R)
			t:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -R, R)
		end
		own[key] = set
	end
	return set
end

local function tintAll(set, r, g, b, a)
	for _, t in ipairs(set) do
		t:SetVertexColor(r, g, b, a)
		t:Show()
	end
end

-- The ground's colour and opacity as Polestar would paint this frame: a
-- menu or popup over other frames (psMenu) on menuBg, never see-through; a
-- window (token "bg") in its own colour and at the window opacity, as the
-- house paints windows; any other panel in its token as it is, so the
-- window opacity leaves the cards and panels alone.
local function ground(frame, token)
	if frame.psMenu then return Theme.Color("menuBg") end
	local r, g, b, a = Theme.Color(token)
	if token ~= "bg" then return r, g, b, a end
	local c = frame.psBgColor
	if c then r, g, b = c[1], c[2], c[3] end
	local alpha = frame.psBgAlpha or (Theme.GroundAlpha and Theme.GroundAlpha()) or a or 1
	return r, g, b, alpha
end

-- A window or a panel: rounded ground and rim, then the mood's lights.
local function roundFrame(token)
	return function(frame, base, kit)
		if frame.psBare then return kit.bare(frame) end
		tintAll(rounded(frame, kit, "ground", "corner", false, "BACKGROUND", -7), ground(frame, token))
		local er, eg, eb, ea = Theme.Color("windowBorder")
		if frame.psNoBorder then ea = 0 end
		tintAll(rounded(frame, kit, "rim", "corner-rim", true, "BORDER", -1), er, eg, eb, (ea or 1) * 0.9)
		lights(frame, kit)
	end
end

-- A pill on `frame` (a capsule as tall as the frame), fill or rim.
local function pill(frame, kit, key, rim, layer, sub)
	local own = kit.store(frame)
	local set = own[key]
	if not set then
		set = {}
		local h = frame:GetHeight() or 0
		local w = h > 0 and math.max(4, math.floor(h / 2)) or 10
		local l = frame:CreateTexture(nil, layer, nil, sub)
		l:SetTexture(HOME .. (rim and "cap-rim" or "cap"))
		l:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		l:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
		l:SetWidth(w)
		local r = frame:CreateTexture(nil, layer, nil, sub)
		r:SetTexture(HOME .. (rim and "cap-rim" or "cap"))
		r:SetTexCoord(1, 0, 0, 1)
		r:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
		r:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
		r:SetWidth(w)
		set[1], set[2] = l, r
		local function mid(p1, p2, y)
			local t = frame:CreateTexture(nil, layer, nil, sub)
			t:SetTexture(WHITE)
			t:SetPoint(p1, l, p1 == "TOPLEFT" and "TOPRIGHT" or "BOTTOMRIGHT", 0, 0)
			t:SetPoint(p2, r, p2 == "TOPRIGHT" and "TOPLEFT" or "BOTTOMLEFT", 0, 0)
			if y then t:SetHeight(1) end
			set[#set + 1] = t
		end
		if rim then
			mid("TOPLEFT", "TOPRIGHT", 1)
			mid("BOTTOMLEFT", "BOTTOMRIGHT", 1)
		else
			local t = frame:CreateTexture(nil, layer, nil, sub)
			t:SetTexture(WHITE)
			t:SetPoint("TOPLEFT", l, "TOPRIGHT", 0, 0)
			t:SetPoint("BOTTOMRIGHT", r, "BOTTOMLEFT", 0, 0)
			set[3] = t
		end
		own[key] = set
	end
	return set
end

-- A button or a dropdown: Polestar paints it, then its square ground and
-- border give way to a pill with a rim: the accent for a primary button
-- (frame.psPrimary), a faint red for a danger one, else the control colour.
local function pillButton(frame, base, kit)
	base(frame)
	kit.fill(frame):Hide()
	kit.hideBorder(frame)
	local r, g, b, a, er, eg, eb, ea
	if frame.psPrimary then
		r, g, b = Theme.Accent()
		a, er, eg, eb, ea = 1, r, g, b, 1
	elseif frame.psDanger then
		r, g, b = Theme.Color("danger")
		a, er, eg, eb, ea = 0.1, r, g, b, 0.5
	else
		r, g, b, a = Theme.Color("panelAlt")
		er, eg, eb = Theme.Color("windowBorder")
		ea = 0.55
	end
	tintAll(pill(frame, kit, "pill", false, "BACKGROUND", 1), r, g, b, a or 1)
	tintAll(pill(frame, kit, "pillRim", true, "BORDER", 1), er, eg, eb, ea)
end

-- A tab: nothing at rest; selected, a pill of the mood's first colour at a
-- quarter, its rim at full and a pool of light below it.
local function pillTab(frame, base, kit)
	local own = kit.store(frame)
	local ar, ag, ab = Theme.Accent()
	local on = frame.psSelected and true or false
	local fill = pill(frame, kit, "pill", false, "BACKGROUND", 1)
	local rim = pill(frame, kit, "pillRim", true, "BORDER", 1)
	if on then
		tintAll(fill, ar, ag, ab, 0.2)
		tintAll(rim, ar, ag, ab, 0.85)
		local w, h = frame:GetWidth() or 60, frame:GetHeight() or 20
		own.pool = kit.glow(frame, { key = "pool", point = "BOTTOM", offset = { 0, -2 }, size = { w * 1.4, h * 1.6 },
			color = { ar, ag, ab, 0.3 }, layer = "BACKGROUND", sub = 0 })
	else
		for _, t in ipairs(fill) do t:Hide() end
		for _, t in ipairs(rim) do t:Hide() end
		if own["glow:pool"] then own["glow:pool"]:Hide() end
	end
	kit.hoverWash(frame)
end

-- The progress line's fill: the first colour into the second.
local function duotone(t)
	if not (t and t.SetGradient and CreateColor) then return end
	local first, second = pair()
	if not second then return end
	t:SetVertexColor(1, 1, 1, 1)
	t:SetGradient("HORIZONTAL", CreateColor(first[1], first[2], first[3], 1), CreateColor(second[1], second[2], second[3], 1))
end

-- The guide window's own tabs (the guideTab hook, where Polestar has it):
-- the house wash and line give way to the pill and its pool of light.
local function guideTab(button, parts, active)
	local kit = Theme.SkinKit
	if not (kit and kit.store) then return end
	local own = kit.store(button)
	local fill = pill(button, kit, "pill", false, "BACKGROUND", 1)
	local rim = pill(button, kit, "pillRim", true, "BORDER", 1)
	if parts.selected then parts.selected:Hide() end
	if parts.bar then parts.bar:Hide() end
	if active then
		local ar, ag, ab = Theme.Accent()
		tintAll(fill, ar, ag, ab, 0.2)
		tintAll(rim, ar, ag, ab, 0.85)
		own.pool = kit.glow(button, { key = "pool", point = "BOTTOM", offset = { 0, -2 }, size = { 150, 40 },
			color = { ar, ag, ab, 0.3 }, layer = "BACKGROUND", sub = 0 })
	else
		for _, t in ipairs(fill) do t:Hide() end
		for _, t in ipairs(rim) do t:Hide() end
		if own["glow:pool"] then own["glow:pool"]:Hide() end
	end
end

-- A frame of the skin's own over a card or a toast, above its parts (their
-- grounds would hide what the skin draws on the frame itself), never taking
-- the mouse; kept in the frame's store so another skin hides it.
local function overlay(frame)
	local kit = Theme.SkinKit
	local own = kit.store(frame)
	local o = own.overlay
	if not o then
		o = CreateFrame("Frame", nil, frame)
		o:SetAllPoints(frame)
		if o.EnableMouse then o:EnableMouse(false) end
		own.overlay = o
	end
	o:SetFrameLevel((frame:GetFrameLevel() or 0) + 20)
	o:Show()
	return o, kit.store(o)
end

local function hasHooks(...)
	if not Theme.HasCapability then return false end
	for i = 1, select("#", ...) do
		if not Theme.HasCapability("surfaces." .. select(i, ...)) then return false end
	end
	return true
end

-- Cards and toasts: a lantern hung over them, a pool of the mood's first
-- colour falling from the top left corner onto their parts, added as light.
local function lantern(frame)
	local first = pair()
	local o = overlay(frame)
	first[4] = 0.28
	local pool = Theme.SkinKit.glow(o, { key = "lantern", color = first, layer = "OVERLAY", sub = 0 })
	pool:ClearAllPoints()
	pool:SetPoint("TOPLEFT", o, "TOPLEFT", 0, 0)
	pool:SetSize(math.min(frame:GetWidth() or 200, 180), math.min(frame:GetHeight() or 80, 70))
	pool:SetTexCoord(0.5, 1, 0.5, 1)
end

local HOOKS = {
	guideProgress = function(foot) duotone(foot.Line and foot.Line.Fill) end,
	-- The house band is square: it would cut the window's rounded top.
	guideTitle = function(nav, parts) if parts.band then parts.band:Hide() end end,
}
if hasHooks("guideTab") then HOOKS.guideTab = guideTab end
if hasHooks("card", "toast") then
	HOOKS.card = function(frame) lantern(frame) end
	HOOKS.toast = function(frame) lantern(frame) end
end

local variants = {}
for _, m in ipairs(MOODS) do
	variants[#variants + 1] = { id = m[1], name = m[2], desc = m[5], tokens = moodTokens(m[3], m[4]) }
end

check("skin lanterns", Theme.RegisterSkin("lanterns", {
	api = 2,
	name = "Lanterns",
	addon = ADDON,
	author = "Polestar",
	desc = "Ten moods, each a pair of colours: tinted grounds, two soft lights in opposite corners, a two-tone progress line.",
	base = "polestar",
	tokens = moodTokens(MOODS[1][3], MOODS[1][4]),
	variants = variants,
	defaultVariant = "forge",
	paint = { window = roundFrame("bg"), panel = roundFrame("panel"), button = pillButton, dropdown = pillButton, tab = pillTab },
	hooks = HOOKS,
	-- The rounded window paints no square ground; its shadow is the skin's.
	shadow = { size = 26, drop = 6 },
	arrow = "3d",
	mapIcons = "polestar",
	preset = { ["ui.band"] = false, ["ui.haze"] = false, ["ui.shadow"] = true, ["guideWindow.padding"] = 4 },
}))
