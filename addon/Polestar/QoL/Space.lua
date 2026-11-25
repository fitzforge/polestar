-- Bag space (qol.bagSpace, on by default): how many bag slots are free, and
-- a way to make room. Only bags that take any item count, not quivers, ammo
-- pouches, soul or profession bags, or the reagent bag. At qol.bagsLow free
-- slots or fewer:
--   * the bag button (QoL/Buttons.lua, bindable) comes up, showing the free
--     slots and the cheapest junk in all the bags, the reagent bag too: a
--     grey item, or one marked as junk (QoL/Marks.lua) of common quality or
--     below; never one marked to keep, one a later step needs, or a quest's
--     item or one that begins a quest (Client.SlotQuest). Its worth
--     is what a merchant pays for the stack (Client.SlotSellPrice: less for a
--     damaged item, #3997; an item without a price is worth
--     nothing; one whose price the client
--     has not loaded yet goes last).
--   * while the live step has an open collect goal, the guide window's
--     banner says so and offers the same delete (Space.Banner).
--   * a spare bag comes first (qol.spareBag, off by default; #2369): when a
--     bag that takes any item sits in the bags while a bag slot is empty, the
--     button and the banner offer to equip it instead, on one press (nothing
--     is lost), and offer a delete only once there is no bag to equip.
-- Deleting takes two presses of the button, its binding or the banner's
-- link: the first arms that item for ARM seconds, the second deletes it
-- once the slot is read again and still holds it (an item moved or swapped
-- in between is left alone, and the next press arms afresh). Nothing is
-- ever deleted any other way.
--
-- Fires BAG_SPACE when the free count, the spare bag, the cheapest junk or
-- the armed item changes.
--
-- Client: C_Container.GetContainerNumFreeSlots (bagFamily 0: any item),
-- GetContainerItemInfo, PickupContainerItem; CursorHasItem, DeleteCursorItem;
-- ContainerIDToInventoryID and PutItemInBag to equip a bag
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
local spare        -- { bag, slot, id, link, into }: a bag to equip, or nil
local armed        -- { bag, slot, id, at }
local dismissed = false
local sig

-- Free and total slots of the bags that take any item (not the reagent bag).
function Space.Count()
	local f, t = 0, 0
	for bag = 0, Client.NumBags() do
		local n, family = Client.FreeSlots(bag)
		if (not family or family == 0) and not Client.IsReagentBag(bag) then
			f = f + n
			t = t + Client.NumSlots(bag)
		end
	end
	return f, t
end

local function candidate(info, bag, slot)
	if not info or info.isLocked or not info.itemID then return false end
	local Marks = QoL.Marks
	if Marks.Protected(info.itemID) then return false end
	if Client.SlotQuest(bag, slot) then return false end -- a quest's item or a quest starter (#1557)
	if info.quality == Client.QUALITY_POOR then return true end
	return Marks.Junk(info.itemID) and info.quality ~= nil and info.quality <= Client.QUALITY_COMMON
end

-- The cheapest junk in the bags: { bag, slot, id, count, value, link } or nil.
function Space.Cheapest()
	local best, bestValue
	for bag = 0, Client.NumBags() do
		for slot = 1, Client.NumSlots(bag) do
			local info = Client.SlotInfo(bag, slot)
			if candidate(info, bag, slot) then
				local count = info.stackCount or 1
				local value
				if info.hasNoValue then
					value = 0
				else
					local price = Client.SlotSellPrice(bag, slot, info.itemID, count)
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

local CLASS_CONTAINER, SUBCLASS_BAG = 1, 0 -- Enum.ItemClass.Container, a bag that takes any item

-- A bag that takes any item, sitting in the bags while a regular bag slot is
-- empty: { bag, slot, id, link, into } (into: the empty bag slot) or nil.
function Space.SpareBag()
	local into
	for bag = 1, Client.NumBags() do
		if Client.BagSlotEmpty(bag) then
			into = bag
			break
		end
	end
	if not into then return nil end
	for bag = 0, Client.NumBags() do
		for slot = 1, Client.NumSlots(bag) do
			local info = Client.SlotInfo(bag, slot)
			if info and info.itemID and not info.isLocked and not Client.SlotQuest(bag, slot) then
				local class, subclass = Client.ItemKind(info.itemID)
				if class == CLASS_CONTAINER and subclass == SUBCLASS_BAG then
					return { bag = bag, slot = slot, id = info.itemID, link = info.hyperlink, into = into }
				end
			end
		end
	end
	return nil
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
function Space.Spare() return spare end

-- The armed item is the cheapest junk still.
function Space.Armed()
	return armed ~= nil and junk ~= nil and armed.bag == junk.bag and armed.slot == junk.slot and armed.id == junk.id
end

local function signature()
	local j, b = junk, spare
	return free .. ":" .. total .. ":" .. (j and (j.bag .. "/" .. j.slot .. "/" .. j.id .. "/" .. j.count) or "-")
		.. ":" .. (b and (b.bag .. "/" .. b.slot .. "/" .. b.id .. ">" .. b.into) or "-")
		.. ":" .. (Space.Armed() and "armed" or "") .. ":" .. (Space.Low() and "low" or "") .. ":" .. (dismissed and "d" or "")
end

-- Reads the bags again; fires BAG_SPACE when something shown changed.
function Space.Refresh()
	free, total = Space.Count()
	spare = Space.Low() and QoL.On("spareBag") and Space.SpareBag() or nil
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

-- The one press: equip a spare bag when there is one; else arm the cheapest
-- junk, or delete it when it is armed already. -> "equipped", "armed",
-- "deleted", "none" (nothing to equip or delete), "busy" (the cursor holds
-- something, or the bag did not go in) or "off".
function Space.Press()
	if not QoL.On("bagSpace") then return "off" end
	Space.Refresh()
	local b = spare
	if b then
		armed = nil
		local info = Client.SlotInfo(b.bag, b.slot)
		local result = "busy"
		if info and info.itemID == b.id and Client.BagSlotEmpty(b.into) and Client.EquipBag(b.bag, b.slot, b.into) then
			ns.Print(format(L["Equipped %s."], b.link or (L["Item"] .. " " .. b.id)))
			result = "equipped"
		end
		Space.Refresh()
		return result
	end
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
		if info and info.itemID == j.id and candidate(info, j.bag, j.slot) and Client.DeleteSlot(j.bag, j.slot) then
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

-- The guide window's banner: { free, spare, junk, armed } while the bags are low and
-- the live step collects something; nil otherwise or once dismissed (until
-- the bags have room again).
function Space.Banner()
	if dismissed or not Space.Low() or not collecting() then return nil end
	return { free = free, spare = spare, junk = junk, armed = Space.Armed() }
end

function Space.Dismiss()
	dismissed = true
	Space.Refresh()
end

ns.OnLogin(Space.Refresh)
ns.RegisterEvent("BAG_UPDATE_DELAYED", refreshSoon)
ns.On("ITEM_MARKS", refreshSoon)
ns.On("SETTING_CHANGED", function(path)
	if path == "" or path == "qol" or path == "qol.bagSpace" or path == "qol.bagsLow" or path == "qol.spareBag" then refreshSoon() end
end)

-- /polestar bags: the free slots and the cheapest junk, in chat.
if ns.RegisterCommand then
	ns.RegisterCommand("bags", function()
		local f, t = Space.Count()
		ns.Print(format(L["Free slots: %d of %d"], f, t))
		local b = QoL.On("spareBag") and Space.SpareBag()
		if b then ns.Print(format(L["Spare bag: %s"], b.link or (L["Item"] .. " " .. b.id))) end
		local j = Space.Cheapest()
		if j then
			ns.Print(format(L["Cheapest junk: %s (%s)"], itemText(j), j.value < huge and QoL.Money(j.value) or "?"))
		end
	end, L["Free bag slots and the cheapest junk"], true)
end
