-- Optional Questie tracker captions (Options > Integrations, off by default).
-- Post-hooks only (hooksecurefunc on Questie's tracker pool and its rows,
-- never on a Blizzard secure function). Polestar reads Questie's rows,
-- appends its own caption to a completed quest's title, sizes a captioned
-- row to fit and asks Questie's tracker to lay out again, out of combat.
-- Questie still owns its pooled rows, clicks, sorting and layout; no Questie
-- file or saved setting is modified.
local ADDON, ns = ...
local L = ns.L
local Integration = {}
ns.QuestieTurnIns = Integration
ns.RegisterDefaults("routePlan", { questie = false })
local pool, tracker, pending, queued
local labels = setmetatable({}, { __mode = "k" })
local function combat() return InCombatLockdown and InCombatLockdown() end

local function readyQuest(id, completed)
	if completed and completed[id] ~= nil then return completed[id] end
	-- Use Polestar's existing client adapter, not another UI's snapshot or
	-- Questie's cached completion flag. Removed/turned-in quests stay unmarked.
	local ok, ready = pcall(ns.Compat.IsQuestReadyForTurnIn, id)
	ready = ok and ready == true
	if completed then completed[id] = ready end
	return ready
end

local function captionFor(line, completed)
	if ns.Get("routePlan.questie") ~= true or line.mode ~= "quest" or type(line.Quest) ~= "table"
		or not ns.Engine.GetGuide() then return nil end
	local id = line.Quest.Id
	if type(id) ~= "number" or not readyQuest(id, completed) then return nil end
	local plan = ns.RoutePlan.GetTurnIn(id)
	local color = (plan.status == "missed" or plan.status == "skipped" or plan.status == "unplanned") and "ffffbb55" or "ffb4bdcf"
	return "\n|c" .. color .. L["Polestar: %s"]:format(ns.RoutePlan.Describe(plan)) .. "|r"
end

local function measure(label, state)
	if not state or state.busy or combat() then return end
	-- Only a row that carries a caption, or has just lost one, has its
	-- heights touched; every other row keeps Questie's own layout.
	if not (state.annotated or state.grown) then return end
	if state.annotated then
		label:SetHeight(0)
		label:SetHeight(math.max(state.baseHeight or 1, label:GetStringHeight()))
	elseif state.line.mode == "quest" and state.baseHeight then label:SetHeight(state.baseHeight) end
	-- Questie 12.1.0 reassigns label widths again in UpdateFormatting after
	-- placing the rows. Preserve its measured padding when this final pass
	-- wraps a caption to more lines, or the following quest will overlap it.
	if state.line.mode == "quest" and state.padding then
		state.line:SetHeight(label:GetHeight() + state.padding)
	end
	state.grown = state.annotated
end

local function decorate(label, text)
	local state = labels[label]
	if not state or state.busy then return end
	if combat() then pending = true; return end
	if text ~= state.decorated then state.base = text end
	local line = state.line
	local base = state.base or ""
	local caption = captionFor(line)
	local _, fontHeight = label:GetFont()
	state.baseHeight = fontHeight or state.baseHeight or label:GetHeight()
	state.annotated = caption ~= nil
	state.decorated = base .. (caption or "")
	state.busy = true
	if label:GetText() ~= state.decorated then label:SetText(state.decorated) end
	state.busy = false
	measure(label, state)
end

local function attach(line)
	if type(line) ~= "table" then return end
	local label = line and line.label
	if not label or labels[label] then return end
	if type(label) ~= "table" and type(label) ~= "userdata" then return end
	for _, method in ipairs({ "GetText", "SetText", "GetFont", "GetHeight", "SetHeight", "GetStringHeight", "SetWidth" }) do
		if type(label[method]) ~= "function" then return end
	end
	if type(line.SetHeight) ~= "function" then return end
	labels[label] = { line = line, base = label:GetText(), baseHeight = label:GetHeight() }
	hooksecurefunc(label, "SetText", decorate)
	-- Questie assigns the final width after SetText. Re-measure then, before
	-- it reads label:GetHeight() to place the next row.
	hooksecurefunc(label, "SetWidth", function(self) measure(self, labels[self]) end)
	hooksecurefunc(line, "SetHeight", function(self, height)
		local state = labels[self.label]
		if state and self.mode == "quest" and not combat() then
			state.padding = math.max(0, height - self.label:GetHeight())
		end
	end)
end

function Integration.Connect()
	if pool then return true end
	if ns.Get("routePlan.questie") ~= true then return false end
	if not (QuestieLoader and QuestieLoader.ImportModule and hooksecurefunc) then return false end
	local ok, p = pcall(QuestieLoader.ImportModule, QuestieLoader, "TrackerLinePool")
	local tok, t = pcall(QuestieLoader.ImportModule, QuestieLoader, "QuestieTracker")
	if not ok or type(p) ~= "table" or type(p.AddQuestLine) ~= "function" or type(p.UpdateQuestTitleLines) ~= "function"
		or not tok or type(t) ~= "table" or type(t.Update) ~= "function" then return false end
	pool, tracker = p, t
	hooksecurefunc(pool, "AddQuestLine", function(_, line) attach(line) end)
	-- Older pooled lines can retain the original AddQuestLine callback from
	-- before our hook. The factory is also hooked so these rows are covered.
	if type(pool.GetQuestTitleLine) == "function" and type(pool.GetCurrentLine) == "function" then
		hooksecurefunc(pool, "GetQuestTitleLine", function() attach(pool.GetCurrentLine()) end)
	end
	pool.UpdateQuestTitleLines(attach)
	return true
end

function Integration.Refresh()
	if not pool and ns.Get("routePlan.questie") ~= true then return end
	pending = true
	if queued or combat() then return end
	queued = true
	C_Timer.After(0.2, function()
		queued = false
		if combat() then return end
		if not Integration.Connect() then return end
		pending = false
		local completed, changed = {}, false
		pool.UpdateQuestTitleLines(function(line)
			if type(line) ~= "table" then return end
			attach(line)
			local state = labels[line.label]
			if not state then return end
			local expected = (state.base or "") .. (captionFor(line, completed) or "")
			if line.label:GetText() ~= expected then changed = true end
		end)
		-- Rebuild through Questie's own layout so additional caption lines are
		-- included in row positions and tracker height (never in combat). Most
		-- quest-log events have already rendered through the SetText hook or do
		-- not affect captions; they must not cause a second complete rebuild.
		if changed then tracker:Update() end
	end)
end

for _, event in ipairs({ "GUIDE_CHANGED", "STEP_CHANGED", "STEP_UPDATED", "GUIDE_COMPLETED", "GUIDES_REGISTERED", "PACKS_CHANGED", "ROUTE_CHOSEN", "STEP_SKIPPED" }) do
	ns.On(event, Integration.Refresh)
end
ns.On("SETTING_CHANGED", function(path)
	if path == "routePlan.questie" or path == "routePlan" or path == "" then Integration.Refresh() end
end)
local function onEvent(event, name)
	if event == "QUEST_LOG_UPDATE" or (event == "ADDON_LOADED" and name == "Questie") or (event == "PLAYER_REGEN_ENABLED" and pending) then Integration.Refresh() end
end
for _, event in ipairs({ "ADDON_LOADED", "QUEST_LOG_UPDATE", "PLAYER_REGEN_ENABLED" }) do
	ns.RegisterEvent(event, onEvent)
end
ns.OnLogin(Integration.Refresh)

-- Options > Integrations > Questie, there only while Questie is installed.
if ns.RegisterOptions then
	ns.RegisterOptions({ page = L["Integrations"], section = "Questie", controls = {
		{ kind = "toggle", key = "routePlan.questie", label = L["Show planned turn-ins in Questie"],
			help = L["Completed quests in Questie's tracker show their Polestar turn-in step. Earlier, skipped and unplanned hand-ins are flagged."],
			needs = function() return ns.Compat.AddOnPresent("Questie") end },
	} })
end
