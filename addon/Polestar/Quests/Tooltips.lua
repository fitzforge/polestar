-- Quest lines on unit, item and object tooltips, and quest icons on the
-- nameplates of objective mobs. Both read the per-entity indexes Tracker.lua
-- keeps for quests in the log, so a hover costs one table lookup.
--
-- Tooltips go through Polestar.Hooks (Core/Hooks.lua, the one owner of the
-- client's tooltip post-calls): UnitLines, ItemLines and ObjectLines, owner
-- "quests". The suite's quest line (agreed with Lookup): Hooks.AddLine(tt,
-- "<Quest>:", "<what> 3/8", quest colour, textDim or success once done), so
-- it reads "<Quest>: Kill Kobold Vermin 3/10" on the mob, "<Quest>: Large
-- Candle 3/8" on a mob or object that drops it, "<Quest>: 3/8" on the item.
--
-- Secret values: Forever can hand out unit GUIDs (and tooltip text) as secret
-- values in combat. Hooks skips them; nameplates check with issecretvalue (via
-- Compat.GetNpcID). A secret value means "no quest lines", never an error.

local ADDON, ns = ...

local Q = ns.QuestDB
local L = ns.L
local type, pairs = type, pairs

local function tooltipsOn()
	return Q.IsRunning() and ns.Get("qol.questTooltips")
end

---------------------------------------------------------------------------
-- Tooltip lines
---------------------------------------------------------------------------

local function addLine(tt, left, right, lc, rc)
	ns.Hooks.AddLine(tt, left, right, lc.r, lc.g, lc.b, rc.r, rc.g, rc.b)
end

local function addObjectiveLines(tt, list, selfKind, selfID, selfName)
	if not list then return 0 end
	local qc, dim, ok = Q.Color("quest"), Q.Color("textDim"), Q.Color("success")
	local added = 0
	for i = 1, #list do
		local o = list[i]
		local e = o.entry
		local what = Q.ProgressText(o)
		local isSelf = o.kind == selfKind and (o.id == selfID or (selfName ~= nil and o.name == selfName))
		if isSelf and o.kind == 1 and o.name then
			what = L["Kill"] .. " " .. o.name .. " " .. what
		elseif not isSelf and o.name then
			what = o.name .. " " .. what
		end
		addLine(tt, (e.title or ("Quest " .. o.q)) .. ":", what, qc, (o.done or e.ready) and ok or dim)
		added = added + 1
	end
	return added
end

-- Items that start a quest: built from the database on first use.
local startItems
local function questsStartedBy(itemID)
	if not startItems then
		startItems = {}
		local F = Q.F
		for q, r in pairs(Q._data.quests) do
			for _, it in Q.Each(r[F.START_ITEM]) do
				local list = startItems[it]
				if not list then
					list = {}
					startItems[it] = list
				end
				list[#list + 1] = q
			end
		end
		for _, list in pairs(startItems) do table.sort(list) end
	end
	return startItems[itemID]
end

local function addStartLines(tt, itemID)
	local list = questsStartedBy(itemID)
	if not list then return 0 end
	local qc, tc = Q.Color("quest"), Q.Color("text")
	local added = 0
	for i = 1, #list do
		local q = list[i]
		if not ns.Compat.IsQuestCompleted(q) and not ns.Compat.IsOnQuest(q) then
			addLine(tt, L["Starts a quest"] .. ":", Q.GetQuestTitle(q) or tostring(q), qc, tc)
			added = added + 1
		end
	end
	return added
end

-- Public so other tooltip paths (and tests) can ask for the same lines.
function Q.AddUnitLines(tt, npcID)
	if not (npcID and tooltipsOn()) then return 0 end
	return addObjectiveLines(tt, Q.ObjectivesForNpc(npcID), 1, npcID)
end

function Q.AddItemLines(tt, itemID)
	if not (itemID and tooltipsOn()) then return 0 end
	return addObjectiveLines(tt, Q.ObjectivesForItem(itemID), 2, itemID) + addStartLines(tt, itemID)
end

function Q.AddObjectLines(tt, objectID, name)
	if not tooltipsOn() then return 0 end
	local list = objectID and Q.ObjectivesForObject(objectID)
	if not list and name then list = Q.ObjectivesForObjectName(name) end
	return addObjectiveLines(tt, list, 3, objectID, name)
end

local OWNER = "quests"

local function onUnit(tt, unit)
	if tooltipsOn() then Q.AddUnitLines(tt, ns.Compat.GetNpcID(unit)) end
end

local function onItem(tt, _, itemID)
	if tooltipsOn() then Q.AddItemLines(tt, itemID) end
end

local function onObject(tt, objectID, name)
	if tooltipsOn() then Q.AddObjectLines(tt, objectID, name) end
end

-- Registered only while the module runs, so an idle Quests costs no hook.
local hooked = false
local function refreshHooks()
	local H = ns.Hooks
	if not H then return end
	local want = tooltipsOn() and true or false
	if want == hooked then return end
	hooked = want
	H.UnitLines(OWNER, want and onUnit or nil)
	H.ItemLines(OWNER, want and onItem or nil)
	if H.ObjectLines then H.ObjectLines(OWNER, want and onObject or nil) end
end

---------------------------------------------------------------------------
-- Nameplate icons
---------------------------------------------------------------------------

local plateUnits = {} -- unit token -> npc id read when the plate appeared (or false)
local icons = {} -- unit token -> icon frame
local pool = {}
local platesRegistered = false

local function platesOn()
	return Q.IsRunning() and ns.Get("qol.nameplateIcons")
end

local function needsKill(npcID)
	local list = npcID and Q.ObjectivesForNpc(npcID)
	if not list then return false end
	for i = 1, #list do
		local o = list[i]
		if not o.done and not o.entry.ready then return true, o end
	end
	return false
end

-- The counts of the objectives the mob is still needed for, by quest:
-- "3/10", or "3/10 · 1/8" when it counts for two. Nil when none has a
-- count to show (a single kill or item: the icon says it all).
local COUNT_SEP = " \194\183 "
local function byQuest(a, b)
	if a.q ~= b.q then return a.q < b.q end
	return a.id < b.id
end

local function countText(npcID)
	local list = npcID and Q.ObjectivesForNpc(npcID)
	if not list then return nil end
	local open
	for i = 1, #list do
		local o = list[i]
		if not o.done and not o.entry.ready and (o.max or 0) > 1 then
			open = open or {}
			open[#open + 1] = o
		end
	end
	if not open then return nil end
	table.sort(open, byQuest)
	for i = 1, #open do open[i] = Q.ProgressText(open[i]) end
	return table.concat(open, COUNT_SEP)
end

local function plateFor(unit)
	if not (C_NamePlate and C_NamePlate.GetNamePlateForUnit) then return nil end
	local ok, plate = pcall(C_NamePlate.GetNamePlateForUnit, unit)
	if ok and type(plate) == "table" then return plate end
	return nil
end

-- Where the icon goes. Replacement nameplate addons hide or restyle Blizzard's
-- plate and draw their own health bar, so the icon looks for the plate the
-- player actually sees: a known addon's per-unit frame, then any shown child
-- of the base plate that holds a status bar, then Blizzard's own health bar,
-- then the base plate itself. Every access is guarded; a failure falls back
-- to the base plate.
local ICON_SIZE, ICON_MIN, ICON_MAX = 16, 14, 20
local ICON_GAP = 3 -- px between the icon and the left end of the bar
local ICON_LIFT = 5 -- frame levels above the frame the icon sits on
local COUNT_GAP = 2 -- px between the progress and the icon
local isIcon = setmetatable({}, { __mode = "k" })

-- Shown and readable: forbidden frames (protected plates) are skipped.
local function shown(f)
	if type(f) ~= "table" or type(f.IsShown) ~= "function" then return false end
	if f.IsForbidden and f:IsForbidden() then return false end
	return f:IsShown() and true or false
end

-- EllesmereUI Nameplates keeps a per-unit frame in
-- EllesmereNameplates_NS.plates (enemies) and .friendlyPlates, parented to
-- the base plate, with its bar in .health; Blizzard's UnitFrame stays on the
-- base plate at alpha 0.
local EUI_LISTS = { "plates", "friendlyPlates" }

-- host: the addon's frame for this unit; bar: its health bar (or nil).
local function knownPlate(plate, unit)
	local eui = _G.EllesmereNameplates_NS
	if type(eui) == "table" then
		for i = 1, #EUI_LISTS do
			local list = eui[EUI_LISTS[i]]
			local p = type(list) == "table" and list[unit]
			if type(p) == "table" and p.nameplate == plate and shown(p) then return p, p.health end
		end
	end
	local uf = plate.unitFrame -- Plater (.healthBar), ElvUI and other oUF plates (.Health)
	if uf ~= plate.UnitFrame and shown(uf) then return uf, uf.healthBar or uf.Health end
	local kui = plate.kui -- KuiNameplates
	if shown(kui) then return kui, kui.HealthBar end
	local tp = plate.TPFrame -- Threat Plates
	if shown(tp) then return tp, type(tp.visual) == "table" and tp.visual.healthbar or nil end
	return nil
end

-- The widest shown StatusBar at or up to two levels under `f`.
local function statusBarIn(f, depth)
	if f:IsObjectType("StatusBar") then return f end
	if depth == 0 then return nil end
	local best, bestW
	local kids = { f:GetChildren() }
	for i = 1, #kids do
		local k = kids[i]
		if not isIcon[k] and shown(k) then
			local bar = statusBarIn(k, depth - 1)
			local w = bar and bar:GetWidth() * bar:GetHeight()
			if bar and (not best or w > bestW) then best, bestW = bar, w end
		end
	end
	return best
end

-- Any other nameplate addon: the shown child of the base plate (not
-- Blizzard's UnitFrame) holding the largest status bar.
local function genericPlate(plate)
	local host, bar, area
	local kids = { plate:GetChildren() }
	for i = 1, #kids do
		local k = kids[i]
		if k ~= plate.UnitFrame and not isIcon[k] and shown(k) then
			local b = statusBarIn(k, 2)
			local a = b and b:GetWidth() * b:GetHeight()
			if b and (not host or a > area) then host, bar, area = k, b, a end
		end
	end
	return host, bar
end

-- Blizzard's UnitFrame while it is on the plate and not faded out.
local function blizzardPlate(plate)
	local uf = plate.UnitFrame
	if not (shown(uf) and uf:GetParent() == plate and uf:GetAlpha() > 0.01) then return nil end
	return uf, shown(uf.healthBar) and uf.healthBar or nil
end

-- owner (icon parent), ref (frame the icon must sit above), bar, above (what
-- the icon sits on when there is no bar), replaced (a replacement plate found).
local function locate(plate, unit)
	local host, bar = knownPlate(plate, unit)
	if not host then host, bar = genericPlate(plate) end
	if host then
		-- Parented to the replacement frame: it follows that frame's alpha and
		-- scale (non-target fading, target scaling) and hides with it.
		if not shown(bar) then bar = nil end
		local name = not bar and host.name
		return host, bar or host, bar, shown(name) and name or host, true
	end
	local uf
	uf, bar = blizzardPlate(plate)
	if uf then
		local name = not bar and uf.name
		return plate, bar or uf, bar, shown(name) and name or plate, false
	end
	return plate, plate, nil, plate, false
end

-- Anchors `f` to what the player sees on `plate`. Returns ok, replaced.
local function place(f, plate, unit)
	local found, owner, ref, bar, above, replaced = pcall(locate, plate, unit)
	if not found then owner, ref, bar, above, replaced = plate, plate, nil, plate, false end
	local ok = pcall(function()
		f:SetParent(owner)
		f:ClearAllPoints()
		if bar then
			local s = math.floor(bar:GetHeight() + 0.5)
			if s < ICON_MIN then s = ICON_MIN elseif s > ICON_MAX then s = ICON_MAX end
			f:SetSize(s, s)
			f:SetPoint("RIGHT", bar, "LEFT", -ICON_GAP, 0)
		else
			f:SetSize(ICON_SIZE, ICON_SIZE)
			f:SetPoint("BOTTOM", above, "TOP", 0, above == plate and -2 or 2)
		end
		f:SetFrameStrata(ref:GetFrameStrata())
		f:SetFrameLevel(ref:GetFrameLevel() + ICON_LIFT)
	end)
	if ok or owner == plate then return ok, ok and replaced end
	ok = pcall(function()
		f:SetParent(plate)
		f:ClearAllPoints()
		f:SetSize(ICON_SIZE, ICON_SIZE)
		f:SetPoint("BOTTOM", plate, "TOP", 0, -2)
	end)
	return ok, false
end

local function acquire(plate, unit)
	local f = pool[#pool]
	if f then
		pool[#pool] = nil
	else
		f = CreateFrame("Frame")
		f.tex = f:CreateTexture(nil, "OVERLAY")
		f.tex:SetAllPoints(f)
		-- The progress, left of the icon: a region of our own frame, so it
		-- follows the plate's fading and scaling with the icon.
		local fs = f:CreateFontString(nil, "OVERLAY")
		local T = ns.Theme
		if T and T.Font then
			T.Font(fs, "small")
			T.SetOutline(fs, true)
		else
			fs:SetFontObject("GameFontHighlightSmall")
		end
		fs:SetPoint("RIGHT", f, "LEFT", -COUNT_GAP, 0)
		fs:SetWordWrap(false)
		f.count = fs
		isIcon[f] = true
	end
	local ok, replaced = place(f, plate, unit)
	if not ok then
		f:Hide()
		pool[#pool + 1] = f
		return nil
	end
	return f, replaced
end

local function release(unit)
	local f = icons[unit]
	if not f then return end
	icons[unit] = nil
	f:Hide()
	f:ClearAllPoints()
	f:SetParent(nil)
	pool[#pool + 1] = f
end

local function updatePlate(unit)
	local npc = plateUnits[unit]
	local need, o = false, nil
	if npc and platesOn() then need, o = needsKill(npc) end
	if not need then
		release(unit)
		return
	end
	local f = icons[unit]
	if not f then
		local plate = plateFor(unit)
		if not plate then return end
		local replaced
		f, replaced = acquire(plate, unit)
		if not f then return end
		icons[unit] = f
		-- Replacement plates are often built in the same event after this
		-- handler, or a frame later: look again once on the next frame.
		if not replaced and C_Timer and C_Timer.After then
			C_Timer.After(0, function()
				if icons[unit] ~= f then return end
				local now = plateFor(unit)
				if now then place(f, now, unit) end
			end)
		end
	end
	-- All objectives on nameplates are mobs to kill or loot: show the game's skull.
	local skullTex = ns.Theme and ns.Theme.Media and ns.Theme.Media("icon-skull")
		or "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8"
	f.tex:SetTexture(skullTex)
	f.tex:SetVertexColor(1, 1, 1, 1)
	-- The client shows the objective count in the nameplate name; hide ours to
	-- avoid the duplicate.
	f.count:SetText("")
	f.count:Hide()
	f:Show()
end

local function onPlateAdded(_, unit)
	if type(unit) ~= "string" then return end
	plateUnits[unit] = ns.Compat.GetNpcID(unit) or false
	updatePlate(unit)
end

local function onPlateRemoved(_, unit)
	if type(unit) ~= "string" then return end
	plateUnits[unit] = nil
	release(unit)
end

local function refreshPlates()
	local on = platesOn()
	if on and not platesRegistered then
		platesRegistered = ns.RegisterEvent("NAME_PLATE_UNIT_ADDED", onPlateAdded)
		ns.RegisterEvent("NAME_PLATE_UNIT_REMOVED", onPlateRemoved)
	elseif not on and platesRegistered then
		ns.UnregisterEvent("NAME_PLATE_UNIT_ADDED", onPlateAdded)
		ns.UnregisterEvent("NAME_PLATE_UNIT_REMOVED", onPlateRemoved)
		platesRegistered = false
		for unit in pairs(plateUnits) do plateUnits[unit] = nil end
	end
	for unit in pairs(icons) do
		if not plateUnits[unit] then release(unit) end
	end
	for unit in pairs(plateUnits) do updatePlate(unit) end
end

-- Units currently showing a quest icon (tests, debugging).
function Q.NameplateIcons()
	local out = {}
	for unit, f in pairs(icons) do
		if f:IsShown() then out[#out + 1] = unit end
	end
	table.sort(out)
	return out
end

-- The icon frame on a unit's nameplate, or nil (tests, debugging).
function Q.NameplateIcon(unit)
	return icons[unit]
end

-- The progress beside that icon ("3/10"), or nil (tests, debugging).
function Q.NameplateCount(unit)
	local f = icons[unit]
	if not (f and f:IsShown() and f.count:IsShown()) then return nil end
	return f.count:GetText()
end

local function refreshAll()
	refreshHooks()
	refreshPlates()
end

ns.On("QUESTDB_UPDATED", refreshAll)
ns.On("QUESTDB_STARTED", refreshAll)
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.nameplateIcons" or path == "qol.questTooltips" or path == "qol.questDB" or path == "qol" or path == "" then refreshAll() end
end)
