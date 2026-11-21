-- The Stats section of the hub: what this character has done, from the
-- totals Collect.lua keeps. The sidebar lists the pages (Activity,
-- Character, Time, Gold, Professions), then the world map: every zone on
-- one canvas (Stats/WorldArt.lua) with a tab per layer: the walked path,
-- heat for time, kills, XP and deaths, and the journeys (flights, rides and
-- jumps). A zone the client cannot place on the world keeps a page of its
-- own on its map art (UI/ZoneArt.lua). The wheel zooms in on the cursor,
-- dragging moves the map, a right-click goes back to where it opened.
--
--   SV.Zoom(steps[, px, py]), SV.Pan(dx, dy), SV.ResetView(): the same, in
--   frame pixels (the scripts on the map call them; tests too).
--
-- Registered with UI.RegisterSection; opened by Stats.Show (SHOW_STATS:
-- /polestar stats and the menus, through Core/StatsPack.lua).

local ns = Polestar
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local Stats = ns.Stats
local Compat = ns.Compat
local L = ns.L
local max, min, floor, ceil, sqrt, ipairs, pairs, format, tostring, tonumber = math.max, math.min, math.floor, math.ceil, math.sqrt, ipairs, pairs, string.format, tostring, tonumber
local sort = table.sort

if not (UI and W and W.SHELL and Stats and Stats.Charts) then return end

local C = Stats.Charts
local WA = Stats.WorldArt -- nil without the zone art; its Rect places nothing on a client that cannot
local SH = W.SHELL
local DOT = "  \194\183  "
local MAX_ZONES = 30 -- zones listed in the sidebar
local MAX_CELLS = 4000 -- heat cells drawn in the frame, the strongest first
local MAX_LINES = 4000 -- path segments drawn in the frame, the newest first
local MAX_ZOOM = 12 -- how far in a zone's map goes (1 = the whole zone); the world's goes as far into its smallest zone
local ZOOM_STEP = 1.25 -- one wheel click
local FIT = 0.9 -- how much of the frame a framed zone (or the zones played in) fills
local MIN_CELL = 2.5 -- heat cells smaller than this many pixels are summed into blocks
local MAX_BLOCK = 32 -- ... of at most this many cells a side
local BLOB = 3.2 -- a heat blob's width in cells (or blocks): wide enough to run into its neighbours
local MIN_BLOB = 9 -- ... and never under this many pixels
local TRAIL_PX = 3 -- path steps shorter than this many pixels are joined (a shorter line does not show)
local FAR_W = 220 -- a zone narrower than this many pixels shows its path as dots: its lines would be too short to see
local DOT_PX = 2 -- ... this many pixels each
local MAX_JUMP_LINES = 300 -- jumps drawn in the frame
local WORLD_KEY = "world"
local MAP_RATIO = 2 / 3 -- a map's height over its width (the frame's too, where the window has the room)
local MAP_MIN_H = 160 -- the frame is never shorter than this, however small the window
local MAP_BELOW = 70 -- room kept under the frame for the scale and a line of notes

local SV = {}
UI.StatsSection = SV

local root, shellRef, scroll, pool, mapArt, mapPool
local shown = {}

local PAGES = {
	{ key = "activity", label = L["Activity"] },
	{ key = "character", label = L["Character"] },
	{ key = "time", label = L["Time"] },
	{ key = "gold", label = L["Gold"] },
	{ key = "professions", label = L["Professions"] },
	{ key = "completion", label = L["Completion"] },
}
local COMPLETION = "completion"

-- The marks' colours are their own, not the theme's: they have to stand out
-- on the map art, which is drawn with some of its colour out (MAP_DESAT).
local MAP_DESAT = 0.6
local PATH_COLOR = { 0.25, 0.95, 1.00 } -- the walked path: bright cyan
local JUMP_COLOR = { 1, 1, 1 }
-- Heat, from the least to the most: violet, blue, cyan, green, yellow, orange, red.
local RAMP = {
	{ 0.36, 0.20, 0.85 }, { 0.13, 0.47, 1.00 }, { 0.05, 0.85, 0.92 }, { 0.40, 0.95, 0.25 },
	{ 1.00, 0.92, 0.15 }, { 1.00, 0.52, 0.05 }, { 1.00, 0.12, 0.12 },
}
-- How a heat cell's value is shared out when drawn: { column, row, share }.
local SPLAT = {
	{ 0, 0, 0.4 }, { 1, 0, 0.1 }, { -1, 0, 0.1 }, { 0, 1, 0.1 }, { 0, -1, 0.1 },
	{ 1, 1, 0.05 }, { 1, -1, 0.05 }, { -1, 1, 0.05 }, { -1, -1, 0.05 },
}
local PEAK_SHARE = 0.02 -- the hottest colour is reached by this share of a zone's cells, not by its one busiest
local HEAT_ALPHA = 0.2 -- every blob's opacity, the same for all: only the colour says how hot (the map shows through)
local SHADES = 32 -- the ramp's steps a cell is coloured in
local HEAT = {} -- [1..SHADES] = { r, g, b }
for i = 1, SHADES do
	local t = (i - 1) / (SHADES - 1) * (#RAMP - 1)
	local k = min(#RAMP - 1, floor(t) + 1)
	local a, b, f = RAMP[k], RAMP[k + 1], t - (k - 1)
	HEAT[i] = { a[1] + (b[1] - a[1]) * f, a[2] + (b[2] - a[2]) * f, a[3] + (b[3] - a[3]) * f }
end

local LAYERS = {
	{ key = "p", label = L["Path"], unit = L["%s path points"] },
	{ key = "t", label = L["Time spent"], unit = L["%s on the move here"] },
	{ key = "k", label = L["Kills"], unit = L["%s kills"] },
	{ key = "x", label = L["XP from kills"], unit = L["%s XP"] },
	{ key = "q", label = L["XP from quests"], unit = L["%s XP"] },
	{ key = "d", label = L["Deaths"], unit = L["%s deaths"] },
	-- Journeys across the world: on the world map only (they are kept on the continents' maps).
	{ key = "j", label = L["Travel"], route = true },
	-- How much of each zone is done (Progress.lua): its quests handed in, its rares killed.
	{ key = "Q", label = L["Quests"], progress = "Quests" },
	{ key = "R", label = L["Rares"], progress = "Rares" },
}
-- A journey's kinds (Stats.Routes), each in its colour.
local ROUTES = {
	{ kind = "f", label = L["Flights"], color = { 1.00, 0.45, 0.95 } },
	{ kind = "r", label = L["Rides and portals"], color = { 1.00, 0.78, 0.20 } },
}
-- The Completion page's tabs: a list of the zones with how much of each is done.
local PROGRESS = {
	{ key = "Q", label = L["Quests"], progress = "Quests", done = L["%s of %s quests done"],
		note = L["The quests your character can take in each zone, of every level, and how many of them are handed in."] },
	{ key = "R", label = L["Rares"], progress = "Rares", done = L["%s of %s rares killed"],
		note = L["A rare counts when its kill gives you experience with it as your target, from now on."] },
}
local DONE_COLOR, TODO_COLOR = { 0.35, 0.95, 0.35 }, { 0.75, 0.75, 0.75 } -- a rare's spawn: killed, still to kill
local LABEL_W = 46 -- a zone at least this many pixels wide carries its percentage; a narrower one a dot
local MAX_SPOTS = 1500 -- rare spawn points drawn in the frame

local DAY_NAMES = { [0] = L["Sun"], L["Mon"], L["Tue"], L["Wed"], L["Thu"], L["Fri"], L["Sat"] }

local PROF_NAMES = {
	[171] = L["Alchemy"], [164] = L["Blacksmithing"], [333] = L["Enchanting"], [202] = L["Engineering"],
	[182] = L["Herbalism"], [165] = L["Leatherworking"], [186] = L["Mining"], [393] = L["Skinning"],
	[197] = L["Tailoring"], [185] = L["Cooking"], [356] = L["Fishing"], [129] = L["First Aid"],
}

---------------------------------------------------------------------------
-- Formatting
---------------------------------------------------------------------------

local function num(n)
	local s = tostring(floor((n or 0) + 0.5))
	while true do
		local k
		s, k = s:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
		if k == 0 then return s end
	end
end

-- A share as a whole percentage.
local function percent(done, total)
	return total > 0 and floor(done / total * 100 + 0.5) or 0
end

local function elapsed(seconds)
	local m = floor((seconds or 0) / 60)
	if m >= 60 then return format(L["%d h %d min"], floor(m / 60), m % 60) end
	return format(L["%d min"], m)
end

local function day(t) return t and date and date("%b %d", t) or "" end

local function share(n, whole)
	if not whole or whole <= 0 then return "" end
	return DOT .. floor(n / whole * 100 + 0.5) .. "%"
end

local function questName(q)
	local name = Compat.GetQuestTitle and Compat.GetQuestTitle(q)
	if type(name) == "string" and name ~= "" then return name end
	return format(L["Quest %d"], q)
end

local function pageWidth()
	local full = shellRef and (shellRef:GetWidth() - (shellRef.psRail or 0) - (shellRef.psSidebar or SH.sidebar) - 2) or 0
	if full <= 0 then full = 654 end
	return full - SH.pad * 2
end

---------------------------------------------------------------------------
-- Pages: each draws into the pool and returns the y its content ends at
---------------------------------------------------------------------------

local pages = {}

function pages.activity(p, w, a)
	local y = C.Cards(p, 0, w, {
		{ L["Quests accepted"], num(a.accepted) }, { L["Quests turned in"], num(a.turned) }, { L["Abandoned"], num(a.abandoned) },
	})
	y = C.Cards(p, y, w, {
		{ L["Monsters killed"], num(a.kills) }, { L["Fights"], num(a.fights) },
		{ L["Average quest"], a.timedQuests > 0 and elapsed(a.questSeconds / a.timedQuests) or "\226\128\148" },
		{ L["Time played"], elapsed(a.played) },
	})
	y = C.Heading(p, y + 8, L["Experience by source"])
	local xp = a.xp
	local total = xp.quests + xp.kills + xp.explore
	local function line(n) return format(L["%s XP"], num(n)) .. share(n, total) end
	y = C.Bars(p, y, w, {
		{ L["Quests"], xp.quests, line(xp.quests) },
		{ L["Monsters"], xp.kills, line(xp.kills) },
		{ L["Exploration"], xp.explore, line(xp.explore) },
	})
	y = C.Heading(p, y + 8, L["Play time by hour"])
	y = C.Columns(p, y, w, 84, 0, 23, a.hours, function(h) return tostring(h) end)
	y = C.Heading(p, y + 8, L["Best paying quests"])
	local list = {}
	for _, q in ipairs(a.quests) do if (q.xp or 0) > 0 then list[#list + 1] = q end end
	sort(list, function(x, z)
		if x.xp ~= z.xp then return x.xp > z.xp end
		return x.q < z.q
	end)
	if #list == 0 then y = C.Note(p, y, w, L["No quests turned in yet."]) end
	for i = 1, min(10, #list) do
		local q = list[i]
		y = C.Table(p, y, {
			{ questName(q.q), 0, w - 260 },
			{ format(L["%s XP"], num(q.xp)), w - 250, 110 },
			{ q.lv and format(L["at level %d"], q.lv) or "", w - 130, 130, "textDim" },
		})
	end
	shown.best = #list
	return y
end

function pages.character(p, w, a)
	local info = Compat.GetPlayerInfo and Compat.GetPlayerInfo() or {}
	local class = UI.ClassName and UI.ClassName(info.class) or tostring(info.class or "")
	local race = UI.RaceName and UI.RaceName(info.race) or tostring(info.race or "")
	local level = Compat.Readable(UnitLevel and UnitLevel("player")) or 0
	-- The character's name, under its race and class.
	local name = Compat.UnitFullName and Compat.UnitFullName("player") or info.name
	if type(name) ~= "string" or name == "" then name = L["Character"] end
	shown.name = name
	local y = C.Cards(p, 0, w, {
		{ race .. " " .. class, name }, { L["Level"], num(level) },
		{ L["Item level"], a.ilvl and num(a.ilvl) or "\226\128\148" },
	})
	y = C.Cards(p, y, w, {
		{ L["Deaths"], num(a.deaths) }, { L["Bosses defeated"], num(a.bosses) }, { L["Dungeon runs"], num(#a.dungeons) },
	})
	y = C.Heading(p, y + 8, L["Levels gained"])
	local levels = a.levels
	if #levels == 0 then y = C.Note(p, y, w, L["No level-ups counted yet."]) end
	for i = max(1, #levels - 11), #levels do
		local lv, before = levels[i], levels[i - 1]
		local took = ""
		if before and before.l == lv.l - 1 and lv.p and before.p then
			took = format(L["%s on level %d"], elapsed(lv.p - before.p), before.l)
		end
		y = C.Table(p, y, {
			{ format(L["Level %d"], lv.l), 0, 100 }, { day(lv.t), 110, 90, "textDim" },
			{ lv.p and format(L["%s played"], elapsed(lv.p)) or "", 210, 170, "textDim" }, { took, 390, w - 390 },
		})
	end
	y = C.Heading(p, y + 14, L["Deaths"])
	local killers = {}
	for id, k in pairs(a.killers) do
		local name = k.name or (id == 0 and L["Unknown"] or format(L["Creature %d"], id))
		killers[#killers + 1] = { name, k.n or 0, k.n == 1 and L["1 death"] or format(L["%d deaths"], k.n or 0) }
	end
	sort(killers, function(x, z)
		if x[2] ~= z[2] then return x[2] > z[2] end
		return x[1] < z[1]
	end)
	while #killers > 8 do killers[#killers] = nil end
	if #killers == 0 then y = C.Note(p, y, w, L["No deaths counted."]) else y = C.Bars(p, y, w, killers, "danger") end
	y = C.Heading(p, y + 8, L["Dungeon runs"])
	local runs = a.dungeons
	if #runs == 0 then y = C.Note(p, y, w, L["No dungeon runs counted."]) end
	for i = max(1, #runs - 7), #runs do
		local run = runs[i]
		y = C.Table(p, y, {
			{ run.name or L["Unknown"], 0, 300 }, { day(run.t), 310, 90, "textDim" }, { run.s and elapsed(run.s) or "", 410, 160 },
		})
	end
	shown.levels, shown.killers = #levels, #killers
	return y
end

function pages.time(p, w, a)
	local y = C.Note(p, 0, w, L["Counted while you play, a few seconds at a time; time logged out is never counted."])
	y = C.Cards(p, y, w, {
		{ L["Time played"], elapsed(a.played) },
		{ L["Time on quests"], a.timedQuests > 0 and elapsed(a.questSeconds) or "\226\128\148" },
		{ L["Sessions"], num(a.sessions) }, { L["Days played"], num(a.days) },
	})
	y = C.Heading(p, y + 8, L["How it was spent"])
	local function part(s) return elapsed(s) .. share(s, a.played) end
	y = C.Bars(p, y, w, {
		{ L["In combat"], a.combat, part(a.combat) },
		{ L["Mounted"], a.mounted, part(a.mounted) },
		{ L["Resting in a town or inn"], a.resting, part(a.resting) },
		{ L["Away from keyboard"], a.afk, part(a.afk) },
	}, nil, max(a.played, 1))
	y = C.Heading(p, y + 8, L["Play time by hour"])
	y = C.Columns(p, y, w, 90, 0, 23, a.hours, function(h) return tostring(h) end)
	y = C.Heading(p, y + 8, L["Play time by day"])
	y = C.Columns(p, y, w, 60, 0, 6, a.weekdays, function(d) return DAY_NAMES[d] end)
	return y
end

function pages.gold(p, w, a)
	local now = Compat.GetMoney and Compat.GetMoney() or 0
	now = tonumber(now) or 0
	local series = a.money
	local first, peak = series[1] and series[1][2], now
	for _, pt in ipairs(series) do peak = max(peak, pt[2]) end
	local change = first and now - first
	local income = a.income.loot + a.income.quests + a.income.vendor
	local y = C.Cards(p, 0, w, {
		{ L["Gold now"], ns.MoneyText(now) },
		{ L["Change since counting began"], change and ((change < 0 and "-" or "+") .. ns.MoneyText(math.abs(change))) or "\226\128\148" },
		{ L["Most held"], ns.MoneyText(peak) },
		{ L["Earned per hour"], a.played > 0 and ns.MoneyText(floor(income / (a.played / 3600))) or "\226\128\148" },
	})
	y = C.Heading(p, y + 8, L["Gold over time"])
	y = C.Line(p, y, w, 130, series, ns.MoneyText, L["Not enough samples yet. One is kept every five minutes while your gold changes."])
	if #series >= 2 then
		C.Text(p, "caption", "textMuted", day(series[1][1]), 0, y - 8)
		local last = C.Text(p, "caption", "textMuted", day(series[#series][1]), w - 80, y - 8, 80)
		last:SetJustifyH("RIGHT")
		y = y + 12
	end
	y = C.Heading(p, y + 8, L["Where it came from"])
	y = C.Bars(p, y, w, {
		{ L["Looted"], a.income.loot, ns.MoneyText(a.income.loot) },
		{ L["Sold to vendors"], a.income.vendor, ns.MoneyText(a.income.vendor) },
		{ L["Quest rewards"], a.income.quests, ns.MoneyText(a.income.quests) },
	})
	y = C.Heading(p, y + 8, L["Where it went"])
	y = C.Bars(p, y, w, {
		{ L["Training"], a.spent.trainer, ns.MoneyText(a.spent.trainer) },
		{ L["Bought from vendors"], a.spent.buy, ns.MoneyText(a.spent.buy) },
		{ L["Repairs"], a.spent.repair, ns.MoneyText(a.spent.repair) },
		{ L["Flights"], a.spent.taxi, ns.MoneyText(a.spent.taxi) },
	}, "warning")
	y = C.Note(p, y, w, L["Auction house, mail and trades are not followed, so the two lists will not add up to the change exactly."])
	shown.money = #series
	return y
end

function pages.professions(p, w, a)
	local rows = {}
	for line, pr in pairs(a.profs) do
		local live = Compat.GetSkillRank and Compat.GetSkillRank(line)
		local name = Compat.GetSkillLineName and Compat.GetSkillLineName(line) or PROF_NAMES[line] or tostring(line)
		rows[#rows + 1] = { name = name, rank = live or pr.rank or 0, first = pr.first, t = pr.t }
	end
	sort(rows, function(x, z)
		if x.rank ~= z.rank then return x.rank > z.rank end
		return x.name < z.name
	end)
	local y = 0
	if #rows == 0 then y = C.Note(p, y, w, L["No profession skills counted for this character yet."]) end
	local barW = max(40, w - 170 - 60 - 220 - 36)
	for _, r in ipairs(rows) do
		-- No cap is read: the bar runs to the classic 300, further when the rank is.
		local cap = max(300, r.rank)
		C.Text(p, "body", "text", r.name, 0, y, 170)
		C.Meter(p, 182, y + 3, barW, 10, r.rank / cap)
		C.Text(p, "number", "text", tostring(r.rank), 194 + barW, y, 60)
		local gained = r.first and r.rank - r.first or 0
		if gained > 0 then C.Text(p, "small", "accent", format(L["+%d since %s"], gained, day(r.t)), 260 + barW, y + 1, 220) end
		y = y + 28
	end
	shown.profs = #rows
	return y
end

---------------------------------------------------------------------------
-- The map: the world on one canvas, or one zone's own map
---------------------------------------------------------------------------

-- The layer picked; a journey layer only on the world map.
local function layerOf(key, world)
	for _, l in ipairs(LAYERS) do
		if l.key == key and (world or not l.route) then return l end
	end
	return LAYERS[1]
end

-- The Completion page's tab picked.
local function progressOf(key)
	for _, l in ipairs(PROGRESS) do if l.key == key then return l end end
	return PROGRESS[1]
end

local function hideMap()
	if mapArt then mapArt:Hide() end
end

-- Whether a zone lies on the world map (it is drawn there, not on a page of its own).
local function onWorld(map)
	return WA ~= nil and WA.Rect(map) ~= nil
end

-- The zones played in that lie on the world map.
local function worldZones()
	local out = {}
	if not WA then return out end
	for _, z in ipairs(Stats.HeatMaps()) do
		if onWorld(z.map) then out[#out + 1] = z.map end
	end
	return out
end

-- The view of the map in sight: how far in, and the percent of the canvas
-- (the world, or the zone's map) at the middle of the frame.
local view = { zoom = 1, fx = 50, fy = 50 }
-- What the map shows: { key ("world" or the uiMapID), world, layer, zones, jumps, bounds, maxZoom, canvas };
-- a zone of it (a continent, for a journey layer): { map, l, r, t, b (on the canvas, 0..1), points (a
-- path or route) or cells (heat), agg }; a jump: { x1, y1, x2, y2 } on the canvas (0..1)
local drawn
local progress -- a progress layer's zones while it is drawn: { [map] = { done, total, spots } }
local droppedKey -- the map that was drawn when SV.Drop let it go: coming back to it keeps the view
local focusOn -- a zone to frame on the world's next draw (picked in the sidebar)

local function maxZoom() return drawn and drawn.maxZoom or MAX_ZOOM end

-- How much of the canvas the frame shows each way at zoom 1 (0..1): all of
-- it across, less down when the frame is flatter than the map.
local function reach()
	if not mapArt then return 1, 1 end
	local mw, mh = mapArt.psW, mapArt.psH
	local cw = max(mw, mh / MAP_RATIO)
	return mw / cw, min(1, mh / floor(cw * MAP_RATIO)) -- (the frame's height is a whole number of pixels)
end

local function clampView()
	view.zoom = max(1, min(maxZoom(), view.zoom))
	local rx, ry = reach()
	local hx, hy = 50 * rx / view.zoom, 50 * ry / view.zoom -- half of what the frame shows, percent of the canvas
	view.fx = max(hx, min(100 - hx, view.fx))
	view.fy = max(hy, min(100 - hy, view.fy))
end

-- Frames a rectangle of the canvas (0..1), with a little room around it.
local function fitView(l, r, t, b)
	local rx, ry = reach()
	view.zoom = max(1, FIT * min(rx / (r - l), ry / (b - t)))
	view.fx, view.fy = (l + r) * 50, (t + b) * 50
end

-- The view a map opens on: the whole zone, or the part of the world played in.
local function homeView()
	local b = drawn and drawn.bounds
	if b then fitView(b[1], b[2], b[3], b[4]) else view.zoom, view.fx, view.fy = 1, 50, 50 end
end

local function stronger(x, z)
	if x[2] ~= z[2] then return x[2] > z[2] end
	return x[1] < z[1]
end

-- A zone's heat with each cell's value spread over the cell and the eight
-- around it (SPLAT), so the grid reads as heat and not as specks in rows:
-- { [row * GRID + column, from 0] = value }. Made once a zone.
local function spread(z)
	local out = z.spread
	if out then return out end
	out = {}
	local G = Stats.GRID
	for cell, v in pairs(z.cells) do
		local c = cell - 1
		local cx, cy = c % G, floor(c / G)
		for i = 1, #SPLAT do
			local k = SPLAT[i]
			local x, y = cx + k[1], cy + k[2]
			if x >= 0 and x < G and y >= 0 and y < G then
				local key = y * G + x
				out[key] = (out[key] or 0) + v * k[3]
			end
		end
	end
	z.spread = out
	return out
end

-- A zone's heat in blocks of f x f cells, the strongest first: { { block, sum }, ... },
-- block = row * (GRID / f) + column, from 0; list.peak: the value that counts as
-- full strength (PEAK_SHARE). Kept per zone and f.
local function blocks(z, f)
	local list = z.agg[f]
	if list then return list end
	local G = Stats.GRID
	local per = ceil(G / f)
	local sum = {}
	for c, v in pairs(spread(z)) do
		local key = floor(floor(c / G) / f) * per + floor((c % G) / f)
		sum[key] = (sum[key] or 0) + v
	end
	list = {}
	for key, v in pairs(sum) do list[#list + 1] = { key, v } end
	sort(list, stronger)
	-- A high percentile, not the most: one spot where the character sat for an
	-- hour does not wash out everything else.
	local top = list[max(1, ceil(#list * PEAK_SHARE))]
	list.peak = top and top[2] or 0
	z.agg[f] = list
	return list
end

-- How many cells a side go into one block for a zone `wide` frame pixels
-- across: far out, cells too small to see are summed into ones that show.
local function blockSize(wide)
	local px, f = wide / Stats.GRID, 1
	while px * f < MIN_CELL and f < MAX_BLOCK do f = f * 2 end
	return f
end

local picked = {} -- the heat cells of a zone being drawn: { x, y, value }, reused

-- Where a zone's path went, on a grid of n cells a side: the cells it
-- touched, the newest first ({ row * n + column, from 0 }). Kept for the n
-- last asked for (it changes with the zoom, not as the map is dragged).
local function dots(z, n)
	local d = z.dots
	if d and d.n == n then return d end
	local pts, seen = z.points, {}
	d = { n = n }
	for i = #pts, 1, -1 do
		local x, y = Stats.TrailXY(pts[i])
		if x then
			local key = min(n - 1, floor(y / 100 * n)) * n + min(n - 1, floor(x / 100 * n))
			if not seen[key] then
				seen[key] = true
				d[#d + 1] = key
			end
		end
	end
	z.dots = d
	return d
end

-- The layer's marks for the canvas `cv`, over the zones in the frame.
local function paintMarks(cv, mw, mh)
	C.Reset(mapPool)
	local layer = drawn.layer
	local pathColor = PATH_COLOR
	local vis = {}
	for _, z in ipairs(drawn.zones) do
		local x, y = cv[1] + z.l * cv[3], cv[2] + z.t * cv[4]
		local w, h = (z.r - z.l) * cv[3], (z.b - z.t) * cv[4]
		if x < mw and y < mh and x + w > 0 and y + h > 0 then
			z.x, z.y, z.w, z.h = x, y, w, h
			vis[#vis + 1] = z
		end
	end
	local n = 0
	-- Jumps (a portal, a hearthstone, the tram): a faint straight line from where to where.
	for _, j in ipairs(drawn.jumps or {}) do
		if n >= MAX_JUMP_LINES then break end
		local x1, y1 = cv[1] + j[1] * cv[3], cv[2] + j[2] * cv[4]
		local x2, y2 = cv[1] + j[3] * cv[3], cv[2] + j[4] * cv[4]
		if not ((x1 < 0 and x2 < 0) or (x1 > mw and x2 > mw) or (y1 < 0 and y2 < 0) or (y1 > mh and y2 > mh)) then
			n = n + 1
			C.Segment(mapPool, x1, y1, x2, y2, JUMP_COLOR, 1.5, 0.7)
		end
	end
	shown.jumps = n
	if #vis == 0 then return n, 0 end
	if layer.progress then
		for _, z in ipairs(vis) do
			-- Zoomed in on a zone: where its rares spawn.
			if z.spots and z.w >= FAR_W then
				for _, sp in ipairs(z.spots) do
					if n >= MAX_SPOTS then break end
					local x, y = z.x + sp[1] / 100 * z.w, z.y + sp[2] / 100 * z.h
					if x > 0 and y > 0 and x < mw and y < mh then
						n = n + 1
						C.Blob(mapPool, x, y, 12, sp[3] and DONE_COLOR or TODO_COLOR, 0.95)
					end
				end
			end
			-- On the world: how much of the zone is done, in its middle.
			if drawn.world and z.total > 0 then
				local cx, cy = z.x + z.w / 2, z.y + z.h / 2
				if cx > 0 and cy > 0 and cx < mw and cy < mh then
					local pct = percent(z.done, z.total)
					local shade = HEAT[max(1, min(SHADES, floor(pct / 100 * (SHADES - 1) + 1.5)))]
					n = n + 1
					if z.w >= LABEL_W then
						C.Blob(mapPool, cx, cy, 40, shade, 0.6)
						C.Text(mapPool, "caption", "text", pct .. "%", cx - 30, cy - 6, 60):SetJustifyH("CENTER")
					else
						C.Blob(mapPool, cx, cy, 10, shade, 0.9)
					end
				end
			end
		end
		return n, #vis
	end
	if layer.key == "p" or layer.route then
		local share = floor(MAX_LINES / #vis)
		for _, z in ipairs(vis) do
			local pts = z.points
			local color = z.color or pathColor
			-- As thick as the zone is zoomed: a hairline from afar (a journey's: as its continent is).
			local thick = min(3, max(1.5, 1.5 + (z.w / mw - 1) * 0.15))
			if layer.route then thick = min(3, max(2, 1.5 + z.w / mw * 0.05)) end
			local kx, ky = z.w / 100, z.h / 100
			local px, py
			local k = 0
			local from = #pts
			if z.w < FAR_W then
				-- From afar: a dot wherever the path went, the lines being too short to show.
				local per = max(1, floor(z.w / DOT_PX))
				local d = dots(z, per)
				local cw, ch = z.w / per, z.h / per
				for i = 1, #d do
					if k >= share then break end
					local key = d[i]
					local x, y = z.x + (key % per) * cw, z.y + floor(key / per) * ch
					if x < mw and y < mh and x + DOT_PX > 0 and y + DOT_PX > 0 then
						k = k + 1
						C.Rect(mapPool, "ARTWORK", x, y, DOT_PX, DOT_PX, color)
					end
				end
				from = 0
			end
			-- Newest first, so a long history gives way to the latest walks.
			for i = from, 1, -1 do
				local tx, ty = Stats.TrailXY(pts[i])
				if not tx then
					px, py = nil, nil
				else
					local x, y = z.x + tx * kx, z.y + ty * ky
					if not px then
						px, py = x, y
					elseif math.abs(x - px) + math.abs(y - py) >= TRAIL_PX then
						-- (a step too short to see is left for the next point to span)
						if k < share and not ((x < 0 and px < 0) or (x > mw and px > mw) or (y < 0 and py < 0) or (y > mh and py > mh)) then
							k = k + 1
							C.Segment(mapPool, px, py, x, y, color, thick, 1)
						end
						px, py = x, y
					end
				end
			end
			n = n + k
		end
	else
		local G = Stats.GRID
		-- One scale for every zone, so a busy zone and a quiet one compare; it
		-- changes with the zoom (the blocks do), not as the map is dragged.
		if drawn.peakAt ~= cv[3] then
			local peak = 0
			for _, z in ipairs(drawn.zones) do
				local top = blocks(z, blockSize((z.r - z.l) * cv[3])).peak
				if top > peak then peak = top end
			end
			drawn.peak, drawn.peakAt = peak, cv[3]
		end
		local peak = drawn.peak > 0 and drawn.peak or 1
		local share = floor(MAX_CELLS / #vis)
		for _, z in ipairs(vis) do
			local f = blockSize(z.w)
			local list = blocks(z, f)
			local per = ceil(G / f)
			local cw, ch = z.w / per, z.h / per
			-- Each cell is a soft round blob wider than the cell, so neighbours run together.
			local size = max(MIN_BLOB, BLOB * max(cw, ch))
			local half = size / 2
			-- The strongest in the frame, up to the zone's share ...
			local k = 0
			for i = 1, #list do
				if k >= share then break end
				local key = list[i][1]
				local x, y = z.x + (key % per + 0.5) * cw, z.y + (floor(key / per) + 0.5) * ch
				if x - half < mw and y - half < mh and x + half > 0 and y + half > 0 then
					k = k + 1
					local pick = picked[k]
					if not pick then
						pick = {}
						picked[k] = pick
					end
					pick[1], pick[2], pick[3] = x, y, list[i][2]
				end
			end
			-- ... drawn the faintest first: the hot spots lie on top.
			for i = k, 1, -1 do
				local pick = picked[i]
				-- The square root lifts the faint cells: one busy spot would hide the rest.
				local heat = min(1, sqrt(pick[3] / peak))
				C.Blob(mapPool, pick[1], pick[2], size, HEAT[floor(heat * (SHADES - 1) + 0.5) + 1], HEAT_ALPHA)
			end
			n = n + k
		end
	end
	return n, #vis
end

-- Lays the art and the layer's marks out for the view. Only this runs while
-- the map is zoomed or dragged: the page around it stays as it is.
local function paintMap()
	if not (mapArt and drawn) then return end
	local mw, mh = mapArt.psW, mapArt.psH
	clampView()
	local painted
	if drawn.world then
		painted = WA.Paint(mapArt, view.fx, view.fy, view.zoom)
	else
		if WA then WA.Clear(mapArt) end
		mapArt.psZoom = view.zoom
		painted = UI.ZoneArt and UI.ZoneArt.Paint and UI.ZoneArt.Paint(mapArt, drawn.key, view.fx, view.fy, 1) or false
	end
	local cv = mapArt.psCanvas
	if not cv then
		-- No art here: the same framing, worked out for a plain panel.
		local cw, ch = mw * view.zoom, mh * view.zoom
		cv = { mw / 2 - view.fx / 100 * cw, mh / 2 - view.fy / 100 * ch, cw, ch }
	end
	drawn.canvas = cv
	local n, zones = paintMarks(cv, mw, mh)
	shown.cells, shown.painted, shown.zoom = n, painted and true or false, view.zoom
	shown.focus = { view.fx, view.fy }
	shown.zones, shown.art = zones, drawn.world and mapArt.psWorld or nil
	shown.size = { mw, mh }
	return painted
end

-- Zooms by `steps` wheel clicks, keeping the map point under (px, py) (frame
-- pixels from the top left; the middle when left out) where it is.
function SV.Zoom(steps, px, py)
	if not (mapArt and drawn and drawn.canvas) then return end
	local mw, mh, cv = mapArt.psW, mapArt.psH, drawn.canvas
	px, py = px or mw / 2, py or mh / 2
	local u, v = (px - cv[1]) / cv[3], (py - cv[2]) / cv[4]
	local was = view.zoom
	view.zoom = max(1, min(maxZoom(), was * ZOOM_STEP ^ steps))
	local k = view.zoom / was
	view.fx = ((mw / 2 - px) / (cv[3] * k) + u) * 100
	view.fy = ((mh / 2 - py) / (cv[4] * k) + v) * 100
	paintMap()
end

-- Moves the view by (dx, dy) frame pixels: the map follows the hand.
function SV.Pan(dx, dy)
	if not (mapArt and drawn and drawn.canvas) then return end
	local cv = drawn.canvas
	view.fx = view.fx - dx / cv[3] * 100
	view.fy = view.fy - dy / cv[4] * 100
	paintMap()
end

function SV.ResetView()
	homeView()
	paintMap()
end

-- The cursor in frame pixels from the art's top left.
local function cursorIn(f)
	if not (GetCursorPosition and f.GetLeft and f.GetTop) then return nil end
	local x, y = GetCursorPosition()
	local scale = f.GetEffectiveScale and f:GetEffectiveScale() or 1
	local left, top = f:GetLeft(), f:GetTop()
	if not (x and y and left and top and scale and scale > 0) then return nil end
	return x / scale - left, top - y / scale
end

local function wireMap(f)
	if f.EnableMouse then f:EnableMouse(true) end
	if f.EnableMouseWheel then f:EnableMouseWheel(true) end
	f:SetScript("OnMouseWheel", function(self, delta)
		local px, py = cursorIn(self)
		SV.Zoom(delta, px, py)
	end)
	f:SetScript("OnMouseDown", function(self, button)
		if button == "RightButton" then return SV.ResetView() end
		self.psDragX, self.psDragY = cursorIn(self)
	end)
	f:SetScript("OnMouseUp", function(self) self.psDragX, self.psDragY = nil, nil end)
	f:SetScript("OnHide", function(self) self.psDragX, self.psDragY = nil, nil end)
	f:SetScript("OnUpdate", function(self)
		if not self.psDragX then return end
		if IsMouseButtonDown and not IsMouseButtonDown("LeftButton") then
			self.psDragX, self.psDragY = nil, nil
			return
		end
		local x, y = cursorIn(self)
		if not x or (x == self.psDragX and y == self.psDragY) then return end
		SV.Pan(x - self.psDragX, y - self.psDragY)
		self.psDragX, self.psDragY = x, y
	end)
end

-- A zone's part of the layer, lying at (l, r, t, b) of the canvas.
-- -> zone, its total on the layer
local function zoneMarks(map, layer, l, r, t, b, route)
	local z = { map = map, l = l, r = r, t = t, b = b, agg = {} }
	local total = 0
	if route then
		z.points, z.color, z.kind = Stats.Routes(route.kind)[map] or {}, route.color, route.kind
		for _, pt in ipairs(z.points) do if pt ~= 0 then total = total + 1 end end
	elseif layer.key == "p" then
		z.points = Stats.Trail(map) or {}
		for _, pt in ipairs(z.points) do if pt ~= 0 then total = total + 1 end end
	elseif layer.progress then
		local e = progress and progress[map]
		z.done, z.total, z.spots = e and e.done or 0, e and e.total or 0, e and e.spots
		total = z.done
	else
		z.cells, total = Stats.Heat(map, layer.key)
		if not z.cells then z.cells, total = {}, 0 end
	end
	return z, total
end

local function notReady(why)
	return why == "combat" and L["The lists of quests and rares load when combat ends."]
		or L["This needs Polestar's Codex (the Polestar_Codex folder), which is not installed."]
end

local function zoneName(map)
	return Compat.MapName and Compat.MapName(map) or tostring(map)
end

-- map: the zone whose own map to draw; nil: the world, with every zone on it.
local function drawMap(map, w)
	local world = map == nil
	local layer = layerOf(ns.Get("stats.layer"), world)
	local key = world and WORLD_KEY or map
	local flown = 0
	local zones, total, bounds, deepest = {}, 0, nil, MAX_ZOOM
	local jumps
	-- A progress layer: every zone the Codex knows work in, not only the ones played in.
	local ready, why, allDone, allTotal = true, nil, 0, 0
	progress = nil
	if layer.progress then
		ready, why = Stats.Progress.Ready()
		progress, allDone, allTotal = Stats.Progress[layer.progress]()
	end
	if world then
		WA.Refresh()
		local narrowest
		local ids = worldZones()
		if progress then
			ids = {}
			for id, e in pairs(progress) do
				if e.total > 0 and onWorld(id) then ids[#ids + 1] = id end
			end
			sort(ids)
		end
		for _, id in ipairs(ids) do
			WA.Include(id)
			local l, r, t, b = WA.Rect(id)
			if not layer.route then
				local z, n = zoneMarks(id, layer, l, r, t, b)
				zones[#zones + 1] = z
				total = total + n
			end
			if bounds then
				bounds[1], bounds[2], bounds[3], bounds[4] = min(bounds[1], l), max(bounds[2], r), min(bounds[3], t), max(bounds[4], b)
			else
				bounds = { l, r, t, b }
			end
			narrowest = min(narrowest or 1, r - l, b - t)
		end
		-- As far into the smallest zone played in as a zone's own map goes.
		deepest = MAX_ZOOM / (narrowest or 0.05)
		if layer.route then
			-- The routes lie on their continents' maps.
			for _, route in ipairs(ROUTES) do
				for id in pairs(Stats.Routes(route.kind)) do
					local l, r, t, b = WA.Rect(id)
					if l then
						local z, n = zoneMarks(id, layer, l, r, t, b, route)
						zones[#zones + 1] = z
						total = total + n
						if route.kind == "f" then flown = flown + n end
					end
				end
			end
			sort(zones, function(x, z)
				if x.map ~= z.map then return x.map < z.map end
				return x.kind < z.kind
			end)
			do
				jumps = {}
				for _, j in ipairs(Stats.Jumps()) do
					local l1, r1, t1, b1 = WA.Rect(j[1])
					local l2, r2, t2, b2 = WA.Rect(j[3])
					local x1, y1 = Stats.TrailXY(j[2])
					local x2, y2 = Stats.TrailXY(j[4])
					if l1 and l2 and x1 and x2 then
						jumps[#jumps + 1] = { l1 + x1 / 100 * (r1 - l1), t1 + y1 / 100 * (b1 - t1), l2 + x2 / 100 * (r2 - l2), t2 + y2 / 100 * (b2 - t2) }
					end
				end
				total = total + #jumps
			end
		end
	else
		local z, n = zoneMarks(map, layer, 0, 1, 0, 1)
		zones[1], total = z, n
	end
	local counted
	if layer.progress then
		local done, of = allDone, allTotal
		if not world then done, of = zones[1].done, zones[1].total end
		total = done
		counted = format("%s / %s  (%d%%)", num(done), num(of), percent(done, of))
	elseif layer.route then
		local a = Stats.Summary()
		counted = format(L["%s flights"], num(a.flights)) .. DOT .. format(L["%s in the air"], elapsed(a.flightSeconds))
			.. DOT .. format(L["%s in fares"], ns.MoneyText(a.spent.taxi))
			.. DOT .. format(L["%s rides"], num(a.rides)) .. DOT .. format(L["%s aboard"], elapsed(a.rideSeconds))
			.. DOT .. format(L["%s portals, hearths and trams"], num(jumps and #jumps or 0))
	else
		counted = format(layer.unit, layer.key == "t" and elapsed(total) or num(total))
	end
	local y = C.Note(pool, 0, w, counted)

	-- As tall as its width asks, or as the window has room for: the page does
	-- not scroll to show the rest of the map.
	local mw, mh = w, floor(w * MAP_RATIO)
	local room = scroll.GetHeight and scroll:GetHeight() or 0
	if room > 0 then mh = max(MAP_MIN_H, min(mh, floor(room - y - 8 - MAP_BELOW))) end
	if not mapArt then
		mapArt = UI.ZoneArt and UI.ZoneArt.Create(scroll.Child, mw, mh, "panel") or CreateFrame("Frame", nil, scroll.Child)
		-- The map as it is: no fades.
		mapArt.psDesat = MAP_DESAT
		if mapArt.Fade then mapArt.Fade:Hide() end
		if mapArt.Top then mapArt.Top:Hide() end
		mapPool = C.Pool(mapArt.Over or mapArt)
		wireMap(mapArt)
	end
	-- (the view's point in the middle of it)
	mapArt:SetSize(mw, mh)
	mapArt.psW, mapArt.psH, mapArt.psFocusY = mw, mh, mh / 2
	mapArt:ClearAllPoints()
	mapArt:SetPoint("TOPLEFT", scroll.Child, "TOPLEFT", SH.pad, -(y + 8))
	mapArt:Show()
	local fresh = (drawn and drawn.key or droppedKey) ~= key
	drawn = { key = key, world = world, layer = layer, zones = zones, jumps = jumps, bounds = bounds, maxZoom = deepest }
	if fresh then homeView() end
	if world and focusOn then
		local l, r, t, b = WA.Rect(focusOn)
		if l then fitView(l, r, t, b) end
	end
	focusOn = nil
	local painted = paintMap()
	y = y + 8 + mh + 12
	if layer.key ~= "p" and not layer.route then
		-- The heat's scale: its colours from the least to the most.
		local less = C.Text(pool, "caption", "textMuted", L["Less"], 0, y)
		local x = floor((less:GetStringWidth() or 28) + 0.5) + 8
		for i = 1, SHADES do C.Rect(pool, "ARTWORK", x + (i - 1) * 5, y + 2, 5, 8, HEAT[i]) end
		C.Text(pool, "caption", "textMuted", L["More"], x + SHADES * 5 + 8, y)
		y = y + 22
	end
	if not painted then y = C.Note(pool, y, w, L["This map's art is not available here, so the marks are drawn without it."]) end
	if layer.progress then
		if not ready then y = C.Note(pool, y, w, notReady(why)) end
	elseif layer.route then
		-- Which colour is which.
		local x = 0
		for _, route in ipairs(ROUTES) do
			C.Rect(pool, "ARTWORK", x, y + 4, 14, 4, route.color)
			local label = C.Text(pool, "caption", "textMuted", route.label, x + 20, y)
			x = x + 20 + floor((label:GetStringWidth() or 60) + 0.5) + 18
		end
		y = y + 22
		if flown == 0 then y = C.Note(pool, y, w, L["No flight drawn yet: a flight path's route is drawn from now on, as you fly it."]) end
	elseif total == 0 then
		y = C.Note(pool, y, w, layer.key == "p" and L["No path walked here yet: it is drawn from now on, as you move."] or L["Nothing counted on this layer here yet."])
	end
	shown.total = total
	return y
end

-- The Completion page: every zone with work in it for this character, the
-- most done first, for the tab picked.
function pages.completion(p, w)
	local tab = progressOf(ns.Get("stats.completion"))
	local ready, why = Stats.Progress.Ready()
	if not ready then return C.Note(p, 0, w, notReady(why)) end
	local zones, done, total = Stats.Progress[tab.progress]()
	local y = C.Note(p, 0, w, format(tab.done, num(done), num(total)) .. " (" .. percent(done, total) .. "%)")
	local rows = {}
	for id, e in pairs(zones) do
		if e.total > 0 then
			rows[#rows + 1] = { zoneName(id), e.done / e.total, format("%s / %s  (%d%%)", num(e.done), num(e.total), percent(e.done, e.total)) }
		end
	end
	sort(rows, function(a, b)
		if a[2] ~= b[2] then return a[2] > b[2] end
		return a[1] < b[1]
	end)
	shown.rows, shown.total = #rows, done
	if #rows > 0 then y = C.Bars(p, y + 8, w, rows, nil, 1) end
	return C.Note(p, y, w, tab.note)
end

---------------------------------------------------------------------------
-- The section
---------------------------------------------------------------------------

-- Lets go of what the map was drawn from (each zone's heat read out of its
-- tiles into cells, their spread, the path's points by map): held only while
-- a map is on screen. The view (zoom and place) stays for the same map.
local function dropMap()
	if drawn then droppedKey, drawn = drawn.key, nil end
	shown.zones, progress = nil, nil
end

function SV.Drop()
	dropMap()
	Stats.DropCaches()
end

-- Whether a map's marks are held now (tests).
function SV.Holds() return drawn ~= nil end

function SV.Build(parent, shell)
	if root then return root end
	shellRef = shell
	root = CreateFrame("Frame", nil, parent)
	root:SetAllPoints(parent)
	root:SetScript("OnHide", SV.Drop)
	scroll = W.Scroll(root)
	scroll:SetPoint("TOPLEFT", root, "TOPLEFT", 0, 0)
	scroll:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", 0, 0)
	root.Page = CreateFrame("Frame", nil, scroll.Child)
	root.Page:SetPoint("TOPLEFT", scroll.Child, "TOPLEFT", SH.pad, -12)
	root.Page:SetSize(1, 1)
	pool = C.Pool(root.Page)
	return root
end

-- The page in view: a page key, "world", or "map:<uiMapID>" with the map (a
-- zone that is not on the world map).
local function current()
	local key = ns.Get("stats.page")
	local map = type(key) == "string" and tonumber(key:match("^map:(%d+)$"))
	if map and not onWorld(map) then return key, map end
	if (map or key == WORLD_KEY) and #worldZones() > 0 then return WORLD_KEY end
	for _, pg in ipairs(PAGES) do if pg.key == key then return key end end
	return PAGES[1].key
end

function SV.Render()
	if not root then return end
	for k in pairs(shown) do shown[k] = nil end
	local key, map = current()
	local on = Stats.Enabled()
	local a = Stats.Summary()
	local w = pageWidth()
	local title, sub = L["Stats"], nil
	if not on then
		sub = L["Turned off: showing what was counted"]
	elseif a.since then
		sub = format(L["Counting since %s"], day(a.since)) .. DOT .. L["kept on this computer only"]
	end
	C.Reset(pool)
	local y
	if map or key == WORLD_KEY then
		title = map and (Compat.MapName and Compat.MapName(map) or tostring(map)) or L["World map"]
		if shellRef then
			local tabs = {}
			for _, l in ipairs(LAYERS) do
				if not map or not l.route then tabs[#tabs + 1] = { key = l.key, label = l.label } end
			end
			W.ShellTabs(shellRef, tabs, layerOf(ns.Get("stats.layer"), not map).key, function(k) SV.SetLayer(k) end)
		end
		y = drawMap(map, w)
	else
		hideMap()
		if key == COMPLETION then
			-- (its lists are the map's progress tabs': kept while this page shows)
			dropMap()
			if shellRef then
				local tabs = {}
				for _, l in ipairs(PROGRESS) do tabs[#tabs + 1] = { key = l.key, label = l.label } end
				W.ShellTabs(shellRef, tabs, progressOf(ns.Get("stats.completion")).key, function(k) SV.SetTab(k) end)
			end
		else
			SV.Drop()
		end
		for _, pg in ipairs(PAGES) do if pg.key == key then title = pg.label end end
		y = pages[key](pool, w, a)
	end
	if shellRef then W.ShellTitle(shellRef, title, sub) end
	if not on then y = C.Note(pool, y + 8, w, L["Stats is turned off. Turn it on under Options > Discovery > Stats."]) end
	scroll.Child:SetWidth(w + SH.pad * 2)
	W.SetScrollContent(scroll, y + 32)
	shown.page, shown.map, shown.title, shown.subtitle, shown.off = key, map, title, sub, not on
	shown.fonts, shown.rects, shown.lines = C.Counts(pool)
end

-- The sidebar: the pages, then the world map and the zones played in that
-- are not on it.
function SV.Nav()
	local out = {}
	for i, pg in ipairs(PAGES) do out[i] = { key = pg.key, label = pg.label } end
	local zones = Stats.HeatMaps()
	if #zones > 0 then out[#out + 1] = { separator = true } end
	if #worldZones() > 0 then out[#out + 1] = { key = WORLD_KEY, label = L["World map"], icon = "icon-goto" } end
	local listed = 0
	for _, z in ipairs(zones) do
		if listed >= MAX_ZONES then break end
		if not onWorld(z.map) then
			listed = listed + 1
			local name = Compat.MapName and Compat.MapName(z.map) or tostring(z.map)
			out[#out + 1] = { key = "map:" .. z.map, label = name, icon = "icon-explore" }
		end
	end
	return out, (current())
end

local function repaint()
	local P = UI.Picker
	if root and root:IsVisible() and P and P.Render then P.Render() else SV.Render() end
end

function SV.OnNav(key)
	local map = type(key) == "string" and tonumber(key:match("^map:(%d+)$"))
	if map and onWorld(map) then key, focusOn = WORLD_KEY, map end
	ns.Set("stats.page", key)
	if scroll then W.ScrollTo(scroll, 0) end
	repaint()
end

function SV.SetLayer(key)
	ns.Set("stats.layer", key)
	repaint()
end

-- The Completion page's tab.
function SV.SetTab(key)
	ns.Set("stats.completion", key)
	repaint()
end

function SV.Shown() return shown end

function SV.Show()
	local P = UI.Picker
	if UI.ShowPicker then UI.ShowPicker() end
	if P and P.ShowSection then P.ShowSection("Stats") end
	SV.Render()
end

ns.On("STATS_UPDATED", function() if root and root:IsVisible() then repaint() end end)
-- The pool's colours are set as they are drawn: a new look draws the page again.
Theme.OnChanged(function() if root and root:IsVisible() then SV.Render() end end)

if UI.RegisterSection then
	UI.RegisterSection({
		key = "Stats", label = L["Stats"], icon = "layers", order = 70,
		build = SV.Build, render = SV.Render,
		nav = SV.Nav, onNav = SV.OnNav,
	})
end
