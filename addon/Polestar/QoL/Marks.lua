-- Junk and keep marks (qol.itemMarks, on by default): Ctrl+Alt-click an item
-- in the bags, a loot slot or a chat link to mark it as junk; again to keep
-- it; again to clear the mark. Or two keys of the player's choosing (Key
-- Bindings > Polestar: Mark as junk, Mark to keep; unbound by default), each
-- pressed over an item: it takes that mark, or loses it when it has it
-- already. Marks are per character, by item ID, and the item's tooltip shows
-- the one it has, with the key that clears it when that key is bound.
--   junk: sold at a merchant along with the grey items (QoL/Vendor.lua), and
--     one of the items the bag button can delete (QoL/Space.lua) when it is
--     of common quality or below.
--   keep: never sold or deleted by Polestar, grey or not.
-- An item a later step still needs (QoL.Kept, QoL/Keep.lua) is
-- kept whatever its mark says.
--
-- Client: HandleModifiedItemClick, through Polestar.Hooks.ItemClick
-- (Core/Hooks.lua); IsControlKeyDown, IsAltKeyDown, IsShiftKeyDown;
-- GetBindingKey, GetBindingText; the hovered item through
-- Polestar.Hooks.HoveredItem, its tooltip shown again by Hooks.RefreshItem.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL

local type, format = type, string.format

local Marks = {}
QoL.Marks = Marks

local NEXT = { [false] = "junk", junk = "keep", keep = false }
-- The keys' bindings (Bindings.xml; their names in Core/Commands.lua).
local BINDING = { junk = "POLESTAR_MARK_JUNK", keep = "POLESTAR_MARK_KEEP" }
Marks.BINDING = BINDING

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

-- Says item id's new mark in chat.
local function announce(link, id, mark)
	local name = type(link) == "string" and link:find("|H", 1, true) and link or (L["Item"] .. " " .. id)
	if mark == "junk" then
		ns.Print(format(L["%s is junk now: sold at merchants, and the first to go when your bags are full."], name))
	elseif mark == "keep" then
		ns.Print(format(L["%s is kept now: Polestar never sells or deletes it."], name))
	else
		ns.Print(format(L["%s: mark cleared."], name))
	end
end

-- The next mark in the cycle, said in chat.
function Marks.OnItemClick(link, id)
	if not (QoL.On("itemMarks") and ctrlAltOnly()) then return end
	local mark = NEXT[Marks.Get(id) or false] or nil
	Marks.Set(id, mark)
	ns.Hooks.RefreshItem(id)
	announce(link, id, mark)
end

-- The Mark as junk / Mark to keep key (kind "junk" or "keep"), pressed over an
-- item: the item takes that mark, or loses it when it has it already; said in
-- chat. Pressed over no item, it says to point at one. Nothing while marks are
-- off or Polestar is hidden (as the click).
function Marks.Press(kind)
	if not BINDING[kind] or not QoL.On("itemMarks") or ns.Hidden() then return end
	local link, id = ns.Hooks.HoveredItem()
	if not id then
		ns.Print(L["Point at an item to mark it."])
		return
	end
	local mark = Marks.Get(id) ~= kind and kind or nil
	Marks.Set(id, mark)
	ns.Hooks.RefreshItem(id)
	announce(link, id, mark)
end

-- The key bound to mark `kind`, as the key bindings window writes it
-- ("Ctrl-J"), or nil while it has none.
function Marks.KeyText(kind)
	if not (BINDING[kind] and GetBindingKey) then return nil end
	local key = GetBindingKey(BINDING[kind])
	if type(key) ~= "string" or key == "" then return nil end
	local text = GetBindingText and GetBindingText(key)
	if type(text) ~= "string" or text == "" then text = key end
	return text
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
	-- The key that clears the mark, when one is bound.
	local key = Marks.KeyText(mark)
	if mark == "junk" then
		local r, g, b = color("danger", 0.9, 0.4, 0.4)
		local text = key and format(L["Marked as junk (%s clears it)"], key) or L["Marked as junk"]
		ns.Hooks.AddLine(tooltip, L["Polestar"], text, lr, lg, lb, r, g, b)
	else
		local r, g, b = color("success", 0.42, 0.85, 0.6)
		local text = key and format(L["Marked to keep (%s clears it)"], key) or L["Marked to keep"]
		ns.Hooks.AddLine(tooltip, L["Polestar"], text, lr, lg, lb, r, g, b)
	end
end

local Hooks = ns.Hooks
if Hooks then
	Hooks.ItemClick("marks", Marks.OnItemClick)
	Hooks.ItemLines("marks", Marks.TooltipLine)
end
