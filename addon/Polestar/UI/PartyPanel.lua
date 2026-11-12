-- The party panel: a small movable panel with one row per party member who
-- runs Polestar (Quests/Party.lua, Party.Roster: those who have spoken it):
-- the name in its class colour, level and XP, the step they are on (or
-- "Other guide"), what they still need of your live step, and whether they
-- are dead, far away or offline. Nothing shows without such a member. A
-- click on a row points the arrow at the member where the client gives
-- their place on the map (Party.PointAt). Opens by itself once a member's
-- Polestar is heard while party sync listens in a party, unless the player
-- closed it (party.panel false); hidden with the guide, and in combat when
-- the guide hides there. Toggled from the guide window's party line and
-- /polestar party (which says why when nothing can show yet; "/polestar
-- party debug" prints Party.Debug); its place is kept in party.panelPos.
-- "Sync to my guide" in its header (and /polestar party sync) asks the
-- party to move to your step (Party.RequestSync). Its scale, width, opacity,
-- type, ground and what it does in a fight or an instance are the player's
-- (trackers.party.*, Options > Trackers; PP.NewPanel/FillRows draw a sandbox
-- one for its preview).

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L

local PP = {}
UI.PartyPanel = PP

local WIDTH = 260
local PAD = 10
local HEAD_H = 26
local DOT = "  \194\183  "
local REFRESH = 2 -- seconds between repaints while shown (dead, far, offline)

local F, ticker
local inCombat = false

local function hexOf(r, g, b)
	return ("|cff%02x%02x%02x"):format(math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5))
end

local function trackers() return UI.Trackers end

-- Its own rules first (Options > Trackers): inside an instance, kept or
-- hidden; in a fight, shown, faded or hidden as the player set it for the
-- panel, or as the guide window ("As the guide window": ui.combat "hide"
-- hides it too). TR.Allowed has no say on a fight under the guide's rule.
local function rulesHide()
	local TR = trackers()
	if TR and not TR.Allowed("party") then return true end
	local rule = TR and TR.Get("party", "combat") or "guide"
	return rule == "guide" and inCombat and ns.Get("ui.combat") == "hide"
end

-- The rows to show (Party.Roster), or false when the panel should not show.
local function wanted()
	local P = ns.Party
	if not (ns.Get("party.panel") and P and P.IsLive and P.IsLive()) then return false end
	if not ns.GuideShown() then return false end
	if rulesHide() then return false end
	local list = P.Roster()
	return #list > 0 and list
end

-- The panel's width: the player's (Options > Trackers), else WIDTH.
local function width(p)
	return p and p.psWidth or WIDTH
end

local function row(F, i)
	local r = F.rows[i]
	if r then return r end
	r = CreateFrame("Button", nil, F)
	r:SetPoint("LEFT", F, "LEFT", PAD, 0)
	r:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
	W.Hover(r, 0.5)
	r.Name = W.Text(r, "label", "text")
	r.Name:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -3)
	r.Name:SetJustifyH("LEFT")
	r.Name:SetWordWrap(false)
	r.Level = W.Text(r, "small", "textDim")
	r.Level:SetPoint("TOPRIGHT", r, "TOPRIGHT", 0, -4)
	r.Level:SetJustifyH("RIGHT")
	r.Name:SetPoint("RIGHT", r.Level, "LEFT", -6, 0)
	r.Step = W.Text(r, "small", "textDim")
	r.Step:SetPoint("TOPLEFT", r.Name, "BOTTOMLEFT", 0, -2)
	r.Step:SetPoint("RIGHT", r, "RIGHT", 0, 0)
	r.Step:SetJustifyH("LEFT")
	r.Step:SetWordWrap(false)
	r.Needs = W.Text(r, "small", "textMuted")
	r.Needs:SetPoint("TOPLEFT", r.Step, "BOTTOMLEFT", 0, -2)
	r.Needs:SetPoint("RIGHT", r, "RIGHT", 0, 0)
	r.Needs:SetJustifyH("LEFT")
	r.Needs:SetWordWrap(true)
	local TR = trackers()
	if TR then TR.AddText(F, { r.Name }, { r.Level, r.Step, r.Needs }) end
	if F.psSandbox then
		F.rows[i] = r
		return r
	end
	r:SetScript("OnClick", function(self)
		local P = ns.Party
		if self.psUnit and P and P.PointAt then P.PointAt(self.psUnit) end
	end)
	r:SetScript("OnEnter", function(self)
		local where = self.psUnit and ns.Compat.GetUnitMapPosition(self.psUnit)
		W.Tooltip(self, "ANCHOR_RIGHT", self.psName or "", {
			where and L["Click to point the arrow at them."] or L["The game doesn't say where they are (in an instance, or out of reach)."],
		})
	end)
	r:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	F.rows[i] = r
	return r
end

-- The panel's header on p: the live panel (a Maps.CompactFrame) or a sandbox
-- one for the options' preview (PP.NewPanel). Its size, type and ground are
-- the player's (Options > Trackers, UI/Looks/Trackers.lua).
local function dress(p, sandbox)
	local noop = function() end
	p.psSandbox = sandbox or nil
	p:SetWidth(WIDTH)
	p.Title = W.Text(p, "small", "textMuted")
	p.Title:SetPoint("TOPLEFT", p, "TOPLEFT", PAD, -8)
	p.Title:SetText(L["Party"])
	p.Close = W.IconButton(p, "close", 18, L["Close"], sandbox and noop or function() ns.Set("party.panel", false) end, 10)
	p.Close:SetPoint("TOPRIGHT", p, "TOPRIGHT", -4, -4)
	p.Sync = W.Button(p, "", sandbox and noop or function() ns.Party.RequestSync() end, { ghost = true, height = 18 })
	p.Sync.psTight = true
	W.SetButtonText(p.Sync, L["Sync to my guide"])
	p.Sync.psTip = L["Sync to my guide"]
	p.Sync.psTipLines = { L["Asks your party to move to your step. Each of them gets a prompt; nothing changes for anyone who declines."] }
	p.Sync:SetPoint("RIGHT", p.Close, "LEFT", -4, 0)
	p.rows = {}
	local TR = trackers()
	if TR then
		TR.Attach("party", p, { titles = { p.Title }, sandbox = sandbox,
			refresh = not sandbox and function() PP.Sync() end or nil,
			relayout = function(self)
				if self.psList then PP.FillRows(self, self.psList) elseif self == F then PP.Refresh() end
			end })
	end
	return p
end

local function build()
	if F then return end
	F = dress(ns.Maps.CompactFrame("PolestarPartyPanel", "party.panelPos", "TOPLEFT", 280, -220))
	F:SetScript("OnHide", function()
		if ticker then
			ticker:Cancel()
			ticker = nil
		end
	end)
end

-- A sandbox panel for the options' preview, and its rows for a made-up roster.
function PP.NewPanel(parent)
	local p = CreateFrame("Frame", nil, parent)
	p.psLight = true
	Theme.Skin(p, "window")
	return dress(p, true)
end

-- The row texts of a Party.Roster entry: name (class colour), level line,
-- step line, needs line or nil.
function PP.RowText(e)
	local name = e.name
	local r, g, b
	if e.class then r, g, b = Theme.ClassColor(e.class) end
	if r then name = hexOf(r, g, b) .. name .. "|r" end
	local level = e.level and L["Level %d"]:format(e.level) or ""
	if e.xp then level = level .. DOT .. L["%d%% XP"]:format(e.xp) end
	-- Boosted Rest (their "2B|"), unless the player turned the status off.
	local Q = ns.QoL
	if e.rest and not (Q and Q.On and not Q.On("boostedRest")) then
		-- Minutes rounded up, to the millisecond first (a frame clock a hair past the minute adds none).
		local rest = e.rest == true and L["Boosted Rest"] or L["Boosted Rest %dm"]:format(math.ceil(math.floor(e.rest * 1000 + 0.5) / 60000))
		level = level ~= "" and (level .. DOT .. rest) or rest
	end
	local parts = {}
	if e.step then
		parts[#parts + 1] = e.step
	elseif e.otherGuide then
		parts[#parts + 1] = L["Other guide"]
	end
	if e.offline then parts[#parts + 1] = L["Offline"] end
	if e.dead then parts[#parts + 1] = L["Dead"] end
	if e.far then parts[#parts + 1] = L["Far away"] end
	local needs = {}
	for i, n in ipairs(e.needs or {}) do needs[i] = n.what .. " " .. n.cur .. "/" .. n.max end
	return name, level, table.concat(parts, DOT), #needs > 0 and L["Still needs: %s"]:format(table.concat(needs, DOT)) or nil
end

-- Panel p's rows for roster `list` (Party.Roster's entries).
function PP.FillRows(F, list)
	if F.psSandbox then F.psList = list end
	local w = width(F)
	local y = HEAD_H
	for i, e in ipairs(list) do
		local r = row(F, i)
		local name, level, step, needs = PP.RowText(e)
		r.psUnit, r.psName = e.unit, e.name
		r.Name:SetText(name)
		r.Level:SetText(level)
		r.Step:SetText(step or "")
		local hasStep = step ~= nil and step ~= ""
		r.Step:SetShown(hasStep)
		UI.SetCounted(r.Needs, needs or "")
		r.Needs:SetShown(needs ~= nil)
		r.Needs:SetWidth(w - PAD * 2)
		UI.FitCounts(r.Needs)
		-- The needs line hangs under the step line only while that shows: a
		-- hidden region still holds its place in an anchor chain, and an empty
		-- one may keep a line's height, which the row's height below leaves out.
		r.Needs:SetPoint("TOPLEFT", hasStep and r.Step or r.Name, "BOTTOMLEFT", 0, -2)
		local h = 6 + r.Name:GetStringHeight()
		if hasStep then h = h + 2 + r.Step:GetStringHeight() end
		if r.Needs:IsShown() then h = h + 2 + r.Needs:GetStringHeight() end
		h = math.floor(h + 4 + 0.5)
		r:SetHeight(h)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -y)
		r:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
		r:Show()
		y = y + h + 2
	end
	for i = #list + 1, #F.rows do F.rows[i]:Hide() end
	F:SetHeight(math.floor(y + PAD - 2 + 0.5))
end

-- Repaint the rows from Party.Roster (`list`: one just read); without a row,
-- the panel hides.
local function refresh(list)
	if not (F and F:IsShown()) then return end
	list = list or ns.Party.Roster()
	if #list == 0 then return F:Hide() end
	PP.FillRows(F, list)
end
-- The ticker and STEP_CHANGED pass arguments of their own: never a list.
function PP.Refresh() refresh(nil) end

-- Show or hide as the settings, the group, the guide and a fight say.
function PP.Sync()
	local list = wanted()
	if not list then
		if F then F:Hide() end
		return
	end
	build()
	F:Show()
	refresh(list)
	if not ticker and C_Timer and C_Timer.NewTicker then ticker = ns.NewTicker(REFRESH, PP.Refresh) end
end

-- Why the panel cannot show now, or nil when it can.
local function whyNot()
	local P = ns.Party
	if not (ns.Get("party.share") or ns.Get("party.show")) then
		return L["Party sync is off: turn it on in Options > Questing > Quests > Group."]
	end
	if not (P and P.IsLive and P.IsLive()) then return L["The party panel shows in a party (not a raid)."] end
	if not ns.GuideShown() then return L["The party panel shows with the guide window."] end
	if #P.Roster() == 0 then
		return L["No one else in your party has been heard running Polestar yet. The panel opens by itself as soon as someone is."]
	end
	if rulesHide() then
		local TR, C = trackers(), ns.Compat
		if TR and TR.Get("party", "instance") == "hide" and C.IsInInstance and C.IsInInstance() then
			return L["The party panel is hidden inside instances: Options > Trackers > Party panel."]
		end
		return L["The party panel comes back after combat."]
	end
	return nil
end

-- The guide window's party line and /polestar party: an open panel closes
-- (and stays closed: party.panel false), a closed one opens, or it says why
-- it cannot yet. "/polestar party debug": Party.Debug's lines; "/polestar
-- party sync": Party.RequestSync.
function PP.Toggle(arg)
	if type(arg) == "string" and arg:lower() == "debug" then
		for _, line in ipairs(ns.Party.Debug()) do ns.Print(line) end
		return
	end
	if type(arg) == "string" and arg:lower() == "sync" then return ns.Party.RequestSync() end
	if F and F:IsShown() then return ns.Set("party.panel", false) end
	ns.Set("party.panel", true)
	if not (F and F:IsShown()) then
		local why = whyNot()
		if why then ns.Print(why) end
	end
end

function PP.Frame() return F end

local function onCombat()
	inCombat = true
	if F and F:IsShown() then PP.Sync() end
end
local function onPeace()
	inCombat = false
	if ns.Get("party.panel") then PP.Sync() end
end

-- Party sync listening (a party) or not: the combat events only then.
local function onLive(on)
	if on then
		inCombat = ns.Compat.InCombat and ns.Compat.InCombat() or false
		ns.RegisterEvent("PLAYER_REGEN_DISABLED", onCombat)
		ns.RegisterEvent("PLAYER_REGEN_ENABLED", onPeace)
	else
		ns.UnregisterEvent("PLAYER_REGEN_DISABLED", onCombat)
		ns.UnregisterEvent("PLAYER_REGEN_ENABLED", onPeace)
	end
	PP.Sync()
end

ns.On("PARTY_LIVE", onLive)
-- A member who speaks Polestar (or leaves) shows or hides the panel; a
-- member's XP alone comes as PARTY_PANEL (Party.lua panelChanged).
ns.On("PARTY_PROGRESS", PP.Sync)
ns.On("PARTY_PANEL", PP.Sync)
ns.On("STEP_CHANGED", PP.Refresh)
ns.On("SETTING_CHANGED", function(path)
	if path == "party.panelPos" then
		if F then F.Place() end
	elseif path == "" or path == "party" or path == "party.panel" or path == "party.show" or path == "party.share" or path == "ui.shown" or path == "ui.combat" then
		PP.Sync()
	end
end)
ns.On("GUIDE_SHOWN", PP.Sync) -- an instance hide (ns.GuideShown)
ns.OnLogin(PP.Sync)

ns.RegisterCommand("party", PP.Toggle, L["Show or hide the party panel"])
