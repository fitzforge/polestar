-- Polestar_Nav's handoff to Polestar: the global Polestar_NavEngine is the
-- walking router's Path table (Routing/, Polestar's router, started from
-- Shortest Path Forever v1.16.0 by Cillian Berragan), which Polestar's Nav
-- keeps as ns.Nav.Path. Its calls are Shortest Path Forever's: Find(map, from,
-- to, callback, opts), FindCost, FindMany, Cancel(job), Busy(), where opts is
-- the waterWalking flag or { waterWalking, profile } (Routing/Path.lua), with
-- points in UnitPosition's frame (x north, y west, z optional) and map the
-- instance map ID (0 Eastern Kingdoms, 1 Kalimdor, 2991 Zephras Isle). The
-- maps are Polestar's own (`nav pack`, PACK.json: maps format 2, 128 cells a
-- tile, 4.17 yd). The engine reads only PolestarPathData, our own copy
-- of the maps, never an installed Shortest Path Forever's tables (its engine
-- evicts decoded entries while ours may be searching them). Added here:
--
--   Path.Available(map) -> true when walking routes can be found on that map
--
-- Memory ceilings (docs/ARCHITECTURE.md, "In-game walking routes"): his are
-- 24 MB of decoded grids and 4 MB of decoded graph, sized for his 8 yd cells.
-- Our 4.17 yd cells hold 3.7 times as many cells a tile, and maps format 2
-- adds a class per node and five values an edge. Measured by the engine's own
-- accounting on the eval corpus's longest walks (2026-10-16, maps format 2):
-- 40.9 MB of grids and 15.7 MB of graph at most (a 6,850 yd walk in the
-- Hinterlands; 0.2.4's maps: 33.7 MB and 7.7 MB), with the maps themselves
-- 33.9 MB loaded (0.2.4: 27.8 MB). So 48 MB of grids holds such a walk
-- without evicting a cluster mid-search, and 16 MB of graph its whole graph.
-- Both are ceilings while a search runs: Idle drops the decoded grids when no
-- search is queued and trims the decoded graph to Path.graphRestKB, 0.2.4's
-- 6 MB, so what a player keeps between walks stays where 0.2.4 left it.
local _, ns = ...
local Path = ns.Path

Path.cacheKB = 48 * 1024
Path.graphKB = 16 * 1024
Path.graphRestKB = 6 * 1024

function Path.Available(map)
	return map ~= nil and Path.HasData(map)
end

-- A map is used whole or not at all: one whose packed tables do not hold the
-- entries its `counts` promise (a part file missing from the folder, or one
-- that failed to load) is dropped, and so is every map when the client lacks
-- C_EncodingUtil's DecodeBase64 or DecompressString (the engine would raise
-- a Lua error decoding the first cluster). Path.HasData is then false for
-- that map and Polestar's arrow points straight. A part's bytes are not
-- checked here: the shipped files are pinned by sha256.
local enc = C_EncodingUtil
local decodes = type(enc) == "table" and type(enc.DecodeBase64) == "function" and type(enc.DecompressString) == "function"
for map, D in pairs(type(PolestarPathData) == "table" and PolestarPathData or {}) do
	local whole = decodes and type(D) == "table"
	if whole and type(D.packed) == "table" and type(D.counts) == "table" then
		for field, want in pairs(D.counts) do
			local n = 0
			for _ in pairs(D.packed[field] or {}) do
				n = n + 1
			end
			if n ~= want then
				whole = false
				break
			end
		end
	end
	if not whole then
		PolestarPathData[map] = nil
	end
end

Polestar_NavEngine = Path
