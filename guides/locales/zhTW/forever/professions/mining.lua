-- Chinese (traditional) (zhTW): the guide forever/professions/mining (forever/professions/mining.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Mining
	-- {skill:186} Mining
	["Learn {skill:186}"] = "學習{skill:186}",
	-- {skill:186} Mining · {item:2901} Mining Pick · {spell:2580} Find Minerals · {item:2770} Copper Ore · {item:2835} Rough Stone · {item:11584} Cactus Apple Surprise · {item:247840} Mining for Dummies · {item:277115} Apprentice's Mining Pack · {spell:1230161} Lodestone
	-- plural, as words: Poor Copper Veins = {object:562111} Poor Copper Vein
	["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} at any level (10c), and so does the Junior Mining Trainer in each starting area; the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it. Turn on {spell:2580} (spellbook, General tab) so veins show on the minimap. Forever's starting areas also have Poor Copper Veins ({item:2770} and {item:2835}, from skill 1). The first-hour quest of each starting area (Rascally Rodents, Coldridge Valley Mail Delivery, The Woodland Protector, Galgar's {item:11584}, A Humble Task, Marla's Last Wish) offers {item:247840} as a reward: reading it gives 2 skill, up to 15. Trade goods vendors and the junior trainers sell the {item:277115}, a four-slot bag for ore and stone (25c). If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:186}: hand it in to the mining trainer it names once you reach skill 20, for the {spell:1230161} recipe."] = "",

	-- Step 2: Copper: Elwynn Forest (1-50)
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (1-50)"] = "銅礦：{zone:1429}（1-50）",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange), Poor Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "",
	["Copper"] = "銅礦",
	["Poor Copper"] = "",
	["Copper, Poor Copper"] = "",

	-- Step 3: Copper & Poor Copper: Dun Morogh (1-50)
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (1-50)"] = "",

	-- Step 4: Chunk of Amber & Large Chunk of Amber: Teldrassil (1-50)
	-- {object:656332} Chunk of Amber (no name in this language: may be words) · {object:656333} Large Chunk of Amber (no name in this language: may be words) · {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every {object:656332} (1, orange), {object:656333} (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "開採沿途經過的每一個琥珀塊（1，橙色）和大琥珀塊（1，橙色），並繞著路徑點循環，直到{skill:186}50。背包滿了就到熔爐熔煉：{spell:2657}（25之前為橙色，70變灰）也會提升技能。地區等級1-10。這49點預計要開採約60個礦點。",

	-- Step 5: Copper: Zephras Isle (1-50)
	-- {zone:2521} Zephras Isle
	["Copper: {zone:2521} (1-50)"] = "",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 60 nodes for these 49 points."] = "",

	-- Step 6: Copper & Poor Copper: Durotar (1-50)
	-- {zone:1411} Durotar
	["Copper & Poor Copper: {zone:1411} (1-50)"] = "",

	-- Step 7: Copper: Mulgore (1-50)
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (1-50)"] = "銅礦：{zone:1412}（1-50）",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange), Poor Copper (1, orange, rare) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "開採沿途經過的每一個銅礦（1，橙色）和貧瘠銅礦（1，橙色，稀有），並繞著路徑點循環，直到{skill:186}50。背包滿了就到熔爐熔煉：{spell:2657}（25之前為橙色，70變灰）也會提升技能。地區等級1-10。這49點預計要開採約60個礦點。",

	-- Step 8: Copper & Poor Copper: Tirisfal Glades (1-50)
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (1-50)"] = "",
	["Poor Copper, Copper"] = "",

	-- Step 9: Journeyman Mining
	-- {skill:186} Mining
	["Journeyman {skill:186}"] = "中級{skill:186}",
	-- {skill:186} Mining · {spell:1230161} Lodestone · {item:2835} Rough Stone · {item:2840} Copper Bar
	["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and no character level, and costs 5s: train it as soon as you reach 50. The arrow picks the nearest {skill:186} trainer of your faction. {spell:1230161}, Forever's camping item for {skill:186}, is taught from skill 20 (1s, or free from Camping 101: {skill:186}): a {item:2835} and a {item:2840} each, it gives points until 25; placed beside a campfire it gives everyone at the camp a buff for an hour."] = "",

	-- Step 10: Copper: Elwynn Forest (50-65) cont.
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (50-65) cont."] = "銅礦：{zone:1429}（50-65）（續）",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow), Poor Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "",

	-- Step 11: Copper & Poor Copper: Dun Morogh (50-65) cont.
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (50-65) cont."] = "",

	-- Step 12: Chunk of Amber & Large Chunk of Amber: Teldrassil (50-65) cont.
	-- {object:656332} Chunk of Amber (no name in this language: may be words) · {object:656333} Large Chunk of Amber (no name in this language: may be words) · {zone:1438} Teldrassil
	["{object:656332} & {object:656333}: {zone:1438} (50-65) cont."] = "琥珀塊和大琥珀塊：{zone:1438}（50-65）（續）",
	-- {object:656332} Chunk of Amber (no name in this language: may be words) · {object:656333} Large Chunk of Amber (no name in this language: may be words) · {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every {object:656332} (1, yellow), {object:656333} (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "開採沿途經過的每一個琥珀塊（1，黃色）和大琥珀塊（1，黃色），並繞著路徑點循環，直到{skill:186}65。背包滿了就到熔爐熔煉：{spell:2657}（25之前為橙色，70變灰）也會提升技能。地區等級1-10。這15點預計要開採約80個礦點。",

	-- Step 13: Copper: Zephras Isle (50-65) cont.
	-- {zone:2521} Zephras Isle
	["Copper: {zone:2521} (50-65) cont."] = "",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 80 nodes for these 15 points."] = "",

	-- Step 14: Copper & Poor Copper: Durotar (50-65) cont.
	-- {zone:1411} Durotar
	["Copper & Poor Copper: {zone:1411} (50-65) cont."] = "",

	-- Step 15: Copper: Mulgore (50-65) cont.
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (50-65) cont."] = "銅礦：{zone:1412}（50-65）（續）",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow), Poor Copper (1, yellow, rare) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "開採沿途經過的每一個銅礦（1，黃色）和貧瘠銅礦（1，黃色，稀有），並繞著路徑點循環，直到{skill:186}65。背包滿了就到熔爐熔煉：{spell:2657}（25之前為橙色，70變灰）也會提升技能。地區等級1-10。這15點預計要開採約80個礦點。",

	-- Step 16: Copper & Poor Copper: Tirisfal Glades (50-65) cont.
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (50-65) cont."] = "",

	-- Step 17: Smelt Bronze & Smelt Tin
	-- {skill:186} Mining · {spell:2659} Smelt Bronze · {spell:3304} Smelt Tin
	["At 65 a {skill:186} trainer teaches {spell:2659} (2s; grey at 115) and {spell:3304} (50c; grey at 75): smelting at a forge raises {skill:186} too, so smelt what you mine."] = "",

	-- Step 18: Incendicite & Tin: Wetlands (65-125)
	-- {zone:1437} Wetlands
	["Incendicite & Tin: {zone:1437} (65-125)"] = "",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Incendicite (65, orange), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",
	["Tin, Copper"] = "錫礦、銅礦",
	["Incendicite, Tin"] = "",

	-- Step 19: Tin: Ashenvale (65-125)
	-- {zone:1440} Ashenvale
	["Tin: {zone:1440} (65-125)"] = "",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 18-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",
	["Tin"] = "錫礦",

	-- Step 20: Copper & Tin: The Barrens (65-125)
	-- {zone:1413} The Barrens
	["Copper & Tin: {zone:1413} (65-125)"] = "",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 10-25. Expect about 280 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",
	["Copper, Tin"] = "銅礦、錫礦",

	-- Step 21: Tin: Hillsbrad Foothills (65-125)
	-- {zone:1424} Hillsbrad Foothills
	["Tin: {zone:1424} (65-125)"] = "",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 140 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",

	-- Step 22: Expert Mining
	-- {skill:186} Mining
	["Expert {skill:186}"] = "高級{skill:186}",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Expert {skill:186} raises the cap to 225; it needs skill 125 and no character level, and costs 50s: train it as soon as you reach 125. The arrow picks the nearest {skill:186} trainer of your faction. Learn {spell:3307} (5s; orange to 130, grey at 140) on the same visit: smelting at a forge raises {skill:186} too, so smelt what you mine."] = "",

	-- Step 23: Iron: Arathi Highlands (125-155)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (125-155)"] = "",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt at a forge when your bags fill: {spell:3307} (orange to 130, grey at 140) gives points too. Zone level 30-40. Expect about 50 nodes for these 30 points."] = "",
	["Iron, Tin"] = "",
	["Lesser Bloodstone"] = "次級血石",

	-- Step 24: Iron: Arathi Highlands (155-175)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (155-175)"] = "",
	-- {skill:186} Mining · {spell:3308} Smelt Gold
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, yellow), Gold (155, orange, rare) node you pass and circle the waypoints until {skill:186} 175. Smelt at a forge when your bags fill: {spell:3308} (orange to 170, grey at 185) gives points too. Zone level 30-40. Expect about 40 nodes for these 20 points. {spell:3308} (25s; orange to 170, grey at 185) is taught from 155: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",

	-- Step 25: Mithril: Badlands (175-200)
	-- {zone:1418} Badlands
	["Mithril: {zone:1418} (175-200)"] = "",
	-- {skill:186} Mining · {spell:3308} Smelt Gold
	["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt at a forge when your bags fill: {spell:3308} (orange to 170, grey at 185) gives points too. Zone level 35-45. Expect about 40 nodes for these 25 points."] = "",
	["Iron, Mithril"] = "",

	-- Step 26: Artisan Mining
	-- {skill:186} Mining
	["Artisan {skill:186}"] = "專家級{skill:186}",
	-- {skill:186} Mining
	["Artisan {skill:186} raises the cap to 300; it needs skill 200 and no character level, and costs 5g: train it as soon as you reach 200. The arrow picks the nearest {skill:186} trainer of your faction."] = "",

	-- Step 27: Mithril: Badlands (200-230) cont.
	-- {zone:1418} Badlands
	["Mithril: {zone:1418} (200-230) cont."] = "",
	-- {skill:186} Mining
	["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 35-45. Expect about 90 nodes for these 30 points."] = "",

	-- Step 28: Mithril & Dark Iron: Searing Gorge (230-245)
	-- {object:147516} Dark Iron · {zone:1427} Searing Gorge
	["Mithril & {object:147516}: {zone:1427} (230-245)"] = "",
	-- {object:147516} Dark Iron · {skill:186} Mining · {item:11099} Dark Iron Ore · {object:174824} Black Forge (no name in this language: may be words) · {area:1584} Blackrock Depths
	["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. {item:11099} smelts only at the {object:174824} in {area:1584} (8 ore a bar). Zone level 43-50. Expect about 40 nodes for these 15 points."] = "",
	-- {object:147516} Dark Iron
	["Mithril, {object:147516}"] = "",

	-- Step 29: Small Thorium: Felwood (245-275)
	-- {zone:1448} Felwood
	["Small Thorium: {zone:1448} (245-275)"] = "",
	-- {skill:186} Mining · {npc:9528} Arathandris Silversky · {npc:9529} Maybess Riverbreeze
	["Mine every Gold (155, green, rare), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Quests here that need {skill:186}: Salve via {skill:186} (level 55, {npc:9528}; Alliance), Salve via {skill:186} (level 55, {npc:9529}; Horde). Zone level 48-55. Expect about 50 nodes for these 30 points."] = "",
	["Mithril, Small Thorium"] = "",
	["Small Thorium, Truesilver"] = "",

	-- Step 30: Small Thorium & Rich Thorium: Winterspring (275-300)
	-- {zone:1452} Winterspring
	["Small Thorium & Rich Thorium: {zone:1452} (275-300)"] = "",
	-- {skill:186} Mining
	["Mine every Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore. Zone level 55-60. Expect about 40 nodes for these 25 points."] = "",
	["Rich Thorium, Small Thorium"] = "",
	["Rich Thorium, Truesilver"] = "",
	["Rich Thorium"] = "",
	["Small Thorium, Rich Thorium"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} (character level 5); the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it."] = "你陣營的任何{skill:186}訓練師都能教初級{skill:186}（角色等級5）；箭頭會指向最近的一位。向商業用品商或雜貨商購買{item:2901}：放在背包裡，沒有它就無法採礦。",
	-- ["Artisan {skill:186} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:186} trainer of your faction."] = "專家級{skill:186}將上限提高至300；需要技能200且角色等級35。箭頭會指向你陣營最近的{skill:186}訓練師。",
	-- ["Copper, Silver"] = "銅礦、銀礦",
	-- ["Copper: {zone:1411} (1-50)"] = "銅礦：{zone:1411}（1-50）",
	-- ["Copper: {zone:1411} (50-65) cont."] = "銅礦：{zone:1411}（50-65）（續）",
	-- ["Copper: {zone:1420} (1-50)"] = "銅礦：{zone:1420}（1-50）",
	-- ["Copper: {zone:1420} (50-65) cont."] = "銅礦：{zone:1420}（50-65）（續）",
	-- ["Copper: {zone:1426} (1-50)"] = "銅礦：{zone:1426}（1-50）",
	-- ["Copper: {zone:1426} (50-65) cont."] = "銅礦：{zone:1426}（50-65）（續）",
	-- ["Copper: {zone:1439} (1-50)"] = "銅礦：{zone:1439}（1-50）",
	-- ["Copper: {zone:1439} (50-65) cont."] = "銅礦：{zone:1439}（50-65）（續）",
	-- ["Expert {skill:186} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:186} trainer of your faction."] = "高級{skill:186}將上限提高至225；需要技能125且角色等級20。箭頭會指向你陣營最近的{skill:186}訓練師。",
	-- ["Gold"] = "金礦脈",
	-- ["Gold & Mithril: {zone:1435} (175-200)"] = "金礦脈與祕銀礦床：{zone:1435}（175-200）",
	-- ["Gold & Mithril: {zone:1435} (200-230) cont."] = "金礦脈與祕銀礦床：{zone:1435}（200-230）（續）",
	-- ["Gold, Iron"] = "金礦脈、鐵礦床",
	-- ["Gold, Mithril"] = "金礦脈、祕銀礦床",
	-- ["Gold: {zone:1435} (155-175)"] = "金礦脈：{zone:1435}（155-175）",
	-- ["Iron, Silver"] = "鐵礦床、銀礦",
	-- ["Iron: {zone:1416} (125-155)"] = "鐵礦床：{zone:1416}（125-155）",
	-- ["Iron: {zone:1431} (125-155)"] = "鐵礦床：{zone:1431}（125-155）",
	-- ["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:186} trainer of your faction."] = "中級{skill:186}將上限提高至150；需要技能50且角色等級10。箭頭會指向你陣營最近的{skill:186}訓練師。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "採集沿途經過的每一個銅礦（1，綠色）、錫礦（65，橙色）、銀礦（75起），並繞著路徑點循環，直到{skill:186}125。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級10-20。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-25."] = "採集沿途經過的每一個銅礦（1，綠色）、錫礦（65，橙色）、銀礦（75起），並繞著路徑點循環，直到{skill:186}125。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級10-25。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 15-25."] = "採集沿途經過的每一個銅礦（1，綠色）、錫礦（65，橙色）、銀礦（75起），並繞著路徑點循環，直到{skill:186}125。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級15-25。",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 20-30."] = "採集沿途經過的每一個銅礦（1，綠色）、錫礦（65，橙色）、銀礦（75起），並繞著路徑點循環，直到{skill:186}125。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級20-30。",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "採集沿途經過的每一個銅礦（1，橙色），並繞著路徑點循環，直到{skill:186}50。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級1-10。",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "採集沿途經過的每一個銅礦（1，橙色），並繞著路徑點循環，直到{skill:186}50。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級10-20。",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "採集沿途經過的每一個銅礦（1，黃色），並繞著路徑點循環，直到{skill:186}65。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級1-10。",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "採集沿途經過的每一個銅礦（1，黃色），並繞著路徑點循環，直到{skill:186}65。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級10-20。",
	-- ["Mine every Gold (155, green), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 45-55."] = "採集沿途經過的每一個金礦脈（155，綠色）、祕銀礦床（175，綠色）、真銀礦床（230，橙色）、瑟銀礦脈（245，橙色），並繞著路徑點循環，直到{skill:186}275。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級45-55。",
	-- ["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 43-50."] = "採集沿途經過的每一個金礦脈（155，綠色）、祕銀礦床（175，綠色）、{object:147516}（230，橙色）、真銀礦床（230，橙色），並繞著路徑點循環，直到{skill:186}245。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級43-50。",
	-- ["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "採集沿途經過的每一個鐵礦床（125，綠色）、金礦脈（155，橙色）、祕銀礦床（175，橙色），並繞著路徑點循環，直到{skill:186}200。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級35-45。",
	-- ["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "採集沿途經過的每一個鐵礦床（125，綠色）、金礦脈（155，黃色）、祕銀礦床（175，黃色），並繞著路徑點循環，直到{skill:186}230。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級35-45。",
	-- ["Mine every Silver (75, green), Iron (125, yellow), Gold (155, orange) node you pass and circle the waypoints until {skill:186} 175. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "採集沿途經過的每一個銀礦（75，綠色）、鐵礦床（125，黃色）、金礦脈（155，橙色），並繞著路徑點循環，直到{skill:186}175。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級35-45。",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 18-30."] = "採集沿途經過的每一個錫礦（65，綠色）、銀礦（75，綠色）、鐵礦床（125，橙色），並繞著路徑點循環，直到{skill:186}155。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級18-30。",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 30-40."] = "採集沿途經過的每一個錫礦（65，綠色）、銀礦（75，綠色）、鐵礦床（125，橙色），並繞著路徑點循環，直到{skill:186}155。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級30-40。",
	-- ["Mine every {object:147516} (230, yellow), Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 50-58."] = "採集沿途經過的每一個{object:147516}（230，黃色）、真銀礦床（230，黃色）、瑟銀礦脈（245，黃色）、富瑟銀礦（275，橙色），並繞著路徑點循環，直到{skill:186}300。背包滿了就到熔爐熔煉礦石：熔煉也會提升{skill:186}。地區等級50-58。",
	-- ["Rich Thorium: {zone:1428} (275-300)"] = "富瑟銀礦：{zone:1428}（275-300）",
	-- ["Silver, Tin"] = "銀礦、錫礦",
	-- ["Tin & Silver: {zone:1413} (65-125)"] = "錫礦與銀礦：{zone:1413}（65-125）",
	-- ["Tin & Silver: {zone:1424} (65-125)"] = "錫礦與銀礦：{zone:1424}（65-125）",
	-- ["Tin & Silver: {zone:1433} (65-125)"] = "錫礦與銀礦：{zone:1433}（65-125）",
	-- ["Tin & Silver: {zone:1439} (65-125)"] = "錫礦與銀礦：{zone:1439}（65-125）",
	-- ["Tin, Silver"] = "錫礦、銀礦",
	-- ["Truesilver & Small Thorium: {zone:1419} (245-275)"] = "真銀礦床與瑟銀礦脈：{zone:1419}（245-275）",
	-- ["Truesilver, {object:147516}"] = "真銀礦床、{object:147516}",
	-- ["{object:147516} & Truesilver: {zone:1427} (230-245)"] = "{object:147516}與真銀礦床：{zone:1427}（230-245）",
	-- ["{object:147516}, Gold"] = "{object:147516}、金礦脈",
	-- ["{object:147516}, Rich Thorium"] = "{object:147516}、富瑟銀礦",
}
