-- The interface strings in the language Polestar shows: Interface.lua in the
-- language folder Polestar_<locale> (load on demand), which fills L. Contract:
-- docs/ARCHITECTURE.md, "Localisation".
--
-- While the files load, the client's language: its folder loads here, before
-- the first file that reads L at load, and after Names.lua and GuideTexts.lua,
-- which the folder's Names.lua and Texts.lua fill as it loads. An English
-- client loads nothing. A folder that is missing or disabled leaves the
-- interface in English (a missing key renders as itself). Names and
-- GuideTexts ask for the folder again later through Data.Pack: if that load
-- succeeds where this one failed, L fills then, and only what was read at
-- load (key binding names, the options' labels) stays English. Not through
-- Data.Pack here: it refuses in combat, which would leave a /reload in combat
-- in English for the session, and keeps a failure for the session.
--
-- The Language setting (#3643): Follow the game (the default), English, or
-- any language Polestar ships, account-wide in its own saved variable,
-- PolestarLanguage, which the game hands over only at ADDON_LOADED. Another
-- language than the client's then replaces the client's: L empties, Names
-- and GuideTexts drop what the client's folder brought, and the chosen
-- folder loads (none for English). A change takes effect at the next
-- /reload, which the setting says; what is read while the files load (key
-- binding names, the options' labels) comes before the setting is read, so it
-- stays in the client's language.
--
--   Polestar.Language.Get() -> "game" | "enUS" | "<locale>"
--   Polestar.Language.Set(name) -> bool   -- one of Language.CHOICES; shown
--     from the next /reload
--   Polestar.Language.CHOICES   -- "game", "enUS", then the shipped languages
--   /polestar language [name]   -- the same; the settings' row is Setup >
--     General > Language (Polestar_Options/UI/Options.lua)
--
-- A folder still not loaded at login while Language follows the game, and
-- not in the AddOns folder at all, gets one chat line, in English: the
-- strings to say it in the player's language are what is missing. One turned
-- off in the AddOns list was turned off on purpose: nothing to say.

local _, ns = ...
local L, Names = ns.L, ns.Names
local Readable = ns.Compat.Readable

local Language = {}
ns.Language = Language

-- The languages Polestar ships a folder for; a client in another language
-- (itIT) has none to miss and plays in English without a word.
local LANGUAGE = {
	deDE = "German", esES = "Spanish (Spain)", esMX = "Spanish (Latin America)", frFR = "French", koKR = "Korean",
	ptBR = "Portuguese (Brazil)", ruRU = "Russian", zhCN = "Simplified Chinese", zhTW = "Traditional Chinese",
}
local FOLLOW, ENGLISH = "game", "enUS"
Language.CHOICES = { FOLLOW, ENGLISH, "deDE", "esES", "esMX", "frFR", "koKR", "ptBR", "ruRU", "zhCN", "zhTW" }

local function loadFolder(pack)
	local load = C_AddOns and C_AddOns.LoadAddOn
	if not (pack and load) then return end
	local ok, loaded, reason = pcall(load, pack)
	if not (ok and Readable(loaded)) then
		ns.Log("Locale: " .. pack .. " not loaded: " .. tostring(ok and Readable(reason) or loaded))
	end
end

loadFolder(Names.PackName())

function Language.Get()
	local v = PolestarLanguage
	if v == ENGLISH or LANGUAGE[v] then return v end
	return FOLLOW
end

function Language.Set(name)
	if name ~= FOLLOW and name ~= ENGLISH and not LANGUAGE[name] then return false end
	PolestarLanguage = name ~= FOLLOW and name or nil
	return true
end

local function english(loc) return loc == "enUS" or loc == "enGB" end

ns.OnInit(function()
	local want = Language.Get()
	if want == FOLLOW then return end
	local shown = Names.Language()
	if want == shown or (english(want) and english(shown)) then return end
	for k in pairs(L) do L[k] = nil end
	Names.SetLanguage(want)
	ns.GuideTexts.SetLanguage(want)
	loadFolder(Names.PackName())
	ns.Fire("NAMES_LOADED")
end)

ns.OnLogin(function()
	if Language.Get() ~= FOLLOW then return end
	local pack = Names.PackName()
	local language = pack and LANGUAGE[Names.Language()]
	if not language then return end
	local isLoaded = C_AddOns and C_AddOns.IsAddOnLoaded
	if not isLoaded then return end
	local ok, loaded = pcall(isLoaded, pack)
	if ok and Readable(loaded) then return end
	if ns.Data.Installed(pack) then return end
	ns.Print(("the %s language files (%s) are missing, so Polestar shows in English."):format(language, pack))
end)

-- What a player types: a choice's code in any case, "english", "follow".
local TYPED = { english = ENGLISH, follow = FOLLOW }
for _, c in ipairs(Language.CHOICES) do TYPED[c:lower()] = c end

ns.RegisterCommand("language", function(rest)
	local typed = rest and rest:match("^%s*(.-)%s*$") or ""
	local choices = table.concat(Language.CHOICES, ", ")
	if typed == "" then
		ns.Print((L["Language: %s. Change it with /polestar language <name>, one of: %s."]):format(Language.Get(), choices))
		return
	end
	local name = TYPED[typed:lower()]
	if not (name and Language.Set(name)) then
		ns.Print((L["No language '%s'. Choose one of: %s."]):format(typed, choices))
		return
	end
	ns.Print((L["Language: %s, from the next /reload."]):format(name))
end, L["Choose Polestar's language (game, enUS, deDE...), from the next /reload"], true)
