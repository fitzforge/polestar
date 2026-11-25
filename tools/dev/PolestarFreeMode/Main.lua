local ADDON, Free = ...
local ps = Polestar
local Planner, Appearance, Targets = Free.Planner, Free.Appearance, Free.Targets
if not (Appearance and ps.Lookup and ps.Lookup.QuestStep and ps.Codex and ps.Nav and ps.DirectTravelCost) then return end

local C, Nav, W, Theme = ps.Compat, ps.Nav, ps.Widgets, ps.Theme
local Guide = Appearance.Guide
local lang = GetLocale()
local function tr(en, tw, cn)
	if lang == "zhTW" then return tw end
	if lang == "zhCN" then return cn end
	return en
end
Free.Translate = tr
local TEXT = {
	title = tr("Free quest planner", "自由任務規劃器", "自由任务规划器"),
	distance = tr("Distance first", "距離優先", "距离优先"),
	xp = tr("XP priority", "經驗優先", "经验优先"),
	auto = tr("Auto select", "自動選擇", "自动选择"),
	back = tr("Back to guide", "返回指南", "返回指南"),
	pinned = tr("Pinned", "已固定", "已固定"),
	current = tr("Guiding", "導航中", "导航中"),
	ready = tr("Turn in", "繳交", "交付"),
	failed = tr("Failed", "任務失敗", "任务失败"),
	group = tr("Group", "建議組隊", "建议组队"),
	hard = tr("Higher level", "等級偏高", "等级偏高"),
	unmapped = tr("No waypoint", "缺少座標", "缺少坐标"),
	unknown = tr("Waiting for your position", "正在等待角色位置", "正在等待角色位置"),
	none = tr("No quests with waypoints here", "暫無可導航的任務", "暂无可导航的任务"),
	empty = tr("Your quest log is empty", "任務日誌目前沒有任務", "任务日志目前没有任务"),
	other = tr("Another waypoint is active. Click a quest to take over.", "箭頭正指向其他地點，點任務可切換。", "箭头正指向其他地点，点任务可切换。"),
	held = tr("Waiting for the current trip to end", "等待目前的特殊導航結束", "等待当前的特殊导航结束"),
	combat = tr("Updates resume after combat", "離開戰鬥後更新", "离开战斗后更新"),
	instance = tr("Outdoor route resumes outside the instance", "離開副本後繼續規劃", "离开副本后继续规划"),
	reached = tr("Reached %s. Back to the guide.", "已到 %s，返回原指南。", "已到 %s，返回原指南。"),
	usage = tr("/psfree [target level] or /psfree off", "/psfree [目標等級] 或 /psfree off", "/psfree [目标等级] 或 /psfree off"),
	tip = tr("Click to pin. Right-click to open the quest log.", "點選可固定。右鍵開啟任務日誌。", "点击可固定。右键打开任务日志。"),
	yard = tr("%d yd", "%d 碼", "%d 码"),
	xpValue = tr("~%s XP", "約 %s 經驗", "约 %s 经验"),
	summary = tr("%d/%d quests with waypoints", "%d/%d 個任務可導航", "%d/%d 个任务可导航"),
	level = tr("Level %d", "%d 級", "%d 级"),
	target = tr("Target %s", "目標 %s", "目标 %s"),
	pickTarget = tr("Target level", "目標等級", "目标等级"),
	noTarget = tr("No level target", "不限等級", "不限等级"),
	route = tr("Route", "路線", "路线"),
	targets = tr("Quest targets", "任務目標", "任务目标"),
	choose = tr("Choose quests", "選擇任務", "选择任务"),
	switchQuest = tr("Switch quest", "切換任務", "切换任务"),
	followRoute = tr("Follow route", "跟隨路線", "跟随路线"),
	noTargets = tr("No creature or NPC targets known for this quest.", "這個任務目前沒有可選取的怪物或 NPC。", "这个任务目前没有可选取的怪物或 NPC。"),
	targetsUnavailable = tr("This Polestar version has no planner target connection.", "這版北極星尚未連接自由規劃器的目標來源。", "这版北极星尚未连接自由规划器的目标来源。"),
	targetsDisabled = tr("Enable the target button in Polestar’s Targeting settings.", "請在北極星的目標選取設定開啟目標按鈕。", "请在北极星的目标选取设置开启目标按钮。"),
	nativeTargets = tr("Click a name in Polestar’s target list. Fold the list to search for several targets.", "點北極星目標清單的名字選取。收合清單可搜尋多個目標。", "点北极星目标列表的名字选取。折叠列表可搜索多个目标。"),
	simpleTargets = tr("Use Polestar’s target button to find a nearby target.", "用北極星的準星按鈕搜尋附近目標。", "用北极星的准星按钮搜索附近目标。"),
	choiceSummary = tr("%d of %d quests included", "已選 %d/%d 個已接任務", "已选 %d/%d 个已接任务"),
	unselected = tr("No quests selected. Choose quests to include.", "目前未選取任務。到「選擇任務」加回。", "当前未选择任务。到「选择任务」添加回来。"),
	turninArrow = tr("Turn in %s", "繳交 %s", "交付 %s"),
}

local function levelLabel(level, fraction)
	local label = TEXT.level:format(level)
	if not fraction then return label end
	return label .. (" %.0f%%"):format(fraction * 100)
end
Free.LevelLabel = levelLabel

local WIDTH, HEIGHT, TARGET_HEIGHT, ROW = 414, 396, 180, 40
local panel, session, owned, queued, changingWorld
local knowledge = Planner.New()
local refresh, stop, setView, renderChoices, renderTargets, showTargetMenu, showQuestMenu

local function exclusions()
	if type(PolestarFreeModeCharDB) ~= "table" then PolestarFreeModeCharDB = {} end
	local saved = PolestarFreeModeCharDB
	if type(saved.excluded) ~= "table" then saved.excluded = {} end
	return saved.excluded
end

local function printStatus(text)
	ps.Print(TEXT.title .. "  " .. text)
end

local function releaseArrow()
	if not owned or C.InCombat() or Nav.IsHeld() then return end
	if Nav.GetTarget() == owned then Nav.ReleaseTarget() end
	owned = nil
end

local function aim(row, force)
	if Nav.IsHeld() then return TEXT.held end
	local target = Nav.GetTarget()
	if not force and Nav.IsOverride() and target ~= owned then return TEXT.other end
	local p = row.point
	local label = row.ready and TEXT.turninArrow:format(row.title) or row.title
	if owned and target == owned and target.map == p.map and target.x == p.x and target.y == p.y
		and target.f == p.f and target.z == p.z and target.label == label then return nil end
	owned = Nav.SetTarget(p.map, p.x, p.y, label, p.f, nil, p.z) or nil
	if not owned then return TEXT.unknown end
end

local function buildPanel()
	local F = CreateFrame("Frame", "PolestarFreeModeWindow", UIParent)
	F:SetFrameStrata("LOW")
	F:SetClampedToScreen(true)
	F:SetMovable(true)
	F:EnableMouse(true)
	F:SetSize(WIDTH, HEIGHT)
	F:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 34, -165)
	F:Hide()

	local header = CreateFrame("Frame", nil, F)
	header:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	header:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	header:SetHeight(39)
	ps.DragWindow(header, F)
	Appearance.Attach(F, header)
	F.Title = Appearance.Text(F, header, "title", "text", "titleSize")
	F.Title:SetPoint("LEFT", header, "LEFT", 16, 0)
	F.Close = W.IconButton(header, "close", 28, TEXT.back, function() stop() end, 14)
	F.Close:SetPoint("RIGHT", header, "RIGHT", -10, 0)
	F.Title:SetPoint("RIGHT", F.Close, "LEFT", -6, 0)

	F.TabRow = CreateFrame("Frame", nil, F)
	F.TabRow:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 12, 0)
	F.TabRow:SetPoint("TOPRIGHT", header, "BOTTOMRIGHT", -12, 0)
	F.TabRow:SetHeight(26)
	F.Tabs, F.view = {}, "route"
	for i, key in ipairs({ "route", "targets", "quests" }) do
		local t = CreateFrame("Button", nil, F.TabRow)
		local width = (WIDTH - 26) / 3
		t:SetSize(width, 26)
		t:SetPoint("TOPLEFT", F.TabRow, "TOPLEFT", (i - 1) * width, 0)
		t.Label = Appearance.Text(F, t, "label", "textDim")
		t.Label:SetPoint("LEFT", t, "LEFT", 2, 0)
		t.Label:SetPoint("RIGHT", t, "RIGHT", -2, 0)
		t.Label:SetJustifyH("CENTER")
		t.Label:SetWordWrap(false)
		Appearance.SetText(t.Label, key == "quests" and TEXT.choose or TEXT[key])
		Theme.Skin(t, "tab")
		t:SetScript("OnClick", function() setView(key) end)
		F.Tabs[key] = t
	end

	F.Target = W.Button(F, TEXT.pickTarget, function(button) showTargetMenu(button) end,
		{ ghost = true, height = 24, icon = "chevron-down" })
	F.Target:SetPoint("TOPRIGHT", F.TabRow, "BOTTOMRIGHT", 0, -2)
	F.TargetQuest = W.Button(F, TEXT.switchQuest, function(button) showQuestMenu(button) end,
		{ ghost = true, height = 24, icon = "chevron-down" })
	F.TargetQuest:SetPoint("TOPRIGHT", F.TabRow, "BOTTOMRIGHT", 0, -2)
	F.Summary = Appearance.Text(F, F, "label", "text", "barTextSize")
	F.Summary:SetWordWrap(false)
	F.Status = Appearance.Text(F, F, "note", "textDim", "noteSize")
	F.Status:SetPoint("TOPLEFT", F.Summary, "BOTTOMLEFT", 0, -5)
	F.Status:SetWidth(WIDTH - 32)
	F.Status:SetWordWrap(true)

	F.List = W.Scroll(F)
	F.Choices = W.Scroll(F)
	F.Choices:Hide()
	F.FooterRule = W.Divider(F)
	F.FooterRule:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 13, 42)
	F.FooterRule:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -13, 42)
	F.List.Child:SetWidth(WIDTH - 43)
	F.Choices.Child:SetWidth(WIDTH - 43)
	F.rows, F.choiceRows = {}, {}

	F.Sort = W.Button(F, TEXT.xp, function()
		session.order = session.order == "xp" and "distance" or "xp"
		session.selected = nil
		refresh()
	end, { ghost = true, height = 26 })
	F.Sort:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 13, 11)
	F.Auto = W.Button(F, TEXT.auto, function()
		session.pinned, session.selected = nil, nil
		refresh(true)
	end, { ghost = true, height = 26 })
	F.Auto:SetPoint("LEFT", F.Sort, "RIGHT", 6, 0)
	F.Back = W.Button(F, TEXT.back, function() stop() end, { ghost = true, height = 26 })
	F.Back:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -13, 11)
	for _, button in ipairs({ F.Sort, F.Auto, F.Back, F.TargetQuest, F.Target }) do
		button.psTight = true
		F.lookTexts[button.Label] = false
	end
	F.rowHeight = ROW
	Appearance.SetText(F.Title, TEXT.title)
	return F
end

local function placeRow(F, row, index)
	row:SetSize(WIDTH - 43, F.rowHeight - 2)
	row:ClearAllPoints()
	row:SetPoint("TOPLEFT", F.List.Child, "TOPLEFT", 1, -(index - 1) * F.rowHeight)
end

local function layoutList(F)
	if F.view == "targets" then return end
	local text = F.Status:GetText()
	local anchor = text and text ~= "" and F.Status or F.Summary
	local list = F.view == "quests" and F.Choices or F.List
	list:ClearAllPoints()
	list:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", -4, -9)
	list:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -10, 49)
	local content = list == F.Choices and F.choicesHeight or (F.visibleRows or 0) * F.rowHeight
	W.SetScrollContent(list, content, list:GetHeight())
end

local function targetLabel(F)
	local level = session.targetLevel and levelLabel(session.targetLevel, session.fraction)
	Appearance.ButtonText(F.Target, level and TEXT.target:format(level) or TEXT.pickTarget)
end

local function paintControls(F)
	local route, targets = F.view == "route", F.view == "targets"
	F.List:SetShown(route)
	F.Choices:SetShown(F.view == "quests")
	F:SetHeight(targets and TARGET_HEIGHT or HEIGHT)
	F.Sort:SetShown(route)
	F.Auto:SetShown(route)
	F.Target:SetShown(route)
	F.TargetQuest:SetShown(targets)
	for key, tab in pairs(F.Tabs) do
		Theme.SetTabSelected(tab, key == F.view)
		W.Color(tab.Label, key == F.view and "accent" or "textDim")
	end
	F.Summary:ClearAllPoints()
	F.Summary:SetPoint("TOPLEFT", F.TabRow, "BOTTOMLEFT", 3, -7)
	local right = route and F.Target or targets and F.TargetQuest
	if right then
		F.Summary:SetPoint("TOPRIGHT", right, "TOPLEFT", -7, -5)
	else
		F.Summary:SetPoint("TOPRIGHT", F.TabRow, "BOTTOMRIGHT", -3, -7)
	end
	Appearance.ButtonText(F.TargetQuest, TEXT.switchQuest)
	Appearance.ButtonText(F.Sort, session.order == "xp" and TEXT.xp or TEXT.distance)
	Appearance.ButtonText(F.Auto, TEXT.auto)
	Appearance.ButtonText(F.Back, TEXT.back)
	targetLabel(F)
end

local function paintPanel(F)
	F:SetScale(tonumber(ps.Get("ui.scale")) or 1)
	Appearance.Apply(F)
	F.FooterRule:SetShown(not F.psBare and Guide.On("rules"))
	paintControls(F)
	local newHeight = ROW
	local first = F.rows[1]
	if first then
		local _, titleSize = first.Title:GetFont()
		local _, detailSize = first.Detail:GetFont()
		newHeight = math.max(ROW, math.ceil((titleSize or 14) + (detailSize or 12) + 12 + Guide.Num("rowSpacing")))
	end
	local changed = newHeight ~= F.rowHeight
	F.rowHeight = newHeight
	for i, row in ipairs(F.rows) do
		Guide.PaintMark(row.Mark)
		if changed then placeRow(F, row, i) end
	end
	if F.view == "quests" then
		renderChoices(F)
	elseif F.view == "targets" then
		renderTargets(F)
	else
		layoutList(F)
	end
end

local function rowHover(row)
	local wash = W.Tex(row, "HIGHLIGHT", nil, nil, -3)
	wash:SetAllPoints(row)
	W.Painter(wash, function(t) t:SetVertexColor(Theme.Wash("hover")) end)
end

local function rowAt(i)
	local r = panel.rows[i]
	if r then return r end
	r = CreateFrame("Button", nil, panel.List.Child)
	placeRow(panel, r, i)
	rowHover(r)
	r:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	r.Mark = W.Tex(r, "ARTWORK")
	r.Mark:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -4)
	r.Mark:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 4)
	W.Painter(r.Mark, Guide.PaintMark)
	r.Icon = W.Tex(r, "ARTWORK", nil, "icon")
	r.Icon:SetSize(13, 13)
	r.Icon:SetPoint("TOPLEFT", r, "TOPLEFT", 9, -5)
	r.Title = Appearance.Text(panel, r, "goal", "text", "goalSize")
	r.Title:SetPoint("TOPLEFT", r, "TOPLEFT", 29, -4)
	r.Title:SetPoint("TOPRIGHT", r, "TOPRIGHT", -6, -4)
	r.Detail = Appearance.Text(panel, r, "small", "textDim", "detailSize")
	r.Detail:SetPoint("TOPLEFT", r.Title, "BOTTOMLEFT", 0, -3)
	r.Detail:SetPoint("TOPRIGHT", r.Title, "BOTTOMRIGHT", 0, -3)
	r:SetScript("OnClick", function(self, button)
		local row = self.planRow
		if not (row and session) then return end
		if button == "RightButton" then
			C.OpenQuestLog(row.id)
		elseif row.point then
			session.pinned = session.pinned ~= row.id and row.id or nil
			session.selected = nil
			refresh(true)
		end
	end)
	r:SetScript("OnEnter", function(self)
		local row = self.planRow
		if not row then return end
		local lines = { self.Detail:GetText() }
		if row.hint and row.hint ~= "" and not row.hint:find("{", 1, true) then lines[#lines + 1] = row.hint end
		lines[#lines + 1] = TEXT.tip
		W.Tooltip(self, "ANCHOR_RIGHT", row.title, lines)
	end)
	r:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	panel.rows[i] = r
	return r
end

local function toggleQuest(row)
	if not (session and row.quest) then return end
	local id = row.quest
	if C.IsOnQuest(id) then
		local excluded = not session.excluded[id]
		session.excluded[id] = excluded or nil
		if excluded and session.pinned == id then session.pinned, session.selected = nil, nil end
	end
	refresh()
end

local function choiceAt(F, i)
	local r = F.choiceRows[i]
	if r then return r end
	r = CreateFrame("Button", nil, F.Choices.Child)
	r:SetWidth(WIDTH - 43)
	rowHover(r)
	r.Check = W.Checkbox(r, function(self) toggleQuest(self:GetParent()) end)
	r.Check:SetPoint("LEFT", r, "LEFT", 5, 0)
	r.Title = Appearance.Text(F, r, "goal", "text", "goalSize")
	r.Title:SetPoint("LEFT", r.Check, "RIGHT", 7, 0)
	r.Title:SetPoint("RIGHT", r, "RIGHT", -6, 0)
	r:SetScript("OnClick", toggleQuest)
	F.choiceRows[i] = r
	return r
end

renderChoices = function(F)
	local quests, included, height = Planner.Choices(ps, knowledge), 0, 26
	for i, quest in ipairs(quests) do
		local r = choiceAt(F, i)
		if i == 1 then
			local _, size = r.Title:GetFont()
			height = math.max(height, math.ceil((size or 14) + 10))
		end
		local selected = not session.excluded[quest.id]
		if selected then included = included + 1 end
		r.quest = quest.id
		r:SetHeight(height)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", F.Choices.Child, "TOPLEFT", 1, -(i - 1) * height)
		if r.Check.psOnWorld ~= F.psBare then
			r.Check.psOnWorld = F.psBare
			Theme.Repaint(r.Check)
		end
		r.Check:SetChecked(selected)
		Appearance.SetText(r.Title, quest.title)
		W.Color(r.Title, selected and "text" or "textMuted")
		r:Show()
	end
	for i = #quests + 1, #F.choiceRows do
		F.choiceRows[i].quest = nil
		F.choiceRows[i]:Hide()
	end
	F.choicesHeight = #quests * height
	Appearance.SetText(F.Summary, TEXT.choiceSummary:format(included, #quests))
	Appearance.SetText(F.Status, #quests == 0 and TEXT.empty or "")
	layoutList(F)
end

local function targetQuest()
	local rows = session.rows or {}
	if session.targetQuest then
		for _, row in ipairs(rows) do
			if row.id == session.targetQuest then return row end
		end
		session.targetQuest = nil
	end
	return session.selected or rows[1]
end

local function syncTargets()
	if not Targets.Available() then return end
	local row = targetQuest()
	local entries = row and Targets.Collect(ps, Planner.TargetGoals(ps, knowledge, row, session.from)) or {}
	session.targetCount = #entries
	Targets.Publish(entries)
	session.targetsPublished = true
end

renderTargets = function(F)
	local row = targetQuest()
	Appearance.SetText(F.Summary, row and row.title or "")
	F.TargetQuest:SetEnabled(row ~= nil)
	local status = not Targets.Available() and TEXT.targetsUnavailable
		or ps.Get("qol.targetButton") == false and TEXT.targetsDisabled
		or C.InCombat() and TEXT.combat
		or not row and (session.held == 0 and TEXT.empty or TEXT.unselected)
		or session.targetCount == 0 and TEXT.noTargets
		or ps.Get("qol.targetSimple") and TEXT.simpleTargets
		or TEXT.nativeTargets
	Appearance.SetText(F.Status, status)
end

showQuestMenu = function(button)
	if not session then return end
	if W.MenuShown(button) then W.HideMenu(); return end
	local function choose(id)
		if not session then return end
		session.targetQuest = id
		if not C.InCombat() then syncTargets() end
		renderTargets(panel)
	end
	local items = { { text = TEXT.followRoute, checked = not session.targetQuest, onClick = function() choose() end } }
	for _, row in ipairs(session.rows or {}) do
		local id = row.id
		items[#items + 1] = { text = row.title, checked = session.targetQuest == id, onClick = function() choose(id) end }
	end
	W.ShowMenu(button, items, { current = true, minWidth = button:GetWidth() })
end

local function closeMenus(F)
	if W.MenuShown(F.Target) or W.MenuShown(F.TargetQuest) then W.HideMenu() end
end

setView = function(view)
	if not session or panel.view == view then return end
	closeMenus(panel)
	panel.view = view
	paintControls(panel)
	refresh()
end

local function chooseLevel(target)
	if not session then return end
	session.targetLevel, session.fraction = target, nil
	targetLabel(panel)
	refresh()
end

showTargetMenu = function(button)
	if not session then return end
	if W.MenuShown(button) then W.HideMenu(); return end
	local level = C.GetPlayerLevel() or 1
	local max = ps.Levels and ps.Levels.MAX_LEVEL or 60
	local target, frac = session.targetLevel, session.fraction
	local items = { { text = TEXT.noTarget, checked = not target, onClick = function() chooseLevel() end } }
	if target and (target > max or target <= level or frac) then
		items[#items + 1] = { text = levelLabel(target, frac), checked = true }
	end
	for n = level + 1, max do
		local choice = n
		items[#items + 1] = {
			text = levelLabel(choice), checked = target == choice and not frac,
			onClick = function() chooseLevel(choice) end,
		}
	end
	W.ShowMenu(button, items, { current = true, minWidth = button:GetWidth() })
end

local function render(rows, navigable, level, status)
	panel.routeSummary = TEXT.summary:format(navigable, #rows) .. "  ·  " .. levelLabel(level)
	targetLabel(panel)
	if panel.view == "quests" then
		renderChoices(panel)
		return
	elseif panel.view == "targets" then
		renderTargets(panel)
		return
	end
	Appearance.SetText(panel.Summary, panel.routeSummary)
	Appearance.SetText(panel.Status, status or "")
	Appearance.ButtonText(panel.Sort, session.order == "xp" and TEXT.xp or TEXT.distance)
	for i, row in ipairs(rows) do
		local r = rowAt(i)
		local selected = row == session.selected and not status
		local label = row.qlvl and ("[" .. row.qlvl .. "] " .. row.title) or row.title
		if row.id == session.pinned then label = TEXT.pinned .. "  " .. label
		elseif selected then label = TEXT.current .. "  " .. label end
		Appearance.SetText(r.Title, label)
		W.Color(r.Title, selected and "accent" or "text")
		r.Mark:SetShown(selected)
		r.Icon:SetTexture(Theme.VerbIcon(row.ready and "turnin" or row.goal and row.goal.t or "note"))
		W.Color(r.Icon, selected and "accent" or "icon")
		local parts = {}
		if row.failed then parts[#parts + 1] = TEXT.failed
		elseif row.ready then parts[#parts + 1] = TEXT.ready
		elseif row.group then parts[#parts + 1] = TEXT.group
		elseif row.hard then parts[#parts + 1] = TEXT.hard end
		if row.line and row.line ~= "" then parts[#parts + 1] = row.line end
		if row.distance then parts[#parts + 1] = TEXT.yard:format(row.distance) end
		if row.point and row.point.map ~= session.zone then
			local where = C.MapName(row.point.map)
			if where and where ~= "" then parts[#parts + 1] = where end
		elseif not row.point and not row.failed then
			parts[#parts + 1] = TEXT.unmapped
		end
		if row.xp then parts[#parts + 1] = TEXT.xpValue:format(ps.Thousands(row.xp)) end
		Appearance.SetText(r.Detail, table.concat(parts, "  ·  "))
		r.planRow = row
		r:Show()
	end
	for i = #rows + 1, #panel.rows do
		panel.rows[i].planRow = nil
		panel.rows[i]:Hide()
	end
	panel.visibleRows = #rows
	if not panel.sizedRows and #rows > 0 then
		panel.sizedRows = true
		paintPanel(panel)
	else
		layoutList(panel)
	end
end

stop = function()
	if session and session.ticker then session.ticker:Cancel() end
	if session then Targets.Publish(nil) end
	session = nil
	if panel then
		closeMenus(panel)
		panel.view = "route"
		if panel:IsShown() then panel:Hide() end
	end
	releaseArrow()
	if Free.RefreshHint then Free.RefreshHint() end
end

local function reached(level, target, fraction)
	if not target or level < target then return false end
	if level > target or not fraction then return true end
	local info = C.GetPlayerInfo()
	return info and info.level == target and info.xpMax > 0 and info.xp / info.xpMax >= fraction
end

local function worldAvailable()
	return not changingWorld and not (UnitIsDeadOrGhost and C.Readable(UnitIsDeadOrGhost("player")))
end

local function suspend()
	closeMenus(panel)
	panel:Hide()
	if session.targetsPublished then
		Targets.Publish(nil)
		session.targetsPublished = nil
	end
end

refresh = function(force)
	if not session then releaseArrow(); return end
	if not worldAvailable() then suspend(); return end
	if not panel:IsShown() then panel:Show() end
	if C.InCombat() then
		session.force = force or session.force
		if panel.view == "quests" then
			renderChoices(panel)
		elseif panel.view == "targets" then
			renderTargets(panel)
		else
			Appearance.SetText(panel.Summary, panel.routeSummary or "")
			Appearance.SetText(panel.Status, TEXT.combat)
			layoutList(panel)
		end
		return
	end
	force, session.force = force or session.force, nil
	local level = math.max(C.GetPlayerLevel() or 1, session.levelHint or 0)
	if reached(level, session.targetLevel, session.fraction) then
		local target = levelLabel(session.targetLevel, session.fraction)
		stop()
		printStatus(TEXT.reached:format(target))
		return
	end

	local inside = C.IsInInstance()
	local from = not inside and ps.PlayerPoint() or nil
	session.from = from
	local zone = from and (C.GetUnitZone("player") or from.map)
	session.zone = zone
	local rows, navigable, _, held = Planner.Build(ps, knowledge, from, zone, level, session.order, session.excluded)
	session.rows, session.held = rows, held
	if session.pinned then
		local found
		for _, row in ipairs(rows) do
			if row.id == session.pinned then found = true; break end
		end
		if not found then session.pinned = nil end
	end
	session.selected = Planner.Choose(rows, session.pinned, session.selected)
	local status
	if session.selected then
		status = aim(session.selected, force)
	else
		releaseArrow()
		if #rows == 0 then
			status = held == 0 and TEXT.empty or TEXT.unselected
		else
			status = inside and TEXT.instance or not from and TEXT.unknown or TEXT.none
		end
	end
	session.navTarget = Nav.GetTarget()
	syncTargets()
	render(rows, navigable, level, status)
end

local function schedule()
	if queued or not (session or owned) then return end
	queued = true
	C_Timer.After(0.2, function()
		queued = nil
		refresh()
	end)
end

local function checkPosition()
	if not session or not worldAvailable() or C.InCombat() then return end
	local from = not C.IsInInstance() and ps.PlayerPoint() or nil
	local last = session.from
	local target = Nav.GetTarget()
	if (not from ~= not last) or (from and last and
		(from.map ~= last.map or (ps.DirectTravelCost(last, from) or 0) > 18))
		or target ~= session.navTarget then
		refresh()
	end
end

local function open(target, fraction)
	if not panel then panel = buildPanel() end
	if not session then
		session = { order = target and "xp" or "distance", excluded = exclusions() }
		session.ticker = C_Timer.NewTicker(4, checkPosition)
	end
	if target then session.targetLevel, session.fraction = target, fraction end
	paintPanel(panel)
	if Free.RefreshHint then Free.RefreshHint() end
	refresh(true)
end

Free.Open = open
Free.IsOpen = function() return session ~= nil end
Appearance.Watch(function()
	if session then paintPanel(panel) end
end)

local function command(input)
	local arg = (input or ""):match("^%s*(.-)%s*$"):lower()
	if arg == "off" then stop(); return end
	local target = tonumber(arg)
	if arg ~= "" and not (target and target > 0 and target < 256 and target == math.floor(target)) then
		printStatus(TEXT.usage)
		return
	end
	open(target)
end

SLASH_POLESTARFREEMODE1 = "/psfree"
SlashCmdList.POLESTARFREEMODE = command

local events = CreateFrame("Frame")
for _, event in ipairs({ "QUEST_LOG_UPDATE", "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_TURNED_IN", "PLAYER_LEVEL_UP", "PLAYER_XP_UPDATE",
	"ZONE_CHANGED_NEW_AREA", "ZONE_CHANGED", "PLAYER_ENTERING_WORLD", "PLAYER_LEAVING_WORLD", "PLAYER_REGEN_DISABLED", "PLAYER_REGEN_ENABLED", "PLAYER_DEAD", "PLAYER_ALIVE", "PLAYER_UNGHOST" }) do
	events:RegisterEvent(event)
end
events:SetScript("OnEvent", function(_, event, arg)
	if event == "PLAYER_XP_UPDATE" and not (session and session.fraction) then return end
	if event == "QUEST_ACCEPTED" and type(arg) == "number" then knowledge.held[arg] = true end
	if event == "QUEST_TURNED_IN" and type(arg) == "number" then knowledge.held[arg] = nil end
	if session and event == "PLAYER_LEVEL_UP" and type(arg) == "number" then session.levelHint = arg end
	if event == "PLAYER_LEAVING_WORLD" then changingWorld = true end
	if event == "PLAYER_ENTERING_WORLD" then changingWorld = nil end
	if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_LEAVING_WORLD" or event == "PLAYER_DEAD" then
		refresh()
	elseif event == "PLAYER_REGEN_DISABLED" then
		if session and panel.view == "targets" then renderTargets(panel) end
	else
		schedule()
	end
end)
ps.On("STEP_CHANGED", schedule)
ps.On("GUIDE_CHANGED", schedule)
ps.On("SETTING_CHANGED", function(path)
	if session and panel.view == "targets" and (path == "" or path == "qol" or path:sub(1, 4) == "qol.") then
		renderTargets(panel)
	end
end)
ps.On("NAME_LEARNED", schedule)
ps.On("QUESTDB_LOADED", schedule)
