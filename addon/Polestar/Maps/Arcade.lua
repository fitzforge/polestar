-- Freedoom Arcade on flights: petllama's Doom port to play while the flight
-- timer counts down (Integrations > Freedoom Arcade, maps.flightArcade).
--
-- Which game: the standalone FreedoomArcade addon when it is installed and
-- enabled (the whole game; Polestar never loads its own copy then), else
-- Polestar_Arcade, the copy in Polestar's download (three levels, loaded on
-- demand the first time Play is pressed: nothing of it is in memory before).
-- Either is driven through FreedoomArcadeAPI (version 1: Open(),
-- Close(saveAndPause) -> saved, IsOpen()), each function checked with type()
-- before it is called. A standalone copy without the API is opened with its
-- slash command, only while its window is not shown (the command toggles),
-- and is never closed by us.
--
-- On a flight with the timer's ETA (Maps.GetFlight) at MIN_LEFT seconds or
-- more, out of combat and outside instances, with the game's window closed:
-- once per flight a small card under the flight timer asks "Do you want to
-- play Doom while waiting?" (Play, Not now, Don't ask again: the setting
-- off); after it, a "Play Freedoom Arcade" row under the timer while the
-- conditions hold. LANDING seconds before arrival with the window open: the
-- banner says so (Nav.alerts.ShowNotice) and, through the API, the game is
-- saved, paused and closed so the keys are the character's again. The
-- landing itself (a loading screen ends a flight too) and a fight on the way
-- do the same with the game still open; a chat line says how to go on.
-- /polestar arcade and the guide window's menu open it any time.
--
-- Cost: with the setting off nothing is made and nothing runs on a flight.
-- On, a flight makes one hidden driver frame (the first flight only), shown
-- for the flight, ticking twice a second, and listens for a fight while it
-- lasts; the card is built on the first offer. Opening the game on a flight
-- (the card's Play with "Don't ask again", the command) also starts the
-- landing guard, the setting off or not.

local ADDON, ns = ...
local Maps = ns.Maps
local L = ns.L

local type, pcall, floor, max = type, pcall, math.floor, math.max

local STANDALONE, BUNDLED, TETRIS = "FreedoomArcade", "Polestar_Arcade", "Polestar_Tetris"
local MIN_LEFT = 60 -- seconds of flight left to offer a game
local LANDING = 10  -- seconds before arrival: the game is put away
local TICK = 0.5
local PROMPT_W, MAX_LINE, PAD, BTN_H = 320, 380, 12, 24

ns.RegisterDefaults("maps", { flightArcade = true, flightArcadeMode = "ask", flightArcadeDefault = "doom", flightArcadeMigrated = false })
-- The old opt-out applied only to Doom. Give those players the new choice.
ns.OnInit(function()
	if not ns.Get("maps.flightArcadeMigrated") then
		if not ns.Get("maps.flightArcade") then ns.Set("maps.flightArcade", true) end
		ns.Set("maps.flightArcadeMigrated", true)
	end
end)

local Arcade = { MIN_LEFT = MIN_LEFT, LANDING = LANDING }
ns.Arcade = Arcade

---------------------------------------------------------------------------
-- The game
---------------------------------------------------------------------------

-- "FreedoomArcade" | "Polestar_Arcade" | nil: the copy Polestar uses. None
-- with the game's gamepad interface: the game plays with the keyboard.
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

function Arcade.Which()
	if ns.GamepadUI() then return nil end
	if present(STANDALONE) then return STANDALONE end
	if present(BUNDLED) then return BUNDLED end
	return nil
end

function Arcade.TetrisAvailable() return present(TETRIS) end
function Arcade.Available() return Arcade.Which() ~= nil or Arcade.TetrisAvailable() end
local function tetrisAPI()
	local A = _G.PolestarTetrisAPI
	if type(A) == "table" and type(A.version) == "number" and A.version >= 1 then return A end
end
local function tetrisCall(name, ...)
	local A = tetrisAPI()
	if not A or type(A[name]) ~= "function" then return false end
	return pcall(A[name], ...)
end

-- The API table when one is there (version 1 or later), else nil.
local function api()
	local A = _G.FreedoomArcadeAPI
	if type(A) == "table" and type(A.version) == "number" and A.version >= 1 then return A end
	return nil
end
Arcade.API = api

-- A function of the API, called safely: ok (it was there and ran), result.
local function call(name, ...)
	local A = api()
	local fn = A and A[name]
	if type(fn) ~= "function" then return false end
	local ok, result = pcall(fn, ...)
	return ok, result
end

local function loaded(name)
	local A = C_AddOns
	return A and A.IsAddOnLoaded and A.IsAddOnLoaded(name) and true or false
end

function Arcade.IsOpen()
	local tOk, tOpen = tetrisCall("IsOpen")
	if tOk and tOpen then return true end
	local ok, open = call("IsOpen")
	if ok then return open and true or false end
	-- Without the API: the standalone window, by its name, read safely.
	local f = _G.FreedoomArcadeFrame
	if type(f) == "table" and type(f.IsShown) == "function" then
		local fine, shown = pcall(f.IsShown, f)
		return fine and shown and true or false
	end
	return false
end
function Arcade.Active()
	local ok, open = tetrisCall("IsOpen")
	if ok and open then return "tetris" end
	if Arcade.IsOpen() then return "doom" end
end

-- Polestar's look on the copy we ship: the window skin round the game's
-- view, its title and keys in the theme's type, the close the look's own.
local dressWindow

-- Our copy, loaded on demand (never in combat: its window takes the
-- keyboard, which is protected there).
local function loadBundled()
	if loaded(BUNDLED) then return true end
	local A = C_AddOns
	local load = A and A.LoadAddOn or LoadAddOn
	if not load then return false end
	local ok = pcall(load, BUNDLED)
	if not (ok and loaded(BUNDLED)) then return false end
	call("OnWindow", function(f) dressWindow(f) end)
	return true
end

-- Opens the game (never closes it): true when it is open after. Arcade.Open
-- (the flight's part, below) wraps it.
local function openGame()
	local which = Arcade.Which()
	if not which then
		ns.Print(L["Freedoom Arcade can't open: its folder Polestar_Arcade is missing or turned off."])
		return false
	end
	if ns.Compat.InCombat() then
		ns.Print(L["Freedoom Arcade opens after the fight."])
		return false
	end
	if which == BUNDLED and not loadBundled() then
		ns.Print(L["Freedoom Arcade can't open: its folder Polestar_Arcade is missing or turned off."])
		return false
	end
	local ok, result = call("Open")
	if ok then return result ~= false end
	if Arcade.IsOpen() then return true end
	local slash = SlashCmdList and SlashCmdList.FREEDOOMARCADE
	if type(slash) ~= "function" then return false end
	local fine = pcall(slash, "")
	return fine and Arcade.IsOpen()
end

-- Saves, pauses and closes it, through the API only: closed, saved.
function Arcade.PutAway()
	if Arcade.Active() == "tetris" then
		local ok, saved = tetrisCall("Close", true)
		return ok, saved and true or false
	end
	if not Arcade.IsOpen() then return false, false end
	local ok, saved = call("Close", true)
	if not ok then return false, false end
	return true, saved and true or false
end

-- The command that brings it back (its own, else ours).
function Arcade.ResumeCommand(game)
	if game == "tetris" then return "/polestar tetris" end
	local slash = SlashCmdList and SlashCmdList.FREEDOOMARCADE
	return type(slash) == "function" and "/doom" or "/polestar arcade"
end

ns.RegisterCommand("arcade", function() Arcade.Open() end, L["Play Freedoom Arcade"])
ns.RegisterCommand("tetris", function() Arcade.Open("tetris") end, L["Play Tetris"])

local function openTetris()
	if not Arcade.TetrisAvailable() then ns.Print(L["Polestar Tetris is missing or disabled."]); return false end
	if ns.Compat.InCombat() then ns.Print(L["Tetris opens after the fight."]); return false end
	if not loaded(TETRIS) then
		local A = C_AddOns
		local load = A and A.LoadAddOn or LoadAddOn
		if not load or not pcall(load, TETRIS) or not loaded(TETRIS) then
			ns.Print(L["Polestar Tetris could not load."])
			return false
		end
	end
	local ok, opened = tetrisCall("Open")
	if not ok or opened == false then ns.Print(L["Polestar Tetris could not open."]); return false end
	return true
end

---------------------------------------------------------------------------
-- The game's window in Polestar's look (our copy only)
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
	local close = W.IconButton(bar, "close", 20, L["Close"], function() call("Close", false) end)
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

	-- The question.
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
	q.Play = W.Button(q, L["Doom"], function() Arcade.Play("doom") end, { primary = true, height = BTN_H })
	q.Play:SetPoint("BOTTOMRIGHT", q, "BOTTOMRIGHT", -PAD, PAD)
	q.Tetris = W.Button(q, L["Tetris"], function() Arcade.Play("tetris") end, { primary = true, height = BTN_H })
	q.Tetris:SetPoint("RIGHT", q.Play, "LEFT", -6, 0)
	q.Later = W.Button(q, L["Not now"], function() Arcade.NotNow() end, { height = BTN_H })
	q.Later:SetPoint("RIGHT", q.Tetris, "LEFT", -6, 0)
	q.Never = W.Checkbox(q)
	q.Never:SetPoint("BOTTOMLEFT", q, "BOTTOMLEFT", PAD, PAD + (BTN_H - 18) / 2)
	q.NeverText = W.Text(q, "note", "textDim")
	q.NeverText:SetPoint("LEFT", q.Never, "RIGHT", 6, 0)
	q.NeverText:SetPoint("RIGHT", q.Later, "LEFT", -8, 0)
	q.NeverText:SetJustifyH("LEFT")
	q.NeverText:SetWordWrap(false)

	-- The row: Play Freedoom Arcade.
	local row = W.Button(f, L["Play Tetris"], function() Arcade.Play(Arcade.Selected()) end, { ghost = true, icon = "gamepad", height = BTN_H })
	row:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -3)
	row:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -4, 3)
	f.Row = row

	-- Sized to its words in the look's type (a skin's may be larger): the
	-- buttons to their labels, the card to the widest of its lines, the
	-- question wrapping past MAX_LINE.
	function f.Layout(self)
		local mode = self.mode
		self:SetScale(parent:GetScale())
		self:ClearAllPoints()
		self:SetPoint("TOP", parent, "BOTTOM", 0, -6)
		q:SetShown(mode == "ask")
		row:SetShown(mode == "row")
		local pw = floor(parent:GetWidth() + 0.5)
		if mode == "ask" then
			q.Title:SetText(L["Play a game while waiting for your flight?"])
			q.By:SetText(ns.GamepadUI() and L["Tetris"] or
				(Arcade.TetrisAvailable() and Arcade.Which() and L["Choose Tetris or Freedoom Arcade."]
				or (Arcade.TetrisAvailable() and L["Tetris"] or L["Freedoom Arcade by petllama"])))
			q.NeverText:SetText(L["Don't ask again"])
			q.Play:SetShown(not ns.GamepadUI() and Arcade.Which() ~= nil)
			q.Tetris:SetShown(Arcade.TetrisAvailable())
			q.Tetris:ClearAllPoints()
			if q.Play:IsShown() then q.Tetris:SetPoint("RIGHT", q.Play, "LEFT", -6, 0)
			else q.Tetris:SetPoint("BOTTOMRIGHT", q, "BOTTOMRIGHT", -PAD, PAD) end
			q.Later:ClearAllPoints()
			q.Later:SetPoint("RIGHT", q.Tetris:IsShown() and q.Tetris or q.Play, "LEFT", -6, 0)
			W.SetButtonText(q.Play, L["Doom"])
			W.SetButtonText(q.Tetris, L["Tetris"])
			W.SetButtonText(q.Later, L["Not now"])
			local foot = PAD + 18 + 6 + q.NeverText:GetStringWidth() + 12 + q.Later:GetWidth() + (q.Tetris:IsShown() and 6 + q.Tetris:GetWidth() or 0) + (q.Play:IsShown() and 6 + q.Play:GetWidth() or 0) + PAD
			local head = PAD + 24 + max(q.By:GetStringWidth(), math.min(q.Title:GetStringWidth(), MAX_LINE)) + PAD
			local w = math.ceil(max(PROMPT_W, pw, foot, head))
			self:SetWidth(w)
			q.Title:SetWidth(w - 2 * PAD - 24)
			q.By:SetWidth(w - 2 * PAD - 24)
			local h = PAD + q.Title:GetStringHeight() + 3 + q.By:GetStringHeight() + 12 + max(BTN_H, q.Play:GetHeight()) + PAD
			self:SetHeight(math.ceil(h))
		else
			W.SetButtonText(row, Arcade.Selected() == "tetris" and L["Play Tetris"] or L["Play Freedoom Arcade"])
			-- The row's button fills the card: the card holds its label, glyph and padding.
			self:SetWidth(max(pw, math.ceil(row.Label:GetStringWidth() + 19 + 2 * Theme.Metric("buttonPad", 16) + 8)))
			self:SetHeight(BTN_H + 6)
		end
	end
	if Theme.OnChanged then Theme.OnChanged(function() if f:IsShown() then f:Layout() end end) end
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(f, { back = function() Arcade.NotNow() end })
	end
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
function Arcade.Selected()
	if ns.GamepadUI() then return Arcade.TetrisAvailable() and "tetris" or nil end
	if ns.Get("maps.flightArcadeMode") == "default" then
		local preferred = ns.Get("maps.flightArcadeDefault")
		if preferred == "tetris" and Arcade.TetrisAvailable() then return "tetris" end
		if preferred == "doom" and Arcade.Which() then return "doom" end
	end
	return Arcade.Which() and "doom" or "tetris"
end

---------------------------------------------------------------------------
-- The flight
---------------------------------------------------------------------------

local trip -- this flight: { asked, warned, closedByUs }
local driver, acc

local function enabled()
	return ns.Get("maps.flightArcade") and Arcade.Available()
end

-- May the game be offered now, with `left` seconds of flight to go?
local function offerable(left)
	if not (left and left >= MIN_LEFT and enabled()) then return false end
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
	local game = Arcade.Active()
	if game and Arcade.PutAway() then
		if game == "tetris" then ns.Print(L["Tetris is saved and paused for the fight."])
		else ns.Print(L["Freedoom Arcade is saved and paused for the fight: type %s to continue."]:format(Arcade.ResumeCommand())) end
	end
end

function Arcade.Tick()
	if not trip then return end
	-- Off with nothing of ours to put away: the flight is none of our business.
	if not ns.Get("maps.flightArcade") and not trip.closedByUs and not Arcade.IsOpen() then
		stopTrip()
		return
	end
	local _, left = Maps.GetFlight()
	if left and left <= LANDING then
		hide()
		if not trip.warned then
			trip.warned = true
			if Arcade.IsOpen() then
				local game = Arcade.Active()
				local closed = Arcade.PutAway()
				trip.closedByUs = closed
				trip.lastClosed = game
				local A = ns.Nav and ns.Nav.alerts
				if A and A.ShowNotice then
					A.ShowNotice(L["Landing in 10 seconds"],
						closed and (game == "tetris" and L["Tetris is saved and paused."] or L["Freedoom Arcade is saved and paused."])
						or (game == "tetris" and L["Close Tetris to get your keys back."] or L["Close Freedoom Arcade to get your keys back."]), LANDING)
				end
			end
		end
		return
	end
	if not offerable(left) then
		hide()
		return
	end
	if not trip.asked and ns.Get("maps.flightArcadeMode") ~= "default" then
		trip.asked = true
		show("ask")
	elseif not (card and card:IsShown() and card.mode == "ask") then
		trip.asked = true
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

-- Opens the game (never closes it): true when it is open after. Opened on a
-- flight (whatever opened it), the landing guard runs for it.
function Arcade.Open(game)
	game = game or "doom"
	local active = Arcade.Active()
	if active and active ~= game then
		Arcade.PutAway()
		if Arcade.IsOpen() then
			ns.Print(L["Close the current arcade game before opening another."])
			return false
		end
	end
	local ok = game == "tetris" and openTetris() or openGame()
	if ok and not trip and Maps.GetFlight() then startTrip(true) end
	return ok
end

function Arcade.Play(game)
	game = game or Arcade.Selected()
	local prefer = card and card.mode == "ask" and card.Ask.Never:GetChecked()
	hide()
	local opened = Arcade.Open(game)
	if prefer and opened then
		ns.Set("maps.flightArcadeDefault", game)
		ns.Set("maps.flightArcadeMode", "default")
	end
	return opened
end

function Arcade.NotNow()
	if card and card.Ask.Never:GetChecked() then
		ns.Set("maps.flightArcade", false)
		hide()
		return
	end
	if card then card.mode = "row" end
	show("row")
end

ns.On("FLIGHT_STARTED", function()
	if ns.Get("maps.flightArcade") or Arcade.IsOpen() then startTrip(false) end
end)

-- Landed (or a loading screen ended the flight): a game still open is put
-- away, whenever it was opened.
ns.On("FLIGHT_ENDED", function()
	if not trip then return end
	local closedByUs = trip.closedByUs
	local game = Arcade.Active() or trip.lastClosed
	if Arcade.IsOpen() then closedByUs = Arcade.PutAway() or closedByUs end
	stopTrip()
	if closedByUs then
		if game == "tetris" then ns.Print(L["Landed. Tetris is saved and paused; open it again to continue."])
		else ns.Print(L["Landed. Freedoom Arcade is saved and paused: type %s to continue."]:format(Arcade.ResumeCommand())) end
	end
end)

ns.On("SETTING_CHANGED", function(path)
	if not (path == "maps.flightArcade" or path == "maps.flightArcadeMode" or path == "maps.flightArcadeDefault" or path == "maps" or path == "") then return end
	if trip then
		Arcade.Tick()
	elseif ns.Get("maps.flightArcade") and Maps.GetFlight() then
		startTrip(false)
	end
end)

-- For the tests: this flight's state.
function Arcade.Trip() return trip end
