local source, addons = assert(arg[1]), assert(arg[2])
local Free = {}
assert(loadfile(source .. "/Planner.lua"))("PolestarFreeMode", Free)
local P = Free.Planner

local function line(text, done, kind, count)
	return { text = text, finished = done, type = kind or "monster", numRequired = count or 1, numFulfilled = done and (count or 1) or 0 }
end

local function direct(from, to)
	if from.map ~= to.map then return 3600 end
	return ((from.x - to.x) ^ 2 + (from.y - to.y) ^ 2) ^ 0.5 * 5
end

local from = { map = 2548, x = 10, y = 10 }
local ids, held, ready, failed, objectives = { 1, 2, 3, 4, 5, 6 }, {}, {}, {}, {}
for _, id in ipairs(ids) do held[id] = true end
local records = {
	[1] = { title = "Chores", xp = 1600, level = 42 },
	[2] = { title = "A better quest", xp = 3600, level = 42 },
	[3] = { title = "Group fight", xp = 10000, level = 45 },
	[4] = { title = "Already finished", xp = 1400, level = 42, ["end"] = { npc = { 98 } } },
}
objectives[1] = { line("Clicked lever: 0/1", false, "object"), line("Boar slain: 1/1", true) }
objectives[2] = { line("Clear camp: 0/1", false, "object") }
objectives[3] = { line("Elite guard slain: 0/1", false) }
objectives[4] = { line("Object obtained: 0/1", false, "item") }
objectives[5] = { line("Unmapped: 0/1", false) }
objectives[6] = { line("Off-zone: 0/1", false) }
local guide = { steps = { { goals = {
	{ t = "kill", quest = 1, oi = 1, npc = 777, map = 2548, x = 10.05, y = 10 },
	{ t = "interact", quest = 1, oi = 2, object = 401, map = 2548, x = 32, y = 10, spots = { { x = 12, y = 10 } } },
	{ t = "kill", quest = 3, oi = 1, map = 2548, x = 10.15, y = 10, group = true },
	{ t = "turnin", quest = 4, map = 2548, x = 10, y = 10 },
	{ t = "accept", quest = 5, map = 2548, x = 10, y = 10 },
	{ t = "kill", quest = 6, oi = 1, map = 1437, x = 10, y = 10 },
} } } }

local C = {
	GetLogQuests = function() return ids end,
	IsOnQuest = function(q) return held[q] end,
	IsQuestReadyForTurnIn = function(q) return ready[q] end,
	IsQuestFailed = function(q) return failed[q] end,
	GetQuestObjectives = function(q) return objectives[q] end,
	GetQuestTitle = function(q) return q == 1 and "遊戲任務名稱" or nil end,
	GetQuestLevel = function() end,
	Placeholder = function() return false end,
	ObjectiveLabel = function(s) return (s:gsub(": %d+/%d+$", "")) end,
}
local ps = {
	Compat = C, DirectTravelCost = direct, TRAVEL_CROSS_CONTINENT = 3600,
	Engine = { GetGuide = function() return guide end },
	Codex = {
		Load = function() return true end,
		Quest = function(id) return records[id] end,
		Name = function(kind, id)
			if id == 777 then return "Boar" end
			if id == 401 then return "Clicked lever" end
			if id == 98 then return "Nearby NPC" end
		end,
	},
	Lookup = {
		QuestStep = function(q)
			if q == records[2] then
				return { goals = { { t = "complete", quest = 2, oi = 1, map = 2548, x = 13, y = 10 } } }
			end
		end,
		QuestEnd = function(ends)
			if ends then
				return { npc = 98, spawn = { map = 2548, x = 5, y = 10, z = 3 } }
			end
		end,
	},
	Levels = { Share = function() return 0.5 end },
}
local function find(rows, id)
	for _, row in ipairs(rows) do if row.id == id then return row end end
end

local state = P.New()
local rows, navigable = P.Build(ps, state, from, 2548, 42, "distance")
assert(#rows == 6 and navigable == 4)
assert(rows[1].id == 1 and rows[1].key == 1 and rows[1].point.x == 12, "reversed objective order and nearer spawn")
assert(rows[1].title == "遊戲任務名稱" and rows[1].xp == 800)
assert(rows[1].nearby > 0, "co-located objectives get a bonus")
assert(find(rows, 3).tier == 2 and find(rows, 6).tier == 5, "solo here first, then risk and far travel")
assert(not find(rows, 4).point and not find(rows, 5).point, "unready turn-ins and accept goals excluded")
assert(P.Choose(rows, 3).id == 3, "manual pin overrides priority")
local filtered, filteredNav, _, allHeld = P.Build(ps, state, from, 2548, 42, "distance", { [2] = true })
assert(not find(filtered, 2) and filteredNav == 3 and allHeld == 6)
assert(find(filtered, 1).nearby < find(rows, 1).nearby, "an excluded quest gives no clustering bonus")
assert(find(P.Choices(ps, state), 2), "an excluded quest can still be added back")
rows = P.Build(ps, state, from, 2548, 42, "xp")
assert(rows[1].id == 2, "XP priority favours the better reward")
ready[4] = true
rows = P.Build(ps, state, from, 2548, 42, "distance")
assert(find(rows, 4).key == "turnin" and find(rows, 4).point.z == 3)
objectives[1][1].finished = true
rows = P.Build(ps, state, from, 2548, 42, "distance")
assert(not find(rows, 1).point, "an objective just completed stops guiding")
ids = { 1, 2, 3, 5, 6 }
rows = P.Build(ps, state, from, 2548, 42, "distance")
assert(find(rows, 4), "quest still held under a collapsed log header")
held[4] = nil
failed[3] = true
rows = P.Build(ps, state, from, 2548, 42, "distance")
assert(not find(rows, 4) and find(rows, 3).failed and not find(rows, 3).point)
print("Planner: live states, local/XP ranking, help for missing points, pin and collapsed-log cases pass")

local previous = { map = 2548, x = 70, y = 50, kind = "guide" }
local current, manual, locked = previous, false, false
local playerLevel, combat, inside, ticks = 42, false, false, {}
local mapPos = from
local navSets, released, chats, cb, timers = 0, 0, {}, {}, {}
ps.Nav = {
	GetTarget = function() return current end,
	IsOverride = function() return manual end,
	IsHeld = function() return locked end,
	SetTarget = function(m, x, y, label, f, _, z)
		navSets = navSets + 1
		manual = true
		current = { map = m, x = x, y = y, label = label, f = f, z = z }
		return current
	end,
	ReleaseTarget = function()
		released = released + 1
		current, manual = previous, false
	end,
}
C.InCombat = function() return combat end
C.GetPlayerLevel = function() return playerLevel end
C.IsInInstance = function() return inside end
C.GetUnitZone = function() return mapPos.map end
C.MapName = function(id) return "Zone " .. id end
C.OpenQuestLog = function(id) cb.opened = id end
ps.PlayerPoint = function() return mapPos end
local xp = 0
C.GetPlayerInfo = function() return { level = playerLevel, xp = xp, xpMax = 100 } end
ps.On = function(key, fn)
	cb[key] = cb[key] or {}
	table.insert(cb[key], fn)
end
ps.Print = function(s) chats[#chats + 1] = s end
ps.Thousands, ps.DragWindow, ps.CloseOnEscape = tostring, function() end, function() end
local login, themeChange
ps.OnLogin = function(fn) login = fn end
local config = { ["ui.style"] = "transparent", ["ui.backing"] = "soft", ["guideWindow.border"] = false }
ps.Get = function(key) return config[key] end
local saved = { skipped = {} }
ps.CharState = function() return saved end
local dead
function UnitIsDeadOrGhost(unit) return unit == 'player' and dead end
function GetLocale() return 'zhTW' end
SlashCmdList = {}
local frames = {}
local function widget(parent)
	local w = { parent = parent, scripts = {}, events = {}, points = {}, shown = true }
	function w:GetParent() return self.parent end
	function w:SetScript(event, fn) self.scripts[event] = fn end
	function w:HookScript(event, fn)
		local old = self.scripts[event]
		self.scripts[event] = function(...) if old then old(...) end; fn(...) end
	end
	function w:RegisterEvent(event) self.events[event] = true end
	function w:SetText(s) self.text = s end
	function w:SetChecked(s) self.checked = s and true or false end
	function w:GetChecked() return self.checked end
	function w:GetText() return self.text end
	function w:SetWidth(n) self.width = n end
	function w:GetWidth() return self.width or 414 end
	function w:SetHeight(n) self.height = n end
	function w:GetHeight() return self.height or 240 end
	function w:GetBottom() return self.bottom or 500 end
	function w:GetLeft() return self.left or 26 end
	function w:GetTop() return self.top or 460 end
	function w:GetFrameLevel() return self.level or (self.parent and self.parent:GetFrameLevel() + 1) or 1 end
	function w:SetFrameLevel(level) self.level = level end
	function w:GetFrameStrata() return self.strata or (self.parent and self.parent:GetFrameStrata()) or "MEDIUM" end
	function w:SetFrameStrata(strata) self.strata = strata end
	function w:SetAttribute(key, value)
		assert(not self.protected or not combat, "attribute written during combat")
		self.attrs = self.attrs or {}
		self.attrs[key] = value
	end
	function w:SetAlpha(n) self.alpha = n end
	function w:SetSize(x, y) self.width, self.height = x, y end
	function w:SetPoint(...)
		assert(not self.protected or not combat, "protected anchor moved during combat")
		table.insert(self.points, { ... })
	end
	function w:ClearAllPoints() self.points = {} end
	function w:GetFont() return "mock-font", 14 * (self.fontScale or 1) end
	function w:GetStringHeight() return 16 * (self.fontScale or 1) end
	function w:GetStringWidth() return (select(2, (self.text or ""):gsub("[^\128-\191]", ""))) * 9 end
	function w:SetTexture(path) self.texture = path end
	function w:SetVertexColor(...) self.tint = { ... } end
	function w:GetEffectiveScale() return 1 end
	function w:Show()
		assert(not self.protected or not combat, "protected frame shown during combat")
		local was = self.shown
		self.shown = true
		if not was and self.scripts.OnShow then self.scripts.OnShow(self) end
	end
	function w:IsShown() return self.shown end
	function w:IsVisible() return self.shown and not (self.driver and combat) and (not self.parent or self.parent:IsVisible()) end
	function w:Hide()
		assert(not self.protected or not combat, "protected frame hidden during combat")
		local was = self.shown
		self.shown = false
		if was and self.scripts.OnHide then self.scripts.OnHide(self) end
	end
	function w:SetShown(on) if on then self:Show() else self:Hide() end end
	function w:CreateTexture() return widget(self) end
	return setmetatable(w, { __index = function(_, key)
		if key:match("^Set") or key:match("^Enable") or key:match("^Register") or key == "Raise" then
			return function() end
		end
	end })
end
function CreateFrame(_, name, parent, template)
	local w = widget(parent)
	w.protected = template and template:find("^Secure") ~= nil
	frames[#frames + 1] = w
	if name then _G[name] = w end
	return w
end
function RegisterStateDriver(w, key, value)
	assert(w.protected and key == "visibility" and value == "[combat] hide; show")
	w.driver = true
end
UIParent = CreateFrame()
local guideFrame = CreateFrame("Frame", "MockPolestarGuide", UIParent)
local nativeGuide = {
	frame = guideFrame, VEIL_FEATHER = 20,
	Transparent = function() return config["ui.style"] == "transparent" end,
	On = function(key) return config["guideWindow." .. key] ~= false end,
	Num = function(key) return config["guideWindow." .. key] or (key == "rowSpacing" and 0 or 1) end,
	Rgb = function(key) return (unpack(config["guideWindow." .. key] or {})) end,
	Outline = function() return config["guideWindow.outline"] or true end,
	ShadeText = function(w, on) w.hasShade = on and w.text and w.text ~= "" and true or false end,
	PaintMark = function(t) t:SetAlpha(config["guideWindow.targetBar"] == false and 0 or 1) end,
}
nativeGuide.SoftShade = function() return nativeGuide.Transparent() and config["ui.backing"] == "soft" end
nativeGuide.Backing = function()
	if nativeGuide.Transparent() and config["ui.backing"] == "dark" then return 0.68 end
end
local skin, skinMode = nil, "umbra"
ps.Theme = {
	API_VERSION = 2, Media = function(s) return s end,
	RegisterScheme = function() return true end,
	RegisterSkin = function(_, spec) skin = spec; return true end,
	SkinBuilder = function(_, build) build() end,
	VerbIcon = function(s) return "icon-" .. s end,
	Accent = function() return .4, .6, .8 end,
	Wash = function() return 0, 0, 0, .1 end,
	SkinKey = function() return skinMode end,
	Band = widget, Scrim = widget, PaintScrim = function(w, a) w.scrimAlpha = a end,
	SetOutline = function(w, on) w.outline = on end,
	SetFontScale = function(w, n) w.fontScale = n or 1 end,
	OnChanged = function(fn) themeChange = themeChange or {}; table.insert(themeChange, fn) end,
}
function CreateColor(...) return { ... } end
Polestar = ps
assert(loadfile(addons .. "/Polestar_Skins/Skins/Umbra/Umbra.lua"))("Polestar_Skins")
local kit = {}
function kit.store(frame)
	frame.skinPieces = frame.skinPieces or {}
	return frame.skinPieces
end
function kit.glow(frame)
	local pieces = kit.store(frame)
	pieces.top = pieces.top or widget(frame)
	pieces.top:Show()
	return pieces.top
end
function kit.bare(frame)
	frame.drawnStyle = "bare"
	local pieces = kit.store(frame)
	for _, name in ipairs({ "vignette", "glow", "edge" }) do
		for _, t in pairs(pieces[name] or {}) do t:Hide() end
	end
	if pieces.top then pieces.top:Hide() end
end
function ps.Theme.Repaint(frame)
	if skinMode == "umbra" then
		skin.paint.window(frame, function(w) w.drawnStyle = "standard" end, kit)
	end
end
function ps.Theme.Skin(frame, kind)
	frame.skinKind = kind
	if kind == "window" then ps.Theme.Repaint(frame) end
end
function ps.Theme.SetTabSelected(tab, selected)
	assert(tab.skinKind == "tab")
	tab.psSelected = selected
end
local function button(parent, label, fn, opts)
	local w = CreateFrame(nil, nil, parent)
	w.Label = widget(w)
	w.options = opts
	w:SetScript("OnClick", fn)
	ps.Widgets.SetButtonText(w, label)
	return w
end
ps.Widgets = {
	Text = widget, Tex = widget, Divider = widget,
	IconButton = function(parent, _, _, label, fn) return button(parent, label, fn) end,
	Button = button,
	Checkbox = function(parent, fn) return button(parent, "", fn) end,
	ShowMenu = function(anchor, items, opts) cb.menu = { anchor = anchor, items = items, opts = opts } end,
	HideMenu = function() cb.menu = nil end,
	MenuShown = function(anchor) return cb.menu and (not anchor or cb.menu.anchor == anchor) end,
	Scroll = function(parent)
		local w = CreateFrame(nil, nil, parent)
		w.Child = CreateFrame(nil, nil, w)
		return w
	end,
	SetButtonText = function(w, s)
		w.Label:SetText(s)
		w:SetWidth(w.Label:GetStringWidth() + (w.psTight and 16 or 32))
	end,
	SetScrollContent = function(w, n) w.contentHeight = n end,
	Painter = function(w, fn) fn(w) end,
	Tooltip = function() end, HideTooltip = function() end,
	Color = function(w, tone) w.tone = tone end,
}
local guideID, stepIndex, activeGuide = "riverglades", 1, guide
guide.id = guideID
ps.Engine.GetGuide = function() return activeGuide end
ps.Engine.GetStepIndex = function() return stepIndex end
ps.Engine.GetStepView = function(i, shared)
	assert(shared)
	local step = activeGuide.steps[i]
	local out = { status = step.status or "current", goals = {} }
	for k, g in ipairs(step.goals) do
		out.goals[k] = {
			t = g.t, optional = g.optional, dismissed = g.dismissed,
			unavailable = g.unavailable, status = g.status or "active",
		}
		if g.t == "level" and (playerLevel > g.level or playerLevel == g.level and xp >= (g.frac or 0) * 100) then
			out.goals[k].status = "done"
		end
	end
	return out
end
ps.Engine.GetGuideState = function(id) return id == "finished" and "done" or "new" end
local classStart
ps.Engine.StartGate = function() return classStart end
local bands = { riverglades = {40,46}, tooHigh = {45,48}, finished = {40,43}, alternative = {41,44} }
ps.Guides = {
	Suggestions = function() return { guideID, "tooHigh", "finished", "alternative" } end,
	Get = function(id) return bands[id] end,
	Levels = function(band) if band then return band[1], band[2] end end,
}
ps.UI = {
	GuideFrame = nativeGuide,
	ShowPicker = function(opts) cb.pickerOptions = opts end,
	Picker = {
		SetView = function(which) cb.pickerView = which end,
		Select = function(id) cb.pickerSelected = id end,
	},
}
C_Timer = {
	After = function(_, fn) timers[#timers + 1] = fn end,
	NewTicker = function(_, fn)
		local t = { run = fn }
		function t:Cancel() self.cancelled = true end
		ticks[#ticks + 1] = t
		return t
	end,
}
local function flush()
	while #timers > 0 do table.remove(timers, 1)() end
end
Polestar = ps
local function ignore() end
ps.RegisterDefaults, ps.RegisterEvent = ignore, ignore
ps.L = setmetatable({}, { __index = function(_, key) return key end })
ps.QoL = {
	Client = {},
	InLockdown = C.InCombat,
	Coalesce = function(fn) return fn, fn end,
	OnStep = ignore,
	On = function(key) return config["qol." .. key] end,
}
C.Readable = function(value) return value end
local targetUnit
function UnitName(unit) if unit == "target" then return targetUnit end end
function UnitExists(unit) return UnitName(unit) ~= nil end
function UnitIsDead() return false end
local onLogin = ps.OnLogin
ps.OnLogin = ignore
assert(loadfile(addons .. "/Polestar/QoL/Buttons.lua"))("Polestar", ps)
ps.OnLogin = onLogin
local setTargetSource = assert(ps.QoL.Buttons.SetTargetSource)
function ps.QoL.Buttons.SetTargetSource(owner, entries)
	setTargetSource(owner, entries)
	cb.targetOwner, cb.targetEntries = owner, entries
end
assert(loadfile(source .. "/Appearance.lua"))("PolestarFreeMode", Free)
assert(loadfile(source .. "/Targets.lua"))("PolestarFreeMode", Free)
assert(loadfile(source .. "/Main.lua"))("PolestarFreeMode", Free)
assert(loadfile(source .. "/LevelHint.lua"))("PolestarFreeMode", Free)
local function emit(event, a)
	for _, frame in ipairs(frames) do
		if frame.events[event] then frame.scripts.OnEvent(frame, event, a) end
	end
	flush()
end
local function fire(message, ...)
	for _, fn in ipairs(cb[message] or {}) do fn(...) end
	flush()
end
login()
flush()
local command = assert(SlashCmdList.POLESTARFREEMODE)
objectives[1][1].finished = false
playerLevel = 42
command("44")
local panel = assert(PolestarFreeModeWindow)
assert(panel:IsShown() and current.label == "A better quest")
local selected = find((function()
	local list = {}
	for _, w in ipairs(panel.rows) do list[#list + 1] = w.planRow end
	return list
end)(), 1)
assert(selected and selected.point)
for _, w in ipairs(panel.rows) do
	if w.planRow.id == 1 then
		w.scripts.OnClick(w, "RightButton")
		w.scripts.OnClick(w, "LeftButton")
		break
	end
end
assert(cb.opened == 1 and current.label == "遊戲任務名稱")
emit("QUEST_LOG_UPDATE")
assert(navSets == 2, "progress events do not reset the same arrow")
objectives[1][1].finished = true
emit("QUEST_LOG_UPDATE")
assert(current.label == "A better quest", "completed objective picks the next one")
current, manual = { label = "Manual waypoint" }, true
ticks[#ticks].run()
assert(current.label == "Manual waypoint" and panel.Status.text:find("其他地點", 1, true))
command("off")
assert(not panel:IsShown() and current.label == "Manual waypoint" and released == 0)
command("44")
combat = true
ready[2] = true
emit("QUEST_LOG_UPDATE")
assert(current.label == "A better quest" and panel.Status.text:find("戰鬥", 1, true))
combat = false
ready[2] = nil
emit("PLAYER_REGEN_ENABLED")
local mine = current
locked, current, manual = true, { label = "Corpse" }, false
ticks[#ticks].run()
assert(current.label == "Corpse", "corpse route keeps precedence")
command("off")
assert(current.label == "Corpse", "stopping cannot dismiss a corpse route")
locked, current, manual = false, mine, true
emit("PLAYER_UNGHOST")
assert(current == previous, "the retired arrow is released after the player returns")
command("44")
emit("PLAYER_LEVEL_UP", 44)
assert(not panel:IsShown() and current == previous and ticks[#ticks].cancelled and chats[#chats]:find("44"))
print("Client wiring: commands, pin, live progression, arrow ownership, combat, death, and level-44 return pass")

assert(panel:GetFrameStrata() == "LOW", "the planner stays below normal bag windows")
objectives[1][1].finished = false
command("44")
for _, w in ipairs(panel.rows) do
	if w.planRow and w.planRow.id == 1 then w.scripts.OnClick(w, "LeftButton"); break end
end
assert(current.label == "遊戲任務名稱")
emit("PLAYER_LEAVING_WORLD")
panel:Hide()
assert(Free.IsOpen() and not ticks[#ticks].cancelled, "world transition preserves the session")
emit("PLAYER_ENTERING_WORLD")
assert(panel:IsShown() and current.label == "遊戲任務名稱")
assert(panel.Target.Label.text:find("44 級", 1, true), "world transition preserves the target level")
local planned = current
dead, locked, current, manual = true, true, { label = "Corpse" }, false
emit("PLAYER_DEAD")
panel:Hide()
assert(Free.IsOpen() and current.label == "Corpse", "death preserves the session and leaves the corpse arrow alone")
emit("PLAYER_ALIVE")
assert(not panel:IsShown() and current.label == "Corpse", "releasing as a ghost does not resume tasks")
dead, locked, current, manual = false, false, planned, true
emit("PLAYER_UNGHOST")
assert(panel:IsShown() and current.label == "遊戲任務名稱", "resurrection resumes the pinned quest")
emit("PLAYER_LEAVING_WORLD")
command("off")
emit("PLAYER_ENTERING_WORLD")
assert(not Free.IsOpen() and not panel:IsShown(), "an explicit exit is not undone by world entry")
print("Window lifetime: layering, loading, ghost navigation, revival and explicit exit pass")

playerLevel = 42
objectives[1][1].finished = false
command("44")
assert(panel.Target.Label.text:find("44 級", 1, true))
local function routeFor(id)
	for _, row in ipairs(panel.rows) do
		if row.planRow and row.planRow.id == id then return row end
	end
end
local function choiceFor(id)
	for _, row in ipairs(panel.choiceRows) do if row.quest == id then return row end end
end
local function tab(key)
	local button = assert(panel.Tabs[key])
	button.scripts.OnClick(button)
	assert(button.psSelected and panel.view == key)
end
local function selectLevelChoice(label)
	panel.Target.scripts.OnClick(panel.Target)
	assert(cb.menu.anchor == panel.Target and cb.menu.opts.current)
	for _, item in ipairs(cb.menu.items) do
		if item.text == label then
			ps.Widgets.HideMenu()
			item.onClick()
			return
		end
	end
	error("missing target menu option " .. label)
end
selectLevelChoice("46 級")
assert(panel.Target.Label.text:find("46 級", 1, true))
selectLevelChoice("不限等級")
assert(panel.Target.Label.text == "目標等級")
routeFor(2).scripts.OnClick(routeFor(2), "LeftButton")
assert(current.label == "A better quest" and routeFor(2).Title.text:find("已固定", 1, true))
tab("quests")
assert(panel.Choices:IsShown() and not panel.List:IsShown() and not panel.Target:IsShown())
local row = assert(choiceFor(2))
assert(row.Check:GetChecked())
combat = true
row.Check.scripts.OnClick(row.Check)
assert(not row.Check:GetChecked() and current.label == "A better quest", "choices remain editable during combat")
combat = false
emit("PLAYER_REGEN_ENABLED")
assert(not row.Check:GetChecked() and current.label == "遊戲任務名稱" and PolestarFreeModeCharDB.excluded[2])
tab("route")
assert(panel.List:IsShown() and not routeFor(2))
command("off")
command("")
assert(not routeFor(2) and not panel.Choices:IsShown(), "a reopened planner retains exclusions")
tab("quests")
assert(not choiceFor(2).Check:GetChecked())
choiceFor(2).scripts.OnClick(choiceFor(2))
assert(choiceFor(2).Check:GetChecked() and not PolestarFreeModeCharDB.excluded[2], "row click adds the quest back")
tab("route")
assert(routeFor(2) and not routeFor(2).Title.text:find("已固定", 1, true), "re-added quest is available for a new pin")
tab("quests")
for _, option in ipairs(panel.choiceRows) do if option.quest and option.Check:GetChecked() then option.scripts.OnClick(option) end end
assert(panel.Summary.text:find("0/5", 1, true) and current == previous)
tab("route")
assert(panel.Status.text:find("未選取", 1, true) and not routeFor(2))
tab("quests")
for _, option in ipairs(panel.choiceRows) do if option.quest and not option.Check:GetChecked() then option.scripts.OnClick(option) end end
tab("route")
assert(routeFor(2) and not next(PolestarFreeModeCharDB.excluded))
selectLevelChoice("44 級")
playerLevel = 44
emit("PLAYER_LEVEL_UP", 44)
assert(not panel:IsShown() and current == previous)
print("Player controls: native level menu, persistent quest selection, pin clearing, combat deferral, all-excluded state, and navigation restored pass")

playerLevel = 42
objectives[1][2].finished = false
ids[#ids + 1] = 4
held[4] = true
ps.Names = { Npc = function(id) if id == 777 then return "野豬" end end }
command("")
routeFor(1).scripts.OnClick(routeFor(1), "LeftButton")
local priorWaypoint = current
tab("targets")
local function pickTargetQuest(title)
	local button = panel.TargetQuest
	button.scripts.OnClick(button)
	for _, item in ipairs(cb.menu.items) do
		if item.text == title then
			ps.Widgets.HideMenu()
			return item.onClick()
		end
	end
	error("missing quest in target menu " .. title)
end

assert(cb.targetOwner == Free.Targets and #cb.targetEntries == 1 and cb.targetEntries[1].name == "野豬",
	"the native window follows the planner from the route tab")
assert(cb.targetEntries[1].progress.cur == 1 and cb.targetEntries[1].progress.max == 1)
local frameCount = #frames
tab("targets")
assert(not panel.List:IsShown() and not panel.Choices:IsShown())
assert(#frames == frameCount and panel:GetHeight() < 200 and panel.Status.text:find("北極星", 1, true))
pickTargetQuest("Already finished")
assert(#cb.targetEntries == 1 and cb.targetEntries[1].name == "Nearby NPC" and cb.targetEntries[1].verb == "turnin")
assert(current == priorWaypoint, "target menu does not retarget the navigation arrow")
combat = true
emit("PLAYER_REGEN_DISABLED")
assert(panel.Status.text:find("戰鬥", 1, true))
pickTargetQuest("跟隨路線")
objectives[1][2].finished = true
emit("QUEST_LOG_UPDATE")
assert(cb.targetEntries[1].name == "Nearby NPC", "target source waits for combat before updating")
combat = false
emit("PLAYER_REGEN_ENABLED")
assert(#cb.targetEntries == 0, "completed objectives clear the target source")
objectives[1][2].finished = false
emit("QUEST_LOG_UPDATE")
pickTargetQuest("遊戲任務名稱")
assert(cb.targetEntries[1].name == "野豬")
tab("quests")
assert(cb.targetEntries[1].name == "野豬" and panel:GetHeight() == 396)
tab("route")
assert(cb.targetEntries[1].name == "野豬")
command("off")
assert(cb.targetEntries == nil, "closing releases the native list")
table.remove(ids)
held[4] = nil
objectives[1][2].finished = true
print("Planner target source: route and tabs, compact pane, localized targets, turn-in NPC, combat and release pass")

playerLevel = 42
activeGuide = { id = guideID, steps = {
	{ goals = { { t = "goto" }, { t = "level", level = 44 } } },
	{ goals = { { t = "kill", qlvl = 46 } } },
	{ goals = { { t = "level", level = 45, optional = true } } },
	{ goals = { { t = "accept", minLevel = 43, unavailable = "level" } } },
	{ status = "na", goals = { { t = "level", level = 44 } } },
	{ goals = { { t = "level", level = 44, frac = 0.8 } } },
} }
fire("GUIDE_CHANGED")
local hint = assert(PolestarFreeModeLevelHint)
assert(hint:IsVisible() and hint.target == 44 and hint.Message.text:find("42") and hint.Message.text:find("44"))
assert(hint.drawnStyle == "bare" and hint.Message.outline)
assert(hint.points[1][1] == "TOPLEFT")
guideFrame.bottom = 20
guideFrame.scripts.OnSizeChanged(guideFrame)
assert(hint.points[1][1] == "BOTTOMLEFT", "hint moves above a guide near the bottom")
hint.Guides.scripts.OnClick()
assert(cb.pickerOptions.newTab and cb.pickerView == "home" and cb.pickerSelected == "alternative")
assert(activeGuide.id == guideID and not Free.IsOpen(), "guide choices are only opened for browsing")
hint.Planner.scripts.OnClick()
flush()
assert(not hint:IsVisible() and panel:IsVisible() and panel.Target.Label.text:find("44 級") and Free.IsOpen())
assert(panel.psBare and panel.psNoBorder and panel.drawnStyle == "bare" and panel.Title.outline and panel.Title.hasShade)
assert(panel.Title:GetText() == "自由任務規劃器" and panel.Back.options.ghost and panel.rows[1].Mark:IsShown())
assert(panel.rows[1].Icon.texture == "icon-complete")
local beforeTheme = navSets
config["ui.style"], config["guideWindow.border"], config["guideWindow.bgOpacity"] = "standard", true, 0.6
fire("SETTING_CHANGED", "ui.style")
assert(panel.drawnStyle == "standard" and panel.skinPieces.glow.top:IsShown())
assert(not panel.psBare and not panel.psNoBorder and panel.psBgAlpha == 0.6 and not panel.Title.outline and not panel.Title.hasShade)
config["ui.style"], config["ui.backing"] = "transparent", "dark"
fire("SETTING_CHANGED", "ui.style")
assert(panel.drawnStyle == "bare" and not panel.skinPieces.glow.top:IsShown())
assert(panel.lookVeil:IsShown() and panel.lookVeil.scrimAlpha == .68 and not panel.Title.hasShade)
config["ui.backing"], config["guideWindow.targetBar"], config["guideWindow.goalSize"] = "none", false, 2
fire("SETTING_CHANGED", "guideWindow.goalSize")
assert(not panel.lookVeil:IsShown() and panel.rows[1].Mark.alpha == 0 and panel.rowHeight > 40)
skinMode = "polestar"
config["ui.style"] = "standard"
for _, fn in ipairs(themeChange) do fn() end
assert(panel.lookBand:IsShown() and not panel.psBare and navSets == beforeTheme)
config["ui.style"], config["ui.backing"], skinMode = "transparent", "soft", "umbra"
config["guideWindow.goalSize"], config["guideWindow.targetBar"] = 1, true
fire("SETTING_CHANGED", "ui.style")
command("off")
flush()
assert(hint:IsVisible(), "stopping the planner restores the still-relevant hint")

stepIndex = 2
fire("STEP_CHANGED")
assert(not hint:IsVisible(), "quest level by itself is not a gating condition")
saved.skipped[guideID] = { [1] = true }
fire("STEP_UPDATED")
assert(hint:IsVisible() and hint.target == 44, "a saved skip on the preceding grind remains actionable")
saved.skipped[guideID] = nil
fire("PLAYER_SKIPPED_STEP", guideID, 1)
assert(hint:IsVisible(), "a just-skipped grind still offers alternatives")
guideFrame:Hide()
fire("GUIDE_VISIBILITY")
assert(not hint:IsVisible())
guideFrame:Show()
flush()
assert(hint:IsVisible())
hint.Close.scripts.OnClick()
fire("STEP_UPDATED")
assert(not hint:IsVisible(), "a dismissed hint stays dismissed")
stepIndex = 3
fire("STEP_CHANGED")
assert(not hint:IsVisible(), "optional grind goals do not give a hint")
stepIndex = 4
fire("STEP_CHANGED")
assert(hint:IsVisible() and hint.target == 43)
stepIndex = 5
fire("STEP_CHANGED")
assert(not hint:IsVisible(), "a step that does not apply gives no hint")
stepIndex, playerLevel, xp = 6, 44, 60
fire("STEP_CHANGED")
assert(hint:IsVisible() and hint.Message.text:find("80%", 1, true))
hint.Planner.scripts.OnClick()
flush()
assert(panel:IsShown() and panel.Target.Label.text:find("80%", 1, true))
xp = 79
emit("PLAYER_XP_UPDATE")
assert(panel:IsShown())
xp = 80
emit("PLAYER_XP_UPDATE")
assert(not panel:IsShown() and not hint:IsVisible() and current == previous and chats[#chats]:find("80%", 1, true))
stepIndex, classStart = nil, { level = 45 }
fire("STEP_CHANGED")
assert(hint:IsVisible() and hint.target == 45)
classStart = { pre = 999 }
fire("STEP_UPDATED")
assert(not hint:IsVisible())
print("Guide appearance and level prompt: Umbra, standard and transparent backing, skipped gates, guide picker, and precise XP return pass")
