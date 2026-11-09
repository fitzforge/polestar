-- Chinese (simplified) (zhCN): the guide forever/professions/cooking (forever/professions/cooking.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Cooking
	-- {skill:185} Cooking
	["Learn {skill:185}"] = "学习{skill:185}",
	-- {skill:185} Cooking · {object:29784} Basic Campfire · {item:279981} Basic Campfire Kit · {item:4470} Simple Wood · {item:4471} Flint and Tinder
	["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5, 1s); the arrow picks the nearest. Forever: every cook knows {object:29784}. Craft a {item:279981} from one {item:4470} (38c) with {item:4471} (1s 35c, kept in your bags), then place the kit to light a cooking fire anywhere; make a few in advance (one use every 5 minutes). The first kits also raise {skill:185} to about 5. The Camping 101: {skill:185} quest at your starting area's camp sends you to this trainer."] = "本阵营任意{skill:185}训练师都能教授初级{skill:185}（角色5级，1银币）；箭头指向最近的一位。无限：每位厨师都掌握{object:29784}。用1个{item:4470}（38铜币）配合{item:4471}（1银35铜，保留在背包中）制作{item:279981}，再放置套件，即可随地点起烹饪用火；提前做几个备用（每5分钟可使用一次）。最初制作的几个套件还能将{skill:185}提高到约5点。初始地区营地的“露营 101: {skill:185}”任务会让你来找这位训练师。",

	-- Step 2: Charred Wolf Meat: ingredients
	-- {spell:2538} Charred Wolf Meat
	["{spell:2538}: ingredients"] = "{spell:2538}：材料",
	-- {zone:1429} Elwynn Forest
	["Prowler (86%) in {zone:1429}, or wherever the arrow points"] = "觅食的灰狼（86%），在{zone:1429}，或前往箭头指向的地点",

	-- Step 3: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2538} 从技能 1 起为橙色（45 变黄、65 变绿、85 变灰）：约制作 50 次可升到 50。在任意火源旁烹饪即可：城镇炉火或自己的 {object:29784}。",

	-- Step 4: Roasted Boar Meat: ingredients
	-- {spell:2540} Roasted Boar Meat
	["{spell:2540}: ingredients"] = "{spell:2540}：材料",
	-- {npc:1126} Large Crag Boar · {npc:1125} Crag Boar · {zone:1426} Dun Morogh
	["{npc:1126} (36%), {npc:1125} (34%) in {zone:1426}, or wherever the arrow points"] = "{zone:1426} 的 {npc:1126}（36%）、{npc:1125}（34%），或箭头指向的其他地点",

	-- Step 5: Roasted Boar Meat (1-50)
	-- {spell:2540} Roasted Boar Meat · {object:29784} Basic Campfire
	["{spell:2540} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2540} 从技能 1 起为橙色（45 变黄、65 变绿、85 变灰）：约制作 50 次可升到 50。在任意火源旁烹饪即可：城镇炉火或自己的 {object:29784}。",

	-- Step 6: Herb Baked Egg: shopping
	-- {item:6888} Herb Baked Egg
	["{item:6888}: shopping"] = "{item:6888}：购物",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 50 {item:2678} (1s)."] = "箭头会为每种物品选取本阵营最近的商人。你需要50个{item:2678}（1银币）。",

	-- Step 7: Herb Baked Egg: ingredients
	-- {item:6888} Herb Baked Egg
	["{item:6888}: ingredients"] = "{item:6888}：材料",
	-- {npc:1995} Strigid Owl · {zone:1438} Teldrassil
	["{npc:1995} (58%) in {zone:1438}, or wherever the arrow points"] = "{zone:1438}的{npc:1995}（58%），或箭头指向的其他地方",

	-- Step 8: Herb Baked Egg (1-50)
	-- {item:6888} Herb Baked Egg · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2678} Mild Spices · {zone:1438} Teldrassil · {item:6889} Small Egg · {zone:1439} Darkshore · {item:6290} Brilliant Smallfish · {npc:6286} Zarrin · {area:186} Dolanaar · {item:5472} Kaldorei Spider Kabob
	-- plural, as words: Small Spider Legs = {item:5465} Small Spider Leg
	["{item:6888} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. {item:6888} comes with {skill:185} (the client teaches it with the skill); {item:2678} are a cooking vendor's. The Strigid owls of {zone:1438} drop a {item:6889} more often than not, and {zone:1439}'s moonkin drop them too. Fishers can cook {item:6290} (recipe 40c) from Rut'theran's waters instead, and {npc:6286} in {area:186} gives Recipe of the Kaldorei (seven Small Spider Legs from the Webwood spiders) for {item:5472}, orange from 10 to 50."] = "{item:6888}从技能1起为橙色（45变黄，65变绿，85变灰）：约制作50次可到50。可在任意火源旁烹饪：城镇炉火或自己的{object:29784}都行。{item:6888}随{skill:185}一同掌握（客户端在学习技能时教授）；{item:2678}向烹饪商人购买。{zone:1438}的巨翼枭掉落{item:6889}的概率超过一半，{zone:1439}的枭兽也会掉落。钓鱼玩家也可改用鲁瑟兰水域钓到的鱼制作{item:6290}（食谱40铜币）；{area:186}的{npc:6286}提供“卡多雷的菜谱”（需从树林蜘蛛收集7条小蜘蛛腿），奖励{item:5472}，该配方在10-50为橙色。",

	-- Step 9: Charred Wolf Meat: ingredients
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} in Zephras Isle, or wherever the arrow points"] = "泽风岛的 {npc:250873}，或箭头指向的地点。",

	-- Step 10: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire · {item:2672} Stringy Wolf Meat
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. The Vuldren of Zephras Isle drop {item:2672}."] = "{spell:2538} 从1点起为橙色（45变黄，65变绿，85变灰）：制作约50次可到50。任意火源旁都能烹饪：城镇炉火或自己放置的 {object:29784} 均可。泽风岛的瓦尔德伦会掉落 {item:2672}。",

	-- Step 11: Roasted Boar Meat: ingredients
	-- {npc:3099} Dire Mottled Boar · {zone:1411} Durotar
	["{npc:3099} (99%) in {zone:1411}, or wherever the arrow points"] = "{zone:1411} 的 {npc:3099}（99%），或前往箭头所指的位置",

	-- Step 13: Charred Wolf Meat: ingredients
	-- {npc:2960} Prairie Wolf Alpha · {npc:2959} Prairie Stalker · {zone:1412} Mulgore
	["{npc:2960} (82%), {npc:2959} (77%) in {zone:1412}, or wherever the arrow points"] = "{npc:2960}（82%）、{npc:2959}（77%），在{zone:1412}，或前往箭头指向的地点",

	-- Step 15: Charred Wolf Meat: ingredients
	-- {npc:1547} Decrepit Darkhound · {npc:1548} Cursed Darkhound · {zone:1420} Tirisfal Glades
	["{npc:1547} (72%), {npc:1548} (33%) in {zone:1420}, or wherever the arrow points"] = "{zone:1420}的{npc:1547}（72%）、{npc:1548}（33%），或箭头指向的其他地方",

	-- Step 17: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "中级{skill:185}",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction; training costs 5s."] = "中级{skill:185}将上限提高到150；需要技能50和角色等级10：箭头会指向你所在阵营最近的{skill:185}训练师；训练花费5银。",

	-- Step 18: Coyote Steak: ingredients
	-- {spell:2541} Coyote Steak
	["{spell:2541}: ingredients"] = "{spell:2541}：材料",
	-- {npc:834} Coyote · {npc:833} Coyote Packleader · {zone:1436} Westfall
	["{npc:834} (54%), {npc:833} (51%) in {zone:1436}, or wherever the arrow points"] = "{zone:1436} 的 {npc:834}（54%）、{npc:833}（51%），或箭头指向的其他地点",

	-- Step 19: Coyote Steak (50-90)
	-- {spell:2541} Coyote Steak · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {npc:235} Salma Saldean · {area:108} Sentinel Hill · {item:733} Westfall Stew · {item:724} Goretusk Liver Pie
	-- plural, as words: Coyotes = {npc:834} Coyote
	["{spell:2541} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. Coyotes roam the middle of {zone:1436}; {npc:235} on the farm north of {area:108} also gives {item:733} and {item:724} quests that use what you loot here."] = "{spell:2541}从技能50起为橙色（90变黄，110变绿，130变灰）：约制作40次可到90。可在任意火源旁烹饪：城镇炉火或自己的{object:29784}都行。任意{skill:185}训练师都可在技能50时以1银币教授。山狗在{zone:1436}中部游荡；{area:108}北面农场的{npc:235}还提供{item:733}和{item:724}任务，会用到这里拾取的材料。",

	-- Step 20: Crab Cake: shopping
	-- {spell:2544} Crab Cake
	["{spell:2544}: shopping"] = "{spell:2544}：购物",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 44 {item:2678} (90c)."] = "箭头会为每种物品选择距离最近的本阵营商人。需要44份 {item:2678}（90铜币）。",

	-- Step 21: Crab Cake: ingredients
	-- {spell:2544} Crab Cake
	["{spell:2544}: ingredients"] = "{spell:2544}：材料",
	-- {npc:830} Sand Crawler · {zone:1436} Westfall
	["{npc:830} (43%) in {zone:1436}, or wherever the arrow points"] = "{zone:1436}的{npc:830}（43%），或箭头所指的位置",

	-- Step 22: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1436} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544}从技能90起为橙色（115变黄，135变绿，155变灰）：约制作44次可到130。可在任意火源旁烹饪：城镇炉火或自己的{object:29784}都行。任意{skill:185}训练师都可在技能75时以2银币教授。螃蟹分布在{zone:1436}整条海岸。做这个到130，再改做{spell:3376}。",

	-- Step 23: Smoked Bear Meat: shopping
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: shopping"] = "{item:6890}：购物",
	["The arrow picks the nearest vendor of your faction for each item."] = "箭头会为每种物品指向本阵营最近的商人。",

	-- Step 24: Smoked Bear Meat: ingredients
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: ingredients"] = "{item:6890}：材料",
	-- {npc:1189} Black Bear Patriarch · {zone:1432} Loch Modan
	["{npc:1189} (39%) in {zone:1432}, or wherever the arrow points"] = "{zone:1432} 的 {npc:1189}（39%），或箭头指向的地点。",

	-- Step 25: Smoked Bear Meat (50-80)
	-- {item:6890} Smoked Bear Meat · {object:29784} Basic Campfire · {item:6892} Recipe: Smoked Bear Meat · {zone:1432} Loch Modan
	["{item:6890} is orange from 50 (yellow at 80, green at 100, grey at 120): about 30 crafts to 80. Cook at any fire: a town hearth or your own {object:29784}. {item:6892} costs 2s 50c at its vendor; the arrow picks the nearest one of your faction. Black bears roam the hills of {zone:1432}."] = "{item:6890} 从50点起为橙色（80变黄，100变绿，120变灰）：制作约30次可到80。任意火源旁都能烹饪：城镇炉火或自己放置的 {object:29784} 均可。{item:6892} 在对应商人处售价2银币50铜币；箭头会选择最近的本阵营商人。黑熊在 {zone:1432} 的山丘中游荡。",

	-- Step 26: Dry Pork Ribs: shopping
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: shopping"] = "{spell:2546}：购物",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2678} (1s 10c)."] = "箭头会为每件物品选择本阵营最近的商人。你需要52个{item:2678}（1银10铜）。",

	-- Step 27: Dry Pork Ribs: ingredients
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: ingredients"] = "{spell:2546}：材料",
	-- {npc:1191} Mangy Mountain Boar · {zone:1432} Loch Modan
	["{npc:1191} (31%) in {zone:1432}, or wherever the arrow points"] = "{zone:1432} 的 {npc:1191}（31%），或箭头所指的地方",

	-- Step 28: Dry Pork Ribs (80-130)
	-- {spell:2546} Dry Pork Ribs · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1432} Loch Modan · {spell:3376} Curiously Tasty Omelet
	["{spell:2546} is orange from 80 (yellow at 120, green at 140, grey at 160): about 52 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 80 for 1s 50c. Mountain boars roam all of {zone:1432}. Cook it to 130, where {spell:3376} takes over."] = "{spell:2546} 从技能 80 起为橙色（120 变黄、140 变绿、160 变灰）：约制作 52 次可升到 130。在任意火源旁烹饪即可：城镇炉火或自己的 {object:29784}。技能达到 80 后，任意 {skill:185} 训练师都可教授，费用为 1 银 50 铜。山猪遍布 {zone:1432}。制作到 130，再改用 {spell:3376}。",

	-- Step 29: Boiled Clams: shopping
	-- {item:5525} Boiled Clams
	["{item:5525}: shopping"] = "{item:5525}：购物",
	-- {item:159} Refreshing Spring Water
	["The arrow picks the nearest vendor of your faction for each item. You need 40 {item:159} (2s)."] = "箭头会为每件物品选择本阵营最近的商人。你需要40个{item:159}（2银）。",

	-- Step 30: Boiled Clams: ingredients
	-- {item:5525} Boiled Clams
	["{item:5525}: ingredients"] = "{item:5525}：材料",
	-- {npc:3812} Clattering Crawler · {npc:3814} Spined Crawler · {npc:3944} Wrathtail Priestess · {zone:1439} Darkshore · {item:5523} Small Barnacled Clam · {item:5503} Clam Meat
	["{npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) in {zone:1439}, or wherever the arrow points; open each {item:5523} for its {item:5503}"] = "{zone:1439} 的 {npc:3812}（42%）、{npc:3814}（42%）、{npc:3944}（42%），或箭头指向的地点；打开每个 {item:5523}，取得其中的 {item:5503}。",

	-- Step 31: Boiled Clams (50-90)
	-- {item:5525} Boiled Clams · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2674} Crawler Meat · {spell:2544} Crab Cake
	["{item:5525} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. The same coastal crawlers drop {item:2674} for {spell:2544} next: keep it."] = "{item:5525} 从技能 50 起为橙色（90 变黄、110 变绿、130 变灰）：约制作 40 次可升到 90。在任意火源旁烹饪即可：城镇炉火或自己的 {object:29784}。技能达到 50 后，任意 {skill:185} 训练师都可教授，费用为 1 银。同一批海岸螃蟹还会掉落下一个配方 {spell:2544} 所需的 {item:2674}：留着。",

	-- Step 33: Crab Cake: ingredients
	-- {npc:3814} Spined Crawler · {npc:3812} Clattering Crawler · {zone:1439} Darkshore
	["{npc:3814} (42%), {npc:3812} (40%) in {zone:1439}, or wherever the arrow points"] = "{zone:1439} 的 {npc:3814}（42%）、{npc:3812}（40%），或前往箭头所指的位置",

	-- Step 34: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1439} Darkshore · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1439} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544}从技能90起为橙色（115变黄，135变绿，155变灰）：约制作44次可到130。可在任意火源旁烹饪：城镇炉火或自己的{object:29784}都行。任意{skill:185}训练师都可在技能75时以2银币教授。螃蟹分布在{zone:1439}整条海岸。做这个到130，再改做{spell:3376}。",

	-- Step 35: Strider Stew: shopping
	-- {item:5477} Strider Stew
	["{item:5477}: shopping"] = "{item:5477}：购物",
	-- {item:4536} Shiny Red Apple
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:4536} (2s 75c)."] = "箭头会为每种物品选择距离最近的本阵营商人。需要52个 {item:4536}（2银币75铜币）。",

	-- Step 36: Strider Stew: ingredients
	-- {item:5477} Strider Stew
	["{item:5477}: ingredients"] = "{item:5477}：材料",
	-- {npc:3246} Fleeting Plainstrider · {zone:1413} The Barrens
	["{npc:3246} (32%) in {zone:1413}, or wherever the arrow points"] = "{zone:1413}的{npc:3246}（32%），或箭头所指的位置",

	-- Step 37: Strider Stew (50-100)
	-- {item:5477} Strider Stew · {object:29784} Basic Campfire · {item:5486} Recipe: Strider Stew
	["{item:5477} is orange from 50 (yellow at 90, green at 110, grey at 130): about 52 crafts to 100. Cook at any fire: a town hearth or your own {object:29784}. {item:5486} costs 4s 40c at its vendor; the arrow picks the nearest one of your faction."] = "{item:5477} 从50点起为橙色（90变黄，110变绿，130变灰）：制作约52次可到100。任意火源旁都能烹饪：城镇炉火或自己放置的 {object:29784} 均可。{item:5486} 在对应商人处售价4银币40铜币；箭头会选择最近的本阵营商人。",

	-- Step 38: Crispy Lizard Tail: shopping
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: shopping"] = "{item:5479}：购物",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 30 {item:2692} (12s)."] = "箭头会为每种物品选择离你最近的本阵营商人。你需要 30 个 {item:2692}（12 银）。",

	-- Step 39: Crispy Lizard Tail: ingredients
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: ingredients"] = "{item:5479}：材料",
	-- {npc:3239} Thunderhead · {zone:1413} The Barrens
	["{npc:3239} (59%), Owatanka (35%) in {zone:1413}, or wherever the arrow points"] = "{npc:3239}（59%）、奥瓦坦卡（35%），在{zone:1413}，或前往箭头指向的地点",

	-- Step 40: Crispy Lizard Tail (100-130)
	-- {item:5479} Crispy Lizard Tail · {object:29784} Basic Campfire · {item:5488} Recipe: Crispy Lizard Tail · {npc:3489} Zargh · {item:3735} Recipe: Hot Lion Chops
	["{item:5479} is orange from 100 (yellow at 140, green at 160, grey at 180): about 30 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. {item:5488} costs 4s at its vendor; the arrow picks the nearest one of your faction. {npc:3489}, the butcher beside this vendor at the Crossroads, sells {item:3735} (18s), the recipe after Expert: buy it now."] = "{item:5479}从100起为橙色（140变黄、160变绿、180变灰），做约30次可到130。任意火源都能烹饪，包括城镇壁炉或自己的{object:29784}。{item:5488}在商人处售价4银币，箭头会指向离你最近的本阵营商人。十字路口这位商人旁边的屠夫{npc:3489}出售{item:3735}（18银币），这是学会高级烹饪后要用的食谱，现在就买。",

	-- Step 41: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "高级{skill:185}",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook
	["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072} (1g); the arrow picks its nearest seller for your faction. Buy it and read it."] = "高级{skill:185}将上限提高到225；需要技能125、角色20级：通过书籍{item:16072}学习（1金币）；箭头会选择本阵营最近的售书商。买来阅读。",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "购买并阅读{item:16072}（高级{skill:185}）",

	-- Step 42: Curiously Tasty Omelet: shopping
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: shopping"] = "{spell:3376}：购物",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 46 {item:2692} (18s 40c)."] = "箭头会为每种物品选择距离最近的本阵营商人。需要46份 {item:2692}（18银币40铜币）。",

	-- Step 43: Curiously Tasty Omelet: ingredients
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: ingredients"] = "{spell:3376}：材料",
	-- {npc:1018} Highland Razormaw · {npc:1019} Elder Razormaw · {zone:1437} Wetlands
	["{npc:1018} (72%), {npc:1019} (67%) in {zone:1437}, or wherever the arrow points"] = "{npc:1018}（72%）、{npc:1019}（67%），在{zone:1437}，或前往箭头指向的地点",

	-- Step 44: Curiously Tasty Omelet (130-175)
	-- {spell:3376} Curiously Tasty Omelet · {object:29784} Basic Campfire · {item:3682} Recipe: Curiously Tasty Omelet · {zone:1437} Wetlands · {item:3685} Raptor Egg · {npc:340} Kendor Kabonka · {zone:1453} Stormwind
	["{spell:3376} is orange from 130 (yellow at 170, green at 190, grey at 210): about 46 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3682} costs 16s at its vendor; the arrow picks the nearest one of your faction. The raptors of the {zone:1437} drop a {item:3685} about two kills in three. {npc:340} in {zone:1453} sells the recipe."] = "{spell:3376} 从技能130起为橙色（170变黄，190变绿，210变灰）：大约制作46次升到175。可在任意火源旁烹饪：城镇炉火或自己的 {object:29784} 都行。{item:3682} 在商人处售价16银币；箭头会选择本阵营最近的商人。{zone:1437} 的迅猛龙掉落 {item:3685} 的概率约为三分之二。{zone:1453} 的 {npc:340} 出售配方。",

	-- Step 45: Hot Lion Chops: shopping
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: shopping"] = "{spell:3398}：购物",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 45 {item:2692} (18s)."] = "箭头会为每件物品选择本阵营最近的商人。需要 45 个 {item:2692}（18 银币）。",

	-- Step 46: Hot Lion Chops: ingredients
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: ingredients"] = "{spell:3398}：材料",
	-- {npc:2384} Starving Mountain Lion · {zone:1424} Hillsbrad Foothills
	["{npc:2384} (42%) in {zone:1424}, or wherever the arrow points"] = "{zone:1424} 的 {npc:2384}（42%），或箭头指向的其他地点",

	-- Step 47: Hot Lion Chops (130-175)
	-- {spell:3398} Hot Lion Chops · {object:29784} Basic Campfire · {item:3735} Recipe: Hot Lion Chops · {item:3731} Lion Meat
	-- plural, as words: Hulking Mountain Lions = {npc:2407} Hulking Mountain Lion
	["{spell:3398} is orange from 130 (yellow at 175, green at 195, grey at 215): about 45 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3735} costs 18s at its vendor; the arrow picks the nearest one of your faction. The Feral and Hulking Mountain Lions of Hillsbrad Foothills drop {item:3731} more often than the Starving ones."] = "{spell:3398} 从技能130起为橙色（175变黄，195变绿，215变灰）：大约制作45次升到175。可在任意火源旁烹饪：城镇炉火或自己的 {object:29784} 都行。{item:3735} 在商人处售价18银币；箭头会选择本阵营最近的商人。希尔斯布莱德丘陵的野生山地狮和巨型山地狮掉落 {item:3731} 的概率高于饥饿的山地狮。",

	-- Step 48: Roast Raptor: shopping
	-- {item:12210} Roast Raptor
	["{item:12210}: shopping"] = "{item:12210}：购物",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2692} (20s 80c)."] = "箭头会为每种物品选择离你最近的本阵营商人。你需要 52 个 {item:2692}（20 银 80 铜）。",

	-- Step 49: Roast Raptor: ingredients
	-- {item:12210} Roast Raptor
	["{item:12210}: ingredients"] = "{item:12210}：材料",
	-- {npc:2560} Highland Thrasher · {zone:1417} Arathi Highlands
	["{npc:2560} (38%) in {zone:1417}, or wherever the arrow points"] = "{zone:1417}的{npc:2560}（38%），或箭头指向的其他地方",

	-- Step 50: Roast Raptor (175-225)
	-- {item:12210} Roast Raptor · {object:29784} Basic Campfire · {item:12228} Recipe: Roast Raptor · {zone:1417} Arathi Highlands · {npc:2810} Hammon Karwn · {area:320} Refuge Pointe · {npc:2821} Keena · {area:321} Hammerfall · {item:2692} Hot Spices · {item:17222} Spider Sausage · {item:12205} White Spider Meat
	["{item:12210} is orange from 175 (yellow at 215, green at 235, grey at 255): about 52 crafts to 225. Cook at any fire: a town hearth or your own {object:29784}. {item:12228} costs 50s at its vendor; the arrow picks the nearest one of your faction. {zone:1417}: {npc:2810} at {area:320} (Alliance) and {npc:2821} at {area:321} (Horde) sell the recipe and {item:2692} beside the raptors. {item:17222} (any trainer from 200, 40s) is the alternative, but it takes two {item:12205} a craft and Dustwallow's spiders drop one about two kills in five."] = "{item:12210}从技能175起为橙色（215变黄，235变绿，255变灰）：约制作52次可到225。可在任意火源旁烹饪：城镇炉火或自己的{object:29784}都行。{item:12228}在对应商人处售价50银币；箭头指向本阵营最近的一位。{zone:1417}：{area:320}的{npc:2810}（联盟）和{area:321}的{npc:2821}（部落）在迅猛龙活动区旁出售食谱及{item:2692}。也可选{item:17222}（任意训练师在技能200起可教，40银币），但每次需2个{item:12205}，尘泥沼泽蜘蛛约每击杀5只掉2次。",

	-- Step 51: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "专家级{skill:185}由{area:976}（{zone:1446}）的{npc:8125}教授。{zone:1455}的烹饪训练师会指引你前往；需要技能225和等级35级。",

	-- Step 52: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "专家级{skill:185}由{area:976}（{zone:1446}）的{npc:8125}教授。{zone:1454}的烹饪训练师会指引你前往；需要技能225和等级35级。",

	-- Step 53: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "巨蛋",
	-- {quest:6610} Clamlette Surprise · {item:7974} Zesty Clam Meat · {item:8932} Alterac Swiss · {zone:1446} Tanaris · {zone:1425} The Hinterlands · {npc:2929} Savage Owlbeast · {item:12218} Monster Omelet
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["{quest:6610} asks for 12 Giant Eggs, 10 {item:7974} and 20 {item:8932}: bring all three before you go to {zone:1446}, so you make the trip once. Giant Eggs drop from the owlbeasts of {zone:1425}: {npc:2929} (54%). {item:12218} takes about 120 more after Artisan: farm them now too if you like."] = "{quest:6610} 需要 12 个巨蛋、10 个 {item:7974} 和 20 个 {item:8932}：前往 {zone:1446} 前带齐这三种材料，免得多跑一趟。巨蛋由 {zone:1425} 的枭兽掉落：{npc:2929}（54%）。学会大师级后，制作 {item:12218} 还需要约 120 个；愿意的话，现在也一并刷好。",

	-- Step 54: Alterac Swiss
	-- {item:8932} Alterac Swiss
	["Innkeepers and food vendors sell {item:8932}; the arrow picks the nearest."] = "旅店老板和食物商人出售 {item:8932}；箭头会选择最近的一位。",

	-- Step 55: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {zone:1445} Dustwallow Marsh · {zone:1446} Tanaris
	-- plural, as words: Big-mouth Clams = {item:7973} Big-mouth Clam · Steeljaw Snappers = {npc:14123} Steeljaw Snapper
	["{item:7974} comes from Big-mouth Clams: open each one, every clam holds one. The Muckshell crabs on the {zone:1445} coast south-west of Theramore drop a clam about seven kills in ten, so ten clams take about fifteen kills, on your way to {zone:1446}. The Steeljaw Snappers on {zone:1446}'s east coast drop them about one kill in three."] = "{item:7974} 来自巨型蚌壳：逐个打开，每个里面都有一个。{zone:1445} 海岸、塞拉摩西南的泥壳蟹约每十次击杀有七次掉落蚌壳，所以在前往 {zone:1446} 的途中，杀约十五只就能获得十个蚌壳。{zone:1446} 东海岸的钢腭钳嘴龟掉率约为三分之一。",

	-- Step 56: Clamlette Surprise
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "专家级{skill:185}",

	-- Step 57: Monster Omelet: shopping
	-- {item:12218} Monster Omelet
	["{item:12218}: shopping"] = "{item:12218}：购物",
	-- {item:3713} Soothing Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 240 {item:3713} (3g 84s)."] = "箭头会为每件物品选择本阵营最近的商人。需要 240 个 {item:3713}（3 金 84 银）。",

	-- Step 58: Monster Omelet: ingredients
	-- {item:12218} Monster Omelet
	["{item:12218}: ingredients"] = "{item:12218}：材料",
	-- {npc:2929} Savage Owlbeast · {zone:1425} The Hinterlands
	["{npc:2929} (54%) in {zone:1425}, or wherever the arrow points"] = "{zone:1425} 的 {npc:2929}（54%），或前往箭头所指的位置",

	-- Step 59: Monster Omelet (225-300)
	-- {item:12218} Monster Omelet · {object:29784} Basic Campfire · {item:16110} Recipe: Monster Omelet · {item:13931} Nightfin Soup · {npc:8137} Gikkix · {area:977} Steamwheedle Port · {item:13932} Poached Sunscale Salmon · {item:279982} Iron Oven
	["{item:12218} is orange from 225 (yellow at 265, green at 285, grey at 305): about 120 crafts to 300. Cook at any fire: a town hearth or your own {object:29784}. {item:16110} costs 1g 20s at its vendor; the arrow picks the nearest one of your faction. {item:12218} is orange to 265 and green from 285, yet it still carries you to 300. Fishers can finish on {item:13931} ({npc:8137}, {area:977}; yellow to 310) instead; {item:13932} needs an {item:279982} on Forever."] = "{item:12218}从技能225起为橙色（265变黄，285变绿，305变灰）：约制作120次可到300。可在任意火源旁烹饪：城镇炉火或自己的{object:29784}都行。{item:16110}在对应商人处售价1金20银；箭头指向本阵营最近的一位。{item:12218}到265前为橙色，285起为绿色，但仍可用它升到300。钓鱼玩家也可最后改做{item:13931}（{area:977}的{npc:8137}出售；到310前为黄色）；无限中，{item:13932}需要{item:279982}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5); the arrow picks the nearest."] = "本阵营的任何{skill:185}训练师都能教授初级{skill:185}（角色等级5级）；箭头指向最近的训练师。",
	-- ["Catch about 50 {item:6291} here by fishing (see the {skill:356} guide)."] = "在这里钓约50条{item:6291}（参见{skill:356}指南）。",
	-- ["Catch about 68 {item:6361} here by fishing (see the {skill:356} guide)."] = "在这里钓约68条{item:6361}（参见{skill:356}指南）。",
	-- ["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072}; the arrow picks its nearest seller for your faction. Buy it and read it."] = "高级{skill:185}将上限提高到225；需要技能125和角色等级20级：它是一本书，即{item:16072}；箭头指向本阵营最近的出售者。买下并阅读。",
	-- ["Giant Eggs drop from the Ironbeak owls of {zone:1448}."] = "巨蛋由{zone:1448}的铁喙猫头鹰掉落。",
	-- ["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction."] = "中级{skill:185}将上限提高到150；需要技能50和角色等级10级：箭头指向本阵营最近的{skill:185}训练师。",
	-- ["{area:442} docks"] = "{area:442}码头",
	-- ["{area:702} docks"] = "{area:702}码头",
	-- ["{item:12210} is orange from 175 (yellow at 215, grey at 255): about 40 crafts to 215. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12210}从175起为橙色（215变黄，255变灰）：约制作40次可到215。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{item:12215} is orange from 215 (yellow at 240, grey at 280): about 10 crafts to 225. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215}从215起为橙色（240变黄，280变灰）：约制作10次可到225。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{item:12215} is orange from 225 (yellow at 240, grey at 280): about 15 crafts to 240. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215}从225起为橙色（240变黄，280变灰）：约制作15次可到240。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{item:12215}: ingredients"] = "{item:12215}：材料",
	-- ["{item:12215}: shopping"] = "{item:12215}：购物",
	-- ["{item:12218} is orange from 240 (yellow at 265, grey at 305): about 105 crafts to 300. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12218}从240起为橙色（265变黄，305变灰）：约制作105次可到300。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{item:5095} is orange from 50 (yellow at 90, grey at 130): about 68 crafts to 110. Cook at any fire: {object:29784} comes with {skill:185}. {skill:356} off the {area:442} docks catches {item:6361}."] = "{item:5095}从50起为橙色（90变黄，130变灰）：约制作68次可到110。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。在{area:442}码头{skill:356}可钓到{item:6361}。",
	-- ["{item:5095}: ingredients"] = "{item:5095}：材料",
	-- ["{item:5095}: shopping"] = "{item:5095}：购物",
	-- ["{item:5477} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5477}从50起为橙色（90变黄，130变灰）：约制作52次可到100。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{item:5479} is orange from 100 (yellow at 140, grey at 180): about 25 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479}从100起为橙色（140变黄，180变灰）：约制作25次可到125。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{item:5479} is orange from 125 (yellow at 140, grey at 180): about 15 crafts to 140. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479}从125起为橙色（140变黄，180变灰）：约制作15次可到140。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{item:5480} is orange from 110 (yellow at 150, grey at 190): about 15 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480}从110起为橙色（150变黄，190变灰）：约制作15次可到125。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{item:5480} is orange from 125 (yellow at 150, grey at 190): about 25 crafts to 150. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480}从125起为橙色（150变黄，190变灰）：约制作25次可到150。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{item:5480}: ingredients"] = "{item:5480}：材料",
	-- ["{item:5480}: shopping"] = "{item:5480}：购物",
	-- ["{item:6290} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}. {item:6291} is the common catch in {zone:1438}'s waters."] = "{item:6290}从1起为橙色（45变黄，85变灰）：约制作50次可到50。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。{item:6291}是{zone:1438}水域的常见渔获。",
	-- ["{item:6290}: ingredients"] = "{item:6290}：材料",
	-- ["{item:6290}: shopping"] = "{item:6290}：购物",
	-- ["{item:6316} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:6316}从50起为橙色（90变黄，130变灰）：约制作52次可到100。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{item:6316}: ingredients"] = "{item:6316}：材料",
	-- ["{item:6316}: shopping"] = "{item:6316}：购物",
	-- ["{item:724} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:724}从50起为橙色（90变黄，130变灰）：约制作52次可到100。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{item:724}: ingredients"] = "{item:724}：材料",
	-- ["{item:724}: shopping"] = "{item:724}：购物",
	-- ["{item:7974} has no drop data: buy it at the Gadgetzan Auction House, next to {npc:8125}, or open clams looted from coastal creatures."] = "{item:7974}没有掉落数据：在加基森拍卖行（{npc:8125}旁边）购买，或打开从沿海生物身上拾取的蚌壳。",
	-- ["{item:7974} has no drop data: buy it at the {object:175904} House, next to Dirge, or open clams looted from coastal creatures."] = "{item:7974}没有掉落数据：在迪尔格旁边的{object:175904}购买，或打开从海岸生物身上拾取的蚌壳。",
	-- ["{npc:1193} (50%) in {zone:1432}, or wherever the arrow points"] = "{npc:1193}（50%），在{zone:1432}，或前往箭头指向的地点",
	-- ["{npc:1400} (50%) in {zone:1437}, or wherever the arrow points"] = "{npc:1400}（50%），在{zone:1437}，或前往箭头指向的地点",
	-- ["{npc:1549} (88%) in {zone:1420}, or wherever the arrow points"] = "{npc:1549}（88%），在{zone:1420}，或前往箭头指向的地点",
	-- ["{npc:1689} (38%), {npc:1127} (36%) in {zone:1426}, or wherever the arrow points"] = "{npc:1689}（38%）、{npc:1127}（36%），在{zone:1426}，或前往箭头指向的地点",
	-- ["{npc:2385} (56%) in {zone:1424}, or wherever the arrow points"] = "{npc:2385}（56%），在{zone:1424}，或前往箭头指向的地点",
	-- ["{npc:3099} (99%), {npc:3100} (74%) in {zone:1411}, or wherever the arrow points"] = "{npc:3099}（99%）、{npc:3100}（74%），在{zone:1411}，或前往箭头指向的地点",
	-- ["{npc:3244} (33%) in {zone:1413}, or wherever the arrow points"] = "{npc:3244}（33%），在{zone:1413}，或前往箭头指向的地点",
	-- ["{npc:3818} (53%) in {zone:1440}, or wherever the arrow points"] = "{npc:3818}（53%），在{zone:1440}，或前往箭头指向的地点",
	-- ["{npc:4352} (52%), {npc:4351} (51%) in {zone:1445}, or wherever the arrow points"] = "{npc:4352}（52%）、{npc:4351}（51%），在{zone:1445}，或前往箭头指向的地点",
	-- ["{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) in {zone:1443}, or wherever the arrow points"] = "{npc:4701}（55%）、{npc:4702}（54%）、{npc:4700}（40%），在{zone:1443}，或前往箭头指向的地点",
	-- ["{npc:547} (35%), {npc:157} (34%) in {zone:1436}, or wherever the arrow points"] = "{npc:547}（35%）、{npc:157}（34%），在{zone:1436}，或前往箭头指向的地点",
	-- ["{npc:7099} (40%) in {zone:1448}, or wherever the arrow points"] = "{npc:7099}（40%），在{zone:1448}，或前往箭头指向的地点",
	-- ["{quest:6610} asks for 20 {item:8932} (check the quest log); innkeepers and food vendors sell it, and the arrow picks the nearest."] = "{quest:6610}需要20块{item:8932}（查看任务日志）；旅店老板和食物商人有售，箭头指向最近的一位。",
	-- ["{spell:2538} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2538}从1起为橙色（45变黄，85变灰）：约制作50次可到50。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{spell:2540} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2540}从1起为橙色（45变黄，85变灰）：约制作50次可到50。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{spell:3370} is orange from 100 (yellow at 120, grey at 160): about 26 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370}从100起为橙色（120变黄，160变灰）：约制作26次可到125。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{spell:3370} is yellow from 125 (yellow at 120, grey at 160): about 7 crafts to 130. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370}从125起为黄色（120变黄，160变灰）：约制作7次可到130。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{spell:3370}: ingredients"] = "{spell:3370}：材料",
	-- ["{spell:3370}: shopping"] = "{spell:3370}：购物",
	-- ["{spell:3376} is orange from 130 (yellow at 170, grey at 210): about 46 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376}从130起为橙色（170变黄，210变灰）：约制作46次可到175。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{spell:3376} is orange from 150 (yellow at 170, grey at 210): about 26 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376}从150起为橙色（170变黄，210变灰）：约制作26次可到175。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
	-- ["{spell:3398} is orange from 140 (yellow at 175, grey at 215): about 35 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3398}从140起为橙色（175变黄，215变灰）：约制作35次可到175。任何火堆都能烹饪：学会{skill:185}即获得{object:29784}。",
}
