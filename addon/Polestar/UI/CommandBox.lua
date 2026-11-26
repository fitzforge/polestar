-- The command box: a small window of Polestar's own to type Polestar's
-- commands in, for the game's gamepad interface, where no slash command is
-- registered (Core/Init.lua, ns.GamepadUI: the chat box calls a command and
-- closes itself in its taint, which blocks the gamepad's actions). It runs
-- ns.RunCommand, the function /polestar runs, from a box that is no part of
-- the game's chat: nothing here touches ChatFrame or ChatEdit.
--
-- What the box takes is what the player would type in chat, with or without
-- the slash: `next`, `/ps options`, `/polestar way 52 40`, `/way 52 40`
-- (/way is a /polestar command too), and the Recorder's `/psrec on`
-- (Polestar_Recorder's PolestarRecorder_Command, when it is loaded). Enter
-- runs it and the box closes, so the window a command opens takes the
-- gamepad; a word nothing answers to stays in the box, with the commands
-- that begin with what was typed under it. Escape closes the box, B too
-- (UI/Gamepad.lua): A on the box puts the keyboard in it, the D-pad moves to
-- Run and the ✕.
--
-- Opened from the minimap button's menu (gamepad interface only), the
-- Gamepad page of the settings, UI.ShowCommandBox(text) and SHOW_COMMAND_BOX.
-- Built on first use; colours are Theme tokens only.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local B = {}
UI.CommandBox = B

local WIDTH, PAD, HEAD_H = 420, 24, 56
local BOX_H, MATCH_LINES, LISTED = 30, 2, 8

-- The words that stand for Polestar's own commands and the Recorder's.
local POLESTAR = { polestar = true, pole = true, ps = true }
local RECORDER = { psrec = true, polestarrec = true }

-- A typed line -> "polestar" | "recorder", the command and its arguments
-- ("/ps next" and "next" are both polestar, "next").
function B.Parse(line)
	local text = (line or ""):match("^%s*/?%s*(.-)%s*$")
	local word, rest = text:match("^(%S*)%s*(.-)$")
	word = word:lower()
	if POLESTAR[word] then return "polestar", rest end
	if RECORDER[word] then return "recorder", rest end
	return "polestar", text
end

-- Does the Parse's command have an answer here?
function B.Known(kind, text)
	if kind == "recorder" then return type(_G.PolestarRecorder_Command) == "function" end
	return ns.HasCommand((text or ""):match("^(%S*)"))
end

-- Runs a typed line as /polestar (or /psrec) would. -> false when nothing
-- answers to its command word (nothing ran).
function B.Run(line)
	local kind, text = B.Parse(line)
	if not B.Known(kind, text) then return false end
	if kind == "recorder" then
		_G.PolestarRecorder_Command(text)
	else
		ns.RunCommand(text)
	end
	return true
end

-- The commands that begin with `word`, in /polestar help's order.
function B.Matches(word)
	local out = {}
	word = (word or ""):lower()
	for _, name in ipairs(ns.CommandNames()) do
		if word == "" or name:find(word, 1, true) == 1 then out[#out + 1] = name end
	end
	return out
end

local F

-- What stands under the box: the commands the first word begins, or that
-- nothing answers to it.
local function update()
	if not F then return end
	local line = F.Box:GetText() or ""
	local kind, text = B.Parse(line)
	local word = text:match("^(%S*)")
	local fs = F.Matches
	local function unknown(w)
		W.Color(fs, "danger")
		fs:SetText((L["Unknown command '%s'."]):format(w))
	end
	if text == "" and kind == "polestar" and line:match("^%s*/?%s*$") then
		W.Color(fs, "textMuted")
		fs:SetText(L["Type help to see every command."])
	elseif kind == "polestar" and text == word then
		-- Still typing the word: the commands it begins, else nothing answers to it.
		local names = B.Matches(word)
		if #names == 0 and not B.Known(kind, text) then return unknown(word) end
		local more = #names > LISTED
		while #names > LISTED do names[#names] = nil end
		W.Color(fs, "textMuted")
		fs:SetText(#names > 0 and (L["Commands: %s"]):format(table.concat(names, ", ") .. (more and ", …" or "")) or "")
	elseif not B.Known(kind, text) then
		unknown(kind == "recorder" and line:match("^%s*/?%s*(%S*)") or word)
	else
		fs:SetText("")
	end
end

local function submit()
	local line = F.Box:GetText() or ""
	if line:match("^%s*$") then return end
	local kind, text = B.Parse(line)
	if not B.Known(kind, text) then
		update()
		return
	end
	-- Closed first: the window the command opens takes the gamepad.
	F:Hide()
	B.Run(line)
end

local function build()
	F = CreateFrame("Frame", "PolestarCommandBox", ns.UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(WIDTH)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 120)
	F:Hide()
	Theme.Skin(F, "window")

	local head = CreateFrame("Frame", nil, F)
	head:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	head:SetHeight(HEAD_H)
	ns.DragWindow(head, F)
	F.Head = head
	F.Band = Theme.Band(head, "BACKGROUND", -5)
	F.Band:SetAllPoints(head)
	F.Band:SetTexCoord(Theme.BandCoords(WIDTH - 2, HEAD_H))
	W.Haze(head, { width = WIDTH * 0.9, height = HEAD_H })
	W.Rim(F, { width = WIDTH * 0.7 })
	F.Close = W.IconButton(head, "close", 28, L["Close"], function() F:Hide() end, 14)
	F.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -14)
	W.FrameClose(F, F.Close)
	F.Icon = head:CreateTexture(nil, "ARTWORK")
	F.Icon:SetTexture(Theme.Media("chevron-right"))
	F.Icon:SetSize(20, 20)
	F.Icon:SetPoint("LEFT", head, "LEFT", PAD - 2, 0)
	W.Color(F.Icon, "accent")
	F.Title = W.Text(head, "title", "text")
	F.Title:SetPoint("LEFT", F.Icon, "RIGHT", 10, 0)
	F.Title:SetPoint("RIGHT", F.Close, "LEFT", -8, 0)
	F.Title:SetJustifyH("LEFT")
	F.Title:SetWordWrap(false)
	F.Title:SetText(L["Run a command"])

	F.Hint = W.Text(F, "note", "textDim")
	F.Hint:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -(HEAD_H + 12))
	F.Hint:SetWidth(WIDTH - PAD * 2)
	F.Hint:SetJustifyH("LEFT")
	F.Hint:SetWordWrap(true)
	F.Hint:SetText(L["Type a command, such as next, options or way 52 40, and press Enter. Escape or B closes."])

	-- The box is the search box's well (the look's edit box), nothing of the chat's.
	local e = CreateFrame("EditBox", nil, F)
	F.Box = e
	e:SetHeight(BOX_H)
	e:SetWidth(WIDTH - PAD * 2)
	e:SetAutoFocus(false)
	e:SetMaxLetters(200)
	e:SetTextInsets(10, 10, 0, 0)
	Theme.Font(e, "label")
	W.Color(e, "text")
	Theme.Skin(e, "editbox")
	e:SetScript("OnEditFocusGained", function(self) Theme.SetFocused(self, true) end)
	e:SetScript("OnEditFocusLost", function(self) Theme.SetFocused(self, false) end)
	e:SetScript("OnEnterPressed", submit)
	e:SetScript("OnEscapePressed", function() F:Hide() end)
	e:SetScript("OnTextChanged", update)
	e:SetPoint("TOPLEFT", F.Hint, "BOTTOMLEFT", 0, -10)

	F.Matches = W.Text(F, "note", "textMuted")
	F.Matches:SetPoint("TOPLEFT", e, "BOTTOMLEFT", 2, -8)
	F.Matches:SetWidth(WIDTH - PAD * 2 - 4)
	F.Matches:SetJustifyH("LEFT")
	F.Matches:SetJustifyV("TOP")
	F.Matches:SetWordWrap(true)

	F.Run = W.Button(F, L["Run"], submit, { primary = true })
	F.Run:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -PAD, PAD)
	F:SetHeight(HEAD_H + 12 + F.Hint:GetStringHeight() + 10 + BOX_H + 8 + MATCH_LINES * 14 + 12 + F.Run:GetHeight() + PAD)

	F:SetScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.FAST, "out") end)
	ns.CloseOnEscape("PolestarCommandBox")
	-- A gamepad (UI/Gamepad.lua) starts on the box: A puts the keyboard in it,
	-- the D-pad goes on to Run and the ✕, B closes.
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(F, { rows = function() return { e, F.Run, F.Close } end })
	end
end

-- Opens the box with `text` in it (none: empty), the keyboard in it. A
-- hidden Polestar comes back, as for any window.
function UI.ShowCommandBox(text)
	if not F then build() end
	if ns.Hidden() then ns.SetHidden(false) end
	F:Show()
	F:Raise()
	F.Box:SetText(text or "")
	F.Box:SetFocus()
	update()
end

ns.On("SHOW_COMMAND_BOX", function(text) UI.ShowCommandBox(text) end)

-- For the tests: the window.
function B.Frame() return F end
