-- Russian (ruRU): the guide forever/professions/mining (forever/professions/mining.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Mining
	-- {skill:186} Mining
	["Learn {skill:186}"] = "Изучите: {skill:186}",
	-- {skill:186} Mining · {item:2901} Mining Pick
	["Any {skill:186} trainer of your faction teaches Apprentice {skill:186} (character level 5); the arrow picks the nearest. Buy a {item:2901} from a trade goods or general vendor: keep it in your bags, you cannot mine without it."] = "Любой учитель вашей фракции ({skill:186}) обучает навыку {skill:186}, ранг «Ученик» (уровень персонажа 5); стрелка ведет к ближайшему. Купите у торговца товарами или припасами: {item:2901} – и держите в сумке, без нее добывать руду нельзя.",

	-- Step 2: Copper: Elwynn Forest (1-50)
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (1-50)"] = "Медная жила: {zone:1429} (1-50)",
	-- {skill:186} Mining
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "Добывайте по пути: Медная жила (1, оранжевый) – и обходите точки маршрута, пока {skill:186} не достигнет 50. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 1-10.",
	["Copper"] = "Медная жила",

	-- Step 3: Copper: Dun Morogh (1-50)
	-- {zone:1426} Dun Morogh
	["Copper: {zone:1426} (1-50)"] = "Медная жила: {zone:1426} (1-50)",

	-- Step 4: Copper: Darkshore (1-50)
	-- {zone:1439} Darkshore
	["Copper: {zone:1439} (1-50)"] = "Медная жила: {zone:1439} (1-50)",
	-- {skill:186} Mining
	["Mine every Copper (1, orange) node you pass and circle the waypoints until {skill:186} 50. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Добывайте по пути: Медная жила (1, оранжевый) – и обходите точки маршрута, пока {skill:186} не достигнет 50. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 10-20.",

	-- Step 5: Copper: Durotar (1-50)
	-- {zone:1411} Durotar
	["Copper: {zone:1411} (1-50)"] = "Медная жила: {zone:1411} (1-50)",

	-- Step 6: Copper: Mulgore (1-50)
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (1-50)"] = "Медная жила: {zone:1412} (1-50)",

	-- Step 7: Copper: Tirisfal Glades (1-50)
	-- {zone:1420} Tirisfal Glades
	["Copper: {zone:1420} (1-50)"] = "Медная жила: {zone:1420} (1-50)",

	-- Step 8: Journeyman Mining
	-- {skill:186} Mining
	["Journeyman {skill:186}"] = "{skill:186}: Подмастерье",
	-- {skill:186} Mining
	["Journeyman {skill:186} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186}, ранг «Подмастерье»: предел 150; нужен навык 50 и уровень персонажа 10. Стрелка ведет к ближайшему учителю вашей фракции ({skill:186}).",

	-- Step 9: Copper: Elwynn Forest (50-65) cont.
	-- {zone:1429} Elwynn Forest
	["Copper: {zone:1429} (50-65) cont."] = "Медная жила: {zone:1429} (50-65), продолжение",
	-- {skill:186} Mining
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 1-10."] = "Добывайте по пути: Медная жила (1, желтый) – и обходите точки маршрута, пока {skill:186} не достигнет 65. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 1-10.",

	-- Step 10: Copper: Dun Morogh (50-65) cont.
	-- {zone:1426} Dun Morogh
	["Copper: {zone:1426} (50-65) cont."] = "Медная жила: {zone:1426} (50-65), продолжение",

	-- Step 11: Copper: Darkshore (50-65) cont.
	-- {zone:1439} Darkshore
	["Copper: {zone:1439} (50-65) cont."] = "Медная жила: {zone:1439} (50-65), продолжение",
	-- {skill:186} Mining
	["Mine every Copper (1, yellow) node you pass and circle the waypoints until {skill:186} 65. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Добывайте по пути: Медная жила (1, желтый) – и обходите точки маршрута, пока {skill:186} не достигнет 65. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 10-20.",

	-- Step 12: Copper: Durotar (50-65) cont.
	-- {zone:1411} Durotar
	["Copper: {zone:1411} (50-65) cont."] = "Медная жила: {zone:1411} (50-65), продолжение",

	-- Step 13: Copper: Mulgore (50-65) cont.
	-- {zone:1412} Mulgore
	["Copper: {zone:1412} (50-65) cont."] = "Медная жила: {zone:1412} (50-65), продолжение",

	-- Step 14: Copper: Tirisfal Glades (50-65) cont.
	-- {zone:1420} Tirisfal Glades
	["Copper: {zone:1420} (50-65) cont."] = "Медная жила: {zone:1420} (50-65), продолжение",

	-- Step 15: Tin & Silver: Redridge Mountains (65-125)
	-- {zone:1433} Redridge Mountains
	["Tin & Silver: {zone:1433} (65-125)"] = "Оловянная и серебряная жилы: {zone:1433} (65-125)",
	-- {skill:186} Mining
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 15-25."] = "Добывайте по пути: Медная жила (1, зеленый), оловянная жила (65, оранжевый), серебряная жила (с 75) – и обходите точки маршрута, пока {skill:186} не достигнет 125. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 15-25.",
	["Copper, Silver"] = "Медная жила, серебряная жила",
	["Copper, Tin"] = "Медная жила, оловянная жила",

	-- Step 16: Tin & Silver: Darkshore (65-125)
	-- {zone:1439} Darkshore
	["Tin & Silver: {zone:1439} (65-125)"] = "Оловянная и серебряная жилы: {zone:1439} (65-125)",
	-- {skill:186} Mining
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-20."] = "Добывайте по пути: Медная жила (1, зеленый), оловянная жила (65, оранжевый), серебряная жила (с 75) – и обходите точки маршрута, пока {skill:186} не достигнет 125. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 10-20.",
	["Tin"] = "Оловянная жила",
	["Tin, Silver"] = "Оловянная жила, серебряная жила",
	["Tin, Copper"] = "Оловянная жила, медная жила",

	-- Step 17: Tin & Silver: The Barrens (65-125)
	-- {zone:1413} The Barrens
	["Tin & Silver: {zone:1413} (65-125)"] = "Оловянная и серебряная жилы: {zone:1413} (65-125)",
	-- {skill:186} Mining
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 10-25."] = "Добывайте по пути: Медная жила (1, зеленый), оловянная жила (65, оранжевый), серебряная жила (с 75) – и обходите точки маршрута, пока {skill:186} не достигнет 125. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 10-25.",
	["Silver, Tin"] = "Серебряная жила, оловянная жила",

	-- Step 18: Tin & Silver: Hillsbrad Foothills (65-125)
	-- {zone:1424} Hillsbrad Foothills
	["Tin & Silver: {zone:1424} (65-125)"] = "Оловянная и серебряная жилы: {zone:1424} (65-125)",
	-- {skill:186} Mining
	["Mine every Copper (1, green), Tin (65, orange), Silver (from 75) node you pass and circle the waypoints until {skill:186} 125. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 20-30."] = "Добывайте по пути: Медная жила (1, зеленый), оловянная жила (65, оранжевый), серебряная жила (с 75) – и обходите точки маршрута, пока {skill:186} не достигнет 125. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 20-30.",

	-- Step 19: Expert Mining
	-- {skill:186} Mining
	["Expert {skill:186}"] = "{skill:186}: Умелец",
	-- {skill:186} Mining
	["Expert {skill:186} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186}, ранг «Умелец»: предел 225; нужен навык 125 и уровень персонажа 20. Стрелка ведет к ближайшему учителю вашей фракции ({skill:186}).",

	-- Step 20: Iron: Duskwood (125-155)
	-- {zone:1431} Duskwood
	["Iron: {zone:1431} (125-155)"] = "Залежи железа: {zone:1431} (125-155)",
	-- {skill:186} Mining
	["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 18-30."] = "Добывайте по пути: Оловянная жила (65, зеленый), серебряная жила (75, зеленый), залежи железа (125, оранжевый) – и обходите точки маршрута, пока {skill:186} не достигнет 155. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 18-30.",
	["Iron, Silver"] = "Залежи железа, серебряная жила",

	-- Step 21: Iron: Alterac Mountains (125-155)
	-- {zone:1416} Alterac Mountains
	["Iron: {zone:1416} (125-155)"] = "Залежи железа: {zone:1416} (125-155)",
	-- {skill:186} Mining
	["Mine every Tin (65, green), Silver (75, green), Iron (125, orange) node you pass and circle the waypoints until {skill:186} 155. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 30-40."] = "Добывайте по пути: Оловянная жила (65, зеленый), серебряная жила (75, зеленый), залежи железа (125, оранжевый) – и обходите точки маршрута, пока {skill:186} не достигнет 155. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 30-40.",

	-- Step 22: Gold: Swamp of Sorrows (155-175)
	-- {zone:1435} Swamp of Sorrows
	["Gold: {zone:1435} (155-175)"] = "Золотая жила: {zone:1435} (155-175)",
	-- {skill:186} Mining
	["Mine every Silver (75, green), Iron (125, yellow), Gold (155, orange) node you pass and circle the waypoints until {skill:186} 175. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Добывайте по пути: Серебряная жила (75, зеленый), залежи железа (125, желтый), золотая жила (155, оранжевый) – и обходите точки маршрута, пока {skill:186} не достигнет 175. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 35-45.",
	["Gold"] = "Золотая жила",
	["Gold, Iron"] = "Золотая жила, залежи железа",

	-- Step 23: Gold & Mithril: Swamp of Sorrows (175-200)
	-- {zone:1435} Swamp of Sorrows
	["Gold & Mithril: {zone:1435} (175-200)"] = "Золотая жила и мифриловые залежи: {zone:1435} (175-200)",
	-- {skill:186} Mining
	["Mine every Iron (125, green), Gold (155, orange), Mithril (175, orange) node you pass and circle the waypoints until {skill:186} 200. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Добывайте по пути: Залежи железа (125, зеленый), золотая жила (155, оранжевый), мифриловые залежи (175, оранжевый) – и обходите точки маршрута, пока {skill:186} не достигнет 200. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 35-45.",
	["Gold, Mithril"] = "Золотая жила, мифриловые залежи",

	-- Step 24: Artisan Mining
	-- {skill:186} Mining
	["Artisan {skill:186}"] = "{skill:186}: Искусник",
	-- {skill:186} Mining
	["Artisan {skill:186} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:186} trainer of your faction."] = "{skill:186}, ранг «Искусник»: предел 300; нужен навык 200 и уровень персонажа 35. Стрелка ведет к ближайшему учителю вашей фракции ({skill:186}).",

	-- Step 25: Gold & Mithril: Swamp of Sorrows (200-230) cont.
	-- {zone:1435} Swamp of Sorrows
	["Gold & Mithril: {zone:1435} (200-230) cont."] = "Золотая жила и мифриловые залежи: {zone:1435} (200-230), продолжение",
	-- {skill:186} Mining
	["Mine every Iron (125, green), Gold (155, yellow), Mithril (175, yellow) node you pass and circle the waypoints until {skill:186} 230. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 35-45."] = "Добывайте по пути: Залежи железа (125, зеленый), золотая жила (155, желтый), мифриловые залежи (175, желтый) – и обходите точки маршрута, пока {skill:186} не достигнет 230. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 35-45.",

	-- Step 26: Dark Iron & Truesilver: Searing Gorge (230-245)
	-- {object:147516} Dark Iron · {zone:1427} Searing Gorge
	["{object:147516} & Truesilver: {zone:1427} (230-245)"] = "{object:147516} и залежи истинного серебра: {zone:1427} (230-245)",
	-- {object:147516} Dark Iron · {skill:186} Mining
	["Mine every Gold (155, green), Mithril (175, green), {object:147516} (230, orange), Truesilver (230, orange) node you pass and circle the waypoints until {skill:186} 245. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 43-50."] = "Добывайте по пути: Золотая жила (155, зеленый), мифриловые залежи (175, зеленый), {object:147516} (230, оранжевый), залежи истинного серебра (230, оранжевый) – и обходите точки маршрута, пока {skill:186} не достигнет 245. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 43-50.",
	-- {object:147516} Dark Iron
	["Truesilver, {object:147516}"] = "Залежи истинного серебра, {object:147516}",
	-- {object:147516} Dark Iron
	["{object:147516}, Gold"] = "{object:147516}, золотая жила",

	-- Step 27: Truesilver & Small Thorium: Blasted Lands (245-275)
	-- {zone:1419} Blasted Lands
	["Truesilver & Small Thorium: {zone:1419} (245-275)"] = "Залежи истинного серебра и малая ториевая жила: {zone:1419} (245-275)",
	-- {skill:186} Mining
	["Mine every Gold (155, green), Mithril (175, green), Truesilver (230, orange), Small Thorium (245, orange) node you pass and circle the waypoints until {skill:186} 275. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 45-55."] = "Добывайте по пути: Золотая жила (155, зеленый), мифриловые залежи (175, зеленый), залежи истинного серебра (230, оранжевый), малая ториевая жила (245, оранжевый) – и обходите точки маршрута, пока {skill:186} не достигнет 275. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 45-55.",

	-- Step 28: Rich Thorium: Burning Steppes (275-300)
	-- {zone:1428} Burning Steppes
	["Rich Thorium: {zone:1428} (275-300)"] = "Богатая ториевая жила: {zone:1428} (275-300)",
	-- {object:147516} Dark Iron · {skill:186} Mining
	["Mine every {object:147516} (230, yellow), Truesilver (230, yellow), Small Thorium (245, yellow), Rich Thorium (275, orange) node you pass and circle the waypoints until {skill:186} 300. Smelt the ore at a forge when your bags fill: smelting also raises {skill:186}. Zone level 50-58."] = "Добывайте по пути: {object:147516} (230, желтый), залежи истинного серебра (230, желтый), малая ториевая жила (245, желтый), богатая ториевая жила (275, оранжевый) – и обходите точки маршрута, пока {skill:186} не достигнет 300. Когда сумки заполнятся, переплавьте руду в горне: выплавка тоже повышает {skill:186}. Уровень зоны: 50-58.",
	-- {object:147516} Dark Iron
	["{object:147516}, Rich Thorium"] = "{object:147516}, богатая ториевая жила",
}
