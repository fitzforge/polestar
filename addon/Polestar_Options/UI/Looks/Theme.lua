-- The settings window's Theme page (look group, key "theme"): the looks
-- every Polestar surface shares, organised per element. The skin (picture
-- cards), the accent, the grounds, the text ladder and the colours names are
-- drawn in; the font faces, sizes, outline and shadow of all Polestar text;
-- the windows' border, hairlines, shadow, band, haze and rim; motion and
-- sound. Every setting resolves in Polestar.Theme (Theme/Theme.lua: the
-- palette, Theme.FontSpec) and repaints live through Theme.Refresh, the
-- page's preview with it.
--
-- Each tab pins a live preview over its rows (built the first time the tab
-- shows): the real surfaces at their true size, drawn by their own code in
-- the theme in use: the guide window with its heads-up card, a rare alert,
-- the arrow and the two kinds of button; the Names tab shows every subject's
-- name in its colour instead of the arrow (see "The preview" below).

local ns = Polestar
local Theme, W = ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, ipairs = math.floor, math.max, math.min, ipairs

local PAGE = L["Theme"]
local NEW = "0.3.8"

local function percent(v) return floor(v * 100 + 0.5) .. "%" end
local function signed(v)
	local p = v < 0 and math.ceil(v * 100 - 0.5) or floor(v * 100 + 0.5)
	return (p > 0 and "+" or "") .. p .. "%"
end
local function times(v) return string.format("%.2gx", v) end
local function px(v) return string.format(L["%d px"], floor(v + 0.5)) end

-- Settings of the house style alone: every other skin brings its own grounds,
-- no starlit band, haze or rim and no drop shadow (Theme.lua, "Skins").
local function houseOnly() return Theme.SkinKey() ~= "polestar" end
local function borderOff() return not ns.Get("ui.border") end
local function bandOff() return houseOnly() or not ns.Get("ui.band") end
local function shadowOff() return houseOnly() or not ns.Get("ui.shadow") end

local function labelIn(list, key)
	for _, c in ipairs(list) do
		if c.value == key then return c.text or c.label end
	end
end
local function skinLabel() return labelIn(Theme.SkinChoices(), Theme.SkinId and Theme.SkinId() or Theme.SkinKey()) or L["Polestar"] end
local function schemeLabel() return labelIn(Theme.SchemeChoices(), Theme.SchemeKey()) or "" end
-- Where a colour comes from while it is not your own: the skin's, or in the
-- house style its scheme's.
local function fromSkin()
	if Theme.SkinKey() == "polestar" then return schemeLabel() end
	return skinLabel()
end

-- The colours names are drawn in, by subject: label, search words.
local SUBJECT = {
	npc = { L["NPCs"], "npc, npc names, person, people, characters, talk to, giver, name colour" },
	quest = { L["Quests"], "quest, quest names, quests, title, gold, name colour" },
	item = { L["Items"], "item, item names, items, loot, collect, objects, name colour" },
	place = { L["Places"], "place, location, town, go to, destination, waypoint" },
	object = { L["Objects"], "object, objects, treasure, chest, interact" },
	area = { L["Areas"], "area, region, subzone, explore" },
	dungeon = { L["Dungeons"], "dungeon, dungeons, raid, raids, instance, portal, entrance" },
	rare = { L["Rares"], "rare, rares, rare npcs, elite, silver dragon" },
	skill = { L["Skills"], "skill, skills, profession, professions, crafting, trade" },
	spell = { L["Spells"], "spell, spells, ability, abilities, cast, use" },
	faction = { L["Factions"], "faction, factions, reputation, rep" },
	achievement = { L["Achievements"], "achievement, achievements" },
	level = { L["Levels"], "level, levels, number" },
	success = { L["Success"], "success, done, complete, finished, green, check" },
	warning = { L["Warnings"], "warning, warnings, caution, orange, attention" },
	danger = { L["Danger"], "danger, error, errors, red, failed, alert" },
}

---------------------------------------------------------------------------
-- The preview: the real surfaces at their true size over the zone you stand
-- in. The guide window (the Guide window page's own drawing,
-- UI.GuideWindowScene) with the heads-up card on its top edge, cropped at
-- the hero's foot; a rare alert and the arrow (their own builders); on the
-- Names tab a card of every subject's name in its colour instead of the
-- arrow. Settings that dress the settings window itself (its sidebar, its
-- header's band, haze and rim, its border) light its own parts too.
---------------------------------------------------------------------------

-- The stage's height laid out alone (the window gives its hero's); the
-- chrome's row over the scene, the room at its foot, the side pads, the gap
-- between the guide window and the right of the scene.
local PREVIEW_H, TOP, BOTTOM, PAD, GAP = 196, 34, 14, 32, 40
local NAME_ROW = 22 -- a line of the names card
local SHADOW_ROOM = 40 -- each side of the guide window's box, for its drop shadow

local function buildScene(view, names)
	local UI, P = ns.UI, ns.UI.Preview
	local TS = UI.Toasts
	local f = P.Stage(view, { height = PREVIEW_H, backdrop = "world" })
	-- The window draws "Preview" and "Live" over it; this names what it shows.
	f.caption = L["Every Polestar surface, in your theme"]

	-- The guide window, drawn by the Guide window page's code; cropped at
	-- the hero's foot, it fades out there as a stage's cropped scene does.
	local G = UI.GuideWindowScene and UI.GuideWindowScene(f)
	if G then
		function G:SetCut(cut) f:SetCut(cut) end
	end
	f.Scene = G
	f.Guide = G and G.Window
	f.StepTitle = G and G.Person.Name
	-- The heads-up card on its top edge, a rare alert: their own builders.
	local heads = TS and TS.Sandbox and TS.Sandbox("headsup", f)
	local toast = TS and TS.Sandbox and TS.Sandbox("rare", f)
	f.Heads, f.Toast = heads, toast
	if heads then heads:Show() end
	if toast then toast:Show() end
	-- The arrow toward the goal (Nav's own dial).
	local A = ns.Nav and ns.Nav.arrow
	local arrow
	if not names and A and A.BuildDial then
		local holder = CreateFrame("Frame", nil, f)
		holder:SetSize(A.WIDTH, A.HEIGHT)
		arrow = { holder = holder, dial = A.BuildDial(holder), look = {} }
	end
	f.Arrow = arrow and arrow.holder
	-- The names card: each subject's name in its own colour.
	local card
	if names then
		card = CreateFrame("Frame", nil, f)
		Theme.Skin(card, "panel")
		card.Words = {}
		for _, name in ipairs(Theme.SUBJECTS) do
			local s = SUBJECT[name]
			if s then
				local fs = W.Text(card, "label", name)
				fs:SetText(s[1])
				card.Words[#card.Words + 1] = { fs = fs, name = name }
			end
		end
	end
	f.Names = card

	-- Their paint from the settings (the toasts' and the arrow's own).
	local function paint()
		if heads then
			TS.ApplyLook(heads, true)
			TS.Refill("headsup", heads)
			heads:SetAlpha(TS.Alpha("headsup"))
		end
		if toast then
			TS.ApplyLook(toast, true)
			toast:SetAlpha(TS.Alpha("rare"))
		end
		if arrow then
			A.ReadLook(arrow.look)
			A.PaintDial(arrow.dial, arrow.look, A.StyleFor(ns.Get("nav.arrowStyle")), "travel", -0.35, 381, L["Brill"], 95)
		end
	end
	f.Paint = paint
	f.psWatch = { "toasts.", "nav.arrow", "ui." }

	-- -> the hero's height (PREVIEW_H laid out alone): the guide window at
	-- the left under its heads-up card, cropped at the hero's foot; at the
	-- right the rare alert, then the arrow or the names. A page too narrow
	-- for both keeps the window and the arrow.
	function f:Layout(width, height)
		height = height or PREVIEW_H
		self:SetWidth(width)
		self.psWidth, self.psHeight = width, height
		paint()
		local t = self:TrueScale()
		local scale = (tonumber(ns.Get("ui.scale")) or 1) * t
		-- The window's own width first (it lays itself out), then its box.
		local winW = 340 * scale
		if G then
			G:Layout(winW + 2 * SHADOW_ROOM, height)
			winW = G.Window:GetWidth() * scale
		end
		local hk = heads and scale * TS.Scale("headsup") or 0
		local hw, hh = heads and heads:GetWidth() * hk or 0, heads and heads:GetHeight() * hk or 0
		local leftW = max(winW, hw)
		local tk = toast and TS.Scale("rare") * t or 0
		local tw, th = toast and toast:GetWidth() * tk or 0, toast and toast:GetHeight() * tk or 0
		local rightX = PAD + leftW + GAP
		local rightW = width - PAD - rightX
		local wide = toast ~= nil and rightW >= tw * 0.75
		local snap = P.Snap
		-- Left: the heads-up card, the window under it to the foot.
		local leftX = wide and PAD or max(PAD, floor((width - leftW - (arrow and (GAP + A.WIDTH * t) or 0)) / 2))
		if heads then
			heads:SetScale(hk)
			heads:ClearAllPoints()
			heads:SetPoint("TOPLEFT", self, "TOPLEFT", snap(heads, (leftX + (leftW - hw) / 2) / hk), snap(heads, -TOP / hk))
		end
		if G then
			local top = TOP + hh
			G:ClearAllPoints()
			-- Its box wider than the window by its shadow's room, so the box
			-- crops only at its foot, the hero's.
			G:SetPoint("TOPLEFT", self, "TOPLEFT", snap(self, leftX + (leftW - winW) / 2 - SHADOW_ROOM), -snap(self, top))
			G:SetSize(winW + 2 * SHADOW_ROOM, max(1, height - top))
			G:Layout(winW + 2 * SHADOW_ROOM, max(1, height - top))
		end
		-- Right: the rare alert, then the arrow or the names.
		if toast then toast:SetShown(wide) end
		if card then card:SetShown(wide) end
		local y = TOP
		if wide then
			local k = min(1, rightW / max(1, tw))
			toast:SetScale(tk * k)
			toast:ClearAllPoints()
			toast:SetPoint("TOPLEFT", self, "TOPLEFT", snap(toast, rightX / (tk * k)), snap(toast, -y / (tk * k)))
			self:Floor(toast)
			y = y + th * k + 24
		end
		if card and wide then
			-- Two columns of names, as many lines as the room under the alert holds.
			local cw = min(rightW, max(tw * min(1, rightW / max(1, tw)), 240))
			local lines = math.ceil(#card.Words / 2)
			local room = height - y - BOTTOM
			local row = min(NAME_ROW, max(14, floor((room - 16) / max(1, lines))))
			for i, word in ipairs(card.Words) do
				local col, line = (i - 1) % 2, floor((i - 1) / 2)
				word.fs:ClearAllPoints()
				word.fs:SetPoint("TOPLEFT", card, "TOPLEFT", 12 + col * (cw / 2), -(8 + line * row))
			end
			card:SetSize(cw, 16 + lines * row)
			card:ClearAllPoints()
			card:SetPoint("TOPLEFT", self, "TOPLEFT", snap(self, rightX), -snap(self, y))
			self:Floor(card)
		elseif arrow then
			-- The arrow at its true size in what is left: under the alert, or
			-- beside the window on a narrow page.
			local ax, aw = wide and rightX or (leftX + leftW + GAP), wide and rightW or A.WIDTH * t
			local roomH = height - y - BOTTOM
			local ak = t * min(1, roomH / A.HEIGHT, aw / A.WIDTH)
			arrow.holder:SetScale(max(0.2, ak))
			arrow.holder:ClearAllPoints()
			arrow.holder:SetPoint("TOP", self, "TOPLEFT", snap(arrow.holder, (ax + aw / 2) / ak), snap(arrow.holder, -(wide and y or TOP) / ak))
			self:Floor(arrow.holder, -floor(max(0, A.WIDTH * ak - 150) / 2))
		end
		return height
	end

	-- A click on a part finds its setting; the pointer on a setting's row
	-- lights the parts it changes (the settings window's own, for what
	-- dresses it).
	local surfaces = { f.Guide, heads, toast, card }
	local win = PolestarOptions
	local edge = {}
	if G then
		f:Hot(G.Window, "ui.bgOpacity")
		f:Hot(G.Window.Band, "ui.starAlpha")
		f:Hot(G.Person.Name, "ui.headingFont")
		f:Hot(G.Rows[1], "ui.textMutedColor")
		f:Hot(G.Rows[2].Text, "ui.colors.npc")
		f:Hot(G.Rows[3].Text, "ui.colors.item")
		f:Hot(G.Up, "ui.colors.quest")
	end
	if toast then f:Hot(toast, "ui.panelColor") end
	if arrow then
		f:Hot(arrow.dial.dial, "ui.accent")
		f:Hot(arrow.dial.distText, "ui.textSize")
	end
	-- The cards' own primary buttons: the heads-up's, the rare alert's.
	local primaries = {}
	for _, b in ipairs({ heads and rawget(heads, "Act") or false, toast and rawget(toast, "Waypoint") or false }) do
		if b then
			primaries[#primaries + 1] = b
			f:Hot(b, "ui.accent")
		end
	end
	local function light(key, ...) f:Light(key, ...) end
	local function outside(key, ...) if win then f:LightEdge(key, ...) end end
	local everything = {}
	for _, s in pairs(surfaces) do everything[#everything + 1] = s end
	if arrow then everything[#everything + 1] = arrow.holder end
	for _, key in ipairs({ "ui.skin", "ui.scheme", "ui.brightness", "ui.reduceMotion", "ui.animSpeed", "ui.font", "ui.fontOutline", "ui.textShadow" }) do
		light(key, unpack(everything))
	end
	local grounds = { f.Guide, heads, toast }
	for _, key in ipairs({ "ui.bgOpacity", "ui.bgColor" }) do light(key, unpack(grounds)) end
	light("ui.panelColor", toast, heads, card)
	-- Every part the accent paints: in the scene the guide window's open tab
	-- (its underline and icon), the current goal's bar and glyph and the
	-- progress bar; the heads-up card's stripe, ring, headline, badge and
	-- primary button; the rare alert's primary button and time bar; the
	-- arrow, which the accent tints unless it has a colour of its own.
	local accents = {}
	local function accent(...)
		for i = 1, select("#", ...) do
			local r = select(i, ...)
			if r then accents[#accents + 1] = r end
		end
	end
	accent(unpack(primaries))
	if G then accent(G.Strip.Bar, G.Strip.Icon, G.Rows[2].Mark, G.Rows[2].Icon, G.Foot.Line) end
	if heads then accent(rawget(heads, "Stripe"), rawget(heads, "Ring"), rawget(heads, "Head"), rawget(heads, "Badge")) end
	if toast then accent(rawget(toast, "Timer")) end
	if arrow then accent(arrow.dial.dial) end
	-- Rings off them: an outline on a part in the accent would not show.
	f:LightRing("ui.accent", unpack(accents))
	f:LightRing("ui.classAccent", unpack(accents))
	-- And every part of the settings window drawn in the accent as the row is
	-- hovered (the emblem, the open page's row, the open tab's underline, the
	-- sliders' fills, the switches that are on, chips, primary buttons, a
	-- focused box's ring) and the gamepad's focus ring: a region in the
	-- accent, at least half opaque; a frame's border by its frame.
	if win then
		local P = ns.UI.Preview
		local function windowAccents()
			local out, seen, ar, ag, ab = {}, {}, Theme.Accent()
			local function walk(fr)
				if not fr:IsVisible() or P.IsStage(fr) then return end
				-- A border's pieces or a pill's (a switch's track) by their frame.
				local own = {}
				for _, t in ipairs(rawget(fr, "psBorder") or {}) do own[t] = true end
				for _, t in ipairs(rawget(fr, "parts") or {}) do own[t] = true end
				for _, r in ipairs({ fr:GetRegions() }) do
					local cr, cg, cb, ca
					if r:GetObjectType() == "FontString" then cr, cg, cb, ca = r:GetTextColor() else cr, cg, cb, ca = r:GetVertexColor() end
					if cr and (ca or 1) >= 0.5 and r:IsShown() and math.abs(cr - ar) + math.abs(cg - ag) + math.abs(cb - ab) < 0.02 then
						local part = own[r] and fr or r
						if not seen[part] then
							seen[part] = true
							out[#out + 1] = part
						end
					end
				end
				for _, c in ipairs({ fr:GetChildren() }) do walk(c) end
			end
			walk(win)
			if _G.PolestarPadRing then walk(_G.PolestarPadRing) end
			return out
		end
		f:LightEach("ui.accent", windowAccents, true)
		f:LightEach("ui.classAccent", windowAccents, true)
	end
	if win then
		local part = function(name) return rawget(win, name) end
		outside("ui.sidebarColor", part("Rail"), part("Sidebar"))
		outside("ui.haze", part("Haze"))
		outside("ui.rim", part("Rim"))
		outside("ui.band", part("Band"))
		outside("ui.starAlpha", part("Band"))
		outside("ui.headingFont", part("Title"))
		outside("ui.headingSize", part("Title"))
		for _, key in ipairs({ "ui.border", "ui.borderSize", "ui.borderColor", "ui.borderAccent", "ui.shadow", "ui.shadowStrength" }) do
			outside(key, win)
		end
	end
	for _, key in ipairs({ "ui.border", "ui.borderSize", "ui.borderColor", "ui.borderAccent", "ui.shadow", "ui.shadowStrength" }) do
		f:LightEdge(key, f.Guide, toast, heads, card)
	end
	if G then
		light("ui.band", G.Window.Band)
		light("ui.starAlpha", G.Window.Band)
		light("ui.hairlineOpacity", G.Strip.Rule, G.Nav.Rule, G.Up.Rule)
		light("ui.textSize", G.Rows[2].Text, G.Rows[3].Text, G.Tip)
		light("ui.headingFont", G.Person.Name)
		light("ui.headingSize", G.Person.Name)
		light("ui.smallSize", G.Strip.Label, G.Nav.Title, G.Person.Where, G.Up.Label)
		light("ui.textColor", G.Rows[2].Text, G.Rows[3].Text)
		light("ui.textDimColor", G.Nav.Title, G.Person.Where, G.Tip)
		light("ui.textMutedColor", G.Rows[1].Text, G.Up)
		-- The names the scene draws in each subject's colour.
		light("ui.colors.npc", G.Person.Name, G.Rows[2].Text)
		light("ui.colors.item", G.Rows[3].Text)
		light("ui.colors.place", G.Person.Where)
		light("ui.colors.success", G.Rows[1].Icon)
		light("ui.colors.level", G.Rows[2].Sub)
		light("ui.colors.quest", G.Up)
	end
	if heads then light("ui.colors.dungeon", heads) end
	if toast then light("ui.colors.rare", toast) end
	if card then
		for _, word in ipairs(card.Words) do light("ui.colors." .. word.name, word.fs) end
	end
	if arrow then light("ui.colors.place", arrow.dial.labelText) end
	return f
end

local function buildPreview(view) return buildScene(view, false) end
local function buildNamesPreview(view) return buildScene(view, true) end
-- The preview, for the other pages and the tests: buildPreview(parent) -> f.
ns.UI.ThemePreview = buildPreview

---------------------------------------------------------------------------
-- The controls
---------------------------------------------------------------------------

-- One swatch per subject, two to a row; the section's Reset puts them all back.
local function subjectControls()
	local out = {}
	for _, name in ipairs(Theme.SUBJECTS) do
		local s = SUBJECT[name]
		if s then
			out[#out + 1] = { kind = "color", key = "ui.colors." .. name, label = s[1], new = NEW,
				search = s[2] .. ", subject colour, text colour, highlight, custom colour, change colour",
				help = L["The colour these are drawn in, everywhere Polestar names them. A colour too dark to read is lifted until it does."],
				shown = function() return Theme.Color(name) end, source = fromSkin }
		end
	end
	return out
end

local function fontChoices(first)
	local list = {}
	if first then list[1] = first end
	for _, c in ipairs(Theme.FontChoices()) do list[#list + 1] = c end
	return list
end

-- The skin in use's preset (Theme/Theme.lua), whether one is applied, and
-- whether the Apply / Undo pair shows (either of them).
local function skinPreset() return Theme.SkinPreset ~= nil and Theme.SkinPreset(Theme.SkinId()) ~= nil end
local function presetApplied() return Theme.SkinPresetApplied ~= nil and Theme.SkinPresetApplied() ~= nil end
local function presetShown() return skinPreset() or presetApplied() end

local skinCards = Theme.DrawSkinCard and true or false
local schemeCards = Theme.DrawSchemeCard and true or false

-- Four tabs, sections by element: Colour (the skin and accent, the grounds),
-- Text (its face, sizes, outline, shadow and colours), Names (the colours
-- names and states are drawn in), Frames (the window's frame, then motion).
-- One element's size, colour and on/off share a row (extras); its finer
-- knobs sit behind the row's cog (more).
local SPECS = {
	-- Colour
	{ page = PAGE, key = "theme", icon = "palette", order = 20, group = "look", tab = L["Colour"], section = L["Skin & accent"],
		preview = buildPreview,
		subtitle = L["The look every Polestar window shares: skin, colours, type, frames and motion."],
		controls = {
		{ kind = skinCards and "cards" or "dropdown", key = "ui.skin", label = L["Skin"], wide = true,
			search = "theme, look, style, frame, skin, halo, hearth, blizzard, classic, forever, inn, wood, ember, parchment",
			help = L["Polestar's own look (the default), Halo (no frame, a soft dark veil, Fira Sans), Hearth (an inn by the fire: warm wood, ember light, parchment text), or the game's own art: WoW Forever, Blizzard and Classic. Style, compact mode and the colours you pick work in each."],
			-- The skin drawn (a saved skin whose addon is gone draws Polestar;
			-- the saved choice is kept for when it returns).
			get = Theme.SkinId and function() return Theme.SkinId() end or nil,
			-- A card shows the skin's name alone; a skin addon's folder is in its tooltip.
			choices = function()
				local list = {}
				for i, c in ipairs(Theme.SkinChoices()) do
					local tip = c.desc
					if c.addon then
						local from = string.format(L["From the addon %s"], c.addon)
						tip = tip and (tip .. "\n" .. from) or from
					end
					list[i] = { value = c.value, label = c.text, tip = tip,
						draw = skinCards and function(card, v) Theme.DrawSkinCard(card, v) end or nil }
				end
				return list
			end },
		-- A skin in several versions (its variants, Skin API 2): the player's
		-- pick, kept per skin (ui.skinVariants.<id>); shown while the skin in
		-- use has them.
		{ kind = "cards", label = L["Variant"], wide = true, new = NEW,
			search = "skin variant, skin version, skin colours, skin style",
			help = L["This skin comes in several versions: pick yours. Each skin keeps its own."],
			needs = function() return Theme.SkinVariants ~= nil and Theme.SkinVariants(Theme.SkinId()) ~= nil end,
			get = function() return Theme.SkinVariant(Theme.SkinId()) end,
			set = function(v) ns.Set("ui.skinVariants." .. Theme.SkinId(), v) end,
			choices = function()
				local list, id = {}, Theme.SkinId()
				for i, v in ipairs(Theme.SkinVariants(id) or {}) do
					list[i] = { value = v.id, label = v.name, tip = v.desc,
						draw = skinCards and function(card, value) Theme.DrawSkinCard(card, id, value) end or nil }
				end
				return list
			end },
		-- A skin may recommend settings of its own (its preset): the player
		-- applies them, and may take them back this session. The pair shows
		-- while the skin has one or one is applied; each dims when it has
		-- nothing to do.
		{ kind = "button", label = function()
				local info = Theme.SkinInfo and Theme.SkinInfo(Theme.SkinId())
				return string.format(L["Apply %s's layout"], info and info.name or "")
			end, button = L["Apply"], new = NEW,
			search = "skin preset, recommended settings, skin layout, apply skin settings",
			help = L["Changes the settings this skin recommends; Undo puts them back."],
			needs = presetShown, disabled = function() return not skinPreset() end,
			onClick = function() Theme.ApplySkinPreset(Theme.SkinId()) end },
		{ kind = "button", label = L["Undo layout"], button = L["Undo"], icon = "reset", new = NEW,
			search = "undo skin preset, restore settings, undo layout",
			help = L["Puts back every setting the skin's layout changed."],
			needs = presetShown, disabled = function() return not presetApplied() end,
			onClick = function() Theme.UndoSkinPreset() end },
		{ kind = "color", key = "ui.accent", label = L["Accent"], linked = { "ui.matchAccent", "ui.classAccent" },
			search = "accent colour, theme colour, highlight colour, tint, gold",
			help = L["Click to pick your own, right-click to go back to the scheme's."],
			shown = function() return Theme.Accent() end,
			source = function()
				if Theme.FollowsClassAccent() then return (UnitClass and UnitClass("player")) or L["Class colour"] end
				return Theme.FollowsEllesmereAccent() and "EllesmereUI" or L["Polestar gold"]
			end },
		{ kind = "toggle", key = "ui.classAccent", label = L["Class colour"], search = "class colour, class color, accent follows class",
			help = L["The accent follows your class: warlock purple, shaman blue, druid orange. Picking your own accent turns this off."] },
	} },
	{ page = PAGE, tab = L["Colour"], section = L["Background"], controls = {
		{ kind = schemeCards and "cards" or "dropdown", key = "ui.scheme", label = L["Scheme"], wide = true,
			search = "colour scheme, theme, dark mode, darker, dusk, night, graphite",
			-- A skin may bring its own scheme; then this has no effect.
			disabled = function() return houseOnly() or (Theme.SkinScheme and Theme.SkinScheme() ~= nil) or false end,
			help = L["How deep the night runs. Dusk is the default, Night the darkest, Graphite a neutral grey; EllesmereUI takes its panel colour and accent. A skin that brings its own colours greys this out."],
			choices = function()
				local list = {}
				for i, c in ipairs(Theme.SchemeChoices()) do
					list[i] = { value = c.value, label = c.text, note = c.addon,
						draw = schemeCards and function(card, v) Theme.DrawSchemeCard(card, v) end or nil }
				end
				return list
			end },
		{ kind = "slider", key = "ui.bgOpacity", label = L["Background"], min = 0, max = 1, step = 0.05, format = percent,
			search = "background opacity, transparency, alpha, see through, translucent",
			help = L["The background opacity of every Polestar window: how much of the world shows through. Right-click to reset."],
			extras = {
				{ kind = "color", key = "ui.bgColor", label = L["Background colour"], disabled = houseOnly,
					search = "background colour, ground, window colour",
					help = L["The ground of every Polestar window. Right-click to go back to the scheme's. Text always stays legible: a colour too light for it is darkened."],
					shown = function() return Theme.Color("bg") end, source = schemeLabel },
			} },
		{ kind = "slider", key = "ui.brightness", label = L["Brightness"], disabled = houseOnly, min = -1, max = 1, step = 0.05, format = signed,
			search = "lighter, darker, light, dark, lift",
			help = L["Lifts or lowers every background together. Right-click to reset."] },
		{ kind = "color", key = "ui.panelColor", label = L["Panels"], alpha = true, disabled = houseOnly, new = NEW,
			search = "panel colour, card, popup, menu, raised, inner background, box colour, ground",
			help = L["The raised panels inside a window: setting groups, menus, cards and toasts, with their opacity."],
			shown = function() return Theme.Color("panel") end, source = schemeLabel },
		{ kind = "color", key = "ui.sidebarColor", label = L["Sidebar"], alpha = true, disabled = houseOnly, new = NEW,
			search = "sidebar colour, side bar, navigation, left column, rail, ground",
			help = L["The sidebar of the settings window and the guide menu, with its opacity."],
			shown = function() return Theme.Color("sidebar") end, source = schemeLabel },
	} },

	-- Text
	{ page = PAGE, tab = L["Text"], section = L["Text"], preview = buildPreview, controls = {
		{ kind = "font", key = "ui.font", label = L["Font"], search = "typeface, text, letters, font face, family",
			help = L["The skin's font (the default: the game's own, Fira Sans in Halo), or a font of your choice."],
			choices = function()
				local list = fontChoices()
				if Theme.IsEllesmere() then list[#list + 1] = { value = "ellesmere", label = "EllesmereUI" } end
				return list
			end,
			get = function() return Theme.FollowsEllesmereFont() and "ellesmere" or ns.Get("ui.font") end,
			set = function(v)
				if v == "ellesmere" then
					ns.Set("ui.matchFont", true)
					return
				end
				ns.Set("ui.font", v)
				if Theme.IsEllesmere() then ns.Set("ui.matchFont", false) end
			end },
		{ kind = "slider", key = "ui.textSize", label = L["Text size"], min = 0.8, max = 1.4, step = 0.05, format = percent,
			search = "text size, font size, bigger text, smaller text, readability, larger, huge, tiny",
			help = L["The size of Polestar's text, apart from the window scale. Changes at once. Right-click to reset."] },
		{ kind = "font", key = "ui.headingFont", label = L["Heading font"], new = NEW,
			search = "heading font, title font, titles, headline, header font, typeface",
			help = L["Window titles, step titles and section headings: the text's font (the default), or one of their own."],
			choices = function() return fontChoices({ value = "body", label = L["Same as the text"] }) end },
		{ kind = "slider", key = "ui.headingSize", label = L["Heading size"], min = 0.7, max = 1.6, step = 0.05, format = percent, new = NEW,
			search = "heading size, title size, bigger titles, smaller titles, headline",
			help = L["Titles and headings, against the text size."] },
		{ kind = "dropdown", key = "ui.fontOutline", label = L["Outline"], new = NEW,
			search = "text outline, border, stroke, thick, readable, contrast, legible",
			help = L["A dark outline round every Polestar letter, for text that holds over any background."],
			choices = { { value = "none", label = L["None"] }, { value = "outline", label = L["Outline"] }, { value = "thick", label = L["Thick outline"] } } },
		{ kind = "dropdown", key = "ui.textShadow", label = L["Shadow"], new = NEW,
			search = "text shadow, drop shadow, glow, depth, readable, contrast",
			help = L["The shadow under every Polestar letter: the skin's, a soft one, the game's hard one, or none."],
			choices = { { value = "skin", label = L["The skin's"] }, { value = "soft", label = L["Soft"] }, { value = "hard", label = L["Hard"] }, { value = "none", label = L["None"] } } },
		{ kind = "slider", key = "ui.smallSize", label = L["Small print"], min = 0.7, max = 1.6, step = 0.05, format = percent, new = NEW,
			search = "small text size, captions, counters, chips, fine print, tiny text, bigger, readability",
			help = L["Secondary lines, captions, chips and counters, against the text size."] },
		{ kind = "color", key = "ui.textColor", label = L["Text colour"], new = NEW, info = true,
			search = "text colour, font colour, white, primary text, main text, readability",
			help = L["Titles, goals and labels. Text always stays legible: a colour too dark to read is lifted until it does."],
			shown = function() return Theme.Color("text") end, source = fromSkin },
		{ kind = "color", key = "ui.textDimColor", label = L["Secondary"], new = NEW,
			search = "secondary text, dim text, descriptions, grey text, font colour",
			help = L["Descriptions, zone names and secondary lines."],
			shown = function() return Theme.Color("textDim") end, source = fromSkin },
		{ kind = "color", key = "ui.textMutedColor", label = L["Muted"], new = NEW,
			search = "muted text, faint, quiet, done goals, hints, grey text, font colour",
			help = L["Finished goals, hints and counts."],
			shown = function() return Theme.Color("textMuted") end, source = fromSkin },
	} },

	-- Names
	{ page = PAGE, tab = L["Names"], section = L["Names & status"], preview = buildNamesPreview, controls = subjectControls() },

	-- Frames
	{ page = PAGE, tab = L["Frames"], section = L["Frame & motion"], preview = buildPreview, controls = {
		{ kind = "slider", key = "ui.borderSize", label = L["Border"], min = 1, max = 4, step = 1, format = px, disabled = borderOff,
			search = "border thickness, thicker border, wide border, border size, window border",
			help = L["In screen pixels; a thicker border grows outward. Right-click to reset."],
			extras = {
				{ kind = "toggle", key = "ui.border", label = L["Window border"], search = "window border, edge, outline, frame",
					help = L["The line around every Polestar window."] },
				{ kind = "color", key = "ui.borderColor", label = L["Border colour"], linked = { "ui.borderAccent" }, disabled = borderOff,
					search = "border colour, edge colour",
					help = L["Click to pick your own, right-click to go back to the scheme's hairline."],
					shown = function() return Theme.Color("windowBorder") end,
					source = function() return ns.Get("ui.borderAccent") and L["Accent"] or L["Hairline"] end },
			} },
		{ kind = "toggle", key = "ui.borderAccent", label = L["Accent border"], disabled = borderOff,
			search = "accent border, gold border, border takes accent",
			help = L["The border takes your accent colour. Picking your own border colour turns this off."] },
		{ kind = "slider", key = "ui.shadowStrength", label = L["Shadow"], min = 0, max = 2, step = 0.05, format = percent, disabled = shadowOff, new = NEW,
			search = "shadow strength, window shadow, darker shadow, lighter shadow, depth, drop shadow opacity",
			help = L["How dark the window shadow falls, against the skin's."],
			extras = {
				{ kind = "toggle", key = "ui.shadow", label = L["Window shadow"], disabled = houseOnly, search = "window shadow, drop shadow, depth",
					help = L["The soft shadow under every window."] },
			} },
		{ kind = "slider", key = "ui.starAlpha", label = L["Band"], min = 0, max = 1, step = 0.05, format = percent, disabled = bandOff, new = NEW,
			search = "starlit band, stars, starfield, sparkle, twinkle, sky, fewer stars, band",
			help = L["How bright the stars in the band shine; at 0% the sky alone."],
			extras = {
				{ kind = "toggle", key = "ui.band", label = L["Starlit band"], disabled = houseOnly, search = "stars, sky, header, night, band",
					help = L["The night sky with its stars across the top of every window. Off: the plain background."] },
			} },
		{ kind = "toggle", key = "ui.haze", label = L["Haze"], disabled = bandOff, new = NEW,
			search = "header haze, glow, blue light, header glow, corner glow",
			help = L["The faint blue light under the top of each window's band."] },
		{ kind = "slider", key = "ui.hairlineOpacity", label = L["Hairlines"], min = 0, max = 3, step = 0.1, format = percent, new = NEW,
			search = "divider, dividers, separator, lines, rules, hairline, border opacity, stronger lines, faint lines",
			help = L["How strongly the thin lines between rows and round panels show, against the skin's."] },
		{ kind = "toggle", key = "ui.rim", label = L["Accent rim"], disabled = houseOnly, new = NEW,
			search = "rim, glow, light, top edge, accent line, corner glow, shine",
			help = L["The lit accent line along the top edge of Polestar's windows, and the light it throws."] },
		{ kind = "toggle", key = "ui.gameMenuButton", label = L["Game menu button"],
			help = L["A Polestar button in the game menu (Esc) that opens the guide menu."],
			search = "game menu, escape, esc, main menu, button, open polestar" },
		{ kind = "toggle", key = "ui.reduceMotion", label = L["Reduce motion"], help = L["No sliding or popping; fades stay short."],
			search = "animations, motion sickness, fps, frame rate, performance, lag, stutter, cpu, slow" },
		{ kind = "slider", key = "ui.animSpeed", label = L["Speed"], min = 0.5, max = 2, step = 0.1, format = times, new = NEW,
			search = "animation speed, faster, slower, snappy, transitions, slide, fade, tween, motion",
			help = L["How fast Polestar's windows slide, fade and pop: 2x takes half the time."] },
	} },
}

-- Essentials (the page's lead tab): the skins, then the ten settings most
-- looks are made of, each a reference to its row on Colour, Text or Frames.
local O = ns.UI and ns.UI.Options
if O and O.Ref then
	local R = O.Ref
	local ESSENTIALS = L["Essentials"]
	local list = {
		{ page = PAGE, tab = ESSENTIALS, lead = true, section = L["Skin"], preview = buildPreview,
			controls = { R(skinCards and "cards" or "dropdown", "ui.skin") } },
		{ page = PAGE, tab = ESSENTIALS, section = L["Colour & frames"], jump = { tab = L["Colour"], section = L["Skin & accent"] },
			controls = { R("color", "ui.accent"), R("dropdown", "ui.scheme", { wide = false }), R("slider", "ui.bgOpacity"), R("slider", "ui.brightness"),
				R("slider", "ui.borderSize"), R("toggle", "ui.reduceMotion") } },
		{ page = PAGE, tab = ESSENTIALS, section = L["Text"], jump = { tab = L["Text"], section = L["Text"] },
			controls = { R("font", "ui.font"), R("slider", "ui.textSize"), R("dropdown", "ui.fontOutline"), R("dropdown", "ui.textShadow") } },
	}
	for _, spec in ipairs(list) do SPECS[#SPECS + 1] = spec end
end

for _, spec in ipairs(SPECS) do
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
