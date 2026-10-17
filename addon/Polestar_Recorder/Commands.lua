-- /psrec: status, on|off, mark <text>, maps, talents, clear.

local ADDON, ns = ...
local L = ns.L

local type, pairs, ipairs, tostring, GetTime = type, pairs, ipairs, tostring, GetTime

local CLEAR_WINDOW = 30 -- seconds to confirm /psrec clear

---------------------------------------------------------------------------
-- Map dump: every map under Azeroth with name/type/parent/world bounds
---------------------------------------------------------------------------

local AZEROTH = 947

local function dumpMaps()
	if not (C_Map and C_Map.GetMapInfo and C_Map.GetMapChildrenInfo) then return 0 end
	local root = AZEROTH
	if not C_Map.GetMapInfo(root) then
		root = C_Map.GetFallbackWorldMapID and C_Map.GetFallbackWorldMapID() or nil
		if not root or not C_Map.GetMapInfo(root) then return 0 end
	end
	local maps = ns.DB().maps
	local count = 0
	local function add(id)
		local info = ns.MapInfo(id)
		if info then
			maps[id] = info
			count = count + 1
		end
	end
	add(root)
	local children = C_Map.GetMapChildrenInfo(root, nil, true)
	if type(children) == "table" then
		for _, child in ipairs(children) do
			if child.mapID and child.mapID ~= root then add(child.mapID) end
		end
	end
	return count
end
ns.DumpMaps = dumpMaps

---------------------------------------------------------------------------
-- Talent dump. Forever's talents are a trait tree (C_ClassTalents/C_Traits)
-- whose groups are the class's classic-style trees.
---------------------------------------------------------------------------

local function activeConfigID()
	local id = C_ClassTalents and C_ClassTalents.GetActiveConfigID and C_ClassTalents.GetActiveConfigID()
	if id then return id end
	if C_SpecializationInfo and C_SpecializationInfo.GetActiveSpecGroup and C_SpecializationInfo.GetCombatConfigIDForSpecGroup then
		return C_SpecializationInfo.GetCombatConfigIDForSpecGroup(C_SpecializationInfo.GetActiveSpecGroup())
	end
	return nil
end

-- Returns the dump, or nil plus a reason.
local function dumpTalents()
	if not (C_Traits and C_Traits.GetConfigInfo and C_Traits.GetTreeNodes and C_Traits.GetNodeInfo) then
		return nil, L["this client exposes no talent tree API"]
	end
	local configID = activeConfigID()
	if not configID then return nil, L["no active talent configuration (too low level?)"] end
	local config = C_Traits.GetConfigInfo(configID)
	if not config or type(config.treeIDs) ~= "table" or #config.treeIDs == 0 then
		return nil, L["the talent configuration has no trees"]
	end
	local _, class = UnitClass("player")
	local GetVersion = GetBuildInfo
	local dump = { class = class, configID = configID, recorded = GetServerTime(), trees = {} }
	if GetVersion then
		local version, build = GetVersion()
		dump.build = tostring(version) .. "." .. tostring(build)
	end
	local nodeCount = 0
	for _, treeID in ipairs(config.treeIDs) do
		local tree, n = ns.TraitTree(configID, treeID)
		dump.trees[#dump.trees + 1] = tree
		nodeCount = nodeCount + n
	end
	if nodeCount == 0 then return nil, L["the talent trees returned no nodes"] end
	return dump, nodeCount
end
ns.DumpTalents = dumpTalents

---------------------------------------------------------------------------
-- Legacy dump. Forever surfaces achievements as Legacy Challenges
-- (Blizzard_AchievementUI/Camelot, Blizzard_LegacySystem): every category of
-- GetCategoryList() appears there, Legacy points per achievement come from
-- C_Traits.GetTraitCurrencyForAchievement, the reward track is the major
-- faction LEGACY_REWARD_TRACK_FACTION_ID, and the Legacy trees are trait
-- trees. The achievement globals are not in the API docs (FrameXML uses
-- them), so each is guarded.
---------------------------------------------------------------------------

-- Values of Constants.LegacyConsts in LegacyConstantsDocumentation (1.60.1),
-- used when the client does not expose the table.
local LEGACY_FALLBACK = {
	LEGACY_REWARD_TRACK_FACTION_ID = 2802,
	LEGACY_POINTS_TRAIT_CURRENCY_ID = 4225,
	LEGACY_TREE_PROFESSIONS_ID = 1187,
	LEGACY_TREE_ADVENTURE_ID = 1188,
	LEGACY_TREE_PROGRESSION_ID = 1189,
}

local function legacyConst(name)
	local c = Constants and Constants.LegacyConsts
	return (c and c[name]) or LEGACY_FALLBACK[name]
end

local function fn(name)
	local f = _G[name]
	return type(f) == "function" and f or nil
end

local function nonZero(v)
	if v == nil or v == 0 or v == "" then return nil end
	return v
end

local function dumpAchievements(dump)
	local GetCategoryList, GetCategoryInfo, GetCategoryNumAchievements, GetAchievementInfo =
		fn("GetCategoryList"), fn("GetCategoryInfo"), fn("GetCategoryNumAchievements"), fn("GetAchievementInfo")
	if not (GetCategoryList and GetCategoryInfo and GetCategoryNumAchievements and GetAchievementInfo) then return 0 end
	local GetNumCriteria, GetCriteria, GetPrevious = fn("GetAchievementNumCriteria"), fn("GetAchievementCriteriaInfo"), fn("GetPreviousAchievement")
	local currency = legacyConst("LEGACY_POINTS_TRAIT_CURRENCY_ID")
	local pointsFor = C_Traits and C_Traits.GetTraitCurrencyForAchievement
	local count = 0
	for order, catID in ipairs(GetCategoryList() or {}) do
		local name, parent = GetCategoryInfo(catID)
		local cat = { name = name, parent = (parent and parent ~= -1) and parent or nil, order = order, legacy = true, achievements = {} }
		dump.categories[catID] = cat
		for index = 1, (GetCategoryNumAchievements(catID)) or 0 do
			local id, aName, points, completed, _, _, _, description, flags, _, rewardText, _, earnedByMe = GetAchievementInfo(catID, index)
			if id then
				cat.achievements[#cat.achievements + 1] = id
				local legacyPoints = pointsFor and pointsFor(currency, id) or nil
				local a = {
					name = aName, description = description, points = points, category = catID,
					completed = completed and true or false, earnedByMe = earnedByMe and true or nil,
					flags = nonZero(flags), reward = nonZero(rewardText),
					legacyPoints = nonZero(legacyPoints), legacy = (legacyPoints and legacyPoints > 0) or nil,
					previous = GetPrevious and GetPrevious(id) or nil,
					criteria = {},
				}
				if GetNumCriteria and GetCriteria then
					for ci = 1, GetNumCriteria(id) or 0 do
						local text, ctype, done, quantity, required, _, cflags, assetID, _, criteriaID = GetCriteria(id, ci)
						a.criteria[ci] = {
							text = text, type = ctype, assetID = nonZero(assetID), quantity = quantity, required = required,
							completed = done and true or false, id = nonZero(criteriaID), flags = nonZero(cflags),
						}
					end
				end
				dump.achievements[id] = a
				count = count + 1
			end
		end
	end
	return count
end

local function dumpMajorFactions(dump)
	local M = C_MajorFactions
	if not (M and M.GetMajorFactionData) then return end
	local legacyID = legacyConst("LEGACY_REWARD_TRACK_FACTION_ID")
	local ids, seen = {}, {}
	if M.GetMajorFactionIDs then
		for _, id in ipairs(M.GetMajorFactionIDs() or {}) do
			if not seen[id] then ids[#ids + 1], seen[id] = id, true end
		end
	end
	if not seen[legacyID] then ids[#ids + 1] = legacyID end
	for _, id in ipairs(ids) do
		local d = M.GetMajorFactionData(id)
		if d then
			local f = {
				name = d.name, description = nonZero(d.description), unlocked = d.isUnlocked and true or false,
				level = M.GetCurrentRenownLevel and M.GetCurrentRenownLevel(id) or d.renownLevel, maxLevel = d.maxLevel,
				earned = d.renownReputationEarned, threshold = d.renownLevelThreshold,
				legacy = id == legacyID or nil, levels = {},
			}
			if M.GetRenownLevels then
				for _, l in ipairs(M.GetRenownLevels(id) or {}) do
					local level = { level = l.level, locked = l.locked and true or false, milestone = l.isMilestone or nil, capstone = l.isCapstone or nil, rewards = {} }
					if M.GetRenownRewardsForLevel then
						for _, r in ipairs(M.GetRenownRewardsForLevel(id, l.level) or {}) do
							level.rewards[#level.rewards + 1] = {
								id = r.renownRewardID, name = r.name, description = r.description, type = r.rewardType,
								item = r.itemID, spell = r.spellID, mount = r.mountID, title = r.titleMaskID,
								accountUnlock = r.isAccountUnlock or nil,
							}
						end
					end
					f.levels[#f.levels + 1] = level
				end
			end
			dump.majorFactions[id] = f
		end
	end
end

local LEGACY_TREES = { "LEGACY_TREE_PROFESSIONS_ID", "LEGACY_TREE_ADVENTURE_ID", "LEGACY_TREE_PROGRESSION_ID" }

local function dumpLegacyTrees(dump)
	for _, const in ipairs(LEGACY_TREES) do
		local treeID = legacyConst(const)
		local configID = C_Traits and C_Traits.GetConfigIDByTreeID and C_Traits.GetConfigIDByTreeID(treeID)
		local tree
		if configID then
			tree = ns.TraitTree(configID, treeID)
			tree.configID = configID
			if C_Traits.GetTreeCurrencyInfo then
				tree.currency = {}
				for _, c in ipairs(C_Traits.GetTreeCurrencyInfo(configID, treeID, false) or {}) do
					tree.currency[#tree.currency + 1] = { id = c.traitCurrencyID, quantity = c.quantity, max = c.maxQuantity, spent = c.spent }
				end
			end
		else
			tree = { id = treeID, groups = {}, nodes = {} }
		end
		tree.key = const:gsub("^LEGACY_TREE_", ""):gsub("_ID$", ""):lower()
		dump.trees[#dump.trees + 1] = tree
	end
end

local function dumpLegacy()
	local dump = {
		recorded = GetServerTime(),
		rewardFaction = legacyConst("LEGACY_REWARD_TRACK_FACTION_ID"),
		pointsCurrency = legacyConst("LEGACY_POINTS_TRAIT_CURRENCY_ID"),
		categories = {}, achievements = {}, majorFactions = {}, trees = {},
	}
	local n = dumpAchievements(dump)
	dumpMajorFactions(dump)
	dumpLegacyTrees(dump)
	return dump, n
end
ns.DumpLegacy = dumpLegacy

---------------------------------------------------------------------------
-- Status
---------------------------------------------------------------------------

local function countKeys(t)
	local n = 0
	if type(t) == "table" then for _ in pairs(t) do n = n + 1 end end
	return n
end

local function status()
	local db = ns.DB()
	local s = ns.Session()
	ns.Print(L["recording %s"]:format(ns.IsEnabled() and "|cff4fd18f" .. L["on"] .. "|r" or "|cffd14f4f" .. L["off"] .. "|r"))
	if s then
		local pos = s.counts and s.counts.pos or 0
		ns.Print(L["session %s: %d events (%d breadcrumbs), %d min"]:format(
			tostring(s.session), #s.events, pos, math.floor(ns.Now() / 60)))
		local dropped = 0
		for _, n in pairs(s.dropped or {}) do dropped = dropped + n end
		if dropped > 0 then ns.Print(L["%d events dropped by the per-session caps"]:format(dropped)) end
	else
		ns.Print(L["no session yet"])
	end
	ns.Print(L["%d sessions stored, %d maps dumped"]:format(countKeys(db.sessions), countKeys(db.maps))
		.. (db.talents and L[", talents dumped"] or ""))
	if s then
		ns.Print(L["this session: %s"]:format(table.concat({
			s.factions and L["factions"] or "-", s.skills and L["skills"] or "-", s.legacy and L["legacy"] or "-",
		}, " ")))
	end
	ns.Print(L["commands: /psrec on | off | mark <text> | maps | talents | legacy | factions | skills | clear"])
end

---------------------------------------------------------------------------
-- Slash command
---------------------------------------------------------------------------

local clearArmedAt

local commands = {}

commands.status = status

commands.on = function()
	ns.SetEnabled(true)
	ns.Print(L["recording %s"]:format("|cff4fd18f" .. L["on"] .. "|r"))
end

commands.off = function()
	ns.SetEnabled(false)
	ns.Print(L["recording %s"]:format("|cffd14f4f" .. L["off"] .. "|r"))
end

commands.mark = function(rest)
	if rest == "" then
		ns.Print(L["usage: /psrec mark <text>"])
		return
	end
	if not ns.IsEnabled() then
		ns.Print(L["recording is off; /psrec on first"])
		return
	end
	if ns.Record("mark", ns.Here({ text = rest })) then
		ns.Print(L["marked: %s"]:format(rest))
	else
		ns.Print(L["mark not recorded (session cap reached)"])
	end
end

commands.maps = function()
	local n = dumpMaps()
	if n > 0 then
		ns.Print(L["recorded %d maps"]:format(n))
	else
		ns.Print(L["no maps found (C_Map unavailable)"])
	end
end

commands.talents = function()
	local dump, info = dumpTalents()
	if not dump then
		ns.Print(L["talents not recorded: %s"]:format(tostring(info)))
		return
	end
	local db = ns.DB()
	if type(db.talents) ~= "table" then db.talents = {} end
	db.talents[dump.class or "UNKNOWN"] = dump
	ns.Print(L["recorded %d talent nodes in %d tree(s) for %s"]:format(info, #dump.trees, tostring(dump.class)))
end

-- Session-scoped dumps (character state at this moment); they travel with
-- the session through `record import`.
commands.legacy = function()
	local dump, n = dumpLegacy()
	if not ns.StoreDump("legacy", dump) then
		ns.Print(L["no session yet"])
		return
	end
	local nodes, renown = 0, dump.majorFactions[dump.rewardFaction]
	for _, t in ipairs(dump.trees) do nodes = nodes + #t.nodes end
	ns.Print(L["recorded %d achievements in %d categories, %d major factions (Legacy renown %s), %d Legacy tree nodes"]:format(
		n, countKeys(dump.categories), countKeys(dump.majorFactions), renown and tostring(renown.level) or "?", nodes))
end

commands.factions = function()
	local factions, n = ns.ScanFactions()
	if not factions then
		ns.Print(L["factions not recorded: this client exposes no C_Reputation list"])
		return
	end
	if not ns.StoreDump("factions", factions) then
		ns.Print(L["no session yet"])
		return
	end
	ns.Print(L["recorded %d factions"]:format(n))
end

commands.skills = function()
	local skills, n = ns.ScanSkills()
	if not skills then
		ns.Print(L["skills not recorded: this client exposes no C_SkillInfo list"])
		return
	end
	if not ns.StoreDump("skills", skills) then
		ns.Print(L["no session yet"])
		return
	end
	ns.Print(L["recorded %d skill lines"]:format(n))
end

commands.clear = function(rest)
	local now = GetTime()
	if rest == "confirm" and clearArmedAt and now - clearArmedAt <= CLEAR_WINDOW then
		clearArmedAt = nil
		local s = ns.ClearAll()
		ns.Print(L["all recordings cleared; new session %s"]:format(tostring(s and s.session)))
		return
	end
	clearArmedAt = now
	ns.Print(L["this deletes every recorded session. Type |cffffd100/psrec clear confirm|r within %d seconds to proceed."]:format(CLEAR_WINDOW))
end

-- Polestar's Recorder page calls PolestarRecorder_Command. /psrec is not
-- registered with Forever's gamepad interface on: the chat box calls a
-- command and then closes itself in the command's taint, which blocks the
-- gamepad's actions until a reload (Polestar's Core/Init.lua, ns.GamepadUI).
-- The API is the answer; the CVar can stay "1" with the keyboard and mouse.
local function gamepadUI()
	local E = Enum and Enum.InputDeviceInterfaceType
	if not (E and E.Gamepad) then return false end
	local S = C_InputInterfaceStyle
	if S and S.GetCurrentStyle then return S.GetCurrentStyle() == E.Gamepad end
	local get = (C_CVar and C_CVar.GetCVar) or GetCVar
	return get and tonumber(get("InputDeviceInterfaceStyle")) == E.Gamepad or false
end

function PolestarRecorder_Command(msg)
	local name, rest = (msg or ""):match("^%s*(%S*)%s*(.-)%s*$")
	name = (name or ""):lower()
	if name == "" then name = "status" end
	local fn = commands[name]
	if not fn then
		ns.Print(L["unknown command: %s"]:format(name))
		status()
		return
	end
	fn(rest or "")
end
if not gamepadUI() then
	SLASH_POLESTARREC1 = "/psrec"
	SLASH_POLESTARREC2 = "/polestarrec"
	SlashCmdList.POLESTARREC = PolestarRecorder_Command
end
