-- Polestar: Mob Markers, a companion to Polestar: a marker on the world map and minimap for every spawn point of the mobs your
-- active quests need, in Polestar's look: its skull on its medallion. Skull colour = quest; for a
-- quest with several mobs, a ring round the medallion in each mob's colour.
--
-- Taint: Forever's gamepad UI reads the world map from secure code, so (as in
-- Polestar/Nav/MapCanvas.lua) nothing here writes into the map: no data
-- provider, no AcquirePin, no OnMouseDown/Up scripts. Frames are created
-- parentless and then SetParent under the canvas; the map is only read.

local _, ns = ...
local DB = LibForeverData
local L = ns.L

-- Colour palettes, picked in the options: one for quests (the skull), one for mobs (the ring). "polestar" is Polestar Theme's SHARED subject colours, soft pastels
-- that read on night grounds; "rings" its accent, status and ground colours.
local PALETTES = {
	polestar = { label = L["Polestar pastels"],
		{ 1, 0.84, 0.45 }, { 0.58, 0.79, 1 }, { 0.78, 0.68, 1 }, { 0.42, 0.85, 0.6 },
		{ 0.97, 0.6, 0.79 }, { 0.47, 0.86, 0.93 }, { 1, 0.5, 0.32 }, { 0.96, 0.68, 0.52 } },
	rings = { label = L["Polestar rings"],
		{ 0.97, 0.97, 0.99 }, { 0.02, 0.03, 0.06 }, { 0.9, 0.73, 0.4 }, { 0.96, 0.45, 0.45 },
		{ 0.6, 0.88, 0.46 }, { 0.64, 0.52, 1 } },
	vivid = { label = L["Vivid"],
		{ 1, 0.82, 0.2 }, { 0.25, 0.6, 1 }, { 0.7, 0.4, 1 }, { 0.2, 0.85, 0.4 },
		{ 1, 0.35, 0.65 }, { 0.15, 0.85, 0.95 }, { 1, 0.45, 0.15 }, { 0.95, 0.25, 0.25 } },
	muted = { label = L["Muted"],
		{ 0.85, 0.75, 0.5 }, { 0.55, 0.65, 0.8 }, { 0.65, 0.58, 0.78 }, { 0.55, 0.72, 0.58 },
		{ 0.8, 0.58, 0.65 }, { 0.55, 0.75, 0.78 }, { 0.82, 0.55, 0.42 }, { 0.75, 0.68, 0.55 } },
	-- Okabe-Ito: told apart with the common colour-vision deficiencies.
	safe = { label = L["Colour-blind safe"],
		{ 0.9, 0.62, 0 }, { 0.34, 0.71, 0.91 }, { 0, 0.62, 0.45 }, { 0.94, 0.89, 0.26 },
		{ 0, 0.45, 0.7 }, { 0.84, 0.37, 0 }, { 0.8, 0.47, 0.65 }, { 0.6, 0.6, 0.6 } },
	mono = { label = L["Light & night"],
		{ 0.97, 0.97, 0.99 }, { 0.02, 0.03, 0.06 }, { 0.6, 0.64, 0.73 }, { 0.9, 0.73, 0.4 } },
}
local PALETTE_ORDER = { "polestar", "rings", "vivid", "muted", "safe", "mono" }

local HOLE = 1 / 1.3 -- the ring textures' hole is this fraction of their size (tools: the ring generator)
-- Polestar's settings mobMarkers.* (sizes in px on screen, opacity in percent), on its Map page.
local DEFAULTS = { worldSize = 10, minimapSize = 9, fillAlpha = 50, borderAlpha = 75, showWorld = true, showMinimap = true,
	showLegend = true, stepOnly = true, questPalette = "polestar", mobPalette = "polestar" }
Polestar.RegisterDefaults("mobMarkers", DEFAULTS)
local preview = false -- a debug view, never saved: each session starts on the real quest log
local function opt(k)
	if k == "preview" then return preview end
	return Polestar.Get("mobMarkers." .. k)
end
local WHITE = "Interface\\Buttons\\WHITE8X8"
local RING = "Interface\\AddOns\\Polestar_Mob_Markers\\ring%d.tga" -- 16, 32 and 64 px
local LEVEL = "PIN_FRAME_LEVEL_SUPER_TRACKED_QUEST"

local function palette(k) return PALETTES[opt(k)] or PALETTES[DEFAULTS[k]] end
-- The first quest (with stepOnly, often the only one) keeps the skull's own colours; the rest take
-- the palette from its start.
local NO_TINT = { 1, 1, 1 }
local function fillFor(qi)
	if qi == 1 then return NO_TINT end
	local fills = palette("questPalette")
	return fills[(qi - 2) % #fills + 1]
end

-- The mi-th border for a quest, never the quest's own fill colour.
local function borderFor(fill, mi)
	local borders = palette("mobPalette")
	local n = 0
	for i = 1, #borders * 2 do
		local b = borders[(i - 1) % #borders + 1]
		if not (b[1] == fill[1] and b[2] == fill[2] and b[3] == fill[3]) then
			n = n + 1
			if n == mi then return b end
		end
	end
	return borders[(mi - 1) % #borders + 1]
end

assert(borderFor(fillFor(1), 1) ~= borderFor(fillFor(1), 2) and fillFor(1) ~= fillFor(2), "Polestar: Mob Markers - palette")

---------------------------------------------------------------------------
-- Marks: uiMapID -> { { x, y, fill, border, quest, mob, questID, objective, drop, key }, ... }
-- objective: the index of its objective in the database quest (questGroups g.oi); drop: the item it drops, if any;
-- key: "questID:objective", the legend's and the hidden list's key for it.
---------------------------------------------------------------------------

local floor, max, abs, cos, sin = math.floor, math.max, math.abs, math.cos, math.sin

local marks = {}
-- continent -> { { wx (north), wy (west), the rest as marks }, ... }
local world = {}
-- continent -> CELL-yard grid square -> the world marks in it, so the minimap looks only near you.
local CELL = 250
local grid = {}
local function cellKey(cx, cy) return (cx + 2000) * 4096 + (cy + 2000) end
-- The legend's rows, in quest-log order: { id, title, fill, mobs = { { id = objective, name, border }, ... } }
local quests = {}

-- Turned off from the legend, per character: PolestarMobMarkersCharDB.hidden[questID] or [key].
local function off(qid, key)
	local h = PolestarMobMarkersCharDB and PolestarMobMarkersCharDB.hidden
	return h and (h[qid] or h[key]) or false
end

-- The quest a hidden-list key belongs to: a questID, or "questID:objective".
local function questOf(k) return tonumber(k) or tonumber(tostring(k):match("^(%d+):")) end
assert(questOf(12) == 12 and questOf("12:3") == 12, "Polestar: Mob Markers - questOf")

-- Drops this character's hidden entries for quests it has turned in (only: just that quest, for
-- QUEST_TURNED_IN, which fires before the quest is flagged completed).
local function pruneHidden(only)
	local h = PolestarMobMarkersCharDB and PolestarMobMarkersCharDB.hidden
	for k in pairs(h or {}) do
		local q = questOf(k)
		if q and (q == only or not only and C_QuestLog.IsQuestFlaggedCompleted(q)) then h[k] = nil end
	end
end

-- A quest's objectives that need mobs, one group each: a kill objective is its mob; an item
-- objective is every mob that drops it, together. { { label, drop = item name or nil, npcs = { id, ... } }, ... }
-- A mob in two objectives stays in the first, so it gets one marker. Objectives the quest log shows
-- finished are left out.
local PC = Polestar.Compat
-- Whether the quest log shows the quest's oi-th database objective, named name, finished. Matched on
-- the line's name as Polestar does (Engine Own.objectiveLine): the database's order is not the
-- log's; the oi-th line when no name matches (another locale).
local function objectiveDone(objs, oi, name)
	for _, o in ipairs(objs) do
		local l = PC.ObjectiveLabel(o.text)
		if l ~= "" and (l == name or l:find(name, 1, true)) then return o.finished end
	end
	return objs[oi] and objs[oi].finished or false
end
-- The log's finished flags for a quest ("10"), so build() notices an objective finishing.
local function doneSig(qid)
	local s = ""
	for _, o in ipairs(PC.GetQuestObjectives(qid) or {}) do s = s .. (o.finished and "1" or "0") end
	return s
end
local function questGroups(qid)
	local q = DB.Quest(qid)
	local objs = PC.GetQuestObjectives(qid) or {} -- empty off the log (preview): nothing is left out
	local groups, seen = {}, {}
	local function group(oi, label, drop, ids)
		local g = { oi = oi, label = label, drop = drop, npcs = {} }
		for _, id in ipairs(ids) do
			if id and not seen[id] then seen[id] = true; g.npcs[#g.npcs + 1] = id end
		end
		if #g.npcs > 0 then groups[#groups + 1] = g end
	end
	for oi, o in ipairs(q and q.objectives or {}) do
		if o.kind == "kill" or o.kind == "npc" then
			local name = DB.Name("npc", o.target) or ("NPC " .. o.target)
			if not objectiveDone(objs, oi, name) then group(oi, name, nil, { o.target }) end
		elseif o.kind == "item" then
			local it = DB.Get("item", o.target)
			local name = it and it.name or ("Item " .. o.target)
			if not objectiveDone(objs, oi, name) then group(oi, name, name, it and it.npcDrops or {}) end
		end
	end
	return groups, q and q.name
end

-- A mob's spawns, decoded once a session (the database decodes on every call): its name, its
-- spawns by map in percent, and in world yards.
local npcCache = {}
local function npcSpawns(id)
	local c = npcCache[id]
	if not c then
		local npc = DB.Get("npc", id)
		c = { name = npc and npc.name or ("NPC " .. id), ui = npc and npc.spawns or {}, world = DB.Spawns("npc", id) }
		npcCache[id] = c
	end
	return c
end

-- The quests Polestar's current guide step works on: its open goals that name a quest, accepts and
-- hand-ins aside. nil when Polestar runs no guide, so the whole log shows.
local function stepQuests()
	local E = Polestar and Polestar.Engine
	local view = E and E.GetStepView(E.GetStepIndex())
	if not view then return nil end
	local set = {}
	for _, g in ipairs(view.goals or {}) do
		if g.quest and g.t ~= "accept" and g.t ~= "turnin" and g.t ~= "abandon"
			and g.status ~= "done" and g.status ~= "skipped" and g.status ~= "na" then set[g.quest] = true end
	end
	return set
end

-- The quest log's open quests (only the current step's, with "stepOnly"): { { id, title }, ... }.
local function logQuests()
	local out, QL = {}, C_QuestLog
	local only = opt("stepOnly") and stepQuests()
	local count = QL.GetNumQuestLogEntries and QL.GetNumQuestLogEntries() or GetNumQuestLogEntries()
	for i = 1, count or 0 do
		local info = QL.GetInfo(i)
		local qid = info and not info.isHeader and not info.isHidden and info.questID
		if qid and qid > 0 and not QL.IsComplete(qid) and (not only or only[qid]) then out[#out + 1] = { id = qid, title = info.title } end
	end
	return out
end

-- Preview (a debug view, never saved): a full log of PREVIEW_MAX quests for the zone the world map
-- shows, your faction's, each with mobs to kill or loot; matched by the quest's zone name.
local PREVIEW_MAX = 20 -- the game's quest log limit
local previewMap -- the uiMapID the preview was filled for
local areaNames = {}
local function areaName(z)
	if z and areaNames[z] == nil then
		local ok, name = pcall(C_Map.GetAreaInfo, z)
		areaNames[z] = ok and name or false
	end
	return z and areaNames[z]
end
local byZone -- AreaTable id -> your faction's quest ids in it, ascending: one pass over the database a session
local previewCache = {} -- uiMapID -> its preview list
local function previewQuests(mapID)
	if mapID and previewCache[mapID] then return previewCache[mapID] end
	local out = {}
	local info = mapID and C_Map.GetMapInfo(mapID)
	local zone = info and info.name
	if not zone then return out end
	if not byZone then
		byZone = {}
		local side = UnitFactionGroup("player") == "Alliance" and 1 or 2
		for _, id in ipairs(DB.Ids("quest")) do
			local q = DB.Quest(id)
			if q and q.zone and (q.side or 0) ~= 3 - side then
				local l = byZone[q.zone] or {}
				byZone[q.zone] = l
				l[#l + 1] = { id = id, title = q.name }
			end
		end
	end
	local candidates = {}
	for z, l in pairs(byZone) do
		if areaName(z) == zone then
			for _, e in ipairs(l) do candidates[#candidates + 1] = e end
		end
	end
	table.sort(candidates, function(a, b) return a.id < b.id end)
	for _, e in ipairs(candidates) do
		if #questGroups(e.id) > 0 then
			out[#out + 1] = e
			if #out >= PREVIEW_MAX then break end
		end
	end
	previewCache[mapID] = out
	return out
end

-- Rebuilds the marks; false when the quests (and their colours) are what they were, so the quest
-- log's frequent updates (every kill and loot) cost nothing. force: rebuild anyway.
local lastSig
local function build(force)
	local list = opt("preview") and previewQuests(previewMap) or logQuests()
	local ids = {}
	for i, info in ipairs(list) do ids[i] = info.id .. ":" .. doneSig(info.id) end
	local sig = table.concat(ids, ",") .. "|" .. opt("questPalette") .. "|" .. opt("mobPalette")
	if not force and sig == lastSig then return false end
	lastSig = sig
	wipe(marks)
	wipe(world)
	wipe(grid)
	wipe(quests)
	local qi = 0
	for _, info in ipairs(list) do
		local qid = info.id
		local groups, title = questGroups(qid)
		if #groups > 0 then
			qi = qi + 1
			local fill = fillFor(qi)
			local entry = { id = qid, title = info.title or title, fill = fill, mobs = {} }
			quests[#quests + 1] = entry
			for gi, g in ipairs(groups) do
				-- One objective: nothing to tell apart, so the marker is the quest colour alone.
				local border = #groups == 1 and fill or borderFor(fill, gi)
				local key = qid .. ":" .. g.oi -- the database objective: stays put as others finish, so hidden keys do too
				entry.mobs[gi] = { id = g.oi, name = g.label, border = border }
				for _, npcId in ipairs(g.npcs) do
					local c = npcSpawns(npcId)
					for mapID, pts in pairs(c.ui) do
						local l = marks[mapID] or {}
						marks[mapID] = l
						for p = 1, #pts - 1, 2 do
							l[#l + 1] = { pts[p], pts[p + 1], fill, border, entry.title, c.name, qid, g.oi, g.drop, key }
						end
					end
					for _, p in ipairs(c.world) do
						local m = { p.x, p.y, fill, border, entry.title, c.name, qid, g.oi, g.drop, key }
						local l = world[p.map] or {}
						world[p.map] = l
						l[#l + 1] = m
						local cg = grid[p.map] or {}
						grid[p.map] = cg
						local ck = cellKey(floor(p.x / CELL), floor(p.y / CELL))
						local cl = cg[ck] or {}
						cg[ck] = cl
						cl[#cl + 1] = m
					end
				end
			end
		end
	end
	return true
end

---------------------------------------------------------------------------
-- Drawing
---------------------------------------------------------------------------

local map, canvas -- set by install(): Blizzard_WorldMap can load after this file
local dots = {}
local placed = 0 -- world map markers in use (dots[1..placed])

local function under(kind, parent)
	local f = CreateFrame(kind)
	f:SetParent(parent or canvas)
	return f
end

-- Polestar's own map mark for mobs (its quest tracker's kill pins): the skull on its medallion, read
-- from Polestar's folder (not copied: Polestar is GPL; the .toc depends on it).
local POLESTAR = "Interface\\AddOns\\Polestar\\Media\\Map\\"
local SKULL = POLESTAR .. "icon-kill"
local MEDAL = POLESTAR .. "medallion-polestar"
-- The medallion at MEDAL_SCALE times the marker size; the skull at Polestar's proportion of it (27/24
-- of a mark that is 1/1.4 of its medallion); the mob ring's hole (HOLE of its size) is the medallion's
-- edge, so none of it shows through a see-through medallion, and the ring is 1.3 times its width.
local MEDAL_SCALE, SKULL_SCALE, RING_SCALE = 1.6, 27 / 24 / 1.4, 1 / HOLE

-- The look every marker shares, read once per change: styleVer goes up whenever an option that
-- changes it does, and a marker repaints only when its mark, size, highlight or styleVer changed.
local styleVer, style = 1, {}
local function currentStyle()
	if style.ver ~= styleVer then
		local _, ph = GetPhysicalScreenSize()
		style.ver = styleVer
		style.fa = opt("fillAlpha") / 100
		style.ba = opt("borderAlpha") / 100
		style.px = (ph or 768) / 768 -- screen pixels per UI unit at scale 1
	end
	return style
end

-- The ring texture nearest the size it is drawn at: addon textures get no mipmaps, so a 64 px ring
-- drawn at 20 px skips most of its texels and comes out patchy.
local function setRing(t, size, st)
	local px = size * t:GetParent():GetEffectiveScale() * st.px
	local n = px <= 16 and 16 or px <= 32 and 32 or 64
	if t.ringN ~= n then
		t.ringN = n
		t:SetTexture(RING:format(n))
	end
end

-- A marker: the mob ring (under), the medallion, the skull.
local function newDot(parent)
	local f = under("Frame", parent)
	f.ring = f:CreateTexture(nil, "ARTWORK", nil, 0)
	f.ring:SetPoint("CENTER")
	f.medal = f:CreateTexture(nil, "ARTWORK", nil, 1)
	f.medal:SetPoint("CENTER")
	f.skull = f:CreateTexture(nil, "ARTWORK", nil, 2)
	f.skull:SetPoint("CENTER")
	f.skull:SetTexture(SKULL)
	f.medal:SetTexture(MEDAL)
	-- Pixel snapping makes small moving marks wobble a pixel at a time.
	for _, t in ipairs({ f.ring, f.medal, f.skull }) do
		if t.SetSnapToPixelGrid then t:SetSnapToPixelGrid(false); t:SetTexelSnappingBias(0) end
	end
	f:EnableMouse(true)
	if f.SetPassThroughButtons then pcall(f.SetPassThroughButtons, f, "RightButton") end
	f:SetScript("OnEnter", function(self)
		local m = self.m
		if not (m and m[5]) then return end
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:AddLine(m[5], 1, 0.84, 0.45)
		GameTooltip:AddLine(m[6], 0.97, 0.97, 0.99)
		if m[9] then GameTooltip:AddLine("Drops " .. m[9], 0.77, 0.79, 0.87) end
		GameTooltip:Show()
	end)
	f:SetScript("OnLeave", function() GameTooltip:Hide() end)
	return f
end

-- The medallion takes the fill opacity; the skull (quest colour) and, for a quest with several mobs,
-- the ring (mob colour) take the border opacity. lit: its legend row is hovered.
local function paint(f, m, size, lit)
	local st = currentStyle()
	lit = lit or false
	local fa = lit and max(st.fa, 0.8) or st.fa -- stands out without resizing
	if f.m == m and f.size == size and f.ver == st.ver then
		-- Same marker: a highlight change is only the medallion's opacity.
		if f.lit ~= lit then f.lit = lit; f.medal:SetVertexColor(1, 1, 1, fa) end
		return
	end
	f.m, f.size, f.lit, f.ver = m, size, lit, st.ver
	local d = size * MEDAL_SCALE
	f:SetSize(d, d)
	f.medal:SetSize(d, d)
	f.medal:SetVertexColor(1, 1, 1, fa)
	f.skull:SetSize(d * SKULL_SCALE, d * SKULL_SCALE)
	f.skull:SetVertexColor(m[3][1], m[3][2], m[3][3], st.ba)
	local several = m[4] ~= m[3] -- one mob: its border is the quest's own colour table
	f.ring:SetShown(several)
	if several then
		f.ring:SetSize(d * RING_SCALE, d * RING_SCALE)
		setRing(f.ring, d * RING_SCALE, st)
		f.ring:SetVertexColor(m[4][1], m[4][2], m[4][3], st.ba)
	end
end

local function dot(i)
	dots[i] = dots[i] or newDot()
	return dots[i]
end

local function levelFor()
	local lm = map.GetPinFrameLevelsManager and map:GetPinFrameLevelsManager()
	return lm and lm.GetValidFrameLevel and lm:GetValidFrameLevel(LEVEL) or canvas:GetFrameLevel() + 1
end

-- A map's world bounds (continent, top/left/bottom/right yards), false when the client can't say.
local bounds = {}
local function worldAt(id, u, v)
	local c, pos = C_Map.GetWorldPosFromMapPos(id, CreateVector2D(u, v))
	if c and pos then return c, pos:GetXY() end
end
local function boundsOf(id)
	if bounds[id] == nil then
		bounds[id] = false
		local ok, c1, top, left = pcall(worldAt, id, 0, 0)
		local ok2, c2, bottom, right = pcall(worldAt, id, 1, 1)
		if ok and ok2 and c1 and c1 == c2 and top ~= bottom and left ~= right then
			bounds[id] = { c = c1, top = top, left = left, kx = 1 / (right - left), ky = 1 / (bottom - top) }
		end
	end
	return bounds[id]
end

local hl -- the legend row under the mouse: { q = questID, n = objective or nil }
local here = {} -- spawns on the shown map: [questID] and [key] -> count
local layoutLegend -- legend section, below
local mmDirty = true -- minimap section, below: its markers need a redraw
local drawSize, drawLevel -- what the last draw used, for restyle()

-- A world map marker painted for the legend row under the mouse: that row's come forward and fill
-- in, the rest fade; nothing moves or resizes.
local function paintLit(f, m)
	local lit = hl and m[7] == hl.q and (not hl.n or m[8] == hl.n) or false
	paint(f, m, drawSize, lit)
	local a = (hl and not lit) and 0.25 or 1
	if f.a ~= a then f.a = a; f:SetAlpha(a) end
	local lv = drawLevel + (lit and 1 or 0)
	if f.lv ~= lv then f.lv = lv; f:SetFrameLevel(lv) end
end

local function restyle()
	for i = 1, placed do paintLit(dots[i], dots[i].m) end
end

-- relayout: the legend's content may have changed (another map, quests, a toggle), so lay it out
-- again; a zoom or resize only moves the markers.
local function draw(relayout)
	if not (map and map:IsShown() and opt("showWorld")) then
		for i = 1, placed do dots[i]:Hide() end
		placed = 0
		wipe(here)
		if layoutLegend then layoutLegend() end
		return
	end
	local id = map:GetMapID()
	if opt("preview") and id ~= previewMap then
		previewMap = id -- the preview follows the shown zone
		build()
		mmDirty = true
		relayout = true
	end
	wipe(here)
	local w, h = canvas:GetWidth(), canvas:GetHeight()
	-- Keep markers a constant size on screen whatever the canvas zoom.
	local s = 1 / ((map.GetCanvasScale and map:GetCanvasScale()) or 1)
	local size = opt("worldSize") * s
	drawSize, drawLevel = size, levelFor()
	-- Markers of one objective within 1.5 medallions on screen share one: zoomed out a camp is one
	-- mark, not dozens stacked, and zooming in brings them back. The legend counts them all.
	local cell = size * MEDAL_SCALE * 1.5
	local taken = {}
	local n = 0
	local function place(m, u, v)
		local q, key = m[7], m[10]
		here[q], here[key] = (here[q] or 0) + 1, (here[key] or 0) + 1
		if off(q, key) then return end
		local x, y = u * w, v * h
		local ck = key .. "|" .. floor(x / cell) .. ":" .. floor(y / cell)
		if taken[ck] then return end
		taken[ck] = true
		n = n + 1
		local f = dot(n)
		paintLit(f, m)
		f:SetPoint("CENTER", canvas, "TOPLEFT", x, -y)
		if not f:IsShown() then f:Show() end
	end
	-- Every spawn inside the shown map's rectangle, so neighbouring zones show their share.
	local b = id and boundsOf(id)
	if b then
		local left, top, kx, ky = b.left, b.top, b.kx, b.ky
		for _, m in ipairs(world[b.c] or {}) do
			local u, v = (m[2] - left) * kx, (m[1] - top) * ky
			if u >= 0 and u <= 1 and v >= 0 and v <= 1 then place(m, u, v) end
		end
	else
		for _, m in ipairs(marks[id] or {}) do place(m, m[1] / 100, m[2] / 100) end
	end
	for i = n + 1, placed do dots[i]:Hide() end
	placed = n
	if relayout and layoutLegend then layoutLegend() end
end

---------------------------------------------------------------------------
-- Legend: the quests and mobs on the shown map, Polestar-styled (night panel, hairline, gold title).
-- Rows are plain Frames, and clicks come from GLOBAL_MOUSE_DOWN/UP as Polestar's pins do: a Button
-- or an OnMouseDown/Up script on the map is taken up by the gamepad UI's navigation and taints it.
---------------------------------------------------------------------------

local C = {
	bg = { 0.095, 0.115, 0.178, 0.88 }, ink = { 1, 1, 1 }, accent = { 0.9, 0.73, 0.4 },
	text = { 0.967, 0.974, 0.991 }, textDim = { 0.765, 0.793, 0.868 }, textMuted = { 0.606, 0.637, 0.726 },
}
-- SWATCH: the slot a row's marker sits in; LEGEND_MARK: the marker size it is painted at (its
-- medallion is drawn 1.6 times that, filling the slot).
local ROW, PAD, SWATCH, LEGEND_MARK, INDENT, MIN_W, MAX_W = 16, 8, 14, 9, 12, 150, 280
local CHEV = 16 -- a quest row's expand chevron: its slot at the row's right end
local CHEV_CLOSED = "Interface\\AddOns\\Polestar\\Media\\UI\\chevron-right"
local CHEV_OPEN = "Interface\\AddOns\\Polestar\\Media\\UI\\chevron-down"
local legend
local rows = {}
local hoverRow, pressedRow
local expanded = {} -- questID -> true: its mob rows are shown (this session)

local function tex(parent, layer, color, a)
	local t = parent:CreateTexture(nil, layer)
	t:SetTexture(WHITE)
	t:SetVertexColor(color[1], color[2], color[3], a or color[4] or 1)
	return t
end

local function buildLegend()
	legend = CreateFrame("Frame", "PolestarMobMarkersLegend")
	legend:SetParent(map)
	local host = map.ScrollContainer or map
	legend:SetPoint("BOTTOMLEFT", host, "BOTTOMLEFT", 8, 30) -- above Polestar's coordinates bar
	legend:SetFrameLevel((host:GetFrameLevel() or 1) + 25)
	legend:EnableMouse(true) -- clicks on the panel stay off the map under it
	tex(legend, "BACKGROUND", C.bg):SetAllPoints()
	-- 1px hairline
	for _, side in ipairs({ { "TOPLEFT", "TOPRIGHT", 0, 1 }, { "BOTTOMLEFT", "BOTTOMRIGHT", 0, 1 },
		{ "TOPLEFT", "BOTTOMLEFT", 1, 0 }, { "TOPRIGHT", "BOTTOMRIGHT", 1, 0 } }) do
		local t = tex(legend, "BORDER", C.ink, 0.12)
		t:SetPoint(side[1]); t:SetPoint(side[2])
		if side[3] == 1 then t:SetWidth(1) else t:SetHeight(1) end
	end
	legend.title = legend:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	legend.title:SetPoint("TOPLEFT", PAD, -PAD)
	legend.title:SetTextColor(C.accent[1], C.accent[2], C.accent[3])
	legend:Hide()
end

local function row(i)
	if rows[i] then return rows[i] end
	local r = CreateFrame("Frame")
	r:SetParent(legend)
	r:SetHeight(ROW)
	r:EnableMouse(true)
	r.hover = tex(r, "BACKGROUND", C.ink, 0.07)
	r.hover:SetAllPoints()
	r.hover:Hide()
	-- A real marker, so the legend always matches the map's colours. The row takes the mouse.
	r.mark = newDot(r)
	r.mark:EnableMouse(false)
	r.slot = r:CreateTexture(nil, "ARTWORK") -- an empty anchor: the marker's slot
	r.slot:SetSize(SWATCH, SWATCH)
	r.label = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	r.label:SetJustifyH("LEFT")
	r.label:SetWordWrap(false)
	r.count = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	r.count:SetJustifyH("RIGHT")
	r.count:SetTextColor(C.textMuted[1], C.textMuted[2], C.textMuted[3])
	-- Expand chevron (Polestar's): a mouse-less frame, so the row keeps the hover and a click on the
	-- row asks whether the pointer was over it.
	r.chev = CreateFrame("Frame")
	r.chev:SetParent(r)
	r.chev:SetSize(CHEV, ROW)
	r.chev:SetPoint("RIGHT", r, "RIGHT", -PAD + 4, 0)
	r.chev.icon = r.chev:CreateTexture(nil, "OVERLAY")
	r.chev.icon:SetSize(10, 10)
	r.chev.icon:SetPoint("CENTER")
	r.chev.icon:SetVertexColor(C.textDim[1], C.textDim[2], C.textDim[3])
	r:SetScript("OnEnter", function(self)
		hoverRow = self
		self.hover:Show()
		hl = { q = self.q, n = self.n }
		restyle()
	end)
	r:SetScript("OnLeave", function(self)
		if hoverRow == self then hoverRow = nil end
		self.hover:Hide()
		hl = nil
		restyle()
	end)
	rows[i] = r
	return r
end

-- One row: a quest (n = nil, its plain marker) or one of its mobs (its ringed marker, indented).
-- chev: nil (no mobs to show), "closed" or "open".
local function setRow(r, y, q, n, label, fill, border, count, disabled, width, chev)
	r.q, r.n = q, n
	r.chev:SetShown(chev ~= nil)
	if chev then r.chev.icon:SetTexture(chev == "open" and CHEV_OPEN or CHEV_CLOSED) end
	local x = PAD + (n and INDENT or 0)
	r:ClearAllPoints()
	r:SetPoint("TOPLEFT", legend, "TOPLEFT", 1, y)
	r:SetPoint("TOPRIGHT", legend, "TOPRIGHT", -1, y)
	r.slot:ClearAllPoints()
	r.slot:SetPoint("LEFT", r, "LEFT", x - 2, 0)
	-- Quest rows show the quest's plain marker (border = fill: no mob ring), mob rows their own. The
	-- mark table is kept per colour pair, so an unchanged row does not repaint.
	r.marks = r.marks or {}
	local key = border or fill
	local m = r.marks[fill] and r.marks[fill][key]
	if not m then
		m = { nil, nil, fill, key }
		r.marks[fill] = r.marks[fill] or {}
		r.marks[fill][key] = m
	end
	paint(r.mark, m, LEGEND_MARK)
	r.mark:SetFrameLevel(r:GetFrameLevel() + 1)
	r.mark:ClearAllPoints()
	r.mark:SetPoint("CENTER", r.slot, "CENTER")
	r.mark:SetAlpha(disabled and 0.3 or 1)
	r.mark:Show()
	local tc = n and C.textDim or C.text
	r.label:SetTextColor(tc[1], tc[2], tc[3], disabled and 0.4 or 1)
	r.label:SetText(label)
	r.label:ClearAllPoints()
	r.label:SetPoint("LEFT", r.slot, "RIGHT", 6, 0)
	r.label:SetWidth(width - x - SWATCH - 6 - PAD - 28 - CHEV)
	r.count:SetText(count and ("x" .. count) or "")
	r.count:ClearAllPoints()
	r.count:SetPoint("RIGHT", r, "RIGHT", -PAD + 1 - CHEV, 0) -- every row leaves the chevron's slot, so counts line up
	r.count:SetAlpha(disabled and 0.4 or 1)
	r.hover:SetShown(hoverRow == r)
	r:Show()
end

function layoutLegend()
	if not legend then return end
	legend.title:SetText(opt("preview") and "Quest spawns (preview)" or "Quest spawns")
	local wanted = opt("showLegend") and opt("showWorld") and map:IsShown()
	local list = {}
	if wanted then
		for _, q in ipairs(quests) do
			if here[q.id] then
				-- One row per quest: its plain marker and all its spawns here. A quest with several mobs
				-- gets a chevron that opens a row per mob under it.
				local several = #q.mobs > 1
				local open = several and expanded[q.id]
				list[#list + 1] = { q.id, nil, q.title, q.fill, q.fill, here[q.id], off(q.id),
					several and (open and "open" or "closed") or nil }
				for _, m in ipairs(open and q.mobs or {}) do
					local key = q.id .. ":" .. m.id
					local c = here[key]
					if c then list[#list + 1] = { q.id, m.id, m.name, q.fill, m.border, c, off(q.id, key) } end
				end
			end
		end
	end
	if #list == 0 then
		legend:Hide()
		for _, r in ipairs(rows) do r:Hide() end
		return
	end
	-- Width from the longest label, within MIN_W..MAX_W.
	local width = legend.title:GetStringWidth() + PAD * 2
	local probe = row(1).label
	for _, e in ipairs(list) do
		probe:SetWidth(0)
		probe:SetText(e[3])
		width = max(width, probe:GetStringWidth() + PAD * 2 + SWATCH + 6 + 28 + CHEV + (e[2] and INDENT or 0))
	end
	width = math.min(MAX_W, max(MIN_W, width))
	local y = -PAD - 14
	for i, e in ipairs(list) do
		setRow(row(i), y, e[1], e[2], e[3], e[4], e[5], e[6], e[7], width, e[8])
		y = y - ROW
	end
	for i = #list + 1, #rows do rows[i]:Hide() end
	legend:SetSize(width, -y + PAD - 2)
	legend:Show()
end

-- A click is a mouse-down and -up of the left button on the same row: on its chevron it opens or
-- closes the quest, anywhere else it turns the row's markers off or on.
local function toggle(r)
	if r.chev:IsShown() and r.chev:IsMouseOver() then
		expanded[r.q] = not expanded[r.q] or nil
		draw(true)
		return
	end
	local h = PolestarMobMarkersCharDB.hidden
	local key = r.n and (r.q .. ":" .. r.n) or r.q
	h[key] = not h[key] or nil
	mmDirty = true
	draw(true)
end
local clicks = CreateFrame("Frame")
clicks:RegisterEvent("GLOBAL_MOUSE_DOWN")
clicks:RegisterEvent("GLOBAL_MOUSE_UP")
clicks:SetScript("OnEvent", function(_, event, button)
	if button ~= "LeftButton" then return end
	if event == "GLOBAL_MOUSE_DOWN" then
		pressedRow = hoverRow
	else
		local r = pressedRow
		pressedRow = nil
		if r and r == hoverRow and r:IsVisible() then toggle(r) end
	end
end)

-- Redraw only when what the map shows changed; runs only while the map is open. Another map redraws
-- at once with the legend; a zoom (the scale changes every frame of it) at most every ZOOM_STEP
-- seconds, and once more when it settles.
local ZOOM_STEP = 0.1
local lastMap, lastW, lastH, lastS
local zooming, lastDraw = false, 0
local function install()
	if canvas or not (WorldMapFrame and WorldMapFrame.GetCanvas) then return end
	map, canvas = WorldMapFrame, WorldMapFrame:GetCanvas()
	buildLegend()
	local watcher = under("Frame")
	watcher:SetScript("OnUpdate", function()
		local id, w, h = map:GetMapID(), canvas:GetWidth(), canvas:GetHeight()
		local s = map.GetCanvasScale and map:GetCanvasScale() or 1
		local now = GetTime()
		if id ~= lastMap then
			lastMap, lastW, lastH, lastS, zooming = id, w, h, s, false
			lastDraw = now
			draw(true)
		elseif w ~= lastW or h ~= lastH or s ~= lastS then
			lastW, lastH, lastS, zooming = w, h, s, true
			if now - lastDraw >= ZOOM_STEP then lastDraw = now; draw() end
		elseif zooming then
			zooming, lastDraw = false, now
			draw()
		end
	end)
end

---------------------------------------------------------------------------
-- Minimap: world yards around the player, projected as Polestar/Nav/Pins.lua does
---------------------------------------------------------------------------

-- View diameters (yards) per zoom level, for clients without C_Minimap.GetViewRadius.
local OUTDOOR = { [0] = 466 + 2 / 3, 400, 333 + 1 / 3, 266 + 2 / 3, 200, 133 + 1 / 3 }
local INDOOR = { [0] = 300, 240, 180, 120, 80, 50 }
local mmDots, mmState, mmPlaced = {}, {}, 0

local function viewRadius()
	local r = C_Minimap and C_Minimap.GetViewRadius and C_Minimap.GetViewRadius()
	if type(r) == "number" and r > 0 then return r end
	local zoom = Minimap:GetZoom() or 0
	return ((IsIndoors and IsIndoors() and INDOOR or OUTDOOR)[zoom] or OUTDOOR[0]) / 2
end

local function drawMinimap()
	local ok, px, py, _, cont = pcall(UnitPosition, "player")
	if not ok or type(px) ~= "number" then px = nil end
	local rotate = GetCVar("rotateMinimap") == "1"
	local facing = rotate and GetPlayerFacing and GetPlayerFacing() or nil
	local radius, half = viewRadius(), Minimap:GetWidth() / 2
	local st = mmState
	if not mmDirty and px == st[1] and py == st[2] and facing == st[3] and radius == st[4] and half == st[5] then return end
	st[1], st[2], st[3], st[4], st[5], mmDirty = px, py, facing, radius, half, false

	local n = 0
	local cg = px and opt("showMinimap") and grid[cont]
	if cg then
		local size = opt("minimapSize")
		local square = GetMinimapShape and GetMinimapShape() == "SQUARE"
		local k, lim = half / radius, half - size / 2
		local lim2 = lim * lim
		local c, s = facing and cos(facing), facing and sin(facing)
		-- Only the grid squares the view can reach.
		for cx = floor((px - radius) / CELL), floor((px + radius) / CELL) do
			for cy = floor((py - radius) / CELL), floor((py + radius) / CELL) do
				for _, m in ipairs(cg[cellKey(cx, cy)] or {}) do
					local dn, dw = m[1] - px, m[2] - py
					if dn > -radius and dn < radius and dw > -radius and dw < radius and not off(m[7], m[10]) then
						local x, y = -dw * k, dn * k -- east, north in px
						if c then x, y = x * c + y * s, -x * s + y * c end
						local inside
						if square then inside = abs(x) <= lim and abs(y) <= lim else inside = x * x + y * y <= lim2 end
						if inside then
							n = n + 1
							local f = mmDots[n]
							if not f then
								f = newDot(Minimap)
								f:SetFrameLevel(Minimap:GetFrameLevel() + 5)
								mmDots[n] = f
							end
							paint(f, m, size)
							f:SetPoint("CENTER", Minimap, "CENTER", x, y)
							if not f:IsShown() then f:Show() end
						end
					end
				end
			end
		end
	end
	for i = n + 1, mmPlaced do mmDots[i]:Hide() end
	mmPlaced = n
end

-- Every frame, in step with the minimap's own scrolling (a slower timer made dots lag and jitter);
-- children of the minimap only update while it is shown, and a still view returns at once.
under("Frame", Minimap):SetScript("OnUpdate", drawMinimap)

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

local pending
-- force: rebuild even when the quests are unchanged (a palette or the preview switched).
local function rebuild(force)
	pending = nil
	if build(force) then
		draw(true)
		mmDirty = true
	end
end
local function queue()
	if pending then return end
	pending = true
	C_Timer.After(0.2, rebuild)
end

-- A mobMarkers setting changed (from Polestar's options, or the old settings moving over).
local function changed(key)
	lastMap, mmDirty = nil, true -- both maps redraw on their next frame
	styleVer = styleVer + 1 -- and every marker repaints
	if key == "preview" then previewMap = nil end -- filled on the next world map draw
	if key == "questPalette" or key == "mobPalette" or key == "preview" or key == "stepOnly" then rebuild(true) end -- colours are given out in build()
end
Polestar.On("SETTING_CHANGED", function(path)
	local key = type(path) == "string" and path:match("^mobMarkers%.(.+)")
	if key then changed(key) end
end)

local function login()
	PolestarMobMarkersDB = PolestarMobMarkersDB or {}
	-- Before Polestar carried them, the settings were the addon's own: move them over once.
	for k in pairs(DEFAULTS) do
		if PolestarMobMarkersDB[k] ~= nil then
			Polestar.Set("mobMarkers." .. k, PolestarMobMarkersDB[k])
			PolestarMobMarkersDB[k] = nil
		end
	end
	PolestarMobMarkersDB.preview, PolestarMobMarkersDB.minimapButton, PolestarMobMarkersDB.minimapButtonAngle = nil, nil, nil
	-- The hidden list was account-wide: each character starts from a copy of it, then prunes its own.
	PolestarMobMarkersCharDB = PolestarMobMarkersCharDB or {}
	PolestarMobMarkersCharDB.hidden = PolestarMobMarkersCharDB.hidden or CopyTable(PolestarMobMarkersDB.hidden or {})
	pruneHidden()
end

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("QUEST_LOG_UPDATE")
events:RegisterEvent("QUEST_TURNED_IN")
events:SetScript("OnEvent", function(_, event, name)
	if event == "PLAYER_LOGIN" then login() end
	if event == "QUEST_TURNED_IN" then pruneHidden(name) end -- name: the questID here
	if event == "ADDON_LOADED" and name ~= "Blizzard_WorldMap" then return end
	install()
	queue()
end)
-- Polestar's guide moving on changes which quests stepOnly shows.
for _, msg in ipairs({ "STEP_CHANGED", "STEP_UPDATED", "GUIDE_CHANGED" }) do Polestar.On(msg, queue) end

---------------------------------------------------------------------------
-- Options: Polestar's options window, Map > Guide & quests > Mob spawns, beside its quest markers.
---------------------------------------------------------------------------

local PL = Polestar.L -- Polestar's own words, translated in its locale files
local function k(name) return "mobMarkers." .. name end
local function px(v) return ("%d px"):format(v) end
local function pct(v) return ("%d%%"):format(v) end
local function noWorld() return not opt("showWorld") end
local function palettes()
	local out = {}
	for i, p in ipairs(PALETTE_ORDER) do out[i] = { value = p, label = PALETTES[p].label } end
	return out
end
if Polestar.RegisterOptions then
	local ok, err = Polestar.RegisterOptions({
		page = PL["Map"], tab = PL["Guide & quests"], section = L["Mob spawns"],
		controls = {
			{ kind = "toggle", key = k("showWorld"), label = L["Mob spawns on the world map"], search = "mob markers, spawn points, kill, skull, map pins",
				help = L["Every spawn point of the mobs your quests need, one skull colour per quest and a ring per mob."] },
			{ kind = "toggle", key = k("showLegend"), label = L["Legend"], disabled = noWorld, child = true,
				help = L["Lists the quests and mobs on the shown map. Hover a row to highlight its markers, click it to turn them off or on."] },
			{ kind = "toggle", key = k("showMinimap"), label = L["Mob spawns on the minimap"], search = "mob markers, minimap pins",
				help = L["The same spawn markers on the minimap."] },
			{ kind = "toggle", key = k("stepOnly"), label = L["Only the current step's mobs"],
				help = L["Marks only the quests Polestar's current guide step works on, not your whole quest log. With no guide running, the whole log shows."] },
			{ kind = "dropdown", key = k("questPalette"), label = L["Quest colours"], choices = palettes, search = "colour blind, palette",
				help = L["The colours quests are given, in quest-log order: the skull's colour. The first quest keeps the skull's own colours."] },
			{ kind = "dropdown", key = k("mobPalette"), label = L["Mob colours"], choices = palettes, search = "colour blind, palette, rings",
				help = L["The colours of the rings that tell a quest's mobs apart. A quest with one mob has no ring."] },
			{ kind = "slider", key = k("worldSize"), label = L["World map marker size"], min = 4, max = 24, step = 1, format = px,
				help = L["The medallion is drawn 1.6 times this."] },
			{ kind = "slider", key = k("minimapSize"), label = L["Minimap marker size"], min = 4, max = 20, step = 1, format = px,
				help = L["The medallion is drawn 1.6 times this."] },
			{ kind = "slider", key = k("fillAlpha"), label = L["Medallion opacity"], min = 0, max = 100, step = 5, format = pct,
				help = L["How solid the medallion under each skull is."] },
			{ kind = "slider", key = k("borderAlpha"), label = L["Skull & ring opacity"], min = 0, max = 100, step = 5, format = pct,
				help = L["How solid the skull and the mob ring are."] },
		},
	})
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

local function openOptions()
	local UI = Polestar.UI
	if not (UI and UI.ShowOptions) then return end
	UI.ShowOptions("map")
	UI.Options.Select("map", PL["Guide & quests"])
end

-- /mobmarkers: what the addon sees, for when nothing shows. /mobmarkers config: its options.
SLASH_POLESTARMOBMARKERS1 = "/mobmarkers"
SLASH_POLESTARMOBMARKERS2 = "/pmm"
SlashCmdList.POLESTARMOBMARKERS = function(msg)
	if msg and msg:lower():match("^%s*config") then return openOptions() end
	if msg and msg:lower():match("^%s*preview") then
		preview = not preview
		changed("preview")
		print("Polestar: Mob Markers - preview " .. (preview and "on: open the world map on a zone." or "off: your quest log again."))
		return
	end
	rebuild(true)
	local maps, total = 0, 0
	for _, list in pairs(marks) do maps, total = maps + 1, total + #list end
	local id = map and map:GetMapID()
	print(("Polestar: Mob Markers - map %s, %d spawn marks on %d maps, %d on this map, %d markers drawn (overlaps merged)."):format(
		tostring(id), total, maps, id and marks[id] and #marks[id] or 0, placed)
		.. (id and boundsOf(id) and " Map bounds: live." or " Map bounds: unavailable (zone-only fallback)."))
end
