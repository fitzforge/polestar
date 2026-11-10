-- The update card and the guide window's update line (Core/Update.lua says
-- what is known).
--
-- The card: the class quest heads-up's card (UI/ClassToast.lua) with
-- "POLESTAR UPDATE", "Polestar 0.3.7 is out", "You're on 0.3.6." (two or more
-- releases behind: "You're on 0.3.5, 2 updates behind: fixes for the quests
-- and arrow issues players report are in the newer versions."), how to
-- update (with Polestar Client installed: that it can do it), "What's new"
-- (the release's notes page in the copy window: the game opens no links, and
-- the notes in the game are this build's) and "Got it" (24 hours of quiet).
-- The close button hides it until the next login.
--
-- When it shows: at every login, DELAY seconds in, while a newer release is
-- known; or the first time one becomes known during a session (a party or
-- guild member's version). Once a session. Never in combat, in an instance,
-- over another heads-up, or in the first FRESH seconds of a fresh install: it
-- waits for each to end. Not while "Got it" holds. Option update.card turns
-- it off, except two or more releases behind: then it still shows, at most
-- once a day.
--
-- The line (GuideFrame's banner, below every other notice): "Polestar 0.3.7
-- is out: you're on 0.3.6." with "Update" (the card, at any time), while a
-- newer release is known; one release behind its close button hides it for
-- the session, two or more it has none and update.card does not hide it.
-- With nothing known, a build first run three weeks ago or more: "This
-- Polestar is 3 weeks old: updates come often, check for a newer one." with
-- "How to update" (the card's how-to), closable for the session. Option
-- update.card off hides both of those.
--
--   UI.UpdateCard.Show(force), .Model(notice), .Banner(), .BannerText(n),
--   .DismissBanner(), .Wanted(), .WhatsNew(version)
--   /polestar update   the card now

local ADDON, ns = ...
local UI, Theme = ns.UI, ns.Theme
local L = ns.L
local format = string.format

local UC = {}
UI.UpdateCard = UC

UC.DELAY = 10 -- seconds after login
UC.FRESH = 120 -- seconds of a fresh install with no card
UC.DAILY = 86400 -- two or more behind with the option off: at most this often

local function U() return ns.Update end
local function CT() return UI.ClassToast end

local shownThisSession = false
local bannerHidden = false -- closed for the session
local waiting = false -- a check held back by combat, an instance, another card or the fresh install
local loginDone = false -- DELAY seconds after login have passed

---------------------------------------------------------------------------
-- What it says
---------------------------------------------------------------------------

-- How to update: Polestar Client, when it is installed, does it.
local function howTo()
	if U().HasClient() then return L["Polestar Client can update it for you: open it, press Update, then restart the game or /reload."] end
	return L["Update it with the CurseForge app or Polestar Client (or the zip from GitHub), then restart the game or /reload."]
end

-- The card for notice n (Update.Notice).
function UC.Model(n)
	local m = { update = n.latest or "old", icon = Theme.Media("logo"), titleColor = "text", head = L["POLESTAR UPDATE"] }
	if n.kind == "old" then
		m.title = L["Check for a newer Polestar"]
		m.giver = format(L["This Polestar is %d weeks old: updates come often."], n.weeks)
	else
		m.title = format(L["Polestar %s is out"], n.latest)
		if n.behind >= 2 then
			m.giver = format(L["You're on %s, %d updates behind: fixes for the quests and arrow issues players report are in the newer versions."], n.mine, n.behind)
		else
			m.giver = format(L["You're on %s."], n.mine)
		end
	end
	m.route = howTo()
	local latest = n.latest
	m.act = { label = L["What's new"], run = function() return UC.WhatsNew(latest) end }
	m.later = { label = L["Got it"], run = function() U().Snooze() end }
	return m
end

-- "What's new": the release's notes page (the newest release's for an old
-- build), to copy into a browser.
function UC.WhatsNew(version)
	if not UI.ShowCopy then return false end
	UI.ShowCopy(version and format(L["Polestar %s: what's new"], version) or L["Polestar releases"], U().ReleaseURL(version), {
		hint = L["The link is selected for you: copy it with Ctrl+C (Cmd+C on a Mac) and open it in your browser."],
	})
	return true
end

---------------------------------------------------------------------------
-- When the card shows
---------------------------------------------------------------------------

local function behind()
	local n = U().Notice()
	return n and n.kind == "behind" and n or nil
end

-- Whether the card is due this session, leaving out the moment (combat, an
-- instance, another card, the fresh install): a newer release known, not
-- shown yet, "Got it" not holding, the option on, or two or more behind and
-- a day since it last showed.
function UC.Wanted()
	local n = behind()
	if not n or shownThisSession or U().Snoozed() then return false end
	if ns.Get("update.card") then return true end
	return n.behind >= 2 and U().SinceShown() >= UC.DAILY
end

-- Why it has to wait now, or nil.
local function blocked()
	local C = ns.Compat
	if C.InCombat and C.InCombat() then return "combat" end
	if C.IsInInstance and C.IsInInstance() then return "instance" end
	local T = CT()
	if T and T.current and T.current.update == nil then return "card" end
	if U().SinceFirstRun() < UC.FRESH then return "fresh" end
	return nil
end

-- A card waiting for the hidden guide window counts once it is on screen.
local hooked = false
local function shownWithWindow()
	local w = UI.GuideFrame and UI.GuideFrame.frame
	if hooked or not w then return end
	hooked = true
	w:HookScript("OnShow", function()
		local T = CT()
		local m = T and T.current
		if m and m.update and m.update ~= "old" and T.frame and T.frame:IsShown() then U().MarkShown(m.update) end
	end)
end

-- Put the card up for notice n. -> true when on screen
local function put(n)
	local T = CT()
	if not (T and T.ShowCard) then return false end
	local m = UC.Model(n)
	local on = T.ShowCard(m)
	if n.kind == "behind" then
		if on then
			U().MarkShown(n.latest)
		elseif T.current == m then
			shownWithWindow()
		end
	end
	return on
end

-- Show the card. force (the line's Update, /polestar update): now, whatever
-- the moment and the rules, also the how-to for an old build. -> true when
-- shown (or waiting for the hidden guide window)
function UC.Show(force)
	local n = U().Notice()
	if force then
		if not n then return false end
		put(n)
		return CT().current ~= nil and CT().current.update ~= nil
	end
	if not UC.Wanted() then return false end
	if blocked() then
		waiting = true
		return false
	end
	waiting = false
	shownThisSession = true
	put(n)
	return true
end

local function retry()
	if not waiting then return end
	ns.After(1, function()
		if waiting then UC.Show() end
	end)
end

---------------------------------------------------------------------------
-- The guide window's line
---------------------------------------------------------------------------

-- What the line says, or nil: { kind, latest, behind, mine, weeks, closable }.
function UC.Banner()
	local n = U().Notice()
	if not n then return nil end
	local strong = n.kind == "behind" and n.behind >= 2
	if not strong and (bannerHidden or not ns.Get("update.card")) then return nil end
	n.closable = not strong
	return n
end

function UC.BannerText(n)
	if n.kind == "old" then return format(L["This Polestar is %d weeks old: updates come often, check for a newer one."], n.weeks) end
	if n.behind >= 2 then return format(L["Polestar %s is out: you're on %s, %d updates behind."], n.latest, n.mine, n.behind) end
	return format(L["Polestar %s is out: you're on %s."], n.latest, n.mine)
end

function UC.DismissBanner()
	local n = UC.Banner()
	if n and n.closable then bannerHidden = true end
end

local function relayout()
	local GF = UI.GuideFrame
	if GF and GF.frame and GF.Layout and ns.IsLoggedIn() then GF.Layout() end
end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

ns.OnLogin(function()
	ns.After(UC.DELAY, function()
		loginDone = true
		UC.Show()
		relayout()
	end)
end)

-- A newer release heard of during the session (a party or guild member);
-- before the login's DELAY is up, the login's check tells it.
ns.On("UPDATE_KNOWN", function()
	relayout()
	if loginDone then ns.After(1, function() UC.Show() end) end
end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", retry)
ns.RegisterEvent("PLAYER_ENTERING_WORLD", retry)
ns.On("HEADS_UP_HIDDEN", retry)
-- The fresh install's quiet minutes: one try once they are over.
ns.OnLogin(function()
	local left = UC.FRESH - U().SinceFirstRun()
	if left > 0 then ns.After(left + 1, function() retry() end) end
end)
ns.On("SETTING_CHANGED", function(path)
	if path == "update.card" then relayout() end
end)
