-- Quest rewards: the marks on the reward choices, and, when qol.rewardAutoPick
-- is on (default off; Shift suppresses), taking the best one.
--
-- Best = the largest upgrade by Polestar.Gear (IsUpgrade's delta) when any
-- choice is an upgrade; otherwise the highest vendor value (sell price times
-- the stack). Gear verdicts are used only while Polestar.Gear is enabled.
-- Item data can be uncached when the panel opens; the ranking for auto-pick
-- is retried a few times before it settles, and the marks redraw as item data
-- arrives.
--
-- Marks (qol.rewardHighlight), on the item icon of each reward choice button,
-- wherever the client shows quest rewards (QuestInfo_Display: the quest
-- giver's detail and reward panels and the quest log), nothing over the name:
--   * an upgrade: a green up arrow (qol-upgrade, success) in the icon's
--     top-left corner, the corner the client's own bag upgrade arrow uses;
--   * the best of two or more choices (the one auto-pick takes): a 2px accent
--     frame around the icon, on a 1px shade keyline so it holds on the
--     parchment and on dark skins, clear of the client's quality border;
--   * the most valuable of two or more choices (sell price times the stack,
--     every price known): the coin (qol-coin, accent) in the icon's top-right
--     corner, whether or not some choice is an upgrade, so the best seller
--     shows beside the upgrade arrows; ties all get it, no price no coin.
-- Hovering a choice shows Gear's comparison line ("+12% upgrade · Head")
-- through Polestar.Hooks (the client's SetQuestItem / SetQuestLogItem run the
-- item tooltip post-calls).
--
-- Client: GetNumQuestChoices, GetQuestItemInfo("choice", i), GetQuestItemLink,
-- GetNumQuestLogChoices, GetQuestLogChoiceInfo(i), GetQuestLogItemLink,
-- GetQuestMoneyToGet, GetQuestReward (Mainline QuestFrame.lua / QuestInfo.lua);
-- reward buttons are QuestInfoFrame.rewardsFrame.RewardButtons with type
-- "choice", objectType "item", ID = choice index, and their 39px Icon at the
-- button's TOPLEFT (LargeItemButtonTemplate).

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local Client = QoL.Client

local type, pairs, format, sort = type, pairs, string.format, table.sort

local Rewards = {}
QoL.Rewards = Rewards

local RETRIES, RETRY_DELAY = 3, 0.3
local BADGE = 20 -- the badge texture's size; its glyph sits 2px in from the edge
local RING = 2   -- the best's frame: its width, outside the icon
local ICON = 39  -- LargeItemButtonTemplate's icon, for buttons without .Icon

local function gear()
	local G = ns.Gear
	if not (G and G.IsUpgrade) then return nil end
	if G.IsEnabled and not G.IsEnabled() then return nil end
	return G
end

local function isUpgrade(c)
	return c.upgrade and (c.delta or 0) > 0 or false
end

-- choices = { { index, link, count, value, upgrade, delta }, ... }
-- -> ordered list of choice indices, best first, and the reason ("upgrade" | "value").
function Rewards.Rank(choices)
	local anyUpgrade = false
	for i = 1, #choices do
		if isUpgrade(choices[i]) then anyUpgrade = true end
	end
	local order = {}
	for i = 1, #choices do order[i] = choices[i] end
	if anyUpgrade then
		sort(order, function(a, b)
			local da = isUpgrade(a) and a.delta or -1
			local db = isUpgrade(b) and b.delta or -1
			if da ~= db then return da > db end
			if (a.value or 0) ~= (b.value or 0) then return (a.value or 0) > (b.value or 0) end
			return a.index < b.index
		end)
	else
		sort(order, function(a, b)
			if (a.value or 0) ~= (b.value or 0) then return (a.value or 0) > (b.value or 0) end
			return a.index < b.index
		end)
	end
	local out = {}
	for i = 1, #order do out[i] = order[i].index end
	return out, anyUpgrade and "upgrade" or "value"
end

local function numChoices(fromLog)
	if fromLog then
		if not GetNumQuestLogChoices then return 0 end
		local questID = C_QuestLog and C_QuestLog.GetSelectedQuest and C_QuestLog.GetSelectedQuest()
		return GetNumQuestLogChoices(questID, true) or 0
	end
	return GetNumQuestChoices and GetNumQuestChoices() or 0
end

local function choiceInfo(i, fromLog)
	local _, count, itemID, link
	if fromLog then
		if GetQuestLogChoiceInfo then _, _, count, _, _, itemID = GetQuestLogChoiceInfo(i) end
		link = GetQuestLogItemLink and GetQuestLogItemLink("choice", i)
	else
		_, _, count, _, _, itemID = GetQuestItemInfo("choice", i)
		link = GetQuestItemLink and GetQuestItemLink("choice", i)
	end
	return link, count, itemID
end

-- Read the shown choices (the quest giver's panel, or the quest log's when
-- fromLog). complete = every link and price known.
function Rewards.ReadChoices(fromLog)
	local n = numChoices(fromLog)
	local list, complete = {}, true
	local G = gear()
	for i = 1, n do
		local link, count, itemID = choiceInfo(i, fromLog)
		local price = Client.SellPrice(link or itemID)
		if not link or price == nil then complete = false end
		local stack = (count and count > 0) and count or 1
		local c = { index = i, link = link, itemID = itemID, count = count or 1, value = (price or 0) * stack }
		-- Gear can judge an uncached choice from its ID (ItemDB stats).
		local probe = link or (type(itemID) == "number" and itemID > 0 and "item:" .. itemID) or nil
		if G and probe then
			local up, delta = G.IsUpgrade(probe)
			c.upgrade, c.delta = up and true or false, delta
		end
		list[i] = c
	end
	return list, complete
end

---------------------------------------------------------------------------
-- The marks
---------------------------------------------------------------------------

local marks = {} -- reward button -> mark frame

local function color(name)
	local T = ns.Theme
	if name == "accent" then return T.Accent() end
	return T.Color(name)
end

-- Four edge textures: top, bottom, left, right.
local function edges(m, sub)
	local T = ns.Theme
	local e = {}
	for k = 1, 4 do
		local t = m:CreateTexture(nil, "OVERLAY", nil, sub)
		t:SetTexture(T and T.Media and T.Media("white") or nil)
		e[k] = t
	end
	return e
end

-- Lay edges along m's sides, `out` outside it, `w` thick.
local function place(e, m, out, w)
	local top, bottom, left, right = e[1], e[2], e[3], e[4]
	top:ClearAllPoints()
	top:SetPoint("TOPLEFT", m, "TOPLEFT", -out, out)
	top:SetPoint("TOPRIGHT", m, "TOPRIGHT", out, out)
	top:SetHeight(w)
	bottom:ClearAllPoints()
	bottom:SetPoint("BOTTOMLEFT", m, "BOTTOMLEFT", -out, -out)
	bottom:SetPoint("BOTTOMRIGHT", m, "BOTTOMRIGHT", out, -out)
	bottom:SetHeight(w)
	left:ClearAllPoints()
	left:SetPoint("TOPLEFT", top, "BOTTOMLEFT", 0, 0)
	left:SetPoint("BOTTOMLEFT", bottom, "TOPLEFT", 0, 0)
	left:SetWidth(w)
	right:ClearAllPoints()
	right:SetPoint("TOPRIGHT", top, "BOTTOMRIGHT", 0, 0)
	right:SetPoint("BOTTOMRIGHT", bottom, "TOPRIGHT", 0, 0)
	right:SetWidth(w)
end

local function paint(m)
	local T = ns.Theme
	if not (T and T.Accent and T.Color) then return end
	local r, g, b = color("success")
	m.Badge:SetVertexColor(r, g, b, 1)
	r, g, b = color("accent")
	m.Coin:SetVertexColor(r, g, b, 1)
	for k = 1, 4 do m.Ring[k]:SetVertexColor(r, g, b, 1) end
	r, g, b = color("shade")
	for k = 1, 4 do m.Key[k]:SetVertexColor(r, g, b, 0.85) end
	-- The keyline is one physical pixel at any UI scale.
	local px = T.Pixel and T.Pixel(m) or 1
	place(m.Key, m, px, px)
end

local function markFor(button)
	local m = marks[button]
	if m then return m end
	m = ns.CreateFrameUnder("Frame", nil, button)
	m:SetFrameLevel((button:GetFrameLevel() or 1) + 3)
	-- m spans the icon plus the frame around it.
	local icon = button.Icon
	if icon then
		m:SetPoint("TOPLEFT", icon, "TOPLEFT", -RING, RING)
		m:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", RING, -RING)
	else
		m:SetPoint("TOPLEFT", button, "TOPLEFT", -RING, RING)
		m:SetSize(ICON + 2 * RING, ICON + 2 * RING)
	end
	-- The best's frame: accent around the icon, clear of the client's quality
	-- border, on a shade keyline so it holds on parchment and on dark skins.
	m.Key = edges(m, 0)
	m.Ring = edges(m, 1)
	place(m.Ring, m, 0, RING)
	-- The badge's glyph tip lands on the icon's top-left corner.
	m.Badge = m:CreateTexture(nil, "OVERLAY", nil, 2)
	m.Badge:SetSize(BADGE, BADGE)
	m.Badge:SetPoint("TOPLEFT", m, "TOPLEFT", 0, 0)
	m.Badge:SetTexture(ns.Theme and ns.Theme.Media and ns.Theme.Media("qol-upgrade") or nil)
	-- The coin takes the opposite corner, so it sits beside an upgrade arrow.
	m.Coin = m:CreateTexture(nil, "OVERLAY", nil, 2)
	m.Coin:SetSize(BADGE, BADGE)
	m.Coin:SetPoint("TOPRIGHT", m, "TOPRIGHT", 0, 0)
	m.Coin:SetTexture(ns.Theme and ns.Theme.Media and ns.Theme.Media("qol-coin") or nil)
	marks[button] = m
	return m
end

-- up: the upgrade arrow; coin: the most valuable; best: the frame.
local function show(button, up, coin, best)
	local m = markFor(button)
	m.up, m.coin, m.best = up, coin, best
	m.Badge:SetShown(up and true or false)
	m.Coin:SetShown(coin and true or false)
	for k = 1, 4 do
		m.Ring[k]:SetShown(best)
		m.Key[k]:SetShown(best)
	end
	paint(m)
	m:Show()
end

function Rewards.HideMarks()
	for _, m in pairs(marks) do m:Hide() end
end

local function rewardsFrame()
	local f = (QuestInfoFrame and QuestInfoFrame.rewardsFrame) or QuestInfoRewardsFrame
	if not (f and type(f.RewardButtons) == "table") then return nil end
	if f.IsShown and not f:IsShown() then return nil end
	return f
end

local function choiceButtons(frame)
	local out = {}
	for _, b in pairs(frame.RewardButtons) do
		if b and b.type == "choice" and (b.objectType == nil or b.objectType == "item") and b:IsShown() then
			out[b:GetID()] = b
		end
	end
	return out
end

local generation = 0
Rewards.best, Rewards.reason = nil, nil

-- Draw the marks on the shown reward panel. -> whether the best choice is
-- marked, or nil when there is no best to mark.
function Rewards.Mark()
	Rewards.HideMarks()
	if not QoL.On("rewardHighlight") then return nil end
	local frame = rewardsFrame()
	if not frame then return nil end
	local fromLog = QuestInfoFrame and QuestInfoFrame.questLog and true or false
	local choices, complete = Rewards.ReadChoices(fromLog)
	if #choices == 0 then return nil end
	-- The best waits for complete item data, or for auto-pick's settled answer.
	local best, reason
	if #choices >= 2 then
		if complete then
			local order
			order, reason = Rewards.Rank(choices)
			best = order[1]
		elseif not fromLog and Rewards.best then
			best, reason = Rewards.best, Rewards.reason
		end
	end
	-- The coin: the highest vendor value, once every price is known.
	local top = 0
	if #choices >= 2 and complete then
		for _, c in pairs(choices) do
			if c.value > top then top = c.value end
		end
	end
	local buttons = choiceButtons(frame)
	local marked
	if best then marked = false end
	for i, c in pairs(choices) do
		local b = buttons[i]
		if b then
			local up, isBest, coin = isUpgrade(c), i == best, top > 0 and c.value == top
			if up or isBest or coin then
				show(b, up, coin, isBest)
				if isBest then marked = true end
			end
		end
	end
	return marked
end

---------------------------------------------------------------------------
-- Flow
---------------------------------------------------------------------------

local pending = false
local function redraw()
	pending = false
	Rewards.Mark()
end

local function schedule()
	if pending then return end
	pending = true
	if C_Timer and C_Timer.After then C_Timer.After(0, redraw) else redraw() end
end
Rewards.ScheduleMarks = schedule

local function evaluate(gen, tries)
	if gen ~= generation then return end
	local choices, complete = Rewards.ReadChoices(false)
	if #choices < 2 then
		Rewards.Mark()
		return
	end
	if not complete and tries < RETRIES and C_Timer and C_Timer.After then
		-- Meanwhile: the upgrades known so far, without a best.
		if tries == 0 then Rewards.Mark() end
		C_Timer.After(RETRY_DELAY, function() evaluate(gen, tries + 1) end)
		return
	end
	local order, reason = Rewards.Rank(choices)
	local best = order[1]
	Rewards.best, Rewards.reason, Rewards.order = best, reason, order
	local why = reason == "upgrade" and L["upgrade"] or L["best vendor value"]
	if QoL.On("rewardAutoPick") and not QoL.Shift() then
		local money = GetQuestMoneyToGet and GetQuestMoneyToGet() or 0
		if (not money or money == 0) and GetQuestReward then
			GetQuestReward(best)
			ns.Print(format(L["Took %s (%s)."], choices[best].link or ("#" .. best), why))
			return
		end
	end
	if QoL.On("rewardHighlight") and Rewards.Mark() ~= true then
		ns.Print(format(L["Best reward: %s (%s)."], choices[best].link or ("#" .. best), why))
	end
end

local function reset()
	generation = generation + 1
	Rewards.best, Rewards.reason, Rewards.order = nil, nil, nil
	Rewards.HideMarks()
end

function Rewards.OnQuestComplete()
	reset()
	if not (QoL.On("rewardHighlight") or QoL.On("rewardAutoPick")) then return end
	local gen = generation
	-- The panel lays its buttons out in the same event; mark them after it.
	if C_Timer and C_Timer.After then
		C_Timer.After(0, function() evaluate(gen, 0) end)
	else
		evaluate(gen, 0)
	end
end

local hooked = false
local function hook()
	if hooked or not (hooksecurefunc and QuestInfo_Display) then return end
	hooksecurefunc("QuestInfo_Display", schedule)
	hooked = true
end
hook()
ns.OnLogin(hook)

local function shown() return rewardsFrame() ~= nil end

ns.RegisterEvent("QUEST_COMPLETE", Rewards.OnQuestComplete)
ns.RegisterEvent("QUEST_DETAIL", function()
	reset()
	schedule()
end)
ns.RegisterEvent("QUEST_FINISHED", reset)
-- Late item data (links, prices) and new gear verdicts (equipment, spec,
-- level, gear settings) redraw an open panel.
ns.RegisterEvent("GET_ITEM_INFO_RECEIVED", function() if shown() then schedule() end end)
ns.On("GEAR_UPDATED", function() if shown() then schedule() end end)
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.rewardHighlight" or path == "qol" or path == "" then schedule() end
end)
if ns.Theme and ns.Theme.OnChanged then
	ns.Theme.OnChanged(function()
		for _, m in pairs(marks) do
			if m:IsShown() then paint(m) end
		end
	end)
end
