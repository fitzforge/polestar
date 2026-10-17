-- The client's gamepad and key binding API for UI/Gamepad.lua, loaded after
-- wow_stub.lua (and stub_ui.lua). stub.pad holds the state:
--   enabled, devices (C_GamePad), labelStyle ("Letters" | "Shapes"),
--   down = { [button] = true } (wow_stub.lua's stub.keysDown, which IsKeyDown
--   reads), saved = { [key] = action }
--   (SetBinding / GetBindingKey), overrides = { [owner] = { [key] = buttonName } },
--   blocked = { "SetOverrideBindingClick", ... } (protected calls refused in
--   combat), ran = { action, ... } (saved bindings the game ran).
-- stub.press(key[, down]) delivers a gamepad button the way the client does:
-- frames reading the gamepad first (shown, EnableGamePadButton, an
-- OnGamePadButtonDown script) unless they let it through
-- (SetPropagateKeyboardInput), then the override bindings, then the saved
-- binding. stub.key(key) delivers a keyboard key to the frames reading it.

local pad = {
	enabled = true, devices = { 1 }, labelStyle = "Letters",
	down = stub.keysDown, saved = {}, overrides = {}, blocked = {}, ran = {}, saves = 0,
}
stub.pad = pad

C_GamePad = {}
function C_GamePad.IsEnabled() return pad.enabled end
function C_GamePad.GetAllDeviceIDs() return pad.devices end
function C_GamePad.GetActiveDeviceID() return pad.devices[1] or -1 end
function C_GamePad.GetDeviceMappedState(id)
	if id == nil or id < 0 then return nil end
	return { labelStyle = pad.labelStyle }
end

function GetCurrentKeyBoardFocus() return stub.focus end
function GetBindingText(key) return key end

-- Protected in combat, as the client keeps them.
local function protected(name)
	if stub.inCombat then
		pad.blocked[#pad.blocked + 1] = name
		error(name .. ": blocked in combat")
	end
end

function SetOverrideBindingClick(owner, _, key, button)
	protected("SetOverrideBindingClick")
	pad.overrides[owner] = pad.overrides[owner] or {}
	pad.overrides[owner][key] = button
end
function ClearOverrideBindings(owner)
	protected("ClearOverrideBindings")
	pad.overrides[owner] = nil
end

-- Every override binding in place: { [key] = buttonName }.
function stub.overrides()
	local out = {}
	for _, map in pairs(pad.overrides) do
		for key, button in pairs(map) do out[key] = button end
	end
	return out
end
function stub.overrideCount()
	local n = 0
	for _ in pairs(stub.overrides()) do n = n + 1 end
	return n
end

function GetBindingAction(key, checkOverride)
	if checkOverride then
		local button = stub.overrides()[key]
		if button then return "CLICK " .. button .. ":LeftButton" end
	end
	return pad.saved[key] or ""
end
function SetBinding(key, action)
	protected("SetBinding")
	pad.saved[key] = action
	return true
end
function GetBindingKey(action)
	local keys = {}
	for key, a in pairs(pad.saved) do if a == action then keys[#keys + 1] = key end end
	table.sort(keys)
	return unpack(keys)
end
function GetCurrentBindingSet() return 1 end
function SaveBindings() pad.saves = pad.saves + 1 end

local M = stub.Methods
function M.EnableGamePadButton(self, on) self.padButtons = on and true or false end
function M.EnableKeyboard(self, on) self.keyboard = on and true or false end
function M.SetPropagateKeyboardInput(self, on)
	protected("SetPropagateKeyboardInput")
	self.propagate = on and true or false
end

-- -> "frame" | "override" | "game": who got the press (the down's, for a
-- press and release).
function stub.press(key, down)
	if down == nil then
		local route = stub.press(key, true)
		stub.press(key, false)
		return route
	end
	pad.down[key] = down or nil
	local script = down and "OnGamePadButtonDown" or "OnGamePadButtonUp"
	for _, f in ipairs(stub.frames) do
		if f.padButtons and f.scripts[script] and M.IsVisible(f) then
			stub.RunScript(f, script, key)
			if not f.propagate then return "frame" end
		end
	end
	local button = stub.overrides()[key]
	if button then
		local b = _G[button]
		if b then stub.RunScript(b, "OnClick", "LeftButton", down) end
		return "override"
	end
	if down and pad.saved[key] then pad.ran[#pad.ran + 1] = pad.saved[key] end
	return "game"
end

-- Hold `hold` and press `press` (a chord), then let both go; the frames'
-- OnUpdate runs while they are held.
function stub.chord(hold, press)
	stub.press(hold, true)
	stub.advance(0.05)
	stub.press(press, true)
	stub.advance(0.05)
	stub.press(press, false)
	stub.press(hold, false)
	stub.advance(0.05)
end

function stub.key(key)
	for _, f in ipairs(stub.frames) do
		if f.keyboard and f.scripts.OnKeyDown and M.IsVisible(f) then
			stub.RunScript(f, "OnKeyDown", key)
			stub.RunScript(f, "OnKeyUp", key)
			return
		end
	end
end
