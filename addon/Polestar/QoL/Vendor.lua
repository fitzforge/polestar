-- Merchant: sell grey items and repair, when a merchant opens, then buy
-- what the step needs (QoL/Buy.lua). Holding Shift skips all three. Selling
-- goes a few slots per tick (the server throttles bursts)
-- and re-reads every slot right before selling it, so an item moved or
-- swapped in the meantime is never sold: only Poor-quality items with a
-- vendor price ever are, and the items the player marked as junk
-- (QoL/Marks.lua), of any quality; never one marked to keep or one the
-- guide keeps for a later step (QoL.Kept, QoL/Keep.lua). Repair runs after
-- the selling (the sale pays for it);
-- with qol.repairGuild and a rank that may (CanGuildBankRepair), it repairs the
-- way the merchant's guild repair button does: RepairAllItems(true), the
-- server paying from the guild bank what the allowance covers and the rest
-- from your money. The client cannot tell beforehand how much the bank will
-- pay (its balance reads 0 until the guild bank is opened), so there is no
-- affordability check on that path, as on Blizzard's button.
--
-- Client: C_Container.GetContainerItemInfo / UseContainerItem (Forever API
-- docs); CanMerchantRepair, GetRepairAllCost, RepairAllItems, GetMoney,
-- CanGuildBankRepair (Mainline MerchantFrame.lua / .xml, GameDialogDefs.lua).

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local Client = QoL.Client

local format = string.format

local Vendor = {}
QoL.Vendor = Vendor

local PER_TICK = 6
local INTERVAL = 0.2

local open = false
local queue = {}          -- { bag, slot, itemID, ... } flattened triples
local qi, qn = 1, 0
local sold, earned = 0, 0
local ticker

-- A slot holding a grey item, or one marked as junk, worth money that no
-- keep mark or later step protects (Marks.Protected covers QoL.Kept): itemID,
-- stack count, price per item.
local function junkAt(bag, slot)
	local info = Client.SlotInfo(bag, slot)
	if not info or info.isLocked or info.hasNoValue then return nil end
	local id = info.itemID
	if not id then return nil end
	local Marks = QoL.Marks
	if Marks.Protected(id) then return nil end
	if info.quality ~= Client.QUALITY_POOR and not Marks.Junk(id) then return nil end
	local price = Client.SellPrice(id)
	if not price or price <= 0 then return nil end
	return id, info.stackCount or 1, price
end
Vendor.JunkAt = junkAt

local function stop()
	if ticker then
		ticker:Cancel()
		ticker = nil
	end
end

-- How to pay `cost`: "guild" (guild bank first, then your money), "own", or
-- nil when your money does not cover it. guild: the guild bank may be used.
function Vendor.RepairPlan(cost, money, guild)
	if guild then return "guild" end
	if money >= cost then return "own" end
	return nil
end

local function repair()
	if not (QoL.On("autoRepair") and CanMerchantRepair and CanMerchantRepair()) then return end
	if not (GetRepairAllCost and RepairAllItems) then return end
	local cost, canRepair = GetRepairAllCost()
	if not canRepair or not cost or cost <= 0 then return end
	local guild = QoL.On("repairGuild") and CanGuildBankRepair and CanGuildBankRepair() and true or false
	local plan = Vendor.RepairPlan(cost, Client.Money(), guild)
	if not plan then
		ns.Print(format(L["Not enough money to repair (%s)."], QoL.Money(cost)))
		return
	end
	RepairAllItems(plan == "guild")
	ns.Print(format(plan == "guild" and L["Repaired for %s, guild bank first."] or L["Repaired for %s."], QoL.Money(cost)))
end

local function finish()
	stop()
	if sold > 0 then
		ns.Print(format(sold == 1 and L["Sold %d grey item for %s."] or L["Sold %d grey items for %s."], sold, QoL.Money(earned)))
	end
	sold, earned = 0, 0
	qi, qn = 1, 0
	if open then
		repair()
		QoL.Buy.Run()
	end
end

local function step()
	if not open then
		stop()
		return
	end
	local done = 0
	while qi <= qn and done < PER_TICK do
		local bag, slot, want = queue[qi], queue[qi + 1], queue[qi + 2]
		qi = qi + 3
		local id, count, price = junkAt(bag, slot)
		if id and id == want then
			Client.UseSlot(bag, slot)
			sold = sold + count
			earned = earned + count * price
			done = done + 1
		end
	end
	if qi > qn then finish() end
end

function Vendor.OnMerchantShow()
	open = true
	if QoL.Shift() then return end
	sold, earned, qi, qn = 0, 0, 1, 0
	if QoL.On("sellJunk") then
		for bag = 0, Client.NumBags() do
			for slot = 1, Client.NumSlots(bag) do
				local id = junkAt(bag, slot)
				if id then
					queue[qn + 1], queue[qn + 2], queue[qn + 3] = bag, slot, id
					qn = qn + 3
				end
			end
		end
	end
	if qn == 0 then
		repair()
		QoL.Buy.Run()
		return
	end
	step()
	if qi <= qn and C_Timer and C_Timer.NewTicker then
		stop()
		ticker = ns.NewTicker(INTERVAL, step)
	end
end

function Vendor.OnMerchantClosed()
	open = false
	if qn > 0 and sold > 0 then finish() else stop() end
	qi, qn = 1, 0
end

ns.RegisterEvent("MERCHANT_SHOW", Vendor.OnMerchantShow)
ns.RegisterEvent("MERCHANT_CLOSED", Vendor.OnMerchantClosed)
