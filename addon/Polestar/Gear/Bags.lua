-- Upgrade arrows on bag items: the quest reward panel's green arrow
-- (QoL/Rewards.lua) on every item in the bags that Gear.IsUpgrade calls an
-- upgrade, so the bags show at a glance what the tooltip's comparison line
-- (Gear/Tooltip.lua) says on hover (gear.bagArrows, on by default; nothing
-- with gear advice off, or with gear.hideForPawn on and Pawn installed). An
-- item that fits an empty slot and is worth nothing under the weights, but no
-- loss, gets the arrow too (Gear.FillsEmptySlot), as the tooltip's "upgrade
-- (empty slot)" says. The verdict is this character's. While Forever
-- Leveling BiS's answers apply (installed, Stat weights on Automatic,
-- gear.useFlbis on): from its API version 2, Gear.IsUpgrade's answer from its
-- gains (GetGain: an upgrade for this character now, whatever its own Bag
-- upgrades switch says); with version 1 alone, its own bag arrow's answer
-- (IsUpgrade, Gear.FLB.BagUpgrade).
--
--   Gear.Bags.IsUpgrade(link) -> bool   -- the verdict an arrow shows
--   Gear.Bags.Redraw()                  -- repaint the shown bags now
--
-- Four bag views:
--   * The client's bags (Blizzard_UIPanels_Game Mainline ContainerFrame.lua,
--     which Forever loads): Core/BagSlots.lua owns the hooks and addon
--     registration for all four views. The arrow
--     is a texture on the item button (the gamepad interface hooks only
--     CreateFrame), in the top-left corner where the client's own, unused,
--     UpgradeIcon sits, at OVERLAY sublevel 3: over the icon overlays (1, 2),
--     under the search overlay (4), so a bag search dims it with the icon.
--     Nothing is written into the button's table: arrows are kept here by
--     button.
--   * Baganator and BagSmith: a corner widget (top-left, first), the way
--     Baganator shows Pawn's arrow. Each addon hides and places it.
--   * EllesmereUI Bags (EllesmereUIBags), which replaces the client's bag
--     frames (grid and list, bags, reagent bag and bank). The arrow is a texture
--     on the button's _textOverlay, bottom-left: top-left is where it shows
--     the item's level (btn.ItemLevelText), which the arrow would cover, and
--     bottom-right is its own Pawn arrow's.
--
-- New verdicts (GEAR_UPDATED: equipment, bags, level, spec, item data, gear
-- settings) repaint the shown bags at most once every REDRAW seconds.

local ADDON, ns = ...

local Gear = ns.Gear
local L = ns.L
local Slots = ns.BagSlots

local type, pairs = type, pairs

local Bags = {}
Gear.Bags = Bags

local BADGE = 20 -- the arrow texture's size, as on the reward panel
local LAYER = 3 -- OVERLAY sublevel: over IconOverlay2, under searchOverlay
local REDRAW = 0.2 -- seconds: GEAR_UPDATED repaints at most this often
local WIDGET = "polestar_upgrade" -- bag addon corner widget id

-- Pawn draws its own arrows on bag items: gear.hideForPawn leaves the bags to
-- it while Pawn is installed and enabled. None while Polestar is hidden.
function Bags.IsOn()
	if ns.Hidden() or not (Gear.IsEnabled() and ns.Get("gear.bagArrows")) then return false end
	if ns.Get("gear.hideForPawn") and ns.Compat.AddOnPresent("Pawn") then return false end
	return true
end

function Bags.IsUpgrade(link)
	if type(link) ~= "string" or not Bags.IsOn() then return false end
	-- Forever Leveling BiS's own arrow while its answers apply (Gear.UsesFLB)
	-- and it has no gains to give (its API version 1): its "no" stands too, as
	-- while its Bag upgrades switch is off.
	if Gear.UsesFLB and Gear.UsesFLB(1) and not Gear.UsesFLB(2) then
		local up = Gear.FLB.BagUpgrade(link)
		if up ~= nil then return up end
	end
	return (Gear.IsUpgrade(link) or Gear.FillsEmptySlot(link)) and true or false
end

local function media()
	local T = ns.Theme
	return T and T.Media and T.Media("qol-upgrade") or nil
end

local function paint(t)
	local T = ns.Theme
	if not (T and T.Color) then return end
	local r, g, b = T.Color("success")
	if r then t:SetVertexColor(r, g, b, 1) end
end

local arrows = setmetatable({}, { __mode = "k" }) -- item button -> arrow texture (the client's bags)
local widgets = setmetatable({}, { __mode = "k" }) -- arrow textures made for bag addons

---------------------------------------------------------------------------
-- The client's bags
---------------------------------------------------------------------------

local function arrowFor(button)
	local t = arrows[button]
	if t then return t end
	t = button:CreateTexture(nil, "OVERLAY", nil, LAYER)
	t:SetSize(BADGE, BADGE)
	t:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
	t:SetTexture(media())
	paint(t)
	arrows[button] = t
	return t
end

---------------------------------------------------------------------------
-- Baganator and BagSmith
---------------------------------------------------------------------------

local function showWidget(details)
	return Bags.IsUpgrade(type(details) == "table" and details.itemLink or nil)
end

local function makeWidget(button)
	local t = button:CreateTexture(nil, "OVERLAY")
	t:SetSize(BADGE, BADGE)
	t:SetTexture(media())
	paint(t)
	widgets[t] = true
	return t
end

---------------------------------------------------------------------------
-- EllesmereUI Bags
---------------------------------------------------------------------------

local marks = setmetatable({}, { __mode = "k" }) -- item button -> arrow texture

local function ellesmereArrow(button)
	local t = marks[button]
	if t then return t end
	local host = button._textOverlay or button
	t = host:CreateTexture(nil, "OVERLAY", nil, LAYER)
	t:SetSize(BADGE, BADGE)
	t:SetPoint("BOTTOMLEFT", host, "BOTTOMLEFT", 0, 0)
	t:SetTexture(media())
	paint(t)
	marks[button] = t
	return t
end

-- One slot's arrow from its link. EllesmereUI Bags reruns the painters each
-- time it fills a button, so the link last painted is the button's item.
local function markEllesmere(button, link)
	local t = marks[button]
	if link and Bags.IsUpgrade(link) then
		ellesmereArrow(button):Show()
	elseif t then
		t:Hide()
	end
end

local function paintBagSlot(button, view, itemID, link)
	if view == "ellesmere" then markEllesmere(button, link); return end
	if Bags.IsUpgrade(link) then
		arrowFor(button):Show()
	elseif arrows[button] then
		arrows[button]:Hide()
	end
end

if Slots then
	Slots.Painter("bag-arrows", paintBagSlot)
	Slots.Widget("bag-arrows", WIDGET, L["Polestar"], showWidget, makeWidget, "top_left")
end

---------------------------------------------------------------------------
-- Keeping the arrows fresh
---------------------------------------------------------------------------

function Bags.Redraw()
	if Slots then Slots.Redraw("bag-arrows") end
end

local pending = false
local function schedule()
	if pending then return end
	pending = true
	local function run()
		pending = false
		Bags.Redraw()
	end
	if C_Timer and C_Timer.After then ns.After(REDRAW, run) else run() end
end

ns.On("GEAR_UPDATED", schedule)
ns.On("POLESTAR_HIDDEN", schedule)

if ns.Theme and ns.Theme.OnChanged then
	ns.Theme.OnChanged(function()
		for _, t in pairs(arrows) do paint(t) end
		for t in pairs(widgets) do paint(t) end
		for _, t in pairs(marks) do paint(t) end
	end)
end
