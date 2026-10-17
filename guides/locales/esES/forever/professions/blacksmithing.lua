-- Spanish (Spain) (esES): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Blacksmithing
	-- {skill:164} Blacksmithing
	["Apprentice {skill:164}"] = "{skill:164} de aprendiz",
	-- {skill:164} Blacksmithing
	["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164} se sube a la vez que el nivel. El sistema de Legado de Forever recompensa las profesiones de fabricación con habilidad 150, 225 y 300 (los topes de oficial, experto y artesano), así que cada uno de esos hitos cuenta. Los materiales de 1-75 valen unos 17s en total.",

	-- Step 2: Rough Stone (Alliance)
	-- {item:2835} Rough Stone
	["{item:2835} (Alliance)"] = "{item:2835} (Alianza)",
	-- {item:2835} Rough Stone · {object:1731} Copper Vein · {skill:186} Mining
	["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} se obtiene de los nodos de {object:1731} ({skill:186}); esta es la zona con más nodos según los datos. También puedes comprarlo en la casa de subastas.",

	-- Step 3: Rough Stone (Horde)
	-- {item:2835} Rough Stone
	["{item:2835} (Horde)"] = "{item:2835} (Horda)",

	-- Step 4: Rough Sharpening Stone to 45
	-- {spell:2660} Rough Sharpening Stone
	["{spell:2660} to 45"] = "{spell:2660} hasta 45",
	["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "Naranja (un punto por cada fabricación) hasta 15, amarillo hasta 35, verde hasta 55.",

	-- Step 5: Blacksmithing recipes at 45
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 45"] = "Recetas de {skill:164} a 45",
	-- {skill:164} Blacksmithing · {spell:3320} Rough Grinding Stone
	["Back to a {skill:164} trainer: {spell:3320} is taught from {skill:164} 45."] = "Vuelve a un instructor de {skill:164}: {spell:3320} se aprende a partir de {skill:164} 45.",

	-- Step 6: Rough Grinding Stone to 75
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 75"] = "{spell:3320} hasta 75",
	["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Amarillo hasta 65, verde hasta 85: no todas las fabricaciones dan punto. 75 es el tope de aprendiz.",

	-- Step 7: Journeyman Blacksmithing
	-- {skill:164} Blacksmithing
	["Journeyman {skill:164}"] = "{skill:164} de oficial",
	-- {skill:164} Blacksmithing
	["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "Oficial requiere nivel de personaje 10 y {skill:164} 50; sube el tope a 150. Los materiales de 75-150 valen unos 9g 41s en total.",
	-- {item:5956} Blacksmith Hammer
	["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: es una herramienta, guárdala en tus bolsas",

	-- Step 10: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (Alianza)",
	-- {item:2836} Coarse Stone · {object:1732} Tin Vein · {skill:186} Mining
	["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} se obtiene de los nodos de {object:1732} ({skill:186}); esta es la zona con más nodos según los datos. También puedes comprarlo en la casa de subastas.",

	-- Step 11: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (Horda)",

	-- Step 12: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (Alianza)",
	-- {item:2838} Heavy Stone · {object:1735} Iron Deposit · {skill:186} Mining
	["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} se obtiene de los nodos de {object:1735} ({skill:186}); esta es la zona con más nodos según los datos. También puedes comprarlo en la casa de subastas.",

	-- Step 13: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (Horda)",

	-- Step 14: Blacksmithing materials for 75-150
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 75-150"] = "Materiales de {skill:164} para 75-150",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Se obtienen despellejando, desencantando o con otra profesión: consíguelos tú o cómpralos en la casa de subastas.",
	-- {skill:186} Mining · {item:2770} Copper Ore
	["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: funde {item:2770} (o cómpralo en la casa de subastas)",
	-- {skill:186} Mining · {item:2840} Copper Bar
	["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: funde {item:2840} (o cómpralo en la casa de subastas)",

	-- Step 15: Rough Grinding Stone to 83
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 83"] = "{spell:3320} hasta 83",
	["Yellow until 65, green until 85: not every craft gives a point."] = "Amarilla hasta 65, verde hasta 85: no todas las fabricaciones dan un punto.",

	-- Step 16: Blacksmithing recipes at 83
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 83"] = "Recetas de {skill:164} a 83",
	-- {skill:164} Blacksmithing · {spell:2666} Runed Copper Belt
	["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "Vuelve a un instructor de {skill:164}: {spell:2666} se aprende a partir de {skill:164} 80.",

	-- Step 17: Runed Copper Belt to 100
	-- {spell:2666} Runed Copper Belt
	["{spell:2666} to 100"] = "{spell:2666} hasta 100",
	["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "Naranja (un punto por cada fabricación) hasta 85, amarillo hasta 105, verde hasta 125. Necesitas un yunque cerca.",

	-- Step 18: Blacksmithing recipes at 100
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 100"] = "Recetas de {skill:164} a 100",
	-- {skill:164} Blacksmithing · {spell:3117} Heavy Weightstone
	["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "Vuelve a un instructor de {skill:164}: {spell:3117} se aprende a partir de {skill:164} 100.",

	-- Step 19: Heavy Weightstone to 112
	-- {spell:3117} Heavy Weightstone
	["{spell:3117} to 112"] = "{spell:3117} hasta 112",
	["Yellow until 107, green until 115: not every craft gives a point."] = "Amarilla hasta 107, verde hasta 115: no todas las fabricaciones dan un punto.",

	-- Step 20: Blacksmithing recipes at 112
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 112"] = "Recetas de {skill:164} a 112",
	-- {skill:164} Blacksmithing · {spell:2668} Rough Bronze Leggings
	["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "Vuelve a un instructor de {skill:164}: {spell:2668} se aprende a partir de {skill:164} 95.",

	-- Step 21: Rough Bronze Leggings to 121
	-- {spell:2668} Rough Bronze Leggings
	["{spell:2668} to 121"] = "{spell:2668} hasta 121",
	["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "Naranja (un punto por cada fabricación) hasta 120, amarillo hasta 135, verde hasta 150. Necesitas un yunque cerca.",

	-- Step 22: Blacksmithing recipes at 121
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 121"] = "Recetas de {skill:164} a 121",
	-- {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers
	["Back to a {skill:164} trainer: {spell:2672} is taught from {skill:164} 120."] = "Vuelve a un instructor de {skill:164}: {spell:2672} se aprende a partir de {skill:164} 120.",

	-- Step 23: Patterned Bronze Bracers to 150
	-- {spell:2672} Patterned Bronze Bracers
	["{spell:2672} to 150"] = "{spell:2672} hasta 150",
	-- {skill:164} Blacksmithing
	["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "Naranja (un punto por cada fabricación) hasta 125, amarillo hasta 140, verde hasta 155. Necesitas un yunque cerca. {skill:164} 150 es un hito del Sistema de legado.",

	-- Step 24: Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Expert {skill:164}"] = "{skill:164} de experto",
	-- {skill:164} Blacksmithing
	["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "Experto requiere nivel de personaje 20 y {skill:164} 125; sube el tope a 225. Los materiales para 150-225 valen unos 42g en total.",

	-- Step 25: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Alianza)",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja aquí a {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Quijaforte, {npc:2384} y {npc:2354} (lo dan las bestias de nivel 18-30); la guía de {skill:393} tiene la ruta. También puedes comprarlo en la casa de subastas.",

	-- Step 26: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Horda)",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja aquí a {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811} y {npc:3817} (lo dan las bestias de nivel 18-30); la guía de {skill:393} tiene la ruta. También puedes comprarlo en la casa de subastas.",

	-- Step 31: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (Alianza)",
	-- {item:7912} Solid Stone · {object:2040} Mithril Deposit · {skill:186} Mining
	["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} se obtiene de los nodos de {object:2040} ({skill:186}); esta es la zona con más nodos según los datos. También puedes comprarlo en la casa de subastas.",

	-- Step 32: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (Horda)",

	-- Step 33: Blacksmithing materials for 150-225
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 150-225"] = "Materiales de {skill:164} para 150-225",
	-- {skill:186} Mining · {item:2775} Silver Ore
	["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}: funde {item:2775} (o cómpralo en la casa de subastas)",
	-- {skill:186} Mining · {item:3575} Iron Bar
	["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: funde {item:3575} (o cómpralo en la casa de subastas)",

	-- Step 34: Silvered Bronze Gauntlets to 155
	-- {spell:3333} Silvered Bronze Gauntlets
	["{spell:3333} to 155"] = "{spell:3333} hasta 155",
	["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 155, verde hasta 170: no todas las fabricaciones dan punto. Necesitas un yunque cerca.",

	-- Step 35: Blacksmithing recipes at 155
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 155"] = "Recetas de {skill:164} a 155",
	-- {skill:164} Blacksmithing · {spell:9985} Bronze Warhammer
	["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "Vuelve a un instructor de {skill:164}: {spell:9985} se aprende a partir de {skill:164} 155.",

	-- Step 36: Bronze Warhammer to 175
	-- {item:7956} Bronze Warhammer
	["{item:7956} to 175"] = "{item:7956} hasta 175",
	["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 170, verde hasta 185: no todas las fabricaciones dan punto. Necesitas un yunque cerca.",

	-- Step 37: Blacksmithing recipes at 175
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 175"] = "Recetas de {skill:164} a 175",
	-- {skill:164} Blacksmithing · {spell:9918} Solid Sharpening Stone
	["Back to a {skill:164} trainer: {spell:9918} is taught from {skill:164} 175."] = "Vuelve a un instructor de {skill:164}: {spell:9918} se aprende a partir de {skill:164} 175.",

	-- Step 38: Solid Sharpening Stone to 185
	-- {item:7964} Solid Sharpening Stone
	["{item:7964} to 185"] = "{item:7964} hasta 185",
	["Yellow until 180, green until 185: not every craft gives a point."] = "Amarilla hasta 180, verde hasta 185: no todas las fabricaciones dan un punto.",

	-- Step 39: Blacksmithing recipes at 185
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 185"] = "Recetas de {skill:164} a 185",
	-- {skill:164} Blacksmithing · {spell:7223} Golden Scale Bracers
	["Back to a {skill:164} trainer: {spell:7223} is taught from {skill:164} 185."] = "Vuelve a un instructor de {skill:164}: {spell:7223} se aprende a partir de {skill:164} 185.",

	-- Step 40: Golden Scale Bracers to 200
	-- {item:6040} Golden Scale Bracers
	["{item:6040} to 200"] = "{item:6040} hasta 200",
	["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 197, verde hasta 210: no todas las fabricaciones dan punto. Necesitas un yunque cerca.",

	-- Step 41: Blacksmithing recipes at 200
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 200"] = "Recetas de {skill:164} a 200",
	-- {skill:164} Blacksmithing · {spell:9916} Steel Breastplate
	["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "Vuelve a un instructor de {skill:164}: {spell:9916} se aprende a partir de {skill:164} 200.",

	-- Step 42: Steel Breastplate to 210
	-- {item:7963} Steel Breastplate
	["{item:7963} to 210"] = "{item:7963} hasta 210",
	["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 212, verde hasta 225: no todas las fabricaciones dan punto. Necesitas un yunque cerca.",

	-- Step 43: Blacksmithing recipes at 210
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 210"] = "Recetas de {skill:164} a 210",
	-- {skill:164} Blacksmithing · {spell:9920} Solid Grinding Stone · {spell:9935} Steel Plate Helm
	["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "Vuelve a un instructor de {skill:164}: {spell:9920}, {spell:9935} se aprenden a partir de {skill:164} 210.",

	-- Step 44: Steel Plate Helm to 225
	-- {item:7922} Steel Plate Helm
	["{item:7922} to 225"] = "{item:7922} hasta 225",
	-- {skill:164} Blacksmithing
	["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "Amarilla hasta 220, verde hasta 230: no todas las fabricaciones dan un punto. Necesitas un yunque cerca. {skill:164} 225 es un hito del sistema de Legado.",

	-- Step 45: Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Artisan {skill:164}"] = "{skill:164} de artesano",
	-- {skill:164} Blacksmithing
	["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "Artesano requiere nivel de personaje 35 y {skill:164} 200; sube el tope a 300. Los materiales para 225-300 valen unos 942g en total.",

	-- Step 46: Plans: Sentinel's Sabatons
	-- {item:250562} Sentinel's Sabatons · {skill:164} Blacksmithing
	["Teaches {item:250562} (needs {skill:164} 240)."] = "Enseña {item:250562} (requiere {skill:164} 240).",

	-- Step 47: Plans: Huge Thorium Battleaxe
	-- {item:12775} Huge Thorium Battleaxe · {skill:164} Blacksmithing
	["Teaches {item:12775} (needs {skill:164} 255)."] = "Enseña {item:12775} (requiere {skill:164} 255).",

	-- Step 48: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304} (Alianza)",
	-- {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch · {skill:393} Skinning
	["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja aquí a {npc:2729}, {npc:2730}, {npc:2732} y {npc:2734} (lo dan las bestias de nivel 38-50); la guía de {skill:393} tiene la ruta. También puedes comprarlo en la casa de subastas.",

	-- Step 49: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304} (Horda)",
	-- {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti · {skill:393} Skinning
	["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja aquí a {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286} y {npc:5296} (lo dan las bestias de nivel 38-50); la guía de {skill:393} tiene la ruta. También puedes comprarlo en la casa de subastas.",

	-- Step 50: Mageweave Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Mata a los enemigos que lo sueltan en el punto de farmeo que Polestar elige para tu nivel y facción. También sirve la Casa de subastas.",

	-- Step 53: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Alianza)",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja aquí a {npc:1815}, {npc:1816} y {npc:1817} (lo dan las bestias de nivel 48-60); la guía de {skill:393} tiene la ruta. También puedes comprarlo en la casa de subastas.",

	-- Step 54: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horda)",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja aquí a {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} y {npc:6377} (lo dan las bestias de nivel 48-60); la guía de {skill:393} tiene la ruta. También puedes comprarlo en la casa de subastas.",

	-- Step 55: Purple Lotus (Alliance)
	-- {item:8831} Purple Lotus
	["{item:8831} (Alliance)"] = "{item:8831} (Alianza)",
	-- {item:8831} Purple Lotus · {skill:182} Herbalism
	["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recoge {item:8831} con {skill:182}; esta es la zona con más nodos según los datos. También sirve la Casa de subastas.",

	-- Step 56: Purple Lotus (Horde)
	-- {item:8831} Purple Lotus
	["{item:8831} (Horde)"] = "{item:8831} (Horda)",

	-- Step 57: Dense Stone (Alliance)
	-- {item:12365} Dense Stone
	["{item:12365} (Alliance)"] = "{item:12365} (Alianza)",
	-- {item:12365} Dense Stone · {object:324} Small Thorium Vein · {skill:186} Mining
	["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365} se obtiene de los nodos de {object:324} ({skill:186}); esta es la zona con más nodos según los datos. También puedes comprarlo en la casa de subastas.",

	-- Step 58: Dense Stone (Horde)
	-- {item:12365} Dense Stone
	["{item:12365} (Horde)"] = "{item:12365} (Horda)",

	-- Step 59: Blacksmithing materials for 225-300
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 225-300"] = "Materiales de {skill:164} para 225-300",
	-- {skill:186} Mining · {item:3858} Mithril Ore
	["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: funde {item:3858} (o cómpralo en la casa de subastas)",
	-- {skill:186} Mining · {item:10620} Thorium Ore
	["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: funde {item:10620} (o cómpralo en la casa de subastas)",
	-- {skill:171} Alchemy · {item:249410} Sulfuric Acid
	["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}: {item:249410} (o cómpralo en la casa de subastas)",
	-- {skill:393} Skinning
	["{skill:393} (or the Auction House)"] = "{skill:393} (o cómpralo en la casa de subastas)",
	-- {skill:202} Engineering · {item:249432} Sandpaper
	["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}: {item:249432} (o cómpralo en la casa de subastas)",

	-- Step 60: Mithril Coif to 230
	-- {item:7931} Mithril Coif
	["{item:7931} to 230"] = "{item:7931} hasta 230",
	["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 235, verde hasta 245: no todas las fabricaciones dan punto. Necesitas un yunque cerca.",

	-- Step 61: Blacksmithing recipes at 230
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 230"] = "Recetas de {skill:164} a 230",
	-- {skill:164} Blacksmithing · {spell:16640} Dense Weightstone
	["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "Vuelve a un instructor de {skill:164}: {spell:16640} se aprende a partir de {skill:164} 230.",

	-- Step 62: Dense Weightstone to 235
	-- {item:12643} Dense Weightstone
	["{item:12643} to 235"] = "{item:12643} hasta 235",
	["Yellow until 232, green until 235: not every craft gives a point."] = "Amarilla hasta 232, verde hasta 235: no todas las fabricaciones dan un punto.",

	-- Step 63: Blacksmithing recipes at 235
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 235"] = "Recetas de {skill:164} a 235",
	-- {skill:164} Blacksmithing · {spell:9968} Heavy Mithril Boots
	["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "Vuelve a un instructor de {skill:164}: {spell:9968} se aprende a partir de {skill:164} 230.",

	-- Step 64: Heavy Mithril Boots to 244
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 244"] = "{item:7933} hasta 244",
	["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 240, verde hasta 250: no todas las fabricaciones dan punto. Necesitas un yunque cerca.",

	-- Step 65: Sentinel's Sabatons to 268
	-- {item:250562} Sentinel's Sabatons
	["{item:250562} to 268"] = "{item:250562} hasta 268",
	["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "Naranja (un punto por cada fabricación) hasta 260, amarillo hasta 270, verde hasta 280. Necesitas un yunque cerca.",
	["from the recipe in your bags"] = "con la receta de tus bolsas",

	-- Step 66: Blacksmithing recipes at 268
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 268"] = "Recetas de {skill:164} a 268",
	-- {skill:164} Blacksmithing · {spell:16639} Dense Grinding Stone
	["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "Vuelve a un instructor de {skill:164}: {spell:16639} se aprende a partir de {skill:164} 230.",

	-- Step 67: Huge Thorium Battleaxe to 300
	-- {item:12775} Huge Thorium Battleaxe
	["{item:12775} to 300"] = "{item:12775} hasta 300",
	-- {skill:164} Blacksmithing
	["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "Naranja (un punto por cada fabricación) hasta 280, amarillo hasta 292, verde hasta 305. Necesitas un yunque cerca. {skill:164} 300 es un hito del Sistema de legado.",
}
