-- Upgrade arrows on bag items: the quest reward panel's green arrow
-- (QoL/Rewards.lua) on every item in the bags that Gear.IsUpgrade calls an
-- upgrade, so the bags show at a glance what the tooltip's comparison line
-- (Gear/Tooltip.lua) says on hover (gear.bagArrows, on by default; nothing
-- with gear advice off, or with gear.hideForPawn on and Pawn installed). An
-- item that fits an empty slot and is worth nothing under the weights, but no
-- loss, gets the arrow too (Gear.FillsEmptySlot), as the tooltip's "upgrade
-- (empty slot)" says. The verdict is this character's.
--
--   Gear.Bags.IsUpgrade(link) -> bool   -- the verdict an arrow shows
--   Gear.Bags.Redraw()                  -- repaint the shown bags now
--
-- Three bag views:
--   * The client's bags (Blizzard_UIPanels_Game Mainline ContainerFrame.lua,
--     which Forever loads): each container frame's UpdateItems is post-hooked
--     on the frame itself (ContainerFrameMixin's functions are copied onto
--     each frame as it is made, so a hook on the mixin would miss them): the
--     bag frames (ContainerFrameContainer.ContainerFrames) and the combined
--     backpack (ContainerFrameCombinedBags). The client runs UpdateItems once
--     a bag's items have loaded, on BAG_UPDATE and as a bag opens. The arrow
--     is a texture on the item button (the gamepad interface hooks only
--     CreateFrame), in the top-left corner where the client's own, unused,
--     UpgradeIcon sits, at OVERLAY sublevel 3: over the icon overlays (1, 2),
--     under the search overlay (4), so a bag search dims it with the icon.
--     Nothing is written into the button's table: arrows are kept here by
--     button.
--   * Baganator: a corner widget (top-left, first), the way Baganator shows
--     Pawn's arrow; it hides and places the arrow itself. Registered as this
--     file loads when Baganator is in, else when it loads.
--   * EllesmereUI Bags (EllesmereUIBags), which replaces the client's bag
--     frames, so there is nothing to hook: it runs the painters registered with
--     EUI_Bags.RegisterItemOverlayIcon(name, fn(button, data)) on every slot it
--     paints (grid and list, bags, reagent bag and bank). The arrow is a texture
--     on the button's _textOverlay, bottom-left: top-left is where it shows
--     the item's level (btn.ItemLevelText), which the arrow would cover, and
--     bottom-right is its own Pawn arrow's. Registered as this file loads when
--     it is in, else when EllesmereUIBags loads. New verdicts re-mark the
--     shown slots from the link each last painted, so its window is not
--     rebuilt (a full RefreshInventory) for them, in or out of combat.
--
-- New verdicts (GEAR_UPDATED: equipment, bags, level, spec, item data, gear
-- settings) repaint the shown bags at most once every REDRAW seconds.

local ADDON, ns = ...

local Gear = ns.Gear
local L = ns.L

local type, pairs, ipairs, pcall = type, pairs, ipairs, pcall

local Bags = {}
Gear.Bags = Bags

local BADGE = 20 -- the arrow texture's size, as on the reward panel
local LAYER = 3 -- OVERLAY sublevel: over IconOverlay2, under searchOverlay
local REDRAW = 0.2 -- seconds: GEAR_UPDATED repaints at most this often
local WIDGET = "polestar_upgrade" -- Baganator corner widget id

-- Pawn draws its own arrows on bag items: gear.hideForPawn leaves the bags to
-- it while Pawn is installed and enabled.
function Bags.IsOn()
	if not (Gear.IsEnabled() and ns.Get("gear.bagArrows")) then return false end
	if ns.Get("gear.hideForPawn") and ns.Compat.AddOnPresent("Pawn") then return false end
	return true
end

function Bags.IsUpgrade(link)
	if type(link) ~= "string" or not Bags.IsOn() then return false end
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
local widgets = setmetatable({}, { __mode = "k" }) -- arrow textures made for Baganator

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

local function linkOf(button)
	local ok, bag = pcall(button.GetBagID, button)
	if not (ok and type(bag) == "number") then return nil end
	return Gear.Client.BagLink(bag, button:GetID())
end

local function updateFrame(frame)
	if type(frame.EnumerateValidItems) ~= "function" then return end
	local on = Bags.IsOn()
	for _, button in frame:EnumerateValidItems() do
		local up = on and Bags.IsUpgrade(linkOf(button))
		if up then
			arrowFor(button):Show()
		elseif arrows[button] then
			arrows[button]:Hide()
		end
	end
end

local function onUpdateItems(frame)
	ns.SafeCall(updateFrame, frame)
end

local function containerFrames()
	local out = {}
	local list = ContainerFrameContainer and ContainerFrameContainer.ContainerFrames
	if type(list) == "table" then
		for _, f in ipairs(list) do out[#out + 1] = f end
	end
	if ContainerFrameCombinedBags then out[#out + 1] = ContainerFrameCombinedBags end
	return out
end

local hooked = setmetatable({}, { __mode = "k" })

local function hookBags()
	if not hooksecurefunc then return end
	for _, f in ipairs(containerFrames()) do
		if not hooked[f] and type(f.UpdateItems) == "function" then
			hooksecurefunc(f, "UpdateItems", onUpdateItems)
			hooked[f] = true
		end
	end
end
hookBags()
ns.OnLogin(hookBags)

---------------------------------------------------------------------------
-- Baganator
---------------------------------------------------------------------------

local baganator = false

local function baganatorAPI()
	local B = _G.Baganator
	local API = type(B) == "table" and B.API
	if type(API) == "table" and API.RegisterCornerWidget then return API end
	return nil
end

local function registerBaganator()
	if baganator then return true end
	local API = baganatorAPI()
	if not API then return false end
	baganator = true
	API.RegisterCornerWidget(L["Polestar"], WIDGET, function(_, details)
		return Bags.IsUpgrade(type(details) == "table" and details.itemLink or nil)
	end, function(button)
		local t = button:CreateTexture(nil, "OVERLAY")
		t:SetSize(BADGE, BADGE)
		t:SetTexture(media())
		paint(t)
		widgets[t] = true
		return t
	end, { corner = "top_left", priority = 1 })
	return true
end

local function onAddonLoaded(_, name)
	if name == "Baganator" and registerBaganator() then
		ns.UnregisterEvent("ADDON_LOADED", onAddonLoaded)
	end
end

if not registerBaganator() then ns.RegisterEvent("ADDON_LOADED", onAddonLoaded) end

---------------------------------------------------------------------------
-- EllesmereUI Bags
---------------------------------------------------------------------------

local ELLESMERE = "Polestar" -- the painter's name in EUI_Bags.itemOverlayIcons
local ellesmere = false
local marks = setmetatable({}, { __mode = "k" }) -- item button -> arrow texture
local painted = setmetatable({}, { __mode = "k" }) -- item button -> link it last painted (false: none)

local function ellesmereAPI()
	local B = _G.EUI_Bags
	if type(B) == "table" and type(B.RegisterItemOverlayIcon) == "function" then return B end
	return nil
end

-- One slot's arrow from its link. EllesmereUI Bags reruns the painters each
-- time it fills a button, so the link last painted is the button's item.
local function markEllesmere(button, link)
	local t = marks[button]
	if link and Bags.IsUpgrade(link) then
		if not t then
			local host = button._textOverlay or button
			t = host:CreateTexture(nil, "OVERLAY", nil, LAYER)
			t:SetSize(BADGE, BADGE)
			t:SetPoint("BOTTOMLEFT", host, "BOTTOMLEFT", 0, 0)
			t:SetTexture(media())
			paint(t)
			marks[button] = t
		end
		t:Show()
	elseif t then
		t:Hide()
	end
end

-- data = { bag, slot, info, itemLink }, valid during the call only.
local function paintEllesmere(button, data)
	local link
	if type(data) == "table" then
		link = data.itemLink
		if not link and data.bag and data.slot and data.slot > 0 then link = Gear.Client.BagLink(data.bag, data.slot) end
	end
	painted[button] = link or false
	markEllesmere(button, link)
end

local function registerEllesmere()
	if ellesmere then return true end
	local B = ellesmereAPI()
	if not B then return false end
	ellesmere = true
	B.RegisterItemOverlayIcon(ELLESMERE, paintEllesmere)
	return true
end

local function onEllesmereLoaded(_, name)
	if name == "EllesmereUIBags" and registerEllesmere() then
		ns.UnregisterEvent("ADDON_LOADED", onEllesmereLoaded)
	end
end

if not registerEllesmere() then ns.RegisterEvent("ADDON_LOADED", onEllesmereLoaded) end

---------------------------------------------------------------------------
-- Keeping the arrows fresh
---------------------------------------------------------------------------

function Bags.Redraw()
	for _, f in ipairs(containerFrames()) do
		if hooked[f] and f:IsShown() then onUpdateItems(f) end
	end
	-- EllesmereUI Bags: re-mark the shown slots from the links they last
	-- painted (bags and bank alike), without making it rebuild its window.
	for button, link in pairs(painted) do
		if button:IsVisible() then markEllesmere(button, link or nil) end
	end
	local API = baganator and baganatorAPI()
	if API and API.RequestItemButtonsRefresh and (not API.IsCornerWidgetActive or API.IsCornerWidgetActive(WIDGET)) then
		local reasons = Baganator.Constants and Baganator.Constants.RefreshReason
		API.RequestItemButtonsRefresh(reasons and reasons.ItemWidgets and { reasons.ItemWidgets } or nil)
	end
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

if ns.Theme and ns.Theme.OnChanged then
	ns.Theme.OnChanged(function()
		for _, t in pairs(arrows) do paint(t) end
		for t in pairs(widgets) do paint(t) end
		for _, t in pairs(marks) do paint(t) end
	end)
end
