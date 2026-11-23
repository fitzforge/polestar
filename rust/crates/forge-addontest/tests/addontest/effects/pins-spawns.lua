-- env: world
-- codex: spawn-markers.json
-- The Map pins page's Spawn markers (Polestar_Options/Nav/PinsOptions.lua; Maps/MobMarkers.lua) on the whole addon
-- with tests/fixtures/codex/spawn-markers.json, as mob-markers.rs plays it: quests 100 (Wolves and Bears, both on
-- 1429) and 200 (a Spider on 1430, north of it) in the log, the player on a Wolf's spawn, the world map open; read
-- as drawn: the markers on each map, the legend, a marker's colours.
local w, M
local function state(key, map)
	stub.worldMapID = map or 1429
	stub.advance(0.6)
	return M.State()[key]
end
-- The first shown world map marker's texture colour (its skull, or its mob ring) on map.
local function colour(map, part)
	state("drawn", map)
	for _, f in ipairs({ Polestar.MapCanvas.Get(WorldMapFrame).frame:GetChildren() }) do
		local t = f.skull and f:IsShown() and f[part]
		if t and t:IsShown() then return { t:GetVertexColor() } end
	end
	return false
end
local stepIndex, stepView
return {
	setup = function()
		w, M = stub.world, Polestar.MobMarkers
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.addMap(1430, { name = "Westfall", c = 0, left = 1500, right = -1500, top = 2500, bottom = 500 })
		w.moveTo(1429, 10, 10)
		w.accept(100, { { text = "Bear Pelt", type = "item", required = 5 }, { text = "Wolf slain", required = 8 } })
		w.accept(200, { { text = "Spider slain", required = 1 } })
		Polestar.Codex.Load()
		stub.worldMapID = 1429
		WorldMapFrame:GetCanvas():SetSize(1000, 700)
		WorldMapFrame:Show()
		stub.advance(0.6)
	end,
	settle = 0.6,
	probes = {
		["mobMarkers.enabled"] = function() return state("drawn") end,
		["mobMarkers.showMinimap"] = function() return state("minimap") end,
		["mobMarkers.showLegend"] = function()
			state("drawn")
			return PolestarMobMarkersLegend ~= nil and PolestarMobMarkersLegend:IsShown()
		end,
		-- A guide step on the Spider's quest alone: on, 1429 shows nothing of it.
		["mobMarkers.stepOnly"] = {
			prepare = function()
				local E = Polestar.Engine
				stepIndex, stepView = E.GetStepIndex, E.GetStepView
				E.GetStepIndex = function() return 1 end
				E.GetStepView = function() return { goals = { { quest = 200, t = "kill" } } } end
				Polestar.Fire("STEP_CHANGED")
			end,
			probe = function() return state("drawn") end,
			cleanup = function()
				local E = Polestar.Engine
				E.GetStepIndex, E.GetStepView = stepIndex, stepView
				Polestar.Fire("STEP_CHANGED")
			end,
		},
		-- The second quest's skull (the Spider's, on 1430) takes the quest palette's first colour.
		["mobMarkers.questPalette"] = function() return colour(1430, "skull") end,
		-- Wolves and Bears tells its two mobs apart by their rings.
		["mobMarkers.mobPalette"] = function() return colour(1429, "ring") end,
	},
}
