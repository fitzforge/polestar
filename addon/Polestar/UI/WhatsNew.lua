-- What's new: a window in the welcome's look (UI/Welcome.lua's building
-- blocks), 600 wide and centred, that tells a player who updated what the
-- release changed for them. One page: a compact night hero (the band, the
-- haze, the Dipper and the emblem on the right) with "What's new in
-- Polestar <version>" in Hero; the release's notes under hairlines, each a
-- glyph, a heading and its line; a footer with "Full notes: polestar.guide"
-- (text only) on the left, "Open the guide list" and "Got it" on the right.
--
-- NOTES holds the releases' notes, newest first: a release with something to
-- tell adds an entry, and the window shows the newest.
--
-- Per account: PolestarDB.whatsNewSeen, the version of the notes last shown.
-- The notes are about the addon, not one character, so a player with alts
-- reads them once. A fresh install (ns.IsNewAccount) gets the welcome, and
-- the newest notes are marked seen without showing; an account from before
-- this window (no flag) has updated, so its notes are due. At login they
-- open while the flag differs from the newest notes' version; opening sets
-- it, so a /reload or a logout with it still up does not bring it back.
--
-- It opens a few seconds after login, never in combat, during a cinematic,
-- in an instance or battleground, over the route choice, or while the
-- welcome is up or due: it waits for each to end (WELCOME_CLOSED,
-- PLAYER_REGEN_ENABLED, CINEMATIC_STOP, PLAYER_ENTERING_WORLD, the route
-- choice's close). /polestar whatsnew (SHOW_WHATSNEW) and About open it
-- again at any time out of combat.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local max = math.max

local WN = {}
UI.WhatsNew = WN

local function cmd(text)
	return "|c" .. Theme.Hex("text") .. text .. "|r"
end

-- The releases' notes, newest first. Each note: its glyph and colour, its
-- heading and its line (a function, so the commands it names take the
-- theme's colours when shown).
local NOTES = {
	{
		version = "0.3.6",
		notes = {
			{ glyph = "guides", color = "accent", head = L["Every route reviewed"], text = function()
				return L["Every leveling guide was gone over again, and 40-60 reworked for both factions with more quests and shorter grinds. Quests new in Forever carry a small ∞ mark. If the guide you had open doesn't match where you are, open the guide list and pick the guide under %s. Your quest log carries over."]:format(cmd(L["Suggested for you"]))
			end },
			{ glyph = "qol-target", color = "accent", head = L["The arrow finds your targets"], text = function()
				return L["Grinding steps point at where the mob is found, and on a step with several camps the arrow moves on from one you've emptied. The Target button shows who it targets, the While you're here mobs included."]
			end },
			{ glyph = "layers", color = "accent", head = L["Guide menu and minimap"], text = function()
				return L["Browse folders fold away, a closed tab comes back with Reopen, the route line can be a line, dots or sparkles on the map and minimap, and a floating Polestar button can be turned on in Options."]
			end },
			{ glyph = "check", color = "success", head = L["Fixes from your reports"], text = function()
				return L["Quests asked for before the game offers them, wrong spots, dungeon pick-ups, guides opened part-way, the arrow while you're a ghost, and lots more."]
			end },
			{ glyph = "bug", color = "textMuted", head = L["Found something off?"], text = function()
				return L["Type %s right where it happens."]:format(cmd("/polestar report"))
			end },
		},
	},
}
WN.NOTES = NOTES
WN.LATEST = NOTES[1].version

local DELAY = 3 -- seconds after login: after the welcome's own delay, so a due welcome goes first
local SITE = "polestar.guide"

local F
local pending -- nil | "login" | "asked": waiting for the moment it may open
local hookedRC

local function seen()
	return ns.DB().whatsNewSeen == WN.LATEST
end

local function inCinematic()
	return (InCinematic and InCinematic()) or (IsInCinematicScene and IsInCinematicScene()) or false
end

local function welcomeBusy()
	local Wel = UI.Welcome
	return Wel and Wel.Busy and Wel.Busy() or false
end

local function routeChoiceUp()
	local RC = UI.RouteChoice
	return RC and RC.IsShown and RC.IsShown() or false
end

local function close()
	if F then F:Hide() end
end

-- The guide list on its home view: the open tabs, then "Suggested for you".
local function openGuideList()
	close()
	UI.ShowPicker()
	if UI.Picker and UI.Picker.SetView then UI.Picker.SetView("home") end
end

local function build()
	local K = UI.Welcome.Kit
	F = CreateFrame("Frame", "PolestarWhatsNew", UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(K.WIDTH)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	F:Hide()
	Theme.Skin(F, "window")
	local function drag(frame)
		frame:EnableMouse(true)
		frame:RegisterForDrag("LeftButton")
		frame:SetScript("OnDragStart", function() F:StartMoving() end)
		frame:SetScript("OnDragStop", function() F:StopMovingOrSizing() end)
	end
	drag(F)

	-- The hero: the night, the Dipper and the emblem on the right, the title
	-- on the 32 edge. It drags the window.
	local h = CreateFrame("Frame", nil, F)
	h:SetWidth(K.INNER)
	Anim.Anchor(h, "TOPLEFT", F, "TOPLEFT", 1, -1)
	if h.SetClipsChildren then h:SetClipsChildren(true) end
	drag(h)
	h.Sky = CreateFrame("Frame", nil, h)
	h.Sky:SetAllPoints(h)
	h.Night = K.night(h, h.Sky, 160, { haze = 0.8, band = 0.6, bottom = "bg" })
	K.dipper(h.Sky, 400, 52, 0.62, -8)
	K.emblem(h.Sky, 40, K.SIDE_X, K.SIDE_Y, 120, 44)
	h.Title = K.para(h.Sky, "hero", "text", K.CHERO_TEXT_W, 2)
	F.Hero = h

	-- The notes on the 32 edge.
	local p = CreateFrame("Frame", nil, F)
	p:SetWidth(K.CW)
	p:SetHeight(1)
	F.Body = p
	p.Notes = {}

	-- The ✕.
	F.Close = W.IconButton(F, "close", 28, L["Close"], close, 12)
	F.Close:SetPoint("TOPRIGHT", F, "TOPRIGHT", -12, -12)
	F.Close:SetFrameLevel(F:GetFrameLevel() + 40)

	-- The footer: the notes' site on the left, the buttons on the right.
	local foot = CreateFrame("Frame", nil, F)
	foot:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 1, 1)
	foot:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -1, 1)
	foot:SetHeight(K.FOOT_H)
	foot:SetFrameLevel(F:GetFrameLevel() + 30)
	W.Fill(foot, "footer")
	local rule = W.Divider(foot)
	rule:SetPoint("TOPLEFT", foot, "TOPLEFT", 0, 0)
	rule:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 0)
	F.Foot = foot
	F.Site = W.Text(foot, "note", "textMuted")
	F.Site:SetPoint("LEFT", foot, "LEFT", K.FOOT_PAD, 0)
	F.GotIt = W.Button(foot, L["Got it"], close, { primary = true })
	F.GotIt:SetPoint("RIGHT", foot, "RIGHT", -K.FOOT_PAD, 0)
	F.GuideList = W.Button(foot, L["Open the guide list"], openGuideList)
	F.GuideList:SetPoint("RIGHT", F.GotIt, "LEFT", -8, 0)

	if W.Rim then F.Rim = W.Rim(F) end
	F:SetScript("OnShow", function(self)
		Anim.To(self, "alpha", 0, 1, Anim.BASE, "out")
		Anim.Anchor(h, "TOPLEFT", F, "TOPLEFT", 1, -1)
		Anim.To(h, "alpha", 0, 1, Anim.BASE, "out")
		Anim.To(h, "offset", -8, 0, Anim.BASE, "out")
	end)
	ns.CloseOnEscape("PolestarWhatsNew")
	WN.frame = F
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(F, {
			initial = function(rows)
				for i, w in ipairs(rows) do if w == F.GotIt then return i end end
			end,
		})
	end
end

-- Lays the newest notes out; the window takes their height.
local function render()
	local K = UI.Welcome.Kit
	local entry = NOTES[1]
	local h, p = F.Hero, F.Body
	h.Title:SetText(L["What's new in Polestar %s"]:format(entry.version))
	K.place(h.Title, K.EDGE, 40)
	local heroH = max(112, 40 + h.Title:GetStringHeight() + 28)
	h:SetHeight(heroH)

	for _, n in pairs(p.Notes) do K.layNote(p, n, 0, false) end
	local y = 0
	for i, note in ipairs(entry.notes) do
		local n = p.Notes[i]
		if not n then
			n = K.noteRow(p, note.glyph, note.color, note.head)
			p.Notes[i] = n
		end
		n.Head:SetText(note.head)
		n.Text:SetText(note.text())
		y = K.layNote(p, n, y, true)
	end
	local bodyH = max(1, y - 10)
	p:ClearAllPoints()
	p:SetPoint("TOPLEFT", F, "TOPLEFT", 1 + K.EDGE, -(1 + heroH))
	p:SetHeight(bodyH)
	F.Site:SetText(L["Full notes: %s"]:format(SITE))
	F:SetHeight(math.ceil(1 + heroH + bodyH + K.BOTTOM + K.FOOT_H + 1))
	if F.Rim and W.LayoutRim then W.LayoutRim(F) end
end

local try -- forward

-- Wait for the route choice to close, then try again.
local function afterRouteChoice()
	local RC = UI.RouteChoice
	if not hookedRC and RC and RC.frame then
		hookedRC = true
		RC.frame:HookScript("OnHide", function() try() end)
	end
end

-- Open now, or once the fight, the cinematic, the instance, the route choice
-- or the welcome allows. A request opens anywhere out of combat.
local function open(why)
	if ns.Compat.InCombat() or inCinematic() then
		pending = pending == "asked" and "asked" or why
		return
	end
	if why == "login" then
		if ns.Compat.IsInInstance() or welcomeBusy() then
			pending = "login"
			return
		end
		if routeChoiceUp() then
			pending = "login"
			afterRouteChoice()
			return
		end
	end
	pending = nil
	ns.DB().whatsNewSeen = WN.LATEST -- shown: a reload or logout from here does not repeat it
	if not F then build() end
	render()
	F:Show()
	F:Raise()
end

function try()
	if pending == "asked" or (pending == "login" and not seen()) then open(pending) end
end

function WN.Show()
	open("asked")
end

function WN.Hide()
	pending = nil
	close()
end

function WN.IsShown()
	return F ~= nil and F:IsShown()
end

-- A fresh install marks the newest notes seen: it gets the welcome instead.
ns.OnInit(function()
	local db = ns.DB()
	if db.whatsNewSeen == nil and ns.IsNewAccount() then db.whatsNewSeen = WN.LATEST end
end)

ns.OnLogin(function()
	if seen() then return end
	pending = "login"
	if C_Timer and C_Timer.After then ns.After(DELAY, try) else try() end
end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function() try() end)
ns.RegisterEvent("CINEMATIC_STOP", function()
	if C_Timer and C_Timer.After then ns.After(1, try) else try() end
end)
-- Out of an instance or battleground.
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	if pending and C_Timer and C_Timer.After then ns.After(DELAY, try) end
end)
ns.On("WELCOME_CLOSED", function() try() end)
ns.On("SHOW_WHATSNEW", function() WN.Show() end)
Theme.OnChanged(function()
	if F and F:IsShown() then render() end
end)
