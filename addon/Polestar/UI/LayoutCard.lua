-- The 0.4.3 layout choice (#3629, #3876): a section of the What's new card
-- (UI/WhatsNew.lua), centred under the notes, in its style: the Atlas
-- layout and the four tab styles, each switching the guide window
-- underneath live, as often as the player likes.
--
--   Layout: Standard | Atlas          "(your current)" after the player's own
--   Tabs:   Above the step bar | Title menu | Top edge | Left side (the one showing marked)
--
-- When What's new opens with the section, the guide window's setup is saved
-- as a look snapshot, "Before Atlas (<date>)", that stays in Settings >
-- Guide window > Presets either way (the section says so); a snapshot that
-- matches the setup already is used again, not taken twice. The ✕ or Escape
-- put the snapshot back, so nothing changes by accident; What's new's
-- buttons (Keep this, Open the guide list) keep what is showing. Standard is
-- Polestar's own layout and Atlas the new one, whatever the player had: the
-- one they had is marked "(your current)", and picking it puts their whole
-- setup back (the tab style with it). Atlas writes only its own key
-- (ui.layout); a tab style only guideWindow.tabStyle. The credit line names
-- the author; one line says what the arrow follows and where a quest of the
-- player's own is found (#3701), as Install's first page does.
--
-- What's new opens at login while its notes are new or the section is due
-- (LC.Due: Atlas installed, the account not past this choice), once: one
-- card, not two. A fresh install never sees the section at login: Install's
-- look step offers the same choice (UI/Welcome.lua). Per account:
-- PolestarDB.layoutCardSeen. /polestar whatsnew shows it again.
--
-- Look snapshots (also taken by the Presets row before a card replaces the
-- player's own look, Polestar_Options/UI/Presets.lua): the stored values of
-- every guide window setting (LC.SnapshotKeys: the guideWindow section, the
-- ui keys of the window, the layout's own defaults' keys), account-wide in
-- PolestarDB.lookSnapshots, newest first, LC.MAX at most. Restoring one puts
-- back exactly the keys it holds, each as it was stored (nil: the default),
-- and nothing else.
--
--   LC.SnapshotKeys() -> { path, ... }
--   LC.Take(name) -> snapshot     { name, at, keys = { path, ... }, values = { [path] = stored } }
--   LC.Restore(snapshot)          LC.Snapshots() -> { snapshot, ... }
--   LC.Offered(), LC.Due()        the section shown / due at login
--   LC.Section(parent) -> frame   LC.LayoutSection(width) -> height
--   LC.Begin(), LC.End(keep)      What's new opened with it / closed
--   LC.IsShown(), LC.State()      (what the section shows)

local ADDON, ns = ...
local UI, W = ns.UI, ns.Widgets
local L = ns.L
local format, ipairs, pairs, type, sort = string.format, ipairs, pairs, type, table.sort

local LC = {}
UI.LayoutCard = LC

LC.VERSION = "0.4.3" -- the update the card is about
LC.MAX = 5 -- look snapshots kept
LC.ATLAS = "atlas"
local CREDIT = "TTik3r"

-- The tab styles in the window's order, with the names Settings gives them.
local STYLES = {
	{ value = "underline", label = L["Above the step bar"] },
	{ value = "switcher", label = L["Title menu"] },
	{ value = "edge", label = L["On the top edge"] },
	{ value = "strip", label = L["Down the left side"] },
}
LC.STYLES = STYLES

---------------------------------------------------------------------------
-- Look snapshots
---------------------------------------------------------------------------

-- The window's ui keys besides its own section (guideWindow.*): where it is,
-- its size, scale, skin, layout and the looks the Presets row sets.
local UI_KEYS = { "ui.layout", "ui.skin", "ui.pos", "ui.scale", "ui.width", "ui.compact", "ui.style", "ui.backing",
	"ui.growUp", "ui.upcoming", "ui.upcomingOpen", "ui.showNotes" }

local function same(a, b)
	if type(a) ~= "table" or type(b) ~= "table" then return a == b end
	for k, v in pairs(a) do if not same(v, b[k]) then return false end end
	for k in pairs(b) do if a[k] == nil then return false end end
	return true
end

local function copy(v)
	if type(v) ~= "table" then return v end
	local t = {}
	for k, x in pairs(v) do t[k] = copy(x) end
	return t
end

function LC.SnapshotKeys()
	local set, out = {}, {}
	local function add(path)
		if not set[path] then set[path], out[#out + 1] = true, path end
	end
	for _, k in ipairs(UI_KEYS) do add(k) end
	local gw = ns.GetBaseDefault and ns.GetBaseDefault("guideWindow")
	if type(gw) == "table" then
		for k in pairs(gw) do add("guideWindow." .. k) end
	end
	-- Every layout's own defaults (Atlas's Up next state, its tab style...).
	local T = ns.Theme
	for _, id in ipairs(T and T.Layouts and T.Layouts() or {}) do
		local info = T.LayoutInfo(id)
		for path in pairs(info and info.defaults or {}) do add(path) end
	end
	sort(out)
	return out
end

local function store()
	local db = ns.DB()
	if type(db.lookSnapshots) ~= "table" then db.lookSnapshots = {} end
	return db.lookSnapshots
end

function LC.Snapshots() return store() end

-- Whether the settings hold exactly what snapshot `snap` saved (each of its keys as stored).
function LC.Matches(snap)
	local values = snap and snap.values or {}
	for _, k in ipairs(snap and snap.keys or {}) do
		if not same(ns.GetStored(k), values[k]) then return false end
	end
	return true
end

local function today()
	return date and date("%Y-%m-%d") or "?"
end

function LC.Take(name)
	local keys = LC.SnapshotKeys()
	local values = {}
	for _, k in ipairs(keys) do values[k] = copy(ns.GetStored(k)) end
	local snap = { name = name or format(L["Before Atlas (%s)"], today()), at = time and time() or 0, keys = keys, values = values }
	local list = store()
	table.insert(list, 1, snap)
	for i = #list, LC.MAX + 1, -1 do list[i] = nil end
	ns.Fire("LOOK_SNAPSHOTS_CHANGED")
	return snap
end

-- The keys it holds, each as it was stored. The layout through Theme.SetLayout
-- (it loads the layout's addon), the rest in one batch.
function LC.Restore(snap)
	if type(snap) ~= "table" or type(snap.keys) ~= "table" then return false end
	local values = snap.values or {}
	local T = ns.Theme
	local layout = values["ui.layout"]
	if (ns.GetStored("ui.layout") or nil) ~= (layout or nil) and T and T.SetLayout then T.SetLayout(layout) end
	ns.Batch(function()
		for _, k in ipairs(snap.keys) do
			if k ~= "ui.layout" then
				local want = values[k]
				local now = ns.GetStored(k)
				if want == nil then
					if now ~= nil then ns.Set(k, nil) end
				elseif not same(now, want) then
					ns.Set(k, copy(want))
				end
			end
		end
	end)
	return true
end

---------------------------------------------------------------------------
-- The section in What's new
---------------------------------------------------------------------------

local S -- the section's frame (LC.Section)
local snapshot -- the setup What's new found when it opened with the section

local function seen() return ns.DB().layoutCardSeen ~= nil end

-- Atlas registered, or installed to load when picked.
local function atlasInstalled()
	local T = ns.Theme
	if not T then return false end
	if T.LayoutInfo and T.LayoutInfo(LC.ATLAS) then return true end
	for _, p in ipairs(T.LayoutPresets and T.LayoutPresets() or {}) do
		if p.id == LC.ATLAS then return true end
	end
	return false
end

local function atlasOn() return ns.Theme and ns.Theme.LayoutId and ns.Theme.LayoutId() == LC.ATLAS end

local function guideWindow() return _G.PolestarGuideFrame end

-- Without Atlas there is nothing to choose: no section, and it stays due for
-- when Atlas is installed.
function LC.Offered() return atlasInstalled() end
function LC.Due() return not seen() and atlasInstalled() end

-- The layout the player had when What's new opened: "atlas" or nil (Standard).
local function ownLayout()
	local v = snapshot and snapshot.values["ui.layout"]
	return v == LC.ATLAS and LC.ATLAS or nil
end

local function paint()
	if not S then return end
	local atlas, own = atlasOn(), ownLayout()
	local mine = " " .. L["(your current)"]
	W.SetButtonText(S.Standard, L["Standard"] .. (snapshot and own == nil and mine or ""))
	W.SetButtonText(S.Atlas, "Atlas" .. (own == LC.ATLAS and mine or ""))
	S.Standard.psPrimary, S.Atlas.psPrimary = not atlas, atlas
	W.RepaintButton(S.Standard)
	W.RepaintButton(S.Atlas)
	local style = ns.Get("guideWindow.tabStyle")
	local tabs = ns.Get("guideWindow.tabs") ~= false
	for _, b in ipairs(S.Styles) do
		b.psPrimary = b.psStyle == style
		W.RepaintButton(b)
		b:SetEnabled(tabs)
		b:SetAlpha(tabs and 1 or 0.45)
	end
	S.TabsOff:SetShown(not tabs)
	local g = guideWindow()
	S.NoWindow:SetShown(not (g and g:IsVisible()))
end

-- A layout picked: the player's own puts their whole setup back (the tab
-- style with it); the other is switched to.
local function pick(layout)
	local T = ns.Theme
	if snapshot and layout == ownLayout() then
		LC.Restore(snapshot)
	elseif T and T.SetLayout and (layout == LC.ATLAS) ~= atlasOn() then
		local ok, why = T.SetLayout(layout)
		if not ok and layout then ns.Print(format(L["The layout %s could not be chosen: %s."], "Atlas", tostring(why))) end
	end
	paint()
end

local function style(v)
	ns.Set("guideWindow.tabStyle", v)
	paint()
end

local function centred(parent, role, color)
	local t = W.Text(parent, role, color)
	t:SetWordWrap(true)
	t:SetJustifyH("CENTER")
	return t
end

-- The section's frame in `parent` (What's new), built once.
function LC.Section(parent)
	if S then return S end
	S = CreateFrame("Frame", nil, parent)
	S.Rule = W.Divider(S)
	S.Rule:SetPoint("TOPLEFT", S, "TOPLEFT", 0, 0)
	S.Rule:SetPoint("TOPRIGHT", S, "TOPRIGHT", 0, 0)
	S.Title = centred(S, "heading", "text")
	S.Title:SetText(L["New in 0.4.3: the Atlas layout"])
	S.Text = centred(S, "note", "textMuted")
	S.Text:SetText(L["Try it on your own guide window: each button switches it now, as often as you like."])
	S.Standard = W.Button(S, L["Standard"], function() pick(nil) end, { height = 26 })
	S.Atlas = W.Button(S, "Atlas", function() pick(LC.ATLAS) end, { height = 26 })
	S.TabsLabel = centred(S, "small", "textDim")
	S.TabsLabel:SetText(L["Tabs"])
	S.Styles = {}
	for i, s in ipairs(STYLES) do
		local b = W.Button(S, s.label, function() style(s.value) end, { height = 24 })
		b.psStyle = s.value
		S.Styles[i] = b
	end
	S.TabsOff = centred(S, "small", "textMuted")
	S.TabsOff:SetText(L["Tabs are off in Settings > Guide window > Parts."])
	-- What the arrow points at (#3701): the route's step, not any quest in the log.
	S.Arrow = centred(S, "small", "textDim")
	S.Arrow:SetText(L["The arrow follows the route step you're on; to go to a quest you already have, open it in Lookup."])
	S.Saved = centred(S, "small", "textDim")
	S.Saved:SetText(L["Your current setup is saved; you can go back to it any time in Settings > Guide window > Presets."])
	S.NoWindow = centred(S, "small", "warning")
	S.NoWindow:SetText(L["The guide window is hidden: open it to see each choice on your guide."])
	S.Credit = centred(S, "small", "textMuted")
	S.Credit:SetText(format(L["Atlas layout and tab styles by %s"], CREDIT))
	S:Hide()
	LC.frame = S
	return S
end

-- A row of buttons centred across `width` from `y`, wrapping into rows of
-- `perRow` when one row would not fit. -> the y under it
local function centreRow(list, width, y, gap, perRow)
	local total = 0
	for i, b in ipairs(list) do total = total + b:GetWidth() + (i > 1 and gap or 0) end
	if total > width and perRow < #list then
		local rows, i = {}, 1
		while i <= #list do
			local r = {}
			for k = i, math.min(#list, i + perRow - 1) do r[#r + 1] = list[k] end
			rows[#rows + 1], i = r, i + perRow
		end
		for _, r in ipairs(rows) do y = centreRow(r, width, y, gap, #r) + 6 end
		return y - 6
	end
	local x = math.floor((width - total) / 2 + 0.5)
	for _, b in ipairs(list) do
		b:ClearAllPoints()
		b:SetPoint("TOPLEFT", S, "TOPLEFT", x, -y)
		x = x + b:GetWidth() + gap
	end
	return y + list[1]:GetHeight()
end

-- Lays the section out `width` wide. -> its height
function LC.LayoutSection(width)
	paint()
	S:SetWidth(width)
	local function text(t, y)
		t:SetWidth(width)
		t:ClearAllPoints()
		t:SetPoint("TOPLEFT", S, "TOPLEFT", 0, -y)
		return y + t:GetStringHeight()
	end
	local y = text(S.Title, 16) + 4
	y = text(S.Text, y) + 12
	y = centreRow({ S.Standard, S.Atlas }, width, y, 8, 2) + 14
	y = text(S.TabsLabel, y) + 6
	y = centreRow(S.Styles, width, y, 6, 2) + 8
	if S.TabsOff:IsShown() then y = text(S.TabsOff, y) + 6 end
	y = text(S.Arrow, y + 4) + 6
	y = text(S.Saved, y) + 6
	if S.NoWindow:IsShown() then y = text(S.NoWindow, y) + 6 end
	y = text(S.Credit, y + 2)
	local h = math.ceil(y + 4)
	S:SetHeight(h)
	return h
end

-- What's new opened with the section: the setup it finds is saved (the
-- newest snapshot again when it holds that setup already).
function LC.Begin()
	local newest = LC.Snapshots()[1]
	snapshot = (newest and LC.Matches(newest)) and newest or LC.Take(format(L["Before Atlas (%s)"], today()))
	if S then S:Show() end
	paint()
end

-- What's new closed: by its ✕ or Escape (`keep` false) the setup it found
-- goes back; either way the choice is seen.
function LC.End(keep)
	if not keep and snapshot then LC.Restore(snapshot) end
	snapshot = nil
	if S then S:Hide() end
	ns.DB().layoutCardSeen = LC.VERSION
end

function LC.IsShown() return S ~= nil and S:IsVisible() end

-- What the section shows (the tests read it).
function LC.State()
	if not S then return nil end
	local styles = {}
	for _, b in ipairs(S.Styles) do styles[#styles + 1] = { b.psStyle, b.psPrimary and true or false } end
	return { shown = S:IsVisible(), title = S.Title:GetText(), standard = S.Standard.Label:GetText(), atlas = S.Atlas.Label:GetText(),
		standardOn = S.Standard.psPrimary and true or false, atlasOn = S.Atlas.psPrimary and true or false,
		styles = styles, saved = S.Saved:GetText(), arrow = S.Arrow:GetText(), credit = S.Credit:GetText(), noWindow = S.NoWindow:IsShown(),
		snapshot = snapshot and snapshot.name }
end

-- A fresh install chooses in Install's look step: the choice is seen.
ns.OnInit(function()
	local db = ns.DB()
	if db.layoutCardSeen == nil and ns.IsNewAccount() then db.layoutCardSeen = LC.VERSION end
end)

-- A layout, tab style or the tabs switched (here or anywhere): What's new
-- lays the section out again (a line about the tabs comes or goes).
ns.On("SETTING_CHANGED", function(path)
	if not (S and S:IsShown() and (path == "ui.layout" or path == "guideWindow.tabStyle" or path == "guideWindow.tabs" or path == "" or path == "ui")) then return end
	local WN = UI.WhatsNew
	if WN and WN.Relayout then WN.Relayout() else paint() end
end)
