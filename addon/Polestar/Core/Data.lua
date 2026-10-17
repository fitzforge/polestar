-- Polestar.Data: load-on-demand data packs (Polestar_Codex and friends).
-- Contract: docs/ARCHITECTURE.md, "Core services: Data, Hooks, Search".
--
--   Data.Pack(name) -> loaded, reason|nil
--     Loads the pack once per session through C_AddOns.LoadAddOn. Never in
--     combat (returns false, "combat"; a later call out of combat tries
--     again). Any other failure is final for the session; reason is
--     LoadAddOn's second return in lower case ("missing", "disabled",
--     "interface_version", "dep_missing", ...), "unavailable" without the
--     API, "error" when the load itself raised.
--   Data.Info(name) -> { loaded, reason, memoryKB }
--     memoryKB from UpdateAddOnMemoryUsage/GetAddOnMemoryUsage (nil when the
--     client hides it).
--   Data.CheckInstall() -> missing, stale
--     The release zip's folders beside Polestar: names of the required ones
--     (Polestar_Guides, Polestar_Codex) that are not installed, and "name
--     (version)" for any of them whose TOC version differs from Polestar's.
--     At login a non-empty result prints one line saying to reinstall: a
--     player who copied only some folders, or one level too deep, finds out.

local ADDON, ns = ...

local Data = {}
ns.Data = Data

local type, pcall, tostring = type, pcall, tostring
local lower = string.lower

local state = {} -- name -> { loaded = bool, reason = string|nil }

local readable = ns.Compat.Readable

local function alreadyLoaded(name)
	local isLoaded = C_AddOns and C_AddOns.IsAddOnLoaded
	if not isLoaded then return false end
	local ok, loading, loaded = pcall(isLoaded, name)
	if not ok then return false end
	if loaded == nil then loaded = loading end
	return readable(loaded) == true
end

function Data.Pack(name)
	if type(name) ~= "string" or name == "" then return false, "missing" end
	local s = state[name]
	if s then
		if s.loaded then return true end
		if s.reason ~= "combat" then return false, s.reason end
	end
	if alreadyLoaded(name) then
		state[name] = { loaded = true }
		return true
	end
	if InCombatLockdown and InCombatLockdown() then
		state[name] = { loaded = false, reason = "combat" }
		return false, "combat"
	end
	local load = C_AddOns and C_AddOns.LoadAddOn
	if not load then
		state[name] = { loaded = false, reason = "unavailable" }
		return false, "unavailable"
	end
	local ok, loaded, reason = pcall(load, name)
	if not ok then
		ns.Debug("Data.Pack:", name, tostring(loaded))
		state[name] = { loaded = false, reason = "error" }
		return false, "error"
	end
	loaded = readable(loaded)
	if loaded then
		state[name] = { loaded = true }
		return true
	end
	reason = readable(reason)
	reason = type(reason) == "string" and reason ~= "" and lower(reason) or "unknown"
	state[name] = { loaded = false, reason = reason }
	return false, reason
end

function Data.Info(name)
	local s = state[name]
	local info = { loaded = (s and s.loaded) or alreadyLoaded(name), reason = s and s.reason or nil }
	if info.loaded and UpdateAddOnMemoryUsage and GetAddOnMemoryUsage then
		local ok = pcall(UpdateAddOnMemoryUsage)
		if ok then
			local got, kb = pcall(GetAddOnMemoryUsage, name)
			kb = got and readable(kb) or nil
			if type(kb) == "number" then info.memoryKB = kb end
		end
	end
	return info
end

-- Folders the release zip puts beside Polestar. The first two must be there;
-- the walking routes (Polestar_Nav), quest and item packs and the names pack
-- of the client's language (Names.PackName(), none in English) are optional
-- (the arrow falls back to straight lines, names to English; a source
-- install may not build the packs), but when present they must be the same
-- version.
local COMPANIONS = { "Polestar_Guides", "Polestar_Codex", "Polestar_Nav", "Polestar_QuestDB", "Polestar_ItemDB" }
local REQUIRED = { Polestar_Guides = true, Polestar_Codex = true }

local function installed(name)
	local A = C_AddOns
	if not A then return true end
	if alreadyLoaded(name) then return true end
	if A.DoesAddOnExist then
		local ok, exists = pcall(A.DoesAddOnExist, name)
		if ok then return readable(exists) == true end
	end
	if not A.GetAddOnInfo then return true end
	local ok, _, _, _, _, reason = pcall(A.GetAddOnInfo, name)
	return ok and readable(reason) ~= "MISSING"
end

local function versionOf(name)
	local get = C_AddOns and C_AddOns.GetAddOnMetadata
	if not get then return nil end
	local ok, v = pcall(get, name, "Version")
	v = ok and readable(v) or nil
	return type(v) == "string" and v ~= "" and v or nil
end

local function check(name, mine, missing, stale)
	if not installed(name) then
		if REQUIRED[name] then missing[#missing + 1] = name end
	else
		local v = versionOf(name)
		if v and mine and v ~= mine then stale[#stale + 1] = name .. " (" .. v .. ")" end
	end
end

function Data.CheckInstall()
	local missing, stale = {}, {}
	local mine = ns.version
	for _, name in ipairs(COMPANIONS) do check(name, mine, missing, stale) end
	local names = ns.Names and ns.Names.PackName()
	if names then check(names, mine, missing, stale) end
	-- Our guide pack's texts addon for the client's language, when that
	-- language has one (Core/GuideTexts.lua): never missing either.
	local texts = ns.GuideTexts and ns.GuideTexts.TextsAddon("Polestar_Guides")
	if texts then check(texts, mine, missing, stale) end
	return missing, stale
end

ns.OnLogin(function()
	local missing, stale = Data.CheckInstall()
	if #missing == 0 and #stale == 0 then return end
	local parts = {}
	if #missing > 0 then parts[#parts + 1] = string.format(ns.L["%s not installed"], table.concat(missing, ", ")) end
	if #stale > 0 then parts[#parts + 1] = string.format(ns.L["%s from another version"], table.concat(stale, ", ")) end
	ns.Print(string.format(ns.L["Polestar %s is installed incompletely: %s. Close the game, delete every Polestar folder in Interface/AddOns and unzip the latest Polestar zip there (CurseForge or GitHub Releases, not \"Source code\")."],
		tostring(ns.version), table.concat(parts, "; ")))
end)
