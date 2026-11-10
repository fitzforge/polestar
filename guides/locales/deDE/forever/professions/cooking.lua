-- German (deDE): the guide forever/professions/cooking (forever/professions/cooking.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Cooking
	-- {skill:185} Cooking
	["Learn {skill:185}"] = "Lerne {skill:185}",
	-- {skill:185} Cooking · {object:29784} Basic Campfire · {item:279981} Basic Campfire Kit · {item:4470} Simple Wood · {item:4471} Flint and Tinder
	["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5, 1s); the arrow picks the nearest. Forever: every cook knows {object:29784}. Craft a {item:279981} from one {item:4470} (38c) with {item:4471} (1s 35c, kept in your bags), then place the kit to light a cooking fire anywhere; make a few in advance (one use every 5 minutes). The first kits also raise {skill:185} to about 5. The Camping 101: {skill:185} quest at your starting area's camp sends you to this trainer."] = "Jeder {skill:185}-Lehrer deiner Fraktion bringt dir die Lehrlingsstufe von {skill:185} bei (Charakterstufe 5, 1s); der Pfeil wählt den nächsten. Forever: Jeder Koch kennt {object:29784}. Stell aus einem {item:4470} (38c) mit {item:4471} (1s 35c, in deinen Taschen aufbewahrt) ein {item:279981} her, dann stell das Set auf, um irgendwo ein Kochfeuer zu entzünden; stell vorab ein paar her (eine Nutzung alle 5 Minuten). Die ersten Sets heben {skill:185} auch auf etwa 5. Die Quest Camping 101: {skill:185} am Lager deines Startgebiets schickt dich zu diesem Lehrer.",

	-- Step 2: Charred Wolf Meat: ingredients
	-- {spell:2538} Charred Wolf Meat
	["{spell:2538}: ingredients"] = "{spell:2538}: Zutaten",
	-- {zone:1429} Elwynn Forest
	["Prowler (86%) in {zone:1429}, or wherever the arrow points"] = "Streuner (86%) in {zone:1429}, oder dort, wo der Pfeil hinzeigt",

	-- Step 3: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2538} ist ab 1 orange (gelb bei 45, grün bei 65, grau bei 85): etwa 50 Herstellungen bis 50. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}.",

	-- Step 4: Roasted Boar Meat: ingredients
	-- {spell:2540} Roasted Boar Meat
	["{spell:2540}: ingredients"] = "{spell:2540}: Zutaten",
	-- {npc:1126} Large Crag Boar · {npc:1125} Crag Boar · {zone:1426} Dun Morogh
	["{npc:1126} (36%), {npc:1125} (34%) in {zone:1426}, or wherever the arrow points"] = "{npc:1126} (36%), {npc:1125} (34%) in {zone:1426}, oder wohin der Pfeil zeigt",

	-- Step 5: Roasted Boar Meat (1-50)
	-- {spell:2540} Roasted Boar Meat · {object:29784} Basic Campfire
	["{spell:2540} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}."] = "{spell:2540} ist ab 1 orange (gelb bei 45, grün bei 65, grau bei 85): etwa 50 Herstellungen bis 50. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}.",

	-- Step 6: Herb Baked Egg: shopping
	-- {item:6888} Herb Baked Egg
	["{item:6888}: shopping"] = "{item:6888}: Einkauf",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 50 {item:2678} (1s)."] = "Der Pfeil wählt für jeden Gegenstand den nächsten Händler deiner Fraktion. Du brauchst 50 {item:2678} (1s).",

	-- Step 7: Herb Baked Egg: ingredients
	-- {item:6888} Herb Baked Egg
	["{item:6888}: ingredients"] = "{item:6888}: Zutaten",
	-- {npc:1995} Strigid Owl · {zone:1438} Teldrassil
	["{npc:1995} (58%) in {zone:1438}, or wherever the arrow points"] = "{npc:1995} (58%) in {zone:1438}, oder wohin der Pfeil zeigt",

	-- Step 8: Herb Baked Egg (1-50)
	-- {item:6888} Herb Baked Egg · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2678} Mild Spices · {zone:1438} Teldrassil · {item:6889} Small Egg · {zone:1439} Darkshore · {item:6290} Brilliant Smallfish · {npc:6286} Zarrin · {area:186} Dolanaar · {item:5472} Kaldorei Spider Kabob
	-- plural, as words: Small Spider Legs = {item:5465} Small Spider Leg
	["{item:6888} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. {item:6888} comes with {skill:185} (the client teaches it with the skill); {item:2678} are a cooking vendor's. The Strigid owls of {zone:1438} drop a {item:6889} more often than not, and {zone:1439}'s moonkin drop them too. Fishers can cook {item:6290} (recipe 40c) from Rut'theran's waters instead, and {npc:6286} in {area:186} gives Recipe of the Kaldorei (seven Small Spider Legs from the Webwood spiders) for {item:5472}, orange from 10 to 50."] = "{item:6888} ist ab 1 orange (gelb bei 45, grün bei 65, grau bei 85): etwa 50 Herstellungen bis 50. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. {item:6888} kommt mit {skill:185} (der Client bringt es mit der Fertigkeit bei); {item:2678} verkaufen Kochhändler. Die Strigid-Eulen in {zone:1438} lassen meistens ein {item:6889} fallen, und auch die Moonkin in {zone:1439} lassen sie fallen. Angler können stattdessen {item:6290} (Rezept 40c) aus den Gewässern von Rut'theran kochen, und {npc:6286} in {area:186} gibt für {item:5472} Recipe of the Kaldorei (sieben Small Spider Legs von den Spinnen im Webwood), orange von 10 bis 50.",

	-- Step 9: Charred Wolf Meat: ingredients
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} in Zephras Isle, or wherever the arrow points"] = "{npc:250873} auf Zephras Isle, oder wohin der Pfeil zeigt",

	-- Step 10: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire · {item:2672} Stringy Wolf Meat
	["{spell:2538} is orange from 1 (yellow at 45, green at 65, grey at 85): about 50 crafts to 50. Cook at any fire: a town hearth or your own {object:29784}. The Vuldren of Zephras Isle drop {item:2672}."] = "{spell:2538} ist ab 1 orange (gelb bei 45, grün bei 65, grau bei 85): etwa 50 Herstellungen bis 50. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. Die Vuldren auf Zephras Isle lassen {item:2672} fallen.",

	-- Step 11: Roasted Boar Meat: ingredients
	-- {npc:3099} Dire Mottled Boar · {zone:1411} Durotar
	["{npc:3099} (99%) in {zone:1411}, or wherever the arrow points"] = "{npc:3099} (99%) in {zone:1411}, oder wohin der Pfeil zeigt",

	-- Step 13: Charred Wolf Meat: ingredients
	-- {npc:2960} Prairie Wolf Alpha · {npc:2959} Prairie Stalker · {zone:1412} Mulgore
	["{npc:2960} (82%), {npc:2959} (77%) in {zone:1412}, or wherever the arrow points"] = "{npc:2960} (82%), {npc:2959} (77%) in {zone:1412}, oder dort, wo der Pfeil hinzeigt",

	-- Step 15: Charred Wolf Meat: ingredients
	-- {npc:1547} Decrepit Darkhound · {npc:1548} Cursed Darkhound · {zone:1420} Tirisfal Glades
	["{npc:1547} (72%), {npc:1548} (33%) in {zone:1420}, or wherever the arrow points"] = "{npc:1547} (72%), {npc:1548} (33%) in {zone:1420}, oder wohin der Pfeil zeigt",

	-- Step 17: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "Geselle: {skill:185}",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction; training costs 5s."] = "Die Gesellenstufe von {skill:185} erhöht das Limit auf 150; sie erfordert Fertigkeit 50 und Charakterstufe 10: Der Pfeil wählt den nächsten {skill:185}-Lehrer deiner Fraktion; die Ausbildung kostet 5s.",

	-- Step 18: Coyote Steak: ingredients
	-- {spell:2541} Coyote Steak
	["{spell:2541}: ingredients"] = "{spell:2541}: Zutaten",
	-- {npc:834} Coyote · {npc:833} Coyote Packleader · {zone:1436} Westfall
	["{npc:834} (54%), {npc:833} (51%) in {zone:1436}, or wherever the arrow points"] = "{npc:834} (54%), {npc:833} (51%) in {zone:1436}, oder wohin der Pfeil zeigt",

	-- Step 19: Coyote Steak (50-90)
	-- {spell:2541} Coyote Steak · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {npc:235} Salma Saldean · {area:108} Sentinel Hill · {item:733} Westfall Stew · {item:724} Goretusk Liver Pie
	-- plural, as words: Coyotes = {npc:834} Coyote
	["{spell:2541} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. Coyotes roam the middle of {zone:1436}; {npc:235} on the farm north of {area:108} also gives {item:733} and {item:724} quests that use what you loot here."] = "{spell:2541} ist ab 50 orange (gelb bei 90, grün bei 110, grau bei 130): etwa 40 Herstellungen bis 90. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. Jeder {skill:185}-Lehrer bringt es ab Fertigkeit 50 für 1s bei. Kojoten streifen durch die Mitte von {zone:1436}; {npc:235} auf der Farm nördlich von {area:108} gibt außerdem Quests für {item:733} und {item:724}, die verwenden, was du hier erbeutest.",

	-- Step 20: Crab Cake: shopping
	-- {spell:2544} Crab Cake
	["{spell:2544}: shopping"] = "{spell:2544}: Einkauf",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 44 {item:2678} (90c)."] = "Der Pfeil wählt für jeden Gegenstand den nächsten Händler deiner Fraktion. Du brauchst 44 {item:2678} (90c).",

	-- Step 21: Crab Cake: ingredients
	-- {spell:2544} Crab Cake
	["{spell:2544}: ingredients"] = "{spell:2544}: Zutaten",
	-- {npc:830} Sand Crawler · {zone:1436} Westfall
	["{npc:830} (43%) in {zone:1436}, or wherever the arrow points"] = "{npc:830} (43%) in {zone:1436}, oder wohin der Pfeil zeigt",

	-- Step 22: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1436} Westfall · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1436} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544} ist ab 90 orange (gelb bei 115, grün bei 135, grau bei 155): etwa 44 Herstellungen bis 130. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. Jeder {skill:185}-Lehrer bringt es ab Fertigkeit 75 für 2s bei. Krabben säumen die ganze Küste von {zone:1436}. Koch es bis 130, dann übernimmt {spell:3376}.",

	-- Step 23: Smoked Bear Meat: shopping
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: shopping"] = "{item:6890}: Einkauf",
	["The arrow picks the nearest vendor of your faction for each item."] = "Der Pfeil wählt für jeden Gegenstand den nächsten Händler deiner Fraktion.",

	-- Step 24: Smoked Bear Meat: ingredients
	-- {item:6890} Smoked Bear Meat
	["{item:6890}: ingredients"] = "{item:6890}: Zutaten",
	-- {npc:1189} Black Bear Patriarch · {zone:1432} Loch Modan
	["{npc:1189} (39%) in {zone:1432}, or wherever the arrow points"] = "{npc:1189} (39%) in {zone:1432}, oder wohin der Pfeil zeigt",

	-- Step 25: Smoked Bear Meat (50-80)
	-- {item:6890} Smoked Bear Meat · {object:29784} Basic Campfire · {item:6892} Recipe: Smoked Bear Meat · {zone:1432} Loch Modan
	["{item:6890} is orange from 50 (yellow at 80, green at 100, grey at 120): about 30 crafts to 80. Cook at any fire: a town hearth or your own {object:29784}. {item:6892} costs 2s 50c at its vendor; the arrow picks the nearest one of your faction. Black bears roam the hills of {zone:1432}."] = "{item:6890} ist ab 50 orange (gelb bei 80, grün bei 100, grau bei 120): etwa 30 Herstellungen bis 80. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. {item:6892} kostet 2s 50c beim Händler; der Pfeil wählt den nächsten deiner Fraktion. Schwarzbären streifen durch die Hügel von {zone:1432}.",

	-- Step 26: Dry Pork Ribs: shopping
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: shopping"] = "{spell:2546}: Einkauf",
	-- {item:2678} Mild Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2678} (1s 10c)."] = "Der Pfeil wählt für jeden Gegenstand den nächsten Händler deiner Fraktion. Du brauchst 52 {item:2678} (1s 10c).",

	-- Step 27: Dry Pork Ribs: ingredients
	-- {spell:2546} Dry Pork Ribs
	["{spell:2546}: ingredients"] = "{spell:2546}: Zutaten",
	-- {npc:1191} Mangy Mountain Boar · {zone:1432} Loch Modan
	["{npc:1191} (31%) in {zone:1432}, or wherever the arrow points"] = "{npc:1191} (31%) in {zone:1432}, oder wohin der Pfeil zeigt",

	-- Step 28: Dry Pork Ribs (80-130)
	-- {spell:2546} Dry Pork Ribs · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1432} Loch Modan · {spell:3376} Curiously Tasty Omelet
	["{spell:2546} is orange from 80 (yellow at 120, green at 140, grey at 160): about 52 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 80 for 1s 50c. Mountain boars roam all of {zone:1432}. Cook it to 130, where {spell:3376} takes over."] = "{spell:2546} ist ab 80 orange (gelb bei 120, grün bei 140, grau bei 160): etwa 52 Herstellungen bis 130. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. Jeder {skill:185}-Lehrer bringt es ab Fertigkeit 80 für 1s 50c bei. Bergeber streifen durch ganz {zone:1432}. Koch es bis 130, dann übernimmt {spell:3376}.",

	-- Step 29: Boiled Clams: shopping
	-- {item:5525} Boiled Clams
	["{item:5525}: shopping"] = "{item:5525}: Einkauf",
	-- {item:159} Refreshing Spring Water
	["The arrow picks the nearest vendor of your faction for each item. You need 40 {item:159} (2s)."] = "Der Pfeil wählt für jeden Gegenstand den nächsten Händler deiner Fraktion. Du brauchst 40 {item:159} (2s).",

	-- Step 30: Boiled Clams: ingredients
	-- {item:5525} Boiled Clams
	["{item:5525}: ingredients"] = "{item:5525}: Zutaten",
	-- {npc:3812} Clattering Crawler · {npc:3814} Spined Crawler · {npc:3944} Wrathtail Priestess · {zone:1439} Darkshore · {item:5523} Small Barnacled Clam · {item:5503} Clam Meat
	["{npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) in {zone:1439}, or wherever the arrow points; open each {item:5523} for its {item:5503}"] = "{npc:3812} (42%), {npc:3814} (42%), {npc:3944} (42%) in {zone:1439}, oder wohin der Pfeil zeigt; öffne jede {item:5523} für ihr {item:5503}",

	-- Step 31: Boiled Clams (50-90)
	-- {item:5525} Boiled Clams · {object:29784} Basic Campfire · {skill:185} Cooking · {item:2674} Crawler Meat · {spell:2544} Crab Cake
	["{item:5525} is orange from 50 (yellow at 90, green at 110, grey at 130): about 40 crafts to 90. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 50 for 1s. The same coastal crawlers drop {item:2674} for {spell:2544} next: keep it."] = "{item:5525} ist ab 50 orange (gelb bei 90, grün bei 110, grau bei 130): etwa 40 Herstellungen bis 90. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. Jeder {skill:185}-Lehrer bringt es ab Fertigkeit 50 für 1s bei. Dieselben Küstenkrabben lassen {item:2674} für das nächste {spell:2544} fallen: Behalte es.",

	-- Step 33: Crab Cake: ingredients
	-- {npc:3814} Spined Crawler · {npc:3812} Clattering Crawler · {zone:1439} Darkshore
	["{npc:3814} (42%), {npc:3812} (40%) in {zone:1439}, or wherever the arrow points"] = "{npc:3814} (42%), {npc:3812} (40%) in {zone:1439}, oder wohin der Pfeil zeigt",

	-- Step 34: Crab Cake (90-130)
	-- {spell:2544} Crab Cake · {object:29784} Basic Campfire · {skill:185} Cooking · {zone:1439} Darkshore · {spell:3376} Curiously Tasty Omelet
	["{spell:2544} is orange from 90 (yellow at 115, green at 135, grey at 155): about 44 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. Any {skill:185} trainer teaches it from skill 75 for 2s. Crawlers line the whole {zone:1439} coast. Cook it to 130, where {spell:3376} takes over."] = "{spell:2544} ist ab 90 orange (gelb bei 115, grün bei 135, grau bei 155): etwa 44 Herstellungen bis 130. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. Jeder {skill:185}-Lehrer bringt es ab Fertigkeit 75 für 2s bei. Krabben säumen die ganze Küste von {zone:1439}. Koch es bis 130, dann übernimmt {spell:3376}.",

	-- Step 35: Strider Stew: shopping
	-- {item:5477} Strider Stew
	["{item:5477}: shopping"] = "{item:5477}: Einkauf",
	-- {item:4536} Shiny Red Apple
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:4536} (2s 75c)."] = "Der Pfeil wählt für jeden Gegenstand den nächsten Händler deiner Fraktion. Du brauchst 52 {item:4536} (2s 75c).",

	-- Step 36: Strider Stew: ingredients
	-- {item:5477} Strider Stew
	["{item:5477}: ingredients"] = "{item:5477}: Zutaten",
	-- {npc:3246} Fleeting Plainstrider · {zone:1413} The Barrens
	["{npc:3246} (32%) in {zone:1413}, or wherever the arrow points"] = "{npc:3246} (32%) in {zone:1413}, oder wohin der Pfeil zeigt",

	-- Step 37: Strider Stew (50-100)
	-- {item:5477} Strider Stew · {object:29784} Basic Campfire · {item:5486} Recipe: Strider Stew
	["{item:5477} is orange from 50 (yellow at 90, green at 110, grey at 130): about 52 crafts to 100. Cook at any fire: a town hearth or your own {object:29784}. {item:5486} costs 4s 40c at its vendor; the arrow picks the nearest one of your faction."] = "{item:5477} ist ab 50 orange (gelb bei 90, grün bei 110, grau bei 130): etwa 52 Herstellungen bis 100. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. {item:5486} kostet 4s 40c beim Händler; der Pfeil wählt den nächsten deiner Fraktion.",

	-- Step 38: Crispy Lizard Tail: shopping
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: shopping"] = "{item:5479}: Einkauf",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 30 {item:2692} (12s)."] = "Der Pfeil wählt für jeden Gegenstand den nächsten Händler deiner Fraktion. Du brauchst 30 {item:2692} (12s).",

	-- Step 39: Crispy Lizard Tail: ingredients
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: ingredients"] = "{item:5479}: Zutaten",
	-- {npc:3239} Thunderhead · {zone:1413} The Barrens
	["{npc:3239} (59%), Owatanka (35%) in {zone:1413}, or wherever the arrow points"] = "{npc:3239} (59%), Owatanka (35%) in {zone:1413}, oder dort, wo der Pfeil hinzeigt",

	-- Step 40: Crispy Lizard Tail (100-130)
	-- {item:5479} Crispy Lizard Tail · {object:29784} Basic Campfire · {item:5488} Recipe: Crispy Lizard Tail · {npc:3489} Zargh · {item:3735} Recipe: Hot Lion Chops
	["{item:5479} is orange from 100 (yellow at 140, green at 160, grey at 180): about 30 crafts to 130. Cook at any fire: a town hearth or your own {object:29784}. {item:5488} costs 4s at its vendor; the arrow picks the nearest one of your faction. {npc:3489}, the butcher beside this vendor at the Crossroads, sells {item:3735} (18s), the recipe after Expert: buy it now."] = "{item:5479} ist ab 100 orange (gelb bei 140, grün bei 160, grau bei 180): etwa 30 Herstellungen bis 130. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. {item:5488} kostet 4s beim Händler; der Pfeil wählt den nächsten deiner Fraktion. {npc:3489}, der Metzger neben diesem Händler am Crossroads, verkauft {item:3735} (18s), das Rezept nach der Expertenstufe: Kauf es jetzt.",

	-- Step 41: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "Experte: {skill:185}",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook
	["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072} (1g); the arrow picks its nearest seller for your faction. Buy it and read it."] = "Die Expertenstufe von {skill:185} erhöht das Limit auf 225; sie erfordert Fertigkeit 125 und Charakterstufe 20: Es ist ein Buch, {item:16072} (1g); der Pfeil wählt den nächsten Verkäufer für deine Fraktion. Kauf es und lies es.",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "Kaufe und lies {item:16072} ({skill:185}, Experte)",

	-- Step 42: Curiously Tasty Omelet: shopping
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: shopping"] = "{spell:3376}: Einkauf",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 46 {item:2692} (18s 40c)."] = "Der Pfeil wählt für jeden Gegenstand den nächsten Händler deiner Fraktion. Du brauchst 46 {item:2692} (18s 40c).",

	-- Step 43: Curiously Tasty Omelet: ingredients
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: ingredients"] = "{spell:3376}: Zutaten",
	-- {npc:1018} Highland Razormaw · {npc:1019} Elder Razormaw · {zone:1437} Wetlands
	["{npc:1018} (72%), {npc:1019} (67%) in {zone:1437}, or wherever the arrow points"] = "{npc:1018} (72%), {npc:1019} (67%) in {zone:1437}, oder dort, wo der Pfeil hinzeigt",

	-- Step 44: Curiously Tasty Omelet (130-175)
	-- {spell:3376} Curiously Tasty Omelet · {object:29784} Basic Campfire · {item:3682} Recipe: Curiously Tasty Omelet · {zone:1437} Wetlands · {item:3685} Raptor Egg · {npc:340} Kendor Kabonka · {zone:1453} Stormwind
	["{spell:3376} is orange from 130 (yellow at 170, green at 190, grey at 210): about 46 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3682} costs 16s at its vendor; the arrow picks the nearest one of your faction. The raptors of the {zone:1437} drop a {item:3685} about two kills in three. {npc:340} in {zone:1453} sells the recipe."] = "{spell:3376} ist ab 130 orange (gelb bei 170, grün bei 190, grau bei 210): etwa 46 Herstellungen bis 175. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. {item:3682} kostet 16s beim Händler; der Pfeil wählt den nächsten deiner Fraktion. Die Raptoren in {zone:1437} lassen etwa bei zwei von drei Kills ein {item:3685} fallen. {npc:340} in {zone:1453} verkauft das Rezept.",

	-- Step 45: Hot Lion Chops: shopping
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: shopping"] = "{spell:3398}: Einkauf",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 45 {item:2692} (18s)."] = "Der Pfeil wählt für jeden Gegenstand den nächsten Händler deiner Fraktion. Du brauchst 45 {item:2692} (18s).",

	-- Step 46: Hot Lion Chops: ingredients
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: ingredients"] = "{spell:3398}: Zutaten",
	-- {npc:2384} Starving Mountain Lion · {zone:1424} Hillsbrad Foothills
	["{npc:2384} (42%) in {zone:1424}, or wherever the arrow points"] = "{npc:2384} (42%) in {zone:1424}, oder wohin der Pfeil zeigt",

	-- Step 47: Hot Lion Chops (130-175)
	-- {spell:3398} Hot Lion Chops · {object:29784} Basic Campfire · {item:3735} Recipe: Hot Lion Chops · {item:3731} Lion Meat
	-- plural, as words: Hulking Mountain Lions = {npc:2407} Hulking Mountain Lion
	["{spell:3398} is orange from 130 (yellow at 175, green at 195, grey at 215): about 45 crafts to 175. Cook at any fire: a town hearth or your own {object:29784}. {item:3735} costs 18s at its vendor; the arrow picks the nearest one of your faction. The Feral and Hulking Mountain Lions of Hillsbrad Foothills drop {item:3731} more often than the Starving ones."] = "{spell:3398} ist ab 130 orange (gelb bei 175, grün bei 195, grau bei 215): etwa 45 Herstellungen bis 175. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. {item:3735} kostet 18s beim Händler; der Pfeil wählt den nächsten deiner Fraktion. Die Feral und Hulking Mountain Lions im Vorgebirge von Hillsbrad lassen {item:3731} häufiger fallen als die Starving.",

	-- Step 48: Roast Raptor: shopping
	-- {item:12210} Roast Raptor
	["{item:12210}: shopping"] = "{item:12210}: Einkauf",
	-- {item:2692} Hot Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 52 {item:2692} (20s 80c)."] = "Der Pfeil wählt für jeden Gegenstand den nächsten Händler deiner Fraktion. Du brauchst 52 {item:2692} (20s 80c).",

	-- Step 49: Roast Raptor: ingredients
	-- {item:12210} Roast Raptor
	["{item:12210}: ingredients"] = "{item:12210}: Zutaten",
	-- {npc:2560} Highland Thrasher · {zone:1417} Arathi Highlands
	["{npc:2560} (38%) in {zone:1417}, or wherever the arrow points"] = "{npc:2560} (38%) in {zone:1417}, oder wohin der Pfeil zeigt",

	-- Step 50: Roast Raptor (175-225)
	-- {item:12210} Roast Raptor · {object:29784} Basic Campfire · {item:12228} Recipe: Roast Raptor · {zone:1417} Arathi Highlands · {npc:2810} Hammon Karwn · {area:320} Refuge Pointe · {npc:2821} Keena · {area:321} Hammerfall · {item:2692} Hot Spices · {item:17222} Spider Sausage · {item:12205} White Spider Meat
	["{item:12210} is orange from 175 (yellow at 215, green at 235, grey at 255): about 52 crafts to 225. Cook at any fire: a town hearth or your own {object:29784}. {item:12228} costs 50s at its vendor; the arrow picks the nearest one of your faction. {zone:1417}: {npc:2810} at {area:320} (Alliance) and {npc:2821} at {area:321} (Horde) sell the recipe and {item:2692} beside the raptors. {item:17222} (any trainer from 200, 40s) is the alternative, but it takes two {item:12205} a craft and Dustwallow's spiders drop one about two kills in five."] = "{item:12210} ist ab 175 orange (gelb bei 215, grün bei 235, grau bei 255): etwa 52 Herstellungen bis 225. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. {item:12228} kostet 50s beim Händler; der Pfeil wählt den nächsten deiner Fraktion. {zone:1417}: {npc:2810} bei {area:320} (Allianz) und {npc:2821} bei {area:321} (Horde) verkaufen das Rezept und {item:2692} neben den Raptoren. {item:17222} (bei jedem Lehrer ab 200, 40s) ist die Alternative, braucht aber zwei {item:12205} pro Herstellung, und die Spinnen in Dustwallow lassen etwa bei zwei von fünf Kills eine fallen.",

	-- Step 51: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "{skill:185} (Fachmann) lernst du bei {npc:8125} in {area:976} ({zone:1446}). Der Kochkunstlehrer in {zone:1455} schickt dich hin; erfordert Fertigkeit 225 und Stufe 35.",

	-- Step 52: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "{skill:185} (Fachmann) lernst du bei {npc:8125} in {area:976} ({zone:1446}). Der Kochkunstlehrer in {zone:1454} schickt dich hin; erfordert Fertigkeit 225 und Stufe 35.",

	-- Step 53: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "Rieseneier",
	-- {quest:6610} Clamlette Surprise · {item:7974} Zesty Clam Meat · {item:8932} Alterac Swiss · {zone:1446} Tanaris · {zone:1425} The Hinterlands · {npc:2929} Savage Owlbeast · {item:12218} Monster Omelet
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["{quest:6610} asks for 12 Giant Eggs, 10 {item:7974} and 20 {item:8932}: bring all three before you go to {zone:1446}, so you make the trip once. Giant Eggs drop from the owlbeasts of {zone:1425}: {npc:2929} (54%). {item:12218} takes about 120 more after Artisan: farm them now too if you like."] = "{quest:6610} verlangt 12 Giant Eggs, 10 {item:7974} und 20 {item:8932}: Bring alle drei mit, bevor du nach {zone:1446} gehst, damit du die Reise nur einmal machst. Giant Eggs lassen die Eulenbestien in {zone:1425} fallen: {npc:2929} (54%). {item:12218} braucht nach der Meisterstufe etwa 120 weitere: Farm sie ruhig auch schon jetzt.",

	-- Step 54: Alterac Swiss
	-- {item:8932} Alterac Swiss
	["Innkeepers and food vendors sell {item:8932}; the arrow picks the nearest."] = "Gastwirte und Essenshändler verkaufen {item:8932}; der Pfeil wählt den nächsten.",

	-- Step 55: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {zone:1445} Dustwallow Marsh · {zone:1446} Tanaris
	-- plural, as words: Big-mouth Clams = {item:7973} Big-mouth Clam · Steeljaw Snappers = {npc:14123} Steeljaw Snapper
	["{item:7974} comes from Big-mouth Clams: open each one, every clam holds one. The Muckshell crabs on the {zone:1445} coast south-west of Theramore drop a clam about seven kills in ten, so ten clams take about fifteen kills, on your way to {zone:1446}. The Steeljaw Snappers on {zone:1446}'s east coast drop them about one kill in three."] = "{item:7974} stammt aus Big-mouth Clams: Öffne jede, jede Muschel enthält eine. Die Muckshell-Krabben an der Küste von {zone:1445} südwestlich von Theramore lassen etwa bei sieben von zehn Kills eine Muschel fallen, zehn Muscheln brauchen also etwa fünfzehn Kills, auf deinem Weg nach {zone:1446}. Die Steeljaw Snappers an der Ostküste von {zone:1446} lassen sie etwa bei jedem dritten Kill fallen.",

	-- Step 56: Clamlette Surprise
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "Fachmann: {skill:185}",

	-- Step 57: Monster Omelet: shopping
	-- {item:12218} Monster Omelet
	["{item:12218}: shopping"] = "{item:12218}: Einkauf",
	-- {item:3713} Soothing Spices
	["The arrow picks the nearest vendor of your faction for each item. You need 240 {item:3713} (3g 84s)."] = "Der Pfeil wählt für jeden Gegenstand den nächsten Händler deiner Fraktion. Du brauchst 240 {item:3713} (3g 84s).",

	-- Step 58: Monster Omelet: ingredients
	-- {item:12218} Monster Omelet
	["{item:12218}: ingredients"] = "{item:12218}: Zutaten",
	-- {npc:2929} Savage Owlbeast · {zone:1425} The Hinterlands
	["{npc:2929} (54%) in {zone:1425}, or wherever the arrow points"] = "{npc:2929} (54%) in {zone:1425}, oder wohin der Pfeil zeigt",

	-- Step 59: Monster Omelet (225-300)
	-- {item:12218} Monster Omelet · {object:29784} Basic Campfire · {item:16110} Recipe: Monster Omelet · {item:13931} Nightfin Soup · {npc:8137} Gikkix · {area:977} Steamwheedle Port · {item:13932} Poached Sunscale Salmon · {item:279982} Iron Oven
	["{item:12218} is orange from 225 (yellow at 265, green at 285, grey at 305): about 120 crafts to 300. Cook at any fire: a town hearth or your own {object:29784}. {item:16110} costs 1g 20s at its vendor; the arrow picks the nearest one of your faction. {item:12218} is orange to 265 and green from 285, yet it still carries you to 300. Fishers can finish on {item:13931} ({npc:8137}, {area:977}; yellow to 310) instead; {item:13932} needs an {item:279982} on Forever."] = "{item:12218} ist ab 225 orange (gelb bei 265, grün bei 285, grau bei 305): etwa 120 Herstellungen bis 300. Koch an jedem Feuer: einem Stadtfeuer oder deinem eigenen {object:29784}. {item:16110} kostet 1g 20s beim Händler; der Pfeil wählt den nächsten deiner Fraktion. {item:12218} ist bis 265 orange und ab 285 grün, bringt dich aber trotzdem bis 300. Angler können stattdessen mit {item:13931} ({npc:8137}, {area:977}; gelb bis 310) abschließen; {item:13932} braucht in Forever ein {item:279982}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5); the arrow picks the nearest."] = "Jeder Lehrer für {skill:185} deiner Fraktion lehrt {skill:185} (Lehrling) (Charakterstufe 5); der Pfeil wählt den nächsten.",
	-- ["Catch about 50 {item:6291} here by fishing (see the {skill:356} guide)."] = "Fange hier etwa 50 {item:6291} beim Angeln (siehe den Leitfaden für {skill:356}).",
	-- ["Catch about 68 {item:6361} here by fishing (see the {skill:356} guide)."] = "Fange hier etwa 68 {item:6361} beim Angeln (siehe den Leitfaden für {skill:356}).",
	-- ["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072}; the arrow picks its nearest seller for your faction. Buy it and read it."] = "{skill:185} (Experte) hebt die Obergrenze auf 225; erfordert Fertigkeit 125 und Charakterstufe 20: Es ist ein Buch, {item:16072}; der Pfeil wählt den nächsten Verkäufer deiner Fraktion. Kaufe es und lies es.",
	-- ["Giant Eggs drop from the Ironbeak owls of {zone:1448}."] = "Rieseneier droppen bei den Eisenschnabeleulen in {zone:1448}.",
	-- ["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction."] = "{skill:185} (Geselle) hebt die Obergrenze auf 150; erfordert Fertigkeit 50 und Charakterstufe 10: Der Pfeil wählt den nächsten Lehrer für {skill:185} deiner Fraktion.",
	-- ["{area:442} docks"] = "Stege von {area:442}",
	-- ["{area:702} docks"] = "Stege von {area:702}",
	-- ["{item:12210} is orange from 175 (yellow at 215, grey at 255): about 40 crafts to 215. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12210} ist orange ab 175 (gelb ab 215, grau ab 255): etwa 40 Herstellungen bis 215. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{item:12215} is orange from 215 (yellow at 240, grey at 280): about 10 crafts to 225. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215} ist orange ab 215 (gelb ab 240, grau ab 280): etwa 10 Herstellungen bis 225. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{item:12215} is orange from 225 (yellow at 240, grey at 280): about 15 crafts to 240. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215} ist orange ab 225 (gelb ab 240, grau ab 280): etwa 15 Herstellungen bis 240. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{item:12215}: ingredients"] = "{item:12215}: Zutaten",
	-- ["{item:12215}: shopping"] = "{item:12215}: Einkauf",
	-- ["{item:12218} is orange from 240 (yellow at 265, grey at 305): about 105 crafts to 300. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12218} ist orange ab 240 (gelb ab 265, grau ab 305): etwa 105 Herstellungen bis 300. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{item:5095} is orange from 50 (yellow at 90, grey at 130): about 68 crafts to 110. Cook at any fire: {object:29784} comes with {skill:185}. {skill:356} off the {area:442} docks catches {item:6361}."] = "{item:5095} ist orange ab 50 (gelb ab 90, grau ab 130): etwa 68 Herstellungen bis 110. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}. Mit {skill:356} an den Stegen von {area:442} fängst du {item:6361}.",
	-- ["{item:5095}: ingredients"] = "{item:5095}: Zutaten",
	-- ["{item:5095}: shopping"] = "{item:5095}: Einkauf",
	-- ["{item:5477} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5477} ist orange ab 50 (gelb ab 90, grau ab 130): etwa 52 Herstellungen bis 100. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{item:5479} is orange from 100 (yellow at 140, grey at 180): about 25 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479} ist orange ab 100 (gelb ab 140, grau ab 180): etwa 25 Herstellungen bis 125. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{item:5479} is orange from 125 (yellow at 140, grey at 180): about 15 crafts to 140. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479} ist orange ab 125 (gelb ab 140, grau ab 180): etwa 15 Herstellungen bis 140. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{item:5480} is orange from 110 (yellow at 150, grey at 190): about 15 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480} ist orange ab 110 (gelb ab 150, grau ab 190): etwa 15 Herstellungen bis 125. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{item:5480} is orange from 125 (yellow at 150, grey at 190): about 25 crafts to 150. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480} ist orange ab 125 (gelb ab 150, grau ab 190): etwa 25 Herstellungen bis 150. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{item:5480}: ingredients"] = "{item:5480}: Zutaten",
	-- ["{item:5480}: shopping"] = "{item:5480}: Einkauf",
	-- ["{item:6290} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}. {item:6291} is the common catch in {zone:1438}'s waters."] = "{item:6290} ist orange ab 1 (gelb ab 45, grau ab 85): etwa 50 Herstellungen bis 50. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}. {item:6291} ist der übliche Fang in den Gewässern von {zone:1438}.",
	-- ["{item:6290}: ingredients"] = "{item:6290}: Zutaten",
	-- ["{item:6290}: shopping"] = "{item:6290}: Einkauf",
	-- ["{item:6316} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:6316} ist orange ab 50 (gelb ab 90, grau ab 130): etwa 52 Herstellungen bis 100. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{item:6316}: ingredients"] = "{item:6316}: Zutaten",
	-- ["{item:6316}: shopping"] = "{item:6316}: Einkauf",
	-- ["{item:724} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:724} ist orange ab 50 (gelb ab 90, grau ab 130): etwa 52 Herstellungen bis 100. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{item:724}: ingredients"] = "{item:724}: Zutaten",
	-- ["{item:724}: shopping"] = "{item:724}: Einkauf",
	-- ["{item:7974} has no drop data: buy it at the Gadgetzan Auction House, next to {npc:8125}, or open clams looted from coastal creatures."] = "Für {item:7974} gibt es keine Drop-Daten: Kauf es im Auktionshaus von Gadgetzan neben {npc:8125}, oder öffne Muscheln von Kreaturen an der Küste.",
	-- ["{npc:1193} (50%) in {zone:1432}, or wherever the arrow points"] = "{npc:1193} (50%) in {zone:1432}, oder dort, wo der Pfeil hinzeigt",
	-- ["{npc:1400} (50%) in {zone:1437}, or wherever the arrow points"] = "{npc:1400} (50%) in {zone:1437}, oder dort, wo der Pfeil hinzeigt",
	-- ["{npc:1549} (88%) in {zone:1420}, or wherever the arrow points"] = "{npc:1549} (88%) in {zone:1420}, oder dort, wo der Pfeil hinzeigt",
	-- ["{npc:1689} (38%), {npc:1127} (36%) in {zone:1426}, or wherever the arrow points"] = "{npc:1689} (38%), {npc:1127} (36%) in {zone:1426}, oder dort, wo der Pfeil hinzeigt",
	-- ["{npc:2385} (56%) in {zone:1424}, or wherever the arrow points"] = "{npc:2385} (56%) in {zone:1424}, oder dort, wo der Pfeil hinzeigt",
	-- ["{npc:3099} (99%), {npc:3100} (74%) in {zone:1411}, or wherever the arrow points"] = "{npc:3099} (99%), {npc:3100} (74%) in {zone:1411}, oder dort, wo der Pfeil hinzeigt",
	-- ["{npc:3244} (33%) in {zone:1413}, or wherever the arrow points"] = "{npc:3244} (33%) in {zone:1413}, oder dort, wo der Pfeil hinzeigt",
	-- ["{npc:3818} (53%) in {zone:1440}, or wherever the arrow points"] = "{npc:3818} (53%) in {zone:1440}, oder dort, wo der Pfeil hinzeigt",
	-- ["{npc:4352} (52%), {npc:4351} (51%) in {zone:1445}, or wherever the arrow points"] = "{npc:4352} (52%), {npc:4351} (51%) in {zone:1445}, oder dort, wo der Pfeil hinzeigt",
	-- ["{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) in {zone:1443}, or wherever the arrow points"] = "{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) in {zone:1443}, oder dort, wo der Pfeil hinzeigt",
	-- ["{npc:547} (35%), {npc:157} (34%) in {zone:1436}, or wherever the arrow points"] = "{npc:547} (35%), {npc:157} (34%) in {zone:1436}, oder dort, wo der Pfeil hinzeigt",
	-- ["{npc:7099} (40%) in {zone:1448}, or wherever the arrow points"] = "{npc:7099} (40%) in {zone:1448}, oder dort, wo der Pfeil hinzeigt",
	-- ["{quest:6610} asks for 20 {item:8932} (check the quest log); innkeepers and food vendors sell it, and the arrow picks the nearest."] = "{quest:6610} verlangt 20 {item:8932} (sieh im Questlog nach); Gastwirte und Lebensmittelhändler verkaufen es, der Pfeil wählt den nächsten.",
	-- ["{spell:2538} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2538} ist orange ab 1 (gelb ab 45, grau ab 85): etwa 50 Herstellungen bis 50. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{spell:2540} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2540} ist orange ab 1 (gelb ab 45, grau ab 85): etwa 50 Herstellungen bis 50. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{spell:3370} is orange from 100 (yellow at 120, grey at 160): about 26 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370} ist orange ab 100 (gelb ab 120, grau ab 160): etwa 26 Herstellungen bis 125. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{spell:3370} is yellow from 125 (yellow at 120, grey at 160): about 7 crafts to 130. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370} ist gelb ab 125 (gelb ab 120, grau ab 160): etwa 7 Herstellungen bis 130. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{spell:3370}: ingredients"] = "{spell:3370}: Zutaten",
	-- ["{spell:3370}: shopping"] = "{spell:3370}: Einkauf",
	-- ["{spell:3376} is orange from 130 (yellow at 170, grey at 210): about 46 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376} ist orange ab 130 (gelb ab 170, grau ab 210): etwa 46 Herstellungen bis 175. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{spell:3376} is orange from 150 (yellow at 170, grey at 210): about 26 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376} ist orange ab 150 (gelb ab 170, grau ab 210): etwa 26 Herstellungen bis 175. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
	-- ["{spell:3398} is orange from 140 (yellow at 175, grey at 215): about 35 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3398} ist orange ab 140 (gelb ab 175, grau ab 215): etwa 35 Herstellungen bis 175. Koche an einem beliebigen Feuer: {object:29784} erhältst du mit {skill:185}.",
}
