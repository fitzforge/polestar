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
local cellOf, nodesOf, metadata, adjacent = Grid.cellOf, Grid.nodesOf, Grid.metadata, Grid.adjacent
local entrance, locate, standing, snap, smooth = Grid.entrance, Grid.locate, Grid.standing, Grid.snap, Grid.smooth
local zoneAt, chunkDanger = Grid.zoneAt, Grid.chunkDanger

local TILE, SNAP, ZTOL, DX, DY = Grid.TILE, Grid.SNAP, Grid.ZTOL, Grid.DX, Grid.DY
local RETRIES = 8 -- other cells tried for an endpoint stuck in a pocket
local DROP = 30 -- how far below its surface a stuck endpoint may move: one can jump down a ledge, never climb one
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
	local tag = (Costs.Profile(profile) or "") .. ":" .. style .. (kept and ":" .. signature or "")
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
-- times; weights) }. -> waterWalking, profile, style, danger
local function options(opts)
	if type(opts) == "table" then
		return opts.waterWalking, opts.profile, opts.style, opts.danger
	end
	return opts, nil, nil, nil
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

-- Where an entrance's decoded edges (PathGrid.lua's adjacent) keep a step's cost and yards: -> the values an edge,
-- the cost's offset and the yards' offset after the target. Format 2 prices an edge per profile (costNone without
-- one) and carries its yards; format 1 has one cost per water mode and its yards are that cost.
local function edgeFields(st, waterWalking, profile)
	if st.classed then
		local p = Costs.Profile(profile)
		return 5, p == "Alliance" and 1 or p == "Horde" and 2 or 3, 4
	end
	local c = waterWalking and 2 or 1
	return 3, c, c
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
-- Dijkstra that stops once every node in targets (a set of nodes) is settled.
local function Tree()
	return { g = {}, par = {}, stamp = {}, closed = {}, gen = 0, y = {} }
end
-- One grid search loop; splitting moves its retained arrays to upvalues on the hot path
local function search(st, k, swim, mult, source, tree, goal, targets, left)
	local val = grid(st, k)
	-- Search only enters populated grids, through snapped endpoints or decoded entrances.
	---@cast val number[]
	-- A paused search retains these arrays even if another job evicts its cluster.
	local m, z, at, links, cls = st.moves[k], st.z[k], st.at[k], st.links[k], mult and st.cls[k]
	local C, cs = st.C, st.cs
	local hs = cs * (mult and mult.min or 1) -- the cheapest yard: the heuristic never overstates
	local N = C * C
	-- Per chunk the zone multiplier of a step into it; nil when the cluster has no dangerous chunk (every search
	-- without danger).
	local dz = mult and mult.danger and chunkDanger(st, k, mult.danger)
	local g, par, stamp, closed, ys = tree.g, tree.par, tree.stamp, tree.closed, mult and tree.y
	tree.gen = tree.gen + 1
	local gen = tree.gen
	tree.k = k
	local gx, gy = 0, 0
	if goal then
		local cell = goal < N and goal or at[goal + 1]
		gx, gy = floor(cell / C), cell % C
	end
	hn = 0
	g[source + 1], par[source + 1], stamp[source + 1] = 0, -1, gen
	if ys then
		ys[source + 1] = 0
	end
	push(0, source)

	---@type number, number, number, number, number
	local u, ux, uy, gu, yu
	local function relax(v, length)
		local i = v + 1
		local gv
		if dz then
			local cell = v < N and v or at[i]
			gv = gu + length * cs * (cls and mult[cls[i]] or 1) * (val[i] == 2 and swim or 1)
				* dz[floor(floor(cell / C) * 16 / C) * 16 + floor(cell % C * 16 / C) + 1]
		else
			gv = gu + length * cs * (cls and mult[cls[i]] or 1) * (val[i] == 2 and swim or 1)
		end
		if stamp[i] ~= gen or gv < g[i] then
			g[i], par[i], stamp[i] = gv, u, gen
			if ys then
				ys[i] = yu + length * cs
			end
			local h = 0
			if goal then
				local cell = v < N and v or at[i]
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
		if closed[i] ~= gen then
			closed[i] = gen
			tick()
			if u == goal then
				return true
			end
			if targets and targets[u] then
				left = left - 1
				if left <= 0 then
					return true
				end
			end
			local cell = u < N and u or at[i]
			gu, ux, uy = g[i], floor(cell / C), cell % C
			if ys then
				yu = ys[i]
			end
			if u < N then
				local mi = m[i] % 16
				local px, mx = mi % 2 == 1, ux > 0 and m[i - C] % 2 == 1
				local py, my = mi % 4 >= 2, uy > 0 and m[i - 1] % 4 >= 2
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
				if ux > 0 and uy > 0 and m[i - C - 1] % 8 >= 4 then
					relax(u - C - 1, SQRT2)
				end
				if ux > 0 and uy < C - 1 and m[i - C + 1] % 16 >= 8 then
					relax(u - C + 1, SQRT2)
				end
			end
			local l = links[i]
			if l then
				for e = 1, #l do
					local d = l[e] % 8
					local tx, ty = ux + DX[d], uy + DY[d]
					if tx >= 0 and ty >= 0 and tx < C and ty < C then
						local v = surface(st, k, tx * C + ty, floor(l[e] / 8) - 1, z[i], val, z, at)
						if v then
							relax(v, d >= 4 and SQRT2 or 1)
						end
					end
				end
			end
		end
	end
	return goal == nil
end

local function reached(tree, node)
	return tree.stamp[node + 1] == tree.gen and tree.closed[node + 1] == tree.gen
end

-- The yards along a tree's path to node: its yards label on a map with classes, its cost on one without (format 1).
local function yardsAt(st, tree, node)
	return st.classed and tree.y[node + 1] or tree.g[node + 1]
end

-- Node path in a tree from node back to its source (node first).
local function trace(tree, node, out)
	local par = tree.par
	while node >= 0 do
		out[#out + 1] = node
		node = par[node + 1]
	end
	return out
end

local trees = { S = Tree(), G = Tree(), R = Tree() }

-- Abstract A* state.
local ag, ay, apar, astamp, aclosed, agen = {}, {}, {}, {}, {}, 0

-- Endpoint searches: grid Dijkstra to the cluster's entrances.
local function endpoint(st, swim, mult, tree, k, node)
	local targets, left = {}, 0
	for _, id in ipairs(nodesOf(st, k)) do
		local e = entrance(st, id)
		if e and not targets[e] then
			targets[e], left = true, left + 1
		end
	end
	search(st, k, swim, mult, node, tree, nil, targets, left)
end
-- An endpoint on a rooftop or ledge the grid cannot leave moves to the nearest node that reaches an entrance,
-- down a ledge but never up one or onto another level.
local function settle(st, swim, mult, tree, k, node)
	local C = st.C
	endpoint(st, swim, mult, tree, k, node)
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
	local tries = 0
	grid(st, k)
	local h = st.z[k][node + 1]
	local cell = cellOf(st, k, node)
	local lx, ly = floor(cell / C), cell % C
	for r = 1, SNAP do
		for dx = -r, r do
			for dy = -r, r do
				if tries >= RETRIES then
					return node
				end
				local x, y = lx + dx, ly + dy
				local ring = dx == r or dx == -r or dy == r or dy == -r
				if ring and x >= 0 and y >= 0 and x < C and y < C then
					local near = standing(st, k, x * C + y, h)
					local rise = near and st.z[k][near + 1] - h
					if near and rise <= ZTOL and rise >= -DROP and not reached(tree, near) then
						tries, node = tries + 1, near
						endpoint(st, swim, mult, tree, k, node)
						if connected() then
							return node
						end
					end
				end
			end
		end
	end
	return node
end

-- Both APIs connect endpoints with the same local search. Connections are outward at both ends, as in the
-- baked undirected graph; the same-cluster direct edge retains the grid's entering-water direction.
-- -> entrance costs and their yards, by entrance id.
local function connections(st, tree, k)
	local edges, yards = {}, {}
	for _, id in ipairs(nodesOf(st, k)) do
		local e = entrance(st, id)
		if e and reached(tree, e) then
			edges[id], yards[id] = tree.g[e + 1], yardsAt(st, tree, e)
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

-- Fixed places recur in both batches and in later journeys. Keep their small entrance-cost vectors and only the
-- last eight grid trees; cap the cache so moving start positions cannot grow it for the entire play session. A
-- connection is priced for one profile and style on a map with classes (mult.tag), for every one on a map without.
local function connect(st, swim, mult, k, node)
	nodesOf(st, k)
	local key = k .. ":" .. node .. ":" .. swim .. ":" .. (mult and mult.tag or "")
	local entry = st.ends[key]
	if not entry then
		local tree = Tree()
		node = settle(st, swim, mult, tree, k, node)
		local edges, yards = connections(st, tree, k)
		entry = { node = node, edges = edges, yards = yards, tree = tree }
		-- A handful of local trees removes repeated endpoint searches without retaining a continent's grids.
		st.endTrees = st.endTrees or {}
		st.endTrees[#st.endTrees + 1] = entry
		if #st.endTrees > 8 then
			table.remove(st.endTrees, 1).tree = nil
		end
		if st.endCount >= 256 then
			st.ends, st.endCount = {}, 0
		end
		st.ends[key], st.endCount = entry, st.endCount + 1
	end
	return entry.node, entry.edges, entry.tree, entry.yards
end

-- A point without a height (a map click, or the player while Polestar's walking floor is unknown: UnitPosition's
-- height is a placeholder 0, so Nav/Walk.lua usually sends the floor it follows under the player, Path.SurfacesAt)
-- could stand on any surface at its spot, so it starts from each one within a cell of it at a distinct height and the
-- search keeps the cheapest: a street beside or over a canal is not walked from the canal bed, but a rock top or roof
-- over the player may be walked from (#234). Returns each surface's connection, the entrance costs merged by minimum,
-- per entrance the surface it came from, and the merged costs' yards.
local function connectPoint(st, swim, mult, k, node, h)
	local nodes = { node }
	if not h then
		local values = grid(st, k)
		assert(values)
		local C, val, z, at = st.C, values, st.z[k], st.at[k]
		local cell = cellOf(st, k, node)
		local lx, ly = floor(cell / C), cell % C
		local function consider(n, r)
			-- A neighbour's water is where the point is not: it would be standing in it.
			if r > 0 and val[n + 1] == 2 then
				return
			end
			for _, m in ipairs(nodes) do
				if abs(z[n + 1] - z[m + 1]) <= ZTOL then
					return
				end
			end
			nodes[#nodes + 1] = n
		end
		for r = 0, 1 do
			for dx = -r, r do
				for dy = -r, r do
					local x, y = lx + dx, ly + dy
					if (dx == r or dx == -r or dy == r or dy == -r) and x >= 0 and y >= 0 and x < C and y < C then
						local c = x * C + y
						if val[c + 1] ~= 0 then
							consider(c, r)
						end
						local n = at[-(c + 1)]
						while n and at[n + 1] == c do
							consider(n, r)
							n = n + 1
						end
					end
				end
			end
		end
	end
	local ends, merged, via, yards = {}, {}, {}, {}
	for _, start in ipairs(nodes) do
		local n, edges, tree, edgeYards = connect(st, swim, mult, k, start)
		ends[#ends + 1] = { node = n, tree = tree }
		for id, cost in pairs(edges) do
			if not merged[id] or cost < merged[id] then
				merged[id], via[id], yards[id] = cost, ends[#ends], edgeYards[id]
			end
		end
	end
	return ends, merged, via, yards
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
				local t = enters(points[i - 1], points[i], hub.disks or {})
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
-- Sliced A* and refinement share scratch trees; splitting adds hot-path calls and upvalues
local function run(map, from, to, waterWalking, costOnly, profile, job, style, danger)
	local st = State(map)
	if not st then
		return nil, "nodata"
	end
	-- Walking on water is running, so the search weights water by 1 (and a format 1 map reads each edge's second
	-- cost).
	local swim = waterWalking and 1 or st.swim
	local stride, ci, yi = edgeFields(st, waterWalking, profile)
	local mult, hmin = weights(st, profile, style, danger)
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
	local starts, source, sourceVia, sourceYards = connectPoint(st, swim, mult, sk, sc, from.z)
	local goals, target, targetVia, targetYards = connectPoint(st, swim, mult, gk, gc, to.z)
	local key = table.concat({ sk, sc, gk, gc, swim, from.z and 1 or 0, to.z and 1 or 0, mult and mult.tag or "" }, ":")
	st.paths = st.paths or {}
	local cached = st.paths[key]
	local hops, cost, yards, directFrom, directTo
	local x0, y0, cs = st.x0, st.y0, st.cs
	if cached then
		hops, cost, yards, directFrom, directTo = cached.hops, cached.cost, cached.yards, cached.directFrom, cached.directTo
	else
		local direct, directYards
		if sk == gk then
			for _, a in ipairs(starts) do
				for _, b in ipairs(goals) do
					if search(st, sk, swim, mult, a.node, S, b.node) and (not direct or S.g[b.node + 1] < direct) then
						direct, directYards, directFrom, directTo = S.g[b.node + 1], yardsAt(st, S, b.node), a.node, b.node
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
		if not direct and not shared then
			return nil, "unreachable"
		end

		-- Abstract A* from START to GOAL through the entrance graph.
		local function world(id)
			local k, lc = floor(id / 4096), metadata(st, id)
			return x0 + (floor(k / st.ny) * C + floor(lc / C) + 0.5) * cs, y0 + ((k % st.ny) * C + lc % C + 0.5) * cs
		end
		-- Rounded graph edges, snapping and, with classes, a yard cheaper than running (hmin) must not let the
		-- heuristic overstate the remaining cost.
		local goalCell = cellOf(st, gk, gc)
		local goalX = x0 + (floor(gk / st.ny) * C + floor(goalCell / C) + 0.5) * cs
		local goalY = y0 + (gk % st.ny * C + goalCell % C + 0.5) * cs
		local lower = max(0, 1 - 0.5 / cs) * hmin
		local function h(id)
			local x, y = world(id)
			local dx, dy = abs(x - goalX), abs(y - goalY)
			return (dx > dy and dx + (SQRT2 - 1) * dy or dy + (SQRT2 - 1) * dx) * lower
		end
		agen = agen + 1
		local gen = agen
		hn = 0
		local function relax(v, gv, yv, parent)
			if astamp[v] ~= gen or gv < ag[v] then
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
				local gu, yu = ag[u], ay[u]
				if target[u] then
					relax(GOAL, gu + target[u], yu + targetYards[u], u)
				end
				nodesOf(st, floor(u / 4096))
				local adj = adjacent(st, u)
				for e = 1, #adj, stride do
					local v = adj[e]
					if aclosed[v] ~= gen then
						nodesOf(st, floor(v / 4096))
						relax(v, gu + (edged and adj[e + ci] * edged(u, v) or adj[e + ci]), yu + adj[e + yi], u)
					end
				end
			end
		end
		if not found then
			return nil, "unreachable"
		end
		cost, yards = ag[GOAL], ay[GOAL]
		hops = { GOAL }
		while hops[#hops] ~= START do
			hops[#hops + 1] = apar[hops[#hops]]
		end

		if (st.pathCount or 0) >= 16 then
			st.paths, st.pathCount = {}, 0
		end
		st.paths[key] = { hops = hops, cost = cost, yards = yards, directFrom = directFrom, directTo = directTo }
		st.pathCount = (st.pathCount or 0) + 1
	end
	if costOnly then
		job.yards = yards
		return cost
	end

	-- Refine each hop into nodes with their global cells and a running count of water nodes. The pruned entrance
	-- graph may route through an entrance a little off the way, which refines to a spur walked out and back: a node
	-- reached again cuts the loop since its first visit, so the drawn walk never doubles back.
	local P = { x = {}, y = {}, w = {}, k = {}, n = {} }
	local seen = {}
	local function add(k, node)
		local id = k * 1048576 + node
		local at = seen[id]
		if at then
			for j = #P.x, at + 1, -1 do
				seen[P.k[j] * 1048576 + P.n[j]] = nil
				P.x[j], P.y[j], P.w[j], P.k[j], P.n[j] = nil, nil, nil, nil, nil
			end
			return
		end
		local n = #P.x
		local cell = node < C * C and node or cellOf(st, k, node)
		P.x[n + 1], P.y[n + 1] = floor(k / st.ny) * C + floor(cell / C), (k % st.ny) * C + cell % C
		P.k[n + 1], P.n[n + 1] = k, node
		P.w[n + 1] = (P.w[n] or 0) + ((st.val[k] or grid(st, k))[node + 1] == 2 and 1 or 0)
		seen[id] = n + 1
	end
	local function addAll(k, nodes, first, last, step)
		for i = first, last, step do
			add(k, nodes[i])
		end
	end
	local R = trees.R
	for i = #hops, 2, -1 do
		local a, b = hops[i], hops[i - 1]
		if a == START and b == GOAL then
			search(st, sk, swim, mult, directFrom, S, directTo)
			local nodes = trace(S, directTo, {})
			addAll(sk, nodes, #nodes, 1, -1)
		elseif a == START then
			local start = sourceVia[b]
			local tree = start.tree
			if not tree or not reached(tree, entrance(st, b)) then
				search(st, sk, swim, mult, start.node, S, entrance(st, b))
				tree = S
			end
			local nodes = trace(tree, entrance(st, b), {})
			addAll(sk, nodes, #nodes, 1, -1)
		elseif b == GOAL then
			local goal = targetVia[a]
			local tree = goal.tree
			if not tree or not reached(tree, entrance(st, a)) then
				search(st, gk, swim, mult, goal.node, G, entrance(st, a))
				tree = G
			end
			local nodes = trace(tree, entrance(st, a), {})
			addAll(gk, nodes, 1, #nodes, 1)
		else
			local ka, kb = floor(a / 4096), floor(b / 4096)
			local ea, eb = entrance(st, a), entrance(st, b)
			if ka == kb and search(st, ka, swim, mult, ea, R, eb) then
				local nodes = trace(R, eb, {})
				addAll(ka, nodes, #nodes, 1, -1)
			else -- neighbouring entrances across a cluster border
				add(ka, ea)
				add(kb, eb)
			end
		end
	end

	-- Points carry the height of the surface they stand on; the cost weights water as the search did, and points.wet
	-- is the yards over water, which call for Water Walking. Straightening keeps to ground no costlier for profile in
	-- style (and danger) than the path it replaces and out of hostile hub cells the path kept out of (smooth).
	local keep = smooth(st, P, profile, style, mult and mult.danger)
	if #keep == 1 then -- both ends on one node
		keep[2] = keep[1]
	end
	local points = { { map = map, x = from.x, y = from.y, z = from.z } }
	for i = 2, #keep - 1 do
		local j = keep[i]
		grid(st, P.k[j])
		points[#points + 1] = {
			map = map,
			x = x0 + (P.x[j] + 0.5) * cs,
			y = y0 + (P.y[j] + 0.5) * cs,
			z = st.z[P.k[j]][P.n[j] + 1],
		}
	end
	points[#points + 1] = { map = map, x = to.x, y = to.y, z = to.z }
	local wetYards, drawnYards = 0, 0
	for i = 2, #points do
		local p, q = keep[i - 1], keep[i]
		local wet = q > p and (P.w[q] - P.w[p]) / (q - p) or 0
		local length = sqrt((points[i].x - points[i - 1].x) ^ 2 + (points[i].y - points[i - 1].y) ^ 2)
		wetYards, drawnYards = wetYards + length * wet, drawnYards + length
	end
	points.wet = wetYards
	job.yards, job.hubs = drawnYards, hubsOn(st.D.hubs, points, profile)
	-- Smoothing only changes drawing: planning and FindMany use the identical graph cost.
	return points, cost
end

-- Lazy terminal-node connections let nearby targets settle without first searching every faraway endpoint.
-- One sliced Dijkstra owns the heap swap and frontier locals across endpoint searches
local function runMany(map, from, targets, waterWalking, reverse, job, profile, style, danger)
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
	local stride, ci, yi = edgeFields(st, waterWalking, profile)
	local mult = weights(st, profile, style, danger)
	local edged = edgeDanger(st, mult)
	local starts, source, _, sourceYards = connectPoint(st, swim, mult, sk, sc, from.z)
	local clusters, links, dist, dyards, closed, left = {}, {}, {}, {}, {}, #targets
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
		-- Local searches need their own heap, including across a yield midway through a connection.
		local keys, values, size = hk, hv, hn
		hk, hv, hn = {}, {}, 0
		local direct, directYards, ends, endYards = {}, {}, {}, {}
		for _, i in ipairs(list) do
			local _, node = pointNode(st, targets[i])
			if node then
				local goals, _
				goals, ends[i], _, endYards[i] = connectPoint(st, swim, mult, k, node, targets[i].z)
				for _, a in ipairs(k == sk and starts or {}) do
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
							cost, yd = tree.g[last + 1], yardsAt(st, tree, last)
						elseif search(st, k, swim, mult, first, trees.R, last) then
							cost, yd = trees.R.g[last + 1], yardsAt(st, trees.R, last)
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
			else
				local k = floor(u / 4096)
				prepare(k)
				local ends = links[u]
				for i = 1, ends and #ends or 0, 3 do
					relax(ends[i], dist[u] + ends[i + 1], dyards[u] + ends[i + 2])
				end
				nodesOf(st, k)
				local adj = adjacent(st, u)
				for e = 1, #adj, stride do
					local v = adj[e]
					if not closed[v] then
						if edged then
							nodesOf(st, floor(v / 4096))
						end
						relax(v, dist[u] + (edged and adj[e + ci] * edged(u, v) or adj[e + ci]), dyards[u] + adj[e + yi])
					end
				end
			end
		end
		if job then
			job.radius = hn > 0 and hk[1] or huge
		end
		tick()
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
function Path.ReuseMany(job, point, profile, style, danger)
	if not job or job.map ~= point.map or not job.sourceNode or Costs.Profile(job.profile) ~= Costs.Profile(profile)
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

-- Path.SurfacesAt's marks, and a node's (its class byte read from the decoded cluster's cls).
Path.SURFACE_WATER, Path.SURFACE_INDOOR = 1, 2
local INDOOR, CITY = Costs.CLASS.INDOOR, Costs.CLASS.CITY
local function marks(val, cls, node)
	local c = cls[node + 1] % 8
	return (val[node + 1] == 2 and 1 or 0) + ((c == INDOOR or c == CITY) and 2 or 0)
end

-- The walkable surfaces of the cell under a world point on map: its base surface and its floors, base first, each
-- surface's height in out[i] and its marks in out[-i]: SURFACE_WATER (1) when it is water, plus SURFACE_INDOOR (2)
-- when its ground class is indoor or an indoor city (Costs.CLASS INDOOR, CITY; never on a map without classes).
-- -> n, 0 outside the map's data, in a cluster without data or a cell with no walkable surface; nil while the cell's
-- cluster is not decoded: the read never decodes, it queues Path.Prefetch for it (decoded under the frame budget, as
-- a search's clusters are) and a later read finds it. The caller's out is reused (nothing is allocated; entries past
-- n are left as they were). The cluster read last stays decoded at rest (PathGrid's reader) until
-- Path.ReleaseSurfaces().
---@param map number
---@param x number
---@param y number
---@param out table
---@return number?
function Path.SurfacesAt(map, x, y, out)
	local st = State(map)
	if not st then
		Grid.dropRead()
		return 0
	end
	local k, lc = locate(st, x, y)
	if not k then
		Grid.dropRead()
		return 0
	end
	local val = st.val[k]
	if val == nil then
		Grid.wantRead(st, k)
		Path.Prefetch(map, x, y)
		return nil
	end
	if not val then
		Grid.dropRead()
		return 0
	end
	Grid.keepRead(st, k)
	local z, at, cls, n = st.z[k], st.at[k], st.cls[k], 0
	if val[lc + 1] ~= 0 then
		n = 1
		out[1], out[-1] = z[lc + 1], marks(val, cls, lc)
	end
	local node = at[-(lc + 1)]
	while node and at[node + 1] == lc do
		if val[node + 1] ~= 0 then
			n = n + 1
			out[n], out[-n] = z[node + 1], marks(val, cls, node)
		end
		node = node + 1
	end
	return n
end

local function start(job)
	if job.prefetch then
		Grid.prefetch(job.st, job.k)
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
	if job.targets then
		return runMany(job.map, job.from, job.targets, job.waterWalking, job.reverse, job, job.profile, job.style, job.danger)
	end
	return run(job.map, job.from, job.to, job.waterWalking, job.costOnly, job.profile, job, job.style, job.danger)
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
		trees = { S = Tree(), G = Tree(), R = Tree() }
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
	local waterWalking, profile, style, danger = options(opts)
	local job = { map = map, from = from, to = to, waterWalking = waterWalking, profile = profile, style = style, danger = danger }
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
	local waterWalking, profile, style, danger = options(opts)
	local costs, reason, yards = runMany(map, from, targets, waterWalking, reverse, nil, profile, style, danger)
	scratch(saved)
	return costs, reason, Expansions(), yards
end

-- PathJobs.lua resumes start in a coroutine between scratch swaps; a finished search's scratch is kept as spare.
---@class SPFPathSearch
ns.PathSearch = {
	start = start,
	options = options,
	scratch = scratch,
	Spare = function(saved)
		spare = saved
	end,
}
