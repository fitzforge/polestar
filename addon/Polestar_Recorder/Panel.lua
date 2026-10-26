-- The Recorder window (/psrec ui, Polestar's Options > Recorder and its
-- guide menu): recording on/off, the position trail (label, Start/Stop,
-- elapsed time, points, distance, the auto-stop countdown), a mark at the
-- player's position, the spots still to walk for the navigation checks
-- (Spots.lua, ticked when a trail with a spot's label stops; the ticks live
-- in PolestarRecorderDB.spots), this session's trails, and Save now (a
-- /reload, which makes the game write the recording to disk).
--
-- Drawn with Polestar's own theme and widgets when Polestar is loaded (its
-- `Polestar` global: Theme, Widgets), else with the game's templates.

local _, ns = ...
local L = ns.L

local type, ipairs, floor, max, min, format, GetTime = type, ipairs, math.floor, math.max, math.min, string.format, GetTime

local WIDTH = 360
local PAD = 16
local HEAD_H = 44
local ROWS = 6
local ROW_H = 20
local TRAILS_SHOWN = 4
local REFRESH = 0.5 -- seconds between live updates while shown

---------------------------------------------------------------------------
-- Spots
---------------------------------------------------------------------------

local function faction()
	local f = UnitFactionGroup and UnitFactionGroup("player")
	if f == "Alliance" or f == "Horde" then return f end
	return nil
end

local function doneSet()
	local s = ns.DB().spots
	return type(s) == "table" and s or nil
end

local function isDone(spot)
	local s = doneSet()
	return s and s[spot.id] and true or false
end

-- The player's faction's spots in tour order, then the rest by id.
local ordered, orderedFor
local function spots()
	local fac = faction()
	if ordered and orderedFor == fac then return ordered end
	local letter = fac == "Alliance" and "A" or fac == "Horde" and "H" or nil
	local byId, list, seen = {}, {}, {}
	for _, s in ipairs(ns.SPOTS or {}) do
		if s.fac == "N" or s.fac == "Both" or s.fac == letter or not letter then byId[s.id] = s end
	end
	for _, id in ipairs(fac and ns.SPOT_TOURS and ns.SPOT_TOURS[fac] or {}) do
		if byId[id] and not seen[id] then list[#list + 1] = byId[id]; seen[id] = true end
	end
	for _, s in ipairs(ns.SPOTS or {}) do
		if byId[s.id] and not seen[s.id] then list[#list + 1] = s; seen[s.id] = true end
	end
	ordered, orderedFor = list, fac
	return list
end

-- The next spot to walk: the first not done the player's level allows.
local function suggestion()
	local lvl = UnitLevel and UnitLevel("player") or 1
	local first
	for _, s in ipairs(spots()) do
		if not isDone(s) then
			if s.min <= lvl then return s end
			first = first or s
		end
	end
	return first
end

-- The spot a trail label names: its label exactly, or "#<id>" first.
local function spotOfLabel(label)
	if type(label) ~= "string" then return nil end
	local id = tonumber(label:match("^#(%d+)%f[^%d]") or "")
	for _, s in ipairs(ns.SPOTS or {}) do
		if s.label == label or s.id == id then return s end
	end
	return nil
end

ns.OnTrailStop(function(summary)
	local spot = spotOfLabel(summary.label)
	if not spot or summary.n < 1 then return end
	local db = ns.DB()
	if type(db.spots) ~= "table" then db.spots = {} end
	if not db.spots[spot.id] then
		db.spots[spot.id] = GetServerTime()
		ns.Print(L["spot done: %s"]:format(spot.label))
	end
end)

---------------------------------------------------------------------------
-- Looks: Polestar's theme when it is there, else the game's templates
---------------------------------------------------------------------------

local function polestar()
	local P = Polestar
	if type(P) == "table" and type(P.Theme) == "table" and type(P.Widgets) == "table"
		and P.Theme.Skin and P.Theme.Band and P.Widgets.Button and P.Widgets.Text then
		return P
	end
	return nil
end

local PLAIN = {
	text = { 1, 1, 1 }, textDim = { 0.78, 0.78, 0.78 }, textMuted = { 0.55, 0.55, 0.55 },
	accent = { 1, 0.82, 0 }, success = { 0.31, 0.82, 0.56 }, danger = { 0.82, 0.31, 0.31 }, warning = { 1, 0.6, 0.2 },
}
local PLAIN_FONT = { title = "GameFontNormalLarge", label = "GameFontNormal", body = "GameFontHighlight", note = "GameFontHighlightSmall", small = "GameFontHighlightSmall" }

local P -- Polestar, when it styles the window

local function color(fs, name)
	if P then return P.Widgets.Color(fs, name) end
	local c = PLAIN[name] or PLAIN.text
	fs:SetTextColor(c[1], c[2], c[3])
end

local function text(parent, role, colorName)
	local fs
	if P then
		fs = P.Widgets.Text(parent, role, colorName)
	else
		fs = parent:CreateFontString(nil, "OVERLAY", PLAIN_FONT[role] or "GameFontHighlight")
		fs:SetJustifyH("LEFT")
		color(fs, colorName or "text")
	end
	return fs
end

local function wrapText(parent, role, colorName, width)
	local fs = text(parent, role, colorName)
	fs:SetWidth(width)
	fs:SetWordWrap(true)
	fs:SetJustifyH("LEFT")
	fs:SetJustifyV("TOP")
	return fs
end

local function button(parent, label, onClick, width, height, primary)
	local b
	if P then
		b = P.Widgets.Button(parent, label, onClick, { width = width, height = height, primary = primary })
	else
		b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
		b:SetSize(width, height or 24)
		b:SetText(label)
		b:SetScript("OnClick", onClick)
	end
	return b
end

local function setButton(b, label)
	if P then P.Widgets.SetButtonText(b, label) else b:SetText(label) end
end

local function editBox(parent, width, onEnter)
	local e
	if P then
		e = CreateFrame("EditBox", nil, parent)
		P.Theme.Font(e, "label")
		P.Widgets.Color(e, "text")
		e:SetTextInsets(10, 10, 0, 0)
		P.Theme.Skin(e, "editbox")
		e:SetScript("OnEditFocusGained", function(self) P.Theme.SetFocused(self, true) end)
		e:SetScript("OnEditFocusLost", function(self) P.Theme.SetFocused(self, false) end)
	else
		e = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
		e:SetTextInsets(2, 2, 0, 0)
	end
	e:SetSize(width, 26)
	e:SetAutoFocus(false)
	e:SetMaxLetters(80)
	e:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	e:SetScript("OnEnterPressed", function(self)
		self:ClearFocus()
		if onEnter then onEnter() end
	end)
	return e
end

local function heading(parent, label)
	local fs = text(parent, "label", "accent")
	fs:SetText(label)
	return fs
end

local function checkTexture(parent)
	local t
	if P then
		t = P.Widgets.Tex(parent, "ARTWORK", "check", "success")
	else
		t = parent:CreateTexture(nil, "ARTWORK")
		t:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
	end
	t:SetSize(14, 14)
	return t
end

---------------------------------------------------------------------------
-- The window
---------------------------------------------------------------------------

local F
local state = { autoLabel = true, offset = 0, selected = nil, last = 0 }

local function clock(secs)
	secs = max(0, floor(secs + 0.5))
	return format("%d:%02d", floor(secs / 60), secs % 60)
end

local function trimmed(s) return ((s or ""):gsub("^%s+", ""):gsub("%s+$", "")) end

-- The label a trail started now takes (also for the key binding).
function ns.PanelLabel()
	if F then
		local t = trimmed(F.Label:GetText())
		if t ~= "" then return t end
	end
	local s = suggestion()
	return s and s.label or nil
end

local function savePosition()
	local p, _, rp, x, y = F:GetPoint(1)
	if p then ns.DB().panel = { p, rp, floor((x or 0) + 0.5), floor((y or 0) + 0.5) } end
end

local function restorePosition()
	F:ClearAllPoints()
	local pos = PolestarRecorderDB and PolestarRecorderDB.panel
	if type(pos) == "table" and type(pos[1]) == "string" then
		F:SetPoint(pos[1], UIParent, pos[2] or pos[1], pos[3] or 0, pos[4] or 0)
	else
		F:SetPoint("CENTER", UIParent, "CENTER", 300, 80)
	end
end

local refresh

local function selectSpot(spot)
	state.selected = spot
	state.autoLabel = false
	F.Label:SetText(spot.label)
	F.Label:ClearFocus()
	refresh()
end

local function build()
	P = polestar()
	F = CreateFrame("Frame", "PolestarRecorderPanel", UIParent, not P and "BackdropTemplate" or nil)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(WIDTH)
	F:Hide()
	local inner = WIDTH - PAD * 2

	-- Head: the title, dragged to move, and the close button.
	local head = CreateFrame("Frame", nil, F)
	head:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	head:SetHeight(HEAD_H)
	head:EnableMouse(true)
	head:RegisterForDrag("LeftButton")
	head:SetScript("OnDragStart", function() F:StartMoving() end)
	head:SetScript("OnDragStop", function()
		F:StopMovingOrSizing()
		savePosition()
	end)
	if P then
		P.Theme.Skin(F, "window")
		local band = P.Theme.Band(head, "BACKGROUND", -5)
		band:SetAllPoints(head)
		band:SetTexCoord(P.Theme.BandCoords(WIDTH - 2, HEAD_H))
		F.Close = P.Widgets.IconButton(head, "close", 28, L["Close"], function() F:Hide() end, 14)
		F.Close:SetPoint("RIGHT", head, "RIGHT", -8, 0)
	else
		F:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true, tileSize = 16, edgeSize = 16,
			insets = { left = 4, right = 4, top = 4, bottom = 4 },
		})
		F.Close = CreateFrame("Button", nil, head, "UIPanelCloseButton")
		F.Close:SetPoint("RIGHT", head, "RIGHT", -2, 0)
		F.Close:SetScript("OnClick", function() F:Hide() end)
	end
	local title = text(head, "title", "text")
	title:SetPoint("LEFT", head, "LEFT", PAD, 0)
	title:SetText(L["Polestar Recorder"])

	local y = HEAD_H + 10
	local function place(region, x, h)
		region:SetPoint("TOPLEFT", F, "TOPLEFT", PAD + (x or 0), -y)
		y = y + (h or 0)
	end

	-- Recording on/off.
	F.Status = text(F, "body", "text")
	F.Toggle = button(F, L["Start recording"], function()
		PolestarRecorder_Command(ns.IsEnabled() and "off" or "on")
	end, 140, 26)
	F.Toggle:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD, -y)
	place(F.Status, 0, 0)
	F.Status:SetPoint("RIGHT", F.Toggle, "LEFT", -8, 0)
	F.Status:SetHeight(26)
	y = y + 38

	-- Trail.
	place(heading(F, L["Trail"]), 0, 20)
	F.Label = editBox(F, inner, function() PolestarRecorder_Command("trail toggle") end)
	F.Label:SetScript("OnTextChanged", function(_, user) if user then state.autoLabel = false end end)
	place(F.Label, 0, 32)
	F.Start = button(F, L["Start trail"], function()
		F.Label:ClearFocus()
		PolestarRecorder_Command("trail toggle")
	end, inner, 34, true)
	place(F.Start, 0, 40)
	F.Info = text(F, "note", "textDim")
	F.Info:SetWidth(inner)
	place(F.Info, 0, 24)

	-- Mark.
	place(heading(F, L["Mark"]), 0, 20)
	local function mark()
		local t = trimmed(F.MarkText:GetText())
		if t == "" then t = L["here"] end
		PolestarRecorder_Command("mark " .. t)
		F.MarkText:SetText("")
	end
	F.MarkText = editBox(F, inner - 118, mark)
	place(F.MarkText, 0, 0)
	F.Mark = button(F, L["Mark here"], mark, 110, 26)
	F.Mark:SetPoint("TOPRIGHT", F, "TOPRIGHT", -PAD, -y)
	y = y + 38

	-- Spots: a list scrolled by the mouse wheel, then the chosen spot's text.
	F.SpotsHead = heading(F, L["Spots"])
	place(F.SpotsHead, 0, 22)
	local list = CreateFrame("Frame", nil, F)
	list:SetSize(inner, ROWS * ROW_H)
	place(list, 0, ROWS * ROW_H + 6)
	list:EnableMouseWheel(true)
	list:SetScript("OnMouseWheel", function(_, delta)
		state.offset = max(0, min(#spots() - ROWS, state.offset - delta))
		refresh()
	end)
	F.Rows = {}
	for i = 1, ROWS do
		local r = CreateFrame("Button", nil, list)
		r:SetSize(inner, ROW_H)
		r:SetPoint("TOPLEFT", list, "TOPLEFT", 0, -(i - 1) * ROW_H)
		if P then P.Widgets.Hover(r) else r:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD") end
		r.Check = checkTexture(r)
		r.Check:SetPoint("LEFT", r, "LEFT", 2, 0)
		r.Text = text(r, "body", "text")
		r.Text:SetPoint("LEFT", r, "LEFT", 22, 0)
		r.Text:SetPoint("RIGHT", r, "RIGHT", -40, 0)
		r.Text:SetWordWrap(false)
		r.Level = text(r, "note", "textMuted")
		r.Level:SetPoint("RIGHT", r, "RIGHT", -4, 0)
		r:SetScript("OnClick", function(self) if self.spot then selectSpot(self.spot) end end)
		F.Rows[i] = r
	end
	F.Spot = wrapText(F, "note", "text", inner)
	F.Spot:SetSpacing(2)
	place(F.Spot, 0, 84)
	F.Spot:SetHeight(80)

	-- This session's trails.
	place(heading(F, L["This session's trails"]), 0, 20)
	F.Trails = {}
	for i = 1, TRAILS_SHOWN do
		local fs = text(F, "note", "textDim")
		fs:SetWidth(inner)
		fs:SetWordWrap(false)
		place(fs, 0, 16)
		F.Trails[i] = fs
	end
	y = y + 10

	-- Save now.
	F.Save = button(F, L["Save now"], function()
		ns.Print(L["saving: the interface reloads and the game writes the recording to disk"])
		ReloadUI()
	end, 110, 26)
	place(F.Save, 0, 0)
	F.SaveNote = wrapText(F, "small", "textMuted", inner - 120)
	F.SaveNote:SetPoint("LEFT", F.Save, "RIGHT", 10, 0)
	F.SaveNote:SetText(L["Reloads the interface (a few seconds) so the recording is on disk."])
	y = y + 26 + PAD
	F:SetHeight(y)

	F:SetScript("OnUpdate", function()
		local now = GetTime()
		if now - state.last >= REFRESH then refresh() end
	end)
	F:SetScript("OnShow", function() refresh() end)
	-- Escape closes it; not with the gamepad interface (its focus owns the
	-- window list), as Polestar's own windows.
	if P and P.CloseOnEscape then
		P.CloseOnEscape("PolestarRecorderPanel")
	elseif not ns.GamepadUI() then
		local list = UISpecialFrames
		if list then list[#list + 1] = "PolestarRecorderPanel" end
	end
	restorePosition()
end

refresh = function()
	if not (F and F:IsShown()) then return end
	state.last = GetTime()
	local on = ns.IsEnabled()
	F.Status:SetText(on and L["Recording"] or L["Recording is off"])
	color(F.Status, on and "success" or "textDim")
	setButton(F.Toggle, on and L["Stop recording"] or L["Start recording"])

	local tr = ns.Trail()
	local nextSpot = suggestion()
	if state.autoLabel and not tr then
		state.selected = nextSpot
		if not F.Label:HasFocus() then F.Label:SetText(nextSpot and nextSpot.label or "") end
	end
	setButton(F.Start, tr and L["Stop trail"] or L["Start trail"])
	if tr then
		local elapsed = GetTime() - tr.started
		F.Info:SetText(L["%s  ·  %d points  ·  %d yd  ·  stops in %s"]:format(
			clock(elapsed), tr.n, floor(tr.yards + 0.5), clock(ns.TRAIL_MAX_MINUTES * 60 - elapsed)))
		color(F.Info, "success")
	else
		F.Info:SetText(on and L["No trail running. Pick a spot or type a label, then Start trail."] or L["Turn recording on to start a trail."])
		color(F.Info, "textDim")
	end
	if F.Start.SetEnabled then F.Start:SetEnabled(on or tr ~= nil) end
	if F.Mark.SetEnabled then F.Mark:SetEnabled(on) end

	local list = spots()
	local done = 0
	for _, s in ipairs(list) do if isDone(s) then done = done + 1 end end
	F.SpotsHead:SetText(L["Spots"] .. format("  %d/%d", done, #list))
	state.offset = max(0, min(state.offset, #list - ROWS))
	local lvl = UnitLevel and UnitLevel("player") or 1
	for i, r in ipairs(F.Rows) do
		local s = list[state.offset + i]
		r.spot = s
		if s then
			local d = isDone(s)
			r.Check:SetShown(d)
			r.Text:SetText(s.label)
			color(r.Text, d and "textMuted" or (s == state.selected and "accent") or (s.min > lvl and "textDim") or "text")
			r.Level:SetText(L["lvl %d"]:format(s.min))
			r:Show()
		else
			r:Hide()
		end
	end
	local sel = state.selected
	if sel then
		local lines = { sel.name, sel.zone .. "  ·  " .. L["level %d+"]:format(sel.min) }
		if sel.todo ~= "" then lines[#lines + 1] = sel.todo end
		if sel.why ~= "" then lines[#lines + 1] = "|cff8c8c8c" .. sel.why .. "|r" end
		F.Spot:SetText(table.concat(lines, "\n"))
	else
		F.Spot:SetText(L["Every spot is done."])
	end

	local hist = ns.TrailHistory()
	for i, fs in ipairs(F.Trails) do
		local h = hist[#hist - i + 1]
		if h then
			fs:SetText(L["%s: %d points, %s, %d yd"]:format(h.label or "?", h.n, clock(h.secs), h.yards))
		else
			fs:SetText(i == 1 and L["None yet."] or "")
		end
	end
end

function ns.RefreshPanel() refresh() end

-- After a trail stops, the next spot fills the label again.
ns.OnTrailStop(function()
	state.autoLabel = true
	refresh()
end)

function ns.TogglePanel()
	if not F then build() end
	if F:IsShown() then F:Hide() else F:Show() end
end

-- Key bindings (Bindings.xml), listed after Polestar's own.
BINDING_NAME_POLESTAR_RECORDER_TRAIL = L["Recorder: start or stop the position trail"]
BINDING_NAME_POLESTAR_RECORDER_WINDOW = L["Recorder: show or hide the window"]
