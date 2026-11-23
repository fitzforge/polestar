-- The games to play on a flight while the flight timer counts down:
-- Freedoom Arcade (petllama's Doom port), Sky Jewels (RikyZ90's
-- match-three) and Tetris (beemerwt's falling blocks). One setting picks the
-- game the flight card offers (Integrations > Flight arcade, arcade.game:
-- "freedoom" | "skyjewels" | "tetris" | "none", which offers nothing).
--
-- Where they live: Polestar_Arcade, one folder in Polestar's download, loaded
-- on demand the first time Play is pressed (nothing of it is in memory
-- before): Freedoom Arcade's engine and three levels, and each other game in
-- its own folder under games/, which hands Arcade.Register its Open(),
-- Close(saveAndPause) -> saved and IsOpen() as the folder loads. Freedoom
-- Arcade may instead be the standalone FreedoomArcade addon, installed and
-- enabled: the whole game. Then Polestar never loads its own folder (both
-- copies are one engine on the same globals), so only Freedoom Arcade is
-- offered. Freedoom Arcade is driven through FreedoomArcadeAPI (version 1:
-- Open(), Close(saveAndPause) -> saved, IsOpen()), each function checked
-- with type() before it is called. A standalone copy without the API is
-- opened with its slash command, only while its window is not shown (the
-- command toggles), and is never closed by us. None of the games is offered
-- with the game's gamepad interface: they play with the keyboard and mouse.
--
-- On a flight with the timer's ETA (Maps.GetFlight) at MIN_LEFT seconds or
-- more, out of combat and outside instances, with no game open: once per
-- flight a small card under the flight timer asks "Play a game while you
-- fly?", a button for each game there (the chosen one first), Not now and
-- Don't ask again (arcade.game "none"). A game's button plays it and makes
-- it the choice. After the card, a "Play <game>" row under the timer while
-- the conditions hold. One game is open at a time: opening another puts the
-- open one away first. LANDING seconds before arrival with a game open: the
-- banner says so (Nav.alerts.ShowNotice) and the game is saved, paused and
-- closed so the keys are the character's again. The landing itself (a
-- loading screen ends a flight too) and a fight on the way do the same with
-- the game still open; a chat line says how to go on. /polestar arcade,
-- /polestar jewels, /polestar tetris and the guide window's menu open a game
-- any time.
--
-- Cost: with "none" nothing is made and nothing runs on a flight. With a
-- game, a flight makes one hidden driver frame (the first flight only),
-- shown for the flight, ticking twice a second, and listens for a fight
-- while it lasts; the card is built on the first offer. Opening a game on a
-- flight (the card's Play with "Don't ask again", a command) also starts the
-- landing guard, "none" or not.

local ADDON, ns = ...
local Maps = ns.Maps
local L = ns.L

local type, pcall, ipairs, floor, max = type, pcall, ipairs, math.floor, math.max

local STANDALONE, BUNDLED = "FreedoomArcade", "Polestar_Arcade"
local MIN_LEFT = 60 -- seconds of flight left to offer a game
local LANDING = 10  -- seconds before arrival: the game is put away
local TICK = 0.5
local PROMPT_W, MAX_LINE, PAD, BTN_H = 320, 380, 12, 24

ns.RegisterDefaults("arcade", { game = "freedoom" })

-- Before the picker, Freedoom Arcade was the one game and maps.flightArcade
-- switched its offer: a profile that had it off offers nothing.
ns.RegisterMigration("arcadeGame", function(s)
	local m = s.maps
	if type(m) ~= "table" or m.flightArcade == nil then return end
	if m.flightArcade == false then
		if type(s.arcade) ~= "table" then s.arcade = {} end
		if s.arcade.game == nil then s.arcade.game = "none" end
	end
	m.flightArcade = nil
end)

local Arcade = { MIN_LEFT = MIN_LEFT, LANDING = LANDING }
ns.Arcade = Arcade

-- The games, in the picker's order, with what Polestar says about each.
local GAMES = {
	{
		id = "freedoom", command = "arcade", name = L["Freedoom Arcade"], credit = L["Freedoom Arcade by petllama"], play = L["Play Freedoom Arcade"],
		missing = L["Freedoom Arcade can't open: its folder Polestar_Arcade is missing or turned off."],
		afterFight = L["Freedoom Arcade opens after the fight."],
		fight = L["Freedoom Arcade is saved and paused for the fight: type %s to continue."],
		paused = L["Freedoom Arcade is saved and paused."],
		keys = L["Close Freedoom Arcade to get your keys back."],
		landed = L["Landed. Freedoom Arcade is saved and paused: type %s to continue."],
	},
	{
		id = "skyjewels", command = "jewels", name = L["Sky Jewels"], credit = L["Sky Jewels by RikyZ90"], play = L["Play Sky Jewels"],
		missing = L["Sky Jewels can't open: its folder Polestar_Arcade is missing or turned off."],
		afterFight = L["Sky Jewels opens after the fight."],
		fight = L["Sky Jewels is saved and paused for the fight: type %s to continue."],
		paused = L["Sky Jewels is saved and paused."],
		landed = L["Landed. Sky Jewels is saved and paused: type %s to continue."],
	},
	{
		id = "tetris", command = "tetris", name = L["Tetris"], credit = L["Tetris by beemerwt"], play = L["Play Tetris"],
		missing = L["Tetris can't open: its folder Polestar_Arcade is missing or turned off."],
		afterFight = L["Tetris opens after the fight."],
		fight = L["Tetris is saved and paused for the fight: type %s to continue."],
		paused = L["Tetris is saved and paused."],
		landed = L["Landed. Tetris is saved and paused: type %s to continue."],
	},
}
local BY_ID = {}
for _, g in ipairs(GAMES) do BY_ID[g.id] = g end

---------------------------------------------------------------------------
-- The games
---------------------------------------------------------------------------

-- Installed and enabled: loaded, loadable, or loadable on demand. The client
-- gives an addon that loads on demand, not loaded yet (Polestar_Arcade), as
-- not loadable with reason "DEMAND_LOADED" ("DEP_DEMAND_LOADED" when one it
-- depends on loads on demand): LoadAddOn loads it (Theme.InstalledSkins reads
-- it the same way).
local ON_DEMAND = { DEMAND_LOADED = true, DEP_DEMAND_LOADED = true }
local function present(name)
	if ns.Compat.AddOnPresent(name) then return true end
	local A = C_AddOns
	if not (A and A.GetAddOnInfo) then return false end
	local ok, _, _, _, loadable, reason = pcall(A.GetAddOnInfo, name)
	return ok and (loadable or ON_DEMAND[reason]) and true or false
end

-- "FreedoomArcade" | "Polestar_Arcade" | nil: the copy of Freedoom Arcade
-- Polestar uses.
function Arcade.Which()
	if ns.GamepadUI() then return nil end
	if present(STANDALONE) then return STANDALONE end
	if present(BUNDLED) then return BUNDLED end
	return nil
end

-- Can the game (by id) be played here? The others than Freedoom Arcade are
-- in Polestar_Arcade only, never loaded beside the standalone addon.
local function available(g)
	if g.id == "freedoom" then return Arcade.Which() ~= nil end
	return not ns.GamepadUI() and not present(STANDALONE) and present(BUNDLED)
end

-- id given: whether that game can be played; else whether any can.
function Arcade.Available(id)
	if id then return BY_ID[id] ~= nil and available(BY_ID[id]) end
	for _, g in ipairs(GAMES) do
		if available(g) then return true end
	end
	return false
end

-- The games there, in the picker's order: { { id, name, credit, play, ... } }.
function Arcade.Games()
	local out = {}
	for _, g in ipairs(GAMES) do
		if available(g) then out[#out + 1] = g end
	end
	return out
end

-- The game the flight offers: the chosen one, else (chosen, but not there)
-- the first there; nil with "none" or none there.
function Arcade.Choice()
	local id = ns.Get("arcade.game")
	if id == "none" then return nil end
	local g = BY_ID[id]
	if g and available(g) then return g end
	return Arcade.Games()[1]
end

-- The game the guide menu opens: the choice, else the first there.
function Arcade.MenuGame()
	return Arcade.Choice() or Arcade.Games()[1]
end

-- Freedoom Arcade's API table when one is there (version 1 or later), else nil.
local function api()
	local A = _G.FreedoomArcadeAPI
	if type(A) == "table" and type(A.version) == "number" and A.version >= 1 then return A end
	return nil
end
Arcade.API = api

-- The other games' functions, handed over as Polestar_Arcade loads them.
local registered = {}
function Arcade.Register(id, fns)
	if BY_ID[id] and id ~= "freedoom" and type(fns) == "table" then registered[id] = fns end
end

-- A function of a game's API, called safely: ok (it was there and ran), result.
local function call(id, name, ...)
	local A
	if id == "freedoom" then A = api() else A = registered[id] end
	local fn = A and A[name]
	if type(fn) ~= "function" then return false end
	local ok, result = pcall(fn, ...)
	return ok, result
end

local function loaded(name)
	local A = C_AddOns
	return A and A.IsAddOnLoaded and A.IsAddOnLoaded(name) and true or false
end

local function isOpen(id)
	local ok, open = call(id, "IsOpen")
	if ok then return open and true or false end
	if id ~= "freedoom" then return false end
	-- Without the API: the standalone window, by its name, read safely.
	local f = _G.FreedoomArcadeFrame
	if type(f) == "table" and type(f.IsShown) == "function" then
		local fine, shown = pcall(f.IsShown, f)
		return fine and shown and true or false
	end
	return false
end

-- The id of the game open, or nil.
function Arcade.Active()
	for _, g in ipairs(GAMES) do
		if isOpen(g.id) then return g.id end
	end
	return nil
end

-- id given: whether that game is open; else whether one is.
function Arcade.IsOpen(id)
	if id then return isOpen(id) end
	return Arcade.Active() ~= nil
end

-- Polestar's look on the Freedoom Arcade we ship: the window skin round the
-- game's view, its title and keys in the theme's type, the close the look's own.
local dressWindow

-- Our folder, loaded on demand (never in combat: a game's window takes the
-- keyboard, which is protected there).
local function loadBundled()
	if loaded(BUNDLED) then return true end
	local A = C_AddOns
	local load = A and A.LoadAddOn or LoadAddOn
	if not load then return false end
	local ok = pcall(load, BUNDLED)
	if not (ok and loaded(BUNDLED)) then return false end
	call("freedoom", "OnWindow", function(f) dressWindow(f) end)
	return true
end

-- Opens the game (never closes it): true when it is open after. Arcade.Open
-- (the flight's part, below) wraps it.
local function openGame(g)
	if not available(g) then
		ns.Print(g.missing)
		return false
	end
	if ns.Compat.InCombat() then
		ns.Print(g.afterFight)
		return false
	end
	if (g.id ~= "freedoom" or Arcade.Which() == BUNDLED) and not loadBundled() then
		ns.Print(g.missing)
		return false
	end
	local ok, result = call(g.id, "Open")
	if ok then return result ~= false and isOpen(g.id) end
	if g.id ~= "freedoom" then return false end
	if isOpen(g.id) then return true end
	local slash = SlashCmdList and SlashCmdList.FREEDOOMARCADE
	if type(slash) ~= "function" then return false end
	local fine = pcall(slash, "")
	return fine and isOpen(g.id)
end

-- Saves, pauses and closes the game open, through its API only: closed, saved.
function Arcade.PutAway()
	local id = Arcade.Active()
	if not id then return false, false end
	local ok, saved = call(id, "Close", true)
	if not ok then return false, false end
	return true, saved and true or false
end

-- The command that brings a game back (Freedoom Arcade's own, else ours).
function Arcade.ResumeCommand(id)
	local g = BY_ID[id or "freedoom"] or GAMES[1]
	if g.id == "freedoom" then
		local slash = SlashCmdList and SlashCmdList.FREEDOOMARCADE
		if type(slash) == "function" then return "/doom" end
	end
	return "/polestar " .. g.command
end

for _, g in ipairs(GAMES) do
	ns.RegisterCommand(g.command, function() Arcade.Open(g.id) end, g.play)
end

---------------------------------------------------------------------------
-- Freedoom Arcade's window in Polestar's look (our copy only)
---------------------------------------------------------------------------

function dressWindow(f)
	local W, Theme = ns.Widgets, ns.Theme
	if not (W and Theme) or type(f) ~= "table" or f.psDressed then return end
	f.psDressed = true
	-- The window skin on a frame just behind the game's, a little larger:
	-- its edge never covers the picture.
	local back = CreateFrame("Frame", "PolestarArcadeFrame", f)
	back:SetPoint("TOPLEFT", f, "TOPLEFT", -6, 6)
	back:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 6, -6)
	back:SetFrameLevel(max(0, f:GetFrameLevel() - 1))
	back.psLight, back.psBgAlpha = true, 1
	Theme.Skin(back, "window")
	if f.bg and f.bg.Hide then f.bg:Hide() end
	if f.title and f.title.Hide then f.title:Hide() end
	local bar = f.bar or f
	back.Title = W.Text(bar, "label", "text")
	back.Title:SetPoint("LEFT", bar, "LEFT", 6, 0)
	back.Title:SetText(L["Freedoom Arcade by petllama"])
	back.Note = W.Text(bar, "note", "textDim")
	back.Note:SetPoint("LEFT", back.Title, "RIGHT", 10, 0)
	back.Note:SetText(L["3 levels of Freedoom Phase 1. Esc: menu, P: pause, F6/F9: save/load."])
	-- Our close in place of the game's red one (a game look draws it in its
	-- own art, as every close icon button).
	local close = W.IconButton(bar, "close", 20, L["Close"], function() call("freedoom", "Close", false) end)
	close:SetPoint("RIGHT", bar, "RIGHT", -2, 0)
	back.Close = close
	if f.close and f.close.Hide then f.close:Hide() end
	if f.fps and f.fps.ClearAllPoints then
		f.fps:ClearAllPoints()
		f.fps:SetPoint("RIGHT", close, "LEFT", -8, 0)
	end
	back.Note:SetPoint("RIGHT", (f.fps or close), "LEFT", -8, 0)
	back.Note:SetWordWrap(false)
	Theme.Repaint(back)
	Arcade.window = back
end
Arcade.DressWindow = function(f) dressWindow(f) end

---------------------------------------------------------------------------
-- The card under the flight timer
---------------------------------------------------------------------------

local card

local function timer() return _G.PolestarFlightTimer end

local function build()
	local W, Theme = ns.Widgets, ns.Theme
	local parent = timer()
	if not (W and Theme and parent) then return nil end
	-- A window of its own on Polestar's layer, under the timer at the timer's
	-- scale, going when the timer goes.
	local f = CreateFrame("Frame", "PolestarArcadeOffer", ns.UIParent)
	f:SetFrameStrata(parent:GetFrameStrata())
	f:SetClampedToScreen(true)
	f:EnableMouse(true)
	parent:HookScript("OnHide", function() f:Hide() end)
	f.psLight = true
	Theme.Skin(f, "window")
	f:Hide()

	-- The question: the games there, each a button that plays it.
	local q = CreateFrame("Frame", nil, f)
	q:SetAllPoints(f)
	f.Ask = q
	q.Icon = W.Tex(q, "ARTWORK", "gamepad", "accent")
	q.Icon:SetSize(16, 16)
	q.Icon:SetPoint("TOPLEFT", q, "TOPLEFT", PAD, -PAD)
	q.Title = W.Text(q, "body", "text")
	q.Title:SetPoint("TOPLEFT", q.Icon, "TOPRIGHT", 8, 1)
	q.Title:SetPoint("RIGHT", q, "RIGHT", -PAD, 0)
	q.Title:SetJustifyH("LEFT")
	q.Title:SetWordWrap(true)
	q.By = W.Text(q, "note", "textDim")
	q.By:SetPoint("TOPLEFT", q.Title, "BOTTOMLEFT", 0, -3)
	q.By:SetPoint("RIGHT", q, "RIGHT", -PAD, 0)
	q.By:SetJustifyH("LEFT")
	q.Games = {}
	for _, g in ipairs(GAMES) do
		q.Games[g.id] = W.Button(q, g.name, function() Arcade.Play(g.id) end, { primary = true, height = BTN_H })
	end
	q.Later = W.Button(q, L["Not now"], function() Arcade.NotNow() end, { height = BTN_H })
	q.Later:SetPoint("BOTTOMRIGHT", q, "BOTTOMRIGHT", -PAD, PAD)
	q.Never = W.Checkbox(q)
	q.Never:SetPoint("BOTTOMLEFT", q, "BOTTOMLEFT", PAD, PAD + (BTN_H - 18) / 2)
	q.NeverText = W.Text(q, "note", "textDim")
	q.NeverText:SetPoint("LEFT", q.Never, "RIGHT", 6, 0)
	q.NeverText:SetPoint("RIGHT", q.Later, "LEFT", -8, 0)
	q.NeverText:SetJustifyH("LEFT")
	q.NeverText:SetWordWrap(false)

	-- The row: Play <the chosen game>.
	local row = W.Button(f, "", function() Arcade.Play() end, { ghost = true, icon = "gamepad", height = BTN_H })
	row:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -3)
	row:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -4, 3)
	f.Row = row

	-- Sized to its words in the look's type (a skin's may be larger): the
	-- buttons to their labels, the card to the widest of its lines, the
	-- question and the credits wrapping past MAX_LINE. The games' buttons
	-- in a line of their own above Not now, the chosen game first.
	function f.Layout(self)
		local mode = self.mode
		self:SetScale(parent:GetScale())
		self:ClearAllPoints()
		self:SetPoint("TOP", parent, "BOTTOM", 0, -6)
		q:SetShown(mode == "ask")
		row:SetShown(mode == "row")
		local pw = floor(parent:GetWidth() + 0.5)
		local choice = Arcade.Choice()
		if mode == "ask" then
			local games, credits = Arcade.Games(), {}
			for i, g in ipairs(games) do
				if choice and g.id == choice.id and i > 1 then
					table.remove(games, i)
					table.insert(games, 1, g)
					break
				end
			end
			for _, b in pairs(q.Games) do b:Hide() end
			local line, prev = 0, nil
			for i, g in ipairs(games) do
				local b = q.Games[g.id]
				W.SetButtonText(b, g.name)
				b:ClearAllPoints()
				if prev then
					b:SetPoint("LEFT", prev, "RIGHT", 6, 0)
				else
					b:SetPoint("BOTTOMLEFT", q, "BOTTOMLEFT", PAD + 24, PAD + max(BTN_H, q.Later:GetHeight()) + 8)
				end
				b:Show()
				line = line + (i > 1 and 6 or 0) + b:GetWidth()
				credits[#credits + 1] = g.credit
				prev = b
			end
			q.Title:SetText(L["Play a game while you fly?"])
			q.By:SetText(table.concat(credits, " · "))
			q.NeverText:SetText(L["Don't ask again"])
			W.SetButtonText(q.Later, L["Not now"])
			local foot = PAD + 18 + 6 + q.NeverText:GetStringWidth() + 12 + q.Later:GetWidth() + PAD
			local head = PAD + 24 + math.min(max(q.By:GetStringWidth(), q.Title:GetStringWidth()), MAX_LINE) + PAD
			local w = math.ceil(max(PROMPT_W, pw, foot, head, PAD + 24 + line + PAD))
			self:SetWidth(w)
			q.Title:SetWidth(w - 2 * PAD - 24)
			q.By:SetWidth(w - 2 * PAD - 24)
			local btn = max(BTN_H, q.Later:GetHeight())
			local h = PAD + q.Title:GetStringHeight() + 3 + q.By:GetStringHeight() + 12 + btn + 8 + btn + PAD
			self:SetHeight(math.ceil(h))
		else
			W.SetButtonText(row, choice and choice.play or "")
			-- The row's button fills the card: the card holds its label, glyph and padding.
			self:SetWidth(max(pw, math.ceil(row.Label:GetStringWidth() + 19 + 2 * Theme.Metric("buttonPad", 16) + 8)))
			self:SetHeight(BTN_H + 6)
		end
	end
	if Theme.OnChanged then Theme.OnChanged(function() if f:IsShown() then f:Layout() end end) end
	return f
end

local function show(mode)
	if not card then card = build() end
	if not card then return end
	card.mode = mode
	if mode == "ask" then card.Ask.Never:SetChecked(false) end
	card:Layout()
	card:Show()
end

local function hide()
	if card then card:Hide() end
end

-- Builds and shows the card on the live timer for a preview or a render:
-- mode "ask" | "row".
function Arcade.ShowCard(mode) show(mode) end
function Arcade.Card() return card end

---------------------------------------------------------------------------
-- The flight
---------------------------------------------------------------------------

local trip -- this flight: { asked, warned, closedByUs, game }
local driver, acc

local function wanted()
	return ns.Get("arcade.game") ~= "none"
end

-- May a game be offered now, with `left` seconds of flight to go?
local function offerable(left)
	if not (left and left >= MIN_LEFT and wanted() and Arcade.Choice()) then return false end
	if ns.Compat.InCombat() or ns.Compat.IsInInstance() then return false end
	local t = timer()
	return t ~= nil and t:IsShown() and not Arcade.IsOpen()
end

local stopTrip

-- A fight on the way: the game is saved, paused and closed (the game's own
-- pause on aggro may have done it already: then it has said so).
local function onFight()
	if not trip then return end
	hide()
	local id = Arcade.Active()
	if id and Arcade.PutAway() then
		ns.Print(BY_ID[id].fight:format(Arcade.ResumeCommand(id)))
	end
end

function Arcade.Tick()
	if not trip then return end
	-- "none" with nothing of ours to put away: the flight is none of our business.
	if not wanted() and not trip.closedByUs and not Arcade.IsOpen() then
		stopTrip()
		return
	end
	local flying, left = Maps.GetFlight()
	-- No flight timer this flight (maps.flightTimer off): off the taxi is the landing.
	if not flying and not ns.Compat.IsOnTaxi() then
		Arcade.Landed()
		return
	end
	if left and left <= LANDING then
		hide()
		if not trip.warned then
			trip.warned = true
			local id = Arcade.Active()
			if id then
				local g = BY_ID[id]
				local closed = Arcade.PutAway()
				trip.closedByUs = closed
				trip.game = id
				local A = ns.Nav and ns.Nav.alerts
				if A and A.ShowNotice then
					A.ShowNotice(L["Landing in 10 seconds"], closed and g.paused or g.keys or g.paused, LANDING)
				end
			end
		end
		return
	end
	if not offerable(left) then
		hide()
		return
	end
	if not trip.asked then
		trip.asked = true
		show("ask")
	elseif not (card and card:IsShown() and card.mode == "ask") then
		show("row")
	end
end

local function startTrip(asked)
	trip = { asked = asked or false, warned = false, closedByUs = false }
	if not driver then
		driver = CreateFrame("Frame")
		driver:SetScript("OnUpdate", ns.Safe(function(_, dt)
			acc = acc + dt
			if acc < TICK then return end
			acc = 0
			Arcade.Tick()
		end))
	end
	acc = TICK
	driver:Show()
	ns.RegisterEvent("PLAYER_REGEN_DISABLED", onFight)
end

function stopTrip()
	trip = nil
	if driver then driver:Hide() end
	ns.UnregisterEvent("PLAYER_REGEN_DISABLED", onFight)
	hide()
end

-- Opens a game by id (Freedoom Arcade when nil), never closes it: true when
-- it is open after. Another game open is put away first. Opened on a flight
-- (whatever opened it), the landing guard runs for it.
function Arcade.Open(id)
	local g = BY_ID[id or "freedoom"]
	if not g then return false end
	local active = Arcade.Active()
	if active and active ~= g.id then
		Arcade.PutAway()
		if Arcade.IsOpen(active) then
			ns.Print(L["Close the game that is open before you start another."])
			return false
		end
	end
	local ok = openGame(g)
	if ok and not trip and (Maps.GetFlight() or ns.Compat.IsOnTaxi()) then startTrip(true) end
	return ok
end

-- The card's Play: the game by id (the choice when nil), made the choice;
-- with "Don't ask again" ticked, nothing is offered again.
function Arcade.Play(id)
	local g = id and BY_ID[id] or Arcade.Choice()
	local never = card and card.mode == "ask" and card.Ask.Never:GetChecked()
	hide()
	if not g then return false end
	-- Opened first: the choice's SETTING_CHANGED then finds the game open and leaves the card away.
	local ok = Arcade.Open(g.id)
	ns.Set("arcade.game", never and "none" or g.id)
	return ok
end

function Arcade.NotNow()
	if card and card.Ask.Never:GetChecked() then
		ns.Set("arcade.game", "none")
		hide()
		return
	end
	if card then card.mode = "row" end
	show("row")
end

ns.On("FLIGHT_STARTED", function()
	if wanted() then startTrip(false) end
end)

-- Landed (or a loading screen ended the flight): a game still open is put
-- away, whenever it was opened.
function Arcade.Landed()
	if not trip then return end
	local closedByUs, id = trip.closedByUs, trip.game
	local open = Arcade.Active()
	if open then
		id = open
		closedByUs = Arcade.PutAway() or closedByUs
	end
	stopTrip()
	if closedByUs and id then
		ns.Print(BY_ID[id].landed:format(Arcade.ResumeCommand(id)))
	end
end
ns.On("FLIGHT_ENDED", function() Arcade.Landed() end)

ns.On("SETTING_CHANGED", function(path)
	if not (path == "arcade.game" or path == "arcade" or path == "") then return end
	if trip then
		Arcade.Tick()
	elseif wanted() and Maps.GetFlight() then
		startTrip(false)
	end
end)

-- For the tests: this flight's state.
function Arcade.Trip() return trip end
