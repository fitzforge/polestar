-- French (frFR): the guide forever/professions/tailoring (forever/professions/tailoring.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Tailoring
	-- {skill:197} Tailoring
	["Learn {skill:197}"] = "Apprendre {skill:197}",
	-- {skill:197} Tailoring · {item:2589} Linen Cloth
	["Apprentice {skill:197} lets you craft up to 75 for 10c, at any character level. Any {skill:197} trainer of your faction teaches it; the arrow picks the nearest. Keep every {item:2589} you loot: humanoids of level 5-20 drop it. 1-75 takes about 50c of recipes and 7s 20c of vendor goods, plus 144 {item:2589} to gather or buy."] = "{skill:197} (Apprenti) vous permet de fabriquer jusqu'à 75 pour 10 pc, à tout niveau de personnage. Tout maître de {skill:197} de votre faction l'enseigne ; la flèche indique le plus proche. Gardez toute l'{item:2589} que vous ramassez : les humanoïdes de niveau 5-20 en laissent tomber. 1-75 demande environ 50 pc de recettes et 7 pa 20 pc de fournitures de marchand, plus 144 {item:2589} à récolter ou acheter.",

	-- Step 2: Tailoring 1-75: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 1-75: vendor goods"] = "{skill:197} 1-75 : fournitures de marchand",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 72 {item:2320} (7s 20c); about 7s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Achetez d'un coup toute la part de cette tranche : 72 {item:2320} (7 pa 20 pc) ; environ 7 pa 20 pc au total. La flèche indique le vendeur de votre faction le plus proche ({zone:1453} : {npc:1347}, {npc:1286} et {npc:5565} ; {zone:1454} : {npc:3364}, {npc:3367} et {npc:5817}).",

	-- Step 3: Linen Cloth
	-- {item:2589} Linen Cloth · {spell:2387} Linen Cloak · {item:7026} Linen Belt
	["144 {item:2589} for {spell:2387} and {item:7026}: humanoids of level 5-20 drop it; or the Auction House. The arrow picks a farm spot for your level and faction."] = "144 {item:2589} pour {spell:2387} et {item:7026} : les humanoïdes de niveau 5-20 en laissent tomber ; ou l'hôtel des ventes. La flèche indique un lieu de récolte adapté à votre niveau et à votre faction.",

	-- Step 4: Linen Cloak to 15
	-- {spell:2387} Linen Cloak
	["{spell:2387} to 15"] = "{spell:2387} jusqu'à 15",
	-- {spell:2387} Linen Cloak · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{spell:2387} is orange at 1 (yellow 35, green 47, grey 60): about 7 crafts to 15, a point every craft. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 7 {spell:2963} first: it gives points too while not grey. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{spell:2387} est orange à 1 (jaune 35, vert 47, gris 60) : environ 7 fabrications jusqu'à 15, un point à chaque fabrication. Chaque fabrication demande 1 {spell:2963} et 1 {item:2320}. Fabriquez d'abord les 7 {spell:2963} : cela donne aussi des points tant que ce n'est pas gris. Le maître l'enseigne, et c'est le moyen le moins cher de passer ces points d'après les données.",

	-- Step 5: Tailoring recipes at 15
	-- {skill:197} Tailoring
	["{skill:197} recipes at 15"] = "{skill:197} : recettes à 15",
	-- {skill:197} Tailoring · {spell:8776} Linen Belt
	["Back to a {skill:197} trainer: {spell:8776} (from 15, 50c)."] = "Retournez voir un maître de métier ({skill:197}) : {spell:8776} (dès 15, 50 pc).",

	-- Step 6: Linen Belt to 75
	-- {item:7026} Linen Belt
	["{item:7026} to 75"] = "{item:7026} jusqu'à 75",
	-- {item:7026} Linen Belt · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{item:7026} is orange at 15 (yellow 50, green 67, grey 85): about 65 crafts to 75. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 65 {spell:2963} first: it gives points too while not grey. Each belt takes one bolt; the belts sell to vendors."] = "{item:7026} est orange à 15 (jaune 50, vert 67, gris 85) : environ 65 fabrications jusqu'à 75. Chaque fabrication demande 1 {spell:2963} et 1 {item:2320}. Fabriquez d'abord les 65 {spell:2963} : cela donne aussi des points tant que ce n'est pas gris. Chaque ceinture demande un rouleau ; les ceintures se vendent aux marchands.",

	-- Step 7: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "{skill:197} (compagnon)",
	-- {skill:197} Tailoring · {npc:1346} Georgio Bolero · {zone:1453} Stormwind City · {npc:2627} Grarnik Goodstitch · {zone:1434} Stranglethorn Vale · {npc:5153} Jormund Stonebrow · {zone:1455} Ironforge · {npc:4159} Me'lynn · {zone:1457} Darnassus · {npc:252380} Othesia Evengale · {npc:251991} Taleen Shimmerthread · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {npc:4576} Josef Gregorian · {zone:1458} Undercity · {npc:3363} Magar · {zone:1454} Orgrimmar · {npc:3704} Mahani · {zone:1413} The Barrens · {npc:11049} Rhiannon Davis · {zone:1456} Thunder Bluff · {spell:2964} Bolt of Woolen Cloth · {spell:2402} Woolen Cape · {spell:1229504} Faction Banner · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread · {item:2592} Wool Cloth · {item:4306} Silk Cloth
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:197} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:197} trainer teaches it: Alliance {npc:1346} ({zone:1453}), {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Zephras Isle), Sellandus ({zone:1453}), {npc:251991} (Zephras Isle) and {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}), {npc:2627} ({zone:1434}), {npc:4576} ({zone:1458}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Zephras Isle), {npc:11049} ({zone:1458}), {npc:251991} (Zephras Isle) and Tepa ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:2964} (from 55, 1s) and {spell:2402} (from 55, 2s 50c). Also learn {spell:1229504} (1s): Forever's {skill:197} camp item, a {spell:2963} and a {item:2320}; each faction has its own. The Camping 101: {skill:197} quest from your starting area's camping guide (after The Great Outdoors) sends you to a tailoring trainer who teaches it free. 75-150 takes about 11s of recipes and 1g 65s 50c of vendor goods, plus 567 {item:2592} and 204 {item:4306} to gather or buy."] = "Compagnon porte le plafond de 75 à 150 pour 5 pa ; il demande {skill:197} 50 et le niveau 10, vous pouvez donc l'apprendre à n'importe quelle visite dès 50. Tous les maîtres de {skill:197} ne l'enseignent pas : Alliance {npc:1346} ({zone:1453}), {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (île de Zéphras), Sellandus ({zone:1453}), {npc:251991} (île de Zéphras) et {npc:11052} ({zone:1445}) ; Horde {npc:2399} ({zone:1424}), {npc:2627} ({zone:1434}), {npc:4576} ({zone:1458}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (île de Zéphras), {npc:11049} ({zone:1458}), {npc:251991} (île de Zéphras) et Tepa ({zone:1456}). La flèche indique le plus proche de votre faction. Apprenez maintenant : {spell:2964} (dès 55, 1 pa) et {spell:2402} (dès 55, 2 pa 50 pc). Apprenez aussi {spell:1229504} (1 pa) : l'objet de camp de Forever pour {skill:197}, un {spell:2963} et une {item:2320} ; chaque faction a le sien. La quête Introduction au camping : {skill:197} du guide de camping de votre zone de départ (après Les grands espaces sauvages) vous envoie à un maître tailleur qui l'enseigne gratuitement. 75-150 demande environ 11 pa de recettes et 1 po 65 pa 50 pc de fournitures de marchand, plus 567 {item:2592} et 204 {item:4306} à récolter ou acheter.",

	-- Step 8: Tailoring 75-150: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 75-150: vendor goods"] = "{skill:197} 75-150 : fournitures de marchand",
	-- {item:2321} Fine Thread · {item:2324} Bleach · {item:2604} Red Dye · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 108 {item:2321} (1g 8s), 34 {item:2324} (8s 50c) and 98 {item:2604} (49s); about 1g 65s 50c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Achetez d'un coup toute la part de cette tranche : 108 {item:2321} (1 po 8 pa), 34 {item:2324} (8 pa 50 pc) et 98 {item:2604} (49 pa) ; environ 1 po 65 pa 50 pc au total. La flèche indique le vendeur de votre faction le plus proche ({zone:1453} : {npc:1347}, {npc:1286} et {npc:5565} ; {zone:1454} : {npc:3364}, {npc:3367} et {npc:5817}).",

	-- Step 9: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (Alliance)",
	-- {item:2592} Wool Cloth · {spell:2402} Woolen Cape · {spell:3866} Stylish Red Shirt · {npc:98} Riverpaw Taskmaster
	["567 {item:2592} for {spell:2402} and {spell:3866}: humanoids of level 15-30 drop it; or the Auction House. It drops from {npc:98} (level 17-18) here."] = "567 {item:2592} pour {spell:2402} et {spell:3866} : les humanoïdes de niveau 15-30 en laissent tomber ; ou l'hôtel des ventes. {npc:98} (niveau 17-18) en laisse tomber ici.",

	-- Step 10: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (Horde)",
	-- {item:2592} Wool Cloth · {spell:2402} Woolen Cape · {spell:3866} Stylish Red Shirt · {npc:3263} Bristleback Geomancer
	["567 {item:2592} for {spell:2402} and {spell:3866}: humanoids of level 15-30 drop it; or the Auction House. It drops from {npc:3263} (level 19-20) here."] = "567 {item:2592} pour {spell:2402} et {spell:3866} : les humanoïdes de niveau 15-30 en laissent tomber ; ou l'hôtel des ventes. {npc:3263} (niveau 19-20) en laisse tomber ici.",

	-- Step 11: Silk Cloth (Alliance)
	-- {item:4306} Silk Cloth
	["{item:4306} (Alliance)"] = "{item:4306} (Alliance)",
	-- {item:4306} Silk Cloth · {spell:3871} Formal White Shirt · {npc:2240} Syndicate Footpad
	["204 {item:4306} for {spell:3871}: humanoids of level 25-45 drop it; or the Auction House. It drops from {npc:2240} (level 32-33) here."] = "204 {item:4306} pour {spell:3871} : les humanoïdes de niveau 25-45 en laissent tomber ; ou l'hôtel des ventes. {npc:2240} (niveau 32-33) en laisse tomber ici.",

	-- Step 12: Silk Cloth (Horde)
	-- {item:4306} Silk Cloth
	["{item:4306} (Horde)"] = "{item:4306} (Horde)",
	-- {item:4306} Silk Cloth · {spell:3871} Formal White Shirt · {npc:11697} Mannoroc Lasher
	["204 {item:4306} for {spell:3871}: humanoids of level 25-45 drop it; or the Auction House. It drops from {npc:11697} (level 29-30) here."] = "204 {item:4306} pour {spell:3871} : les humanoïdes de niveau 25-45 en laissent tomber ; ou l'hôtel des ventes. {npc:11697} (niveau 29-30) en laisse tomber ici.",

	-- Step 13: Woolen Cape to 104
	-- {spell:2402} Woolen Cape
	["{spell:2402} to 104"] = "{spell:2402} jusqu'à 104",
	-- {spell:2402} Woolen Cape · {spell:2964} Bolt of Woolen Cloth · {item:2321} Fine Thread
	["{spell:2402} is orange at 75 (yellow 80, green 97, grey 115): about 42 crafts to 104. Each takes 1 {spell:2964} and 1 {item:2321}. Make the 42 {spell:2964} first: it gives points too while not grey. {spell:2964} is taught from 55 on Forever."] = "{spell:2402} est orange à 75 (jaune 80, vert 97, gris 115) : environ 42 fabrications jusqu'à 104. Chaque fabrication demande 1 {spell:2964} et 1 {item:2321}. Fabriquez d'abord les 42 {spell:2964} : cela donne aussi des points tant que ce n'est pas gris. {spell:2964} est enseigné dès 55 sur Forever.",

	-- Step 14: Tailoring recipes at 104
	-- {skill:197} Tailoring
	["{skill:197} recipes at 104"] = "{skill:197} : recettes à 104",
	-- {skill:197} Tailoring · {spell:3866} Stylish Red Shirt
	["Back to a {skill:197} trainer: {spell:3866} (from 85, 2s 50c)."] = "Retournez voir un maître de métier ({skill:197}) : {spell:3866} (dès 85, 2 pa 50 pc).",

	-- Step 15: Stylish Red Shirt to 135
	-- {spell:3866} Stylish Red Shirt
	["{spell:3866} to 135"] = "{spell:3866} jusqu'à 135",
	-- {spell:3866} Stylish Red Shirt · {spell:2964} Bolt of Woolen Cloth · {item:2604} Red Dye · {item:2321} Fine Thread · {item:2592} Wool Cloth
	["{spell:3866} is orange at 104 (yellow 110, green 127, grey 145): about 49 crafts to 135. Each takes 3 {spell:2964}, 2 {item:2604} and 1 {item:2321}. Make the 147 {spell:2964} first. Three woolen bolts and two {item:2604} a shirt; {item:2592} drops from humanoids of level 15-30."] = "{spell:3866} est orange à 104 (jaune 110, vert 127, gris 145) : environ 49 fabrications jusqu'à 135. Chaque fabrication demande 3 {spell:2964}, 2 {item:2604} et 1 {item:2321}. Fabriquez d'abord les 147 {spell:2964}. Trois rouleaux de laine et deux {item:2604} par chemise ; l'{item:2592} tombe sur les humanoïdes de niveau 15-30.",

	-- Step 16: Tailoring recipes at 135
	-- {skill:197} Tailoring
	["{skill:197} recipes at 135"] = "{skill:197} : recettes à 135",
	-- {skill:197} Tailoring · {spell:3839} Bolt of Silk Cloth · {spell:3871} Formal White Shirt
	["Back to a {skill:197} trainer: {spell:3839} (from 100, 5s) and {spell:3871} (from 135)."] = "Retournez voir un maître de métier ({skill:197}) : {spell:3839} (dès 100, 5 pa) et {spell:3871} (dès 135).",

	-- Step 17: Formal White Shirt to 150
	-- {spell:3871} Formal White Shirt
	["{spell:3871} to 150"] = "{spell:3871} jusqu'à 150",
	-- {spell:3871} Formal White Shirt · {spell:3839} Bolt of Silk Cloth · {item:2324} Bleach · {item:2321} Fine Thread · {item:4306} Silk Cloth · {skill:197} Tailoring
	["{spell:3871} is orange at 135 (yellow 145, green 150, grey 155): about 17 crafts to 150. Each takes 3 {spell:3839}, 2 {item:2324} and 1 {item:2321}. Make the 51 {spell:3839} first. Silk bolts from here on: {item:4306} drops from humanoids of level 25-45. {item:2324} from tailoring and trade supplies vendors. {skill:197} 150 is a Legacy System milestone."] = "{spell:3871} est orange à 135 (jaune 145, vert 150, gris 155) : environ 17 fabrications jusqu'à 150. Chaque fabrication demande 3 {spell:3839}, 2 {item:2324} et 1 {item:2321}. Fabriquez d'abord les 51 {spell:3839}. Rouleaux de soie à partir d'ici : l'{item:4306} tombe sur les humanoïdes de niveau 25-45. {item:2324} chez les marchands de couture et de fournitures. {skill:197} 150 est un palier du système d'Héritage.",

	-- Step 18: Tailoring 150-225: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 150-225: vendor goods"] = "{skill:197} 150-225 : fournitures de marchand",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {item:6260} Blue Dye · {item:8343} Heavy Silken Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 44 {item:2321} (44s), 90 {item:4291} (4g 50s), 44 {item:6260} (22s) and 80 {item:8343} (16g); about 21g 16s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Achetez d'un coup toute la part de cette tranche : 44 {item:2321} (44 pa), 90 {item:4291} (4 po 50 pa), 44 {item:6260} (22 pa) et 80 {item:8343} (16 po) ; environ 21 po 16 pa au total. La flèche indique le vendeur de votre faction le plus proche ({zone:1453} : {npc:1347}, {npc:1286} et {npc:5565} ; {zone:1454} : {npc:3364}, {npc:3367} et {npc:5817}).",

	-- Step 19: Pattern: Azure Silk Cloak
	-- {item:7089} Pattern: Azure Silk Cloak · {item:7053} Azure Silk Cloak · {skill:197} Tailoring · {npc:6576} Brienna Starglow · {zone:1444} Feralas · {npc:251997} Norvin Alderman · {zone:1416} Alterac Mountains · {npc:6574} Jun'ha · {zone:1417} Arathi Highlands
	["{item:7089} teaches {item:7053} ({skill:197} 140) for 15s. Sold by Alliance: {npc:6576} ({zone:1444}), limited stock and {npc:251997} ({zone:1416}); Horde: {npc:6574} ({zone:1417}), limited stock and {npc:251997} ({zone:1416})."] = "{item:7089} enseigne {item:7053} ({skill:197} 140) pour 15 pa. En vente — Alliance : {npc:6576} ({zone:1444}), stock limité et {npc:251997} ({zone:1416}) ; Horde : {npc:6574} ({zone:1417}), stock limité et {npc:251997} ({zone:1416}).",

	-- Step 20: Silk Cloth
	-- {item:4306} Silk Cloth · {item:7053} Azure Silk Cloak
	["264 {item:4306} for {item:7053}: humanoids of level 25-45 drop it; or the Auction House. The arrow picks a farm spot for your level and faction."] = "264 {item:4306} pour {item:7053} : les humanoïdes de niveau 25-45 en laissent tomber ; ou l'hôtel des ventes. La flèche indique un lieu de récolte adapté à votre niveau et à votre faction.",

	-- Step 21: Mageweave Cloth (Alliance)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Alliance)"] = "{item:4338} (Alliance)",
	-- {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband · {npc:4467} Vilebranch Soothsayer
	["900 {item:4338} for {item:9998} and {item:10024}: humanoids of level 35-50 drop it; or the Auction House. It drops from {npc:4467} (level 46-47) here."] = "900 {item:4338} pour {item:9998} et {item:10024} : les humanoïdes de niveau 35-50 en laissent tomber ; ou l'hôtel des ventes. {npc:4467} (niveau 46-47) en laisse tomber ici.",

	-- Step 22: Mageweave Cloth (Horde)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Horde)"] = "{item:4338} (Horde)",
	-- {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband · {npc:5472} Dunemaul Enforcer
	["900 {item:4338} for {item:9998} and {item:10024}: humanoids of level 35-50 drop it; or the Auction House. It drops from {npc:5472} (level 46-47) here."] = "900 {item:4338} pour {item:9998} et {item:10024} : les humanoïdes de niveau 35-50 en laissent tomber ; ou l'hôtel des ventes. {npc:5472} (niveau 46-47) en laisse tomber ici.",

	-- Step 23: Expert Tailoring
	-- {skill:197} Tailoring
	["Expert {skill:197}"] = "{skill:197} (expert)",
	-- {skill:197} Tailoring · {npc:1346} Georgio Bolero · {zone:1453} Stormwind City · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {npc:4576} Josef Gregorian · {zone:1458} Undercity · {spell:3865} Bolt of Mageweave · {item:4306} Silk Cloth · {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband
	["Expert raises the cap from 150 to 225; it needs {skill:197} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:1346} ({zone:1453}) and {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}) and {npc:4576} ({zone:1458}). The arrow picks the nearest of your faction. Learn now: {spell:3865} (from 140). 150-225 takes about 15s of recipes and 21g 16s of vendor goods, plus 264 {item:4306} and 900 {item:4338} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9998} (from 170) and {item:10024} (from 190), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "Expert porte le plafond de 150 à 225 ; il demande {skill:197} 125 et le niveau 20, vous pouvez donc l'apprendre à n'importe quelle visite dès 125. Seuls quelques maîtres l'enseignent : Alliance {npc:1346} ({zone:1453}) et {npc:11052} ({zone:1445}) ; Horde {npc:2399} ({zone:1424}) et {npc:4576} ({zone:1458}). La flèche indique le plus proche de votre faction. Apprenez maintenant : {spell:3865} (dès 140). 150-225 demande environ 15 pa de recettes et 21 po 16 pa de fournitures de marchand, plus 264 {item:4306} et 900 {item:4338} à récolter ou acheter. Venez avec tout cela dans vos sacs (les étapes ci-dessus, le reste à l'hôtel des ventes) : ces maîtres enseignent aussi {item:9998} (dès 170) et {item:10024} (dès 190), et les fabrications ne demandent aucun atelier, alors fabriquez sur place et apprenez chaque recette dès que vous atteignez sa compétence. Un seul trajet au lieu de 3.",

	-- Step 24: Azure Silk Cloak to 170
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 170"] = "{item:7053} jusqu'à 170",
	-- {item:7053} Azure Silk Cloak · {spell:3839} Bolt of Silk Cloth · {item:6260} Blue Dye · {item:2321} Fine Thread
	["{item:7053} is orange at 150 (yellow 160, green 175, grey 190): about 22 crafts to 170. Each takes 3 {spell:3839}, 2 {item:6260} and 2 {item:2321}. Make the 66 {spell:3839} first. Its recipe is the one bought above; it is the cheapest way through these points in the data."] = "{item:7053} est orange à 150 (jaune 160, vert 175, gris 190) : environ 22 fabrications jusqu'à 170. Chaque fabrication demande 3 {spell:3839}, 2 {item:6260} et 2 {item:2321}. Fabriquez d'abord les 66 {spell:3839}. Sa recette est celle achetée plus haut ; c'est le moyen le moins cher de passer ces points d'après les données.",
	["from the recipe in your bags"] = "avec la recette dans vos sacs",

	-- Step 25: Tailoring recipes at 170
	-- {skill:197} Tailoring
	["{skill:197} recipes at 170"] = "{skill:197} : recettes à 170",
	-- {spell:12048} Black Mageweave Vest
	["Still at the Expert trainer: {spell:12048} (from 170)."] = "Toujours chez le maître Expert : {spell:12048} (dès 170).",

	-- Step 26: Black Mageweave Vest to 197
	-- {item:9998} Black Mageweave Vest
	["{item:9998} to 197"] = "{item:9998} jusqu'à 197",
	-- {item:9998} Black Mageweave Vest · {spell:3865} Bolt of Mageweave · {item:4291} Silken Thread
	["{item:9998} is orange at 170 (yellow 185, green 200, grey 215): about 30 crafts to 197. Each takes 2 {spell:3865} and 3 {item:4291}. Make the 60 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{item:9998} est orange à 170 (jaune 185, vert 200, gris 215) : environ 30 fabrications jusqu'à 197. Chaque fabrication demande 2 {spell:3865} et 3 {item:4291}. Fabriquez d'abord les 60 {spell:3865}. Le maître l'enseigne, et c'est le moyen le moins cher de passer ces points d'après les données.",

	-- Step 27: Tailoring recipes at 197
	-- {skill:197} Tailoring
	["{skill:197} recipes at 197"] = "{skill:197} : recettes à 197",
	-- {spell:12072} Black Mageweave Headband
	["Still at the Expert trainer: {spell:12072} (from 190)."] = "Toujours chez le maître Expert : {spell:12072} (dès 190).",

	-- Step 28: Black Mageweave Headband to 225
	-- {item:10024} Black Mageweave Headband
	["{item:10024} to 225"] = "{item:10024} jusqu'à 225",
	-- {item:10024} Black Mageweave Headband · {spell:3865} Bolt of Mageweave · {item:8343} Heavy Silken Thread · {skill:197} Tailoring
	["{item:10024} is orange at 197 (yellow 205, green 220, grey 235): about 40 crafts to 225. Each takes 3 {spell:3865} and 2 {item:8343}. Make the 120 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data. {skill:197} 225 is a Legacy System milestone."] = "{item:10024} est orange à 197 (jaune 205, vert 220, gris 235) : environ 40 fabrications jusqu'à 225. Chaque fabrication demande 3 {spell:3865} et 2 {item:8343}. Fabriquez d'abord les 120 {spell:3865}. Le maître l'enseigne, et c'est le moyen le moins cher de passer ces points d'après les données. {skill:197} 225 est un palier du système d'Héritage.",

	-- Step 29: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "{skill:197} (artisan)",
	-- {skill:197} Tailoring · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {spell:18401} Bolt of Runecloth · {spell:18402} Runecloth Belt · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14227} Ironweb Spider Silk
	["Artisan raises the cap from 225 to 300; it needs {skill:197} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}). The arrow picks the nearest of your faction. Learn now: {spell:18401} (from 205) and {spell:18402} (from 210). 225-300 takes about 1g 60s of recipes and 58g of vendor goods, plus 420 {item:8170}, 3195 {item:14047} and 124 {item:14227} to gather or buy."] = "Artisan porte le plafond de 225 à 300 ; il demande {skill:197} 200 et le niveau 35, vous pouvez donc l'apprendre à n'importe quelle visite dès 200. Seuls quelques maîtres l'enseignent : Alliance {npc:11052} ({zone:1445}) ; Horde {npc:2399} ({zone:1424}). La flèche indique le plus proche de votre faction. Apprenez maintenant : {spell:18401} (dès 205) et {spell:18402} (dès 210). 225-300 demande environ 1 po 60 pa de recettes et 58 po de fournitures de marchand, plus 420 {item:8170}, 3195 {item:14047} et 124 {item:14227} à récolter ou acheter.",

	-- Step 30: Tailoring 225-300: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 225-300: vendor goods"] = "{skill:197} 225-300 : fournitures de marchand",
	-- {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 116 {item:14341} (58g); about 58g in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Achetez d'un coup toute la part de cette tranche : 116 {item:14341} (58 po) ; environ 58 po au total. La flèche indique le vendeur de votre faction le plus proche ({zone:1453} : {npc:1347}, {npc:1286} et {npc:5565} ; {zone:1454} : {npc:3364}, {npc:3367} et {npc:5817}).",

	-- Step 31: Pattern: Runecloth Gloves
	-- {item:14481} Pattern: Runecloth Gloves · {item:13863} Runecloth Gloves · {skill:197} Tailoring · {npc:11189} Qia · {zone:1452} Winterspring
	["{item:14481} teaches {item:13863} ({skill:197} 230) for 1g 60s. Sold by {npc:11189} ({zone:1452}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:14481} enseigne {item:13863} ({skill:197} 230) pour 1 po 60 pa. En vente — {npc:11189} ({zone:1452}), stock limité. Ses vendeurs en gardent un ou deux en stock, qui reviennent quelque temps après une vente ; il est lié quand on le ramasse, donc l'hôtel des ventes ne l'a jamais.",

	-- Step 32: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Alliance)",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:1815}, {npc:1816} and {npc:1817} here (level 48-60); the {skill:393} guide routes this."] = "420 {item:8170} pour {item:13863} et {item:13867} : {skill:393} : bêtes de niveau 48-60 ; ou l'hôtel des ventes. Dépecez {npc:1815}, {npc:1816} et {npc:1817} ici (niveau 48-60) ; le guide de {skill:393} en donne le parcours.",

	-- Step 33: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horde)",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "420 {item:8170} pour {item:13863} et {item:13867} : {skill:393} : bêtes de niveau 48-60 ; ou l'hôtel des ventes. Dépecez {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} et {npc:6377} ici (niveau 48-60) ; le guide de {skill:393} en donne le parcours.",

	-- Step 34: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Alliance)",
	-- {item:14047} Runecloth · {item:13856} Runecloth Belt · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {npc:7027} Blackrock Slayer
	["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:7027} (level 56-57) here."] = "3195 {item:14047} pour {item:13856}, {item:13863} et {item:13867} : les humanoïdes de niveau 45-60 en laissent tomber ; ou l'hôtel des ventes. {npc:7027} (niveau 56-57) en laisse tomber ici.",

	-- Step 35: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horde)",
	-- {item:14047} Runecloth · {item:13856} Runecloth Belt · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {npc:11880} Twilight Avenger
	["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:11880} (level 57-59) here."] = "3195 {item:14047} pour {item:13856}, {item:13863} et {item:13867} : les humanoïdes de niveau 45-60 en laissent tomber ; ou l'hôtel des ventes. {npc:11880} (niveau 57-59) en laisse tomber ici.",

	-- Step 36: Ironweb Spider Silk (Alliance)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Alliance)"] = "{item:14227} (Alliance)",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:1824} Plague Lurker
	["124 {item:14227} for {item:13867}: it drops from {npc:1824} (level 54-55) at the marked spot, or buy it at the Auction House."] = "124 {item:14227} pour {item:13867} : il tombe sur {npc:1824} (niveau 54-55) à l'endroit indiqué, ou achetez-le à l'hôtel des ventes.",

	-- Step 37: Ironweb Spider Silk (Horde)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Horde)"] = "{item:14227} (Horde)",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:11739} Rock Stalker
	["124 {item:14227} for {item:13867}: it drops from {npc:11739} (level 57-59) at the marked spot, or buy it at the Auction House."] = "124 {item:14227} pour {item:13867} : il tombe sur {npc:11739} (niveau 57-59) à l'endroit indiqué, ou achetez-le à l'hôtel des ventes.",

	-- Step 38: Runecloth Belt to 234
	-- {item:13856} Runecloth Belt
	["{item:13856} to 234"] = "{item:13856} jusqu'à 234",
	-- {item:13856} Runecloth Belt · {item:14048} Bolt of Runecloth · {item:14341} Rune Thread
	["{item:13856} is yellow at 225 (yellow 225, green 240, grey 255): about 11 crafts to 234. Each takes 3 {item:14048} and 1 {item:14341}. Make the 33 {item:14048} first. {item:14341} from tailoring vendors."] = "{item:13856} est jaune à 225 (jaune 225, vert 240, gris 255) : environ 11 fabrications jusqu'à 234. Chaque fabrication demande 3 {item:14048} et 1 {item:14341}. Fabriquez d'abord les 33 {item:14048}. {item:14341} chez les marchands de couture.",

	-- Step 39: Runecloth Gloves to 265
	-- {item:13863} Runecloth Gloves
	["{item:13863} to 265"] = "{item:13863} jusqu'à 265",
	-- {item:13863} Runecloth Gloves · {item:14048} Bolt of Runecloth · {item:8170} Rugged Leather · {item:14341} Rune Thread · {npc:11189} Qia · {area:2255} Everlook · {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["{item:13863} is orange at 234 (yellow 245, green 260, grey 275): about 43 crafts to 265. Each takes 4 {item:14048}, 4 {item:8170} and 1 {item:14341}. Make the 172 {item:14048} first. {npc:11189} in {area:2255} keeps one pattern at a time; the {area:1769} tunnel from {zone:1448} is the road in, so never kill Timbermaw furbolgs on the way."] = "{item:13863} est orange à 234 (jaune 245, vert 260, gris 275) : environ 43 fabrications jusqu'à 265. Chaque fabrication demande 4 {item:14048}, 4 {item:8170} et 1 {item:14341}. Fabriquez d'abord les 172 {item:14048}. {npc:11189} à {area:2255} n'a qu'un patron à la fois ; le tunnel de {area:1769} depuis {zone:1448} est la route d'accès, alors ne tuez jamais de furbolgs Grumegueule en chemin.",

	-- Step 40: Runecloth Shoulders to 300
	-- {item:13867} Runecloth Shoulders
	["{item:13867} to 300"] = "{item:13867} jusqu'à 300",
	-- {item:13867} Runecloth Shoulders · {item:14048} Bolt of Runecloth · {item:14227} Ironweb Spider Silk · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:14504} Pattern: Runecloth Shoulders · {zone:1422} Western Plaguelands · {zone:1451} Silithus · {item:13863} Runecloth Gloves · {item:13864} Runecloth Boots · {npc:7940} Darnall · {zone:1450} Moonglade · {item:14342} Mooncloth · {npc:11189} Qia · {npc:11188} Evie Whirlbrew · {area:2255} Everlook · {item:14256} Felcloth · {item:279943} Spinning Wheel · {npc:248202} Jim'bek · {npc:256735} Mivin Shadowweave · {npc:246017} Unstable Sentinel · {item:254123} Runecloth Cuffs · {zone:2482} Mount Hyjal · {skill:197} Tailoring
	["{item:13867} is orange at 265 (yellow 275, green 290, grey 305): about 62 crafts to 300. Each takes 7 {item:14048}, 2 {item:14227}, 4 {item:8170} and 1 {item:14341}. Make the 434 {item:14048} first. Its pattern ({item:14504}) drops from mobs all over the world and does not bind: buy it at the Auction House. Seven bolts, two {item:14227} and four {item:8170} a craft: the dearest stretch. The spiders of {zone:1422} and {zone:1451} drop the silk (the marked spots), or the Auction House. No pattern on the Auction House? {item:13863} still give a point now and then to 275, and {item:13864} ({npc:7940}, {zone:1450}) to 280, at 4 bolts a craft. {item:14342} (pattern from {npc:11189} or {npc:11188} in {area:2255}; 2 {item:14256} at a Moonwell) stays orange to 270 and yellow to 285, but it can be made once every four days. The {item:279943} patterns (Merchant's Favor sandals and waistcords from {npc:248202} or {npc:256735}; the wheel's blueprint drops from the {npc:246017} in the City of Dalaran) and {item:254123} (Pexmit in {zone:2482}, 10g; we could not confirm that vendor yet) are the other ways on. {skill:197} 300 is a Legacy System milestone."] = "{item:13867} est orange à 265 (jaune 275, vert 290, gris 305) : environ 62 fabrications jusqu'à 300. Chaque fabrication demande 7 {item:14048}, 2 {item:14227}, 4 {item:8170} et 1 {item:14341}. Fabriquez d'abord les 434 {item:14048}. Son patron ({item:14504}) tombe sur des monstres partout dans le monde et n'est pas lié : achetez-le à l'hôtel des ventes. Sept rouleaux, deux {item:14227} et quatre {item:8170} par fabrication : la portion la plus chère. Les araignées des {zone:1422} et de {zone:1451} laissent tomber la soie (aux endroits indiqués), ou l'hôtel des ventes. Pas de patron à l'hôtel des ventes ? Les {item:13863} donnent encore un point de temps en temps jusqu'à 275, et les {item:13864} ({npc:7940}, {zone:1450}) jusqu'à 280, à 4 rouleaux par fabrication. L'{item:14342} (patron chez {npc:11189} ou {npc:11188} à {area:2255} ; 2 {item:14256} à un puits de lune) reste orange jusqu'à 270 et jaune jusqu'à 285, mais ne se fabrique qu'une fois tous les quatre jours. Les patrons du {item:279943} (sandales et cordelières Merchant's Favor chez {npc:248202} ou {npc:256735} ; le plan du rouet tombe sur la {npc:246017} dans la cité de Dalaran) et {item:254123} (Pexmit à {zone:2482}, 10 po ; ce vendeur n'est pas encore confirmé) sont les autres voies. {skill:197} 300 est un palier du système d'Héritage.",
	["from the pattern bought at the Auction House"] = "avec le patron acheté à l'hôtel des ventes",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:197}"] = "{skill:197} (apprenti)",
	-- ["Artisan needs character level 35 and {skill:197} 200; it raises the cap to 300. Materials for 225-300 are worth about 845g in all."] = "Artisan nécessite le niveau 35 et {skill:197} 200 ; le plafond passe à 300. Les composants pour 225-300 valent environ 845g au total.",
	-- ["Back to a {skill:197} trainer: {spell:12048} is taught from {skill:197} 185."] = "Retournez voir un maître en {skill:197} : {spell:12048} s'apprend à partir de {skill:197} 185.",
	-- ["Back to a {skill:197} trainer: {spell:12072} is taught from {skill:197} 205."] = "Retournez voir un maître en {skill:197} : {spell:12072} s'apprend à partir de {skill:197} 205.",
	-- ["Back to a {skill:197} trainer: {spell:2402} is taught from {skill:197} 80."] = "Retournez voir un maître en {skill:197} : {spell:2402} s'apprend à partir de {skill:197} 80.",
	-- ["Back to a {skill:197} trainer: {spell:3848} is taught from {skill:197} 110."] = "Retournez voir un maître en {skill:197} : {spell:3848} s'apprend à partir de {skill:197} 110.",
	-- ["Back to a {skill:197} trainer: {spell:3852} is taught from {skill:197} 125."] = "Retournez voir un maître en {skill:197} : {spell:3852} s'apprend à partir de {skill:197} 125.",
	-- ["Back to a {skill:197} trainer: {spell:8776} is taught from {skill:197} 50."] = "Retournez voir un maître en {skill:197} : {spell:8776} s'apprend à partir de {skill:197} 50.",
	-- ["Back to a {skill:197} trainer: {spell:8799} is taught from {skill:197} 180."] = "Retournez voir un maître en {skill:197} : {spell:8799} s'apprend à partir de {skill:197} 180.",
	-- ["Expert needs character level 20 and {skill:197} 125; it raises the cap to 225. Materials for 150-225 are worth about 135g in all."] = "Expert nécessite le niveau 20 et {skill:197} 125 ; le plafond passe à 225. Les composants pour 150-225 valent environ 135g au total.",
	-- ["Journeyman needs character level 10 and {skill:197} 50; it raises the cap to 150. Materials for 75-150 are worth about 17g in all."] = "Compagnon nécessite le niveau 10 et {skill:197} 50 ; le plafond passe à 150. Les composants pour 75-150 valent environ 17g au total.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:197} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:197} trainer teaches it: Alliance {npc:1346} ({zone:1453}), {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Zephras Isle), Sellandus ({zone:1453}), {npc:251991} (Zephras Isle) and {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}), {npc:2627} ({zone:1434}), {npc:4576} ({zone:1458}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Zephras Isle), {npc:11049} ({zone:1458}), {npc:251991} (Zephras Isle) and Tepa ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:2964} (from 55, 1s) and {spell:2402} (from 55, 2s 50c). Also learn {spell:1229504} (1s): Forever's {skill:197} camp item, a {spell:2963} and a {item:2320}; each faction has its own. The Camping 101: {skill:197} quest from your starting area's camping guide (after The Great Outdoors) sends you to a tailoring trainer who teaches it free. 75-150 takes about 11s of recipes and 1g 65s 50c of vendor goods, plus 567 {item:2592} and 204 {item:4306} to gather or buy."] = "Compagnon porte le plafond de 75 à 150 pour 5 pa ; il demande {skill:197} 50 et le niveau 10, vous pouvez donc l'apprendre à n'importe quelle visite dès 50. Tous les maîtres de {skill:197} ne l'enseignent pas : Alliance {npc:1346} ({zone:1453}), {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (île de Zéphras), Sellandus ({zone:1453}), {npc:251991} (île de Zéphras) et {npc:11052} ({zone:1445}) ; Horde {npc:2399} ({zone:1424}), {npc:2627} ({zone:1434}), {npc:4576} ({zone:1458}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (île de Zéphras), {npc:11049} ({zone:1458}), {npc:251991} (île de Zéphras) et Tepa ({zone:1456}). La flèche indique le plus proche de votre faction. Apprenez maintenant : {spell:2964} (dès 55, 1 pa) et {spell:2402} (dès 55, 2 pa 50 pc). Apprenez aussi {spell:1229504} (1 pa) : l'objet de camp de Forever pour {skill:197}, un {spell:2963} et une {item:2320} ; chaque faction a le sien. La quête Introduction au camping : {skill:197} du guide de camping de votre zone de départ (après Les grands espaces sauvages) vous envoie à un maître tailleur qui l'enseigne gratuitement. 75-150 demande environ 11 pa de recettes et 1 po 65 pa 50 pc de fournitures de marchand, plus 567 {item:2592} et 204 {item:4306} à récolter ou acheter.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Tuez les monstres qui le laissent tomber au lieu de farm que Polestar choisit selon votre niveau et votre faction. L'hôtel des ventes convient aussi.",
	-- ["On Forever no recipe a trainer teaches or both factions' vendors sell gives {skill:197} points past 295, so Polestar has no route for the last points. Recipes that still do: {item:14342} (needs a Moonwell), {item:14137} (needs a {item:279943}), {item:14155} (recipe is a drop), {item:14128} (recipe is a drop), {item:19047} (needs a {item:279943})."] = "Sur Forever, aucune recette enseignée par un maître ou vendue par les marchands des deux factions ne donne de points de {skill:197} après 295 : Polestar n'a donc pas de trajet pour les derniers points. Recettes qui en donnent encore : {item:14342} (nécessite un Puits de lune), {item:14137} (nécessite un {item:279943}), {item:14155} (recette obtenue sur un monstre), {item:14128} (recette obtenue sur un monstre), {item:19047} (nécessite un {item:279943}).",
	-- ["Orange (a point every craft) until 160, yellow until 175, green until 190."] = "Orange (un point à chaque fabrication) jusqu'à 160, jaune jusqu'à 175, vert jusqu'à 190.",
	-- ["Orange (a point every craft) until 245, yellow until 260, green until 275."] = "Orange (un point à chaque fabrication) jusqu'à 245, jaune jusqu'à 260, vert jusqu'à 275.",
	-- ["Orange (a point every craft) until 265, yellow until 280, green until 295."] = "Orange (un point à chaque fabrication) jusqu'à 265, jaune jusqu'à 280, vert jusqu'à 295.",
	-- ["Orange (a point every craft) until 40, yellow until 50, green until 60."] = "Orange (un point à chaque fabrication) jusqu'à 40, jaune jusqu'à 50, vert jusqu'à 60.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:1815}, {npc:1816}, {npc:1817} (les bêtes de niveau 48-60 en donnent) ; le guide de {skill:393} couvre ce trajet. L'hôtel des ventes convient aussi.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} (les bêtes de niveau 48-60 en donnent) ; le guide de {skill:393} couvre ce trajet. L'hôtel des ventes convient aussi.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Dépecés, désenchantés ou fabriqués par un autre métier : récoltez-les vous-même ou achetez-les à l'hôtel des ventes.",
	-- ["Teaches {item:13863} (needs {skill:197} 230). Vendors sell it in limited stock that restocks."] = "Apprend {item:13863} (nécessite {skill:197} 230). Les marchands la vendent en stock limité qui se renouvelle.",
	-- ["Teaches {item:254123} (needs {skill:197} 250)."] = "Apprend {item:254123} (nécessite {skill:197} 250).",
	-- ["Teaches {item:7053} (needs {skill:197} 140). Vendors sell it in limited stock that restocks."] = "Apprend {item:7053} (nécessite {skill:197} 140). Les marchands la vendent en stock limité qui se renouvelle.",
	-- ["Yellow until 127, green until 145: not every craft gives a point."] = "Jaune jusqu'à 127, vert jusqu'à 145 : chaque fabrication ne donne pas un point.",
	-- ["Yellow until 140, green until 155: not every craft gives a point. {skill:197} 150 is a Legacy System milestone."] = "Jaune jusqu'à 140, vert jusqu'à 155 : chaque fabrication ne donne pas un point. {skill:197} 150 est un palier du système d'Héritage.",
	-- ["Yellow until 190, green until 200: not every craft gives a point."] = "Jaune jusqu'à 190, vert jusqu'à 200 : chaque fabrication ne donne pas un point.",
	-- ["Yellow until 200, green until 215: not every craft gives a point."] = "Jaune jusqu'à 200, vert jusqu'à 215 : chaque fabrication ne donne pas un point.",
	-- ["Yellow until 220, green until 235: not every craft gives a point. {skill:197} 225 is a Legacy System milestone."] = "Jaune jusqu'à 220, vert jusqu'à 235 : chaque fabrication ne donne pas un point. {skill:197} 225 est un palier du système d'Héritage.",
	-- ["Yellow until 240, green until 255: not every craft gives a point."] = "Jaune jusqu'à 240, vert jusqu'à 255 : chaque fabrication ne donne pas un point.",
	-- ["Yellow until 67, green until 85: not every craft gives a point."] = "Jaune jusqu'à 67, vert jusqu'à 85 : chaque fabrication ne donne pas un point.",
	-- ["Yellow until 67, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Jaune jusqu'à 67, vert jusqu'à 85 : chaque fabrication ne donne pas un point. 75 est le plafond d'Apprenti.",
	-- ["Yellow until 97, green until 115: not every craft gives a point."] = "Jaune jusqu'à 97, vert jusqu'à 115 : chaque fabrication ne donne pas un point.",
	-- ["{item:10045} to 50"] = "{item:10045} jusqu'à 50",
	-- ["{item:13856} to 236"] = "{item:13856} jusqu'à 236",
	-- ["{item:13863} to 251"] = "{item:13863} jusqu'à 251",
	-- ["{item:254123} to 295"] = "{item:254123} jusqu'à 295",
	-- ["{item:7026} to 80"] = "{item:7026} jusqu'à 80",
	-- ["{item:7053} to 180"] = "{item:7053} jusqu'à 180",
	-- ["{item:7062} to 185"] = "{item:7062} jusqu'à 185",
	-- ["{item:9998} to 205"] = "{item:9998} jusqu'à 205",
	-- ["{npc:11739} (level 57-59) drop it here. The Auction House works too."] = "Les {npc:11739} (niveau 57-59) le laissent tomber ici. L'hôtel des ventes convient aussi.",
	-- ["{npc:1824} (level 54-55) drop it here. The Auction House works too."] = "Les {npc:1824} (niveau 54-55) le laissent tomber ici. L'hôtel des ventes convient aussi.",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Les {npc:3263} (niveau 19-20) le laissent tomber ici. L'hôtel des ventes convient aussi.",
	-- ["{npc:5472} (level 46-47) drop it here. The Auction House works too."] = "Les {npc:5472} (niveau 46-47) le laissent tomber ici. L'hôtel des ventes convient aussi.",
	-- ["{npc:6006} (level 52-53) drop it here. The Auction House works too."] = "Les {npc:6006} (niveau 52-53) le laissent tomber ici. L'hôtel des ventes convient aussi.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Les {npc:6189} (niveau 51-52) le laissent tomber ici. L'hôtel des ventes convient aussi.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Les {npc:7027} (niveau 56-57) le laissent tomber ici. L'hôtel des ventes convient aussi.",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Les {npc:98} (niveau 17-18) le laissent tomber ici. L'hôtel des ventes convient aussi.",
	-- ["{skill:171}: {item:3383} (or the Auction House)"] = "{skill:171} : {item:3383} (ou l'hôtel des ventes)",
	-- ["{skill:197} materials for 75-150"] = "Composants de {skill:197} pour 75-150",
	-- ["{skill:197} recipes at 110"] = "Recettes de {skill:197} à 110",
	-- ["{skill:197} recipes at 125"] = "Recettes de {skill:197} à 125",
	-- ["{skill:197} recipes at 180"] = "Recettes de {skill:197} à 180",
	-- ["{skill:197} recipes at 185"] = "Recettes de {skill:197} à 185",
	-- ["{skill:197} recipes at 205"] = "Recettes de {skill:197} à 205",
	-- ["{skill:197} recipes at 50"] = "Recettes de {skill:197} à 50",
	-- ["{skill:197} recipes at 80"] = "Recettes de {skill:197} à 80",
	-- ["{skill:197} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 8s in all."] = "{skill:197} se monte en parallèle de la progression. Le système d'Héritage de Forever récompense les métiers d'artisanat aux compétences 150, 225 et 300 (les plafonds Compagnon, Expert et Artisan) : chacun de ces paliers compte. Les composants pour 1-75 valent environ 1g 8s au total.",
	-- ["{spell:2402} to 110"] = "{spell:2402} jusqu'à 110",
	-- ["{spell:3848} to 125"] = "{spell:3848} jusqu'à 125",
	-- ["{spell:3852} to 150"] = "{spell:3852} jusqu'à 150",
}
