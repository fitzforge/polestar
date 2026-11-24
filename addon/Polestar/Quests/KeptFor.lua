-- "Kept for <guide>" after quest titles in the quest log and the objective
-- tracker (#3390): a quest in the log that a later guide of the route hands
-- in (RoutePlan.KeptFor: the Booty Bay quests the Stranglethorn guide takes
-- for the next one's Wild Shore stop) says so while it is carried, so
-- holding it reads as the route's plan. After the title, dimmed:
-- " · kept for Stranglethorn & Swamp", else " · kept" where the whole would
-- wrap the laid-out title onto another line, else nothing (QuestLevels.lua's
-- rule: these rows' heights are laid out before the hooks run). A quest log
-- row's tooltip says it whole either way. While-you're-here lines say it too
-- (Engine's Own.hereViewOf, UI.HereStep).
--
-- Hooks (post-hooks, as QuestLevels.lua's and after them, so a level prefix
-- goes first; every write is SetText on an unprotected FontString or a line
-- on the tooltip just shown, so it works in combat):
--   * Quest log: global QuestLogQuests_Update (Mainline/QuestMapFrame.lua),
--     then QuestScrollFrame.titleFramePool:EnumerateActive(); button.Text,
--     button.questID.
--   * Tracker: the QuestObjectiveTracker and CampaignQuestObjectiveTracker
--     frames' UpdateSingle(quest), then self:GetExistingBlock(questID).HeaderText.
--   * Quest log tooltip: global QuestMapLogTitleButton_OnEnter(button)
--     (Mainline/QuestMapFrame.lua: GameTooltip, owned by the button).
-- Off while Polestar is hidden (the text it changed put back) and with the
-- gamepad interface (as QuestLevels.lua: its windows' navigation).

local ADDON, ns = ...

local L = ns.L
local readable = ns.Compat.Readable
local type, pairs, format = type, pairs, string.format

local weak = { __mode = "k" }
local questOf = setmetatable({}, weak) -- obj -> questID of the title Blizzard drew last
local origText = setmetatable({}, weak) -- obj -> text before Polestar's label
local ourText = setmetatable({}, weak) -- obj -> text Polestar set

local enabled = false

-- The title of the later guide quest q is kept for, or nil.
local function keptFor(q)
	local P = ns.RoutePlan
	if not (P and P.KeptFor) then return nil end
	local _, title = P.KeptFor(q)
	return title
end

local function dim(s)
	return "|c" .. ns.Theme.Hex("textDim") .. s .. "|r"
end

-- obj's text with `label` after it when that adds no line (it stays set), else nil.
local function fits(obj, text, label, lines)
	local new = text .. dim(" · " .. label)
	obj:SetText(new)
	if obj:GetNumLines() <= lines then return new end
	return nil
end

-- The label after obj's current title, never adding a line to it.
local function apply(obj)
	local q = questOf[obj]
	if not q then return end
	local text = readable(obj:GetText())
	if type(text) ~= "string" or text == "" or text == ourText[obj] then return end
	local title = keptFor(q)
	if not title then return end
	local lines = obj:GetNumLines()
	local new = fits(obj, text, format(L["kept for %s"], title), lines) or fits(obj, text, L["kept"], lines)
	if new then
		origText[obj], ourText[obj] = text, new
	else
		obj:SetText(text)
	end
end

local function restore(obj)
	local ours = ourText[obj]
	if ours and readable(obj:GetText()) == ours then obj:SetText(origText[obj]) end
	ourText[obj], origText[obj] = nil, nil
end

-- Blizzard just drew quest q's title into obj.
local function mark(obj, q)
	if not obj then return end
	ourText[obj], origText[obj] = nil, nil
	q = readable(q)
	if type(q) ~= "number" or q <= 0 then
		questOf[obj] = nil
		return
	end
	questOf[obj] = q
	if enabled then apply(obj) end
end

local function onLogUpdate()
	local pool = QuestScrollFrame and QuestScrollFrame.titleFramePool
	if not pool then return end
	for button in pool:EnumerateActive() do mark(button.Text, button.questID) end
end

local function onTrackerUpdate(module, quest)
	if not (quest and quest.GetID and module.GetExistingBlock) then return end
	local q = readable(quest:GetID())
	if type(q) ~= "number" then return end
	local block = module:GetExistingBlock(q)
	if block and block.HeaderText then mark(block.HeaderText, q) end
end

local function onLogEnter(button)
	if not enabled or type(button) ~= "table" then return end
	local q = readable(button.questID)
	local title = type(q) == "number" and keptFor(q)
	if not title or not GameTooltip or GameTooltip:GetOwner() ~= button then return end
	local r, g, b = ns.Theme.Color("textDim")
	GameTooltip:AddLine(format(L["Kept for %s: the route hands it in there."], title), r, g, b, true)
	GameTooltip:Show()
end

-- Each: ready() -> true once the client defines what install() hooks.
local SURFACES = {
	{
		ready = function() return type(QuestLogQuests_Update) == "function" and QuestScrollFrame ~= nil end,
		install = function() hooksecurefunc("QuestLogQuests_Update", onLogUpdate) end,
	},
	{
		ready = function() return type(QuestObjectiveTracker) == "table" and QuestObjectiveTracker.UpdateSingle ~= nil end,
		install = function() hooksecurefunc(QuestObjectiveTracker, "UpdateSingle", onTrackerUpdate) end,
	},
	{
		ready = function()
			return type(CampaignQuestObjectiveTracker) == "table" and CampaignQuestObjectiveTracker.UpdateSingle ~= nil
		end,
		install = function() hooksecurefunc(CampaignQuestObjectiveTracker, "UpdateSingle", onTrackerUpdate) end,
	},
	{
		ready = function() return type(QuestMapLogTitleButton_OnEnter) == "function" end,
		install = function() hooksecurefunc("QuestMapLogTitleButton_OnEnter", onLogEnter) end,
	},
}

local pending = #SURFACES

local function installReady()
	for i = 1, #SURFACES do
		local s = SURFACES[i]
		if not s.done and s.ready() then
			s.done = true
			pending = pending - 1
			s.install()
		end
	end
	return pending == 0
end

local function onAddonLoaded()
	if installReady() then ns.UnregisterEvent("ADDON_LOADED", onAddonLoaded) end
end

local function sync()
	local on = not ns.Hidden()
	if on == enabled then return end
	enabled = on
	if on then
		for obj in pairs(questOf) do apply(obj) end
	else
		for obj in pairs(ourText) do restore(obj) end
	end
end

ns.On("POLESTAR_HIDDEN", sync)

ns.OnInit(function()
	enabled = not ns.Hidden()
	if ns.GamepadUI() then return end
	if not installReady() then ns.RegisterEvent("ADDON_LOADED", onAddonLoaded) end
end)
