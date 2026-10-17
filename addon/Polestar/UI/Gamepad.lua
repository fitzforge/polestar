-- Adapted from Ding! by Yendi (@moust4ki), GPL-3.0: https://github.com/moust4ki/DingGuideWoWForever
--
-- Polestar.Gamepad: playing Polestar with a gamepad (docs/ARCHITECTURE.md,
-- "Gamepad"). The button names and their chips, the game's key bindings and
-- Polestar's own chords (hold one gamepad button, press another), capturing
-- a button for a binding, and the navigation of every Polestar window: a
-- window that registers (G.Register) holds the D-pad, A, B, X, Y, LB, RB and
-- Start while it is the newest one open, read first by a frame of Polestar's
-- (PolestarPadInput) and, with the keyboard and mouse interface, through
-- temporary override bindings under it, set out of combat and cleared when
-- it closes or a fight starts. With Forever's gamepad interface on
-- (ns.GamepadUI) no override binding is set: its own bindings stay as they
-- are, and the frame alone reads the window's buttons. A window that showed
-- on its own (a route choice, the welcome) waits for the player to ask
-- before it takes the gamepad. Nothing is taken from the game while no
-- Polestar window holds the gamepad. The guide window's focus mode
-- (UI/GamepadGuide.lua) holds it the same way.
--
-- Client calls (C_GamePad, the CVars, the binding API, IsKeyDown, the
-- OnGamePadButton scripts) are made here, each guarded: a client without one
-- of them loses that part, never the rest.

local ADDON, ns = ...
local G = {}
ns.Gamepad = G

local L = ns.L
local Theme, W = ns.Theme, ns.Widgets
local type, pairs, ipairs, pcall, next = type, pairs, ipairs, pcall, next
local floor, max, min, abs = math.floor, math.max, math.min, math.abs
local tinsert, tremove, concat = table.insert, table.remove, table.concat

ns.RegisterDefaults("gamepad", {
	glyphs = "auto", -- "auto" (the gamepad's own labels) | "xbox" | "playstation"
	navigate = true, -- Polestar's windows hold the gamepad while open
	hints = true, -- the hint bar and the B chip on a window's close button
	withMouse = false, -- the gamepad drives Polestar with the keyboard and mouse interface too
})

-- Polestar's chords live outside the settings, account-wide, so "Reset all
-- settings" keeps them like the game keeps its key bindings:
-- PolestarDB.gamepad = { chords = { [action] = "PADRSHOULDER+PADDUP" } }.
local function store()
	local db = ns.DB()
	if type(db.gamepad) ~= "table" then db.gamepad = {} end
	if type(db.gamepad.chords) ~= "table" then db.gamepad.chords = {} end
	return db.gamepad
end
G.Store = store

-- The keys a window takes while it holds the gamepad.
local NAV_KEYS = {
	"PAD1", "PAD2", "PAD3", "PAD4", "PADLSHOULDER", "PADRSHOULDER",
	"PADDUP", "PADDDOWN", "PADDLEFT", "PADDRIGHT", "PADFORWARD",
}
G.NAV_KEYS = NAV_KEYS
local REPEATING = { PADDUP = true, PADDDOWN = true, PADDLEFT = true, PADDRIGHT = true }
local MAX_HOLD = 10 -- seconds: a held D-pad stops repeating if its release was never seen
local REPEAT_DELAY, REPEAT_EVERY = 0.4, 0.12

local function combat() return InCombatLockdown and InCombatLockdown() and true or false end

-- From PLAYER_REGEN_DISABLED to PLAYER_REGEN_ENABLED (see Events): nothing
-- takes the gamepad, not even in the moment before the lockdown starts (a
-- window closing as the fight starts hands it to none).
local fighting = false

---------------------------------------------------------------------------
-- Is a gamepad in use?
---------------------------------------------------------------------------

-- A console variable, nil when empty or "none".
local function cvar(name)
	local get = (C_CVar and C_CVar.GetCVar) or GetCVar
	if type(get) ~= "function" then return nil end
	local ok, value = pcall(get, name)
	if ok and type(value) == "string" and value ~= "" and value:upper() ~= "NONE" then return value end
	return nil
end

-- A gamepad the player can use: Forever's gamepad interface style
-- (ns.GamepadUI). With the keyboard and mouse interface only when the
-- player asks for it (gamepad.withMouse) and the gamepad is turned on in the
-- game's options and plugged in: a pad left on for movement must not put
-- gamepad hints and a focus ring on the windows of a mouse player. Turned
-- on but unplugged, the gamepad help would name buttons nobody can press:
-- everything reads as mouse and keyboard then.
function G.IsActive()
	if ns.GamepadUI() then return true end
	if not ns.Get("gamepad.withMouse") then return false end
	local enabled = false
	if C_GamePad and C_GamePad.IsEnabled then
		local ok, value = pcall(C_GamePad.IsEnabled)
		enabled = ok and value == true
	end
	if not enabled and cvar("GamePadEnable") ~= "1" then return false end
	if C_GamePad and C_GamePad.GetAllDeviceIDs then
		local ok, ids = pcall(C_GamePad.GetAllDeviceIDs)
		if ok and type(ids) == "table" and #ids == 0 then return false end
	end
	return true
end

-- "xbox" | "playstation": the player's choice, else the labels the game
-- reads off the gamepad itself ("Shapes": a PlayStation pad).
function G.Style()
	local s = ns.Get("gamepad.glyphs")
	if s == "xbox" or s == "playstation" then return s end
	local P = C_GamePad
	if P and P.GetActiveDeviceID and P.GetDeviceMappedState then
		local ok, state = pcall(function() return P.GetDeviceMappedState(P.GetActiveDeviceID()) end)
		if ok and type(state) == "table" and state.labelStyle == "Shapes" then return "playstation" end
	end
	return "xbox"
end

---------------------------------------------------------------------------
-- Button names (texts) and chips (G.Glyph)
---------------------------------------------------------------------------

local DPAD = { PADDUP = "chevron-up", PADDDOWN = "chevron-down", PADDLEFT = "chevron-left", PADDRIGHT = "chevron-right" }
local DPAD_TEXT = { PADDUP = L["D-pad up"], PADDDOWN = L["D-pad down"], PADDLEFT = L["D-pad left"], PADDRIGHT = L["D-pad right"] }
local NAMES = {
	xbox = {
		PAD1 = "A", PAD2 = "B", PAD3 = "X", PAD4 = "Y",
		PADLSHOULDER = "LB", PADRSHOULDER = "RB", PADLTRIGGER = "LT", PADRTRIGGER = "RT",
		PADLSTICK = "LS", PADRSTICK = "RS", PADFORWARD = "Start", PADBACK = "Back",
	},
	playstation = {
		PAD1 = L["Cross"], PAD2 = L["Circle"], PAD3 = L["Square"], PAD4 = L["Triangle"],
		PADLSHOULDER = "L1", PADRSHOULDER = "R1", PADLTRIGGER = "L2", PADRTRIGGER = "R2",
		PADLSTICK = "L3", PADRSTICK = "R3", PADFORWARD = L["Options button"], PADBACK = "Share",
	},
}
-- Face buttons sit in a circle: Xbox's letter, PlayStation's shape.
local FACE = { PAD1 = "A", PAD2 = "B", PAD3 = "X", PAD4 = "Y" }
local SHAPES = { PAD1 = "pad-cross", PAD2 = "pad-circle", PAD3 = "pad-square", PAD4 = "pad-triangle" }

-- Binding strings list modifiers in this order: ALT-CTRL-SHIFT-KEY. The
-- game's gamepad settings can make a button act as one (LT as Shift).
local MODIFIERS = {
	{ prefix = "ALT-", cvar = "GamePadEmulateAlt", text = "Alt", down = "IsAltKeyDown" },
	{ prefix = "CTRL-", cvar = "GamePadEmulateCtrl", text = "Ctrl", down = "IsControlKeyDown" },
	{ prefix = "SHIFT-", cvar = "GamePadEmulateShift", text = "Shift", down = "IsShiftKeyDown" },
}

local function modifierOf(button)
	for _, mod in ipairs(MODIFIERS) do
		if cvar(mod.cvar) == button then return mod end
	end
	return nil
end

-- The gamepad buttons the game makes modifiers, in binding order.
function G.ModifierButtons()
	local list = {}
	for _, mod in ipairs(MODIFIERS) do
		local button = cvar(mod.cvar)
		if button then list[#list + 1] = button end
	end
	return list
end

-- "SHIFT-PAD1" -> "PAD1".
local function baseKey(key)
	local rest, found = key, true
	while found do
		found = false
		for _, prefix in ipairs({ "ALT-", "CTRL-", "SHIFT-", "META-" }) do
			if rest:sub(1, #prefix) == prefix and #rest > #prefix then
				rest, found = rest:sub(#prefix + 1), true
			end
		end
	end
	return rest
end

-- A gamepad button ("PAD1", "SHIFT-PADDUP", a chord), not a keyboard key.
function G.IsPadKey(key)
	return type(key) == "string" and baseKey(key):sub(1, 3) == "PAD"
end

-- A chord of Polestar's: two gamepad buttons, the first held
-- ("PADLSHOULDER+PADDUP": LB + Up). The game binds a button with Shift, Ctrl
-- or Alt only, and its gamepad interface can go first: Polestar watches its
-- chords itself (see "Chords in play").
local function chordParts(key)
	if type(key) ~= "string" then return nil end
	return key:match("^(PAD%w+)%+(PAD%w+)$")
end

function G.IsChord(key) return chordParts(key) ~= nil end

function G.ButtonName(button)
	if DPAD_TEXT[button] then return DPAD_TEXT[button] end
	local name = NAMES[G.Style()][button]
	if name then return name end
	if GetBindingText then
		local ok, text = pcall(GetBindingText, button)
		if ok and type(text) == "string" and text ~= "" then return text end
	end
	return button
end

-- "SHIFT-PADDRIGHT" -> { "PADLTRIGGER", "PADDRIGHT" } (LT acts as Shift), a
-- chord into its two buttons; a keyboard key keeps its modifiers' names
-- ({ { word = "Ctrl" }, "N" }).
local function splitKey(key)
	local hold, press = chordParts(key)
	if hold then return { hold, press } end
	local parts, rest = {}, key
	local pad = G.IsPadKey(key)
	for _, mod in ipairs(MODIFIERS) do
		if rest:sub(1, #mod.prefix) == mod.prefix then
			rest = rest:sub(#mod.prefix + 1)
			parts[#parts + 1] = pad and cvar(mod.cvar) or { word = mod.text }
		end
	end
	parts[#parts + 1] = rest
	return parts
end

-- "SHIFT-PADDRIGHT" -> "LT + D-pad right".
function G.KeyName(key)
	local names = {}
	for i, part in ipairs(splitKey(key)) do
		names[i] = type(part) == "table" and part.word or G.ButtonName(part)
	end
	return concat(names, " + ")
end

local CHIP_H = 20

-- One chip per button: a circle for a face button (Xbox's letter or
-- PlayStation's shape) and the D-pad (its chevron), a capsule for the rest
-- ("LB", "Ctrl"), "+" between the buttons of a combination. Neutral chip
-- wash, the name in text: the One Accent Rule keeps the accent for focus.
local function glyphPart(f, i)
	local p = f.parts[i]
	if p then return p end
	p = {}
	p.bg = W.Pill(f, CHIP_H, CHIP_H)
	p.text = W.Text(f, "caption", "text")
	p.text:SetJustifyH("CENTER")
	p.tex = f:CreateTexture(nil, "OVERLAY")
	p.tex:SetSize(12, 12)
	W.Color(p.tex, "text")
	p.plus = W.Text(f, "small", "textDim")
	p.plus:SetText("+")
	f.parts[i] = p
	return p
end

local function paintGlyph(f)
	local r, g, b, a = Theme.Wash("chip")
	for _, p in ipairs(f.parts) do p.bg:SetColor(r, g, b, a) end
end

-- keys: a binding key ("SHIFT-PAD1", "PADLSHOULDER+PADDUP", "CTRL-N") or a
-- list of buttons shown side by side ({ "PADLSHOULDER", "PADRSHOULDER" }).
-- -> width
local function setKeys(f, keys)
	local buttons, joined = keys, false
	if type(keys) == "string" then buttons, joined = splitKey(keys), true end
	local style = G.Style()
	local x, n = 0, 0
	for i, button in ipairs(buttons or {}) do
		n = n + 1
		local p = glyphPart(f, n)
		if i > 1 then
			if joined then
				p.plus:ClearAllPoints()
				p.plus:SetPoint("LEFT", f, "LEFT", x + 3, 0)
				p.plus:Show()
				x = x + 3 + p.plus:GetStringWidth() + 3
			else
				p.plus:Hide()
				x = x + 4
			end
		else
			p.plus:Hide()
		end
		local w = CHIP_H
		if type(button) == "table" then
			p.text:SetText(button.word)
			p.tex:Hide()
			p.text:Show()
			w = max(CHIP_H, floor(p.text:GetStringWidth() + 14 + 0.5))
		elseif DPAD[button] then
			p.tex:SetTexture(Theme.Media(DPAD[button]))
			p.tex:Show()
			p.text:Hide()
		elseif FACE[button] and style == "playstation" then
			p.tex:SetTexture(Theme.Media(SHAPES[button]))
			p.tex:Show()
			p.text:Hide()
		else
			p.text:SetText(FACE[button] or G.ButtonName(button))
			p.tex:Hide()
			p.text:Show()
			if not FACE[button] then w = max(CHIP_H, floor(p.text:GetStringWidth() + 14 + 0.5)) end
		end
		p.bg:SetSize(w, CHIP_H)
		p.bg:ClearAllPoints()
		p.bg:SetPoint("LEFT", f, "LEFT", x, 0)
		p.text:ClearAllPoints()
		p.text:SetPoint("CENTER", p.bg, "CENTER", 0, 0)
		p.tex:ClearAllPoints()
		p.tex:SetPoint("CENTER", p.bg, "CENTER", 0, 0)
		p.bg:Show()
		x = x + w
	end
	for i = n + 1, #f.parts do
		local p = f.parts[i]
		p.bg:Hide(); p.text:Hide(); p.tex:Hide(); p.plus:Hide()
	end
	paintGlyph(f)
	f:SetWidth(max(1, x))
	f.psKeys = keys
	return x
end

-- A chip (or chips) for a key: frame:SetKeys(keys) -> width. name: optional.
function G.Glyph(parent, name)
	local f = CreateFrame("Frame", name, parent)
	f:SetHeight(CHIP_H)
	f.parts = {}
	f.SetKeys = setKeys
	W.Painter(f, paintGlyph)
	return f
end

---------------------------------------------------------------------------
-- Saved bindings. As the game's own Key Bindings do it: a binding goes in
-- the action's binding context when the client has one, a new gamepad
-- button replaces the action's gamepad buttons and chord, a new key its
-- keys; the other kind stays (a key and a button for the same action).
---------------------------------------------------------------------------

-- Polestar's actions, in the order the Key bindings tab lists them. `run`:
-- what the binding runs (Bindings.xml), for a chord; the secure CLICK
-- bindings (the quest buttons) cannot run from a chord.
G.ACTIONS = {
	{ action = "POLESTAR_NEXT", section = "guide", label = L["Next step"], run = "Next" },
	{ action = "POLESTAR_PREV", section = "guide", label = L["Previous step"], run = "Prev" },
	{ action = "POLESTAR_FOCUS", section = "guide", label = L["Browse the guide with the gamepad"], run = "Focus" },
	{ action = "POLESTAR_TOGGLE", section = "guide", label = L["Toggle guide window"], run = "Toggle" },
	{ action = "POLESTAR_MENU", section = "windows", label = L["Open the guide menu"], run = "Menu" },
	{ action = "POLESTAR_OPTIONS", section = "windows", label = L["Open Polestar options"], run = "Options" },
	{ action = "POLESTAR_REPORT", section = "windows", label = L["Report a problem"], run = "Report" },
	{ action = "CLICK PolestarQuestItemButton:LeftButton", section = "buttons", label = L["Use quest item"] },
	{ action = "CLICK PolestarTargetButton:LeftButton", section = "buttons", label = L["Target quest mob"] },
	{ action = "CLICK PolestarRareButton:LeftButton", section = "buttons", label = L["Target rare"] },
	{ action = "CLICK PolestarHearthButton:LeftButton", section = "buttons", label = L["Use Hearthstone"] },
	{ action = "CLICK PolestarStepButton:LeftButton", section = "buttons", label = L["Use the step button"] },
	{ action = "CLICK PolestarTravelButton:LeftButton", section = "buttons", label = L["Use the travel button"] },
}
local RUN = {}
for _, a in ipairs(G.ACTIONS) do RUN[a.action] = a.run end

-- Can `action` take a chord (it is not a secure click)?
function G.ChordAllowed(action) return RUN[action] ~= nil end

local function contextOf(action)
	if not (C_KeyBindings and C_KeyBindings.GetBindingContextForAction) then return nil end
	local ok, context = pcall(C_KeyBindings.GetBindingContextForAction, action)
	return ok and type(context) == "number" and context or nil
end

-- The game's gamepad interface keeps its buttons in a binding context of
-- its own while it is on (Enum.BindingContext.GamepadModeInGameCore).
local function gamepadContext()
	local context = Enum and Enum.BindingContext and Enum.BindingContext.GamepadModeInGameCore
	if type(context) ~= "number" or not (C_KeyBindings and C_KeyBindings.IsBindingContextActive) then return nil end
	local ok, active = pcall(C_KeyBindings.IsBindingContextActive, context)
	return ok and active == true and context or nil
end

local function setBinding(key, action, context)
	if type(SetBinding) ~= "function" then return false end
	local ok, result
	if context then ok, result = pcall(SetBinding, key, action, context) else ok, result = pcall(SetBinding, key, action) end
	return ok and result ~= false
end

local function saveBindings()
	if type(SaveBindings) ~= "function" then return end
	local ok, set = pcall(GetCurrentBindingSet)
	pcall(SaveBindings, ok and set or 1)
end

-- A key in the game's bindings, or a chord in Polestar's (action nil:
-- unbound). A chord belongs to one action.
local function setKey(key, action, context)
	if not chordParts(key) then return setBinding(key, action, context) end
	local list = store().chords
	for other, chord in pairs(list) do
		if chord == key then list[other] = nil end
	end
	if action then list[action] = key end
	return true
end

-- Every key bound to `action`: its chord first, then the game's keys.
function G.BindingKeys(action)
	local list = {}
	local chord = store().chords[action]
	if chord then list[1] = chord end
	if type(GetBindingKey) ~= "function" then return list end
	local context = contextOf(action)
	local ok, keys = pcall(function()
		if context then return { GetBindingKey(action, nil, context) } end
		return { GetBindingKey(action) }
	end)
	if not ok then return list end
	for _, key in ipairs(keys) do
		if type(key) == "string" and key ~= "" then list[#list + 1] = key end
	end
	return list
end

-- The keys of `action` for the input in use: the gamepad's buttons while a
-- gamepad is active, the keyboard's without one (`pad`: that kind); the
-- other kind when that one has none.
function G.ShownKeys(action, pad)
	if pad == nil then pad = G.IsActive() end
	local mine, other = {}, {}
	for _, key in ipairs(G.BindingKeys(action)) do
		if G.IsPadKey(key) == pad then mine[#mine + 1] = key else other[#other + 1] = key end
	end
	return #mine > 0 and mine or other
end

function G.BindingKey(action) return G.ShownKeys(action)[1] end

-- The key or button of `action` in words ("RB + D-pad up"), or nil.
function G.KeyText(action)
	local key = G.BindingKey(action)
	return key and G.KeyName(key) or nil
end

local function bindingsChanged()
	ns.Fire("GAMEPAD_BINDINGS_CHANGED")
end

-- Unbinds what a binding row shows: its gamepad buttons, or its keys.
-- False in a fight: bindings change only out of combat.
function G.Unbind(action, pad)
	if combat() then return false end
	local context = contextOf(action)
	for _, key in ipairs(G.ShownKeys(action, pad)) do setKey(key, nil, context) end
	saveBindings()
	bindingsChanged()
	return true
end

-- Binds `key` (a key, a button, a chord) to `action` in place of the
-- action's keys of the same kind, and saves. False when the game refuses
-- it, or in a fight: the action keeps what it had.
function G.Bind(action, key)
	if combat() then return false end
	local context = contextOf(action)
	local pad, removed = G.IsPadKey(key), {}
	for _, old in ipairs(G.BindingKeys(action)) do
		if old ~= key and G.IsPadKey(old) == pad then
			setKey(old, nil, context)
			removed[#removed + 1] = old
		end
	end
	if not setKey(key, action, context) then
		for _, old in ipairs(removed) do setKey(old, action, context) end
		return false
	end
	saveBindings()
	bindingsChanged()
	return true
end

-- Addons known by the frames and commands of their override bindings.
local ADDONS = {
	{ find = "controllerkeyboard", name = "Easy Controller" },
	{ find = "easycontroller", name = "Easy Controller" },
	{ find = "consoleport", name = "ConsolePort" },
}

local function bindingName(action)
	local name = rawget(_G, "BINDING_NAME_" .. action)
	if type(name) == "string" and name ~= "" then return name end
	for _, a in ipairs(G.ACTIONS) do if a.action == action then return a.label end end
	return nil
end

local function actionAt(key, checkOverride, context)
	if type(GetBindingAction) ~= "function" then return "" end
	local ok, action
	if context then ok, action = pcall(GetBindingAction, key, checkOverride, context) else ok, action = pcall(GetBindingAction, key, checkOverride) end
	return ok and type(action) == "string" and action or ""
end

local function addonOf(action)
	local lower = action:lower()
	for _, addon in ipairs(ADDONS) do
		if lower:find(addon.find, 1, true) then return addon.name end
	end
	return L["another addon"]
end

local function isOurs(action) return action:find("^CLICK PolestarPad") ~= nil end

-- Easy Controller's own chord (its settings' shortcut, RB + Down by
-- default), read from its saved settings, or nil.
function G.EasyControllerChord()
	local loaded = C_AddOns and C_AddOns.IsAddOnLoaded
	if not (loaded and loaded("EasyController")) then return nil end
	local db = rawget(_G, "ControllerKeyboardDB")
	local settings = type(db) == "table" and db.settings
	if type(settings) ~= "table" then return nil end
	if type(settings.features) == "table" and settings.features.configShortcut == false then return nil end
	local chord = settings.shortcut
	if type(chord) == "table" and type(chord.hold) == "string" and type(chord.press) == "string" then
		return chord.hold .. "+" .. chord.press
	end
	return nil
end

-- With the gamepad interface on, LB and RB are its targeting modifiers:
-- held, the D-pad and the face buttons pick group members, mark and assist;
-- both held, the D-pad pages the action bars and opens the quest tracker or
-- the chat (Blizzard_Gamepad's GamepadPersistentInputLegend.lua, with
-- GamepadSwapTargetModifiers swapping the two). A chord held on either is
-- the game's then.
local SHOULDERS = { PADLSHOULDER = true, PADRSHOULDER = true }

local function chordUsedBy(action, key)
	for other, chord in pairs(store().chords) do
		if chord == key and other ~= action then
			return { kind = "binding", name = bindingName(other) or other, action = other }
		end
	end
	if G.EasyControllerChord() == key then return { kind = "addon", name = "Easy Controller", action = key } end
	local hold, press = chordParts(key)
	if ns.GamepadUI() and SHOULDERS[hold] then
		return { kind = "gamepad", name = G.KeyName(key), action = key }
	end
	local mod = modifierOf(hold)
	if mod then
		local over, saved = actionAt(mod.prefix .. press, true), actionAt(mod.prefix .. press, false)
		if over ~= "" and over ~= saved and not isOurs(over) then
			return { kind = "addon", name = addonOf(over), action = over }
		end
	end
	return nil
end

-- Who else has `key`, or nil:
--   { kind = "addon", name }    another addon's override binding (Easy
--                               Controller...): it may win in play;
--   { kind = "gamepad", name }  the game's gamepad interface, while it is on;
--   { kind = "binding", name, action }  a saved binding (the game's or
--                               another of Polestar's), which binding replaces.
function G.WhoUses(action, key)
	if chordParts(key) then return chordUsedBy(action, key) end
	local saved = actionAt(key, false)
	local over = actionAt(key, true)
	if over ~= "" and over ~= saved and over ~= action and not isOurs(over) then
		return { kind = "addon", name = addonOf(over), action = over }
	end
	local context = gamepadContext()
	local own = context and actionAt(key, false, context) or ""
	if own ~= "" and own ~= saved and own ~= action then
		return { kind = "gamepad", name = bindingName(own) or own, action = own }
	end
	if saved ~= "" and saved ~= action then
		return { kind = "binding", name = bindingName(saved) or saved, action = saved }
	end
	return nil
end

-- Who else has `key`, in words, for a binding row waiting to be confirmed:
-- binding again replaces a saved binding, or binds over another's anyway.
function G.ConflictText(key, who)
	local again = G.IsActive() and string.format(L["%s again to bind it anyway."], G.ButtonName("PAD1")) or L["Click again to bind it anyway."]
	if who.kind == "binding" then return string.format(L["Used by %s."], who.name) .. " " .. again end
	if who.kind == "gamepad" then return string.format(L["The game's gamepad setup uses %s."], G.KeyName(key)) .. " " .. again end
	return string.format(L["%s uses %s."], who.name, G.KeyName(key)) .. " " .. again
end

---------------------------------------------------------------------------
-- Temporary navigation bindings and the frame that reads the gamepad first
---------------------------------------------------------------------------

G.held = {}      -- [key] = true while a taken key is down
G.heldKeys = {}  -- [key] = owner: down when the owner took the gamepad, the game's until released
G.redirected = {} -- [key] = true: a secure button's click instead of the handler

local driver -- forward: the OnUpdate frame (repeat, held keys, chords)
local updateDriver

local function protectedCall(fn, ...)
	if type(fn) ~= "function" or combat() then return false end
	return pcall(fn, ...)
end

local navButtons = {}
local function navButton(key)
	local b = navButtons[key]
	if b then return b end
	b = CreateFrame("Button", "PolestarPad" .. key, UIParent)
	b:RegisterForClicks("AnyDown", "AnyUp")
	b:SetScript("OnClick", function(_, _, down) G.Dispatch(key, down) end)
	navButtons[key] = b
	return b
end

local function buttonDown(button)
	if type(IsKeyDown) ~= "function" then return false end
	local ok, down = pcall(IsKeyDown, button)
	return ok and down == true
end

local padInput, chordInput

-- Whether the button a frame of Polestar's just read goes on to the game
-- (the client reads the frame's propagation as its handler ends). Out of
-- combat only: the client refuses the change in a fight.
local function passOn(frame, pass)
	if not frame or not frame.SetPropagateKeyboardInput or combat() then return end
	pcall(frame.SetPropagateKeyboardInput, frame, pass and true or false)
end

local function ourPress(key)
	return (padInput and padInput.eaten[key]) or (chordInput and chordInput.eaten[key]) or false
end

-- With the gamepad interface on, no override binding is set on its
-- buttons: they sit over the game's own (its targeting, its menus' focus),
-- which Forever's binding stack expects to find as it left them. The
-- window's frame (PolestarPadInput) reads its buttons first all the same.
local useOverrides = not ns.GamepadUI()

local function setOverride(owner, key, name)
	if not useOverrides then return end
	if not name then navButton(key) end
	protectedCall(SetOverrideBindingClick, owner, true, key, name or ("PolestarPad" .. key))
end

local function clearOverrides(owner)
	if useOverrides and owner then protectedCall(ClearOverrideBindings, owner) end
end

local function applyNav(owner, ours)
	for _, key in ipairs(NAV_KEYS) do
		if buttonDown(key) and not (ours and ours[key]) and not ourPress(key) then
			-- Pressed for the game (RB of the RB + Up that opened the
			-- window): its release must reach the game too.
			G.heldKeys[key] = owner
		else
			G.heldKeys[key] = nil
			setOverride(owner, key, G.redirected[key])
		end
	end
end

-- The window's buttons that were down when it took the gamepad, bound once released.
local function bindReleased()
	if not next(G.heldKeys) or combat() then return end
	for key, owner in pairs(G.heldKeys) do
		if owner ~= G.owner then
			G.heldKeys[key] = nil
		elseif not buttonDown(key) then
			G.heldKeys[key] = nil
			if not G.IsCapturing() and not G.redirected[key] then setOverride(owner, key) end
		end
	end
end

-- `down`: true on press, false on release, nil when the client does not say.
function G.Dispatch(key, down)
	if down == false then
		G.held[key] = nil
		if G.repeatKey == key then G.repeatKey = nil end
		return
	end
	if down == true then G.held[key] = true end
	if G.handler then G.handler(key, false) end
	if down == true and REPEATING[key] and G.owner then
		G.repeatKey, G.repeatWait, G.repeatAge = key, REPEAT_DELAY, 0
		updateDriver()
	end
end

-- The open window's buttons are read first by a frame of Polestar's
-- (OnGamePadButtonDown), before any binding: neither the game's gamepad
-- interface nor another addon's override bindings go first. Only the
-- window's keys are kept; any other button goes on to the game. The
-- override bindings stay under it for a client where the frame gets nothing.
local KEYSET = {}
for _, key in ipairs(NAV_KEYS) do KEYSET[key] = true end

local function onWindowPress(button)
	if not G.owner or G.IsCapturing() or not KEYSET[button] or G.redirected[button] or G.heldKeys[button] then
		passOn(padInput, true)
		return true
	end
	padInput.eaten[button] = true
	passOn(padInput, false)
	G.Dispatch(button, true)
	-- The press may have opened or closed a window, which set the frame up
	-- afresh: this press still stays Polestar's (the client reads the
	-- propagation as the handler ends).
	padInput.eaten[button] = true
	passOn(padInput, false)
	return false
end

local function onWindowRelease(button)
	if not padInput.eaten[button] then
		passOn(padInput, true)
		return true
	end
	padInput.eaten[button] = nil
	passOn(padInput, false)
	G.Dispatch(button, false)
	passOn(padInput, false)
	return false
end

local function setPadInput(on)
	if combat() then return end
	if not padInput then
		if not on then return end
		padInput = CreateFrame("Frame", "PolestarPadInput", UIParent)
		padInput:SetAllPoints(UIParent)
		padInput:SetFrameStrata("FULLSCREEN_DIALOG")
		padInput.eaten = {}
		pcall(padInput.SetScript, padInput, "OnGamePadButtonDown", function(_, button) return onWindowPress(button) end)
		pcall(padInput.SetScript, padInput, "OnGamePadButtonUp", function(_, button) return onWindowRelease(button) end)
	end
	padInput.eaten = {}
	passOn(padInput, true)
	padInput:SetShown(on)
	if padInput.EnableGamePadButton then pcall(padInput.EnableGamePadButton, padInput, on) end
end

-- `key` clicks the button named `name` instead of reaching the handler (a
-- secure button: focus mode uses the quest item with A), or nil to restore.
-- Through an override binding, so never with the gamepad interface: the key
-- stays the window's there.
function G.Redirect(key, name)
	if not useOverrides or G.redirected[key] == name then return end
	G.redirected[key] = name
	if not G.owner or G.heldKeys[key] then return end
	setOverride(G.owner, key, name)
end

-- Routes the navigation keys to handler(key, isRepeat) until G.Release(owner).
-- ours: keys down whose press was Polestar's (the A that opened this
-- window): their release stays Polestar's too.
function G.Take(owner, handler, ours)
	if fighting or combat() then return false end
	if G.owner and G.owner ~= owner then clearOverrides(G.owner) end
	G.owner, G.handler = owner, handler
	G.held, G.repeatKey = {}, nil
	applyNav(owner, ours)
	setPadInput(true)
	if ours then
		for key in pairs(ours) do if buttonDown(key) then padInput.eaten[key] = true end end
	end
	if chordInput and chordInput:IsShown() then chordInput:Hide() end
	updateDriver()
	return true
end

function G.Release(owner)
	clearOverrides(owner)
	for key, waiting in pairs(G.heldKeys) do
		if waiting == owner then G.heldKeys[key] = nil end
	end
	if G.owner == owner then
		G.owner, G.handler, G.repeatKey = nil, nil, nil
		G.held, G.redirected = {}, {}
		setPadInput(false)
	end
	updateDriver()
end

-- A Polestar window holds the gamepad's buttons (for other gamepad addons
-- that wish to leave it alone meanwhile).
function G.HasWindow() return G.owner ~= nil end

---------------------------------------------------------------------------
-- Chords in play: watched like Easy Controller's own RB + Down, both
-- buttons read with IsKeyDown, never bound (binding the second button while
-- the first is held broke the game's RB combinations). While a chord's first
-- button is held, out of combat, a frame of Polestar's reads the gamepad
-- first and keeps the chord's second button from the game; any other button
-- goes on. A chord does nothing in a fight, while a Polestar window holds
-- the gamepad, while a binding row waits, while the chat has the keyboard
-- or a game window the gamepad's focus, nor with another shoulder or
-- trigger held (LB + RB + Up is not RB + Up). The buttons are looked at
-- CHORD_POLL apart until a chord's first button is down, then every frame.
---------------------------------------------------------------------------

local CHORD_POLL = 0.05
local chordOn = {} -- [chord] = true: both buttons down, its action run once
local chordHeld = false -- a chord's first button was down at the last look

-- The chords bound, parsed once per change: { { action, key, hold, press }, ... }.
local chordList, chordSource, chordsDirty = {}, nil, true
ns.On("GAMEPAD_BINDINGS_CHANGED", function()
	chordsDirty = true
	updateDriver()
end)
local function chords()
	local list = store().chords
	if chordsDirty or list ~= chordSource then
		chordList, chordSource, chordsDirty = {}, list, false
		for action, key in pairs(list) do
			local hold, press = chordParts(key)
			if hold then chordList[#chordList + 1] = { action = action, key = key, hold = hold, press = press } end
		end
	end
	return chordList
end

local OTHER_HOLDS = { "PADLSHOULDER", "PADRSHOULDER", "PADLTRIGGER", "PADRTRIGGER" }
local function alone(hold, press)
	for i = 1, #OTHER_HOLDS do
		local b = OTHER_HOLDS[i]
		if b ~= hold and b ~= press and buttonDown(b) then return false end
	end
	return true
end

local function chordsFree()
	if combat() or G.owner or G.IsCapturing() then return false end
	if type(GetCurrentKeyBoardFocus) == "function" then
		local ok, focus = pcall(GetCurrentKeyBoardFocus)
		if ok and focus then return false end
	end
	-- The window the game's gamepad focus is on: its manager's field, read
	-- (what its GetActiveFrame returns), never a call into it.
	local mode = rawget(_G, "GamepadMode")
	local manager = type(mode) == "table" and rawget(mode, "FrameControlsManager")
	if type(manager) == "table" and rawget(manager, "focusedFrame") then return false end
	return true
end

local function runChord(action, key)
	if chordOn[key] then return end
	chordOn[key] = true
	-- Never in a fight: the window it opens could not take the gamepad, and
	-- the button went on to the game as well.
	if combat() then return end
	local run = RUN[action] and ns.Bindings and ns.Bindings[RUN[action]]
	if run then ns.SafeCall(run) end
end

local function onChordPress(button)
	if chordsFree() then
		local list = chords()
		for i = 1, #list do
			local c = list[i]
			if c.press == button and c.hold ~= button and buttonDown(c.hold) and alone(c.hold, button) then
				chordInput.eaten[button] = true
				passOn(chordInput, false)
				runChord(c.action, c.key)
				return false
			end
		end
	end
	passOn(chordInput, true)
	return true
end

local function onChordRelease(button)
	if not chordInput.eaten[button] then
		passOn(chordInput, true)
		return true
	end
	chordInput.eaten[button] = nil
	passOn(chordInput, false)
	return false
end

-- force: before a fight (the frame cannot change in combat).
local function setChordInput(on, force)
	if combat() then return end
	if not chordInput then
		if not on then return end
		chordInput = CreateFrame("Frame", "PolestarPadChords", UIParent)
		chordInput:SetAllPoints(UIParent)
		chordInput:SetFrameStrata("FULLSCREEN_DIALOG")
		chordInput.eaten = {}
		pcall(chordInput.SetScript, chordInput, "OnGamePadButtonDown", function(_, button) return onChordPress(button) end)
		pcall(chordInput.SetScript, chordInput, "OnGamePadButtonUp", function(_, button) return onChordRelease(button) end)
		chordInput:Hide()
	end
	if on == chordInput:IsShown() then return end
	-- A second button kept from the game: its release comes back here first.
	if not on and next(chordInput.eaten) and not force then return end
	if not on then chordInput.eaten = {} end
	passOn(chordInput, true)
	chordInput:SetShown(on)
	if chordInput.EnableGamePadButton then pcall(chordInput.EnableGamePadButton, chordInput, on) end
end

local function watchChords()
	local list = chords()
	local holding, free = false, nil
	for i = 1, #list do
		local c = list[i]
		local both = false
		if buttonDown(c.hold) then
			holding = true
			both = buttonDown(c.press)
		end
		if not both then
			chordOn[c.key] = nil
		else
			if free == nil then free = chordsFree() end
			if free and alone(c.hold, c.press) then runChord(c.action, c.key) end
		end
	end
	if holding and free == nil then free = chordsFree() end
	chordHeld = holding
	setChordInput(holding and free or false)
end

---------------------------------------------------------------------------
-- The driver: key repeat, held keys, chords, and the open window's focus
-- kept valid. It runs only while one of them needs it.
---------------------------------------------------------------------------

local sinceCheck, sinceChords = 0, 0
local checkFocus -- forward: the open window's focus and help, checked a few times a second

driver = CreateFrame("Frame")
driver:Hide()
driver:SetScript("OnUpdate", function(_, elapsed)
	bindReleased()
	sinceChords = sinceChords + elapsed
	if chordHeld or sinceChords >= CHORD_POLL then
		sinceChords = 0
		watchChords()
	end
	if G.owner then
		sinceCheck = sinceCheck + elapsed
		if sinceCheck >= 0.25 then
			sinceCheck = 0
			checkFocus()
		end
	end
	local key = G.repeatKey
	if not key then return end
	G.repeatAge = G.repeatAge + elapsed
	if G.repeatAge > MAX_HOLD then
		G.repeatKey = nil
		return
	end
	G.repeatWait = G.repeatWait - elapsed
	if G.repeatWait <= 0 then
		G.repeatWait = REPEAT_EVERY
		if G.handler then G.handler(key, true) end
	end
end)

function updateDriver()
	local need = G.owner ~= nil or G.repeatKey ~= nil or next(G.heldKeys) ~= nil
		or (next(store().chords) ~= nil and G.IsActive())
		or (chordInput ~= nil and chordInput:IsShown())
	driver:SetShown(need and true or false)
end
G.UpdateDriver = updateDriver

---------------------------------------------------------------------------
-- Capturing a key, a button or a chord (binding rows). The capture reads the
-- buttons itself (OnGamePadButtonDown / Up, OnKeyDown), with the window's
-- navigation released until it ends, and lets nothing through to the game.
-- A gamepad button is taken on its release when it was pressed alone, so a
-- held button can start a combination: a second button while it is held
-- makes a chord of Polestar's (opts.chords), or, for the quest buttons'
-- secure clicks, a combination of the game's when the first button is one
-- the game makes a modifier (LT, RT...), refused in words otherwise. B
-- tapped alone cancels; held HOLD_B seconds it is taken. Escape cancels, so
-- does a fight or CAPTURE_TIMEOUT seconds without a press.
---------------------------------------------------------------------------

local HOLD_B, CAPTURE_TIMEOUT = 1, 20
G.HOLD_B, G.CAPTURE_TIMEOUT = HOLD_B, CAPTURE_TIMEOUT

local IGNORED_KEYS = {
	LSHIFT = true, RSHIFT = true, LCTRL = true, RCTRL = true, LALT = true, RALT = true, LMETA = true,
	RMETA = true, SHIFT = true, CTRL = true, ALT = true, META = true, UNKNOWN = true, BUTTON1 = true,
	BUTTON2 = true,
}

local capture -- { held = { [button] = time }, single, spoiled, last, opts }

local function now() return GetTime and GetTime() or 0 end

local function isDown(fnName)
	local fn = rawget(_G, fnName)
	if type(fn) ~= "function" then return false end
	local ok, down = pcall(fn)
	return ok and down == true
end

-- "ALT-CTRL-SHIFT-" as far as held: the keyboard's modifiers and the held
-- gamepad buttons the game makes modifiers.
local function modifierPrefix(held)
	local prefix = ""
	for _, mod in ipairs(MODIFIERS) do
		local down = isDown(mod.down)
		if not down and held then
			local button = cvar(mod.cvar)
			down = button ~= nil and held[button] ~= nil
		end
		if down then prefix = prefix .. mod.prefix end
	end
	return prefix
end

local function setCaptureInput(frame, enabled)
	if frame.EnableGamePadButton then pcall(frame.EnableGamePadButton, frame, enabled) end
	if frame.EnableKeyboard then pcall(frame.EnableKeyboard, frame, enabled) end
	if enabled and frame.SetPropagateKeyboardInput then pcall(frame.SetPropagateKeyboardInput, frame, false) end
end

function G.StopCapture(key)
	local frame = G.captureFrame
	if not frame or not frame:IsShown() then return end
	local opts = capture and capture.opts or {}
	local held = capture and capture.held
	capture = nil
	setCaptureInput(frame, false)
	frame:Hide()
	if G.owner and not fighting and not combat() then
		-- The buttons still down were pressed for the capture: their release stays ours.
		applyNav(G.owner, held)
		setPadInput(true)
	end
	if opts.done then opts.done(key) end
end

local function say(text)
	if capture and capture.opts.say then capture.opts.say(text) end
end

local function take(key)
	local why = capture.opts.refuse and capture.opts.refuse(key)
	if why then
		say(why)
		capture.spoiled = next(capture.held) ~= nil
		return
	end
	G.StopCapture(key)
end

-- "RB + D-pad up" refused: the game joins a button with its modifiers only.
local function comboText(first, button)
	local combo = G.ButtonName(first) .. " + " .. G.ButtonName(button)
	local mods = {}
	for _, b in ipairs(G.ModifierButtons()) do mods[#mods + 1] = G.ButtonName(b) end
	if #mods == 0 then return string.format(L["%s: this action takes one button, not two"], combo) end
	return string.format(L["%s: this action takes one button, or one with %s"], combo, concat(mods, L[" or "]))
end

local function onPadDown(button)
	local c = capture
	if not c then return true end
	c.last = now()
	if c.held[button] then return false end
	-- The button held first (a chord's), and a held one the game makes no modifier.
	local first, firstAt, plain
	for b, at in pairs(c.held) do
		if not firstAt or at < firstAt then first, firstAt = b, at end
		if not modifierOf(b) then plain = b end
	end
	c.held[button] = c.last
	if c.spoiled then return false end
	if c.opts.chords and first then
		c.single = nil
		take(first .. "+" .. button)
		return false
	end
	-- A modifier waits for the button it goes with.
	if modifierOf(button) then return false end
	if plain then
		c.single, c.spoiled = nil, true
		say(comboText(plain, button))
		return false
	end
	local prefix = modifierPrefix(c.held)
	if prefix ~= "" then take(prefix .. button) else c.single = button end
	return false
end

local function onPadUp(button)
	local c = capture
	if not c then return true end
	c.held[button] = nil
	if c.spoiled then
		if not next(c.held) then c.spoiled = nil end
		return false
	end
	if c.single == button then
		c.single = nil
		if button == "PAD2" then G.StopCapture(nil) else take(modifierPrefix(c.held) .. button) end
	end
	return false
end

local function onKeyDown(key)
	local c = capture
	if not c or type(key) ~= "string" then return end
	-- Some clients send the gamepad's buttons here too: one press is read once.
	if G.IsPadKey(key) then
		onPadDown(baseKey(key))
		return
	end
	c.last = now()
	if IGNORED_KEYS[key] then return end
	local prefix = modifierPrefix(c.held)
	if key == "ESCAPE" and prefix == "" then
		G.StopCapture(nil)
		return
	end
	take(prefix .. key)
end

local function onKeyUp(key)
	if not (capture and type(key) == "string" and G.IsPadKey(key)) then return end
	if capture.held[baseKey(key)] then onPadUp(baseKey(key)) end
end

local function onCaptureUpdate()
	local c = capture
	if not c then return end
	local t = now()
	if c.single == "PAD2" and c.held.PAD2 and t - c.held.PAD2 >= HOLD_B then
		c.single = nil
		take(modifierPrefix(c.held) .. "PAD2")
	elseif t - c.last >= CAPTURE_TIMEOUT then
		G.StopCapture(nil)
	end
end

-- opts.done(key): the key taken ("SHIFT-PADDRIGHT", "PADLSHOULDER+PADDUP",
-- "CTRL-N"), nil when cancelled; opts.chords: two buttons make a chord of
-- Polestar's; opts.refuse(key) -> text | nil: why that key cannot be taken
-- (the capture goes on); opts.say(text): a word while it goes on.
function G.Capture(opts)
	if combat() then return false end
	if type(opts) == "function" then opts = { done = opts } end
	local frame = G.captureFrame
	if not frame then
		frame = CreateFrame("Frame", "PolestarPadCapture", UIParent)
		frame:SetAllPoints(UIParent)
		frame:SetFrameStrata("FULLSCREEN_DIALOG")
		pcall(frame.SetScript, frame, "OnGamePadButtonDown", function(_, button) return onPadDown(button) end)
		pcall(frame.SetScript, frame, "OnGamePadButtonUp", function(_, button) return onPadUp(button) end)
		pcall(frame.SetScript, frame, "OnKeyDown", function(_, key) onKeyDown(key) end)
		pcall(frame.SetScript, frame, "OnKeyUp", function(_, key) onKeyUp(key) end)
		frame:SetScript("OnUpdate", onCaptureUpdate)
		frame:Hide()
		G.captureFrame = frame
	end
	if frame:IsShown() then G.StopCapture(nil) end
	capture = { held = {}, last = now(), opts = opts }
	clearOverrides(G.owner)
	setPadInput(false)
	frame:Show()
	setCaptureInput(frame, true)
	return true
end

function G.IsCapturing()
	return G.captureFrame ~= nil and G.captureFrame:IsShown()
end

---------------------------------------------------------------------------
-- Window navigation (the contract: docs/ARCHITECTURE.md, "Gamepad")
--
-- G.Register(frame, spec): while `frame` is shown and the newest registered
-- window open, out of combat, with a gamepad active and "Navigate Polestar's
-- windows" on, the gamepad moves a focus through spec.rows():
--   D-pad      the nearest widget that way (in reading order without layout);
--              left / right adjust a slider or step a dropdown's choices
--   A          clicks the focused widget (spec.activate(w) first)
--   B, Start   spec.back(), else hides the window
--   Y          spec.reset(w), else a setting row's right-click (its default)
--   X          spec.x(w)
--   LB / RB    spec.prevTab() / spec.nextTab()
-- Optional: spec.initial(rows) -> index; spec.key(key, w) -> true when it
-- handled the key; spec.actionLabel(w), spec.xLabel(w), spec.backLabel,
-- spec.tabsLabel, spec.resetLabel(w) word the hint bar; spec.onFocus(w).
---------------------------------------------------------------------------

local specs = setmetatable({}, { __mode = "k" })
local stack = {} -- open windows, newest last: { frame, spec, focus, manual }

local function entryOf(frame)
	for i, e in ipairs(stack) do if e.frame == frame then return e, i end end
	return nil
end

local function clickable(f)
	local kind = f.GetObjectType and f:GetObjectType()
	if kind ~= "Button" and kind ~= "CheckButton" then return false end
	return f:GetScript("OnClick") ~= nil
end

-- Every shown, enabled, clickable widget under `root` (the outermost one:
-- a row's own buttons are the row's), in the frame tree's order. Walked
-- over GetChildren's values, with no table per frame: it runs a few times a
-- second while a window holds the gamepad.
local function collectFrom(out, ...)
	for i = 1, select("#", ...) do
		local c = select(i, ...)
		if c:IsShown() and not c.psPadSkip then
			if clickable(c) then
				if c:IsEnabled() and (c:GetAlpha() or 1) > 0.05 then out[#out + 1] = c end
			else
				collectFrom(out, c:GetChildren())
			end
		end
	end
end

function G.Collect(root, out)
	out = out or {}
	if root then collectFrom(out, root:GetChildren()) end
	return out
end

-- Is `w` under `ancestor`?
function G.Within(w, ancestor)
	local f = w
	while f do
		if f == ancestor then return true end
		f = f:GetParent()
	end
	return false
end

local function usable(w)
	return w and w:IsVisible() and (not w.IsEnabled or w:IsEnabled())
end

local function rowsOf(e)
	local ok, list = pcall(e.spec.rows or function() return G.Collect(e.frame) end)
	local out = {}
	if ok and type(list) == "table" then
		for _, w in ipairs(list) do if usable(w) then out[#out + 1] = w end end
	end
	return out
end

local function rect(w)
	local l, b, wd, h = w:GetLeft(), w:GetBottom(), w:GetWidth(), w:GetHeight()
	if not (l and b and wd and h) then return nil end
	return l, b, wd, h
end

-- Laid out: the widgets have places (a client, the preview); the test
-- stub's frames do not, and walk the list in order.
local function laidOut(rows)
	local first
	for _, w in ipairs(rows) do
		local l, b = rect(w)
		if l then
			local p = l .. ":" .. b
			if first and p ~= first then return true end
			first = first or p
		end
	end
	return false
end

local function indexOf(rows, w)
	for i, r in ipairs(rows) do if r == w then return i end end
	return nil
end

-- The nearest widget from `cur` in direction dx, dy (one of them 0): its
-- distance that way plus twice how far it sits off the line.
local function nearest(rows, cur, dx, dy)
	local l, b, w, h = rect(cur)
	if not l then return nil end
	local cx, cy = l + w / 2, b + h / 2
	local best, bestScore
	for _, o in ipairs(rows) do
		if o ~= cur then
			local ol, ob, ow, oh = rect(o)
			if ol then
				local ox, oy = ol + ow / 2, ob + oh / 2
				local primary, off
				if dy ~= 0 then
					primary = dy > 0 and (oy - cy) or (cy - oy)
					off = max(0, max(l, ol) - min(l + w, ol + ow))
				else
					primary = dx > 0 and (ox - cx) or (cx - ox)
					off = max(0, max(b, ob) - min(b + h, ob + oh))
				end
				if primary > 1 then
					local score = primary + off * 2
					if not bestScore or score < bestScore then best, bestScore = o, score end
				end
			end
		end
	end
	return best
end

-- The scroll area holding `w`, if any.
local function scrollOf(w)
	local f = w:GetParent()
	while f do
		if f.GetObjectType and f:GetObjectType() == "ScrollFrame" then return f end
		f = f:GetParent()
	end
	return nil
end

-- Scrolls the focus into view.
local function reveal(w)
	local sf = scrollOf(w)
	if not sf or not sf.GetScrollChild then return end
	local child = sf:GetScrollChild()
	local top, wt, wb = child and child:GetTop(), w:GetTop(), w:GetBottom()
	if not (top and wt and wb) then return end
	local view = sf.psView or sf:GetHeight()
	local cur = sf:GetVerticalScroll()
	local a, z = top - wt, top - wb
	if a < cur then
		W.ScrollTo(sf, a - 8)
	elseif z > cur + view then
		W.ScrollTo(sf, z - view + 8)
	end
end

---------------------------------------------------------------------------
-- The focus ring, the B chip and the hint bar
---------------------------------------------------------------------------

-- One ring, one hint bar and one B chip serve every window, each moved to
-- the window holding the gamepad (named, so previews can draw them).

-- A 2px accent ring inside the focused widget over the hover wash: the
-- mouse's hover, held, and marked as Polestar marks focus.
local ring
local function theRing()
	if ring then return ring end
	local r = CreateFrame("Frame", "PolestarPadRing", UIParent)
	r.Wash = r:CreateTexture(nil, "BACKGROUND")
	r.Wash:SetTexture(Theme.Media("white"))
	r.Wash:SetAllPoints(r)
	r.edges = {}
	for i = 1, 4 do
		local t = r:CreateTexture(nil, "OVERLAY")
		t:SetTexture(Theme.Media("white"))
		r.edges[i] = t
	end
	local e = r.edges
	e[1]:SetPoint("TOPLEFT", r, "TOPLEFT", 0, 0); e[1]:SetPoint("TOPRIGHT", r, "TOPRIGHT", 0, 0); e[1]:SetHeight(2)
	e[2]:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0); e[2]:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", 0, 0); e[2]:SetHeight(2)
	e[3]:SetPoint("TOPLEFT", e[1], "BOTTOMLEFT", 0, 0); e[3]:SetPoint("BOTTOMLEFT", e[2], "TOPLEFT", 0, 0); e[3]:SetWidth(2)
	e[4]:SetPoint("TOPRIGHT", e[1], "BOTTOMRIGHT", 0, 0); e[4]:SetPoint("BOTTOMRIGHT", e[2], "TOPRIGHT", 0, 0); e[4]:SetWidth(2)
	W.Painter(r, function(f)
		local ar, ag, ab = Theme.Accent()
		for i = 1, 4 do f.edges[i]:SetVertexColor(ar, ag, ab, 0.9) end
		f.Wash:SetVertexColor(Theme.Wash("hover"))
	end)
	r:EnableMouse(false)
	r:Hide()
	ring = r
	return r
end

-- The hint bar: a panel of chip + label entries, 16 apart, a chip 6 before
-- its label, wrapping onto a second line rather than leaving one out.
local HINT_LINE, HINT_PAD, HINT_MIN = 24, 12, 300
local bar
local function theBar()
	if bar then return bar end
	bar = CreateFrame("Frame", "PolestarPadHints", UIParent)
	Theme.Skin(bar, "panel")
	bar.items = {}
	bar:SetClampedToScreen(true)
	bar:Hide()
	return bar
end

-- list = { { keys, label }, ... }; maxWidth: the room. -> width, height
local function setHints(list, maxWidth)
	local b = theBar()
	local x, y, widest = HINT_PAD, 0, 0
	for i, h in ipairs(list) do
		local it = b.items[i]
		if not it then
			it = { glyph = G.Glyph(b), label = W.Text(b, "small", "textDim") }
			b.items[i] = it
		end
		local gw = it.glyph:SetKeys(h.keys)
		it.label:SetText(h.label)
		local w = gw + 6 + it.label:GetStringWidth()
		if x > HINT_PAD and x + w + HINT_PAD > maxWidth then
			widest = max(widest, x - 16)
			x, y = HINT_PAD, y + 1
		end
		local cy = -(4 + y * HINT_LINE + HINT_LINE / 2)
		it.glyph:ClearAllPoints()
		it.glyph:SetPoint("LEFT", b, "TOPLEFT", x, cy)
		it.glyph:Show()
		it.label:ClearAllPoints()
		it.label:SetPoint("LEFT", b, "TOPLEFT", x + gw + 6, cy)
		it.label:Show()
		x = x + w + 16
	end
	for i = #list + 1, #b.items do
		b.items[i].glyph:Hide()
		b.items[i].label:Hide()
	end
	widest = max(widest, x - 16)
	local width, height = floor(widest + HINT_PAD + 0.5), (y + 1) * HINT_LINE + 8
	b:SetSize(width, height)
	return width, height
end

local badge
local function theBadge()
	if badge then return badge end
	badge = G.Glyph(UIParent, "PolestarPadBadge")
	badge:Hide()
	return badge
end

-- What A, Y and the D-pad do on a widget, in words.
local function adjustable(w)
	return (w.Slider ~= nil and w.psStep ~= nil) or (w.psChoices ~= nil and w.Button ~= nil)
end

local function actionLabel(e, w)
	if e.spec.actionLabel then
		local text = e.spec.actionLabel(w)
		if text ~= nil then return text or nil end
	end
	if w.psPadLabel then return w.psPadLabel end
	if w.Slider and w.psStep then return nil end
	if w.psBinding then return L["Bind"] end
	if w.psChoices then return L["Choose"] end
	if type(w.Track) == "table" and type(w.Knob) == "table" then return L["Switch"] end
	return L["Select"]
end

local function resetLabel(e, w)
	if e.spec.resetLabel then return e.spec.resetLabel(w) end
	if w.psBinding then return L["Unbind"] end
	if w.psPath ~= nil then return L["Default"] end
	return nil
end

-- The B chip goes on the window's close button when it has one shown; the
-- hint bar then leaves B out (each action shown once).
local function closeButton(e)
	local c = e.spec.close
	if type(c) == "function" then c = c() end
	if c == nil then c = e.frame.Close end
	if type(c) == "table" and c.IsVisible and c:IsVisible() then return c end
	return nil
end

local function hintsOf(e, w, onClose)
	local list = {}
	list[#list + 1] = { keys = { "PADDUP", "PADDDOWN" }, label = L["Move"] }
	if w and adjustable(w) then list[#list + 1] = { keys = { "PADDLEFT", "PADDRIGHT" }, label = L["Adjust"] } end
	local a = w and actionLabel(e, w)
	if a then list[#list + 1] = { keys = "PAD1", label = a } end
	local x = w and e.spec.xLabel and e.spec.xLabel(w)
	if x then list[#list + 1] = { keys = "PAD3", label = x } end
	local y = w and resetLabel(e, w)
	if y then list[#list + 1] = { keys = "PAD4", label = y } end
	if e.spec.prevTab or e.spec.nextTab then
		list[#list + 1] = { keys = { "PADLSHOULDER", "PADRSHOULDER" }, label = e.spec.tabsLabel or L["Tabs"] }
	end
	if not onClose then list[#list + 1] = { keys = "PAD2", label = e.spec.backLabel or L["Close"] } end
	return list
end

local function hidePaint()
	if ring then ring:Hide() end
	if bar then bar:Hide() end
	if badge then badge:Hide() end
end

-- The hint bar under the window, at its left edge, kept on the screen (a
-- window at the screen's foot has it over its own foot). It is the window's
-- child while it holds the gamepad: it scales and hides with it.
local function placeHints(e, b)
	local f = e.frame
	b:SetParent(f)
	b:ClearAllPoints()
	b:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0, -8)
end

local function paint(e)
	local w = e.focus
	local r = theRing()
	if w then
		-- The focused widget's child: clipped with it by a scrolled list.
		r:SetParent(w)
		r:ClearAllPoints()
		r:SetAllPoints(w)
		r:Show()
	else
		r:Hide()
	end
	local hints = ns.Get("gamepad.hints")
	local chip = theBadge()
	local close = hints and closeButton(e)
	if close then
		chip:SetParent(close:GetParent())
		chip:SetKeys("PAD2")
		chip:ClearAllPoints()
		chip:SetPoint("RIGHT", close, "LEFT", -4, 0)
		chip:Show()
	else
		chip:Hide()
	end
	local b = theBar()
	if hints then
		setHints(hintsOf(e, w, close ~= nil), max(HINT_MIN, e.frame:GetWidth() or 0))
		placeHints(e, b)
		b:Show()
	else
		b:Hide()
	end
end

-- Focus `w` (nil: none) in window entry `e`.
local function focus(e, w)
	local old = e.focus
	e.focus = w
	if old and old ~= w and GameTooltip and GameTooltip.GetOwner and GameTooltip:GetOwner() == old then GameTooltip:Hide() end
	if w then reveal(w) end
	if e.spec.onFocus then ns.SafeCall(e.spec.onFocus, w) end
	if G.entry == e then paint(e) end
end

-- Keeps the focus on a widget still there (a page change, a list redrawn).
-- Until the player presses a button, the focus follows spec.initial (a
-- window fills its page after it shows).
local function validate(e)
	local rows = rowsOf(e)
	local still = e.focus and indexOf(rows, e.focus)
	if still and (e.settled or not e.spec.initial) then return rows end
	local at = not e.settled and e.spec.initial and e.spec.initial(rows)
	if at then
		if rows[at] ~= e.focus then focus(e, rows[at]) end
		return rows
	end
	if still then return rows end
	local w = rows[1]
	if e.focus and e.index then w = rows[min(#rows, e.index)] or w end
	focus(e, w)
	return rows
end

function checkFocus()
	local e = G.entry
	if not e then return end
	local before = e.focus
	validate(e)
	if before == e.focus then paint(e) end
end

local function move(e, dx, dy)
	local rows = validate(e)
	local cur = e.focus
	if not cur then return end
	local target
	if laidOut(rows) then
		target = nearest(rows, cur, dx, dy)
		if not target then
			-- At a scrolled list's edge: scroll on, and look again.
			local sf = scrollOf(cur)
			if sf and dy ~= 0 then
				local before = sf:GetVerticalScroll()
				W.ScrollTo(sf, before - dy * (sf.psView or sf:GetHeight()) * 0.8)
				if sf:GetVerticalScroll() ~= before then
					rows = rowsOf(e)
					target = nearest(rows, cur, dx, dy)
				end
			end
		end
	else
		local i = indexOf(rows, cur) or 1
		target = rows[i + ((dx > 0 or dy < 0) and 1 or -1)]
	end
	if target then
		e.index, e.settled = indexOf(rows, target), true
		focus(e, target)
	end
end

-- Left / right on a slider steps it; on a dropdown, its choices.
local function adjust(w, delta)
	if w.Slider and w.psStep then
		if W.Enabled(w) then
			local fn = w.Slider:GetScript("OnMouseWheel")
			if fn then fn(w.Slider, delta) end
		end
		return true
	end
	if w.psChoices and w.Button then
		if not W.Enabled(w) then return true end
		local list = w.psChoices
		if type(list) == "function" then list = list() or {} end
		if #list == 0 then return true end
		local cur = w.psGet and w.psGet() or ns.Get(w.psPath)
		local at = 1
		for i, c in ipairs(list) do if c.value == cur then at = i end end
		local pick = list[max(1, min(#list, at + delta))]
		W.HideMenu()
		if pick and pick.value ~= cur then
			if w.psSet then w.psSet(pick.value) else ns.Set(w.psPath, pick.value) end
		end
		return true
	end
	return false
end

local function activate(e, w)
	if not w then return end
	if e.spec.activate and e.spec.activate(w) then return end
	local kind = w:GetObjectType()
	if kind == "EditBox" then
		w:SetFocus()
	elseif w.Click then
		w:Click("LeftButton")
	end
end

local function reset(e, w)
	if e.spec.reset and e.spec.reset(w) then return end
	if w and (w.psPath ~= nil or w.psBinding) and w.Click then w:Click("RightButton") end
end

local function navKey(key, isRepeat)
	local e = G.entry
	if not e then return end
	validate(e)
	-- A button pressed: the focus is the player's now (LB / RB start a page afresh).
	if key ~= "PADLSHOULDER" and key ~= "PADRSHOULDER" then e.settled = true end
	local w = e.focus
	if e.spec.key and e.spec.key(key, w, isRepeat) then
		if G.entry == e then checkFocus() end
		return
	end
	if key == "PADDUP" then
		move(e, 0, 1)
	elseif key == "PADDDOWN" then
		move(e, 0, -1)
	elseif key == "PADDLEFT" or key == "PADDRIGHT" then
		local delta = key == "PADDLEFT" and -1 or 1
		if not (w and adjustable(w) and adjust(w, delta)) then move(e, delta, 0) end
	elseif isRepeat then
		return
	elseif key == "PAD1" then
		activate(e, w)
	elseif key == "PAD2" or key == "PADFORWARD" then
		if e.spec.back then e.spec.back() else e.frame:Hide() end
	elseif key == "PAD4" then
		reset(e, w)
	elseif key == "PAD3" then
		if e.spec.x then e.spec.x(w) end
	elseif key == "PADLSHOULDER" or key == "PADRSHOULDER" then
		local fn = key == "PADLSHOULDER" and e.spec.prevTab or e.spec.nextTab
		if fn then
			fn()
			e.focus, e.index, e.settled = nil, nil, false
		end
	end
	if G.entry == e then checkFocus() end
end

-- May the newest open window hold the gamepad now? Not one waiting to be
-- asked (it showed on its own).
local function allowed(e)
	if fighting or combat() or e.waiting or not G.IsActive() then return false end
	return e.manual or ns.Get("gamepad.navigate")
end

-- A waiting window's hint bar: the focus binding's button, which gives it
-- the gamepad (G.TakeWaiting). Nothing when no button is bound to it.
local waitingShown
local function paintWaiting(e)
	if not ns.Get("gamepad.hints") then return false end
	local key = G.ShownKeys("POLESTAR_FOCUS", true)[1]
	if not (key and G.IsPadKey(key)) then return false end
	if ring then ring:Hide() end
	if badge then badge:Hide() end
	local b = theBar()
	setHints({ { keys = key, label = L["Use the gamepad here"] } }, max(HINT_MIN, e.frame:GetWidth() or 0))
	placeHints(e, b)
	b:Show()
	return true
end

-- The newest open window; nil when none is shown.
local function newest()
	for i = #stack, 1, -1 do
		local e = stack[i]
		if e.frame:IsShown() then return e end
	end
	return nil
end

-- The newest open window holds the gamepad; none: the game has it all.
local function refresh()
	local shown = newest()
	local top = shown
	if top and not allowed(top) then top = nil end
	local ours
	if padInput and padInput:IsShown() and next(padInput.eaten) then
		ours = {}
		for key in pairs(padInput.eaten) do ours[key] = true end
	end
	if G.entry and G.entry ~= top then
		hidePaint()
		G.Release(G.entry.frame)
		G.entry = nil
	end
	if top and G.entry ~= top then
		if G.Take(top.frame, navKey, ours) then
			G.entry = top
			validate(top)
			paint(top)
		end
	end
	if G.entry then
		waitingShown = nil
	elseif shown and shown.waiting and not fighting and not combat() and G.IsActive() and paintWaiting(shown) then
		waitingShown = shown
	elseif waitingShown then
		waitingShown = nil
		hidePaint()
	end
	updateDriver()
end
G.Refresh = refresh

-- `frame` opens (or comes forward): it holds the gamepad. manual: the
-- player asked for it (focus mode), even with window navigation off. A
-- window whose spec.unasked() says it showed on its own waits instead, unless
-- a Polestar window held the gamepad as it came: a route choice or the
-- welcome over the game would take A, B and the D-pad from the player in
-- the middle of play.
function G.Open(frame, spec, manual)
	local e, i = entryOf(frame)
	if e then tremove(stack, i) end
	local new = e == nil
	e = e or { frame = frame }
	e.spec = spec or specs[frame] or e.spec or {}
	e.manual = manual or e.manual
	if manual then
		e.waiting = nil
	elseif new then
		e.waiting = (G.entry == nil and e.spec.unasked and e.spec.unasked()) and true or nil
	end
	stack[#stack + 1] = e
	refresh()
	return e
end

-- The newest open window, waiting to be asked, takes the gamepad (the focus
-- binding). -> true when there was one.
function G.TakeWaiting()
	local e = newest()
	if not (e and e.waiting) or fighting or combat() or not G.IsActive() then return false end
	e.waiting, e.manual = nil, true
	refresh()
	return true
end

function G.Close(frame)
	local e, i = entryOf(frame)
	if not e then return end
	tremove(stack, i)
	e.focus, e.index, e.settled = nil, nil, false
	if G.entry == e then hidePaint() end
	refresh()
end

-- spec.unasked() -> true when the window showed on its own this time (see
-- G.Open).
function G.Register(frame, spec)
	if type(frame) ~= "table" or not frame.HookScript or specs[frame] then return end
	specs[frame] = spec or {}
	frame:HookScript("OnShow", function() G.Open(frame) end)
	frame:HookScript("OnHide", function() G.Close(frame) end)
	-- A frame is born shown: one still shown once its builder ran is open.
	if C_Timer and C_Timer.After then
		C_Timer.After(0, function() if frame:IsShown() and not entryOf(frame) then G.Open(frame) end end)
	end
end

-- The focused widget of `frame` while it holds the gamepad (tests, preview).
function G.Focused(frame)
	local e = frame and entryOf(frame) or G.entry
	return e and e.focus or nil
end

-- Focus `w` in its open window `frame` (a section moving its selection).
function G.SetFocus(frame, w)
	local e = entryOf(frame)
	if e then focus(e, w) end
end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

-- A fight: the gamepad goes back to the game before the lockdown (the
-- override bindings and the frames cannot change in it); the windows stay
-- open for the mouse. The window lets go first, then a binding row's
-- capture ends (its callback runs), each step on its own: an error in one
-- cannot leave the window's frame or bindings in place for the fight. The
-- first error is raised once all have run. After the fight, the newest
-- open window takes the gamepad again.
ns.RegisterEvent("PLAYER_REGEN_DISABLED", function()
	fighting = true
	local failed
	local function step(fn, ...)
		local ok, err = pcall(fn, ...)
		if not ok and failed == nil then failed = err end
	end
	local e = G.entry
	G.entry, waitingShown = nil, nil
	if e then step(G.Release, e.frame) end
	step(hidePaint)
	step(G.StopCapture, nil)
	step(setChordInput, false, true)
	step(ns.Fire, "GAMEPAD_COMBAT")
	step(updateDriver)
	if failed ~= nil then error(failed, 0) end
end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	fighting = false
	refresh()
end)

-- A gamepad plugged in or out: windows switch between the gamepad and the mouse.
local function gamepadChanged()
	refresh()
	ns.Fire("GAMEPAD_CHANGED", G.IsActive())
end
ns.RegisterEvent("GAME_PAD_CONNECTED", gamepadChanged)
ns.RegisterEvent("GAME_PAD_DISCONNECTED", gamepadChanged)
ns.RegisterEvent("GAME_PAD_ACTIVE_CHANGED", gamepadChanged)

ns.On("SETTING_CHANGED", function(path)
	if path == "gamepad.withMouse" or path == "gamepad" or path == "" then gamepadChanged() end
	if path == "gamepad.navigate" or path == "gamepad.hints" or path == "gamepad" or path == "" then refresh() end
	if (path == "gamepad.hints" or path == "gamepad.glyphs" or path == "gamepad") and G.entry then paint(G.entry) end
end)
ns.On("GAMEPAD_BINDINGS_CHANGED", function() if waitingShown then refresh() end end)

ns.OnLogin(updateDriver)
