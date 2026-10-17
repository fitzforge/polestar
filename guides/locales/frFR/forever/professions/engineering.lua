-- French (frFR): the guide forever/professions/engineering (forever/professions/engineering.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Engineering
	-- {skill:202} Engineering
	["Apprentice {skill:202}"] = "{skill:202} (apprenti)",
	-- {skill:202} Engineering
	["{skill:202} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 62s in all."] = "{skill:202} se monte en parallèle de la progression. Le système d'Héritage de Forever récompense les métiers d'artisanat aux compétences 150, 225 et 300 (les plafonds Compagnon, Expert et Artisan) : chacun de ces paliers compte. Les composants pour 1-75 valent environ 62s au total.",
	-- {item:5956} Blacksmith Hammer
	["{item:5956}: a tool, keep it in your bags"] = "{item:5956} : un outil, gardez-le dans vos sacs",

	-- Step 2: Linen Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Tuez les monstres qui le laissent tomber au lieu de farm que Polestar choisit selon votre niveau et votre faction. L'hôtel des ventes convient aussi.",

	-- Step 3: Rough Stone (Alliance)
	-- {item:2835} Rough Stone
	["{item:2835} (Alliance)"] = "{item:2835} (Alliance)",
	-- {item:2835} Rough Stone · {object:1731} Copper Vein · {skill:186} Mining
	["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} provient des gisements de {object:1731} ({skill:186}) ; c'est le groupe le plus dense des données. L'hôtel des ventes convient aussi.",

	-- Step 4: Rough Stone (Horde)
	-- {item:2835} Rough Stone
	["{item:2835} (Horde)"] = "{item:2835} (Horde)",

	-- Step 5: Engineering materials for 1-75
	-- {skill:202} Engineering
	["{skill:202} materials for 1-75"] = "Composants de {skill:202} pour 1-75",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Dépecés, désenchantés ou fabriqués par un autre métier : récoltez-les vous-même ou achetez-les à l'hôtel des ventes.",
	-- {skill:186} Mining · {item:2770} Copper Ore
	["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186} : fondez {item:2770} (ou l'hôtel des ventes)",

	-- Step 6: Rough Blasting Powder to 37
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 37"] = "{spell:3918} jusqu'à 37",
	["Orange (a point every craft) until 20, yellow until 30, green until 40."] = "Orange (un point à chaque fabrication) jusqu'à 20, jaune jusqu'à 30, vert jusqu'à 40.",

	-- Step 7: Crafted Light Shot to 45
	-- {spell:3920} Crafted Light Shot
	["{spell:3920} to 45"] = "{spell:3920} jusqu'à 45",
	["Yellow until 45, green until 60: not every craft gives a point."] = "Jaune jusqu'à 45, vert jusqu'à 60 : chaque fabrication ne donne pas un point.",

	-- Step 8: Engineering recipes at 45
	-- {skill:202} Engineering
	["{skill:202} recipes at 45"] = "Recettes de {skill:202} à 45",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts
	["Back to an {skill:202} trainer: {spell:3922} is taught from {skill:202} 45."] = "Retournez voir un maître en {skill:202} : {spell:3922} s'apprend à partir de {skill:202} 45.",

	-- Step 9: Handful of Copper Bolts to 60
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 60"] = "{spell:3922} jusqu'à 60",
	["Yellow until 52, green until 60: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 52, vert jusqu'à 60 : chaque fabrication ne donne pas un point. Nécessite une enclume à proximité.",

	-- Step 10: Engineering recipes at 60
	-- {skill:202} Engineering
	["{skill:202} recipes at 60"] = "Recettes de {skill:202} à 60",
	-- {skill:202} Engineering · {spell:3923} Rough Copper Bomb
	["Back to an {skill:202} trainer: {spell:3923} is taught from {skill:202} 60."] = "Retournez voir un maître en {skill:202} : {spell:3923} s'apprend à partir de {skill:202} 60.",

	-- Step 11: Rough Copper Bomb to 75
	-- {spell:3923} Rough Copper Bomb
	["{spell:3923} to 75"] = "{spell:3923} jusqu'à 75",
	["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby. 75 is the Apprentice cap."] = "Jaune jusqu'à 75, vert jusqu'à 90 : chaque fabrication ne donne pas un point. Nécessite une enclume à proximité. 75 est le plafond d'Apprenti.",

	-- Step 12: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "{skill:202} (compagnon)",
	-- {skill:202} Engineering
	["Journeyman needs character level 10 and {skill:202} 50; it raises the cap to 150. Materials for 75-150 are worth about 3g 23s in all."] = "Compagnon nécessite le niveau 10 et {skill:202} 50 ; le plafond passe à 150. Les composants pour 75-150 valent environ 3g 23s au total.",

	-- Step 14: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (Alliance)",
	-- {npc:98} Riverpaw Taskmaster
	["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Les {npc:98} (niveau 17-18) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 15: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (Horde)",
	-- {npc:3263} Bristleback Geomancer
	["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Les {npc:3263} (niveau 19-20) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 18: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (Alliance)",
	-- {item:2836} Coarse Stone · {object:1732} Tin Vein · {skill:186} Mining
	["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} provient des gisements de {object:1732} ({skill:186}) ; c'est le groupe le plus dense des données. L'hôtel des ventes convient aussi.",

	-- Step 19: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (Horde)",

	-- Step 20: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (Alliance)",
	-- {item:2838} Heavy Stone · {object:1735} Iron Deposit · {skill:186} Mining
	["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} provient des gisements de {object:1735} ({skill:186}) ; c'est le groupe le plus dense des données. L'hôtel des ventes convient aussi.",

	-- Step 21: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (Horde)",

	-- Step 22: Engineering materials for 75-150
	-- {skill:202} Engineering
	["{skill:202} materials for 75-150"] = "Composants de {skill:202} pour 75-150",
	-- {skill:186} Mining · {item:2840} Copper Bar
	["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186} : fondez {item:2840} (ou l'hôtel des ventes)",

	-- Step 23: Rough Copper Bomb to 80
	-- {spell:3923} Rough Copper Bomb
	["{spell:3923} to 80"] = "{spell:3923} jusqu'à 80",
	["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 75, vert jusqu'à 90 : chaque fabrication ne donne pas un point. Nécessite une enclume à proximité.",

	-- Step 24: Engineering recipes at 80
	-- {skill:202} Engineering
	["{skill:202} recipes at 80"] = "Recettes de {skill:202} à 80",
	-- {skill:202} Engineering · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:3924} is taught from {skill:202} 80."] = "Retournez voir un maître en {skill:202} : {spell:3924} s'apprend à partir de {skill:202} 80.",

	-- Step 25: Copper Tube to 85
	-- {spell:3924} Copper Tube
	["{spell:3924} to 85"] = "{spell:3924} jusqu'à 85",
	["Yellow until 95, green until 110: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 95, vert jusqu'à 110 : chaque fabrication ne donne pas un point. Nécessite une enclume à proximité.",

	-- Step 26: Engineering recipes at 85
	-- {skill:202} Engineering
	["{skill:202} recipes at 85"] = "Recettes de {skill:202} à 85",
	-- {skill:202} Engineering · {spell:3929} Coarse Blasting Powder
	["Back to an {skill:202} trainer: {spell:3929} is taught from {skill:202} 85."] = "Retournez voir un maître en {skill:202} : {spell:3929} s'apprend à partir de {skill:202} 85.",

	-- Step 27: Coarse Blasting Powder to 95
	-- {spell:3929} Coarse Blasting Powder
	["{spell:3929} to 95"] = "{spell:3929} jusqu'à 95",
	["Yellow until 90, green until 95: not every craft gives a point."] = "Jaune jusqu'à 90, vert jusqu'à 95 : chaque fabrication ne donne pas un point.",

	-- Step 28: Engineering recipes at 95
	-- {skill:202} Engineering
	["{skill:202} recipes at 95"] = "Recettes de {skill:202} à 95",
	-- {skill:202} Engineering · {spell:3926} Copper Modulator
	["Back to an {skill:202} trainer: {spell:3926} is taught from {skill:202} 95."] = "Retournez voir un maître en {skill:202} : {spell:3926} s'apprend à partir de {skill:202} 95.",

	-- Step 29: Copper Modulator to 111
	-- {spell:3926} Copper Modulator
	["{spell:3926} to 111"] = "{spell:3926} jusqu'à 111",
	["Yellow until 110, green until 125: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 110, vert jusqu'à 125 : chaque fabrication ne donne pas un point. Nécessite une enclume à proximité.",
	["a tool: keep it in your bags"] = "un outil : gardez-le dans vos sacs",

	-- Step 30: Engineering recipes at 111
	-- {skill:202} Engineering
	["{skill:202} recipes at 111"] = "Recettes de {skill:202} à 111",
	-- {skill:202} Engineering · {spell:3937} Large Copper Bomb
	["Back to an {skill:202} trainer: {spell:3937} is taught from {skill:202} 105."] = "Retournez voir un maître en {skill:202} : {spell:3937} s'apprend à partir de {skill:202} 105.",

	-- Step 31: Large Copper Bomb to 125
	-- {spell:3937} Large Copper Bomb
	["{spell:3937} to 125"] = "{spell:3937} jusqu'à 125",
	["Yellow until 130, green until 155: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 130, vert jusqu'à 155 : chaque fabrication ne donne pas un point. Nécessite une enclume à proximité.",

	-- Step 32: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "Recettes de {skill:202} à 125",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} is taught from {skill:202} 125."] = "Retournez voir un maître en {skill:202} : {spell:3945} s'apprend à partir de {skill:202} 125.",

	-- Step 33: Heavy Blasting Powder to 139
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 139"] = "{spell:3945} jusqu'à 139",
	["Yellow until 135, green until 145: not every craft gives a point."] = "Jaune jusqu'à 135, vert jusqu'à 145 : chaque fabrication ne donne pas un point.",

	-- Step 34: Engineering recipes at 139
	-- {skill:202} Engineering
	["{skill:202} recipes at 139"] = "Recettes de {skill:202} à 139",
	-- {skill:202} Engineering · {spell:3942} Whirring Bronze Gizmo
	["Back to an {skill:202} trainer: {spell:3942} is taught from {skill:202} 125."] = "Retournez voir un maître en {skill:202} : {spell:3942} s'apprend à partir de {skill:202} 125.",

	-- Step 35: Whirring Bronze Gizmo to 150
	-- {spell:3942} Whirring Bronze Gizmo
	["{spell:3942} to 150"] = "{spell:3942} jusqu'à 150",
	-- {skill:202} Engineering
	["Yellow until 150, green until 175: not every craft gives a point. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "Jaune jusqu'à 150, vert jusqu'à 175 : chaque fabrication ne donne pas un point. Nécessite une enclume à proximité. {skill:202} 150 est un palier du système d'Héritage.",

	-- Step 36: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "{skill:202} (expert)",
	-- {skill:202} Engineering
	["Expert needs character level 20 and {skill:202} 125; it raises the cap to 225. Materials for 150-225 are worth about 15g in all."] = "Expert nécessite le niveau 20 et {skill:202} 125 ; le plafond passe à 225. Les composants pour 150-225 valent environ 15g au total.",

	-- Step 37: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Alliance)",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Gueule d'acier, {npc:2384}, {npc:2354} (les bêtes de niveau 18-30 en donnent) ; le guide de {skill:393} couvre ce trajet. L'hôtel des ventes convient aussi.",

	-- Step 38: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Horde)",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez ici : {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} (les bêtes de niveau 18-30 en donnent) ; le guide de {skill:393} couvre ce trajet. L'hôtel des ventes convient aussi.",

	-- Step 40: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (Alliance)",
	-- {item:7912} Solid Stone · {object:2040} Mithril Deposit · {skill:186} Mining
	["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} provient des gisements de {object:2040} ({skill:186}) ; c'est le groupe le plus dense des données. L'hôtel des ventes convient aussi.",

	-- Step 41: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (Horde)",

	-- Step 42: Engineering materials for 150-225
	-- {skill:202} Engineering
	["{skill:202} materials for 150-225"] = "Composants de {skill:202} pour 150-225",
	-- {skill:186} Mining · {item:3575} Iron Bar
	["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186} : fondez {item:3575} (ou l'hôtel des ventes)",
	-- {skill:186} Mining · {item:3858} Mithril Ore
	["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186} : fondez {item:3858} (ou l'hôtel des ventes)",

	-- Step 43: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "{spell:3953} jusqu'à 175",
	["Yellow until 170, green until 195: not every craft gives a point."] = "Jaune jusqu'à 170, vert jusqu'à 195 : chaque fabrication ne donne pas un point.",

	-- Step 44: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "Recettes de {skill:202} à 175",
	-- {skill:202} Engineering · {spell:12590} Gyromatic Micro-Adjustor
	["Back to an {skill:202} trainer: {spell:12590} is taught from {skill:202} 175."] = "Retournez voir un maître en {skill:202} : {spell:12590} s'apprend à partir de {skill:202} 175.",

	-- Step 45: Gyromatic Micro-Adjustor to 210
	-- {item:10498} Gyromatic Micro-Adjustor
	["{item:10498} to 210"] = "{item:10498} jusqu'à 210",
	["Yellow until 195, green until 215: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 195, vert jusqu'à 215 : chaque fabrication ne donne pas un point. Nécessite une enclume à proximité.",

	-- Step 46: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "Recettes de {skill:202} à 210",
	-- {skill:202} Engineering · {spell:12585} Solid Blasting Powder · {spell:12596} Hi-Impact Mithril Slugs
	["Back to an {skill:202} trainer: {spell:12585}, {spell:12596} are taught from {skill:202} 210."] = "Retournez voir un maître en {skill:202} : {spell:12585}, {spell:12596} s'apprennent à partir de {skill:202} 210.",

	-- Step 47: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "{item:10512} jusqu'à 225",
	-- {skill:202} Engineering
	["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "Jaune jusqu'à 230, vert jusqu'à 250 : chaque fabrication ne donne pas un point. Nécessite une enclume à proximité. {skill:202} 225 est un palier du système d'Héritage.",

	-- Step 48: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "{skill:202} (artisan)",
	-- {skill:202} Engineering
	["Artisan needs character level 35 and {skill:202} 200; it raises the cap to 300. Materials for 225-300 are worth about 67g in all."] = "Artisan nécessite le niveau 35 et {skill:202} 200 ; le plafond passe à 300. Les composants pour 225-300 valent environ 67g au total.",

	-- Step 49: Schematic: Thorium Widget
	-- {item:15994} Thorium Widget · {skill:202} Engineering
	["Teaches {item:15994} (needs {skill:202} 260). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Apprend {item:15994} (nécessite {skill:202} 260). Les marchands la vendent en stock limité qui se renouvelle ; l'hôtel des ventes en a souvent aussi.",

	-- Step 50: Schematic: Thorium Tube
	-- {item:16000} Thorium Tube · {skill:202} Engineering
	["Teaches {item:16000} (needs {skill:202} 275). Vendors sell it in limited stock that restocks."] = "Apprend {item:16000} (nécessite {skill:202} 275). Les marchands la vendent en stock limité qui se renouvelle.",

	-- Step 53: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Alliance)",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Les {npc:7027} (niveau 56-57) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 54: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horde)",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Les {npc:6189} (niveau 51-52) le laissent tomber ici. L'hôtel des ventes convient aussi.",

	-- Step 55: Engineering materials for 225-300
	-- {skill:202} Engineering
	["{skill:202} materials for 225-300"] = "Composants de {skill:202} pour 225-300",
	-- {skill:186} Mining · {item:10620} Thorium Ore
	["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186} : fondez {item:10620} (ou l'hôtel des ventes)",

	-- Step 56: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "{item:10512} jusqu'à 245",
	["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 230, vert jusqu'à 250 : chaque fabrication ne donne pas un point. Nécessite une enclume à proximité.",

	-- Step 57: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "Recettes de {skill:202} à 245",
	-- {skill:202} Engineering · {spell:12621} Mithril Gyro-Shot
	["Back to an {skill:202} trainer: {spell:12621} is taught from {skill:202} 245."] = "Retournez voir un maître en {skill:202} : {spell:12621} s'apprend à partir de {skill:202} 245.",

	-- Step 58: Mithril Gyro-Shot to 264
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 264"] = "{item:10513} jusqu'à 264",
	["Yellow until 265, green until 285: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 265, vert jusqu'à 285 : chaque fabrication ne donne pas un point. Nécessite une enclume à proximité.",

	-- Step 59: Thorium Widget to 288
	-- {item:15994} Thorium Widget
	["{item:15994} to 288"] = "{item:15994} jusqu'à 288",
	["Orange (a point every craft) until 280, yellow until 290, green until 300. Needs an anvil nearby."] = "Orange (un point à chaque fabrication) jusqu'à 280, jaune jusqu'à 290, vert jusqu'à 300. Nécessite une enclume à proximité.",
	["from the recipe in your bags"] = "avec la recette dans vos sacs",

	-- Step 60: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "{item:16000} jusqu'à 300",
	-- {skill:202} Engineering
	["Orange (a point every craft) until 295, yellow until 305, green until 315. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "Orange (un point à chaque fabrication) jusqu'à 295, jaune jusqu'à 305, vert jusqu'à 315. Nécessite une enclume à proximité. {skill:202} 300 est un palier du système d'Héritage.",
}
