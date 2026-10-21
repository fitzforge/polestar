-- At a vendor, when an item a quest still needs leaves your bags, ask whether
-- to buy it back (qol.questSellWarning): "You sold [Murloc Eye], which
-- Stocking Jetsteam still needs. Buy it back for 3c?" Yes buys it back from
-- the merchant's buyback list, which costs what the sale paid.
--
-- The sale itself is the game's and cannot be stopped from an addon without
-- replacing a secure function, so this reacts to it: the bags are counted for
-- quest items (QuestDB.IsItemNeeded) when the merchant opens and again after
-- each BAG_UPDATE_DELAYED, and a drop that matches an entry in the buyback
-- list raises the question. Nothing is bought without the player pressing
-- Yes (the buyback runs from the dialog's accept, a click).
--
-- Client: GetNumBuybackItems, GetBuybackItemInfo, GetBuybackItemLink,
-- BuybackItem, GetMoney; C_Container.GetContainerItemInfo.

local ADDON, ns = ...

local Q = ns.QuestDB
local L = ns.L

local type, pairs, tonumber = type, pairs, tonumber

local WHICH = "POLESTAR_QUEST_BUYBACK"
local DELAY = 0.3 -- seconds: the buyback list follows the bag update

local open = false
local snap -- itemID -> count in the bags, for items a quest needs

local function isOn()
	return Q.IsRunning() and ns.Get("qol.questSellWarning") and true or false
end

-- QoL loads after Quests, so its client helpers are looked up on use.
local function counts()
	local out = {}
	local Client = ns.QoL and ns.QoL.Client
	if not Client then return out end
	for bag = 0, Client.NumBags() do
		for slot = 1, Client.NumSlots(bag) do
			local info = Client.SlotInfo(bag, slot)
			local id = type(info) == "table" and info.itemID
			if id and Q.IsItemNeeded(id) then out[id] = (out[id] or 0) + (info.stackCount or 1) end
		end
	end
	return out
end

local function itemIDOf(link)
	return type(link) == "string" and tonumber(link:match("item:(%d+)")) or nil
end

-- Newest first: the buyback entry for itemID, as index, link, price.
local function buybackFor(itemID)
	if not (GetNumBuybackItems and GetBuybackItemLink and GetBuybackItemInfo) then return nil end
	for i = GetNumBuybackItems() or 0, 1, -1 do
		local link = GetBuybackItemLink(i)
		if itemIDOf(link) == itemID then
			local _, _, price = GetBuybackItemInfo(i)
			return i, link, tonumber(price) or 0
		end
	end
	return nil
end

local function coins(copper)
	if GetCoinTextureString then return GetCoinTextureString(copper) end
	return copper .. "c"
end

local function buyBack(itemID)
	local i, _, price = buybackFor(itemID)
	if not i then
		ns.Print(L["It is no longer in the vendor's buyback list."])
	elseif (GetMoney() or 0) < price then
		ns.Print(L["Not enough money to buy it back."])
	elseif BuybackItem then
		BuybackItem(i)
	end
end

local function ask(itemID)
	if not (StaticPopupDialogs and StaticPopup_Show and open) then return end
	local i, link, price = buybackFor(itemID)
	if not i then return end
	local titles = Q.ItemNeededTitles and Q.ItemNeededTitles(itemID) or {}
	if #titles == 0 then return end
	StaticPopupDialogs[WHICH] = StaticPopupDialogs[WHICH] or {
		text = "%s",
		button1 = YES,
		button2 = NO,
		OnAccept = function(_, data) buyBack(data) end,
		timeout = 0,
		whileDead = false,
		hideOnEscape = true,
		preferredIndex = 3,
	}
	StaticPopup_Show(WHICH, L["You sold %s, which %s still needs. Buy it back for %s?"]:format(link, table.concat(titles, ", "), coins(price)), nil, itemID)
end

local function check()
	if not (open and snap and isOn()) then return end
	local now = counts()
	local before = snap
	snap = now
	for id, n in pairs(before) do
		if (now[id] or 0) < n then
			ask(id)
			return
		end
	end
end

local pending = false
local function schedule()
	if pending or not (open and snap) then return end
	pending = true
	local function run()
		pending = false
		ns.SafeCall(check)
	end
	if C_Timer and C_Timer.After then C_Timer.After(DELAY, run) else run() end
end

local function onShow()
	open = true
	snap = isOn() and counts() or nil
end

local function onClosed()
	open, snap, pending = false, nil, false
	if StaticPopup_Hide then StaticPopup_Hide(WHICH) end
end

ns.RegisterEvent("MERCHANT_SHOW", onShow)
ns.RegisterEvent("MERCHANT_CLOSED", onClosed)
ns.RegisterEvent("BAG_UPDATE_DELAYED", schedule)

-- For tests.
Q.CheckSold = check
Q.SellWarningOpen = function(v) open = v; snap = v and counts() or nil end
