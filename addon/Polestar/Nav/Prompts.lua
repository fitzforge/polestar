-- Travel prompts: the route's cast button and the manual leg step.
--
-- Adapted from Shortest Path Forever by Cillian Berragan (GPL-3.0-or-later,
-- used with permission): its cast prompt (a Hearthstone or teleport leg shows
-- the item or spell to use in the arrow's place, UI/Arrow.lua) and its
-- "complete this step" with a refused Hearthstone left out of the rest of the
-- journey (Journey/Journey.lua). Polestar's prompt is a clickable secure
-- button rather than a picture of one.
-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
--
--   The travel button (PolestarTravelButton, bindable as
--   `CLICK PolestarTravelButton:LeftButton`): while the route's current leg
--   is a Hearthstone, teleport or item leg (leg.kind "hearth", leg.item,
--   leg.spell) and you have the item or know the spell, a secure button just
--   under the arrow casts it with a left click. It is created, filled, moved,
--   shown and hidden only out of combat: a change asked for in combat waits
--   for PLAYER_REGEN_ENABLED (the last request wins) while the button keeps
--   doing what it did. Icon and cooldown are plain textures and repaint at
--   any time. Off with nav.castPrompt, and while the guide is hidden. A
--   step's own Hearthstone button (QoL/Buttons.lua) already showing the same
--   item wins.
--
--   Skip a leg: right-click the arrow (or the travel button), or
--   /polestar skipleg. A Hearthstone, teleport, flight, ride or portal leg
--   ("Skip this leg") is left out and the rest of this trip planned without
--   it; a walk or lift step ("Mark this leg done") is marked done and the
--   arrow moves on (Nav.travel.SkipLeg, Nav.travel.SkipReplans).

local ADDON, ns = ...
local Nav = ns.Nav
local L = ns.L

local type, tonumber, pairs = type, tonumber, pairs

local Prompts = {}
Nav.prompts = Prompts

ns.RegisterDefaults("nav", { castPrompt = true })

local HEARTHSTONE = 6948
local SIZE = 36
local GAP = 6                   -- px between the arrow's foot and the button
local DEFAULT_Y = -262          -- under the arrow's default spot when it is hidden
local NAME = "PolestarTravelButton"

---------------------------------------------------------------------------
-- Secure changes: now, or once combat ends (as QoL.Secure does for the
-- quest buttons; Nav loads before QoL and keeps its own queue)
---------------------------------------------------------------------------

local queued = {}

local function inLockdown()
	return InCombatLockdown and InCombatLockdown() and true or false
end

local function secure(key, fn)
	if inLockdown() then
		queued[key] = fn
		return false
	end
	queued[key] = nil
	fn()
	return true
end

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	for key, fn in pairs(queued) do
		queued[key] = nil
		ns.SafeCall(fn)
	end
end)

function Prompts.Pending() return queued.travel ~= nil end

---------------------------------------------------------------------------
-- What the current leg asks you to use
---------------------------------------------------------------------------

local function itemCount(id)
	local C = ns.Compat
	if C and C.GetItemCount then return C.GetItemCount(id) or 0 end
	if C_Item and C_Item.GetItemCount then return C_Item.GetItemCount(id) or 0 end
	if GetItemCount then return GetItemCount(id) or 0 end
	return 0
end

local function spellKnown(id)
	local C = ns.Compat
	if C and C.IsSpellKnown then return C.IsSpellKnown(id) and true or false end
	if IsPlayerSpell then return IsPlayerSpell(id) and true or false end
	return true
end

local function spellName(id)
	if C_Spell and C_Spell.GetSpellName then
		local name = C_Spell.GetSpellName(id)
		if name then return name end
	end
	if GetSpellInfo then
		local name = GetSpellInfo(id)
		if name then return name end
	end
	return id
end

-- "item", itemID | "spell", spellID | nil: the action a leg asks for, when
-- the player can take it.
function Prompts.ActionOf(leg)
	if type(leg) ~= "table" then return nil end
	local spell = tonumber(leg.spell)
	if spell then
		if spellKnown(spell) then return "spell", spell end
		return nil
	end
	local item = tonumber(leg.item) or (leg.kind == "hearth" and HEARTHSTONE or nil)
	if item and itemCount(item) > 0 then return "item", item end
	return nil
end

local function currentLeg()
	local legs, ci = nil, nil
	if Nav.GetRoute then legs, ci = Nav.GetRoute() end
	if type(legs) ~= "table" or not ci then return nil end
	return legs[ci], ci, #legs
end

-- A step's own Hearthstone button showing this item already.
local function stepButtonHas(kind, id)
	local Q = ns.QoL
	local b = kind == "item" and Q and Q.Buttons and Q.Buttons.hearth
	return b and b.itemID == id and b:IsShown() and true or false
end

-- kind, id the button should hold now (nil: hidden).
function Prompts.Wanted()
	if not ns.Get("nav.castPrompt") or not ns.GuideShown() then return nil end
	local kind, id = Prompts.ActionOf((currentLeg()))
	if not kind or stepButtonHas(kind, id) then return nil end
	return kind, id
end

---------------------------------------------------------------------------
-- The button
---------------------------------------------------------------------------

local button
local want = {}      -- kind, id asked for
local applied = {}   -- kind, id the secure attributes hold

local function themeColor(region, name, alpha)
	local r, g, b = Nav.RGB(name)
	local T = ns.Theme
	if T and T.Color then
		local ok, tr, tg, tb = pcall(T.Color, name)
		if ok and type(tr) == "number" then r, g, b = tr, tg, tb end
	end
	if region.SetVertexColor and region:GetObjectType() == "Texture" then
		region:SetVertexColor(r, g, b, alpha or 1)
	elseif region.SetTextColor then
		region:SetTextColor(r, g, b, alpha or 1)
	end
end

local function paintBorder(b, hover)
	local T = ns.Theme
	if not (T and T.Border) then return end
	if hover then
		local r, g, bl = T.Accent()
		T.Border(b, r, g, bl, 1)
	else
		local r, g, bl, a = T.Color("border")
		T.Border(b, r, g, bl, (a or 0.08) * 2.5)
	end
end

local function iconOf(kind, id)
	if kind == "item" then
		if C_Item and C_Item.GetItemIconByID then
			local icon = C_Item.GetItemIconByID(id)
			if icon then return icon end
		end
		if GetItemIcon then return GetItemIcon(id) end
	elseif kind == "spell" then
		if C_Spell and C_Spell.GetSpellTexture then
			local icon = C_Spell.GetSpellTexture(id)
			if icon then return icon end
		end
		if GetSpellTexture then return GetSpellTexture(id) end
	end
	return 134400 -- the question mark
end

local function cooldownOf(kind, id)
	if kind == "item" then
		if C_Container and C_Container.GetItemCooldown then return C_Container.GetItemCooldown(id) end
		if GetItemCooldown then return GetItemCooldown(id) end
	elseif kind == "spell" then
		local C = ns.Compat
		if C and C.GetSpellCooldown then return C.GetSpellCooldown(id) end
	end
end

-- Icon and cooldown: plain regions, any time.
local function paint()
	if not button or not applied.kind then return end
	button.Icon:SetTexture(iconOf(applied.kind, applied.id))
	local start, duration = cooldownOf(applied.kind, applied.id)
	if duration and duration > 1.5 then button.Cooldown:SetCooldown(start, duration) else button.Cooldown:Clear() end
end

local function openMenu(anchor)
	local items = Prompts.MenuItems()
	if not items then return end
	local W = ns.Widgets
	if W and W.ShowMenu then
		W.ShowMenu(anchor, items, { point = "TOP", relPoint = "BOTTOM", x = 0, y = -4 })
	else
		items[1].onClick(items[1])
	end
end
Prompts.OpenMenu = openMenu

local function create()
	local b = CreateFrame("Button", NAME, UIParent, "SecureActionButtonTemplate")
	b:SetSize(SIZE, SIZE)
	b:SetFrameStrata("MEDIUM")
	b:RegisterForClicks("AnyUp", "AnyDown")
	b:Hide()

	local T = ns.Theme
	local media = T and T.Media and T.Media("white") or "Interface\\Buttons\\WHITE8X8"
	local bg = b:CreateTexture(nil, "BACKGROUND")
	bg:SetTexture(media)
	bg:SetAllPoints(b)
	themeColor(bg, "panel")
	b.Bg = bg

	local icon = b:CreateTexture(nil, "ARTWORK")
	icon:SetPoint("TOPLEFT", b, "TOPLEFT", 2, -2)
	icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -2, 2)
	icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	b.Icon = icon

	local hl = b:CreateTexture(nil, "HIGHLIGHT")
	hl:SetTexture(media)
	hl:SetAllPoints(icon)
	local function paintHover()
		if T and T.Wash then hl:SetVertexColor(T.Wash("hover")) else hl:SetVertexColor(1, 1, 1, 0.07) end
	end
	paintHover()
	b.Hl = hl

	b.Cooldown = CreateFrame("Cooldown", nil, b, "CooldownFrameTemplate")
	b.Cooldown:SetAllPoints(icon)

	paintBorder(b, false)
	if T and T.OnChanged then
		T.OnChanged(function()
			themeColor(bg, "panel")
			paintHover()
			paintBorder(b, false)
		end)
	end

	-- Left click casts (type1 only); right click is left to the menu.
	b:HookScript("PostClick", function(self, mouse, down)
		if mouse == "RightButton" and not down then openMenu(self) end
	end)
	-- Press or release: the client gives an addon's secure button no mouse
	-- arguments, so SecureActionButton_OnClick acts on the press when
	-- useOnKeyDown (nil: the ActionButtonUseKeyDown CVar) says so, else on
	-- the release, for mouse and key alike. As the quest buttons do
	-- (QoL/Buttons.lua): the cursor on it (out of combat) makes it false, so a
	-- mouse click casts once, on its release; leaving puts it back to nil, so
	-- the binding follows the player's key-down setting.
	b:SetScript("OnEnter", function(self)
		-- The game's Quick Keybind Mode takes the hover (QoL/QuickBind.lua).
		local QB = ns.QoL and ns.QoL.QuickBind
		if QB and QB.Hover(self) then return end
		if not inLockdown() then self:SetAttribute("useOnKeyDown", false) end
		paintBorder(self, true)
		if not GameTooltip then return end
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if applied.kind == "item" and GameTooltip.SetItemByID then
			GameTooltip:SetItemByID(applied.id)
		elseif applied.kind == "spell" and GameTooltip.SetSpellByID then
			GameTooltip:SetSpellByID(applied.id)
		end
		GameTooltip:AddLine(L["Right-click to skip this leg."], Nav.RGB("textDim"))
		GameTooltip:Show()
	end)
	b:SetScript("OnLeave", function(self)
		secure("press", function() self:SetAttribute("useOnKeyDown", nil) end)
		paintBorder(self, false)
		if GameTooltip and GameTooltip:GetOwner() == self then GameTooltip:Hide() end
	end)
	button = b
	Prompts.button = b
	-- Bindable from Quick Keybind Mode while it shows (never shown for it:
	-- it stands under the arrow only for a cast leg).
	local QB = ns.QoL and ns.QoL.QuickBind
	if QB then QB.Add(b) end
end

-- Just under the arrow, in UIParent's space; the arrow may be scaled.
local function place()
	local a = Nav.arrow and Nav.arrow.frame
	local x, bottom
	if a and a:IsShown() then
		x, bottom = a:GetCenter(), a:GetBottom()
	end
	button:ClearAllPoints()
	if x and bottom then
		local s = a:GetEffectiveScale() / UIParent:GetEffectiveScale()
		button:SetPoint("TOP", UIParent, "BOTTOMLEFT", x * s, bottom * s - GAP)
	else
		button:SetPoint("TOP", UIParent, "TOP", 0, DEFAULT_Y)
	end
end

-- The one secure change: create, place, fill and show, or empty and hide.
local function sync()
	local kind, id = want.kind, want.id
	if not kind then
		if button then
			button:SetAttribute("type1", nil)
			button:SetAttribute("item", nil)
			button:SetAttribute("spell", nil)
			button:Hide()
		end
		applied.kind, applied.id = nil, nil
		return
	end
	if not button then create() end
	place()
	button:SetAttribute("type1", kind)
	button:SetAttribute("item", kind == "item" and ("item:" .. id) or nil)
	button:SetAttribute("spell", kind == "spell" and spellName(id) or nil)
	applied.kind, applied.id = kind, id
	paint()
	button:Show()
end

local function update()
	local kind, id = Prompts.Wanted()
	want.kind, want.id = kind, id
	if kind == applied.kind and id == applied.id and (button == nil or button:IsShown() == (kind ~= nil)) then
		if not queued.travel then
			paint()
			return
		end
	end
	secure("travel", sync)
end

-- The arrow moved or came back: follow it (out of combat).
local function replace()
	if applied.kind then secure("travel", sync) end
end

---------------------------------------------------------------------------
-- Skipping a leg
---------------------------------------------------------------------------

-- The leg a skip would act on: a current leg that is not the route's last
-- (the final walk is the arrow's own target).
local function skippable()
	local T = Nav.travel
	if not (T and T.Active and T.Active()) then return nil end
	local leg, ci, n = currentLeg()
	if not leg or ci >= n then return nil end
	return leg
end

function Prompts.SkipLeg()
	local T = Nav.travel
	local leg = skippable()
	if not leg or not (T and T.SkipLeg) then
		ns.Print(L["No travel leg to skip."])
		return false
	end
	local ok = T.SkipLeg()
	if ok == false then
		ns.Print(L["No travel leg to skip."])
		return false
	end
	update()
	return true
end

local function skip() Prompts.SkipLeg() end

-- The menu's rows for the current leg, or nil when nothing can be skipped.
function Prompts.MenuItems()
	local leg = skippable()
	if not leg then return nil end
	local T = Nav.travel
	if T.SkipReplans and T.SkipReplans(leg) then
		return { { text = L["Skip this leg"], tip = L["Plans the rest of this trip without it."], onClick = skip } }
	end
	return { { text = L["Mark this leg done"], tip = L["The arrow moves on to the next leg."], onClick = skip } }
end

ns.RegisterCommand("skipleg", function()
	if Nav.SayHandedOff() then return end
	skip()
end, L["Skip the travel route's current leg (a Hearthstone, teleport, flight, ride or portal: plan the rest without it; a walk or lift: mark it done)"])

---------------------------------------------------------------------------
-- Wiring
---------------------------------------------------------------------------

local function hookArrow()
	local a = Nav.arrow and Nav.arrow.frame
	if not a or Prompts.hooked then return end
	Prompts.hooked = true
	a:HookScript("OnMouseUp", function(self, mouse)
		if mouse == "RightButton" then openMenu(self) end
	end)
	a:HookScript("OnEnter", function()
		local leg = GameTooltip and skippable()
		if leg then
			local T = Nav.travel
			local replans = T.SkipReplans and T.SkipReplans(leg)
			GameTooltip:AddLine(replans and L["Right-click to skip this leg."] or L["Right-click to mark this leg done."], Nav.RGB("textDim"))
			GameTooltip:Show()
		end
	end)
	a:HookScript("OnDragStop", replace)
	a:HookScript("OnShow", replace)
end

-- Nav calls these: the once-a-second tick, nav.* settings.
Prompts.Update = update
function Prompts:Refresh() update() end
function Prompts:OnSettings()
	update()
	replace()
end
Nav.RegisterModule(Prompts)

ns.On("ROUTE_CHANGED", update)
ns.On("ROUTE_ADVANCED", update)
ns.On("WAYPOINT_CHANGED", update)
ns.On("STEP_CHANGED", update)
ns.RegisterEvent("BAG_UPDATE_DELAYED", update)
ns.RegisterEvent("SPELLS_CHANGED", update)
ns.RegisterEvent("BAG_UPDATE_COOLDOWN", paint)
ns.RegisterEvent("SPELL_UPDATE_COOLDOWN", paint)
ns.RegisterEvent("GET_ITEM_INFO_RECEIVED", paint)

ns.OnLogin(function()
	hookArrow()
	update()
end)

---------------------------------------------------------------------------
-- Options: Guide > Arrow & routes > Along the route (Alerts.lua adds its
-- own), and Quality of Life > Travel > Along the route: one setting, a fresh
-- control per page (the registry keeps per-control state).
---------------------------------------------------------------------------

if ns.RegisterOptions then
	local function castPrompt()
		return Nav.HandoffOption({ kind = "toggle", key = "nav.castPrompt", label = L["Travel button"],
			search = "hearth, hearthstone, teleport, portal, cast button, travel spell",
			help = L["When the route says to hearth or teleport, a button under the arrow casts it. Right-click the arrow to skip a leg."] })
	end
	for _, spec in ipairs({
		{ page = L["Guide"], tab = L["Arrow & routes"], section = L["Along the route"], controls = { castPrompt() } },
		{ page = L["Quality of Life"], tab = L["Travel"], section = L["Along the route"], controls = { castPrompt() } },
	}) do
		local ok, err = ns.RegisterOptions(spec)
		if not ok and geterrorhandler then geterrorhandler()(err) end
	end
end
