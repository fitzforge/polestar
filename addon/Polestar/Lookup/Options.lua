-- Lookup settings, on the Discovery options page's Lookup tab
-- (docs/ARCHITECTURE.md, "Options registry"; the rows are the settings'
-- addon's, Polestar_Options/Lookup/Options.lua). lookup.enabled switches the
-- whole module off: search entities, tooltip lines, Alt-click guides, the
-- mount spotter and commands.

local ADDON, ns = ...

ns.RegisterDefaults("lookup", {
	enabled = true,
	tooltip = true,
	altClick = true,
	mounts = true,
})
