-- Spanish (Spain) (esES): the guide forever/professions/leatherworking (forever/professions/leatherworking.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Leatherworking
	-- {skill:165} Leatherworking
	["Apprentice {skill:165}"] = "{skill:165} de aprendiz",
	-- {skill:165} Leatherworking
	["{skill:165} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 18s in all."] = "{skill:165} avanza a la vez que subes de nivel. El sistema de Legado de Forever recompensa las profesiones de fabricación a 150, 225 y 300 de habilidad (los límites de oficial, experto y artesano), así que cuenta cada uno de esos hitos. Los materiales de 1 a 75 cuestan en total unos 1 o 18 p.",

	-- Step 2: Light Leather (Alliance)
	-- {item:2318} Light Leather
	["{item:2318} (Alliance)"] = "{item:2318} (Alianza)",
	-- {npc:1125} Crag Boar · {npc:1127} Elder Crag Boar · {npc:1196} Ice Claw Bear · {npc:1199} Juvenile Snow Leopard · {npc:1126} Large Crag Boar · {npc:1689} Scarred Crag Boar · {npc:1201} Snow Leopard · {npc:1138} Snow Tracker Wolf · {npc:1131} Winter Wolf · {npc:1128} Young Black Bear · {skill:393} Skinning
	["Skin {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:1125}, {npc:1127}, {npc:1196}, {npc:1199}, {npc:1126}, {npc:1689}, {npc:1201}, {npc:1138}, {npc:1131}, {npc:1128} aquí (las bestias de nivel 5-20 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",

	-- Step 3: Light Leather (Horde)
	-- {item:2318} Light Leather
	["{item:2318} (Horde)"] = "{item:2318} (Horda)",
	-- {npc:3126} Armored Scorpid · {npc:3123} Bloodtalon Scythemaw · {npc:3122} Bloodtalon Taillasher · {npc:3125} Clattering Scorpid · {npc:3099} Dire Mottled Boar · {npc:3110} Dreadmaw Crocolisk · {npc:3121} Durotar Tiger · {npc:3100} Elder Mottled Boar · {npc:3130} Thunder Lizard · {npc:3127} Venomtail Scorpid · {skill:393} Skinning
	["Skin {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} here (beasts of level 5-20 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:3126}, {npc:3123}, {npc:3122}, {npc:3125}, {npc:3099}, {npc:3110}, {npc:3121}, {npc:3100}, {npc:3130}, {npc:3127} aquí (las bestias de nivel 5-20 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",

	-- Step 4: Light Armor Kit to 55
	-- {spell:2152} Light Armor Kit
	["{spell:2152} to 55"] = "{spell:2152} hasta 55",
	["Orange (a point every craft) until 30, yellow until 45, green until 60."] = "Naranja (un punto con cada fabricación) hasta 30, amarillo hasta 45 y verde hasta 60.",

	-- Step 5: Leatherworking recipes at 55
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 55"] = "Recetas de {skill:165} a 55",
	-- {skill:165} Leatherworking · {spell:9062} Small Leather Ammo Pouch
	["Back to a {skill:165} trainer: {spell:9062} is taught from {skill:165} 55."] = "Vuelve con un instructor de {skill:165}: {spell:9062} se enseña desde {skill:165} 55.",

	-- Step 6: Small Leather Ammo Pouch to 75
	-- {item:7279} Small Leather Ammo Pouch
	["{item:7279} to 75"] = "{item:7279} hasta 75",
	["Yellow until 70, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Amarillo hasta 70 y verde hasta 85: no todas las fabricaciones dan un punto. 75 es el límite de aprendiz.",

	-- Step 7: Journeyman Leatherworking
	-- {skill:165} Leatherworking
	["Journeyman {skill:165}"] = "{skill:165} de oficial",
	-- {skill:165} Leatherworking
	["Journeyman needs character level 10 and {skill:165} 50; it raises the cap to 150. Materials for 75-150 are worth about 11g in all."] = "Oficial requiere nivel de personaje 10 y {skill:165} 50; sube el límite a 150. Los materiales de 75 a 150 cuestan en total unos 11 o.",

	-- Step 8: Light Hide (Alliance)
	-- {item:783} Light Hide
	["{item:783} (Alliance)"] = "{item:783} (Alianza)",

	-- Step 9: Light Hide (Horde)
	-- {item:783} Light Hide
	["{item:783} (Horde)"] = "{item:783} (Horda)",

	-- Step 12: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Alianza)",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Quijaforte, {npc:2384}, {npc:2354} aquí (las bestias de nivel 18-30 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",

	-- Step 13: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Horda)",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} aquí (las bestias de nivel 18-30 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",

	-- Step 14: Medium Hide (Alliance)
	-- {item:4232} Medium Hide
	["{item:4232} (Alliance)"] = "{item:4232} (Alianza)",

	-- Step 15: Medium Hide (Horde)
	-- {item:4232} Medium Hide
	["{item:4232} (Horde)"] = "{item:4232} (Horda)",

	-- Step 16: Leatherworking materials for 75-150
	-- {skill:165} Leatherworking
	["{skill:165} materials for 75-150"] = "Materiales de {skill:165} para 75-150",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Se obtienen despellejando, desencantando o con otra profesión: consíguelos tú o cómpralos en la casa de subastas.",
	-- {skill:171} Alchemy · {item:2457} Elixir of Minor Agility
	["{skill:171}: {item:2457} (or the Auction House)"] = "{skill:171}: {item:2457} (o la casa de subastas)",

	-- Step 17: Embossed Leather Gloves to 85
	-- {spell:3756} Embossed Leather Gloves
	["{spell:3756} to 85"] = "{spell:3756} hasta 85",
	["Yellow until 85, green until 100: not every craft gives a point."] = "Amarillo hasta 85 y verde hasta 100: no todas las fabricaciones dan un punto.",

	-- Step 18: Leatherworking recipes at 85
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 85"] = "Recetas de {skill:165} a 85",
	-- {skill:165} Leatherworking · {spell:3763} Fine Leather Belt
	["Back to a {skill:165} trainer: {spell:3763} is taught from {skill:165} 85."] = "Vuelve con un instructor de {skill:165}: {spell:3763} se enseña desde {skill:165} 85.",

	-- Step 19: Fine Leather Belt to 105
	-- {spell:3763} Fine Leather Belt
	["{spell:3763} to 105"] = "{spell:3763} hasta 105",
	["Yellow until 100, green until 115: not every craft gives a point."] = "Amarillo hasta 100 y verde hasta 115: no todas las fabricaciones dan un punto.",

	-- Step 20: Leatherworking recipes at 105
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 105"] = "Recetas de {skill:165} a 105",
	-- {skill:165} Leatherworking · {spell:9068} Light Leather Pants
	["Back to a {skill:165} trainer: {spell:9068} is taught from {skill:165} 100."] = "Vuelve con un instructor de {skill:165}: {spell:9068} se enseña desde {skill:165} 100.",

	-- Step 21: Light Leather Pants to 120
	-- {item:7282} Light Leather Pants
	["{item:7282} to 120"] = "{item:7282} hasta 120",
	["Yellow until 115, green until 130: not every craft gives a point."] = "Amarillo hasta 115 y verde hasta 130: no todas las fabricaciones dan un punto.",

	-- Step 22: Leatherworking recipes at 120
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 120"] = "Recetas de {skill:165} a 120",
	-- {skill:165} Leatherworking · {spell:9074} Nimble Leather Gloves
	["Back to a {skill:165} trainer: {spell:9074} is taught from {skill:165} 120."] = "Vuelve con un instructor de {skill:165}: {spell:9074} se enseña desde {skill:165} 120.",

	-- Step 23: Nimble Leather Gloves to 130
	-- {item:7285} Nimble Leather Gloves
	["{item:7285} to 130"] = "{item:7285} hasta 130",
	["Yellow until 132, green until 145: not every craft gives a point."] = "Amarillo hasta 132 y verde hasta 145: no todas las fabricaciones dan un punto.",

	-- Step 24: Leatherworking recipes at 130
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 130"] = "Recetas de {skill:165} a 130",
	-- {skill:165} Leatherworking · {spell:3817} Cured Medium Hide · {spell:3768} Hillman's Shoulders
	["Back to a {skill:165} trainer: {spell:3817}, {spell:3768} are taught from {skill:165} 130."] = "Vuelve con un instructor de {skill:165}: {spell:3817} y {spell:3768} se enseñan desde {skill:165} 130.",

	-- Step 25: Hillman's Shoulders to 150
	-- {spell:3768} Hillman's Shoulders
	["{spell:3768} to 150"] = "{spell:3768} hasta 150",
	-- {skill:165} Leatherworking
	["Yellow until 142, green until 155: not every craft gives a point. {skill:165} 150 is a Legacy System milestone."] = "Amarillo hasta 142 y verde hasta 155: no todas las fabricaciones dan un punto. {skill:165} 150 es un hito del sistema de Legado.",

	-- Step 26: Expert Leatherworking
	-- {skill:165} Leatherworking
	["Expert {skill:165}"] = "{skill:165} de experto",
	-- {skill:165} Leatherworking
	["Expert needs character level 20 and {skill:165} 125; it raises the cap to 225. Materials for 150-225 are worth about 61g in all."] = "Experto requiere nivel de personaje 20 y {skill:165} 125; sube el límite a 225. Los materiales de 150 a 225 cuestan en total unos 61 o.",

	-- Step 27: Pattern: Mystic Heavy Armor Kit
	-- {item:252452} Mystic Heavy Armor Kit · {skill:165} Leatherworking
	["Teaches {item:252452} (needs {skill:165} 135)."] = "Enseña {item:252452} (requiere {skill:165} 135).",

	-- Step 28: Pattern: Forceful Thick Armor Kit
	-- {item:252463} Forceful Thick Armor Kit · {skill:165} Leatherworking
	["Teaches {item:252463} (needs {skill:165} 185)."] = "Enseña {item:252463} (requiere {skill:165} 185).",

	-- Step 29: Heavy Leather (Alliance)
	-- {item:4234} Heavy Leather
	["{item:4234} (Alliance)"] = "{item:4234} (Alianza)",
	-- {npc:2248} Cave Yeti · {npc:2249} Ferocious Yeti · {npc:2251} Giant Yeti · {npc:2407} Hulking Mountain Lion · {npc:2406} Mountain Lion · {npc:2250} Mountain Yeti · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Snapjaw here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:2248}, {npc:2249}, {npc:2251}, {npc:2407}, {npc:2406}, {npc:2250}, Quijaforte aquí (las bestias de nivel 28-40 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",

	-- Step 30: Heavy Leather (Horde)
	-- {item:4234} Heavy Leather
	["{item:4234} (Horde)"] = "{item:4234} (Horda)",
	-- {npc:4107} Highperch Wyvern · {npc:4147} Saltstone Basilisk · {npc:4140} Scorpid Reaver · {npc:4139} Scorpid Terror · {npc:4143} Sparkleshell Snapper · {npc:4142} Sparkleshell Tortoise · {skill:393} Skinning
	["Skin {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} here (beasts of level 28-40 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:4107}, {npc:4147}, {npc:4140}, {npc:4139}, {npc:4143}, {npc:4142} aquí (las bestias de nivel 28-40 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",

	-- Step 31: Heavy Hide (Alliance)
	-- {item:4235} Heavy Hide
	["{item:4235} (Alliance)"] = "{item:4235} (Alianza)",

	-- Step 32: Heavy Hide (Horde)
	-- {item:4235} Heavy Hide
	["{item:4235} (Horde)"] = "{item:4235} (Horda)",

	-- Step 33: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304} (Alianza)",
	-- {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch · {skill:393} Skinning
	["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} aquí (las bestias de nivel 38-50 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",

	-- Step 34: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304} (Horda)",
	-- {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti · {skill:393} Skinning
	["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} aquí (las bestias de nivel 38-50 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",

	-- Step 35: Deeprock Salt (Alliance)
	-- {item:8150} Deeprock Salt
	["{item:8150} (Alliance)"] = "{item:8150} (Alianza)",
	-- {npc:92} Rock Elemental
	["{npc:92} (level 39-40) drop it here. The Auction House works too."] = "Cada {npc:92} (nivel 39-40) puede soltarlo aquí. También sirve la casa de subastas.",

	-- Step 36: Deeprock Salt (Horde)
	-- {item:8150} Deeprock Salt
	["{item:8150} (Horde)"] = "{item:8150} (Horda)",
	-- {npc:11746} Desert Rumbler
	["{npc:11746} (level 56-58) drop it here. The Auction House works too."] = "Cada {npc:11746} (nivel 56-58) puede soltarlo aquí. También sirve la casa de subastas.",

	-- Step 37: Thick Hide (Alliance)
	-- {item:8169} Thick Hide
	["{item:8169} (Alliance)"] = "{item:8169} (Alianza)",

	-- Step 38: Thick Hide (Horde)
	-- {item:8169} Thick Hide
	["{item:8169} (Horde)"] = "{item:8169} (Horda)",

	-- Step 39: Leatherworking materials for 150-225
	-- {skill:165} Leatherworking
	["{skill:165} materials for 150-225"] = "Materiales de {skill:165} para 150-225",
	-- {skill:171} Alchemy · {spell:3188} Elixir of Ogre Strength
	["{skill:171}: {spell:3188} (or the Auction House)"] = "{skill:171}: {spell:3188} (o la casa de subastas)",
	-- {skill:171} Alchemy · {item:3389} Elixir of Defense
	["{skill:171}: {item:3389} (or the Auction House)"] = "{skill:171}: {item:3389} (o la casa de subastas)",
	-- {skill:333} Enchanting
	["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}: desencanta equipo poco común (verde) (o la casa de subastas)",

	-- Step 40: Mystic Heavy Armor Kit to 170
	-- {item:252452} Mystic Heavy Armor Kit
	["{item:252452} to 170"] = "{item:252452} hasta 170",
	["Orange (a point every craft) until 155, yellow until 165, green until 175."] = "Naranja (un punto con cada fabricación) hasta 155, amarillo hasta 165 y verde hasta 175.",
	["from the recipe in your bags"] = "con la receta de tus bolsas",

	-- Step 41: Leatherworking recipes at 170
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 170"] = "Recetas de {skill:165} a 170",
	-- {skill:165} Leatherworking · {spell:7151} Barbaric Shoulders
	["Back to a {skill:165} trainer: {spell:7151} is taught from {skill:165} 170."] = "Vuelve con un instructor de {skill:165}: {spell:7151} se enseña desde {skill:165} 170.",

	-- Step 42: Barbaric Shoulders to 175
	-- {item:5964} Barbaric Shoulders
	["{item:5964} to 175"] = "{item:5964} hasta 175",
	["Yellow until 180, green until 190: not every craft gives a point."] = "Amarillo hasta 180 y verde hasta 190: no todas las fabricaciones dan un punto.",

	-- Step 43: Leatherworking recipes at 175
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 175"] = "Recetas de {skill:165} a 175",
	-- {skill:165} Leatherworking · {spell:3776} Green Leather Bracers
	["Back to a {skill:165} trainer: {spell:3776} is taught from {skill:165} 175."] = "Vuelve con un instructor de {skill:165}: {spell:3776} se enseña desde {skill:165} 175.",

	-- Step 44: Green Leather Bracers to 185
	-- {spell:3776} Green Leather Bracers
	["{spell:3776} to 185"] = "{spell:3776} hasta 185",
	["Yellow until 185, green until 195: not every craft gives a point."] = "Amarillo hasta 185 y verde hasta 195: no todas las fabricaciones dan un punto.",

	-- Step 45: Leatherworking recipes at 185
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 185"] = "Recetas de {skill:165} a 185",
	-- {skill:165} Leatherworking · {spell:7156} Guardian Gloves
	["Back to a {skill:165} trainer: {spell:7156} is taught from {skill:165} 185."] = "Vuelve con un instructor de {skill:165}: {spell:7156} se enseña desde {skill:165} 185.",

	-- Step 46: Guardian Gloves to 195
	-- {item:5966} Guardian Gloves
	["{item:5966} to 195"] = "{item:5966} hasta 195",
	["Yellow until 195, green until 205: not every craft gives a point."] = "Amarillo hasta 195 y verde hasta 205: no todas las fabricaciones dan un punto.",

	-- Step 47: Leatherworking recipes at 195
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 195"] = "Recetas de {skill:165} a 195",
	-- {skill:165} Leatherworking · {spell:10487} Thick Armor Kit
	["Back to a {skill:165} trainer: {spell:10487} is taught from {skill:165} 195."] = "Vuelve con un instructor de {skill:165}: {spell:10487} se enseña desde {skill:165} 195.",

	-- Step 48: Forceful Thick Armor Kit to 220
	-- {item:252463} Forceful Thick Armor Kit
	["{item:252463} to 220"] = "{item:252463} hasta 220",
	["Orange (a point every craft) until 205, yellow until 215, green until 225."] = "Naranja (un punto con cada fabricación) hasta 205, amarillo hasta 215 y verde hasta 225.",

	-- Step 49: Leatherworking recipes at 220
	-- {skill:165} Leatherworking
	["{skill:165} recipes at 220"] = "Recetas de {skill:165} a 220",
	-- {skill:165} Leatherworking · {spell:10482} Cured Thick Hide · {spell:14932} Thick Leather Ammo Pouch
	["Back to a {skill:165} trainer: {spell:10482}, {spell:14932} are taught from {skill:165} 220."] = "Vuelve con un instructor de {skill:165}: {spell:10482} y {spell:14932} se enseñan desde {skill:165} 220.",

	-- Step 50: Thick Leather Ammo Pouch to 225
	-- {item:8218} Thick Leather Ammo Pouch
	["{item:8218} to 225"] = "{item:8218} hasta 225",
	-- {skill:165} Leatherworking
	["Yellow until 230, green until 240: not every craft gives a point. {skill:165} 225 is a Legacy System milestone."] = "Amarillo hasta 230 y verde hasta 240: no todas las fabricaciones dan un punto. {skill:165} 225 es un hito del sistema de Legado.",

	-- Step 51: Artisan Leatherworking
	-- {skill:165} Leatherworking
	["Artisan {skill:165}"] = "{skill:165} de artesano",
	-- {skill:165} Leatherworking
	["Artisan needs character level 35 and {skill:165} 200; it raises the cap to 300. Materials for 225-300 are worth about 312g in all."] = "Artesano requiere nivel de personaje 35 y {skill:165} 200; sube el límite a 300. Los materiales de 225 a 300 cuestan en total unos 312 o.",

	-- Step 52: Pattern: Wicked Leather Gauntlets
	-- {item:15083} Wicked Leather Gauntlets · {skill:165} Leatherworking
	["Teaches {item:15083} (needs {skill:165} 235). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Enseña {item:15083} (requiere {skill:165} 235). Los mercaderes lo venden en existencias limitadas que se reponen; la casa de subastas también suele tenerlo.",

	-- Step 53: Pattern: Runic Leather Headband
	-- {item:15094} Runic Leather Headband · {skill:165} Leatherworking
	["Teaches {item:15094} (needs {skill:165} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Enseña {item:15094} (requiere {skill:165} 265). Los mercaderes lo venden en existencias limitadas que se reponen; la casa de subastas también suele tenerlo.",

	-- Step 54: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Alianza)",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:1815}, {npc:1816}, {npc:1817} aquí (las bestias de nivel 48-60 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",

	-- Step 55: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horda)",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} aquí (las bestias de nivel 48-60 lo dan); la guía de {skill:393} marca la ruta. También sirve la casa de subastas.",

	-- Step 56: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Alianza)",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Cada {npc:7027} (nivel 56-57) puede soltarlo aquí. También sirve la casa de subastas.",

	-- Step 57: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horda)",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Cada {npc:6189} (nivel 51-52) puede soltarlo aquí. También sirve la casa de subastas.",

	-- Step 58: Rugged Armor Kit to 236
	-- {item:15564} Rugged Armor Kit
	["{item:15564} to 236"] = "{item:15564} hasta 236",
	["Yellow until 235, green until 245: not every craft gives a point."] = "Amarillo hasta 235 y verde hasta 245: no todas las fabricaciones dan un punto.",

	-- Step 59: Wicked Leather Gauntlets to 267
	-- {item:15083} Wicked Leather Gauntlets
	["{item:15083} to 267"] = "{item:15083} hasta 267",
	["Orange (a point every craft) until 255, yellow until 265, green until 275."] = "Naranja (un punto con cada fabricación) hasta 255, amarillo hasta 265 y verde hasta 275.",

	-- Step 60: Runic Leather Headband to 300
	-- {item:15094} Runic Leather Headband
	["{item:15094} to 300"] = "{item:15094} hasta 300",
	-- {skill:165} Leatherworking
	["Orange (a point every craft) until 285, yellow until 295, green until 305. {skill:165} 300 is a Legacy System milestone."] = "Naranja (un punto con cada fabricación) hasta 285, amarillo hasta 295 y verde hasta 305. {skill:165} 300 es un hito del sistema de Legado.",
}
