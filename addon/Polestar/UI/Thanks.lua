-- Guiding Stars: the people behind Polestar. An options page (Options.lua
-- adds it, key "thanks") with the top supporter, the top contributor and the
-- top bug reporter on podiums, then the three lists; and the "Special thanks
-- to: <name>" line in the hub's and the options' headers, a name drawn anew
-- each time the window opens, that leads to the page.
--
-- The names come from Core/Credits.lua (`forge release credits`): supporters in
-- rank order, GitHub contributors by merged pull requests, and the top bug
-- reporters by confirmed or fixed reports.

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local floor, max, ipairs = math.floor, math.max, ipairs

local SH = W.SHELL
local COLS = 3
local GAP = 24 -- between the columns, as the options grid
local ROW = 22 -- a list row
local PANEL_HEAD = 58 -- a list panel's heading band: its title over its note
local PANEL_PAD = 16 -- a list panel's inner edge
local PODIUM_H = 140
local LINE = 36 -- a podium title's hairlines, when the title leaves room

local T = {}
UI.Thanks = T

-- Only the repository: Blizzard's add-on policy keeps donation links out of the game.
ns.RepoURL = "https://github.com/fitzforge/polestar"

local function credits() return ns.Credits or { supporters = {}, contributors = {}, bugReporters = {} } end

-- -> the supporters', the contributors' and the bug reporters' names (each in
-- rank order)
function T.Names()
	local c = credits()
	local sup, con, rep = {}, {}, {}
	for i, n in ipairs(c.supporters or {}) do sup[i] = n end
	for i, e in ipairs(c.contributors or {}) do con[i] = e.name end
	for i, e in ipairs(c.bugReporters or {}) do rep[i] = e.name end
	return sup, con, rep
end

local function esc(s) return ns.EscapeText and ns.EscapeText(s) or s end

local function bodyWidth()
	local win = UI.Options and UI.Options.frame
	return win and win.BodyWidth or 640
end

---------------------------------------------------------------------------
-- The header line
---------------------------------------------------------------------------

-- A name from any list, a new one each time it can be.
local last
function T.PickName(rand)
	local sup, con, rep = T.Names()
	-- Each name once: someone on two lists, or one name alone, never loops.
	local all, seen = {}, {}
	for _, list in ipairs({ sup, con, rep }) do
		for _, n in ipairs(list) do
			if not seen[n] then seen[n] = true; all[#all + 1] = n end
		end
	end
	if #all == 0 then return nil end
	if #all == 1 then return all[1] end
	rand = rand or math.random
	local n
	repeat n = all[rand(#all)] until n ~= last
	last = n
	return n
end

-- "Special thanks to: <name>" at the top right of a shell's header, on the
-- close button's line: left of it while it stands in the header, else on the
-- main column's pad. Clicking it opens Guiding Stars.
function T.HeaderLink(f)
	local b = CreateFrame("Button", nil, f.Header)
	b:SetHeight(20)
	b.Lead = W.Text(b, "small", "textMuted")
	b.Lead:SetText(L["Special thanks to:"])
	b.Name = W.Text(b, "small", "accent")
	b.Name:SetPoint("RIGHT", b, "RIGHT", 0, 0)
	b.Lead:SetPoint("RIGHT", b.Name, "LEFT", -4, 0)
	b.Line = W.Tex(b, "ARTWORK")
	b.Line:SetPoint("TOPLEFT", b.Name, "BOTTOMLEFT", 0, -2)
	b.Line:SetPoint("TOPRIGHT", b.Name, "BOTTOMRIGHT", 0, -2)
	W.Painter(b.Line, function(t)
		t:SetHeight(Theme.Pixel(b))
		t:SetVertexColor(Theme.Accent())
	end)
	b.Line:Hide()
	b.psTip = L["Guiding Stars"]
	b.psTipLines = { L["Everyone who supports Polestar and helps build it."] }
	b.psTipAnchor = "ANCHOR_BOTTOMLEFT"
	b:SetScript("OnEnter", function(self)
		W.Color(self.Name, "text")
		self.Line:Show()
		W.SimpleTip(self)
	end)
	b:SetScript("OnLeave", function(self)
		W.Color(self.Name, "accent")
		self.Line:Hide()
		W.HideTip(self)
	end)
	b:SetScript("OnClick", function() if UI.ShowOptions then UI.ShowOptions("thanks") end end)

	local function place()
		b:SetWidth(b.Lead:GetStringWidth() + 4 + b.Name:GetStringWidth())
		b:ClearAllPoints()
		local close, tools = f.Close, rawget(f, "HeaderTools")
		-- The close button may have moved (the hub's details pane): the
		-- scale control follows it first.
		if tools then tools.Place() end
		if tools and tools:IsShown() then
			b:SetPoint("RIGHT", tools, "LEFT", -16, 0)
		elseif close and close:IsShown() and close:GetParent() == f.Header then
			b:SetPoint("RIGHT", close, "LEFT", -10, 0)
		else
			b:SetPoint("RIGHT", f.Header, "TOPRIGHT", -SH.pad, -26)
		end
	end
	local function draw()
		local name = T.PickName()
		b:SetShown(name ~= nil)
		if not name then return end
		b.Name:SetText(esc(name))
		place()
	end
	f.ThanksLink, f.PlaceThanks = b, place
	f:HookScript("OnShow", draw)
	-- A new look or font: the close button may have come or gone, the text
	-- measures anew.
	Theme.OnChanged(place)
	draw()
	return b
end

---------------------------------------------------------------------------
-- The page
---------------------------------------------------------------------------

-- A label between two short accent hairlines: ── TOP SUPPORTER ──
local function flanked(parent, text)
	local f = CreateFrame("Frame", nil, parent)
	f:SetHeight(16)
	f.Text = W.Text(f, "caption", "accent")
	f.Text:SetPoint("CENTER", f, "CENTER", 0, 0)
	f.Text:SetText(text:upper())
	f.Left = W.Tex(f, "ARTWORK", nil, "accentLine")
	f.Left:SetSize(LINE, 1)
	f.Left:SetPoint("RIGHT", f.Text, "LEFT", -10, 0)
	f.Right = W.Tex(f, "ARTWORK", nil, "accentLine")
	f.Right:SetSize(LINE, 1)
	f.Right:SetPoint("LEFT", f.Text, "RIGHT", 10, 0)
	return f
end

-- Fit a flanked label to `width`: the hairlines shorten to the room the text
-- leaves and go when it leaves too little; a text wider than the column ends
-- in an ellipsis.
local function fitFlanked(f, width)
	f.Text:SetWidth(0)
	local tw = W.TextWidth(f.Text)
	if tw > width then
		f.Text:SetWidth(width)
		tw = width
	end
	local line = math.min(LINE, floor((width - tw) / 2) - 10)
	f.Left:SetShown(line >= 8)
	f.Right:SetShown(line >= 8)
	if line >= 8 then
		f.Left:SetWidth(line)
		f.Right:SetWidth(line)
	end
end

-- The emblem in its glow, the title, the first name large, then #2 and #3,
-- one to a line.
local function podium(parent, title)
	local p = CreateFrame("Frame", nil, parent)
	p:SetHeight(PODIUM_H)
	p.Glow = W.Tex(p, "BACKGROUND", "glow")
	p.Glow:SetSize(120, 120)
	p.Emblem = W.Tex(p, "ARTWORK", "emblem", "accent")
	p.Emblem:SetSize(36, 36)
	p.Emblem:SetPoint("TOP", p, "TOP", 0, 0)
	p.Glow:SetPoint("CENTER", p.Emblem, "CENTER", 0, 0)
	W.Painter(p.Glow, function(t) local r, g, b = Theme.Accent(); t:SetVertexColor(r, g, b, 0.14) end)
	p.Title = flanked(p, title)
	p.Title:SetPoint("TOPLEFT", p, "TOPLEFT", 0, -44)
	p.Title:SetPoint("TOPRIGHT", p, "TOPRIGHT", 0, -44)
	-- Every line spans the column, so a long name ends in an ellipsis; then
	-- hovering the podium shows its names in full.
	p.Name = W.Text(p, "hero", "text")
	p.Name:SetPoint("TOPLEFT", p, "TOPLEFT", 0, -68)
	p.Name:SetPoint("TOPRIGHT", p, "TOPRIGHT", 0, -68)
	p.Name:SetJustifyH("CENTER")
	p.Name:SetWordWrap(false)
	p.Rest = {}
	for i = 1, 2 do
		local fs = W.Text(p, "label", "textDim")
		fs:SetPoint("TOPLEFT", p, "TOPLEFT", 0, -86 - i * 18)
		fs:SetPoint("TOPRIGHT", p, "TOPRIGHT", 0, -86 - i * 18)
		fs:SetJustifyH("CENTER")
		fs:SetWordWrap(false)
		p.Rest[i] = fs
	end
	p:EnableMouse(true)
	p:SetScript("OnEnter", function(self)
		local cut = self.Name:IsTruncated()
		for _, fs in ipairs(self.Rest) do cut = cut or fs:IsTruncated() end
		if cut and self.psNames then W.Tooltip(self, "ANCHOR_TOP", self.psNames[1], { self.psNames[2], self.psNames[3] }) end
	end)
	p:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	return p
end

-- An empty list leaves the large line blank and says so under it, on up to
-- two lines.
local function fillPodium(p, names, empty)
	local none = #names == 0
	-- The full names, for the tooltip while a line is cut short.
	p.psNames = not none and { esc(names[1]), names[2] and esc(names[2]), names[3] and esc(names[3]) } or nil
	local first = p.Rest[1]
	first:SetWordWrap(none)
	first:SetMaxLines(none and 2 or 0)
	W.Color(first, none and "textMuted" or "textDim")
	if none then
		p.Name:SetText("")
		first:SetText(empty)
		p.Rest[2]:SetText("")
		return
	end
	p.Name:SetText(esc(names[1]))
	local accent = "|c" .. Theme.Hex("accent")
	for i, fs in ipairs(p.Rest) do
		local n = names[i + 1]
		fs:SetText(n and (accent .. "#" .. (i + 1) .. "|r  " .. esc(n)) or "")
	end
end

-- A list panel: an accent line on top, its heading over a note saying what
-- the counts are, then numbered rows.
local function panel(parent, title, note)
	local p = CreateFrame("Frame", nil, parent)
	Theme.Skin(p, "panel")
	p.Top = W.Tex(p, "OVERLAY", nil, "accent")
	p.Top:SetHeight(2)
	p.Top:SetPoint("TOPLEFT", p, "TOPLEFT", 1, -1)
	p.Top:SetPoint("TOPRIGHT", p, "TOPRIGHT", -1, -1)
	p.Title = W.Text(p, "heading", "accent")
	p.Title:SetText(title:upper())
	p.Title:SetPoint("TOPLEFT", p, "TOPLEFT", PANEL_PAD, -16)
	p.Note = W.Text(p, "small", "textMuted")
	p.Note:SetText(note)
	p.Note:SetPoint("TOPLEFT", p, "TOPLEFT", PANEL_PAD, -34)
	p.Rule = W.Divider(p)
	p.Rule:SetPoint("TOPLEFT", p, "TOPLEFT", PANEL_PAD, -(PANEL_HEAD - 4))
	p.Rule:SetPoint("TOPRIGHT", p, "TOPRIGHT", -PANEL_PAD, -(PANEL_HEAD - 4))
	p.Empty = W.Text(p, "note", "textMuted")
	p.Empty:SetWordWrap(true)
	p.Empty:SetJustifyH("LEFT")
	p.Empty:SetPoint("TOPLEFT", p, "TOPLEFT", PANEL_PAD, -(PANEL_HEAD + 6))
	p.rows = {}
	return p
end

local function panelRow(p, i)
	local r = p.rows[i]
	if r then return r end
	r = CreateFrame("Frame", nil, p)
	r:SetHeight(ROW)
	r:SetPoint("TOPLEFT", p, "TOPLEFT", PANEL_PAD, -(PANEL_HEAD + 4 + (i - 1) * ROW))
	r:SetPoint("TOPRIGHT", p, "TOPRIGHT", -PANEL_PAD, -(PANEL_HEAD + 4 + (i - 1) * ROW))
	r.Rank = W.Text(r, "number", "textMuted")
	r.Rank:SetJustifyH("RIGHT")
	r.Rank:SetWidth(22)
	r.Rank:SetPoint("LEFT", r, "LEFT", 0, 0)
	r.Count = W.Text(r, "number", "textMuted")
	r.Count:SetJustifyH("RIGHT")
	r.Count:SetPoint("RIGHT", r, "RIGHT", 0, 0)
	r.Name = W.Text(r, "body", "text")
	r.Name:SetWordWrap(false)
	r.Name:SetJustifyH("LEFT")
	r.Name:SetPoint("LEFT", r.Rank, "RIGHT", 10, 0)
	p.rows[i] = r
	return r
end

-- rows: { { name, count or nil }, ... }; `width` the panel's -> its height.
-- The heading, the note and each name take the panel's inner width, a name
-- what its count leaves, so a long one ends in an ellipsis.
local function fillPanel(p, rows, empty, width)
	local inner = width - PANEL_PAD * 2
	p.Title:SetWidth(inner)
	p.Note:SetWidth(inner)
	for i, e in ipairs(rows) do
		local r = panelRow(p, i)
		r.Rank:SetText(i .. ".")
		W.Color(r.Rank, i <= 3 and "accent" or "textMuted")
		r.Count:SetText(e[2] and tostring(e[2]) or "")
		r.Count:SetWidth(e[2] and W.TextWidth(r.Count) or 0)
		r.Name:SetText(esc(e[1]))
		r.Name:SetWidth(inner - 22 - 10 - (e[2] and r.Count:GetWidth() + 8 or 0))
		W.Color(r.Name, i == 1 and "accent" or "text")
		r:SetWidth(inner)
		r:Show()
	end
	for i = #rows + 1, #p.rows do p.rows[i]:Hide() end
	p.Empty:SetShown(#rows == 0)
	p.Empty:SetWidth(inner)
	p.Empty:SetText(empty or "")
	if #rows == 0 then return PANEL_HEAD + 6 + p.Empty:GetStringHeight() + 18 end
	return PANEL_HEAD + 4 + #rows * ROW + 14
end

-- Options.lua's custom page builder.
function T.Build(view)
	local lead = W.Text(view, "title", "text")
	lead:SetJustifyH("CENTER")
	lead:SetText(L["Thank you to everyone who supports Polestar and helps build it"])
	local join = W.Text(view, "note", "textDim")
	join:SetText(L["Polestar is open source:"])
	local github = W.Link(view, L["contribute on GitHub"], function()
		UI.ShowCopy(L["Contribute on GitHub"], ns.RepoURL)
	end, { role = "note" })

	local topSup = podium(view, L["Top supporter"])
	local topCon = podium(view, L["Top contributor"])
	local topRep = podium(view, L["Top bug reporter"])
	local dividers = { W.Divider(view, true), W.Divider(view, true) }

	local supPanel = panel(view, L["Supporters"], "")
	local conPanel = panel(view, L["Contributors"], L["Pull requests on GitHub"])
	local repPanel = panel(view, L["Bug reporters"], L["Confirmed reports"])

	local closing = W.Text(view, "small", "textMuted")
	closing:SetJustifyH("CENTER")
	closing:SetText(L["Thank you for making Polestar possible."])

	view.Podiums = { topSup, topCon, topRep }
	view.Supporters, view.Contributors, view.BugReporters = supPanel, conPanel, repPanel
	view.Refresh = function()
		local width = bodyWidth()
		local cw = floor((width - GAP * (COLS - 1)) / COLS)
		local x0 = SH.pad
		local y = 22
		lead:ClearAllPoints()
		lead:SetPoint("TOPLEFT", view, "TOPLEFT", x0, -y)
		lead:SetWidth(width)
		y = y + lead:GetStringHeight() + 8

		-- "Polestar is open source: contribute on GitHub", centred as one line.
		-- No call to donate: Blizzard's add-on policy (rule 5) keeps donation
		-- requests out of the game, so supporters are thanked by name only.
		-- The link re-measures (W.SetLinkText) in case the font changed.
		W.SetLinkText(github, L["contribute on GitHub"])
		local widths = { join:GetStringWidth(), github:GetWidth() }
		local x = x0 + floor((width - (widths[1] + 5 + widths[2])) / 2)
		for i, part in ipairs({ join, github }) do
			part:ClearAllPoints()
			part:SetPoint("LEFT", view, "TOPLEFT", x, -(y + 10))
			x = x + widths[i] + 5
		end
		y = y + 20 + 30

		local sup, con, rep = T.Names()
		fillPodium(topSup, sup, L["No names here yet."])
		fillPodium(topCon, con, L["No names here yet."])
		fillPodium(topRep, rep, L["No names here yet."])
		for i, p in ipairs(view.Podiums) do
			p:ClearAllPoints()
			p:SetPoint("TOPLEFT", view, "TOPLEFT", x0 + (i - 1) * (cw + GAP), -y)
			p:SetWidth(cw)
			p.Name:SetWidth(cw)
			for _, fs in ipairs(p.Rest) do fs:SetWidth(cw) end
			fitFlanked(p.Title, cw)
		end
		for i, d in ipairs(dividers) do
			d:ClearAllPoints()
			d:SetPoint("TOP", view, "TOPLEFT", x0 + i * (cw + GAP) - GAP / 2, -(y + 12))
			d:SetHeight(PODIUM_H - 24)
		end
		y = y + PODIUM_H + 16

		local supRows, conRows, repRows = {}, {}, {}
		for i, n in ipairs(sup) do supRows[i] = { n } end
		for i, e in ipairs(credits().contributors or {}) do conRows[i] = { e.name, e.prs or 0 } end
		for i, e in ipairs(credits().bugReporters or {}) do repRows[i] = { e.name, e.reports or 0 } end
		local h = max(fillPanel(supPanel, supRows, L["No names here yet."], cw),
			fillPanel(conPanel, conRows, L["No names here yet."], cw),
			fillPanel(repPanel, repRows, L["No names here yet."], cw))
		for i, p in ipairs({ supPanel, conPanel, repPanel }) do
			p:ClearAllPoints()
			p:SetPoint("TOPLEFT", view, "TOPLEFT", x0 + (i - 1) * (cw + GAP), -y)
			p:SetSize(cw, h)
		end
		y = y + h + 18

		closing:ClearAllPoints()
		closing:SetPoint("TOPLEFT", view, "TOPLEFT", x0, -y)
		closing:SetWidth(width)
		return y + closing:GetStringHeight() + 24
	end
end
