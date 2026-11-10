-- Portuguese (Brazil) (ptBR): the guide forever/professions/first-aid (forever/professions/first-aid.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn First Aid
	-- {skill:129} First Aid
	["Learn {skill:129}"] = "Aprender {skill:129}",
	-- {skill:129} First Aid · {item:118} Minor Healing Potion · {item:2447} Peacebloom · {item:2678} Mild Spices · {item:3371} Empty Vial · {skill:182} Herbalism
	-- plural, as words: Linen Bandages = {item:1251} Linen Bandage
	["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5, 1s); the arrow picks the nearest. Forever teaches {item:118} with it: {item:2447}, {item:2678} and an {item:3371}, orange to 55. With {skill:182} it can replace the Linen Bandages below."] = "Qualquer instrutor de {skill:129} da sua facção ensina {skill:129} Aprendiz (nível de personagem 5, 1s); a seta escolhe o mais próximo. O Forever ensina {item:118} junto: {item:2447}, {item:2678} e uma {item:3371}, laranja até 55. Com {skill:182}, pode substituir as Bandagens de Linho abaixo.",

	-- Step 2: Linen Bandage: cloth
	-- {item:1251} Linen Bandage
	["{item:1251}: cloth"] = "{item:1251}: tecido",
	-- {item:2589} Linen Cloth
	["humanoids of level 5-20 drop {item:2589} (or buy it at the Auction House)."] = "humanoides de nível 5-20 deixam cair {item:2589} (ou compre na Casa de Leilões).",

	-- Step 3: Linen Bandage (1-40)
	-- {item:1251} Linen Bandage · {item:279968} First Aid Kit · {skill:129} First Aid · {item:159} Refreshing Spring Water
	-- plural, as words: Linen Bandages = {item:1251} Linen Bandage
	["{item:1251} is orange from 1 (yellow at 30, green at 45, grey at 60): about 41 crafts to 40. Bandages need no fire: craft them anywhere. At 20 the trainer also teaches {item:279968} (1s; the Camping 101: {skill:129} quest at your starting area's camp teaches it free), Forever's camping item for {skill:129}: three Linen Bandages and a {item:159}; it gives a few points until 25."] = "{item:1251} é laranja desde 1 (amarelo em 30, verde em 45, cinza em 60): cerca de 41 criações até 40. Bandagens não precisam de fogo: crie em qualquer lugar. Em 20 o instrutor também ensina {item:279968} (1s; a missão Introdução ao acampamento: {skill:129} do acampamento da sua área inicial ensina de graça), o item de acampamento do Forever para {skill:129}: três Bandagens de Linho e uma {item:159}; dá alguns pontos até 25.",

	-- Step 4: Heavy Linen Bandage: cloth
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: cloth"] = "{item:2581}: tecido",

	-- Step 5: Heavy Linen Bandage (40-50)
	-- {item:2581} Heavy Linen Bandage · {skill:129} First Aid
	["{item:2581} is orange from 40 (yellow at 50, green at 75, grey at 100): about 10 crafts to 50. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 40 for 1s; the arrow picks the nearest."] = "{item:2581} é laranja desde 40 (amarelo em 50, verde em 75, cinza em 100): cerca de 10 criações até 50. Bandagens não precisam de fogo: crie em qualquer lugar. Qualquer instrutor de {skill:129} da sua facção ensina a partir da perícia 40 por 1s; a seta escolhe o mais próximo.",

	-- Step 6: Journeyman First Aid
	-- {skill:129} First Aid
	["Journeyman {skill:129}"] = "{skill:129} (Profissional)",
	-- {skill:129} First Aid
	["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction; training costs 5s."] = "{skill:129} Profissional eleva o limite para 150; exige perícia 50 e nível de personagem 10: a seta escolhe o instrutor de {skill:129} mais próximo da sua facção; o treino custa 5s.",

	-- Step 8: Heavy Linen Bandage (50-80)
	-- {item:2581} Heavy Linen Bandage · {item:858} Lesser Healing Potion · {item:2450} Briarthorn · {item:2678} Mild Spices · {item:3371} Empty Vial
	["{item:2581} is yellow from 50 (yellow at 50, green at 75, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere. Herbalists: {item:858} (from 55, 1s 50c; {item:2450}, two {item:2678} and an {item:3371}) is orange to 85."] = "{item:2581} é amarela desde 50 (amarelo em 50, verde em 75, cinza em 100): cerca de 46 criações até 80. Bandagens não precisam de fogo: crie em qualquer lugar. Herboristas: {item:858} (a partir de 55, 1s 50c; {item:2450}, duas {item:2678} e uma {item:3371}) é laranja até 85.",

	-- Step 9: Wool Bandage: cloth
	-- {spell:3277} Wool Bandage
	["{spell:3277}: cloth"] = "{spell:3277}: tecido",
	-- {item:2592} Wool Cloth
	["humanoids of level 15-30 drop {item:2592} (or buy it at the Auction House)."] = "humanoides de nível 15-30 deixam cair {item:2592} (ou compre na Casa de Leilões).",

	-- Step 10: Wool Bandage (80-115)
	-- {spell:3277} Wool Bandage · {skill:129} First Aid · {item:6452} Anti-Venom · {item:1475} Small Venom Sac · {spell:9810} Touch of Zanzil
	["{spell:3277} is yellow from 80 (yellow at 80, green at 115, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 80 for 2s 50c; the arrow picks the nearest. {item:6452} ({item:1475}, from spiders) is taught at 80 too: Rogues need it for {spell:9810}, and it sells."] = "{spell:3277} é amarela desde 80 (amarelo em 80, verde em 115, cinza em 150): cerca de 49 criações até 115. Bandagens não precisam de fogo: crie em qualquer lugar. Qualquer instrutor de {skill:129} da sua facção ensina a partir da perícia 80 por 2s 50c; a seta escolhe o mais próximo. {item:6452} ({item:1475}, de aranhas) também é ensinado em 80: ladinos precisam dele para {spell:9810}, e vende bem.",

	-- Step 11: Heavy Wool Bandage: cloth
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: cloth"] = "{spell:3278}: tecido",

	-- Step 12: Heavy Wool Bandage (115-125)
	-- {spell:3278} Heavy Wool Bandage · {skill:129} First Aid · {item:929} Healing Potion · {item:2453} Bruiseweed · {item:2692} Hot Spices · {item:3372} Leaded Vial
	["{spell:3278} is yellow from 115 (yellow at 115, green at 150, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 115 for 10s; the arrow picks the nearest. Herbalists: {item:929} (from 110, 8s; {item:2453}, {item:2692} and a {item:3372}) is orange to 135."] = "{spell:3278} é amarela desde 115 (amarelo em 115, verde em 150, cinza em 185): cerca de 11 criações até 125. Bandagens não precisam de fogo: crie em qualquer lugar. Qualquer instrutor de {skill:129} da sua facção ensina a partir da perícia 115 por 10s; a seta escolhe o mais próximo. Herboristas: {item:929} (a partir de 110, 8s; {item:2453}, {item:2692} e uma {item:3372}) é laranja até 135.",

	-- Step 13: Expert First Aid
	-- {skill:129} First Aid
	["Expert {skill:129}"] = "{skill:129} (Perito)",
	-- {skill:129} First Aid · {item:16084} Expert First Aid - Under Wraps · {item:8544} Mageweave Bandage
	["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084} (1g); the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals (22s and 50s): buy both now, you read them at 180 and 210."] = "{skill:129} Perito eleva o limite para 225; exige perícia 125 e nível de personagem 20: é um livro, {item:16084} (1g); a seta escolhe o vendedor mais próximo da sua facção. Compre e leia. O mesmo vendedor vende os manuais de Bandagem Grossa de Seda e de {item:8544} (22s 50s): compre os dois agora, você os lê em 180 e 210.",
	-- {item:16084} Expert First Aid - Under Wraps · {skill:129} First Aid
	["Buy and read {item:16084} (Expert {skill:129})"] = "Compre e leia {item:16084} ({skill:129} (Perito))",

	-- Step 15: Heavy Wool Bandage (125-150)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 125 (yellow at 115, green at 150, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278} é amarela desde 125 (amarelo em 115, verde em 150, cinza em 185): cerca de 38 criações até 150. Bandagens não precisam de fogo: crie em qualquer lugar.",

	-- Step 16: Silk Bandage: cloth
	-- {item:6450} Silk Bandage
	["{item:6450}: cloth"] = "{item:6450}: tecido",
	-- {item:4306} Silk Cloth
	["humanoids of level 25-45 drop {item:4306} (or buy it at the Auction House)."] = "humanoides de nível 25-45 deixam cair {item:4306} (ou compre na Casa de Leilões).",

	-- Step 17: Silk Bandage (150-180)
	-- {item:6450} Silk Bandage · {skill:129} First Aid
	["{item:6450} is yellow from 150 (yellow at 150, green at 180, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 150 for 50s; the arrow picks the nearest."] = "{item:6450} é amarela desde 150 (amarelo em 150, verde em 180, cinza em 210): cerca de 42 criações até 180. Bandagens não precisam de fogo: crie em qualquer lugar. Qualquer instrutor de {skill:129} da sua facção ensina a partir da perícia 150 por 50s; a seta escolhe o mais próximo.",

	-- Step 18: Heavy Silk Bandage: cloth
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: cloth"] = "{item:6451}: tecido",

	-- Step 19: Heavy Silk Bandage (180-210)
	-- {item:6451} Heavy Silk Bandage
	["{item:6451} is yellow from 180 (yellow at 180, green at 210, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451} é amarela desde 180 (amarelo em 180, verde em 210, cinza em 240): cerca de 42 criações até 210. Bandagens não precisam de fogo: crie em qualquer lugar.",

	-- Step 20: Mageweave Bandage: cloth
	-- {item:8544} Mageweave Bandage
	["{item:8544}: cloth"] = "{item:8544}: tecido",
	-- {item:4338} Mageweave Cloth
	["humanoids of level 35-50 drop {item:4338} (or buy it at the Auction House)."] = "humanoides de nível 35-50 deixam cair {item:4338} (ou compre na Casa de Leilões).",

	-- Step 21: Mageweave Bandage (210-225)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 210 (yellow at 210, green at 240, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544} é amarela desde 210 (amarelo em 210, verde em 240, cinza em 270): cerca de 18 criações até 225. Bandagens não precisam de fogo: crie em qualquer lugar.",

	-- Step 22: Trauma
	["Trauma"] = "Trauma",
	-- {skill:129} First Aid · {quest:6624} Triage · {zone:1455} Ironforge · {item:14047} Runecloth
	["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 35; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore. Bring the Mageweave (about 74) and {item:14047} (about 65) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages."] = "{skill:129} Artífice vem da missão {quest:6624}. Exige perícia 225 e nível 35; o instrutor de {skill:129} em {zone:1455} manda você ao médico em Theramore. Leve agora a Magitrama (cerca de 74) e o {item:14047} (cerca de 65) para 225-300: bandagens não precisam de fogo, então você cria 225-300 ao lado do médico, que ensina as bandagens de Artífice.",

	-- Step 23: Trauma
	-- {skill:129} First Aid · {quest:6622} Triage · {zone:1454} Orgrimmar · {area:321} Hammerfall · {item:14047} Runecloth
	["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 35; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}. Bring the Mageweave (about 74) and {item:14047} (about 65) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages."] = "{skill:129} Artífice vem da missão {quest:6622}. Exige perícia 225 e nível 35; o instrutor de {skill:129} em {zone:1454} manda você ao médico em {area:321}. Leve agora a Magitrama (cerca de 74) e o {item:14047} (cerca de 65) para 225-300: bandagens não precisam de fogo, então você cria 225-300 ao lado do médico, que ensina as bandagens de Artífice.",

	-- Step 24: Triage
	-- {quest:6624} Triage
	-- plural, as words: Triage Bandages = {item:16991} Triage Bandage
	["{quest:6624}: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie inside: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again."] = "{quest:6624}: o médico entrega Bandagens de Triagem; use essas, não as suas. Quinze soldados feridos estão lá dentro: enfaixe primeiro os em estado crítico, depois os gravemente feridos, depois os feridos, antes que morram (mostre as barras de vida com Ctrl+V). Entregue a missão assim que quinze forem salvos: os outros continuam morrendo, e mortes demais fazem a missão falhar mesmo depois de aparecer como completa. Se falhar, abandone e pegue de novo.",
	-- {skill:129} First Aid
	["Artisan {skill:129}"] = "{skill:129} (Artífice)",

	-- Step 25: Triage
	-- {quest:6622} Triage
	-- plural, as words: Triage Bandages = {item:16991} Triage Bandage
	["{quest:6622}: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie on the floor inside: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again."] = "{quest:6622}: o médico entrega Bandagens de Triagem; use essas, não as suas. Quinze soldados feridos estão caídos no chão lá dentro: enfaixe primeiro os em estado crítico, depois os gravemente feridos, depois os feridos, antes que morram (mostre as barras de vida com Ctrl+V). Entregue a missão assim que quinze forem salvos: os outros continuam morrendo, e mortes demais fazem a missão falhar mesmo depois de aparecer como completa. Se falhar, abandone e pegue de novo.",

	-- Step 27: Mageweave Bandage (225-240)
	-- {item:8544} Mageweave Bandage
	-- plural, as words: Mageweave Bandages = {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 225 (yellow at 210, green at 240, grey at 270): about 24 crafts to 240. Bandages need no fire: craft them anywhere. {item:8544} turns green at 240: switch to Heavy Mageweave there, which costs less cloth than green Mageweave Bandages to 260."] = "{item:8544} é amarela desde 225 (amarelo em 210, verde em 240, cinza em 270): cerca de 24 criações até 240. Bandagens não precisam de fogo: crie em qualquer lugar. {item:8544} fica verde em 240: troque ali para a Bandagem Grossa de Magitrama, que gasta menos tecido do que a Bandagem de Magitrama verde até 260.",

	-- Step 28: Heavy Mageweave Bandage
	-- {spell:10841} Heavy Mageweave Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:10841} (skill 240) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:10841} (perícia 240) é uma receita de Artífice: só o médico de {quest:6622} ensina ({npc:12939} em Theramore, {npc:12920} em {area:321}).",

	-- Step 29: Heavy Mageweave Bandage: cloth
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545}: cloth"] = "{item:8545}: tecido",

	-- Step 30: Heavy Mageweave Bandage (240-260)
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545} is yellow from 240 (yellow at 240, green at 270, grey at 300): about 25 crafts to 260. Bandages need no fire: craft them anywhere."] = "{item:8545} é amarela desde 240 (amarelo em 240, verde em 270, cinza em 300): cerca de 25 criações até 260. Bandagens não precisam de fogo: crie em qualquer lugar.",

	-- Step 31: Runecloth Bandage
	-- {spell:18629} Runecloth Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:18629} (perícia 260) é uma receita de Artífice: só o médico de {quest:6622} a ensina ({npc:12939} em Theramore, {npc:12920} em {area:321}).",

	-- Step 32: Runecloth Bandage: cloth
	-- {item:14529} Runecloth Bandage
	["{item:14529}: cloth"] = "{item:14529}: tecido",
	-- {item:14047} Runecloth
	["humanoids of level 45-60 drop {item:14047} (or buy it at the Auction House)."] = "humanoides de nível 45-60 deixam cair {item:14047} (ou compre na Casa de Leilões).",

	-- Step 33: Runecloth Bandage (260-300)
	-- {item:14529} Runecloth Bandage · {item:14047} Runecloth · {item:14530} Heavy Runecloth Bandage
	["{item:14529} is yellow from 260 (yellow at 260, green at 290, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} turns green at 290, yet to 300 it takes about the same {item:14047} as switching to {item:14530} (the doctor teaches it at 290): one recipe is enough."] = "{item:14529} é amarela desde 260 (amarelo em 260, verde em 290, cinza em 320): cerca de 65 criações até 300. Bandagens não precisam de fogo: crie em qualquer lugar. {item:14529} fica verde em 290, mas até 300 gasta quase o mesmo {item:14047} que trocar para {item:14530} (o médico ensina em 290): uma receita basta.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5); the arrow picks the nearest."] = "Qualquer instrutor de {skill:129} da sua facção ensina {skill:129} Aprendiz (nível de personagem 5); a seta escolhe o mais próximo.",
	-- ["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}."] = "{skill:129} Artífice vem da missão {quest:6622}. Requer perícia 225 e nível 40; o instrutor de {skill:129} em {zone:1454} envia você ao médico em {area:321}.",
	-- ["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore."] = "{skill:129} Artífice vem da missão {quest:6624}. Requer perícia 225 e nível 40; o instrutor de {skill:129} em {zone:1455} envia você ao médico em Theramore.",
	-- ["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084}; the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals: buy both now, you read them at 180 and 210."] = "{skill:129} (Perito) eleva o limite para 225; requer perícia 125 e nível de personagem 20: é um livro, {item:16084}; a seta escolhe o vendedor mais próximo da sua facção. Compre-o e leia-o. O mesmo vendedor vende os manuais de Bandagem Grossa de Seda e {item:8544}: compre os dois agora, você os lê em 180 e 210.",
	-- ["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction. Learn {spell:3276} on the same visit."] = "{skill:129} Profissional eleva o limite para 150; requer perícia 50 e nível de personagem 10: a seta escolhe o instrutor de {skill:129} mais próximo da sua facção. Aprenda {spell:3276} na mesma visita.",
	-- ["{item:1251} is orange from 1 (yellow at 30, grey at 60): about 61 crafts to 50. Bandages need no fire: craft them anywhere."] = "{item:1251} fica laranja a partir de 1 (amarelo em 30, cinza em 60): cerca de 61 criações até 50. Bandagens não precisam de fogo: faça-as em qualquer lugar.",
	-- ["{item:14529} is yellow from 260 (yellow at 260, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth."] = "{item:14529} fica amarelo a partir de 260 (amarelo em 260, cinza em 320): cerca de 65 criações até 300. Bandagens não precisam de fogo: faça-as em qualquer lugar. {item:14529} fica amarelo até 320, então leva você até 300 sem uma ida para buscar Bandagem Grossa de Runatrama.",
	-- ["{item:2581} is yellow from 50 (yellow at 50, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere."] = "{item:2581} fica amarelo a partir de 50 (amarelo em 50, cinza em 100): cerca de 46 criações até 80. Bandagens não precisam de fogo: faça-as em qualquer lugar.",
	-- ["{item:6450} is yellow from 150 (yellow at 150, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere."] = "{item:6450} fica amarelo a partir de 150 (amarelo em 150, cinza em 210): cerca de 42 criações até 180. Bandagens não precisam de fogo: faça-as em qualquer lugar.",
	-- ["{item:6451} is yellow from 180 (yellow at 180, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451} fica amarelo a partir de 180 (amarelo em 180, cinza em 240): cerca de 42 criações até 210. Bandagens não precisam de fogo: faça-as em qualquer lugar.",
	-- ["{item:8544} is yellow from 210 (yellow at 210, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544} fica amarelo a partir de 210 (amarelo em 210, cinza em 270): cerca de 18 criações até 225. Bandagens não precisam de fogo: faça-as em qualquer lugar.",
	-- ["{item:8544} is yellow from 225 (yellow at 210, grey at 270): about 88 crafts to 260. Bandages need no fire: craft them anywhere. {item:8544} stays yellow to 270; one recipe to 260 saves two trips to the doctor."] = "{item:8544} fica amarelo a partir de 225 (amarelo em 210, cinza em 270): cerca de 88 criações até 260. Bandagens não precisam de fogo: faça-as em qualquer lugar. {item:8544} fica amarelo até 270; uma só receita até 260 poupa duas idas ao médico.",
	-- ["{quest:6622}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6622}: trate os soldados feridos na tenda do médico com as bandagens que ele lhe der, os mais graves primeiro, antes que algum morra.",
	-- ["{quest:6624}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6624}: trate os soldados feridos na tenda do médico com as bandagens que ele lhe der, os mais graves primeiro, antes que algum morra.",
	-- ["{spell:3277} is yellow from 80 (yellow at 80, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it; the arrow picks the nearest."] = "{spell:3277} fica amarelo a partir de 80 (amarelo em 80, cinza em 150): cerca de 49 criações até 115. Bandagens não precisam de fogo: faça-as em qualquer lugar. Qualquer instrutor de {skill:129} da sua facção a ensina; a seta escolhe o mais próximo.",
	-- ["{spell:3278} is yellow from 115 (yellow at 115, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere."] = "{spell:3278} fica amarelo a partir de 115 (amarelo em 115, cinza em 185): cerca de 11 criações até 125. Bandagens não precisam de fogo: faça-as em qualquer lugar.",
	-- ["{spell:3278} is yellow from 125 (yellow at 115, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278} fica amarelo a partir de 125 (amarelo em 115, cinza em 185): cerca de 38 criações até 150. Bandagens não precisam de fogo: faça-as em qualquer lugar.",
}
