-- Quest titles and item names in the client's language.
--
--   Names.Quest(questID, english) -> the client's title, else english
--   Names.Item(itemID, english)   -> the client's name, else english
--
-- `english` is the compiled name: it shows only while the client has no name
-- yet (a quest or an item it has not loaded). A missing name is asked for
-- once a session (Compat.RequestQuest / RequestItem); when one asked here
-- arrives (QUEST_DATA_LOAD_RESULT / ITEM_DATA_LOAD_RESULT), NAMES_CHANGED
-- fires, at most once per NAMES_DELAY, and what shows names redraws (the
-- Engine re-evaluates: the guide window and the arrow's label).

local ADDON, ns = ...

local Names = {}
ns.Names = Names

local NAMES_DELAY = 0.2 -- seconds: a burst of arrivals redraws once

-- kind -> id -> true while asked, false once answered
local asked = { quest = {}, item = {} }

local function client(kind, id)
	if type(id) ~= "number" then return nil end
	local C = ns.Compat
	local name
	if kind == "quest" then name = C.GetQuestTitle(id) else name = C.GetItemName(id) end
	if name then return name end
	if asked[kind][id] == nil then
		asked[kind][id] = true
		if kind == "quest" then C.RequestQuest(id) else C.RequestItem(id) end
	end
	return nil
end

function Names.Quest(questID, english) return client("quest", questID) or english end
function Names.Item(itemID, english) return client("item", itemID) or english end

local scheduled = false
local function announce()
	scheduled = false
	ns.Fire("NAMES_CHANGED")
end

-- Only the IDs asked here: other addons and the client load quests and items
-- all the time.
local function arrived(kind)
	return function(_, id, success)
		if asked[kind][id] ~= true then return end
		asked[kind][id] = false
		if not success or scheduled then return end
		scheduled = true
		C_Timer.After(NAMES_DELAY, announce)
	end
end

ns.RegisterEvent("QUEST_DATA_LOAD_RESULT", arrived("quest"))
ns.RegisterEvent("ITEM_DATA_LOAD_RESULT", arrived("item"))
