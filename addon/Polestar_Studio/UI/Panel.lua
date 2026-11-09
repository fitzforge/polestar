-- The Studio window (spec 4.2, reworked after Fitz's play, 2026-10-20): one
-- docked window instead of a three-pane panel and seven floating widgets.
--   Header: the guide's title and chips; New / Open (Home), Options, Close.
--   Toolbar, one row: undo, redo, the core tools and the chosen toolkit's
--     (more in its menu when the window is narrow), the toolkit, live sync,
--     Play from this step, Export.
--   Left: the steps (drag to reorder, Ctrl/Shift-click to select several,
--     chevron to collapse, search), badges per step: goals, problems, the
--     step Polestar plays from.
--   Right, top: the selected step (title, tip, conditions, goals as rows:
--     verb glyph, name, count, quest objective, coordinates, show on map).
--   Right, bottom: the dock, one tab each: Details (the selected goal's,
--     step's or guide's every field, where it came from, its problems), the
--     target card, quest log, position, nearby, checks, session, Export.
--   Status line: save state, the checks' count, what the last action did.
-- With no guide open (and on the first run, until the author picks a
-- handle), Home covers the body: the handle, then New and Open.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local P = _G.Polestar
local Theme, W = UI.Theme, UI.W
local format, floor, max, min, ipairs, pairs, type, tostring, tonumber, concat =
	string.format, math.floor, math.max, math.min, ipairs, pairs, type, tostring, tonumber, table.concat

local DOT = "  \194\183  "
local WIDTH, HEIGHT = 920, 680
local LEFT_W, DOCK_H, TAB_H = 260, 290, 28
local STRIP_H, STATUS_H = 38, 24
local STEP_ROW, GOAL_ROW, EDIT_GOAL = 28, 22, 44
local TOOL = 28 -- a toolbar button's step

local panel
local multi = {}      -- step index -> true (several selected)
local collapsed = {}  -- step id -> true (outline hides its goals)
local query = ""
local refreshQueued = false

---------------------------------------------------------------------------
-- Problems (in-game checks + an online report)
---------------------------------------------------------------------------

UI.problems = UI.problems or {}

function UI.AllProblems()
	local out = {}
	for _, p in ipairs(UI.problems or {}) do out[#out + 1] = p end
	return out
end

local function problemsOn(i, j)
	local out = {}
	for _, p in ipairs(UI.AllProblems()) do
		if p.step == i and (j == nil or p.goal == j) then out[#out + 1] = p end
	end
	return out
end

function UI.RunChecks()
	local doc = S.Model.Current()
	if not (doc and S.Checks and S.Checks.Run) then
		UI.problems = {}
		return
	end
	local ok, problems = pcall(S.Checks.Run, doc)
	UI.problems = ok and type(problems) == "table" and problems or {}
	S.Fire("STUDIO_UI_CHECKS")
end

S.On("STUDIO_CHECKS", function(problems)
	UI.problems = type(problems) == "table" and problems or {}
	S.Fire("STUDIO_UI_CHECKS")
	if panel and panel:IsShown() then UI.Refresh() end
end)

---------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------

local function doc() return S.Model.Current() end

local function stepAt(i)
	local d = doc()
	return d and d.steps[i]
end

local function onlySummary(only)
	if type(only) ~= "table" then return L["Everyone"] end
	local parts = {}
	for _, k in ipairs({ "factions", "races", "classes" }) do
		for _, v in ipairs(only[k] or {}) do parts[#parts + 1] = L[v] end
	end
	return #parts > 0 and concat(parts, ", ") or L["Everyone"]
end
UI.OnlySummary = onlySummary

local function inList(list, v)
	for _, x in ipairs(list or {}) do if x == v then return true end end
	return false
end

-- Toggle one class/race/faction in an `only` table -> the new table or nil.
function UI.ToggleOnly(only, kind, v)
	only = UI.Copy(only) or {}
	only[kind] = only[kind] or {}
	local list = only[kind]
	local found
	for k = #list, 1, -1 do
		if list[k] == v then table.remove(list, k); found = true end
	end
	if not found then list[#list + 1] = v end
	if #list == 0 then only[kind] = nil end
	if not (only.classes or only.races or only.factions) then return nil end
	return only
end

-- The menu of `only` choices for a step (or any holder through get/set).
function UI.OnlyMenu(anchor, get, set)
	local items = {}
	local function add(kind, list)
		for _, v in ipairs(list) do
			items[#items + 1] = { text = L[v], checked = inList((get() or {})[kind], v), onClick = function()
				set(UI.ToggleOnly(get(), kind, v))
				UI.OnlyMenu(anchor, get, set)
			end }
		end
		items[#items + 1] = { separator = true }
	end
	add("factions", UI.FACTIONS)
	add("races", UI.RACES)
	add("classes", UI.CLASSES)
	items[#items + 1] = { text = L["Everyone"], onClick = function() set(nil) end }
	UI.Menu(anchor, items)
end

-- "Mage, Human" -> { classes = { "Mage" }, races = { "Human" } } | nil
function UI.ParseOnly(text)
	local only = {}
	for word in (text or ""):gmatch("[^,%s]+") do
		local kind = inList(UI.CLASSES, word) and "classes" or inList(UI.RACES, word) and "races" or inList(UI.FACTIONS, word) and "factions"
		if kind then
			only[kind] = only[kind] or {}
			only[kind][#only[kind] + 1] = word
		end
	end
	if not (only.classes or only.races or only.factions) then return nil end
	return only
end

function UI.OnlyText(only)
	local parts = {}
	for _, k in ipairs({ "factions", "races", "classes" }) do
		for _, v in ipairs((only or {})[k] or {}) do parts[#parts + 1] = v end
	end
	return concat(parts, ",")
end

---------------------------------------------------------------------------
-- Modifier edits: the token and its compiled field together
---------------------------------------------------------------------------

-- Each verb's modifiers (tools/lib/dsl/parse.js MODS).
local COMMON = { "text", "optional", "only", "group" }
local COORDS = { "at", "map", "r", "frame" }
local function mods(...)
	local out = {}
	for _, list in ipairs({ ... }) do for _, m in ipairs(list) do out[#out + 1] = m end end
	return out
end
UI.MODS = {
	accept = mods(COMMON, COORDS, { "npc", "object", "item", "lvl" }),
	turnin = mods(COMMON, COORDS, { "npc", "object", "reward", "choose", "xp", "money", "direct" }),
	complete = mods(COMMON, COORDS),
	kill = mods(COMMON, COORDS, { "npc", "quest", "count" }),
	collect = mods(COMMON, COORDS, { "npc", "quest", "count", "nearest" }),
	["goto"] = mods(COMMON, { "map", "r", "frame" }),
	talk = mods(COMMON, COORDS), interact = mods(COMMON, COORDS, { "quest" }), use = mods(COMMON, COORDS, { "quest" }),
	sethome = mods(COMMON, COORDS, { "npc" }), hearth = mods(COMMON), getfp = mods(COMMON, COORDS, { "npc" }), fly = mods(COMMON),
	train = mods(COMMON, COORDS, { "npc" }), buy = mods(COMMON, COORDS, { "npc", "count", "nearest" }),
	vendor = mods(COMMON, COORDS, { "npc" }), level = mods(COMMON), money = { "text", "optional", "only" },
	task = mods({ "optional", "only" }, COORDS), note = mods({ "optional", "only" }, COORDS),
	skill = mods(COMMON, COORDS), learn = mods(COMMON, COORDS, { "npc", "item", "nearest" }),
	craft = mods(COMMON, COORDS, { "count", "until" }), rep = mods(COMMON, COORDS),
	explore = mods(COMMON, { "map", "r", "frame" }), achieve = mods(COMMON, COORDS, { "criteria" }),
	boss = mods(COMMON, COORDS, { "npc" }), mark = { "only" }, path = mods(COMMON, { "map", "frame", "cycle" }),
	area = { "only", "map", "frame" },
}
local FLAG = { optional = true, cycle = true, nearest = true, direct = true }
UI.FLAG_MODS = FLAG

-- Write a modifier's tokens into the compiled goal.
function UI.ApplyMod(out, name, values)
	local v = values and values[1]
	local on = values ~= nil
	if name == "count" then out.count = on and tonumber((v or ""):match("%d+")) or nil
	elseif name == "optional" then out.optional = on or nil
	elseif name == "cycle" then out.cycle = on or nil
	elseif name == "direct" then out.direct = on or nil
	elseif name == "group" then out.group = on and { kind = "group", size = tonumber(v) } or nil
	elseif name == "r" then out.r = on and tonumber(v) or nil
	elseif name == "map" then out.map = on and tonumber(v) or out.map
	elseif name == "frame" then out.f = (on and v == "era") and "e" or nil
	elseif name == "text" then out.text = on and UI.Untoken(v) or nil
	elseif name == "at" then
		local x, y = (v or ""):match("@%s*([%d%.]+),([%d%.]+)")
		if x then out.x, out.y = tonumber(x), tonumber(y) end
		if not on then out.x, out.y = nil, nil end
	elseif name == "quest" then
		local q, o = (v or ""):match("^(%d+)%.?(%d*)$")
		out.quest = on and tonumber(q) or nil
		out.oi = on and tonumber(o) or nil
	elseif name == "only" then out.only = on and UI.ParseOnly(concat(values, ",")) or nil
	elseif name == "npc" then
		out.npc = on and tonumber(v) or nil
		local C = P.Codex
		out.npcName = out.npc and C and C.Name and C.Name("npc", out.npc) or out.npcName
	elseif name == "until" then out.untilSkill = on and tonumber(v) or nil
	elseif name == "criteria" then out.criteria = on and tonumber(v) or nil
	elseif name == "lvl" then out.minLevel = on and tonumber(v) or nil
	elseif name == "xp" then out.rewards = out.rewards or {}; out.rewards.xp = on and tonumber(v) or nil
	end
end

-- Set one modifier on goal (i, j), its token and its compiled field.
function UI.SetGoalMod(i, j, name, values)
	local st = stepAt(i)
	local g = st and st.goals[j]
	if not g then return end
	local src, out = UI.Copy(g.src), UI.Copy(g.out or {})
	UI.SetMod(src, name, values)
	UI.ApplyMod(out, name, values)
	S.Model.UpdateGoal(i, j, src, out)
end

-- Verbs whose first argument is an id or a name the resolver fills from.
local RERESOLVE = {
	accept = function(a) return S.Resolve.Accept(tonumber(a[1])) end,
	complete = function(a) return S.Resolve.Complete(tonumber(a[1])) end,
	turnin = function(a) return S.Resolve.Turnin(tonumber(a[1])) end,
	kill = function(a, o) return S.Resolve.Kill(tonumber(a[1]) or UI.Untoken(a[1]), o.count, o.quest, o.oi) end,
	collect = function(a, o) return S.Resolve.Collect(tonumber(a[1]), o.count, o.quest, o.oi) end,
	talk = function(a) return S.Resolve.Talk(tonumber(a[1])) end,
	interact = function(a) return S.Resolve.Interact(tonumber(a[1])) end,
	use = function(a) return S.Resolve.Use(tonumber(a[1])) end,
	boss = function(a) return S.Resolve.Boss(tonumber(a[1])) end,
	mark = function(a, o) return S.Resolve.Mark(tonumber(a[1]), o.icon, o.note) end,
	level = function(a) return S.Resolve.Level(tonumber(a[1]) or a[1]) end,
	note = function(a) return S.Resolve.Note(UI.Untoken(a[1])) end,
	hearth = function(a) return S.Resolve.Hearth(UI.Untoken(a[1])) end,
	sethome = function(a) return S.Resolve.SetHome(UI.Untoken(a[1])) end,
	getfp = function(a) return S.Resolve.GetFP(UI.Untoken(a[1])) end,
	fly = function(a) return S.Resolve.Fly(UI.Untoken(a[1])) end,
	train = function(a) return S.Resolve.Train(UI.Untoken(concat(a, " "))) end,
	buy = function(a, o) return S.Resolve.Buy(tonumber(a[1]), o.count) end,
}

-- An argument edited: re-resolve the goal from its new first argument when
-- the verb has a resolver, keeping the author's modifiers; else store the
-- token as written.
function UI.SetGoalArg(i, j, k, text)
	local st = stepAt(i)
	local g = st and st.goals[j]
	if not g then return end
	local src = UI.Copy(g.src)
	src.args = src.args or {}
	src.args[k] = text ~= "" and text or nil
	local fn = RERESOLVE[src.verb]
	if fn and k == 1 and S.Resolve then
		local ok, nsrc, nout = pcall(fn, src.args, g.out or {})
		if ok and nsrc then
			for _, m in ipairs(g.src.mods or {}) do
				if not UI.Mod(nsrc, m[1]) then
					local values = { unpack(m, 2) }
					UI.SetMod(nsrc, m[1], values)
					UI.ApplyMod(nout, m[1], values)
				end
			end
			S.Model.UpdateGoal(i, j, nsrc, nout)
			return
		end
		UI.Say(ok and tostring(nout or L["Not found."]) or tostring(nsrc), "warning")
	end
	local out = UI.Copy(g.out or {})
	if src.verb == "note" or src.verb == "task" then out.text = UI.Untoken(text) end
	if src.verb == "goto" and k == 1 then
		local x, y = text:match("([%d%.]+),([%d%.]+)")
		out.x, out.y = tonumber(x), tonumber(y)
	end
	if src.verb == "goto" and k == 2 then out.text = UI.Untoken(text) end
	S.Model.UpdateGoal(i, j, src, out)
end

---------------------------------------------------------------------------
-- Building: header and tool strip
---------------------------------------------------------------------------

local function headerButtons(f)
	local head = f.Head
	f.Close:ClearAllPoints()
	f.Close:SetPoint("RIGHT", head, "RIGHT", -6, 0)
	f.Options = UI.Icon(head, "gear", L["Studio options"], function(self)
		UI.Menu(self, {
			{ text = L["Hide Studio in combat"], checked = UI.HideInCombat(), onClick = function() UI.SetHideInCombat(not UI.HideInCombat()) end },
			{ text = L["Auto-capture"], checked = S.Capture and S.Capture.Enabled and S.Capture.Enabled(), onClick = function()
				if S.Capture and S.Capture.SetEnabled then S.Capture.SetEnabled(not S.Capture.Enabled()) end
				UI.Refresh()
			end },
			{ separator = true },
			{ text = L["Take the tour"], onClick = function() if UI.Tour then UI.Tour() end end },
			{ text = L["Key bindings"], onClick = function()
				if Settings and Settings.OpenToCategory and SettingsPanel then
					pcall(Settings.OpenToCategory, Settings.KEYBINDINGS_CATEGORY_ID)
				elseif KeyBindingFrame_LoadUI then
					KeyBindingFrame_LoadUI()
					if KeyBindingFrame then KeyBindingFrame:Show() end
				end
			end },
		}, { point = "TOPRIGHT", relPoint = "BOTTOMRIGHT", x = 0, y = -4 })
	end)
	f.Options:SetPoint("RIGHT", f.Close, "LEFT", -4, 0)
	f.HomeButton = W.Button(head, L["New / Open"], function() UI.ShowHome(not f.HomeView:IsShown()) end, { height = 22, ghost = true, icon = Theme.Media("house") })
	f.HomeButton.psTip = L["Home: start a guide, open or fork one"]
	f.HomeButton:SetPoint("RIGHT", f.Options, "LEFT", -6, 0)
	f.Title:SetPoint("RIGHT", f.HomeButton, "LEFT", -200, 0)
	f.Chips = {}
	for k = 1, 3 do
		f.Chips[k] = W.Chip(head)
		f.Chips[k]:Hide()
	end
	f.Chips[1]:SetPoint("RIGHT", f.HomeButton, "LEFT", -12, 0)
	f.Chips[2]:SetPoint("RIGHT", f.Chips[1], "LEFT", -6, 0)
	f.Chips[3]:SetPoint("RIGHT", f.Chips[2], "LEFT", -6, 0)
end

local function kitOfPanel()
	local s = UI.State("Panel")
	if s.kit then return s.kit end
	local d = doc()
	return UI.KitOf(d and d.header.category)
end

-- The toolbar: undo and redo, the tools, then on its right the toolkit,
-- live sync, Play from this step and Export.
local function buildStrip(f)
	local strip = CreateFrame("Frame", nil, f)
	strip:SetPoint("TOPLEFT", f.Head, "BOTTOMLEFT", 0, 0)
	strip:SetPoint("TOPRIGHT", f.Head, "BOTTOMRIGHT", 0, 0)
	strip:SetHeight(STRIP_H)
	W.Fill(strip, "sidebar")
	local rule = W.Divider(strip)
	rule:SetPoint("BOTTOMLEFT", strip, "BOTTOMLEFT", 0, 0)
	rule:SetPoint("BOTTOMRIGHT", strip, "BOTTOMRIGHT", 0, 0)
	f.Strip = strip
	strip.Undo = UI.Icon(strip, "chevron-left", L["Undo"], function() if S.Model.CanUndo() then S.Model.Undo() end end, 24)
	strip.Undo:SetPoint("LEFT", strip, "LEFT", 8, 0)
	strip.Redo = UI.Icon(strip, "chevron-right", L["Redo"], function() if S.Model.CanRedo() then S.Model.Redo() end end, 24)
	strip.Redo:SetPoint("LEFT", strip.Undo, "RIGHT", 2, 0)
	strip.First = W.Divider(strip, true)
	strip.First:SetHeight(20)
	strip.First:SetPoint("LEFT", strip.Redo, "RIGHT", 6, 0)
	strip.Buttons = UI.Pool(strip, function(parent)
		return UI.TexButton(parent, nil, nil, function(self) S.Tools.Run(self.psKey) end, 26)
	end)
	strip.Sep = W.Divider(strip, true)
	strip.Sep:SetHeight(20)
	strip.More = UI.Icon(strip, "menu", L["More tools"], function(self) S.Tools.MoreMenu(self, strip.psMore or {}) end, 26)
	strip.Export = W.Button(strip, L["Export"], function() UI.SelectTab("Export") end, { primary = true, height = 26 })
	strip.Export:SetPoint("RIGHT", strip, "RIGHT", -8, 0)
	strip.Play = UI.Icon(strip, "dart", L["Play from this step: Polestar shows the draft from the selected step."], function()
		local i = S.Model.Selected()
		if i then UI.PlayFrom(i) else UI.Say(L["Pick a step first."], "warning") end
	end, 26)
	strip.Play:SetPoint("RIGHT", strip.Export, "LEFT", -8, 0)
	strip.SyncLabel = W.Text(strip, "label", "textDim")
	strip.SyncLabel:SetText(L["Live sync"])
	strip.SyncLabel:SetPoint("RIGHT", strip.Play, "LEFT", -10, 0)
	strip.Sync = W.Switch(strip, function() return S.Sync and S.Sync.Enabled and S.Sync.Enabled() end, function(on)
		if S.Sync and S.Sync.SetEnabled then S.Sync.SetEnabled(on) end
	end, L["Live sync: Polestar plays the draft as you edit it."])
	strip.Sync:SetPoint("RIGHT", strip.SyncLabel, "LEFT", -2, 0)
	strip.Kit = W.Button(strip, "", function(self)
		local items = {}
		for _, k in ipairs(UI.KITS) do
			items[#items + 1] = { text = L[k.label], checked = kitOfPanel() == k.key, onClick = function()
				UI.State("Panel").kit = k.key
				UI.LayoutStrip()
				S.Fire("STUDIO_KIT")
			end }
		end
		UI.Menu(self, items, { point = "TOPRIGHT", relPoint = "BOTTOMRIGHT", x = 0, y = -4 })
	end, { height = 26, ghost = true })
	strip.Kit:SetPoint("RIGHT", strip.Sync, "LEFT", -10, 0)
end

-- The tools that fit before the toolkit's button; the rest go to More.
function UI.LayoutStrip()
	local strip = panel and panel.Strip
	if not strip then return end
	local kit = kitOfPanel()
	for _, k in ipairs(UI.KITS) do
		if k.key == kit then W.SetButtonText(strip.Kit, L[k.label]) end
	end
	strip.Kit.psTip = L["Toolkit: the tools of this kind of guide"]
	strip.Undo:SetEnabled(S.Model.CanUndo() and true or false)
	strip.Redo:SetEnabled(S.Model.CanRedo() and true or false)
	W.SetIconState(strip.Undo, false, S.Model.CanUndo() and true or false)
	W.SetIconState(strip.Redo, false, S.Model.CanRedo() and true or false)
	strip.Sync:Refresh()
	local shown, more = S.Tools.ForBar(kit)
	local left = (strip.Undo:GetWidth() or 24) * 2 + 24
	local room = (strip.Kit:GetLeft() or 0) - (strip:GetLeft() or 0) - left - TOOL - 12
	local fit = math.max(0, floor(room / TOOL))
	local over = {}
	if #shown > fit then
		for k = #shown, fit + 1, -1 do table.insert(over, 1, table.remove(shown, k)) end
	end
	for _, def in ipairs(more) do over[#over + 1] = def end
	local x, n, sepDone = left, 0, false
	strip.Sep:Hide()
	for _, def in ipairs(shown) do
		if def.kit ~= "core" and not sepDone then
			sepDone = true
			strip.Sep:ClearAllPoints()
			strip.Sep:SetPoint("LEFT", strip, "LEFT", x + 2, 0)
			strip.Sep:Show()
			x = x + 8
		end
		n = n + 1
		local b = strip.Buttons:Get(n)
		b.psKey = def.key
		b.psTip = L[def.label]
		b.psTipLines = def.tip and { L[def.tip] } or nil
		UI.SetToolIcon(b, def)
		b:ClearAllPoints()
		b:SetPoint("LEFT", strip, "LEFT", x, 0)
		x = x + TOOL
	end
	strip.psMore = over
	strip.More:ClearAllPoints()
	strip.More:SetPoint("LEFT", strip, "LEFT", x + 2, 0)
	strip.More:SetShown(#over > 0)
	strip.Buttons:HideFrom(n + 1)
end

---------------------------------------------------------------------------
-- Outline
---------------------------------------------------------------------------

local outlineRows

local function selectStep(i, button)
	local _, sel = S.Model.Selected()
	if IsControlKeyDown() then
		multi[i] = not multi[i] or nil
		UI.Refresh()
		return
	elseif IsShiftKeyDown() then
		local cur = S.Model.Selected()
		if cur then
			for k = min(cur, i), max(cur, i) do multi[k] = true end
			UI.Refresh()
			return
		end
	end
	for k in pairs(multi) do multi[k] = nil end
	S.Model.Select(i, nil)
end

local function outlineRowUnderCursor()
	for _, row in ipairs(outlineRows.items) do
		if row:IsShown() and row:IsMouseOver() and row.psStep then return row.psStep end
	end
	return nil
end

local function makeOutlineRow(parent)
	local row = UI.Row(parent, STEP_ROW)
	row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	row:RegisterForDrag("LeftButton")
	row.Chevron = UI.Icon(row, "chevron-down", nil, function(self)
		local st = stepAt(self:GetParent().psStep)
		if st and st.id then
			collapsed[st.id] = not collapsed[st.id] or nil
			UI.Refresh()
		end
	end, 18)
	row.Chevron:SetPoint("LEFT", row, "LEFT", 4, 0)
	row.Index = W.Text(row, "number", "textMuted")
	row.Index:SetPoint("LEFT", row, "LEFT", 24, 0)
	row.Glyph = row:CreateTexture(nil, "ARTWORK")
	row.Glyph:SetSize(14, 14)
	row.Text = W.Text(row, "body", "text")
	row.Here = W.Tex(row, "ARTWORK", "dart", "accent")
	row.Here:SetSize(12, 12)
	row.Here:SetPoint("RIGHT", row, "RIGHT", -8, 0)
	row.Problems = W.Text(row, "number", "warning")
	row.Problems:SetPoint("RIGHT", row.Here, "LEFT", -6, 0)
	row.Count = W.Text(row, "number", "textMuted")
	row.Count:SetPoint("RIGHT", row.Problems, "LEFT", -6, 0)
	row:SetScript("OnClick", function(self, button)
		if self.psGoal then
			S.Model.Select(self.psStep, self.psGoal)
		elseif button == "RightButton" then
			UI.StepMenu(self, self.psStep)
		else
			selectStep(self.psStep, button)
		end
	end)
	row:SetScript("OnDragStart", function(self)
		if self.psGoal then return end
		panel.psDragFrom = self.psStep
		SetCursor("Interface\\Cursor\\UI-Cursor-Move")
	end)
	row:SetScript("OnDragStop", function(self)
		ResetCursor()
		local from = panel.psDragFrom
		panel.psDragFrom = nil
		local to = outlineRowUnderCursor()
		if from and to and from ~= to then
			S.Model.MoveStep(from, to)
			S.Model.Select(to, nil)
		end
	end)
	return row
end

local function matches(st)
	if query == "" then return true end
	if (st.title or ""):lower():find(query, 1, true) then return true end
	for _, g in ipairs(st.goals or {}) do
		if UI.GoalText(g):lower():find(query, 1, true) then return true end
	end
	return false
end

local function refreshOutline()
	local f = panel
	local d = doc()
	local child = f.Outline.Scroll.Child
	child:SetWidth(f.Outline.Scroll:GetWidth())
	local n, y = 0, 0
	local si, sj = S.Model.Selected()
	if d then
		for i, st in ipairs(d.steps) do
			if matches(st) then
				n = n + 1
				local row = outlineRows:Get(n)
				row:SetHeight(STEP_ROW)
				row:ClearAllPoints()
				row:SetPoint("TOPLEFT", child, "TOPLEFT", 0, -y)
				row:SetPoint("TOPRIGHT", child, "TOPRIGHT", 0, -y)
				row.psStep, row.psGoal = i, nil
				row.Chevron:Show()
				local open = not collapsed[st.id or ""]
				W.SetIcon(row.Chevron, open and "chevron-down" or "chevron-right")
				row.Index:SetText(tostring(i))
				row.Index:Show()
				row.Glyph:Hide()
				row.Text:ClearAllPoints()
				row.Text:SetPoint("LEFT", row, "LEFT", 48, 0)
				row.Text:SetPoint("RIGHT", row.Count, "LEFT", -6, 0)
				Theme.Font(row.Text, "body")
				row.Text:SetText(st.title ~= "" and st.title or L["(untitled step)"])
				W.Color(row.Text, "text")
				row.Count:SetText(tostring(#(st.goals or {})))
				row.Count:Show()
				local np = #problemsOn(i)
				row.Problems:SetText(np > 0 and ("!" .. np) or "")
				row.Problems:Show()
				row.Here:SetShown(UI.pinnedStep ~= nil and UI.pinnedStep == st.id)
				row.Sel:SetShown(i == si and not sj or multi[i] == true)
				y = y + STEP_ROW
				if open then
					for j, g in ipairs(st.goals or {}) do
						n = n + 1
						local gr = outlineRows:Get(n)
						gr:SetHeight(GOAL_ROW)
						gr:ClearAllPoints()
						gr:SetPoint("TOPLEFT", child, "TOPLEFT", 0, -y)
						gr:SetPoint("TOPRIGHT", child, "TOPRIGHT", 0, -y)
						gr.psStep, gr.psGoal = i, j
						gr.Chevron:Hide()
						gr.Index:Hide()
						local tex, tint = UI.GoalIcon(g)
						gr.Glyph:SetTexture(tex)
						if tint == false then W.Uncolor(gr.Glyph); gr.Glyph:SetVertexColor(1, 1, 1, 1) else W.Color(gr.Glyph, "textMuted") end
						gr.Glyph:ClearAllPoints()
						gr.Glyph:SetPoint("LEFT", gr, "LEFT", 48, 0)
						gr.Glyph:Show()
						gr.Text:ClearAllPoints()
						gr.Text:SetPoint("LEFT", gr.Glyph, "RIGHT", 6, 0)
						gr.Text:SetPoint("RIGHT", gr.Count, "LEFT", -6, 0)
						Theme.Font(gr.Text, "small")
						gr.Text:SetText(UI.GoalText(g))
						W.Color(gr.Text, "textDim")
						gr.Count:Hide()
						local gp = #problemsOn(i, j)
						gr.Problems:SetText(gp > 0 and "!" or "")
						gr.Here:Hide()
						gr.Sel:SetShown(i == si and j == sj)
						y = y + GOAL_ROW
					end
				end
			end
		end
	end
	outlineRows:HideFrom(n + 1)
	W.SetScrollContent(f.Outline.Scroll, y)
	local nm = 0
	for _ in pairs(multi) do nm = nm + 1 end
	f.Outline.Delete:SetShown(nm > 1)
	if nm > 1 then W.SetButtonText(f.Outline.Delete, format(L["Delete %d steps"], nm)) end
end

-- Right-click menu of a step.
function UI.StepMenu(anchor, i)
	UI.Menu(anchor, {
		{ text = L["Play from this step"], onClick = function() UI.PlayFrom(i) end },
		{ text = L["Add a step after"], onClick = function()
			local k = S.Model.AddStep(L["New step"], i + 1)
			if k then S.Model.Select(k, nil) end
		end },
		{ text = L["Move up"], disabled = i <= 1, onClick = function() S.Model.MoveStep(i, i - 1); S.Model.Select(i - 1, nil) end },
		{ text = L["Move down"], disabled = i >= #(doc() and doc().steps or {}), onClick = function() S.Model.MoveStep(i, i + 1); S.Model.Select(i + 1, nil) end },
		{ separator = true },
		{ text = L["Delete step"], confirm = true, color = "danger", onClick = function() S.Model.RemoveStep(i) end },
	}, { point = "TOPLEFT", relPoint = "TOPRIGHT", x = 4, y = 0 })
end

function UI.PlayFrom(i)
	local d, st = doc(), stepAt(i)
	local PS = P.Studio
	if not (d and st and PS and PS.PinStep) then
		UI.Say(L["Polestar cannot play drafts yet: update Polestar."], "warning")
		return
	end
	if S.Sync and S.Sync.Now then S.Sync.Now() end
	local ok, err = pcall(PS.PinStep, d.header.id, st.id)
	if ok then
		UI.pinnedStep = st.id
		UI.Say(format(L["Polestar plays from step %d."], i), "success")
		UI.Refresh()
	else
		UI.Say(tostring(err), "danger")
	end
end

local function buildOutline(f)
	local col = CreateFrame("Frame", nil, f)
	col:SetPoint("TOPLEFT", f.Strip, "BOTTOMLEFT", 0, 0)
	col:SetPoint("BOTTOMLEFT", f.Status, "TOPLEFT", 1, 0)
	col:SetWidth(LEFT_W)
	Theme.Skin(col, "sidebar")
	local rule = W.Divider(col, true)
	rule:SetPoint("TOPRIGHT", col, "TOPRIGHT", 0, 0)
	rule:SetPoint("BOTTOMRIGHT", col, "BOTTOMRIGHT", 0, 0)
	f.Outline = col
	col.Search = W.SearchBox(col, { L["Search steps and goals"], L["Search"] }, function(text)
		query = (text or ""):lower()
		refreshOutline()
	end)
	col.Search:SetPoint("TOPLEFT", col, "TOPLEFT", 10, -10)
	col.Search:SetPoint("TOPRIGHT", col, "TOPRIGHT", -10, -10)
	col.Guide = W.Button(col, L["Guide"], function() S.Model.Select(nil, nil) end, { ghost = true, height = 24, icon = Theme.Media("info") })
	col.Guide:SetPoint("TOPLEFT", col.Search, "BOTTOMLEFT", -6, -6)
	col.AddStep = W.Button(col, L["Step"], function()
		local i = S.Model.Selected()
		local k = S.Model.AddStep(L["New step"], i and i + 1 or nil)
		if k then S.Model.Select(k, nil) end
	end, { height = 24, icon = Theme.Media("plus") })
	col.AddStep:SetPoint("TOPRIGHT", col.Search, "BOTTOMRIGHT", 0, -6)
	col.Scroll = W.Scroll(col)
	col.Scroll:SetPoint("TOPLEFT", col, "TOPLEFT", 0, -78)
	col.Scroll:SetPoint("BOTTOMRIGHT", col, "BOTTOMRIGHT", -1, 40)
	outlineRows = UI.Pool(col.Scroll.Child, makeOutlineRow)
	col.Hint = UI.Text(col, "small", "textMuted", true)
	col.Hint:SetPoint("BOTTOMLEFT", col, "BOTTOMLEFT", 12, 8)
	col.Hint:SetPoint("BOTTOMRIGHT", col, "BOTTOMRIGHT", -12, 8)
	col.Hint:SetHeight(26)
	col.Hint:SetText(L["Drag to reorder. Ctrl-click selects several, right-click for more."])
	col.Delete = W.Button(col, "", nil, { danger = true, height = 24 })
	col.Delete.psSetText = W.SetButtonText
	W.Confirm(col.Delete, L["Delete steps"], function()
		local list = {}
		for i in pairs(multi) do list[#list + 1] = i end
		table.sort(list, function(a, b) return a > b end)
		for _, i in ipairs(list) do S.Model.RemoveStep(i) end
		for k in pairs(multi) do multi[k] = nil end
	end)
	col.Delete:SetPoint("BOTTOMLEFT", col, "BOTTOMLEFT", 10, 8)
	col.Delete:SetPoint("BOTTOMRIGHT", col, "BOTTOMRIGHT", -10, 8)
	col.Delete:Hide()
end

---------------------------------------------------------------------------
-- Step editor (centre)
---------------------------------------------------------------------------

local editRows

local function makeGoalRow(parent)
	local row = UI.Row(parent, EDIT_GOAL)
	row.Glyph = row:CreateTexture(nil, "ARTWORK")
	row.Glyph:SetSize(18, 18)
	row.Glyph:SetPoint("LEFT", row, "LEFT", 10, 0)
	row.Text = W.Text(row, "goal", "text")
	row.Text:SetPoint("TOPLEFT", row, "TOPLEFT", 38, -6)
	row.Sub = W.Text(row, "small", "textMuted")
	row.Sub:SetPoint("TOPLEFT", row.Text, "BOTTOMLEFT", 0, -3)
	row.Delete = UI.Icon(row, "close", L["Remove this goal"], function(self)
		local r = self:GetParent()
		S.Model.RemoveGoal(r.psStep, r.psGoal)
	end, 22)
	row.Delete:SetPoint("RIGHT", row, "RIGHT", -6, 0)
	row.Down = UI.Icon(row, "chevron-down", L["Move down"], function(self)
		local r = self:GetParent()
		S.Model.MoveGoal(r.psStep, r.psGoal, r.psGoal + 1)
		S.Model.Select(r.psStep, r.psGoal + 1)
	end, 22)
	row.Down:SetPoint("RIGHT", row.Delete, "LEFT", -2, 0)
	row.Up = UI.Icon(row, "chevron-up", L["Move up"], function(self)
		local r = self:GetParent()
		S.Model.MoveGoal(r.psStep, r.psGoal, r.psGoal - 1)
		S.Model.Select(r.psStep, r.psGoal - 1)
	end, 22)
	row.Up:SetPoint("RIGHT", row.Down, "LEFT", -2, 0)
	row.Place = UI.Icon(row, "plus", L["Place on the world map"], function(self)
		local r = self:GetParent()
		S.Model.Select(r.psStep, r.psGoal)
		S.Tools.Run("place")
	end, 22)
	row.Place:SetPoint("RIGHT", row.Up, "LEFT", -2, 0)
	row.Map = UI.Icon(row, "flag", L["Show on map"], function(self)
		local r = self:GetParent()
		local st = stepAt(r.psStep)
		local g = st and st.goals[r.psGoal]
		if g then UI.ShowOnMap(g.out) end
	end, 22)
	row.Map:SetPoint("RIGHT", row.Place, "LEFT", -2, 0)
	row.Text:SetPoint("RIGHT", row.Map, "LEFT", -8, 0)
	row.Sub:SetPoint("RIGHT", row.Map, "LEFT", -8, 0)
	row.Warn = W.Tex(row, "OVERLAY", "info", "warning")
	row.Warn:SetSize(12, 12)
	row.Warn:SetPoint("TOPLEFT", row, "TOPLEFT", 24, -4)
	row:SetScript("OnClick", function(self) S.Model.Select(self.psStep, self.psGoal) end)
	row:SetScript("OnDoubleClick", function(self) S.Model.Select(self.psStep, self.psGoal) end)
	return row
end

local function goalSub(g)
	local o = g.out or {}
	local parts = {}
	if o.count and o.count > 0 then parts[#parts + 1] = "x" .. o.count end
	local q = UI.QuestLink(o)
	if q then parts[#parts + 1] = q end
	local where = UI.Where(o)
	if where then parts[#parts + 1] = where end
	if o.optional then parts[#parts + 1] = L["optional"] end
	if o.group then parts[#parts + 1] = o.group.size and format(L["group of %d"], o.group.size) or L["group"] end
	if o.only then parts[#parts + 1] = onlySummary(o.only) end
	if o.npcName and o.t ~= "talk" then parts[#parts + 1] = o.npcName end
	if #parts == 0 then parts[1] = g.src and g.src.verb or "" end
	return concat(parts, DOT)
end
UI.GoalSub = goalSub

local function refreshEditor()
	local f = panel
	local E = f.Editor
	local i, sj = S.Model.Selected()
	local st = i and stepAt(i)
	E.Empty:SetShown(not st)
	E.Scroll:SetShown(st ~= nil)
	if not st then
		local d = doc()
		E.Empty:SetText(d and (#d.steps == 0 and L["This guide has no steps yet. Add one with + Step, or use any tool: it adds a step for you."]
			or L["Pick a step in the outline, or Guide to edit the guide's own fields in the inspector."]) or "")
		return
	end
	local c = E.Scroll.Child
	local w = E.Scroll:GetWidth()
	c:SetWidth(w)
	E.Heading:SetText(format(L["Step %d"], i) .. (st.id and (DOT .. st.id) or ""))
	UI.SetEdit(E.TitleBox, st.title)
	UI.SetEdit(E.Tip, st.note)
	W.SetButtonText(E.Only, format(L["Only: %s"], onlySummary(st.only)))
	UI.SetEdit(E.When, type(st.when) == "table" and concat(st.when, "; ") or st.when)
	E.Goals:ClearAllPoints()
	E.Goals:SetPoint("TOPLEFT", c, "TOPLEFT", 16, -E.psGoalsTop)
	E.Goals:SetPoint("TOPRIGHT", c, "TOPRIGHT", -16, -E.psGoalsTop)
	W.SetSection(E.Goals, L["Goals"], #(st.goals or {}))
	local y = E.psGoalsTop + 44
	for j, g in ipairs(st.goals or {}) do
		local row = editRows:Get(j)
		row:ClearAllPoints()
		row:SetPoint("TOPLEFT", c, "TOPLEFT", 8, -y)
		row:SetPoint("TOPRIGHT", c, "TOPRIGHT", -8, -y)
		row.psStep, row.psGoal = i, j
		local tex, tint = UI.GoalIcon(g)
		row.Glyph:SetTexture(tex)
		if tint == false then W.Uncolor(row.Glyph); row.Glyph:SetVertexColor(1, 1, 1, 1) else W.Color(row.Glyph, "accent") end
		row.Text:SetText(UI.GoalText(g))
		row.Sub:SetText(goalSub(g))
		row.Sel:SetShown(j == sj)
		row.Warn:SetShown(#problemsOn(i, j) > 0)
		row.Up:SetEnabled(j > 1)
		row.Down:SetEnabled(j < #st.goals)
		row.Map:SetShown((g.out and g.out.map) ~= nil)
		y = y + EDIT_GOAL
	end
	editRows:HideFrom(#(st.goals or {}) + 1)
	E.NoGoals:SetShown(#(st.goals or {}) == 0)
	E.NoGoals:ClearAllPoints()
	E.NoGoals:SetPoint("TOPLEFT", c, "TOPLEFT", 16, -y - 4)
	E.NoGoals:SetPoint("RIGHT", c, "RIGHT", -16, 0)
	W.SetScrollContent(E.Scroll, y + 60)
end

local function buildEditor(f)
	local E = CreateFrame("Frame", nil, f)
	E:SetPoint("TOPLEFT", f.Outline, "TOPRIGHT", 0, 0)
	E:SetPoint("RIGHT", f, "RIGHT", -1, 0)
	E:SetPoint("BOTTOM", f.Dock, "TOP", 0, 0)
	f.Editor = E
	E.Empty = UI.Text(E, "note", "textMuted", true)
	E.Empty:SetPoint("TOPLEFT", E, "TOPLEFT", 24, -24)
	E.Empty:SetPoint("TOPRIGHT", E, "TOPRIGHT", -24, -24)
	E.Scroll = W.Scroll(E)
	E.Scroll:SetPoint("TOPLEFT", E, "TOPLEFT", 0, -2)
	E.Scroll:SetPoint("BOTTOMRIGHT", E, "BOTTOMRIGHT", -2, 2)
	local c = E.Scroll.Child
	E.Heading = W.Text(c, "caption", "textMuted")
	E.Heading:SetPoint("TOPLEFT", c, "TOPLEFT", 16, -12)
	E.Play = W.Button(c, L["Play from this step"], function() UI.PlayFrom((S.Model.Selected())) end, { height = 24, icon = Theme.Media("dart") })
	E.Play:SetPoint("TOPRIGHT", c, "TOPRIGHT", -16, -6)
	E.More = UI.Icon(c, "menu", L["More"], function(self) UI.StepMenu(self, (S.Model.Selected())) end)
	E.More:SetPoint("RIGHT", E.Play, "LEFT", -6, 0)
	E.TitleBox = UI.Edit(c, { role = "title", height = 30, placeholder = L["Step title"], onCommit = function(text)
		local i = S.Model.Selected()
		if i then S.Model.SetStep(i, "title", text) end
	end })
	E.TitleBox:SetPoint("TOPLEFT", c, "TOPLEFT", 16, -36)
	E.TitleBox:SetPoint("TOPRIGHT", c, "TOPRIGHT", -16, -36)
	E.Tip = UI.Edit(c, { multi = true, height = 58, role = "note", placeholder = L["Tip: what the player should know on this step (optional)"], onCommit = function(text)
		local i = S.Model.Selected()
		if i then S.Model.SetStep(i, "note", text ~= "" and text or nil) end
	end })
	E.Tip:SetPoint("TOPLEFT", E.TitleBox, "BOTTOMLEFT", 0, -8)
	E.Tip:SetPoint("TOPRIGHT", E.TitleBox, "BOTTOMRIGHT", 0, -8)
	E.Only = W.Button(c, "", function(self)
		local i = S.Model.Selected()
		if not i then return end
		UI.OnlyMenu(self, function() local st = stepAt(i); return st and st.only end, function(only) S.Model.SetStep(i, "only", only) end)
	end, { height = 26 })
	E.Only:SetPoint("TOPLEFT", E.Tip, "BOTTOMLEFT", 0, -8)
	E.When = UI.Edit(c, { placeholder = L["when: e.g. level<12; onquest 783 (optional)"], onCommit = function(text)
		local i = S.Model.Selected()
		if not i then return end
		local list = {}
		for raw in text:gmatch("[^;]+") do
			local part = raw:match("^%s*(.-)%s*$")
			if part ~= "" then list[#list + 1] = part end
		end
		S.Model.SetStep(i, "when", #list > 0 and list or nil)
	end })
	E.When:SetPoint("LEFT", E.Only, "RIGHT", 8, 0)
	E.When:SetPoint("RIGHT", E.Tip, "RIGHT", 0, 0)
	E.psGoalsTop = 36 + 30 + 8 + 58 + 8 + 26 + 14
	E.Goals = W.SectionHeader(c)
	E.NoGoals = UI.Text(c, "note", "textMuted", true)
	E.NoGoals:SetText(L["No goals yet. Use a tool in the toolbar, the Target or Quest log tab, or a key binding: each adds one goal here."])
	editRows = UI.Pool(c, makeGoalRow)
end

---------------------------------------------------------------------------
-- Inspector (right)
---------------------------------------------------------------------------

local insp -- the inspector column
local INSPECT_ROW = 30

local function makeField(parent)
	local r = CreateFrame("Frame", nil, parent)
	r:SetHeight(INSPECT_ROW)
	r.Label = W.Text(r, "small", "textMuted")
	r.Label:SetPoint("LEFT", r, "LEFT", 0, 0)
	r.Label:SetWidth(84)
	r.Edit = UI.Edit(r, { height = 24, onCommit = function(text, box) if r.psCommit then r.psCommit(text) end end })
	r.Edit:SetPoint("LEFT", r, "LEFT", 88, 0)
	r.Edit:SetPoint("RIGHT", r, "RIGHT", -24, 0)
	r.Value = W.Text(r, "small", "text")
	r.Value:SetPoint("LEFT", r, "LEFT", 88, 0)
	r.Value:SetPoint("RIGHT", r, "RIGHT", -2, 0)
	r.Value:SetWordWrap(true)
	r.Remove = UI.Icon(r, "close", L["Remove"], function() if r.psRemove then r.psRemove() end end, 20)
	r.Remove:SetPoint("RIGHT", r, "RIGHT", 0, 0)
	r.Switch = W.Switch(r, function() return r.psOn and r.psOn() end, function(on) if r.psSet then r.psSet(on) end end)
	r.Switch:SetPoint("LEFT", r, "LEFT", 84, 0)
	return r
end

local fields, headings

-- Lay out a list of entries in the inspector:
--   { heading = text } | { label, value } (read-only) |
--   { label, edit = text, commit = fn(text), remove = fn } | { label, on = fn, set = fn(on) } |
--   { button = text, onClick = fn(self) } | { text = wrapped note, color }
local function inspect(entries)
	local c = insp.Scroll.Child
	local w = insp.Scroll:GetWidth()
	c:SetWidth(w)
	local y, nf, nh = 10, 0, 0
	for _, e in ipairs(entries) do
		if e.heading then
			nh = nh + 1
			local h = headings:Get(nh)
			h:ClearAllPoints()
			h:SetPoint("TOPLEFT", c, "TOPLEFT", 14, -y)
			h:SetPoint("TOPRIGHT", c, "TOPRIGHT", -14, -y)
			W.SetSection(h, e.heading, e.count)
			y = y + 40
		else
			nf = nf + 1
			local r = fields:Get(nf)
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", c, "TOPLEFT", 14, -y)
			r:SetPoint("TOPRIGHT", c, "TOPRIGHT", -14, -y)
			r.psCommit, r.psRemove, r.psOn, r.psSet = e.commit, e.remove, e.on, e.set
			r.Label:SetText(e.label or "")
			r.Edit:SetShown(e.edit ~= nil)
			r.Remove:SetShown(e.remove ~= nil)
			r.Switch:SetShown(e.on ~= nil)
			r.Value:SetShown(e.value ~= nil or e.text ~= nil)
			if r.psButton then r.psButton:Hide() end
			local h = INSPECT_ROW
			if e.edit ~= nil then
				UI.SetEdit(r.Edit, e.edit)
			elseif e.on ~= nil then
				r.Switch:Refresh()
			elseif e.button then
				r.psButton = r.psButton or W.Button(r, "", function(self) if self.psClick then self.psClick(self) end end, { height = 24 })
				r.psButton:ClearAllPoints()
				r.psButton:SetPoint("LEFT", r, "LEFT", 0, 0)
				W.SetButtonText(r.psButton, e.button)
				r.psButton.psClick = e.onClick
				r.psButton:Show()
			end
			if e.value ~= nil or e.text ~= nil then
				r.Value:ClearAllPoints()
				if e.text then
					r.Value:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -4)
				else
					r.Value:SetPoint("TOPLEFT", r, "TOPLEFT", 88, -8)
				end
				r.Value:SetPoint("RIGHT", r, "RIGHT", -2, 0)
				r.Value:SetText(tostring(e.text or e.value))
				W.Color(r.Value, e.color or (e.text and "textDim" or "text"))
				h = max(INSPECT_ROW, floor(r.Value:GetStringHeight() + 12))
			end
			r:SetHeight(h)
			y = y + h
		end
	end
	fields:HideFrom(nf + 1)
	headings:HideFrom(nh + 1)
	W.SetScrollContent(insp.Scroll, y + 20)
end

local function valueText(v)
	if type(v) ~= "table" then return tostring(v) end
	if v[1] ~= nil and type(v[1]) ~= "table" then
		local parts = {}
		for _, x in ipairs(v) do parts[#parts + 1] = tostring(x) end
		return concat(parts, ", ")
	end
	if v[1] ~= nil then return format(L["%d entries"], #v) end
	local parts = {}
	for k, x in pairs(v) do parts[#parts + 1] = tostring(k) .. "=" .. valueText(x) end
	table.sort(parts)
	return "{ " .. concat(parts, ", ") .. " }"
end

local function problemEntries(list, out)
	if #list == 0 then return end
	out[#out + 1] = { heading = L["Problems"], count = #list }
	for _, p in ipairs(list) do
		out[#out + 1] = { text = tostring(p.message), color = p.severity == "error" and "danger" or "warning" }
	end
end

local function sourceOf(g)
	local o = g.out or {}
	if UI.Mod(g.src, "at") or (g.src.verb == "goto") then return L["Coordinates: your position or a map click"] end
	if o.x and o.map then return L["Coordinates: Codex spawns (or the NPC you stood at)"] end
	return L["Names and ids: the game (target, quest log) first, then Codex"]
end

local function inspectGoal(i, j, g)
	local out = {}
	local src = g.src or {}
	out[#out + 1] = { heading = format(L["Goal %d.%d: %s"], i, j, src.verb or "?") }
	out[#out + 1] = { text = UI.GoalText(g), color = "text" }
	for k, a in ipairs(src.args or {}) do
		out[#out + 1] = { label = format(L["Argument %d"], k), edit = a, commit = function(text) UI.SetGoalArg(i, j, k, text) end }
	end
	if src.verb == "note" or src.verb == "goto" or src.verb == "task" then
		local k = #(src.args or {}) + 1
		out[#out + 1] = { label = format(L["Argument %d"], k), edit = "", commit = function(text) if text ~= "" then UI.SetGoalArg(i, j, k, text) end end }
	end
	out[#out + 1] = { heading = L["Modifiers"] }
	for _, m in ipairs(src.mods or {}) do
		local name = m[1]
		if FLAG[name] then
			out[#out + 1] = { label = name, on = function() return true end, set = function(on) UI.SetGoalMod(i, j, name, on and {} or nil) end, remove = function() UI.SetGoalMod(i, j, name, nil) end }
		elseif name == "only" then
			out[#out + 1] = { button = format(L["only: %s"], onlySummary(g.out and g.out.only)), onClick = function(self)
				UI.OnlyMenu(self, function() return g.out and g.out.only end, function(only)
					UI.SetGoalMod(i, j, "only", only and { UI.OnlyText(only) } or nil)
				end)
			end }
		else
			out[#out + 1] = { label = name, edit = concat(m, " ", 2), remove = function() UI.SetGoalMod(i, j, name, nil) end, commit = function(text)
				local values = {}
				for tok in text:gmatch("%S+") do values[#values + 1] = tok end
				UI.SetGoalMod(i, j, name, #values > 0 and values or nil)
			end }
		end
	end
	out[#out + 1] = { button = L["Add a modifier"], onClick = function(self)
		local items = {}
		for _, name in ipairs(UI.MODS[src.verb] or COMMON) do
			if not UI.Mod(src, name) then
				items[#items + 1] = { text = name, onClick = function()
					if FLAG[name] then
						UI.SetGoalMod(i, j, name, {})
					elseif name == "only" then
						UI.OnlyMenu(self, function() return nil end, function(only) UI.SetGoalMod(i, j, "only", only and { UI.OnlyText(only) } or nil) end)
					elseif name == "at" then
						S.Model.Select(i, j)
						S.Tools.Run("place")
					else
						UI.Prompt({ title = name, label = format(L["Value of %s"], name), onAccept = function(text)
							local values = {}
							for tok in text:gmatch("%S+") do values[#values + 1] = tok end
							if #values > 0 then UI.SetGoalMod(i, j, name, values) end
						end })
					end
				end }
			end
		end
		UI.Menu(self, items)
	end }
	out[#out + 1] = { label = L["-- note"], edit = src.note or "", commit = function(text)
		local s2 = UI.Copy(src)
		s2.note = text ~= "" and text or nil
		S.Model.UpdateGoal(i, j, s2, UI.Copy(g.out or {}))
	end }
	out[#out + 1] = { heading = L["Compiled"] }
	local keys = {}
	for k in pairs(g.out or {}) do keys[#keys + 1] = k end
	table.sort(keys)
	for _, k in ipairs(keys) do out[#out + 1] = { label = k, value = valueText(g.out[k]) } end
	out[#out + 1] = { heading = L["Where it came from"] }
	out[#out + 1] = { text = sourceOf(g) }
	problemEntries(problemsOn(i, j), out)
	inspect(out)
end

local function inspectStep(i, st)
	local out = {
		{ heading = format(L["Step %d"], i) },
		{ label = L["id"], value = st.id or "?" },
		{ label = L["Goals"], value = #(st.goals or {}) },
		{ label = L["Only"], value = onlySummary(st.only) },
	}
	problemEntries(problemsOn(i), out)
	inspect(out)
end

local function inspectGuide(d)
	local h = d.header
	local function edit(label, field, numeric)
		return { label = label, edit = h[field] or "", commit = function(text)
			S.Model.SetHeader(field, numeric and tonumber(text) or (text ~= "" and text or nil))
		end }
	end
	local out = {
		{ heading = L["Guide"] },
		edit(L["Title"], "title"),
		{ label = L["id"], value = h.id or "?" },
		{ button = format(L["Faction: %s"], L[h.faction or "Both"]), onClick = function(self)
			local items = {}
			for _, v in ipairs({ "Alliance", "Horde", "Both" }) do
				items[#items + 1] = { text = L[v], checked = (h.faction or "Both") == v, onClick = function() S.Model.SetHeader("faction", v) end }
			end
			UI.Menu(self, items)
		end },
		{ button = format(L["Type: %s"], L[h.category or "Leveling"]), onClick = function(self)
			local items = {}
			for _, v in ipairs({ "Leveling", "Dungeon", "Profession", "Collectible", "Chain", "Farm", "Reputation" }) do
				items[#items + 1] = { text = L[v], checked = h.category == v, onClick = function() S.Model.SetHeader("category", v) end }
			end
			UI.Menu(self, items)
		end },
		edit(L["Min level"], "minLevel", true),
		edit(L["Max level"], "maxLevel", true),
		edit(L["Zone"], "zone"),
		{ button = format(L["Races: %s"], #(h.races or {}) > 0 and concat(h.races, ", ") or L["all"]), onClick = function(self)
			local items = {}
			for _, v in ipairs(UI.RACES) do
				items[#items + 1] = { text = L[v], checked = inList(h.races, v), onClick = function()
					local t = UI.ToggleOnly({ races = h.races }, "races", v)
					S.Model.SetHeader("races", t and t.races or {})
				end }
			end
			UI.Menu(self, items)
		end },
		{ button = format(L["Classes: %s"], #(h.classes or {}) > 0 and concat(h.classes, ", ") or L["all"]), onClick = function(self)
			local items = {}
			for _, v in ipairs(UI.CLASSES) do
				items[#items + 1] = { text = L[v], checked = inList(h.classes, v), onClick = function()
					local t = UI.ToggleOnly({ classes = h.classes }, "classes", v)
					S.Model.SetHeader("classes", t and t.classes or {})
				end }
			end
			UI.Menu(self, items)
		end },
		edit(L["Author"], "author"),
		{ label = L["Version"], value = tostring(h.version or 1) },
		edit(L["Licence"], "license"),
	}
	if h.next then out[#out + 1] = { label = L["Next"], value = valueText(h.next), } end
	if h.forkedFrom then
		out[#out + 1] = { label = L["Based on"], value = format("%s v%s", tostring(h.forkedFrom.id), tostring(h.forkedFrom.version or "?")) }
	end
	out[#out + 1] = { heading = L["Credits"], count = #(h.credits or {}) }
	for k, cr in ipairs(h.credits or {}) do
		out[#out + 1] = { label = tostring(k), edit = cr, commit = function(text)
			local list = UI.Copy(h.credits)
			list[k] = text ~= "" and text or nil
			local clean = {}
			for _, x in pairs(list) do clean[#clean + 1] = x end
			S.Model.SetHeader("credits", clean)
		end }
	end
	out[#out + 1] = { button = L["Add a credit"], onClick = function()
		UI.Prompt({ title = L["Credits"], label = L["Someone who helped, in your words (\"Yendi: dungeon paths\")."], onAccept = function(text)
			if text == "" then return end
			local list = UI.Copy(h.credits) or {}
			list[#list + 1] = text
			S.Model.SetHeader("credits", list)
		end })
	end }
	local np = 0
	for _, p in ipairs(UI.AllProblems()) do if not p.step then np = np + 1 end end
	if np > 0 then
		local list = {}
		for _, p in ipairs(UI.AllProblems()) do if not p.step then list[#list + 1] = p end end
		problemEntries(list, out)
	end
	inspect(out)
end

local function refreshInspector()
	local d = doc()
	if not d then inspect({}) return end
	local i, j = S.Model.Selected()
	local st = i and d.steps[i]
	if st and j and st.goals[j] then
		inspectGoal(i, j, st.goals[j])
	elseif st then
		inspectStep(i, st)
	else
		inspectGuide(d)
	end
end

-- The Details tab of the dock: the inspector.
local function buildInspector(page)
	insp = page
	insp.Scroll = W.Scroll(insp)
	insp.Scroll:SetPoint("TOPLEFT", insp, "TOPLEFT", 1, -2)
	insp.Scroll:SetPoint("BOTTOMRIGHT", insp, "BOTTOMRIGHT", -2, 2)
	fields = UI.Pool(insp.Scroll.Child, makeField)
	headings = UI.Pool(insp.Scroll.Child, function(parent) return W.SectionHeader(parent) end)
	panel.Inspector = insp
end

---------------------------------------------------------------------------
-- The dock: Details, every widget (UI.Widget, Kit.lua) and Export as tabs
---------------------------------------------------------------------------

local DETAILS = "Details"
local tabs, pages = {}, {} -- key -> tab button, key -> page frame

-- The dock's tabs in order: Details, the widgets, Export.
local function tabKeys()
	local out = { { key = DETAILS, label = L["Details"] } }
	for _, def in ipairs(UI.WidgetList()) do out[#out + 1] = { key = def.name, label = L[def.title] } end
	out[#out + 1] = { key = "Export", label = L["Export"] }
	return out
end

-- The tab shown: the saved one while it still exists, else Details.
function UI.ActiveTab()
	local key = UI.State("Panel").tab
	if key == "Export" or (key and UI.widgets[key]) then return key end
	return DETAILS
end

-- The page of tab `key`, made on first use; a widget's is built by its own
-- build(frame) into frame.Body (the page itself).
function UI.DockPage(key, def)
	local page = pages[key]
	if page then return page end
	local f = UI.Panel()
	page = CreateFrame("Frame", nil, f.Dock)
	page:SetPoint("TOPLEFT", f.Dock.Tabs, "BOTTOMLEFT", 0, 0)
	page:SetPoint("BOTTOMRIGHT", f.Dock, "BOTTOMRIGHT", 0, 0)
	page:Hide()
	page.Body = page
	page.psName = key
	pages[key] = page
	if key == DETAILS then
		buildInspector(page)
	elseif key == "Export" then
		if UI.Export and UI.Export.Build then UI.Export.Build(page) end
	elseif def then
		def.frame = page
		def.build(page)
	end
	return page
end

local function layoutTabs()
	local row = panel.Dock.Tabs
	local x, active = 8, UI.ActiveTab()
	for _, t in ipairs(tabKeys()) do
		local b = tabs[t.key]
		if not b then
			b = CreateFrame("Button", nil, row)
			b:SetHeight(TAB_H)
			b.Label = W.Text(b, "label", "textDim")
			b.Label:SetPoint("CENTER", b, "CENTER", 0, 0)
			Theme.Skin(b, "tab")
			b.psKey = t.key
			b:SetScript("OnClick", function(self) UI.SelectTab(self.psKey) end)
			tabs[t.key] = b
		end
		local on = t.key == active
		Theme.SetTabSelected(b, on)
		b.Label:SetText(t.label)
		Theme.Font(b.Label, "label")
		W.Color(b.Label, on and "text" or "textDim")
		b:SetWidth(floor(b.Label:GetStringWidth() + 20 + 0.5))
		b:ClearAllPoints()
		b:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", x, 0)
		x = x + b:GetWidth() + 2
	end
end

-- Show tab `key` of the dock (a widget's name, "Details" or "Export").
function UI.SelectTab(key)
	local f = UI.Panel()
	if not f:IsShown() then UI.Show() end
	UI.ShowHome(false)
	UI.State("Panel").tab = key
	for k, page in pairs(pages) do
		if k ~= key then page:Hide() end
	end
	local page = UI.DockPage(key, UI.widgets[key])
	page:Show()
	if page.Refresh then page:Refresh() end
	layoutTabs()
	S.Fire("STUDIO_WIDGETS")
	if key == DETAILS then UI.Refresh() end
end

local function buildDock(f)
	local D = CreateFrame("Frame", nil, f)
	D:SetPoint("BOTTOMLEFT", f.Outline, "BOTTOMRIGHT", 0, 0)
	D:SetPoint("BOTTOMRIGHT", f.Status, "TOPRIGHT", -1, 0)
	D:SetHeight(DOCK_H)
	Theme.Skin(D, "inset")
	local rule = W.Divider(D)
	rule:SetPoint("TOPLEFT", D, "TOPLEFT", 0, 0)
	rule:SetPoint("TOPRIGHT", D, "TOPRIGHT", 0, 0)
	D.Tabs = CreateFrame("Frame", nil, D)
	D.Tabs:SetPoint("TOPLEFT", D, "TOPLEFT", 0, -2)
	D.Tabs:SetPoint("TOPRIGHT", D, "TOPRIGHT", 0, -2)
	D.Tabs:SetHeight(TAB_H)
	local under = W.Divider(D.Tabs)
	under:SetPoint("BOTTOMLEFT", D.Tabs, "BOTTOMLEFT", 0, 0)
	under:SetPoint("BOTTOMRIGHT", D.Tabs, "BOTTOMRIGHT", 0, 0)
	f.Dock = D
end

---------------------------------------------------------------------------
-- Status line
---------------------------------------------------------------------------

local function ago(t)
	if not t then return nil end
	local s = time() - t
	if s < 60 then return L["just now"] end
	return format(L["%d min ago"], floor(s / 60))
end

local function refreshStatus()
	local F = panel.Status
	local n = #UI.AllProblems()
	W.SetLinkText(F.Checks, n == 0 and L["No problems"] or format(n == 1 and L["%d problem"] or L["%d problems"], n))
	W.Color(F.Checks.Label, n == 0 and "success" or "warning")
	if not F.psSaying then
		local backup = S.Backup and S.Backup.LastTime and ago(S.Backup.LastTime())
		local capture = S.Capture and S.Capture.Enabled and S.Capture.Enabled() and (DOT .. L["auto-capture on"]) or ""
		F.State:SetText(L["Saved"] .. (backup and (DOT .. format(L["backup %s"], backup)) or "") .. capture)
		W.Color(F.State, "textMuted")
	end
end

local function buildStatus(f)
	local F = CreateFrame("Frame", nil, f)
	F:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)
	F:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
	F:SetHeight(STATUS_H)
	W.Fill(F, "footer")
	local rule = W.Divider(F)
	rule:SetPoint("TOPLEFT", F, "TOPLEFT", 0, 0)
	rule:SetPoint("TOPRIGHT", F, "TOPRIGHT", 0, 0)
	f.Status = F
	F.Checks = W.Link(F, "", function() UI.SelectTab("Checks") end, { role = "note" })
	F.Checks.psTip = L["Open the Checks tab"]
	F.Checks:SetPoint("LEFT", F, "LEFT", 10, 0)
	F.State = W.Text(F, "small", "textMuted")
	F.State:SetPoint("LEFT", F.Checks, "RIGHT", 14, 0)
	F.State:SetPoint("RIGHT", F, "RIGHT", -24, 0)
	F.State:SetJustifyH("LEFT")
	UI.OnSay(function(text, kind)
		if not (panel and panel:IsShown()) then return false end
		F.psSaying = true
		F.State:SetText(text)
		W.Color(F.State, kind or "textDim")
		if F.psTimer then F.psTimer:Cancel() end
		F.psTimer = C_Timer.NewTimer(5, function()
			F.psSaying = nil
			refreshStatus()
		end)
		return true
	end)
end

---------------------------------------------------------------------------
-- The whole panel
---------------------------------------------------------------------------

local function refreshHeader()
	local d = doc()
	local f = panel
	for k = 1, 3 do f.Chips[k]:Hide() end
	if not d then
		f.Title:SetText(L["Polestar Studio"])
		return
	end
	local h = d.header
	f.Title:SetText((h.title and h.title ~= "" and h.title or L["Untitled guide"]) .. DOT .. tostring(h.id or ""))
	W.SetChip(f.Chips[1], L[h.category or "Leveling"], "accent")
	if h.minLevel or h.maxLevel then
		W.SetChip(f.Chips[2], format("%s-%s", tostring(h.minLevel or "?"), tostring(h.maxLevel or "?")))
	end
	if h.faction and h.faction ~= "Both" then W.SetChip(f.Chips[3], L[h.faction]) end
end

function UI.Refresh()
	refreshQueued = false
	if not (panel and panel:IsShown()) then return end
	refreshHeader()
	if panel.HomeView:IsShown() then
		if UI.Home and UI.Home.Refresh then UI.Home.Refresh() end
		refreshStatus()
		return
	end
	UI.LayoutStrip()
	refreshOutline()
	refreshEditor()
	layoutTabs()
	if UI.ActiveTab() == DETAILS and insp then refreshInspector() end
	local active = pages[UI.ActiveTab()]
	if active and active ~= insp and active.Refresh then active:Refresh() end
	refreshStatus()
end

-- Changes come in bursts (an undo, a chain laid out): repaint once per frame.
local function queueRefresh()
	if refreshQueued then return end
	refreshQueued = true
	C_Timer.After(0, UI.Refresh)
end

S.On("STUDIO_CHANGED", function(kind)
	if kind == "doc" then
		for k in pairs(multi) do multi[k] = nil end
		UI.pinnedStep = nil
		UI.State("Panel").kit = nil
		if panel then UI.ShowHome(S.Model.Current() == nil) end
	end
	queueRefresh()
end)
S.On("STUDIO_SAVED", queueRefresh)
S.On("STUDIO_SYNCED", function(ok, problems)
	if ok == false and type(problems) == "table" and problems[1] then
		UI.Say(format(L["Polestar refused the draft: %s"], tostring(problems[1].message or problems[1])), "warning")
	end
	queueRefresh()
end)

local function build()
	local f = UI.Window("Panel", L["Polestar Studio"], WIDTH, HEIGHT, { strata = "HIGH", resizable = true, minW = 760, minH = 560, point = { "RIGHT", "RIGHT", -40, 0 } })
	panel = f
	headerButtons(f)
	buildStrip(f)
	buildStatus(f)
	buildOutline(f)
	buildDock(f)
	buildEditor(f)
	f.HomeView = CreateFrame("Frame", nil, f)
	f.HomeView:SetPoint("TOPLEFT", f.Head, "BOTTOMLEFT", 0, 0)
	f.HomeView:SetPoint("BOTTOMRIGHT", f.Status, "TOPRIGHT", 0, 0)
	f.HomeView:SetFrameLevel(f:GetFrameLevel() + 10)
	f.HomeView:EnableMouse(true)
	Theme.Skin(f.HomeView, "window")
	f.HomeView:Hide()
	if UI.Home and UI.Home.Build then UI.Home.Build(f.HomeView) end
	f:HookScript("OnSizeChanged", queueRefresh)
	f:HookScript("OnShow", function()
		if not S.Model.Current() then UI.ShowHome(true) end
		if #UI.problems == 0 and S.Model.Current() then UI.RunChecks() end
		local page = UI.DockPage(UI.ActiveTab(), UI.widgets[UI.ActiveTab()])
		page:Show()
		UI.Refresh()
	end)
	f:HookScript("OnHide", function() W.HideMenu() end)
	return f
end

function UI.Panel()
	return panel or build()
end

function UI.ShowHome(on)
	local f = UI.Panel()
	if not S.Model.Current() then on = true end
	f.HomeView:SetShown(on and true or false)
	f.Strip:SetShown(not on)
	W.SetIconState(f.HomeButton, on and true or false)
	if f:IsShown() then UI.Refresh() end
end

function UI.Show()
	local f = UI.Panel()
	f:Show()
	f:Raise()
end

function UI.Toggle()
	local f = UI.Panel()
	if f:IsShown() then f:Hide() else UI.Show() end
end
S.TogglePanel = UI.Toggle

-- Open the panel on a step or goal (the Checks widget's rows).
function UI.JumpTo(i, j)
	local d = doc()
	if not (d and i and d.steps[i]) then return end
	UI.Show()
	UI.ShowHome(false)
	local st = d.steps[i]
	if st.id then collapsed[st.id] = nil end
	query = ""
	if panel.Outline.Search:GetText() ~= "" then panel.Outline.Search:SetText("") end
	S.Model.Select(i, j and st.goals[j] and j or nil)
	-- Scroll the step editor and outline to it.
	C_Timer.After(0, function()
		if j then W.ScrollTo(panel.Editor.Scroll, max(0, panel.Editor.psGoalsTop + 44 + (j - 1) * EDIT_GOAL - 60)) end
		local y = 0
		for k = 1, i - 1 do
			y = y + STEP_ROW
			local s2 = d.steps[k]
			if not collapsed[s2.id or ""] then y = y + #(s2.goals or {}) * GOAL_ROW end
		end
		W.ScrollTo(panel.Outline.Scroll, max(0, y - 40))
	end)
end
