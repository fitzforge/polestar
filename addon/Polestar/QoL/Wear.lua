-- Gear worth wearing that reaches the bags from loot or a merchant
-- (qol.wearOffer, on by default, with Gear advice on): the guide window's
-- banner offers it, one item at a time, with "Wear it" and "Not this one".
-- Nothing goes on without that press, and an item that would bind when worn
-- still brings up the client's own confirmation. The slot is the one a quest
-- reward would take (Equip.Placement: the weaker ring or trinket, a
-- one-hander against a worn two-hander). "Not this one" is remembered for
-- the item, per character; closing the banner only lets that copy go.
--
-- Only a new copy counts: what the bags held at login or at the last look
-- is never offered, and neither is a piece just taken off. Left alone too: an
-- item a later step needs (QoL.Kept), one marked as junk, and a turn-in's
-- item QoL/Equip.lua is putting on itself. An offer whose item has left the
-- bags, or that stopped being an upgrade (something better went on), goes.
--
-- Fires WEAR_OFFER when the offer shown changes.
--
-- Client: C_Item.GetItemInfoInstant (itemEquipLoc), C_Item.EquipItemByName
-- (ItemDocumentation); GetInventoryItemID; BAG_UPDATE_DELAYED,
-- PLAYER_EQUIPMENT_CHANGED.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local Client = QoL.Client

local format, tremove, type, pairs, ipairs = string.format, table.remove, type, pairs, ipairs
local wipe = wipe or function(t) for k in pairs(t) do t[k] = nil end return t end

local Wear = {}
QoL.Wear = Wear

local SLOTS = 19 -- inventory slots 1..19: everything worn

local counts           -- itemID -> copies in the bags at the last look; nil before the first
local links = {}       -- itemID -> a link of it in the bags (random suffixes differ per copy)
local spareCounts, spareLinks = {}, {} -- the look before last, reused for the next
local worn = {}        -- itemID -> true: worn at the last look
local offers = {}      -- { id, link, slot, pct }, oldest first
local putting          -- { id, slot, link, pct }: pressed Wear it, not on yet
local shown

local function gear()
	local G = ns.Gear
	if not (G and G.IsUpgrade) then return nil end
	if G.IsEnabled and not G.IsEnabled() then return nil end
	return G
end

local function on()
	return QoL.On("wearOffer") and gear() ~= nil
end

local function declined(id)
	local d = QoL.State().wearDeclined
	return type(d) == "table" and d[id] == true
end

local function equippable(id)
	if not (C_Item and C_Item.GetItemInfoInstant) then return false end
	local _, _, _, loc = C_Item.GetItemInfoInstant(id)
	return type(loc) == "string" and loc ~= "" and loc ~= "INVTYPE_NON_EQUIP_IGNORE" and loc ~= "INVTYPE_BAG"
end

local function leftAlone(id)
	if declined(id) then return true end
	if QoL.Kept and QoL.Kept(id) then return true end
	local M = QoL.Marks
	if M and M.Get(id) == "junk" then return true end
	local E = QoL.Equip
	return E and E.Pending and E.Pending(id) or false
end

local function placed(G, link)
	local E = QoL.Equip
	if E and E.Placement then return E.Placement(G, link) end
	return nil
end

local function announce()
	local head = on() and offers[1] or nil
	if head ~= shown then
		shown = head
		ns.Fire("WEAR_OFFER")
	end
end

-- The bags against the last look: a new copy of something wearable that
-- was not worn a moment ago is offered when it is an upgrade; offers that
-- no longer hold are dropped.
function Wear.Scan()
	if not on() then
		-- Off: forget the last look, so turning it on offers nothing that came meanwhile.
		counts = nil
		wipe(offers)
		announce()
		return
	end
	local now, nowLinks = wipe(spareCounts), wipe(spareLinks)
	for bag = 0, Client.NumBags() do
		for slot = 1, Client.NumSlots(bag) do
			local info = Client.SlotInfo(bag, slot)
			local id = info and info.itemID
			if id then
				now[id] = (now[id] or 0) + (info.stackCount or 1)
				if not nowLinks[id] then nowLinks[id] = info.hyperlink end
			end
		end
	end
	local before = counts
	spareCounts, spareLinks = before or {}, links
	counts, links = now, nowLinks
	local G = gear()
	if before and G then
		for id, n in pairs(now) do
			if n > (before[id] or 0) and not worn[id] and equippable(id) and not leftAlone(id) then
				local link = nowLinks[id]
				local slot, pct
				if link then slot, pct = placed(G, link) end
				local dup = false
				for _, o in ipairs(offers) do
					if o.id == id then dup = true break end
				end
				if slot and not dup then offers[#offers + 1] = { id = id, link = link, slot = slot, pct = pct } end
			end
		end
	end
	local keep = {}
	for _, o in ipairs(offers) do
		if G and now[o.id] and not leftAlone(o.id) then
			local slot, pct = placed(G, links[o.id] or o.link)
			if slot then
				o.slot, o.pct = slot, pct
				keep[#keep + 1] = o
			end
		end
	end
	offers = keep
	wipe(worn)
	for slot = 1, SLOTS do
		local id = Client.WornID(slot)
		if id then worn[id] = true end
	end
	announce()
end
local scanSoon = QoL.Coalesce(Wear.Scan)

-- The offer the banner shows: { id, link, slot, pct } or nil.
function Wear.Offer()
	return on() and offers[1] or nil
end

-- Wear it: the offer goes on (once combat ends, if it has to wait).
function Wear.Take()
	local o = Wear.Offer()
	if not o then return end
	tremove(offers, 1)
	putting = o
	QoL.Secure("wearOffer", function()
		if C_Item and C_Item.EquipItemByName then C_Item.EquipItemByName(o.link, o.slot) end
	end)
	announce()
end

-- Not this one: never offered again on this character.
function Wear.Decline()
	local o = Wear.Offer()
	if not o then return end
	local s = QoL.State()
	if type(s.wearDeclined) ~= "table" then s.wearDeclined = {} end
	s.wearDeclined[o.id] = true
	tremove(offers, 1)
	announce()
end

-- Closed: this copy is let go; a new one may be offered again.
function Wear.Dismiss()
	if not Wear.Offer() then return end
	tremove(offers, 1)
	announce()
end

local function onEquipment()
	local p = putting
	if p and Client.WornID(p.slot) == p.id then
		putting = nil
		local G = ns.Gear
		local gain = p.pct and G and G.GainText and G.GainText(p.pct)
		ns.Print(gain and format(L["Wearing %s (%s)."], p.link, gain) or format(L["Wearing %s."], p.link))
	end
	scanSoon()
end

ns.OnLogin(Wear.Scan)
ns.RegisterEvent("BAG_UPDATE_DELAYED", scanSoon)
ns.RegisterEvent("PLAYER_EQUIPMENT_CHANGED", onEquipment)
ns.On("ITEM_MARKS", scanSoon)
ns.On("SETTING_CHANGED", function(path)
	if path == "" or path == "qol" or path == "qol.wearOffer" or (type(path) == "string" and path:sub(1, 5) == "gear.") then announce() end
end)
