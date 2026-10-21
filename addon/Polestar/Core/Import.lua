-- Import strings: a small guide shared as one line of text, pasted on the
-- Import page (UI/Import.lua, `/polestar import`) instead of installed as a
-- community addon. Contract: docs/PACK_FORMAT.md, "Import strings"; the
-- writer is tools/lib/pack/importstring.js (`polestar export`).
--
--   !PS1!<Adler-32 of the payload, 8 hex digits>!<base64 of zlib of the payload>
--
-- The payload is JSON: { format, license, guide, frames? }, the guide as the
-- compiler writes it into a community addon's Guides.lua. A string is data,
-- never code: the client's own decoders (C_EncodingUtil, as Polestar_Nav's
-- walking maps use them) unpack it, the JSON is read here by hand, and the
-- guide is built field by field from a fixed set of keys (SCHEMA below, the
-- compiler's own key lists: a test holds them equal) before the registry's
-- checks (Guides.Validate) see it. Nothing in a string is ever run.
--
-- Imported guides belong to the pack `imported` (Core/Guides.lua: reserved,
-- registered here as this file loads; its guides keep their authors' ids,
-- `yendi/cozy-sleeping-bag`) and are kept account-wide, as decoded, in
-- PolestarDB.imports[guideId] = { format, license, guide, frames }. They
-- register at login (Import.Load, from Guides.lua's login handler) through
-- the same checks as a pasted string, so a store edited by hand cannot carry
-- anything a string could not.
--
--   Import.Decode(text) -> entry | nil, reason
--   Import.Preview(text) -> info | nil, reason   -- info: what the page shows, state "new"|"update"|"same"|"older"
--   Import.Save(entry) -> ok, reason              -- import or update; fires PACKS_CHANGED("imported")
--   Import.Delete(id) -> bool                     -- fires PACKS_CHANGED("imported")
--   Import.List() -> { { id, title, author, version, license, steps, problem }, ... }  -- by title
--   Import.Load()                                 -- at login: register the store
--   Import.LIMITS, Import.KEYS                    -- the caps and the key lists, for the tests

local ADDON, ns = ...
local L = ns.L
local Guides = ns.Guides

local type, pairs, ipairs, tostring, tonumber, pcall, error = type, pairs, ipairs, tostring, tonumber, pcall, error
local byte, sub, find, char, format, lower, gsub = string.byte, string.sub, string.find, string.char, string.format, string.lower, string.gsub
local concat, floor, huge = table.concat, math.floor, math.huge

local Import = {}
ns.Import = Import

local PACK = "imported"
-- The caps tools/lib/pack/importstring.js applies (a test holds them equal):
-- characters in a string, steps in its guide, bytes of the payload, bytes in
-- any one text or key of it, bytes in any names/written value (a token's
-- English game name, capped at a game-name length), goals per step and
-- candidates per goal (limits from the largest our own compiler emits; large
-- enough that our own guides are never refused, tight enough to prevent
-- route-planner blow-up from imported strings).
local LIMITS = { length = 50000, steps = 60, payload = 262144, text = 4096, names = 128, goals = 100, candidates = 128 }
Import.LIMITS = LIMITS

ns.RegisterPack({ id = PACK, imported = true, title = L["Imported"] })

---------------------------------------------------------------------------
-- JSON, data only: objects, arrays, strings, numbers, true and false (no
-- null: the compiler never writes one). A failure raises { json = why }.
---------------------------------------------------------------------------

local MAX_DEPTH = 12
-- Only the two control characters the compiler and guide authors write: newline
-- and tab. Backspace, form-feed and carriage-return (\b \f \r) are refused;
-- so are \u0000-\u001F other than \n (0x0A) and \t (0x09).
local ESCAPES = { [34] = '"', [92] = "\\", [47] = "/", [110] = "\n", [116] = "\t" }

local function utf8(cp)
	if cp < 0x80 then return char(cp) end
	if cp < 0x800 then return char(0xC0 + floor(cp / 64), 0x80 + cp % 64) end
	if cp < 0x10000 then return char(0xE0 + floor(cp / 4096), 0x80 + floor(cp / 64) % 64, 0x80 + cp % 64) end
	return char(0xF0 + floor(cp / 262144), 0x80 + floor(cp / 4096) % 64, 0x80 + floor(cp / 64) % 64, 0x80 + cp % 64)
end

local function parseJSON(s)
	local pos, depth = 1, 0
	local function fail(why) error({ json = why }, 0) end
	local function skip() pos = find(s, "[^ \t\r\n]", pos) or (#s + 1) end
	local function str()
		local i, parts, n = pos + 1, {}, 0
		while true do
			local j = find(s, '["\\%z\1-\31]', i)
			if not j then fail("unterminated string") end
			if j > i then
				n = n + 1
				parts[n] = sub(s, i, j - 1)
			end
			local c = byte(s, j)
			if c == 34 then
				pos = j + 1
				return concat(parts)
			end
			if c ~= 92 then fail("control character in a string") end
			local e = byte(s, j + 1)
			if e == 117 then
				local h = sub(s, j + 2, j + 5)
				if not find(h, "^%x%x%x%x$") then fail("bad escape") end
				local cp, after = tonumber(h, 16), j + 6
				-- Refuse NUL and non-printable control chars other than \n / \t.
				if cp < 0x20 and cp ~= 0x09 and cp ~= 0x0A then fail("control character in a string") end
				if cp >= 0xD800 and cp <= 0xDBFF then
					local low = sub(s, j + 6, j + 11)
					if not find(low, "^\\u[dD][c-fC-F]%x%x$") then fail("bad surrogate") end
					cp = 0x10000 + (cp - 0xD800) * 1024 + (tonumber(sub(low, 3), 16) - 0xDC00)
					after = j + 12
				elseif cp >= 0xDC00 and cp <= 0xDFFF then
					fail("bad surrogate")
				end
				n = n + 1
				parts[n] = utf8(cp)
				i = after
			else
				local m = e and ESCAPES[e]
				if not m then fail("bad escape") end
				n = n + 1
				parts[n] = m
				i = j + 2
			end
		end
	end
	local value
	local function open()
		depth = depth + 1
		if depth > MAX_DEPTH then fail("nested too deep") end
		pos = pos + 1
		skip()
	end
	-- After a member: `,` goes on, `close` ends. -> true when ended.
	local function after(close)
		skip()
		local d = byte(s, pos)
		pos = pos + 1
		if d == close then
			depth = depth - 1
			return true
		end
		if d ~= 44 then fail("expected , or the end") end
		return false
	end
	function value()
		skip()
		local c = byte(s, pos)
		if c == 123 then -- {
			open()
			local t = {}
			if byte(s, pos) == 125 then
				pos = pos + 1
				depth = depth - 1
				return t
			end
			repeat
				skip()
				if byte(s, pos) ~= 34 then fail("expected a key") end
				local k = str()
				if t[k] ~= nil then fail("a key twice") end
				skip()
				if byte(s, pos) ~= 58 then fail("expected :") end
				pos = pos + 1
				t[k] = value()
			until after(125)
			return t
		elseif c == 91 then -- [
			open()
			local t, n = {}, 0
			if byte(s, pos) == 93 then
				pos = pos + 1
				depth = depth - 1
				return t
			end
			repeat
				n = n + 1
				t[n] = value()
			until after(93)
			return t
		elseif c == 34 then
			return str()
		elseif sub(s, pos, pos + 3) == "true" then
			pos = pos + 4
			return true
		elseif sub(s, pos, pos + 4) == "false" then
			pos = pos + 5
			return false
		end
		local a, b = find(s, "^-?%d+%.?%d*[eE]?[-+]?%d*", pos)
		local v = a and tonumber(sub(s, a, b))
		if not v or v ~= v or v == huge or v == -huge then fail("unexpected text") end
		pos = b + 1
		return v
	end
	local ok, v = pcall(function()
		local r = value()
		skip()
		if pos <= #s then fail("text after the end") end
		return r
	end)
	if ok then return v end
	return nil, type(v) == "table" and v.json or tostring(v)
end
Import.ParseJSON = parseJSON

---------------------------------------------------------------------------
-- The fixed shape a guide may have: every key the compiler writes
-- (tools/lib/dsl/emit.js GUIDE_KEYS, STEP_KEYS, GOAL_KEYS and the lists'
-- keys), with its type. A key outside it, or a value of another type,
-- refuses the string. Built fresh: nothing of the parsed tree is kept.
---------------------------------------------------------------------------

local S, N, B, NS, NL, BS, SM = "s", "n", "b", "ns", "nl", "bs", "sm" -- string, number, boolean, number or string, number or list of numbers, boolean or string, short string (names cap)
local function list(of) return { list = of } end
local function rec(fields) return { rec = fields } end
local LS, LN = list(S), list(N)

local ONLY = rec({ classes = LS, races = LS, factions = LS })
local REWARD_ITEM = rec({ item = N, itemName = S, quality = N })
local GOAL = rec({
	t = S, class = B, spell = N, spellName = S, faction = N, factionName = S, standing = N, achievement = N, achievementName = S, criteria = N,
	quest = N, title = S, target = S, npc = N, npcName = S, object = N, objName = S, item = N, itemName = S, count = N, oi = N, skill = S, skillLine = N,
	rank = NS, rankMax = N, level = N, frac = N, money = N, untilSkill = N,
	reagents = list(rec({ item = N, itemName = S, count = N })),
	location = S, minLevel = N, qlvl = NS, pre = LN, preAll = LN, closedBy = LN, preTitles = { idmap = S }, text = S, node = N, area = N,
	map = N, x = N, y = N, z = N, f = S, r = N,
	spots = list(rec({ x = N, y = N, z = N, r = N, n = N, alt = B })),
	spread = B, optional = B, only = ONLY, profLine = N, profName = S, profRank = N, note = S,
	from = S, fromKind = S, fromRank = N, fromFaction = S, fromAlso = S, fromId = N, fromAlsoId = N,
	fromNpcs = list(rec({ npc = N, npcName = S })),
	candidates = list(rec({ npc = N, npcName = S, map = N, x = N, y = N, z = N, f = S, faction = S, races = LS, classes = LS,
		lvl = rec({ min = N, max = N }), rate = N, spawns = N })),
	rewards = rec({ choices = list(REWARD_ITEM), items = list(REWARD_ITEM), xp = N, money = N }),
	group = rec({ kind = S, rank = N, name = S, size = N, map = N }),
	direct = B, escort = B,
})
-- A step's `when` predicates and a `next` option's (format 4; Guides.Validate checks each kind's keys).
local WHEN = rec({ k = S, neg = B, op = S, n = N, frac = N, q = NL, item = N, spell = N, name = S, label = S, area = N, map = N, skillLine = N, minLevel = N, pre = LN, preAll = LN, closedBy = LN })
-- A step's picture: read so a string carries the guide as its addon does, but
-- an imported guide has no addon folder holding the file, so it shows none.
local IMAGE = rec({ file = S, w = N, h = N })
local STEP = rec({ title = S, note = S, image = IMAGE, label = S, only = ONLY, when = list(WHEN), along = BS, skipto = list(rec({ to = S, when = WHEN })), goals = list(GOAL) })
local GUIDE = rec({
	id = S, title = S, faction = S, races = LS, classes = LS, minLevel = N, maxLevel = N, category = S, folder = S, keywords = LS,
	collects = LN, reward = list(rec({ item = N, itemName = S, quality = N, choice = B, spell = N, spellName = S, text = S })),
	why = S, zone = N, zoneName = S, next = S, nextChoices = LS, nextWhen = { map = list(WHEN) }, pitch = S, pros = LS, cons = LS, author = S, version = N, group = B,
	names = { map = SM }, written = { map = SM }, steps = list(STEP),
})
local PAYLOAD = rec({ format = N, license = S, guide = GUIDE, frames = { idmap = rec({ c = N, left = N, right = N, top = N, bottom = N }) } })

-- The key lists, for the test that holds them to the compiler's.
local function keysOf(spec)
	local out = {}
	for k in pairs(spec.rec) do out[#out + 1] = k end
	table.sort(out)
	return out
end
Import.KEYS = {
	guide = keysOf(GUIDE), step = keysOf(STEP), goal = keysOf(GOAL), only = keysOf(ONLY),
	reagents = keysOf(GOAL.rec.reagents.list), candidates = keysOf(GOAL.rec.candidates.list), spots = keysOf(GOAL.rec.spots.list),
	fromNpcs = keysOf(GOAL.rec.fromNpcs.list),
	items = keysOf(REWARD_ITEM), reward = keysOf(GUIDE.rec.reward.list), when = keysOf(WHEN), image = keysOf(IMAGE),
}

local function finite(v) return type(v) == "number" and v == v and v ~= huge and v ~= -huge end

-- v shaped by spec -> a fresh copy; raises { field = where } at the first
-- key or value that does not fit.
local function build(v, spec, where)
	if type(v) == "string" and #v > LIMITS.text and (spec == S or spec == NS or spec == BS) then error({ field = where, long = true }, 0) end
	if type(v) == "string" and #v > LIMITS.names and spec == SM then error({ field = where, long = true }, 0) end
	if spec == S or spec == SM then
		if type(v) == "string" then return v end
	elseif spec == N then
		if finite(v) then return v end
	elseif spec == B then
		if type(v) == "boolean" then return v end
	elseif spec == NS then
		if type(v) == "string" or finite(v) then return v end
	elseif spec == BS then
		if type(v) == "string" or type(v) == "boolean" then return v end
	elseif spec == NL then
		if finite(v) then return v end
		if type(v) == "table" then return build(v, LN, where) end
	elseif type(v) == "table" then
		local out = {}
		if spec.list then
			local n = #v
			for k in pairs(v) do
				if type(k) ~= "number" or k < 1 or k > n or k % 1 ~= 0 then error({ field = where }, 0) end
			end
			for i = 1, n do out[i] = build(v[i], spec.list, where .. "[" .. i .. "]") end
			return out
		elseif spec.rec then
			for k, x in pairs(v) do
				local inner = type(k) == "string" and spec.rec[k]
				local at = where == "" and tostring(k) or (where .. "." .. tostring(k))
				if not inner then error({ field = at }, 0) end
				out[k] = build(x, inner, at)
			end
			return out
		elseif spec.map then
			for k, x in pairs(v) do
				if type(k) ~= "string" or k == "" then error({ field = where }, 0) end
				if #k > LIMITS.text then error({ field = where, long = true }, 0) end
				out[k] = build(x, spec.map, where .. "." .. k)
			end
			return out
		elseif spec.idmap then
			-- Number keys: JSON writes them as strings ("1429"), the store as numbers.
			for k, x in pairs(v) do
				local id = type(k) == "number" and k or (type(k) == "string" and find(k, "^%d+$") and tonumber(k))
				if not (id and id % 1 == 0) then error({ field = where }, 0) end
				out[id] = build(x, spec.idmap, where .. "." .. tostring(k))
			end
			return out
		end
	end
	error({ field = where }, 0)
end

local function copy(v)
	if type(v) ~= "table" then return v end
	local out = {}
	for k, x in pairs(v) do out[k] = copy(x) end
	return out
end

---------------------------------------------------------------------------
-- The store
---------------------------------------------------------------------------

-- PolestarDB.imports, made on demand when `make`; else nil without one.
local function store(make)
	local db = ns.DB()
	local t = db.imports
	if type(t) ~= "table" then
		if not make then return nil end
		t = {}
		db.imports = t
	end
	return t
end

local function stored(id)
	local t = store(false)
	return t and type(t[id]) == "table" and t[id] or nil
end

---------------------------------------------------------------------------
-- Reading a string
---------------------------------------------------------------------------

local escape = ns.EscapeText

local function damaged() return L["This import string is damaged or incomplete. Copy the whole string again."] end

-- Adler-32 of s as 8 hex digits, in plain arithmetic (no bit library).
local function adler32(s)
	local a, b = 1, 0
	for i = 1, #s, 4096 do
		local bytes = { byte(s, i, i + 4095) }
		for j = 1, #bytes do
			a = a + bytes[j]
			b = b + a
		end
		a, b = a % 65521, b % 65521
	end
	return format("%04x%04x", b, a)
end
Import.Adler32 = adler32

-- Can entry be imported? -> nil, or why not. Every reason a pasted string
-- and a stored guide are refused for, after the shape (build).
local function check(entry)
	local g = entry.guide
	if not Guides.FORMATS[entry.format] then return L["This import string needs a newer Polestar."] end
	if type(entry.license) ~= "string" or entry.license == "" or type(g) ~= "table" then return L["This import string holds no guide."] end
	local id = g.id
	if type(id) ~= "string" or not Guides.OwnsId(PACK, id) then
		return (L["Its guide id %s must start with its author's own id, as in yendi/cozy-sleeping-bag."]):format(escape(tostring(id)))
	end
	-- Require the full id to be pack-id/guide-slug, both segments safe pack ids.
	if not id:match("^[a-z0-9][a-z0-9%-]*/[a-z0-9][a-z0-9%-]*$") then
		return (L["Its guide id %s must start with its author's own id, as in yendi/cozy-sleeping-bag."]):format(escape(id))
	end
	local prefix = id:match("^([^/]+)/")
	local holder = Guides.Pack(prefix)
	if holder and not holder.imported then
		return (L["Guides under %s/ come from the community addon %s, which is installed."]):format(prefix, holder.title or escape(tostring(holder.id)))
	end
	if type(g.steps) == "table" and #g.steps > LIMITS.steps then
		return (L["Its guide has %d steps; an import string holds %d at most. A bigger guide comes as a community addon."]):format(#g.steps, LIMITS.steps)
	end
	local ahead = { g.next }
	for _, t in ipairs(g.nextChoices or {}) do ahead[#ahead + 1] = t end
	for _, t in ipairs(ahead) do
		if not (Guides.OwnsId("guides", t) or t == id or stored(t)) then
			return (L["It leads on to %s, which is neither one of Polestar's guides nor an imported one: import that guide first."]):format(escape(t))
		end
	end
	-- Import-specific structural caps: goals per step, candidates per goal,
	-- at most one direct turn-in per quest per step (finding 3), and frame
	-- bounds sanity (finding 6).
	for i, step in ipairs(g.steps or {}) do
		if #(step.goals or {}) > LIMITS.goals then
			return (L["Its guide has %d goals in step %d; an import string holds %d per step at most."]):format(#step.goals, i, LIMITS.goals)
		end
		local directSeen = {}
		for _, goal in ipairs(step.goals or {}) do
			if goal.candidates and #goal.candidates > LIMITS.candidates then
				return (L["Its guide has %d candidates in a goal; an import string holds %d per goal at most."]):format(#goal.candidates, LIMITS.candidates)
			end
			-- Finding 3: at most one direct turn-in per quest per step.
			if goal.t == "turnin" and goal.direct and goal.quest then
				if directSeen[goal.quest] then
					return (L["Its guide has more than one direct turn-in for quest %d in step %d."]):format(goal.quest, i)
				end
				directSeen[goal.quest] = true
			end
			-- Finding 6: candidate x/y in 0-100.
			for _, c in ipairs(goal.candidates or {}) do
				if c.x ~= nil and (c.x < 0 or c.x > 100 or c.y < 0 or c.y > 100) then
					return (L["Its guide has a candidate coordinate outside 0-100."]):format()
				end
			end
			for _, sp in ipairs(goal.spots or {}) do
				if sp.x ~= nil and (sp.x < 0 or sp.x > 100 or sp.y < 0 or sp.y > 100) then
					return (L["Its guide has a spot coordinate outside 0-100."]):format()
				end
			end
		end
	end
	-- Finding 6: map frames must not be degenerate or huge.
	for _, frame in pairs(entry.frames or {}) do
		if type(frame) == "table" then
			local l, r, t, b, c = frame.left, frame.right, frame.top, frame.bottom, frame.c
			if type(l) ~= "number" or type(r) ~= "number" or type(t) ~= "number" or type(b) ~= "number" or type(c) ~= "number" then
				return L["Its guide has a map frame with missing fields."]
			end
			if l == r or t == b then return L["Its guide has a degenerate map frame (zero extent)."] end
			if math.abs(l) >= 1e6 or math.abs(r) >= 1e6 or math.abs(t) >= 1e6 or math.abs(b) >= 1e6 then
				return L["Its guide has a map frame with out-of-range coordinates."]
			end
		end
	end
	local err = Guides.Validate(g)
	if err then return (L["Guide %s was refused: %s."]):format(escape(id), escape(err)) end
	return nil
end

-- A parsed payload (or a stored entry) -> entry | nil, reason.
local function fromTree(tree)
	if type(tree) ~= "table" then return nil, L["This import string holds no guide."] end
	-- A newer format is expected to hold keys this Polestar does not know.
	if finite(tree.format) and not Guides.FORMATS[tree.format] then return nil, L["This import string needs a newer Polestar."] end
	local ok, entry = pcall(build, tree, PAYLOAD, "")
	if not ok then
		if type(entry) == "table" and entry.long then
			return nil, (L["This import string holds a text longer than Polestar reads (%s): %d characters at most."]):format(escape(entry.field), LIMITS.text)
		end
		if type(entry) == "table" and entry.field then
			return nil, (L["This import string holds a field Polestar does not read (%s). It may need a newer Polestar."]):format(escape(entry.field))
		end
		return nil, damaged()
	end
	local reason = check(entry)
	if reason then return nil, reason end
	return entry
end

function Import.Decode(text)
	if type(text) ~= "string" then return nil, L["Paste an import string."] end
	local s = gsub(text, "%s+", "")
	if s == "" then return nil, L["Paste an import string."] end
	if #s > LIMITS.length then return nil, (L["This import string is too long: Polestar reads up to %d characters."]):format(LIMITS.length) end
	local version = s:match("^!PS(%d+)!")
	if not version then return nil, L["This is not a Polestar import string."] end
	if version ~= "1" then return nil, L["This import string needs a newer Polestar."] end
	local sum, body = s:match("^!PS1!(%x%x%x%x%x%x%x%x)!([A-Za-z0-9+/]+=?=?)$")
	if not sum or #body % 4 ~= 0 then return nil, damaged() end
	local enc = C_EncodingUtil
	if not (type(enc) == "table" and type(enc.DecodeBase64) == "function" and type(enc.DecompressString) == "function") then
		return nil, L["This game client cannot read import strings."]
	end
	local ok, packed = pcall(enc.DecodeBase64, body)
	if not ok or type(packed) ~= "string" then return nil, damaged() end
	local method = Enum and Enum.CompressionMethod and Enum.CompressionMethod.Zlib
	local raw
	ok, raw = pcall(enc.DecompressString, packed, method)
	if not ok or type(raw) ~= "string" then return nil, damaged() end
	if #raw > LIMITS.payload then return nil, (L["This import string holds too much: Polestar reads up to %d KB of guide data."]):format(LIMITS.payload / 1024) end
	if adler32(raw) ~= lower(sum) then return nil, damaged() end
	local tree = parseJSON(raw)
	if tree == nil then return nil, damaged() end
	return fromTree(tree)
end

-- A copy of guide g with its texts in the client's language, for display
-- before (or without) registering it.
local function shown(g)
	local c = copy(g)
	if ns.GuideTexts and ns.GuideTexts.Prepare then ns.GuideTexts.Prepare(c, true) end
	return c
end

local function versionOf(g) return type(g) == "table" and tonumber(g.version) or 0 end

function Import.Preview(text)
	local entry, reason = Import.Decode(text)
	if not entry then return nil, reason end
	local g = entry.guide
	local have = stored(g.id)
	local state = "new"
	local authorChanged, licenseChanged = false, false
	if have then
		local v, h = versionOf(g), versionOf(have.guide)
		state = v > h and "update" or v == h and "same" or "older"
		-- Finding 7: warn when the incoming string changes who wrote or licensed
		-- the guide; anyone can publish a higher version of someone else's import.
		if state == "update" then
			authorChanged = g.author ~= (type(have.guide) == "table" and have.guide.author)
			licenseChanged = entry.license ~= (type(have) == "table" and have.license)
		end
	end
	local c = shown(g)
	return {
		entry = entry, id = g.id, title = escape(c.title or g.id), author = g.author and escape(g.author) or nil,
		version = g.version, steps = #g.steps, minLevel = g.minLevel, maxLevel = g.maxLevel, faction = g.faction,
		license = escape(entry.license), state = state, have = have and versionOf(have.guide) or nil,
		authorChanged = authorChanged or nil, licenseChanged = licenseChanged or nil,
	}
end

---------------------------------------------------------------------------
-- Registering, saving, deleting
---------------------------------------------------------------------------

local problems = {} -- guide id -> why its stored guide did not register (login)

-- The Era frames of entry for the maps its guide's goals and their smart
-- targets stand on, and only where no one has registered a frame: a string
-- never moves another pack's (or Polestar's) map. -> { [map] = frame } | nil
local function newFrames(entry)
	if type(entry.frames) ~= "table" then return nil end
	local used = {}
	for _, step in ipairs(entry.guide.steps or {}) do
		for _, goal in ipairs(step.goals or {}) do
			if goal.map then used[goal.map] = true end
			for _, c in ipairs(goal.candidates or {}) do
				if c.map then used[c.map] = true end
			end
		end
	end
	local era = ns.MapFrames and ns.MapFrames.era or {}
	local out, any = {}, false
	for map, frame in pairs(entry.frames) do
		if used[map] and era[map] == nil then
			out[map] = copy(frame)
			any = true
		end
	end
	return any and out or nil
end
Import.NewFrames = newFrames

local function register(entry)
	local frames = newFrames(entry)
	if frames then ns.RegisterMapFrames({ era = frames }, PACK) end
	local def = copy(entry.guide)
	def.pack = PACK
	def.license = entry.license
	return ns.RegisterGuide(def)
end

function Import.Save(entry)
	if type(entry) ~= "table" or type(entry.guide) ~= "table" then return false, L["This import string holds no guide."] end
	-- Through the checks again: the page may hold a preview from before a
	-- guide it leads on to was deleted.
	local checked, reason = fromTree(entry)
	if not checked then return false, reason end
	local id = checked.guide.id
	local ok, err = register(checked)
	if not ok then return false, (L["Guide %s was refused: %s."]):format(escape(id), escape(tostring(err))) end
	store(true)[id] = copy(checked)
	problems[id] = nil
	ns.Fire("PACKS_CHANGED", PACK)
	return true
end

function Import.Delete(id)
	local t = store(false)
	if not (t and t[id]) then return false end
	t[id] = nil
	problems[id] = nil
	Guides.DropImported(id)
	ns.Fire("PACKS_CHANGED", PACK)
	return true
end

function Import.List()
	local out = {}
	for id, e in pairs(store(false) or {}) do
		if type(id) == "string" and type(e) == "table" and type(e.guide) == "table" then
			local g = Guides.Get(id)
			-- For a stored guide that registered successfully use its live title;
			-- for one that did not, use the raw title without calling Prepare
			-- (which can error on a malformed or downgraded entry and break the
			-- layout so Delete never draws).
			local title
			if g and g.pack == PACK then
				title = g.title
			else
				title = type(e.guide.title) == "string" and escape(e.guide.title) or escape(id)
			end
			out[#out + 1] = {
				id = id, title = title, author = type(e.guide.author) == "string" and escape(e.guide.author) or nil,
				version = tonumber(e.guide.version), license = type(e.license) == "string" and escape(e.license) or nil,
				steps = type(e.guide.steps) == "table" and #e.guide.steps or 0, problem = problems[id],
			}
		end
	end
	table.sort(out, function(a, b)
		local ta, tb = lower(a.title), lower(b.title)
		if ta ~= tb then return ta < tb end
		return a.id < b.id
	end)
	return out
end

-- At login (Guides.lua): every stored guide through the same checks as a
-- pasted string, then registered. One that fails stays stored, listed on the
-- Import page with why.
function Import.Load()
	local t = store(false)
	if not t then return end
	local ids = {}
	for id in pairs(t) do
		if type(id) == "string" then ids[#ids + 1] = id end
	end
	table.sort(ids)
	for _, id in ipairs(ids) do
		local entry, reason = fromTree(t[id])
		if entry and entry.guide.id ~= id then entry, reason = nil, L["This import string holds no guide."] end
		if entry then
			local ok, err = register(entry)
			if not ok then reason = (L["Guide %s was refused: %s."]):format(escape(id), escape(tostring(err))) end
		end
		problems[id] = reason
		if reason then ns.Debug(("import %s: %s"):format(id, reason)) end
	end
end

ns.RegisterCommand("import", function(rest)
	local sub = rest and rest:match("^%s*(%S+)")
	if sub == "clear" then
		local t = store(false)
		if not t or not next(t) then
			ns.Print(L["No imported guides to remove."])
			return
		end
		local ids = {}
		for id in pairs(t) do if type(id) == "string" then ids[#ids + 1] = id end end
		for _, id in ipairs(ids) do Import.Delete(id) end
		ns.Print((L["Removed %d imported guide(s)."]):format(#ids))
	elseif sub == "delete" then
		local id = rest:match("^%s*%S+%s+(.-)%s*$")
		if not id or id == "" then
			ns.Print(L["Usage: /polestar import delete <guide-id>"])
			return
		end
		if Import.Delete(id) then
			ns.Print((L["Removed imported guide %s."]):format(escape(id)))
		else
			ns.Print((L["No imported guide with id %s."]):format(escape(id)))
		end
	else
		ns.Fire("SHOW_IMPORT")
	end
end, L["Open the Import page; import clear / import delete <id>: remove imports"])
