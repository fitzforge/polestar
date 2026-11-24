-- Guide texts in the language Polestar shows (Polestar.Names.Language: the
-- client's unless the Language setting chose another). Contract:
-- docs/ARCHITECTURE.md, "Guide texts".
--
-- A compiled guide's prose (its title, why, pitch, pros, cons and reward
-- words; each step's title and tip; each goal's note and text, and a kill of no
-- NPC's target in words) holds the
-- game's names as tokens, {kind:id} (tools/lib/dsl/tokens.js), and the
-- guide's `names` give each token's English. RegisterGuide hands every guide
-- here before escaping it, and each text is then shown as:
--   1. the guide pack's translation into that language, when its
--      texts addon (<pack addon>_<locale>, load on demand, compiled from the
--      pack's locales/<locale>/ files; for our own pack, Polestar_Guides, the
--      language folder Polestar_<locale> it shares with Polestar.Names) has
--      one; else the English;
--   2. with every token filled by the game's name in that language
--      (Polestar.Names for quests, NPCs, objects, items, spells, factions
--      and areas; the client's map name for a zone; L for a profession),
--      else by its English.
-- In English, a text the guide's `written` holds (one that
-- spells a name otherwise than its token's English: "Dalinda") as the
-- author's words there.
-- A guide's `folder` and the pack's title and notes are the pack's own
-- texts, translated once for every guide; a folder named after a class reads
-- as the client's name of that class.
--
--   GuideTexts.Prepare(def, live)   -- RegisterGuide, before escaping. live:
--     ask Names now (false while the pack's files load: the guide shows its
--     English names until Refresh)
--   GuideTexts.Refresh(def) -> bool  -- rewrites a prepared guide's texts
--     (escaped) after its pack's texts or the names came in; true if any changed
--   GuideTexts.Load(addon) -> "loaded" | "combat" | nil   -- loads the texts
--     addon of the pack addon `addon` (Data.Pack), once; "combat": refused
--     in combat, GuideTexts.Pending() lists it until it is tried again;
--     nil: none (not installed, or English)
--   GuideTexts.TextsAddon(addon) -> "<addon>_<locale>" (our pack's:
--     "Polestar_<locale>") | nil (English, or a pack inside Polestar itself)
--   GuideTexts.PackText(packId, text) -> translation or text
--   GuideTexts.GUIDE_FIELDS   -- the guide-level fields it rewrites
--   Polestar.RegisterGuideTexts(locale, packId, { pack = {...}, guides = {
--     [guideId] = {...} } })   -- a texts addon's one call; each table maps
--     the English (with its tokens) to the translation; ignored unless
--     locale is the language shown
--   GuideTexts.SetLanguage(locale)   -- Core/Locale.lua, at ADDON_LOADED,
--     when the Language setting asks for another than the client's: drops
--     the texts the client's folder brought

local ADDON, ns = ...
local L = ns.L

local GuideTexts = {}
ns.GuideTexts = GuideTexts

local type, pairs, ipairs, tonumber = type, pairs, ipairs, tonumber
local find, sub, upper, concat = string.find, string.sub, string.upper, table.concat

local ENGLISH = { enUS = true, enGB = true }
local locale = ns.Names.Language()
local english = ENGLISH[locale] or false

GuideTexts.GUIDE_FIELDS = { "title", "why", "pitch", "folder" }
local GUIDE_FIELDS = { "title", "why", "pitch" }
local GUIDE_LISTS = { "pros", "cons" }
local STEP_FIELDS = { "title", "note" }
local GOAL_FIELDS = { "note", "text" }
local EMPTY_GOALS = {}

local texts = {} -- pack id -> { pack = { english = translation }, guides = { [guide id] = { english = translation } } }
local prepared = setmetatable({}, { __mode = "k" }) -- def -> { names, fields = { holder, key, english, ... } }
local tried = {} -- pack addon -> its texts addon's "loaded" | "combat" | "missing"

local function valid(s) return type(s) == "string" and s ~= "" end

function ns.RegisterGuideTexts(loc, packId, t)
	if loc ~= locale or english or type(packId) ~= "string" or type(t) ~= "table" then return false end
	local into = { pack = {}, guides = {} }
	if type(t.pack) == "table" then
		for k, v in pairs(t.pack) do if valid(k) and valid(v) then into.pack[k] = v end end
	end
	if type(t.guides) == "table" then
		for id, list in pairs(t.guides) do
			if valid(id) and type(list) == "table" then
				local g = {}
				for k, v in pairs(list) do if valid(k) and valid(v) then g[k] = v end end
				into.guides[id] = g
			end
		end
	end
	texts[packId] = into
	return true
end

-- A token's name in the language shown, or nil.
local function localName(kind, id, en)
	if kind == "zone" then return ns.Names.Localised() and ns.Names.Native() and ns.Compat.GetMapName(id) or nil end
	if kind == "skill" then return L[en] end
	if kind == "spell" or kind == "faction" or kind == "area" then return ns.Names.Get(kind, id) end
	return ns.Names.Cached(kind, id)
end

-- Stop filling once output passes this many bytes; prevents token-fill blow-up
-- from adversarial import strings (2× the per-text cap in Import.LIMITS.text).
local FILL_CAP = 8192

local function fill(s, names, live)
	if not find(s, "{", 1, true) then return s end
	local parts, n, at, total = {}, 0, 1, 0
	while true do
		local a, b, kind, id = find(s, "{(%l+):(%d+)}", at)
		if not a then break end
		local prefix = sub(s, at, a - 1)
		n = n + 1; parts[n] = prefix; total = total + #prefix
		local en = names and names[kind .. ":" .. id]
		local name = en and live and not english and localName(kind, tonumber(id), en) or nil
		local token
		if valid(name) then token = name
		elseif valid(en) then token = en
		else token = sub(s, a, b) end
		n = n + 1; parts[n] = token; total = total + #token
		at = b + 1
		if total >= FILL_CAP then break end
	end
	n = n + 1; parts[n] = sub(s, at)
	return concat(parts, "", 1, n)
end

local function render(def, entry, en, live)
	-- A text that spells a name otherwise than its token's English: an
	-- English client reads the author's words.
	if english and entry.written and valid(entry.written[en]) then return entry.written[en] end
	local t = texts[def.pack]
	local g = t and t.guides[def.id]
	return fill(g and g[en] or en, entry.names, live)
end

function GuideTexts.PackText(packId, s)
	local t = texts[packId]
	return t and valid(s) and t.pack[s] or s
end

local function headerFields(def, add)
	for _, f in ipairs(GUIDE_FIELDS) do add(def, f) end
	for _, f in ipairs(GUIDE_LISTS) do
		local list = def[f]
		if type(list) == "table" then for i = 1, #list do add(list, i) end end
	end
	if type(def.reward) == "table" then
		for _, r in ipairs(def.reward) do if type(r) == "table" then add(r, "text") end end
	end
end

local function stepFields(def, add)
	-- Deferred steps not read in yet are left for PrepareSteps.
	local steps = rawget(def, "steps")
	if not steps then return end
	for _, step in ipairs(steps) do
		for _, f in ipairs(STEP_FIELDS) do add(step, f) end
		for _, goal in ipairs(step.goals or EMPTY_GOALS) do
			if type(goal) == "table" then
				for _, f in ipairs(GOAL_FIELDS) do add(goal, f) end
				-- A kill of no NPC names its target in words.
				if goal.t == "kill" and goal.npc == nil then add(goal, "target") end
			end
		end
	end
end

local function applyFolder(def, entry, escape)
	if valid(entry.folder) then
		local v = GuideTexts.PackText(def.pack, entry.folder)
		-- A folder named after a class: the client's name of it.
		local class = v == entry.folder and LOCALIZED_CLASS_NAMES_MALE and LOCALIZED_CLASS_NAMES_MALE[upper(v)]
		if valid(class) then v = class end
		if escape then v = escape(v) end
		if def.folder ~= v then
			def.folder = v
			return true
		end
	end
	return false
end

-- RegisterGuide escapes def.names after preparation. Only a translated client
-- needs the original names after the first render.
local function newEntry(def)
	local names = type(def.names) == "table" and def.names or nil
	if not english and names then
		local raw = {}
		for k, v in pairs(names) do if valid(k) and valid(v) then raw[k] = v end end
		names = raw
	end
	return { names = names, written = english and type(def.written) == "table" and def.written or nil, fields = {} }
end

local function collectFields(def, entry, withHeader)
	local fields = entry.fields
	local function add(holder, key)
		local en = holder[key]
		if not valid(en) then return end
		-- A weak-key table in Lua 5.1 does not collect a key reachable
		-- from its value. Never store def in its own refresh list.
		local n = #fields
		fields[n + 1] = holder ~= def and holder or false
		fields[n + 2], fields[n + 3] = key, en
	end
	if withHeader then headerFields(def, add) end
	stepFields(def, add)
end

local function apply(def, entry, from, live, escape)
	local changed, fields = false, entry.fields
	for i = from, #fields, 3 do
		local holder, key = fields[i] or def, fields[i + 1]
		local v = render(def, entry, fields[i + 2], live)
		if escape then v = escape(v) end
		if holder[key] ~= v then
			holder[key] = v
			changed = true
		end
	end
	return applyFolder(def, entry, escape) or changed
end

function GuideTexts.Prepare(def, live)
	local entry = newEntry(def)
	entry.folder = def.folder
	if not english then prepared[def] = entry end
	collectFields(def, entry, true)
	apply(def, entry, 1, live)
end

-- A deferred guide's steps, read in (Guides.Steps): their texts join def's,
-- written in the client's language now.
function GuideTexts.PrepareSteps(def)
	local entry = prepared[def] or newEntry(def)
	local from = #entry.fields + 1
	entry.header = entry.header or from - 1
	collectFields(def, entry, false)
	apply(def, entry, from, true)
end

-- A deferred guide's steps dropped (Guides.Release): their texts leave def's.
function GuideTexts.DropSteps(def)
	local entry = prepared[def]
	if not (entry and entry.header) then return end
	for i = #entry.fields, entry.header + 1, -1 do entry.fields[i] = nil end
end

function GuideTexts.Refresh(def)
	local entry = prepared[def]
	return entry and apply(def, entry, 1, true, ns.EscapeText) or false
end

-- Our pack's texts are in the language folder, beside the game's names. A
-- pack inside Polestar itself (its experimental guides, #3507) has no texts
-- addon: "Polestar_<locale>" is the language folder, which Polestar loads
-- on its own (Core/Locale.lua), and asking for it as the pack registers,
-- while Polestar loads, would settle Data.Pack's answer for it too early.
local OWN = "Polestar_Guides"

function GuideTexts.TextsAddon(addon)
	if english or not valid(addon) or addon == ADDON then return nil end
	if addon == OWN then return "Polestar_" .. locale end
	return addon .. "_" .. locale
end

function GuideTexts.Load(addon)
	local name = GuideTexts.TextsAddon(addon)
	if not name then return nil end
	local was = tried[addon]
	if was == "loaded" or was == "missing" then return was == "loaded" and "loaded" or nil end
	local ok, reason = ns.Data.Pack(name)
	tried[addon] = ok and "loaded" or (reason == "combat" and "combat" or "missing")
	return tried[addon] ~= "missing" and tried[addon] or nil
end

-- Texts addons refused in combat, by pack addon: Guides.lua tries them again.
function GuideTexts.Pending()
	local out = {}
	for addon, state in pairs(tried) do
		if state == "combat" then out[#out + 1] = addon end
	end
	return out
end

function GuideTexts.SetLanguage(loc)
	if type(loc) ~= "string" or loc == locale then return end
	locale = loc
	english = ENGLISH[loc] or false
	texts, tried = {}, {}
end
