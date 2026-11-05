-- A contract-faithful stand-in for Search, the Codex and the Lookup runtime
-- (docs/ARCHITECTURE.md, section "Lookup"), for the Lookup window's tests. Load after
-- stub_ui.lua; call lookupstub.install() after uistub.install(). Entities
-- are synthetic (ids and names in Classic Era's shape, no third-party data).
--
--   lookupstub.calls     every Lookup.Guide call: { kind, id, index }
--   lookupstub.loaded / lookupstub.reason   what Search.Status reports
--   lookupstub.entities  the searchable entities, in score order
--   lookupstub.sources[kind .. ":" .. id] = { rows }; .entity[...] = record
--   lookupstub.curated[kind .. ":" .. id] = guideId
--   lookupstub.guideResult = nil, "reason"  to make Guide fail

lookupstub = { calls = {}, loaded = true, reason = nil, sources = {}, entity = {}, curated = {} }

lookupstub.entities = {
	{ kind = "mount", id = 8631, title = "Reins of the Striped Frostsaber", subtitle = "Vendor \194\183 Darnassus", quality = 3 },
	{ kind = "mount", id = 8632, title = "Reins of the Spotted Frostsaber", subtitle = "Vendor \194\183 Darnassus", quality = 3 },
	{ kind = "mount", id = 13086, title = "Reins of the Winterspring Frostsaber", subtitle = "Reputation \194\183 Winterspring", quality = 4 },
	{ kind = "mount", id = 12303, title = "Reins of the Nightsaber", subtitle = "Vendor \194\183 Darnassus", quality = 4 },
	-- Search ranks what cannot be got last: no known source, retired stock.
	{ kind = "mount", id = 12304, title = "Reins of the Shadowsaber", quality = 4, status = "nosource" },
	{ kind = "mount", id = 12302, title = "Reins of the Frostsaber", subtitle = "Vendor \194\183 Darnassus", quality = 4, status = "retired" },
	{ kind = "mount", id = 13335, title = "Deathcharger's Reins", subtitle = "Drop \194\183 Stratholme", quality = 4 },
	{ kind = "item", id = 4386, title = "Sabertooth Fang", subtitle = "Drop \194\183 Stranglethorn Vale", quality = 1 },
	{ kind = "npc", id = 4730, title = "Lelanai", subtitle = "Saber Handler \194\183 Darnassus" },
	{ kind = "npc", id = 10440, title = "Baron Rivendare", subtitle = "Stratholme" },
	{ kind = "quest", id = 4970, title = "Frostsaber Provisions", subtitle = "Level 60 \194\183 Winterspring" },
	{ kind = "zone", id = 1457, title = "Darnassus" },
	{ kind = "quest", id = 38, title = "Westfall Stew", subtitle = "Level 12 \194\183 Westfall" },
	{ kind = "zone", id = 1436, title = "Westfall" },
	{ kind = "guide", id = "forever/alliance/02-westfall", title = "Westfall" },
}

local GUIDE_KIND = { guide = true }

local Search = {}
Search.KINDS = {
	{ key = "guide", label = "Guides" }, { key = "mount", label = "Mounts" }, { key = "pet", label = "Pets" },
	{ key = "item", label = "Items" }, { key = "recipe", label = "Recipes" }, { key = "quest", label = "Quests" },
	{ key = "npc", label = "NPCs" }, { key = "rare", label = "Rares" }, { key = "instance", label = "Dungeons" },
	{ key = "zone", label = "Zones" }, { key = "treasure", label = "Treasures" },
}
lookupstub.queries = 0
lookupstub.subtitled = 0 -- Search.Subtitle calls (rows drawn)

function Search.Status() return lookupstub.loaded, lookupstub.reason end

-- opts: { kinds, limit, perKind, offset (per kind), subtitles = false }
function Search.Query(text, opts)
	lookupstub.queries = lookupstub.queries + 1
	opts = opts or {}
	local q = (text or ""):lower()
	local out, counts, taken = {}, {}, {}
	if q == "" then return out, counts end
	local limit, perKind, offset = opts.limit or 60, opts.perKind or opts.limit or 60, opts.offset or 0
	for _, e in ipairs(lookupstub.entities) do
		local ok = (lookupstub.loaded or GUIDE_KIND[e.kind]) and (not opts.kinds or opts.kinds[e.kind]) and e.title:lower():find(q, 1, true)
		if ok then
			counts[e.kind] = (counts[e.kind] or 0) + 1
			local n = counts[e.kind]
			if n > offset and (taken[e.kind] or 0) < perKind and #out < limit then
				taken[e.kind] = (taken[e.kind] or 0) + 1
				out[#out + 1] = { kind = e.kind, id = e.id, title = e.title, quality = e.quality, status = e.status, score = 1,
					subtitle = opts.subtitles ~= false and e.subtitle or nil }
			end
		end
	end
	return out, counts
end

function Search.Subtitle(res)
	lookupstub.subtitled = lookupstub.subtitled + 1
	for _, e in ipairs(lookupstub.entities) do
		if e.kind == res.kind and e.id == res.id then return e.subtitle end
	end
end

-- n synthetic mounts matching "steed", for paging and drawing only what shows.
function lookupstub.many(n)
	for i = 1, n do
		table.insert(lookupstub.entities, { kind = "mount", id = 90000 + i, title = string.format("Steed %03d", i), subtitle = "Vendor", quality = 3 })
	end
end

local Codex = {}
function Codex.IsLoaded() return lookupstub.loaded end
function Codex.Meta() return { schema = 1, counts = { item = 18204, npc = 6112, quest = 4021 } } end
local function find(kind, id)
	for _, e in ipairs(lookupstub.entities) do if e.id == id and (kind == nil or e.kind == kind) then return e end end
end
function Codex.Item(id)
	local e = find(nil, id)
	return e and { id = id, name = e.title, quality = e.quality, kind = e.kind, status = e.status } or nil
end
function Codex.Npc(id) local e = find("npc", id); return e and { id = id, name = e.title } or nil end
function Codex.Quest(id) local e = find("quest", id); return e and { id = id, title = e.title } or nil end
function Codex.Zone(id) local e = find("zone", id); return e and { id = id, name = e.title } or nil end
function Codex.Instance() return nil end
function Codex.Object() return nil end

local Lookup = {}
function Lookup.Sources(kind, id)
	local k = kind .. ":" .. tostring(id)
	return lookupstub.sources[k] or {}, lookupstub.entity[k] or Codex.Item(id)
end
function Lookup.CuratedGuide(kind, id) return lookupstub.curated[kind .. ":" .. tostring(id)] end
function Lookup.IsMount(record) return type(record) == "table" and record.kind == "mount" end
function Lookup.Guide(kind, id, index)
	table.insert(lookupstub.calls, { kind, id, index or false })
	if lookupstub.guideResult ~= nil then return nil, lookupstub.guideResult end
	local curated = lookupstub.curated[kind .. ":" .. tostring(id)]
	if curated then return curated end
	-- As the runtime: a mount is not built from its best source.
	if index == nil and Lookup.IsMount(select(2, Lookup.Sources(kind, id))) then return nil, "mount" end
	return "lookup/" .. kind .. "/" .. tostring(id)
end
function Lookup.Show(q, kind, id) Polestar.Fire("SHOW_LOOKUP", q, kind, id) end

-- The two sample selections: a vendor mount and a rare drop.
lookupstub.sources["mount:8631"] = {
	{ type = "vendor", src = { type = "vendor", npc = 4730, cost = 800000 }, label = "Lelanai", detail = "Vendor \194\183 Darnassus", zone = "Darnassus",
		map = 1457, x = 38.3, y = 15.8, travel = 260, cost = 260, available = true, price = 800000, guideable = true },
	{ type = "vendor", src = { type = "vendor", npc = 4731, cost = 800000, limited = true }, label = "Zachariah Post", detail = "Vendor \194\183 Undercity", zone = "Undercity",
		map = 1458, x = 69.6, y = 43.6, travel = 1900, cost = 1900, available = false, why = "faction", whyText = "Horde only", price = 800000, guideable = true },
}
lookupstub.entity["mount:8631"] = { id = 8631, name = "Reins of the Striped Frostsaber", quality = 3, kind = "mount", reqLevel = 40 }
lookupstub.sources["mount:13335"] = {
	{ type = "drop", src = { type = "drop", npc = 10440, chance = 0.1, instance = "stratholme" }, label = "Baron Rivendare", detail = "Drop \194\183 Stratholme", zone = "Stratholme",
		map = 1423, x = 43.5, y = 19.3, travel = 1500, effort = 2400, cost = 3900, available = false, why = "level", whyText = "Needs level 58", chance = 0.1, guideable = true },
	{ type = "quest", src = { type = "quest", quest = 9 }, label = "Ramstein's Reward", detail = "Quest \194\183 Stratholme", available = false, why = "level", whyText = "Needs level 60", guideable = false },
}
-- Retired Era stock: listed, never guided to.
lookupstub.sources["mount:12302"] = {
	{ type = "vendor", src = { type = "vendor", npc = 4730, cost = 1000000 }, label = "Lelanai", detail = "Vendor \194\183 Darnassus", zone = "Darnassus",
		map = 1457, x = 38.3, y = 15.8, travel = 260, available = false, why = "retired", whyText = "No longer obtainable", price = 1000000, guideable = false },
}
lookupstub.entity["mount:13335"] = { id = 13335, name = "Deathcharger's Reins", quality = 4, kind = "mount", reqLevel = 60 }
-- An ordinary item: its best source builds a guide.
lookupstub.sources["item:4386"] = {
	{ type = "drop", src = { type = "drop", npc = 772, chance = 40 }, label = "Stranglethorn Tiger", detail = "Drop \194\183 Stranglethorn Vale", zone = "Stranglethorn Vale",
		map = 1434, x = 30.2, y = 10.5, travel = 900, effort = 120, cost = 1020, available = true, chance = 40, guideable = true },
}

function lookupstub.install()
	Polestar.Search = Search
	Polestar.Codex = Codex
	Polestar.Lookup = Lookup
end
