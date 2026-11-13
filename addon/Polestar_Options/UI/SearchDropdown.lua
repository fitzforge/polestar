-- The settings search's dropdown: as the player types in the header's search
-- box, a list opens right under it with the best of what the words find
-- (O.Matches, the search's own scoring). First the places they name, a page,
-- a tab or a section ("Go to page: Arrow"); then the best settings (an
-- inline one on its row when it matched better), eight rows in all at
-- most, each the setting's label (the words it matches lit)
-- over where it lives (Page · Tab); last "See all 12 results", the whole
-- results page. Nothing found: it says so, and the labels nearest the words
-- ("Did you mean:") are rows that search for them.
--
-- The page on screen stays until the player picks. A click on a row, or Up
-- and Down to light one and Enter: a setting opens on its page, its row
-- scrolled into view and lit (O.Jump); a place opens there (O.Go). Enter with
-- no row lit opens the results page, as See all does. Escape, Tab or a click
-- anywhere else closes the list (a second Escape leaves the box); Up or Down
-- opens it again. The box keeps the keyboard all along: the list never takes
-- it. With a gamepad the open list holds the D-pad (UI/Gamepad.lua): A picks,
-- B closes.
--
-- The list hangs under the box as the window's child (the Menu scale and the
-- window's moves carry it), over the page, on the panel skin as the menus
-- are, in the look's colours, opaque: every look draws it.

local ns = Polestar
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local O = UI.Options
local floor, max, ipairs = math.floor, math.max, ipairs

local D = {}
O.Dropdown = D

local ROWS = 8 -- places and settings together
local MIN_W = 300 -- the list's least width (the box is 180 wide in a narrow window)
local TWO, ONE, CAPTION = 40, 28, 22 -- a row of two lines, a row of one, a caption
local PAD, INSET = 6, 12 -- the list's top and bottom room; the text's inset
local PLACE = { page = L["Go to page: %s"], tab = L["Tab: %s"], section = L["Section: %s"] }

local win, box, list
local rows, items = {}, {}
local lit -- the row Up and Down lit (its index), nil for none
local typed = "" -- the words the list shows

-- A label with the words it matches lit: the label in textDim, those words in
-- text, the look's brighter ink.
local function marked(text)
	local spans = O.MatchSpans(text, typed)
	if #spans == 0 then return text end
	local open, out, at = "|c" .. Theme.Hex("text"), {}, 1
	for _, s in ipairs(spans) do
		out[#out + 1] = text:sub(at, s[1] - 1)
		out[#out + 1] = open .. text:sub(s[1], s[2]) .. "|r"
		at = s[2] + 1
	end
	out[#out + 1] = text:sub(at)
	return table.concat(out)
end

-- A row's text in the colours of the look in use (again on a theme change).
local function paint(r)
	local it = r.psItem
	if not it then return end
	if it.kind == "setting" then
		r.Text:SetText(marked(it.text))
	elseif PLACE[it.kind] then
		r.Text:SetText(PLACE[it.kind]:format(marked(it.text)))
	else
		r.Text:SetText(it.text)
	end
end

-- The lit row: the selected wash and an accent bar at its left edge, or the
-- game look's own lit row.
local function paintLit(r, on)
	r.Lit:SetShown(on)
	r.Bar:SetShown(on)
	if Theme.KitRowLit(r, on, nil, 4) then
		r.Lit:Hide()
		r.Bar:Hide()
	end
end

-- A row across the list: the hover wash under the pointer, a click picks it.
local function rowAt(i)
	local r = rows[i]
	if r then return r end
	r = CreateFrame("Button", nil, list)
	r:RegisterForClicks("LeftButtonUp")
	W.Hover(r)
	r.Lit = W.Tex(r, "BACKGROUND")
	r.Lit:SetAllPoints(r)
	W.Painter(r.Lit, function(t) t:SetVertexColor(Theme.Wash("selected")) end)
	r.Bar = W.Tex(r, "ARTWORK", nil, "accent")
	r.Bar:SetWidth(2)
	r.Bar:SetPoint("TOPLEFT", r, "TOPLEFT", 0, 0)
	r.Bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0)
	r.Text = W.Text(r, "label", "textDim")
	r.Where = W.Text(r, "small", "textMuted")
	W.Painter(r.Text, function() paint(r) end)
	r:SetScript("OnClick", function(self) D.Pick(self.psIndex) end)
	rows[i] = r
	return r
end

local function onMouseDown()
	if not (list:IsMouseOver() or box:IsMouseOver()) then D.Hide() end
end

local function build()
	list = CreateFrame("Frame", "PolestarOptionsMatches", win)
	list:SetFrameStrata("DIALOG")
	list:SetClampedToScreen(true)
	list:EnableMouse(true)
	-- The wheel stays with the list: the page under it does not scroll.
	list:EnableMouseWheel(true)
	list:SetScript("OnMouseWheel", function() end)
	-- Painted as the menus are (psMenu: a game look draws the menu's art, not
	-- the box of a card inside the window).
	list.psMenu = true
	Theme.Skin(list, "panel")
	-- Under whatever the look draws (a translucent tile, the client's menu
	-- art, a skin's paper or gradient), the look's menu ground at full
	-- strength, 3 in from the edge (inside the art's rounded rim): the page
	-- under the list never shows through its rows.
	list.Backing = W.Tex(list, "BACKGROUND", nil, nil, -8)
	list.Backing:SetPoint("TOPLEFT", list, "TOPLEFT", 3, -3)
	list.Backing:SetPoint("BOTTOMRIGHT", list, "BOTTOMRIGHT", -3, 3)
	W.Painter(list.Backing, function(t)
		local r, g, b = Theme.Color("menuBg")
		t:SetVertexColor(r, g, b, 1)
	end)
	list.None = W.Text(list, "small", "textMuted")
	list.Hint = W.Text(list, "small", "textMuted")
	list.Hint:SetText(L["Did you mean:"])
	list.Rule = W.Divider(list)
	-- Its rows are its own to the gamepad, not the window's.
	list.psPadSkip = true
	list:SetScript("OnShow", function() ns.RegisterEvent("GLOBAL_MOUSE_DOWN", onMouseDown) end)
	list:SetScript("OnHide", function()
		ns.UnregisterEvent("GLOBAL_MOUSE_DOWN", onMouseDown)
		lit = nil
	end)
	list:Hide()
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(list, {
			rows = function()
				local out = {}
				for i = 1, #items do out[i] = rows[i] end
				return out
			end,
			back = function() D.Hide() end,
		})
	end
end

-- The list's rows and captions from the top, its size.
local function layout()
	local width = max(MIN_W, floor(box:GetWidth() + 0.5))
	local y = PAD
	local function caption(fs, text)
		if text then fs:SetText(text) end
		fs:ClearAllPoints()
		fs:SetPoint("TOPLEFT", list, "TOPLEFT", INSET, -y)
		fs:SetPoint("TOPRIGHT", list, "TOPRIGHT", -INSET, -y)
		fs:SetHeight(CAPTION)
		fs:Show()
		y = y + CAPTION
	end
	list.None:Hide()
	list.Hint:Hide()
	list.Rule:Hide()
	if items.none then caption(list.None, string.format(L["No settings match \226\128\156%s\226\128\157."], typed)) end
	for i, it in ipairs(items) do
		if it.kind == "suggest" and i == 1 then caption(list.Hint) end
		if it.kind == "all" and i > 1 then
			-- A hairline over See all.
			list.Rule:ClearAllPoints()
			list.Rule:SetPoint("TOPLEFT", list, "TOPLEFT", 8, -(y + 3))
			list.Rule:SetPoint("TOPRIGHT", list, "TOPRIGHT", -8, -(y + 3))
			list.Rule:Show()
			y = y + 7
		end
		local r = rowAt(i)
		local two = it.where ~= nil and it.where ~= ""
		local h = two and TWO or ONE
		r.psIndex, r.psItem = i, it
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", list, "TOPLEFT", 1, -y)
		r:SetPoint("TOPRIGHT", list, "TOPRIGHT", -1, -y)
		r:SetHeight(h)
		r.Text:ClearAllPoints()
		r.Text:SetPoint("LEFT", r, "LEFT", INSET, two and 7 or 0)
		r.Text:SetPoint("RIGHT", r, "RIGHT", -INSET, two and 7 or 0)
		-- See all and a suggestion are links, in the accent as links are.
		W.Color(r.Text, (it.kind == "all" or it.kind == "suggest") and "accent" or "textDim")
		paint(r)
		r.Where:SetShown(two)
		if two then
			r.Where:ClearAllPoints()
			r.Where:SetPoint("LEFT", r, "LEFT", INSET, -8)
			r.Where:SetPoint("RIGHT", r, "RIGHT", -INSET, -8)
			r.Where:SetText(it.where)
		end
		paintLit(r, i == lit)
		r:Show()
		y = y + h
	end
	for i = #items + 1, #rows do rows[i]:Hide() end
	list:SetSize(width, y + PAD)
end

-- Open (or refresh) the list for the words typed.
function D.Show(text)
	if not list then build() end
	typed = text or ""
	local m = O.Matches(typed, ROWS)
	for i = #items, 1, -1 do items[i] = nil end
	items.none = nil
	for _, d in ipairs(m.places) do items[#items + 1] = { kind = d.kind, text = d.text, where = d.where, place = d } end
	for _, s in ipairs(m.settings) do items[#items + 1] = { kind = "setting", text = s.text, where = s.where, control = s.control } end
	if m.count > 0 then
		items[#items + 1] = { kind = "all", text = m.count == 1 and L["See 1 result"] or string.format(L["See all %d results"], m.count) }
	elseif #items == 0 then
		items.none = true
		for _, s in ipairs(m.suggestions or {}) do items[#items + 1] = { kind = "suggest", text = s } end
	end
	lit = nil
	layout()
	if not list:IsShown() then
		-- Out of its trigger as the menus come: a short fade and a 4px drop.
		Anim.Anchor(list, "TOPRIGHT", box, "BOTTOMRIGHT", 0, -4)
		list:Show()
		list:Raise()
		Anim.To(list, "alpha", 0, 1, Anim.FAST, "out")
		Anim.To(list, "offset", 4, 0, Anim.FAST, "out")
	end
end

function D.Hide()
	if list and list:IsShown() then list:Hide() end
end

function D.Shown()
	return list ~= nil and list:IsShown()
end

-- Light the next (delta 1) or previous row, round from either end.
function D.Step(delta)
	local n = #items
	if n == 0 then return end
	if lit then lit = (lit - 1 + delta) % n + 1 else lit = delta > 0 and 1 or n end
	for i = 1, n do paintLit(rows[i], i == lit) end
end

-- Pick row i: a suggestion searches for its words (the box keeps the
-- keyboard); See all opens the results page; anything else opens where it
-- stands, the list closed and the box let go.
function D.Pick(i)
	local it = items[i]
	if not it then return end
	if it.kind == "suggest" then
		O.SetBoxText(it.text)
		box:SetFocus()
		D.Show(it.text)
		return
	end
	D.Hide()
	box:ClearFocus()
	if it.kind == "all" then
		O.SetQuery(typed)
	else
		O.Go(it.place or it)
	end
end

-- Enter in the box: the lit row, else the results page for its words.
function D.Enter()
	if D.Shown() and lit then return D.Pick(lit) end
	local text = box:GetText() or ""
	D.Hide()
	box:ClearFocus()
	if text ~= "" then O.SetQuery(text) end
end

-- The rows on screen, in order (tests, the studio): { kind, text (as shown),
-- label (the name or label alone), where, key (a setting's), lit }.
function D.Rows()
	local out = {}
	if not D.Shown() then return out end
	for i, it in ipairs(items) do
		out[i] = { kind = it.kind, text = rows[i].Text:GetText(), label = it.text, where = it.where, key = it.control and it.control.key or nil, lit = i == lit }
	end
	return out
end

-- The settings window's search box drives the list (UI/Options.lua's
-- build): its keys, its focus, its size; the window's hiding closes it.
function D.Attach(w)
	win, box = w, w.Search
	box:SetScript("OnArrowPressed", function(self, key)
		local delta = key == "DOWN" and 1 or (key == "UP" and -1 or nil)
		if not delta then return end
		if not D.Shown() then
			local text = self:GetText() or ""
			if text == "" then return end
			D.Show(text)
		end
		D.Step(delta)
	end)
	box:SetScript("OnEnterPressed", function() D.Enter() end)
	box:SetScript("OnEscapePressed", function(self)
		if D.Shown() then D.Hide() else self:ClearFocus() end
	end)
	box:SetScript("OnTabPressed", function() D.Hide() end)
	-- The box let go (another box took the keyboard): the list goes, unless
	-- the pointer is on it (a row being clicked).
	box:HookScript("OnEditFocusLost", function()
		if D.Shown() and not list:IsMouseOver() then D.Hide() end
	end)
	box:HookScript("OnSizeChanged", function() if D.Shown() then layout() end end)
	w:HookScript("OnHide", D.Hide)
end
