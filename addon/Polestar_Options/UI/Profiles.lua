-- The Profiles page of the settings window (key `profiles`, Setup), two tabs
-- of equal standing:
--   Profiles: every profile as a picture card (a small picture of its look
--   drawn from its own values: its skin with its colours, its arrow and its
--   target pin; "In use" on the one this character uses, else who uses it),
--   the last card a new one; This character (the profile in use, and whether
--   the choice is this character's own or its class's); then the selected
--   profile with Use, Copy, Rename and Delete. A click on a card selects it
--   and Use switches to it, as in the guide menu; Delete takes a second click.
--   Share: a string of a profile to paste anywhere, holding the categories
--   ticked on its checklist (P.CATEGORIES; every one but Window positions to
--   start with), and pasting someone's: a checklist of the categories it
--   holds, each with what it changes (yours, then theirs), then into the
--   profile in use or as a new one, with an Undo after.
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
-- An open category's list: a line a setting, LIST_MAX at most (the rest counted).
local LINE, LIST_MAX = 22, 40
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
-- The selected profile's key being set: what the capture says (a key taken
-- by something else), shown under its actions.
local keyNote
-- Share: the profile a string is made of (nil: the one in use), the
-- categories ticked to go in and the one whose list is open, the string
-- made (and of which profile), or why none was.
local shareFrom
local exportPick, exportOpen = {}, nil
local exported, exportedCount, exportedFrom, exportError
-- Import: the pasted string's preview or why it was refused, the
-- categories ticked to take and the one open, the line the last import
-- left and what its Undo takes back.
local preview, refusal, importDone, importError
local importPick, importOpen = {}, nil
local undo
-- While an import writes its settings: the tab is laid out once, after.
local busy = false

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
-- A key's name as the game's key bindings write it ("Ctrl-F5"), nil for none.
local function keyName(key)
	local G = ns.Gamepad
	if not key then return nil end
	return G and G.KeyName and G.KeyName(key) or key
end
PV.KeyName = keyName

-- Why `key` cannot be the profile's, or nil: a chord, or a key the game or
-- another addon binds (another profile's moves here).
local function keyRefusal(key)
	local G = ns.Gamepad
	if G and G.IsChord and G.IsChord(key) then return L["One key or button, not two."] end
	-- The game's gamepad setup keeps the gamepad's buttons to itself.
	if G and G.IsPadKey and G.IsPadKey(key) and ns.GamepadUI and ns.GamepadUI() then
		return L["The game's gamepad setup holds the gamepad's buttons: press a keyboard key."]
	end
	local action = GetBindingAction and GetBindingAction(key, true) or ""
	if type(action) == "string" and action ~= "" and not action:find("^CLICK PolestarProfileKey") then
		local who = G and G.WhoUses and G.WhoUses(nil, key)
		local by = who and who.name or action
		return (L["%s is taken (%s): press another key, or Escape."]):format(keyName(key), by)
	end
	return nil
end

-- Set the profile's key: the next key (or gamepad button) pressed, Escape
-- cancelling (the shared capture, UI/Gamepad.lua). -> started
function PV.CaptureKey(name)
	local G = ns.Gamepad
	local P = Profiles()
	if not (G and G.Capture and P.SetKey and P.Exists(name)) then return false end
	keyNote = nil
	local ok = G.Capture({
		refuse = keyRefusal,
		say = function(text)
			keyNote = text
			relayout()
		end,
		done = function(key)
			PV.capturing, keyNote = nil, nil
			if key then P.SetKey(name, key) end
			relayout()
		end,
	})
	if ok then
		PV.capturing = name
		relayout()
	end
	return ok
end

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
	local s, n = Profiles().Export(from, { categories = exportPick })
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

-- Every category, ticked when ids is nil or names it.
local function picked(ids)
	local t = {}
	for _, c in ipairs(Profiles().CATEGORIES or {}) do t[c.id] = ids == nil or ids[c.id] == true end
	return t
end

-- To start with, everything goes in but where frames were dragged to.
exportPick = picked()
exportPick.positions = false

-- What an import would change, by category: id -> { change, ... }.
local function changesBy(list)
	local by = {}
	for _, ch in ipairs(list) do
		local t = by[ch.category]
		if not t then
			t = {}
			by[ch.category] = t
		end
		t[#t + 1] = ch
	end
	return by
end

-- A category of the pasted string can be taken while it changes something
-- or carries settings (a new profile takes those).
local function takeable(id, by)
	return preview ~= nil and preview.holds[id] and ((by[id] ~= nil and #by[id] > 0) or (preview.held[id] or 0) > 0) and true or false
end

local function pickImport(ids)
	local by = changesBy(Profiles().Changes(preview))
	importPick = picked(ids)
	for id, on in pairs(importPick) do importPick[id] = on and takeable(id, by) end
end

-- side "export" | "import": its categories ticked as ids says (every one
-- when nil; on Import, those it can take).
function PV.Pick(side, ids)
	if side == "import" then
		if not preview then return end
		pickImport(ids)
	else
		exportPick = picked(ids)
		if exported then return PV.Export() end
	end
	relayout()
end

-- One category ticked or not.
function PV.Tick(side, id, on)
	if side == "import" then
		importPick[id] = on and true or false
	else
		exportPick[id] = on and true or false
		if exported then return PV.Export() end
	end
	relayout()
end

-- A category's list opened, or folded again: one open at a time.
function PV.Open(side, id)
	if side == "import" then
		importOpen = importOpen ~= id and id or nil
	else
		exportOpen = exportOpen ~= id and id or nil
	end
	relayout()
end

function PV.Check(value)
	importDone, importError, undo, importOpen = nil, nil, nil, nil
	if (value or ""):gsub("%s+", "") == "" then
		preview, refusal = nil, nil
	else
		preview, refusal = Profiles().Import(value)
		if preview then
			-- Ticked: every part it holds that it can take, but positions made on another screen.
			pickImport()
			if preview.otherScreen then importPick.positions = false end
			local v = views[SHARE]
			if v then v.ImportName:SetText(Profiles().FreeName(preview.name) or "") end
		end
	end
	relayout()
end

function PV.ClearImport()
	preview, refusal, importError, importOpen = nil, nil, nil, nil
	local v = views[SHARE]
	if v then v.PasteBox:SetText("") end
	relayout()
end

local function finishImport(line, u)
	preview, refusal, importError, importOpen = nil, nil, nil, nil
	importDone, undo = line, u
	local v = views[SHARE]
	if v then v.PasteBox:SetText("") end
	relayout()
end

-- fn(...) with the tab laid out once, after (an import's or its undo's
-- settings each fire SETTING_CHANGED). -> what fn returns
local function quietly(fn, ...)
	busy = true
	local ok, a, b = pcall(fn, ...)
	busy = false
	if not ok then error(a, 0) end
	return a, b
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
	local ok, u = quietly(P.Apply, preview, clean, importPick)
	if not ok then
		importError = u
		relayout()
		return
	end
	quietly(P.Switch, clean)
	selected = nil
	finishImport((L["Imported as %s, now in use."]):format(P.Label(clean)), u)
end

-- Into the profile in use, after the dialog (none when nothing ticked would change).
function PV.ImportHere()
	if not preview then return end
	local P = Profiles()
	local n = #P.Changes(preview, importPick)
	if n == 0 then
		-- Nothing written: P.Apply says why.
		importError = select(2, P.Apply(preview, P.Active(), importPick))
		relayout()
		return
	end
	W.Modal({ title = L["Apply to the profile in use?"], icon = "check", action = L["Apply"],
		text = (L["%s takes the string's settings in the parts ticked: %s. The rest stays as it is, and Undo puts it back."]):format(
			P.Label(P.Active()), count(n, L["1 setting"], L["%d settings"])),
		onAccept = function()
			if not preview then return end
			local ok, u = quietly(P.Apply, preview, P.Active(), importPick)
			if ok then
				finishImport((L["Applied to %s: %s."]):format(P.Label(P.Active()), count(u.count, L["1 setting changed"], L["%d settings changed"])), u)
			else
				importError = u
				relayout()
			end
		end })
end

-- The last import taken back: the profile in use as it was, or the profile
-- it made gone and the one before back in use.
function PV.Undo()
	local u = undo
	if not u then return end
	local P = Profiles()
	local ok, why = quietly(P.Undo, u)
	undo, selected = nil, nil
	if ok and u.made then
		importDone, importError = (L["Undone: %s is gone and %s is in use again."]):format(P.Label(u.made), P.Label(P.Active())), nil
	elseif ok then
		importDone, importError = (L["Undone: %s is as it was."]):format(P.Label(u.profile)), nil
	else
		importDone, importError = nil, why
	end
	relayout()
end

---------------------------------------------------------------------------
-- A profile's card: a small picture of its look drawn from its own values
-- by the look code the elements themselves use (the skin's guide window as
-- the skin picker draws it, in the profile's colours; the arrow's dial; the
-- map's target pin); the profile in use from the live settings. Drawn again
-- at every layout, so the card of the profile in use follows its settings.
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

-- The window: the profile's skin's guide window in its own colours. -> the palette it drew with
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
		if UI.SkinWindow then UI.SkinWindow(win, skin) end
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
-- hairline between the halves of its rows (a checklist's lines have their own).
local function newCard(parent, title)
	local c = W.SectionCard(parent)
	c:SetTitle(title)
	c.Count = W.Text(c.Header, "number", "textMuted")
	c.Count:SetPoint("LEFT", c.Title, "RIGHT", 8, 0)
	c.Count:Hide()
	c.Split = W.Divider(c, true)
	c.Split:Hide()
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
-- refused, an i for a warning or a note) and a note beside it.
local STATUS = { success = "check", danger = "close", warning = "info", info = "info" }
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

local function profileChoices()
	local P = Profiles()
	local out = {}
	for i, name in ipairs(P.List()) do out[i] = { value = name, text = P.Label(name) } end
	return out
end

local layoutProfiles, layoutShare

-- The view's loose text (labels, notes and warnings placed by the layout)
-- stands on a layer of its own over the section cards, whose grounds would
-- otherwise cover text drawn on the view itself.
local function overlay(v)
	local top = rawget(v, "TextLayer")
	if top then return top end
	top = CreateFrame("Frame", nil, v)
	top:SetAllPoints(v)
	top:SetFrameLevel(v:GetFrameLevel() + 6)
	v.TextLayer = top
	return top
end

---------------------------------------------------------------------------
-- Share's checklists: a row per category (P.CATEGORIES) on Make a string
-- and on Import, the quick picks in the card's header, and the open row's
-- list under it.
---------------------------------------------------------------------------

-- A category's row: its box (ticked: it goes in, or it is taken), its
-- name, what it holds at the right and a chevron (down while its list is
-- open); what it holds says the tooltip. A click on the box ticks it,
-- anywhere else opens or folds the list. With a gamepad the box is a stop
-- of its own after its row (the settings window's inline extras).
local function partRow(v, side, c)
	local R = W.RowParts
	local row = R.settingRow(v, c.label, c.help)
	row.psId = c.id
	row.Box = W.Checkbox(row, function(box) PV.Tick(side, c.id, box:GetChecked()) end)
	row.Box:SetPoint("LEFT", row, "LEFT", PAD, 0)
	row.psExtras = { row.Box }
	row.Label:ClearAllPoints()
	row.Label:SetPoint("LEFT", row.Box, "RIGHT", 10, 0)
	row.Label:SetWordWrap(false)
	row.Chevron = W.Tex(row, "ARTWORK", "chevron-right", "textDim")
	row.Chevron:SetSize(12, 12)
	row.Chevron:SetPoint("RIGHT", row, "RIGHT", -PAD, 0)
	row.Count = W.Text(row, "label", "textMuted")
	row.Count:SetJustifyH("RIGHT")
	row.Count:SetPoint("RIGHT", row.Chevron, "LEFT", -8, 0)
	row:SetScript("OnClick", function() PV.Open(side, c.id) end)
	row:SetScript("OnEnter", W.RowEnter)
	row:SetScript("OnLeave", R.hideTip)
	row:Hide()
	return row
end

local function partRows(v, side)
	local out = {}
	for _, c in ipairs(Profiles().CATEGORIES or {}) do out[c.id] = partRow(v, side, c) end
	return out
end

-- A line of an open list on the view's text layer: the setting's name,
-- then its value (on Import: yours, a chevron, theirs).
local function listLine(v)
	local f = CreateFrame("Frame", nil, overlay(v))
	f:SetHeight(LINE)
	f.Name = W.Text(f, "label", "textDim")
	f.Was = W.Text(f, "label", "textMuted")
	f.Now = W.Text(f, "label", "text")
	for _, fs in ipairs({ f.Name, f.Was, f.Now }) do
		fs:SetWordWrap(false)
		fs:SetJustifyH("LEFT")
	end
	f.Arrow = W.Tex(f, "ARTWORK", "chevron-right", "textMuted")
	f.Arrow:SetSize(9, 9)
	return f
end

-- The quick picks, right to left at the header's right edge: every
-- category, none, the skin alone, the skin and the fonts.
local PICKS = {
	{ L["All"], L["Tick every part."] },
	{ L["None"], L["Untick every part."], {} },
	{ L["Skin only"], L["Only Skin & colours."], { skin = true } },
	{ L["Skin & fonts"], L["Skin & colours and Fonts & text size."], { skin = true, fonts = true } },
}

local function pickButtons(card, side)
	local out = {}
	for i, p in ipairs(PICKS) do
		local b = W.Button(card.Header, p[1], function() PV.Pick(side, p[3]) end, { ghost = true, height = 22 })
		b.psTight = true
		W.SetButtonText(b, p[1])
		b.psTip, b.psTipLines = p[1], { p[2] }
		b:Hide()
		out[i] = b
	end
	return out
end

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
	-- Its key: a click, then the key (or gamepad button) that switches to it;
	-- right-click takes the key away.
	v.Key = W.Button(v, "", function(self, button)
		local name = current()
		if button == "RightButton" then
			Profiles().SetKey(name, nil)
		elseif PV.capturing then
			ns.Gamepad.StopCapture(nil)
		else
			PV.CaptureKey(name)
		end
	end, { height = 24 })
	v.Key:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	v.Key.psTip = L["Its key"]
	v.Key.psTipLines = { L["Click, then press the key (or gamepad button) that switches to this profile; right-click takes it away. It works out of combat."] }
	v.Delete = W.Button(v, L["Delete"], nil, { danger = true, height = 24 })
	v.Delete.psTip = L["Delete this profile (asks first)."]
	v.Delete.psSetText = function(self, label)
		W.SetButtonText(self, label)
		self:ClearAllPoints()
		self:SetPoint("RIGHT", v, "TOPLEFT", (v.psActionsRight or 0), -(v.psActionsY or 0))
	end
	W.Confirm(v.Delete, L["Delete"], function() PV.Delete(current()) end)
	-- The name editor, in place of the actions.
	v.NameLabel = W.Text(overlay(v), "body", "rowLabel")
	v.NameLabel:SetWordWrap(false)
	v.NameBox = field(v, function() PV.CommitEdit() end)
	v.NameOK = W.Button(v, "", function() PV.CommitEdit() end, { primary = true, height = 24 })
	v.NameCancel = W.Button(v, L["Cancel"], function() PV.CancelEdit() end, { height = 24 })
	v.NameError = text(overlay(v), "note", "warning")
	v.Refresh = function() return layoutProfiles(v) end
end

local function buildShare(v)
	v.MakeCard = newCard(v, L["Make a string"])
	v.ImportCard = newCard(v, L["Import"])
	v.ExportPicks = pickButtons(v.MakeCard, "export")
	v.ImportPicks = pickButtons(v.ImportCard, "import")

	v.From = W.Dropdown(v, L["From"], nil, profileChoices, L["The profile the string is made of."], nil, { get = source, set = function(name)
		shareFrom = name
		if exported then PV.Export() else relayout() end
	end })
	W.CompactRow(v.From)
	v.ExportRows = partRows(v, "export")
	v.ExportList = {}
	v.ExportNote = statusLine(v)
	v.CopyBox = W.CopyBox(v, { lines = 3 })
	v.Made = statusLine(v)
	v.ExportButton = W.Button(v, L["Make a string"], function() PV.Export() end, { primary = true, height = 24 })
	v.ExportButton.psTip = L["A line of text holding the parts ticked above, from the profile chosen, to paste anywhere."]

	v.PasteBox = pasteBox(v)
	v.Status = statusLine(v)
	v.ImportRows = partRows(v, "import")
	v.ImportList = {}
	v.Screen = text(overlay(v), "note", "warning")
	v.Dropped = text(overlay(v), "note", "warning")
	v.ImportNameLabel = W.Text(overlay(v), "body", "rowLabel")
	v.ImportNameLabel:SetText(L["Name"])
	v.ImportName = field(v, function() PV.ImportNew() end)
	v.ImportNew = W.Button(v, L["Import as new"], function() PV.ImportNew() end, { primary = true, height = 24 })
	v.ImportNew.psTip = L["A new profile with the string's settings in the parts ticked, every other setting at its default. Polestar switches to it."]
	v.ImportHere = W.Button(v, L["Apply to current"], function() PV.ImportHere() end, { height = 24 })
	v.ImportHere.psTip = L["The string's settings in the parts ticked into the profile in use; everything else stays as it is. Asks first."]
	v.ImportCancel = W.Button(v, L["Clear"], function() PV.ClearImport() end, { ghost = true, height = 24 })
	v.ImportCancel.psTip = L["Empty the box."]
	v.ImportError = text(overlay(v), "note", "warning")
	v.Done = statusLine(v)
	v.UndoButton = W.Button(v, L["Undo"], function() PV.Undo() end, { ghost = true, height = 24 })
	v.UndoButton.psTight = true
	W.SetButtonText(v.UndoButton, L["Undo"])
	W.Color(v.UndoButton.Label, "accent")
	v.UndoButton.psTip, v.UndoButton.psTipLines = L["Undo"], { L["Puts back what that import changed."] }
	v.UndoButton:Hide()
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

-- A status line (statusLine): `kind` "success" | "danger" | "warning" | "info" puts its glyph before the text. -> y under it
local function status(v, s, msg, kind, width, x, y)
	s:SetShown(msg ~= nil)
	if not msg then return y end
	local glyph = STATUS[kind]
	s.Icon:SetShown(glyph ~= nil)
	if glyph then
		s.Icon:SetTexture(Theme.Media(glyph))
		W.Color(s.Icon, kind == "info" and "textMuted" or kind)
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
	local key = P.Key and P.Key(name)
	W.SetButtonText(v.Key, PV.capturing == name and L["Press a key..."] or key and (L["Key: %s"]):format(keyName(key)) or L["Set a key"])
	v.Key:SetShown(P.SetKey ~= nil)
	v.Delete:SetShown(not fixed and not active)
	-- A Delete armed for another profile is not this one's.
	if v.psActionsFor ~= name then
		v.psActionsFor = name
		v.Delete.psArmed = nil
		W.SetButtonText(v.Delete, L["Delete"])
	end
	local left = x + PAD
	for _, b in ipairs({ v.Use, v.Copy, v.Rename, v.Key }) do
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
	for _, b in ipairs({ v.Use, v.Copy, v.Rename, v.Key, v.Delete }) do b:SetShown(not editing) end
	for _, r in ipairs({ v.NameLabel, v.NameBox, v.NameOK, v.NameCancel }) do r:SetShown(editing) end
	if editing then placeEditor(v, P, x, y, width) else placeActions(v, P, name, x, y, width) end
	y = y + ROW
	y = line(v, v.NameError, editorError or keyNote, width, x, y)
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

-- The quick picks in a card's header while it has a checklist.
local function placePicks(card, list, shown)
	local right = -PAD
	for i = #list, 1, -1 do
		local b = list[i]
		b:SetShown(shown)
		b:ClearAllPoints()
		b:SetPoint("RIGHT", card.Header, "RIGHT", right, 0)
		right = right - b:GetWidth() - 2
	end
end

-- A checklist's row at (x, y), `w` wide. e = { count, ticked, enabled, open }
local function setPartRow(v, row, e, x, y, w)
	row:SetSize(w, ROW)
	row.Count:SetText(e.count or "")
	local right = PAD + 12 + 8 + math.ceil(W.TextWidth(row.Count)) + 12
	row.Label:SetWidth(max(20, w - PAD - row.Box:GetWidth() - 10 - right))
	row.Box:SetChecked(e.ticked and true or false)
	row.Box:SetEnabled(e.enabled ~= false)
	row:SetAlpha(e.enabled == false and 0.45 or 1)
	row.Chevron:SetTexture(Theme.Media(e.open and "chevron-down" or "chevron-right"))
	row.psOpen = e.open and true or nil
	place(v, row, x, y)
	row:Show()
end

-- The lines of an open list: each setting's name (where it sits after it
-- when two share a name) and values(path) -> yours, theirs (or nil, its
-- value), by name.
local function listItems(paths, values)
	local P = Profiles()
	local items, names = {}, {}
	for i, path in ipairs(paths) do
		local label, where = P.LabelOf(path)
		local was, now = values(path)
		items[i] = { path = path, label = label, where = where, was = was, now = now }
		names[label] = (names[label] or 0) + 1
	end
	for _, it in ipairs(items) do
		it.name = names[it.label] > 1 and it.where and (L["%s (%s)"]):format(it.label, it.where) or it.label
	end
	table.sort(items, function(a, b)
		if a.name ~= b.name then return a.name < b.name end
		return a.path < b.path
	end)
	return items
end

-- An open list under its row's line, across the card: a line a setting
-- (on Import: its name, yours, a chevron and theirs), the rest counted; an
-- item with a note alone says it across the line. -> y under it
local function layoutList(v, pool, items, compare, x, y, width)
	local w = width - 2 * PAD
	local wasX = floor(w * 0.44)
	local nowX = compare and floor(w * 0.72) or wasX
	local shown = min(#items, LIST_MAX)
	local n = shown + (#items > shown and 1 or 0)
	y = y + 6
	for i = 1, n do
		local f = pool[i]
		if not f then
			f = listLine(v)
			pool[i] = f
		end
		f:SetWidth(w)
		f.Name:ClearAllPoints()
		f.Name:SetPoint("LEFT", f, "LEFT", 28, 0)
		local item = items[i]
		local values = i <= shown and not item.note
		if not values then
			f.Name:SetWidth(w - 28)
			f.Name:SetText(item and item.note or (L["and %d more"]):format(#items - shown))
		else
			f.Name:SetWidth(max(20, wasX - 28 - 12))
			f.Name:SetText(item.name)
			f.Now:ClearAllPoints()
			f.Now:SetPoint("LEFT", f, "LEFT", nowX, 0)
			f.Now:SetWidth(max(20, w - nowX))
			f.Now:SetText(item.now)
			if compare then
				f.Was:ClearAllPoints()
				f.Was:SetPoint("LEFT", f, "LEFT", wasX, 0)
				f.Was:SetWidth(max(20, nowX - wasX - 24))
				f.Was:SetText(item.was)
				f.Arrow:ClearAllPoints()
				f.Arrow:SetPoint("RIGHT", f, "LEFT", nowX - 8, 0)
			end
		end
		f.Now:SetShown(values)
		f.Was:SetShown(compare and values)
		f.Arrow:SetShown(compare and values)
		place(v, f, x + PAD, y)
		f:Show()
		y = y + LINE
	end
	for i = n + 1, #pool do pool[i]:Hide() end
	return y + 6
end

-- A checklist: its rows in two halves (stacked below STACK_BELOW), each
-- line's halves split by a hairline, the open row's list under its line.
-- entries: { { row, count, ticked, enabled, open }, ... }; rows not listed
-- stay hidden. -> y
local function layoutChecklist(v, card, entries, pool, items, compare, x, y, width)
	local two = width >= STACK_BELOW
	local half = two and floor((width - 1) / 2) or width
	local per = two and 2 or 1
	card.psSplits = card.psSplits or {}
	local splits, used, listed = card.psSplits, 0, false
	for i = 1, #entries, per do
		local top, open = y, false
		for k = 0, per - 1 do
			local e = entries[i + k]
			if e then
				setPartRow(v, e.row, e, x + k * (half + 1), y, half)
				open = open or e.open
			end
		end
		y = y + ROW
		if two then
			used = used + 1
			local s = splits[used]
			if not s then
				s = W.Divider(card, true)
				splits[used] = s
			end
			s:ClearAllPoints()
			s:SetPoint("TOPLEFT", v, "TOPLEFT", x + half, -top)
			s:SetHeight(ROW)
			s:Show()
		end
		if open and items then
			y = layoutList(v, pool, items, compare, x, y, width)
			listed = true
		end
	end
	for i = used + 1, #splits do splits[i]:Hide() end
	if not listed then for _, f in ipairs(pool) do f:Hide() end end
	return y
end

-- A checklist put away: its rows, hairlines and list.
local function hideChecklist(card, rows, pool)
	for _, row in pairs(rows) do row:Hide() end
	for _, s in ipairs(card.psSplits or {}) do s:Hide() end
	for _, f in ipairs(pool) do f:Hide() end
end

-- Make a string: the profile it is made of, a checklist of the categories
-- (how many of its settings off their defaults each holds, and which),
-- the word on positions while they stay out, the string once made, its
-- line and the button.
local function layoutMake(v, P, x, y, width)
	local card = v.MakeCard
	y = openCard(card, nil, nil, x, y)
	placePicks(card, v.ExportPicks, true)
	y = halves(v, card.Split, { v.From, false }, x, y, width)
	local mine = P.Portable(source()) or {}
	local by = {}
	for path in pairs(mine) do
		local id = P.CategoryOf(path)
		if id then
			by[id] = by[id] or {}
			by[id][#by[id] + 1] = path
		end
	end
	local entries = {}
	for _, c in ipairs(P.CATEGORIES) do
		local n = by[c.id] and #by[c.id] or 0
		entries[#entries + 1] = { row = v.ExportRows[c.id], ticked = exportPick[c.id], open = exportOpen == c.id,
			count = n > 0 and count(n, L["1 setting"], L["%d settings"]) or L["At defaults"] }
	end
	local items = exportOpen and listItems(by[exportOpen] or {}, function(path) return nil, P.ValueText(path, mine[path]) end)
	if items and #items == 0 then items = { { note = L["Every setting here is at its default, so taking this part puts the defaults back."] } } end
	y = layoutChecklist(v, card, entries, v.ExportList, items, false, x, y, width)
	y = status(v, v.ExportNote, not exportPick.positions and L["Window positions stay out unless you tick them: on another screen, frames you dragged can land in odd places."] or nil,
		"info", width, x, y)
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
			msg, kind = L["No settings in it: the parts ticked are at their defaults, so taking it puts the defaults back."], "warning"
		else
			msg, kind = (L["%s of %s. Selected for you: copy it with Ctrl+C, then share it anywhere."]):format(
				count(exportedCount, L["1 setting"], L["%d settings"]), P.Label(exportedFrom)), "success"
		end
	elseif exportError then
		msg, kind = exportError, "danger"
	else
		msg = L["Tick the parts to share and pick the profile, then make the string."]
	end
	local bw = v.ExportButton:GetWidth()
	local top = y
	y = status(v, v.Made, msg, kind, width - bw - 16, x, y)
	v.ExportButton:ClearAllPoints()
	v.ExportButton:SetPoint("RIGHT", v, "TOPLEFT", x + width - PAD, -(top + ROW / 2))
	y = max(y, top + ROW)
	return closeCard(card, x, y, width)
end

-- Import: the paste box, then whose it is, a checklist of the categories it
-- holds (what each changes, yours then theirs) and the ways in; the line
-- the last import left, with its Undo.
local function layoutImport(v, P, x, y, width)
	local card = v.ImportCard
	y = openCard(card, nil, nil, x, y)
	local has = preview ~= nil
	placePicks(card, v.ImportPicks, has)
	v.PasteBox:SetWidth(width - 2 * PAD)
	place(v, v.PasteBox, x + PAD, y + 12)
	y = y + 12 + v.PasteBox:GetHeight()
	hideChecklist(card, v.ImportRows, v.ImportList)
	if has then
		local list = P.Changes(preview)
		local by = changesBy(list)
		local n = #list
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
		local entries = {}
		for _, id in ipairs(preview.order) do
			local k = by[id] and #by[id] or 0
			local can = takeable(id, by)
			if not can then importPick[id] = false end
			entries[#entries + 1] = { row = v.ImportRows[id], ticked = importPick[id], enabled = can, open = importOpen == id,
				count = k > 0 and count(k, L["1 change"], L["%d changes"]) or L["Same as yours"] }
		end
		local items
		if importOpen then
			local theirs, paths = {}, {}
			for i, ch in ipairs(by[importOpen] or {}) do
				paths[i] = ch.path
				theirs[ch.path] = ch.theirs
			end
			items = listItems(paths, function(path) return P.ValueText(path, ns.Get(path)), P.ValueText(path, theirs[path]) end)
			if #items == 0 then items = { { note = L["Nothing here differs from yours."] } } end
		end
		y = layoutChecklist(v, card, entries, v.ImportList, items, true, x, y, width)
		y = line(v, v.Screen, preview.otherScreen and L["The positions were made on another screen or UI scale, so Window positions starts unticked: tick it to take them anyway."] or nil,
			width, x, y)
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
		for _, fs in ipairs({ v.Screen, v.Dropped }) do fs:Hide() end
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
	-- What the last import did, its Undo at the right.
	local canUndo = undo ~= nil and importDone ~= nil
	v.UndoButton:SetShown(canUndo)
	local top = y
	y = status(v, v.Done, importDone, "success", width - (canUndo and v.UndoButton:GetWidth() + 16 or 0), x, y)
	if canUndo then
		v.UndoButton:ClearAllPoints()
		v.UndoButton:SetPoint("RIGHT", v, "TOPLEFT", x + width - PAD, -(top + ROW / 2))
		y = max(y, top + ROW)
	end
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
		-- A checklist's rows on screen: { id, label, count, ticked, enabled, open }.
		local function parts(rows)
			local list = {}
			for _, c in ipairs(Profiles().CATEGORIES or {}) do
				local row = rows[c.id]
				if row and row:IsShown() then
					list[#list + 1] = { id = c.id, label = row.Label:GetText(), count = row.Count:GetText(), ticked = row.Box:GetChecked() and true or false,
						enabled = row.Box:IsEnabled() and true or false, open = row.psOpen or false }
				end
			end
			return list
		end
		-- An open list's lines on screen: "name: value" or "name: yours > theirs".
		local function lines(pool)
			local list = {}
			for _, f in ipairs(pool) do
				if f:IsShown() then
					local t = f.Name:GetText()
					if f.Now:IsShown() then t = t .. ": " .. (f.Was:IsShown() and f.Was:GetText() .. " > " or "") .. f.Now:GetText() end
					list[#list + 1] = t
				end
			end
			return list
		end
		out.from = s.From.Button.Label:GetText()
		out.exported = exported
		out.exportParts, out.exportList = parts(s.ExportRows), lines(s.ExportList)
		out.note = s.ExportNote:IsShown() and s.ExportNote.Text:GetText() or nil
		out.copyNote = s.Made:IsShown() and s.Made.Text:GetText() or nil
		out.preview = s.Status:IsShown() and not refusal and s.Status.Text:GetText() or nil
		out.importParts, out.importList = parts(s.ImportRows), lines(s.ImportList)
		out.picks = s.ImportPicks[1]:IsShown()
		out.screen = s.Screen:IsShown() and s.Screen:GetText() or nil
		out.dropped = s.Dropped:IsShown() and s.Dropped:GetText() or nil
		out.refusal = s.Status:IsShown() and refusal and s.Status.Text:GetText() or nil
		out.done = s.Done:IsShown() and s.Done.Text:GetText() or nil
		out.undo = s.UndoButton:IsShown()
		out.importName = s.ImportName:IsShown() and s.ImportName:GetText() or nil
	end
	return out
end

local function changed()
	if busy then return end
	for _, v in pairs(views) do
		if v:IsVisible() then return relayout() end
		v.psDirty = true
	end
end
ns.On("PROFILES_CHANGED", changed)
-- The card of the profile in use follows its settings; every card is drawn
-- again after the theme's repaint (a new UI scale too), which hides the
-- game looks' and a skin's own pieces on their windows until then.
ns.On("SETTING_CHANGED", changed)
if Theme.OnChanged then Theme.OnChanged(changed) end

ns.RegisterOptions({ page = PAGE, key = "profiles", icon = "layers", order = 64, group = "setup", new = "0.3.8", tab = PROFILES,
	subtitle = L["Named sets of settings: one per character, class or the whole account, and strings to share them."],
	search = L["profile, profiles, export, import, share, string, copy settings, backup, per character, alts, class, switch, rename, delete"],
	custom = PV.Build, controls = {} })
ns.RegisterOptions({ page = PAGE, key = "profiles", tab = SHARE, controls = {} })
