-- Mark goals (guide format 10): `mark <npcId> <icon> ["note"]` puts a raid
-- icon over the nameplate of every mob of that kind while its step is the
-- current one, and a line on the mob's tooltip ("Polestar: Pull first", or
-- the icon's name without a note). A mark never holds a step (Engine.lua
-- treats it as a note).
--
-- The icon is our own texture on the plate, seen by this player only:
-- Polestar never calls SetRaidTarget (restricted on Forever). Unit GUIDs are
-- read through Compat.GetNpcID, as Quests/Tooltips.lua does: a secret value
-- reads as unknown, so that plate gets no icon and its tooltip no line.
-- Tooltip lines go through Polestar.Hooks (owner "marks").
--
--   Marks.Current() -> { [npcId] = icon }   the current step's marks
--   Marks.Icon(unit) -> texture | nil       the texture on that unit's plate
--
-- Setting: nav.marks (Guide > Arrow & routes > Along the route).

local ADDON, ns = ...
local L = ns.L

local type, pairs, ipairs, next, pcall, tostring = type, pairs, ipairs, next, pcall, tostring

local Marks = {}
ns.Marks = Marks

ns.RegisterDefaults("nav", { marks = true })

local ICON_PATH = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_"
local ICON_SIZE = 20
local ICON_LIFT = 20 -- px between the plate's top and the icon

local icons = {} -- npc id -> icon (1-8), the current step's marks
local notes = {} -- npc id -> the mark's note
local units = {} -- unit token -> true while its plate is shown
local onUnit = {} -- unit token -> the plate showing our icon
local textures = {} -- plate -> its icon texture (plates are recycled; so are these)
local hooked = false

local function on() return ns.Get("nav.marks") and true or false end

local function npcOf(unit)
	local C = ns.Compat
	return C and C.GetNpcID and C.GetNpcID(unit) or nil
end

local function plateFor(unit)
	return ns.Compat.GetNamePlateForUnit(unit)
end

local function textureOn(plate)
	local t = textures[plate]
	if t then return t end
	local ok, made = pcall(plate.CreateTexture, plate, nil, "OVERLAY")
	if not ok or not made then return nil end
	made:SetSize(ICON_SIZE, ICON_SIZE)
	made:SetPoint("BOTTOM", plate, "TOP", 0, ICON_LIFT)
	textures[plate] = made
	return made
end

local function clear(unit)
	local plate = onUnit[unit]
	if not plate then return end
	onUnit[unit] = nil
	local t = textures[plate]
	if t then t:Hide() end
end

local function update(unit)
	local npc = npcOf(unit)
	local icon = npc and icons[npc]
	local plate = icon and plateFor(unit)
	if onUnit[unit] and onUnit[unit] ~= plate then clear(unit) end
	if not plate then return end
	local t = textureOn(plate)
	if not t then return end
	t:SetTexture(ICON_PATH .. icon)
	t:Show()
	onUnit[unit] = plate
end

-- The name of raid icon n in the client's language (GlobalStrings).
local function iconName(n)
	local name = _G["RAID_TARGET_" .. n]
	return type(name) == "string" and name or tostring(n)
end

local function onTooltip(tt, unit)
	local npc = npcOf(unit)
	local icon = npc and icons[npc]
	if not icon then return end
	local text = "|T" .. ICON_PATH .. icon .. ":0|t " .. L["Polestar: %s"]:format(notes[npc] or iconName(icon))
	local T = ns.Theme
	if T and T.Color then
		local r, g, b = T.Color("accent")
		ns.Hooks.AddLine(tt, text, nil, r, g, b)
	else
		ns.Hooks.AddLine(tt, text)
	end
end

-- The current step's marks, read again: on a guide or step change and when
-- the setting changes. Plates already up are redrawn.
local function collect()
	for k in pairs(icons) do icons[k] = nil end
	for k in pairs(notes) do notes[k] = nil end
	local E = ns.Engine
	local guide = on() and E and E.GetGuide and E.GetGuide()
	local step = guide and guide.steps and guide.steps[E.GetStepIndex() or 0]
	-- A mark for other classes, races or factions (`only`) is not this
	-- character's, as Engine.lua's goalApplies reads it.
	local player = step and ns.Compat.GetPlayerInfo()
	for _, goal in ipairs(step and step.goals or {}) do
		if goal.t == "mark" and type(goal.npc) == "number" and type(goal.icon) == "number"
			and ns.Guides.Matches(goal.only, player) then
			icons[goal.npc] = goal.icon
			notes[goal.npc] = goal.note
		end
	end
	local want = next(icons) ~= nil
	local H = ns.Hooks
	if H and H.UnitLines and want ~= hooked then
		hooked = want
		H.UnitLines("marks", want and onTooltip or nil)
	end
	for unit in pairs(onUnit) do
		if not units[unit] then clear(unit) end
	end
	for unit in pairs(units) do update(unit) end
end

function Marks.Current()
	local out = {}
	for npc, icon in pairs(icons) do out[npc] = icon end
	return out
end

function Marks.Icon(unit)
	local plate = onUnit[unit]
	return plate and textures[plate] or nil
end

ns.RegisterEvent("NAME_PLATE_UNIT_ADDED", function(_, unit)
	if type(unit) ~= "string" then return end
	units[unit] = true
	if next(icons) then update(unit) end
end)

ns.RegisterEvent("NAME_PLATE_UNIT_REMOVED", function(_, unit)
	if type(unit) ~= "string" then return end
	units[unit] = nil
	clear(unit)
end)

ns.On("GUIDE_CHANGED", collect)
ns.On("STEP_CHANGED", collect)
ns.On("SETTING_CHANGED", function(path)
	if path == "nav.marks" or path == "nav" or path == "" then collect() end
end)

---------------------------------------------------------------------------
-- Options: Guide > Arrow & routes > Along the route
---------------------------------------------------------------------------

if ns.RegisterOptions then
	local ok, err = ns.RegisterOptions({
		page = L["Guide"], tab = L["Arrow & routes"], section = L["Along the route"],
		controls = {
			{ kind = "toggle", key = "nav.marks", label = L["Marks on nameplates"],
				search = "raid icon, skull, nameplate, mark, pull",
				help = L["A guide can mark the mobs that matter with a raid icon. Polestar draws it over their nameplates, for you only, and says why on their tooltip."] },
		},
	})
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
