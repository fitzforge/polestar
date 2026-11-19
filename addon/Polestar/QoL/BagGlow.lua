-- The step's item in the bags: a glow on the bag slot holding the item the
-- current step uses (the quest item button's item, every open `use` goal's
-- item) or a quest item it collects (an open `collect` goal with a quest), so
-- the player finds it at a glance (qol.bagGlow, on by default). A slot
-- holding an item a later step keeps (QoL.Kept, QoL/Keep.lua) that a
-- merchant would buy gets a small lock instead, bottom-left in the client's
-- bags, Baganator and BagSmith; top-right in EllesmereUI Bags, beside the
-- quest icon when the slot has one.
--
--   BagGlow.Items(view, raw) -> { [itemID] = true }   -- what glows for a step
--   BagGlow.Redraw()                                  -- repaint the shown bags now
--
-- Four bag views, as Gear/Bags.lua's upgrade arrows:
--   * The client's bags: Core/BagSlots.lua owns the hooks and addon
--     registration; the glow is the action button border texture on the
--     item button (OVERLAY sublevel 2, under the upgrade arrow and the search
--     overlay), in the theme's accent colour, pulsing unless ui.reduceMotion
--     is on. Glows and locks are
--     kept here by button; nothing is written into the button's table.
--   * Baganator and BagSmith: corner widgets, the lock bottom-left. The glow
--     is bottom-right in Baganator, bottom-left in BagSmith to leave its
--     protected stack count visible.
--   * EllesmereUI Bags: the full-slot glow is centred on _textOverlay or the
--     button; the lock is in the top-right corner, moved left of the quest
--     icon on a slot that shows one.
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
-- Bag addon corner widget id of the lock. A new id (it was polestar_kept_item):
-- Baganator and BagSmith place a widget at its default corner only once per
-- id, so players who had the old one get the lock bottom-left too (#2704).
local KEEP_WIDGET = "polestar_keep_lock"

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
local eGlows = setmetatable({}, { __mode = "k" }) -- EllesmereUI item button -> glow texture
local eLocks = setmetatable({}, { __mode = "k" }) -- EllesmereUI item button -> lock texture

local function lockFor(button, view)
	local cache = view == "ellesmere" and eLocks or locks
	local t = cache[button]
	if t then return t end
	local host = view == "ellesmere" and (button._textOverlay or button) or button
	t = host:CreateTexture(nil, "OVERLAY", nil, LAYER)
	t:SetSize(LOCK_SIZE, LOCK_SIZE)
	if view ~= "ellesmere" then t:SetPoint("BOTTOMLEFT", host, "BOTTOMLEFT", 1, 1) end
	t:SetTexture(LOCK)
	cache[button] = t
	return t
end

local function placeEllesmereLock(t, button, itemID)
	local host = button._textOverlay or button
	local Q = ns.QuestDB
	local beside = Q and Q.BagMarkShown and Q.BagMarkShown(itemID)
	t:ClearAllPoints()
	t:SetPoint("TOPRIGHT", host, "TOPRIGHT", beside and -17 or -1, -1)
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

local function glowFor(button, view)
	local cache = view == "ellesmere" and eGlows or glows
	local t = cache[button]
	if t then return t end
	local host = view == "ellesmere" and (button._textOverlay or button) or button
	t = host:CreateTexture(nil, "OVERLAY", nil, LAYER)
	local w, h = 37, 37
	if button.GetSize then w, h = button:GetSize() end
	t:SetSize((w or 37) * SCALE, (h or 37) * SCALE)
	t:SetPoint("CENTER", host, "CENTER", 0, 0)
	t:SetTexture(TEXTURE)
	if t.SetBlendMode then t:SetBlendMode("ADD") end
	paint(t)
	pulse(t)
	cache[button] = t
	return t
end

local function show(t)
	t:Show()
	if not t.pulse then return end
	if ns.Get("ui.reduceMotion") then
		t.pulse:Stop()
		-- A stopped alpha animation can leave the texture part-way through its bounce.
		if t.SetAlpha then t:SetAlpha(1) end
		return
	end
	if not t.pulse:IsPlaying() then t.pulse:Play() end
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
	local glowCache = view == "ellesmere" and eGlows or glows
	local lockCache = view == "ellesmere" and eLocks or locks
	local id = glowing() and itemID
	if id and wanted(id) then
		show(glowFor(button, view))
	elseif glowCache[button] then
		hide(glowCache[button])
	end
	if id and locked(id) then
		local lock = lockFor(button, view)
		if view == "ellesmere" then placeEllesmereLock(lock, button, id) end
		lock:Show()
	elseif lockCache[button] then
		lockCache[button]:Hide()
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
	-- BagSmith shares bottom-left: locked excludes wanted, so glow and lock never compete.
	Slots.Widget("step-glow", WIDGET, L["Polestar: step item"], showStepItem, makeStepItem, "bottom_right", "bottom_left")
	Slots.Widget("step-glow", KEEP_WIDGET, L["Polestar: kept for the guide"], showKeptItem, makeKeptItem, "bottom_left")
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
	if path == "ui.reduceMotion" or path == "ui" then BagGlow.Redraw() end
end)
ns.On("POLESTAR_HIDDEN", reset)

if ns.Theme and ns.Theme.OnChanged then
	ns.Theme.OnChanged(function()
		for _, t in pairs(glows) do paint(t) end
		for _, t in pairs(eGlows) do paint(t) end
		for t in pairs(widgets) do paint(t) end
	end)
end
