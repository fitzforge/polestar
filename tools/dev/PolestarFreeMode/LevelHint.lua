local _, Free = ...
local ps = Polestar
local Appearance = Free.Appearance
if not (Appearance and Free.Open and ps.Engine and ps.UI.ShowPicker) then return end

local Guide = Appearance.Guide
local C, E, G, W, Theme = ps.Compat, ps.Engine, ps.Guides, ps.Widgets, ps.Theme
local tr = Free.Translate
local TEXT = {
	level = tr("You're level %d. The guide aims for %s.", "目前 %d 級，指南目標是 %s。", "当前 %d 级，指南目标是 %s。"),
	guides = tr("Find a guide for my level", "找適合等級的指南", "找适合等级的指南"),
	planner = tr("Free quest planner", "自由任務規劃器", "自由任务规划器"),
	dismiss = tr("Dismiss this level hint", "關閉這則等級提示", "关闭这条等级提示"),
}

local hint, dismissed, recentSkip, queued
local schedule

local function levelAt(guide, index, level)
	local step = index and guide.steps[index]
	if not step then return end

	-- Most steps only contain things that are available at the current
	-- level. Only ask for a view when there could be a real level gate.
	local gated
	for _, goal in ipairs(step.goals) do
		local need = tonumber(goal.level)
		if goal.t == "level" and need and (need > level or (need == level and goal.frac))
			or (goal.t == "accept" or goal.direct) and (tonumber(goal.minLevel) or 0) > level then
			gated = true
			break
		end
	end
	if not gated then return end
	local view = E.GetStepView(index, true)
	if not view or view.status == "na" then return end

	local target, fraction, pickup
	for i, row in ipairs(view.goals) do
		local goal = step.goals[i]
		if not row.optional and not row.dismissed then
			if row.t == "level" and (row.status == "active" or row.status == "pending") then
				local n, frac = tonumber(goal.level), tonumber(goal.frac)
				if n and (n > level or (n == level and frac and frac > 0))
					and (not target or n + (frac or 0) > target + (fraction or 0)) then
					target, fraction = n, frac
				end
			elseif row.unavailable == "level" and (row.t == "accept" or goal.direct) then
				local n = tonumber(goal.minLevel)
				if n and n > level then pickup = math.min(pickup or n, n) end
			end
		end
	end
	if target then return target, fraction end
	return pickup
end

local function showGuides()
	local current, level = E.GetGuide(), C.GetPlayerLevel()
	local selected
	for _, id in ipairs(G.Suggestions()) do
		if not current or current.id ~= id then
			local lo, hi = G.Levels(G.Get(id))
			if level and lo and level >= lo and level <= (hi or lo) and E.GetGuideState(id) ~= "done" then
				selected = id
				break
			end
		end
	end
	local picker = ps.UI.Picker
	picker.SetView("home")
	ps.UI.ShowPicker({ newTab = true })
	if selected then picker.Select(selected) end
end

local function layout()
	local parent = hint:GetParent()
	hint:SetWidth(parent:GetWidth())
	Appearance.Apply(hint)
	local messageHeight = math.max(20, math.ceil(hint.Message:GetStringHeight()))
	hint.Message:SetHeight(messageHeight)
	Appearance.ButtonText(hint.Guides, TEXT.guides)
	Appearance.ButtonText(hint.Planner, TEXT.planner)
	local stacked = hint.Guides:GetWidth() + hint.Planner:GetWidth() + 26 > parent:GetWidth()
	hint.Planner:ClearAllPoints()
	if stacked then
		hint.Planner:SetPoint("TOPLEFT", hint.Guides, "BOTTOMLEFT", 0, -2)
	else
		hint.Planner:SetPoint("LEFT", hint.Guides, "RIGHT", 4, 0)
	end
	local height = 37 + messageHeight + (stacked and 25 or 0)
	hint:SetHeight(height)
	hint:ClearAllPoints()
	local below = (parent:GetBottom() or height + 8) >= height + 8
	local top, anchor, gap = "TOP", "BOTTOM", -6
	if not below then top, anchor, gap = "BOTTOM", "TOP", 6 end
	hint:SetPoint(top .. "LEFT", parent, anchor .. "LEFT", 0, gap)
end

local function build(parent)
	local F = CreateFrame("Frame", "PolestarFreeModeLevelHint", parent)
	F:SetFrameLevel(parent:GetFrameLevel() + 2)
	F:Hide()
	Appearance.Attach(F)

	local glyph = W.Tex(F, "ARTWORK", nil, "accent")
	glyph:SetTexture(Theme.VerbIcon("level"))
	glyph:SetSize(13, 13)
	glyph:SetPoint("TOPLEFT", F, "TOPLEFT", 11, -12)
	F.Message = Appearance.Text(F, F, "goal", "text", "goalSize")
	F.Message:SetPoint("TOPLEFT", F, "TOPLEFT", 33, -8)
	F.Message:SetPoint("TOPRIGHT", F, "TOPRIGHT", -33, -8)
	F.Message:SetWordWrap(true)
	F.Close = W.IconButton(F, "close", 20, TEXT.dismiss, function()
		dismissed = F.key
		F:Hide()
	end, 11)
	F.Close:SetPoint("TOPRIGHT", F, "TOPRIGHT", -6, -8)

	F.Guides = W.Button(F, TEXT.guides, showGuides, { ghost = true, height = 23 })
	F.Guides:SetPoint("TOPLEFT", F.Message, "BOTTOMLEFT", -8, -3)
	F.Planner = W.Button(F, TEXT.planner, function()
		Free.Open(F.target, F.fraction)
	end, { ghost = true, height = 23 })
	F.Guides.psTight, F.Planner.psTight = true, true
	F.lookTexts[F.Guides.Label], F.lookTexts[F.Planner.Label] = false, false
	return F
end

local function refresh()
	local parent = Guide.frame
	local guide, index = E.GetGuide(), E.GetStepIndex()
	if not (parent and parent:IsVisible() and guide and not Free.IsOpen()) then
		if hint then hint:Hide() end
		return
	end

	local level = C.GetPlayerLevel()
	if not level then
		if hint then hint:Hide() end
		return
	end
	local at = index
	local target, fraction = levelAt(guide, at, level)
	if not target and recentSkip and recentSkip.id == guide.id and recentSkip.next == index then
		at = recentSkip.step
		target, fraction = levelAt(guide, at, level)
	end
	if not target and index and index > 1 then
		-- Restore the choice after /reload if the next step is showing and
		-- the preceding grind was explicitly skipped.
		local skips = ps.CharState().skipped[guide.id]
		if skips and skips[index - 1] == true then
			at = index - 1
			target, fraction = levelAt(guide, at, level)
		end
	end
	if not (target or index) and E.StartGate then
		local gate = E.StartGate(guide.id)
		target = gate and gate.level and gate.level > level and gate.level or nil
	end

	local key = target and (guide.id .. ":" .. (at or 0) .. ":" .. (target + (fraction or 0)))
	if not key or key == dismissed then
		if hint then hint:Hide() end
		return
	end
	if not hint then hint = build(parent) end
	local repaint = hint.key ~= key or hint.level ~= level or not hint:IsShown()
	hint.key, hint.target, hint.fraction, hint.level = key, target, fraction, level
	if repaint then
		Appearance.SetText(hint.Message, TEXT.level:format(level, Free.LevelLabel(target, fraction)))
		layout()
	end
	hint:Show()
end

schedule = function()
	if queued then return end
	queued = true
	C_Timer.After(0, function()
		queued = nil
		refresh()
	end)
end

Free.RefreshHint = schedule
for _, name in ipairs({ "GUIDE_CHANGED", "STEP_CHANGED", "STEP_UPDATED", "GUIDE_VISIBILITY", "GUIDE_COMPLETED" }) do
	ps.On(name, schedule)
end
ps.On("PLAYER_SKIPPED_STEP", function(id, step)
	recentSkip = { id = id, step = step, next = E.GetStepIndex() }
	schedule()
end)

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_LEVEL_UP")
events:SetScript("OnEvent", schedule)
ps.OnLogin(function()
	if Guide.frame then
		Guide.frame:HookScript("OnShow", schedule)
		Guide.frame:HookScript("OnSizeChanged", function()
			if hint and hint:IsVisible() then layout() end
		end)
	end
	schedule()
end)
Appearance.Watch(function()
	if hint and hint:IsVisible() then layout() end
end)
