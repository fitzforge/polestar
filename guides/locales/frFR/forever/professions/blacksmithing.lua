-- French (frFR): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Blacksmithing
	-- {skill:164} Blacksmithing
	["Apprentice {skill:164}"] = "Apprenti {skill:164}",
	-- {skill:164} Blacksmithing
	["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164} se monte en parallèle de la progression. Le système d'Héritage de Forever récompense les métiers d'artisanat aux compétences 150, 225 et 300 (les plafonds Compagnon, Expert et Artisan) : chacun de ces paliers compte. Les composants pour 1-75 valent environ 17 pa au total.",

	-- Step 2: Rough Stone (Alliance)
	-- {item:2835} Rough Stone
	["{item:2835} (Alliance)"] = "{item:2835} (Alliance)",
	-- {item:2835} Rough Stone · {object:1731} Copper Vein · {skill:186} Mining
	["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} provient des gisements de {object:1731} ({skill:186}) ; c'est la zone la plus dense des données. L'hôtel des ventes fonctionne aussi.",

	-- Step 3: Rough Stone (Horde)
	-- {item:2835} Rough Stone
	["{item:2835} (Horde)"] = "{item:2835} (Horde)",

	-- Step 4: Rough Sharpening Stone to 45
	-- {spell:2660} Rough Sharpening Stone
	["{spell:2660} to 45"] = "{spell:2660} jusqu'à 45",
	["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "Orange (un point à chaque fabrication) jusqu'à 15, jaune jusqu'à 35, vert jusqu'à 55.",

	-- Step 5: Blacksmithing recipes at 45
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 45"] = "{skill:164} : recettes à 45",
	-- {skill:164} Blacksmithing · {spell:3320} Rough Grinding Stone
	["Back to a {skill:164} trainer: {spell:3320} is taught from {skill:164} 45."] = "Retournez voir un maître de métier ({skill:164}) : {spell:3320} est enseigné dès {skill:164} 45.",

	-- Step 6: Rough Grinding Stone to 75
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 75"] = "{spell:3320} jusqu'à 75",
	["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Jaune jusqu'à 65, vert jusqu'à 85 : chaque fabrication ne rapporte pas un point. 75 est le plafond Apprenti.",

	-- Step 7: Journeyman Blacksmithing
	-- {skill:164} Blacksmithing
	["Journeyman {skill:164}"] = "Compagnon {skill:164}",
	-- {skill:164} Blacksmithing
	["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "Compagnon requiert le niveau 10 et {skill:164} 50 ; le plafond passe à 150. Les composants pour 75-150 valent environ 9 po 41 pa au total.",
	-- {item:5956} Blacksmith Hammer
	["{item:5956}: a tool, keep it in your bags"] = "{item:5956} : un outil, gardez-le dans vos sacs",

	-- Step 10: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (Alliance)",
	-- {item:2836} Coarse Stone · {object:1732} Tin Vein · {skill:186} Mining
	["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} provient des gisements de {object:1732} ({skill:186}) ; c'est la zone la plus dense des données. L'hôtel des ventes fonctionne aussi.",

	-- Step 11: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (Horde)",

	-- Step 12: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (Alliance)",
	-- {item:2838} Heavy Stone · {object:1735} Iron Deposit · {skill:186} Mining
	["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} provient des gisements de {object:1735} ({skill:186}) ; c'est la zone la plus dense des données. L'hôtel des ventes fonctionne aussi.",

	-- Step 13: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (Horde)",

	-- Step 14: Blacksmithing materials for 75-150
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 75-150"] = "{skill:164} : composants pour 75-150",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Dépecés, désenchantés ou fabriqués par un autre métier : récupérez-les vous-même ou achetez-les à l'hôtel des ventes.",
	-- {skill:186} Mining · {item:2770} Copper Ore
	["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186} : fondez {item:2770} (ou l'hôtel des ventes)",
	-- {skill:186} Mining · {item:2840} Copper Bar
	["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186} : fondez {item:2840} (ou l'hôtel des ventes)",

	-- Step 15: Rough Grinding Stone to 83
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 83"] = "{spell:3320} jusqu'à 83",
	["Yellow until 65, green until 85: not every craft gives a point."] = "Jaune jusqu'à 65, vert jusqu'à 85 : chaque fabrication ne rapporte pas un point.",

	-- Step 16: Blacksmithing recipes at 83
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 83"] = "{skill:164} : recettes à 83",
	-- {skill:164} Blacksmithing · {spell:2666} Runed Copper Belt
	["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "Retournez voir un maître de métier ({skill:164}) : {spell:2666} est enseigné dès {skill:164} 80.",

	-- Step 17: Runed Copper Belt to 100
	-- {spell:2666} Runed Copper Belt
	["{spell:2666} to 100"] = "{spell:2666} jusqu'à 100",
	["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "Orange (un point à chaque fabrication) jusqu'à 85, jaune jusqu'à 105, vert jusqu'à 125. Nécessite une enclume à proximité.",

	-- Step 18: Blacksmithing recipes at 100
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 100"] = "{skill:164} : recettes à 100",
	-- {skill:164} Blacksmithing · {spell:3117} Heavy Weightstone
	["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "Retournez voir un maître de métier ({skill:164}) : {spell:3117} est enseigné dès {skill:164} 100.",

	-- Step 19: Heavy Weightstone to 112
	-- {spell:3117} Heavy Weightstone
	["{spell:3117} to 112"] = "{spell:3117} jusqu'à 112",
	["Yellow until 107, green until 115: not every craft gives a point."] = "Jaune jusqu'à 107, vert jusqu'à 115 : chaque fabrication ne rapporte pas un point.",

	-- Step 20: Blacksmithing recipes at 112
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 112"] = "{skill:164} : recettes à 112",
	-- {skill:164} Blacksmithing · {spell:2668} Rough Bronze Leggings
	["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "Retournez voir un maître de métier ({skill:164}) : {spell:2668} est enseigné dès {skill:164} 95.",

	-- Step 21: Rough Bronze Leggings to 121
	-- {spell:2668} Rough Bronze Leggings
	["{spell:2668} to 121"] = "{spell:2668} jusqu'à 121",
	["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "Orange (un point à chaque fabrication) jusqu'à 120, jaune jusqu'à 135, vert jusqu'à 150. Nécessite une enclume à proximité.",

	-- Step 22: Blacksmithing recipes at 121
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 121"] = "{skill:164} : recettes à 121",
	-- {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers
	["Back to a {skill:164} trainer: {spell:2672} is taught from {skill:164} 120."] = "Retournez voir un maître de métier ({skill:164}) : {spell:2672} est enseigné dès {skill:164} 120.",

	-- Step 23: Patterned Bronze Bracers to 150
	-- {spell:2672} Patterned Bronze Bracers
	["{spell:2672} to 150"] = "{spell:2672} jusqu'à 150",
	-- {skill:164} Blacksmithing
	["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "Orange (un point à chaque fabrication) jusqu'à 125, jaune jusqu'à 140, vert jusqu'à 155. Nécessite une enclume à proximité. {skill:164} 150 est un palier du système d'Héritage.",

	-- Step 24: Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Expert {skill:164}"] = "Expert {skill:164}",
	-- {skill:164} Blacksmithing
	["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "Expert requiert le niveau 20 et {skill:164} 125 ; le plafond passe à 225. Les composants pour 150-225 valent environ 42 po au total.",

	-- Step 25: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Alliance)",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Gueule d'acier, {npc:2384}, {npc:2354} ici (les bêtes de niveau 18-30 le fournissent) ; le guide {skill:393} vous y mène. L'hôtel des ventes fonctionne aussi.",

	-- Step 26: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Horde)",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} ici (les bêtes de niveau 18-30 le fournissent) ; le guide {skill:393} vous y mène. L'hôtel des ventes fonctionne aussi.",

	-- Step 31: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (Alliance)",
	-- {item:7912} Solid Stone · {object:2040} Mithril Deposit · {skill:186} Mining
	["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} provient des gisements de {object:2040} ({skill:186}) ; c'est la zone la plus dense des données. L'hôtel des ventes fonctionne aussi.",

	-- Step 32: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (Horde)",

	-- Step 33: Blacksmithing materials for 150-225
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 150-225"] = "{skill:164} : composants pour 150-225",
	-- {skill:186} Mining · {item:2775} Silver Ore
	["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186} : fondez {item:2775} (ou l'hôtel des ventes)",
	-- {skill:186} Mining · {item:3575} Iron Bar
	["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186} : fondez {item:3575} (ou l'hôtel des ventes)",

	-- Step 34: Silvered Bronze Gauntlets to 155
	-- {spell:3333} Silvered Bronze Gauntlets
	["{spell:3333} to 155"] = "{spell:3333} jusqu'à 155",
	["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 155, vert jusqu'à 170 : chaque fabrication ne rapporte pas un point. Nécessite une enclume à proximité.",

	-- Step 35: Blacksmithing recipes at 155
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 155"] = "{skill:164} : recettes à 155",
	-- {skill:164} Blacksmithing · {spell:9985} Bronze Warhammer
	["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "Retournez voir un maître de métier ({skill:164}) : {spell:9985} est enseigné dès {skill:164} 155.",

	-- Step 36: Bronze Warhammer to 175
	-- {item:7956} Bronze Warhammer
	["{item:7956} to 175"] = "{item:7956} jusqu'à 175",
	["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 170, vert jusqu'à 185 : chaque fabrication ne rapporte pas un point. Nécessite une enclume à proximité.",

	-- Step 37: Blacksmithing recipes at 175
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 175"] = "{skill:164} : recettes à 175",
	-- {skill:164} Blacksmithing · {spell:9918} Solid Sharpening Stone
	["Back to a {skill:164} trainer: {spell:9918} is taught from {skill:164} 175."] = "Retournez voir un maître de métier ({skill:164}) : {spell:9918} est enseigné dès {skill:164} 175.",

	-- Step 38: Solid Sharpening Stone to 185
	-- {item:7964} Solid Sharpening Stone
	["{item:7964} to 185"] = "{item:7964} jusqu'à 185",
	["Yellow until 180, green until 185: not every craft gives a point."] = "Jaune jusqu'à 180, vert jusqu'à 185 : chaque fabrication ne rapporte pas un point.",

	-- Step 39: Blacksmithing recipes at 185
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 185"] = "{skill:164} : recettes à 185",
	-- {skill:164} Blacksmithing · {spell:7223} Golden Scale Bracers
	["Back to a {skill:164} trainer: {spell:7223} is taught from {skill:164} 185."] = "Retournez voir un maître de métier ({skill:164}) : {spell:7223} est enseigné dès {skill:164} 185.",

	-- Step 40: Golden Scale Bracers to 200
	-- {item:6040} Golden Scale Bracers
	["{item:6040} to 200"] = "{item:6040} jusqu'à 200",
	["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 197, vert jusqu'à 210 : chaque fabrication ne rapporte pas un point. Nécessite une enclume à proximité.",

	-- Step 41: Blacksmithing recipes at 200
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 200"] = "{skill:164} : recettes à 200",
	-- {skill:164} Blacksmithing · {spell:9916} Steel Breastplate
	["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "Retournez voir un maître de métier ({skill:164}) : {spell:9916} est enseigné dès {skill:164} 200.",

	-- Step 42: Steel Breastplate to 210
	-- {item:7963} Steel Breastplate
	["{item:7963} to 210"] = "{item:7963} jusqu'à 210",
	["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 212, vert jusqu'à 225 : chaque fabrication ne rapporte pas un point. Nécessite une enclume à proximité.",

	-- Step 43: Blacksmithing recipes at 210
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 210"] = "{skill:164} : recettes à 210",
	-- {skill:164} Blacksmithing · {spell:9920} Solid Grinding Stone · {spell:9935} Steel Plate Helm
	["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "Retournez voir un maître de métier ({skill:164}) : {spell:9920} et {spell:9935} sont enseignés dès {skill:164} 210.",

	-- Step 44: Steel Plate Helm to 225
	-- {item:7922} Steel Plate Helm
	["{item:7922} to 225"] = "{item:7922} jusqu'à 225",
	-- {skill:164} Blacksmithing
	["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "Jaune jusqu'à 220, vert jusqu'à 230 : chaque fabrication ne rapporte pas un point. Nécessite une enclume à proximité. {skill:164} 225 est un palier du système d'Héritage.",

	-- Step 45: Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Artisan {skill:164}"] = "Artisan {skill:164}",
	-- {skill:164} Blacksmithing
	["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "Artisan requiert le niveau 35 et {skill:164} 200 ; le plafond passe à 300. Les composants pour 225-300 valent environ 942 po au total.",

	-- Step 46: Plans: Sentinel's Sabatons
	-- {item:250562} Sentinel's Sabatons · {skill:164} Blacksmithing
	["Teaches {item:250562} (needs {skill:164} 240)."] = "Enseigne {item:250562} (requiert {skill:164} 240).",

	-- Step 47: Plans: Huge Thorium Battleaxe
	-- {item:12775} Huge Thorium Battleaxe · {skill:164} Blacksmithing
	["Teaches {item:12775} (needs {skill:164} 255)."] = "Enseigne {item:12775} (requiert {skill:164} 255).",

	-- Step 48: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304} (Alliance)",
	-- {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch · {skill:393} Skinning
	["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} ici (les bêtes de niveau 38-50 le fournissent) ; le guide {skill:393} vous y mène. L'hôtel des ventes fonctionne aussi.",

	-- Step 49: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304} (Horde)",
	-- {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti · {skill:393} Skinning
	["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} ici (les bêtes de niveau 38-50 le fournissent) ; le guide {skill:393} vous y mène. L'hôtel des ventes fonctionne aussi.",

	-- Step 50: Mageweave Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Tuez les monstres qui le lâchent à l'endroit que Polestar choisit pour votre niveau et votre faction. L'hôtel des ventes fonctionne aussi.",

	-- Step 53: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Alliance)",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez {npc:1815}, {npc:1816}, {npc:1817} ici (les bêtes de niveau 48-60 le fournissent) ; le guide {skill:393} vous y mène. L'hôtel des ventes fonctionne aussi.",

	-- Step 54: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horde)",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Dépecez {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} ici (les bêtes de niveau 48-60 le fournissent) ; le guide {skill:393} vous y mène. L'hôtel des ventes fonctionne aussi.",

	-- Step 55: Purple Lotus (Alliance)
	-- {item:8831} Purple Lotus
	["{item:8831} (Alliance)"] = "{item:8831} (Alliance)",
	-- {item:8831} Purple Lotus · {skill:182} Herbalism
	["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Cueillez {item:8831} avec {skill:182} ; c'est la zone la plus dense des données. L'hôtel des ventes fonctionne aussi.",

	-- Step 56: Purple Lotus (Horde)
	-- {item:8831} Purple Lotus
	["{item:8831} (Horde)"] = "{item:8831} (Horde)",

	-- Step 57: Dense Stone (Alliance)
	-- {item:12365} Dense Stone
	["{item:12365} (Alliance)"] = "{item:12365} (Alliance)",
	-- {item:12365} Dense Stone · {object:324} Small Thorium Vein · {skill:186} Mining
	["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365} provient des gisements de {object:324} ({skill:186}) ; c'est la zone la plus dense des données. L'hôtel des ventes fonctionne aussi.",

	-- Step 58: Dense Stone (Horde)
	-- {item:12365} Dense Stone
	["{item:12365} (Horde)"] = "{item:12365} (Horde)",

	-- Step 59: Blacksmithing materials for 225-300
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 225-300"] = "{skill:164} : composants pour 225-300",
	-- {skill:186} Mining · {item:3858} Mithril Ore
	["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186} : fondez {item:3858} (ou l'hôtel des ventes)",
	-- {skill:186} Mining · {item:10620} Thorium Ore
	["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186} : fondez {item:10620} (ou l'hôtel des ventes)",
	-- {skill:171} Alchemy · {item:249410} Sulfuric Acid
	["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171} : {item:249410} (ou l'hôtel des ventes)",
	-- {skill:393} Skinning
	["{skill:393} (or the Auction House)"] = "{skill:393} (ou l'hôtel des ventes)",
	-- {skill:202} Engineering · {item:249432} Sandpaper
	["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202} : {item:249432} (ou l'hôtel des ventes)",

	-- Step 60: Mithril Coif to 230
	-- {item:7931} Mithril Coif
	["{item:7931} to 230"] = "{item:7931} jusqu'à 230",
	["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 235, vert jusqu'à 245 : chaque fabrication ne rapporte pas un point. Nécessite une enclume à proximité.",

	-- Step 61: Blacksmithing recipes at 230
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 230"] = "{skill:164} : recettes à 230",
	-- {skill:164} Blacksmithing · {spell:16640} Dense Weightstone
	["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "Retournez voir un maître de métier ({skill:164}) : {spell:16640} est enseigné dès {skill:164} 230.",

	-- Step 62: Dense Weightstone to 235
	-- {item:12643} Dense Weightstone
	["{item:12643} to 235"] = "{item:12643} jusqu'à 235",
	["Yellow until 232, green until 235: not every craft gives a point."] = "Jaune jusqu'à 232, vert jusqu'à 235 : chaque fabrication ne rapporte pas un point.",

	-- Step 63: Blacksmithing recipes at 235
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 235"] = "{skill:164} : recettes à 235",
	-- {skill:164} Blacksmithing · {spell:9968} Heavy Mithril Boots
	["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "Retournez voir un maître de métier ({skill:164}) : {spell:9968} est enseigné dès {skill:164} 230.",

	-- Step 64: Heavy Mithril Boots to 244
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 244"] = "{item:7933} jusqu'à 244",
	["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Jaune jusqu'à 240, vert jusqu'à 250 : chaque fabrication ne rapporte pas un point. Nécessite une enclume à proximité.",

	-- Step 65: Sentinel's Sabatons to 268
	-- {item:250562} Sentinel's Sabatons
	["{item:250562} to 268"] = "{item:250562} jusqu'à 268",
	["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "Orange (un point à chaque fabrication) jusqu'à 260, jaune jusqu'à 270, vert jusqu'à 280. Nécessite une enclume à proximité.",
	["from the recipe in your bags"] = "depuis la recette dans vos sacs",

	-- Step 66: Blacksmithing recipes at 268
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 268"] = "{skill:164} : recettes à 268",
	-- {skill:164} Blacksmithing · {spell:16639} Dense Grinding Stone
	["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "Retournez voir un maître de métier ({skill:164}) : {spell:16639} est enseigné dès {skill:164} 230.",

	-- Step 67: Huge Thorium Battleaxe to 300
	-- {item:12775} Huge Thorium Battleaxe
	["{item:12775} to 300"] = "{item:12775} jusqu'à 300",
	-- {skill:164} Blacksmithing
	["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "Orange (un point à chaque fabrication) jusqu'à 280, jaune jusqu'à 292, vert jusqu'à 305. Nécessite une enclume à proximité. {skill:164} 300 est un palier du système d'Héritage.",
}
