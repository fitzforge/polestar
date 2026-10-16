-- Lookup, a section of the hub (the guide menu's window, UI.RegisterSection
-- "Lookup"): one search over the guides and every entity in the Codex
-- (items, mounts, pets, recipes, quests, NPCs, rares, dungeons, zones,
-- treasures), and for the selection, where to get it, ranked for this
-- character, with one click to a guide.
--
-- Search only, never browsing: nothing lists a whole data set. The hub's
-- search box drives it while the section is shown (typing searches after a
-- short pause; Up/Down walk the results, Enter acts on the selection). An
-- empty search shows the recent lookups (CharState().ui.recentLookups) and
-- a hint. The sidebar filters the current results by kind: Everything, then
-- the kinds found, with their counts. Under the 152 line, left: the results
-- grouped by kind, one line each (icon in the gutter, the name in its
-- quality or subject colour, a short subtitle right); under Everything a
-- kind shows its first few and a "Show all" line; a kind shows a page of
-- results and a "Show more" line for the next. Only the rows in view are
-- drawn.
-- Right: the selection's details (its sources asked for once per
-- selection): a band (the zone art of where it is got, the night band
-- without) with the kind, the icon and the name; key facts; the sources
-- from Lookup.Sources, best first (label, detail, travel time, chance, price
-- or standing; ones this character cannot use yet dimmed and saying why);
-- the selected source carries its own "Guide" button; pinned at the bottom
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
}

-- The client's colours, for a client (or preview) without the API.
local QUALITY_RGB = {
	[0] = { 0.62, 0.62, 0.62 }, { 1, 1, 1 }, { 0.12, 1, 0 }, { 0, 0.44, 0.87 }, { 0.64, 0.21, 0.93 }, { 1, 0.5, 0 }, { 0.9, 0.8, 0.5 },
}
local FACTION = { A = ns.FactionName("A"), H = ns.FactionName("H"), AH = L["Both factions"] }

local shell, root, results, details -- the hub window, this section, the results scroll, the details pane
local query, kind = "", "all"
local sel -- { kind, id, title, subtitle, quality }
local sourceSel -- index into the selection's sources
local visible = {} -- results in the middle pane, top to bottom
local pending -- the debounce timer
-- The selection's sources (Lookup.Sources), kept until the selection changes.
local detailCache = {}
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
		return L["Lookup is turned off in Options > Discovery > Lookup. Items, mounts, NPCs and quests are not searched."]
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

-- opts: { perKind, limit, offset (per kind: for the next page) }.
local function search(text, only, opts)
	local S = ns.Search
	if text == "" or not (S and S.Query) then return {}, {} end
	local o = { limit = opts.limit, perKind = opts.perKind, offset = opts.offset, subtitles = opts.subtitles }
	if only then o.kinds = only end
	local results, counts = S.Query(text, o)
	return results or {}, counts or {}
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

-- Item qualities and standings in the client's words (Core/Init.lua).
local qualityName, standingName = ns.QualityName, ns.StandingName

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

function LK.Money(copper)
	if type(copper) ~= "number" or copper <= 0 then return nil end
	local g, s, c = floor(copper / 10000), floor(copper / 100) % 100, copper % 100
	local parts = {}
	if g > 0 then parts[#parts + 1] = g .. L["g"] end
	if s > 0 then parts[#parts + 1] = s .. L["s"] end
	if c > 0 then parts[#parts + 1] = c .. L["c"] end
	return table.concat(parts, " ")
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
	r.Title:SetText(res.title or tostring(res.id))
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
function LK.Select(k, id, res, auto)
	if k == nil or id == nil then
		sel = nil
		detailCache = {}
	else
		res = res or {}
		if not (sel and sel.kind == k and sel.id == id) then detailCache = {} end
		sel = { kind = k, id = id, title = res.title, subtitle = res.subtitle, quality = res.quality, status = res.status, remember = not auto }
	end
	sourceSel = nil
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
	d.Art:EnableMouse(true)
	d.Art:RegisterForDrag("LeftButton")
	d.Art:SetScript("OnDragStart", function() shell:StartMoving() end)
	d.Art:SetScript("OnDragStop", function() shell:StopMovingOrSizing() end)
	-- The icon in a dark well with a hairline in the quality colour, the
	-- name beside it and a muted line under the name.
	d.Well = CreateFrame("Frame", nil, d.Art.Over)
	d.Well:SetSize(ICON, ICON)
	d.Well:SetPoint("BOTTOMLEFT", d.Art, "BOTTOMLEFT", DPAD, 16)
	d.Well:SetFrameLevel(d.Art.Over:GetFrameLevel() + 2)
	d.WellGround = d.Well:CreateTexture(nil, "BACKGROUND")
	d.WellGround:SetTexture(Theme.Media("white"))
	d.WellGround:SetAllPoints(d.Well)
	W.Painter(d.WellGround, function(t)
		local r, g, b = Theme.Color("scrim")
		t:SetVertexColor(r, g, b, 0.72)
	end)
	d.Icon = d.Well:CreateTexture(nil, "ARTWORK")
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

-- Facts: { label, value, colour? }.
local function factsFor(s, entity, list)
	local k, e, out = s.kind, entity or {}, {}
	local function add(label, value, color) if value and value ~= "" then out[#out + 1] = { label, value, color } end end
	if k == "guide" then
		local g = guideHeader(s.id) or {}
		add(L["Category"], g and UI.Category and L[UI.Category(g)])
		add(L["Levels"], UI.LevelRange(g.minLevel, g.maxLevel))
		add(L["Faction"], ns.FactionName(g.faction) or L["Both factions"])
		if g.stepCount or g.steps then add(L["Steps"], tostring(g.stepCount or #g.steps)) end
		return out
	end
	if KIND[k] and KIND[k].item then
		local q = qualityName(e.quality or s.quality)
		add(L["Type"], KIND[k].name .. (q and (DOT .. q) or ""))
		if type(e.reqLevel) == "number" and e.reqLevel > 1 then add(L["Requires"], format(L["Level %d"], e.reqLevel)) end
	elseif k == "npc" or k == "rare" then
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
		add(L["Faction"], e.faction and (FACTION[e.faction] or L[e.faction]) or L["Both factions"])
		if e.zone then
			local z = UI.MapName(e.zone) or (codexRecord("zone", e.zone) or {}).name
			add(L["Zone"], z)
		end
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
		local label = (KIND[k] and KIND[k].item) and L["Sources"] or L["Places"]
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
	if KIND[k] and KIND[k].item then return L["Where to get it"] end
	if k == "quest" then return L["Start and turn-in"] end
	if k == "instance" then return L["Entrance"] end
	return L["Where to find it"]
end

-- The band: where it is got (the best source with a place), or its own
-- map, else the night sky.
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
	return entity and entity.map or nil
end

local function emptyDetails(title, note)
	local d = details
	d.psArt = ZoneArt.Paint(d.Art, nil, nil, nil, 1)
	for _, p in ipairs({ d.Well, d.Title, d.Sub, d.Status, d.Head, d.Scroll, d.Note, d.Primary, d.Secondary }) do p:Hide() end
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
	local title = s.kind == "guide" and (g and g.title) or (entity and (entity.name or entity.title)) or s.title or tostring(s.id)
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
	d.Well:Show()
	d.Title:SetText(title)
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
	local facts = factsFor(s, entity, list)
	local shown = {}
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
	for i = #facts + 1, #d.Facts do
		d.Facts[i].Label:Hide()
		d.Facts[i].Value:Hide()
	end
	y = y - FACT_GAP + 8

	-- The bottom: what the button does, then the button(s).
	local Lk = ns.Lookup
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
	elseif s.kind == "zone" then
		note = L["Zones have no sources. Search for what is in them."]
	elseif blocked then
		note = STATUS_NOTE[status]
	elseif curated then
		local cg = guideHeader(curated)
		primary = L["Open guide"]
		note = format(L["A guide covers this: %s."], cg and cg.title or curated)
	elseif not (Lk and Lk.Guide) then
		note = L["Guides from the Codex need the Lookup module."]
	elseif best then
		primary = L["Guide me"]
		note = format(L["Builds a guide to %s, the best source for you, and opens it in a new tab."], list[best].label or "?")
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
		d.Primary.psTip = s.kind == "guide" and nil or L["Enter does this too."]
	else
		d.Primary:Hide()
		d.Secondary:Hide()
	end
	local noteH = d.Note:IsShown() and (d.Note:GetStringHeight() + 12) or 0
	local bottom = DPAD + (primary and (32 + 12) or 0) + noteH + 4

	-- Sources.
	local rowsShown = {}
	if list and s.kind ~= "zone" then
		d.Head.Text:SetText(headText(s.kind))
		d.Head.Count:SetText(#list > 0 and tostring(#list) or "")
		d.Head:ClearAllPoints()
		d.Head:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD - TEXT_X, -y)
		d.Head:Show()
		y = y + FOLDER_H + 6
		d.Scroll:ClearAllPoints()
		d.Scroll:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD - 8, -y)
		d.Scroll:SetPoint("BOTTOMRIGHT", d, "BOTTOMRIGHT", -DPAD + 10, bottom)
		d.Scroll:Show()
		local child = d.Scroll.Child
		local cw = INNER + 8
		child:SetWidth(cw)
		local cy = 0
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
			d.NoSource:SetText(L["No source is known for this yet."])
			d.NoSource:Show()
			cy = 30
		else
			d.NoSource:Hide()
		end
		W.SetScrollContent(d.Scroll, cy + 4, shell:GetHeight() - SH.top - y - bottom)
	else
		d.Head:Hide()
		d.Scroll:Hide()
	end
	LK.detail = {
		kind = s.kind, id = s.id, title = title, facts = shown, sources = rowsShown, curated = curated, status = status,
		primary = primary and d.Primary.Label:GetText() or nil, note = d.Note:GetText(), art = d.psArt,
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

local function selectFirst()
	if sel then
		for _, res in ipairs(visible) do
			if res.kind == sel.kind and res.id == sel.id then return end
		end
	end
	if visible[1] then LK.Select(visible[1].kind, visible[1].id, visible[1], true) end
end

-- Bumped when what a search finds may have changed (the Codex or the
-- guides loaded).
LK.gen = 0
local function stale() LK.gen = LK.gen + 1 end

-- The current search, run once per query and kind (the hub asks for the
-- sidebar's counts and the section's list in one render): the counts with a
-- few results per kind, and under one kind its first page. Subtitles are
-- filled for the rows drawn only (Search.Subtitle).
local cache = {}
local function current()
	if cache.query == query and cache.kind == kind and cache.gen == LK.gen then return cache end
	local all, counts, list = {}, {}, {}
	if query ~= "" then
		all, counts = search(query, nil, { perKind = GROUP_MAX, limit = GROUP_MAX * #kinds(), subtitles = false })
		if kind == "all" then
			list = all
		else
			list = (search(query, { [kind] = true }, { perKind = PAGE, limit = PAGE, offset = 0, subtitles = false }))
		end
	end
	-- After the search: its first one loads the pack (or learns it is missing).
	local loaded, reason = status()
	local total = 0
	for _, n in pairs(counts) do total = total + n end
	cache = { query = query, kind = kind, gen = LK.gen, list = list, counts = counts, total = total, loaded = loaded, reason = reason }
	return cache
end

-- The next page of the shown kind.
function LK.More()
	local c = current()
	if kind == "all" or query == "" then return end
	local more = search(query, { [kind] = true }, { perKind = PAGE, limit = PAGE, offset = #c.list, subtitles = false })
	for _, res in ipairs(more) do c.list[#c.list + 1] = res end
	LK.Render()
end

-- The hub sidebar under the search: Everything, then the kinds this search
-- found, with their counts (the one shown always), as many as the sidebar
-- holds above its foot; the rest are a "Show all" away in the list.
local NAV_MAX = 10
function LK.Nav()
	local c = current()
	local items = { { key = "all", label = L["Everything"], icon = "search", count = query ~= "" and c.total or nil } }
	for _, k in ipairs(kinds()) do
		local n = c.counts[k.key] or 0
		if (n > 0 and #items <= NAV_MAX) or (k.key == kind and query ~= "") then
			items[#items + 1] = { key = k.key, label = k.label, icon = KIND[k.key] and KIND[k.key].icon or k.icon or "search", count = n }
		end
	end
	return items, kind
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

-- The list as laid out: { t = "folder"|"row"|"action", y, ... }, top down.
local entries = {}

local function viewHeight() return shell:GetHeight() - SH.top - 8 end

-- Draw the entries in view (and a row either side), from the pools.
local function paintVisible()
	if not (root and results) then return end
	local top = results:GetVerticalScroll() or 0
	local lo, hi = top - ROW_H * 2, top + viewHeight() + ROW_H * 2
	local width = MID_W - ROW_X * 2
	local body = results.Child
	local nf, nr = 0, 0
	for _, e in ipairs(entries) do
		local h = e.t == "folder" and FOLDER_H or ROW_H
		if e.y + h >= lo and e.y <= hi then
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
			local top, view = results:GetVerticalScroll() or 0, viewHeight()
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
	local title = (kind == "all" or query == "") and L["Lookup"] or kindLabel(kind)
	local subtitle
	if query == "" then
		subtitle = L["Every guide, item, mount, NPC, quest and place, and where to get it."]
	else
		local n = kind == "all" and total or (counts[kind] or #list)
		subtitle = n == 1 and format(L["1 result for %s"], LQ .. query .. RQ) or format(L["%d results for %s"], n, LQ .. query .. RQ)
	end
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
	if query == "" then
		-- No search: the recent lookups, never a data set.
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

	local empty
	if reason == "loading" and #list == 0 then
		empty = L["Loading the Codex\226\128\166"]
	elseif query == "" then
		empty = loaded and L["Type a name in the search box: a mount you saw, an item you want, an NPC or a quest."]
			or L["Type a name in the search box to search the guides."]
	elseif #list == 0 then
		empty = format(L["Nothing matches %s."], LQ .. query .. RQ)
		if reason == "off" then
			empty = empty .. " " .. L["Lookup is turned off in Options > Discovery > Lookup, so items, mounts, NPCs and quests are not searched."]
		elseif not loaded then
			empty = empty .. " " .. L["Items, mounts, NPCs and quests are searched once the Codex loads."]
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
	W.SetScrollContent(results, y + 16, viewHeight())
	paintVisible()
	renderDetails(loaded, reason)
	LK.shown = { query = query, kind = kind, groups = groups, rows = #visible, empty = empty, total = total }
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

local function setQuery(text)
	text = text or ""
	if text == query then return end
	query = text
	LK.message = nil
	if not (root and root:IsVisible()) then return end
	W.ScrollTo(results, 0)
	refresh()
	if query ~= "" then selectFirst() end
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
	pending = C_Timer.NewTimer(DEBOUNCE, function()
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
	LK.Activate()
end

function LK.Query() return query end

function LK.SetKind(k)
	kind = k or "all"
	if root and root:IsVisible() then
		W.ScrollTo(results, 0)
		refresh()
		if query ~= "" then selectFirst() end
	end
end

function LK.Kind() return kind end

function LK.Step(delta)
	if #visible == 0 then return end
	local at
	if sel then
		for i, res in ipairs(visible) do if res.kind == sel.kind and res.id == sel.id then at = i end end
	end
	at = at and min(#visible, max(1, at + delta)) or 1
	-- Walking the list opens no page for good: only a click or Enter does.
	LK.Select(visible[at].kind, visible[at].id, visible[at], true)
	reveal()
end

---------------------------------------------------------------------------
-- The hub section
---------------------------------------------------------------------------

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
	if w <= 0 then w = hub:GetWidth() - (hub.psRail or 0) - SH.sidebar - 2 end
	MID_W = floor(w - DETAIL_W)
	results = W.Scroll(root)
	-- Rows are drawn for what is in view: scrolling draws the rest.
	results:HookScript("OnMouseWheel", function() paintVisible() end)
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
	-- It belongs to this section: other sections' tab rows stay theirs.
	root:SetScript("OnShow", function() root.CodexLine:Show() end)
	root:SetScript("OnHide", function()
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
		query = hub
		LK.message = nil
		LK.Render()
		if query ~= "" then selectFirst() end
		return
	end
	LK.Render()
end

if UI.RegisterSection then
	UI.RegisterSection({
		key = "Lookup", label = L["Lookup"], icon = "search", order = 20,
		build = LK.Build, render = sectionRender,
		nav = LK.Nav, onNav = LK.SetKind,
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
	if id ~= nil and k then
		if q == nil or q == "" then
			local rec = k == "guide" and guideHeader(id) or codexRecord(k, id)
			q = rec and (rec.name or rec.title) or q
		end
		if not (sel and sel.kind == k and sel.id == id) then detailCache = {} end
		sel = { kind = k, id = id, remember = true }
		sourceSel = nil
	end
	LK.message = nil
	-- Opening Lookup means looking something up: load the pack now, so the
	-- section knows at once whether it is there.
	local C = ns.Codex
	if C and C.Load and not (C.IsLoaded and C.IsLoaded()) and not lookupOff() then C.Load() end
	if q ~= nil then
		cancelPending()
		query = q
		kind = "all"
	end
	opening = true
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
	if not sel and query ~= "" then selectFirst() end
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
end
ns.On("CODEX_LOADED", namesChanged)
ns.On("NAMES_LOADED", namesChanged)
local function guidesChanged()
	stale()
	LK.Render()
end
ns.On("GUIDES_REGISTERED", guidesChanged)
ns.On("PACKS_CHANGED", guidesChanged)
-- Search ranks by the suggestion source's guides: a new source ranks anew.
ns.On("SETTING_CHANGED", function(path)
	if path == "behavior.suggestFrom" or path == "behavior" or path == "" then guidesChanged() end
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
