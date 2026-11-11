-- Korean (koKR): the guide forever/professions/mining (forever/professions/mining.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Mining
	-- {skill:186} Mining
	["Learn {skill:186}"] = "{skill:186} 배우기",
	-- {skill:186} Mining · {item:2901} Mining Pick · {spell:2580} Find Minerals · {item:2770} Copper Ore · {item:2835} Rough Stone · {item:11584} Cactus Apple Surprise · {item:247840} Mining for Dummies · {item:277115} Apprentice's Mining Pack · {spell:1230161} Lodestone
	-- plural, as words: Poor Copper Veins = {object:562111} Poor Copper Vein
	["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} at any level (10c), and so does the Junior Mining Trainer in each starting area; the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it. Turn on {spell:2580} (spellbook, General tab) so veins show on the minimap. Forever's starting areas also have Poor Copper Veins ({item:2770} and {item:2835}, from skill 1). The first-hour quest of each starting area (Rascally Rodents, Coldridge Valley Mail Delivery, The Woodland Protector, Galgar's {item:11584}, A Humble Task, Marla's Last Wish) offers {item:247840} as a reward: reading it gives 2 skill, up to 15. Trade goods vendors and the junior trainers sell the {item:277115}, a four-slot bag for ore and stone (25c). If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:186}: hand it in to the mining trainer it names once you reach skill 20, for the {spell:1230161} recipe."] = "",

	-- Step 2: Copper: Elwynn Forest (1-50)
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (1-50)"] = "구리: {zone:1429} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange), Poor Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "",
	["Copper"] = "구리",
	["Poor Copper"] = "",
	["Copper, Poor Copper"] = "",

	-- Step 3: Copper & Poor Copper: Dun Morogh (1-50)
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (1-50)"] = "",

	-- Step 4: Chunk of Amber & Large Chunk of Amber: Teldrassil (1-50)
	-- {object:656332} Chunk of Amber · {object:656333} Large Chunk of Amber · {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every {object:656332} (1, orange), {object:656333} (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "",

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
	["Copper: {zone:1412} (1-50)"] = "구리: {zone:1412} (1-50)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, orange), Poor Copper (1, orange, rare) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "",

	-- Step 8: Copper & Poor Copper: Tirisfal Glades (1-50)
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (1-50)"] = "",
	["Poor Copper, Copper"] = "",

	-- Step 9: Journeyman Mining
	-- {skill:186} Mining
	["Journeyman {skill:186}"] = "수습 {skill:186}",
	-- {skill:186} Mining · {spell:1230161} Lodestone · {item:2835} Rough Stone · {item:2840} Copper Bar
	["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and no character level, and costs 5s: train it as soon as you reach 50. The arrow picks the nearest {skill:186} trainer of your faction. {spell:1230161}, Forever's camping item for {skill:186}, is taught from skill 20 (1s, or free from Camping 101: {skill:186}): a {item:2835} and a {item:2840} each, it gives points until 25; placed beside a campfire it gives everyone at the camp a buff for an hour."] = "",

	-- Step 10: Copper: Elwynn Forest (50-65) cont.
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (50-65) cont."] = "구리: {zone:1429} (50-65) (계속)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow), Poor Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "",

	-- Step 11: Copper & Poor Copper: Dun Morogh (50-65) cont.
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (50-65) cont."] = "",

	-- Step 12: Chunk of Amber & Large Chunk of Amber: Teldrassil (50-65) cont.
	-- {object:656332} Chunk of Amber · {object:656333} Large Chunk of Amber · {zone:1438} Teldrassil
	["{object:656332} & {object:656333}: {zone:1438} (50-65) cont."] = "",
	-- {object:656332} Chunk of Amber · {object:656333} Large Chunk of Amber · {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every {object:656332} (1, yellow), {object:656333} (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "",

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
	["Copper: {zone:1412} (50-65) cont."] = "구리: {zone:1412} (50-65) (계속)",
	-- {skill:186} Mining · {spell:2657} Smelt Copper
	["Mine every Copper (1, yellow), Poor Copper (1, yellow, rare) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "",

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
	["Tin, Copper"] = "주석, 구리",
	["Incendicite, Tin"] = "",

	-- Step 19: Tin: Ashenvale (65-125)
	-- {zone:1440} Ashenvale
	["Tin: {zone:1440} (65-125)"] = "",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 18-30. Expect about 130 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",
	["Tin"] = "주석",

	-- Step 20: Copper & Tin: The Barrens (65-125)
	-- {zone:1413} The Barrens
	["Copper & Tin: {zone:1413} (65-125)"] = "",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 10-25. Expect about 280 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",
	["Copper, Tin"] = "구리, 주석",

	-- Step 21: Tin: Hillsbrad Foothills (65-125)
	-- {zone:1424} Hillsbrad Foothills
	["Tin: {zone:1424} (65-125)"] = "",
	-- {skill:186} Mining · {spell:2657} Smelt Copper · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar · {spell:2658} Smelt Silver
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: {spell:2657} (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 140 nodes for these 60 points. {spell:2658} (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",

	-- Step 22: Expert Mining
	-- {skill:186} Mining
	["Expert {skill:186}"] = "숙련 {skill:186}",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Expert {skill:186} raises the cap to 225; it needs skill 125 and no character level, and costs 50s: train it as soon as you reach 125. The arrow picks the nearest {skill:186} trainer of your faction. Learn {spell:3307} (5s; orange to 130, grey at 140) on the same visit: smelting at a forge raises {skill:186} too, so smelt what you mine."] = "",

	-- Step 23: Iron: Arathi Highlands (125-155)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (125-155)"] = "",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt at a forge when your bags fill: {spell:3307} (orange to 130, grey at 140) gives points too. Zone level 30-40. Expect about 50 nodes for these 30 points."] = "",
	["Iron, Tin"] = "",
	["Lesser Bloodstone"] = "",

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
	["Artisan {skill:186}"] = "전문 {skill:186}",
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
	-- ["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} (character level 5); the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it."] = "진영의 {skill:186} 상급자 누구에게서나 초급 {skill:186}을(를) 배울 수 있습니다(캐릭터 레벨 5). 화살표가 가장 가까운 상급자를 가리킵니다. 직업용품 상인이나 잡화 상인에게서 {item:2901}을(를) 사서 가방에 넣어 두세요. 없으면 채광할 수 없습니다.",
	-- ["Artisan {skill:186} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:186} trainer of your faction."] = "전문 {skill:186}은(는) 최대 숙련도를 300(으)로 올립니다. 숙련도 200, 캐릭터 레벨 35이(가) 필요합니다. 화살표는 진영의 가장 가까운 {skill:186} 상급자를 가리킵니다.",
	-- ["Copper, Silver"] = "구리, 은",
	-- ["Copper: {zone:1411} (1-50)"] = "구리: {zone:1411} (1-50)",
	-- ["Copper: {zone:1411} (50-65) cont."] = "구리: {zone:1411} (50-65) (계속)",
	-- ["Copper: {zone:1420} (1-50)"] = "구리: {zone:1420} (1-50)",
	-- ["Copper: {zone:1420} (50-65) cont."] = "구리: {zone:1420} (50-65) (계속)",
	-- ["Copper: {zone:1426} (1-50)"] = "구리: {zone:1426} (1-50)",
	-- ["Copper: {zone:1426} (50-65) cont."] = "구리: {zone:1426} (50-65) (계속)",
	-- ["Copper: {zone:1439} (1-50)"] = "구리: {zone:1439} (1-50)",
	-- ["Copper: {zone:1439} (50-65) cont."] = "구리: {zone:1439} (50-65) (계속)",
	-- ["Expert {skill:186} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:186} trainer of your faction."] = "숙련 {skill:186}은(는) 최대 숙련도를 225(으)로 올립니다. 숙련도 125, 캐릭터 레벨 20이(가) 필요합니다. 화살표는 진영의 가장 가까운 {skill:186} 상급자를 가리킵니다.",
	-- ["Gold"] = "금",
	-- ["Gold & Mithril: {zone:1435} (175-200)"] = "금 및 미스릴: {zone:1435} (175-200)",
	-- ["Gold & Mithril: {zone:1435} (200-230) cont."] = "금 및 미스릴: {zone:1435} (200-230) (계속)",
	-- ["Gold, Iron"] = "금, 철",
	-- ["Gold, Mithril"] = "금, 미스릴",
	-- ["Gold: {zone:1435} (155-175)"] = "금: {zone:1435} (155-175)",
	-- ["Iron, Silver"] = "철, 은",
	-- ["Iron: {zone:1416} (125-155)"] = "철: {zone:1416} (125-155)",
	-- ["Iron: {zone:1431} (125-155)"] = "철: {zone:1431} (125-155)",
	-- ["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:186} trainer of your faction."] = "수습 {skill:186}은(는) 최대 숙련도를 150(으)로 올립니다. 숙련도 50, 캐릭터 레벨 10이(가) 필요합니다. 화살표는 진영의 가장 가까운 {skill:186} 상급자를 가리킵니다.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "지나가는 구리(1, 초록색), 주석(65, 주황색), 은(75부터) 광맥을 모두 캐고, {skill:186} 125까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 10-20.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-25."] = "지나가는 구리(1, 초록색), 주석(65, 주황색), 은(75부터) 광맥을 모두 캐고, {skill:186} 125까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 10-25.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 15-25."] = "지나가는 구리(1, 초록색), 주석(65, 주황색), 은(75부터) 광맥을 모두 캐고, {skill:186} 125까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 15-25.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 20-30."] = "지나가는 구리(1, 초록색), 주석(65, 주황색), 은(75부터) 광맥을 모두 캐고, {skill:186} 125까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 20-30.",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "지나가는 구리(1, 주황색) 광맥을 모두 캐고, {skill:186} 50까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 1-10.",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "지나가는 구리(1, 주황색) 광맥을 모두 캐고, {skill:186} 50까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 10-20.",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "지나가는 구리(1, 노란색) 광맥을 모두 캐고, {skill:186} 65까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 1-10.",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "지나가는 구리(1, 노란색) 광맥을 모두 캐고, {skill:186} 65까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 10-20.",
	-- ["Mine every Gold (155, green), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 45-55."] = "지나가는 금(155, 초록색), 미스릴(175, 초록색), 진은(230, 주황색), 작은 토륨(245, 주황색) 광맥을 모두 캐고, {skill:186} 275까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 45-55.",
	-- ["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 43-50."] = "지나가는 금(155, 초록색), 미스릴(175, 초록색), {object:147516}(230, 주황색), 진은(230, 주황색) 광맥을 모두 캐고, {skill:186} 245까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 43-50.",
	-- ["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "지나가는 철(125, 초록색), 금(155, 주황색), 미스릴(175, 주황색) 광맥을 모두 캐고, {skill:186} 200까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 35-45.",
	-- ["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "지나가는 철(125, 초록색), 금(155, 노란색), 미스릴(175, 노란색) 광맥을 모두 캐고, {skill:186} 230까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 35-45.",
	-- ["Mine every Silver (75, green), Iron (125, yellow), Gold (155, orange) node you pass and circle the waypoints until {skill:186} 175. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "지나가는 은(75, 초록색), 철(125, 노란색), 금(155, 주황색) 광맥을 모두 캐고, {skill:186} 175까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 35-45.",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 18-30."] = "지나가는 주석(65, 초록색), 은(75, 초록색), 철(125, 주황색) 광맥을 모두 캐고, {skill:186} 155까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 18-30.",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 30-40."] = "지나가는 주석(65, 초록색), 은(75, 초록색), 철(125, 주황색) 광맥을 모두 캐고, {skill:186} 155까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 30-40.",
	-- ["Mine every {object:147516} (230, yellow), Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 50-58."] = "지나가는 {object:147516}(230, 노란색), 진은(230, 노란색), 작은 토륨(245, 노란색), 풍부한 토륨(275, 주황색) 광맥을 모두 캐고, {skill:186} 300까지 경유지를 도세요. 가방이 차면 제련소에서 광석을 제련하세요. 제련도 {skill:186}을(를) 올립니다. 지역 레벨 50-58.",
	-- ["Rich Thorium: {zone:1428} (275-300)"] = "풍부한 토륨: {zone:1428} (275-300)",
	-- ["Silver, Tin"] = "은, 주석",
	-- ["Tin & Silver: {zone:1413} (65-125)"] = "주석 및 은: {zone:1413} (65-125)",
	-- ["Tin & Silver: {zone:1424} (65-125)"] = "주석 및 은: {zone:1424} (65-125)",
	-- ["Tin & Silver: {zone:1433} (65-125)"] = "주석 및 은: {zone:1433} (65-125)",
	-- ["Tin & Silver: {zone:1439} (65-125)"] = "주석 및 은: {zone:1439} (65-125)",
	-- ["Tin, Silver"] = "주석, 은",
	-- ["Truesilver & Small Thorium: {zone:1419} (245-275)"] = "진은 및 작은 토륨: {zone:1419} (245-275)",
	-- ["Truesilver, {object:147516}"] = "진은, {object:147516}",
	-- ["{object:147516} & Truesilver: {zone:1427} (230-245)"] = "{object:147516} 및 진은: {zone:1427} (230-245)",
	-- ["{object:147516}, Gold"] = "{object:147516}, 금",
	-- ["{object:147516}, Rich Thorium"] = "{object:147516}, 풍부한 토륨",
}
