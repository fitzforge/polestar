-- Chinese (traditional) (zhTW): the guide forever/professions/cooking (forever/professions/cooking.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Cooking
	-- {skill:185} Cooking
	["Learn {skill:185}"] = "學習{skill:185}",
	-- {skill:185} Cooking · {object:29784} Basic Campfire · {item:279981} Basic Campfire Kit · {item:4470} Simple Wood · {item:4471} Flint and Tinder
	["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (any character level, 1s); the arrow picks the nearest. Forever: every cook knows {object:29784}. Craft a {item:279981} from one {item:4470} (38c) with {item:4471} (1s 35c, kept in your bags), then place the kit to light a cooking fire anywhere; make a few in advance (one use every 5 minutes). The first kits also raise {skill:185} to about 5. The Camping 101: {skill:185} quest at your starting area's camp sends you to this trainer."] = "你陣營的任何{skill:185}訓練師都會教初級{skill:185}（不限角色等級，1銀）；箭頭會指向最近的一位。Forever：每位廚師都會{object:29784}。用1個{item:4470}（38銅）搭配{item:4471}（1銀35銅，留在背包中）製作{item:279981}，然後放置套件即可隨地生起烹飪用火；預先多做幾個（每5分鐘可用一次）。最初做的幾個套件還能把{skill:185}提升到約5點。起始地區營地的「紮營入門指南：{skill:185}」任務會讓你來找這位訓練師。",

	-- Step 2: Get Stringy Wolf Meat
	-- {item:2672} Stringy Wolf Meat
	["Get {item:2672}"] = "",
	-- {item:2672} Stringy Wolf Meat · {spell:2538} Charred Wolf Meat · {npc:118} Prowler · {zone:1429} Elwynn Forest
	["You need 50 {item:2672} for {spell:2538} (1-50). It drops from {npc:118} (86%) in {zone:1429}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 3: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2538}從1起為橘色（45變黃，65變綠，85變灰）：製作約50次到50。在任何火堆旁都能烹飪：城鎮的爐火或你自己的{object:29784}。",

	-- Step 4: Get Chunk of Boar Meat
	-- {item:769} Chunk of Boar Meat
	["Get {item:769}"] = "",
	-- {item:769} Chunk of Boar Meat · {spell:2540} Roasted Boar Meat · {npc:1126} Large Crag Boar · {npc:1125} Crag Boar · {zone:1426} Dun Morogh
	["You need 50 {item:769} for {spell:2540} (1-50). It drops from {npc:1126} (36%), {npc:1125} (34%) in {zone:1426}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 5: Roasted Boar Meat (1-50)
	-- {spell:2540} Roasted Boar Meat · {object:29784} Basic Campfire
	["{spell:2540} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2540}從1起為橘色（45變黃，65變綠，85變灰）：製作約50次到50。在任何火堆旁都能烹飪：城鎮的爐火或你自己的{object:29784}。",

	-- Step 6: Herb Baked Egg: shopping
	-- {item:6888} Herb Baked Egg
	["{item:6888}: shopping"] = "{item:6888}：採購",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 50 {item:2678} (1s)."] = "箭頭會為每件物品指向本陣營最近的商人。你需要50個{item:2678}（1銀）。",

	-- Step 7: Get Small Egg
	-- {item:6889} Small Egg
	["Get {item:6889}"] = "",
	-- {item:6889} Small Egg · {item:6888} Herb Baked Egg · {npc:1995} Strigid Owl · {zone:1438} Teldrassil
	["You need 50 {item:6889} for {item:6888} (1-50). It drops from {npc:1995} (58%) in {zone:1438}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 8: Herb Baked Egg (1-50)
	-- {item:6888} Herb Baked Egg · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2678} Mild Spices · {zone:1438} Teldrassil · {item:6889} Small Egg · {zone:1439} Darkshore · {item:6290} Brilliant Smallfish · {npc:6286} Zarrin · {area:186} Dolanaar · {item:5472} Kaldorei Spider Kabob
	-- plural, as words: Small Spider Legs = {item:5465} Small Spider Leg
	["{item:6888} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. {item:6888} comes with {skill:185} (the client teaches it with the skill); {item:2678} are a cooking vendor's. The Strigid owls of {zone:1438} drop a {item:6889} more often than not, and {zone:1439}'s moonkin drop them too. Fishers can cook {item:6290} (recipe 40c) from Rut'theran's waters instead, and {npc:6286} in {area:186} gives Recipe of the Kaldorei (seven Small Spider Legs from the Webwood spiders) for {item:5472}, orange from 10 to 50."] = "{item:6888}從1起為橙色（45黃、65綠、85灰）：做到50約需50次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。{item:6888}隨{skill:185}一起學會（客戶端會隨技能教授）；{item:2678}則向烹飪商人購買。{zone:1438}的夜梟多數時候會掉{item:6889}，{zone:1439}的梟獸也會掉。漁夫可以改用魯瑟蘭水域的{item:6290}（配方40銅）來烹飪，而{area:186}的{npc:6286}會用{item:5472}換“卡多雷的食譜”（需要七條蛛網蜘蛛的小蜘蛛腿），10到50點均為橙色。",

	-- Step 9: Get Stringy Wolf Meat
	-- {item:2672} Stringy Wolf Meat · {spell:2538} Charred Wolf Meat · {npc:250873} Juvenile Vuldren
	["You need 50 {item:2672} for {spell:2538} (1-50). It drops from {npc:250873} in Zephras Isle. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 10: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire · {item:2672} Stringy Wolf Meat
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. The Vuldren of Zephras Isle drop {item:2672}."] = "{spell:2538}從1起為橙色（45黃、65綠、85灰）：做到50約需50次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。澤弗拉斯島的鷲龍會掉落{item:2672}。",

	-- Step 11: Get Chunk of Boar Meat
	-- {item:769} Chunk of Boar Meat · {spell:2540} Roasted Boar Meat · {npc:3099} Dire Mottled Boar · {zone:1411} Durotar
	["You need 50 {item:769} for {spell:2540} (1-50). It drops from {npc:3099} (99%) in {zone:1411}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 13: Get Stringy Wolf Meat
	-- {item:2672} Stringy Wolf Meat · {spell:2538} Charred Wolf Meat · {npc:2960} Prairie Wolf Alpha · {npc:2959} Prairie Stalker · {zone:1412} Mulgore
	["You need 50 {item:2672} for {spell:2538} (1-50). It drops from {npc:2960} (82%), {npc:2959} (77%) in {zone:1412}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 15: Get Stringy Wolf Meat
	-- {item:2672} Stringy Wolf Meat · {spell:2538} Charred Wolf Meat · {npc:1547} Decrepit Darkhound · {npc:1548} Cursed Darkhound · {zone:1420} Tirisfal Glades
	["You need 50 {item:2672} for {spell:2538} (1-50). It drops from {npc:1547} (72%), {npc:1548} (33%) in {zone:1420}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 17: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "中級{skill:185}",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and no character level: the arrow picks the nearest {skill:185} trainer of your faction; training costs 5s."] = "中級{skill:185}將上限提高到150；需要技能50，沒有角色等級要求：箭頭會指向你陣營最近的{skill:185}訓練師；訓練費用5銀。",

	-- Step 18: Get Coyote Meat
	-- {item:2673} Coyote Meat
	["Get {item:2673}"] = "",
	-- {item:2673} Coyote Meat · {spell:2541} Coyote Steak · {npc:833} Coyote Packleader · {zone:1436} Westfall
	["You need 40 {item:2673} for {spell:2541} (50-90). It drops from Coyote (54%), {npc:833} (51%) in {zone:1436}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 19: Coyote Steak (50-90)
	-- {spell:2541} Coyote Steak · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {npc:235} Salma Saldean · {area:108} Sentinel Hill · {item:733} Westfall Stew · {item:724} Goretusk Liver Pie
	["{spell:2541} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. Coyotes roam the middle of {zone:1436}; {npc:235} on the farm north of {area:108} also gives {item:733} and {item:724} quests that use what you loot here."] = "{spell:2541}從50起為橙色（90黃、110綠、130灰）：做到90約需40次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。任何{skill:185}訓練師都會從技能50起以1銀教授它。郊狼在{zone:1436}中部遊蕩；{area:108}以北農場的{npc:235}還會給需要此處戰利品的{item:733}和{item:724}任務。",

	-- Step 20: Crab Cake: shopping
	-- {spell:2544} Crab Cake
	["{spell:2544}: shopping"] = "{spell:2544}：採購",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 44 {item:2678} (90c)."] = "箭頭會為每件物品指向本陣營最近的商人。你需要44個{item:2678}（90銅）。",

	-- Step 21: Get Crawler Meat
	-- {item:2674} Crawler Meat
	["Get {item:2674}"] = "",
	-- {item:2674} Crawler Meat · {spell:2544} Crab Cake · {npc:830} Sand Crawler · {zone:1436} Westfall
	["You need 44 {item:2674} for {spell:2544} (90-130). It drops from {npc:830} (43%) in {zone:1436}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 22: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1436} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544}從90起為橙色（115黃、135綠、155灰）：做到130約需44次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。任何{skill:185}訓練師都會從技能75起以2銀教授它。爬行者遍佈{zone:1436}整條海岸。做到130，之後改用{spell:3376}。",

	-- Step 23: Smoked Bear Meat: shopping
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: shopping"] = "{item:6890}：採購",
	["The arrow picks the nearest vendor of your faction for each item."] = "箭頭會為每件物品指向你陣營最近的商人。",

	-- Step 24: Get Bear Meat
	-- {item:3173} Bear Meat
	["Get {item:3173}"] = "",
	-- {item:3173} Bear Meat · {item:6890} Smoked Bear Meat · {npc:1189} Black Bear Patriarch · {zone:1432} Loch Modan
	["You need 30 {item:3173} for {item:6890} (50-80). It drops from {npc:1189} (39%) in {zone:1432}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 25: Smoked Bear Meat (50-80)
	-- {item:6890} Smoked Bear Meat · {object:29784} Basic Campfire · {item:6892} Recipe: Smoked Bear Meat · {zone:1432} Loch Modan
	["{item:6890} is orange from 50 (yellow at 80, green at 100, grey at 120): about 30 crafts to 80. Cook at any fire: a town hearth or your own {object:29784}. {item:6892} costs 2s 50c at its vendor; the arrow picks the nearest one of your faction. Black bears roam the hills of {zone:1432}."] = "{item:6890}從50起為橙色（80黃、100綠、120灰）：做到80約需30次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。{item:6892}在商人處售價2銀50銅；箭頭會指向本陣營最近的一位。黑熊在{zone:1432}的丘陵遊蕩。",

	-- Step 26: Dry Pork Ribs: shopping
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: shopping"] = "{spell:2546}：採購",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2678} (1s 10c)."] = "箭頭會為每件物品指向本陣營最近的商人。你需要52個{item:2678}（1銀10銅）。",

	-- Step 27: Get Boar Ribs
	-- {item:2677} Boar Ribs
	["Get {item:2677}"] = "",
	-- {item:2677} Boar Ribs · {spell:2546} Dry Pork Ribs · {npc:1191} Mangy Mountain Boar · {zone:1432} Loch Modan
	["You need 52 {item:2677} for {spell:2546} (80-130). It drops from {npc:1191} (31%) in {zone:1432}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 28: Dry Pork Ribs (80-130)
	-- {spell:2546} Dry Pork Ribs · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1432} Loch Modan · {spell:3376} Curiously Tasty Omelet
	["{spell:2546} is orange from 80 (yellow at 120, green at 140, grey at 160): about 52 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 80 for 1s 50c. Mountain boars roam all of {zone:1432}. Cook it to 130, where {spell:3376} takes over."] = "{spell:2546}從80起為橙色（120黃、140綠、160灰）：做到130約需52次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。任何{skill:185}訓練師都會從技能80起以1銀50銅教授它。山地野豬遍佈{zone:1432}。做到130，之後改用{spell:3376}。",

	-- Step 29: Boiled Clams: shopping
	-- {item:5525} Boiled Clams
	["{item:5525}: shopping"] = "{item:5525}：採購",
	-- {item:159} Refreshing Spring Water
	["The arrow picks the nearest vendor of your faction for each item. You need 40 {item:159} (2s)."] = "箭頭會為每件物品指向本陣營最近的商人。你需要40個{item:159}（2銀）。",

	-- Step 30: Get Clam Meat
	-- {item:5503} Clam Meat
	["Get {item:5503}"] = "",
	-- {item:5503} Clam Meat · {item:5525} Boiled Clams · {npc:3812} Clattering Crawler · {npc:3814} Spined Crawler · {npc:3944} Wrathtail Priestess · {zone:1439} Darkshore
	-- plural, as words: Small Barnacled Clams = {item:5523} Small Barnacled Clam
	["You need 40 {item:5503} for {item:5525} (50-90). It comes in Small Barnacled Clams, which {npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) in {zone:1439} drop: open each one. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice."] = "",

	-- Step 31: Boiled Clams (50-90)
	-- {item:5525} Boiled Clams · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2674} Crawler Meat · {spell:2544} Crab Cake
	["{item:5525} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. The same coastal crawlers drop {item:2674} for {spell:2544} next: keep it."] = "{item:5525}從50起為橙色（90黃、110綠、130灰）：做到90約需40次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。任何{skill:185}訓練師都會從技能50起以1銀教授它。同樣的海岸爬行者還會掉落下一步{spell:2544}所需的{item:2674}：留著。",

	-- Step 33: Get Crawler Meat
	-- {item:2674} Crawler Meat · {spell:2544} Crab Cake · {npc:3814} Spined Crawler · {npc:3812} Clattering Crawler · {zone:1439} Darkshore
	["You need 44 {item:2674} for {spell:2544} (90-130). It drops from {npc:3814} (42%), {npc:3812} (40%) in {zone:1439}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 34: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1439} Darkshore · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1439} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544}從90起為橙色（115黃、135綠、155灰）：做到130約需44次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。任何{skill:185}訓練師都會從技能75起以2銀教授它。爬行者遍佈{zone:1439}整條海岸。做到130，之後改用{spell:3376}。",

	-- Step 35: Strider Stew: shopping
	-- {item:5477} Strider Stew
	["{item:5477}: shopping"] = "{item:5477}：購買",
	-- {item:4536} Shiny Red Apple
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:4536} (2s 75c)."] = "箭頭會為每件物品指向本陣營最近的商人。你需要52個{item:4536}（2銀75銅）。",

	-- Step 36: Get Strider Meat
	-- {item:5469} Strider Meat
	["Get {item:5469}"] = "",
	-- {item:5469} Strider Meat · {item:5477} Strider Stew · {npc:3246} Fleeting Plainstrider · {zone:1413} The Barrens
	["You need 52 {item:5469} for {item:5477} (50-100). It drops from {npc:3246} (32%) in {zone:1413}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 37: Strider Stew (50-100)
	-- {item:5477} Strider Stew · {object:29784} Basic Campfire · {item:5486} Recipe: Strider Stew
	["{item:5477} is orange from 50 (yellow at 90, green at 110, grey at 130): about 52 crafts to 100. Cook at any fire: a town hearth or your own {object:29784}. {item:5486} costs 4s 40c at its vendor; the arrow picks the nearest one of your faction."] = "{item:5477}從50起為橘色（90變黃，110變綠，130變灰）：製作約52次到100。在任何火堆旁都能烹飪：城鎮的爐火或你自己的{object:29784}。{item:5486}在商人處售價4銀40銅；箭頭會選擇你陣營最近的一位。",

	-- Step 38: Crispy Lizard Tail: shopping
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: shopping"] = "{item:5479}：購買",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 30 {item:2692} (12s)."] = "箭頭會為每件物品指向本陣營最近的商人。你需要30個{item:2692}（12銀）。",

	-- Step 39: Get Thunder Lizard Tail
	-- {item:5470} Thunder Lizard Tail
	["Get {item:5470}"] = "",
	-- {item:5470} Thunder Lizard Tail · {item:5479} Crispy Lizard Tail · {npc:3239} Thunderhead · {zone:1413} The Barrens
	["You need 30 {item:5470} for {item:5479} (100-130). It drops from {npc:3239} (59%), Owatanka (35%) in {zone:1413}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 40: Crispy Lizard Tail (100-130)
	-- {item:5479} Crispy Lizard Tail · {object:29784} Basic Campfire · {item:5488} Recipe: Crispy Lizard Tail · {npc:3489} Zargh · {item:3735} Recipe: Hot Lion Chops
	["{item:5479} is orange from 100 (yellow at 140, green at 160, grey at 180): about 30 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. {item:5488} costs 4s at its vendor; the arrow picks the nearest one of your faction. {npc:3489}, the butcher beside this vendor at the Crossroads, sells {item:3735} (18s), the recipe after Expert: buy it now."] = "{item:5479}從100起為橙色（140黃、160綠、180灰）：做到130約需30次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。{item:5488}在商人處售價4銀；箭頭會指向本陣營最近的一位。十字路口這位商人旁的屠夫{npc:3489}出售{item:3735}（18銀），即高階之後的配方：現在就買下。",

	-- Step 41: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "高級{skill:185}",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook
	["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072} (1g); the arrow picks its nearest seller for your faction. Buy it and read it."] = "高級{skill:185}將上限提高到225；需要技能125和角色等級20：它是一本書，{item:16072}（1金）；箭頭會指向你陣營最近的賣家。買下並閱讀。",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "購買並閱讀{item:16072}（高級{skill:185}）",

	-- Step 42: Curiously Tasty Omelet: shopping
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: shopping"] = "{spell:3376}：購買",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 46 {item:2692} (18s 40c)."] = "箭頭會為每件物品指向本陣營最近的商人。你需要46個{item:2692}（18銀40銅）。",

	-- Step 43: Get Raptor Egg
	-- {item:3685} Raptor Egg
	["Get {item:3685}"] = "",
	-- {item:3685} Raptor Egg · {spell:3376} Curiously Tasty Omelet · {npc:1018} Highland Razormaw · {npc:1019} Elder Razormaw · {zone:1437} Wetlands
	["You need 46 {item:3685} for {spell:3376} (130-175). It drops from {npc:1018} (72%), {npc:1019} (67%) in {zone:1437}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 44: Curiously Tasty Omelet (130-175)
	-- {spell:3376} Curiously Tasty Omelet · {object:29784} Basic Campfire · {item:3682} Recipe: Curiously Tasty Omelet · {zone:1437} Wetlands · {item:3685} Raptor Egg · {npc:340} Kendor Kabonka · {zone:1453} Stormwind
	["{spell:3376} is orange from 130 (yellow at 170, green at 190, grey at 210): about 46 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3682} costs 16s at its vendor; the arrow picks the nearest one of your faction. The raptors of the {zone:1437} drop a {item:3685} about two kills in three. {npc:340} in {zone:1453} sells the recipe."] = "{spell:3376}從130起為橙色（170黃、190綠、210灰）：做到175約需46次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。{item:3682}在商人處售價16銀；箭頭會指向本陣營最近的一位。{zone:1437}的迅猛龍約每三次擊殺掉一次{item:3685}。{zone:1453}的{npc:340}出售配方。",

	-- Step 45: Hot Lion Chops: shopping
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: shopping"] = "{spell:3398}：購買",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 45 {item:2692} (18s)."] = "箭頭會為每件物品指向本陣營最近的商人。你需要45個{item:2692}（18銀）。",

	-- Step 46: Get Lion Meat
	-- {item:3731} Lion Meat
	["Get {item:3731}"] = "",
	-- {item:3731} Lion Meat · {spell:3398} Hot Lion Chops · {npc:2384} Starving Mountain Lion · {zone:1424} Hillsbrad Foothills
	["You need 45 {item:3731} for {spell:3398} (130-175). It drops from {npc:2384} (42%) in {zone:1424}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 47: Hot Lion Chops (130-175)
	-- {spell:3398} Hot Lion Chops · {object:29784} Basic Campfire · {item:3735} Recipe: Hot Lion Chops · {item:3731} Lion Meat
	-- plural, as words: Hulking Mountain Lions = {npc:2407} Hulking Mountain Lion
	["{spell:3398} is orange from 130 (yellow at 175, green at 195, grey at 215): about 45 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3735} costs 18s at its vendor; the arrow picks the nearest one of your faction. The Feral and Hulking Mountain Lions of Hillsbrad Foothills drop {item:3731} more often than the Starving ones."] = "{spell:3398}從130起為橙色（175黃、195綠、215灰）：做到175約需45次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。{item:3735}在商人處售價18銀；箭頭會指向本陣營最近的一位。希爾斯布萊德丘陵的兇猛山地獅和魁梧山地獅比飢餓山地獅更常掉落{item:3731}。",

	-- Step 48: Roast Raptor: shopping
	-- {item:12210} Roast Raptor
	["{item:12210}: shopping"] = "{item:12210}：購買",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2692} (20s 80c)."] = "箭頭會為每件物品指向本陣營最近的商人。你需要52個{item:2692}（20銀80銅）。",

	-- Step 49: Get Raptor Flesh
	-- {item:12184} Raptor Flesh
	["Get {item:12184}"] = "",
	-- {item:12184} Raptor Flesh · {item:12210} Roast Raptor · {npc:2560} Highland Thrasher · {zone:1417} Arathi Highlands
	["You need 52 {item:12184} for {item:12210} (175-225). It drops from {npc:2560} (38%) in {zone:1417}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 50: Roast Raptor (175-225)
	-- {item:12210} Roast Raptor · {object:29784} Basic Campfire · {item:12228} Recipe: Roast Raptor · {zone:1417} Arathi Highlands · {npc:2810} Hammon Karwn · {area:320} Refuge Pointe · {npc:2821} Keena · {area:321} Hammerfall · {item:2692} Hot Spices · {item:17222} Spider Sausage · {item:12205} White Spider Meat
	["{item:12210} is orange from 175 (yellow at 215, green at 235, grey at 255): about 52 crafts to 225. Cook at any fire: a town hearth or your own {object:29784}. {item:12228} costs 50s at its vendor; the arrow picks the nearest one of your faction. {zone:1417}: {npc:2810} at {area:320} (Alliance) and {npc:2821} at {area:321} (Horde) sell the recipe and {item:2692} beside the raptors. {item:17222} (any trainer from 200, 40s) is the alternative, but it takes two {item:12205} a craft and Dustwallow's spiders drop one about two kills in five."] = "{item:12210}從175起為橙色（215黃、235綠、255灰）：做到225約需52次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。{item:12228}在商人處售價50銀；箭頭會指向本陣營最近的一位。{zone:1417}：{area:320}的{npc:2810}（聯盟）和{area:321}的{npc:2821}（部落）在迅猛龍旁出售配方和{item:2692}。替代品是{item:17222}（200點起任何訓練師可教，40銀），但每次需要兩個{item:12205}，而塵泥沼澤的蜘蛛約每五次擊殺掉落兩次。",

	-- Step 51: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "專家級{skill:185}由{area:976}（{zone:1446}）的{npc:8125}傳授。{zone:1455}的烹飪訓練師會派你去；需要技能225和等級35。",

	-- Step 52: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "專家級{skill:185}由{area:976}（{zone:1446}）的{npc:8125}傳授。{zone:1454}的烹飪訓練師會派你去；需要技能225和等級35。",

	-- Step 53: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "巨蛋",
	-- {quest:6610} Clamlette Surprise · {item:7974} Zesty Clam Meat · {item:8932} Alterac Swiss · {zone:1446} Tanaris · {zone:1425} The Hinterlands · {npc:2929} Savage Owlbeast · {item:12218} Monster Omelet
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["{quest:6610} asks for 12 Giant Eggs, 10 {item:7974} and 20 {item:8932}: bring all three before you go to {zone:1446}, so you make the trip once. Giant Eggs drop from the owlbeasts of {zone:1425}: {npc:2929} (54%). {item:12218} takes about 120 more after Artisan: farm them now too if you like."] = "{quest:6610}需要12枚巨型蛋、10個{item:7974}和20個{item:8932}：去{zone:1446}之前把三樣都備齊，這樣只需跑一趟。巨型蛋由{zone:1425}的梟獸掉落：{npc:2929}（54%）。大師級之後{item:12218}還需要約120個，願意的話也可以現在一起刷。",

	-- Step 54: Alterac Swiss
	-- {item:8932} Alterac Swiss
	["Innkeepers and food vendors sell {item:8932}; the arrow picks the nearest."] = "旅店老闆和食品商人都出售{item:8932}；箭頭會指向最近的一位。",

	-- Step 55: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {zone:1445} Dustwallow Marsh · {zone:1446} Tanaris
	-- plural, as words: Big-mouth Clams = {item:7973} Big-mouth Clam · Steeljaw Snappers = {npc:14123} Steeljaw Snapper
	["{item:7974} comes from Big-mouth Clams: open each one, every clam holds one. The Muckshell crabs on the {zone:1445} coast south-west of Theramore drop a clam about seven kills in ten, so ten clams take about fifteen kills, on your way to {zone:1446}. The Steeljaw Snappers on {zone:1446}'s east coast drop them about one kill in three."] = "{item:7974}來自大嘴蛤蜊：每個都要開啟，每隻蛤蜊裡都有一個。塞拉摩西南{zone:1445}海岸的泥殼蟹約每十次擊殺掉落七次蛤蜊，所以十個蛤蜊約需十五次擊殺，正好在去{zone:1446}的路上。{zone:1446}東海岸的鋼顎鉗嘴龜約每三次擊殺掉一次。",

	-- Step 56: Clamlette Surprise
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "專家級{skill:185}",

	-- Step 57: Monster Omelet: shopping
	-- {item:12218} Monster Omelet
	["{item:12218}: shopping"] = "{item:12218}：購買",
	-- {item:3713} Soothing Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 240 {item:3713} (3g 84s)."] = "箭頭會為每件物品指向本陣營最近的商人。你需要240個{item:3713}（3金84銀）。",

	-- Step 58: Get Giant Egg
	-- {item:12207} Giant Egg
	["Get {item:12207}"] = "",
	-- {item:12207} Giant Egg · {item:12218} Monster Omelet · {npc:2929} Savage Owlbeast · {zone:1425} The Hinterlands
	["You need 120 {item:12207} for {item:12218} (225-300). It drops from {npc:2929} (54%) in {zone:1425}. The arrow takes you to the best farm for your level: mobs at or below it first, then the most per minute and the nearest; it picks again as you level. The guide window shows the kills and minutes it takes there and a second choice. Or buy them at the Auction House."] = "",

	-- Step 59: Monster Omelet (225-300)
	-- {item:12218} Monster Omelet · {object:29784} Basic Campfire · {item:16110} Recipe: Monster Omelet · {item:13931} Nightfin Soup · {npc:8137} Gikkix · {area:977} Steamwheedle Port · {item:13932} Poached Sunscale Salmon · {item:279982} Iron Oven
	["{item:12218} is orange from 225 (yellow at 265, green at 285, grey at 305): about 120 crafts to 300. Cook at any fire: a town hearth or your own {object:29784}. {item:16110} costs 1g 20s at its vendor; the arrow picks the nearest one of your faction. {item:12218} is orange to 265 and green from 285, yet it still carries you to 300. Fishers can finish on {item:13931} ({npc:8137}, {area:977}; yellow to 310) instead; {item:13932} needs an {item:279982} on Forever."] = "{item:12218}從225起為橙色（265黃、285綠、305灰）：做到300約需120次。在任何火堆旁烹飪：城鎮爐火或你自己的{object:29784}。{item:16110}在商人處售價1金20銀；箭頭會指向本陣營最近的一位。{item:12218}到265仍是橙色、285起轉綠，但仍能一路帶到300。漁夫可以改用{item:13931}收尾（{npc:8137}，{area:977}；到310仍為黃色）；{item:13932}在Forever需要一個{item:279982}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5); the arrow picks the nearest."] = "你陣營的任何{skill:185}訓練師都能教初級{skill:185}（角色等級5）；箭頭會指向最近的一位。",
	-- ["Catch about 50 {item:6291} here by fishing (see the {skill:356} guide)."] = "在這裡釣約50條{item:6291}（見{skill:356}指南）。",
	-- ["Catch about 68 {item:6361} here by fishing (see the {skill:356} guide)."] = "在這裡釣約68條{item:6361}（見{skill:356}指南）。",
	-- ["Coyote (54%), {npc:833} (51%) in {zone:1436}, or wherever the arrow points"] = "{zone:1436}的山狗（54%）、{npc:833}（51%），或箭頭指向的地方",
	-- ["Giant Eggs drop from the Ironbeak owls of {zone:1448}."] = "巨蛋由{zone:1448}的鐵喙貓頭鷹掉落。",
	-- ["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction."] = "中級{skill:185}將上限提高到150；需要技能50和角色等級10：箭頭會指向你陣營最近的{skill:185}訓練師。",
	-- ["Prowler (86%) in {zone:1429}, or wherever the arrow points"] = "{zone:1429}的覓食的灰狼（86%），或箭頭指向的地方",
	-- ["Vuldren, {npc:250874} in Zephras Isle, or wherever the arrow points"] = "澤弗拉斯島的弗德飛狐、{npc:250874}，或箭頭指向的地方",
	-- ["What {item:12210} takes that the Auction House sells: 52 {item:12184}. The counts drop by what your bags, bank and mail hold."] = "{item:12210}所需的材料中，拍賣場有賣的：52個{item:12184}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What {item:12218} takes that the Auction House sells: 120 {item:12207}. The counts drop by what your bags, bank and mail hold."] = "{item:12218}所需的材料中，拍賣場有賣的：120個{item:12207}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What {item:5477} takes that the Auction House sells: 52 {item:5469}. The counts drop by what your bags, bank and mail hold."] = "{item:5477}所需的材料中，拍賣場有賣的：52個{item:5469}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What {item:5479} takes that the Auction House sells: 30 {item:5470}. The counts drop by what your bags, bank and mail hold."] = "{item:5479}所需的材料中，拍賣場有賣的：30個{item:5470}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What {item:6888} takes that the Auction House sells: 50 {item:6889}. The counts drop by what your bags, bank and mail hold."] = "{item:6888}所需的材料中，拍賣場有賣的：50個{item:6889}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What {item:6890} takes that the Auction House sells: 30 {item:3173}. The counts drop by what your bags, bank and mail hold."] = "{item:6890}所需的材料中，拍賣場有賣的：30個{item:3173}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What {spell:2538} takes that the Auction House sells: 50 {item:2672}. The counts drop by what your bags, bank and mail hold."] = "{spell:2538}所需的材料中，拍賣場有賣的：50個{item:2672}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What {spell:2540} takes that the Auction House sells: 50 {item:769}. The counts drop by what your bags, bank and mail hold."] = "{spell:2540}所需的材料中，拍賣場有賣的：50個{item:769}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What {spell:2541} takes that the Auction House sells: 40 {item:2673}. The counts drop by what your bags, bank and mail hold."] = "{spell:2541}所需的材料中，拍賣場有賣的：40個{item:2673}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What {spell:2544} takes that the Auction House sells: 44 {item:2674}. The counts drop by what your bags, bank and mail hold."] = "{spell:2544}所需的材料中，拍賣場有賣的：44個{item:2674}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What {spell:2546} takes that the Auction House sells: 52 {item:2677}. The counts drop by what your bags, bank and mail hold."] = "{spell:2546}所需的材料中，拍賣場有賣的：52個{item:2677}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What {spell:3376} takes that the Auction House sells: 46 {item:3685}. The counts drop by what your bags, bank and mail hold."] = "{spell:3376}所需的材料中，拍賣場有賣的：46個{item:3685}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["What {spell:3398} takes that the Auction House sells: 45 {item:3731}. The counts drop by what your bags, bank and mail hold."] = "{spell:3398}所需的材料中，拍賣場有賣的：45個{item:3731}。數量會扣除你背包、銀行和郵件中已有的。",
	-- ["{area:442} docks"] = "{area:442}碼頭",
	-- ["{area:702} docks"] = "{area:702}碼頭",
	-- ["{item:12210} is orange from 175 (yellow at 215, grey at 255): about 40 crafts to 215. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12210}從175起為橘色（215變黃，255變灰）：製作約40次到215。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{item:12210}: Auction House"] = "{item:12210}：拍賣場",
	-- ["{item:12210}: ingredients"] = "{item:12210}：材料",
	-- ["{item:12215} is orange from 215 (yellow at 240, grey at 280): about 10 crafts to 225. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215}從215起為橘色（240變黃，280變灰）：製作約10次到225。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{item:12215} is orange from 225 (yellow at 240, grey at 280): about 15 crafts to 240. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215}從225起為橘色（240變黃，280變灰）：製作約15次到240。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{item:12215}: ingredients"] = "{item:12215}：材料",
	-- ["{item:12215}: shopping"] = "{item:12215}：購買",
	-- ["{item:12218} is orange from 240 (yellow at 265, grey at 305): about 105 crafts to 300. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12218}從240起為橘色（265變黃，305變灰）：製作約105次到300。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{item:12218}: Auction House"] = "{item:12218}：拍賣場",
	-- ["{item:12218}: ingredients"] = "{item:12218}：材料",
	-- ["{item:5095} is orange from 50 (yellow at 90, grey at 130): about 68 crafts to 110. Cook at any fire: {object:29784} comes with {skill:185}. {skill:356} off the {area:442} docks catches {item:6361}."] = "{item:5095}從50起為橘色（90變黃，130變灰）：製作約68次到110。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。在{area:442}碼頭{skill:356}可釣到{item:6361}。",
	-- ["{item:5095}: ingredients"] = "{item:5095}：材料",
	-- ["{item:5095}: shopping"] = "{item:5095}：購買",
	-- ["{item:5477}: Auction House"] = "{item:5477}：拍賣場",
	-- ["{item:5477}: ingredients"] = "{item:5477}：材料",
	-- ["{item:5479} is orange from 100 (yellow at 140, grey at 180): about 25 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479}從100起為橘色（140變黃，180變灰）：製作約25次到125。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{item:5479} is orange from 125 (yellow at 140, grey at 180): about 15 crafts to 140. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479}從125起為橘色（140變黃，180變灰）：製作約15次到140。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{item:5479}: Auction House"] = "{item:5479}：拍賣場",
	-- ["{item:5479}: ingredients"] = "{item:5479}：材料",
	-- ["{item:5480} is orange from 110 (yellow at 150, grey at 190): about 15 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480}從110起為橘色（150變黃，190變灰）：製作約15次到125。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{item:5480} is orange from 125 (yellow at 150, grey at 190): about 25 crafts to 150. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480}從125起為橘色（150變黃，190變灰）：製作約25次到150。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{item:5480}: ingredients"] = "{item:5480}：材料",
	-- ["{item:5480}: shopping"] = "{item:5480}：購買",
	-- ["{item:5525}: ingredients"] = "{item:5525}：材料",
	-- ["{item:6290} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}. {item:6291} is the common catch in {zone:1438}'s waters."] = "{item:6290}從1起為橘色（45變黃，85變灰）：製作約50次到50。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。{item:6291}是{zone:1438}水域的常見漁獲。",
	-- ["{item:6290}: ingredients"] = "{item:6290}：材料",
	-- ["{item:6290}: shopping"] = "{item:6290}：購買",
	-- ["{item:6316} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:6316}從50起為橘色（90變黃，130變灰）：製作約52次到100。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{item:6316}: ingredients"] = "{item:6316}：材料",
	-- ["{item:6316}: shopping"] = "{item:6316}：購買",
	-- ["{item:6888}: Auction House"] = "{item:6888}：拍賣場",
	-- ["{item:6888}: ingredients"] = "{item:6888}：材料",
	-- ["{item:6890}: Auction House"] = "{item:6890}：拍賣場",
	-- ["{item:6890}: ingredients"] = "{item:6890}：材料",
	-- ["{item:724} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:724}從50起為橘色（90變黃，130變灰）：製作約52次到100。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{item:724}: ingredients"] = "{item:724}：材料",
	-- ["{item:724}: shopping"] = "{item:724}：購買",
	-- ["{item:7974} has no drop data: buy it at the Gadgetzan Auction House, next to {npc:8125}, or open clams looted from coastal creatures."] = "{item:7974}沒有掉落資料：在{npc:8125}旁邊的加基森拍賣場購買，或打開從海岸生物身上拾取的蚌殼。",
	-- ["{npc:1018} (72%), {npc:1019} (67%) in {zone:1437}, or wherever the arrow points"] = "{zone:1437}的{npc:1018}（72%）、{npc:1019}（67%），或箭頭指向的地方",
	-- ["{npc:1126} (36%), {npc:1125} (34%) in {zone:1426}, or wherever the arrow points"] = "{zone:1426}的{npc:1126}（36%）、{npc:1125}（34%），或箭頭指向的地方",
	-- ["{npc:1189} (39%) in {zone:1432}, or wherever the arrow points"] = "{zone:1432}的{npc:1189}（39%），或箭頭指向的地方",
	-- ["{npc:1191} (31%) in {zone:1432}, or wherever the arrow points"] = "{zone:1432}的{npc:1191}（31%），或箭頭指向的地方",
	-- ["{npc:1547} (72%), {npc:1548} (33%) in {zone:1420}, or wherever the arrow points"] = "{zone:1420}的{npc:1547}（72%）、{npc:1548}（33%），或箭頭指向的地方",
	-- ["{npc:1995} (58%) in {zone:1438}, or wherever the arrow points"] = "{zone:1438}的{npc:1995}（58%），或箭頭指向的地方",
	-- ["{npc:2384} (42%) in {zone:1424}, or wherever the arrow points"] = "{zone:1424}的{npc:2384}（42%），或箭頭指向的地方",
	-- ["{npc:250873} in Zephras Isle, or wherever the arrow points"] = "微風島的 {npc:250873}，或箭頭指向的地點。",
	-- ["{npc:2560} (38%) in {zone:1417}, or wherever the arrow points"] = "{zone:1417}的{npc:2560}（38%），或箭頭指向的任何地方",
	-- ["{npc:2929} (54%) in {zone:1425}, or wherever the arrow points"] = "{zone:1425}的{npc:2929}（54%），或箭頭指向的任何地方",
	-- ["{npc:2960} (82%), {npc:2959} (77%) in {zone:1412}, or wherever the arrow points"] = "{zone:1412}的{npc:2960}（82%）、{npc:2959}（77%），或箭頭指向的地方",
	-- ["{npc:3099} (99%) in {zone:1411}, or wherever the arrow points"] = "{zone:1411}的{npc:3099}（99%），或箭頭指向的地方",
	-- ["{npc:3239} (59%), Owatanka (35%) in {zone:1413}, or wherever the arrow points"] = "{zone:1413}的{npc:3239}（59%）、奧瓦坦卡（35%），或箭頭指向的地方",
	-- ["{npc:3246} (32%) in {zone:1413}, or wherever the arrow points"] = "{zone:1413}的{npc:3246}（32%），或箭頭指向的地方",
	-- ["{npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) in {zone:1439}, or wherever the arrow points; open each {item:5523} for its {item:5503}"] = "{zone:1439}的{npc:3812}（42%）、{npc:3814}（42%）、{npc:3944}（42%），或箭頭指向的任何地方；開啟每個{item:5523}獲取其中的{item:5503}",
	-- ["{npc:3814} (42%), {npc:3812} (40%) in {zone:1439}, or wherever the arrow points"] = "{zone:1439}的{npc:3814}（42%）、{npc:3812}（40%），或箭頭指向的地方",
	-- ["{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) in {zone:1443}, or wherever the arrow points"] = "{zone:1443}的{npc:4701}（55%）、{npc:4702}（54%）、{npc:4700}（40%），或箭頭指向的地方",
	-- ["{npc:830} (43%) in {zone:1436}, or wherever the arrow points"] = "{zone:1436}的{npc:830}（43%），或箭頭指向的地方",
	-- ["{npc:834} (54%), {npc:833} (51%) in {zone:1436}, or wherever the arrow points"] = "{zone:1436}的{npc:834}（54%）、{npc:833}（51%），或箭頭指向的地方",
	-- ["{quest:6610} asks for 20 {item:8932} (check the quest log); innkeepers and food vendors sell it, and the arrow picks the nearest."] = "{quest:6610}需要20個{item:8932}（查看任務日誌）；旅店老闆和食物商人有賣，箭頭會指向最近的一位。",
	-- ["{spell:2538}: Auction House"] = "{spell:2538}：拍賣場",
	-- ["{spell:2538}: ingredients"] = "{spell:2538}：材料",
	-- ["{spell:2540}: Auction House"] = "{spell:2540}：拍賣場",
	-- ["{spell:2540}: ingredients"] = "{spell:2540}：材料",
	-- ["{spell:2541}: Auction House"] = "{spell:2541}：拍賣場",
	-- ["{spell:2541}: ingredients"] = "{spell:2541}：材料",
	-- ["{spell:2544}: Auction House"] = "{spell:2544}：拍賣場",
	-- ["{spell:2544}: ingredients"] = "{spell:2544}：材料",
	-- ["{spell:2546}: Auction House"] = "{spell:2546}：拍賣場",
	-- ["{spell:2546}: ingredients"] = "{spell:2546}：材料",
	-- ["{spell:3370} is orange from 100 (yellow at 120, grey at 160): about 26 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370}從100起為橘色（120變黃，160變灰）：製作約26次到125。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{spell:3370} is yellow from 125 (yellow at 120, grey at 160): about 7 crafts to 130. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370}從125起為黃色（120變黃，160變灰）：製作約7次到130。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{spell:3370}: ingredients"] = "{spell:3370}：材料",
	-- ["{spell:3370}: shopping"] = "{spell:3370}：購買",
	-- ["{spell:3376} is orange from 130 (yellow at 170, grey at 210): about 46 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376}從130起為橘色（170變黃，210變灰）：製作約46次到175。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{spell:3376} is orange from 150 (yellow at 170, grey at 210): about 26 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376}從150起為橘色（170變黃，210變灰）：製作約26次到175。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{spell:3376}: Auction House"] = "{spell:3376}：拍賣場",
	-- ["{spell:3376}: ingredients"] = "{spell:3376}：材料",
	-- ["{spell:3398} is orange from 140 (yellow at 175, grey at 215): about 35 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3398}從140起為橘色（175變黃，215變灰）：製作約35次到175。在任何火堆旁都能烹飪：{object:29784}隨{skill:185}一起學會。",
	-- ["{spell:3398}: Auction House"] = "{spell:3398}：拍賣場",
	-- ["{spell:3398}: ingredients"] = "{spell:3398}：材料",
}
