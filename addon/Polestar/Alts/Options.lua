-- The Characters setting on the Discovery options page's Characters tab
-- (docs/ARCHITECTURE.md, "Options registry"). alts.enabled switches the
-- module off: nothing is saved about the characters you play, and the
-- Characters page says so. Characters saved earlier are still listed until you forget them.

local ADDON, ns = ...
local L = ns.L

if not (ns.Alts and ns.RegisterOptions) then return end

local ok, err = ns.RegisterOptions({
	page = L["Discovery"], tab = L["Characters"], section = L["Characters"],
	controls = {
		{ kind = "toggle", key = "alts.enabled", label = L["Characters"],
			help = L["Keep a note of each character you play, for the Characters page (/pole alts)."] },
	},
})
if not ok and geterrorhandler then geterrorhandler()(err) end
