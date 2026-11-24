-- The game's Quick Keybind Mode for QoL/QuickBind.lua, loaded after
-- stub_qol.lua (its key binding fakes are replaced here). Shaped on the
-- 1.60.1 interface code (Blizzard_QuickKeybind, Blizzard_Settings_Shared's
-- KeybindListener): QuickKeybindFrame (DIALOG, reads the keyboard), its
-- EventRegistry signals on show and hide, its output line, and the saved
-- bindings with their order (an action's first key is the one bound first).
--
--   local k = stub.qkb
--   k.open() / k.close()   show / hide the window (its OnShow / OnHide signals)
--   k.hover(b), k.leave()  the cursor onto a button (its OnEnter) and off the frame on top of it
--   k.key(key)             a key down: to the topmost keyboard frame that reads it (strata order),
--                          -> "frame" (an addon frame took it), "window" (the window's own handler) or
--                          "game" (passed on: k.ran lists the actions the game ran)
--   k.mouseUp(mouse), k.wheel(delta)  a mouse button / the wheel on the frame under the cursor
--   k.bind(key, action)    a saved binding (SetBinding), k.keys(action) -> its keys in order
--   k.output, k.saves      the window's last line; SaveBindings calls; k.screenshots: Screenshot() calls

local k = { list = {}, output = nil, saves = 0, ran = {}, under = nil, screenshots = 0 }
stub.qkb = k
function Screenshot() k.screenshots = k.screenshots + 1 end

-- EventRegistry (SharedXML's callback registry), when no other stub made one.
if not EventRegistry then
	local callbacks = {}
	EventRegistry = {}
	function EventRegistry:RegisterCallback(name, fn, owner)
		callbacks[name] = callbacks[name] or {}
		table.insert(callbacks[name], { fn = fn, owner = owner })
	end
	function EventRegistry:TriggerEvent(name, ...)
		for _, c in ipairs(callbacks[name] or {}) do c.fn(c.owner, ...) end
	end
end

local M = stub.Methods
M.EnableKeyboard = M.EnableKeyboard or function(self, on) self.keyboard = on and true or false end
M.SetPropagateKeyboardInput = M.SetPropagateKeyboardInput or function(self, on)
	if stub.inCombat then error("SetPropagateKeyboardInput: blocked in combat") end
	self.propagate = on and true or false
end

-- Saved bindings: { { key, action }, ... } in the order they were made.
local function find(key)
	for i, b in ipairs(k.list) do if b[1] == key then return i end end
end
function SetBinding(key, action)
	if stub.inCombat then error("SetBinding: blocked in combat") end
	local i = find(key)
	if i then table.remove(k.list, i) end
	if action then k.list[#k.list + 1] = { key, action } end
	stub.fire("UPDATE_BINDINGS")
	return true
end
function GetBindingKey(action)
	local out = {}
	for _, b in ipairs(k.list) do if b[2] == action then out[#out + 1] = b[1] end end
	return unpack(out)
end
function GetBindingAction(key)
	local i = find(key)
	return i and k.list[i][2] or ""
end
function GetBindingFromClick(key) return GetBindingAction(key) end
function k.bind(key, action) SetBinding(key, action) end
function k.keys(action) return { GetBindingKey(action) } end
function GetBindingName(action) return _G["BINDING_NAME_" .. action] or action end
function GetBindingText(key) return key end
function GetBindingKeyForAction(action)
	local key = GetBindingKey(action)
	return key and GetBindingText(key) or nil
end
function GetConvertedKeyOrButton(input)
	if input == "LeftButton" then return "BUTTON1" end
	if input == "RightButton" then return "BUTTON2" end
	if input == "MiddleButton" then return "BUTTON3" end
	local n = input:match("^Button(%d+)$")
	return n and ("BUTTON" .. n) or input
end
local IGNORED = { LSHIFT = true, RSHIFT = true, LCTRL = true, RCTRL = true, LALT = true, RALT = true, UNKNOWN = true }
function IsKeyPressIgnoredForBinding(key) return IGNORED[key] or false end
function CreateKeyChordStringUsingMetaKeyState(key)
	local held = ""
	if stub.keys.alt then held = held .. "ALT-" end
	if stub.keys.ctrl then held = held .. "CTRL-" end
	if stub.keys.shift then held = held .. "SHIFT-" end
	return held .. key
end
function GetCurrentBindingSet() return 1 end
function SaveBindings() k.saves = k.saves + 1 end
function LoadBindings() end

ESCAPE_TO_UNBIND = "Press Escape to unbind"
NOT_BOUND = "Not Bound"
PRESS_KEY_TO_BIND = "Press a key to bind"
KEY_BOUND = "Key Bound"
KEY_UNBOUND_ERROR = "%s Function is Now Unbound!"
PRIMARY_KEY_UNBOUND_ERROR = "Main Binding for %s is Now Unbound!"
KEYBINDINGFRAME_MOUSEWHEEL_ERROR = "Can't bind mousewheel to actions with up and down states"

-- The mode's tooltip: lines as plain text, the helpers' kind in front.
QuickKeybindTooltip = CreateFrame("GameTooltip", "QuickKeybindTooltip", UIParent)
QuickKeybindTooltip.lines = {}
function QuickKeybindTooltip.SetOwner(self, owner) self.owner, self.lines = owner, {} end
function QuickKeybindTooltip.GetOwner(self) return self.owner end
function QuickKeybindTooltip.AddLine(self, text) table.insert(self.lines, tostring(text)) end
QuickKeybindTooltip:Hide()
for kind, name in pairs({ highlight = "GameTooltip_AddHighlightLine", instruction = "GameTooltip_AddInstructionLine",
	error = "GameTooltip_AddErrorLine", normal = "GameTooltip_AddNormalLine" }) do
	_G[name] = function(tip, text) table.insert(tip.lines, kind .. ": " .. tostring(text)) end
end

QuickKeybindFrame = CreateFrame("Button", "QuickKeybindFrame", UIParent)
QuickKeybindFrame:SetFrameStrata("DIALOG")
QuickKeybindFrame:EnableKeyboard(true)
QuickKeybindFrame:Hide()
function QuickKeybindFrame.SetOutputText(_, text) k.output = text end
QuickKeybindFrame:SetScript("OnKeyDown", function() end)
QuickKeybindFrame:SetScript("OnShow", function() EventRegistry:TriggerEvent("QuickKeybindFrame.QuickKeybindModeEnabled") end)
QuickKeybindFrame:SetScript("OnHide", function() EventRegistry:TriggerEvent("QuickKeybindFrame.QuickKeybindModeDisabled") end)

function k.open() k.output = nil; QuickKeybindFrame:Show() end
function k.close() QuickKeybindFrame:Hide() end

-- The frame under the cursor: what took the hover (a shown mouse frame laid
-- over the button with SetAllPoints), else the button.
local function topAt(b)
	for _, f in ipairs(stub.frames) do
		local p = f.points and f.points[1]
		if f ~= b and f.mouse and f:IsVisible() and p and p.rel == b and p.point == "TOPLEFT" then return f end
	end
	return b
end

function k.hover(b)
	k.button = b
	stub.RunScript(b, "OnEnter")
	k.under = topAt(b)
	if k.under ~= b then stub.RunScript(b, "OnLeave") end
	return k.under ~= b and k.under or nil
end
function k.leave()
	local f = k.under
	k.under, k.button = nil, nil
	if f then stub.RunScript(f, "OnLeave") end
end

local STRATA = { BACKGROUND = 1, LOW = 2, MEDIUM = 3, HIGH = 4, DIALOG = 5, FULLSCREEN = 6, FULLSCREEN_DIALOG = 7, TOOLTIP = 8 }
function k.key(key)
	local readers = {}
	for _, f in ipairs(stub.frames) do
		if f.keyboard and f.scripts.OnKeyDown and f:IsVisible() then readers[#readers + 1] = f end
	end
	table.sort(readers, function(a, b) return (STRATA[a:GetFrameStrata()] or 3) > (STRATA[b:GetFrameStrata()] or 3) end)
	for _, f in ipairs(readers) do
		f.propagate = false
		stub.RunScript(f, "OnKeyDown", key)
		if not f.propagate then return f == QuickKeybindFrame and "window" or "frame" end
	end
	local action = GetBindingAction(key)
	if action ~= "" then k.ran[#k.ran + 1] = action end
	return "game"
end
function k.mouseUp(mouse)
	if k.under then stub.RunScript(k.under, "OnMouseUp", mouse) end
end
function k.wheel(delta)
	if k.under then stub.RunScript(k.under, "OnMouseWheel", delta) end
end
