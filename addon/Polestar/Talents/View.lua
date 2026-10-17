-- The Talents section of the hub (the guide menu's shell): the talent plans
-- for the player's class, one per spec (Builds.lua), and where the player
-- stands on the one being followed (Talents.lua).
--
-- Tabs: one per spec (the sidebar index). Under them two panes on the guide
-- menu's grid, as Rares: the plan (left, its picks in order, numbered, in
-- bands of ten; learned picks muted, the next one marked) and the plan's
-- page (right, on the panel ground): where you stand, "Follow this plan" /
-- "Follow my spec", the plan's notes (at approximate levels: points can come
-- earlier than one a level), and its source. Talent names are the client's
-- on every tab, not only the followed plan's.
--
-- Registered with UI.RegisterSection; opened by SHOW_TALENTS.

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local T = ns.Talents
local L = ns.L
local max, min, floor, ipairs, pairs, format, tostring = math.max, math.min, math.floor, ipairs, pairs, string.format, tostring

if not (UI and W and W.SHELL and T) then return end

local SH = W.SHELL
local LIST_W = 272
local ROW_X = 12
local TEXT_X = SH.pad - ROW_X
local ROW_H = 26
local HEAD_H = 34
local FOOT_PAD = 24
local FOOT_H = 28 + FOOT_PAD * 2
local DPAD = SH.side
local DOT = "  \194\183  "
local BAND = 10 -- picks per list heading

local TV = {}
UI.TalentsSection = TV

local tab -- the spec index shown; nil: the followed plan's
local root, shellRef, list, detail
local rows, bands, heads, notes = {}, {}, {}, {}
local shown = {}

local function row(i)
	local r = rows[i]
	if r then return r end
	r = CreateFrame("Frame", nil, list.Scroll.Child)
	r:SetHeight(ROW_H)
	r.Selected = r:CreateTexture(nil, "BACKGROUND")
	r.Selected:SetTexture(Theme.Media("white"))
	r.Selected:SetAllPoints(r)
	W.Painter(r.Selected, function(t) t:SetVertexColor(Theme.Wash("selected")) end)
	r.Bar = r:CreateTexture(nil, "ARTWORK")
	r.Bar:SetTexture(Theme.Media("white"))
	r.Bar:SetWidth(2)
	r.Bar:SetPoint("TOPLEFT", r, "TOPLEFT", 0, 0)
	r.Bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0)
	W.Color(r.Bar, "accent")
	r.Level = W.Text(r, "number", "textMuted")
	r.Level:SetPoint("RIGHT", r, "LEFT", TEXT_X - 8, 0)
	r.Title = W.Text(r, "body", "text")
	r.Title:SetPoint("LEFT", r, "LEFT", TEXT_X, 0)
	r.Sub = W.Text(r, "small", "textMuted")
	r.Sub:SetJustifyH("RIGHT")
	r.Sub:SetPoint("RIGHT", r, "RIGHT", -10, 0)
	rows[i] = r
	return r
end

local function band(i)
	local h = bands[i]
	if h then return h end
	h = CreateFrame("Frame", nil, list.Scroll.Child)
	h:SetHeight(HEAD_H)
	h.Text = W.Text(h, "label", "textMuted")
	h.Text:SetPoint("BOTTOMLEFT", h, "BOTTOMLEFT", TEXT_X, 8)
	bands[i] = h
	return h
end

function TV.Build(parent, shell)
	if root then return root end
	shellRef = shell
	root = CreateFrame("Frame", nil, parent)
	root:SetAllPoints(parent)
	list = CreateFrame("Frame", nil, root)
	list:SetPoint("TOPLEFT", root, "TOPLEFT", 0, 0)
	list:SetPoint("BOTTOMLEFT", root, "BOTTOMLEFT", 0, 0)
	list:SetWidth(LIST_W)
	list.Scroll = W.Scroll(list)
	list.Scroll:SetPoint("TOPLEFT", list, "TOPLEFT", 0, -4)
	list.Scroll:SetPoint("BOTTOMRIGHT", list, "BOTTOMRIGHT", 0, 8)
	list.Scroll.Child:SetWidth(LIST_W)
	list.Empty = W.Text(list.Scroll.Child, "note", "textMuted")
	list.Empty:SetWordWrap(true)
	list.Empty:SetWidth(LIST_W - TEXT_X * 2)
	list.Empty:SetJustifyH("LEFT")
	list.Empty:SetPoint("TOPLEFT", list.Scroll.Child, "TOPLEFT", SH.pad, -8)

	local d = CreateFrame("Frame", nil, root)
	detail = d
	d:SetPoint("TOPLEFT", list, "TOPRIGHT", 0, 0)
	d:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", 0, 0)
	W.Fill(d, "panel")
	local rule = W.Divider(d, true)
	rule:SetPoint("TOPLEFT", d, "TOPLEFT", 0, 0)
	rule:SetPoint("BOTTOMLEFT", d, "BOTTOMLEFT", 0, 0)
	d.Foot = CreateFrame("Frame", nil, d)
	d.Foot:SetPoint("BOTTOMLEFT", d, "BOTTOMLEFT", 1, 0)
	d.Foot:SetPoint("BOTTOMRIGHT", d, "BOTTOMRIGHT", 0, 0)
	d.Foot:SetHeight(FOOT_H)
	d.FootRule = W.Divider(d.Foot)
	d.FootRule:SetPoint("TOPLEFT", d.Foot, "TOPLEFT", 0, 0)
	d.FootRule:SetPoint("TOPRIGHT", d.Foot, "TOPRIGHT", 0, 0)
	d.Follow = W.Button(d.Foot, L["Follow this plan"], function() TV.Follow() end, { primary = true, height = 28, icon = "icon-learn" })
	d.Follow:SetPoint("BOTTOMRIGHT", d.Foot, "BOTTOMRIGHT", -FOOT_PAD, FOOT_PAD)
	d.Auto = W.Button(d.Foot, L["Follow my spec"], function() TV.FollowSpec() end, { height = 28 })
	d.Auto.psTip = L["Pick the plan for the spec Polestar's gear advice uses."]
	d.Scroll = W.Scroll(d)
	d.Scroll:SetPoint("TOPLEFT", d, "TOPLEFT", 0, -1)
	d.Scroll:SetPoint("BOTTOMRIGHT", d.Foot, "TOPRIGHT", -4, 4)
	d.Body = d.Scroll.Child
	d.Title = W.Text(d.Body, "display", "text")
	d.Sub = W.Text(d.Body, "small", "textDim")
	return root
end

local function detailWidth()
	local full = shellRef and (shellRef:GetWidth() - (shellRef.psRail or 0) - (shellRef.psSidebar or SH.sidebar) - 2) or 0
	if full <= 0 then full = 878 end
	return full - LIST_W
end

local function writer()
	local d = detail
	local width = detailWidth()
	d.Body:SetWidth(width)
	local w = { y = -24, h = 0, n = 0, width = width - DPAD * 2 - 8 }
	function w.title(text, sub)
		d.Title:ClearAllPoints()
		d.Title:SetPoint("TOPLEFT", d.Body, "TOPLEFT", DPAD, w.y)
		d.Title:SetText(text)
		d.Sub:ClearAllPoints()
		d.Sub:SetPoint("TOPLEFT", d.Title, "BOTTOMLEFT", 0, -8)
		d.Sub:SetText(sub or "")
		w.y = w.y - 24 - 8 - 14 - 8
	end
	function w.head(text, count)
		w.h = w.h + 1
		local h = heads[w.h] or W.SectionHeader(d.Body)
		heads[w.h] = h
		h:ClearAllPoints()
		h:SetPoint("TOPLEFT", d.Body, "TOPLEFT", DPAD, w.y)
		h:SetWidth(w.width)
		W.SetSection(h, text, count)
		h:Show()
		w.y = w.y - 44 - 2
	end
	function w.note(text, color)
		w.n = w.n + 1
		local n = notes[w.n]
		if not n then
			n = W.Text(d.Body, "note", "textDim")
			n:SetWordWrap(true)
			n:SetJustifyH("LEFT")
			n:SetJustifyV("TOP")
			notes[w.n] = n
		end
		W.Color(n, color or "textDim")
		n:ClearAllPoints()
		n:SetPoint("TOPLEFT", d.Body, "TOPLEFT", DPAD, w.y - 6)
		n:SetWidth(min(560, w.width))
		n:SetText(text)
		n:Show()
		w.y = w.y - 6 - n:GetStringHeight() - 10
		shown.notes[#shown.notes + 1] = text
	end
	return w
end

local function hideAll()
	for _, t in ipairs({ rows, bands, heads, notes }) do
		for _, r in ipairs(t) do r:Hide() end
	end
end

-- Where the player stands on the plan they follow.
local function statusText(c)
	local s = c.state
	local data, nxt = c.data, s.next
	if s.status == "early" then return L["No talent points yet. The first pick is marked once the game gives you one."], "textDim" end
	if s.status == "complete" then return L["Every pick in this plan is learned."], "success" end
	if s.status == "offplan" then
		local n = 0
		for _, r in pairs(s.offPlan) do n = n + r end
		return format(n == 1 and L["1 point is spent outside this plan. Its marks on the talent frame show where; a respec puts you back on it."] or L["%d points are spent outside this plan. Its marks on the talent frame show where; a respec puts you back on it."], n), "warning"
	end
	if s.status == "behind" then
		if s.unspent == 1 then return format(L["1 point to spend. Next: %s."], T.PickText(data, nxt, c.valid)), "accent" end
		return format(L["%d points to spend. Next: %s."], s.unspent, T.PickText(data, nxt, c.valid)), "accent"
	end
	return format(L["On plan. Next point: %s."], T.PickText(data, nxt, c.valid)), "text"
end

local REASONS = {
	off = L["Talent plans are turned off. Turn them on under Options > Questing > Talents."],
	class = L["There is no talent plan for your class yet."],
	noconfig = L["The talent tree is not loaded yet. It will be once you are in the world."],
	notree = L["The talent tree is not loaded yet. It will be once you are in the world."],
}

-- c: the current state when this is the followed plan (progress marks);
-- valid: the live tree's names, for every plan.
local function renderList(build, c, valid)
	local s = c and c.state
	local y, nr, nb = 0, 0, 0
	local lastBand
	for _, p in ipairs(build.picks) do
		local b = floor((p.order - 1) / BAND) * BAND + 1
		if b ~= lastBand then
			lastBand = b
			nb = nb + 1
			local h = band(nb)
			h:ClearAllPoints()
			h:SetPoint("TOPLEFT", list.Scroll.Child, "TOPLEFT", ROW_X, -y)
			h:SetWidth(LIST_W - ROW_X * 2)
			h.Text:SetText(format(L["Picks %d-%d"], b, min(b + BAND - 1, #build.picks)))
			h:Show()
			y = y + HEAD_H
		end
		nr = nr + 1
		local r = row(nr)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", list.Scroll.Child, "TOPLEFT", ROW_X, -y)
		r:SetWidth(LIST_W - ROW_X * 2)
		local n = build.data.nodes[p.node]
		local done = s and (p.order < (s.next and s.next.order or math.huge))
		local isNext = s and s.next == p
		r.Selected:SetShown(isNext or false)
		r.Bar:SetShown(isNext or false)
		r.Level:SetText(tostring(p.order))
		r.Title:SetText(T.NodeName(build.data, p.node, valid))
		W.Color(r.Title, isNext and "accent" or (done and "textMuted" or "text"))
		r.Sub:SetText(format("%d/%d", p.rank, n.max))
		r.Title:SetWidth(max(40, min(LIST_W - ROW_X * 2 - TEXT_X - 50, floor(r.Title:GetStringWidth() + 1))))
		r.psPick = p
		r:Show()
		y = y + ROW_H
	end
	for i = nr + 1, #rows do rows[i]:Hide() end
	for i = nb + 1, #bands do bands[i]:Hide() end
	list.Empty:SetShown(nr == 0)
	W.SetScrollContent(list.Scroll, y + 16)
	shown.rows = nr
	shown.titles = {}
	for i = 1, nr do shown.titles[i] = rows[i].Title:GetText() end
end

local function actions(follow, auto)
	local d = detail
	d.Follow:SetShown(follow)
	d.Auto:SetShown(auto)
	d.Auto:ClearAllPoints()
	if follow then d.Auto:SetPoint("RIGHT", d.Follow, "LEFT", -8, 0) else d.Auto:SetPoint("BOTTOMRIGHT", d.Foot, "BOTTOMRIGHT", -FOOT_PAD, FOOT_PAD) end
	d.Foot:SetShown(follow or auto)
end

function TV.Render()
	if not root then return end
	hideAll()
	for k in pairs(shown) do shown[k] = nil end
	shown.notes = {}
	local w = writer()
	local data = T.Data()
	local c, reason = T.Current()
	if not data or reason == "off" then
		reason = reason or "class"
		if shellRef then W.ShellTitle(shellRef, L["Talents"], L["A talent plan, pick by pick"]) end
		renderList({ picks = {} }, nil)
		list.Empty:SetText(L["No plan for this character."])
		w.title(L["Talents"])
		w.note(REASONS[reason] or REASONS.class)
		actions(false, false)
		shown.empty = reason
		W.SetScrollContent(detail.Scroll, -w.y + 24)
		return
	end
	local followed = c and c.build or T.ActiveBuild(data)
	local spec = tab or followed.spec
	local build = data.builds[1]
	for _, b in ipairs(data.builds) do if b.spec == spec then build = b end end
	local mine = build == followed
	if shellRef then
		W.ShellTitle(shellRef, L["Talents"], format(L["%s plan for %s"], followed.specName, UnitClass("player") or "")
			.. (c and c.state and (DOT .. format(L["%d of %d picks"], c.state.done, c.state.total)) or ""))
	end
	renderList(build, mine and c and c.state and c or nil, c and c.valid)
	w.title(format(L["%s plan"], build.specName), build.split .. DOT .. format(L["%d picks, in order"], #build.picks))
	shown.spec, shown.followed, shown.mine = build.specName, followed.specName, mine
	if reason == "stale" then
		w.note(format(L["This plan no longer matches the game's talent tree (missing: %s). It is shown as written, without marks on the talent frame, until Polestar is updated."], table.concat(c.valid.missing, ", ")), "warning")
		shown.status = "stale"
	elseif not mine then
		w.note(format(L["You are following the %s plan."], followed.specName))
		shown.status = "other"
	elseif c and c.state then
		local text, color = statusText(c)
		w.note(text, color)
		shown.status = c.state.status
	elseif reason then
		w.note(REASONS[reason] or tostring(reason))
		shown.status = reason
	end
	if data.summary and mine then w.note(data.summary) end
	w.head(L["Notes"])
	-- Keyed by the level the source plan reaches them at; shown as a rough
	-- guide only, since points can come sooner.
	local lvs = {}
	for lv in pairs(build.notes) do lvs[#lvs + 1] = lv end
	table.sort(lvs)
	for _, lv in ipairs(lvs) do w.note(format(L["Around level %d: %s"], lv, build.notes[lv]), "text") end
	w.head(L["Source"])
	w.note(format(L["Picks from %s (%s), checked against the game's talent tree; notes in Polestar's words."], data.source, data.url))
	local choice = T.Choice()
	actions(not mine or choice == "auto", choice ~= "auto")
	if mine and choice == "auto" then W.SetButtonText(detail.Follow, L["Keep this plan"]) else W.SetButtonText(detail.Follow, L["Follow this plan"]) end
	detail.Follow.psTip = L["Follow this plan whatever spec gear advice uses."]
	shown.follow, shown.auto = detail.Follow:IsShown(), detail.Auto:IsShown()
	W.SetScrollContent(detail.Scroll, -w.y + 24)
end

local function repaint()
	local P = UI.Picker
	if root and root:IsVisible() and P and P.Render then P.Render() else TV.Render() end
end

function TV.SetTab(key)
	tab = tonumber(key)
	if list then W.ScrollTo(list.Scroll, 0) end
	if detail then W.ScrollTo(detail.Scroll, 0) end
	repaint()
end

-- The sidebar index: one tab per spec plan.
function TV.Nav()
	local data = T.Data()
	if not data then return {}, nil end
	local c = T.Current()
	local followed = c and c.build or T.ActiveBuild(data)
	local out = {}
	for _, b in ipairs(data.builds) do
		out[#out + 1] = { key = tostring(b.spec), label = b.specName, icon = b == followed and "icon-learn" or nil, count = b.split }
	end
	return out, tostring(tab or followed.spec)
end

function TV.Follow()
	local data = T.Data()
	if not data then return end
	local c = T.Current()
	local spec = tab or (c and c.build and c.build.spec) or T.ActiveBuild(data).spec
	for _, b in ipairs(data.builds) do
		if b.spec == spec then return T.Choose(b.key) end
	end
end

function TV.FollowSpec()
	tab = nil
	T.Choose("auto")
end

function TV.Shown() return shown end
TV.rows = rows

function TV.Show()
	local P = UI.Picker
	if UI.ShowPicker then UI.ShowPicker() end
	if P and P.ShowSection then P.ShowSection("Talents") end
	TV.Render()
end

ns.On("SHOW_TALENTS", TV.Show)
ns.On("TALENTS_UPDATED", function() if root and root:IsVisible() then repaint() end end)

if UI.RegisterSection then
	UI.RegisterSection({
		key = "Talents", label = L["Talents"], icon = "icon-learn", order = 40,
		build = TV.Build, render = TV.Render,
		nav = TV.Nav, onNav = TV.SetTab,
	})
end
