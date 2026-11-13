-- Junk and keep marks (qol.itemMarks, on by default): Ctrl+Alt-click an item
-- in the bags, a loot slot or a chat link to mark it as junk; again to keep
-- it; again to clear the mark (qol.itemMarksClick, on by default, turns the
-- click off). Two key bindings (Bindings.xml, unbound until the player sets
-- them) act on the item under the mouse: Mark as junk toggles junk, Mark to
-- keep toggles keep, each replacing the other mark. Marks are per character,
-- by item ID, and the item's tooltip shows the one it has.
--   junk: sold at a merchant along with the grey items (QoL/Vendor.lua), and
--     one of the items the bag button can delete (QoL/Space.lua) when it is
--     of common quality or below.
--   keep: never sold or deleted by Polestar, grey or not.
-- An item a later step still needs (QoL.Kept, QoL/Keep.lua) is
-- kept whatever its mark says.
--
-- Client: HandleModifiedItemClick, through Polestar.Hooks.ItemClick
-- (Core/Hooks.lua); IsControlKeyDown, IsAltKeyDown, IsShiftKeyDown. The item
-- under the mouse, for the keys: GetMouseFoci (GetMouseFocus on older
-- clients); a bag slot's button has GetBagID and GetID, its link from
-- C_Container.GetContainerItemLink (Blizzard_UIPanels_Game/Mainline/
-- ContainerFrame.lua); a loot slot's button sits in an element with
-- GetSlotIndex, its link from GetLootSlotLink (LootFrame.lua); any other
-- item button shows its item on GameTooltip, owned by the button.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL

local type, format, tonumber, pcall = type, string.format, tonumber, pcall

local Marks = {}
QoL.Marks = Marks

local NEXT = { [false] = "junk", junk = "keep", keep = false }

local function saved(create)
	local s = QoL.State()
	local m = s.marks
	if type(m) ~= "table" then
		if not create then return nil end
		m = {}
		s.marks = m
	end
	return m
end

-- "junk", "keep" or nil: the player's own mark.
function Marks.Get(id)
	local m = saved(false)
	return m and m[id] or nil
end

-- mark: "junk", "keep" or nil to clear.
function Marks.Set(id, mark)
	if type(id) ~= "number" then return end
	local m = saved(true)
	if mark ~= "junk" and mark ~= "keep" then mark = nil end
	if m[id] == mark then return end
	m[id] = mark
	ns.Fire("ITEM_MARKS", id, mark)
end

-- Never sold or deleted: marked to keep, or still needed by a later step.
function Marks.Protected(id)
	if Marks.Get(id) == "keep" then return true end
	local kept = QoL.Kept
	return kept ~= nil and kept(id) ~= nil
end

-- Marked junk and nothing says to keep it.
function Marks.Junk(id)
	return Marks.Get(id) == "junk" and not Marks.Protected(id)
end

local function ctrlAltOnly()
	if not (IsControlKeyDown and IsControlKeyDown()) then return false end
	if not (IsAltKeyDown and IsAltKeyDown()) then return false end
	return not (IsShiftKeyDown and IsShiftKeyDown())
end

-- The item's new mark, said in chat.
local function apply(link, id, mark)
	Marks.Set(id, mark)
	local name = type(link) == "string" and link:find("|H", 1, true) and link or (L["Item"] .. " " .. id)
	if mark == "junk" then
		ns.Print(format(L["%s is junk now: sold at merchants, and the first to go when your bags are full."], name))
	elseif mark == "keep" then
		ns.Print(format(L["%s is kept now: Polestar never sells or deletes it."], name))
	else
		ns.Print(format(L["%s: mark cleared."], name))
	end
end

-- The next mark in the cycle.
function Marks.OnItemClick(link, id)
	if not (QoL.On("itemMarks") and QoL.On("itemMarksClick") and ctrlAltOnly()) then return end
	apply(link, id, NEXT[Marks.Get(id) or false] or nil)
end

local secret = ns.Compat and ns.Compat.IsSecret or function() return false end

local function itemLink(link)
	if type(link) ~= "string" or secret(link) then return nil end
	local id = tonumber(link:match("item:(%d+)"))
	if not id then return nil end
	return link, id
end

local function call(obj, method, ...)
	local fn = obj and obj[method]
	if type(fn) ~= "function" then return nil end
	local ok, v = pcall(fn, obj, ...)
	if ok then return v end
end

local function mouseFocus()
	if GetMouseFoci then
		local foci = GetMouseFoci()
		return type(foci) == "table" and foci[1] or nil
	end
	return GetMouseFocus and GetMouseFocus() or nil
end

-- The item under the mouse: link, item ID, or nil.
function Marks.Hovered()
	local f = mouseFocus()
	if type(f) ~= "table" then return nil end
	local bag, slot = call(f, "GetBagID"), call(f, "GetID")
	if type(bag) == "number" and type(slot) == "number" and C_Container and C_Container.GetContainerItemLink then
		return itemLink(C_Container.GetContainerItemLink(bag, slot))
	end
	local index = call(f, "GetSlotIndex") or call(call(f, "GetParent"), "GetSlotIndex")
	if type(index) == "number" and GetLootSlotLink then
		return itemLink(GetLootSlotLink(index))
	end
	local tip = GameTooltip
	if tip and call(tip, "IsShown") and call(tip, "GetOwner") == f then
		local link
		if TooltipUtil and TooltipUtil.GetDisplayedItem then
			local ok, _, l = pcall(TooltipUtil.GetDisplayedItem, tip)
			if ok then link = l end
		end
		if link == nil and tip.GetItem then
			local ok, _, l = pcall(tip.GetItem, tip)
			if ok then link = l end
		end
		return itemLink(link)
	end
	return nil
end

-- A key binding: `kind` ("junk" or "keep") on the item under the mouse, or
-- off again when it has that mark. -> the new mark (false when cleared), or
-- nil when nothing was marked. While Polestar is hidden, nothing.
function Marks.Key(kind)
	if kind ~= "junk" and kind ~= "keep" then return nil end
	if not QoL.On("itemMarks") or ns.Hidden() then return nil end
	local link, id = Marks.Hovered()
	if not id then return nil end
	local mark = Marks.Get(id) ~= kind and kind or nil
	apply(link, id, mark)
	return mark or false
end

local function color(name, fr, fg, fb)
	local T = ns.Theme
	if T and T.Color then
		local r, g, b = T.Color(name)
		if r then return r, g, b end
	end
	return fr, fg, fb
end

function Marks.TooltipLine(tooltip, link, id)
	if not QoL.On("itemMarks") then return end
	local mark = Marks.Get(id)
	if not mark then return end
	local lr, lg, lb = color("textDim", 0.69, 0.72, 0.8)
	if mark == "junk" then
		local r, g, b = color("danger", 0.9, 0.4, 0.4)
		ns.Hooks.AddLine(tooltip, L["Polestar"], L["Marked as junk"], lr, lg, lb, r, g, b)
	else
		local r, g, b = color("success", 0.42, 0.85, 0.6)
		ns.Hooks.AddLine(tooltip, L["Polestar"], L["Marked to keep"], lr, lg, lb, r, g, b)
	end
end

local Hooks = ns.Hooks
if Hooks then
	Hooks.ItemClick("marks", Marks.OnItemClick)
	Hooks.ItemLines("marks", Marks.TooltipLine)
end
