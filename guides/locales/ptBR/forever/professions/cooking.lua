-- Portuguese (Brazil) (ptBR): the guide forever/professions/cooking (forever/professions/cooking.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Cooking
	-- {skill:185} Cooking
	["Learn {skill:185}"] = "Aprender {skill:185}",
	-- {skill:185} Cooking · {object:29784} Basic Campfire · {item:279981} Basic Campfire Kit · {item:4470} Simple Wood · {item:4471} Flint and Tinder
	["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5, 1s); the arrow picks the nearest. Forever: every cook knows {object:29784}. Craft a {item:279981} from one {item:4470} (38c) with {item:4471} (1s 35c, kept in your bags), then place the kit to light a cooking fire anywhere; make a few in advance (one use every 5 minutes). The first kits also raise {skill:185} to about 5. The Camping 101: {skill:185} quest at your starting area's camp sends you to this trainer."] = "Qualquer instrutor de {skill:185} da sua facção ensina {skill:185} Aprendiz (nível de personagem 5, 1s); a seta escolhe o mais próximo. Forever: todo cozinheiro conhece {object:29784}. Crie um {item:279981} a partir de uma {item:4470} (38c) com {item:4471} (1s 35c, mantido nas bolsas), depois coloque o kit para acender uma fogueira de cozinha em qualquer lugar; faça alguns com antecedência (um uso a cada 5 minutos). Os primeiros kits também elevam {skill:185} a cerca de 5. A missão Introdução ao acampamento: {skill:185}, no acampamento da sua área inicial, manda você a este instrutor.",

	-- Step 2: Charred Wolf Meat: ingredients
	-- {spell:2538} Charred Wolf Meat
	["{spell:2538}: ingredients"] = "{spell:2538}: ingredientes",
	-- {zone:1429} Elwynn Forest
	["Prowler (86%) in {zone:1429}, or wherever the arrow points"] = "Predador (86%) em {zone:1429}, ou onde a seta apontar",

	-- Step 3: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2538} é laranja desde 1 (amarelo em 45, verde em 65, cinza em 85): cerca de 50 criações até 50. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}.",

	-- Step 4: Roasted Boar Meat: ingredients
	-- {spell:2540} Roasted Boar Meat
	["{spell:2540}: ingredients"] = "{spell:2540}: ingredientes",
	-- {npc:1126} Large Crag Boar · {npc:1125} Crag Boar · {zone:1426} Dun Morogh
	["{npc:1126} (36%), {npc:1125} (34%) in {zone:1426}, or wherever the arrow points"] = "{npc:1126} (36%), {npc:1125} (34%) em {zone:1426}, ou onde a seta apontar",

	-- Step 5: Roasted Boar Meat (1-50)
	-- {spell:2540} Roasted Boar Meat · {object:29784} Basic Campfire
	["{spell:2540} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2540} é laranja desde 1 (amarelo em 45, verde em 65, cinza em 85): cerca de 50 criações até 50. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}.",

	-- Step 6: Herb Baked Egg: shopping
	-- {item:6888} Herb Baked Egg
	["{item:6888}: shopping"] = "{item:6888}: compras",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 50 {item:2678} (1s)."] = "A seta escolhe o vendedor mais próximo da sua facção para cada item. Você precisa de 50 {item:2678} (1s).",

	-- Step 7: Herb Baked Egg: ingredients
	-- {item:6888} Herb Baked Egg
	["{item:6888}: ingredients"] = "{item:6888}: ingredientes",
	-- {npc:1995} Strigid Owl · {zone:1438} Teldrassil
	["{npc:1995} (58%) in {zone:1438}, or wherever the arrow points"] = "{npc:1995} (58%) em {zone:1438}, ou onde a seta apontar",

	-- Step 8: Herb Baked Egg (1-50)
	-- {item:6888} Herb Baked Egg · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2678} Mild Spices · {zone:1438} Teldrassil · {item:6889} Small Egg · {zone:1439} Darkshore · {item:6290} Brilliant Smallfish · {npc:6286} Zarrin · {area:186} Dolanaar · {item:5472} Kaldorei Spider Kabob
	-- plural, as words: Small Spider Legs = {item:5465} Small Spider Leg
	["{item:6888} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. {item:6888} comes with {skill:185} (the client teaches it with the skill); {item:2678} are a cooking vendor's. The Strigid owls of {zone:1438} drop a {item:6889} more often than not, and {zone:1439}'s moonkin drop them too. Fishers can cook {item:6290} (recipe 40c) from Rut'theran's waters instead, and {npc:6286} in {area:186} gives Recipe of the Kaldorei (seven Small Spider Legs from the Webwood spiders) for {item:5472}, orange from 10 to 50."] = "{item:6888} é laranja desde 1 (amarelo em 45, verde em 65, cinza em 85): cerca de 50 criações até 50. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. {item:6888} vem com {skill:185} (o cliente ensina junto com a habilidade); {item:2678} são de vendedor de culinária. As corujas Estrígidas de {zone:1438} soltam {item:6889} na maioria das vezes, e os luniscantes de {zone:1439} também. Pescadores podem cozinhar {item:6290} (receita 40c) com as águas de Rut'theran, e {npc:6286} em {area:186} dá a Receita dos Kaldorei (sete Pernas Pequenas de Aranha das aranhas Lenhateias) por {item:5472}, laranja de 10 a 50.",

	-- Step 9: Charred Wolf Meat: ingredients
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} in Zephras Isle, or wherever the arrow points"] = "{npc:250873} na Ilha de Zefras, ou onde a seta apontar",

	-- Step 10: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire · {item:2672} Stringy Wolf Meat
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. The Vuldren of Zephras Isle drop {item:2672}."] = "{spell:2538} é laranja desde 1 (amarelo em 45, verde em 65, cinza em 85): cerca de 50 criações até 50. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. Os Vuldren da Ilha de Zefras soltam {item:2672}.",

	-- Step 11: Roasted Boar Meat: ingredients
	-- {npc:3099} Dire Mottled Boar · {zone:1411} Durotar
	["{npc:3099} (99%) in {zone:1411}, or wherever the arrow points"] = "{npc:3099} (99%) em {zone:1411}, ou onde a seta apontar",

	-- Step 13: Charred Wolf Meat: ingredients
	-- {npc:2960} Prairie Wolf Alpha · {npc:2959} Prairie Stalker · {zone:1412} Mulgore
	["{npc:2960} (82%), {npc:2959} (77%) in {zone:1412}, or wherever the arrow points"] = "{npc:2960} (82%), {npc:2959} (77%) em {zone:1412}, ou onde a seta apontar",

	-- Step 15: Charred Wolf Meat: ingredients
	-- {npc:1547} Decrepit Darkhound · {npc:1548} Cursed Darkhound · {zone:1420} Tirisfal Glades
	["{npc:1547} (72%), {npc:1548} (33%) in {zone:1420}, or wherever the arrow points"] = "{npc:1547} (72%), {npc:1548} (33%) em {zone:1420}, ou onde a seta apontar",

	-- Step 17: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "{skill:185} (Profissional)",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction; training costs 5s."] = "{skill:185} Profissional eleva o limite para 150; exige perícia 50 e nível de personagem 10: a seta escolhe o instrutor de {skill:185} mais próximo da sua facção; o treinamento custa 5s.",

	-- Step 18: Coyote Steak: ingredients
	-- {spell:2541} Coyote Steak
	["{spell:2541}: ingredients"] = "{spell:2541}: ingredientes",
	-- {npc:834} Coyote · {npc:833} Coyote Packleader · {zone:1436} Westfall
	["{npc:834} (54%), {npc:833} (51%) in {zone:1436}, or wherever the arrow points"] = "{npc:834} (54%), {npc:833} (51%) em {zone:1436}, ou onde a seta apontar",

	-- Step 19: Coyote Steak (50-90)
	-- {spell:2541} Coyote Steak · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {npc:235} Salma Saldean · {area:108} Sentinel Hill · {item:733} Westfall Stew · {item:724} Goretusk Liver Pie
	-- plural, as words: Coyotes = {npc:834} Coyote
	["{spell:2541} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. Coyotes roam the middle of {zone:1436}; {npc:235} on the farm north of {area:108} also gives {item:733} and {item:724} quests that use what you loot here."] = "{spell:2541} é laranja desde 50 (amarelo em 90, verde em 110, cinza em 130): cerca de 40 criações até 90. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. Qualquer instrutor de {skill:185} ensina a partir da perícia 50 por 1s. Coiotes vagam pelo meio de {zone:1436}; {npc:235}, na fazenda ao norte de {area:108}, também dá missões de {item:733} e {item:724} que usam o que você coleta aqui.",

	-- Step 20: Crab Cake: shopping
	-- {spell:2544} Crab Cake
	["{spell:2544}: shopping"] = "{spell:2544}: compras",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 44 {item:2678} (90c)."] = "A seta escolhe o vendedor mais próximo da sua facção para cada item. Você precisa de 44 {item:2678} (90c).",

	-- Step 21: Crab Cake: ingredients
	-- {spell:2544} Crab Cake
	["{spell:2544}: ingredients"] = "{spell:2544}: ingredientes",
	-- {npc:830} Sand Crawler · {zone:1436} Westfall
	["{npc:830} (43%) in {zone:1436}, or wherever the arrow points"] = "{npc:830} (43%) em {zone:1436}, ou onde a seta apontar",

	-- Step 22: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1436} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544} é laranja desde 90 (amarelo em 115, verde em 135, cinza em 155): cerca de 44 criações até 130. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. Qualquer instrutor de {skill:185} ensina a partir da perícia 75 por 2s. Aretiscos ocupam toda a costa de {zone:1436}. Cozinhe até 130, quando {spell:3376} assume.",

	-- Step 23: Smoked Bear Meat: shopping
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: shopping"] = "{item:6890}: compras",
	["The arrow picks the nearest vendor of your faction for each item."] = "A seta escolhe o mercador mais próximo da sua facção para cada item.",

	-- Step 24: Smoked Bear Meat: ingredients
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: ingredients"] = "{item:6890}: ingredientes",
	-- {npc:1189} Black Bear Patriarch · {zone:1432} Loch Modan
	["{npc:1189} (39%) in {zone:1432}, or wherever the arrow points"] = "{npc:1189} (39%) em {zone:1432}, ou onde a seta apontar",

	-- Step 25: Smoked Bear Meat (50-80)
	-- {item:6890} Smoked Bear Meat · {object:29784} Basic Campfire · {item:6892} Recipe: Smoked Bear Meat · {zone:1432} Loch Modan
	["{item:6890} is orange from 50 (yellow at 80, green at 100, grey at 120): about 30 crafts to 80. Cook at any fire: a town hearth or your own {object:29784}. {item:6892} costs 2s 50c at its vendor; the arrow picks the nearest one of your faction. Black bears roam the hills of {zone:1432}."] = "{item:6890} é laranja desde 50 (amarelo em 80, verde em 100, cinza em 120): cerca de 30 criações até 80. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. {item:6892} custa 2s 50c no vendedor; a seta escolhe o mais próximo da sua facção. Ursos pretos vagam pelas colinas de {zone:1432}.",

	-- Step 26: Dry Pork Ribs: shopping
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: shopping"] = "{spell:2546}: compras",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2678} (1s 10c)."] = "A seta escolhe o vendedor mais próximo da sua facção para cada item. Você precisa de 52 {item:2678} (1s 10c).",

	-- Step 27: Dry Pork Ribs: ingredients
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: ingredients"] = "{spell:2546}: ingredientes",
	-- {npc:1191} Mangy Mountain Boar · {zone:1432} Loch Modan
	["{npc:1191} (31%) in {zone:1432}, or wherever the arrow points"] = "{npc:1191} (31%) em {zone:1432}, ou onde a seta apontar",

	-- Step 28: Dry Pork Ribs (80-130)
	-- {spell:2546} Dry Pork Ribs · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1432} Loch Modan · {spell:3376} Curiously Tasty Omelet
	["{spell:2546} is orange from 80 (yellow at 120, green at 140, grey at 160): about 52 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 80 for 1s 50c. Mountain boars roam all of {zone:1432}. Cook it to 130, where {spell:3376} takes over."] = "{spell:2546} é laranja desde 80 (amarelo em 120, verde em 140, cinza em 160): cerca de 52 criações até 130. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. Qualquer instrutor de {skill:185} ensina a partir da perícia 80 por 1s 50c. Javalis montanheses vagam por toda {zone:1432}. Cozinhe até 130, quando {spell:3376} assume.",

	-- Step 29: Boiled Clams: shopping
	-- {item:5525} Boiled Clams
	["{item:5525}: shopping"] = "{item:5525}: compras",
	-- {item:159} Refreshing Spring Water
	["The arrow picks the nearest vendor of your faction for each item. You need 40 {item:159} (2s)."] = "A seta escolhe o vendedor mais próximo da sua facção para cada item. Você precisa de 40 {item:159} (2s).",

	-- Step 30: Boiled Clams: ingredients
	-- {item:5525} Boiled Clams
	["{item:5525}: ingredients"] = "{item:5525}: ingredientes",
	-- {npc:3812} Clattering Crawler · {npc:3814} Spined Crawler · {npc:3944} Wrathtail Priestess · {zone:1439} Darkshore · {item:5523} Small Barnacled Clam · {item:5503} Clam Meat
	["{npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) in {zone:1439}, or wherever the arrow points; open each {item:5523} for its {item:5503}"] = "{npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) em {zone:1439}, ou onde a seta apontar; abra cada {item:5523} para pegar a {item:5503}",

	-- Step 31: Boiled Clams (50-90)
	-- {item:5525} Boiled Clams · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2674} Crawler Meat · {spell:2544} Crab Cake
	["{item:5525} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. The same coastal crawlers drop {item:2674} for {spell:2544} next: keep it."] = "{item:5525} é laranja desde 50 (amarelo em 90, verde em 110, cinza em 130): cerca de 40 criações até 90. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. Qualquer instrutor de {skill:185} ensina a partir da perícia 50 por 1s. Os mesmos aretiscos costeiros soltam {item:2674} para {spell:2544} em seguida: guarde.",

	-- Step 33: Crab Cake: ingredients
	-- {npc:3814} Spined Crawler · {npc:3812} Clattering Crawler · {zone:1439} Darkshore
	["{npc:3814} (42%), {npc:3812} (40%) in {zone:1439}, or wherever the arrow points"] = "{npc:3814} (42%), {npc:3812} (40%) em {zone:1439}, ou onde a seta apontar",

	-- Step 34: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1439} Darkshore · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1439} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544} é laranja desde 90 (amarelo em 115, verde em 135, cinza em 155): cerca de 44 criações até 130. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. Qualquer instrutor de {skill:185} ensina a partir da perícia 75 por 2s. Aretiscos ocupam toda a costa de {zone:1439}. Cozinhe até 130, quando {spell:3376} assume.",

	-- Step 35: Strider Stew: shopping
	-- {item:5477} Strider Stew
	["{item:5477}: shopping"] = "{item:5477}: compras",
	-- {item:4536} Shiny Red Apple
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:4536} (2s 75c)."] = "A seta escolhe o vendedor mais próximo da sua facção para cada item. Você precisa de 52 {item:4536} (2s 75c).",

	-- Step 36: Strider Stew: ingredients
	-- {item:5477} Strider Stew
	["{item:5477}: ingredients"] = "{item:5477}: ingredientes",
	-- {npc:3246} Fleeting Plainstrider · {zone:1413} The Barrens
	["{npc:3246} (32%) in {zone:1413}, or wherever the arrow points"] = "{npc:3246} (32%) em {zone:1413}, ou onde a seta apontar",

	-- Step 37: Strider Stew (50-100)
	-- {item:5477} Strider Stew · {object:29784} Basic Campfire · {item:5486} Recipe: Strider Stew
	["{item:5477} is orange from 50 (yellow at 90, green at 110, grey at 130): about 52 crafts to 100. Cook at any fire: a town hearth or your own {object:29784}. {item:5486} costs 4s 40c at its vendor; the arrow picks the nearest one of your faction."] = "{item:5477} é laranja desde 50 (amarelo em 90, verde em 110, cinza em 130): cerca de 52 criações até 100. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. {item:5486} custa 4s 40c no vendedor; a seta escolhe o mais próximo da sua facção.",

	-- Step 38: Crispy Lizard Tail: shopping
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: shopping"] = "{item:5479}: compras",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 30 {item:2692} (12s)."] = "A seta escolhe o vendedor mais próximo da sua facção para cada item. Você precisa de 30 {item:2692} (12s).",

	-- Step 39: Crispy Lizard Tail: ingredients
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: ingredients"] = "{item:5479}: ingredientes",
	-- {npc:3239} Thunderhead · {zone:1413} The Barrens
	["{npc:3239} (59%), Owatanka (35%) in {zone:1413}, or wherever the arrow points"] = "{npc:3239} (59%), Owatanka (35%) em {zone:1413}, ou onde a seta apontar",

	-- Step 40: Crispy Lizard Tail (100-130)
	-- {item:5479} Crispy Lizard Tail · {object:29784} Basic Campfire · {item:5488} Recipe: Crispy Lizard Tail · {npc:3489} Zargh · {item:3735} Recipe: Hot Lion Chops
	["{item:5479} is orange from 100 (yellow at 140, green at 160, grey at 180): about 30 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. {item:5488} costs 4s at its vendor; the arrow picks the nearest one of your faction. {npc:3489}, the butcher beside this vendor at the Crossroads, sells {item:3735} (18s), the recipe after Expert: buy it now."] = "{item:5479} é laranja desde 100 (amarelo em 140, verde em 160, cinza em 180): cerca de 30 criações até 130. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. {item:5488} custa 4s no vendedor; a seta escolhe o mais próximo da sua facção. {npc:3489}, o açougueiro ao lado deste vendedor na Encruzilhada, vende {item:3735} (18s), a receita depois de Perito: compre agora.",

	-- Step 41: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "{skill:185} (Perito)",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook
	["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072} (1g); the arrow picks its nearest seller for your faction. Buy it and read it."] = "{skill:185} Perito eleva o limite para 225; exige perícia 125 e nível de personagem 20: é um livro, {item:16072} (1g); a seta escolhe o vendedor mais próximo para a sua facção. Compre e leia.",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "Compre e leia {item:16072} ({skill:185} (Perito))",

	-- Step 42: Curiously Tasty Omelet: shopping
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: shopping"] = "{spell:3376}: compras",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 46 {item:2692} (18s 40c)."] = "A seta escolhe o vendedor mais próximo da sua facção para cada item. Você precisa de 46 {item:2692} (18s 40c).",

	-- Step 43: Curiously Tasty Omelet: ingredients
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: ingredients"] = "{spell:3376}: ingredientes",
	-- {npc:1018} Highland Razormaw · {npc:1019} Elder Razormaw · {zone:1437} Wetlands
	["{npc:1018} (72%), {npc:1019} (67%) in {zone:1437}, or wherever the arrow points"] = "{npc:1018} (72%), {npc:1019} (67%) em {zone:1437}, ou onde a seta apontar",

	-- Step 44: Curiously Tasty Omelet (130-175)
	-- {spell:3376} Curiously Tasty Omelet · {object:29784} Basic Campfire · {item:3682} Recipe: Curiously Tasty Omelet · {zone:1437} Wetlands · {item:3685} Raptor Egg · {npc:340} Kendor Kabonka · {zone:1453} Stormwind
	["{spell:3376} is orange from 130 (yellow at 170, green at 190, grey at 210): about 46 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3682} costs 16s at its vendor; the arrow picks the nearest one of your faction. The raptors of the {zone:1437} drop a {item:3685} about two kills in three. {npc:340} in {zone:1453} sells the recipe."] = "{spell:3376} é laranja desde 130 (amarelo em 170, verde em 190, cinza em 210): cerca de 46 criações até 175. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. {item:3682} custa 16s no vendedor; a seta escolhe o mais próximo da sua facção. Os raptores de {zone:1437} soltam {item:3685} em cerca de duas de cada três mortes. {npc:340} em {zone:1453} vende a receita.",

	-- Step 45: Hot Lion Chops: shopping
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: shopping"] = "{spell:3398}: compras",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 45 {item:2692} (18s)."] = "A seta escolhe o vendedor mais próximo da sua facção para cada item. Você precisa de 45 {item:2692} (18s).",

	-- Step 46: Hot Lion Chops: ingredients
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: ingredients"] = "{spell:3398}: ingredientes",
	-- {npc:2384} Starving Mountain Lion · {zone:1424} Hillsbrad Foothills
	["{npc:2384} (42%) in {zone:1424}, or wherever the arrow points"] = "{npc:2384} (42%) em {zone:1424}, ou onde a seta apontar",

	-- Step 47: Hot Lion Chops (130-175)
	-- {spell:3398} Hot Lion Chops · {object:29784} Basic Campfire · {item:3735} Recipe: Hot Lion Chops · {item:3731} Lion Meat
	-- plural, as words: Hulking Mountain Lions = {npc:2407} Hulking Mountain Lion
	["{spell:3398} is orange from 130 (yellow at 175, green at 195, grey at 215): about 45 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3735} costs 18s at its vendor; the arrow picks the nearest one of your faction. The Feral and Hulking Mountain Lions of Hillsbrad Foothills drop {item:3731} more often than the Starving ones."] = "{spell:3398} é laranja desde 130 (amarelo em 175, verde em 195, cinza em 215): cerca de 45 criações até 175. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. {item:3735} custa 18s no vendedor; a seta escolhe o mais próximo da sua facção. Os Leões da Montanha Selvagens e Imponentes de Contraforte de Eira dos Montes soltam {item:3731} com mais frequência que os Esfomeados.",

	-- Step 48: Roast Raptor: shopping
	-- {item:12210} Roast Raptor
	["{item:12210}: shopping"] = "{item:12210}: compras",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2692} (20s 80c)."] = "A seta escolhe o vendedor mais próximo da sua facção para cada item. Você precisa de 52 {item:2692} (20s 80c).",

	-- Step 49: Roast Raptor: ingredients
	-- {item:12210} Roast Raptor
	["{item:12210}: ingredients"] = "{item:12210}: ingredientes",
	-- {npc:2560} Highland Thrasher · {zone:1417} Arathi Highlands
	["{npc:2560} (38%) in {zone:1417}, or wherever the arrow points"] = "{npc:2560} (38%) em {zone:1417}, ou onde a seta apontar",

	-- Step 50: Roast Raptor (175-225)
	-- {item:12210} Roast Raptor · {object:29784} Basic Campfire · {item:12228} Recipe: Roast Raptor · {zone:1417} Arathi Highlands · {npc:2810} Hammon Karwn · {area:320} Refuge Pointe · {npc:2821} Keena · {area:321} Hammerfall · {item:2692} Hot Spices · {item:17222} Spider Sausage · {item:12205} White Spider Meat
	["{item:12210} is orange from 175 (yellow at 215, green at 235, grey at 255): about 52 crafts to 225. Cook at any fire: a town hearth or your own {object:29784}. {item:12228} costs 50s at its vendor; the arrow picks the nearest one of your faction. {zone:1417}: {npc:2810} at {area:320} (Alliance) and {npc:2821} at {area:321} (Horde) sell the recipe and {item:2692} beside the raptors. {item:17222} (any trainer from 200, 40s) is the alternative, but it takes two {item:12205} a craft and Dustwallow's spiders drop one about two kills in five."] = "{item:12210} é laranja desde 175 (amarelo em 215, verde em 235, cinza em 255): cerca de 52 criações até 225. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. {item:12228} custa 50s no vendedor; a seta escolhe o mais próximo da sua facção. {zone:1417}: {npc:2810} em {area:320} (Aliança) e {npc:2821} em {area:321} (Horda) vendem a receita e {item:2692} ao lado dos raptores. {item:17222} (qualquer instrutor a partir de 200, 40s) é a alternativa, mas exige duas {item:12205} por criação e as aranhas de Pântano Vadeoso soltam um em cerca de duas mortes de cinco.",

	-- Step 51: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "{skill:185} Artífice vem de {npc:8125} em {area:976} ({zone:1446}). O instrutor de culinária em {zone:1455} envia você; requer perícia 225 e nível 35.",

	-- Step 52: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "{skill:185} Artífice vem de {npc:8125} em {area:976} ({zone:1446}). O instrutor de culinária em {zone:1454} envia você; requer perícia 225 e nível 35.",

	-- Step 53: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "Ovos Gigantescos",
	-- {quest:6610} Clamlette Surprise · {item:7974} Zesty Clam Meat · {item:8932} Alterac Swiss · {zone:1446} Tanaris · {zone:1425} The Hinterlands · {npc:2929} Savage Owlbeast · {item:12218} Monster Omelet
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["{quest:6610} asks for 12 Giant Eggs, 10 {item:7974} and 20 {item:8932}: bring all three before you go to {zone:1446}, so you make the trip once. Giant Eggs drop from the owlbeasts of {zone:1425}: {npc:2929} (54%). {item:12218} takes about 120 more after Artisan: farm them now too if you like."] = "{quest:6610} pede 12 Ovos Gigantescos, 10 {item:7974} e 20 {item:8932}: leve os três antes de ir a {zone:1446}, para fazer a viagem uma vez só. Ovos Gigantescos soltam das bestas-coruja de {zone:1425}: {npc:2929} (54%). {item:12218} usa cerca de 120 a mais depois de Artífice: junte-os agora também, se quiser.",

	-- Step 54: Alterac Swiss
	-- {item:8932} Alterac Swiss
	["Innkeepers and food vendors sell {item:8932}; the arrow picks the nearest."] = "Estalajadeiros e vendedores de comida vendem {item:8932}; a seta escolhe o mais próximo.",

	-- Step 55: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {zone:1445} Dustwallow Marsh · {zone:1446} Tanaris
	-- plural, as words: Big-mouth Clams = {item:7973} Big-mouth Clam · Steeljaw Snappers = {npc:14123} Steeljaw Snapper
	["{item:7974} comes from Big-mouth Clams: open each one, every clam holds one. The Muckshell crabs on the {zone:1445} coast south-west of Theramore drop a clam about seven kills in ten, so ten clams take about fifteen kills, on your way to {zone:1446}. The Steeljaw Snappers on {zone:1446}'s east coast drop them about one kill in three."] = "{item:7974} vem de Mariscos Boca-grande: abra cada um, todo marisco tem um. Os caranguejos Conchalodo da costa de {zone:1445}, a sudoeste de Theramore, soltam um marisco em cerca de sete mortes de dez, então dez mariscos levam cerca de quinze mortes, no seu caminho até {zone:1446}. As Tartaliscas Maxilaço da costa leste de {zone:1446} soltam em cerca de uma morte de três.",

	-- Step 56: Clamlette Surprise
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "{skill:185} (Artífice)",

	-- Step 57: Monster Omelet: shopping
	-- {item:12218} Monster Omelet
	["{item:12218}: shopping"] = "{item:12218}: compras",
	-- {item:3713} Soothing Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 240 {item:3713} (3g 84s)."] = "A seta escolhe o vendedor mais próximo da sua facção para cada item. Você precisa de 240 {item:3713} (3g 84s).",

	-- Step 58: Monster Omelet: ingredients
	-- {item:12218} Monster Omelet
	["{item:12218}: ingredients"] = "{item:12218}: ingredientes",
	-- {npc:2929} Savage Owlbeast · {zone:1425} The Hinterlands
	["{npc:2929} (54%) in {zone:1425}, or wherever the arrow points"] = "{npc:2929} (54%) em {zone:1425}, ou onde a seta apontar",

	-- Step 59: Monster Omelet (225-300)
	-- {item:12218} Monster Omelet · {object:29784} Basic Campfire · {item:16110} Recipe: Monster Omelet · {item:13931} Nightfin Soup · {npc:8137} Gikkix · {area:977} Steamwheedle Port · {item:13932} Poached Sunscale Salmon · {item:279982} Iron Oven
	["{item:12218} is orange from 225 (yellow at 265, green at 285, grey at 305): about 120 crafts to 300. Cook at any fire: a town hearth or your own {object:29784}. {item:16110} costs 1g 20s at its vendor; the arrow picks the nearest one of your faction. {item:12218} is orange to 265 and green from 285, yet it still carries you to 300. Fishers can finish on {item:13931} ({npc:8137}, {area:977}; yellow to 310) instead; {item:13932} needs an {item:279982} on Forever."] = "{item:12218} é laranja desde 225 (amarelo em 265, verde em 285, cinza em 305): cerca de 120 criações até 300. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. {item:16110} custa 1g 20s no vendedor; a seta escolhe o mais próximo da sua facção. {item:12218} é laranja até 265 e verde a partir de 285, mas ainda leva você até 300. Pescadores podem terminar com {item:13931} ({npc:8137}, {area:977}; amarelo até 310); {item:13932} exige um {item:279982} no Forever.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5); the arrow picks the nearest."] = "Qualquer instrutor de {skill:185} da sua facção ensina {skill:185} Aprendiz (nível de personagem 5); a seta escolhe o mais próximo.",
	-- ["Catch about 50 {item:6291} here by fishing (see the {skill:356} guide)."] = "Pesque cerca de 50 {item:6291} aqui (veja o guia de {skill:356}).",
	-- ["Catch about 68 {item:6361} here by fishing (see the {skill:356} guide)."] = "Pesque cerca de 68 {item:6361} aqui (veja o guia de {skill:356}).",
	-- ["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072}; the arrow picks its nearest seller for your faction. Buy it and read it."] = "{skill:185} (Perito) eleva o limite para 225; requer perícia 125 e nível de personagem 20: é um livro, {item:16072}; a seta escolhe o vendedor mais próximo da sua facção. Compre-o e leia-o.",
	-- ["Giant Eggs drop from the Ironbeak owls of {zone:1448}."] = "Ovos Gigantescos caem das Corujas Bico-de-ferro de {zone:1448}.",
	-- ["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction."] = "{skill:185} Profissional eleva o limite para 150; requer perícia 50 e nível de personagem 10: a seta escolhe o instrutor de {skill:185} mais próximo da sua facção.",
	-- ["{area:442} docks"] = "Docas de {area:442}",
	-- ["{area:702} docks"] = "Docas de {area:702}",
	-- ["{item:12210} is orange from 175 (yellow at 215, grey at 255): about 40 crafts to 215. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12210} fica laranja a partir de 175 (amarelo em 215, cinza em 255): cerca de 40 criações até 215. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{item:12215} is orange from 215 (yellow at 240, grey at 280): about 10 crafts to 225. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215} fica laranja a partir de 215 (amarelo em 240, cinza em 280): cerca de 10 criações até 225. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{item:12215} is orange from 225 (yellow at 240, grey at 280): about 15 crafts to 240. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215} fica laranja a partir de 225 (amarelo em 240, cinza em 280): cerca de 15 criações até 240. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{item:12215}: ingredients"] = "{item:12215}: ingredientes",
	-- ["{item:12215}: shopping"] = "{item:12215}: compras",
	-- ["{item:12218} is orange from 240 (yellow at 265, grey at 305): about 105 crafts to 300. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12218} fica laranja a partir de 240 (amarelo em 265, cinza em 305): cerca de 105 criações até 300. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{item:5095} is orange from 50 (yellow at 90, grey at 130): about 68 crafts to 110. Cook at any fire: {object:29784} comes with {skill:185}. {skill:356} off the {area:442} docks catches {item:6361}."] = "{item:5095} fica laranja a partir de 50 (amarelo em 90, cinza em 130): cerca de 68 criações até 110. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}. {skill:356} nas docas de {area:442} rende {item:6361}.",
	-- ["{item:5095}: ingredients"] = "{item:5095}: ingredientes",
	-- ["{item:5095}: shopping"] = "{item:5095}: compras",
	-- ["{item:5477} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5477} fica laranja a partir de 50 (amarelo em 90, cinza em 130): cerca de 52 criações até 100. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{item:5479} is orange from 100 (yellow at 140, green at 160, grey at 180): about 30 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. {item:5488} costs 4s at its vendor; the arrow picks the nearest one of your faction. {npc:3489}, the butcher beside this vendor at the {area:380}, sells {item:3735} (18s), the recipe after Expert: buy it now."] = "{item:5479} é laranja desde 100 (amarelo em 140, verde em 160, cinza em 180): cerca de 30 criações até 130. Cozinhe em qualquer fogueira: a lareira de uma cidade ou a sua própria {object:29784}. {item:5488} custa 4s no vendedor; a seta escolhe o mais próximo da sua facção. {npc:3489}, o açougueiro ao lado deste vendedor em {area:380}, vende {item:3735} (18s), a receita depois de Perito: compre agora.",
	-- ["{item:5479} is orange from 100 (yellow at 140, grey at 180): about 25 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479} fica laranja a partir de 100 (amarelo em 140, cinza em 180): cerca de 25 criações até 125. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{item:5479} is orange from 125 (yellow at 140, grey at 180): about 15 crafts to 140. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479} fica laranja a partir de 125 (amarelo em 140, cinza em 180): cerca de 15 criações até 140. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{item:5480} is orange from 110 (yellow at 150, grey at 190): about 15 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480} fica laranja a partir de 110 (amarelo em 150, cinza em 190): cerca de 15 criações até 125. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{item:5480} is orange from 125 (yellow at 150, grey at 190): about 25 crafts to 150. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480} fica laranja a partir de 125 (amarelo em 150, cinza em 190): cerca de 25 criações até 150. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{item:5480}: ingredients"] = "{item:5480}: ingredientes",
	-- ["{item:5480}: shopping"] = "{item:5480}: compras",
	-- ["{item:6290} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}. {item:6291} is the common catch in {zone:1438}'s waters."] = "{item:6290} fica laranja a partir de 1 (amarelo em 45, cinza em 85): cerca de 50 criações até 50. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}. {item:6291} é a pesca comum nas águas de {zone:1438}.",
	-- ["{item:6290}: ingredients"] = "{item:6290}: ingredientes",
	-- ["{item:6290}: shopping"] = "{item:6290}: compras",
	-- ["{item:6316} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:6316} fica laranja a partir de 50 (amarelo em 90, cinza em 130): cerca de 52 criações até 100. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{item:6316}: ingredients"] = "{item:6316}: ingredientes",
	-- ["{item:6316}: shopping"] = "{item:6316}: compras",
	-- ["{item:724} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:724} fica laranja a partir de 50 (amarelo em 90, cinza em 130): cerca de 52 criações até 100. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{item:724}: ingredients"] = "{item:724}: ingredientes",
	-- ["{item:724}: shopping"] = "{item:724}: compras",
	-- ["{item:7974} has no drop data: buy it at the Gadgetzan Auction House, next to {npc:8125}, or open clams looted from coastal creatures."] = "{item:7974} não tem dados de saque: compre na Casa de Leilões de Geringontzan, ao lado de {npc:8125}, ou abra mariscos saqueados de criaturas costeiras.",
	-- ["{npc:1193} (50%) in {zone:1432}, or wherever the arrow points"] = "{npc:1193} (50%) em {zone:1432}, ou onde a seta apontar",
	-- ["{npc:1400} (50%) in {zone:1437}, or wherever the arrow points"] = "{npc:1400} (50%) em {zone:1437}, ou onde a seta apontar",
	-- ["{npc:1549} (88%) in {zone:1420}, or wherever the arrow points"] = "{npc:1549} (88%) em {zone:1420}, ou onde a seta apontar",
	-- ["{npc:1689} (38%), {npc:1127} (36%) in {zone:1426}, or wherever the arrow points"] = "{npc:1689} (38%), {npc:1127} (36%) em {zone:1426}, ou onde a seta apontar",
	-- ["{npc:2385} (56%) in {zone:1424}, or wherever the arrow points"] = "{npc:2385} (56%) em {zone:1424}, ou onde a seta apontar",
	-- ["{npc:3099} (99%), {npc:3100} (74%) in {zone:1411}, or wherever the arrow points"] = "{npc:3099} (99%), {npc:3100} (74%) em {zone:1411}, ou onde a seta apontar",
	-- ["{npc:3244} (33%) in {zone:1413}, or wherever the arrow points"] = "{npc:3244} (33%) em {zone:1413}, ou onde a seta apontar",
	-- ["{npc:3818} (53%) in {zone:1440}, or wherever the arrow points"] = "{npc:3818} (53%) em {zone:1440}, ou onde a seta apontar",
	-- ["{npc:4352} (52%), {npc:4351} (51%) in {zone:1445}, or wherever the arrow points"] = "{npc:4352} (52%), {npc:4351} (51%) em {zone:1445}, ou onde a seta apontar",
	-- ["{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) in {zone:1443}, or wherever the arrow points"] = "{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) em {zone:1443}, ou onde a seta apontar",
	-- ["{npc:547} (35%), {npc:157} (34%) in {zone:1436}, or wherever the arrow points"] = "{npc:547} (35%), {npc:157} (34%) em {zone:1436}, ou onde a seta apontar",
	-- ["{npc:7099} (40%) in {zone:1448}, or wherever the arrow points"] = "{npc:7099} (40%) em {zone:1448}, ou onde a seta apontar",
	-- ["{quest:6610} asks for 20 {item:8932} (check the quest log); innkeepers and food vendors sell it, and the arrow picks the nearest."] = "{quest:6610} pede 20 {item:8932} (confira o Registro de Missões); estalajadeiros e vendedores de comida o vendem, e a seta escolhe o mais próximo.",
	-- ["{spell:2538} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2538} fica laranja a partir de 1 (amarelo em 45, cinza em 85): cerca de 50 criações até 50. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{spell:2540} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2540} fica laranja a partir de 1 (amarelo em 45, cinza em 85): cerca de 50 criações até 50. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{spell:3370} is orange from 100 (yellow at 120, grey at 160): about 26 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370} fica laranja a partir de 100 (amarelo em 120, cinza em 160): cerca de 26 criações até 125. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{spell:3370} is yellow from 125 (yellow at 120, grey at 160): about 7 crafts to 130. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370} fica amarelo a partir de 125 (amarelo em 120, cinza em 160): cerca de 7 criações até 130. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{spell:3370}: ingredients"] = "{spell:3370}: ingredientes",
	-- ["{spell:3370}: shopping"] = "{spell:3370}: compras",
	-- ["{spell:3376} is orange from 130 (yellow at 170, grey at 210): about 46 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376} fica laranja a partir de 130 (amarelo em 170, cinza em 210): cerca de 46 criações até 175. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{spell:3376} is orange from 150 (yellow at 170, grey at 210): about 26 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376} fica laranja a partir de 150 (amarelo em 170, cinza em 210): cerca de 26 criações até 175. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
	-- ["{spell:3398} is orange from 140 (yellow at 175, grey at 215): about 35 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3398} fica laranja a partir de 140 (amarelo em 175, cinza em 215): cerca de 35 criações até 175. Cozinhe em qualquer fogo: {object:29784} vem com {skill:185}.",
}
