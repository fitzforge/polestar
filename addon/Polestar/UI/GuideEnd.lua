-- The end of a leveling guide (PolestarGuideEnd): with behavior.guideEnd
-- "ask" (the default) the Engine does not load the next guide by itself; it
-- fires GUIDE_END once per guide per character when the guide's last step is
-- done (Core/Engine.lua, Own.noteEnd) and this window, centred on the screen,
-- says so and offers what comes next.
--
-- It wears the route choice window's chrome (UI/RouteChoice.lua): the gold
-- rim on top (W.Rim), a night header (the band, and in the house style a
-- gradient and the haze) with the Polestar emblem centred in its soft accent
-- glow and the star's bright centre (emblem-hot, as on the hub), then the
-- heading in the hero font, the guide's name and levels in the accent:
-- "You've completed Durotar (1–12)", or "You've reached the end of Durotar
-- (1–12)" over "3 steps were left undone." when the route still has open
-- steps. The body shows the next guide's zone painting (UI.ZoneArt, framed on
-- where it starts, as the guide menu's details) with "Next: The Barrens
-- (12–16)" on it. The footer holds the buttons, the primary on the right:
--   next guide     Start The Barrens (Engine.StartNext: in the same tab)
--                  Not now, or Back to step 13 (the guide stays; the guide
--                  window then offers the next guide: GuideFrame's banner)
--   route choice   Choose where to go next (the route choice window), with
--                  the same second button
--   none           Pick a guide (the guide menu), Close
-- The header ✕ and Esc close it like the second button. It fades in with a
-- small rise (Theme/Anim.lua; only the fade under ui.reduceMotion), plays
-- the quest-complete chime when the game's sound is on, can be dragged by
-- its header and waits for a fight to end before it opens.
--
-- Colours are Theme tokens only (the name's shadow in shade), repainted on a
-- scheme change. Built on first use; nothing runs while it is hidden.
--
--   UI.GuideEnd.Show(info) -> shown        info: GUIDE_END's (Engine)
--   UI.GuideEnd.Hide(), .Start(), .Later(), .IsShown(), .frame

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, format = math.floor, math.max, string.format
local ZoneArt = UI.ZoneArt

local GE = {}
UI.GuideEnd = GE

local WIDTH = 460
local PAD = 24
local EMBLEM = 44
local EMBLEM_Y = 26 -- the emblem's top below the header's
local HEAD_BOTTOM = 24 -- under the heading's last line
local ART_H = 132
local FOOT_H = 60
local RISE = 12 -- the entrance's rise, in pixels

local F -- the window
local shown -- the model on screen
local waiting -- an end to show once combat ends or the player is logged in

local function Engine() return ns.Engine end

local function inCombat()
	return InCombatLockdown and InCombatLockdown() or false
end

-- "Durotar (1–12)"
local function label(g)
	local lv = UI.LevelRange(g.minLevel, g.maxLevel)
	local title = g.title or g.id
	return lv and (title .. " (" .. lv .. ")") or title
end

-- What the window says for GUIDE_END's info, or nil (no such guide).
function GE.Model(info)
	local G, E = ns.Guides, Engine()
	local g = info and info.guideId and G and G.Get(info.guideId)
	if not g then return nil end
	local m = { id = g.id, label = label(g), undone = info.undone or 0, live = info.live }
	m.complete = m.live == nil or m.undone == 0
	local choice = info.choose and E and E.GetRouteChoice and E.GetRouteChoice(g.id)
	if choice and #choice.options >= 2 then
		m.choose = true
	else
		local nextGuide = info.next and G.Get(info.next)
		if nextGuide then
			m.next = nextGuide
			m.nextLabel = label(nextGuide)
		end
	end
	return m
end

---------------------------------------------------------------------------
-- Window
---------------------------------------------------------------------------

-- The heading, the guide in the accent (rebuilt on a theme change).
local function paintTitle(fs)
	local m = shown
	if not m then return end
	local name = "|c" .. Theme.Hex("accent") .. m.label .. "|r"
	fs:SetText(format(m.complete and L["You've completed %s"] or L["You've reached the end of %s"], name))
end

local function build()
	F = CreateFrame("Frame", "PolestarGuideEnd", UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(WIDTH)
	Anim.Anchor(F, "CENTER", UIParent, "CENTER", 0, 60)
	F:Hide()
	Theme.Skin(F, "window")

	-- Header: the night sky, the emblem in its glow, the heading.
	local head = CreateFrame("Frame", nil, F)
	head:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	head:EnableMouse(true)
	head:RegisterForDrag("LeftButton")
	head:SetScript("OnDragStart", function() F:StartMoving() end)
	head:SetScript("OnDragStop", function()
		F:StopMovingOrSizing()
		-- Where the player put it is where it opens (and rises to) next time.
		local point, _, relPoint, x, y = F:GetPoint(1)
		if point then Anim.Anchor(F, point, UIParent, relPoint, x, y) end
	end)
	F.Header = head
	F.Night = head:CreateTexture(nil, "BACKGROUND", nil, -8)
	F.Night:SetTexture(Theme.Media("white"))
	F.Night:SetAllPoints(head)
	W.Painter(F.Night, function(t)
		t:SetShown(Theme.SkinKey() == "polestar")
		local tr, tg, tb = Theme.Color("scrim")
		local br, bg, bb = Theme.Color("bg")
		if t.SetGradient and CreateColor then
			t:SetVertexColor(1, 1, 1, 1)
			t:SetGradient("VERTICAL", CreateColor(br, bg, bb, 1), CreateColor(tr, tg, tb, 1))
		else
			t:SetVertexColor(br, bg, bb, 1)
		end
	end)
	F.Band = Theme.Band(head, "BACKGROUND", -5)
	F.Band:SetAllPoints(head)
	F.HeadRule = W.Divider(head)
	F.HeadRule:SetPoint("BOTTOMLEFT", head, "BOTTOMLEFT", 0, 0)
	F.HeadRule:SetPoint("BOTTOMRIGHT", head, "BOTTOMRIGHT", 0, 0)
	F.Emblem = W.Tex(head, "ARTWORK", "emblem", "accent")
	F.Emblem:SetSize(EMBLEM, EMBLEM)
	F.Emblem:SetPoint("TOP", head, "TOP", 0, -EMBLEM_Y)
	F.Hot = W.Tex(head, "OVERLAY", "emblem-hot")
	F.Hot:SetAllPoints(F.Emblem)
	F.Hot:SetVertexColor(1, 0.93, 0.76)
	F.Glow = W.Tex(head, "BORDER", "glow")
	F.Glow:SetSize(EMBLEM * 3, EMBLEM * 3)
	F.Glow:SetPoint("CENTER", F.Emblem, "CENTER", 0, 0)
	W.Painter(F.Glow, function(t)
		local r, g, b = Theme.Accent()
		t:SetVertexColor(r, g, b, 0.3)
		t:SetShown(Theme.SkinKey() == "polestar")
	end)
	F.Title = W.Text(head, "hero", "text")
	F.Title:SetWidth(WIDTH - PAD * 2)
	F.Title:SetJustifyH("CENTER")
	F.Title:SetWordWrap(true)
	F.Title:SetSpacing(2)
	F.Title:SetPoint("TOP", F.Emblem, "BOTTOM", 0, -16)
	W.Painter(F.Title, paintTitle)
	F.Undone = W.Text(head, "note", "textDim")
	F.Undone:SetWidth(WIDTH - PAD * 2)
	F.Undone:SetJustifyH("CENTER")
	F.Undone:SetPoint("TOP", F.Title, "BOTTOM", 0, -8)
	F.Close = W.IconButton(head, "close", 28, L["Close"], function() GE.Later() end, 14)
	F.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -12)

	-- Body: the next guide's zone painting (a dark hairline round it) with
	-- its name and levels over the fade, or a line saying what to do.
	F.Art = ZoneArt.Create(F, WIDTH - PAD * 2, ART_H, "panel")
	F.Art.psZoom = 1.5
	F.Art.Rule:Hide()
	F.Edge = {}
	for k = 1, 4 do F.Edge[k] = F.Art.Over:CreateTexture(nil, "OVERLAY") end
	F.Edge[1]:SetPoint("TOPLEFT", F.Art, "TOPLEFT", 0, 0)
	F.Edge[1]:SetPoint("TOPRIGHT", F.Art, "TOPRIGHT", 0, 0)
	F.Edge[2]:SetPoint("BOTTOMLEFT", F.Art, "BOTTOMLEFT", 0, 0)
	F.Edge[2]:SetPoint("BOTTOMRIGHT", F.Art, "BOTTOMRIGHT", 0, 0)
	F.Edge[3]:SetPoint("TOPLEFT", F.Art, "TOPLEFT", 0, 0)
	F.Edge[3]:SetPoint("BOTTOMLEFT", F.Art, "BOTTOMLEFT", 0, 0)
	F.Edge[4]:SetPoint("TOPRIGHT", F.Art, "TOPRIGHT", 0, 0)
	F.Edge[4]:SetPoint("BOTTOMRIGHT", F.Art, "BOTTOMRIGHT", 0, 0)
	W.Painter(F.Art, function(a)
		local r, g, b = Theme.Color("shade")
		local px = Theme.Pixel(a)
		for k = 1, 4 do
			local t = F.Edge[k]
			t:SetTexture(Theme.Media("white"))
			t:SetVertexColor(r, g, b, 0.6)
			if k <= 2 then t:SetHeight(px) else t:SetWidth(px) end
		end
	end)
	F.Next = W.Text(F.Art.Over, "display", "text")
	F.Next:SetPoint("BOTTOMLEFT", F.Art, "BOTTOMLEFT", 16, 12)
	F.Next:SetWidth(WIDTH - PAD * 2 - 32)
	F.Next:SetJustifyH("LEFT")
	W.Painter(F.Next, function(fs)
		local r, g, b = Theme.Color("shade")
		fs:SetShadowOffset(0, -1)
		fs:SetShadowColor(r, g, b, 0.85)
	end)
	F.Text = W.Text(F, "body", "textDim")
	F.Text:SetWidth(WIDTH - PAD * 2)
	F.Text:SetJustifyH("CENTER")
	F.Text:SetWordWrap(true)

	-- Footer: the second button, then the primary on the right.
	local foot = CreateFrame("Frame", nil, F)
	foot:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 1, 1)
	foot:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -1, 1)
	foot:SetHeight(FOOT_H)
	W.Fill(foot, "footer")
	F.FootRule = W.Divider(foot)
	F.FootRule:SetPoint("TOPLEFT", foot, "TOPLEFT", 0, 0)
	F.FootRule:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 0)
	F.Footer = foot
	F.Go = W.Button(foot, "", function() GE.Start() end, { primary = true })
	F.Go:SetPoint("RIGHT", foot, "RIGHT", -PAD + 1, 0)
	F.Later = W.Button(foot, "", function() GE.Later() end, { ghost = true })
	F.Later:SetPoint("RIGHT", F.Go, "LEFT", -8, 0)

	F:SetScript("OnShow", function(self)
		Anim.To(self, "alpha", 0, 1, Anim.SLOW, "out")
		Anim.To(self, "offset", -RISE, 0, Anim.SLOW, "out")
	end)
	ns.CloseOnEscape("PolestarGuideEnd")
	-- A gamepad (UI/Gamepad.lua) starts on the primary button; the window
	-- shows by itself, so it waits for the player before it takes the pad.
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(F, {
			initial = function(rows)
				for i, w in ipairs(rows) do if w == F.Go then return i end end
			end,
			back = function() GE.Later() end,
			unasked = function() return true end,
		})
	end
	if W.Rim then W.Rim(F) end
	GE.frame = F
end

local function layout(m)
	paintTitle(F.Title)
	if m.complete then
		F.Undone:Hide()
	else
		F.Undone:SetText(m.undone == 1 and L["1 step was left undone."] or format(L["%d steps were left undone."], m.undone))
		F.Undone:Show()
	end
	local headH = EMBLEM_Y + EMBLEM + 16 + F.Title:GetStringHeight()
	if F.Undone:IsShown() then headH = headH + 8 + F.Undone:GetStringHeight() end
	headH = floor(headH + HEAD_BOTTOM + 0.5)
	F.Header:SetHeight(headH)
	F.Band:SetTexCoord(Theme.BandCoords(WIDTH - 2, headH))

	local y = headH + PAD
	if m.next then
		local fx, fy
		local E = Engine()
		if E and E.GuideFocus then fx, fy = E.GuideFocus(m.next.id) end
		F.psArt = ZoneArt.Paint(F.Art, m.next.zone, fx, fy, 1)
		F.Next:SetText(format(L["Next: %s"], m.nextLabel))
		F.Art:ClearAllPoints()
		F.Art:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -y)
		F.Art:Show()
		F.Text:Hide()
		y = y + ART_H
	else
		F.Art:Hide()
		F.Text:SetText(m.choose and L["Pick where you want to level next."] or L["Nice work. Pick your next guide to keep going."])
		F.Text:ClearAllPoints()
		F.Text:SetPoint("TOP", F, "TOP", 0, -y)
		F.Text:Show()
		y = y + F.Text:GetStringHeight()
	end

	if m.choose then
		W.SetButtonText(F.Go, L["Choose where to go next"])
	elseif m.next then
		W.SetButtonText(F.Go, format(L["Start %s"], m.next.title or m.next.id))
	else
		W.SetButtonText(F.Go, L["Pick a guide"])
	end
	if not (m.next or m.choose) then
		W.SetButtonText(F.Later, L["Close"])
	elseif m.complete then
		W.SetButtonText(F.Later, L["Not now"])
	else
		W.SetButtonText(F.Later, format(L["Back to step %d"], m.live))
	end
	F:SetHeight(floor(y + PAD + FOOT_H + 0.5))
	if W.LayoutRim then W.LayoutRim(F) end
end

-- Show the end of a guide (GUIDE_END's info). -> true when the window
-- opened (or will, after combat).
function GE.Show(info)
	local m = GE.Model(info)
	if not m then return false end
	if inCombat() or not ns.IsLoggedIn() then
		waiting = info
		return true
	end
	waiting = nil
	if not F then build() end
	shown = m
	layout(m)
	if not F:IsShown() then
		local C = UI.ClassCard
		if C and C.GameSoundOn and C.GameSoundOn() and PlaySound then
			pcall(PlaySound, (SOUNDKIT and SOUNDKIT.IG_QUEST_LIST_COMPLETE) or 878, "SFX")
		end
	end
	F:Show()
	F:Raise()
	return true
end

function GE.Hide()
	waiting = nil
	shown = nil
	if F then F:Hide() end
end

function GE.IsShown()
	return F ~= nil and F:IsShown()
end

-- The primary button: start the next guide in the guide's tab, open the
-- route choice, or the guide menu.
function GE.Start()
	local m, E = shown, Engine()
	if not m then return end
	GE.Hide()
	if m.choose then
		UI.ShowRouteChoice(m.id)
	elseif m.next then
		if E and E.StartNext then E.StartNext(m.id) end
	else
		UI.ShowPicker()
	end
	ns.Set("ui.shown", true)
end

-- The second button (and ✕, Esc): the guide stays; with steps left open the
-- guide window goes back to the live step.
function GE.Later()
	local m, E = shown, Engine()
	GE.Hide()
	if not (m and m.live and E) then return end
	local g = E.GetGuide and E.GetGuide()
	if g and g.id == m.id and E.GetStepIndex and E.GetStepIndex() ~= m.live and E.Goto then E.Goto(m.live) end
end

ns.On("GUIDE_END", function(_, info) GE.Show(info) end)

-- The next guide was loaded some other way: nothing left to ask.
ns.On("GUIDE_CHANGED", function()
	local E = Engine()
	if shown and F and F:IsShown() and E and E.GetTabs then
		for _, t in ipairs(E.GetTabs() or {}) do
			if t.guideId == shown.id then return end
		end
		GE.Hide()
	end
end)

ns.OnLogin(function()
	if waiting then GE.Show(waiting) end
end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if waiting then GE.Show(waiting) end
end)
