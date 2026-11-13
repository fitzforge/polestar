-- Where and when the guide window shows: position, size, scale, opacity, the
-- lock, moving and resizing, and the combat and instance rules (UI/GuideFrame.lua).

local ADDON, ns = ...
local UI, Theme, W, Anim, L, floor, max, min = ns.UI, ns.Theme, ns.Widgets, ns.Anim, ns.L, math.floor, math.max, math.min
local GF = UI.GuideFrame
local resetModel, anchorSkip = GF.ResetModel, GF.AnchorSkip

-- The window's parts and sizes, handed over by the core (GF.Bind).
local F, nav, grip
GF.Bind(function(p, m)
	F, nav, grip = p.F, p.nav, p.grip
end)
local inCombat = false
local inInstance, openInside = false, false -- in a dungeon or raid; opened there by the player
local shownOnEntry = false -- ui.shown when this visit began

---------------------------------------------------------------------------
-- Window state from settings
---------------------------------------------------------------------------

local function targetAlpha()
	local a = ns.Get("ui.opacity") or 1
	if inCombat and ns.Get("ui.combat") == "fade" then a = a * GF.Num("combatAlpha") end
	-- The cursor away from the window: guideWindow.idleAlpha (1: no fade).
	if not GF.IsHovering() then a = a * GF.Num("idleAlpha") end
	return a
end

-- With ui.instance "hide" (the default), the window waits out a dungeon,
-- raid, battleground or arena until the player opens it there. Like combat
-- it never writes ui.shown, so leaving brings back what the player had.
-- Unlike combat it takes what goes with the guide along (ns.GuideShown).
local function hiddenInside()
	return inInstance and not openInside and ns.Get("ui.instance") == "hide"
end

-- What the window's own rules hide now: a fight (ui.combat "hide") and an
-- instance it waits out (ui.instance "hide"). The floating launcher
-- (UI/Launcher.lua) follows them; GUIDE_VISIBILITY says they may have changed.
-- With guideWindow.hideTaxi, a flight too.
function GF.RulesHide()
	return (inCombat and ns.Get("ui.combat") == "hide") or hiddenInside() or GF.OnTaxi()
end
function GF.OnTaxi()
	return ns.Get("guideWindow.hideTaxi") and UnitOnTaxi and UnitOnTaxi("player") and true or false
end

function GF.ApplyVisibility()
	ns.SetGuideAwayInside(hiddenInside() and ns.Get("ui.shown"))
	ns.Fire("GUIDE_VISIBILITY")
	if not F then return end
	local show = ns.Get("ui.shown") and not GF.RulesHide()
	F:SetShown(show and true or false)
end

-- The toggle (/polestar, the key binding, the minimap button) inside, with
-- ui.instance "hide" and the window on, now and on the way in: opens or
-- closes it for this visit, ui.shown untouched. -> true when it did. A
-- window that was off on the way in toggles ui.shown as anywhere else, so
-- closing it there keeps it off after leaving.
function GF.ToggleInside()
	if not (inInstance and shownOnEntry and ns.Get("ui.instance") == "hide" and ns.Get("ui.shown")) then return false end
	openInside = not openInside
	GF.ApplyVisibility()
	return true
end

function GF.ApplyAlpha(animate)
	if not F then return end
	if animate then
		Anim.To(F, "alpha", F:GetAlpha(), targetAlpha(), Anim.SLOW, "out")
	else
		Anim.Stop(F, "alpha")
		F:SetAlpha(targetAlpha())
	end
end

-- The corner the window is pinned by and that corner's y: the bottom-left
-- with ui.growUp (a longer step pushes the top edge up), else the top-left
-- (it pushes the bottom edge down). ui.pos holds that corner.
local function pinCorner()
	if ns.Get("ui.growUp") then return "BOTTOMLEFT", F:GetBottom() end
	return "TOPLEFT", F:GetTop()
end

function GF.ApplyPosition()
	if not F then return end
	local pos = ns.Get("ui.pos")
	F:ClearAllPoints()
	if type(pos) == "table" and type(pos[1]) == "number" and type(pos[2]) == "number" then
		F:SetPoint(ns.Get("ui.growUp") and "BOTTOMLEFT" or "TOPLEFT", UIParent, "BOTTOMLEFT", pos[1], pos[2])
	elseif ns.Get("ui.growUp") then
		F:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -64, 240)
	else
		F:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -64, -240)
	end
end

function GF.SavePosition()
	if not F then return end
	local l = F:GetLeft()
	local _, y = pinCorner()
	if l and y then ns.Set("ui.pos", { floor(l + 0.5), floor(y + 0.5) }) end
end

function GF.ApplyLock()
	if not F then return end
	grip:SetShown(not ns.Get("ui.locked"))
end

function GF.ApplyWidth()
	if not F then return end
	local w = ns.Get("ui.width") or 340
	F:SetWidth(min(UI.MAX_WIDTH, max(UI.MIN_WIDTH, w)))
	GF.Layout()
end

function GF.ApplyCompact()
	if not F then return end
	GF.Render()
	GF.Layout()
end

-- Scale about the pinned corner, so the window stays where the user put
-- it, then repaint so 1px lines land on the new pixel grid. From the scale
-- Polestar set last (GF.scale), not the window's own: another addon may hold
-- the window out of sight at a scale far below a pixel (ns.OutOfSight), and a
-- place worked out from that would land in the corner of the screen.
function GF.ApplyScale()
	local new = ns.Get("ui.scale") or 1
	local old = GF.scale or F:GetScale()
	if old == new then return end
	local l = F:GetLeft()
	local corner, y = pinCorner()
	F:SetScale(new)
	GF.scale = new
	if l and y and type(ns.Get("ui.pos")) == "table" then
		F:ClearAllPoints()
		F:SetPoint(corner, UIParent, "BOTTOMLEFT", l * old / new, y * old / new)
		ns.Set("ui.pos", { floor(l * old / new + 0.5), floor(y * old / new + 0.5) })
	end
	Theme.Refresh()
end

local APPLY = {
	-- Shown inside (a guide picked, /polestar show, the switch): open for the visit.
	["ui.shown"] = function()
		if inInstance and ns.Get("ui.shown") then openInside = true end
		GF.ApplyVisibility()
	end,
	["ui.instance"] = function() GF.ApplyVisibility() end,
	["ui.scale"] = function() GF.ApplyScale() end,
	["ui.opacity"] = function() GF.ApplyAlpha(false) end,
	["ui.bgOpacity"] = function() GF.ApplyStyle() end,
	["ui.style"] = function() GF.ApplyStyle() end,
	["ui.barShown"] = function() GF.ApplyStyle() end,
	["ui.backing"] = function() GF.ApplyStyle() end,
	["ui.locked"] = function() GF.ApplyLock() end,
	["ui.compact"] = function() GF.ApplyCompact() end,
	["ui.width"] = function() GF.ApplyWidth() end,
	-- With Grow upward the room above the bottom edge sets the window's height.
	["ui.pos"] = function() GF.ApplyPosition(); if ns.Get("ui.growUp") then GF.Layout() end end,
	-- Re-pin by the other corner where the window stands now, so it does not jump.
	["ui.growUp"] = function() GF.SavePosition(); GF.Layout() end,
	["ui.barsBottom"] = function() GF.Layout() end,
	["ui.upcoming"] = function() GF.Render() end,
	["ui.upcomingOpen"] = function() GF.Render() end,
	["ui.showNotes"] = function() GF.Render() end,
	["ui.notesOpen"] = function() GF.SetTipOpen(ns.Get("ui.notesOpen") and true or false); GF.Render() end,
	["ui.newInForever"] = function() GF.Render() end,
	["ui.maxHeight"] = function() GF.Layout() end,
	-- Another way of reading the card: nothing kept from the one before.
	["ui.wholeStep"] = function() resetModel(); GF.Render() end,
	["ui.combat"] = function() GF.ApplyVisibility(); GF.ApplyAlpha(false) end,
	["ui.font"] = function() GF.Layout() end,
	["nav.nearbyButton"] = function()
		nav.Nearby:SetShown(ns.Get("nav.nearbyButton") ~= false)
		anchorSkip()
		GF.Layout()
	end,
}

local function applyAll()
	GF.ApplySkin()
	GF.scale = ns.Get("ui.scale") or 1
	F:SetScale(GF.scale)
	GF.ApplyPosition()
	GF.ApplyLock()
	GF.ApplyWidth()
	GF.ApplyAlpha(false)
	GF.ApplyStyle()
	GF.ApplyCompact()
	GF.ApplyVisibility()
end
---------------------------------------------------------------------------
-- Move and resize
---------------------------------------------------------------------------

local savePosition = GF.SavePosition

local function dragStart()
	if ns.Get("ui.locked") then return end
	F:StartMoving()
end

local function dragStop()
	F:StopMovingOrSizing()
	savePosition()
	-- The class quest card on the window flips below it when there is no room above.
	if UI.ClassToast and UI.ClassToast.Place then UI.ClassToast.Place(false) end
end

local function resizeUpdate(self)
	local x = GetCursorPosition() / F:GetEffectiveScale()
	local w = min(UI.MAX_WIDTH, max(UI.MIN_WIDTH, floor(self.psStartW + (x - self.psStartX) + 0.5)))
	if w ~= floor(F:GetWidth() + 0.5) then
		F:SetWidth(w)
		GF.Layout()
	end
end

local function resizeStart(self)
	if ns.Get("ui.locked") then return end
	-- Grow from the left edge: pin the window by its left corner first.
	local l = F:GetLeft()
	local corner, y = pinCorner()
	if l and y then
		F:ClearAllPoints()
		F:SetPoint(corner, UIParent, "BOTTOMLEFT", l, y)
	end
	self.psStartX = GetCursorPosition() / F:GetEffectiveScale()
	self.psStartW = F:GetWidth()
	self:SetScript("OnUpdate", ns.Safe(resizeUpdate))
end

local function resizeStop(self)
	if not self:GetScript("OnUpdate") then return end
	self:SetScript("OnUpdate", nil)
	ns.Set("ui.width", floor(F:GetWidth() + 0.5))
	savePosition()
end

-- The combat events may have fired before a /reload or reconnect.
local function combatNow()
	local C = ns.Compat
	if C and C.InCombat then
		local ok, v = pcall(C.InCombat)
		if ok then return v and true or false end
	end
	return InCombatLockdown and InCombatLockdown() and true or false
end
ns.OnLogin(function()
	inCombat = combatNow()
	applyAll()
	GF.Render()
end)
ns.On("SETTING_CHANGED", function(path)
	if not F then return end
	local fn = APPLY[path]
	if fn then
		fn()
	elseif path == "" or path == "ui" then
		applyAll()
		if path == "" then GF.ApplyLook() end
	elseif path == "guideWindow" then
		GF.ApplyLook()
	elseif type(path) == "string" and path:sub(1, 12) == "guideWindow." then
		GF.ApplyLook(path:sub(13))
	end
end)
ns.RegisterEvent("PLAYER_REGEN_DISABLED", function()
	inCombat = true
	W.HideMenu()
	GF.ApplyVisibility()
	GF.ApplyAlpha(true)
end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	inCombat = false
	GF.ApplyVisibility()
	GF.ApplyAlpha(true)
	-- Off-route timer rows held through the fight (GF.FillHere) catch up.
	if ns.Timed and ns.IsLoggedIn() then GF.HereChanged() end
end)
-- Dungeons, raids, battlegrounds and arenas: not scenarios.
local INSTANCE_KINDS = { party = true, raid = true, pvp = true, arena = true }
local function instanceNow()
	local C = ns.Compat
	if not (C and C.IsInInstance) then return false end
	local ok, inside, kind = pcall(C.IsInInstance)
	return (ok and inside and INSTANCE_KINDS[kind]) and true or false
end

-- How to bring the window back inside: the minimap button's menu (when the
-- button is on: its click hides or shows all of Polestar), the toggle's key
-- binding (when bound, named as the client names it: "Ctrl-P"), else
-- /polestar (never with the gamepad interface, which has no slash commands).
function GF.HowToShow()
	local button = ns.Get("maps.minimapButton")
	local key = GetBindingKey and GetBindingKey("POLESTAR_TOGGLE")
	if key == "" then key = nil end
	local named = key and GetBindingText and GetBindingText(key)
	if type(named) == "string" and named ~= "" then key = named end
	if button and key then return L["Press %s, or right-click the minimap button and pick Guide window, to show it."]:format(key) end
	if button then return L["Right-click the minimap button and pick Guide window to show it."] end
	if ns.GamepadUI() then
		if key then return L["Press %s to show it."]:format(key) end
		return L["Turn on the minimap button or bind a key to show it."]
	end
	if key then return L["Press %s or type /polestar to show it."]:format(key) end
	return L["Type /polestar to show it."]
end

-- The first time on this account the window hides itself on the way in, a
-- notice at the top of the screen (Nav/Alerts.lua) says how to bring it
-- back for 12 seconds, and one chat line says where the setting is.
-- Accounts told before by the chat line alone (instanceHideTold) see the
-- notice once too. Not while Polestar is hidden: the player hid it all, and
-- the hint waits for an entry Polestar is shown on.
local function hintHiddenOnce()
	local db = ns.DB()
	if db.instanceHint or ns.Hidden() then return end
	db.instanceHint = true
	db.instanceHideTold = nil
	local howTo = GF.HowToShow()
	local alerts = ns.Nav and ns.Nav.alerts
	if alerts and alerts.ShowNotice then alerts.ShowNotice(L["Polestar is hidden here"], howTo, 12) end
	ns.Print(L["The guide window hides in dungeons and battlegrounds. %s Change it in Options > Guide > Window."]:format(howTo))
end

-- The notice goes as soon as the window is back.
ns.On("GUIDE_SHOWN", function(shown)
	local alerts = ns.Nav and ns.Nav.alerts
	if shown and alerts and alerts.HideNotice then alerts.HideNotice() end
end)

-- Every way in or out passes a loading screen, a /reload included. Going in
-- or out ends a visit, so the next one starts hidden again.
local function checkInstance()
	local now = instanceNow()
	local entered = now and not inInstance
	if now ~= inInstance then
		openInside = false
		shownOnEntry = ns.Get("ui.shown") and true or false
	end
	inInstance = now
	GF.ApplyVisibility()
	if entered and hiddenInside() and ns.Get("ui.shown") then hintHiddenOnce() end
end
ns.RegisterEvent("PLAYER_ENTERING_WORLD", checkInstance)
ns.RegisterEvent("ZONE_CHANGED_NEW_AREA", checkInstance)

GF.ApplyAll = applyAll
GF.DragStart, GF.DragStop, GF.ResizeStart, GF.ResizeStop = dragStart, dragStop, resizeStart, resizeStop

-- In a fight now (PLAYER_REGEN_*).
function GF.InCombat() return inCombat end
