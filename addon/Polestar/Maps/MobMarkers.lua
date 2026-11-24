-- Spawn markers for your quests: a marker on the world map and the minimap
-- for every spawn point of the mobs and objects your quests need, in
-- Polestar's look: its skull on its medallion (the guide's pickup bag for an
-- object). Skull colour = quest; for a quest with several mobs, a ring round
-- the medallion in each mob's colour; a legend on the world map lists the
-- quests and mobs there (hover a row to light its markers, click it to turn
-- them off or on, open a quest's chevron for its mobs). By default only the
-- quests of the guide step you're on; the whole log with no guide running.
-- Contributed by rohkin as Mob Markers (#1129), folded into Polestar: the
-- quests and their finished objectives are the quest log's (Compat), the
-- step's quests the Engine's, the mobs, objects and every spawn the Codex's
-- (a quest's objectives; an item's drops and the objects that give it).
-- Settings: Look > Map pins > Spawn markers (mobMarkers.*: on for a new
-- install, off for a profile from before them); the markers' size and
-- opacity follow the Map pins Icons settings (nav.worldIconSize,
-- nav.minimapIconSize, nav.worldPinAlpha, nav.minimapPinAlpha).
--
-- Taint: Forever's gamepad UI reads the world map from secure code, so (as
-- everything Polestar draws there) the markers are frames under the world
-- map's MapCanvas view (Nav/MapCanvas.lua): nothing written into the map, no
-- data provider, no AcquirePin, no OnMouseDown/Up scripts (the legend's
-- clicks come from GLOBAL_MOUSE_DOWN/UP while it shows); frames are made
-- parentless and then set under their parent (ns.CreateFrameUnder).
--
-- Cost: off, nothing is built and nothing runs per frame. On: the marks of
-- the quests shown (rebuilt only when the quests or their finished
-- objectives change), drawn on the world map's view as it changes and on
-- Nav/Pins' minimap view. The Codex is never loaded for them, not even by
-- opening the world map: they build once something else has loaded it (the
-- guide's engine, Lookup; CODEX_LOADED) or on /polestar spawns, which says
-- what it found; /polestar spawns preview marks 20 of this zone's quests
-- instead of your log (a test view, never saved).

local ADDON, ns = ...
local L = ns.L
local Compat = ns.Compat

local type, pairs, ipairs, pcall, tonumber, tostring = type, pairs, ipairs, pcall, tonumber, tostring
local floor, max, min = math.floor, math.max, math.min
local wipe = wipe or function(t) for k in pairs(t) do t[k] = nil end return t end

-- Polestar's colours by name, as { r, g, b }.
local function themed(names)
	local out = {}
	for i, n in ipairs(names) do
		local r, g, b = ns.Theme.Color(n)
		out[i] = { r, g, b }
	end
	return out
end

-- Colour palettes, picked in the settings: one for quests (the skull), one for mobs (the ring). "polestar" is
-- the theme's subject colours, soft pastels that read on night grounds; "rings" its accent, status and ground
-- colours.
local PALETTES = {
	polestar = themed({ "quest", "npc", "item", "success", "faction", "spell", "rare", "place" }),
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
PALETTES.polestar.label = L["Polestar pastels"]
local PALETTE_ORDER = { "polestar", "rings", "vivid", "muted", "safe", "mono" }

local MobMarkers = {}
ns.MobMarkers = MobMarkers

-- The palettes for the settings' dropdowns: { { value, label }, ... }.
function MobMarkers.Palettes()
	local out = {}
	for i, p in ipairs(PALETTE_ORDER) do out[i] = { value = p, label = PALETTES[p].label } end
	return out
end

local DEFAULTS = { enabled = true, showMinimap = true, showLegend = true, stepOnly = true, questPalette = "polestar", mobPalette = "polestar" }
ns.RegisterDefaults("mobMarkers", DEFAULTS)

-- On for a new install; a profile Polestar had before the markers keeps its maps as they were (off), until the
-- player turns them on. Saved profiles only: a profile string from before leaves the markers at today's default
-- instead of carrying an off (and the Map pins category with it) into the importer's settings.
ns.RegisterMigration("mobMarkersOff", function(s)
	if ns.IsNewAccount() then return end
	if type(s.mobMarkers) ~= "table" then s.mobMarkers = {} end
	if s.mobMarkers.enabled == nil then s.mobMarkers.enabled = false end
end, { strings = false })

local preview = false -- a test view, never saved: each session starts on the real quest log
local function opt(k)
	if k == "preview" then return preview end
	return ns.Get("mobMarkers." .. k)
end
local function on() return opt("enabled") and true or false end

local WHITE = "Interface\\Buttons\\WHITE8X8"
local MAP_MEDIA = "Interface\\AddOns\\Polestar\\Media\\Map\\"
local RINGS = { [16] = MAP_MEDIA .. "mob-ring16", [32] = MAP_MEDIA .. "mob-ring32", [64] = MAP_MEDIA .. "mob-ring64" }
local HOLE = 1 / 1.3 -- the rings' hole is this fraction of their size (tools/media/map.js mobRing)
local LEVEL = "PIN_FRAME_LEVEL_SUPER_TRACKED_QUEST"
local LOOT = "Interface\\AddOns\\Polestar\\Media\\UI\\icon-collect" -- an object's mark in place of the skull: the guide's pickup bag
-- The marker sizes before the Map pins Icons settings scale them (px on screen), and the opacities.
local WORLD_SIZE, MINIMAP_SIZE, FILL_ALPHA, BORDER_ALPHA = 10, 9, 0.5, 0.75

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

---------------------------------------------------------------------------
-- Marks: uiMapID -> { { x, y, fill, border, quest, mob, questID, objective, drop, key, icon }, ... }
-- objective: the index of its objective in the Codex quest; drop: the item it drops or gives, if any;
-- key: "questID:objective", the legend's and the hidden list's key for it; icon: the pickup bag for an
-- object, nil (the skull) for a mob.
---------------------------------------------------------------------------

local marks = {}
-- continent -> { { wx (north), wy (west), the rest as marks }, ... }
local world = {}
-- continent -> CELL-yard grid square -> the world marks in it, so the minimap looks only near you.
local CELL = 250
local grid = {}
local function cellKey(cx, cy) return (cx + 2000) * 4096 + (cy + 2000) end
-- The legend's rows, in quest-log order: { id, title, fill, mobs = { { id = objective, name, border }, ... } }
local quests = {}

-- Turned off from the legend, per character: CharState().mobMarkersHidden[questID] or [key].
local function hiddenList()
	local s = ns.CharState()
	if type(s.mobMarkersHidden) ~= "table" then s.mobMarkersHidden = {} end
	return s.mobMarkersHidden
end
local function off(qid, key)
	local h = ns.CharState().mobMarkersHidden
	return h and (h[qid] or h[key]) or false
end

-- The quest a hidden-list key belongs to: a questID, or "questID:objective".
local function questOf(k) return tonumber(k) or tonumber(tostring(k):match("^(%d+):")) end

-- Drops this character's hidden entries for quests it has turned in (only: just that quest, for
-- QUEST_TURNED_IN, which fires before the quest is flagged completed).
local function pruneHidden(only)
	local h = ns.CharState().mobMarkersHidden
	for k in pairs(h or {}) do
		local q = questOf(k)
		if q and (q == only or not only and Compat.IsQuestCompleted(q)) then h[k] = nil end
	end
end

-- Whether the quest log shows the quest's oi-th Codex objective, named name, finished. Matched on the
-- line's name as Polestar does (Engine Own.objectiveLine): the Codex's order is not the log's; the
-- oi-th line when no name matches (another locale).
local function objectiveDone(objs, oi, name)
	for _, o in ipairs(objs) do
		local l = Compat.ObjectiveLabel(o.text)
		if l ~= "" and (l == name or l:find(name, 1, true)) then return o.finished end
	end
	return objs[oi] and objs[oi].finished or false
end
-- The log's finished flags for a quest as one number (objective i finished: bit i), so build() notices an
-- objective finishing without making a string.
local NONE = {}
local function doneMask(qid)
	local m, bit = 0, 1
	for _, o in ipairs(Compat.GetQuestObjectives(qid) or NONE) do
		if o.finished then m = m + bit end
		bit = bit * 2
	end
	return m
end

-- A quest's objectives that need mobs or objects, one group each: a kill objective is its mob; an item
-- objective is every mob that drops it and every object that gives it, together; an object objective is
-- its object. { { oi, label, drop = item name or nil, npcs = { { kind, id }, ... } }, ... }
-- A source in two objectives stays in the first, so it gets one marker. Objectives the quest log shows
-- finished are left out; so are drops inside a dungeon.
local function questGroups(qid)
	local C = ns.Codex
	local q = C.Quest(qid)
	local objs = Compat.GetQuestObjectives(qid) or {} -- empty off the log (preview): nothing is left out
	local groups, seen = {}, {}
	local function group(oi, label, drop, npcs, objects)
		local g = { oi = oi, label = label, drop = drop, npcs = {} }
		for _, src in ipairs({ { "npc", npcs }, { "object", objects } }) do
			for _, id in ipairs(src[2] or {}) do
				local sk = src[1] .. id
				if not seen[sk] then seen[sk] = true; g.npcs[#g.npcs + 1] = { src[1], id } end
			end
		end
		if #g.npcs > 0 then groups[#groups + 1] = g end
	end
	for oi, o in ipairs(q and q.objectives or {}) do
		if o.type == "kill" and o.id then
			local name = C.Name("npc", o.id) or o.text or ""
			if not objectiveDone(objs, oi, name) then group(oi, name, nil, { o.id }) end
		elseif o.type == "object" and o.id then
			local name = C.Name("object", o.id) or o.text or ""
			if not objectiveDone(objs, oi, name) then group(oi, name, nil, nil, { o.id }) end
		elseif o.type == "item" and o.id then
			local it = C.Item(o.id)
			local name = it and it.name or o.text or ""
			if not objectiveDone(objs, oi, name) then
				local npcs, objects = {}, {}
				for _, s in ipairs(it and it.sources or {}) do
					if s.type == "drop" and s.npc and not s.instance then npcs[#npcs + 1] = s.npc
					elseif s.type == "object" and s.object then objects[#objects + 1] = s.object end
				end
				group(oi, name, name, npcs, objects)
			end
		end
	end
	return groups, q and q.title
end

-- A mob's or object's spawns, read once per build that wants it: its name, its spawns by map in percent
-- (live frame only: the fallback for a map without world bounds), and in world yards by continent.
local spawnCache, lastCache = {}, {}
local function spawnsOf(kind, id)
	local ck = kind .. id
	local c = spawnCache[ck] or lastCache[ck]
	if not c then
		local C = ns.Codex
		local rec = kind == "npc" and C.Npc(id) or C.Object(id)
		c = { name = rec and rec.name or (kind .. " " .. id), ui = {}, world = {} }
		for _, p in ipairs(rec and rec.spawns or {}) do
			if p.map and p.x and p.y then
				if not p.f then
					local l = c.ui[p.map] or {}
					c.ui[p.map] = l
					l[#l + 1], l[#l + 2] = p.x, p.y
				end
				local cont, wx, wy = Compat.MapToWorld(p.map, p.x, p.y, p.f)
				if cont then c.world[#c.world + 1] = { cont, wx, wy } end
			end
		end
	end
	spawnCache[ck] = c
	return c
end

-- The quests Polestar's current guide step works on: its open goals that name a quest, accepts and
-- hand-ins aside, in a set kept between calls. nil when Polestar runs no guide, so the whole log shows.
local stepSet = {}
local function stepQuests()
	local E = ns.Engine
	local view = E and E.GetStepView and E.GetStepView(E.GetStepIndex())
	if not view then return nil end
	wipe(stepSet)
	for _, g in ipairs(view.goals or NONE) do
		if g.quest and g.t ~= "accept" and g.t ~= "turnin" and g.t ~= "abandon"
			and g.status ~= "done" and g.status ~= "skipped" and g.status ~= "na" then stepSet[g.quest] = true end
	end
	return stepSet
end

-- The quest log's open quests (only the current step's, with "stepOnly"), into out: { questID, ... }.
local function logQuests(out)
	wipe(out)
	local only = opt("stepOnly") and stepQuests()
	for _, qid in ipairs(Compat.GetLogQuests()) do
		if not Compat.IsQuestReadyForTurnIn(qid) and (not only or only[qid]) then out[#out + 1] = qid end
	end
	return out
end

-- Preview (a test view, never saved): a full log of PREVIEW_MAX quests for the zone the world map shows,
-- your faction's, each with mobs or objects to find; the Codex's quests of that map.
local PREVIEW_MAX = 20 -- the game's quest log limit
local previewMap -- the uiMapID the preview was filled for
local previewCache = {} -- uiMapID -> its preview list
local function previewQuests(mapID)
	if not mapID then return NONE end
	if previewCache[mapID] then return previewCache[mapID] end
	local out, C = {}, ns.Codex
	local side = UnitFactionGroup("player") == "Alliance" and "A" or "H"
	local candidates = {}
	C.Each("quest", function(id)
		local q = C.Quest(id)
		if q and q.zone == mapID and (q.faction == nil or q.faction == side) then candidates[#candidates + 1] = id end
	end)
	table.sort(candidates)
	for _, id in ipairs(candidates) do
		if #questGroups(id) > 0 then
			out[#out + 1] = id
			if #out >= PREVIEW_MAX then break end
		end
	end
	previewCache[mapID] = out
	return out
end

-- Rebuilds the marks; false when the quests, their finished objectives and the palettes are what they
-- were, so the quest log's frequent updates (every kill and loot) and the guide's step changes cost nothing
-- and make no garbage. force: rebuild anyway. Off (or no Codex), every mark goes.
local built = false
local logIds, lastIds, lastDone = {}, {}, {}
local lastQP, lastMP
local function build(force)
	local C = ns.Codex
	if not (on() and C and C.IsLoaded and C.IsLoaded() and C.Quest) then
		if not built then return false end
		built = false
		wipe(lastIds)
		wipe(marks); wipe(world); wipe(grid); wipe(quests)
		spawnCache, lastCache = {}, {}
		return true
	end
	local list = opt("preview") and previewQuests(previewMap) or logQuests(logIds)
	local qp, mp = opt("questPalette"), opt("mobPalette")
	local same = built and not force and #list == #lastIds and qp == lastQP and mp == lastMP
	for i = 1, #list do
		local done = doneMask(list[i])
		if same and (list[i] ~= lastIds[i] or done ~= lastDone[i]) then same = false end
		lastIds[i], lastDone[i] = list[i], done
	end
	for i = #list + 1, #lastIds do lastIds[i], lastDone[i] = nil, nil end
	if same then return false end
	built, lastQP, lastMP = true, qp, mp
	wipe(marks)
	wipe(world)
	wipe(grid)
	wipe(quests)
	-- Spawns kept only for the quests marked now: a quest gone takes its mobs' spawns with it.
	lastCache, spawnCache = spawnCache, {}
	local qi = 0
	for _, qid in ipairs(list) do
		local groups, title = questGroups(qid)
		if #groups > 0 then
			qi = qi + 1
			local fill = fillFor(qi)
			local entry = { id = qid, title = Compat.GetQuestTitle(qid) or title, fill = fill, mobs = {} }
			quests[#quests + 1] = entry
			for gi, g in ipairs(groups) do
				-- One objective: nothing to tell apart, so the marker is the quest colour alone.
				local border = #groups == 1 and fill or borderFor(fill, gi)
				local key = qid .. ":" .. g.oi -- the Codex objective: stays put as others finish, so hidden keys do too
				entry.mobs[gi] = { id = g.oi, name = g.label, border = border }
				for _, src in ipairs(g.npcs) do
					local c = spawnsOf(src[1], src[2])
					local icon = src[1] == "object" and LOOT or nil
					for mapID, pts in pairs(c.ui) do
						local l = marks[mapID] or {}
						marks[mapID] = l
						for p = 1, #pts - 1, 2 do
							l[#l + 1] = { pts[p], pts[p + 1], fill, border, entry.title, c.name, qid, g.oi, g.drop, key, icon }
						end
					end
					for _, p in ipairs(c.world) do
						local m = { p[2], p[3], fill, border, entry.title, c.name, qid, g.oi, g.drop, key, icon }
						local l = world[p[1]] or {}
						world[p[1]] = l
						l[#l + 1] = m
						local cg = grid[p[1]] or {}
						grid[p[1]] = cg
						local ck = cellKey(floor(p[2] / CELL), floor(p[3] / CELL))
						local cl = cg[ck] or {}
						cg[ck] = cl
						cl[#cl + 1] = m
					end
				end
			end
		end
	end
	lastCache = {}
	return true
end

---------------------------------------------------------------------------
-- Drawing
---------------------------------------------------------------------------

local map, canvas, view -- set by install(): Blizzard_WorldMap can load after this file; view: its MapCanvas view
local dots = {}
local placed = 0 -- world map markers in use (dots[1..placed])

-- Polestar's own map mark for mobs (its quest tracker's kill pins): the skull on its medallion.
local SKULL = MAP_MEDIA .. "icon-kill"
local MEDAL = MAP_MEDIA .. "medallion-polestar"
-- The medallion at MEDAL_SCALE times the marker size; the skull at Polestar's proportion of it (27/24
-- of a mark that is 1/1.4 of its medallion); the mob ring's hole (HOLE of its size) is the medallion's
-- edge, so none of it shows through a see-through medallion, and the ring is 1.3 times its width.
local MEDAL_SCALE, SKULL_SCALE, RING_SCALE = 1.6, 27 / 24 / 1.4, 1 / HOLE
local BAG_SCALE = 0.85 -- the pickup bag, a little smaller than the skull on its medallion

-- The look every marker shares, read once per change: styleVer goes up whenever a setting that changes
-- it does, and a marker repaints only when its mark, size, highlight or styleVer changed.
local styleVer, style = 1, {}
local function currentStyle()
	if style.ver ~= styleVer then
		local _, ph = GetPhysicalScreenSize()
		style.ver = styleVer
		style.px = (ph or 768) / 768 -- screen pixels per UI unit at scale 1
		style.world = tonumber(ns.Get("nav.worldIconSize")) or 1
		style.minimap = tonumber(ns.Get("nav.minimapIconSize")) or 1
		style.worldAlpha = tonumber(ns.Get("nav.worldPinAlpha")) or 1
		style.mmAlpha = tonumber(ns.Get("nav.minimapPinAlpha")) or 1
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
		t:SetTexture(RINGS[n])
	end
end

local function tooltip(self)
	local m = self.m
	if not (m and m[5]) then return end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:AddLine(m[5], 1, 0.84, 0.45)
	GameTooltip:AddLine(m[6], 0.97, 0.97, 0.99)
	if m[9] then GameTooltip:AddLine((m[11] and L["Gives %s"] or L["Drops %s"]):format(m[9]), 0.77, 0.79, 0.87) end
	GameTooltip:Show()
end

-- A marker: the mob ring (under), the medallion, the skull.
local function newDot(parent)
	local f = ns.CreateFrameUnder("Frame", nil, parent or view.frame)
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
	f:SetScript("OnEnter", tooltip)
	f:SetScript("OnLeave", function() GameTooltip:Hide() end)
	return f
end

-- The medallion takes the fill opacity; the skull (quest colour) and, for a quest with several mobs,
-- the ring (mob colour) the border opacity. lit: its legend row is hovered.
local function paint(f, m, size, lit)
	local st = currentStyle()
	lit = lit or false
	local fa = lit and max(FILL_ALPHA, 0.8) or FILL_ALPHA -- stands out without resizing
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
	f.skull:SetTexture(m[11] or SKULL)
	local g = d * SKULL_SCALE * (m[11] and BAG_SCALE or 1)
	f.skull:SetSize(g, g)
	f.skull:SetVertexColor(m[3][1], m[3][2], m[3][3], BORDER_ALPHA)
	local several = m[4] ~= m[3] -- one mob: its border is the quest's own colour table
	f.ring:SetShown(several)
	if several then
		f.ring:SetSize(d * RING_SCALE, d * RING_SCALE)
		setRing(f.ring, d * RING_SCALE, st)
		f.ring:SetVertexColor(m[4][1], m[4][2], m[4][3], BORDER_ALPHA)
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
local function boundsOf(id)
	if bounds[id] == nil then
		bounds[id] = false
		local ok, c1, top, left = pcall(Compat.MapToWorld, id, 0, 0)
		local ok2, c2, bottom, right = pcall(Compat.MapToWorld, id, 100, 100)
		if ok and ok2 and c1 and c1 == c2 and top ~= bottom and left ~= right then
			bounds[id] = { c = c1, top = top, left = left, kx = 1 / (right - left), ky = 1 / (bottom - top) }
		end
	end
	return bounds[id]
end

local hl -- the legend row under the mouse: { q = questID, n = objective or nil }
local here = {} -- spawns on the shown map: [questID] and [key] -> count
local layoutLegend -- legend section, below
local minimapRedraw -- minimap section, below: draws its markers again (the marks, the hidden list or the look changed)
local drawSize, drawLevel -- what the last draw used, for restyle()

-- A world map marker painted for the legend row under the mouse: that row's come forward and fill in,
-- the rest fade; nothing moves or resizes.
local function paintLit(f, m)
	local lit = hl and m[7] == hl.q and (not hl.n or m[8] == hl.n) or false
	paint(f, m, drawSize, lit)
	local a = ((hl and not lit) and 0.25 or 1) * style.worldAlpha
	if f.a ~= a then f.a = a; f:SetAlpha(a) end
	local lv = drawLevel + (lit and 1 or 0)
	if f.lv ~= lv then f.lv = lv; f:SetFrameLevel(lv) end
end

local function restyle()
	for i = 1, placed do paintLit(dots[i], dots[i].m) end
end

-- relayout: the legend's content may have changed (another map, quests, a toggle), so lay it out again;
-- a zoom or resize only moves the markers.
local function draw(relayout)
	if not (map and map:IsShown() and on() and ns.GuideShown()) then
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
		minimapRedraw()
		relayout = true
	end
	wipe(here)
	local w, h = canvas:GetWidth(), canvas:GetHeight()
	-- Keep markers a constant size on screen whatever the canvas zoom.
	local s = 1 / ((map.GetCanvasScale and map:GetCanvasScale()) or 1)
	local size = WORLD_SIZE * currentStyle().world * s
	drawSize, drawLevel = size, levelFor()
	-- Markers of one objective within 1.5 medallions on screen share one: zoomed out a camp is one mark,
	-- not dozens stacked, and zooming in brings them back. The legend counts them all.
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
-- Legend: the quests and mobs on the shown map, in Polestar's look (night panel, hairline, accent title).
-- Rows are plain Frames, and clicks come from GLOBAL_MOUSE_DOWN/UP as Polestar's pins do: a Button or an
-- OnMouseDown/Up script on the map is taken up by the gamepad UI's navigation and taints it.
---------------------------------------------------------------------------

-- The player's colour scheme and accent, read when the legend is built.
local C = {}
-- SWATCH: the slot a row's marker sits in; LEGEND_MARK: the marker size it is painted at (its medallion is
-- drawn 1.6 times that, filling the slot).
local ROW, PAD, SWATCH, LEGEND_MARK, INDENT, MIN_W, MAX_W = 16, 8, 14, 9, 12, 150, 280
local CHEV = 16 -- a quest row's expand chevron: its slot at the row's right end
local CHEV_CLOSED = "Interface\\AddOns\\Polestar\\Media\\UI\\chevron-right"
local CHEV_OPEN = "Interface\\AddOns\\Polestar\\Media\\UI\\chevron-down"
local legend
local rows = {}
local hoverRow, pressedRow
local expanded = {} -- questID -> true: its mob rows are shown (this session)
local clicks -- the legend's click listener, listening only while the legend shows

local function tex(parent, layer, color, a)
	local t = parent:CreateTexture(nil, layer)
	t:SetTexture(WHITE)
	t:SetVertexColor(color[1], color[2], color[3], a or color[4] or 1)
	return t
end

local function buildLegend()
	for _, n in ipairs({ "bg", "ink", "accent", "text", "textDim", "textMuted" }) do C[n] = themed({ n })[1] end
	legend = ns.CreateFrameUnder("Frame", "PolestarMobMarkersLegend", map)
	local host = map.ScrollContainer or map
	legend:SetPoint("BOTTOMLEFT", host, "BOTTOMLEFT", 8, 30) -- above Polestar's coordinates bar
	legend:SetFrameLevel((host:GetFrameLevel() or 1) + 25)
	legend:EnableMouse(true) -- clicks on the panel stay off the map under it
	tex(legend, "BACKGROUND", C.bg, 0.88):SetAllPoints() -- the map shows through a little
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
	local r = ns.CreateFrameUnder("Frame", nil, legend)
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
	-- Expand chevron: a mouse-less frame, so the row keeps the hover and a click on the row asks whether
	-- the pointer was over it.
	r.chev = ns.CreateFrameUnder("Frame", nil, r)
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
	-- Quest rows show the quest's plain marker (border = fill: no mob ring), mob rows their own. The mark
	-- table is kept per colour pair, so an unchanged row does not repaint.
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

local function listen(yes)
	if not clicks or clicks.on == yes then return end
	clicks.on = yes
	if yes then
		clicks:RegisterEvent("GLOBAL_MOUSE_DOWN")
		clicks:RegisterEvent("GLOBAL_MOUSE_UP")
	else
		clicks:UnregisterAllEvents()
		pressedRow = nil
	end
end

function layoutLegend()
	if not legend then return end
	legend.title:SetText(opt("preview") and L["Quest spawns (preview)"] or L["Quest spawns"])
	local wanted = opt("showLegend") and on() and map:IsShown() and ns.GuideShown()
	local list = {}
	if wanted then
		for _, q in ipairs(quests) do
			if here[q.id] then
				-- One row per quest: its plain marker and all its spawns here. A quest with several mobs gets
				-- a chevron that opens a row per mob under it.
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
		listen(false)
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
	width = min(MAX_W, max(MIN_W, width))
	local y = -PAD - 14
	for i, e in ipairs(list) do
		setRow(row(i), y, e[1], e[2], e[3], e[4], e[5], e[6], e[7], width, e[8])
		y = y - ROW
	end
	for i = #list + 1, #rows do rows[i]:Hide() end
	legend:SetSize(width, -y + PAD - 2)
	legend:Show()
	listen(true)
end

-- A click is a mouse-down and -up of the left button on the same row: on its chevron it opens or closes
-- the quest, anywhere else it turns the row's markers off or on.
local function toggle(r)
	if r.chev:IsShown() and r.chev:IsMouseOver() then
		expanded[r.q] = not expanded[r.q] or nil
		draw(true)
		return
	end
	local h = hiddenList()
	local key = r.n and (r.q .. ":" .. r.n) or r.q
	h[key] = not h[key] or nil
	minimapRedraw()
	draw(true)
end

-- The world map's view (MapCanvas): another map or the map opened redraws with the legend; a zoom (the scale
-- changes every frame of it) at most every ZOOM_STEP seconds, and once more when it settles; closed, or Polestar
-- hidden, the markers and the legend go.
local ZOOM_STEP = 0.1
local zooming, zoomed, lastDraw = false, false, 0
local function onMap(_, what)
	if what == "tick" then
		if zoomed then
			zoomed = false
		elseif zooming then
			zooming, lastDraw = false, GetTime()
			draw()
		end
	elseif what == "show" or what == "map" then
		zooming, lastDraw = false, GetTime()
		draw(true)
	elseif what == "size" or what == "scale" then
		zooming, zoomed = true, true
		local now = GetTime()
		if now - lastDraw >= ZOOM_STEP then lastDraw = now; draw() end
	elseif what == "hide" then
		draw(true)
	end
end

local function install()
	local MC = ns.MapCanvas
	if view or not (MC and WorldMapFrame and WorldMapFrame.GetCanvas) then return end
	view = MC.Watch(WorldMapFrame, onMap)
	if not view then return end
	map, canvas = WorldMapFrame, view.canvas
	buildLegend()
	clicks = CreateFrame("Frame")
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
end

---------------------------------------------------------------------------
-- Minimap: world yards around the player, on Nav/Pins.lua's view of it (Pins.WatchMinimapView: called on each
-- frame the view changes, from the reads Pins makes for its own pins) and its projection, so both draw alike.
---------------------------------------------------------------------------

local mmDots, mmPlaced = {}, 0
local mmOn = false
local view = {} -- the minimap's last view: continent, player north and west, radius, facing, square

local function drawMinimap()
	local Pins = ns.Pins
	local px, py, radius, facing, square = view.px, view.py, view.radius, view.facing, view.square
	local n = 0
	local cg = mmOn and px and radius and ns.GuideShown() and grid[view.c]
	if cg then
		local half = Minimap:GetWidth() / 2
		local look = currentStyle()
		local size = MINIMAP_SIZE * look.minimap
		local lim = half - size / 2 -- a marker past the rim is not drawn (Polestar's pins clamp to it)
		-- Only the grid squares the view can reach.
		for cx = floor((px - radius) / CELL), floor((px + radius) / CELL) do
			for cy = floor((py - radius) / CELL), floor((py + radius) / CELL) do
				for _, m in ipairs(cg[cellKey(cx, cy)] or NONE) do
					local dn, dw = m[1] - px, m[2] - py
					if dn > -radius and dn < radius and dw > -radius and dw < radius and not off(m[7], m[10]) then
						local x, y, past = Pins.Project(dn, dw, facing, radius, half, facing ~= nil, square, lim)
						if not past then
							n = n + 1
							local f = mmDots[n]
							if not f then
								f = newDot(Minimap)
								f:SetFrameLevel(Minimap:GetFrameLevel() + 5)
								mmDots[n] = f
							end
							paint(f, m, size)
							f:SetAlpha(look.mmAlpha)
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
function minimapRedraw()
	if mmOn or mmPlaced > 0 then drawMinimap() end
end

local function onView(c, px, py, radius, facing, square)
	view.c, view.px, view.py, view.radius, view.facing, view.square = c, px, py, radius, facing, square
	drawMinimap()
end

-- The minimap markers on or off: Pins' view watch with them.
local function minimapOn(yes)
	local Pins = ns.Pins
	if not (Pins and Pins.WatchMinimapView and Pins.Project) then return end
	if yes == mmOn then return minimapRedraw() end
	mmOn = yes
	Pins.WatchMinimapView("mobMarkers", yes and onView or nil)
	minimapRedraw()
end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

local pending
-- force: rebuild even when the quests are unchanged (a palette or the preview switched).
local function rebuild(force)
	pending = nil
	if build(force) then
		draw(true)
		minimapRedraw()
	end
end
local queued = ns.Safe(function() rebuild() end)
local function queue()
	if pending or not on() then return end
	pending = true
	C_Timer.After(0.2, queued)
end

-- On or off: the world map's view is watched from the first time they are on (off, its draws hide everything),
-- the minimap's view while they are.
local function apply()
	local yes = on()
	if yes then install() end
	minimapOn(yes and opt("showMinimap") and not ns.Hidden() and true or false)
	rebuild(true)
	draw(true)
end

-- A mobMarkers setting or a Map pins Icons setting changed.
local function changed(key)
	styleVer = styleVer + 1 -- every marker repaints on its next draw
	if key == "preview" then previewMap = nil end -- filled on the next world map draw
	if key == "enabled" or key == "showMinimap" or key == "" then
		apply()
	elseif key == "questPalette" or key == "mobPalette" or key == "preview" or key == "stepOnly" then
		rebuild(true) -- colours are given out in build()
	else
		draw(true)
		minimapRedraw()
	end
end
local LOOK = { ["nav.worldIconSize"] = true, ["nav.minimapIconSize"] = true, ["nav.worldPinAlpha"] = true, ["nav.minimapPinAlpha"] = true }
ns.On("SETTING_CHANGED", function(path)
	if type(path) ~= "string" then return end
	local key = path:match("^mobMarkers%.(.+)")
	if key then
		changed(key)
	elseif path == "" or path == "mobMarkers" then
		changed("")
	elseif on() and (LOOK[path] or path == "nav" or path == "ui.shown") then
		changed(path)
	end
end)
-- Hiding the guide (ui.shown off, or an instance hide) hides the markers and legend with it.
ns.On("GUIDE_SHOWN", function() if on() then changed("shown") end end)

ns.OnLogin(function()
	pruneHidden()
	apply()
end)
ns.RegisterEvent("QUEST_TURNED_IN", function(_, qid) pruneHidden(qid) end)
ns.RegisterEvent("QUEST_LOG_UPDATE", queue)
-- The Codex loaded (by the guide's engine, Lookup or /polestar spawns): the marks build.
ns.On("CODEX_LOADED", function() if on() then rebuild(true) end end)
-- Polestar hidden or shown again: the minimap's markers and Pins' view watch go or come back (the world map's go
-- with its view), so nothing of theirs runs while hidden.
ns.On("POLESTAR_HIDDEN", function(hidden) minimapOn(not hidden and on() and opt("showMinimap") and true or false) end)
ns.RegisterEvent("ADDON_LOADED", function(_, name)
	if name == "Blizzard_WorldMap" and on() then apply() end
end)
-- Polestar's guide moving on changes which quests stepOnly shows.
local function stepMoved() if opt("stepOnly") then queue() end end
for _, msg in ipairs({ "STEP_CHANGED", "STEP_UPDATED", "GUIDE_CHANGED" }) do ns.On(msg, stepMoved) end

-- /polestar spawns: what the markers see, for when nothing shows; "preview": 20 of this zone's quests.
local function command(msg)
	-- Asked for: the Codex loads now if nothing has loaded it yet (CODEX_LOADED builds the marks).
	local C = ns.Codex
	if on() and C and C.IsLoaded and not C.IsLoaded() and C.Load then C.Load() end
	if msg and msg:lower():match("^%s*preview") then
		preview = not preview
		changed("preview")
		ns.Print(preview and L["Spawn markers: preview on. Open the world map on a zone."] or L["Spawn markers: preview off, your quest log again."])
		return
	end
	if not on() then
		ns.Print(L["Spawn markers are off: Settings, Map pins, Spawn markers."])
		return
	end
	rebuild(true)
	local maps, total = 0, 0
	for _, list in pairs(marks) do maps, total = maps + 1, total + #list end
	local spawns = 0
	for _, list in pairs(world) do spawns = spawns + #list end
	local id = map and map:GetMapID()
	ns.Print(L["Spawn markers: %d quests, %d spawns in world positions, %d zone marks on %d maps (%d on map %s), %d markers drawn."]:format(
		#quests, spawns, total, maps, id and marks[id] and #marks[id] or 0, tostring(id), placed))
end
ns.RegisterCommand("spawns", command, L["Spawn markers for your quests: what they found here (preview: 20 of this zone's quests)"])

-- For the tests and /polestar spawns: what is marked now (ids: the quests, in the legend's order).
function MobMarkers.State()
	local spawns, ids = 0, {}
	for _, list in pairs(world) do spawns = spawns + #list end
	for i, q in ipairs(quests) do ids[i] = q.id end
	return { quests = #quests, ids = ids, spawns = spawns, drawn = placed, minimap = mmPlaced }
end
