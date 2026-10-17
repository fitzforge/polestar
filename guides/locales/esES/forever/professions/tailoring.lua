-- Spanish (Spain) (esES): the guide forever/professions/tailoring (forever/professions/tailoring.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Tailoring
	-- {skill:197} Tailoring
	["Apprentice {skill:197}"] = "{skill:197} de aprendiz",
	-- {skill:197} Tailoring
	["{skill:197} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 8s in all."] = "{skill:197} se sube a la vez que subes de nivel. El Sistema de legado de Forever recompensa las profesiones de fabricación con 150, 225 y 300 de habilidad (los topes de oficial, experto y artesano), así que cada uno de esos hitos cuenta. Los materiales para 1-75 valen unos 1g 8s en total.",

	-- Step 2: Linen Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Mata a los enemigos que lo sueltan en el punto de farmeo que Polestar elige para tu nivel y facción. También puedes comprarlo en la casa de subastas.",

	-- Step 3: Simple Linen Pants to 50
	-- {item:10045} Simple Linen Pants
	["{item:10045} to 50"] = "{item:10045} hasta 50",
	["Orange (a point every craft) until 40, yellow until 50, green until 60."] = "Naranja (un punto por cada fabricación) hasta 40, amarillo hasta 50, verde hasta 60.",

	-- Step 4: Tailoring recipes at 50
	-- {skill:197} Tailoring
	["{skill:197} recipes at 50"] = "Recetas de {skill:197} a 50",
	-- {skill:197} Tailoring · {spell:8776} Linen Belt
	["Back to a {skill:197} trainer: {spell:8776} is taught from {skill:197} 50."] = "Vuelve a un instructor de {skill:197}: {spell:8776} se aprende a partir de {skill:197} 50.",

	-- Step 5: Linen Belt to 75
	-- {item:7026} Linen Belt
	["{item:7026} to 75"] = "{item:7026} hasta 75",
	["Yellow until 67, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "Amarillo hasta 67, verde hasta 85: no todas las fabricaciones dan punto. 75 es el tope de aprendiz.",

	-- Step 6: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "{skill:197} de oficial",
	-- {skill:197} Tailoring
	["Journeyman needs character level 10 and {skill:197} 50; it raises the cap to 150. Materials for 75-150 are worth about 17g in all."] = "Oficial requiere nivel de personaje 10 y {skill:197} 50; sube el tope a 150. Los materiales para 75-150 valen unos 17g en total.",

	-- Step 8: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (Alianza)",
	-- {npc:98} Riverpaw Taskmaster
	["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "Lo suelta {npc:98} (nivel 17-18) de aquí. También puedes comprarlo en la casa de subastas.",

	-- Step 9: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (Horda)",
	-- {npc:3263} Bristleback Geomancer
	["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "Lo suelta {npc:3263} (nivel 19-20) de aquí. También puedes comprarlo en la casa de subastas.",

	-- Step 10: Tailoring materials for 75-150
	-- {skill:197} Tailoring
	["{skill:197} materials for 75-150"] = "Materiales de {skill:197} para 75-150",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "Se obtienen despellejando, desencantando o con otra profesión: consíguelos tú o cómpralos en la casa de subastas.",
	-- {skill:171} Alchemy · {item:3383} Elixir of Wisdom
	["{skill:171}: {item:3383} (or the Auction House)"] = "{skill:171}: {item:3383} (o cómpralo en la casa de subastas)",

	-- Step 11: Linen Belt to 80
	-- {item:7026} Linen Belt
	["{item:7026} to 80"] = "{item:7026} hasta 80",
	["Yellow until 67, green until 85: not every craft gives a point."] = "Amarillo hasta 67, verde hasta 85: no todas las fabricaciones dan punto.",

	-- Step 12: Tailoring recipes at 80
	-- {skill:197} Tailoring
	["{skill:197} recipes at 80"] = "Recetas de {skill:197} a 80",
	-- {skill:197} Tailoring · {spell:2402} Woolen Cape
	["Back to a {skill:197} trainer: {spell:2402} is taught from {skill:197} 80."] = "Vuelve a un instructor de {skill:197}: {spell:2402} se aprende a partir de {skill:197} 80.",

	-- Step 13: Woolen Cape to 110
	-- {spell:2402} Woolen Cape
	["{spell:2402} to 110"] = "{spell:2402} hasta 110",
	["Yellow until 97, green until 115: not every craft gives a point."] = "Amarillo hasta 97, verde hasta 115: no todas las fabricaciones dan punto.",

	-- Step 14: Tailoring recipes at 110
	-- {skill:197} Tailoring
	["{skill:197} recipes at 110"] = "Recetas de {skill:197} a 110",
	-- {skill:197} Tailoring · {spell:3848} Double-stitched Woolen Shoulders
	["Back to a {skill:197} trainer: {spell:3848} is taught from {skill:197} 110."] = "Vuelve a un instructor de {skill:197}: {spell:3848} se aprende a partir de {skill:197} 110.",

	-- Step 15: Double-stitched Woolen Shoulders to 125
	-- {spell:3848} Double-stitched Woolen Shoulders
	["{spell:3848} to 125"] = "{spell:3848} hasta 125",
	["Yellow until 127, green until 145: not every craft gives a point."] = "Amarillo hasta 127, verde hasta 145: no todas las fabricaciones dan punto.",

	-- Step 16: Tailoring recipes at 125
	-- {skill:197} Tailoring
	["{skill:197} recipes at 125"] = "Recetas de {skill:197} a 125",
	-- {skill:197} Tailoring · {spell:3852} Gloves of Meditation
	["Back to a {skill:197} trainer: {spell:3852} is taught from {skill:197} 125."] = "Vuelve a un instructor de {skill:197}: {spell:3852} se aprende a partir de {skill:197} 125.",

	-- Step 17: Gloves of Meditation to 150
	-- {spell:3852} Gloves of Meditation
	["{spell:3852} to 150"] = "{spell:3852} hasta 150",
	-- {skill:197} Tailoring
	["Yellow until 140, green until 155: not every craft gives a point. {skill:197} 150 is a Legacy System milestone."] = "Amarillo hasta 140, verde hasta 155: no todas las fabricaciones dan punto. {skill:197} 150 es un hito del Sistema de legado.",

	-- Step 18: Expert Tailoring
	-- {skill:197} Tailoring
	["Expert {skill:197}"] = "{skill:197} de experto",
	-- {skill:197} Tailoring
	["Expert needs character level 20 and {skill:197} 125; it raises the cap to 225. Materials for 150-225 are worth about 135g in all."] = "Experto requiere nivel de personaje 20 y {skill:197} 125; sube el tope a 225. Los materiales para 150-225 valen unos 135g en total.",

	-- Step 19: Pattern: Azure Silk Cloak
	-- {item:7053} Azure Silk Cloak · {skill:197} Tailoring
	["Teaches {item:7053} (needs {skill:197} 140). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Enseña {item:7053} (requiere {skill:197} 140). Los mercaderes lo venden en existencias limitadas que se reponen; también suele estar en la casa de subastas.",

	-- Step 21: Mageweave Cloth (Alliance)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Alliance)"] = "{item:4338} (Alianza)",
	-- {npc:6006} Shadowsworn Adept
	["{npc:6006} (level 52-53) drop it here. The Auction House works too."] = "Lo suelta {npc:6006} (nivel 52-53) de aquí. También puedes comprarlo en la casa de subastas.",

	-- Step 22: Mageweave Cloth (Horde)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Horde)"] = "{item:4338} (Horda)",
	-- {npc:5472} Dunemaul Enforcer
	["{npc:5472} (level 46-47) drop it here. The Auction House works too."] = "Lo suelta {npc:5472} (nivel 46-47) de aquí. También puedes comprarlo en la casa de subastas.",

	-- Step 23: Azure Silk Cloak to 180
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 180"] = "{item:7053} hasta 180",
	["Orange (a point every craft) until 160, yellow until 175, green until 190."] = "Naranja (un punto por cada fabricación) hasta 160, amarillo hasta 175, verde hasta 190.",
	["from the recipe in your bags"] = "con la receta de tus bolsas",

	-- Step 24: Tailoring recipes at 180
	-- {skill:197} Tailoring
	["{skill:197} recipes at 180"] = "Recetas de {skill:197} a 180",
	-- {skill:197} Tailoring · {spell:8799} Crimson Silk Pantaloons
	["Back to a {skill:197} trainer: {spell:8799} is taught from {skill:197} 180."] = "Vuelve a un instructor de {skill:197}: {spell:8799} se aprende a partir de {skill:197} 180.",

	-- Step 25: Crimson Silk Pantaloons to 185
	-- {item:7062} Crimson Silk Pantaloons
	["{item:7062} to 185"] = "{item:7062} hasta 185",
	["Yellow until 190, green until 200: not every craft gives a point."] = "Amarillo hasta 190, verde hasta 200: no todas las fabricaciones dan punto.",

	-- Step 26: Tailoring recipes at 185
	-- {skill:197} Tailoring
	["{skill:197} recipes at 185"] = "Recetas de {skill:197} a 185",
	-- {skill:197} Tailoring · {spell:12048} Black Mageweave Vest
	["Back to a {skill:197} trainer: {spell:12048} is taught from {skill:197} 185."] = "Vuelve a un instructor de {skill:197}: {spell:12048} se aprende a partir de {skill:197} 185.",

	-- Step 27: Black Mageweave Vest to 205
	-- {item:9998} Black Mageweave Vest
	["{item:9998} to 205"] = "{item:9998} hasta 205",
	["Yellow until 200, green until 215: not every craft gives a point."] = "Amarillo hasta 200, verde hasta 215: no todas las fabricaciones dan punto.",

	-- Step 28: Tailoring recipes at 205
	-- {skill:197} Tailoring
	["{skill:197} recipes at 205"] = "Recetas de {skill:197} a 205",
	-- {skill:197} Tailoring · {spell:12072} Black Mageweave Headband
	["Back to a {skill:197} trainer: {spell:12072} is taught from {skill:197} 205."] = "Vuelve a un instructor de {skill:197}: {spell:12072} se aprende a partir de {skill:197} 205.",

	-- Step 29: Black Mageweave Headband to 225
	-- {item:10024} Black Mageweave Headband
	["{item:10024} to 225"] = "{item:10024} hasta 225",
	-- {skill:197} Tailoring
	["Yellow until 220, green until 235: not every craft gives a point. {skill:197} 225 is a Legacy System milestone."] = "Amarillo hasta 220, verde hasta 235: no todas las fabricaciones dan punto. {skill:197} 225 es un hito del Sistema de legado.",

	-- Step 30: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "{skill:197} de artesano",
	-- {skill:197} Tailoring
	["Artisan needs character level 35 and {skill:197} 200; it raises the cap to 300. Materials for 225-300 are worth about 845g in all."] = "Artesano requiere nivel de personaje 35 y {skill:197} 200; sube el tope a 300. Los materiales para 225-300 valen unos 845g en total.",

	-- Step 31: Pattern: Runecloth Gloves
	-- {item:13863} Runecloth Gloves · {skill:197} Tailoring
	["Teaches {item:13863} (needs {skill:197} 230). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Enseña {item:13863} (requiere {skill:197} 230). Los mercaderes lo venden en existencias limitadas que se reponen; también suele estar en la casa de subastas.",

	-- Step 32: Pattern: Runecloth Cuffs
	-- {item:254123} Runecloth Cuffs · {skill:197} Tailoring
	["Teaches {item:254123} (needs {skill:197} 250)."] = "Enseña {item:254123} (requiere {skill:197} 250).",

	-- Step 33: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (Alianza)",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja aquí a {npc:1815}, {npc:1816} y {npc:1817} (lo dan las bestias de nivel 48-60); la guía de {skill:393} tiene la ruta. También puedes comprarlo en la casa de subastas.",

	-- Step 34: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (Horda)",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "Despelleja aquí a {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} y {npc:6377} (lo dan las bestias de nivel 48-60); la guía de {skill:393} tiene la ruta. También puedes comprarlo en la casa de subastas.",

	-- Step 35: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (Alianza)",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "Lo suelta {npc:7027} (nivel 56-57) de aquí. También puedes comprarlo en la casa de subastas.",

	-- Step 36: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (Horda)",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "Lo suelta {npc:6189} (nivel 51-52) de aquí. También puedes comprarlo en la casa de subastas.",

	-- Step 37: Ironweb Spider Silk (Alliance)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Alliance)"] = "{item:14227} (Alianza)",
	-- {npc:1824} Plague Lurker
	["{npc:1824} (level 54-55) drop it here. The Auction House works too."] = "Lo suelta {npc:1824} (nivel 54-55) de aquí. También puedes comprarlo en la casa de subastas.",

	-- Step 38: Ironweb Spider Silk (Horde)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Horde)"] = "{item:14227} (Horda)",
	-- {npc:11739} Rock Stalker
	["{npc:11739} (level 57-59) drop it here. The Auction House works too."] = "Lo suelta {npc:11739} (nivel 57-59) de aquí. También puedes comprarlo en la casa de subastas.",

	-- Step 39: Runecloth Belt to 236
	-- {item:13856} Runecloth Belt
	["{item:13856} to 236"] = "{item:13856} hasta 236",
	["Yellow until 240, green until 255: not every craft gives a point."] = "Amarillo hasta 240, verde hasta 255: no todas las fabricaciones dan punto.",

	-- Step 40: Runecloth Gloves to 251
	-- {item:13863} Runecloth Gloves
	["{item:13863} to 251"] = "{item:13863} hasta 251",
	["Orange (a point every craft) until 245, yellow until 260, green until 275."] = "Naranja (un punto por cada fabricación) hasta 245, amarillo hasta 260, verde hasta 275.",

	-- Step 41: Runecloth Cuffs to 295
	-- {item:254123} Runecloth Cuffs
	["{item:254123} to 295"] = "{item:254123} hasta 295",
	["Orange (a point every craft) until 265, yellow until 280, green until 295."] = "Naranja (un punto por cada fabricación) hasta 265, amarillo hasta 280, verde hasta 295.",

	-- Step 42: Tailoring 295-300
	-- {skill:197} Tailoring · {item:14342} Mooncloth · {item:14137} Mooncloth Leggings · {item:279943} Spinning Wheel · {item:14155} Mooncloth Bag · {item:14128} Wizardweave Robe · {item:19047} Wisdom of the Timbermaw
	["On Forever no recipe a trainer teaches or both factions' vendors sell gives {skill:197} points past 295, so Polestar has no route for the last points. Recipes that still do: {item:14342} (needs a Moonwell), {item:14137} (needs a {item:279943}), {item:14155} (recipe is a drop), {item:14128} (recipe is a drop), {item:19047} (needs a {item:279943})."] = "En Forever ninguna receta que enseñe un instructor o vendan los mercaderes de ambas facciones da puntos de {skill:197} más allá de 295, así que Polestar no tiene ruta para los últimos puntos. Recetas que aún los dan: {item:14342} (requiere una Poza de la Luna), {item:14137} (requiere una {item:279943}), {item:14155} (la receta es un botín), {item:14128} (la receta es un botín), {item:19047} (requiere una {item:279943}).",
}
