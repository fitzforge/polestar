-- Make room in the quest log: a small window listing the quests in the log
-- that no open route needs (RoutePlan.Unneeded: no tab's route nor a dungeon
-- open in a tab hands them in, or grey), each with its reason and its own
-- Abandon button. A press asks
-- through the game's own confirmation (Compat.AskAbandonQuest); nothing is
-- ever abandoned without it. Opened by the guide window's full-log notice
-- and menu ("Clean up quest log (N)"), the Options button and
-- /polestar questlog.
-- UI.ShowQuestRoom(), or SHOW_QUEST_ROOM from Core.
--
-- UI.ShowQuestRoom("carried"): "Finished quests you're still carrying"
-- (RoutePlan.Carried; the Make room list's own button switches to it while
-- it has any, and back): the finished quests no open route hands in, each
-- with who takes it and where (RoutePlan.Ender) and what it gives now; a
-- grey one says so and keeps its Abandon button. "Guide me" opens a hand-in
-- guide for all of them (the Lookup planner kind "carried", id "log": one
-- stop per ender, nearest first from where the player stands).
--
-- The end of a leveling guide opens two more lists (the guide window's end
-- card, the guide-end window): UI.ShowQuestRoom("later", guideId), "Carried
-- to later guides" (Engine.CarriedQuests: each with the guide that hands it
-- in, no Abandon, kept), and UI.ShowQuestRoom("offroute", guideId), "Not
-- part of your route" (RoutePlan.OffRoute: quests no guide of the route
-- takes, works or hands in, each with its Abandon button, for the player to
-- keep or abandon).
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

	F.GuideMe = W.Button(F, L["Guide me"], function()
		local Lk = ns.Lookup
		local gid, why = Lk and Lk.Guide and Lk.Guide("carried", "log")
		if gid then
			F:Hide()
		elseif why == "tabs" then
			ns.Print(L["Six tabs is the limit. Close one to open another."])
		else
			ns.Print(L["None of these has a known place to hand it in."])
		end
	end, { height = 28 })
	F.GuideMe:Hide()
	-- Between the two lists: the finished quests while Make room is shown, and back.
	F.Switch = W.Button(F, "", function() UI.ShowQuestRoom(F.psMode ~= "carried" and "carried" or nil) end, { ghost = true, height = 28 })
	F.Switch:Hide()

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

-- One row's second line in the "carried" list: who takes it in and where,
-- and what it gives now (or that it is grey).
local function carriedWhy(c)
	local e = ns.RoutePlan.Ender(c.quest)
	local where = e and (e.zone and L["%s, %s"]:format(e.name or "", e.zone) or e.name) or L["Where it is turned in is not known"]
	if c.grey then return L["Grey: no XP any more"] .. "  \194\183  " .. where, e end
	if c.xp and c.xp > 0 then return where .. "  \194\183  " .. L["%d XP"]:format(c.xp), e end
	return where, e
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
	local carried = mode == "carried"
	local ending = mode == "later" or mode == "offroute"
	local list
	if ending then
		local title, hint
		title, list, hint = endList(mode, F.psGuide)
		F.Title:SetText(title)
		F.Hint:SetText(hint)
	elseif carried then
		F.Title:SetText(L["Finished quests you're still carrying"])
		list = ns.RoutePlan.Carried()
		if list == nil then
			F.Hint:SetText(L["The route ahead isn't settled yet (a guide to choose or load), so it can't say which quests it leaves behind."])
		elseif #list == 0 then
			F.Hint:SetText(L["The route hands in every finished quest in your log."])
		else
			F.Hint:SetText(L["Finished, and the route ahead never hands these in: here is who takes each. Guide me leads you to them, nearest first. A grey one gives almost no XP any more: abandon it if you won't pass by."])
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
	local y = HEAD_H + 12 + F.Hint:GetStringHeight() + 12
	local guided = false
	for i, u in ipairs(list or {}) do
		local r = row(i)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -y)
		r:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD, -y)
		r.Title:SetText(u.title or ("#" .. u.quest))
		if mode == "later" then
			-- A later guide hands it in: kept, no Abandon.
			r.Why:SetText(laterWhy(u))
			r.Abandon:Hide()
		elseif mode == "offroute" then
			r.Why:SetText(u.ready and L["Finished: no guide of your route hands it in"] or L["Not in any guide of your route"])
			r.Abandon:Show()
		elseif carried then
			local why, e = carriedWhy(u)
			r.Why:SetText(why)
			if e then guided = true end
			r.Abandon:SetShown(u.grey)
		else
			r.Why:SetText(WHY[u.status])
			r.Abandon:Show()
		end
		r.Abandon.psQuest = u.quest
		r:Show()
		y = y + ROW_H + 6
	end
	for i = #(list or {}) + 1, #F.rows do F.rows[i]:Hide() end
	F.GuideMe:ClearAllPoints()
	F.GuideMe:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD, -y)
	F.GuideMe:SetShown(carried and guided)
	-- Make room: the finished quests no route hands in, when there are any.
	local finished = not (carried or ending) and ns.RoutePlan.Carried() or nil
	local switch = carried or (finished ~= nil and #finished > 0)
	if switch then
		W.SetButtonText(F.Switch, carried and L["Make room in your quest log"] or L["Finished quests you're still carrying (%d)"]:format(#finished))
		F.Switch:ClearAllPoints()
		F.Switch:SetPoint("TOPLEFT", F, "TOPLEFT", PAD - 8, -y)
	end
	F.Switch:SetShown(switch)
	if (carried and guided) or switch then y = y + 28 + 6 end
	F:SetHeight(y + PAD - 6)
end

-- mode: nil (make room in the quest log), "carried", or the guide's end's
-- "later" and "offroute" (guideId: the guide that ended; nil: the active tab's).
function UI.ShowQuestRoom(mode, guideId)
	if not F then build() end
	F.psMode, F.psGuide = mode, guideId
	F:Show()
	F:Raise()
	UI.LayoutQuestRoom()
end

ns.On("SHOW_QUEST_ROOM", function() UI.ShowQuestRoom() end)
ns.RegisterEvent("QUEST_LOG_UPDATE", function() UI.LayoutQuestRoom() end)

-- The hand-in guide for RoutePlan.Carried's quests (Lookup planner kind
-- "carried", id "log"): one step per ender (RoutePlan.Ender) holding every
-- quest it takes in, the nearest first from where the player stands, then
-- the nearest from each stop (ns.DirectTravelCost). -> def | nil, reason
local function carriedGuide()
	local P = ns.RoutePlan
	local list = P.Carried()
	if not list then return nil, "unsettled" end
	local stops, byKey = {}, {}
	for _, c in ipairs(list) do
		local e = P.Ender(c.quest)
		if e then
			local key = e.npc and ("n" .. e.npc) or ("o" .. tostring(e.object))
			local s = byKey[key]
			if not s then
				s = { at = e, quests = {} }
				byKey[key] = s
				stops[#stops + 1] = s
			end
			s.quests[#s.quests + 1] = c
		end
	end
	if #stops == 0 then return nil, "nothing" end
	local from, steps = ns.PlayerPoint(), {}
	while #stops > 0 do
		local best, bestT = 1, nil
		for i, s in ipairs(stops) do
			local t = from and ns.DirectTravelCost and ns.DirectTravelCost(from, s.at)
			if t and (not bestT or t < bestT) then best, bestT = i, t end
		end
		local s = table.remove(stops, best)
		local at, goals = s.at, {}
		for _, c in ipairs(s.quests) do
			goals[#goals + 1] = { t = "turnin", quest = c.quest, title = c.title or ns.Names.Quest(c.quest) or (L["Quest"] .. " " .. c.quest),
				npc = at.npc, npcName = at.npc and at.name or nil, object = at.object, objName = at.object and at.name or nil,
				map = at.map, x = at.x, y = at.y, f = at.f }
		end
		steps[#steps + 1] = { title = at.name or L["Quest giver"], goals = goals }
		from = at
	end
	return { title = L["Hand in your finished quests"], steps = steps }
end

if ns.Lookup and ns.Lookup.RegisterPlanner then ns.Lookup.RegisterPlanner("carried", carriedGuide) end
