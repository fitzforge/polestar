-- Which guides use a quest: the installed guides for this character that
-- pick it up, work it or hand it in, wherever the game shows the quest, so
-- a quest can be taken early when passing by, kept for a later guide (the
-- second part of a zone, a dungeon's pick-up guide for its pre-quests) or
-- dropped when none of the guides it is in will be played.
-- Setting qol.questGuides.
--
--   ns.QuestGuides.For(q) -> { { guide = header, roles = bits, open = bool }, ... }
--     the open guides first, then by the guides' first level, then the guide
--     list's order; nil while the
--     index is still being built (it starts itself). roles: ACCEPT, WORK,
--     TURNIN bits (QG.ACCEPT ...). open: a guide tab shows it.
--   ns.QuestGuides.AddLines(tooltip, q) -> true when lines were added
--
-- The index: every guide Guides.List() lists that is for this character
-- (Guides.GuideMatches), its steps and goals filtered by `only` as the route
-- reads them; quest -> guide -> roles. Built a few guides per frame
-- (BUDGET ms) after login and again when guides register or packs change;
-- the deferred steps it read are given back (Guides.Release) unless a tab
-- shows that guide.
--
-- Surfaces (post-hooks, as QuestLevels.lua's and KeptFor.lua's, and loaded
-- after them so their text goes first; every write is SetText on an
-- unprotected FontString, a line on a tooltip just shown, or a FontString
-- of Polestar's own):
--   * Quest log rows and tracker titles: a small guide mark after the title
--     (QuestLogQuests_Update, the trackers' UpdateSingle), not where it wraps
--     the title onto another line. In the accent when an open guide uses
--     the quest, dimmed when only other guides do, none when no guide does.
--   * Quest log row tooltip: QuestMapLogTitleButton_OnEnter.
--   * Tracker title: the block's OnEnter (HookScript, once per block): the
--     lines on the tooltip the client shows there, else a tooltip of its own.
--   * Quest details: QuestInfo_Display; a section under the last element.
--   * Gossip and greeting quest buttons: the mark after the title and the
--     lines on hover (GossipAvailableQuestButtonMixin / GossipActiveQuestButtonMixin
--     Setup, QuestFrameGreetingPanel's OnShow).
-- Off while Polestar is hidden and with the gamepad interface (QuestLevels.lua's reasons).

local ADDON, ns = ...

local L = ns.L
local readable = ns.Compat.Readable
local type, pairs, ipairs, select, format, max = type, pairs, ipairs, select, string.format, math.max

local QG = {}
ns.QuestGuides = QG

QG.ACCEPT, QG.WORK, QG.TURNIN = 1, 2, 4

local BUDGET = 4 -- ms of index building per frame
local MARK_PATH = "Interface\\AddOns\\Polestar\\Media\\UI\\guides"

---------------------------------------------------------------------------
-- The index
---------------------------------------------------------------------------

local index -- quest -> { [guideId] = roles }
local headerOf = {} -- guide id -> header, in list order (rank)
local rankOf = {}
local building -- coroutine while building
local redrawWanted = false -- redraw the marks once the index is built
local redraw -- below

local function now() return debugprofilestop and debugprofilestop() or 0 end

local function scan(G, h, player, into)
	local def = G.Get(h.id)
	if not def then return end
	local wasLive = rawget(def, "steps") ~= nil
	local steps = def.steps
	local function applies(only) return not G.Matches or G.Matches(only, player) end
	for _, step in ipairs(type(steps) == "table" and steps or {}) do
		if applies(step.only) and type(step.goals) == "table" then
			for _, goal in ipairs(step.goals) do
				local q = goal.quest
				if type(q) == "number" and applies(goal.only) then
					local bit = goal.t == "accept" and QG.ACCEPT or goal.t == "turnin" and QG.TURNIN or QG.WORK
					local byGuide = into[q]
					if not byGuide then
						byGuide = {}
						into[q] = byGuide
					end
					local had = byGuide[h.id] or 0
					if had % (bit * 2) < bit then byGuide[h.id] = had + bit end
				end
			end
		end
	end
	if not wasLive then
		local E = ns.Engine
		local tabs = E and E.TabIds and E.TabIds() or {}
		if not tabs[h.id] and G.Release then G.Release(h.id) end
	end
end

local function build()
	local G, C = ns.Guides, ns.Compat
	local player = C.GetPlayerInfo and C.GetPlayerInfo() or {}
	local into, headers, ranks = {}, {}, {}
	local start = now()
	for i, h in ipairs(G.List()) do
		if not G.GuideMatches or G.GuideMatches(h, player) then
			headers[h.id], ranks[h.id] = h, i
			local ok, err = pcall(scan, G, h, player, into)
			if not ok and ns.NoteError then ns.NoteError(err) end
			if now() - start > BUDGET then
				coroutine.yield()
				start = now()
			end
		end
	end
	index, headerOf, rankOf = into, headers, ranks
end

local function step()
	if not building then return end
	local ok, err = coroutine.resume(building)
	if not ok then
		building = nil
		if ns.NoteError then ns.NoteError(err) end
		return
	end
	if coroutine.status(building) == "dead" then
		building = nil
		if redrawWanted then
			redrawWanted = false
			local ok2, err2 = pcall(redraw)
			if not ok2 and ns.NoteError then ns.NoteError(err2) end
		end
		return
	end
	if C_Timer and C_Timer.After then C_Timer.After(0, step) end
end

function QG.Rebuild()
	building = coroutine.create(build)
	if C_Timer and C_Timer.After then C_Timer.After(0, step) else
		while building do step() end
	end
end

function QG.Ready() return index ~= nil and building == nil end

-- Synchronously, for tests and slash commands.
function QG.BuildNow()
	building = coroutine.create(build)
	while building do
		local ok, err = coroutine.resume(building)
		if not ok or coroutine.status(building) == "dead" then
			building = nil
			if not ok then error(err) end
		end
	end
end

local function levelOf(h)
	local lo = ns.Guides.Levels and ns.Guides.Levels(h)
	return lo or h.minLevel or 0
end

function QG.For(q)
	q = readable(q)
	if type(q) ~= "number" then return nil end
	if not index then
		if not building then QG.Rebuild() end
		return nil
	end
	local byGuide = index[q]
	if not byGuide then return {} end
	local E = ns.Engine
	local tabs = E and E.TabIds and E.TabIds() or {}
	local out = {}
	for id, roles in pairs(byGuide) do
		local h = headerOf[id]
		if h then out[#out + 1] = { guide = h, roles = roles, open = tabs[id] and true or false } end
	end
	table.sort(out, function(a, b)
		if a.open ~= b.open then return a.open end
		local la, lb = levelOf(a.guide), levelOf(b.guide)
		if la ~= lb then return la < lb end
		return (rankOf[a.guide.id] or 0) < (rankOf[b.guide.id] or 0)
	end)
	return out
end

---------------------------------------------------------------------------
-- Text
---------------------------------------------------------------------------

local function has(roles, bit) return roles % (bit * 2) >= bit end

local function rolesText(roles)
	local parts = {}
	if has(roles, QG.ACCEPT) then parts[#parts + 1] = L["picks up"] end
	if has(roles, QG.WORK) then parts[#parts + 1] = L["works"] end
	if has(roles, QG.TURNIN) then parts[#parts + 1] = L["hands in"] end
	return table.concat(parts, ", ")
end

-- The label of each entry of a For list, as the lines name it: the guide's
-- label, with its pack's title when another guide of that label is from
-- another pack. Entries whose line would read the same as an earlier one's
-- (label, roles, open) are dropped: the list as shown.
local function shown(list)
	local G = ns.Guides
	local byLabel, out, seen = {}, {}, {}
	for _, e in ipairs(list) do
		local label = ns.UI.GuideLabel(e.guide)
		local packs = byLabel[label]
		if not packs then
			packs = {}
			byLabel[label] = packs
		end
		packs[e.guide.pack or ""] = true
		e.label = label
	end
	for _, e in ipairs(list) do
		local packs, n = byLabel[e.label], 0
		for _ in pairs(packs) do n = n + 1 end
		local label = e.label
		local p = n > 1 and G.Pack and G.Pack(e.guide.pack)
		if p and p.title then label = label .. " \194\183 " .. p.title end
		local key = label .. "|" .. e.roles .. "|" .. tostring(e.open)
		if not seen[key] then
			seen[key] = true
			out[#out + 1] = { guide = e.guide, roles = e.roles, open = e.open, label = label }
		end
	end
	return out
end
QG.Shown = shown

local enabled = false

local function wanted()
	return ns.Get("qol.questGuides") and not ns.Hidden() and true or false
end

local function markTexture(r, g, b)
	return format("|T%s:12:12:0:0:64:64:0:64:0:64:%d:%d:%d|t", MARK_PATH, r * 255, g * 255, b * 255)
end

-- "Polestar guides" and a line per guide: its name and levels, what it does
-- with the quest on the right. The open guides first, marked and in the
-- accent; the others muted, so the ones being played stand out.
function QG.AddLines(tip, q)
	if not (enabled and tip) then return false end
	local list = QG.For(q)
	if not list or #list == 0 then return false end
	local T = ns.Theme
	local ar, ag, ab = T.Color("accent")
	local tr, tg, tb = T.Color("text")
	local mr, mg, mb = T.Color("textMuted")
	tip:AddLine(" ")
	tip:AddLine(L["Polestar guides"], ar, ag, ab)
	for _, e in ipairs(shown(list)) do
		local label = e.label
		if e.open then
			tip:AddDoubleLine(markTexture(ar, ag, ab) .. " " .. label, rolesText(e.roles), ar, ag, ab, tr, tg, tb)
		else
			tip:AddDoubleLine(label, rolesText(e.roles), mr, mg, mb, mr, mg, mb)
		end
	end
	return true
end

-- The mark after a title: accent when an open guide uses the quest, dimmed
-- when only others do; nil when none does (or the index is not ready).
local function markFor(q)
	local list = QG.For(q)
	if not list or #list == 0 then return nil end
	local open = false
	for _, e in ipairs(list) do if e.open then open = true break end end
	return " " .. markTexture(ns.Theme.Color(open and "accent" or "textDim"))
end
QG.MarkFor = markFor

---------------------------------------------------------------------------
-- Title marks (log, tracker, gossip, greeting)
---------------------------------------------------------------------------

local weak = { __mode = "k" }
local questOf = setmetatable({}, weak) -- obj -> quest of the title drawn last
local resizeOf = setmetatable({}, weak) -- obj -> fn to lay it out again, or false
local origText = setmetatable({}, weak)
local ourText = setmetatable({}, weak)

local function measureOf(obj)
	if obj.GetNumLines then return obj end
	return obj.GetFontString and obj:GetFontString()
end

local function apply(obj)
	local q = questOf[obj]
	if not q then return end
	local text = readable(obj:GetText())
	if type(text) ~= "string" or text == "" or text == ourText[obj] then return end
	local mark = markFor(q)
	if not mark then return end
	local measure = measureOf(obj)
	local lines = measure and measure:GetNumLines()
	local new = text .. mark
	obj:SetText(new)
	if lines and measure:GetNumLines() > lines then
		obj:SetText(text)
		return
	end
	origText[obj], ourText[obj] = text, new
	local resize = resizeOf[obj]
	if resize then resize(obj) end
end

local function restore(obj)
	local ours = ourText[obj]
	if ours and readable(obj:GetText()) == ours then
		obj:SetText(origText[obj])
		local resize = resizeOf[obj]
		if resize then resize(obj) end
	end
	ourText[obj], origText[obj] = nil, nil
end

local function mark(obj, q, resize)
	if not obj then return end
	ourText[obj], origText[obj] = nil, nil
	q = readable(q)
	if type(q) ~= "number" or q <= 0 then
		questOf[obj] = nil
		return
	end
	questOf[obj], resizeOf[obj] = q, resize or false
	if enabled then apply(obj) end
end

local function gossipResize(button) if button.Resize then button:Resize() end end
local function greetingResize(button)
	local icon = button.Icon
	button:SetHeight(max((button:GetTextHeight() or 0) + 2, icon and icon:GetHeight() or 0))
end

---------------------------------------------------------------------------
-- Tooltips on frames
---------------------------------------------------------------------------

local hovered = setmetatable({}, weak) -- frame -> fn() -> quest
local ownTip = setmetatable({}, weak) -- frame -> true when its tooltip is Polestar's own

local function onEnter(frame)
	local get = hovered[frame]
	local q = get and get(frame)
	if not (enabled and q and GameTooltip) then return end
	local list = QG.For(q)
	if not list or #list == 0 then return end
	if GameTooltip:IsShown() and GameTooltip:GetOwner() == frame then
		QG.AddLines(GameTooltip, q)
	else
		GameTooltip:SetOwner(frame, "ANCHOR_LEFT")
		GameTooltip:SetText(ns.UI.QuestTitle(q) or (L["Quest"] .. " " .. q), 1, 1, 1, 1, true)
		QG.AddLines(GameTooltip, q)
		ownTip[frame] = true
	end
	ns.Theme.TipDots(GameTooltip)
	GameTooltip:Show()
end

local function onLeave(frame)
	if ownTip[frame] then
		ownTip[frame] = nil
		if GameTooltip and GameTooltip:GetOwner() == frame then GameTooltip:Hide() end
	end
end

local function hoverable(frame, get)
	if type(frame) ~= "table" or not frame.HookScript then return end
	if not hovered[frame] then
		frame:HookScript("OnEnter", onEnter)
		frame:HookScript("OnLeave", onLeave)
	end
	hovered[frame] = get
end

---------------------------------------------------------------------------
-- Quest details: a section under the text and rewards
---------------------------------------------------------------------------

local section

local function lowestShown(frame, low)
	for _, r in ipairs({ frame:GetRegions() }) do
		if r ~= section and r.IsShown and r:IsShown() and r.GetBottom then
			local b = r:GetBottom()
			if b and (not low or b < low.b) then low = { obj = r, b = b } end
		end
	end
	for _, c in ipairs({ frame:GetChildren() }) do
		if c:IsShown() then
			local b = c:GetBottom()
			if b and (not low or b < low.b) then low = { obj = c, b = b } end
		end
	end
	return low
end

local function detailText(q)
	local list = QG.For(q)
	if not list or #list == 0 then return nil end
	local T = ns.Theme
	local lines = { "|c" .. T.Hex("accent") .. L["Polestar guides"] .. "|r" }
	for _, e in ipairs(shown(list)) do
		local label = e.label
		if e.open then
			label = markTexture(T.Color("accent")) .. " |c" .. T.Hex("accent") .. label .. "|r  " .. rolesText(e.roles)
		else
			label = "|c" .. T.Hex("textMuted") .. label .. "  " .. rolesText(e.roles) .. "|r"
		end
		lines[#lines + 1] = label
	end
	return table.concat(lines, "\n")
end

local function onInfoDisplay(template)
	if not QuestInfoFrame then return end
	if section then section:Hide() end
	if not enabled or type(template) ~= "table" then return end
	local q
	if template.questLog then
		q = C_QuestLog and C_QuestLog.GetSelectedQuest and C_QuestLog.GetSelectedQuest()
	else
		q = GetQuestID and GetQuestID()
	end
	local text = detailText(readable(q))
	if not text then return end
	local low = lowestShown(QuestInfoFrame)
	if QuestInfoFrame.rewardsFrame and QuestInfoFrame.rewardsFrame:IsShown() then
		low = lowestShown(QuestInfoFrame.rewardsFrame, low)
	end
	if not low then return end
	if not section then
		section = QuestInfoFrame:CreateFontString(nil, "ARTWORK", "QuestFont")
		section:SetJustifyH("LEFT")
	end
	section:SetParent(QuestInfoFrame)
	section:ClearAllPoints()
	section:SetPoint("TOPLEFT", low.obj, "BOTTOMLEFT", 0, -15)
	section:SetPoint("LEFT", QuestInfoFrame, "LEFT", 5, 0)
	section:SetWidth(max((QuestInfoFrame:GetWidth() or 0) - 10, 200))
	section:SetText(text)
	section:Show()
end

---------------------------------------------------------------------------
-- Surfaces
---------------------------------------------------------------------------

local function onLogUpdate()
	local pool = QuestScrollFrame and QuestScrollFrame.titleFramePool
	if not pool then return end
	for button in pool:EnumerateActive() do mark(button.Text, button.questID) end
end

local function trackerQuest(frame)
	local block = frame.parentBlock or frame
	return readable(block.id)
end

local function onTrackerUpdate(module, quest)
	if not (quest and quest.GetID and module.GetExistingBlock) then return end
	local q = readable(quest:GetID())
	if type(q) ~= "number" then return end
	local block = module:GetExistingBlock(q)
	if not block then return end
	if block.HeaderText then mark(block.HeaderText, q) end
	-- The header's own button when the tracker has one (a frame), else the block.
	local header = block.HeaderButton
	hoverable(type(header) == "table" and header or block, trackerQuest)
end

local function onLogEnter(button)
	if not enabled or type(button) ~= "table" or not GameTooltip or GameTooltip:GetOwner() ~= button then return end
	if QG.AddLines(GameTooltip, button.questID) then GameTooltip:Show() end
end

local gossipQuest = setmetatable({}, weak)
local function onGossipSetup(button, questInfo)
	if type(questInfo) ~= "table" then return end
	gossipQuest[button] = readable(questInfo.questID)
	mark(button, questInfo.questID, gossipResize)
	hoverable(button, function(b) return gossipQuest[b] end)
end

local greetingQuest = setmetatable({}, weak)
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
		greetingQuest[button] = readable(q)
		mark(button, q, greetingResize)
		hoverable(button, function(b) return greetingQuest[b] end)
	end
end

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
		ready = function() return QuestFrameGreetingPanel ~= nil and type(QuestFrameGreetingPanel_OnShow) == "function" end,
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

-- Marks drawn before the index was ready, or with the setting just turned on.
function redraw()
	for obj in pairs(questOf) do
		restore(obj)
		if enabled then apply(obj) end
	end
end

local function sync()
	local on = wanted()
	if on == enabled then return end
	enabled = on
	if on then
		for obj in pairs(questOf) do apply(obj) end
	else
		for obj in pairs(ourText) do restore(obj) end
		if section then section:Hide() end
	end
end

ns.On("SETTING_CHANGED", function(path)
	if path == "qol.questGuides" or path == "qol" or path == "" then sync() end
end)
ns.On("POLESTAR_HIDDEN", sync)

local function stale()
	index = nil
	if enabled then
		redrawWanted = true
		QG.Rebuild()
	end
end
ns.On("GUIDES_REGISTERED", stale)
ns.On("PACKS_CHANGED", stale)
-- The accent follows the open tabs.
ns.On("TABS_CHANGED", function() if enabled and index then redraw() end end)

ns.OnInit(function()
	enabled = wanted()
	if ns.GamepadUI() then return end
	if not installReady() then ns.RegisterEvent("ADDON_LOADED", onAddonLoaded) end
end)

ns.OnLogin(function()
	if not enabled or ns.GamepadUI() then return end
	redrawWanted = true
	if C_Timer and C_Timer.After then
		C_Timer.After(3, function() if not index and not building then QG.Rebuild() end end)
	end
end)
