-- The class macros setting on the Discovery options page's Lookup tab, beside
-- the Characters page's (docs/ARCHITECTURE.md, "Options registry").
-- macros.enabled switches the module off: the Macros section says so and
-- writes nothing; the macros it made stay on the game's list.
-- Part of the settings' addon: nothing of it is in memory before the settings open.

local ns = Polestar
local L = ns.L

if not (ns.Macros and ns.RegisterOptions) then return end

local ok, err = ns.RegisterOptions({
	page = L["Discovery"], tab = L["Lookup"], section = L["Dungeons and characters"],
	controls = {
		{ kind = "toggle", key = "macros.enabled", label = L["Class macros"], search = "macros, class macros, macro, keybinds, mouseover",
			help = L["Ready-made macros for your class, put on your macro list in one click (/pole macros)."] },
	},
})
if not ok and geterrorhandler then geterrorhandler()(err) end
