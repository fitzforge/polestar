-- Items the guide keeps for later: what a step from the live one on still
-- needs in the bags (Engine.KeptItems: a `use` item, a `collect`'s or a
-- `buy`'s, a `craft`'s reagents, the item an `accept` starts from, a quest's
-- items until its turn-in). They are never sold as junk (QoL/Vendor.lua),
-- their bag slot carries a lock (QoL/BagGlow.lua), and opening a merchant
-- with any that sell in the bags names them in chat first, so none goes by
-- mistake. Any item's tooltip lists the guides whose steps use it
-- (Engine.ItemGuides: the active guide with its step, then the guides
-- ahead), headed "Don't sell, used in guides:" in the warning colour while a
-- merchant is open. An item only a guide ahead uses is listed but not Kept.
--
--   QoL.Kept(itemID) -> the step that needs it | nil   -- the active guide only
--   QoL.KeptLines(itemID) -> { header = { text, r, g, b }, lines = { { text, r, g, b }, ... } } | nil
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

-- A guide's levels as "12-13" ("12" for one level), for the player's side.
-- A step title cut to at most TITLE_MAX characters (UTF-8, not bytes) at a
-- word's end, with an ellipsis, so a long step title keeps the tooltip narrow.
local TITLE_MAX = 32
local function shortTitle(t)
	local n = 0
	for pos in t:gmatch("()[%z\1-\127\194-\244][\128-\191]*") do
		n = n + 1
		if n > TITLE_MAX then
			local head = t:sub(1, pos - 1)
			if not t:sub(pos, pos):match("%s") then head = head:match("^(.*%S)%s") or head end
			return (head:gsub("[%s%p]+$", "")) .. "\226\128\166"
		end
	end
	return t
end

local function levelsText(g)
	local G = ns.Guides
	local lo, hi
	if G and G.Levels then lo, hi = G.Levels(g) else lo, hi = g.minLevel, g.maxLevel end
	if not (lo or hi) then return nil end
	lo, hi = lo or hi, hi or lo
	if lo == hi then return format("%d", lo) end
	return format("%d-%d", lo, hi)
end

-- The tooltip block for itemID: every guide whose steps use it, the active
-- one (with its step) first, then those ahead (Engine.ItemGuides).
-- -> { header = { text, r, g, b }, lines = { { text, r, g, b }, ... } } | nil
-- The header is the accent colour, "Don't sell, used in guides:" in the
-- warning colour while a merchant is open. An item only a guide ahead uses
-- gets the block but is not Kept: it can still be sold.
function QoL.KeptLines(itemID)
	local E = ns.Engine
	local list = itemID and E and E.ItemGuides and E.ItemGuides(itemID)
	if not list then return nil end
	local lines = {}
	for i, e in ipairs(list) do
		local g = e.guide
		local text = g.title or g.id or "?"
		local levels = levelsText(g)
		if levels then text = levels .. " " .. text end
		local s = e.step
		if s then
			-- The step as the player counts it (#942: steps not theirs left out)
			-- and its title when it has one.
			local step = g.steps and g.steps[s]
			local title = step and type(step.title) == "string" and step.title ~= "" and step.title or nil
			if title then title = shortTitle(title) end
			if E.StepNumberOf then s = E.StepNumberOf(g, s) end
			text = title and format(L["%s: step %d (%s)"], text, s, title) or format(L["%s: step %d"], text, s)
		end
		local r, gr, b = color("textDim", 0.8, 0.8, 0.8)
		lines[i] = { text, r, gr, b }
	end
	local header
	if atMerchant then
		header = { L["Don't sell, used in guides:"], color("warning", 1, 0.6, 0.25) }
	else
		header = { L["Used in guides:"], color("accent", 1, 0.82, 0) }
	end
	return { header = header, lines = lines }
end

-- Hooks (Core/Hooks.lua) owns the tooltips; a partial load without it has none.
local H = ns.Hooks
if H and H.ItemLines then
	H.ItemLines("keep", function(tooltip, _, itemID)
		local block = QoL.KeptLines(itemID)
		if not block then return end
		local h = block.header
		H.AddLine(tooltip, h[1], nil, h[2], h[3], h[4])
		for _, l in ipairs(block.lines) do H.AddLine(tooltip, "  " .. l[1], nil, l[2], l[3], l[4]) end
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
