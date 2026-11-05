-- Junk and keep marks (qol.itemMarks, on by default): Ctrl+Alt-click an item
-- in the bags, a loot slot or a chat link to mark it as junk; again to keep
-- it; again to clear the mark. Marks are per character, by item ID, and the
-- item's tooltip shows the one it has.
--   junk: sold at a merchant along with the grey items (QoL/Vendor.lua), and
--     one of the items the bag button can delete (QoL/Space.lua) when it is
--     of common quality or below.
--   keep: never sold or deleted by Polestar, grey or not.
-- An item a later step still needs (QoL.Kept, QoL/Keep.lua) is
-- kept whatever its mark says.
--
-- Client: HandleModifiedItemClick, through Polestar.Hooks.ItemClick
-- (Core/Hooks.lua); IsControlKeyDown, IsAltKeyDown, IsShiftKeyDown.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL

local type, format = type, string.format

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

-- The next mark in the cycle, said in chat.
function Marks.OnItemClick(link, id)
	if not (QoL.On("itemMarks") and ctrlAltOnly()) then return end
	local mark = NEXT[Marks.Get(id) or false] or nil
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
