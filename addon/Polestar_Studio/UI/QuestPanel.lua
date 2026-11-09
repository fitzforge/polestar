-- Quest log panel (spec 4.3): every quest in the log with its objectives and
-- counts, and Accept / Complete / Turn in buttons that add the goal with
-- giver and objective links filled. Each objective adds its kill, collect or
-- click goal linked as `quest Q.O`. Quests the open gossip or quest frame
-- offers appear on top.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local P = _G.Polestar
local Theme, W = UI.Theme, UI.W
local format, ipairs, tostring, tonumber, max = string.format, ipairs, tostring, tonumber, math.max

local panel
local offered = {} -- { { quest, title, active } } from the NPC window

local function codex()
	local C = P.Codex
	if C and C.Load then C.Load() end
	return C
end

local function questTitle(q)
	local C = codex()
	local rec = C and C.Quest and C.Quest(q)
	if rec and rec.title then return rec.title end
	if C_QuestLog and C_QuestLog.GetTitleForQuestID then return C_QuestLog.GetTitleForQuestID(q) end
	return tostring(q)
end
UI.QuestTitle = questTitle

-- Add the goal for one objective of a quest in the log.
function UI.AddObjective(q, o)
	local C = codex()
	local rec = C and C.Quest and C.Quest(q)
	local obj = rec and rec.objectives and rec.objectives[o]
	local live = P.Compat and P.Compat.GetQuestObjectives and P.Compat.GetQuestObjectives(q)
	local lo = live and live[o]
	local count = (obj and obj.count) or (lo and lo.numRequired)
	local kind = obj and obj.type or (lo and (lo.type == "item" and "item" or lo.type == "object" and "object" or lo.type == "monster" and "kill" or lo.type))
	if kind == "kill" or kind == "monster" then
		if obj and obj.id then return UI.Resolve("Kill", obj.id, count, q, o) end
		return UI.Resolve("Kill", "target", count, q, o)
	elseif kind == "item" then
		if obj and obj.id then return UI.Resolve("Collect", obj.id, count, q, o) end
		UI.Say(L["Polestar does not know this objective's item: use Collect with the item."], "warning")
	elseif kind == "object" then
		if obj and obj.id then return UI.Resolve("Interact", obj.id) end
		return UI.Resolve("Interact")
	else
		-- An event objective: be there.
		if obj and obj.map and obj.x then
			return UI.Add(UI.GotoAt(obj.map, obj.x, obj.y, obj.text))
		end
		return UI.Resolve("Goto", lo and P.Compat.ObjectiveLabel and P.Compat.ObjectiveLabel(lo.text) or nil)
	end
end

-- The quests the NPC window offers (gossip, quest detail).
local function readOffered()
	offered = {}
	local G = C_GossipInfo
	if G and G.GetAvailableQuests then
		for _, q in ipairs(G.GetAvailableQuests() or {}) do
			if q.questID then offered[#offered + 1] = { quest = q.questID, title = q.title } end
		end
		for _, q in ipairs(G.GetActiveQuests and G.GetActiveQuests() or {}) do
			if q.questID then offered[#offered + 1] = { quest = q.questID, title = q.title, active = true } end
		end
	end
	local q = GetQuestID and GetQuestID()
	if q and q > 0 then
		local seen = false
		for _, x in ipairs(offered) do if x.quest == q then seen = true end end
		if not seen then offered[#offered + 1] = { quest = q, title = GetTitleText and GetTitleText() or questTitle(q), active = QuestFrameCompleteButton and QuestFrameCompleteButton:IsVisible() } end
	end
end

local ROW, OBJ = 46, 22

local function makeRow(parent)
	local row = UI.Row(parent, ROW)
	row.Title = W.Text(row, "body", "quest")
	row.Title:SetPoint("TOPLEFT", row, "TOPLEFT", 10, -6)
	row.Sub = W.Text(row, "small", "textMuted")
	row.Sub:SetPoint("TOPLEFT", row.Title, "BOTTOMLEFT", 0, -3)
	row.Turnin = W.Button(row, L["Turn in"], function(self) UI.Resolve("Turnin", self:GetParent().psQuest) end, { height = 22 })
	row.Turnin:SetPoint("TOPRIGHT", row, "TOPRIGHT", -6, -6)
	row.Complete = W.Button(row, L["Complete"], function(self) UI.Resolve("Complete", self:GetParent().psQuest) end, { height = 22 })
	row.Complete:SetPoint("RIGHT", row.Turnin, "LEFT", -4, 0)
	row.Accept = W.Button(row, L["Accept"], function(self) UI.Resolve("Accept", self:GetParent().psQuest) end, { height = 22, primary = true })
	row.Accept:SetPoint("RIGHT", row.Complete, "LEFT", -4, 0)
	row.Title:SetPoint("RIGHT", row.Accept, "LEFT", -6, 0)
	row.Sub:SetPoint("RIGHT", row.Accept, "LEFT", -6, 0)
	return row
end

local function makeObj(parent)
	local row = UI.Row(parent, OBJ)
	row.Text = W.Text(row, "small", "textDim")
	row.Text:SetPoint("LEFT", row, "LEFT", 24, 0)
	row.Add = W.Button(row, "", function(self)
		local r = self:GetParent()
		UI.AddObjective(r.psQuest, r.psObj)
	end, { height = 20, ghost = true })
	row.Add:SetPoint("RIGHT", row, "RIGHT", -6, 0)
	row.Text:SetPoint("RIGHT", row.Add, "LEFT", -6, 0)
	return row
end

local function refresh()
	local f = panel
	if not (f and f:IsShown()) then return end
	readOffered()
	local c = f.Scroll.Child
	c:SetWidth(f.Scroll:GetWidth())
	local y, nr, no = 0, 0, 0
	local function quest(q, title, sub, opts)
		nr = nr + 1
		local row = f.Rows:Get(nr)
		row:ClearAllPoints()
		row:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
		row:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, -y)
		row.psQuest = q
		row.Title:SetText(title or tostring(q))
		row.Sub:SetText(sub or "")
		row.Accept:SetShown(opts.accept)
		row.Complete:SetShown(opts.complete)
		row.Turnin:SetShown(opts.turnin)
		y = y + ROW
	end
	for _, o in ipairs(offered) do
		quest(o.quest, o.title, o.active and L["Offered for turn-in by this NPC"] or L["Offered by this NPC"], { accept = not o.active, complete = false, turnin = o.active and true or false })
	end
	local C = codex()
	local Compat = P.Compat
	for _, q in ipairs(S.Resolve.QuestLog and S.Resolve.QuestLog() or {}) do
		local rec = C and C.Quest and C.Quest(q)
		local done = Compat and Compat.IsQuestReadyForTurnIn and Compat.IsQuestReadyForTurnIn(q)
		quest(q, questTitle(q), format("%d%s%s", q, rec and rec.level and format(L["  \194\183  level %d"], rec.level) or "", done and ("  \194\183  " .. L["ready to turn in"]) or ""), { accept = true, complete = true, turnin = true })
		local live = Compat and Compat.GetQuestObjectives and Compat.GetQuestObjectives(q) or {}
		local n = max(#live, rec and rec.objectives and #rec.objectives or 0)
		for o = 1, n do
			no = no + 1
			local row = f.Objs:Get(no)
			row:ClearAllPoints()
			row:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
			row:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, -y)
			row.psQuest, row.psObj = q, o
			local lo = live[o]
			local obj = rec and rec.objectives and rec.objectives[o]
			local text = lo and lo.text or (obj and obj.text) or "?"
			if lo and not text:find("%d+/%d+") then text = format("%s  %d/%d", text, lo.numFulfilled, lo.numRequired) end
			row.Text:SetText(format("%d.  %s", o, text))
			W.Color(row.Text, lo and lo.finished and "textMuted" or "textDim")
			local kind = obj and obj.type or (lo and lo.type)
			W.SetButtonText(row.Add, (kind == "kill" or kind == "monster") and L["Kill goal"] or kind == "item" and L["Collect goal"] or kind == "object" and L["Click goal"] or L["Go there"])
			y = y + OBJ
		end
	end
	f.Rows:HideFrom(nr + 1)
	f.Objs:HideFrom(no + 1)
	f.Empty:SetShown(nr == 0)
	W.SetScrollContent(f.Scroll, y)
end
UI.RefreshQuestPanel = refresh

UI.Widget("QuestPanel", "Quest log", 440, 420, function(f)
	panel = f
	f.Scroll = W.Scroll(f.Body)
	f.Scroll:SetPoint("TOPLEFT", f.Body, "TOPLEFT", 0, -4)
	f.Scroll:SetPoint("BOTTOMRIGHT", f.Body, "BOTTOMRIGHT", -2, 4)
	f.Rows = UI.Pool(f.Scroll.Child, makeRow)
	f.Objs = UI.Pool(f.Scroll.Child, makeObj)
	f.Empty = UI.Text(f.Body, "note", "textMuted", true)
	f.Empty:SetPoint("TOPLEFT", f.Body, "TOPLEFT", 14, -14)
	f.Empty:SetPoint("RIGHT", f.Body, "RIGHT", -14, 0)
	f.Empty:SetText(L["Your quest log is empty. Quests an NPC offers show here while you talk to them."])
	f.Refresh = refresh
	f:HookScript("OnShow", refresh)
	local function soon() if f:IsShown() then S.Debounce("questpanel", 0.2, refresh) end end
	for _, ev in ipairs({ "QUEST_LOG_UPDATE", "GOSSIP_SHOW", "GOSSIP_CLOSED", "QUEST_DETAIL", "QUEST_PROGRESS", "QUEST_COMPLETE", "QUEST_FINISHED", "QUEST_ACCEPTED" }) do
		S.RegisterEvent(ev, soon)
	end
end, { point = { "RIGHT", "RIGHT", -60, 60 }, resizable = true, minW = 360, minH = 240 })
