-- Spanish (Spain) (esES): the guide forever/professions/first-aid (forever/professions/first-aid.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn First Aid
	-- {skill:129} First Aid
	["Learn {skill:129}"] = "Aprende {skill:129}",
	-- {skill:129} First Aid
	["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5); the arrow picks the nearest."] = "Cualquier instructor de {skill:129} de tu facción enseña {skill:129} de aprendiz (nivel de personaje 5); la flecha elige el más cercano.",

	-- Step 2: Linen Bandage: cloth
	-- {item:1251} Linen Bandage
	["{item:1251}: cloth"] = "{item:1251}: paño",
	-- {item:2589} Linen Cloth
	["humanoids of level 5-20 drop {item:2589} (or buy it at the Auction House)."] = "los humanoides de nivel 5-20 sueltan {item:2589} (o cómpralo en la casa de subastas).",

	-- Step 3: Linen Bandage (1-50)
	-- {item:1251} Linen Bandage
	["{item:1251} is orange from 1 (yellow at 30, grey at 60): about 61 crafts to 50. Bandages need no fire: craft them anywhere."] = "{item:1251} es naranja desde 1 (amarillo a 30, gris a 60): unas 61 fabricaciones hasta 50. Las vendas no necesitan fuego: hazlas en cualquier sitio.",

	-- Step 4: Journeyman First Aid
	-- {skill:129} First Aid
	["Journeyman {skill:129}"] = "{skill:129} de oficial",
	-- {skill:129} First Aid · {spell:3276} Heavy Linen Bandage
	["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction. Learn {spell:3276} on the same visit."] = "{skill:129} de oficial sube el límite a 150; requiere habilidad 50 y nivel de personaje 10: la flecha elige el instructor de {skill:129} de tu facción más cercano. Aprende {spell:3276} en la misma visita.",

	-- Step 5: Heavy Linen Bandage: cloth
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: cloth"] = "{item:2581}: paño",

	-- Step 6: Heavy Linen Bandage (50-80)
	-- {item:2581} Heavy Linen Bandage
	["{item:2581} is yellow from 50 (yellow at 50, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere."] = "{item:2581} es amarillo desde 50 (amarillo a 50, gris a 100): unas 46 fabricaciones hasta 80. Las vendas no necesitan fuego: hazlas en cualquier sitio.",

	-- Step 7: Wool Bandage: cloth
	-- {spell:3277} Wool Bandage
	["{spell:3277}: cloth"] = "{spell:3277}: paño",
	-- {item:2592} Wool Cloth
	["humanoids of level 15-30 drop {item:2592} (or buy it at the Auction House)."] = "los humanoides de nivel 15-30 sueltan {item:2592} (o cómpralo en la casa de subastas).",

	-- Step 8: Wool Bandage (80-115)
	-- {spell:3277} Wool Bandage · {skill:129} First Aid
	["{spell:3277} is yellow from 80 (yellow at 80, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it; the arrow picks the nearest."] = "{spell:3277} es amarillo desde 80 (amarillo a 80, gris a 150): unas 49 fabricaciones hasta 115. Las vendas no necesitan fuego: hazlas en cualquier sitio. Te lo enseña cualquier instructor de {skill:129} de tu facción; la flecha elige el más cercano.",

	-- Step 9: Heavy Wool Bandage: cloth
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: cloth"] = "{spell:3278}: paño",

	-- Step 10: Heavy Wool Bandage (115-125)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 115 (yellow at 115, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere."] = "{spell:3278} es amarillo desde 115 (amarillo a 115, gris a 185): unas 11 fabricaciones hasta 125. Las vendas no necesitan fuego: hazlas en cualquier sitio.",

	-- Step 11: Expert First Aid
	-- {skill:129} First Aid
	["Expert {skill:129}"] = "{skill:129} de experto",
	-- {skill:129} First Aid · {item:16084} Expert First Aid - Under Wraps · {item:8544} Mageweave Bandage
	["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084}; the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals: buy both now, you read them at 180 and 210."] = "{skill:129} de experto sube el límite a 225; requiere habilidad 125 y nivel de personaje 20: es un libro, {item:16084}; la flecha elige el vendedor más cercano de tu facción. Cómpralo y léelo. El mismo mercader vende los manuales de Venda de seda pesada y de {item:8544}: compra los dos ahora, los leerás a 180 y 210.",
	-- {item:16084} Expert First Aid - Under Wraps · {skill:129} First Aid
	["Buy and read {item:16084} (Expert {skill:129})"] = "Compra y lee {item:16084} ({skill:129} de experto)",

	-- Step 13: Heavy Wool Bandage (125-150)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 125 (yellow at 115, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278} es amarillo desde 125 (amarillo a 115, gris a 185): unas 38 fabricaciones hasta 150. Las vendas no necesitan fuego: hazlas en cualquier sitio.",

	-- Step 14: Silk Bandage: cloth
	-- {item:6450} Silk Bandage
	["{item:6450}: cloth"] = "{item:6450}: paño",
	-- {item:4306} Silk Cloth
	["humanoids of level 25-45 drop {item:4306} (or buy it at the Auction House)."] = "los humanoides de nivel 25-45 sueltan {item:4306} (o cómpralo en la casa de subastas).",

	-- Step 15: Silk Bandage (150-180)
	-- {item:6450} Silk Bandage
	["{item:6450} is yellow from 150 (yellow at 150, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere."] = "{item:6450} es amarillo desde 150 (amarillo a 150, gris a 210): unas 42 fabricaciones hasta 180. Las vendas no necesitan fuego: hazlas en cualquier sitio.",

	-- Step 16: Heavy Silk Bandage: cloth
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: cloth"] = "{item:6451}: paño",

	-- Step 17: Heavy Silk Bandage (180-210)
	-- {item:6451} Heavy Silk Bandage
	["{item:6451} is yellow from 180 (yellow at 180, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451} es amarillo desde 180 (amarillo a 180, gris a 240): unas 42 fabricaciones hasta 210. Las vendas no necesitan fuego: hazlas en cualquier sitio.",

	-- Step 18: Mageweave Bandage: cloth
	-- {item:8544} Mageweave Bandage
	["{item:8544}: cloth"] = "{item:8544}: paño",
	-- {item:4338} Mageweave Cloth
	["humanoids of level 35-50 drop {item:4338} (or buy it at the Auction House)."] = "los humanoides de nivel 35-50 sueltan {item:4338} (o cómprala en la casa de subastas).",

	-- Step 19: Mageweave Bandage (210-225)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 210 (yellow at 210, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544} es amarillo desde 210 (amarillo a 210, gris a 270): unas 18 fabricaciones hasta 225. Las vendas no necesitan fuego: hazlas en cualquier sitio.",

	-- Step 20: Trauma
	["Trauma"] = "Traumatología",
	-- {skill:129} First Aid · {quest:6624} Triage · {zone:1455} Ironforge
	["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore."] = "{skill:129} de artesano se obtiene con la misión {quest:6624}. Requiere habilidad 225 y nivel 40; el instructor de {skill:129} de {zone:1455} te envía al médico de Isla de Theramore.",

	-- Step 21: Trauma
	-- {skill:129} First Aid · {quest:6622} Triage · {zone:1454} Orgrimmar · {area:321} Hammerfall
	["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}."] = "{skill:129} de artesano se obtiene con la misión {quest:6622}. Requiere habilidad 225 y nivel 40; el instructor de {skill:129} de {zone:1454} te envía al médico de {area:321}.",

	-- Step 22: Triage
	-- {quest:6624} Triage
	["{quest:6624}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6624}: atiende a los soldados heridos en la tienda del médico con las vendas que te da, primero a los más graves, antes de que muera ninguno.",
	-- {skill:129} First Aid
	["Artisan {skill:129}"] = "{skill:129} de artesano",

	-- Step 23: Triage
	-- {quest:6622} Triage
	["{quest:6622}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6622}: atiende a los soldados heridos en la tienda del médico con las vendas que te da, primero a los más graves, antes de que muera ninguno.",

	-- Step 25: Mageweave Bandage (225-260)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 225 (yellow at 210, grey at 270): about 88 crafts to 260. Bandages need no fire: craft them anywhere. {item:8544} stays yellow to 270; one recipe to 260 saves two trips to the doctor."] = "{item:8544} es amarillo desde 225 (amarillo a 210, gris a 270): unas 88 fabricaciones hasta 260. Las vendas no necesitan fuego: hazlas en cualquier sitio. {item:8544} sigue amarillo hasta 270; una sola receta hasta 260 te ahorra dos viajes al médico.",

	-- Step 26: Runecloth Bandage
	-- {spell:18629} Runecloth Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:18629} (habilidad 260) es una receta de artesano: solo la enseña el médico de {quest:6622} ({npc:12939} en Isla de Theramore, {npc:12920} en {area:321}).",

	-- Step 27: Runecloth Bandage: cloth
	-- {item:14529} Runecloth Bandage
	["{item:14529}: cloth"] = "{item:14529}: paño",
	-- {item:14047} Runecloth
	["humanoids of level 45-60 drop {item:14047} (or buy it at the Auction House)."] = "los humanoides de nivel 45-60 sueltan {item:14047} (o cómpralo en la casa de subastas).",

	-- Step 28: Runecloth Bandage (260-300)
	-- {item:14529} Runecloth Bandage
	["{item:14529} is yellow from 260 (yellow at 260, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth."] = "{item:14529} es amarilla desde 260 (amarilla a 260, gris a 320): unas 65 fabricaciones hasta 300. Las vendas no necesitan fuego: hazlas en cualquier sitio. {item:14529} sigue amarilla hasta 320, así que te lleva hasta 300 sin tener que ir a por la Venda de paño rúnico pesada.",
}
