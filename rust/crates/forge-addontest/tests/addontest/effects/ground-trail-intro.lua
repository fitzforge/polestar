-- env: trailui
-- The Ground trail page's Introduction button (Polestar_Options/Nav/WorldTrailOptions.lua): the trail's
-- introduction window, opened again (UI/WorldTrailIntro.lua).
return {
	probes = {
		["Ground trail:Introduction"] = { press = true, probe = function() return PolestarTrailIntro ~= nil and PolestarTrailIntro:IsShown() end,
			cleanup = function() Polestar.UI.WorldTrailIntro.Hide() end },
	},
}
