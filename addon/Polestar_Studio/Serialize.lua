-- A draft as Polestar reads it: the compiled guide (what Polestar plays,
-- Guides.Validate's shape) and the source tree (docs/PACK_FORMAT.md, "Source
-- tree": what `node tools/polestar.js decode` writes back as a .guide file),
-- and the `!PS2!` string both travel in (Polestar.Import.Encode / Decode).
--
--   S.Serialize.Payload(doc) -> payload, map   (Model.ToPayload)
--   S.Export(doc) -> string | nil, reason
--   S.Decode(text) -> entry | nil, reason      (a pasted string, not opened)
--   S.Import(text) -> doc | nil, reason        (decoded and opened as a draft)

local ADDON, S = ...
local L = S.L

local Serialize = {}
S.Serialize = Serialize

local type, pairs, ipairs, tostring, tonumber = type, pairs, ipairs, tostring, tonumber
local concat = table.concat

-- Guide format 10: every step Studio writes carries its stable `id`.
local FORMAT = 10

-- Race files as guides write them (Scourge: Undead), classes in title case.
local function raceLabel(file) return file == "Scourge" and "Undead" or file end
local function classLabel(file) return file:sub(1, 1) .. file:sub(2):lower() end
Serialize.RaceLabel, Serialize.ClassLabel = raceLabel, classLabel

local function nonEmpty(list)
	return type(list) == "table" and #list > 0 and list or nil
end

-- A condition list (`only`, header `race`/`class`) as written: Mage,Undead,Horde.
local function conditionText(only)
	if type(only) ~= "table" then return nil end
	local parts = {}
	for _, c in ipairs(only.classes or {}) do parts[#parts + 1] = classLabel(c) end
	for _, r in ipairs(only.races or {}) do parts[#parts + 1] = raceLabel(r) end
	for _, f in ipairs(only.factions or {}) do parts[#parts + 1] = f end
	return #parts > 0 and concat(parts, ",") or nil
end
Serialize.ConditionText = conditionText

local function cleanOnly(only)
	if type(only) ~= "table" then return nil end
	local o = {}
	for _, k in ipairs({ "classes", "races", "factions" }) do
		if nonEmpty(only[k]) then o[k] = S.Copy(only[k]) end
	end
	return next(o) and o or nil
end

local function mapName(map)
	local P = S.P()
	local C = P and P.Compat
	if type(map) == "number" and C and C.MapName then
		local ok, name = pcall(C.MapName, map)
		if ok and type(name) == "string" and name ~= "" then return name end
	end
	return nil
end

-- The first map a goal of the doc stands on, for a header without a zone.
local function firstMap(doc)
	for _, step in ipairs(doc.steps) do
		for _, goal in ipairs(step.goals) do
			if goal.out and type(goal.out.map) == "number" then return goal.out.map end
		end
	end
	return nil
end

local function zoneValue(zone)
	if type(zone) == "number" then return "map " .. zone end
	if type(zone) == "string" and zone ~= "" then
		if zone:lower():match("^map%s") or zone:lower() == "map" then return S.Quote(zone) end
		return zone
	end
	return nil
end

local function merge(into, extra)
	for k, v in pairs(extra or {}) do
		if into[k] == nil then into[k] = S.Copy(v) end
	end
end

-- The source tree's header.
local function sourceHeader(doc)
	local h = doc.header
	local out = { guide = h.id, title = S.OneLine(h.title or "") }
	local lo, hi = tonumber(h.minLevel), tonumber(h.maxLevel)
	if lo and hi then out.levels = ("%d-%d"):format(lo, hi) end
	out.zone = zoneValue(h.zone) or zoneValue(firstMap(doc))
	if h.faction == "Alliance" or h.faction == "Horde" then out.faction = h.faction end
	if nonEmpty(h.races) then out.race = conditionText({ races = h.races }) end
	if nonEmpty(h.classes) then out.class = conditionText({ classes = h.classes }) end
	out.category = S.Model.CATEGORY_OUT[h.category] or h.category
	if type(h.author) == "string" and h.author ~= "" then out.author = S.OneLine(h.author) end
	if nonEmpty(h.credits) then
		out.credits = {}
		for i, c in ipairs(h.credits) do out.credits[i] = S.OneLine(c) end
	end
	if type(h.forkedFrom) == "table" and h.forkedFrom.id then
		out["forked-from"] = ("%s %d"):format(h.forkedFrom.id, tonumber(h.forkedFrom.version) or 1)
	end
	out.version = tostring(tonumber(h.version) or 1)
	if nonEmpty(h.next) then
		out.next = {}
		for i, id in ipairs(h.next) do out.next[i] = S.OneLine(id) end
	end
	merge(out, doc.extra and doc.extra.source)
	return out
end

-- A `when` predicate as written -> its compiled form | nil, why
-- (tools/lib/dsl/when.js parseWhen, then resolve.js resolveWhen).
local WHEN_KINDS = { onquest = true, complete = true, turnedin = true, available = true, has = true, zone = true, subzone = true, bound = true, dungeon = true, done = true }

local function readMoney(text)
	local t = tostring(text or ""):lower()
	if t:match("^%d+$") then return tonumber(t) end
	local total, any = 0, false
	for _, unit in ipairs({ { "g", 10000 }, { "s", 100 }, { "c", 1 } }) do
		local n, rest = t:match("^(%d+)" .. unit[1] .. "(.*)$")
		if n then
			total = total + tonumber(n) * unit[2]
			t, any = rest, true
		end
	end
	if t ~= "" or not any then return nil end
	return total
end
Serialize.ReadMoney = readMoney

local function nameArg(text)
	local t = text:match("^%s*(.-)%s*$")
	local q = t:match('^"(.*)"$')
	if q then return (q:gsub("\\([\"\\])", "%1")) end
	if t:find('"', 1, true) or t == "" then return nil end
	return t
end

function Serialize.ParseWhen(text)
	text = S.OneLine(text)
	if text == "" then return nil, L["A condition needs a predicate."] end
	local neg, op, n = text:match("^(!?)[Ll][Ee][Vv][Ee][Ll]%s*([<>]=?)%s*([%d%.]+)$")
	if op then
		if neg ~= "" then return nil, L["`level` takes no `!`: turn the comparison around."] end
		local v = tonumber(n)
		if not v or v < 1 or v >= 61 then return nil, L["A level is 1 to 60."] end
		local w = { k = "level", op = op, n = math.floor(v) }
		local frac = S.Round2(v - math.floor(v))
		if frac > 0 and frac < 1 then w.frac = frac end
		return w
	end
	local mneg, mop, amount = text:match("^(!?)[Mm][Oo][Nn][Ee][Yy]%s*([<>]=?)%s*(%S+)$")
	if mop then
		if mneg ~= "" then return nil, L["`money` takes no `!`: turn the comparison around."] end
		local c = readMoney(amount)
		if not c then return nil, L["Write money as copper or 1g50s, 7s, 25c."] end
		return { k = "money", op = mop, n = c }
	end
	local bang, kind, rest = text:match("^(!?)(%a+)%s*(.*)$")
	kind = kind and kind:lower()
	if not (kind and WHEN_KINDS[kind]) then return nil, (L["Unknown condition: %s"]):format(text) end
	local w = { k = kind }
	if bang == "!" then w.neg = true end
	if kind == "onquest" then
		local q, seen = {}, {}
		for id in rest:gmatch("[^%s,]+") do
			local v = tonumber(id)
			if not v or v <= 0 or v % 1 ~= 0 then return nil, L["`onquest` needs quest ids."] end
			if not seen[v] then
				seen[v] = true
				q[#q + 1] = v
			end
		end
		if #q == 0 then return nil, L["`onquest` needs quest ids."] end
		w.q = q
	elseif kind == "complete" or kind == "turnedin" or kind == "available" then
		local v = tonumber(rest:match("^(%d+)$"))
		if not v or v <= 0 then return nil, L["This condition needs one quest id."] end
		w.q = v
		if kind == "available" then
			local X = S.Resolve.Codex()
			local ok, rec = false, nil
			if X and X.Quest then ok, rec = pcall(X.Quest, v) end
			if ok and rec then
				if type(rec.minLevel) == "number" and rec.minLevel > 0 then w.minLevel = rec.minLevel end
				if nonEmpty(rec.preAny) then w.pre = S.Copy(rec.preAny) end
				if nonEmpty(rec.pre) then w.preAll = S.Copy(rec.pre) end
			end
		end
	elseif kind == "has" then
		local item, count = rest:match("^(%d+)%s*[xX]?(%d*)$")
		item = tonumber(item)
		if not item or item <= 0 then return nil, L["`has` needs an item id."] end
		w.item = item
		w.n = tonumber(count) or 1
		if w.n < 1 then return nil, L["`has` needs a count of 1 or more."] end
	elseif kind == "done" then
		if not rest:match("^[%w_%-]+$") then return nil, L["`done` needs a step label."] end
		w.label = rest
	else
		local name = nameArg(rest)
		if not name then return nil, L["This condition needs a name."] end
		w.name = name
		if kind ~= "dungeon" then
			local area = S.Resolve.AreaId(name)
			if area then w.area = area end
		end
	end
	return w
end

-- A step's `when` lines -> compiled predicates (the ones that read).
local function compiledWhen(list)
	if not nonEmpty(list) then return nil end
	local out = {}
	for _, text in ipairs(list) do
		local w = Serialize.ParseWhen(text)
		if w then out[#out + 1] = w end
	end
	return #out > 0 and out or nil
end

local NEXT_KEYS = { next = true, nextChoices = true, nextWhen = true }

-- The compiled guide's own keys (steps added by the caller).
local function compiledGuide(doc)
	local h = doc.header
	local g = { id = h.id, title = S.OneLine(h.title or "") }
	if h.faction == "Alliance" or h.faction == "Horde" then g.faction = h.faction end
	if nonEmpty(h.races) then g.races = S.Copy(h.races) end
	if nonEmpty(h.classes) then g.classes = S.Copy(h.classes) end
	g.minLevel, g.maxLevel = tonumber(h.minLevel), tonumber(h.maxLevel)
	g.category = S.Model.CATEGORY_OUT[h.category] or h.category or "Leveling"
	local zone = type(h.zone) == "number" and h.zone or (h.zone == nil and firstMap(doc)) or nil
	if type(zone) == "number" then
		g.zone = zone
		g.zoneName = mapName(zone)
	end
	g.author = type(h.author) == "string" and h.author ~= "" and S.OneLine(h.author) or (S.Handle() or "Polestar")
	g.version = tonumber(h.version) or 1
	if nonEmpty(h.credits) then
		g.credits = {}
		for i, c in ipairs(h.credits) do g.credits[i] = S.OneLine(c) end
	end
	if type(h.forkedFrom) == "table" and h.forkedFrom.id then
		g.forkedFrom = { id = h.forkedFrom.id, version = tonumber(h.forkedFrom.version) or 1 }
	end
	if nonEmpty(h.next) then
		g.next = h.next[1]
		if #h.next > 1 then g.nextChoices = S.Copy(h.next) end
		for k, v in pairs(doc.extra and doc.extra.guide or {}) do
			if g[k] == nil and not NEXT_KEYS[k] then g[k] = S.Copy(v) end
		end
	else
		merge(g, doc.extra and doc.extra.guide)
	end
	return g
end

local function sourceGoal(src)
	local out = { verb = src.verb, args = {}, mods = {} }
	for i, a in ipairs(src.args or {}) do out.args[i] = tostring(a) end
	for i, m in ipairs(src.mods or {}) do
		local mod = {}
		for k, v in ipairs(m) do mod[k] = tostring(v) end
		out.mods[i] = mod
	end
	if type(src.note) == "string" and src.note ~= "" then out.note = S.OneLine(src.note) end
	if type(src.zone) == "string" and src.zone ~= "" then out.zone = src.zone end
	return out
end

-- Era-frame maps the payload's goals use -> their bounds (Polestar's own).
local function framesFor(guide)
	local P = S.P()
	local era = P and P.MapFrames and P.MapFrames.era
	if type(era) ~= "table" then return nil end
	local out
	local function add(map)
		local b = type(map) == "number" and era[map]
		if b and not (out and out[map]) then
			out = out or {}
			out[map] = { c = b.c, left = b.left, right = b.right, top = b.top, bottom = b.bottom }
		end
	end
	for _, step in ipairs(guide.steps) do
		for _, goal in ipairs(step.goals) do
			if goal.f == "e" then add(goal.map) end
			for _, c in ipairs(goal.candidates or {}) do
				if c.f == "e" then add(c.map) end
			end
		end
	end
	return out
end

function Serialize.Payload(doc)
	local guide = compiledGuide(doc)
	local tree = { v = 1, header = sourceHeader(doc), steps = {} }
	guide.steps = {}
	local map = {}
	local group = false
	for i, step in ipairs(doc.steps) do
		local outs, srcs, goalMap = {}, {}, {}
		for j, goal in ipairs(step.goals) do
			if type(goal.out) == "table" and type(goal.src) == "table" then
				outs[#outs + 1] = S.Copy(goal.out)
				srcs[#srcs + 1] = sourceGoal(goal.src)
				goalMap[#outs] = j
				if goal.out.group and not goal.out.optional then group = true end
			end
		end
		if #outs > 0 then
			local cs = { id = step.id, goals = outs }
			if type(step.title) == "string" and step.title ~= "" then cs.title = S.OneLine(step.title) end
			if type(step.note) == "string" and step.note ~= "" then cs.note = step.note end
			cs.only = cleanOnly(step.only)
			cs.when = compiledWhen(step.when)
			merge(cs, step.extra and step.extra.guide)
			local ss = { title = S.OneLine(step.title or ""), id = step.id, goals = srcs }
			ss.only = conditionText(cleanOnly(step.only))
			if nonEmpty(step.when) then
				ss.when = {}
				for k, w in ipairs(step.when) do ss.when[k] = S.OneLine(w) end
			end
			if type(step.note) == "string" and step.note ~= "" then
				local lines = {}
				for raw in (step.note .. "\n"):gmatch("([^\n]*)\n") do
					local line = S.OneLine(raw)
					if line ~= "" then lines[#lines + 1] = line end
				end
				if #lines > 0 then ss.tip = concat(lines, "\n") end
			end
			merge(ss, step.extra and step.extra.source)
			guide.steps[#guide.steps + 1] = cs
			tree.steps[#tree.steps + 1] = ss
			map[#guide.steps] = { step = i, goals = goalMap }
		end
	end
	if group then guide.group = true end
	local payload = { format = FORMAT, license = doc.header.license or "CC-BY-4.0", guide = guide, source = tree }
	payload.frames = framesFor(guide)
	return payload, map
end

---------------------------------------------------------------------------
-- Strings
---------------------------------------------------------------------------

local function importer()
	local P = S.P()
	return P and P.Import
end

function S.Export(doc)
	doc = doc or S.Model.Current()
	if not doc then return nil, L["Open a draft first."] end
	local I = importer()
	if not (I and I.Encode) then return nil, L["This Polestar cannot write import strings: update Polestar."] end
	local payload = S.Model.ToPayload(doc)
	if #payload.guide.steps == 0 then return nil, L["The guide has no step with a goal yet."] end
	local ok, text, reason = pcall(I.Encode, payload)
	if not ok then return nil, tostring(text) end
	return text, reason
end

function S.Decode(text)
	local I = importer()
	if not (I and I.Decode) then return nil, L["This Polestar cannot read import strings: update Polestar."] end
	local ok, entry, reason = pcall(I.Decode, text)
	if not ok then return nil, tostring(entry) end
	return entry, reason
end

function S.Import(text)
	local entry, reason = S.Decode(text)
	if not entry then return nil, reason end
	return S.Model.Open(entry)
end
