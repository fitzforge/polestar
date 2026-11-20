-- The ground trail's introduction: a window in Install's look
-- (UI/Welcome.lua's building blocks), 600 wide and centred, that says what
-- the ground trail is and lets a player try it. One page: a compact night
-- hero (the band, the haze, the Dipper and the emblem on the right) with
-- "Ground trail" and a line on what it is; the trail's switch with its
-- description inline (nav.worldTrail, off until the player turns it on),
-- a Beta chip beside the title and a paragraph on what the trail does to
-- the game's waypoint while it is on;
-- four looks as cards (WorldTrail.QUICK), each a small preview of that look
-- along one gentle path from the player's mark to the goal's, applied at a
-- click; a line on where the rest is; a footer with "Change it later with
-- /polestar trail" on the left, "Trail settings" and "Got it" on the right.
-- Nothing here turns the trail on but its switch, and closing leaves every
-- setting as it is.
--
-- It never opens by itself. The Ground trail page's "Introduction" row and
-- /polestar trail intro (SHOW_TRAIL_INTRO) open it, at once out of combat;
-- asked for in a fight or during a cinematic, it opens when that ends.
--
-- The previews drift toward the goal only while they show (an OnUpdate, 20
-- times a second, moves the textures made once) and hold still under
-- ui.reduceMotion. Built on first use; colours are Theme tokens and the
-- trail's own sparkle colours.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, min, sin, sqrt = math.floor, math.max, math.min, math.sin, math.sqrt

local TI = {}
UI.WorldTrailIntro = TI

local GAP, PREVIEW_H, NAME_H = 12, 56, 24
local ROW_PAD = 11
local MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Nav\\"

local F
local asked -- asked for in a fight or during a cinematic: it opens when that ends

-- Only with the trail itself (Nav/WorldTrail.lua) and Install's building blocks.
local function available()
	return ns.WorldTrail ~= nil and ns.GetDefault("nav.worldTrail") ~= nil
		and UI.Welcome ~= nil and UI.Welcome.Kit ~= nil
end

local function inCinematic()
	return (InCinematic and InCinematic()) or (IsInCinematicScene and IsInCinematicScene()) or false
end

local function close()
	if F then F:Hide() end
end

local function openSettings()
	close()
	ns.Fire("SHOW_OPTIONS", "groundtrail")
end

---------------------------------------------------------------------------
-- A look's preview
---------------------------------------------------------------------------

-- The look's sparkles along one gentle path across the card's ground, from
-- the player's mark to the goal's. The path stands for YARDS of route, so a
-- look's reach, how far ahead of the player it starts and its spacing show
-- to scale; the width at the feet narrowing into the route, the fade toward
-- the far end, the sparkle's size and colour, the drift toward the goal and
-- the twinkle are the look's own, reckoned as the painter reckons them
-- (Maps/WorldTrailRender.lua), a few glints to a row at most.
local PATH = { 0.06, 0.80, 0.22, 0.56, 0.40, 0.46, 0.58, 0.60, 0.74, 0.62, 0.88, 0.40, 0.95, 0.22 } -- x, y fractions
local POINTS = #PATH / 2
local YARDS = 40
local MAX_ROWS, MAX_MARKS = 22, 44
local MIN_SPACING = 3.5 -- px between rows, at least
local FLOW, TICK = 16, 1 / 20 -- px a second at full flow; the previews' pace

local function pathPoint(c, i)
	return PATH[i * 2 - 1] * c.psW, PATH[i * 2] * PREVIEW_H
end

local function pathLength(c)
	local total = 0
	local ax, ay = pathPoint(c, 1)
	for i = 2, POINTS do
		local bx, by = pathPoint(c, i)
		total = total + sqrt((bx - ax) ^ 2 + (by - ay) ^ 2)
		ax, ay = bx, by
	end
	return total
end

-- The point `d` px along the path, and the path's direction there.
local function along(c, d)
	local ax, ay = pathPoint(c, 1)
	local tx, ty = 1, 0
	for i = 2, POINTS do
		local bx, by = pathPoint(c, i)
		local len = sqrt((bx - ax) ^ 2 + (by - ay) ^ 2)
		if len > 0 then tx, ty = (bx - ax) / len, (by - ay) / len end
		if d <= len or i == POINTS then
			local t = len > 0 and min(1, d / len) or 0
			return ax + (bx - ax) * t, ay + (by - ay) * t, tx, ty
		end
		d = d - len
		ax, ay = bx, by
	end
	return ax, ay, tx, ty
end

-- A steady number in -1..1 for glint `id`, so a glint keeps its place beside
-- the path as it drifts.
local function scatter(id, salt)
	local v = sin(id * 12.9898 + salt * 78.233) * 43758.5453
	return (v - floor(v)) * 2 - 1
end

local function mark(c, i)
	local t = c.Marks[i]
	if not t then
		t = c.Look:CreateTexture(nil, "ARTWORK", nil, 1)
		t:SetTexture(MEDIA .. "sparkle")
		t:SetBlendMode("ADD")
		c.Marks[i] = t
	end
	return t
end

local function drawLook(c, now)
	local T = ns.WorldTrail
	local look = T and T.PRESETS[c.psLook]
	if not (look and c.psW) then return end
	local still = Anim and Anim.Reduced and Anim.Reduced() or false
	local scale = c.psLength / YARDS
	local reach = min(c.psLength, look.groundLength * scale)
	local start = min(reach, look.groundAhead * scale)
	local spacing = max(MIN_SPACING, look.groundGap * scale)
	local rows = floor((reach - start) / spacing) + 1
	if rows > MAX_ROWS then
		rows = MAX_ROWS
		spacing = (reach - start) / (MAX_ROWS - 1)
	end
	local flowing = not still and look.speed > 0
	local travel = flowing and now * FLOW * look.speed or 0
	local base, shift = floor(travel / spacing), travel % spacing
	local rgb = T.ColorOf(look.color).rgb
	local size = max(6, min(14, look.size * 0.75 * (1 - 0.3 * look.subtlety)))
	local twinkle = still and 0 or 0.5 * (1 - 0.6 * look.subtlety)
	local used = 0
	for k = 0, rows - 1 do
		local d = start + k * spacing + shift
		if d > reach then break end
		local u = reach > 0 and d / reach or 0
		local x, y, tx, ty = along(c, d)
		local half = look.groundWidth * scale * (1 - u) * (1 - u)
		local extra = min(2, floor(look.groundWidth * 2.5 * (1 - u) + 0.5))
		local fade = 1 - look.groundFade * u
		if flowing then
			-- A glint comes in at the near end and goes out at the far one.
			fade = fade * min(1, (d - start) / spacing + 0.25) * min(1, (reach - d) / spacing + 0.1)
		end
		for j = 0, extra do
			if used >= MAX_MARKS then break end
			local id = (k - base) * 7 + j
			local off = scatter(id, 1) * half * (j == 0 and 0.35 or 1)
			local slip = j == 0 and 0 or scatter(id, 2) * spacing * 0.4
			local alpha = look.intensity * fade * (1 - twinkle * (0.5 + 0.5 * sin(now * 3 + id * 1.7)))
			used = used + 1
			local t = mark(c, used)
			local s = size * (j == 0 and 1 or 0.8)
			t:SetSize(s, s)
			t:SetVertexColor(rgb[1], rgb[2], rgb[3], 1)
			t:SetAlpha(max(0, min(1, alpha)))
			t:ClearAllPoints()
			t:SetPoint("CENTER", c.Look, "TOPLEFT", x - ty * off + tx * slip, -(y + tx * off + ty * slip))
			t:Show()
		end
	end
	for i = used + 1, #c.Marks do c.Marks[i]:Hide() end
	c.psUsed = used
end

local function tick(self, elapsed)
	local c = self:GetParent()
	c.psElapsed = (c.psElapsed or 0) + elapsed
	if c.psElapsed < TICK then return end
	c.psElapsed = 0
	drawLook(c, GetTime and GetTime() or 0)
end

---------------------------------------------------------------------------
-- The look cards and the switch
---------------------------------------------------------------------------

local function solid(parent, layer, sub)
	local t = parent:CreateTexture(nil, layer or "BACKGROUND", nil, sub or 0)
	t:SetTexture(Theme.Media("white"))
	return t
end

-- A frame's 1px outline, as Install's cards have it.
local function outline(c)
	c.psEdge = {}
	for i, pts in ipairs({ { "TOPLEFT", "TOPRIGHT" }, { "BOTTOMLEFT", "BOTTOMRIGHT" }, { "TOPLEFT", "BOTTOMLEFT" }, { "TOPRIGHT", "BOTTOMRIGHT" } }) do
		local e = solid(c, "BORDER", 2)
		e:SetPoint(pts[1], c, pts[1], 0, 0)
		e:SetPoint(pts[2], c, pts[2], 0, 0)
		c.psEdge[i] = e
	end
end

local function paintOutline(c, r, g, b, a)
	local px = Theme.Pixel(c)
	for i = 1, 4 do
		local e = c.psEdge[i]
		if i <= 2 then e:SetHeight(px) else e:SetWidth(px) end
		e:SetVertexColor(r, g, b, a)
	end
end

-- The card in the theme's colours, its preview drawn for its width; the look
-- in use in a 1px accent outline. The preview is a piece of the ground in the
-- world, where the trail is light: a dark look's sidebar stands for it, and a
-- light look (Vellum's paper) keeps the game tooltip's dark ground under it
-- (Theme.TIP_GROUND), the two marks in colours that read there
-- (Theme.TipColor), so the sparkles show in every look.
local function paintCard(c)
	if not c.psW then return end
	local light = Theme.IsLightPalette(Theme.Palette())
	if light then
		local ground = Theme.TIP_GROUND
		c.Ground:SetVertexColor(ground[1], ground[2], ground[3], 1)
	else
		c.Ground:SetVertexColor(Theme.Color("sidebar"))
	end
	local sx, sy = pathPoint(c, 1)
	c.Start:ClearAllPoints()
	c.Start:SetPoint("CENTER", c.Look, "TOPLEFT", sx, -sy)
	if light then c.Start:SetVertexColor(Theme.TipColor("text")) else c.Start:SetVertexColor(Theme.Color("text")) end
	local gx, gy = pathPoint(c, POINTS)
	c.Goal:ClearAllPoints()
	c.Goal:SetPoint("CENTER", c.Look, "TOPLEFT", gx, -gy)
	if light then c.Goal:SetVertexColor(Theme.TipColor("accent")) else c.Goal:SetVertexColor(Theme.Accent()) end
	drawLook(c, GetTime and GetTime() or 0)
	local on = ns.WorldTrail ~= nil and ns.WorldTrail.CurrentLook() == c.psLook
	c.psSelected = on
	if on then
		local ar, ag, ab = Theme.Accent()
		paintOutline(c, ar, ag, ab, 1)
	else
		paintOutline(c, Theme.Wash("border"))
	end
	W.Color(c.Name, on and "text" or "textDim")
end

-- A click applies the look; right-click puts the default look back. Neither
-- turns the trail on.
local function lookCard(p, name)
	local T = ns.WorldTrail
	local info = T.LOOK_INFO[name]
	local c = CreateFrame("Button", nil, p)
	W.Hover(c)
	outline(c)
	c.psLook = name
	c.Look = CreateFrame("Frame", nil, c)
	c.Look:SetPoint("TOPLEFT", c, "TOPLEFT", 5, -5)
	c.Look:SetPoint("TOPRIGHT", c, "TOPRIGHT", -5, -5)
	c.Look:SetHeight(PREVIEW_H)
	if c.Look.SetClipsChildren then c.Look:SetClipsChildren(true) end
	c.Ground = solid(c.Look, "BACKGROUND", 0)
	c.Ground:SetAllPoints(c.Look)
	c.Marks = {}
	c.Start = W.Tex(c.Look, "OVERLAY", "circle", nil, 0)
	c.Start:SetSize(7, 7)
	c.Goal = W.Tex(c.Look, "OVERLAY", "circle", nil, 0)
	c.Goal:SetSize(10, 10)
	c.Name = W.Text(c, "label", "textDim")
	c.Name:SetPoint("TOPLEFT", c.Look, "BOTTOMLEFT", 3, 0)
	c.Name:SetPoint("TOPRIGHT", c.Look, "BOTTOMRIGHT", -3, 0)
	c.Name:SetHeight(NAME_H)
	c.Name:SetJustifyH("LEFT")
	c.Name:SetWordWrap(false)
	c.Name:SetText(info.label)
	c:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	c:SetScript("OnClick", function(self, button)
		T.ApplyPreset(button == "RightButton" and T.LOOKS[1] or self.psLook)
	end)
	c:SetScript("OnEnter", function(self) W.Tooltip(self, "ANCHOR_TOP", info.label, { info.note }) end)
	c:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	c.Look:SetScript("OnUpdate", tick)
	return c
end

-- The trail's switch with its description under the label, not only in the
-- tooltip, as Install's rows have theirs: the row reaches 12px past
-- the page's edge on both sides, so the label and the switch sit on it.
local function switchRow(p, K, label, desc)
	local textW = K.CW - 30 - 24
	local row = W.Toggle(p, label, "nav.worldTrail", desc)
	row:SetWidth(K.CW + 24)
	row.Desc = K.para(row, "note", "textMuted", textW, 3)
	row.Desc:SetText(desc)
	row.Track:ClearAllPoints()
	row.Track:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	row.Label:ClearAllPoints()
	row.Label:SetPoint("TOPLEFT", row, "TOPLEFT", 12, -ROW_PAD)
	row.Label:SetWidth(textW)
	row.Label:SetWordWrap(true)
	row.Desc:SetPoint("TOPLEFT", row.Label, "BOTTOMLEFT", 0, -3)
	row.Rule:ClearAllPoints()
	row.Rule:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 12, 0)
	row.Rule:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", -12, 0)
	return row
end

---------------------------------------------------------------------------
-- The window
---------------------------------------------------------------------------

local function build()
	local K = UI.Welcome.Kit
	local T = ns.WorldTrail
	F = CreateFrame("Frame", "PolestarTrailIntro", ns.UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(K.WIDTH)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	F:Hide()
	Theme.Skin(F, "window")
	local function drag(frame) ns.DragWindow(frame, F) end
	drag(F)

	-- The hero: the night, the Dipper and the emblem on the right, the title
	-- and its line on the 32 edge. It drags the window.
	local h = CreateFrame("Frame", nil, F)
	h:SetWidth(K.INNER)
	Anim.Anchor(h, "TOPLEFT", F, "TOPLEFT", 1, -1)
	if h.SetClipsChildren then h:SetClipsChildren(true) end
	drag(h)
	h.Sky = CreateFrame("Frame", nil, h)
	h.Sky:SetAllPoints(h)
	h.Night = K.night(h, h.Sky, 160, { haze = 0.8, band = 0.6, bottom = "bg" })
	K.dipper(h.Sky, 400, 52, 0.62, -8)
	K.emblem(h.Sky, 40, K.SIDE_X, K.SIDE_Y, 120, 44)
	h.Title = K.para(h.Sky, "hero", "text", K.CHERO_TEXT_W, 2)
	h.Title:SetText(L["Ground trail"])
	h.Chip = W.Chip(h.Sky)
	W.SetChip(h.Chip, ns.Upper(L["Beta"]), "warning")
	h.Sub = K.para(h.Sky, "body", "textDim", K.CHERO_TEXT_W, 3)
	h.Sub:SetText(L["Optional sparkles on the ground ahead of you, along your route."])
	F.Hero = h

	-- The page on the 32 edge: the switch, then the looks.
	local p = CreateFrame("Frame", nil, F)
	p:SetWidth(K.CW)
	p:SetHeight(1)
	F.Body = p
	F.Switch = switchRow(p, K, L["Show a ground trail"],
		L["It follows the route the arrow walks you. Where it lies on the ground is an estimate, so now and then it floats or sinks a little. Off until you turn it on."])
	-- What it costs while it is on, said here and not left to a tooltip.
	p.Cost = K.para(p, "note", "textMuted", K.CW, 3)
	p.Cost:SetText(L["Beta. The game does not tell an addon how the camera is tilted, so while the trail is on Polestar sets the game's waypoint where the route leads and reads the angle from its marker. That marker takes the place of the game's quest marker and of a map pin of your own, and quests you accept meanwhile are not tracked by the game. You can switch that off in Settings, Ground trail; the trail is then drawn short once you have moved the camera."])
	p.LookTitle = K.para(p, "body", "text", K.CW, 2)
	p.LookTitle:SetText(L["Look"])
	p.LookNote = K.para(p, "note", "textMuted", K.CW, 3)
	p.LookNote:SetText(L["Four to start from. A click applies one; right-click puts %s back."]:format(T.LOOK_INFO[T.LOOKS[1]].label))
	F.Cards = {}
	for i, name in ipairs(T.QUICK) do F.Cards[i] = lookCard(p, name) end
	p.More = K.para(p, "note", "textMuted", K.CW, 3)
	p.More:SetText(L["More looks, a look of your own and every slider are in Settings, Ground trail."])

	-- The ✕.
	F.Close = W.IconButton(F, "close", 28, L["Close"], close, 12)
	F.Close:SetPoint("TOPRIGHT", F, "TOPRIGHT", -12, -12)
	F.Close:SetFrameLevel(F:GetFrameLevel() + 40)
	W.FrameClose(F, F.Close)

	-- The footer: the command on the left, the buttons on the right.
	local foot = CreateFrame("Frame", nil, F)
	foot:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 1, 1)
	foot:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -1, 1)
	foot:SetHeight(K.FOOT_H)
	foot:SetFrameLevel(F:GetFrameLevel() + 30)
	W.Fill(foot, "footer")
	local rule = W.Divider(foot)
	rule:SetPoint("TOPLEFT", foot, "TOPLEFT", 0, 0)
	rule:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 0)
	F.Foot = foot
	F.Hint = W.Text(foot, "note", "textMuted")
	F.Hint:SetPoint("LEFT", foot, "LEFT", K.FOOT_PAD, 0)
	F.GotIt = W.Button(foot, L["Got it"], close, { primary = true })
	F.GotIt:SetPoint("RIGHT", foot, "RIGHT", -K.FOOT_PAD, 0)
	F.Settings = W.Button(foot, L["Trail settings"], openSettings)
	F.Settings:SetPoint("RIGHT", F.GotIt, "LEFT", -8, 0)

	if W.Rim then F.Rim = W.Rim(F) end
	F:SetScript("OnShow", function(self)
		Anim.To(self, "alpha", 0, 1, Anim.BASE, "out")
		Anim.Anchor(h, "TOPLEFT", F, "TOPLEFT", 1, -1)
		Anim.To(h, "alpha", 0, 1, Anim.BASE, "out")
		Anim.To(h, "offset", -8, 0, Anim.BASE, "out")
	end)
	ns.CloseOnEscape("PolestarTrailIntro")
	TI.frame = F
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(F, {
			initial = function(rows)
				for i, w in ipairs(rows) do if w == F.GotIt then return i end end
			end,
			-- A look's card: Y puts the default look back.
			reset = function(w)
				if w and w.psLook then
					w:Click("RightButton")
					return true
				end
			end,
			resetLabel = function(w) return w.psLook and L["Default"] or nil end,
		})
	end
end

-- Lays the page out in the current language and font; the window takes its height.
local function render()
	local K = UI.Welcome.Kit
	local h, p = F.Hero, F.Body
	K.place(h.Title, K.EDGE, 40)
	h.Chip:ClearAllPoints()
	h.Chip:SetPoint("LEFT", h.Title, "TOPLEFT", math.ceil(W.TextWidth(h.Title)) + 10, -floor(h.Title:GetStringHeight() / 2))
	local y = 40 + h.Title:GetStringHeight() + 8
	K.place(h.Sub, K.EDGE, y)
	local heroH = max(112, y + h.Sub:GetStringHeight() + 22)
	h:SetHeight(heroH)

	local row = F.Switch
	y = 0
	K.place(row, -12, y)
	row:Refresh()
	local rh = ROW_PAD + row.Label:GetStringHeight() + 3 + row.Desc:GetStringHeight() + ROW_PAD
	row:SetHeight(rh)
	y = y + rh + 10
	K.place(p.Cost, 0, y)
	y = y + p.Cost:GetStringHeight() + 16
	K.place(p.LookTitle, 0, y)
	y = y + p.LookTitle:GetStringHeight() + 4
	K.place(p.LookNote, 0, y)
	y = y + p.LookNote:GetStringHeight() + 10
	local n = #F.Cards
	local cw = floor((K.CW - GAP * (n - 1)) / n)
	for i, c in ipairs(F.Cards) do
		c:SetSize(cw, 5 + PREVIEW_H + NAME_H)
		c.psW = cw - 10
		c.psLength = pathLength(c)
		K.place(c, (i - 1) * (cw + GAP), y)
		if not c.psPainted then
			c.psPainted = true
			W.Painter(c, paintCard)
		else
			paintCard(c)
		end
	end
	y = y + 5 + PREVIEW_H + NAME_H + 12
	K.place(p.More, 0, y)
	y = y + p.More:GetStringHeight()

	p:SetHeight(max(1, y))
	p:ClearAllPoints()
	p:SetPoint("TOPLEFT", F, "TOPLEFT", 1 + K.EDGE, -(1 + heroH))
	F.Hint:SetText(L["Change it later with %s"]:format("|c" .. Theme.Hex("text") .. "/polestar trail|r"))
	F:SetHeight(math.ceil(1 + heroH + y + K.BOTTOM + K.FOOT_H + 1))
	if F.Rim and W.LayoutRim then W.LayoutRim(F) end
end

-- Opens now; asked for in a fight or during a cinematic, when that ends.
local function open()
	if not available() then return end
	if ns.Compat.InCombat() or inCinematic() then
		asked = true
		return
	end
	asked = nil
	if not F then build() end
	render()
	F:Show()
	F:Raise()
end

function TI.Show()
	open()
end

function TI.Hide()
	asked = nil
	close()
end

function TI.IsShown()
	return F ~= nil and F:IsShown()
end

-- Asked for, and waiting for a fight or a cinematic to end (tests).
function TI.Pending()
	return asked or false
end

-- Never by itself: only when asked for, here.
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if asked then open() end
end)
ns.RegisterEvent("CINEMATIC_STOP", function()
	if not asked then return end
	if C_Timer and C_Timer.After then ns.After(1, function() if asked then open() end end) else open() end
end)
ns.On("SHOW_TRAIL_INTRO", function() TI.Show() end)

-- The cards follow the look in use and reduced motion.
ns.On("SETTING_CHANGED", function(path)
	if not (F and F.Cards) then return end
	path = path or ""
	if path == "" or path == "nav" or path == "ui" or path == "ui.reduceMotion"
		or path:find("nav.worldTrail", 1, true) == 1 then
		for _, c in ipairs(F.Cards) do paintCard(c) end
	end
end)
Theme.OnChanged(function()
	if F and F:IsShown() then render() end
end)
W.OnFontChanged(function()
	if F and F:IsShown() then render() end
end)
