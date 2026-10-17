-- English on a non-English client (tools/lib/i18n/leaks.js, `i18n leaks`).
-- Run in runAddon's `before`, after the stubs and before any addon file, with
-- LEAKS = { locale = "ruRU" } set. It
--   * makes the client answer in "its language": every name the client
--     itself gives (quest titles, item, map, area, zone, spell, faction,
--     instance, class and race names, a few GlobalStrings) comes back as a
--     placeholder, ⟦q176⟧, that holds no word, so a word left on screen is
--     Polestar's;
--   * records every text the addons put up: font strings and buttons
--     (SetText, SetFormattedText), tooltips, chat, error and popup texts,
--     Settings panel names and menu entries, each with the scene it showed
--     in and the addon line that set it;
--   * records where English came from: interface keys the locale file does
--     not translate (L, LC), names the names pack does not have, guide texts
--     the guide texts addon does not translate;
--   * collects the locale's own words: every word of its interface
--     translations (both addons), its names pack and its guide texts. A word
--     the language itself writes in Latin letters (German, French, a name
--     kept as in English) is one of them.
-- leaks.dump() emits the texts holding a Latin word of 3+ letters that is
-- not one of the locale's own, with their words, sources and scenes.

-- The client's string.format takes positional arguments (%2$s); Lua 5.1 does not.
do
	local fmt0 = string.format
	local function pformat(f, ...)
		if type(f) ~= "string" or not f:find("%%%d+%$") then return fmt0(f, ...) end
		local args, seq = { ... }, {}
		f = f:gsub("%%(%d+)%$", function(i) seq[#seq + 1] = args[tonumber(i)]; return "%" end)
		return fmt0(f, unpack(seq, 1, #seq))
	end
	string.format = pformat
	format = pformat
end

local LOCALE = LEAKS.locale
leaks = {}
local A = leaks

---------------------------------------------------------------------------
-- The client's language: placeholders for every name it gives.
---------------------------------------------------------------------------

function GetLocale() return LOCALE end
local function P(tag, id) return "⟦" .. tag .. tostring(id or "") .. "⟧" end
A.P = P

local function wrapName(tbl, key, tag, field)
	local o = tbl and tbl[key]
	if type(o) ~= "function" then return end
	tbl[key] = function(id, ...)
		local r = { o(id, ...) }
		if field then
			if type(r[1]) == "table" and r[1][field] ~= nil then r[1][field] = P(tag, r[1].mapID or r[1].factionID or r[1].areaID or id) end
		elseif r[1] ~= nil then
			r[1] = P(tag, id)
		end
		return unpack(r, 1, table.maxn(r))
	end
end

-- Every quest, item and spell has a name in the client's language.
if C_QuestLog then C_QuestLog.GetTitleForQuestID = function(q) return P("q", q) end end
C_Item = C_Item or {}
C_Item.GetItemNameByID = function(id) if type(id) == "number" then return P("i", id) end end
do
	local function itemInfo(o)
		return function(id, ...)
			local r = { (o or function() end)(id, ...) }
			if type(id) ~= "number" then return unpack(r, 1, table.maxn(r)) end
			if r[1] == nil then r = { nil, nil, 1, 1, 1, nil, nil, 1, "", 134400, 0 } end
			r[1], r[6], r[7] = P("i", id), P("it"), P("it")
			return unpack(r, 1, 11)
		end
	end
	GetItemInfo = itemInfo(GetItemInfo)
	if C_Item.GetItemInfo then C_Item.GetItemInfo = itemInfo(C_Item.GetItemInfo) end
	local spellInfo = GetSpellInfo
	function GetSpellInfo(id, ...)
		if type(id) == "number" then return P("s", id), nil, 136243 end
		if spellInfo then return spellInfo(id, ...) end
	end
	C_Spell = C_Spell or {}
	C_Spell.GetSpellName = function(id) if type(id) == "number" then return P("s", id) end end
	-- The player's and realm's names are the player's own.
	local unitName = UnitName
	function UnitName(unit, ...)
		local n, realm = unitName(unit, ...)
		if n ~= nil then return P("p"), realm and P("p") end
		return n, realm
	end
	if GetRealmName then GetRealmName = function() return P("p") end end
end
-- The client knows every map (the stub world only the guides' zones).
do
	local info = C_Map and C_Map.GetMapInfo
	if info then
		C_Map.GetMapInfo = function(id, ...)
			local r = info(id, ...)
			if r == nil and type(id) == "number" and id > 0 then r = { mapID = id, name = "", mapType = 3, parentMapID = 0 } end
			if type(r) == "table" then r.name = P("m", r.mapID or id) end
			return r
		end
	end
end
wrapName(C_Map, "GetMapInfoAtPosition", "m", "name")
if C_Map then C_Map.GetAreaInfo = function(id) return P("a", id) end end
for _, fn in ipairs({ "GetZoneText", "GetRealZoneText", "GetSubZoneText", "GetMinimapZoneText", "GetBindLocation" }) do
	local o = _G[fn]
	if o then _G[fn] = function(...) local v = o(...); if v and v ~= "" then return P("z") end return v end end
end
wrapName(_G, "TaxiNodeName", "n")
wrapName(_G, "GetFactionInfoByID", "f")
if C_Reputation then wrapName(C_Reputation, "GetFactionDataByID", "f", "name") end
wrapName(_G, "GetInstanceInfo", "d")
if C_TradeSkillUI then wrapName(C_TradeSkillUI, "GetRecipeInfo", "r", "name") end
do
	local c, r = UnitClass, UnitRace
	if c then UnitClass = function(u) local a, b, n = c(u); if a then a = P("c", n) end return a, b, n end end
	if r then UnitRace = function(u) local a, b, n = r(u); if a then a = P("r", n) end return a, b, n end end
end
LOCALIZED_CLASS_NAMES_MALE = setmetatable({}, { __index = function(_, k) return P("c", k) end })
LOCALIZED_CLASS_NAMES_FEMALE = LOCALIZED_CLASS_NAMES_MALE
C_CreatureInfo = C_CreatureInfo or {}
C_CreatureInfo.GetRaceInfo = function(id) return { raceName = P("r", id), clientFileString = "X", raceID = id } end
C_CreatureInfo.GetClassInfo = function(id) return { className = P("c", id), classFile = "X", classID = id } end
for i, k in ipairs({ "FACTION_STANDING_LABEL1", "FACTION_STANDING_LABEL2", "FACTION_STANDING_LABEL3", "FACTION_STANDING_LABEL4",
	"FACTION_STANDING_LABEL5", "FACTION_STANDING_LABEL6", "FACTION_STANDING_LABEL7", "FACTION_STANDING_LABEL8",
	"ITEM_QUALITY0_DESC", "ITEM_QUALITY1_DESC", "ITEM_QUALITY2_DESC", "ITEM_QUALITY3_DESC", "ITEM_QUALITY4_DESC",
	"ITEM_QUALITY5_DESC", "ITEM_QUALITY6_DESC", "FACTION_ALLIANCE", "FACTION_HORDE", "HEADSLOT", "NECKSLOT",
	"SHOULDERSLOT", "CHESTSLOT", "WAISTSLOT", "LEGSSLOT", "FEETSLOT", "WRISTSLOT", "HANDSSLOT", "FINGER0SLOT",
	"TRINKET0SLOT", "BACKSLOT", "MAINHANDSLOT", "SECONDARYHANDSLOT", "RANGEDSLOT", "ENCOUNTER_JOURNAL" }) do
	_G[k] = P("g", i)
end

---------------------------------------------------------------------------
-- What the addons put on screen.
---------------------------------------------------------------------------

local texts, seen = {}, {}
local errors = {}
local scene = "load"
function A.scene(name) scene = name end

-- The addon lines that set a text, innermost first (at most three).
local function site(level)
	local chain = {}
	while true do
		local info = debug.getinfo(level, "Sl")
		if not info then break end
		local rel = (info.source or ""):match("[/\\]addon[/\\](.*)$")
		if rel and not rel:find("^Polestar_Names_") then
			chain[#chain + 1] = rel:gsub("\\", "/") .. ":" .. (info.currentline or 0)
			if #chain >= 3 then break end
		end
		level = level + 1
	end
	return chain
end

local function rec(kind, text)
	if text == nil then return end
	text = tostring(text)
	if text == "" or not text:find("%a%a%a") then return end
	local e = seen[text]
	if e then
		if #e.scenes < 3 and e.scenes[#e.scenes] ~= scene then e.scenes[#e.scenes + 1] = scene end
		return
	end
	e = { kind = kind, text = text, site = site(3), scenes = { scene } }
	seen[text] = e
	texts[#texts + 1] = e
end
A.rec = rec

local M = stub.Methods
do
	local setText, setFmt = M.SetText, M.SetFormattedText
	-- An edit box holds what the player typed.
	function M.SetText(self, t, ...)
		if self.kind ~= "EditBox" then rec(self.kind == "GameTooltip" and "tooltip" or "text", t) end
		return setText(self, t, ...)
	end
	function M.SetFormattedText(self, fmt, ...)
		local ok, s = pcall(string.format, fmt, ...)
		rec("text", ok and s or fmt)
		return setFmt(self, fmt, ...)
	end
	local addLine, addDouble = M.AddLine, M.AddDoubleLine
	function M.AddLine(self, t, ...) rec("tooltip", t); if addLine then return addLine(self, t, ...) end end
	function M.AddDoubleLine(self, l, r, ...) rec("tooltip", l); rec("tooltip", r); if addDouble then return addDouble(self, l, r, ...) end end
end

-- A tooltip object with its own methods (GameTooltip, ones the addon makes).
function A.watchTooltip(tt)
	if not tt or tt.__leaks then return end
	tt.__leaks = true
	local al, ad, st = rawget(tt, "AddLine"), rawget(tt, "AddDoubleLine"), rawget(tt, "SetText")
	if al then tt.AddLine = function(self, t, ...) rec("tooltip", t); return al(self, t, ...) end end
	if ad then tt.AddDoubleLine = function(self, l, r, ...) rec("tooltip", l); rec("tooltip", r); return ad(self, l, r, ...) end end
	if st then tt.SetText = function(self, t, ...) rec("tooltip", t); return st(self, t, ...) end end
end
A.watchTooltip(GameTooltip)
A.watchTooltip(ItemRefTooltip)

do
	local am = DEFAULT_CHAT_FRAME.AddMessage
	DEFAULT_CHAT_FRAME.AddMessage = function(self, msg, ...) rec("chat", msg); return am(self, msg, ...) end
	UIErrorsFrame.AddMessage = function(_, msg) rec("error", msg) end
	local show = StaticPopup_Show
	function StaticPopup_Show(which, a1, a2, ...)
		local d = StaticPopupDialogs[which]
		if d then
			if d.text then local ok, s = pcall(string.format, d.text, a1 or "", a2 or ""); rec("popup", ok and s or d.text) end
			for _, k in ipairs({ "button1", "button2", "button3" }) do rec("popup", d[k]) end
		end
		return show(which, a1, a2, ...)
	end
	function print(...)
		local parts = {}
		for i = 1, select("#", ...) do parts[#parts + 1] = tostring((select(i, ...))) end
		rec("chat", table.concat(parts, " "))
	end
	if Settings then
		for _, fn in ipairs({ "RegisterCanvasLayoutCategory", "RegisterVerticalLayoutCategory", "RegisterCanvasLayoutSubcategory" }) do
			local o = Settings[fn]
			if o then Settings[fn] = function(a, b, c, ...) rec("settings", type(b) == "string" and b or (type(c) == "string" and c) or nil); return o(a, b, c, ...) end end
		end
	end
end

-- A menu description (MenuUtil) records its entries.
function A.menu()
	local node = {}
	local function child() return A.menu() end
	function node:CreateButton(t) rec("menu", t); return child() end
	function node:CreateCheckbox(t) rec("menu", t); return child() end
	function node:CreateRadio(t) rec("menu", t); return child() end
	function node:CreateTitle(t) rec("menu", t); return child() end
	function node:CreateDivider() return child() end
	function node:SetTooltip(fn) if type(fn) == "function" then pcall(fn, GameTooltip, child()) end end
	setmetatable(node, { __index = function() return function() return child() end end })
	return node
end

---------------------------------------------------------------------------
-- Where English came from, and the locale's own words.
---------------------------------------------------------------------------

local lmiss = {} -- interface key -> { addon = name, sites = { [site] = true } }
local nmiss = {} -- "kind:id" -> true
local ownPairs = {} -- { english, translation } of every translated text the client has
local shownNames = {} -- every name Polestar.Names gave (the client's language)
local guideTexts = {} -- pack id -> { [guide id] = { english = translation } }
local guideEnglish = {} -- { id, pack, texts = { english... }, names }

local function own(en, s)
	if type(s) == "string" and s ~= "" then ownPairs[#ownPairs + 1] = { en, s } end
end
local function shown(v) if type(v) == "string" and v:find("%a%a%a") then shownNames[v] = true end end

local function watchL(addon, ns)
	local L = ns.L
	setmetatable(L, { __index = function(_, key)
		if type(key) == "string" and key ~= "" then
			local e = lmiss[key]
			if not e then e = { addon = addon, sites = {} }; lmiss[key] = e end
			local s = site(3)[1]
			if s then e.sites[s] = true end
		end
		return key
	end })
	if ns.LC then
		local LC = ns.LC
		function ns.LC(context, text)
			local key = context .. ": " .. text
			if rawget(L, key) == nil and lmiss[key] == nil then lmiss[key] = { addon = addon, sites = {}, shows = text } end
			return LC(context, text)
		end
	end
	A.L = A.L or {}
	A.L[addon] = L
end

-- Polestar's L right after Core/Init.lua makes it; the Recorder's after
-- Recorder.lua does. Their locale files fill them next. The first file of
-- any other addon (the guides, a pack) finds Polestar loaded: its hooks go
-- in then, before a guide registers.
do
	local load = loadfile
	function loadfile(file)
		local chunk, err = load(file)
		if not chunk then return chunk, err end
		local folder = file:match("[/\\]addon[/\\]([^/\\]+)[/\\]")
		if folder and folder ~= "Polestar" and Polestar and Polestar.GuideTexts then A.hookPolestar() end
		local addon = (file:match("[/\\](Polestar)[/\\]Core[/\\]Init%.lua$")) or (file:match("[/\\](Polestar_Recorder)[/\\]Recorder%.lua$"))
		if not addon then return chunk, err end
		return function(name, ns, ...)
			local r = { chunk(name, ns, ...) }
			watchL(addon, ns)
			return unpack(r, 1, table.maxn(r))
		end
	end
end

-- Hooks into Polestar itself, once it has loaded.
function A.hookPolestar()
	local ns = Polestar
	if not ns or ns.__leaks then return end
	ns.__leaks = true
	-- LEAKS.everyStep: every step and goal shows, whatever class, race or
	-- faction it is for (the guide scenes: one character sees them all).
	if LEAKS.everyStep and ns.Guides and ns.Guides.Matches then ns.Guides.Matches = function() return true end end
	local Names = ns.Names
	-- A name Names had none for, with the Codex's English when it has one.
	local function missed(kind, id)
		local key = kind .. ":" .. tostring(id)
		if type(nmiss[key]) == "string" then return end
		local C = ns.Codex
		local ok, en = false, nil
		if C and C.Name and C.IsLoaded and C.IsLoaded() then ok, en = pcall(C.Name, kind, id) end
		nmiss[key] = (ok and type(en) == "string" and en ~= "") and en or true
	end
	for _, kind in ipairs({ "Quest", "Npc", "Object", "Item", "Spell", "Faction", "Instance", "Area", "Taxi", "Encounter" }) do
		local f = Names[kind]
		if f then
			local k = kind:lower()
			Names[kind] = function(id, ...)
				local v = f(id, ...)
				if v == nil and id ~= nil then missed(k, id) else shown(v) end
				return v
			end
		end
	end
	for _, fn in ipairs({ "Get", "Cached" }) do
		local f = Names[fn]
		Names[fn] = function(kind, id, ...)
			local v = f(kind, id, ...)
			if v == nil and kind and id ~= nil then missed(tostring(kind), id) else shown(v) end
			return v
		end
	end
	local reg = ns.RegisterGuideTexts
	function ns.RegisterGuideTexts(loc, packId, t)
		if loc == LOCALE and type(t) == "table" then
			local into = { pack = {}, guides = {} }
			for k, v in pairs(type(t.pack) == "table" and t.pack or {}) do into.pack[k] = v; own(k, v) end
			for id, list in pairs(type(t.guides) == "table" and t.guides or {}) do
				-- LEAKS.drop: translations to leave out (the tests' dropped text).
				for k in pairs(LEAKS.drop or {}) do list[k] = nil end
				into.guides[id] = list
				for k, v in pairs(list) do own(k, v) end
			end
			guideTexts[packId] = into
		end
		return reg(loc, packId, t)
	end
	local GT = ns.GuideTexts
	local prepare = GT.Prepare
	function GT.Prepare(def, ...)
		if type(def) == "table" and type(def.id) == "string" then
			local list = {}
			local function add(v) if type(v) == "string" and v:find("%a%a%a") then list[#list + 1] = v end end
			for _, f in ipairs({ "title", "why", "pitch" }) do add(def[f]) end
			for _, f in ipairs({ "pros", "cons" }) do for _, v in ipairs(type(def[f]) == "table" and def[f] or {}) do add(v) end end
			for _, r in ipairs(type(def.reward) == "table" and def.reward or {}) do if type(r) == "table" then add(r.text) end end
			for _, step in ipairs(type(def.steps) == "table" and def.steps or {}) do
				add(step.title); add(step.note)
				for _, g in ipairs(type(step.goals) == "table" and step.goals or {}) do if type(g) == "table" then add(g.note); add(g.text); if g.t == "kill" and g.npc == nil then add(g.target) end end end
			end
			-- The goals name their quest, NPC, object, item, spell, faction and zone.
			local names = {}
			for k, v in pairs(type(def.names) == "table" and def.names or {}) do names[k] = v end
			for _, step in ipairs(type(def.steps) == "table" and def.steps or {}) do
				for _, g in ipairs(type(step.goals) == "table" and step.goals or {}) do
					if type(g) == "table" then
						local function name(kind, id, en)
							if type(id) == "number" and type(en) == "string" then names[kind .. ":" .. id] = names[kind .. ":" .. id] or en end
						end
						-- The source first: a quest named after its mob gives the mob's id.
						name(g.fromKind or "npc", g.fromId, g.from)
						name(g.fromKind or "npc", g.fromAlsoId, g.fromAlso)
						name("npc", g.npc, g.target)
						for kind, field in pairs({ npc = "npcName", item = "itemName", object = "objName", spell = "spellName", faction = "factionName", quest = "title", zone = "zoneName" }) do
							name(kind, g[kind], g[field])
						end
						for _, c in ipairs(type(g.candidates) == "table" and g.candidates or {}) do
							if type(c) == "table" then name("npc", c.npc, c.npcName) end
						end
					end
				end
			end
			guideEnglish[#guideEnglish + 1] = { id = def.id, pack = def.pack, folder = def.folder, texts = list, names = names }
		end
		return prepare(def, ...)
	end
end

---------------------------------------------------------------------------
-- Scenes: run, hover, report.
---------------------------------------------------------------------------

function A.try(name, fn, ...)
	A.scene(name)
	local ok, err = xpcall(fn, debug.traceback, ...)
	if not ok then errors[#errors + 1] = { scene = name, error = tostring(err) } end
	stub.runTimers()
end

local function hoverable(f)
	return (f.scripts.OnEnter or (f.hooks.OnEnter and #f.hooks.OnEnter > 0)) and f:IsVisible()
end

-- Every shown frame with a tooltip under `root` (a frame or its global name;
-- every frame when nil) is hovered, then left.
function A.hover(root, label)
	if type(root) == "string" then root = _G[root] end
	local list = {}
	if root then
		local function walk(f)
			if f.children then for _, c in ipairs(f.children) do if c:IsVisible() then
				if hoverable(c) then list[#list + 1] = c end
				walk(c)
			end end end
		end
		walk(root)
	else
		for _, f in ipairs(stub.frames) do if hoverable(f) then list[#list + 1] = f end end
	end
	local was = scene
	if label then A.scene(label) end
	for _, f in ipairs(list) do
		pcall(stub.RunScript, f, "OnEnter", false)
		pcall(stub.RunScript, f, "OnLeave", false)
	end
	A.scene(was)
end

local function strip(s)
	return (s:gsub("|c%x%x%x%x%x%x%x%x", " "):gsub("|r", " "):gsub("|T.-|t", " "):gsub("|A.-|a", " ")
		:gsub("|H.-|h", " "):gsub("|h", " "):gsub("|n", " "):gsub("|4", " "):gsub("⟦.-⟧", " "))
end

-- What the player typed (a search, a command's arguments) is theirs when a
-- text repeats it: cut out as whole words.
local typed = {}
function A.typed(s)
	if type(s) ~= "string" then return end
	for part in s:gmatch("[^%s]+") do
		if part:find("%a%a%a") then typed[#typed + 1] = "%f[%w]" .. part:gsub("%p", "%%%0") .. "%f[%W]" end
	end
end
local function cutTyped(s)
	for _, p in ipairs(typed) do s = s:gsub(p, " ") end
	return s
end

-- Latin words of 3+ letters (a word with any other letter is not English).
local function words(s, into)
	into = into or {}
	for w in s:gmatch("[%a\128-\255]+") do
		if #w >= 3 and not w:find("[\128-\255]") then into[#into + 1] = w end
	end
	return into
end

-- The literal stretches of an English text with its {kind:id} tokens and
-- format directives cut out, longest first.
local function stretches(s)
	local out = {}
	for part in (s:gsub("{%l+:%d+}", "\0"):gsub("%%[%d%$%-%.]*%a", "\0") .. "\0"):gmatch("([^%z]*)%z") do
		part = part:gsub("^%s+", ""):gsub("%s+$", "")
		if part:find("%a%a%a") then out[#out + 1] = part end
	end
	table.sort(out, function(a, b) return #a > #b end)
	return out
end

-- The languages written in Latin letters: their translations teach words.
local LATIN = { deDE = true, esES = true, esMX = true, frFR = true, ptBR = true }

-- A text with what is the same in every language cut out: the allow list's
-- products and terms (LEAKS.products), slash commands with their documented
-- arguments (LEAKS.slashArgs), {kind:id} tokens, format directives.
local productPatterns
local function universal(s)
	if not productPatterns then
		productPatterns = {}
		for _, p in ipairs(LEAKS.products or {}) do productPatterns[#productPatterns + 1] = "%f[%w]" .. p:gsub("%p", "%%%0") .. "%f[%W]" end
	end
	s = strip(s):gsub("{%l+:%d+}", " "):gsub("%%[%d%$%-%.]*%a", " ")
	for _, p in ipairs(productPatterns) do s = s:gsub(p, " ") end
	local args = LEAKS.slashArgs or {}
	s = s:gsub("/%l[%w]*([%w ,]*)", function(after)
		local rest, cut = after, true
		while cut do
			cut = false
			local w, tail = rest:match("^[ ,]+(%a+)(.*)$")
			if w and args[w] then rest, cut = tail, true end
		end
		return " " .. rest
	end)
	return s
end

function A.dump()
	-- The language's own words: in a language written in Latin letters, the
	-- words of its real translations (learn); in Russian, Korean and Chinese,
	-- none: a Latin word there is never the language's own.
	local vocab = {}
	-- A translation teaches its words when at least half of them are not in
	-- its English (a real translation: its words the English shares too, such
	-- as German "Horde" or "Guide"); one that mostly copies its English, or
	-- equals it, teaches nothing.
	local function allWords(t)
		local out = {}
		for w in t:gmatch("[%a\128-\255]+") do if #w >= 3 then out[#out + 1] = w:lower() end end
		return out
	end
	local kept = {} -- Latin word -> a translation's English key that keeps it
	local function learn(en, tr)
		local has = {}
		for _, w in ipairs(allWords(universal(en))) do has[w] = true end
		local all, novel = allWords(universal(tr)), 0
		for _, w in ipairs(all) do if not has[w] then novel = novel + 1 end end
		local list = words(universal(tr))
		for _, w in ipairs(list) do kept[w:lower()] = kept[w:lower()] or en end
		if tr == en or not LATIN[LOCALE] or novel == 0 or novel * 2 < #all then return end
		for _, w in ipairs(list) do vocab[w:lower()] = true end
	end
	for _, L in pairs(A.L or {}) do
		for k, v in pairs(L) do if type(k) == "string" and type(v) == "string" then learn(k, v) end end
	end
	for _, p in ipairs(ownPairs) do learn(p[1], p[2]) end
	-- The names Polestar.Names gave are the client's: by each of their Latin words.
	-- A word of four letters or more from one of them is the language's own
	-- wherever it shows (a first name, a name with an ending).
	local nameIndex, nameWords = {}, {}
	for name in pairs(shownNames) do
		for _, w in ipairs(words(strip(name))) do
			local lw = w:lower()
			if #lw >= 4 then nameWords[lw] = true end
			nameIndex[lw] = nameIndex[lw] or {}
			table.insert(nameIndex[lw], name)
		end
	end

	-- English sources, by the literal stretches that show.
	local sources = {}
	for key, e in pairs(lmiss) do
		local sites = {}
		for s in pairs(e.sites) do sites[#sites + 1] = s end
		table.sort(sites)
		local st = stretches(e.shows or key)
		if st[1] then sources[#sources + 1] = { kind = "interface", key = key, addon = e.addon, sites = sites, match = st[1] } end
	end
	for _, g in ipairs(guideEnglish) do
		local tr = guideTexts[g.pack or ""]
		local list = tr and tr.guides[g.id]
		for _, en in ipairs(g.texts) do
			if not (list and list[en]) then
				local st = stretches(en)
				if st[1] then sources[#sources + 1] = { kind = "guide", guide = g.id, english = en, match = st[1] } end
			end
		end
		local tf = tr and tr.pack
		if type(g.folder) == "string" and not (tf and tf[g.folder]) and g.folder:find("%a%a%a") then
			sources[#sources + 1] = { kind = "guide", guide = g.pack or "?", english = g.folder, match = g.folder, field = "folder" }
		end
	end
	-- A name shows in the English its guide gives it: the names pack lacks
	-- it (asked and missed), or nothing asked Polestar.Names for it.
	local english = {}
	for _, g in ipairs(guideEnglish) do
		for k, v in pairs(g.names) do if type(v) == "string" and v:find("%a%a%a") then english[k] = english[k] or v end end
	end
	for key in pairs(nmiss) do
		local en = english[key] or (type(nmiss[key]) == "string" and nmiss[key] or nil)
		if en then sources[#sources + 1] = { kind = "name", name = key, english = en, match = en } end
	end
	for key, en in pairs(english) do
		if not nmiss[key] then sources[#sources + 1] = { kind = "unasked", name = key, english = en, match = en } end
	end

	-- One of the language's own words, or one with an inflection ending (a
	-- German genitive "Verbanntes" of a name's "Verbannte", French "s").
	local function ownWord(lw)
		if vocab[lw] or nameWords[lw] then return true end
		if not LATIN[LOCALE] then return false end
		for n = 1, 2 do
			local stem = lw:sub(1, -n - 1)
			if #stem >= 4 and (vocab[stem] or nameWords[stem]) then return true end
		end
		return false
	end

	local out = {}
	for _, e in ipairs(texts) do
		local plain = strip(e.text)
		local function flag(s)
			local flagged, seenW = {}, {}
			for _, w in ipairs(words(s)) do
				local lw = w:lower()
				if not ownWord(lw) and not seenW[lw] then seenW[lw] = true; flagged[#flagged + 1] = w end
			end
			return flagged
		end
		local rest = cutTyped(plain)
		local flagged = flag(rest)
		if #flagged > 0 then
			-- Cut the names the client gave that hold a flagged word, the longest first.
			local cand, seenN = {}, {}
			for _, w in ipairs(flagged) do
				for _, n in ipairs(nameIndex[w:lower()] or {}) do
					if not seenN[n] then seenN[n] = true; cand[#cand + 1] = n end
				end
			end
			if #cand > 0 then
				table.sort(cand, function(a, b) return #a > #b end)
				for _, n in ipairs(cand) do
					local a, b = rest:find(n, 1, true)
					while a do
						rest = rest:sub(1, a - 1) .. " " .. rest:sub(b + 1)
						a, b = rest:find(n, 1, true)
					end
				end
				flagged = flag(rest)
			end
		end
		if #flagged > 0 then
			-- The source whose English it holds the most of (the first on a
			-- tie), and every missed name it holds (for the baseline).
			local best, names = nil, {}
			for _, s in ipairs(sources) do
				if plain:find(s.match, 1, true) then
					if not best or #s.match > #best.match then best = s end
					if s.kind == "name" and #names < 12 then names[#names + 1] = { name = s.name, english = s.english } end
				end
			end
			-- Every flagged word is one a translation of this language keeps
			-- in English (a name it writes as the English does): which one.
			-- The flagged words a translation of this language keeps in English
			-- (Node decides once the names and the allow list are cut).
			local keeps = {}
			for _, w in ipairs(flagged) do
				local k = kept[w:lower()]
				if k then keeps[w:lower()] = k end
			end
			out[#out + 1] = { kind = e.kind, text = e.text, plain = plain, words = flagged, site = e.site, scenes = e.scenes, from = best, names = names, keeps = next(keeps) and keeps or nil }
		end
	end
	local missedNames = {}
	local missedEnglish = {}
	for k, v in pairs(nmiss) do
		missedNames[#missedNames + 1] = k
		-- Its English: the Codex's, else the guides' (without built data, as on CI).
		if type(v) == "string" then missedEnglish[k] = v elseif english[k] then missedEnglish[k] = english[k] end
	end
	table.sort(missedNames)
	-- LEAKS.all: every text as well (to see what a scene shows).
	emit({ leaks = true, locale = LOCALE, candidates = out, texts = #texts, all = LEAKS.all and texts or nil, errors = errors, missedNames = missedNames, missedEnglish = next(missedEnglish) and missedEnglish or nil })
end
