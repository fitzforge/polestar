-- The Profiles page of the settings window (key `profiles`, Setup): the
-- profile in use and whose choice it is (this character's, its class's or
-- the account's), every profile with Use, Copy, Rename and Delete, a new
-- one, and profile strings: Export (the look, guiding and positions, each
-- ticked or not) and Import (what the string holds and what it changes, then
-- a new profile or into the one in use). The work is Core/Profiles.lua's.
-- Built when the page is first shown; laid out again on PROFILES_CHANGED
-- only while it is on screen.

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local SH = W.SHELL
local format, floor, max, min, ipairs, pairs = string.format, math.floor, math.max, math.min, ipairs, pairs

local PV = {}
UI.Profiles = PV

local DOT = "  \194\183  "
local ROW_H = 48
local SHOWN_CHANGES = 8 -- settings named in an import's preview; the rest counted

local function Profiles() return ns.Profiles end

local view
-- The name editor under the list: { mode = "new" | "copy" | "rename", subject = name }, or nil.
local editor
local editorError
-- Export: which parts go in, and the string made (nil until asked).
local exportAreas = { look = true, guiding = true, positions = true }
local exported, exportedCount
-- Import: the pasted string's preview or why it was refused, the parts
-- ticked, and the line left by the last import.
local preview, refusal, importDone, importError
local importAreas = { look = true, guiding = true, positions = true }

local function bodyWidth()
	local win = UI.Options and UI.Options.frame
	return win and win.BodyWidth or 640
end

local function relayout()
	if not (view and view.Refresh) then return end
	local h = view.Refresh()
	view:SetHeight(h)
	local win = UI.Options and UI.Options.frame
	if win and view:IsShown() then W.ShellBody(win, h) end
end
PV.Relayout = relayout

local function text(parent, role, color)
	local fs = W.Text(parent, role, color)
	fs:SetWordWrap(true)
	fs:SetJustifyH("LEFT")
	fs:SetJustifyV("TOP")
	return fs
end

local function count(n, one, many) return n == 1 and one or many:format(n) end

-- An edit box in the search field's well: typed text, Enter acts.
local function field(parent, onEnter, onChange)
	local e = CreateFrame("EditBox", nil, parent)
	e:SetAutoFocus(false)
	e:SetHeight(30)
	e:SetTextInsets(10, 10, 0, 0)
	e:SetMaxBytes(Profiles() and Profiles().LIMITS.name + 1 or 49)
	Theme.Font(e, "label")
	W.Color(e, "text")
	Theme.Skin(e, "editbox")
	e:SetScript("OnEditFocusGained", function(self) Theme.SetFocused(self, true) end)
	e:SetScript("OnEditFocusLost", function(self) Theme.SetFocused(self, false) end)
	e:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	e:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
		if onEnter then onEnter() end
	end)
	if onChange then e:SetScript("OnTextChanged", function(self, userInput) if userInput then onChange(self:GetText()) end end) end
	return e
end

---------------------------------------------------------------------------
-- Actions
---------------------------------------------------------------------------

function PV.Use(name)
	editor = nil
	Profiles().Switch(name)
	relayout()
end

-- Open the name editor: "new", "copy" (of subject) or "rename" (subject).
function PV.Edit(mode, subject)
	editor = { mode = mode, subject = subject }
	editorError = nil
	local P = Profiles()
	local name = ""
	if mode == "copy" then
		name = P.FreeName((L["%s (copy)"]):format(subject == P.DEFAULT and L["Default"] or subject)) or ""
	elseif mode == "rename" then
		name = subject
	end
	if view and view.NameBox then view.NameBox:SetText(name) end
	relayout()
	if view and view.NameBox then
		view.NameBox:SetFocus()
		view.NameBox:HighlightText()
	end
end

function PV.CancelEdit()
	editor, editorError = nil, nil
	if view and view.NameBox then view.NameBox:ClearFocus() end
	relayout()
end

-- The editor's action: New and Copy make the profile and switch to it.
function PV.CommitEdit(name)
	if not editor then return end
	local P = Profiles()
	name = name or (view and view.NameBox:GetText()) or ""
	local ok, why
	if editor.mode == "rename" then
		ok, why = P.Rename(editor.subject, name)
	else
		local made
		made, why = P.New(name, editor.mode == "copy" and editor.subject or nil)
		if made then ok = P.Switch(made) end
	end
	if ok then
		editor, editorError = nil, nil
		if view and view.NameBox then view.NameBox:ClearFocus() end
	else
		editorError = why
	end
	relayout()
end

function PV.Delete(name)
	local P = Profiles()
	W.Modal({ title = L["Delete this profile?"], icon = "close", danger = true, action = L["Delete"],
		text = (L["The profile %s and every setting in it are deleted. Characters that use it go back to the account's profile."]):format(P.Label(name)),
		onAccept = function()
			P.Delete(name)
			relayout()
		end })
end

function PV.Export()
	local s, n = Profiles().Export(nil, { areas = exportAreas })
	exported, exportedCount = s, n
	if view and view.CopyBox then
		W.SetCopyText(view.CopyBox, s or "")
	end
	relayout()
	if view and view.CopyBox and s then
		view.CopyBox:SetFocus()
		view.CopyBox:HighlightText()
	end
end

function PV.Check(value)
	importDone, importError = nil, nil
	if (value or ""):gsub("%s+", "") == "" then
		preview, refusal = nil, nil
	else
		preview, refusal = Profiles().Import(value)
		if preview then
			importAreas = { look = preview.areas.look > 0, guiding = preview.areas.guiding > 0, positions = preview.areas.positions > 0 }
			if view and view.ImportName then view.ImportName:SetText(Profiles().FreeName(preview.name) or "") end
		end
	end
	relayout()
end

function PV.ClearImport()
	preview, refusal, importError = nil, nil, nil
	if view and view.PasteBox then view.PasteBox:SetText("") end
	relayout()
end

local function finishImport(line)
	preview, refusal, importError = nil, nil, nil
	importDone = line
	if view and view.PasteBox then view.PasteBox:SetText("") end
	relayout()
end

-- As a new profile, named in the box under the preview, and switched to.
function PV.ImportNew(name)
	if not preview then return end
	local P = Profiles()
	name = name or (view and view.ImportName:GetText()) or ""
	local clean, why = P.CleanName(name)
	if not clean then
		importError = why
		relayout()
		return
	end
	local ok
	ok, why = P.Apply(preview, clean, importAreas)
	if not ok then
		importError = why
		relayout()
		return
	end
	P.Switch(clean)
	finishImport((L["Imported as %s, now in use."]):format(P.Label(clean)))
end

-- Into the profile in use, after the dialog.
function PV.ImportHere()
	if not preview then return end
	local P = Profiles()
	local n = 0
	for _, path in ipairs(preview.changes) do
		if importAreas[preview.area[path]] then n = n + 1 end
	end
	W.Modal({ title = L["Apply to the profile in use?"], icon = "check", action = L["Apply"],
		text = (L["%s changes to the string's values: %s. Your other settings stay as they are."]):format(P.Label(P.Active()),
			count(n, L["1 setting"], L["%d settings"])),
		onAccept = function()
			if not preview then return end
			local ok, why = P.Apply(preview, P.Active(), importAreas)
			if ok then
				finishImport((L["Applied to %s."]):format(P.Label(P.Active())))
			else
				importError = why
				relayout()
			end
		end })
end

---------------------------------------------------------------------------
-- Building
---------------------------------------------------------------------------

-- An edit box lays out its whole text, which freezes the game for a long
-- string: the box holds little; a paste's characters come one by one in the
-- same frame (OnChar) and are joined on the next (as the Import page).
local PASTE_BOX_BYTES = 2500
local PASTE_MIN = 20

local function pasteBox(parent)
	local e = CreateFrame("EditBox", nil, parent)
	e:SetAutoFocus(false)
	e:SetMaxLetters(0)
	e:SetMaxBytes(PASTE_BOX_BYTES)
	local parts, n, at = {}, 0, nil
	e:SetScript("OnChar", function(self, c)
		local now = GetTime()
		if now ~= at then
			at, parts, n = now, {}, 0
			self:SetScript("OnUpdate", ns.Safe(function(box)
				box:SetScript("OnUpdate", nil)
				if n < PASTE_MIN then
					PV.Check(box:GetText())
					return
				end
				local pasted = table.concat(parts, "", 1, n)
				parts, n = {}, 0
				box:SetText(format("%s\226\128\166 (%d KB)", pasted:gsub("%s", ""):sub(1, 40), math.ceil(#pasted / 1024)))
				box:ClearFocus()
				PV.Check(pasted)
			end))
		end
		n = n + 1
		parts[n] = c
	end)
	Theme.Font(e, "label")
	W.Color(e, "text")
	e:SetHeight(30)
	e:SetTextInsets(10, 10, 0, 0)
	Theme.Skin(e, "editbox")
	e.Hint = W.Text(e, "label", "textMuted")
	e.Hint:SetPoint("LEFT", e, "LEFT", 10, 0)
	e.Hint:SetPoint("RIGHT", e, "RIGHT", -10, 0)
	e.Hint:SetText(L["Paste a profile string here (Ctrl+V)"])
	e:SetScript("OnEditFocusGained", function(self) Theme.SetFocused(self, true) end)
	e:SetScript("OnEditFocusLost", function(self) Theme.SetFocused(self, false) end)
	e:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	e:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
	e:SetScript("OnTextChanged", function(self, userInput)
		self.Hint:SetShown(self:GetText() == "")
		if userInput and at ~= GetTime() then PV.Check(self:GetText()) end
	end)
	return e
end

-- A row of the profile list: the name, an "In use" chip, and its actions.
local function newRow(parent)
	local row = CreateFrame("Frame", nil, parent)
	row:SetHeight(ROW_H)
	row.Rule = W.Divider(row, false, 0.6)
	row.Rule:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 0)
	row.Rule:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
	row.Name = W.Text(row, "body", "rowLabel")
	row.Name:SetPoint("LEFT", row, "LEFT", 12, 0)
	row.Chip = W.Chip(row)
	row.Chip:SetPoint("LEFT", row.Name, "RIGHT", 10, 0)
	local function act(label, fn, opts)
		local b = W.Button(row, label, function() if row.psName then fn(row.psName) end end, opts)
		return b
	end
	row.Delete = act(L["Delete"], PV.Delete, { ghost = true, danger = true, height = 24 })
	row.Rename = act(L["Rename"], function(name) PV.Edit("rename", name) end, { ghost = true, height = 24 })
	row.Copy = act(L["Copy"], function(name) PV.Edit("copy", name) end, { ghost = true, height = 24 })
	row.Use = act(L["Use"], PV.Use, { height = 24 })
	return row
end

-- A switch row (W.Toggle) for state that is no setting.
local function switchRow(parent, label, help, get, set)
	local row = W.Toggle(parent, label, nil, help, nil, { get = get, set = function(v)
		set(v)
		relayout()
	end })
	W.RowDetails(row, { marks = false })
	return row
end

local AREA_LABEL = { look = L["Look"], guiding = L["Guiding"], positions = L["Positions"] }
local AREA_HELP = {
	look = L["Everything on the Look pages: theme, colours, fonts, sizes, the arrow, map pins, lines, buttons and alerts."],
	guiding = L["What Polestar does and shows: the Guide, Map, Questing, Discovery and Quality of Life pages."],
	positions = L["Where you dragged the guide window, the arrow, the alerts and the panels. Another screen may need them moved again."],
}

function PV.Build(v)
	view = v
	PV.view = v
	local P = Profiles()
	v.InUseH = W.SectionHeader(v, { plain = true })
	W.SetSection(v.InUseH, L["In use"])
	v.InUsePanel = W.RowPanel(v)
	v.InUse = W.InfoRow(v, L["Profile in use"])
	W.RowDetails(v.InUse, { marks = false })
	v.ForChar = switchRow(v, L["Use a profile for this character only"],
		L["This character keeps its own choice of profile. Off: it follows its class's profile, else the account's."],
		function() return P.ForCharacter() end, function(on) P.UseForCharacter(on) end)
	v.ForClass = switchRow(v, L["Use this profile for the whole class"],
		L["Every character of this class uses the profile in use, unless one has its own."],
		function() return P.ClassProfile() ~= nil end, function(on) P.UseForClass(on) end)

	v.ListH = W.SectionHeader(v, { plain = true })
	v.ListPanel = W.RowPanel(v)
	v.Rows = {}
	v.NewButton = W.Button(v, L["New profile"], function() PV.Edit("new") end, { icon = "plus", height = 28 })
	v.NameLabel = W.Text(v, "label", "text")
	v.NameBox = field(v, function() PV.CommitEdit() end)
	v.NameOK = W.Button(v, "", function() PV.CommitEdit() end, { primary = true, height = 28 })
	v.NameCancel = W.Button(v, L["Cancel"], function() PV.CancelEdit() end, { height = 28 })
	v.NameError = text(v, "note", "warning")

	v.ExportH = W.SectionHeader(v, { plain = true })
	W.SetSection(v.ExportH, L["Share a profile"])
	v.ExportPanel = W.RowPanel(v)
	v.ExportAreas = {}
	for _, area in ipairs(P.AREAS) do
		v.ExportAreas[area] = switchRow(v, AREA_LABEL[area], AREA_HELP[area],
			function() return exportAreas[area] end,
			function(on)
				exportAreas[area] = on and true or false
				if exported then PV.Export() end
			end)
	end
	v.ExportNote = text(v, "note", "textDim")
	v.ExportButton = W.Button(v, L["Make a profile string"], function() PV.Export() end, { primary = true, height = 28 })
	v.CopyBox = W.CopyBox(v, { lines = 4 })
	v.CopyNote = text(v, "note", "textDim")

	v.ImportH = W.SectionHeader(v, { plain = true })
	W.SetSection(v.ImportH, L["Import a profile"])
	v.PasteBox = pasteBox(v)
	v.Preview = text(v, "body", "text")
	v.Changes = text(v, "note", "textDim")
	v.ImportPanel = W.RowPanel(v)
	v.ImportAreas = {}
	for _, area in ipairs(P.AREAS) do
		v.ImportAreas[area] = switchRow(v, AREA_LABEL[area], AREA_HELP[area],
			function() return importAreas[area] end,
			function(on) importAreas[area] = on and true or false end)
	end
	v.Screen = text(v, "note", "warning")
	v.Dropped = text(v, "note", "warning")
	v.Refusal = text(v, "note", "warning")
	v.ImportNameLabel = W.Text(v, "label", "text")
	v.ImportNameLabel:SetText(L["Name"])
	v.ImportName = field(v, function() PV.ImportNew() end)
	v.ImportNew = W.Button(v, L["Import as a new profile"], function() PV.ImportNew() end, { primary = true, height = 28 })
	v.ImportHere = W.Button(v, L["Apply to the profile in use"], function() PV.ImportHere() end, { height = 28 })
	v.ImportCancel = W.Button(v, L["Cancel"], function() PV.ClearImport() end, { height = 28 })
	v.ImportError = text(v, "note", "warning")
	v.ImportDone = text(v, "note", "success")

	v.Refresh = PV.Layout
	v:HookScript("OnShow", function() if v.psDirty then v.psDirty = nil; relayout() end end)
end

---------------------------------------------------------------------------
-- Layout
---------------------------------------------------------------------------

local function place(region, x, y)
	region:ClearAllPoints()
	region:SetPoint("TOPLEFT", view, "TOPLEFT", x, -y)
end

local function block(fs, s, width, x, y, gap)
	fs:SetShown(s ~= nil)
	if not s then return y end
	fs:SetText(s)
	fs:SetWidth(width)
	place(fs, x, y)
	return y + fs:GetStringHeight() + (gap or 8)
end

local function header(h, x, y, width)
	h:SetWidth(width)
	place(h, x, y)
	return y + W.PLAIN_SECTION_H
end

-- Rows in a panel; -> y under them.
local function rows(panel, list, x, y, width)
	local top = y
	for _, row in ipairs(list) do
		if row:IsShown() then
			local h = W.LayoutRow(row, width)
			if row.Refresh then row:Refresh() end
			place(row, x, y)
			y = y + h
		end
	end
	panel:ClearAllPoints()
	panel:SetPoint("TOPLEFT", view, "TOPLEFT", x, -top)
	panel:SetSize(width, max(1, y - top))
	panel:SetShown(y > top)
	return y
end

local function sourceLine(P)
	local source = P.Source()
	if source == "character" then return L["Only this character uses it."] end
	if source == "class" then return (L["Every %s uses it (the class's profile)."]):format(P.ClassName() or "") end
	return L["Every character on this account uses it, unless one has its own."]
end

local function layoutList(P, x, y, width)
	local names = P.List()
	W.SetSection(view.ListH, L["Profiles"], #names)
	y = header(view.ListH, x, y, width)
	local active = P.Active()
	local top = y
	for i, name in ipairs(names) do
		local row = view.Rows[i] or newRow(view)
		view.Rows[i] = row
		row.psName = name
		row:SetWidth(width)
		row.Name:SetText(P.Label(name))
		local using = name == active
		if using then W.SetChip(row.Chip, L["In use"], "accent") else row.Chip:Hide() end
		W.Color(row.Name, using and "text" or "rowLabel")
		-- Right to left: Delete, Rename, Copy, Use, each shown where it applies.
		local fixed = name == P.DEFAULT
		row.Delete:SetShown(not fixed and not using)
		row.Rename:SetShown(not fixed)
		row.Use:SetShown(not using)
		local right = -12
		for _, b in ipairs({ row.Delete, row.Rename, row.Copy, row.Use }) do
			if b:IsShown() then
				b:ClearAllPoints()
				b:SetPoint("RIGHT", row, "RIGHT", right, 0)
				right = right - b:GetWidth() - 6
			end
		end
		row.Name:SetWidth(max(40, min(row.Name:GetStringWidth() + 2, width + right - 12 - 100)))
		place(row, x, y)
		row:Show()
		y = y + ROW_H
	end
	for i = #names + 1, #view.Rows do view.Rows[i]:Hide() end
	view.ListPanel:ClearAllPoints()
	view.ListPanel:SetPoint("TOPLEFT", view, "TOPLEFT", x, -top)
	view.ListPanel:SetSize(width, y - top)
	y = y + 12

	-- The name editor, or New profile.
	local editing = editor ~= nil
	view.NewButton:SetShown(not editing)
	for _, r in ipairs({ view.NameLabel, view.NameBox, view.NameOK, view.NameCancel }) do r:SetShown(editing) end
	if not editing then
		view.NameError:Hide()
		place(view.NewButton, x, y)
		return y + 28 + 8
	end
	local label, action
	if editor.mode == "rename" then
		label, action = (L["Rename %s to"]):format(P.Label(editor.subject)), L["Rename"]
	elseif editor.mode == "copy" then
		label, action = (L["Copy %s as"]):format(P.Label(editor.subject)), L["Copy"]
	else
		label, action = L["New profile, every setting at its default"], L["Create"]
	end
	view.NameLabel:SetText(label)
	view.NameLabel:SetWidth(width)
	place(view.NameLabel, x, y)
	y = y + 22
	W.SetButtonText(view.NameOK, action)
	local buttons = view.NameOK:GetWidth() + 8 + view.NameCancel:GetWidth()
	view.NameBox:SetWidth(max(120, min(320, width - buttons - 12)))
	place(view.NameBox, x, y)
	view.NameOK:ClearAllPoints()
	view.NameOK:SetPoint("LEFT", view.NameBox, "RIGHT", 12, 0)
	view.NameCancel:ClearAllPoints()
	view.NameCancel:SetPoint("LEFT", view.NameOK, "RIGHT", 8, 0)
	y = y + 30 + 8
	return block(view.NameError, editorError, width, x, y)
end

local function layoutExport(P, x, y, width)
	y = header(view.ExportH, x, y, width)
	local list = {}
	for _, area in ipairs(P.AREAS) do list[#list + 1] = view.ExportAreas[area] end
	y = rows(view.ExportPanel, list, x, y, width) + 12
	place(view.ExportButton, x, y)
	y = y + 28 + 12
	local shown = exported ~= nil
	view.CopyBox:SetShown(shown)
	if shown then
		view.CopyBox:SetWidth(width)
		place(view.CopyBox, x, y)
		y = y + view.CopyBox:GetHeight() + 8
		local line
		if exportedCount == 0 then
			line = L["Nothing in it: every setting ticked above is at its default."]
		else
			line = (L["%s of %s. Selected for you: copy it with Ctrl+C, then share it anywhere."]):format(
				count(exportedCount, L["1 setting"], L["%d settings"]), P.Label(P.Active()))
		end
		y = block(view.CopyNote, line, width, x, y)
	else
		view.CopyNote:Hide()
	end
	return y
end

local function changeLines(P)
	local labels = {}
	for i, path in ipairs(preview.changes) do
		if i > SHOWN_CHANGES then break end
		labels[i] = ns.EscapeText(preview.labels[path])
	end
	local line = table.concat(labels, ", ")
	local more = #preview.changes - #labels
	if more > 0 then line = line .. ", " .. (L["and %d more"]):format(more) end
	return #labels > 0 and line or nil
end

local function layoutImport(P, x, y, width)
	y = header(view.ImportH, x, y, width)
	view.PasteBox:SetWidth(width)
	place(view.PasteBox, x, y)
	y = y + 30 + 12
	local has = preview ~= nil
	if has then
		local parts = { preview.name and P.Label(preview.name) or L["A profile"], count(preview.count, L["1 setting"], L["%d settings"]) }
		local n = #preview.changes
		local active = P.Label(P.Active())
		if n == 0 then
			parts[#parts + 1] = L["the same as yours"]
		elseif n == 1 then
			parts[#parts + 1] = (L["1 differs from %s"]):format(active)
		else
			parts[#parts + 1] = (L["%d differ from %s"]):format(n, active)
		end
		y = block(view.Preview, table.concat(parts, DOT), width, x, y, 4)
		y = block(view.Changes, changeLines(P), width, x, y)
		local list = {}
		for _, area in ipairs(P.AREAS) do
			local row = view.ImportAreas[area]
			local n = preview.areas[area]
			row:SetShown(n > 0)
			row.Label:SetText(AREA_LABEL[area] .. DOT .. count(n, L["1 setting"], L["%d settings"]))
			list[#list + 1] = row
		end
		y = rows(view.ImportPanel, list, x, y + 4, width) + 8
		y = block(view.Screen, preview.otherScreen and L["The positions were made on another screen or UI scale: things may need moving again."] or nil, width, x, y)
		local dropped
		if #preview.dropped > 0 then
			local names = {}
			for i = 1, min(8, #preview.dropped) do names[i] = preview.dropped[i] end
			dropped = (L["Left out, as this Polestar has no such setting or the value does not fit: %s"]):format(table.concat(names, ", "))
			if #preview.dropped > #names then dropped = dropped .. ", " .. (L["and %d more"]):format(#preview.dropped - #names) end
		end
		y = block(view.Dropped, dropped, width, x, y)
		view.ImportNameLabel:SetWidth(0)
		place(view.ImportNameLabel, x, y + 8)
		local lw = floor(view.ImportNameLabel:GetStringWidth() + 12)
		view.ImportName:SetWidth(max(120, min(320, width - lw)))
		place(view.ImportName, x + lw, y)
		y = y + 30 + 10
		place(view.ImportNew, x, y)
		view.ImportHere:ClearAllPoints()
		view.ImportHere:SetPoint("LEFT", view.ImportNew, "RIGHT", 8, 0)
		view.ImportCancel:ClearAllPoints()
		view.ImportCancel:SetPoint("LEFT", view.ImportHere, "RIGHT", 8, 0)
		y = y + 28 + 10
	else
		for _, fs in ipairs({ view.Preview, view.Changes, view.Screen, view.Dropped }) do fs:Hide() end
		view.ImportPanel:Hide()
		for _, row in pairs(view.ImportAreas) do row:Hide() end
	end
	for _, r in ipairs({ view.ImportNameLabel, view.ImportName, view.ImportNew, view.ImportHere }) do r:SetShown(has) end
	view.ImportCancel:SetShown(has or refusal ~= nil)
	y = block(view.Refusal, refusal, width, x, y)
	if refusal and not has then
		place(view.ImportCancel, x, y)
		y = y + 28 + 10
	end
	y = block(view.ImportError, importError, width, x, y)
	return block(view.ImportDone, importDone, width, x, y)
end

function PV.Layout()
	if not view then return 0 end
	local P = Profiles()
	local width = bodyWidth()
	local x, y = SH.pad, 16
	y = header(view.InUseH, x, y, width)
	view.InUse.Value:SetText(P.Label(P.Active()))
	view.InUse.psDesc = sourceLine(P)
	W.RowDetails(view.InUse, { marks = false })
	local class = P.ClassName()
	view.ForClass:SetShown(class ~= nil)
	if class then view.ForClass.Label:SetText((L["Use this profile for every %s"]):format(class)) end
	y = rows(view.InUsePanel, { view.InUse, view.ForChar, view.ForClass }, x, y, width) + 24
	y = layoutList(P, x, y, width) + 16
	y = layoutExport(P, x, y, width) + 16
	y = layoutImport(P, x, y, width)
	return y + 24
end

-- What the page shows, for the tests.
function PV.Shown()
	if not view then return nil end
	local list = {}
	for _, row in ipairs(view.Rows) do
		if row:IsShown() then
			local actions = {}
			for _, key in ipairs({ "Use", "Copy", "Rename", "Delete" }) do
				if row[key]:IsShown() then actions[#actions + 1] = key end
			end
			list[#list + 1] = { name = row.Name:GetText(), inUse = row.Chip:IsShown(), actions = actions }
		end
	end
	return {
		inUse = view.InUse.Value:GetText(),
		source = view.InUse.psDesc,
		rows = list,
		editing = editor and editor.mode or nil,
		editorError = view.NameError:IsShown() and view.NameError:GetText() or nil,
		exported = exported,
		copyNote = view.CopyNote:IsShown() and view.CopyNote:GetText() or nil,
		preview = view.Preview:IsShown() and view.Preview:GetText() or nil,
		changes = view.Changes:IsShown() and view.Changes:GetText() or nil,
		dropped = view.Dropped:IsShown() and view.Dropped:GetText() or nil,
		refusal = view.Refusal:IsShown() and view.Refusal:GetText() or nil,
		done = view.ImportDone:IsShown() and view.ImportDone:GetText() or nil,
		importName = view.ImportName:IsShown() and view.ImportName:GetText() or nil,
	}
end

ns.On("PROFILES_CHANGED", function()
	if not view then return end
	if view:IsVisible() then relayout() else view.psDirty = true end
end)

ns.RegisterOptions({ page = L["Profiles"], key = "profiles", icon = "compact", order = 64, group = "setup", new = "0.3.7",
	subtitle = L["Named sets of settings: one per character, class or the whole account, and strings to share them."],
	search = L["profile, profiles, export, import, share, string, copy settings, backup, per character, alts, class, switch, rename, delete"],
	custom = PV.Build, controls = {} })
