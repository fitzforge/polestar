-- Polestar's walking router. Started from Shortest Path Forever v1.16.0 (b1ad5bd) by Cillian Berragan (GPL-3.0-or-later); modified for Polestar since 2026-10-16.
-- Routing/Path.lua: Copyright (C) 2026 Cillian Berragan (https://github.com/cjber/shortest-path-forever); Polestar's
-- changes Copyright (c) 2026 The Polestar authors. This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3
-- of the License, or (at your option) any later version. It is distributed WITHOUT ANY WARRANTY; see the GNU General
-- Public License in this folder's LICENSE.
---@class SPFNamespace
local ns = select(2, ...)

-- Walking searches over PathGrid.lua's decoded maps: HPA* between ADT-tile clusters, an 8 yd grid inside them, and
-- FindMany's abstract Dijkstra. PathJobs.lua slices them over frames. On a map with ground classes (format 2) a grid
-- step costs its length times Costs.Mult(the class of the node it enters, the player's profile, the route style),
-- times the swim factor in water, a graph edge its profile's cost (costNone without a profile; Balanced's baked cost
-- in every style), and the A* heuristics scale by the smallest multiplier they may meet (Costs.MIN or the style's,
-- whichever is smaller); a map without them (format 1) routes as before classes, one edge cost for every profile and
-- style. Format 2 edges carry no walking-on-water cost: with waterWalking the graph reads the profile's (water at
-- swim) while the grid inside the end clusters runs on water.
-- Zone danger (the zone danger design, 2026-10-17): on a map with the zone field a caller's opts.danger ({ [uiMapID] =
-- multiplier }, multipliers at least 1) multiplies a grid step into a node by its chunk's zone's, a graph edge by the
-- larger of its two ends' and straightening's limit alike; no zone is closed, and the heuristics stay admissible.
-- Without danger (nil, {}, only multipliers of 1, or a map without the field) every search is exactly as before.
-- Every result carries yards beside its cost. Find's job.yards is the drawn line's flat length (any format). FindCost's
-- job.yards and FindMany's job.yards[i] are a second label along the cost-best path: on format 2 each grid step's
-- length and each graph edge's yards (one value an edge for every profile, the no-profile way's: across a cluster
-- where a profile detours a hostile hub, FindMany's yards understate the walk); on format 1, whose edges carry no yards, the cost itself (no per-step classes
-- there; a swum stretch counts at the swim factor), so yards[i] equals costs[i]. Find's job.hubs lists the hubs of
-- the map's metadata (D.hubs = { { id, side, name, areaId, disks = { { x, y, r }, ... } }, ... }: name in English,
-- areaId the town's AreaTable id) hostile to the profile that the drawn line enters: { { id, name, areaId }, ... },
-- each once, in path order; {} without a profile or hubs.
---@class SPFPath
local Path = ns.Path
local Grid, Costs = ns.PathGrid, ns.Costs
local tick, Deadline, Expansions, State, surface, grid =
	Grid.tick, Grid.Deadline, Grid.Expansions, Grid.State, Grid.surface, Grid.grid
local cellOf, nodesOf, metadata = Grid.cellOf, Grid.nodesOf, Grid.metadata
local edges, edgeTarget, edgeValue = Grid.edges, Grid.edgeTarget, Grid.edgeValue
local entrance, locate, standing, snap = Grid.entrance, Grid.locate, Grid.standing, Grid.snap
local zOf, floorCell, floorsOf = Grid.zOf, Grid.floorCell, Grid.floorsOf
local KINDS, VAL, CLS, MASK = Grid.KINDS, Grid.VAL, Grid.CLS, Grid.MASK
local INDOOR, CITY = Costs.CLASS.INDOOR, Costs.CLASS.CITY -- indoor ground: a node's base class (CLS % 8)
local byte = string.byte
local zoneAt, chunkDanger, nodeArea = Grid.zoneAt, Grid.chunkDanger, Grid.nodeArea

local TILE, SNAP, ZTOL, DX, DY = Grid.TILE, Grid.SNAP, Grid.ZTOL, Grid.DX, Grid.DY
local RETRIES = 8 -- other cells tried for an endpoint stuck in a pocket
local DROP = 30 -- how far below its surface a stuck endpoint may move: one can jump down a ledge, never climb one
local ARRIVE = 5 -- yd: a walk's end this near its goal, height and all, has reached it (Nav/Travel.lua's FLAT_ARRIVE)
local SQRT2 = math.sqrt(2)
local START, GOAL = -1, -2

local floor, sqrt, huge, max, abs = math.floor, math.sqrt, math.huge, math.max, math.abs
local yield = coroutine.yield

-- A danger table ({ [uiMapID] = multiplier }, opts.danger) -> its entries above 1 (nil when none) and their
-- signature, "uiMap=mult,..." by uiMapID ("" when none): what a cache tag carries, so two tables with the same
-- entries price alike and two different ones never share a cached search.
local function dangerOf(danger)
	if type(danger) ~= "table" then
		return nil, ""
	end
	local ids, kept = {}, {}
	for id, m in pairs(danger) do
		if type(id) == "number" and type(m) == "number" and m > 1 then
			ids[#ids + 1], kept[id] = id, m
		end
	end
	if #ids == 0 then
		return nil, ""
	end
	table.sort(ids)
	for i, id in ipairs(ids) do
		ids[i] = id .. "=" .. string.format("%.17g", kept[id])
	end
	return kept, table.concat(ids, ",")
end

-- Class multipliers by class byte for a profile ("Alliance", "Horde" or none), a style and a danger signature, built
-- once each. The caller's danger table leaves out the zones of a walk's start and goal, so it changes with each
-- start/goal zone pair as well as with a level-up: tags split per pair, bounded by the 32-table cap below.
local mults, multCount = {}, 0
-- A search's step multipliers on map state st for profile, style and danger: nil on a map without classes (every
-- step costs its length), and the heuristics' factor for a search that also crosses graph edges (Balanced's baked
-- costs): the smaller of Costs.MIN and the style's own, else 1 (a format 1 map searches exactly as before). mult.min
-- is the style's own smallest multiplier, for searches on the grid alone. On a map with the zone field, mult.danger
-- is danger's entries above 1 (dangerOf; nil for none), and mult.tag carries their signature: a step into a node
-- also costs danger[its chunk's zone], a graph edge its baked cost times the larger of its two ends' (run, runMany).
-- Multipliers are at least 1, so the heuristics stay admissible.
local function weights(st, profile, style, danger)
	if not st.classed then
		return nil, 1
	end
	style = Costs.Style(style)
	local kept, signature
	if st.zoned then
		kept, signature = dangerOf(danger)
	end
	-- A walked trail (Path.SetTrail) opens ways the grid doesn't have: its searches are their own (caches keyed by tag).
	local tag = (Costs.Profile(profile) or "") .. ":" .. style .. (kept and ":" .. signature or "")
		.. (st.trail and ":trail" .. st.trail.version or "")
	local mult = mults[tag]
	if not mult then
		if multCount >= 32 then
			mults, multCount = {}, 0
		end
		mult = { tag = tag, min = Costs.Min(style), danger = kept }
		for c = 0, 47 do -- every byte a run-length literal can hold
			mult[c] = Costs.Mult(c, Costs.Profile(profile), style)
		end
		mults[tag], multCount = mult, multCount + 1
	end
	return mult, math.min(Costs.MIN, mult.min)
end

-- The fifth argument of Find, FindCost and FindMany (the fourth of FindSync and FindManySync): a boolean is the
-- waterWalking flag every caller passed before profiles; a table is opts { waterWalking = boolean, profile =
-- "Alliance" | "Horde" | nil, style = "fastest" | "balanced" | "roads" | nil (Costs.Style: anything else is
-- Balanced), danger = { [uiMapID] = multiplier >= 1 } | nil (a step into a zone the table holds costs that many
-- times; weights), homeHub = true | nil (the walk starts or ends inside a town hostile to profile: it is priced as
-- for no profile, so it takes the town's own way in or out instead of the shortest way off the town's ground, over
-- its walls or the mountains, and a quest goal inside the town is walked to as the town's own people walk; the
-- hostile towns its drawn line enters are still reported for profile, and the walk's policy (Safe) is still
-- profile's) }.
-- -> waterWalking, profile (the one that prices), style, danger, report (the profile job.hubs is read for, and the
-- policy's), walkLevel
local function options(opts)
	if type(opts) == "table" then
		if opts.homeHub then
			return opts.waterWalking, nil, opts.style, opts.danger, opts.profile, opts.walkLevel
		end
		return opts.waterWalking, opts.profile, opts.style, opts.danger, opts.profile, opts.walkLevel
	end
	return opts, nil, nil, nil, nil
end

-- Strict jobs always validate the materialized walk. Only a rejected candidate needs
-- policy checks inside grid expansion; a continent's ordinary abstract A* stays cheap.
local Safe = { refusal = "no safe walking route" }
function Safe.setup(job)
	local d = Polestar and Polestar.Nav and Polestar.Nav.danger
	local profile = job.report or job.profile
	if not Costs.Profile(profile) then return "unknown faction" end
	if not d or type(d.Blocked) ~= "function" then return "missing danger policy" end
	if not State(job.map) then return "missing walking data" end
	local blocked, map = d.Blocked, job.map
	job.policy = blocked
	job.check = function(x, y, X, Y) return blocked(map, x, y, X, Y, profile) end
end
function Safe.segment(job, x, y, X, Y)
	local why = job.check(x, y, X, Y)
	if why then job.blockedReason = why end
	return why
end
function Safe.line(job, points, from, to)
	if not points or not points[1] then return false end
	local st = State(job.map)
	local solid = st and st.D.solidSamples and Grid.solidChord
	local a = from
	for i = 1, #points do
		local b = points[i]
		if b.rideFrom == a then
			if Safe.segment(job, a.x, a.y, a.x, a.y) or Safe.segment(job, b.x, b.y, b.x, b.y) then return false end
			if solid and (solid(st,a.x,a.y,a.z,a.x,a.y,a.z) or solid(st,b.x,b.y,b.z,b.x,b.y,b.z)) then return false end
		elseif solid and solid(st,a.x,a.y,a.z,b.x,b.y,b.z) then return false
		elseif Safe.segment(job, a.x, a.y, b.x, b.y) then return false end
		a = b
		tick()
	end
	return not Safe.segment(job, a.x, a.y, to.x, to.y) and not (solid and solid(st,a.x,a.y,a.z,to.x,to.y,to.z))
end
function Safe.xy(st, k, cell)
	return st.x0 + (floor(k / st.ny) * st.C + floor(cell / st.C) + .5) * st.cs,
		st.y0 + (k % st.ny * st.C + cell % st.C + .5) * st.cs
end
-- The displayed first/last point normally replaces its snapped centre. Beside a
-- hazard that substitution can cut the inside of a safe corner. Restore the centre
-- only on an adjacent mapped step and with independent support for the short join.
function Safe.joinEnd(st, P, keep, points, first)
	local n = #points
	if n < 2 then return end
	local i, j = first and 1 or n, first and 2 or n-1
	local cell, nextCell = keep[i], keep[j]
	if abs(cell-nextCell) > 1 then return end
	local a, b = points[i], points[j]
	local x = st.x0 + (P.x[cell]+.5)*st.cs
	local y = st.y0 + (P.y[cell]+.5)*st.cs
	if a.x == x and a.y == y then return end
	if not P.rides[max(cell,nextCell)] and not P.check(a.x,a.y,b.x,b.y) then return end
	local z = zOf(grid(st, P.k[cell]), P.n[cell])
	if not Path.FinalDrySight(st.map,a.x,a.y,a.z,x,y,z) then return end
	local at = first and 2 or n
	table.insert(points, at, { map=st.map, x=x, y=y, z=z })
	table.insert(keep, at, cell)
end
-- A distant snapped start can invent the first segment just as a substituted
-- goal can invent the last. Check the bearing the route actually draws.
-- Terrain evidence needs the start's height, which Forever's client does not
-- report, and it never covers the platforms and decks the maps leave out. So a
-- start without it still departs from TravelData's own places (a flight master,
-- a dock or deck, the tram's ends, a portal's ends: the table is the evidence),
-- and on open ground from a cell beside the player's on their storey: the node
-- is not indoor ground (floors and walls stack there: a lift shaft's top, the
-- Undercity's ring), no farther than the centre of a diagonal neighbour, no
-- higher or lower than a step plus a walkable slope (Safe.STEP, Safe.SLOPE),
-- and no known solid face on the way to it or along the drawn first segment.
-- A storey change, indoor ground or a wall still refuses the walk.
Safe.STEP, Safe.SLOPE = 2, 1.2 -- yd; the rise per yard of the steepest walkable ground (about 50 degrees)
function Safe.departure(st, P, from, b)
	local c, n = grid(st, P.k[1]), P.n[1]
	local nx, ny, nz = st.x0 + (P.x[1] + .5) * st.cs, st.y0 + (P.y[1] + .5) * st.cs, zOf(c, n)
	local dx, dy = nx - from.x, ny - from.y
	local dz = from.z and nz - from.z or 0
	if dx*dx + dy*dy + dz*dz <= ARRIVE*ARRIVE then return true end
	if b and from.z and b.z
		and (Path.FinalDrySight(st.map, from.x, from.y, from.z, b.x, b.y, b.z)
			or Path.FootprintDrySight(st.map, from.x, from.y, from.z, b.x, b.y, b.z)) then return true end
	local T = Polestar and Polestar.Nav and Polestar.Nav.travel
	if T and T.CuratedEnd and T.CuratedEnd(st.map, from.x, from.y) then return true end
	local kb = c.kind and byte(c.kind, n + 1)
	local cls = kb and CLS[kb] % 8
	if not cls or cls == INDOOR or cls == CITY then return false end
	local flat = math.sqrt(dx*dx + dy*dy)
	if flat > 1.5 * SQRT2 * st.cs or math.abs(dz) > Safe.STEP + Safe.SLOPE * flat then return false end
	local z = from.z or nz
	return not (Grid.solidChord(st, from.x, from.y, z, nx, ny, nz)
		or (b and Grid.solidChord(st, from.x, from.y, z, b.x, b.y, b.z or nz)))
end
-- A decoded cluster owns one bounded cache for its current policy. Local cells (not
-- floors) identify this symmetric XY predicate, including long directed jump arcs.
function Safe.gridGate(st, k, c, mult)
	local cache = c.safeSteps
	if not cache or cache.tag ~= mult.tag or cache.fn ~= mult.policy then
		cache = { tag = mult.tag, fn = mult.policy, n = 0, edges = {} }
		c.safeSteps = cache
	end
	local span = st.C * st.C
	return function(u, v)
		local key = u < v and u * span + v or v * span + u
		local value = cache.edges[key]
		if value == nil then
			local x, y = Safe.xy(st, k, u)
			local X, Y = Safe.xy(st, k, v)
			value = mult.check(x, y, X, Y) or false
			if cache.n >= 16384 then cache.n, cache.edges = 0, {} end
			if not value or not value:find("unknown", 1, true) then
				cache.edges[key], cache.n = value, cache.n + 1
			end
		end
		return value
	end
end

-- A graph edge's multiplier under mult.danger: the larger of its two ends' (each entrance's chunk's zone), each
-- entrance read once per search (memo). nil without danger.
local function edgeDanger(st, mult)
	local danger = mult and mult.danger
	if not danger then
		return nil
	end
	local memo = {}
	local function at(id)
		local m = memo[id]
		if not m then
			local z = zoneAt(st, floor(id / 4096), (metadata(st, id)))
			m = z and danger[z] or 1
			memo[id] = m
		end
		return m
	end
	return function(a, b)
		local ma, mb = at(a), at(b)
		return ma > mb and ma or mb
	end
end

-- Which values of a graph edge record (PathGrid.lua's edgeValue) are a step's cost and yards: -> the cost's and the
-- yards' value numbers. Format 2 prices an edge per profile (costNone without
-- one) and carries its yards; format 1 has one cost per water mode and its yards are that cost.
local function edgeFields(st, waterWalking, profile)
	if st.classed then
		local p = Costs.Profile(profile)
		return p == "Alliance" and 1 or p == "Horde" and 2 or 3, 4
	end
	local c = waterWalking and 2 or 1
	return c, c
end

-- Binary min-heap on parallel arrays, reset per search.
local hk, hv, hn = {}, {}, 0

local function push(k, v)
	hn = hn + 1
	local i = hn
	while i > 1 do
		local p = floor(i / 2)
		if hk[p] <= k then
			break
		end
		hk[i], hv[i] = hk[p], hv[p]
		i = p
	end
	hk[i], hv[i] = k, v
end

local function pop()
	local top = hv[1]
	local k, v = hk[hn], hv[hn]
	hn = hn - 1
	local i = 1
	while true do
		local c = i * 2
		if c > hn then
			break
		end
		if c < hn and hk[c + 1] < hk[c] then
			c = c + 1
		end
		if hk[c] >= k then
			break
		end
		hk[i], hv[i] = hk[c], hv[c]
		i = c
	end
	hk[i], hv[i] = k, v
	return top
end

-- Grid search inside one cluster, entering water costing swim times its length and, with mult (weights), a node of
-- class c mult[c] times it, and a node in a zone of mult.danger that zone's multiplier times. tree holds g/parent
-- keyed by node + 1 and, with mult, y: the yards walked along the cost-best path. With goal set it is A*, otherwise
-- Dijkstra that stops once every node in targets (a set of nodes) is settled. On a map with arcs (format 5's one-way
-- jumps and drops) a search steps along them; back (a search out of a goal, its tree walked to the goal) along them
-- backwards.
-- Each page holds 16 adjacent nodes' marks, costs and yards in one dense Lua array. Expanding outward from a
-- source otherwise inserts the same sparse numeric keys in three hash tables. Pages are allocated only after
-- the first accepted step into them. Label arithmetic and tie order are unchanged. A mark is stamp * SPAN +
-- parent + 1: stamp is 2 * gen while open, 2 * gen + 1 once settled; the source has parent -1.
-- Endpoint trees dropped from st.endTrees go to the
-- pool while it holds fewer than POOL (one is enough for the next connection: a tree grows to its cluster's size
-- once, then is reused), and so does the newest start's at rest (PathGrid.lua's Rest); Path.spareSeconds' rest empties
-- it. Path.treesMade counts the trees grown new (tests: a tree grown is a cluster's worth of keys inserted and rehashed).
local SPAN = 1048576 -- 2^20: above any node id + 1 (a cluster holds at most 65,536 nodes)
local PAGE = 16
local blank = {}
for i = 1, 3 * PAGE do blank[i] = 0 end
local function addPage(tree, k)
	local page = { unpack(blank) }
	tree[k] = page
	return page
end
local function label(tree, node, column)
	local j = node % PAGE
	local page = tree[(node - j) / PAGE + 1]
	return page and page[j + column]
end
function Grid.costAt(tree, node)
	return label(tree, node, PAGE + 1)
end
local pool, POOL = {}, 1
Path.treesMade = 0
local function Tree()
	local tree = table.remove(pool)
	if not tree then
		tree = { gen = 0 }
		Path.treesMade = Path.treesMade + 1
	end
	return tree
end
-- A tree given up (an endpoint tree st.endTrees no longer keeps) goes to the pool while it has room.
local function Release(tree)
	if tree and #pool < POOL then
		pool[#pool + 1] = tree
	end
end
-- Per kind byte (PathGrid's decoded clusters), a step's class multiplier (mult's; 1 without one) and its water factor
-- (swim in water, else 1), built once a multiplier table and a swim factor.
local ONES, swims = {}, {}
for b = 0, 255 do
	ONES[b] = 1
end
local function kindMults(mult)
	if not mult then
		return ONES
	end
	local t = mult.kinds
	if not t then
		t = {}
		for b = 0, 255 do
			t[b] = mult[CLS[b]] or 1
		end
		mult.kinds = t
	end
	return t
end
function Safe.weights(st, profile, style, danger, job, from, to)
	local base, hmin = weights(st, profile, style, danger)
	if not job.check then return base, hmin end
	local policy = tostring(job.report or profile)
	return { min = base and base.min or 1, kinds = kindMults(base), danger = base and base.danger,
		tag = (base and base.tag or tostring(profile)) .. ":strict:" .. policy .. ":" .. tostring(job.policy)
			.. (job.filtered and ":checked" or ":candidate"),
		check = job.filtered and job.check, policy = job.policy, from = from, to = to }, hmin
end
local function kindSwims(swim)
	local t = swims[swim]
	if not t then
		t = {}
		for b = 0, 255 do
			t[b] = VAL[b] == 2 and swim or 1
		end
		swims[swim] = t
	end
	return t
end

-- One grid search loop; splitting moves its retained arrays to upvalues on the hot path
-- limit: with goal, give up once the cheapest open node's cost plus its heuristic passes it (the goal costs more);
-- without, stop the Dijkstra once the cheapest open node costs more (every node settled costs at most limit).
local function search(st, k, swim, mult, source, tree, goal, targets, left, back, limit)
	-- Search only enters populated grids, through snapped endpoints or decoded entrances. A paused search keeps its
	-- cluster's strings even if another job evicts the cluster.
	local c = grid(st, k)
	local kind, mv, lm, xo, xs, zs, fl, first = c.kind, c.mv, c.lm, c.xo, c.xs, c.z, c.fl, c.first
	local WM, WS = kindMults(mult), kindSwims(swim)
	local gate = mult and mult.check and Safe.gridGate(st, k, c, mult)
	local arcTag = back and 255 or 254 -- the arcs a search steps along (PathGrid's xs): backwards out of a goal
	local C, cs = st.C, st.cs
	local unit = 4 * cs -- an arc's yards * 4 per cell
	local hs = cs * (mult and mult.min or 1) -- the cheapest yard: the heuristic never overstates
	local N = C * C
	-- Per chunk the zone multiplier of a step into it; nil when the cluster has no dangerous chunk (every search
	-- without danger).
	local dz = mult and mult.danger and chunkDanger(st, k, mult.danger)
	local weighted = mult ~= nil
	local trail = st.trail and st.trail.arcs[k] -- the walked trail's steps in this cluster (Path.SetTrail)
	tree.gen = tree.gen + 1
	local open = 2 * tree.gen * SPAN -- pm at or above it: open in this search; at or above settled: settled
	local settled = open + SPAN
	tree.k = k
	local gx, gy = 0, 0
	if goal then
		local cell = goal < N and goal or floorCell(c, goal)
		gx, gy = floor(cell / C), cell % C
	end
	hn = 0
	local j = source % PAGE
	local k0 = (source - j) / PAGE + 1
	local sourcePage = tree[k0] or addPage(tree, k0)
	sourcePage[j + 1], sourcePage[j + PAGE + 1], sourcePage[j + 2 * PAGE + 1] = open, 0, 0
	push(0, source)

	---@type number, number, number, number, number
	local u, ux, uy, gu, yu
	-- The node on local cell lc nearest height h (PathGrid's surface for layer -1, on this cluster's strings).
	local function nearest(lc, h)
		local best, gap
		if byte(kind, lc + 1) >= KINDS then
			local a, b = byte(zs, 2 * lc + 1, 2 * lc + 2)
			best, gap = lc, abs((a * 256 + b - 32768) / 2 - h)
		end
		local f1, f2, f3 = Grid.indexBytes(first, lc, 3)
		local v = (f1 * 256 + f2) * 256 + f3
		if v > 0 then
			local node = floor(v / 64) - 1
			for n = node, node + v % 64 - 1 do
				local z1, z2 = byte(zs, 2 * n + 1, 2 * n + 2)
				local d = abs((z1 * 256 + z2 - 32768) / 2 - h)
				if not gap or d < gap then
					best, gap = n, d
				end
			end
		end
		return best
	end
	local function relax(v, length)
		local i = v + 1
		local kb = byte(kind, i)
		local gv
		local cell = v
		if v >= N and (dz or goal or gate) then
			local a, b = byte(fl, 2 * (v - N) + 1, 2 * (v - N) + 2)
			cell = a * 256 + b
		end
		if dz then
			gv = gu + length * cs * WM[kb] * WS[kb] * dz[floor(floor(cell / C) * 16 / C) * 16 + floor(cell % C * 16 / C) + 1]
		else
			gv = gu + length * cs * WM[kb] * WS[kb]
		end
		local j = v % PAGE
		local key = (v - j) / PAGE + 1
		local page = tree[key]
		local mk = page and page[j + 1] or 0
		if mk < open or gv < page[j + PAGE + 1] then
			if gate and gate(ux * C + uy, cell) then return end
			if not page then page = addPage(tree, key) end
			page[j + PAGE + 1] = gv
			if mk < open then
				page[j + 1] = open + u + 1
			else
				page[j + 1] = mk - mk % SPAN + u + 1
			end
			if weighted then
				page[j + 2 * PAGE + 1] = yu + length * cs
			end
			local h = 0
			if goal then
				local ax, ay = floor(cell / C) - gx, cell % C - gy
				if ax < 0 then
					ax = -ax
				end
				if ay < 0 then
					ay = -ay
				end
				h = (ax > ay and ax + (SQRT2 - 1) * ay or ay + (SQRT2 - 1) * ax) * hs
			end
			push(gv + h, v)
		end
	end

	while hn > 0 do
		u = pop()
		local i = u + 1
		local j = u % PAGE
		local page = tree[(u - j) / PAGE + 1]
		local mk = page[j + 1]
		if mk < settled then
			page[j + 1] = mk + SPAN
			tick()
			if u == goal then
				return true
			end
			if limit and not goal then
				-- A Dijkstra settles in cost order: past limit, every node left costs more.
				if page[j + PAGE + 1] > limit then
					return false
				end
			elseif limit then
				-- Popped in order of cost plus the (consistent) heuristic: past limit, so is the goal.
				local lc = u < N and u or floorCell(c, u)
				local ax, ay = floor(lc / C) - gx, lc % C - gy
				if ax < 0 then
					ax = -ax
				end
				if ay < 0 then
					ay = -ay
				end
				if page[j + PAGE + 1] + (ax > ay and ax + (SQRT2 - 1) * ay or ay + (SQRT2 - 1) * ax) * hs > limit then
					return false
				end
			end
			if targets and targets[u] then
				left = left - 1
				if left <= 0 then
					return true
				end
			end
			local cell = u < N and u or floorCell(c, u)
			gu, ux, uy = page[j + PAGE + 1], floor(cell / C), cell % C
			if weighted then
				yu = page[j + 2 * PAGE + 1]
			end
			if u < N then
				-- This cell's moves, and the -x row's three around it (read only where that row exists).
				local ml, mi = byte(mv, i - 1, i)
				if uy == 0 then
					mi = byte(mv, i)
				end
				mi = mi % 16
				local mxm, mx0, mxp
				if ux > 0 and uy > 0 then
					mxm, mx0, mxp = byte(mv, i - C - 1, i - C + 1)
				elseif ux > 0 then
					mx0, mxp = byte(mv, i - C, i - C + 1)
				end
				local px, mx = mi % 2 == 1, ux > 0 and mx0 % 2 == 1
				local py, my = mi % 4 >= 2, uy > 0 and ml % 4 >= 2
				if px then
					relax(u + C, 1)
				end
				if mx then
					relax(u - C, 1)
				end
				if py then
					relax(u + 1, 1)
				end
				if my then
					relax(u - 1, 1)
				end
				if mi % 8 >= 4 then
					relax(u + C + 1, SQRT2)
				end
				if mi >= 8 then
					relax(u + C - 1, SQRT2)
				end
				if ux > 0 and uy > 0 and mxm % 8 >= 4 then
					relax(u - C - 1, SQRT2)
				end
				if ux > 0 and uy < C - 1 and mxp % 16 >= 8 then
					relax(u - C + 1, SQRT2)
				end
			end
			-- Steps to the surface nearest the node's height on a neighbouring cell, then its other moves: steps to a
			-- layer, and arcs.
			local zu
			local dirs = MASK[byte(lm, i)]
			if #dirs > 0 then
				zu = zOf(c, u)
				for e = 1, #dirs do
					local d = dirs[e]
					local tx, ty = ux + DX[d], uy + DY[d]
					if tx >= 0 and ty >= 0 and tx < C and ty < C then
						local v = nearest(tx * C + ty, zu)
						if v then
							relax(v, d >= 4 and SQRT2 or 1)
						end
					end
				end
			end
			local o1, o2, o3, p1, p2, p3 = Grid.indexBytes(xo, u, 6)
			local a, b = (o1 * 256 + o2) * 256 + o3, (p1 * 256 + p2) * 256 + p3
			while a < b do
				local e = byte(xs, a + 1)
				if e < 254 then
					local d, layer
					if e < 248 then
						d, layer, a = e % 8, floor(e / 8) - 1, a + 1
					else
						local x1, x2 = byte(xs, a + 2, a + 3)
						d, layer, a = x1, x2 - 1, a + 3
					end
					local tx, ty = ux + DX[d], uy + DY[d]
					if tx >= 0 and ty >= 0 and tx < C and ty < C then
						zu = zu or zOf(c, u)
						local v = layer == -1 and nearest(tx * C + ty, zu) or surface(st, k, tx * C + ty, layer, zu, c)
						if v then
							relax(v, d >= 4 and SQRT2 or 1)
						end
					end
				else
					if e == arcTag then
						local t1, t2, t3, y1, y2 = byte(xs, a + 2, a + 6)
						relax((t1 * 256 + t2) * 256 + t3, (y1 * 256 + y2) / unit)
					end
					a = a + 6
				end
			end
			-- The player's own steps where the grid has no way (Path.SetTrail): both ways, at their length.
			local t = trail and trail[u]
			if t then
				for e = 1, #t, 2 do
					relax(t[e], t[e + 1])
				end
			end
		end
	end
	-- The heap ran dry: every node reachable from source is settled (an endpoint tree that never met all its targets).
	tree.whole = tree.gen
	return goal == nil
end

-- Settled in the tree's last search (no later search has a larger stamp).
local function reached(tree, node)
	local v = label(tree, node, 1)
	return v ~= nil and v >= (2 * tree.gen + 1) * SPAN
end

-- The yards along a tree's path to node: its yards label on a map with classes, its cost on one without (format 1).
local function yardsAt(st, tree, node)
	return label(tree, node, st.classed and 2 * PAGE + 1 or PAGE + 1)
end

-- Node path in a tree from node back to its source (node first).
local function trace(tree, node, out)
	while node >= 0 do
		out[#out + 1] = node
		node = label(tree, node, 1) % SPAN - 1
	end
	return out
end

local trees = { S = Tree(), G = Tree(), R = Tree(), B = {} } -- (B: connectWithin's, one per start surface)

-- Abstract A* state.
local ag, ay, apar, astamp, aclosed, agen = {}, {}, {}, {}, {}, 0

-- Endpoint searches: grid Dijkstra to the cluster's entrances.
local function endpoint(st, swim, mult, tree, k, node, back)
	local targets, left = {}, 0
	for _, id in ipairs(nodesOf(st, k)) do
		local e = entrance(st, id)
		if e and not targets[e] then
			targets[e], left = true, left + 1
		end
	end
	search(st, k, swim, mult, node, tree, nil, targets, left, back)
end
-- An endpoint on a rooftop or ledge the grid cannot leave moves to the nearest node that reaches an entrance,
-- down a ledge but never up one or onto another level: ring by ring, RETRIES cells at most. A point asked at a height
-- (`want`: an NPC's spawn, the player's floor) has a second order too: every surface of the cells within SNAP, its own
-- cell's others included, by its distance plus twice its gap to that height (as snap weighs them), RETRIES more. A
-- goal (`back`) tries that order first: one whose own cell holds only a counter, a table or a stair's piece above the
-- floor the NPC stands on finds that floor a few cells away (0.4.1: the Stonefire Tavern's innkeeper, 5 yd under the
-- bar's surfaces round her, was walked to over the mountain above Ironforge; Nissa Firestone's ring settled on a ledge
-- whose entrance leads nowhere). Every surface, not only a cell's nearest to that height: round an NPC on a deck the
-- maps join to nothing, that nearest is the deck itself (already searched, so skipped) over the floor below it that
-- people walk up from. Booty Bay's Gyll (36 yd up) settled on a deck of his height beyond the rail, 17 yd off, and the
-- line ran straight over it (about 120 yd round on foot); now on the floor under his own cell, 5 yd down, where the
-- way up starts. The climb itself is not on the maps, and the walk says so (run: job.reached). A start (the player,
-- on the floor Walk.lua follows) tries the rings first, as before, the other order only when they find nothing.
-- `pockets` (a rescue: connect's, for runAny's last tries only): a try is a node no failed try reached, not only the
-- latest. A search that met no entrance flooded its whole pocket (endpoint stops only on meeting them all or running
-- dry), and every node it reached joins that pocket the same way round (`back` alike in every try): none of them
-- reaches an entrance either. So each order's RETRIES tries go to distinct pockets, in the same order as without.
-- Steamwheedle Port (Tanaris, -6974, -4846): floors 14 to 20 yd up joined to each other and to nothing else; every
-- try of both orders went to that one pocket, and every walk to or from it was unreachable.
local function settle(st, swim, mult, tree, k, node, back, want, pockets)
	local C = st.C
	endpoint(st, swim, mult, tree, k, node, back)
	local function connected()
		for _, id in ipairs(nodesOf(st, k)) do
			local e = entrance(st, id)
			if e and reached(tree, e) then
				return true
			end
		end
		return false
	end
	if connected() then
		return node
	end
	local start = node
	local h = zOf(grid(st, k), node)
	local cell = cellOf(st, k, node)
	local lx, ly = floor(cell / C), cell % C
	-- A rescue's pockets: every node either order may try (the surfaces of the cells within SNAP), each one a failed
	-- try reached marked dead (the asked node's own pocket first).
	local around, dead
	local function failed()
		for _, n in ipairs(around) do
			if not dead[n] and reached(tree, n) then
				dead[n] = true
			end
		end
	end
	if pockets then
		local c = grid(st, k)
		around, dead = {}, {}
		for x = max(0, lx - SNAP), math.min(C - 1, lx + SNAP) do
			for y = max(0, ly - SNAP), math.min(C - 1, ly + SNAP) do
				local lc = x * C + y
				if byte(c.kind, lc + 1) >= KINDS then
					around[#around + 1] = lc
				end
				local first, count = floorsOf(c, lc)
				for f = first or 0, (first or 0) + count - 1 do
					around[#around + 1] = f
				end
			end
		end
		failed()
	end
	-- n is not tried: the latest try reached it (rescuing: any failed one did).
	local function skip(n)
		return reached(tree, n) or (pockets and dead[n]) or false
	end
	-- Ring by ring: the node settled (true), or the last one tried (false).
	local function rings()
		local tries, at = 0, start
		for r = 1, SNAP do
			for dx = -r, r do
				for dy = -r, r do
					if tries >= RETRIES then
						return at, false
					end
					local x, y = lx + dx, ly + dy
					local ring = dx == r or dx == -r or dy == r or dy == -r
					if ring and x >= 0 and y >= 0 and x < C and y < C then
						local near = standing(st, k, x * C + y, h)
						local rise = near and zOf(grid(st, k), near) - h
						if near and rise <= ZTOL and rise >= -DROP and not skip(near) then
							tries, at = tries + 1, near
							endpoint(st, swim, mult, tree, k, at, back)
							if connected() then
								return at, true
							end
							if pockets then
								failed()
							end
						end
					end
				end
			end
		end
		return at, false
	end
	-- By distance and height gap to want: the node settled, or nil.
	local function nearest()
		local cands = {}
		local c = grid(st, k)
		local function consider(near, dx, dy)
			local z = zOf(c, near)
			if z - h <= ZTOL and z - h >= -DROP then
				cands[#cands + 1] = { near, sqrt(dx * dx + dy * dy) * st.cs + 2 * abs(z - want), #cands }
			end
		end
		for r = 0, SNAP do
			for dx = -r, r do
				for dy = -r, r do
					local x, y = lx + dx, ly + dy
					if (dx == r or dx == -r or dy == r or dy == -r) and x >= 0 and y >= 0 and x < C and y < C then
						local lc = x * C + y
						if byte(c.kind, lc + 1) >= KINDS then
							consider(lc, dx, dy)
						end
						local first, count = floorsOf(c, lc)
						for f = first or 0, (first or 0) + count - 1 do
							consider(f, dx, dy)
						end
					end
				end
			end
		end
		table.sort(cands, function(a, b)
			if a[2] ~= b[2] then
				return a[2] < b[2]
			end
			return a[3] < b[3]
		end)
		local tries = 0
		for _, c in ipairs(cands) do
			if tries >= RETRIES then
				return nil
			end
			if not skip(c[1]) then
				tries = tries + 1
				endpoint(st, swim, mult, tree, k, c[1], back)
				if connected() then
					return c[1]
				end
				if pockets then
					failed()
				end
			end
		end
	end
	if want and back then
		local found = nearest()
		if found then
			return found
		end
		endpoint(st, swim, mult, tree, k, start, back)
	end
	local at, ok = rings()
	if ok or not want or back then
		return at
	end
	-- (the tree holds the last ring try's search: the start's own is searched again for `reached`)
	endpoint(st, swim, mult, tree, k, start, back)
	local found = nearest()
	if found then
		return found
	end
	-- (none: as the rings left it, its tree searched again)
	endpoint(st, swim, mult, tree, k, at, back)
	return at
end

-- Both APIs connect endpoints with the same local search. Connections are outward at both ends, as in the
-- baked undirected graph; the same-cluster direct edge retains the grid's entering-water direction.
-- -> entrance costs and their yards, by entrance id.
local function connections(st, tree, k)
	local edges, yards = {}, {}
	for _, id in ipairs(nodesOf(st, k)) do
		local e = entrance(st, id)
		if e and reached(tree, e) then
			edges[id], yards[id] = Grid.costAt(tree, e), yardsAt(st, tree, e)
		end
	end
	return edges, yards
end

local function pointNode(st, point)
	local k, node = locate(st, point.x, point.y)
	if not k then
		return nil, nil, "outside"
	end
	node = snap(st, k, node, point.x, point.y, point.z)
	return k, node, not node and "offmesh" or nil
end

-- One dry node is not an edge between floors. This envelope is deliberately
-- looser than the native walking slope and step; ordinary sub-cell ramps pass.
function Grid.verticalGap(a, b)
	if not a.z or not b.z then return false end
	local dz = abs(a.z - b.z) - .8
	return dz > 0 and dz * dz > 1.44 * ((a.x - b.x)^2 + (a.y - b.y)^2)
end
-- A short dry graph edge entirely on one deck is not a way up to that deck.
-- Keep longer walks around via stairs, wet surfaces and explicit lift hops.
function Grid.missedDeck(st, k, a, b, from, to, yards)
	if not yards or yards > st.cs * 1.5 or not (a and b) then return false end
	local g = grid(st, k)
	if VAL[byte(g.kind, a + 1)] == 2 or VAL[byte(g.kind, b + 1)] == 2 then return false end
	if a == b then return true end
	local az, bz = zOf(g, a), zOf(g, b)
	return abs(az - bz) <= 1 and (abs(az - from.z) > 2 or abs(bz - to.z) > 2)
end
function Grid.settledAtStart(st, k, node, goals, from, to)
	local goal = goals and goals[1]
	if not goal or goal.node ~= node or goal.asked == node then return false end
	local z = zOf(grid(st, k), node)
	return abs(z - from.z) < .6 and abs(z - to.z) > ARRIVE
end

-- Fixed places recur in both batches and in later journeys. Keep their small entrance-cost vectors and only the
-- last ENDTREES grid trees (an older entry's tree goes to the pool for the next connection: whoever kept the entry
-- finds its tree gone and searches again); cap the cache so moving start positions cannot grow it for the entire play
-- session. A connection is priced for one profile and style on a map with classes (mult.tag), for every one on a map
-- without. -> the entry's node, edges, tree and yards, and the entry ({ node, edges, yards, tree }).
-- st.endTrees keeps at most ENDTREES trees and TREE_NODES nodes between them (a tree spans its cluster: a city's on
-- Leffe's maps holds up to 40,000 nodes, 2-3 MB a tree).
local ENDTREES, TREE_NODES = 4, 65536
-- Each Find stamps the entries it connects (pin): the trees of the walk under way are never the ones given up (a start
-- without a height connects each of its surfaces: Ironforge's floors, whose trees spare a same-cluster walk its A*), so
-- st.endTrees may hold more than ENDTREES while one runs. A batch (FindMany) pins its source's only: of its targets
-- it keeps the costs.
local runStamp, pin = 0, nil
-- want: the height the point was asked at (settle's), when it has one. entry.asked is the node asked for, entry.node
-- the one settle kept (another when no walk leaves the asked one's surface).
-- rescue (a point of runAny's rescue, with want): when no walk leaves the node the plain way, the node settled with
-- `pockets` instead, kept apart (its key's ":r", entry.rescued): every other ask reads the plain entry as before.
-- Path.rescues counts the rescue entries that connect (tests).
Path.rescues = 0
local function connect(st, swim, mult, k, node, back, want, rescue)
	nodesOf(st, k)
	local key = k .. ":" .. node .. ":" .. swim .. ":" .. (mult and mult.tag or "") .. (back and ":b" or "")
	local function build(pockets)
		local tree = Tree()
		local asked = node
		local kept
		if mult and mult.check then
			-- A disconnected safe pocket is not a ledge: do not teleport to
			-- the other side of a hazard in search of an entrance.
			kept = node
			endpoint(st, swim, mult, tree, k, node, back)
		else
			kept = settle(st, swim, mult, tree, k, node, back, want, pockets)
		end
		local edges, yards = connections(st, tree, k)
		local entry = { node = kept, edges = edges, yards = yards, tree = tree, back = back, asked = asked,
			rescued = pockets or nil }
		-- A handful of local trees removes repeated endpoint searches without retaining a continent's grids.
		st.endTrees = st.endTrees or {}
		st.endTrees[#st.endTrees + 1] = entry
		entry.stamp, entry.size = pin, grid(st, k).T
		st.endNodes = (st.endNodes or 0) + entry.size
		while #st.endTrees > ENDTREES or st.endNodes > TREE_NODES do
			local gone
			for i, old in ipairs(st.endTrees) do
				if old.stamp ~= runStamp then
					gone = table.remove(st.endTrees, i)
					break
				end
			end
			if not gone then
				break
			end
			st.endNodes = st.endNodes - gone.size
			if gone.tree then
				Release(gone.tree)
				gone.tree = nil
			end
		end
		if st.endCount >= (Path.endsMax or 256) then
			st.ends, st.endCount = {}, 0
		end
		return entry
	end
	local entry = st.ends[key]
	if not entry then
		entry = build(false)
		st.ends[key], st.endCount = entry, st.endCount + 1
	end
	entry.stamp = pin
	if rescue and want and next(entry.edges) == nil then
		key = key .. ":r"
		entry = st.ends[key]
		if not entry then
			entry = build(true)
			st.ends[key], st.endCount = entry, st.endCount + 1
			if next(entry.edges) ~= nil then
				Path.rescues = Path.rescues + 1
			end
		end
		entry.stamp = pin
	end
	return entry.node, entry.edges, entry.tree, entry.yards, entry
end

-- The endpoint tree a start surface already has from an earlier Find (connect's), when it ran dry from that very node
-- (not settled elsewhere, not given back to the pool): every node the start can reach is in it, so a goal it never
-- reached is out of reach. nil otherwise. Reading it searches nothing.
local function keptDry(st, swim, mult, k, node)
	local entry = st.ends and st.ends[k .. ":" .. node .. ":" .. swim .. ":" .. (mult and mult.tag or "")]
	local tree = entry and entry.node == node and entry.tree
	if tree and tree.k == k and tree.whole == tree.gen then
		return tree
	end
end

-- A point without a height (a map click, or the player while Polestar's walking floor is unknown: UnitPosition's
-- height is a placeholder 0, so Nav/Walk.lua usually sends the floor it follows under the player, Path.SurfacesAt)
-- could stand on any surface at its spot, so it starts from each one within a cell of it at a distinct height and the
-- search keeps the cheapest: a street beside or over a canal is not walked from the canal bed, but a rock top or roof
-- over the player may be walked from (#234). `floors` (the point's: a list of heights, Nav/Walk.lua's candidate floors
-- while the player's own is unknown indoors) keeps to the surfaces within ZTOL of one of them, all of them when none
-- is: the Undercity's canals and streets, never its roofs or the Ruins above. In the point's own cell, indoor ground
-- (indoor or indoor city) up to ZTOL over a surface that is not takes that surface's place: it is the ground the
-- models were built over, buried under a city's streets (Stormwind's Dwarven District: 2 yd under the street, and
-- joined to the world only far away). A start there hid the street, and the walk to Westfall went 19,225 yd for a
-- 3,465-yd walk (#1890). Returns each surface's connection, the entrance costs merged by minimum, per entrance the
-- surface it came from, and the merged costs' yards.
-- The surfaces a point starts from (connectPoint, and run's walk inside one cluster).
local function surfaces(st, k, node, h, floors)
	local nodes = { node }
	if not h then
		local cl = grid(st, k)
		assert(cl)
		local C, kind = st.C, cl.kind
		local function onFloor(n)
			for _, f in ipairs(floors) do
				if abs(zOf(cl, n) - f) <= ZTOL then
					return true
				end
			end
			return false
		end
		if type(floors) == "table" and #floors > 0 then
			if not onFloor(node) then
				nodes = {}
			end
		else
			floors = nil
		end
		local cell = cellOf(st, k, node)
		local lx, ly = floor(cell / C), cell % C
		local function consider(n, r)
			-- A neighbour's water is where the point is not: it would be standing in it.
			if r > 0 and VAL[byte(kind, n + 1)] == 2 then
				return
			end
			if floors and not onFloor(n) then
				return
			end
			local z, b, under = zOf(cl, n), CLS[byte(kind, n + 1)] % 8, nil
			for i, m in ipairs(nodes) do
				local dz = z - zOf(cl, m)
				if abs(dz) <= ZTOL then
					local bm = CLS[byte(kind, m + 1)] % 8
					if r > 0 or dz < 0 or (b ~= INDOOR and b ~= CITY) or bm == INDOOR or bm == CITY then
						return
					end
					under = under or i
				end
			end
			nodes[under or #nodes + 1] = n
		end
		for r = 0, 1 do
			for dx = -r, r do
				for dy = -r, r do
					local x, y = lx + dx, ly + dy
					if (dx == r or dx == -r or dy == r or dy == -r) and x >= 0 and y >= 0 and x < C and y < C then
						local c = x * C + y
						if byte(kind, c + 1) >= KINDS then
							consider(c, r)
						end
						local n, count = floorsOf(cl, c)
						for f = n or 0, (n or 0) + count - 1 do
							consider(f, r)
						end
					end
				end
			end
		end
		if #nodes == 0 then
			nodes[1] = node
		end
	end
	return nodes
end

local function connectPoint(st, swim, mult, k, node, h, floors, back, rescue)
	local ends, merged, via, yards = {}, {}, {}, {}
	for _, start in ipairs(surfaces(st, k, node, h, floors)) do
		local allowed = true
		if mult and mult.check then
			local p = back and mult.to or mult.from
			local x, y = Safe.xy(st, k, cellOf(st, k, start))
			allowed = not mult.check(p.x, p.y, x, y)
		end
		if allowed then
			-- Keep the entry: a sliced search may give its tree back to the pool.
			local _, edges, _, edgeYards, entry = connect(st, swim, mult, k, start, back, h, rescue)
			ends[#ends + 1] = entry
			for id, cost in pairs(edges) do
				if not merged[id] or cost < merged[id] then
					merged[id], via[id], yards[id] = cost, entry, edgeYards[id]
				end
			end
		end
	end
	return ends, merged, via, yards
end

-- The start's connection within a cost radius (run's walk across clusters): each surface's Dijkstra to its cluster's
-- entrances stops once past R, so it holds the exact cost of every entrance within R and nothing beyond. Its trees are
-- run's own, reused (never cached: a moving start never comes again). -> as connectPoint, then whether every tree is
-- complete (it met every entrance or ran dry: the full connection) and whether any entrance was met at all.
-- The trees are the job's own (trees.B, in its scratch): searches are sliced and take turns, and one job's tree must
-- never be rewritten under another's paused search or traced by its refinement.
-- A surface whose tree is complete and met no entrance is a rock top or ledge: like connectPoint, it goes through
-- connect, which moves it to a node that reaches one (settle, toward `h`, the start's height when it has one), and
-- that connection joins the starts.
local function connectWithin(st, swim, mult, k, nodes, R, h, rescue)
	local targets, left = {}, 0
	for _, id in ipairs(nodesOf(st, k)) do
		local e = entrance(st, id)
		if e and not targets[e] then
			targets[e], left = true, left + 1
		end
	end
	local ends, merged, via, yards = {}, {}, {}, {}
	local complete, met = true, false
	for i, n in ipairs(nodes) do
		local tree = trees.B[i] or Tree()
		trees.B[i] = tree
		local whole = search(st, k, swim, mult, n, tree, nil, targets, left, nil, R)
		local edges, edgeYards = connections(st, tree, k)
		local entry
		if whole and next(edges) == nil then
			local _, _, _, _, settled = connect(st, swim, mult, k, n, nil, h, rescue)
			entry, edges, edgeYards = settled, settled.edges, settled.yards
		else
			entry = { node = n, edges = edges, yards = edgeYards, tree = tree }
			if not whole then
				complete = false
			end
		end
		ends[#ends + 1] = entry
		for id, c in pairs(edges) do
			met = true
			if not merged[id] or c < merged[id] then
				merged[id], via[id], yards[id] = c, entry, edgeYards[id]
			end
		end
	end
	return ends, merged, via, yards, complete, met
end

-- Lifts: the walking grid has no links between a lift's landings (the car moves, the ground does not), so the
-- searches join them here. The pack's lift chokepoints (PolestarNavChokepoints[map], Nav/Chokepoints.lua: kind
-- "lift", liftEnd "bottom" with pair, the index of its "top" landing, each with its height) give each lift's
-- landings; a ride between a bottom landing and its top, either way, costs its seconds at run speed (the landing's
-- `ride`: the ride and the average wait for the car, from the client's lift animation: the Undercity's 7.6 s, Thunder
-- Bluff's and the Great Lift's 20.4 s; LIFT_COST, 25 s, for a landing without one) and adds the yards between them.
-- A landing is an abstract vertex (LIFT_ID + its index) joined to its
-- cluster's entrances by a grid Dijkstra from it (kept per profile, style and water mode: a few numbers a landing,
-- LIFT_ENDS at most), and to a start or goal in its cluster by their own trees or one A* inside the cluster. A
-- drawn line keeps both landings: straightening never jumps floors (PathGrid's sight), so Nav/Walk.lua finds the
-- ride on it.
local LIFT_SPEED = 7 -- yd/s: a ride's seconds priced as yards at run speed
local LIFT_COST = 25 * LIFT_SPEED -- a ride without its seconds
local LIFT_ID = 1073741824 -- landing i's vertex is LIFT_ID + i, above every entrance id
local LIFT_ENDS = 64
-- The longest walk a search looks for: DETOUR times the straight line plus DETOUR_YD yards (run's abstract A*).
local DETOUR, DETOUR_YD = 8, 2000
-- The straight yards up to which a walk across clusters bounds the start's tree (run): the arrow's re-asks round an
-- objective, where the win is; a far walk's cost is usually well over the first bound, so it takes the full tree.
local BOUNDED_YARDS = 400

local liftJoined -- (below, with landingEnds: whether the rides join a start's components to a goal's)

-- The map's lift landings, read once a map state: { [i] = { x, y, z, k, partners = { j, ... }, ride = { [j] = cost } },
-- byCluster = { [k] = { i, ... } }, joined = liftJoined }: ride[j] the ride's cost to partner j (its seconds at run
-- speed, else LIFT_COST). (`joined` rides on the table: run holds Lua 5.1's 60 upvalues.)
local function liftsOf(st, map)
	local L = st.lifts
	if L then
		return L
	end
	L = { byCluster = {}, joined = liftJoined }
	local list = type(PolestarNavChokepoints) == "table" and PolestarNavChokepoints[map]
	if type(list) == "table" then
		local index = {}
		local function landing(e)
			if index[e] then
				return index[e]
			end
			if type(e.wx) ~= "number" or type(e.wy) ~= "number" or type(e.z) ~= "number" then
				return nil
			end
			local k = locate(st, e.wx, e.wy)
			if not k then
				return nil
			end
			local i = #L + 1
			L[i], index[e] = { x = e.wx, y = e.wy, z = e.z, k = k, entry = e, partners = {}, ride = {} }, i
			local here = L.byCluster[k] or {}
			L.byCluster[k], here[#here + 1] = here, i
			return i
		end
		for _, e in ipairs(list) do
			local top = type(e) == "table" and e.kind == "lift" and e.liftEnd == "bottom" and type(e.pair) == "number"
				and list[e.pair]
			if type(top) == "table" and top.kind == "lift" and top.liftEnd == "top" then
				local a, b = landing(e), landing(top)
				if a and b then
					local seconds = type(e.ride) == "number" and e.ride > 0 and e.ride or type(top.ride) == "number" and top.ride > 0 and top.ride
					local cost = seconds and seconds * LIFT_SPEED or LIFT_COST
					local pa, pb = L[a].partners, L[b].partners
					pa[#pa + 1], pb[#pb + 1] = b, a
					L[a].ride[b], L[b].ride[a] = cost, cost
				end
			end
		end
	end
	st.lifts = L
	return L
end

-- Landing i's node and its costs (and yards) to its cluster's entrances for this search's water mode and weights;
-- false when the landing stands on no walkable surface.
local function landingEnds(st, swim, mult, lifts, i)
	local key = i .. ":" .. swim .. ":" .. (mult and mult.tag or "")
	st.liftEnds = st.liftEnds or { n = 0 }
	local entry = st.liftEnds[key]
	if entry == nil then
		local l = lifts[i]
		local k, lc = locate(st, l.x, l.y)
		local node = k and snap(st, k, lc, l.x, l.y, l.z)
		entry = false
		if node and mult and mult.check then
			local x, y = Safe.xy(st, k, cellOf(st, k, node))
			if mult.check(l.x, l.y, x, y) then node = nil end
		end
		if node then
			nodesOf(st, k)
			-- Called mid-search: the grid search gets its own heap, and runs on trees.R (every other use searches it and
			-- reads it at once; only the costs to the entrances are kept).
			local keys, values, size = hk, hv, hn
			hk, hv, hn = {}, {}, 0
			endpoint(st, swim, mult, trees.R, k, node)
			local edges, yards = connections(st, trees.R, k)
			hk, hv, hn = keys, values, size
			entry = { node = node, edges = edges, yards = yards }
		end
		if st.liftEnds.n >= LIFT_ENDS then
			st.liftEnds = { n = 0 }
		end
		st.liftEnds[key], st.liftEnds.n = entry, st.liftEnds.n + 1
	end
	return entry
end

-- Whether the lifts can join a start whose entrances lie in components `comps` ({ [component] = true }) to a goal
-- with entrances `target` ({ [entrance id] = cost }), for a search in clusters sk and gk. Components join only
-- through the grid but for a ride: a landing's own entrances (landingEnds, this search's water mode and weights)
-- give its components, and a ride joins its two landings'. True when a ride chain leads from comps to a goal
-- component, and whenever a landing stands in the start's or the goal's own cluster (a start or goal may reach it
-- inside the cluster, through no entrance). Without this, any map with a lift searched a goal no walk reaches (Telf
-- Joolam's shrine above the Durotar bank, #3605) until the search's detour bound: 250,000 to 500,000 expansions,
-- half a minute of slices, for every walk asked there.
function liftJoined(st, swim, mult, lifts, comps, target, sk, gk)
	if lifts.byCluster[sk] or lifts.byCluster[gk] then return true end
	local of, reached = {}, {}
	for c in pairs(comps) do reached[c] = true end
	for i = 1, #lifts do
		local set = {}
		local land = landingEnds(st, swim, mult, lifts, i)
		for id in pairs(land and land.edges or {}) do
			nodesOf(st, floor(id / 4096))
			local _, _, component = metadata(st, id)
			set[component] = true
		end
		of[i] = set
	end
	local grew = true
	while grew do
		grew = false
		for i = 1, #lifts do
			local on = false
			for c in pairs(of[i]) do
				if reached[c] then on = true break end
			end
			if on then
				for _, j in ipairs(lifts[i].partners) do
					for c in pairs(of[j]) do
						if not reached[c] then reached[c], grew = true, true end
					end
				end
			end
		end
	end
	for id in pairs(target) do
		nodesOf(st, floor(id / 4096))
		local _, _, component = metadata(st, id)
		if reached[component] then return true end
	end
	return false
end

-- The grid cost (and yards) between an endpoint (its connection: node, tree) and node `to` in cluster k: the
-- endpoint's own tree when it settled `to`, else an A* from the endpoint inside the cluster (trees.R). nil when the
-- cluster joins them nowhere.
local function within(st, swim, mult, k, from, to)
	local tree = from.tree
	if tree and tree.k == k and reached(tree, to) then
		return Grid.costAt(tree, to), yardsAt(st, tree, to)
	end
	if from.node == to then
		return 0, 0
	end
	local keys, values, size = hk, hv, hn
	hk, hv, hn = {}, {}, 0
	local cost, yards
	if search(st, k, swim, mult, from.node, trees.R, to) then
		cost, yards = Grid.costAt(trees.R, to), yardsAt(st, trees.R, to)
	end
	hk, hv, hn = keys, values, size
	return cost, yards
end

-- Where the segment from a to b first enters one of disks ({ x, y, r } each), as a fraction of the way along it;
-- nil when it enters none.
local function enters(a, b, disks)
	local dx, dy = b.x - a.x, b.y - a.y
	local A = dx * dx + dy * dy
	local first
	for _, d in ipairs(disks) do
		local fx, fy = a.x - d[1], a.y - d[2]
		local c = fx * fx + fy * fy - d[3] * d[3]
		local t
		if c <= 0 then
			t = 0
		elseif A > 0 then
			local B = 2 * (fx * dx + fy * dy)
			local disc = B * B - 4 * A * c
			if disc >= 0 then
				t = (-B - sqrt(disc)) / (2 * A)
				if t < 0 or t > 1 then
					t = nil
				end
			end
		end
		if t and (not first or t < first) then
			first = t
		end
	end
	return first
end

-- The hubs (metadata D.hubs) hostile to profile that the drawn line enters: a point of it inside one of the hub's
-- disks. -> { { id, name, areaId }, ... }, each hub once, in path order; {} without hubs or a profile.
local function hubsOn(hubs, points, profile)
	local out = {}
	profile = Costs.Profile(profile)
	if not hubs or not profile then
		return out
	end
	local listed = {}
	for i = 2, #points do
		local hits
		for order, hub in ipairs(hubs) do
			if not listed[hub] and hub.side ~= profile and Costs.Profile(hub.side) then
				local t = points[i].rideFrom ~= points[i - 1] and enters(points[i - 1], points[i], hub.disks or {})
				if t then
					hits = hits or {}
					hits[#hits + 1] = { t = t, order = order, hub = hub }
				end
			end
		end
		if hits then
			table.sort(hits, function(p, q)
				return p.t < q.t or (p.t == q.t and p.order < q.order)
			end)
			for _, hit in ipairs(hits) do
				listed[hit.hub] = true
				out[#out + 1] = { id = hit.hub.id, name = hit.hub.name, areaId = hit.hub.areaId }
			end
		end
	end
	return out
end
-- The hostile hubs the walk goes round (display only; nothing here prices or changes the path): the ones the straight
-- line between its ends would enter and the drawn line does not (it is not in entered, hubsOn's list), and that the
-- drawn line passes within AVOID_NEAR yards of, so a bend the ground forced elsewhere is not called a detour.
-- -> { { id, name, areaId, x, y }, ... } in the order the straight line meets them (x, y: the town's place); {} without
-- hubs, a profile or a line.
local AVOID_NEAR = 100

local function distanceToSegment(a, b, cx, cy)
	local dx, dy = b.x - a.x, b.y - a.y
	local A = dx * dx + dy * dy
	local t = A > 0 and ((cx - a.x) * dx + (cy - a.y) * dy) / A or 0
	t = t < 0 and 0 or (t > 1 and 1 or t)
	local px, py = a.x + dx * t - cx, a.y + dy * t - cy
	return sqrt(px * px + py * py)
end

local function passesNear(points, disks)
	for _, d in ipairs(disks) do
		for i = 2, #points do
			if points[i].rideFrom ~= points[i - 1] and distanceToSegment(points[i - 1], points[i], d[1], d[2]) <= d[3] + AVOID_NEAR then
				return true
			end
		end
	end
	return false
end

local function hubsAvoided(hubs, points, profile, entered)
	local out = {}
	profile = Costs.Profile(profile)
	if not hubs or not profile or #points < 2 then
		return out
	end
	local inside = {}
	for _, h in ipairs(entered) do
		inside[h.id] = true
	end
	local hits = {}
	for order, hub in ipairs(hubs) do
		if hub.side ~= profile and Costs.Profile(hub.side) and not inside[hub.id] then
			local disks = hub.disks or {}
			local t = enters(points[1], points[#points], disks)
			if t and passesNear(points, disks) then
				hits[#hits + 1] = { t = t, order = order, hub = hub }
			end
		end
	end
	table.sort(hits, function(p, q)
		return p.t < q.t or (p.t == q.t and p.order < q.order)
	end)
	for _, hit in ipairs(hits) do
		local sx, sy, n = 0, 0, 0
		for _, d in ipairs(hit.hub.disks or {}) do
			sx, sy, n = sx + d[1], sy + d[2], n + 1
		end
		-- x, y: the town's place (the mean of its disks' centres), for the walk piece that passes it
		out[#out + 1] = { id = hit.hub.id, name = hit.hub.name, areaId = hit.hub.areaId, x = n > 0 and sx / n or nil, y = n > 0 and sy / n or nil }
	end
	return out
end

local function recordHubs(job, hubs, points, profile)
	if job.skipReport then return end
	job.hubs = hubsOn(hubs, points, profile)
	job.avoided = hubsAvoided(hubs, points, profile, job.hubs)
end

-- A failed search for an exit may leave the endpoint on the last unrelated floor it tried.
-- Check the actual two floors before discarding a walk wholly inside the cluster (Stromgarde).
local function nearNode(st, k, p, node)
	local lc = cellOf(st, k, node)
	local x = st.x0 + (floor(k / st.ny) * st.C + floor(lc / st.C) + 0.5) * st.cs
	local y = st.y0 + (k % st.ny * st.C + lc % st.C + 0.5) * st.cs
	return (x - p.x)^2 + (y - p.y)^2 + (zOf(grid(st, k), node) - p.z)^2 <= ARRIVE^2
end
local function pocketWalk(st, k, swim, mult, from, to, a, b, reverse)
	if not from.z or not to.z or not ((a.node ~= a.asked and not next(a.edges)) or (b.node ~= b.asked and not next(b.edges))) then
		return nil
	end
	if not nearNode(st, k, from, a.asked) or not nearNode(st, k, to, b.asked) then return nil end
	local first, last = a.asked, b.asked
	if reverse then first, last = last, first end
	local tree = trees.R
	if search(st, k, swim, mult, first, tree, last) then
		return Grid.costAt(tree, last), yardsAt(st, tree, last)
	end
end

-- Do not draw a last segment through an unmapped floor. Even an unmoved goal node can be a street above a room.
local function drawnEnd(map, st, P, goals, to, job, x0, y0, cs, previous)
	local endpoint = { map = map, x = to.x, y = to.y, z = to.z }
	job.reached, job.endFloor = nil, nil
	job.endMiss = nil
	if to.z then
		local j = #P.x
		local node = P.n[j]
		local z = zOf(grid(st, P.k[j]), node)
		job.endFloor = z
		local dx = x0 + (P.x[j] + .5) * cs - to.x
		local dy = y0 + (P.y[j] + .5) * cs - to.y
		job.endMiss = dx * dx + dy * dy + (z - to.z)^2 > 25
		local moved = goals[1] and goals[1].node == node and goals[1].asked ~= node
		if moved or abs(z - to.z) > (to.reach and ARRIVE or ZTOL) then
			local x, y = x0 + (P.x[j] + 0.5) * cs, y0 + (P.y[j] + 0.5) * cs
			if (x - to.x)^2 + (y - to.y)^2 + (z - to.z)^2 > ARRIVE * ARRIVE then
				-- A sideways substitution on roughly the right level proves neither
				-- the requested point nor a new chord to the substitute. End before
				-- that chord unless a collision-checked tail independently joins it.
				local sameColumn = floor((to.x - x0) / cs) == P.x[j] and floor((to.y - y0) / cs) == P.y[j]
				if not sameColumn and abs(z - to.z) <= (to.reach and ARRIVE or ZTOL) and not (moved and goals[1].rescued) then return nil end
				endpoint.x, endpoint.y, endpoint.z = x, y, z
				if not ns.noNewTailVolume(map, previous, to, endpoint) then return nil end
				job.reached = endpoint
			end
		end
	end
	return endpoint
end

-- Packed cell centres can see across the tip of a wall on a coarse grid. Where the
-- map supplies a collision-checked corridor, follow it only between those exact XYZs.
-- Index by the first point's whole-yard X; the six-coordinate check distinguishes floors.
local function detailLine(index, points)
	local out
	for i = 2, #points do
		local a, b = points[i - 1], points[i]
		local bucket = index[floor(a.x)]
		if bucket and not b.rideFrom and a.z and b.z then
			for _, lane in ipairs(bucket) do
				if abs(a.x - lane[1]) <= 0.001 and abs(a.y - lane[2]) <= 0.001 and abs(a.z - lane[3]) <= 0.001
					and abs(b.x - lane[4]) <= 0.001 and abs(b.y - lane[5]) <= 0.001 and abs(b.z - lane[6]) <= 0.001 then
					if not out then
						out = { wet = points.wet }
						for j = 1, i - 1 do out[j] = points[j] end
					end
					a.detail, b.detail = true, true
					for j = 7, #lane, 3 do
						out[#out + 1] = { map = a.map, x = lane[j], y = lane[j + 1], z = lane[j + 2], detail = true }
					end
					break
				end
			end
		end
		if out then out[#out + 1] = b end
	end
	return out
end

local function finishDraw(st, P, keep, points, drawnYards, job, profile)
	local line = Grid.groundLine(st, P, keep, points)
	if st.D.detailLanes and points.wet == 0 then
		local detailed = detailLine(st.D.detailLanes, line)
		if detailed then
			line, points, drawnYards = detailed, detailed, 0
			for i = 2, #line do
				local a, b = line[i - 1], line[i]
				drawnYards = drawnYards + sqrt((b.x - a.x)^2 + (b.y - a.y)^2)
			end
		end
	end
	-- Preserve the chosen route and its XY length. On long dry segments with a
	-- supported height profile, follow the actual hillside rather than an air chord.
	if st.D.localWalk and points.wet == 0 then
		local refined
		for i = 2, #line do
			local a, b = line[i - 1], line[i]
			if a.z and b.z and not b.rideFrom and not a.detail and not b.detail then
				local v = ns.groundProfile(st.D.localWalk, a, b)
				if v then
					if not refined then
						refined = { wet = line.wet }
						for j = 1, i - 1 do refined[j] = line[j] end
					end
					for j = 2, #v - 1 do refined[#refined + 1] = v[j] end
				end
			end
			if refined then refined[#refined + 1] = b end
			tick()
		end
		if refined then line = refined end
	end
	job.yards = drawnYards
	recordHubs(job, st.D.hubs, job.check and line or points, job.report or profile)
	return line
end

-- Sliced A* and refinement share scratch trees; splitting adds hot-path calls and upvalues
local function run(map, from, to, waterWalking, costOnly, profile, job, style, danger)
	runStamp = runStamp + 1
	pin = runStamp
	local st = State(map)
	if not st then
		return nil, "nodata"
	end
	-- Walking on water is running, so the search weights water by 1 (and a format 1 map reads each edge's second
	-- cost).
	local swim = waterWalking and 1 or st.swim
	local ci, yi = edgeFields(st, waterWalking, profile)
	local mult, hmin = Safe.weights(st, profile, style, danger, job, from, to)
	local edged = edgeDanger(st, mult)
	local sk, sc = locate(st, from.x, from.y)
	local gk, gc = locate(st, to.x, to.y)
	if not sk or not gk then
		return nil, "outside"
	end
	sc, gc = snap(st, sk, sc, from.x, from.y, from.z), snap(st, gk, gc, to.x, to.y, to.z)
	if not sc or not gc then
		return nil, "offmesh"
	end
	local C = st.C

	local S, G = trees.S, trees.G
	local hops, cost, yards, directFrom, directTo
	local x0, y0, cs = st.x0, st.y0, st.cs
	local lifts = liftsOf(st, map)
	-- Per landing vertex on the way: the start node walked to it, the goal node walked to from it.
	local liftStart, liftGoal
	local starts, source, sourceVia, sourceYards, goals, target, targetVia, targetYards, key, cached
	-- A walk inside one cluster without the start's endpoint tree. Each end's tree is a Dijkstra over the whole
	-- cluster to its entrances; the goal's is kept (connect), but a moving start never reuses its own, so every time
	-- the arrow asked again from a few steps on it flooded the cluster again: 15,000 to 60,000 expansions for a quest
	-- objective 14 yards away. Any walk that leaves the cluster comes back to the goal through an entrance e, so it
	-- costs at least the straight yards from a start surface's own cell to e at the cheapest yard (the abstract
	-- search's own lower bound) plus the goal tree's exact cost from e. A direct walk no dearer than the least of those
	-- over every entrance costs what the full search finds (a tie may draw another line), without the start's tree.
	-- Its A* stops once past that bound, so a surface that cannot reach the goal costs little. No lift in the cluster
	-- (a ride enters through no entrance); otherwise, or when no direct walk is under the bound, the full search.
	if not job.filtered and Path.direct ~= false and sk == gk and #(lifts.byCluster[sk] or {}) == 0 then
		local lower = max(0, 1 - 0.5 / cs) * hmin
		goals, target, targetVia, targetYards = connectPoint(st, swim, mult, gk, gc, to.z, to.floors, true, to.rescue)
		-- (from each start surface's own cell centre, where its search begins: snap may place it cells from the point)
		local starts0 = surfaces(st, sk, sc, from.z, from.floors)
		local centres = {}
		for i, a in ipairs(starts0) do
			local cell = cellOf(st, sk, a)
			centres[i] = { x0 + (floor(sk / st.ny) * C + floor(cell / C) + 0.5) * cs, y0 + ((sk % st.ny) * C + cell % C + 0.5) * cs }
		end
		local bound = huge
		for id, c in pairs(target) do
			local k = floor(id / 4096)
			nodesOf(st, k)
			local lc = metadata(st, id)
			local ex = x0 + (floor(k / st.ny) * C + floor(lc / C) + 0.5) * cs
			local ey = y0 + ((k % st.ny) * C + lc % C + 0.5) * cs
			for _, p in ipairs(centres) do
				local d = sqrt((ex - p[1]) ^ 2 + (ey - p[2]) ^ 2)
				if d * lower + c < bound then
					bound = d * lower + c
				end
			end
		end
		if bound < huge and not (from.z and to.z and goals[1].node ~= gc) then
			-- Every surface the start stands on must reach the goal so: one that does not (a rock top the grid cannot
			-- leave) is moved by its endpoint tree (settle), which only the full search does.
			local all = true
			for _, a in ipairs(starts0) do
				local reaches = false
				-- (a goal surface the start's kept endpoint tree never reached when it ran dry is out of reach: no A*
				-- for it, as in the full search; Ironforge's city floors under the mountain's ground)
				local dry = keptDry(st, swim, mult, sk, a)
				for _, b in ipairs(goals) do
					if not (dry and not reached(dry, b.node))
						and search(st, sk, swim, mult, a, S, b.node, nil, nil, nil, bound) and Grid.costAt(S, b.node) <= bound then
						reaches = true
						if not cost or Grid.costAt(S, b.node) < cost then
							cost, yards, directFrom, directTo = Grid.costAt(S, b.node), yardsAt(st, S, b.node), a, b.node
						end
					end
				end
				if not reaches then
					all = false
					break
				end
			end
			if not all then
				cost, yards, directFrom, directTo = nil, nil, nil, nil
			end
			if cost then
				hops = { GOAL, START }
				liftStart, liftGoal = {}, {}
			end
		end
	end
	local R, complete, full
	local tries = 0
	if not hops then
		goals, target, targetVia, targetYards = connectPoint(st, swim, mult, gk, gc, to.z, to.floors, true, to.rescue)
		key = table.concat({ sk, sc, gk, gc, swim, from.z and 1 or 0, to.z and 1 or 0, mult and mult.tag or "",
			type(from.floors) == "table" and table.concat(from.floors, ",") or "", type(to.floors) == "table" and table.concat(to.floors, ",") or "" }, ":")
		if from.rescue or to.rescue then
			-- (a rescue's walk is never another ask's)
			key = key .. ":r" .. (from.rescue and "s" or "") .. (to.rescue and "g" or "")
		end
		st.paths = st.paths or {}
		cached = not job.check and st.paths[key]
		local straight = sqrt((to.x - from.x) ^ 2 + (to.y - from.y) ^ 2)
		if not job.filtered and not cached and Path.direct ~= false and sk ~= gk and straight <= BOUNDED_YARDS
			and #(lifts.byCluster[sk] or {}) == 0 then
			R = 1.25 * straight + 25
		else
			starts, source, sourceVia, sourceYards = connectPoint(st, swim, mult, sk, sc, from.z, from.floors, nil, from.rescue)
			if not starts[1] or not goals[1] then return nil, "unreachable" end
			if sk == gk and not lifts.byCluster[sk] then
				cost, yards = pocketWalk(st, sk, swim, mult, from, to, starts[1], goals[1])
				if cost then
					hops, directFrom, directTo = { GOAL, START }, sc, gc
				end
			end
		end
	end
	-- A short walk across clusters (the arrow's re-asks round an objective: BOUNDED_YARDS): the start's tree only as
	-- far as it needs to go. The start's Dijkstra to its entrances stops past a cost R; a walk the abstract search
	-- then finds for at most R is the cheapest there is (any other leaves the start's cluster through an entrance
	-- beyond R, so costs more). A walk dearer than R gets one more try with R that cost; none found, or a second
	-- miss, takes the full tree (a far or unreachable goal would otherwise pay a growing tree and an abstract search
	-- each time). A tree that meets every entrance or runs dry within R is the full one, so its walk stands. Not with
	-- a lift in the start's cluster (its landings are walked to from the full trees). The cost is the full search's;
	-- an equal-cost tie may draw another line.
	while true do
		local retry = false
		if full then
			full = false
			starts, source, sourceVia, sourceYards = connectPoint(st, swim, mult, sk, sc, from.z, from.floors, nil, from.rescue)
		elseif R then
			tries = tries + 1
			local met
			starts, source, sourceVia, sourceYards, complete, met =
				connectWithin(st, swim, mult, sk, surfaces(st, sk, sc, from.z, from.floors), R, from.z, from.rescue)
			if complete and not met then
				-- (a start no entrance joins: the full connection moves it, as before)
				R = nil
				starts, source, sourceVia, sourceYards = connectPoint(st, swim, mult, sk, sc, from.z, from.floors, nil, from.rescue)
			end
		end
		if hops then
			-- (the direct walk above)
		elseif cached then
			hops, cost, yards, directFrom, directTo = cached.hops, cached.cost, cached.yards, cached.directFrom, cached.directTo
			liftStart, liftGoal = cached.liftStart, cached.liftGoal
		else
			local direct, directYards
			if sk == gk then
				-- A start's endpoint tree is a Dijkstra over its cluster: a goal it never reached when it ran dry is out of
				-- reach (a floor or rock top the start's floor never joins), and an A* for it would expand everything the
				-- start reaches (Ironforge's city under the mountain: most of a cold walk). A goal it can reach keeps its A*
				-- (the same points and costs as before).
				for _, a in ipairs(starts) do
					local tree = a.tree
					local dry = tree and tree.k == sk and tree.whole == tree.gen
					for _, b in ipairs(goals) do
						if not (dry and not reached(tree, b.node)) and search(st, sk, swim, mult, a.node, S, b.node)
							and (not direct or Grid.costAt(S, b.node) < direct) then
							direct, directYards, directFrom, directTo = Grid.costAt(S, b.node), yardsAt(st, S, b.node), a.node, b.node
						end
					end
				end
			end

			local comps, shared = {}, false
			for id in pairs(source) do
				nodesOf(st, floor(id / 4096))
				local _, _, component = metadata(st, id)
				comps[component] = true
			end
			for id in pairs(target) do
				nodesOf(st, floor(id / 4096))
				local _, _, component = metadata(st, id)
				shared = shared or comps[component]
			end
			-- Components join only through the grid: a lift may join two (a mesa top and the plain below), so with lifts
			-- on the map the rides decide (liftJoined). An end whose cluster joins it to no entrance and holds no
			-- landing is a pocket nothing leaves or enters (Telf Joolam's shrine, #3605): the abstract search could
			-- only run to its detour bound.
			if not direct and not shared and (#lifts == 0
				or (not next(source) and not lifts.byCluster[sk]) or (not next(target) and not lifts.byCluster[gk])
				or (next(source) and next(target) and not lifts.joined(st, swim, mult, lifts, comps, target, sk, gk))) then
				if R and not complete then
					retry, R, full = true, nil, true
				else
					return nil, "unreachable"
				end
			end
			if not retry then

			-- Abstract A* from START to GOAL through the entrance graph.
			local function world(id)
				local k, lc = floor(id / 4096), metadata(st, id)
				return x0 + (floor(k / st.ny) * C + floor(lc / C) + 0.5) * cs, y0 + ((k % st.ny) * C + lc % C + 0.5) * cs
			end
			-- Rounded graph edges, snapping and, with classes, a yard cheaper than running (hmin) must not let the
			-- heuristic overstate the remaining cost. The goal's nodes are not all at its cell (gc): a point without a
			-- height starts from the surfaces within a cell of it (surfaces), and each settles up to SNAP cells on
			-- (settle), so the goal tree's cost from an entrance can be up to (SNAP + 1) diagonal cells short of the
			-- straight yards to gc's centre. Measured from gc, the heuristic overstated by up to that and the search could
			-- settle on a longer walk (#2723, reported by undersailor). The reach comes off the straight yards before the
			-- scale, as Shortest Path Forever's abstract A* does since its 1.37.1 (Routing/Path.lua, by Cillian Berragan,
			-- GPL-3.0-or-later) and as Path.LowerBound does.
			local goalCell = cellOf(st, gk, gc)
			local goalX = x0 + (floor(gk / st.ny) * C + floor(goalCell / C) + 0.5) * cs
			local goalY = y0 + (gk % st.ny * C + goalCell % C + 0.5) * cs
			local lower = max(0, 1 - 0.5 / cs) * hmin
			local reach = (SNAP + 1) * SQRT2 * cs
			local function h(id)
				local x, y
				if id > LIFT_ID then
					local l = lifts[id - LIFT_ID]
					x, y = l.x, l.y
				else
					x, y = world(id)
				end
				local dx, dy = abs(x - goalX), abs(y - goalY)
				local gap = dx > dy and dx + (SQRT2 - 1) * dy or dy + (SQRT2 - 1) * dx
				return gap > reach and (gap - reach) * lower or 0
			end
			agen = agen + 1
			local gen = agen
			hn = 0
			-- No walk is worth more than DETOUR times the straight line plus DETOUR_YD: past that the search stops
			-- (unreachable; Nav/Walk.lua asks again without the start's height). A start on a surface the maps join to the
			-- world only far away (the terrain buried under Stormwind's Trade District, reached by Leffe's maps only over
			-- the mountains: 20 km) otherwise searched most of a continent's graph for seconds.
			local detour = DETOUR * sqrt((to.x - from.x) ^ 2 + (to.y - from.y) ^ 2) + DETOUR_YD
			local function relax(v, gv, yv, parent)
				if not job.filtered and yv and yv > detour then
					return
				end
				if astamp[v] ~= gen or gv < ag[v] then
					if job.filtered and v ~= GOAL then
						local veto = job.vertices[v]
						if veto == nil then
							local x, y
							if v > LIFT_ID then
								local l = lifts[v - LIFT_ID]
								x, y = l.x, l.y
							else x, y = world(v) end
							veto = job.check(x, y, x, y) or false
							job.vertices[v] = veto
						end
						if veto then return end
					end
					ag[v], ay[v], apar[v], astamp[v] = gv, yv, parent, gen
					push(gv + (v == GOAL and 0 or h(v)), v)
				end
			end
			for id, distance in pairs(source) do
				relax(id, distance, sourceYards[id], START)
			end
			if direct then
				relax(GOAL, direct, directYards, START)
			end
			liftStart, liftGoal = {}, {}
			-- The landings in the start's cluster, walked to from the start.
			for _, i in ipairs(lifts.byCluster[sk] or {}) do
				local land = landingEnds(st, swim, mult, lifts, i)
				if land then
					for _, a in ipairs(starts) do
						local c, yd = within(st, swim, mult, sk, a, land.node)
						local v = LIFT_ID + i
						if c and (astamp[v] ~= gen or c < ag[v]) then
							relax(v, c, yd, START)
							liftStart[v] = a.node
						end
					end
				end
			end
			local found = false
			while hn > 0 do
				local u = pop()
				if aclosed[u] ~= gen then
					aclosed[u] = gen
					tick()
					-- An abstract expansion (an entrance's edges, the clusters they reach decoded, a landing's grid
					-- searches) can take far longer than a grid one: read the clock after each (#3640).
					Path.Checkpoint()
					if u == GOAL then
						found = true
						break
					end
					local gu, yu = ag[u], ay[u]
					if u > LIFT_ID then
						-- A landing: the ride to its other landing, its cluster's entrances, and the goal in its cluster.
						local i = u - LIFT_ID
						local l = lifts[i]
						for _, j in ipairs(l.partners) do
							local p = lifts[j]
							relax(LIFT_ID + j, gu + (l.ride[j] or LIFT_COST), yu + sqrt((p.x - l.x) ^ 2 + (p.y - l.y) ^ 2), u)
						end
						local land = landingEnds(st, swim, mult, lifts, i)
						if land then
							for id, c in pairs(land.edges) do
								if aclosed[id] ~= gen then
									nodesOf(st, floor(id / 4096))
									relax(id, gu + c, yu + land.yards[id], u)
								end
							end
							if l.k == gk then
								for _, b in ipairs(goals) do
									local c, yd = within(st, swim, mult, gk, b, land.node)
									if c and (astamp[GOAL] ~= gen or gu + c < ag[GOAL]) then
										relax(GOAL, gu + c, yu + yd, u)
										liftGoal[u] = b.node
									end
								end
							end
						end
					else
						if target[u] then
							relax(GOAL, gu + target[u], yu + targetYards[u], u)
						end
						local ku = floor(u / 4096)
						-- The landings in this entrance's cluster.
						for _, i in ipairs(lifts.byCluster[ku] or {}) do
							local land = landingEnds(st, swim, mult, lifts, i)
							local c = land and land.edges[u]
							if c and aclosed[LIFT_ID + i] ~= gen then
								relax(LIFT_ID + i, gu + c, yu + land.yards[u], u)
							end
						end
						nodesOf(st, ku)
						local s, pos, n, width = edges(st, u)
						for _ = 1, n do
							local v = edgeTarget(st, s, pos, ku)
							if aclosed[v] ~= gen and not (job.denied and job.denied[u] and job.denied[u][v]) then
								nodesOf(st, floor(v / 4096))
								local c = edgeValue(st, s, pos, ci)
								relax(v, gu + (edged and c * edged(u, v) or c), yu + edgeValue(st, s, pos, yi), u)
							end
							pos = pos + width
						end
					end
				end
			end
			if not found then
				if R and not complete then
					retry, R, full = true, nil, true
				else
					return nil, "unreachable"
				end
			elseif R and not complete and ag[GOAL] > R then
				-- (a walk dearer than R: another may leave through an entrance beyond R; look that far once, then
				-- the full tree)
				retry = true
				if tries < 2 then
					R = ag[GOAL]
				else
					R, full = nil, true
				end
			else
				cost, yards = ag[GOAL], ay[GOAL]
				hops = { GOAL }
				while hops[#hops] ~= START do
					hops[#hops + 1] = apar[hops[#hops]]
				end

				if not job.check then
					if (st.pathCount or 0) >= 16 then
						st.paths, st.pathCount = {}, 0
					end
					st.paths[key] = { hops = hops, cost = cost, yards = yards, directFrom = directFrom, directTo = directTo,
						liftStart = liftStart, liftGoal = liftGoal }
					st.pathCount = (st.pathCount or 0) + 1
				end
			end
			end
		end
		if not retry then
			break
		end
	end
	if #hops == 2 and directFrom ~= nil and sk == gk and Grid.verticalGap(from, to)
		and Grid.missedDeck(st, sk, directFrom, directTo, from, to, yards) then
		job.collapsed, job.endMiss, job.endFloor, job.yards = true, true, from.z, 0
		if costOnly then return nil, "unreachable" end
		-- If the player is already on a substituted goal floor, let drawnEnd
		-- retain that actual floor's cell centre, never the requested height.
		if directFrom ~= directTo or not Grid.settledAtStart(st, sk, directTo, goals, from, to) then
			local start = { map = map, x = from.x, y = from.y, z = from.z }
			job.reached = start
			return { start, wet = 0 }, 0
		end
	end
	if costOnly then
		job.yards = yards
		return cost
	end

	-- Refine each hop into nodes with their global cells and a running count of water nodes. The pruned entrance
	-- graph may route through an entrance a little off the way, which refines to a spur walked out and back: a node
	-- reached again cuts the loop since its first visit, so the drawn walk never doubles back.
	local P = { x = {}, y = {}, w = {}, k = {}, n = {} }
	if job.check then P.rides = {} end
	local seen = {}
	local function add(k, node)
		local id = k * 1048576 + node
		local at = seen[id]
		if at then
			for j = #P.x, at + 1, -1 do
				seen[P.k[j] * 1048576 + P.n[j]] = nil
				if P.rides then P.rides[j] = nil end
				P.x[j], P.y[j], P.w[j], P.k[j], P.n[j] = nil, nil, nil, nil, nil
			end
			return
		end
		local n = #P.x
		local cell = node < C * C and node or cellOf(st, k, node)
		P.x[n + 1], P.y[n + 1] = floor(k / st.ny) * C + floor(cell / C), (k % st.ny) * C + cell % C
		P.k[n + 1], P.n[n + 1] = k, node
		P.w[n + 1] = (P.w[n] or 0) + (VAL[byte((st.cl[k] or grid(st, k)).kind, node + 1)] == 2 and 1 or 0)
		seen[id] = n + 1
	end
	local function addAll(k, nodes, first, last, step)
		for i = first, last, step do
			add(k, nodes[i])
		end
	end
	local R = trees.R
	-- A hop end beside a landing: its cluster and node.
	local function hopEnd(x, landing)
		if x == START then
			return sk, liftStart[landing]
		elseif x == GOAL then
			return gk, liftGoal[landing]
		elseif x > LIFT_ID then
			return lifts[x - LIFT_ID].k, landingEnds(st, swim, mult, lifts, x - LIFT_ID).node
		end
		return floor(x / 4096), entrance(st, x)
	end
	for i = #hops, 2, -1 do
		local a, b = hops[i], hops[i - 1]
		if a > LIFT_ID or b > LIFT_ID then
			-- To, from or on a lift: a ride joins its two landings; a walk to or from one stays in its cluster.
			local ka, na = hopEnd(a, b)
			local kb, nb = hopEnd(b, a)
			if not na or not nb then return nil, "unreachable" end
			if a > LIFT_ID and b > LIFT_ID then
				if job.check then
					-- Both walks to/from the actual moving platform, not just the
					-- snapped cell centres. Only the paired ride itself is exempt.
					local p, q = lifts[a-LIFT_ID], lifts[b-LIFT_ID]
					local x, y = Safe.xy(st, ka, cellOf(st, ka, na))
					local X, Y = Safe.xy(st, kb, cellOf(st, kb, nb))
					if Safe.segment(job, x, y, p.x, p.y) or Safe.segment(job, q.x, q.y, X, Y) then return nil, "unreachable" end
				end
				add(ka, na)
				local before = #P.x
				add(kb, nb)
				if P.rides and #P.x == before + 1 then P.rides[#P.x] = lifts[a - LIFT_ID].entry end
			elseif search(st, ka, swim, mult, na, R, nb) then
				local nodes = trace(R, nb, {})
				addAll(ka, nodes, #nodes, 1, -1)
			else
				if job.check then return nil, "unreachable" end
				add(ka, na)
				add(kb, nb)
			end
		elseif a == START and b == GOAL then
			if not search(st, sk, swim, mult, directFrom, S, directTo) then return nil, "unreachable" end
			local nodes = trace(S, directTo, {})
			addAll(sk, nodes, #nodes, 1, -1)
		elseif a == START then
			local start = sourceVia[b]
			local endNode = entrance(st, b)
			if not endNode then return nil, "unreachable" end
			local tree = start.tree
			if not tree or not reached(tree, endNode) then
				if not search(st, sk, swim, mult, start.node, S, endNode) then return nil, "unreachable" end
				tree = S
			end
			local nodes = trace(tree, endNode, {})
			addAll(sk, nodes, #nodes, 1, -1)
		elseif b == GOAL then
			local goal = targetVia[a]
			local endNode = entrance(st, a)
			if not endNode then return nil, "unreachable" end
			local tree = goal.tree
			if not tree or not reached(tree, endNode) then
				if not search(st, gk, swim, mult, goal.node, G, endNode, nil, nil, true) then return nil, "unreachable" end
				tree = G
			end
			local nodes = trace(tree, endNode, {})
			addAll(gk, nodes, 1, #nodes, 1)
		else
			local ka, kb = floor(a / 4096), floor(b / 4096)
			local ea, eb = entrance(st, a), entrance(st, b)
			if not ea or not eb then return nil, "unreachable" end
			if ka == kb and search(st, ka, swim, mult, ea, R, eb) then
				local nodes = trace(R, eb, {})
				addAll(ka, nodes, #nodes, 1, -1)
				if job.check then
					-- A baked edge may now wind round forbidden ground. Charge the
					-- materialized detour, not the baked crossing it replaced.
					local s, pos, n, width = edges(st, a)
					for _ = 1, n do
						if edgeTarget(st, s, pos, ka) == b then
							local old = edgeValue(st, s, pos, ci)
							cost = cost + Grid.costAt(R, eb) - (edged and old * edged(a, b) or old)
							break
						end
						pos = pos + width
					end
				end
			else
				if job.check then
					local x, y = Safe.xy(st, ka, cellOf(st, ka, ea))
					local X, Y = Safe.xy(st, kb, cellOf(st, kb, eb))
					if ka == kb or Safe.segment(job, x, y, X, Y) then
						-- Intra-cluster baked edges carry no geometry. Never replace
						-- a failed refinement by a straight chord. Replan without it.
						job.denied = job.denied or {}
						local out = job.denied[a] or {}
						out[b], job.denied[a], job.replan = true, out, true
						return nil, "unreachable"
					end
				end
				add(ka, ea)
				add(kb, eb)
			end
		end
	end

	-- Points carry the height of the surface they stand on (the first: the start's, else, searched without one from
	-- every surface at its spot, the height of the start node the search kept); the cost weights water as the search
	-- did, and points.wet is the yards over water, which call for Water Walking. Straightening keeps to ground no
	-- costlier for profile in style (and danger) than the path it replaces and out of hostile hub cells the path kept
	-- out of (smooth).
	if job.check then
		local x, y = from.x, from.y
		local j = 1
		while j <= #P.x do
			-- Consecutive equal grid steps trace a single exact swept segment.
			-- One policy query covers the straight run, never skipping a turn.
			if j > 1 and not P.rides[j] then
				local dx, dy = P.x[j]-P.x[j-1], P.y[j]-P.y[j-1]
				while j < #P.x and not P.rides[j+1] and P.x[j+1]-P.x[j] == dx and P.y[j+1]-P.y[j] == dy do
					j = j + 1
				end
			end
			local X, Y = x0 + (P.x[j] + .5) * cs, y0 + (P.y[j] + .5) * cs
			if P.rides[j] then
				if Safe.segment(job, x, y, x, y) or Safe.segment(job, X, Y, X, Y) then return nil, "unreachable" end
			elseif Safe.segment(job, x, y, X, Y) then return nil, "unreachable" end
			x, y = X, Y
			j = j + 1
			tick()
		end
		if Safe.segment(job, x, y, to.x, to.y) then return nil, "unreachable" end
		P.check, P.from, P.to = job.check, from, to
	end
	local keep = Grid.smooth(st, P, profile, style, mult and mult.danger)
	if #keep == 1 then -- both ends on one node
		keep[2] = keep[1]
	end
	local points = { { map = map, x = from.x, y = from.y, z = from.z or zOf(grid(st, P.k[keep[1]]), P.n[keep[1]]) } }
	for i = 2, #keep - 1 do
		local j = keep[i]
		points[#points + 1] = {
			map = map,
			x = x0 + (P.x[j] + 0.5) * cs,
			y = y0 + (P.y[j] + 0.5) * cs,
			z = zOf(grid(st, P.k[j]), P.n[j]),
		}
	end
	local endpoint = drawnEnd(map, st, P, goals, to, job, x0, y0, cs, points[#points])
	if endpoint then
		points[#points + 1] = endpoint
	else
		keep[#keep] = nil
		job.reached = points[#points]
	end
	if job.check and not job.reached then
		Safe.joinEnd(st, P, keep, points, true)
		Safe.joinEnd(st, P, keep, points, false)
	end
	if job.check and not Safe.departure(st, P, from, points[2]) then return nil, "unreachable" end
	local wetYards, drawnYards = 0, 0
	for i = 2, #points do
		local p, q = keep[i - 1], keep[i]
		if P.rides and P.rides[q] and q == p + 1 then
			local a, b = points[i-1], points[i]
			if a.x == x0 + (P.x[p]+.5)*cs and a.y == y0 + (P.y[p]+.5)*cs
				and b.x == x0 + (P.x[q]+.5)*cs and b.y == y0 + (P.y[q]+.5)*cs then
				b.rideFrom, b.boarding = a, P.rides[q]
			end
		end
		local wet = q > p and (P.w[q] - P.w[p]) / (q - p) or 0
		local length = sqrt((points[i].x - points[i - 1].x) ^ 2 + (points[i].y - points[i - 1].y) ^ 2)
		wetYards, drawnYards = wetYards + length * wet, drawnYards + length
	end
	points.wet = wetYards
	-- Only the drawn walk uses subcell geometry; planners retain their graph cost.
	return finishDraw(st, P, keep, points, drawnYards, job, profile), cost
end

-- FindCoarse: the walk's shape from the entrance graph alone, no grid decoded or searched. A* from the start to the
-- goal over the entrances (their edges priced as run's) and lift landings (a ride its cost, liftsOf), the start joined to
-- every entrance and landing of its cluster and the goal to those of its, and a landing to its cluster's entrances,
-- at their straight (octile) yards: no grid Dijkstra from an endpoint or a landing, which is most of a cold search.
-- The line is the start, each entrance (the middle of its cell) and landing (with its height) on the way, and the
-- goal: straight inside a cluster at most, between the border crossings the walk takes (consecutive points closer
-- than SKETCH_GAP yards, the two sides of one border, are one); points.coarse = true, job.yards its length. Inside
-- one cluster the full search is that cluster's (run): with job.whole its drawn path, without points.coarse; else
-- nil, "cluster".
local SKETCH_GAP = 8
local function sketch(map, from, to, waterWalking, profile, job, style, danger)
	local st = State(map)
	if not st then
		return nil, "nodata"
	end
	local sk, gk = locate(st, from.x, from.y), locate(st, to.x, to.y)
	if not sk or not gk then
		return nil, "outside"
	end
	if sk == gk then
		if not job.whole then
			return nil, "cluster"
		end
		return run(map, from, to, waterWalking, false, profile, job, style, danger)
	end
	local ci = edgeFields(st, waterWalking, profile)
	local mult, hmin = weights(st, profile, style, danger)
	local edged = edgeDanger(st, mult)
	local lifts = liftsOf(st, map)
	local C, x0, y0, cs, ny = st.C, st.x0, st.y0, st.cs, st.ny
	local lower = max(0, 1 - 0.5 / cs) * hmin
	local function at(id)
		if id > LIFT_ID then
			local l = lifts[id - LIFT_ID]
			return l.x, l.y
		end
		local k, lc = floor(id / 4096), metadata(st, id)
		return x0 + (floor(k / ny) * C + floor(lc / C) + 0.5) * cs, y0 + ((k % ny) * C + lc % C + 0.5) * cs
	end
	local function octile(ax, ay, bx, by)
		local dx, dy = abs(ax - bx), abs(ay - by)
		return dx > dy and dx + (SQRT2 - 1) * dy or dy + (SQRT2 - 1) * dx
	end
	agen = agen + 1
	local gen = agen
	hn = 0
	local function relax(v, gv, parent)
		if astamp[v] ~= gen or gv < ag[v] then
			ag[v], apar[v], astamp[v] = gv, parent, gen
			local h = 0
			if v ~= GOAL then
				local x, y = at(v)
				h = octile(x, y, to.x, to.y) * lower
			end
			push(gv + h, v)
		end
	end
	-- A cluster's entrances and landings, from a point in it at its straight yards.
	local function join(k, x, y, g, parent)
		for _, id in ipairs(nodesOf(st, k)) do
			if aclosed[id] ~= gen then
				local ex, ey = at(id)
				relax(id, g + octile(x, y, ex, ey), parent)
			end
		end
		for _, i in ipairs(lifts.byCluster[k] or {}) do
			local l = lifts[i]
			if aclosed[LIFT_ID + i] ~= gen then
				relax(LIFT_ID + i, g + octile(x, y, l.x, l.y), parent)
			end
		end
	end
	join(sk, from.x, from.y, 0, START)
	local found = false
	while hn > 0 do
		local u = pop()
		if aclosed[u] ~= gen then
			aclosed[u] = gen
			tick()
			if u == GOAL then
				found = true
				break
			end
			local gu = ag[u]
			local ux, uy = at(u)
			local k
			if u > LIFT_ID then
				local l = lifts[u - LIFT_ID]
				k = l.k
				for _, j in ipairs(l.partners) do
					relax(LIFT_ID + j, gu + (l.ride[j] or LIFT_COST), u)
				end
				join(k, ux, uy, gu, u)
			else
				k = floor(u / 4096)
				for _, i in ipairs(lifts.byCluster[k] or {}) do
					local l = lifts[i]
					if aclosed[LIFT_ID + i] ~= gen then
						relax(LIFT_ID + i, gu + octile(ux, uy, l.x, l.y), u)
					end
				end
				nodesOf(st, k)
				local s, pos, n, width = edges(st, u)
				for _ = 1, n do
					local v = edgeTarget(st, s, pos, k)
					if aclosed[v] ~= gen then
						nodesOf(st, floor(v / 4096))
						local c = edgeValue(st, s, pos, ci)
						relax(v, gu + (edged and c * edged(u, v) or c), u)
					end
					pos = pos + width
				end
			end
			if k == gk then
				relax(GOAL, gu + octile(ux, uy, to.x, to.y), u)
			end
		end
	end
	if not found then
		return nil, "unreachable"
	end
	local hops = { GOAL }
	while hops[#hops] ~= START do
		hops[#hops + 1] = apar[hops[#hops]]
	end
	local points = { { map = map, x = from.x, y = from.y, z = from.z } }
	for i = #hops - 1, 2, -1 do
		local id = hops[i]
		local x, y = at(id)
		local last = points[#points]
		if id > LIFT_ID then
			points[#points + 1] = { map = map, x = x, y = y, z = lifts[id - LIFT_ID].z }
		elseif (x - last.x) ^ 2 + (y - last.y) ^ 2 >= SKETCH_GAP * SKETCH_GAP then
			points[#points + 1] = { map = map, x = x, y = y }
		end
	end
	local last = points[#points]
	if #points > 1 and last.z == nil and (to.x - last.x) ^ 2 + (to.y - last.y) ^ 2 < SKETCH_GAP * SKETCH_GAP then
		points[#points] = nil
	end
	points[#points + 1] = { map = map, x = to.x, y = to.y, z = to.z }
	points.coarse = true
	local yards = 0
	for i = 2, #points do
		yards = yards + sqrt((points[i].x - points[i - 1].x) ^ 2 + (points[i].y - points[i - 1].y) ^ 2)
	end
	job.yards = yards
	return points, ag[GOAL]
end

-- Lazy terminal-node connections let nearby targets settle without first searching every faraway endpoint.
-- One sliced Dijkstra owns the heap swap and frontier locals across endpoint searches
local function runMany(map, from, targets, waterWalking, reverse, job, profile, style, danger)
	runStamp = runStamp + 1
	pin = runStamp
	local costs, yards = job and job.costs or {}, job and job.yards or {}
	local function failed(reason)
		for i = 1, #targets do
			costs[i], yards[i] = false, false
		end
		return costs, reason, yards
	end
	local st = State(map)
	if not st then
		return failed("nodata")
	end
	local sk, sc, reason = pointNode(st, from)
	if not sc then
		return failed(reason)
	end
	if job then
		job.valid, job.sourceCluster, job.sourceNode = true, sk, sc
		for i, point in ipairs(targets) do
			if point.x == from.x and point.y == from.y then
				local k, node = pointNode(st, point)
				if k == sk and node == sc then
					costs[i], yards[i] = 0, 0
					job.revision = job.revision + 1
				end
			end
		end
		-- Publish endpoint validity before doing local Dijkstra work. Invalid goals and co-located
		-- transfers can then settle without launching speculative walks across the continent.
		if job.progress then
			yield()
		end
	end
	local swim = waterWalking and 1 or st.swim
	local ci, yi = edgeFields(st, waterWalking, profile)
	local mult = weights(st, profile, style, danger)
	local edged = edgeDanger(st, mult)
	local starts, source, _, sourceYards = connectPoint(st, swim, mult, sk, sc, from.z, from.floors, reverse)
	pin = nil -- the source's trees stay (a target in its cluster is priced on them); the targets' may go
	local clusters, links, dist, dyards, closed, left = {}, {}, {}, {}, {}, #targets
	local lifts = liftsOf(st, map)
	-- Per prepared cluster with a landing: its targets, and per target the nodes it stands on (for a walk off a lift).
	local landed, standsOn = {}, {}
	for i, point in ipairs(targets) do
		local k = locate(st, point.x, point.y)
		if costs[i] ~= nil then
			left = left - 1
		elseif k then
			clusters[k] = clusters[k] or {}
			clusters[k][#clusters[k] + 1] = i
		else
			costs[i], yards[i], left = false, false, left - 1
		end
	end
	hn = 0
	local function relax(id, cost, yd)
		if not dist[id] or cost < dist[id] then
			dist[id], dyards[id] = cost, yd
			push(cost, id)
		end
	end
	local function prepare(k)
		local list = clusters[k]
		if not list then
			return
		end
		clusters[k] = nil
		if lifts.byCluster[k] then
			landed[k] = list
		end
		-- Local searches need their own heap, including across a yield midway through a connection.
		local keys, values, size = hk, hv, hn
		hk, hv, hn = {}, {}, 0
		local direct, directYards, ends, endYards = {}, {}, {}, {}
		for _, i in ipairs(list) do
			local _, node = pointNode(st, targets[i])
			if node then
				local goals, _
				goals, ends[i], _, endYards[i] = connectPoint(st, swim, mult, k, node, targets[i].z, targets[i].floors, not reverse)
				if landed[k] then
					local nodes = {}
					for g, b in ipairs(goals) do
						nodes[g] = b.node
					end
					standsOn[i] = nodes
				end
				local exact, yd
				if k == sk and not landed[k] then
					exact, yd = pocketWalk(st, k, swim, mult, from, targets[i], starts[1], goals[1], reverse)
				end
				if exact then direct[i], directYards[i], ends[i] = exact, yd, nil end
				for j = 1, (k == sk and not exact and #starts or 0) do
					local a = starts[j]
					for _, b in ipairs(goals) do
						-- Both trees search outward from their endpoint; a reverse batch walks to the source.
						local first, last, tree = a.node, b.node, a.tree
						if reverse then
							first, last, tree = b.node, a.node, b.tree
						end
						local cost, yd
						if first == last then
							cost, yd = 0, 0
						elseif tree and reached(tree, last) then
							cost, yd = Grid.costAt(tree, last), yardsAt(st, tree, last)
						elseif search(st, k, swim, mult, first, trees.R, last) then
							cost, yd = Grid.costAt(trees.R, last), yardsAt(st, trees.R, last)
						end
						if cost and (not direct[i] or cost < direct[i]) then
							direct[i], directYards[i] = cost, yd
						end
					end
				end
			else
				costs[i], yards[i], left = false, false, left - 1
				if job then
					job.revision = job.revision + 1
				end
			end
		end
		hk, hv, hn = keys, values, size
		for i, cost in pairs(direct) do
			relax(-i, cost, directYards[i])
		end
		for i, edges in pairs(ends) do
			local edgeYards = endYards[i]
			for id, cost in pairs(edges) do
				links[id] = links[id] or {}
				local joined = links[id]
				joined[#joined + 1], joined[#joined + 2], joined[#joined + 3] = -i, cost, edgeYards[id]
			end
		end
	end
	prepare(sk)
	for id, cost in pairs(source) do
		relax(id, cost, sourceYards[id])
	end
	-- The landings in the start's cluster, walked to from the start.
	for _, i in ipairs(lifts.byCluster[sk] or {}) do
		local land = landingEnds(st, swim, mult, lifts, i)
		for _, a in ipairs(land and starts or {}) do
			local c, yd = within(st, swim, mult, sk, a, land.node)
			if c then
				relax(LIFT_ID + i, c, yd)
			end
		end
	end
	while hn > 0 and left > 0 do
		-- Until the popped node's outgoing edges are relaxed, its key still bounds the frontier.
		if job then
			job.radius = hk[1]
		end
		local u = pop()
		if not closed[u] then
			closed[u] = true
			if u < 0 then
				costs[-u], yards[-u], left = dist[u], dyards[u], left - 1
				if job then
					job.revision = job.revision + 1
				end
			elseif u > LIFT_ID then
				-- A landing: the ride to its other landing, its cluster's entrances and targets.
				local l = lifts[u - LIFT_ID]
				for _, j in ipairs(l.partners) do
					local p = lifts[j]
					relax(LIFT_ID + j, dist[u] + (l.ride[j] or LIFT_COST), dyards[u] + sqrt((p.x - l.x) ^ 2 + (p.y - l.y) ^ 2))
				end
				local land = landingEnds(st, swim, mult, lifts, u - LIFT_ID)
				if land then
					for id, c in pairs(land.edges) do
						if not closed[id] then
							nodesOf(st, floor(id / 4096))
							relax(id, dist[u] + c, dyards[u] + land.yards[id])
						end
					end
					prepare(l.k)
					local from = { node = land.node }
					for _, i in ipairs(landed[l.k] or {}) do
						for _, node in ipairs(not closed[-i] and standsOn[i] or {}) do
							local c, yd = within(st, swim, mult, l.k, from, node)
							if c then
								relax(-i, dist[u] + c, dyards[u] + yd)
							end
						end
					end
				end
			else
				local k = floor(u / 4096)
				prepare(k)
				local ends = links[u]
				for i = 1, ends and #ends or 0, 3 do
					relax(ends[i], dist[u] + ends[i + 1], dyards[u] + ends[i + 2])
				end
				-- The landings in this entrance's cluster.
				for _, i in ipairs(lifts.byCluster[k] or {}) do
					local land = landingEnds(st, swim, mult, lifts, i)
					local c = land and land.edges[u]
					if c and not closed[LIFT_ID + i] then
						relax(LIFT_ID + i, dist[u] + c, dyards[u] + land.yards[u])
					end
				end
				nodesOf(st, k)
				local s, pos, n, width = edges(st, u)
				for _ = 1, n do
					local v = edgeTarget(st, s, pos, k)
					if not closed[v] then
						if edged then
							nodesOf(st, floor(v / 4096))
						end
						local c = edgeValue(st, s, pos, ci)
						relax(v, dist[u] + (edged and c * edged(u, v) or c), dyards[u] + edgeValue(st, s, pos, yi))
					end
					pos = pos + width
				end
			end
		end
		if job then
			job.radius = hn > 0 and hk[1] or huge
		end
		tick()
		Path.Checkpoint() -- after each abstract expansion, as run's (#3640)
	end
	for i = 1, #targets do
		if costs[i] == nil then
			costs[i], yards[i] = false, false
		end
	end
	return costs, nil, yards
end

-- Eight-direction grid distance is a lower bound even across clusters. Costs omit snapping and height
-- and round each abstract edge to yards. Each endpoint can snap
-- SNAP cells and then move SNAP more off a ledge; each nonzero grid step is at least cs before rounding.
-- This bound is in running yards for both water modes, before the planner divides by walkSpeed; on a map with classes
-- a yard may cost as little as the smaller of Costs.MIN (graph edges, Balanced's) and style's smallest multiplier.
-- Zone danger only raises costs (multipliers at least 1), so the bound holds with any danger table.
---@param map number
---@param from SPFPoint
---@param to SPFPoint
---@param style? string the route style (Costs.Style)
---@return number
function Path.LowerBound(map, from, to, style)
	---@type SPFNavData?
	local D = PolestarPathData and PolestarPathData[map]
	-- Unloaded maps need no synchronous addon load just to publish an admissible preview.
	if not D then
		return 0
	end
	local cs = TILE / D.cells
	local dx, dy = abs(from.x - to.x), abs(from.y - to.y)
	local gap = dx > dy and dx + (SQRT2 - 1) * dy or dy + (SQRT2 - 1) * dx
	local cheapest = Grid.Classed(D) and math.min(Costs.MIN, Costs.Min(style)) or 1
	return max(0, gap - (4 * SNAP + 1) * SQRT2 * cs) * max(0, 1 - 0.5 / cs) * cheapest
end

-- May a FindMany batch from job's source serve a new batch from point for profile in style with danger? Only from the
-- same source node, priced for the same profile (Costs.Profile: one for Alliance, one for Horde, one for none), the
-- same style (Costs.Style: nil and unknown names are Balanced) and, on a map with the zone field (where weights
-- prices danger), a danger table of the same signature (dangerOf: the same entries above 1; nil and {} are none).
---@param job SPFPathJob?
---@param point SPFPoint
---@param profile? string the new batch's opts.profile
---@param style? string the new batch's opts.style
---@param danger? table<number, number> the new batch's opts.danger
---@return boolean
function Path.ReuseMany(job, point, profile, style, danger, walkLevel)
	if not job or job.walkLevel ~= walkLevel or job.walkLevel ~= nil or job.map ~= point.map or not job.sourceNode or Costs.Profile(job.profile) ~= Costs.Profile(profile)
		or Costs.Style(job.style) ~= Costs.Style(style) then
		return false
	end
	local st = State(job.map)
	if st.classed and st.zoned and select(2, dangerOf(job.danger)) ~= select(2, dangerOf(danger)) then
		return false
	end
	local from = job.from
	if (from.x - point.x) ^ 2 + (from.y - point.y) ^ 2 > 9 or (from.z and point.z and abs(from.z - point.z) > ZTOL) then
		return false
	end
	local k, node = pointNode(st, point)
	return k == job.sourceCluster and node == job.sourceNode
end

-- The zone (uiMapID) of a world point on map: its chunk's in the map's zone field (tools/lib/nav/pack.js HEADER); nil
-- outside the map's data, on a map without the field, and in a chunk of no zone. Reads the metadata only: no cluster
-- is decoded.
---@param map number
---@param x number
---@param y number
---@return number?
function Path.ZoneAt(map, x, y)
	local st = State(map)
	if not st or not st.zoned then
		return nil
	end
	local k, lc = locate(st, x, y)
	return k and zoneAt(st, k, lc) or nil
end

-- Every chunk's zone in the tile (cluster) holding the world point (x, y) on map, read in one pass (Path.ZoneAt reads
-- one chunk a pass): a string of 512 bytes, the chunk qx chunks along x and qy along y from the tile's corner the
-- uiMapID in bytes 2 * (qx * 16 + qy) + 1 (high) and + 2 (low), 0 for none; and the world chunk indices of that corner
-- (a chunk is 1/16 of a tile: floor(x * 16 / tile) along x). Nav/Danger.lua keeps it for its straight lines. -> s,
-- cx0, cy0; nil outside the map's data or on a map without the field.
---@param map number
---@param x number
---@param y number
---@return string?, integer?, integer?
function Path.ZoneTile(map, x, y)
	local st = State(map)
	if not st or not st.zoned then
		return nil
	end
	local k = locate(st, x, y)
	local s = k and Grid.zoneString(st, k)
	if not s then
		return nil
	end
	local side = st.C * st.cs
	return s, 16 * (floor(st.x0 / side + 0.5) + floor(k / st.ny)), 16 * (floor(st.y0 / side + 0.5) + k % st.ny)
end

-- The player's own steps as evidence (#3641, Fitz in Hillsbrad Fields: he walked round the farmhouse's left side
-- while every walk the arrow asked went round its right, the maps' 4-yd cells closing the orchard and the fence gaps
-- he walked through). samples = { x1, y1, z1, x2, y2, z2, ... }: the player's recent places on map, oldest first, a
-- couple of yards apart (z false where unknown). Two places in a row at most TRAIL_STEP yards apart, on nodes of one
-- cluster that the grid joins by no way at most TRAIL_DETOUR times their distance (plus TRAIL_SLACK cells), are
-- joined for this map's searches (st.trail: a step each way at its length, read by `search`), until the next
-- SetTrail; nil clears it. A walk then goes where the player walked. Nothing is stored or shipped, and the profile's
-- costs and the walk's policy apply to those steps as to any. Each place stands on the surface nearest the last
-- one's height (its own when it has one); two whose surfaces lie further apart in height than Path.trailRise yards a
-- yard plus Path.trailPad (a fence's step, a bank) are never joined: another floor, not a gap. The searches of a set
-- trail are their own (weights' tag carries its
-- version; a trail with the same joins keeps it, so caches stay). Reads decoded clusters only: a place in a cluster
-- not decoded (dropped at rest, never searched) is passed over, so a walk asked at a step change never decodes the
-- player's last minute of ground in that frame (#3451: 30-60 ms frames); the search decodes what it needs in its
-- slices, and the next walk asked has those places. A place asked again at the same height on the same decoded
-- cluster keeps the node it snapped to last time, and a step searched again there keeps its answer (st.trailMemo,
-- the last call's places and steps): the player's trail moves on by a few places between two asks, so a walk asked
-- at a step change snaps only the places added since (#3451: snapping up to 300 places in that frame was half of a
-- step change's cost on a kill-as-you-meet tour). The memo holds its clusters weakly; one dropped and decoded again
-- is snapped again. -> the joins made (map gaps the player walked through) and the middle of the first: n, x, y (0
-- for none).
local TRAIL_STEP, TRAIL_DETOUR, TRAIL_SLACK = 6, 3, 2
Path.trailRise, Path.trailPad = 1.2, 3
local trailVersion = 0
function Path.SetTrail(map, samples)
	local st = State(map)
	if not st then
		return 0
	end
	if not samples then
		st.trail = nil
		return 0
	end
	local arcs, keys, gaps, gx, gy = {}, {}, 0, nil, nil
	-- The grid's own ways, without the trail set before (its joins would hide the gaps they bridge).
	local before = st.trail
	st.trail = nil
	local tree = Tree()
	local C, cs = st.C, st.cs
	local N = C * C
	local memo = st.trailMemo
	if not memo then
		local weak = { __mode = "v" }
		memo = { x = {}, y = {}, h = {}, node = {}, c = setmetatable({}, weak), n = 0, open = {}, on = setmetatable({}, weak), weak = weak }
		st.trailMemo = memo
	end
	local mx, my, mh, mnode, mc, mn = memo.x, memo.y, memo.h, memo.node, memo.c, memo.n
	local openBefore, onBefore = memo.open, memo.on
	local open, on = {}, setmetatable({}, memo.weak)
	-- Where this trail's first place stands in the last one's: the places dropped off its start shift the rest.
	local shift = 0
	for j = 1, mn do
		if mx[j] == samples[1] and my[j] == samples[2] then
			shift = j - 1
			break
		end
	end
	local s = 0
	local pk, pn, px, py, pz, pc
	for i = 1, #samples - 2, 3 do
		local x, y, z = samples[i], samples[i + 1], samples[i + 2]
		if z == false then
			z = nil
		end
		local h = z or pz
		local k, lc = locate(st, x, y)
		local c = k and st.cl[k] or nil
		local node
		s = s + 1
		local j = s + shift
		if c and j <= mn and mc[j] == c and mx[j] == x and my[j] == y and mh[j] == (h or false) then
			node = mnode[j] or nil
		elseif c then
			node = snap(st, k, lc, x, y, h)
		end
		-- (In place: entry s is written after entry s + shift, which is not before it, was read.)
		mx[s], my[s], mh[s], mnode[s], mc[s] = x, y, h or false, node or false, c
		if node then
			local cell = node < N and node or floorCell(c, node)
			local nz = zOf(c, node)
			if pn and pk == k and pn ~= node and (x - px) ^ 2 + (y - py) ^ 2 <= TRAIL_STEP * TRAIL_STEP
				and abs(nz - pz) <= Path.trailRise * (abs(x - px) + abs(y - py)) + Path.trailPad then
				local dx, dy = floor(cell / C) - floor(pc / C), cell % C - pc % C
				local d = sqrt(dx * dx + dy * dy)
				local key = k .. ":" .. (pn < node and pn .. ":" .. node or node .. ":" .. pn)
				if not keys[key] then
					keys[key] = true
					local gap
					if onBefore[key] == c then
						gap = openBefore[key]
					else
						hn = 0
						gap = not search(st, k, 1, nil, pn, tree, node, nil, nil, false, (TRAIL_DETOUR * d + TRAIL_SLACK) * cs)
					end
					open[key], on[key] = gap, c
					if gap then
						local A = arcs[k] or {}
						arcs[k] = A
						local a, b = A[pn] or {}, A[node] or {}
						A[pn], A[node] = a, b
						a[#a + 1], a[#a + 2] = node, d
						b[#b + 1], b[#b + 2] = pn, d
						gaps = gaps + 1
						keys[#keys + 1] = key
						if not gx then
							gx, gy = (x + px) / 2, (y + py) / 2
						end
					end
				end
			end
			pk, pn, px, py, pz, pc = k, node, x, y, nz, cell
		else
			pn = nil
		end
	end
	memo.n, memo.open, memo.on = s, open, on
	Release(tree)
	if gaps == 0 then
		st.trail = nil
		return 0
	end
	table.sort(keys)
	local sig = table.concat(keys, ",")
	if before and before.sig == sig then
		st.trail = before
	else
		trailVersion = trailVersion + 1
		st.trail = { version = trailVersion, sig = sig, arcs = arcs }
	end
	return gaps, gx, gy
end

-- The town hostile to profile (Costs.Profile) whose ground holds the world point (x, y) on map: one of its disks in
-- the map's hubs metadata (D.hubs, Nav/Nav<map>.lua) -> its id and English name; nil without one, without a profile or
-- hubs. Reads the metadata only.
---@param map number
---@param x number
---@param y number
---@param profile? string
---@return string?, string?
function Path.HubAt(map, x, y, profile)
	local D = PolestarPathData and PolestarPathData[map]
	profile = Costs.Profile(profile)
	if not (D and D.hubs and profile and x and y) then
		return nil
	end
	for _, hub in ipairs(D.hubs) do
		if hub.side ~= profile and Costs.Profile(hub.side) then
			for _, d in ipairs(hub.disks or {}) do
				local dx, dy = x - d[1], y - d[2]
				if dx * dx + dy * dy <= d[3] * d[3] then
					return hub.id, hub.name
				end
			end
		end
	end
	return nil
end

-- Path.SurfacesAt's marks, and a node's (its kind byte read from decoded cluster c).
Path.SURFACE_WATER, Path.SURFACE_INDOOR = 1, 2
local function marks(c, node)
	local kb = byte(c.kind, node + 1)
	local cls = CLS[kb] % 8
	return (VAL[kb] == 2 and 1 or 0) + ((cls == INDOOR or cls == CITY) and 2 or 0)
end

-- The walkable surfaces of the cell under a world point on map: its base surface and its floors, base first, each
-- surface's height in out[i] and its marks in out[-i]: SURFACE_WATER (1) when it is water, plus SURFACE_INDOOR (2)
-- when its ground class is indoor or an indoor city (Costs.CLASS INDOOR, CITY; never on a map without classes).
-- -> n, 0 outside the map's data, in a cluster without data or a cell with no walkable surface; nil while the cell's
-- cluster is not decoded: the read never decodes, it queues Path.Prefetch for it (decoded under the frame budget, as
-- a search's clusters are) and a later read finds it. The caller's out is reused (nothing is allocated; entries past
-- n are left as they were). The cluster read last stays decoded at rest (PathGrid's reader) until
-- Path.ReleaseSurfaces(). With areas (optional, reused alike), areas[i] is surface i's WMOAreaTable row id (maps
-- format 3: the client's subzone on that floor, Path.AreaName), 0 for none or on a map without areas.
---@param map number
---@param x number
---@param y number
---@param out table
---@param areas table?
---@return number?
local function groundOnly(map, x, y, out, areas)
	local h = ns.provenGround(map, x, y, true) -- player update: never decompress here
	if h == nil then return 0 end
	out[1], out[-1] = h, 0
	if areas then areas[1] = nil end
	return 1
end
function Path.SurfacesAt(map, x, y, out, areas)
	local st = State(map)
	if not st then
		Grid.dropRead()
		return 0
	end
	local k, lc = locate(st, x, y)
	if not k then
		Grid.dropRead()
		return groundOnly(map, x, y, out, areas)
	end
	local c = st.cl[k]
	if c == nil then
		Grid.wantRead(st, k)
		Path.Prefetch(map, x, y)
		return nil
	end
	if not c then
		Grid.dropRead()
		return groundOnly(map, x, y, out, areas)
	end
	Grid.keepRead(st, k)
	local kind, n = c.kind, 0
	if byte(kind, lc + 1) >= KINDS then
		n = 1
		out[1], out[-1] = zOf(c, lc), marks(c, lc)
		if areas then
			areas[1] = nodeArea(st, k, lc)
		end
	end
	local first, count = floorsOf(c, lc)
	for node = first or 0, (first or 0) + count - 1 do
		if byte(kind, node + 1) >= KINDS then
			n = n + 1
			out[n], out[-n] = zOf(c, node), marks(c, node)
			if areas then
				areas[n] = nodeArea(st, k, node)
			end
		end
	end
	if n == 0 then return groundOnly(map, x, y, out, areas) end
	return n
end

-- 3 when map's walking data carries areas (maps format 3: Path.SurfacesAt's areas), else nil.
---@param map number
---@return number?
function Path.AreaFormat(map)
	local D = PolestarPathData and PolestarPathData[map]
	return D and (D.area ~= nil or (D.packed ~= nil and D.packed.area ~= nil)) and 3 or nil
end

-- The subzone name (English, as GetSubZoneText gives it) of a WMOAreaTable row id of map's areas; nil for none.
---@param map number
---@param id number
---@return string?
function Path.AreaName(map, id)
	local D = PolestarPathData and PolestarPathData[map]
	local name = D and D.areaNames and D.areaNames[id]
	return name ~= "" and name or nil
end

-- The capitals' trail layer (Trails/Trails.lua, written by `node tools/polestar.js nav city trails` from players'
-- recordings, only counts of 3+ distinct people): per ADT tile of a map the levels people walk, by cell of 4.17 yd
-- (128 per tile). A tile's string (ns.PathTrails[map]["<col>_<row>"]) is decoded once, on its first read, into
-- the cells' first entry and count and flat heights and weights (1 = 3-9 people, 2 = 10-49, 3 = 50+).
local TRAIL_TILE = 1600 / 3
local TRAIL_CELL = TRAIL_TILE / 128
local TRAIL_ZTOL = 10 -- yd: `near` keeps the levels this close to it (PathGrid's ZTOL)
local trailTiles = {} -- [map][col * 64 + row] = decoded tile, or false for none

local function trailVarint(s, pos)
	local v, mul = 0, 1
	while true do
		local b = byte(s, pos)
		pos = pos + 1
		if b < 128 then
			return v + b * mul, pos
		end
		v, mul = v + (b - 128) * mul, mul * 128
	end
end

local function trailTile(map, col, row)
	local tiles = trailTiles[map]
	if not tiles then
		tiles = {}
		trailTiles[map] = tiles
	end
	local key = col * 64 + row
	local t = tiles[key]
	if t ~= nil then
		return t
	end
	local src = ns.PathTrails and ns.PathTrails[map]
	local s = src and src[col .. "_" .. row]
	if not s then
		tiles[key] = false
		return false
	end
	t = { first = {}, count = {}, z = {}, w = {} }
	local pos, cell, n, zq = 1, 0, 0, 0
	while pos <= #s do
		local a, q
		a, pos = trailVarint(s, pos)
		q, pos = trailVarint(s, pos)
		local w = a % 4
		cell = cell + (a - w) / 4
		n = n + 1
		zq = zq + (q % 2 == 0 and q / 2 or -(q + 1) / 2)
		t.z[n] = zq / 4
		t.w[n] = w
		if not t.first[cell] then
			t.first[cell], t.count[cell] = n, 0
		end
		t.count[cell] = t.count[cell] + 1
	end
	tiles[key] = t
	return t
end

-- True when map has a trail layer (the six capitals' tiles).
---@param map number
---@return boolean
function Path.HasTrails(map)
	return ns.PathTrails ~= nil and ns.PathTrails[map] ~= nil
end

-- "The floor people walk on here": of the trail levels within reach yd (horizontally, cell centres) of the world point
-- (x, y) on map, the one with the highest weight; ties: the nearer cell, then the height nearer near. near (optional):
-- only levels within TRAIL_ZTOL of it. -> z, weight; nil when none qualifies or map has no trail layer. Allocation-free
-- once the tiles around are decoded.
---@param map number
---@param x number
---@param y number
---@param reach number?
---@param near number?
---@return number?, number?
function Path.TrailFloor(map, x, y, reach, near)
	if not (ns.PathTrails and ns.PathTrails[map]) then
		return nil
	end
	reach = reach or 4
	local ti0 = (32 * TRAIL_TILE - y) / TRAIL_CELL -- cells east
	local tj0 = (32 * TRAIL_TILE - x) / TRAIL_CELL -- cells south
	local r = floor(reach / TRAIL_CELL + 0.5)
	local bz, bw, bd, bdz
	for tj = floor(tj0) - r, floor(tj0) + r do
		for ti = floor(ti0) - r, floor(ti0) + r do
			local d = sqrt((ti + 0.5 - ti0) ^ 2 + (tj + 0.5 - tj0) ^ 2) * TRAIL_CELL
			if d <= reach + TRAIL_CELL * 0.5 then
				local col, row = floor(ti / 128), floor(tj / 128)
				local t = trailTile(map, col, row)
				local cell = (tj - row * 128) * 128 + (ti - col * 128)
				local first = t and t.first[cell]
				if first then
					for e = first, first + t.count[cell] - 1 do
						local z, w = t.z[e], t.w[e]
						local dz = near and abs(z - near) or 0
						if dz <= TRAIL_ZTOL and (not bw or w > bw or (w == bw and (d < bd or (d == bd and dz < bdz)))) then
							bz, bw, bd, bdz = z, w, d, dz
						end
					end
				end
			end
		end
	end
	return bz, bw
end

-- The walkable surfaces' heights in the cell under (x, y) on the map of st, lowest first (its cluster decoded).
local function heightsAt(st, x, y)
	local k, lc = locate(st, x, y)
	local c = k and grid(st, k)
	if not c then
		return {}
	end
	local kind, out = c.kind, {}
	if byte(kind, lc + 1) >= KINDS then
		out[1] = zOf(c, lc)
	end
	local first, count = floorsOf(c, lc)
	for node = first or 0, (first or 0) + count - 1 do
		if byte(kind, node + 1) >= KINDS then
			out[#out + 1] = zOf(c, node)
		end
	end
	table.sort(out)
	return out
end

-- The height of a spawn listed where floors overlap (maps format 5's spawn field, `forge nav pack`'s
-- pack/spawns.rs: per cluster "x y z ..." in whole yards; ported from Shortest Path Forever v1.33.0's spawn heights,
-- his v1.30 Data/Heights.lua) within SPAWN_REACH yards of world (x, y): the nearest's. nil when none, or the map
-- has no field. A cluster's list is read once (st.spawns[k]: a flat array x, y, z, ...; false for none).
local SPAWN_REACH = 8
local function spawnHeight(st, x, y)
	local D = st and st.D
	if not (D and (D.spawn or (D.packed and D.packed.spawn))) then
		return nil
	end
	st.spawns = st.spawns or {}
	local best, bestD
	local C, cs = st.C, st.cs
	-- The clusters of the four corners of the reach square: the point's own, and those within SPAWN_REACH of it.
	local done = {}
	for sx = -1, 1, 2 do
		for sy = -1, 1, 2 do
			local gx, gy = floor((x + sx * SPAWN_REACH - st.x0) / cs), floor((y + sy * SPAWN_REACH - st.y0) / cs)
			local k = floor(gx / C) * st.ny + floor(gy / C)
			if gx >= 0 and gy >= 0 and gx < st.GX and gy < st.GY and not done[k] then
				done[k] = true
				local list = st.spawns[k]
				if list == nil then
					local raw = Grid.unpackField(D, "spawn", k + 1)
					list = false
					if raw then
						list = {}
						for v in raw:gmatch("%S+") do
							list[#list + 1] = tonumber(v)
						end
					end
					st.spawns[k] = list
				end
				if list then
					for i = 1, #list - 2, 3 do
						local d = (list[i] - x) ^ 2 + (list[i + 1] - y) ^ 2
						if d <= SPAWN_REACH * SPAWN_REACH and (not bestD or d < bestD) then
							best, bestD = list[i + 2], d
						end
					end
				end
			end
		end
	end
	return best
end

-- A point asked at a height with a reach (`reach` yards: Nav/Walk.lua inside the capitals, where a walk asked again
-- without the goal's height ends on whatever surface is cheapest at its spot: Ironforge's mountain, a roof, the ground
-- under Stormwind's streets): when no walk reaches its own floor, the walk to (or, for a batch, from) the nearest
-- surface within `reach` yards on its level (within ZTOL of its height) that one is found for. #2860: the cooking
-- trainer's platform in the Great Forge, which the maps reach only at its foot. Candidates by their flat distance plus
-- twice their height's gap, at most REACH_TRIES tries, a candidate within a cell of one tried on the same level
-- skipped (it settles on the same node). try(q) -> its answer when it is one, else nil. -> q, and try's answer; nil.
local REACH_TRIES = 6
local function nearby(map, p, try)
	local st = State(map)
	if not st then
		return nil
	end
	local cs, reach, z = st.cs, p.reach, p.z
	local r, cands = math.ceil(reach / cs), {}
	for dx = -r, r do
		for dy = -r, r do
			local d = sqrt(dx * dx + dy * dy) * cs
			if d > 0 and d <= reach then
				local x, y = p.x + dx * cs, p.y + dy * cs
				for _, h in ipairs(heightsAt(st, x, y)) do
					local gap = abs(h - z)
					if gap <= ZTOL then
						cands[#cands + 1] = { x, y, h, d + 2 * gap, #cands }
					end
				end
			end
		end
	end
	table.sort(cands, function(a, b)
		if a[4] ~= b[4] then
			return a[4] < b[4]
		end
		return a[5] < b[5]
	end)
	local tried = {}
	for _, c in ipairs(cands) do
		if #tried >= REACH_TRIES then
			return nil
		end
		local near = false
		for _, t in ipairs(tried) do
			if abs(t[1] - c[1]) <= cs and abs(t[2] - c[2]) <= cs and abs(t[3] - c[3]) <= ZTOL then
				near = true
				break
			end
		end
		if not near then
			tried[#tried + 1] = c
			local q = { x = c[1], y = c[2], z = c[3], map = p.map }
			local a, b, y = try(q)
			if a then
				return q, a, b, y
			end
		end
	end
	return nil
end

-- A nearby approach is needed only when the graph ends on the wrong floor. The penultimate
-- drawing point may be the foot of a perfectly mapped uphill walk, hundreds of yards away.
-- Keep a marked approach within the normal floor tolerance: a closer XY point can be on a
-- different, disconnected deck (Gyll). The tighter arrival radius governs what may be drawn.
local function offLevel(job, z)
	return job.endFloor and abs(job.endFloor - z) > ZTOL
end

-- runMany, and for a batch whose source has a height and a reach (above) that finds no walk at all, the batch again
-- from the source's nearest surface on its level that finds one (job.reached: { x, y, z }).
local function coarseManyReach(map, from, targets, waterWalking, reverse, job, profile, style, danger)
	local costs, reason, yards = runMany(map, from, targets, waterWalking, reverse, job, profile, style, danger)
	if not (from.reach and from.z) then
		return costs, reason, yards
	end
	local function any(c)
		for i = 1, #targets do
			if type(c[i]) == "number" then
				return true
			end
		end
		return false
	end
	if any(costs) then
		return costs, reason, yards
	end
	local q, c, rr, y = nearby(map, from, function(p)
		-- (a batch's settled costs are kept: runMany skips a target that has one)
		if job then
			for i = 1, #targets do
				job.costs[i], job.yards[i] = nil, nil
			end
		end
		local c2, r2, y2 = runMany(map, p, targets, waterWalking, reverse, job, profile, style, danger)
		if any(c2) then
			return c2, r2, y2
		end
	end)
	if not q then
		return costs, reason, yards
	end
	if job then
		job.reached = { x = q.x, y = q.y, z = q.z }
	end
	return c, rr, y
end

-- run, and for an end without a height (a map click: no floor said) that finds no walk, the same walk from each
-- other surface of that end's cell, lowest first, before giving up: a point without a height starts on the
-- surface its cell's search picks (the base, or the cheapest of those apart in height), which can be a pocket no
-- walk leaves (William MacGregor's house in Westfall: the ground's surface over the house floor, 4 yd above it).
-- The start's surfaces first, then the goal's; at most RETRY_SURFACES tries. The answer's end keeps that surface's
-- height. A goal without a height beside a spawn listed where floors overlap (spawnHeight) is walked to on that
-- spawn's floor first: the NPC in the cellar, not the street over it.
-- None of those found a walk: the same tries once more as a rescue (each surface once), whose end settles past the
-- pockets its tries flood (settle's `pockets`), not only the latest. Nothing else changes: an answer found before
-- the rescue is the same answer, and a walk the rescue finds says so (job.rescued: "start" or "goal"; a rescued goal
-- the walk ends beside also says where, job.reached, and its line ends there).
local RETRY_SURFACES = 6
local function coarseAny(job)
	local map, from, to = job.map, job.from, job.to
	job.rescued, job.collapsed = nil, nil
	-- A goal at a height with a reach (nearby, above): its own floor first; unreachable, or a walk that ends off its
	-- level, the nearest surface on its level within reach that a walk ends on (job.reached); none: the first answer.
	if to.reach and to.z then
		local points, cost = run(map, from, to, job.waterWalking, job.costOnly, job.profile, job, job.style, job.danger)
		if job.collapsed or (points and (job.costOnly or not offLevel(job, to.z))) then
			return points, cost
		end
		local yards, hubs, avoided, reached, endFloor, endMiss = job.yards, job.hubs, job.avoided, job.reached, job.endFloor, job.endMiss
		local q, a, b = nearby(map, to, function(p)
			local a2, b2 = run(map, from, p, job.waterWalking, job.costOnly, job.profile, job, job.style, job.danger)
			if a2 and (job.costOnly or not offLevel(job, to.z)) then
				return a2, b2
			end
		end)
		if q then
			job.reached = job.reached or { x = q.x, y = q.y, z = q.z }
			return a, b
		end
		job.yards, job.hubs, job.avoided, job.reached, job.endFloor, job.endMiss = yards, hubs, avoided, reached, endFloor, endMiss
		return points, cost
	end
	if to.z == nil then
		local sz = spawnHeight(State(map), to.x, to.y)
		if sz then
			local p, c = run(map, from, { x = to.x, y = to.y, z = sz, map = to.map }, job.waterWalking, job.costOnly, job.profile, job, job.style, job.danger)
			if p then
				return p, c
			end
		end
	end
	local points, cost = run(map, from, to, job.waterWalking, job.costOnly, job.profile, job, job.style, job.danger)
	if points or cost ~= "unreachable" or (from.z and to.z) then
		return points, cost
	end
	local st = State(map)
	local function retry(rescue)
		local tries = 0
		for side = 1, 2 do
			local p = side == 1 and from or to
			if p.z == nil then
				local last
				for _, h in ipairs(heightsAt(st, p.x, p.y)) do
					if tries >= RETRY_SURFACES then
						return nil
					end
					if not (rescue and h == last) then
						tries, last = tries + 1, h
						local q = { x = p.x, y = p.y, z = h, map = p.map, rescue = rescue or nil }
						local a, b = run(map, side == 1 and q or from, side == 2 and q or to, job.waterWalking, job.costOnly,
							job.profile, job, job.style, job.danger)
						if a then
							if rescue then
								job.rescued = side == 1 and "start" or "goal"
							end
							return a, b
						end
					end
				end
			end
		end
	end
	local a, b = retry(false)
	if a then
		return a, b
	end
	a, b = retry(true)
	if a then
		return a, b
	end
	return points, cost
end

-- A local witness is not an off-mesh teleport. Both ends and the entire walk must be
-- supported on one trace or on adjoining certified dry ground. Preserve faction policy,
-- active danger weighting and successful graph routes. No new transport or dungeon joins.
local function localAnswer(map, from, to, profile, style, danger, solve)
	local points, kind = (solve or ns.provenWalk)(map, from, to)
	if not points then return end
	local st = State(map)
	if not st or #hubsOn(st.D.hubs, points, profile) > 0 then return end
	if not to.z then
		local known = spawnHeight(st, to.x, to.y)
		if known and abs(points[#points].z - known) > 1 then return end
	end
	if not from.z and from.floors and #from.floors > 0 then
		local matched
		for _, z in ipairs(from.floors) do if abs(points[1].z - z) <= 1 then matched = true; break end end
		if not matched then return end
	end
	local active = st.zoned and type(danger) == "table" and next(danger) and danger
	local yards, weighted = 0, 0
	for i = 2, #points do
		local a, b = points[i - 1], points[i]
		local multiplier = 1
		if active then
			-- A higher-level zone makes this corridor less attractive, never impassable.
			local side = 100 / 3
			for r = floor(math.min(a.x, b.x) / side), floor(math.max(a.x, b.x) / side) do
				for c = floor(math.min(a.y, b.y) / side), floor(math.max(a.y, b.y) / side) do
					local zone = Path.ZoneAt(map, (r + .5) * side, (c + .5) * side)
					local factor = zone and active[zone]
					if type(factor) == "number" and factor > multiplier then multiplier = factor end
				end
			end
		end
		local distance = sqrt((a.x - b.x)^2 + (a.y - b.y)^2)
		yards, weighted = yards + distance, weighted + distance * multiplier
	end
	local ground = kind == "ground" or kind == "ground-native"
	return points, weighted * Costs.Mult(ground and Costs.CLASS.GENTLE or Costs.CLASS.INDOOR, profile, style), yards, kind
end

local function preferSupported(job, points, cost)
	if job.reached then job.endFloor = job.reached.z end
	local chord = points and not job.reached and not job.endMiss and (job.costOnly or not job.to.z or not offLevel(job, job.to.z))
	-- For the last twenty yards prefer a fully supported dry walk to a
	-- coarse line. Keep its turns and reject every stateful policy contact.
	local a, b = job.from, job.to
	if chord and not job.costOnly and type(points) == "table" and #points >= 2 and points.wet == 0
		and a.z and b.z and job.yards and (a.x-b.x)^2+(a.y-b.y)^2 <= 20^2 then
		local ordinary = true
		for i=1,#points do if points[i].detail then ordinary=false;break end end
		if ordinary then
			local line, price, length = localAnswer(job.map,a,b,job.profile,job.style,job.danger,ns.astraSurfaceWalk)
			if line and length <= 1.6*job.yards+3 and (not job.check or Safe.line(job, line, a, b)) then
				local clear = true
				for i=2,#line do if not ns.noNewTailVolume(job.map,line[i-1],nil,line[i]) then clear=false;break end end
				if clear then
					line.absoluteDry=true
					job.localWalk,job.yards,job.endFloor="surface-terminal",length,line[#line].z
					recordHubs(job,State(job.map).D.hubs,line,job.report or job.profile)
					return line,price
				end
			end
		end
	end
	if chord and (job.costOnly or type(points) ~= "table" or #points ~= 2 or points.wet ~= 0
		or not job.from.z or not job.to.z or not job.yards or job.yards > 128 or job.yards < 2
		or points[1].detail or points[2].detail) then return points, cost end
	local line, price, yards, kind = localAnswer(job.map, job.from, job.to, job.profile, job.style, job.danger)
	if line and job.check and not Safe.line(job, line, job.from, job.to) then line = nil end
	if chord then
		-- A straight coarse chord may cross a wall or miss the crown of a ramp.
		-- Replace it only with a complete, policy-checked, comparably short physical
		-- alternative whose actual interior differs. Never smooth a lift or wet route.
		if not line or #line < 3 or yards > 1.6 * job.yards + 3 then return points, cost end
		local a, b = points[1], points[2]
		local dx, dy = b.x - a.x, b.y - a.y
		local norm, differs = dx * dx + dy * dy, false
		if norm < 1 then return points, cost end
		for i = 2, #line - 1 do
			local p = line[i]
			local t = math.max(0, math.min(1, ((p.x - a.x) * dx + (p.y - a.y) * dy) / norm))
			if (a.x + t * dx - p.x)^2 + (a.y + t * dy - p.y)^2 > .55^2
				or abs(a.z + t * (b.z - a.z) - p.z) > .85 then differs = true; break end
		end
		if not differs then return points, cost end
	end
	-- For a long journey the coarse graph sometimes ends early. Retain its whole
	-- approach and attach only at the actual drawn, graph-supported last point.
	if not line and type(points) == "table" and #points > 1 and job.reached then
		local last, at = points[#points], job.reached
		if last.z and at.z and abs(last.z - at.z) <= 1
			and (last.x - at.x)^2 + (last.y - at.y)^2 < .01 then
			local tail, extra, distance, evidence = localAnswer(job.map, last, job.to, job.profile, job.style, job.danger)
			if tail and (not job.check or Safe.line(job, tail, last, job.to)) then
				for i = 2, #tail do points[#points + 1] = tail[i] end
				line, price, yards, kind = points, cost + extra, job.yards + distance, "graph+" .. evidence
			end
		end
	end
	if not line then return points, cost end
	job.localWalk, job.yards, job.endFloor, job.reached, job.rescued = kind, yards, line[#line].z, nil, nil
	recordHubs(job, State(job.map).D.hubs, line, job.report or job.profile)
	if job.costOnly then return price end
	return line, price
end

local function runAny(job)
	local line, cost = preferSupported(job, coarseAny(job))
	-- A map-only caller has no player policy. A snapped departure still
	-- cannot cross known masonry. Check the final line, after local detours.
	if not job.check and job.from.z and type(line) == "table" and line[2] then
		local a, b = line[1], line[2]
		if not b.rideFrom and Grid.solidChord(State(job.map), a.x, a.y, a.z, b.x, b.y, b.z) then
			job.yards = nil
			return nil, "unreachable"
		end
	end
	return line, cost
end

function Safe.find(job)
	local from, to = job.from, job.to
	local why
	if not job.check then why = Safe.setup(job) end
	if not why then why = Safe.segment(job, from.x, from.y, from.x, from.y) or Safe.segment(job, to.x, to.y, to.x, to.y) end
	if why then job.blockedReason = why; return nil, Safe.refusal end
	-- Cost work also needs the actual line. Leave the enqueued job's costOnly
	-- untouched (the scheduler uses it for priority between coroutine slices).
	local solve = { map = job.map, from = from, to = to, waterWalking = job.waterWalking,
		profile = job.profile, report = job.report or job.profile, style = job.style, danger = job.danger,
		walkLevel = job.walkLevel, check = job.check, policy = job.policy, skipReport = job.costOnly }
	repeat
		solve.replan = nil
		solve.endMiss, solve.endFloor, solve.yards, solve.reached, solve.localWalk = nil, nil, nil, nil, nil
		local points, cost = runAny(solve)
		-- A supported approach is useful for steering, but is not a transfer to
		-- the target. Preserve the original terminal; never publish its cost to a planner.
		local stop=solve.reached
		if not job.costOnly and not job.coarseOnly and type(stop)=="table" and points and #points>1 then
			local first,last=points[1],points[#points]
			-- Already on the goal's floor: a partial ending farther away on that
			-- same floor has no onward leg. Only its endpoint matters here; a
			-- real route can lead away temporarily to reach a door or stair.
			local retreats = from.z and to.z and last.z and abs(from.z - to.z) <= 1 and abs(last.z - to.z) <= 1
				and (last.x - to.x)^2 + (last.y - to.y)^2 >= (from.x - to.x)^2 + (from.y - to.y)^2
			if first.x==from.x and first.y==from.y and (not from.z or (first.z and abs(first.z-from.z)<=1))
				and last.x==stop.x and last.y==stop.y and last.z and stop.z and abs(last.z-stop.z)<=1
				and not retreats and Safe.line(solve,points,from,last) then
				job.reached,job.yards,job.endFloor=stop,solve.yards,solve.endFloor
				job.hubs,job.avoided,job.rescued=solve.hubs,solve.avoided,solve.rescued
				return points,cost
			end
		end
		if points and Safe.line(solve, points, from, to) then
			local first, last = points[1], points[#points]
			-- A partial approach, in particular on a disconnected floor, is not
			-- a proved transfer and must never settle a batch target.
			if first.x == from.x and first.y == from.y and last.x == to.x and last.y == to.y
				and (not from.z or (first.z and abs(first.z-from.z) <= 1))
				and (not to.z or (last.z and abs(last.z-to.z) <= 1)) and not solve.reached
				and (not solve.endMiss or solve.localWalk) then
				job.blockedReason = nil
				job.walkChecked = true
				job.yards, job.localWalk, job.endFloor = solve.yards, solve.localWalk, solve.endFloor
				job.hubs, job.avoided, job.rescued = solve.hubs, solve.avoided, solve.rescued
				if job.costOnly then return cost end
				return points, cost
			end
		end
		job.blockedReason = solve.blockedReason or job.blockedReason
		if not solve.replan and (solve.filtered or not solve.blockedReason) then break end
		solve.filtered = true
		solve.vertices = solve.vertices or {}
		tick()
	until false
	return nil, Safe.refusal
end

-- A batch's source at a height its places' walks can't reach though no policy says no (Foggy MacKreel on a broken
-- section of the Thandol Span, #3553: the maps hold the deck above and the water below, not the ledge he stands on)
-- would fail place after place, each search running dry: 16 places, about 250,000 expansions each, four minutes
-- of slices. While no place is priced yet, a place whose walk fails so is asked once more to the source without
-- its height: when that walk exists, the source's floor is what no walk joins (job.unjoined), and that place and
-- every place not searched yet are left unpriced (costs[i] nil: the caller keeps its estimate, as for a place
-- beyond its reach), never false. Once a place is priced, a walk does reach that floor, so a later failure is that
-- place's own and stays false, as does a walk with no way at all (none without the height either).
-- A batch that has spent Path.manyCap expansions stops before its next place: the places not priced yet are left
-- unpriced (job.capped; costs[i] nil, the caller's estimates), never false. Whatever the maps hold that no rule above
-- foresaw, a batch's search ends (#3605: before the pocket rule in run, 16 places ran to the detour bound, minutes of
-- slices). The cap sits well over the batches ordinary routes take (430,000 to 600,000 expansions measured on the
-- route-speed scenes, whose settled routes it leaves as they were).
-- A target marked `bound` (the player's own walk into a measured target, Nav/Walk.lua) is searched right after the
-- `first` ones; once it is priced, a place whose walk can't be cheaper than it (Path.LowerBound over its gap to the
-- source above the bound's cost, and that gap above its yards) is left unpriced (job.pruned; costs[i] nil, the
-- caller's estimate, itself no less than that bound), never searched: a route ending in that walk costs more than
-- walking from where the player stands. A place at the same point as one already searched (same x, y, z, no floors
-- or reach of its own) takes that one's answer. Fitz's 0.4.3-rc probe (Sun Rock's turn-ins from the Charred Vale):
-- the flight masters and inns of Desolace, the Barrens and Ashenvale, 3,500-7,200 yd of walk from the target while the
-- player's own walk was 1,476, took 438,000 of the batch's 571,000 expansions, 19 s of 3 ms slices.
Path.manyCap = 1000000
function Safe.many(job)
	local why = Safe.setup(job)
	local from = job.from
	why = why or Safe.segment(job, from.x, from.y, from.x, from.y)
	if why then
		job.blockedReason, job.radius = why, huge
		for i = 1, #job.targets do job.costs[i], job.yards[i] = false, false end
		job.revision = job.revision + 1
		return job.costs, Safe.refusal, job.yards
	end
	-- Publish nearby verified transfers first, regardless of the planner's target
	-- order; a target marked `first` (the landing a planned route waits on) before
	-- them, then the `bound` one. Each target is its own search, so the order changes no answer, only when each is
	-- published. A pending entry stays nil with a conservative radius of zero.
	local order, dist, lead, any = {}, {}, {}, false
	local bound, boundYards -- the bound target's cost and yards, once priced
	for i, p in ipairs(job.targets) do
		order[i], dist[i], lead[i] = i, (p.x-from.x)^2 + (p.y-from.y)^2, p.first and 0 or p.bound and 1 or 2
		if p.bound and type(job.costs[i]) == "number" then bound, boundYards = job.costs[i], job.yards[i] or job.costs[i] end
	end
	for i = 1, #job.targets do
		if job.costs[i] then any = true end
	end
	table.sort(order, function(a,b)
		if lead[a] ~= lead[b] then return lead[a] < lead[b] end
		return dist[a] < dist[b] or (dist[a] == dist[b] and a < b)
	end)
	local function search(target, source)
		local child = { map = job.map, from = job.reverse and target or source, to = job.reverse and source or target,
			profile = job.profile, report = job.report, walkLevel = job.walkLevel, style = job.style, danger = job.danger,
			waterWalking = job.waterWalking, costOnly = true, check = job.check, policy = job.policy }
		return Safe.find(child), child
	end
	local D = PolestarPathData and PolestarPathData[job.map]
	local cheapest = D and Grid.Classed(D) and math.min(Costs.MIN, Costs.Min(job.style)) or 1
	local function beyond(target)
		if not bound or target.first then return false end
		local least = Path.LowerBound(job.map, from, target, job.style)
		return least > bound and least / cheapest > boundYards
	end
	-- An earlier target at the same point, already answered: its index.
	local function twin(n, target)
		if target.floors or target.reach then return nil end
		for k = 1, n - 1 do
			local j = order[k]
			local q = job.targets[j]
			if job.costs[j] ~= nil and q.x == target.x and q.y == target.y and q.z == target.z and not q.floors and not q.reach then return j end
		end
		return nil
	end
	for n, i in ipairs(order) do
		local target = job.targets[i]
		if job.costs[i] == nil and not job.unjoined and not job.capped and Expansions() >= Path.manyCap then job.capped = true end
		local same = job.costs[i] == nil and not job.unjoined and not job.capped and twin(n, target)
		if same then
			job.costs[i], job.yards[i] = job.costs[same], job.yards[same]
			job.revision = job.revision + 1
		elseif job.costs[i] == nil and not job.unjoined and not job.capped and beyond(target) then
			job.pruned = true
		elseif job.costs[i] == nil and not job.unjoined and not job.capped then
			local cost, child = search(target, from)
			if not cost and from.z and not any and not child.blockedReason and search(target, { x = from.x, y = from.y }) then
				job.unjoined = true
			else
				if child.walkChecked then job.walkChecked = true end
				job.costs[i], job.yards[i] = cost or false, cost and child.yards or false
				if not cost then job.blockedReason = child.blockedReason or job.blockedReason end
				if target.bound and cost then bound, boundYards = cost, child.yards or cost end
			end
			job.revision = job.revision + 1
		end
		if job.costs[i] then any, job.valid = true, true end
		tick()
	end
	job.radius = huge
	if not any and not job.unjoined and not job.capped then return job.costs, Safe.refusal, job.yards end
	return job.costs, nil, job.yards
end

local function runManyReach(map, from, targets, waterWalking, reverse, job, profile, style, danger)
	local costs, reason, yards = coarseManyReach(map, from, targets, waterWalking, reverse, job, profile, style, danger)
	if job and job.reached then return costs, reason, yards end
	for i, target in ipairs(targets) do
		if costs[i] and Grid.verticalGap(from, target) then
			local st = State(map)
			local ka, a = pointNode(st, from)
			local kb, b = pointNode(st, target)
			if a and ka == kb and Grid.missedDeck(st, ka, a, b, from, target, yards[i]) then
				costs[i], yards[i] = false, false
				-- The priced graph edge stays on one level.
				if job then job.sourceNode = nil end
			end
		end
		if not costs[i] then
			local _, price, distance = localAnswer(map, from, target, profile, style, danger)
			if price then
				costs[i], yards[i], reason = price, distance, nil
				if job then
					job.valid, job.sourceNode, job.revision = true, nil, job.revision + 1
				end
			end
		end
	end
	return costs, reason, yards
end

local function start(job)
	if job.prefetch then
		Grid.prefetch(job.st, job.k)
		local st, k = job.st, job.k
		if st.D.localWalk then
			local side = st.C * st.cs
			ns.provenGround(st.map, st.x0 + (floor(k / st.ny) + .5) * side, st.y0 + (k % st.ny + .5) * side)
		end
		return
	end
	if job.notify then
		local owner = job.owner
		if not owner.cancelled then
			job.notify(job.points, job.cost, owner)
		end
		return
	end
	Expansions(0)
	if job.walkLevel ~= nil then
		if job.targets then return Safe.many(job) end
		-- A sketch across clusters (FindCoarse) is a drawn shape over the entrance graph (points.coarse), never a walk
		-- the arrow follows or a leg is priced on: it is drawn at once, as before strict jobs, and the checked walk
		-- replaces it. Inside one cluster `whole` draws the cluster's real walk, which a leg is priced on (Walk.lua's
		-- later legs): that one is still checked.
		if job.coarseOnly then
			local st = State(job.map)
			local sk = st and locate(st, job.from.x, job.from.y)
			if not (sk and job.whole and sk == locate(st, job.to.x, job.to.y)) then
				return sketch(job.map, job.from, job.to, job.waterWalking, job.profile, job, job.style, job.danger)
			end
		end
		return Safe.find(job)
	end
	if job.targets then
		return runManyReach(job.map, job.from, job.targets, job.waterWalking, job.reverse, job, job.profile, job.style, job.danger)
	end
	if job.coarseOnly then
		if job.whole then
			local st = State(job.map)
			if st then
				local k = locate(st, job.from.x, job.from.y)
				if k and k == locate(st, job.to.x, job.to.y) then
					return preferSupported(job, sketch(job.map, job.from, job.to, job.waterWalking, job.profile, job, job.style, job.danger))
				end
			end
		end
		return sketch(job.map, job.from, job.to, job.waterWalking, job.profile, job, job.style, job.danger)
	end
	return runAny(job)
end

local spare
local function scratch(saved)
	local previous = { hk, hv, hn, trees, ag, apar, astamp, aclosed, agen, ay }
	if not saved and spare then
		saved, spare = spare, nil
		saved[3] = 0
	end
	if saved then
		hk, hv, hn, trees = saved[1], saved[2], saved[3], saved[4]
		ag, apar, astamp, aclosed, agen, ay = saved[5], saved[6], saved[7], saved[8], saved[9], saved[10]
	else
		hk, hv, hn = {}, {}, 0
		trees = { S = Tree(), G = Tree(), R = Tree(), B = {} }
		ag, apar, astamp, aclosed, agen, ay = {}, {}, {}, {}, 0, {}
	end
	return previous
end

-- Synchronous search, for tests and tools. Returns points, cost (or nil, reason), the expansion count and the job
-- (its yards and hubs, as Find's).
---@param map number
---@param from SPFPoint
---@param to SPFPoint
---@param opts? boolean|{ waterWalking: boolean?, profile: string?, style: string?, danger: table<number, number>? } waterWalking, or opts (options above)
function Path.FindSync(map, from, to, opts)
	Deadline(huge)
	local waterWalking, profile, style, danger, report, walkLevel = options(opts)
	local job = { map = map, from = from, to = to, waterWalking = waterWalking, profile = profile, style = style, danger = danger,
		report = report, walkLevel = walkLevel }
	local co = coroutine.create(start)
	local saved = scratch()
	local ok, points, cost = coroutine.resume(co, job)
	scratch(saved)
	if not ok then
		error(points)
	end
	return points, cost, Expansions(), job
end

-- Costs indexed like targets, false for unreachable/off-mesh points; no geometry is built. reverse returns
-- target -> from costs, including the directed same-cluster water step. Format 1's abstract edges are symmetric;
-- format 2's are directional (each priced the way out of its entrance, the class of the node it enters), and the
-- reversed search reads the outbound costs, so a reversed cost is off by at most one entered step at each end.
-- Returns costs, reason, the expansion count and yards indexed like costs (FindMany's job.yards).
---@param map number
---@param from SPFPoint
---@param targets SPFPoint[]
---@param opts? boolean|{ waterWalking: boolean?, profile: string?, style: string?, danger: table<number, number>? } waterWalking, or opts (options above)
---@param reverse? boolean
function Path.FindManySync(map, from, targets, opts, reverse)
	Deadline(huge)
	Expansions(0)
	local saved = scratch()
	local waterWalking, profile, style, danger, _, walkLevel = options(opts)
	local costs, reason, yards
	if walkLevel ~= nil then
		costs, reason, yards = Safe.many({ map = map, from = from, targets = targets, waterWalking = waterWalking,
			profile = profile, style = style, danger = danger, reverse = reverse, walkLevel = walkLevel, costs = {}, yards = {}, revision = 0 })
	else
		costs, reason, yards = runManyReach(map, from, targets, waterWalking, reverse, nil, profile, style, danger)
	end
	scratch(saved)
	return costs, reason, Expansions(), yards
end

-- PathJobs.lua resumes start in a coroutine between scratch swaps; a finished search's scratch is kept as spare.
---@class SPFPathSearch
ns.PathSearch = {
	start = start,
	options = options,
	scratch = scratch,
	-- saved: a finished search's scratch, kept for the next; nil once the router is idle.
	Spare = function(saved)
		spare = saved
		if not saved then
			pool = {}
		end
	end,
	-- The queue emptied (PathJobs.lua's rest): what the pool holds goes (it fills while a run gives up more endpoint
	-- trees than st.endTrees keeps: a batch, a start on several floors; a tree is 2-4 MB), and Grid.Rest then hands it
	-- the newest start's tree (Release), one of the Path.restTrees kept between searches.
	Rest = function()
		pool = {}
	end,
	Release = Release,
}
