-- Polestar Group Finder: search languages.
--
-- Each player's searches carry their game's language, one letter
-- (GetLocale; the door's GroupFinder.LANGUAGES). Who appears in the list:
-- players of the languages ticked on the Group Finder page
-- (groupFinder.langs.<letter>, your own by default), or everyone with "All
-- languages" (groupFinder.acceptAll). Filtering is your side's alone; the
-- page offers only the languages played in the game's region.

local _, ns = ...
local L = ns.L
local GF = ns.P.GroupFinder

local Lang = {}
ns.Lang = Lang

local byCode = {}
for _, row in ipairs(GF.LANGUAGES) do byCode[row.code] = row end

function Lang.DefaultCode() return GF.OwnLanguage() end
function Lang.Tag(code) return byCode[code] and byCode[code].tag or tostring(code):upper() end
function Lang.Name(code) return byCode[code] and byCode[code].name or Lang.Tag(code) end
function Lang.AcceptsAll() return ns.Get("acceptAll") and true or false end

-- The letters searched: those ticked (your own by default), in the page's order.
function Lang.Search()
	local out = {}
	for _, row in ipairs(GF.LANGUAGES) do
		if ns.Get("langs." .. row.code) then out[#out + 1] = row.code end
	end
	return out
end

-- What a search carries: your game's language.
function Lang.Encode()
	return Lang.DefaultCode()
end

-- `their` is { code = "f" }, or nil for an unknown or missing letter.
function Lang.Decode(text)
	if type(text) ~= "string" or not byCode[text] then return nil end
	return { code = text }
end

-- Keep a player if every language is searched, or theirs is.
function Lang.Compatible(their)
	if Lang.AcceptsAll() then return true end
	if not (their and their.code) then return false end
	for _, c in ipairs(Lang.Search()) do
		if c == their.code then return true end
	end
	return false
end

-- A player's language as a short label ("FR"), "?" when unknown.
function Lang.Summary(their)
	if not (their and their.code) then return "?" end
	return Lang.Tag(their.code)
end
