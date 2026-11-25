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

-- A zone by its map ID in the client's language (Forever's new zones have
-- no name of Polestar's own to translate).
local function zone(id, english)
	return ns.Compat.GetMapName(id) or english
end

-- The releases' notes, newest first. Each note: its glyph and colour, its
-- heading and its line (a function, so the commands it names take the
-- theme's colours when shown), and the setting it is about when it has one
-- (`setting`, a settings key: the note opens the settings on it).
local NOTES = {
	{
		version = "0.4.3",
		notes = {
			{ glyph = "dart", color = "accent", head = L["A smarter arrow"], text = function()
				return L["Walks that follow your own trail, boats and lifts it understands, flights it remembers, enemy towns it goes round."]
			end },
			{ glyph = "guides", color = "accent", head = L["Guides named for their zones"], text = function()
				return L["Titles name the zones you quest in, in walking order. Camping 101 is in for every start-zone profession."]
			end },
			{ glyph = "icon-group", color = "accent", head = L["Escorts are your choice"], text = function()
				return L["Do it or Skip it, with how long other players' runs take and how often they fail."]
			end },
			{ glyph = "window", color = "accent", head = L["Windows your way"], text = function()
				return L["Atlas or Standard layout; Settings and Guides have their own scale; switches for chat messages and the XP line."]
			end },
			{ glyph = "key", color = "accent", head = L["Attunements"], text = function()
				return L["Every attunement and key for your faction in the guide menu, with a progress bar and %s."]:format(L["Guide me"])
			end },
			{ glyph = "icon-talk", color = "accent", head = L["Polestar in your language"], text = function()
				return L["Settings > General > Language shows Polestar in another language than the game's."]
			end },
			{ glyph = "reload", color = "accent", head = L["Fewer folders"], text = function()
				return L["Quit the game fully and start it again: Polestar is 22 folders now, not 45."]
			end },
			{ glyph = "check", color = "success", head = L["Fixes from your reports"], text = function()
				return L["Steps fixed in dozens of zones. Found something off? Type %s."]:format(cmd("/polestar report"))
			end },
		},
	},
	{
		version = "0.4.0",
		notes = {
			{ glyph = "icon-forever", color = "accent", head = L["Two new zones in your route"], text = function()
				return L["%s and %s are now part of the 1 to 60 route, for both factions."]:format(zone(2548, "Riverglades"), zone(2652, "Shen'dralas"))
			end },
			{ glyph = "guides", color = "accent", head = L["Safer, smoother routes"], text = function()
				return L["Every zone reviewed: less walking back, less grinding, fewer mobs well above your level."]
			end },
			{ glyph = "icon-dungeon", color = "accent", head = L["A dungeon instead of a grind"], text = function()
				return L["Grind steps suggest a dungeon that fits you now, with the game's own level ranges."]
			end },
			{ glyph = "icon-turnin", color = "accent", head = L["Finished quests stay found"], text = function()
				return L["Handed in where the route passes their NPC; when a guide ends, it says what carries on."]
			end },
			{ glyph = "sliders", color = "accent", head = L["A new settings window"], text = function()
				return L["Live previews, search that answers questions, Undo, and a short %s for new characters."]:format(L["Install"])
			end },
			{ glyph = "palette", color = "accent", head = L["New and rebuilt skins"], setting = "ui.skin", text = function()
				return L["Nine new skins; %s, %s, %s and %s rebuilt, arrow and all."]:format(L["WoW Forever"], L["Blizzard"], L["Classic"], L["Hearth"])
			end },
			{ glyph = "qol-target", color = "accent", head = L["A target list"], setting = "qol.targetRows", text = function()
				return L["The target button lists the step's mobs and what they drop; click one to target it."]
			end },
			{ glyph = "icon-repair", color = "accent", head = L["Small helpers"], setting = "behavior.whileHereVendors", text = function()
				return L["Sell and repair reminders before you leave town; compact mode now has tabs."]
			end },
			{ glyph = "icon-talk", color = "accent", head = L["Fully translated"], text = function()
				return L["In 9 languages, now with German and Latin American Spanish guides. Thanks, translators!"]
			end },
			{ glyph = "check", color = "success", head = L["Fixes from your reports"], text = function()
				return L["Caves, cities, flights and more. Found something off? Type %s."]:format(cmd("/polestar report"))
			end },
		},
	},
	{
		version = "0.3.7",
		notes = {
			{ glyph = "dart", color = "accent", head = L["A steadier arrow"], text = function()
				return L["Keeps up on slopes and ledges, takes the faster flight, and no turning back after you land."]
			end },
			{ glyph = "bolt", color = "accent", head = L["Smoother indoors"], text = function()
				return L["No more stutter in the Undercity, buildings and caves; less work in the background."]
			end },
			{ glyph = "reload", color = "accent", head = L["Update notice"], setting = "update.card", text = function()
				return L["At login, a card says when a newer Polestar is out and how to update."]
			end },
			{ glyph = "icon-train", color = "accent", head = L["New spells"], setting = "qol.levelUpSpells", text = function()
				return L["A level-up card lists what to train; %s updates your bars."]:format(cmd(L["Upgrade"]))
			end },
			{ glyph = "icon-accept", color = "accent", head = L["Quest helpers"], setting = "qol.questLoot", text = function()
				return L["Loot that starts a quest glows on the quest item button; timed quests count down."]
			end },
			{ glyph = "emblem", color = "accent", head = L["Hide it all"], setting = "maps.minimapButton", text = function()
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
local NOTES_WITH_SECTION = 200 -- the notes' view at most under the layout section (UI/LayoutCard.lua)
local SITE = "polestar.guide"

local F
local pending -- nil | "login" | "asked": waiting for the moment it may open
local hookedRC
local section -- the layout section is in this showing (UI/LayoutCard.lua)
local kept -- closed by one of the footer's buttons, not the ✕ or Escape

local function LC() return UI.LayoutCard end

-- Seen: the newest notes shown, and the 0.4.3 layout choice not due (LC.Due).
local function seen()
	local lc = LC()
	return ns.DB().whatsNewSeen == WN.LATEST and not (lc and lc.Due())
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

-- Got it / Keep this: what the layout section shows stays.
local function keep()
	kept = true
	close()
end

-- The guide list on its home view: the open tabs, then "Suggested for you".
local function openGuideList()
	keep()
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
		ns.DragWindow(frame, F)
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
	W.FrameClose(F, F.Close)

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
	F.GotIt = W.Button(foot, L["Got it"], keep, { primary = true })
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
	-- Closed (not hidden with the rest of Polestar): the layout section's
	-- setup goes back unless a footer button closed it (LC.End), and what
	-- waits on What's new may open.
	F:HookScript("OnHide", function(self)
		if self:IsShown() then return end
		local lc = LC()
		if section and lc then lc.End(kept) end
		section, kept = nil, nil
		ns.Fire("WHATSNEW_CLOSED")
	end)
	WN.frame = F
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(F, {
			initial = function(rows)
				for i, w in ipairs(rows) do if w == F.GotIt then return i end end
			end,
		})
	end
end

-- A note about a setting leads to it: the whole note answers the pointer
-- (the hover wash, a chevron on its heading's line) and a click opens the
-- settings on that setting's row (UI.ShowSetting), What's new closing. A
-- note with no setting stays text: no wash, no click.
local function linkNote(p, n, key)
	n.psSetting = key
	if not key then
		if n.Hit then n.Hit:Hide() end
		if n.Chevron then n.Chevron:Hide() end
		n.Link = nil
		return
	end
	if not n.Hit then
		local b = CreateFrame("Button", nil, p)
		W.Hover(b)
		b:SetScript("OnClick", function()
			local k = n.psSetting
			close()
			if k and UI.ShowSetting then UI.ShowSetting(k) end
		end)
		b:SetScript("OnEnter", function(self)
			W.Color(n.Chevron, "text")
			W.Tooltip(self, "ANCHOR_TOP", n.Head:GetText(), { L["Click to open this setting."] })
		end)
		b:SetScript("OnLeave", function(self)
			W.Color(n.Chevron, "textMuted")
			W.HideTooltip(self)
		end)
		n.Hit = b
		n.Chevron = W.Tex(p, "ARTWORK", "chevron-right", "textMuted")
		n.Chevron:SetSize(9, 9)
	end
	n.Link = n.Chevron
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

	for _, n in pairs(p.Notes) do
		K.layNote(p, n, 0, false)
		if n.Hit then n.Hit:Hide() end
	end
	local y = 0
	for i, note in ipairs(entry.notes) do
		local n = p.Notes[i]
		if not n then
			n = K.noteRow(p, note.glyph, note.color, note.head)
			p.Notes[i] = n
		end
		n.Head:SetText(note.head)
		n.Text:SetText(note.text())
		linkNote(p, n, note.setting)
		local top = y
		y = K.layNote(p, n, y, true)
		if note.setting then
			n.Hit:ClearAllPoints()
			n.Hit:SetPoint("TOPLEFT", p, "TOPLEFT", 0, -top)
			n.Hit:SetPoint("TOPRIGHT", p, "TOPRIGHT", 0, -top)
			n.Hit:SetHeight(max(1, y - top))
			n.Hit:Show()
		end
	end
	local bodyH = max(1, y - 10)
	-- The layout section (UI/LayoutCard.lua) under the notes, outside their
	-- scroll so it is always in view: the notes' view a little shorter then.
	local lc = LC()
	local S = section and lc and lc.Section(F)
	local sectionH = S and (lc.LayoutSection(K.CW) + 8) or 0
	local fixed = 1 + heroH + K.BOTTOM + K.FOOT_H + 1
	local viewH = math.min(bodyH, S and NOTES_WITH_SECTION or (MAX_H - fixed))
	local sf = F.Scroll
	sf:ClearAllPoints()
	sf:SetPoint("TOPLEFT", F, "TOPLEFT", 1 + K.EDGE, -(1 + heroH))
	sf:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -(1 + heroH))
	sf:SetHeight(viewH)
	W.SetScrollContent(sf, viewH < bodyH and y or bodyH, viewH) -- scrolled to the end, the last note keeps its margin
	W.ScrollTo(sf, 0)
	if S then
		S:ClearAllPoints()
		S:SetPoint("TOPLEFT", F, "TOPLEFT", 1 + K.EDGE, -(1 + heroH + viewH + 8))
		S:Show()
	end
	W.SetButtonText(F.GotIt, S and L["Keep this"] or L["Got it"])
	F.Site:SetText(L["Full notes: %s"]:format(SITE))
	F:SetHeight(math.ceil(fixed + viewH + sectionH))
	if F.Rim and W.LayoutRim then W.LayoutRim(F) end
end

-- Laid out again (the layout section's buttons changed their words).
function WN.Relayout()
	if F and F:IsShown() then render() end
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
	-- The layout section with Atlas installed (UI/LayoutCard.lua): its setup
	-- saved as the window opens, put back by the ✕ or Escape.
	if not F:IsShown() then
		local lc = LC()
		section, kept = lc ~= nil and lc.Offered(), nil
		if section then
			lc.Section(F)
			lc.Begin()
		end
	end
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
