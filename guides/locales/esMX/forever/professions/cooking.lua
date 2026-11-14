-- Spanish (Latin America) (esMX): the guide forever/professions/cooking (forever/professions/cooking.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Cooking
	-- {skill:185} Cooking
	["Learn {skill:185}"] = "Aprende {skill:185}",
	-- {skill:185} Cooking · {object:29784} Basic Campfire · {item:279981} Basic Campfire Kit · {item:4470} Simple Wood · {item:4471} Flint and Tinder
	["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (any character level, 1s); the arrow picks the nearest. Forever: every cook knows {object:29784}. Craft a {item:279981} from one {item:4470} (38c) with {item:4471} (1s 35c, kept in your bags), then place the kit to light a cooking fire anywhere; make a few in advance (one use every 5 minutes). The first kits also raise {skill:185} to about 5. The Camping 101: {skill:185} quest at your starting area's camp sends you to this trainer."] = "Cualquier instructor de {skill:185} de tu facción enseña Aprendiz de {skill:185} (cualquier nivel de personaje, 1s); la flecha elige el más cercano. En Forever, todo cocinero conoce {object:29784}. Fabrica una {item:279981} con una {item:4470} (38c) y {item:4471} (1s 35c, se queda en tus bolsas), y luego coloca el kit para encender un fuego de cocina en cualquier lugar; haz unos cuantos por adelantado (un uso cada 5 minutos). Los primeros kits también suben {skill:185} hasta 5 aproximadamente. La misión “Campamento básico: {skill:185}” del campamento de tu zona inicial te envía a este instructor.",

	-- Step 2: Charred Wolf Meat: Auction House
	-- {spell:2538} Charred Wolf Meat
	["{spell:2538}: Auction House"] = "",
	-- {spell:2538} Charred Wolf Meat · {item:2672} Stringy Wolf Meat
	["What {spell:2538} takes that the Auction House sells: 50 {item:2672}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 3: Charred Wolf Meat: ingredients
	-- {spell:2538} Charred Wolf Meat
	["{spell:2538}: ingredients"] = "{spell:2538}: ingredientes",
	-- {zone:1429} Elwynn Forest
	["Prowler (86%) in {zone:1429}, or wherever the arrow points"] = "Merodeador (86%) en {zone:1429}, o donde indique la flecha",

	-- Step 4: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2538} es naranja desde 1 (amarillo a 45, verde a 65, gris a 85): unas 50 fabricaciones hasta 50. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}.",

	-- Step 5: Roasted Boar Meat: Auction House
	-- {spell:2540} Roasted Boar Meat
	["{spell:2540}: Auction House"] = "",
	-- {spell:2540} Roasted Boar Meat · {item:769} Chunk of Boar Meat
	["What {spell:2540} takes that the Auction House sells: 50 {item:769}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 6: Roasted Boar Meat: ingredients
	-- {spell:2540} Roasted Boar Meat
	["{spell:2540}: ingredients"] = "{spell:2540}: ingredientes",
	-- {npc:1126} Large Crag Boar · {npc:1125} Crag Boar · {zone:1426} Dun Morogh
	["{npc:1126} (36%), {npc:1125} (34%) in {zone:1426}, or wherever the arrow points"] = "{npc:1126} (36%), {npc:1125} (34%) en {zone:1426}, o donde indique la flecha",

	-- Step 7: Roasted Boar Meat (1-50)
	-- {spell:2540} Roasted Boar Meat · {object:29784} Basic Campfire
	["{spell:2540} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2540} es naranja desde 1 (amarillo a 45, verde a 65, gris a 85): unas 50 fabricaciones hasta 50. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}.",

	-- Step 8: Herb Baked Egg: shopping
	-- {item:6888} Herb Baked Egg
	["{item:6888}: shopping"] = "{item:6888}: compras",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 50 {item:2678} (1s)."] = "La flecha elige el mercader más cercano de tu facción para cada objeto. Necesitas 50 {item:2678} (1s).",

	-- Step 9: Herb Baked Egg: Auction House
	-- {item:6888} Herb Baked Egg
	["{item:6888}: Auction House"] = "",
	-- {item:6888} Herb Baked Egg · {item:6889} Small Egg
	["What {item:6888} takes that the Auction House sells: 50 {item:6889}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 10: Herb Baked Egg: ingredients
	-- {item:6888} Herb Baked Egg
	["{item:6888}: ingredients"] = "{item:6888}: ingredientes",
	-- {npc:1995} Strigid Owl · {zone:1438} Teldrassil
	["{npc:1995} (58%) in {zone:1438}, or wherever the arrow points"] = "{npc:1995} (58%) en {zone:1438}, o donde indique la flecha",

	-- Step 11: Herb Baked Egg (1-50)
	-- {item:6888} Herb Baked Egg · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2678} Mild Spices · {zone:1438} Teldrassil · {item:6889} Small Egg · {zone:1439} Darkshore · {item:6290} Brilliant Smallfish · {npc:6286} Zarrin · {area:186} Dolanaar · {item:5472} Kaldorei Spider Kabob
	-- plural, as words: Small Spider Legs = {item:5465} Small Spider Leg
	["{item:6888} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. {item:6888} comes with {skill:185} (the client teaches it with the skill); {item:2678} are a cooking vendor's. The Strigid owls of {zone:1438} drop a {item:6889} more often than not, and {zone:1439}'s moonkin drop them too. Fishers can cook {item:6290} (recipe 40c) from Rut'theran's waters instead, and {npc:6286} in {area:186} gives Recipe of the Kaldorei (seven Small Spider Legs from the Webwood spiders) for {item:5472}, orange from 10 to 50."] = "{item:6888} es naranja desde 1 (amarillo a 45, verde a 65, gris a 85): unas 50 fabricaciones hasta 50. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. {item:6888} viene con {skill:185} (el cliente la enseña con la habilidad); {item:2678} se compra a un mercader de cocina. Los búhos estrígidos de {zone:1438} sueltan {item:6889} más veces que no, y los lechúcicos de {zone:1439} también. Los pescadores pueden cocinar en su lugar {item:6290} (receta 40c) con lo que pesquen en las aguas de Rut'theran, y {npc:6286} en {area:186} da Receta de los kaldorei (siete patas de araña pequeñas de las arañas Tejemadera) para {item:5472}, naranja de 10 a 50.",

	-- Step 13: Charred Wolf Meat: ingredients
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} in Zephras Isle, or wherever the arrow points"] = "{npc:250873} en la isla Zephras, o donde indique la flecha",

	-- Step 14: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire · {item:2672} Stringy Wolf Meat
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. The Vuldren of Zephras Isle drop {item:2672}."] = "{spell:2538} es naranja desde 1 (amarillo a 45, verde a 65, gris a 85): unas 50 fabricaciones hasta 50. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. Los Vuldren de la isla Zephras sueltan {item:2672}.",

	-- Step 16: Roasted Boar Meat: ingredients
	-- {npc:3099} Dire Mottled Boar · {zone:1411} Durotar
	["{npc:3099} (99%) in {zone:1411}, or wherever the arrow points"] = "{npc:3099} (99%) en {zone:1411}, o donde indique la flecha",

	-- Step 19: Charred Wolf Meat: ingredients
	-- {npc:2960} Prairie Wolf Alpha · {npc:2959} Prairie Stalker · {zone:1412} Mulgore
	["{npc:2960} (82%), {npc:2959} (77%) in {zone:1412}, or wherever the arrow points"] = "{npc:2960} (82%), {npc:2959} (77%) en {zone:1412}, o donde indique la flecha",

	-- Step 22: Charred Wolf Meat: ingredients
	-- {npc:1547} Decrepit Darkhound · {npc:1548} Cursed Darkhound · {zone:1420} Tirisfal Glades
	["{npc:1547} (72%), {npc:1548} (33%) in {zone:1420}, or wherever the arrow points"] = "{npc:1547} (72%), {npc:1548} (33%) en {zone:1420}, o donde indique la flecha",

	-- Step 24: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "Oficial de {skill:185}",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and no character level: the arrow picks the nearest {skill:185} trainer of your faction; training costs 5s."] = "Oficial de {skill:185} sube el límite a 150; requiere habilidad 50 y ningún nivel de personaje: la flecha elige el instructor de {skill:185} más cercano de tu facción; el entrenamiento cuesta 5s.",

	-- Step 25: Coyote Steak: Auction House
	-- {spell:2541} Coyote Steak
	["{spell:2541}: Auction House"] = "",
	-- {spell:2541} Coyote Steak · {item:2673} Coyote Meat
	["What {spell:2541} takes that the Auction House sells: 40 {item:2673}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 26: Coyote Steak: ingredients
	-- {spell:2541} Coyote Steak
	["{spell:2541}: ingredients"] = "{spell:2541}: ingredientes",
	-- {npc:834} Coyote · {npc:833} Coyote Packleader · {zone:1436} Westfall
	["{npc:834} (54%), {npc:833} (51%) in {zone:1436}, or wherever the arrow points"] = "{npc:834} (54%), {npc:833} (51%) en {zone:1436}, o donde indique la flecha",

	-- Step 27: Coyote Steak (50-90)
	-- {spell:2541} Coyote Steak · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {npc:235} Salma Saldean · {area:108} Sentinel Hill · {item:733} Westfall Stew · {item:724} Goretusk Liver Pie
	-- plural, as words: Coyotes = {npc:834} Coyote
	["{spell:2541} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. Coyotes roam the middle of {zone:1436}; {npc:235} on the farm north of {area:108} also gives {item:733} and {item:724} quests that use what you loot here."] = "{spell:2541} es naranja desde 50 (amarillo a 90, verde a 110, gris a 130): unas 40 fabricaciones hasta 90. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. Cualquier instructor de {skill:185} lo enseña desde la habilidad 50 por 1s. Los coyotes recorren el centro de {zone:1436}; {npc:235}, en la granja al norte de {area:108}, también da misiones de {item:733} y {item:724} que usan lo que saquees aquí.",

	-- Step 28: Crab Cake: shopping
	-- {spell:2544} Crab Cake
	["{spell:2544}: shopping"] = "{spell:2544}: compras",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 44 {item:2678} (90c)."] = "La flecha elige el mercader más cercano de tu facción para cada objeto. Necesitas 44 {item:2678} (90c).",

	-- Step 29: Crab Cake: Auction House
	-- {spell:2544} Crab Cake
	["{spell:2544}: Auction House"] = "",
	-- {spell:2544} Crab Cake · {item:2674} Crawler Meat
	["What {spell:2544} takes that the Auction House sells: 44 {item:2674}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 30: Crab Cake: ingredients
	-- {spell:2544} Crab Cake
	["{spell:2544}: ingredients"] = "{spell:2544}: ingredientes",
	-- {npc:830} Sand Crawler · {zone:1436} Westfall
	["{npc:830} (43%) in {zone:1436}, or wherever the arrow points"] = "{npc:830} (43%) en {zone:1436}, o donde indique la flecha",

	-- Step 31: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1436} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544} es naranja desde 90 (amarillo a 115, verde a 135, gris a 155): unas 44 fabricaciones hasta 130. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. Cualquier instructor de {skill:185} lo enseña desde la habilidad 75 por 2s. Los reptadores cubren toda la costa de {zone:1436}. Cocínalo hasta 130, donde {spell:3376} toma el relevo.",

	-- Step 32: Smoked Bear Meat: shopping
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: shopping"] = "{item:6890}: compras",
	["The arrow picks the nearest vendor of your faction for each item."] = "La flecha elige el mercader más cercano de tu facción para cada objeto.",

	-- Step 33: Smoked Bear Meat: Auction House
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: Auction House"] = "",
	-- {item:6890} Smoked Bear Meat · {item:3173} Bear Meat
	["What {item:6890} takes that the Auction House sells: 30 {item:3173}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 34: Smoked Bear Meat: ingredients
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: ingredients"] = "{item:6890}: ingredientes",
	-- {npc:1189} Black Bear Patriarch · {zone:1432} Loch Modan
	["{npc:1189} (39%) in {zone:1432}, or wherever the arrow points"] = "{npc:1189} (39%) en {zone:1432}, o donde indique la flecha",

	-- Step 35: Smoked Bear Meat (50-80)
	-- {item:6890} Smoked Bear Meat · {object:29784} Basic Campfire · {item:6892} Recipe: Smoked Bear Meat · {zone:1432} Loch Modan
	["{item:6890} is orange from 50 (yellow at 80, green at 100, grey at 120): about 30 crafts to 80. Cook at any fire: a town hearth or your own {object:29784}. {item:6892} costs 2s 50c at its vendor; the arrow picks the nearest one of your faction. Black bears roam the hills of {zone:1432}."] = "{item:6890} es naranja desde 50 (amarillo a 80, verde a 100, gris a 120): unas 30 fabricaciones hasta 80. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. {item:6892} cuesta 2s 50c en su mercader; la flecha elige el más cercano de tu facción. Los osos negros recorren las colinas de {zone:1432}.",

	-- Step 36: Dry Pork Ribs: shopping
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: shopping"] = "{spell:2546}: compras",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2678} (1s 10c)."] = "La flecha elige el mercader más cercano de tu facción para cada objeto. Necesitas 52 {item:2678} (1s 10c).",

	-- Step 37: Dry Pork Ribs: Auction House
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: Auction House"] = "",
	-- {spell:2546} Dry Pork Ribs · {item:2677} Boar Ribs
	["What {spell:2546} takes that the Auction House sells: 52 {item:2677}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 38: Dry Pork Ribs: ingredients
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: ingredients"] = "{spell:2546}: ingredientes",
	-- {npc:1191} Mangy Mountain Boar · {zone:1432} Loch Modan
	["{npc:1191} (31%) in {zone:1432}, or wherever the arrow points"] = "{npc:1191} (31%) en {zone:1432}, o donde indique la flecha",

	-- Step 39: Dry Pork Ribs (80-130)
	-- {spell:2546} Dry Pork Ribs · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1432} Loch Modan · {spell:3376} Curiously Tasty Omelet
	["{spell:2546} is orange from 80 (yellow at 120, green at 140, grey at 160): about 52 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 80 for 1s 50c. Mountain boars roam all of {zone:1432}. Cook it to 130, where {spell:3376} takes over."] = "{spell:2546} es naranja desde 80 (amarillo a 120, verde a 140, gris a 160): unas 52 fabricaciones hasta 130. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. Cualquier instructor de {skill:185} lo enseña desde la habilidad 80 por 1s 50c. Los jabalíes montañeses recorren todo {zone:1432}. Cocínalo hasta 130, donde {spell:3376} toma el relevo.",

	-- Step 40: Boiled Clams: shopping
	-- {item:5525} Boiled Clams
	["{item:5525}: shopping"] = "{item:5525}: compras",
	-- {item:159} Refreshing Spring Water
	["The arrow picks the nearest vendor of your faction for each item. You need 40 {item:159} (2s)."] = "La flecha elige el mercader más cercano de tu facción para cada objeto. Necesitas 40 {item:159} (2s).",

	-- Step 41: Boiled Clams: ingredients
	-- {item:5525} Boiled Clams
	["{item:5525}: ingredients"] = "{item:5525}: ingredientes",
	-- {npc:3812} Clattering Crawler · {npc:3814} Spined Crawler · {npc:3944} Wrathtail Priestess · {zone:1439} Darkshore · {item:5523} Small Barnacled Clam · {item:5503} Clam Meat
	["{npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) in {zone:1439}, or wherever the arrow points; open each {item:5523} for its {item:5503}"] = "{npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) en {zone:1439}, o donde indique la flecha; abre cada {item:5523} para sacar su {item:5503}",

	-- Step 42: Boiled Clams (50-90)
	-- {item:5525} Boiled Clams · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2674} Crawler Meat · {spell:2544} Crab Cake
	["{item:5525} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. The same coastal crawlers drop {item:2674} for {spell:2544} next: keep it."] = "{item:5525} es naranja desde 50 (amarillo a 90, verde a 110, gris a 130): unas 40 fabricaciones hasta 90. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. Cualquier instructor de {skill:185} lo enseña desde la habilidad 50 por 1s. Los mismos reptadores de la costa sueltan {item:2674} para {spell:2544}, lo siguiente: guárdalo.",

	-- Step 45: Crab Cake: ingredients
	-- {npc:3814} Spined Crawler · {npc:3812} Clattering Crawler · {zone:1439} Darkshore
	["{npc:3814} (42%), {npc:3812} (40%) in {zone:1439}, or wherever the arrow points"] = "{npc:3814} (42%), {npc:3812} (40%) en {zone:1439}, o donde indique la flecha",

	-- Step 46: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1439} Darkshore · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1439} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544} es naranja desde 90 (amarillo a 115, verde a 135, gris a 155): unas 44 fabricaciones hasta 130. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. Cualquier instructor de {skill:185} lo enseña desde la habilidad 75 por 2s. Los reptadores cubren toda la costa de {zone:1439}. Cocínalo hasta 130, donde {spell:3376} toma el relevo.",

	-- Step 47: Strider Stew: shopping
	-- {item:5477} Strider Stew
	["{item:5477}: shopping"] = "{item:5477}: compras",
	-- {item:4536} Shiny Red Apple
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:4536} (2s 75c)."] = "La flecha elige el mercader más cercano de tu facción para cada objeto. Necesitas 52 {item:4536} (2s 75c).",

	-- Step 48: Strider Stew: Auction House
	-- {item:5477} Strider Stew
	["{item:5477}: Auction House"] = "",
	-- {item:5477} Strider Stew · {item:5469} Strider Meat
	["What {item:5477} takes that the Auction House sells: 52 {item:5469}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 49: Strider Stew: ingredients
	-- {item:5477} Strider Stew
	["{item:5477}: ingredients"] = "{item:5477}: ingredientes",
	-- {npc:3246} Fleeting Plainstrider · {zone:1413} The Barrens
	["{npc:3246} (32%) in {zone:1413}, or wherever the arrow points"] = "{npc:3246} (32%) en {zone:1413}, o donde indique la flecha",

	-- Step 50: Strider Stew (50-100)
	-- {item:5477} Strider Stew · {object:29784} Basic Campfire · {item:5486} Recipe: Strider Stew
	["{item:5477} is orange from 50 (yellow at 90, green at 110, grey at 130): about 52 crafts to 100. Cook at any fire: a town hearth or your own {object:29784}. {item:5486} costs 4s 40c at its vendor; the arrow picks the nearest one of your faction."] = "{item:5477} es naranja desde 50 (amarillo a 90, verde a 110, gris a 130): unas 52 fabricaciones hasta 100. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. {item:5486} cuesta 4s 40c en su mercader; la flecha elige el más cercano de tu facción.",

	-- Step 51: Crispy Lizard Tail: shopping
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: shopping"] = "{item:5479}: compras",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 30 {item:2692} (12s)."] = "La flecha elige el mercader más cercano de tu facción para cada objeto. Necesitas 30 {item:2692} (12s).",

	-- Step 52: Crispy Lizard Tail: Auction House
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: Auction House"] = "",
	-- {item:5479} Crispy Lizard Tail · {item:5470} Thunder Lizard Tail
	["What {item:5479} takes that the Auction House sells: 30 {item:5470}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 53: Crispy Lizard Tail: ingredients
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: ingredients"] = "{item:5479}: ingredientes",
	-- {npc:3239} Thunderhead · {zone:1413} The Barrens
	["{npc:3239} (59%), Owatanka (35%) in {zone:1413}, or wherever the arrow points"] = "{npc:3239} (59%), Owatanka (35%) en {zone:1413}, o donde indique la flecha",

	-- Step 54: Crispy Lizard Tail (100-130)
	-- {item:5479} Crispy Lizard Tail · {object:29784} Basic Campfire · {item:5488} Recipe: Crispy Lizard Tail · {npc:3489} Zargh · {item:3735} Recipe: Hot Lion Chops
	["{item:5479} is orange from 100 (yellow at 140, green at 160, grey at 180): about 30 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. {item:5488} costs 4s at its vendor; the arrow picks the nearest one of your faction. {npc:3489}, the butcher beside this vendor at the Crossroads, sells {item:3735} (18s), the recipe after Expert: buy it now."] = "{item:5479} es naranja desde 100 (amarillo a 140, verde a 160, gris a 180): unas 30 fabricaciones hasta 130. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. {item:5488} cuesta 4s en su mercader; la flecha elige el más cercano de tu facción. {npc:3489}, el carnicero junto a este mercader en el Cruce, vende {item:3735} (18s), la receta de después de Experto: cómprala ahora.",

	-- Step 55: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "Experto de {skill:185}",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook
	["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072} (1g); the arrow picks its nearest seller for your faction. Buy it and read it."] = "Experto de {skill:185} sube el límite a 225; requiere habilidad 125 y nivel de personaje 20: es un libro, {item:16072} (1g); la flecha elige su vendedor más cercano de tu facción. Cómpralo y léelo.",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "Compra y lee {item:16072} (Experto de {skill:185})",

	-- Step 56: Curiously Tasty Omelet: shopping
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: shopping"] = "{spell:3376}: compras",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 46 {item:2692} (18s 40c)."] = "La flecha elige el mercader más cercano de tu facción para cada objeto. Necesitas 46 {item:2692} (18s 40c).",

	-- Step 57: Curiously Tasty Omelet: Auction House
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: Auction House"] = "",
	-- {spell:3376} Curiously Tasty Omelet · {item:3685} Raptor Egg
	["What {spell:3376} takes that the Auction House sells: 46 {item:3685}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 58: Curiously Tasty Omelet: ingredients
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: ingredients"] = "{spell:3376}: ingredientes",
	-- {npc:1018} Highland Razormaw · {npc:1019} Elder Razormaw · {zone:1437} Wetlands
	["{npc:1018} (72%), {npc:1019} (67%) in {zone:1437}, or wherever the arrow points"] = "{npc:1018} (72%), {npc:1019} (67%) en {zone:1437}, o donde indique la flecha",

	-- Step 59: Curiously Tasty Omelet (130-175)
	-- {spell:3376} Curiously Tasty Omelet · {object:29784} Basic Campfire · {item:3682} Recipe: Curiously Tasty Omelet · {zone:1437} Wetlands · {item:3685} Raptor Egg · {npc:340} Kendor Kabonka · {zone:1453} Stormwind
	["{spell:3376} is orange from 130 (yellow at 170, green at 190, grey at 210): about 46 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3682} costs 16s at its vendor; the arrow picks the nearest one of your faction. The raptors of the {zone:1437} drop a {item:3685} about two kills in three. {npc:340} in {zone:1453} sells the recipe."] = "{spell:3376} es naranja desde 130 (amarillo a 170, verde a 190, gris a 210): unas 46 fabricaciones hasta 175. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. {item:3682} cuesta 16s en su mercader; la flecha elige el más cercano de tu facción. Los raptores de {zone:1437} sueltan {item:3685} más o menos dos de cada tres muertes. {npc:340} en {zone:1453} vende la receta.",

	-- Step 60: Hot Lion Chops: shopping
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: shopping"] = "{spell:3398}: compras",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 45 {item:2692} (18s)."] = "La flecha elige el mercader más cercano de tu facción para cada objeto. Necesitas 45 {item:2692} (18s).",

	-- Step 61: Hot Lion Chops: Auction House
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: Auction House"] = "",
	-- {spell:3398} Hot Lion Chops · {item:3731} Lion Meat
	["What {spell:3398} takes that the Auction House sells: 45 {item:3731}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 62: Hot Lion Chops: ingredients
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: ingredients"] = "{spell:3398}: ingredientes",
	-- {npc:2384} Starving Mountain Lion · {zone:1424} Hillsbrad Foothills
	["{npc:2384} (42%) in {zone:1424}, or wherever the arrow points"] = "{npc:2384} (42%) en {zone:1424}, o donde indique la flecha",

	-- Step 63: Hot Lion Chops (130-175)
	-- {spell:3398} Hot Lion Chops · {object:29784} Basic Campfire · {item:3735} Recipe: Hot Lion Chops · {item:3731} Lion Meat
	-- plural, as words: Hulking Mountain Lions = {npc:2407} Hulking Mountain Lion
	["{spell:3398} is orange from 130 (yellow at 175, green at 195, grey at 215): about 45 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3735} costs 18s at its vendor; the arrow picks the nearest one of your faction. The Feral and Hulking Mountain Lions of Hillsbrad Foothills drop {item:3731} more often than the Starving ones."] = "{spell:3398} es naranja desde 130 (amarillo a 175, verde a 195, gris a 215): unas 45 fabricaciones hasta 175. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. {item:3735} cuesta 18s en su mercader; la flecha elige el más cercano de tu facción. Los leones de montaña salvajes y enormes de las Laderas de Trabalomas sueltan {item:3731} más a menudo que los hambrientos.",

	-- Step 64: Roast Raptor: shopping
	-- {item:12210} Roast Raptor
	["{item:12210}: shopping"] = "{item:12210}: compras",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2692} (20s 80c)."] = "La flecha elige el mercader más cercano de tu facción para cada objeto. Necesitas 52 {item:2692} (20s 80c).",

	-- Step 65: Roast Raptor: Auction House
	-- {item:12210} Roast Raptor
	["{item:12210}: Auction House"] = "",
	-- {item:12210} Roast Raptor · {item:12184} Raptor Flesh
	["What {item:12210} takes that the Auction House sells: 52 {item:12184}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 66: Roast Raptor: ingredients
	-- {item:12210} Roast Raptor
	["{item:12210}: ingredients"] = "{item:12210}: ingredientes",
	-- {npc:2560} Highland Thrasher · {zone:1417} Arathi Highlands
	["{npc:2560} (38%) in {zone:1417}, or wherever the arrow points"] = "{npc:2560} (38%) en {zone:1417}, o donde indique la flecha",

	-- Step 67: Roast Raptor (175-225)
	-- {item:12210} Roast Raptor · {object:29784} Basic Campfire · {item:12228} Recipe: Roast Raptor · {zone:1417} Arathi Highlands · {npc:2810} Hammon Karwn · {area:320} Refuge Pointe · {npc:2821} Keena · {area:321} Hammerfall · {item:2692} Hot Spices · {item:17222} Spider Sausage · {item:12205} White Spider Meat
	["{item:12210} is orange from 175 (yellow at 215, green at 235, grey at 255): about 52 crafts to 225. Cook at any fire: a town hearth or your own {object:29784}. {item:12228} costs 50s at its vendor; the arrow picks the nearest one of your faction. {zone:1417}: {npc:2810} at {area:320} (Alliance) and {npc:2821} at {area:321} (Horde) sell the recipe and {item:2692} beside the raptors. {item:17222} (any trainer from 200, 40s) is the alternative, but it takes two {item:12205} a craft and Dustwallow's spiders drop one about two kills in five."] = "{item:12210} es naranja desde 175 (amarillo a 215, verde a 235, gris a 255): unas 52 fabricaciones hasta 225. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. {item:12228} cuesta 50s en su mercader; la flecha elige el más cercano de tu facción. {zone:1417}: {npc:2810} en {area:320} (Alianza) y {npc:2821} en {area:321} (Horda) venden la receta y {item:2692}, cerca de los raptores. {item:17222} (cualquier instructor desde 200, 40s) es la alternativa, pero lleva dos {item:12205} por fabricación y las arañas de Marjal Revolcafango sueltan una más o menos dos de cada cinco muertes.",

	-- Step 68: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "Artesano de {skill:185} se obtiene de {npc:8125} en {area:976} ({zone:1446}). El instructor de cocina de {zone:1455} te envía; requiere habilidad 225 y nivel 35.",

	-- Step 69: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "Artesano de {skill:185} se obtiene de {npc:8125} en {area:976} ({zone:1446}). El instructor de cocina de {zone:1454} te envía; requiere habilidad 225 y nivel 35.",

	-- Step 70: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "Huevos gigantes",
	-- {quest:6610} Clamlette Surprise · {item:7974} Zesty Clam Meat · {item:8932} Alterac Swiss · {zone:1446} Tanaris · {zone:1425} The Hinterlands · {npc:2929} Savage Owlbeast · {item:12218} Monster Omelet
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["{quest:6610} asks for 12 Giant Eggs, 10 {item:7974} and 20 {item:8932}: bring all three before you go to {zone:1446}, so you make the trip once. Giant Eggs drop from the owlbeasts of {zone:1425}: {npc:2929} (54%). {item:12218} takes about 120 more after Artisan: farm them now too if you like."] = "{quest:6610} pide 12 huevos gigantes, 10 {item:7974} y 20 {item:8932}: lleva los tres antes de ir a {zone:1446}, así haces el viaje una sola vez. Los huevos gigantes los sueltan las lechubestias de {zone:1425}: {npc:2929} (54%). {item:12218} necesita unos 120 más después de Artesano: si quieres, consíguelos también ahora.",

	-- Step 71: Alterac Swiss
	-- {item:8932} Alterac Swiss
	["Innkeepers and food vendors sell {item:8932}; the arrow picks the nearest."] = "Los posaderos y mercaderes de comida venden {item:8932}; la flecha elige el más cercano.",

	-- Step 72: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {zone:1445} Dustwallow Marsh · {zone:1446} Tanaris
	-- plural, as words: Big-mouth Clams = {item:7973} Big-mouth Clam · Steeljaw Snappers = {npc:14123} Steeljaw Snapper
	["{item:7974} comes from Big-mouth Clams: open each one, every clam holds one. The Muckshell crabs on the {zone:1445} coast south-west of Theramore drop a clam about seven kills in ten, so ten clams take about fifteen kills, on your way to {zone:1446}. The Steeljaw Snappers on {zone:1446}'s east coast drop them about one kill in three."] = "{item:7974} sale de las almejas bocazas: abre cada una, todas tienen una. Los cangrejos Caparazón de lodo de la costa de {zone:1445}, al suroeste de Theramore, sueltan una almeja más o menos siete de cada diez muertes, así que diez almejas son unas quince muertes, de camino a {zone:1446}. Las tortugas mordedoras Quijacero de la costa este de {zone:1446} las sueltan más o menos una de cada tres muertes.",

	-- Step 73: Clamlette Surprise
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "Artesano de {skill:185}",

	-- Step 74: Monster Omelet: shopping
	-- {item:12218} Monster Omelet
	["{item:12218}: shopping"] = "{item:12218}: compras",
	-- {item:3713} Soothing Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 240 {item:3713} (3g 84s)."] = "La flecha elige el mercader más cercano de tu facción para cada objeto. Necesitas 240 {item:3713} (3g 84s).",

	-- Step 75: Monster Omelet: Auction House
	-- {item:12218} Monster Omelet
	["{item:12218}: Auction House"] = "",
	-- {item:12218} Monster Omelet · {item:12207} Giant Egg
	["What {item:12218} takes that the Auction House sells: 120 {item:12207}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 76: Monster Omelet: ingredients
	-- {item:12218} Monster Omelet
	["{item:12218}: ingredients"] = "{item:12218}: ingredientes",
	-- {npc:2929} Savage Owlbeast · {zone:1425} The Hinterlands
	["{npc:2929} (54%) in {zone:1425}, or wherever the arrow points"] = "{npc:2929} (54%) en {zone:1425}, o donde indique la flecha",

	-- Step 77: Monster Omelet (225-300)
	-- {item:12218} Monster Omelet · {object:29784} Basic Campfire · {item:16110} Recipe: Monster Omelet · {item:13931} Nightfin Soup · {npc:8137} Gikkix · {area:977} Steamwheedle Port · {item:13932} Poached Sunscale Salmon · {item:279982} Iron Oven
	["{item:12218} is orange from 225 (yellow at 265, green at 285, grey at 305): about 120 crafts to 300. Cook at any fire: a town hearth or your own {object:29784}. {item:16110} costs 1g 20s at its vendor; the arrow picks the nearest one of your faction. {item:12218} is orange to 265 and green from 285, yet it still carries you to 300. Fishers can finish on {item:13931} ({npc:8137}, {area:977}; yellow to 310) instead; {item:13932} needs an {item:279982} on Forever."] = "{item:12218} es naranja desde 225 (amarillo a 265, verde a 285, gris a 305): unas 120 fabricaciones hasta 300. Cocina en cualquier fuego: un hogar de pueblo o tu propia {object:29784}. {item:16110} cuesta 1g 20s en su mercader; la flecha elige el más cercano de tu facción. {item:12218} es naranja hasta 265 y verde desde 285, pero aun así te lleva hasta 300. Los pescadores pueden terminar en su lugar con {item:13931} ({npc:8137}, {area:977}; amarillo hasta 310); {item:13932} necesita un {item:279982} en Forever.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5); the arrow picks the nearest."] = "Cualquier instructor de {skill:185} de tu facción enseña Aprendiz de {skill:185} (nivel de personaje 5); la flecha elige el más cercano.",
	-- ["Catch about 50 {item:6291} here by fishing (see the {skill:356} guide)."] = "Pesca aquí unos 50 {item:6291} (consulta la guía de {skill:356}).",
	-- ["Catch about 68 {item:6361} here by fishing (see the {skill:356} guide)."] = "Pesca aquí unos 68 {item:6361} (consulta la guía de {skill:356}).",
	-- ["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072}; the arrow picks its nearest seller for your faction. Buy it and read it."] = "Experto de {skill:185} sube el límite a 225; requiere habilidad 125 y nivel de personaje 20: es un libro, {item:16072}; la flecha elige su vendedor más cercano de tu facción. Cómpralo y léelo.",
	-- ["Giant Eggs drop from the Ironbeak owls of {zone:1448}."] = "Los Huevos gigantes los sueltan las Lechuzas Cortezaférrea de {zone:1448}.",
	-- ["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction."] = "Oficial de {skill:185} sube el límite a 150; requiere habilidad 50 y nivel de personaje 10: la flecha elige el instructor de {skill:185} más cercano de tu facción.",
	-- ["{area:442} docks"] = "Muelles de {area:442}",
	-- ["{area:702} docks"] = "Muelles de {area:702}",
	-- ["{item:12210} is orange from 175 (yellow at 215, grey at 255): about 40 crafts to 215. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12210} es naranja desde 175 (amarillo en 215, gris en 255): unas 40 creaciones hasta 215. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{item:12215} is orange from 215 (yellow at 240, grey at 280): about 10 crafts to 225. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215} es naranja desde 215 (amarillo en 240, gris en 280): unas 10 creaciones hasta 225. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{item:12215} is orange from 225 (yellow at 240, grey at 280): about 15 crafts to 240. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215} es naranja desde 225 (amarillo en 240, gris en 280): unas 15 creaciones hasta 240. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{item:12215}: ingredients"] = "{item:12215}: ingredientes",
	-- ["{item:12215}: shopping"] = "{item:12215}: compras",
	-- ["{item:12218} is orange from 240 (yellow at 265, grey at 305): about 105 crafts to 300. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12218} es naranja desde 240 (amarillo en 265, gris en 305): unas 105 creaciones hasta 300. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{item:5095} is orange from 50 (yellow at 90, grey at 130): about 68 crafts to 110. Cook at any fire: {object:29784} comes with {skill:185}. {skill:356} off the {area:442} docks catches {item:6361}."] = "{item:5095} es naranja desde 50 (amarillo en 90, gris en 130): unas 68 creaciones hasta 110. Cocina en cualquier fuego: {object:29784} viene con {skill:185}. Con {skill:356} desde los muelles de {area:442} se pesca {item:6361}.",
	-- ["{item:5095}: ingredients"] = "{item:5095}: ingredientes",
	-- ["{item:5095}: shopping"] = "{item:5095}: compras",
	-- ["{item:5477} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5477} es naranja desde 50 (amarillo en 90, gris en 130): unas 52 creaciones hasta 100. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{item:5479} is orange from 100 (yellow at 140, grey at 180): about 25 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479} es naranja desde 100 (amarillo en 140, gris en 180): unas 25 creaciones hasta 125. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{item:5479} is orange from 125 (yellow at 140, grey at 180): about 15 crafts to 140. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479} es naranja desde 125 (amarillo en 140, gris en 180): unas 15 creaciones hasta 140. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{item:5480} is orange from 110 (yellow at 150, grey at 190): about 15 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480} es naranja desde 110 (amarillo en 150, gris en 190): unas 15 creaciones hasta 125. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{item:5480} is orange from 125 (yellow at 150, grey at 190): about 25 crafts to 150. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480} es naranja desde 125 (amarillo en 150, gris en 190): unas 25 creaciones hasta 150. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{item:5480}: ingredients"] = "{item:5480}: ingredientes",
	-- ["{item:5480}: shopping"] = "{item:5480}: compras",
	-- ["{item:6290} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}. {item:6291} is the common catch in {zone:1438}'s waters."] = "{item:6290} es naranja desde 1 (amarillo en 45, gris en 85): unas 50 creaciones hasta 50. Cocina en cualquier fuego: {object:29784} viene con {skill:185}. {item:6291} es la captura común en las aguas de {zone:1438}.",
	-- ["{item:6290}: ingredients"] = "{item:6290}: ingredientes",
	-- ["{item:6290}: shopping"] = "{item:6290}: compras",
	-- ["{item:6316} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:6316} es naranja desde 50 (amarillo en 90, gris en 130): unas 52 creaciones hasta 100. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{item:6316}: ingredients"] = "{item:6316}: ingredientes",
	-- ["{item:6316}: shopping"] = "{item:6316}: compras",
	-- ["{item:724} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:724} es naranja desde 50 (amarillo en 90, gris en 130): unas 52 creaciones hasta 100. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{item:724}: ingredients"] = "{item:724}: ingredientes",
	-- ["{item:724}: shopping"] = "{item:724}: compras",
	-- ["{item:7974} has no drop data: buy it at the Gadgetzan Auction House, next to {npc:8125}, or open clams looted from coastal creatures."] = "{item:7974} no tiene datos de botín: cómprala en la casa de subastas de Gadgetzan, junto a {npc:8125}, o abre las almejas que sueltan las criaturas de la costa.",
	-- ["{npc:1193} (50%) in {zone:1432}, or wherever the arrow points"] = "{npc:1193} (50%) en {zone:1432}, o donde indique la flecha",
	-- ["{npc:1400} (50%) in {zone:1437}, or wherever the arrow points"] = "{npc:1400} (50%) en {zone:1437}, o donde indique la flecha",
	-- ["{npc:1549} (88%) in {zone:1420}, or wherever the arrow points"] = "{npc:1549} (88%) en {zone:1420}, o donde indique la flecha",
	-- ["{npc:1689} (38%), {npc:1127} (36%) in {zone:1426}, or wherever the arrow points"] = "{npc:1689} (38%), {npc:1127} (36%) en {zone:1426}, o donde indique la flecha",
	-- ["{npc:2385} (56%) in {zone:1424}, or wherever the arrow points"] = "{npc:2385} (56%) en {zone:1424}, o donde indique la flecha",
	-- ["{npc:3099} (99%), {npc:3100} (74%) in {zone:1411}, or wherever the arrow points"] = "{npc:3099} (99%), {npc:3100} (74%) en {zone:1411}, o donde indique la flecha",
	-- ["{npc:3244} (33%) in {zone:1413}, or wherever the arrow points"] = "{npc:3244} (33%) en {zone:1413}, o donde indique la flecha",
	-- ["{npc:3818} (53%) in {zone:1440}, or wherever the arrow points"] = "{npc:3818} (53%) en {zone:1440}, o donde indique la flecha",
	-- ["{npc:4352} (52%), {npc:4351} (51%) in {zone:1445}, or wherever the arrow points"] = "{npc:4352} (52%), {npc:4351} (51%) en {zone:1445}, o donde indique la flecha",
	-- ["{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) in {zone:1443}, or wherever the arrow points"] = "{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) en {zone:1443}, o donde indique la flecha",
	-- ["{npc:547} (35%), {npc:157} (34%) in {zone:1436}, or wherever the arrow points"] = "{npc:547} (35%), {npc:157} (34%) en {zone:1436}, o donde indique la flecha",
	-- ["{npc:7099} (40%) in {zone:1448}, or wherever the arrow points"] = "{npc:7099} (40%) en {zone:1448}, o donde indique la flecha",
	-- ["{quest:6610} asks for 20 {item:8932} (check the quest log); innkeepers and food vendors sell it, and the arrow picks the nearest."] = "{quest:6610} pide 20 {item:8932} (revisa el registro de misiones); lo venden los taberneros y mercaderes de comida, y la flecha elige el más cercano.",
	-- ["{spell:2538} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2538} es naranja desde 1 (amarillo en 45, gris en 85): unas 50 creaciones hasta 50. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{spell:2540} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2540} es naranja desde 1 (amarillo en 45, gris en 85): unas 50 creaciones hasta 50. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{spell:3370} is orange from 100 (yellow at 120, grey at 160): about 26 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370} es naranja desde 100 (amarillo en 120, gris en 160): unas 26 creaciones hasta 125. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{spell:3370} is yellow from 125 (yellow at 120, grey at 160): about 7 crafts to 130. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370} es amarillo desde 125 (amarillo en 120, gris en 160): unas 7 creaciones hasta 130. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{spell:3370}: ingredients"] = "{spell:3370}: ingredientes",
	-- ["{spell:3370}: shopping"] = "{spell:3370}: compras",
	-- ["{spell:3376} is orange from 130 (yellow at 170, grey at 210): about 46 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376} es naranja desde 130 (amarillo en 170, gris en 210): unas 46 creaciones hasta 175. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{spell:3376} is orange from 150 (yellow at 170, grey at 210): about 26 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376} es naranja desde 150 (amarillo en 170, gris en 210): unas 26 creaciones hasta 175. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
	-- ["{spell:3398} is orange from 140 (yellow at 175, grey at 215): about 35 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3398} es naranja desde 140 (amarillo en 175, gris en 215): unas 35 creaciones hasta 175. Cocina en cualquier fuego: {object:29784} viene con {skill:185}.",
}
