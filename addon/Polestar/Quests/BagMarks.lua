-- A quest mark on bag items a quest still needs, so a Murloc Eye is not
-- deleted or sold before the hand-in: a quest in your log (Q.ObjectivesForItem,
-- the index the item tooltip reads) or one the running guide has ahead that you
-- have not accepted (Q.IsItemNeededAhead). It goes once the quest is handed in.
-- Abandoning a quest keeps it, as the quest is ahead in the guide again.
-- So does a guide that has gone past every step for a quest you never accepted:
-- nothing ahead needs the item, and the mark clears.
-- A red border suggests a leftover only when every known quest tied to that
-- quest-class item was handed in and none is repeatable or kept by the guide.
--
-- Four bag views (qol.questBagMarks, which hides only the marks: the sale,
-- delete and buyback guards ask Q.IsItemNeeded whatever it says), the way
-- Gear/Bags.lua draws its arrows: Core/BagSlots.lua owns the hooks and addon
-- registration. In the client's bags the mark is a texture on the item
-- button, top-right, kept here by button, nothing written into the button's
-- table; Baganator and BagSmith, as corner widgets; and EllesmereUI Bags,
-- as an item overlay painter, top-right on _textOverlay or the button.
--
--   Q.IsItemNeeded(itemID) -> bool          -- also used by the item guards
--   Q.IsObsoleteQuestItem(itemID) -> bool   -- a leftover suggestion only
--   Q.BagMarkShown(itemID) -> bool          -- the quest icon shows on the item's slot
--   Q.RedrawBagMarks()                      -- repaint the shown bags now

local ADDON, ns = ...

local Q = ns.QuestDB
local Slots = ns.BagSlots
local type, tonumber = type, tonumber

local ICON = "Interface/GossipFrame/ActiveQuestIcon"
local SIZE = 16
local BORDER = "Interface\\Buttons\\UI-ActionButton-Border"
local BORDER_SCALE = 1.9

-- Bag visuals only (none while Polestar is hidden); guards still ask Q.IsItemNeeded.
local function isOn()
	return Q.IsRunning() and ns.Get("qol.questBagMarks") and not ns.Hidden() and true or false
end

-- Whether a quest in the log, or one ahead in the running guide, still asks
-- for item `itemID`. Needs only the quest database: the marks' setting does
-- not turn off the other guards that ask this.
function Q.IsItemNeeded(itemID)
	return Q.IsRunning() and (Q.ObjectivesForItem(itemID) ~= nil or Q.IsItemNeededAhead(itemID)) or false
end

function Q.BagMarkShown(itemID)
	return itemID ~= nil and isOn() and Q.IsItemNeeded(itemID) or false
end

-- A suggestion only: the client cannot prove an item has no other use.
function Q.IsObsoleteQuestItem(itemID)
	local client = ns.QoL and ns.QoL.Client
	if not (itemID and Q.IsRunning() and client and client.ItemClass) then return false end
	if client.ItemClass(itemID) ~= client.CLASS_QUEST or Q.IsItemNeeded(itemID) then return false end
	local kept = ns.QoL and ns.QoL.Kept
	if kept and kept(itemID) then return false end
	local log = C_QuestLog
	if not (log and log.IsOnQuest and log.IsQuestFlaggedCompleted and log.IsRepeatableQuest) then return false end
	local quests = Q.ItemQuests(itemID)
	if not quests then return false end
	for i = 1, #quests do
		local q = quests[i]
		if log.IsOnQuest(q) or not log.IsQuestFlaggedCompleted(q) or log.IsRepeatableQuest(q) ~= false then return false end
	end
	return true
end

local marks = setmetatable({}, { __mode = "k" }) -- item button -> texture
local borders = setmetatable({}, { __mode = "k" })

local function borderFor(button, cache, parent)
	local t = cache[button]
	if t then return t end
	t = (parent or button):CreateTexture(nil, "OVERLAY", nil, 2)
	local w, h = button:GetSize()
	t:SetSize((w and w > 0 and w or 37) * BORDER_SCALE, (h and h > 0 and h or 37) * BORDER_SCALE)
	t:SetPoint("CENTER", button, "CENTER")
	t:SetTexture(BORDER)
	t:SetVertexColor(1, 0.12, 0.12, 1)
	t:SetBlendMode("ADD")
	cache[button] = t
	return t
end

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

---------------------------------------------------------------------------
-- Bag addons (as Gear/Bags.lua draws its arrows there)
---------------------------------------------------------------------------

local function needed(link)
	local id = type(link) == "string" and tonumber(link:match("item:(%d+)"))
	return id and Q.IsItemNeeded(id) or false
end

-- Baganator and BagSmith place the quest icon and leftover border as corner widgets.
local WIDGET = "polestar_quest_needed"
local RED_WIDGET = "polestar_quest_leftover"
local widgetBorders = setmetatable({}, { __mode = "k" })

local function showNeeded(details)
	return isOn() and needed(type(details) == "table" and details.itemLink or nil)
end

local function makeNeeded(button)
	local t = button:CreateTexture(nil, "OVERLAY")
	t:SetSize(SIZE, SIZE)
	t:SetTexture(ICON)
	return t
end

local function showLeftover(details)
	return isOn() and type(details) == "table" and Q.IsObsoleteQuestItem(details.itemID) or false
end

local function makeLeftover(button)
	local frame = CreateFrame("Frame")
	frame:SetParent(button)
	frame:SetSize(1, 1)
	borderFor(button, widgetBorders, frame)
	return frame
end

-- EllesmereUI Bags replaces the client's bag frames and runs the painters
-- through Core/BagSlots.lua on every slot it paints. The mark sits on the
-- button's _textOverlay, top-right.
local eMarks = setmetatable({}, { __mode = "k" }) -- item button -> texture
local eBorders = setmetatable({}, { __mode = "k" })

local function ellesmereMark(button)
	local t = eMarks[button]
	if t then return t end
	local host = button._textOverlay or button
	t = host:CreateTexture(nil, "OVERLAY", nil, 3)
	t:SetSize(SIZE, SIZE)
	t:SetPoint("TOPRIGHT", host, "TOPRIGHT", 0, 0)
	t:SetTexture(ICON)
	eMarks[button] = t
	return t
end

local function paintBagSlot(button, view, itemID, link)
	local id = isOn() and itemID
	local icons = view == "ellesmere" and eMarks or marks
	local edges = view == "ellesmere" and eBorders or borders
	if id and Q.IsItemNeeded(id) then
		local mark = view == "ellesmere" and ellesmereMark(button) or markFor(button)
		mark:Show()
	elseif icons[button] then
		icons[button]:Hide()
	end
	if id and Q.IsObsoleteQuestItem(id) then
		borderFor(button, edges):Show()
	elseif edges[button] then
		edges[button]:Hide()
	end
end

if Slots then
	Slots.Painter("quest-marks", paintBagSlot)
	Slots.Widget("quest-marks", WIDGET, ns.L["Polestar quest items"], showNeeded, makeNeeded, "top_right")
	-- The leftover's full-slot border shares top-left with the upgrade arrow: a quest-class item is never a gear upgrade.
	Slots.Widget("quest-marks", RED_WIDGET, ns.L["Polestar quest leftovers"], showLeftover, makeLeftover, "top_left")
end

local tooltipOn = false
local function onItemTooltip(tt, _, itemID)
	if isOn() and Q.IsObsoleteQuestItem(itemID) then
		ns.Hooks.AddLine(tt, ns.L["Related quests completed (likely safe to delete)"])
	end
end

local function refreshTooltip()
	local H = ns.Hooks
	if not (H and H.ItemLines) then return end
	local on = isOn()
	if on == tooltipOn then return end
	tooltipOn = on
	H.ItemLines("quest-leftovers", on and onItemTooltip or nil)
end

-- Repaints the shown bags now.
function Q.RedrawBagMarks()
	refreshTooltip()
	if Slots then Slots.Redraw("quest-marks") end
end

ns.On("QUESTDB_UPDATED", Q.RedrawBagMarks)
ns.On("QUESTDB_STARTED", Q.RedrawBagMarks)
ns.On("STEP_CHANGED", Q.RedrawBagMarks)
ns.On("GUIDE_CHANGED", Q.RedrawBagMarks)
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.questBagMarks" or path == "qol.questDB" or path == "qol" or path == "" then Q.RedrawBagMarks() end
end)
ns.On("POLESTAR_HIDDEN", Q.RedrawBagMarks)
