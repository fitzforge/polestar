-- The Profiles page of the settings window (key `profiles`, Setup), two tabs
-- of equal standing:
--   Profiles: every profile as a picture card (a small picture of its look
--   drawn from its own values: its skin with its colours, its arrow and its
--   target pin; "In use" on the one this character uses, else who uses it),
--   the last card a new one; This character (the profile in use, and whether
--   the choice is this character's own or its class's); then the selected
--   profile with Use, Copy, Rename and Delete. A click on a card selects it
--   and Use switches to it, as in the guide menu; Delete takes a second click.
--   Share: a string of a profile (the look, guiding and positions, each
--   switched on or off) to paste anywhere, and pasting someone's: what it
--   holds and what it changes, then into the profile in use or as a new one.
-- The work is Core/Profiles.lua's. A tab is built the first time it shows
-- and laid out again on PROFILES_CHANGED and on setting changes, only while
-- it is on screen.

local ns = Polestar
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local SH = W.SHELL
local format, floor, max, min, ipairs, pairs, type, tonumber = string.format, math.floor, math.max, math.min, ipairs, pairs, type, tonumber

local PV = {}
UI.Profiles = PV

local PAGE, PROFILES, SHARE = L["Profiles"], L["Profiles"], L["Share"]
-- The last card's value, a profile still to name (a profile name holds no NUL).
local NEW = "\0new"
local DOT = "  \194\183  "
local SHOWN_CHANGES = 8 -- settings named in an import's preview; the rest counted
-- The settings window's metrics (DESIGN.md "The Row Rule"): section cards
-- with a 36px header, 36px rows in two halves (stacked below 760), 24 apart.
local ROW, PAD, GAP, STACK_BELOW = 36, 16, 24, 760

local function Profiles() return ns.Profiles end
local function O() return UI.Options end

-- Each tab's view, built the first time the tab shows: PV.views[tab name].
local views = {}
PV.views = views

-- The card picked on the Profiles tab (picking is not switching): a
-- profile's name, or nil for the profile in use.
local selected
-- The name editor in the selected profile's section: { mode = "new" | "copy" | "rename", subject = name }, or nil.
local editor, editorError
-- Share: the profile a string is made of (nil: the one in use), which parts
-- go in, the string made (and of which profile), or why none was.
local shareFrom
local exportAreas = { look = true, guiding = true, positions = true }
local exported, exportedCount, exportedFrom, exportError
-- Import: the pasted string's preview or why it was refused, the parts
-- switched on, and the line left by the last import.
local preview, refusal, importDone, importError
local importAreas = { look = true, guiding = true, positions = true }

-- The profile the Profiles tab's section shows: the one picked while it
-- exists, else the one in use.
local function current()
	local P = Profiles()
	if selected and P.Exists(selected) then return selected end
	return P.Active()
end

-- The lit card: the new one while it is being named.
local function lit()
	if editor and editor.mode == "new" then return NEW end
	return current()
end

-- The profile the Share tab makes strings of.
local function source()
	local P = Profiles()
	if shareFrom and P.Exists(shareFrom) then return shareFrom end
	return P.Active()
end

local function bodyWidth()
	local win = O() and O().frame
	return win and win.BodyWidth or 640
end

-- The tab on screen laid out again; the other when it next shows.
local function relayout()
	local win = O() and O().frame
	for _, v in pairs(views) do
		if v:IsVisible() then
			local h = v.Refresh()
			v:SetHeight(h)
			if win then W.ShellBody(win, h) end
		else
			v.psDirty = true
		end
	end
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

-- How far a profile is from the defaults, in its section and its card's tooltip.
local function changedText(n)
	if not n or n == 0 then return L["Every setting at its default"] end
	return count(n, L["1 setting off its default"], L["%d settings off their defaults"])
end

local function changedOf(name)
	local _, n = Profiles().Portable(name)
	return type(n) == "number" and n or 0
end

-- An edit box in the search field's well: typed text, Enter acts.
local function field(parent, onEnter)
	local e = CreateFrame("EditBox", nil, parent)
	e:SetAutoFocus(false)
	e:SetHeight(26)
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
	return e
end

---------------------------------------------------------------------------
-- Actions
---------------------------------------------------------------------------

-- Pick a card: a profile (nil: the one in use), or the new one to name.
function PV.Select(value)
	if value == NEW then return PV.Edit("new") end
	selected = value
	editor, editorError = nil, nil
	relayout()
end

function PV.Use(name)
	editor, editorError = nil, nil
	local ok, why = Profiles().Switch(name or current())
	if ok then selected = nil end
	relayout()
	return ok, why
end

-- Open the name editor: "new", "copy" (of subject) or "rename" (subject).
function PV.Edit(mode, subject)
	local P = Profiles()
	subject = subject or current()
	editor, editorError = { mode = mode, subject = subject }, nil
	local name = ""
	if mode == "copy" then
		name = P.FreeName((L["%s (copy)"]):format(subject == P.DEFAULT and L["Default"] or subject)) or ""
	elseif mode == "rename" then
		name = subject
	end
	local v = views[PROFILES]
	if v then v.NameBox:SetText(name) end
	relayout()
	if v and v.NameBox:IsVisible() then
		v.NameBox:SetFocus()
		v.NameBox:HighlightText()
	end
end

function PV.CancelEdit()
	editor, editorError = nil, nil
	local v = views[PROFILES]
	if v then v.NameBox:ClearFocus() end
	relayout()
end

-- The editor's action: New and Copy make the profile and switch to it.
function PV.CommitEdit(name)
	if not editor then return end
	local P = Profiles()
	local v = views[PROFILES]
	name = name or (v and v.NameBox:GetText()) or ""
	local ok, why, made
	if editor.mode == "rename" then
		ok, why = P.Rename(editor.subject, name)
		made = ok and P.CleanName(name) or nil
	else
		made, why = P.New(name, editor.mode == "copy" and editor.subject or nil)
		if made then ok, why = P.Switch(made) end
	end
	if ok then
		selected, editor, editorError = made, nil, nil
		if v then v.NameBox:ClearFocus() end
	else
		editorError = why
	end
	relayout()
	return ok
end

-- Delete: its button's second click (W.Confirm).
function PV.Delete(name)
	local ok, why = Profiles().Delete(name or current())
	if ok then selected = nil end
	editorError = not ok and why or nil
	relayout()
	return ok, why
end

-- The Share tab, making strings of `name`.
function PV.Share(name)
	shareFrom = name
	if exported and exportedFrom ~= source() then exported = nil end
	if O() and O().Select then O().Select("profiles", SHARE) else relayout() end
end

function PV.Export()
	local from = source()
	local s, n = Profiles().Export(from, { areas = exportAreas })
	if s then
		exported, exportedCount, exportedFrom, exportError = s, n, from, nil
	else
		exported, exportedCount, exportedFrom, exportError = nil, nil, nil, n
	end
	local v = views[SHARE]
	if v then W.SetCopyText(v.CopyBox, s or "") end
	relayout()
	if v and s and v.CopyBox:IsVisible() then
		v.CopyBox:SetFocus()
		v.CopyBox:HighlightText()
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
			local v = views[SHARE]
			if v then v.ImportName:SetText(Profiles().FreeName(preview.name) or "") end
		end
	end
	relayout()
end

function PV.ClearImport()
	preview, refusal, importError = nil, nil, nil
	local v = views[SHARE]
	if v then v.PasteBox:SetText("") end
	relayout()
end

local function finishImport(line)
	preview, refusal, importError = nil, nil, nil
	importDone = line
	local v = views[SHARE]
	if v then v.PasteBox:SetText("") end
	relayout()
end

-- As a new profile, named in the box beside the buttons, and switched to.
function PV.ImportNew(name)
	if not preview then return end
	local P = Profiles()
	local v = views[SHARE]
	name = name or (v and v.ImportName:GetText()) or ""
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
	selected = nil
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
-- A profile's card: a small picture of its look drawn from its own values
-- by the look code the elements themselves use (the skin's card with the
-- profile's colours, the arrow's dial, the map's target pin); the profile in
-- use from the live settings. Drawn again at every layout, so the card of
-- the profile in use follows its settings.
---------------------------------------------------------------------------

local DEFAULTS = { __index = function(_, path) return ns.GetDefault(path) end }

-- What ns.Get answers while a card is drawn: nil for the profile in use
-- (the live settings), else the profile's own values over the defaults.
local function valuesOf(name)
	local P = Profiles()
	if name == P.Active() then return nil end
	local vals = P.Portable(name)
	return setmetatable(type(vals) == "table" and vals or {}, DEFAULTS)
end

local function with(values, fn)
	if values then return O().WithSettings(values, fn) end
	return fn()
end

-- Nav's colours (the arrow's dial reads them) as palette `pal` gives them, while fn runs.
local function withPalette(pal, fn)
	local Nav = ns.Nav
	if not (pal and Nav and Nav.RGB) then return fn() end
	local rgb = Nav.RGB
	Nav.RGB = function(name)
		local c = pal[name]
		if type(c) == "table" then return c[1], c[2], c[3] end
		return rgb(name)
	end
	local ok, err = pcall(fn)
	Nav.RGB = rgb
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

local function artSize(art)
	local w, h = art:GetWidth(), art:GetHeight()
	if not (w and w > 0) then w = W.CARD_W - 2 end
	if not (h and h > 0) then h = W.CARD_ART end
	return w, h
end

-- Where the arrow and the pin stand on the picture (fractions of it).
local ARROW_AT, PIN_AT = { 0.75, 0.36 }, { 0.75, 0.76 }

-- The window: the profile's skin with its own colours. -> the palette it drew with
local function paintWindow(art, values, w, h)
	local win = art.psWin
	if not win then
		win = CreateFrame("Frame", nil, art)
		art.psWin = win
	end
	win:SetSize(floor(w * 0.56), h - 16)
	win:ClearAllPoints()
	win:SetPoint("LEFT", art, "LEFT", 8, 0)
	local pal
	with(values, function()
		local skin = ns.Get("ui.skin")
		if not (type(skin) == "string" and Theme.PaletteFor and Theme.PaletteFor(skin)) then skin = "polestar" end
		pal = Theme.PaletteFor and Theme.PaletteFor(skin)
		if Theme.DrawSkinCard then Theme.DrawSkinCard(win, skin) end
	end)
	return pal
end

-- The arrow's dial in the profile's style, size and colours, its text off.
local function paintArrow(art, values, pal, w, h)
	local A = ns.Nav and ns.Nav.arrow
	if not (A and A.BuildDial and A.PaintDial and A.ReadLook and A.StyleFor) then return end
	local c = art.psArrow
	if not c then
		local holder = CreateFrame("Frame", nil, art)
		holder:SetSize(A.WIDTH, A.HEIGHT)
		c = { holder = holder, dial = A.BuildDial(holder), look = {} }
		art.psArrow = c
	end
	local scale = 1
	with(values, function()
		A.ReadLook(c.look)
		scale = tonumber(ns.Get("nav.arrowScale")) or 1
		withPalette(pal, function()
			A.PaintDial(c.dial, c.look, A.StyleFor(ns.Get("nav.arrowStyle")), "travel", 0.7, 400)
		end)
	end)
	for _, t in ipairs({ c.dial.distText, c.dial.labelText, c.dial.etaText }) do t:Hide() end
	local s = max(0.36, min(0.7, 0.5 * scale))
	c.holder:SetScale(s)
	c.holder:ClearAllPoints()
	c.holder:SetPoint("TOP", art, "TOPLEFT", ARROW_AT[1] * w / s, -(ARROW_AT[2] * h - A.DIAL * s / 2) / s)
	c.holder:Show()
end

-- The map's target pin in the profile's size and glow, the arrow's colour.
local function paintPin(art, values, pal, w, h)
	local Pins, Layers = ns.Pins, ns.Nav and ns.Nav.layers
	if not (Pins and Pins.BuildLook and Pins.ApplyLook and Pins.ReadLook and Pins.WorldPinSize and Layers and Layers.TargetLook) then return end
	local f = art.psPin
	if not f then
		f = CreateFrame("Frame", nil, art)
		Pins.BuildLook(f)
		art.psPin = f
	end
	with(values, function()
		Pins.ReadLook()
		local glow, _, grow, scale = Layers.TargetLook()
		local c = pal and pal.arrow
		local color = c and { c[1], c[2], c[3], 1 } or { Theme.Color("arrow") }
		local p = { icon = "map:target", color = color, glow = glow, grow = grow }
		Pins.ApplyLook(f, p, Pins.WorldPinSize(p, scale))
	end)
	-- The live pins read their look again.
	Pins.ReadLook()
	local foot = tonumber(f.footPx) or 40
	local k = min(0.6, 34 / max(1, foot))
	f:SetScale(k)
	f:SetAlpha(1)
	f:ClearAllPoints()
	f:SetPoint("CENTER", art, "TOPLEFT", PIN_AT[1] * w / k, -PIN_AT[2] * h / k)
	f:Show()
end

local function paintArt(art, name)
	local values = valuesOf(name)
	local w, h = artSize(art)
	local pal = paintWindow(art, values, w, h)
	paintArrow(art, values, pal, w, h)
	paintPin(art, values, pal, w, h)
end

-- The new profile's card: a plus inside a dashed outline.
local function paintNew(art)
	if art.psNew then return end
	art.psNew = true
	local w, h = artSize(art)
	local plus = W.Tex(art, "ARTWORK", "plus", "textDim")
	plus:SetSize(16, 16)
	plus:SetPoint("CENTER", art, "CENTER", 0, 0)
	local inset, dash, gap = 12, 6, 4
	local function put(x, y, dw, dh)
		local t = W.Tex(art, "BORDER", "white", "textMuted")
		t:SetAlpha(0.55)
		t:SetSize(dw, dh)
		t:SetPoint("TOPLEFT", art, "TOPLEFT", x, -y)
	end
	for x = inset, w - inset - dash, dash + gap do
		put(x, inset, dash, 1)
		put(x, h - inset - 1, dash, 1)
	end
	for y = inset + dash + gap, h - inset - dash - gap, dash + gap do
		put(inset, y, 1, dash)
		put(w - inset - 1, y, 1, dash)
	end
end

---------------------------------------------------------------------------
-- Who uses a profile
---------------------------------------------------------------------------

local function classLabel(token)
	local names = LOCALIZED_CLASS_NAMES_MALE
	local n = type(names) == "table" and names[token]
	if type(n) == "string" then return n end
	return token:sub(1, 1) .. token:sub(2):lower()
end

-- The classes whose characters use profile `name` (their own class's
-- choice), and whether it is the account's.
local function usersOf(name)
	local classes = {}
	local map = ns.DB().classProfiles
	if type(map) == "table" then
		for token, n in pairs(map) do
			if n == name and type(token) == "string" then classes[#classes + 1] = classLabel(token) end
		end
	end
	table.sort(classes)
	return classes, Profiles().AccountProfile() == name
end

-- A card's note: who else uses it ("In use" is a chip of its own).
local function noteOf(name)
	if name == Profiles().Active() then return nil end
	local classes, account = usersOf(name)
	if #classes == 1 then return format(L["Every %s"], classes[1]) end
	if #classes > 1 then return format(L["%d classes"], #classes) end
	if account then return L["Whole account"] end
	return nil
end

-- Who uses profile `name`, as the selected profile's Used by row and the
-- card's tooltip say it: "This character, Every Warlock, Whole account".
local function whoOf(name)
	local who = {}
	if name == Profiles().Active() then who[#who + 1] = L["This character"] end
	local classes, account = usersOf(name)
	for _, c in ipairs(classes) do who[#who + 1] = format(L["Every %s"], c) end
	if account then who[#who + 1] = L["Whole account"] end
	return #who > 0 and table.concat(who, ", ") or nil
end

local function cardTip(name)
	local lines = { changedText(changedOf(name)) }
	local who = whoOf(name)
	if who then lines[#lines + 1] = format("%s: %s", L["Used by"], who) end
	lines[#lines + 1] = L["Click to see it below; Use switches to it."]
	return lines
end

local function cardChoices()
	local P = Profiles()
	local out = {}
	for i, name in ipairs(P.List()) do
		out[i] = { value = name, text = P.Label(name), note = noteOf(name) }
	end
	out[#out + 1] = { value = NEW, text = L["New profile"], draw = paintNew }
	return out
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

-- A switch row (W.Toggle) for state that is no setting, as a compact half;
-- its help is the tooltip (tip(row) -> lines, else the help).
local function switchRow(parent, label, help, get, set, tip)
	local row = W.Toggle(parent, label, nil, help, nil, { get = get, set = function(v)
		set(v)
		relayout()
	end })
	return W.CompactRow(row, { tip = tip })
end

-- A read-only half (W.InfoRow): its label, its value at the right in the
-- control column's edge, the help as its tooltip.
local function infoRow(parent, label, help)
	local row = W.CompactRow(W.InfoRow(parent, label, help))
	row.Value:ClearAllPoints()
	row.Value:SetPoint("RIGHT", row, "RIGHT", -PAD, 0)
	return row
end

-- A section card (W.SectionCard) with a count after its title and the
-- hairlines between the halves of its rows (Share's Import has two blocks).
local function newCard(parent, title)
	local c = W.SectionCard(parent)
	c:SetTitle(title)
	c.Count = W.Text(c.Header, "number", "textMuted")
	c.Count:SetPoint("LEFT", c.Title, "RIGHT", 8, 0)
	c.Count:Hide()
	c.Split = W.Divider(c, true)
	c.Split:Hide()
	c.Split2 = W.Divider(c, true)
	c.Split2:Hide()
	return c
end

-- A section's link in its header ("Share" and a chevron), as the
-- Essentials' More: the label role in textDim, text under the cursor.
local function headerLink(parent, label, tip, onClick)
	local b = CreateFrame("Button", nil, parent)
	b.Label = W.Text(b, "label", "textDim")
	b.Label:SetText(label)
	b.Label:SetPoint("LEFT", b, "LEFT", 0, 0)
	b.Chevron = W.Tex(b, "ARTWORK", "chevron-right", "textDim")
	b.Chevron:SetSize(9, 9)
	b.Chevron:SetPoint("LEFT", b.Label, "RIGHT", 4, 0)
	b:SetSize(floor(b.Label:GetStringWidth() + 13 + 0.5), 20)
	b:SetScript("OnEnter", function(self)
		W.Color(self.Label, "text")
		W.Color(self.Chevron, "text")
		W.Tooltip(self, "ANCHOR_TOP", tip)
	end)
	b:SetScript("OnLeave", function(self)
		W.Color(self.Label, "textDim")
		W.Color(self.Chevron, "textDim")
		W.HideTooltip(self)
	end)
	b:SetScript("OnClick", onClick)
	return b
end

-- A line of status inside a card: a glyph (a check for done, a cross for
-- refused) and a note beside it.
local STATUS = { success = "check", danger = "close", warning = "info" }
local function statusLine(parent)
	local s = CreateFrame("Frame", nil, parent)
	s.Icon = W.Tex(s, "ARTWORK", "check", "success")
	s.Icon:SetSize(12, 12)
	s.Icon:SetPoint("TOPLEFT", s, "TOPLEFT", 0, -2)
	s.Text = text(s, "note", "textDim")
	s.Text:SetPoint("TOPLEFT", s, "TOPLEFT", 20, 0)
	s:Hide()
	return s
end

local function sourceLine(P)
	local source = P.Source()
	if source == "character" then return L["Only this character uses it."] end
	if source == "class" then return (L["Every %s uses it (the class's profile)."]):format(P.ClassName() or "") end
	return L["Every character on this account uses it, unless one has its own."]
end

local AREA_LABEL = { look = L["Look"], guiding = L["Guiding"], positions = L["Positions"] }
local AREA_HELP = {
	look = L["Everything on the Look pages: theme, colours, fonts, sizes, the arrow, map pins, lines, buttons and alerts."],
	guiding = L["What Polestar does and shows: the Guide, Map, Questing, Discovery and Quality of Life pages."],
	positions = L["Where you dragged the guide window, the arrow, the alerts and the panels. Another screen may need them moved again."],
}

local function profileChoices()
	local P = Profiles()
	local out = {}
	for i, name in ipairs(P.List()) do out[i] = { value = name, text = P.Label(name) } end
	return out
end

local layoutProfiles, layoutShare

local function buildProfiles(v)
	local P = Profiles()
	-- The cards first, so the rows over them draw above.
	v.ListCard = newCard(v, L["Profiles"])
	v.CharCard = newCard(v, L["This character"])
	v.CharWho = W.Text(v.CharCard.Header, "small", "textMuted")
	v.CharWho:SetPoint("RIGHT", v.CharCard.Header, "RIGHT", -PAD, 0)
	v.SelCard = newCard(v, "")
	v.SelChip = W.Chip(v.SelCard.Header)
	v.SelChip:Hide()
	v.ShareLink = headerLink(v.SelCard.Header, SHARE, L["Make a string of this profile to share it."], function() PV.Share(current()) end)

	v.CardRow = W.CompactRow(W.Cards(v, L["Profiles"], nil, cardChoices,
		L["Click a profile to see it below: Use switches to it. The last card makes a new one."], { get = lit, set = PV.Select }), { bare = true })
	v.Chips = {}

	v.Profile = W.Dropdown(v, L["Profile"], nil, profileChoices, L["The profile this character uses now."], nil,
		{ get = function() return P.Active() end, set = function(name) PV.Use(name) end })
	W.CompactRow(v.Profile, { tip = function() return { sourceLine(P), L["Pick another to switch to it."] } end })
	v.ForChar = switchRow(v, L["This character only"],
		L["This character keeps its own choice of profile. Off: it follows its class's profile, else the account's."],
		function() return P.ForCharacter() end, function(on) P.UseForCharacter(on) end)
	v.ForClass = switchRow(v, L["Whole class"],
		L["Every character of this class uses the profile in use, unless one has its own."],
		function() return P.ClassProfile() ~= nil end, function(on) P.UseForClass(on) end,
		function() return { (L["Every %s uses the profile in use, unless one has its own."]):format(P.ClassName() or "") } end)

	-- The selected profile: who uses it and how far it is from the defaults, then its actions.
	v.UsedBy = infoRow(v, L["Used by"], L["Who uses this profile: this character, a class (Whole class) or the whole account (every character without a profile of its own or its class's). Another character's own choice shows on that character."])
	v.Changed = infoRow(v, L["Settings changed"], L["The settings of this profile that are off their defaults."])

	-- The selected profile's actions; Delete takes a second click.
	v.Use = W.Button(v, L["Use"], function() PV.Use(current()) end, { primary = true, height = 24 })
	v.Use.psTip = L["Use this profile now."]
	v.Copy = W.Button(v, L["Copy"], function() PV.Edit("copy", current()) end, { height = 24 })
	v.Copy.psTip = L["Make a new profile from this one and use it."]
	v.Rename = W.Button(v, L["Rename"], function() PV.Edit("rename", current()) end, { height = 24 })
	v.Rename.psTip = L["Give this profile another name."]
	v.Delete = W.Button(v, L["Delete"], nil, { danger = true, height = 24 })
	v.Delete.psTip = L["Delete this profile (asks first)."]
	v.Delete.psSetText = function(self, label)
		W.SetButtonText(self, label)
		self:ClearAllPoints()
		self:SetPoint("RIGHT", v, "TOPLEFT", (v.psActionsRight or 0), -(v.psActionsY or 0))
	end
	W.Confirm(v.Delete, L["Delete"], function() PV.Delete(current()) end)
	-- The name editor, in place of the actions.
	v.NameLabel = W.Text(v, "body", "rowLabel")
	v.NameLabel:SetWordWrap(false)
	v.NameBox = field(v, function() PV.CommitEdit() end)
	v.NameOK = W.Button(v, "", function() PV.CommitEdit() end, { primary = true, height = 24 })
	v.NameCancel = W.Button(v, L["Cancel"], function() PV.CancelEdit() end, { height = 24 })
	v.NameError = text(v, "note", "warning")
	v.Refresh = function() return layoutProfiles(v) end
end

local function buildShare(v)
	local P = Profiles()
	v.MakeCard = newCard(v, L["Make a string"])
	v.ImportCard = newCard(v, L["Import"])

	v.ExportAreas = {}
	for _, area in ipairs(P.AREAS) do
		v.ExportAreas[area] = switchRow(v, AREA_LABEL[area], AREA_HELP[area],
			function() return exportAreas[area] end,
			function(on)
				exportAreas[area] = on and true or false
				if exported then PV.Export() end
			end)
	end
	v.From = W.Dropdown(v, L["From"], nil, profileChoices, L["The profile the string is made of."], nil, { get = source, set = function(name)
		shareFrom = name
		if exported then PV.Export() else relayout() end
	end })
	W.CompactRow(v.From)
	v.CopyBox = W.CopyBox(v, { lines = 3 })
	v.Made = statusLine(v)
	v.ExportButton = W.Button(v, L["Make a string"], function() PV.Export() end, { primary = true, height = 24 })
	v.ExportButton.psTip = L["A line of text holding the parts switched on above, from the profile chosen, to paste anywhere."]

	v.PasteBox = pasteBox(v)
	v.Status = statusLine(v)
	v.Changes = text(v, "note", "textDim")
	v.ImportAreas = {}
	for _, area in ipairs(P.AREAS) do
		v.ImportAreas[area] = switchRow(v, AREA_LABEL[area], AREA_HELP[area],
			function() return importAreas[area] end,
			function(on) importAreas[area] = on and true or false end)
	end
	v.Screen = text(v, "note", "warning")
	v.Dropped = text(v, "note", "warning")
	v.ImportNameLabel = W.Text(v, "body", "rowLabel")
	v.ImportNameLabel:SetText(L["Name"])
	v.ImportName = field(v, function() PV.ImportNew() end)
	v.ImportNew = W.Button(v, L["Import as new"], function() PV.ImportNew() end, { primary = true, height = 24 })
	v.ImportNew.psTip = L["A new profile with the string's settings (the parts switched on), every other setting at its default. Polestar switches to it."]
	v.ImportHere = W.Button(v, L["Apply to current"], function() PV.ImportHere() end, { height = 24 })
	v.ImportHere.psTip = L["The string's settings (the parts switched on) into the profile in use; the rest stay as they are. Asks first."]
	v.ImportCancel = W.Button(v, L["Clear"], function() PV.ClearImport() end, { ghost = true, height = 24 })
	v.ImportCancel.psTip = L["Empty the box."]
	v.ImportError = text(v, "note", "warning")
	v.Done = statusLine(v)
	v.Refresh = function() return layoutShare(v) end
end

function PV.Build(v)
	local name = v.psTab and v.psTab.name or PROFILES
	views[name] = v
	if name == SHARE then buildShare(v) else buildProfiles(v) end
	v:HookScript("OnShow", function() if v.psDirty then relayout() end end)
end

---------------------------------------------------------------------------
-- Layout
---------------------------------------------------------------------------

local function place(v, region, x, y)
	region:ClearAllPoints()
	region:SetPoint("TOPLEFT", v, "TOPLEFT", x, -y)
end

-- A line of feedback inside a card (a status, a warning). -> y under it
local function line(v, fs, s, width, x, y)
	fs:SetShown(s ~= nil)
	if not s then return y end
	fs:SetText(s)
	fs:SetWidth(width - 2 * PAD)
	place(v, fs, x + PAD, y + 10)
	return y + fs:GetStringHeight() + 20
end

-- A status line (statusLine): `kind` "success" | "danger" | "warning" puts its glyph before the text. -> y under it
local function status(v, s, msg, kind, width, x, y)
	s:SetShown(msg ~= nil)
	if not msg then return y end
	local glyph = STATUS[kind]
	s.Icon:SetShown(glyph ~= nil)
	if glyph then
		s.Icon:SetTexture(Theme.Media(glyph))
		W.Color(s.Icon, kind)
	end
	s.Text:ClearAllPoints()
	s.Text:SetPoint("TOPLEFT", s, "TOPLEFT", glyph and 20 or 0, 0)
	s.Text:SetWidth(width - 2 * PAD - (glyph and 20 or 0))
	s.Text:SetText(msg)
	W.Color(s.Text, kind == "danger" and "danger" or "textDim")
	local h = max(14, s.Text:GetStringHeight())
	s:SetSize(width - 2 * PAD, h)
	place(v, s, x + PAD, y + 11)
	return y + h + 22
end

-- One compact half at `w` (W.CompactRow: 36 tall, label and control 16 in).
local function setRow(v, row, x, y, w)
	W.LayoutRow(row, w)
	if row.Refresh then row:Refresh() end
	place(v, row, x, y)
	row:Show()
end

-- Rows in two halves (stacked below STACK_BELOW), the hairline between the
-- halves on the card. list items: a row, or false for an empty half. -> y
local function halves(v, split, list, x, y, width)
	local shown = {}
	for _, r in ipairs(list) do if r == false or r:IsShown() then shown[#shown + 1] = r end end
	if #shown == 0 then
		split:Hide()
		return y
	end
	local two = width >= STACK_BELOW
	local half = two and floor((width - 1) / 2) or width
	local top = y
	for i, r in ipairs(shown) do
		local col = two and (i - 1) % 2 or 0
		if r then setRow(v, r, x + col * (half + 1), y, half) end
		if not two or col == 1 or i == #shown then y = y + ROW end
	end
	split:SetShown(two)
	if two then
		split:ClearAllPoints()
		split:SetPoint("TOPLEFT", v, "TOPLEFT", x + half, -top)
		split:SetHeight(y - top)
	end
	return y
end

-- Start a card at y: -> the y its rows start at.
local function openCard(card, title, n, x, y)
	card.psTop = y
	if title then card:SetTitle(title) end
	card.Count:SetShown(n ~= nil)
	if n then
		card.Count:SetText(n)
		card.Count:ClearAllPoints()
		card.Count:SetPoint("LEFT", card.Title, "LEFT", math.ceil(W.TextWidth(card.Title)) + 8, 0)
	end
	return y + card.RowsTop
end

local function closeCard(card, x, y, width)
	return card.psTop + card:Place(x, card.psTop, width, y - card.psTop - card.RowsTop)
end

-- The cards' own parts the picture cards do not have: the "In use" chip at
-- the name's right, and each picture drawn again.
local function decorateCards(v)
	local P = Profiles()
	local active = P.Active()
	local cards = v.CardRow.psCardBy
	for _, chip in pairs(v.Chips) do chip:Hide() end
	for _, name in ipairs(P.List()) do
		local card = cards[name]
		if card and card:IsShown() then
			card.psTipLines = cardTip(name)
			if name == active then
				local chip = v.Chips[card]
				if not chip then
					chip = W.Chip(card)
					v.Chips[card] = chip
				end
				local cw = W.SetChip(chip, L["In use"], "success")
				chip:ClearAllPoints()
				chip:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -8, 7)
				chip:SetFrameLevel(card:GetFrameLevel() + 3)
				card.Name:SetWidth(max(20, card:GetWidth() - 20 - cw - 6))
			end
			paintArt(card.Art, name)
		end
	end
end

-- The selected profile's buttons on one line at y: Use, Copy and Rename from
-- the left, Delete at the right.
local function placeActions(v, P, name, x, y, width)
	local active = name == P.Active()
	local fixed = name == P.DEFAULT
	v.Use:SetShown(not active)
	v.Copy:Show()
	v.Rename:SetShown(not fixed)
	v.Delete:SetShown(not fixed and not active)
	-- A Delete armed for another profile is not this one's.
	if v.psActionsFor ~= name then
		v.psActionsFor = name
		v.Delete.psArmed = nil
		W.SetButtonText(v.Delete, L["Delete"])
	end
	local left = x + PAD
	for _, b in ipairs({ v.Use, v.Copy, v.Rename }) do
		if b:IsShown() then
			b:ClearAllPoints()
			b:SetPoint("LEFT", v, "TOPLEFT", left, -(y + ROW / 2))
			left = left + b:GetWidth() + 8
		end
	end
	v.psActionsRight, v.psActionsY = x + width - PAD, y + ROW / 2
	v.Delete:ClearAllPoints()
	v.Delete:SetPoint("RIGHT", v, "TOPLEFT", v.psActionsRight, -v.psActionsY)
end

-- The name editor on one line at y: what it does, the box, its action and Cancel.
local function placeEditor(v, P, x, y, width)
	local action
	if editor.mode == "rename" then
		action = L["Rename"]
	elseif editor.mode == "copy" then
		action = L["Copy"]
	else
		action = L["Create"]
	end
	W.SetButtonText(v.NameOK, action)
	v.NameLabel:SetText(L["Name"])
	v.NameCancel:ClearAllPoints()
	v.NameCancel:SetPoint("RIGHT", v, "TOPLEFT", x + width - PAD, -(y + ROW / 2))
	v.NameOK:ClearAllPoints()
	v.NameOK:SetPoint("RIGHT", v.NameCancel, "LEFT", -8, 0)
	local lw = math.ceil(W.TextWidth(v.NameLabel))
	v.NameLabel:SetWidth(lw + 2)
	v.NameLabel:ClearAllPoints()
	v.NameLabel:SetPoint("LEFT", v, "TOPLEFT", x + PAD, -(y + ROW / 2))
	local buttons = v.NameOK:GetWidth() + 8 + v.NameCancel:GetWidth()
	v.NameBox:SetWidth(max(140, min(320, width - 2 * PAD - lw - 16 - buttons - 16)))
	v.NameBox:ClearAllPoints()
	v.NameBox:SetPoint("LEFT", v.NameLabel, "RIGHT", 14, 0)
end

local function layoutSelected(v, P, x, y, width)
	local card = v.SelCard
	local editing = editor ~= nil
	local name = current()
	local title
	if editing and editor.mode == "new" then
		title = L["New profile"]
	elseif editing and editor.mode == "copy" then
		title = (L["Copy of %s"]):format(P.Label(editor.subject))
	elseif editing then
		title = (L["Rename %s"]):format(P.Label(editor.subject))
	else
		title = P.Label(name)
	end
	y = openCard(card, title, nil, x, y)
	-- The header: an "In use" chip after the name, Share at the right.
	local tw = math.ceil(W.TextWidth(card.Title))
	card.Title:SetWidth(min(tw + 2, floor(width * 0.5)))
	local inUse = not editing and name == P.Active()
	v.SelChip:SetShown(inUse)
	if inUse then
		W.SetChip(v.SelChip, L["In use"], "success")
		v.SelChip:ClearAllPoints()
		v.SelChip:SetPoint("LEFT", card.Header, "LEFT", PAD + min(tw, floor(width * 0.5)) + 10, 0)
	end
	v.ShareLink:SetShown(not editing)
	v.ShareLink:ClearAllPoints()
	v.ShareLink:SetPoint("RIGHT", card.Header, "RIGHT", -PAD, 0)
	-- Who uses it and how far it is from the defaults, then its actions; the
	-- name editor in their place while it is open.
	v.UsedBy:SetShown(not editing)
	v.Changed:SetShown(not editing)
	if editing then
		card.Split:Hide()
	else
		v.UsedBy.Value:SetText(whoOf(name) or "\226\128\148")
		local n = changedOf(name)
		v.Changed.Value:SetText(n > 0 and tostring(n) or L["None"])
		y = halves(v, card.Split, { v.UsedBy, v.Changed }, x, y, width)
	end
	for _, b in ipairs({ v.Use, v.Copy, v.Rename, v.Delete }) do b:SetShown(not editing) end
	for _, r in ipairs({ v.NameLabel, v.NameBox, v.NameOK, v.NameCancel }) do r:SetShown(editing) end
	if editing then placeEditor(v, P, x, y, width) else placeActions(v, P, name, x, y, width) end
	y = y + ROW
	y = line(v, v.NameError, editorError, width, x, y)
	return closeCard(card, x, y, width)
end

function layoutProfiles(v)
	v.psDirty = nil
	local P = Profiles()
	if selected and not P.Exists(selected) then selected = nil end
	local width = bodyWidth()
	local x, y = SH.pad, 16
	local names = P.List()
	-- Profiles: the cards, the last a new one.
	local card = v.ListCard
	y = openCard(card, nil, #names, x, y)
	local h = W.LayoutRow(v.CardRow, width)
	if v.CardRow.Refresh then v.CardRow:Refresh() end
	place(v, v.CardRow, x, y)
	v.CardRow:Show()
	decorateCards(v)
	y = closeCard(card, x, y + h, width) + GAP
	-- This character: the profile in use, whose choice it is.
	card = v.CharCard
	y = openCard(card, nil, nil, x, y)
	local me = UnitName and UnitName("player")
	local class = P.ClassName()
	v.CharWho:SetText(me and class and format(L["%s, %s"], me, class) or me or class or "")
	v.ForClass:SetShown(class ~= nil)
	y = halves(v, card.Split, class and { v.Profile, v.ForChar, v.ForClass, false } or { v.Profile, v.ForChar }, x, y, width)
	y = closeCard(card, x, y, width) + GAP
	-- The selected profile.
	y = layoutSelected(v, P, x, y, width)
	return y + 24
end

local function changeLines()
	local labels = {}
	for i, path in ipairs(preview.changes) do
		if i > SHOWN_CHANGES then break end
		labels[i] = ns.EscapeText(preview.labels[path])
	end
	local s = table.concat(labels, ", ")
	local more = #preview.changes - #labels
	if more > 0 then s = s .. ", " .. (L["and %d more"]):format(more) end
	return #labels > 0 and s or nil
end

-- Make a string: the parts and the profile, the string once made, its line and the button.
local function layoutMake(v, P, x, y, width)
	local card = v.MakeCard
	y = openCard(card, nil, nil, x, y)
	local a = v.ExportAreas
	y = halves(v, card.Split, { a.look, a.guiding, a.positions, v.From }, x, y, width)
	local made = exported ~= nil
	v.CopyBox:SetShown(made)
	if made then
		v.CopyBox:SetWidth(width - 2 * PAD)
		place(v, v.CopyBox, x + PAD, y + 12)
		y = y + 12 + v.CopyBox:GetHeight()
	end
	-- Its line, the button at the right of it.
	local msg, kind
	if made then
		if exportedCount == 0 then
			msg, kind = L["Nothing in it: every setting switched on above is at its default."], "warning"
		else
			msg, kind = (L["%s of %s. Selected for you: copy it with Ctrl+C, then share it anywhere."]):format(
				count(exportedCount, L["1 setting"], L["%d settings"]), P.Label(exportedFrom)), "success"
		end
	elseif exportError then
		msg, kind = exportError, "danger"
	else
		msg = L["Switch on the parts to share and pick the profile, then make the string."]
	end
	local bw = v.ExportButton:GetWidth()
	local top = y
	y = status(v, v.Made, msg, kind, width - bw - 16, x, y)
	v.ExportButton:ClearAllPoints()
	v.ExportButton:SetPoint("RIGHT", v, "TOPLEFT", x + width - PAD, -(top + ROW / 2))
	y = max(y, top + ROW)
	return closeCard(card, x, y, width)
end

-- Import: the paste box, then what the string holds and the ways in.
local function layoutImport(v, P, x, y, width)
	local card = v.ImportCard
	y = openCard(card, nil, nil, x, y)
	v.PasteBox:SetWidth(width - 2 * PAD)
	place(v, v.PasteBox, x + PAD, y + 12)
	y = y + 12 + v.PasteBox:GetHeight()
	local has = preview ~= nil
	if has then
		local n = #preview.changes
		local active = P.Label(P.Active())
		local differ
		if n == 0 then
			differ = L["the same as yours"]
		elseif n == 1 then
			differ = (L["1 differs from %s"]):format(active)
		else
			differ = (L["%d differ from %s"]):format(n, active)
		end
		local msg = table.concat({ preview.name and P.Label(preview.name) or L["A profile"], count(preview.count, L["1 setting"], L["%d settings"]), differ }, DOT)
		y = status(v, v.Status, msg, "success", width, x, y)
		local changes = changeLines()
		if changes then y = line(v, v.Changes, changes, width, x, y - 14) else v.Changes:Hide() end
		local list = {}
		for _, area in ipairs(P.AREAS) do
			local row = v.ImportAreas[area]
			local k = preview.areas[area]
			row:SetShown(k > 0)
			row.Label:SetText(AREA_LABEL[area] .. DOT .. count(k, L["1 setting"], L["%d settings"]))
			list[#list + 1] = row
		end
		y = halves(v, card.Split2, list, x, y, width)
		y = line(v, v.Screen, preview.otherScreen and L["The positions were made on another screen or UI scale: things may need moving again."] or nil, width, x, y)
		local dropped
		if #preview.dropped > 0 then
			local names = {}
			for i = 1, min(8, #preview.dropped) do names[i] = preview.dropped[i] end
			dropped = (L["Left out, as this Polestar has no such setting or the value does not fit: %s"]):format(table.concat(names, ", "))
			if #preview.dropped > #names then dropped = dropped .. ", " .. (L["and %d more"]):format(#preview.dropped - #names) end
		end
		y = line(v, v.Dropped, dropped, width, x, y)
		-- The new profile's name at the left, the ways in at the right: one row.
		v.ImportNameLabel:ClearAllPoints()
		v.ImportNameLabel:SetPoint("LEFT", v, "TOPLEFT", x + PAD, -(y + ROW / 2))
		v.ImportNew:ClearAllPoints()
		v.ImportNew:SetPoint("RIGHT", v, "TOPLEFT", x + width - PAD, -(y + ROW / 2))
		v.ImportHere:ClearAllPoints()
		v.ImportHere:SetPoint("RIGHT", v.ImportNew, "LEFT", -8, 0)
		v.ImportCancel:ClearAllPoints()
		v.ImportCancel:SetPoint("RIGHT", v.ImportHere, "LEFT", -8, 0)
		local buttons = v.ImportNew:GetWidth() + v.ImportHere:GetWidth() + v.ImportCancel:GetWidth() + 16
		local lw = floor(W.TextWidth(v.ImportNameLabel) + 12)
		v.ImportName:SetWidth(max(120, min(280, width - 2 * PAD - lw - buttons - 24)))
		v.ImportName:ClearAllPoints()
		v.ImportName:SetPoint("LEFT", v.ImportNameLabel, "RIGHT", 12, 0)
		y = y + ROW
	else
		for _, fs in ipairs({ v.Changes, v.Screen, v.Dropped }) do fs:Hide() end
		for _, row in pairs(v.ImportAreas) do row:Hide() end
		card.Split2:Hide()
		-- Why it was refused, Clear at the right of it.
		local top = y
		y = status(v, v.Status, refusal, "danger", width - v.ImportCancel:GetWidth() - 16, x, y)
		if refusal then
			v.ImportCancel:ClearAllPoints()
			v.ImportCancel:SetPoint("RIGHT", v, "TOPLEFT", x + width - PAD, -(top + ROW / 2))
			y = max(y, top + ROW)
		end
	end
	for _, r in ipairs({ v.ImportNameLabel, v.ImportName, v.ImportNew, v.ImportHere }) do r:SetShown(has) end
	v.ImportCancel:SetShown(has or refusal ~= nil)
	y = line(v, v.ImportError, importError, width, x, y)
	y = status(v, v.Done, importDone, "success", width, x, y)
	return closeCard(card, x, y + 4, width)
end

function layoutShare(v)
	v.psDirty = nil
	local P = Profiles()
	local width = bodyWidth()
	local x, y = SH.pad, 16
	y = layoutMake(v, P, x, y, width) + GAP
	y = layoutImport(v, P, x, y, width)
	return y + 24
end

-- What the page shows, for the tests.
function PV.Shown()
	local out = {}
	local v, s = views[PROFILES], views[SHARE]
	if v then
		local cards = {}
		for _, name in ipairs(Profiles().List()) do
			local card = v.CardRow.psCardBy[name]
			if card and card:IsShown() then
				local chip = v.Chips[card]
				local note = card.Note:IsShown() and card.Note:GetText() or ""
				cards[#cards + 1] = { name = card.Name:GetText(), inUse = chip ~= nil and chip:IsShown(), lit = card.Check:IsShown(),
					note = note ~= "" and note or nil }
			end
		end
		local new = v.CardRow.psCardBy[NEW]
		local actions = {}
		for _, k in ipairs({ "Use", "Copy", "Rename", "Delete" }) do
			if v[k]:IsShown() then actions[#actions + 1] = k end
		end
		out.cards, out.newCard, out.newLit = cards, new ~= nil and new:IsShown(), new ~= nil and new.Check:IsShown()
		out.inUse = v.Profile.Button.Label:GetText()
		out.source = v.Profile.psTipFn(v.Profile)[1]
		out.who = v.CharWho:GetText()
		out.selected = v.SelCard.Title:GetText()
		out.selectedInUse = v.SelChip:IsShown()
		out.usedBy = v.UsedBy:IsShown() and v.UsedBy.Value:GetText() or nil
		out.changed = v.Changed:IsShown() and v.Changed.Value:GetText() or nil
		out.actions = actions
		out.delete = v.Delete.Label:GetText()
		out.editing = editor and editor.mode or nil
		out.editorError = v.NameError:IsShown() and v.NameError:GetText() or nil
	end
	if s then
		out.from = s.From.Button.Label:GetText()
		out.exported = exported
		out.copyNote = s.Made:IsShown() and s.Made.Text:GetText() or nil
		out.preview = s.Status:IsShown() and not refusal and s.Status.Text:GetText() or nil
		out.changes = s.Changes:IsShown() and s.Changes:GetText() or nil
		out.dropped = s.Dropped:IsShown() and s.Dropped:GetText() or nil
		out.refusal = s.Status:IsShown() and refusal and s.Status.Text:GetText() or nil
		out.done = s.Done:IsShown() and s.Done.Text:GetText() or nil
		out.importName = s.ImportName:IsShown() and s.ImportName:GetText() or nil
	end
	return out
end

local function changed()
	for _, v in pairs(views) do
		if v:IsVisible() then return relayout() end
		v.psDirty = true
	end
end
ns.On("PROFILES_CHANGED", changed)
-- The card of the profile in use follows its settings.
ns.On("SETTING_CHANGED", changed)

ns.RegisterOptions({ page = PAGE, key = "profiles", icon = "layers", order = 64, group = "setup", new = "0.3.8", tab = PROFILES,
	subtitle = L["Named sets of settings: one per character, class or the whole account, and strings to share them."],
	search = L["profile, profiles, export, import, share, string, copy settings, backup, per character, alts, class, switch, rename, delete"],
	custom = PV.Build, controls = {} })
ns.RegisterOptions({ page = PAGE, key = "profiles", tab = SHARE, controls = {} })
