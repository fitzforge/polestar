-- A quest mark on bag items a quest in your log still needs, so a Murloc Eye
-- is not deleted or sold before the hand-in. It reads the same per-item index
-- the item tooltip does (Q.ObjectivesForItem, quests in the log only), so the
-- mark goes once the quest is handed in or abandoned.
--
-- The client's bags only (qol.questBagMarks): each container frame's
-- UpdateItems is post-hooked on the frame itself, as Gear/Bags.lua does for
-- its arrows (ContainerFrameMixin's functions are copied onto each frame as it
-- is made). The mark is a texture on the item button, top-right, kept here by
-- button; nothing is written into the button's table.

local ADDON, ns = ...

local Q = ns.QuestDB
local type, ipairs, pcall = type, ipairs, pcall

local ICON = "Interface/GossipFrame/ActiveQuestIcon"
local SIZE = 16

local function isOn()
	return Q.IsRunning() and ns.Get("qol.questBagMarks") and true or false
end

-- Whether a quest in the log still asks for item `itemID`.
function Q.IsItemNeeded(itemID)
	return isOn() and (Q.ObjectivesForItem(itemID) ~= nil or Q.IsItemNeededAhead(itemID)) or false
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

-- Repaints the shown bags now.
function Q.RedrawBagMarks()
	hookBags()
	for _, f in ipairs(containerFrames()) do
		if hooked[f] and f:IsShown() then onUpdateItems(f) end
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
