-- Make room in the quest log: a small window listing the quests in the log
-- that the selected route never hands in (RoutePlan.Unneeded), each with its
-- own Abandon button. A press asks through the game's own confirmation
-- (Compat.AskAbandonQuest); nothing is ever abandoned without it. Opened by
-- the guide window's full-log notice and /polestar questlog.
-- UI.ShowQuestRoom(), or SHOW_QUEST_ROOM from Core.
--
-- Built on first use; colours are Theme tokens only.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local WIDTH = 380
local PAD = 24
local HEAD_H = 56
local ROW_H = 36

local F

-- What a quest's hand-in status means for the player.
local WHY = {
	missed = L["The route passed its hand-in"],
	skipped = L["You skipped its hand-in"],
	unplanned = L["Not handed in on this route"],
}

local function build()
	F = CreateFrame("Frame", "PolestarQuestRoom", UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(WIDTH)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 120)
	F:Hide()
	Theme.Skin(F, "window")

	local head = CreateFrame("Frame", nil, F)
	head:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	head:SetHeight(HEAD_H)
	head:EnableMouse(true)
	head:RegisterForDrag("LeftButton")
	head:SetScript("OnDragStart", function() F:StartMoving() end)
	head:SetScript("OnDragStop", function() F:StopMovingOrSizing() end)
	F.Band = Theme.Band(head, "BACKGROUND", -5)
	F.Band:SetAllPoints(head)
	F.Band:SetTexCoord(Theme.BandCoords(WIDTH - 2, HEAD_H))
	F.Close = W.IconButton(head, "close", 28, L["Close"], function() F:Hide() end, 14)
	F.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -14)
	F.Title = W.Text(head, "title", "text")
	F.Title:SetPoint("LEFT", head, "LEFT", PAD, 0)
	F.Title:SetPoint("RIGHT", F.Close, "LEFT", -8, 0)
	F.Title:SetJustifyH("LEFT")
	F.Title:SetWordWrap(false)
	F.Title:SetText(L["Make room in your quest log"])

	F.Hint = W.Text(F, "note", "textDim")
	F.Hint:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -(HEAD_H + 12))
	F.Hint:SetWidth(WIDTH - PAD * 2)
	F.Hint:SetJustifyH("LEFT")
	F.Hint:SetWordWrap(true)

	F.rows = {}
	F:SetScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.FAST, "out") end)
	ns.CloseOnEscape("PolestarQuestRoom")
	if ns.Gamepad and ns.Gamepad.Register then ns.Gamepad.Register(F, {}) end
end

local function row(i)
	local r = F.rows[i]
	if r then return r end
	r = CreateFrame("Frame", nil, F)
	r:SetHeight(ROW_H)
	r.Title = W.Text(r, "label", "text")
	r.Title:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -2)
	r.Title:SetJustifyH("LEFT")
	r.Title:SetWordWrap(false)
	r.Why = W.Text(r, "note", "textDim")
	r.Why:SetPoint("TOPLEFT", r.Title, "BOTTOMLEFT", 0, -2)
	r.Why:SetJustifyH("LEFT")
	r.Abandon = W.Button(r, L["Abandon"], function(self)
		if not ns.Compat.AskAbandonQuest(self.psQuest) then ns.Print(L["Abandon it from your quest log."]) end
	end, { ghost = true, danger = true, height = 24 })
	r.Abandon:SetPoint("RIGHT", r, "RIGHT", 0, 0)
	r.Title:SetPoint("RIGHT", r.Abandon, "LEFT", -8, 0)
	F.rows[i] = r
	return r
end

-- Fill the list from the quest log as it is now.
function UI.LayoutQuestRoom()
	if not (F and F:IsShown()) then return end
	local list = ns.RoutePlan.Unneeded()
	if list == nil then
		F.Hint:SetText(L["The route ahead isn't settled yet (a guide to choose or load), so it can't say which quests it leaves behind."])
	elseif #list == 0 then
		F.Hint:SetText(L["The route hands in every quest in your log."])
	else
		F.Hint:SetText(L["The route never hands these in. Abandon asks in the game's own window first."])
	end
	local y = HEAD_H + 12 + F.Hint:GetStringHeight() + 12
	for i, u in ipairs(list or {}) do
		local r = row(i)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -y)
		r:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD, -y)
		r.Title:SetText(u.title or ("#" .. u.quest))
		r.Why:SetText(WHY[u.status])
		r.Abandon.psQuest = u.quest
		r:Show()
		y = y + ROW_H + 6
	end
	for i = #(list or {}) + 1, #F.rows do F.rows[i]:Hide() end
	F:SetHeight(y + PAD - 6)
end

function UI.ShowQuestRoom()
	if not F then build() end
	F:Show()
	UI.LayoutQuestRoom()
end

ns.On("SHOW_QUEST_ROOM", function() UI.ShowQuestRoom() end)
ns.RegisterEvent("QUEST_LOG_UPDATE", function() UI.LayoutQuestRoom() end)
