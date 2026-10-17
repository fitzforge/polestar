-- Upgrade arrows on bag items: the quest reward panel's green arrow
-- (QoL/Rewards.lua) on every item in the bags that Gear.IsUpgrade calls an
-- upgrade, so the bags show at a glance what the tooltip's comparison line
-- (Gear/Tooltip.lua) says on hover (gear.bagArrows, on by default; nothing
-- with gear advice off). The verdict is this character's, as on the tooltip.
--
--   Gear.Bags.IsUpgrade(link) -> bool   -- the verdict an arrow shows
--   Gear.Bags.Redraw()                  -- repaint the shown bags now
--
-- Two bag views:
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

function Bags.IsOn()
	return Gear.IsEnabled() and ns.Get("gear.bagArrows") and true or false
end

function Bags.IsUpgrade(link)
	if type(link) ~= "string" or not Bags.IsOn() then return false end
	return Gear.IsUpgrade(link) and true or false
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
-- Keeping the arrows fresh
---------------------------------------------------------------------------

function Bags.Redraw()
	for _, f in ipairs(containerFrames()) do
		if hooked[f] and f:IsShown() then onUpdateItems(f) end
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
	if C_Timer and C_Timer.After then C_Timer.After(REDRAW, run) else run() end
end

ns.On("GEAR_UPDATED", schedule)

if ns.Theme and ns.Theme.OnChanged then
	ns.Theme.OnChanged(function()
		for _, t in pairs(arrows) do paint(t) end
		for t in pairs(widgets) do paint(t) end
	end)
end
