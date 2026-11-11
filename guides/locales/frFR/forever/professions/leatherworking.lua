-- French (frFR): the guide forever/professions/leatherworking (forever/professions/leatherworking.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Leatherworking
	-- {skill:165} Leatherworking
	["Learn {skill:165}"] = "Apprendre {skill:165}",
	-- {skill:165} Leatherworking · {npc:1632} Adele Fielder · {zone:1429} Elwynn Forest · {npc:11083} Darianna · {zone:1457} Darnassus · {npc:252376} Emerii Tallgust · {zone:2521} Zephras Isle · {npc:1466} Gretta Finespindle · {zone:1455} Ironforge · {npc:251993} Indari Sunseam · {npc:3605} Nadyia Maneweaver · {zone:1438} Teldrassil · {npc:11096} Randal Worth · {zone:1453} Stormwind City · {npc:3069} Chaw Stronghide · {zone:1412} Mulgore · {npc:223} Dan Golthas · {zone:1458} Undercity · {npc:5811} Kamari · {zone:1454} Orgrimmar · {npc:3008} Mak · {zone:1456} Thunder Bluff · {npc:3549} Shelene Rhobart · {zone:1420} Tirisfal Glades · {skill:393} Skinning · {item:2318} Light Leather · {item:2320} Coarse Thread
	["Apprentice {skill:165} lets you craft up to 75 for 10c, at any character level. Not every {skill:165} trainer teaches it: Alliance {npc:1632} ({zone:1429}), {npc:11083} ({zone:1457}), {npc:252376} ({zone:2521}), {npc:1466} ({zone:1455}), {npc:251993} ({zone:2521}), {npc:3605} ({zone:1438}) and {npc:11096} ({zone:1453}); Horde {npc:3069} ({zone:1412}), {npc:223} ({zone:1458}), {npc:252376} ({zone:2521}), {npc:251993} ({zone:2521}), {npc:5811} ({zone:1454}), {npc:3008} ({zone:1456}) and {npc:3549} ({zone:1420}). The arrow picks the nearest of your faction. Pair it with {skill:393}: {item:2318} comes from the beasts of every starting zone. {item:2320} and Salt are sold by leatherworking and trade supplies vendors. 1-75 takes about 1s 50c of recipes and 5s of vendor goods, plus 349 {item:2318} to gather or buy."] = "",

	-- Step 2: Leatherworking 1-75: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 1-75: vendor goods"] = "{skill:165} 1-75 : fournitures de marchand",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 50 {item:2320} (5s); about 5s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Achetez d'un coup toute la part de cette tranche : 50 {item:2320} (5 pa) ; environ 5 pa au total. La flèche indique le vendeur de votre faction le plus proche ({zone:1453} : {npc:1347}, {npc:1286} et {npc:5565} ; {zone:1454} : {npc:3364}, {npc:3367} et {npc:5817}).",

	-- Step 3: Light Leather (Elwynn Forest)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1922} Gray Forest Wolf · {npc:525} Mangy Wolf · {npc:524} Rockhide Boar · {npc:113} Stonetusk Boar · {npc:822} Young Forest Bear
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:1922}, {npc:525}, Prowler, {npc:524}, {npc:113} and {npc:822} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} pour {spell:2152}, {spell:3756} et {spell:3763} (dont 210 pour 75-150 : récoltez-les tous maintenant) : {skill:393} : bêtes de niveau 5-20 ; ou l'hôtel des ventes. Dépecez {npc:1922}, {npc:525}, Rôdeur, {npc:524}, {npc:113} et {npc:822} ici (niveau 5-20) ; le guide de {skill:393} en donne le parcours.",

	-- Step 4: Light Leather (Dun Morogh)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1125} Crag Boar · {npc:1127} Elder Crag Boar · {npc:1196} Ice Claw Bear · {npc:1199} Juvenile Snow Leopard · {npc:1126} Large Crag Boar · {npc:1689} Scarred Crag Boar · {npc:1201} Snow Leopard · {npc:1138} Snow Tracker Wolf · {npc:1131} Winter Wolf · {npc:1128} Young Black Bear
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131} and {npc:1128} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} pour {spell:2152}, {spell:3756} et {spell:3763} (dont 210 pour 75-150 : récoltez-les tous maintenant) : {skill:393} : bêtes de niveau 5-20 ; ou l'hôtel des ventes. Dépecez {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131} et {npc:1128} ici (niveau 5-20) ; le guide de {skill:393} en donne le parcours.",

	-- Step 5: Light Leather (Teldrassil)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:2033} Elder Nightsaber · {npc:2043} Nightsaber Stalker
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:2033}, Nightsaber and {npc:2043} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} pour {spell:2152}, {spell:3756} et {spell:3763} (dont 210 pour 75-150 : récoltez-les tous maintenant) : {skill:393} : bêtes de niveau 5-20 ; ou l'hôtel des ventes. Dépecez {npc:2033}, Sabre-de-nuit et {npc:2043} ici (niveau 5-20) ; le guide de {skill:393} en donne le parcours.",

	-- Step 6: Light Leather (Zephras Isle)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:250928} Highlands Ursera · {npc:251284} Hippogryph Protector · {npc:251291} Hippogryph Youth · {npc:251707} Ornery Galestrider · {npc:256092} Shadowgale Shriekling · {npc:253282} Shriekling Fledgling · {npc:250874} Vuldren Alpha · {npc:254588} Windsong Crawler
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin Cloudrunner, Galestrider, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Prideclaw, {npc:256092}, {npc:253282}, Vuldren, {npc:250874} and {npc:254588} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} pour {spell:2152}, {spell:3756} et {spell:3763} (dont 210 pour 75-150 : récoltez-les tous maintenant) : {skill:393} : bêtes de niveau 5-20 ; ou l'hôtel des ventes. Dépecez Cloudrunner, Trotteur des trombes, {npc:250928}, {npc:251284}, {npc:251291}, {npc:251707}, Fièregriffe, {npc:256092}, {npc:253282}, Vuldrène, {npc:250874} et {npc:254588} ici (niveau 5-20) ; le guide de {skill:393} en donne le parcours.",

	-- Step 7: Light Leather (Durotar)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:3126} Armored Scorpid · {npc:3123} Bloodtalon Scythemaw · {npc:3122} Bloodtalon Taillasher · {npc:3125} Clattering Scorpid · {npc:3099} Dire Mottled Boar · {npc:3110} Dreadmaw Crocolisk · {npc:3121} Durotar Tiger · {npc:3100} Elder Mottled Boar · {npc:3130} Thunder Lizard · {npc:3127} Venomtail Scorpid
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130} and {npc:3127} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} pour {spell:2152}, {spell:3756} et {spell:3763} (dont 210 pour 75-150 : récoltez-les tous maintenant) : {skill:393} : bêtes de niveau 5-20 ; ou l'hôtel des ventes. Dépecez {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130} et {npc:3127} ici (niveau 5-20) ; le guide de {skill:393} en donne le parcours.",

	-- Step 8: Light Leather (Mulgore)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:2956} Adult Plainstrider · {npc:2957} Elder Plainstrider · {npc:3035} Flatland Cougar · {npc:3566} Flatland Prowler · {npc:2972} Kodo Calf · {npc:2959} Prairie Stalker · {npc:2958} Prairie Wolf · {npc:2960} Prairie Wolf Alpha
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958} and {npc:2960} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} pour {spell:2152}, {spell:3756} et {spell:3763} (dont 210 pour 75-150 : récoltez-les tous maintenant) : {skill:393} : bêtes de niveau 5-20 ; ou l'hôtel des ventes. Dépecez {npc:2956}, {npc:2957}, {npc:3035}, {npc:3566}, {npc:2972}, {npc:2959}, {npc:2958} et {npc:2960} ici (niveau 5-20) ; le guide de {skill:393} en donne le parcours.",

	-- Step 9: Light Leather (Tirisfal Glades)
	-- {item:2318} Light Leather · {spell:2152} Light Armor Kit · {spell:3756} Embossed Leather Gloves · {spell:3763} Fine Leather Belt · {skill:393} Skinning · {npc:1548} Cursed Darkhound · {npc:1547} Decrepit Darkhound · {npc:1553} Greater Duskbat · {npc:1549} Ravenous Darkhound · {npc:1554} Vampiric Duskbat
	["349 {item:2318} for {spell:2152}, {spell:3756} and {spell:3763} (210 of them for 75-150: pick them all now): {skill:393}: beasts of level 5-20; or the Auction House. Skin {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549} and {npc:1554} here (level 5-20); the {skill:393} guide routes this."] = "349 {item:2318} pour {spell:2152}, {spell:3756} et {spell:3763} (dont 210 pour 75-150 : récoltez-les tous maintenant) : {skill:393} : bêtes de niveau 5-20 ; ou l'hôtel des ventes. Dépecez {npc:1548}, {npc:1547}, {npc:1553}, {npc:1549} et {npc:1554} ici (niveau 5-20) ; le guide de {skill:393} en donne le parcours.",

	-- Step 10: Light Armor Kit to 51
	-- {spell:2152} Light Armor Kit
	["{spell:2152} to 51"] = "{spell:2152} jusqu'à 51",
	-- {spell:2152} Light Armor Kit · {item:2318} Light Leather
	["{spell:2152} is orange at 1 (yellow 30, green 45, grey 60): about 64 crafts to 51. Each takes 1 {item:2318}. One {item:2318} a craft; the kits sell to vendors."] = "{spell:2152} est orange à 1 (jaune 30, vert 45, gris 60) : environ 64 fabrications jusqu'à 51. Chaque fabrication demande 1 {item:2318}. Un {item:2318} par fabrication ; les renforts se vendent aux marchands.",

	-- Step 11: Leatherworking recipes at 51
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 51"] = "{skill:165} : recettes à 51",
	-- {skill:165} Leatherworking · {spell:3756} Embossed Leather Gloves · {spell:1229432} Camp Tent · {item:2318} Light Leather
	["Back to a {skill:165} trainer: {spell:3756} (from 40, 1s 50c). Also learn {spell:1229432} (1s): Forever's {skill:165} camp item, 5 {item:2318}, placed at a campsite beside a campfire. The Camping 101: {skill:165} quest from your starting area's camping guide (after The Great Outdoors) sends you to a leatherworking trainer who teaches it free."] = "Retournez voir un maître de métier ({skill:165}) : {spell:3756} (dès 40, 1 pa 50 pc). Apprenez aussi {spell:1229432} (1 pa) : l'objet de camp de Forever pour {skill:165}, 5 {item:2318}, à poser sur un campement près d'un feu de camp. La quête Introduction au camping : {skill:165} du guide de camping de votre zone de départ (après Les grands espaces sauvages) vous envoie à un maître travailleur du cuir qui l'enseigne gratuitement.",

	-- Step 12: Embossed Leather Gloves to 75
	-- {spell:3756} Embossed Leather Gloves
	["{spell:3756} to 75"] = "{spell:3756} jusqu'à 75",
	-- {spell:3756} Embossed Leather Gloves · {item:2318} Light Leather · {item:2320} Coarse Thread
	["{spell:3756} is orange at 51 (yellow 70, green 85, grey 100): about 25 crafts to 75. Each takes 3 {item:2318} and 2 {item:2320}. Forever teaches {spell:3756} from 40."] = "{spell:3756} est orange à 51 (jaune 70, vert 85, gris 100) : environ 25 fabrications jusqu'à 75. Chaque fabrication demande 3 {item:2318} et 2 {item:2320}. Forever enseigne {spell:3756} dès 40.",

	-- Step 13: Journeyman Leatherworking
	-- {skill:165} Leatherworking
	["Journeyman {skill:165}"] = "{skill:165} (Compagnon)",
	-- {skill:165} Leatherworking · {npc:3967} Aayndia Floralwind · {zone:1440} Ashenvale · {npc:252376} Emerii Tallgust · {zone:2521} Zephras Isle · {npc:11081} Faldron · {zone:1457} Darnassus · {npc:5127} Fimble Finespindle · {zone:1455} Ironforge · {npc:5564} Simon Tanner · {zone:1453} Stormwind City · {npc:4588} Arthur Moore · {zone:1458} Undercity · {npc:1385} Brawn · {zone:1434} Stranglethorn Vale · {npc:3365} Karolek · {zone:1454} Orgrimmar · {npc:3703} Krulmoo Fullmoon · {zone:1413} The Barrens · {npc:8153} Narv Hidecrafter · {zone:1443} Desolace · {npc:11084} Tarn · {zone:1456} Thunder Bluff · {spell:3763} Fine Leather Belt · {item:2319} Medium Leather · {item:2457} Elixir of Minor Agility · {item:4234} Heavy Leather
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:165} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:165} trainer teaches it: Alliance {npc:3967} ({zone:1440}), {npc:252376} ({zone:2521}), {npc:11081} ({zone:1457}), {npc:5127} ({zone:1455}) and {npc:5564} ({zone:1453}); Horde {npc:4588} ({zone:1458}), {npc:1385} ({zone:1434}), {npc:252376} ({zone:2521}), {npc:3365} ({zone:1454}), {npc:3703} ({zone:1413}), {npc:8153} ({zone:1443}) and {npc:11084} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:3763} (from 55, 3s). 75-150 takes about 15s 50c of recipes and 57s of vendor goods, plus 144 {item:2319}, 24 {item:2457} and 321 {item:4234} to gather or buy."] = "",

	-- Step 14: Leatherworking 75-150: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 75-150: vendor goods"] = "{skill:165} 75-150 : fournitures de marchand",
	-- {item:2320} Coarse Thread · {item:2321} Fine Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 70 {item:2320} (7s) and 50 {item:2321} (50s); about 57s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Achetez d'un coup toute la part de cette tranche : 70 {item:2320} (7 pa) et 50 {item:2321} (50 pa) ; environ 57 pa au total. La flèche indique le vendeur de votre faction le plus proche ({zone:1453} : {npc:1347}, {npc:1286} et {npc:5565} ; {zone:1454} : {npc:3364}, {npc:3367} et {npc:5817}).",

	-- Step 15: Medium Leather (Hillsbrad Foothills)
	-- {item:2319} Medium Leather · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear
	["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "144 {item:2319} pour {item:7285} : {skill:393} : bêtes de niveau 18-30 ; ou l'hôtel des ventes. Dépecez {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Gueule d'acier, {npc:2384} et {npc:2354} ici (niveau 18-30) ; le guide de {skill:393} en donne le parcours.",

	-- Step 16: Medium Leather (Darkshore)
	-- {item:2319} Medium Leather · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:3823} Ghostpaw Runner · {npc:2071} Moonstalker Matriarch
	["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:3823} and {npc:2071} here (level 18-30); the {skill:393} guide routes this."] = "144 {item:2319} pour {item:7285} : {skill:393} : bêtes de niveau 18-30 ; ou l'hôtel des ventes. Dépecez {npc:3823} et {npc:2071} ici (niveau 18-30) ; le guide de {skill:393} en donne le parcours.",

	-- Step 17: Medium Leather (The Barrens)
	-- {item:2319} Medium Leather · {item:7285} Nimble Leather Gloves · {skill:393} Skinning · {npc:3236} Barrens Kodo
	["144 {item:2319} for {item:7285}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:3236} and Thunderhead here (level 18-30); the {skill:393} guide routes this."] = "144 {item:2319} pour {item:7285} : {skill:393} : bêtes de niveau 18-30 ; ou l'hôtel des ventes. Dépecez {npc:3236} et Thunderhead ici (niveau 18-30) ; le guide de {skill:393} en donne le parcours.",

	-- Step 19: Heavy Leather (Alterac Mountains)
	-- {item:4234} Heavy Leather · {spell:3780} Heavy Armor Kit · {item:5964} Barbaric Shoulders · {item:5966} Guardian Gloves · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2249} Ferocious Yeti · {npc:2251} Giant Yeti · {npc:2407} Hulking Mountain Lion · {npc:2406} Mountain Lion · {npc:2250} Mountain Yeti
	["321 {item:4234} for {spell:3780}, {item:5964} and {item:5966} (191 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40; or the Auction House. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this."] = "",

	-- Step 20: Heavy Leather (Thousand Needles)
	-- {item:4234} Heavy Leather · {spell:3780} Heavy Armor Kit · {item:5964} Barbaric Shoulders · {item:5966} Guardian Gloves · {skill:393} Skinning · {npc:4107} Highperch Wyvern · {npc:4147} Saltstone Basilisk · {npc:4140} Scorpid Reaver · {npc:4139} Scorpid Terror · {npc:4143} Sparkleshell Snapper · {npc:4142} Sparkleshell Tortoise
	["321 {item:4234} for {spell:3780}, {item:5964} and {item:5966} (191 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40; or the Auction House. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this."] = "",

	-- Step 23: Fine Leather Belt to 102
	-- {spell:3763} Fine Leather Belt
	["{spell:3763} to 102"] = "{spell:3763} jusqu'à 102",
	-- {spell:3763} Fine Leather Belt · {item:2318} Light Leather · {item:2320} Coarse Thread
	["{spell:3763} is orange at 75 (yellow 85, green 100, grey 115): about 35 crafts to 102. Each takes 6 {item:2318} and 2 {item:2320}. Forever teaches {spell:3763} from 55."] = "{spell:3763} est orange à 75 (jaune 85, vert 100, gris 115) : environ 35 fabrications jusqu'à 102. Chaque fabrication demande 6 {item:2318} et 2 {item:2320}. Forever enseigne {spell:3763} dès 55.",

	-- Step 24: Leatherworking recipes at 102
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 102"] = "{skill:165} : recettes à 102",
	-- {skill:165} Leatherworking · {spell:9074} Nimble Leather Gloves
	["Back to a {skill:165} trainer: {spell:9074} (from 95, 5s)."] = "Retournez voir un maître de métier ({skill:165}) : {spell:9074} (dès 95, 5 pa).",

	-- Step 25: Nimble Leather Gloves to 125
	-- {item:7285} Nimble Leather Gloves
	["{item:7285} to 125"] = "{item:7285} jusqu'à 125",
	-- {item:7285} Nimble Leather Gloves · {item:2457} Elixir of Minor Agility · {item:2319} Medium Leather · {item:2321} Fine Thread · {item:2452} Swiftthistle · {item:765} Silverleaf · {spell:3763} Fine Leather Belt · {item:2316} Dark Leather Cloak · {item:4340} Gray Dye · {skill:171} Alchemy
	["{item:7285} is orange at 102 (yellow 120, green 132, grey 145): about 24 crafts to 125. Each takes 1 {item:2457}, 6 {item:2319} and 1 {item:2321}. Each takes an {item:2457}: an alchemist makes it from a {item:2452} and a {item:765}, and the Auction House has it cheap. With no elixirs, take {spell:3763} on to 105 and {item:2316} (from 85: 8 {item:2319}, a {item:4340} and a {item:2321}) to 125: about 28 cloaks, 224 {item:2319} in all. {item:2457} (24 for 75-150): {skill:171}: {item:2457}; or the Auction House."] = "{item:7285} est orange à 102 (jaune 120, vert 132, gris 145) : environ 24 fabrications jusqu'à 125. Chaque fabrication demande 1 {item:2457}, 6 {item:2319} et 1 {item:2321}. Chacune demande un {item:2457} : un alchimiste le fabrique avec un {item:2452} et une {item:765}, et l'hôtel des ventes l'a à bas prix. Sans élixirs, poursuivez {spell:3763} jusqu'à 105 et {item:2316} (dès 85 : 8 {item:2319}, une {item:4340} et une {item:2321}) jusqu'à 125 : environ 28 capes, 224 {item:2319} au total. {item:2457} (24 pour 75-150) : {skill:171} : {item:2457} ; ou l'hôtel des ventes.",

	-- Step 26: Leatherworking recipes at 125
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 125"] = "{skill:165} : recettes à 125",
	-- {skill:165} Leatherworking · {spell:3780} Heavy Armor Kit
	["Back to a {skill:165} trainer: {spell:3780} (from 125, 7s 50c)."] = "Retournez voir un maître de métier ({skill:165}) : {spell:3780} (dès 125, 7 pa 50 pc).",

	-- Step 27: Heavy Armor Kit to 150
	-- {spell:3780} Heavy Armor Kit
	["{spell:3780} to 150"] = "{spell:3780} jusqu'à 150",
	-- {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather · {item:2321} Fine Thread · {skill:165} Leatherworking
	["{spell:3780} is orange at 125 (yellow 145, green 155, grey 165): about 26 crafts to 150. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors. {skill:165} 150 is a Legacy System milestone."] = "{spell:3780} est orange à 125 (jaune 145, vert 155, gris 165) : environ 26 fabrications jusqu'à 150. Chaque fabrication demande 5 {item:4234} et 1 {item:2321}. Cinq {item:4234} par fabrication (bêtes de niveau 28-40) ; les renforts se vendent aux marchands. {skill:165} 150 est un palier du système d'Héritage.",

	-- Step 28: Leatherworking 150-225: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 150-225: vendor goods"] = "{skill:165} 150-225 : fournitures de marchand",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 29 {item:2321} (29s), 66 Salt (33s) and 145 {item:4291} (7g 25s); about 7g 87s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "",

	-- Step 29: Heavy Hide (Alliance)
	-- {item:4235} Heavy Hide
	["{item:4235} (Alliance)"] = "{item:4235} (Alliance)",
	-- {item:4235} Heavy Hide · {item:5964} Barbaric Shoulders · {item:5966} Guardian Gloves · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2249} Ferocious Yeti · {npc:2251} Giant Yeti · {npc:2407} Hulking Mountain Lion · {npc:2406} Mountain Lion · {npc:2250} Mountain Yeti
	["22 {item:4235} for {item:5964} and {item:5966}: {skill:393}: beasts of level 28-40; or the Auction House. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this."] = "",

	-- Step 30: Heavy Hide (Horde)
	-- {item:4235} Heavy Hide
	["{item:4235} (Horde)"] = "{item:4235} (Horde)",
	-- {item:4235} Heavy Hide · {item:5964} Barbaric Shoulders · {item:5966} Guardian Gloves · {skill:393} Skinning · {npc:4107} Highperch Wyvern · {npc:4147} Saltstone Basilisk · {npc:4140} Scorpid Reaver · {npc:4139} Scorpid Terror · {npc:4143} Sparkleshell Snapper · {npc:4142} Sparkleshell Tortoise
	["22 {item:4235} for {item:5964} and {item:5966}: {skill:393}: beasts of level 28-40; or the Auction House. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this."] = "",

	-- Step 31: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304} (Alliance)",
	-- {item:4304} Thick Leather · {item:8176} Nightscape Headband · {item:8193} Nightscape Pants · {skill:393} Skinning · {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch
	["373 {item:4304} for {item:8176} and {item:8193}: {skill:393}: beasts of level 38-50; or the Auction House. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "",

	-- Step 32: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304} (Horde)",
	-- {item:4304} Thick Leather · {item:8176} Nightscape Headband · {item:8193} Nightscape Pants · {skill:393} Skinning · {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti
	["373 {item:4304} for {item:8176} and {item:8193}: {skill:393}: beasts of level 38-50; or the Auction House. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "",

	-- Step 33: Expert Leatherworking
	-- {skill:165} Leatherworking
	["Expert {skill:165}"] = "{skill:165} (Expert)",
	-- {skill:165} Leatherworking · {npc:4212} Telonis · {zone:1457} Darnassus · {npc:3007} Una · {zone:1456} Thunder Bluff · {spell:3818} Cured Heavy Hide · {spell:7151} Barbaric Shoulders · {item:4235} Heavy Hide · {item:4304} Thick Leather · {item:5966} Guardian Gloves · {item:8176} Nightscape Headband · {item:8193} Nightscape Pants
	["Expert raises the cap from 150 to 225; it needs {skill:165} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4212} ({zone:1457}); Horde {npc:3007} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:3818} (from 125, 5s) and {spell:7151} (from 150). 150-225 takes about 5s of recipes and 7g 87s of vendor goods, plus 22 {item:4235} and 373 {item:4304} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:5966} (from 165), {item:8176} (from 180) and {item:8193} (from 210), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 4."] = "",

	-- Step 34: Heavy Armor Kit to 158
	-- {spell:3780} Heavy Armor Kit
	["{spell:3780} to 158"] = "",
	-- {spell:3780} Heavy Armor Kit · {item:4234} Heavy Leather · {item:2321} Fine Thread
	["{spell:3780} is yellow at 150 (yellow 145, green 155, grey 165): about 15 crafts to 158. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors."] = "",

	-- Step 35: Barbaric Shoulders to 165
	-- {item:5964} Barbaric Shoulders
	["{item:5964} to 165"] = "",
	-- {item:5964} Barbaric Shoulders · {item:4234} Heavy Leather · {spell:3818} Cured Heavy Hide · {item:2321} Fine Thread
	["{item:5964} is orange at 158 (yellow 170, green 180, grey 190): about 7 crafts to 165, a point every craft. Each takes 8 {item:4234}, 1 {spell:3818} and 2 {item:2321}. Make the 7 {spell:3818} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 36: Leatherworking recipes at 165
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 165"] = "",
	-- {spell:7156} Guardian Gloves
	["Still at the Expert trainer: {spell:7156} (from 165)."] = "",

	-- Step 37: Guardian Gloves to 180
	-- {item:5966} Guardian Gloves
	["{item:5966} to 180"] = "",
	-- {item:5966} Guardian Gloves · {item:4234} Heavy Leather · {spell:3818} Cured Heavy Hide · {item:4291} Silken Thread
	["{item:5966} is orange at 165 (yellow 185, green 195, grey 205): about 15 crafts to 180, a point every craft. Each takes 4 {item:4234}, 1 {spell:3818} and 1 {item:4291}. Make the 15 {spell:3818} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 38: Leatherworking recipes at 180
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 180"] = "",
	-- {spell:10507} Nightscape Headband
	["Still at the Expert trainer: {spell:10507} (from 180)."] = "",

	-- Step 39: Nightscape Headband to 213
	-- {item:8176} Nightscape Headband
	["{item:8176} to 213"] = "",
	-- {item:8176} Nightscape Headband · {item:4304} Thick Leather · {item:4291} Silken Thread
	["{item:8176} is orange at 180 (yellow 200, green 210, grey 220): about 41 crafts to 213. Each takes 5 {item:4304} and 2 {item:4291}. The trainer teaches it, and it is the cheapest way through these points in the data."] = "",

	-- Step 40: Leatherworking recipes at 213
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 213"] = "",
	-- {spell:10548} Nightscape Pants
	["Still at the Expert trainer: {spell:10548} (from 210)."] = "",

	-- Step 41: Nightscape Pants to 225
	-- {item:8193} Nightscape Pants
	["{item:8193} to 225"] = "",
	-- {item:8193} Nightscape Pants · {item:4304} Thick Leather · {item:4291} Silken Thread · {skill:165} Leatherworking
	["{item:8193} is orange at 213 (yellow 225, green 235, grey 245): about 12 crafts to 225, a point every craft. Each takes 14 {item:4304} and 4 {item:4291}. The trainer teaches it, and it is the cheapest way through these points in the data. {skill:165} 225 is a Legacy System milestone."] = "",

	-- Step 42: Artisan Leatherworking
	-- {skill:165} Leatherworking
	["Artisan {skill:165}"] = "{skill:165} (Artisan)",
	-- {skill:165} Leatherworking · {npc:11097} Drakk Stonehand · {zone:1425} The Hinterlands · {npc:11098} Hahrana Ironhide · {zone:1444} Feralas · {spell:19058} Rugged Armor Kit · {item:8170} Rugged Leather · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300; it needs {skill:165} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). The arrow picks the nearest of your faction. Learn now: {spell:19058} (from 225). 225-300 takes about 3g 40s of recipes and 44g 90s of vendor goods, plus 1029 {item:8170} and 430 {item:14047} to gather or buy."] = "",

	-- Step 43: Leatherworking 225-300: vendor goods
	-- {skill:165} Leatherworking
	["{skill:165} 225-300: vendor goods"] = "{skill:165} 225-300 : fournitures de marchand",
	-- {item:2325} Black Dye · {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 39 {item:2325} (3g 90s) and 82 {item:14341} (41g); about 44g 90s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Achetez d'un coup toute la part de cette tranche : 39 {item:2325} (3 po 90 pa) et 82 {item:14341} (41 po) ; environ 44 po 90 pa au total. La flèche indique le vendeur de votre faction le plus proche ({zone:1453} : {npc:1347}, {npc:1286} et {npc:5565} ; {zone:1454} : {npc:3364}, {npc:3367} et {npc:5817}).",

	-- Step 44: Pattern: Wicked Leather Gauntlets
	-- {item:15725} Pattern: Wicked Leather Gauntlets · {item:15083} Wicked Leather Gauntlets · {skill:165} Leatherworking · {npc:12942} Leonard Porter · {zone:1422} Western Plaguelands · {npc:12943} Werg Thickblade
	["{item:15725} teaches {item:15083} ({skill:165} 235) for 1g 20s. Sold by Alliance: {npc:12942} ({zone:1422}), limited stock; Horde: {npc:12943} ({zone:1422}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:15725} enseigne {item:15083} ({skill:165} 235) pour 1 po 20 pa. En vente — Alliance : {npc:12942} ({zone:1422}), stock limité ; Horde : {npc:12943} ({zone:1422}), stock limité. Ses vendeurs en gardent un ou deux en stock, qui reviennent quelque temps après une vente ; il est lié quand on le ramasse, donc l'hôtel des ventes ne l'a jamais.",

	-- Step 45: Pattern: Runic Leather Headband
	-- {item:15756} Pattern: Runic Leather Headband · {item:15094} Runic Leather Headband · {skill:165} Leatherworking · {npc:12941} Jase Farlane · {zone:1423} Eastern Plaguelands
	["{item:15756} teaches {item:15094} ({skill:165} 265) for 2g 20s. Sold by {npc:12941} ({zone:1423}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:15756} enseigne {item:15094} ({skill:165} 265) pour 2 po 20 pa. En vente — {npc:12941} ({zone:1423}), stock limité. Ses vendeurs en gardent un ou deux en stock, qui reviennent quelque temps après une vente ; il est lié quand on le ramasse, donc l'hôtel des ventes ne l'a jamais.",

	-- Step 46: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Alliance)",
	-- {item:8170} Rugged Leather · {item:15564} Rugged Armor Kit · {item:15083} Wicked Leather Gauntlets · {item:15094} Runic Leather Headband · {skill:393} Skinning · {npc:8598} Frenzied Plaguehound · {npc:8596} Plaguehound Runt
	["1029 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:8598}, Plaguehound and {npc:8596} here (level 48-60); the {skill:393} guide routes this."] = "",

	-- Step 47: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horde)",
	-- {item:8170} Rugged Leather · {item:15564} Rugged Armor Kit · {item:15083} Wicked Leather Gauntlets · {item:15094} Runic Leather Headband · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	["1029 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "",

	-- Step 48: Runecloth
	-- {item:14047} Runecloth · {item:15094} Runic Leather Headband
	["430 {item:14047} for {item:15094}: humanoids of level 45-60 drop it. Keep what you loot as you level, take it from your bank, or buy it at the Auction House."] = "",

	-- Step 49: Rugged Armor Kit to 239
	-- {item:15564} Rugged Armor Kit
	["{item:15564} to 239"] = "{item:15564} jusqu'à 239",
	-- {item:15564} Rugged Armor Kit · {item:8170} Rugged Leather · {npc:7866} Peter Galen · {zone:1447} Azshara · {npc:7867} Thorkaf Dragoneye · {zone:1418} Badlands · {item:8204} Tough Scorpid Gloves · {zone:1446} Tanaris · {item:8165} Worn Dragonscale · {npc:7868} Sarah Tanner · {zone:1427} Searing Gorge · {npc:7869} Brumn Winterhoof · {zone:1417} Arathi Highlands · {item:7077} Heart of Fire · {item:7079} Globe of Water · {item:7075} Core of Earth · {item:7081} Breath of Wind · {npc:7870} Caryssia Moonhunter · {zone:1444} Feralas · {npc:7871} Se'Jib · {zone:1434} Stranglethorn Vale · {item:8211} Wild Leather Vest · {npc:7852} Pratt McGrubben · {npc:7854} Jangdor Swiftstrider · {item:279941} Tanning Rack
	-- plural, as words: Tough Scorpid Breastplates = {item:8203} Tough Scorpid Breastplate
	["{item:15564} is yellow at 225 (yellow 225, green 235, grey 245): about 23 crafts to 239. Each takes 5 {item:8170}. Five {item:8170} a craft. Specialisation (optional): at 225 and character level 40. Dragonscale: {npc:7866} ({zone:1447}) or {npc:7867} ({zone:1418}) wants 2 Tough Scorpid Breastplates, 2 {item:8204} (patterns drop from the Wastewander bandits in {zone:1446}) and 10 {item:8165}. Elemental: {npc:7868} ({zone:1427}) or {npc:7869} ({zone:1417}) wants 2 each of {item:7077}, {item:7079}, {item:7075} and {item:7081}. Tribal (from 235): {npc:7870} ({zone:1444}) or {npc:7871} ({zone:1434}) wants a {item:8211} and Helmet, after the Wild Leather quests from {npc:7852} or {npc:7854} in {zone:1444}. On Forever the specialisation patterns need a {item:279941}. You can take only one; none is needed for 300, and the beta never tested them (it stopped at level 30)."] = "",

	-- Step 50: Wicked Leather Gauntlets to 269
	-- {item:15083} Wicked Leather Gauntlets
	["{item:15083} to 269"] = "{item:15083} jusqu'à 269",
	-- {item:15083} Wicked Leather Gauntlets · {item:8170} Rugged Leather · {item:2325} Black Dye · {item:14341} Rune Thread
	["{item:15083} is orange at 239 (yellow 255, green 265, grey 275): about 39 crafts to 269. Each takes 8 {item:8170}, 1 {item:2325} and 1 {item:14341}. Eight {item:8170} a craft; {item:2325} and {item:14341} from leatherworking or tailoring vendors."] = "{item:15083} est orange à 239 (jaune 255, vert 265, gris 275) : environ 39 fabrications jusqu'à 269. Chaque fabrication demande 8 {item:8170}, 1 {item:2325} et 1 {item:14341}. Huit {item:8170} par fabrication ; {item:2325} et {item:14341} chez les marchands de travail du cuir ou de couture.",
	["from the recipe in your bags"] = "avec la recette de vos sacs",

	-- Step 51: Runic Leather Headband to 300
	-- {item:15094} Runic Leather Headband
	["{item:15094} to 300"] = "{item:15094} jusqu'à 300",
	-- {item:15094} Runic Leather Headband · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14341} Rune Thread · {skill:165} Leatherworking
	["{item:15094} is orange at 269 (yellow 285, green 295, grey 305): about 43 crafts to 300. Each takes 14 {item:8170}, 10 {item:14047} and 1 {item:14341}. 14 {item:8170} and 10 {item:14047} a craft: the dearest stretch. {skill:165} 300 is a Legacy System milestone."] = "{item:15094} est orange à 269 (jaune 285, vert 295, gris 305) : environ 43 fabrications jusqu'à 300. Chaque fabrication demande 14 {item:8170}, 10 {item:14047} et 1 {item:14341}. 14 {item:8170} et 10 {item:14047} par fabrication : la portion la plus chère. {skill:165} 300 est un palier du système d'Héritage.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["1009 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:1815}, {npc:1816} and {npc:1817} here (level 48-60); the {skill:393} guide routes this."] = "1009 {item:8170} pour {item:15564}, {item:15083} et {item:15094} : {skill:393} : bêtes de niveau 48-60 ; ou l'hôtel des ventes. Dépecez {npc:1815}, {npc:1816} et {npc:1817} ici (niveau 48-60) ; le guide de {skill:393} en donne le parcours.",
	-- ["1009 {item:8170} for {item:15564}, {item:15083} and {item:15094}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "1009 {item:8170} pour {item:15564}, {item:15083} et {item:15094} : {skill:393} : bêtes de niveau 48-60 ; ou l'hôtel des ventes. Dépecez {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} et {npc:6377} ici (niveau 48-60) ; le guide de {skill:393} en donne le parcours.",
	-- ["257 {item:4304} for {item:8173} and {item:8170}: {skill:393}: beasts of level 38-50; or the Auction House. Skin {npc:2729}, {npc:2730}, {npc:2732} and {npc:2734} here (level 38-50); the {skill:393} guide routes this."] = "257 {item:4304} pour {item:8173} et {item:8170} : {skill:393} : bêtes de niveau 38-50 ; ou l'hôtel des ventes. Dépecez {npc:2729}, {npc:2730}, {npc:2732} et {npc:2734} ici (niveau 38-50) ; le guide de {skill:393} en donne le parcours.",
	-- ["257 {item:4304} for {item:8173} and {item:8170}: {skill:393}: beasts of level 38-50; or the Auction House. Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} and {npc:5296} here (level 38-50); the {skill:393} guide routes this."] = "257 {item:4304} pour {item:8173} et {item:8170} : {skill:393} : bêtes de niveau 38-50 ; ou l'hôtel des ventes. Dépecez {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} et {npc:5296} ici (niveau 38-50) ; le guide de {skill:393} en donne le parcours.",
	-- ["308 {item:4234} for {spell:3780} and {item:4304} (178 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40; or the Auction House. Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} and Snapjaw here (level 28-40); the {skill:393} guide routes this."] = "308 {item:4234} pour {spell:3780} et {item:4304} (dont 178 pour 150-225 : récoltez-les tous maintenant) : {skill:393} : bêtes de niveau 28-40 ; ou l'hôtel des ventes. Dépecez {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250} et Gueule d'acier ici (niveau 28-40) ; le guide de {skill:393} en donne le parcours.",
	-- ["308 {item:4234} for {spell:3780} and {item:4304} (178 of them for 150-225: pick them all now): {skill:393}: beasts of level 28-40; or the Auction House. Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} and {npc:4142} here (level 28-40); the {skill:393} guide routes this."] = "308 {item:4234} pour {spell:3780} et {item:4304} (dont 178 pour 150-225 : récoltez-les tous maintenant) : {skill:393} : bêtes de niveau 28-40 ; ou l'hôtel des ventes. Dépecez {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143} et {npc:4142} ici (niveau 28-40) ; le guide de {skill:393} en donne le parcours.",
	-- ["430 {item:14047} for {item:15094}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:11880} (level 57-59) here."] = "430 {item:14047} pour {item:15094} : les humanoïdes de niveau 45-60 en laissent tomber ; ou l'hôtel des ventes. {npc:11880} (niveau 57-59) en laisse tomber ici.",
	-- ["430 {item:14047} for {item:15094}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:7027} (level 56-57) here."] = "430 {item:14047} pour {item:15094} : les humanoïdes de niveau 45-60 en laissent tomber ; ou l'hôtel des ventes. {npc:7027} (niveau 56-57) en laisse tomber ici.",
	-- ["Apprentice {skill:165}"] = "{skill:165} (Apprenti)",
	-- ["Apprentice {skill:165} lets you craft up to 75 for 10c, at any character level. Any {skill:165} trainer of your faction teaches it; the arrow picks the nearest. Pair it with {skill:393}: {item:2318} comes from the beasts of every starting zone. {item:2320} and Salt are sold by leatherworking and trade supplies vendors. 1-75 takes about 1s 50c of recipes and 5s of vendor goods, plus 349 {item:2318} to gather or buy."] = "{skill:165} (Apprenti) vous permet de fabriquer jusqu'à 75 pour 10 pc, à tout niveau de personnage. Tout maître de {skill:165} de votre faction l'enseigne ; la flèche indique le plus proche. Associez-le à {skill:393} : le {item:2318} vient des bêtes de chaque zone de départ. La {item:2320} et le sel sont vendus par les marchands de travail du cuir et de fournitures. 1-75 demande environ 1 pa 50 pc de recettes et 5 pa de fournitures de marchand, plus 349 {item:2318} à récolter ou acheter.",
	-- ["Artisan needs character level 35 and {skill:165} 200; it raises the cap to 300. Materials for 225-300 are worth about 312g in all."] = "Le rang Artisan demande le niveau 35 et {skill:165} 200 ; il porte le maximum à 300. Les matériaux pour 225-300 valent environ 312 po au total.",
	-- ["Artisan raises the cap from 225 to 300; it needs {skill:165} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). The arrow picks the nearest of your faction. Learn now: {spell:19058} (from 205). 225-300 takes about 3g 40s of recipes and 44g 90s of vendor goods, plus 1009 {item:8170} and 430 {item:14047} to gather or buy."] = "Artisan porte le plafond de 225 à 300 ; il demande {skill:165} 200 et le niveau 35, vous pouvez donc l'apprendre à n'importe quelle visite dès 200. Seuls quelques maîtres l'enseignent : Alliance {npc:11097} ({zone:1425}) ; Horde {npc:11098} ({zone:1444}). La flèche indique le plus proche de votre faction. Apprenez maintenant : {spell:19058} (dès 205). 225-300 demande environ 3 po 40 pa de recettes et 44 po 90 pa de fournitures de marchand, plus 1009 {item:8170} et 430 {item:14047} à récolter ou acheter.",
	-- ["Back to a {skill:165} trainer: {spell:10482}, {spell:14932} are taught from {skill:165} 220."] = "Retournez voir un maître de {skill:165} : {spell:10482}, {spell:14932} s'apprendnent dès {skill:165} 220.",
	-- ["Back to a {skill:165} trainer: {spell:10487} is taught from {skill:165} 195."] = "Retournez voir un maître de {skill:165} : {spell:10487} s'apprend dès {skill:165} 195.",
	-- ["Back to a {skill:165} trainer: {spell:3763} is taught from {skill:165} 85."] = "Retournez voir un maître de {skill:165} : {spell:3763} s'apprend dès {skill:165} 85.",
	-- ["Back to a {skill:165} trainer: {spell:3776} is taught from {skill:165} 175."] = "Retournez voir un maître de {skill:165} : {spell:3776} s'apprend dès {skill:165} 175.",
	-- ["Back to a {skill:165} trainer: {spell:3817}, {spell:3768} are taught from {skill:165} 130."] = "Retournez voir un maître de {skill:165} : {spell:3817}, {spell:3768} s'apprendnent dès {skill:165} 130.",
	-- ["Back to a {skill:165} trainer: {spell:7151} is taught from {skill:165} 170."] = "Retournez voir un maître de {skill:165} : {spell:7151} s'apprend dès {skill:165} 170.",
	-- ["Back to a {skill:165} trainer: {spell:7156} is taught from {skill:165} 185."] = "Retournez voir un maître de {skill:165} : {spell:7156} s'apprend dès {skill:165} 185.",
	-- ["Back to a {skill:165} trainer: {spell:9062} is taught from {skill:165} 55."] = "Retournez voir un maître de {skill:165} : {spell:9062} s'apprend dès {skill:165} 55.",
	-- ["Back to a {skill:165} trainer: {spell:9068} is taught from {skill:165} 100."] = "Retournez voir un maître de {skill:165} : {spell:9068} s'apprend dès {skill:165} 100.",
	-- ["Back to a {skill:165} trainer: {spell:9074} is taught from {skill:165} 120."] = "Retournez voir un maître de {skill:165} : {spell:9074} s'apprend dès {skill:165} 120.",
	-- ["Buy the whole bracket's share in one go: 8 {item:2321} (8s) and 32 {item:4291} (1g 60s); about 1g 68s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "Achetez d'un coup toute la part de cette tranche : 8 {item:2321} (8 pa) et 32 {item:4291} (1 po 60 pa) ; environ 1 po 68 pa au total. La flèche indique le vendeur de votre faction le plus proche ({zone:1453} : {npc:1347}, {npc:1286} et {npc:5565} ; {zone:1454} : {npc:3364}, {npc:3367} et {npc:5817}).",
	-- ["Expert needs character level 20 and {skill:165} 125; it raises the cap to 225. Materials for 150-225 are worth about 61g in all."] = "Le rang Expert demande le niveau 20 et {skill:165} 125 ; il porte le maximum à 225. Les matériaux pour 150-225 valent environ 61 po au total.",
	-- ["Expert raises the cap from 150 to 225; it needs {skill:165} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:11097} ({zone:1425}) and {npc:4212} ({zone:1457}); Horde {npc:11098} ({zone:1444}) and {npc:3007} ({zone:1456}). The arrow picks the nearest of your faction. 150-225 takes about 1g 68s of vendor goods, plus 257 {item:4304} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:4304} (from 155) and {item:8173} (from 175), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3. {item:8170} (from 205) takes a second trip, to other trainers (below)."] = "Expert porte le plafond de 150 à 225 ; il demande {skill:165} 125 et le niveau 20, vous pouvez donc l'apprendre à n'importe quelle visite dès 125. Seuls quelques maîtres l'enseignent : Alliance {npc:11097} ({zone:1425}) et {npc:4212} ({zone:1457}) ; Horde {npc:11098} ({zone:1444}) et {npc:3007} ({zone:1456}). La flèche indique le plus proche de votre faction. 150-225 demande environ 1 po 68 pa de fournitures de marchand, plus 257 {item:4304} à récolter ou acheter. Venez avec tout cela dans vos sacs (les étapes ci-dessus, le reste à l'hôtel des ventes) : ces maîtres enseignent aussi {item:4304} (dès 155) et {item:8173} (dès 175), et les fabrications ne demandent aucun atelier, alors fabriquez sur place et apprenez chaque recette dès que vous atteignez sa compétence. Un seul trajet au lieu de 3. {item:8170} (dès 205) demande un second trajet, vers d'autres maîtres (ci-dessous).",
	-- ["Journeyman needs character level 10 and {skill:165} 50; it raises the cap to 150. Materials for 75-150 are worth about 11g in all."] = "Le rang Compagnon demande le niveau 10 et {skill:165} 50 ; il porte le maximum à 150. Les matériaux pour 75-150 valent environ 11 po au total.",
	-- ["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:165} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:165} trainer teaches it: Alliance {npc:3967} ({zone:1440}), {npc:11097} ({zone:1425}), {npc:252376} ({zone:2521}), Faldron ({zone:1457}), {npc:5127} ({zone:1455}), {npc:5564} ({zone:1453}) and {npc:4212} ({zone:1457}); Horde {npc:4588} ({zone:1458}), {npc:1385} ({zone:1434}), {npc:252376} ({zone:2521}), {npc:11098} ({zone:1444}), {npc:3365} ({zone:1454}), {npc:3703} ({zone:1413}), {npc:8153} ({zone:1443}), Tarn ({zone:1456}) and {npc:3007} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:3763} (from 55, 3s). 75-150 takes about 15s 50c of recipes and 57s of vendor goods, plus 144 {item:2319}, 24 {item:2457} and 308 {item:4234} to gather or buy."] = "Compagnon porte le plafond de 75 à 150 pour 5 pa ; il demande {skill:165} 50 et le niveau 10, vous pouvez donc l'apprendre à n'importe quelle visite dès 50. Tous les maîtres de {skill:165} ne l'enseignent pas : Alliance {npc:3967} ({zone:1440}), {npc:11097} ({zone:1425}), {npc:252376} ({zone:2521}), Faldron ({zone:1457}), {npc:5127} ({zone:1455}), {npc:5564} ({zone:1453}) et {npc:4212} ({zone:1457}) ; Horde {npc:4588} ({zone:1458}), {npc:1385} ({zone:1434}), {npc:252376} ({zone:2521}), {npc:11098} ({zone:1444}), {npc:3365} ({zone:1454}), {npc:3703} ({zone:1413}), {npc:8153} ({zone:1443}), Tarn ({zone:1456}) et {npc:3007} ({zone:1456}). La flèche indique le plus proche de votre faction. Apprenez maintenant : {spell:3763} (dès 55, 3 pa). 75-150 demande environ 15 pa 50 pc de recettes et 57 pa de fournitures de marchand, plus 144 {item:2319}, 24 {item:2457} et 308 {item:4234} à récolter ou acheter.",
	-- ["Orange (a point every craft) until 155, yellow until 165, green until 175."] = "Orange (un point à chaque fabrication) jusqu'à 155, jaune jusqu'à 165, vert jusqu'à 175.",
	-- ["Orange (a point every craft) until 205, yellow until 215, green until 225."] = "Orange (un point à chaque fabrication) jusqu'à 205, jaune jusqu'à 215, vert jusqu'à 225.",
	-- ["Orange (a point every craft) until 255, yellow until 265, green until 275."] = "Orange (un point à chaque fabrication) jusqu'à 255, jaune jusqu'à 265, vert jusqu'à 275.",
	-- ["Orange (a point every craft) until 285, yellow until 295, green until 305. {skill:165} 300 is a Legacy System milestone."] = "Orange (un point à chaque fabrication) jusqu'à 285, jaune jusqu'à 295, vert jusqu'à 305. {skill:165} 300 est un palier du système d'héritage.",
	-- ["Orange (a point every craft) until 30, yellow until 45, green until 60."] = "Orange (un point à chaque fabrication) jusqu'à 30, jaune jusqu'à 45, vert jusqu'à 60.",
	-- ["Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} (les bêtes de niveau 5-20 en donnent) ; le guide de {skill:393} vous y mène. L'hôtel des ventes convient aussi.",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:1815}, {npc:1816}, {npc:1817} (les bêtes de niveau 48-60 en donnent) ; le guide de {skill:393} vous y mène. L'hôtel des ventes convient aussi.",
	-- ["Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Snapjaw here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Gueule d'acier (les bêtes de niveau 28-40 en donnent) ; le guide de {skill:393} vous y mène. L'hôtel des ventes convient aussi.",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Gueule d'acier, {npc:2384}, {npc:2354} (les bêtes de niveau 18-30 en donnent) ; le guide de {skill:393} vous y mène. L'hôtel des ventes convient aussi.",
	-- ["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} (les bêtes de niveau 38-50 en donnent) ; le guide de {skill:393} vous y mène. L'hôtel des ventes convient aussi.",
	-- ["Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} (les bêtes de niveau 5-20 en donnent) ; le guide de {skill:393} vous y mène. L'hôtel des ventes convient aussi.",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} (les bêtes de niveau 18-30 en donnent) ; le guide de {skill:393} vous y mène. L'hôtel des ventes convient aussi.",
	-- ["Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} (les bêtes de niveau 28-40 en donnent) ; le guide de {skill:393} vous y mène. L'hôtel des ventes convient aussi.",
	-- ["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} (les bêtes de niveau 38-50 en donnent) ; le guide de {skill:393} vous y mène. L'hôtel des ventes convient aussi.",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} (les bêtes de niveau 48-60 en donnent) ; le guide de {skill:393} vous y mène. L'hôtel des ventes convient aussi.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Obtenus par dépeçage, désenchantement ou fabriqués par un autre métier : récoltez-les vous-même ou achetez-les à l'hôtel des ventes.",
	-- ["Still at the Expert trainer: {spell:10487} (from 175)."] = "Toujours chez le maître Expert : {spell:10487} (dès 175).",
	-- ["Still at the Expert trainer: {spell:20650} (from 155)."] = "Toujours chez le maître Expert : {spell:20650} (dès 155).",
	-- ["Teaches {item:15083} (needs {skill:165} 235). Vendors sell it in limited stock that restocks."] = "Apprend {item:15083} (nécessite {skill:165} 235). Les marchands le vendent en stock limité qui se renouvelle.",
	-- ["Teaches {item:15094} (needs {skill:165} 265). Vendors sell it in limited stock that restocks."] = "Apprend {item:15094} (nécessite {skill:165} 265). Les marchands le vendent en stock limité qui se renouvelle.",
	-- ["Teaches {item:252452} (needs {skill:165} 135)."] = "Apprend {item:252452} (nécessite {skill:165} 135).",
	-- ["Teaches {item:252463} (needs {skill:165} 185)."] = "Apprend {item:252463} (nécessite {skill:165} 185).",
	-- ["Yellow until 100, green until 115: not every craft gives a point."] = "Jaune jusqu'à 100, vert jusqu'à 115 : toutes les fabrications ne donnent pas de point.",
	-- ["Yellow until 115, green until 130: not every craft gives a point."] = "Jaune jusqu'à 115, vert jusqu'à 130 : toutes les fabrications ne donnent pas de point.",
	-- ["Yellow until 132, green until 145: not every craft gives a point."] = "Jaune jusqu'à 132, vert jusqu'à 145 : toutes les fabrications ne donnent pas de point.",
	-- ["Yellow until 142, green until 155: not every craft gives a point. {skill:165} 150 is a Legacy System milestone."] = "Jaune jusqu'à 142, vert jusqu'à 155 : toutes les fabrications ne donnent pas de point. {skill:165} 150 est un palier du système d'héritage.",
	-- ["Yellow until 180, green until 190: not every craft gives a point."] = "Jaune jusqu'à 180, vert jusqu'à 190 : toutes les fabrications ne donnent pas de point.",
	-- ["Yellow until 185, green until 195: not every craft gives a point."] = "Jaune jusqu'à 185, vert jusqu'à 195 : toutes les fabrications ne donnent pas de point.",
	-- ["Yellow until 195, green until 205: not every craft gives a point."] = "Jaune jusqu'à 195, vert jusqu'à 205 : toutes les fabrications ne donnent pas de point.",
	-- ["Yellow until 230, green until 240: not every craft gives a point. {skill:165} 225 is a Legacy System milestone."] = "Jaune jusqu'à 230, vert jusqu'à 240 : toutes les fabrications ne donnent pas de point. {skill:165} 225 est un palier du système d'héritage.",
	-- ["Yellow until 235, green until 245: not every craft gives a point."] = "Jaune jusqu'à 235, vert jusqu'à 245 : toutes les fabrications ne donnent pas de point.",
	-- ["Yellow until 70, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Jaune jusqu'à 70, vert jusqu'à 85 : toutes les fabrications ne donnent pas de point. 75 est le maximum du rang Apprenti.",
	-- ["Yellow until 85, green until 100: not every craft gives a point."] = "Jaune jusqu'à 85, vert jusqu'à 100 : toutes les fabrications ne donnent pas de point.",
	-- ["{item:14047} (Alliance)"] = "{item:14047} (Alliance)",
	-- ["{item:14047} (Horde)"] = "{item:14047} (Horde)",
	-- ["{item:15083} to 267"] = "{item:15083} jusqu'à 267",
	-- ["{item:15564} is yellow at 225 (yellow 225, green 235, grey 245): about 23 crafts to 239. Each takes 5 {item:8170}. Use the 20 {item:8170} you made earlier; the counts above leave them out. Five {item:8170} a craft. Specialisation (optional): at 225 and character level 40. Dragonscale: {npc:7866} ({zone:1447}) or {npc:7867} ({zone:1418}) wants 2 Tough Scorpid Breastplates, 2 {item:8204} (patterns drop from the Wastewander bandits in {zone:1446}) and 10 {item:8165}. Elemental: {npc:7868} ({zone:1427}) or {npc:7869} ({zone:1417}) wants 2 each of {item:7077}, {item:7079}, {item:7075} and {item:7081}. Tribal (from 235): {npc:7870} ({zone:1444}) or {npc:7871} ({zone:1434}) wants a {item:8211} and Helmet, after the Wild Leather quests from {npc:7852} or {npc:7854} in {zone:1444}. On Forever the specialisation patterns need a {item:279941}. You can take only one; none is needed for 300, and the beta never tested them (it stopped at level 30)."] = "{item:15564} est jaune à 225 (jaune 225, vert 235, gris 245) : environ 23 fabrications jusqu'à 239. Chaque fabrication demande 5 {item:8170}. Utilisez les 20 {item:8170} fabriqués plus tôt ; les quantités ci-dessus ne les comptent pas. Cinq {item:8170} par fabrication. Spécialisation (facultative) : à 225 et au niveau 40. Écailles de dragon : {npc:7866} ({zone:1447}) ou {npc:7867} ({zone:1418}) demande 2 Cuirasses armées du scorpide, 2 {item:8204} (les patrons tombent sur les bandits Bat-le-désert de {zone:1446}) et 10 {item:8165}. Élémentaire : {npc:7868} ({zone:1427}) ou {npc:7869} ({zone:1417}) demande 2 de chacun : {item:7077}, {item:7079}, {item:7075} et {item:7081}. Tribal (dès 235) : {npc:7870} ({zone:1444}) ou {npc:7871} ({zone:1434}) demande un {item:8211} et un casque, après les quêtes du Cuir sauvage de {npc:7852} ou {npc:7854} à {zone:1444}. Sur Forever, les patrons de spécialisation demandent un {item:279941}. Vous ne pouvez en prendre qu'une ; aucune n'est nécessaire pour 300, et la bêta ne les a jamais testées (elle s'est arrêtée au niveau 30).",
	-- ["{item:15564} to 236"] = "{item:15564} jusqu'à 236",
	-- ["{item:2318} (Alliance)"] = "{item:2318} (Alliance)",
	-- ["{item:2318} (Horde)"] = "{item:2318} (Horde)",
	-- ["{item:2319} (Alliance)"] = "{item:2319} (Alliance)",
	-- ["{item:2319} (Horde)"] = "{item:2319} (Horde)",
	-- ["{item:252452} to 170"] = "{item:252452} jusqu'à 170",
	-- ["{item:252463} to 220"] = "{item:252463} jusqu'à 220",
	-- ["{item:4232} (Alliance)"] = "{item:4232} (Alliance)",
	-- ["{item:4232} (Horde)"] = "{item:4232} (Horde)",
	-- ["{item:4234} (Alliance)"] = "{item:4234} (Alliance)",
	-- ["{item:4234} (Horde)"] = "{item:4234} (Horde)",
	-- ["{item:4235} (Alliance)"] = "{item:4235} (Alliance)",
	-- ["{item:4235} (Horde)"] = "{item:4235} (Horde)",
	-- ["{item:4304} is orange at 155 (yellow 175, green 177, grey 180): about 23 crafts to 177. Each takes 6 {item:4234}. Six {item:4234} make one {item:4304}, orange until 175: keep them, the Thick Armor Kits next use them."] = "{item:4304} est orange à 155 (jaune 175, vert 177, gris 180) : environ 23 fabrications jusqu'à 177. Chaque fabrication demande 6 {item:4234}. Six {item:4234} donnent un {item:4304}, orange jusqu'à 175 : gardez-les, les Renforts d'armure épais suivants les utilisent.",
	-- ["{item:4304} to 177"] = "{item:4304} jusqu'à 177",
	-- ["{item:5964} to 175"] = "{item:5964} jusqu'à 175",
	-- ["{item:5966} to 195"] = "{item:5966} jusqu'à 195",
	-- ["{item:7279} to 75"] = "{item:7279} jusqu'à 75",
	-- ["{item:7282} to 120"] = "{item:7282} jusqu'à 120",
	-- ["{item:7285} to 130"] = "{item:7285} jusqu'à 130",
	-- ["{item:783} (Alliance)"] = "{item:783} (Alliance)",
	-- ["{item:783} (Horde)"] = "{item:783} (Horde)",
	-- ["{item:8150} (Alliance)"] = "{item:8150} (Alliance)",
	-- ["{item:8150} (Horde)"] = "{item:8150} (Horde)",
	-- ["{item:8169} (Alliance)"] = "{item:8169} (Alliance)",
	-- ["{item:8169} (Horde)"] = "{item:8169} (Horde)",
	-- ["{item:8170} is orange at 205 (yellow 225, green 225, grey 225): about 20 crafts to 225, a point every craft. Each takes 6 {item:4304}. {item:8170} from {item:4304}: the points come cheap and you need the {item:8170} next. {skill:165} 225 is a Legacy System milestone."] = "{item:8170} est orange à 205 (jaune 225, vert 225, gris 225) : environ 20 fabrications jusqu'à 225, un point à chaque fabrication. Chaque fabrication demande 6 {item:4304}. {item:8170} à partir de {item:4304} : les points sont bon marché et il vous faut le {item:8170} ensuite. {skill:165} 225 est un palier du système d'Héritage.",
	-- ["{item:8170} to 225"] = "{item:8170} jusqu'à 225",
	-- ["{item:8173} is orange at 177 (yellow 195, green 205, grey 215): about 32 crafts to 205. Each takes 5 {item:4304} and 1 {item:4291}. Use the 23 {item:4304} you made earlier; the counts above leave them out. Five {item:4304} a craft; the kits sell to vendors."] = "{item:8173} est orange à 177 (jaune 195, vert 205, gris 215) : environ 32 fabrications jusqu'à 205. Chaque fabrication demande 5 {item:4304} et 1 {item:4291}. Utilisez les 23 {item:4304} fabriqués plus tôt ; les quantités ci-dessus ne les comptent pas. Cinq {item:4304} par fabrication ; les renforts se vendent aux marchands.",
	-- ["{item:8173} to 205"] = "{item:8173} jusqu'à 205",
	-- ["{item:8218} to 225"] = "{item:8218} jusqu'à 225",
	-- ["{npc:11746} (level 56-58) drop it here. The Auction House works too."] = "Lâché ici par {npc:11746} (niveau 56-58). L'hôtel des ventes convient aussi.",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Lâché ici par {npc:6189} (niveau 51-52). L'hôtel des ventes convient aussi.",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Lâché ici par {npc:7027} (niveau 56-57). L'hôtel des ventes convient aussi.",
	-- ["{npc:92} (level 39-40) drop it here. The Auction House works too."] = "Lâché ici par {npc:92} (niveau 39-40). L'hôtel des ventes convient aussi.",
	-- ["{skill:165} materials for 150-225"] = "Matériaux de {skill:165} pour 150-225",
	-- ["{skill:165} materials for 75-150"] = "Matériaux de {skill:165} pour 75-150",
	-- ["{skill:165} recipes at 105"] = "Recettes de {skill:165} à 105",
	-- ["{skill:165} recipes at 120"] = "Recettes de {skill:165} à 120",
	-- ["{skill:165} recipes at 130"] = "Recettes de {skill:165} à 130",
	-- ["{skill:165} recipes at 155"] = "{skill:165} : recettes à 155",
	-- ["{skill:165} recipes at 170"] = "Recettes de {skill:165} à 170",
	-- ["{skill:165} recipes at 175"] = "Recettes de {skill:165} à 175",
	-- ["{skill:165} recipes at 177"] = "{skill:165} : recettes à 177",
	-- ["{skill:165} recipes at 185"] = "Recettes de {skill:165} à 185",
	-- ["{skill:165} recipes at 195"] = "Recettes de {skill:165} à 195",
	-- ["{skill:165} recipes at 205"] = "{skill:165} : recettes à 205",
	-- ["{skill:165} recipes at 220"] = "Recettes de {skill:165} à 220",
	-- ["{skill:165} recipes at 55"] = "Recettes de {skill:165} à 55",
	-- ["{skill:165} recipes at 85"] = "Recettes de {skill:165} à 85",
	-- ["{skill:165} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 18s in all."] = "Le métier {skill:165} se monte en parallèle de la progression. Le système d'héritage de Forever récompense les métiers de fabrication aux compétences 150, 225 et 300 (les maximums Compagnon, Expert et Artisan) : chacun de ces paliers compte. Les matériaux pour 1-75 valent environ 1 po 18 pa au total.",
	-- ["{skill:171}: {item:2457} (or the Auction House)"] = "{skill:171} : {item:2457} (ou l'hôtel des ventes)",
	-- ["{skill:171}: {item:3389} (or the Auction House)"] = "{skill:171} : {item:3389} (ou l'hôtel des ventes)",
	-- ["{skill:171}: {spell:3188} (or the Auction House)"] = "{skill:171} : {spell:3188} (ou l'hôtel des ventes)",
	-- ["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333} : désenchantez de l'équipement inhabituel (vert) (ou l'hôtel des ventes)",
	-- ["{spell:2152} to 55"] = "{spell:2152} jusqu'à 55",
	-- ["{spell:22331} (from 205) is taught only by the Artisan trainers: Alliance {npc:11097} ({zone:1425}); Horde {npc:11098} ({zone:1444}). You can train Artisan there now if you are level 35 (it needs {skill:165} 200), which saves the trip at 225."] = "{spell:22331} (dès 205) n'est enseigné que par les maîtres Artisan : Alliance {npc:11097} ({zone:1425}) ; Horde {npc:11098} ({zone:1444}). Vous pouvez y apprendre Artisan dès maintenant si vous êtes niveau 35 (il demande {skill:165} 200), ce qui vous évite le trajet à 225.",
	-- ["{spell:3756} to 85"] = "{spell:3756} jusqu'à 85",
	-- ["{spell:3763} to 105"] = "{spell:3763} jusqu'à 105",
	-- ["{spell:3768} to 150"] = "{spell:3768} jusqu'à 150",
	-- ["{spell:3776} to 185"] = "{spell:3776} jusqu'à 185",
	-- ["{spell:3780} is yellow at 150 (yellow 145, green 155, grey 165): about 8 crafts to 155. Each takes 5 {item:4234} and 1 {item:2321}. Five {item:4234} a craft (beasts of level 28-40); the kits sell to vendors."] = "{spell:3780} est jaune à 150 (jaune 145, vert 155, gris 165) : environ 8 fabrications jusqu'à 155. Chaque fabrication demande 5 {item:4234} et 1 {item:2321}. Cinq {item:4234} par fabrication (bêtes de niveau 28-40) ; les renforts se vendent aux marchands.",
	-- ["{spell:3780} to 155"] = "{spell:3780} jusqu'à 155",
}
