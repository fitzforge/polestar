-- Clickable guide objectives and NPC headers. Secure buttons live outside the guide's frame
-- tree, so quest progress can still move and repaint the guide in combat.
-- The client hides their holder in combat; attributes and geometry are
-- prepared only outside lockdown. No target or mark is set without a click.
local ADDON, ns = ...
local UI, L = ns.UI, ns.L
local NameTargets = { buttons = {} }
UI.NameTargets = NameTargets

local guide, provider, watcher, holder
local active = 0
local function locked()
	return InCombatLockdown and InCombatLockdown()
end

local function ownerScript(b, script, ...)
	local owner = b.psOwner
	local fn = owner and owner:GetScript(script)
	if fn then fn(owner, ...) end
end

local function leave(b)
	if b.psHover then
		b.psHover = nil
		ownerScript(b, "OnLeave")
	end
end

local function enter(b)
	b.psHover = true
	ownerScript(b, "OnEnter")
	if GameTooltip then
		local r, g, blue = ns.Theme.Color("textDim")
		local mark = ns.QoL.On("markTarget")
		local hint = mark and L["Click to target and mark %s (out of combat)."] or L["Click to target %s (out of combat)."]
		GameTooltip:AddLine(string.format(hint, b.psName or ""), r, g, blue, true)
		GameTooltip:Show()
	end
end

function NameTargets.Hide()
	if watcher then watcher:Hide() end
	for _, b in ipairs(NameTargets.buttons) do leave(b) end
	if locked() then return end
	for _, b in ipairs(NameTargets.buttons) do b:Hide() end
end

local function createButton(i)
	if not holder then
		holder = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
		holder:SetSize(1, 1)
		RegisterStateDriver(holder, "visibility", "[combat] hide; show")
		NameTargets.holder = holder
	end
	local b = CreateFrame("Button", nil, holder, "SecureActionButtonTemplate")
	b:Hide()
	b:RegisterForClicks("AnyUp", "AnyDown")
	b:SetAttribute("useOnKeyDown", false)
	b:SetAttribute("type1", "macro")
	b:SetScript("OnEnter", enter)
	b:SetScript("OnLeave", leave)
	b:SetScript("OnHide", leave)
	-- OnClick belongs to SecureActionButtonTemplate. Keep the ordinary row
	-- navigation and right-click actions, once, after the secure action.
	b:HookScript("PostClick", function(self, mouse, down)
		if down or locked() then return end
		local kind = self.psKind
		-- "type1" answers only an unmodified left click: with Shift, Ctrl or
		-- Alt held no macro ran, so nothing was targeted or marked and the
		-- click is only the ordinary row click.
		local ran = mouse == "LeftButton" and not (IsModifierKeyDown and IsModifierKeyDown())
		-- The secure macro clears absent or dead targets. Report that result
		-- before navigation can repaint the row and reuse this button.
		if ran and UnitExists and not UnitExists("target") then
			local message = string.format(L["%s not found nearby."], self.psName or "")
			if UIErrorsFrame and UIErrorsFrame.AddMessage then
				UIErrorsFrame:AddMessage(message, 1, 0.2, 0.2)
			else
				ns.Print(message)
			end
		end
		if mouse == "LeftButton" or (mouse == "RightButton" and self.psRight) then ownerScript(self, "OnClick", mouse) end
		-- Navigation can change the step and reuse this overlay. Advance the
		-- kind whose macro just ran, after the ordinary click has finished.
		if ran then ns.QoL.Buttons.AdvanceMark(kind) end
	end)
	NameTargets.buttons[i] = b
	return b
end

local function place(b)
	local owner, region = b.psOwner, b.psRegion
	if not (guide and guide:IsVisible() and owner and owner:IsVisible() and region and region:IsVisible())
		or (guide.GetEffectiveAlpha and guide:GetEffectiveAlpha() <= 0) then
		b:Hide()
		return
	end
	local left, top = region:GetLeft(), region:GetTop()
	if not left or not top then b:Hide(); return end
	local scale = owner:GetEffectiveScale() / UIParent:GetEffectiveScale()
	local width, height = region:GetWidth(), region:GetHeight()
	if not b.psWholeRow then
		width = math.min(width, region:GetStringWidth())
		height = region:GetStringHeight()
	end
	width, height = width * scale, height * scale
	if width <= 0 or height <= 0 then b:Hide(); return end
	left, top = left * scale, top * scale
	-- Absolute UIParent coordinates: no protected anchor points at a guide
	-- frame. All guide layouts, including animation and dragging, stay free.
	if b.psLeft ~= left or b.psTop ~= top or b.psWidth ~= width or b.psHeight ~= height then
		b:ClearAllPoints()
		b:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
		b:SetSize(width, height)
		b.psLeft, b.psTop, b.psWidth, b.psHeight = left, top, width, height
	end
	local strata, level = owner:GetFrameStrata(), owner:GetFrameLevel() + 1
	if b:GetFrameStrata() ~= strata then b:SetFrameStrata(strata) end
	if b:GetFrameLevel() ~= level then b:SetFrameLevel(level) end
	-- The row overlay covers icon, text and whitespace, but its ordinary
	-- buttons must win hit testing. Reserve a distinct level above it rather
	-- than depending on creation order between frames at the same level.
	for _, control in ipairs(b.psControls or {}) do
		if control:GetFrameLevel() ~= level + 1 then control:SetFrameLevel(level + 1) end
	end
	if not b:IsShown() then b:Show() end
end

function NameTargets.Refresh()
	if locked() then return end
	local Q = ns.QoL
	local buttons = Q and Q.Buttons
	if not (guide and provider and guide:IsVisible() and Q and Q.On and Q.On("guideNameTarget")
		and buttons and buttons.GuideNameMacro and type(RegisterStateDriver) == "function") then
		active = 0
		NameTargets.Hide()
		return
	end
	active = 0
	for _, entry in ipairs(provider()) do
		local macro, name, kind = buttons.GuideNameMacro(entry.goal, entry.raw)
		if macro then
			active = active + 1
			local b = NameTargets.buttons[active] or createButton(active)
			if b.psOwner ~= entry.owner or b.psName ~= name or b.psKind ~= kind then leave(b) end
			b.psOwner, b.psRegion, b.psName = entry.owner, entry.region, name
			b.psKind = kind
			b.psRight = entry.right
			b.psWholeRow, b.psControls = entry.wholeRow, entry.controls
			local changed = b.psMacro ~= macro
			if changed then
				b:SetAttribute("macrotext1", macro)
				b.psMacro = macro
			end
			place(b)
			-- A shared mark cycle changes the macro under a stationary cursor.
			-- Keep its wash and refresh its hint without waiting for OnEnter.
			if changed and b.psHover then enter(b) end
		end
	end
	for i = active + 1, #NameTargets.buttons do
		local b = NameTargets.buttons[i]
		b:Hide()
		b:SetAttribute("macrotext1", nil)
		b.psOwner, b.psRegion, b.psName, b.psMacro = nil, nil, nil, nil
		b.psKind = nil
		b.psControls = nil
	end
	if watcher then watcher:SetShown(active > 0) end
end

-- The provider describes displayed objectives and NPC headers. The short position
-- watch follows animation and dragging without querying game data again.
function NameTargets.Bind(frame, getNames)
	guide, provider = frame, getNames
	watcher = CreateFrame("Frame", nil, frame)
	watcher:Hide()
	local elapsed = 0
	watcher:SetScript("OnUpdate", function(_, dt)
		if locked() then return end
		elapsed = elapsed + dt
		if elapsed < 0.05 then return end
		elapsed = 0
		for i = 1, active do place(NameTargets.buttons[i]) end
	end)
	frame:HookScript("OnShow", NameTargets.Refresh)
	frame:HookScript("OnHide", NameTargets.Hide)
	NameTargets.Refresh()
end

ns.RegisterEvent("PLAYER_REGEN_DISABLED", function()
	-- Visibility is the secure driver's job; the ordinary watch can stop.
	if watcher then watcher:Hide() end
	for _, b in ipairs(NameTargets.buttons) do leave(b) end
end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", NameTargets.Refresh)
ns.On("QOL_TARGET_MARK_CHANGED", NameTargets.Refresh)
ns.On("SETTING_CHANGED", function(path)
	if path == "" or path == "qol" or path == "qol.guideNameTarget" or path == "qol.markTarget"
		or path == "qol.markMob" or path == "qol.markNpc" then
		NameTargets.Refresh()
	end
end)
