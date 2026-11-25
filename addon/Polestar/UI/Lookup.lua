-- Lookup, a section of the hub (the guide menu's window, UI.RegisterSection
-- "Lookup"): one search over the guides and every entity in the Codex
-- (items, mounts, pets, recipes, quests, NPCs, rares, dungeons, zones,
-- treasures), and for the selection, where to get it, ranked for this
-- character, with one click to a guide.
--
-- Typing searches after a short pause. The sidebar shows Everything and
-- the kinds found, with exact counts. With an empty search, Everything shows the
-- recent lookups (CharState().ui.recentLookups) and a hint, and the sidebar
-- offers each available kind with its total. With filter data, Items opens
-- into a tree of item classes and subclasses, with counts at each level.
-- Pick a kind to browse A to Z, with unavailable entries last. The list
-- groups results by kind: under Everything a search shows the first few
-- and a "Show all" line. One kind shows pages of 50 with a "Show more"
-- line. While searching, Sort by above the results offers Best match and
-- A to Z (under Everything, for each kind's first few). With stat data,
-- Most orders item-backed results by
-- the chosen stat in search or browse. Filters opens a drawer above the
-- list for level ranges, class, rarity, slot, stat and availability. Drawer
-- item filters are saved in CharState().ui.lookupItemFilters. Availability
-- is account-wide. The order holds while the hub is open, and closing it
-- with an empty search box goes back to Best match.
-- Each row has an icon, the name in its quality or subject colour, and a
-- short subtitle.
-- Only the rows in view are drawn. Up/Down walk the results, and Enter acts
-- on the selection.
-- Right: the selection's details (its sources asked for once per
-- selection): a band (the zone art of where it is got, the night band
-- without) with the kind, the icon and the name; key facts. Items show
-- rarity and levels, the game's tooltip in its own order once loaded, and
-- any class restrictions in class colours. Sources from Lookup.Sources
-- appear best first (label, detail, travel time, chance, price
-- or standing; ones this character cannot use yet dimmed and saying why);
-- the selected source carries its own "Guide" button; for a quest in a
-- chain, the chain under them (Lookup.ChainProgress, #2554): each quest done,
-- in the log, open now or waiting and why, skipped ones marked, a click
-- opens that quest's page; pinned at the bottom
-- "Guide me" (or "Open guide" when a curated guide collects it), which opens
-- the guide in a new tab (Lookup.Guide). Guides in the results open in a new
-- tab or show among the guides; dungeons also open in the Dungeons section.
--
-- Without the Codex pack (Search.Status) it says what is missing and still
-- searches the guides.
--
-- Opened by SHOW_LOOKUP(query, kind, id) (Polestar.Lookup.Show) or
-- UI.ShowLookup({ query, kind, id }): the hub at this section.
--
-- The hub's guide search lists entity matches under its guide results
-- through UI.LookupRows / UI.LookupCount / UI.LookupTotal (an "In the
-- Codex" folder, a few per kind; UI.HideLookupRows clears them before the
-- menu draws a list); picking one opens this section at it.

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, type, ipairs, pairs, tostring, format = math.floor, math.max, math.min, type, ipairs, pairs, tostring, string.format
local ZoneArt = UI.ZoneArt

local SH = W.SHELL
local DETAIL_W = 372 -- the details pane, right (the guide menu's)
local MID_W = 1120 - SH.sidebar - 2 - DETAIL_W -- the results pane, left; measured from the hub on build
local ROW_X = 12 -- where list rows' grounds start in the middle pane
local TEXT_X = SH.pad - ROW_X -- text inside a row, on the column's x=32 edge
local ROW_H, FOLDER_H = 28, 32
local ART_H = 112 -- the details' band, under the tab row's hairline (the header band's height)
local DPAD = SH.side -- details pane inset
local INNER = DETAIL_W - DPAD * 2
local FACT_W, FACT_GAP = 84, 10
local ICON = 36 -- the selection's icon on the band
local GROUP_MAX = 5 -- results per kind under Everything
local PAGE = 50 -- results per page under one kind ("Show more" adds a page)
local RECENT_MAX = 10 -- recent lookups kept per character
local PICKER_PER_KIND, PICKER_MAX = 3, 9
local DEBOUNCE = 0.15
local DOT = "  \194\183  "
local LQ, RQ = "\226\128\156", "\226\128\157"

local LK = {}
UI.Lookup = LK

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

local SOURCE_ICON = {
	vendor = "icon-vendor", drop = "icon-kill", object = "icon-interact", quest = "icon-accept", gift = "icon-talk", craft = "icon-craft",
	rep = "icon-rep", pvp = "icon-achieve", container = "icon-use", world = "icon-explore",
	flight = "icon-fly", inn = "icon-sethome", middle = "icon-explore",
}

-- The client's colours, for a client (or preview) without the API.
local QUALITY_RGB = {
	[0] = { 0.62, 0.62, 0.62 }, { 1, 1, 1 }, { 0.12, 1, 0 }, { 0, 0.44, 0.87 }, { 0.64, 0.21, 0.93 }, { 1, 0.5, 0 }, { 0.9, 0.8, 0.5 },
	{ 0, 0.8, 1 }, { 0, 0.8, 1 }, -- Heirloom, WoW Token
}
local FACTION = { A = ns.FactionName("A"), H = ns.FactionName("H"), AH = L["Both factions"] }

local shell, root, results, details -- the hub window, this section, the results scroll, the details pane
local query, kind = "", "all"
local category, openBranches = nil, {}
-- Most has a separate stat and keeps the base search order for other kinds.
-- These choices live until the hub closes with its search box empty.
local order, baseOrder, sortStat = "best", "best", nil
local sel -- { kind, id, title, subtitle, quality }
local sourceSel -- index into the selection's sources
local visible = {} -- results in the middle pane, top to bottom
local pending -- the debounce timer
-- The selection's sources (Lookup.Sources), kept until the selection changes.
local detailCache = {}
local itemDetails = {}
local rowPool, folderPool = {}, {}

---------------------------------------------------------------------------
-- Data
---------------------------------------------------------------------------

local secret = ns.Compat.IsSecret

local function kinds()
	local S = ns.Search
	return S and type(S.KINDS) == "table" and S.KINDS or FALLBACK_KINDS
end

local function kindLabel(key)
	for _, k in ipairs(kinds()) do if k.key == key then return k.label end end
	return L[key]
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

-- Turned off in Options: nothing may load the Codex.
local function lookupOff() return select(2, status()) == "off" end

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

-- A short line for the tab row.
local function reasonShort(reason)
	if reason == "loading" then return L["Loading the Codex\226\128\166"] end
	if reason == "off" then return L["Lookup is off: searching guides only"] end
	if reason == "missing" then return L["Codex not installed: searching guides only"] end
	if reason == "disabled" then return L["Codex disabled: searching guides only"] end
	if reason == "combat" then return L["Codex loads after combat"] end
	return L["Codex unavailable: searching guides only"]
end

local function search(text, only, opts)
	local S = ns.Search
	if text == "" or not (S and S.Query) then return {}, {} end
	opts.kinds = only
	local results, counts, syntaxError, info = S.Query(text, opts)
	return results or {}, counts or {}, info, syntaxError
end

local function codexRecord(k, id)
	local C = ns.Codex
	if not C or lookupOff() then return nil end
	-- Looking an entity up loads the pack, as a search would.
	if not (C.IsLoaded and C.IsLoaded()) and not (C.Load and C.Load()) then return nil end
	if KIND[k] and KIND[k].item then return C.Item and C.Item(id) end
	if k == "npc" or k == "rare" then return C.Npc and C.Npc(id) end
	if k == "quest" then return C.Quest and C.Quest(id) end
	if k == "instance" then return C.Instance and C.Instance(id) end
	if k == "zone" then return C.Zone and C.Zone(id) end
	if k == "treasure" then return C.Object and C.Object(id) end
	return nil
end

-- -> sources (ranked), entity; nil when the runtime has none for this kind.
local function sourcesOf(k, id)
	local Lk = ns.Lookup
	-- Guides and kinds other modules register have no Codex sources.
	if k == "guide" or not KIND[k] or not (Lk and Lk.Sources) then return nil, codexRecord(k, id) end
	local list, entity = Lk.Sources(k, id)
	return list, entity or codexRecord(k, id)
end

local function curatedOf(k, id)
	local Lk = ns.Lookup
	if k == "guide" or not KIND[k] or not (Lk and Lk.CuratedGuide) then return nil end
	return Lk.CuratedGuide(k, id)
end

local function guideHeader(id)
	local G = ns.Guides
	return G and G.Get and G.Get(id) or nil
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

-- Standings in the client's words (Core/Init.lua).
local standingName = ns.StandingName

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

function LK.Travel(seconds)
	if type(seconds) ~= "number" then return nil end
	if seconds < 60 then return L["< 1 min"] end
	local m = floor(seconds / 60 + 0.5)
	if m < 60 then return format(L["%d min"], m) end
	return format(L["%d h %d min"], floor(m / 60), m % 60)
end

function LK.Percent(p)
	if type(p) ~= "number" then return nil end
	local s
	if p >= 10 then s = format("%d", floor(p + 0.5)) else s = format("%.2f", p):gsub("0+$", ""):gsub("%.$", "") end
	return s .. "%"
end

-- The third line of a source: its odds, price, standing, stock.
local function sourceFacts(row)
	local src = type(row.src) == "table" and row.src or {}
	local parts = {}
	local chance = row.chance or src.chance
	if chance then
		parts[#parts + 1] = format(row.type == "drop" and L["%s drop chance"] or L["%s chance"], LK.Percent(chance))
	end
	local price = LK.Money(row.price)
	if price then parts[#parts + 1] = price end
	local standing = standingName(row.standing or src.standing)
	-- Said once: the detail ("Reputation · Exalted") may carry it already.
	if standing and not (type(row.detail) == "string" and row.detail:find(standing, 1, true)) then parts[#parts + 1] = standing end
	if src.limited then parts[#parts + 1] = L["Limited stock"] end
	if src.choice then parts[#parts + 1] = L["Reward choice"] end
	if #parts == 0 then return nil end
	return table.concat(parts, DOT)
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
local STATUS_NOTE = {
	retired = L["Not obtainable any more; shown for reference."],
	nosource = L["No source is known for this; shown for reference."],
}
-- A mount without a curated guide: nothing is built from its best source.
local MOUNT_NOTE = L["No guide to this mount yet: the sources above say where it comes from and what it takes. Guide on one leads you there."]
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

---------------------------------------------------------------------------
-- Selection and actions
---------------------------------------------------------------------------

local function keyOf(k, id) return tostring(k) .. ":" .. tostring(id) end

function LK.Selected() return sel end

-- auto: picked by the search (the first result), not by the player; only a
-- page the player opens joins the recent lookups.
local function setSelection(k, id, res, auto)
	local same = sel and sel.kind == k and sel.id == id
	if not same then
		detailCache = {}
		if details then W.ScrollTo(details.Scroll, 0) end
	end
	itemDetails.direct, itemDetails.outside = nil, nil
	if k == nil or id == nil then
		sel = nil
	else
		res = res or {}
		sel = { kind = k, id = id, title = res.title, subtitle = res.subtitle, quality = res.quality, status = res.status, remember = not auto }
	end
	sourceSel = nil
end

function LK.Select(k, id, res, auto)
	setSelection(k, id, res, auto)
	LK.Render()
end

-- The recent lookups, newest first.
function LK.Recent()
	local s = ns.CharState and ns.CharState()
	if type(s) ~= "table" then return {} end
	s.ui = s.ui or {}
	s.ui.recentLookups = s.ui.recentLookups or {}
	return s.ui.recentLookups
end

local function itemFilterInteger(value, max)
	if type(value) == "number" and value >= 0 and value <= max and value % 1 == 0 then
		return value == 0 and 0 or value
	end
end

local function itemFilterRange(lo, hi)
	lo, hi = itemFilterInteger(lo, 999), itemFilterInteger(hi, 999)
	if lo and hi and lo > hi then return nil, nil end
	return lo, hi
end

local function normalizeItemFilters(input)
	local filters = {}
	if type(input) ~= "table" then return filters end
	filters.reqMin, filters.reqMax = itemFilterRange(input.reqMin, input.reqMax)
	filters.ilvlMin, filters.ilvlMax = itemFilterRange(input.ilvlMin, input.ilvlMax)
	filters.slot = itemFilterInteger(input.slot, 34)

	if type(input.quality) == "table" then
		local seen, quality = {}, {}
		-- A rarity is either an array value or the key of a true set entry.
		for index, value in pairs(input.quality) do
			local id
			if value == true then
				id = itemFilterInteger(index, 8)
			elseif type(index) == "number" and index >= 1 and index % 1 == 0 then
				id = itemFilterInteger(value, 8)
			end
			if id then seen[id] = true end
		end
		for id = 0, 8 do
			if seen[id] then quality[#quality + 1] = id end
		end
		if #quality > 0 then filters.quality = quality end
	end

	local class = input.class
	-- Before Gear loads, retain the token so it can be checked on the next read.
	local classes = ns.Gear and ns.Gear.CLASSES
	if type(class) == "string" and (classes and classes[class] or not classes and class:match("^[A-Z]+$")) then
		filters.class = class
	end
	local S, stat = ns.Search, input.stat
	if type(stat) == "number" and S and S.StatLabel and S.StatLabel(stat) then
		filters.stat = stat
	end
	return filters
end

local function savedItemFilterState()
	local s = ns.CharState and ns.CharState()
	return type(s) == "table" and type(s.ui) == "table" and s.ui.lookupItemFilters or nil
end

function LK.ItemFilters()
	return normalizeItemFilters(savedItemFilterState())
end

function LK.SetItemFilters(input)
	local filters = normalizeItemFilters(input)
	local s = ns.CharState and ns.CharState()
	if type(s) ~= "table" then return filters end
	if next(filters) then
		if type(s.ui) ~= "table" then s.ui = {} end
		local saved = {}
		for key, value in pairs(filters) do saved[key] = value end
		if filters.quality then saved.quality = { unpack(filters.quality) } end
		s.ui.lookupItemFilters = saved
	elseif type(s.ui) == "table" then
		s.ui.lookupItemFilters = nil
	end
	return filters
end

function LK.ClearItemFilters()
	return LK.SetItemFilters({})
end

local function gearKind(k)
	return k == "item" or k == "all"
end

-- Slot and Stat apply only in gear views; elsewhere they stay saved but are
-- suspended: not searched, not shown, not counted and not cleared.
local GEAR_ONLY_FILTERS = { slot = true, stat = true }

-- Whether the saved item filter key applies in viewKind (nil: every view).
local function filterApplies(key, viewKind)
	return not GEAR_ONLY_FILTERS[key] or viewKind == nil or gearKind(viewKind)
end

-- Adapt the normalized saved shape to Search's predicates.
function LK.SearchFilters(saved, category, viewKind)
	if type(saved) ~= "table" then saved = {} end
	local filters = {
		reqMin = saved.reqMin, reqMax = saved.reqMax, ilvlMin = saved.ilvlMin, ilvlMax = saved.ilvlMax,
		class = saved.class, category = category,
	}
	for key in pairs(GEAR_ONLY_FILTERS) do
		if filterApplies(key, viewKind) then filters[key] = saved[key] end
	end
	if saved.quality and #saved.quality > 0 then
		filters.quality = {}
		for _, id in ipairs(saved.quality) do filters.quality[id] = true end
	end
	if next(filters) then return filters end
end

local function remember(k, id, title, quality, status)
	local list = LK.Recent()
	for i = #list, 1, -1 do
		if list[i].kind == k and list[i].id == id then table.remove(list, i) end
	end
	table.insert(list, 1, { kind = k, id = id, title = title, quality = quality, status = status })
	for i = #list, RECENT_MAX + 1, -1 do list[i] = nil end
end

function LK.SelectSource(i)
	sourceSel = i
	LK.Render()
end

local function setStatus(text)
	LK.message = text
	if details then
		details.Note:SetText(text or "")
		W.Color(details.Note, "warning")
	end
end

-- Open a guide (curated or built) for the selection; source index i, else
-- the best one.
function LK.Guide(i)
	-- Nothing leads to what cannot be got.
	if not sel or STATUS_TEXT[sel.status] then return nil end
	local Lk = ns.Lookup
	if not (Lk and Lk.Guide) then return nil end
	local gid, reason = Lk.Guide(sel.kind, sel.id, i)
	if gid then
		-- The guide opens in its tab; the hub steps aside, as loading does.
		ns.Set("ui.shown", true)
		if shell then shell:Hide() end
		return gid
	end
	if reason == "tabs" then
		setStatus(L["Six tabs is the limit. Close one to open another."])
	elseif reason == "mount" then
		setStatus(MOUNT_NOTE)
	else
		setStatus(format(L["No guide could be made for this (%s)."], tostring(reason or "no source")))
	end
	return nil, reason
end

-- A guide result: open it in a new tab, or show it among the hub's guides.
function LK.OpenGuide(id, inMenu)
	if not id then return end
	local P = UI.Picker
	if not P then return end
	if inMenu or not (P.Load and ns.Engine and ns.Engine.OpenTab) then
		if P.Select then P.Select(id) end
		if P.SetCategory then P.SetCategory("All") end
		return
	end
	P.Load(id, true)
end

-- Hand a dungeon to the Dungeons section (its bosses and loot).
local function hasDungeons() return ns.Dungeons and ns.Dungeons.Open and true or false end
function LK.OpenDungeon(key)
	if not hasDungeons() then return false end
	ns.Dungeons.Open(key)
	return true
end

-- Enter: the selection's primary action.
function LK.Activate()
	if not sel then return end
	-- Acting on it is opening it: it joins the recent lookups.
	if LK.detail and LK.detail.kind == sel.kind and LK.detail.id == sel.id then
		remember(sel.kind, sel.id, LK.detail.title, sel.quality, sel.status)
	end
	if sel.kind == "guide" then
		LK.OpenGuide(sel.id)
	elseif sourceSel then
		LK.Guide(sourceSel)
	elseif details and details.psPrimaryAction then
		details.psPrimaryAction()
	elseif sel.kind == "zone" and not (LK.detail and LK.detail.primary) then
		-- A continent or a battleground: nothing to guide to, and the note says so.
		return
	else
		LK.Guide(nil)
	end
end

---------------------------------------------------------------------------
-- Details pane
---------------------------------------------------------------------------

local function factRow(i)
	local f = details.Facts[i]
	if f then return f end
	f = {}
	f.Label = W.Text(details, "small", "textMuted")
	f.Label:SetWidth(FACT_W)
	f.Label:SetJustifyH("LEFT")
	f.Value = W.Text(details, "note", "text")
	f.Value:SetWidth(INNER - FACT_W)
	f.Value:SetJustifyH("LEFT")
	f.Value:SetJustifyV("TOP")
	f.Value:SetWordWrap(true)
	details.Facts[i] = f
	return f
end

local function sourceRowClick(self, button)
	if self.psIndex then LK.SelectSource(self.psIndex) end
end

local function sourceRowDouble(self)
	if self.psIndex then LK.Guide(self.psIndex) end
end

local function sourceRow(i)
	local r = details.Rows[i]
	if r then return r end
	local parent = details.Scroll.Child
	r = CreateFrame("Button", nil, parent)
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
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(14, 14)
	r.Icon:SetPoint("TOPLEFT", r, "TOPLEFT", 8, -9)
	r.Label = W.Text(r, "body", "text")
	r.Label:SetPoint("TOPLEFT", r, "TOPLEFT", 30, -8)
	r.Travel = W.Text(r, "small", "textDim")
	r.Travel:SetJustifyH("RIGHT")
	r.Travel:SetPoint("TOPRIGHT", r, "TOPRIGHT", -10, -9)
	r.Detail = W.Text(r, "small", "textDim")
	r.Detail:SetPoint("TOPLEFT", r, "TOPLEFT", 30, -27)
	r.Facts = W.Text(r, "small", "textMuted")
	r.Facts:SetPoint("TOPLEFT", r, "TOPLEFT", 30, -43)
	-- Why this character cannot use it yet, under the facts.
	r.Why = W.Text(r, "small", "warning")
	r.Guide = W.Button(r, L["Guide"], function(b) LK.Guide(b:GetParent().psIndex) end, { height = 24, icon = "icon-goto" })
	r.Guide:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", -8, 8)
	r.Guide.psTip = L["Build a guide to this source and open it in a new tab."]
	r:SetScript("OnClick", sourceRowClick)
	r:SetScript("OnDoubleClick", sourceRowDouble)
	r:SetScript("OnEnter", W.SimpleTip)
	r:SetScript("OnLeave", W.HideTip)
	details.Rows[i] = r
	return r
end

-- The details' icon: an item's page shows the game's own tooltip for it on
-- hover (W.ItemTip), and Shift-click links it in chat, Ctrl-click tries it
-- on (W.ItemClick), as the Dungeons section's tiles do; other pages have none.
local function wellEnter(self)
	self.Highlight:SetShown(self.psItem ~= nil)
	if self.psItem then W.ItemTip(self, self.psItem) else W.HideTooltip(self) end
end

local function wellLeave(self)
	self.Highlight:Hide()
	W.HideTooltip(self)
end

local function wellClick(self, button)
	if self.psItem and button == "LeftButton" then W.ItemClick(self.psItem) end
end

local function buildDetails()
	local d = CreateFrame("Frame", nil, root)
	details = d
	LK.details = d
	d:SetPoint("TOPRIGHT", root, "TOPRIGHT", 0, 0)
	d:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", 0, 0)
	d:SetWidth(DETAIL_W)
	d:EnableMouse(true)
	W.Fill(d, "panel")
	local rule = W.Divider(d, true)
	rule:SetPoint("TOPLEFT", d, "TOPLEFT", 0, 0)
	rule:SetPoint("BOTTOMLEFT", d, "BOTTOMLEFT", 0, 0)

	d.Art = ZoneArt.Create(d, DETAIL_W, ART_H, "panel")
	d.Art.psZoom = 1.5
	d.Art:SetPoint("TOPLEFT", d, "TOPLEFT", 0, 0)
	ns.DragWindow(d.Art, shell)
	-- The icon in a dark well with a hairline in the quality colour, the
	-- name beside it and a muted line under the name.
	d.Well = CreateFrame("Frame", nil, d.Art.Over)
	d.Well:SetSize(ICON, ICON)
	d.Well:SetPoint("BOTTOMLEFT", d.Art, "BOTTOMLEFT", DPAD, 16)
	d.Well:SetFrameLevel(d.Art.Over:GetFrameLevel() + 2)
	d.Well:SetScript("OnEnter", wellEnter)
	d.Well:SetScript("OnLeave", wellLeave)
	d.Well:SetScript("OnMouseUp", wellClick)
	d.WellGround = d.Well:CreateTexture(nil, "BACKGROUND")
	d.WellGround:SetTexture(Theme.Media("white"))
	d.WellGround:SetAllPoints(d.Well)
	W.Painter(d.WellGround, function(t)
		local r, g, b = Theme.Color("scrim")
		t:SetVertexColor(r, g, b, 0.72)
	end)
	d.Icon = d.Well:CreateTexture(nil, "ARTWORK")
	d.Well.Highlight = d.Well:CreateTexture(nil, "OVERLAY")
	d.Well.Highlight:SetPoint("TOPLEFT", d.Well, "TOPLEFT", 1, -1)
	d.Well.Highlight:SetPoint("BOTTOMRIGHT", d.Well, "BOTTOMRIGHT", -1, 1)
	d.Well.Highlight:SetColorTexture(1, 1, 1, 0.08)
	d.Well.Highlight:Hide()
	d.Title = W.Text(d.Art.Over, "display", "text")
	d.Title:SetPoint("BOTTOMLEFT", d.Art, "BOTTOMLEFT", DPAD + ICON + 12, 16 + 11 + 7)
	d.Title:SetWidth(INNER - ICON - 12)
	-- A long name takes a second line, upward from the subtitle.
	d.Title:SetWordWrap(true)
	d.Title:SetMaxLines(2)
	d.Title:SetJustifyH("LEFT")
	d.Sub = W.Text(d.Art.Over, "small", "textDim")
	d.Sub:SetPoint("BOTTOMLEFT", d.Art, "BOTTOMLEFT", DPAD + ICON + 12, 17)
	d.Sub:SetWidth(INNER - ICON - 12)
	for _, fs in ipairs({ d.Title, d.Sub }) do
		W.Painter(fs, function(t)
			local r, g, b = Theme.Color("shade")
			t:SetShadowOffset(0, -1)
			t:SetShadowColor(r, g, b, 0.85)
		end)
	end

	d.Facts = {}
	-- What makes it unobtainable, first under the band.
	d.Status = W.Chip(d)
	d.Status:Hide()
	-- The sources, under a small folder header, scrolling down to the note.
	d.Head = makeFolder(d)
	d.Head:SetWidth(INNER + TEXT_X * 2)
	d.Scroll = W.Scroll(d)
	d.Rows = {}
	d.NoSource = W.Text(d.Scroll.Child, "note", "textMuted")
	d.NoSource:SetWordWrap(true)
	d.NoSource:SetJustifyV("TOP")
	d.NoSource:SetWidth(INNER)
	d.NoSource:SetPoint("TOPLEFT", d.Scroll.Child, "TOPLEFT", 0, -4)
	-- A quest's chain, under its sources (#2554).
	d.ChainHead = makeFolder(d.Scroll.Child)
	d.ChainHead:Hide()
	d.ChainRows = {}
	d.ChainBranches = W.Text(d.Scroll.Child, "small", "textDim")
	d.ChainBranches:SetWordWrap(true)
	d.ChainBranches:Hide()

	-- Pinned at the bottom: a line saying what the button does, the button.
	d.Note = W.Text(d, "note", "textDim")
	d.Note:SetWordWrap(true)
	d.Note:SetJustifyV("BOTTOM")
	d.Note:SetWidth(INNER)
	d.Note:SetPoint("BOTTOMLEFT", d, "BOTTOMLEFT", DPAD, DPAD + 32 + 12)
	d.Primary = W.Button(d, L["Guide me"], function() LK.Activate() end, { primary = true, height = 32 })
	d.Primary:SetPoint("BOTTOMLEFT", d, "BOTTOMLEFT", DPAD, DPAD)
	d.Secondary = W.Button(d, L["Show in Guides"], function(b) if b.psAction then b.psAction() end end, { height = 32 })
	d.Secondary:SetPoint("BOTTOMRIGHT", d, "BOTTOMRIGHT", -DPAD, DPAD)

	-- Nothing selected (or nothing to look in).
	d.EmptyTitle = W.Text(d, "display", "text")
	d.EmptyTitle:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -(ART_H + 24))
	d.EmptyTitle:SetWidth(INNER)
	d.EmptyNote = W.Text(d, "note", "textDim")
	d.EmptyNote:SetWordWrap(true)
	d.EmptyNote:SetJustifyV("TOP")
	d.EmptyNote:SetWidth(INNER)
	d.EmptyNote:SetPoint("TOPLEFT", d.EmptyTitle, "BOTTOMLEFT", 0, -10)
end

local function skyIndex(s)
	local n = 0
	for i = 1, #s do n = (n * 31 + s:byte(i)) % 997 end
	return n + 1
end

local function setButtonWidth(b, w)
	b.psFixedWidth = w
	W.SetButtonText(b, b.Label:GetText())
end

local function setButton(b, text, enabled)
	W.SetButtonText(b, text)
	b:SetEnabled(enabled ~= false)
	b:SetAlpha(enabled == false and 0.5 or 1)
end

-- A chain row: the state's glyph, the quest's title, and its state.
local CHAIN_ROW_H = 40
local CHAIN_GLYPH = {
	done = { "check", "success" }, log = { "icon-accept", "accent" },
	open = { "circle", "quest" }, later = { "lock", "textMuted" },
}

local function chainRowClick(self)
	if self.psQuest then LK.Select("quest", self.psQuest) end
end

local function chainRow(i)
	local d = details
	local r = d.ChainRows[i]
	if r then return r end
	r = CreateFrame("Button", nil, d.Scroll.Child)
	W.Hover(r)
	r:SetHeight(CHAIN_ROW_H)
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(12, 12)
	r.Icon:SetPoint("TOPLEFT", r, "TOPLEFT", 9, -8)
	r.Label = W.Text(r, "body", "text")
	r.Label:SetPoint("TOPLEFT", r, "TOPLEFT", 30, -6)
	r.State = W.Text(r, "small", "textDim")
	r.State:SetPoint("TOPLEFT", r, "TOPLEFT", 30, -23)
	r:SetScript("OnClick", chainRowClick)
	r:SetScript("OnEnter", W.SimpleTip)
	r:SetScript("OnLeave", W.HideTip)
	d.ChainRows[i] = r
	return r
end

-- What a chain row says about its quest.
local function chainStateText(e)
	if e.state == "done" then return L["Done"] end
	local t
	if e.state == "log" then
		t = L["In your quest log"]
	elseif e.state == "open" then
		t = L["You can take it now"]
	else
		t = e.why or L["Not yet"]
	end
	if e.skipped then t = L["Skipped"] .. DOT .. t end
	return t
end

-- "Step 6 of 11", "All 11 done", or "Finished, 2 skipped" when only skipped
-- quests are left.
local function chainStepText(chain)
	if chain.done and (chain.skippedCount or 0) > 0 then
		return format(L["Finished, %d skipped"], chain.skippedCount)
	end
	if chain.done then return format(L["All %d done"], chain.total) end
	return format(L["Step %d of %d"], chain.step, chain.total)
end
LK.ChainStepText = chainStepText

-- Facts: { label, value, colour? }.
local function factsFor(s, entity, list, chain)
	local k, e, out = s.kind, entity or {}, {}
	local function add(label, value, color) if value and value ~= "" then out[#out + 1] = { label, value, color } end end
	if k == "guide" then
		local g = guideHeader(s.id) or {}
		add(L["Category"], g and UI.Category and L[UI.Category(g)])
		add(L["Levels"], UI.GuideLevels(g))
		add(L["Faction"], ns.FactionName(g.faction) or L["Both factions"])
		if g.stepCount or g.steps then add(L["Steps"], tostring(g.stepCount or #g.steps)) end
		return out
	end
	if k == "npc" or k == "rare" then
		local tags = { KIND[k].name }
		if e.elite then tags[#tags + 1] = L["Elite"] end
		if e.boss then tags[#tags + 1] = L["Boss"] end
		add(L["Type"], table.concat(tags, DOT))
		if e.level then add(L["Level"], (e.levelMax and e.levelMax ~= e.level) and (e.level .. "-" .. e.levelMax) or tostring(e.level)) end
		if e.faction then add(L["Faction"], FACTION[e.faction] or L[e.faction]) end
		if e.instance then
			local inst = codexRecord("instance", e.instance)
			add(L["Dungeon"], inst and inst.name or tostring(e.instance))
		end
	elseif k == "quest" then
		if e.level then add(L["Level"], (e.minLevel and e.minLevel ~= e.level) and format(L["%d (from %d)"], e.level, e.minLevel) or tostring(e.level)) end
		-- Offered only from a level above the character's: said in the warning
		-- colour (#3370: In Demand reads "Level 60", and a level 57 went for it).
		local own = ns.Compat.GetPlayerInfo().level
		if e.minLevel and own and own < e.minLevel then add(L["Requires"], format(L["Level %d"], e.minLevel), "warning") end
		add(L["Faction"], e.faction and (FACTION[e.faction] or L[e.faction]) or L["Both factions"])
		if e.zone then
			local z = UI.MapName(e.zone) or (codexRecord("zone", e.zone) or {}).name
			add(L["Zone"], z)
		end
		local new = ns.NewQuests and ns.NewQuests.TooltipText(s.id)
		add(L["Origin"], new, "accent")
		if chain then add(L["Chain"], chainStepText(chain), chain.done and (chain.skippedCount or 0) == 0 and "success" or nil) end
	elseif k == "instance" then
		add(L["Type"], e.kind == "raid" and L["Raid"] or L["Dungeon"])
		local lv = type(e.levels) == "table" and UI.LevelRange(e.levels[2] or e.levels[1], e.levels[3])
		add(L["Levels"], lv or nil)
		if type(e.bosses) == "table" and #e.bosses > 0 then add(L["Bosses"], tostring(#e.bosses)) end
	else
		add(L["Type"], KIND[k] and KIND[k].name or L[k])
	end
	if list and k ~= "zone" then
		local avail = 0
		for _, row in ipairs(list) do if row.available ~= false then avail = avail + 1 end end
		local label = L["Places"]
		if #list == 0 then
			add(label, L["None known"], "textMuted")
		elseif avail == #list then
			add(label, tostring(#list))
		else
			add(label, format(L["%d  \194\183  %d open to you"], #list, avail))
		end
	end
	return out
end

local function headText(k)
	if k == "quest" then return L["Start and turn-in"] end
	if k == "instance" then return L["Entrance"] end
	return L["Where to find it"]
end

-- The band: where it is got (the best source with a place), or its own
-- map, else the night sky. A dungeon without a known entrance: the zone its
-- page places it in (its own `map` is the instance's, no zone painting).
local function bandMap(s, entity, list)
	if s.kind == "zone" then return s.id end
	if s.kind == "guide" then
		local g = guideHeader(s.id)
		return g and g.zone, nil, nil
	end
	for _, row in ipairs(list or {}) do
		if row.map then return row.map, row.x, row.y end
	end
	if entity and type(entity.entrance) == "table" then return entity.entrance.map, entity.entrance.x, entity.entrance.y end
	if s.kind == "instance" then
		local d = ns.Dungeons and ns.Dungeons.Get and ns.Dungeons.Get(s.id)
		return d and d.zone or nil
	end
	return entity and entity.map or nil
end

local function emptyDetails(title, note)
	local d = details
	d.psArt = ZoneArt.Paint(d.Art, nil, nil, nil, 1)
	for _, p in ipairs({ d.Well, d.Title, d.Sub, d.Status, d.Head, d.Scroll, d.Note, d.Primary, d.Secondary }) do p:Hide() end
	d.Well.psItem = nil
	d.Well.Highlight:Hide()
	W.HideTooltip(d.Well)
	itemDetails.Hide(d)
	for _, f in ipairs(d.Facts) do
		f.Label:Hide()
		f.Value:Hide()
	end
	d.EmptyTitle:SetText(title)
	d.EmptyNote:SetText(note)
	d.EmptyTitle:Show()
	d.EmptyNote:Show()
	LK.detail = { empty = title, note = note }
end

-- The selection's sources, asked for once per selection (and again only
-- when the Codex or the guides change).
local function selectionSources(s)
	local key = keyOf(s.kind, s.id)
	if detailCache.key ~= key or detailCache.gen ~= LK.gen then
		local list, entity = sourcesOf(s.kind, s.id)
		detailCache = { key = key, gen = LK.gen, list = list, entity = entity }
	end
	return detailCache.list, detailCache.entity
end

local function paintLegacyFacts(d, facts, shown, y)
	if facts then
		for i, f in ipairs(facts) do
			local row = factRow(i)
			row.Label:SetText(f[1])
			row.Value:SetText(f[2])
			W.Color(row.Value, f[3] or "text")
			row.Label:ClearAllPoints()
			row.Label:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -(y + 1))
			row.Value:ClearAllPoints()
			row.Value:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD + FACT_W, -y)
			row.Label:Show()
			row.Value:Show()
			y = y + max(row.Value:GetStringHeight(), row.Label:GetStringHeight()) + FACT_GAP
			shown[i] = { f[1], f[2] }
		end
		y = y - FACT_GAP + 8
	end
	for i = #shown + 1, #d.Facts do
		d.Facts[i].Label:Hide()
		d.Facts[i].Value:Hide()
	end
	return y
end

local function renderDetails(loaded, reason)
	local d = details
	if not sel then
		if reason == "loading" then
			emptyDetails(L["Loading the Codex\226\128\166"], L["Results come in as soon as it is ready."])
		elseif not loaded and reason ~= "notloaded" and reason ~= nil then
			local title = reason == "off" and L["Lookup is turned off"] or L["The Codex is not loaded"]
			emptyDetails(title, LK.ReasonText(reason) .. "\n\n" .. L["Guides are still searched; their results open from here."])
		else
			emptyDetails(L["Look something up"], L["Type a name: a mount, an item, a pet, an NPC, a quest, a dungeon or a zone. Select a result to see where to get it, best for you first."])
		end
		return
	end
	d.EmptyTitle:Hide()
	d.EmptyNote:Hide()
	local s = sel
	local list, entity = selectionSources(s)
	local g = s.kind == "guide" and guideHeader(s.id) or nil
	local title = s.kind == "guide" and (g and g.title) or localTitle(s.kind, s.id, entity and (entity.name or entity.title)) or s.title or tostring(s.id)
	local quality = entity and entity.quality or s.quality
	local status = entity and entity.status or s.status
	s.status = status
	-- A page the player opened joins the recent lookups.
	if s.remember then
		s.remember = nil
		remember(s.kind, s.id, title, quality, status)
	end
	local blocked = STATUS_TEXT[status] ~= nil

	-- The band.
	local map, fx, fy = bandMap(s, entity, list)
	d.psArt = ZoneArt.Paint(d.Art, map, fx, fy, skyIndex(keyOf(s.kind, s.id)))
	-- A dungeon with no zone known: its loading screen (Dungeons.Art).
	local pic = not d.psArt and s.kind == "instance" and ns.Dungeons and ns.Dungeons.Art and ns.Dungeons.Art(s.id)
	if pic then d.psArt = ZoneArt.Picture(d.Art, pic) end
	local icon = KIND[s.kind] and KIND[s.kind].item and itemIcon(s.id)
	d.Icon:ClearAllPoints()
	if icon then
		W.Uncolor(d.Icon)
		d.Icon:SetTexture(icon)
		d.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		d.Icon:SetVertexColor(1, 1, 1, 1)
		d.Icon:SetPoint("TOPLEFT", d.Well, "TOPLEFT", 1, -1)
		d.Icon:SetPoint("BOTTOMRIGHT", d.Well, "BOTTOMRIGHT", -1, 1)
	else
		setGlyph(d.Icon, KIND[s.kind] and KIND[s.kind].icon or "search", "text")
		d.Icon:SetSize(18, 18)
		d.Icon:SetPoint("CENTER", d.Well, "CENTER", 0, 0)
	end
	local qr, qg, qb = qualityColor(quality)
	if qr and KIND[s.kind] and KIND[s.kind].item then
		Theme.Border(d.Well, qr, qg, qb, 0.9)
		if not icon then
			W.Uncolor(d.Icon)
			d.Icon:SetVertexColor(qr, qg, qb, 1)
		end
	else
		local ir, ig, ib = Theme.Color("ink")
		Theme.Border(d.Well, ir, ig, ib, 0.18)
	end
	-- Only an item's icon takes the mouse, so the band still drags the window
	-- from any other page's glyph; a tooltip already up follows the new page.
	d.Well.psItem = KIND[s.kind] and KIND[s.kind].item and type(s.id) == "number" and s.id or nil
	d.Well:EnableMouse(d.Well.psItem ~= nil)
	if not d.Well.psItem then d.Well.Highlight:Hide() end
	-- (Through GetScript: this function is at Lua 5.1's 60 upvalues.)
	if GameTooltip and GameTooltip.GetOwner and GameTooltip:GetOwner() == d.Well then d.Well:GetScript("OnEnter")(d.Well) end
	d.Well:Show()
	d.Title:SetText(title .. questMark(s))
	paintName(d.Title, s.kind, quality)
	d.Title:Show()
	local sub = s.subtitle
	if s.kind == "guide" and g then sub = UI.GuidePlace(g) or sub end
	if sub == title then sub = nil end
	if not sub and s.kind ~= "guide" and ns.Lookup and ns.Lookup.Subtitle then sub = ns.Lookup.Subtitle(s.kind, s.id) end
	d.Sub:SetText(sub or "")
	d.Sub:SetShown(sub ~= nil and sub ~= "")
	-- Alone, the name centres on the icon (one line, or two).
	local base = d.Sub:IsShown() and (16 + 11 + 7) or (d.Title:GetNumLines() > 1 and 16 or (16 + 9))
	d.Title:SetPoint("BOTTOMLEFT", d.Art, "BOTTOMLEFT", DPAD + ICON + 12, base)

	-- Facts.
	local y = ART_H + 18
	if blocked then
		paintStatus(d.Status, status)
		d.Status:ClearAllPoints()
		d.Status:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -(ART_H + 16))
		y = ART_H + 16 + W.CHIP_H + 14
	else
		d.Status:Hide()
	end
	local Lk = ns.Lookup
	local chain = s.kind == "quest" and Lk and Lk.ChainProgress and Lk.ChainProgress(s.id) or nil
	local item = itemDetails.Read(s, loaded, entity)
	local facts = not item and factsFor(s, entity, list, chain)
	local shown = {}
	y = itemDetails.Outside(d, itemDetails.outside, y)
	y = paintLegacyFacts(d, facts, shown, y)

	-- The bottom: what the button does, then the button(s).
	local curated = curatedOf(s.kind, s.id)
	local note, primary, enabled, secondary
	local best
	for i, row in ipairs(list or {}) do
		if row.available ~= false and row.guideable then best = best or i end
	end
	local dungeon = s.kind == "instance" and hasDungeons()
	d.psPrimaryAction, d.Secondary.psAction = nil, nil
	if s.kind == "guide" then
		if ns.Engine and ns.Engine.OpenTab then
			primary, secondary = L["Open in new tab"], L["Show in Guides"]
		else
			primary = L["Show in Guides"]
		end
		d.Secondary.psAction = function() LK.OpenGuide(s.id, true) end
		note = g and g.pitch or nil
	elseif s.kind == "zone" and not (list and #list > 0) then
		-- A continent or a battleground: no flight master, inn or middle to go to.
		note = L["Zones have no sources. Search for what is in them."]
	elseif blocked then
		note = STATUS_NOTE[status]
	elseif curated then
		local cg = guideHeader(curated)
		primary = L["Open guide"]
		note = format(L["A guide covers this: %s."], cg and cg.title or curated)
	elseif not (Lk and Lk.Guide) then
		note = L["Guides from the Codex need the Lookup module."]
	elseif Lk.IsMount and Lk.IsMount(entity) then
		-- Only a curated guide leads to a mount (Lookup.Guide): its sources
		-- above, with their cost and requirements, and each row's Guide.
		note = MOUNT_NOTE
	elseif best then
		primary = L["Guide me"]
		if s.kind == "zone" then
			note = format(L["Builds a guide to %s, the quickest of these to reach, and opens it in a new tab."], list[best].label or "?")
		else
			note = format(L["Builds a guide to %s, the best source for you, and opens it in a new tab."], list[best].label or "?")
		end
	elseif list and #list > 0 then
		primary, enabled = L["Guide me"], false
		note = L["No source is open to this character yet. Pick one above to be guided anyway."]
	else
		note = L["The Codex knows no source for this."]
	end
	-- A dungeon also opens in the Dungeons section (its quests and bosses):
	-- beside the guide to its entrance, or alone without one.
	if dungeon then
		local open = function() LK.OpenDungeon(s.id) end
		if primary then
			secondary = L["Open dungeon"]
			d.Secondary.psAction = open
		else
			primary, enabled = L["Open dungeon"], nil
			d.psPrimaryAction = open
			if not LK.message then note = L["Its quests and bosses are under Dungeons."] end
		end
	end
	if LK.message then note = nil end
	d.Note:SetText(LK.message or note or "")
	W.Color(d.Note, LK.message and "warning" or (blocked and "textMuted" or "textDim"))
	d.Note:SetShown((LK.message or note) ~= nil)
	if primary then
		setButton(d.Primary, primary, enabled)
		d.Primary:Show()
		if secondary then
			d.Secondary:Show()
			d.Secondary.psFixedWidth = nil
			W.SetButtonText(d.Secondary, secondary)
			setButtonWidth(d.Primary, INNER - d.Secondary:GetWidth() - 8)
		else
			d.Secondary:Hide()
			setButtonWidth(d.Primary, INNER)
		end
		d.Primary.psTip = s.kind ~= "guide" and not itemDetails.outside and L["Enter does this too."] or nil
	else
		d.Primary:Hide()
		d.Secondary:Hide()
	end
	local noteH = d.Note:IsShown() and (d.Note:GetStringHeight() + 12) or 0
	local bottom = DPAD + (primary and (32 + 12) or 0) + noteH + 4

	-- Sources.
	local rowsShown = {}
	if item or (list and (s.kind ~= "zone" or #list > 0)) then
		list = list or itemDetails.Empty
		local child = d.Scroll.Child
		local cw = INNER + 8
		child:SetWidth(cw)
		local cy = 0
		if item then
			d.Head:Hide()
			cy = itemDetails.Paint(d, item, quality, #list, itemDetails.Tooltip(d.Well.psItem, item.reqLevel))
		else
			itemDetails.HideFacts(d)
			d.Head.Text:SetText(headText(s.kind))
			d.Head.Count:SetText(#list > 0 and tostring(#list) or "")
			d.Head:ClearAllPoints()
			d.Head:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD - TEXT_X, -y)
			d.Head:Show()
			y = y + FOLDER_H + 6
		end
		d.Scroll:ClearAllPoints()
		d.Scroll:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD - 8, -y)
		d.Scroll:SetPoint("BOTTOMRIGHT", d, "BOTTOMRIGHT", -DPAD + 10, bottom)
		d.Scroll:Show()
		for i, row in ipairs(list) do
			local r = sourceRow(i)
			local on = sourceSel == i
			local open = row.available ~= false
			r.psIndex = i
			r.Selected:SetShown(on)
			r.Bar:SetShown(on)
			setGlyph(r.Icon, SOURCE_ICON[row.type] or "icon-goto", on and "accent" or (open and "textDim" or "textMuted"))
			r.Label:SetText(row.label or "?")
			if not open then
				W.Color(r.Label, "textDim")
			elseif row.type == "quest" then
				W.Color(r.Label, "quest")
			elseif row.type == "craft" or row.type == "world" or row.type == "pvp" then
				W.Color(r.Label, "text")
			else
				W.Color(r.Label, "npc")
			end
			r.Travel:SetText(LK.Travel(row.travel) or "")
			r.Travel.psTip = nil
			r.Detail:SetText(row.detail or "")
			W.Color(r.Detail, open and "textDim" or "textMuted")
			local facts = sourceFacts(row)
			local why = not open and (row.whyText or L["Not open to this character"]) or nil
			r.Facts:SetText(facts or "")
			r.Facts:SetShown(facts ~= nil)
			r.Why:SetText(why or "")
			-- Gone for good is a fact, not something to fix: muted.
			W.Color(r.Why, (blocked or row.why == "retired") and "textMuted" or "warning")
			r.Why:SetShown(why ~= nil)
			r.Why:ClearAllPoints()
			r.Why:SetPoint("TOPLEFT", r, "TOPLEFT", 30, facts and -59 or -43)
			local guideBtn = on and row.guideable and not blocked and true or false
			r.Guide:SetShown(guideBtn)
			local textW = cw - 30 - 10
			local detailW = guideBtn and (textW - r.Guide:GetWidth() - 8) or textW
			r.Label:SetWidth(max(60, min(textW - r.Travel:GetStringWidth() - 12, floor(r.Label:GetStringWidth() + 1))))
			r.Detail:SetWidth(max(60, min(detailW, floor(r.Detail:GetStringWidth() + 1))))
			r.Facts:SetWidth(max(60, min(detailW, floor(r.Facts:GetStringWidth() + 1))))
			r.Why:SetWidth(max(60, min(detailW, floor(r.Why:GetStringWidth() + 1))))
			local lines = 2 + (facts and 1 or 0) + (why and 1 or 0)
			local h = 27 + (lines - 2) * 16 + 11 + 9
			if guideBtn then h = max(h, 27 + 24 + 8) end
			r:SetHeight(h)
			r:SetWidth(cw)
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", child, "TOPLEFT", 0, -cy)
			local tip = {}
			if row.zone or row.map then tip[#tip + 1] = (row.zone or UI.MapName(row.map) or "") .. ((row.x and row.y) and format("  %.1f, %.1f", row.x, row.y) or "") end
			if row.travel then tip[#tip + 1] = format(L["About %s from here"], LK.Travel(row.travel)) end
			tip[#tip + 1] = (row.guideable and not blocked) and L["Select it, then Guide; or double-click."] or L["No guide can lead here."]
			r.psTipTitle = row.label
			r.psTip = table.concat(tip, "\n")
			r:Show()
			cy = cy + h + 2
			rowsShown[i] = { label = row.label, detail = row.detail, travel = r.Travel:GetText(), facts = facts, why = why, available = open, guide = guideBtn }
		end
		for i = #list + 1, #d.Rows do d.Rows[i]:Hide() end
		if #list == 0 then
			d.NoSource:ClearAllPoints()
			d.NoSource:SetPoint("TOPLEFT", child, "TOPLEFT", enhanced and 8 or 0, -(cy + 4))
			d.NoSource:SetText(L["No source is known for this yet."])
			d.NoSource:Show()
			cy = cy + 30
		else
			d.NoSource:Hide()
		end
		-- The chain, under the sources (#2554).
		local chainShown
		if chain then
			chainShown = { step = chainStepText(chain), quests = {}, branches = {} }
			cy = cy + 10
			d.ChainHead.Text:SetText(L["Chain"])
			d.ChainHead.Count:SetText(chainStepText(chain))
			d.ChainHead:SetWidth(cw + TEXT_X * 2 - 16)
			d.ChainHead:ClearAllPoints()
			d.ChainHead:SetPoint("TOPLEFT", child, "TOPLEFT", 8 - TEXT_X, -cy)
			d.ChainHead:Show()
			cy = cy + FOLDER_H + 4
			for i, e in ipairs(chain.quests) do
				local r = chainRow(i)
				local here = e.id == s.id
				local g = CHAIN_GLYPH[e.state] or CHAIN_GLYPH.later
				setGlyph(r.Icon, e.skipped and "skip" or g[1], e.skipped and "warning" or g[2])
				r.Label:SetText(e.title or (L["Quest"] .. " " .. e.id))
				W.Color(r.Label, here and "accent" or (e.state == "done" and "textDim" or "quest"))
				local st = chainStateText(e)
				r.State:SetText(st)
				W.Color(r.State, e.skipped and "warning" or "textDim")
				r.Label:SetWidth(cw - 30 - 10)
				r.State:SetWidth(cw - 30 - 10)
				r.psQuest = not here and e.id or nil
				r.psTip = not here and L["Click to open its page."] or nil
				r:SetWidth(cw)
				r:ClearAllPoints()
				r:SetPoint("TOPLEFT", child, "TOPLEFT", 0, -cy)
				r:Show()
				cy = cy + CHAIN_ROW_H
				chainShown.quests[i] = { id = e.id, title = e.title, state = st, here = here or nil }
			end
			for i = #chain.quests + 1, #d.ChainRows do d.ChainRows[i]:Hide() end
			if chain.branches then
				local titles = {}
				for i, b in ipairs(chain.branches) do
					titles[i] = b.title or (L["Quest"] .. " " .. b.id)
					chainShown.branches[i] = titles[i]
				end
				d.ChainBranches:SetText(format(L["Then any of: %s"], table.concat(titles, ", ")))
				d.ChainBranches:SetWidth(cw - 30 - 10)
				d.ChainBranches:ClearAllPoints()
				d.ChainBranches:SetPoint("TOPLEFT", child, "TOPLEFT", 30, -(cy + 4))
				d.ChainBranches:Show()
				cy = cy + d.ChainBranches:GetStringHeight() + 10
			else
				d.ChainBranches:Hide()
			end
		else
			d.ChainHead:Hide()
			d.ChainBranches:Hide()
			for _, r in ipairs(d.ChainRows) do r:Hide() end
		end
		LK.chainShown = chainShown
		W.SetScrollContent(d.Scroll, cy + 4, shell:GetHeight() - SH.top - y - bottom)
	else
		itemDetails.HideFacts(d)
		d.Head:Hide()
		d.Scroll:Hide()
		LK.chainShown = nil
	end
	LK.detail = {
		kind = s.kind, id = s.id, title = title, facts = shown, sources = rowsShown, curated = curated, status = status,
		primary = primary and d.Primary.Label:GetText() or nil, note = d.Note:GetText(), art = d.psArt,
		chain = LK.chainShown,
	}
	if primary then LK.detail.enabled = d.Primary:IsEnabled() end
end

---------------------------------------------------------------------------
-- Results pane: the current search's results by kind, or the recent
-- lookups; only the rows in view are drawn
---------------------------------------------------------------------------

local function resultClick(self)
	if self.psResult then
		LK.Select(self.psResult.kind, self.psResult.id, self.psResult)
	elseif self.psAct then
		self.psAct()
	end
end

local function resultDouble(self)
	if not self.psResult then return end
	LK.Select(self.psResult.kind, self.psResult.id, self.psResult)
	LK.Activate()
end

local function resultRow(i)
	local r = rowPool[i]
	if r then return r end
	r = makeRow(results.Child)
	r:SetScript("OnClick", resultClick)
	r:SetScript("OnDoubleClick", resultDouble)
	rowPool[i] = r
	return r
end

local function folderRow(i)
	local f = folderPool[i]
	if f then return f end
	f = makeFolder(results.Child)
	folderPool[i] = f
	return f
end

local function selectFirst(reset, selectRow)
	if sel and not reset then
		for _, res in ipairs(visible) do
			if res.kind == sel.kind and res.id == sel.id then return end
		end
	end
	selectRow = selectRow or LK.Select
	if visible[1] then
		selectRow(visible[1].kind, visible[1].id, visible[1], true)
	elseif sel then
		-- Nothing listed: nothing for Enter to act on.
		selectRow()
	end
end

-- Whenever the list may have changed: the selection stays on a row the list
-- shows, since Enter acts on it. A search or a kind takes its first row; the
-- empty Everything list (recent lookups) picks nothing for the player.
local function reconcile(reset)
	if itemDetails.direct then return end
	if query ~= "" or kind ~= "all" then return selectFirst(reset) end
	if not sel then return end
	for _, res in ipairs(visible) do
		if res.kind == sel.kind and res.id == sel.id then return end
	end
	LK.Select()
end

local function clearDirectSelection()
	if not itemDetails.direct then return end
	itemDetails.direct, itemDetails.outside = nil, nil
	return true
end

local function reconcileDirectSelection()
	if not clearDirectSelection() then return end
	local direct = sel
	reconcile()
	if sel == direct then LK.Render() end
end

-- Bumped when what a search finds may have changed (the Codex or the
-- guides loaded).
LK.gen = 0
local function stale() LK.gen = LK.gen + 1 end

-- ItemClass and class-scoped ItemSubclass labels from the Codex taxonomy.
local itemCategories = {}
function itemCategories.LoadLabels()
	itemCategories.classLabels = {
		[0] = L["Consumable"], L["Container"], L["Weapon"], L["Gem"], L["Armor"], L["Reagent"],
		L["Projectile"], L["Trade Goods"], L["Item Enhancement"], L["Recipe"], L["Money"], L["Quiver"],
		L["Quest"], L["Key"], L["Permanent"], L["Miscellaneous"], L["Glyph"], L["Battle Pets"],
		L["WoW Token"], L["Profession"], L["Housing"],
	}
	itemCategories.subclassLabels = {
		[0] = { [0] = L["Explosives and Devices"], L["Potion"], L["Elixir"], L["Flask"], L["Scroll"],
			L["Food & Drink"], L["Item Enhancement"], L["Bandage"], L["Other"],
			[14] = L["Device"], [15] = L["Temporary Item Enhancement"] },
		[1] = { [0] = L["Bag"], L["Soul Bag"], L["Herb Bag"], L["Enchanting Bag"],
			[6] = L["Mining Bag"], [7] = L["Leatherworking Bag"], [11] = L["Reagent Bag"] },
		[2] = { [0] = L["Axe"], L["Two-Handed Axe"], L["Bow"], L["Gun"], L["Mace"], L["Two-Handed Mace"],
			L["Polearm"], L["Sword"], L["Two-Handed Sword"], [10] = L["Staff"], [11] = L["Bear Claws"],
			[13] = L["Fist Weapon"], [14] = L["Miscellaneous"], [15] = L["Dagger"], [16] = L["Thrown"],
			[17] = L["Spear"], [18] = L["Crossbow"], [19] = L["Wand"], [20] = L["Fishing Pole"] },
		[4] = { [0] = L["Miscellaneous"], L["Cloth"], L["Leather"], L["Mail"], L["Plate"], L["Cosmetic"],
			L["Shield"], L["Libram"], L["Idol"], L["Totem"] },
		[5] = { [0] = L["Reagent"] },
		[6] = { [2] = L["Arrow"], [3] = L["Bullet"] },
		[7] = { [0] = L["Trade Goods"], L["Parts"], L["Explosives"], [5] = L["Cloth"], [6] = L["Leather"],
			[7] = L["Metal & Stone"], [8] = L["Cooking"], [9] = L["Herb"], [10] = L["Elemental"],
			[11] = L["Other"], [12] = L["Enchanting"] },
		[9] = { [0] = L["Book"], L["Leatherworking"], L["Tailoring"], L["Engineering"], L["Blacksmithing"],
			L["Cooking"], L["Alchemy"], L["First Aid"], L["Enchanting"], L["Fishing"] },
		[11] = { [2] = L["Quiver"], [3] = L["Ammo Pouch"] },
		[12] = { [0] = L["Quest"] },
		[13] = { [0] = L["Key"] },
		[15] = { [0] = L["Junk"], L["Reagent"], L["Companion Pets"], L["Holiday"], L["Other"], L["Mount"] },
		[18] = { [0] = L["WoW Token"] },
	}
end

function itemCategories.ClassLabel(class)
	if not itemCategories.classLabels then itemCategories.LoadLabels() end
	return itemCategories.classLabels[class] or format(L["Category %d"], class)
end

function itemCategories.SubclassLabel(class, subclass)
	return itemCategories.subclassLabels[class] and itemCategories.subclassLabels[class][subclass] or format(L["Type %d"], subclass)
end

do
	itemDetails.Empty = {}
	local SEP = " \194\183 "
	local PAIR_GAP, LINE_GAP = 12, 4

	local function coloredText(text, r, g, b)
		if not r then return text end
		return format("|cff%02x%02x%02x%s|r", floor(r * 255 + 0.5), floor(g * 255 + 0.5), floor(b * 255 + 0.5), text)
	end

	local function restrictedClasses(S, f)
		local names, count = nil, 0
		for _, token in ipairs(itemDetails.ClassTokens) do
			local eligible = S.ClassEligible(token, f.allowClass, f.itemClass, f.itemSubclass, f.slot)
			if eligible == nil then return end
			if eligible then
				local name = coloredText(UI.ClassName(token), Theme.ClassColor(token))
				names = names and format(L["%s, %s"], names, name) or name
				count = count + 1
			end
		end
		if count < #itemDetails.ClassTokens then return names or L["None of these classes"] end
	end

	local function readItem(s, loaded, entity)
		local C, S = ns.Codex, ns.Search
		local f = loaded and C and C.HasFilters and C.HasFilters() and C.FilterFacts(s.kind, s.id)
		local levels = {}
		if f and f.itemLevel then levels[#levels + 1] = format(L["Item level %d"], f.itemLevel) end
		local req = f and f.reqLevel
		if not f and entity then req = entity.reqLevel end
		if req then levels[#levels + 1] = req == 0 and L["No level required"] or format(L["Requires level %d"], req) end
		local classes = f and restrictedClasses(S, f)
		return {
			levels = #levels > 0 and table.concat(levels, SEP) or nil,
			reqLevel = req,
			classes = classes and format(L["Classes: %s"], classes),
		}
	end

	function itemDetails.Read(s, loaded, entity)
		if not (KIND[s.kind] and KIND[s.kind].item) then return end
		-- Kept once the Codex is loaded: before that, the facts fill in later.
		local item = detailCache.item or readItem(s, loaded, entity)
		if loaded then detailCache.item = item end
		return item
	end

	local function tooltipText(text)
		if type(text) == "string" and not secret(text) then return text end
	end

	local function tooltipColor(color)
		if type(color) ~= "table" or secret(color) then return end
		local r, g, b = color.r, color.g, color.b
		if type(r) == "number" and type(g) == "number" and type(b) == "number" and not (secret(r) or secret(g) or secret(b)) then
			return { r, g, b }
		end
	end

	local function sellPriceText(id, price)
		if type(price) ~= "number" or secret(price) then
			if not (C_Item and C_Item.GetItemInfo) then return end
			local ok, _, _, _, _, _, _, _, _, _, _, copper = pcall(C_Item.GetItemInfo, id)
			if not ok or type(copper) ~= "number" or secret(copper) then return end
			price = copper
		end
		if price > 0 and SELL_PRICE then
			local coins = GetCoinTextureString and GetCoinTextureString(price) or (price .. "c")
			return SELL_PRICE .. " " .. coins
		end
	end

	local function startsWith(text, prefix)
		return prefix and text:sub(1, #prefix) == prefix
	end

	function itemDetails.Tooltip(id, reqLevel)
		local lines = id and ns.Compat.ItemTooltipLines(id)
		if not lines then return end
		local types = Enum and Enum.TooltipDataLineType
		local sellType = types and types.SellPrice
		local levelPattern
		if ITEM_MIN_LEVEL and reqLevel and reqLevel > 1 then
			levelPattern = "^" .. ITEM_MIN_LEVEL:gsub("([%^%$%(%)%.%[%]%*%+%-%?%%])", "%%%1")
				:gsub("%%%%%d+%%%$d", "%%d+"):gsub("%%%%d", "%%d+") .. "$"
		end
		local rows = {}
		local effectAt, sellAt, appearanceAt, nativeSell
		for i = 2, #lines do -- The item's name is already in the banner.
			local line = lines[i]
			local left, right = tooltipText(line.leftText), tooltipText(line.rightText)
			local kind = line.type
			if sellType and not secret(kind) and kind == sellType then
				nativeSell = true
				left, right = sellPriceText(id, line.price), nil
				if left then sellAt = #rows + 1 end
			elseif left then
				local plain = left:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
				if levelPattern and plain:match(levelPattern) then levelPattern = nil end
				if not effectAt and (startsWith(plain, ITEM_SPELL_TRIGGER_ONEQUIP) or startsWith(plain, ITEM_SPELL_TRIGGER_ONUSE)
					or startsWith(plain, ITEM_SPELL_TRIGGER_ONPROC)) then
					effectAt = #rows + 1
				end
				if not appearanceAt and plain == TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN then appearanceAt = #rows + 1 end
			end
			if left or right then
				rows[#rows + 1] = { left = left, right = right, leftColor = tooltipColor(line.leftColor), rightColor = tooltipColor(line.rightColor) }
			end
		end
		if not nativeSell then
			local sell = sellPriceText(id)
			if sell then
				sellAt = appearanceAt or #rows + 1
				table.insert(rows, sellAt, { left = sell })
				if effectAt and effectAt >= sellAt then effectAt = effectAt + 1 end
			end
		end
		if levelPattern then
			table.insert(rows, effectAt or sellAt or appearanceAt or #rows + 1, { left = format(ITEM_MIN_LEVEL, reqLevel) })
		end
		return rows
	end

	local function summaryText(item, quality)
		local rarity = itemDetails.RarityName(quality)
		if not rarity then return item.levels end
		rarity = coloredText(rarity, qualityColor(quality))
		return item.levels and (rarity .. SEP .. item.levels) or rarity
	end

	local function detailLine(panel, width, color)
		local line = W.Text(panel, "note", color)
		line:SetWidth(width)
		line:SetWordWrap(true)
		return line
	end

	local function paintLine(line, text, x, y)
		line:SetShown(text ~= nil)
		if not text then return 0 end
		line:SetText(text)
		line:SetPoint("TOPLEFT", line:GetParent(), "TOPLEFT", x, -y)
		return line:GetStringHeight() + LINE_GAP
	end

	function itemDetails.Outside(d, outside, y)
		local line = rawget(d, "Outside")
		if not outside then
			if line then line:Hide() end
			return y
		end
		if not line then
			line = W.Text(d, "note", "textMuted")
			line:SetWidth(INNER)
			line:SetWordWrap(true)
			line:SetText(L["This item is outside the current filters."])
			d.Outside = line
		end
		line:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -y)
		line:Show()
		return y + line:GetStringHeight() + FACT_GAP
	end

	function itemDetails.HideFacts(d)
		local panel = rawget(d, "ItemFactsPanel")
		if panel then panel:Hide() end
	end

	function itemDetails.Hide(d)
		itemDetails.HideFacts(d)
		itemDetails.Outside(d, false)
	end

	local function paintTooltip(d, rows, y)
		for i, row in ipairs(rows) do
			local pair = d.TooltipRows[i]
			if not pair then
				pair = { Left = detailLine(d.ItemFactsPanel, INNER), Right = detailLine(d.ItemFactsPanel, INNER) }
				pair.Right:SetJustifyH("RIGHT")
				d.TooltipRows[i] = pair
			end
			local leftW, rightW = INNER, INNER
			if row.right then
				pair.Right:SetText(row.right)
				local room = row.left and (INNER - PAIR_GAP - 1) or INNER
				rightW = max(1, min(room, math.ceil(pair.Right:GetUnboundedStringWidth())))
				leftW = INNER - rightW - PAIR_GAP
			end
			pair.Left:SetWidth(row.left and leftW or INNER)
			pair.Right:SetWidth(rightW)
			W.Color(pair.Left, row.leftColor or "text")
			W.Color(pair.Right, row.rightColor or "text")
			local leftH = paintLine(pair.Left, row.left, 0, y)
			local rightH = paintLine(pair.Right, row.right, INNER - rightW, y)
			y = y + max(leftH, rightH)
		end
		for i = #rows + 1, #d.TooltipRows do
			d.TooltipRows[i].Left:Hide()
			d.TooltipRows[i].Right:Hide()
		end
		return y
	end

	function itemDetails.Paint(d, item, quality, sourceCount, tooltip)
		local panel = rawget(d, "ItemFactsPanel")
		if not panel then
			panel = CreateFrame("Frame", nil, d.Scroll.Child)
			panel:SetPoint("TOPLEFT", d.Scroll.Child, "TOPLEFT", 8, 0)
			panel:SetWidth(INNER)
			d.ItemFactsPanel, d.TooltipRows = panel, {}
			d.ItemSummary = detailLine(panel, INNER, "textDim")
			d.ItemClasses = detailLine(panel, INNER)
			d.ItemHead = makeFolder(panel)
			d.ItemHead:SetWidth(INNER + TEXT_X * 2)
			d.ItemHead.Text:SetText(L["Where to get it"])
		end
		local y = paintLine(d.ItemSummary, summaryText(item, quality), 0, 0)
		y = paintTooltip(d, tooltip or itemDetails.Empty, y)
		y = y + paintLine(d.ItemClasses, item.classes, 0, y)
		d.ItemHead.Count:SetText(sourceCount > 0 and tostring(sourceCount) or "")
		d.ItemHead:SetPoint("TOPLEFT", panel, "TOPLEFT", -TEXT_X, -y)
		y = y + FOLDER_H + 6
		panel:SetHeight(y)
		panel:Show()
		return y
	end
end

function itemCategories.SortOrder(a, b)
	if a.sortLabel ~= b.sortLabel then return a.sortLabel < b.sortLabel end
	return (a.subclass or a.class) < (b.subclass or b.class)
end

function itemCategories.Tree()
	local C = ns.Codex
	if not (C and C.FilterColumn and C.DecodeFilter and C.FilterCategory) then return end
	local blob, count = C.FilterColumn("item")
	if not blob or count == 0 then return end
	if itemCategories.column == blob then return itemCategories.tree end
	itemCategories.column, itemCategories.tree = blob, nil
	local classes, byClass, byKey, seen = {}, {}, {}, {}
	local sortLabel = ns.Search.Fold or string.lower
	-- The directory covers all five item-backed kinds. Read only the packed
	-- searchable Items column to learn which of its entries belong here.
	for i = 1, count do
		local _, _, _, _, id = C.DecodeFilter(blob, i)
		if id and not seen[id] then
			seen[id] = true
			local class, subclass = C.FilterCategory(id)
			if class then
				local parent = byClass[class]
				if not parent then
					local label = itemCategories.ClassLabel(class)
					parent = { key = "item:" .. class, parent = "item", class = class, label = label,
						sortLabel = sortLabel(label), children = {} }
					byClass[class], byKey[parent.key] = parent, parent
					classes[#classes + 1] = parent
				end
				if subclass then
					local label = itemCategories.SubclassLabel(class, subclass)
					local node = { key = parent.key .. ":" .. subclass, parent = parent.key, id = id,
						class = class, subclass = subclass, label = label, sortLabel = sortLabel(label) }
					byKey[node.key] = node
					parent.children[#parent.children + 1] = node
				end
			end
		end
	end
	if #classes == 0 then return end
	table.sort(classes, itemCategories.SortOrder)
	for _, node in ipairs(classes) do table.sort(node.children, itemCategories.SortOrder) end
	itemCategories.tree = { classes = classes, byKey = byKey }
	return itemCategories.tree
end

-- The current list, built once per query and kind (the hub asks for the
-- sidebar's counts and the section's list in one render): the counts with a
-- few results per kind for a search, or totals for browsing, and under one
-- kind its first page. Search.Subtitle fills subtitles for drawn rows only.
local cache = {}
local function itemCapable()
	return kind == "all" or KIND[kind] and KIND[kind].item
end

local function mostAvailable()
	local C = ns.Codex
	return C and C.HasFilters and C.HasFilters() and C.StatGeneration and C.StatGeneration() ~= nil
end

local function effectiveOrder()
	if order == "most" and gearKind(kind) and mostAvailable() and not lookupOff() then return order end
	return query == "" and "az" or baseOrder
end

local function listOptions(saved)
	return {
		subtitles = false,
		ids = true,
		categoryTotals = true,
		filters = LK.SearchFilters(saved, category, kind),
		hideRetired = ns.Get("lookup.hideRetired"),
		hideNoSource = ns.Get("lookup.hideNoSource"),
		order = effectiveOrder(), baseOrder = baseOrder, sortStat = sortStat,
	}
end

local function current()
	local savedState = savedItemFilterState()
	if cache.query == query and cache.kind == kind and cache.category == category and cache.gen == LK.gen
		and cache.savedState == savedState
		and (cache.reason ~= "combat" or ns.Compat.InCombat()) then return cache end
	local saved = normalizeItemFilters(savedState)
	local opts = listOptions(saved)
	-- Slot and Stat hold only in gear views (Items, Everything). With either
	-- set, the item-backed kinds across that line are counted once more with
	-- the filters their own view uses, so each sidebar count is the total its
	-- row opens. Everything's total and the Items tree count as gear views.
	local gear, otherOpts, otherCounts, otherKinds = gearKind(kind), nil, nil, nil
	if saved.slot or saved.stat then
		otherOpts, otherCounts, otherKinds = {}, {}, {}
		for key, value in pairs(opts) do otherOpts[key] = value end
		otherOpts.filters = LK.SearchFilters(saved, category, gear and "mount" or "item")
		for _, k in ipairs(kinds()) do
			local spec = KIND[k.key]
			if spec and spec.item and gearKind(k.key) ~= gear then otherKinds[k.key] = true end
		end
	end
	local counts, before, list = {}, {}, {}
	local filterData, classDormant, categoryTotals, syntaxError
	-- gearSide: the info was counted with Slot and Stat applied.
	local function mergeInfo(info, gearSide)
		if not info then return end
		filterData = filterData or info.filtersAvailable
		classDormant = classDormant or info.classFilterDormant
		if gearSide or not otherOpts then categoryTotals = info.categoryTotals or categoryTotals end
		for k, n in pairs(info.preFilterCounts or {}) do before[k] = n end
	end
	if query ~= "" then
		if kind == "all" then
			opts.perKind, opts.limit = GROUP_MAX, GROUP_MAX * #kinds()
		else
			opts.resultKind, opts.limit = kind, PAGE
		end
		local info
		list, counts, info, syntaxError = search(query, nil, opts)
		mergeInfo(info, gear)
		if otherOpts and not syntaxError then
			-- One counting pass for the other side. Outside gear views it
			-- covers every item-backed kind: Everything's total needs them all.
			local only = {}
			for _, k in ipairs(kinds()) do
				local spec = KIND[k.key]
				if spec and spec.item and (not gear or otherKinds[k.key]) then only[k.key] = true end
			end
			otherOpts.limit = 0
			local _, other, otherInfo = search(query, only, otherOpts)
			mergeInfo(otherInfo, not gear)
			for k in pairs(only) do otherCounts[k] = other[k] or 0 end
		end
	else
		local S = ns.Search
		if kind ~= "all" and S and S.Browse then
			opts.limit = PAGE
			local info
			list, counts[kind], info = S.Browse(kind, opts)
			mergeInfo(info, gear)
		end
		if S and S.BrowseCount then
			for _, k in ipairs(kinds()) do
				local info
				if otherKinds and otherKinds[k.key] then
					otherCounts[k.key], info = S.BrowseCount(k.key, otherOpts)
					mergeInfo(info, not gear)
				elseif counts[k.key] == nil then
					counts[k.key], info = S.BrowseCount(k.key, opts)
					mergeInfo(info, gear)
				end
			end
		end
	end
	-- A search or browse can load the Codex or learn why it cannot load.
	local loaded, reason = status()
	if loaded and order == "most" and not (filterData and mostAvailable()) then
		order, sortStat = baseOrder, nil
	end
	local waiting = reason == "loading" or reason == "notloaded" or reason == "combat"
	if not loaded and query == "" and kind ~= "guide" then counts[kind] = nil end
	-- The sidebar's counts: each kind with the filters of its own view.
	local navCounts = {}
	for k, n in pairs(counts) do navCounts[k] = n end
	if otherKinds then
		for k in pairs(otherKinds) do navCounts[k] = otherCounts[k] end
	end
	-- Search's pre-filter counts include the visibility switches. For a kind
	-- they might have emptied, also ask for its candidates with both off.
	if loaded and not syntaxError and (opts.hideRetired or opts.hideNoSource) then
		local missing = {}
		for _, k in ipairs(kinds()) do
			local spec = KIND[k.key]
			if spec and spec.item and (before[k.key] or navCounts[k.key] or 0) == 0 then missing[k.key] = true end
		end
		if next(missing) then
			opts.hideRetired, opts.hideNoSource, opts.categoryTotals = false, false, false
			if query ~= "" then
				opts.limit, opts.perKind, opts.resultKind = 0, nil, nil
				local _, totals, info = search(query, missing, opts)
				for k in pairs(missing) do before[k] = info and info.preFilterCounts[k] or totals[k] end
			elseif ns.Search and ns.Search.BrowseCount then
				for k in pairs(missing) do
					local n, info = ns.Search.BrowseCount(k, opts)
					before[k] = info and info.preFilterCounts[k] or n
				end
			end
		end
	end
	if query == "" and kind ~= "all" and kind ~= "guide" and not (loaded or waiting) then
		kind, category, list = "all", nil, {}
		-- Nothing can look a Codex entry up now. Clear it here, not through
		-- LK.Select: this runs inside a render.
		if sel and sel.kind ~= "guide" then setSelection() end
	end
	local tree = loaded and filterData and itemCategories.Tree()
	if not tree then category = nil end
	local total = 0
	if query ~= "" then
		-- Everything's total counts with Slot and Stat, as Everything lists.
		local gearCounts = counts
		if otherCounts and not gear then
			gearCounts = {}
			for k, n in pairs(counts) do gearCounts[k] = n end
			for k, n in pairs(otherCounts) do gearCounts[k] = n > 0 and n or nil end
		end
		for _, n in pairs(gearCounts) do total = total + n end
		if categoryTotals then total = total - (gearCounts.item or 0) + categoryTotals.root end
	end
	cache = { query = query, kind = kind, category = category, gen = LK.gen, list = list, counts = counts,
		navCounts = navCounts, total = total, tree = tree, categoryTotals = categoryTotals, loaded = loaded, reason = reason, waiting = waiting,
		before = before, filterData = loaded and filterData, classDormant = classDormant, saved = saved, savedState = savedState,
		syntaxError = syntaxError }
	return cache
end

-- The next page of the shown kind.
function LK.More()
	local c = current()
	if kind == "all" then return end
	local opts = listOptions(c.saved)
	opts.limit, opts.offset = PAGE, #c.list
	local more
	if query == "" then
		local S = ns.Search
		if not (S and S.Browse) then return end
		more = S.Browse(kind, opts)
	else
		more = search(query, { [kind] = true }, opts)
	end
	for _, res in ipairs(more) do c.list[#c.list + 1] = res end
	local direct = clearDirectSelection()
	LK.Render()
	if direct then reconcile() end
end

local activeNavRow

local function toggleCategory(key)
	openBranches[key] = not openBranches[key] or nil
	UI.Picker.RenderSectionNav()
end

local function appendCategories(items, nodes, depth, totals)
	local isClass = depth == 1
	for _, node in ipairs(nodes) do
		local count = totals and (isClass and totals.classes or totals.subclasses)[isClass and node.class or node.id]
		local parent = node.children and #node.children > 0
		local folded = not openBranches[node.key]
		items[#items + 1] = {
			key = node.key, label = node.label, count = count or 0, depth = depth, rowH = isClass and 32 or 28,
			folded = parent and folded, onToggle = parent and toggleCategory or nil,
		}
		if parent and not folded then appendCategories(items, node.children, 2, totals) end
	end
end

local function visibleNavKey(key, tree, rowsByKey)
	while key and not rowsByKey[key] do
		local node = tree.byKey[key]
		key = node and node.parent
	end
	return key
end

-- The kind counts describe their destinations. Items and its descendants
-- use the unscoped totals, while the result pane uses the selected scope.
function LK.Nav()
	local c = current()
	local tree, totals = c.tree, c.categoryTotals
	local items = { { key = "all", label = L["Everything"], icon = "search", count = query ~= "" and c.total or nil } }
	for _, k in ipairs(kinds()) do
		local n, show = c.navCounts[k.key], false
		if query ~= "" then
			n = n or 0
			show = n > 0 or (c.before[k.key] or 0) > 0 or k.key == kind
		elseif c.waiting then
			n, show = nil, true
		elseif c.loaded then
			show = (n or 0) > 0 or (c.before[k.key] or 0) > 0 or k.key == kind
		else
			show = k.key == "guide"
		end
		local itemRoot = k.key == "item" and tree
		if show or itemRoot then
			local row = { key = k.key, label = k.label, icon = KIND[k.key] and KIND[k.key].icon or k.icon or "search", count = n }
			items[#items + 1] = row
			if itemRoot then
				row.count = totals and totals.root or 0
				row.depth, row.rowH, row.folded, row.onToggle = 0, 36, not openBranches.item, toggleCategory
				if not row.folded then appendCategories(items, tree.classes, 1, totals) end
			end
		end
	end
	local rowsByKey = {}
	for _, row in ipairs(items) do rowsByKey[row.key] = row end
	local activeKey = kind
	if tree and category then activeKey = visibleNavKey(category.key, tree, rowsByKey) end
	activeNavRow = rowsByKey[activeKey]
	return items, activeKey
end

-- A drawn row's subtitle, asked for once.
local STAT_SUBTITLE = { [2] = L["Amount unknown"], [3] = L["No listed stat"], [4] = L["Unknown"] }
local function subtitleOf(res)
	if res.statBucket == 1 then return tostring(res.statAmount) end
	if res.statBucket then return STAT_SUBTITLE[res.statBucket] end
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

-- The list as laid out: { t = "folder"|"row"|"action", y, ... }, top down.
local entries = {}

local filtersUI = { drawerOpen = false, chromeHeight = 0 }
local resetListSelection
function filtersUI.ViewHeight()
	return max(1, shell:GetHeight() - SH.top - 8 - filtersUI.chromeHeight)
end

-- Draw the entries in view (and a row either side), from the pools.
local function paintVisible()
	if not (root and results) then return end
	local top = results:GetVerticalScroll() or 0
	local lo, hi = top - ROW_H * 2, top + filtersUI.ViewHeight() + ROW_H * 2
	local width = MID_W - ROW_X * 2
	local body = results.Child
	local nf, nr = 0, 0
	-- The entries run top down: find the first in reach (no entry is taller
	-- than a folder), then stop past the view, however many pages are open.
	local first, last = 1, #entries
	while first < last do
		local mid = floor((first + last) / 2)
		if entries[mid].y + FOLDER_H < lo then first = mid + 1 else last = mid end
	end
	for i = first, #entries do
		local e = entries[i]
		if e.y > hi then break end
		local h = e.t == "folder" and FOLDER_H or ROW_H
		if e.y + h >= lo then
			local f
			if e.t == "folder" then
				nf = nf + 1
				f = folderRow(nf)
				f.Text:SetText(e.text)
				f.Count:SetText(e.count or "")
				f:SetWidth(width)
			else
				nr = nr + 1
				f = resultRow(nr)
				if e.t == "row" then
					paintResult(f, e.res, subtitleOf(e.res), width, sel and sel.kind == e.res.kind and sel.id == e.res.id)
					f.psAct = nil
				else
					paintAction(f, e.text, e.glyph, width)
					f.psAct = e.act
				end
				f.psTip = e.tip
			end
			f:ClearAllPoints()
			f:SetPoint("TOPLEFT", body, "TOPLEFT", ROW_X, -e.y)
			f:Show()
		end
	end
	for i = nr + 1, #rowPool do rowPool[i]:Hide() end
	for i = nf + 1, #folderPool do folderPool[i]:Hide() end
	LK.painted = nr
end
LK.PaintVisible = paintVisible

-- Keep the selection in view (arrow keys).
local function reveal()
	if not sel then return end
	for _, e in ipairs(entries) do
		if e.t == "row" and e.res.kind == sel.kind and e.res.id == sel.id then
			local top, view = results:GetVerticalScroll() or 0, filtersUI.ViewHeight()
			if e.y < top then
				W.ScrollTo(results, e.y - 8)
			elseif e.y + ROW_H > top + view then
				W.ScrollTo(results, e.y + ROW_H - view + 8)
			end
			paintVisible()
			return
		end
	end
end

local ORDER_LABELS = { best = L["Best match"], az = L["A to Z"] }
local HISTORY_TIP = { L["Recent lookups show your history."] }
local VISIBILITY_CHOICES = {
	{ path = "lookup.hideRetired", text = L["Hide no longer obtainable"], desc = L["Hides items that can't be obtained any more."] },
	{ path = "lookup.hideNoSource", text = L["Hide no known source"], desc = L["Hides items with no known source."] },
}

local function mostLabel(code)
	return format(L["Most %s"], ns.Search.StatLabel(code))
end

local function fixedButtonText(button, text, lines)
	W.SetButtonText(button, text)
	local room = button:GetWidth() - (rawget(button, "Icon") and 31 or 12)
	local clipped = button.Label:GetUnboundedStringWidth() > room
	button.Label:SetWidth(clipped and room or 0)
	button.Label:SetWordWrap(false)
	button.psTip = (clipped or lines) and text or nil
	button.psTipLines = lines
end

local function showControls(c)
	local button, visibility = root.SearchOrder, root.Visibility
	local showOrder = query ~= "" or c.loaded and kind ~= "all" and itemCapable()
	button:GetParent():SetShown(showOrder)
	root.FilterBar:Show()
	local groups = filtersUI.Paint(c)
	local text = groups > 0 and format(L["Filters (%d)"], groups) or L["Filters"]
	local history = groups > 0 and query == "" and kind == "all" and HISTORY_TIP
	fixedButtonText(visibility, text, history or nil)
	visibility.Icon:SetTexture(Theme.Media(filtersUI.drawerOpen and "chevron-up" or "chevron-down"))
	if showOrder then button:GetParent():Refresh() end
end

local function directOutsideFilters(c, s)
	local retired, noSource = ns.Get("lookup.hideRetired"), ns.Get("lookup.hideNoSource")
	local filters = c.filterData and LK.SearchFilters(c.saved, category, kind)
	if not (retired or noSource or filters) then return false end
	local idQuery, only = "#" .. s.id, { [s.kind] = true }
	local _, counts = search(idQuery, only, { ids = true, limit = 0, filters = filters, hideRetired = retired, hideNoSource = noSource })
	if counts[s.kind] then return false end
	-- A detail-only record can be absent even with every filter off.
	_, counts = search(idQuery, only, { ids = true, limit = 0 })
	return counts[s.kind] ~= nil
end

function LK.Render()
	if not (root and root:IsVisible()) then return end
	local c = current()
	local list, counts, total, loaded, reason = c.list, c.counts, c.total, c.loaded, c.reason

	-- No tabs, so no tab row: the keys live in each row's tooltip. The row
	-- comes back only to say why the Codex is not there to search (not while
	-- it simply waits for the first search).
	local status = not loaded and reason ~= nil and reason ~= "notloaded" and reasonShort(reason) or nil
	shell.psKeepTabRow = status ~= nil
	W.ShellTabs(shell, nil)
	shell.psKeepTabRow = nil
	root.CodexLine:SetText(status or "")
	if status then
		W.Color(root.CodexLine, (reason == "combat" or reason == "loading") and "textMuted" or "warning")
	end

	-- The header: what the list holds.
	local title = kind == "all" and L["Lookup"] or kindLabel(kind)
	if category then
		if category.subclass then title = format(L["%s › %s"], title, c.tree.byKey[category.parent].label) end
		title = format(L["%s › %s"], title, category.label)
	end
	local subtitle
	if query == "" then
		local n = counts[kind]
		if n and effectiveOrder() == "most" then
			subtitle = n == 1 and L["1 result"] or format(L["%d results"], n)
		else
			subtitle = n and format(L["%d, from A to Z"], n)
				or L["Every guide, item, mount, NPC, quest and place, and where to get it."]
		end
	else
		local n = kind == "all" and total or (counts[kind] or #list)
		subtitle = n == 1 and format(L["1 result for %s"], LQ .. query .. RQ) or format(L["%d results for %s"], n, LQ .. query .. RQ)
	end
	showControls(c)
	W.ShellTitle(shell, title, subtitle)

	-- Lay the list out.
	entries, visible = {}, {}
	local groups = {}
	local y = 8
	local function folder(text, count)
		if #entries > 0 then y = y + 10 end
		entries[#entries + 1] = { t = "folder", y = y, text = text, count = count }
		y = y + FOLDER_H + 4
	end
	local function row(res)
		local tip
		if STATUS_TEXT[res.status] then
			tip = L["Shown for reference: nothing leads to it."]
		elseif res.kind == "guide" then
			tip = L["Double-click or press Enter to open it in a new tab."]
		else
			tip = L["Double-click or press Enter to be guided to it."]
		end
		entries[#entries + 1] = { t = "row", y = y, res = res, tip = tip }
		visible[#visible + 1] = res
		y = y + ROW_H
	end
	local function action(text, glyph, act, tip)
		entries[#entries + 1] = { t = "action", y = y, text = text, glyph = glyph, act = act, tip = tip }
		y = y + ROW_H
	end
	if query == "" and kind == "all" then
		local recent = LK.Recent()
		if #recent > 0 then
			folder(L["Recent lookups"], #recent)
			-- Copies: the saved entries stay as saved.
			for _, r in ipairs(recent) do row({ kind = r.kind, id = r.id, title = r.title, quality = r.quality, status = r.status }) end
		end
	else
		local byKind = {}
		for _, res in ipairs(list) do
			byKind[res.kind] = byKind[res.kind] or {}
			local b = byKind[res.kind]
			b[#b + 1] = res
		end
		for _, k in ipairs(kinds()) do
			local hits = byKind[k.key]
			if hits then
				local n = counts[k.key] or #hits
				folder(k.label, n)
				local cap = kind == "all" and GROUP_MAX or #hits
				for i = 1, min(cap, #hits) do row(hits[i]) end
				if kind == "all" and n > cap then
					local key = k.key
					action(format(L["Show all %d"], n), "chevron-right", function() LK.SetKind(key) end, format(L["Only %s"], k.label))
				elseif kind ~= "all" and n > #hits then
					action(format(L["Show more (%d more)"], n - #hits), "chevron-down", LK.More, format(L["The next %d"], min(PAGE, n - #hits)))
				end
				groups[#groups + 1] = { kind = k.key, count = n, shown = min(cap, #hits) }
			end
		end
	end
	if resetListSelection then
		resetListSelection = nil
		if query ~= "" or kind ~= "all" then selectFirst(true, setSelection) end
	end

	local empty
	if c.syntaxError == "id-syntax" then
		empty = L["Use # followed by an item ID."]
	elseif reason == "loading" and #list == 0 then
		empty = L["Loading the Codex\226\128\166"]
	elseif query == "" and kind == "all" then
		empty = loaded and L["Type a name in the search box: a mount you saw, an item you want, an NPC or a quest."]
			or L["Type a name in the search box to search the guides."]
	elseif #list == 0 then
		if query == "" and not loaded and kind ~= "guide" then
			empty = LK.ReasonText(reason)
		elseif query == "" then
			empty = L["Nothing to list here."]
		elseif loaded and query:match("^%s*#") then
			empty = L["No item with that ID here."]
		else
			empty = format(L["Nothing matches %s."], LQ .. query .. RQ)
			if reason == "off" then
				empty = empty .. " " .. L["Lookup is turned off in Settings > Discovery > Lookup, so items, mounts, NPCs and quests are not searched."]
			elseif not loaded then
				empty = empty .. " " .. L["Items, mounts, NPCs and quests are searched once the Codex loads."]
			end
		end
	end
	local body = results.Child
	if empty then
		root.Empty:SetText(empty)
		root.Empty:ClearAllPoints()
		root.Empty:SetPoint("TOPLEFT", body, "TOPLEFT", SH.pad, -(y + (#entries > 0 and 16 or 8)))
		root.Empty:Show()
		y = y + 16 + root.Empty:GetStringHeight() + 16
	else
		root.Empty:Hide()
	end
	-- The engraving only behind a list with nothing in it.
	root.Watermark:SetShown(#entries == 0)
	body:SetWidth(MID_W)
	W.SetScrollContent(results, y + 16, filtersUI.ViewHeight())
	paintVisible()
	if c.loaded and itemDetails.direct and itemDetails.outside == nil then itemDetails.outside = directOutsideFilters(c, sel) end
	renderDetails(loaded, reason)
	LK.shown = { query = query, kind = kind, groups = groups, rows = #visible, empty = empty,
		total = category and (counts.item or 0) or total }
end

---------------------------------------------------------------------------
-- Search, kinds, keys
---------------------------------------------------------------------------

-- The hub draws the sidebar (Nav) and this section together.
local function refresh()
	local P = UI.Picker
	if P and P.Render and P.Section and P.Section() == "Lookup" then P.Render() else LK.Render() end
end

local function cancelPending()
	if pending then
		pending:Cancel()
		pending = nil
	end
end

local function flushPending()
	if not pending then return end
	cancelPending()
	query = UI.Picker.Query()
	LK.message = nil
end

local function restartList()
	flushPending()
	clearDirectSelection()
	stale()
	if root and root:IsVisible() then
		resetListSelection = true
		W.ScrollTo(results, 0)
		refresh()
	end
end

function LK.Order() return order end

local function changeOrder(value, stat)
	local hadPending = pending ~= nil
	flushPending()
	if value ~= "most" then
		if query ~= "" then baseOrder = value end
		value, stat = baseOrder, nil
	end
	if value == order and stat == sortStat and not hadPending then return end
	order, sortStat = value, stat
	restartList()
end

function LK.SetOrder(value)
	changeOrder(value == "az" and "az" or "best")
end

local function setQuery(text)
	text = text or ""
	if text == query then return end
	clearDirectSelection()
	query = text
	LK.message = nil
	if not (root and root:IsVisible()) then return end
	W.ScrollTo(results, 0)
	refresh()
	reconcile(query == "")
end

-- The hub's search box, while this section is shown: each keystroke
-- restarts a short wait; the search runs when typing pauses.
local function onSearch(text)
	text = text or ""
	cancelPending()
	if text == "" or text == query then
		setQuery(text)
		return
	end
	pending = ns.NewTimer(DEBOUNCE, function()
		pending = nil
		setQuery(text)
	end)
end

-- Enter: search now if typing has not paused yet, then act.
local function onEnter()
	local P = UI.Picker
	if pending then
		cancelPending()
		setQuery(P and P.Query and P.Query() or query)
	end
	local outside = itemDetails.outside
	if clearDirectSelection() then
		local direct = sel
		reconcile()
		if outside and sel == direct then LK.Render() end
		if outside or sel ~= direct then return end
	end
	LK.Activate()
end

local function orderMenu(button)
	if not (button and button:IsVisible()) then return end
	if W.MenuShown(button) then return W.HideMenu() end
	local items, selected = {}, effectiveOrder()
	local function addChoice(value)
		items[#items + 1] = { text = ORDER_LABELS[value], checked = value == selected,
			onClick = function() if value ~= selected then LK.SetOrder(value) end end }
	end
	if query ~= "" then addChoice("best") end
	addChoice("az")
	if gearKind(kind) and current().filterData and mostAvailable() then
		local code = sortStat or LK.ItemFilters().stat
		if code then
			items[#items + 1] = { text = mostLabel(code), checked = selected == "most",
				onClick = function() changeOrder("most", code) end }
		end
		items[#items + 1] = { text = L["Choose a stat…"], onClick = function()
			filtersUI.StatMenu(button, sortStat, function(stat)
				changeOrder(stat and "most" or baseOrder, stat)
			end)
		end }
	end
	filtersUI.ShowMenu(button, items, true)
end

function LK.Query() return query end

local function setKind(k, node, categoryCommit)
	clearDirectSelection()
	k = k or "all"
	local changed = kind ~= k
	categoryCommit = categoryCommit or category ~= nil
	if categoryCommit then flushPending() end
	if categoryCommit and not changed and node == category then stale() end
	if root and gearKind(kind) ~= gearKind(k) and W.MenuShown(root.SearchOrder) then W.HideMenu() end
	kind, category = k, node
	if root and root:IsVisible() then
		W.ScrollTo(results, 0)
		refresh()
		reconcile(categoryCommit or (changed and query == ""))
	end
end

function LK.SetKind(k) setKind(k) end

local function selectNav(key)
	if activeNavRow and activeNavRow.key == key and activeNavRow.onToggle then
		toggleCategory(key)
		return
	end
	local tree = current().tree
	local node = tree and tree.byKey[key]
	if node or (tree and key == "item") then setKind("item", node, true) else setKind(key) end
end

function LK.Kind() return kind end

function LK.Step(delta)
	if #visible == 0 then
		if clearDirectSelection() then reconcile() end
		return
	end
	local at
	if sel then
		for i, res in ipairs(visible) do if res.kind == sel.kind and res.id == sel.id then at = i end end
	end
	at = at and min(#visible, max(1, at + delta)) or 1
	-- Walking the list opens no page for good: only a click or Enter does.
	LK.Select(visible[at].kind, visible[at].id, visible[at], true)
	reveal()
end

local function installFilterChrome()
	local CLASSES = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID" }
	itemDetails.ClassTokens = CLASSES
	local slotLabels, slotGroups
	local function loadSlots()
		if slotLabels then return end
		slotLabels = {
			[0] = L["Non-equippable"], L["Head"], L["Neck"], L["Shoulder"], L["Shirt"], L["Chest"],
			L["Waist"], L["Legs"], L["Feet"], L["Wrist"], L["Hands"], L["Finger"], L["Trinket"], L["One-hand"],
			L["Shield"], L["Ranged"], L["Back"], L["Two-hand"], L["Bag"], L["Tabard"], L["Robe"], L["Main hand"],
			L["Off-hand weapon"], L["Held in off-hand"], L["Ammo"], L["Thrown"], L["Ranged (right)"], L["Quiver slot"],
			L["Relic"], L["Profession tool"], L["Profession gear"], L["Offensive spell"], L["Utility spell"],
			L["Defensive spell"], L["Mobility spell"],
		}
		slotGroups = {
			{ label = L["Armor and accessories"], 1, 2, 3, 16, 5, 20, 9, 10, 6, 7, 8, 11, 12 },
			{ label = L["Weapons and off-hand"], 13, 17, 21, 22, 14, 23, 15, 25, 26, 28 },
			{ label = L["Clothing and containers"], 4, 19, 18, 24, 27 },
			{ label = L["Other slots"], 0, 29, 30, 31, 32, 33, 34 },
		}
	end

	local function rarityName(id)
		if type(id) ~= "number" then return nil end
		local name = ns.QualityName(id)
		if name then return name end
		if id == 0 then return L["Poor"] end
		if id == 1 then return L["Common"] end
		if id == 2 then return L["Uncommon"] end
		if id == 3 then return L["Rare"] end
		if id == 4 then return L["Epic"] end
		if id == 5 then return L["Legendary"] end
		if id == 6 then return L["Artifact"] end
		if id == 7 then return L["Heirloom"] end
		if id == 8 then return L["WoW Token"] end
		return format(L["Quality %d"], id)
	end
	itemDetails.RarityName = rarityName

	local function rarityText(quality)
		if not quality then return L["Any rarity"] end
		return #quality == 1 and rarityName(quality[1]) or format(L["%d rarities"], #quality)
	end

	local function tokenQualityPresent()
		local C = ns.Codex
		if not (C and C.Index) then return false end
		for _, k in ipairs(kinds()) do
			if KIND[k.key] and KIND[k.key].item then
				local index = C.Index(k.key)
				-- Search's canonical name rows end in ID, quality, status, name length.
				if index and index:find("\1%d+,8,%a?,%d+\n") then return true end
			end
		end
		return false
	end

	local function classText()
		local c = current()
		local class = c.saved.class
		if not class then return L["Any class"] end
		local name = UI.ClassName(class)
		local r, g, b = Theme.ClassColor(class)
		return c.classDormant and format(L["%s · %s"], name, L["Unknown"]) or name, r and { r, g, b }
	end

	local function changeItemFilter(key, value)
		local saved = LK.ItemFilters()
		if saved[key] == value then return end
		flushPending()
		saved[key] = value
		LK.SetItemFilters(saved)
		restartList()
	end

	function filtersUI.HideMenu(onlyHidden)
		local function ownsMenu(button)
			return W.MenuShown(button) and (not onlyHidden or not button:IsVisible())
		end
		if ownsMenu(root.SearchOrder) then return W.HideMenu() end
		local drawer = rawget(root, "FilterDrawer")
		local item = drawer and rawget(drawer, "Item")
		if not item then return end
		for _, button in ipairs(item.Dropdowns) do
			if ownsMenu(button) then return W.HideMenu() end
		end
	end

	function filtersUI.ShowMenu(button, items, currentChoice, searchFold)
		W.ShowMenu(button, items, { minWidth = button:GetWidth(), current = currentChoice, searchFold = searchFold })
	end

	local function classChoices()
		local choices = { { text = L["Any class"] } }
		for _, token in ipairs(CLASSES) do
			choices[#choices + 1] = { value = token, text = UI.ClassName(token), color = { Theme.ClassColor(token) } }
		end
		return choices
	end

	local function rarityMenu(button)
		if W.MenuShown(button) then return W.HideMenu() end
		local checked, items = {}, {}
		local tokenPresent = tokenQualityPresent()
		for _, id in ipairs(LK.ItemFilters().quality or {}) do checked[id] = true end
		local function choose(id)
			if id == nil then checked = {} else checked[id] = not checked[id] or nil end
			local removeToken = items[10] and not tokenPresent and not checked[8]
			if removeToken then items[10] = nil end
			items[1].checked = next(checked) == nil
			for i = 2, #items do items[i].checked = checked[i - 2] end
			changeItemFilter("quality", next(checked) and checked or nil)
			return removeToken
		end
		items[1] = { text = L["Any rarity"], checked = next(checked) == nil, keepOpen = true, onClick = function() return choose() end }
		local last = (checked[8] or tokenPresent) and 8 or 7
		for id = 0, last do
			local quality = id
			items[#items + 1] = { text = rarityName(id), color = { qualityColor(id) }, checked = checked[id], keepOpen = true,
				onClick = function() return choose(quality) end }
		end
		filtersUI.ShowMenu(button, items)
	end

	local function slotChoices()
		loadSlots()
		local choices = { { text = L["Any slot"] } }
		for _, group in ipairs(slotGroups) do
			choices[#choices + 1] = { text = group.label, disabled = true }
			for _, id in ipairs(group) do choices[#choices + 1] = { value = id, text = slotLabels[id] } end
		end
		return choices
	end

	local function foldStat(text)
		return ns.Search.Fold(text):sub(2)
	end

	function filtersUI.StatMenu(button, selected, choose)
		if W.MenuShown(button) then return W.HideMenu() end
		local S, items = ns.Search, {}
		local function add(code, label)
			items[#items + 1] = { text = label, checked = selected == code,
				searchText = S.StatSearchText(code), onClick = function() choose(code) end }
		end
		add(nil, L["Any stat"])
		for _, code in ipairs(S.StatCodes()) do add(code, S.StatLabel(code)) end
		filtersUI.ShowMenu(button, items, false, foldStat)
	end

	local function statFilterMenu(button)
		filtersUI.StatMenu(button, LK.ItemFilters().stat, function(code) changeItemFilter("stat", code) end)
	end

	local function editValue(box)
		local raw = (box:GetText() or ""):match("^%s*(.-)%s*$")
		if raw == "" then return nil, true end
		local value = raw:match("^%d+$") and itemFilterInteger(tonumber(raw), 999)
		return value, value ~= nil
	end

	local function boxError(box, errorText)
		if box.psTip == errorText then return end
		box.psTip = errorText
		W.Color(box, errorText and "warning" or "text")
		if errorText and box:HasFocus() then W.SimpleTip(box) else W.HideTip(box) end
	end

	local function validateRange(range)
		local lo, loOK = editValue(range.Min)
		local hi, hiOK = editValue(range.Max)
		local inverted = loOK and hiOK and lo and hi and lo > hi
		local bounds = inverted and L["Minimum must be at or below maximum."] or nil
		local invalid = L["Enter whole levels from 0 to 999."]
		boxError(range.Min, not loOK and invalid or bounds)
		boxError(range.Max, not hiOK and invalid or bounds)
		return loOK and hiOK and not inverted, lo, hi
	end

	local function restoreRange(range, lo, hi)
		range.appliedLo, range.appliedHi, range.dirty = lo, hi, nil
		local first, last = lo and tostring(lo) or "", hi and tostring(hi) or ""
		range.Min:SetText(first)
		range.Max:SetText(last)
		range.Min.Hint:SetShown(first == "")
		range.Max.Hint:SetShown(last == "")
		boxError(range.Min)
		boxError(range.Max)
	end

	local function commitRange(range)
		if not (filtersUI.drawerOpen and range.dirty) then return true end
		local valid, lo, hi = validateRange(range)
		if not valid then return false end
		local changed = lo ~= range.appliedLo or hi ~= range.appliedHi
		restoreRange(range, lo, hi)
		if changed then
			flushPending()
			local saved = LK.ItemFilters()
			saved[range.loKey], saved[range.hiKey] = lo, hi
			LK.SetItemFilters(saved)
			restartList()
		end
		return true
	end

	local function paintRange(range, saved)
		local lo, hi = saved[range.loKey], saved[range.hiKey]
		if lo ~= range.appliedLo or hi ~= range.appliedHi then restoreRange(range, lo, hi) end
	end

	local function makeRange(panel, text, desc, loKey, hiKey)
		local range = W.SettingRow(panel, text, desc)
		range:SetScript("OnEnter", W.RowEnter)
		range:SetScript("OnLeave", W.HideTip)
		range.loKey, range.hiKey = loKey, hiKey
		local label = range.Label
		local function box(placeholder)
			local b = W.NumberBox(range, { placeholder = placeholder,
				onEdit = function(_, user) if user then range.dirty = true; validateRange(range) end end,
				onCommit = function(self)
					if not commitRange(range) and self:HasFocus() then
						W.SimpleTip(self.psTip and self or (range.Min.psTip and range.Min or range.Max))
					end
				end,
				onCancel = function(self)
					restoreRange(range, range.appliedLo, range.appliedHi)
					self:ClearFocus()
				end,
			})
			b:HookScript("OnEditFocusGained", function(self)
				if self.psTip then W.SimpleTip(self)
				elseif label:IsTruncated() then W.Tooltip(self, "ANCHOR_TOP", text) end
			end)
			b:HookScript("OnEnter", function(self)
				if not self.psTip and label:IsTruncated() then W.Tooltip(self, "ANCHOR_TOP", text) end
			end)
			return b
		end
		range.Min, range.Max = box(L["Min"]), box(L["Max"])
		range.Max:SetPoint("RIGHT", range, "RIGHT", -12, 0)
		range.Min:SetPoint("RIGHT", range.Max, "LEFT", -6, 0)
		label:SetPoint("RIGHT", range.Min, "LEFT", -10, 0)
		range.psSpan = function() return 12 + range.Min:GetWidth() + 6 + range.Max:GetWidth() + 10 end
		return range
	end

	local function makeGroup(drawer, title)
		local group = CreateFrame("Frame", nil, drawer)
		group:SetWidth(drawer:GetWidth())
		group.Header = W.SectionHeader(group, { plain = true })
		group.Header:SetPoint("TOPLEFT")
		group.Header:SetWidth(group:GetWidth())
		W.SetSection(group.Header, title)
		group.Panel = W.RowPanel(group)
		group.Panel:SetPoint("TOPLEFT", group.Header, "BOTTOMLEFT")
		group.Panel:SetWidth(group:GetWidth())
		return group
	end

	-- Use the Options row measurements, including wrapped labels. The two
	-- level ranges share a line so results stay in reach with Filters open.
	local function layoutGroup(group, top)
		group:SetPoint("TOPLEFT", group:GetParent(), "TOPLEFT", 0, -top)
		local y = 0
		for _, line in ipairs(group.Rows) do
			if line[1]:IsShown() then
				local width, height = group:GetWidth() / #line, 0
				for i, row in ipairs(line) do
					row:SetPoint("TOPLEFT", group.Panel, "TOPLEFT", (i - 1) * width, -y)
					height = max(height, W.LayoutRow(row, width))
				end
				for _, row in ipairs(line) do row:SetHeight(height) end
				y = y + height
			end
		end
		group.Panel:SetHeight(y)
		group:SetHeight(group.Header:GetHeight() + y)
		return top + group:GetHeight()
	end

	local function makeAvailability(drawer)
		local group = makeGroup(drawer, L["Availability"])
		group.Rows = {}
		drawer.Availability = {}
		for i, choice in ipairs(VISIBILITY_CHOICES) do
			local row = W.Toggle(group.Panel, choice.text, choice.path, choice.desc)
			group.Rows[i] = { row }
			drawer.Availability[i] = row
		end
		return group
	end

	local function makeItemControls(drawer)
		local item = makeGroup(drawer, L["Item filters"])
		local panel = item.Panel
		local function singleDropdown(label, key, choices, tip, display)
			local row = W.Dropdown(panel, label, nil, choices, tip, nil, {
				get = function() return LK.ItemFilters()[key] end,
				set = function(value) changeItemFilter(key, value) end,
				display = display,
			})
			return row.Button
		end
		local function customDropdown(label, menu, desc, display)
			local row = W.Dropdown(panel, label, nil, nil, desc, nil, { openMenu = menu, display = display })
			return row.Button
		end
		item.Required = makeRange(panel, L["Required level"], L["Uses the level the item requires."], "reqMin", "reqMax")
		item.Level = makeRange(panel, L["Item level"], L["Uses the item's item level, which sets how strong its stats are."], "ilvlMin", "ilvlMax")
		item.Class = singleDropdown(L["Usable by"], "class", classChoices, L["Uses item class restrictions and equipment proficiencies."], classText)
		item.Rarity = customDropdown(L["Rarity"], rarityMenu, L["Uses the item's quality, from Poor to Legendary."], function()
			local quality = current().saved.quality
			return rarityText(quality), quality and #quality == 1 and { qualityColor(quality[1]) }
		end)
		item.Slot = singleDropdown(L["Slot"], "slot", slotChoices(), L["Uses where the item is worn; items that aren't worn have no slot."])
		item.Stat = customDropdown(L["Stat"], statFilterMenu, L["Uses the item's listed stats."], function()
			return ns.Search.StatLabel(current().saved.stat) or L["Any stat"]
		end)
		item.Dropdowns = { item.Class, item.Rarity, item.Slot, item.Stat }
		item.Rows = { { item.Required, item.Level } }
		for _, button in ipairs(item.Dropdowns) do item.Rows[#item.Rows + 1] = { button:GetParent() } end
		drawer.Item = item
		return item
	end

	local function itemControls(c)
		return c.filterData and itemCapable()
	end

	local function clearAvailability()
		-- Keep the narrow setting notifications. A broad profile notification
		-- would also trigger a hub render before the filter commit finishes.
		filtersUI.clearingAvailability = true
		for _, choice in ipairs(VISIBILITY_CHOICES) do
			if ns.Get(choice.path) then ns.Set(choice.path, false) end
		end
		filtersUI.clearingAvailability = nil
	end

	local function clearAll()
		flushPending()
		filtersUI.DiscardRanges()
		-- Use the view's displayed controls, even if the flushed query changes
		-- which kinds have matches.
		if itemControls(cache) then
			-- Keep the suspended filters this view neither shows nor counts.
			local kept = {}
			for key, value in pairs(LK.ItemFilters()) do
				if not filterApplies(key, kind) then kept[key] = value end
			end
			LK.SetItemFilters(kept)
			category = nil
		end
		clearAvailability()
		restartList()
	end

	local function paintDrawer(c)
		local drawer = rawget(root, "FilterDrawer")
		if not filtersUI.drawerOpen then if drawer then drawer:Hide() end; return 0 end
		local showItems = itemControls(c)
		if not drawer then
			drawer = CreateFrame("Frame", nil, root)
			drawer:SetWidth(root.FilterBar:GetWidth())
			drawer:SetPoint("TOPLEFT", root.FilterBar, "BOTTOMLEFT")
			drawer.Status = makeAvailability(drawer)
			drawer.Clear = W.Button(drawer, L["Clear all filters"], clearAll)
			drawer.Clear:SetPoint("TOPRIGHT", drawer.Status, "BOTTOMRIGHT", 0, -4)
			root.FilterDrawer = drawer
		end
		local item = rawget(drawer, "Item")
		local height = 0
		if showItems then
			item = item or makeItemControls(drawer)
			item.Slot:GetParent():SetShown(filterApplies("slot", kind))
			item.Stat:GetParent():SetShown(filterApplies("stat", kind))
			paintRange(item.Required, c.saved)
			paintRange(item.Level, c.saved)
			for _, button in ipairs(item.Dropdowns) do button:GetParent():Refresh() end
			height = layoutGroup(item, 0)
		elseif item and item:IsShown() then
			filtersUI.DiscardRanges()
		end
		if item then item:SetShown(showItems and true or false) end
		local C = ns.Codex
		local needsUpdate = c.loaded and not c.filterData and itemCapable() and not (C and C.FiltersTooNew and C.FiltersTooNew())
		local note = rawget(drawer, "Compatibility")
		if needsUpdate and not note then
			note = W.Text(drawer, "note", "textMuted")
			note:SetText(L["Update the Codex to filter items."])
			note:SetPoint("TOPLEFT", drawer, "TOPLEFT", 0, -8)
			note:SetPoint("TOPRIGHT", drawer, "TOPRIGHT", 0, -8)
			note:SetHeight(36)
			note:SetJustifyH("LEFT")
			note:SetWordWrap(true)
			drawer.Compatibility = note
		end
		if note then note:SetShown(needsUpdate and true or false) end
		if needsUpdate then height = height + 36 end
		height = layoutGroup(drawer.Status, height) + drawer.Clear:GetHeight() + 8
		drawer:SetHeight(height)
		drawer:Show()
		return height
	end

	local function activeFilterCount(c)
		local count = category and 1 or 0
		if itemControls(c) then
			local saved = c.saved
			count = count + ((saved.reqMin or saved.reqMax) and 1 or 0) + ((saved.ilvlMin or saved.ilvlMax) and 1 or 0)
				+ (saved.class and 1 or 0) + (saved.quality and 1 or 0)
			for key in pairs(GEAR_ONLY_FILTERS) do
				if saved[key] and filterApplies(key, kind) then count = count + 1 end
			end
		end
		for _, choice in ipairs(VISIBILITY_CHOICES) do
			if ns.Get(choice.path) then count = count + 1 end
		end
		return count
	end

	function filtersUI.Paint(c)
		local height = root.FilterBar:GetHeight() + paintDrawer(c)
		if height ~= filtersUI.chromeHeight then
			filtersUI.chromeHeight = height
			results:SetPoint("TOPLEFT", root, "TOPLEFT", 0, -4 - height)
		end
		filtersUI.HideMenu(true)
		return activeFilterCount(c)
	end

	function filtersUI.DiscardRanges()
		local drawer = rawget(root, "FilterDrawer")
		local item = drawer and rawget(drawer, "Item")
		if not item then return end
		for _, range in ipairs({ item.Required, item.Level }) do
			restoreRange(range, range.appliedLo, range.appliedHi)
			range.Min:ClearFocus()
			range.Max:ClearFocus()
		end
	end

	local function finishRanges()
		local drawer = rawget(root, "FilterDrawer")
		local item = drawer and rawget(drawer, "Item")
		if item and item:IsShown() then
			commitRange(item.Required)
			commitRange(item.Level)
		end
	end

	function filtersUI.Toggle()
		filtersUI.HideMenu()
		if filtersUI.drawerOpen then
			finishRanges()
			filtersUI.DiscardRanges()
		end
		filtersUI.drawerOpen = not filtersUI.drawerOpen
		showControls(current())
		W.SetScrollContent(results, results.psContent, filtersUI.ViewHeight())
		paintVisible()
	end

	function filtersUI.Hide()
		if filtersUI.drawerOpen then finishRanges() end
		filtersUI.drawerOpen = false
		filtersUI.HideMenu()
		filtersUI.DiscardRanges()
		root.FilterBar:Hide()
		local drawer = rawget(root, "FilterDrawer")
		if drawer then drawer:Hide() end
	end
end
installFilterChrome()

---------------------------------------------------------------------------
-- The hub section
---------------------------------------------------------------------------

local function resetCategoryVisit()
	category, openBranches = nil, {}
end

-- build(parent, hub): parent spans the list and details area under the
-- tab row; the hub is the window (its header, tab row and search).
function LK.Build(parent, hub)
	if root then return root end
	shell = hub
	root = CreateFrame("Frame", nil, parent)
	root:SetAllPoints(parent)
	LK.root = root
	-- The results take what the details leave of the section's width.
	local w = parent:GetWidth() or 0
	if w <= 0 then w = hub:GetWidth() - (hub.psRail or 0) - (hub.psSidebar or SH.sidebar) - 2 end
	MID_W = floor(w - DETAIL_W)
	results = W.Scroll(root)
	-- Rows are drawn for what is in view: scrolling draws the rest.
	results:HookScript("OnMouseWheel", function() reconcileDirectSelection(); paintVisible() end)
	results.Bar:HookScript("OnMouseDown", reconcileDirectSelection)
	results:HookScript("OnVerticalScroll", function() paintVisible() end)
	results:SetPoint("TOPLEFT", root, "TOPLEFT", 0, -4)
	results:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", -(DETAIL_W + 4), 4)
	LK.results = results
	-- The emblem engraving, behind an empty list only.
	root.Watermark = root:CreateTexture(nil, "BACKGROUND", nil, -4)
	root.Watermark:SetTexture(Theme.Media("watermark"))
	root.Watermark:SetSize(300, 300)
	root.Watermark:SetPoint("CENTER", root, "LEFT", MID_W / 2, 0)
	W.Painter(root.Watermark, function(t) t:SetVertexColor(Theme.Wash("watermark")) end)
	root.Watermark:Hide()
	root.Empty = W.Text(results.Child, "note", "textDim")
	root.Empty:SetWordWrap(true)
	root.Empty:SetJustifyV("TOP")
	root.Empty:SetWidth(MID_W - SH.pad * 2)
	root.Empty:Hide()
	-- In the hub's tab row, while the Codex is not there to search: why.
	root.CodexLine = W.Text(hub.TabRow, "small", "textMuted")
	root.CodexLine:SetPoint("LEFT", hub.TabRow, "LEFT", SH.pad, 0)
	root.CodexLine:SetWidth(MID_W - SH.pad * 2)
	local bar = CreateFrame("Frame", nil, root)
	bar:SetSize(MID_W - 2 * SH.pad, W.ROW_H)
	bar:SetPoint("TOPLEFT", root, "TOPLEFT", SH.pad, -4)
	root.FilterBar = bar
	root.Visibility = W.Button(bar, L["Filters"], filtersUI.Toggle, { icon = "chevron-down", height = 28, width = 112 })
	root.Visibility:SetPoint("RIGHT", bar, "RIGHT")
	local sort = W.Dropdown(bar, L["Sort by"], nil, nil, nil, nil, { openMenu = orderMenu, display = function()
		local value = effectiveOrder()
		return value == "most" and mostLabel(sortStat) or ORDER_LABELS[value]
	end })
	sort:SetPoint("RIGHT", root.Visibility, "LEFT", -8, 0)
	W.LayoutRow(sort, bar:GetWidth() - root.Visibility:GetWidth() - 8)
	sort.Rule:Hide()
	root.SearchOrder = sort.Button
	bar:Hide()
	-- It belongs to this section: other sections' tab rows stay theirs.
	root:SetScript("OnShow", function() root.CodexLine:Show() end)
	-- The hub closing with nothing in its search box: the next visit starts
	-- in Best match. A search left in the box keeps its order with it.
	hub:HookScript("OnHide", function()
		resetCategoryVisit()
		filtersUI.Hide()
		local P = UI.Picker
		local text = P and P.Query and P.Query() or query
		if text == "" and (order ~= "best" or sortStat) then
			order, baseOrder, sortStat = "best", "best", nil
			stale()
		end
	end)
	parent:HookScript("OnHide", function()
		resetCategoryVisit()
		filtersUI.Hide()
	end)
	-- Leaving the section, not Polestar hiding (its layer hides the hub with
	-- the section still open: a search running goes on). The hub leaves a
	-- section by hiding the section's frame, `parent`, not this one: with
	-- only its own state read, the line stayed over the guide list's tabs
	-- (#2692).
	root:SetScript("OnHide", function(self)
		filtersUI.Hide()
		if self:IsShown() and parent:IsShown() then return end
		cancelPending()
		root.CodexLine:Hide()
	end)
	buildDetails()
	return root
end

-- The hub renders the section: take up its search when it changed while
-- another section was shown (not while ShowLookup hands it one).
local opening = false
local function sectionRender()
	local P = UI.Picker
	local hub = P and P.Query and P.Query() or query
	if not pending and not opening and hub ~= query then
		clearDirectSelection()
		query = hub
		LK.message = nil
		LK.Render()
		reconcile(query == "")
		return
	end
	LK.Render()
	-- While the hub was closed a typed search could land or Filters change:
	-- the list it shows again may no longer hold the selection.
	if not opening then reconcile() end
end

if UI.RegisterSection then
	UI.RegisterSection({
		key = "Lookup", label = L["Lookup"], icon = "search", order = 20,
		build = LK.Build, render = sectionRender,
		nav = LK.Nav, onNav = selectNav,
		search = onSearch, enter = onEnter, step = LK.Step,
		searchPlaceholder = { L["Search items, mounts, NPCs"], L["Search items, mounts"], L["Search"] },
	})
end

-- opts: { query, kind, id }: the hub at this section. With an id and no
-- query the search is the entity's name, and it is selected.
function UI.ShowLookup(opts)
	opts = type(opts) == "table" and opts or {}
	local P = UI.Picker
	if not (P and UI.ShowPicker and P.ShowSection) then return end
	local q, k, id = opts.query, opts.kind, opts.id
	local direct = id ~= nil and KIND[k] and KIND[k].item
	opening = true
	if id ~= nil and k then
		if direct then id = tonumber(id) or id end
		if q == nil or q == "" then
			local rec = k == "guide" and guideHeader(id) or codexRecord(k, id)
			q = rec and (rec.name or rec.title) or q
		end
		setSelection(k, id)
		itemDetails.direct = direct
	else
		clearDirectSelection()
	end
	LK.message = nil
	-- Opening Lookup means looking something up: load the pack now, so the
	-- section knows at once whether it is there.
	local C = ns.Codex
	if C and C.Load and not (C.IsLoaded and C.IsLoaded()) and not lookupOff() then C.Load() end
	if q ~= nil then
		cancelPending()
		query = q
		kind, category = "all", nil
	end
	UI.ShowPicker()
	P.ShowSection("Lookup")
	-- The hub's box shows the search (this section has it already).
	if q ~= nil and P.SetQuery then
		P.SetQuery(q)
		-- The box's own state follows its text (a client fires OnTextChanged).
		local box = P.search
		if box and box.Placeholder then box.Placeholder:SetShown(q == "") end
		if box and box.Clear then box.Clear:SetShown(q ~= "") end
	end
	cancelPending()
	opening = false
	refresh()
	-- An entity asked for stays selected; otherwise the list decides.
	if id == nil or not k then reconcile() end
	if P.search then P.search:SetFocus() end
end

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
-- A late names pack renames the results and the selection's sources.
local function namesChanged()
	stale()
	refresh()
	-- A list that was empty while the Codex loaded selects its first row now.
	if root and root:IsVisible() then reconcile() end
end
ns.On("CODEX_LOADED", function()
	itemCategories.column = nil
	category = nil
	namesChanged()
end)
ns.On("NAMES_LOADED", namesChanged)
ns.RegisterEvent("GET_ITEM_INFO_RECEIVED", function(_, id, success)
	if not (success and root and root:IsVisible() and sel and sel.id == id and details.Well.psItem == id) then return end
	local c = current()
	renderDetails(c.loaded, c.reason)
end)
-- The Codex refused to load in combat: a list waiting on it loads it now.
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if not (root and root:IsVisible()) or cache.reason ~= "combat" or lookupOff() then return end
	local C = ns.Codex
	if C and C.Load and not (C.IsLoaded and C.IsLoaded()) then C.Load() end
	-- Loaded, CODEX_LOADED drew the list; else it says why now.
	if not (C and C.IsLoaded and C.IsLoaded()) then namesChanged() end
end)
local function guidesChanged()
	stale()
	if query == "" then refresh() else LK.Render() end
end
ns.On("GUIDES_REGISTERED", guidesChanged)
ns.On("PACKS_CHANGED", guidesChanged)
-- Search ranks by the suggestion source's guides: a new source ranks anew.
-- The "New in Forever" mark shows or goes on the pages at once.
ns.On("SETTING_CHANGED", function(path)
	if path == "behavior.suggestFrom" or path == "behavior" then guidesChanged() end
	if path == "lookup.enabled" then namesChanged() end
	if path == "lookup" or path == "lookup.hideRetired" or path == "lookup.hideNoSource" or path == "" then
		if not filtersUI.clearingAvailability then restartList() end
	end
	if path == "ui.newInForever" then LK.Render() end
end)
-- Quality colours are lifted against the ground and the icon's hairline is
-- set by hand: a scheme change paints them again.
Theme.OnChanged(function() LK.Render() end)

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
