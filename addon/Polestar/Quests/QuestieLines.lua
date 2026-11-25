-- With qol.questTooltipsQuestie, Questie leaves out its lines for the quests
-- Polestar's own tooltip lines name on the same mob, item or object, so each
-- quest shows once. Questie's other lines stay (quests Polestar does not name,
-- its IDs), and in a group all of them: they carry the party's progress, as
-- the game's rows do under qol.questTooltipsReplace.
--
-- Questie (12.14) builds those lines in QuestieTooltips.GetTooltip(key, zone)
-- from QuestieTooltips.lookupByKey[key], one entry per quest objective or
-- starter, { questId = ... }; key "m_<npc id>", "i_<item id>" or
-- "o_<object id>". Its tooltip handlers call it through the module table, so
-- Polestar wraps that field once (when Questie is loaded and the setting is
-- first on): around Questie's own call it takes the entries of the quests
-- Q.TooltipQuests names out of that key's table and puts them straight back.
-- Questie's data is never left changed. Plater reads the same function for
-- its nameplate quest lines, so those quests leave there too. Anything
-- unexpected (no module, another shape, an error) leaves Questie's call as
-- it was.
--
--   QL.Wrap() -> bool                -- wrap now if Questie is loaded (tests, login)

local ADDON, ns = ...

local Q = ns.QuestDB
local type, pairs, tonumber = type, pairs, tonumber

local QL = {}
ns.QuestieLines = QL

local KINDS = { m_ = "unit", i_ = "item", o_ = "object" }
local wrapped = false

local function wanted()
	return ns.Get("qol.questTooltipsQuestie") and not ns.Hidden() and not (IsInGroup and IsInGroup())
end

-- Takes the entries Polestar's lines cover out of key's table. -> held, entries
local function hold(tooltips, key)
	if not wanted() or type(key) ~= "string" then return nil end
	local kind = KINDS[key:sub(1, 2)]
	local id = kind and tonumber(key:sub(3))
	local byKey = id and tooltips.lookupByKey
	local entries = type(byKey) == "table" and byKey[key]
	if type(entries) ~= "table" then return nil end
	local set = Q.TooltipQuests(kind, id)
	if not set then return nil end
	local held
	for k, e in pairs(entries) do
		if type(e) == "table" and set[e.questId] then
			held = held or {}
			held[k] = e
		end
	end
	if not held then return nil end
	for k in pairs(held) do entries[k] = nil end
	return held, entries
end

local function questieTooltips()
	local loader = QuestieLoader
	if not (type(loader) == "table" and type(loader.ImportModule) == "function") then return nil end
	local ok, mod = pcall(loader.ImportModule, loader, "QuestieTooltips")
	if ok and type(mod) == "table" and type(mod.GetTooltip) == "function" and type(mod.lookupByKey) == "table" then
		return mod
	end
end

function QL.Wrap()
	if wrapped then return true end
	local A = C_AddOns
	if not (A and A.IsAddOnLoaded and A.IsAddOnLoaded("Questie")) then return false end
	local tooltips = questieTooltips()
	if not tooltips then return false end
	local original = tooltips.GetTooltip
	wrapped = true
	tooltips.GetTooltip = function(key, ...)
		local okHold, held, entries = pcall(hold, tooltips, key)
		if not okHold then
			ns.NoteError(held)
			held = nil
		end
		local ok, res = pcall(original, key, ...)
		if held then
			for k, e in pairs(held) do
				if entries[k] == nil then entries[k] = e end
			end
		end
		if not ok then error(res, 0) end
		return res
	end
	return true
end

local function try()
	if wrapped or not ns.Get("qol.questTooltipsQuestie") then return end
	if QL.Wrap() then ns.UnregisterEvent("ADDON_LOADED", try) end
end

ns.On("SETTING_CHANGED", function(path)
	if path == "qol.questTooltipsQuestie" or path == "qol" or path == "" then try() end
end)
ns.OnLogin(function()
	try()
	if not wrapped then ns.RegisterEvent("ADDON_LOADED", try) end
end)
