-- The guide menu, in the Polestar shell, read in three panes on the shell's
-- grid: the zone art and the tab row end on the one 152 line; text in the
-- middle pane starts at x=32 (a finished guide's check sits in the gutter
-- left of it); the sidebar and the details keep the shell's 24 inset.
--
-- Left: the hub rail (sections, Options at its foot; below), then the
-- sidebar: the search under the wordmark, then the categories with their
-- icons and counts (All, Leveling, Professions, Reputation, Exploration,
-- Legacy, Collectibles, Favorites). A category with no guide for any faction
-- is left out; one empty only for this faction fades and says how to reach
-- its guides. Dungeons have their own hub section, not a category.
-- Middle: tabs (Home: Continue cards for the open tabs and the suggested
-- guides; Browse: the last category or the search; Current: the open tabs;
-- Recent: the last guides loaded), one always active, over one line per
-- guide, "Title (min-max)", a "Group" chip on a guide with group content
-- (elites, dungeons, raids: the compiled `group`; on the Continue cards
-- too), a check on finished guides and a muted "Tab N"
-- on open ones, under small folder headers (leveling by faction and band:
-- "Horde 30-40"; the rest by category). The faction filter sits at the
-- right of the tab row. The header says what the list holds ("Horde · 65
-- guides · 1 open", or the search's result count). The list runs to the
-- window's bottom.
-- Right: the selected guide's details: its zone's art from the client (the
-- night band without it) with the title on it, chips (levels, group,
-- faction, races, classes), progress, the facts (what the guide's goal gives
-- and why: a Class guide's `reward`, item and spell icons with the game's
-- tooltip on hover, and its `why`; steps, the quests this character takes,
-- the zones in route order, what comes next), pitch, pros and cons,
-- the favourite star, "Load guide" (into the current tab) and "Open in new
-- tab"; on an open guide Load reads "Continue" and the new-tab button goes.
--
-- Selecting shows details; loading is explicit: the buttons, a double-click,
-- or Enter in the search box (a row's tooltip says so). Opened from the guide
-- window's + (UI.ShowPicker({ newTab = true })), loading opens a new tab.
--
-- Per character, in CharState().ui: recentGuides (the last 10 guides loaded,
-- newest first, kept on GUIDE_CHANGED), favoriteGuides ({ [id] = true }) and
-- pickerSelected (the last selection).

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, type, ipairs, pairs = math.floor, math.max, math.min, type, ipairs, pairs
local ZoneArt = UI.ZoneArt

local SH = W.SHELL
local WIN_W = 1120 + SH.rail -- the section rail, then the three panes
local DETAIL_W = 372 -- the details pane, right
local MID_W = WIN_W - SH.rail - SH.sidebar - 2 - DETAIL_W -- the list pane, middle
local ROW_X = 12 -- where list rows' grounds start in the middle pane
local TEXT_X = SH.pad - ROW_X -- text inside a row, on the column's x=32 edge
local ROW_H, FOLDER_H, CARD_H, CARD_GAP = 28, 32, 78, 10
local ART_H = SH.top -- the art ends on the tab row's hairline
local DPAD = SH.side -- details pane inset, the sidebar's
local FACT_W, FACT_GAP = 84, 10 -- the facts' label column and row gap
local RECENT_MAX = 10
local SUGGEST_MAX = 5
local DOT = "  \194\183  "
-- "›", not "→": many fonts the window may follow (EllesmereUI's Expressway
-- included) have no arrow glyph and draw a box.
local ARROW, ELLIPSIS = " \226\128\186 ", "\226\128\166"

local P = {}
UI.Picker = P
P.RECENT_MAX = RECENT_MAX

local win, details
local factCache = {} -- guide id -> { quests, zones } (guideFacts)
local folderPool, rowPool, cardPool, segButtons = {}, {}, {}, {}
local query = ""
local category = "All"
local view = "home" -- "home" | "current" | "recent" | "browse"
local newTabMode = false
local visibleIds = {} -- guide ids in the middle pane, top to bottom (arrow keys)

local FACTIONS = { "Alliance", "Horde", "All" }
local VIEWS = { "home", "browse", "current", "recent" }
local VIEW_LABEL = { home = L["Home"], browse = L["Browse"], current = L["Current"], recent = L["Recent"] }

-- The guide format's categories, in the order players look for them.
local CATEGORIES = { "Leveling", "Class", "Professions", "Reputation", "Exploration", "Legacy", "Collectibles" }
P.CATEGORIES = CATEGORIES
local CATEGORY_RANK = {}
for i, c in ipairs(CATEGORIES) do CATEGORY_RANK[c] = i end
local CATEGORY_ICON = {
	Leveling = "icon-level", Class = "icon-train", Professions = "icon-craft", Reputation = "icon-rep", Exploration = "icon-explore",
	Legacy = "icon-achieve", Collectibles = "icon-collect", Favorites = "star",
}
P.CATEGORY_ICON = CATEGORY_ICON

local categoryOf = UI.Category

-- Community guide packs: their guides are not in our categories but under
-- the "Guide packs" heading, one entry per pack (key "pack:<id>"); All,
-- Favorites and search cover every shown guide.
local PACK = "pack:"

-- The community pack a guide (header) comes from; nil for ours (`guides`)
-- and Polestar's internal packs.
local function packOf(g)
	local id = g and g.pack
	if id == nil or id == "guides" then return nil end
	local G = ns.Guides
	local r = G and G.Pack and G.Pack(id)
	if r and not r.internal then return r end
	return nil
end
P.PackOf = packOf

-- Where a guide is listed: its pack's entry, else its category.
local function bucketOf(g)
	local r = packOf(g)
	return r and (PACK .. r.id) or categoryOf(g)
end

-- The pack record behind a "pack:<id>" key, or nil.
local function packOfKey(key)
	if type(key) ~= "string" or key:sub(1, #PACK) ~= PACK then return nil end
	local G = ns.Guides
	return G and G.Pack and G.Pack(key:sub(#PACK + 1)) or nil
end

-- A category's or a pack entry's name. The "Favorites" key is shown as
-- "Favourites".
local function bucketLabel(key)
	if key == "Favorites" then return L["Favourites"] end
	local r = packOfKey(key)
	return r and (r.title or r.id) or L[key]
end

local function categoryLess(a, b)
	local ra, rb = CATEGORY_RANK[a] or 100, CATEGORY_RANK[b] or 100
	if ra ~= rb then return ra < rb end
	return a < b
end

local function factionFilter()
	local f = ns.Get("ui.pickerFaction")
	if f == "auto" or f == nil then f = UI.PlayerFaction() or "All" end
	return f
end

---------------------------------------------------------------------------
-- Character state: recent guides, favourites, the last selection
---------------------------------------------------------------------------

local function uiState()
	local s = ns.CharState()
	local u = s.ui
	if type(u) ~= "table" then
		u = {}
		s.ui = u
	end
	if type(u.recentGuides) ~= "table" then u.recentGuides = {} end
	if type(u.favoriteGuides) ~= "table" then u.favoriteGuides = {} end
	return u
end

function P.Recent() return uiState().recentGuides end

local function remember(id)
	if type(id) ~= "string" then return end
	local list = uiState().recentGuides
	for i = #list, 1, -1 do
		if list[i] == id then table.remove(list, i) end
	end
	table.insert(list, 1, id)
	for i = #list, RECENT_MAX + 1, -1 do list[i] = nil end
end

function P.IsFavorite(id) return id ~= nil and uiState().favoriteGuides[id] == true end

function P.ToggleFavorite(id)
	if not id then return end
	local favs = uiState().favoriteGuides
	favs[id] = (not favs[id]) and true or nil
	P.Render()
end

---------------------------------------------------------------------------
-- Model: the browse list, grouped into folders
---------------------------------------------------------------------------

local function haystack(g)
	local c = categoryOf(g)
	local parts = { g.title or "", g.zoneName or "", c, L[c], g.id or "", g.folder or "" }
	if type(g.keywords) == "table" then
		for _, k in ipairs(g.keywords) do parts[#parts + 1] = k end
	end
	if type(g.races) == "table" then
		for _, r in ipairs(g.races) do parts[#parts + 1] = r; parts[#parts + 1] = UI.RaceName(r) end
	end
	if type(g.classes) == "table" then
		for _, cl in ipairs(g.classes) do parts[#parts + 1] = cl; parts[#parts + 1] = UI.ClassName(cl) end
	end
	return table.concat(parts, " "):lower()
end

local function matches(g, q)
	if q == "" then return true end
	local hay = haystack(g)
	for word in q:gmatch("%S+") do
		if not hay:find(word, 1, true) then return false end
	end
	return true
end

-- A leveling guide's band: the id's band folder ("forever/horde/30-40/..."),
-- else from its first level (1-30, then by tens). -> low, high
local function band(g)
	for lo, hi in (g.id or ""):gmatch("/(%d+)%-(%d+)/") do return tonumber(lo), tonumber(hi) end
	local lv = g.minLevel or 1
	if lv < 30 then return 1, 30 end
	local lo = floor(lv / 10) * 10
	return lo, lo + 10
end
P.Band = band

local FACTION_ORDER = { Alliance = 1, Horde = 2 }

-- The folder a guide is listed under -> label, sort key. A guide's own
-- `folder` wins; guides sharing it still sort by faction, then level.
local function folderOf(g, mine)
	local c = categoryOf(g)
	if type(g.folder) == "string" and g.folder ~= "" then
		return g.folder, string.format("%02d", CATEGORY_RANK[c] or 99) .. c .. "/" .. g.folder
	end
	if c == "Leveling" then
		local lo, hi = band(g)
		local f = g.faction
		local rank = f == nil and 3 or (f == mine and 0 or (FACTION_ORDER[f] or 4))
		local label = (f and ns.FactionName(f) or L["Leveling"]) .. " " .. UI.LevelRange(lo, hi)
		return label, string.format("%02d%d%03d", CATEGORY_RANK.Leveling, rank, lo)
	end
	return L[c], string.format("%02d", CATEGORY_RANK[c] or 99) .. c
end

local function rankOfFaction(f, mine)
	if f == nil then return 3 end
	if f == mine then return 0 end
	return FACTION_ORDER[f] or 4
end

-- filter: faction ("Alliance" | "Horde" | "All"); q: search text; cat: a
-- category, "Favorites" or "All". On the player's own faction only the
-- guides this character can follow are listed (none for other races or
-- classes); the other faction and "All" list every guide.
-- -> entries { kind = "folder"|"guide", text, count, guide },
--    number of guides listed, { [category] = matching guides, Favorites = n }
--    (before the category filter)
function P.Entries(filter, q, cat)
	local G, C = ns.Guides, ns.Compat
	local list = G and G.List and G.List() or {}
	q = (q or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
	cat = cat or "All"
	local mine = UI.PlayerFaction()
	local player
	if filter == mine and G and G.GuideMatches and C and C.GetPlayerInfo then
		local ok, info = pcall(C.GetPlayerInfo)
		if ok and type(info) == "table" then player = info end
	end
	local favs = uiState().favoriteGuides
	local counts, picked = { Favorites = 0 }, {}
	for _, g in ipairs(list) do
		local hit = matches(g, q)
		if hit and favs[g.id] then
			counts.Favorites = counts.Favorites + 1
			if cat == "Favorites" then picked[#picked + 1] = g end
		end
		local okFaction = filter == "All" or g.faction == nil or g.faction == filter
		if okFaction and player and not G.GuideMatches(g, player) then okFaction = false end
		if okFaction and hit then
			local c = bucketOf(g)
			counts[c] = (counts[c] or 0) + 1
			if cat == "All" or c == cat then picked[#picked + 1] = g end
		end
	end
	local key, label = {}, {}
	for _, g in ipairs(picked) do label[g], key[g] = folderOf(g, mine) end
	table.sort(picked, function(a, b)
		if key[a] ~= key[b] then return key[a] < key[b] end
		local fa, fb = rankOfFaction(a.faction, mine), rankOfFaction(b.faction, mine)
		if fa ~= fb then return fa < fb end
		local la, lb = a.minLevel or 0, b.minLevel or 0
		if la ~= lb then return la < lb end
		if categoryOf(a) == "Leveling" then return (a.id or "") < (b.id or "") end
		return (a.title or "") < (b.title or "")
	end)
	local out, folder = {}, nil
	for _, g in ipairs(picked) do
		if label[g] ~= (folder and folder.text) then
			folder = { kind = "folder", text = label[g], count = 0 }
			out[#out + 1] = folder
		end
		folder.count = folder.count + 1
		out[#out + 1] = { kind = "guide", guide = g }
	end
	return out, #picked, counts
end

---------------------------------------------------------------------------
-- Engine glue
---------------------------------------------------------------------------

local function tabsInfo()
	local E = ns.Engine
	if not (E and E.GetTabs) then return nil, nil end
	local ok, tabs, active = pcall(E.GetTabs)
	if not ok or type(tabs) ~= "table" then return nil, nil end
	return tabs, active
end

local function guideState(id)
	local E = ns.Engine
	if not (E and E.GetGuideState) then return nil end
	return E.GetGuideState(id)
end

local function headersById()
	local G = ns.Guides
	local byId = {}
	for _, g in ipairs(G and G.List and G.List() or {}) do byId[g.id] = g end
	return byId
end

-- How to load from the list: a row's tooltip and the empty states.
local function loadHint()
	return newTabMode and L["Double-click a guide or press Enter to open it in a new tab."]
		or L["Double-click a guide or press Enter to load it."]
end

local mapName = ns.Compat.MapName

-- What a guide's steps hold for this character: the quests it accepts
-- (steps and goals filtered by `only`, as the route choice counts them) and
-- the zones its goals visit, in step order (its own zone without any).
-- Cached per guide until guides register again.
local function guideFacts(g)
	local f = factCache[g.id]
	if f then return f end
	f = { quests = 0, zones = {} }
	local G, C = ns.Guides, ns.Compat
	local full = G and G.Get and G.Get(g.id)
	local player
	if C and C.GetPlayerInfo then
		local ok, info = pcall(C.GetPlayerInfo)
		if ok and type(info) == "table" then player = info end
	end
	local fits = G and G.Matches
	local function applies(only)
		if type(only) ~= "table" or not fits then return true end
		return player ~= nil and fits(only, player)
	end
	local seen = {}
	for _, step in ipairs(full and type(full.steps) == "table" and full.steps or {}) do
		if applies(step.only) and type(step.goals) == "table" then
			for _, goal in ipairs(step.goals) do
				if applies(goal.only) then
					if goal.t == "accept" then f.quests = f.quests + 1 end
					local name = mapName(goal.map)
					if name and not seen[name] then
						seen[name] = true
						f.zones[#f.zones + 1] = name
					end
				end
			end
		end
	end
	if #f.zones == 0 then f.zones[1] = UI.GuidePlace(g) end
	if player then factCache[g.id] = f end
	return f
end

-- Where a guide leads: "Title (lo-hi)", or "Your choice: A or B" for a
-- route choice; nil at the end of a line.
local function nextFact(g, byId)
	local function named(id)
		local h = byId[id]
		if not h then return nil end
		local lv = UI.LevelRange(h.minLevel, h.maxLevel)
		return (h.title or id) .. (lv and (" (" .. lv .. ")") or "")
	end
	if type(g.nextChoices) == "table" then
		local ids = {}
		for _, id in ipairs(g.nextChoices) do if byId[id] then ids[#ids + 1] = id end end
		if #ids > 1 then
			local titles = {}
			for i, id in ipairs(ids) do titles[i] = byId[id].title or id end
			local last = table.remove(titles)
			return string.format(L["Your choice: %s or %s"], table.concat(titles, ", "), last)
		elseif #ids == 1 then
			return named(ids[1])
		end
	end
	return g.next and named(g.next) or nil
end

local function load(id, inNewTab)
	local E = ns.Engine
	if not (E and id) then return end
	if inNewTab and E.OpenTab then
		if not E.OpenTab(id) then
			ns.Print(L["Six tabs is the limit. Close one to open another."])
			return
		end
	elseif E.SetGuide then
		E.SetGuide(id)
	end
	ns.Set("ui.shown", true)
	if win then win:Hide() end
end
P.Load = load

function P.Selected() return uiState().pickerSelected end

function P.Select(id)
	uiState().pickerSelected = id
	P.Render()
end

-- The primary action on the selection: continue it where it is open, else
-- load it (into a new tab when the menu came from the guide window's +).
function P.LoadSelected()
	local id = P.Selected()
	if not id then return end
	local tabs = tabsInfo()
	local open = false
	for _, t in ipairs(tabs or {}) do if t.guideId == id then open = true end end
	load(id, newTabMode and not open)
end

-- "Suggested for you": every leveling guide for the player's level, best
-- first (Guides.Suggestions), open ones included (their row says "Tab N"),
-- so the list always answers "what fits me now"; then where the open tabs
-- lead (`next` and route choices) once the player is within two levels of
-- them (a level 2 player in a 1-12 guide is not sent on to a 12-19 one).
-- Finished guides are left out.
local FOLLOW_REACH = 2 -- levels below a follow-up's minimum at which it shows

local function suggestions(byId, tabs, openIndex)
	local G, C = ns.Guides, ns.Compat
	local level
	if C and C.GetPlayerInfo then
		local ok, info = pcall(C.GetPlayerInfo)
		if ok and type(info) == "table" then level = info.level end
	end
	local out, seen = {}, {}
	local function add(id, followUp)
		if #out >= SUGGEST_MAX or not id or seen[id] or not byId[id] then return end
		if followUp and (openIndex[id] or (level and level + FOLLOW_REACH < (byId[id].minLevel or 1))) then return end
		seen[id] = true
		if guideState(id) == "done" then return end
		out[#out + 1] = byId[id]
	end
	for _, id in ipairs(G and G.Suggestions and G.Suggestions() or {}) do add(id) end
	for _, t in ipairs(tabs or {}) do
		local h = byId[t.guideId]
		if h then
			add(h.next, true)
			if type(h.nextChoices) == "table" then for _, c in ipairs(h.nextChoices) do add(c, true) end end
		end
	end
	return out
end

---------------------------------------------------------------------------
-- Middle pane: folders, guide lines, Continue cards
---------------------------------------------------------------------------

local function folderRow(i)
	local f = folderPool[i]
	if f then return f end
	f = CreateFrame("Frame", nil, win.Body)
	f:SetHeight(FOLDER_H)
	f.Text = W.Text(f, "label", "textMuted")
	f.Text:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", TEXT_X, 7)
	f.Count = W.Text(f, "number", "textMuted")
	f.Count:SetJustifyH("RIGHT")
	f.Count:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -TEXT_X, 7)
	f.Rule = W.Divider(f, false, 0.7)
	f.Rule:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", TEXT_X, 0)
	f.Rule:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -TEXT_X, 0)
	folderPool[i] = f
	return f
end

local function rowClick(self)
	if self.psGuide then P.Select(self.psGuide.id) end
end

local function rowDoubleClick(self)
	if not self.psGuide then return end
	uiState().pickerSelected = self.psGuide.id
	P.LoadSelected()
end

local function guideRow(i)
	local r = rowPool[i]
	if r then return r end
	r = CreateFrame("Button", nil, win.Body)
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
	-- A finished guide's check, in the gutter left of the text edge.
	r.Check = W.Tex(r, "ARTWORK", "check", "success")
	r.Check:SetSize(12, 12)
	r.Check:SetPoint("CENTER", r, "LEFT", TEXT_X / 2, 0)
	r.Title = W.Text(r, "body", "text")
	r.Title:SetPoint("LEFT", r, "LEFT", TEXT_X, 0)
	r.Range = W.Text(r, "body", "textMuted")
	r.Range:SetPoint("LEFT", r.Title, "RIGHT", 5, 0)
	-- A guide with group content (compiled `group`): "Group" after the range.
	r.Group = W.Chip(r)
	r.Group:SetPoint("LEFT", r.Range, "RIGHT", 6, 0)
	r.Group:Hide()
	-- An open guide's tab ("Tab 2", "Tab 2 · 25%").
	r.Note = W.Text(r, "small", "textMuted")
	r.Note:SetJustifyH("RIGHT")
	r.Note:SetPoint("RIGHT", r, "RIGHT", -TEXT_X, 0)
	r:SetScript("OnClick", rowClick)
	r:SetScript("OnDoubleClick", rowDoubleClick)
	r:SetScript("OnEnter", W.SimpleTip)
	r:SetScript("OnLeave", W.HideTip)
	rowPool[i] = r
	return r
end

-- note: the right-hand text ("Tab 2", "Tab 2 · 25%"), or nil.
local function paintRow(r, g, note, width)
	r.psGuide = g
	r.psTip = loadHint()
	local sel = P.Selected() == g.id
	r.Selected:SetShown(sel)
	r.Bar:SetShown(sel)
	local done = guideState(g.id) == "done"
	r.Check:SetShown(done)
	-- A Class guide this character cannot start yet recedes and says when.
	local E = ns.Engine
	local gate = not done and E and E.StartGate and E.StartGate(g.id)
	if gate then
		local when = gate.level and string.format(L["From level %d"], gate.level) or L["Not available yet"]
		note = note and (note .. DOT .. when) or when
	end
	r.Title:SetWidth(0) -- measured below from scratch, as the note
	r.Title:SetText(g.title or g.id)
	W.Color(r.Title, sel and "text" or ((done or gate) and "textDim" or "text"))
	local lv = UI.LevelRange(g.minLevel, g.maxLevel)
	r.Range:SetText(lv and ("(" .. lv .. ")") or "")
	local groupW = g.group == true and (W.SetChip(r.Group, L["Group"], "dungeon") + 6) or 0
	r.Group:SetShown(groupW > 0)
	-- A pack's guide carries its pack's title, except in that pack's own list.
	local pack = packOf(g)
	if pack and not (view == "browse" and category == PACK .. pack.id) then
		note = note and (note .. DOT .. (pack.title or pack.id)) or (pack.title or pack.id)
	end
	-- A pooled row keeps its last note's width, and GetStringWidth includes
	-- truncation: measure from an unbounded width.
	r.Note:SetWidth(0)
	r.Note:SetText(note or "")
	-- The note never takes more than 45% of the row: a long pack title is cut.
	local noteW = note and min(floor(r.Note:GetStringWidth() + 1), floor(width * 0.45)) or 0
	r.Note:SetWidth(noteW)
	local room = width - TEXT_X * 2 - (note and (noteW + 12) or 0) - (lv and (r.Range:GetStringWidth() + 5) or 0) - groupW
	r.Title:SetWidth(max(40, min(room, floor(r.Title:GetStringWidth() + 1))))
	r:SetWidth(width)
end

local function card(i)
	local c = cardPool[i]
	if c then return c end
	c = CreateFrame("Button", nil, win.Body)
	c:SetHeight(CARD_H)
	Theme.Skin(c, "button")
	c.Ring = W.Tex(c, "OVERLAY", "white", "accent")
	c.Ring:SetHeight(1)
	c.Ring:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
	c.Ring:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, 0)
	c.Icon = c:CreateTexture(nil, "ARTWORK")
	c.Icon:SetSize(14, 14)
	c.Icon:SetPoint("TOPLEFT", c, "TOPLEFT", TEXT_X, -13)
	c.Title = W.Text(c, "body", "text")
	c.Title:SetPoint("LEFT", c.Icon, "RIGHT", 8, 0)
	-- The tab it is open in, level with the title.
	c.Note = W.Text(c, "small", "textMuted")
	c.Note:SetJustifyH("RIGHT")
	c.Note:SetPoint("RIGHT", c, "TOPRIGHT", -TEXT_X, -20)
	-- A guide with group content: "Group" left of the tab.
	c.Group = W.Chip(c)
	c.Group:SetPoint("RIGHT", c.Note, "LEFT", -8, 0)
	c.Group:Hide()
	c.Step = W.Text(c, "small", "textDim")
	c.Step:SetPoint("TOPLEFT", c, "TOPLEFT", TEXT_X, -38)
	c.Pct = W.Text(c, "number", "textDim")
	c.Pct:SetJustifyH("RIGHT")
	c.Pct:SetPoint("TOPRIGHT", c, "TOPRIGHT", -TEXT_X, -38)
	c.Line = W.ProgressLine(c, 2)
	c.Line:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", TEXT_X, 14)
	c.Line:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", -TEXT_X, 14)
	c:SetScript("OnClick", rowClick)
	c:SetScript("OnDoubleClick", rowDoubleClick)
	c:SetScript("OnEnter", W.SimpleTip)
	c:SetScript("OnLeave", W.HideTip)
	cardPool[i] = c
	return c
end

local function layoutCards(tabs, active, byId, y)
	local per = 2
	local x0 = ROW_X
	local cw = floor((MID_W - x0 * 2 - CARD_GAP * (per - 1)) / per)
	for i, t in ipairs(tabs) do
		local c = card(i)
		c.psIndex = i
		c.psGuide = byId[t.guideId] or { id = t.guideId, title = t.title }
		c.psTip = loadHint()
		local sel = P.Selected() == t.guideId
		c.Ring:SetShown(sel)
		c.Icon:SetTexture(Theme.Media(CATEGORY_ICON[t.category] or "icon-level"))
		W.Color(c.Icon, i == active and "accent" or "textDim")
		c.Title:SetText(t.title or t.guideId)
		local total = t.total or t.stepCount or 0
		if t.complete then
			c.Step:SetText(ns.LC("guide status", "Completed"))
		elseif t.stepIndex then
			c.Step:SetText(string.format(L["Step %d of %d"], t.stepIndex, t.stepCount or 0))
		else
			c.Step:SetText("")
		end
		local frac = total > 0 and (t.done or 0) / total or 0
		c.Pct:SetText(floor(frac * 100 + 0.5) .. "%")
		c:SetWidth(cw)
		W.SetProgress(c.Line, frac, cw - TEXT_X * 2)
		c.Note:SetText(string.format(L["Tab %d"], i))
		local groupW = c.psGuide.group == true and (W.SetChip(c.Group, L["Group"], "dungeon") + 8) or 0
		c.Group:SetShown(groupW > 0)
		local room = cw - TEXT_X * 2 - 14 - 8 - c.Note:GetStringWidth() - 8 - groupW
		c.Title:SetWidth(max(40, floor(room)))
		local col, line = (i - 1) % per, floor((i - 1) / per)
		c:ClearAllPoints()
		c:SetPoint("TOPLEFT", win.Body, "TOPLEFT", x0 + col * (cw + CARD_GAP), -(y + line * (CARD_H + CARD_GAP)))
		c:Show()
	end
	for i = #tabs + 1, #cardPool do cardPool[i]:Hide() end
	local lines = floor((#tabs + per - 1) / per)
	return y + lines * (CARD_H + CARD_GAP)
end

---------------------------------------------------------------------------
-- Right pane: details
---------------------------------------------------------------------------

local function detailChip(i)
	local c = details.Chips[i]
	if c then return c end
	c = W.Chip(details)
	details.Chips[i] = c
	return c
end

local function bullet(list, i, glyph, color, textColor, size)
	local b = list[i]
	if not b then
		local parent = details.Scroll.Child
		b = {}
		b.Glyph = W.Tex(parent, "ARTWORK", glyph, color)
		b.Glyph:SetSize(size, size)
		b.Text = W.Text(parent, "note", textColor)
		b.Text:SetWordWrap(true)
		b.Text:SetJustifyV("TOP")
		list[i] = b
	end
	return b
end

-- One fact: a muted label in a fixed column, the value beside it.
local function factRow(i)
	local f = details.Facts[i]
	if f then return f end
	f = {}
	f.Label = W.Text(details, "small", "textMuted")
	f.Label:SetWidth(FACT_W - 8) -- 8px clear of the value; a long label wraps
	f.Label:SetWordWrap(true)
	f.Label:SetJustifyH("LEFT")
	f.Label:SetJustifyV("TOP")
	f.Value = W.Text(details, "note", "text")
	f.Value:SetWidth(DETAIL_W - DPAD * 2 - FACT_W)
	f.Value:SetJustifyH("LEFT")
	f.Value:SetJustifyV("TOP")
	f.Value:SetWordWrap(true)
	details.Facts[i] = f
	return f
end

-- The guide's reward: one tile per entry in the facts' value column, an
-- item or spell icon (a glyph for words) and its name; items in their
-- quality's colour and border. Hovering shows the game's item or spell
-- tooltip, a modified click acts as on any item or spell button
-- (W.ItemClick, W.SpellClick); the pane asks for the items and spells as it
-- paints them, so the first hover usually finds them cached.
local REWARD_H, REWARD_GAP = 22, 4

local function rewardEnter(self)
	local e = self.psReward
	if not e then return end
	if e.item then
		W.ItemTip(self, e.item)
	elseif e.spell then
		W.SpellTip(self, e.spell)
	end
end

local function rewardClick(self)
	local e = self.psReward
	if not e then return end
	if e.item then
		W.ItemClick(e.item)
	elseif e.spell then
		W.SpellClick(e.spell)
	end
end

local function rewardTile(i)
	local t = details.Rewards[i]
	if t then return t end
	t = CreateFrame("Button", nil, details)
	t:SetSize(DETAIL_W - DPAD * 2 - FACT_W, REWARD_H)
	W.Hover(t)
	t.Well = CreateFrame("Frame", nil, t)
	t.Well:SetSize(REWARD_H, REWARD_H)
	t.Well:SetPoint("LEFT", t, "LEFT", 0, 0)
	t.Well.Ground = W.Fill(t.Well, "scrim", "BACKGROUND", 0)
	t.Icon = t.Well:CreateTexture(nil, "ARTWORK")
	t.Icon:SetPoint("TOPLEFT", t.Well, "TOPLEFT", 1, -1)
	t.Icon:SetPoint("BOTTOMRIGHT", t.Well, "BOTTOMRIGHT", -1, 1)
	t.Name = W.Text(t, "note", "text")
	t.Name:SetPoint("LEFT", t.Well, "RIGHT", 8, 0)
	t.Name:SetWidth(DETAIL_W - DPAD * 2 - FACT_W - REWARD_H - 8)
	t:SetScript("OnEnter", rewardEnter)
	t:SetScript("OnLeave", W.HideTip)
	t:SetScript("OnClick", rewardClick)
	details.Rewards[i] = t
	return t
end

-- "ffrrggbb" -> r, g, b (0-1).
local function hexRGB(hex)
	local r, g, b = hex:match("^%x%x(%x%x)(%x%x)(%x%x)$")
	if not r then return nil end
	return tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255
end

-- Paints tile t for reward entry e -> the name shown.
local function paintReward(t, e)
	local C = ns.Compat
	t.psReward = e
	local icon, name, hex
	if e.item then
		W.PrefetchItem(e.item)
		icon = C.ItemIcon and C.ItemIcon(e.item)
		name = ns.Names.Item(e.item) or e.itemName or (L["Item"] .. " " .. e.item)
		local q = (C.GetItemQuality and C.GetItemQuality(e.item)) or e.quality
		hex = q and C.ItemQualityHex and C.ItemQualityHex(q)
	elseif e.spell then
		W.PrefetchSpell(e.spell)
		icon = C.SpellIcon and C.SpellIcon(e.spell)
		name = ns.Names.Spell(e.spell) or e.spellName or (L["Spell"] .. " " .. e.spell)
	else
		name = e.text or ""
	end
	if icon then
		t.Icon:SetTexture(icon)
		t.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		W.Uncolor(t.Icon)
		t.Icon:SetVertexColor(1, 1, 1, 1)
	else
		t.Icon:SetTexture(Theme.Media(e.item and "icon-collect" or "icon-train"))
		t.Icon:SetTexCoord(0, 1, 0, 1)
		W.Color(t.Icon, "textMuted")
	end
	local r, g, b = hexRGB(hex or "")
	if r then
		Theme.Border(t.Well, r, g, b, 0.9)
		W.Uncolor(t.Name)
		t.Name:SetTextColor(Theme.Legible(r, g, b))
	else
		local br, bg, bb = Theme.Wash("border")
		Theme.Border(t.Well, br, bg, bb, 0.6)
		W.Color(t.Name, e.item and "item" or "text")
	end
	t.Name:SetText(name)
	return name
end

-- The zones in route order, as many as fit on two lines ("A › B › …").
local function fitZones(fs, zones)
	for k = #zones, 1, -1 do
		local text = table.concat(zones, ARROW, 1, k)
		if k < #zones then text = text .. ARROW .. ELLIPSIS end
		fs:SetText(text)
		if fs:GetNumLines() <= 2 then return end
	end
end

local function buildDetails()
	local d = CreateFrame("Frame", nil, win.Main)
	details = d
	P.details = d
	d:SetPoint("TOPRIGHT", win.Main, "TOPRIGHT", 0, 0)
	d:SetPoint("BOTTOMRIGHT", win.Main, "BOTTOMRIGHT", 0, 0)
	d:SetWidth(DETAIL_W)
	d:SetFrameLevel(win.Content:GetFrameLevel() + 6)
	d:EnableMouse(true)
	W.Fill(d, "panel")
	local rule = W.Divider(d, true)
	rule:SetPoint("TOPLEFT", d, "TOPLEFT", 0, 0)
	rule:SetPoint("BOTTOMLEFT", d, "BOTTOMLEFT", 0, 0)
	local inner = DETAIL_W - DPAD * 2

	d.Art = ZoneArt.Create(d, DETAIL_W, ART_H, "panel")
	d.Art.psZoom = 1.5 -- the wider band shows more of the zone
	d.Art:SetPoint("TOPLEFT", d, "TOPLEFT", 0, 0)
	d.Art:EnableMouse(true)
	d.Art:RegisterForDrag("LeftButton")
	d.Art:SetScript("OnDragStart", function() win:StartMoving() end)
	d.Art:SetScript("OnDragStop", function() win:StopMovingOrSizing() end)
	-- The window's close button moves to the art's corner, where the shell
	-- keeps it; the star beside it.
	win.Close:SetParent(d.Art.Over)
	win.Close:ClearAllPoints()
	win.Close:SetPoint("TOPRIGHT", d.Art, "TOPRIGHT", -12, -12)
	d.Star = W.IconButton(d.Art.Over, "star", 28, L["Add to favourites"], function()
		P.ToggleFavorite(P.Selected())
	end, 14)
	d.Star:SetPoint("RIGHT", win.Close, "LEFT", -4, 0)
	-- On a bright painting the two glyphs need a dark ground of their own:
	-- 4 past the pair at either end, 2 above and below.
	d.Scrim = W.Pill(d.Art.Over, 68, 32)
	d.Scrim:SetPoint("TOPRIGHT", win.Close, "TOPRIGHT", 4, 2)
	W.Painter(d.Scrim, function(p)
		local r, g, b = Theme.Color("scrim")
		p:SetColor(r, g, b, 0.6)
	end)
	d.Scrim:SetFrameLevel(d.Art.Over:GetFrameLevel())
	win.Close:SetFrameLevel(d.Scrim:GetFrameLevel() + 2)
	d.Star:SetFrameLevel(d.Scrim:GetFrameLevel() + 2)
	d.Title = W.Text(d.Art.Over, "display", "text")
	d.Title:SetPoint("BOTTOMLEFT", d.Art, "BOTTOMLEFT", DPAD, 14)
	d.Title:SetWidth(inner)
	W.Painter(d.Title, function(fs)
		local r, g, b = Theme.Color("shade")
		fs:SetShadowOffset(0, -1)
		fs:SetShadowColor(r, g, b, 0.85)
	end)

	d.Chips = {}
	d.ProgLabel = W.Text(d, "small", "textDim")
	d.ProgPct = W.Text(d, "number", "textDim")
	d.ProgPct:SetJustifyH("RIGHT")
	d.Prog = W.ProgressLine(d, 2)
	d.Prog:SetWidth(inner)
	-- The facts, under a hairline (factRow).
	d.FactRule = W.Divider(d)
	d.Facts = {}
	d.Rewards = {}
	-- Credits under the facts: who wrote it and, for a pack's guide, the
	-- pack; the pack's source on its own line.
	d.Credits = W.Text(d, "small", "textMuted")
	d.Credits:SetWordWrap(true)
	d.Credits:SetJustifyH("LEFT")
	d.Credits:SetWidth(inner)
	d.Source = W.Text(d, "note", "textDim")
	d.Source:SetWordWrap(true)
	d.Source:SetJustifyH("LEFT")
	d.Source:SetWidth(inner)

	-- Pitch, pros and cons scroll between the facts and the buttons.
	d.Scroll = W.Scroll(d)
	d.Pitch = W.Text(d.Scroll.Child, "note", "textDim")
	d.Pitch:SetWordWrap(true)
	d.Pitch:SetJustifyV("TOP")
	d.Pitch:SetWidth(inner)
	d.Pros, d.Cons = {}, {}

	-- Load: into the current tab; Continue on a guide already open.
	d.Load = W.Button(d, L["Load guide"], function() load(P.Selected(), false) end, { primary = true, height = 32 })
	d.NewTab = W.Button(d, L["Open in new tab"], function() load(P.Selected(), true) end, { height = 32, icon = "plus" })
	d.NewTab:SetPoint("BOTTOMRIGHT", d, "BOTTOMRIGHT", -DPAD, DPAD)
	d.Load:SetPoint("BOTTOMLEFT", d, "BOTTOMLEFT", DPAD, DPAD)

	-- Nothing selected yet.
	d.EmptyTitle = W.Text(d, "display", "text")
	d.EmptyTitle:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -(ART_H + 24))
	d.EmptyTitle:SetText(L["Choose a guide"])
	d.EmptyNote = W.Text(d, "note", "textDim")
	d.EmptyNote:SetWordWrap(true)
	d.EmptyNote:SetJustifyV("TOP")
	d.EmptyNote:SetWidth(inner)
	d.EmptyNote:SetPoint("TOPLEFT", d.EmptyTitle, "BOTTOMLEFT", 0, -10)
	d.EmptyNote:SetText(L["Select a guide to see where it goes, then load it."])
end

-- A stable stretch of night sky per guide, so neighbours never look cloned.
local function skyIndex(id)
	local n = 0
	for i = 1, #id do n = (n * 31 + id:byte(i)) % 997 end
	return n + 1
end

local function setButtonWidth(b, w)
	b.psFixedWidth = w
	W.SetButtonText(b, b.Label:GetText())
end

local function setPrimary(b, on)
	b.psPrimary = on
	Theme.Repaint(b)
	W.RepaintButton(b)
end

-- A guide's credits: "By <author>" for ours; for a pack's guide "By
-- <author> · <pack title> <version> · <licence>". The author is the guide's
-- own, else its pack's. -> text or nil, the pack's source or nil
function P.Credits(g)
	if not g then return nil end
	local G = ns.Guides
	local own = g.pack and G and G.Pack and G.Pack(g.pack) or nil
	local author = type(g.author) == "string" and g.author ~= "" and g.author or (own and own.author)
	local pack = packOf(g)
	local parts = {}
	if author then parts[1] = string.format(L["By %s"], author) end
	if pack then
		parts[#parts + 1] = (pack.title or pack.id) .. (pack.version and (" " .. pack.version) or "")
		if pack.license then parts[#parts + 1] = pack.license end
	end
	if #parts == 0 then return nil end
	return table.concat(parts, DOT), pack and pack.source or nil
end

local function renderDetails(byId, tabs, active)
	local d = details
	local inner = DETAIL_W - DPAD * 2
	local id = P.Selected()
	local g = id and byId[id]
	local E = ns.Engine
	local parts = { d.Star, d.Title, d.ProgLabel, d.ProgPct, d.Prog, d.FactRule, d.Scroll, d.Load, d.NewTab, d.Credits, d.Source }
	if not g then
		d.psArt = ZoneArt.Paint(d.Art, nil, nil, nil, 1)
		for _, p in ipairs(parts) do p:Hide() end
		for _, c in ipairs(d.Chips) do c:Hide() end
		for _, f in ipairs(d.Facts) do
			f.Label:Hide()
			f.Value:Hide()
		end
		for _, t in ipairs(d.Rewards) do t:Hide() end
		d.EmptyTitle:Show()
		d.EmptyNote:Show()
		P.detail = nil
		return
	end
	d.EmptyTitle:Hide()
	d.EmptyNote:Hide()
	for _, p in ipairs(parts) do p:Show() end
	local fx, fy
	if E and E.GuideFocus then fx, fy = E.GuideFocus(g.id) end
	d.psArt = ZoneArt.Paint(d.Art, g.zone, fx, fy, skyIndex(g.id))
	local fav = P.IsFavorite(g.id)
	W.SetIconState(d.Star, fav)
	d.Star.psTip = fav and L["Remove from favourites"] or L["Add to favourites"]
	d.Title:SetText(g.title or g.id)

	-- Chips: levels, group content, faction, races, classes; on two lines at most.
	local y = ART_H + 16
	local n, x, line, full = 0, DPAD, 0, false
	local function addChip(text, kind)
		if full then return end
		local c = detailChip(n + 1)
		local w = W.SetChip(c, text, kind)
		if x > DPAD and x + w > DPAD + inner then
			if line == 1 then
				c:Hide()
				full = true
				return
			end
			line, x = 1, DPAD
		end
		n = n + 1
		c:ClearAllPoints()
		c:SetPoint("TOPLEFT", d, "TOPLEFT", x, -(y + line * (W.CHIP_H + 6)))
		x = x + w + 6
	end
	local lv = UI.LevelRange(g.minLevel, g.maxLevel)
	if lv then addChip(L["Levels"] .. " " .. lv, "accent") end
	if g.group == true then addChip(L["Group"], "dungeon") end
	addChip(ns.FactionName(g.faction) or L["Both factions"])
	if type(g.races) == "table" then for _, race in ipairs(g.races) do addChip(UI.RaceName(race)) end end
	if type(g.classes) == "table" then for _, cl in ipairs(g.classes) do addChip(UI.ClassName(cl)) end end
	for i = n + 1, #d.Chips do d.Chips[i]:Hide() end
	y = y + (line + 1) * W.CHIP_H + line * 6 + 16

	-- Progress: GetGuideState, plus the tab's step when it is open.
	local state, done, total = guideState(g.id)
	local tabIndex, tab
	for i, t in ipairs(tabs or {}) do if t.guideId == g.id then tabIndex, tab = i, t end end
	local label
	if state == "done" then
		label = L["Finished"]
	elseif tab then
		label = tab.stepIndex and string.format(L["Open in tab %d  \194\183  step %d of %d"], tabIndex, tab.stepIndex, tab.stepCount or 0)
			or string.format(L["Open in tab %d"], tabIndex)
	elseif state == "started" then
		label = L["Started"]
	else
		label = L["Not started"]
	end
	local frac
	if total and total > 0 then frac = (done or 0) / total elseif state == "done" then frac = 1 end
	d.ProgLabel:SetText(label)
	d.ProgLabel:ClearAllPoints()
	d.ProgLabel:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -y)
	-- Nothing done yet: the label alone; an empty track would only double the
	-- facts rule under it.
	local started = frac and frac > 0
	d.ProgPct:SetText(started and (floor(frac * 100 + 0.5) .. "%") or "")
	d.ProgPct:ClearAllPoints()
	d.ProgPct:SetPoint("TOPRIGHT", d, "TOPRIGHT", -DPAD, -y)
	d.Prog:ClearAllPoints()
	d.Prog:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -(y + 20))
	W.SetProgress(d.Prog, frac or 0, inner)
	d.Prog:SetShown(started and true or false)
	y = y + (started and (20 + 2) or 14) + 16

	-- Facts: what the guide's goal gives and why (a Class guide's `reward`
	-- and `why`), then steps, the quests this character takes, the zones in
	-- route order, where the guide leads. Reward entries are tiles: those
	-- given outright under "Reward", a choice under "Choose one".
	local facts, info = {}, guideFacts(g)
	if type(g.reward) == "table" then
		local get, choose = {}, {}
		for _, e in ipairs(g.reward) do
			if type(e) == "table" then
				local list = e.choice and choose or get
				list[#list + 1] = e
			end
		end
		if #get > 0 then facts[#facts + 1] = { L["Reward"], rewards = get } end
		if #choose > 0 then facts[#facts + 1] = { L["Choose one"], rewards = choose } end
	end
	if type(g.why) == "string" and g.why ~= "" then facts[#facts + 1] = { L["Why"], g.why } end
	if g.stepCount then facts[#facts + 1] = { L["Steps"], tostring(g.stepCount) } end
	if info.quests > 0 then facts[#facts + 1] = { L["Quests"], tostring(info.quests) } end
	if #info.zones > 0 then facts[#facts + 1] = { L["Zones"], info.zones, "textDim" } end
	local nextText = nextFact(g, byId)
	if nextText then facts[#facts + 1] = { L["Next"], nextText, "textDim" } end
	d.FactRule:ClearAllPoints()
	d.FactRule:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -y)
	d.FactRule:SetPoint("TOPRIGHT", d, "TOPRIGHT", -DPAD, -y)
	d.FactRule:SetShown(#facts > 0)
	local shownFacts, shownRewards, nTiles = {}, {}, 0
	if #facts > 0 then y = y + 1 + 16 end
	-- The label column: FACT_W, or wider by what a label's longest word
	-- needs ("Choisissez-en"), so a label wraps between words only.
	local factW = FACT_W
	for i, f in ipairs(facts) do
		for word in f[1]:gmatch("%S+") do factW = max(factW, math.ceil(W.TextWidth(factRow(i).Label, word)) + 8) end
	end
	local valueW = DETAIL_W - DPAD * 2 - factW
	for i, f in ipairs(facts) do
		local row = factRow(i)
		row.Label:SetWidth(factW - 8)
		row.Label:SetText(f[1])
		row.Label:ClearAllPoints()
		row.Label:Show()
		row.Value:SetWidth(valueW)
		if f.rewards then
			-- The label sits on the first tile's text line.
			row.Label:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -(y + (REWARD_H - row.Label:GetStringHeight()) / 2))
			row.Value:Hide()
			local names = {}
			for k, e in ipairs(f.rewards) do
				nTiles = nTiles + 1
				local t = rewardTile(nTiles)
				t:SetWidth(valueW)
				t.Name:SetWidth(valueW - REWARD_H - 8)
				t:ClearAllPoints()
				t:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD + factW, -y)
				names[k] = paintReward(t, e)
				shownRewards[#shownRewards + 1] = { kind = e.item and "item" or e.spell and "spell" or "text", id = e.item or e.spell, name = names[k], choice = e.choice and true or nil }
				t:Show()
				y = y + REWARD_H + (k < #f.rewards and REWARD_GAP or 0)
			end
			y = y + FACT_GAP
			shownFacts[i] = { f[1], table.concat(names, ", ") }
		else
			W.Color(row.Value, f[3] or "text")
			if type(f[2]) == "table" then fitZones(row.Value, f[2]) else row.Value:SetText(f[2]) end
			row.Label:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -(y + 1))
			row.Value:ClearAllPoints()
			row.Value:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD + factW, -y)
			row.Value:Show()
			y = y + max(row.Value:GetStringHeight(), row.Label:GetStringHeight()) + FACT_GAP
			shownFacts[i] = { f[1], row.Value:GetText() }
		end
	end
	for i = #facts + 1, #d.Facts do
		d.Facts[i].Label:Hide()
		d.Facts[i].Value:Hide()
	end
	for i = nTiles + 1, #d.Rewards do d.Rewards[i]:Hide() end
	if #facts > 0 then y = y - FACT_GAP + 20 end

	-- Credits, and the pack's source.
	local credits, source = P.Credits(g)
	d.Credits:SetShown(credits ~= nil)
	d.Source:SetShown(source ~= nil)
	if credits then
		d.Credits:SetText(credits)
		d.Credits:ClearAllPoints()
		d.Credits:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -y)
		y = y + d.Credits:GetStringHeight() + 6
	end
	if source then
		d.Source:SetText("\226\128\156" .. source .. "\226\128\157")
		d.Source:ClearAllPoints()
		d.Source:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -y)
		y = y + d.Source:GetStringHeight() + 6
	end
	if credits or source then y = y + 10 end

	-- Pitch, pros, cons.
	local bottom = DPAD + 32 + 16
	d.Scroll:ClearAllPoints()
	d.Scroll:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -y)
	d.Scroll:SetPoint("BOTTOMRIGHT", d, "BOTTOMRIGHT", -DPAD + 10, bottom)
	local child = d.Scroll.Child
	child:SetWidth(inner)
	local cy = 0
	if type(g.pitch) == "string" and g.pitch ~= "" then
		d.Pitch:SetText(g.pitch)
		d.Pitch:ClearAllPoints()
		d.Pitch:SetPoint("TOPLEFT", child, "TOPLEFT", 0, -cy)
		d.Pitch:Show()
		cy = cy + d.Pitch:GetStringHeight() + 14
	else
		d.Pitch:Hide()
	end
	local function lines(list, items, glyph, color, textColor, size)
		local k = 0
		for i, text in ipairs(type(items) == "table" and items or {}) do
			local b = bullet(list, i, glyph, color, textColor, size)
			b.Glyph:ClearAllPoints()
			b.Glyph:SetPoint("TOPLEFT", child, "TOPLEFT", (12 - size) / 2, -(cy + 2 + (12 - size) / 2))
			b.Text:SetText(text)
			b.Text:SetWidth(inner - 20)
			b.Text:ClearAllPoints()
			b.Text:SetPoint("TOPLEFT", child, "TOPLEFT", 20, -cy)
			b.Glyph:Show()
			b.Text:Show()
			cy = cy + b.Text:GetStringHeight() + 7
			k = i
		end
		for i = k + 1, #list do
			list[i].Glyph:Hide()
			list[i].Text:Hide()
		end
		return k
	end
	local pros = lines(d.Pros, g.pros, "check", "success", "text", 12)
	if pros > 0 and type(g.cons) == "table" and #g.cons > 0 then cy = cy + 4 end
	lines(d.Cons, g.cons, "cross", "textMuted", "textDim", 9)
	W.SetScrollContent(d.Scroll, cy + 8, win:GetHeight() - y - bottom)
	W.ScrollTo(d.Scroll, 0)

	-- Buttons: Load and Open in new tab; on a guide already open, Continue
	-- alone at full width.
	local hasTabs = E and E.OpenTab and true or false
	W.SetButtonText(d.Load, tab and L["Continue"] or L["Load guide"])
	d.Load.psTip = tab and string.format(L["Switch to tab %d."], tabIndex) or L["Load into the current tab."]
	if hasTabs and not tab then
		d.NewTab:Show()
		setButtonWidth(d.NewTab, nil)
		setButtonWidth(d.Load, inner - d.NewTab:GetWidth() - 8)
		setPrimary(d.Load, not newTabMode)
		setPrimary(d.NewTab, newTabMode)
	else
		d.NewTab:Hide()
		setButtonWidth(d.Load, inner)
		setPrimary(d.Load, true)
	end
	P.detail = { id = g.id, art = d.psArt, state = state, tab = tabIndex, label = label, frac = frac, facts = shownFacts,
		reward = #shownRewards > 0 and shownRewards or nil, credits = credits, source = source }
end

---------------------------------------------------------------------------
-- Render
---------------------------------------------------------------------------

-- The categories: one with no guide for any faction is left out (one empty
-- only for this faction stays, faded by ShellNav).
local function navItems(counts, total)
	local exists, packs, seen = {}, {}, {}
	for _, g in ipairs(ns.Guides and ns.Guides.List and ns.Guides.List() or {}) do
		local r = packOf(g)
		if not r then
			exists[categoryOf(g)] = true
		elseif not seen[r.id] then
			seen[r.id] = true
			packs[#packs + 1] = r
		end
	end
	local items = { { key = "All", label = L["All guides"], icon = "compact", count = total } }
	for _, c in ipairs(CATEGORIES) do
		if exists[c] then items[#items + 1] = { key = c, label = L[c], icon = CATEGORY_ICON[c], count = counts[c] or 0 } end
	end
	items[#items + 1] = { key = "Favorites", label = L["Favourites"], icon = CATEGORY_ICON.Favorites, count = counts.Favorites or 0 }
	-- Guide packs: one entry per shown pack with guides, "<title> · <author>".
	if #packs > 0 then
		table.sort(packs, function(a, b) return (a.title or a.id):lower() < (b.title or b.id):lower() end)
		items[#items + 1] = { key = "", heading = true, label = L["Guide packs"] }
		for _, r in ipairs(packs) do
			local label = r.title or r.id
			if r.author then label = label .. DOT .. r.author end
			items[#items + 1] = { key = PACK .. r.id, label = label, icon = "layers", count = counts[PACK .. r.id] or 0 }
		end
	end
	P.categories = {}
	for _, it in ipairs(items) do
		if not it.heading then P.categories[#P.categories + 1] = it.key end
	end
	return items
end

-- A category empty only under this faction says how to reach its guides.
local function navTips(filter)
	for _, b in ipairs(win.navButtons) do
		local tip
		if b:IsShown() and b.psEmpty and query == "" and filter ~= "All" and b.psKey ~= "Favorites" then
			tip = string.format(L["None for %s; switch the filter to All."], ns.FactionName(filter))
		end
		b.psTip = tip
		if tip and not b.psPickerTip then
			b.psPickerTip = true
			b:HookScript("OnEnter", W.SimpleTip)
			b:HookScript("OnLeave", W.HideTip)
		end
	end
end

local function paintSegments(filter)
	for _, b in ipairs(segButtons) do
		local on = b.psKey == filter
		b.Selected:SetShown(on)
		W.Color(b.Label, on and "text" or "textMuted")
	end
end

---------------------------------------------------------------------------
-- The hub (docs/SUITE.md "UI"): sections on a rail at the window's left
-- (icon over label, from the 152 line down; Options at the rail's foot).
-- Guides is the built-in section. The sidebar holds the hub search and the
-- active section's index: the guide categories under Guides, a section's
-- own `nav` under it. A section other than Guides gets one frame spanning
-- the list and details panes under the header band (and its tab row when it
-- sets tabs: W.ShellTabs on the hub is for views inside it).
--
--   UI.RegisterSection({
--     key, label, icon, order,
--     build = fn(parent, hub), render = fn(),
--     nav = fn() -> items, activeKey,  -- optional: its index ({ key, label, icon, count })
--     onNav = fn(key),                 -- with nav: set the state, then UI.Picker.Render()
--     search = fn(text), enter = fn(), step = fn(delta), -- optional: the hub search drives it
--     searchPlaceholder = "...",       -- optional; or a list of wordings, longest first (the first that fits shows)
--   })
---------------------------------------------------------------------------

local GUIDES = { key = "Guides", label = L["Guides"], icon = "guides", order = 10, builtin = true }
local sections, section = { GUIDES }, nil
P.GUIDES = GUIDES.key

function UI.RegisterSection(spec)
	if type(spec) ~= "table" or type(spec.key) ~= "string" or type(spec.build) ~= "function" or type(spec.render) ~= "function" then return false end
	if spec.key == GUIDES.key then return false end
	for i = #sections, 1, -1 do if sections[i].key == spec.key then table.remove(sections, i) end end
	sections[#sections + 1] = spec
	table.sort(sections, function(a, b) return (a.order or 100) < (b.order or 100) end)
	if win and win:IsShown() then P.Render() end
	return true
end

function P.Sections() return sections end
function P.Section() return section or GUIDES.key end

local function activeSection()
	if not section then return nil end
	for _, s in ipairs(sections) do if s.key == section and not s.builtin then return s end end
	return nil
end
P.ActiveSection = activeSection

function P.Query() return query end

-- Show a section ("Guides" or nil: the guide list). The hub search starts
-- empty in every section.
function P.ShowSection(key)
	if key == GUIDES.key then key = nil end
	if key ~= section and win then
		query = ""
		win.Search:SetText("")
	end
	section = key
	if win and win:IsShown() then P.Render() end
end

-- The section `delta` away on the rail (LB / RB on a gamepad).
function P.StepSection(delta)
	local cur = P.Section()
	for i, s in ipairs(sections) do
		if s.key == cur then
			local to = sections[i + delta]
			if to then P.ShowSection(to.key) end
			return
		end
	end
end

-- The hub's search wordings, longest first: the box shows the first that fits.
local HUB_SEARCH = { L["Search guides, items, NPCs"], L["Search guides, items"], L["Search"] }

local function sectionLayout(s)
	local on = s ~= nil
	details:SetShown(not on)
	win.Content:SetShown(not on)
	for _, b in ipairs(segButtons) do b:SetShown(not on) end
	win.Header:ClearAllPoints()
	win.Header:SetPoint("TOPLEFT", win.Main, "TOPLEFT", 0, 0)
	win.Header:SetPoint("TOPRIGHT", win.Main, "TOPRIGHT", on and 0 or -DETAIL_W, 0)
	win.Band:SetTexCoord(Theme.BandCoords(on and (MID_W + DETAIL_W) or MID_W, SH.header))
	win.Close:SetParent(on and win.Header or details.Art.Over)
	win.Close:ClearAllPoints()
	win.Close:SetPoint("TOPRIGHT", on and win.Header or details.Art, "TOPRIGHT", -12, -12)
	if not on then win.Close:SetFrameLevel(details.Scrim:GetFrameLevel() + 2) end
	W.SetSearchPlaceholder(win.Search, (s and s.searchPlaceholder) or (s and s.search and L["Search"]) or HUB_SEARCH)
	win.Search:SetShown(not s or s.search ~= nil)
end

local function renderSection(s)
	if not s.psFrame then
		local f = CreateFrame("Frame", nil, win.Main)
		s.psFrame = f
		s.build(f, win)
	end
	for _, o in ipairs(sections) do
		if o.psFrame then o.psFrame:SetShown(o == s) end
	end
	-- No tabs until the section sets its own (its render may).
	W.ShellTabs(win, nil)
	s.render()
	-- Under the tab row when the section set one, else under the header.
	local f = s.psFrame
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", win.TabRow:IsShown() and win.TabRow or win.Header, "BOTTOMLEFT", 0, 0)
	f:SetPoint("BOTTOMRIGHT", win.Main, "BOTTOMRIGHT", 0, 0)
end

-- The hub's sections as rail items (the settings window shows the same rail).
function P.RailItems()
	local items = {}
	for i, s in ipairs(sections) do items[i] = { key = s.key, label = s.label or s.key, icon = s.icon } end
	return items
end

-- Open `to` where `from` stands when switching between the hub and the
-- settings: their top-left corners meet, so the rail stays put.
function P.TakePlace(to, from)
	local left, top = from:GetLeft(), from:GetTop()
	if not (left and top) then return end
	local k = from:GetEffectiveScale() / to:GetEffectiveScale()
	to:ClearAllPoints()
	to:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left * k, top * k)
end

-- The rail: every section, Options at its foot.
local function renderRail()
	P.railShown = W.ShellRail(win, P.RailItems(), {
		{ key = "Options", label = L["Options"], icon = "sliders", tip = L["Options"],
			onClick = function() if UI.ShowOptions then UI.ShowOptions() end end },
	}, section or GUIDES.key, function(key) P.ShowSection(key) end)
end

-- The sidebar index of a section: its own nav, or for a one-view section
-- the section itself, marked (the sidebar never stands empty).
local function sectionNav(s)
	if not s.nav then
		W.ShellNav(win, { { key = s.key, label = s.label or s.key, icon = s.icon } }, s.key, nil)
		return
	end
	local ok, items, activeKey = pcall(s.nav)
	if not ok or type(items) ~= "table" then items, activeKey = {}, nil end
	-- onNav changes the section's state and re-renders the hub (P.Render).
	W.ShellNav(win, items, activeKey, function(key) if s.onNav then s.onNav(key) end end)
end

function P.Render()
	if not (win and win:IsShown()) then return end
	local active = activeSection()
	if not active then section = nil end
	renderRail()
	sectionLayout(active)
	if active then
		sectionNav(active)
		navTips("All")
		renderSection(active)
		return
	end
	for _, s in ipairs(sections) do if s.psFrame then s.psFrame:Hide() end end
	local filter = factionFilter()
	-- A pack entry whose pack was hidden or holds no guides, or a category no
	-- shown guide is in (its pack was switched off): back to All.
	if category:sub(1, #PACK) == PACK then
		local r = packOfKey(category)
		if not (r and r.status == "on" and (r.guideCount or 0) > 0) then category = "All" end
	elseif category ~= "All" and category ~= "Favorites" then
		local shown = false
		for _, g in ipairs(ns.Guides and ns.Guides.List and ns.Guides.List() or {}) do
			if not packOf(g) and categoryOf(g) == category then
				shown = true
				break
			end
		end
		if not shown then category = "All" end
	end
	local entries, n, counts = P.Entries(filter, query, view == "browse" and category or "All")
	local total = 0
	for c, k in pairs(counts) do if c ~= "Favorites" then total = total + k end end
	W.ShellNav(win, navItems(counts, total), view == "browse" and category or nil, function(key) P.SetCategory(key) end)
	navTips(filter)
	local tabsList = {}
	for i, v in ipairs(VIEWS) do tabsList[i] = { key = v, label = VIEW_LABEL[v] } end
	W.ShellTabs(win, tabsList, view, function(key) P.SetView(key) end)
	paintSegments(filter)

	local byId = headersById()
	local tabs, active = tabsInfo()
	local openIndex = {}
	for i, t in ipairs(tabs or {}) do openIndex[t.guideId] = i end

	-- The header: where you are, and what the list holds.
	local title, subtitle
	if view == "browse" then
		title = query ~= "" and L["Search"] or (category == "All" and L["All guides"] or bucketLabel(category))
		if query ~= "" then
			subtitle = n == 1 and string.format(L["1 result for \226\128\156%s\226\128\157"], query)
				or string.format(L["%d results for \226\128\156%s\226\128\157"], n, query)
		else
			local parts = { filter == "All" and L["All factions"] or ns.FactionName(filter), n == 1 and L["1 guide"] or string.format(L["%d guides"], n) }
			local open = tabs and #tabs or 0
			if open > 0 then parts[#parts + 1] = string.format(L["%d open"], open) end
			subtitle = table.concat(parts, DOT)
		end
	else
		title = VIEW_LABEL[view]
		if view == "home" then
			subtitle = L["Pick up where you left off, or start something new."]
		elseif view == "current" then
			subtitle = L["The guides open in your tabs."]
		else
			subtitle = L["The last guides you loaded."]
		end
	end
	if newTabMode then subtitle = L["Pick a guide to open in a new tab."] end
	W.ShellTitle(win, title, subtitle)

	local width = MID_W - ROW_X * 2
	local y, nf, ng, nc = 8, 0, 0, 0
	visibleIds = {}
	local function folder(text, count)
		nf = nf + 1
		local f = folderRow(nf)
		f.Text:SetText(text)
		f.Count:SetText(count or "")
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", win.Body, "TOPLEFT", ROW_X, -y)
		f:SetWidth(width)
		f:Show()
		y = y + FOLDER_H + 4
	end
	-- note: the tab an open guide sits in, with its progress where asked.
	local function tabNote(id, withPct)
		local i = openIndex[id]
		if not i then return nil end
		if not withPct then return string.format(L["Tab %d"], i) end
		local t = tabs[i]
		local tot = t.total or t.stepCount or 0
		local pct = tot > 0 and floor((t.done or 0) / tot * 100 + 0.5) or 0
		return string.format(L["Tab %d  \194\183  %d%%"], i, pct)
	end
	local function row(g, note)
		ng = ng + 1
		local r = guideRow(ng)
		paintRow(r, g, note, width)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", win.Body, "TOPLEFT", ROW_X, -y)
		r:Show()
		y = y + ROW_H
		visibleIds[#visibleIds + 1] = g.id
	end
	local empty
	-- The last search's Codex matches go away first; a browse with a query
	-- draws them again below.
	if UI.HideLookupRows then UI.HideLookupRows(win.Body) end
	if view == "browse" then
		local lastFolder = false
		for _, e in ipairs(entries) do
			if e.kind == "folder" then
				if lastFolder then y = y + 10 end
				folder(e.text, e.count)
				lastFolder = true
			else
				row(e.guide, tabNote(e.guide.id))
			end
		end
		-- Items, NPCs and quests that match, under the guides (UI/Lookup.lua).
		if query ~= "" and UI.LookupRows then
			y = UI.LookupRows(win.Body, y, query, width, ROW_X)
			-- The header counts both: "1 guide · 8 in the Codex for “west”".
			local codex = UI.LookupTotal and UI.LookupTotal() or 0
			if codex > 0 and not newTabMode then
				W.ShellTitle(win, title, string.format(L["%s  \194\183  %d in the Codex for \226\128\156%s\226\128\157"],
					n == 1 and L["1 guide"] or string.format(L["%d guides"], n), codex, query))
			end
		end
		if n == 0 and not (query ~= "" and UI.LookupCount and UI.LookupCount() > 0) then
			if #(ns.Guides and ns.Guides.List and ns.Guides.List() or {}) == 0 then
				empty = (UI.Packs and UI.Packs.AnySwitchedOff())
					and L["No guides shown: the guide packs are switched off. Turn one on under Options, Guide packs (/polestar packs)."]
					or L["No guides installed. Enable Polestar Guides or a guide pack in the AddOns list on the character screen, then reload."]
			elseif query ~= "" then
				empty = string.format(L["No guides match \226\128\156%s\226\128\157."], query)
			elseif category == "Favorites" then
				empty = L["No favourites yet. Select a guide and click its star."]
			elseif category ~= "All" then
				empty = string.format(L["No %s guides for this faction."], bucketLabel(category))
			else
				empty = L["No guides for this faction."]
			end
		end
	elseif view == "home" then
		if tabs and #tabs > 0 then
			folder(L["Continue"], #tabs)
			y = y + 4
			y = layoutCards(tabs, active, byId, y) + 6
			nc = #tabs
		end
		local sugg = suggestions(byId, tabs, openIndex)
		if #sugg > 0 then
			folder(L["Suggested for you"], #sugg)
			for _, g in ipairs(sugg) do row(g, tabNote(g.id)) end
		end
		if nc == 0 and #sugg == 0 then empty = L["Nothing open yet. Pick a category on the left to find a guide."] end
	elseif view == "current" then
		if tabs and #tabs > 0 then
			folder(L["Open tabs"], #tabs)
			for i, t in ipairs(tabs) do
				local g = byId[t.guideId]
				if g then row(g, tabNote(g.id, true)) end
			end
		else
			empty = L["No guide is open. Load one and it shows up here."]
		end
	else
		local recent = {}
		for _, id in ipairs(P.Recent()) do if byId[id] then recent[#recent + 1] = byId[id] end end
		if #recent > 0 then
			folder(L["Recently loaded"], #recent)
			for _, g in ipairs(recent) do row(g, tabNote(g.id)) end
		else
			empty = L["Guides you load show up here."]
		end
	end
	if view ~= "home" or nc == 0 then
		for _, c in ipairs(cardPool) do c:Hide() end
	end
	for i = ng + 1, #rowPool do rowPool[i]:Hide() end
	for i = nf + 1, #folderPool do folderPool[i]:Hide() end
	if empty then
		-- Where guides can show up, say how to load one once they do.
		if #(ns.Guides and ns.Guides.List and ns.Guides.List() or {}) > 0 then empty = empty .. "\n\n" .. loadHint() end
		win.Empty:SetText(empty)
		win.Empty:ClearAllPoints()
		win.Empty:SetPoint("TOPLEFT", win.Body, "TOPLEFT", SH.pad, -(y + 16))
		win.Empty:Show()
		y = y + 16 + win.Empty:GetStringHeight()
	else
		win.Empty:Hide()
	end
	W.ShellWatermark(win, empty ~= nil)
	W.ShellBody(win, y + 16)
	renderDetails(byId, tabs, active)
	P.shown = { view = view, guides = ng, folders = nf, cards = nc }
end

-- Searching: keep the selection among the results, so Enter loads what
-- the list shows.
local function selectFirstResult()
	local sel = P.Selected()
	for _, id in ipairs(visibleIds) do if id == sel then return end end
	if visibleIds[1] then P.Select(visibleIds[1]) end
end

function P.SetView(v)
	view = v or "home"
	section = nil
	if view ~= "browse" and query ~= "" then
		query = ""
		if win then win.Search:SetText("") end
	end
	if win and win:IsShown() then
		W.ScrollTo(win.Scroll, 0)
		P.Render()
	end
end

function P.View() return view end

function P.SetCategory(c)
	category = c or "All"
	P.SetView("browse")
end

function P.Category() return category end
function P.IsNewTabMode() return newTabMode end

-- Arrow keys in the search box walk the visible guides.
local function step(delta)
	if #visibleIds == 0 then return end
	local sel, at = P.Selected(), nil
	for i, id in ipairs(visibleIds) do if id == sel then at = i end end
	at = at and min(#visibleIds, max(1, at + delta)) or 1
	P.Select(visibleIds[at])
end
P.Step = step

---------------------------------------------------------------------------
-- Build
---------------------------------------------------------------------------

local function onSearch(text)
	text = text or ""
	if text == query then return end
	-- A section with its own search takes the box while it is shown; in any
	-- other section typing goes back to the guides.
	local s = activeSection()
	if s and s.search then
		query = text
		s.search(text)
		return
	end
	if s and text ~= "" then section = nil end
	-- A new search looks through every guide; a category picked while
	-- searching narrows it.
	if query == "" and text ~= "" then category = "All" end
	query = text
	if not (win and win:IsShown()) then return end
	if query ~= "" then view = "browse" end
	W.ScrollTo(win.Scroll, 0)
	P.Render()
	if query ~= "" then selectFirstResult() end
end

local function build()
	win = W.Shell("PolestarPicker", {
		width = WIN_W, rail = true, title = L["Guides"], scalePath = "ui.menuScale", searchPlaceholder = HUB_SEARCH,
		onSearch = onSearch,
	})
	P.frame = win
	UI.Report.SidebarLink(win)
	P.search = win.Search
	P.scroll = win.Scroll
	local main = win.Main

	-- Left: the rail (sections, Options at its foot), then the sidebar with
	-- the search in the tab band and the section's index from the 152 line.
	win.Search:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
		local s = activeSection()
		if s and s.enter then s.enter() elseif not s then P.LoadSelected() end
	end)
	win.Search:SetScript("OnArrowPressed", function(_, key)
		local d = key == "UP" and -1 or (key == "DOWN" and 1 or nil)
		if not d then return end
		local s = activeSection()
		if s and s.step then s.step(d) elseif not s then step(d) end
	end)

	-- Middle: the header, tab row and list end where the details begin; no
	-- footer, the list runs to the window's bottom.
	win.Header:ClearAllPoints()
	win.Header:SetPoint("TOPLEFT", main, "TOPLEFT", 0, 0)
	win.Header:SetPoint("TOPRIGHT", main, "TOPRIGHT", -DETAIL_W, 0)
	win.Band:SetTexCoord(Theme.BandCoords(MID_W, SH.header))
	win.BodyWidth = MID_W - SH.pad * 2
	win.Empty = W.Text(win.Body, "note", "textMuted")
	win.Empty:SetWordWrap(true)
	win.Empty:SetJustifyV("TOP")
	win.Empty:SetWidth(win.BodyWidth)
	win.Empty:Hide()
	W.ShellFooter(win, nil, nil)

	-- The faction filter, at the right of the tab row, centred in it; its
	-- right edge mirrors the first tab's left (SH.pad - 12).
	local x = -(SH.pad - 12)
	for i = #FACTIONS, 1, -1 do
		local f = FACTIONS[i]
		local b = CreateFrame("Button", nil, win.TabRow)
		b:SetHeight(24)
		b.psKey = f
		W.Hover(b)
		b.Selected = W.Fill(b, "panelAlt", "BACKGROUND", 0)
		b.Label = W.Text(b, "small", "textMuted")
		b.Label:SetPoint("CENTER", b, "CENTER", 0, 0)
		b.Label:SetText(f == "All" and L["All"] or ns.FactionName(f))
		b:SetWidth(floor(b.Label:GetStringWidth() + 20 + 0.5))
		b:SetPoint("RIGHT", win.TabRow, "RIGHT", x, 0)
		b:SetScript("OnClick", function(self) ns.Set("ui.pickerFaction", self.psKey) end)
		b.psTip = L["Faction filter"]
		x = x - b:GetWidth() - 2
		segButtons[i] = b
	end
	win.factionButtons = segButtons

	buildDetails()
	win:HookScript("OnShow", function() P.Render() end)
	-- A gamepad moves through the hub (UI/Gamepad.lua): LB / RB step the
	-- rail's sections, X loads the guide on a focused row.
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(win, {
			initial = function(rows)
				local first
				for i, w in ipairs(rows) do
					if ns.Gamepad.Within(w, win.Main) and w.psKey == nil then
						if w.psGuide and w.psGuide.id == P.Selected() then return i end
						first = first or i
					end
				end
				return first
			end,
			prevTab = function() P.StepSection(-1) end,
			nextTab = function() P.StepSection(1) end,
			tabsLabel = L["Sections"],
			-- The close sits among the details' own buttons: B goes in the hint bar.
			close = false,
			x = function(w)
				if w and w.psGuide and w.psGuide.id then
					P.Select(w.psGuide.id)
					P.LoadSelected()
				end
			end,
			xLabel = function(w) return w.psGuide and L["Load guide"] or nil end,
		})
	end
end

-- opts: { newTab = true } when loading should open a new tab.
function UI.ShowPicker(opts)
	if not win then build() end
	newTabMode = type(opts) == "table" and opts.newTab and true or false
	-- Remember the last selection; without one, start on the open guide or
	-- the suggestion.
	local byId = headersById()
	local sel = P.Selected()
	if not (sel and byId[sel]) then
		sel = nil
		local tabs, active = tabsInfo()
		if tabs and active and tabs[active] then sel = tabs[active].guideId end
		local G = ns.Guides
		if not sel and G and G.Suggest then sel = G.Suggest() end
		uiState().pickerSelected = sel and byId[sel] and sel or nil
	end
	local settings = UI.Options and UI.Options.frame
	if win:IsShown() then
		P.Render()
	else
		if settings and settings:IsShown() then P.TakePlace(win, settings) end
		win:Show()
	end
	if settings then settings:Hide() end
end

-- A new font measures the rail, the sidebar and the details' label column
-- anew: the hub on screen renders again.
W.OnFontChanged(function()
	if win and win:IsShown() then P.Render() end
end)

function P.SetQuery(text)
	if not win then build() end
	win.Search:SetText(text or "")
	onSearch(text or "")
end

ns.On("GUIDE_CHANGED", function(id)
	remember(id)
	P.Render()
end)
ns.On("SETTING_CHANGED", function(path)
	if path == "ui.pickerFaction" or path == "" or path == "ui" then P.Render() end
end)
local function guidesChanged()
	factCache = {}
	P.Render()
end
ns.On("GUIDES_REGISTERED", guidesChanged)
ns.On("PACKS_CHANGED", guidesChanged)
ns.On("TABS_CHANGED", function() P.Render() end)
