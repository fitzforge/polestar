-- Adapted from Ding! by Yendi (@moust4ki), GPL-3.0: https://github.com/moust4ki/DingGuideWoWForever
--
-- The gamepad on the guide window and in the options (docs/ARCHITECTURE.md,
-- "Gamepad"):
-- * Focus mode ("Browse the guide with the gamepad", POLESTAR_FOCUS): the
--   guide window never takes a button from the game while it is merely
--   shown; this binding gives it the gamepad until B. The D-pad picks a line
--   (up from the goals: the navigator's buttons and the tabs), A points the
--   arrow there or uses the quest item on its line, X shows the line's
--   details, LB / RB look at the previous / next step, Y minimizes the window
--   to compact mode, B gives the gamepad back. Out of combat only; a fight
--   ends it. A window that showed on its own (a route choice, the welcome)
--   waits for the same binding before it takes the gamepad.
-- * The Gamepad options page: button names, window navigation, hints, and a
--   binding row per Polestar action (a key, a button, or a chord). No action
--   gets a button or a chord unasked: every combination of LB or RB is the
--   game's own with its gamepad interface on, and the minimap button opens
--   the options there.

local ADDON, ns = ...
local G = ns.Gamepad
local UI = ns.UI
local L = ns.L
local W = ns.Widgets

local function combat() return InCombatLockdown and InCombatLockdown() and true or false end

---------------------------------------------------------------------------
-- Focus mode
---------------------------------------------------------------------------

local F -- the guide window
local focusing = false
local tipped -- the line whose details X opened

local function itemButton()
	local Q = ns.QoL
	local B = Q and Q.Buttons
	return B and B.item or nil
end

-- A goal line the quest item button serves: A uses the item there (the
-- button's secure click, through an override binding: never from
-- Polestar's code). Not with the gamepad interface, which keeps its
-- buttons' bindings (G.Redirect): A clicks that line as on any other.
local function itemRow(w)
	if ns.GamepadUI() then return false end
	local goal = w and w.psGoal
	local b = itemButton()
	if not (goal and b and b:IsShown() and b.itemID) then return false end
	if goal.status == "done" or goal.status == "skipped" then return false end
	return goal.item == b.itemID or goal.t == "use"
end

-- The first open goal, else the first goal, else the first line.
local function firstOpen(rows)
	for i, w in ipairs(rows) do
		local g = w.psGoal
		if g and g.status ~= "done" and g.status ~= "skipped" then return i end
	end
	for i, w in ipairs(rows) do if w.psGoal then return i end end
	return 1
end

local function leave(w)
	if not w then return end
	local fn = w:GetScript("OnLeave")
	if fn then pcall(fn, w) end
	if tipped == w then tipped = nil end
end

-- X: the line's details, as the mouse's hover shows them; again: gone.
local function details(w)
	if not w then return end
	if tipped == w then return leave(w) end
	leave(tipped)
	local fn = w:GetScript("OnEnter")
	if fn then
		pcall(fn, w)
		tipped = w
	end
end

local function engine() return ns.Engine end

local spec = {
	rows = function() return G.Collect(F) end,
	initial = firstOpen,
	onFocus = function(w)
		if tipped and tipped ~= w then leave(tipped) end
		G.Redirect("PAD1", itemRow(w) and "PolestarQuestItemButton" or nil)
	end,
	actionLabel = function(w)
		if itemRow(w) then return L["Use the item"] end
		local g = w.psGoal
		if g and g.x and g.map then return L["Point the arrow"] end
		return nil
	end,
	xLabel = function(w) return w:GetScript("OnEnter") and L["Details"] or nil end,
	x = details,
	reset = function()
		G.StopFocus()
		ns.Set("ui.compact", true)
		return true
	end,
	resetLabel = function() return L["Minimize"] end,
	prevTab = function() local E = engine(); if E and E.Prev then E.Prev() end end,
	nextTab = function() local E = engine(); if E and E.Next then E.Next() end end,
	tabsLabel = L["Steps"],
	back = function() G.StopFocus() end,
	backLabel = L["Back to the game"],
	close = false,
}

function G.IsFocusing() return focusing end

-- -> true when the guide window now holds the gamepad.
function G.StartFocus()
	if focusing then return true end
	F = rawget(_G, "PolestarGuideFrame")
	if not F then return false end
	if combat() then return false end
	if not G.IsActive() then
		ns.Print(L["Browsing the guide needs the game's gamepad interface (Options, Gamepad, Enable Gamepad UI), or Use with the keyboard and mouse on Polestar's Gamepad page with a gamepad plugged in."])
		return false
	end
	if not F:IsShown() then ns.Set("ui.shown", true) end
	if ns.Get("ui.compact") then ns.Set("ui.compact", false) end
	if not F:IsShown() then return false end
	if not F.psFocusHooked then
		F.psFocusHooked = true
		F:HookScript("OnHide", function() G.StopFocus() end)
	end
	focusing = true
	G.Open(F, spec, true)
	return true
end

function G.StopFocus()
	if not focusing then return end
	focusing = false
	leave(tipped)
	G.Close(F)
end

-- The focus binding: a window that showed on its own and waits takes the
-- gamepad first; else focus mode starts or ends.
function G.ToggleFocus()
	if focusing then
		G.StopFocus()
	elseif not G.TakeWaiting() then
		G.StartFocus()
	end
end

ns.On("TOGGLE_FOCUS", G.ToggleFocus)
ns.On("GAMEPAD_COMBAT", function() G.StopFocus() end)
-- The item button follows the step: A on its line follows it.
ns.On("STEP_UPDATED", function()
	if focusing and G.entry and G.entry.frame == F then spec.onFocus(G.Focused(F)) end
end)

---------------------------------------------------------------------------
-- Binding rows (the options registry's `binding` control): label left, the
-- bound key or buttons as chips right. A (a click) waits for a key, a button
-- or two buttons; Y (a right-click) unbinds what the row shows. A key someone
-- else has asks first: the row says who, and binding again replaces it.
---------------------------------------------------------------------------

local bindingRows = setmetatable({}, { __mode = "k" })
local ARM_SECONDS = 5

local function howTo(row)
	if G.IsActive() then
		local a, y, b = G.ButtonName("PAD1"), G.ButtonName("PAD4"), G.ButtonName("PAD2")
		if row.psChords then
			return string.format(L["%s, then press a button, or hold one and press another. Tap %s to cancel, hold it to bind %s. %s unbinds."], a, b, b, y)
		end
		return string.format(L["%s, then press a button. Tap %s to cancel, hold it to bind %s. %s unbinds."], a, b, b, y)
	end
	return L["Click, then press a key; Escape cancels. Right-click unbinds."]
end

local function refreshRow(row)
	local v = row.Value
	row.psTipLines = { row.psDesc, howTo(row) }
	if row.psWaiting or row.psSay or row.psArmed then
		row.Keys:Hide()
		v:ClearAllPoints()
		v:SetPoint("RIGHT", row, "RIGHT", -12, 0)
		if row.psArmed then
			v:SetText(G.ConflictText(row.psArmed, row.psWho))
			W.Color(v, "danger")
		elseif row.psSay then
			v:SetText(row.psSay)
			W.Color(v, "warning")
		else
			v:SetText(G.IsActive() and L["Press a button…"] or L["Press a key…"])
			W.Color(v, "accent")
		end
		return
	end
	local keys = G.ShownKeys(row.psBinding)
	if #keys > 0 then
		local w = row.Keys:SetKeys(keys[1])
		row.Keys:Show()
		v:ClearAllPoints()
		v:SetPoint("RIGHT", row, "RIGHT", -12 - w - (#keys > 1 and 6 or 0), 0)
		v:SetText(#keys > 1 and string.format(L["+%d"], #keys - 1) or "")
		W.Color(v, "textMuted")
	else
		row.Keys:Hide()
		v:ClearAllPoints()
		v:SetPoint("RIGHT", row, "RIGHT", -12, 0)
		v:SetText(L["Not bound"])
		W.Color(v, "textMuted")
	end
end

local function disarm(row)
	row.psArmed, row.psWho = nil, nil
	row:Refresh()
end

local function bindingClick(row, button)
	if combat() then return end
	if button == "RightButton" then
		if G.IsCapturing() then return G.StopCapture(nil) end
		row.psArmed, row.psWho, row.psSay = nil, nil, nil
		G.Unbind(row.psBinding)
		row:Refresh()
		return
	end
	if row.psArmed then
		local key = row.psArmed
		disarm(row)
		if not G.Bind(row.psBinding, key) then row.psSay = L["The game refused that key."] end
		row:Refresh()
		return
	end
	row.psWaiting, row.psSay = true, nil
	row:Refresh()
	G.Capture({
		chords = row.psChords,
		say = function(text)
			row.psSay = text
			row:Refresh()
		end,
		done = function(key)
			row.psWaiting, row.psSay = nil, nil
			if key then
				local who = G.WhoUses(row.psBinding, key)
				if who then
					row.psArmed, row.psWho = key, who
					local armed = key
					if C_Timer and C_Timer.After then
						C_Timer.After(ARM_SECONDS, function() if row.psArmed == armed then disarm(row) end end)
					end
				elseif not G.Bind(row.psBinding, key) then
					row.psSay = L["The game refused that key."]
				end
			end
			row:Refresh()
			G.UpdateDriver()
		end,
	})
end

-- c = { kind = "binding", action, label, help }
function G.BindingRow(parent, c)
	local row = W.InfoRow(parent, c.label, c.help)
	row.psBinding = c.action
	row.psChords = G.ChordAllowed(c.action)
	ns.Theme.Font(row.Value, "small")
	row.Keys = G.Glyph(row)
	row.Keys:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	row:SetScript("OnClick", bindingClick)
	row.Refresh = refreshRow
	bindingRows[row] = true
	row:Refresh()
	return row
end

local function refreshRows()
	for row in pairs(bindingRows) do row:Refresh() end
end
ns.On("GAMEPAD_BINDINGS_CHANGED", refreshRows)
ns.On("GAMEPAD_CHANGED", refreshRows)
ns.RegisterEvent("UPDATE_BINDINGS", refreshRows)
ns.On("SETTING_CHANGED", function(path)
	if path == "gamepad.glyphs" or path == "gamepad" or path == "" then refreshRows() end
end)

---------------------------------------------------------------------------
-- The Gamepad options page
---------------------------------------------------------------------------

local PAGE, NAV, KEYS = L["Gamepad"], L["Navigation"], L["Key bindings"]
local ORDER = 75

ns.RegisterOptions({
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
		{ kind = "toggle", key = "gamepad.navigate", label = L["Navigate Polestar's windows"],
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
	ns.RegisterOptions({
		page = PAGE, key = "gamepad", icon = "gamepad", order = ORDER, tab = KEYS, section = SECTIONS[a.section],
		controls = { { kind = "binding", action = a.action, label = a.label, help = HELP[a.action] } },
	})
end
