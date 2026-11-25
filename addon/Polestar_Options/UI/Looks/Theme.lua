-- The settings window's Theme page (look group, key "theme"): the looks
-- every Polestar surface shares, organised per element. The skin (picture
-- cards), the accent, the grounds, the text ladder and the colours names are
-- drawn in; the font faces, sizes, outline and shadow of all Polestar text;
-- the windows' border, hairlines, shadow, band, haze and rim; motion and
-- sound. Every setting resolves in Polestar.Theme (Theme/Theme.lua: the
-- palette, Theme.FontSpec) and repaints live through Theme.Refresh, the
-- page's preview with it.
--
-- Each tab pins a band over its rows (UI.Preview.Band, built the first time
-- the tab shows): the three surfaces the theme styles at their real size,
-- side by side, drawn by their own code in the theme in use: the guide
-- window's head and three goal rows, the heads-up card and the rare alert;
-- the Names tab shows every subject's name in its colour instead.

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
-- The Names tab's preview, a band (UI.Preview.Band): every subject's name in
-- its colour on a panel card, two columns, alone at its real size.
---------------------------------------------------------------------------

local NAME_ROW, NAME_COL = 22, 150 -- a line of the names card; a column, at least

local lightParts
local function buildNamesPreview(view)
	local P = ns.UI.Preview
	local f = P.Band(view, { watch = { "ui." } })
	local card = CreateFrame("Frame", nil, f)
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
	f.Names = card
	lightParts(f, nil, nil, nil, card)
	local snap = P.Snap
	function f:Content()
		local t = self:TrueScale()
		-- The columns as wide as the longest name (a translation's) needs.
		local col = NAME_COL
		for _, word in ipairs(card.Words) do col = max(col, math.ceil(W.TextWidth(word.fs)) + 24) end
		local lines = math.ceil(#card.Words / 2)
		for i, word in ipairs(card.Words) do
			local c, line = (i - 1) % 2, floor((i - 1) / 2)
			word.fs:ClearAllPoints()
			word.fs:SetPoint("TOPLEFT", card, "TOPLEFT", 16 + c * col, -(10 + line * NAME_ROW))
		end
		local cw, ch = 16 + 2 * col, 20 + lines * NAME_ROW
		card:SetSize(cw, ch)
		return cw * t, ch * t, function(left, top, k)
			local g = t * k
			card:SetScale(g)
			card:ClearAllPoints()
			card:SetPoint("TOPLEFT", self, "TOPLEFT", snap(card, left / g), snap(card, -top / g))
		end
	end
	return f
end

-- The settings window's parts drawn in the accent: a region in the accent,
-- at least half opaque; a frame's border or pill (a switch's track) by its
-- frame. Found by walking the window, once for the tab on screen: kept until
-- another tab shows or a setting or the look changes, so an accent row's
-- hover lights them without walking every frame again. The gamepad's focus
-- ring moves on its own and is looked at each time.
local windowAccents
do
	local kept, out, seen, own = {}, {}, {}, {}
	local keptView
	local ar, ag, ab
	local function regions(fr, list, ...)
		for i = 1, select("#", ...) do
			local r = (select(i, ...))
			local cr, cg, cb, ca
			if r:GetObjectType() == "FontString" then cr, cg, cb, ca = r:GetTextColor() else cr, cg, cb, ca = r:GetVertexColor() end
			if cr and (ca or 1) >= 0.5 and r:IsShown() and math.abs(cr - ar) + math.abs(cg - ag) + math.abs(cb - ab) < 0.02 then
				local part = own[r] and fr or r
				if not seen[part] then
					seen[part] = true
					list[#list + 1] = part
				end
			end
		end
	end
	local function walk(fr, list)
		if not fr:IsVisible() or ns.UI.Preview.IsBand(fr) then return end
		for k in pairs(own) do own[k] = nil end
		for _, t in ipairs(rawget(fr, "psBorder") or {}) do own[t] = true end
		for _, t in ipairs(rawget(fr, "parts") or {}) do own[t] = true end
		regions(fr, list, fr:GetRegions())
		for i = 1, fr:GetNumChildren() do walk((select(i, fr:GetChildren())), list) end
	end
	local function forget() keptView = nil end
	ns.On("SETTING_CHANGED", forget)
	Theme.OnChanged(forget)
	function windowAccents()
		local O = ns.UI.Options
		local view = O and O.view or false
		ar, ag, ab = Theme.Accent()
		if keptView ~= view then
			for k in pairs(seen) do seen[k] = nil end
			for i = #kept, 1, -1 do kept[i] = nil end
			walk(PolestarOptions, kept)
			keptView = view
		end
		local ring = _G.PolestarPadRing
		if not (ring and ring:IsVisible()) then return kept end
		for i = #out, 1, -1 do out[i] = nil end
		for i = 1, #kept do out[i] = kept[i] end
		walk(ring, out)
		for i = #kept + 1, #out do seen[out[i]] = nil end
		return out
	end
end

-- A click on a part finds its setting; the pointer on a setting's row lights
-- the parts it changes (the settings window's own, for what dresses it), on
-- preview f: the guide window G (UI.GuideWindowScene, a copy of the window
-- drawn once as it is made), the heads-up card, the rare alert and the names
-- card, those it has.
function lightParts(f, G, heads, toast, card)
	local guide = rawget(f, "Guide")
	local surfaces = { guide, heads, toast, card }
	local win = PolestarOptions
	-- The scene's window: its open tab, the "1 done" line, the current goal
	-- (the kill the arrow points at), the collect under it with its mobs, the
	-- "Then:" line naming the step's other person (in the NPC's colour, the
	-- quest's name in the quest's).
	local S
	if G then
		local C, P = G.Copy, G.Copy.parts
		S = { window = G.Window, band = P.band, person = P.person, strip = P.strip, nav = P.nav, tip = P.tip, foot = P.foot,
			up = P.upnext, tab = C.tabs[1], done = C.lines[1], current = C.rows[1], collect = C.rows[2], next = C.lines[2] }
		f:Hot(S.window, "ui.bgOpacity")
		f:Hot(S.band, "ui.starAlpha")
		f:Hot(S.person.Name, "ui.headingFont")
		f:Hot(S.collect and S.collect.Sub, "ui.textMutedColor")
		f:Hot(S.next and S.next.Text, "ui.colors.npc")
		f:Hot(S.collect and S.collect.Text, "ui.colors.item")
	end
	if toast then f:Hot(toast, "ui.panelColor") end
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
	for _, key in ipairs({ "ui.skin", "ui.scheme", "ui.brightness", "ui.reduceMotion", "ui.animSpeed", "ui.font", "ui.fontOutline", "ui.textShadow" }) do
		light(key, unpack(everything))
	end
	local grounds = { guide, heads, toast }
	for _, key in ipairs({ "ui.bgOpacity", "ui.bgColor" }) do light(key, unpack(grounds)) end
	light("ui.panelColor", toast, heads, card)
	-- Every part the accent paints: in the scene the guide window's open tab
	-- (its underline and icon), the current goal's bar and glyph and the
	-- progress bar; the heads-up card's stripe, ring, headline, badge and
	-- primary button; the rare alert's primary button and time bar.
	local accents = {}
	local function accent(...)
		for i = 1, select("#", ...) do
			local r = select(i, ...)
			if r then accents[#accents + 1] = r end
		end
	end
	accent(unpack(primaries))
	if S then accent(S.tab and S.tab.Bar, S.tab and S.tab.Icon, S.current and S.current.Mark, S.current and S.current.Icon, S.foot.Line) end
	if heads then accent(rawget(heads, "Stripe"), rawget(heads, "Ring"), rawget(heads, "Head"), rawget(heads, "Badge")) end
	if toast then accent(rawget(toast, "Timer")) end
	-- Rings off them: an outline on a part in the accent would not show.
	f:LightRing("ui.accent", unpack(accents))
	f:LightRing("ui.classAccent", unpack(accents))
	-- And every part of the settings window drawn in the accent as the row is
	-- hovered (the emblem, the open page's row, the open tab's underline, the
	-- sliders' fills, the switches that are on, chips, primary buttons, a
	-- focused box's ring) and the gamepad's focus ring: windowAccents below.
	if win then
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
		f:LightEdge(key, guide, toast, heads, card)
	end
	if S then
		local current, collect, next, done = S.current or {}, S.collect or {}, S.next or {}, S.done or {}
		light("ui.band", S.band)
		light("ui.starAlpha", S.band)
		light("ui.hairlineOpacity", S.strip.Rule, S.nav.Rule, S.up.Toggle.Rule)
		light("ui.textSize", current.Text, collect.Text, S.tip)
		light("ui.headingFont", S.person.Name)
		light("ui.headingSize", S.person.Name)
		light("ui.smallSize", S.tab and S.tab.Label, S.nav.Title, S.person.Where, S.up.Toggle.Label)
		light("ui.textColor", current.Text, collect.Text)
		light("ui.textDimColor", S.nav.Title, S.person.Where, S.tip, done.Text, next.Text)
		light("ui.textMutedColor", collect.Sub, S.tab and S.tab.Range)
		-- The names the scene draws in each subject's colour.
		light("ui.colors.npc", next.Text)
		light("ui.colors.quest", next.Text)
		light("ui.colors.item", collect.Text)
		light("ui.colors.success", done.Icon)
	end
	if heads then light("ui.colors.dungeon", heads) end
	if toast then light("ui.colors.rare", toast) end
	if card then
		for _, word in ipairs(card.Words) do light("ui.colors." .. word.name, word.fs) end
	end
end

-- Theme v2, a band (UI.Preview.Band): the three surfaces the theme styles on
-- one stage, a framed panel across the band: the guide window (a copy drawn
-- by its own code, UI.GuideWindowScene: its head and its goals, cut under
-- them and faded into the stage), the heads-up card (on the window's scale,
-- as it sits on the window) and the rare alert, drawn by their own code at
-- their real size, each centred on its row's middle line, the space between
-- them even, a caption under each on one line. A band too narrow for the
-- three across at STAGE_FIT of their size or more takes the window on a row
-- of its own and the two cards under it (then each on its own row). Each row
-- is drawn as large as the stage's width holds it, never over its real size:
-- one part wider than the rest (the rare alert in the new page's narrow
-- Preview panel) shrinks its own row, not the others. Past that, all smaller
-- alike, never overlapping, and nothing says so.
local GAP, MAX_GAP, ROWS_ROOM, SIDE = 32, 72, 12, 16 -- between two (least, most); the window's ground under its goals; the window's own room a side
local STAGE_PAD, ROW_GAP, CAP_GAP, CAP_H, STAGE_FIT, CUT_FADE = 20, 20, 10, 15, 0.8, 20
local ARRANGEMENTS = { { { 1, 2, 3 } }, { { 1 }, { 2, 3 } }, { { 1 }, { 2 }, { 3 } } }
local function buildPreview(view)
	local UI = ns.UI
	local TS = UI.Toasts
	local P = UI.Preview
	local f = P.Band(view, { watch = { "ui.", "guideWindow.", "toasts." }, fitNote = false })
	-- The stage: the panel colour laid on the band's ground (opaque, so the
	-- window's cut fades into exactly it) inside a hairline, under the three.
	local stage = CreateFrame("Frame", nil, f)
	stage:SetFrameLevel(f:GetFrameLevel())
	stage.Fill = stage:CreateTexture(nil, "BACKGROUND", nil, -6)
	stage.Fill:SetTexture(Theme.Media("white"))
	stage.Fill:SetAllPoints(stage)
	local function stageColor()
		local r, g, b, a = Theme.Color("panel")
		local br, bg, bb = Theme.Color("bg")
		a = a or 1
		return r * a + br * (1 - a), g * a + bg * (1 - a), b * a + bb * (1 - a)
	end
	W.Painter(stage, function(s)
		s.Fill:SetVertexColor(stageColor())
		Theme.Border(s, Theme.Wash("border"))
	end)
	stage:Hide()
	f.Stage = stage
	local G = UI.GuideWindowScene and UI.GuideWindowScene(f)
	f.Scene, f.Guide = G, G and G.Window
	f.StepTitle = G and G.Copy.parts.person.Name
	if G and G.FadeTo then G:FadeTo(stageColor, CUT_FADE) end
	local heads = TS and TS.Sandbox and TS.Sandbox("headsup", f)
	local toast = TS and TS.Sandbox and TS.Sandbox("rare", f)
	f.Heads, f.Toast = heads, toast
	if heads then heads:Show() end
	if toast then toast:Show() end
	local parts = {}
	if G then parts[#parts + 1] = { kind = "guide", label = f:Label(L["Guide window"]) } end
	if heads then parts[#parts + 1] = { kind = "headsup", frame = heads, label = f:Label(L["Heads-up card"]) } end
	if toast then parts[#parts + 1] = { kind = "rare", frame = toast, label = f:Label(L["Rare alert"]) } end
	f.Parts = parts
	-- The stage over the band's ground, the parts over the stage, each
	-- caption on it.
	stage:SetFrameLevel(f:GetFrameLevel() + 1)
	for _, p in ipairs(parts) do
		p.label:SetParent(stage)
		local fr = p.kind == "guide" and G or p.frame
		if fr:GetFrameLevel() <= stage:GetFrameLevel() then fr:SetFrameLevel(stage:GetFrameLevel() + 2) end
	end
	lightParts(f, G, heads, toast)
	if #parts == 0 then return f end
	local snap = P.Snap
	-- Rows of parts (indexes into `parts`, those it has), across `room` ->
	-- the stage's natural width and height, each row's width and tallest
	-- part at its own fit (the most of its real size the room holds), and
	-- the least of those fits.
	local function measure(rows, room)
		local wide, high, sized, least = 0, STAGE_PAD * 2, {}, 1
		for i, row in ipairs(rows) do
			local w, tall = 0, 0
			for _, at in ipairs(row) do
				local p = parts[at]
				w = w + p.w
				tall = max(tall, p.h)
			end
			local gaps = (#row - 1) * GAP
			local fit = min(1, max(0.05, (room - STAGE_PAD * 2 - gaps) / max(1, w)))
			least = min(least, fit)
			sized[i] = { list = row, fit = fit, w = w * fit + gaps, tall = tall * fit }
			wide = max(wide, w * fit + gaps)
			high = high + tall * fit + CAP_GAP + CAP_H + (i > 1 and ROW_GAP or 0)
		end
		return wide + STAGE_PAD * 2, high, sized, least
	end
	function f:Content(width, tall)
		local t = self:TrueScale()
		local scale = (tonumber(ns.Get("ui.scale")) or 1) * t
		-- Each one's size at its real size (band units).
		for _, p in ipairs(parts) do
			if p.kind == "guide" then
				-- Drawn whole, then given the room down to its goals' foot
				-- (and the 8 its crop keeps under what it shows).
				G:Layout(400 * scale + SIDE * 2, 4000)
				p.k = scale
				p.w = G.Window:GetWidth() * scale
				p.h = ((G.psRowsFoot or 0) + ROWS_ROOM) * scale + 8
			else
				TS.ApplyLook(p.frame, true)
				if p.kind == "headsup" then TS.Refill("headsup", p.frame) end
				p.frame:SetAlpha(TS.Alpha(p.kind))
				p.k = TS.Scale(p.kind) * (p.kind == "headsup" and scale or t)
				p.w, p.h = p.frame:GetWidth() * p.k, p.frame:GetHeight() * p.k
			end
		end
		-- The first arrangement the band holds at STAGE_FIT or more (across
		-- and in the height it may take), else the one it holds largest.
		local room = max(1, (width or 0) - 2 * (P.BAND_SIDE or 24))
		local best, bestFit
		for _, rows in ipairs(ARRANGEMENTS) do
			local list = {}
			for _, row in ipairs(rows) do
				local kept = {}
				for _, at in ipairs(row) do if parts[at] then kept[#kept + 1] = at end end
				if #kept > 0 then list[#list + 1] = kept end
			end
			local w, h, _, least = measure(list, room)
			local fit = min(least, room / w, tall and tall > 0 and tall / h or 1)
			if not best or fit > bestFit + 0.001 then best, bestFit = list, fit end
			if fit >= STAGE_FIT then best = list break end
		end
		local natural, high, sized = measure(best, room)
		f.psRows = #sized
		-- The stage spans the band; the parts share what is over.
		local wide = max(natural, room)
		return wide, high, function(left, top, k)
			stage:ClearAllPoints()
			stage:SetPoint("TOPLEFT", self, "TOPLEFT", snap(self, left), -snap(self, top))
			stage:SetSize(snap(self, wide * k), snap(self, high * k))
			stage:Show()
			local y = top + STAGE_PAD * k
			for _, row in ipairs(sized) do
				local n, rf = #row.list, row.fit
				local parts_w = row.w - (n - 1) * GAP
				local gap = n > 1 and min(MAX_GAP, max(GAP, (wide - parts_w) / (n + 1))) or 0
				local x = left + (wide - parts_w - (n - 1) * gap) / 2 * k
				local mid = y + row.tall / 2 * k
				-- The row's own scale: its fit within the band's.
				local rk = rf * k
				for _, at in ipairs(row.list) do
					local p = parts[at]
					local g = p.k * rk
					local ptop = mid - p.h / 2 * rk
					if p.kind == "guide" then
						-- Its box the window and the room it keeps a side, as
						-- tall as the cut.
						G:SetScale(rk)
						G:ClearAllPoints()
						G:SetPoint("TOPLEFT", self, "TOPLEFT", snap(self, x - SIDE * rk) / rk, -snap(self, ptop) / rk)
						G:Resize(p.w + SIDE * 2, p.h)
					else
						p.frame.psBandScale = g
						p.frame:SetScale(g)
						p.frame:ClearAllPoints()
						p.frame:SetPoint("TOPLEFT", self, "TOPLEFT", snap(p.frame, x / g), snap(p.frame, -ptop / g))
					end
					p.label:ClearAllPoints()
					p.label:SetPoint("TOP", self, "TOPLEFT", snap(self, x + p.w * rf / 2 * k), -snap(self, y + (row.tall + CAP_GAP) * k))
					p.label:SetWidth(max(1, (p.w * rf + gap) * k))
					x = x + (p.w * rf + gap) * k
				end
				y = y + (row.tall + CAP_GAP + CAP_H + ROW_GAP) * k
			end
		end
	end
	return f
end

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
-- The cards' picture: a miniature of the look's guide window (Theme/SkinPicker.lua),
-- at least this size, the cards sharing the row (W.Cards' grid).
local CARD_ART = { 200, 116 }
-- The skin cards' groups: Polestar's own looks, the game's, the skins from addons.
local function skinGroup(c)
	if c.addon then return L["More looks"] end
	if Theme.GameSkin(c.value) then return L["Game looks"] end
	return L["Polestar looks"]
end

-- Four tabs, sections by element: Colour (the skin and accent, the grounds),
-- Text (its face, sizes, outline, shadow and colours), Names (the colours
-- names and states are drawn in), Frames (the window's frame, then motion).
-- One element's size, colour and on/off share a row (extras); its finer
-- knobs sit behind the row's cog (more).
local SPECS = {
	-- Colour
	-- general: the settings of every Polestar window, before a module's of the same label in a search.
	{ page = PAGE, key = "theme", icon = "palette", order = 21, group = "look", general = true, tab = L["Colour"], section = L["Skin & accent"],
		preview = buildPreview,
		subtitle = L["The look every Polestar window shares: skin, colours, type, frames and motion."],
		controls = {
		{ kind = skinCards and "cards" or "dropdown", key = "ui.skin", label = L["Skin"], wide = true, art = CARD_ART, grid = true,
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
					list[i] = { value = c.value, label = c.text, tip = tip, group = skinGroup(c),
						draw = skinCards and function(card, v) Theme.DrawSkinCard(card, v) end or nil }
				end
				return list
			end },
		-- A skin in several versions (its variants, Skin API 2): the player's
		-- pick, kept per skin (ui.skinVariants.<id>); shown while the skin in
		-- use has them.
		{ kind = "cards", label = L["Variant"], wide = true, new = NEW, art = CARD_ART, grid = true,
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
				return Theme.FollowsEllesmereAccent() and (Theme.SkinProvider() or "EllesmereUI") or L["Polestar gold"]
			end },
		{ kind = "toggle", key = "ui.classAccent", label = L["Class colour"], search = "class colour, class color, accent follows class",
			help = L["The accent follows your class: warlock purple, shaman blue, druid orange. Picking your own accent turns this off."] },
	} },
	{ page = PAGE, tab = L["Colour"], section = L["Background"], controls = {
		{ kind = schemeCards and "cards" or "dropdown", key = "ui.scheme", label = L["Scheme"], wide = true, art = CARD_ART, grid = true,
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
				if Theme.IsEllesmere() then list[#list + 1] = { value = "ellesmere", label = Theme.SkinProvider() or "EllesmereUI" } end
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
			help = L["The size of Polestar's text, apart from the window scale. The guide window has its own, on its page. Changes at once. Right-click to reset."] },
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
		{ kind = "dropdown", key = "ui.textShadow", label = L["Text shadow"], new = NEW,
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
		{ kind = "slider", key = "ui.shadowStrength", label = L["Shadow strength"], min = 0, max = 2, step = 0.05, format = percent, disabled = shadowOff, new = NEW,
			search = "shadow strength, window shadow, darker shadow, lighter shadow, depth, drop shadow opacity",
			help = L["How dark the window shadow falls, against the skin's."],
			extras = {
				{ kind = "toggle", key = "ui.shadow", label = L["Window shadow"], disabled = houseOnly, search = "window shadow, drop shadow, depth",
					help = L["The soft shadow under every window."] },
			} },
		{ kind = "slider", key = "ui.starAlpha", label = L["Stars in the band"], min = 0, max = 1, step = 0.05, format = percent, disabled = bandOff, new = NEW,
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
		{ kind = "toggle", key = "ui.reduceMotion", label = L["Reduce motion"], help = L["No sliding or popping; fades stay short."],
			search = "animations, motion sickness, fps, frame rate, performance, lag, stutter, cpu, slow" },
		{ kind = "slider", key = "ui.animSpeed", label = L["Animation speed"], min = 0.5, max = 2, step = 0.1, format = times, new = NEW,
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
			jump = { tab = L["Colour"], section = L["Skin & accent"] },
			controls = { R(skinCards and "cards" or "dropdown", "ui.skin", skinCards and { limit = 6 } or nil) } },
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
