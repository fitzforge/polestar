-- Completed quest rewards on the game's XP bar. The native XP and rested fills stay untouched.
local ADDON, ns = ...
local L, QoL, C = ns.L, ns.QoL, ns.Compat
local min, max, format = math.min, math.max, string.format

local QuestXP = { total = 0, count = 0 }
QoL.QuestXP = QuestXP

local frame
local hookedShows, hookedTips, hookedRested = {}, {}, {}
local excluded = {}
local dirty = true
local schedule
local SAGE_R, SAGE_G, SAGE_B = 156 / 255, 183 / 255, 167 / 255

local function draw()
	if not frame then return end
	if not QoL.On("questXPOverlay") then frame:Hide(); return end
	local xp, limit, total = QuestXP.xp, QuestXP.limit, QuestXP.total
	if not (xp and limit and limit > 0 and total > 0) then frame:Hide(); return end
	local start = min(1, max(0, xp / limit))
	local finish = min(1, max(start, (xp + total) / limit))
	local width = frame:GetWidth() or 0
	if finish <= start or width <= 0 then frame:Hide(); return end
	local height = frame:GetHeight()
	local inset = min(2, width / 4, height / 4)
	local innerLeft = max(start * width, inset)
	local innerRight = min(finish * width, width - inset)
	local tintWidth = innerRight - innerLeft
	local tint = frame.Tint
	tint:SetShown(tintWidth > 0 and height > 0)
	if tint:IsShown() then
		tint:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", innerLeft, inset - 0.5)
		tint:SetSize(tintWidth - min(1, tintWidth / 2), height - 2 * inset)
	end
	frame.Rested:SetShown(tint:IsShown() and frame.restedTick ~= nil and frame.restedTick:IsShown())
	frame.LevelLabel:SetShown(xp + total >= limit)
	frame:Show()
end

local function attach(bar)
	if not frame then
		frame = ns.CreateFrameUnder("Frame", nil, bar)
		frame:EnableMouse(false)
		frame:SetAlpha(0.8)
		frame.Tint = frame:CreateTexture(nil, "OVERLAY")
		frame.Tint:SetTexture(ns.Theme.Media("white"))
		frame.Tint:SetVertexColor(SAGE_R, SAGE_G, SAGE_B, 0.36)
		local mask = frame:CreateMaskTexture()
		mask:SetAtlas("UI-HUD-ExperienceBar-Fill-Experience", false, nil, true, "CLAMPTOBLACKADDITIONAL", "CLAMPTOBLACKADDITIONAL")
		mask:SetAllPoints(frame)
		frame.Tint:AddMaskTexture(mask)
		local rested = ns.CreateFrameUnder("Frame", nil, frame)
		rested:EnableMouse(false)
		local pip = rested:CreateTexture(nil, "OVERLAY")
		pip:SetAtlas("UI-HUD-ExperienceBar-Frame-Pip")
		pip:SetAllPoints(rested)
		pip:SetDesaturated(true)
		pip:SetVertexColor(0.55, 0.85, 1)
		frame.Rested = rested
		frame.LevelLabel = frame:CreateFontString(nil, "OVERLAY")
		if ns.Theme and ns.Theme.Font then ns.Theme.Font(frame.LevelLabel, "small") end
		if ns.Theme and ns.Theme.SetOutline then ns.Theme.SetOutline(frame.LevelLabel, true) end
		frame.LevelLabel:SetText(L["+1 Level"])
		frame.LevelLabel:SetTextColor(SAGE_R, SAGE_G, SAGE_B, 1)
		frame.LevelLabel:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, 2)
		frame:SetScript("OnSizeChanged", draw)
		QuestXP.frame = frame
	end
	if frame.bar ~= bar then
		frame.bar = bar
		frame:SetParent(bar)
		frame:ClearAllPoints()
		frame:SetAllPoints(bar.StatusBar)
	end
	frame:SetFrameStrata("MEDIUM")
	local overlay = bar.OverlayFrame
	frame:SetFrameLevel(max(1, (overlay and overlay:GetFrameLevel() or bar:GetFrameLevel()) - 1))
	local tick = type(bar.ExhaustionTick) == "table" and bar.ExhaustionTick or nil
	frame.Rested:SetFrameStrata(frame:GetFrameStrata())
	frame.Rested:SetFrameLevel(max(frame:GetFrameLevel(), tick and tick:GetFrameLevel() or 0) + 1)
	if tick ~= frame.restedTick then
		frame.restedTick = tick
		frame.Rested:ClearAllPoints()
		if tick then frame.Rested:SetAllPoints(tick) end
	end
	draw()
end

local function xpTooltip()
	return GetAppropriateTooltip and GetAppropriateTooltip() or GameTooltip
end

local function tooltip(owner)
	if not QoL.On("questXPOverlay") or QuestXP.total <= 0 then return end
	local tip = xpTooltip()
	if not tip then return end
	if tip:IsShown() then
		local currentOwner = tip:GetOwner()
		if currentOwner ~= UIParent and currentOwner ~= owner then return end
	else
		tip:SetOwner(owner, "ANCHOR_TOP")
		tip:SetText(L["Experience"])
		tip:AddDoubleLine(L["Current XP"], format("%d / %d (%.1f%%)", QuestXP.xp, QuestXP.limit, QuestXP.xp / QuestXP.limit * 100))
		local rested = C.Readable(GetXPExhaustion and GetXPExhaustion())
		if type(rested) == "number" and rested > 0 then
			tip:AddDoubleLine(L["Rested XP"], format("%d", rested))
		end
	end
	tip:AddLine(" ")
	tip:AddDoubleLine(L["Completed quests"], format("%d", QuestXP.count))
	tip:AddDoubleLine(L["Pending Quest XP"], format("+%d (%.1f%%)", QuestXP.total, QuestXP.total / QuestXP.limit * 100), SAGE_R, SAGE_G, SAGE_B, SAGE_R, SAGE_G, SAGE_B)
	if QuestXP.xp + QuestXP.total >= QuestXP.limit then
		tip:AddLine(L["After turn-ins: at least +1 level"], SAGE_R, SAGE_G, SAGE_B)
	else
		local projected = QuestXP.xp + QuestXP.total
		tip:AddDoubleLine(L["XP after turn-ins"], format("%d / %d (%.1f%%)", projected, QuestXP.limit, projected / QuestXP.limit * 100), SAGE_R, SAGE_G, SAGE_B, SAGE_R, SAGE_G, SAGE_B)
		tip:AddDoubleLine(L["XP remaining after turn-ins"], format("%d", QuestXP.limit - projected))
	end
	tip:Show()
end

local function hideOwnedTooltip(owner)
	local tip = xpTooltip()
	if tip and tip:GetOwner() == owner then tip:Hide() end
end

local function hookTooltip(owner)
	if hookedTips[owner] then return end
	owner:HookScript("OnEnter", tooltip)
	owner:HookScript("OnLeave", hideOwnedTooltip)
	hookedTips[owner] = true
end

local function hook(bar)
	if not hookedShows[bar] then
		bar:HookScript("OnShow", function() schedule() end)
		hookedShows[bar] = true
	end
	hookTooltip(bar)
	local tick = bar.ExhaustionTick
	if type(tick) == "table" then
		hookTooltip(tick)
		if not hookedRested[tick] then
			tick:HookScript("OnShow", schedule)
			tick:HookScript("OnHide", schedule)
			hookedRested[tick] = true
		end
	end
end

local function hookBars()
	local info, manager = StatusTrackingBarInfo, StatusTrackingBarManager
	local exp = type(info) == "table" and type(info.BarsEnum) == "table" and info.BarsEnum.Experience
	local containers = exp and type(manager) == "table" and manager.barContainers
	if type(containers) ~= "table" then return end
	for i = 1, #containers do
		local bars = containers[i].bars
		local bar = type(bars) == "table" and bars[exp]
		if bar and bar.HookScript then hook(bar) end
	end
end

function QuestXP.Refresh()
	if not QoL.On("questXPOverlay") then
		if frame then frame:Hide() end
		return
	end
	hookBars()
	local bar = QoL.XPMark.Bar()
	if not bar then if frame then frame:Hide() end; return end
	local xp = C.Readable(UnitXP and UnitXP("player"))
	local limit = C.Readable(UnitXPMax and UnitXPMax("player"))
	local level = C.Readable(UnitLevel and UnitLevel("player"))
	local cap = C.Readable(GetMaxPlayerLevel and GetMaxPlayerLevel())
	if type(xp) ~= "number" or type(limit) ~= "number" or limit <= 0 or (cap and level and level >= cap) then
		if frame then frame:Hide() end
		QuestXP.total, QuestXP.count = 0, 0
		return
	end
	if dirty then
		local total, count = 0, 0
		for id in pairs(excluded) do if not C.IsOnQuest(id) then excluded[id] = nil end end
		if type(GetQuestLogRewardXP) == "function" then
			for _, questID in ipairs(C.GetLogQuests()) do
				if not excluded[questID] and C.IsQuestReadyForTurnIn(questID) then
					local ok, reward = pcall(GetQuestLogRewardXP, questID)
					reward = ok and C.Readable(reward) or nil
					if type(reward) == "number" and reward > 0 then
						total, count = total + reward, count + 1
					end
				end
			end
		end
		QuestXP.total, QuestXP.count = total, count
		dirty = false
	end
	QuestXP.xp, QuestXP.limit = xp, limit
	if QuestXP.total > 0 then attach(bar)
	elseif frame then frame:Hide() end
end

schedule = QoL.Coalesce(QuestXP.Refresh)
local function rescan()
	dirty = true
	schedule()
end
local key = "questXPOverlay"
for _, event in ipairs({ "QUEST_LOG_UPDATE", "QUEST_DATA_LOAD_RESULT", "PLAYER_LEVEL_UP", "PLAYER_ENTERING_WORLD" }) do
	QoL.WhileOn(key, event, rescan)
end
QoL.WhileOn(key, "PLAYER_XP_UPDATE", schedule)
for _, event in ipairs({ "QUEST_TURNED_IN", "QUEST_REMOVED" }) do
	QoL.WhileOn(key, event, function(_, id)
		id = C.Readable(id)
		if type(id) == "number" then excluded[id] = true end
		rescan()
	end)
end
QoL.WhileOn(key, "QUEST_ACCEPTED", function(_, id)
	id = C.Readable(id)
	if type(id) == "number" then excluded[id] = nil end
	rescan()
end)
ns.OnLogin(rescan)
ns.On("SETTING_CHANGED", function(path)
	if path == "qol" or path == "" or path == "qol." .. key then
		if not QoL.On(key) then
			for id in pairs(excluded) do excluded[id] = nil end
		end
		rescan()
	end
end)
