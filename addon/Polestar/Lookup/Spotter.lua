-- Polestar.Lookup spotter and tooltip lines: what mount another player
-- rides and where it comes from, and where an item comes from.
--
--   Lookup.UnitMount(unit) -> { spell, item|nil, name, icon|nil, class|nil } | nil
--   /polestar mount            -- the target's mount (else the mouseover's) in Lookup
--   /polestar lookup [text]    -- open Lookup, searching text
--   MOUNT_SPOTTED(unit, info)  -- on target change and mouseover of a mounted player
--
-- Reading another player's auras on Forever (Blizzard_APIDocumentationGenerated):
--   * C_UnitAuras.GetAuraDataByIndex(unit, index, filter) -> AuraData
--     (UnitAuraDocumentation.lua) is flagged RequiresUnitAuraAccess, whose
--     FailureMode is "Error" (SecretPredicatesDocumentation.lua: "callers have
--     access to unit aura data"), so the call runs in pcall; and
--     SecretWhenUnitAuraRestricted: "secret values when combat, encounter,
--     challenge mode, or PvP match addon restrictions are in effect.
--     Individual spells may be flagged as never or always secret". Outside
--     those restrictions a player's buffs, mounts included, read normally.
--     Any secret spellId/name/aura means "unknown": the scan stops, nothing
--     is shown, nothing is compared.
--   * AuraData fields used: spellId, name, icon (AuraUtil.UnpackAuraData).
--   * UnitAura / UnitBuff only exist as Blizzard_Deprecated fallbacks
--     (Classic/Deprecated_1_15_8.lua, behind the loadDeprecationFallbacks
--     CVar); they are used only when C_UnitAuras is missing.
--   * A mount aura is matched by spell ID against the Codex (spells.json:
--     the client's mount/pet aura spells with their item and class), else
--     C_MountJournal.GetMountFromSpell + GetMountInfoByID
--     (MountJournalDocumentation.lua; guarded, may be absent or return nil).
--   * UnitIsPlayer / UnitExists (UnitDocumentation.lua), events
--     PLAYER_TARGET_CHANGED and UPDATE_MOUSEOVER_UNIT (UnitDocumentation.lua).
--
-- Item tooltips (Hooks.ItemLines) get the best one or two ranked sources and
-- "Alt-click: guide me" when lookup.tooltip is on and Alt-click would guide
-- (a mount: only with a curated guide). The Codex pack is loaded
-- on the first tooltip that needs it out of combat (Data.Pack never loads in
-- combat). Everything here is off with lookup.enabled.

local ADDON, ns = ...

local Lookup = ns.Lookup
local L = ns.L

local type, pcall, ipairs = type, pcall, ipairs

local MAX_AURAS = 40

local secret = ns.Compat.IsSecret

local function on(key)
	return ns.Get("lookup.enabled") and ns.Get(key) and true or false
end

local function codex()
	local C = ns.Codex
	if not C then return nil end
	if C.IsLoaded() then return C end
	if ns.Compat.InCombat() then return nil end
	if C.Load() then return C end
	return nil
end

---------------------------------------------------------------------------
-- Auras
---------------------------------------------------------------------------

-- -> spellId, name, icon | false (no aura at i) | nil (unreadable: stop)
local function auraAt(unit, i)
	local A = C_UnitAuras
	if A and A.GetAuraDataByIndex then
		local ok, aura = pcall(A.GetAuraDataByIndex, unit, i, "HELPFUL")
		if not ok or secret(aura) then return nil end
		if aura == nil then return false end
		local id, name, icon = aura.spellId, aura.name, aura.icon
		if secret(id) or secret(name) then return nil end
		if secret(icon) then icon = nil end
		return id, name, icon
	end
	local fn = UnitAura or UnitBuff
	if not fn then return nil end
	local ok, name, icon, a3, a4, a5, a6, a7, a8, a9, id = pcall(fn, unit, i, "HELPFUL")
	if not ok then return nil end
	if name == nil then return false end
	if secret(id) or secret(name) then return nil end
	if secret(icon) then icon = nil end
	return id, name, icon
end

local function journalMount(spellId)
	local J = C_MountJournal
	if not (J and J.GetMountFromSpell and J.GetMountInfoByID) then return nil end
	local ok, mountID = pcall(J.GetMountFromSpell, spellId)
	if not ok or secret(mountID) or type(mountID) ~= "number" then return nil end
	local got, name, _, icon = pcall(J.GetMountInfoByID, mountID)
	if not got or secret(name) or type(name) ~= "string" then return nil end
	if secret(icon) then icon = nil end
	return name, icon
end

function Lookup.UnitMount(unit)
	if type(unit) ~= "string" or not (UnitExists and UnitIsPlayer) then return nil end
	local ok, exists = pcall(UnitExists, unit)
	if not ok or secret(exists) or not exists then return nil end
	local got, isPlayer = pcall(UnitIsPlayer, unit)
	if not got or secret(isPlayer) or not isPlayer then return nil end
	local C = codex()
	for i = 1, MAX_AURAS do
		local id, name, icon = auraAt(unit, i)
		-- false: no more auras; nil: unreadable (secret or no access), stop.
		if not id then return nil end
		if type(id) == "number" then
			local spell = C and C.Spell(id)
			if spell and spell.kind == "mount" then
				return { spell = id, item = spell.item, name = spell.name or name, icon = icon, class = spell.class }
			end
			if not spell then
				local mname, micon = journalMount(id)
				if mname then return { spell = id, name = mname, icon = micon or icon } end
			end
		end
	end
	return nil
end

-- The item kind Lookup lists the mount's item under ("mount" normally).
local function itemKind(C, item)
	local rec = C and item and C.Item(item)
	return rec and rec.kind or "mount"
end

---------------------------------------------------------------------------
-- Tooltips
---------------------------------------------------------------------------

local function color(name, r, g, b)
	local T = ns.Theme
	if T and T.Color then
		local cr, cg, cb = T.Color(name)
		if cr then return cr, cg, cb end
	end
	return r, g, b
end

local function sourceText(row)
	if not row.available and row.whyText then return row.whyText end
	return row.detail
end

-- Best ranked sources of an item, at most `n`, one per source type.
local function bestRows(list, n)
	local out, seen = {}, {}
	for _, r in ipairs(list) do
		if not seen[r.type] then
			seen[r.type] = true
			out[#out + 1] = r
			if #out >= n then break end
		end
	end
	return out
end

local function guideable(list)
	for _, r in ipairs(list) do
		if r.guideable then return true end
	end
	return false
end

function Lookup.ItemTooltip(tooltip, link, itemID)
	if not on("lookup.tooltip") or not itemID then return end
	local C = codex()
	local item = C and C.Item(itemID)
	if not (item and item.sources and #item.sources > 0) then return end
	if item.status == "retired" then
		local rr, rg, rb = color("textMuted", 0.5, 0.54, 0.63)
		ns.Hooks.AddLine(tooltip, L["No longer obtainable"], nil, rr, rg, rb)
		return
	end
	local kind = item.kind or "item"
	local list = Lookup.Sources(kind, itemID, true)
	if #list == 0 then return end
	local H = ns.Hooks
	local lr, lg, lb = color("textDim", 0.69, 0.72, 0.8)
	local rr, rg, rb = color("textMuted", 0.5, 0.54, 0.63)
	for _, row in ipairs(bestRows(list, 2)) do
		local right = sourceText(row)
		H.AddLine(tooltip, L["From"] .. " " .. (row.label or ""), right, lr, lg, lb, rr, rg, rb)
	end
	-- A mount is guided to only by a curated guide (Lookup.Guide); Alt-click
	-- opens its Lookup page otherwise, so the line promises nothing.
	if ns.Get("lookup.altClick") and ((guideable(list) and not Lookup.IsMount(item)) or Lookup.CuratedGuide(kind, itemID)) then
		H.AddLine(tooltip, L["Alt-click: guide me"], nil, rr, rg, rb)
	end
end

function Lookup.UnitTooltip(tooltip, unit)
	if not on("lookup.mounts") then return end
	local info = Lookup.UnitMount(unit)
	if not info then return end
	local H = ns.Hooks
	local lr, lg, lb = color("textDim", 0.69, 0.72, 0.8)
	local rr, rg, rb = color("textMuted", 0.5, 0.54, 0.63)
	local right
	if info.item then
		local list = Lookup.Sources(itemKind(ns.Codex, info.item), info.item, true)
		if list[1] then right = sourceText(list[1]) end
	elseif info.class then
		right = L["Class mount"]
	end
	H.AddLine(tooltip, L["Mount"] .. ": " .. info.name, right, lr, lg, lb, rr, rg, rb)
	H.AddLine(tooltip, L["/pole mount: how to get it"], nil, rr, rg, rb)
end

ns.Hooks.ItemLines("lookup", Lookup.ItemTooltip)
ns.Hooks.UnitLines("lookup", Lookup.UnitTooltip)

---------------------------------------------------------------------------
-- Spotting and commands
---------------------------------------------------------------------------

local function spot(unit)
	if not on("lookup.mounts") then return end
	local info = Lookup.UnitMount(unit)
	if info then ns.Fire("MOUNT_SPOTTED", unit, info) end
end

ns.RegisterEvent("PLAYER_TARGET_CHANGED", function() spot("target") end)
ns.RegisterEvent("UPDATE_MOUSEOVER_UNIT", function() spot("mouseover") end)

local function isPlayer(unit)
	if not (UnitExists and UnitIsPlayer) then return false end
	local ok, exists = pcall(UnitExists, unit)
	if not ok or secret(exists) or not exists then return false end
	local got, p = pcall(UnitIsPlayer, unit)
	return got and not secret(p) and p and true or false
end

function Lookup.ShowMount(unit)
	if not ns.Get("lookup.enabled") then
		ns.Print(L["Lookup is turned off (Options > Discovery > Lookup)."])
		return false
	end
	unit = unit or (isPlayer("target") and "target") or "mouseover"
	local info = Lookup.UnitMount(unit)
	if not info then
		ns.Print(L["No mount found on your target or mouseover."])
		return false
	end
	if info.item then
		Lookup.Show(nil, itemKind(ns.Codex, info.item), info.item)
	else
		-- A class mount is a spell: its guide is found by name.
		Lookup.Show(info.name)
	end
	return true
end

ns.RegisterCommand("mount", function() Lookup.ShowMount() end, L["Look up your target's mount"])
ns.RegisterCommand("lookup", function(rest)
	Lookup.Show(rest ~= "" and rest or nil)
end, L["Search guides, items, mounts, NPCs and quests"])
