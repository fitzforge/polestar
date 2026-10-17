-- Spanish (Latin America) (esMX): the guide forever/professions/alchemy (forever/professions/alchemy.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Alchemy
	-- {skill:171} Alchemy
	["Apprentice {skill:171}"] = "Aprendiz de {skill:171}",
	-- {skill:171} Alchemy
	["{skill:171} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 68s in all."] = "{skill:171} avanza junto con la subida de nivel. El Sistema de Legado de Forever recompensa las profesiones de fabricación con habilidad 150, 225 y 300 (los límites de Oficial, Experto y Artesano), así que cada uno de esos hitos cuenta. Los materiales para 1-75 valen unos 68s en total.",

	-- Step 2: Silverleaf (Alliance)
	-- {item:765} Silverleaf
	["{item:765} (Alliance)"] = "{item:765} (Alianza)",
	-- {item:765} Silverleaf · {skill:182} Herbalism
	["Pick {item:765} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {item:765} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",

	-- Step 3: Silverleaf (Horde)
	-- {item:765} Silverleaf
	["{item:765} (Horde)"] = "{item:765} (Horda)",

	-- Step 4: Peacebloom (Alliance)
	-- {item:2447} Peacebloom
	["{item:2447} (Alliance)"] = "{item:2447} (Alianza)",
	-- {item:2447} Peacebloom · {skill:182} Herbalism
	["Pick {item:2447} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {item:2447} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",

	-- Step 5: Peacebloom (Horde)
	-- {item:2447} Peacebloom
	["{item:2447} (Horde)"] = "{item:2447} (Horda)",

	-- Step 6: Elixir of Minor Defense to 75
	-- {item:5997} Elixir of Minor Defense
	["{item:5997} to 75"] = "{item:5997} hasta 75",
	["Orange (a point every craft) until 55, yellow until 75, green until 95. 75 is the Apprentice cap."] = "Naranja (un punto por creación) hasta 55, amarillo hasta 75, verde hasta 95. 75 es el límite de Aprendiz.",

	-- Step 7: Journeyman Alchemy
	-- {skill:171} Alchemy
	["Journeyman {skill:171}"] = "Oficial de {skill:171}",
	-- {skill:171} Alchemy
	["Journeyman needs character level 10 and {skill:171} 50; it raises the cap to 150. Materials for 75-150 are worth about 1g 44s in all."] = "Oficial requiere nivel de personaje 10 y {skill:171} 50; sube el límite a 150. Los materiales para 75-150 valen unos 1g 44s en total.",

	-- Step 8: Recipe: Holy Protection Potion
	-- {item:6051} Holy Protection Potion · {skill:171} Alchemy
	["Teaches {item:6051} (needs {skill:171} 100). Vendors sell it in limited stock that restocks."] = "Enseña {item:6051} (requiere {skill:171} 100). Los mercaderes lo venden en existencias limitadas que se reponen.",

	-- Step 9: Murloc Eye (Alliance)
	-- {item:730} Murloc Eye
	["{item:730} (Alliance)"] = "{item:730} (Alianza)",
	-- {npc:513} Murloc Netter
	["{npc:513} (level 14-15) drop it here. The Auction House works too."] = "{npc:513} (nivel 14-15) lo sueltan aquí. También sirve la casa de subastas.",

	-- Step 10: Murloc Eye (Horde)
	-- {item:730} Murloc Eye
	["{item:730} (Horde)"] = "{item:730} (Horda)",
	-- {npc:1958} Vile Fin Tidecaller
	["{npc:1958} (level 17-18) drop it here. The Auction House works too."] = "{npc:1958} (nivel 17-18) lo sueltan aquí. También sirve la casa de subastas.",

	-- Step 11: Mageroyal (Alliance)
	-- {item:785} Mageroyal
	["{item:785} (Alliance)"] = "{item:785} (Alianza)",
	-- {item:785} Mageroyal · {skill:182} Herbalism
	["Pick {item:785} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {item:785} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",

	-- Step 12: Mageroyal (Horde)
	-- {item:785} Mageroyal
	["{item:785} (Horde)"] = "{item:785} (Horda)",

	-- Step 15: Briarthorn (Alliance)
	-- {item:2450} Briarthorn
	["{item:2450} (Alliance)"] = "{item:2450} (Alianza)",
	-- {item:2450} Briarthorn · {skill:182} Herbalism
	["Pick {item:2450} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {item:2450} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",

	-- Step 16: Briarthorn (Horde)
	-- {item:2450} Briarthorn
	["{item:2450} (Horde)"] = "{item:2450} (Horda)",

	-- Step 17: Swiftthistle (Alliance)
	-- {item:2452} Swiftthistle
	["{item:2452} (Alliance)"] = "{item:2452} (Alianza)",
	-- {item:2452} Swiftthistle · {item:2450} Briarthorn · {skill:182} Herbalism
	["{item:2452} comes from {item:2450} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:2452} se obtiene de los nodos de {item:2450} ({skill:182}); esta es la zona más densa según los datos. También sirve la casa de subastas.",

	-- Step 18: Swiftthistle (Horde)
	-- {item:2452} Swiftthistle
	["{item:2452} (Horde)"] = "{item:2452} (Horda)",

	-- Step 19: Bruiseweed (Alliance)
	-- {item:2453} Bruiseweed
	["{item:2453} (Alliance)"] = "{item:2453} (Alianza)",
	-- {item:2453} Bruiseweed · {skill:182} Herbalism
	["Pick {item:2453} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {item:2453} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",

	-- Step 20: Bruiseweed (Horde)
	-- {item:2453} Bruiseweed
	["{item:2453} (Horde)"] = "{item:2453} (Horda)",

	-- Step 21: Minor Mana Potion to 85
	-- {spell:2331} Minor Mana Potion
	["{spell:2331} to 85"] = "{spell:2331} hasta 85",
	["Yellow until 85, green until 105: not every craft gives a point."] = "Amarillo hasta 85, verde hasta 105: no todas las creaciones dan un punto.",

	-- Step 22: Alchemy recipes at 85
	-- {skill:171} Alchemy
	["{skill:171} recipes at 85"] = "Recetas de {skill:171} a 85",
	-- {skill:171} Alchemy · {spell:1244645} Lesser Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244645} is taught from {skill:171} 85."] = "Vuelve con un instructor de {skill:171}: {spell:1244645} se enseña desde {skill:171} 85.",

	-- Step 23: Lesser Discolored Healing Potion to 100
	-- {item:247239} Lesser Discolored Healing Potion
	["{item:247239} to 100"] = "{item:247239} hasta 100",
	["Yellow until 105, green until 125: not every craft gives a point."] = "Amarillo hasta 105, verde hasta 125: no todas las creaciones dan un punto.",

	-- Step 24: Holy Protection Potion to 150
	-- {item:6051} Holy Protection Potion
	["{item:6051} to 150"] = "{item:6051} hasta 150",
	-- {skill:171} Alchemy
	["Orange (a point every craft) until 130, yellow until 150, green until 170. {skill:171} 150 is a Legacy System milestone."] = "Naranja (un punto por creación) hasta 130, amarillo hasta 150, verde hasta 170. {skill:171} 150 es un hito del Sistema de Legado.",
	["from the recipe in your bags"] = "con la receta de tus bolsas",

	-- Step 25: Expert Alchemy
	-- {skill:171} Alchemy
	["Expert {skill:171}"] = "Experto de {skill:171}",
	-- {skill:171} Alchemy
	["Expert needs character level 20 and {skill:171} 125; it raises the cap to 225. Materials for 150-225 are worth about 3g 65s in all."] = "Experto requiere nivel de personaje 20 y {skill:171} 125; sube el límite a 225. Los materiales para 150-225 valen unos 3g 65s en total.",

	-- Step 26: Murloc Eye
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Mata a los enemigos que lo sueltan en el lugar de farmeo que Polestar elige para tu nivel y facción. También sirve la casa de subastas.",

	-- Step 27: Wild Steelbloom (Alliance)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Alliance)"] = "{object:1623} (Alianza)",
	-- {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick {object:1623} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {object:1623} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",

	-- Step 28: Wild Steelbloom (Horde)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Horde)"] = "{object:1623} (Horda)",

	-- Step 29: Kingsblood (Alliance)
	-- {item:3356} Kingsblood
	["{item:3356} (Alliance)"] = "{item:3356} (Alianza)",
	-- {item:3356} Kingsblood · {skill:182} Herbalism
	["Pick {item:3356} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {item:3356} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",

	-- Step 30: Kingsblood (Horde)
	-- {item:3356} Kingsblood
	["{item:3356} (Horde)"] = "{item:3356} (Horda)",

	-- Step 31: Liferoot (Alliance)
	-- {item:3357} Liferoot
	["{item:3357} (Alliance)"] = "{item:3357} (Alianza)",
	-- {item:3357} Liferoot · {skill:182} Herbalism
	["Pick {item:3357} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {item:3357} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",

	-- Step 32: Liferoot (Horde)
	-- {item:3357} Liferoot
	["{item:3357} (Horde)"] = "{item:3357} (Horda)",

	-- Step 33: Goldthorn (Alliance)
	-- {object:2046} Goldthorn
	["{object:2046} (Alliance)"] = "{object:2046} (Alianza)",
	-- {object:2046} Goldthorn · {skill:182} Herbalism
	["Pick {object:2046} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {object:2046} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",

	-- Step 34: Goldthorn (Horde)
	-- {object:2046} Goldthorn
	["{object:2046} (Horde)"] = "{object:2046} (Horda)",

	-- Step 35: Oily Blackmouth (Alliance)
	-- {item:6358} Oily Blackmouth
	["{item:6358} (Alliance)"] = "{item:6358} (Alianza)",
	-- {object:180582} Oily Blackmouth School
	["Fish {object:180582}; this is where the data has most of them. The Auction House works too."] = "Pesca en {object:180582}; aquí es donde los datos registran más. También sirve la casa de subastas.",

	-- Step 36: Oily Blackmouth (Horde)
	-- {item:6358} Oily Blackmouth
	["{item:6358} (Horde)"] = "{item:6358} (Horda)",

	-- Step 37: Firefin Snapper (Alliance)
	-- {item:6359} Firefin Snapper
	["{item:6359} (Alliance)"] = "{item:6359} (Alianza)",
	-- {object:180657} Firefin Snapper School
	["Fish {object:180657}; this is where the data has most of them. The Auction House works too."] = "Pesca en {object:180657}; aquí es donde los datos registran más. También sirve la casa de subastas.",

	-- Step 38: Firefin Snapper (Horde)
	-- {item:6359} Firefin Snapper
	["{item:6359} (Horde)"] = "{item:6359} (Horda)",

	-- Step 39: Fire Oil to 165
	-- {item:6371} Fire Oil
	["{item:6371} to 165"] = "{item:6371} hasta 165",
	["Yellow until 160, green until 170: not every craft gives a point."] = "Amarillo hasta 160, verde hasta 170: no todas las creaciones dan un punto.",

	-- Step 40: Alchemy recipes at 165
	-- {skill:171} Alchemy
	["{skill:171} recipes at 165"] = "Recetas de {skill:171} a 165",
	-- {skill:171} Alchemy · {spell:7845} Elixir of Fire Power
	["Back to an {skill:171} trainer: {spell:7845} is taught from {skill:171} 165."] = "Vuelve con un instructor de {skill:171}: {spell:7845} se enseña desde {skill:171} 165.",

	-- Step 41: Elixir of Fire Power to 175
	-- {spell:7845} Elixir of Fire Power
	["{spell:7845} to 175"] = "{spell:7845} hasta 175",
	["Yellow until 185, green until 205: not every craft gives a point."] = "Amarillo hasta 185, verde hasta 205: no todas las creaciones dan un punto.",

	-- Step 42: Alchemy recipes at 175
	-- {skill:171} Alchemy
	["{skill:171} recipes at 175"] = "Recetas de {skill:171} a 175",
	-- {skill:171} Alchemy · {spell:1244647} Greater Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244647} is taught from {skill:171} 175."] = "Vuelve con un instructor de {skill:171}: {spell:1244647} se enseña desde {skill:171} 175.",

	-- Step 43: Greater Discolored Healing Potion to 200
	-- {item:247241} Greater Discolored Healing Potion
	["{item:247241} to 200"] = "{item:247241} hasta 200",
	["Yellow until 195, green until 215: not every craft gives a point."] = "Amarillo hasta 195, verde hasta 215: no todas las creaciones dan un punto.",

	-- Step 44: Alchemy recipes at 200
	-- {skill:171} Alchemy
	["{skill:171} recipes at 200"] = "Recetas de {skill:171} a 200",
	-- {skill:171} Alchemy · {spell:11447} Draught of Water Walking
	["Back to an {skill:171} trainer: {spell:11447} is taught from {skill:171} 190."] = "Vuelve con un instructor de {skill:171}: {spell:11447} se enseña desde {skill:171} 190.",

	-- Step 45: Draught of Water Walking to 215
	-- {spell:11447} Draught of Water Walking
	["{spell:11447} to 215"] = "{spell:11447} hasta 215",
	["Yellow until 210, green until 230: not every craft gives a point."] = "Amarillo hasta 210, verde hasta 230: no todas las creaciones dan un punto.",

	-- Step 46: Alchemy recipes at 215
	-- {skill:171} Alchemy
	["{skill:171} recipes at 215"] = "Recetas de {skill:171} a 215",
	-- {skill:171} Alchemy · {spell:11450} Elixir of Defense
	["Back to an {skill:171} trainer: {spell:11450} is taught from {skill:171} 215."] = "Vuelve con un instructor de {skill:171}: {spell:11450} se enseña desde {skill:171} 215.",

	-- Step 47: Elixir of Defense to 225
	-- {spell:11450} Elixir of Defense
	["{spell:11450} to 225"] = "{spell:11450} hasta 225",
	-- {skill:171} Alchemy
	["Yellow until 235, green until 255: not every craft gives a point. {skill:171} 225 is a Legacy System milestone."] = "Amarillo hasta 235, verde hasta 255: no todas las creaciones dan un punto. {skill:171} 225 es un hito del Sistema de Legado.",

	-- Step 48: Artisan Alchemy
	-- {skill:171} Alchemy
	["Artisan {skill:171}"] = "Artesano de {skill:171}",
	-- {skill:171} Alchemy
	["Artisan needs character level 35 and {skill:171} 200; it raises the cap to 300. Materials for 225-300 are worth about 7g 80s in all."] = "Artesano requiere nivel de personaje 35 y {skill:171} 200; sube el límite a 300. Los materiales para 225-300 valen unos 7g 80s en total.",

	-- Step 49: Recipe: Elixir of Superior Defense
	-- {item:8951} Elixir of Greater Defense · {skill:171} Alchemy
	["Teaches {item:8951} (needs {skill:171} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Enseña {item:8951} (requiere {skill:171} 265). Los mercaderes lo venden en existencias limitadas que se reponen; la casa de subastas también suele tenerlo.",

	-- Step 55: Arthas' Tears (Alliance)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Alliance)"] = "{item:8836} (Alianza)",
	-- {item:8836} Arthas' Tears · {skill:182} Herbalism
	["Pick {item:8836} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {item:8836} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",

	-- Step 56: Arthas' Tears (Horde)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Horde)"] = "{item:8836} (Horda)",

	-- Step 57: Sungrass (Alliance)
	-- {item:8838} Sungrass
	["{item:8838} (Alliance)"] = "{item:8838} (Alianza)",
	-- {item:8838} Sungrass · {skill:182} Herbalism
	["Pick {item:8838} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {item:8838} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",

	-- Step 58: Sungrass (Horde)
	-- {item:8838} Sungrass
	["{item:8838} (Horde)"] = "{item:8838} (Horda)",

	-- Step 59: Stonescale Eel (Alliance)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Alliance)"] = "{item:13422} (Alianza)",
	-- {object:180712} Stonescale Eel Swarm
	["Fish {object:180712}; this is where the data has most of them. The Auction House works too."] = "Pesca en {object:180712}; aquí es donde los datos registran más. También sirve la casa de subastas.",

	-- Step 60: Stonescale Eel (Horde)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Horde)"] = "{item:13422} (Horda)",

	-- Step 61: Elixir of Defense to 230
	-- {spell:11450} Elixir of Defense
	["{spell:11450} to 230"] = "{spell:11450} hasta 230",
	["Yellow until 235, green until 255: not every craft gives a point."] = "Amarillo hasta 235, verde hasta 255: no todas las creaciones dan un punto.",

	-- Step 62: Alchemy recipes at 230
	-- {skill:171} Alchemy
	["{skill:171} recipes at 230"] = "Recetas de {skill:171} a 230",
	-- {skill:171} Alchemy · {spell:1244648} Superior Discolored Healing Potion
	["Back to an {skill:171} trainer: {spell:1244648} is taught from {skill:171} 230."] = "Vuelve con un instructor de {skill:171}: {spell:1244648} se enseña desde {skill:171} 230.",

	-- Step 63: Superior Discolored Healing Potion to 250
	-- {item:247242} Superior Discolored Healing Potion
	["{item:247242} to 250"] = "{item:247242} hasta 250",
	["Yellow until 250, green until 270: not every craft gives a point."] = "Amarillo hasta 250, verde hasta 270: no todas las creaciones dan un punto.",

	-- Step 64: Alchemy recipes at 250
	-- {skill:171} Alchemy
	["{skill:171} recipes at 250"] = "Recetas de {skill:171} a 250",
	-- {skill:171} Alchemy · {spell:17551} Stonescale Oil
	["Back to an {skill:171} trainer: {spell:17551} is taught from {skill:171} 250."] = "Vuelve con un instructor de {skill:171}: {spell:17551} se enseña desde {skill:171} 250.",

	-- Step 65: Stonescale Oil to 259
	-- {item:13423} Stonescale Oil
	["{item:13423} to 259"] = "{item:13423} hasta 259",
	["Yellow until 255, green until 260: not every craft gives a point."] = "Amarillo hasta 255, verde hasta 260: no todas las creaciones dan un punto.",

	-- Step 66: Alchemy recipes at 259
	-- {skill:171} Alchemy
	["{skill:171} recipes at 259"] = "Recetas de {skill:171} a 259",
	-- {skill:171} Alchemy · {spell:11460} Draught of Detect Undead
	["Back to an {skill:171} trainer: {spell:11460} is taught from {skill:171} 245."] = "Vuelve con un instructor de {skill:171}: {spell:11460} se enseña desde {skill:171} 245.",

	-- Step 67: Draught of Detect Undead to 265
	-- {spell:11460} Draught of Detect Undead
	["{spell:11460} to 265"] = "{spell:11460} hasta 265",
	["Yellow until 265, green until 285: not every craft gives a point."] = "Amarillo hasta 265, verde hasta 285: no todas las creaciones dan un punto.",

	-- Step 68: Elixir of Greater Defense to 300
	-- {spell:17554} Elixir of Greater Defense
	["{spell:17554} to 300"] = "{spell:17554} hasta 300",
	-- {skill:171} Alchemy
	["Orange (a point every craft) until 280, yellow until 300, green until 320. {skill:171} 300 is a Legacy System milestone."] = "Naranja (un punto por creación) hasta 280, amarillo hasta 300, verde hasta 320. {skill:171} 300 es un hito del Sistema de Legado.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Pick {item:3355} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {item:3355} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",
	-- ["Pick {item:3821} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "Recolecta {item:3821} con {skill:182}; esta es la zona más densa según los datos. También sirve la casa de subastas.",
	-- ["{item:3355} (Alliance)"] = "{item:3355} (Alianza)",
	-- ["{item:3355} (Horde)"] = "{item:3355} (Horda)",
	-- ["{item:3821} (Alliance)"] = "{item:3821} (Alianza)",
	-- ["{item:3821} (Horde)"] = "{item:3821} (Horda)",
}
