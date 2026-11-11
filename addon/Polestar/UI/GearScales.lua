-- The window for the gear advice's custom stat weights (Gear/Pawn.lua): paste a
-- Pawn scale string to import it, and keep the scales of every class. One
-- window: the input panel on top (the paste box, or the name box while a scale
-- is renamed), then a row per scale with Use, Rename, Export, Delete and
-- Details: its weights, each a box to change, a menu to add a stat and a
-- remove button, a Reset to the string as imported, and the Pawn stats it left
-- out. "Copy a built-in spec" starts a scale from Polestar's own weights.
-- Export is UI.ShowCopy (UI/Copy.lua).
--
--   UI.ShowScales()        open the window
--   UI.ShowScaleImport()   open it with the cursor in the paste box
--   UI.ScalesView          what it shows, for the tests: { frame, rows }
--
-- Drag the grip in the bottom-right corner to resize it (never smaller than
-- MIN_W x MIN_H); the size is kept in PolestarDB.gearScalesWindow.
--
-- Built on first use; colours are Theme tokens only.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local format, max, floor = string.format, math.max, math.floor

local WIDTH = 560 -- the size it opens at the first time
local HEIGHT = 640
local MIN_W, MIN_H = 480, 460
local MAX_W, MAX_H = 1100, 1400
local PAD = 24
local HEAD_H = 56
local GRIP = 18
local INPUT_H = 80 -- the paste box's height: the room the input area keeps
local PASTE_LINES = 4
local ROW_H = 86
local LINE_H = 26 -- a weight's line in the details
local COL_GAP = 16
local SCROLL_W = 12 -- room for the scroll bar

local F
local restoredSize, saveSize
local mode = "import" -- "import" | "rename"
local renaming -- { class, id } while renaming
local rows = {}
local expanded = {} -- scale id -> its details are open

local function gear() return ns.Gear end

local function playerClass()
	return gear().GetPlayer().class
end

local function classLabel(class)
	local names = LOCALIZED_CLASS_NAMES_MALE
	return names and names[class] or (class:sub(1, 1) .. class:sub(2):lower())
end

local function field(parent, lines)
	local e = CreateFrame("EditBox", nil, parent)
	e:SetAutoFocus(false)
	Theme.Font(e, "label")
	W.Color(e, "text")
	if lines > 1 then
		e:SetMultiLine(true)
		e:SetHeight(lines * 16 + 16)
		e:SetTextInsets(10, 10, 8, 8)
	else
		e:SetHeight(30)
		e:SetTextInsets(10, 10, 0, 0)
	end
	e:SetMaxLetters(lines > 1 and 6000 or 40)
	Theme.Skin(e, "editbox")
	e:SetScript("OnEditFocusGained", function(self) Theme.SetFocused(self, true) end)
	e:SetScript("OnEditFocusLost", function(self) Theme.SetFocused(self, false) end)
	e:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	return e
end

local function setStatus(text, role)
	F.Status:SetText(text or "")
	W.Color(F.Status, role or "textDim")
end

---------------------------------------------------------------------------
-- What a scale says about itself
---------------------------------------------------------------------------

-- A stat in plain words (Pawn's names, in the exported string, are for Pawn).
local STAT_LABEL = {
	str = L["Strength"], agi = L["Agility"], sta = L["Stamina"], int = L["Intellect"], spi = L["Spirit"],
	armor = L["Armor"], health = L["Health"], mana = L["Mana"],
	ap = L["Attack power"], rap = L["Ranged attack power"],
	dps = L["Weapon DPS (melee)"], rdps = L["Weapon DPS (ranged)"],
	sp = L["Spell damage (all schools)"], heal = L["Healing"],
	spArcane = L["Arcane spell damage"], spFire = L["Fire spell damage"], spFrost = L["Frost spell damage"],
	spHoly = L["Holy spell damage"], spNature = L["Nature spell damage"], spShadow = L["Shadow spell damage"],
	crit = L["Melee and ranged crit (%)"], hit = L["Melee and ranged hit (%)"],
	spellCrit = L["Spell crit (%)"], spellHit = L["Spell hit (%)"],
	mp5 = L["Mana per 5 seconds"], hp5 = L["Health per 5 seconds"],
	defense = L["Defense skill"], dodge = L["Dodge (%)"], parry = L["Parry (%)"], block = L["Block (%)"],
	blockValue = L["Block value"],
}

local function nameOf(key) return STAT_LABEL[key] or gear().Pawn.NameOf(key) end

-- The weights of a scale as { { key, name, value }, ... } in the order of
-- Gear.STAT_KEYS (the main stats first, weapon DPS last).
local function weightList(scale)
	local list = {}
	for i, key in ipairs(gear().STAT_KEYS) do
		local value = scale.weights[key]
		if value ~= nil then list[#list + 1] = { key = key, name = nameOf(key), value = value } end
	end
	return list
end

local function valueText(v)
	return tostring(floor(v * 1000 + (v >= 0 and 0.5 or -0.5)) / 1000)
end

local function metaText(class, scale)
	local n = 0
	for _ in pairs(scale.weights) do n = n + 1 end
	local parts = { classLabel(class), format(L["%d weights"], n) }
	if scale.date and scale.date > 0 and date then parts[#parts + 1] = date("%Y-%m-%d", scale.date) end
	return table.concat(parts, "  \194\183  ")
end

---------------------------------------------------------------------------
-- The input panel
---------------------------------------------------------------------------

local function setMode(which)
	mode = which
	local importing = which == "import"
	F.Paste:SetShown(importing)
	F.Name:SetShown(not importing)
	F.Hint:SetText(importing and L["Paste a Pawn scale string (Ctrl+V). In Pawn, open a scale's Scale tab and use Share, Copy."]
		or format(L["A new name for %s."], renaming and renaming.name or ""))
	W.SetButtonText(F.Ok, importing and L["Import"] or L["Save"])
	W.SetButtonText(F.Cancel, importing and L["Clear"] or L["Cancel"])

end

local relist

local function doImport()
	local G = gear()
	local class = playerClass()
	local ok, res = G.Scales.Import(F.Paste:GetText(), class)
	if not ok then
		setStatus(G.Scales.ErrorText(res), "warning")
		return
	end
	local text = G.Scales.Summary(res)
	if res.class == class then
		ns.Set("gear.spec." .. class, "custom:" .. res.scale.id)
	else
		text = (L["%s. Saved for %s: it applies on a character of that class."]):format(text, classLabel(res.class))
	end
	F.Paste:SetText("")
	F.Paste:ClearFocus()
	setStatus(text, "success")
	relist()
end

local function doRename()
	if not renaming then return end
	local ok, err = gear().Scales.Rename(renaming.class, renaming.id, F.Name:GetText())
	if ok then
		renaming = nil
		setStatus("")
		setMode("import")
		relist()
	else
		setStatus(gear().Scales.ErrorText(err), "warning")
	end
end

local function onOk()
	if mode == "import" then doImport() else doRename() end
end

local function onCancel()
	if mode == "import" then
		F.Paste:SetText("")
		setStatus("")
	else
		renaming = nil
		setStatus("")
		setMode("import")
	end
end

---------------------------------------------------------------------------
-- The list
---------------------------------------------------------------------------

-- A weight's line: its Pawn name, a box for the value, a remove button.
local function newLine(row)
	local line = CreateFrame("Frame", nil, row)
	line:SetHeight(LINE_H)
	line.Label = W.Text(line, "small", "text")
	line.Label:SetPoint("LEFT", line, "LEFT", 0, 0)
	line.Label:SetJustifyH("LEFT")
	line.Label:SetWordWrap(false)
	line.Remove = W.IconButton(line, "close", 18, L["Remove"], function()
		gear().Scales.RemoveWeight(row.psClass, row.psId, line.psKey)
	end, 10)
	line.Remove:SetPoint("RIGHT", line, "RIGHT", 0, 0)
	local e = CreateFrame("EditBox", nil, line)
	e:SetAutoFocus(false)
	Theme.Font(e, "label")
	W.Color(e, "text")
	e:SetSize(64, 22)
	e:SetTextInsets(6, 6, 0, 0)
	e:SetMaxLetters(12)
	Theme.Skin(e, "editbox")
	e:SetPoint("RIGHT", line.Remove, "LEFT", -6, 0)
	local function commit()
		local n = gear().Pawn.Number(e:GetText())
		if n == nil then
			e:SetText(valueText(line.psValue or 0))
		elseif n ~= line.psValue then
			gear().Scales.SetWeight(row.psClass, row.psId, line.psKey, n)
		end
	end
	e:SetScript("OnEditFocusGained", function(self) Theme.SetFocused(self, true) end)
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

-- The stats this scale has no weight for, in a menu.
local function addMenu(row, anchor)
	local scale = gear().Scales.Get(row.psClass, row.psId)
	if not scale then return end
	local items = {}
	for _, key in ipairs(gear().STAT_KEYS) do
		if scale.weights[key] == nil then
			items[#items + 1] = { text = nameOf(key), onClick = function()
				gear().Scales.SetWeight(row.psClass, row.psId, key, 0)
			end }
		end
	end
	if #items > 0 and W.ShowMenu then W.ShowMenu(anchor, items, {}) end
end

local function newRow(parent)
	local row = CreateFrame("Frame", nil, parent)
	row.Rule = W.Divider(row, false, 0.6)
	row.Rule:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 0)
	row.Rule:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
	row.Title = W.Text(row, "body", "text")
	row.Title:SetPoint("TOPLEFT", row, "TOPLEFT", 0, -10)
	row.Title:SetJustifyH("LEFT")
	row.Title:SetWordWrap(false)
	row.Tag = W.Text(row, "small", "success")
	row.Tag:SetPoint("TOPRIGHT", row, "TOPRIGHT", 0, -12)
	row.Meta = W.Text(row, "small", "textDim")
	row.Meta:SetPoint("TOPLEFT", row, "TOPLEFT", 0, -32)
	row.Meta:SetJustifyH("LEFT")
	row.Meta:SetWordWrap(false)
	row.Use = W.Button(row, L["Use"], nil, { ghost = true, height = 24 })
	row.Rename = W.Button(row, L["Rename"], nil, { ghost = true, height = 24 })
	row.Export = W.Button(row, L["Export"], nil, { ghost = true, height = 24 })
	row.Delete = W.Button(row, L["Delete"], nil, { ghost = true, height = 24 })
	row.Details = W.Button(row, L["Details"], nil, { ghost = true, height = 24 })
	row.Use:SetPoint("TOPLEFT", row, "TOPLEFT", 0, -54)
	row.Rename:SetPoint("LEFT", row.Use, "RIGHT", 6, 0)
	row.Export:SetPoint("LEFT", row.Rename, "RIGHT", 6, 0)
	row.Delete:SetPoint("LEFT", row.Export, "RIGHT", 6, 0)
	row.Details:SetPoint("TOPRIGHT", row, "TOPRIGHT", 0, -54)
	row.Lines = {}
	row.Add = W.Button(row, L["Add a stat"], nil, { ghost = true, height = 24 })
	row.Reset = W.Button(row, L["Reset to imported"], nil, { ghost = true, height = 24 })
	row.Add:SetScript("OnClick", function(self) addMenu(row, self) end)
	row.Reset:SetScript("OnClick", function() gear().Scales.Reset(row.psClass, row.psId) end)
	row.Body = W.Text(row, "small", "textDim")
	row.Body:SetJustifyH("LEFT")
	row.Body:SetWordWrap(true)
	row.Use:SetScript("OnClick", function()
		local key = "gear.spec." .. row.psClass
		if row.psActive then ns.Set(key, nil) else ns.Set(key, "custom:" .. row.psId) end
	end)
	row.Rename:SetScript("OnClick", function()
		renaming = { class = row.psClass, id = row.psId, name = row.Title:GetText() }
		setStatus("")
		setMode("rename")
		F.Name:SetText(row.Title:GetText())
		F.Name:SetFocus()
		F.Name:HighlightText()
	end)
	row.Export:SetScript("OnClick", function()
		local text = gear().Scales.Export(row.psClass, row.psId)
		if text and UI.ShowCopy then
			UI.ShowCopy(row.Title:GetText(), text, { hint = L["Selected for you: copy it with Ctrl+C (Cmd+C on a Mac), then paste it into Pawn's import box or share it."] })
		end
	end)
	row.Delete.psSetText = W.SetButtonText
	W.Confirm(row.Delete, L["Delete"], function()
		gear().Scales.Delete(row.psClass, row.psId)
	end)
	row.Details:SetScript("OnClick", function()
		expanded[row.psId] = not expanded[row.psId] or nil
		relist()
	end)
	return row
end

function relist()
	if not F then return end
	local G = gear()
	local mine = playerClass()
	local chosen = mine and G.Scales.Chosen(mine)
	local all = G.Scales.All(mine)
	W.SetSection(F.ListH, L["Your scales"], #all)
	F.None:SetShown(#all == 0)
	local width = F:GetWidth() - PAD * 2 - SCROLL_W
	local child = F.Scroll.Child
	child:SetWidth(width)
	local y = 0
	for i, item in ipairs(all) do
		local row = rows[i] or newRow(child)
		rows[i] = row
		local scale = item.scale
		row.psClass, row.psId = item.class, scale.id
		row.psActive = item.class == mine and chosen == scale
		row:SetWidth(width)
		row.Title:SetWidth(width - 90)
		row.Title:SetText(scale.name)
		row.Meta:SetWidth(width)
		row.Meta:SetText(metaText(item.class, scale))
		row.Tag:SetText(row.psActive and L["In use"] or "")
		row.Use:SetShown(item.class == mine)
		W.SetButtonText(row.Use, row.psActive and L["Stop using"] or L["Use"])
		W.SetButtonText(row.Details, expanded[scale.id] and L["Hide details"] or L["Details"])
		local h = ROW_H
		local open = expanded[scale.id] or false
		row.Body:SetShown(open)
		row.Add:SetShown(open)
		row.Reset:SetShown(open and scale.edited or false)
		local list = open and weightList(scale) or {}
		local colW = floor((width - COL_GAP) / 2)
		for n, w in ipairs(list) do
			local line = row.Lines[n] or newLine(row)
			row.Lines[n] = line
			line.psKey, line.psValue = w.key, w.value
			line:SetWidth(colW)
			line.Label:SetWidth(colW - 64 - 18 - 12)
			line.Label:SetText(w.name)
			if not line.Box:HasFocus() then line.Box:SetText(valueText(w.value)) end
			line:ClearAllPoints()
			line:SetPoint("TOPLEFT", row, "TOPLEFT", ((n - 1) % 2) * (colW + COL_GAP), -(ROW_H + floor((n - 1) / 2) * LINE_H))
			line:Show()
		end
		for n = #list + 1, #row.Lines do row.Lines[n]:Hide() end
		if open then
			local y = ROW_H + math.ceil(#list / 2) * LINE_H + 6
			row.Add:ClearAllPoints()
			row.Add:SetPoint("TOPLEFT", row, "TOPLEFT", 0, -y)
			row.Reset:ClearAllPoints()
			row.Reset:SetPoint("LEFT", row.Add, "RIGHT", 6, 0)
			y = y + 30
			local note = {}
			if scale.edited then note[#note + 1] = L["Edited: Export gives these weights."] end
			if scale.ignored and #scale.ignored > 0 then note[#note + 1] = L["Ignored"] .. ": " .. table.concat(scale.ignored, ", ") end
			row.Body:SetWidth(width)
			row.Body:SetText(table.concat(note, "\n"))
			row.Body:ClearAllPoints()
			row.Body:SetPoint("TOPLEFT", row, "TOPLEFT", 0, -y)
			h = y + (#note > 0 and row.Body:GetStringHeight() or 0) + 12
		end
		row:SetHeight(h)
		row:ClearAllPoints()
		row:SetPoint("TOPLEFT", child, "TOPLEFT", 0, -y)
		row:Show()
		y = y + h
	end
	for i = #all + 1, #rows do rows[i]:Hide() end
	W.SetScrollContent(F.Scroll, y + 8)
end

---------------------------------------------------------------------------
-- The window
---------------------------------------------------------------------------

local function close() F:Hide() end

local function clamp(v, lo, hi)
	return math.max(lo, math.min(hi, v))
end

-- The size the window opens at: the one it was left at, else the default, kept
-- inside the limits and the screen.
function restoredSize()
	local saved = ns.DB().gearScalesWindow
	local w, h = WIDTH, HEIGHT
	if type(saved) == "table" and tonumber(saved.w) and tonumber(saved.h) then w, h = saved.w, saved.h end
	local sw, sh = UIParent:GetWidth(), UIParent:GetHeight()
	local maxW, maxH = MAX_W, MAX_H
	if sw and sw > 0 then maxW = math.min(maxW, floor(sw - 20)) end
	if sh and sh > 0 then maxH = math.min(maxH, floor(sh - 20)) end
	return clamp(floor(w), MIN_W, max(MIN_W, maxW)), clamp(floor(h), MIN_H, max(MIN_H, maxH))
end

function saveSize()
	if not F then return end
	ns.DB().gearScalesWindow = { w = floor(F:GetWidth() + 0.5), h = floor(F:GetHeight() + 0.5) }
end

local function build()
	F = CreateFrame("Frame", "PolestarScales", ns.UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetSize(restoredSize())
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
	F:SetResizable(true)
	if F.SetResizeBounds then F:SetResizeBounds(MIN_W, MIN_H, MAX_W, MAX_H) end
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
	F.Band:SetTexCoord(Theme.BandCoords(F:GetWidth() - 2, HEAD_H))
	F.Close = W.IconButton(head, "close", 28, L["Close"], close, 14)
	F.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -14)
	F.Title = W.Text(head, "title", "text")
	F.Title:SetPoint("LEFT", head, "LEFT", PAD, 0)
	F.Title:SetPoint("RIGHT", F.Close, "LEFT", -8, 0)
	F.Title:SetJustifyH("LEFT")
	F.Title:SetWordWrap(false)
	F.Title:SetText(L["Custom stat weights"])

	F.Hint = W.Text(F, "note", "textDim")
	F.Hint:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -(HEAD_H + 12))
	F.Hint:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
	F.Hint:SetJustifyH("LEFT")
	F.Hint:SetWordWrap(true)
	F.Hint:SetHeight(32) -- two lines, so the rest does not move as the window narrows

	-- The input area keeps the paste box's height in both modes, so the list
	-- does not jump when a scale is renamed.
	F.Input = CreateFrame("Frame", nil, F)
	F.Input:SetPoint("TOPLEFT", F.Hint, "BOTTOMLEFT", 0, -8)
	F.Input:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
	F.Input:SetHeight(INPUT_H)
	F.Paste = field(F.Input, PASTE_LINES)
	F.Paste:SetPoint("TOPLEFT", F.Input, "TOPLEFT", 0, 0)
	F.Paste:SetPoint("RIGHT", F.Input, "RIGHT", 0, 0)
	F.Name = field(F.Input, 1)
	F.Name:SetPoint("TOPLEFT", F.Input, "TOPLEFT", 0, 0)
	F.Name:SetPoint("RIGHT", F.Input, "RIGHT", 0, 0)
	F.Name:SetScript("OnEnterPressed", function() doRename() end)

	F.Status = W.Text(F, "note", "textDim")
	F.Status:SetPoint("TOPLEFT", F.Input, "BOTTOMLEFT", 0, -8)
	F.Status:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
	F.Status:SetJustifyH("LEFT")
	F.Status:SetWordWrap(true)
	F.Status:SetHeight(56) -- up to four lines: the list does not jump when it fills

	F.Ok = W.Button(F, L["Import"], onOk, { primary = true, height = 28 })
	F.Cancel = W.Button(F, L["Clear"], onCancel, { height = 28 })
	F.Ok:SetPoint("TOPLEFT", F.Status, "BOTTOMLEFT", 0, -6)
	F.Cancel:SetPoint("LEFT", F.Ok, "RIGHT", 8, 0)
	F.Copy = W.Button(F, L["Copy a built-in spec"], function(self)
		local class = playerClass()
		local meta = class and gear().CLASSES[class]
		if not (meta and W.ShowMenu) then return end
		local items = {}
		for _, spec in ipairs(meta.specs) do
			items[#items + 1] = { text = L[spec.label], onClick = function()
				local ok, res = gear().Scales.CopyBuiltin(class, spec.key)
				if ok then
					expanded[res.scale.id] = true
					setStatus((L["Copied %s. Change its weights below."]):format(res.scale.name), "success")
					relist()
				else
					setStatus(gear().Scales.ErrorText(res), "warning")
				end
			end }
		end
		W.ShowMenu(self, items, {})
	end, { height = 28 })
	F.Copy:SetPoint("LEFT", F.Cancel, "RIGHT", 8, 0)

	F.ListH = W.SectionHeader(F)
	F.ListH:SetPoint("TOPLEFT", F.Ok, "BOTTOMLEFT", 0, -10)
	F.ListH:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
	F.None = W.Text(F, "note", "textMuted")
	F.None:SetPoint("TOPLEFT", F.ListH, "BOTTOMLEFT", 0, -6)
	F.None:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
	F.None:SetJustifyH("LEFT")
	F.None:SetText(L["No custom scales yet. Paste a Pawn string above."])

	F.Scroll = W.Scroll(F)
	F.Scroll:SetPoint("TOPLEFT", F.ListH, "BOTTOMLEFT", 0, -4)
	F.Scroll:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -PAD, GRIP + 4)

	-- The grip: drag to resize. The window is re-anchored by its top-left
	-- corner first, so the corner opposite the grip stays where it is.
	local grip = CreateFrame("Button", nil, F)
	grip:SetSize(GRIP, GRIP)
	grip:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -4, 4)
	local gr, gg, gb = Theme.Color("textMuted")
	for i = 1, 3 do
		local dot = grip:CreateTexture(nil, "OVERLAY")
		dot:SetSize(3, 3)
		dot:SetColorTexture(gr or 0.6, gg or 0.6, gb or 0.6, 0.9)
		dot:SetPoint("BOTTOMRIGHT", grip, "BOTTOMRIGHT", -2, 2 + (i - 1) * 5)
		if i > 1 then
			local dot2 = grip:CreateTexture(nil, "OVERLAY")
			dot2:SetSize(3, 3)
			dot2:SetColorTexture(gr or 0.6, gg or 0.6, gb or 0.6, 0.9)
			dot2:SetPoint("BOTTOMRIGHT", grip, "BOTTOMRIGHT", -2 - (i - 1) * 5, 2)
		end
	end
	grip:SetScript("OnMouseDown", function()
		local left, top = F:GetLeft(), F:GetTop()
		if left and top and top > 0 then
			F:ClearAllPoints()
			F:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
		end
		F:StartSizing("BOTTOMRIGHT")
	end)
	grip:SetScript("OnMouseUp", function()
		F:StopMovingOrSizing()
		saveSize()
	end)
	F.Grip = grip
	F:SetScript("OnSizeChanged", function(self, w)
		if w then F.Band:SetTexCoord(Theme.BandCoords(w - 2, HEAD_H)) end
		relist()
	end)

	F:SetScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.FAST, "out") end)
	ns.CloseOnEscape("PolestarScales")
	if ns.Gamepad and ns.Gamepad.Register then ns.Gamepad.Register(F, {}) end

	-- The list follows the scales and the chosen one, wherever they change.
	ns.On("GEAR_UPDATED", function() if F:IsShown() then relist() end end)
	ns.On("SETTING_CHANGED", function(path)
		if F:IsShown() and type(path) == "string" and path:sub(1, 9) == "gear.spec" then relist() end
	end)
end

function UI.ShowScales()
	if not F then build() end
	renaming = nil
	setStatus("")
	setMode("import")
	relist()
	F:Show()
	F:Raise()
end

function UI.ShowScaleImport()
	UI.ShowScales()
	F.Paste:SetFocus()
end

UI.ScalesView = setmetatable({ rows = rows }, { __index = function(_, k) if k == "frame" then return F end end })
