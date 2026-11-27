-- Lookup's part in the core. The Lookup window, a section of the hub (the
-- guide menu's window, UI.RegisterSection "Lookup": one search over the
-- guides and every entity in the Codex, and for the selection, where to get
-- it), is its own addon, Polestar_Lookup (load on demand, like the settings
-- window): nothing of it is in memory until the player first opens Lookup
-- (Polestar_Lookup/UI/LookupWindow.lua describes it). This file is what
-- stays resident:
--
--   the hub's "Lookup" section, whose `load` loads Polestar_Lookup the first
--   time it is shown (the window then registers it again with its own
--   build, render and search)
--   UI.ShowLookup({ query, kind, id }), SHOW_LOOKUP(query, kind, id) and
--   UI.ToggleLookup: the hub at Lookup, loading Polestar_Lookup the first
--   time (its UI.ShowLookup then takes this file's place)
--   UI.Lookup: the kinds, the Codex's state and what is missing in the
--   player's words (Rares and Dungeons say it too), quality colours, coin
--   amounts, the search, and the rows and painters the window shares with
--   the guide menu's search
--
-- The hub's guide search lists entity matches under its guide results
-- through UI.LookupRows / UI.LookupCount / UI.LookupTotal (an "In the
-- Codex" folder, a few per kind; UI.HideLookupRows clears them before the
-- menu draws a list); picking one opens this section at it.
--
-- Addons load nowhere near a fight (ns.Data.Pack refuses in combat): asked
-- then, it says so in chat once and opens Lookup when the fight ends.

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, type, ipairs, pairs, tostring, format = math.floor, math.max, math.min, type, ipairs, pairs, tostring, string.format

local SH = W.SHELL
local ROW_X = 12 -- where list rows' grounds start in the middle pane
local TEXT_X = SH.pad - ROW_X -- text inside a row, on the column's x=32 edge
local ROW_H, FOLDER_H = 28, 32
local PICKER_PER_KIND, PICKER_MAX = 3, 9
local DOT = "  \194\183  "
local LQ, RQ = "\226\128\156", "\226\128\157"

local LK = {}
UI.Lookup = LK
-- The window's rows sit on the same edges.
LK.ROW_X, LK.TEXT_X, LK.ROW_H, LK.FOLDER_H = ROW_X, TEXT_X, ROW_H, FOLDER_H

-- Per kind: the glyph, the subject colour of its names (item kinds use
-- their quality), the singular name.
local KIND = {
	guide = { icon = "icon-level", color = "text", name = L["Guide"] },
	mount = { icon = "icon-mount", color = "item", name = L["Mount"], item = true },
	pet = { icon = "icon-collect", color = "item", name = L["Companion"], item = true },
	item = { icon = "icon-use", color = "item", name = L["Item"], item = true },
	recipe = { icon = "icon-craft", color = "item", name = L["Recipe"], item = true },
	tabard = { icon = "icon-rep", color = "item", name = L["Tabard"], item = true },
	quest = { icon = "icon-accept", color = "quest", name = L["Quest"] },
	npc = { icon = "icon-talk", color = "npc", name = L["NPC"] },
	rare = { icon = "qol-target", color = "npc", name = L["Rare"] },
	instance = { icon = "icon-kill", color = "area", name = L["Dungeon"] },
	zone = { icon = "icon-explore", color = "place", name = L["Zone"] },
	treasure = { icon = "icon-treasure", color = "object", name = L["Treasure"] },
}
LK.KIND = KIND
-- The kinds in order without Search (its KINDS carry translated labels too).
local FALLBACK_KINDS = {
	{ key = "guide", label = L["Guides"] }, { key = "mount", label = L["Mounts"] }, { key = "pet", label = L["Pets"] },
	{ key = "item", label = L["Items"] }, { key = "recipe", label = L["Recipes"] }, { key = "quest", label = L["Quests"] },
	{ key = "npc", label = L["NPCs"] }, { key = "rare", label = L["Rares"] }, { key = "instance", label = L["Dungeons"] },
	{ key = "zone", label = L["Zones"] }, { key = "treasure", label = L["Treasures"] },
}

-- The client's colours, for a client (or preview) without the API.
local QUALITY_RGB = {
	[0] = { 0.62, 0.62, 0.62 }, { 1, 1, 1 }, { 0.12, 1, 0 }, { 0, 0.44, 0.87 }, { 0.64, 0.21, 0.93 }, { 1, 0.5, 0 }, { 0.9, 0.8, 0.5 },
}

---------------------------------------------------------------------------
-- Data
---------------------------------------------------------------------------

local secret = ns.Compat.IsSecret

local function kinds()
	local S = ns.Search
	return S and type(S.KINDS) == "table" and S.KINDS or FALLBACK_KINDS
end

-- -> codexLoaded, reason ("missing", "disabled", "combat", "notloaded",
-- "off" (lookup.enabled false: guides and registered kinds only), ...)
local function status()
	local S = ns.Search
	if not (S and S.Status) then return false, "nosearch" end
	local loaded, reason = S.Status()
	return loaded and true or false, reason
end
LK.Status = status

-- What is missing, in the player's words.
function LK.ReasonText(reason)
	if reason == "loading" then
		return L["Loading the Codex\226\128\166"]
	elseif reason == "off" then
		return L["Lookup is turned off in Settings > Discovery > Lookup. Items, mounts, NPCs and quests are not searched."]
	elseif reason == "missing" then
		return L["The Polestar_Codex addon is not installed. Get Polestar from CurseForge or the GitHub Releases page (the Polestar zip under Assets, not \"Source code\"), install it and restart the game."]
	elseif reason == "disabled" then
		return L["The Polestar_Codex addon is turned off: enable it in the AddOns list, then /reload."]
	elseif reason == "combat" then
		return L["The Codex loads when combat ends."]
	elseif reason == "notloaded" or reason == nil then
		return L["The Codex loads with your first search."]
	elseif reason == "nosearch" then
		return L["Search is not part of this Polestar build."]
	end
	return format(L["The Codex pack could not load (%s)."], tostring(reason))
end

-- opts: { perKind, limit, offset (per kind: for the next page) }.
local function search(text, only, opts)
	local S = ns.Search
	if text == "" or not (S and S.Query) then return {}, {} end
	local o = { limit = opts.limit, perKind = opts.perKind, offset = opts.offset, subtitles = opts.subtitles }
	if only then o.kinds = only end
	local results, counts = S.Query(text, o)
	return results or {}, counts or {}
end

local function itemIcon(id)
	local C = C_Item
	if type(id) ~= "number" or not (C and C.GetItemIconByID) then return nil end
	local ok, icon = pcall(C.GetItemIconByID, id)
	if ok and icon and not secret(icon) then return icon end
	return nil
end

-- A quality's colour, lifted toward the text colour until it reads on the
-- lightest ground at 4.5:1 (Theme.Legible, the floor for subject colours).
local function qualityColor(q)
	if type(q) ~= "number" or secret(q) then return nil end
	local r, g, b
	local C = C_Item
	if C and C.GetItemQualityColor then
		local ok, cr, cg, cb = pcall(C.GetItemQualityColor, q)
		if ok and type(cr) == "number" and not secret(cr) then r, g, b = cr, cg, cb end
	end
	if not r then
		local t = ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[q]
		if type(t) == "table" and type(t.r) == "number" then r, g, b = t.r, t.g, t.b end
	end
	if not r then
		local t = QUALITY_RGB[q]
		if not t then return nil end
		r, g, b = t[1], t[2], t[3]
	end
	return Theme.Legible(r, g, b)
end
LK.QualityColor = qualityColor

-- Paint a font string in a result's colour: its quality for item kinds,
-- else its kind's subject colour.
local function paintName(fs, k, quality)
	local r, g, b = qualityColor(quality)
	if r and KIND[k] and KIND[k].item then
		W.Uncolor(fs)
		fs:SetTextColor(r, g, b, 1)
	else
		W.Color(fs, KIND[k] and KIND[k].color or "text")
	end
end

-- An amount of copper in the client's coin symbols (ns.MoneyText), nil for none.
function LK.Money(copper)
	if type(copper) ~= "number" or copper <= 0 then return nil end
	return ns.MoneyText(copper)
end

---------------------------------------------------------------------------
-- Rows (shared by this window and the guide menu's Codex folder)
---------------------------------------------------------------------------

local function makeFolder(parent)
	local f = CreateFrame("Frame", nil, parent)
	f:SetHeight(FOLDER_H)
	f.Text = W.Text(f, "label", "textMuted")
	f.Text:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", TEXT_X, 7)
	f.Count = W.Text(f, "number", "textMuted")
	f.Count:SetJustifyH("RIGHT")
	f.Count:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -TEXT_X, 7)
	f.Rule = W.Divider(f, false, 0.7)
	f.Rule:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", TEXT_X, 0)
	f.Rule:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -TEXT_X, 0)
	return f
end

local function makeRow(parent)
	local r = CreateFrame("Button", nil, parent)
	r:SetHeight(ROW_H)
	W.Hover(r)
	r.Selected = r:CreateTexture(nil, "BACKGROUND")
	r.Selected:SetTexture(Theme.Media("white"))
	r.Selected:SetAllPoints(r)
	W.Painter(r.Selected, function(t) t:SetVertexColor(Theme.Wash("selected")) end)
	r.Bar = r:CreateTexture(nil, "ARTWORK")
	r.Bar:SetTexture(Theme.Media("white"))
	r.Bar:SetWidth(2)
	r.Bar:SetPoint("TOPLEFT", r, "TOPLEFT", 0, 0)
	r.Bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0)
	W.Color(r.Bar, "accent")
	-- The icon sits in the gutter left of the text edge.
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(12, 12)
	r.Icon:SetPoint("CENTER", r, "LEFT", TEXT_X / 2 - 1, 0)
	r.Title = W.Text(r, "body", "text")
	r.Title:SetPoint("LEFT", r, "LEFT", TEXT_X, 0)
	r.Sub = W.Text(r, "small", "textMuted")
	r.Sub:SetJustifyH("RIGHT")
	r.Sub:SetPoint("RIGHT", r, "RIGHT", -TEXT_X, 0)
	-- What makes it unobtainable, right after the name (STATUS_TEXT).
	r.Status = W.Chip(r)
	r.Status:SetPoint("LEFT", r.Title, "RIGHT", 8, 0)
	r.Status:Hide()
	r:SetScript("OnEnter", W.SimpleTip)
	r:SetScript("OnLeave", W.HideTip)
	return r
end

local function setGlyph(tex, glyph, color)
	tex:SetTexture(Theme.Media(glyph))
	tex:SetTexCoord(0, 1, 0, 1)
	W.Color(tex, color or "textDim")
end

-- An entity's status (Codex item records, Search results): no longer
-- obtainable, or no source known. Shown for reference, never guided to.
local STATUS_TEXT = { retired = L["No longer obtainable"], nosource = L["No known source"] }
LK.STATUS_TEXT = STATUS_TEXT

-- A muted chip saying so.
local function paintStatus(chip, status)
	if not STATUS_TEXT[status] then
		chip:Hide()
		return 0
	end
	local w = W.SetChip(chip, STATUS_TEXT[status], "neutral")
	W.Color(chip.Text, "textMuted")
	return w
end

-- A result or selection's name in the client's language, else `fallback`.
local function localTitle(kind, id, fallback)
	local S = ns.Search
	return S and S.LocalName and S.LocalName(kind, id) or fallback
end

-- The "New in Forever" mark after a quest's name (NewQuests.Mark), else "".
local function questMark(s)
	local NQ = ns.NewQuests
	return s.kind == "quest" and NQ and NQ.Mark(s.id) or ""
end

-- One result on a row: icon (the item's own, else the kind's glyph), the
-- name in its colour (a chip saying why when it cannot be got: the name keeps
-- its full colour), the subtitle right. note: the right-hand text.
local function paintResult(r, res, note, width, on)
	r.psResult = res
	r.Selected:SetShown(on and true or false)
	r.Bar:SetShown(on and true or false)
	local icon = KIND[res.kind] and KIND[res.kind].item and itemIcon(res.id)
	if icon then
		W.Uncolor(r.Icon)
		r.Icon:SetTexture(icon)
		r.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		r.Icon:SetVertexColor(1, 1, 1, 1)
	else
		setGlyph(r.Icon, KIND[res.kind] and KIND[res.kind].icon or "search", on and "accent" or "textDim")
	end
	r.Title:SetText(localTitle(res.kind, res.id, res.title or tostring(res.id)) .. questMark(res))
	paintName(r.Title, res.kind, res.quality)
	local blocked = STATUS_TEXT[res.status] ~= nil
	local chipW = paintStatus(r.Status, res.status)
	W.Color(r.Sub, "textMuted")
	r.Sub:SetText(note or "")
	local room = width - TEXT_X * 2 - (note and note ~= "" and (r.Sub:GetStringWidth() + 16) or 0) - (blocked and (chipW + 8) or 0)
	r.Title:SetWidth(max(60, min(room, floor(r.Title:GetStringWidth() + 1))))
	r.Sub:SetWidth(max(0, min(r.Sub:GetStringWidth() + 1, width - TEXT_X * 2 - 60 - (blocked and (chipW + 8) or 0))))
	r:SetWidth(width)
	r:Show()
end

-- A row that acts rather than shows: "Show all 14", "Search everything".
local function paintAction(r, text, glyph, width)
	r.psResult = nil
	r.Selected:Hide()
	r.Bar:Hide()
	setGlyph(r.Icon, glyph, "accent")
	r.Icon:SetAlpha(1)
	r.Title:SetAlpha(1)
	r.Status:Hide()
	r.Title:SetText(text)
	W.Color(r.Title, "accent")
	r.Sub:SetText("")
	r.Title:SetWidth(max(60, min(width - TEXT_X * 2, floor(r.Title:GetStringWidth() + 1))))
	r:SetWidth(width)
	r:Show()
end

-- A drawn row's subtitle, asked for once.
local function subtitleOf(res)
	if res.subtitle == nil and not res.psSubtitled then
		res.psSubtitled = true
		local S = ns.Search
		if S and S.Subtitle then
			local ok, text = pcall(S.Subtitle, res)
			if ok and type(text) == "string" and text ~= "" then res.subtitle = text end
		end
	end
	return res.subtitle
end

-- The window (Polestar_Lookup/UI/LookupWindow.lua) draws with the same
-- kinds, search, rows and painters.
LK.Kinds, LK.Search = kinds, search
LK.MakeFolder, LK.MakeRow, LK.SetGlyph = makeFolder, makeRow, setGlyph
LK.ItemIcon, LK.PaintName, LK.PaintStatus = itemIcon, paintName, paintStatus
LK.LocalTitle, LK.QuestMark = localTitle, questMark
LK.PaintResult, LK.PaintAction, LK.SubtitleOf = paintResult, paintAction, subtitleOf

---------------------------------------------------------------------------
-- The hub section, until the window's addon is loaded
---------------------------------------------------------------------------

local PACK = "Polestar_Lookup"
local stub -- this file's UI.ShowLookup, until the window's addon replaces it

-- A request made in combat (the latest), run when the fight ends.
local waiting
local function afterCombat()
	ns.UnregisterEvent("PLAYER_REGEN_ENABLED", afterCombat)
	local open = waiting
	waiting = nil
	if open then open() end
end

-- -> true once the window's addon is loaded. Asked in combat, it says so in
-- chat once and runs `retry` when the fight ends.
local function loadLookup(retry)
	if UI.ShowLookup ~= stub then return true end
	local Data = ns.Data
	local ok, why = false, "unavailable"
	if Data and Data.Pack then ok, why = Data.Pack(PACK) end
	if ok and UI.ShowLookup ~= stub then return true end
	if why == "combat" then
		if not waiting then
			ns.Print(L["Polestar's Lookup opens when combat ends."])
			ns.RegisterEvent("PLAYER_REGEN_ENABLED", afterCombat)
		end
		waiting = retry
		return false
	end
	ns.Print(format(L["Polestar's Lookup could not be loaded (%s): is the Polestar_Lookup folder installed and enabled?"], tostring(why or "error")))
	return false
end

-- The rail shows Lookup from login; the window registers it again with its
-- build and render once loaded.
if UI.RegisterSection then
	UI.RegisterSection({ key = "Lookup", label = L["Lookup"], icon = "search", order = 20, load = loadLookup })
end

-- opts: { query, kind, id }: the hub at Lookup.
stub = function(opts)
	if loadLookup(function() UI.ShowLookup(opts) end) then return UI.ShowLookup(opts) end
end
UI.ShowLookup = stub

function UI.ToggleLookup()
	local P = UI.Picker
	if P and P.frame and P.frame:IsShown() and P.Section and P.Section() == "Lookup" then
		P.frame:Hide()
	else
		UI.ShowLookup()
	end
end

ns.On("SHOW_LOOKUP", function(q, k, id)
	UI.ShowLookup({ query = q, kind = k, id = id })
end)

---------------------------------------------------------------------------
-- The guide menu's search: entity matches under its guide results
---------------------------------------------------------------------------

local pickerPools = setmetatable({}, { __mode = "k" }) -- parent -> { folder, rows }
local pickerCount, pickerTotal = 0, 0

local function pickerClick(self)
	local q = self.psQuery
	if self.psResult then
		UI.ShowLookup({ query = q, kind = self.psResult.kind, id = self.psResult.id })
	else
		UI.ShowLookup({ query = q })
	end
end

-- Draw up to a few matches per kind (items, mounts, NPCs, quests...) at y
-- in `parent` (the guide menu's list), rows `width` wide from x. -> new y.
function UI.LookupRows(parent, y, q, width, x)
	local pool = pickerPools[parent]
	if not pool then
		pool = { rows = {} }
		pickerPools[parent] = pool
	end
	pickerCount, pickerTotal = 0, 0
	local results, counts = {}, {}
	if q and q ~= "" then
		local only = {}
		for _, k in ipairs(kinds()) do if k.key ~= "guide" then only[k.key] = true end end
		results, counts = search(q, only, { perKind = PICKER_PER_KIND, limit = PICKER_PER_KIND * #kinds(), subtitles = false })
	end
	local per, picked = {}, {}
	for _, k in ipairs(kinds()) do
		for _, res in ipairs(results) do
			if res.kind == k.key and res.kind ~= "guide" and (per[res.kind] or 0) < PICKER_PER_KIND and #picked < PICKER_MAX then
				per[res.kind] = (per[res.kind] or 0) + 1
				picked[#picked + 1] = res
			end
		end
	end
	if #picked == 0 then
		if pool.folder then pool.folder:Hide() end
		for _, r in ipairs(pool.rows) do r:Hide() end
		return y
	end
	local total = 0
	for k, n in pairs(counts) do if k ~= "guide" then total = total + n end end
	pickerTotal = total
	if y > 8 then y = y + 10 end
	pool.folder = pool.folder or makeFolder(parent)
	local f = pool.folder
	f.Text:SetText(L["In the Codex"])
	f.Count:SetText(total)
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", parent, "TOPLEFT", x, -y)
	f:SetWidth(width)
	f:Show()
	y = y + FOLDER_H + 4
	local n = 0
	local function nextRow()
		n = n + 1
		local r = pool.rows[n]
		if not r then
			r = makeRow(parent)
			r:SetScript("OnClick", pickerClick)
			pool.rows[n] = r
		end
		r.psQuery = q
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", parent, "TOPLEFT", x, -y)
		y = y + ROW_H
		return r
	end
	for _, res in ipairs(picked) do
		local r = nextRow()
		local kindName = KIND[res.kind] and KIND[res.kind].name or res.kind
		local sub = subtitleOf(res)
		paintResult(r, res, sub and (kindName .. DOT .. sub) or kindName, width, false)
		r.psTip = L["Click to see where to get it."]
	end
	local r = nextRow()
	paintAction(r, format(L["Look up everything for %s"], LQ .. q .. RQ), "search", width)
	r.psTip = L["Opens Lookup with this search."]
	for i = n + 1, #pool.rows do pool.rows[i]:Hide() end
	pickerCount = #picked
	return y
end

-- Hides the matches drawn in `parent` by UI.LookupRows. The guide menu calls
-- it before every render: a list drawn without them (search cleared, another
-- view) must not show the last search's rows over its own.
function UI.HideLookupRows(parent)
	local pool = pickerPools[parent]
	pickerCount, pickerTotal = 0, 0
	if not pool then return end
	if pool.folder then pool.folder:Hide() end
	for _, r in ipairs(pool.rows) do r:Hide() end
end

-- Entity rows the guide menu shows now (its empty state stays away).
function UI.LookupCount() return pickerCount end

-- Everything the Codex matched for the guide menu's search (shown or not).
function UI.LookupTotal() return pickerTotal end
