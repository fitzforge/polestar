-- Merchant: buy what the current step's buy goals still need (qol.buyGoals,
-- default off), from a merchant that sells it for money. Runs after selling
-- and repairing (QoL/Vendor.lua calls Buy.Run), so the sale pays for it, and
-- Shift skips it with them. What is still needed is the goal's count less
-- what the bags hold and what is still on its way from an earlier purchase
-- (opening the merchant again before it lands buys nothing twice). Goods sold
-- in stacks are bought in whole stacks, each call within the merchant's stack
-- limit, and limited stock and your money cap the rest. The client's source
-- does not say whether stock counts items or purchases; it is read as items
-- rounded down to whole purchases, at least one while any is left. Goods for
-- other currencies or items are left alone, and so are optional goals and a
-- goal that would cost over MAX_SPEND, or take one visit's buying over it
-- (it says so). Only Polestar's own guides spend your money: a community or
-- imported guide's buy goals are named with their cost for you to buy (its
-- author is a stranger). Prints what was bought
-- once it lands in the bags (a refused purchase never is), and what money
-- was short for.
--
-- Client: GetMerchantNumItems, GetMerchantItemID, C_MerchantFrame.GetItemInfo
-- (else GetMerchantItemInfo), GetMerchantItemMaxStack, BuyMerchantItem (Forever Vanilla MerchantFrame.lua:
-- a split buys whole stacks, BuyMerchantItem(index, items)).

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local Client = QoL.Client

local format, ceil, floor, min, max = string.format, math.ceil, math.floor, math.min, math.max

local Buy = {}
QoL.Buy = Buy

local LAND_WAIT = 1
local PENDING_WAIT = 5    -- a purchase not landed by then was refused
-- A goal that would cost more is left to you: the required mounts (200g).
-- The dearest other buy goal in the guides is a profession's thread, ~24g.
local MAX_SPEND = 500000  -- 50g

local pending = {}        -- itemID -> { before, items, at }: bought, not landed

-- Items of `id` bought and not in the bags yet.
local function onTheWay(id)
	local p = pending[id]
	if not p then return 0 end
	local left = p.before + p.items - Client.ItemCount(id)
	if left <= 0 or GetTime() - p.at > PENDING_WAIT then
		pending[id] = nil
		return 0
	end
	return left
end

-- Whether the current guide is one of Polestar's own (the official pack,
-- Core/Guides.lua): only those buy by themselves.
local function ownGuide()
	local E, G = ns.Engine, ns.Guides
	local guide = E and E.GetGuide and E.GetGuide()
	local pack = guide and G and G.Pack and G.Pack(guide.pack)
	return type(pack) == "table" and pack.official == true
end

-- itemID -> { count, name }: the most any open buy goal of the step asks for.
local function wanted()
	local view, raw = QoL.CurrentStep()
	if not (view and raw) then return nil end
	local out
	for g, gv in ipairs(view.goals) do
		local goal = raw[g]
		if goal and goal.t == "buy" and goal.item and not goal.optional and QoL.Open(gv) then
			out = out or {}
			local w = out[goal.item]
			local count = goal.count or 1
			if not w or count > w.count then out[goal.item] = { count = count, name = goal.itemName } end
		end
	end
	return out
end

-- What to buy for `need` items sold `perStack` to a purchase at `price`:
-- whole purchases, within stock (`numAvailable`, -1 unlimited) and `money`.
-- Returns items and their cost, then the items money did not cover and
-- their cost (0, 0 when it did).
function Buy.Plan(need, price, perStack, numAvailable, money)
	local stacks = ceil(need / perStack)
	if numAvailable and numAvailable >= 0 then
		stacks = min(stacks, numAvailable > 0 and max(1, floor(numAvailable / perStack)) or 0)
	end
	local afford = floor(money / price)
	local short = stacks > afford and stacks - afford or 0
	stacks = stacks - short
	return stacks * perStack, stacks * price, short * perStack, short * price
end

-- name, price, perStack, numAvailable, hasExtendedCost of merchant slot i:
-- C_MerchantFrame.GetItemInfo (MerchantItemInfo) where the client has it,
-- as retail does since 11.0.5 and Forever does; GetMerchantItemInfo is
-- the fallback for a client without it.
local function itemInfo(i)
	local M = C_MerchantFrame
	if M and M.GetItemInfo then
		local info = M.GetItemInfo(i)
		if not info then return nil end
		return info.name, info.price, info.stackCount, info.numAvailable, info.hasExtendedCost
	end
	local name, _, price, perStack, numAvailable, _, _, extendedCost = GetMerchantItemInfo(i)
	return name, price, perStack, numAvailable, extendedCost
end

function Buy.Run()
	if not QoL.On("buyGoals") then return end
	local want = wanted()
	if not want then return end
	local own = ownGuide()
	local money = Client.Money()
	local spent = 0
	for i = 1, GetMerchantNumItems() do
		local id = GetMerchantItemID(i)
		local w = id and want[id]
		if w then
			want[id] = nil
			local name, price, perStack, numAvailable, extendedCost = itemInfo(i)
			name = w.name or name or ("item " .. id)
			local need = w.count - Client.ItemCount(id) - onTheWay(id)
			if need > 0 and not extendedCost and (price or 0) > 0 then
				perStack = (perStack and perStack > 0) and perStack or 1
				local items, cost, shortItems, shortCost = Buy.Plan(need, price, perStack, numAvailable, money)
				-- The whole goal, not only what this visit's stock covers:
				-- a merchant with fewer in stock must not split a dear goal.
				local goalCost = ceil(need / perStack) * price
				-- And the whole visit: several dear goals at one merchant
				-- (a guide pack may list them) stop at the same cap. A
				-- guide not Polestar's own buys nothing: it says what to buy.
				if not own or goalCost > MAX_SPEND or spent + cost > MAX_SPEND then
					ns.Print(format(L["Left %d %s (%s) for you to buy."], need, name, QoL.Money(goalCost)))
					items, shortItems = 0, 0
				end
				if shortItems > 0 then
					ns.Print(format(L["Not enough money to buy %d %s (%s)."], shortItems, name, QoL.Money(shortCost)))
				end
				if items > 0 then
					local maxStack = GetMerchantItemMaxStack(i) or perStack
					local per = maxStack >= perStack and (maxStack - maxStack % perStack) or perStack
					local left = items
					while left > 0 do
						local n = min(left, per)
						BuyMerchantItem(i, n)
						left = left - n
					end
					money = money - cost
					spent = spent + cost
					-- One record per item while purchases are on their way: a
					-- later one adds to it, and each landing reports only the
					-- items not reported yet, so none is counted twice and a
					-- refused purchase is never reported.
					local p = onTheWay(id) > 0 and pending[id]
					if p then
						p.items, p.at = p.items + items, GetTime()
					else
						p = { before = Client.ItemCount(id), items = items, at = GetTime(), reported = 0 }
						pending[id] = p
					end
					if C_Timer and C_Timer.After then
						local function report()
							local got = min(Client.ItemCount(id) - p.before, p.items) - p.reported
							if got > 0 then
								p.reported = p.reported + got
								ns.Print(format(L["Bought %d %s for %s."], got, name, QoL.Money(got * price / perStack)))
							end
							-- Some not landed yet: look again while they still may.
							if p.reported < p.items and GetTime() - p.at < PENDING_WAIT then
								C_Timer.After(LAND_WAIT, report)
							end
						end
						C_Timer.After(LAND_WAIT, report)
					end
				end
			end
		end
	end
end
