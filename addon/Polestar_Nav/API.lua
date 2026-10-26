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
-- Memory ceilings (docs/ARCHITECTURE.md, "In-game walking routes"). A
-- decoded cluster is a few byte strings (Routing/PathGrid.lua): 0.2-0.45 MB
-- on Leffe's maps (2-10 MB as tables before, 2026-10-25), so 8 MB of grids
-- hold a long walk's clusters (a 3,000 yd walk decodes about 10) without
-- evicting one mid-search. The decoded graph (entrance lists and each
-- cluster's graph string, about 40 KB a cluster on his maps) may grow to 16
-- MB while a search runs (a batch of walks 3,000 yd round the Trade District
-- reads 209 clusters' graphs: about 9 MB) and is trimmed to 1 MB at rest.
local _, ns = ...
local Path = ns.Path

Path.cacheKB = 8 * 1024
Path.graphKB = 16 * 1024
Path.graphRestKB = 1024

function Path.Available(map)
	return map ~= nil and Path.HasData(map)
end

-- A map is used whole or not at all: one whose packed tables do not hold the
-- entries its `counts` promise (a part file missing from the folder, or one
-- that failed to load) is dropped, and so is every map when the client lacks
-- C_EncodingUtil's DecodeBase64 or DecompressString (the engine would raise
-- a Lua error decoding the first cluster). Path.HasData is then false for
-- that map and Polestar's arrow points straight. A part's bytes are not
-- checked here: the shipped files are pinned by sha256. A map whose parts ship in
-- their own load-on-demand addon (D.part, maps format 5) is checked the same
-- way once that addon loads (Routing/PathGrid.lua EnsurePart).
local enc = C_EncodingUtil
local decodes = type(enc) == "table" and type(enc.DecodeBase64) == "function" and type(enc.DecompressString) == "function"
for map, D in pairs(type(PolestarPathData) == "table" and PolestarPathData or {}) do
	local whole = decodes and type(D) == "table"
	if whole and not D.part and type(D.packed) == "table" and type(D.counts) == "table" then
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
