-- env: world stub_quests.lua
-- questdb: fixture
-- The Map page's quest markers (Quests/Options.lua, Tracker.lua) on the fixture quest database, as quests.rs reads
-- them through the Pins contract (stub_quests.lua's recording Pins): a level 10 character in Elwynn with A Threat
-- Within done, Kobold Camp Cleanup in the log and Wolves Across the Border ready to hand in, on a guide whose step
-- kills for Kobold Camp Cleanup.
local w, sq
local function layer(name) local l = sq.pins.layers[name]; return l and l.pins or {} end
-- How many available-quest markers offer quest q.
local function offers(q)
	local n = 0
	for _, p in ipairs(layer("quests.available")) do for _, r in ipairs(p.refs or {}) do if r == q then n = n + 1 end end end
	return n
end
local function first(name) return layer(name)[1] or {} end
local OBJECTIVES = { ["qol.mapObjectives"] = true }
local AREAS = { ["qol.mapObjectives"] = true, ["qol.objectiveSpots"] = "areas" }
local AVAILABLE = { ["qol.availableQuests"] = true }
return {
	setup = function()
		w, sq = stub.world, stub.quests
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 48, 40)
		for q, t in pairs({ [7] = "Kobold Camp Cleanup", [18] = "Gathering Wood", [33] = "Wolves Across the Border", [60] = "Kobold Candles" }) do w.titles[q] = t end
		w.setLevel(10)
		w.complete({ 783 })
		sq.installPins()
		w.accept(7, { { text = "Kobold Vermin slain: 0/10", type = "monster", required = 10 } })
		w.accept(33, { { text = "Tough Wolf Meat: 0/8", type = "item", required = 8 } })
		w.progress(33, 1, 8)
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/markers", pack = "test", title = "Markers", minLevel = 1, maxLevel = 20, steps = {
			{ goals = { { t = "kill", quest = 7, target = "Kobold Vermin", count = 10 } } },
		} })
		Polestar.Engine.SetGuide("test/markers")
		stub.advance(0.5)
	end,
	settle = 0.3,
	probes = {
		["qol.availableQuests"] = function() return #layer("quests.available") end,
		-- Veteran Work (level 12) for a level 10: within five levels, not within one.
		["qol.questLevelWindow"] = { with = AVAILABLE, value = 1, probe = function() return offers(10) end },
		-- Gathering Wood (level 3): grey for a level 10.
		["qol.lowLevelQuests"] = { with = AVAILABLE, probe = function() return offers(18) end },
		["qol.mapObjectives"] = function() return #layer("quests.objectives") end,
		["qol.minimapObjectives"] = { with = OBJECTIVES, probe = function() local l = sq.pins.layers["quests.objectives"]; return l and l.opts.minimap or false end },
		-- The Kobold Vermin's spots: markers, or their areas alone.
		["qol.objectiveSpots"] = { with = OBJECTIVES, value = "areas", probe = function()
			local areas, marks = 0, 0
			for _, p in ipairs(layer("quests.objectives")) do if p.areaOnly or p.hull then areas = areas + 1 else marks = marks + 1 end end
			return { areas = areas, markers = marks }
		end },
		["qol.objectiveAreaAlpha"] = { with = AREAS, probe = function()
			for _, p in ipairs(layer("quests.objectives")) do if p.areaOnly or p.hull then return p.color and p.color[4] or false end end
			return false
		end },
		["qol.turnInMarkers"] = function() return #layer("quests.turnin") end,
		["qol.questMarkerSize"] = { with = OBJECTIVES, probe = function() return first("quests.objectives").size or false end },
		-- The step's quest: its markers circled and larger, or plain.
		["qol.guideHighlight"] = { with = OBJECTIVES, probe = function() local p = first("quests.objectives"); return { p.focus or "none", p.size or false } end },
		-- The turn-in marker (not the step's): faded, or full.
		["qol.guideDim"] = { with = { ["qol.turnInMarkers"] = true }, probe = function() local p = first("quests.turnin"); return { p.focus or "none", p.color and p.color[4] or false } end },
	},
}
