-- Guide texts in the client's language. Contract: docs/ARCHITECTURE.md,
-- "Guide texts".
--
-- A compiled guide's prose (its title, why, pitch, pros, cons and reward
-- words; each step's title and tip; each goal's note and text, and a kill of no
-- NPC's target in words) holds the
-- game's names as tokens, {kind:id} (tools/lib/dsl/tokens.js), and the
-- guide's `names` give each token's English. RegisterGuide hands every guide
-- here before escaping it, and each text is then shown as:
--   1. the guide pack's translation into the client's language, when its
--      texts addon (<pack addon>_<locale>, load on demand, compiled from the
--      pack's locales/<locale>/ files) has one; else the English;
--   2. with every token filled by the game's name in that language
--      (Polestar.Names for quests, NPCs, objects, items, spells, factions
--      and areas; the client's map name for a zone; L for a profession),
--      else by its English.
-- An English client reads a text the guide's `written` holds (one that
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
--     nil: none (not installed, or an English client)
--   GuideTexts.TextsAddon(addon) -> "<addon>_<locale>" | nil (English)
--   GuideTexts.PackText(packId, text) -> translation or text
--   GuideTexts.GUIDE_FIELDS   -- the guide-level fields it rewrites
--   Polestar.RegisterGuideTexts(locale, packId, { pack = {...}, guides = {
--     [guideId] = {...} } })   -- a texts addon's one call; each table maps
--     the English (with its tokens) to the translation

local ADDON, ns = ...
local L = ns.L

local GuideTexts = {}
ns.GuideTexts = GuideTexts

local type, pairs, ipairs, tonumber, next = type, pairs, ipairs, tonumber, next
local find, sub, upper = string.find, string.sub, string.upper

local ENGLISH = { enUS = true, enGB = true }
local locale = (GetLocale and GetLocale()) or "enUS"
local english = ENGLISH[locale] or false

GuideTexts.GUIDE_FIELDS = { "title", "why", "pitch", "folder" }
local GUIDE_FIELDS = { "title", "why", "pitch" }
local GUIDE_LISTS = { "pros", "cons" }
local STEP_FIELDS = { "title", "note" }
local GOAL_FIELDS = { "note", "text" }

local texts = {} -- pack id -> { pack = { english = translation }, guides = { [guide id] = { english = translation } } }
local prepared = setmetatable({}, { __mode = "k" }) -- def -> { names, fields = { holder, key, english, ... } }
local tried = {} -- texts addon name -> "loaded" | "combat" | "missing"

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

-- A token's name in the client's language, or nil.
local function localName(kind, id, en)
	if kind == "zone" then return ns.Names.Localised() and ns.Compat.GetMapName(id) or nil end
	if kind == "skill" then return L[en] end
	if kind == "spell" or kind == "faction" or kind == "area" then return ns.Names.Get(kind, id) end
	return ns.Names.Cached(kind, id)
end

local function fill(s, names, live)
	if not find(s, "{", 1, true) then return s end
	local out, at = "", 1
	while true do
		local a, b, kind, id = find(s, "{(%l+):(%d+)}", at)
		if not a then break end
		out = out .. sub(s, at, a - 1)
		local en = names[kind .. ":" .. id]
		local name = en and live and not english and localName(kind, tonumber(id), en) or nil
		if valid(name) then out = out .. name
		elseif en then out = out .. en
		else out = out .. sub(s, a, b) end -- not a token of this guide: left as written
		at = b + 1
	end
	return out .. sub(s, at)
end

local function render(def, entry, en, live)
	-- A text that spells a name otherwise than its token's English: an
	-- English client reads the author's words.
	if english and entry.written[en] then return entry.written[en] end
	local t = texts[def.pack]
	local g = t and t.guides[def.id]
	return fill(g and g[en] or en, entry.names, live)
end

function GuideTexts.PackText(packId, s)
	local t = texts[packId]
	return t and valid(s) and t.pack[s] or s
end

-- Every prose text of def as holder, key, English triples, in `fields`.
local function collect(def, fields)
	local function add(holder, key)
		local v = holder[key]
		if valid(v) then
			fields[#fields + 1] = holder
			fields[#fields + 1] = key
			fields[#fields + 1] = v
		end
	end
	for _, f in ipairs(GUIDE_FIELDS) do add(def, f) end
	for _, f in ipairs(GUIDE_LISTS) do
		local list = def[f]
		if type(list) == "table" then for i = 1, #list do add(list, i) end end
	end
	if type(def.reward) == "table" then
		for _, r in ipairs(def.reward) do if type(r) == "table" then add(r, "text") end end
	end
	for _, step in ipairs(def.steps) do
		for _, f in ipairs(STEP_FIELDS) do add(step, f) end
		for _, goal in ipairs(step.goals) do
			if type(goal) == "table" then
				for _, f in ipairs(GOAL_FIELDS) do add(goal, f) end
				-- A kill of no NPC names its target in words.
				if goal.t == "kill" and goal.npc == nil then add(goal, "target") end
			end
		end
	end
end

-- Writes def's texts; escaped through `escape` (nil: left for RegisterGuide).
local function apply(def, entry, live, escape)
	local changed = false
	local f = entry.fields
	for i = 1, #f, 3 do
		local v = render(def, entry, f[i + 2], live)
		if escape then v = escape(v) end
		if f[i][f[i + 1]] ~= v then
			f[i][f[i + 1]] = v
			changed = true
		end
	end
	if valid(entry.folder) then
		local v = GuideTexts.PackText(def.pack, entry.folder)
		-- A folder named after a class: the client's name of it.
		local class = v == entry.folder and LOCALIZED_CLASS_NAMES_MALE and LOCALIZED_CLASS_NAMES_MALE[upper(v)]
		if valid(class) then v = class end
		if escape then v = escape(v) end
		if def.folder ~= v then
			def.folder = v
			changed = true
		end
	end
	return changed
end

function GuideTexts.Prepare(def, live)
	local names, written = {}, {}
	if type(def.names) == "table" then
		for k, v in pairs(def.names) do if valid(k) and valid(v) then names[k] = v end end
	end
	if type(def.written) == "table" then
		for k, v in pairs(def.written) do if valid(k) and valid(v) then written[k] = v end end
	end
	local entry = { names = names, written = written, fields = {}, folder = def.folder }
	collect(def, entry.fields)
	-- An English client fills the tokens once: nothing ever changes them.
	if not english then prepared[def] = entry end
	apply(def, entry, live, nil)
end

function GuideTexts.Refresh(def)
	local entry = prepared[def]
	if not entry then return false end
	return apply(def, entry, true, ns.EscapeText)
end

function GuideTexts.TextsAddon(addon)
	if english or not valid(addon) then return nil end
	return addon .. "_" .. locale
end

function GuideTexts.Load(addon)
	local name = GuideTexts.TextsAddon(addon)
	if not name then return nil end
	local was = tried[name]
	if was == "loaded" or was == "missing" then return was == "loaded" and "loaded" or nil end
	local ok, reason = ns.Data.Pack(name)
	tried[name] = ok and "loaded" or (reason == "combat" and "combat" or "missing")
	return tried[name] ~= "missing" and tried[name] or nil
end

-- Texts addons refused in combat, by pack addon: Guides.lua tries them again.
function GuideTexts.Pending()
	local out = {}
	for name, state in pairs(tried) do
		if state == "combat" then out[#out + 1] = name:sub(1, #name - #locale - 1) end
	end
	return out
end
