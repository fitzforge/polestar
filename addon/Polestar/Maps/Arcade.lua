-- Flight Arcade puts shortcuts to Sky Jewels and petllama's Freedoom in the taxi HUD.
-- Prefer the standalone Freedoom addon and load the bundled copy only on demand.

local ADDON, ns = ...
local Maps = ns.Maps
local L = ns.L
local Jewels = ns.SkyJewels

local type, pcall, max = type, pcall, math.max

local STANDALONE, BUNDLED = "FreedoomArcade", "Polestar_Arcade"
local LANDING = 10  -- seconds before arrival: the game is put away
local TICK = 0.5
local BUTTON_SIZE, BUTTON_GAP = 22, 4

ns.RegisterDefaults("maps", { flightArcade = true })

local Arcade = { LANDING = LANDING }
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

function Arcade.Available() return not ns.GamepadUI() end

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
	if not Arcade.IsOpen() then return false, false end
	local ok, saved = call("Close", true)
	if not ok then return false, false end
	return not Arcade.IsOpen(), saved and true or false
end

-- The command that brings it back (its own, else ours).
function Arcade.ResumeCommand()
	local slash = SlashCmdList and SlashCmdList.FREEDOOMARCADE
	return type(slash) == "function" and "/doom" or "/polestar arcade"
end

ns.RegisterCommand("arcade", function() Arcade.Open() end, L["Play Freedoom Arcade"])
ns.RegisterCommand("jewels", function() Arcade.Open("jewels") end, L["Play Sky Jewels"])
if not ns.GamepadUI() then
	SLASH_POLESTAR_SKYJEWELS1 = Jewels.command
	SlashCmdList.POLESTAR_SKYJEWELS = function() ns.RunCommand("jewels") end
end

local function putAwayGames()
	local jewels = Jewels.Close()
	local doom, saved = Arcade.PutAway()
	return jewels, doom, saved
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
-- Flight shortcuts
---------------------------------------------------------------------------

local shortcuts

local function shortcut(parent, icon, title, game)
	local W = ns.Widgets
	local b = CreateFrame("Button", nil, parent)
	b:SetSize(BUTTON_SIZE, BUTTON_SIZE)
	W.Hover(b)
	local art = b:CreateTexture(nil, "ARTWORK")
	art:SetSize(18, 18)
	art:SetPoint("CENTER")
	art:SetTexture(icon)
	b.psTip = title
	b:SetScript("OnEnter", W.SimpleTip)
	b:SetScript("OnLeave", W.HideTooltip)
	b:SetScript("OnHide", W.HideTooltip)
	b:SetScript("OnClick", function() Arcade.Open(game) end)
	return b
end

local function build()
	local f = CreateFrame("Frame", "PolestarFlightArcade", ns.UIParent)
	f:SetFrameStrata("MEDIUM")
	f:SetClampedToScreen(true)
	f:Hide()
	f.Jewels = shortcut(f, "Interface\\AddOns\\" .. ADDON .. "\\Media\\SkyJewels\\jewel-5", Jewels.title, "jewels")
	f.Jewels:SetPoint("LEFT")
	f.Doom = shortcut(f, ns.Theme.Media("icon-skull"), L["Freedoom Arcade"])
	f.Doom:SetPoint("LEFT", f.Jewels, "RIGHT", BUTTON_GAP, 0)
	return f
end

local function show()
	local arrow = ns.Nav and ns.Nav.arrow and ns.Nav.arrow.frame
	local timer = _G.PolestarFlightTimer
	-- The arrow normally hides on taxis. Follow the flight timer while it is visible.
	local anchor = (arrow and arrow:IsVisible() and arrow) or (timer and timer:IsVisible() and timer) or arrow or timer
	if not anchor then return end
	if not shortcuts then shortcuts = build() end
	if shortcuts.anchor ~= anchor then
		shortcuts.anchor = anchor
		shortcuts:ClearAllPoints()
		shortcuts:SetPoint("TOP", anchor, "BOTTOM", 0, -3)
	end
	if not shortcuts:IsShown() then
		local doom = Arcade.Which() ~= nil
		shortcuts.Doom:SetShown(doom)
		shortcuts:SetSize(doom and (2 * BUTTON_SIZE + BUTTON_GAP) or BUTTON_SIZE, BUTTON_SIZE)
		shortcuts:Show()
	end
end

local function hide()
	if shortcuts then shortcuts:Hide() end
end

---------------------------------------------------------------------------
-- The flight
---------------------------------------------------------------------------

local trip
local driver, acc

local function enabled()
	return ns.Get("maps.flightArcade") and Arcade.Available()
end

local stopTrip

-- A fight on the way: the game is saved, paused and closed (the game's own
-- pause on aggro may have done it already: then it has said so).
local function onFight()
	if not trip then return end
	hide()
	local jewels, doom, saved = putAwayGames()
	if jewels then
		ns.Print(L["Sky Jewels paused for combat. Type %s to continue."]:format(Jewels.command))
	end
	if doom then
		local line = saved and L["Freedoom Arcade is saved and paused for the fight: type %s to continue."]
			or L["Freedoom Arcade closed for combat. Type %s to reopen."]
		ns.Print(line:format(Arcade.ResumeCommand()))
	end
end

function Arcade.Tick()
	if not trip then return end
	-- Off with nothing of ours to put away: the flight is none of our business.
	local playing = Jewels.IsOpen() or Arcade.IsOpen()
	if not ns.Get("maps.flightArcade") and not (playing or trip.jewelsClosed or trip.doomClosed) then
		stopTrip()
		return
	end
	local _, left = Maps.GetFlight()
	if left and left <= LANDING then
		hide()
		if playing then
			local doomWasOpen = Arcade.IsOpen()
			local jewels, doom, saved = putAwayGames()
			trip.jewelsClosed = trip.jewelsClosed or jewels
			trip.doomClosed = trip.doomClosed or doom
			trip.doomSaved = trip.doomSaved or saved
			local A = ns.Nav and ns.Nav.alerts
			if not trip.warned and A and A.ShowNotice then
				trip.warned = true
				local reason = L["Sky Jewels progress saved."]
				if doomWasOpen then
					reason = trip.doomSaved and L["Freedoom Arcade is saved and paused."]
						or (trip.doomClosed and L["Freedoom Arcade closed."] or L["Close Freedoom Arcade to get your keys back."])
				end
				A.ShowNotice(L["Landing in 10 seconds"], reason, LANDING)
			end
		end
		return
	end
	if not playing and enabled() and ns.Compat.IsOnTaxi() and not ns.Compat.InCombat() and not ns.Compat.IsInInstance() then
		show()
	else
		hide()
	end
end

local function startTrip()
	if trip then return end
	trip = {}
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
	local flying = ns.Compat.IsOnTaxi()
	if flying then
		local _, left = Maps.GetFlight()
		if left and left <= LANDING then
			ns.Print(L["The flight is almost over. Open the arcade after landing."])
			return false
		end
	end
	local ok
	if game == "jewels" then
		if ns.Compat.InCombat() then
			ns.Print(L["Sky Jewels opens after the fight."])
			return false
		end
		if Arcade.IsOpen() and not Arcade.PutAway() then
			ns.Print(L["Close Freedoom Arcade before opening Sky Jewels."])
			return false
		end
		ok = Jewels.Open()
	else
		ok = openGame()
		if ok then Jewels.Close() end
	end
	if ok then
		hide()
		if flying then startTrip() end
	end
	return ok
end

ns.On("FLIGHT_STARTED", function()
	if enabled() then startTrip() end
end)

-- Landed (or a loading screen ended the flight): a game still open is put
-- away, whenever it was opened.
ns.On("FLIGHT_ENDED", function()
	if not trip then return end
	local jewels, doom, saved = putAwayGames()
	jewels, doom, saved = jewels or trip.jewelsClosed, doom or trip.doomClosed, saved or trip.doomSaved
	stopTrip()
	if jewels then
		ns.Print(L["Landed. Sky Jewels progress saved. Type %s to continue."]:format(Jewels.command))
	end
	if doom then
		local line = saved and L["Landed. Freedoom Arcade is saved and paused: type %s to continue."]
			or L["Landed. Type %s to reopen Freedoom Arcade."]
		ns.Print(line:format(Arcade.ResumeCommand()))
	end
end)

ns.On("SETTING_CHANGED", function(path)
	if not (path == "maps.flightArcade" or path == "maps" or path == "") then return end
	if trip then
		Arcade.Tick()
	elseif enabled() and ns.Compat.IsOnTaxi() then
		startTrip()
	end
end)

-- For the tests: this flight's state.
function Arcade.Trip() return trip end
