-- Polestar.Search: one search over guides and every Codex entity, shared by
-- the guide menu's search box and the Lookup window. Contract:
-- docs/ARCHITECTURE.md, "Core services: Data, Hooks, Search".
--
--   Search.Query(text, opts) -> results, counts, more
--     opts = { kinds = { item = true, ... } | nil (all), limit = 60, perKind = n,
--              offset = n (per kind, for paging), subtitles = false (leave them to Search.Subtitle) }
--     result = { kind, id, title, subtitle|nil, quality|nil, score, status|nil, curated|nil }
--       status: Codex item status ("retired" = no longer obtainable, "nosource");
--       curated: a guide of the suggestion source or Polestar's own `collects`
--       the item, as Lookup's curated guide looks
--     Order: items a curated guide collects first, then everything else,
--     then retired or sourceless items; then exact > prefix > word prefix >
--     substring (> every word somewhere), then Search.KINDS order, then
--     shorter names. counts[kind] = matches of that kind before the caps
--     (perKind: 20 with several kinds, else limit). A one-letter query
--     matches the first 250 name prefixes per kind only; more[kind] = true
--     when there were more (counts then say "at least").
--   Search.Subtitle(result) -> text|nil   -- guides "Zone · 1-6"; Codex entities Lookup.Subtitle
--   Search.KINDS = { { key, label }, ... }   -- display order
--   Search.Status() -> codexLoaded, reason   -- reason: Data.Pack's code
--     ("missing", "disabled", "combat", ...), "loading" while the pack loads,
--     "notloaded" before any try, or "off" when the Lookup module is switched
--     off (lookup.enabled): then queries list guides only and never load the Codex.
--
-- Speed: the Codex ships a prebuilt index per kind (Codex.Index: one string
-- of folded names), so a keystroke is a handful of plain string.find calls
-- over it and never decodes a record; only the results returned are named
-- (Codex.Name) and, unless asked not to, given subtitles. Guide headers are
-- folded once, again when the guide list changes. Guide keywords match one
-- tier below the title. Generated Lookup guides (ids "lookup/...") are not
-- listed.
--
-- On a client in another language a quest, NPC, item, treasure or zone is
-- also found by its name in that language (Polestar.Names, the client's map
-- names) and listed under it: each kind's index gets, once, a line per id
-- whose name differs from the English, and a match counts an id once.

local ADDON, ns = ...

local Search = {}
ns.Search = Search

local L = ns.L
local type, ipairs, tostring, tonumber = type, ipairs, tostring, tonumber
local find, sub, gsub, lower, byte, match, gmatch = string.find, string.sub, string.gsub, string.lower, string.byte, string.match, string.gmatch
local min = math.min

local STATUS = { r = "retired", n = "nosource" }

local CODEX_PACK = "Polestar_Codex"

Search.KINDS = {
	{ key = "guide", label = L["Guides"] },
	{ key = "mount", label = L["Mounts"] },
	{ key = "pet", label = L["Pets"] },
	{ key = "item", label = L["Items"] },
	{ key = "recipe", label = L["Recipes"] },
	{ key = "tabard", label = L["Tabards"] },
	{ key = "quest", label = L["Quests"] },
	{ key = "npc", label = L["NPCs"] },
	{ key = "rare", label = L["Rares"] },
	{ key = "instance", label = L["Dungeons and raids"] },
	{ key = "zone", label = L["Zones"] },
	{ key = "treasure", label = L["Treasures"] },
}

local KIND_INDEX = {}
local function reindexKinds()
	for k in pairs(KIND_INDEX) do KIND_INDEX[k] = nil end
	for i, k in ipairs(Search.KINDS) do KIND_INDEX[k.key] = i end
end
reindexKinds()

local DEFAULT_LIMIT = 60
local DEFAULT_PER_KIND = 20

---------------------------------------------------------------------------
-- Folding
---------------------------------------------------------------------------

-- Two-byte UTF-8 letters -> folded: Latin-1 (lead byte 0xC3) to ASCII, Œ œ, Cyrillic case.
local FOLD = {}
do
	local runs = {
		{ 0x80, 0x85, "a" }, { 0x86, 0x86, "ae" }, { 0x87, 0x87, "c" }, { 0x88, 0x8B, "e" },
		{ 0x8C, 0x8F, "i" }, { 0x90, 0x90, "d" }, { 0x91, 0x91, "n" }, { 0x92, 0x96, "o" },
		{ 0x98, 0x98, "o" }, { 0x99, 0x9C, "u" }, { 0x9D, 0x9D, "y" }, { 0x9E, 0x9E, "th" },
		{ 0x9F, 0x9F, "ss" },
		{ 0xA0, 0xA5, "a" }, { 0xA6, 0xA6, "ae" }, { 0xA7, 0xA7, "c" }, { 0xA8, 0xAB, "e" },
		{ 0xAC, 0xAF, "i" }, { 0xB0, 0xB0, "d" }, { 0xB1, 0xB1, "n" }, { 0xB2, 0xB6, "o" },
		{ 0xB8, 0xB8, "o" }, { 0xB9, 0xBC, "u" }, { 0xBD, 0xBD, "y" }, { 0xBE, 0xBE, "th" },
		{ 0xBF, 0xBF, "y" },
	}
	for _, r in ipairs(runs) do
		for b = r[1], r[2] do FOLD["\195" .. string.char(b)] = r[3] end
	end
	-- Œ œ (lead byte 0xC5) -> "oe".
	FOLD["\197\146"], FOLD["\197\147"] = "oe", "oe"
	-- Cyrillic capitals to lower case (string.lower leaves them), Ё and ё as е:
	-- a Russian name matches whatever case the player types.
	for b = 0x90, 0x9F do FOLD["\208" .. string.char(b)] = "\208" .. string.char(b + 0x20) end
	for b = 0xA0, 0xAF do FOLD["\208" .. string.char(b)] = "\209" .. string.char(b - 0x20) end
	FOLD["\208\129"], FOLD["\209\145"] = "\208\181", "\208\181"
end

-- " folded name" (leading space, single spaces), so a word prefix is a plain
-- find of " " .. query.
local function fold(s)
	s = lower(s)
	if find(s, "[\128-\255]") then
		s = gsub(s, "[\195\197\208\209][\128-\191]", FOLD)
		s = gsub(s, "\226\128\153", "") -- right single quotation mark
	end
	s = gsub(s, "'", "")
	s = gsub(s, "[%p%c]", " ")
	s = gsub(s, "%s+", " ")
	if byte(s, 1) ~= 32 then s = " " .. s end
	if byte(s, -1) == 32 then s = sub(s, 1, -2) end
	return s
end
Search.Fold = fold

---------------------------------------------------------------------------
-- Matching
---------------------------------------------------------------------------

local EXACT, PREFIX, WORD, SUBSTRING, WORDS = 4, 3, 2, 1, 0

-- q: a folded query (" black stallion"); words: its words with a leading
-- space each, when it has several. -> tier | nil
local function tier(f, q, body, short, words)
	if f == q then return EXACT end
	local pos = find(f, body, 2, true)
	if pos == 2 then return PREFIX end
	if short then
		if find(f, q, 1, true) then return WORD end
		return nil
	end
	if pos then
		if find(f, q, 1, true) then return WORD end
		return SUBSTRING
	end
	if words then
		for i = 1, #words do
			if not find(f, words[i], 2, true) then return nil end
		end
		return WORDS
	end
	return nil
end

-- standing: 2 items a curated guide collects, 1 everything else (guides,
-- places, items to be had), 0 items no longer obtainable or without a known
-- source. It outranks the match tier, so among items the ones a guide covers
-- come first and a retired mount never sits above the ones on sale. (The
-- UIs group results by kind, so this mostly reorders within a kind.)
local function score(t, kind, len, standing)
	return (standing or 1) * 10000000 + t * 1000000 - (KIND_INDEX[kind] or 99) * 10000 - min(len, 9999)
end

---------------------------------------------------------------------------
-- Indexes
---------------------------------------------------------------------------

local guideIndex, guideCount, guideSource
-- item id -> true when a guide of the suggestion source or ours `collects` it
local curated = {}

-- The Lookup module's switch; nil (no Lookup module) counts as on.
local function codexOn()
	return ns.Get("lookup.enabled") ~= false
end

-- The Codex's prebuilt name index of a kind (Codex.Index): one string of
-- lines "\2<folded name>\1<id>,<quality>,<status letter>,<name length>\n",
-- folded exactly as Search.Fold (without its leading space). nil while the
-- Codex is not loaded or Lookup is off.
local function codexBlob(kind)
	if not codexOn() then return nil end
	local C = ns.Codex
	if not (C and C.IsLoaded and C.IsLoaded() and C.Index) then return nil end
	return C.Index(kind)
end

-- Codex kinds named in the client's language, by Polestar.Names' kind; zones
-- by the client's map names.
local NAMES_KIND = { item = "item", mount = "item", pet = "item", recipe = "item", tabard = "item",
	npc = "npc", rare = "npc", quest = "quest", treasure = "object", zone = "zone" }
local localIndex = {} -- kind -> { base = the Codex's blob, blob = it plus the localised lines }

local function localised()
	local N = ns.Names
	return N and N.Localised() or false
end

-- A Codex entity's name in the client's language, or nil; never asks the
-- server (Names.Cached). A dungeon or raid by its map (Names.Instance).
local function localName(kind, id)
	if kind == "instance" then
		local C = ns.Codex
		local inst = C and C.Instance and C.Instance(id)
		return inst and type(inst.map) == "number" and ns.Names.Instance(inst.map) or nil
	end
	local nk = NAMES_KIND[kind]
	if not nk or type(id) ~= "number" then return nil end
	if nk == "zone" then return ns.Compat.GetMapName(id) end
	return ns.Names.Cached(nk, id)
end

local function blobOf(kind)
	local blob = codexBlob(kind)
	if not (blob and NAMES_KIND[kind] and localised()) then return blob end
	local cached = localIndex[kind]
	if cached and cached.base == blob then return cached.blob end
	local lines = { blob }
	for folded, id, quality, st in gmatch(blob, "\2([^\1]*)\1([^,]*),(%d*),(%a?),%d+\n") do
		local name = localName(kind, tonumber(id))
		if name then
			local f = sub(fold(name), 2)
			if f ~= folded and f ~= "" then
				lines[#lines + 1] = "\2" .. f .. "\1" .. id .. "," .. quality .. "," .. st .. "," .. #name .. "\n"
			end
		end
	end
	local full = table.concat(lines)
	-- Kept once the names pack is in (or will not come this session).
	if ns.Names.Ready() then localIndex[kind] = { base = blob, blob = full } end
	return full
end

local function guideList()
	local list = ns.Guides and ns.Guides.List and ns.Guides.List() or {}
	local source = ns.Guides and ns.Guides.SuggestSource and ns.Guides.SuggestSource() or "guides"
	if guideIndex and guideCount == #list and guideSource == source then return guideIndex end
	guideCount, guideSource = #list, source
	guideIndex = {}
	curated = {}
	for _, h in ipairs(list) do
		local id = h.id
		if type(id) == "string" and sub(id, 1, 7) ~= "lookup/" and type(h.collects) == "table"
			and (h.pack == source or h.pack == "guides") then
			for i = 1, #h.collects do curated[h.collects[i]] = true end
		end
		if type(id) == "string" and sub(id, 1, 7) ~= "lookup/" and type(h.title) == "string" then
			local keys = {}
			if type(h.keywords) == "table" then
				for i = 1, #h.keywords do
					if type(h.keywords[i]) == "string" then keys[#keys + 1] = fold(h.keywords[i]) end
				end
			end
			local where = {}
			-- The zone as the client names it (its language), else the guide's English.
			local zone = type(h.zone) == "number" and ns.Compat.MapName(h.zone) or h.zoneName
			if type(h.zoneName) == "string" then where[#where + 1] = fold(h.zoneName) end
			if type(zone) == "string" and zone ~= h.zoneName then where[#where + 1] = fold(zone) end
			if type(h.category) == "string" then where[#where + 1] = fold(h.category) end
			local sublabel = zone or h.category
			if h.minLevel and h.maxLevel then
				sublabel = (sublabel and (sublabel .. " \194\183 ") or "") .. h.minLevel .. "-" .. h.maxLevel
			end
			guideIndex[#guideIndex + 1] = {
				id = id, title = h.title, folded = fold(h.title), keys = keys, where = where, subtitle = sublabel,
			}
		end
	end
	return guideIndex
end

if ns.On then
	-- Guides.List leaves hidden packs' guides out: re-index when one switches.
	ns.On("GUIDES_REGISTERED", function() guideIndex = nil end)
	ns.On("PACKS_CHANGED", function() guideIndex = nil end)
end

---------------------------------------------------------------------------
-- Query
---------------------------------------------------------------------------

-- Keeps the best `cap` (score, key) pairs of one kind, best first.
local function keep(top, cap, s, i)
	local n = top.n
	if n >= cap and s <= top.s[n] then return end
	local scores, idx = top.s, top.i
	local pos = n < cap and n + 1 or n
	while pos > 1 and scores[pos - 1] < s do
		scores[pos], idx[pos] = scores[pos - 1], idx[pos - 1]
		pos = pos - 1
	end
	scores[pos], idx[pos] = s, i
	if n < cap then top.n = n + 1 end
end

local META = "^([^,]*),(%d*),(%a?),(%d+)"

-- Candidates read per kind and query, best tiers first. A broad query ("s",
-- "in", "gar eth") can touch thousands of names; past this the rest only
-- counts as "more", which keeps a keystroke within a few milliseconds.
local BUDGET = 200

-- One kind's matches in its index blob, best `cap` kept in `top` (keys are
-- the positions of the lines' "\1"). Every line is matched by plain finds
-- over the one string, tier by tier: name prefixes ("\2" .. q), then (2+
-- letters) word prefixes (" " .. q), anywhere, and (several words) lines
-- holding every word. A line counts once, at its best tier. -> matches, more
local function scanBlob(blob, kind, body, short, words, cap, top)
	local seen, ids, n, reads = {}, {}, 0, 0
	local function hit(e, t)
		if seen[e] then return end
		seen[e] = true
		local id, _, st, len = match(blob, META, e + 1)
		-- An id found by its English and its localised name counts once, at
		-- the better tier (the tiers run best first).
		if ids[id] then return end
		ids[id] = true
		n = n + 1
		local standing = st ~= "" and 0 or curated[tonumber(id)] and 2 or 1
		keep(top, cap, score(t, kind, tonumber(len) or 0, standing), e)
	end
	-- -> true when the budget ran out with candidates left
	local function each(q, tierOf)
		local at = find(blob, q, 1, true)
		while at do
			local e = find(blob, "\1", at, true)
			if not e then return false end
			-- A find past the name (in a line's id or numbers) shows as the
			-- next line's "\2" before the next "\1".
			local s2 = find(blob, "\2", at + 1, true)
			if s2 and s2 < e then
				at = find(blob, q, s2, true)
			else
				if not seen[e] then
					if reads >= BUDGET then return true end
					reads = reads + 1
					local t = tierOf(at, e)
					if t then hit(e, t) end
				end
				at = find(blob, q, e, true)
			end
		end
		return false
	end
	local blen = #body
	if each("\2" .. body, function(at, e) return e == at + 1 + blen and EXACT or PREFIX end) then return n, true end
	if short then return n, false end
	if each(" " .. body, function() return WORD end) then return n, true end
	if each(body, function() return SUBSTRING end) then return n, true end
	if words then
		local longest = words[1]
		for i = 2, #words do if #words[i] > #longest then longest = words[i] end end
		if each(longest, function(at, e)
			if seen[e] then return nil end
			local s = at
			while byte(blob, s) ~= 2 do s = s - 1 end
			local f = sub(blob, s + 1, e - 1)
			for i = 1, #words do
				if not find(f, words[i], 1, true) then return nil end
			end
			return WORDS
		end) then return n, true end
	end
	return n, false
end

local function wants(kinds, kind)
	return kinds == nil or kinds[kind]
end

local function guideTier(g, q, body, short, words)
	local best = tier(g.folded, q, body, short, words)
	if best == EXACT then return best end
	for i = 1, #g.keys do
		local t = tier(g.keys[i], q, body, short, words)
		-- A keyword is an alternative name, one tier below the title.
		if t then t = t - 1 end
		if t and (not best or t > best) then best = t end
	end
	if not best then
		for i = 1, #g.where do
			local t = tier(g.where[i], q, body, short, words)
			if t and t >= WORD then return SUBSTRING end
		end
	end
	return best
end

function Search.Query(text, opts)
	opts = opts or {}
	local results, counts, more = {}, {}, {}
	if type(text) ~= "string" then return results, counts, more end
	local q = fold(text)
	if q == "" or q == " " then return results, counts, more end
	local body = sub(q, 2)
	local short = #body < 2
	local words
	if find(body, " ", 1, true) then
		words = {}
		for w in body:gmatch("%S+") do words[#words + 1] = w end
	end
	local kinds = opts.kinds
	local limit = opts.limit or DEFAULT_LIMIT
	local offset = opts.offset or 0
	local several = 0
	for _, k in ipairs(Search.KINDS) do
		if wants(kinds, k.key) then several = several + 1 end
	end
	local cap = opts.perKind or (several > 1 and min(DEFAULT_PER_KIND, limit) or limit)
	local keepN = cap + offset

	-- Built (and cached) even when guides are not asked for: it holds the
	-- curated `collects` set that ranks items.
	local list = guideList()
	if wants(kinds, "guide") then
		local top, n = { n = 0, s = {}, i = {} }, 0
		for i = 1, #list do
			local g = list[i]
			local t = guideTier(g, q, body, short, words)
			if t then
				n = n + 1
				keep(top, keepN, score(t, "guide", #g.title), i)
			end
		end
		if n > 0 then counts.guide = n end
		for j = offset + 1, top.n do
			local g = list[top.i[j]]
			results[#results + 1] = { kind = "guide", id = g.id, title = g.title, subtitle = g.subtitle, score = top.s[j] }
		end
	end

	-- The Codex kinds load the Codex pack on the first query that wants them.
	local wantCodex = false
	for _, k in ipairs(Search.KINDS) do
		if k.key ~= "guide" and wants(kinds, k.key) and codexOn() then wantCodex = true end
	end
	local C = ns.Codex
	if wantCodex and C and C.IsLoaded and not C.IsLoaded() and C.Load then C.Load() end
	for _, k in ipairs(Search.KINDS) do
		local kind = k.key
		local blob = kind ~= "guide" and wants(kinds, kind) and blobOf(kind)
		if blob then
			local top = { n = 0, s = {}, i = {} }
			local n, capped = scanBlob(blob, kind, body, short, words, keepN, top)
			if n > 0 then counts[kind] = n end
			if capped then more[kind] = true end
			for j = offset + 1, top.n do
				local rawId, quality, st = match(blob, META, top.i[j] + 1)
				local id = kind == "instance" and rawId or tonumber(rawId)
				results[#results + 1] = {
					kind = kind, id = id, title = (localised() and localName(kind, id)) or C.Name(kind, id) or rawId, quality = tonumber(quality), score = top.s[j],
					status = STATUS[st], curated = curated[id] or nil,
				}
			end
		end
	end

	table.sort(results, function(a, b)
		if a.score ~= b.score then return a.score > b.score end
		if a.title ~= b.title then return a.title < b.title end
		return tostring(a.id) < tostring(b.id)
	end)
	for i = #results, limit + 1, -1 do results[i] = nil end
	if opts.subtitles ~= false then
		for _, r in ipairs(results) do Search.Subtitle(r) end
	end
	return results, counts, more
end

-- A result's name in the client's language (Polestar.Names, the client's map
-- name), or nil on an English client or when nothing has one.
function Search.LocalName(kind, id)
	return localised() and localName(kind, id) or nil
end

-- Fills (once) and returns a result's subtitle: one record decode for a
-- Codex entity, so a list asks only for the rows it shows.
function Search.Subtitle(r)
	if r.subtitle == nil and r.kind ~= "guide" then
		local subtitle = ns.Lookup and ns.Lookup.Subtitle
		r.subtitle = subtitle and subtitle(r.kind, r.id) or false
	end
	return r.subtitle or nil
end

function Search.Status()
	local C = ns.Codex
	if not (C and C.IsLoaded) then return false, "missing" end
	if not codexOn() then return false, "off" end
	if C.IsLoaded() then return true, nil end
	if C.IsLoading and C.IsLoading() then return false, "loading" end
	local info = ns.Data and ns.Data.Info and ns.Data.Info(CODEX_PACK)
	return false, (info and info.reason) or "notloaded"
end
