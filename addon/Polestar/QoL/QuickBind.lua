-- Quick Keybind Mode: the game's window that binds a key to the button under
-- the cursor (Options > Keybindings > Quick Keybind Mode, or an action bar
-- addon's /kb). While it is open, Polestar's on-screen buttons with a CLICK
-- binding (QoL/Buttons.lua's set, the travel button) take part the way the
-- game's action buttons do:
--   * each wears the mode's highlight, brighter under the cursor, and its
--     tooltip is the mode's: the binding's name, its key, how to bind or
--     unbind (never the button's usual tooltip);
--   * a key, a mouse button other than the left and right ones, or the wheel,
--     pressed over one binds it as the window's own listener does: in place
--     of its first key, its second kept, the key taken from whatever it ran
--     (the window says so when that leaves the other action unbound); Escape
--     unbinds its first key. A bare modifier waits for the key it goes with.
--     The key used for screenshots still takes one. Polestar never saves: the
--     window's Okay saves into the set its character-specific box picks, its
--     Cancel throws the changes away;
--   * a button hidden now (no target, quest item or rare, bags not full)
--     shows in its slot, dimmed, with its binding's name as its label, and
--     goes again when the window closes. One turned off in the options stays
--     hidden. A button the guide needs while the window is open gets its own
--     look back.
-- Keys are read by a plain frame of Polestar's own laid over the hovered
-- button, never by the window's listener: the key goes no further, and
-- nothing of the game's secure binding code runs from addon code. A click
-- lands on that frame too, so it never fires the button. Nothing binds,
-- shows or hides in a fight: the frame steps aside, and buttons shown for the
-- mode go once the fight ends. Outside the mode nothing here runs.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL

local type, ipairs, pcall = type, ipairs, pcall

local QB = {}
QoL.QuickBind = QB

-- The mode's highlight on the game's action buttons and its two strengths
-- (idle, under the cursor); a hidden button's alpha while shown for binding;
-- how often the shown set is checked while the window is open.
local HL_ATLAS = "UI-HUD-ActionBar-IconFrame-Mouseover"
local IDLE_ALPHA, HOVER_ALPHA = 0.5, 1
local DIM_ALPHA = 0.45
local TICK = 0.2

local entries, byButton = {}, {}
local active = false
local overlay, ticker, hovered

local function lockdown() return QoL.InLockdown() end

---------------------------------------------------------------------------
-- The client's binding API, with the action's binding context when the
-- client has one (as the window's listener passes it)
---------------------------------------------------------------------------

local function contextOf(command)
	local K = C_KeyBindings
	if not (K and K.GetBindingContextForAction) then return nil end
	local ok, context = pcall(K.GetBindingContextForAction, command)
	return ok and type(context) == "number" and context or nil
end

local function keysOf(command, context)
	if not GetBindingKey then return nil, nil end
	if context then return GetBindingKey(command, nil, context) end
	return GetBindingKey(command)
end

local function actionOf(key, context)
	if not GetBindingAction then return "" end
	local action
	if context then action = GetBindingAction(key, nil, context) else action = GetBindingAction(key) end
	return type(action) == "string" and action or ""
end

local function setBinding(key, command, context)
	if context then return SetBinding(key, command, context) ~= false end
	return SetBinding(key, command) ~= false
end

local function bindingName(command)
	local name = GetBindingName and GetBindingName(command)
	return type(name) == "string" and name ~= "" and name or command
end

-- A line in the window under its buttons.
local function say(text)
	local f = QuickKeybindFrame
	if text and f and f.SetOutputText then f:SetOutputText(text) end
end

-- The key the client means (BUTTON3 for the middle mouse button), or nil
-- for one that binds nothing alone (a modifier).
local BARE_MODIFIER = {
	LSHIFT = true, RSHIFT = true, LCTRL = true, RCTRL = true, LALT = true, RALT = true,
	LMETA = true, RMETA = true, SHIFT = true, CTRL = true, ALT = true, META = true,
}
local function normalize(input)
	local key
	if GetConvertedKeyOrButton then
		key = GetConvertedKeyOrButton(input)
	else
		local n = input:match("^Button(%d+)$")
		key = input == "MiddleButton" and "BUTTON3" or n and ("BUTTON" .. n) or input
	end
	if IsKeyPressIgnoredForBinding then
		if IsKeyPressIgnoredForBinding(key) then return nil end
	elseif BARE_MODIFIER[key] then
		return nil
	end
	return key
end

-- The key with the modifiers held, in the client's order ("ALT-CTRL-F").
local function chord(key)
	if CreateKeyChordStringUsingMetaKeyState then return CreateKeyChordStringUsingMetaKeyState(key) end
	local held = ""
	if IsAltKeyDown and IsAltKeyDown() then held = held .. "ALT-" end
	if IsControlKeyDown and IsControlKeyDown() then held = held .. "CTRL-" end
	if IsShiftKeyDown and IsShiftKeyDown() then held = held .. "SHIFT-" end
	if IsMetaKeyDown and IsMetaKeyDown() then held = held .. "META-" end
	return held .. key
end

---------------------------------------------------------------------------
-- The mode's tooltip
---------------------------------------------------------------------------

local function tip() return QuickKeybindTooltip or GameTooltip end

local LINE = {
	highlight = { "GameTooltip_AddHighlightLine", 1, 1, 1 },
	instruction = { "GameTooltip_AddInstructionLine", 0.1, 1, 0.1 },
	error = { "GameTooltip_AddErrorLine", 1, 0.125, 0.125 },
	normal = { "GameTooltip_AddNormalLine", 1, 0.82, 0 },
}
local function addLine(t, text, kind)
	if type(text) ~= "string" or text == "" then return end
	local l = LINE[kind]
	local add = _G[l[1]]
	if add then add(t, text) else t:AddLine(text, l[2], l[3], l[4], true) end
end

local function showTip(e)
	local t = tip()
	if not t then return end
	local command = e.command
	t:SetOwner(e.button, "ANCHOR_RIGHT")
	addLine(t, bindingName(command), "highlight")
	local key = keysOf(command, contextOf(command))
	if key then
		local text = GetBindingKeyForAction and GetBindingKeyForAction(command)
		if type(text) ~= "string" or text == "" then text = GetBindingText and GetBindingText(key) or key end
		addLine(t, text, "instruction")
		addLine(t, ESCAPE_TO_UNBIND, "normal")
	else
		addLine(t, NOT_BOUND, "error")
		addLine(t, PRESS_KEY_TO_BIND, "normal")
	end
	if e.forced then addLine(t, L["Not needed right now: shown so you can bind it."], "normal") end
	t:Show()
end

local function hideTip(e)
	local t = tip()
	if t and e and t.GetOwner and t:GetOwner() == e.button then t:Hide() end
end

---------------------------------------------------------------------------
-- Binding (what the window's listener does for its own buttons)
---------------------------------------------------------------------------

-- `input` as the new first key of e's command.
local function takeKey(e, input)
	if lockdown() then return end
	local key = normalize(input)
	if not key then return end
	local command = e.command
	local context = contextOf(command)
	local key1, key2 = keysOf(command, context)
	local new = chord(key)
	-- What the key ran loses it; the window names an action left unbound
	-- (or whose first key moved up), not one that keeps a key.
	local other, lost = actionOf(new, context), nil
	if other ~= "" and other ~= command then
		local o1, o2 = keysOf(other, context)
		if o1 == new and o2 then
			lost = PRIMARY_KEY_UNBOUND_ERROR
		elseif (not o1 or o1 == new) and (not o2 or o2 == new) then
			lost = KEY_UNBOUND_ERROR
		end
	end
	if key1 then setBinding(key1, nil, context) end
	if key2 then setBinding(key2, nil, context) end
	setBinding(new, nil, context)
	local ok = setBinding(new, command, context)
	if not ok and key1 then setBinding(key1, command, context) end
	if key2 and key2 ~= new then setBinding(key2, command, context) end
	if lost and other ~= "" then
		say(lost:format(bindingName(other)))
	elseif not ok then
		say(KEYBINDINGFRAME_MOUSEWHEEL_ERROR)
	else
		say(KEY_BOUND)
	end
	showTip(e)
end

-- Escape: the first key goes, the second (if any) becomes the first.
local function clearFirst(e)
	if lockdown() then return end
	local command = e.command
	local context = contextOf(command)
	local key1, key2 = keysOf(command, context)
	if key1 then setBinding(key1, nil, context) end
	if key2 then setBinding(key2, command, context) end
	showTip(e)
end

---------------------------------------------------------------------------
-- The look: highlight, and a hidden button shown dimmed for binding
---------------------------------------------------------------------------

local function newHighlight(b)
	local hl = b:CreateTexture(nil, "OVERLAY", nil, 7)
	hl:SetAllPoints(b)
	local atlas = C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(HL_ATLAS)
	if atlas then
		hl:SetAtlas(HL_ATLAS)
	else
		local T = ns.Theme
		hl:SetTexture(T and T.Media and T.Media("white") or "Interface\\Buttons\\WHITE8X8")
		hl:SetBlendMode("ADD")
		local r, g, bl = 1, 0.82, 0
		if T and T.Accent then r, g, bl = T.Accent() end
		hl:SetVertexColor(r, g, bl, 0.6)
	end
	hl:Hide()
	return hl
end

local function paint(e)
	local on = active and e.button:IsShown()
	e.hl:SetShown(on)
	if on then e.hl:SetAlpha(hovered == e and HOVER_ALPHA or IDLE_ALPHA) end
end

local function wanted(e)
	local w = e.opts.wanted
	if w then return w(e.button) and true or false end
	return e.button:GetAttribute("type") ~= nil
end

local function mayForce(e)
	local o = e.opts
	return o.force and (not o.enabled or o.enabled()) and true or false
end

-- The dimmed look and the binding's name as the label (the label it had is
-- kept for when the guide needs the button again).
local function dim(e)
	local b = e.button
	if not e.forced then
		e.forced = true
		e.label = b.Label and b.Label:GetText()
		if e.opts.icon then
			b.Icon:SetTexture(e.opts.icon())
			b.Icon:SetDesaturated(true)
			if b.Count then b.Count:SetText("") end
		end
	end
	b:SetAlpha(DIM_ALPHA)
	if b.Label then
		local name, now = bindingName(e.command), b.Label:GetText()
		if now ~= name then
			e.label = now
			b.Label:SetText(name)
		end
	end
end

-- The label it had, unless the guide has written its own since.
local function restoreLabel(e)
	local l = e.button.Label
	if l and l:GetText() == bindingName(e.command) then l:SetText(e.label or "") end
	e.label = nil
end

-- Back to the button's own look (its icon and count are the guide's again
-- by the time it shows for real: the module that shows it paints them).
local function undim(e)
	if not e.forced then return end
	e.forced = nil
	e.button:SetAlpha(1)
	restoreLabel(e)
end

local function sync(e)
	local b = e.button
	if active and not lockdown() then
		if mayForce(e) and not wanted(e) then
			dim(e)
			if not b:IsShown() then b:Show() end
		elseif e.forced then
			-- The guide shows it now (its own look back), or it was turned
			-- off in the options while the window is open (it goes).
			undim(e)
			if not wanted(e) then b:Hide() end
		end
	end
	paint(e)
end

---------------------------------------------------------------------------
-- The capture frame over the hovered button
---------------------------------------------------------------------------

local function leave()
	local e = hovered
	hovered = nil
	if overlay then overlay:Hide() end
	if e then
		hideTip(e)
		paint(e)
	end
end

local function getOverlay()
	if overlay then return overlay end
	-- Above the window itself (DIALOG), so the key reaches this frame first
	-- and goes no further.
	local f = CreateFrame("Frame", nil, UIParent)
	f:SetFrameStrata("FULLSCREEN_DIALOG")
	f:SetFrameLevel(100)
	f:EnableMouse(true)
	f:EnableKeyboard(true)
	f:EnableMouseWheel(true)
	f:Hide()
	f:SetScript("OnLeave", leave)
	f:SetScript("OnKeyDown", function(_, key)
		if lockdown() or not hovered then return end
		-- The screenshot key still takes one, as over the game's own buttons
		-- (the window would swallow it if it went on).
		if GetBindingFromClick and GetBindingFromClick(key) == "SCREENSHOT" then
			if Screenshot then pcall(Screenshot) end
			return
		end
		if key == "ESCAPE" then clearFirst(hovered) else takeKey(hovered, key) end
	end)
	f:SetScript("OnMouseUp", function(_, mouse)
		if hovered and mouse ~= "LeftButton" and mouse ~= "RightButton" then takeKey(hovered, mouse) end
	end)
	f:SetScript("OnMouseWheel", function(_, delta)
		if hovered then takeKey(hovered, delta > 0 and "MOUSEWHEELUP" or "MOUSEWHEELDOWN") end
	end)
	overlay = f
	return f
end

-- From a button's OnEnter: true when the mode takes the hover (the button's
-- own tooltip and hover then stay off).
function QB.Hover(b)
	local e = byButton[b]
	if not (e and active) or lockdown() then return false end
	if GameTooltip and GameTooltip.GetOwner and GameTooltip:GetOwner() == b then GameTooltip:Hide() end
	hovered = e
	local f = getOverlay()
	f:ClearAllPoints()
	f:SetAllPoints(b)
	f:Show()
	paint(e)
	showTip(e)
	return true
end

---------------------------------------------------------------------------
-- The window opens and closes
---------------------------------------------------------------------------

local function tick()
	if hovered and (lockdown() or not hovered.button:IsVisible()) then leave() end
	for _, e in ipairs(entries) do sync(e) end
end

local function open()
	if active then return end
	active = true
	if not ticker then
		ticker = CreateFrame("Frame")
		local since = 0
		ticker:SetScript("OnUpdate", function(_, elapsed)
			since = since + (elapsed or 0)
			if since < TICK then return end
			since = 0
			tick()
		end)
	end
	ticker:Show()
	tick()
end

local function close()
	if not active then return end
	active = false
	leave()
	if ticker then ticker:Hide() end
	for _, e in ipairs(entries) do
		if e.forced then
			local b = e.button
			-- Its label back now; dimmed and on screen until it can hide (a
			-- fight holds it), unless the guide wants it by then.
			restoreLabel(e)
			QoL.Secure("quickbind:" .. b:GetName(), function()
				if active then return end
				e.forced = nil
				b:SetAlpha(1)
				if not wanted(e) then b:Hide() end
			end)
		end
		paint(e)
	end
end

-- A button joins: `opts.force` shows it while hidden (when `opts.enabled()`,
-- if given, says it is on); `opts.wanted(b)` says the guide shows it now
-- (default: it has a secure action); `opts.icon()` stands in for its icon
-- while it is shown for binding.
function QB.Add(b, opts)
	if byButton[b] or not (b and b.GetName and b:GetName()) then return end
	local e = { button = b, command = "CLICK " .. b:GetName() .. ":LeftButton", opts = opts or {} }
	e.hl = newHighlight(b)
	entries[#entries + 1] = e
	byButton[b] = e
	if active then sync(e) end
end

function QB.Active() return active end

-- The window's own signals (Blizzard_QuickKeybind): shown and hidden.
if EventRegistry and EventRegistry.RegisterCallback then
	EventRegistry:RegisterCallback("QuickKeybindFrame.QuickKeybindModeEnabled", open, QB)
	EventRegistry:RegisterCallback("QuickKeybindFrame.QuickKeybindModeDisabled", close, QB)
end

-- A fight: the capture frame steps aside (a key then runs as usual).
ns.RegisterEvent("PLAYER_REGEN_DISABLED", function() if hovered then leave() end end)
