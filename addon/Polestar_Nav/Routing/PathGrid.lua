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

Path.budget = 3 -- milliseconds of path work a frame, whatever the frame rate (PathJobs.lua)
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

-- The directory is resident; a region's pages wait as one string in the map's part (Polestar_Nav itself for map
-- 2991; tools/lib/nav/import-regions.js writes it: the fields' names, "packed.floor,localWalk.ground:", then each
-- page as its field (1 byte, from 1), key (3), block count (1; 0 for a lone string) and each block's length (3)
-- before its bytes). The first page a walk needs from a region unpacks all of it into the map's page tables, the
-- same strings and block lists 0.4.2's region addons assigned, and drops the string (#3396).
local function unpackRegion(D, blob)
	local colon = string.find(blob, ":", 1, true)
	if not colon then return end
	local tables = {}
	for name in string.gmatch(string.sub(blob, 1, colon - 1), "[^,]+") do
		local t = D
		for part in string.gmatch(name, "[^.]+") do
			t = type(t) == "table" and t[part] or nil
		end
		if type(t) ~= "table" then return end
		tables[#tables + 1] = t
	end
	local sub, pos, size = string.sub, colon + 1, #blob
	while pos <= size do
		local f, k1, k2, k3, n = byte(blob, pos, pos + 4)
		pos = pos + 5
		local value
		if n == 0 then
			local a, b, c = byte(blob, pos, pos + 2)
			local len = (a * 256 + b) * 256 + c
			value = sub(blob, pos + 3, pos + 2 + len)
			pos = pos + 3 + len
		else
			value = {}
			for i = 1, n do
				local a, b, c = byte(blob, pos, pos + 2)
				local len = (a * 256 + b) * 256 + c
				value[i] = sub(blob, pos + 3, pos + 2 + len)
				pos = pos + 3 + len
			end
		end
		tables[f][(k1 * 256 + k2) * 256 + k3] = value
	end
end

-- A promised page unavailable in combat is not absent terrain: a later request retries it. Regions unpack only out
-- of combat, as each region's addon loaded in 0.4.2, so every answer stays what it was.
local function loadRegion(map, id)
	if map == nil or (InCombatLockdown and InCombatLockdown()) then return end
	local D = Data(map)
	local regions = D and D.regions
	local blob = regions and regions[id]
	if type(blob) ~= "string" then return end
	regions[id] = nil
	unpackRegion(D, blob)
end
local unavailablePages = 0
local function regionPage(t, key)
	if not t then return nil end
	local value, directory = t[key], t.directory
	if value or not directory then return value end
	local lo, hi = 0, #directory / 4 - 1
	while lo <= hi do
		local mid = floor((lo + hi) / 2)
		local a, b, c, id = byte(directory, 4 * mid + 1, 4 * mid + 4)
		local k = (a * 256 + b) * 256 + c
		if key == k then
			loadRegion(t.detailMap, id)
			if not t[key] then unavailablePages = unavailablePages + 1; return nil, true end
			return t[key]
		elseif key < k then hi = mid - 1 else lo = mid + 1 end
	end
	return nil
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
	if type(blocks) == "number" then
		loadRegion(data.detailMap, blocks)
		blocks = data.packed[field][key]
		if type(blocks) ~= "table" then return nil end
	end
	if not blocks then
		return nil
	end
	local chunks = #blocks > 1 and {} or nil
	local raw
	for i, block in ipairs(blocks) do
		slice()
		-- Maps format 5 may carry the zlib bytes themselves (D.blocks == "zlib") instead of base64.
		local compressed = data.blocks == "zlib" and block or C_EncodingUtil.DecodeBase64(block)
		raw = compressed and C_EncodingUtil.DecompressString(compressed, Enum.CompressionMethod.Zlib)
		if not raw then
			return nil
		end
		if chunks then chunks[i] = raw end
	end
	raw = chunks and table.concat(chunks) or raw or ""
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
			areaMarks = {}, -- [k] = checkpoints into area[k] (areaMarks), dropped with it
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
-- Keep three-byte indexes in the chunks the decoder produces. Joining them into a second, contiguous
-- string would copy every entry. An XO chunk repeats the next offset so reading a pair never straddles pages.
local INDEX_N = 1024
local function indexBytes(pages, node, count)
	local j = node % INDEX_N
	return byte(pages[(node - j) / INDEX_N + 1], 3 * j + 1, 3 * j + count)
end
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
	local a, b, d = indexBytes(c.first, lc, 3)
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
	if not c then return nil end
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

-- The writers below finish a decode: each CHUNK a slice point (a decode holds its scratch across a yield).
local CHUNK = 4096 -- bytes a string.char call
local function chunk(S, n)
	S.np = S.np + 1
	S.parts[S.np] = char(unpack(S.buf, 1, n))
	slice()
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
		slice()
	end
	return finish(S)
end
-- t[first .. last] plus bias, each as width (2 or 3) bytes, high first.
local function wide(S, t, first, last, width, bias)
	local buf, n = S.buf, 0
	local pages = width == 3 and {}
	S.np = 0
	for i = first, last, INDEX_N do
		local j = min(last, i + INDEX_N - 1)
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
		if pages then
			pages[#pages + 1] = char(unpack(buf, 1, n))
			slice()
		else
			chunk(S, n)
		end
		n = 0
	end
	return pages or finish(S)
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
		if i % 256 == 0 then
			slice()
		end
		local gap
		gap, pos = b32(s, pos)
		lc = lc + gap + 1
		cells[i] = lc
	end
	counts = pos
	for i = 0, n - 1 do
		if i % 1024 == 0 then
			slice()
		end
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
		if i % 256 == 0 then
			slice()
		end
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
		if i % 256 == 0 then
			slice()
		end
		local gap
		gap, pos = b32(s, pos)
		a = a + gap
		X[e0 + i] = a * NODE
	end
	for i = 1, n do
		if i % 256 == 0 then
			slice()
		end
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
		if e % 256 == 0 then
			slice()
		end
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
		if i % 1024 == 0 then
			slice()
		end
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
			if e % 64 == 0 then
				slice()
			end
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
		if i % 1024 == 0 then
			slice()
		end
		V[i] = V[i] * KINDS
	end
	-- Heights in half yards (whole numbers: zstep 2 and floors in yards), a blocked base cell's 0 (after the bias).
	for i = 1, N do
		if i % 1024 == 0 then
			slice()
		end
		if V[i] < KINDS then
			Z[i] = -16384
		end
	end
	-- Each cell's floors: the first's node + 1 and their count (the consecutive floors on that cell).
	local AT = S.at
	for i = 1, N do
		if i % 1024 == 0 then
			slice()
		end
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
	local xo = {}
	local o1, o2, o3 = 0, 0, 0 -- off's bytes
	local xb, xw = S.xbuf, 0
	local xparts, xnp = S.xparts or {}, 0
	S.xparts, S.np = xparts, 0
	local j, nextNode = 1, nx > 0 and floor(X[1] / NODE) or T
	for node = 0, T do
		buf[w + 1], buf[w + 2], buf[w + 3], w = o1, o2, o3, w + 3
		if w == 3 * (INDEX_N + 1) then
			xo[#xo + 1] = char(unpack(buf, 1, w))
			buf[1], buf[2], buf[3], w = o1, o2, o3, 3
			slice()
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
	if w > 3 then
		xo[#xo + 1] = char(unpack(buf, 1, w))
		slice()
	end
	if xw > 0 then
		xnp = xnp + 1
		xparts[xnp] = char(unpack(xb, 1, xw))
	end
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
	c.bytes = #c.kind + #c.mv + #c.z + #c.fl + #c.lm + #c.xs + 3 * (N + T + #xo) + 64 * (#c.first + #xo) + 10 * 25 + 200
	spare = S
	return c
end

local useClock, decodedKB, decodedCount = 0, 0, 0

local function evict(st, oldest)
	decodedKB, decodedCount = decodedKB - st.sizes[oldest], decodedCount - 1
	st.sizes[oldest], st.used[oldest] = nil, nil
	st.cl[oldest], st.area[oldest], st.areaMarks[oldest] = nil, nil, nil
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
			-- A regional floor not loaded yet (for example in combat) is retryable.
			if not (st.D.packed and type(st.D.packed.floor[k + 1]) == "number") then st.cl[k] = false end
			return false
		end
		local area = unpackField(st.D, "area", k + 1)
		local size = (c.bytes + (area and #area or 0)) / 1024
		trim(st, size)
		st.cl[k], st.area[k], st.areaMarks[k] = c, area or false, nil
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

-- Checkpoints into a cluster's area field string (nodeArea), so reading a node's area scans from the last checkpoint
-- before it instead of from the string's start: a city cluster's floor nodes lie tens of thousands of nodes in, and
-- from the start one read cost up to 40 ms in the Undercity, every quarter second while the player walked indoors
-- (Walk.lua's floor reads, Path.SurfacesAt with areas). Every AREA_MARK nodes: where the next run starts in the
-- string, the last node before it and that node's value. Built in one pass over the string: under the job's frame
-- budget by Path.Prefetch (the reader's cluster, slicing), else at the first read. Kept only while the cluster's
-- string is (dropped on eviction or a new decode), and only for the string it was built from.
local AREA_MARK = 256
local function areaMarks(st, k, s)
	local m = st.areaMarks[k]
	if m and m.s == s then
		return m
	end
	local mi, mn, mv, count = {}, {}, {}, 0
	local i, n, value, last, len = 1, -1, 0, -huge, #s
	while i <= len do
		if n - last >= AREA_MARK then
			count, last = count + 1, n
			mi[count], mn[count], mv[count] = i, n, value
			slice()
		end
		local a = B64[byte(s, i)]
		if a < 48 then
			value, n, i = (a * 64 + B64[byte(s, i + 1)]) * 64 + B64[byte(s, i + 2)], n + 1, i + 3
		else
			n, i = n + a - 47, i + 1
		end
	end
	m = { s = s, i = mi, n = mn, v = mv, count = count }
	-- A slice may have yielded: the cluster's string may be gone or replaced meanwhile.
	if st.area[k] == s then
		st.areaMarks[k] = m
	end
	return m
end

-- Path.Prefetch's job: decode cluster k of st (slicing under the job's deadline); the reader's if still read last.
-- Its area checkpoints are built here too, under the same budget, so the floor reads that follow stay cheap.
local function prefetch(st, k)
	if grid(st, k) and reader.wantSt == st and reader.wantK == k then
		local s = st.area[k]
		if s then
			areaMarks(st, k, s)
			-- Building them may have sliced: still decoded, and still the cluster read last?
			if not (st.cl[k] and reader.wantSt == st and reader.wantK == k) then
				return
			end
		end
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
	local o1, o2, o3, p1, p2, p3 = indexBytes(c.xo, node, 6)
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
-- nodes now and then, so nothing more is decoded), from the last checkpoint before node (areaMarks); 0 in none, or on
-- a map or cluster without the field.
local function nodeArea(st, k, node)
	local s = st.area[k]
	if not s then
		return 0
	end
	local m = areaMarks(st, k, s)
	local mn, lo, hi = m.n, 1, m.count
	while lo < hi do
		local mid = floor((lo + hi + 1) / 2)
		if mn[mid] < node then
			lo = mid
		else
			hi = mid - 1
		end
	end
	local i, n, value = 1, -1, 0
	if lo >= 1 and mn[lo] and mn[lo] < node then
		i, n, value = m.i[lo], mn[lo], m.v[lo]
	end
	local len = #s
	while i <= len do
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

-- Sparse points on fixed collision faces, not filled boxes or extra walking edges.
-- Each point is indexed in every cluster within shoulder reach. Visit only clusters
-- crossed by the actual chord; no grid decode, even for a long line across tiles.
local function solidSweep(bins, x0, y0, ny, x, y, z, X, Y, Z)
	local r, c = floor((x-x0)/TILE), floor((y-y0)/TILE)
	local R, C = floor((X-x0)/TILE), floor((Y-y0)/TILE)
	local points = bins[r*ny+c]
	if r == R and c == C and not points then return false end
	local dx, dy, dz = X-x, Y-y, Z-z
	local ds = dx*dx + dy*dy
	local sx, sy = dx >= 0 and 1 or -1, dy >= 0 and 1 or -1
	while true do
		if points then
			for i = 1, #points, 3 do
				local u, v = points[i]-x, points[i+1]-y
				local t = ds > 0 and math.min(1, max(0, (u*dx+v*dy)/ds)) or 0
				local h = points[i+2] - (z+t*dz)
				u, v = u-t*dx, v-t*dy
				-- Inscribed shoulder disc minus source/coordinate rounding; ignore
				-- toe-only contacts and points above the body or on another deck.
				if h > .29 and h < 1.95 and u*u+v*v < .454^2 then return true end
			end
		end
		if r == R and c == C then return false end
		local tx = r == R and huge or (x0+(r+(sx>0 and 1 or 0))*TILE-x)/dx
		local ty = c == C and huge or (y0+(c+(sy>0 and 1 or 0))*TILE-y)/dy
		if tx <= ty then r = r+sx end
		if ty <= tx then c = c+sy end
		points = bins[r*ny+c]
	end
end
local function solidChord(st, x, y, z, X, Y, Z)
	local bins = st.D.solidSamples
	return bins and z and Z and solidSweep(bins,st.x0,st.y0,st.ny,x,y,z,X,Y,Z) or false
end

-- Line of sight between two path entries, walking every cell the segment between their cell centres crosses and
-- following the surface from node to node, so it cannot jump between floors. With limit (a map with classes), every
-- node crossed must also cost no more than limit (Costs.Mult for profile in style, times dangerAt(k, node) when
-- given: smooth's zone danger) and, unless hostileOK, carry no hub bit hb (the one hostile to profile; nil for none).
local function sight(st, P, a, b, water, limit, profile, hb, hostileOK, style, dangerAt, sample)
	local ax, ay, bx, by = P.x[a], P.y[a], P.x[b], P.y[b]
	local k, node = P.k[a], P.n[a]
	if st.D.solidSamples and (st.D.solidSamples[k] or k ~= P.k[b] or (a == 1 and P.from) or (b == #P.x and P.to)) then
		local first, last = a == 1 and P.from, b == #P.x and P.to
		if solidChord(st, first and first.x or st.x0+(ax+.5)*st.cs, first and first.y or st.y0+(ay+.5)*st.cs,
			first and first.z or zOf(st.cl[k] or grid(st,k),node), last and last.x or st.x0+(bx+.5)*st.cs,
			last and last.y or st.y0+(by+.5)*st.cs, last and last.z or zOf(st.cl[P.k[b]] or grid(st,P.k[b]),P.n[b])) then return false end
	end
	local dx, dy = bx - ax, by - ay
	local sx, sy = dx > 0 and 1 or -1, dy > 0 and 1 or -1
	local nx, ny = dx * sx, dy * sy
	local major = sample and max(nx, ny)
	local scale = major and major > 0 and (nx * nx + ny * ny) / major
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
		if scale then
			-- Trace every touched cell for walls and floor continuity, but take only one height
			-- per major-axis cell centre. A line barely clipping a side cell must not inherit
			-- its whole height change over a fraction of a yard.
			local m, side, minor
			if nx >= ny then m, side, minor = ix, iy, ny else m, side, minor = iy, ix, nx end
			if side == floor(m * minor / major + 0.5) then
				sample(m == major and nx * nx + ny * ny or m * scale, zOf(st.cl[k] or grid(st, k), node))
			end
		end
	end
	return k == P.k[b] and node == P.n[b]
end

-- A straight run of original graph edges already names its exact floor at every cell. A fresh
-- visibility trace can instead choose the other layer where a ramp and the ground coincide.
-- No jumps, lifts, horizontal skips, floor changes in place, or non-walkable grades.
local function straightGround(st, P, p, q, dx, dy, sample)
	local n = q - p
	if n < 2 or max(abs(dx), abs(dy)) ~= n or (dx ~= 0 and dy ~= 0 and abs(dx) ~= abs(dy)) then return false end
	local sx, sy = dx / n, dy / n
	local step = sx * dx + sy * dy
	local rise = st.cs * (sx ~= 0 and sy ~= 0 and 1.41421356237 or 1) * 1.192 + 1 -- 50° walk slope, quantized yards
	local x, y, z = P.x[p], P.y[p], zOf(grid(st, P.k[p]), P.n[p])
	for j = p + 1, q do
		tick()
		x, y = x + sx, y + sy
		if P.x[j] ~= x or P.y[j] ~= y then return false end
		local h = zOf(grid(st, P.k[j]), P.n[j])
		if abs(h - z) > rise then return false end
		sample((j - p) * step, h)
		z = h
	end
	return true
end

-- A line can have clear walking sight in XY yet put the arrow below a ridge or in the air over a
-- valley. Keep the original turns, cost and yards. Sample the connected level along each long
-- straight and emit a point only when extending its height chord would miss a sample by >3 yd.
-- If the line is a transport, a drop, or an unmapped approach, do not infer an intermediate floor.
local function groundLine(st, P, keep, points)
	local out, i, a, b, dx, dy, total, anchor, za, prev, zp, lo, hi
	local function sample(s, z)
		if s == total then z = b.z end
		local slope = (z - za) / (s - anchor)
		if slope < lo or slope > hi then
			if not out then
				out = { wet = points.wet }
				for j = 1, i - 1 do out[j] = points[j] end
			end
			local t = prev / total
			out[#out + 1] = { map = a.map, x = a.x + dx * t, y = a.y + dy * t, z = zp }
			anchor, za, lo, hi = prev, zp, -huge, huge
		end
		local ds = s - anchor
		lo = max(lo, (z - za - 3) / ds)
		hi = math.min(hi, (z - za + 3) / ds)
		prev, zp = s, z
	end
	for j = 2, #keep do
		i, a, b = j, points[j - 1], points[j]
		local p, q = keep[j - 1], keep[j]
		local gx, gy = P.x[q] - P.x[p], P.y[q] - P.y[p]
		total = gx * gx + gy * gy
		if not b.rideFrom and total >= 16 and a.z and b.z
			and floor((a.x - st.x0) / st.cs) == P.x[p] and floor((a.y - st.y0) / st.cs) == P.y[p]
			and floor((b.x - st.x0) / st.cs) == P.x[q] and floor((b.y - st.y0) / st.cs) == P.y[q]
			and abs(a.z - zOf(grid(st, P.k[p]), P.n[p])) <= 4 and abs(b.z - zOf(grid(st, P.k[q]), P.n[q])) <= 4 then
			local before = out and #out or j - 1
			dx, dy = b.x - a.x, b.y - a.y
			anchor, za, prev, zp, lo, hi = 0, a.z, 0, a.z, -huge, huge
			if not straightGround(st, P, p, q, gx, gy, sample) then
				if out then for t = #out, before + 1, -1 do out[t] = nil end end
				anchor, za, prev, zp, lo, hi = 0, a.z, 0, a.z, -huge, huge
				if not sight(st, P, p, q, P.w[q] > P.w[p], nil, nil, nil, nil, nil, nil, sample) and out then
					for t = #out, before + 1, -1 do out[t] = nil end
				end
			end
		end
		if out then out[#out + 1] = b end
	end
	return out or points
end

-- Path.Sight's clusters: the ones its line has read and their use stamps before (reused, at most SIGHT_CLUSTERS).
local SIGHT_CLUSTERS = 4
local sightK, sightU, sightN = {}, {}, 0
-- May Path.Sight read cluster k of st? true once it is decoded (its stamp kept to be put back); false for a cluster
-- without data; nil while it is not decoded (Sight decodes nothing) or the line has read SIGHT_CLUSTERS already.
local function sightCluster(st, k)
	for i = 1, sightN do
		if sightK[i] == k then
			return true
		end
	end
	local c = st.cl[k]
	if c == nil or sightN >= SIGHT_CLUSTERS then
		return nil
	end
	if not c then
		return false
	end
	sightN = sightN + 1
	sightK[sightN], sightU[sightN] = k, st.used[k]
	return true
end

local INDOOR_CLASS, CITY_CLASS = Costs.CLASS.INDOOR, Costs.CLASS.CITY

-- Polestar's arrow beside its path (Nav/Follow.lua `sight`): can a player standing at the world point (x1, y1) at
-- height z1 on map walk straight to (x2, y2)? Walks every cell the segment between the two cells crosses, following
-- the surface from the node under the start (the one nearest z1, within ZTOL), as the drawn line's straightening does
-- (sight): never through a closed step (a wall, a cliff edge, a building's side), from one floor to another or into
-- water, and on a map with classes never onto indoor or indoor city ground nor into a town hostile to profile ("Horde",
-- "Alliance"; nil: none is). With z2, the walk must reach the floor nearest that height, within ZTOL; without
-- z2, the connected floor suffices. A blocked step or an unusable start returns false. Reads decoded clusters only:
-- nil when the line (or a diagonal step's corner) touches one that is not, touches more than SIGHT_CLUSTERS, or
-- leaves the map's data. It decodes nothing, puts back every use stamp it moved (the cache's order and the
-- reader's slot stay as they were), never yields and allocates nothing. With walls, indoor and indoor city ground
-- pass: only walls, cliffs, floor changes, water and hostile towns block (the arrow's aim kept in reach,
-- Nav/Follow.lua `reach`).
---@param map number
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2? number
---@param profile? string
---@param walls? boolean
---@return boolean?
function Path.Sight(map, x1, y1, z1, x2, y2, z2, profile, walls)
	local st = states[map]
	if not (st and x1 and y1 and z1 and x2 and y2) then
		return nil
	end
	local cs, C, ny, GX, GY = st.cs, st.C, st.ny, st.GX, st.GY
	local gx, gy = floor((x1 - st.x0) / cs), floor((y1 - st.y0) / cs)
	local tx, ty = floor((x2 - st.x0) / cs), floor((y2 - st.y0) / cs)
	if gx < 0 or gy < 0 or gx >= GX or gy >= GY or tx < 0 or ty < 0 or tx >= GX or ty >= GY then
		return nil
	end
	sightN = 0
	local clock0 = useClock
	local k = floor(gx / C) * ny + floor(gy / C)
	local clear = sightCluster(st, k)
	local node
	if clear then
		local gap
		node, gap = surface(st, k, (gx % C) * C + gy % C, -1, z1, st.cl[k])
		clear = node ~= nil and gap <= ZTOL
	end
	local hb = profile == "Horde" and Costs.HUB_ALLIANCE or profile == "Alliance" and Costs.HUB_HORDE or nil
	local classed = st.classed
	local dx, dy = tx - gx, ty - gy
	local sx, sy = dx > 0 and 1 or -1, dy > 0 and 1 or -1
	local nx, nyy = dx * sx, dy * sy
	local x, y, ix, iy = gx, gy, 0, 0
	while clear and (ix < nx or iy < nyy) do
		local d = (1 + 2 * ix) * nyy - (1 + 2 * iy) * nx
		local mx, my = 0, 0
		if d == 0 then
			mx, my = sx, sy
		elseif d < 0 then
			mx = sx
		else
			my = sy
		end
		-- The step's cells: its target, and a diagonal's two corners (stepOpen and diagonalOpen read them).
		clear = sightCluster(st, floor((x + mx) / C) * ny + floor((y + my) / C))
		if clear and mx ~= 0 and my ~= 0 then
			clear = sightCluster(st, floor((x + mx) / C) * ny + floor(y / C))
			if clear then
				clear = sightCluster(st, floor(x / C) * ny + floor((y + my) / C))
			end
		end
		if clear then
			k, node = neighbour(st, k, node, x, y, mx, my, false)
			if not k then
				clear = false
			elseif classed then
				local cb = CLS[byte(st.cl[k].kind, node + 1)]
				local base = cb % 8
				if (not walls and (base == INDOOR_CLASS or base == CITY_CLASS)) or (hb and cb % (hb + hb) >= hb) then
					clear = false
				end
			end
		end
		x, y = x + mx, y + my
		ix, iy = ix + mx * sx, iy + my * sy
	end
	if clear and z2 then
		-- A floor within the height tolerance can still be the storey below the requested one.
		local target, gap = surface(st, k, (tx % C)*C + ty % C, -1, z2, st.cl[k])
		clear = target == node and gap <= ZTOL
	end
	if clear and st.D.solidSamples and solidChord(st, x1,y1,z1, x2,y2,z2 or zOf(st.cl[k],node)) then clear = false end
	for i = 1, sightN do
		st.used[sightK[i]] = sightU[i]
	end
	useClock = clock0
	return clear
end

-- Collapse a node path to its turns, then pull the string: from each anchor, the furthest turn in sight becomes the
-- next anchor (the turns are where the path's own runs end; a segment ending partway along a run gave the arrow's
-- follower lines it aimed back along, #3732). The next turn is always taken, as the path walks it. Further turns are
-- galloped: probe 2, 4, 8, ... turns on while in sight; at the first blocked probe, take the furthest turn in sight up
-- to SMOOTH_MISSES turns past it whose line saves at least SMOOTH_SAVE cells on the path's way round (the far side of
-- the wall the path went round: 0.4.2 stopped at the first turn out of sight, so the line kept the grid's axis-aligned
-- runs round every fence and house wall, #3641; a smaller cut in a zigzag only sharpens the turn the arrow swings
-- through, Orgrimmar's Drag) and gallop on from there, else end at the furthest turn in sight before it. A segment
-- spans at most SMOOTH_SPAN path nodes and never a ride. Water may only be crossed where the path itself swam.
-- On a map with classes a straight segment replaces the path between two entries only over ground no costlier for
-- profile in style (times the zone danger of danger, Path.lua's weights, when given) than the costliest node of that
-- path stretch (than its cost per yard, once the line reaches past a wall), and into a hub hostile to profile only
-- where that stretch already entered one: the drawn line (and the hubs it reports) never cuts a road's bend, a hostile
-- hub's rim or a dangerous zone's edge the cost-best path kept to.
local SMOOTH_MISSES, SMOOTH_SPAN, SMOOTH_SAVE = 8, 400, 1.5
local function smooth(st, P, profile, style, danger)
	local PX, PY, PW, PK, PN = P.x, P.y, P.w, P.k, P.n
	local n = #PX
	local keep = { 1 }
	local rides = P.rides
	local function blocked(p, q)
		local a = p == 1 and P.from
		local b = q == n and P.to
		return P.check(a and a.x or st.x0 + (PX[p]+.5)*st.cs, a and a.y or st.y0 + (PY[p]+.5)*st.cs,
			b and b.x or st.x0 + (PX[q]+.5)*st.cs, b and b.y or st.y0 + (PY[q]+.5)*st.cs)
	end
	for i = 2, n - 1 do
		if (rides and (rides[i] or rides[i+1] or i == 2 or i == n-1))
			or PX[i + 1] - PX[i] ~= PX[i] - PX[i - 1] or PY[i + 1] - PY[i] ~= PY[i] - PY[i - 1] or PW[i + 1] ~= PW[i] then
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
	local worstAt, meanAt, hostileAt = {}, {}, {}
	while a < #keep do
		-- For the path after keep[a] up to node q, filled as far as the probes reach: worstAt[q] its costliest node,
		-- meanAt[q] its cost per yard (each step's multiplier times its length, over the length), hostileAt[q] whether
		-- it entered a hostile hub. The anchor's own node is never stepped into, by the path or by the straight segment
		-- (sight). While every probe from the anchor is in sight, a segment may cross ground up to the stretch's
		-- costliest node (0.4.2's rule); once a probe was blocked and the line reaches past that wall, only up to the
		-- stretch's cost per yard, so it never costs more than the way round the wall it replaces.
		local p = keep[a]
		local cost, length, worst, hostile, filled, past = 0, 0, 0, false, p, false
		local walked, walkedTo = { [p] = 0 }, p
		local stop = #keep
		for j = a + 2, #keep do
			if (rides and (rides[keep[j - 1]] or rides[keep[j]])) or keep[j] - p > SMOOTH_SPAN then
				stop = j - 1
				break
			end
		end
		local function visible(j)
			local q = keep[j]
			if classed then
				while filled < q do
					filled = filled + 1
					local c = classOf(st, PK[filled], PN[filled])
					local m = Mult(c, profile, style)
					if dangerAt then
						m = m * dangerAt(PK[filled], PN[filled])
					end
					local step = sqrt((PX[filled] - PX[filled - 1]) ^ 2 + (PY[filled] - PY[filled - 1]) ^ 2)
					cost, length = cost + m * step, length + step
					if m > worst then
						worst = m
					end
					if hb and c % (hb + hb) >= hb then
						hostile = true
					end
					worstAt[filled], meanAt[filled], hostileAt[filled] = worst, length > 0 and cost / length + 1e-9 or m, hostile
				end
			end
			if rides and blocked(p, q) then
				return false
			end
			local limit = classed and (past and meanAt[q] or worstAt[q]) or nil
			return sight(st, P, p, q, PW[q] - PW[p] > 0, limit, profile, hb, classed and hostileAt[q], style, dangerAt)
		end
		local b, step, j = a + 1, 1, a + 2
		while j <= stop do
			if visible(j) then
				b, step = j, step * 2
				j = (b < stop and b + step > stop) and stop or b + step
			else
				local top = j + SMOOTH_MISSES
				if top > stop then
					top = stop
				end
				local found
				local before = past
				past = true
				for t = top, j + 1, -1 do
					-- Worth it only when the line saves SMOOTH_SAVE cells on the way round: a cut of a cell or two
					-- in a zigzag (Orgrimmar's Drag) only sharpens the turn the arrow has to swing through.
					local q = keep[t]
					while walkedTo < q do
						walkedTo = walkedTo + 1
						walked[walkedTo] = walked[walkedTo - 1] + sqrt((PX[walkedTo] - PX[walkedTo - 1]) ^ 2 + (PY[walkedTo] - PY[walkedTo - 1]) ^ 2)
					end
					if walked[q] - sqrt((PX[q] - PX[p]) ^ 2 + (PY[q] - PY[p]) ^ 2) >= SMOOTH_SAVE and visible(t) then
						found = t
						break
					end
				end
				if not found then
					past = before
					local lo, hi = b, j
					while hi - lo > 1 do
						local mid = floor((lo + hi) / 2)
						if visible(mid) then
							lo = mid
						else
							hi = mid
						end
					end
					b = lo
					break
				end
				b, step = found, 1
				j = (b < stop and b + step > stop) and stop or b + step
			end
		end
		out[#out + 1] = keep[b]
		a = b
	end
	return out
end

-- With no search queued (PathJobs.lua's rest): drop the strings of clusters whose decode never finished and trim the
-- decoded graph to its resting ceiling. Decoded grids and the decoder's scratch stay for the next search (within
-- Path.cacheKB), until Idle; of the endpoint trees, Path.restTrees stay, the older ones' costs staying in st.ends. While
-- a search runs st.endTrees keeps up to Path.lua's ENDTREES; at rest, each tree a city's cluster can make 2-3 MB.
-- The newest start's tree (a walk's start or a batch's source, searched outward) is the one least likely read again:
-- the player has moved on by the next search. It goes to release (Path.lua's pool, while it has room) as one of the
-- restTrees, for the next search's first connection to fill instead of growing a new tree key by key (0.4.1 emptied
-- the pool at every rest, so every search grew its first trees new: rehashes of up to 32,768 keys inside one frame's
-- slice); the newest of the others keep their trees (a walk asked again to the same goal reads its tree).
Path.restTrees = 2
local function Rest(release)
	for _, st in pairs(states) do
		if st.D.packed then
			st.D.grid, st.D.height, st.D.floor = {}, {}, {}
			if st.classed then
				st.D.class = {}
			end
		end
		local kept = st.endTrees
		if kept then
			local keep = Path.restTrees
			if release then
				for i = #kept, 1, -1 do
					local entry = kept[i]
					local tree = entry.tree
					if not entry.back and tree then
						table.remove(kept, i)
						st.endNodes = (st.endNodes or 0) - (entry.size or 0)
						entry.tree = nil
						release(tree)
						keep = keep - 1
						break
					end
				end
			end
			for _ = 1, #kept - keep do
				local gone = table.remove(kept, 1)
				st.endNodes = (st.endNodes or 0) - (gone.size or 0)
				gone.tree = nil
			end
		end
	end
	trimGraphs(math.min(Path.graphRestKB or Path.graphKB, Path.graphKB))
end

-- Rested Path.restSeconds with no search (PathJobs.lua): drop decoded grids (but the one Path.SurfacesAt reads: the
-- player's), the decoder's scratch and local trees as well; exact endpoint costs stay.
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
	end
	Rest()
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
	solidChord = solidChord,
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
	-- Every chunk's zone of cluster k in one pass over its zone field (zoneAt reads one chunk a pass): a string of 512
	-- bytes, chunk q (0-based, chunkOf's numbering) the uiMapID in bytes 2q + 1 (high) and 2q + 2 (low), 0 for none;
	-- nil without the field. (A field, not a local: Path.ZoneTile is its only reader.)
	zoneString = function(st, k)
		local s = st.D.zone and st.D.zone[k + 1]
		if not s then
			return nil
		end
		local out, n, q, i, pair = {}, 0, 0, 1, "\0\0"
		while i <= #s and q < 256 do
			local a, reps = B64[byte(s, i)], 1
			if a < 48 then
				local value = a * 64 + B64[byte(s, i + 1)]
				pair, i = string.char(floor(value / 256), value % 256), i + 2
			else
				reps, i = a - 47, i + 1
			end
			if q + reps > 256 then
				reps = 256 - q
			end
			n, q = n + 1, q + reps
			out[n] = string.rep(pair, reps)
		end
		if q < 256 then
			out[n + 1] = string.rep("\0\0", 256 - q)
		end
		return table.concat(out)
	end,
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
	groundLine = groundLine,
	unpackField = unpackField,
	indexBytes = indexBytes,
	Rest = Rest,
	Idle = Idle,
	Reset = Reset,
	TILE = TILE,
	SNAP = SNAP,
	ZTOL = ZTOL,
	DX = DX,
	DY = DY,
}

-- Build-matched local walks. XY is world north/west, never UI map coordinates.
-- Never join separate corridors merely because they cross in XY.
do
local floor,abs,min,max,sqrt=math.floor,math.abs,math.min,math.max,math.sqrt
local unit=25/3
local cache,key,slot={}, {},0
local function blob(t,k,parse)
 local encoded=regionPage(t,k); if not encoded then return end
 local found=cache[encoded]; if found then return found end
 local bytes=t.directory and encoded or C_EncodingUtil.DecodeBase64(encoded); if not bytes then return end
 local s=C_EncodingUtil.DecompressString(bytes,Enum.CompressionMethod.Zlib); if not s then return end
 if parse then s=parse(s) end
 slot=slot%6+1; if key[slot] then cache[key[slot]]=nil end; key[slot]=encoded; cache[encoded]=s; return s
end
local function ground(d,r,c,warmOnly)
 if r<0 or c<0 or r>=4096 or c>=4096 then return end
 local tile=floor(r/64)*64+floor(c/64);local s
 if warmOnly then s=d.ground and cache[d.ground[tile]] else s=blob(d.ground,tile) end
 if not s then return end
 local a,b,u,v=s:byte(4*(r%64*64+c%64)+1,4*(r%64*64+c%64)+4); if not v then return end
 local h=a+256*b; if h==32768 then return end
 return (h>=32768 and h-65536 or h)/16,(u>=128 and u-256 or u)*unit/128,(v>=128 and v-256 or v)*unit/128
end
local function push(line,map,x,y,z)
 local p=line[#line]; if p and abs(p.x-x)+abs(p.y-y)<1e-7 then return end
 line[#line+1]={map=map,x=x,y=y,z=z,detail=true}
end
local function accepts(p,h) return p.z==nil or abs(p.z-h)<=1 end
local function terrain(d,map,a,b)
 local ax,ay=2048-a.x/unit,2048-a.y/unit; local vx,vy=(a.x-b.x)/unit,(a.y-b.y)/unit
 local function first(x,v) local i=floor(x); if v<0 and x==i then return i-1 end; return i end
 local r,c=first(ax,vx),first(ay,vy); local line={wet=0}; local t,last=0,nil
 -- Each interval stays in one supported patch; check both limiting heights at every joint.
 for step=1,80 do
  local h,u,v=ground(d,r,c); if not h then return end
  local tx=vx==0 and math.huge or ((vx>0 and r+1 or r)-ax)/vx
  local ty=vy==0 and math.huge or ((vy>0 and c+1 or c)-ay)/vy
  local stop=min(1,tx,ty); if stop<t-1e-8 then return end
  local z=h-(ax+t*vx-r)*u-(ay+t*vy-c)*v
  if (not last and not accepts(a,z)) or (last and abs(last-z)>.60) then return end
  if not last then push(line,map,a.x,a.y,z) end
  last=h-(ax+stop*vx-r)*u-(ay+stop*vy-c)*v
  push(line,map,a.x+(b.x-a.x)*stop,a.y+(b.y-a.y)*stop,last)
  if stop>=1 then if accepts(b,last) and #line>=2 then return line,'ground' end;return end
  local xr=tx<=stop+1e-10; local yc=ty<=stop+1e-10
  local dr=vx>0 and 1 or -1; local dc=vy>0 and 1 or -1
  if xr and yc and (not ground(d,r+dr,c) or not ground(d,r,c+dc)) then return end
  if xr then r=r+dr end; if yc then c=c+dc end; t=stop
 end
end
local function traces(s)
 local out={}; for row in s:gmatch('[^\n]+') do local pts={}; local sep=row:find(':',1,true); local w=tonumber(row:sub(1,sep-1)); for x,y,h in row:sub(sep+1):gmatch('([%-%d.]+),([%-%d.]+),([%-%d.]+);') do pts[#pts+1]={tonumber(x),tonumber(y),tonumber(h)} end;out[#out+1]={w,pts} end;return out
end
local function projection(line,p,width)
 local best,at,bx,by,bz; for i=1,#line-1 do local a,b=line[i],line[i+1];local dx,dy=b[1]-a[1],b[2]-a[2];local dd=dx*dx+dy*dy; if dd>1e-10 then
 local t=max(0,min(1,((p.x-a[1])*dx+(p.y-a[2])*dy)/dd)); local x,y,z=a[1]+t*dx,a[2]+t*dy,a[3]+t*(b[3]-a[3]);local e=(x-p.x)^2+(y-p.y)^2
 if e<=(width+1e-7)^2 and abs(z-p.z)<=.35 and (not best or e<best) then best,at,bx,by,bz=e,i+t,x,y,z end end end
 return at,bx,by,bz
end
local function bucket(x,y) return floor((17067-x)/64)*1024+floor((17067-y)/64) end
local function strip(lines,map,a,b)
 if a.z==nil or b.z==nil then return end
 local rows=blob(lines,bucket(a.x,a.y),traces); if not rows then return end
 for _,row in ipairs(rows) do local w,l=row[1],row[2]; local i,x,y,h=projection(l,a,w); if i then local j,ex,ey,eh=projection(l,b,w); if j and abs(i-j)>1e-8 then
 local line={wet=0};push(line,map,a.x,a.y,h);push(line,map,x,y,h)
 if i<j then for k=floor(i)+1,math.ceil(j)-1 do push(line,map,l[k][1],l[k][2],l[k][3]) end else for k=math.ceil(i)-1,floor(j)+1,-1 do push(line,map,l[k][1],l[k][2],l[k][3]) end end
 push(line,map,ex,ey,eh);push(line,map,b.x,b.y,eh);if #line>=2 then return line,'strip' end end end end
end
-- Included inside LocalWalk.lua's private scope. Page offsets are zero based on disk.
-- No joins across MCNK edges: the original chunks can have minute XY gaps.
local quadUnit, chunkUnit = 25/6, 100/3
local function word(s, i)
 local a,b = s:byte(i,i+1); return a+256*b
end
local function signedWord(s,i)
 local v=word(s,i); return v>=32768 and v-65536 or v
end
local function present(s,k,r,c)
 return r>=1 and r<=6 and c>=1 and c<=6 and floor(s:byte(k+6+r)/2^c)%2==1
end
local function fanHeight(s,k,z0,r,c)
 local y,x=floor(r),floor(c);local v=k+14+2*(17*y+x)
 local a,b,d,e,m=signedWord(s,v),signedWord(s,v+2),signedWord(s,v+34),signedWord(s,v+36),signedWord(s,v+18)
 r,c=r-y,c-x
 local h
 if r+c<=1 then
  if r<=c then h=a+(b-a)*c+(2*m-a-b)*r else h=a+(d-a)*r+(2*m-a-d)*c end
 elseif r>=c then h=d+(e-d)*c+(2*m-d-e)*(1-r) else h=b+(e-b)*r+(2*m-b-e)*(1-c) end
 return z0+h/64
end
-- Include both native triangle diagonals, not just the borders of each quad.
local function crossings(list,a,b)
 if a==b then return end
 for v=floor(min(a,b))+1,math.ceil(max(a,b))-1 do list[#list+1]=(v-a)/(b-a) end
end
local function nativePage(map,x,y,warmOnly)
 local md=PolestarPathData and PolestarPathData[map];local pages=md and md.nativeTerrain
 if not pages then return end
 local r,c=floor(512-x/chunkUnit),floor(512-y/chunkUnit)
 if r<0 or r>=1024 or c<0 or c>=1024 then return end
 local key=(floor(r/16)*64+floor(c/16))*16+floor(r%16/4)*4+floor(c%16/4)
 local s
 if warmOnly then s=cache[pages[key]] else s=blob(pages,key) end
 if not s then return end
 local off=word(s,1+2*(r%4*4+c%4));if off==0 then return end
 local k=off+1;local nx=(512-r)*chunkUnit+signedWord(s,k)/8192;local wy=(512-c)*chunkUnit+signedWord(s,k+2)/8192;local z0=signedWord(s,k+4)
 return s,k,nx,wy,z0
end
function ns.nativeGround(map,x,y,warmOnly)
 local s,k,nx,wy,z0=nativePage(map,x,y,warmOnly);if not s then return end
 local r,c=(nx-x)/quadUnit,(wy-y)/quadUnit
 if present(s,k,floor(r),floor(c)) then return fanHeight(s,k,z0,r,c) end
end

-- A straight terminal bearing on a single source terrain chunk. Each touched
-- quad must accommodate the whole player, not only the line under their feet.
-- The table excludes every placed model, liquid quad and protected volume in XY.
local footprintBuild
function Path.FootprintDrySight(map,x,y,z,gx,gy,gz)
 if not z or not gz or (x-gx)^2+(y-gy)^2>8^2 then return false end
 if footprintBuild==nil then
  local ok,version,build=pcall(GetBuildInfo)
  footprintBuild=ok and version=="1.60.1" and tostring(build)=="70532"
 end
 if not footprintBuild or not (C_EncodingUtil and C_EncodingUtil.DecodeBase64 and C_EncodingUtil.DecompressString and Enum and Enum.CompressionMethod) then return false end
 local r,c=floor(512-x/chunkUnit),floor(512-y/chunkUnit)
 if r<0 or r>=1024 or c<0 or c>=1024 or r~=floor(512-gx/chunkUnit) or c~=floor(512-gy/chunkUnit) then return false end
 local md=PolestarPathData and PolestarPathData[map]
 local key=(floor(r/16)*64+floor(c/16))*16+floor(r%16/4)*4+floor(c%16/4)
 local mask=md and blob(md.terminalGround,key)
 if not mask or #mask<32 then return false end
 local offset=word(mask,1+2*(r%4*4+c%4))
 if offset==0 then return false end
 local s,k,north,west,z0,maskAt
 if offset>=32768 then
  maskAt=offset-32768+1
  s,k,north,west,z0=nativePage(map,x,y)
  if not s then return false end
 else
  s,k=mask,offset+1
  if k+303>#s then return false end
  north,west=(512-r)*chunkUnit+signedWord(s,k)/8192,(512-c)*chunkUnit+signedWord(s,k+2)/8192
  z0,maskAt=signedWord(s,k+4),k+6
 end
 if maskAt+7>#mask then return false end
 local ar,ac,br,bc=(north-x)/quadUnit,(west-y)/quadUnit,(north-gx)/quadUnit,(west-gy)/quadUnit
 -- .46 yd player half-width plus margin for source and coordinate rounding.
 local pad=.55/quadUnit
 local r0,c0=floor(min(ar,br)-pad),floor(min(ac,bc)-pad)
 local r1,c1=floor(max(ar,br)+pad),floor(max(ac,bc)+pad)
 if r0<0 or c0<0 or r1>7 or c1>7 then return false end
 for row=r0,r1 do
  local bits=mask:byte(maskAt+row)
  for col=c0,c1 do if floor(bits/2^col)%2==0 then return false end end
 end
 if abs(fanHeight(s,k,z0,ar,ac)-z)>.10 or abs(fanHeight(s,k,z0,br,bc)-gz)>.30 then return false end
 return ns.noNewTailVolume and ns.noNewTailVolume(map,{x=x,y=y,z=z},nil,{x=gx,y=gy,z=gz}) or false
end
function ns.nativeTerrainWalk(map,a,b,directOnly)
 if a.z==nil or b.z==nil or floor(512-b.x/chunkUnit)~=floor(512-a.x/chunkUnit) or floor(512-b.y/chunkUnit)~=floor(512-a.y/chunkUnit) then return end
 local s,k,nx,wy,z0=nativePage(map,a.x,a.y);if not s then return end
 local ar,ac=(nx-a.x)/quadUnit,(wy-a.y)/quadUnit;local br,bc=(nx-b.x)/quadUnit,(wy-b.y)/quadUnit
 if not present(s,k,floor(ar),floor(ac)) or not present(s,k,floor(br),floor(bc)) then return end
 if abs(fanHeight(s,k,z0,ar,ac)-a.z)>.50 or abs(fanHeight(s,k,z0,br,bc)-b.z)>.50 then return end
 local function segment(r0,c0,r1,c1,line)
  local t={0,1};crossings(t,r0,r1);crossings(t,c0,c1);crossings(t,r0+c0,r1+c1);crossings(t,r0-c0,r1-c1);table.sort(t)
  local dr,dc=r1-r0,c1-c0;local last=0
  for i=2,#t do
   local hi=t[i];if hi>last then
    local mid=(hi+last)*.5;local rr,cc=floor(r0+dr*mid),floor(c0+dc*mid)
    if not present(s,k,rr,cc) then return false end
    -- Avoid cutting the corner between two diagonally touching regions. The evaluated
    -- interval itself is on one dry, native triangle; the adjacent quads were halo-checked.
    if hi<1 and dr~=0 and dc~=0 then
     local yr,xc=r0+hi*dr,c0+hi*dc;local y,x=floor(yr+.5),floor(xc+.5)
     if abs(yr-y)<1e-9 and abs(xc-x)<1e-9 and not (present(s,k,y-1,x-1) and present(s,k,y-1,x) and present(s,k,y,x-1) and present(s,k,y,x)) then return false end
    end
    last=hi
   end
  end
  for i=1,#t do local f=t[i];local yr,xc=r0+f*dr,c0+f*dc;push(line,map,nx-yr*quadUnit,wy-xc*quadUnit,fanHeight(s,k,z0,yr,xc)) end
  return true
 end
 local line={wet=0};if segment(ar,ac,br,bc,line) and #line>=2 then return line,'ground-native' end
 if directOnly then return end
 local start=floor(ar)*8+floor(ac);local goal=floor(br)*8+floor(bc)
 if start==goal then return end
 local queue={start};local parent={[start]=false};local head=1
 while head<=#queue do local u=queue[head];head=head+1;if u==goal then break end
  local row,col=floor(u/8),u%8
  for d=1,4 do local y=row+(d==1 and 1 or d==2 and -1 or 0);local x=col+(d==3 and 1 or d==4 and -1 or 0);local v=y*8+x
   if parent[v]==nil and present(s,k,y,x) then parent[v]=u;queue[#queue+1]=v end
  end
 end
 if not parent[goal] then return end
 local back={};local u=goal;while u do back[#back+1]=u;u=parent[u] end
 line={wet=0};local lr,lc=ar,ac
 for i=#back,1,-1 do local y,x=floor(back[i]/8)+.5,back[i]%8+.5;if not segment(lr,lc,y,x,line) then return end;lr,lc=y,x end
 if segment(lr,lc,br,bc,line) and #line>=2 then return line,'ground-native' end
end
-- On a long coarse segment either end may be outside the native patch. A hillside
-- can still be corrected between two points where the coarse chord meets it.
-- The unproved portions keep exactly their original XYZ chord; this never creates
-- a routing edge, connects chunks or changes arrival status.
function ns.nativeTerrainProfile(map,a,b,length)
 local n=math.ceil(length/2);local dx,dy,dz=b.x-a.x,b.y-a.y,b.z-a.z
 local entry,key,peak,out
 for i=0,n do
  if i>0 and i%32==0 then ns.PathGrid.tick() end
  local t=i/n;local x,y,z=a.x+t*dx,a.y+t*dy,a.z+t*dz;local ck=floor(512-x/chunkUnit)*1024+floor(512-y/chunkUnit)
  local h=ns.nativeGround(map,x,y)
  if not h or ck~=key then entry,peak=nil,nil end
  key=ck
  if h then
   local delta=abs(h-z)
   if delta<=.35 then
    if entry and peak then
     local start={map=map,x=a.x+entry*dx,y=a.y+entry*dy,z=a.z+entry*dz}
     local last={map=map,x=x,y=y,z=z}
     local part=ns.nativeTerrainWalk(map,start,last,true)
     if part and #part>2 then
      if not out then out={wet=0};push(out,map,a.x,a.y,a.z) end
      push(out,map,start.x,start.y,start.z)
      for j=2,#part-1 do local p=part[j];push(out,map,p.x,p.y,p.z) end
      push(out,map,x,y,z)
     end
    end
    entry,peak=t,false
   elseif entry and delta>.85 then peak=true end
  end
 end
 if out then push(out,map,b.x,b.y,b.z);return out end
end

-- This veto cannot grant a walk. Reject a replacement tail that enters a policy
-- volume the former final segment avoided. Do not treat a prior exposure as safe.
do
local function mm(s,k)
 local a,b,c,d=s:byte(k,k+3);if d>=128 then d=d-256 end
 return (a+256*(b+256*(c+256*d)))/1000
end
local function slab(a,b,lo,hi,t,u)
 local d=b-a;if d==0 then if a>=lo and a<=hi then return t,u end;return end
 local j,k=(lo-a)/d,(hi-a)/d;if j>k then j,k=k,j end
 t,u=max(t,j),min(u,k);if t<=u then return t,u end
end
local function contact(a,b,x,y,z,X,Y,Z,e)
 local t,u=slab(a.x,b.x,x-.46-e,X+.46+e,0,1);if not t then return false end
 t,u=slab(a.y,b.y,y-.46-e,Y+.46+e,t,u);if not t then return false end
 return slab(a.z,b.z,z-2-e,Z+.10+e,t,u)~=nil
end
function ns.noNewTailVolume(map,from,asked,landing)
 if not (from.z and (not asked or asked.z) and landing.z) or (from.x-landing.x)^2+(from.y-landing.y)^2>64^2 then return false end
 local d=PolestarPathData and PolestarPathData[map];local bins=d and d.obstructionBounds;if not bins then return false end
 for r=floor(min(from.x,landing.x)/128),floor(max(from.x,landing.x)/128) do
  for c=floor(min(from.y,landing.y)/128),floor(max(from.y,landing.y)/128) do
   local k=(r+256)*512+c+256
   local value,missing=regionPage(bins,k)
   if missing then return false end
   if value then
    local s=blob(bins,k);if not s or #s%24~=0 or (not asked and #s>192*24) then return false end
    for j=1,#s,24 do
     local x,y,z,X,Y,Z=mm(s,j),mm(s,j+4),mm(s,j+8),mm(s,j+12),mm(s,j+16),mm(s,j+20)
     -- Outward vs inward margin covers milliyard quantisation and replay rounding.
     if contact(from,landing,x,y,z,X,Y,Z,.003) and (not asked or not contact(from,asked,x,y,z,X,Y,Z,-.003)) then return false end
     if asked and (j-1)%(24*64)==0 then ns.PathGrid.tick() end
    end
   end
  end
 end
 return true
end
end

-- Only keep new vertices when they resolve meaningful vertical error, not just because a tile exists.
function ns.groundProfile(d,a,b)
 local dx,dy=b.x-a.x,b.y-a.y;local n=dx*dx+dy*dy;if n<144 or n>256^2 then return end
 local l=terrain(d,a.map,a,b) or ns.nativeTerrainWalk(a.map,a,b,true)
 if not l then return ns.nativeTerrainProfile(a.map,a,b,sqrt(n)) end
 for j=2,#l-1 do local p=l[j]; local t=((p.x-a.x)*dx+(p.y-a.y)*dy)/n
  if abs(p.z-a.z-t*(b.z-a.z))>.85 then return l end
 end
end
-- A blocked direct segment need not disconnect the meadow. Search only certified
-- four-neighbour cells, with a boundary-height check before crossing each edge.
local function detour(d,map,a,b)
 local function cell(p) return floor(2048-p.x/unit),floor(2048-p.y/unit) end
 local sr,sc=cell(a);local gr,gc=cell(b);local start,goal=sr*4096+sc,gr*4096+gc
 local function height(p,r,c) local h,u,v=ground(d,r,c);if h then return h-(2048-p.x/unit-r)*u-(2048-p.y/unit-c)*v end end
 local za,zb=height(a,sr,sc),height(b,gr,gc)
 if not za or not zb or not accepts(a,za) or not accepts(b,zb) or start==goal then return end
 local ids,rank,n={}, {},0
 local function add(id,score)
  n=n+1;local i=n;while i>1 do local j=floor(i/2);if rank[j]<=score then break end;ids[i],rank[i]=ids[j],rank[j];i=j end;ids[i],rank[i]=id,score
 end
 local function take()
  local id,k,v=ids[1],ids[n],rank[n];n=n-1;local i=1;while i*2<=n do local j=i*2;if j<n and rank[j+1]<rank[j] then j=j+1 end;if rank[j]>=v then break end;ids[i],rank[i]=ids[j],rank[j];i=j end;ids[i],rank[i]=k,v;return id
 end
 local score,prev,done={[start]=0},{},{};add(start,0);local visits=0
 while n>0 and visits<384 do
  local key=take()
  if key==goal then
   local nodes={b};local k=goal
   while k do local r,c=floor(k/4096),k%4096;nodes[#nodes+1]={x=(2047.5-r)*unit,y=(2047.5-c)*unit};k=prev[k] end
   nodes[#nodes+1]=a;local line={wet=0};local i=#nodes
   while i>1 do local part,j
    for t=max(1,i-8),i-1 do part=terrain(d,map,nodes[i],nodes[t]);if part then j=t;break end end
    if not j then return end
    for _,p in ipairs(part) do push(line,map,p.x,p.y,p.z) end;i=j
   end
   if #line>=2 then return line,'ground' end;return
  end
  if not done[key] then
   visits=visits+1;done[key]=true;if visits%16==0 then ns.PathGrid.tick() end
   local r,c=floor(key/4096),key%4096;local h,u,v=ground(d,r,c)
   for q=1,4 do local dr=(q==1 and 1 or q==2 and -1 or 0);local dc=(q==3 and 1 or q==4 and -1 or 0)
    local nr,nc=r+dr,c+dc;local nk=nr*4096+nc;local g=score[key]+1
    if not done[nk] and (not score[nk] or g<score[nk]) then
     local hh,uu,vv=ground(d,nr,nc)
     if hh and abs((h-u*(1+dr)/2-v*(1+dc)/2)-(hh-uu*(1-dr)/2-vv*(1-dc)/2))<=.6 then
      score[nk],prev[nk]=g,key;add(nk,g+abs(nr-gr)+abs(nc-gc))
     end
    end
   end
  end
 end
end
function ns.provenWalk(map,a,b)
 local md=PolestarPathData and PolestarPathData[map];local d=md and md.localWalk; if not d or (a.map and a.map~=map) or (b.map and b.map~=map) or (a.x-b.x)^2+(a.y-b.y)^2>256^2 then return end
 local l,kind=strip(d.lines,map,a,b);if l then return l,kind end
 l,kind=terrain(d,map,a,b);if l then return l,kind end
 l,kind=detour(d,map,a,b);if l then return l,kind end
 l,kind=ns.nativeTerrainWalk(map,a,b);if l then return l,kind end
 l,kind=strip(md.approachLines,map,a,b);if l then return l,'approach' end
 if ns.astraSurfaceWalk then return ns.astraSurfaceWalk(map,a,b) end
end
function ns.provenGround(map,x,y,warmOnly)
 local md=PolestarPathData and PolestarPathData[map];local d=md and md.localWalk;if not d then return end
 local ax,ay=2048-x/unit,2048-y/unit;local r,c=floor(ax),floor(ay);local h,u,v=ground(d,r,c,warmOnly);if h then return h-(ax-r)*u-(ay-c)*v end
 return ns.nativeGround(map,x,y,warmOnly)
end
end

-- 70532 native surface patches. All coordinates are world yards. Data lives in the owning lazy map.
local ns = select(2, ...)
do
local U, floor, abs, min, max = 25/24, math.floor, math.abs, math.min, math.max
local last, cache, slots = 0, {}, {}
local function block(data,r,c)
 if r<0 or c<0 or r>=32768 or c>=32768 then return end
 local text=regionPage(data,floor(r/32)*1024+floor(c/32));if not text then return end
 local v=cache[text];if v then return v end
 if not(C_EncodingUtil and C_EncodingUtil.DecodeBase64 and C_EncodingUtil.DecompressString and Enum and Enum.CompressionMethod) then unavailablePages=unavailablePages+1;return end
 local raw=data.directory and text or C_EncodingUtil.DecodeBase64(text);if not raw then unavailablePages=unavailablePages+1;return end
 v=C_EncodingUtil.DecompressString(raw,Enum.CompressionMethod.Zlib);if not v or #v==0 or #v%11~=0 then unavailablePages=unavailablePages+1;return end
 last=last%12+1;if slots[last] then cache[slots[last]]=nil end;slots[last],cache[text]=text,v;return v
end
local function key(r,c,layer) return (r*32768+c)*32+layer end
local function center(i) return (16384-i)*U end
local function signed(n) return n>=128 and n-256 or n end
local function find(data,r,c,layer,p)
 local v=block(data,r,c);if not v then return end
 local k=((r%32)*32+c%32)*32;local addr=k+(layer or 0);local lo,hi=0,#v/11
 while lo<hi do local m=floor((lo+hi)/2);local x,y=v:byte(11*m+1,11*m+2);if x+256*y<addr then lo=m+1 else hi=m end end
 local found;for i=11*lo+1,#v,11 do
  local a,b,h0,h1,h2,sx,sy=v:byte(i,i+6);local l=a+256*b-k;if l<0 or l>31 or (layer and l~=layer) then break end
  local h=h0+256*h1+65536*h2;if h>=8388608 then h=h-16777216 end;h=h/64;sx=signed(sx)/64;sy=signed(sy)/64
  if not p or abs(p.z-h-(p.x-center(r))*sx-(p.y-center(c))*sy)<=.55 then
   if found then return end -- ambiguous endpoint layer
   found={r=r,c=c,id=key(r,c,l),h=h,sx=sx,sy=sy,blob=v,edge=i+7}
   if layer then return found end
  end
 end;return found
end
local function locate(data,p) return find(data,floor(16384-p.x/U+.5),floor(16384-p.y/U+.5),nil,p) end
local function height(q,p) return q.h+(p.x-center(q.r))*q.sx+(p.y-center(q.c))*q.sy end
local dr,dc={0,1,0,-1},{1,0,-1,0}
local function step(data,q,d,known)
 local n=q.blob:byte(q.edge+d-1);if n==0 or n>32 then return end
 local r,c=q.r+dr[d],q.c+dc[d];local id=key(r,c,n-1)
 local p=known[id] or find(data,r,c,n-1);if p and p.blob:byte(p.edge+(d+1)%4)==q.id%32+1 then known[id]=p;return p end
end
-- A chord may cross only explicitly joined adjacent cells. Every cell interval must agree with its floor plane.
local function chord(data,a,b,known,bounded)
 local q=a.cell;local dx,dy,dz=b.x-a.x,b.y-a.y,b.z-a.z;local vx,vy=-dx/U,-dy/U;local ax,ay=16384-a.x/U,16384-a.y/U;local t=0
 for iter=1,128 do
  if not bounded and iter%12==0 and ns.PathGrid and ns.PathGrid.tick then ns.PathGrid.tick() end
  local tx=vx==0 and math.huge or ((q.r+(vx>0 and .5 or -.5))-ax)/vx
  local ty=vy==0 and math.huge or ((q.c+(vy>0 and .5 or -.5))-ay)/vy
  local s=min(1,tx,ty);if s<t-1e-8 then return end
  local h=height(q,a);local err=a.z-h;local rate=dz-dx*q.sx-dy*q.sy
  if max(abs(err+rate*t),abs(err+rate*s))>.19 then return end
  if s>=1-1e-12 and q.id==b.cell.id then return true end
  local crossX=tx<=s+1e-12;local crossY=ty<=s+1e-12;if not(crossX or crossY) then return end
  local rd=vx>0 and 2 or 4;local cd=vy>0 and 1 or 3
  if crossX and crossY then local one=step(data,q,rd,known);local two=step(data,q,cd,known);if not one or not two then return end;q=step(data,one,cd,known);local alt=step(data,two,rd,known);if not q or not alt or q.id~=alt.id then return end
  else q=step(data,q,crossX and rd or cd,known);if not q then return end end
  t=s
 end
end

-- Trace the XY segment on reciprocally joined cells, not on an interpolated
-- endpoint height: a real deck may change slope at each joint. At a corner
-- both orders of crossing must select the same layer.
local function cross(data,q,rd,cd,known)
 if not (rd and cd) then return step(data,q,rd or cd,known) end
 local r,c=step(data,q,rd,known),step(data,q,cd,known)
 if not r or not c then return end
 local rc,cr=step(data,r,cd,known),step(data,c,rd,known)
 if rc and cr and rc.id==cr.id then return rc end
end
local function traceSheets(data,a,b,q,other,known)
 local dx,dy=b.x-a.x,b.y-a.y;local vx,vy=-dx/U,-dy/U
 local ax,ay=16384-a.x/U,16384-a.y/U;local t=0
 local sign=other and (height(other,a)>height(q,a) and 1 or -1)
 for i=1,16 do -- the caller only tests the five-yard visit sphere
  local atEnd=q.r==b.cell.r and q.c==b.cell.c
  local tx=vx==0 and math.huge or (q.r+(vx>0 and .5 or -.5)-ax)/vx
  local ty=vy==0 and math.huge or (q.c+(vy>0 and .5 or -.5)-ay)/vy
  local s=atEnd and 1 or min(1,tx,ty)
  if s<t-1e-8 then return end
  if other then
   local gap=(height(other,a)-height(q,a))*sign
   local rate=(dx*(other.sx-q.sx)+dy*(other.sy-q.sy))*sign
   if min(gap+rate*t,gap+rate*s)<1.875 then return end
  end
  if atEnd then return q,other end
  local rd=tx<=s+1e-12 and (vx>0 and 2 or 4)
  local cd=ty<=s+1e-12 and (vy>0 and 1 or 3)
  if not (rd or cd) then return end
  q=cross(data,q,rd,cd,known);if not q then return end
  if other then other=cross(data,other,rd,cd,known);if not other then return end end
  t=s
 end
end
-- A near point can be on a *different* walkable deck, even inside the
-- arrival sphere. Require connected patches on both decks across the same
-- XY interval. Missing cells, an ambiguous height or a ramp are not a veto.
local sheetMap,sheetX,sheetY,sheetZ,sheetGX,sheetGY,sheetGZ,sheetResult
local function separateFloors(map,x,y,z,gx,gy,gz)
 if (x-gx)^2+(y-gy)^2<=.10^2 and abs(z-gz)<=.35 then return false end
 local md=PolestarPathData and PolestarPathData[map];local data=md and md.astraSurfaces
 if not data then return false end
 if sheetMap==data and sheetX==x and sheetY==y and sheetZ==z and sheetGX==gx and sheetGY==gy and sheetGZ==gz then return sheetResult end
 sheetMap,sheetX,sheetY,sheetZ,sheetGX,sheetGY,sheetGZ,sheetResult=data,x,y,z,gx,gy,gz,false
 local ok,version,build=pcall(GetBuildInfo)
 -- These three maps have identical base terrain, placements and model geometry
 -- on both builds. Only reject a visit from the other deck; do not grant a walk.
 build=tonumber(build)
 if not ok or version~='1.60.1' or not (build==70532 or (build==70959 and (map==0 or map==1 or map==2991))) then return false end
 local a,b={x=x,y=y,z=z},{x=gx,y=gy,z=gz}
 local start,goal=locate(data,a),locate(data,b);if not start or not goal then return false end
 a.cell,b.cell=start,goal
 if start.id==goal.id or abs(height(start,a)-z)>.30 or abs(height(goal,b)-gz)>.30 then return false end
 local known={[start.id]=start,[goal.id]=goal}
 local endOnStart=traceSheets(data,a,b,start,nil,known)
 if not endOnStart or endOnStart.id==goal.id then return false end
 local otherStart,back=traceSheets(data,b,a,goal,endOnStart,known)
 sheetResult=otherStart~=nil and otherStart.id~=start.id and back.id==start.id
 return sheetResult
end
function ns.Path.OnSeparateLocalFloors(...)
 local before=unavailablePages
 local result=separateFloors(...)
 if before~=unavailablePages then sheetMap=nil;return true end
 return result
end
local function node(q) return {x=center(q.r),y=center(q.c),z=q.h,cell=q} end
local function output(map,p) return {map=map,x=p.x,y=p.y,z=p.z,detail=true} end
function ns.astraSurfaceWalk(map,a,b,directOnly)
 if not(a and b and a.x and a.y and b.x and b.y and a.z and b.z) or (a.map and a.map~=map) or (b.map and b.map~=map) then return end
 local dd=(b.x-a.x)^2+(b.y-a.y)^2;if dd<1e-12 or dd>128^2 then return end
 local md=PolestarPathData and PolestarPathData[map];local data=md and md.astraSurfaces;if not data then return end
 local start,goal=locate(data,a),locate(data,b);if not start or not goal then return end
 local A={x=a.x,y=a.y,z=height(start,a),cell=start};local B={x=b.x,y=b.y,z=height(goal,b),cell=goal}
 local known={[start.id]=start,[goal.id]=goal};if chord(data,A,B,known,directOnly) then return {output(map,A),output(map,B),wet=0},'surface' end
 if directOnly then return end
 local heap,rank,n={},{},0
 local function add(id,f)
  n=n+1;local i=n;while i>1 do local j=floor(i/2);if rank[j]<=f then break end;heap[i],rank[i]=heap[j],rank[j];i=j end;heap[i],rank[i]=id,f
 end
 local function pop()
  local result,id,f=heap[1],heap[n],rank[n];n=n-1;local i=1;while 2*i<=n do local j=i*2;if j<n and rank[j+1]<rank[j] then j=j+1 end;if rank[j]>=f then break end;heap[i],rank[i]=heap[j],rank[j];i=j end;heap[i],rank[i]=id,f;return result
 end
 local g,prev,closed={[start.id]=0},{},{};local seen=0;add(start.id,0)
 while n>0 and seen<2048 do local id=pop();if id==goal.id then
   local route={B};local p=goal
   while p do
    route[#route+1]=node(p);local parent=known[prev[p.id]]
    -- An actual floor can hinge at the shared edge. Don't require a straight height
    -- chord between cell centres when their two half-segments are supported.
    if parent then local mid={x=(center(p.r)+center(parent.r))*.5,y=(center(p.c)+center(parent.c))*.5,cell=p}
     mid.z=(height(p,mid)+height(parent,mid))*.5;route[#route+1]=mid
    end;p=parent
   end;route[#route+1]=A
   local line={wet=0};local i=#route;line[1]=output(map,A)
   while i>1 do local nexti;for j=max(1,i-48),i-1 do if chord(data,route[i],route[j],known) then nexti=j;break end end
    if not nexti then return end;local p=route[nexti];local tail=line[#line];if abs(p.x-tail.x)+abs(p.y-tail.y)>1e-9 then line[#line+1]=output(map,p) end;i=nexti
   end;if #line>=2 then return line,'surface' end;return
  end
  if not closed[id] then closed[id]=true;seen=seen+1;if seen%24==0 and ns.PathGrid and ns.PathGrid.tick then ns.PathGrid.tick() end
   local q=known[id];for d=1,4 do local p=step(data,q,d,known);if p and not closed[p.id] then local w=g[id]+1;if not g[p.id] or w<g[p.id] then g[p.id],prev[p.id]=w,id;local h=abs(goal.r-p.r)+abs(goal.c-p.c);add(p.id,w+h+h/65536) end end end
  end
 end
end

-- Veto only: the walking follower already chose this direction. Across the
-- former arrival ring do not extend that bearing on a coarse graph alone.
local oldMap,oldX,oldY,oldZ,oldGX,oldGY,oldGZ,lastClear
function ns.Path.FinalDrySight(map,x,y,z,gx,gy,gz)
 if not z or not gz or (x-gx)^2+(y-gy)^2>8^2 then return false end
 if map==oldMap and x==oldX and y==oldY and z==oldZ and gx==oldGX and gy==oldGY and gz==oldGZ then return lastClear end
 oldMap,oldX,oldY,oldZ,oldGX,oldGY,oldGZ,lastClear=map,x,y,z,gx,gy,gz,false
 local a,b={x=x,y=y,z=z},{x=gx,y=gy,z=gz}
 local before=unavailablePages
 local line=ns.nativeTerrainWalk(map,a,b,true) or ns.astraSurfaceWalk(map,a,b,true)
 if not line then if before~=unavailablePages then oldMap=nil end;return false end
 for i=2,#line do if not ns.noNewTailVolume(map,line[i-1],nil,line[i]) then if before~=unavailablePages then oldMap=nil end;return false end end
 lastClear=true;return true
end
end

-- Negative evidence only: a known fixed face in the swept body, or two
-- distinct near-parallel sides crossed by the torso ray. Neither grants a walk.
do
local ns=select(2,...);local abs,floor,min,sqrt=math.abs,math.floor,math.min,math.sqrt
local function short(s,k) local a,b=s:byte(k,k+1);return ((b>=128 and b-256 or b)*256+a)/64 end
local hot,page;local M,X,Y,Z,AX,AY,AZ,L,blocked;local hits,ex,ey={},{},{}
function ns.Path.FinalBodyBlocked(map,x,y,z,ax,ay,limit,az)
 if not z then return false end
 if M==map and X==x and Y==y and Z==z and AX==ax and AY==ay and AZ==az and L==limit then return blocked end
 M,X,Y,Z,AX,AY,AZ,L,blocked=map,x,y,z,ax,ay,az,limit,false
 local md=Data(map)
 -- The exact destination supplies both heights, even before a search warms its grid.
 -- Leave the player's directly observed position alone; test only the requested reach.
 if az and md and md.solidSamples then
  local dx,dy=ax-x,ay-y
  local dd=dx*dx+dy*dy
  if dd>.10^2 then
   local t=dd>limit*limit and limit/sqrt(dd) or 1
   if solidSweep(md.solidSamples,md.cx0*TILE,md.cy0*TILE,md.ny,x,y,z,x+t*dx,y+t*dy,z+t*(az-z)) then blocked=true;return true end
  end
 end
 local data=md and md.solidColumns;if not data then return false end
 local side=100/3;local r,c=floor(512-x/side),floor(512-y/side)
 local src,missing=regionPage(data,r*1024+c)
 if missing then M=nil;return true end
 if not src then return false end
 if src~=hot then
  if not (C_EncodingUtil and C_EncodingUtil.DecodeBase64 and C_EncodingUtil.DecompressString and Enum and Enum.CompressionMethod) then M=nil;return true end
  local raw=data.directory and src or C_EncodingUtil.DecodeBase64(src);if not raw then M=nil;return true end
  local s=C_EncodingUtil.DecompressString(raw,Enum.CompressionMethod.Zlib);if not s or #s<18 or (#s-4)%14~=0 or #s>7172 then M=nil;return true end
  page,hot=s,src
 end
 local a,b,c0,d=page:byte(1,4);local zref=(a+256*(b+256*(c0+256*(d>=128 and d-256 or d))))/64
 local dx,dy=ax-x,ay-y;local len=sqrt(dx*dx+dy*dy);if len<.12 then return false end;dx,dy=dx/len,dy/len
 local ahead=min(len,limit);x,y=x-(512-r)*side,y-(512-c)*side
 local torso=z+1.0-zref;local n=0
 for k=5,#page,14 do
  local bx,by=short(page,k),short(page,k+2);local vx,vy=short(page,k+4)-bx,short(page,k+6)-by
  local den=dx*vy-dy*vx;local v2=vx*vx+vy*vy
  if den*den>.035*v2 then
   local sx,sy=bx-x,by-y;local t=(sx*vy-sy*vx)/den;local u=(sx*dy-sy*dx)/den
   if t>.045 and t<ahead-.025 and u>0 and u<1 and min(u,1-u)^2*v2>.04^2 then
    local lo,hi,tip=short(page,k+8),short(page,k+10),short(page,k+12)
    -- Stay inside the original triangle, not its rounded edge.
    if torso>lo+(tip-lo)*u+.07 and torso<hi+(tip-hi)*u-.07 then
     local vl=sqrt(v2);local ux,uy=vx/vl,vy/vl
     for j=1,n do local width=abs(t-hits[j]);if width>=.10 and width<=1.5 and abs(ux*ex[j]+uy*ey[j])>.985 then blocked=true;return true end end
     n=n+1;hits[n],ex[n],ey[n]=t,ux,uy
    end
   end
  end
 end
 return false
end
end

-- Negative evidence for a proximity visit, not a walking edge. This native
-- layer contains only isolated dry terrain with a single floor and no models.
local ns=select(2,...)
function ns.Path.ContradictsPointFloor(map,x,y,z,gx,gy,gz)
 -- An actual observation at the target outweighs the base-world estimate.
 if (x-gx)^2+(y-gy)^2<=.10^2 and math.abs(z-gz)<=.35 then return false end
 local before=unavailablePages
 local target=ns.nativeGround(map,gx,gy)
 if before~=unavailablePages then return true end
 -- Stored vertices round to 1/64 yd, chunk origins to 1/8192. On the
 -- admitted slope the worst combined error is < .009 yd. Do not reject
 -- a goal whose true height could still be inside the .35-yd stance band.
 if not target or math.abs(target-gz)<=.359 then return false end
 local player=ns.nativeGround(map,x,y)
 return before~=unavailablePages or (player~=nil and math.abs(player-z)<=.10)
end
