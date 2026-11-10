-- !PolestarLocaleTest: a developer's addon, never shipped. On an English
-- client it makes Polestar load as on a client in another language, through
-- the same path a real one takes: Core/Names.lua reads GetLocale() at load,
-- so Core/Locale.lua asks for Polestar_<locale> with C_AddOns.LoadAddOn while
-- Polestar's own files are still loading (#1295), and the folder's files
-- check GetLocale() themselves.
--
-- GetLocale() answers LOCALE only to Polestar's files (Interface/AddOns/
-- Polestar/...) and the language folders (Polestar_xxXX/...); everything
-- else, the Recorder, Blizzard's UI and other addons, gets the client's own.
-- The "!" makes the client load it before Polestar.
--
-- Try it: copy this folder into Interface/AddOns, keep Polestar_deDE
-- installed and enabled, start the game (or /reload) and check:
--   /dump Polestar.Names.PackName()      -> "Polestar_deDE" (the test is on)
--   /dump BINDING_NAME_POLESTAR_NEXT     -> "Nächster Schritt": the early
--      load worked. "Next step" while guide texts are German: the client
--      refused the load during Polestar's own (key bindings and the options'
--      labels stay English); Polestar's debug log has "Locale: Polestar_deDE
--      not loaded: <reason>".
-- Then delete the folder and /reload: it replaces the global GetLocale, which
-- taints it for the session.

local LOCALE = "deDE"

local real = GetLocale
local function polestars(where)
	return where:find("[/\\]Polestar[/\\]") ~= nil or where:find("[/\\]Polestar_%a%a%u%u[/\\]") ~= nil
end

function GetLocale()
	local where = debugstack and debugstack(2, 1, 0) or ""
	if polestars(where) then return LOCALE end
	return real()
end
