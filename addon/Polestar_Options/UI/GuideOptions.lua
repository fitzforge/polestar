-- The guide window's modules' rows (docs/ARCHITECTURE.md, "Options
-- registry"): the Gamepad page (UI/GamepadGuide.lua: button names, window
-- navigation, hints, and a binding row per action), the journey's steps
-- (UI/JourneyPanel.lua) and Questie's planned turn-ins (UI/QuestieTurnIns.lua).
-- Part of the settings' addon: none of it is in memory before the settings
-- open.

local ns = Polestar
local L = ns.L

if not ns.RegisterOptions then return end

local function register(spec)
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

-- The Gamepad page; its binding rows are drawn by G.BindingRow.
local G = ns.Gamepad
if G and G.BindingRow then
	local PAGE, NAV, KEYS = L["Gamepad"], L["Navigation"], L["Key bindings"]
	local ORDER = 75
	register({
		page = PAGE, key = "gamepad", icon = "gamepad", order = ORDER,
		subtitle = L["Play Polestar with a gamepad: its windows, its buttons and your bindings. The bindings take keys too."],
		tab = NAV, section = L["Your gamepad"],
		controls = {
			{ kind = "dropdown", key = "gamepad.glyphs", label = L["Button names"],
				help = L["The names and shapes Polestar shows for your gamepad's buttons. Automatic reads them off the gamepad."],
				choices = {
					{ value = "auto", label = L["Automatic"] },
					{ value = "xbox", label = L["Xbox (A, B, X, Y)"] },
					{ value = "playstation", label = L["PlayStation (shapes)"] },
				} },
			{ kind = "toggle", key = "gamepad.navigate", label = L["Navigate Polestar's windows"], search = "controller, gamepad, steam deck, console, joystick",
				help = L["While a Polestar window is open, the D-pad moves through it, A selects, B closes, LB and RB change tabs, Y restores a default. Out of combat; the game gets every button back when the window closes."] },
			{ kind = "toggle", key = "gamepad.hints", label = L["Button hints"],
				help = L["A bar under the window says what each button does, and B sits on the close button."] },
			{ kind = "toggle", key = "gamepad.withMouse", label = L["Use with the keyboard and mouse"],
				help = L["Off, Polestar uses the gamepad only with the game's gamepad interface (Options, Gamepad, Enable Gamepad UI). On, also with the keyboard and mouse interface, while the gamepad is turned on in the game's options and plugged in."] },
		},
	})

	local SECTIONS = { guide = L["The guide"], windows = L["Windows"], buttons = L["Quest buttons"] }
	local HELP = {
		POLESTAR_FOCUS = L["The guide window holds the gamepad until B: the D-pad picks a line, A points the arrow there or uses the item, X shows its details, LB and RB change steps, Y minimizes the window. A window that opened by itself, such as a route choice, waits for this button before it takes the gamepad."],
		["CLICK PolestarStepButton:LeftButton"] = L["Step action: NPC, quest item, mob or Hearthstone"],
		["CLICK PolestarTravelButton:LeftButton"] = L["Use the route's Hearthstone or teleport"],
	}
	for _, a in ipairs(G.ACTIONS) do
		register({
			page = PAGE, key = "gamepad", icon = "gamepad", order = ORDER, tab = KEYS, section = SECTIONS[a.section],
			controls = { { kind = "binding", action = a.action, label = a.label, help = HELP[a.action] } },
		})
	end
end

-- The journey's steps in the guide window (Guide > Arrow & routes > Routes).
local Nav, UI = ns.Nav, ns.UI
if Nav and UI and UI.JourneyPanel then
	register({
		page = L["Guide"], tab = L["Arrow & routes"], section = L["Routes"],
		controls = {
			Nav.HandoffOption({ kind = "toggle", key = "nav.journeySteps", label = L["Show the journey"],
				help = L["The route's steps in the guide window with a time for each, counting down: walks, lifts, boats and flights. Click the current step to skip it."] }),
		},
	})
end

-- Integrations > Questie, there only while Questie is installed.
if ns.QuestieTurnIns then
	register({ page = L["Integrations"], section = "Questie", controls = {
		{ kind = "toggle", key = "routePlan.questie", label = L["Show planned turn-ins in Questie"],
			help = L["Completed quests in Questie's tracker show their Polestar turn-in step. Earlier, skipped and unplanned hand-ins are flagged."],
			needs = function() return ns.Compat.AddOnPresent("Questie") end },
	} })
end
