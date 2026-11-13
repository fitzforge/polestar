-- luacheck: read globals GetQuestID
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
--     shows beside the upgrade arrows; ties all get it, no price no coin;
--   * with an upgrade arrow among them, what the arrows were scored for at
--     the right of the panel's Rewards heading ("Scored for Arcane", #2035):
--     its tooltip says where the weights came from (Gear.ScoredFor), a click
--     opens Stat weights (Gear.ShowWeightsSetting). Panels without that
--     heading (the map's quest details) have none; their choices' tooltips
--     say it.
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

-- Gear intentionally returns no comparison for consumables and inventory
-- types it does not score (bags, shirts, tabards...). A known unscored type
-- is a settled non-upgrade; missing facts about a scored type are not.
local function unscored(G, probe, id)
	local slots = G.SLOTS_OF
	if not slots then return false end
	local D = ns.ItemDB
	local rec = id and D and D.Get and D.Get(id)
	if rec and type(rec.inv) == "number" then return slots[rec.inv] == nil end
	local C = G.Client
	local loc = C and C.ItemInfo and ns.Compat.Readable(C.ItemInfo(probe))
	if type(loc) ~= "string" then return false end
	if loc == "" then return true end
	local inv = G.EQUIP_LOC and G.EQUIP_LOC[loc]
	return inv ~= nil and slots[inv] == nil
end

-- Read the shown choices (the quest giver's panel, or the quest log's when
-- fromLog). complete = every link, price and enabled gear verdict known;
-- priced = every link and price known (the coin needs no gear verdict).
function Rewards.ReadChoices(fromLog)
	local n = numChoices(fromLog)
	local list, complete, priced = {}, true, true
	local G = gear()
	for i = 1, n do
		local link, count, itemID = choiceInfo(i, fromLog)
		local price = Client.SellPrice(link or itemID)
		if not link or price == nil then complete, priced = false, false end
		local stack = (count and count > 0) and count or 1
		local c = { index = i, link = link, itemID = itemID, count = count or 1, value = (price or 0) * stack }
		-- Gear can judge an uncached choice from its ID (ItemDB stats).
		local probe = link or (type(itemID) == "number" and itemID > 0 and "item:" .. itemID) or nil
		if G and probe then
			local up, delta = G.IsUpgrade(probe)
			c.upgrade, c.delta = up and true or false, delta
			-- false,nil means both "not usable" and "not loaded yet" in
			-- IsUpgrade. Only a settled comparison distinguishes the two.
			local verdict = G.CompareToEquipped and G.CompareToEquipped(probe)
			if (not verdict and not unscored(G, probe, itemID)) or (verdict and verdict.usable and delta == nil) then
				complete = false
			end
		elseif G then
			complete = false
		end
		list[i] = c
	end
	return list, complete, priced
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

---------------------------------------------------------------------------
-- What the upgrade arrows were scored for
---------------------------------------------------------------------------

local SCORED_ARROW = 14 -- the arrow beside the line: the badge's glyph at the line's height
local scored -- the line (a button), made the first time it shows

local function scoredTip(self)
	local G = ns.Gear
	local W = ns.Widgets
	local text = G and G.ScoredFor and G.ScoredFor()
	if text and W and W.Tooltip then W.Tooltip(self, "ANCHOR_TOP", text, { L["Click: choose the stat weights"] }) end
end

-- Made under the rewards frame it first shows on (listed in hide-all.rs's
-- SURFACES: Rewards.Mark hides it while Polestar is hidden).
local function scoredButton(frame)
	if scored then return scored end
	local W, T = ns.Widgets, ns.Theme
	local b = ns.CreateFrameUnder("Button", nil, frame)
	b:SetHeight(18)
	b.Arrow = b:CreateTexture(nil, "ARTWORK")
	b.Arrow:SetSize(SCORED_ARROW, SCORED_ARROW)
	b.Arrow:SetPoint("LEFT", b, "LEFT", 0, 0)
	b.Arrow:SetTexture(T and T.Media and T.Media("qol-upgrade") or nil)
	b.Text = W.Text(b, "small", "text")
	b.Text:SetPoint("LEFT", b.Arrow, "RIGHT", 1, 0)
	b.Text:SetJustifyH("LEFT")
	b.Text:SetWordWrap(false)
	b:SetScript("OnEnter", scoredTip)
	b:SetScript("OnLeave", function(self) if W.HideTooltip then W.HideTooltip(self) end end)
	b:SetScript("OnClick", function()
		local G = ns.Gear
		if G and G.ShowWeightsSetting then G.ShowWeightsSetting() end
	end)
	scored = b
	return b
end

-- The line at the right of frame's Rewards heading, in the panel's own text
-- colour (its quest material's: the choose line's), so it reads on parchment
-- and stone alike; the arrow in the look's success colour, as on the icons;
-- the look's small font. It keeps clear of the heading's text. The map's
-- quest details (MapQuestInfoRewardsFrame) have no heading: their Header is
-- an anchor-only frame, so they get no line; nor does a panel without a
-- Header (a stand-in, another addon's), whose fields may be anything.
local function showScored(frame)
	local head = frame.Header
	local G = ns.Gear
	local text = G and G.ScoredFor and G.ScoredFor(true)
	if not (text and type(head) == "table" and head.GetObjectType and head:GetObjectType() == "FontString" and head:IsShown()) then return end
	local b = scoredButton(frame)
	if b:GetParent() ~= frame then b:SetParent(frame) end
	b:SetFrameLevel((frame:GetFrameLevel() or 1) + 5)
	b.Text:SetWidth(0) -- unbounded, to measure the whole text
	b.Text:SetText(text)
	local W = ns.Widgets
	local choose = frame.ItemChooseText
	local r, g, bl
	if type(choose) == "table" and choose.GetTextColor then r, g, bl = choose:GetTextColor() end
	if type(r) == "number" then
		W.Uncolor(b.Text)
		b.Text:SetTextColor(r, g, bl, 1)
	else
		W.Color(b.Text, "text")
	end
	W.Color(b.Arrow, "success")
	local room = (frame:GetWidth() or 285) - (head:GetStringWidth() or 0) - 12 - SCORED_ARROW - 1
	local w = math.max(0, math.min(b.Text:GetStringWidth() or 0, room))
	b.Text:SetWidth(w)
	b:SetWidth(SCORED_ARROW + 1 + w)
	b:ClearAllPoints()
	b:SetPoint("RIGHT", head, "RIGHT", 0, 0)
	b:SetShown(w > 0)
end

function Rewards.HideMarks()
	for _, m in pairs(marks) do m:Hide() end
	if scored then scored:Hide() end
end
Rewards.ScoredLine = function() return scored end

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

-- Draw the marks on the shown reward panel (none while Polestar is hidden).
-- -> whether the best choice is marked, or nil when there is no best to mark.
function Rewards.Mark()
	Rewards.HideMarks()
	if not QoL.On("rewardHighlight") or ns.Hidden() then return nil end
	local frame = rewardsFrame()
	if not frame then return nil end
	local fromLog = QuestInfoFrame and QuestInfoFrame.questLog and true or false
	local choices, complete, priced = Rewards.ReadChoices(fromLog)
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
	if #choices >= 2 and priced then
		for _, c in pairs(choices) do
			if c.value > top then top = c.value end
		end
	end
	local buttons = choiceButtons(frame)
	local marked, anyUp
	if best then marked = false end
	for i, c in pairs(choices) do
		local b = buttons[i]
		if b then
			local up, isBest, coin = isUpgrade(c), i == best, top > 0 and c.value == top
			if up or isBest or coin then
				show(b, up, coin, isBest)
				if isBest then marked = true end
				if up then anyUp = true end
			end
		end
	end
	if anyUp then showScored(frame) end
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
	if C_Timer and C_Timer.After then ns.After(0, redraw) else redraw() end
end
Rewards.ScheduleMarks = schedule

local function questID()
	local q = GetQuestID and ns.Compat.Readable(GetQuestID())
	return type(q) == "number" and q > 0 and q or nil
end

-- Whether auto-pick may take a reward from the panel of `quest` now.
local function mayTake(gen, quest)
	return gen == generation and quest and questID() == quest and QoL.On("rewardAutoPick") and not QoL.Shift()
end

local function evaluate(gen, tries, quest)
	if gen ~= generation then return end
	if quest and questID() ~= quest then return end
	local choices, complete = Rewards.ReadChoices(false)
	if #choices < 2 then
		Rewards.Mark()
		return
	end
	if not complete and tries < RETRIES and C_Timer and C_Timer.After then
		-- Meanwhile: the upgrades known so far, without a best.
		if tries == 0 then Rewards.Mark() end
		ns.After(RETRY_DELAY, function() evaluate(gen, tries + 1, quest) end)
		return
	end
	-- A retry deadline is not evidence that the missing choice is worse.
	-- Leave an incomplete ranking to the player instead of committing it.
	if not complete then Rewards.Mark(); return end
	local order, reason = Rewards.Rank(choices)
	local best = order[1]
	Rewards.best, Rewards.reason, Rewards.order = best, reason, order
	local why = reason == "upgrade" and L["upgrade"] or L["best vendor value"]
	if mayTake(gen, quest) then
		local money = GetQuestMoneyToGet and ns.Compat.Readable(GetQuestMoneyToGet())
		if money == 0 and GetQuestReward then
			local function take()
				GetQuestReward(best)
				ns.Print(format(L["Took %s (%s)."], choices[best].link or ("#" .. best), why))
			end
			-- Automation's wait for Spoken: the marks show until it ends, and stay if Shift stops it.
			local delay = ns.Automation and ns.Automation.Delay()
			if not delay then return take() end
			Rewards.Mark()
			ns.After(delay, function() if mayTake(gen, quest) then take() end end)
			return
		end
	end
	if QoL.On("rewardHighlight") and not ns.Hidden() and Rewards.Mark() ~= true then
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
	local gen, quest = generation, questID()
	-- The panel lays its buttons out in the same event; mark them after it.
	if C_Timer and C_Timer.After then
		ns.After(0, function() evaluate(gen, 0, quest) end)
	else
		evaluate(gen, 0, quest)
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
	if path == "qol.rewardAutoPick" or path == "qol.rewardHighlight" or path == "qol" or path == "" then
		reset()
		schedule()
	end
end)
ns.On("POLESTAR_HIDDEN", function() if shown() then schedule() end end)
if ns.Theme and ns.Theme.OnChanged then
	ns.Theme.OnChanged(function()
		for _, m in pairs(marks) do
			if m:IsShown() then paint(m) end
		end
	end)
end
