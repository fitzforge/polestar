-- Bag space (qol.bagSpace, on by default): how many bag slots are free, and
-- a way to make room. Only bags that take any item count, not quivers, ammo
-- pouches, soul or profession bags. At qol.bagsLow free slots or fewer:
--   * the bag button (QoL/Buttons.lua, bindable) comes up, showing the free
--     slots and the cheapest junk in the bags: a grey item, or one marked as
--     junk (QoL/Marks.lua) of common quality or below; never one marked to
--     keep or one a later step needs. Its worth is the vendor price of the
--     stack (an item without one is worth nothing; one whose price the client
--     has not loaded yet goes last).
--   * while the live step has an open collect goal, the guide window's
--     banner says so and offers the same delete (Space.Banner).
-- Deleting takes two presses of the button, its binding or the banner's
-- link: the first arms that item for ARM seconds, the second deletes it
-- once the slot is read again and still holds it (an item moved or swapped
-- in between is left alone, and the next press arms afresh). Nothing is
-- ever deleted any other way.
--
-- Fires BAG_SPACE when the free count, the cheapest junk or the armed item
-- changes.
--
-- Client: C_Container.GetContainerNumFreeSlots (bagFamily 0: any item),
-- GetContainerItemInfo, PickupContainerItem; CursorHasItem, DeleteCursorItem
-- (ContainerDocumentation, GameCursorDocumentation; the client's DELETE_ITEM
-- dialog in GameDialogDefs.lua calls it from its button).

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local Client = QoL.Client

local format, huge, tonumber = string.format, math.huge, tonumber

local Space = {}
QoL.Space = Space

local ARM = 5 -- seconds the first press keeps an item armed

local free, total = 0, 0
local junk         -- { bag, slot, id, count, value, link }: the cheapest junk, or nil
local armed        -- { bag, slot, id, at }
local dismissed = false
local sig

-- Free and total slots of the bags that take any item.
function Space.Count()
	local f, t = 0, 0
	for bag = 0, Client.NumBags() do
		local n, family = Client.FreeSlots(bag)
		if not family or family == 0 then
			f = f + n
			t = t + Client.NumSlots(bag)
		end
	end
	return f, t
end

local function candidate(info)
	if not info or info.isLocked or not info.itemID then return false end
	local Marks = QoL.Marks
	if Marks.Protected(info.itemID) then return false end
	if info.quality == Client.QUALITY_POOR then return true end
	return Marks.Junk(info.itemID) and info.quality ~= nil and info.quality <= Client.QUALITY_COMMON
end

-- The cheapest junk in the bags: { bag, slot, id, count, value, link } or nil.
function Space.Cheapest()
	local best, bestValue
	for bag = 0, Client.NumBags() do
		for slot = 1, Client.NumSlots(bag) do
			local info = Client.SlotInfo(bag, slot)
			if candidate(info) then
				local count = info.stackCount or 1
				local value
				if info.hasNoValue then
					value = 0
				else
					local price = Client.SellPrice(info.itemID)
					value = price and price * count or huge
				end
				if not best or value < bestValue then
					best = { bag = bag, slot = slot, id = info.itemID, count = count, value = value, link = info.hyperlink }
					bestValue = value
				end
			end
		end
	end
	return best
end

function Space.Threshold()
	return tonumber(ns.Get("qol.bagsLow")) or 0
end

-- At or under the threshold, with the feature on.
function Space.Low()
	return QoL.On("bagSpace") and free <= Space.Threshold()
end

function Space.Free() return free, total end
function Space.Junk() return junk end

-- The armed item is the cheapest junk still.
function Space.Armed()
	return armed ~= nil and junk ~= nil and armed.bag == junk.bag and armed.slot == junk.slot and armed.id == junk.id
end

local function signature()
	local j = junk
	return free .. ":" .. total .. ":" .. (j and (j.bag .. "/" .. j.slot .. "/" .. j.id .. "/" .. j.count) or "-")
		.. ":" .. (Space.Armed() and "armed" or "") .. ":" .. (Space.Low() and "low" or "") .. ":" .. (dismissed and "d" or "")
end

-- Reads the bags again; fires BAG_SPACE when something shown changed.
function Space.Refresh()
	free, total = Space.Count()
	junk = Space.Low() and Space.Cheapest() or nil
	if not Space.Low() then dismissed = false end
	local s = signature()
	if s ~= sig then
		sig = s
		ns.Fire("BAG_SPACE")
	end
end
local refreshSoon = QoL.Coalesce(Space.Refresh)

local function itemText(j)
	local name = j.link or (L["Item"] .. " " .. j.id)
	if j.count > 1 then name = name .. " x" .. j.count end
	return name
end
Space.ItemText = itemText

-- The one press: arm the cheapest junk, or delete it when it is armed
-- already. -> "armed", "deleted", "none" (nothing to delete), "busy" (the
-- cursor holds something) or "off".
function Space.Press()
	if not QoL.On("bagSpace") then return "off" end
	Space.Refresh()
	local j = junk
	if not j then
		armed = nil
		return "none"
	end
	local now = GetTime()
	if Space.Armed() and now - armed.at <= ARM then
		armed = nil
		local info = Client.SlotInfo(j.bag, j.slot)
		local result = "busy"
		if info and info.itemID == j.id and candidate(info) and Client.DeleteSlot(j.bag, j.slot) then
			ns.Print(format(L["Deleted %s."], itemText(j)))
			result = "deleted"
		end
		Space.Refresh()
		return result
	end
	local this = { bag = j.bag, slot = j.slot, id = j.id, at = now }
	armed = this
	if C_Timer and C_Timer.After then
		ns.After(ARM, function()
			if armed == this then
				armed = nil
				Space.Refresh()
			end
		end)
	end
	Space.Refresh()
	return "armed"
end

local function collecting()
	local view, raw = QoL.CurrentStep()
	if not (view and raw) then return false end
	for g, gv in ipairs(view.goals) do
		local goal = raw[g]
		if goal and goal.t == "collect" and QoL.Open(gv) then return true end
	end
	return false
end

-- The guide window's banner: { free, junk, armed } while the bags are low and
-- the live step collects something; nil otherwise or once dismissed (until
-- the bags have room again).
function Space.Banner()
	if dismissed or not Space.Low() or not collecting() then return nil end
	return { free = free, junk = junk, armed = Space.Armed() }
end

function Space.Dismiss()
	dismissed = true
	Space.Refresh()
end

ns.OnLogin(Space.Refresh)
ns.RegisterEvent("BAG_UPDATE_DELAYED", refreshSoon)
ns.On("ITEM_MARKS", refreshSoon)
ns.On("SETTING_CHANGED", function(path)
	if path == "" or path == "qol" or path == "qol.bagSpace" or path == "qol.bagsLow" then refreshSoon() end
end)

-- /polestar bags: the free slots and the cheapest junk, in chat.
if ns.RegisterCommand then
	ns.RegisterCommand("bags", function()
		local f, t = Space.Count()
		ns.Print(format(L["Free slots: %d of %d"], f, t))
		local j = Space.Cheapest()
		if j then
			ns.Print(format(L["Cheapest junk: %s (%s)"], itemText(j), j.value < huge and QoL.Money(j.value) or "?"))
		end
	end, L["Free bag slots and the cheapest junk"])
end
