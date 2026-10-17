-- Quest levels before quest titles ("[12] Kobold Camp Cleanup", "[24+] ..."
-- for elite quests) wherever the client draws a quest title without one.
-- Setting qol.questLevels; turning it off puts back the text Polestar
-- changed and nothing else: a prefix the client drew itself stays.
--
-- What the camelot client (WoW: Forever 1.60.1.70338) already shows, from
-- .ref/wow-ui-source-forever/Interface/AddOns:
--   * Quest log and objective tracker prefix every title natively and
--     unconditionally: Blizzard_FrameXMLUtil/Camelot/QuestUtilsOverrides.lua
--     GetQuestTitlePrefix -> "[" .. difficultyLevel .. ("+" if
--     C_QuestLog.IsEliteQuest) .. "] ", used by
--     Blizzard_UIPanels_Game/Mainline/QuestMapFrame.lua QuestLogQuests_GetTitle
--     (camelot loads the Mainline QuestMapFrame; QuestLogFrame is
--     vanilla/tbc/wrath/cata only, Blizzard_UIPanels_Game.toc) and by
--     Blizzard_FrameXMLUtil/Mainline/DifficultyUtil.lua
--     SetQuestTitleLevelAndDifficultyColor (Blizzard_ObjectiveTracker/
--     Blizzard_QuestObjectiveTracker.lua QuestObjectiveTrackerMixin:UpdateSingle,
--     which also appends "(Elite)"/"(Dungeon)" via Camelot/
--     Blizzard_QuestObjectiveTrackerOverride.lua GetQuestTagText). The hooks
--     there find the level already drawn and change nothing; they stay for
--     clients that do not prefix.
--   * Gossip quest lists, the quest giver greeting and quest detail titles
--     carry no level: Polestar adds it.
--
-- Hooks (all post-hooks: hooksecurefunc / HookScript run after Blizzard's
-- code and never taint it; every write is SetText/SetHeight on unprotected
-- FontStrings and buttons, so it works in combat):
--   * Quest log: global QuestLogQuests_Update (Mainline/QuestMapFrame.lua),
--     then QuestScrollFrame.titleFramePool:EnumerateActive(); button.Text,
--     button.questID, button.info (C_QuestLog.GetInfo struct, difficultyLevel).
--     Button heights come from button.Text:GetHeight() before the layout, so
--     a prefix that would wrap the title onto another line is not applied.
--   * Tracker: the QuestObjectiveTracker and CampaignQuestObjectiveTracker
--     frames' UpdateSingle(quest) (LayoutContents calls it through
--     self.UpdateSingle), then self:GetExistingBlock(questID).HeaderText
--     (Blizzard_ObjectiveTrackerModule.lua, Blizzard_ObjectiveTrackerBlock.xml).
--     Block heights come from SetHeader, so the same no-wrap rule applies.
--   * Gossip: GossipAvailableQuestButtonMixin.Setup / GossipActiveQuestButtonMixin.Setup
--     (Mainline/GossipFrame.lua, Shared/GossipFrameShared.lua). Buttons get
--     the mixin when GossipFrameSharedMixin:Update first creates them, after
--     this file loads. questInfo.questLevel (GossipInfoDocumentation.lua
--     GossipQuestUIInfo); button:Resize() afterwards as Blizzard does.
--   * Greeting: QuestFrameGreetingPanel's OnShow script (bound to the
--     original function in Mainline/QuestFrame.xml, hence HookScript) and the
--     global QuestFrameGreetingPanel_OnShow (called directly from
--     QuestFrame.lua); titleButtonPool, button.isActive, button:GetID(),
--     GetActiveQuestID(i) / 5th return of GetAvailableQuestInfo(i) (both
--     called by Mainline/QuestFrame.lua; legacy globals absent from the
--     generated docs); height re-set as Blizzard does (GetTextHeight + 2).
--   * Detail titles: global QuestInfo_Display(template) (Mainline/QuestInfo.lua)
--     when template.elements holds QuestInfo_ShowTitle; QuestInfoTitleHeader;
--     quest from C_QuestLog.GetSelectedQuest() (template.questLog) or
--     GetQuestID() (QuestInfo_GetQuestID). Later elements anchor below it.
--   Frames missing when Polestar initializes are hooked on ADDON_LOADED.
--
-- Level: the surface's own (log difficultyLevel, gossip questLevel), else
-- C_QuestLog.GetQuestDifficultyLevel (what Blizzard prefixes with), else the
-- quest database's level. Elite: C_QuestLog.IsEliteQuest. Both documented in
-- Blizzard_APIDocumentationGenerated/QuestLogDocumentation.lua. Text, IDs
-- and levels that are secret values (issecretvalue,
-- FrameScriptDocumentation.lua) read as unknown: the title is left alone.
--
-- Cost: per title a few table writes, one GetText, two plain finds and, when
-- the prefix is new, the new string. Prefix strings are cached per level.

local ADDON, ns = ...

local Q = ns.QuestDB
local readable = ns.Compat.Readable
local type, pairs, tostring, select, find, sub, max = type, pairs, tostring, select, string.find, string.sub, math.max

local KIND_FIXED = 1 -- log and tracker: height already laid out, never add a line
local KIND_GOSSIP = 2 -- gossip button: Resize() after
local KIND_GREETING = 3 -- greeting button: height from text after
local KIND_FLOW = 4 -- detail title: the next element anchors below it

local enabled = false

-- Per text object (FontString or button), weak so pooled frames are not kept.
local weak = { __mode = "k" }
local questOf = setmetatable({}, weak) -- obj -> questID of the title Blizzard drew last
local levelOf = setmetatable({}, weak) -- obj -> level the surface gave, or false
local kindOf = setmetatable({}, weak) -- obj -> KIND_*; every object ever seen
local origText = setmetatable({}, weak) -- obj -> text before Polestar's prefix
local ourText = setmetatable({}, weak) -- obj -> text Polestar set

-- "[12]" / "[12+]" (to recognise a drawn level) and "[12] " / "[12+] " (to add).
local TAG, TAG_ELITE, PREFIX, PREFIX_ELITE = {}, {}, {}, {}

local function tags(level)
	local tag = TAG[level]
	if not tag then
		local s = tostring(level)
		tag = "[" .. s .. "]"
		TAG[level], TAG_ELITE[level] = tag, "[" .. s .. "+]"
		PREFIX[level], PREFIX_ELITE[level] = tag .. " ", "[" .. s .. "+] "
	end
	return tag, TAG_ELITE[level]
end

-- Escapes a title may start with (colour, atlas, texture, quest decoration
-- link, spaces): the level goes after them, right before the words.
local LEAD = { "^|c%x%x%x%x%x%x%x%x", "^|cn[%w_]+:", "^|A.-|a", "^|T.-|t", "^|H.-|h.-|h", "^ +" }

local function bodyStart(text)
	local pos, moved = 1, true
	while moved do
		moved = false
		for i = 1, #LEAD do
			local _, e = find(text, LEAD[i], pos)
			if e then
				pos, moved = e + 1, true
				break
			end
		end
	end
	return pos
end

local function valid(level)
	return type(level) == "number" and level > 0
end

local function levelFor(obj, q)
	local level = levelOf[obj]
	if valid(level) then return level end
	local QL = C_QuestLog
	if QL and QL.GetQuestDifficultyLevel then
		level = readable(QL.GetQuestDifficultyLevel(q))
		if valid(level) then return level end
	end
	if Q.IsLoaded() then
		local r = Q.QuestRecord(q)
		level = r and r[Q.F.LEVEL]
		if valid(level) then return level end
	end
	return nil
end

local function relayout(obj, kind)
	if kind == KIND_GOSSIP then
		if obj.Resize then obj:Resize() end
	elseif kind == KIND_GREETING then
		local icon = obj.Icon
		obj:SetHeight(max((obj:GetTextHeight() or 0) + 2, icon and icon:GetHeight() or 0))
	end
end

-- Adds the level to obj's current text unless it is unknown or already
-- there. `noGrow`: refuse a prefix that wraps the text onto another line.
local function apply(obj, noGrow)
	local q = questOf[obj]
	if not q then return end
	local text = readable(obj:GetText())
	if type(text) ~= "string" or text == "" or text == ourText[obj] then return end
	local level = levelFor(obj, q)
	if not level then return end
	local tag, tagElite = tags(level)
	if find(text, tag, 1, true) or find(text, tagElite, 1, true) then return end
	local QL = C_QuestLog
	local elite = QL and QL.IsEliteQuest and readable(QL.IsEliteQuest(q)) == true
	local prefix = elite and PREFIX_ELITE[level] or PREFIX[level]
	local at = bodyStart(text)
	local new = at == 1 and prefix .. text or sub(text, 1, at - 1) .. prefix .. sub(text, at)
	local kind = kindOf[obj]
	-- Buttons (gossip, greeting) measure through their FontString.
	local measure = (noGrow or kind == KIND_FIXED) and (obj.GetNumLines and obj or obj.GetFontString and obj:GetFontString())
	local lines = measure and measure:GetNumLines()
	obj:SetText(new)
	if lines and measure:GetNumLines() > lines then
		obj:SetText(text)
		return
	end
	origText[obj], ourText[obj] = text, new
	relayout(obj, kind)
end

local function restore(obj)
	local ours = ourText[obj]
	if ours and readable(obj:GetText()) == ours then
		obj:SetText(origText[obj])
		relayout(obj, kindOf[obj])
	end
	ourText[obj], origText[obj] = nil, nil
end

-- Blizzard just drew a quest title into obj.
local function mark(obj, kind, q, level)
	if not obj then return end
	ourText[obj], origText[obj] = nil, nil
	q = readable(q)
	if type(q) ~= "number" or q <= 0 then
		questOf[obj] = nil
		return
	end
	questOf[obj], kindOf[obj], levelOf[obj] = q, kind, readable(level) or false
	if enabled then apply(obj, false) end
end

---------------------------------------------------------------------------
-- Surfaces
---------------------------------------------------------------------------

local function onLogUpdate()
	local pool = QuestScrollFrame and QuestScrollFrame.titleFramePool
	if not pool then return end
	for button in pool:EnumerateActive() do
		local info = button.info
		mark(button.Text, KIND_FIXED, button.questID, info and info.difficultyLevel)
	end
end

local function onTrackerUpdate(module, quest)
	if not (quest and quest.GetID and module.GetExistingBlock) then return end
	local q = readable(quest:GetID())
	if type(q) ~= "number" then return end
	local block = module:GetExistingBlock(q)
	if block and block.HeaderText then mark(block.HeaderText, KIND_FIXED, q, nil) end
end

local function onGossipSetup(button, questInfo)
	if type(questInfo) ~= "table" then return end
	mark(button, KIND_GOSSIP, questInfo.questID, questInfo.questLevel)
end

local function onGreetingShow()
	local pool = QuestFrameGreetingPanel and QuestFrameGreetingPanel.titleButtonPool
	if not pool then return end
	for button in pool:EnumerateActive() do
		local i = button:GetID()
		local q
		if button.isActive == 1 then
			q = GetActiveQuestID and GetActiveQuestID(i)
		elseif GetAvailableQuestInfo then
			q = select(5, GetAvailableQuestInfo(i))
		end
		mark(button, KIND_GREETING, q, nil)
	end
end

local function onInfoDisplay(template)
	local elements = type(template) == "table" and template.elements
	if type(elements) ~= "table" or not QuestInfoTitleHeader then return end
	local hasTitle = false
	for i = 1, #elements, 3 do
		if elements[i] == QuestInfo_ShowTitle then
			hasTitle = true
			break
		end
	end
	if not hasTitle then return end
	local q
	if template.questLog then
		q = C_QuestLog and C_QuestLog.GetSelectedQuest and C_QuestLog.GetSelectedQuest()
	else
		q = GetQuestID and GetQuestID()
	end
	mark(QuestInfoTitleHeader, KIND_FLOW, q, nil)
end

-- Each: ready() -> true once the client defines what install() hooks.
local SURFACES = {
	{
		ready = function()
			return type(QuestLogQuests_Update) == "function" and QuestScrollFrame ~= nil
		end,
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
		ready = function()
			return type(GossipAvailableQuestButtonMixin) == "table" and type(GossipActiveQuestButtonMixin) == "table"
		end,
		install = function()
			hooksecurefunc(GossipAvailableQuestButtonMixin, "Setup", onGossipSetup)
			hooksecurefunc(GossipActiveQuestButtonMixin, "Setup", onGossipSetup)
		end,
	},
	{
		ready = function()
			return QuestFrameGreetingPanel ~= nil and type(QuestFrameGreetingPanel_OnShow) == "function"
		end,
		install = function()
			QuestFrameGreetingPanel:HookScript("OnShow", onGreetingShow)
			hooksecurefunc("QuestFrameGreetingPanel_OnShow", onGreetingShow)
		end,
	},
	{
		ready = function() return type(QuestInfo_Display) == "function" end,
		install = function() hooksecurefunc("QuestInfo_Display", onInfoDisplay) end,
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

---------------------------------------------------------------------------
-- Setting
---------------------------------------------------------------------------

local function sync()
	local on = ns.Get("qol.questLevels") and true or false
	if on == enabled then return end
	enabled = on
	if on then
		-- Titles on screen now; the next refresh of each surface redraws anyway.
		for obj in pairs(kindOf) do apply(obj, true) end
	else
		for obj in pairs(ourText) do restore(obj) end
	end
end

ns.On("SETTING_CHANGED", function(path)
	if path == "qol.questLevels" or path == "qol" or path == "" then sync() end
end)

-- Not with the gamepad interface (ns.GamepadUI): every surface is a window
-- its navigation manages, and these hooks resize the game's buttons there
-- from Polestar's code. A list that lays itself out again then rebuilds the
-- gamepad's buttons in that code (ScrollBoxListView.lua RefreshSmartNav),
-- and the window's next close is blocked.
ns.OnInit(function()
	enabled = ns.Get("qol.questLevels") and true or false
	if ns.GamepadUI() then return end
	if not installReady() then ns.RegisterEvent("ADDON_LOADED", onAddonLoaded) end
end)
