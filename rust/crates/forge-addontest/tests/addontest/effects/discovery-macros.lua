-- env: world stub_macros.lua
-- The Discovery page's Lookup tab, class macros (Macros/Options.lua, Macros.lua): a level 30 warrior out of
-- combat with free macro slots; whether the first macro of the class could be written to the character's list.
return {
	probes = {
		["macros.enabled"] = function()
			local M = Polestar.Macros
			local ok, why = M.CanWrite(M.Data().macros[1], true, false)
			return ok and "writes" or why
		end,
	},
}
