-- Items the guide keeps for later: what a step from the live one on still
-- needs in the bags (Engine.KeptItems: a `use` item, a `collect`'s or a
-- `buy`'s, a `craft`'s reagents, the item an `accept` starts from, a quest's
-- items until its turn-in). They are never sold as junk (QoL/Vendor.lua),
-- their bag slot carries a lock (QoL/BagGlow.lua), their tooltip says which
-- step needs them, in the warning colour while a merchant is open, and
-- opening a merchant with any that sell in the bags names them in chat
-- first, so none goes by mistake.
--
--   QoL.Kept(itemID) -> the step that needs it | nil
--   QoL.KeptLine(itemID) -> text, r, g, b | nil   -- its tooltip line (a warning while a merchant is open)
--   QoL.KeptToSell() -> { { item, link }, ... }   -- kept items in the bags a merchant buys, once each, in bag order
--
-- Client: C_Container.GetContainerItemInfo (hasNoValue, hyperlink), C_Item.GetItemInfo's sell price.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local Client = QoL.Client

local format, concat = string.format, table.concat

function QoL.Kept(itemID)
	local E = ns.Engine
	local items = itemID and E and E.KeptItems and E.KeptItems()
	return items and items[itemID] or nil
end

function QoL.KeptToSell()
	local out, seen = {}, {}
	for bag = 0, Client.NumBags() do
		for slot = 1, Client.NumSlots(bag) do
			local info = Client.SlotInfo(bag, slot)
			local id = info and info.itemID
			if id and not seen[id] and not info.hasNoValue and QoL.Kept(id) and (Client.SellPrice(id) or 0) > 0 then
				seen[id] = true
				out[#out + 1] = { item = id, link = info.hyperlink }
			end
		end
	end
	return out
end

local atMerchant = false

-- The theme's colour `name` ("accent": its accent), else the given one.
local function color(name, r, g, b)
	local T = ns.Theme
	local cr, cg, cb
	if name == "accent" and T and T.Accent then cr, cg, cb = T.Accent()
	elseif T and T.Color then cr, cg, cb = T.Color(name) end
	if cr then return cr, cg, cb end
	return r, g, b
end

function QoL.KeptLine(itemID)
	local s = QoL.Kept(itemID)
	if not s then return nil end
	if atMerchant then return format(L["Don't sell: the guide needs it at step %d"], s), color("warning", 1, 0.6, 0.25) end
	return format(L["Kept for the guide: step %d needs it"], s), color("accent", 1, 0.82, 0)
end

-- Hooks (Core/Hooks.lua) owns the tooltips; a partial load without it has none.
local H = ns.Hooks
if H and H.ItemLines then
	H.ItemLines("keep", function(tooltip, _, itemID)
		local text, r, g, b = QoL.KeptLine(itemID)
		if text then H.AddLine(tooltip, text, nil, r, g, b) end
	end)
end

-- The item as chat shows it: its link, else its name.
local function itemText(e)
	if type(e.link) == "string" and e.link ~= "" then return e.link end
	local N = ns.Names
	local name = N and N.Item and N.Item(e.item)
	if not name and C_Item and C_Item.GetItemInfo then name = C_Item.GetItemInfo(e.item) end
	return name or ("item:" .. e.item)
end

ns.RegisterEvent("MERCHANT_SHOW", function()
	atMerchant = true
	local list = QoL.KeptToSell()
	if #list == 0 then return end
	local names = {}
	for i, e in ipairs(list) do names[i] = itemText(e) end
	ns.Print(format(#list == 1 and L["Keep %s: a later step of the guide needs it."] or L["Keep %s: later steps of the guide need them."], concat(names, ", ")))
end)
ns.RegisterEvent("MERCHANT_CLOSED", function() atMerchant = false end)
