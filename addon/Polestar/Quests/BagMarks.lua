-- A quest mark on bag items a quest still needs, so a Murloc Eye is not
-- deleted or sold before the hand-in: a quest in your log (Q.ObjectivesForItem,
-- the index the item tooltip reads) or one the running guide has ahead that you
-- have not accepted (Q.IsItemNeededAhead). It goes once the quest is handed in.
-- Abandoning a quest keeps it, as the quest is ahead in the guide again.
-- So does a guide that has gone past every step for a quest you never accepted:
-- nothing ahead needs the item, and the mark clears.
--
-- Three bag views (qol.questBagMarks, which hides only the marks: the sale,
-- delete and buyback guards ask Q.IsItemNeeded whatever it says), the way
-- Gear/Bags.lua draws its arrows: the client's bags, where each container
-- frame's UpdateItems is
-- post-hooked on the frame itself (ContainerFrameMixin's functions are copied
-- onto each frame as it is made) and the mark is a texture on the item
-- button, top-right, kept here by button, nothing written into the button's
-- table; Baganator, as a corner widget; and EllesmereUI Bags, as an item
-- overlay painter.

local ADDON, ns = ...

local Q = ns.QuestDB
local type, pairs, ipairs, pcall, tonumber = type, pairs, ipairs, pcall, tonumber

local ICON = "Interface/GossipFrame/ActiveQuestIcon"
local SIZE = 16

local function isOn()
	return Q.IsRunning() and ns.Get("qol.questBagMarks") and true or false
end

-- Whether a quest in the log, or one ahead in the running guide, still asks
-- for item `itemID`. Needs only the quest database: the marks' setting does
-- not turn off the other guards that ask this.
function Q.IsItemNeeded(itemID)
	return Q.IsRunning() and (Q.ObjectivesForItem(itemID) ~= nil or Q.IsItemNeededAhead(itemID)) or false
end

local marks = setmetatable({}, { __mode = "k" }) -- item button -> texture

local function markFor(button)
	local t = marks[button]
	if t then return t end
	t = button:CreateTexture(nil, "OVERLAY", nil, 3)
	t:SetSize(SIZE, SIZE)
	t:SetPoint("TOPRIGHT", button, "TOPRIGHT", 0, 0)
	t:SetTexture(ICON)
	marks[button] = t
	return t
end

local function itemOf(button)
	local ok, bag = pcall(button.GetBagID, button)
	if not (ok and type(bag) == "number") then return nil end
	local C = C_Container
	if not C then return nil end
	local slot = button:GetID()
	if C.GetContainerItemID then return C.GetContainerItemID(bag, slot) end
	local info = C.GetContainerItemInfo and C.GetContainerItemInfo(bag, slot)
	return type(info) == "table" and info.itemID or nil
end

local function updateFrame(frame)
	if type(frame.EnumerateValidItems) ~= "function" then return end
	local on = isOn()
	for _, button in frame:EnumerateValidItems() do
		local id = on and itemOf(button)
		if id and Q.IsItemNeeded(id) then
			markFor(button):Show()
		elseif marks[button] then
			marks[button]:Hide()
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

---------------------------------------------------------------------------
-- Baganator and EllesmereUI Bags (as Gear/Bags.lua draws its arrows there)
---------------------------------------------------------------------------

local function needed(link)
	local id = type(link) == "string" and tonumber(link:match("item:(%d+)"))
	return id and Q.IsItemNeeded(id) or false
end

-- Baganator: a corner widget, top-right, which it hides and places itself.
local WIDGET = "polestar_quest_needed"
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
	API.RegisterCornerWidget(ns.L["Polestar quest items"], WIDGET, function(_, details)
		return isOn() and needed(type(details) == "table" and details.itemLink or nil)
	end, function(button)
		local t = button:CreateTexture(nil, "OVERLAY")
		t:SetSize(SIZE, SIZE)
		t:SetTexture(ICON)
		return t
	end, { corner = "top_right", priority = 1 })
	return true
end

local function onAddonLoaded(_, name)
	if name == "Baganator" and registerBaganator() then
		ns.UnregisterEvent("ADDON_LOADED", onAddonLoaded)
	end
end

if not registerBaganator() then ns.RegisterEvent("ADDON_LOADED", onAddonLoaded) end

-- EllesmereUI Bags replaces the client's bag frames and runs the painters
-- registered with EUI_Bags.RegisterItemOverlayIcon(name, fn(button, data)) on
-- every slot it paints. The mark sits on the button's _textOverlay, top-right.
local ELLESMERE = "PolestarQuestItems"
local ellesmere = false
local eMarks = setmetatable({}, { __mode = "k" }) -- item button -> texture
local painted = setmetatable({}, { __mode = "k" }) -- item button -> link it last painted (false: none)

local function ellesmereAPI()
	local B = _G.EUI_Bags
	if type(B) == "table" and type(B.RegisterItemOverlayIcon) == "function" then return B end
	return nil
end

local function markEllesmere(button, link)
	local t = eMarks[button]
	if link and isOn() and needed(link) then
		if not t then
			local host = button._textOverlay or button
			t = host:CreateTexture(nil, "OVERLAY", nil, 3)
			t:SetSize(SIZE, SIZE)
			t:SetPoint("TOPRIGHT", host, "TOPRIGHT", 0, 0)
			t:SetTexture(ICON)
			eMarks[button] = t
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
		if not link and data.bag and data.slot and data.slot > 0 and C_Container and C_Container.GetContainerItemLink then
			link = C_Container.GetContainerItemLink(data.bag, data.slot)
		end
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

-- Repaints the shown bags now.
function Q.RedrawBagMarks()
	hookBags()
	for _, f in ipairs(containerFrames()) do
		if hooked[f] and f:IsShown() then onUpdateItems(f) end
	end
	for button, link in pairs(painted) do
		if button:IsVisible() then markEllesmere(button, link or nil) end
	end
	local API = baganator and baganatorAPI()
	if API and API.RequestItemButtonsRefresh and (not API.IsCornerWidgetActive or API.IsCornerWidgetActive(WIDGET)) then
		local reasons = Baganator.Constants and Baganator.Constants.RefreshReason
		API.RequestItemButtonsRefresh(reasons and reasons.ItemWidgets and { reasons.ItemWidgets } or nil)
	end
end

hookBags()
ns.OnLogin(hookBags)
ns.On("QUESTDB_UPDATED", Q.RedrawBagMarks)
ns.On("QUESTDB_STARTED", Q.RedrawBagMarks)
ns.On("STEP_CHANGED", Q.RedrawBagMarks)
ns.On("GUIDE_CHANGED", Q.RedrawBagMarks)
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.questBagMarks" or path == "qol.questDB" or path == "qol" or path == "" then Q.RedrawBagMarks() end
end)
