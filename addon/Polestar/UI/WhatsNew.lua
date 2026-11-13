-- What's new: a window in the welcome's look (UI/Welcome.lua's building
-- blocks), 600 wide and centred, that tells a player who updated what the
-- release changed for them. One page: a compact night hero (the band, the
-- haze, the Dipper and the emblem on the right) with "What's new in
-- Polestar <version>" in Hero; the release's notes under hairlines, each a
-- glyph, a heading and its line, in a list that scrolls once it would make
-- the window taller than MAX_H; a footer with "Full notes: polestar.guide"
-- (text only) on the left, "Open the guide list" and "Got it" on the right.
--
-- NOTES holds the releases' notes, newest first: a release with something to
-- tell adds an entry, and the window shows the newest.
--
-- Per account: PolestarDB.whatsNewSeen, the version of the notes last shown.
-- The notes are about the addon, not one character, so a player with alts
-- reads them once. A fresh install (ns.IsNewAccount) gets Install, and
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
		version = "0.3.7",
		notes = {
			{ glyph = "dart", color = "accent", head = L["A steadier arrow"], text = function()
				return L["Keeps up on slopes and ledges, takes the faster flight, and no turning back after you land."]
			end },
			{ glyph = "bolt", color = "accent", head = L["Smoother indoors"], text = function()
				return L["No more stutter in the Undercity, buildings and caves; less work in the background."]
			end },
			{ glyph = "reload", color = "accent", head = L["Update notice"], text = function()
				return L["At login, a card says when a newer Polestar is out and how to update."]
			end },
			{ glyph = "icon-train", color = "accent", head = L["New spells"], text = function()
				return L["A level-up card lists what to train; %s updates your bars."]:format(cmd(L["Upgrade"]))
			end },
			{ glyph = "icon-accept", color = "accent", head = L["Quest helpers"], text = function()
				return L["Loot that starts a quest glows on the quest item button; timed quests count down."]
			end },
			{ glyph = "emblem", color = "accent", head = L["Hide it all"], text = function()
				return L["A click on the minimap button hides all of Polestar; another brings it back."]
			end },
			{ glyph = "menu", color = "accent", head = L["Browse all steps"], text = function()
				return L["Click the step number to see every step of the guide (thanks TTik3r and aalejandrofer)."]
			end },
			{ glyph = "icon-craft", color = "accent", head = L["Profession guides"], text = function()
				return L["Rebuilt on Forever's trainers, and they start where your skill is."]
			end },
			{ glyph = "icon-talk", color = "accent", head = L["Fully translated"], text = function()
				return L["All of 0.3.7 in 9 languages, with thanks to our translators."]
			end },
			{ glyph = "check", color = "success", head = L["Fixes from your reports"], text = function()
				return L["Routes, trainers, dungeons and more. Found something off? Type %s."]:format(cmd("/polestar report"))
			end },
		},
	},
	{
		version = "0.3.6",
		notes = {
			{ glyph = "guides", color = "accent", head = L["Every route reviewed"], text = function()
				return L["More quests and shorter grinds at 40-60, fewer walk-backs, no pointless travel steps."]
			end },
			{ glyph = "icon-turnin", color = "accent", head = L["Dynamic Questing saves trips"], text = function()
				return L["Hand in and pick up at NPCs on your way; auto-accept takes the next steps' quests."]
			end },
			{ glyph = "qol-target", color = "accent", head = L["The arrow finds your targets"], text = function()
				return L["Grinds go to the nearest spawns, past emptied camps; Target shows who, pings, marks."]
			end },
			{ glyph = "dart", color = "accent", head = L["Route lines your way"], text = function()
				return L["%s, %s or %s on map and minimap: set in Install or in Settings."]:format(L["Line"], L["Dots"], L["Sparkles"])
			end },
			{ glyph = "icon-forever", color = "accent", head = L["New in Forever"], text = function()
				return L["Quests only Forever has carry a small ∞ mark."]
			end },
			{ glyph = "window", color = "accent", head = L["Tabs and windows"], text = function()
				return L["Closed tabs reopen where you were; %s backing; floating button; Esc menu."]:format(L["Transparent"])
			end },
			{ glyph = "icon-dungeon", color = "accent", head = L["Groups and dungeons"], text = function()
				return L["%s in a party; Dungeons shows what fits your level, when more unlock."]:format(cmd(L["Sync to my guide"]))
			end },
			{ glyph = "icon-elite", color = "accent", head = L["Rares"], text = function()
				return L["Target and ping a rare right from its card."]
			end },
			{ glyph = "icon-talk", color = "accent", head = L["Fully translated"], text = function()
				return L["In 9 languages, with thanks to our translators."]
			end },
			{ glyph = "check", color = "success", head = L["Fixes from your reports"], text = function()
				return L["Gear spec, trainers, map spots and more. Found something off? Type %s."]:format(cmd("/polestar report"))
			end },
		},
	},
}
WN.NOTES = NOTES
WN.LATEST = NOTES[1].version

local DELAY = 3 -- seconds after login: after the welcome's own delay, so a due welcome goes first
local MAX_H = 440 -- the window's height at most (its size with five notes); more notes scroll
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
	F = CreateFrame("Frame", "PolestarWhatsNew", ns.UIParent)
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

	-- The notes on the 32 edge, in a list that scrolls when they don't fit.
	local sf = W.Scroll(F)
	F.Scroll = sf
	local p = sf.Child
	p:SetWidth(K.CW)
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
	local fixed = 1 + heroH + K.BOTTOM + K.FOOT_H + 1
	local viewH = math.min(bodyH, MAX_H - fixed)
	local sf = F.Scroll
	sf:ClearAllPoints()
	sf:SetPoint("TOPLEFT", F, "TOPLEFT", 1 + K.EDGE, -(1 + heroH))
	sf:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -(1 + heroH))
	sf:SetHeight(viewH)
	W.SetScrollContent(sf, viewH < bodyH and y or bodyH, viewH) -- scrolled to the end, the last note keeps its margin
	W.ScrollTo(sf, 0)
	F.Site:SetText(L["Full notes: %s"]:format(SITE))
	F:SetHeight(math.ceil(fixed + viewH))
	if F.Rim and W.LayoutRim then W.LayoutRim(F) end
end

local try -- forward

-- Wait for the route choice to close (not for Polestar hiding it with the
-- rest: it stays open then), then try again.
local function afterRouteChoice()
	local RC = UI.RouteChoice
	if not hookedRC and RC and RC.frame then
		hookedRC = true
		RC.frame:HookScript("OnHide", function(self) if not self:IsShown() then try() end end)
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
