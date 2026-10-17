-- French (frFR): the guide forever/professions/cooking (forever/professions/cooking.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Cooking
	-- {skill:185} Cooking
	["Learn {skill:185}"] = "Apprendre {skill:185}",
	-- {skill:185} Cooking
	["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5); the arrow picks the nearest."] = "Tout maître en {skill:185} de votre faction enseigne {skill:185} (Apprenti) (niveau 5) ; la flèche indique le plus proche.",

	-- Step 2: Charred Wolf Meat: ingredients
	-- {spell:2538} Charred Wolf Meat
	["{spell:2538}: ingredients"] = "{spell:2538} : ingrédients",
	-- {zone:1429} Elwynn Forest
	["Prowler (86%) in {zone:1429}, or wherever the arrow points"] = "Rôdeur (86%) ({zone:1429}), ou là où pointe la flèche",

	-- Step 3: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:2538} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2538} est orange dès 1 (jaune à 45, gris à 85) : environ 50 préparations jusqu'à 50. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 4: Roasted Boar Meat: ingredients
	-- {spell:2540} Roasted Boar Meat
	["{spell:2540}: ingredients"] = "{spell:2540} : ingrédients",
	-- {npc:1689} Scarred Crag Boar · {npc:1127} Elder Crag Boar · {zone:1426} Dun Morogh
	["{npc:1689} (38%), {npc:1127} (36%) in {zone:1426}, or wherever the arrow points"] = "{npc:1689} (38%), {npc:1127} (36%) ({zone:1426}), ou là où pointe la flèche",

	-- Step 5: Roasted Boar Meat (1-50)
	-- {spell:2540} Roasted Boar Meat · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:2540} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2540} est orange dès 1 (jaune à 45, gris à 85) : environ 50 préparations jusqu'à 50. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 6: Brilliant Smallfish: shopping
	-- {item:6290} Brilliant Smallfish
	["{item:6290}: shopping"] = "{item:6290} : achats",
	["The arrow picks the nearest vendor of your faction for each item."] = "La flèche indique le marchand le plus proche de votre faction pour chaque objet.",

	-- Step 7: Brilliant Smallfish: ingredients
	-- {item:6290} Brilliant Smallfish
	["{item:6290}: ingredients"] = "{item:6290} : ingrédients",
	-- {area:702} Rut'theran Village
	["{area:702} docks"] = "Quais de {area:702}",
	-- {item:6291} Raw Brilliant Smallfish · {skill:356} Fishing
	["Catch about 50 {item:6291} here by fishing (see the {skill:356} guide)."] = "Pêchez ici environ 50 {item:6291} (voir le guide de {skill:356}).",

	-- Step 8: Brilliant Smallfish (1-50)
	-- {item:6290} Brilliant Smallfish · {object:29784} Basic Campfire · {skill:185} Cooking · {item:6291} Raw Brilliant Smallfish · {zone:1438} Teldrassil
	["{item:6290} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}. {item:6291} is the common catch in {zone:1438}'s waters."] = "{item:6290} est orange dès 1 (jaune à 45, gris à 85) : environ 50 préparations jusqu'à 50. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}. {item:6291} est la prise courante dans les eaux de {zone:1438}.",

	-- Step 9: Roasted Boar Meat: ingredients
	-- {npc:3099} Dire Mottled Boar · {npc:3100} Elder Mottled Boar · {zone:1411} Durotar
	["{npc:3099} (99%), {npc:3100} (74%) in {zone:1411}, or wherever the arrow points"] = "{npc:3099} (99%), {npc:3100} (74%) ({zone:1411}), ou là où pointe la flèche",

	-- Step 11: Charred Wolf Meat: ingredients
	-- {npc:2960} Prairie Wolf Alpha · {npc:2959} Prairie Stalker · {zone:1412} Mulgore
	["{npc:2960} (82%), {npc:2959} (77%) in {zone:1412}, or wherever the arrow points"] = "{npc:2960} (82%), {npc:2959} (77%) ({zone:1412}), ou là où pointe la flèche",

	-- Step 13: Charred Wolf Meat: ingredients
	-- {npc:1549} Ravenous Darkhound · {zone:1420} Tirisfal Glades
	["{npc:1549} (88%) in {zone:1420}, or wherever the arrow points"] = "{npc:1549} (88%) ({zone:1420}), ou là où pointe la flèche",

	-- Step 15: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "{skill:185} (Compagnon)",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction."] = "{skill:185} (Compagnon) porte le plafond à 150 ; requiert la compétence 50 et le niveau 10 : la flèche indique le maître en {skill:185} le plus proche de votre faction.",

	-- Step 16: Goretusk Liver Pie: shopping
	-- {item:724} Goretusk Liver Pie
	["{item:724}: shopping"] = "{item:724} : achats",

	-- Step 17: Goretusk Liver Pie: ingredients
	-- {item:724} Goretusk Liver Pie
	["{item:724}: ingredients"] = "{item:724} : ingrédients",
	-- {npc:547} Great Goretusk · {npc:157} Goretusk · {zone:1436} Westfall
	["{npc:547} (35%), {npc:157} (34%) in {zone:1436}, or wherever the arrow points"] = "{npc:547} (35%), {npc:157} (34%) ({zone:1436}), ou là où pointe la flèche",

	-- Step 18: Goretusk Liver Pie (50-100)
	-- {item:724} Goretusk Liver Pie · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:724} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:724} est orange dès 50 (jaune à 90, gris à 130) : environ 52 préparations jusqu'à 100. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 19: Loch Frenzy Delight: shopping
	-- {item:6316} Loch Frenzy Delight
	["{item:6316}: shopping"] = "{item:6316} : achats",

	-- Step 20: Loch Frenzy Delight: ingredients
	-- {item:6316} Loch Frenzy Delight
	["{item:6316}: ingredients"] = "{item:6316} : ingrédients",
	-- {npc:1193} Loch Frenzy · {zone:1432} Loch Modan
	["{npc:1193} (50%) in {zone:1432}, or wherever the arrow points"] = "{npc:1193} (50%) ({zone:1432}), ou là où pointe la flèche",

	-- Step 21: Loch Frenzy Delight (50-100)
	-- {item:6316} Loch Frenzy Delight · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:6316} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:6316} est orange dès 50 (jaune à 90, gris à 130) : environ 52 préparations jusqu'à 100. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 22: Rainbow Fin Albacore: shopping
	-- {item:5095} Rainbow Fin Albacore
	["{item:5095}: shopping"] = "{item:5095} : achats",

	-- Step 23: Rainbow Fin Albacore: ingredients
	-- {item:5095} Rainbow Fin Albacore
	["{item:5095}: ingredients"] = "{item:5095} : ingrédients",
	-- {area:442} Auberdine
	["{area:442} docks"] = "Quais d'{area:442}",
	-- {item:6361} Raw Rainbow Fin Albacore · {skill:356} Fishing
	["Catch about 68 {item:6361} here by fishing (see the {skill:356} guide)."] = "Pêchez ici environ 68 {item:6361} (voir le guide de {skill:356}).",

	-- Step 24: Rainbow Fin Albacore (50-110)
	-- {item:5095} Rainbow Fin Albacore · {object:29784} Basic Campfire · {skill:185} Cooking · {skill:356} Fishing · {area:442} Auberdine · {item:6361} Raw Rainbow Fin Albacore
	["{item:5095} is orange from 50 (yellow at 90, grey at 130): about 68 crafts to 110. Cook at any fire: {object:29784} comes with {skill:185}. {skill:356} off the {area:442} docks catches {item:6361}."] = "{item:5095} est orange dès 50 (jaune à 90, gris à 130) : environ 68 préparations jusqu'à 110. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}. La {skill:356} depuis les quais d'{area:442} rapporte des {item:6361}.",

	-- Step 25: Strider Stew: shopping
	-- {item:5477} Strider Stew
	["{item:5477}: shopping"] = "{item:5477} : achats",

	-- Step 26: Strider Stew: ingredients
	-- {item:5477} Strider Stew
	["{item:5477}: ingredients"] = "{item:5477} : ingrédients",
	-- {npc:3244} Greater Plainstrider · {zone:1413} The Barrens
	["{npc:3244} (33%) in {zone:1413}, or wherever the arrow points"] = "{npc:3244} (33%) ({zone:1413}), ou là où pointe la flèche",

	-- Step 27: Strider Stew (50-100)
	-- {item:5477} Strider Stew · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:5477} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5477} est orange dès 50 (jaune à 90, gris à 130) : environ 52 préparations jusqu'à 100. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 28: Crocolisk Steak: shopping
	-- {spell:3370} Crocolisk Steak
	["{spell:3370}: shopping"] = "{spell:3370} : achats",

	-- Step 29: Crocolisk Steak: ingredients
	-- {spell:3370} Crocolisk Steak
	["{spell:3370}: ingredients"] = "{spell:3370} : ingrédients",
	-- {npc:1400} Wetlands Crocolisk · {zone:1437} Wetlands
	["{npc:1400} (50%) in {zone:1437}, or wherever the arrow points"] = "{npc:1400} (50%) ({zone:1437}), ou là où pointe la flèche",

	-- Step 30: Crocolisk Steak (100-125)
	-- {spell:3370} Crocolisk Steak · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:3370} is orange from 100 (yellow at 120, grey at 160): about 26 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370} est orange dès 100 (jaune à 120, gris à 160) : environ 26 préparations jusqu'à 125. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 31: Lean Venison: shopping
	-- {item:5480} Lean Venison
	["{item:5480}: shopping"] = "{item:5480} : achats",

	-- Step 32: Lean Venison: ingredients
	-- {item:5480} Lean Venison
	["{item:5480}: ingredients"] = "{item:5480} : ingrédients",
	-- {npc:3818} Elder Shadowhorn Stag · {zone:1440} Ashenvale
	["{npc:3818} (53%) in {zone:1440}, or wherever the arrow points"] = "{npc:3818} (53%) ({zone:1440}), ou là où pointe la flèche",

	-- Step 33: Lean Venison (110-125)
	-- {item:5480} Lean Venison · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:5480} is orange from 110 (yellow at 150, grey at 190): about 15 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480} est orange dès 110 (jaune à 150, gris à 190) : environ 15 préparations jusqu'à 125. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 34: Crispy Lizard Tail: shopping
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: shopping"] = "{item:5479} : achats",

	-- Step 35: Crispy Lizard Tail: ingredients
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: ingredients"] = "{item:5479} : ingrédients",
	-- {npc:3239} Thunderhead · {zone:1413} The Barrens
	["{npc:3239} (59%), Owatanka (35%) in {zone:1413}, or wherever the arrow points"] = "{npc:3239} (59%), Owatanka (35%) ({zone:1413}), ou là où pointe la flèche",

	-- Step 36: Crispy Lizard Tail (100-125)
	-- {item:5479} Crispy Lizard Tail · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:5479} is orange from 100 (yellow at 140, grey at 180): about 25 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479} est orange dès 100 (jaune à 140, gris à 180) : environ 25 préparations jusqu'à 125. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 37: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "{skill:185} (Expert)",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook
	["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072}; the arrow picks its nearest seller for your faction. Buy it and read it."] = "{skill:185} (Expert) porte le plafond à 225 ; requiert la compétence 125 et le niveau 20 : c'est un livre, {item:16072} ; la flèche indique son vendeur le plus proche pour votre faction. Achetez-le et lisez-le.",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "Achetez et lisez {item:16072} ({skill:185} Expert)",

	-- Step 40: Crocolisk Steak (125-130)
	-- {spell:3370} Crocolisk Steak · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:3370} is yellow from 125 (yellow at 120, grey at 160): about 7 crafts to 130. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370} est jaune dès 125 (jaune à 120, gris à 160) : environ 7 préparations jusqu'à 130. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 41: Curiously Tasty Omelet: shopping
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: shopping"] = "{spell:3376} : achats",

	-- Step 42: Curiously Tasty Omelet: ingredients
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: ingredients"] = "{spell:3376} : ingrédients",
	-- {npc:1018} Highland Razormaw · {npc:1019} Elder Razormaw · {zone:1437} Wetlands
	["{npc:1018} (72%), {npc:1019} (67%) in {zone:1437}, or wherever the arrow points"] = "{npc:1018} (72%), {npc:1019} (67%) ({zone:1437}), ou là où pointe la flèche",

	-- Step 43: Curiously Tasty Omelet (130-175)
	-- {spell:3376} Curiously Tasty Omelet · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:3376} is orange from 130 (yellow at 170, grey at 210): about 46 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376} est orange dès 130 (jaune à 170, gris à 210) : environ 46 préparations jusqu'à 175. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 46: Lean Venison (125-150)
	-- {item:5480} Lean Venison · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:5480} is orange from 125 (yellow at 150, grey at 190): about 25 crafts to 150. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480} est orange dès 125 (jaune à 150, gris à 190) : environ 25 préparations jusqu'à 150. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 49: Curiously Tasty Omelet (150-175)
	-- {spell:3376} Curiously Tasty Omelet · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:3376} is orange from 150 (yellow at 170, grey at 210): about 26 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376} est orange dès 150 (jaune à 170, gris à 210) : environ 26 préparations jusqu'à 175. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 52: Crispy Lizard Tail (125-140)
	-- {item:5479} Crispy Lizard Tail · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:5479} is orange from 125 (yellow at 140, grey at 180): about 15 crafts to 140. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479} est orange dès 125 (jaune à 140, gris à 180) : environ 15 préparations jusqu'à 140. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 53: Hot Lion Chops: shopping
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: shopping"] = "{spell:3398} : achats",

	-- Step 54: Hot Lion Chops: ingredients
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: ingredients"] = "{spell:3398} : ingrédients",
	-- {npc:2385} Feral Mountain Lion · {zone:1424} Hillsbrad Foothills
	["{npc:2385} (56%) in {zone:1424}, or wherever the arrow points"] = "{npc:2385} (56%) ({zone:1424}), ou là où pointe la flèche",

	-- Step 55: Hot Lion Chops (140-175)
	-- {spell:3398} Hot Lion Chops · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:3398} is orange from 140 (yellow at 175, grey at 215): about 35 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3398} est orange dès 140 (jaune à 175, gris à 215) : environ 35 préparations jusqu'à 175. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 56: Roast Raptor: shopping
	-- {item:12210} Roast Raptor
	["{item:12210}: shopping"] = "{item:12210} : achats",

	-- Step 57: Roast Raptor: ingredients
	-- {item:12210} Roast Raptor
	["{item:12210}: ingredients"] = "{item:12210} : ingrédients",
	-- {npc:4352} Bloodfen Screecher · {npc:4351} Bloodfen Raptor · {zone:1445} Dustwallow Marsh
	["{npc:4352} (52%), {npc:4351} (51%) in {zone:1445}, or wherever the arrow points"] = "{npc:4352} (52%), {npc:4351} (51%) ({zone:1445}), ou là où pointe la flèche",

	-- Step 58: Roast Raptor (175-215)
	-- {item:12210} Roast Raptor · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:12210} is orange from 175 (yellow at 215, grey at 255): about 40 crafts to 215. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12210} est orange dès 175 (jaune à 215, gris à 255) : environ 40 préparations jusqu'à 215. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 59: Heavy Kodo Stew: shopping
	-- {item:12215} Heavy Kodo Stew
	["{item:12215}: shopping"] = "{item:12215} : achats",

	-- Step 60: Heavy Kodo Stew: ingredients
	-- {item:12215} Heavy Kodo Stew
	["{item:12215}: ingredients"] = "{item:12215} : ingrédients",
	-- {npc:4701} Dying Kodo · {npc:4702} Ancient Kodo · {npc:4700} Aged Kodo · {zone:1443} Desolace
	["{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) in {zone:1443}, or wherever the arrow points"] = "{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) ({zone:1443}), ou là où pointe la flèche",

	-- Step 61: Heavy Kodo Stew (215-225)
	-- {item:12215} Heavy Kodo Stew · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:12215} is orange from 215 (yellow at 240, grey at 280): about 10 crafts to 225. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215} est orange dès 215 (jaune à 240, gris à 280) : environ 10 préparations jusqu'à 225. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 62: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "{skill:185} (Artisan) s'apprend auprès de {npc:8125} à {area:976} ({zone:1446}). Le maître cuisinier de {zone:1455} vous y envoie ; requiert la compétence 225 et le niveau 35.",

	-- Step 63: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "{skill:185} (Artisan) s'apprend auprès de {npc:8125} à {area:976} ({zone:1446}). Le maître cuisinier d'{zone:1454} vous y envoie ; requiert la compétence 225 et le niveau 35.",

	-- Step 65: Alterac Swiss
	-- {quest:6610} Clamlette Surprise · {item:8932} Alterac Swiss
	["{quest:6610} asks for 20 {item:8932} (check the quest log); innkeepers and food vendors sell it, and the arrow picks the nearest."] = "{quest:6610} demande 20 {item:8932} (voir le journal des quêtes) ; les aubergistes et marchands de nourriture en vendent, et la flèche indique le plus proche.",

	-- Step 66: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "Oeufs géants",
	-- {zone:1448} Felwood
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs drop from the Ironbeak owls of {zone:1448}."] = "Les Oeufs géants sont laissés par les chouettes Bec-de-fer de {zone:1448}.",

	-- Step 67: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {npc:8125} Dirge Quikcleave
	["{item:7974} has no drop data: buy it at the Gadgetzan Auction House, next to {npc:8125}, or open clams looted from coastal creatures."] = "{item:7974} n'a pas de données de butin : achetez-la à l'hôtel des ventes de Gadgetzan, à côté de {npc:8125}, ou ouvrez les palourdes ramassées sur les créatures côtières.",

	-- Step 68: Dirge Quikcleave
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "{skill:185} (Artisan)",

	-- Step 71: Heavy Kodo Stew (225-240)
	-- {item:12215} Heavy Kodo Stew · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:12215} is orange from 225 (yellow at 240, grey at 280): about 15 crafts to 240. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215} est orange dès 225 (jaune à 240, gris à 280) : environ 15 préparations jusqu'à 240. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- Step 72: Monster Omelet: shopping
	-- {item:12218} Monster Omelet
	["{item:12218}: shopping"] = "{item:12218} : achats",

	-- Step 73: Monster Omelet: ingredients
	-- {item:12218} Monster Omelet
	["{item:12218}: ingredients"] = "{item:12218} : ingrédients",
	-- {npc:7099} Ironbeak Hunter · {zone:1448} Felwood
	["{npc:7099} (40%) in {zone:1448}, or wherever the arrow points"] = "{npc:7099} (40%) ({zone:1448}), ou là où pointe la flèche",

	-- Step 74: Monster Omelet (240-300)
	-- {item:12218} Monster Omelet · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:12218} is orange from 240 (yellow at 265, grey at 305): about 105 crafts to 300. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12218} est orange dès 240 (jaune à 265, gris à 305) : environ 105 préparations jusqu'à 300. Cuisinez à n'importe quel feu : {object:29784} s'apprend avec {skill:185}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:7974} has no drop data: buy it at the {object:175904} House, next to Dirge, or open clams looted from coastal creatures."] = "Aucune donnée de butin pour {item:7974} : achetez-en à l'hôtel des ventes ({object:175904}), à côté de Dirge, ou ouvrez les palourdes récupérées sur les créatures côtières.",
}
