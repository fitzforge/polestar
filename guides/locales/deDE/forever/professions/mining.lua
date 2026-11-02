-- German (deDE): the guide forever/professions/mining (forever/professions/mining.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Mining
	-- {skill:186} Mining
	["Learn {skill:186}"] = "{skill:186} erlernen",
	-- {skill:186} Mining · {item:2901} Mining Pick · {item:2770} Copper Ore · {item:2835} Rough Stone · {item:11584} Cactus Apple Surprise · {item:247840} Mining for Dummies · {item:277115} Apprentice's Mining Pack · {spell:1230161} Lodestone
	-- plural, as words: Poor Copper Veins = {object:562111} Poor Copper Vein
	["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} at any level (10c), and so does the Junior Mining Trainer in each starting area; the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it. Turn on Find Minerals (spellbook, General tab) so veins show on the minimap. Forever's starting areas also have Poor Copper Veins ({item:2770} and {item:2835}, from skill 1). The first-hour quest of each starting area (Rascally Rodents, Coldridge Valley Mail Delivery, The Woodland Protector, Galgar's {item:11584}, A Humble Task, Marla's Last Wish) offers {item:247840} as a reward: reading it gives 2 skill, up to 15. Trade goods vendors and the junior trainers sell the {item:277115}, a four-slot bag for ore and stone (25c). If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:186}: hand it in to the mining trainer it names once you reach skill 20, for the {spell:1230161} recipe."] = "",

	-- Step 2: Copper: Elwynn Forest (1-50)
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (1-50)"] = "Kupfervorkommen: {zone:1429} (1-50)",
	-- {skill:186} Mining
	["Mine every Copper (1, orange), Poor Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: Smelt Copper (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "",
	["Copper"] = "Kupfervorkommen",
	["Poor Copper"] = "",
	["Copper, Poor Copper"] = "",

	-- Step 3: Copper & Poor Copper: Dun Morogh (1-50)
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (1-50)"] = "",

	-- Step 4: Copper: Darkshore (1-50)
	-- {zone:1439} Darkshore
	["Copper: {zone:1439} (1-50)"] = "Kupfervorkommen: {zone:1439} (1-50)",
	-- {skill:186} Mining
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: Smelt Copper (orange to 25, grey at 70) gives points too. Zone level 10-20. Expect about 60 nodes for these 49 points."] = "",

	-- Step 5: Copper: Zephras Isle (1-50)
	-- {zone:2521} Zephras Isle
	["Copper: {zone:2521} (1-50)"] = "",
	-- {skill:186} Mining
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: Smelt Copper (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 60 nodes for these 49 points."] = "",

	-- Step 6: Copper & Poor Copper: Durotar (1-50)
	-- {zone:1411} Durotar
	["Copper & Poor Copper: {zone:1411} (1-50)"] = "",

	-- Step 7: Copper: Mulgore (1-50)
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (1-50)"] = "Kupfervorkommen: {zone:1412} (1-50)",
	-- {skill:186} Mining
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt at a forge when your bags fill: Smelt Copper (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 60 nodes for these 49 points."] = "",

	-- Step 8: Copper & Poor Copper: Tirisfal Glades (1-50)
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (1-50)"] = "",
	["Poor Copper, Copper"] = "",

	-- Step 9: Journeyman Mining
	-- {skill:186} Mining
	["Journeyman {skill:186}"] = "{skill:186} (Geselle)",
	-- {skill:186} Mining · {spell:1230161} Lodestone · {item:2835} Rough Stone · {item:2840} Copper Bar
	["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and no character level, and costs 5s: train it as soon as you reach 50. The arrow picks the nearest {skill:186} trainer of your faction. {spell:1230161}, Forever's camping item for {skill:186}, is taught from skill 20 (1s, or free from Camping 101: {skill:186}): a {item:2835} and a {item:2840} each, it gives points until 25; placed beside a campfire it gives everyone at the camp a buff for an hour."] = "",

	-- Step 10: Copper: Elwynn Forest (50-65) cont.
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (50-65) cont."] = "Kupfervorkommen: {zone:1429} (50-65), Fortsetzung",
	-- {skill:186} Mining
	["Mine every Copper (1, yellow), Poor Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: Smelt Copper (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "",

	-- Step 11: Copper & Poor Copper: Dun Morogh (50-65) cont.
	-- {zone:1426} Dun Morogh
	["Copper & Poor Copper: {zone:1426} (50-65) cont."] = "",

	-- Step 12: Copper: Darkshore (50-65) cont.
	-- {zone:1439} Darkshore
	["Copper: {zone:1439} (50-65) cont."] = "Kupfervorkommen: {zone:1439} (50-65), Fortsetzung",
	-- {skill:186} Mining
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: Smelt Copper (orange to 25, grey at 70) gives points too. Zone level 10-20. Expect about 80 nodes for these 15 points."] = "",

	-- Step 13: Copper: Zephras Isle (50-65) cont.
	-- {zone:2521} Zephras Isle
	["Copper: {zone:2521} (50-65) cont."] = "",
	-- {skill:186} Mining
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: Smelt Copper (orange to 25, grey at 70) gives points too. Zone level 1-15. Expect about 80 nodes for these 15 points."] = "",

	-- Step 14: Copper & Poor Copper: Durotar (50-65) cont.
	-- {zone:1411} Durotar
	["Copper & Poor Copper: {zone:1411} (50-65) cont."] = "",

	-- Step 15: Copper: Mulgore (50-65) cont.
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (50-65) cont."] = "Kupfervorkommen: {zone:1412} (50-65), Fortsetzung",
	-- {skill:186} Mining
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt at a forge when your bags fill: Smelt Copper (orange to 25, grey at 70) gives points too. Zone level 1-10. Expect about 80 nodes for these 15 points."] = "",

	-- Step 16: Copper & Poor Copper: Tirisfal Glades (50-65) cont.
	-- {zone:1420} Tirisfal Glades
	["Copper & Poor Copper: {zone:1420} (50-65) cont."] = "",

	-- Step 17: Smelt Bronze & Smelt Tin
	-- {skill:186} Mining · {spell:2659} Smelt Bronze · {spell:3304} Smelt Tin
	["At 65 a {skill:186} trainer teaches {spell:2659} (2s; grey at 115) and {spell:3304} (50c; grey at 75): smelting at a forge raises {skill:186} too, so smelt what you mine."] = "",

	-- Step 18: Incendicite & Tin: Wetlands (65-125)
	-- {zone:1437} Wetlands
	["Incendicite & Tin: {zone:1437} (65-125)"] = "",
	-- {skill:186} Mining · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar
	["Mine every Copper (1, green), Incendicite (65, orange), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: Smelt Copper (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 130 nodes for these 60 points. Smelt Silver (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",
	["Tin, Copper"] = "Zinnvorkommen, Kupfervorkommen",
	["Incendicite, Tin"] = "",

	-- Step 19: Tin: Ashenvale (65-125)
	-- {zone:1440} Ashenvale
	["Tin: {zone:1440} (65-125)"] = "",
	-- {skill:186} Mining · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: Smelt Copper (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 18-30. Expect about 130 nodes for these 60 points. Smelt Silver (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",
	["Tin, Silver"] = "Zinnvorkommen, Silbervorkommen",
	["Tin"] = "Zinnvorkommen",

	-- Step 20: Copper & Tin: The Barrens (65-125)
	-- {zone:1413} The Barrens
	["Copper & Tin: {zone:1413} (65-125)"] = "",
	-- {skill:186} Mining · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: Smelt Copper (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 10-25. Expect about 280 nodes for these 60 points. Smelt Silver (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",
	["Copper, Tin"] = "Kupfervorkommen, Zinnvorkommen",

	-- Step 21: Tin: Hillsbrad Foothills (65-125)
	-- {zone:1424} Hillsbrad Foothills
	["Tin: {zone:1424} (65-125)"] = "",
	-- {skill:186} Mining · {spell:3304} Smelt Tin · {spell:2659} Smelt Bronze · {item:2840} Copper Bar · {item:3576} Tin Bar
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75, rare) node you pass and circle the waypoints until {skill:186} 125. Smelt at a forge when your bags fill: Smelt Copper (orange to 25, grey at 70), {spell:3304} (grey at 75), {spell:2659} (grey at 115) give points too. {spell:2659} takes a {item:2840} and a {item:3576} each: keep bars from the smelts before it. Zone level 20-30. Expect about 140 nodes for these 60 points. Smelt Silver (2s; orange to 100, grey at 125) is taught from 75: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",

	-- Step 22: Expert Mining
	-- {skill:186} Mining
	["Expert {skill:186}"] = "{skill:186} (Experte)",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Expert {skill:186} raises the cap to 225; it needs skill 125 and no character level, and costs 50s: train it as soon as you reach 125. The arrow picks the nearest {skill:186} trainer of your faction. Learn {spell:3307} (5s; orange to 130, grey at 140) on the same visit: smelting at a forge raises {skill:186} too, so smelt what you mine."] = "",

	-- Step 23: Iron: Arathi Highlands (125-155)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (125-155)"] = "",
	-- {skill:186} Mining · {spell:3307} Smelt Iron
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt at a forge when your bags fill: {spell:3307} (orange to 130, grey at 140) gives points too. Zone level 30-40. Expect about 50 nodes for these 30 points."] = "",
	["Iron, Tin"] = "",
	["Lesser Bloodstone, Silver"] = "",

	-- Step 24: Iron: Arathi Highlands (155-175)
	-- {zone:1417} Arathi Highlands
	["Iron: {zone:1417} (155-175)"] = "",
	-- {skill:186} Mining
	["Mine every Tin (65, green), Lesser Bloodstone (75, green), Silver (75, green, rare), Iron (125, yellow), Gold (155, orange, rare) node you pass and circle the waypoints until {skill:186} 175. Smelt at a forge when your bags fill: Smelt Gold (orange to 170, grey at 185) gives points too. Zone level 30-40. Expect about 40 nodes for these 20 points. Smelt Gold (25s; orange to 170, grey at 185) is taught from 155: learn it if you pass a {skill:186} trainer, it is not worth a trip of its own."] = "",
	["Lesser Bloodstone, Gold"] = "",

	-- Step 25: Mithril: Badlands (175-200)
	-- {zone:1418} Badlands
	["Mithril: {zone:1418} (175-200)"] = "",
	-- {skill:186} Mining
	["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt at a forge when your bags fill: Smelt Gold (orange to 170, grey at 185) gives points too. Zone level 35-45. Expect about 40 nodes for these 25 points."] = "",
	["Iron, Mithril"] = "",

	-- Step 26: Artisan Mining
	-- {skill:186} Mining
	["Artisan {skill:186}"] = "{skill:186} (Fachmann)",
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
	-- ["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} (character level 5); the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it."] = "Jeder Lehrer für {skill:186} deiner Fraktion bringt dir {skill:186} (Lehrling) bei (Charakterstufe 5); der Pfeil wählt den nächsten. Kauf eine {item:2901} bei einem Handwerkswaren- oder Gemischtwarenhändler: Behalte sie in deinen Taschen, ohne sie kannst du nicht abbauen.",
	-- ["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} at any level, and so does the Junior Mining Trainer in each starting zone; the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it."] = "Jeder Lehrer für {skill:186} deiner Fraktion bringt dir auf jeder Stufe {skill:186} (Lehrling) bei, ebenso der Junior-Lehrer für Bergbau in jedem Startgebiet; der Pfeil wählt den nächsten. Kaufe {item:2901} bei einem Handelswarenhändler oder allgemeinen Händler: Behalte sie in deinen Taschen, ohne sie kannst du nicht schürfen.",
	-- ["Artisan {skill:186} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186} (Fachmann) hebt die Obergrenze auf 300; dafür brauchst du Fertigkeit 200 und Charakterstufe 35. Der Pfeil wählt den nächsten Lehrer für {skill:186} deiner Fraktion.",
	-- ["Copper, Silver"] = "Kupfervorkommen, Silbervorkommen",
	-- ["Copper: {zone:1411} (1-50)"] = "Kupfervorkommen: {zone:1411} (1-50)",
	-- ["Copper: {zone:1411} (50-65) cont."] = "Kupfervorkommen: {zone:1411} (50-65), Fortsetzung",
	-- ["Copper: {zone:1420} (1-50)"] = "Kupfervorkommen: {zone:1420} (1-50)",
	-- ["Copper: {zone:1420} (50-65) cont."] = "Kupfervorkommen: {zone:1420} (50-65), Fortsetzung",
	-- ["Copper: {zone:1426} (1-50)"] = "Kupfervorkommen: {zone:1426} (1-50)",
	-- ["Copper: {zone:1426} (50-65) cont."] = "Kupfervorkommen: {zone:1426} (50-65), Fortsetzung",
	-- ["Expert {skill:186} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186} (Experte) hebt die Obergrenze auf 225; dafür brauchst du Fertigkeit 125 und Charakterstufe 20. Der Pfeil wählt den nächsten Lehrer für {skill:186} deiner Fraktion.",
	-- ["Gold"] = "Goldvorkommen",
	-- ["Gold & Mithril: {zone:1435} (175-200)"] = "Goldvorkommen & Mithrilablagerung: {zone:1435} (175-200)",
	-- ["Gold & Mithril: {zone:1435} (200-230) cont."] = "Goldvorkommen & Mithrilablagerung: {zone:1435} (200-230), Fortsetzung",
	-- ["Gold, Iron"] = "Goldvorkommen, Eisenvorkommen",
	-- ["Gold, Mithril"] = "Goldvorkommen, Mithrilablagerung",
	-- ["Gold: {zone:1435} (155-175)"] = "Goldvorkommen: {zone:1435} (155-175)",
	-- ["Iron, Silver"] = "Eisenvorkommen, Silbervorkommen",
	-- ["Iron: {zone:1416} (125-155)"] = "Eisenvorkommen: {zone:1416} (125-155)",
	-- ["Iron: {zone:1431} (125-155)"] = "Eisenvorkommen: {zone:1431} (125-155)",
	-- ["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186} (Geselle) hebt die Obergrenze auf 150; dafür brauchst du Fertigkeit 50 und Charakterstufe 10. Der Pfeil wählt den nächsten Lehrer für {skill:186} deiner Fraktion.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Baue unterwegs jedes dieser Vorkommen ab: Kupfervorkommen (1, grün), Zinnvorkommen (65, orange), Silbervorkommen (ab 75). Lauf die Wegpunkte ab, bis {skill:186} 125 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 10-20.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-25."] = "Baue unterwegs jedes dieser Vorkommen ab: Kupfervorkommen (1, grün), Zinnvorkommen (65, orange), Silbervorkommen (ab 75). Lauf die Wegpunkte ab, bis {skill:186} 125 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 10-25.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 15-25."] = "Baue unterwegs jedes dieser Vorkommen ab: Kupfervorkommen (1, grün), Zinnvorkommen (65, orange), Silbervorkommen (ab 75). Lauf die Wegpunkte ab, bis {skill:186} 125 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 15-25.",
	-- ["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 20-30."] = "Baue unterwegs jedes dieser Vorkommen ab: Kupfervorkommen (1, grün), Zinnvorkommen (65, orange), Silbervorkommen (ab 75). Lauf die Wegpunkte ab, bis {skill:186} 125 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 20-30.",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "Baue unterwegs jedes dieser Vorkommen ab: Kupfervorkommen (1, orange). Lauf die Wegpunkte ab, bis {skill:186} 50 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 1-10.",
	-- ["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Baue unterwegs jedes dieser Vorkommen ab: Kupfervorkommen (1, orange). Lauf die Wegpunkte ab, bis {skill:186} 50 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 10-20.",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "Baue unterwegs jedes dieser Vorkommen ab: Kupfervorkommen (1, gelb). Lauf die Wegpunkte ab, bis {skill:186} 65 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 1-10.",
	-- ["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Baue unterwegs jedes dieser Vorkommen ab: Kupfervorkommen (1, gelb). Lauf die Wegpunkte ab, bis {skill:186} 65 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 10-20.",
	-- ["Mine every Gold (155, green), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 45-55."] = "Baue unterwegs jedes dieser Vorkommen ab: Goldvorkommen (155, grün), Mithrilablagerung (175, grün), Echtsilberablagerung (230, orange), Kleines Thoriumvorkommen (245, orange). Lauf die Wegpunkte ab, bis {skill:186} 275 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 45-55.",
	-- ["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 43-50."] = "Baue unterwegs jedes dieser Vorkommen ab: Goldvorkommen (155, grün), Mithrilablagerung (175, grün), {object:147516} (230, orange), Echtsilberablagerung (230, orange). Lauf die Wegpunkte ab, bis {skill:186} 245 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 43-50.",
	-- ["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Baue unterwegs jedes dieser Vorkommen ab: Eisenvorkommen (125, grün), Goldvorkommen (155, orange), Mithrilablagerung (175, orange). Lauf die Wegpunkte ab, bis {skill:186} 200 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 35-45.",
	-- ["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Baue unterwegs jedes dieser Vorkommen ab: Eisenvorkommen (125, grün), Goldvorkommen (155, gelb), Mithrilablagerung (175, gelb). Lauf die Wegpunkte ab, bis {skill:186} 230 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 35-45.",
	-- ["Mine every Silver (75, green), Iron (125, yellow), Gold (155, orange) node you pass and circle the waypoints until {skill:186} 175. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Baue unterwegs jedes dieser Vorkommen ab: Silbervorkommen (75, grün), Eisenvorkommen (125, gelb), Goldvorkommen (155, orange). Lauf die Wegpunkte ab, bis {skill:186} 175 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 35-45.",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 18-30."] = "Baue unterwegs jedes dieser Vorkommen ab: Zinnvorkommen (65, grün), Silbervorkommen (75, grün), Eisenvorkommen (125, orange). Lauf die Wegpunkte ab, bis {skill:186} 155 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 18-30.",
	-- ["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 30-40."] = "Baue unterwegs jedes dieser Vorkommen ab: Zinnvorkommen (65, grün), Silbervorkommen (75, grün), Eisenvorkommen (125, orange). Lauf die Wegpunkte ab, bis {skill:186} 155 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 30-40.",
	-- ["Mine every {object:147516} (230, yellow), Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 50-58."] = "Baue unterwegs jedes dieser Vorkommen ab: {object:147516} (230, gelb), Echtsilberablagerung (230, gelb), Kleines Thoriumvorkommen (245, gelb), Reiches Thoriumvorkommen (275, orange). Lauf die Wegpunkte ab, bis {skill:186} 300 erreicht ist. Schmilz das Erz an einer Schmiede, wenn deine Taschen voll sind: Auch Schmelzen steigert {skill:186}. Gebietsstufe 50-58.",
	-- ["Rich Thorium: {zone:1428} (275-300)"] = "Reiches Thoriumvorkommen: {zone:1428} (275-300)",
	-- ["Silver, Tin"] = "Silbervorkommen, Zinnvorkommen",
	-- ["Tin & Silver: {zone:1413} (65-125)"] = "Zinnvorkommen & Silbervorkommen: {zone:1413} (65-125)",
	-- ["Tin & Silver: {zone:1424} (65-125)"] = "Zinnvorkommen & Silbervorkommen: {zone:1424} (65-125)",
	-- ["Tin & Silver: {zone:1433} (65-125)"] = "Zinnvorkommen & Silbervorkommen: {zone:1433} (65-125)",
	-- ["Tin & Silver: {zone:1439} (65-125)"] = "Zinnvorkommen & Silbervorkommen: {zone:1439} (65-125)",
	-- ["Truesilver & Small Thorium: {zone:1419} (245-275)"] = "Echtsilberablagerung & Kleines Thoriumvorkommen: {zone:1419} (245-275)",
	-- ["Truesilver, {object:147516}"] = "Echtsilberablagerung, {object:147516}",
	-- ["{object:147516} & Truesilver: {zone:1427} (230-245)"] = "{object:147516} & Echtsilberablagerung: {zone:1427} (230-245)",
	-- ["{object:147516}, Gold"] = "{object:147516}, Goldvorkommen",
	-- ["{object:147516}, Rich Thorium"] = "{object:147516}, Reiches Thoriumvorkommen",
}
