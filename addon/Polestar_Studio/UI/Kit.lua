-- Polestar Studio UI kit: what every Studio window, widget and tool shares.
-- Everything is drawn with Polestar's own Theme and Widgets (docs/DESIGN.md:
-- Dusk by default, one gold accent, square corners, hairlines, colours by
-- palette name only).
--
--   S.UI.Window(name, title, w, h, opts) -> frame   a themed window (the Studio window, Panel.lua)
--   S.UI.Widget(name, title, w, h, build) -> def   a tab of the window's dock (Panel.lua)
--   S.UI.ShowWidget(name, on) / ToggleWidget(name) / WidgetShown(name)
--   S.UI.Edit(parent, opts) -> editbox            commits on Enter / focus lost
--   S.UI.Say(text, kind)                          a status line (or chat)
--   S.UI.Add(src, out, why) -> i, j               a goal into the selected step
--   S.UI.Resolve(fn, ...) -> i, j                 S.Resolve[fn](...) then Add
--   S.UI.GoalText(goal) / GoalIcon(goal) / Where(out)
--   S.Tools.Register(def) / S.Tools.Run(key) / S.Tools.List(kit)

local ADDON, S = ...
local L = S.L
local P = _G.Polestar
local Theme, W = P.Theme, P.Widgets
local format, floor, max, min, type, pairs, ipairs, tostring, tonumber =
	string.format, math.floor, math.max, math.min, type, pairs, ipairs, tostring, tonumber

local UI = S.UI or {}
S.UI = UI
UI.Theme, UI.W = Theme, W

---------------------------------------------------------------------------
-- Saved state
---------------------------------------------------------------------------

function UI.DB()
	local db = _G.PolestarStudioDB
	if type(db) ~= "table" then return nil end
	if type(db.ui) ~= "table" then db.ui = {} end
	return db.ui
end

-- The saved table of one window or widget ({ point, x, y, shown, ... }).
function UI.State(name)
	local ui = UI.DB()
	if not ui then return {} end
	local s = ui[name]
	if type(s) ~= "table" then
		s = {}
		ui[name] = s
	end
	return s
end

function UI.Handle()
	local db = _G.PolestarStudioDB
	local h = type(db) == "table" and db.handle
	if type(h) == "string" and h ~= "" then return h end
	return nil
end

function UI.SetHandle(h)
	local db = _G.PolestarStudioDB
	if type(db) ~= "table" then return end
	h = (h or ""):lower():gsub("[^a-z0-9_-]", "")
	db.handle = h ~= "" and h or nil
end

---------------------------------------------------------------------------
-- Small builders
---------------------------------------------------------------------------

-- A font string; wrap = true lets it run onto more lines (top aligned).
function UI.Text(parent, role, color, wrap)
	local fs = W.Text(parent, role or "body", color or "text")
	if wrap then
		fs:SetWordWrap(true)
		fs:SetJustifyV("TOP")
	end
	return fs
end

-- An edit box in the search field's well. opts: { multi, height, role,
-- placeholder, onCommit(text), onChange(text), max, numeric }.
-- Enter (single line) or leaving the box commits a changed text; Escape
-- puts the last committed text back.
function UI.Edit(parent, opts)
	opts = opts or {}
	local e = CreateFrame("EditBox", nil, parent)
	e:SetAutoFocus(false)
	Theme.Font(e, opts.role or "label")
	W.Color(e, "text")
	e:SetMaxLetters(opts.max or 0)
	if opts.multi then
		e:SetMultiLine(true)
		e:SetHeight(opts.height or 64)
		e:SetTextInsets(8, 8, 6, 6)
	else
		e:SetHeight(opts.height or 26)
		e:SetTextInsets(8, 8, 0, 0)
	end
	if opts.numeric then e:SetNumeric(true) end
	Theme.Skin(e, "editbox")
	e.Hint = W.Text(e, opts.role or "label", "textMuted")
	e.Hint:SetPoint("TOPLEFT", e, "TOPLEFT", 8, opts.multi and -6 or 0)
	if not opts.multi then e.Hint:SetPoint("BOTTOMLEFT", e, "BOTTOMLEFT", 8, 0) end
	e.Hint:SetPoint("RIGHT", e, "RIGHT", -8, 0)
	e.Hint:SetText(opts.placeholder or "")
	e.psValue = ""
	local function commit(self)
		local text = self:GetText() or ""
		if text ~= self.psValue then
			self.psValue = text
			if opts.onCommit then opts.onCommit(text, self) end
		end
	end
	e:SetScript("OnEditFocusGained", function(self) Theme.SetFocused(self, true) end)
	e:SetScript("OnEditFocusLost", function(self)
		Theme.SetFocused(self, false)
		commit(self)
	end)
	e:SetScript("OnEscapePressed", function(self)
		self:SetText(self.psValue or "")
		self:ClearFocus()
	end)
	if not opts.multi then
		e:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
	end
	e:SetScript("OnTextChanged", function(self, user)
		local text = self:GetText() or ""
		self.Hint:SetShown(text == "")
		if user and opts.onChange then opts.onChange(text, self) end
	end)
	e.Commit = commit
	return e
end

-- Fill an edit box without committing.
function UI.SetEdit(e, value)
	if e:HasFocus() then return end
	e.psValue = value and tostring(value) or ""
	e:SetText(e.psValue)
	e.Hint:SetShown(e.psValue == "")
	e:SetCursorPosition(0)
end

-- A list of reusable children: pool:Get(i) makes the i-th with make(parent).
function UI.Pool(parent, make)
	local pool = { items = {} }
	function pool:Get(i)
		local f = self.items[i]
		if not f then
			f = make(parent, i)
			self.items[i] = f
		end
		f:Show()
		return f
	end
	function pool:HideFrom(n)
		for k = n, #self.items do self.items[k]:Hide() end
	end
	return pool
end

-- A list row: selection wash, hover wash, hairline under it.
function UI.Row(parent, height)
	local row = CreateFrame("Button", nil, parent)
	row:SetHeight(height or 28)
	row.Sel = W.Fill(row, "text", "BACKGROUND", -5)
	W.Painter(row.Sel, function(t) t:SetVertexColor(Theme.Wash("selected")) end)
	row.Sel:Hide()
	W.Hover(row)
	row.Rule = W.Divider(row, false, 0.5)
	row.Rule:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 0)
	row.Rule:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
	return row
end

-- A small glyph button with a tooltip.
function UI.Icon(parent, icon, tip, onClick, size)
	return W.IconButton(parent, icon, size or 22, tip, onClick)
end

-- An icon button showing a raw texture path (verb glyphs, raid icons).
function UI.TexButton(parent, path, tip, onClick, size, tint)
	local b = CreateFrame("Button", nil, parent)
	size = size or 26
	b:SetSize(size, size)
	W.Hover(b)
	b.Icon = b:CreateTexture(nil, "ARTWORK")
	b.Icon:SetTexture(path)
	b.Icon:SetSize(floor(size * 0.65 + 0.5), floor(size * 0.65 + 0.5))
	b.Icon:SetPoint("CENTER")
	b.psTint = tint
	if tint ~= false then W.Color(b.Icon, tint or "icon") end
	b.psTip = tip
	b:SetScript("OnEnter", function(self)
		if self.psTint ~= false then W.Color(self.Icon, "iconHover") end
		W.SimpleTip(self)
	end)
	b:SetScript("OnLeave", function(self)
		if self.psTint ~= false then W.Color(self.Icon, self.psActive and "accent" or (self.psTint or "icon")) end
		W.HideTip(self)
	end)
	b:SetScript("OnMouseDown", function(self) self.Icon:SetPoint("CENTER", self, "CENTER", 0, -1) end)
	b:SetScript("OnMouseUp", function(self) self.Icon:SetPoint("CENTER", self, "CENTER", 0, 0) end)
	if onClick then b:SetScript("OnClick", onClick) end
	return b
end

function UI.SetActive(b, on)
	b.psActive = on and true or false
	if b.Icon and b.psTint ~= false then W.Color(b.Icon, b.psActive and "accent" or "icon") end
end

-- Show a tool's glyph on a button: house glyphs tinted, game art (raid
-- icons) in its own colours.
function UI.SetToolIcon(b, def)
	b.Icon:SetTexture(S.Tools.Icon(def))
	if def.tex then
		b.psTint = false
		W.Uncolor(b.Icon)
		b.Icon:SetVertexColor(1, 1, 1, 1)
	else
		b.psTint = nil
		W.Color(b.Icon, "icon")
	end
end

---------------------------------------------------------------------------
-- Windows and widgets
---------------------------------------------------------------------------

local HEAD = 30
UI.HEAD = HEAD
local windows = {} -- name -> frame

local function savePosition(f)
	local s = UI.State(f.psName)
	local point, _, relPoint, x, y = f:GetPoint(1)
	s.point, s.rel, s.x, s.y = point, relPoint, x, y
end

function UI.RestorePosition(f)
	local s = UI.State(f.psName)
	f:ClearAllPoints()
	if s.point then
		f:SetPoint(s.point, UIParent, s.rel or s.point, s.x or 0, s.y or 0)
	else
		local d = f.psDefault
		f:SetPoint(d[1], UIParent, d[2], d[3], d[4])
	end
	if s.w and s.h and f.psResizable then f:SetSize(s.w, s.h) end
end

-- A floating window in Polestar's look: the window ground, a band of night
-- sky as its title bar (drag to move), a close glyph. opts: { strata,
-- point = { point, rel, x, y }, noClose, resizable, minW, minH, onClose }.
function UI.Window(name, title, w, h, opts)
	opts = opts or {}
	local f = CreateFrame("Frame", "PolestarStudio" .. name, UIParent)
	f.psName = name
	f:SetSize(w, h)
	f:SetFrameStrata(opts.strata or "MEDIUM")
	f:SetToplevel(true)
	f:SetClampedToScreen(true)
	f:EnableMouse(true)
	f:SetMovable(true)
	f:Hide()
	Theme.Skin(f, "window")
	f.psDefault = opts.point or { "CENTER", "CENTER", 0, 0 }

	local head = CreateFrame("Frame", nil, f)
	head:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -1)
	head:SetHeight(HEAD)
	head:EnableMouse(true)
	head:RegisterForDrag("LeftButton")
	head:SetScript("OnDragStart", function() f:StartMoving() end)
	head:SetScript("OnDragStop", function()
		f:StopMovingOrSizing()
		savePosition(f)
	end)
	f.Head = head
	f.Band = Theme.Band(head, "BACKGROUND", -5)
	f.Band:SetAllPoints(head)
	f.Band:SetTexCoord(Theme.BandCoords(w, HEAD))
	local rule = W.Divider(head)
	rule:SetPoint("BOTTOMLEFT", head, "BOTTOMLEFT", 0, 0)
	rule:SetPoint("BOTTOMRIGHT", head, "BOTTOMRIGHT", 0, 0)
	f.Title = W.Text(head, "heading", "text")
	f.Title:SetPoint("LEFT", head, "LEFT", 12, 0)
	f.Title:SetPoint("RIGHT", head, "RIGHT", -64, 0)
	f.Title:SetText(title or "")
	if not opts.noClose then
		f.Close = W.IconButton(head, "close", 22, L["Close"], function()
			f:Hide()
			if opts.onClose then opts.onClose(f) end
		end, 12)
		f.Close:SetPoint("RIGHT", head, "RIGHT", -4, 0)
	end
	f.Body = CreateFrame("Frame", nil, f)
	f.Body:SetPoint("TOPLEFT", head, "BOTTOMLEFT", 0, 0)
	f.Body:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)

	if opts.resizable then
		f.psResizable = true
		f:SetResizable(true)
		if f.SetResizeBounds then f:SetResizeBounds(opts.minW or w, opts.minH or h) elseif f.SetMinResize then f:SetMinResize(opts.minW or w, opts.minH or h) end
		local grip = W.IconButton(f, "resize", 16, L["Drag to resize"], nil, 10)
		grip:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
		grip:SetFrameLevel(f:GetFrameLevel() + 20)
		grip:RegisterForDrag("LeftButton")
		grip:SetScript("OnDragStart", function() f:StartSizing("BOTTOMRIGHT") end)
		grip:SetScript("OnDragStop", function()
			f:StopMovingOrSizing()
			local s = UI.State(name)
			s.w, s.h = floor(f:GetWidth() + 0.5), floor(f:GetHeight() + 0.5)
			savePosition(f)
		end)
		f.Grip = grip
		f:HookScript("OnSizeChanged", function(self, nw)
			self.Band:SetTexCoord(Theme.BandCoords(nw, HEAD))
		end)
	end
	if _G.UISpecialFrames and opts.escape ~= false then table.insert(_G.UISpecialFrames, f:GetName()) end
	windows[name] = f
	UI.RestorePosition(f)
	return f
end

function UI.WindowByName(name) return windows[name] end

-- Widgets: the tabs of the Studio window's dock (Panel.lua: UI.DockPage,
-- UI.SelectTab), in the order they register. build(frame) fills the tab's
-- page once, on its first show; frame.Body is the page itself.
local widgets, widgetOrder = {}, {}
UI.widgets = widgets

function UI.Widget(name, title, w, h, build, opts)
	local def = { name = name, title = title, w = w, h = h, build = build, opts = opts or {} }
	widgets[name] = def
	widgetOrder[#widgetOrder + 1] = name
	return def
end

function UI.WidgetList()
	local out = {}
	for _, name in ipairs(widgetOrder) do out[#out + 1] = widgets[name] end
	return out
end

-- A widget's page in the dock, built on first use.
function UI.WidgetFrame(name)
	local def = widgets[name]
	if not (def and UI.DockPage) then return nil end
	def.frame = def.frame or UI.DockPage(name, def)
	return def.frame
end

-- on: open the Studio window on the widget's tab; off: back to Details.
function UI.ShowWidget(name, on)
	if not widgets[name] then return end
	if on then
		UI.SelectTab(name)
	elseif UI.WidgetShown(name) then
		UI.SelectTab("Details")
	end
end

function UI.WidgetShown(name)
	local def = widgets[name]
	return def and def.frame and def.frame:IsVisible() or false
end

function UI.ToggleWidget(name)
	UI.ShowWidget(name, not UI.WidgetShown(name))
end

function UI.HideInCombat()
	local ui = UI.DB()
	return ui and ui.hideInCombat and true or false
end

function UI.SetHideInCombat(on)
	local ui = UI.DB()
	if ui then ui.hideInCombat = on and true or false end
end

-- Hide the Studio window in combat (when asked), show it again after.
local hiddenForCombat = false
S.RegisterEvent("PLAYER_REGEN_DISABLED", function()
	UI.combatHidden = true
	local panel = windows.Panel
	if UI.HideInCombat() and panel and panel:IsShown() then
		hiddenForCombat = true
		panel:Hide()
	end
end)
S.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	UI.combatHidden = false
	if hiddenForCombat and windows.Panel then windows.Panel:Show() end
	hiddenForCombat = false
end)

-- Windows go back where the author left them once the saved variables are in.
S.On("STUDIO_LOADED", function()
	for _, f in pairs(windows) do UI.RestorePosition(f) end
end)

---------------------------------------------------------------------------
-- Status line
---------------------------------------------------------------------------

local sayHandlers = {}
function UI.OnSay(fn) sayHandlers[#sayHandlers + 1] = fn end

-- kind: nil | "success" | "warning" | "danger". Shown on the panel's bottom
-- bar while it is open, else printed to chat.
function UI.Say(text, kind)
	if not text then return end
	local shown = false
	for _, fn in ipairs(sayHandlers) do shown = fn(text, kind) or shown end
	if not shown and DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage(format("|c%s%s|r  %s", Theme.Hex("accent"), L["Polestar Studio"], tostring(text)))
	end
end

function UI.InCombat()
	return InCombatLockdown and InCombatLockdown() or false
end

-- Studio does no work in combat (spec 9.5): tools refuse and say so.
function UI.Ready()
	if UI.InCombat() then
		UI.Say(L["Not in combat: Studio waits until the fight is over."], "warning")
		return false
	end
	return true
end

---------------------------------------------------------------------------
-- Tokens and modifiers (source tree: tokens as written)
---------------------------------------------------------------------------

-- A name as one token: quoted when it holds a space or a quote.
function UI.Token(s)
	s = tostring(s or "")
	if s:find("[%s\"]") or s == "" then return '"' .. s:gsub("\\", "\\\\"):gsub('"', '\\"') .. '"' end
	return s
end

-- A quoted token's text.
function UI.Untoken(s)
	s = tostring(s or "")
	local inner = s:match('^"(.*)"$')
	if inner then return (inner:gsub('\\(.)', "%1")) end
	return s
end

-- The first modifier named `name` on a source goal -> its list, or nil.
function UI.Mod(src, name)
	for _, m in ipairs(src and src.mods or {}) do
		if m[1] == name then return m end
	end
	return nil
end

-- Set (values: a list of tokens, {} for a bare flag) or drop (nil) a modifier.
function UI.SetMod(src, name, values)
	src.mods = src.mods or {}
	for k = #src.mods, 1, -1 do
		if src.mods[k][1] == name then table.remove(src.mods, k) end
	end
	if values then
		local m = { name }
		for _, v in ipairs(values) do m[#m + 1] = tostring(v) end
		src.mods[#src.mods + 1] = m
	end
	return src
end

function UI.Copy(v)
	if type(v) ~= "table" then return v end
	local out = {}
	for k, x in pairs(v) do out[k] = UI.Copy(x) end
	return out
end

---------------------------------------------------------------------------
-- Goals: words, glyphs, places
---------------------------------------------------------------------------

UI.STANDINGS = { "Hated", "Hostile", "Unfriendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted" }
UI.ICONS = { "star", "circle", "diamond", "triangle", "moon", "square", "cross", "skull" }

function UI.RaidIcon(n)
	return "Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. tostring(n)
end

local VERB = {
	accept = "Accept %s", turnin = "Turn in %s", complete = "Complete %s", kill = "Kill %s", collect = "Collect %s",
	["goto"] = "Go to %s", talk = "Talk to %s", interact = "Click %s", use = "Use %s", sethome = "Set your home at %s",
	hearth = "Hearth to %s", getfp = "Get the flight path at %s", fly = "Fly to %s", train = "Train %s", buy = "Buy %s",
	vendor = "Sell and repair at %s", level = "Reach level %s", note = "%s", skill = "Reach %s", learn = "Learn %s",
	craft = "Craft %s", rep = "Reach %s", explore = "Explore %s", achieve = "Earn %s", boss = "Defeat %s",
	mark = "Mark %s", path = "Walk the path %s", area = "Hunt in %s", task = "%s", money = "Have %s",
}

local function nameOf(o, s)
	local n = o.title or o.target or o.npcName or o.itemName or o.objName or o.spellName or o.achievementName
		or o.location or o.text or o.skill
	if o.t == "rep" then
		n = format("%s with %s", L[UI.STANDINGS[o.standing or 0] or "?"], o.factionName or tostring(o.faction or "?"))
	elseif o.t == "skill" then
		n = format("%s %s", o.skill or "?", tostring(o.level or "?"))
	elseif o.t == "level" then
		n = tostring(o.level or "?") .. (o.frac and format(" (%d%%)", floor(o.frac * 100 + 0.5)) or "")
	elseif o.t == "path" then
		n = format(L["(%d points)"], o.pts and #o.pts or 0) .. (o.text and (" " .. o.text) or "")
	elseif o.t == "area" then
		n = o.text or o.npcName or format(L["%d points"], o.pts and #o.pts or 0)
	elseif o.t == "money" then
		n = tostring(o.money or "?")
	end
	if not n and s and s.args then n = UI.Untoken(s.args[#s.args] or s.args[1] or "") end
	return n or "?"
end

function UI.GoalText(goal)
	local o, s = goal.out or {}, goal.src or {}
	local t = o.t or s.verb or "note"
	local text = format(L[VERB[t] or "%s"], nameOf(o, s))
	if o.count and o.count > 1 then text = text .. format(" x%d", o.count) end
	return text
end

function UI.Verb(goal)
	return (goal.out and goal.out.t) or (goal.src and goal.src.verb) or "note"
end

function UI.GoalIcon(goal)
	local t = UI.Verb(goal)
	if t == "mark" and goal.out and goal.out.icon then return UI.RaidIcon(goal.out.icon), false end
	if t == "boss" then return Theme.Media("icon-dungeon") end
	if t == "area" then return Theme.Media("layers") end
	if t == "task" then return Theme.Media("check") end
	if t == "money" then return Theme.Media("icon-vendor") end
	return Theme.VerbIcon(t)
end

function UI.MapName(map)
	if not (map and C_Map and C_Map.GetMapInfo) then return nil end
	local info = C_Map.GetMapInfo(map)
	return info and info.name or nil
end

-- "47.6, 35.1 · Elwynn Forest" for a goal with coordinates, or nil.
function UI.Where(o)
	if not (o and o.x and o.y) then
		if o and o.pts and o.pts[1] then
			return format("%.1f, %.1f", o.pts[1].x, o.pts[1].y) .. (o.map and ("  \194\183  " .. (UI.MapName(o.map) or o.map)) or "")
		end
		return nil
	end
	local where = format("%.1f, %.1f", o.x, o.y)
	if o.map then where = where .. "  \194\183  " .. tostring(UI.MapName(o.map) or o.map) end
	return where
end

-- "quest 783.2" for a goal linked to a quest objective.
function UI.QuestLink(o)
	if not (o and o.quest) then return nil end
	if o.oi then return format("quest %d.%d", o.quest, o.oi) end
	return format("quest %d", o.quest)
end

---------------------------------------------------------------------------
-- Adding goals
---------------------------------------------------------------------------

-- The step new goals go to: the selected one, a new one when the guide has
-- none. -> i, or nil when no guide is open.
function UI.TargetStep()
	local doc = S.Model.Current()
	if not doc then
		UI.Say(L["Start or open a guide first."], "warning")
		if UI.Show then UI.Show() end
		return nil
	end
	local i = S.Model.Selected()
	if not (i and doc.steps[i]) then
		if #doc.steps == 0 then
			i = S.Model.AddStep(L["New step"])
		else
			i = #doc.steps
		end
	end
	return i
end

-- Add one goal after the selected goal of the selected step and select it.
function UI.Add(src, out, why)
	if not src then
		UI.Say(why or L["Nothing to add here."], "warning")
		return nil
	end
	local i = UI.TargetStep()
	if not i then return nil end
	local _, sel = S.Model.Selected()
	local doc = S.Model.Current()
	local at = (sel and doc.steps[i] and doc.steps[i].goals[sel]) and sel + 1 or nil
	local j = S.Model.AddGoal(i, src, out or {}, at)
	if j then
		S.Model.Select(i, j)
		UI.Say(format(L["Added: %s"], UI.GoalText({ src = src, out = out or {} })), "success")
	end
	return i, j
end

-- S.Resolve[fn](...) and add what it returns.
function UI.Resolve(fn, ...)
	if not UI.Ready() then return nil end
	local R = S.Resolve
	if not (R and R[fn]) then
		UI.Say(format(L["%s is not available."], fn), "danger")
		return nil
	end
	local ok, src, out = pcall(R[fn], ...)
	if not ok then
		UI.Say(tostring(src), "danger")
		return nil
	end
	return UI.Add(src, out, out)
end

-- Replace the selected goal's src/out (re-resolved or edited).
function UI.Replace(i, j, src, out)
	if not (i and j and src) then return end
	S.Model.UpdateGoal(i, j, src, out or {})
end

-- The live position (S.Resolve.Here) or nil with a message.
function UI.Here()
	local here = S.Resolve and S.Resolve.Here and S.Resolve.Here()
	if not (here and here.map and here.x) then
		local C = P.Compat
		local map, x, y
		if C and C.GetPlayerMapPosition then map, x, y = C.GetPlayerMapPosition() end
		if map then here = here or {}; here.map, here.x, here.y = map, x, y end
	end
	if not (here and here.map and here.x) then return nil end
	return here
end

-- A goto at a point on a map (a map click, a spawn): live-frame coordinates.
function UI.GotoAt(map, x, y, label)
	local src = { verb = "goto", args = { format("%.2f,%.2f", x, y) }, mods = { { "frame", "live" } } }
	if label and label ~= "" then src.args[2] = UI.Token(label) end
	if map then UI.SetMod(src, "map", { map }) end
	local out = { t = "goto", map = map, x = floor(x * 100 + 0.5) / 100, y = floor(y * 100 + 0.5) / 100, text = label }
	return src, out
end

---------------------------------------------------------------------------
-- Tools registry
---------------------------------------------------------------------------

-- def = { key, label, icon (media name) | tex (path), kit = "core" | "leveling" |
-- "dungeon" | "profession" | "collectible" | "chain" | "farm" | "reputation",
-- tip, run = fn(), belt = true (on the Toolbelt) }
local Tools = S.Tools or {}
S.Tools = Tools
Tools.list, Tools.byKey = Tools.list or {}, Tools.byKey or {}

_G.BINDING_HEADER_POLESTARSTUDIO = "Polestar Studio"
_G.BINDING_NAME_POLESTARSTUDIO_TOGGLE = L["Toggle the Studio panel"]
_G.BINDING_NAME_POLESTARSTUDIO_UNDO = L["Undo"]
_G.BINDING_NAME_POLESTARSTUDIO_REDO = L["Redo"]

function Tools.Register(def)
	if Tools.byKey[def.key] then return Tools.byKey[def.key] end
	def.kit = def.kit or "core"
	Tools.list[#Tools.list + 1] = def
	Tools.byKey[def.key] = def
	_G["BINDING_NAME_POLESTARSTUDIO_" .. def.key:upper()] = def.label
	return def
end

function Tools.Run(key)
	local def = Tools.byKey[key]
	if not def then return end
	local ok, err = pcall(def.run, def)
	if not ok then UI.Say(tostring(err), "danger") end
end

-- The tools a bar shows for a kit (the core's, then the kit's; those with
-- belt = false wait in the bar's More menu) -> shown, more
function Tools.ForBar(kit)
	local shown, more = {}, {}
	for _, k in ipairs({ "core", kit }) do
		for _, def in ipairs(Tools.list) do
			if def.kit == k then
				if def.belt == false then more[#more + 1] = def else shown[#shown + 1] = def end
			end
		end
	end
	return shown, more
end

-- The More menu of a bar.
function Tools.MoreMenu(anchor, more)
	local items = {}
	for _, def in ipairs(more) do
		items[#items + 1] = { text = L[def.label], tip = def.tip and L[def.tip], onClick = function() Tools.Run(def.key) end }
	end
	if UI.Menu then UI.Menu(anchor, items) end
end

function Tools.List(kit)
	local out = {}
	for _, def in ipairs(Tools.list) do
		if kit == nil or def.kit == kit then out[#out + 1] = def end
	end
	return out
end

-- The toolkit of a guide category.
local KIT_OF = {
	Leveling = "leveling", Dungeon = "dungeon", Profession = "profession", Collectible = "collectible",
	Chain = "chain", Farm = "farm", Reputation = "reputation",
}
UI.KITS = {
	{ key = "leveling", label = "Leveling" }, { key = "dungeon", label = "Dungeon walkthrough" },
	{ key = "profession", label = "Profession" }, { key = "collectible", label = "Collectible" },
	{ key = "chain", label = "Chain / attunement" }, { key = "farm", label = "Farm / gold loop" },
	{ key = "reputation", label = "Reputation / achievement" },
}
function UI.KitOf(category) return KIT_OF[category or ""] or "leveling" end

function Tools.Icon(def)
	if def.tex then return def.tex end
	return Theme.Media(def.icon or "plus")
end

-- Bindings.xml handlers.
_G.PolestarStudio_Binding = function(key)
	if key == "TOGGLE" then
		if UI.Toggle then UI.Toggle() end
	elseif key == "UNDO" then
		if S.Model.CanUndo() then S.Model.Undo() end
	elseif key == "REDO" then
		if S.Model.CanRedo() then S.Model.Redo() end
	else
		Tools.Run(key:lower())
	end
end

-- Placeholder until Panel.lua loads: /studio before anything else.
UI.Toggle = UI.Toggle or function() end
