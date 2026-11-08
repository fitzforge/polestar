-- Russian (ruRU): the guide forever/professions/first-aid (forever/professions/first-aid.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn First Aid
	-- {skill:129} First Aid
	["Learn {skill:129}"] = "Изучите: {skill:129}",
	-- {skill:129} First Aid · {item:118} Minor Healing Potion · {item:2447} Peacebloom · {item:2678} Mild Spices · {item:3371} Empty Vial · {skill:182} Herbalism
	-- plural, as words: Linen Bandages = {item:1251} Linen Bandage
	["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5, 1s); the arrow picks the nearest. Forever teaches {item:118} with it: {item:2447}, {item:2678} and an {item:3371}, orange to 55. With {skill:182} it can replace the Linen Bandages below."] = "Любой учитель навыка {skill:129} вашей фракции обучает уровню «Ученик» ({skill:129}) (уровень персонажа 5, 1с); стрелка указывает на ближайшего. На Forever вместе с ним изучается {item:118}: {item:2447}, {item:2678} и {item:3371}, оранжевый до 55. С навыком {skill:182} это может заменить льняные бинты ниже.",

	-- Step 2: Linen Bandage: cloth
	-- {item:1251} Linen Bandage
	["{item:1251}: cloth"] = "{item:1251}: ткань",
	-- {item:2589} Linen Cloth
	["humanoids of level 5-20 drop {item:2589} (or buy it at the Auction House)."] = "с гуманоидов 5-20 уровня падает {item:2589} (или купите на аукционе).",

	-- Step 3: Linen Bandage (1-40)
	-- {item:1251} Linen Bandage · {item:279968} First Aid Kit · {skill:129} First Aid · {item:159} Refreshing Spring Water
	-- plural, as words: Linen Bandages = {item:1251} Linen Bandage
	["{item:1251} is orange from 1 (yellow at 30, green at 45, grey at 60): about 41 crafts to 40. Bandages need no fire: craft them anywhere. At 20 the trainer also teaches {item:279968} (1s; the Camping 101: {skill:129} quest at your starting area's camp teaches it free), Forever's camping item for {skill:129}: three Linen Bandages and a {item:159}; it gives a few points until 25."] = "{item:1251} — оранжевый с 1 (желтый с 30, зеленый с 45, серый с 60): около 41 изготовления до 40. Бинтам не нужен огонь: делайте их где угодно. На 20 учитель также обучает рецепту {item:279968} (1с; задание «Camping 101: {skill:129}» в лагере стартовой зоны обучает бесплатно) — походный предмет Forever для навыка {skill:129}: три льняных бинта и {item:159}; дает немного очков до 25.",

	-- Step 4: Heavy Linen Bandage: cloth
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: cloth"] = "{item:2581}: ткань",

	-- Step 5: Heavy Linen Bandage (40-50)
	-- {item:2581} Heavy Linen Bandage · {skill:129} First Aid
	["{item:2581} is orange from 40 (yellow at 50, green at 75, grey at 100): about 10 crafts to 50. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 40 for 1s; the arrow picks the nearest."] = "{item:2581} — оранжевый с 40 (желтый с 50, зеленый с 75, серый с 100): около 10 изготовлений до 50. Бинтам не нужен огонь: делайте их где угодно. Любой учитель навыка {skill:129} вашей фракции обучает этому с навыка 40 за 1с; стрелка указывает на ближайшего.",

	-- Step 6: Journeyman First Aid
	-- {skill:129} First Aid
	["Journeyman {skill:129}"] = "{skill:129}: подмастерье",
	-- {skill:129} First Aid
	["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction; training costs 5s."] = "Уровень «Подмастерье» ({skill:129}) повышает предел до 150; нужен навык 50 и уровень персонажа 10: стрелка указывает на ближайшего учителя навыка {skill:129} вашей фракции; обучение стоит 5с.",

	-- Step 8: Heavy Linen Bandage (50-80)
	-- {item:2581} Heavy Linen Bandage · {item:858} Lesser Healing Potion · {item:2450} Briarthorn · {item:2678} Mild Spices · {item:3371} Empty Vial
	["{item:2581} is yellow from 50 (yellow at 50, green at 75, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere. Herbalists: {item:858} (from 55, 1s 50c; {item:2450}, two {item:2678} and an {item:3371}) is orange to 85."] = "{item:2581} — желтый с 50 (желтый с 50, зеленый с 75, серый с 100): около 46 изготовлений до 80. Бинтам не нужен огонь: делайте их где угодно. Травникам: {item:858} (с 55, 1с 50м; {item:2450}, два {item:2678} и {item:3371}) — оранжевый до 85.",

	-- Step 9: Wool Bandage: cloth
	-- {spell:3277} Wool Bandage
	["{spell:3277}: cloth"] = "{spell:3277}: ткань",
	-- {item:2592} Wool Cloth
	["humanoids of level 15-30 drop {item:2592} (or buy it at the Auction House)."] = "с гуманоидов 15-30 уровня падает {item:2592} (или купите на аукционе).",

	-- Step 10: Wool Bandage (80-115)
	-- {spell:3277} Wool Bandage · {skill:129} First Aid · {item:6452} Anti-Venom · {item:1475} Small Venom Sac · {spell:9810} Touch of Zanzil
	["{spell:3277} is yellow from 80 (yellow at 80, green at 115, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 80 for 2s 50c; the arrow picks the nearest. {item:6452} ({item:1475}, from spiders) is taught at 80 too: Rogues need it for {spell:9810}, and it sells."] = "{spell:3277} — желтый с 80 (желтый с 80, зеленый с 115, серый с 150): около 49 изготовлений до 115. Бинтам не нужен огонь: делайте их где угодно. Любой учитель навыка {skill:129} вашей фракции обучает этому с навыка 80 за 2с 50м; стрелка указывает на ближайшего. {item:6452} ({item:1475}, с пауков) тоже изучается на 80: он нужен разбойникам для {spell:9810}, и он хорошо продается.",

	-- Step 11: Heavy Wool Bandage: cloth
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: cloth"] = "{spell:3278}: ткань",

	-- Step 12: Heavy Wool Bandage (115-125)
	-- {spell:3278} Heavy Wool Bandage · {skill:129} First Aid · {item:929} Healing Potion · {item:2453} Bruiseweed · {item:2692} Hot Spices · {item:3372} Leaded Vial
	["{spell:3278} is yellow from 115 (yellow at 115, green at 150, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 115 for 10s; the arrow picks the nearest. Herbalists: {item:929} (from 110, 8s; {item:2453}, {item:2692} and a {item:3372}) is orange to 135."] = "{spell:3278} — желтый с 115 (желтый с 115, зеленый с 150, серый с 185): около 11 изготовлений до 125. Бинтам не нужен огонь: делайте их где угодно. Любой учитель навыка {skill:129} вашей фракции обучает этому с навыка 115 за 10с; стрелка указывает на ближайшего. Травникам: {item:929} (с 110, 8с; {item:2453}, {item:2692} и {item:3372}) — оранжевый до 135.",

	-- Step 13: Expert First Aid
	-- {skill:129} First Aid
	["Expert {skill:129}"] = "{skill:129}: умелец",
	-- {skill:129} First Aid · {item:16084} Expert First Aid - Under Wraps · {item:8544} Mageweave Bandage
	["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084} (1g); the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals (22s and 50s): buy both now, you read them at 180 and 210."] = "Уровень «Умелец» ({skill:129}) повышает предел до 225; нужен навык 125 и уровень персонажа 20: это книга {item:16084} (1з); стрелка указывает на ближайшего продавца вашей фракции. Купите и прочтите ее. Тот же торговец продает руководства по плотным шелковым бинтам и {item:8544} (22с и 50с): купите оба сейчас, прочтете их на 180 и 210.",
	-- {item:16084} Expert First Aid - Under Wraps · {skill:129} First Aid
	["Buy and read {item:16084} (Expert {skill:129})"] = "Купите и прочтите {item:16084} (уровень «Умелец», {skill:129})",

	-- Step 15: Heavy Wool Bandage (125-150)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 125 (yellow at 115, green at 150, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278} — желтый с 125 (желтый с 115, зеленый с 150, серый с 185): около 38 изготовлений до 150. Бинтам не нужен огонь: делайте их где угодно.",

	-- Step 16: Silk Bandage: cloth
	-- {item:6450} Silk Bandage
	["{item:6450}: cloth"] = "{item:6450}: ткань",
	-- {item:4306} Silk Cloth
	["humanoids of level 25-45 drop {item:4306} (or buy it at the Auction House)."] = "с гуманоидов 25-45 уровня падает {item:4306} (или купите на аукционе).",

	-- Step 17: Silk Bandage (150-180)
	-- {item:6450} Silk Bandage · {skill:129} First Aid
	["{item:6450} is yellow from 150 (yellow at 150, green at 180, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 150 for 50s; the arrow picks the nearest."] = "{item:6450} — желтый с 150 (желтый с 150, зеленый с 180, серый с 210): около 42 изготовлений до 180. Бинтам не нужен огонь: делайте их где угодно. Любой учитель навыка {skill:129} вашей фракции обучает этому с навыка 150 за 50с; стрелка указывает на ближайшего.",

	-- Step 18: Heavy Silk Bandage: cloth
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: cloth"] = "{item:6451}: ткань",

	-- Step 19: Heavy Silk Bandage (180-210)
	-- {item:6451} Heavy Silk Bandage
	["{item:6451} is yellow from 180 (yellow at 180, green at 210, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451} — желтый с 180 (желтый с 180, зеленый с 210, серый с 240): около 42 изготовлений до 210. Бинтам не нужен огонь: делайте их где угодно.",

	-- Step 20: Mageweave Bandage: cloth
	-- {item:8544} Mageweave Bandage
	["{item:8544}: cloth"] = "{item:8544}: ткань",
	-- {item:4338} Mageweave Cloth
	["humanoids of level 35-50 drop {item:4338} (or buy it at the Auction House)."] = "с гуманоидов 35-50 уровня падает {item:4338} (или купите на аукционе).",

	-- Step 21: Mageweave Bandage (210-225)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 210 (yellow at 210, green at 240, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544} — желтый с 210 (желтый с 210, зеленый с 240, серый с 270): около 18 изготовлений до 225. Бинтам не нужен огонь: делайте их где угодно.",

	-- Step 22: Trauma
	["Trauma"] = "Травма",
	-- {skill:129} First Aid · {quest:6624} Triage · {zone:1455} Ironforge · {item:14047} Runecloth
	["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 35; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore. Bring the Mageweave (about 74) and {item:14047} (about 65) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages."] = "Уровень «Искусник» ({skill:129}) дает задание {quest:6624}. Нужен навык 225 и уровень 35; учитель навыка {skill:129} — {zone:1455} — отправит вас к доктору в Терамор. Возьмите сразу магическую ткань (около 74) и {item:14047} (около 65) для 225-300: бинтам не нужен огонь, так что 225-300 вы прокачаете рядом с доктором, который обучает бинтам искусника.",

	-- Step 23: Trauma
	-- {skill:129} First Aid · {quest:6622} Triage · {zone:1454} Orgrimmar · {area:321} Hammerfall · {item:14047} Runecloth
	["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 35; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}. Bring the Mageweave (about 74) and {item:14047} (about 65) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages."] = "Уровень «Искусник» ({skill:129}) дает задание {quest:6622}. Нужен навык 225 и уровень 35; учитель навыка {skill:129} — {zone:1454} — отправит вас к доктору ({area:321}). Возьмите сразу магическую ткань (около 74) и {item:14047} (около 65) для 225-300: бинтам не нужен огонь, так что 225-300 вы прокачаете рядом с доктором, который обучает бинтам искусника.",

	-- Step 24: Triage
	-- {quest:6624} Triage
	-- plural, as words: Triage Bandages = {item:16991} Triage Bandage
	["{quest:6624}: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie inside: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again."] = "{quest:6624}: доктор выдаст вам бинты для сортировки раненых; используйте их, а не свои. Внутри лежат пятнадцать раненых солдат: перевязывайте сначала тяжелораненых при смерти, затем тяжелораненых, затем раненых, пока никто не умер (полосы здоровья — Ctrl+V). Сдайте задание сразу, как спасете пятнадцать: остальные продолжают умирать, и слишком много смертей проваливают задание даже после пометки «выполнено». При провале откажитесь от задания и возьмите его снова.",
	-- {skill:129} First Aid
	["Artisan {skill:129}"] = "{skill:129}: искусник",

	-- Step 25: Triage
	-- {quest:6622} Triage
	-- plural, as words: Triage Bandages = {item:16991} Triage Bandage
	["{quest:6622}: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie on the floor inside: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again."] = "{quest:6622}: доктор выдаст вам бинты для сортировки раненых; используйте их, а не свои. Внутри на полу лежат пятнадцать раненых солдат: перевязывайте сначала тяжелораненых при смерти, затем тяжелораненых, затем раненых, пока никто не умер (полосы здоровья — Ctrl+V). Сдайте задание сразу, как спасете пятнадцать: остальные продолжают умирать, и слишком много смертей проваливают задание даже после пометки «выполнено». При провале откажитесь от задания и возьмите его снова.",

	-- Step 27: Mageweave Bandage (225-240)
	-- {item:8544} Mageweave Bandage
	-- plural, as words: Mageweave Bandages = {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 225 (yellow at 210, green at 240, grey at 270): about 24 crafts to 240. Bandages need no fire: craft them anywhere. {item:8544} turns green at 240: switch to Heavy Mageweave there, which costs less cloth than green Mageweave Bandages to 260."] = "{item:8544} — желтый с 225 (желтый с 210, зеленый с 240, серый с 270): около 24 изготовлений до 240. Бинтам не нужен огонь: делайте их где угодно. {item:8544} зеленеет на 240: переходите на плотные бинты из магической ткани — до 260 они требуют меньше ткани, чем зеленые бинты из магической ткани.",

	-- Step 28: Heavy Mageweave Bandage
	-- {spell:10841} Heavy Mageweave Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:10841} (skill 240) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:10841} (навык 240) — рецепт искусника: ему обучает только доктор из задания {quest:6622} ({npc:12939} в Тераморе, {npc:12920} — {area:321}).",

	-- Step 29: Heavy Mageweave Bandage: cloth
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545}: cloth"] = "{item:8545}: ткань",

	-- Step 30: Heavy Mageweave Bandage (240-260)
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545} is yellow from 240 (yellow at 240, green at 270, grey at 300): about 25 crafts to 260. Bandages need no fire: craft them anywhere."] = "{item:8545} — желтый с 240 (желтый с 240, зеленый с 270, серый с 300): около 25 изготовлений до 260. Бинтам не нужен огонь: делайте их где угодно.",

	-- Step 31: Runecloth Bandage
	-- {spell:18629} Runecloth Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:18629} (навык 260) — рецепт искусника: ему обучает только доктор из задания {quest:6622} ({npc:12939} в Тераморе, {npc:12920} — {area:321}).",

	-- Step 32: Runecloth Bandage: cloth
	-- {item:14529} Runecloth Bandage
	["{item:14529}: cloth"] = "{item:14529}: ткань",
	-- {item:14047} Runecloth
	["humanoids of level 45-60 drop {item:14047} (or buy it at the Auction House)."] = "с гуманоидов 45-60 уровня падает {item:14047} (или купите на аукционе).",

	-- Step 33: Runecloth Bandage (260-300)
	-- {item:14529} Runecloth Bandage · {item:14047} Runecloth · {item:14530} Heavy Runecloth Bandage
	["{item:14529} is yellow from 260 (yellow at 260, green at 290, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} turns green at 290, yet to 300 it takes about the same {item:14047} as switching to {item:14530} (the doctor teaches it at 290): one recipe is enough."] = "{item:14529} — желтый с 260 (желтый с 260, зеленый с 290, серый с 320): около 65 изготовлений до 300. Бинтам не нужен огонь: делайте их где угодно. {item:14529} зеленеет на 290, но до 300 уходит примерно столько же ткани ({item:14047}), сколько при переходе на {item:14530} (доктор обучает на 290): хватит одного рецепта.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5); the arrow picks the nearest."] = "Любой учитель профессии «{skill:129}» вашей фракции обучает уровню «Ученик» ({skill:129}; 5-й уровень персонажа); стрелка выбирает ближайшего.",
	-- ["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}."] = "Уровень «Искусник» ({skill:129}) дается за задание {quest:6622}. Нужен навык 225 и 40-й уровень; учитель профессии «{skill:129}» в городе {zone:1454} отправляет вас к доктору: {area:321}.",
	-- ["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore."] = "Уровень «Искусник» ({skill:129}) дается за задание {quest:6624}. Нужен навык 225 и 40-й уровень; учитель профессии «{skill:129}» в городе {zone:1455} отправляет вас к доктору в Терамор.",
	-- ["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084}; the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals: buy both now, you read them at 180 and 210."] = "Уровень «Умелец» ({skill:129}) поднимает предел до 225; нужен навык 125 и 20-й уровень персонажа: это книга, {item:16084}; стрелка выбирает ближайшего продавца вашей фракции. Купите и прочтите ее. Тот же торговец продает учебники по плотным шелковым бинтам и {item:8544}: купите оба сейчас, прочтете их на 180 и 210.",
	-- ["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction. Learn {spell:3276} on the same visit."] = "Уровень «Подмастерье» ({skill:129}) поднимает предел до 150; нужен навык 50 и 10-й уровень персонажа: стрелка выбирает ближайшего учителя профессии «{skill:129}» вашей фракции. За тот же визит изучите {spell:3276}.",
	-- ["{item:1251} is orange from 1 (yellow at 30, grey at 60): about 61 crafts to 50. Bandages need no fire: craft them anywhere."] = "{item:1251} — оранжевый с 1 (желтый с 30, серый с 60): примерно 61 изготовление до 50. Для бинтов не нужен огонь: делайте их где угодно.",
	-- ["{item:14529} is yellow from 260 (yellow at 260, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth."] = "{item:14529}: желтый с 260 (желтый с 260, серый с 320) – около 65 изготовлений до 300. Бинтам не нужен огонь: делайте их где угодно. {item:14529} остается желтым до 320, так что доведет вас до 300 без похода за плотными бинтами из рунной ткани.",
	-- ["{item:2581} is yellow from 50 (yellow at 50, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere."] = "{item:2581} — желтый с 50 (желтый с 50, серый с 100): примерно 46 изготовлений до 80. Для бинтов не нужен огонь: делайте их где угодно.",
	-- ["{item:6450} is yellow from 150 (yellow at 150, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere."] = "{item:6450} — желтый с 150 (желтый с 150, серый с 210): примерно 42 изготовлений до 180. Для бинтов не нужен огонь: делайте их где угодно.",
	-- ["{item:6451} is yellow from 180 (yellow at 180, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451} — желтый с 180 (желтый с 180, серый с 240): примерно 42 изготовлений до 210. Для бинтов не нужен огонь: делайте их где угодно.",
	-- ["{item:8544} is yellow from 210 (yellow at 210, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544} — желтый с 210 (желтый с 210, серый с 270): примерно 18 изготовлений до 225. Для бинтов не нужен огонь: делайте их где угодно.",
	-- ["{item:8544} is yellow from 225 (yellow at 210, grey at 270): about 88 crafts to 260. Bandages need no fire: craft them anywhere. {item:8544} stays yellow to 270; one recipe to 260 saves two trips to the doctor."] = "{item:8544} — желтый с 225 (желтый с 210, серый с 270): примерно 88 изготовлений до 260. Для бинтов не нужен огонь: делайте их где угодно. {item:8544} остается желтым до 270; одного рецепта до 260 хватает, чтобы не ездить к доктору дважды.",
	-- ["{quest:6622}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6622}: лечите раненых солдат в палатке доктора выданными бинтами, сначала самых тяжелых, пока никто не умер.",
	-- ["{quest:6624}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6624}: лечите раненых солдат в палатке доктора выданными бинтами, сначала самых тяжелых, пока никто не умер.",
	-- ["{spell:3277} is yellow from 80 (yellow at 80, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it; the arrow picks the nearest."] = "{spell:3277} — желтый с 80 (желтый с 80, серый с 150): примерно 49 изготовлений до 115. Для бинтов не нужен огонь: делайте их где угодно. Ему обучает любой учитель профессии «{skill:129}» вашей фракции; стрелка выбирает ближайшего.",
	-- ["{spell:3278} is yellow from 115 (yellow at 115, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere."] = "{spell:3278} — желтый с 115 (желтый с 115, серый с 185): примерно 11 изготовлений до 125. Для бинтов не нужен огонь: делайте их где угодно.",
	-- ["{spell:3278} is yellow from 125 (yellow at 115, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278} — желтый с 125 (желтый с 115, серый с 185): примерно 38 изготовлений до 150. Для бинтов не нужен огонь: делайте их где угодно.",
}
