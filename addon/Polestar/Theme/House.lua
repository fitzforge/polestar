-- The house look: Polestar's own skin ("polestar", the default; docs/DESIGN.md,
-- "The Guiding-Star Instrument"), apart from the Theme core (Theme/Theme.lua)
-- that resolves every look. Here: Polestar gold, the status and subject
-- colours, the colour schemes (Dusk, Night, Graphite), the type ladder and
-- the frame painters. This file loads first (Theme/Theme.xml); Theme.lua
-- takes these as its own locals as it loads, and hands the painters its
-- paint helpers (House.Bind) before anything paints. A skin drawn from the
-- house look (a registered skin on base "polestar") paints with them too.

local ADDON, ns = ...
local House = {}
ns.House = House

-- Polestar gold: the accent of every scheme.
local DEFAULT_ACCENT = { 0.9, 0.73, 0.4 }

-- Status and subject colours: one set for every scheme (all schemes are
-- night grounds), so a quest is the same gold everywhere.
local SHARED = {
	success = { 0.42, 0.85, 0.6, 1 },
	warning = { 0.98, 0.75, 0.3, 1 },
	danger = { 0.96, 0.45, 0.45, 1 },
	quest = { 1, 0.84, 0.45, 1 },
	npc = { 0.58, 0.79, 1, 1 },
	item = { 0.78, 0.68, 1, 1 },
	place = { 0.96, 0.68, 0.52, 1 },
	object = { 0.86, 0.79, 0.66, 1 },
	level = { 0.96, 0.97, 0.99, 1 },
	skill = { 0.6, 0.88, 0.46, 1 },
	spell = { 0.47, 0.86, 0.93, 1 },
	faction = { 0.97, 0.6, 0.79, 1 },
	area = { 0.93, 0.75, 0.6, 1 },
	achievement = { 1, 0.64, 0.32, 1 },
	dungeon = { 0.64, 0.52, 1, 1 }, -- dungeon and raid entrances (portal violet)
	rare = { 1, 0.5, 0.32, 1 }, -- rare NPCs (ember; treasures keep object)
}
House.DEFAULT_ACCENT, House.SHARED = DEFAULT_ACCENT, SHARED

-- A scheme: the grounds (bg window, panel raised panels and popups, panelAlt
-- controls, sidebar, footer, sky the top of the header band), the text
-- ladder (100/70/50, tinted toward the ground so secondary text stays in the
-- world), ink (the colour of hairlines and washes), shade (wells, text
-- shadows, art fades), scrim (dark grounds for text on zone art), onAccent
-- (text and glyphs on an accent fill) and shadow (window drop shadow).
local SCHEMES = {
	-- The default: Night lifted to dusk, still navy, clearly lighter.
	dusk = {
		bg = { 0.095, 0.115, 0.178, 0.97 },
		panel = { 0.11, 0.133, 0.203, 0.98 },
		panelAlt = { 0.139, 0.166, 0.249, 1 },
		sidebar = { 0.072, 0.088, 0.14, 1 },
		footer = { 0.08, 0.097, 0.151, 1 },
		sky = { 0.156, 0.196, 0.329, 1 },
		text = { 0.967, 0.974, 0.991, 1 },
		textDim = { 0.765, 0.793, 0.868, 1 },
		textMuted = { 0.606, 0.637, 0.726, 1 },
		ink = { 1, 1, 1, 1 },
		star = { 1, 1, 1, 1 },
		shade = { 0, 0, 0.02, 1 },
		scrim = { 0.02, 0.03, 0.06, 1 },
		onAccent = { 0.04, 0.05, 0.08, 1 },
		shadow = { 0, 0, 0.02, 0.6 },
	},
	-- The original deep night navy-black, unchanged.
	night = {
		bg = { 0.039, 0.051, 0.086, 0.97 },
		panel = { 0.051, 0.066, 0.11, 0.98 },
		panelAlt = { 0.075, 0.094, 0.149, 1 },
		sidebar = { 0.027, 0.035, 0.063, 1 },
		footer = { 0.031, 0.04, 0.071, 1 },
		sky = { 0.075, 0.106, 0.2, 1 },
		text = { 0.96, 0.97, 0.99, 1 },
		textDim = { 0.69, 0.72, 0.8, 1 },
		textMuted = { 0.5, 0.54, 0.63, 1 },
		ink = { 1, 1, 1, 1 },
		star = { 1, 1, 1, 1 },
		shade = { 0, 0, 0.02, 1 },
		scrim = { 0.02, 0.03, 0.06, 1 },
		onAccent = { 0.04, 0.05, 0.08, 1 },
		shadow = { 0, 0, 0.02, 0.6 },
	},
	-- Neutral and lighter: slate grey, the faintest cool cast.
	graphite = {
		bg = { 0.131, 0.137, 0.146, 0.97 },
		panel = { 0.15, 0.156, 0.165, 0.98 },
		panelAlt = { 0.182, 0.19, 0.202, 1 },
		sidebar = { 0.104, 0.109, 0.116, 1 },
		footer = { 0.113, 0.118, 0.125, 1 },
		sky = { 0.2, 0.215, 0.239, 1 },
		text = { 0.974, 0.974, 0.974, 1 },
		textDim = { 0.793, 0.801, 0.813, 1 },
		textMuted = { 0.635, 0.646, 0.663, 1 },
		ink = { 1, 1, 1, 1 },
		star = { 1, 1, 1, 1 },
		shade = { 0, 0, 0, 1 },
		scrim = { 0.03, 0.03, 0.035, 1 },
		onAccent = { 0.05, 0.05, 0.06, 1 },
		shadow = { 0, 0, 0, 0.6 },
	},
}
House.SCHEMES = SCHEMES

-- The size ladder, read at arm's length over a busy game world.
local ROLES = {
	hero = { "semibold", 26 },     -- shell page titles
	display = { "semibold", 18 },  -- the guide's step title, empty-state titles
	title = { "semibold", 15 },    -- window and guide titles
	heading = { "semibold", 13 },  -- section headers
	body = { "medium", 13 },       -- goal lines, row labels
	label = { "medium", 12 },      -- controls
	note = { "regular", 12 },      -- tips and descriptions
	small = { "medium", 11 },      -- secondary lines
	number = { "semibold", 12 },   -- counters
	caption = { "semibold", 11 },  -- pills and chips
	goal = { "medium", 14 },        -- the guide window's goal lines
	name = { "semibold", 15 },     -- the person to talk to now
	mono = { "medium", 12 },
}
House.ROLES = ROLES

---------------------------------------------------------------------------
-- The house look's own tokens (the 0.3.8 glow-up, docs/DESIGN.md): what the
-- house look draws that no other look does. Theme.House(key) answers them
-- only while the built-in house skin is the one drawn (Theme.SkinId() is
-- "polestar"); a skin registered on the house look, Halo, Hearth, the
-- game's looks and a picker card of another skin get nil, and the code
-- asking keeps its own way, so no other look changes with these.
--   raised       While you're here's card: the control ground at this share
--   clearShade   ... in the transparent style: the scrim at this share
--   lit          the arrow's goal: the target bar's colour at this share,
--                fading out across its row
--   cardFacts    the heads-up card leads with its title, its facts under
--                it in sentence case, and draws no stripe
--   toastBand    the While you're here toast wears the alerts' anatomy:
--                the night band, the glyph in a ring, the distance in its
--                header, the line on up to two lines
--   edgeLight    a window's light inside its top edge: ink at this share
--   edgeKey      its contact line just outside, with the shadow: shade at
--                this share
--   openSections the guide window's body sections go without hairlines
--   loneTab      a lone guide tab takes the room its title needs
--   well         a tick box's well: shade at this share
--   rareEmber    the rare button's glyph and name in Rare Ember, outlined
--   dialogFoot   a dialog's and the guide end's footer height (the 4-point
--                rhythm; 54 and 60 in the other looks)
--   endEmblem    the guide end's emblem (44 in the other looks)
--   sidePad      the party panel's padding (10 in the other looks)
--   sideHead     the party panel's head, as the guide window's tab strip
--                (26 in the other looks)
--   sourceLines  Polestar's tooltip source lines stand out: the source's
--                name in the accent, the type and place in textDim (textDim
--                and textMuted in the other looks)
---------------------------------------------------------------------------

local TOKENS = {
	raised = 0.85,
	clearShade = 0.32,
	lit = 0.13,
	cardFacts = true,
	toastBand = true,
	edgeLight = 0.07,
	edgeKey = 0.42,
	openSections = true,
	loneTab = true,
	well = 0.12,
	rareEmber = true,
	dialogFoot = 56,
	endEmblem = 40,
	sidePad = 12,
	sideHead = 28,
	sourceLines = true,
}

---------------------------------------------------------------------------
-- The painters, one per frame kind (Theme.Skin(frame, kind)), with
-- Theme.lua's paint helpers, handed over by House.Bind as it loads.
---------------------------------------------------------------------------

local Theme, fill, hoverWash, glyph, bare, hideBorder, shadowFor, isColor, get
function House.Bind(t)
	Theme, fill, hoverWash, glyph, bare, hideBorder = t.Theme, t.fill, t.hoverWash, t.glyph, t.bare, t.hideBorder
	shadowFor, isColor, get = t.shadowFor, t.isColor, t.get
	function Theme.House(key)
		if Theme.SkinId() ~= "polestar" then return nil end
		return TOKENS[key]
	end
	House.Bind = nil
end

-- The house window's edges (Theme.House "edgeLight"): a 1px light inside
-- the top edge, under the border (ink at `edgeLight`), as light catching
-- a pane; with the drop shadow, a 1px contact line just outside the window
-- and its border (shade at `edgeKey`), so its edge stays crisp on bright
-- ground. n: the border's thickness in pixels (0: none; Theme.Border lays
-- its first pixel inside the frame, the rest outside). Kept in
-- f.psSkin.edge (the light, then the top, bottom, left and right lines),
-- which a skin switch hides (Theme.lua's clearSkin).
local function edges(f, alpha, on, contact, n)
	local d = f.psSkin
	local e = d.edge
	if not on then
		if e then for i = 1, 5 do e[i]:Hide() end end
		return
	end
	if not e then
		-- Made once the window is on screen: a window is painted as it is
		-- built and most are hidden at once, so this waits for its first
		-- showing, or a moment after this paint if it stays shown. A window
		-- never opened has none.
		if not f.psEdgeNow then
			if not f.psEdgeWait then
				f.psEdgeWait = true
				local function shown(self)
					if self.psSkin.edge or not self:IsVisible() or not Theme.House("edgeLight") then return end
					self.psEdgeNow = true
					Theme.Repaint(self)
				end
				f:HookScript("OnShow", shown)
				ns.After(0, function() shown(f) end)
			end
			return
		end
		e = {}
		for i = 1, 5 do
			e[i] = f:CreateTexture(nil, i == 1 and "BORDER" or "BACKGROUND", nil, i == 1 and 6 or -8)
			e[i]:SetTexture(Theme.Media("white"))
		end
		d.edge = e
	end
	local px = Theme.Pixel(f)
	local inner, o = n > 0 and px or 0, px * math.max(0, n - 1)
	local light, top, bottom, left, right = e[1], e[2], e[3], e[4], e[5]
	light:ClearAllPoints(); light:SetPoint("TOPLEFT", f, "TOPLEFT", inner, -inner); light:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inner, -inner); light:SetHeight(px)
	local ir, ig, ib = Theme.Color("ink")
	light:SetVertexColor(ir, ig, ib, TOKENS.edgeLight * math.min(1, alpha))
	light:Show()
	top:ClearAllPoints(); top:SetPoint("BOTTOMLEFT", f, "TOPLEFT", -o - px, o); top:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", o + px, o); top:SetHeight(px)
	bottom:ClearAllPoints(); bottom:SetPoint("TOPLEFT", f, "BOTTOMLEFT", -o - px, -o); bottom:SetPoint("TOPRIGHT", f, "BOTTOMRIGHT", o + px, -o); bottom:SetHeight(px)
	left:ClearAllPoints(); left:SetPoint("TOPRIGHT", f, "TOPLEFT", -o, o); left:SetPoint("BOTTOMRIGHT", f, "BOTTOMLEFT", -o, -o); left:SetWidth(px)
	right:ClearAllPoints(); right:SetPoint("TOPLEFT", f, "TOPRIGHT", o, o); right:SetPoint("BOTTOMLEFT", f, "BOTTOMRIGHT", o, -o); right:SetWidth(px)
	local sr, sg, sb = Theme.Color("shade")
	for i = 2, 5 do
		e[i]:SetVertexColor(sr, sg, sb, TOKENS.edgeKey * math.min(1, alpha + 0.1))
		e[i]:SetShown(contact)
	end
end

local HOUSE_PAINT = {
	-- Every window: the ground at the player's opacity, the window border
	-- (Theme.WindowBorder: on or off, its colour and thickness) and the
	-- drop shadow unless the player turned it off. One window may carry its
	-- own ground colour (f.psBgColor, { r, g, b }) and go without the border
	-- (f.psNoBorder): the guide window's own look (UI/GuideFrame.lua). In the
	-- house look itself, its edges (edges above).
	window = function(f)
		if f.psBare then
			edges(f)
			return bare(f)
		end
		local r, g, b = Theme.Color("bg")
		if isColor(f.psBgColor) then r, g, b = f.psBgColor[1], f.psBgColor[2], f.psBgColor[3] end
		local alpha = f.psBgAlpha or Theme.GroundAlpha()
		fill(f):SetVertexColor(r, g, b, alpha)
		local shown, size = Theme.WindowBorder()
		local n = 0
		if shown and not f.psNoBorder then
			local br, bg, bb, ba = Theme.Color("windowBorder")
			Theme.Border(f, br, bg, bb, ba, nil, size)
			n = f.psBorderSize
		else
			hideBorder(f)
		end
		local shadow = get("ui.shadow") ~= false
		edges(f, alpha, Theme.House("edgeLight") ~= nil, shadow, n)
		if not shadow then
			if f.psShadow then f.psShadow:Hide() end
			return
		end
		local s = shadowFor(f)
		local sr, sg, sb, sa = Theme.Color("shadow")
		for i = 1, #s.parts do s.parts[i]:SetVertexColor(sr, sg, sb, sa * math.min(1, alpha + 0.1)) end
		s:Show()
	end,
	-- A raised panel; a menu or popup over other frames (f.psMenu) on
	-- menuBg, never see-through.
	panel = function(f)
		if f.psBare then return bare(f) end
		fill(f):SetVertexColor(Theme.Color(f.psMenu and "menuBg" or "panel"))
		Theme.Border(f, Theme.Color("border"))
	end,
	sidebar = function(f)
		fill(f):SetVertexColor(Theme.Color("sidebar"))
	end,
	inset = function(f)
		local r, g, b = Theme.Color("shade")
		fill(f):SetVertexColor(r, g, b, 0.25)
		hideBorder(f)
	end,
	button = function(f)
		fill(f):SetVertexColor(Theme.Color("panelAlt"))
		Theme.Border(f, Theme.Color("border"))
		hoverWash(f)
	end,
	dropdown = function(f)
		fill(f):SetVertexColor(Theme.Color("panelAlt"))
		Theme.Border(f, Theme.Color("border"))
		hoverWash(f)
	end,
	-- An action tile (W.ActionTile): a button's ground in the house style.
	tile = function(f)
		fill(f):SetVertexColor(Theme.Color("panelAlt"))
		Theme.Border(f, Theme.Color("border"))
		hoverWash(f)
	end,
	editbox = function(f)
		local r, g, b = Theme.Color("shade")
		fill(f):SetVertexColor(r, g, b, 0.35)
		if f.psFocused then
			local r, g, b = Theme.Accent()
			Theme.Border(f, r, g, b, 0.8)
		else
			Theme.Border(f, Theme.Color("border"))
		end
	end,
	checkbox = function(f)
		local d = f.psSkin
		if not d.box then
			d.box = CreateFrame("Frame", nil, f)
			d.box:SetPoint("CENTER", f, "CENTER", 0, 0)
			d.box:SetSize(14, 14)
			d.box.psSkin = {}
			if f.SetCheckedTexture then
				local check = f:CreateTexture(nil, "OVERLAY")
				check:SetTexture(Theme.Media("check"))
				check:SetSize(12, 12)
				check:SetPoint("CENTER", f, "CENTER", 0, 0)
				f:SetCheckedTexture(check)
				d.check = check
			end
		end
		-- psOnWorld (the transparent guide window's tick boxes): the scrim
		-- inside and an ink edge, so the box holds over bright ground.
		if f.psOnWorld then
			local r, g, b = Theme.Color("scrim")
			fill(d.box):SetVertexColor(r, g, b, 0.6)
			local tr, tg, tb = Theme.Color("textDim")
			Theme.Border(d.box, tr, tg, tb, 0.7)
		else
			-- The well: the house look's light one (Theme.House "well"), else
			-- 0.35 of the shade.
			local r, g, b = Theme.Color("shade")
			fill(d.box):SetVertexColor(r, g, b, Theme.House("well") or 0.35)
			Theme.Border(d.box, Theme.Wash("box"))
		end
		if d.check then d.check:SetVertexColor(Theme.Accent()) end
		d.box:Show()
		hoverWash(f)
	end,
	tab = function(f)
		local d = f.psSkin
		if not d.bar then
			d.bar = f:CreateTexture(nil, "OVERLAY")
			d.bar:SetTexture(Theme.Media("white"))
			d.bar:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
			d.bar:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
		end
		d.bar:SetHeight(2)
		d.bar:SetVertexColor(Theme.Accent())
		d.bar:SetShown(f.psSelected and true or false)
		hoverWash(f)
		-- Back from a game look's tab, whose label sat on its art.
		local label = rawget(f, "Label")
		if f.psKitLabel and label then
			label:ClearAllPoints()
			label:SetPoint("CENTER", f, "CENTER", 0, 0)
			f.psKitLabel = nil
		end
	end,
	close = function(f)
		glyph(f, "close", 14):SetVertexColor(Theme.Color("textDim"))
		hoverWash(f):SetVertexColor(Theme.Wash("hover"))
	end,
	scrollbar = function(f)
		-- Back from a game look's scroll bar (Polestar_Looks/GameSkins.lua): the slim
		-- white thumb over the whole bar.
		local thumb = f.thumb or f.psThumb
		if f.psInset then
			f.psInset, f.psReach = nil, nil
			f:SetWidth(6)
			if thumb and thumb.SetTexture then
				thumb:SetTexture(Theme.Media("white"))
				thumb:SetTexCoord(0, 1, 0, 1)
				thumb:SetWidth(2)
			end
		end
		if thumb and thumb.SetVertexColor then thumb:SetVertexColor(Theme.Wash("thumb")) end
	end,
}
House.PAINT = HOUSE_PAINT
