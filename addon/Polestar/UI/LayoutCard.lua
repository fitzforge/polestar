-- The 0.4.3 "What's new" card (#3629): one choice, shown once per account
-- after an update from before 0.4.3, beside the real guide window: the
-- player's current design or the new Atlas layout, and the four tab styles,
-- each switching the window underneath live, as often as they like.
--
--   Layout: Your current design | Atlas
--   Tabs:   Above the step bar | Title menu | Top edge | Left side (the one showing marked)
--
-- Before anything changes, when the card opens, the guide window's setup is
-- saved as a look snapshot, "Before Atlas (<date>)", that stays in Settings >
-- Guide window > Presets either way (the card says so). Keep this commits
-- what is showing and closes the card; the ✕ or Escape put the snapshot
-- back, so nothing changes by accident. Atlas writes only its own key
-- (ui.layout); a tab style only guideWindow.tabStyle. The credit line names
-- the author. One line says what the arrow follows and where a quest of the
-- player's own is found (#3701), as Install's first page does. A fresh install
-- never sees the card: Install's look step offers the same choice
-- (UI/Welcome.lua). Per account: PolestarDB.layoutCardSeen.
-- It waits as What's new does: a few seconds after login, out of combat,
-- cinematics and instances, after the welcome, the route choice and What's
-- new itself.
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
--   LC.Show(force), LC.Keep(), LC.Close(), LC.IsShown(), LC.State() (what the card shows)

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local format, ipairs, pairs, type, sort = string.format, ipairs, pairs, type, table.sort

local LC = {}
UI.LayoutCard = LC

LC.VERSION = "0.4.3" -- the update the card is about
LC.MAX = 5 -- look snapshots kept
LC.ATLAS = "atlas"
local DELAY = 4 -- seconds after login: after What's new's own delay
local WIDTH = 440
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
-- The card
---------------------------------------------------------------------------

local F
local snapshot -- taken when the card opened
local kept
local pending

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

-- Beside the guide window, on the side with room; centred without one.
local function place()
	F:ClearAllPoints()
	local g = guideWindow()
	if g and g:IsVisible() and g:GetLeft() then
		local room = g:GetLeft() * (g:GetEffectiveScale() / F:GetEffectiveScale())
		if room >= WIDTH + 24 then
			F:SetPoint("RIGHT", g, "LEFT", -24, 0)
		else
			F:SetPoint("LEFT", g, "RIGHT", 24, 0)
		end
	else
		F:SetPoint("CENTER", UIParent, "CENTER", 0, 60)
	end
end

local function paint()
	if not F then return end
	local atlas = atlasOn()
	F.Current.psPrimary, F.Atlas.psPrimary = not atlas, atlas
	W.RepaintButton(F.Current)
	W.RepaintButton(F.Atlas)
	local style = ns.Get("guideWindow.tabStyle")
	local tabs = ns.Get("guideWindow.tabs") ~= false
	for _, b in ipairs(F.Styles) do
		b.psPrimary = b.psStyle == style
		W.RepaintButton(b)
		b:SetEnabled(tabs)
		b:SetAlpha(tabs and 1 or 0.45)
	end
	F.TabsOff:SetShown(not tabs)
	local g = guideWindow()
	F.NoWindow:SetShown(not (g and g:IsVisible()))
end

local function finish()
	ns.DB().layoutCardSeen = LC.VERSION
	pending = nil
end

function LC.Keep()
	kept = true
	finish()
	if F then F:Hide() end
end

function LC.Close()
	if F then F:Hide() end
end

-- Your current design: the setup the card found, the layout and tab style with it.
local function current()
	if snapshot then LC.Restore(snapshot) end
	paint()
end

local function atlas()
	local T = ns.Theme
	if T and T.SetLayout and not atlasOn() then
		local ok, why = T.SetLayout(LC.ATLAS)
		if not ok then ns.Print(format(L["The layout %s could not be chosen: %s."], "Atlas", tostring(why))) end
	end
	paint()
end

local function style(v)
	ns.Set("guideWindow.tabStyle", v)
	paint()
end

local function row(parent, label, y)
	local t = W.Text(parent, "label", "textDim")
	t:SetText(label)
	t:SetPoint("TOPLEFT", parent, "TOPLEFT", 24, -y)
	return t
end

local function build()
	F = CreateFrame("Frame", "PolestarLayoutCard", ns.UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(WIDTH)
	F:Hide()
	Theme.Skin(F, "window")
	ns.DragWindow(F, F)
	F.Title = W.Text(F, "title", "text")
	F.Title:SetPoint("TOPLEFT", F, "TOPLEFT", 24, -22)
	F.Title:SetText(L["New in 0.4.3: the Atlas layout"])
	F.Text = W.Text(F, "body", "textDim")
	F.Text:SetPoint("TOPLEFT", F, "TOPLEFT", 24, -48)
	F.Text:SetWidth(WIDTH - 48)
	F.Text:SetWordWrap(true)
	F.Text:SetJustifyH("LEFT")
	F.Text:SetText(L["Try it on your own guide window: each button switches it now, as often as you like."])
	F.Close = W.IconButton(F, "close", 28, L["Close"], LC.Close, 12)
	F.Close:SetPoint("TOPRIGHT", F, "TOPRIGHT", -10, -10)
	W.FrameClose(F, F.Close)

	local y = 96
	F.LayoutLabel = row(F, L["Layout"], y)
	F.Current = W.Button(F, L["Your current design"], current, { height = 26 })
	F.Current:SetPoint("TOPLEFT", F, "TOPLEFT", 24, -(y + 20))
	F.Atlas = W.Button(F, "Atlas", atlas, { height = 26 })
	F.Atlas:SetPoint("LEFT", F.Current, "RIGHT", 8, 0)
	y = y + 60
	F.TabsLabel = row(F, L["Tabs"], y)
	F.Styles = {}
	local prev
	for i, s in ipairs(STYLES) do
		local b = W.Button(F, s.label, function() style(s.value) end, { height = 24 })
		b.psStyle = s.value
		if i == 1 then
			b:SetPoint("TOPLEFT", F, "TOPLEFT", 24, -(y + 20))
		elseif i == 3 then
			b:SetPoint("TOPLEFT", F.Styles[1], "BOTTOMLEFT", 0, -6)
		else
			b:SetPoint("LEFT", prev, "RIGHT", 6, 0)
		end
		F.Styles[i], prev = b, b
	end
	F.TabsOff = W.Text(F, "small", "textMuted")
	F.TabsOff:SetPoint("LEFT", F.TabsLabel, "RIGHT", 10, 0)
	F.TabsOff:SetText(L["Tabs are off in Settings > Guide window > Parts."])
	y = y + 20 + 24 + 6 + 24 + 18
	-- What the arrow points at (#3701): the route's step, not any quest in the log.
	F.Arrow = W.Text(F, "small", "textDim")
	F.Arrow:SetPoint("TOPLEFT", F, "TOPLEFT", 24, -y)
	F.Arrow:SetWidth(WIDTH - 48)
	F.Arrow:SetWordWrap(true)
	F.Arrow:SetJustifyH("LEFT")
	F.Arrow:SetText(L["The arrow follows the route step you're on; to go to a quest you already have, open it in Lookup."])
	y = y + math.floor(F.Arrow:GetStringHeight() + 0.5) + 10
	F.Saved = W.Text(F, "small", "textDim")
	F.Saved:SetPoint("TOPLEFT", F, "TOPLEFT", 24, -y)
	F.Saved:SetWidth(WIDTH - 48)
	F.Saved:SetWordWrap(true)
	F.Saved:SetJustifyH("LEFT")
	F.Saved:SetText(L["Your current setup is saved; you can go back to it any time in Settings > Guide window > Presets."])
	F.NoWindow = W.Text(F, "small", "warning")
	F.NoWindow:SetPoint("TOPLEFT", F.Saved, "BOTTOMLEFT", 0, -6)
	F.NoWindow:SetWidth(WIDTH - 48)
	F.NoWindow:SetWordWrap(true)
	F.NoWindow:SetJustifyH("LEFT")
	F.NoWindow:SetText(L["The guide window is hidden: open it to see each choice on your guide."])
	F.Credit = W.Text(F, "small", "textMuted")
	F.Credit:SetText(format(L["Atlas layout and tab styles by %s"], CREDIT))
	F.Keep = W.Button(F, L["Keep this"], LC.Keep, { primary = true })
	F.Keep:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -20, 18)
	F.Credit:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 24, 26)
	F:SetHeight(y + 40 + 28 + 18 + 24)
	-- Closed any other way than Keep this (the ✕, Escape): the setup it found.
	F:SetScript("OnHide", function(self)
		if self:IsShown() then return end -- Polestar hidden with the rest: the card waits
		if not kept and snapshot then LC.Restore(snapshot) end
		if not kept then finish() end
		kept = nil
	end)
	ns.CloseOnEscape("PolestarLayoutCard")
	LC.frame = F
end

local function busy()
	local C = ns.Compat
	if C.InCombat() or (InCinematic and InCinematic()) then return true end
	if C.IsInInstance() then return true end
	local Wel, RC, WN = UI.Welcome, UI.RouteChoice, UI.WhatsNew
	if Wel and Wel.Busy and Wel.Busy() then return true end
	if RC and RC.IsShown and RC.IsShown() then return true end
	if WN and WN.IsShown and WN.IsShown() then return true end
	return false
end

-- Open now (force: whatever is up, out of combat), else wait for the moment.
function LC.Show(force)
	if ns.Compat.InCombat() then
		pending = true
		return false
	end
	if not force and busy() then
		pending = true
		return false
	end
	pending = nil
	-- Without Atlas there is nothing to choose: it stays due for when Atlas is installed.
	if not atlasInstalled() then return false end
	if not F then build() end
	if not F:IsShown() then
		kept = nil
		snapshot = LC.Take(format(L["Before Atlas (%s)"], today()))
	end
	place()
	paint()
	F:Show()
	F:Raise()
	return true
end

function LC.IsShown() return F ~= nil and F:IsShown() end

-- What the card shows (the tests read it).
function LC.State()
	if not F then return nil end
	local styles = {}
	for _, b in ipairs(F.Styles) do styles[#styles + 1] = { b.psStyle, b.psPrimary and true or false } end
	return { shown = F:IsShown(), title = F.Title:GetText(), current = F.Current.psPrimary and true or false, atlas = F.Atlas.psPrimary and true or false,
		styles = styles, saved = F.Saved:GetText(), arrow = F.Arrow:GetText(), credit = F.Credit:GetText(), noWindow = F.NoWindow:IsShown(), snapshot = snapshot and snapshot.name }
end

local function try()
	if pending and not seen() then LC.Show(false) end
end

-- DELAY seconds from now, one wait at a time (the login and the entering
-- world that follows it ask for the same one).
local waiting = false
local function fire()
	waiting = false
	try()
end
local function later()
	if not (C_Timer and C_Timer.After) then return try() end
	if waiting then return end
	waiting = true
	ns.After(DELAY, fire)
end

-- A fresh install chooses in Install's look step: the card is seen.
ns.OnInit(function()
	local db = ns.DB()
	if db.layoutCardSeen == nil and ns.IsNewAccount() then db.layoutCardSeen = LC.VERSION end
end)

ns.OnLogin(function()
	if seen() then return end
	pending = true
	later()
end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function() try() end)
ns.RegisterEvent("CINEMATIC_STOP", function() later() end)
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function() if pending then later() end end)
ns.On("WELCOME_CLOSED", function() try() end)
ns.On("WHATSNEW_CLOSED", function() try() end)
ns.On("SETTING_CHANGED", function(path)
	if F and F:IsShown() and (path == "ui.layout" or path == "guideWindow.tabStyle" or path == "guideWindow.tabs" or path == "" or path == "ui") then paint() end
end)
