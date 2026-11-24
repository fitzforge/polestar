-- The client's quest title surfaces, for Quests/QuestLevels.lua. Load after
-- stub_world.lua (it owns C_QuestLog). Each fake keeps the shape of the
-- camelot UI in .ref/wow-ui-source-forever/Interface/AddOns, reduced to what
-- draws the title:
--   quest log  Blizzard_UIPanels_Game/Mainline/QuestMapFrame.lua (QuestLogQuests_Update,
--              QuestScrollFrame.titleFramePool, button.Text/.info/.questID)
--   tracker    Blizzard_ObjectiveTracker (QuestObjectiveTracker / CampaignQuestObjectiveTracker,
--              UpdateSingle via self.UpdateSingle, GetExistingBlock, block.HeaderText)
--   gossip     Blizzard_UIPanels_Game/Shared/GossipFrameShared.lua + Mainline/GossipFrame.lua
--              (Gossip*QuestButtonMixin:Setup(questInfo), buttons created on first gossip)
--   greeting   Blizzard_UIPanels_Game/Mainline/QuestFrame.lua (QuestFrameGreetingPanel,
--              OnShow script bound to the original QuestFrameGreetingPanel_OnShow)
--   details    Blizzard_UIPanels_Game/Mainline/QuestInfo.lua (QuestInfo_Display, QuestInfoTitleHeader)
--
--   local ql = stub.questlog
--   ql.quests[id] = { title = "...", level = 12, elite = false }  -- what the client knows
--   ql.native = true                     -- log and tracker prefix the level themselves (camelot)
--   ql.log = { id, ... }                 -- quests in the log, in order
--   ql.updateLog()                       -- QuestLogQuests_Update()
--   ql.logText(id) -> title text in the log
--   ql.hoverLog(id) -> GameTooltip's lines with the cursor on its row (QuestMapLogTitleButton_OnEnter)
--   ql.updateTracker(id [, campaign])    -- the module's LayoutContents for one watched quest
--   ql.trackerText(id [, campaign])
--   ql.gossip({ { id, active = bool, level = n }, ... }) -> { buttons }  (GossipFrameSharedMixin:Update)
--   ql.greeting({ activeIDs }, { availableIDs }) -> { buttons }         (QuestFrameGreetingPanel:Show())
--   ql.greetingDirect()                  -- QuestFrameGreetingPanel_OnShow() called directly
--   ql.detail(id, fromLog) -> QuestInfoTitleHeader text                 (QuestInfo_Display)
--   ql.removeTracker() / ql.installTracker()  -- tracker frames absent until its ADDON_LOADED

local ql = { quests = {}, log = {}, native = false, selected = nil, npcQuest = nil }
stub.questlog = ql

local function questOf(id) return ql.quests[id] or {} end

---------------------------------------------------------------------------
-- Client API (Blizzard_APIDocumentationGenerated/QuestLogDocumentation.lua)
---------------------------------------------------------------------------

C_QuestLog = C_QuestLog or {}
-- Documented non-nilable; 0 here stands for "the client does not know it".
function C_QuestLog.GetQuestDifficultyLevel(id) return questOf(id).level or 0 end
function C_QuestLog.IsEliteQuest(id) return questOf(id).elite == true end
function C_QuestLog.GetSelectedQuest() return ql.selected end
function GetQuestID() return ql.npcQuest or 0 end

---------------------------------------------------------------------------
-- Shared bits
---------------------------------------------------------------------------

local function newPool(make)
	local pool = { active = {}, free = {} }
	function pool:Acquire()
		local o = table.remove(self.free) or make()
		self.active[o] = true
		o:Show()
		return o
	end
	function pool:ReleaseAll()
		for o in pairs(self.active) do
			o:Hide()
			table.insert(self.free, o)
		end
		self.active = {}
	end
	-- ObjectPoolMixin:EnumerateActive (Blizzard_SharedXMLBase/Pools.lua): pairs(activeObjects).
	function pool:EnumerateActive() return pairs(self.active) end
	return pool
end

-- Widget Button:GetTextHeight (SimpleButtonAPIDocumentation.lua).
local function buttonTextHeight(self) return stub.Methods.GetStringHeight(self) end

local function newTextButton(width)
	local b = CreateFrame("Button")
	b:SetWidth(width)
	b.Icon = b:CreateTexture()
	b.Icon:SetHeight(16)
	b.GetTextHeight = buttonTextHeight
	return b
end

-- What the client draws before the words: the level (camelot's
-- QuestUtilsOverrides.GetQuestTitlePrefix) when native, nothing otherwise.
local function nativePrefix(id)
	if not ql.native then return "" end
	local q = questOf(id)
	return "[" .. (q.level or 0) .. (q.elite and "+" or "") .. "] "
end

NORMAL_QUEST_DISPLAY = "|cff000000%s|r"
TRIVIAL_QUEST_DISPLAY = "|cff000000%s (low level)|r"
IGNORED_QUEST_DISPLAY = "|cff000000%s (ignored)|r"

---------------------------------------------------------------------------
-- Quest log
---------------------------------------------------------------------------

QuestScrollFrame = CreateFrame("Frame", "QuestScrollFrame")
QuestScrollFrame.titleFramePool = newPool(function()
	local b = CreateFrame("Button", nil, QuestScrollFrame)
	b.Text = b:CreateFontString()
	b.Text:SetWidth(200)
	return b
end)

function QuestLogQuests_Update()
	local pool = QuestScrollFrame.titleFramePool
	pool:ReleaseAll()
	for i, id in ipairs(ql.log) do
		local q = questOf(id)
		local button = pool:Acquire()
		button.info = { title = q.title, questLogIndex = i, questID = id, level = q.level or 0, difficultyLevel = q.level or 0, isHeader = false }
		button.questID = id
		button.questLogIndex = i
		button.Text:SetText(nativePrefix(id) .. q.title)
		button:SetHeight(8 + button.Text:GetStringHeight())
	end
end

function ql.updateLog() QuestLogQuests_Update() end

function ql.logText(id)
	for b in QuestScrollFrame.titleFramePool:EnumerateActive() do
		if b.questID == id then return b.Text:GetText() end
	end
end

-- QuestMapLogTitleButton_OnEnter: the row's tooltip, the title first (the client's own lines after it left out).
function QuestMapLogTitleButton_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
	GameTooltip:SetText(self.info.title)
end

-- The cursor on quest id's row in the log -> the tooltip's lines.
function ql.hoverLog(id)
	for b in QuestScrollFrame.titleFramePool:EnumerateActive() do
		if b.questID == id then
			QuestMapLogTitleButton_OnEnter(b)
			return GameTooltip.lines
		end
	end
end

---------------------------------------------------------------------------
-- Objective tracker
---------------------------------------------------------------------------

local TrackerMixin = {}

function TrackerMixin:GetExistingBlock(id) return self.usedBlocks[id] end

function TrackerMixin:GetBlock(id)
	local block = self.usedBlocks[id]
	if not block then
		block = CreateFrame("Frame", nil, self)
		block.HeaderText = block:CreateFontString()
		block.HeaderText:SetWidth(250)
		self.usedBlocks[id] = block
	end
	return block
end

function TrackerMixin:UpdateSingle(quest)
	local id = quest:GetID()
	local block = self:GetBlock(id)
	local title = quest.title
	if ql.native and questOf(id).elite then title = title .. " (Elite)" end
	-- SetQuestTitleLevelAndDifficultyColor: prefix, then the difficulty colour.
	title = "|cffffd100" .. nativePrefix(id) .. title .. "|r"
	-- ObjectiveTrackerBlockMixin:SetHeader -> SetStringText (max two lines), height from it.
	block.HeaderText:SetText(title)
	block.height = block.HeaderText:GetStringHeight()
end

-- LayoutContents -> EnumQuestWatchData(self.UpdateSingle): the field, read at call time.
function TrackerMixin:LayoutContents(id)
	local quest = { title = questOf(id).title }
	function quest.GetID() return id end
	local fn = self.UpdateSingle
	fn(self, quest)
end

local function newTracker(name)
	local f = CreateFrame("Frame", name)
	for k, v in pairs(TrackerMixin) do f[k] = v end
	f.usedBlocks = {}
	return f
end

function ql.removeTracker()
	QuestObjectiveTracker, CampaignQuestObjectiveTracker = nil, nil
end

function ql.installTracker()
	newTracker("QuestObjectiveTracker")
	newTracker("CampaignQuestObjectiveTracker")
end
ql.installTracker()

local function tracker(campaign) return campaign and CampaignQuestObjectiveTracker or QuestObjectiveTracker end
function ql.updateTracker(id, campaign) tracker(campaign):LayoutContents(id) end
function ql.trackerText(id, campaign)
	local block = tracker(campaign):GetExistingBlock(id)
	return block and block.HeaderText:GetText()
end

---------------------------------------------------------------------------
-- Gossip
---------------------------------------------------------------------------

GossipSharedTitleButtonMixin = {}
function GossipSharedTitleButtonMixin:Resize()
	self:SetHeight(math.max(self:GetTextHeight() + 2, self.Icon:GetHeight()))
end

GossipSharedQuestButtonMixin = CreateFromMixins(GossipSharedTitleButtonMixin)
function GossipSharedQuestButtonMixin:UpdateTitleForQuest(questID, titleText, isIgnored, isTrivial)
	if isIgnored then
		self:SetFormattedText(IGNORED_QUEST_DISPLAY, titleText)
	elseif isTrivial then
		self:SetFormattedText(TRIVIAL_QUEST_DISPLAY, titleText)
	else
		self:SetFormattedText(NORMAL_QUEST_DISPLAY, titleText)
	end
	self:Resize()
end

GossipSharedAvailableQuestButtonMixin = CreateFromMixins(GossipSharedQuestButtonMixin)
function GossipSharedAvailableQuestButtonMixin:Setup(questInfo)
	self:SetID(questInfo.questID)
	self:UpdateTitleForQuest(questInfo.questID, questInfo.title, questInfo.isIgnored, questInfo.isTrivial)
	self:Show()
end
GossipSharedActiveQuestButtonMixin = CreateFromMixins(GossipSharedQuestButtonMixin)
GossipSharedActiveQuestButtonMixin.Setup = GossipSharedAvailableQuestButtonMixin.Setup

GossipAvailableQuestButtonMixin = CreateFromMixins(GossipSharedAvailableQuestButtonMixin)
GossipActiveQuestButtonMixin = CreateFromMixins(GossipSharedActiveQuestButtonMixin)

-- Templates apply their mixin when a button is created (on the first gossip).
function ql.gossip(list)
	local out = {}
	for i, e in ipairs(list) do
		local b = newTextButton(260)
		Mixin(b, e.active and GossipActiveQuestButtonMixin or GossipAvailableQuestButtonMixin)
		b:Setup({ questID = e[1], title = questOf(e[1]).title, questLevel = e.level or 0, isTrivial = e.trivial or false, isIgnored = false })
		out[i] = b
	end
	return out
end

---------------------------------------------------------------------------
-- Quest giver greeting
---------------------------------------------------------------------------

local greeting = { active = {}, available = {} }

function GetNumActiveQuests() return #greeting.active end
function GetNumAvailableQuests() return #greeting.available end
function GetActiveTitle(i) return questOf(greeting.active[i]).title, false end
function GetAvailableTitle(i) return questOf(greeting.available[i]).title end
function GetActiveQuestID(i) return greeting.active[i] end
function GetAvailableQuestInfo(i) return false, 0, false, false, greeting.available[i], false, false, nil end

QuestFrameGreetingPanel = CreateFrame("Frame", "QuestFrameGreetingPanel")
QuestFrameGreetingPanel:Hide()
QuestFrameGreetingPanel.titleButtonPool = newPool(function() return newTextButton(260) end)

function QuestFrameGreetingPanel_OnShow()
	local pool = QuestFrameGreetingPanel.titleButtonPool
	pool:ReleaseAll()
	local nActive = GetNumActiveQuests()
	for i = 1, nActive do
		local b = pool:Acquire()
		b:SetFormattedText(NORMAL_QUEST_DISPLAY, (GetActiveTitle(i)))
		b:SetHeight(math.max(b:GetTextHeight() + 2, b.Icon:GetHeight()))
		b:SetID(i)
		b.isActive = 1
	end
	for i = nActive + 1, nActive + GetNumAvailableQuests() do
		local b = pool:Acquire()
		b:SetFormattedText(NORMAL_QUEST_DISPLAY, GetAvailableTitle(i - nActive))
		b:SetHeight(math.max(b:GetTextHeight() + 2, b.Icon:GetHeight()))
		b:SetID(i - nActive)
		b.isActive = 0
	end
end
-- <OnShow function="QuestFrameGreetingPanel_OnShow"/>: the script holds the original.
QuestFrameGreetingPanel:SetScript("OnShow", QuestFrameGreetingPanel_OnShow)

local function greetingButtons()
	local out = {}
	for b in QuestFrameGreetingPanel.titleButtonPool:EnumerateActive() do
		out[#out + 1] = b
	end
	table.sort(out, function(a, b) return a.isActive > b.isActive or (a.isActive == b.isActive and a:GetID() < b:GetID()) end)
	return out
end

function ql.greeting(active, available)
	greeting.active, greeting.available = active or {}, available or {}
	QuestFrameGreetingPanel:Hide()
	QuestFrameGreetingPanel:Show()
	return greetingButtons()
end

-- QuestFrame.lua's QUEST_LOG_UPDATE path calls the global directly.
function ql.greetingDirect()
	QuestFrameGreetingPanel_OnShow(QuestFrameGreetingPanel)
	return greetingButtons()
end

---------------------------------------------------------------------------
-- Quest details
---------------------------------------------------------------------------

QuestInfoFrame = CreateFrame("Frame", "QuestInfoFrame")
QuestInfoTitleHeader = QuestInfoFrame:CreateFontString("QuestInfoTitleHeader")
QuestInfoTitleHeader:SetWidth(275)

function QuestInfo_ShowTitle()
	local id = QuestInfoFrame.questLog and C_QuestLog.GetSelectedQuest() or GetQuestID()
	QuestInfoTitleHeader:SetText(questOf(id).title)
	return QuestInfoTitleHeader
end
function QuestInfo_ShowRewards() end

QUEST_TEMPLATE_DETAIL = { questLog = nil, elements = { QuestInfo_ShowTitle, 10, -10, QuestInfo_ShowRewards, 0, -15 } }
QUEST_TEMPLATE_LOG = { questLog = true, elements = { QuestInfo_ShowTitle, 5, -5 } }
QUEST_TEMPLATE_MAP_REWARDS = { questLog = true, elements = { QuestInfo_ShowRewards, 0, 0 } }

function QuestInfo_Display(template, parentFrame)
	QuestInfoFrame.questLog = template.questLog
	local elements = template.elements
	for i = 1, #elements, 3 do elements[i](parentFrame) end
end

function ql.detail(id, fromLog)
	if fromLog then ql.selected = id else ql.npcQuest = id end
	QuestInfo_Display(fromLog and QUEST_TEMPLATE_LOG or QUEST_TEMPLATE_DETAIL, QuestInfoFrame)
	return QuestInfoTitleHeader:GetText()
end

return ql
