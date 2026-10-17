-- Portuguese (Brazil) (ptBR): the guide forever/professions/first-aid (forever/professions/first-aid.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn First Aid
	-- {skill:129} First Aid
	["Learn {skill:129}"] = "Aprender {skill:129}",
	-- {skill:129} First Aid
	["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5); the arrow picks the nearest."] = "Qualquer instrutor de {skill:129} da sua facção ensina {skill:129} Aprendiz (nível de personagem 5); a seta escolhe o mais próximo.",

	-- Step 2: Linen Bandage: cloth
	-- {item:1251} Linen Bandage
	["{item:1251}: cloth"] = "{item:1251}: tecido",
	-- {item:2589} Linen Cloth
	["humanoids of level 5-20 drop {item:2589} (or buy it at the Auction House)."] = "humanoides de nível 5-20 deixam cair {item:2589} (ou compre na Casa de Leilões).",

	-- Step 3: Linen Bandage (1-50)
	-- {item:1251} Linen Bandage
	["{item:1251} is orange from 1 (yellow at 30, grey at 60): about 61 crafts to 50. Bandages need no fire: craft them anywhere."] = "{item:1251} fica laranja a partir de 1 (amarelo em 30, cinza em 60): cerca de 61 criações até 50. Bandagens não precisam de fogo: faça-as em qualquer lugar.",

	-- Step 4: Journeyman First Aid
	-- {skill:129} First Aid
	["Journeyman {skill:129}"] = "{skill:129} (Profissional)",
	-- {skill:129} First Aid · {spell:3276} Heavy Linen Bandage
	["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction. Learn {spell:3276} on the same visit."] = "{skill:129} Profissional eleva o limite para 150; requer perícia 50 e nível de personagem 10: a seta escolhe o instrutor de {skill:129} mais próximo da sua facção. Aprenda {spell:3276} na mesma visita.",

	-- Step 5: Heavy Linen Bandage: cloth
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: cloth"] = "{item:2581}: tecido",

	-- Step 6: Heavy Linen Bandage (50-80)
	-- {item:2581} Heavy Linen Bandage
	["{item:2581} is yellow from 50 (yellow at 50, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere."] = "{item:2581} fica amarelo a partir de 50 (amarelo em 50, cinza em 100): cerca de 46 criações até 80. Bandagens não precisam de fogo: faça-as em qualquer lugar.",

	-- Step 7: Wool Bandage: cloth
	-- {spell:3277} Wool Bandage
	["{spell:3277}: cloth"] = "{spell:3277}: tecido",
	-- {item:2592} Wool Cloth
	["humanoids of level 15-30 drop {item:2592} (or buy it at the Auction House)."] = "humanoides de nível 15-30 deixam cair {item:2592} (ou compre na Casa de Leilões).",

	-- Step 8: Wool Bandage (80-115)
	-- {spell:3277} Wool Bandage · {skill:129} First Aid
	["{spell:3277} is yellow from 80 (yellow at 80, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it; the arrow picks the nearest."] = "{spell:3277} fica amarelo a partir de 80 (amarelo em 80, cinza em 150): cerca de 49 criações até 115. Bandagens não precisam de fogo: faça-as em qualquer lugar. Qualquer instrutor de {skill:129} da sua facção a ensina; a seta escolhe o mais próximo.",

	-- Step 9: Heavy Wool Bandage: cloth
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: cloth"] = "{spell:3278}: tecido",

	-- Step 10: Heavy Wool Bandage (115-125)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 115 (yellow at 115, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere."] = "{spell:3278} fica amarelo a partir de 115 (amarelo em 115, cinza em 185): cerca de 11 criações até 125. Bandagens não precisam de fogo: faça-as em qualquer lugar.",

	-- Step 11: Expert First Aid
	-- {skill:129} First Aid
	["Expert {skill:129}"] = "{skill:129} (Perito)",
	-- {skill:129} First Aid · {item:16084} Expert First Aid - Under Wraps · {item:8544} Mageweave Bandage
	["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084}; the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals: buy both now, you read them at 180 and 210."] = "{skill:129} (Perito) eleva o limite para 225; requer perícia 125 e nível de personagem 20: é um livro, {item:16084}; a seta escolhe o vendedor mais próximo da sua facção. Compre-o e leia-o. O mesmo vendedor vende os manuais de Bandagem Grossa de Seda e {item:8544}: compre os dois agora, você os lê em 180 e 210.",
	-- {item:16084} Expert First Aid - Under Wraps · {skill:129} First Aid
	["Buy and read {item:16084} (Expert {skill:129})"] = "Compre e leia {item:16084} ({skill:129} (Perito))",

	-- Step 13: Heavy Wool Bandage (125-150)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 125 (yellow at 115, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278} fica amarelo a partir de 125 (amarelo em 115, cinza em 185): cerca de 38 criações até 150. Bandagens não precisam de fogo: faça-as em qualquer lugar.",

	-- Step 14: Silk Bandage: cloth
	-- {item:6450} Silk Bandage
	["{item:6450}: cloth"] = "{item:6450}: tecido",
	-- {item:4306} Silk Cloth
	["humanoids of level 25-45 drop {item:4306} (or buy it at the Auction House)."] = "humanoides de nível 25-45 deixam cair {item:4306} (ou compre na Casa de Leilões).",

	-- Step 15: Silk Bandage (150-180)
	-- {item:6450} Silk Bandage
	["{item:6450} is yellow from 150 (yellow at 150, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere."] = "{item:6450} fica amarelo a partir de 150 (amarelo em 150, cinza em 210): cerca de 42 criações até 180. Bandagens não precisam de fogo: faça-as em qualquer lugar.",

	-- Step 16: Heavy Silk Bandage: cloth
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: cloth"] = "{item:6451}: tecido",

	-- Step 17: Heavy Silk Bandage (180-210)
	-- {item:6451} Heavy Silk Bandage
	["{item:6451} is yellow from 180 (yellow at 180, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451} fica amarelo a partir de 180 (amarelo em 180, cinza em 240): cerca de 42 criações até 210. Bandagens não precisam de fogo: faça-as em qualquer lugar.",

	-- Step 18: Mageweave Bandage: cloth
	-- {item:8544} Mageweave Bandage
	["{item:8544}: cloth"] = "{item:8544}: tecido",
	-- {item:4338} Mageweave Cloth
	["humanoids of level 35-50 drop {item:4338} (or buy it at the Auction House)."] = "humanoides de nível 35-50 deixam cair {item:4338} (ou compre na Casa de Leilões).",

	-- Step 19: Mageweave Bandage (210-225)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 210 (yellow at 210, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544} fica amarelo a partir de 210 (amarelo em 210, cinza em 270): cerca de 18 criações até 225. Bandagens não precisam de fogo: faça-as em qualquer lugar.",

	-- Step 20: Trauma
	["Trauma"] = "Trauma",
	-- {skill:129} First Aid · {quest:6624} Triage · {zone:1455} Ironforge
	["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore."] = "{skill:129} Artífice vem da missão {quest:6624}. Requer perícia 225 e nível 40; o instrutor de {skill:129} em {zone:1455} envia você ao médico em Theramore.",

	-- Step 21: Trauma
	-- {skill:129} First Aid · {quest:6622} Triage · {zone:1454} Orgrimmar · {area:321} Hammerfall
	["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}."] = "{skill:129} Artífice vem da missão {quest:6622}. Requer perícia 225 e nível 40; o instrutor de {skill:129} em {zone:1454} envia você ao médico em {area:321}.",

	-- Step 22: Triage
	-- {quest:6624} Triage
	["{quest:6624}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6624}: trate os soldados feridos na tenda do médico com as bandagens que ele lhe der, os mais graves primeiro, antes que algum morra.",
	-- {skill:129} First Aid
	["Artisan {skill:129}"] = "{skill:129} (Artífice)",

	-- Step 23: Triage
	-- {quest:6622} Triage
	["{quest:6622}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6622}: trate os soldados feridos na tenda do médico com as bandagens que ele lhe der, os mais graves primeiro, antes que algum morra.",

	-- Step 25: Mageweave Bandage (225-260)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 225 (yellow at 210, grey at 270): about 88 crafts to 260. Bandages need no fire: craft them anywhere. {item:8544} stays yellow to 270; one recipe to 260 saves two trips to the doctor."] = "{item:8544} fica amarelo a partir de 225 (amarelo em 210, cinza em 270): cerca de 88 criações até 260. Bandagens não precisam de fogo: faça-as em qualquer lugar. {item:8544} fica amarelo até 270; uma só receita até 260 poupa duas idas ao médico.",

	-- Step 26: Runecloth Bandage
	-- {spell:18629} Runecloth Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:18629} (perícia 260) é uma receita de Artífice: só o médico de {quest:6622} a ensina ({npc:12939} em Theramore, {npc:12920} em {area:321}).",

	-- Step 27: Runecloth Bandage: cloth
	-- {item:14529} Runecloth Bandage
	["{item:14529}: cloth"] = "{item:14529}: tecido",
	-- {item:14047} Runecloth
	["humanoids of level 45-60 drop {item:14047} (or buy it at the Auction House)."] = "humanoides de nível 45-60 deixam cair {item:14047} (ou compre na Casa de Leilões).",

	-- Step 28: Runecloth Bandage (260-300)
	-- {item:14529} Runecloth Bandage
	["{item:14529} is yellow from 260 (yellow at 260, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth."] = "{item:14529} fica amarelo a partir de 260 (amarelo em 260, cinza em 320): cerca de 65 criações até 300. Bandagens não precisam de fogo: faça-as em qualquer lugar. {item:14529} fica amarelo até 320, então leva você até 300 sem uma ida para buscar Bandagem Grossa de Runatrama.",
}
