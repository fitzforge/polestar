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

---------------------------------------------------------------------------
-- The preview
---------------------------------------------------------------------------

local PREVIEW_H, MINI_W, MINI_PAD, TOAST_W = 196, 270, 10, 232

local function buildPreview(view)
	-- The settings window's preview stage, the night sky by default: the
	-- starlit band (gone with ui.band off) and a soft lift of the sky colour
	-- behind the window, the inner hairline.
	local f = ns.UI.Preview.Stage(view, { height = PREVIEW_H, backdrop = "sky" })

	-- The window draws "Preview" and "Live" over it; this names what it shows.
	f.caption = L["Every Polestar surface, in your theme"]

	-- The guide window, in the guide window's paint of the skin in use
	-- (psGuide: a game look's big-window frame, its title plate or bar,
	-- would sit over the preview's caption), with its header band, haze
	-- and rim.
	local gw = CreateFrame("Frame", nil, f)
	gw:SetWidth(MINI_W)
	gw.psGuide = true
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

	-- A click on a part jumps to its setting (the window's hotspots): the
	-- guide window's ground first, its parts over it.
	local hotspot = ns.UI.Options and ns.UI.Options.PreviewHotspot
	if hotspot then
		f.Hot = {}
		for _, h in ipairs({
			{ gw, "ui.bgOpacity" }, { band, "ui.starAlpha" }, { title, "ui.headingFont" }, { done, "ui.textMutedColor" },
			{ cur, "ui.colors.npc" }, { turnIn, "ui.colors.quest" }, { arrow, "ui.accent" }, { dist, "ui.textSize" },
			{ toast, "ui.panelColor" }, { tBody, "ui.colors.item" }, { accept, "ui.accent" },
		}) do
			f.Hot[#f.Hot + 1] = hotspot(f, h[1], h[2])
		end
	end

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
		-- The sky is the stage's (UI.Preview), laid across the width it is given.
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
			choices = function()
				local list = {}
				for i, c in ipairs(Theme.SkinChoices()) do
					list[i] = { value = c.value, label = c.text, note = c.addon, tip = c.desc,
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
	{ page = PAGE, tab = L["Names"], section = L["Names & status"], preview = buildPreview, controls = subjectControls() },

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

for _, spec in ipairs(SPECS) do
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
