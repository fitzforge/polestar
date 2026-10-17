-- Polestar's walking router. Started from Shortest Path Forever v1.16.0 (b1ad5bd) by Cillian Berragan (GPL-3.0-or-later); modified for Polestar since 2026-10-16.
-- Routing/PathGrid.lua: Copyright (C) 2026 Cillian Berragan (https://github.com/cjber/shortest-path-forever); Polestar's
-- changes Copyright (c) 2026 The Polestar authors. This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3
-- of the License, or (at your option) any later version. It is distributed WITHOUT ANY WARRANTY; see the GNU General
-- Public License in this folder's LICENSE.
---@class SPFNamespace
local ns = select(2, ...)

-- Walking routes over a continent's collision map: HPA* between ADT-tile clusters, an 8 yd grid inside them,
-- then string-pulling so the drawn line is not jagged. FindMany resolves costs in one abstract Dijkstra.
-- Costs use the graph and local grid weights; smoothing changes only the drawing.
-- Coordinates are UnitPosition's frame (x north, y west).
-- A cell holds its base surface and, where surfaces overlap (a tunnel under a mountain, a city under ruins, both
-- ends of a lift), floors above or below it. A node is a local cell (the base surface) or C * C + a floor's index.
-- A map of format 2 also carries a ground class byte per node (the class field, Routing/Costs.lua) and graph edges
-- priced per profile with their yards (adjacent), and may carry the zone of each cluster's 16 x 16 chunks (the zone
-- field, zoneAt); format 1 maps (0.2.4's) have no classes (class 0 everywhere) and one edge cost for every profile.
-- This file holds the decoded maps, their memory ceilings, frame slicing and string-pulling; Path.lua searches them
-- and PathJobs.lua schedules the searches.
---@class SPFPath
local Path = {}
ns.Path = Path

Path.budget = 2 -- milliseconds of path work, leaving headroom under the 3 ms frame ceiling
Path.clusters = 64 -- secondary count ceiling per map (at least 4)
Path.graphKB = 4096 -- decoded entrances/edges across all maps while a search runs
Path.graphRestKB = 4096 -- the same with no search queued (Idle trims to it)
Path.cacheKB = 24576 -- decoded grids across all maps; active coroutine locals are additional
Path.clock = debugprofilestop or function()
	return os.clock() * 1000
end

local TILE = 1600 / 3
local SNAP = 6 -- cells searched around an off-grid endpoint
local ZTOL = 10 -- an endpoint stands on a surface within this height (yd)
local CHECK = 64 -- expansions between clock reads
local EDGE1, EDGE2 = 7, 14 -- symbols in a graph edge record of format 1 and format 2 (adjacent)

local byte, floor, sqrt, huge, max, abs = string.byte, math.floor, math.sqrt, math.huge, math.max, math.abs
local yield = coroutine.yield
local Costs = ns.Costs -- Routing/Costs.lua loads first
local Mult = Costs.Mult

local B64 = {}
do
	local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	for i = 1, 64 do
		B64[byte(alphabet, i)] = i - 1
	end
end

local function num(s, i, width)
	local a, b, c = byte(s, i, i + width - 1)
	local value = B64[a] * 64 + B64[b]
	return width == 2 and value or value * 64 + B64[c]
end

-- Slicing yields at the shared deadline; pump swaps each coroutine's private search scratch before resuming it.
local deadline, ops, expansions = huge, 0, 0
local clock = function()
	return Path.clock()
end

local function slice()
	if deadline < huge and clock() > deadline then
		yield()
	end
end

Path.Checkpoint = slice

local function tick()
	expansions = expansions + 1
	ops = ops + 1
	if ops >= CHECK then
		ops = 0
		slice()
	end
end

-- Pump and the synchronous searches arm the deadline; math.huge never yields.
local function Deadline(limit)
	deadline, ops = limit, 0
end

-- The running expansion count, replaced when count is given.
local function Expansions(count)
	expansions = count or expansions
	return expansions
end

-- Compressed terrain is bundled with the main addon; decoded clusters stay lazy.
local function Data(map)
	return PolestarPathData and PolestarPathData[map]
end

local states = {}

-- A field's string for cluster key (k + 1), decoded on first use; nil when the map lacks it (format 1 has no class
-- field) or the cluster has none.
local function unpackField(data, field, key)
	local loose = data[field]
	if loose == nil then
		if not (data.packed and data.packed[field]) then
			return nil
		end
		loose = {}
		data[field] = loose
	end
	if loose[key] or not data.packed then
		return loose[key]
	end
	local blocks = data.packed[field][key]
	if not blocks then
		return nil
	end
	local chunks = {}
	for i, block in ipairs(blocks) do
		slice()
		local compressed = C_EncodingUtil.DecodeBase64(block)
		local raw = compressed and C_EncodingUtil.DecompressString(compressed, Enum.CompressionMethod.Zlib)
		if not raw then
			return nil
		end
		chunks[i] = raw
	end
	local raw = table.concat(chunks)
	loose[key] = raw
	return raw
end

-- Does a map's data carry ground classes (format 2)?
local function Classed(D)
	return D.class ~= nil or (D.packed ~= nil and D.packed.class ~= nil)
end

local function State(map)
	local st = states[map]
	if st == nil then
		local D = Data(map)
		if states[map] then
			return states[map]
		end
		if not D then
			return nil
		end
		local C = D.cells
		st = {
			D = D,
			map = map,
			C = C,
			ny = D.ny,
			GX = D.nx * C,
			GY = D.ny * C,
			x0 = D.cx0 * TILE,
			y0 = D.cy0 * TILE,
			cs = TILE / C,
			swim = D.swim,
			zstep = D.zstep,
			classed = Classed(D), -- format 2: Path.lua prices steps by class (and style) and the heuristic by its least
			zoned = D.zone ~= nil, -- the zone field: Path.lua prices a step into a zone by its caller's danger table
			sizes = {},
			used = {}, -- [k] = last use, for eviction
			decoded = 0,
			val = {}, -- [k] = node values (node + 1), false when the cluster has no data
			moves = {}, -- [k][lc + 1] = open moves inside the cluster + 16 * the data file's step flags
			z = {}, -- [k][node + 1] = height of a walkable node
			at = {}, -- [k][node + 1] = a floor's local cell; [k][-(lc + 1)] = the cell's first floor node
			links = {}, -- [k][node + 1] = { direction + 8 * (layer + 1), ... } steps besides the base grid's
			cls = {}, -- [k][node + 1] = ground class byte (Routing/Costs.lua); ZERO for a cluster without classes
			graphUsed = {},
			graphSize = {},
			nodes = {}, -- [k] = entrance ids (k * 4096 + i)
			ncell = {}, -- [id] = local cell
			nlayer = {}, -- [id] = 0 for the base surface, i for the cell's ith floor
			ncomp = {},
			ends = {}, -- bounded local connections, shared by successive endpoint batches
			endCount = 0,
			nadj = {}, -- [id] = decoded edges, adjacent's layout (format 1: 3 values an edge, format 2: 5)
		}
		states[map] = st
	end
	return st
end

-- Directions of floor links: +x, -x, +y, -y, +x+y, +x-y, -x+y, -x-y.
local DX = { [0] = 1, -1, 0, 0, 1, 1, -1, -1 }
local DY = { [0] = 0, 0, 1, -1, 1, -1, 1, -1 }
local OPPOSITE = { [0] = 1, 0, 3, 2, 7, 6, 5, 4 }
local DIRECTION = {} -- [(dx + 1) * 3 + dy + 1] = direction
for d = 0, 7 do
	DIRECTION[(DX[d] + 1) * 3 + DY[d] + 1] = d
end

-- The node on local cell lc for a link layer (0 the base surface, i the ith floor up, -1 the surface nearest
-- height h), with its height gap for -1. The cluster must be decoded.
local function surface(st, k, lc, layer, h, values, heights, floors)
	local val, z, at = values or st.val[k], heights or st.z[k], floors or st.at[k]
	local first = at[-(lc + 1)]
	if layer == 0 then
		return val[lc + 1] ~= 0 and lc or nil
	elseif layer > 0 then
		local node = first and first + layer - 1
		return node and at[node + 1] == lc and node or nil
	end
	local best, gap
	if val[lc + 1] ~= 0 then
		best, gap = lc, abs(z[lc + 1] - h)
	end
	local node = first
	while node and at[node + 1] == lc do
		if not gap or abs(z[node + 1] - h) < gap then
			best, gap = node, abs(z[node + 1] - h)
		end
		node = node + 1
	end
	return best, gap
end

-- Floor step masks recur thousands of times. Share the common immutable link sets;
-- the few nodes with additional explicit links copy on write.
local linkSets, directionBits = {}, {}
for _, layer in ipairs({ -1, 1 }) do
	linkSets[layer] = setmetatable({}, {
		__index = function(set, mask)
			if mask == 0 then
				return nil
			end
			local links, bits = { shared = layer, mask = mask }, mask
			for d = 0, 7 do
				if bits % 2 == 1 then
					links[#links + 1] = d + 8 * (layer + 1)
				end
				bits = floor(bits / 2)
			end
			set[mask] = links
			return links
		end,
	})
end
for d = 0, 7 do
	directionBits[d] = 2 ^ d
end
local stepLinks = linkSets[-1]

local function addLink(links, node, d, layer)
	local l = links[node + 1]
	local set = linkSets[layer]
	if set and (not l or l.shared == layer) then
		local mask, bit = l and l.mask or 0, directionBits[d]
		if floor(mask / bit) % 2 == 0 then
			mask = mask + bit
		end
		links[node + 1] = set[mask]
		return
	end
	if not l then
		l = {}
		links[node + 1] = l
	elseif l.shared then
		local copy = {}
		for i = 1, #l do
			copy[i] = l[i]
		end
		l, links[node + 1] = copy, copy
	end
	l[#l + 1] = d + 8 * (layer + 1)
end

local function decodeHeights(st, val, z, s)
	local C, step = st.C, st.zstep
	local pos, rep, delta, last = 1, 0, 0, 0
	for i = 1, C * C do
		if i % 256 == 0 then
			slice()
		end
		if val[i] ~= 0 then
			local a = i - 1
			local pred = (a % C > 0 and z[i - 1] and z[i - 1] / step)
				or (a >= C and z[i - C] and z[i - C] / step)
				or last
			local v
			if rep > 0 then
				rep, v = rep - 1, pred + delta
			else
				local sym = B64[byte(s, pos)]
				if sym == 47 then
					v, pos = num(s, pos + 1, 2) - 2048, pos + 3
				else
					delta, pos = sym - 23, pos + 1
					while pos <= #s and B64[byte(s, pos)] >= 48 do
						rep, pos = rep + B64[byte(s, pos)] - 47, pos + 1
					end
					v = pred + delta
				end
			end
			last, z[i] = v, v * step
		end
	end
end

local function decodeFloors(st, k, val, z, chunks)
	local at, links = {}, {}
	if not chunks then
		return at, links
	end
	local s, C = chunks, st.C
	local node, pos = C * C, 4
	for _ = 1, num(s, 1, 3) do
		local lc, count = num(s, pos, 3), B64[byte(s, pos + 3)]
		pos = pos + 4
		at[-(lc + 1)] = node
		for _ = 1, count do
			if node % 64 == 0 then
				slice()
			end
			val[node + 1], z[node + 1], at[node + 1] = B64[byte(s, pos)], num(s, pos + 1, 2) - 2048, lc
			links[node + 1] = stepLinks[num(s, pos + 3, 2)]
			pos, node = pos + 5, node + 1
		end
	end
	local last = node
	for i = 1, num(s, pos, 3) do
		if i % 64 == 0 then
			slice()
		end
		addLink(links, num(s, pos + 3, 3), B64[byte(s, pos + 6)], B64[byte(s, pos + 7)])
		pos = pos + 5
	end
	-- A base cell's links to floors inside the cluster are the reverse of the floors' own.
	for f = C * C, last - 1 do
		if f % 64 == 0 then
			slice()
		end
		local l, lc = links[f + 1], at[f + 1]
		local layer = f - at[-(lc + 1)] + 1
		for e = 1, l and #l or 0 do
			local d = l[e] % 8
			local tx, ty = floor(lc / C) + DX[d], lc % C + DY[d]
			if tx >= 0 and ty >= 0 and tx < C and ty < C then
				local t = surface(st, k, tx * C + ty, floor(l[e] / 8) - 1, z[f + 1], val, z, at)
				if t and t < C * C then
					addLink(links, t, OPPOSITE[d], layer)
				end
			end
		end
	end
	return at, links
end

-- Every node of a cluster without classes (a format 1 map, or a format 2 cluster the field skips) is class 0. Shared
-- and never written: a search reads it like a decoded class array.
local ZERO = setmetatable({}, {
	__index = function()
		return 0
	end,
	__newindex = function()
		error("PathGrid: the shared class-0 table is read-only")
	end,
})

-- The class field of a cluster: one byte per node in node order, run-length like the grid field (a symbol >= 48
-- repeats the previous value (symbol - 47) more times); nodes past its end (floors it does not cover) are class 0.
local function decodeClasses(s, nodes)
	local cls, n, value = {}, 0, 0
	for i = 1, #s do
		if i % 256 == 0 then
			slice()
		end
		local sym = B64[byte(s, i)]
		if sym < 48 then
			value, n = sym, n + 1
			cls[n] = value
		else
			for _ = 48, sym do
				n = n + 1
				cls[n] = value
			end
		end
	end
	for i = n + 1, nodes do
		cls[i] = 0
	end
	return cls
end

local function decodeGrid(st, k)
	Path.decodes = (Path.decodes or 0) + 1
	local chunks = unpackField(st.D, "grid", k + 1)
	if not chunks then
		st.val[k] = false
		return false
	end
	local s, C = chunks, st.C
	local height = unpackField(st.D, "height", k + 1)
	if not height then
		st.val[k] = false
		return false
	end
	local floors = unpackField(st.D, "floor", k + 1)
	if st.D.packed and st.D.packed.floor[k + 1] and not floors then
		st.val[k] = false
		return false
	end
	local classes = st.classed and unpackField(st.D, "class", k + 1)
	if st.classed and st.D.packed and st.D.packed.class and st.D.packed.class[k + 1] and not classes then
		st.val[k] = false
		return false
	end
	local val, m = {}, {}
	local n, valueCode, moveCode = 0, 0, 0
	for i = 1, #s do
		if i % 256 == 0 then
			slice()
		end
		local sym = B64[byte(s, i)]
		if sym < 48 then
			valueCode, moveCode = floor(sym / 16), (sym % 16) * 16
			n = n + 1
			val[n], m[n] = valueCode, moveCode
		else
			for _ = 48, sym do
				n = n + 1
				val[n], m[n] = valueCode, moveCode
			end
		end
	end
	-- m[i] packs the open moves (1 = +x, 2 = +y, 4 = +x+y, 8 = +x-y) over the data flags * 16.
	local N = C * C
	-- Descending cells let diagonals reuse their forward neighbours' decoded moves in the same pass.
	for a = N - 1, 0, -1 do
		if a % 256 == 0 then
			slice()
		end
		local i, ly = a + 1, a % C
		local f = m[i] / 16
		if val[i] ~= 0 then
			if a + C < N and val[i + C] ~= 0 and f % 2 == 0 then
				m[i] = m[i] + 1
			end
			if ly < C - 1 and val[i + 1] ~= 0 and f % 4 < 2 then
				m[i] = m[i] + 2
			end
		end
		-- Diagonals: either L-shaped detour open, or an explicit link.
		if a + C < N and val[i] ~= 0 then
			if
				ly < C - 1
				and val[i + C + 1] ~= 0
				and ((m[i] % 2 == 1 and m[i + C] % 4 >= 2) or (m[i] % 4 >= 2 and m[i + 1] % 2 == 1) or f % 8 >= 4)
			then
				m[i] = m[i] + 4
			end
			if
				ly > 0
				and val[i + C - 1] ~= 0
				and (
					(m[i] % 2 == 1 and m[i + C - 1] % 4 >= 2)
					or (val[i - 1] ~= 0 and m[i - 1] % 64 < 32 and m[i - 1] % 32 < 16)
					or f >= 8
				)
			then
				m[i] = m[i] + 8
			end
		end
	end
	local z = {}
	decodeHeights(st, val, z, height)
	local at, links = decodeFloors(st, k, val, z, floors)
	return val, m, z, at, links, classes and decodeClasses(classes, #val) or ZERO
end

-- Lua 5.1 array slots occupy 16 bytes and grow by powers of two. Charge sparse floor/link hashes
-- conservatively too; this is a memory ceiling across continents, not a cluster count estimate.
local useClock, decodedKB, decodedCount = 0, 0, 0
local function gridSize(val, at, links, cls)
	local capacity = 1
	while capacity < #val do
		capacity = capacity * 2
	end
	local bytes = capacity * 16 * (cls == ZERO and 3 or 4) + 5 * 64
	for _ in pairs(at) do
		bytes = bytes + 64
	end
	for _, link in pairs(links) do
		bytes = bytes + 128 + #link * 32
	end
	return bytes / 1024
end

local function evict(st, oldest)
	decodedKB, decodedCount = decodedKB - st.sizes[oldest], decodedCount - 1
	st.sizes[oldest], st.used[oldest] = nil, nil
	st.val[oldest], st.moves[oldest], st.z[oldest], st.at[oldest], st.links[oldest] = nil, nil, nil, nil, nil
	st.cls[oldest] = nil
	st.decoded = st.decoded - 1
end

local function trim(st, size)
	while (decodedKB + size > Path.cacheKB and decodedCount >= 4) or st.decoded >= max(Path.clusters, 4) do
		local owner, oldest, age = nil, nil, huge
		for _, candidate in pairs(states) do
			if st.decoded < max(Path.clusters, 4) or candidate == st then
				for k, used in pairs(candidate.used) do
					if used < age then
						owner, oldest, age = candidate, k, used
					end
				end
			end
		end
		if not owner or not oldest then
			break
		end
		evict(owner, oldest)
	end
end

local function grid(st, k)
	local val = st.val[k]
	if val == nil then
		local m, z, at, links, cls
		val, m, z, at, links, cls = decodeGrid(st, k)
		-- Decoding may yield; only complete grids are published to concurrent searches.
		if st.val[k] ~= nil then
			return grid(st, k)
		end
		if not val then
			return false
		end
		local size = gridSize(val, at, links, cls)
		trim(st, size)
		st.val[k], st.moves[k], st.z[k], st.at[k], st.links[k], st.cls[k] = val, m, z, at, links, cls
		st.sizes[k], st.decoded, decodedKB = size, st.decoded + 1, decodedKB + size
		decodedCount = decodedCount + 1
		if st.D.packed then
			st.D.grid[k + 1], st.D.height[k + 1], st.D.floor[k + 1] = nil, nil, nil
			if st.D.class then
				st.D.class[k + 1] = nil
			end
		end
	end
	if val then
		useClock = useClock + 1
		st.used[k] = useClock
	end
	return val
end

-- The cluster Path.SurfacesAt reads (the player's, for Polestar's walking floor): never decoded by the read itself,
-- only by Path.Prefetch's job under the frame budget (prefetch, run from PathJobs as a search is). The reader keeps
-- at most one cluster: the one the player stands in, read last. A read of another decoded cluster makes it the
-- reader's at once and evicts the old one unless a search has used it since (its use stamp moved: the search's now,
-- Idle drops it later). A Prefetch that lands takes the slot only when its cluster is still the one read last (walked
-- A to B and back to A before B landed: A stays, Idle drops B). Idle keeps the reader's cluster (the floor reads it
-- again within a quarter second); Path.ReleaseSurfaces drops it when the caller stops reading (Walk.lua: no target, or
-- no arrow update for 2 s).
local reader = {} -- { st, k, use } the cluster kept; { wantSt, wantK } the cluster read last
local function drop()
	local st, k = reader.st, reader.k
	if st and states[st.map] == st and st.used[k] ~= nil and st.used[k] == reader.use then
		evict(st, k)
	end
	reader.st, reader.k, reader.use, reader.wantSt, reader.wantK = nil, nil, nil, nil, nil
end
-- Cluster k of st is the one read last (decoded or not).
local function wantRead(st, k)
	reader.wantSt, reader.wantK = st, k
end
-- Cluster k of st, decoded, is read: the reader's.
local function keepRead(st, k)
	if reader.st ~= st or reader.k ~= k then
		drop()
		reader.st, reader.k, reader.use = st, k, st.used[k]
	end
	reader.wantSt, reader.wantK = st, k
end
-- Path.Prefetch's job: decode cluster k of st (slicing under the job's deadline); the reader's if still read last.
local function prefetch(st, k)
	if grid(st, k) and reader.wantSt == st and reader.wantK == k then
		keepRead(st, k)
	end
end

-- A node's local cell.
local function cellOf(st, k, node)
	if node < st.C * st.C then
		return node
	end
	grid(st, k)
	return st.at[k][node + 1]
end

local graphKB, graphClock = 0, 0
local function trimGraphs(limit)
	while graphKB > (limit or Path.graphKB) do
		local owner, oldest, age = nil, nil, huge
		for _, st in pairs(states) do
			for k, used in pairs(st.graphUsed) do
				if used < age then
					owner, oldest, age = st, k, used
				end
			end
		end
		if not owner or not oldest then
			break
		end
		for _, id in ipairs(owner.nodes[oldest]) do
			owner.ncell[id], owner.nlayer[id], owner.ncomp[id], owner.nadj[id] = nil, nil, nil, nil
		end
		if owner.D.packed then
			owner.D.graph[oldest + 1] = nil
		end
		graphKB = graphKB - owner.graphSize[oldest]
		owner.nodes[oldest], owner.graphUsed[oldest], owner.graphSize[oldest] = nil, nil, nil
	end
end

local function decodeGraph(st, k)
	slice()
	if st.nodes[k] then
		return st.nodes[k]
	end
	trimGraphs()
	local chunks = unpackField(st.D, "graph", k + 1)
	if st.nodes[k] then
		return st.nodes[k]
	end
	local ids = {}
	st.nodes[k] = ids
	if not chunks then
		return ids
	end
	local s = chunks
	local n, pos = num(s, 1, 2), 3
	st.graphSize[k] = (n * 288 + 128 + (st.D.packed and #s or 0)) / 1024
	graphKB = graphKB + st.graphSize[k]
	local degree = {}
	for i = 0, n - 1 do
		local id = k * 4096 + i
		ids[i + 1] = id
		degree[i + 1] = B64[byte(s, pos + 6)]
		pos = pos + 7
	end
	local width = st.classed and EDGE2 or EDGE1
	for i = 1, n do
		st.nadj[ids[i]] = pos
		pos = pos + degree[i] * width
	end
	return ids
end

local function nodesOf(st, k)
	local nodes = st.nodes[k] or decodeGraph(st, k)
	if st.graphSize[k] then
		graphClock = graphClock + 1
		st.graphUsed[k] = graphClock
	end
	return nodes
end

local function metadata(st, id)
	if st.ncell[id] == nil then
		local s, pos = st.D.graph[floor(id / 4096) + 1], 3 + (id % 4096) * 7
		st.ncell[id], st.nlayer[id], st.ncomp[id] = num(s, pos, 3), B64[byte(s, pos + 3)], num(s, pos + 4, 2)
	end
	return st.ncell[id], st.nlayer[id], st.ncomp[id]
end

-- Most entrances in a visited cluster are never expanded. Decode their edges only when needed.
-- graph[k + 1] is n(2) | n x [cell(3) layer(1) component(2) degree(1)] | the edges in node order, each an edge record:
--   format 1 (7 symbols): cluster offset(1) ((dx + 1) * 3 + dy + 1), node(2), cost(2) swimming with water at swim,
--     cost(2) walking on water, in running yards. Decoded: target, cost swimming, cost walking on water.
--   format 2 (a map with the class field, 14 symbols): cluster offset(1), node(2), costAlliance(3), costHorde(3),
--     costNone(3), yards(2): the edge's grid path priced under each profile's multipliers (Routing/Costs.lua, no
--     profile for costNone, water at swim) and its walked length in yards. Decoded: target, costAlliance, costHorde,
--     costNone, yards. This decoder is the layout's one definition: the packer writes what it reads.
local function adjacent(st, id)
	local adj = st.nadj[id]
	if type(adj) == "number" then
		local k, pos = floor(id / 4096), adj
		local s = st.D.graph[k + 1]
		adj = {}
		local classed, n = st.classed, 0
		for _ = 1, B64[byte(s, 9 + (id % 4096) * 7)] do
			local offset = B64[byte(s, pos)]
			local target = k + (floor(offset / 3) - 1) * st.ny + offset % 3 - 1
			adj[n + 1] = target * 4096 + num(s, pos + 1, 2)
			if classed then
				adj[n + 2], adj[n + 3], adj[n + 4] = num(s, pos + 3, 3), num(s, pos + 6, 3), num(s, pos + 9, 3)
				adj[n + 5] = num(s, pos + 12, 2)
				n, pos = n + 5, pos + EDGE2
			else
				adj[n + 2], adj[n + 3] = num(s, pos + 3, 2), num(s, pos + 5, 2)
				n, pos = n + 3, pos + EDGE1
			end
		end
		st.nadj[id] = adj
		local capacity = 1
		while capacity < #adj do
			capacity = capacity * 2
		end
		local size = (64 + capacity * 16) / 1024
		st.graphSize[k], graphKB = st.graphSize[k] + size, graphKB + size
	end
	return adj
end

-- An entrance's node in its cluster.
local function entrance(st, id)
	local k = floor(id / 4096)
	if not st.nodes[k] then
		nodesOf(st, k)
	end
	local cell, layer = metadata(st, id)
	grid(st, k)
	return surface(st, k, cell, layer)
end

-- Cluster k and local cell of a world point, or nil outside the data.
local function locate(st, x, y)
	local gx, gy = floor((x - st.x0) / st.cs), floor((y - st.y0) / st.cs)
	if gx < 0 or gy < 0 or gx >= st.GX or gy >= st.GY then
		return nil
	end
	local C = st.C
	return floor(gx / C) * st.ny + floor(gy / C), (gx % C) * C + gy % C
end

-- The walkable node of local cell lc a point at height h stands on (the base surface when h is unknown), and the
-- height gap to it.
local function standing(st, k, lc, h)
	local val = grid(st, k)
	if not val then
		return nil
	end
	if h == nil then
		return val[lc + 1] ~= 0 and lc or nil, 0
	end
	return surface(st, k, lc, -1, h)
end

-- The node an endpoint stands on: within SNAP cells, the surface with the least distance plus twice the height gap,
-- among those within ZTOL of its height. A point off every surface (in a lift shaft, mid-jump, deep under water) takes
-- the nearest surface of any height.
local function snap(st, k, lc, x, y, h)
	local C, cs = st.C, st.cs
	local lx, ly = floor(lc / C), lc % C
	local cx, cy = st.x0 + (floor(k / st.ny) * C + lx + 0.5) * cs, st.y0 + ((k % st.ny) * C + ly + 0.5) * cs
	local best, bestCost, any, anyD
	for r = 0, SNAP do
		if best and (r - 1) * cs > bestCost then
			break
		end
		for dx = -r, r do
			for dy = -r, r do
				local nx, ny = lx + dx, ly + dy
				if (dx == r or dx == -r or dy == r or dy == -r) and nx >= 0 and ny >= 0 and nx < C and ny < C then
					local n, gap = standing(st, k, nx * C + ny, h)
					if n then
						local d = r == 0 and 0 or sqrt((cx + dx * cs - x) ^ 2 + (cy + dy * cs - y) ^ 2)
						if gap <= ZTOL and (not bestCost or d + 2 * gap < bestCost) then
							best, bestCost = n, d + 2 * gap
						end
						if not anyD or d < anyD then
							any, anyD = n, d
						end
					end
				end
			end
		end
	end
	return best or any
end

-- Global grid helpers for smoothing across clusters.
local function value(st, gx, gy)
	if gx < 0 or gy < 0 or gx >= st.GX or gy >= st.GY then
		return 0
	end
	local C = st.C
	local val = grid(st, floor(gx / C) * st.ny + floor(gy / C))
	return val and val[(gx % C) * C + gy % C + 1] or 0
end

-- Is the base surface's step from (gx, gy) to (gx + dx, gy + dy) open, for an orthogonal unit step?
local function stepOpen(st, gx, gy, dx, dy, water)
	local ax, ay = gx, gy
	if dx < 0 or dy < 0 then
		ax, ay = gx + dx, gy + dy
	end
	local a, b = value(st, ax, ay), value(st, ax + (dx ~= 0 and 1 or 0), ay + (dy ~= 0 and 1 or 0))
	if a == 0 or b == 0 or (not water and (a == 2 or b == 2)) then
		return false
	end
	local C = st.C
	local f = floor(st.moves[floor(ax / C) * st.ny + floor(ay / C)][(ax % C) * C + ay % C + 1] / 16)
	if dx ~= 0 then
		return f % 2 == 0
	end
	return f % 4 < 2
end

-- Is the base surface's diagonal step from (gx, gy) by (sx, sy) open?
local function diagonalOpen(st, gx, gy, sx, sy, water)
	local b = value(st, gx + sx, gy + sy)
	if b == 0 or (not water and b == 2) then
		return false
	end
	if
		(stepOpen(st, gx, gy, sx, 0, water) and stepOpen(st, gx + sx, gy, 0, sy, water))
		or (stepOpen(st, gx, gy, 0, sy, water) and stepOpen(st, gx, gy + sy, sx, 0, water))
	then
		return true
	end
	local ax, ay, up = gx, gy, sy > 0 -- links are stored on the lower-x cell
	if sx < 0 then
		ax, ay, up = gx + sx, gy + sy, sy < 0
	end
	local a = value(st, ax, ay)
	if a == 0 or (not water and a == 2) then
		return false
	end
	local C = st.C
	local f = floor(st.moves[floor(ax / C) * st.ny + floor(ay / C)][(ax % C) * C + ay % C + 1] / 16)
	if up then
		return f % 8 >= 4
	end
	return f >= 8
end

-- The node one step (dx, dy) on from node of cluster k at global cell (gx, gy): the base surface's own step first,
-- then the node's floor links. Nil when the step is closed.
local function neighbour(st, k, node, gx, gy, dx, dy, water)
	local tx, ty = gx + dx, gy + dy
	if tx < 0 or ty < 0 or tx >= st.GX or ty >= st.GY then
		return nil
	end
	local C = st.C
	local tk, tlc = floor(tx / C) * st.ny + floor(ty / C), (tx % C) * C + ty % C
	if node < C * C then
		local open
		local val = tk == k and grid(st, k)
		-- Most string-pulling steps stay on one base grid. Its decoded moves already check the
		-- same detours; only a dry diagonal beside water needs the stricter surface checks below.
		if
			val
			and (
				water
				or (
					val[node + 1] ~= 2
					and val[tlc + 1] ~= 2
					and (dx == 0 or dy == 0 or (val[node + dx * C + 1] ~= 2 and val[node + dy + 1] ~= 2))
				)
			)
		then
			local m = st.moves[k]
			if dy == 0 then
				open = m[(dx > 0 and node or tlc) + 1] % 2 == 1
			elseif dx == 0 then
				open = m[(dy > 0 and node or tlc) + 1] % 4 >= 2
			elseif dx == dy then
				open = m[(dx > 0 and node or tlc) + 1] % 8 >= 4
			else
				open = m[(dx > 0 and node or tlc) + 1] % 16 >= 8
			end
		elseif dx == 0 or dy == 0 then
			open = stepOpen(st, gx, gy, dx, dy, water)
		else
			open = diagonalOpen(st, gx, gy, dx, dy, water)
		end
		if open then
			return tk, tlc
		end
	end
	grid(st, k)
	local l = st.links[k][node + 1]
	if not l then
		return nil
	end
	local here, h, d = st.val[k][node + 1], st.z[k][node + 1], DIRECTION[(dx + 1) * 3 + dy + 1]
	for e = 1, #l do
		if l[e] % 8 == d then
			grid(st, tk)
			local v = surface(st, tk, tlc, floor(l[e] / 8) - 1, h)
			if v and (water or (here ~= 2 and st.val[tk][v + 1] ~= 2)) then
				return tk, v
			end
		end
	end
	return nil
end

-- A node's class byte (0 on a map without classes), decoding its cluster again if it was evicted.
local function classOf(st, k, node)
	local cls = st.cls[k]
	if not cls then
		grid(st, k)
		cls = st.cls[k]
	end
	return cls and cls[node + 1] or 0
end

-- The zone field (metadata zone[k + 1], format 2, optional; tools/lib/nav/pack.js HEADER): per cluster the uiMapID of
-- each of its 16 x 16 chunks, read straight from the string (never decoded and kept: a cluster's search builds its
-- chunk multipliers once, chunkDanger). Chunk q (0-based) of local cell lc.
local function chunkOf(C, lc)
	return floor(floor(lc / C) * 16 / C) * 16 + floor(lc % C * 16 / C)
end

-- The uiMapID of local cell lc of cluster k; nil in no zone, or on a map or cluster without the zone field.
local function zoneAt(st, k, lc)
	local s = st.D.zone and st.D.zone[k + 1]
	if not s then
		return nil
	end
	local q, i, n, value = chunkOf(st.C, lc), 1, -1, 0
	while i <= #s do
		local a = B64[byte(s, i)]
		if a < 48 then
			value, n, i = a * 64 + B64[byte(s, i + 1)], n + 1, i + 2
		else
			n, i = n + a - 47, i + 1
		end
		if n >= q then
			return value ~= 0 and value or nil
		end
	end
	return nil
end

-- The multiplier of a step into each chunk of cluster k (index q + 1) under danger ({ [uiMapID] = multiplier > 1 },
-- Path.lua's weights); nil when no chunk of the cluster is dangerous (or it has no zone field).
local function chunkDanger(st, k, danger)
	local s = danger and st.D.zone and st.D.zone[k + 1]
	if not s then
		return nil
	end
	local out, any, n, value, i = {}, false, 0, 1, 1
	while i <= #s do
		local a, reps = B64[byte(s, i)], nil
		if a < 48 then
			local m = danger[a * 64 + B64[byte(s, i + 1)]]
			value, any, reps, i = m or 1, any or m ~= nil, 1, i + 2
		else
			reps, i = a - 47, i + 1
		end
		for _ = 1, reps do
			n = n + 1
			out[n] = value
		end
	end
	for q = n + 1, 256 do
		out[q] = 1
	end
	return any and out or nil
end

-- Line of sight between two path entries, walking every cell the segment between their cell centres crosses and
-- following the surface from node to node, so it cannot jump between floors. With limit (a map with classes), every
-- node crossed must also cost no more than limit (Costs.Mult for profile in style, times dangerAt(k, node) when
-- given: smooth's zone danger) and, unless hostileOK, carry no hub bit hb (the one hostile to profile; nil for none).
local function sight(st, P, a, b, water, limit, profile, hb, hostileOK, style, dangerAt)
	local ax, ay, bx, by = P.x[a], P.y[a], P.x[b], P.y[b]
	local k, node = P.k[a], P.n[a]
	local dx, dy = bx - ax, by - ay
	local sx, sy = dx > 0 and 1 or -1, dy > 0 and 1 or -1
	local nx, ny = dx * sx, dy * sy
	local x, y, ix, iy = ax, ay, 0, 0
	while ix < nx or iy < ny do
		tick()
		-- Compare the next x and y boundary crossings: (0.5 + ix) / nx against (0.5 + iy) / ny.
		local d = (1 + 2 * ix) * ny - (1 + 2 * iy) * nx
		local mx, my = 0, 0
		if d == 0 then -- through a corner
			mx, my = sx, sy
		elseif d < 0 then
			mx = sx
		else
			my = sy
		end
		k, node = neighbour(st, k, node, x, y, mx, my, water)
		if not k then
			return false
		end
		if limit then
			local c = classOf(st, k, node)
			local m = Mult(c, profile, style)
			if dangerAt then
				m = m * dangerAt(k, node)
			end
			if m > limit or (hb and not hostileOK and c % (hb + hb) >= hb) then
				return false
			end
		end
		x, y = x + mx, y + my
		ix, iy = ix + mx * sx, iy + my * sy
	end
	return k == P.k[b] and node == P.n[b]
end

-- Collapse a node path to its turns, then pull the string: from each anchor, jump to the furthest point in sight.
-- Water may only be crossed where the path itself swam. On a map with classes a straight segment replaces the path
-- between two entries only over ground no costlier for profile in style (times the zone danger of danger, Path.lua's
-- weights, when given) than the costliest node of that path stretch, and into a hub hostile to profile only where
-- that stretch already entered one: the drawn line (and the hubs it reports) never cuts a road's bend, a hostile
-- hub's rim or a dangerous zone's edge the cost-best path kept to.
local function smooth(st, P, profile, style, danger)
	local PX, PY, PW, PK, PN = P.x, P.y, P.w, P.k, P.n
	local n = #PX
	local keep = { 1 }
	for i = 2, n - 1 do
		if PX[i + 1] - PX[i] ~= PX[i] - PX[i - 1] or PY[i + 1] - PY[i] ~= PY[i] - PY[i - 1] or PW[i + 1] ~= PW[i] then
			keep[#keep + 1] = i
		end
	end
	if n > 1 then
		keep[#keep + 1] = n
	end
	local classed = st.classed
	profile = Costs.Profile(profile)
	local hb = profile == "Horde" and Costs.HUB_ALLIANCE or profile == "Alliance" and Costs.HUB_HORDE or nil
	-- A node's zone multiplier, each cluster's chunk multipliers built once (false: none dangerous).
	local dangerAt
	if classed and danger then
		local chunks, C = {}, st.C
		dangerAt = function(k, node)
			local z = chunks[k]
			if z == nil then
				z = chunkDanger(st, k, danger) or false
				chunks[k] = z
			end
			return z and z[chunkOf(C, cellOf(st, k, node)) + 1] or 1
		end
	end
	local out, a = { keep[1] }, 1
	while a < #keep do
		local b = a + 1
		-- The costliest node of the path after keep[a] up to keep[j], and whether it entered a hostile hub, grown with
		-- j: the anchor's own node is never stepped into, by the path or by the straight segment (sight).
		local limit, hostile, last
		if classed then
			limit, hostile, last = 0, false, keep[a]
		end
		for j = a + 2, #keep do
			local p, q = keep[a], keep[j]
			if classed then
				for i = last + 1, q do
					local c = classOf(st, PK[i], PN[i])
					local m = Mult(c, profile, style)
					if dangerAt then
						m = m * dangerAt(PK[i], PN[i])
					end
					if m > limit then
						limit = m
					end
					if hb and c % (hb + hb) >= hb then
						hostile = true
					end
				end
				last = q
			end
			if not sight(st, P, p, q, PW[q] - PW[p] > 0, limit, profile, hb, hostile, style, dangerAt) then
				break
			end
			b = j
		end
		out[#out + 1] = keep[b]
		a = b
	end
	return out
end

-- With no search queued, drop decoded grids (but the one Path.SurfacesAt reads: the player's) and local trees and
-- trim the decoded graph to its resting ceiling; exact endpoint costs stay.
local function Idle()
	for _, st in pairs(states) do
		for _, entry in ipairs(st.endTrees or {}) do
			entry.tree = nil
		end
		st.endTrees = nil
		for k in pairs(st.used) do
			if reader.st == st and reader.k == k then
				reader.use = st.used[k]
			else
				evict(st, k)
			end
		end
		if st.D.packed then
			st.D.grid, st.D.height, st.D.floor = {}, {}, {}
			if st.classed then
				st.D.class = {}
			end
		end
	end
	trimGraphs(math.min(Path.graphRestKB or Path.graphKB, Path.graphKB))
end

local function Reset()
	for _, st in pairs(states) do
		if st.D.packed then
			st.D.graph, st.D.grid, st.D.height, st.D.floor = {}, {}, {}, {}
			if st.classed then
				st.D.class = {}
			end
		end
	end
	states = {}
	reader.st, reader.k, reader.use = nil, nil, nil
	decodedKB, decodedCount, graphKB = 0, 0, 0
end

---@param map number
---@return boolean
function Path.HasData(map)
	return Data(map) ~= nil
end

---@param map number
---@return boolean
function Path.IsLoaded(map)
	local data = Data(map)
	local state = states[map]
	return (state ~= nil and (state.decoded > 0 or next(state.graphUsed) ~= nil))
		or (data ~= nil and data.packed == nil)
end

---@class SPFPathGrid
ns.PathGrid = {
	clock = clock,
	tick = tick,
	Deadline = Deadline,
	Expansions = Expansions,
	State = State,
	Classed = Classed,
	surface = surface,
	grid = grid,
	keepRead = keepRead,
	wantRead = wantRead,
	prefetch = prefetch,
	dropRead = drop,
	cellOf = cellOf,
	chunkOf = chunkOf,
	zoneAt = zoneAt,
	chunkDanger = chunkDanger,
	nodesOf = nodesOf,
	metadata = metadata,
	adjacent = adjacent,
	entrance = entrance,
	locate = locate,
	standing = standing,
	snap = snap,
	smooth = smooth,
	Idle = Idle,
	Reset = Reset,
	TILE = TILE,
	SNAP = SNAP,
	ZTOL = ZTOL,
	DX = DX,
	DY = DY,
}
