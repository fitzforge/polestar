-- The Free mode section's About page (Page.lua's third page): how Free mode
-- works, in the hero's art (Hero.lua's kit: the emblem, stars as quests,
-- dotted paths), then when to use it and how to get back to a guide.
--
--   How Free mode works   the tagline and its lead, then four beats along a
--                         dotted trail, each a small drawing over its title
--                         and line: you pick up anything (loose stars), Polestar
--                         orders it (the same stars joined and numbered), the
--                         arrow leads (the emblem's path to a ringed star), you
--                         hand in on the way (a hand-in stop on the path)
--   When to use it        three cases side by side, a glyph each
--   Back to your guide    how turning it off works; off, Activate under it
--
-- Drawn only from the addon's own art and painted through Theme tokens, so
-- every look restyles it (the accent, the star and quest colours, success).
--
--   Free.About.Lay(c) -> the y under the page (c: Page.lua's context)
--   Free.About.Hide()

local ns = Polestar
local UI, Theme, W, L = ns.UI, ns.Theme, ns.Widgets, ns.L
local Free = ns.Free
if not (UI and Theme and W and W.SHELL and Free and Free.Hero) then return end
local max, min, floor, ipairs, pairs, tostring = math.max, math.min, math.floor, ipairs, pairs, tostring

local A = {}
Free.About = A

local BAND = 150 -- the trail's height: the four drawings
local BUTTON_H = 32

local art, K
local parts = {}
A.parts = parts

-- The four beats: the drawing's key, its title and line.
local BEATS = {
	{ key = "pick", title = L["Pick up anything"], text = L["Any quest, anywhere: Free mode follows your quest log, not a guide."] },
	{ key = "order", title = L["Polestar orders it"], text = L["The best trip for the walk, planned again whenever your log changes."] },
	{ key = "arrow", title = L["The arrow leads"], text = L["To each objective and hand-in in turn, as in any guide."] },
	{ key = "handin", title = L["Hand in on the way"], text = L["Finished quests become stops on the trip: you hand them in as you pass."] },
}

local WHEN = {
	{ icon = "guides", title = L["Off your guide's route"], text = L["Quests your guide doesn't have, or a zone it skips: Free mode takes them all."] },
	{ icon = "icon-group", title = L["Questing with friends"], text = L["Take what the group takes, and the arrow leads you through all of it."] },
	{ icon = "icon-explore", title = L["Doing your own thing"], text = L["No route to keep to: pick up what looks fun and Polestar finds the way."] },
}

local function build(body)
	art = CreateFrame("Frame", nil, body)
	art:SetPoint("TOPLEFT", body, "TOPLEFT", 0, 0)
	art:SetSize(1, 1)
	art:SetFrameLevel(body:GetFrameLevel())
	K = Free.Hero.Kit(art)
	parts.Title = W.Text(body, "hero", "text")
	parts.Title:SetJustifyH("CENTER")
	parts.Title:SetText(L["How Free mode works"])
	parts.Lead = W.Text(body, "note", "textDim")
	parts.Lead:SetJustifyH("CENTER")
	parts.Lead:SetWordWrap(true)
	parts.Lead:SetSpacing(3)
	parts.Lead:SetText(L["Pick up whatever quests you like. Free mode puts them in a smart order and the arrow takes you through them, one after another."])
	-- Each beat: its number in a ring, its title, its line.
	parts.Beats = {}
	for i, b in ipairs(BEATS) do
		local f = {}
		f.Num = W.Text(body, "label", "accent")
		f.Num:SetJustifyH("CENTER")
		f.Num:SetText(tostring(i))
		f.Title = W.Text(body, "body", "text")
		f.Title:SetJustifyH("CENTER")
		f.Title:SetWordWrap(true)
		f.Title:SetText(b.title)
		f.Text = W.Text(body, "small", "textDim")
		f.Text:SetJustifyH("CENTER")
		f.Text:SetWordWrap(true)
		f.Text:SetSpacing(2)
		f.Text:SetText(b.text)
		parts.Beats[i] = f
	end
	-- The numbers beside the ordered stars of the second beat.
	parts.Order = {}
	for i = 1, 4 do
		local t = W.Text(body, "small", "textMuted")
		t:SetText(tostring(i))
		parts.Order[i] = t
	end
	parts.WhenH = W.SectionHeader(body)
	parts.When = {}
	for i, c in ipairs(WHEN) do
		local f = CreateFrame("Frame", nil, body)
		f.Icon = W.Tex(f, "ARTWORK", c.icon, "accent")
		f.Icon:SetSize(16, 16)
		f.Icon:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -1)
		f.Title = W.Text(f, "body", "text")
		f.Title:SetJustifyH("LEFT")
		f.Title:SetWordWrap(true)
		f.Title:SetPoint("TOPLEFT", f, "TOPLEFT", 26, 0)
		f.Title:SetText(c.title)
		f.Text = W.Text(f, "small", "textDim")
		f.Text:SetJustifyH("LEFT")
		f.Text:SetWordWrap(true)
		f.Text:SetSpacing(2)
		f.Text:SetPoint("TOPLEFT", f.Title, "BOTTOMLEFT", 0, -5)
		f.Text:SetText(c.text)
		parts.When[i] = f
	end
	parts.BackH = W.SectionHeader(body)
	parts.BackText = W.Text(body, "note", "textDim")
	parts.BackText:SetJustifyH("LEFT")
	parts.BackText:SetWordWrap(true)
	parts.BackText:SetSpacing(3)
	parts.BackText:SetText(L["Turn Free mode off on its Main page or from the guide window's menu: the arrow goes back to the guide you had open, where you left it."])
end

function A.Hide()
	if not art then return end
	K.Reset()
	for k, f in pairs(parts) do
		if type(f) == "table" and f.Hide then f:Hide() end
	end
	for _, f in ipairs(parts.Beats) do
		f.Num:Hide()
		f.Title:Hide()
		f.Text:Hide()
	end
	for _, t in ipairs(parts.Order) do t:Hide() end
	for _, f in ipairs(parts.When) do f:Hide() end
end

---------------------------------------------------------------------------
-- The beats' drawings, each round its centre (x, y)
---------------------------------------------------------------------------

-- The loose quests of the first beat, the same four the second beat orders.
local LOOSE = { { -50, -18 }, { 26, -34 }, { -14, 26 }, { 52, 14 } }
-- The second beat's order through them: the nearest first.
local ORDER = { 3, 1, 2, 4 }
-- A few faint stars behind every drawing.
local FAINT = { { -70, -40, 0.9 }, { 66, -44, 0.8 }, { -66, 40, 0.8 }, { 70, 42, 1 }, { 4, -50, 0.7 } }

local function faint(x, y)
	for _, s in ipairs(FAINT) do K.Star(x + s[1], y + s[2], s[3], "star", 0.4) end
end

-- 1. Pick up anything: quests scattered, each with its "!".
local function pick(x, y)
	for _, p in ipairs(LOOSE) do
		K.Star(x + p[1], y + p[2], 2.4, "quest", 1)
		K.tint(K.Place(K.Tex("icon-accept", "ARTWORK", 1), x + p[1], y + p[2] - 15, 12), "quest", 0.9)
	end
end

-- 2. Polestar orders it: the same quests joined in order, numbered.
local function order(x, y)
	local pts = {}
	for i, k in ipairs(ORDER) do
		local p = LOOSE[k]
		pts[i] = { x + p[1], y + p[2] }
	end
	K.Dots(K.smooth(pts), "star", 0.6, 0.15)
	for i, p in ipairs(pts) do
		K.Star(p[1], p[2], 2.4, "quest", 1)
		K.At(parts.Order[i], p[1] + 7, p[2] - 6)
	end
end

-- 3. The arrow leads: the emblem's dotted path to the quest it leads to, ringed.
local function arrow(x, y)
	local from, to = { x - 46, y + 16 }, { x + 46, y - 18 }
	K.Emblem(from[1], from[2], 38, 120, 0)
	K.Dots(K.smooth({ { from[1] + 18, from[2] - 4 }, { x, y + 18 }, { x + 18, y - 26 }, to }), "accent", 0.8, 0, 2.5)
	K.tint(K.Place(K.Tex("ring", "ARTWORK", 0), to[1], to[2], 26), "accent", 0.9)
	K.Star(to[1], to[2], 2.6, "quest", 1)
	K.tint(K.Place(K.Tex("icon-goto", "ARTWORK", 1), to[1], to[2] - 24, 14), "accent", 1)
end

-- 4. Hand in on the way: a path past a hand-in stop, quests before and after it.
local function handin(x, y)
	local pts = { { x - 72, y + 22 }, { x - 34, y + 4 }, { x, y + 10 }, { x + 34, y - 6 }, { x + 72, y - 22 } }
	K.Dots(K.smooth(pts), "star", 0.55, 0.3)
	K.Star(pts[2][1], pts[2][2], 2.2, "quest", 0.8)
	K.Star(pts[4][1], pts[4][2], 2.2, "quest", 0.8)
	local r, g, b = Theme.Color("success")
	K.Place(K.Tex("glow", "BORDER", 1), x, y + 10, 64):SetVertexColor(r, g, b, 0.3)
	K.tint(K.Place(K.Tex("icon-turnin", "ARTWORK", 1), x, y + 10, 18), "success", 1)
end

local DRAW = { pick = pick, order = order, arrow = arrow, handin = handin }

---------------------------------------------------------------------------
-- Laying the page
---------------------------------------------------------------------------

-- The trail: the four drawings across `width` from x at y, joined by a faint
-- dotted line, then each beat's number, title and line -> the y under it.
local function trail(c, x, y, width)
	local colW = floor(width / 4)
	local cy = y + BAND / 2
	local beats = {}
	for i, b in ipairs(BEATS) do
		local bx = x + (i - 0.5) * colW
		faint(bx, cy)
		DRAW[b.key](bx, cy)
		if i < #BEATS then
			K.Dots({ { bx + colW * 0.36, cy }, { bx + colW * 0.64, cy } }, "star", 0.3, 0.2)
		end
		beats[i] = b.title
	end
	c.shown.beats = beats
	y = y + BAND + 8
	local bottom = y
	for i, f in ipairs(parts.Beats) do
		local bx = x + (i - 0.5) * colW
		-- The beat's number in an accent ring.
		K.tint(K.Place(K.Tex("ring", "ARTWORK", 0), bx, y + 10, 22), "accent", 0.8)
		f.Num:SetWidth(22)
		K.At(f.Num, bx - 11, y + 4)
		local ty = K.Centred(f.Title, bx, y + 30, colW - 24) + 6
		bottom = max(bottom, K.Centred(f.Text, bx, ty, colW - 32))
	end
	return bottom
end

-- The three cases side by side across `width` from x at y -> the y under them.
local function when(c, x, y, width)
	local colW = floor(width / 3)
	local bottom = y
	local titles = {}
	for i, f in ipairs(parts.When) do
		f.Title:SetWidth(colW - 26 - 20)
		f.Text:SetWidth(colW - 26 - 20)
		f:SetSize(colW - 20, f.Title:GetStringHeight() + 5 + f.Text:GetStringHeight())
		K.At(f, x + (i - 1) * colW, y)
		bottom = max(bottom, y + f:GetHeight())
		titles[i] = f.Title:GetText()
	end
	c.shown.when = titles
	return bottom
end

-- c = { body, x, y, width, on, start (Activate, shown while off), shown } -> the y under the page.
function A.Lay(c)
	if not art then build(c.body) end
	A.Hide()
	art:SetSize(c.x * 2 + c.width, 1)
	local x, y, width = c.x, c.y, c.width
	local cx = x + width / 2
	y = K.Centred(parts.Title, cx, y + 4, width) + 8
	y = K.Centred(parts.Lead, cx, y, min(width, 560)) + 20
	y = trail(c, x, y, width) + 40

	local h = parts.WhenH
	h:SetWidth(width)
	W.SetSection(h, L["When to use it"])
	K.At(h, x, y - 18)
	y = when(c, x, y + 30, width) + 40

	h = parts.BackH
	h:SetWidth(width)
	W.SetSection(h, L["Back to your guide"])
	K.At(h, x, y - 18)
	parts.BackText:SetWidth(min(width, 640))
	y = K.Centred(parts.BackText, x + min(width, 640) / 2, y + 30, min(width, 640))
	c.shown.back = parts.BackText:GetText()
	if not c.on then
		local b = c.start
		b:SetWidth(max(200, b:GetWidth()))
		K.At(b, x, y + 18)
		c.shown.start = L["Activate Free mode"]
		y = y + 18 + BUTTON_H
	end
	return y + 32
end
