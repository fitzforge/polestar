-- The step's item in the bags: a glow on the bag slot holding the item the
-- current step uses (the quest item button's item, every open `use` goal's
-- item) or a quest item it collects (an open `collect` goal with a quest), so
-- the player finds it at a glance (qol.bagGlow, on by default). A slot
-- holding an item a later step keeps (QoL.Kept, QoL/Keep.lua) that a
-- merchant would buy gets a small lock in its top-left corner instead.
--
--   BagGlow.Items(view, raw) -> { [itemID] = true }   -- what glows for a step
--   BagGlow.Redraw()                                  -- repaint the shown bags now
--
-- Three bag views, as Gear/Bags.lua's upgrade arrows:
--   * The client's bags: Core/BagSlots.lua owns the hooks and addon
--     registration; the glow is the action button border texture on the
--     item button (OVERLAY sublevel 2, under the upgrade arrow and the search
--     overlay), in the theme's accent colour, pulsing. Glows and locks are
--     kept here by button; nothing is written into the button's table.
--   * Baganator and BagSmith: corner widgets, the lock top-left. The glow
--     is bottom-right in Baganator, bottom-left in BagSmith to leave its
--     protected stack count visible.
--
-- The step (STEP_CHANGED and friends), the bags (BAG_UPDATE_DELAYED) and the
-- quest log repaint the shown bags on the next frame.

local ADDON, ns = ...

local QoL = ns.QoL
local Client = QoL.Client
local L = ns.L
local Slots = ns.BagSlots

local type, pairs = type, pairs

local BagGlow = {}
QoL.BagGlow = BagGlow

local TEXTURE = "Interface\\Buttons\\UI-ActionButton-Border"
local SCALE = 1.9 -- the border texture's size against the item button's
local LAYER = 2 -- OVERLAY sublevel: under the upgrade arrow (3) and the search overlay (4)
local WIDGET = "polestar_step_item" -- bag addon corner widget id
local LOCK = "Interface\\PetBattles\\PetBattle-LockIcon"
local LOCK_SIZE = 14
local KEEP_WIDGET = "polestar_kept_item" -- bag addon corner widget id of the lock

local function paint(t)
	local T = ns.Theme
	local r, g, b = 1, 0.82, 0
	if T and T.Accent then r, g, b = T.Accent() end
	t:SetVertexColor(r, g, b, 1)
end

-- The items the current step wants found in the bags, and those later
-- steps keep (itemID -> step).
local items, kept = {}, {}

function BagGlow.Items(view, raw)
	local out = {}
	if not view then return out end
	local goals = view.goals or {}
	for g = 1, #goals do
		local gv = goals[g]
		if QoL.Open(gv) then
			local item = gv.item or (raw and raw[g] and raw[g].item)
			if item and (gv.t == "use" or (gv.t == "collect" and gv.quest)) then out[item] = true end
		end
	end
	local B = QoL.Buttons
	local chosen = B and B.ChooseQuestItem and B.ChooseQuestItem(view, raw)
	if chosen then out[chosen] = true end
	return out
end

local function wanted(itemID)
	return itemID ~= nil and items[itemID] == true
end

-- A kept item a merchant would buy: the glowing step item needs no lock.
local function locked(itemID)
	return itemID ~= nil and kept[itemID] ~= nil and not wanted(itemID) and (Client.SellPrice(itemID) or 0) > 0
end

---------------------------------------------------------------------------
-- The client's bags
---------------------------------------------------------------------------

local glows = setmetatable({}, { __mode = "k" }) -- item button -> glow texture
local widgets = setmetatable({}, { __mode = "k" }) -- glow textures made for bag addons
local locks = setmetatable({}, { __mode = "k" }) -- item button -> lock texture

local function lockFor(button)
	local t = locks[button]
	if t then return t end
	t = button:CreateTexture(nil, "OVERLAY", nil, LAYER)
	t:SetSize(LOCK_SIZE, LOCK_SIZE)
	t:SetPoint("TOPLEFT", button, "TOPLEFT", 1, -1)
	t:SetTexture(LOCK)
	locks[button] = t
	return t
end

local function pulse(t)
	if not t.CreateAnimationGroup then return end
	local ag = t:CreateAnimationGroup()
	ag:SetLooping("BOUNCE")
	local a = ag:CreateAnimation("Alpha")
	a:SetFromAlpha(1)
	a:SetToAlpha(0.35)
	a:SetDuration(0.7)
	t.pulse = ag
end

local function glowFor(button)
	local t = glows[button]
	if t then return t end
	t = button:CreateTexture(nil, "OVERLAY", nil, LAYER)
	local w, h = 37, 37
	if button.GetSize then w, h = button:GetSize() end
	t:SetSize((w or 37) * SCALE, (h or 37) * SCALE)
	t:SetPoint("CENTER", button, "CENTER", 0, 0)
	t:SetTexture(TEXTURE)
	if t.SetBlendMode then t:SetBlendMode("ADD") end
	paint(t)
	pulse(t)
	glows[button] = t
	return t
end

local function show(t)
	t:Show()
	if t.pulse and not t.pulse:IsPlaying() then t.pulse:Play() end
end

local function hide(t)
	if t.pulse then t.pulse:Stop() end
	t:Hide()
end

-- The glow and the locks: with the setting, not while Polestar is hidden.
local function glowing()
	return QoL.On("bagGlow") and not ns.Hidden()
end

local function paintBagSlot(button, view, itemID, link)
	if view == "ellesmere" then return end
	local id = glowing() and itemID
	if id and wanted(id) then
		show(glowFor(button))
	elseif glows[button] then
		hide(glows[button])
	end
	if id and locked(id) then
		lockFor(button):Show()
	elseif locks[button] then
		locks[button]:Hide()
	end
end

---------------------------------------------------------------------------
-- Baganator and BagSmith
---------------------------------------------------------------------------

local function showStepItem(details)
	return glowing() and type(details) == "table" and wanted(details.itemID) or false
end

local function makeStepItem(button)
	local t = button:CreateTexture(nil, "OVERLAY")
	local w = button.GetWidth and button:GetWidth() or 37
	t:SetSize(w * 0.6, w * 0.6)
	t:SetTexture(TEXTURE)
	if t.SetBlendMode then t:SetBlendMode("ADD") end
	paint(t)
	widgets[t] = true
	return t
end

local function showKeptItem(details)
	return glowing() and type(details) == "table" and locked(details.itemID) or false
end

local function makeKeptItem(button)
	local t = button:CreateTexture(nil, "OVERLAY")
	t:SetSize(LOCK_SIZE, LOCK_SIZE)
	t:SetTexture(LOCK)
	return t
end

if Slots then
	Slots.Painter("step-glow", paintBagSlot)
	Slots.Widget("step-glow", WIDGET, L["Polestar: step item"], showStepItem, makeStepItem, "bottom_right", "bottom_left")
	Slots.Widget("step-glow", KEEP_WIDGET, L["Polestar: kept for the guide"], showKeptItem, makeKeptItem, "top_left")
end

---------------------------------------------------------------------------
-- Keeping the glow on the step's items
---------------------------------------------------------------------------

function BagGlow.Redraw()
	if Slots then Slots.Redraw("step-glow") end
end

-- Two item sets the same?
local function same(a, b)
	for k, v in pairs(a) do if b[k] ~= v then return false end end
	for k in pairs(b) do if a[k] == nil then return false end end
	return true
end

-- The step's items and the kept ones again; a repaint only when they changed.
local function refresh()
	local view, raw = QoL.CurrentStep()
	local on = glowing()
	local now = on and BagGlow.Items(view, raw) or {}
	local keep = {}
	local E = ns.Engine
	local all = on and E and E.KeptItems and E.KeptItems()
	if all then for id, s in pairs(all) do keep[id] = s end end
	if same(now, items) and same(keep, kept) then return end
	items, kept = now, keep
	BagGlow.Redraw()
end
local refreshSoon, refreshOnLog = QoL.Coalesce(refresh)
BagGlow.Refresh = refresh

QoL.OnStep(refreshSoon)
ns.RegisterEvent("BAG_UPDATE_DELAYED", refreshSoon)
ns.RegisterEvent("QUEST_LOG_UPDATE", refreshOnLog)
local function reset()
	items, kept = {}, {}
	refreshSoon()
	BagGlow.Redraw()
end
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.bagGlow" or path == "qol" or path == "" then reset() end
end)
ns.On("POLESTAR_HIDDEN", reset)

if ns.Theme and ns.Theme.OnChanged then
	ns.Theme.OnChanged(function()
		for _, t in pairs(glows) do paint(t) end
		for t in pairs(widgets) do paint(t) end
	end)
end
