-- The Free mode page's hero, shown every time the page opens while Free mode
-- is off (Page.lua's intro): the one primary "Activate Free mode" at the centre of the
-- page, the Polestar emblem and a faint constellation around it, the tagline,
-- and under it the three points and the player's own quests in Free mode's
-- order. Drawn only from the addon's own art (the emblem, its engraving, the
-- glow, a dot) and painted through Theme tokens, so the gold follows each
-- look's accent and the stars its star colour; the button is the Skin API's.
--
-- Three compositions, one shown (dev switch: PolestarDB.devFreeHero, "sky",
-- "polaris" or "seal"; unset is "sky"):
--   sky      your quests as a constellation: the emblem leads a dotted path
--            through a star for each of the first three, their names beside
--            them, the button under the sky
--   polaris  the lockup: the emblem large in its glow over the tagline and
--            the button, a dotted path winding into it from the left
--   seal     the button at the heart of the emblem's engraving, the tagline
--            above it inside the ring, a dotted orbit round it
--
--   Free.Hero.Lay(c) -> the y under the hero (c: Page.lua's context)
--   Free.Hero.Direction() -> the composition shown

local ns = Polestar
local UI, Theme, W, L = ns.UI, ns.Theme, ns.Widgets, ns.L
local Free = ns.Free
if not (UI and Theme and W and W.SHELL and Free) then return end
local max, min, floor, sqrt, cos, sin, rad, ipairs, format = math.max, math.min, math.floor, math.sqrt, math.cos, math.sin, math.rad, ipairs, string.format

local H = {}
Free.Hero = H

local BUTTON_H = 44
local BUTTON_W = 248 -- at least: the centrepiece
local DOT_GAP = 7 -- the dotted path: a dot every 7 units
local DIRECTIONS = { sky = true, polaris = true, seal = true }
H.DEFAULT = "sky"

function H.Direction()
	local d = ns.DB and ns.DB().devFreeHero
	return DIRECTIONS[d] and d or H.DEFAULT
end

local art -- the frame every hero texture sits on (over the body, under its text)
local pool, used = {}, 0
local parts = {}
H.parts = parts

local function house()
	return Theme.SkinKey() == "polestar"
end

-- The next texture of the pool, `media` on it, in `layer`/`sub`.
local function tex(media, layer, sub)
	used = used + 1
	local t = pool[used]
	if not t then
		t = art:CreateTexture(nil, "ARTWORK")
		pool[used] = t
	end
	t:SetDrawLayer(layer or "ARTWORK", sub or 0)
	t:SetTexture(Theme.Media(media))
	t:SetTexCoord(0, 1, 0, 1)
	t:SetRotation(0)
	t:SetBlendMode("BLEND")
	t:ClearAllPoints()
	t:Show()
	return t
end

local function place(t, x, y, w, h)
	t:SetSize(w, h or w)
	t:SetPoint("CENTER", art, "TOPLEFT", x, -y)
	return t
end

local function tint(t, token, alpha)
	local r, g, b = Theme.Color(token)
	t:SetVertexColor(r, g, b, alpha or 1)
	return t
end

-- A star: a core in `token` (the star colour unless given) in its soft light.
local function star(x, y, r, token, alpha)
	token = token or "star"
	tint(place(tex("glow", "BORDER", 1), x, y, r * 7), token, 0.28 * (alpha or 1))
	tint(place(tex("circle", "BORDER", 2), x, y, max(2, r * 2)), token, alpha or 1)
end

-- A dotted path through `pts` ({ x, y } in art space): a dot every DOT_GAP,
-- `fade` (0..1) of the way the dots thin to nothing at its end.
local function dots(pts, token, alpha, fade, size)
	local total = 0
	for i = 2, #pts do
		local dx, dy = pts[i][1] - pts[i - 1][1], pts[i][2] - pts[i - 1][2]
		total = total + sqrt(dx * dx + dy * dy)
	end
	local walked, carry = 0, DOT_GAP / 2
	for i = 2, #pts do
		local ax, ay, bx, by = pts[i - 1][1], pts[i - 1][2], pts[i][1], pts[i][2]
		local len = sqrt((bx - ax) ^ 2 + (by - ay) ^ 2)
		local d = carry
		while d <= len do
			local f = (walked + d) / max(1, total)
			local a = alpha
			if fade and fade > 0 and f > 1 - fade then a = alpha * max(0, (1 - f) / fade) end
			if a > 0.02 then tint(place(tex("circle", "BORDER", 0), ax + (bx - ax) * d / len, ay + (by - ay) * d / len, size or 2), token, a) end
			d = d + DOT_GAP
		end
		carry = d - len
		walked = walked + len
	end
end

-- A smooth path through `pts`: each corner rounded by a quadratic curve, cut
-- into short straight steps for dots().
local function smooth(pts)
	if #pts < 3 then return pts end
	local out = { pts[1] }
	for i = 2, #pts - 1 do
		local p, q, r = pts[i - 1], pts[i], pts[i + 1]
		local ax, ay = (p[1] + q[1]) / 2, (p[2] + q[2]) / 2
		local bx, by = (q[1] + r[1]) / 2, (q[2] + r[2]) / 2
		if i == 2 then out[#out + 1] = { ax, ay } end
		for s = 1, 8 do
			local t = s / 8
			local u = 1 - t
			out[#out + 1] = { u * u * ax + 2 * u * t * q[1] + t * t * bx, u * u * ay + 2 * u * t * q[2] + t * t * by }
		end
	end
	out[#out + 1] = pts[#pts]
	return out
end

-- The emblem, `size` across, centred at (x, y), in its glow (`bloom` across);
-- in the house look its hot centre and a 1px beam rising `beam` above it.
local function emblem(x, y, size, bloom, beam)
	local glow = place(tex("glow", "BACKGROUND", 2), x, y, bloom)
	local r, g, b = Theme.Accent()
	glow:SetVertexColor(r, g, b, house() and 0.3 or 0.16)
	parts.Glow = glow
	local e = tint(place(tex("emblem", "ARTWORK", 1), x, y, size), "accent")
	parts.Emblem = e
	local hr, hg, hb = W.AccentHi()
	local hot = place(tex("emblem-hot", "ARTWORK", 2), x, y, size)
	hot:SetVertexColor(hr, hg, hb, 1)
	hot:SetShown(house())
	if beam and beam > 0 and house() then
		local t = tex("white", "BORDER", 3)
		t:SetSize(1, beam)
		t:SetPoint("BOTTOM", art, "TOPLEFT", x, -(y - size * 0.47))
		if t.SetGradient and CreateColor then
			t:SetVertexColor(1, 1, 1, 1)
			t:SetGradient("VERTICAL", CreateColor(hr, hg, hb, 0.6), CreateColor(r, g, b, 0))
		else
			t:SetVertexColor(r, g, b, 0.3)
		end
	end
	return e
end

-- The texts and the frames the hero owns.
local function build(body)
	art = CreateFrame("Frame", nil, body)
	art:SetPoint("TOPLEFT", body, "TOPLEFT", 0, 0)
	art:SetSize(1, 1)
	art:SetFrameLevel(body:GetFrameLevel())
	parts.Title = W.Text(body, "hero", "text")
	parts.Title:SetJustifyH("CENTER")
	parts.Lead = W.Text(body, "note", "textDim")
	parts.Lead:SetJustifyH("CENTER")
	parts.Lead:SetWordWrap(true)
	parts.Lead:SetSpacing(3)
	parts.Lead:SetText(L["Pick up whatever quests you like. Free mode puts them in a smart order and the arrow takes you through them, one after another."])
	parts.Back = W.Text(body, "small", "textMuted")
	parts.Back:SetJustifyH("CENTER")
	parts.Back:SetWordWrap(true)
	parts.Back:SetSpacing(2)
	parts.Back:SetText(L["Back to your guide any time, from the guide window's menu or this page."])
	-- The three points, side by side: a glyph over a title over a line.
	parts.Points = {}
	for i, p in ipairs({
		{ "icon-accept", L["You pick up quests"], L["Any quest, anywhere: Free mode follows your quest log, not a guide."] },
		{ "sliders", L["Polestar plans the order"], L["The best trip for the walk, planned again whenever your log changes."] },
		{ "icon-goto", L["The arrow leads"], L["To each objective and hand-in in turn, as in any guide."] },
	}) do
		local f = CreateFrame("Frame", nil, body)
		f.Icon = W.Tex(f, "ARTWORK", p[1], "accent")
		f.Icon:SetSize(16, 16)
		f.Icon:SetPoint("TOP", f, "TOP", 0, 0)
		f.Title = W.Text(f, "body", "text")
		f.Title:SetJustifyH("CENTER")
		f.Title:SetPoint("TOP", f, "TOP", 0, -24)
		f.Title:SetText(p[2])
		f.Text = W.Text(f, "small", "textDim")
		f.Text:SetJustifyH("CENTER")
		f.Text:SetWordWrap(true)
		f.Text:SetSpacing(2)
		f.Text:SetPoint("TOP", f.Title, "BOTTOM", 0, -5)
		f.Text:SetText(p[3])
		parts.Points[i] = f
	end
	-- The preview of the player's own quests: a hairline, the running
	-- figure, the first quest and why, then the next ones.
	parts.Rule = W.Divider(body)
	parts.StripIcon = W.Tex(body, "ARTWORK", "icon-freemode", "textDim")
	parts.StripIcon:SetSize(16, 16)
	parts.Strip = W.Text(body, "body", "text")
	parts.Strip:SetJustifyH("CENTER")
	parts.Strip:SetWordWrap(true)
	parts.Then = W.Text(body, "small", "textMuted")
	parts.Then:SetJustifyH("CENTER")
	parts.Then:SetWordWrap(true)
	-- The sky's labels: a quest's title over its why line, per star.
	parts.Labels = {}
	for i = 1, 3 do
		local t = W.Text(body, "body", "quest")
		local why = W.Text(body, "small", "textDim")
		parts.Labels[i] = { title = t, why = why }
	end
	parts.More = W.Text(body, "small", "textMuted")
end

local function hide()
	for i = 1, used do pool[i]:Hide() end
	used = 0
	for k, f in pairs(parts) do
		if k ~= "Points" and k ~= "Labels" and type(f) == "table" and f.Hide then f:Hide() end
	end
	for _, p in ipairs(parts.Points or {}) do p:Hide() end
	for _, l in ipairs(parts.Labels or {}) do
		l.title:Hide()
		l.why:Hide()
	end
end
H.Hide = function() if art then hide() end end

local function at(f, x, y, point)
	f:ClearAllPoints()
	f:SetPoint(point or "TOPLEFT", art, "TOPLEFT", x, -y)
	f:Show()
end

-- A centred line of text `width` wide, its top at y -> the y under it.
local function centred(fs, cx, y, width)
	fs:SetWidth(width)
	at(fs, cx - width / 2, y)
	return y + fs:GetStringHeight()
end

-- The button, `y` its top, centred on cx -> the y under it.
local function button(c, cx, y)
	local b = c.start
	if not b.psHero then
		b.psHero = true
		b.psHeight = BUTTON_H
		b:SetHeight(BUTTON_H)
		Theme.Font(b.Label, "title")
		if b.Icon then b.Icon:SetSize(16, 16) end
	end
	W.SetButtonText(b, L["Activate Free mode"])
	b:SetWidth(max(BUTTON_W, b:GetWidth() + 32))
	at(b, cx - b:GetWidth() / 2, y)
	c.shown.start = L["Activate Free mode"]
	return y + BUTTON_H
end

-- The three points side by side across `width` from x -> the y under them.
local function points(x, y, width)
	local colW = floor(width / 3)
	local bottom = y
	for i, p in ipairs(parts.Points) do
		p.Text:SetWidth(colW - 40)
		p.Title:SetWidth(colW - 24)
		p:SetSize(colW, 24 + 18 + 5 + p.Text:GetStringHeight())
		at(p, x + (i - 1) * colW, y)
		bottom = max(bottom, y + p:GetHeight())
	end
	return bottom
end

local function hex(name) return "|c" .. Theme.Hex(name) end

-- The intro's preview strip: a hairline, then "Free mode would start with
-- <quest> · why" and under it the next ones -> the y under it.
local function strip(c, x, y, width)
	local route = c.route
	local cx = x + width / 2
	parts.Rule:ClearAllPoints()
	parts.Rule:SetPoint("TOPLEFT", art, "TOPLEFT", x, -y)
	parts.Rule:SetPoint("TOPRIGHT", art, "TOPLEFT", x + width, -y)
	parts.Rule:Show()
	y = y + 20
	if #route == 0 then
		parts.Strip:SetText(L["Pick up quests and Free mode leads you to them."])
		c.shown.empty = true
	else
		local first = route[1]
		local line = format(L["Free mode would start with %s"], hex("quest") .. first.title .. "|r")
		if first.why then line = line .. hex("textDim") .. "  \194\183  " .. first.why .. "|r" end
		parts.Strip:SetText(line)
		c.shown.lead = parts.Strip:GetText()
	end
	local textW = min(width - 48, 640)
	local sy = centred(parts.Strip, cx + 12, y, textW)
	-- The running figure before the first line.
	parts.StripIcon:ClearAllPoints()
	local lineW = min(textW, W.TextWidth and W.TextWidth(parts.Strip) or parts.Strip:GetStringWidth())
	parts.StripIcon:SetPoint("TOPRIGHT", art, "TOPLEFT", cx + 12 - lineW / 2 - 8, -y)
	parts.StripIcon:Show()
	y = sy
	if #route > 1 then
		local names = {}
		for i = 2, min(#route, 3) do names[#names + 1] = hex("quest") .. route[i].title .. "|r" end
		local rest = #route - 3
		local text = rest > 0 and format(L["Then %s and %d more"], table.concat(names, ", "), rest) or format(L["Then %s"], table.concat(names, ", "))
		parts.Then:SetText(text)
		y = centred(parts.Then, cx, y + 6, textW)
		if rest > 0 then c.shown.more = rest end
	end
	return y
end

-- The previewed quests in Page.Shown() (its array part), as the rows were.
local function record(c, upto)
	for i = 1, min(upto, #c.route) do
		local s = c.route[i]
		c.shown[#c.shown + 1] = { n = s.n, quest = s.quest, title = s.title, why = s.why, ready = s.ready, xp = s.xp, zone = s.zone }
	end
end

---------------------------------------------------------------------------
-- sky: your quests as a constellation
---------------------------------------------------------------------------

-- The stars' places across the sky, as shares of its width from its centre
-- and units down from its top: the emblem, the three quests, the path's end.
local SKY = { emblem = { -0.36, 92 }, { -0.15, 58 }, { 0.04, 128 }, { 0.23, 62 }, tail = { 0.40, 112 } }
-- The background stars, unlinked: share of the width, y, radius.
local FIELD = { { -0.46, 30, 1 }, { -0.27, 150, 1.2 }, { -0.05, 24, 0.9 }, { 0.19, 182, 1 }, { 0.33, 22, 1.1 }, { 0.46, 160, 0.9 },
	{ -0.42, 170, 0.8 }, { 0.47, 70, 1 } }

local function sky(c, x, y, width, h)
	local cx = x + width / 2
	local function pt(p) return { cx + p[1] * width, y + p[2] * h / 200 } end
	for _, s in ipairs(FIELD) do
		local p = pt(s)
		star(p[1], p[2], s[3], "star", 0.5)
	end
	local e = pt(SKY.emblem)
	emblem(e[1], e[2], 80, 280, 48)
	local n = #c.route
	local path = { { e[1] + 30, e[2] - 6 } }
	local stars = {}
	for i = 1, 3 do
		if i <= n then
			stars[i] = pt(SKY[i])
			path[#path + 1] = stars[i]
		end
	end
	local tail = pt(SKY.tail)
	if n == 0 then tail = pt(SKY[1]) end
	path[#path + 1] = tail
	dots(smooth(path), "star", 0.55, n > 3 and 0.25 or 0.45)
	for i, p in ipairs(stars) do
		star(p[1], p[2], 2.6, "quest", 1)
		local l, s = parts.Labels[i], c.route[i]
		local up = i ~= 2
		local lw = min(200, floor(width * 0.22))
		l.title:SetText(s.title)
		l.title:SetWidth(lw)
		l.title:SetJustifyH("CENTER")
		l.why:SetText(s.why or "")
		l.why:SetWidth(lw)
		l.why:SetJustifyH("CENTER")
		if up then
			at(l.why, p[1] - lw / 2, p[2] - 14 - 14, "TOPLEFT")
			at(l.title, p[1] - lw / 2, p[2] - 14 - 14 - 18, "TOPLEFT")
		else
			at(l.title, p[1] - lw / 2, p[2] + 14, "TOPLEFT")
			at(l.why, p[1] - lw / 2, p[2] + 14 + 18, "TOPLEFT")
		end
		l.why:SetShown(s.why ~= nil)
	end
	if n > 3 then
		parts.More:SetText(format(L["and %d more"], n - 3))
		at(parts.More, tail[1] - 4, tail[2] + 8)
		c.shown.more = n - 3
	elseif n == 0 then
		parts.More:SetText(L["Pick up quests and Free mode leads you to them."])
		star(tail[1], tail[2], 1.6, "star", 0.6)
		at(parts.More, tail[1] + 14, tail[2] - 7)
		c.shown.empty = true
	end
end

local function laySky(c)
	local x, y, width = c.x, c.y, c.width
	local cx = x + width / 2
	parts.Title:SetText(L["Quest your own way"])
	y = centred(parts.Title, cx, y + 4, width) + 8
	y = centred(parts.Lead, cx, y, min(width, 520)) + 14
	sky(c, x, y, width, 200)
	record(c, 3)
	if #c.route > 0 then
		local first = c.route[1]
		c.shown.lead = format(L["Free mode would start with %s"], first.title)
	end
	y = button(c, cx, y + 200 + 4)
	y = centred(parts.Back, cx, y + 10, min(width, 520)) + 28
	y = points(x, y, width)
	return y + 32
end

---------------------------------------------------------------------------
-- polaris: the lockup
---------------------------------------------------------------------------

local POLARIS_PATH = { { -0.47, 150 }, { -0.36, 118 }, { -0.27, 138 }, { -0.18, 96 }, { -0.09, 84 } }
local POLARIS_RIGHT = { { 0.12, 52, 1.4 }, { 0.2, 88, 1.8 }, { 0.29, 70, 1.5 }, { 0.37, 112, 1.2 }, { 0.45, 96, 1 } }
local POLARIS_LINKS = { { 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 5 } }

local function polaris(c, x, y, width, h, size)
	local cx = x + width / 2
	local ey = y + h * 0.5
	emblem(cx, ey, size, size * 3.4, h * 0.5 - size * 0.4)
	local s = h / 170
	local pts = {}
	for i, p in ipairs(POLARIS_PATH) do
		pts[i] = { cx + p[1] * width, y + p[2] * s }
		if i < #POLARIS_PATH then star(pts[i][1], pts[i][2], i == 1 and 1.2 or 1.6, "star", 0.9) end
	end
	pts[#pts] = { cx - size * 0.62, ey }
	dots(smooth(pts), "star", 0.5)
	-- The fixed lines a guide draws, on the right: a few stars joined by hairlines.
	local right = {}
	for i, p in ipairs(POLARIS_RIGHT) do
		right[i] = { cx + p[1] * width, y + p[2] * s }
		star(right[i][1], right[i][2], p[3], "star", 0.75)
	end
	for _, link in ipairs(POLARIS_LINKS) do
		local a, b = right[link[1]], right[link[2]]
		local t = tex("white", "BORDER", 0)
		local dx, dy = b[1] - a[1], b[2] - a[2]
		t:SetSize(sqrt(dx * dx + dy * dy), Theme.Pixel(art))
		t:SetPoint("CENTER", art, "TOPLEFT", (a[1] + b[1]) / 2, -(a[2] + b[2]) / 2)
		t:SetRotation(-math.atan2(dy, dx))
		tint(t, "star", 0.2)
	end
end

local function layPolaris(c)
	local x, y, width = c.x, c.y, c.width
	local cx = x + width / 2
	polaris(c, x, y, width, 144, 76)
	y = y + 144 + 2
	parts.Title:SetText(L["Quest your own way"])
	y = centred(parts.Title, cx, y, width) + 8
	y = centred(parts.Lead, cx, y, min(width, 520)) + 20
	y = button(c, cx, y)
	y = centred(parts.Back, cx, y + 10, min(width, 520)) + 36
	y = points(x, y, width) + 28
	record(c, 3)
	return strip(c, x, y, width) + 28
end

---------------------------------------------------------------------------
-- seal: the button at the heart of the emblem's engraving
---------------------------------------------------------------------------

local function seal(c, cx, cy, size)
	local glow = place(tex("glow", "BACKGROUND", 1), cx, cy, size * 1.3)
	local r, g, b = Theme.Accent()
	glow:SetVertexColor(r, g, b, house() and 0.16 or 0.1)
	parts.Glow = glow
	local e = place(tex("watermark", "BACKGROUND", 3), cx, cy, size)
	e:SetVertexColor(r, g, b, house() and 0.3 or 0.24)
	parts.Emblem = e
	-- A dotted orbit round the ring: your own path, a star on it now and then.
	local R = size * 0.5
	local pts = {}
	for a = 200, 520, 4 do pts[#pts + 1] = { cx + cos(rad(a)) * R, cy + sin(rad(a)) * R * 0.92 } end
	dots(pts, "star", 0.45, 0.3)
	for _, a in ipairs({ 214, 300, 382, 455 }) do
		star(cx + cos(rad(a)) * R, cy + sin(rad(a)) * R * 0.92, 1.7, "star", 0.9)
	end
	for _, s in ipairs({ { -0.42, -0.3, 1 }, { 0.47, 0.12, 1.2 }, { -0.5, 0.36, 0.9 }, { 0.38, -0.42, 1 } }) do
		star(cx + s[1] * size * 1.6, cy + s[2] * size, s[3], "star", 0.5)
	end
end

local function laySeal(c)
	local x, y, width = c.x, c.y, c.width
	local cx = x + width / 2
	local size = 340
	local cy = y + size / 2 + 4
	seal(c, cx, cy, size)
	parts.Title:SetText(L["Quest your own way"])
	centred(parts.Title, cx, cy - 66, width)
	button(c, cx, cy - BUTTON_H / 2 + 2)
	centred(parts.Back, cx, cy + 36, 250)
	y = cy + size / 2 + 20
	y = points(x, y, width) + 28
	record(c, 3)
	return strip(c, x, y, width) + 28
end

local LAY = { sky = laySky, polaris = layPolaris, seal = laySeal }

-- Lay the hero from c.y: c = { body, x, y, width, route (Page's entries),
-- start (the button), shown } -> the y under it.
function H.Lay(c)
	if not art then build(c.body) end
	hide()
	art:SetSize(c.x * 2 + c.width, 1)
	local d = H.Direction()
	c.shown.hero = d
	return LAY[d](c)
end
