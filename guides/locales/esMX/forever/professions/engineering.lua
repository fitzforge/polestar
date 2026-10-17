-- Spanish (Latin America) (esMX): the guide forever/professions/engineering (forever/professions/engineering.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Engineering
	-- {skill:202} Engineering
	["Apprentice {skill:202}"] = "Aprendiz de {skill:202}",
	-- {skill:202} Engineering
	["{skill:202} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 62s in all."] = "{skill:202} avanza junto con la subida de nivel. El Sistema de Legado de Forever recompensa las profesiones de fabricación con habilidad 150, 225 y 300 (los límites de Oficial, Experto y Artesano), así que cada uno de esos hitos cuenta. Los materiales para 1-75 valen unos 62s en total.",
	-- {item:5956} Blacksmith Hammer
	["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: una herramienta, guárdala en tus bolsas",

	-- Step 2: Linen Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Mata a los enemigos que lo sueltan en el lugar de farmeo que Polestar elige para tu nivel y facción. También sirve la casa de subastas.",

	-- Step 3: Rough Stone (Alliance)
	-- {item:2835} Rough Stone
	["{item:2835} (Alliance)"] = "{item:2835} (Alianza)",
	-- {item:2835} Rough Stone · {object:1731} Copper Vein · {skill:186} Mining
	["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835} se obtiene de nodos de {object:1731} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",

	-- Step 4: Rough Stone (Horde)
	-- {item:2835} Rough Stone
	["{item:2835} (Horde)"] = "{item:2835} (Horda)",

	-- Step 5: Engineering materials for 1-75
	-- {skill:202} Engineering
	["{skill:202} materials for 1-75"] = "Materiales de {skill:202} para 1-75",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Se obtienen despellejando, desencantando o con otra profesión: consíguelos tú mismo o cómpralos en la casa de subastas.",
	-- {skill:186} Mining · {item:2770} Copper Ore
	["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: funde {item:2770} (o la casa de subastas)",

	-- Step 6: Rough Blasting Powder to 37
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 37"] = "{spell:3918} hasta 37",
	["Orange (a point every craft) until 20, yellow until 30, green until 40."] = "Naranja (un punto por creación) hasta 20, amarillo hasta 30, verde hasta 40.",

	-- Step 7: Crafted Light Shot to 45
	-- {spell:3920} Crafted Light Shot
	["{spell:3920} to 45"] = "{spell:3920} hasta 45",
	["Yellow until 45, green until 60: not every craft gives a point."] = "Amarillo hasta 45, verde hasta 60: no todas las creaciones dan un punto.",

	-- Step 8: Engineering recipes at 45
	-- {skill:202} Engineering
	["{skill:202} recipes at 45"] = "Recetas de {skill:202} a 45",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts
	["Back to an {skill:202} trainer: {spell:3922} is taught from {skill:202} 45."] = "Vuelve con un instructor de {skill:202}: {spell:3922} se enseña a partir de {skill:202} 45.",

	-- Step 9: Handful of Copper Bolts to 60
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 60"] = "{spell:3922} hasta 60",
	["Yellow until 52, green until 60: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 52, verde hasta 60: no todas las creaciones dan un punto. Requiere un yunque cerca.",

	-- Step 10: Engineering recipes at 60
	-- {skill:202} Engineering
	["{skill:202} recipes at 60"] = "Recetas de {skill:202} a 60",
	-- {skill:202} Engineering · {spell:3923} Rough Copper Bomb
	["Back to an {skill:202} trainer: {spell:3923} is taught from {skill:202} 60."] = "Vuelve con un instructor de {skill:202}: {spell:3923} se enseña a partir de {skill:202} 60.",

	-- Step 11: Rough Copper Bomb to 75
	-- {spell:3923} Rough Copper Bomb
	["{spell:3923} to 75"] = "{spell:3923} hasta 75",
	["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby. 75 is the Apprentice cap."] = "Amarillo hasta 75, verde hasta 90: no todas las creaciones dan un punto. Requiere un yunque cerca. 75 es el límite de Aprendiz.",

	-- Step 12: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "{skill:202} de oficial",
	-- {skill:202} Engineering
	["Journeyman needs character level 10 and {skill:202} 50; it raises the cap to 150. Materials for 75-150 are worth about 3g 23s in all."] = "Oficial requiere nivel de personaje 10 y {skill:202} 50; sube el límite a 150. Los materiales para 75-150 valen unos 3g 23s en total.",

	-- Step 14: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (Alianza)",
	-- {npc:98} Riverpaw Taskmaster
	["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "{npc:98} (nivel 17-18) lo sueltan aquí. También sirve la casa de subastas.",

	-- Step 15: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (Horda)",
	-- {npc:3263} Bristleback Geomancer
	["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "{npc:3263} (nivel 19-20) lo sueltan aquí. También sirve la casa de subastas.",

	-- Step 18: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (Alianza)",
	-- {item:2836} Coarse Stone · {object:1732} Tin Vein · {skill:186} Mining
	["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836} se obtiene de nodos de {object:1732} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",

	-- Step 19: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (Horda)",

	-- Step 20: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (Alianza)",
	-- {item:2838} Heavy Stone · {object:1735} Iron Deposit · {skill:186} Mining
	["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838} se obtiene de nodos de {object:1735} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",

	-- Step 21: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (Horda)",

	-- Step 22: Engineering materials for 75-150
	-- {skill:202} Engineering
	["{skill:202} materials for 75-150"] = "Materiales de {skill:202} para 75-150",
	-- {skill:186} Mining · {item:2840} Copper Bar
	["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: funde {item:2840} (o la casa de subastas)",

	-- Step 23: Rough Copper Bomb to 80
	-- {spell:3923} Rough Copper Bomb
	["{spell:3923} to 80"] = "{spell:3923} hasta 80",
	["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 75, verde hasta 90: no todas las creaciones dan un punto. Requiere un yunque cerca.",

	-- Step 24: Engineering recipes at 80
	-- {skill:202} Engineering
	["{skill:202} recipes at 80"] = "Recetas de {skill:202} a 80",
	-- {skill:202} Engineering · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:3924} is taught from {skill:202} 80."] = "Vuelve con un instructor de {skill:202}: {spell:3924} se enseña a partir de {skill:202} 80.",

	-- Step 25: Copper Tube to 85
	-- {spell:3924} Copper Tube
	["{spell:3924} to 85"] = "{spell:3924} hasta 85",
	["Yellow until 95, green until 110: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 95, verde hasta 110: no todas las creaciones dan un punto. Requiere un yunque cerca.",

	-- Step 26: Engineering recipes at 85
	-- {skill:202} Engineering
	["{skill:202} recipes at 85"] = "Recetas de {skill:202} a 85",
	-- {skill:202} Engineering · {spell:3929} Coarse Blasting Powder
	["Back to an {skill:202} trainer: {spell:3929} is taught from {skill:202} 85."] = "Vuelve con un instructor de {skill:202}: {spell:3929} se enseña a partir de {skill:202} 85.",

	-- Step 27: Coarse Blasting Powder to 95
	-- {spell:3929} Coarse Blasting Powder
	["{spell:3929} to 95"] = "{spell:3929} hasta 95",
	["Yellow until 90, green until 95: not every craft gives a point."] = "Amarillo hasta 90, verde hasta 95: no todas las creaciones dan un punto.",

	-- Step 28: Engineering recipes at 95
	-- {skill:202} Engineering
	["{skill:202} recipes at 95"] = "Recetas de {skill:202} a 95",
	-- {skill:202} Engineering · {spell:3926} Copper Modulator
	["Back to an {skill:202} trainer: {spell:3926} is taught from {skill:202} 95."] = "Vuelve con un instructor de {skill:202}: {spell:3926} se enseña a partir de {skill:202} 95.",

	-- Step 29: Copper Modulator to 111
	-- {spell:3926} Copper Modulator
	["{spell:3926} to 111"] = "{spell:3926} hasta 111",
	["Yellow until 110, green until 125: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 110, verde hasta 125: no todas las creaciones dan un punto. Requiere un yunque cerca.",
	["a tool: keep it in your bags"] = "una herramienta: guárdala en tus bolsas",

	-- Step 30: Engineering recipes at 111
	-- {skill:202} Engineering
	["{skill:202} recipes at 111"] = "Recetas de {skill:202} a 111",
	-- {skill:202} Engineering · {spell:3937} Large Copper Bomb
	["Back to an {skill:202} trainer: {spell:3937} is taught from {skill:202} 105."] = "Vuelve con un instructor de {skill:202}: {spell:3937} se enseña a partir de {skill:202} 105.",

	-- Step 31: Large Copper Bomb to 125
	-- {spell:3937} Large Copper Bomb
	["{spell:3937} to 125"] = "{spell:3937} hasta 125",
	["Yellow until 130, green until 155: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 130, verde hasta 155: no todas las creaciones dan un punto. Requiere un yunque cerca.",

	-- Step 32: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "Recetas de {skill:202} a 125",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} is taught from {skill:202} 125."] = "Vuelve con un instructor de {skill:202}: {spell:3945} se enseña a partir de {skill:202} 125.",

	-- Step 33: Heavy Blasting Powder to 139
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 139"] = "{spell:3945} hasta 139",
	["Yellow until 135, green until 145: not every craft gives a point."] = "Amarillo hasta 135, verde hasta 145: no todas las creaciones dan un punto.",

	-- Step 34: Engineering recipes at 139
	-- {skill:202} Engineering
	["{skill:202} recipes at 139"] = "Recetas de {skill:202} a 139",
	-- {skill:202} Engineering · {spell:3942} Whirring Bronze Gizmo
	["Back to an {skill:202} trainer: {spell:3942} is taught from {skill:202} 125."] = "Vuelve con un instructor de {skill:202}: {spell:3942} se enseña a partir de {skill:202} 125.",

	-- Step 35: Whirring Bronze Gizmo to 150
	-- {spell:3942} Whirring Bronze Gizmo
	["{spell:3942} to 150"] = "{spell:3942} hasta 150",
	-- {skill:202} Engineering
	["Yellow until 150, green until 175: not every craft gives a point. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "Amarillo hasta 150, verde hasta 175: no todas las creaciones dan un punto. Requiere un yunque cerca. {skill:202} 150 es un hito del Sistema de Legado.",

	-- Step 36: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "Experto de {skill:202}",
	-- {skill:202} Engineering
	["Expert needs character level 20 and {skill:202} 125; it raises the cap to 225. Materials for 150-225 are worth about 15g in all."] = "Experto requiere nivel de personaje 20 y {skill:202} 125; sube el límite a 225. Los materiales para 150-225 valen unos 15g en total.",

	-- Step 37: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (Alianza)",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despella a {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Quijaforte, {npc:2384}, {npc:2354} aquí (las bestias de nivel 18-30 lo dan); la guía de {skill:393} traza esta ruta. También sirve la casa de subastas.",

	-- Step 38: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (Horda)",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despella a {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} aquí (las bestias de nivel 18-30 lo dan); la guía de {skill:393} traza esta ruta. También sirve la casa de subastas.",

	-- Step 40: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (Alianza)",
	-- {item:7912} Solid Stone · {object:2040} Mithril Deposit · {skill:186} Mining
	["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912} se obtiene de nodos de {object:2040} ({skill:186}); este es el grupo más denso según los datos. También sirve la casa de subastas.",

	-- Step 41: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (Horda)",

	-- Step 42: Engineering materials for 150-225
	-- {skill:202} Engineering
	["{skill:202} materials for 150-225"] = "Materiales de {skill:202} para 150-225",
	-- {skill:186} Mining · {item:3575} Iron Bar
	["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: funde {item:3575} (o la casa de subastas)",
	-- {skill:186} Mining · {item:3858} Mithril Ore
	["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: funde {item:3858} (o la casa de subastas)",

	-- Step 43: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "{spell:3953} hasta 175",
	["Yellow until 170, green until 195: not every craft gives a point."] = "Amarillo hasta 170, verde hasta 195: no todas las creaciones dan un punto.",

	-- Step 44: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "Recetas de {skill:202} a 175",
	-- {skill:202} Engineering · {spell:12590} Gyromatic Micro-Adjustor
	["Back to an {skill:202} trainer: {spell:12590} is taught from {skill:202} 175."] = "Vuelve con un instructor de {skill:202}: {spell:12590} se enseña a partir de {skill:202} 175.",

	-- Step 45: Gyromatic Micro-Adjustor to 210
	-- {item:10498} Gyromatic Micro-Adjustor
	["{item:10498} to 210"] = "{item:10498} hasta 210",
	["Yellow until 195, green until 215: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 195, verde hasta 215: no todas las creaciones dan un punto. Requiere un yunque cerca.",

	-- Step 46: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "Recetas de {skill:202} a 210",
	-- {skill:202} Engineering · {spell:12585} Solid Blasting Powder · {spell:12596} Hi-Impact Mithril Slugs
	["Back to an {skill:202} trainer: {spell:12585}, {spell:12596} are taught from {skill:202} 210."] = "Vuelve con un instructor de {skill:202}: {spell:12585}, {spell:12596} se enseñan a partir de {skill:202} 210.",

	-- Step 47: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "{item:10512} hasta 225",
	-- {skill:202} Engineering
	["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "Amarillo hasta 230, verde hasta 250: no todas las creaciones dan un punto. Requiere un yunque cerca. {skill:202} 225 es un hito del Sistema de Legado.",

	-- Step 48: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "Artesano de {skill:202}",
	-- {skill:202} Engineering
	["Artisan needs character level 35 and {skill:202} 200; it raises the cap to 300. Materials for 225-300 are worth about 67g in all."] = "Artesano requiere nivel de personaje 35 y {skill:202} 200; sube el límite a 300. Los materiales para 225-300 valen unos 67g en total.",

	-- Step 49: Schematic: Thorium Widget
	-- {item:15994} Thorium Widget · {skill:202} Engineering
	["Teaches {item:15994} (needs {skill:202} 260). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Enseña {item:15994} (requiere {skill:202} 260). Los mercaderes lo venden en existencias limitadas que se reponen; la casa de subastas también suele tenerlo.",

	-- Step 50: Schematic: Thorium Tube
	-- {item:16000} Thorium Tube · {skill:202} Engineering
	["Teaches {item:16000} (needs {skill:202} 275). Vendors sell it in limited stock that restocks."] = "Enseña {item:16000} (requiere {skill:202} 275). Los mercaderes lo venden en existencias limitadas que se reponen.",

	-- Step 53: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Alianza)",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "{npc:7027} (nivel 56-57) lo sueltan aquí. También sirve la casa de subastas.",

	-- Step 54: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horda)",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "{npc:6189} (nivel 51-52) lo sueltan aquí. También sirve la casa de subastas.",

	-- Step 55: Engineering materials for 225-300
	-- {skill:202} Engineering
	["{skill:202} materials for 225-300"] = "Materiales de {skill:202} para 225-300",
	-- {skill:186} Mining · {item:10620} Thorium Ore
	["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: funde {item:10620} (o la casa de subastas)",

	-- Step 56: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "{item:10512} hasta 245",
	["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 230, verde hasta 250: no todas las creaciones dan un punto. Requiere un yunque cerca.",

	-- Step 57: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "Recetas de {skill:202} a 245",
	-- {skill:202} Engineering · {spell:12621} Mithril Gyro-Shot
	["Back to an {skill:202} trainer: {spell:12621} is taught from {skill:202} 245."] = "Vuelve con un instructor de {skill:202}: {spell:12621} se enseña a partir de {skill:202} 245.",

	-- Step 58: Mithril Gyro-Shot to 264
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 264"] = "{item:10513} hasta 264",
	["Yellow until 265, green until 285: not every craft gives a point. Needs an anvil nearby."] = "Amarillo hasta 265, verde hasta 285: no todas las creaciones dan un punto. Requiere un yunque cerca.",

	-- Step 59: Thorium Widget to 288
	-- {item:15994} Thorium Widget
	["{item:15994} to 288"] = "{item:15994} hasta 288",
	["Orange (a point every craft) until 280, yellow until 290, green until 300. Needs an anvil nearby."] = "Naranja (un punto por creación) hasta 280, amarillo hasta 290, verde hasta 300. Requiere un yunque cerca.",
	["from the recipe in your bags"] = "con la receta de tus bolsas",

	-- Step 60: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "{item:16000} hasta 300",
	-- {skill:202} Engineering
	["Orange (a point every craft) until 295, yellow until 305, green until 315. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "Naranja (un punto por creación) hasta 295, amarillo hasta 305, verde hasta 315. Requiere un yunque cerca. {skill:202} 300 es un hito del Sistema de Legado.",
}
