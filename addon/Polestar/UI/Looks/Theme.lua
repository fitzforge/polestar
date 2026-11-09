-- The settings window's Theme page (look group, key "theme"): the looks
-- every Polestar surface shares, organised per element. The skin (picture
-- cards), the accent, the grounds, the text ladder and the colours names are
-- drawn in; the font faces, sizes, outline and shadow of all Polestar text;
-- the windows' border, hairlines, shadow, band, haze and rim; motion and
-- sound. Every setting resolves in Polestar.Theme (Theme/Theme.lua: the
-- palette, Theme.FontSpec) and repaints live through Theme.Refresh, the
-- page's preview with it.
--
-- Each tab pins the same live preview over its rows: a small guide window,
-- the arrow, a toast and the two kinds of button, all drawn by the widget kit
-- from the theme in use (built the first time the tab shows).

local ADDON, ns = ...
local Theme, W = ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, ipairs = math.floor, math.max, math.min, ipairs

local PAGE = L["Theme"]
local NEW = "0.3.7"

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

---------------------------------------------------------------------------
-- The preview
---------------------------------------------------------------------------

local PREVIEW_H, MINI_W, MINI_PAD, TOAST_W = 196, 270, 10, 232

local function buildPreview(view)
	local f = CreateFrame("Frame", nil, view)
	f:SetHeight(PREVIEW_H)
	if f.SetClipsChildren then f:SetClipsChildren(true) end
	-- The sky: the deepest ground, the starlit band (gone with ui.band off),
	-- a soft lift of the sky colour behind the window, the inner hairline.
	W.Fill(f, "scrim", "BACKGROUND", -8)
	f.Lift = W.Tex(f, "BACKGROUND", "glow", nil, -7)
	W.Painter(f.Lift, function(t)
		local r, g, b = Theme.Color("sky")
		t:SetVertexColor(r, g, b, 0.75)
	end)
	f.Band = Theme.Band(f, "BACKGROUND", -6)
	f.Band:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
	f.Band:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
	f.Band:SetHeight(Theme.BAND_H)
	W.Painter(f, function(self) Theme.Border(self, Theme.Wash("divider")) end)

	-- The window draws "Preview" and "Live" over it; this names what it shows.
	f.caption = L["Every Polestar surface, in your theme"]

	-- The guide window, in the window paint of the skin in use, with its
	-- header band, haze and rim.
	local gw = CreateFrame("Frame", nil, f)
	gw:SetWidth(MINI_W)
	Theme.Skin(gw, "window")
	local band = Theme.Band(gw, "BACKGROUND", -5)
	band:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, 0)
	band:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, 0)
	band:SetHeight(48)
	band:SetTexCoord(Theme.BandCoords(MINI_W, 48))
	W.Haze(gw, { width = MINI_W * 0.8, height = 60 })
	W.Rim(gw, { height = 40 })
	local tabGlyph = W.Tex(gw, "ARTWORK", "icon-level", "accent")
	tabGlyph:SetSize(10, 10)
	tabGlyph:SetPoint("LEFT", gw, "TOPLEFT", MINI_PAD, -12)
	local tab = W.Text(gw, "small", "text")
	tab:SetText(L["Tirisfal Glades"])
	tab:SetPoint("LEFT", tabGlyph, "RIGHT", 6, 0)
	local range = W.Text(gw, "small", "textMuted")
	range:SetText("(1\226\128\14713)")
	range:SetPoint("LEFT", tab, "RIGHT", 4, 0)
	local tabRule = W.Divider(gw)
	tabRule:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, -24)
	tabRule:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, -24)
	local tabBar = W.Tex(gw, "ARTWORK", nil, "accent")
	tabBar:SetHeight(2)
	tabBar:SetPoint("BOTTOMLEFT", gw, "TOPLEFT", MINI_PAD - 2, -24)
	W.Painter(tabBar, function(t) t:SetWidth(math.ceil(W.TextWidth(tab) + 10 + 6 + 4)) end)
	local title = W.Text(gw, "heading", "text")
	title:SetText(L["Garren's Haunt"])
	f.StepTitle = title
	title:SetPoint("TOPLEFT", gw, "TOPLEFT", MINI_PAD, -32)
	local zone = W.Text(gw, "small", "textMuted")
	zone:SetText(L["Tirisfal Glades"])
	zone:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -2)
	local function goal(y, glyph, glyphColor, textColor)
		local g = W.Tex(gw, "ARTWORK", glyph, glyphColor)
		g:SetSize(11, 11)
		g:SetPoint("LEFT", gw, "TOPLEFT", MINI_PAD + 2, -y)
		local t = W.Text(gw, "note", textColor)
		t:SetPoint("LEFT", g, "LEFT", 18, 0)
		t:SetWidth(MINI_W - 2 * MINI_PAD - 20)
		return g, t
	end
	local _, done = goal(78, "check", "success", "textMuted")
	done:SetText(L["Collect Doom Weed"] .. " 10/10")
	local curGlyph, cur = goal(98, "icon-kill", "text", "text")
	W.Painter(cur, function(fs)
		fs:SetText(string.format(L["Kill %s"], "|c" .. Theme.Hex("npc") .. L["Rot Hide Mongrel"] .. "|r") .. "  2/5")
	end)
	local curBar = W.Tex(gw, "ARTWORK", nil, "accent")
	curBar:SetSize(2, 16)
	curBar:SetPoint("LEFT", gw, "LEFT", 0, 0)
	curBar:SetPoint("TOP", curGlyph, "CENTER", 0, 8)
	local _, turnIn = goal(118, "icon-turnin", "quest", "textDim")
	W.Painter(turnIn, function(fs)
		fs:SetText(string.format(L["Turn in %s"], "|c" .. Theme.Hex("quest") .. L["The Mills Overrun"] .. "|r"))
	end)
	local progress = W.ProgressLine(gw, 3)
	progress:SetPoint("TOPLEFT", gw, "TOPLEFT", MINI_PAD, -134)
	progress:SetPoint("TOPRIGHT", gw, "TOPRIGHT", -MINI_PAD, -134)
	W.SetProgress(progress, 0.38, MINI_W - 2 * MINI_PAD)
	gw:SetHeight(134 + 3 + 9)
	f.Guide = gw

	-- The arrow toward the goal, its distance and where it goes.
	local arrow = W.Tex(f, "ARTWORK", "dart", "arrow")
	arrow:SetSize(52, 52)
	if arrow.SetRotation then arrow:SetRotation(-0.35) end
	local dist = W.Text(f, "display", "arrowText")
	dist:SetText(L["381 yd"])
	dist:SetPoint("TOP", arrow, "BOTTOM", 0, -2)
	local to = W.Text(f, "small", "textDim")
	to:SetPoint("TOP", dist, "BOTTOM", 0, -2)
	W.Painter(to, function(fs)
		fs:SetText(string.format(L["Go to %s"], "|c" .. Theme.Hex("place") .. L["Brill"] .. "|r"))
	end)
	f.Arrow = arrow

	-- A toast: a raised panel with its glyph, title and a line naming an
	-- item and a person in their colours.
	local toast = CreateFrame("Frame", nil, f)
	toast:SetSize(TOAST_W, 58)
	Theme.Skin(toast, "panel")
	local tGlyph = W.Tex(toast, "ARTWORK", "icon-accept", "accent")
	tGlyph:SetSize(16, 16)
	tGlyph:SetPoint("TOPLEFT", toast, "TOPLEFT", 10, -10)
	local tTitle = W.Text(toast, "label", "text")
	tTitle:SetPoint("TOPLEFT", tGlyph, "TOPRIGHT", 8, 1)
	tTitle:SetPoint("RIGHT", toast, "RIGHT", -10, 0)
	tTitle:SetText(L["Quest ready to turn in"])
	local tBody = W.Text(toast, "small", "textDim")
	tBody:SetPoint("TOPLEFT", tTitle, "BOTTOMLEFT", 0, -4)
	tBody:SetPoint("RIGHT", toast, "RIGHT", -10, 0)
	W.Painter(tBody, function(fs)
		fs:SetText(string.format(L["%s for %s"], "|c" .. Theme.Hex("item") .. L["Doom Weed"] .. "|r",
			"|c" .. Theme.Hex("npc") .. L["Executor Zygand"] .. "|r"))
	end)
	local tNote = W.Text(toast, "caption", "textMuted")
	tNote:SetPoint("TOPLEFT", tBody, "BOTTOMLEFT", 0, -4)
	tNote:SetText(L["Right-click to dismiss"])
	f.Toast, f.ToastBody = toast, tBody

	-- The two kinds of button.
	local accept = W.Button(f, L["Accept"], nil, { primary = true })
	local skip = W.Button(f, L["Skip"])
	f.Buttons = { accept, skip }

	-- -> the preview's height, its parts placed across `width`: the guide
	-- window at the left, the arrow beside it, the toast and the buttons at
	-- the right (under the guide window when the page is narrow).
	function f:Layout(width)
		self:SetWidth(width)
		local x = 32 -- the body's pad: the preview spans the column edge to edge
		gw:ClearAllPoints()
		gw:SetPoint("TOPLEFT", self, "TOPLEFT", x, -32)
		local right = x + MINI_W
		local wide = width >= right + 110 + TOAST_W + 32
		local arrowX = wide and right + 55 or right + floor((width - right) / 2)
		arrow:ClearAllPoints()
		arrow:SetPoint("TOP", self, "TOPLEFT", arrowX, -36)
		toast:ClearAllPoints()
		accept:ClearAllPoints()
		skip:ClearAllPoints()
		toast:SetShown(wide)
		accept:SetShown(wide)
		skip:SetShown(wide)
		if wide then
			toast:SetPoint("TOPRIGHT", self, "TOPRIGHT", -32, -32)
			skip:SetPoint("TOPRIGHT", toast, "BOTTOMRIGHT", 0, -14)
			accept:SetPoint("RIGHT", skip, "LEFT", -8, 0)
		end
		f.Lift:ClearAllPoints()
		f.Lift:SetSize(width * 0.7, PREVIEW_H * 1.6)
		f.Lift:SetPoint("CENTER", self, "TOPLEFT", width * 0.4, -PREVIEW_H * 0.4)
		f.Band:SetTexCoord(Theme.BandCoords(width, Theme.BAND_H))
		return PREVIEW_H
	end
	return f
end
-- The preview, for the other pages and the tests: buildPreview(parent) -> f.
ns.UI.ThemePreview = buildPreview

---------------------------------------------------------------------------
-- The controls
---------------------------------------------------------------------------

-- The colours names are drawn in, by subject: label, search words.
local SUBJECT = {
	npc = { L["NPC names"], "npc, person, people, characters, talk to, giver, name colour" },
	quest = { L["Quest names"], "quest, quests, title, gold, name colour" },
	item = { L["Item names"], "item, items, loot, collect, objects, name colour" },
	place = { L["Places"], "place, location, town, go to, destination, waypoint" },
	object = { L["Objects & treasure"], "object, objects, treasure, chest, interact" },
	area = { L["Areas"], "area, region, subzone, explore" },
	dungeon = { L["Dungeons & raids"], "dungeon, dungeons, raid, instance, portal, entrance" },
	rare = { L["Rare NPCs"], "rare, rares, elite, silver dragon" },
	skill = { L["Skills & professions"], "skill, profession, crafting, trade" },
	spell = { L["Spells & abilities"], "spell, spells, ability, cast, use" },
	faction = { L["Factions"], "faction, reputation, rep" },
	achievement = { L["Achievements"], "achievement, achievements" },
	level = { L["Levels"], "level, levels, number" },
	success = { L["Done & success"], "success, done, complete, finished, green, check" },
	warning = { L["Warnings"], "warning, caution, orange, attention" },
	danger = { L["Danger & errors"], "danger, error, red, failed, alert" },
}

local function subjectControls()
	local out = {}
	for _, name in ipairs(Theme.SUBJECTS) do
		local s = SUBJECT[name]
		if s then
			out[#out + 1] = { kind = "color", key = "ui.colors." .. name, label = s[1], new = NEW,
				search = s[2] .. ", subject colour, text colour, highlight, custom colour, change colour",
				help = L["The colour these are drawn in, everywhere Polestar names them. Right-click to go back to the skin's. A colour too dark to read is lifted until it does."],
				shown = function() return Theme.Color(name) end, source = fromSkin }
		end
	end
	out[#out + 1] = { kind = "button", label = L["Reset name colours"], button = L["Reset"], icon = "reset", new = NEW,
		search = "reset colours, default colours, restore, undo",
		help = L["Every colour above back to the skin's."],
		onClick = function()
			for _, name in ipairs(Theme.SUBJECTS) do ns.Set("ui.colors." .. name, nil) end
		end }
	return out
end

local function fontChoices(first)
	local list = {}
	if first then list[1] = first end
	for _, c in ipairs(Theme.FontChoices()) do list[#list + 1] = c end
	return list
end

local skinCards = Theme.DrawSkinCard and true or false
local schemeCards = Theme.DrawSchemeCard and true or false

local SPECS = {
	-- Colour: the skin, the accent, the grounds, the text ladder, names.
	{ page = PAGE, key = "theme", icon = "palette", order = 20, group = "look", tab = L["Colour"], section = L["Skin"],
		preview = buildPreview,
		subtitle = L["The look every Polestar window shares: skin, colours, type, frames and motion. Everything repaints as you change it; right-click a setting to reset it."],
		controls = {
		{ kind = skinCards and "cards" or "dropdown", key = "ui.skin", label = L["Skin"], search = "theme, look, style, frame, skin, halo, hearth, blizzard, classic, forever, inn, wood, ember, parchment",
			help = L["Polestar's own look (the default), Halo (no frame, a soft dark veil, Fira Sans), Hearth (an inn by the fire: warm wood, ember light, parchment text), or the game's own art: WoW Forever, Blizzard and Classic. Style, compact mode and the colours you pick work in each."],
			-- The skin drawn (a saved skin whose addon is gone draws Polestar;
			-- the saved choice is kept for when it returns).
			get = Theme.SkinId and function() return Theme.SkinId() end or nil,
			choices = function()
				local list = {}
				for i, c in ipairs(Theme.SkinChoices()) do
					list[i] = { value = c.value, label = c.text, note = c.addon, tip = c.desc,
						draw = skinCards and function(card, v) Theme.DrawSkinCard(card, v) end or nil }
				end
				return list
			end },
	} },
	{ page = PAGE, tab = L["Colour"], section = L["Accent"], controls = {
		{ kind = "color", key = "ui.accent", label = L["Accent colour"], linked = { "ui.matchAccent", "ui.classAccent" }, search = "theme colour, highlight colour, tint",
			help = L["Click to pick your own, right-click to go back to the scheme's."],
			shown = function() return Theme.Accent() end,
			source = function()
				if Theme.FollowsClassAccent() then return (UnitClass and UnitClass("player")) or L["Class colour"] end
				return Theme.FollowsEllesmereAccent() and "EllesmereUI" or L["Polestar gold"]
			end },
		{ kind = "toggle", key = "ui.classAccent", label = L["Class colour"],
			help = L["The accent follows your class: warlock purple, shaman blue, druid orange. Picking your own accent turns this off."] },
	} },
	{ page = PAGE, tab = L["Colour"], section = L["Background"], controls = {
		{ kind = schemeCards and "cards" or "dropdown", key = "ui.scheme", label = L["Colour scheme"], search = "theme, dark mode, darker, dusk, night, graphite",
			-- A skin of the house's family may bring its own scheme; then this has no effect.
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
		{ kind = "color", key = "ui.bgColor", label = L["Background colour"], disabled = houseOnly,
			help = L["The ground of every Polestar window. Right-click to go back to the scheme's. Text always stays legible: a colour too light for it is darkened."],
			shown = function() return Theme.Color("bg") end,
			source = schemeLabel },
		{ kind = "color", key = "ui.panelColor", label = L["Panel colour"], alpha = true, disabled = houseOnly, new = NEW,
			search = "panel, card, popup, menu, raised, inner background, box colour, ground",
			help = L["The raised panels inside a window: setting groups, menus, cards and toasts. With its opacity. Right-click to go back to the background's shade."],
			shown = function() return Theme.Color("panel") end,
			source = schemeLabel },
		{ kind = "color", key = "ui.sidebarColor", label = L["Sidebar colour"], alpha = true, disabled = houseOnly, new = NEW,
			search = "sidebar, side bar, navigation, left column, rail, ground",
			help = L["The sidebar of the settings window and the guide menu. With its opacity. Right-click to go back to the background's shade."],
			shown = function() return Theme.Color("sidebar") end,
			source = schemeLabel },
		{ kind = "slider", key = "ui.brightness", label = L["Brightness"], disabled = houseOnly, min = -1, max = 1, step = 0.05, format = signed,
			search = "lighter, darker, light, dark, lift",
			help = L["Lifts or lowers every background together. Right-click to reset."] },
		{ kind = "slider", key = "ui.bgOpacity", label = L["Background opacity"], min = 0, max = 1, step = 0.05, format = percent,
			search = "transparency, alpha, see through, translucent",
			help = L["The background opacity of every Polestar window: how much of the world shows through. Right-click to reset."] },
	} },
	{ page = PAGE, tab = L["Colour"], section = L["Text colours"], controls = {
		{ kind = "color", key = "ui.textColor", label = L["Text"], new = NEW,
			search = "text colour, font colour, white, primary text, main text, readability",
			help = L["Titles, goals and labels. Right-click to go back to the skin's. Text always stays legible: a colour too dark to read is lifted until it does."],
			shown = function() return Theme.Color("text") end, source = fromSkin },
		{ kind = "color", key = "ui.textDimColor", label = L["Secondary text"], new = NEW,
			search = "dim text, secondary, descriptions, grey text, font colour",
			help = L["Descriptions, zone names and secondary lines. Right-click to go back to the skin's."],
			shown = function() return Theme.Color("textDim") end, source = fromSkin },
		{ kind = "color", key = "ui.textMutedColor", label = L["Muted text"], new = NEW,
			search = "muted, faint, quiet, done goals, hints, grey text, font colour",
			help = L["Finished goals, hints and counts. Right-click to go back to the skin's."],
			shown = function() return Theme.Color("textMuted") end, source = fromSkin },
	} },
	{ page = PAGE, tab = L["Colour"], section = L["Names & status"], controls = subjectControls() },

	-- Type: faces, sizes, outline and shadow of every Polestar string.
	{ page = PAGE, tab = L["Type"], section = L["Font"], preview = buildPreview, controls = {
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
		{ kind = "font", key = "ui.headingFont", label = L["Heading font"], new = NEW,
			search = "heading, title, titles, headline, header font, typeface",
			help = L["Window titles, step titles and section headings: the text's font (the default), or one of their own."],
			choices = function() return fontChoices({ value = "body", label = L["Same as the text"] }) end },
	} },
	{ page = PAGE, tab = L["Type"], section = L["Size"], controls = {
		{ kind = "slider", key = "ui.textSize", label = L["Text size"], min = 0.8, max = 1.4, step = 0.05, format = percent,
			search = "font size, bigger text, smaller text, readability, larger, huge, tiny",
			help = L["The size of Polestar's text, apart from the window scale. Changes at once. Right-click to reset."] },
		{ kind = "slider", key = "ui.headingSize", label = L["Heading size"], min = 0.7, max = 1.6, step = 0.05, format = percent, new = NEW,
			search = "title size, heading size, bigger titles, smaller titles, headline",
			help = L["Titles and headings against the text size above. Right-click to reset."] },
		{ kind = "slider", key = "ui.smallSize", label = L["Small print size"], min = 0.7, max = 1.6, step = 0.05, format = percent, new = NEW,
			search = "small text, captions, counters, chips, fine print, tiny text, bigger, readability",
			help = L["Secondary lines, captions, chips and counters against the text size above. Right-click to reset."] },
	} },
	{ page = PAGE, tab = L["Type"], section = L["Outline & shadow"], controls = {
		{ kind = "dropdown", key = "ui.fontOutline", label = L["Text outline"], new = NEW,
			search = "outline, border, stroke, thick, readable, contrast, legible",
			help = L["A dark outline round every Polestar letter, for text that holds over any background."],
			choices = { { value = "none", label = L["None"] }, { value = "outline", label = L["Outline"] }, { value = "thick", label = L["Thick outline"] } } },
		{ kind = "dropdown", key = "ui.textShadow", label = L["Text shadow"], new = NEW,
			search = "shadow, drop shadow, glow, depth, readable, contrast",
			help = L["The shadow under every Polestar letter: the skin's, a soft one, the game's hard one, or none."],
			choices = { { value = "skin", label = L["The skin's"] }, { value = "soft", label = L["Soft"] }, { value = "hard", label = L["Hard"] }, { value = "none", label = L["None"] } } },
	} },

	-- Frames: border, hairlines, depth and light, menus.
	{ page = PAGE, tab = L["Frames"], section = L["Window border"], preview = buildPreview, controls = {
		{ kind = "toggle", key = "ui.border", label = L["Window border"], search = "border, edge, outline, frame",
			help = L["The line around every Polestar window."] },
		{ kind = "color", key = "ui.borderColor", label = L["Border colour"], linked = { "ui.borderAccent" }, disabled = borderOff, child = true,
			help = L["Click to pick your own, right-click to go back to the scheme's hairline."],
			shown = function() return Theme.Color("windowBorder") end,
			source = function() return ns.Get("ui.borderAccent") and L["Accent"] or L["Hairline"] end },
		{ kind = "toggle", key = "ui.borderAccent", label = L["Accent border"], disabled = borderOff, child = true,
			help = L["The border takes your accent colour. Picking your own border colour turns this off."] },
		{ kind = "slider", key = "ui.borderSize", label = L["Border thickness"], min = 1, max = 4, step = 1, format = px, disabled = borderOff, child = true,
			search = "thicker border, wide border, border size",
			help = L["In screen pixels; a thicker border grows outward. Right-click to reset."] },
		{ kind = "slider", key = "ui.hairlineOpacity", label = L["Hairlines"], min = 0, max = 3, step = 0.1, format = percent, new = NEW,
			search = "divider, dividers, separator, lines, rules, hairline, border opacity, stronger lines, faint lines",
			help = L["How strongly the thin lines between rows and round panels show, against the skin's. Right-click to reset."] },
	} },
	{ page = PAGE, tab = L["Frames"], section = L["Depth & light"], controls = {
		{ kind = "toggle", key = "ui.shadow", label = L["Window shadow"], disabled = houseOnly, search = "shadow, drop shadow, depth",
			help = L["The soft shadow under every window."] },
		{ kind = "slider", key = "ui.shadowStrength", label = L["Shadow strength"], min = 0, max = 2, step = 0.05, format = percent, child = true, disabled = shadowOff, new = NEW,
			search = "shadow, darker shadow, lighter shadow, depth, drop shadow opacity",
			help = L["How dark the window shadow falls, against the skin's. Right-click to reset."] },
		{ kind = "toggle", key = "ui.band", label = L["Starlit band"], disabled = houseOnly, search = "stars, sky, header, night, band",
			help = L["The night sky with its stars across the top of every window. Off: the plain background."] },
		{ kind = "slider", key = "ui.starAlpha", label = L["Stars"], min = 0, max = 1, step = 0.05, format = percent, child = true, disabled = bandOff, new = NEW,
			search = "stars, starfield, sparkle, twinkle, sky, fewer stars, band",
			help = L["How bright the stars in the band shine; at 0% the sky alone. Right-click to reset."] },
		{ kind = "toggle", key = "ui.haze", label = L["Header haze"], child = true, disabled = bandOff, new = NEW,
			search = "glow, haze, blue light, header glow, corner glow",
			help = L["The faint blue light under the top of each window's band."] },
		{ kind = "toggle", key = "ui.rim", label = L["Accent rim"], disabled = houseOnly, new = NEW,
			search = "rim, glow, light, top edge, accent line, corner glow, shine",
			help = L["The lit accent line along the top edge of Polestar's windows, and the light it throws."] },
	} },
	{ page = PAGE, tab = L["Frames"], section = L["Menus"], controls = {
		{ kind = "slider", key = "ui.menuScale", label = L["Menu scale"], min = 0.7, max = 1.4, step = 0.05, format = percent, release = true,
			search = "settings size, menu size, bigger menu, zoom, options scale",
			help = L["The guide menu and this window; applies when you let go. Right-click to reset."] },
		{ kind = "toggle", key = "ui.gameMenuButton", label = L["Button in the game menu"],
			help = L["A Polestar button in the game menu (Esc) that opens the guide menu."],
			search = "game menu, escape, esc, main menu, button, open polestar" },
	} },

	-- Motion and sound.
	{ page = PAGE, tab = L["Motion & sound"], section = L["Motion"], preview = buildPreview, controls = {
		{ kind = "toggle", key = "ui.reduceMotion", label = L["Reduce motion"], help = L["No sliding or popping; fades stay short."],
			search = "animations, motion sickness, fps, frame rate, performance, lag, stutter, cpu, slow" },
		{ kind = "slider", key = "ui.animSpeed", label = L["Animation speed"], min = 0.5, max = 2, step = 0.1, format = times, new = NEW,
			search = "animation, speed, faster, slower, snappy, transitions, slide, fade, tween, motion",
			help = L["How fast Polestar's windows slide, fade and pop: 2x takes half the time. Right-click to reset."] },
	} },
	{ page = PAGE, tab = L["Motion & sound"], section = L["Sound"], controls = {
		{ kind = "toggle", key = "ui.classCardSound", label = L["Class quest chime"], search = "sound, chime, audio, class quest",
			disabled = function() return not (ns.UI and ns.UI.ClassCard and ns.UI.ClassCard.GameSoundOn()) end,
			help = L["A short chime the first time a class quest chain's card shows. Off while the game's sound effects are off."] },
	} },
}

for _, spec in ipairs(SPECS) do
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
