-- The window that changes the built-in stat weights (Gear/Adjust.lua, #1529):
-- one spec of the player's class at a time, every stat it weighs at the
-- player's level, each a box to change. A changed stat carries the 6px accent
-- dot before its name (docs/DESIGN.md, the Row Rule) and a reset button that
-- puts it back, its default in the button's tooltip; Add a stat weighs one
-- the spec leaves out; Revert to default (click twice) clears every change of
-- the spec. A change applies at once, wherever gear advice scores an item,
-- and always to the stat it was typed for: a box being typed in when the
-- lines change (another spec, a stat added) gives its number to its own
-- stat first.
--
--   UI.ShowAdjust([spec])   open it on that spec, else the one in use
--   UI.AdjustView           what it shows, for the tests: { frame, lines, spec }
--
-- Built on first use; colours are Theme tokens only.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local format, floor = string.format, math.floor

local WIDTH, HEIGHT = 560, 560
local PAD = 24
local HEAD_H = 56
local LINE_H = 28
local COL_GAP = 16
local BOX_W = 64
local DOT = 6
local DOT_GAP = 6
local RESET_W = 18
local SCROLL_W = 12

local F
local spec -- the spec key shown
local lines = {}

local function gear() return ns.Gear end

local function playerClass()
	return gear().GetPlayer().class
end

local function playerLevel()
	return gear().GetPlayer().level or 1
end

local function valueText(v)
	return tostring(floor(v * 1000 + (v >= 0 and 0.5 or -0.5)) / 1000)
end

-- A stat in plain words: the scales window's names (UI/GearScales.lua).
local function nameOf(key)
	local view = UI.ScalesStatName
	return view and view(key) or key
end

local function specLabel(class, key)
	local meta = gear().CLASSES[class]
	for _, s in ipairs(meta and meta.specs or {}) do
		if s.key == key then return L[s.label] end
	end
	return key
end

-- The built-in spec in use: the chosen or detected one (a custom scale in use
-- has none; then the one talents point to).
local function specInUse(class)
	local key, _, source = gear().GetSpec()
	if source ~= "custom" and key then return key end
	return (gear().DetectSpec(class))
end

local function setStatus(text, role)
	F.Status:SetText(text or "")
	W.Color(F.Status, role or "textDim")
end

---------------------------------------------------------------------------
-- The weights
---------------------------------------------------------------------------

local relist

local function newLine(parent)
	local line = CreateFrame("Frame", nil, parent)
	line:SetHeight(LINE_H)
	line.Dot = W.Tex(line, "ARTWORK", "circle", "accent")
	line.Dot:SetSize(DOT, DOT)
	line.Dot:SetPoint("LEFT", line, "LEFT", 0, 0)
	line.Label = W.Text(line, "small", "text")
	line.Label:SetPoint("LEFT", line, "LEFT", DOT + DOT_GAP, 0)
	line.Label:SetJustifyH("LEFT")
	line.Label:SetWordWrap(false)
	line.Reset = W.IconButton(line, "reset", RESET_W, L["Back to the default"], function()
		gear().Adjust.Clear(playerClass(), spec, line.psKey)
	end, 10)
	line.Reset:SetPoint("RIGHT", line, "RIGHT", 0, 0)
	local e = CreateFrame("EditBox", nil, line)
	e:SetAutoFocus(false)
	Theme.Font(e, "label")
	W.Color(e, "text")
	e:SetSize(BOX_W, 22)
	e:SetTextInsets(6, 6, 0, 0)
	e:SetMaxLetters(12)
	Theme.Skin(e, "editbox")
	e:SetPoint("RIGHT", line, "RIGHT", -(RESET_W + 6), 0)
	-- The stat the box was focused on, so what is typed goes to it even when
	-- the lines have moved on since (another spec, a stat added above it).
	local function commit()
		local f = line.psFocus or { class = playerClass(), spec = spec, key = line.psKey, value = line.psValue }
		line.psFocus = nil
		local n = gear().Pawn.Number(e:GetText())
		if n == nil then
			e:SetText(valueText(line.psValue or 0))
		elseif f.key and n ~= f.value then
			gear().Adjust.Set(f.class, f.spec, f.key, n, playerLevel())
		end
	end
	line.psCommit = commit
	e:SetScript("OnEditFocusGained", function(self)
		Theme.SetFocused(self, true)
		line.psFocus = { class = playerClass(), spec = spec, key = line.psKey, value = line.psValue }
	end)
	e:SetScript("OnEditFocusLost", function(self)
		Theme.SetFocused(self, false)
		commit()
	end)
	e:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
	e:SetScript("OnEscapePressed", function(self)
		self:SetText(valueText(line.psValue or 0))
		self:ClearFocus()
	end)
	line.Box = e
	return line
end

-- The stats the spec has no line for, in a menu.
local function addMenu(anchor)
	local class = playerClass()
	local have = {}
	for _, row in ipairs(gear().Adjust.Rows(class, spec, playerLevel())) do have[row.key] = true end
	local items = {}
	for _, key in ipairs(gear().STAT_KEYS) do
		if not have[key] then
			items[#items + 1] = { text = nameOf(key), onClick = function()
				-- Weighed at 1 to start: a line at its default (0) would not stay.
				gear().Adjust.Set(class, spec, key, 1, playerLevel())
			end }
		end
	end
	if #items > 0 and W.ShowMenu then W.ShowMenu(anchor, items, {}) end
end

local function specMenu(anchor)
	local class = playerClass()
	local meta = class and gear().CLASSES[class]
	if not (meta and W.ShowMenu) then return end
	local items = {}
	for _, s in ipairs(meta.specs) do
		local n = gear().Adjust.Count(class, s.key)
		items[#items + 1] = { text = n > 0 and (L["%s (adjusted)"]):format(L[s.label]) or L[s.label], checked = s.key == spec,
			onClick = function()
				spec = s.key
				setStatus("")
				relist()
			end }
	end
	W.ShowMenu(anchor, items, {})
end

-- A box being typed in whose line is about to show another stat: its number
-- goes to its own stat first (the client fires OnEditFocusLost on
-- ClearFocus; commit runs once either way). -> whether one did
local function settle(rows)
	for i, line in ipairs(lines) do
		local f = line.psFocus
		if f and line.Box:HasFocus() and (f.spec ~= spec or not rows[i] or rows[i].key ~= f.key) then
			line.Box:ClearFocus()
			if line.psFocus then line.psCommit() end
			return true
		end
	end
	return false
end

local listedSpec -- the spec the lines last showed: Revert stays armed while it is the same

function relist()
	if not (F and spec) then return end
	local G = gear()
	local class, lv = playerClass(), playerLevel()
	if settle(G.Adjust.Rows(class, spec, lv)) then return relist() end
	local n = G.Adjust.Count(class, spec)
	local label = specLabel(class, spec)
	W.SetButtonText(F.Spec, n > 0 and (L["%s (adjusted)"]):format(label) or label)
	local _, _, source = G.GetSpec()
	local hint = L["A change is kept as a share of the default, so it carries over when Polestar's defaults change."]
	if source == "custom" then
		hint = hint .. " " .. L["A custom scale is in use: these apply once you choose a built-in spec again."]
	end
	F.Hint:SetText(hint)
	local rows = G.Adjust.Rows(class, spec, lv)
	W.SetSection(F.ListH, L["Weights"], #rows)
	local width = F:GetWidth() - PAD * 2 - SCROLL_W
	local child = F.Scroll.Child
	child:SetWidth(width)
	local colW = floor((width - COL_GAP) / 2)
	for i, row in ipairs(rows) do
		local line = lines[i] or newLine(child)
		lines[i] = line
		line.psKey, line.psValue, line.psEdited = row.key, row.value, row.edited
		line:SetWidth(colW)
		-- The name keeps its room whether or not the stat is changed.
		line.Label:SetWidth(colW - DOT - DOT_GAP - BOX_W - RESET_W - 6 - 8)
		line.Label:SetText(nameOf(row.key))
		line.Dot:SetShown(row.edited)
		line.Reset:SetShown(row.edited)
		line.Reset.psTipLines = row.edited and { format(L["Default: %s"], valueText(row.default)) } or nil
		if not line.Box:HasFocus() then line.Box:SetText(valueText(row.value)) end
		line:ClearAllPoints()
		line:SetPoint("TOPLEFT", child, "TOPLEFT", ((i - 1) % 2) * (colW + COL_GAP), -(floor((i - 1) / 2) * LINE_H))
		line:Show()
	end
	for i = #rows + 1, #lines do lines[i]:Hide() end
	W.SetScrollContent(F.Scroll, math.ceil(#rows / 2) * LINE_H + 8)
	F.Revert:SetShown(n > 0)
	-- Armed by a first click: kept through a relist of the same spec (a bag
	-- update, GEAR_UPDATED), so the second click still reverts.
	if listedSpec ~= spec or n == 0 or not F.Revert.psArmed then
		F.Revert.psArmed = nil
		W.SetButtonText(F.Revert, L["Revert to default"])
	end
	listedSpec = spec
end

---------------------------------------------------------------------------
-- The window
---------------------------------------------------------------------------

local function close() F:Hide() end

local function build()
	F = CreateFrame("Frame", "PolestarAdjust", UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetSize(WIDTH, HEIGHT)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
	F:Hide()
	Theme.Skin(F, "window")

	local head = CreateFrame("Frame", nil, F)
	head:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	head:SetHeight(HEAD_H)
	head:EnableMouse(true)
	head:RegisterForDrag("LeftButton")
	head:SetScript("OnDragStart", function() F:StartMoving() end)
	head:SetScript("OnDragStop", function() F:StopMovingOrSizing() end)
	F.Band = Theme.Band(head, "BACKGROUND", -5)
	F.Band:SetAllPoints(head)
	F.Band:SetTexCoord(Theme.BandCoords(WIDTH - 2, HEAD_H))
	F.Close = W.IconButton(head, "close", 28, L["Close"], close, 14)
	F.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -14)
	F.Title = W.Text(head, "title", "text")
	F.Title:SetPoint("LEFT", head, "LEFT", PAD, 0)
	F.Title:SetPoint("RIGHT", F.Close, "LEFT", -8, 0)
	F.Title:SetJustifyH("LEFT")
	F.Title:SetWordWrap(false)
	F.Title:SetText(L["Adjust stat weights"])

	F.Spec = W.Button(F, "", function(self) specMenu(self) end, { height = 28 })
	F.Spec:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -(HEAD_H + 12))

	F.Hint = W.Text(F, "note", "textDim")
	F.Hint:SetPoint("TOPLEFT", F.Spec, "BOTTOMLEFT", 0, -8)
	F.Hint:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
	F.Hint:SetJustifyH("LEFT")
	F.Hint:SetWordWrap(true)
	F.Hint:SetHeight(44) -- up to three lines, so the list does not move

	F.ListH = W.SectionHeader(F)
	F.ListH:SetPoint("TOPLEFT", F.Hint, "BOTTOMLEFT", 0, -6)
	F.ListH:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)

	F.Add = W.Button(F, L["Add a stat"], function(self) addMenu(self) end, { ghost = true, height = 28 })
	F.Add:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", PAD, PAD)
	F.Revert = W.Button(F, L["Revert to default"], nil, { ghost = true, height = 28 })
	F.Revert:SetPoint("LEFT", F.Add, "RIGHT", 8, 0)
	F.Revert.psSetText = W.SetButtonText
	W.Confirm(F.Revert, L["Revert to default"], function()
		local n = gear().Adjust.Revert(playerClass(), spec)
		setStatus(n == 1 and L["Put back 1 weight."] or format(L["Put back %d weights."], n), "success")
	end)

	F.Status = W.Text(F, "note", "textDim")
	F.Status:SetPoint("BOTTOMLEFT", F.Add, "TOPLEFT", 0, 8)
	F.Status:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
	F.Status:SetJustifyH("LEFT")
	F.Status:SetWordWrap(false)
	F.Status:SetHeight(16)

	F.Scroll = W.Scroll(F)
	F.Scroll:SetPoint("TOPLEFT", F.ListH, "BOTTOMLEFT", 0, -4)
	F.Scroll:SetPoint("BOTTOMRIGHT", F.Status, "TOPRIGHT", 0, 8)

	F:SetScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.FAST, "out") end)
	ns.CloseOnEscape("PolestarAdjust")
	if ns.Gamepad and ns.Gamepad.Register then ns.Gamepad.Register(F, {}) end

	-- The lines follow the weights wherever they change (a level band, an edit).
	ns.On("GEAR_UPDATED", function() if F:IsShown() then relist() end end)
end

function UI.ShowAdjust(key)
	local class = playerClass()
	if not (class and gear().CLASSES[class]) then return end
	if not F then build() end
	spec = (key and gear().WEIGHTS[class][key]) and key or specInUse(class)
	setStatus("")
	relist()
	F:Show()
	F:Raise()
end

UI.AdjustView = setmetatable({ lines = lines }, { __index = function(_, k)
	if k == "frame" then return F end
	if k == "spec" then return spec end
end })
