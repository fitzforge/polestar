-- Install: a Polestar window, 600 wide and centred, that sets Polestar up
-- for a character it has not seen before, a page at a time. It grew out of
-- the welcome, whose names the code and the saved flags keep (this file,
-- UI.Welcome, the frame PolestarWelcome, SHOW_WELCOME, welcomeSeen). Each
-- page opens under its own hero (the night sky: a gradient, the faint haze,
-- the starlit band); the page below on the 32 edge; a footer with Skip
-- install (Back on the last page) on the left, "Step 2 of 6" over the step
-- dots in the middle (not buttons), and Back and Next on the right (Start
-- guide and Finish on the last page). The gold rim (W.Rim) runs along the
-- window's top. Each choice writes its real setting the moment it is made
-- and shows it where it can (the window re-skins, the previews redraw), so
-- nothing waits for the last page and nothing needs a reload; Skip install
-- (the ✕, Escape) leaves every setting as it is. Each choice page ends on
-- "Skip install keeps these as they are."
--   1. welcome: a 208px hero with the start zone's painting engraved faintly
--      into the night, the Little Dipper leading to the emblem in its glow
--      and beam, the wordmark and tagline centred under it; Hello, <name>,
--      one line on what Polestar does, then three cards, each a miniature
--      of the real thing: a goal row of the suggested guide with its accent
--      bar and progress line (the guide window), the gold dart with the
--      guide's first walk (the arrow), the library's Leveling, Professions
--      and Reputation rows with their counts (every guide); a line on what
--      the next pages do;
--   2. questing: quest automation (behavior.autoAccept and autoTurnin as one
--      switch), grey quests (behavior.skipGrey) and the guide at login
--      (behavior.autoSelectGuide), each with its description inline; then
--      the stat weights the gear advice scores rewards with
--      (gear.spec.<CLASS>: Automatic or one of the class's specs) as option
--      cards, while Gear knows the class;
--   3. targeting (with QoL loaded): the target button (qol.targetButton)
--      and its target list, a preview of the list (Buttons.NewListFaces) or,
--      with Simple target button, of the single button's face and name plate
--      (Buttons.NewFace) over the switches for it, the single button
--      (qol.targetSimple, its child) and who it targets (qol.targetPlate, the
--      single button's), its mark and its ping (qol.markTarget,
--      qol.pingTarget), and a line that the step key targets the same without
--      it and Move frames moves it;
--   4. groups: dungeons in the route (behavior.dungeons: Skip them, Ask me,
--      Run them; once that setting exists and the character's guides have
--      dungeons) and group quests (behavior.groupQuests: Ask me at each, Do
--      them with a group, Skip them; while the guides have any) as option
--      cards;
--   5. route: the polestar.guide front page's route demo (Elwynn Forest,
--      Northshire Abbey to the Westfall bridge): the chosen style's walk
--      as the site draws it, redrawn when the style changes, the last one
--      left as a faint dashed ghost; then the route style (nav.routeStyle,
--      the setting Options' Route style dropdown writes) as three rows,
--      Fastest, Balanced (Recommended) and Roads, each saying what it does;
--      then the route line's look (nav.lineStyle: Line, Dots, Sparkles) as
--      cards each previewing it;
--   6. look: the looks (ui.skin, Theme.SkinChoices) as a list beside a large
--      preview of the one under the pointer or the gamepad's focus, else the
--      one in use, drawn by the settings' skin picker (Theme.DrawSkinCard:
--      Polestar_Options, and the skin addons, load when the page first
--      shows; without them the window itself is the preview); the colour
--      scheme (ui.scheme) as preview cards in each scheme's own colours
--      while the house look is on (not a skin that brings its own grounds);
--      the gamepad's button names (gamepad.glyphs) while a gamepad is in use;
--   7. finish: the guide on its painting (its level range, who it is for),
--      its pitch; You're all set; what Start guide does, or that the guide
--      is open; where to change it all later (Settings and its search,
--      /polestar install); the beta note while ns.routesBeta is true; the
--      Recorder, pointed to and never switched on; the Discord community
--      (its invite as a link to the copy window); community guides (Browse
--      guides opens the guide menu). Finish closes it; Start guide (Choose a
--      guide without one), shown while that guide is not the one open, opens
--      it and closes the window.
--
-- Per character: PolestarCharDB.welcomeSeen, Install's version (SEEN).
-- A new character (ns.IsNewCharacter: no saved PolestarCharDB when Polestar
-- loaded) gets 0, so Install is due; a character with saved data and no
-- flag gets SEEN without seeing it, so nobody who already plays gets it
-- unasked. At login it opens while the character's flag is below SEEN, and
-- opening it sets the flag, so a /reload or a logout with it still up does
-- not bring it back; a due Install that never opened (a logout in combat or
-- under the route choice) stays due for the next login.
--
-- Per account: PolestarDB.welcomeSeen, the account has had its Install. The
-- settings are the account's (the profile in use), so a later character
-- shown it at login gets the welcome, the choices that are its own (the
-- stat weights, kept per class) and the last page. The page set is fixed
-- when a showing starts. Any close (Skip install, Finish, Start guide,
-- Browse guides, the ✕, Escape) sets both flags. The beta notice's old flag
-- (betaNoticeSeen) is dropped.
--
-- It opens a moment after login, never in combat (it waits for the fight to
-- end, and a fight that starts with it up sends it aside until the fight is
-- over), never during a cinematic, and never over the route choice: while
-- that window is up it waits for it to close, and if a route choice opens
-- over it, it steps aside until that is done; each time it comes back on
-- the page it left. A new character's first login plays the intro
-- cinematic, whose start closes every special window (CloseAllWindows) and
-- hides the UI: an Install closed that way is not marked seen and comes
-- back on the page it left once the cinematic stops. /polestar install (and
-- /polestar welcome), About's Install, the settings window's Install button
-- and its search (SHOW_WELCOME) open it with every page.
--
-- Keys: Enter takes the footer's main button (Next, Finish on the last
-- page), Backspace goes back; every other key goes on to the game, Escape
-- among them (the game's close of special windows closes it). The gamepad
-- turns the pages with LB / RB and starts on Next (UI/Gamepad.lua).
--
-- The window takes the height of its tallest page, laid out in the current
-- language, font and look, so it never jumps; a shorter page's body sits in
-- the middle of the room under its hero. Taller than the screen (a large UI
-- scale, a long translation), it scales itself down to fit. Motion: the
-- window fades in and the hero settles 8px up as it fades in (180ms); a page
-- change fades the old page out (120ms) and the new one in, rising 6px
-- (180ms). Reduced motion (Anim) snaps the movement. The night's extras
-- (gradient, haze, engraving, beam) are the house style's; the other skins
-- keep the band. Built on first use; colours are Theme tokens only.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, min, sqrt, cos, sin, rad = math.floor, math.max, math.min, math.sqrt, math.cos, math.sin, math.rad
local atan2 = math.atan2 or math.atan

local WEL = {}
UI.Welcome = WEL

local SEEN = 1 -- Install's version (the welcome's, kept so no one who saw it gets it again); a later one raises it
local WIDTH = 600
local PAD = 32
local CW = WIDTH - PAD * 2 -- the page's width
local INNER = WIDTH - 2 -- inside the window's 1px edge
local EDGE = PAD - 1 -- the 32 edge, in hero coordinates
local HELLO_H = 208 -- the first page's hero
local START_H = 184 -- the last page's hero
local BAND_H = 128 -- the band at 1:1
local BAND_SHIFT = 180 / 1024 -- the stretch of the band the heroes show
local BOTTOM = 24 -- under a page's last line
local FOOT_H = 56
local FOOT_PAD = 24
local DELAY = 2 -- seconds after login, so the world and the other windows settle first
local OUT = 0.11 -- a page leaving fades this long
local MARGIN = 24 -- kept free round the window when it scales itself down to fit the screen

local F -- the window
local current = "welcome" -- the page shown (its key)
local pending -- nil | "login" (due at login) | "asked" (opened on request, or coming back), waiting for combat or the route choice
local stepping -- hidden to make way for the route choice or a fight, not closed
local full = true -- this showing has every page (false: a later character's, its own choices alone); fixed when it starts
local unasked = false -- this showing came by itself (open's deferred): a gamepad waits to be asked
local hookedRC

local function inCombat()
	return InCombatLockdown and InCombatLockdown() or false
end

-- The intro cinematic or a cinematic scene is playing.
local function inCinematic()
	return (InCinematic and InCinematic()) or (IsInCinematicScene and IsInCinematicScene()) or false
end

-- This character has had its Install.
local function seen()
	return (tonumber(ns.CharState().welcomeSeen) or 0) >= SEEN
end

-- This account has had its Install.
local function accountSeen()
	return (tonumber(ns.DB().welcomeSeen) or 0) >= SEEN
end

local function routeChoiceUp()
	local RC = UI.RouteChoice
	return RC and RC.IsShown and RC.IsShown() or false
end

-- The house style draws the night's extras; the other skins keep the band.
local function house()
	return Theme.SkinKey() == "polestar"
end

local function colored(name, text)
	return "|c" .. Theme.Hex(name) .. text .. "|r"
end

local function cmd(text)
	return colored("text", text)
end

local function known(s)
	return type(s) == "string" and s ~= "" and s or nil
end

-- A wrapped block of text, `width` wide.
local function para(parent, role, color, width, spacing)
	local fs = W.Text(parent, role, color)
	fs:SetWidth(width)
	fs:SetWordWrap(true)
	fs:SetSpacing(spacing or 3)
	fs:SetJustifyH("LEFT")
	fs:SetJustifyV("TOP")
	return fs
end

local function place(region, x, y)
	region:ClearAllPoints()
	region:SetPoint("TOPLEFT", region:GetParent(), "TOPLEFT", x, -y)
end

local function solid(parent, layer, sub)
	local t = parent:CreateTexture(nil, layer or "BACKGROUND", nil, sub or 0)
	t:SetTexture(Theme.Media("white"))
	return t
end

-- A vertical gradient, top colour then bottom colour.
local function vgrad(t, r1, g1, b1, a1, r2, g2, b2, a2)
	if t.SetGradient and CreateColor then
		t:SetVertexColor(1, 1, 1, 1)
		t:SetGradient("VERTICAL", CreateColor(r2, g2, b2, a2), CreateColor(r1, g1, b1, a1))
	else
		t:SetVertexColor(r1, g1, b1, (a1 + a2) / 2)
	end
end

-- A horizontal gradient, left colour then right colour.
local function hgrad(t, r1, g1, b1, a1, r2, g2, b2, a2)
	if W.Gradient then return W.Gradient(t, r1, g1, b1, a1, r2, g2, b2, a2) end
	if t.SetGradient and CreateColor then
		t:SetVertexColor(1, 1, 1, 1)
		t:SetGradient("HORIZONTAL", CreateColor(r1, g1, b1, a1), CreateColor(r2, g2, b2, a2))
	else
		t:SetVertexColor(r2, g2, b2, (a1 + a2) / 2)
	end
end

local function accentHi()
	if W.AccentHi then return W.AccentHi() end
	return Theme.Accent()
end

-- A frame's 1px outline in a wash (or the accent while `on`).
local function outline(c)
	c.psEdge = {}
	for i, pts in ipairs({ { "TOPLEFT", "TOPRIGHT" }, { "BOTTOMLEFT", "BOTTOMRIGHT" }, { "TOPLEFT", "BOTTOMLEFT" }, { "TOPRIGHT", "BOTTOMRIGHT" } }) do
		local e = solid(c, "BORDER", 2)
		e:SetPoint(pts[1], c, pts[1], 0, 0)
		e:SetPoint(pts[2], c, pts[2], 0, 0)
		c.psEdge[i] = e
	end
end

local function paintOutline(c, r, g, b, a)
	local px = Theme.Pixel(c)
	for i = 1, 4 do
		local e = c.psEdge[i]
		if i <= 2 then e:SetHeight(px) else e:SetWidth(px) end
		e:SetVertexColor(r, g, b, a)
	end
end

-- A line from (ax, ay) to (bx, by) in `parent`'s top-left coordinates.
local function segment(t, parent, ax, ay, bx, by, thick)
	local dx, dy = bx - ax, by - ay
	t:SetTexCoord(0, 1, 0, 1) -- drawn as an image, so it turns
	t:SetSize(max(1, sqrt(dx * dx + dy * dy)), thick)
	t:ClearAllPoints()
	t:SetPoint("CENTER", parent, "TOPLEFT", (ax + bx) / 2, -(ay + by) / 2)
	t:SetRotation(-atan2(dy, dx))
end

-- A footer button's chevron after its label (Next, Start guide).
local function chevron(b)
	local c = b:CreateTexture(nil, "ARTWORK")
	c:SetTexture(Theme.Media("chevron-right"))
	c:SetSize(11, 11)
	b.psChevron = c
	W.Painter(c, function(t)
		if b.Label.GetTextColor then t:SetVertexColor(b.Label:GetTextColor()) end
	end)
end

local function setChevronText(b, text)
	W.SetButtonText(b, text)
	b:SetWidth(b:GetWidth() + 16)
	b.psLabelX = -8
	b.Label:SetPoint("CENTER", b, "CENTER", -8, 0)
	b.psChevron:ClearAllPoints()
	b.psChevron:SetPoint("LEFT", b.Label, "RIGHT", 5, 0)
	if b.Label.GetTextColor then b.psChevron:SetVertexColor(b.Label:GetTextColor()) end
end

local function close()
	if F then F:Hide() end
end

---------------------------------------------------------------------------
-- The night: gradient, haze, band; the emblem; the Little Dipper
---------------------------------------------------------------------------

-- The night ground of a hero `height` tall: the gradient (house style), the
-- haze and the starlit band. opts: { haze = alpha, band = alpha, bottom =
-- the palette colour the gradient ends in }. Textures on `h` (under every
-- child frame) and on `sky` (above the painting, if any).
local function night(h, sky, height, opts)
	local n = {}
	n.Ground = solid(h, "BACKGROUND", -8)
	n.Ground:SetAllPoints(h)
	n.Band = Theme.Band(sky, "BACKGROUND", -5)
	n.Band:SetPoint("TOPLEFT", sky, "TOPLEFT", 0, 0)
	n.Band:SetPoint("TOPRIGHT", sky, "TOPRIGHT", 0, 0)
	n.Band:SetHeight(min(BAND_H, height))
	local x0, x1, y0, y1 = Theme.BandCoords(INNER, min(BAND_H, height))
	n.Band:SetTexCoord(x0 + BAND_SHIFT, x1 + BAND_SHIFT, y0, y1)
	n.Band:SetAlpha(opts.band or 0.7)
	if W.Haze then
		n.Haze = W.Haze(sky, { width = floor(INNER * 1.2), height = floor(height * 0.75), sub = -6 })
		n.Haze:SetAlpha(opts.haze or 1)
	end
	W.Painter(n.Ground, function(t)
		t:SetShown(house())
		local tr, tg, tb = Theme.Color("scrim")
		local br, bg, bb = Theme.Color(opts.bottom or "bg")
		vgrad(t, tr, tg, tb, 1, br, bg, bb, 1)
	end)
	return n
end

-- The emblem, `size` px, centred on (x, y) of `parent`, in its glow, a
-- 1px beam rising from it (house style). bloom: the glow's size.
local function emblem(parent, size, x, y, bloom, beamH)
	local e = W.Tex(parent, "ARTWORK", "emblem", "accent")
	e:SetSize(size, size)
	e:SetPoint("CENTER", parent, "TOPLEFT", x, -y)
	local glow = W.Tex(parent, "BORDER", "glow", nil, 3)
	glow:SetSize(bloom, bloom)
	glow:SetPoint("CENTER", e, "CENTER", 0, 0)
	local beam = solid(parent, "BORDER", 4)
	beam:SetSize(1, beamH)
	beam:SetPoint("BOTTOM", e, "TOP", 0, -4)
	W.Painter(glow, function(t)
		local r, g, b = Theme.Accent()
		t:SetVertexColor(r, g, b, house() and 0.3 or 0.12)
		local hr, hg, hb = accentHi()
		beam:SetShown(house())
		vgrad(beam, r, g, b, 0, hr, hg, hb, 0.7)
	end)
	return e
end

-- The Little Dipper as the mock draws it, in px from the end of its handle
-- (x right, y down): { x, y, radius }. The handle's end has no star of its
-- own (Polaris: the emblem beside it, or the sky).
local DIPPER = {
	{ 0, 0, 0 }, { 62, -24, 1.6 }, { 114, -34, 1.5 }, { 162, -27, 1.5 },
	{ 236, -52, 2.2 }, { 262, -10, 1.9 }, { 196, 13, 1.3 },
}
local LINKS = { { 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 5 }, { 5, 6 }, { 6, 7 }, { 7, 4 } }

-- Draws the Dipper on `parent`, its handle's end at (ox, oy), scaled and
-- turned `deg` degrees clockwise, in the neutral star colour.
local function dipper(parent, ox, oy, scale, deg)
	local a = rad(deg or 0)
	local c, s = cos(a), sin(a)
	local pts = {}
	for i, st in ipairs(DIPPER) do
		local x, y = st[1], st[2]
		pts[i] = { ox + (x * c - y * s) * scale, oy + (x * s + y * c) * scale }
		if st[3] > 0 then
			local halo = W.Tex(parent, "BORDER", "glow", nil, 1)
			halo:SetSize(st[3] * 6, st[3] * 6)
			halo:SetPoint("CENTER", parent, "TOPLEFT", pts[i][1], -pts[i][2])
			local core = W.Tex(parent, "BORDER", "circle", nil, 2)
			core:SetSize(max(2, st[3] * 2), max(2, st[3] * 2))
			core:SetPoint("CENTER", halo, "CENTER", 0, 0)
			W.Painter(halo, function(t)
				local r, g, b = Theme.Color("star")
				t:SetVertexColor(r, g, b, 0.3)
				core:SetVertexColor(r, g, b, 1)
			end)
		end
	end
	for _, link in ipairs(LINKS) do
		local p, q = pts[link[1]], pts[link[2]]
		local t = solid(parent, "BORDER", 0)
		segment(t, parent, p[1], p[2], q[1], q[2], 1)
		W.Painter(t, function(tex)
			tex:SetHeight(Theme.Pixel(parent))
			local r, g, b = Theme.Color("star")
			tex:SetVertexColor(r, g, b, 0.28)
		end)
	end
end

---------------------------------------------------------------------------
-- What the pages show of the suggested guide
---------------------------------------------------------------------------

-- The player as Polestar reads them; a field is nil when the client cannot say.
local function playerInfo()
	local C = ns.Compat
	local ok, info = pcall(C.GetPlayerInfo)
	return ok and type(info) == "table" and info or {}
end

-- The guide Polestar suggests, or nil.
local function suggested()
	local G = ns.Guides
	local id = G and G.Suggest and G.Suggest()
	local g = id and G.Get and G.Get(id)
	if g and known(g.title) then return id, g end
	return nil
end

-- A name a guide gives (its tokens filled), or nil.
local function nameOf(...)
	for i = 1, select("#", ...) do
		local s = known((select(i, ...)))
		if s and not s:find("{", 1, true) then return s end
	end
	return nil
end

-- A goal's place on the guide's zone map (live-frame percent, as the
-- Engine's GuideFocus reads it), or nil: elsewhere, or for some only.
local function zonePoint(g, goal)
	if goal.only or not (g.zone and goal.map == g.zone and goal.x and goal.y) then return nil end
	local x, y = goal.x, goal.y
	local C = ns.Compat
	if goal.f and C.MapToWorld and C.WorldToMap then
		local c, wx, wy = C.MapToWorld(goal.map, goal.x, goal.y, goal.f)
		if c then x, y = C.WorldToMap(c, wx, wy, goal.map) end
	end
	if x and y then return x, y end
	return nil
end

local WALK_MIN = 12 -- a walk is at least this far (percent of the map)
local SCAN = 40 -- steps read from the guide's start

-- The guide's first walk: the first stretch between two of its places on
-- its zone map at least WALK_MIN apart, ending at a named place.
-- -> { x0, y0, x1, y1, name } | nil (cached per guide)
local walks = setmetatable({}, { __mode = "k" })
local function firstWalk(g)
	local w = walks[g]
	if w == nil then
		w = false
		local ok, found = pcall(function()
			local lx, ly
			for si, step in ipairs(g.steps or {}) do
				if si > SCAN then break end
				if not step.only then
					for _, goal in ipairs(step.goals or {}) do
						local x, y = zonePoint(g, goal)
						if x then
							local name = goal.t == "goto" and nameOf(goal.text, goal.subject)
							if lx and name and (x - lx) ^ 2 + (y - ly) ^ 2 >= WALK_MIN ^ 2 then
								return { lx, ly, x, y, name }
							end
							lx, ly = x, y
						end
					end
				end
			end
		end)
		if ok and found then w = found end
		walks[g] = w
	end
	return w or nil
end

-- A goal of the guide to show as a goal row: a collect or a kill with a
-- count. -> kind, name, count | nil
local function sampleGoal(g)
	for si, step in ipairs(g and g.steps or {}) do
		if si > SCAN then break end
		for _, goal in ipairs(step.goals or {}) do
			if (goal.t == "collect" or goal.t == "kill") and not goal.only then
				-- In the client's language where Polestar.Names has it.
				local N = ns.Names
				local name = nameOf(N and N.Item(goal.item), goal.itemName, N and N.Npc(goal.npc), goal.target, goal.subject)
				local n = tonumber(goal.count) or (type(goal.progress) == "table" and tonumber(goal.progress.max))
				if name and n and n > 1 then return goal.t, name, n end
			end
		end
	end
	return nil
end

-- The library's guides of a category.
local function countOf(category)
	local G = ns.Guides
	local list = G and G.List and G.List() or {}
	local n = 0
	for _, h in ipairs(list) do if h.category == category then n = n + 1 end end
	return n
end

-- "Your first guide, for your level 1 Human Warrior in Elwynn Forest",
-- leaving out what is unknown.
local function forWhom(g)
	local info = playerInfo()
	local race, class = known(UI.RaceName(info.race)), known(UI.ClassName(info.class))
	local level = tonumber(info.level)
	local who
	if race or class then
		who = race and class and (race .. " " .. class) or race or class
		if level then who = (L["level %d %s"]):format(level, who) end
	elseif level then
		who = (L["level %d character"]):format(level)
	end
	local zone = known((ns.Compat.GetZoneText()))
	-- A guide named for the zone already says where.
	if zone and g.title:lower():find(zone:lower(), 1, true) then zone = nil end
	if who and zone then return (L["Your first guide, for your %s in %s"]):format(who, zone) end
	if who then return (L["Your first guide, for your %s"]):format(who) end
	if zone then return (L["Your first guide, in %s"]):format(zone) end
	return L["Your first guide"]
end

---------------------------------------------------------------------------
-- Pages: build(P) once; layout(P) -> the hero's height, the page's height,
-- on every show. P.Hero is the hero, P.Body the page under it.
---------------------------------------------------------------------------

local PAGES = {}
local pageList -- forward: the pages shown now (the welcome page counts what follows it)

-- The compact hero (the choice pages): the night, the emblem on the right, the
-- title and its line on the 32 edge.
local SIDE_X, SIDE_Y = INNER - 64 - 20, 64
local CHERO_TEXT_W = 440

local function compactHero(h, title, sub, withDipper)
	h.Sky = CreateFrame("Frame", nil, h)
	h.Sky:SetAllPoints(h)
	h.Night = night(h, h.Sky, 160, { haze = 0.8, band = 0.6, bottom = "bg" })
	if withDipper then dipper(h.Sky, 400, 52, 0.62, -8) end
	emblem(h.Sky, 40, SIDE_X, SIDE_Y, 120, 44)
	h.Title = para(h.Sky, "hero", "text", CHERO_TEXT_W, 2)
	h.Title:SetText(title)
	h.Sub = para(h.Sky, "body", "textDim", CHERO_TEXT_W, 3)
	h.Sub:SetText(sub)
end

local function layoutCompactHero(h)
	place(h.Title, EDGE, 40)
	local y = 40 + h.Title:GetStringHeight() + 8
	place(h.Sub, EDGE, y)
	return y + h.Sub:GetStringHeight() + 22
end

-- 1. Welcome --------------------------------------------------------------

local CARD_GAP = 16
local CARD_W = floor((CW - CARD_GAP * 2) / 3)
local MEDIA_H = 72

-- A card: the panel, a hairline, an inset night for its miniature, its
-- title and line.
local function card(p, title, desc)
	local c = CreateFrame("Frame", nil, p)
	c:SetWidth(CARD_W)
	W.Fill(c, "panel", "BACKGROUND", -6)
	outline(c)
	c.Media = CreateFrame("Frame", nil, c)
	c.Media:SetPoint("TOPLEFT", c, "TOPLEFT", 6, -6)
	c.Media:SetPoint("TOPRIGHT", c, "TOPRIGHT", -6, -6)
	c.Media:SetHeight(MEDIA_H)
	if c.Media.SetClipsChildren then c.Media:SetClipsChildren(true) end
	local m = c.Media
	m.Ground = solid(m, "BACKGROUND", -7)
	m.Ground:SetAllPoints(m)
	m.Stars = m:CreateTexture(nil, "BACKGROUND", nil, -6)
	m.Stars:SetTexture(Theme.Media("band-stars"))
	m.Stars:SetAllPoints(m)
	m.Stars:SetTexCoord(0.4, 0.4 + (CARD_W - 12) / Theme.BAND_W, 0.2, 0.2 + MEDIA_H / Theme.BAND_H)
	outline(m)
	W.Painter(c, function(self)
		paintOutline(self, Theme.Wash("divider"))
		local sr, sg, sb = Theme.Color("shade")
		paintOutline(self.Media, sr, sg, sb, 0.6)
		local r, g, b = Theme.Color("scrim")
		self.Media.Ground:SetVertexColor(r, g, b, 1)
		local tr, tg, tb = Theme.Color("star")
		self.Media.Stars:SetVertexColor(tr, tg, tb, 0.5)
	end)
	c.Title = para(c, "heading", "text", CARD_W - 24, 2)
	c.Title:SetText(title)
	c.Desc = para(c, "note", "textMuted", CARD_W - 24, 3)
	c.Desc:SetText(desc)
	return c
end

-- The guide window's miniature: a goal row with the accent bar, its count
-- and the progress line under it.
local function goalMini(m)
	local box = CreateFrame("Frame", nil, m)
	box:SetPoint("TOPLEFT", m, "TOPLEFT", 10, -14)
	box:SetPoint("TOPRIGHT", m, "TOPRIGHT", -10, -14)
	box:SetHeight(34)
	W.Fill(box, "bg", "BACKGROUND", -5)
	outline(box)
	W.Painter(box, function(self) paintOutline(self, Theme.Wash("border")) end)
	box.Bar = solid(box, "ARTWORK", 1)
	box.Bar:SetSize(2, 15)
	box.Bar:SetPoint("TOPLEFT", box, "TOPLEFT", 0, -6)
	W.Color(box.Bar, "accent")
	box.Glyph = W.Tex(box, "ARTWORK", "icon-collect", "text")
	box.Glyph:SetSize(11, 11)
	box.Glyph:SetPoint("CENTER", box, "TOPLEFT", 12 + 5.5, -13)
	box.Count = W.Text(box, "caption", "success")
	box.Count:SetPoint("RIGHT", box, "TOPRIGHT", -8, -13)
	box.Name = W.Text(box, "small", "item")
	box.Name:SetPoint("LEFT", box.Glyph, "RIGHT", 6, 0)
	box.Name:SetPoint("RIGHT", box.Count, "LEFT", -6, 0)
	box.Name:SetJustifyH("LEFT")
	box.Name:SetWordWrap(false)
	box.Line = CreateFrame("Frame", nil, box)
	box.Line:SetPoint("TOPLEFT", box, "TOPLEFT", 12, -24)
	box.Line:SetPoint("TOPRIGHT", box, "TOPRIGHT", -8, -24)
	box.Line:SetHeight(3)
	box.Line.Track = solid(box.Line, "BACKGROUND", 0)
	box.Line.Track:SetAllPoints(box.Line)
	W.Painter(box.Line.Track, function(t) t:SetVertexColor(Theme.Wash("track")) end)
	box.Line.Fill = solid(box.Line, "ARTWORK", 0)
	box.Line.Fill:SetPoint("TOPLEFT", box.Line, "TOPLEFT", 0, 0)
	box.Line.Fill:SetPoint("BOTTOMLEFT", box.Line, "BOTTOMLEFT", 0, 0)
	W.Color(box.Line.Fill, "success")
	return box
end

local function paintGoalMini(box, g)
	local kind, name, n = sampleGoal(g)
	if not kind then kind, name, n = "collect", L["Supplies"], 5 end
	local cur = max(1, floor(n * 0.6))
	box.Glyph:SetTexture(Theme.Media(kind == "kill" and "icon-kill" or "icon-collect"))
	box.Name:SetText(name)
	W.Color(box.Name, kind == "kill" and "npc" or "item")
	box.Count:SetText(cur .. "/" .. n)
	box.Line.Fill:SetWidth(max(1, (CARD_W - 12 - 20 - 20) * cur / n))
end

-- The arrow's miniature: the gold dart, a distance and where it leads.
local function arrowMini(m)
	local a = CreateFrame("Frame", nil, m)
	a:SetAllPoints(m)
	a.Dart = W.Tex(a, "ARTWORK", "dart-gold")
	a.Dart:SetSize(40, 40)
	a.Dart:SetTexCoord(0, 1, 0, 1)
	a.Dart:SetRotation(rad(30))
	a.Yd = W.Text(a, "display", "text")
	a.Yd:SetText((L["%d yd"]):format(412)) -- an illustration of the arrow's readout
	a.To = W.Text(a, "small", "textDim")
	a.To:SetWordWrap(false)
	return a
end

local function paintArrowMini(a, g)
	local walk = g and firstWalk(g)
	local to = walk and walk[5] or L["your next stop"]
	a.To:SetText(L["Go to"] .. " " .. colored("place", to))
	local room = CARD_W - 12 - 16 - 40 - 10
	local textW = min(room, max(W.TextWidth(a.Yd), W.TextWidth(a.To)))
	a.To:SetWidth(textW)
	local total = 40 + 10 + textW
	local x = floor((CARD_W - 12 - total) / 2)
	a.Dart:ClearAllPoints()
	a.Dart:SetPoint("CENTER", a, "LEFT", x + 20, 0)
	local h = a.Yd:GetStringHeight() + 3 + a.To:GetStringHeight()
	a.Yd:ClearAllPoints()
	a.Yd:SetPoint("TOPLEFT", a, "LEFT", x + 50, h / 2)
	a.To:ClearAllPoints()
	a.To:SetPoint("TOPLEFT", a.Yd, "BOTTOMLEFT", 0, -3)
end

-- The library's miniature: three rows with their counts, the first chosen.
local LIBRARY = {
	{ "Leveling", "icon-level" },
	{ "Professions", "icon-craft" },
	{ "Reputation", "icon-rep" },
}

local function libraryMini(m)
	local rows = {}
	for i, it in ipairs(LIBRARY) do
		local r = CreateFrame("Frame", nil, m)
		r:SetPoint("TOPLEFT", m, "TOPLEFT", 10, -(9 + (i - 1) * 20))
		r:SetPoint("TOPRIGHT", m, "TOPRIGHT", -10, -(9 + (i - 1) * 20))
		r:SetHeight(17)
		local sel = i == 1
		r.Fill = solid(r, "BACKGROUND", -4)
		r.Fill:SetAllPoints(r)
		W.Painter(r.Fill, function(t) t:SetVertexColor(Theme.Wash(sel and "selected" or "hover")) end)
		if sel then
			r.Bar = solid(r, "ARTWORK", 1)
			r.Bar:SetPoint("TOPLEFT", r, "TOPLEFT", 0, 0)
			r.Bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0)
			r.Bar:SetWidth(2)
			W.Color(r.Bar, "accent")
		end
		r.Glyph = W.Tex(r, "ARTWORK", it[2], sel and "accent" or "textMuted")
		r.Glyph:SetSize(11, 11)
		r.Glyph:SetPoint("LEFT", r, "LEFT", 6, 0)
		r.Count = W.Text(r, "caption", "textMuted")
		r.Count:SetPoint("RIGHT", r, "RIGHT", -6, 0)
		r.Name = W.Text(r, "small", sel and "text" or "textDim")
		r.Name:SetPoint("LEFT", r.Glyph, "RIGHT", 7, 0)
		r.Name:SetPoint("RIGHT", r.Count, "LEFT", -6, 0)
		r.Name:SetJustifyH("LEFT")
		r.Name:SetWordWrap(false)
		r.Name:SetText(L[it[1]])
		r.psCategory = it[1]
		rows[i] = r
	end
	return rows
end

PAGES[#PAGES + 1] = {
	key = "welcome",
	build = function(P)
		local h = P.Hero
		h:SetHeight(HELLO_H)
		-- The start zone's painting, engraved: no colour, multiplied into
		-- the night's blue, faint.
		h.Art = UI.ZoneArt.Create(h, INNER, HELLO_H, "bg")
		h.Art:SetPoint("TOPLEFT", h, "TOPLEFT", 0, 0)
		h.Art.psZoom = 1.2
		h.Art.psDesat = 1
		h.Art.Fade:Hide()
		h.Art.Top:Hide()
		h.Art.Rule:Hide()
		h.Sky = CreateFrame("Frame", nil, h)
		h.Sky:SetAllPoints(h)
		h.Sky:SetFrameLevel(h.Art.Over:GetFrameLevel() + 1)
		h.Night = night(h, h.Sky, HELLO_H, {})
		-- Over the painting, the night again from the top; under it all, the
		-- fade into the page's ground.
		h.Dark = solid(h.Sky, "BACKGROUND", -7)
		h.Dark:SetPoint("TOPLEFT", h.Sky, "TOPLEFT", 0, 0)
		h.Dark:SetPoint("TOPRIGHT", h.Sky, "TOPRIGHT", 0, 0)
		h.Dark:SetHeight(floor(HELLO_H * 0.55))
		h.Under = solid(h.Sky, "BORDER", -2)
		h.Under:SetPoint("BOTTOMLEFT", h.Sky, "BOTTOMLEFT", 0, 0)
		h.Under:SetPoint("BOTTOMRIGHT", h.Sky, "BOTTOMRIGHT", 0, 0)
		h.Under:SetHeight(120)
		W.Painter(h.Under, function(t)
			local r, g, b = Theme.Color("bg")
			vgrad(t, r, g, b, 0, r, g, b, 1)
			local sr, sg, sb = Theme.Color("scrim")
			vgrad(h.Dark, sr, sg, sb, 0.85, sr, sg, sb, 0)
			local kr, kg, kb = Theme.Color("sky")
			h.Art.psTint = { min(1, kr * 1.5), min(1, kg * 1.5), min(1, kb * 1.5) }
		end)
		-- The lockup: the emblem (Polaris) with the Dipper's handle leading
		-- to it, the wordmark and tagline centred under it.
		local cx = floor(INNER / 2)
		dipper(h.Sky, cx + 30, 70, 1, 0)
		emblem(h.Sky, 60, cx, 70, 170, 70)
		h.Word = W.Tex(h.Sky, "ARTWORK", "wordmark", "text")
		h.Word:SetSize(144, 18)
		h.Word:SetPoint("CENTER", h.Sky, "TOPLEFT", cx, -130)
		h.Tagline = W.Text(h.Sky, "note", "textDim")
		h.Tagline:SetWidth(CW)
		h.Tagline:SetJustifyH("CENTER")
		h.Tagline:SetText(L["Leveling guides for World of Warcraft: Forever"])
		h.Tagline:SetPoint("TOP", h.Sky, "TOPLEFT", cx, -151)

		local p = P.Body
		p.Title = para(p, "hero", "text", CW, 2)
		p.Line = para(p, "body", "textDim", CW)
		p.Line:SetText(L["Polestar guides you step by step: who to talk to, what to kill or collect, and where to go."])
		p.Cards = {
			card(p, L["The guide window"], L["Goals tick off as you play."]),
			card(p, L["The arrow"], L["Points the way. The map marks each place."]),
			card(p, L["Every guide"], L["Leveling, professions, reputations, mounts and pets."]),
		}
		p.Goal = goalMini(p.Cards[1].Media)
		p.Arrow = arrowMini(p.Cards[2].Media)
		p.Library = libraryMini(p.Cards[3].Media)
		-- What the next pages are for.
		p.Ahead = para(p, "note", "textMuted", CW, 3)
	end,
	layout = function(P)
		local h, p = P.Hero, P.Body
		local id, g = suggested()
		local painted = false
		if g and house() then
			local fx, fy
			local E = ns.Engine
			if E and E.GuideFocus then fx, fy = E.GuideFocus(id) end
			painted = UI.ZoneArt.Paint(h.Art, g.zone, fx, fy, 1) and true or false
		end
		h.Art:SetShown(painted)
		h.Art:SetAlpha(0.55)
		h.Dark:SetShown(painted)

		local name = known(playerInfo().name)
		p.Title:SetText(name and (L["Hello, %s"]):format(name) or L["Welcome to Polestar"])
		place(p.Title, 0, 4)
		local y = 4 + p.Title:GetStringHeight() + 8
		place(p.Line, 0, y)
		y = y + p.Line:GetStringHeight() + 22
		paintGoalMini(p.Goal, g)
		paintArrowMini(p.Arrow, g)
		for _, r in ipairs(p.Library) do
			local n = countOf(r.psCategory)
			r.Count:SetText(n > 0 and tostring(n) or "")
		end
		-- Every card as tall as the tallest.
		local textH = 0
		for _, c in ipairs(p.Cards) do
			textH = max(textH, c.Title:GetStringHeight() + 4 + c.Desc:GetStringHeight())
		end
		for i, c in ipairs(p.Cards) do
			place(c, (i - 1) * (CARD_W + CARD_GAP), y)
			c:SetHeight(6 + MEDIA_H + 10 + textH + 12)
			c.Title:ClearAllPoints()
			c.Title:SetPoint("TOPLEFT", c, "TOPLEFT", 12, -(6 + MEDIA_H + 10))
			c.Desc:ClearAllPoints()
			c.Desc:SetPoint("TOPLEFT", c.Title, "BOTTOMLEFT", 0, -4)
		end
		y = y + 6 + MEDIA_H + 10 + textH + 12 + 18
		-- A later character's settings are the account's: only its own choices follow.
		local own = #pageList() > 2
		if full then
			p.Ahead:SetText(L["The next pages set Polestar up for how you play. Each choice works at once, and Skip install keeps everything as it is."])
		elseif own then
			p.Ahead:SetText(L["Your settings come with you from your other characters. Next, the choice that is this character's own."])
		else
			p.Ahead:SetText(L["Your settings come with you from your other characters."])
		end
		place(p.Ahead, 0, y)
		return HELLO_H, y + p.Ahead:GetStringHeight()
	end,
	title = function(P) return P.Body.Title:GetText() end,
}

-- Choices ------------------------------------------------------------------

-- Quest automation is one switch for two settings: on while both are.
local function autoQuestGet()
	return ns.Get("behavior.autoAccept") and ns.Get("behavior.autoTurnin")
end

local function autoQuestSet(v)
	ns.Set("behavior.autoAccept", v)
	ns.Set("behavior.autoTurnin", v)
end

-- A toggle row with its description under the label, not only in the
-- tooltip, a hairline under it: the row reaches 12px past the 32 edge on
-- both sides, so the label and the switch sit on the page's edges.
local ROW_PAD = 11
local TEXT_W = CW - 30 - 24

-- opts: depends (the setting the row waits on, greyed while it is off),
-- child (indented under that setting's row).
local CHILD_X = 18
local function toggleRow(p, label, path, desc, opts)
	local row = W.Toggle(p, label, path, desc, opts and opts.depends, opts)
	local indent = opts and opts.child and CHILD_X or 0
	row:SetWidth(CW + 24)
	row.Desc = para(row, "note", "textMuted", TEXT_W - indent, 3)
	row.Desc:SetText(desc)
	row.Track:ClearAllPoints()
	row.Track:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	row.Label:ClearAllPoints()
	row.Label:SetPoint("TOPLEFT", row, "TOPLEFT", 12 + indent, -ROW_PAD)
	row.Label:SetWidth(TEXT_W - indent)
	row.Label:SetWordWrap(true)
	row.Desc:SetPoint("TOPLEFT", row.Label, "BOTTOMLEFT", 0, -3)
	row.Rule:ClearAllPoints() -- the row's own hairline, on the page's edges
	row.Rule:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 12, 0)
	row.Rule:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", -12, 0)
	return row
end

local function toggleRowHeight(row)
	return ROW_PAD + row.Label:GetStringHeight() + 3 + row.Desc:GetStringHeight() + ROW_PAD
end

-- Lays toggle rows out from y, those `shown` says no to hidden. -> the y under them
local function layRows(rows, y, shown)
	for _, row in ipairs(rows) do
		local on = shown == nil or shown(row)
		row:SetShown(on)
		if on then
			place(row, -12, y)
			row:Refresh()
			local rh = toggleRowHeight(row)
			row:SetHeight(rh)
			y = y + rh
		end
	end
	return y
end

-- The line every choice page ends on.
local function keepLine(p)
	local fs = para(p, "note", "textMuted", CW, 3)
	fs:SetText(L["Skip install keeps these as they are."])
	return fs
end

-- Option cards: one setting's few values side by side (four to a row at
-- most), each a radio ring, its name and what it does under it; the one in
-- use on the selected wash in a 1px accent outline. A click sets it live;
-- right-click (or the gamepad's Y) puts the default back. spec: { title,
-- note (or nil), get() -> the value in use, set(value) (nil: the default),
-- choices() -> { { value, name, desc (or nil) }, ... } }. The cards are made
-- as the choices first need them, and repaint as any setting changes.
local OPTION_GAP, OPTION_PER_ROW, OPTION_PAD = 10, 4, 10
local OPTION_TEXT_X = OPTION_PAD + 14 + 8 -- after the ring's 14px of ink

local function paintOption(c)
	local on = c.psGroup.spec.get() == c.psValue
	c.psSelected = on
	c.Fill:SetShown(on)
	c.Dot:SetShown(on)
	if on then
		local r, g, b = Theme.Accent()
		paintOutline(c, r, g, b, 1)
		c.Ring:SetVertexColor(r, g, b)
	else
		paintOutline(c, Theme.Wash("border"))
		c.Ring:SetVertexColor(Theme.Color("textMuted"))
	end
	W.Color(c.Name, on and "text" or "textDim")
end

local function optionCard(g)
	local c = CreateFrame("Button", nil, g.parent)
	c.psGroup = g
	c.Fill = solid(c, "BACKGROUND", -6)
	c.Fill:SetAllPoints(c)
	W.Hover(c)
	outline(c)
	c.Ring = W.Tex(c, "ARTWORK", "skin-ring", nil, 0)
	c.Ring:SetSize(19, 19) -- the ring's ink is 14px of it
	c.Dot = W.Tex(c, "ARTWORK", "circle", "accent", 2)
	c.Dot:SetSize(7, 7)
	c.Dot:SetPoint("CENTER", c.Ring, "CENTER", 0, 0)
	c.Name = W.Text(c, "label", "text")
	c.Name:SetJustifyH("LEFT")
	c.Name:SetJustifyV("TOP")
	c.Name:SetWordWrap(true)
	c.Desc = para(c, "note", "textMuted", 100, 3)
	c:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	c:SetScript("OnClick", function(self, button)
		local spec = self.psGroup.spec
		if button == "RightButton" then spec.set(nil) else spec.set(self.psValue) end
		for _, o in ipairs(self.psGroup.cards) do paintOption(o) end
	end)
	W.Painter(c, function(self)
		self.Fill:SetVertexColor(Theme.Wash("selected"))
		if self.psValue ~= nil then paintOption(self) end
	end)
	return c
end

local function optionGroup(p, spec)
	local g = { spec = spec, parent = p, cards = {} }
	g.Title = para(p, "body", "text", CW, 2)
	g.Title:SetText(spec.title)
	if spec.note then
		g.Note = para(p, "note", "textMuted", CW, 3)
		g.Note:SetText(spec.note)
	end
	F.Groups[#F.Groups + 1] = g
	return g
end

-- Shows group g or hides it; shown, lays it out from y. -> the y under it
local function layGroup(g, y, shown)
	local list = shown and g.spec.choices() or {}
	shown = shown and #list > 0
	g.Title:SetShown(shown)
	if g.Note then g.Note:SetShown(shown) end
	for i = shown and #list + 1 or 1, #g.cards do g.cards[i]:Hide() end
	if not shown then return y end
	place(g.Title, 0, y)
	y = y + g.Title:GetStringHeight() + 4
	if g.Note then
		place(g.Note, 0, y)
		y = y + g.Note:GetStringHeight()
	end
	y = y + 10
	local perRow = min(OPTION_PER_ROW, #list)
	local cw = floor((CW - OPTION_GAP * (perRow - 1)) / perRow)
	local rowTop, rowH = y, 0
	for i, ch in ipairs(list) do
		local c = g.cards[i] or optionCard(g)
		g.cards[i] = c
		c.psValue = ch.value
		c.Name:SetText(ch.name)
		c.Name:SetWidth(cw - OPTION_TEXT_X - OPTION_PAD)
		c.Desc:SetText(ch.desc or "")
		c.Desc:SetWidth(cw - OPTION_PAD * 2)
		c.Desc:SetShown(ch.desc ~= nil)
		local nameH = c.Name:GetStringHeight()
		c.Name:ClearAllPoints()
		c.Name:SetPoint("TOPLEFT", c, "TOPLEFT", OPTION_TEXT_X, -OPTION_PAD)
		c.Ring:ClearAllPoints()
		-- The ring on the name's first line.
		local _, size = c.Name:GetFont()
		c.Ring:SetPoint("CENTER", c, "TOPLEFT", OPTION_PAD + 7, -(OPTION_PAD + min(nameH, (tonumber(size) or 12) * 1.2) / 2))
		c.Desc:ClearAllPoints()
		c.Desc:SetPoint("TOPLEFT", c, "TOPLEFT", OPTION_PAD, -(OPTION_PAD + nameH + 4))
		c.psH = OPTION_PAD + nameH + (ch.desc and 4 + c.Desc:GetStringHeight() or 0) + OPTION_PAD
		local col = (i - 1) % perRow
		if col == 0 and i > 1 then
			rowTop = rowTop + rowH + OPTION_GAP
			rowH = 0
		end
		place(c, col * (cw + OPTION_GAP), rowTop)
		c:SetWidth(cw)
		rowH = max(rowH, c.psH)
		c:Show()
		-- Every card of a row as tall as its tallest.
		if col == perRow - 1 or i == #list then
			for k = i - col, i do g.cards[k]:SetHeight(rowH) end
		end
		paintOption(c)
	end
	return rowTop + rowH
end

-- Scheme cards: a small window in that scheme's colours (the sidebar strip,
-- the ground, the sky along its top, a title and a line, the selection bar
-- and the primary button), the name under it; the chosen one in a 1px
-- accent outline. The scheme's own colours come from Theme.SCHEMES;
-- EllesmereUI derives its grounds from its panel, shown as they are while
-- it is in use.
local SCHEME_GAP, PREVIEW_H, SCHEME_NAME_H = 12, 44, 24

local function schemeColours(key)
	if key == "ellesmere" then
		if Theme.SchemeKey() == "ellesmere" then return Theme.Palette() end
		return Theme.SCHEMES.graphite
	end
	return Theme.SCHEMES[key] or Theme.SCHEMES.dusk
end

local function paintScheme(c)
	local pal = schemeColours(c.psValue)
	local function rgb(name) local v = pal[name]; return v[1], v[2], v[3] end
	c.Ground:SetVertexColor(rgb("bg"))
	c.Side:SetVertexColor(rgb("sidebar"))
	c.Sky:SetVertexColor(rgb("sky"))
	c.Line1:SetVertexColor(rgb("text"))
	c.Line2:SetVertexColor(rgb("textMuted"))
	local ar, ag, ab = Theme.Accent()
	c.Button:SetVertexColor(ar, ag, ab, 1)
	c.Bar:SetVertexColor(ar, ag, ab, 1)
	local on = Theme.SchemeKey() == c.psValue
	c.psSelected = on
	if on then paintOutline(c, ar, ag, ab, 1) else paintOutline(c, Theme.Wash("border")) end
	W.Color(c.Name, on and "text" or "textDim")
end

local function schemeCard(p)
	local c = CreateFrame("Button", nil, p)
	W.Hover(c)
	outline(c)
	c.Side = solid(c, "BORDER", 0)
	c.Side:SetPoint("TOPLEFT", c, "TOPLEFT", 5, -5)
	c.Side:SetSize(22, PREVIEW_H)
	c.Ground = solid(c, "BORDER", 0)
	c.Ground:SetPoint("TOPLEFT", c.Side, "TOPRIGHT", 0, 0)
	c.Ground:SetPoint("TOPRIGHT", c, "TOPRIGHT", -5, -5)
	c.Ground:SetHeight(PREVIEW_H)
	c.Sky = solid(c, "BORDER", 1)
	c.Sky:SetPoint("TOPLEFT", c.Ground, "TOPLEFT", 0, 0)
	c.Sky:SetPoint("TOPRIGHT", c.Ground, "TOPRIGHT", 0, 0)
	c.Sky:SetHeight(14)
	c.Line1 = solid(c, "ARTWORK", 0)
	c.Line1:SetSize(52, 4)
	c.Line1:SetPoint("TOPLEFT", c.Ground, "TOPLEFT", 8, -20)
	c.Line2 = solid(c, "ARTWORK", 0)
	c.Line2:SetPoint("TOPLEFT", c.Ground, "TOPLEFT", 8, -29)
	c.Line2:SetHeight(3)
	c.Bar = solid(c, "ARTWORK", 1)
	c.Bar:SetSize(2, 15)
	c.Bar:SetPoint("TOPLEFT", c.Ground, "TOPLEFT", 0, -18)
	c.Button = solid(c, "ARTWORK", 0)
	c.Button:SetSize(22, 7)
	c.Button:SetPoint("BOTTOMRIGHT", c.Ground, "BOTTOMRIGHT", -6, 6)
	c.Name = W.Text(c, "label", "textDim")
	c.Name:SetPoint("TOPLEFT", c.Side, "BOTTOMLEFT", 3, 0)
	c.Name:SetPoint("TOPRIGHT", c.Ground, "BOTTOMRIGHT", -3, 0)
	c.Name:SetHeight(SCHEME_NAME_H)
	c.Name:SetJustifyH("LEFT")
	c.Name:SetWordWrap(false)
	-- Click applies it live; right-click puts the default back.
	c:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	c:SetScript("OnClick", function(self, button)
		if button == "RightButton" then ns.Set("ui.scheme", nil) else ns.Set("ui.scheme", self.psValue) end
	end)
	return c
end

-- The route line's look (nav.lineStyle, Maps/RouteLines.lua): a card per
-- style with a small preview of it on a dark ground, along one gentle path
-- from the player's mark to the goal's; a click applies it, right-click puts
-- the default (the line) back. The sparkles' preview drifts toward the goal
-- only while it shows (its OnUpdate, 20 times a second, moves the textures
-- it made once), and holds still under ui.reduceMotion, as the maps then
-- draw dots.
local LOOK_PATH = { 0.07, 0.74, 0.22, 0.52, 0.38, 0.44, 0.54, 0.58, 0.7, 0.62, 0.84, 0.42, 0.93, 0.28 } -- x, y fractions
local LOOK_POINTS = #LOOK_PATH / 2
local LOOK_DOT_GAP, LOOK_SPARKLES, LOOK_FLOW, LOOK_TICK = 8, 6, 10, 1 / 20
local NAV_MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Nav\\"

-- A preview path point in the card's ground, from its top left.
local function lookPoint(c, i)
	return LOOK_PATH[i * 2 - 1] * c.psW, LOOK_PATH[i * 2] * PREVIEW_H
end

-- The point `d` px along the preview path, and the path's length.
local function lookAlong(c, d)
	local ax, ay = lookPoint(c, 1)
	for i = 2, LOOK_POINTS do
		local bx, by = lookPoint(c, i)
		local len = sqrt((bx - ax) ^ 2 + (by - ay) ^ 2)
		if d <= len then
			local t = len > 0 and d / len or 0
			return ax + (bx - ax) * t, ay + (by - ay) * t
		end
		d = d - len
		ax, ay = bx, by
	end
	return ax, ay
end

local function lookLength(c)
	local total = 0
	local ax, ay = lookPoint(c, 1)
	for i = 2, LOOK_POINTS do
		local bx, by = lookPoint(c, i)
		total = total + sqrt((bx - ax) ^ 2 + (by - ay) ^ 2)
		ax, ay = bx, by
	end
	return total
end

-- The route's colour: Dot colour's when one is set, else the arrow's (the accent).
local function routeColour()
	local R = ns.RouteLines
	local tint = R and R.DOT_COLORS and R.DOT_COLORS[ns.Get("nav.dotColor")]
	if tint then return tint[1], tint[2], tint[3] end
	local r, g, b = Theme.Color("arrow")
	return r, g, b
end

local function centre(t, c, x, y)
	t:ClearAllPoints()
	t:SetPoint("CENTER", c.Look, "TOPLEFT", x, -y)
end

-- The sparkles' preview: each sparkle a spacing apart, flowing toward the goal and twinkling.
local function drawSparkles(c, now)
	local still = Anim and Anim.Reduced and Anim.Reduced()
	local spacing = c.psLength / LOOK_SPARKLES
	local shift = still and spacing / 2 or (now * LOOK_FLOW) % spacing
	for k, t in ipairs(c.Marks) do
		local x, y = lookAlong(c, (k - 1) * spacing + shift)
		centre(t, c, x, y)
		t:SetAlpha(still and 0.85 or 0.55 + 0.45 * sin(now * 3 + k * 1.7))
	end
end

local function lookTick(self, elapsed)
	local c = self:GetParent()
	c.psElapsed = (c.psElapsed or 0) + elapsed
	if c.psElapsed < LOOK_TICK then return end
	c.psElapsed = 0
	drawSparkles(c, GetTime and GetTime() or 0)
end

local function lookCard(p, style)
	local c = CreateFrame("Button", nil, p)
	W.Hover(c)
	outline(c)
	c.psStyle = style
	c.Look = CreateFrame("Frame", nil, c)
	c.Look:SetPoint("TOPLEFT", c, "TOPLEFT", 5, -5)
	c.Look:SetPoint("TOPRIGHT", c, "TOPRIGHT", -5, -5)
	c.Look:SetHeight(PREVIEW_H)
	c.Ground = solid(c.Look, "BACKGROUND", 0)
	c.Ground:SetAllPoints(c.Look)
	c.Marks, c.Shadows = {}, {}
	if style == "line" then
		for i = 1, LOOK_POINTS - 1 do
			c.Shadows[i] = c.Look:CreateLine(nil, "ARTWORK", nil, 0)
			c.Shadows[i]:SetTexture(NAV_MEDIA .. "line-soft")
			c.Shadows[i]:SetThickness(9)
			c.Marks[i] = c.Look:CreateLine(nil, "ARTWORK", nil, 1)
			c.Marks[i]:SetColorTexture(1, 1, 1, 1)
			c.Marks[i]:SetThickness(3)
		end
	elseif style == "sparkle" then
		for i = 1, LOOK_SPARKLES do
			local t = c.Look:CreateTexture(nil, "ARTWORK", nil, 1)
			t:SetTexture(NAV_MEDIA .. "sparkle")
			t:SetBlendMode("ADD")
			t:SetSize(12, 12)
			c.Marks[i] = t
		end
		c.Look:SetScript("OnUpdate", lookTick)
	end
	c.Start = W.Tex(c.Look, "OVERLAY", "circle", nil, 0)
	c.Start:SetSize(7, 7)
	c.Goal = W.Tex(c.Look, "OVERLAY", "circle", nil, 0)
	c.Goal:SetSize(10, 10)
	c.Name = W.Text(c, "label", "textDim")
	c.Name:SetPoint("TOPLEFT", c.Look, "BOTTOMLEFT", 3, 0)
	c.Name:SetPoint("TOPRIGHT", c.Look, "BOTTOMRIGHT", -3, 0)
	c.Name:SetHeight(SCHEME_NAME_H)
	c.Name:SetJustifyH("LEFT")
	c.Name:SetWordWrap(false)
	c:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	c:SetScript("OnClick", function(self, button)
		if button == "RightButton" then ns.Set("nav.lineStyle", nil) else ns.Set("nav.lineStyle", self.psStyle) end
	end)
	return c
end

-- The preview drawn for the card's width, in the theme's and the route's colours.
local function paintLook(c)
	if not c.psW then return end
	local r, g, b = routeColour()
	local s1, s2, s3 = Theme.Color("scrim")
	c.Ground:SetVertexColor(Theme.Color("sidebar"))
	if c.psStyle == "line" then
		for i = 1, LOOK_POINTS - 1 do
			local ax, ay = lookPoint(c, i)
			local bx, by = lookPoint(c, i + 1)
			c.Shadows[i]:SetStartPoint("TOPLEFT", c.Look, ax, -ay)
			c.Shadows[i]:SetEndPoint("TOPLEFT", c.Look, bx, -by)
			c.Marks[i]:SetStartPoint("TOPLEFT", c.Look, ax, -ay)
			c.Marks[i]:SetEndPoint("TOPLEFT", c.Look, bx, -by)
			c.Shadows[i]:SetVertexColor(s1, s2, s3, 0.75)
			c.Marks[i]:SetVertexColor(r, g, b, 1)
		end
	elseif c.psStyle == "dots" then
		local n = floor(c.psLength / LOOK_DOT_GAP) + 1
		for i = 1, n do
			local t = c.Marks[i]
			if not t then
				t = W.Tex(c.Look, "ARTWORK", "circle", nil, 1)
				t:SetSize(4, 4)
				c.Marks[i] = t
			end
			centre(t, c, lookAlong(c, (i - 1) * LOOK_DOT_GAP))
			t:SetVertexColor(r, g, b, 1)
			t:Show()
		end
		for i = n + 1, #c.Marks do c.Marks[i]:Hide() end
	else
		for _, t in ipairs(c.Marks) do t:SetVertexColor(r, g, b, 1) end
		drawSparkles(c, GetTime and GetTime() or 0)
	end
	centre(c.Start, c, lookPoint(c, 1))
	c.Start:SetVertexColor(Theme.Color("text"))
	centre(c.Goal, c, lookPoint(c, LOOK_POINTS))
	c.Goal:SetVertexColor(Theme.Accent())
	local on = ns.Get("nav.lineStyle") == c.psStyle
	c.psSelected = on
	if on then
		local ar, ag, ab = Theme.Accent()
		paintOutline(c, ar, ag, ab, 1)
	else
		paintOutline(c, Theme.Wash("border"))
	end
	W.Color(c.Name, on and "text" or "textDim")
end

-- The route line cards (Maps/RouteLines.lua's styles) on page p, for the
-- route page: a heading, its line, a card per style.
local function buildLines(p)
	F.Lines = {}
	local R = ns.RouteLines
	if not (R and R.STYLE_CHOICES) then return end
	p.LineTitle = para(p, "body", "text", CW, 2)
	p.LineTitle:SetText(L["Route line"])
	p.LineNote = para(p, "note", "textMuted", CW, 3)
	p.LineNote:SetText(L["How the way to your goal shows on the world map and the minimap."])
	for i, ch in ipairs(R.STYLE_CHOICES) do
		local c = lookCard(p, ch.value)
		c.Name:SetText(ch.label)
		F.Lines[i] = c
	end
end

-- Lays the route line cards out from y. -> the y under them
local function layLines(p, y)
	if #F.Lines == 0 then return y end
	place(p.LineTitle, 0, y)
	y = y + p.LineTitle:GetStringHeight() + 4
	place(p.LineNote, 0, y)
	y = y + p.LineNote:GetStringHeight() + 10
	local count = #F.Lines
	local lw = floor((CW - SCHEME_GAP * (count - 1)) / count)
	for i, c in ipairs(F.Lines) do
		c:SetSize(lw, 5 + PREVIEW_H + SCHEME_NAME_H)
		c.psW = lw - 10
		c.psLength = lookLength(c)
		place(c, (i - 1) * (lw + SCHEME_GAP), y)
		if not c.psPainted then
			c.psPainted = true
			W.Painter(c, paintLook)
		else
			paintLook(c)
		end
	end
	return y + 5 + PREVIEW_H + SCHEME_NAME_H
end

-- The scheme cards (Theme.SchemeChoices) on page p, for the look page.
local function buildSchemes(p)
	F.Schemes = {}
	p.SchemeTitle = para(p, "body", "text", CW, 2)
	p.SchemeTitle:SetText(L["Colour scheme"])
	p.SchemeNote = para(p, "note", "textMuted", CW, 3)
	p.SchemeNote:SetText(L["The background of every Polestar window. It changes as you pick."])
end

-- Shows the scheme cards from y, or hides them. -> the y under them
local function laySchemes(p, y, shown)
	p.SchemeTitle:SetShown(shown)
	p.SchemeNote:SetShown(shown)
	local choices = shown and Theme.SchemeChoices() or {}
	local n = #choices
	for i = n + 1, #F.Schemes do F.Schemes[i]:Hide() end
	if n == 0 then return y end
	place(p.SchemeTitle, 0, y)
	y = y + p.SchemeTitle:GetStringHeight() + 4
	place(p.SchemeNote, 0, y)
	y = y + p.SchemeNote:GetStringHeight() + 10
	local cw = floor((CW - SCHEME_GAP * (n - 1)) / n)
	for i, ch in ipairs(choices) do
		local c = F.Schemes[i] or schemeCard(p)
		F.Schemes[i] = c
		c.psValue = ch.value
		c.Name:SetText(ch.text)
		c:SetSize(cw, 5 + PREVIEW_H + SCHEME_NAME_H)
		-- The title line and the text line inside a card as narrow as six schemes make it.
		c.Line1:SetWidth(min(52, floor((cw - 10 - 22) * 0.6)))
		c.Line2:SetWidth(floor((cw - 10 - 22) * 0.8))
		place(c, (i - 1) * (cw + SCHEME_GAP), y)
		if not c.psPainted then
			c.psPainted = true
			W.Painter(c, paintScheme)
		else
			paintScheme(c)
		end
		c:Show()
	end
	return y + 5 + PREVIEW_H + SCHEME_NAME_H
end

-- 2. Questing ----------------------------------------------------------------

-- Gear advice's stat weights for the character's class (gear.spec.<CLASS>,
-- Gear/Weights.lua): kept per class, so a later character of another class
-- has its own. -> class, its entry | nil (no Gear, the class not known yet)
local function gearClass()
	local G = ns.Gear
	local class = G and G.Client and G.Client.PlayerClass and G.Client.PlayerClass()
	local meta = class and G.CLASSES and G.CLASSES[class]
	if meta and meta.specs and #meta.specs > 0 and ns.GetDefault("gear.spec." .. class) ~= nil then return class, meta end
	return nil
end

-- Automatic (the talent tree with the most points), the class's specs, and
-- a custom scale (Settings, Gear advice) while one is in use.
local function gearChoices()
	local class, meta = gearClass()
	if not class then return {} end
	local out = { { value = "auto", name = L["Automatic (talents)"] } }
	for _, spec in ipairs(meta.specs) do out[#out + 1] = { value = spec.key, name = L[spec.label] } end
	local cur = ns.Get("gear.spec." .. class)
	local id = type(cur) == "string" and cur:match("^custom:(.+)$")
	local Scales = id and ns.Gear.Scales
	for _, scale in ipairs(Scales and Scales.List and Scales.List(class) or {}) do
		if tostring(scale.id) == id then out[#out + 1] = { value = cur, name = (L["Custom: %s"]):format(scale.name) } end
	end
	return out
end

PAGES[#PAGES + 1] = {
	key = "questing",
	-- A later character: its stat weights alone.
	shown = function() return full or gearClass() ~= nil end,
	build = function(P)
		compactHero(P.Hero, L["Questing"], L["How Polestar helps with your quests."], true)
		local p = P.Body
		F.AutoQuest = toggleRow(p, L["Accept and turn in guide quests for me"], "behavior.autoAccept",
			L["Only quests in the next steps of your open guides. Never picks between rewards. Hold Shift to skip."],
			{ get = autoQuestGet, set = autoQuestSet })
		F.SkipGrey = toggleRow(p, L["Skip grey quests"], "behavior.skipGrey",
			L["Leaves out grey quests and their turn-ins, unless a later quest needs them first."])
		F.AutoGuide = toggleRow(p, L["Load a guide for me when I log in"], "behavior.autoSelectGuide",
			L["Opens the suggested guide when no tab is open."])
		F.Gear = optionGroup(p, { title = L["Stat weights"],
			note = L["Gear advice scores quest rewards with them: it names the one to take and marks upgrades. Automatic follows your talents."],
			get = function()
				local class = gearClass()
				return class and ns.Get("gear.spec." .. class)
			end,
			set = function(v)
				local class = gearClass()
				if class then ns.Set("gear.spec." .. class, v) end
			end,
			choices = gearChoices })
		p.Keep = keepLine(p)
	end,
	layout = function(P)
		local heroH = layoutCompactHero(P.Hero)
		local p = P.Body
		local y = layRows({ F.AutoQuest, F.SkipGrey, F.AutoGuide }, 0, function() return full end)
		local gear = gearClass() ~= nil
		y = layGroup(F.Gear, (gear and y > 0) and y + 16 or y, gear) + 14
		place(p.Keep, 0, y)
		return heroH, y + p.Keep:GetStringHeight()
	end,
	title = function(P) return P.Hero.Title:GetText() end,
}

-- 3. Targeting -------------------------------------------------------------------

-- The target button and its switches (QoL/Buttons.lua), with QoL loaded.
local function targetShown()
	return ns.GetDefault("qol.targetButton") ~= nil
end

do
	local STAGE_H = 72
	-- The preview's names: the settings' Buttons page's.
	local DEMO = { L["Rot Hide Mongrel"], L["Scarlet Warrior"] }

	-- The target list's rows in the preview: the first close (green).
	local LIST = { { name = DEMO[1], verb = "kill", cur = 3, max = 8, near = true }, { name = DEMO[2], verb = "kill", cur = 0, max = 5 } }

	-- The preview: the target list as it stands beside the button (the live
	-- rows' own code on plain frames: Buttons.NewListFaces), or with Simple
	-- target button the button's own face (Buttons.NewFace: a plain Button,
	-- no secure template, no clicks) with its plate as qol.targetPlate has
	-- it; on a patch of the world, faint while the button is off.
	-- (psFace, psList: the faces, made only with QoL loaded.)
	local function paintStage(stage)
		paintOutline(stage, Theme.Wash("border"))
		local r, g, b = Theme.Color("scrim")
		stage.Ground:SetVertexColor(r, g, b, 1)
		local face, list, B = stage.psFace, stage.psList, ns.QoL and ns.QoL.Buttons
		if face and B then
			local alpha = ns.Get("qol.targetButton") and 1 or 0.35
			local simple = ns.Get("qol.targetSimple") or not list
			B.Paint(face)
			face:SetAlpha(alpha)
			face:SetShown(simple and true or false)
			if list then
				if simple then
					for _, row in ipairs(list.rows) do row:Hide() end
				else
					B.PaintListFaces(list, face, LIST, "right")
					for _, row in ipairs(list.rows) do row:SetAlpha(alpha) end
				end
				list.mark:SetShown(not simple)
				list.mark:SetAlpha(alpha)
			end
		end
	end

	PAGES[#PAGES + 1] = {
		key = "targeting",
		shown = function() return full and targetShown() end,
		build = function(P)
			compactHero(P.Hero, L["Targeting"],
				L["A list beside the target button names the mobs and NPCs of your step: click a name to target it, or press the button's key for the first one close by."])
			local p = P.Body
			local stage = CreateFrame("Frame", nil, p)
			stage:SetSize(CW, STAGE_H)
			outline(stage)
			stage.Ground = solid(stage, "BACKGROUND", -7)
			stage.Ground:SetAllPoints(stage)
			local B = ns.QoL and ns.QoL.Buttons
			if B and B.NewFace then
				local face = B.NewFace(stage, "target")
				face.aList, face.aVerbs, face.aIds, face.aMarks, face.aCycle = DEMO, { "kill", "kill" }, {}, { false, false }, 1
				face:SetPoint("LEFT", stage, "LEFT", 20, 0)
				face:EnableMouse(false)
				stage.psFace = face
				if B.NewListFaces then
					stage.psList = B.NewListFaces(stage, #LIST)
					stage.psList.mark:EnableMouse(false)
					for _, row in ipairs(stage.psList.rows) do row:EnableMouse(false) end
				end
			end
			stage.Refresh = paintStage
			W.Painter(stage, paintStage)
			W.Bind(stage, "qol.targetPlate", "qol.targetButton")
			W.Bind(stage, "qol.targetSimple")
			p.Stage = stage
			F.TargetButton = toggleRow(p, L["Show a button that targets the step's mobs and NPCs"], "qol.targetButton",
				L["A row for each mob or NPC your step names, with its face and what it drops, beside a small Polestar mark. Click a row, or press the target button's key for the first one close by."])
			-- The single button instead of the list; who it targets is its own.
			F.TargetSimple = toggleRow(p, L["Simple target button"], "qol.targetSimple",
				L["One square button instead of the list: each click, or a press of its key, targets the next name."],
				{ depends = "qol.targetButton", child = true })
			F.TargetPlate = toggleRow(p, L["Show who it targets"], "qol.targetPlate",
				L["Their name beside the button: green for an NPC, red for a mob, gold for an elite or rare."],
				{ depends = "qol.targetButton", child = true })
			W.SetDisabledWhen(F.TargetPlate, function() return not ns.Get("qol.targetSimple") end)
			F.MarkTarget = toggleRow(p, L["Mark what the target button finds"], "qol.markTarget",
				L["A skull on the enemy, a star on the friendly NPC. In a group it never takes another player's icon."])
			F.PingTarget = toggleRow(p, L["Ping it for my group"], "qol.pingTarget",
				L["Your group sees what the target button and the step key found, even behind rocks and buildings."])
			p.StepKey = para(p, "note", "textMuted", CW, 3)
			p.StepKey:SetText(L["The step key targets the same names without the button. Move frames, in Settings, moves the button."])
			p.Keep = keepLine(p)
		end,
		layout = function(P)
			local heroH = layoutCompactHero(P.Hero)
			local p = P.Body
			place(p.Stage, 0, 0)
			paintStage(p.Stage)
			local y = layRows({ F.TargetButton, F.TargetSimple, F.TargetPlate, F.MarkTarget, F.PingTarget }, STAGE_H + 8) + 10
			place(p.StepKey, 0, y)
			y = y + p.StepKey:GetStringHeight() + 14
			place(p.Keep, 0, y)
			return heroH, y + p.Keep:GetStringHeight()
		end,
		title = function(P) return P.Hero.Title:GetText() end,
	}
end

-- 4. Groups and dungeons -------------------------------------------------------

-- Dungeons in the route (behavior.dungeons; Engine's Own.dungeonAnswer):
-- once the setting exists and the character's guides have dungeons
-- (Engine.GuideDungeons), as Options offers it.
local function dungeonsShown()
	local E = ns.Engine
	return ns.GetDefault("behavior.dungeons") ~= nil and E ~= nil and E.GuideDungeons ~= nil and next(E.GuideDungeons() or {}) ~= nil
end

-- Group quests (behavior.groupQuests; Own.groupAnswer): while the guides have any.
local function groupQuestsShown()
	local E = ns.Engine
	return ns.GetDefault("behavior.groupQuests") ~= nil and E ~= nil and E.GroupQuests ~= nil and #(E.GroupQuests() or {}) > 0
end

local function oneOf(path, list, default)
	local v = ns.Get(path)
	for _, x in ipairs(list) do if v == x then return v end end
	return default
end

PAGES[#PAGES + 1] = {
	key = "groups",
	shown = function() return full and (dungeonsShown() or groupQuestsShown()) end,
	build = function(P)
		compactHero(P.Hero, L["Groups and dungeons"],
			L["Leveling guides can take you through dungeons and group quests on your way. Choose how much of that you want."])
		local p = P.Body
		F.Dungeons = optionGroup(p, { title = L["Dungeons in my route"],
			note = L["For a group of five: the guide picks up a dungeon's quests on its way, sends you to the door at the right level and hands them in after."],
			get = function() return oneOf("behavior.dungeons", { "skip", "ask", "run" }, "skip") end,
			set = function(v) ns.Set("behavior.dungeons", v) end,
			choices = function()
				return {
					{ value = "skip", name = L["Skip them"], desc = L["The solo route."] },
					{ value = "ask", name = L["Ask me"], desc = L["The guide asks at each dungeon."] },
					{ value = "run", name = L["Run them"], desc = L["Every dungeon on your way."] },
				}
			end })
		F.GroupQuests = optionGroup(p, { title = L["Group quests"],
			note = L["Elite and escort quests the guides mark for a group."],
			get = function() return oneOf("behavior.groupQuests", { "ask", "do", "skip" }, "ask") end,
			set = function(v) ns.Set("behavior.groupQuests", v) end,
			choices = function()
				return {
					{ value = "ask", name = L["Ask me at each"], desc = L["The guide asks when you reach one."] },
					{ value = "do", name = L["Do them with a group"], desc = L["A party levelling together."] },
					{ value = "skip", name = L["Skip them"], desc = L["Solo: the route leaves them out."] },
				}
			end })
		p.Keep = keepLine(p)
	end,
	layout = function(P)
		local heroH = layoutCompactHero(P.Hero)
		local p = P.Body
		local dungeons, quests = dungeonsShown(), groupQuestsShown()
		local y = layGroup(F.Dungeons, 0, dungeons)
		y = layGroup(F.GroupQuests, (dungeons and quests) and y + 18 or y, quests) + 14
		place(p.Keep, 0, y)
		return heroH, y + p.Keep:GetStringHeight()
	end,
	title = function(P) return P.Hero.Title:GetText() end,
}

-- 5. Your route ----------------------------------------------------------------

-- The styles: the setting's value, the name, what it does, the
-- Recommended tag. Options' Route style dropdown writes the same setting;
-- Nav/Walk.lua searches its walks again when it changes.
local STYLES = {
	{ "fastest", L["Fastest"], L["The shortest walk. Cuts across fields and goes straight over hills."] },
	{ "balanced", L["Balanced"], L["Takes roads when they aren't much longer, and goes round steep hills."], true },
	{ "roads", L["Roads"], L["Stays on roads, even when it's longer. Slower, but easy to follow."] },
}
local MAP_H = 150
local OPT_L, OPT_R, OPT_T, OPT_B = 12, 14, 8, 9
local OPT_TEXT_X = OPT_L + 16 + 12
local OPT_TEXT_W = CW - OPT_TEXT_X - OPT_R

-- The style in use: the router reads anything but Fastest or Roads as
-- Balanced, the default.
local function routeStyle()
	local s = ns.Get("nav.routeStyle")
	if s == "fastest" or s == "roads" then return s end
	return "balanced"
end

local function paintStyle(c)
	local on = routeStyle() == c.psStyle
	c.psSelected = on
	c.Fill:SetShown(on)
	c.Bar:SetShown(on)
	c.Dot:SetShown(on)
	paintOutline(c, Theme.Wash("divider"))
	if on then c.Ring:SetVertexColor(Theme.Accent()) else c.Ring:SetVertexColor(Theme.Color("textMuted")) end
	W.Color(c.Name, "text")
	if c.psChip then W.SetChip(c.psChip, L["Recommended"], "accent") end
end

-- A style's row: the radio, its name (and tag), what it does. Click sets
-- the style live; right-click puts Balanced back.
local function styleRow(p, st)
	local c = CreateFrame("Button", nil, p)
	c:SetWidth(CW)
	c.Fill = W.Fill(c, "panelAlt", "BACKGROUND", -6)
	W.Hover(c)
	outline(c)
	c.Bar = solid(c, "ARTWORK", 2)
	c.Bar:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
	c.Bar:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", 0, 0)
	c.Bar:SetWidth(2)
	W.Color(c.Bar, "accent")
	c.psStyle = st[1]
	-- The radio: a ring, the accent dot in it while chosen.
	c.Ring = W.Tex(c, "ARTWORK", "skin-ring", nil, 0)
	c.Ring:SetSize(19, 19) -- the ring's ink is 14px of it
	c.Ring:SetPoint("CENTER", c, "LEFT", OPT_L + 8, 0)
	c.Dot = W.Tex(c, "ARTWORK", "circle", "accent", 2)
	c.Dot:SetSize(7, 7)
	c.Dot:SetPoint("CENTER", c.Ring, "CENTER", 0, 0)
	c.Name = W.Text(c, "heading", "text")
	c.Name:SetText(st[2])
	c.Desc = para(c, "note", "textMuted", OPT_TEXT_W, 3)
	c.Desc:SetText(st[3])
	if st[4] then c.psChip = W.Chip(c) end
	c:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	c:SetScript("OnClick", function(self, button)
		if button == "RightButton" then ns.Set("nav.routeStyle", nil) else ns.Set("nav.routeStyle", self.psStyle) end
	end)
	W.Painter(c, paintStyle)
	return c
end

local function layoutStyleRow(c)
	paintStyle(c)
	local chipH = c.psChip and W.CHIP_H or 0
	local nameH = max(c.Name:GetStringHeight(), chipH)
	c.Name:ClearAllPoints()
	c.Name:SetPoint("LEFT", c, "TOPLEFT", OPT_TEXT_X, -(OPT_T + nameH / 2))
	if c.psChip then
		c.psChip:ClearAllPoints()
		c.psChip:SetPoint("LEFT", c.Name, "RIGHT", 8, 0)
	end
	place(c.Desc, OPT_TEXT_X, OPT_T + nameH + 2)
	local h = OPT_T + nameH + 2 + c.Desc:GetStringHeight() + OPT_B
	c:SetHeight(h)
	return h
end

-- What the route page and the setting changes need of the map.
local routeMap, paintMap, redrawRoute
do
	-- The map: the polestar.guide front page's route demo, as the site draws it
	-- (polestar-site: components/landing/Demo.tsx, lib/route-demo.json and the
	-- route card's styles), one example for everyone: on the Elwynn Forest
	-- painting, Northshire Abbey's front steps to the Westfall border bridge,
	-- each route style's walk (the site's illustrations traced over the painted
	-- map, its yards), corners rounded by 4 of the painting's 1002 px as the
	-- site's roadPath rounds them. The chosen style's walk shows as the site's
	-- dotted road with the white trail over it; a switch leaves the last style's
	-- walk as a faint dashed ghost, fades the new road in and replays the trail
	-- from the abbey; under reduced motion all of it at once.
	local DEMO_MAP, DEMO_GOAL = 1429, 1436 -- Elwynn Forest; Westfall, where the walk goes
	local DEMO = { -- map percent, x1, y1, x2, y2, ...
		fastest = { yards = 1359, 48.17, 42.26, 47.52, 43.81, 47.3, 44.3, 47.07, 44.79, 46.35, 46.23, 46.12, 46.72, 45.93, 47.24, 45.79, 47.67, 45.65, 48.22, 45.61, 48.8, 45.61, 49.1, 45.56, 49.68, 45.42, 50.22, 45.3, 50.52, 45.08, 51.02, 44.81, 51.44, 34.53, 64.88, 34.23, 65.26, 33.91, 65.62, 19.66, 81.05 },
		balanced = { yards = 1519, 48.17, 42.26, 47.99, 42.61, 47.82, 42.98, 47.67, 43.36, 47.65, 43.41, 47.5, 43.85, 47.32, 44.28, 47.1, 44.75, 46.87, 45.17, 46.77, 45.35, 46.51, 45.81, 46.25, 46.26, 46.16, 46.42, 45.93, 46.88, 45.76, 47.38, 45.67, 47.91, 45.71, 48.43, 45.82, 48.95, 45.95, 49.45, 46.11, 50.0, 46.28, 50.51, 46.33, 50.66, 46.41, 51.19, 46.3, 51.71, 41.82, 62.81, 41.6, 63.3, 41.34, 63.76, 37.5, 69.78, 37.26, 70.24, 37.08, 70.77, 36.87, 71.6, 36.75, 72.16, 36.68, 72.75, 36.6, 73.34, 36.49, 73.91, 36.47, 73.99, 36.3, 74.53, 36.09, 75.04, 36.06, 75.11, 35.8, 75.56, 35.49, 75.92, 35.37, 76.03, 35.03, 76.34, 34.68, 76.64, 34.48, 76.8, 34.12, 77.06, 33.74, 77.24, 33.32, 77.4, 32.93, 77.52, 32.54, 77.59, 32.13, 77.65, 31.74, 77.69, 31.34, 77.74, 30.84, 77.8, 30.44, 77.82, 30.04, 77.78, 29.84, 77.75, 29.44, 77.69, 29.04, 77.64, 28.84, 77.6, 28.44, 77.55, 28.05, 77.49, 27.84, 77.45, 27.44, 77.41, 27.05, 77.39, 26.75, 77.39, 26.35, 77.41, 25.95, 77.45, 25.65, 77.49, 25.25, 77.55, 24.85, 77.6, 24.65, 77.64, 24.26, 77.73, 23.87, 77.88, 23.73, 77.95, 23.35, 78.14, 22.97, 78.32, 22.74, 78.42, 22.36, 78.61, 21.98, 78.82, 21.73, 78.97, 21.37, 79.22, 21.02, 79.51, 20.9, 79.62, 20.57, 79.96, 20.25, 80.32, 19.66, 81.05 },
		roads = { yards = 1596, 48.17, 42.26, 47.99, 42.61, 47.82, 42.98, 47.67, 43.36, 47.65, 43.41, 47.5, 43.85, 47.32, 44.28, 47.1, 44.75, 46.87, 45.17, 46.77, 45.35, 46.51, 45.81, 46.25, 46.26, 46.16, 46.42, 45.93, 46.88, 45.76, 47.38, 45.67, 47.91, 45.71, 48.43, 45.82, 48.95, 45.95, 49.45, 46.11, 50.0, 46.28, 50.51, 46.33, 50.66, 46.51, 51.2, 46.69, 51.73, 46.73, 51.86, 46.89, 52.41, 47.0, 52.98, 47.08, 53.6, 47.11, 54.19, 47.07, 54.78, 46.98, 55.36, 46.93, 55.57, 46.79, 56.13, 46.63, 56.67, 46.59, 56.8, 46.39, 57.32, 46.17, 57.82, 46.14, 57.9, 45.92, 58.4, 45.73, 58.92, 45.69, 59.05, 45.49, 59.56, 45.25, 60.04, 45.17, 60.17, 44.9, 60.62, 44.63, 61.05, 44.49, 61.25, 44.21, 61.68, 43.93, 62.1, 43.8, 62.3, 43.52, 62.73, 43.25, 63.18, 43.17, 63.32, 42.92, 63.78, 42.68, 64.26, 42.65, 64.33, 42.4, 64.8, 42.13, 65.24, 42.1, 65.3, 41.79, 65.65, 41.43, 65.85, 41.31, 65.89, 40.92, 66.01, 40.53, 66.14, 40.31, 66.2, 39.92, 66.32, 39.53, 66.43, 39.31, 66.5, 38.92, 66.62, 38.53, 66.76, 38.47, 66.79, 38.14, 66.96, 37.82, 67.22, 37.55, 67.55, 37.33, 67.96, 37.14, 68.42, 36.98, 68.91, 36.85, 69.47, 36.78, 70.03, 36.77, 70.21, 36.74, 70.81, 36.73, 71.41, 36.73, 71.56, 36.71, 72.15, 36.68, 72.75, 36.6, 73.34, 36.49, 73.91, 36.47, 73.99, 36.3, 74.53, 36.09, 75.04, 36.06, 75.11, 35.8, 75.56, 35.49, 75.92, 35.37, 76.03, 35.03, 76.34, 34.68, 76.64, 34.48, 76.8, 34.12, 77.06, 33.74, 77.24, 33.32, 77.4, 32.93, 77.52, 32.54, 77.59, 32.13, 77.65, 31.74, 77.69, 31.34, 77.74, 30.84, 77.8, 30.44, 77.82, 30.04, 77.78, 29.84, 77.75, 29.44, 77.69, 29.04, 77.64, 28.84, 77.6, 28.44, 77.55, 28.05, 77.49, 27.84, 77.45, 27.44, 77.41, 27.05, 77.39, 26.75, 77.39, 26.35, 77.41, 25.95, 77.45, 25.65, 77.49, 25.25, 77.55, 24.85, 77.6, 24.65, 77.64, 24.26, 77.73, 23.87, 77.88, 23.73, 77.95, 23.35, 78.14, 22.97, 78.32, 22.74, 78.42, 22.36, 78.61, 21.98, 78.82, 21.73, 78.97, 21.37, 79.22, 21.02, 79.51, 20.9, 79.62, 20.57, 79.96, 20.25, 80.32, 19.66, 81.05 },
	}
	local ROUTE_STYLES = { "fastest", "balanced", "roads" }
	local LAYER_W = 1002 -- the painting's width in its own px (the site's stroke units)
	local REPLAY, ROAD_FADE, GHOST_FADE, GHOST_ALPHA = 1.6, 0.5, 0.9, 0.55
	-- The site's strokes, in the painting's px: the trail 2.4 wide over a dark
	-- glow; the road 1.4 wide, 1 on and 3.2 off; the ghost 1.3 wide, 2.5 on and
	-- 3 off.
	local TRAIL_W, ROAD_W, ROAD_ON, ROAD_OFF, GHOST_W, GHOST_ON, GHOST_OFF = 2.4, 1.4, 1, 3.2, 1.3, 2.5, 3
	-- The painting zoomed so the walks take WALKS_H of the map's height, their
	-- middle at WALKS_X of its width.
	local WALKS_H, WALKS_X = 0.82, 0.3

	-- The box round every style's walk, in map percent.
	local function walkBounds()
		local x0, y0, x1, y1 = 100, 100, 0, 0
		for _, s in ipairs(ROUTE_STYLES) do
			local w = DEMO[s]
			for i = 1, #w, 2 do
				x0, x1 = min(x0, w[i]), max(x1, w[i])
				y0, y1 = min(y0, w[i + 1]), max(y1, w[i + 1])
			end
		end
		return x0, y0, x1, y1
	end

	-- The pooled line `i` of a set on `parent`, made once.
	local function poolLine(parent, set, i, sub, soft)
		local l = set[i]
		if not l then
			l = parent:CreateLine(nil, "ARTWORK", nil, sub)
			if soft then l:SetTexture(NAV_MEDIA .. "line-soft") else l:SetColorTexture(1, 1, 1, 1) end
			set[i] = l
		end
		return l
	end

	-- Calls fn(ax, ay, bx, by) for each stretch of a polyline (px, x1, y1, ...)
	-- between `from` and `to` px along it, `on` px long with `off` between them
	-- (on = nil: one stretch).
	local function stretches(pts, from, to, on, off, fn)
		local at, k = 0, 0
		local nextOn, nextOff = from, on and from + on or to
		for i = 1, #pts - 3, 2 do
			local ax, ay, bx, by = pts[i], pts[i + 1], pts[i + 2], pts[i + 3]
			local len = sqrt((bx - ax) ^ 2 + (by - ay) ^ 2)
			while len > 0 and nextOn < at + len and nextOn < to do
				local s0 = max(nextOn, at)
				local s1 = min(nextOff, at + len, to)
				if s1 > s0 then
					k = k + 1
					local t0, t1 = (s0 - at) / len, (s1 - at) / len
					fn(k, ax + (bx - ax) * t0, ay + (by - ay) * t0, ax + (bx - ax) * t1, ay + (by - ay) * t1)
				end
				if s1 < nextOff then break end
				if not on then break end
				nextOn = nextOff + off
				nextOff = nextOn + on
			end
			at = at + len
		end
		return k
	end

	-- Shows lines 1..n of a set (as fn set them up), hides the rest.
	local function hideFrom(set, n)
		for i = n + 1, #set do set[i]:Hide() end
	end

	local function lineAt(l, parent, ax, ay, bx, by)
		l:SetStartPoint("TOPLEFT", parent, ax, -ay)
		l:SetEndPoint("TOPLEFT", parent, bx, -by)
		l:Show()
	end

	-- The trail: the chosen walk's first `share` (0-1, eased) in white over its
	-- dark glow; the goal's pin turns the accent once it is whole.
	local function drawTrail(m, share)
		m.psShare = share
		local pts = m.psPts and m.psPts[m.psStyle]
		if not pts then return end
		local u, f = m.psUnit, m.Trail
		local r, g, b = Theme.Color("scrim")
		local n = stretches(pts, 0, m.psLen[m.psStyle] * share, nil, nil, function(k, ax, ay, bx, by)
			local glow = poolLine(f, m.TrailGlow, k, 0, true)
			glow:SetThickness(max(5, TRAIL_W * u * 3))
			glow:SetVertexColor(r, g, b, 0.8)
			lineAt(glow, f, ax, ay, bx, by)
			local core = poolLine(f, m.TrailCore, k, 1)
			core:SetThickness(max(2, TRAIL_W * u))
			core:SetVertexColor(1, 1, 1, 0.95)
			lineAt(core, f, ax, ay, bx, by)
		end)
		hideFrom(m.TrailGlow, n)
		hideFrom(m.TrailCore, n)
		local arrived = share >= 0.995
		if arrived then m.EndFill:SetVertexColor(Theme.Accent()) else m.EndFill:SetVertexColor(Theme.Color("sidebar")) end
	end

	-- The road (the chosen walk, dotted) and the ghost (the last style's, dashed).
	local function drawRoads(m)
		local u, s, ghost = m.psUnit, m.psStyle, m.psGhost
		local r, g, b = Theme.Color("scrim")
		local pts = m.psPts[s]
		local n = stretches(pts, 0, m.psLen[s], max(1, ROAD_ON * u), ROAD_OFF * u, function(k, ax, ay, bx, by)
			local l = poolLine(m.Road, m.RoadLines, k, 0)
			l:SetThickness(max(1.5, ROAD_W * u))
			l:SetVertexColor(r * 0.5 + 0.02, g * 0.5 + 0.03, b * 0.5 + 0.05, 0.55)
			lineAt(l, m.Road, ax, ay, bx, by)
		end)
		hideFrom(m.RoadLines, n)
		n = 0
		if ghost and ghost ~= s then
			local gp = m.psPts[ghost]
			n = stretches(gp, 0, m.psLen[ghost], GHOST_ON * u, GHOST_OFF * u, function(k, ax, ay, bx, by)
				local sh = poolLine(m.Ghost, m.GhostShadow, k, 0, true)
				sh:SetThickness(max(3, GHOST_W * u * 2.5))
				sh:SetVertexColor(r, g, b, 0.6)
				lineAt(sh, m.Ghost, ax, ay, bx, by)
				local l = poolLine(m.Ghost, m.GhostLines, k, 1)
				l:SetThickness(max(1.5, GHOST_W * u))
				l:SetVertexColor(1, 1, 1, 0.75)
				lineAt(l, m.Ghost, ax, ay, bx, by)
			end)
		end
		hideFrom(m.GhostLines, n)
		hideFrom(m.GhostShadow, n)
	end

	-- The note: where the walk goes and its yards, as the site's "Go to
	-- Westfall" (the arrow card's words).
	local function noteWalk(m)
		local C = ns.Compat
		local goal = C and C.MapName and C.MapName(DEMO_GOAL) or "Westfall"
		m.Note:SetText(L["Go to"] .. " " .. colored("place", goal) .. " \194\183 " .. (L["%d yd"]):format(DEMO[m.psStyle].yards))
	end

	-- The walk's ends as the site's legs: the start in the accent, the goal in
	-- the sidebar's colour until the trail reaches it (drawTrail).
	local function legs(m)
		m.StartFill:SetVertexColor(Theme.Accent())
		m.StartRing:SetVertexColor(1, 0.965, 0.87, 1)
		m.EndRing:SetVertexColor(1, 1, 1, 0.7)
	end

	function routeMap(p)
		local m = CreateFrame("Frame", nil, p)
		m:SetSize(CW, MAP_H)
		m.Art = UI.ZoneArt.Create(m, CW, MAP_H, "bg")
		m.Art:SetPoint("TOPLEFT", m, "TOPLEFT", 0, 0)
		m.Art.psZoom = 1
		m.Art.psFocusY = MAP_H / 2
		m.Art.Fade:Hide()
		m.Art.Rule:Hide()
		m.Draw = CreateFrame("Frame", nil, m)
		m.Draw:SetAllPoints(m)
		m.Draw:SetFrameLevel(m.Art.Over:GetFrameLevel() + 1)
		local d = m.Draw
		-- The readout (the zone, then where the walk goes and its yards) on its
		-- ground: dark on the right (the walks are on the left of
		-- the painting), clear by 60 %.
		m.Vig1 = solid(d, "BACKGROUND", -4)
		m.Vig1:SetPoint("TOPRIGHT", d, "TOPRIGHT", 0, 0)
		m.Vig1:SetPoint("BOTTOMRIGHT", d, "BOTTOMRIGHT", 0, 0)
		m.Vig1:SetWidth(floor(CW * 0.34))
		m.Vig2 = solid(d, "BACKGROUND", -4)
		m.Vig2:SetPoint("TOPRIGHT", m.Vig1, "TOPLEFT", 0, 0)
		m.Vig2:SetPoint("BOTTOMRIGHT", m.Vig1, "BOTTOMLEFT", 0, 0)
		m.Vig2:SetWidth(floor(CW * 0.2))
		-- The ghost, the road and the trail, each its own layer to fade.
		for _, k in ipairs({ "Ghost", "Road", "Trail" }) do
			m[k] = CreateFrame("Frame", nil, d)
			m[k]:SetAllPoints(d)
		end
		m.GhostLines, m.GhostShadow, m.RoadLines, m.TrailCore, m.TrailGlow = {}, {}, {}, {}, {}
		-- The trail replays eased as the site's (cubic out).
		m.psOnValue = function(self, v) drawTrail(self, 1 - (1 - v) ^ 3) end
		local top = CreateFrame("Frame", nil, d)
		top:SetAllPoints(d)
		m.Start = CreateFrame("Frame", nil, top)
		m.Start:SetSize(9, 9)
		m.StartRing = W.Tex(m.Start, "OVERLAY", "circle", nil, 0)
		m.StartRing:SetAllPoints(m.Start)
		m.StartFill = W.Tex(m.Start, "OVERLAY", "circle", nil, 1)
		m.StartFill:SetSize(7, 7)
		m.StartFill:SetPoint("CENTER", m.Start, "CENTER", 0, 0)
		m.End = CreateFrame("Frame", nil, top)
		m.End:SetSize(11, 11)
		m.EndRing = W.Tex(m.End, "OVERLAY", "circle", nil, 0)
		m.EndRing:SetAllPoints(m.End)
		m.EndFill = W.Tex(m.End, "OVERLAY", "circle", nil, 1)
		m.EndFill:SetSize(9, 9)
		m.EndFill:SetPoint("CENTER", m.End, "CENTER", 0, 0)
		m.Place = W.Text(top, "display", "text")
		m.Place:SetPoint("TOPRIGHT", d, "TOPRIGHT", -14, -12)
		m.Place:SetWidth(floor(CW * 0.4))
		m.Place:SetJustifyH("RIGHT")
		m.Place:SetWordWrap(false)
		m.Note = para(top, "note", "textDim", floor(CW * 0.4), 2)
		m.Note:SetJustifyH("RIGHT")
		m.Note:SetPoint("TOPRIGHT", m.Place, "BOTTOMRIGHT", 0, -4)
		outline(m)
		W.Painter(m, function(self)
			local s1, s2, s3 = Theme.Color("scrim")
			hgrad(self.Vig1, s1, s2, s3, 0.35, s1, s2, s3, 0.85)
			hgrad(self.Vig2, s1, s2, s3, 0, s1, s2, s3, 0.35)
			legs(self)
			if self.psPts then
				drawRoads(self)
				drawTrail(self, self.psShare or 1)
			end
			paintOutline(self, Theme.Wash("border"))
		end)
		return m
	end

	function paintMap(m)
		local x0, y0, x1, y1 = walkBounds()
		local fx, fy = (x0 + x1) / 2, (y0 + y1) / 2
		m.Art.psZoom = 1
		local painted = UI.ZoneArt.Paint(m.Art, DEMO_MAP, fx, fy, 3) and true or false
		local cv = painted and m.Art.psCanvas
		if cv then
			-- Zoomed so the walks take WALKS_H of the height, their middle as
			-- near WALKS_X of the width as the painting's edge allows, clear of
			-- the readout.
			m.Art.psZoom = max(1, MAP_H * WALKS_H / max(1, (y1 - y0) * cv[4] / 100))
			painted = UI.ZoneArt.Paint(m.Art, DEMO_MAP, fx, fy, 3) and true or false
			cv = painted and m.Art.psCanvas
			if cv then
				painted = UI.ZoneArt.Paint(m.Art, DEMO_MAP, fx + (CW * (0.5 - WALKS_X)) / cv[3] * 100, fy, 3) and true or false
				cv = painted and m.Art.psCanvas
			end
		end
		local sx, sy, ox, oy
		if cv then
			sx, sy, ox, oy = cv[3] / 100, cv[4] / 100, cv[1], cv[2]
		else
			-- The band stands in: the walks' shape kept (a zone map is about 3:2).
			local k = MAP_H * WALKS_H / (y1 - y0)
			sx, sy = k * 1.5, k
			ox, oy = CW * WALKS_X - fx * sx, MAP_H / 2 - fy * sy
		end
		m.psUnit = sx * 100 / LAYER_W -- screen px per painting px
		m.psPts, m.psLen = {}, {}
		for _, s in ipairs(ROUTE_STYLES) do
			local w, pts, len = DEMO[s], {}, 0
			for i = 1, #w, 2 do
				local n = #pts
				pts[n + 1], pts[n + 2] = ox + w[i] * sx, oy + w[i + 1] * sy
				if n > 0 then len = len + sqrt((pts[n + 1] - pts[n - 1]) ^ 2 + (pts[n + 2] - pts[n]) ^ 2) end
			end
			m.psPts[s], m.psLen[s] = pts, len
		end
		local pts = m.psPts.balanced
		m.Start:ClearAllPoints()
		m.Start:SetPoint("CENTER", m.Draw, "TOPLEFT", pts[1], -pts[2])
		m.End:ClearAllPoints()
		m.End:SetPoint("CENTER", m.Draw, "TOPLEFT", pts[#pts - 1], -pts[#pts])
		m.psStyle, m.psGhost = routeStyle(), nil
		Anim.Stop(m, "value")
		m.Ghost:SetAlpha(GHOST_ALPHA)
		m.Road:SetAlpha(1)
		legs(m)
		drawRoads(m)
		drawTrail(m, 1)
		local C = ns.Compat
		m.Place:SetText(C and C.MapName and C.MapName(DEMO_MAP) or "Elwynn Forest")
		noteWalk(m)
	end

	-- A new style: the last one's walk stays as the ghost, the new road fades in
	-- and the trail replays from the abbey (the site's switch); under reduced
	-- motion all at once.
	function redrawRoute(m)
		if not (m and m.psPts) then return end
		local s = routeStyle()
		if s == m.psStyle then return end
		m.psGhost, m.psStyle = m.psStyle, s
		noteWalk(m)
		drawRoads(m)
		if Anim.Reduced() then
			m.Ghost:SetAlpha(GHOST_ALPHA)
			m.Road:SetAlpha(1)
			Anim.Stop(m, "value")
			drawTrail(m, 1)
			return
		end
		Anim.To(m.Road, "alpha", 0, 1, ROAD_FADE, "out")
		Anim.To(m.Ghost, "alpha", 1, GHOST_ALPHA, GHOST_FADE, "out")
		Anim.To(m, "value", 0, 1, REPLAY, "linear")
	end
end

PAGES[#PAGES + 1] = {
	key = "route",
	shown = function() return full end,
	build = function(P)
		compactHero(P.Hero, L["Your route"], L["How the arrow walks you, and how the way shows on your maps."])
		local p = P.Body
		p.Map = routeMap(p)
		F.RouteMap = p.Map
		F.Styles = {}
		for i, st in ipairs(STYLES) do F.Styles[i] = styleRow(p, st) end
		p.Foot = para(p, "note", "textMuted", CW, 3)
		p.Foot:SetText(L["Every style keeps you out of enemy towns and zones far above your level."])
		-- The route line's look, with the route lines (Maps/RouteLines.lua).
		buildLines(p)
		p.Keep = keepLine(p)
	end,
	layout = function(P)
		local heroH = layoutCompactHero(P.Hero)
		local p = P.Body
		place(p.Map, 0, 0)
		paintMap(p.Map)
		local y = MAP_H + 10
		for _, c in ipairs(F.Styles) do
			place(c, 0, y)
			y = y + layoutStyleRow(c) + 6
		end
		y = y - 6 + 8
		place(p.Foot, 0, y)
		y = y + p.Foot:GetStringHeight() + 16
		y = layLines(p, y) + 14
		place(p.Keep, 0, y)
		return heroH, y + p.Keep:GetStringHeight()
	end,
	title = function(P) return P.Hero.Title:GetText() end,
}

-- 6. Your look -------------------------------------------------------------------

-- What the window and the gamepad need of the look page.
local loadLooks, previewLook, paintLookRow
do
	-- The looks (ui.skin): Theme.SkinChoices, the built-ins and then the skin
	-- addons (which it loads), as a list of rows in up to three columns of
	-- eight, each a radio ring and the look's name, beside a large preview of
	-- the look under the pointer or the gamepad's focus, else the one in use.
	-- The settings' skin picker draws it (Theme.DrawSkinCard, Polestar_Options)
	-- the way the Theme page draws its cards; without that addon the window
	-- itself shows the look once picked. None of it loads before the page first
	-- shows: the list keeps room for eight rows, so the window's height does not
	-- wait for it. A click puts the look on, and every Polestar window, this
	-- one with it, wears it at once; right-click (or the gamepad's Y) puts the
	-- house look back.
	local PREVIEW_W, PREVIEW_ART_H = 248, 140
	local LIST_X = PREVIEW_W + 16
	local LIST_W = CW - LIST_X
	local LOOK_ROW_H, LOOK_ROW_GAP, LOOK_ROWS, LOOK_MAX_COLS = 24, 2, 8, 3
	local LOOK_LIST_H = LOOK_ROWS * LOOK_ROW_H + (LOOK_ROWS - 1) * LOOK_ROW_GAP

	-- What each built-in look is; a skin addon says it itself (its desc).
	local LOOK_LINES = {
		polestar = L["Polestar's own: a night sky, gold accents."],
		halo = L["No frame, a soft dark veil."],
		hearth = L["An inn by the fire: warm wood, ember light, parchment text."],
		forever = L["Forever's own art: bronze metal frames."],
		blizzard = L["The game's frames in their modern art."],
		classic = L["The original game's frames."],
	}

	local looksLoaded = false

	-- The looks and the settings' skin picker, loaded once (out of combat: an
	-- addon loads nowhere near a fight; the window steps aside for one anyway).
	function loadLooks()
		if looksLoaded or inCombat() then return end
		looksLoaded = true
		if UI.LoadOptions then pcall(UI.LoadOptions) end
	end

	-- The look in use (a saved look whose addon is gone draws the house look).
	local function lookInUse()
		return Theme.SkinId and Theme.SkinId() or Theme.SkinKey()
	end

	-- Draws look `id` in the preview, with its name and line under it.
	function previewLook(p, id)
		if not (p.Preview and id) then return end
		p.psPreviewed = id
		local info = Theme.SkinInfo and Theme.SkinInfo(id)
		p.PreviewName:SetText(info and info.name or id)
		p.PreviewLine:SetText(LOOK_LINES[id] or (info and known(info.desc)) or "")
		local drawn = false
		if Theme.DrawSkinCard and info then
			drawn = pcall(Theme.DrawSkinCard, p.Preview.Art, id)
		end
		p.Preview.Art:SetShown(drawn and true or false)
		p.Preview.Plain:SetShown(not drawn)
		p.Preview.Plain:SetText(info and info.name or id)
	end

	function paintLookRow(r)
		local on = lookInUse() == r.psLook
		r.psSelected = on
		r.Dot:SetShown(on)
		if on then r.Ring:SetVertexColor(Theme.Accent()) else r.Ring:SetVertexColor(Theme.Color("textMuted")) end
		W.Color(r.Name, on and "text" or "textDim")
	end

	local function lookRow(p)
		local r = CreateFrame("Button", nil, p)
		W.Hover(r)
		r.Ring = W.Tex(r, "ARTWORK", "skin-ring", nil, 0)
		r.Ring:SetSize(17, 17)
		r.Ring:SetPoint("CENTER", r, "LEFT", 6 + 7, 0)
		r.Dot = W.Tex(r, "ARTWORK", "circle", "accent", 2)
		r.Dot:SetSize(6, 6)
		r.Dot:SetPoint("CENTER", r.Ring, "CENTER", 0, 0)
		r.Name = W.Text(r, "label", "textDim")
		r.Name:SetPoint("LEFT", r, "LEFT", 6 + 14 + 8, 0)
		r.Name:SetPoint("RIGHT", r, "RIGHT", -4, 0)
		r.Name:SetJustifyH("LEFT")
		r.Name:SetWordWrap(false)
		r:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		r:SetScript("OnClick", function(self, button)
			if button == "RightButton" then ns.Set("ui.skin", nil) else ns.Set("ui.skin", self.psLook) end
			previewLook(p, lookInUse())
		end)
		-- The pointer previews a look before it is picked.
		r:SetScript("OnEnter", function(self) previewLook(p, self.psLook) end)
		r:SetScript("OnLeave", function() previewLook(p, lookInUse()) end)
		W.Painter(r, function(self) if self.psLook then paintLookRow(self) end end)
		return r
	end

	-- The gamepad's button names (gamepad.glyphs), while a gamepad is in use.
	local function gamepadShown()
		local G = ns.Gamepad
		return G ~= nil and G.IsActive ~= nil and G.IsActive() and ns.GetDefault("gamepad.glyphs") ~= nil
	end

	PAGES[#PAGES + 1] = {
		key = "look",
		shown = function() return full end,
		build = function(P)
			compactHero(P.Hero, L["Your look"],
				L["Every Polestar window wears it, this one too. Colours, fonts and each look's versions are in Settings, Theme."], true)
			local p = P.Body
			F.LookPage = p
			F.Skins = {}
			-- The preview: the look drawn as the settings' Theme page draws it.
			p.Preview = CreateFrame("Frame", nil, p)
			p.Preview:SetSize(PREVIEW_W, PREVIEW_ART_H)
			outline(p.Preview)
			p.Preview.Ground = solid(p.Preview, "BACKGROUND", -7)
			p.Preview.Ground:SetAllPoints(p.Preview)
			p.Preview.Art = CreateFrame("Frame", nil, p.Preview)
			p.Preview.Art:SetPoint("TOPLEFT", p.Preview, "TOPLEFT", 1, -1)
			p.Preview.Art:SetSize(PREVIEW_W - 2, PREVIEW_ART_H - 2)
			if p.Preview.Art.SetClipsChildren then p.Preview.Art:SetClipsChildren(true) end
			p.Preview.Plain = W.Text(p.Preview, "title", "textDim")
			p.Preview.Plain:SetPoint("CENTER", p.Preview, "CENTER", 0, 0)
			W.Painter(p.Preview, function(self)
				paintOutline(self, Theme.Wash("border"))
				local r, g, b = Theme.Color("scrim")
				self.Ground:SetVertexColor(r, g, b, 1)
			end)
			p.PreviewName = W.Text(p, "heading", "text")
			p.PreviewName:SetJustifyH("LEFT")
			p.PreviewLine = para(p, "note", "textMuted", PREVIEW_W, 3)
			buildSchemes(p)
			F.Glyphs = optionGroup(p, { title = L["Button names"],
				note = L["The names and shapes Polestar shows for your gamepad's buttons. Automatic reads them off the gamepad."],
				get = function() return oneOf("gamepad.glyphs", { "auto", "xbox", "playstation" }, "auto") end,
				set = function(v) ns.Set("gamepad.glyphs", v) end,
				choices = function()
					return {
						{ value = "auto", name = L["Automatic"] },
						{ value = "xbox", name = L["Xbox (A, B, X, Y)"] },
						{ value = "playstation", name = L["PlayStation (shapes)"] },
					}
				end })
			p.Keep = keepLine(p)
		end,
		layout = function(P)
			local heroH = layoutCompactHero(P.Hero)
			local p = P.Body
			place(p.Preview, 0, 0)
			place(p.PreviewName, 0, PREVIEW_ART_H + 10)
			p.PreviewName:SetWidth(PREVIEW_W)
			place(p.PreviewLine, 0, PREVIEW_ART_H + 10 + p.PreviewName:GetStringHeight() + 3)
			-- The list, once the page has shown (the looks load then).
			local choices = looksLoaded and Theme.SkinChoices() or {}
			local cols = min(LOOK_MAX_COLS, max(1, math.ceil(#choices / LOOK_ROWS)))
			local colW = floor((LIST_W - 8 * (cols - 1)) / cols)
			for i, ch in ipairs(choices) do
				local r = F.Skins[i] or lookRow(p)
				F.Skins[i] = r
				r.psLook = ch.value
				r.Name:SetText(ch.text)
				local col, row = floor((i - 1) / LOOK_ROWS), (i - 1) % LOOK_ROWS
				r:SetShown(col < cols)
				r:SetSize(colW, LOOK_ROW_H)
				place(r, LIST_X + col * (colW + 8), row * (LOOK_ROW_H + LOOK_ROW_GAP))
				paintLookRow(r)
			end
			for i = #choices + 1, #F.Skins do F.Skins[i]:Hide() end
			if looksLoaded then previewLook(p, lookInUse()) end
			local y = max(LOOK_LIST_H, PREVIEW_ART_H + 10 + p.PreviewName:GetStringHeight() + 3 + p.PreviewLine:GetStringHeight())
			-- The colour scheme: the house look's alone (a skin that brings its
			-- own ground colours leaves a scheme nothing to change).
			local house = Theme.SkinKey() == "polestar" and not (Theme.SkinScheme and Theme.SkinScheme()) and not Theme.SkinToken("bg")
			y = laySchemes(p, house and y + 18 or y, house)
			local pad = gamepadShown()
			y = layGroup(F.Glyphs, pad and y + 18 or y, pad) + 14
			place(p.Keep, 0, y)
			return heroH, y + p.Keep:GetStringHeight()
		end,
		title = function(P) return P.Hero.Title:GetText() end,
	}
end

-- 7. Finish ----------------------------------------------------------------------

-- The guide Start guide opens (Engine.StartingGuide, else the suggestion),
-- and whether the guide window shows it already.
local function startingGuide()
	local G, E = ns.Guides, ns.Engine
	local id = E and E.StartingGuide and E.StartingGuide() or (G and G.Suggest and G.Suggest())
	local open = id and E and E.GetGuide and E.GetGuide()
	return id, type(open) == "table" and open.id == id
end

local function startSuggested()
	local E = ns.Engine
	local id = startingGuide()
	close()
	if id and E and E.StartGuide then
		E.StartGuide()
	elseif id and E and E.OpenTab then
		E.OpenTab(id)
	elseif id and E and E.SetGuide then
		E.SetGuide(id)
	else
		UI.ShowPicker()
		return
	end
	ns.Fire("SHOW_FRAME")
end

-- A note under a hairline: its glyph, a heading, its line, a link on the
-- right if any.
local NOTE_X = 18 + 10

local function noteRow(p, glyph, color, heading)
	local n = {}
	n.Rule = W.Divider(p)
	n.Glyph = W.Tex(p, "ARTWORK", glyph, color)
	n.Glyph:SetSize(14, 14)
	n.Head = W.Text(p, "heading", "text")
	n.Head:SetText(heading)
	n.Text = para(p, "note", "textMuted", CW - NOTE_X, 3)
	return n
end

-- Lays note `n` out on page `p` from `y` down (its hairline at `y`), shown
-- or not. -> the y under it
local function layNote(p, n, y, shown)
	for _, k in ipairs({ "Rule", "Glyph", "Head", "Text", "Link" }) do
		if n[k] then n[k]:SetShown(shown) end
	end
	if not shown then return y end
	n.Rule:ClearAllPoints()
	n.Rule:SetPoint("TOPLEFT", p, "TOPLEFT", 0, -y)
	n.Rule:SetPoint("TOPRIGHT", p, "TOPRIGHT", 0, -y)
	local top = y + 10
	place(n.Glyph, 0, top + 2)
	place(n.Head, NOTE_X, top)
	local linkW = n.Link and (n.Link:GetWidth() + 16) or 0
	n.Text:SetWidth(CW - NOTE_X - linkW)
	place(n.Text, NOTE_X, top + n.Head:GetStringHeight() + 3)
	if n.Link then
		n.Link:ClearAllPoints()
		n.Link:SetPoint("TOPRIGHT", p, "TOPRIGHT", 0, -(top - 2))
	end
	return top + n.Head:GetStringHeight() + 3 + n.Text:GetStringHeight() + 10
end

PAGES[#PAGES + 1] = {
	key = "finish",
	build = function(P)
		local h = P.Hero
		h:SetHeight(START_H)
		-- The suggested guide's painting fills the hero; without one the
		-- band stands in and the emblem keeps its place on the right.
		h.Art = UI.ZoneArt.Create(h, INNER, START_H, "bg")
		h.Art.psZoom = 1.3
		h.Art:SetPoint("TOPLEFT", h, "TOPLEFT", 0, 0)
		h.Art.Band:ClearAllPoints() -- the stand-in at its own 1:1 height
		h.Art.Band:SetPoint("TOPLEFT", h.Art, "TOPLEFT", 0, 0)
		h.Art.Band:SetPoint("TOPRIGHT", h.Art, "TOPRIGHT", 0, 0)
		h.Art.Band:SetHeight(BAND_H)
		h.Art.Rule:Hide()
		-- The corner the title sits in, darker.
		h.Corner = W.Tex(h.Art.Over, "BACKGROUND", "glow", nil, 1)
		h.Corner:SetSize(INNER * 1.4, START_H * 1.8)
		h.Corner:SetPoint("CENTER", h.Art.Over, "BOTTOMLEFT", 0, 0)
		W.Painter(h.Corner, function(t)
			local r, g, b = Theme.Color("scrim")
			t:SetVertexColor(r, g, b, 0.8)
		end)
		h.Sky = CreateFrame("Frame", nil, h)
		h.Sky:SetAllPoints(h)
		h.Sky:SetFrameLevel(h.Art.Over:GetFrameLevel() + 1)
		h.SkyGround = night(h, h.Sky, START_H, { haze = 0.8, band = 0, bottom = "bg" })
		h.SkyGround.Band:Hide()
		dipper(h.Sky, 400, 52, 0.62, -8)
		emblem(h.Sky, 40, SIDE_X, SIDE_Y, 120, 44)
		h.Text = CreateFrame("Frame", nil, h)
		h.Text:SetAllPoints(h)
		h.Text:SetFrameLevel(h.Sky:GetFrameLevel() + 1)
		h.Title = para(h.Text, "hero", "text", CW, 2)
		h.Chip = W.Chip(h.Text)
		h.For = W.Text(h.Text, "body", "textDim")
		h.For:SetWordWrap(true) -- a second line where the chip leaves too little room
		h.For:SetJustifyH("LEFT")

		local p = P.Body
		p.Pitch = para(p, "body", "textDim", CW, 5)
		-- You're all set: everything chosen works already; then what Start
		-- guide does, or that the guide is open.
		p.Next = CreateFrame("Frame", nil, p)
		p.Next:SetWidth(CW)
		W.Fill(p.Next, "panel", "BACKGROUND", -6)
		outline(p.Next)
		W.Painter(p.Next, function(self) paintOutline(self, Theme.Wash("divider")) end)
		p.Next.Glyph = W.Tex(p.Next, "ARTWORK", "check", "success")
		p.Next.Glyph:SetSize(16, 16)
		p.Next.Glyph:SetPoint("TOPLEFT", p.Next, "TOPLEFT", 12, -12)
		p.Next.Head = W.Text(p.Next, "title", "text")
		p.Next.Head:SetText(L["You're all set"])
		p.Next.Head:SetPoint("TOPLEFT", p.Next, "TOPLEFT", 12 + 24, -10)
		p.Next.Text = para(p.Next, "note", "textDim", CW - 24 - 24, 3)
		p.Next.Text:SetPoint("TOPLEFT", p.Next.Head, "BOTTOMLEFT", 0, -3)

		-- Where it all is later: Settings and its search, Install again.
		p.Later = noteRow(p, "gear", "textMuted", L["Change it later"])
		F.Settings = W.Link(p, L["Settings"], function()
			close()
			UI.ShowOptions()
		end)
		F.Settings.psTip = nil -- it opens the settings, nothing to copy
		p.Later.Link = F.Settings
		p.Beta = noteRow(p, "flag", "warning", L["Our routes are still in beta"])
		p.Beta.Chip = W.Chip(p)
		p.Beta.Chip:SetPoint("LEFT", p.Beta.Head, "RIGHT", 8, 0)
		p.Discord = noteRow(p, "discord", "discord", L["Join us on Discord"])
		-- The invite as a link (the scheme left off); a click opens the copy
		-- window holding it, since the game cannot open links.
		F.Discord = W.Link(p, (ns.DiscordURL:gsub("^%a+://", "")), function() UI.ShowDiscord() end)
		p.Discord.Link = F.Discord
		-- The Recorder: its own addon, pointed to here and never switched on.
		p.Recorder = noteRow(p, "record", "textMuted", L["Help improve the routes"])
		F.Recorder = W.Link(p, L["Recorder"], function()
			close()
			UI.ShowOptions("recorder")
		end)
		F.Recorder.psTip = nil
		p.Recorder.Link = F.Recorder
		p.Packs = noteRow(p, "guides", "textMuted", L["Community guides"])
		F.Browse = W.Link(p, L["Browse guides"], function()
			close()
			UI.ShowPicker()
		end)
		F.Browse.psTip = nil -- it opens the guide menu, nothing to copy
		p.Packs.Link = F.Browse
	end,
	layout = function(P)
		local h, p = P.Hero, P.Body
		local id, g = suggested()
		-- The hero: the painting, or the band with the emblem and the Dipper.
		local painted = false
		if g then
			local fx, fy
			local E = ns.Engine
			if E and E.GuideFocus then fx, fy = E.GuideFocus(id) end
			painted = UI.ZoneArt.Paint(h.Art, g.zone, fx, fy, 1) and true or false
		else
			UI.ZoneArt.Paint(h.Art, nil, nil, nil, 1)
		end
		h.psPainted = painted
		h.Sky:SetShown(not painted)
		h.Corner:SetShown(painted)
		h.Title:SetWidth(painted and CW or CW - 120)
		h.Title:SetText(g and g.title or L["Choose your first guide"])
		local lv = g and UI.LevelRange(g.minLevel, g.maxLevel)
		local chipW = 0
		if lv then
			chipW = W.SetChip(h.Chip, L["Levels"] .. " " .. lv, "accent") + 10
		else
			h.Chip:Hide()
		end
		h.For:SetText(g and forWhom(g) or L["Polestar has no guide to suggest for where you are."])
		h.For:SetWidth(min(W.TextWidth(h.For) + 1, CW - chipW))
		local factY = START_H - 12 - W.CHIP_H
		h.Chip:ClearAllPoints()
		h.Chip:SetPoint("TOPLEFT", h.Text, "TOPLEFT", EDGE, -factY)
		h.For:ClearAllPoints()
		h.For:SetPoint("LEFT", h.Text, "TOPLEFT", EDGE + chipW, -(factY + W.CHIP_H / 2))
		-- Centred on the chip, a wrapped line reaches above it: the title
		-- keeps its 8px over whichever is higher.
		local lift = max(0, (h.For:GetStringHeight() - W.CHIP_H) / 2)
		h.Title:ClearAllPoints()
		h.Title:SetPoint("TOPLEFT", h.Text, "TOPLEFT", EDGE, -(factY - lift - 8 - h.Title:GetStringHeight()))

		-- The page: the pitch, all set and what Start guide does, the notes.
		local y = 8
		local pitch = g and known(g.pitch)
		p.Pitch:SetShown(pitch ~= nil)
		if pitch then
			p.Pitch:SetText(pitch)
			place(p.Pitch, 0, y)
			y = y + p.Pitch:GetStringHeight() + 12
		end
		local _, open = startingGuide()
		local nextLine
		if open then
			nextLine = L["Your guide is open in the guide window on the right. The arrow points at your next stop."]
		else
			nextLine = (L["%s opens the guide window on the right. The arrow points at your first stop."]):format(cmd(g and L["Start guide"] or L["Choose a guide"]))
		end
		p.Next.Text:SetText(L["Everything you chose works already, with no reload."] .. " " .. nextLine)
		place(p.Next, 0, y)
		p.Next:SetHeight(10 + p.Next.Head:GetStringHeight() + 3 + p.Next.Text:GetStringHeight() + 12)
		y = y + p.Next:GetHeight() + 14

		p.Later.Text:SetText((L["Every choice here is in Settings, and its search finds any setting by name. Install opens again from there, or with %s."]):format(cmd("/polestar install")))
		y = layNote(p, p.Later, y, true)

		local beta = ns.routesBeta and true or false
		p.Beta.Text:SetText((L["Played to the end in tests, but not yet by players. If a step is wrong, press %s in the guide window and tell us on Discord."]):format(cmd(L["Skip"])))
		y = layNote(p, p.Beta, y, beta)
		if beta then W.SetChip(p.Beta.Chip, string.upper(L["Beta"]), "warning") else p.Beta.Chip:Hide() end
		p.Recorder.Text:SetText(L["The Polestar Recorder, an optional addon of its own, records your play without names so the routes get better. Its page in Settings says how it works."])
		y = layNote(p, p.Recorder, y, true)
		p.Discord.Text:SetText(L["Feedback, bug reports and news."])
		y = layNote(p, p.Discord, y, true)
		p.Packs.Text:SetText(L["Guides by other players, installed like any addon. They show under Community guides in the guide list."])
		y = layNote(p, p.Packs, y, true)
		setChevronText(F.Start, g and L["Start guide"] or L["Choose a guide"])
		F.Start.psOpen = open
		return START_H, y - 10
	end,
	title = function(P) return P.Hero.Title:GetText() end,
}

-- The pages shown now, in order.
function pageList()
	local out = {}
	for _, pg in ipairs(PAGES) do
		if not pg.shown or pg.shown() then out[#out + 1] = pg end
	end
	return out
end

---------------------------------------------------------------------------
-- The window
---------------------------------------------------------------------------

local render -- forward

-- The hero settles 8px up as it fades in (on open).
local function settle(P)
	Anim.Anchor(P.Hero, "TOPLEFT", P, "TOPLEFT", 0, 0)
	Anim.To(P.Hero, "alpha", 0, 1, Anim.BASE, "out")
	Anim.To(P.Hero, "offset", -8, 0, Anim.BASE, "out")
end

local function go(delta)
	local list = pageList()
	local at = 1
	for i, pg in ipairs(list) do if pg.key == current then at = i end end
	local to = at + delta
	if to > #list then return close() end
	if to < 1 then to = 1 end
	if list[to].key == current then return end
	local from = current
	current = list[to].key
	render(from)
end

local DOT, DOT_ON, DOT_GAP = 4, 16, 6

-- A key's name in the client's language (the game's own), for the footer's tooltips.
local function keyName(key)
	local text = GetBindingText and GetBindingText(key)
	return type(text) == "string" and text ~= "" and text or key
end

-- The footer's main button: Next, or Finish on the last page.
local function primary()
	local _, at, count = WEL.Page()
	if at and count and at >= count then return close() end
	go(1)
end

-- Enter takes the footer's main button, Backspace goes back; every other key
-- goes on to the game, Escape too (the game's close of special windows
-- closes this one). Never in a fight: the window steps aside for one.
local function onKey(self, key)
	local mine = (key == "ENTER" or key == "BACKSPACE") and not inCombat()
	if self.SetPropagateKeyboardInput and not inCombat() then self:SetPropagateKeyboardInput(not mine) end
	if not mine then return end
	if key == "BACKSPACE" then go(-1) else primary() end
end

local function drag(frame)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function() F:StartMoving() end)
	frame:SetScript("OnDragStop", function() F:StopMovingOrSizing() end)
end

local function build()
	F = CreateFrame("Frame", "PolestarWelcome", ns.UIParent)
	F.Groups = {} -- the option cards' groups (optionGroup), repainted as settings change
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(WIDTH)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	F:Hide()
	-- The title the game's looks write in the window's title bar.
	F.psTitle = L["Polestar Install"]
	Theme.Skin(F, "window")
	drag(F)

	-- Over the pages: the ✕ (with a dark disc of its own on a painting).
	local top = CreateFrame("Frame", nil, F)
	top:SetPoint("TOPLEFT", F, "TOPLEFT", 0, 0)
	top:SetPoint("TOPRIGHT", F, "TOPRIGHT", 0, 0)
	top:SetHeight(52)
	top:SetFrameLevel(F:GetFrameLevel() + 40)
	F.Close = W.IconButton(top, "close", 28, L["Close"], close, 12)
	F.Close:SetPoint("TOPRIGHT", F, "TOPRIGHT", -12, -12)
	F.CloseScrim = W.Pill(top, 28, 28)
	F.CloseScrim:SetPoint("CENTER", F.Close, "CENTER", 0, 0)
	W.Painter(F.CloseScrim, function(s) local r, g, b = Theme.Color("scrim"); s:SetColor(r, g, b, 0.6) end)
	F.CloseScrim:SetFrameLevel(top:GetFrameLevel())
	F.Close:SetFrameLevel(top:GetFrameLevel() + 2)
	F.CloseScrim:Hide()
	-- The game's looks put the close button on the window frame's corner
	-- (it clicks this one).
	F.Close:SetShown(not Theme.Kit())

	-- The footer: Skip install (Back on the last page) on the left, "Step 2
	-- of 6" over the step dots in the middle, Back and Next (Start guide and
	-- Finish on the last page) on the right. Each says its key.
	local foot = CreateFrame("Frame", nil, F)
	foot:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 1, 1)
	foot:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -1, 1)
	foot:SetHeight(FOOT_H)
	foot:SetFrameLevel(F:GetFrameLevel() + 30)
	W.Fill(foot, "footer")
	local rule = W.Divider(foot)
	rule:SetPoint("TOPLEFT", foot, "TOPLEFT", 0, 0)
	rule:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 0)
	F.Foot = foot
	F.Skip = W.Button(foot, L["Skip install"], close, { ghost = true })
	F.Skip:SetPoint("LEFT", foot, "LEFT", FOOT_PAD, 0)
	F.Skip.psTip = L["Skip install"]
	F.Skip.psTipLines = { L["Keeps every setting as it is. Install opens again from Settings, or with /polestar install."], keyName("ESCAPE") }
	F.Next = W.Button(foot, L["Next"], function() go(1) end, { primary = true })
	chevron(F.Next)
	setChevronText(F.Next, L["Next"])
	F.Next:SetPoint("RIGHT", foot, "RIGHT", -FOOT_PAD, 0)
	F.Next.psTip = L["Next"]
	F.Next.psTipLines = { keyName("ENTER") }
	F.Back = W.Button(foot, L["Back"], function() go(-1) end)
	F.Back.psTip = L["Back"]
	F.Back.psTipLines = { keyName("BACKSPACE") }
	F.Finish = W.Button(foot, L["Finish"], close, { primary = true })
	F.Finish:SetPoint("RIGHT", foot, "RIGHT", -FOOT_PAD, 0)
	F.Finish.psTip = L["Finish"]
	F.Finish.psTipLines = { L["Everything you chose works already, with no reload."], keyName("ENTER") }
	F.Start = W.Button(foot, L["Start guide"], startSuggested)
	chevron(F.Start)
	F.Start:SetPoint("RIGHT", F.Finish, "LEFT", -8, 0)
	F.Step = W.Text(foot, "caption", "textDim")
	F.Dots = CreateFrame("Frame", nil, foot)
	F.Dots:SetHeight(DOT)
	F.Dots:SetPoint("CENTER", foot, "CENTER", 0, 0)
	F.Dots.list = {}
	-- The pages: each its hero and the page under it on the 32 edge.
	F.pages = {}
	for _, pg in ipairs(PAGES) do
		local P = CreateFrame("Frame", nil, F)
		P:SetWidth(INNER)
		P:SetHeight(1)
		Anim.Anchor(P, "TOPLEFT", F, "TOPLEFT", 1, -1)
		P:Hide()
		local h = CreateFrame("Frame", nil, P)
		h:SetSize(INNER, HELLO_H)
		Anim.Anchor(h, "TOPLEFT", P, "TOPLEFT", 0, 0)
		if h.SetClipsChildren then h:SetClipsChildren(true) end
		drag(h)
		local b = CreateFrame("Frame", nil, P)
		b:SetWidth(CW)
		b:SetHeight(1)
		P.Hero, P.Body, P.psKey = h, b, pg.key
		pg.build(P)
		F.pages[pg.key] = P
	end
	if W.Rim then F.Rim = W.Rim(F) end
	-- Enter and Backspace (onKey); the rest goes on to the game. Every key
	-- goes on again once let go, so none stays held back.
	F:EnableKeyboard(true)
	F:SetScript("OnKeyDown", onKey)
	F:SetScript("OnKeyUp", function(self)
		if self.SetPropagateKeyboardInput and not inCombat() then self:SetPropagateKeyboardInput(true) end
	end)

	F:SetScript("OnShow", function(self)
		Anim.To(self, "alpha", 0, 1, Anim.BASE, "out")
		settle(F.pages[current])
	end)
	-- Any close marks it seen, for the character and the account; stepping
	-- aside for the route choice does not, nor does a cinematic closing it
	-- (it comes back after the cinematic, on the same page), nor Polestar
	-- hiding (its layer hides the window still open: it comes back as it
	-- was). A close tells the windows waiting for it (UI/WhatsNew.lua).
	F:SetScript("OnHide", function(self)
		if stepping or self:IsShown() then return end
		if inCinematic() then
			pending = "asked"
			return
		end
		ns.CharState().welcomeSeen = SEEN
		ns.DB().welcomeSeen = SEEN
		pending = nil
		ns.Fire("WELCOME_CLOSED")
	end)
	ns.CloseOnEscape("PolestarWelcome")
	WEL.frame = F
	-- A gamepad (UI/Gamepad.lua): LB / RB turn the pages, A on Next (Finish on
	-- the last page) by default. Shown by itself, it waits for the player
	-- before it takes the gamepad.
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(F, {
			unasked = function() return unasked end,
			initial = function(rows)
				for i, w in ipairs(rows) do if w == F.Next or w == F.Finish then return i end end
			end,
			prevTab = function() go(-1) end,
			nextTab = function()
				local _, at, count = WEL.Page()
				if at and count and at < count then go(1) end
			end,
			tabsLabel = L["Pages"],
			-- An option card, a look, a colour scheme's card, a route style's
			-- row or a route line's card: Y puts the default back.
			reset = function(w)
				if w and (w.psValue ~= nil or w.psStyle or w.psLook) then
					w:Click("RightButton")
					return true
				end
			end,
			resetLabel = function(w) return (w.psValue ~= nil or w.psStyle or w.psLook) and L["Default"] or nil end,
			-- A look under the gamepad's focus shows in the preview, as under the pointer.
			onFocus = function(w)
				if w and w.psLook and F.LookPage then previewLook(F.LookPage, w.psLook) end
			end,
		})
	end
end

-- The step dots: the current one a 16x4 accent capsule, those done muted,
-- the rest faint. They show where you are; they are not buttons.
local function paintDots(at, n, animate)
	local list = F.Dots.list
	for i = 1, max(n, #list) do
		local d = list[i]
		if i <= n then
			if not d then
				d = W.Pill(F.Dots, DOT, DOT)
				list[i] = d
			end
			local on = i == at
			if on then
				local r, g, b = Theme.Accent()
				d:SetColor(r, g, b, 1)
			elseif i < at then
				local r, g, b = Theme.Color("textMuted")
				d:SetColor(r, g, b, 1)
			else
				local r, g, b = Theme.Color("ink")
				d:SetColor(r, g, b, 0.22)
			end
			local w = on and DOT_ON or DOT
			if animate and d.psW and d.psW ~= w then
				Anim.To(d, "width", d.psW, w, Anim.FAST, "out")
			else
				d:SetWidth(w)
			end
			d.psW = w
			d:Show()
		elseif d then
			d:Hide()
		end
	end
	local total, x = 0, 0
	for i = 1, n do total = total + (i == at and DOT_ON or DOT) + (i > 1 and DOT_GAP or 0) end
	F.Dots:SetWidth(total)
	for i = 1, n do
		list[i]:ClearAllPoints()
		list[i]:SetPoint("LEFT", F.Dots, "LEFT", x, 0)
		x = x + (i == at and DOT_ON or DOT) + DOT_GAP
	end
end

-- Lays every page shown out (the window takes the tallest; a shorter page's
-- body sits in the middle of what is left under its hero, so no blank band
-- gathers over the footer) and shows the current one; `from`: the page
-- left, faded out. The look page's looks load as it first shows.
function render(from)
	local list = pageList()
	local at
	for i, pg in ipairs(list) do if pg.key == current then at = i end end
	if not at then
		at = 1
		current = list[1].key
	end
	if current == "look" then loadLooks() end
	local tallest = 0
	local heights = {}
	for _, pg in ipairs(list) do
		local P = F.pages[pg.key]
		local heroH, bodyH = pg.layout(P)
		P.Hero:SetHeight(heroH)
		P.Body:SetHeight(max(1, bodyH))
		heights[pg.key] = heroH
		tallest = max(tallest, heroH + bodyH + BOTTOM)
	end
	tallest = math.ceil(tallest)
	for _, pg in ipairs(list) do
		local P = F.pages[pg.key]
		local heroH = heights[pg.key]
		local spare = tallest - (heroH + P.Body:GetHeight() + BOTTOM)
		P.Body:ClearAllPoints()
		P.Body:SetPoint("TOPLEFT", P, "TOPLEFT", EDGE, -(heroH + floor(max(0, spare) / 2)))
		P:SetHeight(tallest)
	end
	F:SetHeight(1 + tallest + FOOT_H + 1)
	if F.Rim and W.LayoutRim then W.LayoutRim(F) end
	-- Taller or wider than the screen (a large UI scale, a long
	-- translation): scaled down until it fits, MARGIN clear all round.
	local sw, sh = UIParent:GetWidth() or 0, UIParent:GetHeight() or 0
	local fit = 1
	if sh > 0 then fit = min(fit, (sh - MARGIN * 2) / F:GetHeight()) end
	if sw > 0 then fit = min(fit, (sw - MARGIN * 2) / WIDTH) end
	F:SetScale(max(0.5, fit))
	local animate = from ~= nil and F:IsShown()
	for key, P in pairs(F.pages) do
		if key == current then
			P:Show()
			P.Hero:SetAlpha(1)
			if animate then
				Anim.To(P, "alpha", 0, 1, Anim.BASE, "out")
				Anim.To(P, "offset", -6, 0, Anim.BASE, "out")
			else
				Anim.Stop(P, "offset")
				P:SetAlpha(1)
			end
		elseif animate and key == from then
			Anim.To(P, "alpha", P:GetAlpha(), 0, OUT, "out", function(o) if o.psKey ~= current then o:Hide() end end)
		else
			P:Hide()
		end
	end
	F.Close:SetShown(not Theme.Kit())
	F.CloseScrim:SetShown(current == "finish" and F.pages.finish.Hero.psPainted and not Theme.Kit() or false)

	local last = at == #list
	paintDots(at, #list, animate)
	F.Step:SetText((L["Install  \194\183  Step %d of %d"]):format(at, #list))
	F.Skip:SetShown(not last)
	F.Next:SetShown(not last)
	F.Finish:SetShown(last)
	-- Start guide while there is a guide to start that is not the one open.
	F.Start:SetShown(last and not F.Start.psOpen)
	-- Back sits beside Next; on the last page it takes Skip install's place,
	-- so Finish keeps the right.
	F.Back:SetShown(at > 1)
	F.Back:ClearAllPoints()
	if last then
		F.Back:SetPoint("LEFT", F.Foot, "LEFT", FOOT_PAD, 0)
	else
		F.Back:SetPoint("RIGHT", F.Next, "LEFT", -8, 0)
	end
	-- The step and its dots stay centred unless the buttons come within
	-- 12px; then they centre in the room between them.
	local leftW = last and (at > 1 and F.Back:GetWidth() or 0) or F.Skip:GetWidth()
	local rightW = last and (F.Finish:GetWidth() + (F.Start:IsShown() and (8 + F.Start:GetWidth()) or 0))
		or (F.Next:GetWidth() + (at > 1 and (8 + F.Back:GetWidth()) or 0))
	local lo, hi = FOOT_PAD + leftW + 12, INNER - FOOT_PAD - rightW - 12
	local dw, mid = max(F.Dots:GetWidth(), W.TextWidth(F.Step)), INNER / 2
	if mid - dw / 2 < lo or mid + dw / 2 > hi then mid = (lo + hi) / 2 end
	F.Step:ClearAllPoints()
	F.Step:SetPoint("BOTTOM", F.Foot, "LEFT", mid, 2)
	F.Dots:ClearAllPoints()
	F.Dots:SetPoint("TOP", F.Foot, "LEFT", mid, -6)
	F.psAt, F.psCount = at, #list
end

local try -- forward; defined below

-- Wait for the route choice to close (not for Polestar hiding it with the
-- rest: it stays open then), then try again.
local function afterRouteChoice()
	local RC = UI.RouteChoice
	if not hookedRC and RC and RC.frame then
		hookedRC = true
		RC.frame:HookScript("OnHide", function(self) if not self:IsShown() then try() end end)
	end
end

-- Open now on the current page, or as soon as combat and the route choice
-- allow. A showing at login starts on the first page, with every page while
-- the account has not had its Install, else the character's own. deferred:
-- opened by itself (at login, or after the fight or the route choice that
-- held it back), not on request.
local function open(why, deferred)
	if inCombat() or inCinematic() then
		pending = pending == "asked" and "asked" or why
		return
	end
	if routeChoiceUp() then
		pending = pending == "asked" and "asked" or why
		afterRouteChoice()
		return
	end
	pending = nil
	if why == "login" then
		ns.CharState().welcomeSeen = SEEN -- shown: a reload or logout from here does not repeat it
		full = not accountSeen()
		current = PAGES[1].key
	end
	if not F then build() end
	unasked = deferred and true or false
	render()
	F:Show()
	F:Raise()
end

-- Open Install at `page` (a page key: "welcome", "questing", "groups",
-- "route", "look", "finish"; or its number among the pages shown), the first
-- by default, with every page. Opens even when already seen (About, the
-- settings window, /polestar install, the preview).
function WEL.Show(page)
	full = true
	local list = pageList()
	current = list[1].key
	if type(page) == "number" and list[page] then
		current = list[page].key
	elseif type(page) == "string" then
		for _, pg in ipairs(list) do if pg.key == page then current = page end end
	end
	open("asked")
end

function WEL.Hide()
	pending = nil
	if F then F:Hide() end
end

function WEL.IsShown()
	return F ~= nil and F:IsShown()
end

-- Up, or due and waiting (for the login delay, a fight, a cinematic or the
-- route choice): a window that must not open over it waits for
-- WELCOME_CLOSED.
function WEL.Busy()
	return WEL.IsShown() or pending ~= nil
end

-- Install's building blocks, for the windows in its look
-- (UI/WhatsNew.lua): the night, the emblem, the Dipper, wrapped text,
-- placing, the note rows, and its measures.
WEL.Kit = {
	night = night, emblem = emblem, dipper = dipper, para = para, place = place,
	noteRow = noteRow, layNote = layNote, colored = colored,
	WIDTH = WIDTH, INNER = INNER, CW = CW, EDGE = EDGE, BOTTOM = BOTTOM,
	FOOT_H = FOOT_H, FOOT_PAD = FOOT_PAD, SIDE_X = SIDE_X, SIDE_Y = SIDE_Y, CHERO_TEXT_W = CHERO_TEXT_W,
}

-- The page shown: its key, its place and the number of pages, its title.
function WEL.Page()
	if not F then return nil end
	local title
	for _, pg in ipairs(PAGES) do
		if pg.key == current then title = pg.title(F.pages[current]) end
	end
	return current, F.psAt, F.psCount, title
end

function try()
	if pending == "asked" or (pending and not seen()) then open(pending, true) end
end

-- Hidden to make way for another window or a fight, not closed: it comes
-- back on the same page, with the same pages.
local function stepAside()
	stepping = true
	F:Hide()
	stepping = nil
	pending = "asked"
end

-- A route choice opened over Install: step aside, come back after it.
local function yieldToRouteChoice()
	if not (F and F:IsShown() and routeChoiceUp()) then return end
	stepAside()
	afterRouteChoice()
end

-- A fight: step aside until it is over (PLAYER_REGEN_ENABLED tries again).
local function yieldToFight()
	if F and F:IsShown() then stepAside() end
end

-- The route line cards follow their setting, the route's colour and reduced motion.
local LINE_SETTINGS = { ["nav.lineStyle"] = true, ["nav.dotColor"] = true, ["nav"] = true, ["ui.reduceMotion"] = true, ["ui"] = true, [""] = true }
ns.On("SETTING_CHANGED", function(path)
	if not (F and F.Lines and LINE_SETTINGS[path or ""]) then return end
	for _, c in ipairs(F.Lines) do paintLook(c) end
end)

-- The character's flag, set as the addon loads: due (0) for a new character,
-- seen for one Polestar already knew, so only new characters get it unasked.
ns.OnInit(function()
	local s = ns.CharState()
	if s.welcomeSeen == nil then s.welcomeSeen = ns.IsNewCharacter() and 0 or SEEN end
end)

ns.OnLogin(function()
	local db = ns.DB()
	db.betaNoticeSeen = nil -- the beta notice's flag; Install has its own
	if seen() then return end
	pending = "login"
	if C_Timer and C_Timer.After then ns.After(DELAY, try) else try() end
end)

-- RouteChoice.lua registers first, so its window is already up (or still
-- waiting out combat) when these run.
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	yieldToRouteChoice()
	try()
end)
ns.RegisterEvent("PLAYER_REGEN_DISABLED", yieldToFight)
-- After a cinematic, once the UI is back.
ns.RegisterEvent("CINEMATIC_STOP", function()
	if C_Timer and C_Timer.After then ns.After(1, try) else try() end
end)
ns.On("ROUTE_CHOICE", yieldToRouteChoice)
ns.On("SHOW_WELCOME", function(page) WEL.Show(page) end)

-- The quest switch stands for two settings; the widgets refresh it for the
-- one it is bound to (behavior.autoAccept), this for the other. A route
-- style set anywhere (the rows, Options) moves the rows' pick; the option
-- cards and the looks follow their settings however they change.
ns.On("SETTING_CHANGED", function(path)
	if not F then return end
	if path == "behavior.autoTurnin" and F.AutoQuest then F.AutoQuest:Refresh() end
	if (path == "nav.routeStyle" or path == "nav" or path == "") and F.Styles then
		for _, c in ipairs(F.Styles) do paintStyle(c) end
		redrawRoute(F.RouteMap)
	end
	for _, g in ipairs(F.Groups) do
		for _, c in ipairs(g.cards) do
			if c:IsShown() then paintOption(c) end
		end
	end
	for _, r in ipairs(F.Skins or {}) do
		if r:IsShown() then paintLookRow(r) end
	end
end)
-- A new look or scheme measures every page anew in its fonts (the window keeps
-- its tallest page's height); hidden, the dots repaint.
Theme.OnChanged(function()
	if not F then return end
	if F:IsShown() and not F.psRendering then
		F.psRendering = true
		local ok, err = pcall(render)
		F.psRendering = nil
		if not ok then error(err, 0) end
	elseif F.psAt then
		paintDots(F.psAt, F.psCount, false)
	end
end)
