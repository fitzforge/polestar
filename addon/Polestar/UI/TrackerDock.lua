-- Quest tracker docking is opt-in and takes effect after a reload.
local _, ns = ...
local L = ns.L
local Skin = {}
ns.UI.TrackerDock = Skin
local active = false
local polestarDock
local tabOrder = {}
local strip, holder, tracker, background
local customTracker, nativeTracker, questieTracker, backgroundTexture, backgroundDivider
local buttons = {}
local writing = false
local desiredAlpha = 1
local pending
local elapsed = 0
local textures = {}

local function InCombat()
	return InCombatLockdown and InCombatLockdown()
end

local function Loaded(name)
	local check = C_AddOns and C_AddOns.IsAddOnLoaded or IsAddOnLoaded
	return check and check(name)
end

local function Accent()
	if EllesmereUI and EllesmereUI.GetAccentColor then
		return EllesmereUI.GetAccentColor()
	end
	return ns.Theme.Accent()
end

-- Keep visibility separate from opacity: Ellesmere uses frame alpha for fades
-- and the background texture's vertex alpha for the configured fill.
local function SuppressTexture(tex)
	if not tex or textures[tex] then return end
	textures[tex] = tex:GetAlpha()
	hooksecurefunc(tex, "SetAlpha", function(self, alpha)
		if writing then return end
		textures[self] = alpha
		if active and not ns.Hidden() then
			writing = true
			self:SetAlpha(0)
			writing = false
		end
	end)
end

-- Dock dimensions and selected-tab treatment follow MidnightChores'
-- AttachedTracker.lua: BTN_H=18, TOP_PAD=4, QUESTS_H=26, GAP=2,
-- MakeButton and UpdateToggleHighlight. Resolve colours from EUI's DB:
-- GetVertexColor returns the tint, not the fill set by SetColorTexture.
-- MidnightChores is MIT-licensed; its notice is in LICENSE-midnightchores.txt.
local function TrackerConfig()
	local eqt = _G.EllesmereUIQuestTracker
	return eqt and eqt.DB and eqt.DB() or {}
end

local NATIVE_BACKDROP = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
	edgeSize = 12,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
}
local function EllesmereStyle()
	if questieTracker then return false end
	local eqt = _G.EllesmereUIQuestTracker
	if eqt and eqt.Blizz then return not eqt.Blizz() end
	return not nativeTracker and EllesmereUI ~= nil
end

local OBJECTIVES_HEADER_ATLAS = "ui-questtracker-primary-objective-header"
-- The atlas includes transparent space before the visible left finial.
local OBJECTIVES_HEADER_LEFT_INSET = 10

local function Paint()
	-- These colors match the host tracker's artwork rather than Polestar's
	-- window palette: Ellesmere supplies its accent, Questie its backdrop,
	-- and Blizzard's header art uses gold text over its dark native panel.
	local themed = EllesmereStyle()
	local useHeaderArt = not themed and not questieTracker and C_Texture and C_Texture.GetAtlasInfo
		and C_Texture.GetAtlasInfo(OBJECTIVES_HEADER_ATLAS)
	local questieHeader = questieTracker and _G.Questie_HeaderFrame
	local header = not themed and not questieTracker and (tracker.HeaderMenu or tracker.Header)
	local art = useHeaderArt and header and header.Background
	local artHeight = art and art:GetHeight()
	local matchHeader = artHeight and artHeight > 0
	local tabAnchor = matchHeader and art or (nativeTracker and tracker or background)
	local rowHeight = matchHeader and artHeight or 26
	local rowScale = matchHeader and header:GetEffectiveScale() / UIParent:GetEffectiveScale() or 1
	if questieTracker then rowScale = tracker:GetEffectiveScale() / UIParent:GetEffectiveScale() end
	if strip:GetScale() ~= rowScale then strip:SetScale(rowScale) end
	if strip:GetHeight() ~= rowHeight then strip:SetHeight(rowHeight) end
	local leftExtension = 0
	if matchHeader then
		local artLeft, panelLeft = art:GetLeft(), background:GetLeft()
		if artLeft and panelLeft then
			local panelScale = background:GetEffectiveScale() / header:GetEffectiveScale()
			leftExtension = math.max(0, artLeft - panelLeft * panelScale + OBJECTIVES_HEADER_LEFT_INSET)
		end
	end
	if strip.tabAnchor ~= tabAnchor or strip.leftExtension ~= leftExtension then
		strip:ClearAllPoints()
		strip:SetPoint("BOTTOMLEFT", tabAnchor, "TOPLEFT", -leftExtension, 2)
		strip:SetPoint("BOTTOMRIGHT", tabAnchor, "TOPRIGHT", 0, 2)
		strip.tabAnchor = tabAnchor
		strip.leftExtension = leftExtension
	end
	local cfg = themed and TrackerConfig() or {}
	local r, g, b = 1, 0.82, 0
	local eqt = _G.EllesmereUIQuestTracker
	if themed then
		r, g, b = Accent()
		if eqt and eqt.GetLineRGB then r, g, b = eqt.GetLineRGB() end
	end
	local cr, cg, cb, ca = cfg.bgR or 0.035, cfg.bgG or 0.035,
		cfg.bgB or 0.035, cfg.bgAlpha or 0.75
	if not themed then cr, cg, cb, ca = 0.08, 0.06, 0.03, 0.8 end
	if questieTracker then
		local profile = Questie.db.profile
		local color = profile.trackerBackdropColor or {}
		cr, cg, cb = color.r or 0, color.g or 0, color.b or 0
		ca = profile.trackerBackdropEnabled and (color.a or 0.75) or 0
	end
	for _, panel in ipairs({strip, holder}) do
		if themed or questieTracker or (panel == strip and useHeaderArt) then
			panel:SetBackdrop(nil)
		else
			panel:SetBackdrop(NATIVE_BACKDROP)
			panel:SetBackdropColor(0, 0, 0, 0)
			panel:SetBackdropBorderColor(0.8, 0.65, 0.35, 1)
		end
	end
	if useHeaderArt then
		strip.fill:SetAtlas(OBJECTIVES_HEADER_ATLAS)
	else
		strip.fill:SetColorTexture(cr, cg, cb, ca)
	end
	holder.fill:SetColorTexture(cr, cg, cb, ca)
	strip.line:SetColorTexture(r, g, b, 1)
	holder.line:SetColorTexture(r, g, b, 1)
	strip.line:SetShown(themed and cfg.showTopLine ~= false)
	holder.line:SetShown(themed and cfg.showTopLine ~= false)
	local previous
	for _, key in ipairs(tabOrder) do
		local button = buttons[key]
		local selected = (key == "quests" and not active) or (active and key == "polestar")
		local questieFont = questieHeader and questieHeader.trackedQuests and questieHeader.trackedQuests.label
		local fontObject = questieFont or (not themed and ((header and header.Text)
			or _G.ObjectiveTrackerHeaderFont or _G.GameFontNormalSmall))
		if fontObject and fontObject.GetFont then
			local path, size, flags = fontObject:GetFont()
			if path and size then button.label:SetFont(path, size, flags or "") end
		elseif themed and EllesmereUI and EllesmereUI.GetFontPath then
			button.label:SetFont(EllesmereUI.GetFontPath("questTracker"), 12, "")
		end
		button.bg:SetColorTexture(r, g, b, 0.2)
		button.bg:SetShown(themed and selected)
		button.label:SetTextColor(selected and r or 0.6,
			selected and g or 0.6, selected and b or 0.6)
		button:SetHeight(rowHeight - 8)
		button:SetWidth(math.max(button.label:GetStringWidth() + 16, 44))
		button:ClearAllPoints()
		if previous then button:SetPoint("LEFT", previous, "RIGHT", 6, 0)
		else
			local inset = matchHeader and 8 or 6
			button:SetPoint("LEFT", strip, "LEFT", inset + leftExtension, 0)
		end
		previous = button
	end
end

local function Layout()
	if not strip or InCombat() then return end
	writing = true
	local suppress = active and not ns.Hidden()
	tracker:SetAlpha(suppress and 0 or desiredAlpha)
	for tex, alpha in pairs(textures) do tex:SetAlpha(suppress and 0 or alpha) end
	-- Stay in the tracker's window layer. HIGH strata put the tab strip over
	-- unrelated windows; a small level offset is enough to keep tabs clickable.
	local strata = tracker:GetFrameStrata() or "LOW"
	local level = tracker:GetFrameLevel() + 1
	if strip:GetFrameStrata() ~= strata then strip:SetFrameStrata(strata) end
	if strip:GetFrameLevel() ~= level then strip:SetFrameLevel(level) end
	if active then polestarDock:Layout(tracker, customTracker, EllesmereStyle()) end
	writing = false
	Paint()
end

local function Select(mode)
	if not strip then return end
	if InCombat() then
		pending = mode
		ns.Print(L["Tab change queued until combat ends."])
		return
	end
	if mode == "polestar" and not polestarDock then return end
	active = mode ~= "quests"
	writing = true
	holder:SetShown(active)
	if polestarDock then polestarDock:SetSelected(active, active) end
	writing = false
	Layout()
end

local function Surface(name)
	local frame = CreateFrame("Frame", name, ns.UIParent, "BackdropTemplate")
	frame:SetFrameStrata(tracker:GetFrameStrata() or "LOW")
	frame.fill = frame:CreateTexture(nil, "BACKGROUND")
	frame.fill:SetAllPoints()
	frame.line = frame:CreateTexture(nil, "OVERLAY")
	frame.line:SetPoint("TOPLEFT")
	frame.line:SetPoint("TOPRIGHT")
	-- MidnightChores OnePixel: a physical pixel at the current UI scale.
	local pixel = 1
	local scale = frame:GetEffectiveScale()
	if scale > 0 and PixelUtil and PixelUtil.GetNearestPixelSize then
		local ok, value = pcall(PixelUtil.GetNearestPixelSize, 1, scale)
		if ok and type(value) == "number" and value > 0 and value < math.huge then
			pixel = value
		end
	end
	frame.line:SetHeight(pixel)
	return frame
end

local function Initialize()
	if not Skin.Enabled() or Skin.SharedHost() then return false end
	if strip then return true end
	if InCombat() then
		return false
	end
	if IsLoggedIn and not IsLoggedIn() then
		return false
	end
	local guide = Skin.PolestarGuide()
	if not guide or not guide.frame then
		return false
	end
	-- Forever's custom tracker replaces the Blizzard skin entirely. It has
	-- its own frame and bg/topLine textures, not EllesmereUIQTBackground.
	customTracker = _G.EUI_CustomQuestTracker ~= nil
	questieTracker = false
	tracker = customTracker and _G.EUI_CustomQuestTracker or _G.ObjectiveTrackerFrame
	background = customTracker and tracker or _G.EllesmereUIQTBackground
	if not tracker then
		return false
	end
	if not background then
		local eqt = _G.EllesmereUIQuestTracker
		-- Do not latch onto Blizzard's hidden tracker while EUI's custom
		-- replacement is still being built during login.
		if Loaded("EllesmereUIQuestTracker") and eqt and eqt.Blizz and not eqt.Blizz() then
			return false
		end
		-- MidnightChores' native docking bounds: the visible NineSlice extends
		-- 30px left and 5px right of ObjectiveTrackerFrame. Use our own FRAME
		-- as the anchor, never a region or protected tracker child.
		local profile = _G.Questie and Questie.db and Questie.db.profile
		questieTracker = profile and profile.trackerEnabled == true
		if questieTracker then
			tracker = _G.Questie_BaseFrame
			if not tracker or tracker:GetWidth() <= 25 then return false end
		end
		nativeTracker = not questieTracker
		background = CreateFrame("Frame", "PolestarTrackerDockNativeAnchor", ns.UIParent)
		background:SetPoint("TOPLEFT", tracker, "TOPLEFT", nativeTracker and -30 or 0, 0)
		background:SetPoint("TOPRIGHT", tracker, "TOPRIGHT", nativeTracker and 5 or 0, 0)
		background:SetHeight(1)
		background:EnableMouse(false)
	end
	if not nativeTracker and not questieTracker then
		backgroundTexture = customTracker and tracker.bg or background._tex
		backgroundDivider = customTracker and tracker.topLine or background._divider
	end

	desiredAlpha = tracker:GetAlpha()
	strip = Surface("PolestarTrackerDockTabs")
	holder = Surface("PolestarTrackerDockContent")
	holder:SetFrameLevel(tracker:GetFrameLevel() + 5)
	holder:SetPoint("TOPLEFT", background, "TOPLEFT")
	holder:SetPoint("TOPRIGHT", background, "TOPRIGHT")
	-- Consume clicks across the replaced tracker, including empty guide space.
	holder:EnableMouse(true)
	holder:Hide()
	polestarDock = Skin.AttachPolestar(holder,
		function() if not writing then Select("polestar") end end,
		function() if not writing and active then Select("quests") end end)
	local entries = {{"quests", L["Quests"]}, {"polestar", "Polestar"}}

	for _, entry in ipairs(entries) do
		local key = entry[1]
		local button = CreateFrame("Button", nil, strip)
		button.bg = button:CreateTexture(nil, "BACKGROUND")
		button.bg:SetAllPoints()
		button.label = button:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
		button.label:SetPoint("CENTER")
		button.label:SetText(entry[2])
		if EllesmereStyle() and EllesmereUI and EllesmereUI.GetFontPath then
			button.label:SetFont(EllesmereUI.GetFontPath("questTracker"), 12, "")
		end
		button:SetScript("OnClick", function() Select(key) end)
		buttons[key] = button
		tabOrder[#tabOrder + 1] = key
	end

	SuppressTexture(backgroundTexture)
	SuppressTexture(backgroundDivider)
	hooksecurefunc(tracker, "SetAlpha", function(self, alpha)
		if writing then return end
		desiredAlpha = alpha
		if active and not ns.Hidden() then
			writing = true
			self:SetAlpha(0)
			writing = false
		end
	end)
	-- Start on quests, preserving the host tracker's login behavior. Remembering
	-- a guide tab across reloads is a separate user-facing policy choice.
	Select("quests")
	return true
end


local enabled
function Skin.Enabled()
	if enabled == nil then
		-- Detect enabled addons before their files load: the standalone addon
		-- depends on Polestar, so IsAddOnLoaded alone would miss it here.
		-- Saved configurations can predate the mutually exclusive controls.
		-- Keep the guide floating when hiding the tracker or using the gamepad HUD.
		enabled = ns.Get("ui.trackerDock") and not ns.Get("qol.hideQuestTracker")
			and not ns.GamepadUI() and not ns.Compat.AddOnPresent("Polestartrackerdock") or false
	end
	return enabled
end

local function Host()
	local host = _G.FTAEllesmereTrackerDock
	if not host or host.SupportsQuestie then return host end
	local profile = _G.Questie and Questie.db and Questie.db.profile
	local eqt = _G.EllesmereUIQuestTracker
	local waitingForEllesmere = Loaded("EllesmereUIQuestTracker") and eqt and eqt.Blizz and not eqt.Blizz()
	if profile and profile.trackerEnabled and not _G.EUI_CustomQuestTracker
	    and not _G.EllesmereUIQTBackground and not waitingForEllesmere then
	    return nil
	end
	return host
end

function Skin.SharedHost()
	local host = Host()
	return host and host.CanDock() and host
end

local function Register()
	local host = Host()
	if host and not Skin.registered and Skin.Enabled() then
		Skin.registered = true
		host.RegisterGuide("polestar", "Polestar", Skin.PolestarGuide, Skin.AttachPolestar)
	end
end

local reloadDialog, reloadPending

local function CloseReloadPrompt()
	if InCombat() then return end
	reloadPending = false
	if not reloadDialog then return end
	UnregisterStateDriver(reloadDialog, "visibility")
	reloadDialog:Hide()
end

local function ShowReloadPrompt()
	if ns.Hidden() or ns.GamepadUI() then return end
	if InCombat() then
		reloadPending = true
		return
	end
	reloadPending = false
	if not reloadDialog then
		-- Reload is protected on Forever. Let the client execute /reload from
		-- a real click on SecureActionButtonTemplate, without a Lua callback.
		local dialog = CreateFrame("Frame", "PolestarTrackerDockReload", UIParent, "BackdropTemplate")
		dialog:SetSize(380, 150)
		dialog:SetPoint("CENTER", UIParent, "CENTER")
		dialog:SetFrameStrata("FULLSCREEN_DIALOG")
		dialog:EnableMouse(true)
		dialog:Hide()
		dialog:SetBackdrop(NATIVE_BACKDROP)
		dialog:SetBackdropColor(0.04, 0.04, 0.04, 1)
		local title = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
		title:SetPoint("TOP", dialog, "TOP", 0, -20)
		title:SetText(L["Reload UI?"])
		local text = dialog:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
		text:SetPoint("TOPLEFT", dialog, "TOPLEFT", 24, -52)
		text:SetWidth(332)
		text:SetText(L["Reload to apply quest tracker docking changes."])
		local reload = CreateFrame("Button", nil, dialog, "UIPanelButtonTemplate,SecureActionButtonTemplate")
		reload:SetSize(140, 26)
		reload:SetPoint("BOTTOMRIGHT", dialog, "BOTTOMRIGHT", -24, 20)
		reload:SetText(L["Reload UI"])
		reload:RegisterForClicks("LeftButtonDown", "LeftButtonUp")
		reload:SetAttribute("useOnKeyDown", false)
		reload:SetAttribute("type1", "macro")
		reload:SetAttribute("macrotext1", "/reload")
		reload:HookScript("PostClick", function(_, _, down)
			if not down then CloseReloadPrompt() end
		end)
		local later = CreateFrame("Button", nil, dialog, "UIPanelButtonTemplate")
		later:SetSize(140, 26)
		later:SetPoint("BOTTOMLEFT", dialog, "BOTTOMLEFT", 24, 20)
		later:SetText(L["Later"])
		later:SetScript("OnClick", CloseReloadPrompt)
		dialog.Reload, dialog.Later = reload, later
		dialog:EnableKeyboard(true)
		dialog:SetScript("OnKeyDown", function(self, key)
			if InCombat() then return end
			self:SetPropagateKeyboardInput(key ~= "ESCAPE")
			if key == "ESCAPE" then CloseReloadPrompt() end
		end)
		reloadDialog = dialog
	end
	-- The client hides the protected dialog in combat and brings it back
	-- afterward. No insecure Show/Hide or attribute changes run in combat.
	RegisterStateDriver(reloadDialog, "visibility", "[combat] hide; show")
end

ns.On("SETTING_CHANGED", function(path)
	if path == "ui.trackerDock" then ShowReloadPrompt() end
end)

ns.On("POLESTAR_HIDDEN", function(hidden)
	if hidden then CloseReloadPrompt() end
	Layout()
end)

local events = CreateFrame("Frame", nil, ns.UIParent)
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:SetScript("OnEvent", function(self, event, addon)
	if event == "ADDON_LOADED" then
		if addon == "Polestar" then
			self:UnregisterEvent("ADDON_LOADED")
			Register()
		end
	elseif event == "PLAYER_LOGIN" then
		C_Timer.After(0, function()
			Register()
			Initialize()
		end)
	elseif event == "PLAYER_REGEN_ENABLED" then
		if ns.Hidden() then CloseReloadPrompt()
		elseif reloadPending then ShowReloadPrompt() end
		if pending then
			local mode = pending
			pending = nil
			Select(mode)
		else
			Layout()
		end
	end
end)
-- The background is created lazily. A modest update also follows tracker fades,
-- movement, theme changes and FTA settings without hooking restricted modules.
events:SetScript("OnUpdate", function(_, dt)
	elapsed = elapsed + dt
	if elapsed < 0.2 then return end
	elapsed = 0
	if not Skin.Enabled() or Skin.SharedHost() then return end
	if not strip and not Initialize() then return end
	if InCombat() then return end
	local visible = tracker:IsShown()
	strip:SetShown(visible)
	holder:SetShown(visible and active)
	local alpha = desiredAlpha
	if not customTracker and background:GetAlpha() < alpha then alpha = background:GetAlpha() end
	strip:SetAlpha(alpha)
	holder:SetAlpha(alpha)
	Layout()
end)
