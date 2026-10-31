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
-- priced per profile with their yards (edgeValue), and may carry the zone of each cluster's 16 x 16 chunks (the zone
-- field, zoneAt); format 1 maps (0.2.4's) have no classes (class 0 everywhere) and one edge cost for every profile.
-- This file holds the decoded maps, their memory ceilings, frame slicing and string-pulling; Path.lua searches them
-- and PathJobs.lua schedules the searches.
---@class SPFPath
local Path = {}
ns.Path = Path

Path.budget = 2 -- milliseconds of path work, leaving headroom under the 3 ms frame ceiling
Path.clusters = 64 -- secondary count ceiling per map (at least 4)
Path.graphKB = 4096 -- decoded entrances/edges across all maps while a search runs (API.lua sets Polestar's)
Path.graphRestKB = 4096 -- the same with no search queued (Idle trims to it)
Path.cacheKB = 8192 -- decoded grids across all maps; active coroutine locals are additional
Path.endsMax = 256  -- max cached endpoint-connection entries; raise offline to avoid repeated connect() searches
Path.clock = debugprofilestop or function()
	return os.clock() * 1000
end

local TILE = 1600 / 3
local SNAP = 6 -- cells searched around an off-grid endpoint
local ZTOL = 10 -- an endpoint stands on a surface within this height (yd)
local CHECK = 64 -- expansions between clock reads
local EDGE1, EDGE2 = 7, 14 -- symbols in a graph edge record of format 1 and format 2 (edges)

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

-- A number of maps format 5's columns at i: base 32, five bits a symbol, low first, a symbol >= 32 saying another
-- follows. -> value, the position after it.
local function b32(s, i)
	local value, scale = 0, 1
	while true do
		local sym = B64[byte(s, i)]
		i = i + 1
		if sym < 32 then
			return value + sym * scale, i
		end
		value, scale = value + (sym - 32) * scale, scale * 32
	end
end

-- A zigzag column number as the difference it stands for: 0, 1, 2, 3, 4, ... -> 0, -1, 1, -2, 2, ...
local function unzig(v)
	return v % 2 == 0 and v / 2 or -(v + 1) / 2
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

-- Compressed terrain is bundled with the main addon; decoded clusters stay lazy. A map of Leffe's (maps format 5)
-- keeps only its metadata here: its parts ship in a load-on-demand addon (D.part, Polestar_Nav_EK or
-- Polestar_Nav_Kalimdor) that State loads the first time a search needs the map.
local function Data(map)
	return PolestarPathData and PolestarPathData[map]
end

-- Every packed field holds the clusters its counts promise (API.lua drops a map that does not at load).
local function Whole(D)
	if type(D.packed) ~= "table" or type(D.counts) ~= "table" then
		return true
	end
	for field, want in pairs(D.counts) do
		local n = 0
		for _ in pairs(D.packed[field] or {}) do
			n = n + 1
		end
		if n ~= want then
			return false
		end
	end
	return true
end

-- A map's part addon, loaded once, never in combat (loading builds tens of MB of packed strings: Nav/Walk.lua's
-- rule for Polestar_Nav itself). -> whether the map's data is whole now; false in combat (asked again later),
-- and for good when the part fails to load (the map is dropped: the arrow points straight there).
local function EnsurePart(map, D)
	if not D.part or D.partReady then
		return true
	end
	if not Whole(D) then
		if (InCombatLockdown and InCombatLockdown()) or D.partTried then
			return false
		end
		D.partTried = true
		local load = C_AddOns and C_AddOns.LoadAddOn
		if load then
			pcall(load, D.part)
		end
		if not Whole(D) then
			PolestarPathData[map] = nil
			return false
		end
	end
	D.partReady = true
	return true
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
		-- Maps format 5 may carry the zlib bytes themselves (D.blocks == "zlib") instead of base64.
		local compressed = data.blocks == "zlib" and block or C_EncodingUtil.DecodeBase64(block)
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
		if not D or not EnsurePart(map, D) then
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
			columns = D.format == 5, -- maps format 5: the floor field in columns (floorColumns)
			sizes = {}, -- [k] = a decoded cluster's KiB (its strings and area)
			used = {}, -- [k] = last use, for eviction
			decoded = 0,
			cl = {}, -- [k] = the decoded cluster's strings (decodeGrid), false when the cluster has no data
			area = {}, -- [k] = the cluster's area field string (maps format 3; nodeArea reads it), kept while it is decoded
			graphUsed = {},
			graphSize = {},
			nodes = {}, -- [k] = entrance ids (k * 4096 + i); each one's cell, layer and component are read from the graph
			-- string (metadata)
			adj = {}, -- [k][i + 1] = the position of entrance i's first edge record in the cluster's graph string (edges)
			ends = {}, -- bounded local connections, shared by successive endpoint batches
			endCount = 0,
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

-- A decoded cluster (grid(st, k)) is a handful of byte strings read with string.byte: nothing per node lives in a
-- table (AddonSizeOptimisation.md, section 4a: one byte string a cluster holds a tenth of what four tables do, and
-- reads as fast). T = N + F nodes: the N = C * C base cells, then the F floors.
--   kind   T bytes          val * KINDS + its class byte: val 0 blocked, 1 walkable, 2 water (floors up to 4); the
--                           class byte Routing/Costs.lua's (0 on a map or cluster without classes), below KINDS
--   mv     N bytes          open moves (1 +x, 2 +y, 4 +x+y, 8 +x-y) + 16 * the data file's step flags
--   z      2 T bytes        height * 2 + 32768, high byte first (0 for a blocked base cell)
--   fl     2 F bytes        a floor's local cell
--   first  3 N bytes        a cell's floors: (its first floor node + 1) * 64 + their count, 0 for none (the others
--                           follow the first, one node each)
--   lm     T bytes          the node's steps to the surface nearest its height on a neighbouring cell (layer -1),
--                           bit d for direction d (DX, DY)
--   xo     3 (T + 1) bytes  where node i's other moves start in xs (they end where node i + 1's start)
--   xs                      those moves: a step to a layer (b < 248: direction b % 8, layer floor(b / 8) - 1; or
--                           248, direction, layer + 1), a one-way arc (254, its end (3), yards * 4 (2)), the same arc
--                           backwards at its end, for a search out of a goal (255, its start (3), yards * 4 (2))
local char, concat, unpack, min = string.char, table.concat, unpack, math.min
local KINDS = 48 -- every byte a class field's run-length literal can hold
local VAL, CLS = {}, {} -- [kind byte] = val, class byte
for b = 0, 255 do
	VAL[b], CLS[b] = floor(b / KINDS), b % KINDS
end
local BIT, MASK = {}, {} -- [d] = 2 ^ d; [mask] = { the directions of its bits, ascending }
for d = 0, 7 do
	BIT[d] = 2 ^ d
end
for mask = 0, 255 do
	local dirs = {}
	for d = 0, 7 do
		if floor(mask / BIT[d]) % 2 == 1 then
			dirs[#dirs + 1] = d
		end
	end
	MASK[mask] = dirs
end
-- The decoder's move list (below): an entry is node * NODE + its payload, the payload a step's d + 8 * (layer + 1), an
-- arc's ARC (backwards ARC2) + the node at its other end * 65536 + yards * 4 (nodes below 2 ^ 17: 52 bits).
local NODE, ARC, ARC2 = 2 ^ 35, 2 ^ 33, 2 ^ 34

-- Node's height in decoded cluster c.
local function zOf(c, node)
	local a, b = byte(c.z, 2 * node + 1, 2 * node + 2)
	return (a * 256 + b - 32768) / 2
end
-- A floor node's local cell in decoded cluster c.
local function floorCell(c, node)
	local i = 2 * (node - c.N)
	local a, b = byte(c.fl, i + 1, i + 2)
	return a * 256 + b
end
-- Local cell lc's first floor node in decoded cluster c and its floors' count; nil, 0 for none.
local function floorsOf(c, lc)
	local a, b, d = byte(c.first, 3 * lc + 1, 3 * lc + 3)
	local v = (a * 256 + b) * 256 + d
	if v == 0 then
		return nil, 0
	end
	return floor(v / 64) - 1, v % 64
end

-- The node on local cell lc for a link layer (0 the base surface, i the ith floor up, -1 the surface nearest
-- height h), with its height gap for -1. The cluster must be decoded (c: its strings, st.cl[k] when not given).
local function surface(st, k, lc, layer, h, c)
	c = c or st.cl[k]
	local kind = c.kind
	if layer == 0 then
		return byte(kind, lc + 1) >= KINDS and lc or nil
	end
	local first, count = floorsOf(c, lc)
	if layer > 0 then
		return layer <= count and first + layer - 1 or nil
	end
	local best, gap
	if byte(kind, lc + 1) >= KINDS then
		best, gap = lc, abs(zOf(c, lc) - h)
	end
	for node = first or 0, (first or 0) + count - 1 do
		local g = abs(zOf(c, node) - h)
		if not gap or g < gap then
			best, gap = node, g
		end
	end
	return best, gap
end

-- The decoder's scratch: arrays reused from one decode to the next, so a decode allocates little besides its strings
-- (Idle drops them). A decode that yields holds its set; another decode meanwhile takes a fresh one.
--   v, z    [node + 1] = val (then the kind byte), height; m [lc + 1] = moves; at [floor + 1] = local cell;
--   first   [lc + 1] = first floor node + 1 or 0; lm [node + 1] = layer -1 step mask;
--   x       the other moves (entries above, nx of them; sorted by node before they are written); cells a floor
--           field's cells; buf, parts the string being written, xbuf the move bytes
local spare
local function takeScratch()
	local S = spare
	spare = nil
	return S or { v = {}, z = {}, m = {}, at = {}, first = {}, lm = {}, x = {}, cells = {}, buf = {}, xbuf = {}, parts = {}, nx = 0, xmax = 0, np = 0 }
end

local CHUNK = 4096 -- bytes a string.char call
local function chunk(S, n)
	S.np = S.np + 1
	S.parts[S.np] = char(unpack(S.buf, 1, n))
end
local function finish(S)
	local s = concat(S.parts, "", 1, S.np)
	for i = 1, S.np do
		S.parts[i] = nil
	end
	S.np = 0
	return s
end
-- t[first .. last], each a byte, as a string.
local function bytes(S, t, first, last)
	S.np = 0
	for i = first, last, CHUNK do
		S.np = S.np + 1
		S.parts[S.np] = char(unpack(t, i, min(last, i + CHUNK - 1)))
	end
	return finish(S)
end
-- t[first .. last] plus bias, each as width (2 or 3) bytes, high first.
local function wide(S, t, first, last, width, bias)
	local buf, n = S.buf, 0
	S.np = 0
	for i = first, last, CHUNK / 4 do
		local j = min(last, i + CHUNK / 4 - 1)
		if width == 3 then
			for e = i, j do
				local v = t[e] + bias
				local lo = v % 256
				local hi = (v - lo) / 256
				local mid = hi % 256
				buf[n + 1], buf[n + 2], buf[n + 3], n = (hi - mid) / 256, mid, lo, n + 3
			end
		else
			for e = i, j do
				local v = t[e] + bias
				local lo = v % 256
				buf[n + 1], buf[n + 2], n = (v - lo) / 256, lo, n + 2
			end
		end
		chunk(S, n)
		n = 0
	end
	return finish(S)
end

-- Heights t[1 .. last] as height * 2 + 32768 in 2 bytes, high first.
local function wide2(S, t, last)
	local buf, n = S.buf, 0
	S.np = 0
	for i = 1, last, CHUNK / 4 do
		for e = i, min(last, i + CHUNK / 4 - 1) do
			local v = t[e] * 2 + 32768
			local lo = v % 256
			buf[n + 1], buf[n + 2], n = (v - lo) / 256, lo, n + 2
		end
		chunk(S, n)
		n = 0
	end
	return finish(S)
end

-- A move of node besides the base grid's: a step d to layer (-1 joins the node's step mask), or any payload.
local function addMove(S, node, payload)
	local nx = S.nx + 1
	S.x[nx], S.nx = node * NODE + payload, nx
end
local function link(S, node, d, layer)
	if layer == -1 then
		local m = S.lm[node + 1]
		if floor(m / BIT[d]) % 2 == 0 then
			S.lm[node + 1] = m + BIT[d]
		end
	else
		addMove(S, node, d + 8 * (layer + 1))
	end
end

-- surface on the decoder's scratch (T nodes, N base cells).
local function surfaceS(S, N, T, lc, layer, h)
	local V, Z, AT = S.v, S.z, S.at
	local first = S.first[lc + 1]
	first = first > 0 and first - 1 or nil
	if layer == 0 then
		return V[lc + 1] ~= 0 and lc or nil
	elseif layer > 0 then
		local node = first and first + layer - 1
		return node and node < T and AT[node - N + 1] == lc and node or nil
	end
	local best, gap
	if V[lc + 1] ~= 0 then
		best, gap = lc, abs(Z[lc + 1] - h)
	end
	local node = first
	while node and node < T and AT[node - N + 1] == lc do
		if not gap or abs(Z[node + 1] - h) < gap then
			best, gap = node, abs(Z[node + 1] - h)
		end
		node = node + 1
	end
	return best, gap
end

local function decodeHeights(st, V, Z, s)
	local C, step = st.C, st.zstep
	local pos, rep, delta, last = 1, 0, 0, 0
	for i = 1, C * C do
		if i % 256 == 0 then
			slice()
		end
		if V[i] ~= 0 then
			local a = i - 1
			local pred = (a % C > 0 and V[i - 1] ~= 0 and Z[i - 1] / step) or (a >= C and V[i - C] ~= 0 and Z[i - C] / step) or last
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
			last, Z[i] = v, v * step
		end
	end
end

-- The floor field's floors and explicit links into the scratch (rows, maps formats 1-3). -> the first node past the
-- floors.
local function floorRows(S, N, s)
	local V, Z, AT, FIRST, LM = S.v, S.z, S.at, S.first, S.lm
	local node, pos = N, 4
	for _ = 1, num(s, 1, 3) do
		local lc, count = num(s, pos, 3), B64[byte(s, pos + 3)]
		pos = pos + 4
		FIRST[lc + 1] = node + 1
		for _ = 1, count do
			if node % 64 == 0 then
				slice()
			end
			V[node + 1], Z[node + 1], AT[node - N + 1] = B64[byte(s, pos)], num(s, pos + 1, 2) - 2048, lc
			LM[node + 1] = num(s, pos + 3, 2) % 256
			pos, node = pos + 5, node + 1
		end
	end
	for i = 1, num(s, pos, 3) do
		if i % 64 == 0 then
			slice()
		end
		link(S, num(s, pos + 3, 3), B64[byte(s, pos + 6)], B64[byte(s, pos + 7)])
		pos = pos + 5
	end
	return node
end

-- The same from maps format 5's columns (Nav<map>.lua's header): n | n cell gaps | n counts (1) | the floors' values
-- (1) | their heights (zigzag, against the floor below, a cell's first against the previous cell's first) | their
-- steps (2) | m | m link nodes (zigzag, against the previous link's) | m directions (1) | m layers (1).
local function floorColumns(S, N, s)
	local V, Z, AT, FIRST, LM = S.v, S.z, S.at, S.first, S.lm
	local n, pos = b32(s, 1)
	-- The cells go into AT's tail end first (AT[F + i] for the ith cell): read once each, below.
	local counts, floors = 0, 0
	local cells = S.cells
	local lc = -1
	for i = 1, n do
		local gap
		gap, pos = b32(s, pos)
		lc = lc + gap + 1
		cells[i] = lc
	end
	counts = pos
	for i = 0, n - 1 do
		floors = floors + B64[byte(s, counts + i)]
	end
	local values = counts + n
	pos = values + floors
	local node, first = N, 0
	for i = 1, n do
		if i % 64 == 0 then
			slice()
		end
		lc = cells[i]
		FIRST[lc + 1] = node + 1
		local below = first
		for j = 1, B64[byte(s, counts + i - 1)] do
			local d
			d, pos = b32(s, pos)
			below = below + unzig(d)
			if j == 1 then
				first = below
			end
			V[node + 1], Z[node + 1], AT[node - N + 1] = B64[byte(s, values + node - N)], below, lc
			node = node + 1
		end
	end
	for f = 0, floors - 1 do
		if f % 256 == 0 then
			slice()
		end
		LM[N + f + 1] = num(s, pos + 2 * f, 2) % 256
	end
	local m
	m, pos = b32(s, pos + 2 * floors)
	local u = 0
	for i = 1, m do
		local d
		d, pos = b32(s, pos)
		u = u + unzig(d)
		cells[i] = u
	end
	for i = 1, m do
		if i % 64 == 0 then
			slice()
		end
		link(S, cells[i], B64[byte(s, pos + i - 1)], B64[byte(s, pos + m + i - 1)])
	end
	return node
end

-- One-way arcs (maps format 5's columns): n | n from-node gaps (by from node) | n to-nodes (zigzag, against the from
-- node) | n yards * 4 -> into the move list: each arc at its start, then each backwards at its end.
local function decodeArcs(S, s)
	local n, pos = b32(s, 1)
	local X, e0 = S.x, S.nx
	local a = 0
	for i = 1, n do
		local gap
		gap, pos = b32(s, pos)
		a = a + gap
		X[e0 + i] = a * NODE
	end
	for i = 1, n do
		local d
		d, pos = b32(s, pos)
		X[e0 + i] = X[e0 + i] + X[e0 + i] / NODE + unzig(d) -- its start * NODE + its end
	end
	for i = 1, n do
		if i % 256 == 0 then
			slice()
		end
		local y
		y, pos = b32(s, pos)
		local v = X[e0 + i]
		local to = v % NODE
		X[e0 + i] = v - to + ARC + to * 65536 + min(y, 65535)
	end
	S.nx = e0 + n
	for e = e0 + 1, e0 + n do
		local v = X[e]
		local p = v % NODE
		local from, rest = (v - p) / NODE, p - ARC
		local y = rest % 65536
		addMove(S, (rest - y) / 65536, ARC2 + from * 65536 + y)
	end
end

-- Decode cluster k into its strings (above). -> the cluster ({ kind, mv, z, fl, first, lm, xo, xs, N, T, bytes }), or
-- false when it has no data.
local function decodeGrid(st, k)
	Path.decodes = (Path.decodes or 0) + 1
	local s = unpackField(st.D, "grid", k + 1)
	if not s then
		return false
	end
	local height = unpackField(st.D, "height", k + 1)
	if not height then
		return false
	end
	local floors = unpackField(st.D, "floor", k + 1)
	if st.D.packed and st.D.packed.floor[k + 1] and not floors then
		return false
	end
	local classes = st.classed and unpackField(st.D, "class", k + 1)
	if st.classed and st.D.packed and st.D.packed.class and st.D.packed.class[k + 1] and not classes then
		return false
	end
	local arcs = unpackField(st.D, "arc", k + 1)
	local S = takeScratch()
	local V, M, Z, FIRST, LM = S.v, S.m, S.z, S.first, S.lm
	local C = st.C
	local N = C * C
	local n, valueCode, moveCode = 0, 0, 0
	for i = 1, #s do
		if i % 256 == 0 then
			slice()
		end
		local sym = B64[byte(s, i)]
		if sym < 48 then
			valueCode, moveCode = floor(sym / 16), (sym % 16) * 16
			n = n + 1
			V[n], M[n] = valueCode, moveCode
		else
			for _ = 48, sym do
				n = n + 1
				V[n], M[n] = valueCode, moveCode
			end
		end
	end
	-- M[i] packs the open moves (1 = +x, 2 = +y, 4 = +x+y, 8 = +x-y) over the data flags * 16.
	-- Descending cells let diagonals reuse their forward neighbours' decoded moves in the same pass.
	for a = N - 1, 0, -1 do
		if a % 256 == 0 then
			slice()
		end
		local i, ly = a + 1, a % C
		local f = M[i] / 16
		if V[i] ~= 0 then
			if a + C < N and V[i + C] ~= 0 and f % 2 == 0 then
				M[i] = M[i] + 1
			end
			if ly < C - 1 and V[i + 1] ~= 0 and f % 4 < 2 then
				M[i] = M[i] + 2
			end
		end
		-- Diagonals: either L-shaped detour open, or an explicit link.
		if a + C < N and V[i] ~= 0 then
			if
				ly < C - 1
				and V[i + C + 1] ~= 0
				and ((M[i] % 2 == 1 and M[i + C] % 4 >= 2) or (M[i] % 4 >= 2 and M[i + 1] % 2 == 1) or f % 8 >= 4)
			then
				M[i] = M[i] + 4
			end
			if
				ly > 0
				and V[i + C - 1] ~= 0
				and (
					(M[i] % 2 == 1 and M[i + C - 1] % 4 >= 2)
					or (V[i - 1] ~= 0 and M[i - 1] % 64 < 32 and M[i - 1] % 32 < 16)
					or f >= 8
				)
			then
				M[i] = M[i] + 8
			end
		end
	end
	decodeHeights(st, V, Z, height)
	for i = 1, N do
		FIRST[i], LM[i] = 0, 0
	end
	S.nx = 0
	local T = N
	if floors then
		T = (st.columns and floorColumns or floorRows)(S, N, floors)
		if T >= 131072 then -- the move list's node numbers (NODE)
			error("PathGrid: cluster " .. k .. " has more than 131071 nodes")
		end
		-- A base cell's links to floors inside the cluster are the reverse of the floors' own (the floors' layer -1
		-- steps, then their links to other layers).
		local AT, X, explicit = S.at, S.x, S.nx
		for f = N, T - 1 do
			if f % 64 == 0 then
				slice()
			end
			local dirs = MASK[LM[f + 1]]
			if #dirs > 0 then
				local lc = AT[f - N + 1]
				local layer = f - FIRST[lc + 1] + 2
				for e = 1, #dirs do
					local d = dirs[e]
					local tx, ty = floor(lc / C) + DX[d], lc % C + DY[d]
					if tx >= 0 and ty >= 0 and tx < C and ty < C then
						local t = surfaceS(S, N, T, tx * C + ty, -1, Z[f + 1])
						if t and t < N then
							addMove(S, t, OPPOSITE[d] + 8 * (layer + 1))
						end
					end
				end
			end
		end
		for e = 1, explicit do
			local p = X[e] % NODE
			local f = (X[e] - p) / NODE
			if f >= N and f < T then
				local lc = AT[f - N + 1]
				local d = p % 8
				local tx, ty = floor(lc / C) + DX[d], lc % C + DY[d]
				if tx >= 0 and ty >= 0 and tx < C and ty < C then
					local t = surfaceS(S, N, T, tx * C + ty, floor(p / 8) - 1, Z[f + 1])
					if t and t < N then
						addMove(S, t, OPPOSITE[d] + 8 * (f - FIRST[lc + 1] + 3))
					end
				end
			end
		end
	end
	if arcs then
		decodeArcs(S, arcs)
	end
	-- Kinds: val * KINDS + the class field's byte (one a node in node order, run-length like the grid field: a symbol
	-- >= 48 repeats the previous value (symbol - 47) more times; nodes past its end are class 0).
	n = 0
	if classes then
		local value = 0
		for i = 1, #classes do
			if i % 256 == 0 then
				slice()
			end
			local sym = B64[byte(classes, i)]
			local reps = 1
			if sym < 48 then
				value = sym
			else
				reps = sym - 47
			end
			for _ = 1, reps do
				n = n + 1
				if n <= T then
					V[n] = V[n] * KINDS + value
				end
			end
		end
	end
	for i = n + 1, T do
		V[i] = V[i] * KINDS
	end
	-- Heights in half yards (whole numbers: zstep 2 and floors in yards), a blocked base cell's 0 (after the bias).
	for i = 1, N do
		if V[i] < KINDS then
			Z[i] = -16384
		end
	end
	-- Each cell's floors: the first's node + 1 and their count (the consecutive floors on that cell).
	local AT = S.at
	for i = 1, N do
		local f = FIRST[i]
		if f > 0 then
			local count = 0
			while f - 1 + count < T and AT[f - N + count] == i - 1 do
				count = count + 1
			end
			FIRST[i] = f * 64 + min(count, 63)
		end
	end
	-- The other moves by node (then by payload: steps, arcs, arcs backwards), each node's first byte in xs (xo) and
	-- the moves' bytes (xs), in one pass.
	local X, nx = S.x, S.nx
	for i = nx + 1, S.xmax do
		X[i] = nil
	end
	S.xmax = nx
	table.sort(X)
	local buf, w, off = S.buf, 0, 0
	local o1, o2, o3 = 0, 0, 0 -- off's bytes
	local xb, xw = S.xbuf, 0
	local xparts, xnp = S.xparts or {}, 0
	S.xparts, S.np = xparts, 0
	local j, nextNode = 1, nx > 0 and floor(X[1] / NODE) or T
	for node = 0, T do
		buf[w + 1], buf[w + 2], buf[w + 3], w = o1, o2, o3, w + 3
		if w >= CHUNK then
			chunk(S, w)
			w = 0
		end
		if node == nextNode and node < T then
			local before = xw
			while j <= nx do
				local p = X[j] % NODE
				if (X[j] - p) / NODE ~= node then
					break
				end
				if p < 248 then
					xb[xw + 1], xw = p, xw + 1
				elseif p < ARC then
					xb[xw + 1], xb[xw + 2], xb[xw + 3], xw = 248, p % 8, (p - p % 8) / 8, xw + 3
				else
					local tag, rest = p >= ARC2 and 255 or 254, p % ARC
					local y = rest % 65536
					local other = (rest - y) / 65536
					local lo = other % 256
					local hi = (other - lo) / 256
					xb[xw + 1], xb[xw + 2], xb[xw + 3], xb[xw + 4], xb[xw + 5], xb[xw + 6], xw =
						tag, (hi - hi % 256) / 256, hi % 256, lo, (y - y % 256) / 256, y % 256, xw + 6
				end
				j = j + 1
			end
			nextNode = j <= nx and floor(X[j] / NODE) or T
			off = off + xw - before
			o3 = off % 256
			o1 = (off - o3) / 256
			o2 = o1 % 256
			o1 = (o1 - o2) / 256
			if xw >= CHUNK then
				xnp = xnp + 1
				xparts[xnp] = char(unpack(xb, 1, xw))
				xw = 0
			end
		end
	end
	if w > 0 then
		chunk(S, w)
	end
	if xw > 0 then
		xnp = xnp + 1
		xparts[xnp] = char(unpack(xb, 1, xw))
	end
	local xo = finish(S)
	local xstr = concat(xparts, "", 1, xnp)
	for i = 1, xnp do
		xparts[i] = nil
	end
	local c = {
		N = N,
		T = T,
		xs = xstr,
		xo = xo,
		kind = bytes(S, V, 1, T),
		mv = bytes(S, M, 1, N),
		z = wide2(S, Z, T),
		fl = wide(S, S.at, 1, T - N, 2, 0),
		first = wide(S, FIRST, 1, N, 3, 0),
		lm = bytes(S, LM, 1, T),
	}
	c.bytes = #c.kind + #c.mv + #c.z + #c.fl + #c.first + #c.lm + #c.xo + #c.xs + 10 * 25 + 200
	spare = S
	return c
end

local useClock, decodedKB, decodedCount = 0, 0, 0

local function evict(st, oldest)
	decodedKB, decodedCount = decodedKB - st.sizes[oldest], decodedCount - 1
	st.sizes[oldest], st.used[oldest] = nil, nil
	st.cl[oldest], st.area[oldest] = nil, nil
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

-- Cluster k of st decoded (its strings, above), false when it has no data.
local function grid(st, k)
	local c = st.cl[k]
	if c == nil then
		c = decodeGrid(st, k)
		-- Decoding may yield; only complete grids are published to concurrent searches.
		if st.cl[k] ~= nil then
			return grid(st, k)
		end
		if not c then
			st.cl[k] = false
			return false
		end
		local area = unpackField(st.D, "area", k + 1)
		local size = (c.bytes + (area and #area or 0)) / 1024
		trim(st, size)
		st.cl[k], st.area[k] = c, area or false
		st.sizes[k], st.decoded, decodedKB = size, st.decoded + 1, decodedKB + size
		decodedCount = decodedCount + 1
		if st.D.packed then
			st.D.grid[k + 1], st.D.height[k + 1], st.D.floor[k + 1] = nil, nil, nil
			if st.D.class then
				st.D.class[k + 1] = nil
			end
			if st.D.area then
				st.D.area[k + 1] = nil
			end
			if st.D.arc then
				st.D.arc[k + 1] = nil
			end
		end
	end
	if c then
		useClock = useClock + 1
		st.used[k] = useClock
	end
	return c
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
	return floorCell(grid(st, k), node)
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
		owner.adj[oldest] = nil
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
	st.graphSize[k] = (n * 40 + 128 + (st.D.packed and #s or 0)) / 1024
	graphKB = graphKB + st.graphSize[k]
	local adj = {}
	st.adj[k] = adj
	for i = 0, n - 1 do
		ids[i + 1] = k * 4096 + i
	end
	local width = st.classed and EDGE2 or EDGE1
	pos = pos + n * 7
	for i = 1, n do
		adj[i] = pos
		pos = pos + B64[byte(s, 3 + (i - 1) * 7 + 6)] * width
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
	local i = id % 4096
	local a, b, c, d, e, f = byte(st.D.graph[(id - i) / 4096 + 1], 3 + i * 7, 8 + i * 7)
	return (B64[a] * 64 + B64[b]) * 64 + B64[c], B64[d], B64[e] * 64 + B64[f]
end

-- An entrance's edges stay in the graph string; a search reads each record where it lies (edges, edgeTarget,
-- edgeValue). graph[k + 1] is n(2) | n x [cell(3) layer(1) component(2) degree(1)] | the edges in node order, each an
-- edge record:
--   format 1 (7 symbols): cluster offset(1) ((dx + 1) * 3 + dy + 1), node(2), cost(2) swimming with water at swim,
--     cost(2) walking on water, in running yards. Values: 1 cost swimming, 2 cost walking on water.
--   format 2 (a map with the class field, 14 symbols): cluster offset(1), node(2), costAlliance(3), costHorde(3),
--     costNone(3), yards(2): the edge's grid path priced under each profile's multipliers (Routing/Costs.lua, no
--     profile for costNone, water at swim) and its walked length in yards. Values: 1 costAlliance, 2 costHorde,
--     3 costNone, 4 yards. These readers are the layout's one definition: the packer writes what they read.
-- An entrance's graph string (its cluster's graph decoded: nodesOf), its first record's position, its record count
-- and the record width.
local function edges(st, id)
	local s = st.D.graph[floor(id / 4096) + 1]
	return s, st.adj[floor(id / 4096)][id % 4096 + 1], B64[byte(s, 9 + (id % 4096) * 7)], st.classed and EDGE2 or EDGE1
end

-- The target entrance of the record at pos of cluster k's graph string s.
local function edgeTarget(st, s, pos, k)
	local offset = B64[byte(s, pos)]
	return (k + (floor(offset / 3) - 1) * st.ny + offset % 3 - 1) * 4096 + num(s, pos + 1, 2)
end

-- Value i of the record at pos (the numbering above).
local function edgeValue(st, s, pos, i)
	if st.classed then
		if i == 4 then
			return num(s, pos + 12, 2)
		end
		return num(s, pos + 3 * i, 3)
	end
	return num(s, pos + 1 + 2 * i, 2)
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
	local c = grid(st, k)
	if not c then
		return nil
	end
	if h == nil then
		return byte(c.kind, lc + 1) >= KINDS and lc or nil, 0
	end
	return surface(st, k, lc, -1, h, c)
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
	local c = grid(st, floor(gx / C) * st.ny + floor(gy / C))
	return c and VAL[byte(c.kind, (gx % C) * C + gy % C + 1)] or 0
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
	local f = floor(byte(grid(st, floor(ax / C) * st.ny + floor(ay / C)).mv, (ax % C) * C + ay % C + 1) / 16)
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
	local f = floor(byte(grid(st, floor(ax / C) * st.ny + floor(ay / C)).mv, (ax % C) * C + ay % C + 1) / 16)
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
		local c = tk == k and grid(st, k)
		-- Most string-pulling steps stay on one base grid. Its decoded moves already check the
		-- same detours; only a dry diagonal beside water needs the stricter surface checks below.
		local kind = c and c.kind
		if
			c
			and (
				water
				or (
					VAL[byte(kind, node + 1)] ~= 2
					and VAL[byte(kind, tlc + 1)] ~= 2
					and (dx == 0 or dy == 0 or (VAL[byte(kind, node + dx * C + 1)] ~= 2 and VAL[byte(kind, node + dy + 1)] ~= 2))
				)
			)
		then
			local m = byte(c.mv, (dx > 0 or (dx == 0 and dy > 0)) and node + 1 or tlc + 1)
			if dy == 0 then
				open = m % 2 == 1
			elseif dx == 0 then
				open = m % 4 >= 2
			elseif dx == dy then
				open = m % 8 >= 4
			else
				open = m % 16 >= 8
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
	local c = grid(st, k)
	local here, h, d = VAL[byte(c.kind, node + 1)], zOf(c, node), DIRECTION[(dx + 1) * 3 + dy + 1]
	-- The node's step to the surface nearest its height that way first, then its other moves that way, in order.
	if floor(byte(c.lm, node + 1) / BIT[d]) % 2 == 1 then
		local tc = grid(st, tk)
		local v = surface(st, tk, tlc, -1, h, tc)
		if v and (water or (here ~= 2 and VAL[byte(tc.kind, v + 1)] ~= 2)) then
			return tk, v
		end
	end
	local o1, o2, o3, p1, p2, p3 = byte(c.xo, 3 * node + 1, 3 * node + 6)
	local a, b, xs = (o1 * 256 + o2) * 256 + o3, (p1 * 256 + p2) * 256 + p3, c.xs
	while a < b do
		local e = byte(xs, a + 1)
		if e >= 254 then
			a = a + 6
		else
			local ed, layer
			if e < 248 then
				ed, layer, a = e % 8, floor(e / 8) - 1, a + 1
			else
				local x1, x2 = byte(xs, a + 2, a + 3)
				ed, layer, a = x1, x2 - 1, a + 3
			end
			if ed == d then
				local tc = grid(st, tk)
				local v = surface(st, tk, tlc, layer, h, tc)
				if v and (water or (here ~= 2 and VAL[byte(tc.kind, v + 1)] ~= 2)) then
					return tk, v
				end
			end
		end
	end
	return nil
end

-- A node's class byte (0 on a map without classes), decoding its cluster again if it was evicted.
local function classOf(st, k, node)
	local c = st.cl[k] or grid(st, k)
	return c and CLS[byte(c.kind, node + 1)] or 0
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

-- The area field (maps format 3; tools/lib/nav/pack.js HEADER): node's WMOAreaTable row id in decoded cluster k (the
-- client's subzone on that floor), read straight from its string (kept with the cluster's grid: the reader asks a few
-- nodes now and then, so nothing more is decoded); 0 in none, or on a map or cluster without the field.
local function nodeArea(st, k, node)
	local s = st.area[k]
	if not s then
		return 0
	end
	local i, n, value = 1, -1, 0
	while i <= #s do
		local a = B64[byte(s, i)]
		if a < 48 then
			value, n, i = (a * 64 + B64[byte(s, i + 1)]) * 64 + B64[byte(s, i + 2)], n + 1, i + 3
		else
			n, i = n + a - 47, i + 1
		end
		if n >= node then
			return value
		end
	end
	return 0
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

-- With no search queued, drop decoded grids (but the one Path.SurfacesAt reads: the player's), the decoder's scratch
-- and local trees, and trim the decoded graph to its resting ceiling; exact endpoint costs stay.
local function Idle()
	spare = nil
	for _, st in pairs(states) do
		for _, entry in ipairs(st.endTrees or {}) do
			entry.tree = nil
		end
		st.endTrees, st.endNodes = nil, 0
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
	decodedKB, decodedCount, graphKB, spare = 0, 0, 0, nil
end

---@param map number
---@return boolean
function Path.HasData(map)
	return Data(map) ~= nil
end

-- Is map's walking data in memory: Polestar_Nav's own maps, or a map whose part addon (maps format 5) has loaded? A
-- search on a map that is not loads its part first (State, EnsurePart): Polestar asks for walks only on its player's
-- continent and on resident ones, so the other continent's part loads when the player gets there.
---@param map number
---@return boolean
function Path.Resident(map)
	local D = Data(map)
	if not D then
		return false
	end
	return not D.part or D.partReady == true or (type(D.packed) == "table" and type(D.packed.grid) == "table" and next(D.packed.grid) ~= nil)
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
	zOf = zOf,
	floorCell = floorCell,
	floorsOf = floorsOf,
	KINDS = KINDS,
	VAL = VAL,
	CLS = CLS,
	MASK = MASK,
	grid = grid,
	keepRead = keepRead,
	wantRead = wantRead,
	prefetch = prefetch,
	dropRead = drop,
	cellOf = cellOf,
	chunkOf = chunkOf,
	zoneAt = zoneAt,
	nodeArea = nodeArea,
	chunkDanger = chunkDanger,
	nodesOf = nodesOf,
	metadata = metadata,
	edges = edges,
	edgeTarget = edgeTarget,
	edgeValue = edgeValue,
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
