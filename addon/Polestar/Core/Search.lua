-- Polestar.Search: one search over guides and every Codex entity, shared by
-- the guide menu's search box and the Lookup window. Contract:
-- docs/ARCHITECTURE.md, "Core services: Data, Hooks, Search".
--
--   Search.Query(text, opts) -> results, counts
--     opts = { kinds = { item = true, ... } | nil (all), resultKind = nil,
--              order = "best" | "az", hideRetired = false, hideNoSource = false,
--              limit = 60, perKind = n, offset = n, subtitles = false }
--     resultKind restricts the returned rows, with counts still filled for
--     all requested kinds. offset pages within each kind. A to Z applies
--     to a single result kind and uses Browse's order.
--     result = { kind, id, title, subtitle|nil, quality|nil, score, status|nil, curated|nil }
--       status: Codex item status ("retired" = no longer obtainable, "nosource");
--       curated: a guide of the suggestion source or Polestar's own `collects`
--       the item, as Lookup's curated guide looks
--     Best match: items a curated guide collects first, then everything else,
--     then retired or sourceless items; then exact > prefix > word prefix >
--     substring (> every word somewhere), then Search.KINDS order, then
--     shorter names, title and id. counts[kind] is the exact positive total
--     after visibility filters and before paging or preview limits
--     (perKind: 20 with several result kinds, else limit). A one-letter
--     Codex query matches name prefixes only.
--   Search.Browse(kind, opts) -> results, count
--     opts = { offset = 0, limit = 60, subtitles = false, hideRetired = false, hideNoSource = false }
--     Results have the same fields without a score, A to Z with unavailable
--     entries last. The order is cached on first use, and only the page is named.
--   Search.BrowseCount(kind, opts) -> count|nil   -- same visibility filters; no sorting or loading
--   Search.Subtitle(result) -> text|nil   -- guides "Zone · 1-6"; Codex entities Lookup.Subtitle
--   Search.KINDS = { { key, label }, ... }   -- display order
--   Search.Status() -> codexLoaded, reason   -- reason: Data.Pack's code
--     ("missing", "disabled", "combat", ...), "loading" while the pack loads,
--     "notloaded" before any try, or "off" when the Lookup module is switched
--     off (lookup.enabled): then queries list guides only and never load the Codex.
--
-- Speed: the Codex ships a prebuilt index per kind (Codex.Index: one string
-- of folded names), so a keystroke jumps between hits with plain string.find
-- and never decodes a record. Only returned rows and Best match ties that
-- can affect the page need display names. Subtitle decoding is separate
-- and can wait until the UI draws the row. Guide headers are
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

local guideIndex, guideCount, guideSource, pagedSearch
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
local localIndex = {} -- kind -> { base = Codex blob, extra = translated lines only }

local function localised()
	local N = ns.Names
	return N and N.Localised() or false
end

-- A Codex entity's name in the client's language, or nil; never asks the
-- server (Names.Cached). A dungeon or raid by its map (Names.Instance).
local function localName(kind, id, cursor)
	if kind == "instance" then
		local C = ns.Codex
		local inst = C and C.Instance and C.Instance(id)
		return inst and type(inst.map) == "number" and ns.Names.Instance(inst.map) or nil
	end
	local nk = NAMES_KIND[kind]
	if not nk or type(id) ~= "number" then return nil end
	if nk == "zone" then return ns.Compat.GetMapName(id) end
	return ns.Names.Cached(nk, id, cursor)
end

local function translatedBlob(kind, blob)
	if not (NAMES_KIND[kind] and localised()) then return nil end
	local cached = localIndex[kind]
	if cached and cached.base == blob then return cached.extra end
	local lines, cursor = {}, {}
	for folded, id, quality, st in gmatch(blob, "\2([^\1]*)\1([^,]*),(%d*),(%a?),%d+\n") do
		local name = localName(kind, tonumber(id), cursor)
		if name then
			local f = sub(fold(name), 2)
			if f ~= folded and f ~= "" then
				lines[#lines + 1] = "\2" .. f .. "\1" .. id .. "," .. quality .. "," .. st .. "," .. #name .. "\n"
			end
		end
	end
	local extra = lines[1] and table.concat(lines) or nil
	-- Do not retain a copy of the English catalogue alongside its translations.
	if ns.Names.Ready() then localIndex[kind] = { base = blob, extra = extra } end
	return extra
end

-- The guides search offers: those this character can follow, as the guide
-- menu lists them (Guides.GuideMatches, or their side's other starting
-- zones): never the other faction's (#2462), nor another class's or race's.
local function guideList()
	local G = ns.Guides
	local list = G and G.List and G.List() or {}
	local source = G and G.SuggestSource and G.SuggestSource() or "guides"
	if guideIndex and guideCount == #list and guideSource == source then return guideIndex end
	guideCount, guideSource = #list, source
	guideIndex = {}
	curated = {}
	local player = ns.Compat.GetPlayerInfo()
	for _, h in ipairs(list) do
		local id = h.id
		local fits = G.GuideMatches(h, player) or G.OtherStart(h, player)
		if fits and type(id) == "string" and sub(id, 1, 7) ~= "lookup/" and type(h.collects) == "table"
			and (h.pack == source or h.pack == "guides") then
			for i = 1, #h.collects do curated[h.collects[i]] = true end
		end
		if fits and type(id) == "string" and sub(id, 1, 7) ~= "lookup/" and type(h.title) == "string" then
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
			local lo, hi = G.Levels(h)
			if lo and hi then
				sublabel = (sublabel and (sublabel .. " \194\183 ") or "") .. lo .. "-" .. hi
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
	ns.On("NAMES_LOADED", function() localIndex, pagedSearch = {}, nil end)
	ns.On("CODEX_LOADED", function() pagedSearch = nil end)
end

local META = "^([^,]*),(%d*),(%a?),(%d+)"
local RANK_META = "^([^,]*),%d*,(%a?),(%d+)"
local RANK_NO_ID = "^[^,]*,%d*,(%a?),(%d+)"
local RAW_ID = "^[^,]*"

local function hidden(st, opts)
	return (st == "r" and opts.hideRetired) or (st == "n" and opts.hideNoSource)
end

local function loadCodex()
	local C = ns.Codex
	if codexOn() and C and C.IsLoaded and not C.IsLoaded() and C.Load then C.Load() end
end

local function codexTitle(kind, id, rawId, localNames)
	return (localNames and localName(kind, id)) or ns.Codex.Name(kind, id) or rawId
end

local function codexRow(kind, blob, at, title)
	local rawId, quality, st = match(blob, META, at)
	local id = kind == "instance" and rawId or tonumber(rawId)
	return { kind = kind, id = id, title = title or codexTitle(kind, id, rawId, localised()),
		quality = tonumber(quality), status = STATUS[st], curated = curated[id] or nil }
end

---------------------------------------------------------------------------
-- Browse
---------------------------------------------------------------------------

local browseCounts, browseIndexes = {}, {}
local guideBrowseSource, guideOrder
local BROWSE_LINE = "\2([^\1]*)\1()([^,]*),%d*,(%a?),(%d+)\n"

function Search.BrowseCount(kind, opts)
	if kind == "guide" then return #guideList() end
	local blob = codexBlob(kind)
	if not blob then return Search.Status() and ns.Codex.Index and 0 or nil end
	local cached = browseCounts[kind]
	if not cached or cached.blob ~= blob then
		local count = 0
		for _ in gmatch(blob, "\n") do count = count + 1 end
		cached = { blob = blob, count = count }
		browseCounts[kind] = cached
	end
	local count = cached.count
	if opts and (opts.hideRetired or opts.hideNoSource) then
		if not cached.r then
			local retired, nosource = 0, 0
			for st in gmatch(blob, ",([rn]),%d+\n") do
				if st == "r" then retired = retired + 1 else nosource = nosource + 1 end
			end
			cached.r, cached.n = retired, nosource
		end
		if opts.hideRetired then count = count - cached.r end
		if opts.hideNoSource then count = count - cached.n end
	end
	return count
end

local function orderedGuides(list)
	if guideBrowseSource == list then return guideOrder end
	local order = {}
	for i = 1, #list do order[i] = i end
	table.sort(order, function(i, j)
		local a, b = list[i], list[j]
		if a.folded ~= b.folded then return a.folded < b.folded end
		if #a.title ~= #b.title then return #a.title < #b.title end
		return a.id < b.id
	end)
	guideBrowseSource, guideOrder = list, order
	return order
end

local function orderedCodex(kind, blob, extra)
	local cached = browseIndexes[kind]
	if cached and cached.blob == blob and cached.extra == extra then return cached end

	local translations = {}
	if extra then
		for folded, _, id, _, len in gmatch(extra, BROWSE_LINE) do
			translations[id] = { folded = folded, len = tonumber(len) }
		end
	end
	local order, translatedAt = {}, {}
	local retired, nosource = 0, 0
	for folded, at, rawId, st, len in gmatch(blob, BROWSE_LINE) do
		local entry = translations[rawId] or { folded = folded, len = tonumber(len) }
		if translations[rawId] then translatedAt[rawId] = at end
		entry.at = at
		entry.id = kind == "instance" and rawId or tonumber(rawId)
		entry.status = st
		if st == "r" then retired = retired + 1 elseif st == "n" then nosource = nosource + 1 end
		order[#order + 1] = entry
	end
	table.sort(order, function(a, b)
		local unavailableA, unavailableB = STATUS[a.status] ~= nil, STATUS[b.status] ~= nil
		if unavailableA ~= unavailableB then return not unavailableA end
		if a.folded ~= b.folded then return a.folded < b.folded end
		if a.len ~= b.len then return a.len < b.len end
		return a.id < b.id
	end)
	-- The two status-specific tails share the same available prefix.
	local tails, available = { r = {}, n = {} }, #order - retired - nosource
	for i, entry in ipairs(order) do
		local tail = tails[entry.status]
		if tail then tail[#tail + 1] = entry.at end
		order[i] = entry.at
	end
	cached = { blob = blob, extra = extra, order = order, available = available, tails = tails, translations = translatedAt }
	browseIndexes[kind] = cached
	browseCounts[kind] = { blob = blob, count = #order, r = retired, n = nosource }
	return cached
end

function Search.Browse(kind, opts)
	opts = opts or {}
	local results = {}
	local offset, limit = opts.offset or 0, opts.limit or DEFAULT_LIMIT
	if kind == "guide" then
		local list = guideList()
		local order = orderedGuides(list)
		for i = offset + 1, min(#order, offset + limit) do
			local g = list[order[i]]
			results[#results + 1] = { kind = kind, id = g.id, title = g.title, subtitle = g.subtitle }
		end
		return results, #order
	end

	loadCodex()
	local blob = codexBlob(kind)
	if not blob then return results, 0 end
	guideList() -- fills the curated set, also used by Query
	local sorted = orderedCodex(kind, blob, translatedBlob(kind, blob))
	local split, tail = #sorted.order
	if opts.hideRetired or opts.hideNoSource then
		split = sorted.available
		if not opts.hideRetired then tail = sorted.tails.r
		elseif not opts.hideNoSource then tail = sorted.tails.n end
	end
	local count = split + (tail and #tail or 0)
	for i = offset + 1, min(count, offset + limit) do
		local result = codexRow(kind, blob, i <= split and sorted.order[i] or tail[i - split])
		if opts.subtitles ~= false then Search.Subtitle(result) end
		results[#results + 1] = result
	end
	return results, count
end

---------------------------------------------------------------------------
-- Query
---------------------------------------------------------------------------

-- Fold once per query. For several words, scan for the longest word and
-- check each candidate's name for the complete phrase or all its words.
local function queryTerms(text)
	if type(text) ~= "string" then return end
	local q = fold(text)
	if q == "" then return end
	local body = sub(q, 2)
	local short = #body == 1
	local words, needle = nil, short and ("\2" .. body) or body
	if find(body, " ", 1, true) then
		words, needle = {}, ""
		for word in gmatch(body, "%S+") do
			words[#words + 1] = word
			if #word > #needle then needle = word end
		end
	end
	return { q = q, body = body, short = short, words = words, needle = needle }
end

-- Visit each matching line once. For count-only searches a simple query
-- needs neither the full name nor its metadata; skip straight to the next hit.
local function scanNames(blob, kind, terms, ranked, hit)
	local needle, words, short = terms.needle, terms.words, terms.short
	local nameOnly = short or (kind ~= "instance" and #needle > 1 and not find(needle, "%d"))
	local at, last = find(blob, needle, 1, true)
	local n = 0
	while at do
		local e = find(blob, "\1", last + 1, true)
		if not e then break end
		local nl = not nameOnly and find(blob, "\n", at, true)
		if nl and nl < e then
			at, last = find(blob, needle, nl + 1, true)
		else
			local t = SUBSTRING
			if words then
				local start = at - 1
				while byte(blob, start) ~= 2 do start = start - 1 end
				t = tier(" " .. sub(blob, start + 1, e - 1), terms.q, terms.body, false, words)
			elseif ranked then
				local b = byte(blob, at - 1)
				if short or b == 2 then
					t = last + 1 == e and EXACT or PREFIX
				elseif b == 32 or find(sub(blob, at, e - 1), terms.q, 1, true) then
					t = WORD
				end
			end
			if t then
				if hit then hit(e + 1, t) else n = n + 1 end
			end
			at, last = find(blob, needle, (nl or e) + 1, true)
		end
	end
	return n
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

local function bestFirst(a, b)
	if a.score ~= b.score then return a.score > b.score end
	if a.title ~= b.title then return a.title < b.title end
	return tostring(a.id) < tostring(b.id)
end

local function searchGuides(list, terms, az, show)
	local hits, n = {}, 0
	local order = az and orderedGuides(list)
	for i = 1, #list do
		local g = list[order and order[i] or i]
		local t = guideTier(g, terms.q, terms.body, terms.short, terms.words)
		if t then
			n = n + 1
			if show then
				hits[n] = { kind = "guide", id = g.id, title = g.title, subtitle = g.subtitle,
					score = not az and score(t, "guide", #g.title) or nil }
			end
		end
	end
	if show and not az then table.sort(hits, bestFirst) end
	return hits, n
end

-- A later keystroke often finds lines the last one found too. Cache the
-- query-independent part of their score by offset, without storing names.
local scoreIndexes = {}
local function searchCodex(kind, blob, extra, list, terms, opts, show, az, full, cap)
	local hideRetired, hideNoSource = opts.hideRetired, opts.hideNoSource
	local useLocalName = show and not az and localised()
	-- Only the paged kind needs a complete ordered list. The guide index
	-- participates in its key because its curated set affects item scores.
	local cached = full and pagedSearch
	if cached and cached.kind == kind and cached.blob == blob and cached.extra == extra
		and cached.guides == list and cached.q == terms.q and cached.az == az
		and cached.localNames == useLocalName
		and cached.hideRetired == hideRetired and cached.hideNoSource == hideNoSource then
		return cached.hits, cached.n
	end
	if not (show or extra or hideRetired or hideNoSource) then
		return nil, scanNames(blob, kind, terms, false)
	end

	local ranked = show and not az
	local hits, n = {}, 0
	local buckets = ranked and full and {}
	local seen = extra and {}
	local sorted = az and orderedCodex(kind, blob, extra)
	local marked = az and {}
	local usesCurated = ranked and next(curated) ~= nil
	local kindWeight = (KIND_INDEX[kind] or 99) * 10000
	local filter = hideRetired or hideNoSource
	local floorScore
	local baseScores
	if ranked and not (seen or filter or full) then
		local cached = scoreIndexes[kind]
		if not cached or cached.blob ~= blob or cached.guides ~= list then
			cached = { blob = blob, guides = list, scores = {} }
			scoreIndexes[kind] = cached
		end
		baseScores = cached.scores
	end
	local function name(rawId)
		local id = kind == "instance" and rawId or tonumber(rawId)
		return codexTitle(kind, id, rawId, useLocalName)
	end
	local function title(entry)
		if not entry.title then entry.title = name(entry.id) end
		return entry.title
	end
	local function before(a, b)
		if a.score ~= b.score then return a.score > b.score end
		local an, bn = title(a), title(b)
		if an ~= bn then return an < bn end
		return a.id < b.id
	end
	local function keep(at, id, s, translation)
		if buckets then
			local bucket = buckets[s]
			if not bucket then
				bucket = { score = s }
				buckets[s] = bucket
				hits[#hits + 1] = bucket
			end
			bucket[#bucket + 1] = translation and -at or at
			return
		end
		if floorScore and s < floorScore then return end
		local last = #hits
		local tail = last == cap and hits[last]
		local text
		if tail and s == tail.score then
			text = name(id)
			local against = title(tail)
			if text > against or (text == against and id >= tail.id) then return end
		end
		local entry = { at = at, id = id, score = s, translation = translation, title = text }
		local pos = tail and last or last + 1
		while pos > 1 and before(entry, hits[pos - 1]) do
			hits[pos] = hits[pos - 1]
			pos = pos - 1
		end
		hits[pos] = entry
		if #hits == cap then floorScore = hits[cap].score end
	end
	local function scan(source, translation)
		scanNames(source, kind, terms, ranked, function(at, t)
			if floorScore and not (seen or filter or usesCurated)
				and floorScore > 10000000 + t * 1000000 - kindWeight then
				n = n + 1
				return
			end
			if baseScores then
				n = n + 1
				local base = baseScores[at]
				if not base then
					local st, len = match(source, RANK_NO_ID, at)
					local standing = st ~= "" and 0 or 1
					if standing == 1 and usesCurated and curated[tonumber(match(source, RAW_ID, at))] then standing = 2 end
					base = standing * 10000000 - kindWeight - min(tonumber(len), 9999)
					baseScores[at] = base
				end
				local s = base + t * 1000000
				if not floorScore or s >= floorScore then keep(at, match(source, RAW_ID, at), s) end
				return
			end
			local rawId, st, len
			if seen or usesCurated then
				rawId, st, len = match(source, RANK_META, at)
			elseif ranked or filter then
				st, len = match(source, RANK_NO_ID, at)
			end
			if filter and hidden(st, opts) then return end
			local prior = seen and seen[rawId]
			if not prior then n = n + 1 end
			if ranked then
				local standing = st ~= "" and 0 or usesCurated and curated[tonumber(rawId)] and 2 or 1
				local s = standing * 10000000 + t * 1000000 - kindWeight - min(tonumber(len), 9999)
				if not seen then
					if not floorScore or s >= floorScore then
						keep(at, rawId or (not buckets and match(source, RAW_ID, at)), s)
					end
				elseif not prior or prior.tier < t then
					seen[rawId] = { at = at, id = rawId, score = s, tier = t, translation = translation }
				end
			else
				if seen then seen[rawId] = true end
				if az then marked[translation and sorted.translations[rawId] or at] = true end
			end
		end)
	end
	scan(blob, false)
	if extra then
		scan(extra, true)
		if ranked then
			for _, entry in pairs(seen) do keep(entry.at, entry.id, entry.score, entry.translation) end
		end
	end
	if az then
		-- Filter Browse's cached offsets in their existing order.
		for _, at in ipairs(sorted.order) do
			if marked[at] then hits[#hits + 1] = at end
		end
	elseif full then
		table.sort(hits, function(a, b) return a.score > b.score end)
	end
	if full then
		pagedSearch = { kind = kind, blob = blob, extra = extra, guides = list, q = terms.q, az = az,
			localNames = useLocalName, hideRetired = hideRetired, hideNoSource = hideNoSource, hits = hits, n = n }
	end
	return hits, n
end

-- Only name equal-score groups that overlap a requested page. Their keys
-- compare by title and id in C, and preserve the source and offset to page.
local function orderBucket(kind, blob, extra, bucket)
	local useLocalName = localised()
	for i, at in ipairs(bucket) do
		local rawId = at < 0 and match(extra, RAW_ID, -at) or match(blob, RAW_ID, at)
		local id = kind == "instance" and rawId or tonumber(rawId)
		bucket[i] = codexTitle(kind, id, rawId, useLocalName) .. "\0" .. rawId .. "\0" .. at
	end
	table.sort(bucket)
	bucket.ordered = true
end

local function appendRankedPage(results, kind, blob, extra, hits, offset, cap)
	local start, stop = offset + 1, offset + cap
	for _, bucket in ipairs(hits) do
		if start <= #bucket then
			if #bucket > 1 and not bucket.ordered then orderBucket(kind, blob, extra, bucket) end
			for i = math.max(start, 1), min(stop, #bucket) do
				local at, title = bucket[i], nil
				if bucket.ordered then
					title, at = match(at, "^([^%z]*)%z[^%z]*%z(-?%d+)$")
					at = tonumber(at)
				end
				local r = at < 0 and codexRow(kind, extra, -at, title) or codexRow(kind, blob, at, title)
				r.score = bucket.score
				results[#results + 1] = r
			end
		end
		start, stop = start - #bucket, stop - #bucket
		if stop <= 0 then return end
	end
end

function Search.Query(text, opts)
	opts = opts or {}
	local results, counts = {}, {}
	local terms = queryTerms(text)
	if not terms then return results, counts end
	local kinds = opts.kinds
	local limit, offset = opts.limit or DEFAULT_LIMIT, opts.offset or 0
	local only = opts.resultKind
	if not only and kinds then
		for _, k in ipairs(Search.KINDS) do
			if kinds[k.key] then
				if only then only = nil; break end
				only = k.key
			end
		end
	end
	local cap = opts.perKind or (only and limit or min(DEFAULT_PER_KIND, limit))
	local az = only and opts.order == "az" or false

	-- Built even when guides are not asked for: it holds the curated set.
	local list = guideList()
	if wants(kinds, "guide") then
		local show = not only or only == "guide"
		local hits, n = searchGuides(list, terms, az and show, show)
		if n > 0 then counts.guide = n end
		for j = offset + 1, min(#hits, offset + cap) do results[#results + 1] = hits[j] end
	end

	for _, k in ipairs(Search.KINDS) do
		if k.key ~= "guide" and wants(kinds, k.key) then loadCodex(); break end
	end
	for _, k in ipairs(Search.KINDS) do
		local kind = k.key
		local blob = kind ~= "guide" and wants(kinds, kind) and codexBlob(kind)
		if blob then
			local extra = translatedBlob(kind, blob)
			local show = (not only or only == kind) and cap > 0
			local full = show and only ~= nil
			local alpha = show and az
			local hits, n = searchCodex(kind, blob, extra, list, terms, opts, show, alpha, full, cap + offset)
			if n > 0 then counts[kind] = n end
			if full and not alpha then
				appendRankedPage(results, kind, blob, extra, hits, offset, cap)
			elseif show then
				for j = offset + 1, min(#hits, offset + cap) do
					local hit = hits[j]
					local source = not alpha and hit.translation and extra or blob
					local r = codexRow(kind, source, alpha and hit or hit.at, not alpha and hit.title or nil)
					if not alpha then r.score = hit.score end
					results[#results + 1] = r
				end
			end
		end
	end

	if not only then table.sort(results, bestFirst) end
	for i = #results, limit + 1, -1 do results[i] = nil end
	if opts.subtitles ~= false then
		for _, r in ipairs(results) do Search.Subtitle(r) end
	end
	return results, counts
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
