-- Make room in the quest log: a small window listing the quests in the log
-- that no open route needs (RoutePlan.Unneeded: no tab's route nor a dungeon
-- open in a tab hands them in, or grey), each with its reason (what it is
-- worth, RoutePlan.Worth, where known) and its own Abandon button. A press asks
-- through the game's own confirmation (Compat.AskAbandonQuest); nothing is
-- ever abandoned without it. Opened by the guide window's full-log notice
-- and menu ("Clean up quest log (N)"), the Options button and
-- /polestar questlog.
-- UI.ShowQuestRoom(), or SHOW_QUEST_ROOM from Core.
--
-- UI.ShowQuestRoom("carried"): "Finished quests you're still carrying"
-- (RoutePlan.Carried(true); the Make room list's own button switches to it
-- while it has any, and back): every finished quest in the log, each
-- with who takes it and where (RoutePlan.Ender) and what it gives now; a
-- grey one says so and keeps its Abandon button. "Guide me" opens a hand-in
-- guide for all of them (Lookup/Handins.lua, planner kind "carried", id
-- "log": grouped enders in an estimated travel order, unknown locations
-- kept for manual hand-in).
-- A quest kept for a later guide says so; choosing Guide me still includes
-- it, because this is the player's explicit all-finished-quests route.
-- UI.ShowQuestRoom("elsewhere"): the same list for only the finished quests
-- no open route hands in (RoutePlan.Carried), matching the guide window's
-- "to hand in elsewhere" row. Guide me still opens the all-ready guide.
--
-- The end of a leveling guide opens two more lists (the guide window's end
-- card, the guide-end window): UI.ShowQuestRoom("later", guideId), "Carried
-- to later guides" (Engine.CarriedQuests: each with the guide that hands it
-- in, no Abandon, kept), and UI.ShowQuestRoom("offroute", guideId), "Not
-- part of your route" (RoutePlan.OffRoute: quests no guide of the route
-- takes, works or hands in, each with its Abandon button, for the player to
-- keep or abandon).
--
-- The quests scroll in a list of at most MAX_ROWS rows, and never so tall
-- that the window passes the screen's edge (MARGIN clear above and below: a
-- full log of 40 at UI scale 1 on a 768-high screen): the title, the ✕,
-- the switch and Guide me stay in reach under it. Every row shows the
-- quest's tooltip on hover (UI.QuestTip, its second line under it), so a
-- title or a second line cut short reads whole there.
--
-- Built on first use; colours are Theme tokens only.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local WIDTH = 380
local PAD = 24
local HEAD_H = 56
local ROW_H = 36
local ROW_GAP = 6
local MAX_ROWS = 9 -- rows in view at most; more scroll
local MARGIN = 24 -- kept clear above and below the window on a short screen
local BUTTON_H = 28

local F

-- What a quest's hand-in status means for the player.
local WHY = {
	missed = L["The route passed its hand-in"],
	skipped = L["You skipped its hand-in"],
	unplanned = L["Not handed in on this route"],
	grey = L["Grey: no XP any more"],
}

local function build()
	F = CreateFrame("Frame", "PolestarQuestRoom", ns.UIParent)
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
	ns.DragWindow(head, F)
	F.Band = Theme.Band(head, "BACKGROUND", -5)
	F.Band:SetAllPoints(head)
	F.Band:SetTexCoord(Theme.BandCoords(WIDTH - 2, HEAD_H))
	F.Close = W.IconButton(head, "close", 28, L["Close"], function() F:Hide() end, 14)
	F.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -14)
	W.FrameClose(F, F.Close)
	F.Title = W.Text(head, "title", "text")
	F.Title:SetPoint("LEFT", head, "LEFT", PAD, 0)
	F.Title:SetPoint("RIGHT", F.Close, "LEFT", -8, 0)
	F.Title:SetJustifyH("LEFT")
	-- A long translation ("Finished quests you're still carrying" in Russian) takes a second line in the band.
	F.Title:SetWordWrap(true)
	F.Title:SetMaxLines(2)
	F.Title:SetText(L["Make room in your quest log"])

	F.Hint = W.Text(F, "note", "textDim")
	F.Hint:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -(HEAD_H + 12))
	F.Hint:SetWidth(WIDTH - PAD * 2)
	F.Hint:SetJustifyH("LEFT")
	F.Hint:SetWordWrap(true)

	-- The quests, in a list that scrolls when they don't fit (What's new's
	-- way): it spans to the window's right edge, so its bar sits in the margin
	-- beside the rows' Abandon buttons.
	F.List = W.Scroll(F)
	F.List.Child:SetWidth(WIDTH - PAD * 2)

	F.GuideMe = W.Button(F, L["Guide me"], function()
		if UI.GuideCarried() then F:Hide() end
	end, { height = 28 })
	F.GuideMe.psTip = L["Hand in your finished quests"]
	F.GuideMe.psTipLines = { L["Guide me opens a travel order for all finished quests in your log, including those kept for a later guide."] }
	F.GuideMe:Hide()
	-- Between the two lists: the finished quests while Make room is shown, and back.
	F.Switch = W.Button(F, "", function()
		UI.ShowQuestRoom(F.psMode ~= "carried" and F.psMode ~= "elsewhere" and "carried" or nil)
	end, { ghost = true, height = 28 })
	F.Switch:Hide()

	F.rows = {}
	F:SetScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.FAST, "out") end)
	ns.CloseOnEscape("PolestarQuestRoom")
	if ns.Gamepad and ns.Gamepad.Register then ns.Gamepad.Register(F, {}) end
end

-- A row: the quest's tooltip (UI.QuestTip), its lines under it (psTip, else
-- its second line; whole where the row cuts it short).
local function rowEnter(self)
	if self.psQuest then UI.QuestTip(self, self.psQuest, "ANCHOR_RIGHT", self.psTip or { self.Why:GetText() }, self.Title:GetText()) end
end

-- A Make room or Not part of your route row: its plain-word worth
-- (RoutePlan.Worth) on the row, else why the route leaves it; the tooltip
-- has both and what it gives now. -> row line, tooltip lines
local function worthWhy(quest, status)
	local P, _, worth, xp = ns.RoutePlan
	if P.Worth then _, worth, xp = P.Worth(quest) end
	local tip = { status }
	if worth and worth ~= status then tip[2] = worth end
	if xp and xp > 0 then tip[#tip + 1] = L["%s XP"]:format(ns.Thousands(xp)) end
	return worth or status, tip
end

local function row(i)
	local r = F.rows[i]
	if r then return r end
	r = CreateFrame("Frame", nil, F.List.Child)
	r:SetHeight(ROW_H)
	r:EnableMouse(true)
	r:SetScript("OnEnter", rowEnter)
	r:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	r.Title = W.Text(r, "label", "text")
	r.Title:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -2)
	r.Title:SetJustifyH("LEFT")
	r.Title:SetWordWrap(false)
	r.Why = W.Text(r, "note", "textDim")
	r.Why:SetPoint("TOPLEFT", r.Title, "BOTTOMLEFT", 0, -2)
	r.Why:SetJustifyH("LEFT")
	r.Why:SetWordWrap(false)
	r.Abandon = W.Button(r, L["Abandon"], function(self)
		if not ns.Compat.AskAbandonQuest(self.psQuest) then ns.Print(L["Abandon it from your quest log."]) end
	end, { ghost = true, danger = true, height = 24 })
	r.Abandon:SetPoint("RIGHT", r, "RIGHT", 0, 0)
	F.rows[i] = r
	return r
end

-- One row's second line in the "carried" list: who takes it in and where,
-- and what it gives now (or that it is grey).
local function carriedWhy(c)
	local e = ns.RoutePlan.Ender(c.quest)
	local where = e and (e.zone and L["%s, %s"]:format(e.name or "", e.zone) or e.name) or L["Where it is turned in is not known"]
	if c.grey then return L["Grey: no XP any more"] .. "  \194\183  " .. where end
	if c.xp and c.xp > 0 then return where .. "  \194\183  " .. L["%s XP"]:format(ns.Thousands(c.xp)) end
	return where
end

-- One row's second line in the "later" list: the guide that hands it in.
local function laterWhy(c)
	local later = c.guideId and ns.Guides.Get(c.guideId)
	return later and L["Handed in in %s"]:format(UI.GuideLabel(later)) or L["A later guide hands it in"]
end

-- The lists the guide's end opens (UI/GuideFrame.lua's end card, UI/GuideEnd.lua):
-- the quests a later guide hands in (Engine.CarriedQuests of the guide that
-- ended: keep them), and those no guide of the route uses (RoutePlan.OffRoute:
-- keep or abandon them). -> title, list, hint
local function endList(mode, id)
	local E = ns.Engine
	id = id or (E.GetGuide and E.GetGuide() or {}).id
	if mode == "later" then
		local list = id and E.CarriedQuests and E.CarriedQuests(id) or {}
		return L["Carried to later guides"], list,
			#list == 0 and L["No quest in your log waits for a later guide."] or L["A later guide of your route hands these in: keep them."]
	end
	local list = ns.RoutePlan.OffRoute(id)
	local hint
	if list == nil then
		hint = L["The route ahead isn't settled yet (a guide to choose or load), so it can't say which quests it leaves behind."]
	elseif #list == 0 then
		hint = L["Every quest in your log is part of your route."]
	else
		hint = L["No guide of your route takes, works or hands these in. Keep the ones you want; Abandon asks in the game's own window first."]
	end
	return L["Not part of your route"], list, hint
end

-- Fill the list from the quest log as it is now.
function UI.LayoutQuestRoom()
	if not (F and F:IsShown()) then return end
	local mode = F.psMode
	local elsewhere = mode == "elsewhere"
	local carried = mode == "carried" or elsewhere
	local ending = mode == "later" or mode == "offroute"
	local list
	if ending then
		local title, hint
		title, list, hint = endList(mode, F.psGuide)
		F.Title:SetText(title)
		F.Hint:SetText(hint)
	elseif carried then
		F.Title:SetText(L["Finished quests you're still carrying"])
		local waiting
		list, waiting = ns.RoutePlan.Carried(not elsewhere)
		if list == nil or (#list == 0 and (waiting or 0) > 0) then
			F.Hint:SetText(L["The route ahead isn't settled yet (a guide to choose or load), so it can't say which quests it leaves behind."])
		elseif elsewhere then
			F.Hint:SetText(#list == 0 and L["The route hands in every finished quest in your log."]
				or L["Finished, and the route ahead never hands these in: here is who takes each. Guide me leads you to them, nearest first. A grey one gives almost no XP any more: abandon it if you won't pass by."])
		elseif #list == 0 then
			F.Hint:SetText(L["No quests in your log are ready to hand in."])
		else
			F.Hint:SetText(L["Every finished quest in your log, including those on your route. Guide me estimates a travel order; quests with unknown locations stay listed for manual hand-in. A grey one gives almost no XP any more."])
		end
	else
		F.Title:SetText(L["Make room in your quest log"])
		list = ns.RoutePlan.Unneeded()
		if list == nil then
			F.Hint:SetText(L["The route ahead isn't settled yet (a guide to choose or load), so it can't say which quests it leaves behind."])
		elseif #list == 0 then
			F.Hint:SetText(L["The route hands in every quest in your log."])
		else
			F.Hint:SetText(L["The route doesn't need these: it never hands them in, or they give no XP any more. Abandon asks in the game's own window first."])
		end
	end
	local top = HEAD_H + 12 + F.Hint:GetStringHeight() + 12
	local rowW = WIDTH - PAD * 2
	local y, guided = 0, carried and list ~= nil and #list > 0
	for i, u in ipairs(list or {}) do
		local r = row(i)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", F.List.Child, "TOPLEFT", 0, -y)
		r:SetWidth(rowW)
		r.Title:SetText(u.title or ("#" .. u.quest))
		r.psTip = nil
		if mode == "later" then
			-- A later guide hands it in: kept, no Abandon.
			r.Why:SetText(laterWhy(u))
			r.Abandon:Hide()
		elseif mode == "offroute" then
			local why
			why, r.psTip = worthWhy(u.quest, u.ready and L["Finished: no guide of your route hands it in"] or L["Not in any guide of your route"])
			r.Why:SetText(why)
			r.Abandon:Show()
		elseif carried then
			local where = carriedWhy(u)
			if u.keptFor then
				local why = L["Kept for %s: the route hands it in there."]:format(u.keptFor)
				r.Why:SetText(why)
				r.psTip = { why, where }
			else
				r.Why:SetText(where)
			end
			r.Abandon:SetShown(u.grey)
		else
			local why
			if u.status == "grey" then why = WHY.grey else why, r.psTip = worthWhy(u.quest, WHY[u.status]) end
			r.Why:SetText(why)
			r.Abandon:Show()
		end
		-- Both lines to the Abandon button, or the row's end without it: cut short past it (the tooltip has them whole).
		local textW = rowW - (r.Abandon:IsShown() and (r.Abandon:GetWidth() + 8) or 0)
		r.Title:SetWidth(textW)
		r.Why:SetWidth(textW)
		r.Abandon.psQuest, r.psQuest = u.quest, u.quest
		r:Show()
		y = y + ROW_H + ROW_GAP
	end
	for i = #(list or {}) + 1, #F.rows do F.rows[i]:Hide() end
	-- Make room: every finished quest in the log, when there are any.
	local finished = not (carried or ending) and ns.RoutePlan.Carried(true) or nil
	local switch = carried or (finished ~= nil and #finished > 0)
	local foot = ((carried and guided) or switch) and (BUTTON_H + ROW_GAP) or 0
	-- The list: every row, at most MAX_ROWS of them in view, and no taller
	-- than the screen leaves room for (MARGIN above and below the window).
	local screen = UIParent:GetHeight() or 0
	local view = math.min(y, MAX_ROWS * (ROW_H + ROW_GAP))
	if screen > 0 then view = math.min(view, math.max(ROW_H + ROW_GAP, screen - MARGIN * 2 - top - foot - (PAD - 6))) end
	F.List:ClearAllPoints()
	F.List:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -top)
	F.List:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -top)
	F.List:SetHeight(math.max(1, view))
	F.List.Child:SetWidth(rowW)
	W.SetScrollContent(F.List, y, view)
	local under = top + view
	F.GuideMe:ClearAllPoints()
	F.GuideMe:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD, -under)
	F.GuideMe:SetShown(carried and guided)
	if switch then
		W.SetButtonText(F.Switch, carried and L["Make room in your quest log"] or L["Finished quests you're still carrying (%d)"]:format(#finished))
		F.Switch:ClearAllPoints()
		F.Switch:SetPoint("TOPLEFT", F, "TOPLEFT", PAD - 8, -under)
	end
	F.Switch:SetShown(switch)
	F:SetHeight(under + foot + PAD - 6)
end

-- mode: nil (make room in the quest log), "carried" (all ready), "elsewhere"
-- (the off-route finished subset), or the guide's end's
-- "later" and "offroute" (guideId: the guide that ended; nil: the active tab's).
function UI.ShowQuestRoom(mode, guideId)
	if not F then build() end
	F.psMode, F.psGuide = mode, guideId
	F:Show()
	F:Raise()
	UI.LayoutQuestRoom()
end

-- Guide me on the "carried" list, and the guide window's menu: the hand-in
-- guide for every finished quest in the log (Lookup planner kind
-- "carried", id "log"). -> its guide id, or nil with the reason in chat.
function UI.GuideCarried()
	return ns.Handins.Start()
end

ns.On("SHOW_QUEST_ROOM", function() UI.ShowQuestRoom() end)
ns.RegisterEvent("QUEST_LOG_UPDATE", function() UI.LayoutQuestRoom() end)
