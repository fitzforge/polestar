-- The Rares section of the hub (the guide menu's shell): every rare NPC and
-- treasure the Codex knows, by zone, and the ones this realm has seen. Data:
-- Polestar.Rares over the Codex pack (loaded on first show); its signature
-- drop from Codex.Loot, places from Lookup (Lookup.Sources for the rare's
-- spawns, Lookup.Guide on Alt-click).
--
-- Tabs: Rares, Treasures, Seen. Under the tab row two panes on the guide
-- menu's grid, as the Journal: the list (left, a filter on top, rows on the
-- 32 edge under zone headings, the player's zone first; Seen lists newest
-- first) and the selection (right, on the panel ground): a band (the zone art
-- at its nearest spawn) with its name and facts, "Set waypoint", "Look up"
-- and "Mute alerts", then Drops (its signature drop: the best quality, then
-- the highest item level; loot tables are left to loot addons), Where (each
-- spawn: zone, coordinates, travel; a click sets the waypoint) and Seen
-- (when, where and how it was last met).
--
-- Registered with UI.RegisterSection; opened by SHOW_RARES(kind, id).

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local Rares = ns.Rares
local serverTime, mapName = ns.Compat.Now, ns.Compat.MapName
local L = ns.L
local floor, max, min, type, ipairs, pairs, tostring, format, pcall, concat = math.floor, math.max, math.min, type, ipairs, pairs, tostring, string.format, pcall, table.concat

if not (UI and W and W.SHELL) then return end
local ZoneArt = UI.ZoneArt

local SH = W.SHELL
local LIST_W = 272
local ROW_X = 12
local TEXT_X = SH.pad - ROW_X
local ROW_H = 28
local HEAD_H = 34
local ITEM_H = 28
local PLACE_H = 26
local BAND_H = 132
local FOOT_PAD = 24 -- the actions' inset from the pane's edges
local FOOT_H = 28 + FOOT_PAD * 2
local DPAD = SH.side
local DOT = "  \194\183  "
local MAX_PLACES = 8

local RV = {}
UI.RaresSection = RV

local TABS = {
	{ key = "rare", label = L["Rares"] },
	{ key = "treasure", label = L["Treasures"] },
	{ key = "seen", label = L["Seen"] },
}
RV.TABS = TABS

local tab = "rare"
local selected = {} -- tab -> key ("rare:61")
local filter = ""
local root, shellRef, list, detail
local listRows, heads, items, places, notes, sections = {}, {}, {}, {}, {}, {}
local shown = {} -- what the last render put up, for tests and the preview

local function LK() return UI.Lookup end
local secret = ns.Compat.IsSecret

---------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------

local function splitKey(key)
	if type(key) ~= "string" then return nil end
	local kind, id = key:match("^(%a+):(.+)$")
	if kind == "rare" or kind == "treasure" then return kind, tonumber(id) end
	return kind, id
end

local function itemIcon(id)
	local C = C_Item
	if type(id) ~= "number" or not (C and C.GetItemIconByID) then return nil end
	local ok, icon = pcall(C.GetItemIconByID, id)
	if ok and icon and not secret(icon) then return icon end
	return nil
end

local function paintQuality(fs, q)
	local qc = LK() and LK().QualityColor
	local r, g, b
	if qc then r, g, b = qc(q) end
	if r then
		W.Uncolor(fs)
		fs:SetTextColor(r, g, b, 1)
	else
		W.Color(fs, "item")
	end
end

local function matches(...)
	if filter == "" then return true end
	for i = 1, select("#", ...) do
		local s = select(i, ...)
		if type(s) == "string" and s:lower():find(filter, 1, true) then return true end
	end
	return false
end

local function playerMap()
	local map = ns.Compat.GetPlayerMapPosition()
	return map
end

---------------------------------------------------------------------------
-- Pools
---------------------------------------------------------------------------

local function listRow(i)
	local r = listRows[i]
	if r then return r end
	r = CreateFrame("Button", nil, list.Scroll.Child)
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
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(12, 12)
	r.Icon:SetPoint("CENTER", r, "LEFT", TEXT_X / 2 - 1, 0)
	r.Title = W.Text(r, "body", "text")
	r.Title:SetPoint("LEFT", r, "LEFT", TEXT_X, 0)
	r.Sub = W.Text(r, "small", "textMuted")
	r.Sub:SetJustifyH("RIGHT")
	r.Sub:SetPoint("RIGHT", r, "RIGHT", -10, 0)
	r:SetScript("OnClick", function(self) RV.Select(self.psKey) end)
	listRows[i] = r
	return r
end

local function listHead(i)
	local h = sections[i]
	if h then return h end
	h = CreateFrame("Frame", nil, list.Scroll.Child)
	h:SetHeight(HEAD_H)
	h.Text = W.Text(h, "label", "textDim")
	h.Text:SetPoint("BOTTOMLEFT", h, "BOTTOMLEFT", TEXT_X, 8)
	h.Count = W.Text(h, "number", "textMuted")
	h.Count:SetJustifyH("RIGHT")
	h.Count:SetPoint("BOTTOMRIGHT", h, "BOTTOMRIGHT", -10, 8)
	sections[i] = h
	return h
end

local function head(i, parent)
	local h = heads[i]
	if h then return h end
	h = W.SectionHeader(parent)
	heads[i] = h
	return h
end

local function note(i, parent)
	local n = notes[i]
	if n then return n end
	n = W.Text(parent, "note", "textDim")
	n:SetWordWrap(true)
	n:SetJustifyH("LEFT")
	n:SetJustifyV("TOP")
	notes[i] = n
	return n
end

local function itemLines(tip)
	local r, g, b = Theme.Color("textDim")
	tip:AddLine(L["Click: every way to get it in Lookup"], r, g, b, true)
	tip:AddLine(L["Alt-click: a guide to get it"], r, g, b, true)
end

local function itemEnter(self)
	W.ItemTip(self, self.psID, itemLines)
end

local function itemLeave(self)
	if GameTooltip and GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end

function RV.ItemClick(id)
	if not id then return end
	local Lookup = ns.Lookup
	if IsAltKeyDown and IsAltKeyDown() and Lookup and Lookup.Guide then
		-- No guide to it (a mount without a curated one): its Lookup page.
		if not Lookup.Guide("item", id) and Lookup.Show then Lookup.Show(nil, "item", id) end
		return
	end
	if W.ItemClick(id) then return end
	if Lookup and Lookup.Show then Lookup.Show(nil, "item", id) end
end

local function itemRow(i, parent)
	local r = items[i]
	if r then return r end
	r = CreateFrame("Button", nil, parent)
	r:SetHeight(ITEM_H)
	W.Hover(r)
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(18, 18)
	r.Icon:SetPoint("LEFT", r, "LEFT", 0, 0)
	r.Name = W.Text(r, "body", "item")
	r.Name:SetPoint("LEFT", r, "LEFT", 28, 0)
	r.Note = W.Text(r, "small", "textMuted")
	r.Note:SetPoint("LEFT", r.Name, "RIGHT", 10, 0)
	r:SetScript("OnEnter", itemEnter)
	r:SetScript("OnLeave", itemLeave)
	r:SetScript("OnClick", function(self) RV.ItemClick(self.psID) end)
	items[i] = r
	return r
end

local function placeRow(i, parent)
	local r = places[i]
	if r then return r end
	r = CreateFrame("Button", nil, parent)
	r:SetHeight(PLACE_H)
	W.Hover(r)
	r.Icon = W.Tex(r, "ARTWORK", "icon-goto", "textMuted")
	r.Icon:SetSize(12, 12)
	r.Icon:SetPoint("LEFT", r, "LEFT", 3, 0)
	r.Zone = W.Text(r, "body", "text")
	r.Zone:SetPoint("LEFT", r, "LEFT", 28, 0)
	r.Coords = W.Text(r, "number", "textDim")
	r.Coords:SetPoint("LEFT", r.Zone, "RIGHT", 10, 0)
	r.Travel = W.Text(r, "number", "textMuted")
	r.Travel:SetJustifyH("RIGHT")
	r.Travel:SetPoint("RIGHT", r, "RIGHT", 0, 0)
	r:SetScript("OnClick", function(self)
		local N = ns.Nav
		if N and N.SetTarget and self.psMap then N.SetTarget(self.psMap, self.psX, self.psY, self.psLabel, self.psF) end
	end)
	r:SetScript("OnEnter", function(self) W.Tooltip(self, "ANCHOR_RIGHT", self.psLabel, { L["Click: set the waypoint here"] }) end)
	r:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	places[i] = r
	return r
end

---------------------------------------------------------------------------
-- Build
---------------------------------------------------------------------------

function RV.Build(parent, shell)
	if root then return root end
	shellRef = shell
	root = CreateFrame("Frame", nil, parent)
	root:SetAllPoints(parent)

	list = CreateFrame("Frame", nil, root)
	list:SetPoint("TOPLEFT", root, "TOPLEFT", 0, 0)
	list:SetPoint("BOTTOMLEFT", root, "BOTTOMLEFT", 0, 0)
	list:SetWidth(LIST_W)
	list.Scroll = W.Scroll(list)
	list.Scroll:SetPoint("TOPLEFT", list, "TOPLEFT", 0, -4)
	list.Scroll:SetPoint("BOTTOMRIGHT", list, "BOTTOMRIGHT", 0, 8)
	list.Scroll.Child:SetWidth(LIST_W)
	list.Empty = W.Text(list.Scroll.Child, "note", "textMuted")
	list.Empty:SetWordWrap(true)
	list.Empty:SetWidth(LIST_W - TEXT_X * 2)
	list.Empty:SetJustifyH("LEFT")
	list.Empty:SetPoint("TOPLEFT", list.Scroll.Child, "TOPLEFT", SH.pad, -8)

	local d = CreateFrame("Frame", nil, root)
	detail = d
	d:SetPoint("TOPLEFT", list, "TOPRIGHT", 0, 0)
	d:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", 0, 0)
	W.Fill(d, "panel")
	local rule = W.Divider(d, true)
	rule:SetPoint("TOPLEFT", d, "TOPLEFT", 0, 0)
	rule:SetPoint("BOTTOMLEFT", d, "BOTTOMLEFT", 0, 0)
	return root
end

-- The selection pane's width, from the hub (anchored frames have no width
-- before the first layout): the main column, less the rail and sidebar.
local function detailWidth()
	local full = shellRef and (shellRef:GetWidth() - (shellRef.psRail or 0) - (shellRef.psSidebar or SH.sidebar) - 2) or 0
	if full <= 0 then full = 878 end
	return full - LIST_W
end

local function buildDetail()
	local d = detail
	if rawget(d, "Art") then return end
	local w = detailWidth()
	d.psW = w
	d.Art = ZoneArt.Create(d, w, BAND_H, "panel")
	d.Art.psZoom = 1.6
	d.Art:SetPoint("TOPLEFT", d, "TOPLEFT", 1, 0)
	d.Title = W.Text(d.Art.Over, "display", "text")
	d.Sub = W.Text(d.Art.Over, "small", "textDim")
	d.Sub:SetPoint("TOPLEFT", d.Title, "BOTTOMLEFT", 0, -8)
	for _, fs in ipairs({ d.Title, d.Sub }) do
		W.Painter(fs, function(t)
			local r, g, b = Theme.Color("shade")
			t:SetShadowOffset(0, -1)
			t:SetShadowColor(r, g, b, 0.85)
		end)
	end
	-- The actions sit at the pane's foot, 24 in from its edges: Set waypoint
	-- (the one accent) on the right, the secondary ones to its left.
	d.Foot = CreateFrame("Frame", nil, d)
	d.Foot:SetPoint("BOTTOMLEFT", d, "BOTTOMLEFT", 1, 0)
	d.Foot:SetPoint("BOTTOMRIGHT", d, "BOTTOMRIGHT", 0, 0)
	d.Foot:SetHeight(FOOT_H)
	d.FootRule = W.Divider(d.Foot)
	d.FootRule:SetPoint("TOPLEFT", d.Foot, "TOPLEFT", 0, 0)
	d.FootRule:SetPoint("TOPRIGHT", d.Foot, "TOPRIGHT", 0, 0)
	d.Go = W.Button(d.Foot, L["Set waypoint"], function() RV.Waypoint() end, { primary = true, height = 28, icon = "icon-goto" })
	d.Look = W.Button(d.Foot, L["Look up"], function() RV.LookUp() end, { height = 28, icon = "search" })
	d.Look.psTip = L["Open it in Lookup: where it is, ranked for this character."]
	d.Mute = W.Button(d.Foot, L["Mute alerts"], function() RV.ToggleMute() end, { height = 28 })

	d.Scroll = W.Scroll(d)
	d.Scroll:SetPoint("TOPLEFT", d.Art, "BOTTOMLEFT", 0, -1)
	d.Scroll:SetPoint("BOTTOMRIGHT", d.Foot, "TOPRIGHT", -4, 4)
	d.Body = d.Scroll.Child
	d.Body:SetWidth(w)

	d.EmptyTitle = W.Text(d.Body, "display", "text")
	d.EmptyNote = W.Text(d.Body, "note", "textDim")
	d.EmptyNote:SetWordWrap(true)
	d.EmptyNote:SetJustifyH("LEFT")
	d.EmptyNote:SetJustifyV("TOP")
end

---------------------------------------------------------------------------
-- The list
---------------------------------------------------------------------------

local NOWHERE = "~" -- sorts last

-- -> { { head = zone, count } | { key, title, sub, kind, dim } } for the tab
local function entries()
	local out, total = {}, 0
	if tab == "seen" then
		local h = Rares.History()
		local rows = {}
		local now = serverTime()
		for key, e in pairs(h) do
			if type(e) == "table" and e.t then
				local zone = mapName(e.map)
				if matches(e.name, zone) then
					rows[#rows + 1] = { key = key, title = e.name or key, sub = Rares.AgoText(e.t, now), kind = e.kind, t = e.t }
				end
			end
		end
		table.sort(rows, function(a, b) return a.t > b.t end)
		for _, r in ipairs(rows) do out[#out + 1] = r end
		return out, #rows
	end
	local all = Rares.ListOf(tab) or {}
	local unplaced = {}
	if tab == "rare" then
		-- Rares with no spawn on any map (instances, unknown places) too.
		local C = Rares.Codex(false)
		if C then
			C.Each("rare", function(id)
				local rec = Rares.Info("rare", id)
				if rec and #rec.spawns == 0 then unplaced[#unplaced + 1] = rec end
			end)
		end
	end
	local here = playerMap()
	local byZone, zones = {}, {}
	local function add(rec, zone)
		local z = zone or NOWHERE
		local listZ = byZone[z]
		if not listZ then
			listZ = {}
			byZone[z] = listZ
			zones[#zones + 1] = z
		end
		listZ[#listZ + 1] = rec
	end
	for _, rec in ipairs(all) do
		local zone = mapName(rec.spawns[1].map) or NOWHERE
		if matches(rec.name, zone) then add(rec, zone) end
	end
	for _, rec in ipairs(unplaced) do
		if matches(rec.name) then add(rec, nil) end
	end
	local hereName = here and mapName(here)
	table.sort(zones, function(a, b)
		if a == hereName then return b ~= hereName end
		if b == hereName then return false end
		return a < b
	end)
	local ignored = Rares.Get("ignored")
	for _, z in ipairs(zones) do
		local recs = byZone[z]
		table.sort(recs, function(a, b)
			local la, lb = a.level or 0, b.level or 0
			if la ~= lb then return la < lb end
			return (a.name or "") < (b.name or "")
		end)
		out[#out + 1] = { head = z == NOWHERE and L["Dungeons and unplaced"] or z, count = #recs, here = z == hereName }
		for _, rec in ipairs(recs) do
			local key = Rares.Key(tab, rec.id)
			local sub
			if tab == "rare" then
				sub = Rares.LevelText(rec.level, rec.levelMax)
				if sub and rec.elite then sub = sub .. "+" end
			else
				local n = #rec.spawns
				sub = n == 1 and L["1 spot"] or format(L["%d spots"], n)
			end
			out[#out + 1] = { key = key, title = rec.name, sub = sub, kind = tab, dim = type(ignored) == "table" and ignored[key] }
			total = total + 1
		end
	end
	return out, total
end

local function renderList(rows)
	local y, nr, nh = 0, 0, 0
	local key = selected[tab]
	for _, e in ipairs(rows) do
		if e.head then
			nh = nh + 1
			local h = listHead(nh)
			h:ClearAllPoints()
			h:SetPoint("TOPLEFT", list.Scroll.Child, "TOPLEFT", ROW_X, -y)
			h:SetWidth(LIST_W - ROW_X * 2)
			h.Text:SetText(e.here and format(L["%s (you are here)"], e.head) or e.head)
			W.Color(h.Text, "textMuted")
			h.Count:SetText(tostring(e.count))
			h:Show()
			y = y + HEAD_H
		else
			nr = nr + 1
			local r = listRow(nr)
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", list.Scroll.Child, "TOPLEFT", ROW_X, -y)
			r:SetWidth(LIST_W - ROW_X * 2)
			r.psKey = e.key
			local on = e.key == key
			r.Selected:SetShown(on)
			r.Bar:SetShown(on)
			r.Icon:SetTexture(Theme.Media(e.kind == "treasure" and "icon-treasure" or "qol-target"))
			W.Color(r.Icon, on and "accent" or Rares.ColorName(e.kind), on and 1 or 0.85)
			r.Title:SetText(e.title)
			W.Color(r.Title, (e.dim and not on) and "textMuted" or "text")
			r.Sub:SetText(e.sub or "")
			local room = LIST_W - ROW_X * 2 - TEXT_X - 10 - (e.sub and e.sub ~= "" and (r.Sub:GetStringWidth() + 12) or 0)
			r.Title:SetWidth(max(40, min(room, floor(r.Title:GetStringWidth() + 1))))
			r:Show()
			y = y + ROW_H
		end
	end
	for i = nr + 1, #listRows do listRows[i]:Hide() end
	for i = nh + 1, #sections do sections[i]:Hide() end
	list.Empty:SetShown(nr == 0)
	if filter ~= "" then
		list.Empty:SetText(L["Nothing matches the filter."])
	elseif tab == "seen" then
		list.Empty:SetText(L["Nothing seen yet. Rares and treasures you meet are kept here, newest first."])
	else
		list.Empty:SetText(L["Nothing here yet."])
	end
	W.SetScrollContent(list.Scroll, y + 16)
end

---------------------------------------------------------------------------
-- The selection
---------------------------------------------------------------------------

local function hideBody()
	for _, t in ipairs({ heads, items, places, notes }) do
		for _, r in ipairs(t) do r:Hide() end
	end
	detail.EmptyTitle:Hide()
	detail.EmptyNote:Hide()
end

local function band(title, sub, map, x, y)
	local d = detail
	d.psArt = ZoneArt.Paint(d.Art, map, x, y, #(title or "") + 1)
	d.Title:SetText(title or "")
	d.Sub:SetText(sub or "")
	d.Title:SetWidth(d.psW - DPAD * 2)
	d.Sub:SetWidth(d.psW - DPAD * 2)
	d.Title:ClearAllPoints()
	d.Title:SetPoint("BOTTOMLEFT", d.Art, "BOTTOMLEFT", DPAD, 16 + 11 + 8)
end

local function actions(go, look, mute)
	local d = detail
	d.Go:SetShown(go)
	d.Look:SetShown(look)
	d.Mute:SetShown(mute ~= nil)
	if mute ~= nil then W.SetButtonText(d.Mute, mute and L["Unmute alerts"] or L["Mute alerts"]) end
	d.Mute.psTip = mute and L["Alerts for it are off. Click to turn them back on."] or L["No more alerts for this one; it stays on the map."]
	local prev
	for _, b in ipairs({ d.Go, d.Look, d.Mute }) do
		if b:IsShown() then
			b:ClearAllPoints()
			if prev then b:SetPoint("RIGHT", prev, "LEFT", -8, 0) else b:SetPoint("BOTTOMRIGHT", d.Foot, "BOTTOMRIGHT", -FOOT_PAD, FOOT_PAD) end
			prev = b
		end
	end
	d.Foot:SetShown(prev ~= nil)
	d.Scroll:ClearAllPoints()
	d.Scroll:SetPoint("TOPLEFT", d.Art, "BOTTOMLEFT", 0, -1)
	if prev then
		d.Scroll:SetPoint("BOTTOMRIGHT", d.Foot, "TOPRIGHT", -4, 4)
	else
		d.Scroll:SetPoint("BOTTOMRIGHT", d, "BOTTOMRIGHT", -4, 4)
	end
end

local function empty(title, text, y)
	local d = detail
	d.EmptyTitle:ClearAllPoints()
	d.EmptyTitle:SetPoint("TOPLEFT", d.Body, "TOPLEFT", DPAD, y - 8)
	d.EmptyTitle:SetWidth(d.psW - DPAD * 2)
	d.EmptyTitle:SetText(title)
	d.EmptyTitle:Show()
	d.EmptyNote:ClearAllPoints()
	d.EmptyNote:SetPoint("TOPLEFT", d.EmptyTitle, "BOTTOMLEFT", 0, -10)
	d.EmptyNote:SetWidth(min(520, d.psW - DPAD * 2))
	d.EmptyNote:SetText(text)
	d.EmptyNote:Show()
	return 8 + 24 + 10 + d.EmptyNote:GetStringHeight() + 16
end

local function writer()
	local d = detail
	local w = { y = -8, h = 0, i = 0, p = 0, n = 0, width = d.psW - DPAD * 2 - 8 }
	function w.head(text, count)
		w.h = w.h + 1
		local h = head(w.h, d.Body)
		h:ClearAllPoints()
		h:SetPoint("TOPLEFT", d.Body, "TOPLEFT", DPAD, w.y)
		h:SetWidth(w.width)
		W.SetSection(h, text, count)
		h:Show()
		w.y = w.y - 44 - 2
	end
	function w.note(text)
		w.n = w.n + 1
		local n = note(w.n, d.Body)
		n:ClearAllPoints()
		n:SetPoint("TOPLEFT", d.Body, "TOPLEFT", DPAD, w.y - 6)
		n:SetWidth(min(560, w.width))
		n:SetText(text)
		n:Show()
		w.y = w.y - 6 - n:GetStringHeight() - 10
	end
	function w.item(e)
		w.i = w.i + 1
		local r = itemRow(w.i, d.Body)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", d.Body, "TOPLEFT", DPAD, w.y)
		r:SetWidth(w.width)
		r.psID = e.id
		local icon = itemIcon(e.id)
		if icon then
			r.Icon:SetTexture(icon)
			r.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			W.Uncolor(r.Icon)
			r.Icon:SetVertexColor(1, 1, 1, 1)
		else
			r.Icon:SetTexture(Theme.Media("icon-collect"))
			r.Icon:SetTexCoord(0, 1, 0, 1)
			W.Color(r.Icon, "textMuted")
		end
		r.Name:SetText(e.name or ("item:" .. tostring(e.id)))
		paintQuality(r.Name, e.quality)
		r.Note:SetText(e.note or "")
		local room = w.width - 28 - 12
		r.Name:SetWidth(max(60, min(room, floor(r.Name:GetStringWidth() + 1))))
		r.Note:SetWidth(max(0, room - r.Name:GetWidth() - 10))
		r:Show()
		w.y = w.y - ITEM_H
	end
	function w.place(p)
		w.p = w.p + 1
		local r = placeRow(w.p, d.Body)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", d.Body, "TOPLEFT", DPAD, w.y)
		r:SetWidth(w.width)
		r.psMap, r.psX, r.psY, r.psF, r.psLabel = p.map, p.x, p.y, p.f, p.label
		r.Zone:SetText(p.zone or "?")
		r.Coords:SetText(p.x and format("%.1f, %.1f", p.x, p.y) or "")
		r.Travel:SetText(p.travel or "")
		r.Zone:SetWidth(max(60, min(w.width - 200, floor(r.Zone:GetStringWidth() + 1))))
		r:Show()
		w.y = w.y - PLACE_H
	end
	return w
end

local function travelText(seconds)
	if not seconds then return nil end
	if seconds >= (ns.TRAVEL_CROSS_CONTINENT or 3600) then return L["another continent"] end
	if seconds < 60 then return L["under a minute"] end
	return format(L["%d min away"], floor(seconds / 60 + 0.5))
end

-- An item's level: the client's (C_Item.GetDetailedItemLevelInfo), else the
-- level the Codex says it needs, else 0.
local function itemLevel(id, item)
	local C = C_Item
	if C and C.GetDetailedItemLevelInfo then
		local ok, lv = pcall(C.GetDetailedItemLevelInfo, id)
		if ok and type(lv) == "number" and not secret(lv) then return lv end
	end
	return item and item.reqLevel or 0
end

-- Whether the Codex knows this item only from this rare or treasure: it
-- has sources and every one is a drop from it.
local function onlyHere(item, kind, ownerId)
	local sources = item and item.sources
	if type(sources) ~= "table" or #sources == 0 then return false end
	for _, s in ipairs(sources) do
		local own = (kind == "rare" and s.type == "drop" and s.npc == ownerId) or (kind == "treasure" and s.type == "object" and s.object == ownerId)
		if not own then return false end
	end
	return true
end

-- Its signature drop: one the Codex knows only from it first, then the best
-- quality, then the highest item level, then the lowest ID (stable).
-- -> item id, Codex item | nil
local function signature(rec, C)
	local bestId, best, bx, bq, blv
	for _, id in ipairs(rec.loot or {}) do
		local item = C and C.Item(id)
		local x, q, lv = onlyHere(item, rec.kind, rec.id) and 1 or 0, item and item.quality or -1, itemLevel(id, item)
		if not bestId or x > bx or (x == bx and (q > bq or (q == bq and (lv > blv or (lv == blv and id < bestId))))) then
			bestId, best, bx, bq, blv = id, item, x, q, lv
		end
	end
	return bestId, best
end
RV.Signature = signature

local function renderLoot(rec, w)
	local C = Rares.Codex(false)
	local id, item = signature(rec, C)
	w.head(L["Drops"])
	if not id then
		w.note(L["The Codex knows no drop for it."])
		return
	end
	w.item({ id = id, name = item and item.name, quality = item and item.quality })
	shown.loot = id
end

local function renderWhere(rec, w)
	local Lookup = ns.Lookup
	local rows = {}
	if Lookup and Lookup.Sources then
		local ok, got = pcall(Lookup.Sources, rec.kind, rec.id)
		if ok and type(got) == "table" then rows = got end
	end
	if #rows == 0 then
		for _, s in ipairs(rec.spawns) do rows[#rows + 1] = { map = s.map, x = s.x, y = s.y, f = s.f } end
	end
	w.head(L["Where"], #rows > 0 and tostring(#rows) or nil)
	if #rows == 0 then
		if rec.instance then
			local C = Rares.Codex(false)
			local inst = C and C.Instance(rec.instance)
			w.note(format(L["Inside %s."], inst and inst.name or rec.instance))
		else
			w.note(L["No place is known for it yet."])
		end
		return
	end
	for i = 1, min(#rows, MAX_PLACES) do
		local r = rows[i]
		w.place({ map = r.map, x = r.x, y = r.y, f = r.f, zone = r.zone or mapName(r.map), travel = travelText(r.travel), label = rec.name })
	end
	if #rows > MAX_PLACES then w.note(format(L["And %d more on the map."], #rows - MAX_PLACES)) end
	shown.places = #rows
end

local function renderSeen(entry, w, now)
	w.head(L["Seen"])
	if not entry or not entry.t then
		w.note(L["Not met on this realm yet. Polestar notes every rare and treasure you meet."])
		return
	end
	local how = { vignette = L["on the minimap"], nameplate = L["by its nameplate"], target = L["as your target"], mouseover = L["under the cursor"] }
	local zone = mapName(entry.map)
	local line = format(L["Last seen %s"], Rares.AgoText(entry.t, now))
	if zone then line = line .. " " .. format(L["in %s"], zone) end
	if how[entry.src or ""] then line = line .. ", " .. how[entry.src] end
	w.note(line .. ".")
	if (entry.n or 0) > 1 and entry.first and date then
		w.note(format(L["Met %d times since %s."], entry.n, date("%d %b", entry.first)))
	end
	if entry.dead and entry.dead >= entry.t then w.note(L["It was dead when last seen."]) end
end

local function renderEntity(key, w)
	local kind, id = splitKey(key)
	local now = serverTime()
	local entry = key and Rares.History()[key]
	local rec = (kind == "rare" or kind == "treasure") and Rares.Info(kind, id) or nil
	if not rec and not entry then
		band(L["Rares"], nil, nil)
		actions(false, false, nil)
		w.y = w.y - empty(L["Pick a rare or a treasure"], L["Its level, its signature drop, every place it spawns and when you last met it."], w.y)
		return
	end
	local name = (rec and rec.name) or (entry and entry.name) or key
	local me = ns.PlayerPoint()
	local spawn = rec and Rares.Nearest(rec.spawns, me)
	if not spawn and entry and entry.map then spawn = { map = entry.map, x = entry.x, y = entry.y } end
	local facts = {}
	local lv = Rares.LevelText(rec and rec.level or entry and entry.level, rec and rec.levelMax)
	if lv then facts[#facts + 1] = format(L["Level %s"], lv) end
	if kind == "rare" and rec and rec.elite then facts[#facts + 1] = L["Elite"] end
	local zone = spawn and mapName(spawn.map)
	if zone then facts[#facts + 1] = zone end
	if entry and entry.t then facts[#facts + 1] = format(L["seen %s"], Rares.AgoText(entry.t, now)) end
	band(name, concat(facts, DOT), spawn and spawn.map, spawn and spawn.x, spawn and spawn.y)
	detail.psSpawn, detail.psName, detail.psKey = spawn, name, key
	actions(spawn ~= nil and ns.Nav ~= nil, rec ~= nil and ns.Lookup ~= nil, Rares.IsIgnored(key))
	shown.name, shown.facts = name, concat(facts, DOT)
	if rec then
		renderLoot(rec, w)
		renderWhere(rec, w)
	else
		w.head(L["Drops"])
		w.note(L["Its drop and places come with the Codex pack."])
	end
	renderSeen(entry, w, now)
end

local function subtitle()
	if tab == "seen" then
		local n = 0
		for _ in pairs(Rares.History()) do n = n + 1 end
		return n == 1 and L["1 met on this realm"] or format(L["%d met on this realm"], n)
	end
	local r, t = Rares.ListOf("rare"), Rares.ListOf("treasure")
	local zones = {}
	for _, l in ipairs({ r or {}, t or {} }) do
		for _, rec in ipairs(l) do
			for _, s in ipairs(rec.spawns) do zones[s.map] = true end
		end
	end
	local nz = 0
	for _ in pairs(zones) do nz = nz + 1 end
	local nr, nt = r and #r or 0, t and #t or 0
	return concat({
		nr == 1 and L["1 rare"] or format(L["%d rares"], nr),
		nt == 1 and L["1 treasure"] or format(L["%d treasures"], nt),
		nz == 1 and L["1 zone"] or format(L["%d zones"], nz),
	}, DOT)
end

-- The hub's search is this section's filter (name or zone).
local function syncFilter()
	local P = UI.Picker
	local q = P and P.Query and P.ActiveSection and P.ActiveSection() and P.ActiveSection().key == "Rares" and P.Query() or nil
	if q ~= nil then filter = q:lower() end
end

function RV.Render()
	if not root then return end
	syncFilter()
	buildDetail()
	hideBody()
	for k in pairs(shown) do shown[k] = nil end
	local w = writer()
	local C, reason
	if not Rares.Get("enabled") then
		reason = "off"
	else
		C = Rares.Codex(true)
		if not C then
			local X = ns.Codex
			if X and X.Load and not ns.Compat.InCombat() then
				local _, why = X.Load()
				reason = why or "missing"
			else
				reason = ns.Compat.InCombat() and "combat" or "missing"
			end
		end
	end
	if reason == "off" or (not C and tab ~= "seen") then
		if shellRef then W.ShellTitle(shellRef, L["Rares"], L["Rare NPCs and treasures, what they drop and where they spawn"]) end
		renderList({})
		list.Empty:SetText(reason == "off" and L["Rares is turned off."] or L["Nothing to list without the Codex."])
		band(L["Rares"], nil, nil)
		actions(false, false, nil)
		local text
		if reason == "off" then
			text = L["Rares is turned off. Turn it on under Options > Discovery > Rares."]
		else
			local rt = LK() and LK().ReasonText
			text = (rt and rt(reason)) or tostring(reason)
		end
		w.y = w.y - empty(reason == "off" and L["Rares is off"] or L["Rares needs the Codex"], text, w.y)
		shown.empty = reason
		W.SetScrollContent(detail.Scroll, -w.y + 24)
		return
	end
	if shellRef then W.ShellTitle(shellRef, L["Rares"], subtitle()) end
	local rows, n = entries()
	local key = selected[tab]
	local found = false
	for _, e in ipairs(rows) do if e.key and e.key == key then found = true end end
	if not found then
		key = nil
		for _, e in ipairs(rows) do
			if e.key then
				key = e.key
				break
			end
		end
		selected[tab] = key
	end
	renderList(rows)
	shown.tab, shown.list, shown.selected = tab, n, key
	renderEntity(key, w)
	W.SetScrollContent(detail.Scroll, -w.y + 24)
end

function RV.SetTab(key)
	for _, t in ipairs(TABS) do
		if t.key == key then
			tab = key
			W.ScrollTo(list.Scroll, 0)
			if detail.Scroll then W.ScrollTo(detail.Scroll, 0) end
			local P = UI.Picker
			if P and P.Render and root:IsVisible() then P.Render() else RV.Render() end
			return
		end
	end
end

-- The sidebar index: Rares, Treasures, Seen with their counts.
function RV.Nav()
	local C = Rares.Codex(false)
	local seen = 0
	for _ in pairs(Rares.History()) do seen = seen + 1 end
	local r, t
	if C then
		r, t = 0, 0
		C.Each("rare", function() r = r + 1 end)
		C.Each("treasure", function() t = t + 1 end)
	end
	return {
		{ key = "rare", label = L["Rares"], icon = "qol-target", count = r },
		{ key = "treasure", label = L["Treasures"], icon = "icon-treasure", count = t },
		{ key = "seen", label = L["Seen"], icon = "icon-explore", count = seen },
	}, tab
end

function RV.Search(text)
	filter = (text or ""):lower()
	if list then W.ScrollTo(list.Scroll, 0) end
	RV.Render()
end

-- Up/Down walk the list; Enter sets the waypoint to the selection.
function RV.Step(delta)
	local keys = {}
	for _, r in ipairs(listRows) do if r:IsShown() and r.psKey then keys[#keys + 1] = r.psKey end end
	if #keys == 0 then return end
	local at = 0
	for i, k in ipairs(keys) do if k == selected[tab] then at = i end end
	local nxt = keys[max(1, min(#keys, at + (delta or 1)))]
	if nxt then RV.Select(nxt) end
end

function RV.Enter() RV.Waypoint() end

function RV.Select(key)
	selected[tab] = key
	if detail and detail.Scroll then W.ScrollTo(detail.Scroll, 0) end
	RV.Render()
end

function RV.Waypoint()
	local s = detail and detail.psSpawn
	local N = ns.Nav
	if s and N and N.SetTarget then N.SetTarget(s.map, s.x, s.y, detail.psName, s.f) end
end

function RV.LookUp()
	local kind, id = splitKey(detail and detail.psKey)
	local Lookup = ns.Lookup
	if id and Lookup and Lookup.Show then Lookup.Show(nil, kind, id) end
end

function RV.ToggleMute()
	local key = detail and detail.psKey
	if not key then return end
	Rares.Ignore(key, not Rares.IsIgnored(key))
	RV.Render()
end

function RV.Tab() return tab end
function RV.Shown() return shown end

-- kind: "rare" | "treasure" | nil (just open)
function RV.Show(kind, id)
	if kind == "rare" or kind == "treasure" then
		tab = kind
		if id then selected[tab] = Rares.Key(kind, id) end
	end
	local P = UI.Picker
	if UI.ShowPicker then UI.ShowPicker() end
	if P and P.ShowSection then P.ShowSection("Rares") end
	RV.Render()
end

RV.items, RV.places, RV.listRows, RV.heads = items, places, listRows, heads -- the pools, for tests and the preview

ns.On("SHOW_RARES", function(kind, id) RV.Show(kind, id) end)
-- The hub repaints the section and its index (counts) together.
local function repaint()
	if not (root and root:IsVisible()) then return end
	local P = UI.Picker
	if P and P.Render then P.Render() else RV.Render() end
end
ns.On("CODEX_LOADED", repaint)
ns.On("RARES_HISTORY", function() if tab == "seen" then repaint() end end)

if UI.RegisterSection then
	UI.RegisterSection({
		key = "Rares", label = L["Rares"], icon = "qol-target", order = 50,
		build = RV.Build, render = RV.Render,
		nav = RV.Nav, onNav = RV.SetTab,
		search = RV.Search, enter = RV.Enter, step = RV.Step,
		searchPlaceholder = { L["Search rares and treasures"], L["Search rares"], L["Search"] },
	})
end
