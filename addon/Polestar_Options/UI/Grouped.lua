-- The settings window's grouped layout ("New settings page", a preview the
-- player turns on in the window's header; PolestarDB.optionsLayout =
-- "grouped", account-wide, off by default). The same window and the same
-- rows as the classic layout, from the same registry and through
-- UI/Options.lua's own pieces (UI.Options.Kit), laid out in fewer doors:
--
--   the sidebar      the window's own: the groups of G.TREE (Guiding, Look,
--                    Setup, About), the one shown open on its pages (the
--                    classic pages, another addon's among them); a page with
--                    settings new to the player has a ring, else a dot while
--                    one is off its default
--   a page           its own tabs, the classic page's, in the tab row, and
--                    each tab's rows as the classic page lays them out
--   the header       "Search first": a "Group › Page" crumb and the
--                    description, then the wide search, the switch, Peek,
--                    Fold, Reload UI and ··· (Menu scale, Move frames, the
--                    resets); Undo beside the crumb; no footer
--   the index        under the tabs, for a tab of more than 30 rows: its
--                    sections as jump links, the one in view lit as the selected tab
--   dependency line  a section whose on/off lives in another tab says so
--                    first, with the way to it
--
-- Options.lua asks this file first (O.Select, the sidebar, the search, the
-- relayout, LB / RB, a jump to a row) while the layout is on.

local ns = Polestar
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local O = UI.Options
local K = O.Kit
local SH = W.SHELL
local floor, max, min, ipairs, pairs, type = math.floor, math.max, math.min, ipairs, pairs, type

local G = {}
O.Grouped = G

-- The sidebar's groups in order, each with the keys of its pages in order:
-- the one place that says which group a page sits in. A registered page
-- left out of it goes last in the group the current page gives it
-- (K.groupOf), so a new module's page never goes missing. label: the
-- group's name (the first page's name without one); icon, else iconPage:
-- its glyph, or the glyph of that page (the first page's without either).
-- After an edit, G.Invalidate() builds the tree again. The pages in the
-- order a player meets them: the first quest before the map's tweaks,
-- Discovery now and then; the guide window sized before the look is changed.
G.TREE = {
	{ key = "guiding", label = L["Guiding"], icon = "star",
		pages = { "guide", "questing", "map", "qualityoflife", "discovery" } },
	{ key = "look", label = L["Look"], iconPage = "theme",
		pages = { "guidewindow", "theme", "arrow", "mappins", "routelines", "buttons", "alerts", "trackers" } },
	{ key = "setup", label = L["Setup"], iconPage = "profiles",
		pages = { "profiles", "integrations", "guidepacks", "gamepad" } },
	{ key = "about", label = L["About"], iconPage = "about",
		pages = { "about", "thanks", "recorder" } },
}

-- SEP: a crumb's separator (" › "). LONG: rows past which a tab shows its
-- index. STRIP: the index's height.
local SEP = " \226\128\186 "
local LONG, STRIP = 30, 34

local SUBTITLES = {
	guidewindow = L["The guide window's frame, bars, step card, tips and progress bar."],
	guiding = L["What Polestar does for you while you level: suggestions, quests, rewards, buttons, rares."],
	arrowmap = L["The arrow, its routes, and what Polestar draws on the world map and the minimap."],
	look = L["The theme every Polestar window wears, the action buttons, the alert cards and the trackers."],
	setup = L["Profiles, other addons, community guides and gamepad."],
}

local homes, dirty = nil, true
-- st.group (the group shown), st.page[group key] (its page last shown),
-- st.tab[page key] (its tab last shown).
local st = { page = {}, tab = {} }
local B = { views = {}, links = {}, depKeys = {} }
local shown = false
local render

function G.On()
	return ns.DB().optionsLayout == "grouped"
end

local function win() return K.window() end

local function dropViews()
	for _, v in pairs(B.views) do v:Hide() end
	B.views = {}
end

-- The tree the sidebar draws, built from G.TREE and the pages registered:
-- { { key, label, icon, pages = { p } } } in sidebar order,
-- groups with no page registered left out.
local tree
function G.Tree()
	if tree then return tree end
	local byKey, placed, at, out = {}, {}, {}, {}
	for _, p in ipairs(K.pages) do byKey[p.key] = p end
	for _, spec in ipairs(G.TREE) do
		local g = { key = spec.key, label = spec.label, icon = spec.icon, pages = {} }
		if not g.icon and spec.iconPage and byKey[spec.iconPage] then g.icon = byKey[spec.iconPage].icon end
		for _, k in ipairs(spec.pages or {}) do
			local p = byKey[k]
			if p and not placed[p] then
				placed[p] = true
				g.pages[#g.pages + 1] = p
			end
		end
		out[#out + 1] = g
		at[g.key] = at[g.key] or g
	end
	for _, p in ipairs(K.pages) do
		if not placed[p] then
			local gk = K.groupOf(p)
			local g = at[gk]
			if not g then
				g = { key = gk, pages = {} }
				for _, cg in ipairs(K.groups) do if cg.key == gk then g.label = cg.label end end
				out[#out + 1] = g
				at[gk] = g
			end
			g.pages[#g.pages + 1] = p
		end
	end
	local built = {}
	for _, g in ipairs(out) do
		if #g.pages > 0 then
			g.label = g.label or g.pages[1].name
			g.icon = g.icon or g.pages[1].icon or "gear"
			built[#built + 1] = g
		end
	end
	tree = built
	return tree
end

-- A page's tabs on the new page: its Essentials tab first (UI/Essentials.lua,
-- in place of the page's own one of that name), then the page's tabs on
-- screen. -> list
local function pageTabs(p)
	local tabs = K.shownTabs(p)
	local e = G.EssentialsTab and G.EssentialsTab(p)
	if not e then return tabs end
	local out = { e }
	for _, t in ipairs(tabs) do
		if t.name ~= e.name then out[#out + 1] = t end
	end
	return out
end
G.Tabs = pageTabs

-- -> the group of the tree holding page p
local function groupOfPage(p, tree)
	for _, g in ipairs(tree or G.Tree()) do
		for _, gp in ipairs(g.pages) do if gp == p then return g end end
	end
end

local function groupBy(key, tree)
	for _, g in ipairs(tree or G.Tree()) do if g.key == key then return g end end
end

local function rowsOf(sec)
	local out = {}
	for _, c in ipairs(sec.controls) do if K.available(c) then out[#out + 1] = c end end
	return out
end

-- The rows a count looks at: a reference stands for its home, counted there.
local function homeRows(sec)
	local out = {}
	for _, c in ipairs(sec.controls) do
		if K.available(c) and not rawget(c, "ref") then out[#out + 1] = c end
	end
	return out
end

local function secShown(sec)
	if not K.sectionShown(sec) then return false end
	if #rowsOf(sec) > 0 then return true end
	return sec.toggle ~= nil and K.available(sec.toggle)
end

local function tabVisible(t)
	for _, sec in ipairs(t.sections) do if secShown(sec) then return true end end
	return false
end

-- A page in the sidebar: a custom one, one that says why it is empty, or
-- one with a tab of rows.
local function pageShown(p)
	if p.custom or p.empty then return true end
	for _, t in ipairs(p.tabs) do if tabVisible(t) then return true end end
	return false
end

-- Where each section's on/off has its home: the first section holding a
-- toggle of that key that is no reference, in sidebar order (a reference
-- counts at its home, a row or another section's switch).
-- { [key] = { page, tab, section } }, built again after a registration
-- (its views too).
local function toggleHomes()
	if dirty or not homes then
		homes = {}
		for _, g in ipairs(G.Tree()) do
			for _, p in ipairs(g.pages) do
				for _, t in ipairs(p.tabs) do
					for _, sec in ipairs(t.sections) do
						local tg = sec.toggle
						if tg and tg.key and not rawget(tg, "ref") and not homes[tg.key] then homes[tg.key] = { page = p, tab = t, section = sec } end
					end
				end
			end
		end
		dirty = false
		dropViews()
	end
	return homes
end

-- A registration later than the homes (a module loading late): built again.
-- G.TREE edited, or a page registered: the tree, the homes and the views
-- are built again.
function G.Invalidate()
	dirty, tree = true, nil
end
W.OnOptionsRegistered(function() G.Invalidate() end)

local function eachSetting(c, fn)
	fn(c)
	for _, e in ipairs(c.extras or {}) do fn(e) end
	for _, m in ipairs(c.more or {}) do eachSetting(m, fn) end
end

local function modified(x)
	return x.key ~= nil and x.kind ~= "button" and x.kind ~= "binding" and K.available(x) and W.Modified(x.key) and true or false
end

-- A section's on/off counts as changed where it has its home (a switch in
-- several headers, in the first), and not where a row holds it too.
local function toggleChanged(sec)
	local t = sec.toggle
	if not (t and t.key and modified(t)) then return false end
	local h = toggleHomes()[t.key]
	if not (h and h.section == sec) then return false end
	for _, c in ipairs(homeRows(sec)) do if c.key == t.key then return false end end
	return true
end

local function rowChanged(c)
	local hit = false
	eachSetting(c, function(x) if modified(x) then hit = true end end)
	return hit
end

-- New since the player last opened its page (the sidebar's count).
local function unseen(c)
	if not (c.new and c.page) then return false end
	local seen = K.seenTable()
	return K.newer(c.new, seen[c.page.key]) and K.newer(c.new, seen["*"])
end

-- fn(sec, rows, p, t) for every section on screen in a page's tabs (rows:
-- homes only, as counted).
local function eachPageShown(p, fn)
	if p.custom then return end
	for _, t in ipairs(p.tabs) do
		for _, sec in ipairs(t.sections) do
			if K.sectionShown(sec) then fn(sec, homeRows(sec), p, t) end
		end
	end
end

local function countsOf(walk, x)
	local changed, fresh = 0, 0
	walk(x, function(sec, rows)
		if toggleChanged(sec) then changed = changed + 1 end
		for _, c in ipairs(rows) do
			if rowChanged(c) then changed = changed + 1 end
			if unseen(c) then fresh = fresh + 1 end
		end
	end)
	return changed, fresh
end
local function pageCounts(p) return countsOf(eachPageShown, p) end

-- Where a control lives (an extra, a cog's setting: the row it is on; a
-- reference: its home's row). -> { page, tab, section }, the row's control
local function homeOf(c)
	local root = c
	while root.psOwner do root = root.psOwner end
	if rawget(root, "ref") then root = O.HomeOf(root) or root end
	local sec = rawget(root, "psSection")
	local p = rawget(root, "page")
	if not (sec and p and sec.psTab) then return nil, root end
	return { page = p, tab = sec.psTab, section = sec }, root
end

-- The crumb's start: "Group › Page", the name once where a group's page
-- is named as the group is (any case).
local function headOf(at)
	local g = groupOfPage(at.page)
	if not g or g.label:lower() == at.page.name:lower() then return at.page.name end
	return g.label .. SEP .. at.page.name
end

-- "Group › Page › Tab › Section" (the tab where the page has more than one).
local function pathOf(at)
	local out = headOf(at)
	if #pageTabs(at.page) > 1 and at.tab.name ~= "" then out = out .. SEP .. at.tab.name end
	local name = at.section.name
	if name and name ~= "" then out = out .. SEP .. name end
	return out
end
G.PathOf = function(c)
	local at = homeOf(c)
	return at and pathOf(at) or nil
end

---------------------------------------------------------------------------
-- The sidebar
---------------------------------------------------------------------------

local search = O.Search

-- Where a hit lives here, "page › tab" (its section where the tab has no
-- name; the group before the page where neither has).
local function hitTitle(at)
	local tab = at.tab.name
	if not tab or tab == "" then tab = at.section.name end
	if not tab or tab == "" then
		return headOf(at)
	end
	return at.page.name .. SEP .. tab
end

-- A search result's card is titled with where the setting lives here.
function O.Search(q)
	local groups, count, suggestions, page = search(q)
	if G.On() and type(groups) == "table" then
		for _, gr in ipairs(groups) do
			local c = gr.controls and gr.controls[1]
			local at = c and homeOf(c)
			if at then gr.title = hitTitle(at) end
		end
	end
	return groups, count, suggestions, page
end

---------------------------------------------------------------------------
-- The sidebar
---------------------------------------------------------------------------

-- A sidebar click: a group (on its page last shown) or a page.
local function navSelect(key)
	O.Select(key)
end

-- The sidebar the window already has (W.ShellNav): a header for each group of
-- the tree, the one shown open on its pages (none while a search is open),
-- each page marked as the classic page's are: a ring while it holds settings
-- new to the player, else a dot while one is off its default.
function G.NavItems()
	local items = {}
	local searching = K.query() ~= ""
	for _, g in ipairs(G.Tree()) do
		local open = not searching and shown and g.key == st.group
		items[#items + 1] = { group = true, key = "b:" .. g.key, label = g.label, folded = not open }
		if open then
			for _, p in ipairs(g.pages) do
				if pageShown(p) or p == B.page then
					local changed, fresh = pageCounts(p)
					local new = fresh > 0
					local off = not new and changed > 0
					items[#items + 1] = { key = p.key, label = p.name, icon = p.icon, indent = true, dot = p.dot and p.dot() or nil,
						new = new or nil, changed = off or nil,
						markTip = new and L["New settings on this page"] or off and L["Settings on this page changed from their default"] or nil }
				end
			end
		end
	end
	return items
end

-- The sidebar key of what is on screen (nil while a search is open).
function G.NavKey()
	if not (shown and G.On()) or K.query() ~= "" then return nil end
	return B.navKey
end

---------------------------------------------------------------------------
-- The chrome: the header's crumb, the index
---------------------------------------------------------------------------

-- The header's line one: the breadcrumb, "Group › Page", then the
-- description (the header lays them out, W.HeaderScale's "Search first").
local function drawCrumb(group, page, desc)
	B.crumb = { group, page }
	local text = group and page and (group:lower() == page:lower() and page or group .. SEP .. page) or group or page or ""
	W.ShellTitle(win(), text, desc)
end
function G.Crumb()
	local c = B.crumb or {}
	return c[1], c[2]
end

-- The index under the tabs (the shell's pinned slot): links, the count.
local function strip()
	if B.Strip then return B.Strip end
	local s = CreateFrame("Frame", nil, W.ShellPreviewSlot(win()))
	s.Count = W.Text(s, "small", "textMuted")
	s.Count:SetJustifyH("RIGHT")
	s:Hide()
	B.Strip = s
	return s
end

local function stripLink(i)
	local l = B.links[i]
	if l then return l end
	local s = strip()
	-- A tab as the row above draws its own (W.ShellTabs), one size down.
	l = CreateFrame("Button", nil, s)
	l:SetHeight(STRIP - 6)
	l.Label = W.Text(l, "label", "textDim")
	l.Label:SetPoint("CENTER", l, "CENTER", 0, 0)
	Theme.Skin(l, "tab")
	l:SetScript("OnClick", function(self) if self.psClick then self.psClick(self) end end)
	l:SetScript("OnEnter", function(self) if not self.psOn then W.Color(self.Label, "text") end end)
	l:SetScript("OnLeave", function(self) if not self.psOn then W.Color(self.Label, "textDim") end end)
	B.links[i] = l
	return l
end

-- i: the lit entry. One folded under More (drawStrip) lights More, which
-- takes its name.
local function lightLink(i)
	B.lit = i
	local at = B.moreIdx
	local more = at and B.links[at]
	if more then
		local folded = i and i >= B.moreFrom and i < at and B.entries and B.entries[i]
		more.Label:SetText(folded and folded.label or L["More"])
		more:SetWidth(floor(more.Label:GetStringWidth() + 24 + 14 + 0.5))
		if folded then i = at end
	end
	for j, l in ipairs(B.links) do
		local on = j == i
		l.psOn = on
		Theme.SetTabSelected(l, on)
		local kit = Theme.KitTab(l, on, l.Label)
		if not kit then
			l.Label:ClearAllPoints()
			l.Label:SetPoint(j == at and "LEFT" or "CENTER", l, j == at and "LEFT" or "CENTER", j == at and 12 or 0, 0)
		end
		l.psKit = kit
		W.Color(l.Label, on and "text" or (kit and "tabRest" or "textDim"))
		if rawget(l, "Chev") then l.Chev:SetShown(j == at) end
	end
end

-- entries: { { label, onClick, on } }; count: the right-hand note or nil.
-- The links that don't fit fold under a last one, More, its menu theirs.
local function drawStrip(entries, count, width)
	local s = strip()
	B.entries = entries
	s.Count:SetText(count or "")
	s.Count:ClearAllPoints()
	s.Count:SetPoint("RIGHT", s, "RIGHT", -SH.pad, 0)
	local room = width - SH.pad * 2 - (count and s.Count:GetStringWidth() + 16 or 0)
	local widths, total = {}, 0
	for i, e in ipairs(entries) do
		local l = stripLink(i)
		l.Label:SetText(e.label)
		widths[i] = floor(l.Label:GetStringWidth() + 24 + 0.5)
		total = total + widths[i] + (i > 1 and 4 or 0)
	end
	-- Room for More, its widest label, when they don't all fit.
	local fold
	if total > room then
		local probe = stripLink(#entries + 1)
		probe.Label:SetText(L["More"])
		local moreW = floor(probe.Label:GetStringWidth() + 24 + 14 + 0.5)
		local x = 0
		fold = 1
		for i = 1, #entries do
			if x + widths[i] + 4 + moreW > room then break end
			x = x + widths[i] + 4
			fold = i + 1
		end
	end
	local x, lit = 0, nil
	local shown = fold and (fold - 1) or #entries
	for i, e in ipairs(entries) do
		local l = stripLink(i)
		l.Label:SetText(e.label)
		l:SetWidth(widths[i])
		l:ClearAllPoints()
		l:SetPoint("BOTTOMLEFT", s, "BOTTOMLEFT", SH.pad - 12 + x, 0)
		l.psClick = e.onClick
		l:SetShown(i <= shown)
		if e.on then lit = i end
		if i <= shown then x = x + widths[i] + 4 end
	end
	local n = #entries
	B.moreIdx, B.moreFrom = nil, nil
	if fold then
		n = n + 1
		local m = stripLink(n)
		if not rawget(m, "Chev") then
			m.Chev = W.Tex(m, "ARTWORK", "chevron-down", "textMuted")
			m.Chev:SetSize(10, 10)
			m.Chev:SetPoint("LEFT", m.Label, "RIGHT", 4, 0)
		end
		m:ClearAllPoints()
		m:SetPoint("BOTTOMLEFT", s, "BOTTOMLEFT", SH.pad - 12 + x, 0)
		m.psClick = function(self)
			local items = {}
			for i = fold, #entries do
				local e = entries[i]
				items[#items + 1] = { text = e.label, checked = B.lit == i, onClick = e.onClick }
			end
			W.ShowMenu(self, items)
		end
		m:Show()
		-- Folded entries still light by index (lightLink): More stands for them.
		B.moreIdx, B.moreFrom = n, fold
	end
	for i = n + 1, #B.links do B.links[i]:Hide() end
	lightLink(lit)
end

-- The body's scroll starts under the index while one stands there.
local function scrollRoom()
	local w = win()
	local sf = w.Scroll
	sf:ClearAllPoints()
	local ph = w.psPreviewH or 0
	sf:SetPoint("TOPLEFT", w.Content, "TOPLEFT", 0, -(4 + ph))
	sf:SetPoint("BOTTOMRIGHT", w.Content, "BOTTOMRIGHT", -4, 4)
end

---------------------------------------------------------------------------
-- Views
---------------------------------------------------------------------------

-- The on/off a reference in the section waits on, while it is off: the
-- nearest switch that is off wins. Its home follows rows up a chain (Sound
-- under Play a sound under Alert for rares; Route lines over its Line
-- style), looked at nearest first, then its home row's section's switch,
-- drawn in another card, last (the section's own switch stands in its
-- header, and a row that is the switch, or holds it as an extra, needs no
-- line); one this section holds is passed over (it shows here). -> { toggle, home = { page, tab, section } } or nil, home the
-- place of that on/off. Every on/off looked at goes in B.depKeys, so its
-- change lays the tab out again.
local function holds(sec, key)
	if sec.toggle and sec.toggle.key == key then return true end
	for _, x in ipairs(sec.controls) do
		local found = false
		eachSetting(x, function(y) if y.key == key then found = true end end)
		if found then return true end
	end
	return false
end

local function dependency(sec)
	local found
	for _, c in ipairs(sec.controls) do
		local h = rawget(c, "ref") and O.HomeOf(c)
		local hs = h and rawget(h, "psSection")
		if hs and hs ~= sec and h.page and hs.psTab then
			-- Nearest first: the home's parents up, then its section's switch.
			local chain = {}
			local parent, seen = rawget(h, "psParent"), { [h] = true }
			while parent and not seen[parent] do
				seen[parent] = true
				if not holds(sec, parent.key) then chain[#chain + 1] = parent end
				parent = rawget(parent, "psParent")
			end
			if hs.toggle then chain[#chain + 1] = hs.toggle end
			for _, tg in ipairs(chain) do
				if tg.key and tg.kind == "toggle" and K.available(tg) then
					local held = false
					eachSetting(c, function(x) if x.key == tg.key then held = true end end)
					if not held then
						B.depKeys[tg.key] = true
						if not found and not ns.Get(tg.key) then
							local ts = rawget(tg, "psSection") or hs
							found = { toggle = tg, home = { page = rawget(tg, "page") or h.page, tab = ts.psTab or hs.psTab, section = ts } }
						end
					end
				end
			end
		end
	end
	return found
end
-- For the tests: a section's dependency line, worked out.
G._dependency = dependency

-- The dependency line: a row of the section, its button the way to the
-- switch ("Group › Page").
local depRows = {}
local function depRow(sec)
	local d = dependency(sec)
	if not d then return nil end
	local row = depRows[sec]
	local label = string.format(L["Turn on %s first."], K.labelOf(d.toggle) or "")
	local button = headOf(d.home)
	if not row or row.label ~= label or row.button ~= button then
		row = { kind = "button", wide = true, label = label, button = button, help = pathOf(d.home),
			onClick = function() G.ShowSection(d.home) end }
		depRows[sec] = row
	end
	return row
end

-- A page's tab, as the classic page builds it (K.buildView) with the
-- dependency lines first in their sections; its own
-- view, not the classic page's. v.psGroups / v.psRows: its sections on
-- screen and their rows (the index reads them). A module's switch lays the
-- tab out again (its card folds or opens); the rows a jump asked for
-- (B.reveal) show in a folded card.
local function tabView(p, t)
	if p.custom then
		p.views = p.views or {}
		local v = p.views[t.name]
		if not v then
			v = K.buildView(p, t)
			p.views[t.name] = v
		end
		return v
	end
	local id = p.key .. "\1" .. t.name
	local v = B.views[id]
	if v and v.psTab == t then return v end
	if v then v:Hide() end
	v = K.buildView(p, t, { lead = depRow })
	local refresh = v.Refresh
	v.Refresh = function()
		v.psReveal = B.reveal
		-- An Essentials row's link to its home, in its row before the layout.
		if rawget(t, "psEssentials") and G.EssentialsLinks then G.EssentialsLinks(v, t) end
		for _, sec in ipairs(t.sections) do
			local tg = sec.toggle
			if tg and tg.key then B.depKeys[tg.key] = true end
		end
		local h = refresh()
		local groups, total = {}, 0
		for _, sec in ipairs(t.sections) do
			if secShown(sec) then
				groups[#groups + 1] = { section = sec }
				total = total + #rowsOf(sec)
			end
		end
		v.psGroups, v.psRows = groups, total
		return h
	end
	B.views[id] = v
	return v
end

---------------------------------------------------------------------------
-- Showing a page's tab
---------------------------------------------------------------------------

-- Hide what this layout puts on the window (its views too).
local function hideChrome()
	local w = win()
	if not w then return end
	for _, v in pairs(B.views) do v:Hide() end
	if B.Strip then B.Strip:Hide() end
	W.ShellTabs(w, nil)
	B.entries = nil
	W.ShellLayout(w)
end

-- A search opens over the layout: its chrome goes until the search closes.
function G.Searching()
	if shown then
		hideChrome()
		W.ShellPreview(win(), nil)
	end
end

local function leave()
	hideChrome()
	shown = false
end

-- The seen record: the pages of the rows on screen are seen (the rows keep
-- their badges this session, as on the classic pages).
local function markSeen(controls)
	local seen = K.seenTable()
	for _, c in ipairs(controls) do
		if c.new and c.page and K.newer(c.new, seen[c.page.key]) then seen[c.page.key] = c.new end
	end
end

---------------------------------------------------------------------------
-- The header, "Search first": no footer, the scale and Move frames in ···,
-- Reload UI beside it (the current page keeps its own)
---------------------------------------------------------------------------

-- Reload UI and ··· (made the first time the new page shows), first of the
-- header's tools: right to left, ···, Reload UI, Fold, Peek, (Move frames),
-- the switch, the search.
local function newTools()
	local w = win()
	if B.Menu then return end
	B.Reload = W.IconButton(w.Header, "reload", 24, L["Reload UI"], function() if ReloadUI then ReloadUI() end end, W.HEAD_GLYPH)
	B.Menu = W.HeaderMenu(w.Header, function() return G.MenuItems() end)
	w.HeaderMenu, w.ReloadButton = B.Menu, B.Reload
	w.psHeadTools = w.psHeadTools or {}
	table.insert(w.psHeadTools, 1, B.Menu)
	table.insert(w.psHeadTools, 2, B.Reload)
end

-- The window's header and footer for the new page (on) or the current one.
local function headerMode(on)
	local w = win()
	if not w then return end
	if on then
		newTools()
	elseif not (rawget(w, "psSearchFirst") or rawget(w, "psNoFooter")) then
		return
	end
	W.ShellSetFooter(w, not on)
	w.psSearchFirst = on or nil
	B.Menu:SetShown(on)
	B.Reload:SetShown(on)
	local move = rawget(w, "MoveButton")
	if move then move:SetShown(not on) end
	if rawget(w, "HeaderTools") then w.HeaderTools.Place() end
	O.UndoAnchor(w)
	if not on then K.renderFooter(nil) end
end

-- What ··· holds: Menu scale (a slider in the menu itself, written when the
-- drag ends: it rescales the window and the menu it sits in), Move frames,
-- then the two resets, each asking first and naming its scope (the page on
-- screen; the profile in use).
local MENU_SCALE = { kind = "slider", key = "ui.menuScale", label = L["Menu scale"], icon = "sliders",
	min = 0.7, max = 1.4, step = 0.05, release = true, format = function(v) return floor(v * 100 + 0.5) .. "%" end }
function G.MenuItems()
	local M = ns.Movers
	local p = G.Current() or O.page
	return {
		{ text = L["Menu scale"], slider = MENU_SCALE },
		{ text = L["Move frames"], icon = "resize", disabled = not (M and M.Unlock) or nil, onClick = function() O.MoveFrame(nil) end },
		{ text = L["Reset this page\226\128\166"], icon = "reset", danger = true,
			disabled = not (p and K.pageShowsSetting(p)) or nil, onClick = function() O.AskResetPage(p) end },
		{ text = L["Reset all settings\226\128\166"], icon = "reset", danger = true, onClick = function() O.AskResetAll() end },
	}
end

-- opts: { page, tab (a tab of the page, or its name), keep (the scroll and
-- the place as they are) }. With no page, the page on screen (else the
-- first group's first page).
function render(opts)
	opts = opts or {}
	local w = win()
	if not w then return end
	local scroll = opts.keep and w.Scroll:GetVerticalScroll() or 0
	-- ··· stays open through a layout its Menu scale slider set off (the
	-- window resized); any other list goes with the page it was opened on.
	if not W.MenuShown(B.Menu) then W.HideMenu() end
	O.HideMore()
	if O.Dropdown then O.Dropdown.Hide() end
	K.hideViews()
	toggleHomes()
	for _, v in pairs(B.views) do v:Hide() end
	K.clearQuery()
	local tree = G.Tree()
	local p = opts.page or B.page
	local g = p and groupOfPage(p, tree)
	if not g then
		g = tree[1]
		p = g.pages[1]
		for _, gp in ipairs(g.pages) do if pageShown(gp) then p = gp break end end
	end
	st.group, st.page[g.key] = g.key, p.key
	local tabs = pageTabs(p)
	local tab = opts.tab or (opts.keep and B.tab) or st.tab[p.key]
	local pick
	for _, t in ipairs(tabs) do if t == tab or t.name == tab then pick = t end end
	tab = pick or tabs[1]
	st.tab[p.key] = tab.name
	B.page, B.tab, B.group = p, tab, g
	if not opts.keep then B.reveal = opts.reveal end
	shown = true
	B.depKeys = {}
	headerMode(true)
	W.ShellLayout(w)
	-- The page's tabs in the tab row (none for a page of one unnamed tab).
	local list
	if #tabs > 1 or tabs[1].name ~= "" then
		list = {}
		for i, t in ipairs(tabs) do list[i] = { key = t.name, label = t.name } end
	end
	W.ShellTabs(w, list, tab.name, function(key) render({ page = p, tab = key }) end)
	local view = tabView(p, tab)
	drawCrumb(g.label, p.name, p.subtitle or SUBTITLES[p.key])
	local h = view.Refresh()
	view:SetHeight(h)
	view:Show()
	-- The index under the tabs, for a long tab.
	local entries
	if not p.custom and (view.psRows or 0) > LONG then
		entries = {}
		local last
		for n, gr in ipairs(view.psGroups or {}) do
			local label = gr.section.name or ""
			if label ~= "" and label ~= last then
				local card = view.cards[n]
				local at = #entries + 1
				entries[at] = { label = label, card = card, onClick = function()
					W.ScrollTo(w.Scroll, max(0, (card.psTop or 0) - 12))
					-- One the scroll can't bring to the top is still the one asked for.
					lightLink(at)
				end }
				last = label
			end
		end
		-- One section is the tab itself: no index for it.
		if #entries > 1 then
			drawStrip(entries, string.format(L["%d settings"], view.psRows), w.psMainW)
		else
			entries = nil
		end
	end
	B.entries = entries
	if entries and #entries > 0 then
		strip():Show()
		W.ShellPreview(w, strip(), STRIP)
	else
		if B.Strip then B.Strip:Hide() end
		W.ShellPreview(w, nil)
	end
	scrollRoom()
	W.ShellBody(w, h)
	W.ScrollTo(w.Scroll, scroll)
	-- The seen record, the sidebar.
	if not p.custom then
		local all = {}
		for _, sec in ipairs(tab.sections) do for _, c in ipairs(sec.controls) do all[#all + 1] = c end end
		markSeen(all)
	end
	B.navKey = p.key
	W.ShellNav(w, G.NavItems(), B.navKey, navSelect)
	O.UndoAnchor(w)
	-- What Options.lua holds as on screen: the page and its tab, so leaving a
	-- search (or the switch) comes back here.
	K.setCurrent(p, tab)
	O.page, O.view = p, view
	if not opts.keep then Anim.To(view, "alpha", 0, 1, Anim.FAST, "out") end
	if B.Switch then B.Switch.Sw:Refresh() end
end
G.Render = render
-- The index's entries in view (the tests read them).
function G._entries() return B.entries or {} end

-- The page and its tab on screen. -> p, t
function G.Current()
	return B.page, B.tab
end

-- The window's O.Select while the layout is on: a group ("b:look", on its
-- page last shown), or a page key (and tab). -> handled
function G.Select(key, tabName)
	if not G.On() then
		if shown then leave() end
		headerMode(false)
		return false
	end
	if type(key) == "string" and key:sub(1, 2) == "b:" then
		local tree = G.Tree()
		local g = groupBy(key:sub(3), tree)
		local p
		if g then
			for _, gp in ipairs(g.pages) do if gp.key == st.page[g.key] then p = gp end end
			if not p then
				for _, gp in ipairs(g.pages) do if not p and pageShown(gp) then p = gp end end
			end
		end
		render({ page = p, tab = tabName })
		return true
	end
	local p, aliasTab = nil, nil
	if key then p, aliasTab = K.pageByKey(key) end
	render({ page = p, tab = tabName or aliasTab })
	return true
end

-- The page on screen laid out again in place (a new size or font, a section
-- shown or hidden, a dependency's switch). -> handled
function G.Relayout()
	if not (G.On() and shown) then return false end
	render({ keep = true })
	return true
end

-- LB / RB: the next or previous tab, on into the next page's first (from
function G.StepTab(delta)
	if not G.On() then return false end
	local list, at = {}, nil
	local from = { page = B.page, tab = B.tab }
	for _, g in ipairs(G.Tree()) do
		for _, p in ipairs(g.pages) do
			if pageShown(p) then
				for _, t in ipairs(pageTabs(p)) do
					list[#list + 1] = { p, t }
					-- By name: the Essentials tab is built again after a registration.
					if p == from.page and from.tab and t.name == from.tab.name then at = #list end
				end
			end
		end
	end
	local to = list[(at or 0) + delta]
	if to then render({ page = to[1], tab = to[2] }) end
	return true
end

-- A section's tab ({ page, tab, section }), the section scrolled under the
-- body's top and lit.
function G.ShowSection(at)
	render({ page = at.page, tab = at.tab })
	local view = O.view
	for _, card in ipairs(view and view.cards or {}) do
		if card:IsShown() and card.psSection == at.section then
			W.ScrollTo(win().Scroll, max(0, (card.psTop or 0) - 16))
			O.Flash(card.Header)
			return card
		end
	end
end

-- A row's place here, scrolled into view and lit (a search result, a
-- preview's hotspot, What's New). -> the row, or nil
function G.Jump(c)
	local at, root = homeOf(c)
	if not at then return nil end
	-- In a card folded by its module's switch, the row shows dimmed.
	local line = root
	while rawget(line, "psChildOf") do line = line.psChildOf end
	render({ page = at.page, tab = at.tab, reveal = { [line] = true } })
	local view = O.view
	if not (view and view.cache) then return nil end
	local w, top = view.cache[root], nil
	-- A child while its parent is off: the parent's row.
	local kidOf = rawget(root, "psChildOf")
	if kidOf and not (w and w:IsShown()) and view.cache[kidOf] then w = view.cache[kidOf] end
	if w then
		top = w.psTop
	elseif view.extras[c] then
		w = view.extras[c]:GetParent()
		top = w:GetParent().psTop
	else
		for _, card in ipairs(view.cards or {}) do
			if card:IsShown() and card.psSection == at.section then w, top = card.Header, card.psTop end
		end
	end
	if not (w and w:IsShown()) then return nil end
	W.ScrollTo(win().Scroll, max(0, (top or 0) - 40))
	O.Flash(w)
	return w
end

-- The scroll's place: the index lights the section in view.
-- A section lights once its top is 24 under the body's top. The sections
-- the scroll can't bring up so far (the last ones, short) share the scroll's
-- last stretch, from the last one that can to the end, in turn: scrolled to
-- the end, the last one is lit.
local function spy(_, cur, range)
	local list = B.entries
	if not (shown and list and list[1] and list[1].card) then return end
	range = range or cur
	local marks, reach = {}, 0
	for i, e in ipairs(list) do
		marks[i] = e.card and max(0, (e.card.psTop or 0) - 24) or 0
		if marks[i] <= range then reach = i end
	end
	local n = #list
	if reach < n then
		local from = reach > 0 and marks[reach] or 0
		local share = (range - from) / (n - reach + 1)
		for i = reach + 1, n do marks[i] = from + share * (i - reach) end
		-- At the very end the last one, whatever the rounding.
		marks[n] = min(marks[n], range)
	end
	local lit = 1
	for i = 1, n do if marks[i] <= cur then lit = i end end
	lightLink(lit)
end

-- The pages whose settings offer a reload when the window closes (some of
-- a look's parts are drawn once, at login): the guide window and the look
-- pages. One of them changed while the window was up: on its close a
-- reload is offered, recommended, and may be skipped. Not when the window
-- only steps aside for Move frames (O.MoveFrame), whose own bar brings it
-- back.
G.RELOAD_PAGES = { guidewindow = true, theme = true, buttons = true, alerts = true, trackers = true }
local reloadAsk = false
ns.On("SETTING_CHANGED", function(path)
	if not (shown and G.On() and type(path) == "string") then return end
	local c = O.HomeControl(path)
	if c and c.page and G.RELOAD_PAGES[c.page.key] then reloadAsk = true end
end)

local function offerReload()
	if not reloadAsk then return end
	local M = ns.Movers
	local w = win()
	if (w and w:IsShown()) or (M and M.IsUnlocked and M.IsUnlocked()) then return end
	reloadAsk = false
	W.Modal({ title = L["Reload to finish?"], icon = "reload", action = L["Reload UI"], cancel = L["Not now"],
		text = L["Some guide window and look changes only show in full after a reload. Recommended."],
		onAccept = function() if ReloadUI then ReloadUI() end end })
end
G._offerReload = offerReload

-- A dependency's switch changed: the tab lays out again.
ns.On("SETTING_CHANGED", function(path)
	if not (G.On() and type(path) == "string" and win() and win():IsShown()) then return end
	if K.query() == "" and shown and B.depKeys[path] then G.Relayout() end
end)

---------------------------------------------------------------------------
-- The switch: "New settings page" in the header, in both layouts
---------------------------------------------------------------------------

local SWITCH_ROOM, fitSwitch = 1000, nil

-- Where the switch stands: on the current page after Menu scale (before the
-- close button); on the new page first of the icon buttons, right of the
-- search (the tools list runs right to left, the search last).
local function placeSwitch()
	local w, b = win(), B.Switch
	if not (w and b) then return end
	b.psHeadAfterScale = not G.On() or nil
	local list = rawget(w, "psHeadTools")
	if not list then return end
	for i = #list, 1, -1 do if list[i] == b then table.remove(list, i) end end
	local at = #list + 1
	if G.On() then
		for i, t in ipairs(list) do if t == rawget(w, "Search") then at = i break end end
	end
	table.insert(list, at, b)
end
function G.Switch() return B.Switch end

-- The texts shown under root: its shown FontStrings, in the order found.
function G.NewPageText(root)
	local out = {}
	local function walk(f)
		if f.IsShown and not f:IsShown() then return end
		for _, r in ipairs({ f:GetRegions() }) do
			if r.GetText and r:IsShown() then
				local t = r:GetText()
				if type(t) == "string" and t ~= "" then out[#out + 1] = t end
			end
		end
		for _, c in ipairs({ f:GetChildren() }) do walk(c) end
	end
	walk(root)
	return out
end

function G.SetOn(on)
	local w = win()
	local was = G.On()
	ns.DB().optionsLayout = on and "grouped" or nil
	if B.Switch then B.Switch.Sw:Refresh() end
	placeSwitch()
	if not (w and w:IsShown()) or was == (on and true or false) then return end
	if on then
		local current, currentTab = K.current()
		O.Select(current and current.key, currentTab and currentTab.name)
	else
		-- The classic page opens where this one was.
		local key, tabName = B.page and B.page.key, B.tab and B.tab.name
		leave()
		-- The footer back (then filled by the current page's own select).
		headerMode(false)
		O.Select(key, tabName)
	end
	fitSwitch()
end

-- The switch's label while the header has room for it (a main column of
-- SWITCH_ROOM); the switch alone, its tooltip naming it, in a narrower one.
function fitSwitch()
	local w, b = win(), B.Switch
	if not (w and b) then return end
	local room = (tonumber(rawget(w, "psMainW")) or 0) >= SWITCH_ROOM
	b.Label:SetShown(room)
	b:SetWidth(floor(b.Sw:GetWidth() + (room and (4 + b.Label:GetStringWidth()) or 0) + 0.5))
	if rawget(w, "HeaderTools") then w.HeaderTools.Place() end
end

local function ensureSwitch()
	local w = win()
	if not w or B.Switch then return end
	local b = CreateFrame("Button", nil, w.Header)
	b:SetHeight(24)
	b.Sw = W.Switch(b, G.On, function(v) G.SetOn(v) end)
	b.Sw:SetPoint("LEFT", b, "LEFT", 0, 0)
	b.Label = W.Text(b, "label", "textDim")
	b.Label:SetText(L["New settings page"])
	b.Label:SetPoint("LEFT", b.Sw, "RIGHT", 4, 0)
	b:SetWidth(floor(b.Sw:GetWidth() + 4 + b.Label:GetStringWidth() + 0.5))
	local lines = { L["A preview of the settings in groups, with tabs, a filter and a preview beside the rows. The same settings; switch it off for the current page."] }
	b.Sw.psTip, b.Sw.psTipLines = L["New settings page"], lines
	b:SetScript("OnClick", function() G.SetOn(not G.On()) end)
	b:SetScript("OnEnter", function(self)
		W.Color(self.Label, "text")
		W.Tooltip(self, "ANCHOR_BOTTOM", L["New settings page"], lines)
	end)
	b:SetScript("OnLeave", function(self)
		W.Color(self.Label, "textDim")
		W.HideTooltip(self)
	end)
	B.Switch = b
	w.psHeadTools = w.psHeadTools or {}
	w.psHeadTools[#w.psHeadTools + 1] = b
	placeSwitch()
	fitSwitch()
	w:HookScript("OnSizeChanged", fitSwitch)
	-- The grip let go: the layout fits the window's new size.
	local grip = rawget(w, "Grip")
	if grip then grip:HookScript("OnMouseUp", function() if shown then G.Relayout() end end) end
	w.Scroll.psOnScroll = spy
	-- Closed: the reload offer, a frame on (Move frames hides the window first, then unlocks).
	w:HookScript("OnHide", function()
		if ns.After then ns.After(0, offerReload) else offerReload() end
	end)
end

local show = UI.ShowOptions
function UI.ShowOptions(...)
	-- The saved choices moved before the first render (show draws the page).
	local r = show(...)
	ensureSwitch()
	if B.Switch then B.Switch.Sw:Refresh() placeSwitch() fitSwitch() end
	return r
end
