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
-- (12–16)" on it, then "Carried to later guides": the quests still in the
-- log that a later guide of the chain hands in (Engine.CarriedQuests), each
-- with that guide ("Sceptre of Light · Badlands"), so the player keeps them,
-- and the accepts the guide passed for the character's level, kept for a
-- later guide (Engine.WaitingQuests: "Moontouched Wildkin · at level 52").
-- Then "Not part of your route": the quests in the log no guide of the route
-- takes, works or hands in (RoutePlan.OffRoute, read when the window opens),
-- six at most, and "Keep or abandon them", which opens their list with an
-- Abandon button each (UI.ShowQuestRoom "offroute"); nothing is abandoned
-- without the game's own confirmation.
-- The window is the guide's summary; it holds one button in the footer, Close
-- (a finished guide) or Back to step 13 (the guide stays). The guide window
-- owns the next guide's button: its complete page, or its banner while steps
-- are open (GuideFrame's GF.EndOffer).
-- The last step done before the rest (GUIDE_STEPS_LEFT, #3517) is no end
-- yet: the same window says "2 steps left in Durotar (1–12)" and what follows
-- once they are done or skipped (the next guide, a route choice, or the
-- guide's end), with Back to step 13 (the guide's tab at its live step), no
-- next guide shown and no quest lists; it closes once the live step moves
-- on. The end itself comes later as above.
-- The header ✕ and Esc close it like the button. It fades in with a
-- small rise (Theme/Anim.lua; only the fade under ui.reduceMotion), plays
-- the quest-complete chime for an end when the game's sound is on, can be
-- dragged by its header and waits for a fight to end before it opens.
--
-- Colours are Theme tokens only (the name's shadow in shade), repainted on a
-- scheme change. Built on first use; nothing runs while it is hidden.
--
--   UI.GuideEnd.Show(info) -> shown        info: GUIDE_END's or
--                                          GUIDE_STEPS_LEFT's (Engine)
--   UI.GuideEnd.Hide(), .Later(), .IsShown(), .frame

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, format = math.floor, math.max, string.format
local ZoneArt = UI.ZoneArt

local GE = {}
UI.GuideEnd = GE

local WIDTH = 460
local PAD = 24
-- The emblem and the footer; the house look's own (Theme.House "endEmblem",
-- "dialogFoot", on the 4-point rhythm) read as the window is laid out.
local EMBLEM = 44
local EMBLEM_Y = 26 -- the emblem's top below the header's
local HEAD_BOTTOM = 24 -- under the heading's last line
local ART_H = 132
local FOOT_H = 60
local RISE = 12 -- the entrance's rise, in pixels
local CARRIED_SHOWN = 6 -- carried quests listed; the rest as "+N more"

local F -- the window
local shown -- the model on screen
local waiting -- an end to show once combat ends or the player is logged in

local function Engine() return ns.Engine end

local function inCombat()
	return InCombatLockdown and InCombatLockdown() or false
end

-- What the window says for GUIDE_END's info, or nil (no such guide).
function GE.Model(info)
	local G, E = ns.Guides, Engine()
	local g = info and info.guideId and G and G.Get(info.guideId)
	if not g then return nil end
	local m = { id = g.id, label = UI.GuideLabel(g), undone = info.undone or 0, live = info.live }
	if info.left then
		-- Its tab closed, or its live step moved on while a fight held the
		-- window back (the count is stale, as in liveMoved): nothing to say.
		local tab
		for i, t in ipairs(E and E.GetTabs and E.GetTabs() or {}) do
			if t.guideId == g.id then tab = i end
		end
		if not tab then return nil end
		local cur = E.GetGuide and E.GetGuide()
		if cur and cur.id == g.id and E.GetLiveStep and E.GetLiveStep() ~= info.live then return nil end
		m.left = info.left
		-- What follows once they are done, as the end says it.
		local choice = info.choose and E.GetRouteChoice and E.GetRouteChoice(g.id)
		m.choose = choice and #choice.options >= 2 or nil
		m.next = not m.choose and info.next and G.Get(info.next) or nil
		return m
	end
	m.complete = m.live == nil or m.undone == 0
	local choice = info.choose and E and E.GetRouteChoice and E.GetRouteChoice(g.id)
	if choice and #choice.options >= 2 then
		m.choose = true
	else
		local nextGuide = info.next and G.Get(info.next)
		if nextGuide then
			m.next = nextGuide
			m.nextLabel = UI.GuideLabel(nextGuide)
		end
	end
	m.carried = E and E.CarriedQuests and E.CarriedQuests(g.id) or {}
	m.waiting = E and E.WaitingQuests and E.WaitingQuests(g.id) or {}
	local P = ns.RoutePlan
	m.offRoute = P and P.OffRoute and P.OffRoute(g.id) or {}
	return m
end

---------------------------------------------------------------------------
-- Window
---------------------------------------------------------------------------

-- The heading, the guide in the accent (rebuilt on a theme change). When it
-- wraps and the sentence ends with the guide, the break goes before the
-- guide so its name stays on one line ("…the end of" / "Dun Morogh (1–12)").
local function paintTitle(fs)
	local m = shown
	if not m then return end
	local name = "|c" .. Theme.Hex("accent") .. m.label .. "|r"
	local pattern, count
	if m.left then
		count = m.left ~= 1 and m.left or nil
		pattern = count and L["%d steps left in %s"] or L["1 step left in %s"]
	else
		pattern = m.complete and L["You've completed %s"] or L["You've reached the end of %s"]
	end
	-- The count, then the guide (a translation may number them: %2$s, %1$d).
	local function fill(p)
		if count then return format(p, count, name) end
		return format(p, name)
	end
	fs:SetText(fill(pattern))
	if fs.GetNumLines and fs:GetNumLines() > 1 and pattern:find(" %%s$") then
		fs:SetText(fill((pattern:gsub(" %%s$", "\n%%s"))))
	end
end

local function build()
	F = CreateFrame("Frame", "PolestarGuideEnd", ns.UIParent)
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
	-- Where the player put it is where it opens (and rises to) next time.
	ns.DragWindow(head, F, { onStop = function()
		local point, _, relPoint, x, y = F:GetPoint(1)
		if point then Anim.Anchor(F, point, UIParent, relPoint, x, y) end
	end })
	F.Header = head
	F.Night, F.Haze, F.Band = W.Night(head, { width = WIDTH * 0.8, height = 120, sub = -6 })
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
	W.FrameClose(F, F.Close)

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
	F.CarriedHead = W.Text(F, "label", "text")
	F.CarriedHead:SetWidth(WIDTH - PAD * 2)
	F.CarriedHead:SetJustifyH("LEFT")
	F.Carried = W.Text(F, "note", "textDim")
	F.Carried:SetWidth(WIDTH - PAD * 2)
	F.Carried:SetJustifyH("LEFT")
	F.Carried:SetWordWrap(true)
	F.Carried:SetSpacing(3)
	F.OffHead = W.Text(F, "label", "text")
	F.OffHead:SetWidth(WIDTH - PAD * 2)
	F.OffHead:SetJustifyH("LEFT")
	F.OffHead:SetText(L["Not part of your route"])
	F.Off = W.Text(F, "note", "textDim")
	F.Off:SetWidth(WIDTH - PAD * 2)
	F.Off:SetJustifyH("LEFT")
	F.Off:SetWordWrap(true)
	F.Off:SetSpacing(3)
	F.OffLink = W.Link(F, L["Keep or abandon them"], function()
		if shown then UI.ShowQuestRoom("offroute", shown.id) end
	end, { role = "note" })
	F.OffLink.psTip = L["Each with its Abandon button, which asks in the game's own window first."]

	-- Footer: one button on the right. The window is the guide's summary; the
	-- guide window owns the next guide's button (its complete page, or its
	-- banner while steps are open: GF.EndOffer).
	local foot = CreateFrame("Frame", nil, F)
	foot:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 1, 1)
	foot:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -1, 1)
	foot:SetHeight(FOOT_H)
	W.Fill(foot, "footer")
	F.FootRule = W.Divider(foot)
	F.FootRule:SetPoint("TOPLEFT", foot, "TOPLEFT", 0, 0)
	F.FootRule:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 0)
	F.Footer = foot
	F.Later = W.Button(foot, "", function() GE.Later() end)
	F.Later:SetPoint("RIGHT", foot, "RIGHT", -PAD + 1, 0)

	F:SetScript("OnShow", function(self)
		Anim.To(self, "alpha", 0, 1, Anim.SLOW, "out")
		Anim.To(self, "offset", -RISE, 0, Anim.SLOW, "out")
	end)
	ns.CloseOnEscape("PolestarGuideEnd")
	-- A gamepad (UI/Gamepad.lua) starts on the footer's button; the window
	-- shows by itself, so it waits for the player before it takes the pad.
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(F, {
			initial = function(rows)
				for i, w in ipairs(rows) do if w == F.Later then return i end end
			end,
			back = function() GE.Later() end,
			unasked = function() return true end,
		})
	end
	if W.Rim then W.Rim(F) end
	GE.frame = F
end

-- The live step as the player counts that guide's steps (#942).
local function liveNumber(m)
	local E, g = ns.Engine, ns.Guides.Get(m.id)
	return E and E.StepNumberOf and g and (E.StepNumberOf(g, m.live)) or m.live
end

local function layout(m)
	local emblem, footH = Theme.House("endEmblem") or EMBLEM, Theme.House("dialogFoot") or FOOT_H
	F.Emblem:SetSize(emblem, emblem)
	F.Glow:SetSize(emblem * 3, emblem * 3)
	F.Footer:SetHeight(footH)
	paintTitle(F.Title)
	if m.complete or m.left then
		F.Undone:Hide()
	else
		F.Undone:SetText(m.undone == 1 and L["1 step was left undone."] or format(L["%d steps were left undone."], m.undone))
		F.Undone:Show()
	end
	local headH = EMBLEM_Y + emblem + 16 + F.Title:GetStringHeight()
	if F.Undone:IsShown() then headH = headH + 8 + F.Undone:GetStringHeight() end
	headH = floor(headH + HEAD_BOTTOM + 0.5)
	F.Header:SetHeight(headH)
	F.Band:SetTexCoord(Theme.BandCoords(WIDTH - 2, headH))

	local y = headH + PAD
	if m.left then
		F.Art:Hide()
		F.Text:SetText(m.choose and L["Do or skip what's left, and you choose where to go next."]
			or m.next and L["Do or skip what's left, and the next guide follows."]
			or L["Do or skip what's left, and the guide ends."])
		F.Text:ClearAllPoints()
		F.Text:SetPoint("TOP", F, "TOP", 0, -y)
		F.Text:Show()
		y = y + F.Text:GetStringHeight()
	elseif m.next then
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

	-- The quests a later guide hands in: keep them. Then the accepts waiting
	-- for the character's level.
	local list = {}
	for _, c in ipairs(m.carried or {}) do list[#list + 1] = c end
	for _, w in ipairs(m.waiting or {}) do list[#list + 1] = { title = format(L["%s · at level %d"], w.title, w.level) } end
	if #list > 0 then
		local G, lines = ns.Guides, {}
		for i, c in ipairs(list) do
			if i > CARRIED_SHOWN then
				lines[#lines + 1] = format(L["+%d more"], #list - CARRIED_SHOWN)
				break
			end
			local later = c.guideId and G and G.Get(c.guideId)
			lines[i] = later and format(L["%s · %s"], c.title, UI.GuideLabel(later)) or c.title
		end
		F.CarriedHead:SetText(L["Carried to later guides"])
		F.CarriedHead:ClearAllPoints()
		F.CarriedHead:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -(y + 16))
		F.CarriedHead:Show()
		F.Carried:SetText(table.concat(lines, "\n"))
		F.Carried:ClearAllPoints()
		F.Carried:SetPoint("TOPLEFT", F.CarriedHead, "BOTTOMLEFT", 0, -6)
		F.Carried:Show()
		y = y + 16 + F.CarriedHead:GetStringHeight() + 6 + F.Carried:GetStringHeight()
	else
		F.CarriedHead:Hide()
		F.Carried:Hide()
	end

	-- The quests no guide of the route uses: the player keeps or abandons them.
	local off = m.offRoute or {}
	if #off > 0 then
		local lines = {}
		for i, c in ipairs(off) do
			if i > CARRIED_SHOWN then
				lines[#lines + 1] = format(L["+%d more"], #off - CARRIED_SHOWN)
				break
			end
			lines[i] = c.title or ("#" .. c.quest)
		end
		F.OffHead:ClearAllPoints()
		F.OffHead:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -(y + 16))
		F.OffHead:Show()
		F.Off:SetText(table.concat(lines, "\n"))
		F.Off:ClearAllPoints()
		F.Off:SetPoint("TOPLEFT", F.OffHead, "BOTTOMLEFT", 0, -6)
		F.Off:Show()
		F.OffLink:ClearAllPoints()
		F.OffLink:SetPoint("TOPLEFT", F.Off, "BOTTOMLEFT", 0, -4)
		F.OffLink:Show()
		y = y + 16 + F.OffHead:GetStringHeight() + 6 + F.Off:GetStringHeight() + 4 + 20
	else
		F.OffHead:Hide()
		F.Off:Hide()
		F.OffLink:Hide()
	end

	if m.complete then
		W.SetButtonText(F.Later, L["Close"])
	else
		W.SetButtonText(F.Later, format(L["Back to step %d"], liveNumber(m)))
	end
	F:SetHeight(floor(y + PAD + footH + 0.5))
	if W.LayoutRim then W.LayoutRim(F) end
end

-- Show the end of a guide (GUIDE_END's info). -> true when the window
-- opened (or will, after combat).
function GE.Show(info)
	local m = GE.Model(info)
	if not m then
		-- One held back that has nothing to say any more.
		if waiting == info then waiting = nil end
		return false
	end
	if inCombat() or not ns.IsLoggedIn() then
		waiting = info
		return true
	end
	waiting = nil
	if not F then build() end
	-- The chime for an end, also when it follows the steps-left window.
	local chime = not m.left and not (F:IsShown() and shown and not shown.left)
	shown = m
	layout(m)
	if chime then
		local C = UI.ClassCard
		if C and C.GameSoundOn and C.GameSoundOn() then
			pcall(ns.PlaySound, (SOUNDKIT and SOUNDKIT.IG_QUEST_LIST_COMPLETE) or 878, "SFX")
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

-- The footer's button (and ✕, Esc): the guide stays; with steps left open the
-- guide window goes back to the live step.
function GE.Later()
	local m, E = shown, Engine()
	GE.Hide()
	-- Steps left: that guide's tab, at its live step.
	if m and m.left and E then
		for i, t in ipairs(E.GetTabs and E.GetTabs() or {}) do
			if t.guideId == m.id then
				if E.SelectTab then E.SelectTab(i) end
				local live = E.GetLiveStep and E.GetLiveStep()
				if live and E.GetStepIndex and E.GetStepIndex() ~= live and E.Goto then E.Goto(live) end
				return
			end
		end
		return
	end
	if not (m and m.live and E) then return end
	local g = E.GetGuide and E.GetGuide()
	if g and g.id == m.id and E.GetStepIndex and E.GetStepIndex() ~= m.live and E.Goto then E.Goto(m.live) end
end

ns.On("GUIDE_END", function(_, info) GE.Show(info) end)
ns.On("GUIDE_STEPS_LEFT", function(_, info) GE.Show(info) end)

-- Steps left: the live step moved on (one of them done or skipped), so the
-- count is stale; the window has said its piece.
local function liveMoved()
	local E = Engine()
	if not (shown and shown.left and F and F:IsShown() and E and E.GetGuide and E.GetLiveStep) then return end
	local g = E.GetGuide()
	if g and g.id == shown.id and E.GetLiveStep() ~= shown.live then GE.Hide() end
end
ns.On("STEP_CHANGED", liveMoved)
ns.On("STEP_UPDATED", liveMoved)

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
