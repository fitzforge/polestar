-- A line on the game's delete confirmation when the item on the cursor is one
-- a quest still needs (qol.questDeleteWarning): "Needed for: Stocking Jetsteam".
-- The delete itself is the game's: this only adds
-- text to the dialog it already shows.
--
-- StaticPopup_Show is post-hooked with hooksecurefunc, which never taints the
-- caller and cannot block or change the call; it runs after the dialog is up,
-- with the item still on the cursor (the dialog's accept deletes it, the
-- cancel puts it back). Only the four delete dialogs of the client's
-- GameDialogDefs.lua are looked at. The dialog's text is read and set through
-- its text region; nothing else of the dialog is touched.

local ADDON, ns = ...

local Q = ns.QuestDB
local L = ns.L
local type, pcall = type, pcall

local DELETE = { DELETE_ITEM = true, DELETE_GOOD_ITEM = true, DELETE_QUEST_ITEM = true, DELETE_GOOD_QUEST_ITEM = true }

local function isOn()
	return Q.IsRunning() and ns.Get("qol.questDeleteWarning") and true or false
end

local function cursorItem()
	local kind, id = GetCursorInfo()
	if kind == "item" and type(id) == "number" then return id end
	return nil
end

local function titlesFor(itemID)
	local out = {}
	local live = Q.ObjectivesForItem(itemID)
	for i = 1, live and #live or 0 do
		local title = live[i].entry and live[i].entry.title
		if title then out[#out + 1] = title end
	end
	if #out == 0 then
		local list = Q.ItemAheadList(itemID)
		for i = 1, list and #list or 0 do out[#out + 1] = Q.GetQuestTitle(list[i].q) or tostring(list[i].q) end
	end
	return out
end

local function warn(which)
	if not (DELETE[which] and isOn()) then return end
	local id = cursorItem()
	if not (id and Q.IsItemNeeded(id)) then return end
	local dialog = StaticPopup_FindVisible and StaticPopup_FindVisible(which)
	local text = dialog and (dialog.text or dialog.Text)
	if not (text and text.GetText and text.SetText) then return end
	local titles = titlesFor(id)
	if #titles == 0 then return end
	local height, textHeight = dialog:GetHeight(), text:GetStringHeight()
	text:SetText((text:GetText() or "") .. "\n\n|cffffd100" .. L["Needed for:"] .. " " .. table.concat(titles, ", ") .. "|r")
	if type(dialog.Resize) == "function" then pcall(dialog.Resize, dialog) end
	if StaticPopup_Resize and dialog:GetHeight() == height then pcall(StaticPopup_Resize, dialog, which) end
	-- The client's own resize may not run for text set after the dialog was
	-- laid out: grow it by the lines added, so the buttons stay inside.
	if dialog:GetHeight() == height then
		dialog:SetHeight(height + math.max(0, text:GetStringHeight() - textHeight))
	end
end

Q.AddDeleteWarning = warn

if hooksecurefunc and StaticPopup_Show then
	hooksecurefunc("StaticPopup_Show", function(which) ns.SafeCall(warn, which) end)
end
