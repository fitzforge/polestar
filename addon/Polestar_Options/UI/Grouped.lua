-- The settings window's grouped layout ("New settings page", a preview the
-- player turns on in the window's header; PolestarDB.optionsLayout =
-- "grouped", account-wide, off by default). The same window and the same
-- rows as the classic layout, from the same registry and through
-- UI/Options.lua's own pieces (UI.Options.Kit), laid out in fewer doors:
--
--   the sidebar      a tree: the groups of G.TREE (Guiding, Look, Quality
--                    of Life, Setup), the one shown open on its pages (the
--                    classic pages, another addon's among them), each page's
--                    changed count; every group open while Expand all is on
--                    (PolestarDB.optionsNavAll). Then the settings pinned
--                    there, each a live control on its setting, About and
--                    Guiding Stars, and the profile card (Switch) at its
--                    foot. A group's and a
--                    page's New ring, a group's hits while a search is open.
--                    Folded to an icon rail (PolestarDB.optionsRail), a
--                    group's icon opens its pages as a fly-out
--   a page           its own tabs, the classic page's, in the tab band, and
--                    each tab's rows as the classic page lays them out
--   the header       "Search first": a "Group › Page" crumb and the
--                    description, then the wide search, the switch, Peek,
--                    Fold, Reload UI and ··· (Settings scale, Move frames, the
--                    resets); Undo beside the crumb; no footer
--   the tab band     at its right end the filter, then Preview (on a page
--                    with a live preview: shows or hides it)
--   All / Changed    a filter over the whole window: Changed shows one card
--                    per page with changes ("Group › Page", its count, its
--                    Reset, a link there) and a jump tab for each; Esc, the
--                    close button and the switch go back to the page
--   the index        under the tabs, for a tab of more than 30 rows: its
--                    sections as jump links, the one in view lit as the selected tab
--   beside the rows  on a page with a live preview (UI/Preview.lua), that
--                    preview alone; under a 1240 wide window over the rows.
--                    Preview in the tab band hides it
--                    (PolestarDB.optionsPreviewHidden, account-wide)
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
-- order a player meets them (docs/superpowers/specs/2026-11-17-settings-ia-
-- review.md, section 4): the first quest before the map's tweaks, Discovery
-- now and then; the guide window sized before the look is changed.
-- The rule: the sidebar shows two levels at most, groups then rows. A row is
-- a place a player names; a tab is a facet of one place (the parts of one
-- window, the cards of one alert). A group with several pages lists its
-- pages, a page with facets keeping them as tabs. A group with exactly one
-- page lists that page's tabs as its rows: the page row is not drawn (it
-- would double the group's name) and the page's folder tabs are not drawn
-- (the rows are the tabs). The page and its tabs stay registered as they
-- are, so saved keys, search jumps, pins and LB / RB keep working.
G.TREE = {
	{ key = "guiding", label = L["Guiding"], icon = "star",
		pages = { "guide", "questing", "map", "discovery" } },
	{ key = "qol", label = L["Quality of Life"], iconPage = "qualityoflife",
		pages = { "qualityoflife" } },
	{ key = "look", label = L["Look"], iconPage = "theme",
		pages = { "guidewindow", "theme", "arrow", "mappins", "routelines", "buttons", "alerts", "trackers" } },
	{ key = "setup", label = L["Setup"], iconPage = "profiles",
		pages = { "language", "profiles", "integrations", "guidepacks", "gamepad", "recorder" } },
	-- foot: the group's pages stand at the sidebar's foot, over the profile
	-- card, as rows of their own (folded to the rail, a group like the rest).
	{ key = "about", label = L["About"], iconPage = "about", foot = true,
		pages = { "about", "thanks" } },
}

-- SEP: a crumb's separator (" › "). WIDE: the window width from which the
-- side card stands beside the rows. LONG: rows past which a tab shows its
-- index. STRIP: the index's height. SIDE: the side card's width bounds and
-- its gap to the rows and to the window's edge. PIN_MAX: the settings the
-- sidebar holds pinned at most.
local SEP = " \226\128\186 "
local WIDE, LONG, STRIP = 1240, 30, 34
local SIDE = { MIN = 300, MAX = 400, GAP = 16, EDGE = 16 }
local PIN_MAX = 8

local SUBTITLES = {
	guidewindow = L["The guide window's frame, bars, step card, tips and progress bar."],
	guiding = L["What Polestar does for you while you level: suggestions, quests, rewards, buttons, rares."],
	arrowmap = L["The arrow, its routes, and what Polestar draws on the world map and the minimap."],
	look = L["The theme every Polestar window wears, the action buttons, the alert cards and the trackers."],
	setup = L["Profiles, other addons, community guides and gamepad."],
}

local homes, dirty = nil, true
-- st.group (the group shown), st.page[group key] (its page last shown),
-- st.tab[page key] (its tab last shown), st.filter ("all", "changed": the
-- whole window's).
local st = { page = {}, tab = {}, filter = "all" }
local B = { views = {}, links = {}, depKeys = {} }
local shown = false
local render, navSelect, hookPins, changedKeys, changedTabs, changedJump

-- The Preview panel hidden (its button): PolestarDB.optionsPreviewHidden,
-- account-wide, not a setting: true hidden, false shown, nil not chosen yet
-- (shown beside the rows, hidden where it would stand over them).
local function previewHidden(wide)
	local v = ns.DB().optionsPreviewHidden
	if v == nil then return not wide end
	return v and true or false
end

-- The side card's old saved choice (PolestarDB.optionsSideHidden) moved
-- into optionsPreviewHidden, while that one is not chosen yet; once a
-- session. -> nothing
local migrated = false
function G.MigrateSaved()
	if migrated then return end
	migrated = true
	local db = ns.DB()
	if db.optionsSideHidden ~= nil and db.optionsPreviewHidden == nil then
		db.optionsPreviewHidden = db.optionsSideHidden and true or false
	end
	db.optionsSideHidden = nil
end

function G.On()
	return ns.DB().optionsLayout == "grouped"
end

local function win() return K.window() end

local function dropViews()
	for _, v in pairs(B.views) do
		v:Hide()
		local host = rawget(v, "PreviewHost")
		if host then host:Hide() end
	end
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
		local g = { key = spec.key, label = spec.label, icon = spec.icon, foot = spec.foot, pages = {} }
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

-- The page whose shown tabs are group g's sidebar rows (the rule above), or
-- nil. -> page
local function flatPage(g)
	if g.foot or #g.pages ~= 1 then return nil end
	local p = g.pages[1]
	if p.custom or p.empty or #pageTabs(p) < 2 then return nil end
	return p
end

-- A tab's sidebar key, and back: "t:<page key>\t<tab name>".
local function tabKey(p, t) return "t:" .. p.key .. "\t" .. t.name end

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

local function eachShown(g, fn)
	for _, p in ipairs(g.pages) do eachPageShown(p, fn) end
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
local function eachTabShown(x, fn)
	for _, sec in ipairs(x[2].sections) do
		if K.sectionShown(sec) then fn(sec, homeRows(sec), x[1], x[2]) end
	end
end
local function groupCounts(g) return countsOf(eachShown, g) end
local function tabCounts(p, t) return countsOf(eachTabShown, { p, t }) end
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

-- While a search is open, each group's hits (by group key).
local function searchHits(q, tree)
	local hits = {}
	local groups = search(q) or {}
	for _, gr in ipairs(groups) do
		for _, c in ipairs(gr.controls or {}) do
			local at = homeOf(c)
			local g = at and groupOfPage(at.page, tree)
			if g then hits[g.key] = (hits[g.key] or 0) + 1 end
		end
	end
	return hits
end

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
-- The sidebar's tree, its pins and its foot
---------------------------------------------------------------------------

-- PolestarDB.optionsPins: the settings pinned to the sidebar, their keys in
-- the order pinned (account-wide, not a setting).
local function pins()
	local db = ns.DB()
	if type(db.optionsPins) ~= "table" then db.optionsPins = {} end
	return db.optionsPins
end

local function pinnedAt(key)
	for i, k in ipairs(pins()) do if k == key then return i end end
end
G.Pinned = function(key) return pinnedAt(key) ~= nil end

-- PolestarDB.optionsNavAll: every group open in the sidebar (Expand all),
-- else the one shown alone. PolestarDB.optionsRail: the sidebar folded to
-- its icons. Both account-wide, not settings.
local function navAll() return ns.DB().optionsNavAll == true end
local function railOn() return ns.DB().optionsRail == true end

-- The kinds a pinned setting has a live control for (W.PinControl).
local PINNABLE = { toggle = true, slider = true, dropdown = true, font = true }

-- Is the card a setting sits in off (its module's switch, where that is not
-- the setting itself)?
local function moduleOff(c)
	local at, root = homeOf(c)
	local t = at and at.section.toggle
	if not (t and t ~= root and t.key and K.available(t)) then return false end
	return not ns.Get(t.key)
end

-- A pinned control is off while its home row is: K.disabledOf, or its
-- card's module off.
local function pinDisabled(c)
	local rowOff = K.disabledOf(c)
	return function() return rowOff() or moduleOff(c) end
end

-- What a row's marks mean, as its tooltip (W.ShellNav's markTip): the count
-- is the settings changed from their default there, the ring new settings
-- (#2541: a number on the sidebar read as a notification).
local function marksTip(changed, new)
	if changed and changed > 0 and new then
		return L["Settings on this page changed from their default"] .. "\n" .. L["New settings on this page"]
	end
	if changed and changed > 0 then return L["Settings on this page changed from their default"] end
	if new then return L["New settings on this page"] end
	return nil
end

-- The sidebar: the groups of the tree, the one shown open on its pages (all
-- of them while Expand all is on), each group and page with a ring while it
-- holds settings new to the player; then the settings pinned there, each a
-- live control ({ pin = key }), and the profile card at its foot
-- ({ profile = name }). Folded to the rail, the groups alone, each with its
-- pages for its fly-out.
function G.NavItems()
	local items, q = {}, K.query()
	local tree = G.Tree()
	local hits = q ~= "" and searchHits(q, tree) or nil
	local rail, all = railOn(), navAll()
	local foot = {}
	for _, g in ipairs(tree) do
		if g.foot and not rail then
			for _, p in ipairs(g.pages) do
				if pageShown(p) or p == B.page then foot[#foot + 1] = p end
			end
		else
			local open = not hits and shown and not rail and (all or g.key == st.group)
			local it = { key = "b:" .. g.key, label = g.label, icon = g.icon, open = open or nil, rowH = rail and 48 or 44 }
			if hits then
				it.count = hits[g.key] or 0
			else
				local _, fresh = groupCounts(g)
				it.new = fresh > 0 or nil
				it.markTip = it.new and L["New settings in this group"] or nil
			end
			if rail then
				it.open = (not hits and shown and g.key == st.group) or nil
				local fly = { { heading = true, label = g.label } }
				local fp = flatPage(g)
				if fp then
					for _, t in ipairs(pageTabs(fp)) do fly[#fly + 1] = { key = tabKey(fp, t), label = t.name } end
				else
					for _, p in ipairs(g.pages) do
						if pageShown(p) or p == B.page then fly[#fly + 1] = { key = p.key, label = p.name } end
					end
				end
				it.flyout = fly
			end
			items[#items + 1] = it
			-- An open group lists its pages, each with its changed count.
			local fp = open and flatPage(g)
			if fp then
				for _, t in ipairs(pageTabs(fp)) do
					local n, fresh = tabCounts(fp, t)
					local new = (not hits and fresh > 0) or nil
					items[#items + 1] = { key = tabKey(fp, t), label = t.name, indent = true,
						count = n > 0 and n or nil, dot = n == 0 and G.TabDot(t) or nil, new = new, markTip = marksTip(n, new) }
				end
			elseif open then
				for _, p in ipairs(g.pages) do
					if pageShown(p) or p == B.page then
						local n, fresh = pageCounts(p)
						local new = (not hits and fresh > 0) or nil
						items[#items + 1] = { key = p.key, label = p.name, indent = true,
							count = n > 0 and n or nil, dot = p.dot and p.dot() or nil, new = new, markTip = marksTip(n, new) }
					end
				end
			end
		end
	end
	if rail then return items end
	items[#items + 1] = { separator = true }
	items[#items + 1] = { heading = true, label = L["Pinned"] }
	-- A pin unavailable now (its module not loaded, another class's, another
	-- addon's page not registered) is not drawn, and stays saved. With none
	-- drawn and some saved, a line says so, and Clear (asked first) takes
	-- those off the list.
	local any, hidden = false, 0
	for _, key in ipairs(pins()) do
		local c = O.ControlByKey(key)
		if c and K.available(c) then
			any = true
			items[#items + 1] = { part = "pin", pin = key, key = "p:" .. key, control = c, label = K.labelOf(c) or key, disabled = pinDisabled(c),
				choices = function() return K.choicesOf(c) end }
		else
			hidden = hidden + 1
		end
	end
	if not any and hidden > 0 then
		items[#items + 1] = { heading = true, label = string.format(L["Pinned, not available here: %d"], hidden) }
		items[#items + 1] = { key = "pins:clear", label = L["Clear"], icon = "flag" }
	elseif not any then
		items[#items + 1] = { heading = true, label = L["Pin a setting with the flag on its row."] }
	end
	-- The foot pages (About, Guiding Stars), then the profile in use: Switch
	-- opens its menu.
	local names, active = K.profileNames()
	if #foot > 0 or names then items[#items + 1] = { part = "fill", fill = true } end
	if #foot > 0 then
		items[#items + 1] = { separator = true }
		for _, p in ipairs(foot) do
			local n, fresh = pageCounts(p)
			local new = (not hits and fresh > 0) or nil
			items[#items + 1] = { key = p.key, label = p.name, icon = p.icon,
				count = n > 0 and n or nil, new = new, markTip = marksTip(n, new) }
		end
	end
	if names then
		local name = K.profileLabel(active)
		items[#items + 1] = { separator = true }
		items[#items + 1] = { part = "profile", profile = name, key = "profile", label = name, caption = L["Profile"], action = L["Switch"],
			tip = string.format(L["Profile: %s"], name) }
	end
	return items
end

-- The sidebar key of what is on screen (nil while a search is open).
function G.NavKey()
	if not (shown and G.On()) or K.query() ~= "" then return nil end
	return B.navKey
end

-- The pins not available here off the list, the player asked first (the
-- ones drawn stay).
local function clearHiddenPins()
	W.Modal({ title = L["Clear the pins not available here?"], icon = "flag", danger = true, action = L["Clear"],
		text = L["They come off the list on every character. The pins you see here stay."],
		onAccept = function()
			local gone = {}
			for _, key in ipairs(pins()) do
				local c = O.ControlByKey(key)
				if not (c and K.available(c)) then gone[#gone + 1] = key end
			end
			for _, key in ipairs(gone) do G.Pin(key, false) end
		end })
end

-- A sidebar click: a group (on its page last shown), a page, a pinned
-- setting (its row), the pins not available here (Clear) or the profile
-- (its menu). -> handled
function navSelect(key)
	if type(key) ~= "string" then O.Select(key) return true end
	if key == "pins:clear" then
		clearHiddenPins()
		return true
	end
	if key == "profile" then
		local card = rawget(win(), "NavProfile")
		if card and card:IsShown() then K.profileMenu(card.Action) end
		return true
	end
	if key:sub(1, 2) == "p:" then
		local c = O.ControlByKey(key:sub(3))
		if c then G.Jump(c) end
		return true
	end
	if key:sub(1, 2) == "t:" then
		local pk, tn = key:match("^t:([^\t]*)\t(.*)$")
		if pk then
			O.Select(pk, tn)
			return true
		end
	end
	O.Select(key)
	return true
end
G.NavSelect = function(key)
	if not (shown and G.On()) then return false end
	return navSelect(key)
end

-- The sidebar drawn again (a pin, a value or a count moved).
local function redrawNav()
	if shown and win() then W.ShellNav(win(), G.NavItems(), G.NavKey(), navSelect) end
end

-- key pinned (on true), unpinned (false) or flipped (nil). -> done
function G.Pin(key, on)
	if type(key) ~= "string" then return false end
	local list, at = pins(), pinnedAt(key)
	if on == nil then on = not at end
	if on and not at then
		if #list >= PIN_MAX then return false end
		list[#list + 1] = key
	elseif not on and at then
		table.remove(list, at)
	end
	redrawNav()
	return true
end

-- The sidebar's head: Expand all (every group open, or the one shown alone)
-- and the fold to the rail, right-aligned on the lockup's tagline line (the
-- wordmark's ink reaches past where Expand all stands, the tagline's does
-- not); on the rail the fold alone, centred under the emblem on the band's
-- line. Made the first time the new page shows.
local function navHead()
	if B.Head then return B.Head end
	local side = win().Sidebar
	local h = {}
	h.Rail = W.IconButton(side, "chevron-left", 22, L["Fold the sidebar to icons"], function() G.SetRail(not railOn()) end, 12)
	W.SetFramed(h.Rail, "icon")
	h.Expand = W.Button(side, L["Expand all"], function() G.SetNavAll(not navAll()) end,
		{ height = 22, ghost = true, icon = "chevron-down" })
	h.Expand.psTight = true
	h.Expand.psTip = L["Expand all"]
	B.Head = h
	return h
end
G._navHead = function() return B.Head end

local function paintHead()
	local w = win()
	if not w then return end
	local h, side, rail, all = navHead(), w.Sidebar, railOn(), navAll()
	h.Rail:ClearAllPoints()
	h.Expand:ClearAllPoints()
	-- The toolbar row above the sidebar's hairline (SHELL.header + SHELL.tabs):
	-- Expand all (a labelled button) on the 24 edge, the fold plate at the
	-- right edge; on the rail the fold alone, centred. The tagline's line is
	-- clear.
	local cy = SH.header + SH.tabs - 16
	if rail then
		h.Rail:SetPoint("CENTER", side, "TOP", 0, -cy)
	else
		h.Rail:SetPoint("CENTER", side, "TOPRIGHT", -(SH.side - 4) - 11, -cy)
		h.Expand:SetPoint("LEFT", side, "TOPLEFT", SH.side - 8, -cy)
	end
	W.SetIcon(h.Rail, rail and "chevron-right" or "chevron-left")
	h.Rail.psTip = rail and L["Show the sidebar"] or L["Fold the sidebar to icons"]
	W.SetButtonText(h.Expand, all and L["Collapse all"] or L["Expand all"])
	h.Expand.Icon:SetTexture(Theme.Media(all and "chevron-up" or "chevron-down"))
	h.Expand.psTip = all and L["Collapse all"] or L["Expand all"]
	h.Rail:Show()
	h.Expand:SetShown(not rail)
end

-- The sidebar as the new page wants it (on), or the classic page's.
local function sidebarMode(on)
	local w = win()
	if not w then return end
	W.ShellNavRail(w, on and railOn())
	if not (on and railOn()) then W.ShellFlyoutHide(w) end
	if on then
		paintHead()
	elseif B.Head then
		B.Head.Rail:Hide()
		B.Head.Expand:Hide()
	end
end

-- Expand all: every group open in the sidebar (on), or the one shown
-- alone; kept for the account. -> nothing
function G.SetNavAll(on)
	ns.DB().optionsNavAll = on and true or nil
	if shown then
		paintHead()
		redrawNav()
	end
end

-- The sidebar folded to its icons (on), or at its full width; kept for
-- the account. The page lays out again for the room. -> nothing
function G.SetRail(on)
	ns.DB().optionsRail = on and true or nil
	if not on then W.ShellFlyoutHide(win()) end
	if shown then render({ keep = true }) end
end

-- The rail's fly-out (the tests read it).
G._flyout = function() return W.ShellFlyoutFrame() end

---------------------------------------------------------------------------
-- The chrome: the filter, the index, the side card
---------------------------------------------------------------------------

-- A button of the band's right end (the filter's, Preview).
local function bandButton()
	local w = win()
	local b = CreateFrame("Button", nil, w.TabRow)
	b:SetHeight(24)
	b.Ground = W.Tex(b, "BACKGROUND")
	b.Ground:SetAllPoints(b)
	W.Color(b.Ground, "shade", 0.22)
	b.Edge = W.Divider(b)
	b.Edge:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, 0)
	b.Edge:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 0, 0)
	b.Dot = W.Tex(b, "ARTWORK", "circle", "accent")
	b.Dot:SetSize(5, 5)
	b.Label = W.Text(b, "label", "textDim")
	b.Count = W.Text(b, "number", "textMuted")
	b.Chevron = W.Tex(b, "ARTWORK", "chevron-down", "textDim")
	b.Chevron:SetSize(9, 9)
	b:SetScript("OnClick", function(self) if self.psClick then self.psClick(self) end end)
	b:SetScript("OnEnter", function(self)
		if not self.psOn then W.Color(self.Label, "text") end
		if self.psTip then W.Tooltip(self, "ANCHOR_BOTTOM", self.psTip, self.psTipLines) end
	end)
	b:SetScript("OnLeave", function(self)
		if not self.psOn then W.Color(self.Label, "textDim") end
		W.HideTooltip(self)
	end)
	return b
end

-- The filter at the band's right end: All / Changed n, or (narrow) one
-- button that opens them as a menu.
local function filterButton(i)
	B.filters = B.filters or {}
	local b = B.filters[i]
	if b then return b end
	b = bandButton()
	B.filters[i] = b
	return b
end

-- -> the button's width
local function dressFilter(b, label, count, on, dot, chevron, icon)
	b.psOn = on and true or false
	b.Ground:SetShown(on and true or false)
	b.Edge:SetShown(on and true or false)
	W.Color(b.Label, on and "text" or "textDim")
	b.Label:SetText(label)
	b.Count:SetText(count or "")
	b.Count:SetShown(count ~= nil)
	b.Dot:SetShown(dot and true or false)
	if icon then
		b.Dot:SetTexture(Theme.Media(icon))
		b.Dot:SetSize(12, 12)
		W.Color(b.Dot, "textDim")
	else
		b.Dot:SetTexture(Theme.Media("circle"))
		b.Dot:SetSize(5, 5)
		W.Color(b.Dot, "accent")
	end
	b.Chevron:SetShown(chevron and true or false)
	local x = 8
	b.Dot:ClearAllPoints()
	if b.Dot:IsShown() then
		b.Dot:SetPoint("LEFT", b, "LEFT", x, 0)
		x = x + b.Dot:GetWidth() + 6
	end
	b.Label:ClearAllPoints()
	b.Label:SetPoint("LEFT", b, "LEFT", x, 0)
	x = x + b.Label:GetStringWidth()
	if count ~= nil then
		b.Count:ClearAllPoints()
		b.Count:SetPoint("LEFT", b, "LEFT", x + 5, 0)
		x = x + 5 + b.Count:GetStringWidth()
	end
	if chevron then
		b.Chevron:ClearAllPoints()
		b.Chevron:SetPoint("LEFT", b, "LEFT", x + 5, 0)
		x = x + 5 + 9
	end
	local wd = floor(x + 8 + 0.5)
	b:SetWidth(wd)
	b:Show()
	return wd
end

local FILTERS = { "all", "changed" }
local function filterLabel(f)
	return f == "changed" and L["Changed"] or L["All"]
end

-- The pages with settings off their default, in sidebar order:
-- { { page, count, group } }.
function G.ChangedPages()
	local out = {}
	for _, g in ipairs(G.Tree()) do
		for _, p in ipairs(g.pages) do
			local n = pageCounts(p)
			if n > 0 then out[#out + 1] = { page = p, count = n, group = g } end
		end
	end
	return out
end

local function changedTotal()
	local n = 0
	for _, e in ipairs(G.ChangedPages()) do n = n + e.count end
	return n
end

-- A filter picked: Changed (from the page on screen), or All (back to it).
local function pickFilter(f)
	if f == "changed" then G.Filter("changed") else G.Back() end
end

-- Lay out the filter `from` in from the band's right end. -> the width taken
local function drawFilter(g, wide, from)
	local w = win()
	local counts = { all = nil, changed = changedTotal() }
	local right = w.psMainW - SH.pad + 8
	local start = from or 0
	local used, n = start, 0
	local function put(b, wd)
		b:ClearAllPoints()
		b:SetPoint("BOTTOMRIGHT", w.TabRow, "BOTTOMLEFT", right - used, 6)
		used = used + wd + 4
	end
	if wide then
		for i = #FILTERS, 1, -1 do
			local f = FILTERS[i]
			n = n + 1
			local b = filterButton(n)
			local wd = dressFilter(b, filterLabel(f), counts[f], st.filter == f, f ~= "all" and (counts[f] or 0) > 0)
			b.psClick = function() pickFilter(f) end
			put(b, wd)
		end
	else
		n = n + 1
		local b = filterButton(n)
		local f = st.filter
		local wd = dressFilter(b, filterLabel(f), counts[f], f ~= "all", f ~= "all", true)
		b.psClick = function(self)
			local items = {}
			for _, ff in ipairs(FILTERS) do
				local text = filterLabel(ff) .. (counts[ff] and ("  " .. counts[ff]) or "")
				items[#items + 1] = { text = text, checked = st.filter == ff, onClick = function() pickFilter(ff) end }
			end
			W.ShowMenu(self, items)
		end
		put(b, wd)
	end
	for i = n + 1, #(B.filters or {}) do B.filters[i]:Hide() end
	return used - start
end
-- The filter's buttons, from the band's right end leftward (the tests read them).
function G._filters() return B.filters or {} end

-- Does page p show a live preview (a tab of it on screen registers one)?
-- -> bool
function G.HasPreview(p)
	if not p or p.custom then return false end
	for _, t in ipairs(pageTabs(p)) do
		if t.preview then return true end
	end
	return false
end

-- The tab whose preview page p shows on tab t: t's own, else the first of
-- the page's tabs on screen with one. -> tab, or nil
local function previewTabOf(p, t)
	if t and t.preview then return t end
	if not (p and not p.custom) then return nil end
	for _, pt in ipairs(pageTabs(p)) do
		if pt.preview then return pt end
	end
end

-- Preview, left of the filter: shows or hides the Preview panel for the
-- account, lit while it is open; on a page with a live preview only (none
-- in the Changed view). -> the width taken
local function drawPreview(g, wide, from)
	local w = win()
	local b = B.PreviewBtn
	if not b then
		b = bandButton()
		b:SetScript("OnClick", function(self)
			W.HideTooltip(self)
			G.SetPreviewHidden(self.psOn)
		end)
		B.PreviewBtn = b
	end
	if st.filter == "changed" or not G.HasPreview(B.page) then
		b:Hide()
		return 0
	end
	local open = not previewHidden(wide)
	b.psTip = open and L["Hide preview"] or L["Show preview"]
	b.psTipLines = { open and L["The rows take the full width. Polestar keeps this for all your characters."]
		or L["A live view of what these settings change, beside the rows."] }
	local wd = dressFilter(b, L["Preview"], nil, open, true, nil, "eye")
	b:ClearAllPoints()
	b:SetPoint("BOTTOMRIGHT", w.TabRow, "BOTTOMLEFT", w.psMainW - SH.pad + 8 - (from or 0), 6)
	return wd + 4
end
-- The Preview button (the tests read it). -> button, or nil before the first draw
function G.PreviewButton() return B.PreviewBtn end

-- What stands at the band's right end, from the end leftward: each
-- fn(g, wide, from) lays its widgets out `from` in from the end. -> the
-- width taken
local RIGHT_END = { drawFilter, drawPreview }
local function drawRightEnd(g, wide)
	local used = 0
	for _, fn in ipairs(RIGHT_END) do used = used + fn(g, wide, used) end
	return used
end

-- A folder tab's icon: the tab's own, else its page's, else the page of
-- its first section's first row (a reference's home); one taken by a tab
-- before it in the bar gives way to the first free one of TAB_ICONS. All of
-- them glyphs of Media/UI.
G.TAB_ICONS = { "sliders", "window", "menu", "gear", "layers", "star", "flag", "info", "eye", "palette", "bolt", "plug", "check" }

local function sectionPageIcon(t)
	local sec = t.sections and t.sections[1]
	local c = sec and sec.controls[1]
	if not c then return nil end
	local home = rawget(c, "ref") and O.HomeOf(c) or c
	local hp = home and rawget(home, "page")
	return hp and hp.icon
end

-- -> the icon of tab t in page p's bar (unique in it)
function G.TabIcon(p, t)
	local used = {}
	for _, x in ipairs(pageTabs(p)) do
		local pick
		for _, cand in ipairs({ rawget(x, "icon") or false, p.icon or false, sectionPageIcon(x) or false }) do
			if cand and not used[cand] then pick = cand break end
		end
		if not pick then
			for _, cand in ipairs(G.TAB_ICONS) do
				if not used[cand] then pick = cand break end
			end
		end
		pick = pick or "gear"
		if x == t then return pick end
		used[pick] = true
	end
	return rawget(t, "icon") or p.icon or "gear"
end

-- A folder tab's dot: "filled" while a row on the tab is off its default,
-- "hollow" while the only change is under a parent whose children are
-- closed, else nil.
function G.TabDot(t)
	local hidden = false
	for _, sec in ipairs(t and t.sections or {}) do
		if K.sectionShown(sec) then
			if toggleChanged(sec) then return "filled" end
			for _, c in ipairs(homeRows(sec)) do
				if rowChanged(c) then
					local parent = rawget(c, "psChildOf")
					if parent and not O.KidsOpen(parent) then hidden = true else return "filled" end
				end
			end
		end
	end
	return hidden and "hollow" or nil
end

-- The header's line one: the breadcrumb, "Group › Page" (a foot page, or a
-- filter's name in the page's place), then the description (the header lays
-- them out, W.HeaderScale's "Search first").
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

-- The Preview panel: the page's live preview alone, beside the rows (over
-- them in a narrow window, with its close button).
local function side()
	if B.Side then return B.Side end
	local w = win()
	local f = CreateFrame("Frame", nil, w.Content)
	f:SetFrameStrata(w:GetFrameStrata())
	f:SetFrameLevel(w.Scroll:GetFrameLevel() + 6)
	f:EnableMouse(true)
	-- Over the rows (a narrow window) it must hide them: its ground is opaque.
	f.psMenu = true
	Theme.Skin(f, "panel")
	f.Close = W.IconButton(f, "close", 22, L["Close"], function() G.SetPreviewHidden(true) end, 11)
	f.Close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -6, -6)
	f.Close:SetFrameLevel(f:GetFrameLevel() + 4)
	f:Hide()
	B.Side = f
	return f
end
G._side = function() return B.Side end

-- The pin on the row under the pointer: a flag in the gutter left of its
-- label (accent while pinned) that pins it to the sidebar or takes it off.
local function pinTip(b)
	local key = b.psKey
	if pinnedAt(key) then
		b.psTip, b.psTipLines = L["Unpin from the sidebar"], nil
	elseif #pins() >= PIN_MAX then
		b.psTip, b.psTipLines = L["Pin to the sidebar"], { L["The sidebar holds eight pinned settings: unpin one first."] }
	else
		b.psTip, b.psTipLines = L["Pin to the sidebar"], nil
	end
end

local function paintPin(b)
	b.psActive = pinnedAt(b.psKey) ~= nil
	W.Color(b.Icon, b.psActive and "accent" or "icon")
	pinTip(b)
end

-- Is the pointer on the flag or on the row that holds it?
local function over(f)
	return f and f.IsMouseOver and f:IsMouseOver() == true
end
local function pinHeld(b)
	return over(b) or over(b:GetParent())
end

local function pinButton()
	if B.Pin then return B.Pin end
	local b = W.IconButton(win().Body, "flag", 18, L["Pin to the sidebar"], function(self)
		if G.Pin(self.psKey) then paintPin(self) end
		W.SimpleTip(self)
	end, 11)
	-- The flag stays while the pointer is on its row (its reset, slider or
	-- any other part of it too) or on the flag, and goes once it is on
	-- neither: the row hears OnLeave when the pointer enters one of its own
	-- parts, so the flag watches the pointer itself while it is shown.
	b:HookScript("OnLeave", function(self)
		if not pinHeld(self) then self:Hide() end
	end)
	b:SetScript("OnUpdate", function(self)
		if not pinHeld(self) then self:Hide() end
	end)
	b:Hide()
	B.Pin = b
	return b
end

local function placePin(row, c)
	if not (shown and c.key) then return end
	local b = pinButton()
	b.psKey = c.key
	b:SetParent(row)
	b:SetFrameLevel(row:GetFrameLevel() + 4)
	b:ClearAllPoints()
	local label = rawget(row, "Label")
	if label then
		-- A child's row stands its indent into the column (row.psIndent): the
		-- flag keeps the column's gutter, left of the child's accent rule.
		b:SetPoint("RIGHT", label, "LEFT", -14 - (rawget(row, "psIndent") or 0), 0)
	else
		b:SetPoint("RIGHT", row, "LEFT", -4, 0)
	end
	paintPin(b)
	b:Show()
end
G._placePin = placePin

-- Every keyed row with a live control for the sidebar (PINNABLE) takes the
-- pin on its hover (once a row).
function hookPins(view)
	for c, row in pairs(view and view.cache or {}) do
		if type(c) == "table" and c.key and PINNABLE[c.kind] and not rawget(row, "psPinHook") then
			row.psPinHook = true
			row:HookScript("OnEnter", function(self) placePin(self, c) end)
			row:HookScript("OnLeave", function(self)
				local b = B.Pin
				if b and b:GetParent() == self and not pinHeld(b) then b:Hide() end
			end)
		end
	end
end

-- The Preview panel hidden (true) or shown, for the account. -> nothing
function G.SetPreviewHidden(hidden)
	ns.DB().optionsPreviewHidden = hidden and true or false
	if shown then render({ keep = true }) end
end

-- The body's scroll stops short of the side card while it stands beside it.
local function scrollRoom()
	local w = win()
	local sf = w.Scroll
	if not rawget(sf, "psGroupedSetPoint") then
		local set = sf.SetPoint
		sf.psGroupedSetPoint = set
		sf.SetPoint = function(self, point, rel, relPoint, x, y)
			if point == "BOTTOMRIGHT" and (B.room or 0) > 0 then x = -(4 + B.room) end
			return set(self, point, rel, relPoint, x, y)
		end
	end
	sf:ClearAllPoints()
	local ph = w.psPreviewH or 0
	sf:SetPoint("TOPLEFT", w.Content, "TOPLEFT", 0, -(4 + ph))
	sf:SetPoint("BOTTOMRIGHT", w.Content, "BOTTOMRIGHT", -4, 4)
end

---------------------------------------------------------------------------
-- Views
---------------------------------------------------------------------------

local function newView()
	local v = CreateFrame("Frame", nil, win().Body)
	v:SetPoint("TOPLEFT", win().Body, "TOPLEFT", 0, 0)
	v:SetPoint("RIGHT", win().Body, "RIGHT", 0, 0)
	K.viewTables(v)
	return v
end

local function emptyNote(v, text, button)
	local w = win()
	for _, x in pairs(v.cache) do x:Hide() end
	for _, card in ipairs(v.cards) do card:Hide() end
	for _, m in ipairs(v.mids) do m:Hide() end
	if not rawget(v, "Empty") then
		v.Empty = W.Text(v, "body", "textDim")
		v.Empty:SetWordWrap(true)
		v.Empty:SetJustifyH("CENTER")
		v.EmptyIcon = W.Tex(v, "ARTWORK", "check", "textMuted")
		v.EmptyIcon:SetSize(18, 18)
		v.EmptyAll = W.Button(v, L["All"], function() G.Back() end)
	end
	v.Empty:SetText(text)
	v.Empty:SetWidth(w.BodyWidth)
	v.Empty:ClearAllPoints()
	v.Empty:SetPoint("TOP", v, "TOPLEFT", SH.pad + w.BodyWidth / 2, -96)
	v.Empty:Show()
	v.EmptyIcon:ClearAllPoints()
	v.EmptyIcon:SetPoint("BOTTOM", v.Empty, "TOP", 0, 12)
	v.EmptyIcon:SetShown(button and true or false)
	v.EmptyAll:ClearAllPoints()
	v.EmptyAll:SetPoint("TOP", v.Empty, "BOTTOM", 0, -16)
	v.EmptyAll:SetShown(button and true or false)
	return 220
end

local function hideEmpty(v)
	if rawget(v, "Empty") then
		v.Empty:Hide()
		v.EmptyIcon:Hide()
		v.EmptyAll:Hide()
	end
end

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
-- dependency lines first in their sections and Legend card headers; its own
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
	v = K.buildView(p, t, { lead = depRow, legend = true })
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

-- A page's settings off their default, for its card in the Changed view:
-- each changed row in the page's order (a section's switch counted where
-- it has its home, as the counts do). -> list, settings, tab (control -> its tab)
local function changedRows(p)
	local list, settings, tabOf = {}, {}, {}
	eachPageShown(p, function(sec, rows, _, t)
		local function add(c)
			list[#list + 1] = c
			tabOf[c] = t
			eachSetting(c, function(x) settings[#settings + 1] = x end)
		end
		if toggleChanged(sec) then add(sec.toggle) end
		for _, c in ipairs(rows) do if rowChanged(c) then add(c) end end
	end)
	return list, settings, tabOf
end

-- A row of a page of more than one tab names its tab first ("Tab › Label");
-- the Changed view's rows are its own, so the page's rows keep theirs.
local function tabPrefix(v, c, t, many)
	local w = K.rowOf(v, c)
	local label = rawget(w, "Label")
	if not label then return end
	local base = rawget(w, "psBaseLabel") or w.psLabel or label:GetText() or ""
	w.psBaseLabel = base
	local text = base
	if many and t and t.name ~= "" then text = t.name .. SEP .. base end
	w.psLabel = text
	label:SetText(text)
end

-- A card's link to its page ("Open ›"), made once per card.
local function openLink(card)
	local b = rawget(card, "Open")
	if not b then
		b = W.Link(card, L["Open"] .. " \226\128\186", function(self)
			local p = self.psPage
			if p then O.Select(p.key) end
		end)
		card.Open = b
	end
	return b
end

-- The Changed view: one Legend card per page with changes, in sidebar
-- order, "Group › Page" with its count, its Reset (the page's, with Undo)
-- and its link there. Its cards' .psPage: their pages.
local function changedView()
	local v = B.views.changed
	if not v then
		v = newView()
		-- Its rows as a list: a child stands alone, not under its parent.
		v.psFlat = true
		B.views.changed = v
	end
	v.Refresh = function()
		local groups, rows = {}, {}
		for _, e in ipairs(G.ChangedPages()) do
			local p = e.page
			local list, settings, tabOf = changedRows(p)
			if #list > 0 then
				local many = #K.shownTabs(p) > 1
				for _, c in ipairs(list) do
					rows[#rows + 1] = c
					tabPrefix(v, c, tabOf[c], many)
				end
				local title = e.group.label:lower() == p.name:lower() and p.name or e.group.label .. SEP .. p.name
				groups[#groups + 1] = { name = title, controls = list, settings = settings, count = #list, page = p,
					onReset = function()
						-- The card goes, its jump tab too (SETTING_CHANGED lays the view
						-- out again; state with no setting behind it fires none, so then
						-- here); Undo stays beside the title.
						local seq = B.renders
						O.ResetPage(p)
						if shown and B.renders == seq then render({ keep = true }) end
					end,
					lead = function(card)
						local b = openLink(card)
						b.psPage, b.psTip = p, title
						return b
					end }
			end
		end
		v.psTab = { name = filterLabel("changed"), sections = {} }
		v.psShownSig = nil
		v.psGroups, v.psRows, v.psFiltered = groups, #rows, rows
		if #groups == 0 then
			for _, card in ipairs(v.cards) do card.psPage = nil end
			return emptyNote(v, L["Every setting at its default"], true)
		end
		hideEmpty(v)
		local h = K.layoutSections(v, groups, 16, { legend = true }) + 24
		for i, gr in ipairs(groups) do v.cards[i].psPage = gr.page end
		for i = #groups + 1, #v.cards do v.cards[i].psPage = nil end
		return h
	end
	return v
end
G.ChangedView = function() return changedView() end

---------------------------------------------------------------------------
-- Showing a page's tab
---------------------------------------------------------------------------

-- While the Changed view is open, Esc and the close button go back to the
-- page it was opened from (G.Back) instead of closing the window. Esc: the
-- window reads the keyboard then, and keeps Escape from the game's own
-- close (out of combat; in it, Escape closes the window as ever).
local function onKey(self, key)
	local back = key == "ESCAPE" and st.filter == "changed" and shown and not (InCombatLockdown and InCombatLockdown())
	if self.SetPropagateKeyboardInput and not (InCombatLockdown and InCombatLockdown()) then self:SetPropagateKeyboardInput(not back) end
	if back then G.Back() end
end

function changedKeys(on)
	local w = win()
	if not w then return end
	if on and not rawget(w, "psChangedKeys") then
		w.psChangedKeys = true
		w:SetScript("OnKeyDown", onKey)
		local close = rawget(w, "Close")
		local click = close and close:GetScript("OnClick")
		if click then
			close:SetScript("OnClick", function(self, ...)
				if st.filter == "changed" and shown and G.On() then return G.Back() end
				return click(self, ...)
			end)
		end
	end
	if rawget(w, "psChangedKeys") and not (InCombatLockdown and InCombatLockdown()) then
		-- Every other key goes on to the game, also once a fight locks the choice.
		if on and w.SetPropagateKeyboardInput then w:SetPropagateKeyboardInput(true) end
		w:EnableKeyboard(on and true or false)
	end
end

-- Hide what this layout puts on the window (its views too).
local function hideChrome()
	local w = win()
	if not w then return end
	for _, b in ipairs(B.filters or {}) do b:Hide() end
	if rawget(w, "FolderTabs") then w.FolderTabs:Hide() end
	if B.Side then B.Side:Hide() end
	if B.PreviewBtn then B.PreviewBtn:Hide() end
	if B.Pin then B.Pin:Hide() end
	if B.host then
		B.host:Hide()
		B.host = nil
	end
	for _, v in pairs(B.views) do
		v:Hide()
		local host = rawget(v, "PreviewHost")
		if host then host:Hide() end
	end
	if B.Strip then B.Strip:Hide() end
	changedKeys(false)
	w.psKeepTabRow, w.psTabRoom = nil, nil
	W.ShellTabs(w, nil)
	B.room, B.sideMode, B.entries = 0, nil, nil
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
	sidebarMode(false)
	W.ShellFlyoutHide(win())
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

-- What ··· holds: Settings scale (a slider in the menu itself, written when the
-- drag ends: it rescales the window and the menu it sits in), Move frames,
-- then the two resets, each asking first and naming its scope (the page on
-- screen; the profile in use).
local MENU_SCALE = { kind = "slider", key = "ui.menuScale", label = L["Settings scale"], icon = "sliders",
	min = 0.7, max = 1.4, step = 0.05, release = true, format = function(v) return floor(v * 100 + 0.5) .. "%" end }
function G.MenuItems()
	local M = ns.Movers
	local p = G.Current() or O.page
	-- The Changed view keeps the page it was opened from behind it: nothing
	-- on screen for Reset this page to name.
	local hidden = st.filter == "changed"
	return {
		{ text = L["Settings scale"], slider = MENU_SCALE },
		{ text = L["Move frames"], icon = "resize", disabled = not (M and M.Unlock) or nil, onClick = function() O.MoveFrame(nil) end },
		{ text = L["Reset this page\226\128\166"], icon = "reset", danger = true,
			disabled = (hidden or not (p and K.pageShowsSetting(p))) or nil, onClick = function() O.AskResetPage(p) end },
		{ text = L["Reset all settings\226\128\166"], icon = "reset", danger = true, onClick = function() O.AskResetAll() end },
	}
end

-- The Changed view's tab bar: All, then one jump tab per card, "Page n",
-- with its page's glyph (one taken before it in the bar gives way to the
-- first free one of TAB_ICONS). -> list, the active key
function changedTabs(view)
	local used = { sliders = true }
	local list = { { key = "all", label = L["All"], icon = "sliders" } }
	local keys = {}
	for i, card in ipairs(view.cards) do
		local p = card:IsShown() and card.psPage
		local gr = view.psGroups and view.psGroups[i]
		if p and gr then
			local icon = p.icon
			if not icon or used[icon] then
				icon = nil
				for _, cand in ipairs(G.TAB_ICONS) do
					if not used[cand] then icon = cand break end
				end
			end
			icon = icon or "gear"
			used[icon] = true
			local key = "j:" .. p.key
			keys[key] = true
			list[#list + 1] = { key = key, label = p.name .. " " .. gr.count, icon = icon }
		end
	end
	if not (B.jump and keys[B.jump]) then B.jump = list[2] and list[2].key or nil end
	return list, B.jump
end

-- A tab of the Changed view's bar: All goes back to the page; a jump tab
-- scrolls its card under the body's top.
function changedJump(view, key)
	if key == "all" then return G.Back() end
	for _, card in ipairs(view.cards) do
		if card:IsShown() and card.psPage and "j:" .. card.psPage.key == key then
			B.jump = key
			local w = win()
			if rawget(w, "FolderTabs") then w.FolderTabs:Set(w.FolderTabs.psList, key) end
			W.ScrollTo(w.Scroll, max(0, (card.psTop or 0) - W.LEGEND.H / 2 - 12))
			return card
		end
	end
end

-- opts: { page, tab (a tab of the page, or its name), keep (the scroll and
-- the place as they are) }. With no page, the page on screen (else the
-- first group's first page).
function render(opts)
	opts = opts or {}
	B.renders = (B.renders or 0) + 1
	local w = win()
	if not w then return end
	local scroll = opts.keep and w.Scroll:GetVerticalScroll() or 0
	-- ··· stays open through a layout its Settings scale slider set off (the
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
	sidebarMode(true)
	W.ShellLayout(w)
	-- What stands beside the rows: the page's live preview (the tab's own,
	-- else its page's), on a page that has one, in the Preview panel.
	local filtering = st.filter == "changed"
	if not filtering then B.from = nil end
	local previewTab = not filtering and G.HasPreview(p) and previewTabOf(p, tab) or nil
	-- Shown (its button, for the account): beside the rows in a wide
	-- window, over them in a narrow one. Hidden: the rows take the width.
	local wide = w:GetWidth() >= WIDE
	local sideW = min(SIDE.MAX, max(SIDE.MIN, floor(w.psMainW * 0.34)))
	local hidden = previewHidden(wide)
	local beside = previewTab ~= nil and wide and not hidden
	local over = previewTab ~= nil and not wide and not hidden
	B.sideMode = (beside or over) and "preview" or nil
	B.room = beside and (sideW + SIDE.GAP + SIDE.EDGE - 4) or 0
	local fullW = w.BodyWidth
	if beside then
		w.BodyWidth = w.psMainW - SH.pad - sideW - SIDE.GAP - SIDE.EDGE
	end
	-- The title, the band: the page's folder tabs, the filter at its right
	-- end (the band's row kept for it, the classic tabs off).
	w.psKeepTabRow = true
	W.ShellTabs(w, nil)
	local rightW = drawRightEnd(g, wide)
	local list, active
	local view = filtering and changedView() or tabView(p, tab)
	if filtering then
		drawCrumb(nil, filterLabel("changed"), nil)
	else
		drawCrumb(g.label, flatPage(g) and tab.name or p.name, p.subtitle or SUBTITLES[p.key])
	end
	local h = view.Refresh()
	view:SetHeight(h)
	view:Show()
	if filtering then
		-- All (back to the page), then a jump tab per card ("Guide 3").
		list, active = changedTabs(view)
	elseif flatPage(g) then
		-- The group's rows are the tabs: no folder tabs.
		list, active = nil, nil
	elseif #tabs > 1 or tabs[1].name ~= "" then
		list, active = {}, tab.name
		for i, t in ipairs(tabs) do
			list[i] = { key = t.name, label = t.name, icon = G.TabIcon(p, t), dot = G.TabDot(t) }
		end
	end
	local folder = { active = active, width = w.psMainW, rightWidth = rightW > 0 and (rightW + SH.pad - 8) or 0,
		onSelect = function(key)
			if filtering then return changedJump(view, key) end
			st.filter = "all"
			render({ page = p, tab = key })
		end }
	if rawget(w, "FolderTabs") then
		w.FolderTabs:Set(list, active, folder)
	else
		w.FolderTabs = W.FolderTabs(w.TabRow, list, folder)
	end
	w.FolderTabs:Show()
	-- The index under the tabs, for a long tab.
	local entries
	if not filtering and not p.custom and (view.psRows or 0) > LONG then
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
			drawStrip(entries, string.format(L["%d settings"], view.psRows), beside and (w.BodyWidth + SH.pad * 2) or w.psMainW)
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
	-- The Preview panel.
	local f = side()
	if B.host then
		B.host:Hide()
		B.host = nil
	end
	if B.sideMode then
		local ph = w.psPreviewH or 0
		f:ClearAllPoints()
		f:SetPoint("TOPRIGHT", w.Content, "TOPRIGHT", -SIDE.EDGE, -(ph + 12))
		f:SetPoint("BOTTOMRIGHT", w.Content, "BOTTOMRIGHT", -SIDE.EDGE, 12)
		f:SetWidth(sideW)
		f.Close:SetShown(over and true or false)
		f:Show()
		local room = f:GetHeight()
		if not room or room <= 0 then room = w:GetHeight() - SH.header - SH.tabs - (rawget(w, "psNoFooter") and 0 or SH.footer) - ph - 24 end
		UI.Preview.Place(w, view, previewTab, sideW - 24, max(80, room - 24) / UI.Preview.MAX)
		local host = rawget(view, "PreviewHost")
		local hh = w.psPreviewH or 0
		W.ShellPreview(w, entries and #entries > 0 and strip() or nil, entries and #entries > 0 and STRIP or 0)
		if host and host.Frame and hh > 0 and not view.empty then
			host:SetParent(f)
			host:ClearAllPoints()
			host:SetPoint("TOPLEFT", f, "TOPLEFT", 12, -12)
			host:SetSize(sideW - 24, hh)
			host:Show()
			B.host = host
		else
			-- The preview laid nothing out: no empty panel, the rows take the
			-- width (laid out again for it).
			f:Hide()
			B.sideMode, B.room = nil, 0
			if beside then
				w.BodyWidth = fullW
				h = view.Refresh()
				view:SetHeight(h)
				if entries and #entries > 0 then drawStrip(entries, string.format(L["%d settings"], view.psRows), w.psMainW) end
			end
		end
	else
		f:Hide()
	end
	scrollRoom()
	W.ShellBody(w, h)
	W.ScrollTo(w.Scroll, scroll)
	-- The seen record, the sidebar.
	if not filtering and not p.custom then
		local all = {}
		for _, sec in ipairs(tab.sections) do for _, c in ipairs(sec.controls) do all[#all + 1] = c end end
		markSeen(all)
	end
	-- The Changed view is the whole window's: no sidebar row is its place.
	B.navKey = not filtering and (flatPage(g) and tabKey(p, tab) or p.key) or nil
	W.ShellNav(w, G.NavItems(), B.navKey, navSelect)
	changedKeys(filtering)
	hookPins(view)
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

-- The filter over the whole window: "changed" (the Changed view, opened
-- from the page on screen) or "all" (back to that page).
function G.Filter(f)
	if f ~= "changed" then return G.Back() end
	if st.filter ~= "changed" then
		B.from, B.jump = { page = B.page, tab = B.tab }, nil
	end
	st.filter = "changed"
	if shown then render({}) end
end

-- Out of the Changed view, back to the page it was opened from (its tab).
function G.Back()
	local from = B.from
	B.from = nil
	st.filter = "all"
	if not shown then return end
	render({ page = from and from.page or B.page, tab = from and from.tab or B.tab })
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
		st.filter = "all"
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
	if p then st.filter = "all" end
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
-- the Changed view, from the page it was opened from).
function G.StepTab(delta)
	if not G.On() then return false end
	local list, at = {}, nil
	local from = st.filter == "changed" and B.from or { page = B.page, tab = B.tab }
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
	if to then
		st.filter = "all"
		render({ page = to[1], tab = to[2] })
	end
	return true
end

-- A section's tab ({ page, tab, section }), the section scrolled under the
-- body's top and lit.
function G.ShowSection(at)
	st.filter = "all"
	render({ page = at.page, tab = at.tab })
	local view = O.view
	for _, card in ipairs(view and view.cards or {}) do
		if card:IsShown() and card.psSection == at.section then
			W.ScrollTo(win().Scroll, max(0, (card.psTop or 0) - 16))
			O.Flash(card.psLegend and card or card.Header)
			return card
		end
	end
end

-- A row's place here, scrolled into view and lit (a search result, a
-- preview's hotspot, What's New). -> the row, or nil
function G.Jump(c)
	local at, root = homeOf(c)
	if not at then return nil end
	st.filter = "all"
	-- In a card folded by its module's switch, the row shows dimmed.
	local line = root
	while rawget(line, "psChildOf") do line = line.psChildOf end
	render({ page = at.page, tab = at.tab, reveal = { [line] = true } })
	local view = O.view
	if not (view and view.cache) then return nil end
	local w, top = view.cache[root], nil
	local pill = rawget(view, "psPills") and view.psPills[c]
	-- A child while its parent is off: the parent's row.
	local kidOf = rawget(root, "psChildOf")
	if kidOf and not (w and w:IsShown()) and view.cache[kidOf] then w = view.cache[kidOf] end
	if w then
		top = w.psTop
	elseif pill then
		-- A module's switch: its card.
		w = pill:GetParent():GetParent()
		top = w.psTop
	elseif view.extras[c] then
		w = view.extras[c]:GetParent()
		top = w:GetParent().psTop
	else
		for _, card in ipairs(view.cards or {}) do
			if card:IsShown() and card.psSection == at.section then w, top = card.psLegend and card or card.Header, card.psTop end
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

-- A setting changed while the Changed view is open: it lays out again (a
-- card comes or goes). A live change (a slider dragged) waits to settle.
ns.On("SETTING_CHANGED", function()
	if shown and G.On() and st.filter == "changed" and K.query() == "" and not ns.SettingLive() and win() and win():IsShown() then
		render({ keep = true })
	end
end)

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

-- A dependency's switch changed: the tab lays out again. A module's pill in
-- the search results: the results again (its hits dim or brighten).
ns.On("SETTING_CHANGED", function(path)
	if not (G.On() and type(path) == "string" and win() and win():IsShown()) then return end
	if K.query() == "" then
		if shown and B.depKeys[path] then G.Relayout() end
		return
	end
	local sv = K.searchView()
	for t, p in pairs(sv and rawget(sv, "psPills") or {}) do
		if t.key == path and p:IsVisible() then return O.SetQuery(K.query()) end
	end
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
		-- The Changed view keeps the page it was opened from on B.page and
		-- B.tab: the classic page opens there, and the filter is left.
		local key, tabName = B.page and B.page.key, B.tab and B.tab.name
		st.filter, B.from = "all", nil
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
	G.MigrateSaved()
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
	G.MigrateSaved()
	local r = show(...)
	ensureSwitch()
	if B.Switch then B.Switch.Sw:Refresh() placeSwitch() fitSwitch() end
	return r
end
