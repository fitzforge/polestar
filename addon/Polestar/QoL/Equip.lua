-- Quest rewards worth wearing: what a turn-in gives (the reward picked, by
-- hand, by auto-pick or by quest automation, and the items every turn-in
-- gives) is put on once it reaches the bags, when Polestar.Gear calls it an
-- upgrade (qol.rewardEquip, default off; Shift at the turn-in skips). Never in
-- combat: wearing waits for combat to end. Only a new copy of what that
-- turn-in gave counts (the bag count must rise within WAIT seconds). Rewards
-- go on one at a time, each in the slot Gear.CompareToEquipped names (the
-- weaker ring or trinket) against what is worn once the last one is on.
-- Quest rewards bind when picked up, so wearing one asks nothing; an item
-- that would bind when worn brings up the client's own confirmation, which is
-- left to you.
--
-- Client: GetQuestReward (post-hooked), GetQuestItemLink, GetNumQuestRewards
-- (Mainline QuestInfo.lua); C_Item.EquipItemByName (ItemDocumentation);
-- BAG_UPDATE_DELAYED (ContainerDocumentation); PLAYER_EQUIPMENT_CHANGED
-- (PaperDollInfoDocumentation).

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local Client = QoL.Client

local format, tremove = string.format, table.remove

local Equip = {}
QoL.Equip = Equip

local WAIT = 10 -- seconds a reward may take to reach the bags, or to go on
local MAIN, OFF = 16, 17 -- hand slots
local TWO_HANDER = 17 -- INVTYPE_2HWEAPON
local HAND = { [13] = MAIN, [21] = MAIN, [14] = OFF, [22] = OFF, [23] = OFF } -- one-hand and off-hand pieces

local expected = {} -- { link, id, before, at }: given by a turn-in, not arrived yet
local landed = {}   -- { link }: arrived, waiting to be worn
local waiting       -- { id, slot, link, pct }: the reward last put on, until it is on (or WAIT passes)

local function itemID(link) return link and tonumber(link:match("item:(%d+)")) end

local function gear()
	local G = ns.Gear
	if not (G and G.IsUpgrade) then return nil end
	if G.IsEnabled and not G.IsEnabled() then return nil end
	return G
end

-- Right after GetQuestReward, while the reward panel still holds this
-- quest's items (whoever turned it in, and however soon after QUEST_COMPLETE):
-- the reward taken and the ones every turn-in gives, each with how many the
-- bags held before, so only a new copy counts as arrived.
local function onReward(choice)
	if not QoL.On("rewardEquip") or QoL.Shift() then return end
	local now = GetTime()
	local function add(kind, i)
		local link = GetQuestItemLink(kind, i)
		local id = itemID(link)
		if not id then return end
		for _, e in ipairs(expected) do
			if e.id == id then return end
		end
		expected[#expected + 1] = { link = link, id = id, before = Client.ItemCount(id), at = now }
	end
	if choice and choice > 0 then add("choice", choice) end
	for i = 1, (GetNumQuestRewards and GetNumQuestRewards() or 0) do add("reward", i) end
end

-- Where a reward goes and how much better it is, or nil to leave it. With a
-- two-hander worn, Gear weighs a one-hand or off-hand reward together with
-- the best partner in the bags, but only the reward goes on: it must beat the
-- two-hander by itself, and a weapon that fits the main hand goes there. An
-- off-hand piece (shield, off-hand weapon, held item) stays in the bags: on
-- its own it would take the two-hander off and leave the main hand empty.
local function placement(G, link)
	local up, _, pct = G.IsUpgrade(link)
	if not up then return nil end
	local r = G.CompareToEquipped(link)
	local mainLink = G.Client.InventoryLink(MAIN)
	local main, info = mainLink and G.GetItemInfo(mainLink), G.GetItemInfo(link)
	if not (main and main.inv == TWO_HANDER and info and HAND[info.inv]) then return r and r.slot, pct end
	if HAND[info.inv] == OFF then return nil end
	local gain = r.score - r.old
	pct = r.old > 0 and gain / r.old * 100 or nil
	if gain <= 0 or (pct and pct < (tonumber(ns.Get("gear.minUpgrade")) or 0)) then return nil end
	return HAND[info.inv], pct
end

-- Shared with the loot and merchant offers (QoL/Wear.lua).
Equip.Placement = placement

-- A turn-in's item this module is about to put on (or waits to see on):
-- the offers leave it alone.
function Equip.Pending(id)
	if waiting and waiting.id == id then return true end
	for _, e in ipairs(expected) do
		if e.id == id then return true end
	end
	for _, link in ipairs(landed) do
		if itemID(link) == id then return true end
	end
	return false
end

-- One reward at a time: the next is scored once the last is on
-- (PLAYER_EQUIPMENT_CHANGED), so a second ring takes the other finger only
-- when it beats the ring there, which may be the first reward's finger if
-- that is now the weaker. One that never goes on (its bind confirmation
-- cancelled) holds up the rest for WAIT seconds and is never announced.
local function wear()
	local G = QoL.On("rewardEquip") and gear()
	while G and C_Item and C_Item.EquipItemByName and #landed > 0 do
		local link = tremove(landed, 1)
		local slot, pct = placement(G, link)
		if slot then
			local this = { id = itemID(link), slot = slot, link = link, pct = pct }
			waiting = this
			C_Item.EquipItemByName(link, slot)
			ns.After(WAIT, function()
				if waiting == this then waiting = nil; QoL.Secure("rewardEquip", wear) end
			end)
			return
		end
	end
	wipe(landed)
end

local function onBags()
	if #expected == 0 then return end
	local now, keep = GetTime(), {}
	for _, e in ipairs(expected) do
		if now - e.at <= WAIT then
			if Client.ItemCount(e.id) > e.before then
				landed[#landed + 1] = e.link
			else
				keep[#keep + 1] = e
			end
		end
	end
	expected = keep
	if #landed > 0 and not waiting then QoL.Secure("rewardEquip", wear) end
end

-- Only the pending reward reaching its slot is announced and moves on to the
-- next one.
local function onEquipment()
	local G = ns.Gear
	if not (waiting and G and itemID(G.Client.InventoryLink(waiting.slot)) == waiting.id) then return end
	local done = waiting
	waiting = nil
	local gain = done.pct and G.GainText and (G.GainText(done.pct))
	ns.Print(gain and format(L["Wearing %s (%s)."], done.link, gain) or format(L["Wearing %s."], done.link))
	if #landed > 0 then QoL.Secure("rewardEquip", wear) end
end

if hooksecurefunc and GetQuestReward then hooksecurefunc("GetQuestReward", onReward) end
ns.RegisterEvent("BAG_UPDATE_DELAYED", onBags)
ns.RegisterEvent("PLAYER_EQUIPMENT_CHANGED", onEquipment)
