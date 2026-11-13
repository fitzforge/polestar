-- env: world
-- The Guide page's Professions tab (Core/Materials.lua, Engine.MaterialRows; UI/Materials.lua's window), as
-- ui-materials.rs plays it: a level 10 Human with Tailoring 1 on a Tailoring guide that buys Linen Cloth or gathers
-- it from mobs of level 5-15; another character of the realm and side holds 30 of it.
local E
-- The cloth as the Materials window lists it: its way, and how many are still to get.
local function linen()
	for _, sec in ipairs(E.MaterialRows("rest")) do
		for _, r in ipairs(sec.items) do
			if r.item == 2589 then return { r.way, r.toGet } end
		end
	end
	return false
end
return {
	setup = function()
		local w = stub.world
		E = Polestar.Engine
		w.setLevel(10)
		w.learnSkill(197, "Tailoring", 1, 75)
		local db = PolestarDB
		db.alts = db.alts or {}
		db.alts.chars = db.alts.chars or {}
		db.alts.chars["Kaelia-Test Realm"] = { key = "Kaelia-Test Realm", name = "Kaelia", realm = "Test Realm", faction = "Alliance", level = 30, seen = 1, mats = { [2589] = 30 } }
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/tailoring", pack = "test", title = "Tailoring 1-75", category = "Professions", minLevel = 1, maxLevel = 60,
			sections = { { skill = "Tailoring", skillLine = 197, from = 1, to = 75 } },
			steps = {
				{ title = "Auction House", section = 1, goals = { { t = "auction", item = 2589, itemName = "Linen Cloth", count = 40 } } },
				{ title = "Linen Cloth", section = 1, goals = { { t = "collect", item = 2589, itemName = "Linen Cloth", count = 40, gather = { min = 5, max = 15 } } } },
			} })
		E.SetGuide("test/tailoring")
		stub.advance(0.5)
	end,
	settle = 0.3,
	probes = {
		-- A guide never answered: Ask (Mix meanwhile) gathers the cloth at level 10; Buy buys it.
		["professions.materials"] = { probe = function() return linen()[1] end, value = "buy" },
		-- The other character's 30 count toward the 40.
		["professions.altMaterials"] = function() return linen()[2] end,
	},
}
