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

local function wanted()
	local P = ns.Party
	if not (ns.Get("party.panel") and P and P.IsLive and P.IsLive()) then return false end
	if not ns.GuideShown() then return false end
	if inCombat and ns.Get("ui.combat") == "hide" then return false end
	return #P.Roster() > 0
end

local function row(i)
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

local function build()
	if F then return end
	F = ns.Maps.CompactFrame("PolestarPartyPanel", "party.panelPos", "TOPLEFT", 280, -220)
	F:SetWidth(WIDTH)
	F.Title = W.Text(F, "small", "textMuted")
	F.Title:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -8)
	F.Title:SetText(L["Party"])
	F.Close = W.IconButton(F, "close", 18, L["Close"], function() ns.Set("party.panel", false) end, 10)
	F.Close:SetPoint("TOPRIGHT", F, "TOPRIGHT", -4, -4)
	F.rows = {}
	F:SetScript("OnHide", function()
		if ticker then
			ticker:Cancel()
			ticker = nil
		end
	end)
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

-- Repaint the rows from Party.Roster; without a row, the panel hides.
function PP.Refresh()
	if not (F and F:IsShown()) then return end
	local list = ns.Party.Roster()
	if #list == 0 then return F:Hide() end
	local y = HEAD_H
	for i, e in ipairs(list) do
		local r = row(i)
		local name, level, step, needs = PP.RowText(e)
		r.psUnit, r.psName = e.unit, e.name
		r.Name:SetText(name)
		r.Level:SetText(level)
		r.Step:SetText(step or "")
		r.Step:SetShown(step ~= nil and step ~= "")
		r.Needs:SetText(needs or "")
		r.Needs:SetShown(needs ~= nil)
		r.Needs:SetWidth(WIDTH - PAD * 2)
		local h = 6 + r.Name:GetStringHeight()
		if r.Step:IsShown() then h = h + 2 + r.Step:GetStringHeight() end
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

-- Show or hide as the settings, the group and the guide say.
function PP.Sync()
	if not wanted() then
		if F then F:Hide() end
		return
	end
	build()
	F:Show()
	PP.Refresh()
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
	if inCombat and ns.Get("ui.combat") == "hide" then return L["The party panel comes back after combat."] end
	return nil
end

-- The guide window's party line and /polestar party: an open panel closes
-- (and stays closed: party.panel false), a closed one opens, or it says why
-- it cannot yet. "/polestar party debug": Party.Debug's lines;
-- "/polestar party selftest": Party.SelfTest, the check with nobody else.
function PP.Toggle(arg)
	local sub = type(arg) == "string" and arg:lower() or ""
	if sub == "debug" then
		for _, line in ipairs(ns.Party.Debug()) do ns.Print(line) end
		return
	end
	if sub == "selftest" then return ns.Party.SelfTest() end
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
-- A member who speaks Polestar (or leaves) shows or hides the panel.
ns.On("PARTY_PROGRESS", PP.Sync)
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
