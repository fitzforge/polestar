-- Polestar_Looks (load on demand): Hearth's painters (docs/ARCHITECTURE.md,
-- "Skins"), an inn by the fire in Polestar's own art: every window a walnut
-- board lit from above by an ember light, copper hairlines, planks for the
-- controls. Hearth's palette, sizes and fonts stay in the core (Theme.lua:
-- the picker draws its card from them); its painters load with this part,
-- the first time Hearth is painted. Its pieces live in the frame's kit store
-- (frame.psSkin.kit, as the game's looks keep theirs), so Theme's clearSkin
-- hides them when another skin paints the frame. A gradient set on a texture
-- outlives a flat SetVertexColor, so the boards and planks draw on their own
-- texture and leave the house fill (psSkin.bg) flat for the skins that use
-- it so.

local ns = Polestar
local Theme = ns and ns.Theme
local I = ns and ns.ThemeInternal
if not (Theme and I and Theme.SKIN_PAINT) or Theme.SKIN_PAINT.hearth then return end

local P = Theme.Paint
local fill, hoverWash, bare, hideBorder, HOUSE_PAINT = P.fill, P.hoverWash, P.bare, P.hideBorder, P.house
local get, isColor, shifted, shadowFor, veilAlpha = I.get, I.isColor, I.shifted, I.shadowFor, I.veilAlpha

local function store(f)
	local d = f.psSkin
	d.kit = d.kit or {}
	return d.kit
end

-- The board: `top` shading to `bottom` over the whole frame, on the house
-- fill's layer; the house fill itself out of sight.
local function board(f, top, bottom)
	local k = store(f)
	local t = k.board
	if not t then
		t = f:CreateTexture(nil, "BACKGROUND", nil, -7)
		t:SetTexture(Theme.Media("white"))
		t:SetAllPoints(f)
		k.board = t
	end
	if f.psSkin.bg then f.psSkin.bg:Hide() end
	if t.SetGradient and CreateColor then
		t:SetGradient("VERTICAL", CreateColor(bottom[1], bottom[2], bottom[3], bottom[4] or 1), CreateColor(top[1], top[2], top[3], top[4] or 1))
	else
		t:SetVertexColor(top[1], top[2], top[3], top[4] or 1)
	end
	t:Show()
	return t
end

-- The firelight: the lower half of Media/UI/glow (a soft radial) laid along
-- a window's top edge in the ember colour, added to the ground, so the board
-- reads lit from above and fades into shadow.
local EMBER_H = 120
local function ember(f, alpha)
	local k = store(f)
	local g = k.ember
	if not g then
		g = f:CreateTexture(nil, "BACKGROUND", nil, -6)
		g:SetTexture(Theme.Media("glow"))
		g:SetTexCoord(0, 1, 0.5, 1)
		g:SetBlendMode("ADD")
		g:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
		g:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
		k.ember = g
	end
	local h = f.GetHeight and f:GetHeight() or 0
	g:SetHeight(h > 0 and math.min(EMBER_H, h) or EMBER_H)
	local r, gg, b = Theme.Color("ember")
	g:SetVertexColor(r, gg, b, alpha)
	g:Show()
	return g
end

-- Hearth's transparent window: bare, its board and ember light out too.
local function bareBoard(f)
	bare(f)
	local k = f.psSkin.kit
	if k then
		if k.board then k.board:Hide() end
		if k.ember then k.ember:Hide() end
	end
end

-- Hearth's plank: a control's ground shading down to its foot, edged in
-- copper. A primary button keeps the flat house fill for the accent
-- W.Button lays on it.
local function plank(f)
	if f.psPrimary then
		local k = f.psSkin.kit
		if k and k.board then k.board:Hide() end
		fill(f):SetVertexColor(Theme.Color("control"))
	else
		local top = { Theme.Color("control") }
		board(f, top, shifted(top, -0.06))
	end
	local r, g, b = Theme.Color("frameEdge")
	Theme.Border(f, r, g, b, 0.6)
	hoverWash(f)
end

Theme.SKIN_PAINT.hearth = {
	-- A walnut board lit from above: the bg -> bgBottom gradient at the
	-- player's opacity (their own ground colour darkened toward its foot
	-- when they picked one), the ember light along its top edge, a copper
	-- hairline by the window border setting (the player's own colour wins)
	-- and the house drop shadow in Hearth's warm shade.
	window = function(f)
		if f.psBare then return bareBoard(f) end
		local a = veilAlpha(f, "bg")
		local top, bottom = { Theme.Color("bg") }, { Theme.Color("bgBottom") }
		if isColor(f.psBgColor) then
			top = { f.psBgColor[1], f.psBgColor[2], f.psBgColor[3] }
			bottom = shifted(top, -0.08)
		end
		top[4], bottom[4] = a, a
		board(f, top, bottom)
		-- Small boards (the guide window, the toasts) sit closer to the fire
		-- than the big windows.
		ember(f, ((f.psGuide or f.psLight) and 0.2 or 0.16) * math.min(1, a + 0.2))
		local shown, size = Theme.WindowBorder()
		if shown and not f.psNoBorder then
			local br, bg, bb, ba = Theme.Color("windowBorder")
			Theme.Border(f, br, bg, bb, ba, nil, size)
		else
			hideBorder(f)
		end
		if get("ui.shadow") == false then
			if f.psShadow then f.psShadow:Hide() end
			return
		end
		local s = shadowFor(f)
		local sr, sg, sb, sa = Theme.Color("shadow")
		for i = 1, #s.parts do s.parts[i]:SetVertexColor(sr, sg, sb, sa * math.min(1, a + 0.1)) end
		s:Show()
	end,
	-- Menus and detail panes: a flat, slightly lighter board with a dark
	-- copper edge.
	panel = function(f)
		if f.psBare then return bare(f) end
		fill(f):SetVertexColor(Theme.Color("panel"))
		Theme.Border(f, Theme.Color("frameEdgeDark"))
	end,
	-- Action tiles: a shaded recess in the board.
	tile = function(f)
		local r, g, b = Theme.Color("shade")
		fill(f):SetVertexColor(r, g, b, 0.35)
		Theme.Border(f, Theme.Color("titleLine"))
		hoverWash(f)
	end,
	sidebar = function(f)
		fill(f):SetVertexColor(Theme.Color("sidebar"))
	end,
	inset = function(f)
		local r, g, b = Theme.Color("shade")
		fill(f):SetVertexColor(r, g, b, 0.4)
		hideBorder(f)
	end,
	-- Text buttons (W.Button) and dropdowns are planks: the control ground
	-- shading down, a copper edge; primary buttons take the accent fill the
	-- house gives them. Anything else painted as a button (cards, rows) is
	-- a shaded recess.
	button = function(f)
		if f.psTextButton then return plank(f) end
		local r, g, b = Theme.Color("shade")
		fill(f):SetVertexColor(r, g, b, 0.35)
		Theme.Border(f, Theme.Color("titleLine"))
		hoverWash(f)
	end,
	dropdown = plank,
	editbox = function(f)
		fill(f):SetVertexColor(Theme.Color("inputBg"))
		if f.psFocused then
			local r, g, b = Theme.Accent()
			Theme.Border(f, r, g, b, 0.8)
		else
			Theme.Border(f, Theme.Color("frameEdgeDark"))
		end
	end,
	-- The tick box: a recess edged in copper, the house check in the accent
	-- inside it.
	checkbox = function(f)
		HOUSE_PAINT.checkbox(f)
		local d = f.psSkin
		d.box:SetSize(15, 15)
		if f.psOnWorld then return end
		fill(d.box):SetVertexColor(Theme.Color("inputBg"))
		Theme.Border(d.box, Theme.Color("box"))
	end,
}
