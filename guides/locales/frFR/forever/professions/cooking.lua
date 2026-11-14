-- French (frFR): the guide forever/professions/cooking (forever/professions/cooking.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Cooking
	-- {skill:185} Cooking
	["Learn {skill:185}"] = "Apprendre {skill:185}",
	-- {skill:185} Cooking · {object:29784} Basic Campfire · {item:279981} Basic Campfire Kit · {item:4470} Simple Wood · {item:4471} Flint and Tinder
	["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (any character level, 1s); the arrow picks the nearest. Forever: every cook knows {object:29784}. Craft a {item:279981} from one {item:4470} (38c) with {item:4471} (1s 35c, kept in your bags), then place the kit to light a cooking fire anywhere; make a few in advance (one use every 5 minutes). The first kits also raise {skill:185} to about 5. The Camping 101: {skill:185} quest at your starting area's camp sends you to this trainer."] = "Tout maître de {skill:185} de votre faction enseigne {skill:185} (Apprenti) (tout niveau, 1 pa) ; la flèche indique le plus proche. Sur Forever, tout cuisinier connaît {object:29784}. Fabriquez un {item:279981} à partir d'un {item:4470} (38 pc) avec un {item:4471} (1 pa 35 pc, gardé dans vos sacs), puis posez le kit pour allumer un feu de cuisine n'importe où ; préparez-en quelques-uns à l'avance (une utilisation toutes les 5 minutes). Les premiers kits portent aussi {skill:185} à environ 5. La quête Introduction au camping : {skill:185} au camp de votre zone de départ vous envoie à ce maître.",

	-- Step 2: Charred Wolf Meat: Auction House
	-- {spell:2538} Charred Wolf Meat
	["{spell:2538}: Auction House"] = "{spell:2538} : hôtel des ventes",
	-- {spell:2538} Charred Wolf Meat · {item:2672} Stringy Wolf Meat
	["What {spell:2538} takes that the Auction House sells: 50 {item:2672}. The counts drop by what your bags, bank and mail hold."] = "Ce que {spell:2538} demande et que vend l'hôtel des ventes : 50 {item:2672}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 3: Charred Wolf Meat: ingredients
	-- {spell:2538} Charred Wolf Meat
	["{spell:2538}: ingredients"] = "{spell:2538} : ingrédients",
	-- {zone:1429} Elwynn Forest
	["Prowler (86%) in {zone:1429}, or wherever the arrow points"] = "Rôdeur (86%) ({zone:1429}), ou là où pointe la flèche",

	-- Step 4: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2538} est orange dès 1 (jaune à 45, vert à 65, gris à 85) : environ 50 préparations jusqu'à 50. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}.",

	-- Step 5: Roasted Boar Meat: Auction House
	-- {spell:2540} Roasted Boar Meat
	["{spell:2540}: Auction House"] = "{spell:2540} : hôtel des ventes",
	-- {spell:2540} Roasted Boar Meat · {item:769} Chunk of Boar Meat
	["What {spell:2540} takes that the Auction House sells: 50 {item:769}. The counts drop by what your bags, bank and mail hold."] = "Ce que {spell:2540} demande et que vend l'hôtel des ventes : 50 {item:769}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 6: Roasted Boar Meat: ingredients
	-- {spell:2540} Roasted Boar Meat
	["{spell:2540}: ingredients"] = "{spell:2540} : ingrédients",
	-- {npc:1126} Large Crag Boar · {npc:1125} Crag Boar · {zone:1426} Dun Morogh
	["{npc:1126} (36%), {npc:1125} (34%) in {zone:1426}, or wherever the arrow points"] = "{npc:1126} (36 %), {npc:1125} (34 %) dans {zone:1426}, ou là où la flèche indique",

	-- Step 7: Roasted Boar Meat (1-50)
	-- {spell:2540} Roasted Boar Meat · {object:29784} Basic Campfire
	["{spell:2540} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2540} est orange dès 1 (jaune à 45, vert à 65, gris à 85) : environ 50 préparations jusqu'à 50. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}.",

	-- Step 8: Herb Baked Egg: shopping
	-- {item:6888} Herb Baked Egg
	["{item:6888}: shopping"] = "{item:6888} : achats",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 50 {item:2678} (1s)."] = "La flèche indique le marchand de votre faction le plus proche pour chaque objet. Il vous faut 50 {item:2678} (1 pa).",

	-- Step 9: Herb Baked Egg: Auction House
	-- {item:6888} Herb Baked Egg
	["{item:6888}: Auction House"] = "{item:6888} : hôtel des ventes",
	-- {item:6888} Herb Baked Egg · {item:6889} Small Egg
	["What {item:6888} takes that the Auction House sells: 50 {item:6889}. The counts drop by what your bags, bank and mail hold."] = "Ce que {item:6888} demande et que vend l'hôtel des ventes : 50 {item:6889}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 10: Herb Baked Egg: ingredients
	-- {item:6888} Herb Baked Egg
	["{item:6888}: ingredients"] = "{item:6888} : ingrédients",
	-- {npc:1995} Strigid Owl · {zone:1438} Teldrassil
	["{npc:1995} (58%) in {zone:1438}, or wherever the arrow points"] = "{npc:1995} (58 %) dans {zone:1438}, ou là où la flèche indique",

	-- Step 11: Herb Baked Egg (1-50)
	-- {item:6888} Herb Baked Egg · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2678} Mild Spices · {zone:1438} Teldrassil · {item:6889} Small Egg · {zone:1439} Darkshore · {item:6290} Brilliant Smallfish · {npc:6286} Zarrin · {area:186} Dolanaar · {item:5472} Kaldorei Spider Kabob
	-- plural, as words: Small Spider Legs = {item:5465} Small Spider Leg
	["{item:6888} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. {item:6888} comes with {skill:185} (the client teaches it with the skill); {item:2678} are a cooking vendor's. The Strigid owls of {zone:1438} drop a {item:6889} more often than not, and {zone:1439}'s moonkin drop them too. Fishers can cook {item:6290} (recipe 40c) from Rut'theran's waters instead, and {npc:6286} in {area:186} gives Recipe of the Kaldorei (seven Small Spider Legs from the Webwood spiders) for {item:5472}, orange from 10 to 50."] = "{item:6888} est orange dès 1 (jaune à 45, vert à 65, gris à 85) : environ 50 préparations jusqu'à 50. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. {item:6888} vient avec {skill:185} (le client l'enseigne avec la compétence) ; les {item:2678} s'achètent chez un marchand de cuisine. Les Hiboux strigides de {zone:1438} laissent tomber un {item:6889} plus d'une fois sur deux, et les séléniens de {zone:1439} aussi. Les pêcheurs peuvent plutôt cuisiner le {item:6290} (recette 40 pc) pêché dans les eaux de Rut'theran, et {npc:6286} à {area:186} donne Une recette kaldorei (sept Petites pattes d'araignée sur les araignées Tissebois) pour {item:5472}, orange de 10 à 50.",

	-- Step 13: Charred Wolf Meat: ingredients
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} in Zephras Isle, or wherever the arrow points"] = "{npc:250873} sur l'île de Zéphras, ou là où la flèche indique",

	-- Step 14: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire · {item:2672} Stringy Wolf Meat
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. The Vuldren of Zephras Isle drop {item:2672}."] = "{spell:2538} est orange dès 1 (jaune à 45, vert à 65, gris à 85) : environ 50 préparations jusqu'à 50. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. Les vuldrènes de l'île de Zéphras laissent tomber de la {item:2672}.",

	-- Step 16: Roasted Boar Meat: ingredients
	-- {npc:3099} Dire Mottled Boar · {zone:1411} Durotar
	["{npc:3099} (99%) in {zone:1411}, or wherever the arrow points"] = "{npc:3099} (99 %) dans {zone:1411}, ou là où la flèche indique",

	-- Step 19: Charred Wolf Meat: ingredients
	-- {npc:2960} Prairie Wolf Alpha · {npc:2959} Prairie Stalker · {zone:1412} Mulgore
	["{npc:2960} (82%), {npc:2959} (77%) in {zone:1412}, or wherever the arrow points"] = "{npc:2960} (82%), {npc:2959} (77%) ({zone:1412}), ou là où pointe la flèche",

	-- Step 22: Charred Wolf Meat: ingredients
	-- {npc:1547} Decrepit Darkhound · {npc:1548} Cursed Darkhound · {zone:1420} Tirisfal Glades
	["{npc:1547} (72%), {npc:1548} (33%) in {zone:1420}, or wherever the arrow points"] = "{npc:1547} (72 %), {npc:1548} (33 %) dans {zone:1420}, ou là où la flèche indique",

	-- Step 24: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "{skill:185} (Compagnon)",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and no character level: the arrow picks the nearest {skill:185} trainer of your faction; training costs 5s."] = "{skill:185} (Compagnon) porte le plafond à 150 ; il demande la compétence 50 et aucun niveau de personnage : la flèche indique le maître de {skill:185} de votre faction le plus proche ; l'apprentissage coûte 5 pa.",

	-- Step 25: Coyote Steak: Auction House
	-- {spell:2541} Coyote Steak
	["{spell:2541}: Auction House"] = "{spell:2541} : hôtel des ventes",
	-- {spell:2541} Coyote Steak · {item:2673} Coyote Meat
	["What {spell:2541} takes that the Auction House sells: 40 {item:2673}. The counts drop by what your bags, bank and mail hold."] = "Ce que {spell:2541} demande et que vend l'hôtel des ventes : 40 {item:2673}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 26: Coyote Steak: ingredients
	-- {spell:2541} Coyote Steak
	["{spell:2541}: ingredients"] = "{spell:2541} : ingrédients",
	-- {npc:834} Coyote · {npc:833} Coyote Packleader · {zone:1436} Westfall
	["{npc:834} (54%), {npc:833} (51%) in {zone:1436}, or wherever the arrow points"] = "{npc:834} (54 %), {npc:833} (51 %) dans {zone:1436}, ou là où la flèche indique",

	-- Step 27: Coyote Steak (50-90)
	-- {spell:2541} Coyote Steak · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {npc:235} Salma Saldean · {area:108} Sentinel Hill · {item:733} Westfall Stew · {item:724} Goretusk Liver Pie
	-- plural, as words: Coyotes = {npc:834} Coyote
	["{spell:2541} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. Coyotes roam the middle of {zone:1436}; {npc:235} on the farm north of {area:108} also gives {item:733} and {item:724} quests that use what you loot here."] = "{spell:2541} est orange dès 50 (jaune à 90, vert à 110, gris à 130) : environ 40 préparations jusqu'à 90. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. Tout maître de {skill:185} l'enseigne dès la compétence 50 pour 1 pa. Les Coyotes parcourent le centre de {zone:1436} ; {npc:235}, à la ferme au nord de {area:108}, donne aussi des quêtes de {item:733} et de {item:724} qui utilisent ce que vous ramassez ici.",

	-- Step 28: Crab Cake: shopping
	-- {spell:2544} Crab Cake
	["{spell:2544}: shopping"] = "{spell:2544} : achats",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 44 {item:2678} (90c)."] = "La flèche indique le marchand de votre faction le plus proche pour chaque objet. Il vous faut 44 {item:2678} (90 pc).",

	-- Step 29: Crab Cake: Auction House
	-- {spell:2544} Crab Cake
	["{spell:2544}: Auction House"] = "{spell:2544} : hôtel des ventes",
	-- {spell:2544} Crab Cake · {item:2674} Crawler Meat
	["What {spell:2544} takes that the Auction House sells: 44 {item:2674}. The counts drop by what your bags, bank and mail hold."] = "Ce que {spell:2544} demande et que vend l'hôtel des ventes : 44 {item:2674}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 30: Crab Cake: ingredients
	-- {spell:2544} Crab Cake
	["{spell:2544}: ingredients"] = "{spell:2544} : ingrédients",
	-- {npc:830} Sand Crawler · {zone:1436} Westfall
	["{npc:830} (43%) in {zone:1436}, or wherever the arrow points"] = "{npc:830} (43 %) dans {zone:1436}, ou là où la flèche indique",

	-- Step 31: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1436} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544} est orange dès 90 (jaune à 115, vert à 135, gris à 155) : environ 44 préparations jusqu'à 130. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. Tout maître de {skill:185} l'enseigne dès la compétence 75 pour 2 pa. Les clampants bordent toute la côte de {zone:1436}. Cuisinez-le jusqu'à 130, où {spell:3376} prend le relais.",

	-- Step 32: Smoked Bear Meat: shopping
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: shopping"] = "{item:6890} : achats",
	["The arrow picks the nearest vendor of your faction for each item."] = "La flèche indique le marchand le plus proche de votre faction pour chaque objet.",

	-- Step 33: Smoked Bear Meat: Auction House
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: Auction House"] = "{item:6890} : hôtel des ventes",
	-- {item:6890} Smoked Bear Meat · {item:3173} Bear Meat
	["What {item:6890} takes that the Auction House sells: 30 {item:3173}. The counts drop by what your bags, bank and mail hold."] = "Ce que {item:6890} demande et que vend l'hôtel des ventes : 30 {item:3173}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 34: Smoked Bear Meat: ingredients
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: ingredients"] = "{item:6890} : ingrédients",
	-- {npc:1189} Black Bear Patriarch · {zone:1432} Loch Modan
	["{npc:1189} (39%) in {zone:1432}, or wherever the arrow points"] = "{npc:1189} (39 %) dans {zone:1432}, ou là où la flèche indique",

	-- Step 35: Smoked Bear Meat (50-80)
	-- {item:6890} Smoked Bear Meat · {object:29784} Basic Campfire · {item:6892} Recipe: Smoked Bear Meat · {zone:1432} Loch Modan
	["{item:6890} is orange from 50 (yellow at 80, green at 100, grey at 120): about 30 crafts to 80. Cook at any fire: a town hearth or your own {object:29784}. {item:6892} costs 2s 50c at its vendor; the arrow picks the nearest one of your faction. Black bears roam the hills of {zone:1432}."] = "{item:6890} est orange dès 50 (jaune à 80, vert à 100, gris à 120) : environ 30 préparations jusqu'à 80. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. {item:6892} coûte 2 pa 50 pc chez son marchand ; la flèche indique le plus proche de votre faction. Les ours noirs parcourent les collines du {zone:1432}.",

	-- Step 36: Dry Pork Ribs: shopping
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: shopping"] = "{spell:2546} : achats",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2678} (1s 10c)."] = "La flèche indique le marchand de votre faction le plus proche pour chaque objet. Il vous faut 52 {item:2678} (1 pa 10 pc).",

	-- Step 37: Dry Pork Ribs: Auction House
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: Auction House"] = "{spell:2546} : hôtel des ventes",
	-- {spell:2546} Dry Pork Ribs · {item:2677} Boar Ribs
	["What {spell:2546} takes that the Auction House sells: 52 {item:2677}. The counts drop by what your bags, bank and mail hold."] = "Ce que {spell:2546} demande et que vend l'hôtel des ventes : 52 {item:2677}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 38: Dry Pork Ribs: ingredients
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: ingredients"] = "{spell:2546} : ingrédients",
	-- {npc:1191} Mangy Mountain Boar · {zone:1432} Loch Modan
	["{npc:1191} (31%) in {zone:1432}, or wherever the arrow points"] = "{npc:1191} (31 %) dans {zone:1432}, ou là où la flèche indique",

	-- Step 39: Dry Pork Ribs (80-130)
	-- {spell:2546} Dry Pork Ribs · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1432} Loch Modan · {spell:3376} Curiously Tasty Omelet
	["{spell:2546} is orange from 80 (yellow at 120, green at 140, grey at 160): about 52 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 80 for 1s 50c. Mountain boars roam all of {zone:1432}. Cook it to 130, where {spell:3376} takes over."] = "{spell:2546} est orange dès 80 (jaune à 120, vert à 140, gris à 160) : environ 52 préparations jusqu'à 130. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. Tout maître de {skill:185} l'enseigne dès la compétence 80 pour 1 pa 50 pc. Les sangliers des montagnes parcourent tout le {zone:1432}. Cuisinez-le jusqu'à 130, où {spell:3376} prend le relais.",

	-- Step 40: Boiled Clams: shopping
	-- {item:5525} Boiled Clams
	["{item:5525}: shopping"] = "{item:5525} : achats",
	-- {item:159} Refreshing Spring Water
	["The arrow picks the nearest vendor of your faction for each item. You need 40 {item:159} (2s)."] = "La flèche indique le marchand de votre faction le plus proche pour chaque objet. Il vous faut 40 {item:159} (2 pa).",

	-- Step 41: Boiled Clams: ingredients
	-- {item:5525} Boiled Clams
	["{item:5525}: ingredients"] = "{item:5525} : ingrédients",
	-- {npc:3812} Clattering Crawler · {npc:3814} Spined Crawler · {npc:3944} Wrathtail Priestess · {zone:1439} Darkshore · {item:5523} Small Barnacled Clam · {item:5503} Clam Meat
	["{npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) in {zone:1439}, or wherever the arrow points; open each {item:5523} for its {item:5503}"] = "{npc:3812} (42 %), {npc:3814} (42 %), {npc:3944} (42 %) dans {zone:1439}, ou là où la flèche indique ; ouvrez chaque {item:5523} pour sa {item:5503}",

	-- Step 42: Boiled Clams (50-90)
	-- {item:5525} Boiled Clams · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2674} Crawler Meat · {spell:2544} Crab Cake
	["{item:5525} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. The same coastal crawlers drop {item:2674} for {spell:2544} next: keep it."] = "{item:5525} est orange dès 50 (jaune à 90, vert à 110, gris à 130) : environ 40 préparations jusqu'à 90. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. Tout maître de {skill:185} l'enseigne dès la compétence 50 pour 1 pa. Les mêmes clampants de la côte laissent tomber de la {item:2674} pour {spell:2544} ensuite : gardez-la.",

	-- Step 45: Crab Cake: ingredients
	-- {npc:3814} Spined Crawler · {npc:3812} Clattering Crawler · {zone:1439} Darkshore
	["{npc:3814} (42%), {npc:3812} (40%) in {zone:1439}, or wherever the arrow points"] = "{npc:3814} (42 %), {npc:3812} (40 %) dans {zone:1439}, ou là où la flèche indique",

	-- Step 46: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1439} Darkshore · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1439} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544} est orange dès 90 (jaune à 115, vert à 135, gris à 155) : environ 44 préparations jusqu'à 130. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. Tout maître de {skill:185} l'enseigne dès la compétence 75 pour 2 pa. Les clampants bordent toute la côte de {zone:1439}. Cuisinez-le jusqu'à 130, où {spell:3376} prend le relais.",

	-- Step 47: Strider Stew: shopping
	-- {item:5477} Strider Stew
	["{item:5477}: shopping"] = "{item:5477} : achats",
	-- {item:4536} Shiny Red Apple
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:4536} (2s 75c)."] = "La flèche indique le marchand de votre faction le plus proche pour chaque objet. Il vous faut 52 {item:4536} (2 pa 75 pc).",

	-- Step 48: Strider Stew: Auction House
	-- {item:5477} Strider Stew
	["{item:5477}: Auction House"] = "{item:5477} : hôtel des ventes",
	-- {item:5477} Strider Stew · {item:5469} Strider Meat
	["What {item:5477} takes that the Auction House sells: 52 {item:5469}. The counts drop by what your bags, bank and mail hold."] = "Ce que {item:5477} demande et que vend l'hôtel des ventes : 52 {item:5469}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 49: Strider Stew: ingredients
	-- {item:5477} Strider Stew
	["{item:5477}: ingredients"] = "{item:5477} : ingrédients",
	-- {npc:3246} Fleeting Plainstrider · {zone:1413} The Barrens
	["{npc:3246} (32%) in {zone:1413}, or wherever the arrow points"] = "{npc:3246} (32 %) dans les {zone:1413}, ou là où la flèche indique",

	-- Step 50: Strider Stew (50-100)
	-- {item:5477} Strider Stew · {object:29784} Basic Campfire · {item:5486} Recipe: Strider Stew
	["{item:5477} is orange from 50 (yellow at 90, green at 110, grey at 130): about 52 crafts to 100. Cook at any fire: a town hearth or your own {object:29784}. {item:5486} costs 4s 40c at its vendor; the arrow picks the nearest one of your faction."] = "{item:5477} est orange dès 50 (jaune à 90, vert à 110, gris à 130) : environ 52 préparations jusqu'à 100. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. {item:5486} coûte 4 pa 40 pc chez son marchand ; la flèche indique le plus proche de votre faction.",

	-- Step 51: Crispy Lizard Tail: shopping
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: shopping"] = "{item:5479} : achats",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 30 {item:2692} (12s)."] = "La flèche indique le marchand de votre faction le plus proche pour chaque objet. Il vous faut 30 {item:2692} (12 pa).",

	-- Step 52: Crispy Lizard Tail: Auction House
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: Auction House"] = "{item:5479} : hôtel des ventes",
	-- {item:5479} Crispy Lizard Tail · {item:5470} Thunder Lizard Tail
	["What {item:5479} takes that the Auction House sells: 30 {item:5470}. The counts drop by what your bags, bank and mail hold."] = "Ce que {item:5479} demande et que vend l'hôtel des ventes : 30 {item:5470}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 53: Crispy Lizard Tail: ingredients
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: ingredients"] = "{item:5479} : ingrédients",
	-- {npc:3239} Thunderhead · {zone:1413} The Barrens
	["{npc:3239} (59%), Owatanka (35%) in {zone:1413}, or wherever the arrow points"] = "{npc:3239} (59%), Owatanka (35%) ({zone:1413}), ou là où pointe la flèche",

	-- Step 54: Crispy Lizard Tail (100-130)
	-- {item:5479} Crispy Lizard Tail · {object:29784} Basic Campfire · {item:5488} Recipe: Crispy Lizard Tail · {npc:3489} Zargh · {item:3735} Recipe: Hot Lion Chops
	["{item:5479} is orange from 100 (yellow at 140, green at 160, grey at 180): about 30 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. {item:5488} costs 4s at its vendor; the arrow picks the nearest one of your faction. {npc:3489}, the butcher beside this vendor at the Crossroads, sells {item:3735} (18s), the recipe after Expert: buy it now."] = "{item:5479} est orange dès 100 (jaune à 140, vert à 160, gris à 180) : environ 30 préparations jusqu'à 130. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. {item:5488} coûte 4 pa chez son marchand ; la flèche indique le plus proche de votre faction. {npc:3489}, le boucher à côté de ce marchand à la Croisée, vend {item:3735} (18 pa), la recette qui suit Expert : achetez-la maintenant.",

	-- Step 55: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "{skill:185} (Expert)",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook
	["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072} (1g); the arrow picks its nearest seller for your faction. Buy it and read it."] = "{skill:185} (Expert) porte le plafond à 225 ; il demande la compétence 125 et le niveau 20 : c'est un livre, {item:16072} (1 po) ; la flèche indique son vendeur le plus proche pour votre faction. Achetez-le et lisez-le.",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "Achetez et lisez {item:16072} ({skill:185} Expert)",

	-- Step 56: Curiously Tasty Omelet: shopping
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: shopping"] = "{spell:3376} : achats",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 46 {item:2692} (18s 40c)."] = "La flèche indique le marchand de votre faction le plus proche pour chaque objet. Il vous faut 46 {item:2692} (18 pa 40 pc).",

	-- Step 57: Curiously Tasty Omelet: Auction House
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: Auction House"] = "{spell:3376} : hôtel des ventes",
	-- {spell:3376} Curiously Tasty Omelet · {item:3685} Raptor Egg
	["What {spell:3376} takes that the Auction House sells: 46 {item:3685}. The counts drop by what your bags, bank and mail hold."] = "Ce que {spell:3376} demande et que vend l'hôtel des ventes : 46 {item:3685}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 58: Curiously Tasty Omelet: ingredients
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: ingredients"] = "{spell:3376} : ingrédients",
	-- {npc:1018} Highland Razormaw · {npc:1019} Elder Razormaw · {zone:1437} Wetlands
	["{npc:1018} (72%), {npc:1019} (67%) in {zone:1437}, or wherever the arrow points"] = "{npc:1018} (72%), {npc:1019} (67%) ({zone:1437}), ou là où pointe la flèche",

	-- Step 59: Curiously Tasty Omelet (130-175)
	-- {spell:3376} Curiously Tasty Omelet · {object:29784} Basic Campfire · {item:3682} Recipe: Curiously Tasty Omelet · {zone:1437} Wetlands · {item:3685} Raptor Egg · {npc:340} Kendor Kabonka · {zone:1453} Stormwind
	["{spell:3376} is orange from 130 (yellow at 170, green at 190, grey at 210): about 46 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3682} costs 16s at its vendor; the arrow picks the nearest one of your faction. The raptors of the {zone:1437} drop a {item:3685} about two kills in three. {npc:340} in {zone:1453} sells the recipe."] = "{spell:3376} est orange dès 130 (jaune à 170, vert à 190, gris à 210) : environ 46 préparations jusqu'à 175. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. {item:3682} coûte 16 pa chez son marchand ; la flèche indique le plus proche de votre faction. Les raptors des {zone:1437} laissent tomber un {item:3685} environ deux fois sur trois. {npc:340} à {zone:1453} vend la recette.",

	-- Step 60: Hot Lion Chops: shopping
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: shopping"] = "{spell:3398} : achats",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 45 {item:2692} (18s)."] = "La flèche indique le marchand de votre faction le plus proche pour chaque objet. Il vous faut 45 {item:2692} (18 pa).",

	-- Step 61: Hot Lion Chops: Auction House
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: Auction House"] = "{spell:3398} : hôtel des ventes",
	-- {spell:3398} Hot Lion Chops · {item:3731} Lion Meat
	["What {spell:3398} takes that the Auction House sells: 45 {item:3731}. The counts drop by what your bags, bank and mail hold."] = "Ce que {spell:3398} demande et que vend l'hôtel des ventes : 45 {item:3731}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 62: Hot Lion Chops: ingredients
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: ingredients"] = "{spell:3398} : ingrédients",
	-- {npc:2384} Starving Mountain Lion · {zone:1424} Hillsbrad Foothills
	["{npc:2384} (42%) in {zone:1424}, or wherever the arrow points"] = "{npc:2384} (42 %) dans les {zone:1424}, ou là où la flèche indique",

	-- Step 63: Hot Lion Chops (130-175)
	-- {spell:3398} Hot Lion Chops · {object:29784} Basic Campfire · {item:3735} Recipe: Hot Lion Chops · {item:3731} Lion Meat
	-- plural, as words: Hulking Mountain Lions = {npc:2407} Hulking Mountain Lion
	["{spell:3398} is orange from 130 (yellow at 175, green at 195, grey at 215): about 45 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3735} costs 18s at its vendor; the arrow picks the nearest one of your faction. The Feral and Hulking Mountain Lions of Hillsbrad Foothills drop {item:3731} more often than the Starving ones."] = "{spell:3398} est orange dès 130 (jaune à 175, vert à 195, gris à 215) : environ 45 préparations jusqu'à 175. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. {item:3735} coûte 18 pa chez son marchand ; la flèche indique le plus proche de votre faction. Les Lions des montagnes farouches et massifs des contreforts de Hautebrande laissent tomber de la {item:3731} plus souvent que les affamés.",

	-- Step 64: Roast Raptor: shopping
	-- {item:12210} Roast Raptor
	["{item:12210}: shopping"] = "{item:12210} : achats",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2692} (20s 80c)."] = "La flèche indique le marchand de votre faction le plus proche pour chaque objet. Il vous faut 52 {item:2692} (20 pa 80 pc).",

	-- Step 65: Roast Raptor: Auction House
	-- {item:12210} Roast Raptor
	["{item:12210}: Auction House"] = "{item:12210} : hôtel des ventes",
	-- {item:12210} Roast Raptor · {item:12184} Raptor Flesh
	["What {item:12210} takes that the Auction House sells: 52 {item:12184}. The counts drop by what your bags, bank and mail hold."] = "Ce que {item:12210} demande et que vend l'hôtel des ventes : 52 {item:12184}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 66: Roast Raptor: ingredients
	-- {item:12210} Roast Raptor
	["{item:12210}: ingredients"] = "{item:12210} : ingrédients",
	-- {npc:2560} Highland Thrasher · {zone:1417} Arathi Highlands
	["{npc:2560} (38%) in {zone:1417}, or wherever the arrow points"] = "{npc:2560} (38 %) dans les {zone:1417}, ou là où la flèche indique",

	-- Step 67: Roast Raptor (175-225)
	-- {item:12210} Roast Raptor · {object:29784} Basic Campfire · {item:12228} Recipe: Roast Raptor · {zone:1417} Arathi Highlands · {npc:2810} Hammon Karwn · {area:320} Refuge Pointe · {npc:2821} Keena · {area:321} Hammerfall · {item:2692} Hot Spices · {item:17222} Spider Sausage · {item:12205} White Spider Meat
	["{item:12210} is orange from 175 (yellow at 215, green at 235, grey at 255): about 52 crafts to 225. Cook at any fire: a town hearth or your own {object:29784}. {item:12228} costs 50s at its vendor; the arrow picks the nearest one of your faction. {zone:1417}: {npc:2810} at {area:320} (Alliance) and {npc:2821} at {area:321} (Horde) sell the recipe and {item:2692} beside the raptors. {item:17222} (any trainer from 200, 40s) is the alternative, but it takes two {item:12205} a craft and Dustwallow's spiders drop one about two kills in five."] = "{item:12210} est orange dès 175 (jaune à 215, vert à 235, gris à 255) : environ 52 préparations jusqu'à 225. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. {item:12228} coûte 50 pa chez son marchand ; la flèche indique le plus proche de votre faction. {zone:1417} : {npc:2810} à {area:320} (Alliance) et {npc:2821} à {area:321} (Horde) vendent la recette et les {item:2692} à côté des raptors. {item:17222} (tout maître dès 200, 40 pa) est l'autre option, mais elle demande deux {item:12205} par préparation, et les araignées du marécage d'Âprefange en laissent tomber une environ deux fois sur cinq.",

	-- Step 68: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "{skill:185} (Artisan) s'apprend auprès de {npc:8125} à {area:976} ({zone:1446}). Le maître cuisinier de {zone:1455} vous y envoie ; requiert la compétence 225 et le niveau 35.",

	-- Step 69: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "{skill:185} (Artisan) s'apprend auprès de {npc:8125} à {area:976} ({zone:1446}). Le maître cuisinier d'{zone:1454} vous y envoie ; requiert la compétence 225 et le niveau 35.",

	-- Step 70: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "Oeufs géants",
	-- {quest:6610} Clamlette Surprise · {item:7974} Zesty Clam Meat · {item:8932} Alterac Swiss · {zone:1446} Tanaris · {zone:1425} The Hinterlands · {npc:2929} Savage Owlbeast · {item:12218} Monster Omelet
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["{quest:6610} asks for 12 Giant Eggs, 10 {item:7974} and 20 {item:8932}: bring all three before you go to {zone:1446}, so you make the trip once. Giant Eggs drop from the owlbeasts of {zone:1425}: {npc:2929} (54%). {item:12218} takes about 120 more after Artisan: farm them now too if you like."] = "{quest:6610} demande 12 Oeufs géants, 10 {item:7974} et 20 {item:8932} : apportez les trois avant d'aller en {zone:1446}, pour ne faire le trajet qu'une fois. Les Oeufs géants tombent sur les chouettards des {zone:1425} : {npc:2929} (54 %). L'{item:12218} en demande environ 120 de plus après Artisan : récoltez-les aussi maintenant si vous voulez.",

	-- Step 71: Alterac Swiss
	-- {item:8932} Alterac Swiss
	["Innkeepers and food vendors sell {item:8932}; the arrow picks the nearest."] = "Les aubergistes et les marchands de nourriture vendent du {item:8932} ; la flèche indique le plus proche.",

	-- Step 72: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {zone:1445} Dustwallow Marsh · {zone:1446} Tanaris
	-- plural, as words: Big-mouth Clams = {item:7973} Big-mouth Clam · Steeljaw Snappers = {npc:14123} Steeljaw Snapper
	["{item:7974} comes from Big-mouth Clams: open each one, every clam holds one. The Muckshell crabs on the {zone:1445} coast south-west of Theramore drop a clam about seven kills in ten, so ten clams take about fifteen kills, on your way to {zone:1446}. The Steeljaw Snappers on {zone:1446}'s east coast drop them about one kill in three."] = "La {item:7974} vient des Palourdes à large bouche : ouvrez-les une à une, chaque palourde en contient une. Les crabes Bourbecoque sur la côte du {zone:1445}, au sud-ouest de Theramore, laissent tomber une palourde environ sept fois sur dix, donc dix palourdes demandent une quinzaine de victimes, sur votre route vers {zone:1446}. Les Mordeuses mâchoire d'acier de la côte est de {zone:1446} en laissent tomber environ une fois sur trois.",

	-- Step 73: Clamlette Surprise
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "{skill:185} (Artisan)",

	-- Step 74: Monster Omelet: shopping
	-- {item:12218} Monster Omelet
	["{item:12218}: shopping"] = "{item:12218} : achats",
	-- {item:3713} Soothing Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 240 {item:3713} (3g 84s)."] = "La flèche indique le marchand de votre faction le plus proche pour chaque objet. Il vous faut 240 {item:3713} (3 po 84 pa).",

	-- Step 75: Monster Omelet: Auction House
	-- {item:12218} Monster Omelet
	["{item:12218}: Auction House"] = "{item:12218} : hôtel des ventes",
	-- {item:12218} Monster Omelet · {item:12207} Giant Egg
	["What {item:12218} takes that the Auction House sells: 120 {item:12207}. The counts drop by what your bags, bank and mail hold."] = "Ce que {item:12218} demande et que vend l'hôtel des ventes : 120 {item:12207}. Les quantités baissent selon ce que contiennent vos sacs, votre banque et votre courrier.",

	-- Step 76: Monster Omelet: ingredients
	-- {item:12218} Monster Omelet
	["{item:12218}: ingredients"] = "{item:12218} : ingrédients",
	-- {npc:2929} Savage Owlbeast · {zone:1425} The Hinterlands
	["{npc:2929} (54%) in {zone:1425}, or wherever the arrow points"] = "{npc:2929} (54 %) dans les {zone:1425}, ou là où la flèche indique",

	-- Step 77: Monster Omelet (225-300)
	-- {item:12218} Monster Omelet · {object:29784} Basic Campfire · {item:16110} Recipe: Monster Omelet · {item:13931} Nightfin Soup · {npc:8137} Gikkix · {area:977} Steamwheedle Port · {item:13932} Poached Sunscale Salmon · {item:279982} Iron Oven
	["{item:12218} is orange from 225 (yellow at 265, green at 285, grey at 305): about 120 crafts to 300. Cook at any fire: a town hearth or your own {object:29784}. {item:16110} costs 1g 20s at its vendor; the arrow picks the nearest one of your faction. {item:12218} is orange to 265 and green from 285, yet it still carries you to 300. Fishers can finish on {item:13931} ({npc:8137}, {area:977}; yellow to 310) instead; {item:13932} needs an {item:279982} on Forever."] = "L'{item:12218} est orange dès 225 (jaune à 265, vert à 285, gris à 305) : environ 120 préparations jusqu'à 300. Cuisinez à n'importe quel feu : le foyer d'une ville ou votre propre {object:29784}. {item:16110} coûte 1 po 20 pa chez son marchand ; la flèche indique le plus proche de votre faction. L'{item:12218} est orange jusqu'à 265 et vert dès 285, mais elle vous mène quand même à 300. Les pêcheurs peuvent plutôt finir avec la {item:13931} ({npc:8137}, {area:977} ; jaune jusqu'à 310) ; le {item:13932} demande un {item:279982} sur Forever.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5); the arrow picks the nearest."] = "Tout maître en {skill:185} de votre faction enseigne {skill:185} (Apprenti) (niveau 5) ; la flèche indique le plus proche.",
	-- ["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5, 1s); the arrow picks the nearest. Forever: every cook knows {object:29784}. Craft a {item:279981} from one {item:4470} (38c) with {item:4471} (1s 35c, kept in your bags), then place the kit to light a cooking fire anywhere; make a few in advance (one use every 5 minutes). The first kits also raise {skill:185} to about 5. The Camping 101: {skill:185} quest at your starting area's camp sends you to this trainer."] = "Tout maître de {skill:185} de votre faction enseigne {skill:185} (Apprenti) (niveau 5, 1 pa) ; la flèche indique le plus proche. Sur Forever, tout cuisinier connaît {object:29784}. Fabriquez un {item:279981} à partir d'un {item:4470} (38 pc) avec un {item:4471} (1 pa 35 pc, gardé dans vos sacs), puis posez le kit pour allumer un feu de cuisine n'importe où ; préparez-en quelques-uns à l'avance (une utilisation toutes les 5 minutes). Les premiers kits portent aussi {skill:185} à environ 5. La quête Introduction au camping : {skill:185} au camp de votre zone de départ vous envoie à ce maître.",
	-- ["Catch about 50 {item:6291} here by fishing (see the {skill:356} guide)."] = "Pêchez ici environ 50 {item:6291} (voir le guide de {skill:356}).",
	-- ["Catch about 68 {item:6361} here by fishing (see the {skill:356} guide)."] = "Pêchez ici environ 68 {item:6361} (voir le guide de {skill:356}).",
	-- ["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072}; the arrow picks its nearest seller for your faction. Buy it and read it."] = "{skill:185} (Expert) porte le plafond à 225 ; requiert la compétence 125 et le niveau 20 : c'est un livre, {item:16072} ; la flèche indique son vendeur le plus proche pour votre faction. Achetez-le et lisez-le.",
	-- ["Giant Eggs drop from the Ironbeak owls of {zone:1448}."] = "Les Oeufs géants sont laissés par les chouettes Bec-de-fer de {zone:1448}.",
	-- ["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction."] = "{skill:185} (Compagnon) porte le plafond à 150 ; requiert la compétence 50 et le niveau 10 : la flèche indique le maître en {skill:185} le plus proche de votre faction.",
	-- ["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction; training costs 5s."] = "{skill:185} (Compagnon) porte le plafond à 150 ; il demande la compétence 50 et le niveau 10 : la flèche indique le maître de {skill:185} de votre faction le plus proche ; l'apprentissage coûte 5 pa.",
	-- ["{area:442} docks"] = "Quais d'{area:442}",
	-- ["{area:702} docks"] = "Quais de {area:702}",
	-- ["{item:12210} is orange from 175 (yellow at 215, grey at 255): about 40 crafts to 215. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12210} est orange dès 175 (jaune à 215, gris à 255) : environ 40 préparations jusqu'à 215. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{item:12215} is orange from 215 (yellow at 240, grey at 280): about 10 crafts to 225. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215} est orange dès 215 (jaune à 240, gris à 280) : environ 10 préparations jusqu'à 225. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{item:12215} is orange from 225 (yellow at 240, grey at 280): about 15 crafts to 240. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215} est orange dès 225 (jaune à 240, gris à 280) : environ 15 préparations jusqu'à 240. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{item:12215}: ingredients"] = "{item:12215} : ingrédients",
	-- ["{item:12215}: shopping"] = "{item:12215} : achats",
	-- ["{item:12218} is orange from 240 (yellow at 265, grey at 305): about 105 crafts to 300. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12218} est orange dès 240 (jaune à 265, gris à 305) : environ 105 préparations jusqu'à 300. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{item:5095} is orange from 50 (yellow at 90, grey at 130): about 68 crafts to 110. Cook at any fire: {object:29784} comes with {skill:185}. {skill:356} off the {area:442} docks catches {item:6361}."] = "{item:5095} est orange dès 50 (jaune à 90, gris à 130) : environ 68 préparations jusqu'à 110. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}. La {skill:356} depuis les quais d'{area:442} rapporte des {item:6361}.",
	-- ["{item:5095}: ingredients"] = "{item:5095} : ingrédients",
	-- ["{item:5095}: shopping"] = "{item:5095} : achats",
	-- ["{item:5477} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5477} est orange dès 50 (jaune à 90, gris à 130) : environ 52 préparations jusqu'à 100. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{item:5479} is orange from 100 (yellow at 140, grey at 180): about 25 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479} est orange dès 100 (jaune à 140, gris à 180) : environ 25 préparations jusqu'à 125. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{item:5479} is orange from 125 (yellow at 140, grey at 180): about 15 crafts to 140. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479} est orange dès 125 (jaune à 140, gris à 180) : environ 15 préparations jusqu'à 140. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{item:5480} is orange from 110 (yellow at 150, grey at 190): about 15 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480} est orange dès 110 (jaune à 150, gris à 190) : environ 15 préparations jusqu'à 125. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{item:5480} is orange from 125 (yellow at 150, grey at 190): about 25 crafts to 150. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480} est orange dès 125 (jaune à 150, gris à 190) : environ 25 préparations jusqu'à 150. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{item:5480}: ingredients"] = "{item:5480} : ingrédients",
	-- ["{item:5480}: shopping"] = "{item:5480} : achats",
	-- ["{item:6290} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}. {item:6291} is the common catch in {zone:1438}'s waters."] = "{item:6290} est orange dès 1 (jaune à 45, gris à 85) : environ 50 préparations jusqu'à 50. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}. {item:6291} est la prise courante dans les eaux de {zone:1438}.",
	-- ["{item:6290}: ingredients"] = "{item:6290} : ingrédients",
	-- ["{item:6290}: shopping"] = "{item:6290} : achats",
	-- ["{item:6316} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:6316} est orange dès 50 (jaune à 90, gris à 130) : environ 52 préparations jusqu'à 100. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{item:6316}: ingredients"] = "{item:6316} : ingrédients",
	-- ["{item:6316}: shopping"] = "{item:6316} : achats",
	-- ["{item:724} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:724} est orange dès 50 (jaune à 90, gris à 130) : environ 52 préparations jusqu'à 100. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{item:724}: ingredients"] = "{item:724} : ingrédients",
	-- ["{item:724}: shopping"] = "{item:724} : achats",
	-- ["{item:7974} has no drop data: buy it at the Gadgetzan Auction House, next to {npc:8125}, or open clams looted from coastal creatures."] = "{item:7974} n'a pas de données de butin : achetez-la à l'hôtel des ventes de Gadgetzan, à côté de {npc:8125}, ou ouvrez les palourdes ramassées sur les créatures côtières.",
	-- ["{item:7974} has no drop data: buy it at the {object:175904} House, next to Dirge, or open clams looted from coastal creatures."] = "Aucune donnée de butin pour {item:7974} : achetez-en à l'hôtel des ventes ({object:175904}), à côté de Dirge, ou ouvrez les palourdes récupérées sur les créatures côtières.",
	-- ["{npc:1193} (50%) in {zone:1432}, or wherever the arrow points"] = "{npc:1193} (50%) ({zone:1432}), ou là où pointe la flèche",
	-- ["{npc:1400} (50%) in {zone:1437}, or wherever the arrow points"] = "{npc:1400} (50%) ({zone:1437}), ou là où pointe la flèche",
	-- ["{npc:1549} (88%) in {zone:1420}, or wherever the arrow points"] = "{npc:1549} (88%) ({zone:1420}), ou là où pointe la flèche",
	-- ["{npc:1689} (38%), {npc:1127} (36%) in {zone:1426}, or wherever the arrow points"] = "{npc:1689} (38%), {npc:1127} (36%) ({zone:1426}), ou là où pointe la flèche",
	-- ["{npc:2385} (56%) in {zone:1424}, or wherever the arrow points"] = "{npc:2385} (56%) ({zone:1424}), ou là où pointe la flèche",
	-- ["{npc:3099} (99%), {npc:3100} (74%) in {zone:1411}, or wherever the arrow points"] = "{npc:3099} (99%), {npc:3100} (74%) ({zone:1411}), ou là où pointe la flèche",
	-- ["{npc:3244} (33%) in {zone:1413}, or wherever the arrow points"] = "{npc:3244} (33%) ({zone:1413}), ou là où pointe la flèche",
	-- ["{npc:3818} (53%) in {zone:1440}, or wherever the arrow points"] = "{npc:3818} (53%) ({zone:1440}), ou là où pointe la flèche",
	-- ["{npc:4352} (52%), {npc:4351} (51%) in {zone:1445}, or wherever the arrow points"] = "{npc:4352} (52%), {npc:4351} (51%) ({zone:1445}), ou là où pointe la flèche",
	-- ["{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) in {zone:1443}, or wherever the arrow points"] = "{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) ({zone:1443}), ou là où pointe la flèche",
	-- ["{npc:547} (35%), {npc:157} (34%) in {zone:1436}, or wherever the arrow points"] = "{npc:547} (35%), {npc:157} (34%) ({zone:1436}), ou là où pointe la flèche",
	-- ["{npc:7099} (40%) in {zone:1448}, or wherever the arrow points"] = "{npc:7099} (40%) ({zone:1448}), ou là où pointe la flèche",
	-- ["{quest:6610} asks for 20 {item:8932} (check the quest log); innkeepers and food vendors sell it, and the arrow picks the nearest."] = "{quest:6610} demande 20 {item:8932} (voir le journal des quêtes) ; les aubergistes et marchands de nourriture en vendent, et la flèche indique le plus proche.",
	-- ["{spell:2538} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2538} est orange dès 1 (jaune à 45, gris à 85) : environ 50 préparations jusqu'à 50. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{spell:2540} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2540} est orange dès 1 (jaune à 45, gris à 85) : environ 50 préparations jusqu'à 50. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{spell:3370} is orange from 100 (yellow at 120, grey at 160): about 26 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370} est orange dès 100 (jaune à 120, gris à 160) : environ 26 préparations jusqu'à 125. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{spell:3370} is yellow from 125 (yellow at 120, grey at 160): about 7 crafts to 130. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370} est jaune dès 125 (jaune à 120, gris à 160) : environ 7 préparations jusqu'à 130. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{spell:3370}: ingredients"] = "{spell:3370} : ingrédients",
	-- ["{spell:3370}: shopping"] = "{spell:3370} : achats",
	-- ["{spell:3376} is orange from 130 (yellow at 170, grey at 210): about 46 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376} est orange dès 130 (jaune à 170, gris à 210) : environ 46 préparations jusqu'à 175. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{spell:3376} is orange from 150 (yellow at 170, grey at 210): about 26 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376} est orange dès 150 (jaune à 170, gris à 210) : environ 26 préparations jusqu'à 175. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
	-- ["{spell:3398} is orange from 140 (yellow at 175, grey at 215): about 35 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3398} est orange dès 140 (jaune à 175, gris à 215) : environ 35 préparations jusqu'à 175. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",
}
