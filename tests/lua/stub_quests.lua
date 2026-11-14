-- Client pieces the Quests module needs on top of wow_stub.lua and
-- stub_world.lua (load both first): quest log enumeration, the bulk
-- completed-quest call, TooltipDataProcessor, nameplates, secret values,
-- LoadAddOn for the load-on-demand Polestar_QuestDB, and a contract-faithful
-- fake of Polestar.Pins (docs/ARCHITECTURE.md, "Pins").
--
--   local sq = stub.quests
--   sq.dbFiles = { "/abs/Quests.lua", ... }   -- files LoadAddOn("Polestar_QuestDB") runs
--   sq.installPins()                          -- after the addon loaded: Polestar.Pins = fake
--   sq.pins.layers[layer] -> { pins = {...}, opts = {...} } ; sq.pins.calls -> { { "SetLayer", layer, n }, ... }
--   sq.hoverUnit(npcID [, secret])            -- run the Unit tooltip post-calls on GameTooltip
--   sq.hoverItem(itemID); sq.hoverObject(objectID, name)
--   sq.addPlate(unit, npcID [, secret]); sq.removePlate(unit)
--   sq.secret(value)                          -- issecretvalue(value) is true from now on
--   sq.collapsed[questID] = true              -- in the log, hidden from enumeration (collapsed header)

local world = assert(stub.world, "stub_quests.lua needs stub_world.lua")

local sq = { dbFiles = {}, loadCalls = 0, secrets = {}, plates = {}, postCalls = {}, collapsed = {} }
stub.quests = sq

---------------------------------------------------------------------------
-- Secret values
---------------------------------------------------------------------------

function issecretvalue(v) return sq.secrets[v] == true end
function sq.secret(v) sq.secrets[v] = true end

---------------------------------------------------------------------------
-- Quest log enumeration (log order = quest ID order) and completed quests
---------------------------------------------------------------------------

local function sortedLog()
	local ids = {}
	for q in pairs(world.log) do
		if not sq.collapsed[q] then ids[#ids + 1] = q end -- under a collapsed header: not enumerated
	end
	table.sort(ids)
	return ids
end

-- Forever's client answers 0 (Compat.GetLogCap: its log holds 40).
function C_QuestLog.GetMaxNumQuestsCanAccept() return 0 end

function C_QuestLog.GetNumQuestLogEntries()
	local n = #sortedLog()
	return n + (n > 0 and 1 or 0), n -- one header line when the log is not empty
end

function C_QuestLog.GetInfo(i)
	local ids = sortedLog()
	if #ids == 0 then return nil end
	if i == 1 then return { title = "Zone", questLogIndex = 1, questID = 0, isHeader = true, level = 0 } end
	local q = ids[i - 1]
	if not q then return nil end
	return { title = world.log[q].title, questLogIndex = i, questID = q, isHeader = false, level = 1 }
end

function C_QuestLog.GetAllCompletedQuestIDs()
	local out = {}
	for q, done in pairs(world.completed) do
		if done then out[#out + 1] = q end
	end
	table.sort(out)
	return out
end

---------------------------------------------------------------------------
-- LoadAddOn for the quest database
---------------------------------------------------------------------------

local baseLoad = C_AddOns.LoadAddOn
function C_AddOns.LoadAddOn(name)
	if name ~= "Polestar_QuestDB" then return baseLoad(name) end
	sq.loadCalls = sq.loadCalls + 1
	if stub.addonsLoaded[name] then return true end
	if #sq.dbFiles == 0 then return false, "MISSING" end
	local ns = {}
	for _, f in ipairs(sq.dbFiles) do
		local chunk, err = loadfile(f)
		if not chunk then error(err, 0) end
		chunk(name, ns)
	end
	stub.addonLoaded(name)
	return true
end
LoadAddOn = C_AddOns.LoadAddOn

---------------------------------------------------------------------------
-- Tooltips: TooltipDataProcessor post-calls
---------------------------------------------------------------------------

Enum.TooltipDataType = { Item = 0, Spell = 1, Unit = 2, Corpse = 3, Object = 4 }
TooltipDataProcessor = { AllTypes = "ALL" }
function TooltipDataProcessor.AddTooltipPostCall(kind, fn)
	sq.postCalls[kind] = sq.postCalls[kind] or {}
	table.insert(sq.postCalls[kind], fn)
end
function TooltipDataProcessor.AddTooltipPreCall() end
function TooltipDataProcessor.AddLinePreCall() end
function TooltipDataProcessor.AddLinePostCall() end

local function runPostCalls(kind, data)
	GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	GameTooltip:AddLine(data.name or "?")
	for _, fn in ipairs(sq.postCalls[kind] or {}) do fn(GameTooltip, data) end
	return GameTooltip.lines
end

-- The unit is "mouseover" (Hooks finds it through GameTooltip:GetUnit()).
function sq.hoverUnit(npc, secret)
	local guid = world.npcGUID(npc)
	if secret then sq.secret(guid) end
	world.units.mouseover = guid
	GameTooltip.GetUnit = function() return "?", "mouseover" end
	return runPostCalls(Enum.TooltipDataType.Unit, { type = 2, guid = guid })
end

function sq.hoverItem(item)
	return runPostCalls(Enum.TooltipDataType.Item, { type = 0, id = item })
end

function sq.hoverObject(object, name)
	return runPostCalls(Enum.TooltipDataType.Object, { type = 4, id = object, lines = { { leftText = name } } })
end

---------------------------------------------------------------------------
-- Nameplates
---------------------------------------------------------------------------

C_NamePlate = {}
function C_NamePlate.GetNamePlateForUnit(unit)
	return sq.plates[unit]
end

-- build(plate), when given, adds frames to the base plate before the event
-- (a replacement nameplate addon that built its plate first).
function sq.addPlate(unit, npc, secret, build)
	local guid = world.npcGUID(npc)
	if secret then sq.secret(guid) end
	world.units[unit] = guid
	sq.plates[unit] = CreateFrame("Frame", nil, UIParent)
	if build then build(sq.plates[unit]) end
	stub.fire("NAME_PLATE_UNIT_ADDED", unit)
end

function sq.removePlate(unit)
	stub.fire("NAME_PLATE_UNIT_REMOVED", unit)
	sq.plates[unit] = nil
	world.units[unit] = nil
end

---------------------------------------------------------------------------
-- Polestar.Pins fake (contract: SetLayer / ClearLayer / SetLayerVisible / WatchMinimapView; a pin at map, x, y
-- or at the additive world position c, wx, wy)
---------------------------------------------------------------------------

local pins = { layers = {}, calls = {}, visible = {} }
sq.pins = pins

function pins.SetLayer(layer, list, opts)
	assert(type(layer) == "string", "layer must be a string")
	assert(type(list) == "table", "pins must be a table")
	for i, p in ipairs(list) do
		local onMap = type(p.map) == "number" and type(p.x) == "number" and type(p.y) == "number"
		local inWorld = p.c ~= nil and type(p.wx) == "number" and type(p.wy) == "number"
		assert(onMap or inWorld, "pin " .. i .. " needs map, x, y or c, wx, wy")
		assert(p.hull == nil or (type(p.hull) == "table" and #p.hull >= 6 and #p.hull % 2 == 0), "pin hull must be wx, wy pairs of 3 or more corners")
		assert(p.f == nil or p.f == "e" or p.f == "l", "pin frame must be nil, 'e' or 'l'")
		assert(p.tooltip == nil or type(p.tooltip) == "string" or type(p.tooltip) == "function", "bad tooltip")
		assert(p.area == nil or (type(p.area) == "number" and p.area > 0), "pin area must be a positive number of yards")
	end
	pins.layers[layer] = { pins = list, opts = opts or {} }
	table.insert(pins.calls, { "SetLayer", layer, #list })
end

function pins.ClearLayer(layer)
	pins.layers[layer] = nil
	table.insert(pins.calls, { "ClearLayer", layer })
end

function pins.SetLayerVisible(layer, visible)
	pins.visible[layer] = visible and true or false
	table.insert(pins.calls, { "SetLayerVisible", layer, visible and true or false })
end

-- The minimap view's watchers (Maps/RouteLines.lua's route line asks for one): kept, never called.
function pins.WatchMinimapView(key, fn)
	pins.watchers = pins.watchers or {}
	pins.watchers[key] = fn
end

function sq.installPins()
	Polestar.Pins = pins
end

-- Tooltip lines a pin shows.
function sq.pinTooltip(pin)
	GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	if type(pin.tooltip) == "function" then pin.tooltip(GameTooltip) else GameTooltip:AddLine(pin.tooltip) end
	return GameTooltip.lines
end

return sq
