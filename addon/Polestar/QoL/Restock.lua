-- Restock (qol.restock, on by default): drinks, food, ammunition and any
-- other item (reagents, say) topped up to amounts the player sets for this
-- character, at any merchant that sells them, on a press of the Restock
-- button under the merchant window. Nothing is bought without that press.
--
-- The amounts: Drinks, Food and Ammunition on the options page (Quality of
-- Life > Vendors > Restock), and any item with `/polestar restock <item>
-- <amount>` (0 forgets it). Drinks, food and ammunition go by kind, so they
-- keep up with your level: everything of that kind in the bags counts
-- towards the amount, and the merchant's best one you can use now is bought
-- (the highest level, then the dearest).
--   drink: a consumable whose use is the spell named like spell 430 (the
--     client's "Drink"; Refreshing Spring Water's, item 159);
--   food: likewise spell 433 ("Food"; Tough Hunk of Bread's, item 4540)
--     (cmangos classicdb item_template spellid_1);
--   ammunition: arrows for a bow or crossbow worn, shot for a gun
--     (Projectile class 6, subclass 2 and 3 there); nothing without one.
-- What is still on its way from an earlier purchase counts (QoL/Buy.lua), a
-- press spends at most Buy.MAX_SPEND, money short is said, and goods for
-- other currencies or items are left alone.
--
-- Client: GetMerchantNumItems, GetMerchantItemID, C_MerchantFrame.GetItemInfo
-- (isUsable), C_Item.GetItemSpell, C_Spell.GetSpellName, GetInventoryItemID;
-- MERCHANT_SHOW, MERCHANT_UPDATE, MERCHANT_CLOSED.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local Client = QoL.Client

local type, pairs, ipairs, tonumber, format = type, pairs, ipairs, tonumber, string.format
local floor, max = math.floor, math.max

local Restock = {}
QoL.Restock = Restock

local DRINK_SPELL, FOOD_SPELL = 430, 433
local ARROW, BULLET = 2, 3
-- The ranged weapons that shoot (ItemWeaponSubclass): bows and crossbows
-- take arrows, guns take shot.
local SHOOTS = { [2] = ARROW, [18] = ARROW, [3] = BULLET }
local KINDS = { "drink", "food", "ammo" }
-- The options page's slider ends: five stacks of drinks or food, ten of arrows.
Restock.LIMITS = { drink = 100, food = 100, ammo = 2000 }

local open = false
local button

-- Per-character amounts: { drink, food, ammo, items = { [itemID] = n } }.
local function amounts()
	local s = QoL.State()
	local r = s.restock
	if type(r) ~= "table" then
		r = {}
		s.restock = r
	end
	if type(r.items) ~= "table" then r.items = {} end
	return r
end

function Restock.Get(kind)
	return tonumber(amounts()[kind]) or 0
end

-- kind: "drink", "food" or "ammo"; nil or 0 clears it.
function Restock.Set(kind, n)
	n = tonumber(n)
	amounts()[kind] = n and n > 0 and floor(n) or nil
	ns.Fire("RESTOCK_CHANGED")
end

function Restock.GetItem(id) return tonumber(amounts().items[id]) or 0 end

function Restock.SetItem(id, n)
	n = tonumber(n)
	amounts().items[id] = n and n > 0 and floor(n) or nil
	ns.Fire("RESTOCK_CHANGED")
end

function Restock.Items() return amounts().items end

-- The ammunition subclass the worn ranged weapon shoots, or nil.
local function ammoType()
	local id = Client.WornID(Client.RANGED_SLOT)
	if not id then return nil end
	local classID, subclassID = Client.ItemKind(id)
	if classID ~= 2 then return nil end -- Enum.ItemClass.Weapon
	return SHOOTS[subclassID]
end

-- Which kind an item is ("drink", "food", "ammo") or nil. ammo: the kind
-- the worn weapon shoots only.
function Restock.KindOf(id, shoots)
	local classID, subclassID = Client.ItemKind(id)
	if classID == Client.CLASS_PROJECTILE then
		return shoots ~= nil and subclassID == shoots and "ammo" or nil
	end
	if classID ~= 0 then return nil end -- Enum.ItemClass.Consumable
	local spell = Client.ItemSpell(id)
	if not spell then return nil end
	if spell == Client.SpellName(DRINK_SPELL) then return "drink" end
	if spell == Client.SpellName(FOOD_SPELL) then return "food" end
	return nil
end

-- kind -> count in the bags.
local function have(shoots)
	local out = { drink = 0, food = 0, ammo = 0 }
	for bag = 0, Client.NumBags() do
		for slot = 1, Client.NumSlots(bag) do
			local info = Client.SlotInfo(bag, slot)
			local kind = info and info.itemID and Restock.KindOf(info.itemID, shoots)
			if kind then out[kind] = out[kind] + (info.stackCount or 1) end
		end
	end
	return out
end

local function usable(i)
	local M = C_MerchantFrame
	if M and M.GetItemInfo then
		local info = M.GetItemInfo(i)
		return not info or info.isUsable ~= false
	end
	return true
end

-- What a press buys here: a list of { i, id, name, need, items, cost,
-- price, perStack } in merchant order, then the ones left: { name, need,
-- cost, why = "money" | "cap" }. Empty lists when nothing is short.
function Restock.Plan()
	local buy, left = {}, {}
	if not QoL.On("restock") then return buy, left end
	local shoots = ammoType()
	local targets = {}
	for _, kind in ipairs(KINDS) do targets[kind] = Restock.Get(kind) end
	local items = amounts().items
	local best = {} -- kind -> { i, id, level, price }
	local level = (UnitLevel and UnitLevel("player")) or 1
	local wantItem = {}
	for i = 1, (GetMerchantNumItems and GetMerchantNumItems() or 0) do
		local id = GetMerchantItemID(i)
		if id then
			local _, price, _, _, extendedCost = QoL.Buy.ItemInfo(i)
			if not extendedCost and (price or 0) > 0 and usable(i) then
				if (tonumber(items[id]) or 0) > 0 and not wantItem[id] then wantItem[id] = i end
				local kind = Restock.KindOf(id, shoots)
				if kind and targets[kind] > 0 then
					local lvl = Client.ItemMinLevel(id) or 0
					local b = best[kind]
					if lvl <= level and (not b or lvl > b.level or (lvl == b.level and price > b.price)) then
						best[kind] = { i = i, id = id, level = lvl, price = price }
					end
				end
			end
		end
	end
	local need = {} -- merchant index -> items needed
	local bags = have(shoots)
	local Buy = QoL.Buy
	for _, kind in ipairs(KINDS) do
		local b = best[kind]
		if b then
			local n = targets[kind] - bags[kind] - Buy.OnTheWay(b.id)
			if n > 0 then need[b.i] = (need[b.i] or 0) + n end
		end
	end
	for id, i in pairs(wantItem) do
		local n = (tonumber(items[id]) or 0) - Client.ItemCount(id) - Buy.OnTheWay(id)
		-- An item set by hand that is also the best of its kind: the larger need.
		if n > 0 then need[i] = max(need[i] or 0, n) end
	end
	local money, spent = Client.Money(), 0
	for i = 1, (GetMerchantNumItems and GetMerchantNumItems() or 0) do
		local n = need[i]
		if n then
			local id = GetMerchantItemID(i)
			local name, price, perStack, numAvailable = Buy.ItemInfo(i)
			name = name or (L["Item"] .. " " .. id)
			perStack = (perStack and perStack > 0) and perStack or 1
			local got, cost, shortItems, shortCost = Buy.Plan(n, price, perStack, numAvailable, money)
			if spent + cost > Buy.MAX_SPEND then
				left[#left + 1] = { name = name, need = n, cost = cost + shortCost, why = "cap" }
			else
				if got > 0 then
					buy[#buy + 1] = { i = i, id = id, name = name, need = n, items = got, cost = cost, price = price, perStack = perStack }
					money, spent = money - cost, spent + cost
				end
				if shortItems > 0 then left[#left + 1] = { name = name, need = shortItems, cost = shortCost, why = "money" } end
			end
		end
	end
	return buy, left
end

local function total(list)
	local t = 0
	for _, e in ipairs(list) do t = t + e.cost end
	return t
end

-- The press: buy the plan, and say what is left.
function Restock.Run()
	if not open then return end
	local buy, left = Restock.Plan()
	for _, e in ipairs(buy) do QoL.Buy.Purchase(e.i, e.id, e.name, e.items, e.price, e.perStack) end
	for _, e in ipairs(left) do
		if e.why == "money" then
			ns.Print(format(L["Not enough money to buy %d %s (%s)."], e.need, e.name, QoL.Money(e.cost)))
		else
			ns.Print(format(L["Left %d %s (%s) for you to buy."], e.need, e.name, QoL.Money(e.cost)))
		end
	end
	Restock.Update()
end

---------------------------------------------------------------------------
-- The button under the merchant window
---------------------------------------------------------------------------

local function makeButton()
	local W = ns.Widgets
	local parent = MerchantFrame or UIParent
	if W and W.Button then
		button = W.Button(parent, L["Restock"], function() Restock.Run() end, { primary = true })
	else
		button = CreateFrame("Button", nil, parent)
		button:SetSize(120, 26)
		button:SetScript("OnClick", function() Restock.Run() end)
	end
	button:SetFrameStrata("HIGH")
	button:ClearAllPoints()
	button:SetPoint("TOPRIGHT", parent, "BOTTOMRIGHT", 0, -4)
	button:Hide()
end

-- Shown while the merchant sells something short of its amount.
function Restock.Update()
	if not open then
		if button then button:Hide() end
		return
	end
	local buy = Restock.Plan()
	if #buy == 0 then
		if button then button:Hide() end
		return
	end
	if not button then makeButton() end
	local text = format(L["Restock (%s)"], QoL.Money(total(buy)))
	local W = ns.Widgets
	if W and W.SetButtonText and button.Label then W.SetButtonText(button, text) end
	local lines = {}
	for _, e in ipairs(buy) do lines[#lines + 1] = format("%d %s", e.items, e.name) end
	button.psTip, button.psTipLines = L["Restock"], lines
	button:Show()
end
local updateSoon = QoL.Coalesce(Restock.Update)

ns.RegisterEvent("MERCHANT_SHOW", function()
	open = true
	updateSoon()
end)
ns.RegisterEvent("MERCHANT_UPDATE", function() if open then updateSoon() end end)
ns.RegisterEvent("BAG_UPDATE_DELAYED", function() if open then updateSoon() end end)
ns.RegisterEvent("MERCHANT_CLOSED", function()
	open = false
	if button then button:Hide() end
end)
ns.On("RESTOCK_CHANGED", function() if open then updateSoon() end end)
ns.On("SETTING_CHANGED", function(path)
	if open and (path == "" or path == "qol" or path == "qol.restock") then updateSoon() end
end)

---------------------------------------------------------------------------
-- /polestar restock [drink|food|ammo|<item>] [amount]
---------------------------------------------------------------------------

local WORDS = { drink = "drink", drinks = "drink", water = "drink", food = "food", ammo = "ammo", ammunition = "ammo", arrows = "ammo", shot = "ammo" }
local LABEL = { drink = L["Drinks"], food = L["Food"], ammo = L["Ammunition"] }
Restock.Label = LABEL

function Restock.Command(rest)
	rest = rest or ""
	local n = tonumber(rest:match("(%d+)%s*$"))
	local what = n and rest:gsub("%s*%d+%s*$", "") or rest
	what = what:match("^%s*(.-)%s*$")
	if what == "" then
		local any = false
		for _, kind in ipairs(KINDS) do
			local v = Restock.Get(kind)
			if v > 0 then
				ns.Print(format(L["Restock: %s to %d"], LABEL[kind], v))
				any = true
			end
		end
		for id, v in pairs(amounts().items) do
			local link = ns.Compat.ItemLink and ns.Compat.ItemLink(id) or (L["Item"] .. " " .. id)
			ns.Print(format(L["Restock: %s to %d"], link, v))
			any = true
		end
		if not any then ns.Print(L["Nothing to restock. Set amounts on the options page, or: /polestar restock <item> <amount>."]) end
		return
	end
	local kind = WORDS[what:lower()]
	local id = not kind and (Client.ItemIDFromLink(what) or tonumber(what))
	if not (kind or id) or not n then
		ns.Print(L["Usage: /polestar restock [drink|food|ammo|<item>] <amount>"])
		return
	end
	if kind then
		Restock.Set(kind, n)
		ns.Print(format(L["Restock: %s to %d"], LABEL[kind], Restock.Get(kind)))
	else
		Restock.SetItem(id, n)
		local name = what:find("|H", 1, true) and what or (L["Item"] .. " " .. id)
		if n > 0 then ns.Print(format(L["Restock: %s to %d"], name, n)) else ns.Print(format(L["Restock: %s forgotten"], name)) end
	end
end

if ns.RegisterCommand then
	ns.RegisterCommand("restock", Restock.Command, L["Amounts to restock at merchants: drink, food, ammo or an item"])
end
