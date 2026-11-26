-- Polestar.BagSlots: the one owner of bag slot hooks and addon registration,
-- so modules paint their marks instead of each hooking the same bags.
-- Contract: docs/ARCHITECTURE.md, "Core services: Data, Hooks, Search".
--
--   BagSlots.Painter(owner, fn(button, view, itemID, link))
--       view "client" (anchor on the button) or "ellesmere" (anchor on
--       button._textOverlay or button); itemID and link nil on an empty slot.
--       One painter per owner, replaced in place, in registration order, each
--       through ns.SafeCall so one module's error never costs another its marks.
--   BagSlots.Widget(owner, id, label, show, make, corner)
--       show(details) -> bool; make(button) -> region; corner top_left,
--       top_right or bottom_left. Not bottom_right: both addons draw the stack
--       count there, and Baganator shows one widget per corner (#4207).
--       Registered once per addon, present now or on its ADDON_LOADED.
--   BagSlots.Redraw(owner) -- repaint that owner's shown slots and active widgets
--       (EllesmereUI Bags' shown slots with every painter)
--
-- Client mechanisms:
--   * ContainerFrameMixin's functions are copied onto each frame as it is
--     made, so hook UpdateItems on the frame itself: the bag frames in
--     ContainerFrameContainer.ContainerFrames and ContainerFrameCombinedBags.
--   * Baganator and BagSmith place corner widgets; BagSmith also takes
--     { listRows = true } so its list view gets the same marks.
--   * EllesmereUI Bags replaces the client's bag frames. It calls
--     EUI_Bags.RegisterItemOverlayIcon(name, fn(button, data)), with
--     data = { bag, slot, info, itemLink } valid during the call only.
--     Re-mark shown slots from the link last painted so its window is not
--     rebuilt (a full RefreshInventory), in or out of combat.

local ADDON, ns = ...

local Slots = {}
ns.BagSlots = Slots
local type, pairs, ipairs, pcall, tonumber = type, pairs, ipairs, pcall, tonumber
local painters, specs = {}, {}
local hooked = setmetatable({}, { __mode = "k" })
local painted = setmetatable({}, { __mode = "k" })
local registered = { Baganator = {}, BagSmith = {} }

function Slots.Painter(owner, fn)
	for _, entry in ipairs(painters) do
		if entry.owner == owner then entry.fn = fn; return end
	end
	painters[#painters + 1] = { owner = owner, fn = fn }
end

local function idOfLink(link)
	return type(link) == "string" and tonumber(link:match("item:(%d+)")) or nil
end

local function readable(link)
	if ns.Compat then return ns.Compat.Readable(link) end
	return link
end

local function bagLink(bag, slot)
	local C = C_Container
	if not (C and type(C.GetContainerItemLink) == "function") then return nil end
	return readable(C.GetContainerItemLink(bag, slot))
end

local function clientItem(button)
	if type(button.GetBagID) ~= "function" or type(button.GetID) ~= "function" then return nil end
	local ok, bag = pcall(button.GetBagID, button)
	if not (ok and type(bag) == "number") then return nil end
	local slot = button:GetID()
	local link = bagLink(bag, slot)
	local C, id = C_Container
	if C and type(C.GetContainerItemID) == "function" then id = C.GetContainerItemID(bag, slot) end
	if not id and C and type(C.GetContainerItemInfo) == "function" then
		local info = C.GetContainerItemInfo(bag, slot)
		id = type(info) == "table" and info.itemID or nil
	end
	return id or idOfLink(link), link
end

local function paintSlot(button, view, id, link, owner)
	for _, entry in ipairs(painters) do
		if owner == nil or entry.owner == owner then ns.SafeCall(entry.fn, button, view, id, link) end
	end
end

local function updateFrame(frame, owner)
	if type(frame.EnumerateValidItems) ~= "function" then return end
	for _, button in frame:EnumerateValidItems() do
		local id, link = clientItem(button)
		paintSlot(button, "client", id, link, owner)
	end
end

local function onUpdateItems(frame)
	updateFrame(frame)
end

local function containerFrames()
	local out = {}
	local list = ContainerFrameContainer and ContainerFrameContainer.ContainerFrames
	if type(list) == "table" then
		for _, frame in ipairs(list) do out[#out + 1] = frame end
	end
	if ContainerFrameCombinedBags then out[#out + 1] = ContainerFrameCombinedBags end
	return out
end

local function hook()
	if not hooksecurefunc then return end
	for _, frame in ipairs(containerFrames()) do
		if not hooked[frame] and type(frame.UpdateItems) == "function" then
			hooksecurefunc(frame, "UpdateItems", onUpdateItems)
			hooked[frame] = true
		end
	end
end

local function paintEllesmere(button, details)
	local link
	if type(details) == "table" then
		link = readable(details.itemLink)
		if not link and details.bag and details.slot and details.slot > 0 then link = bagLink(details.bag, details.slot) end
	end
	painted[button] = link or false
	paintSlot(button, "ellesmere", idOfLink(link), link)
end

local ellesmere = false
local function registerEllesmere()
	if ellesmere then return true end
	local B = _G.EUI_Bags
	if not (type(B) == "table" and type(B.RegisterItemOverlayIcon) == "function") then return false end
	ellesmere = true
	B.RegisterItemOverlayIcon("Polestar", paintEllesmere)
	return true
end

local function onEllesmereLoaded(_, name)
	if name == "EllesmereUIBags" and registerEllesmere() then
		ns.UnregisterEvent("ADDON_LOADED", onEllesmereLoaded)
	end
end

local function cornerAPI(name)
	local B = _G[name]
	local API = type(B) == "table" and B.API
	if type(API) == "table" and API.RegisterCornerWidget then return API end
	return nil
end

local function registerSpec(API, name, spec)
	API.RegisterCornerWidget(spec.label, spec.id, function(_, details)
		return spec.show(details)
	end, spec.make, { corner = spec.corner, priority = 1 }, nil, name == "BagSmith" and { listRows = true } or nil)
	registered[name][spec.id] = true
end

local function registerWith(name)
	local API = cornerAPI(name)
	if not API then return end
	for _, spec in ipairs(specs) do
		if not registered[name][spec.id] then registerSpec(API, name, spec) end
	end
end

function Slots.Widget(owner, id, label, show, make, corner)
	specs[#specs + 1] = { owner = owner, id = id, label = label, show = show, make = make, corner = corner }
	registerWith("Baganator")
	registerWith("BagSmith")
end

local function onAddonLoaded(_, name)
	if name ~= "Baganator" and name ~= "BagSmith" then return end
	registerWith(name)
end

local function activeWidgets(API, name, owner)
	for _, spec in ipairs(specs) do
		if spec.owner == owner and registered[name][spec.id]
			and (not API.IsCornerWidgetActive or API.IsCornerWidgetActive(spec.id)) then return true end
	end
	return false
end

local function refreshWidgets(name, owner)
	local API = cornerAPI(name)
	if not (API and API.RequestItemButtonsRefresh and activeWidgets(API, name, owner)) then return end
	if name == "BagSmith" then API.RequestItemButtonsRefresh(); return end
	local B = _G[name]
	local reasons = B.Constants and B.Constants.RefreshReason
	API.RequestItemButtonsRefresh(reasons and reasons.ItemWidgets and { reasons.ItemWidgets } or nil)
end

function Slots.Redraw(owner)
	hook()
	for _, frame in ipairs(containerFrames()) do
		if hooked[frame] and frame:IsShown() then updateFrame(frame, owner) end
	end
	-- EllesmereUI slots repaint every painter: the keep lock there moves
	-- aside for the quest icon, so a quest mark change moves it too.
	for button, link in pairs(painted) do
		if button:IsVisible() then paintSlot(button, "ellesmere", idOfLink(link), link or nil) end
	end
	refreshWidgets("Baganator", owner)
	refreshWidgets("BagSmith", owner)
end

hook()
ns.OnLogin(hook)
registerWith("Baganator")
registerWith("BagSmith")
ns.RegisterEvent("ADDON_LOADED", onAddonLoaded)
if not registerEllesmere() then ns.RegisterEvent("ADDON_LOADED", onEllesmereLoaded) end
