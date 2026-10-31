-- Client pieces the Lookup runtime touches (Hooks, Spotter, Alt-click), for
-- tests/lookup.test.js. Load after wow_stub.lua and stub_world.lua.
--
--   lookuprt.postCalls[type]            TooltipDataProcessor post-calls, by Enum.TooltipDataType
--   lookuprt.showItem(tt, id, link)     run the item post-calls as ProcessInfo does
--   lookuprt.showUnit(tt, unit)         run the unit post-calls for a unit token
--   lookuprt.showObject(tt, data)       run the object post-calls with tooltip data { id, guid, lines }
--   lookuprt.SECRET                     a value issecretvalue() reports as secret
--   lookuprt.units[unit] = { guid, player = true }
--   lookuprt.auras[unit] = { { spellId, name, icon }, ... }   (HELPFUL)
--   lookuprt.auraError = true           GetAuraDataByIndex raises (no aura access)
--   lookuprt.journal[spellId] = { id, name, icon }             C_MountJournal
--   lookuprt.button = "LeftButton"      GetMouseButtonClicked()
--   lookuprt.clickItem(link)            a modified click (HandleModifiedItemClick)
--
-- ClearLines/SetOwner simulate OnTooltipCleared through the generic script
-- dispatcher. This models the lifecycle under test, not verified Forever
-- native event timing. The show helpers only deliver post-calls: they never
-- clear lines, so tests can also model repeated callbacks and appended text.

lookuprt = { postCalls = {}, units = {}, auras = {}, journal = {}, button = "LeftButton", clicks = {} }

lookuprt.SECRET = setmetatable({}, { __tostring = function() return "<secret>" end })
function issecretvalue(v) return v == lookuprt.SECRET end
Enum.TooltipDataType = { Item = 0, Unit = 2, Object = 4 }
TooltipDataProcessor = { AllTypes = "ALL" }
function TooltipDataProcessor.AddTooltipPostCall(kind, fn)
	lookuprt.postCalls[kind] = lookuprt.postCalls[kind] or {}
	table.insert(lookuprt.postCalls[kind], fn)
end

ItemRefTooltip = CreateFrame("GameTooltip", "ItemRefTooltip", UIParent)
for _, tt in ipairs({ GameTooltip, ItemRefTooltip }) do
	tt.lines = tt.lines or {}
	tt.ClearLines = function(self)
		self.lines = {}
		stub.RunScript(self, "OnTooltipCleared")
	end
	tt.SetOwner = function(self, owner, anchor)
		self.owner, self.anchor = owner, anchor
		self:ClearLines()
	end
	tt.AddLine = function(self, text) table.insert(self.lines, tostring(text)) end
	tt.AddDoubleLine = function(self, l, r) table.insert(self.lines, tostring(l) .. " | " .. tostring(r)) end
	tt.NumLines = function(self) return #self.lines end
	tt.IsForbidden = function(self) return self.forbidden end
end

local function run(kind, tt, data)
	for _, fn in ipairs(lookuprt.postCalls[kind] or {}) do fn(tt, data) end
end

function lookuprt.showItem(tt, id, link)
	tt.link = link
	run(Enum.TooltipDataType.Item, tt, { type = Enum.TooltipDataType.Item, id = id })
end

function lookuprt.showUnit(tt, unit)
	local u = lookuprt.units[unit]
	run(Enum.TooltipDataType.Unit, tt, { type = Enum.TooltipDataType.Unit, guid = u and u.guid })
end

function lookuprt.showObject(tt, data)
	data.type = Enum.TooltipDataType.Object
	run(Enum.TooltipDataType.Object, tt, data)
end

GameTooltip.GetItem = function(self) return nil, self.link end
ItemRefTooltip.GetItem = GameTooltip.GetItem

function UnitExists(unit) return unit == "player" or lookuprt.units[unit] ~= nil end
function UnitIsPlayer(unit)
	local u = lookuprt.units[unit]
	if u and u.secretPlayer then return lookuprt.SECRET end
	return unit == "player" or (u and u.player) or false
end
function UnitTokenFromGUID(guid)
	for unit, u in pairs(lookuprt.units) do
		if u.guid == guid then return unit end
	end
	return nil
end
local worldGUID = UnitGUID
function UnitGUID(unit)
	local u = lookuprt.units[unit]
	if u then return u.guid end
	return worldGUID(unit)
end

C_UnitAuras = {}
function C_UnitAuras.GetAuraDataByIndex(unit, index, filter)
	if lookuprt.auraError then error("no aura access") end
	local list = lookuprt.auras[unit]
	local a = list and list[index]
	if not a then return nil end
	return { spellId = a.spellId, name = a.name, icon = a.icon, auraInstanceID = index }
end

C_MountJournal = {}
function C_MountJournal.GetMountFromSpell(spellId)
	local m = lookuprt.journal[spellId]
	return m and m.id or nil
end
function C_MountJournal.GetMountInfoByID(mountID)
	for spellId, m in pairs(lookuprt.journal) do
		if m.id == mountID then return m.name, spellId, m.icon, false, true, 0, false, false, nil, false, false, mountID, false end
	end
end

function GetMouseButtonClicked() return lookuprt.button end

-- The client's handler: Shift (chat link) and Ctrl (dress up) do their own
-- thing; everything is post-hooked by Polestar.Hooks.
function HandleModifiedItemClick(link)
	table.insert(lookuprt.clicks, link)
	return false
end

function lookuprt.clickItem(link)
	return HandleModifiedItemClick(link)
end
