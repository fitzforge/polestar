-- Korean (koKR): the guide forever/professions/cooking (forever/professions/cooking.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Cooking
	-- {skill:185} Cooking
	["Learn {skill:185}"] = "{skill:185} 배우기",
	-- {skill:185} Cooking · {object:29784} Basic Campfire · {item:279981} Basic Campfire Kit · {item:4470} Simple Wood · {item:4471} Flint and Tinder
	["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5, 1s); the arrow picks the nearest. Forever: every cook knows {object:29784}. Craft a {item:279981} from one {item:4470} (38c) with {item:4471} (1s 35c, kept in your bags), then place the kit to light a cooking fire anywhere; make a few in advance (one use every 5 minutes). The first kits also raise {skill:185} to about 5. The Camping 101: {skill:185} quest at your starting area's camp sends you to this trainer."] = "",

	-- Step 2: Charred Wolf Meat: ingredients
	-- {spell:2538} Charred Wolf Meat
	["{spell:2538}: ingredients"] = "{spell:2538}: 재료",
	-- {zone:1429} Elwynn Forest
	["Prowler (86%) in {zone:1429}, or wherever the arrow points"] = "{zone:1429}의 굶주린 늑대 (86%), 또는 화살표가 가리키는 곳",

	-- Step 3: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "",

	-- Step 4: Roasted Boar Meat: ingredients
	-- {spell:2540} Roasted Boar Meat
	["{spell:2540}: ingredients"] = "{spell:2540}: 재료",
	-- {npc:1126} Large Crag Boar · {npc:1125} Crag Boar · {zone:1426} Dun Morogh
	["{npc:1126} (36%), {npc:1125} (34%) in {zone:1426}, or wherever the arrow points"] = "",

	-- Step 5: Roasted Boar Meat (1-50)
	-- {spell:2540} Roasted Boar Meat · {object:29784} Basic Campfire
	["{spell:2540} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "",

	-- Step 6: Herb Baked Egg: shopping
	-- {item:6888} Herb Baked Egg
	["{item:6888}: shopping"] = "",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 50 {item:2678} (1s)."] = "",

	-- Step 7: Herb Baked Egg: ingredients
	-- {item:6888} Herb Baked Egg
	["{item:6888}: ingredients"] = "",
	-- {npc:1995} Strigid Owl · {zone:1438} Teldrassil
	["{npc:1995} (58%) in {zone:1438}, or wherever the arrow points"] = "",

	-- Step 8: Herb Baked Egg (1-50)
	-- {item:6888} Herb Baked Egg · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2678} Mild Spices · {zone:1438} Teldrassil · {item:6889} Small Egg · {zone:1439} Darkshore · {item:6290} Brilliant Smallfish · {npc:6286} Zarrin · {area:186} Dolanaar · {item:5472} Kaldorei Spider Kabob
	-- plural, as words: Small Spider Legs = {item:5465} Small Spider Leg
	["{item:6888} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. {item:6888} comes with {skill:185} (the client teaches it with the skill); {item:2678} are a cooking vendor's. The Strigid owls of {zone:1438} drop a {item:6889} more often than not, and {zone:1439}'s moonkin drop them too. Fishers can cook {item:6290} (recipe 40c) from Rut'theran's waters instead, and {npc:6286} in {area:186} gives Recipe of the Kaldorei (seven Small Spider Legs from the Webwood spiders) for {item:5472}, orange from 10 to 50."] = "",

	-- Step 9: Charred Wolf Meat: ingredients
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} in Zephras Isle, or wherever the arrow points"] = "",

	-- Step 10: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire · {item:2672} Stringy Wolf Meat
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. The Vuldren of Zephras Isle drop {item:2672}."] = "",

	-- Step 11: Roasted Boar Meat: ingredients
	-- {npc:3099} Dire Mottled Boar · {zone:1411} Durotar
	["{npc:3099} (99%) in {zone:1411}, or wherever the arrow points"] = "",

	-- Step 13: Charred Wolf Meat: ingredients
	-- {npc:2960} Prairie Wolf Alpha · {npc:2959} Prairie Stalker · {zone:1412} Mulgore
	["{npc:2960} (82%), {npc:2959} (77%) in {zone:1412}, or wherever the arrow points"] = "{zone:1412}의 {npc:2960} (82%), {npc:2959} (77%), 또는 화살표가 가리키는 곳",

	-- Step 15: Charred Wolf Meat: ingredients
	-- {npc:1547} Decrepit Darkhound · {npc:1548} Cursed Darkhound · {zone:1420} Tirisfal Glades
	["{npc:1547} (72%), {npc:1548} (33%) in {zone:1420}, or wherever the arrow points"] = "",

	-- Step 17: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "수습 {skill:185}",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction; training costs 5s."] = "",

	-- Step 18: Coyote Steak: ingredients
	-- {spell:2541} Coyote Steak
	["{spell:2541}: ingredients"] = "",
	-- {npc:834} Coyote · {npc:833} Coyote Packleader · {zone:1436} Westfall
	["{npc:834} (54%), {npc:833} (51%) in {zone:1436}, or wherever the arrow points"] = "",

	-- Step 19: Coyote Steak (50-90)
	-- {spell:2541} Coyote Steak · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {npc:235} Salma Saldean · {area:108} Sentinel Hill · {item:733} Westfall Stew · {item:724} Goretusk Liver Pie
	-- plural, as words: Coyotes = {npc:834} Coyote
	["{spell:2541} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. Coyotes roam the middle of {zone:1436}; {npc:235} on the farm north of {area:108} also gives {item:733} and {item:724} quests that use what you loot here."] = "",

	-- Step 20: Crab Cake: shopping
	-- {spell:2544} Crab Cake
	["{spell:2544}: shopping"] = "",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 44 {item:2678} (90c)."] = "",

	-- Step 21: Crab Cake: ingredients
	-- {spell:2544} Crab Cake
	["{spell:2544}: ingredients"] = "",
	-- {npc:830} Sand Crawler · {zone:1436} Westfall
	["{npc:830} (43%) in {zone:1436}, or wherever the arrow points"] = "",

	-- Step 22: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1436} coast. Cook it to 130, where {spell:3376} takes over."] = "",

	-- Step 23: Smoked Bear Meat: shopping
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: shopping"] = "",
	["The arrow picks the nearest vendor of your faction for each item."] = "화살표가 아이템마다 진영의 가장 가까운 상인을 가리킵니다.",

	-- Step 24: Smoked Bear Meat: ingredients
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: ingredients"] = "",
	-- {npc:1189} Black Bear Patriarch · {zone:1432} Loch Modan
	["{npc:1189} (39%) in {zone:1432}, or wherever the arrow points"] = "",

	-- Step 25: Smoked Bear Meat (50-80)
	-- {item:6890} Smoked Bear Meat · {object:29784} Basic Campfire · {item:6892} Recipe: Smoked Bear Meat · {zone:1432} Loch Modan
	["{item:6890} is orange from 50 (yellow at 80, green at 100, grey at 120): about 30 crafts to 80. Cook at any fire: a town hearth or your own {object:29784}. {item:6892} costs 2s 50c at its vendor; the arrow picks the nearest one of your faction. Black bears roam the hills of {zone:1432}."] = "",

	-- Step 26: Dry Pork Ribs: shopping
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: shopping"] = "",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2678} (1s 10c)."] = "",

	-- Step 27: Dry Pork Ribs: ingredients
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: ingredients"] = "",
	-- {npc:1191} Mangy Mountain Boar · {zone:1432} Loch Modan
	["{npc:1191} (31%) in {zone:1432}, or wherever the arrow points"] = "",

	-- Step 28: Dry Pork Ribs (80-130)
	-- {spell:2546} Dry Pork Ribs · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1432} Loch Modan · {spell:3376} Curiously Tasty Omelet
	["{spell:2546} is orange from 80 (yellow at 120, green at 140, grey at 160): about 52 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 80 for 1s 50c. Mountain boars roam all of {zone:1432}. Cook it to 130, where {spell:3376} takes over."] = "",

	-- Step 29: Boiled Clams: shopping
	-- {item:5525} Boiled Clams
	["{item:5525}: shopping"] = "",
	-- {item:159} Refreshing Spring Water
	["The arrow picks the nearest vendor of your faction for each item. You need 40 {item:159} (2s)."] = "",

	-- Step 30: Boiled Clams: ingredients
	-- {item:5525} Boiled Clams
	["{item:5525}: ingredients"] = "",
	-- {npc:3812} Clattering Crawler · {npc:3814} Spined Crawler · {npc:3944} Wrathtail Priestess · {zone:1439} Darkshore · {item:5523} Small Barnacled Clam · {item:5503} Clam Meat
	["{npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) in {zone:1439}, or wherever the arrow points; open each {item:5523} for its {item:5503}"] = "",

	-- Step 31: Boiled Clams (50-90)
	-- {item:5525} Boiled Clams · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2674} Crawler Meat · {spell:2544} Crab Cake
	["{item:5525} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. The same coastal crawlers drop {item:2674} for {spell:2544} next: keep it."] = "",

	-- Step 33: Crab Cake: ingredients
	-- {npc:3814} Spined Crawler · {npc:3812} Clattering Crawler · {zone:1439} Darkshore
	["{npc:3814} (42%), {npc:3812} (40%) in {zone:1439}, or wherever the arrow points"] = "",

	-- Step 34: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1439} Darkshore · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1439} coast. Cook it to 130, where {spell:3376} takes over."] = "",

	-- Step 35: Strider Stew: shopping
	-- {item:5477} Strider Stew
	["{item:5477}: shopping"] = "{item:5477}: 구매",
	-- {item:4536} Shiny Red Apple
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:4536} (2s 75c)."] = "",

	-- Step 36: Strider Stew: ingredients
	-- {item:5477} Strider Stew
	["{item:5477}: ingredients"] = "{item:5477}: 재료",
	-- {npc:3246} Fleeting Plainstrider · {zone:1413} The Barrens
	["{npc:3246} (32%) in {zone:1413}, or wherever the arrow points"] = "",

	-- Step 37: Strider Stew (50-100)
	-- {item:5477} Strider Stew · {object:29784} Basic Campfire · {item:5486} Recipe: Strider Stew
	["{item:5477} is orange from 50 (yellow at 90, green at 110, grey at 130): about 52 crafts to 100. Cook at any fire: a town hearth or your own {object:29784}. {item:5486} costs 4s 40c at its vendor; the arrow picks the nearest one of your faction."] = "",

	-- Step 38: Crispy Lizard Tail: shopping
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: shopping"] = "{item:5479}: 구매",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 30 {item:2692} (12s)."] = "",

	-- Step 39: Crispy Lizard Tail: ingredients
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: ingredients"] = "{item:5479}: 재료",
	-- {npc:3239} Thunderhead · {zone:1413} The Barrens
	["{npc:3239} (59%), Owatanka (35%) in {zone:1413}, or wherever the arrow points"] = "{zone:1413}의 {npc:3239} (59%), 오와탄카 (35%), 또는 화살표가 가리키는 곳",

	-- Step 40: Crispy Lizard Tail (100-130)
	-- {item:5479} Crispy Lizard Tail · {object:29784} Basic Campfire · {item:5488} Recipe: Crispy Lizard Tail · {npc:3489} Zargh · {item:3735} Recipe: Hot Lion Chops
	["{item:5479} is orange from 100 (yellow at 140, green at 160, grey at 180): about 30 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. {item:5488} costs 4s at its vendor; the arrow picks the nearest one of your faction. {npc:3489}, the butcher beside this vendor at the Crossroads, sells {item:3735} (18s), the recipe after Expert: buy it now."] = "",

	-- Step 41: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "숙련 {skill:185}",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook
	["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072} (1g); the arrow picks its nearest seller for your faction. Buy it and read it."] = "",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "{item:16072} 사서 읽기 (숙련 {skill:185})",

	-- Step 42: Curiously Tasty Omelet: shopping
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: shopping"] = "{spell:3376}: 구매",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 46 {item:2692} (18s 40c)."] = "",

	-- Step 43: Curiously Tasty Omelet: ingredients
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: ingredients"] = "{spell:3376}: 재료",
	-- {npc:1018} Highland Razormaw · {npc:1019} Elder Razormaw · {zone:1437} Wetlands
	["{npc:1018} (72%), {npc:1019} (67%) in {zone:1437}, or wherever the arrow points"] = "{zone:1437}의 {npc:1018} (72%), {npc:1019} (67%), 또는 화살표가 가리키는 곳",

	-- Step 44: Curiously Tasty Omelet (130-175)
	-- {spell:3376} Curiously Tasty Omelet · {object:29784} Basic Campfire · {item:3682} Recipe: Curiously Tasty Omelet · {zone:1437} Wetlands · {item:3685} Raptor Egg · {npc:340} Kendor Kabonka · {zone:1453} Stormwind
	["{spell:3376} is orange from 130 (yellow at 170, green at 190, grey at 210): about 46 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3682} costs 16s at its vendor; the arrow picks the nearest one of your faction. The raptors of the {zone:1437} drop a {item:3685} about two kills in three. {npc:340} in {zone:1453} sells the recipe."] = "",

	-- Step 45: Hot Lion Chops: shopping
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: shopping"] = "{spell:3398}: 구매",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 45 {item:2692} (18s)."] = "",

	-- Step 46: Hot Lion Chops: ingredients
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: ingredients"] = "{spell:3398}: 재료",
	-- {npc:2384} Starving Mountain Lion · {zone:1424} Hillsbrad Foothills
	["{npc:2384} (42%) in {zone:1424}, or wherever the arrow points"] = "",

	-- Step 47: Hot Lion Chops (130-175)
	-- {spell:3398} Hot Lion Chops · {object:29784} Basic Campfire · {item:3735} Recipe: Hot Lion Chops · {item:3731} Lion Meat
	-- plural, as words: Hulking Mountain Lions = {npc:2407} Hulking Mountain Lion
	["{spell:3398} is orange from 130 (yellow at 175, green at 195, grey at 215): about 45 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3735} costs 18s at its vendor; the arrow picks the nearest one of your faction. The Feral and Hulking Mountain Lions of Hillsbrad Foothills drop {item:3731} more often than the Starving ones."] = "",

	-- Step 48: Roast Raptor: shopping
	-- {item:12210} Roast Raptor
	["{item:12210}: shopping"] = "{item:12210}: 구매",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2692} (20s 80c)."] = "",

	-- Step 49: Roast Raptor: ingredients
	-- {item:12210} Roast Raptor
	["{item:12210}: ingredients"] = "{item:12210}: 재료",
	-- {npc:2560} Highland Thrasher · {zone:1417} Arathi Highlands
	["{npc:2560} (38%) in {zone:1417}, or wherever the arrow points"] = "",

	-- Step 50: Roast Raptor (175-225)
	-- {item:12210} Roast Raptor · {object:29784} Basic Campfire · {item:12228} Recipe: Roast Raptor · {zone:1417} Arathi Highlands · {npc:2810} Hammon Karwn · {area:320} Refuge Pointe · {npc:2821} Keena · {area:321} Hammerfall · {item:2692} Hot Spices · {item:17222} Spider Sausage · {item:12205} White Spider Meat
	["{item:12210} is orange from 175 (yellow at 215, green at 235, grey at 255): about 52 crafts to 225. Cook at any fire: a town hearth or your own {object:29784}. {item:12228} costs 50s at its vendor; the arrow picks the nearest one of your faction. {zone:1417}: {npc:2810} at {area:320} (Alliance) and {npc:2821} at {area:321} (Horde) sell the recipe and {item:2692} beside the raptors. {item:17222} (any trainer from 200, 40s) is the alternative, but it takes two {item:12205} a craft and Dustwallow's spiders drop one about two kills in five."] = "",

	-- Step 51: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "전문 {skill:185}은(는) {area:976}({zone:1446})의 {npc:8125}에게 배웁니다. {zone:1455}의 요리 상급자가 보내 줍니다. 숙련도 225, 레벨 35가 필요합니다.",

	-- Step 52: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "전문 {skill:185}은(는) {area:976}({zone:1446})의 {npc:8125}에게 배웁니다. {zone:1454}의 요리 상급자가 보내 줍니다. 숙련도 225, 레벨 35가 필요합니다.",

	-- Step 53: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "거대한 알",
	-- {quest:6610} Clamlette Surprise · {item:7974} Zesty Clam Meat · {item:8932} Alterac Swiss · {zone:1446} Tanaris · {zone:1425} The Hinterlands · {npc:2929} Savage Owlbeast · {item:12218} Monster Omelet
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["{quest:6610} asks for 12 Giant Eggs, 10 {item:7974} and 20 {item:8932}: bring all three before you go to {zone:1446}, so you make the trip once. Giant Eggs drop from the owlbeasts of {zone:1425}: {npc:2929} (54%). {item:12218} takes about 120 more after Artisan: farm them now too if you like."] = "",

	-- Step 54: Alterac Swiss
	-- {item:8932} Alterac Swiss
	["Innkeepers and food vendors sell {item:8932}; the arrow picks the nearest."] = "",

	-- Step 55: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {zone:1445} Dustwallow Marsh · {zone:1446} Tanaris
	-- plural, as words: Big-mouth Clams = {item:7973} Big-mouth Clam · Steeljaw Snappers = {npc:14123} Steeljaw Snapper
	["{item:7974} comes from Big-mouth Clams: open each one, every clam holds one. The Muckshell crabs on the {zone:1445} coast south-west of Theramore drop a clam about seven kills in ten, so ten clams take about fifteen kills, on your way to {zone:1446}. The Steeljaw Snappers on {zone:1446}'s east coast drop them about one kill in three."] = "",

	-- Step 56: Clamlette Surprise
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "전문 {skill:185}",

	-- Step 57: Monster Omelet: shopping
	-- {item:12218} Monster Omelet
	["{item:12218}: shopping"] = "{item:12218}: 구매",
	-- {item:3713} Soothing Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 240 {item:3713} (3g 84s)."] = "",

	-- Step 58: Monster Omelet: ingredients
	-- {item:12218} Monster Omelet
	["{item:12218}: ingredients"] = "{item:12218}: 재료",
	-- {npc:2929} Savage Owlbeast · {zone:1425} The Hinterlands
	["{npc:2929} (54%) in {zone:1425}, or wherever the arrow points"] = "",

	-- Step 59: Monster Omelet (225-300)
	-- {item:12218} Monster Omelet · {object:29784} Basic Campfire · {item:16110} Recipe: Monster Omelet · {item:13931} Nightfin Soup · {npc:8137} Gikkix · {area:977} Steamwheedle Port · {item:13932} Poached Sunscale Salmon · {item:279982} Iron Oven
	["{item:12218} is orange from 225 (yellow at 265, green at 285, grey at 305): about 120 crafts to 300. Cook at any fire: a town hearth or your own {object:29784}. {item:16110} costs 1g 20s at its vendor; the arrow picks the nearest one of your faction. {item:12218} is orange to 265 and green from 285, yet it still carries you to 300. Fishers can finish on {item:13931} ({npc:8137}, {area:977}; yellow to 310) instead; {item:13932} needs an {item:279982} on Forever."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5); the arrow picks the nearest."] = "진영의 모든 {skill:185} 상급자가 초급 {skill:185}을(를) 가르칩니다(캐릭터 레벨 5). 화살표가 가장 가까운 곳을 가리킵니다.",
	-- ["Catch about 50 {item:6291} here by fishing (see the {skill:356} guide)."] = "이곳에서 낚시로 {item:6291} 약 50개를 잡으세요({skill:356} 가이드 참고).",
	-- ["Catch about 68 {item:6361} here by fishing (see the {skill:356} guide)."] = "이곳에서 낚시로 {item:6361} 약 68개를 잡으세요({skill:356} 가이드 참고).",
	-- ["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072}; the arrow picks its nearest seller for your faction. Buy it and read it."] = "숙련 {skill:185}은(는) 최대 숙련도를 225로 올립니다. 숙련도 125, 캐릭터 레벨 20이 필요합니다. 책 {item:16072}(으)로 배우며, 화살표가 진영의 가장 가까운 판매 상인을 가리킵니다. 사서 읽으세요.",
	-- ["Giant Eggs drop from the Ironbeak owls of {zone:1448}."] = "거대한 알은 {zone:1448}의 무쇠부리 올빼미가 떨어뜨립니다.",
	-- ["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction."] = "수습 {skill:185}은(는) 최대 숙련도를 150으로 올립니다. 숙련도 50, 캐릭터 레벨 10이 필요합니다. 화살표가 진영의 가장 가까운 {skill:185} 상급자를 가리킵니다.",
	-- ["{area:442} docks"] = "{area:442} 부두",
	-- ["{area:702} docks"] = "{area:702} 부두",
	-- ["{item:12210} is orange from 175 (yellow at 215, grey at 255): about 40 crafts to 215. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12210}은(는) 175부터 주황색입니다(노란색 215, 회색 255). 215까지 약 40번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:12215} is orange from 215 (yellow at 240, grey at 280): about 10 crafts to 225. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215}은(는) 215부터 주황색입니다(노란색 240, 회색 280). 225까지 약 10번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:12215} is orange from 225 (yellow at 240, grey at 280): about 15 crafts to 240. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215}은(는) 225부터 주황색입니다(노란색 240, 회색 280). 240까지 약 15번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:12215}: ingredients"] = "{item:12215}: 재료",
	-- ["{item:12215}: shopping"] = "{item:12215}: 구매",
	-- ["{item:12218} is orange from 240 (yellow at 265, grey at 305): about 105 crafts to 300. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12218}은(는) 240부터 주황색입니다(노란색 265, 회색 305). 300까지 약 105번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:5095} is orange from 50 (yellow at 90, grey at 130): about 68 crafts to 110. Cook at any fire: {object:29784} comes with {skill:185}. {skill:356} off the {area:442} docks catches {item:6361}."] = "{item:5095}은(는) 50부터 주황색입니다(노란색 90, 회색 130). 110까지 약 68번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다. {area:442} 부두에서 {skill:356}을(를) 하면 {item:6361}이(가) 낚입니다.",
	-- ["{item:5095}: ingredients"] = "{item:5095}: 재료",
	-- ["{item:5095}: shopping"] = "{item:5095}: 구매",
	-- ["{item:5477} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5477}은(는) 50부터 주황색입니다(노란색 90, 회색 130). 100까지 약 52번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:5479} is orange from 100 (yellow at 140, grey at 180): about 25 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479}은(는) 100부터 주황색입니다(노란색 140, 회색 180). 125까지 약 25번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:5479} is orange from 125 (yellow at 140, grey at 180): about 15 crafts to 140. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479}은(는) 125부터 주황색입니다(노란색 140, 회색 180). 140까지 약 15번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:5480} is orange from 110 (yellow at 150, grey at 190): about 15 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480}은(는) 110부터 주황색입니다(노란색 150, 회색 190). 125까지 약 15번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:5480} is orange from 125 (yellow at 150, grey at 190): about 25 crafts to 150. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480}은(는) 125부터 주황색입니다(노란색 150, 회색 190). 150까지 약 25번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:5480}: ingredients"] = "{item:5480}: 재료",
	-- ["{item:5480}: shopping"] = "{item:5480}: 구매",
	-- ["{item:6290} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}. {item:6291} is the common catch in {zone:1438}'s waters."] = "{item:6290}은(는) 1부터 주황색입니다(노란색 45, 회색 85). 50까지 약 50번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다. {item:6291}은(는) {zone:1438} 물가에서 흔히 낚입니다.",
	-- ["{item:6290}: ingredients"] = "{item:6290}: 재료",
	-- ["{item:6290}: shopping"] = "{item:6290}: 구매",
	-- ["{item:6316} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:6316}은(는) 50부터 주황색입니다(노란색 90, 회색 130). 100까지 약 52번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:6316}: ingredients"] = "{item:6316}: 재료",
	-- ["{item:6316}: shopping"] = "{item:6316}: 구매",
	-- ["{item:724} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:724}은(는) 50부터 주황색입니다(노란색 90, 회색 130). 100까지 약 52번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{item:724}: ingredients"] = "{item:724}: 재료",
	-- ["{item:724}: shopping"] = "{item:724}: 구매",
	-- ["{item:7974} has no drop data: buy it at the Gadgetzan Auction House, next to {npc:8125}, or open clams looted from coastal creatures."] = "{item:7974}은(는) 획득 데이터가 없습니다. 가젯잔 경매장({npc:8125} 옆)에서 사거나, 해안 생물에게서 얻은 조개를 여세요.",
	-- ["{npc:1193} (50%) in {zone:1432}, or wherever the arrow points"] = "{zone:1432}의 {npc:1193} (50%), 또는 화살표가 가리키는 곳",
	-- ["{npc:1400} (50%) in {zone:1437}, or wherever the arrow points"] = "{zone:1437}의 {npc:1400} (50%), 또는 화살표가 가리키는 곳",
	-- ["{npc:1549} (88%) in {zone:1420}, or wherever the arrow points"] = "{zone:1420}의 {npc:1549} (88%), 또는 화살표가 가리키는 곳",
	-- ["{npc:1689} (38%), {npc:1127} (36%) in {zone:1426}, or wherever the arrow points"] = "{zone:1426}의 {npc:1689} (38%), {npc:1127} (36%), 또는 화살표가 가리키는 곳",
	-- ["{npc:2385} (56%) in {zone:1424}, or wherever the arrow points"] = "{zone:1424}의 {npc:2385} (56%), 또는 화살표가 가리키는 곳",
	-- ["{npc:3099} (99%), {npc:3100} (74%) in {zone:1411}, or wherever the arrow points"] = "{zone:1411}의 {npc:3099} (99%), {npc:3100} (74%), 또는 화살표가 가리키는 곳",
	-- ["{npc:3244} (33%) in {zone:1413}, or wherever the arrow points"] = "{zone:1413}의 {npc:3244} (33%), 또는 화살표가 가리키는 곳",
	-- ["{npc:3818} (53%) in {zone:1440}, or wherever the arrow points"] = "{zone:1440}의 {npc:3818} (53%), 또는 화살표가 가리키는 곳",
	-- ["{npc:4352} (52%), {npc:4351} (51%) in {zone:1445}, or wherever the arrow points"] = "{zone:1445}의 {npc:4352} (52%), {npc:4351} (51%), 또는 화살표가 가리키는 곳",
	-- ["{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) in {zone:1443}, or wherever the arrow points"] = "{zone:1443}의 {npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%), 또는 화살표가 가리키는 곳",
	-- ["{npc:547} (35%), {npc:157} (34%) in {zone:1436}, or wherever the arrow points"] = "{zone:1436}의 {npc:547} (35%), {npc:157} (34%), 또는 화살표가 가리키는 곳",
	-- ["{npc:7099} (40%) in {zone:1448}, or wherever the arrow points"] = "{zone:1448}의 {npc:7099} (40%), 또는 화살표가 가리키는 곳",
	-- ["{quest:6610} asks for 20 {item:8932} (check the quest log); innkeepers and food vendors sell it, and the arrow picks the nearest."] = "{quest:6610}에는 {item:8932} 20개가 필요합니다(퀘스트 목록 확인). 여관주인과 음식 상인이 팔며, 화살표가 가장 가까운 곳을 가리킵니다.",
	-- ["{spell:2538} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2538}은(는) 1부터 주황색입니다(노란색 45, 회색 85). 50까지 약 50번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{spell:2540} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2540}은(는) 1부터 주황색입니다(노란색 45, 회색 85). 50까지 약 50번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{spell:3370} is orange from 100 (yellow at 120, grey at 160): about 26 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370}은(는) 100부터 주황색입니다(노란색 120, 회색 160). 125까지 약 26번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{spell:3370} is yellow from 125 (yellow at 120, grey at 160): about 7 crafts to 130. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370}은(는) 125부터 노란색입니다(노란색 120, 회색 160). 130까지 약 7번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{spell:3370}: ingredients"] = "{spell:3370}: 재료",
	-- ["{spell:3370}: shopping"] = "{spell:3370}: 구매",
	-- ["{spell:3376} is orange from 130 (yellow at 170, grey at 210): about 46 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376}은(는) 130부터 주황색입니다(노란색 170, 회색 210). 175까지 약 46번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{spell:3376} is orange from 150 (yellow at 170, grey at 210): about 26 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376}은(는) 150부터 주황색입니다(노란색 170, 회색 210). 175까지 약 26번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
	-- ["{spell:3398} is orange from 140 (yellow at 175, grey at 215): about 35 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3398}은(는) 140부터 주황색입니다(노란색 175, 회색 215). 175까지 약 35번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
}
