-- The interface strings in the client's language: Interface.lua in the
-- language folder Polestar_<locale> (load on demand), which fills L. Loaded
-- here, before the first file that reads L at load, and after Names.lua and
-- GuideTexts.lua, which the folder's Names.lua and Texts.lua fill as it
-- loads. Contract: docs/ARCHITECTURE.md, "Localisation".
--
-- An English client loads nothing. A folder that is missing or disabled
-- leaves the interface in English (a missing key renders as itself). Names
-- and GuideTexts ask for the folder again later through Data.Pack: if that
-- load succeeds where this one failed, L fills then, and only what was read
-- at load (key binding names, the options' labels) stays English. Not
-- through Data.Pack here: it refuses in combat, which would leave a /reload
-- in combat in English for the session, and keeps a failure for the session.

local _, ns = ...

local pack = ns.Names.PackName()
local load = C_AddOns and C_AddOns.LoadAddOn
if pack and load then
	local ok, loaded, reason = pcall(load, pack)
	if not (ok and ns.Compat.Readable(loaded)) then
		ns.Log("Locale: " .. pack .. " not loaded: " .. tostring(ok and ns.Compat.Readable(reason) or loaded))
	end
end
