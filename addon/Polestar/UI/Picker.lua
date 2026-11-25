-- The guide menu, in the Polestar shell, read in three panes on the shell's
-- grid: the zone art and the tab row end on the one 152 line; text in the
-- middle pane starts at x=32 (a finished guide's check sits in the gutter
-- left of it); the sidebar and the details keep the shell's 24 inset.
--
-- Left: the hub rail (sections, Options at its foot; below), then the
-- sidebar: the search under the wordmark, then the categories with their
-- icons and counts (All, Leveling, Professions, Reputation, Exploration,
-- Legacy, Collectibles, Miscellaneous, Favorites). A category with no guide at all
-- is left out; one with none for this character fades. Dungeons have their own
-- hub section, not a category.
-- Middle: tabs (Home, "resume first": the active tab as a wide card over its
-- zone art with its full name, its current step, a progress line, Continue
-- and a ··· tab menu, then the other open tabs as rows with a small bar
-- (three, "Show all N" on their label for the rest), then the suggested
-- guides, each saying why it is listed; with no tab open, a "Start here"
-- card for the top suggestion with Load guide, the other suggestions for the
-- level and buttons for Leveling, Class, Professions and Import; Special
-- thanks at its foot. Browse: the last category or the search; Current: the
-- open tabs; Recent: the tabs closed, newest first, then the last guides
-- loaded), one always active, over one line per
-- guide, "Title (min-max)" (same-titled guides of one range with their races
-- or faction: "Dun Morogh (Dwarf)", P.Titles), a "Group" chip on a guide
-- with group content on the route every player follows (elites, dungeons,
-- raids: the compiled `group`; on Home's tab card too), a check on
-- finished guides and a muted "Tab N" on open ones, under small folder
-- headers (leveling by faction and band: "Horde 30-40"; the rest by
-- category). On Browse without a search a header folds its guides away and
-- back (click, or A on a gamepad; its count stays), kept account-wide in
-- ui.pickerCollapsed; opening the menu unfolds the open guide's folder. Only
-- the character's own side is ever listed (Guides.OtherFaction; no faction
-- filter, #2462): Browse, search, Home's suggestions and Recent alike. The
-- header says what the list holds ("Horde · 65 guides · 1 open", or the
-- search's result count). The list runs to the
-- window's bottom.
-- Right: the selected guide's details: its zone's art from the client (the
-- night band without it) with the title on it, chips (levels, on a leveling
-- guide what its turn-ins are worth in levels with a panel on hover
-- (UI/LevelTip.lua), group, faction, races, classes), progress, the facts (what the guide's goal gives
-- and why: a Class guide's `reward`, item and spell icons with the game's
-- tooltip on hover, and its `why`; steps, the quests this character takes,
-- the zones in route order, what comes next), pitch, pros and cons,
-- the favourite star, "Load guide" (into the current tab) and "Open in new
-- tab"; on an open guide Load reads "Continue" and the new-tab button goes.
-- On Home the details show Home's own selection: the top suggestion until
-- the player picks another line there; the other tabs show the last guide
-- selected. Home's tab card and tab rows close their tab from their
-- right-click menu (Close tab, Move left, Move right; the card's ··· too) or
-- Y on a gamepad. A name cut short (the tab card's, a row's, a community
-- pack's in the sidebar, the Quests in and Passes through facts) reads
-- whole in its tooltip.
--
-- Selecting shows details; loading is explicit: the buttons, a double-click,
-- or Enter in the search box (a row's tooltip says so). Opened from the guide
-- window's + (UI.ShowPicker({ newTab = true })), loading opens a new tab.
--
-- Per character, in CharState().ui: recentGuides (the last 10 guides loaded,
-- newest first, kept on GUIDE_CHANGED), favoriteGuides ({ [id] = true }) and
-- pickerSelected (the last selection, Home's included).

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, type, ipairs, pairs = math.floor, math.max, math.min, type, ipairs, pairs
local ZoneArt = UI.ZoneArt
local readable = ns.Compat.Readable

local SH = W.SHELL
local WIN_W = 1120 + SH.rail -- the section rail, then the three panes
local DETAIL_W = 372 -- the details pane, right
local MID_W = WIN_W - SH.rail - SH.sidebar - 2 - DETAIL_W -- the list pane, middle

local SIDE_W = SH.sidebar -- the sidebar, left of the list

-- The skin's sizes (Theme.Metric; DIRECTION_B_HALO.md §3: 1100 x 640 beside the rail,
-- a 230 sidebar, a 380 details pane), read as the window is built.
local WIN_H = 640

-- The window is the skin's size in the game's UI units (pickerW beside the
-- rail, pickerH: 1208 x 680 by default), so it follows the game's UI scale as
-- the game's own windows do; never past the screen at the Guides scale.
local function readSizes()
	local scale = W.ScaleSetting("ui.pickerScale")
	local maxW = floor(UIParent:GetWidth() / scale - 32)
	local maxH = floor(UIParent:GetHeight() / scale - 32)
	WIN_W = min(maxW, max(W.SHELL_MIN_W, Theme.Metric("pickerW", 1120) + SH.rail))
	WIN_H = min(maxH, max(W.SHELL_MIN_H, Theme.Metric("pickerH", SH.height)))
	DETAIL_W = Theme.Metric("pickerDetail", 372)
	SIDE_W = Theme.Metric("pickerSidebar", SH.sidebar)
	MID_W = WIN_W - SH.rail - SIDE_W - 2 - DETAIL_W
end
local ROW_X = 12 -- where list rows' grounds start in the middle pane
local TEXT_X = SH.pad - ROW_X -- text inside a row, on the column's x=32 edge
local ROW_H, FOLDER_H = 28, 32
-- Home's rhythm (the B modal template): 16 from the tab row to the body, a
-- 16 label 8 over its content, 36 rows with a hairline between, 24 before
-- each section label and under the last content; the tab card 114 tall, its
-- text 16 in.
local HOME_TOP, LABEL_H, LABEL_GAP, SECTION_GAP, HOME_ROW_H = 16, 16, 8, 24, 36
local HERO_H, HERO_PAD = 114, 16
local OTHER_TABS = 3 -- other tabs listed on Home before "Show all N"
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
local factCache = {} -- guide id -> { quests, questsIn, passes } (guideFacts)
local folderPool, rowPool = {}, {}
local query = ""
local questContext -- { id, query, steps = { [guideId] = matching steps } }
local category = "All"
local view = "home" -- "home" | "current" | "recent" | "browse"
local newTabMode = false
local visibleIds = {} -- guide ids in the middle pane, top to bottom (arrow keys)
local allCards = false -- "Show all N": every other open tab on Home, not three; this session
-- Home's own selection: the line picked there this visit, else the top
-- suggestion (homeTop); onHome while Home's list is what the hub shows.
local homeSel, homeTop, onHome = nil, nil, false

local VIEWS = { "home", "browse", "current", "recent" }
local VIEW_LABEL = { home = L["Home"], browse = L["Browse"], current = L["Current"], recent = L["Recent"] }

-- The guide format's categories, in the order players look for them.
local CATEGORIES = { "Leveling", "Class", "Professions", "Reputation", "Exploration", "Legacy", "Collectibles", "Miscellaneous" }
P.CATEGORIES = CATEGORIES
local CATEGORY_RANK = {}
for i, c in ipairs(CATEGORIES) do CATEGORY_RANK[c] = i end
local CATEGORY_ICON = UI.CATEGORY_ICON

local categoryOf = UI.Category

-- Community guide packs: their guides are not in our categories but under
-- the "Community guides" heading, one entry per pack (key "pack:<id>"); All,
-- Favorites and search cover every shown guide.
local PACK = "pack:"

-- The community pack a guide (header) comes from; nil for ours (`guides`),
-- Polestar's internal packs and its extra packs (Guides.OWN_EXTRA: the
-- experimental guides, listed with ours under Leveling).
local function packOf(g)
	local id = g and g.pack
	if id == nil or id == "guides" then return nil end
	local G = ns.Guides
	if G and G.OWN_EXTRA and G.OWN_EXTRA[id] then return nil end
	local r = G and G.Pack and G.Pack(id)
	if r and not r.internal then return r end
	return nil
end
P.PackOf = packOf

-- One of Polestar's experimental guides (its "Experimental" chip).
local function isExperimental(g)
	local G = ns.Guides
	return G and G.IsExperimental and G.IsExperimental(g) or false
end

-- A guide in one of Forever's new zones (Guides.InForeverZone): the Forever
-- mark on its row and a "Forever" chip in its details.
local function inForeverZone(g)
	local G = ns.Guides
	return G and G.InForeverZone and G.InForeverZone(g) or false
end

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

-- The character, for what the menu may list (Guides.GuideMatches,
-- Guides.OtherFaction); nil while Compat has none.
-- While P.Render runs, the character it read once (false: none): a render
-- asks for it per guide, and each ask builds a table.
local renderPlayer
local function playerInfo()
	if renderPlayer ~= nil then return renderPlayer or nil end
	local C = ns.Compat
	if not (C and C.GetPlayerInfo) then return nil end
	local ok, info = pcall(C.GetPlayerInfo)
	return ok and type(info) == "table" and info or nil
end

-- Whether guide header g is of the character's side (or both): no list in the
-- menu holds another side's guide, whatever brought it in.
local function ownSide(g, player)
	local G = ns.Guides
	return not (g and G and G.OtherFaction and G.OtherFaction(g, player or playerInfo()))
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
	local parts = { g.title or "", g.zoneName or "", c, L[c], g.id or "", g.folder or "", isExperimental(g) and L["Experimental"] or "" }
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

-- Match IDs, not translated titles: two quests can share a name. A hit
-- keeps the step's title and note, not the step: a side-shelf guide's steps
-- are read in for the search and given back (Guides.Peek).
local function questSteps(g)
	local cached = questContext.steps[g.id]
	if cached then return cached end
	local G, C = ns.Guides, ns.Compat
	local full = G.Get(g.id)
	local player = C.GetPlayerInfo()
	local found = {}
	questContext.steps[g.id] = found
	if not full or (G.GuideMatches and not G.GuideMatches(g, player) and not (G.OtherStart and G.OtherStart(g, player))) then return found end
	local function applies(only) return not G.Matches or G.Matches(only, player) end
	local steps, fresh = G.Peek(g.id)
	for i, step in ipairs(steps or {}) do
		if applies(step.only) then
			for _, goal in ipairs(step.goals or {}) do
				if goal.quest == questContext.id and applies(goal.only) then
					found[#found + 1] = { index = i, step = { title = step.title, note = step.note } }
					break
				end
			end
		end
	end
	G.Unpeek(g.id, fresh)
	return found
end

local function matches(g, q)
	if questContext and q == questContext.query:lower() then return #questSteps(g) > 0 end
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
	local lv = ns.Guides.Levels(g) or 1
	if lv < 30 then return 1, 30 end
	local lo = floor(lv / 10) * 10
	return lo, lo + 10
end
P.Band = band

local FACTION_ORDER = { Alliance = 1, Horde = 2 }

-- The folder a guide is listed under -> label, sort key, id. A guide's own
-- `folder` wins; guides sharing it still sort by faction, then level. The
-- id names the folder whatever the client's language or the character's
-- faction (the collapsed folders are kept by it, account-wide). `side`: the
-- faction a leveling guide for both is listed under (an experimental guide
-- such as Shen'dralas sits in that side's band, as ours do).
local function folderOf(g, mine, side)
	local c = categoryOf(g)
	if type(g.folder) == "string" and g.folder ~= "" then
		return g.folder, string.format("%02d", CATEGORY_RANK[c] or 99) .. c .. "/" .. g.folder, c .. "/" .. g.folder
	end
	if c == "Leveling" then
		local lo, hi = band(g)
		local f = g.faction or side
		local rank = f == nil and 3 or (f == mine and 0 or (FACTION_ORDER[f] or 4))
		local label = (f and ns.FactionName(f) or L["Leveling"]) .. " " .. UI.LevelRange(lo, hi)
		return label, string.format("%02d%d%03d", CATEGORY_RANK.Leveling, rank, lo), "Leveling/" .. (f or "") .. "/" .. lo
	end
	return L[c], string.format("%02d", CATEGORY_RANK[c] or 99) .. c, c
end
local OTHER_STARTS = "Leveling/other-starts"

-- Same-titled guides in one list (#1358: the Dwarf's and the Gnome's "Dun
-- Morogh (1-12)") say whose they are: their races where those differ, else
-- their faction ("Zephras Isle (Horde)" beside the Alliance one). A title
-- with another level range needs nothing: the range tells them apart. A
-- title that names its own guide's faction ("Defensive Stance and a Weapon
-- (Alliance)", written for the two sides' twins) says it only when the other
-- side's twin is in the same list (#2462: the menu lists one side's guides).
-- list: guide headers -> { [guide] = shown title }
local function racesOf(g)
	if type(g.races) ~= "table" or #g.races == 0 then return nil end
	local names = {}
	for i, r in ipairs(g.races) do names[i] = UI.RaceName(r) end
	local text = names[1]
	for i = 2, #names do text = string.format(L["%s, %s"], text, names[i]) end
	return text
end

-- g's title without a closing "(<its own faction>)", English or the client's.
local function baseTitle(g)
	local t = g.title or g.id or ""
	if type(g.faction) ~= "string" then return t end
	for _, f in ipairs({ g.faction, ns.FactionName(g.faction) or g.faction }) do
		local suffix = " (" .. f .. ")"
		if #t > #suffix and t:sub(-#suffix) == suffix then return t:sub(1, -#suffix - 1) end
	end
	return t
end

function P.Titles(list)
	local same, base, sides = {}, {}, {}
	for _, g in ipairs(list) do
		base[g] = baseTitle(g)
		local b = sides[base[g]] or {}
		sides[base[g]] = b
		b[g.faction or ""] = true
		local lo, hi = ns.Guides.Levels(g)
		local k = base[g] .. "\0" .. (lo or "") .. "-" .. (hi or "")
		local s = same[k]
		if not s then
			s = {}
			same[k] = s
		end
		s[#s + 1] = g
	end
	-- A twin whose other side is listed too keeps its whole title, whatever its range.
	for _, g in ipairs(list) do
		local n = 0
		for _ in pairs(sides[base[g]]) do n = n + 1 end
		if n > 1 and base[g] ~= (g.title or g.id or "") then base[g] = g.title or g.id end
	end
	local out = {}
	for _, s in pairs(same) do
		local races, factions = {}, {}
		for _, g in ipairs(s) do
			races[racesOf(g) or ""] = true
			factions[g.faction or ""] = true
		end
		local function count(t)
			local n = 0
			for _ in pairs(t) do n = n + 1 end
			return n
		end
		local byRace, byFaction = count(races) == #s, count(factions) == #s
		for _, g in ipairs(s) do
			local q = #s > 1 and ((byRace and racesOf(g)) or (byFaction and g.faction and ns.FactionName(g.faction))) or nil
			if q and base[g] == (g.title or g.id) and base[g] ~= baseTitle(g) then q = nil end
			out[g] = q and string.format(L["%s (%s)"], base[g], q) or base[g]
		end
	end
	return out
end

-- Browse folders the player folded away: { [folder id] = true }, account-wide.
function P.IsCollapsed(id)
	local t = ns.Get("ui.pickerCollapsed")
	return id ~= nil and type(t) == "table" and t[id] == true
end

function P.SetCollapsed(id, collapsed)
	if id == nil or P.IsCollapsed(id) == (collapsed and true or false) then return end
	local t, copy = ns.Get("ui.pickerCollapsed"), {}
	if type(t) == "table" then for k, v in pairs(t) do copy[k] = v end end
	copy[id] = collapsed and true or nil
	ns.Set("ui.pickerCollapsed", next(copy) and copy or nil)
end

function P.ToggleFolder(id) P.SetCollapsed(id, not P.IsCollapsed(id)) end

local function rankOfFaction(f, mine)
	if f == nil then return 3 end
	if f == mine then return 0 end
	return FACTION_ORDER[f] or 4
end

-- Does guide a hand over to guide b: its `next`, or one of its route
-- choices (a shared guide offers each side's next guide)?
local function handsTo(a, b)
	if a.next == b.id then return true end
	for _, id in ipairs(type(a.nextChoices) == "table" and a.nextChoices or {}) do
		if id == b.id then return true end
	end
	return false
end

-- q: search text; cat: a category, "Favorites" or "All". Only the guides
-- this character can follow are listed: none of the other faction's (#2462),
-- other classes' or other races', but their own side's starting zones (those,
-- Guides.OtherStart, go in an "Other starting zones" folder, the first of
-- Leveling). Favourites keep to the character's side.
-- -> entries { kind = "folder", text, count, id } | { kind = "guide", guide,
--    title (Titles), folder (the folder entry) },
--    number of guides listed, { [category] = matching guides, Favorites = n }
--    (before the category filter)
function P.Entries(q, cat)
	local G = ns.Guides
	local list = G and G.List and G.List() or {}
	q = (q or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
	cat = cat or "All"
	local mine = UI.PlayerFaction()
	local player = playerInfo()
	local favs = uiState().favoriteGuides
	local counts, picked, other = { Favorites = 0 }, {}, {}
	for _, g in ipairs(list) do
		local hit = matches(g, q)
		local side = ownSide(g, player)
		if hit and side and favs[g.id] then
			counts.Favorites = counts.Favorites + 1
			if cat == "Favorites" then picked[#picked + 1] = g end
		end
		local fits = side
		if fits and player and G.GuideMatches and not G.GuideMatches(g, player) then
			if G.OtherStart and G.OtherStart(g, player) then other[g] = true else fits = false end
		end
		if fits and hit then
			local c = bucketOf(g)
			counts[c] = (counts[c] or 0) + 1
			if cat == "All" or c == cat then picked[#picked + 1] = g end
		end
	end
	-- A leveling guide for both factions (Shen'dralas, an experimental one)
	-- sits in the player's side's band, at that side's levels.
	local key, label, fid, fac = {}, {}, {}, {}
	for _, g in ipairs(picked) do
		-- A community pack's guide for both keeps its own "Leveling" band.
		local ours = categoryOf(g) == "Leveling" and packOf(g) == nil
		fac[g] = g.faction or ((ours or isExperimental(g)) and mine or nil)
		if other[g] then
			label[g], key[g], fid[g] = L["Other starting zones"], string.format("%02d!", CATEGORY_RANK.Leveling), OTHER_STARTS
		else
			label[g], key[g], fid[g] = folderOf(g, mine, fac[g])
		end
	end
	-- Guides in one folder, on one side, at one first level are listed as they
	-- are played: a guide that hands over to another comes before it (a race's
	-- lead-in "(12)" before the shared "(12-16)"; Badlands, Shen'dralas, then
	-- Feralas, all at 45), otherwise by id (leveling) or title. The order is a
	-- rank worked out before the sort, so guides that hand over to each other
	-- (a community pack's starting zones offering one another, #3817) still
	-- give table.sort one consistent order.
	local level, groups, rank = {}, {}, {}
	for _, g in ipairs(picked) do
		level[g] = G.Levels(g, mine) or 0
		local k = key[g] .. "\0" .. rankOfFaction(fac[g], mine) .. "\0" .. level[g]
		groups[k] = groups[k] or {}
		table.insert(groups[k], g)
	end
	local function byName(a, b)
		if categoryOf(a) == "Leveling" then return (a.id or "") < (b.id or "") end
		if (a.title or "") ~= (b.title or "") then return (a.title or "") < (b.title or "") end
		return (a.id or "") < (b.id or "")
	end
	for _, members in pairs(groups) do
		table.sort(members, byName)
		-- Each round places the first guide (by name) that no unplaced guide
		-- hands over to; in a loop of hand-overs, the first by name.
		local into = {}
		for _, g in ipairs(members) do
			into[g] = 0
			for _, h in ipairs(members) do
				if h ~= g and handsTo(h, g) then into[g] = into[g] + 1 end
			end
		end
		for n = 1, #members do
			local pick
			for _, g in ipairs(members) do
				if not rank[g] then
					if into[g] == 0 then pick = g break end
					pick = pick or g
				end
			end
			rank[pick] = n
			for _, g in ipairs(members) do
				if g ~= pick and not rank[g] and handsTo(pick, g) then into[g] = into[g] - 1 end
			end
		end
	end
	table.sort(picked, function(a, b)
		if key[a] ~= key[b] then return key[a] < key[b] end
		local fa, fb = rankOfFaction(fac[a], mine), rankOfFaction(fac[b], mine)
		if fa ~= fb then return fa < fb end
		if level[a] ~= level[b] then return level[a] < level[b] end
		return rank[a] < rank[b]
	end)
	local titles = P.Titles(picked)
	local out, folder = {}, nil
	for _, g in ipairs(picked) do
		if label[g] ~= (folder and folder.text) then
			folder = { kind = "folder", text = label[g], count = 0, id = fid[g] }
			out[#out + 1] = folder
		end
		folder.count = folder.count + 1
		out[#out + 1] = { kind = "guide", guide = g, title = titles[g], folder = folder }
	end
	return out, #picked, counts
end

-- The id of the Browse folder a guide is listed under (every category, no
-- search), or nil where it is not listed.
function P.FolderOf(id)
	for _, e in ipairs((P.Entries("", "All"))) do
		if e.kind == "guide" and e.guide.id == id then return e.folder.id end
	end
	return nil
end

---------------------------------------------------------------------------
-- Engine glue
---------------------------------------------------------------------------

local function tabsInfo()
	local E = ns.Engine
	if not (E and E.GetTabs) then return nil, nil end
	local ok, tabs, active = pcall(E.GetTabs, true) -- with done and total: the tab cards' progress
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

-- Whether `text` has `name` in it as whole words.
local function mentions(text, name)
	local at = 1
	while true do
		local a, b = text:find(name, at, true)
		if not a then return false end
		if not text:sub(a - 1, a - 1):find("[%w\128-\255]") and not text:sub(b + 1, b + 1):find("[%w\128-\255]") then return true end
		at = a + 1
	end
end

-- Whether a guide's title names the zone: its name in the title, or its first
-- word before "&" and the rest of it after ("Western Plaguelands" in "Western
-- & Eastern Plaguelands": the writer's titles share the last word).
local function titleNames(title, zone)
	if mentions(title, zone) then return true end
	local first, rest = zone:match("^(%S+) (.+)$")
	return first ~= nil and mentions(title, first .. " &") and mentions(title, rest)
end

-- What a guide's steps hold for this character: the quests it accepts
-- (steps and goals filtered by `only`, as the route choice counts them) and
-- the zones its goals visit, in step order: `questsIn` those its title names
-- (the guide writer's: the zones it quests in) or where QUEST_STEPS or more
-- of its steps carry a quest goal, `passes` the rest (its own zone when no
-- goal has one). Cached per guide until guides register again.
local QUEST_STEPS = 6
local function guideFacts(g)
	local f = factCache[g.id]
	if f then return f end
	f = { quests = 0, questsIn = {}, passes = {} }
	local G, C = ns.Guides, ns.Compat
	local full, fresh = nil, false
	if G and G.Peek then full, fresh = G.Peek(g.id) end
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
	local zones, questSteps = {}, {} -- route order; zone -> steps with a quest goal there
	for _, step in ipairs(type(full) == "table" and full or {}) do
		if applies(step.only) and type(step.goals) == "table" then
			local counted = {}
			for _, goal in ipairs(step.goals) do
				if applies(goal.only) then
					if goal.t == "accept" then f.quests = f.quests + 1 end
					local name = mapName(goal.map)
					if name then
						if not questSteps[name] then
							questSteps[name] = 0
							zones[#zones + 1] = name
						end
						if goal.quest and not counted[name] then
							counted[name] = true
							questSteps[name] = questSteps[name] + 1
						end
					end
				end
			end
		end
	end
	if G and G.Peek then G.Unpeek(g.id, fresh) end
	local title = type(g.title) == "string" and g.title or ""
	for _, name in ipairs(zones) do
		local list = (questSteps[name] >= QUEST_STEPS or titleNames(title, name)) and f.questsIn or f.passes
		list[#list + 1] = name
	end
	if #zones == 0 then f.passes[1] = UI.GuidePlace(g) end
	if player then factCache[g.id] = f end
	return f
end

-- What a guide's turn-ins are worth to this character (Levels.ForGuide),
-- kept while their level and XP stay the same: a turn-in moves the XP.
local xpCache = {}
local function guideXP(id)
	local Lv = ns.Levels
	if not (Lv and Lv.ForGuide) then return nil end
	local p = Lv.Player()
	local key = (p.level or 0) .. ":" .. (p.xp or 0)
	local hit = xpCache[id]
	if hit and hit.key == key then return hit.s end
	local s = Lv.ForGuide(id, p)
	-- Nothing yet (no Codex) is asked again: the Codex may load later.
	if s then xpCache[id] = { key = key, s = s } end
	return s
end

-- Whether guide `fromId`'s `next` offers `id` now (an option with `when`
-- only while it holds: Engine.RouteOffered).
local function offered(fromId, id)
	local E = ns.Engine
	return not (E and E.RouteOffered) or E.RouteOffered(fromId, id)
end

-- Where a guide leads: "Title (lo-hi)", or "Your choice: A or B" for a
-- route choice; nil at the end of a line. Only the options offered now.
local function nextFact(g, byId)
	local function named(id)
		local h = byId[id]
		if not h then return nil end
		local lv = UI.GuideLevels(h)
		return (h.title or id) .. (lv and (" (" .. lv .. ")") or "")
	end
	if type(g.nextChoices) == "table" then
		local ids = {}
		for _, id in ipairs(g.nextChoices) do if byId[id] and offered(g.id, id) then ids[#ids + 1] = id end end
		if #ids > 1 then
			local titles = {}
			for i, id in ipairs(ids) do titles[i] = byId[id].title or id end
			local last = table.remove(titles)
			return string.format(L["Your choice: %s or %s"], table.concat(titles, ", "), last)
		elseif #ids == 1 then
			return named(ids[1])
		end
		if g.nextWhen then return nil end
	end
	return g.next and named(g.next) or nil
end

local LEAVE_POPUP = "POLESTAR_LEAVE_HANDINS"

-- Loading guide `id` in place of the active leveling guide, while the route
-- still hands in finished quests before it (RoutePlan.LeftBehind): asks once
-- in the game's own popup (Load / Cancel). True when it asked. With the
-- gamepad interface, whose focus owns the game's dialogs, chat says it
-- instead and the guide loads.
local function askLeave(id)
	local E, Plan = ns.Engine, ns.RoutePlan
	local cur = E.GetGuide and E.GetGuide()
	if not (cur and cur.id ~= id and (cur.category == nil or cur.category == "Leveling") and Plan and Plan.LeftBehind) then return false end
	local left = Plan.LeftBehind(id)
	if not (left and left.n > 0) then return false end
	local target = ns.Guides.Get(id)
	local what = left.n == 1 and L["1 finished quest in your log is handed in on the route before %s"]:format(target and target.title or id)
		or L["%d finished quests in your log are handed in on the route before %s"]:format(left.n, target and target.title or id)
	if left.xp > 0 then what = string.format(L["%s (%s XP)"], what, ns.Thousands(left.xp)) end
	if ns.GamepadUI() then
		ns.Print(what .. ". " .. L["They stay in your log, and the guide lists who takes each in."])
		return false
	end
	if not (StaticPopupDialogs and StaticPopup_Show) then return false end
	StaticPopupDialogs[LEAVE_POPUP] = StaticPopupDialogs[LEAVE_POPUP] or {
		text = "%s",
		button1 = L["Load guide"],
		button2 = CANCEL,
		OnAccept = function(_, data) P.Load(data, false, true) end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,
	}
	StaticPopup_Show(LEAVE_POPUP, what .. ". " .. L["Load it anyway? They stay in your log, and the guide lists who takes each in."], nil, id)
	return true
end

-- asked: the player has answered askLeave already.
local function load(id, inNewTab, asked)
	local E = ns.Engine
	if not (E and id) then return end
	if inNewTab and E.OpenTab then
		if not E.OpenTab(id) then
			ns.Print(L["Six tabs is the limit. Close one to open another."])
			return
		end
	elseif E.SetGuide then
		if not asked and askLeave(id) then return end
		E.SetGuide(id)
	end
	ns.Set("ui.shown", true)
	if win then win:Hide() end
end
P.Load = load

function P.Selected()
	if onHome then return homeSel or homeTop end
	return uiState().pickerSelected
end

-- The selection, without drawing anew; on Home it is Home's own too.
local function setSelected(id)
	if onHome then homeSel = id end
	uiState().pickerSelected = id
end

function P.Select(id)
	setSelected(id)
	P.Redraw()
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
-- lead (`next` and route choices) once the player is one level below them
-- (Fitz, 2026-11-10: suggestions come one level early, not several; a level
-- 10 player in a 1-12 guide is not sent on to a 12-19 one).
-- Finished guides are left out. Each says why it is listed: "Fits level
-- 24" (its range holds the level), "After Ashenvale" (where that open tab
-- leads).
local FOLLOW_REACH = 1 -- levels below a follow-up's minimum at which it shows

-- -> the guides, { [guide] = why or nil }
local function suggestions(byId, tabs, openIndex)
	local G = ns.Guides
	local player = playerInfo()
	local level = player and player.level
	local faction = player and player.faction
	local out, why, seen = {}, {}, {}
	local function add(id, after)
		if #out >= SUGGEST_MAX or not id or seen[id] or not byId[id] or not ownSide(byId[id], player) then return end
		if after and (openIndex[id] or (level and level + FOLLOW_REACH < (G.Levels(byId[id], faction) or 1))) then return end
		seen[id] = true
		if guideState(id) == "done" then return end
		local g = byId[id]
		out[#out + 1] = g
		if after then
			why[g] = string.format(L["After %s"], after)
		elseif level and G and G.Levels then
			local lo, hi = G.Levels(g, faction)
			if (lo or 1) <= level and level <= (hi or lo or level) then why[g] = string.format(L["Fits level %d"], level) end
		end
	end
	for _, id in ipairs(G and G.Suggestions and G.Suggestions() or {}) do add(id) end
	for _, t in ipairs(tabs or {}) do
		local h = byId[t.guideId]
		if h then
			-- Never an experimental offer: the route choice window offers it.
			for _, c in ipairs(type(h.nextChoices) == "table" and h.nextChoices or { h.next }) do
				if offered(h.id, c) and not (G and G.ExperimentalOffer and G.ExperimentalOffer(h, c)) then add(c, baseTitle(h)) end
			end
		end
	end
	return out, why
end

-- Play next: the top suggestion when it fits the player's level (it has a
-- reason) and is not open in a tab; nothing otherwise (no card, no mark).
-- -> { guide, why } | nil
local playNext
-- The suggestions on show ({ sugg, why }): P.Render works them out again (on
-- show and on each change from outside: tabs, guides, settings); moving
-- about the menu (P.Select, a view, a category, a search) draws again with
-- them (P.Redraw), as ranking every guide each time made garbage.
local shownSugg

local function playNextOf(sugg, why, openIndex)
	local g = sugg[1]
	if g and why[g] and not openIndex[g.id] then return { guide = g, why = why[g] } end
end

-- -> { guide, why } for the suggestion on show, or nil
function P.PlayNext() return playNext end

-- Start: the guide loads when no tab is open, else it opens in a new tab.
local function playNextStart()
	local pn = playNext
	if not pn then return end
	local tabs = tabsInfo()
	load(pn.guide.id, newTabMode or (tabs ~= nil and #tabs > 0))
end

---------------------------------------------------------------------------
-- Middle pane: folders, guide lines, Continue cards
---------------------------------------------------------------------------

-- Back into open tab i, in the guide window: one click from Home.
local function resume(i)
	local E = ns.Engine
	if not (E and i) then return end
	if E.SelectTab then E.SelectTab(i) end
	ns.Set("ui.shown", true)
	if win then win:Hide() end
end

-- A tab card's or tab row's tab, closed (Engine.CloseTab hands an active tab over to
-- its neighbour); TABS_CHANGED draws the list again.
local function closeCard(c)
	local E = ns.Engine
	if E and E.CloseTab and c.psIndex then E.CloseTab(c.psIndex) end
end

-- A tab card's or tab row's right-click (the card's ··· too, the menu under
-- it: anchor): its tab's options, as on the guide window's strip.
local function cardMenu(c, anchor)
	local E = ns.Engine
	local i = c.psIndex
	if not (E and E.CloseTab and i) then return end
	local tabs = tabsInfo() or {}
	W.ShowMenu(anchor or c, {
		{ text = L["Close tab"], icon = "close", onClick = function() E.CloseTab(i) end },
		{ text = L["Move left"], icon = "chevron-left", disabled = i <= 1 or not E.MoveTab, onClick = function() E.MoveTab(i, i - 1) end },
		{ text = L["Move right"], icon = "chevron-right", disabled = i >= #tabs or not E.MoveTab, onClick = function() E.MoveTab(i, i + 1) end },
	}, { point = "TOPLEFT", relPoint = "BOTTOMLEFT", x = 0, y = -2 })
end

-- A Browse folder's header folds its guides away and back (#1358): a click,
-- or A on a gamepad. Its count stays; the chevron at the right points down
-- while open, right while folded. Elsewhere (Home, Current, Recent, a
-- search) a header is only a label.
local function folderPaint(f, hover)
	local tone = hover and "textDim" or "textMuted"
	W.Color(f.Text, tone)
	W.Color(f.Chevron, tone)
end

local function folderClick(self)
	if self.psFolder then P.ToggleFolder(self.psFolder) end
end

local function folderEnter(self)
	if not self.psFolder then return end
	folderPaint(self, true)
	W.SimpleTip(self)
end

local function folderLeave(self)
	folderPaint(self, false)
	W.HideTip(self)
end

local function folderRow(i)
	local f = folderPool[i]
	if f then return f end
	f = CreateFrame("Button", nil, win.Body)
	f:SetHeight(FOLDER_H)
	W.Hover(f)
	f.Text = W.Text(f, "label", "textMuted")
	f.Chevron = W.Tex(f, "ARTWORK", "chevron-down", "textMuted")
	f.Chevron:SetSize(12, 12)
	f.Chevron:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -TEXT_X, 7)
	f.Count = W.Text(f, "number", "textMuted")
	f.Count:SetJustifyH("RIGHT")
	-- "Suggested", on a folded Browse band that holds the suggested guide.
	f.Mark = W.Chip(f)
	f.Mark:SetPoint("BOTTOMLEFT", f.Text, "BOTTOMRIGHT", 8, -4)
	f.Mark:Hide()
	f.Rule = W.Divider(f, false, 0.7)
	f.Rule:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", TEXT_X, 0)
	f.Rule:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -TEXT_X, 0)
	f:SetScript("OnClick", folderClick)
	f:SetScript("OnEnter", folderEnter)
	f:SetScript("OnLeave", folderLeave)
	folderPool[i] = f
	return f
end

-- id: the folder's id where it folds (Browse without a search), else nil.
-- inline: Home's label, LABEL_H tall with no hairline, its count after it.
local function paintFolder(f, text, count, id, inline, mark)
	f.psFolder = id
	if mark then W.SetChip(f.Mark, L["Suggested"], "accent") end
	f.Mark:SetShown(mark and true or false)
	local collapsed = id ~= nil and P.IsCollapsed(id)
	f.psCollapsed = collapsed
	f:SetHeight(inline and LABEL_H or FOLDER_H)
	f.Rule:SetShown(not inline)
	f.Text:SetText(text)
	f.Text:ClearAllPoints()
	f.Count:SetText(count or "")
	f.Count:ClearAllPoints()
	if inline then
		f.Text:SetPoint("LEFT", f, "LEFT", TEXT_X, 0)
		f.Count:SetPoint("LEFT", f.Text, "RIGHT", 8, 0)
	else
		f.Text:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", TEXT_X, 7)
	end
	if id then
		f.Chevron:SetTexture(Theme.Media(collapsed and "chevron-right" or "chevron-down"))
		f.Count:SetPoint("BOTTOMRIGHT", f.Chevron, "BOTTOMLEFT", -6, 0)
		f.psPadLabel = collapsed and L["Expand"] or L["Collapse"]
		f.psTip = f.psPadLabel
	elseif not inline then
		f.Count:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -TEXT_X, 7)
		f.psTip, f.psPadLabel = nil, nil
	else
		f.psTip, f.psPadLabel = nil, nil
	end
	f.Chevron:SetShown(id ~= nil)
	f:EnableMouse(id ~= nil)
	f:SetEnabled(id ~= nil)
	f.psPadSkip = id == nil or nil
	folderPaint(f, false)
end

local function rowClick(self, button)
	if button == "RightButton" then
		if self.psIndex then cardMenu(self) end
		return
	end
	if self.psGuide then P.Select(self.psGuide.id) end
end

local function rowDoubleClick(self)
	if not self.psGuide then return end
	if self.psIndex then return resume(self.psIndex) end
	setSelected(self.psGuide.id)
	P.LoadSelected()
end

-- The Forever mark on the row of a guide in Forever's new zones: under the
-- cursor it says what the zone is (and that an experimental guide is a work
-- in progress), and the row keeps its hover wash; a click on it is the row's.
local function foreverEnter(self)
	self:GetParent():LockHighlight()
	local g = self:GetParent().psGuide
	local text = isExperimental(g) and L["This zone is new in Forever. Its guide is experimental and still a work in progress: thanks for trying it."]
		or L["This zone is new in Forever."]
	W.Tooltip(self, "ANCHOR_RIGHT", L["New in Forever"], { text })
end
local function foreverLeave(self)
	self:GetParent():UnlockHighlight()
	W.HideTooltip(self)
end
local function foreverClick(self) rowClick(self:GetParent()) end
local function foreverDoubleClick(self) rowDoubleClick(self:GetParent()) end
-- The mark's glyph (16 x 8, Media/UI/icon-forever) and the box under the
-- cursor around it.
local FOREVER_W, FOREVER_H, FOREVER_BOX = 16, 8, 18

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
	-- On Home: the guide's category glyph before the title, and a hairline
	-- over every row after a section's first.
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(14, 14)
	r.Icon:SetPoint("LEFT", r, "LEFT", TEXT_X, 0)
	r.Icon:Hide()
	r.Rule = W.Divider(r, false, 0.5)
	r.Rule:SetPoint("TOPLEFT", r, "TOPLEFT", TEXT_X, 0)
	r.Rule:SetPoint("TOPRIGHT", r, "TOPRIGHT", -TEXT_X, 0)
	r.Rule:Hide()
	r.Title = W.Text(r, "body", "text")
	r.Range = W.Text(r, "body", "textMuted")
	r.Range:SetPoint("LEFT", r.Title, "RIGHT", 5, 0)
	-- A guide in one of Forever's new zones: the Forever mark after the
	-- range, in its own gold as quest texts show it (Guides.InForeverZone).
	r.Forever = CreateFrame("Button", nil, r)
	r.Forever:SetSize(FOREVER_W + 4, FOREVER_BOX)
	r.Forever:SetPoint("LEFT", r.Range, "RIGHT", 4, 0)
	r.Forever.Mark = W.Tex(r.Forever, "ARTWORK", "icon-forever")
	r.Forever.Mark:SetSize(FOREVER_W, FOREVER_H)
	r.Forever.Mark:SetPoint("CENTER", r.Forever, "CENTER", 0, 0)
	r.Forever:SetScript("OnEnter", foreverEnter)
	r.Forever:SetScript("OnLeave", foreverLeave)
	r.Forever:SetScript("OnClick", foreverClick)
	r.Forever:SetScript("OnDoubleClick", foreverDoubleClick)
	r.Forever:Hide()
	-- A guide with group content (compiled `group`): "Group" after the range
	-- and that mark.
	r.Group = W.Chip(r)
	r.Group:SetPoint("LEFT", r.Range, "RIGHT", 6, 0)
	r.Group:Hide()
	-- An open guide's tab ("Tab 2", "Tab 2 · 25%").
	r.Note = W.Text(r, "small", "textMuted")
	r.Note:SetJustifyH("RIGHT")
	r.Note:SetPoint("RIGHT", r, "RIGHT", -TEXT_X, 0)
	-- The suggested guide in Browse: "Suggested" left of the note, with the accent bar.
	r.Suggest = W.Chip(r)
	r.Suggest:Hide()
	-- An open tab's progress on Home: a 56 bar and its percent at the right.
	r.Pct = W.Text(r, "number", "textMuted")
	r.Pct:SetJustifyH("RIGHT")
	r.Pct:SetWidth(32)
	r.Pct:SetPoint("RIGHT", r, "RIGHT", -TEXT_X, 0)
	r.Pct:Hide()
	r.Mini = W.ProgressLine(r, 2)
	r.Mini:SetWidth(56)
	r.Mini:SetPoint("RIGHT", r.Pct, "LEFT", -8, 0)
	r.Mini:Hide()
	r:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	r:SetScript("OnClick", rowClick)
	r:SetScript("OnDoubleClick", rowDoubleClick)
	r:SetScript("OnEnter", W.SimpleTip)
	r:SetScript("OnLeave", W.HideTip)
	rowPool[i] = r
	return r
end

local TITLE_MIN = 120 -- a row's title keeps this much before its note gives up more
local NOTE_MIN = 24 -- a note with less room than this is left out

-- note: the right-hand text ("Tab 2", "Tab 2 · 25%"), or nil; title: the
-- title to show (P.Titles), else the guide's own. home: Home's row, { rule
-- = a hairline over it, frac = an open tab's progress, index = that tab }.
local function paintRow(r, g, note, width, title, home, suggested)
	r.psGuide = g
	r.psIndex = home and home.index or nil
	r.psCard = r.psIndex and true or nil
	r:SetHeight(home and HOME_ROW_H or ROW_H)
	r.Rule:SetShown(home and home.rule and true or false)
	r.Icon:SetShown(home ~= nil)
	if home then r.Icon:SetTexture(Theme.Media(CATEGORY_ICON[categoryOf(g)] or "icon-level")) end
	local iconW = home and (14 + 10) or 0
	r.Title:ClearAllPoints()
	r.Title:SetPoint("LEFT", r, "LEFT", TEXT_X + iconW, 0)
	local frac = home and home.frac
	r.Mini:SetShown(frac ~= nil)
	r.Pct:SetShown(frac ~= nil)
	local barW = 0
	if frac then
		W.SetProgress(r.Mini, frac, 56)
		r.Pct:SetText(floor(frac * 100 + 0.5) .. "%")
		barW = 32 + 8 + 56 + 12
	end
	r.Note:ClearAllPoints()
	r.Note:SetPoint("RIGHT", r, "RIGHT", -(TEXT_X + barW), 0)
	local sel = P.Selected() == g.id
	r.Selected:SetShown(sel)
	r.Bar:SetShown(sel or suggested == true)
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
	r.Title:SetText(title or g.title or g.id)
	W.Color(r.Title, sel and "text" or ((done or gate) and "textDim" or "text"))
	if home then W.Color(r.Icon, sel and "accent" or "textMuted") end
	-- On the selected row's wash the muted range and tab note go a step up,
	-- so they keep 4.5:1 there as on the plain ground.
	W.Color(r.Range, sel and "textDim" or "textMuted")
	W.Color(r.Note, sel and "textDim" or "textMuted")
	local lv = UI.GuideLevels(g)
	r.Range:SetText(lv and ("(" .. lv .. ")") or "")
	local expW = inForeverZone(g) and (FOREVER_W + 4 + 4) or 0
	r.Forever:SetShown(expW > 0)
	local groupW = g.group == true and (W.SetChip(r.Group, L["Group"], "dungeon") + 6) or 0
	r.Group:SetShown(groupW > 0)
	r.Group:ClearAllPoints()
	r.Group:SetPoint("LEFT", expW > 0 and r.Forever or r.Range, "RIGHT", expW > 0 and 2 or 6, 0)
	-- A pack's guide carries its pack's title, except in that pack's own list.
	local pack = packOf(g)
	if pack and not (view == "browse" and category == PACK .. pack.id) then
		note = note and (note .. DOT .. (pack.title or pack.id)) or (pack.title or pack.id)
	end
	-- A pooled row keeps its last note's width, and GetStringWidth includes
	-- truncation: measure from an unbounded width.
	r.Note:SetWidth(0)
	r.Note:SetText(note or "")
	-- The note never takes more than 45% of the row, and gives way first: the
	-- title keeps TITLE_MIN (or its whole width, if shorter) beside the range
	-- and chip, and the note gets what is left, cut with "..."; with next to
	-- nothing left it is dropped, so nothing draws over the chip.
	local full = floor(r.Title:GetStringWidth() + 1)
	-- The suggested mark sits left of the note, else at the row's right edge.
	local sugW = 0
	if suggested then
		sugW = W.SetChip(r.Suggest, L["Suggested"], "accent") + 8
	end
	r.Suggest:SetShown(suggested == true)
	local left = width - TEXT_X * 2 - iconW - barW - sugW - (lv and (r.Range:GetStringWidth() + 5) or 0) - groupW - expW
	local natural = note and floor(r.Note:GetStringWidth() + 1) or 0
	local noteW = note and min(natural, floor(width * 0.45), left - min(full, TITLE_MIN) - 12) or 0
	-- Left out only when cut below NOTE_MIN; a short note ("Test") shows whole.
	if noteW < min(NOTE_MIN, natural) then
		noteW = 0
		r.Note:SetText("")
	end
	r.Note:SetWidth(noteW)
	if suggested then
		r.Suggest:ClearAllPoints()
		if noteW > 0 then r.Suggest:SetPoint("RIGHT", r.Note, "LEFT", -8, 0) else r.Suggest:SetPoint("RIGHT", r, "RIGHT", -TEXT_X, 0) end
	end
	local room = left - (noteW > 0 and (noteW + 12) or 0)
	r.Title:SetWidth(max(40, min(room, full)))
	-- A name cut short reads whole in the tooltip, over how to load it.
	if full > max(40, room) then
		r.psTip = (title or g.title or g.id) .. (lv and (" (" .. lv .. ")") or "")
		r.psTipLines = { loadHint() }
	else
		r.psTip, r.psTipLines = loadHint(), nil
	end
	-- An open tab's row has the tab's menu on a right-click (cardMenu).
	if r.psIndex then
		r.psTipLines = r.psTipLines or {}
		r.psTipLines[#r.psTipLines + 1] = { L["Right-click for tab options"], Theme.Accent() }
	end
	r:SetWidth(width)
end

-- A stable stretch of night sky per guide, so neighbours never look cloned.
local function skyIndex(id)
	local n = 0
	for i = 1, #id do n = (n * 31 + id:byte(i)) % 997 end
	return n + 1
end

-- Home's card: the active tab ("Tab 1 · active", its full name, its
-- current step, its progress, Continue and the ··· tab menu) or, with no tab
-- open, the top suggestion ("Start here", why, its steps and quests, Load
-- guide), over its zone's art darkened toward the text. A click selects its
-- guide, a double-click continues or loads it.
local hero

local function heroGo(c)
	if c.psIndex then return resume(c.psIndex) end
	if c.psGuide then load(c.psGuide.id, newTabMode) end
end

local function heroClick(self, button)
	if button == "RightButton" then
		if self.psIndex then cardMenu(self) end
		return
	end
	if self.psGuide then P.Select(self.psGuide.id) end
end

local function heroDoubleClick(self, button)
	if button == nil or button == "LeftButton" then heroGo(self) end
end

local function heroCard()
	if hero then return hero end
	local w = MID_W - SH.pad * 2
	local c = CreateFrame("Button", nil, win.Body)
	hero = c
	P.hero = c
	c.psCard = true
	c:SetSize(w, HERO_H)
	Theme.Skin(c, "panel")
	W.Hover(c)
	c.Art = ZoneArt.Create(c, w - 2, HERO_H - 2, "panel", 0.3)
	c.Art:SetPoint("TOPLEFT", c, "TOPLEFT", 1, -1)
	c.Art.psZoom = 1.6
	c.Art:SetAlpha(0.6)
	-- The text and buttons above the painting, on a ground that runs from
	-- the panel's colour at the left to half of it at the right.
	c.Front = CreateFrame("Frame", nil, c)
	c.Front:SetAllPoints(c)
	c.Front:SetFrameLevel(c.Art.Over:GetFrameLevel() + 1)
	c.Scrim = c.Front:CreateTexture(nil, "BACKGROUND")
	c.Scrim:SetTexture(Theme.Media("white"))
	c.Scrim:SetPoint("TOPLEFT", c, "TOPLEFT", 1, -1)
	c.Scrim:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", -1, 1)
	W.Painter(c.Scrim, function(t)
		local r, g, b = Theme.Color("panel")
		if t.SetGradient and CreateColor then
			t:SetVertexColor(1, 1, 1, 1)
			t:SetGradient("HORIZONTAL", CreateColor(r, g, b, 0.95), CreateColor(r, g, b, 0.5))
		else
			t:SetVertexColor(r, g, b, 0.8)
		end
	end)
	c.Eyebrow = W.Text(c.Front, "caption", "accent")
	c.Eyebrow:SetPoint("TOPLEFT", c, "TOPLEFT", HERO_PAD, -14)
	c.Title = W.Text(c.Front, "title", "text")
	c.Title:SetPoint("TOPLEFT", c, "TOPLEFT", HERO_PAD, -30)
	c.Range = W.Text(c.Front, "body", "textMuted")
	c.Range:SetPoint("LEFT", c.Title, "RIGHT", 6, 0)
	c.Group = W.Chip(c.Front)
	c.Group:SetPoint("LEFT", c.Range, "RIGHT", 8, 0)
	c.Group:Hide()
	c.Step = W.Text(c.Front, "small", "textDim")
	c.Step:SetPoint("TOPLEFT", c, "TOPLEFT", HERO_PAD, -58)
	c.Step:SetWidth(w - HERO_PAD * 2)
	c.More = W.IconButton(c.Front, "menu", 24, L["Tab options"], function(self) cardMenu(hero, self) end, 14)
	c.More:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", -HERO_PAD, 14)
	c.Go = W.Button(c.Front, L["Continue"], function() heroGo(hero) end, { primary = true, height = 24 })
	c.Pct = W.Text(c.Front, "number", "textDim")
	c.Pct:SetJustifyH("RIGHT")
	c.Pct:SetPoint("RIGHT", c.Go, "LEFT", -12, 0)
	c.Line = W.ProgressLine(c.Front, 2)
	c.Line:SetPoint("LEFT", c, "BOTTOMLEFT", HERO_PAD, 14 + 12)
	c.Meta = W.Text(c.Front, "small", "textMuted")
	c.Meta:SetPoint("LEFT", c, "BOTTOMLEFT", HERO_PAD, 14 + 12)
	c:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	c:SetScript("OnClick", heroClick)
	c:SetScript("OnDoubleClick", heroDoubleClick)
	c:SetScript("OnEnter", W.SimpleTip)
	c:SetScript("OnLeave", W.HideTip)
	return c
end

-- The card's name, whole where the line has room, cut short past it; the
-- tooltip then has it whole. -> the card's tooltip title
local function heroTitle(c, g, title)
	local inner = c:GetWidth() - HERO_PAD * 2
	local lv = UI.GuideLevels(g)
	c.Range:SetText(lv and ("(" .. lv .. ")") or "")
	local groupW = g.group == true and (W.SetChip(c.Group, L["Group"], "dungeon") + 8) or 0
	c.Group:SetShown(groupW > 0)
	c.Title:SetWidth(0)
	c.Title:SetText(title)
	local full = math.ceil(W.TextWidth(c.Title)) + 1
	local room = inner - (lv and (math.ceil(W.TextWidth(c.Range)) + 6) or 0) - groupW
	c.Title:SetWidth(max(40, min(full, room)))
	if full > room then return title .. (lv and (" (" .. lv .. ")") or "") end
	return nil
end

local function paintArt(c, g)
	local E = ns.Engine
	local fx, fy
	if E and E.GuideFocus then fx, fy = E.GuideFocus(g.id) end
	c.psArt = ZoneArt.Paint(c.Art, g.zone, fx, fy, skyIndex(g.id))
end

-- The active tab's card at y. -> the y under it
local function layoutHero(t, i, byId, y)
	local c = heroCard()
	local g = byId[t.guideId] or { id = t.guideId, title = t.title }
	c.psGuide, c.psIndex = g, i
	paintArt(c, g)
	c.Eyebrow:SetText(ns.Upper(string.format(L["Tab %d  \194\183  active"], i)))
	local cut = heroTitle(c, g, t.title or baseTitle(g))
	c.psTip = cut or loadHint()
	c.psTipLines = { { L["Right-click for tab options"], Theme.Accent() } }
	if cut then table.insert(c.psTipLines, 1, loadHint()) end
	-- Its current step, as the guide window counts it.
	local E = ns.Engine
	local full = E and E.GetGuide and E.GetGuide()
	local step = t.stepIndex and full and full.id == t.guideId and type(full.steps) == "table" and full.steps[t.stepIndex]
	if t.complete then
		c.Step:SetText(ns.LC("guide status", "Completed"))
	elseif t.stepIndex then
		local no, of = t.stepNumber or t.stepIndex, t.stepTotal or t.stepCount or 0
		local title = type(step) == "table" and type(step.title) == "string" and step.title ~= "" and step.title
		c.Step:SetText(title and string.format(L["Step %d of %d: %s"], no, of, title) or string.format(L["Step %d of %d"], no, of))
	else
		c.Step:SetText("")
	end
	W.SetButtonText(c.Go, L["Continue"])
	c.Go:ClearAllPoints()
	c.Go:SetPoint("RIGHT", c.More, "LEFT", -8, 0)
	c.More:Show()
	local total = t.total or t.stepCount or 0
	local frac = total > 0 and (t.done or 0) / total or 0
	c.Pct:SetText(floor(frac * 100 + 0.5) .. "%")
	c.Pct:Show()
	local lineW = c:GetWidth() - HERO_PAD * 2 - 24 - 8 - c.Go:GetWidth() - 12 - math.ceil(W.TextWidth(c.Pct)) - 12
	c.Line:SetWidth(max(20, lineW))
	W.SetProgress(c.Line, frac, max(20, lineW))
	c.Line:Show()
	c.Meta:Hide()
	c:ClearAllPoints()
	c:SetPoint("TOPLEFT", win.Body, "TOPLEFT", SH.pad, -y)
	c:Show()
	return y + HERO_H
end

-- "Start here": the top suggestion's card at y; why: its reason. -> the y under it
local function layoutStart(g, why, y)
	local c = heroCard()
	c.psGuide, c.psIndex = g, nil
	paintArt(c, g)
	c.Eyebrow:SetText(ns.Upper(L["Start here"]))
	local cut = heroTitle(c, g, baseTitle(g))
	c.psTip = cut or loadHint()
	c.psTipLines = cut and { loadHint() } or nil
	-- The race's own starting zone says so; another guide says why it is here.
	local player = playerInfo()
	local race = player and player.race
	local own = false
	for _, r in ipairs(type(g.races) == "table" and g.races or {}) do if r == race then own = true end end
	c.Step:SetText(own and (g.minLevel or 1) <= 1 and L["The leveling guide for your race's starting zone."] or why or "")
	local parts = {}
	if g.stepCount then parts[1] = g.stepCount == 1 and L["1 step"] or string.format(L["%d steps"], g.stepCount) end
	local q = guideFacts(g).quests
	if q > 0 then parts[#parts + 1] = q == 1 and L["1 quest"] or string.format(L["%d quests"], q) end
	c.Meta:SetText(table.concat(parts, DOT))
	c.Meta:Show()
	W.SetButtonText(c.Go, L["Load guide"])
	c.Go:ClearAllPoints()
	c.Go:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", -HERO_PAD, 14)
	c.More:Hide()
	c.Pct:Hide()
	c.Line:Hide()
	c:ClearAllPoints()
	c:SetPoint("TOPLEFT", win.Body, "TOPLEFT", SH.pad, -y)
	c:Show()
	return y + HERO_H
end

-- The Play next card (Home under the active tab's card, Browse above the
-- list): the zone's art at its left, "Play next", the guide and its levels,
-- why it is suggested, and Start. One focus stop for the pad (Start is the X
-- action there).
local PLAY_H, PLAY_ART = 108, 72

local playCard
local playDrawn -- the card was drawn by this render

local function playNextCard()
	local c = playCard
	if c then return c end
	c = CreateFrame("Button", nil, win.Body)
	c:SetHeight(PLAY_H)
	Theme.Skin(c, "button")
	c.Sel = c:CreateTexture(nil, "BACKGROUND")
	c.Sel:SetTexture(Theme.Media("white"))
	c.Sel:SetAllPoints(c)
	W.Painter(c.Sel, function(t) t:SetVertexColor(Theme.Wash("selected")) end)
	c.Art = ZoneArt.Create(c, PLAY_ART, PLAY_H, "panel", 0.1)
	c.Art:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
	c.Ring = W.Tex(c, "OVERLAY", "white", "accent")
	c.Ring:SetHeight(1)
	c.Ring:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
	c.Ring:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, 0)
	c.Eyebrow = W.Text(c, "label", "accent")
	c.Eyebrow:SetPoint("TOPLEFT", c, "TOPLEFT", PLAY_ART + 14, -10)
	c.Eyebrow:SetText(L["Play next"])
	c.Title = W.Text(c, "body", "text")
	c.Title:SetPoint("TOPLEFT", c, "TOPLEFT", PLAY_ART + 14, -28)
	c.Range = W.Text(c, "body", "textMuted")
	c.Range:SetPoint("LEFT", c.Title, "RIGHT", 5, 0)
	c.Why = W.Text(c, "note", "textDim")
	c.Why:SetWordWrap(true)
	c.Why:SetJustifyV("TOP")
	c.Why:SetPoint("TOPLEFT", c, "TOPLEFT", PLAY_ART + 14, -48)
	c.Start = W.Button(c, L["Start"], playNextStart, { primary = true, height = 22 })
	c.Start:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", -12, 10)
	c.psPlayNext = true
	c:SetScript("OnClick", rowClick)
	c:SetScript("OnDoubleClick", playNextStart)
	c:SetScript("OnEnter", W.SimpleTip)
	c:SetScript("OnLeave", W.HideTip)
	playCard = c
	return c
end

-- Draws the card at x, y, width wide. -> the y under it
local function layoutPlayNext(x, y, width)
	playDrawn = true
	local pn = playNext
	local g = pn.guide
	local c = playNextCard()
	c.psGuide = g
	c.psTip = loadHint()
	c.Sel:SetShown(P.Selected() == g.id)
	local E = ns.Engine
	local fx, fy
	if E and E.GuideFocus then fx, fy = E.GuideFocus(g.id) end
	ZoneArt.Paint(c.Art, g.zone, fx, fy, skyIndex(g.id))
	local textW = width - PLAY_ART - 14 - 12
	c.Range:SetText("")
	c.Title:SetWidth(0)
	c.Title:SetText(baseTitle(g))
	local lv = UI.GuideLevels(g)
	c.Range:SetText(lv and ("(" .. lv .. ")") or "")
	c.Title:SetWidth(max(40, min(textW - (lv and (c.Range:GetStringWidth() + 5) or 0), floor(c.Title:GetStringWidth() + 1))))
	c.Why:SetWidth(textW)
	c.Why:SetText(pn.why or "")
	c:SetWidth(width)
	c:ClearAllPoints()
	c:SetPoint("TOPLEFT", win.Body, "TOPLEFT", x, -y)
	c:Show()
	return y + PLAY_H
end

-- Home's way into the rest: Leveling, Class and Professions with their
-- counts (those with guides for this character), then Import.
local actPool = {}
local function act(i)
	local b = actPool[i]
	if b then return b end
	b = W.Button(win.Body, "", function(self) self.psGo() end, { height = 32, icon = "compact" })
	-- Its count after the label, in the faintest text colour.
	b.Count = W.Text(b, "number", "textOff")
	b.Count:SetPoint("LEFT", b.Label, "RIGHT", 8, 0)
	actPool[i] = b
	return b
end

-- -> the y under the row
local function layoutActs(counts, y)
	local items = {}
	for _, c in ipairs({ "Leveling", "Class", "Professions" }) do
		local n = counts[c] or 0
		if n > 0 then items[#items + 1] = { label = L[c], count = n, icon = CATEGORY_ICON[c], go = function() P.SetCategory(c) end } end
	end
	for _, s in ipairs(P.Sections()) do
		if s.key == "Import" then items[#items + 1] = { label = s.label or L["Import"], icon = "plus", go = function() P.ShowSection("Import") end } end
	end
	local x, line = SH.pad, 0
	local right = MID_W - SH.pad
	for i, it in ipairs(items) do
		local b = act(i)
		b.psGo = it.go
		b.Icon:SetTexture(Theme.Media(it.icon or "compact"))
		W.SetButtonText(b, it.label)
		b.Count:SetText(it.count or "")
		b.Count:SetShown(it.count ~= nil)
		if it.count then
			-- The label and its count centred together.
			local cw = math.ceil(W.TextWidth(b.Count)) + 8
			b.psLabelX = (b.psLabelX or 0) - cw / 2
			b.Label:SetPoint("CENTER", b, "CENTER", b.psLabelX, 0)
			b:SetWidth(b:GetWidth() + cw)
		end
		local bw = b:GetWidth()
		if x > SH.pad and x + bw > right then
			x, line = SH.pad, line + 1
		end
		b:ClearAllPoints()
		b:SetPoint("TOPLEFT", win.Body, "TOPLEFT", x, -(y + line * (32 + 8)))
		b:Show()
		x = x + bw + 8
	end
	for i = #items + 1, #actPool do actPool[i]:Hide() end
	if #items == 0 then return y end
	return y + (line + 1) * 32 + line * 8
end

-- The open tabs in the order Home lists them: the active one, then the most
-- recently used (P.Recent, kept on GUIDE_CHANGED), then the rest as the tabs run.
local function cardOrder(tabs, active)
	local order, taken, at = {}, {}, {}
	local function take(i)
		if i and tabs[i] and not taken[i] then
			taken[i] = true
			order[#order + 1] = i
		end
	end
	for i, t in ipairs(tabs) do at[t.guideId] = at[t.guideId] or i end
	take(active)
	for _, id in ipairs(P.Recent()) do take(at[id]) end
	for i = 1, #tabs do take(i) end
	return order
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
	-- Over a value cut short (Quests in, Passes through): the whole of it on hover.
	f.Hit = CreateFrame("Frame", nil, details)
	f.Hit:SetAllPoints(f.Value)
	f.Hit:SetScript("OnEnter", W.SimpleTip)
	f.Hit:SetScript("OnLeave", W.HideTip)
	f.Hit:Hide()
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
-- -> whether some were left out
local function fitZones(fs, zones)
	for k = #zones, 1, -1 do
		local text = table.concat(zones, ARROW, 1, k)
		if k < #zones then text = text .. ARROW .. ELLIPSIS end
		fs:SetText(text)
		if fs:GetNumLines() <= 2 then return k < #zones end
	end
	return #zones > 1
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
	ns.DragWindow(d.Art, win)
	-- The window's close button moves to the art's corner, where the shell
	-- keeps it; the star beside it.
	win.Close:SetParent(d.Art.Over)
	win.Close:ClearAllPoints()
	win.Close:SetPoint("TOPRIGHT", d.Art, "TOPRIGHT", -12, -12)
	d.Star = W.IconButton(d.Art.Over, "star", 28, L["Add to favourites"], function()
		P.ToggleFavorite(P.Selected())
	end, 14)
	d.Star:SetPoint("RIGHT", win.Close, "LEFT", -4, 0)
	-- On a bright painting the glyphs need a dark ground of their own: 4 past
	-- them at either end, 2 above and below. In the game's looks the close is
	-- the frame's own, on its corner (W.FrameClose), and the ground holds the
	-- star alone, still clear of that corner. The Guides scale's button, while
	-- it stands left of the star (win.psPlaceScale), shares it.
	d.Scrim = W.Pill(d.Art.Over, 68, 32)
	function d.FitScrim()
		local p = d.Scrim
		local alone = Theme.Kit() ~= nil
		p:SetWidth((alone and 36 or 68) + (rawget(d, "psScaleHere") and 32 or 0))
		p:ClearAllPoints()
		p:SetPoint("TOPRIGHT", alone and d.Star or win.Close, "TOPRIGHT", 4, 2)
	end
	W.Painter(d.Scrim, function(p)
		local r, g, b = Theme.Color("scrim")
		p:SetColor(r, g, b, 0.6)
		d.FitScrim()
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
	-- "Suggested for you" and why, over the chips on the top suggestion.
	d.LeadHead = W.Text(d, "label", "accent")
	d.LeadHead:SetText(L["Suggested for you"])
	d.LeadHead:Hide()
	d.LeadWhy = W.Text(d, "note", "textDim")
	d.LeadWhy:SetWordWrap(true)
	d.LeadWhy:SetJustifyV("TOP")
	d.LeadWhy:SetWidth(DETAIL_W - DPAD * 2)
	d.LeadWhy:Hide()
	-- What a leveling guide is worth in levels; hovering opens its panel
	-- (UI/LevelTip.lua) on the window.
	d.XP = UI.LevelTip.Chip(d, win)
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

local function setButtonWidth(b, w)
	b.psFixedWidth = w
	W.SetButtonText(b, b.Label:GetText())
end

local function setPrimary(b, on)
	b.psPrimary = on
	W.RepaintButton(b)
end

-- A guide's credits: "By <author>" for ours ("By Polestar · Experimental"
-- for one of its experimental guides); for a pack's guide "By <author> ·
-- <pack title> <version> · <licence>" (an imported guide: "By <author> ·
-- Imported · <its own licence>"). The author is the guide's own, else its
-- pack's. -> text or nil, the pack's source or nil
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
		local license = pack.license or (pack.imported and type(g.license) == "string" and g.license or nil)
		if license then parts[#parts + 1] = license end
	end
	if isExperimental(g) then parts[#parts + 1] = L["Experimental"] end
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
		d.LeadHead:Hide()
		d.LeadWhy:Hide()
		for _, c in ipairs(d.Chips) do c:Hide() end
		UI.LevelTip.Set(d.XP, nil)
		for _, f in ipairs(d.Facts) do
			f.Label:Hide()
			f.Value:Hide()
			f.Hit:Hide()
		end
		for _, t in ipairs(d.Rewards) do t:Hide() end
		d.EmptyTitle:Show()
		d.EmptyNote:Show()
		P.detail = nil
		d.psReadFor = nil
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
	-- Its own faction left out of the title, as on its row (P.Titles): the chips say it.
	d.Title:SetText(baseTitle(g))

	-- Chips: levels, what a leveling guide is worth in levels, Forever's new
	-- zone, experimental, group content, faction, races, classes; on two
	-- lines at most.
	local y = ART_H + 16
	-- The top suggestion leads with why, above the chips.
	local lead = playNext and playNext.guide.id == g.id
	d.LeadHead:SetShown(lead and true or false)
	d.LeadWhy:SetShown(lead and playNext.why ~= nil)
	if lead then
		d.LeadHead:ClearAllPoints()
		d.LeadHead:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -y)
		y = y + 16
		if playNext.why then
			d.LeadWhy:SetText(playNext.why)
			d.LeadWhy:ClearAllPoints()
			d.LeadWhy:SetPoint("TOPLEFT", d, "TOPLEFT", DPAD, -y)
			y = y + d.LeadWhy:GetStringHeight() + 4
		end
		y = y + 8
	end
	local n, x, line, full = 0, DPAD, 0, false
	local function place(c, w)
		if full then
			c:Hide()
			return false
		end
		if x > DPAD and x + w > DPAD + inner then
			if line == 1 then
				c:Hide()
				full = true
				return false
			end
			line, x = 1, DPAD
		end
		c:ClearAllPoints()
		c:SetPoint("TOPLEFT", d, "TOPLEFT", x, -(y + line * (W.CHIP_H + 6)))
		x = x + w + 6
		return true
	end
	local function addChip(text, kind)
		if full then return end
		local c = detailChip(n + 1)
		if place(c, W.SetChip(c, text, kind)) then n = n + 1 end
	end
	local lv = UI.GuideLevels(g)
	if lv then addChip(L["Levels"] .. " " .. lv, "accent") end
	local xw = UI.LevelTip.Set(d.XP, g.category == "Leveling" and guideXP(g.id) or nil,
		{ head = L["If you finish this guide"], need = L["You are level %d. Level %d is recommended for this guide; from there:"] })
	if xw and place(d.XP, xw) then
		-- Its panel starts on the details' text edge, not the chip's: the
		-- pane ends at the window's right edge.
		local _, _, _, cx = d.XP:GetPoint(1)
		d.XP.psTipX = DPAD - (cx or DPAD)
	end
	if inForeverZone(g) then addChip(L["Forever"]) end
	if isExperimental(g) then addChip(L["Experimental"], "experimental") end
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
		label = tab.stepIndex and string.format(L["Open in tab %d  \194\183  step %d of %d"], tabIndex, tab.stepNumber or tab.stepIndex, tab.stepTotal or tab.stepCount or 0)
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
	-- and `why`), then steps, the quests this character takes, the zones it
	-- quests in and those it passes through (each in route order), where the
	-- guide leads. Reward entries are tiles: those given outright under
	-- "Reward", a choice under "Choose one".
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
	-- A Class guide: the same heads-up the class-quest card gives (QoL/ClassQuests.lua).
	local CQ, G = ns.QoL and ns.QoL.ClassQuests, ns.Guides
	local full = g.category == "Class" and CQ and CQ.Heads and G and G.Get and G.Get(g.id)
	if type(full) == "table" then
		local steps, fresh = G.Peek(g.id)
		if type(steps) == "table" then
			local okP, player = pcall(ns.Compat.GetPlayerInfo)
			local heads = CQ.HeadsLine(CQ.Heads(full, okP and type(player) == "table" and player or {}), full)
			if heads then facts[#facts + 1] = { L["Heads-up"], heads } end
		end
		G.Unpeek(g.id, fresh)
	end
	if g.stepCount then facts[#facts + 1] = { L["Steps"], tostring(g.stepCount) } end
	if info.quests > 0 then facts[#facts + 1] = { L["Quests"], tostring(info.quests) } end
	if #info.questsIn > 0 then facts[#facts + 1] = { L["Quests in"], info.questsIn, "textDim" } end
	if #info.passes > 0 then facts[#facts + 1] = { L["Passes through"], info.passes, "textDim" } end
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
			row.Hit:Hide()
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
			local cut = false
			if type(f[2]) == "table" then cut = fitZones(row.Value, f[2]) else row.Value:SetText(f[2]) end
			row.Hit.psTip = cut and f[1] or nil
			row.Hit.psTipLines = cut and { table.concat(f[2], ARROW) } or nil
			row.Hit:SetShown(cut)
			row.Hit:EnableMouse(cut)
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
		d.Facts[i].Hit:Hide()
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
	-- Put the quest's matching steps first; the guide's pitch follows them.
	local pitch = g.pitch
	if questContext then
		local text = {}
		local E, G = ns.Engine, ns.Guides
		local full = G.Get(g.id)
		local numbered = E and E.StepNumberOf and full
		local _, fresh = G.Peek(g.id)
		for _, hit in ipairs(questSteps(g)) do
			-- As the player counts the steps (#942).
			local no = numbered and (E.StepNumberOf(full, hit.index)) or hit.index
			local total = numbered and E.StepTotalOf(full) or g.stepCount or 0
			text[#text + 1] = string.format(L["Step %d of %d: %s"], no, total, hit.step.title or questContext.query)
			if type(hit.step.note) == "string" and hit.step.note ~= "" then text[#text + 1] = hit.step.note end
		end
		G.Unpeek(g.id, fresh)
		if #text > 0 then
			if type(pitch) == "string" and pitch ~= "" then text[#text + 1] = pitch end
			pitch = table.concat(text, "\n\n")
		end
	end
	if type(pitch) == "string" and pitch ~= "" then
		d.Pitch:SetText(pitch)
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
	-- Another guide (or another quest's search) reads from the top; the same
	-- one drawn again (a tab's progress, a guide registering) keeps the
	-- place the player scrolled to.
	local readFor = g.id .. "\0" .. (questContext and questContext.query or "")
	if d.psReadFor ~= readFor then
		d.psReadFor = readFor
		W.ScrollTo(d.Scroll, 0)
	end

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

-- The categories: one with no guide of the character's side is left out (one
-- with none for this character stays, faded by ShellNav).
local function navItems(counts, total)
	local exists, packs, seen = {}, {}, {}
	local player = playerInfo()
	-- Another side's guide (an old saved tab's) makes no category or pack.
	for _, g in ipairs(ns.Guides and ns.Guides.List and ns.Guides.List() or {}) do
		if ownSide(g, player) then
			local r = packOf(g)
			if not r then
				exists[categoryOf(g)] = true
			elseif not seen[r.id] then
				seen[r.id] = true
				packs[#packs + 1] = r
			end
		end
	end
	local items = { { key = "All", label = L["All guides"], icon = "compact", count = total } }
	for _, c in ipairs(CATEGORIES) do
		if exists[c] then items[#items + 1] = { key = c, label = L[c], icon = CATEGORY_ICON[c], count = counts[c] or 0 } end
	end
	-- A category outside the format's list (Lookup's and Dungeons' made guides: "Lookup", #2779), after them.
	local extra = {}
	for c in pairs(exists) do
		if not CATEGORY_RANK[c] then extra[#extra + 1] = c end
	end
	table.sort(extra)
	for _, c in ipairs(extra) do
		items[#items + 1] = { key = c, label = L[c], icon = CATEGORY_ICON[c] or "compact", count = counts[c] or 0 }
	end
	items[#items + 1] = { key = "Favorites", label = L["Favourites"], icon = CATEGORY_ICON.Favorites, count = counts.Favorites or 0 }
	-- Community guides: one entry per shown pack with guides, "<title> · <author>",
	-- on one line (its tooltip has it whole when cut).
	if #packs > 0 then
		table.sort(packs, function(a, b) return (a.title or a.id):lower() < (b.title or b.id):lower() end)
		items[#items + 1] = { key = "", heading = true, label = L["Community guides"] }
		for _, r in ipairs(packs) do
			local label = r.title or r.id
			if r.author then label = label .. DOT .. r.author end
			items[#items + 1] = { key = PACK .. r.id, label = label, icon = "layers", count = counts[PACK .. r.id] or 0, oneLine = true }
		end
	end
	P.categories = {}
	for _, it in ipairs(items) do
		if not it.heading then P.categories[#P.categories + 1] = it.key end
	end
	return items
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

-- The rail's items as drawn, kept until a section registers (renderRail):
-- built afresh on every render they were garbage each time the menu opened.
local railItems, footItems
function UI.RegisterSection(spec)
	if type(spec) ~= "table" or type(spec.key) ~= "string" or type(spec.build) ~= "function" or type(spec.render) ~= "function" then return false end
	if spec.key == GUIDES.key then return false end
	for i = #sections, 1, -1 do if sections[i].key == spec.key then table.remove(sections, i) end end
	sections[#sections + 1] = spec
	railItems, footItems = nil, nil
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
	win.Header:ClearAllPoints()
	win.Header:SetPoint("TOPLEFT", win.Main, "TOPLEFT", 0, 0)
	win.Header:SetPoint("TOPRIGHT", win.Main, "TOPRIGHT", on and 0 or -DETAIL_W, 0)
	win.Band:SetTexCoord(Theme.BandCoords(on and (MID_W + DETAIL_W) or MID_W, SH.header))
	win.Close:SetParent(on and win.Header or details.Art.Over)
	win.Close:ClearAllPoints()
	win.Close:SetPoint("TOPRIGHT", on and win.Header or details.Art, "TOPRIGHT", -12, -12)
	if not on then win.Close:SetFrameLevel(details.Scrim:GetFrameLevel() + 2) end
	if win.PlaceThanks then win.PlaceThanks() end
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

-- The hub's sections as rail items (the settings window shows the same rail);
-- a section with `foot = true` sits at the rail's foot instead, above
-- Options (P.FootItems).
function P.RailItems()
	local items = {}
	for _, s in ipairs(sections) do
		if not s.foot then items[#items + 1] = { key = s.key, label = s.label or s.key, icon = s.icon } end
	end
	return items
end

-- The rail's foot from the bottom up: Options (onOptions opens the settings;
-- nil: the shell's own onSelect), then every `foot` section above it.
function P.FootItems(onOptions)
	local items = { { key = "Options", label = L["Settings"], icon = "sliders", tip = L["Settings"], onClick = onOptions } }
	for _, s in ipairs(sections) do
		if s.foot then items[#items + 1] = { key = s.key, label = s.label or s.key, icon = s.icon } end
	end
	return items
end

-- The rail: every section, Options at its foot with the foot sections above it.
local function openOptions() if UI.ShowOptions then UI.ShowOptions() end end
local function showSection(key) P.ShowSection(key) end
local function renderRail()
	railItems = railItems or P.RailItems()
	footItems = footItems or P.FootItems(openOptions)
	P.railShown = W.ShellRail(win, railItems, footItems, section or GUIDES.key, showSection)
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

-- Home's list (the header comment's "resume first"), from the body's top.
-- -> the y under it, the labels, rows and cards it shows
local function renderHome(tabs, active, byId, openIndex, counts, width, sugg, why)
	local y, nf, ng, nc = 0, 0, 0, 0
	-- Home's label (LABEL_H, LABEL_GAP over its content) and rows (36, a
	-- glyph, a hairline between). -> the label
	local function label(text, count)
		nf = nf + 1
		local f = folderRow(nf)
		paintFolder(f, text, count, nil, true)
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", win.Body, "TOPLEFT", ROW_X, -y)
		f:SetWidth(width)
		f:Show()
		y = y + LABEL_H + LABEL_GAP
		return f
	end
	local function homeRow(g, note, shownTitle, opts)
		ng = ng + 1
		local r = guideRow(ng)
		paintRow(r, g, note, width, shownTitle, opts)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", win.Body, "TOPLEFT", ROW_X, -y)
		r:Show()
		y = y + HOME_ROW_H
		visibleIds[#visibleIds + 1] = g.id
	end
	local function tabNote(id)
		return openIndex[id] and string.format(L["Tab %d"], openIndex[id]) or nil
	end
	y = HOME_TOP
	local player = playerInfo()
	local level = player and player.level
	local shown = P.Titles(sugg)
	-- The pane follows Home: the line picked there, else the top suggestion
	-- not open in a tab (the tab card already shows that one), else the
	-- first, else the active tab.
	local listed = {}
	for _, g in ipairs(sugg) do listed[g.id] = true end
	for _, t in ipairs(tabs or {}) do listed[t.guideId] = true end
	if homeSel and not listed[homeSel] then homeSel = nil end
	homeTop = nil
	for _, g in ipairs(sugg) do
		if not openIndex[g.id] then
			homeTop = g.id
			break
		end
	end
	homeTop = homeTop or (sugg[1] and sugg[1].id) or (tabs and active and tabs[active] and tabs[active].guideId) or nil
	local more = win.CardsMore
	more:Hide()
	if tabs and #tabs > 0 then
		for _, b in ipairs(actPool) do b:Hide() end
		local order = cardOrder(tabs, active)
		y = layoutHero(tabs[order[1]], order[1], byId, y)
		nc = 1
		visibleIds[#visibleIds + 1] = tabs[order[1]].guideId
		-- Play next under the active tab's card; its guide is not repeated below.
		local alsoFor = sugg
		if playNext then
			y = layoutPlayNext(SH.pad, y + SECTION_GAP, MID_W - SH.pad * 2)
			visibleIds[#visibleIds + 1] = playNext.guide.id
			alsoFor = {}
			for _, g in ipairs(sugg) do if g ~= playNext.guide then alsoFor[#alsoFor + 1] = g end end
		end
		-- The other tabs, three of them until "Show all N" on their label.
		local rest = #order - 1
		if rest > 0 then
			y = y + SECTION_GAP
			local f = label(L["Other tabs"], rest)
			if rest > OTHER_TABS then
				W.SetButtonText(more, allCards and L["Show fewer"] or string.format(L["Show all %d"], rest))
				more:ClearAllPoints()
				more:SetPoint("RIGHT", f, "RIGHT", -(TEXT_X - 8), 0)
				more:Show()
			end
			local n = allCards and rest or min(rest, OTHER_TABS)
			local open = {}
			for k = 1, n do
				local t = tabs[order[k + 1]]
				open[k] = byId[t.guideId] or { id = t.guideId, title = t.title }
			end
			local titles = P.Titles(open)
			for k, g in ipairs(open) do
				local i = order[k + 1]
				local t = tabs[i]
				local tot = t.total or t.stepCount or 0
				homeRow(g, string.format(L["Tab %d"], i), titles[g], { rule = k > 1, frac = tot > 0 and (t.done or 0) / tot or 0, index = i })
			end
		end
		if #alsoFor > 0 then
			y = y + SECTION_GAP
			label(playNext and level and string.format(L["Also for level %d"], level) or L["Suggested for you"], #alsoFor)
			for k, g in ipairs(alsoFor) do homeRow(g, tabNote(g.id) or why[g], shown[g], { rule = k > 1 }) end
		end
	else
		-- A character with nothing open: "Start here", the other guides
		-- for the level, then the categories people look for first.
		if #sugg > 0 then
			y = layoutStart(sugg[1], why[sugg[1]], y)
			nc = 1
			visibleIds[#visibleIds + 1] = sugg[1].id
			if #sugg > 1 then
				y = y + SECTION_GAP
				label(level and string.format(L["Also for level %d"], level) or L["Suggested for you"], #sugg - 1)
				for k = 2, #sugg do
					local g = sugg[k]
					homeRow(g, why[g], shown[g], { rule = k > 2 })
				end
			end
			y = y + SECTION_GAP
			label(L["Find more"])
		else
			label(L["Find a guide"])
		end
		y = layoutActs(counts, y)
	end
	if nc == 0 and hero then hero:Hide() end
	return y, nf, ng, nc
end

local function render()
	local active = activeSection()
	if not active then section = nil end
	onHome = not active and view == "home"
	renderRail()
	sectionLayout(active)
	if active then
		-- The section first, then its sidebar: a section takes up a search the hub changed while another one
		-- was shown when it draws, and its index counts what it shows (#2769).
		renderSection(active)
		sectionNav(active)
		return
	end
	for _, s in ipairs(sections) do if s.psFrame then s.psFrame:Hide() end end
	-- A pack entry whose pack was hidden or holds no guides, or a category no
	-- shown guide is in (its pack was switched off): back to All.
	if category:sub(1, #PACK) == PACK then
		local r = packOfKey(category)
		local own = r and ns.Guides.OWN_EXTRA and ns.Guides.OWN_EXTRA[r.id]
		if own or not (r and r.status == "on" and (r.guideCount or 0) > 0) then category = "All" end
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
	local entries, n, counts = P.Entries(query, view == "browse" and category or "All")
	local total = 0
	for c, k in pairs(counts) do if c ~= "Favorites" then total = total + k end end
	W.ShellNav(win, navItems(counts, total), view == "browse" and category or nil, function(key) P.SetCategory(key) end)
	local tabsList = {}
	for i, v in ipairs(VIEWS) do tabsList[i] = { key = v, label = VIEW_LABEL[v] } end
	W.ShellTabs(win, tabsList, view, function(key) P.SetView(key) end)

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
			local parts = { n == 1 and L["1 guide"] or string.format(L["%d guides"], n) }
			local mine = UI.PlayerFaction()
			if mine then table.insert(parts, 1, ns.FactionName(mine)) end
			local open = tabs and #tabs or 0
			if open > 0 then parts[#parts + 1] = string.format(L["%d open"], open) end
			subtitle = table.concat(parts, DOT)
		end
	elseif view == "home" then
		-- The section, so the tab row's Home is said once; then the character
		-- and what is open: "Level 24 Alliance · 5 open".
		title = L["Guides"]
		local player, parts = playerInfo(), {}
		local mine = UI.PlayerFaction()
		if player and player.level then
			parts[1] = mine and string.format(L["Level %d %s"], player.level, ns.FactionName(mine)) or string.format(L["Level %d"], player.level)
		end
		local open = tabs and #tabs or 0
		if open > 0 then
			parts[#parts + 1] = string.format(L["%d open"], open)
		elseif #P.Recent() == 0 then
			parts[#parts + 1] = L["pick your first guide"]
		end
		subtitle = table.concat(parts, DOT)
	else
		title = VIEW_LABEL[view]
		if view == "current" then
			subtitle = L["The guides open in your tabs."]
		else
			subtitle = L["The tabs you closed and the last guides you loaded."]
		end
	end
	if newTabMode then subtitle = L["Pick a guide to open in a new tab."] end
	W.ShellTitle(win, title, subtitle)

	local width = MID_W - ROW_X * 2
	if not shownSugg then
		local sugg, why = suggestions(byId, tabs, openIndex)
		shownSugg = { sugg = sugg, why = why }
	end
	local sugg, why = shownSugg.sugg, shownSugg.why
	playNext = playNextOf(sugg, why, openIndex)
	playDrawn = false
	local y, nf, ng, nc = 8, 0, 0, 0
	visibleIds = {}
	-- id: a Browse folder's id where it folds (no search), else nil.
	local function folder(text, count, id, mark)
		nf = nf + 1
		local f = folderRow(nf)
		paintFolder(f, text, count, id, nil, mark)
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
	local function row(g, note, shownTitle)
		ng = ng + 1
		local r = guideRow(ng)
		paintRow(r, g, note, width, shownTitle, nil, playNext ~= nil and playNext.guide.id == g.id)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", win.Body, "TOPLEFT", ROW_X, -y)
		r:Show()
		y = y + ROW_H
		visibleIds[#visibleIds + 1] = g.id
	end
	local empty, turnOn
	-- The last search's Codex matches go away first; a browse with a query
	-- draws them again below.
	if UI.HideLookupRows then UI.HideLookupRows(win.Body) end
	if view == "browse" then
		-- A search lists every match: no folder folds then.
		local folds = query == ""
		local lastFolder = false
		-- Play next above the list, and its band marked while folded.
		local sugFolder
		if playNext then
			for _, e in ipairs(entries) do
				if e.kind == "guide" and e.guide.id == playNext.guide.id then sugFolder = e.folder end
			end
			if sugFolder and folds then y = layoutPlayNext(ROW_X, y, width) + 10 end
		end
		for _, e in ipairs(entries) do
			if e.kind == "folder" then
				if lastFolder then y = y + 10 end
				folder(e.text, e.count, folds and e.id or nil, e == sugFolder and folds and P.IsCollapsed(e.id))
				lastFolder = true
			elseif not (folds and P.IsCollapsed(e.folder.id)) then
				row(e.guide, tabNote(e.guide.id), e.title)
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
				local Pk = UI.Packs
				if Pk and Pk.OwnGuidesOff() then
					empty = L["No guides: Polestar Guides is installed but unticked in the game's AddOns list."]
					turnOn = true
				elseif Pk and Pk.OursSwitchedOff() then
					empty = L["No guides shown: Polestar's own guides are switched off. Turn them on under Settings, Community guides (/polestar packs)."]
				elseif Pk and Pk.AnySwitchedOff() then
					empty = L["No guides shown: the community addons are switched off. Turn one on under Settings, Community guides (/polestar packs)."]
				else
					empty = L["No guides installed. Enable Polestar Guides or a community addon in the AddOns list on the character screen, then reload."]
				end
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
		y, nf, ng, nc = renderHome(tabs, active, byId, openIndex, counts, width, sugg, why)
	elseif view == "current" then
		if tabs and #tabs > 0 then
			folder(L["Open tabs"], #tabs)
			local open = {}
			for _, t in ipairs(tabs) do open[#open + 1] = byId[t.guideId] end
			local shown = P.Titles(open)
			for _, g in ipairs(open) do row(g, tabNote(g.id, true), shown[g]) end
		else
			empty = L["No guide is open. Load one and it shows up here."]
		end
	else
		-- The tabs the player closed, newest first (Engine.ClosedTabs): opened
		-- again, each comes back at the step it was on. Then the last guides loaded.
		-- Only the character's side: an old tab or load of another side's guide stays out (#2462).
		local E, shut, listed, player = ns.Engine, {}, {}, playerInfo()
		for _, c in ipairs(E and E.ClosedTabs and E.ClosedTabs() or {}) do
			local g = byId[c.guideId]
			if g and ownSide(g, player) then
				shut[#shut + 1] = g
				listed[g.id] = true
			end
		end
		if #shut > 0 then
			folder(L["Recently closed"], #shut)
			local shown = P.Titles(shut)
			for _, g in ipairs(shut) do row(g, nil, shown[g]) end
		end
		local recent = {}
		for _, id in ipairs(P.Recent()) do
			local g = byId[id]
			if g and not listed[id] and ownSide(g, player) then recent[#recent + 1] = g end
		end
		if #recent > 0 then
			if #shut > 0 then y = y + 10 end
			folder(L["Recently loaded"], #recent)
			local shown = P.Titles(recent)
			for _, g in ipairs(recent) do row(g, tabNote(g.id), shown[g]) end
		elseif #shut == 0 then
			empty = L["Guides you load show up here."]
		end
	end
	if view ~= "home" then
		if hero then hero:Hide() end
		for _, b in ipairs(actPool) do b:Hide() end
		win.CardsMore:Hide()
	end
	if playCard and not playDrawn then playCard:Hide() end
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
	-- Polestar Guides unticked in the AddOns list: one click turns it on.
	if turnOn then
		W.SetButtonText(win.TurnOn, L["Turn on Polestar Guides and reload"])
		win.TurnOn:ClearAllPoints()
		win.TurnOn:SetPoint("TOPLEFT", win.Body, "TOPLEFT", SH.pad, -(y + 12))
		win.TurnOn:Show()
		y = y + 12 + win.TurnOn:GetHeight()
	else
		win.TurnOn:Hide()
	end
	W.ShellWatermark(win, empty ~= nil)
	W.ShellBody(win, y + (view == "home" and SECTION_GAP or 16))
	renderDetails(byId, tabs, active)
	P.shown = { view = view, guides = ng, folders = nf, cards = nc }
end

-- Draws the menu again with the suggestions on show (shownSugg).
function P.Redraw()
	if not (win and win:IsShown()) then return end
	renderPlayer = nil
	renderPlayer = playerInfo() or false
	render()
	renderPlayer = nil
end

function P.Render()
	shownSugg = nil
	P.Redraw()
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
	-- Back on Home, the pane starts on its top suggestion again.
	if view == "home" then homeSel = nil end
	if view ~= "browse" and query ~= "" then
		query = ""
		if win then win.Search:SetText("") end
	end
	if win and win:IsShown() then
		W.ScrollTo(win.Scroll, 0)
		P.Redraw()
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
	if questContext and text ~= questContext.query then questContext = nil end
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
	P.Redraw()
	if query ~= "" then selectFirstResult() end
end

local function build()
	readSizes()
	win = W.Shell("PolestarPicker", {
		width = WIN_W, height = WIN_H, sidebar = SIDE_W,
		rail = true, title = L["Guides"], scalePath = "ui.pickerScale", scaleButton = true, scaleLabel = L["Guides scale"],
		scaleTip = L["The guides window only. Click to pick a size; right-click to reset."], searchPlaceholder = HUB_SEARCH,
		onSearch = onSearch,
	})
	P.frame = win
	UI.Report.SidebarLink(win)
	-- Special thanks to: a name drawn anew each time the window opens, at the
	-- top right of the header on every page (UI/Thanks.lua).
	UI.Thanks.HeaderLink(win)
	-- On Guides the details pane holds the close button: the Guides scale's
	-- button stands with it on the pane's art, left of the star, on the same dark
	-- ground (Theme/Widgets.lua's W.HeaderScaleButton puts it back in the header
	-- beside the close button on the other pages).
	win.psPlaceScale = function(t, away)
		if not details then return end
		details.psScaleHere = away
		if away then
			local over = details.Art.Over
			if t:GetParent() ~= over then t:SetParent(over) end
			t:ClearAllPoints()
			t:SetPoint("RIGHT", details.Star, "LEFT", -4, 0)
			t:SetFrameLevel(details.Scrim:GetFrameLevel() + 2)
		end
		details.FitScrim()
	end
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
	win.TurnOn = W.Button(win.Body, "", function()
		if UI.Packs then UI.Packs.TurnOnOwnGuides() end
	end, { primary = true })
	win.TurnOn:Hide()
	-- Home's "Show all N" / "Show fewer" on the Other tabs label.
	win.CardsMore = W.Button(win.Body, "", function()
		allCards = not allCards
		P.Render()
	end, { ghost = true, height = 24 })
	win.CardsMore.psTight = true
	win.CardsMore:Hide()
	-- The list's column ends where the details begin: the hidden footer
	-- marks the body's width (W.ShellFooter), so the list's scroll area and
	-- its bar stop at the details' edge rather than run on under them.
	win.Footer:SetPoint("BOTTOMRIGHT", main, "BOTTOMRIGHT", -DETAIL_W, 0)
	W.ShellFooter(win, nil, nil)

	buildDetails()
	win:HookScript("OnShow", function() P.Render() end)
	-- A gamepad moves through the hub (UI/Gamepad.lua): LB / RB step the
	-- rail's sections, X loads the guide on a focused row, Y closes a
	-- Continue card's tab.
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(win, {
			initial = function(rows)
				-- The selected guide, else the first line that is no folder header.
				-- Home leads with its first card: the active tab's, Start here
				-- or, under it, Play next's.
				local first, header, card, play
				for i, w in ipairs(rows) do
					if ns.Gamepad.Within(w, win.Main) and w.psKey == nil and w ~= win.ThanksLink then
						if w == hero and not card then card = i end
						if w.psPlayNext then play = i end
					end
				end
				if view == "home" and (card or play) then return card or play end
				for i, w in ipairs(rows) do
					if ns.Gamepad.Within(w, win.Main) and w.psKey == nil and w ~= win.ThanksLink then
						if w.psGuide and w.psGuide.id == P.Selected() then return i end
						if w.psFolder then header = header or i else first = first or i end
					end
				end
				return first or header
			end,
			prevTab = function() P.StepSection(-1) end,
			nextTab = function() P.StepSection(1) end,
			tabsLabel = L["Sections"],
			-- The close sits among the details' own buttons: B goes in the hint bar.
			close = false,
			x = function(w)
				if w and w.psPlayNext then return playNextStart() end
				if w and w.psGuide and w.psGuide.id then
					P.Select(w.psGuide.id)
					P.LoadSelected()
				end
			end,
			xLabel = function(w) return w.psPlayNext and L["Start"] or (w.psGuide and L["Load guide"] or nil) end,
			reset = function(w)
				if not (w and w.psCard) then return false end
				closeCard(w)
				return true
			end,
			resetLabel = function(w) return w and w.psCard and L["Close tab"] or nil end,
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
	local sel = uiState().pickerSelected
	-- Opened again, Home starts on its top suggestion.
	if not win:IsShown() then homeSel = nil end
	if not (sel and byId[sel] and ownSide(byId[sel])) then
		sel = nil
		local tabs, active = tabsInfo()
		if tabs and active and tabs[active] then sel = tabs[active].guideId end
		local G = ns.Guides
		if not sel and G and G.Suggest then sel = G.Suggest() end
		uiState().pickerSelected = sel and byId[sel] and sel or nil
	end
	-- The folder holding the open guide starts expanded (#1358).
	if not win:IsShown() then
		local tabs, active = tabsInfo()
		local open = tabs and active and tabs[active] and tabs[active].guideId
		if open then P.SetCollapsed(P.FolderOf(open), false) end
	end
	-- The settings window is a window of its own: it stays where it is.
	if win:IsShown() then
		P.Render()
	else
		win:Show()
	end
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

-- A quest menu searches installed guides, including those without a Codex.
function P.ShowQuest(id)
	id = readable(id)
	if type(id) ~= "number" or id <= 0 or id >= math.huge or id % 1 ~= 0 then return false end
	UI.ShowPicker()
	P.ShowSection("Guides")
	P.SetCategory("All")
	local name = UI.QuestTitle(id) or (ns.Names and ns.Names.Quest(id))
	questContext = { id = id, query = name or tostring(id), steps = {} }
	P.SetQuery(questContext.query)
	P.Render()
	if #visibleIds == 0 then P.Select(nil) else selectFirstResult() end
	win.Search:SetFocus()
	return true
end

ns.On("GUIDE_CHANGED", function(id)
	remember(id)
	P.Render()
end)
ns.On("SETTING_CHANGED", function(path)
	if path == "ui.pickerCollapsed" or path == "" or path == "ui" then P.Render() end
end)
local function guidesChanged()
	factCache = {}
	if questContext then questContext.steps = {} end
	P.Render()
end
ns.On("GUIDES_REGISTERED", guidesChanged)
ns.On("PACKS_CHANGED", guidesChanged)
ns.On("TABS_CHANGED", function() P.Render() end)
