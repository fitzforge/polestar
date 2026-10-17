-- A compiled guide pack's Guides.lua, as `compile` writes it (test fixture).

-- Source: test/names.guide
do
	local function register()
		Polestar.RegisterGuide({
			id = "test/names",
			pack = "test",
			title = "Names",
			reward = { { item = 2862, itemName = "Rough Sharpening Stone" } },
			names = { ["npc:299"] = "Young Wolf", ["zone:1429"] = "Elwynn Forest" },
			steps = {
				{
					title = "Goldshire",
					goals = {
						{ t = "accept", quest = 176, title = "Wanted: \"Hogger\"", npc = 240, npcName = "Marshal Dughan", pre = { 33 }, preTitles = { [33] = "Wolves Across the Border" } },
						{ t = "kill", quest = 7, title = "Kobold Camp Cleanup", target = "Kobold Vermin", npc = 6, count = 10, oi = 1 },
						{ t = "collect", quest = 7, item = 1528, itemName = "Handful of Oats", from = "Battered Chest", fromKind = "object" },
						{ t = "interact", object = 68, objName = "Wanted Poster", closedBy = 34 },
						{ t = "collect", item = 750, itemName = "Tough Wolf Meat", count = 5, candidates = { { npc = 197, npcName = "Marshal McBride", map = 1429, x = 1, y = 2 } } },
					},
				},
			},
		})
	end
	register()
end
