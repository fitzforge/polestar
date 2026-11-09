-- Chinese (simplified) (zhCN): the guide forever/professions/first-aid (forever/professions/first-aid.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn First Aid
	-- {skill:129} First Aid
	["Learn {skill:129}"] = "学习{skill:129}",
	-- {skill:129} First Aid · {item:118} Minor Healing Potion · {item:2447} Peacebloom · {item:2678} Mild Spices · {item:3371} Empty Vial · {skill:182} Herbalism
	-- plural, as words: Linen Bandages = {item:1251} Linen Bandage
	["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5, 1s); the arrow picks the nearest. Forever teaches {item:118} with it: {item:2447}, {item:2678} and an {item:3371}, orange to 55. With {skill:182} it can replace the Linen Bandages below."] = "你所在阵营的任何{skill:129}训练师都教授初级{skill:129}（角色等级5，1银）；箭头会指向最近的一位。无限会同时教授{item:118}：{item:2447}、{item:2678}和一个{item:3371}，55前为橙色。有{skill:182}的话，它可以替代下面的亚麻绷带。",

	-- Step 2: Linen Bandage: cloth
	-- {item:1251} Linen Bandage
	["{item:1251}: cloth"] = "{item:1251}：布料",
	-- {item:2589} Linen Cloth
	["humanoids of level 5-20 drop {item:2589} (or buy it at the Auction House)."] = "5-20级的人型生物会掉落{item:2589}（或在拍卖行购买）。",

	-- Step 3: Linen Bandage (1-40)
	-- {item:1251} Linen Bandage · {item:279968} First Aid Kit · {skill:129} First Aid · {item:159} Refreshing Spring Water
	-- plural, as words: Linen Bandages = {item:1251} Linen Bandage
	["{item:1251} is orange from 1 (yellow at 30, green at 45, grey at 60): about 41 crafts to 40. Bandages need no fire: craft them anywhere. At 20 the trainer also teaches {item:279968} (1s; the Camping 101: {skill:129} quest at your starting area's camp teaches it free), Forever's camping item for {skill:129}: three Linen Bandages and a {item:159}; it gives a few points until 25."] = "{item:1251}从1开始为橙色（30变黄，45变绿，60变灰）：约制作41次到40。绷带不需要火：随处都能制作。20时训练师还会教授{item:279968}（1银；起始区域营地的“野营入门101：{skill:129}”任务可免费学会），这是无限的{skill:129}野营物品：三条亚麻绷带和一瓶{item:159}；25前能提供少量点数。",

	-- Step 4: Heavy Linen Bandage: cloth
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: cloth"] = "{item:2581}：布料",

	-- Step 5: Heavy Linen Bandage (40-50)
	-- {item:2581} Heavy Linen Bandage · {skill:129} First Aid
	["{item:2581} is orange from 40 (yellow at 50, green at 75, grey at 100): about 10 crafts to 50. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 40 for 1s; the arrow picks the nearest."] = "{item:2581}从40开始为橙色（50变黄，75变绿，100变灰）：约制作10次到50。绷带不需要火：随处都能制作。你所在阵营的任何{skill:129}训练师在技能40时教授，花费1银；箭头会指向最近的一位。",

	-- Step 6: Journeyman First Aid
	-- {skill:129} First Aid
	["Journeyman {skill:129}"] = "中级{skill:129}",
	-- {skill:129} First Aid
	["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction; training costs 5s."] = "中级{skill:129}将上限提高到150；需要技能50和角色等级10：箭头会指向你所在阵营最近的{skill:129}训练师；训练花费5银。",

	-- Step 8: Heavy Linen Bandage (50-80)
	-- {item:2581} Heavy Linen Bandage · {item:858} Lesser Healing Potion · {item:2450} Briarthorn · {item:2678} Mild Spices · {item:3371} Empty Vial
	["{item:2581} is yellow from 50 (yellow at 50, green at 75, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere. Herbalists: {item:858} (from 55, 1s 50c; {item:2450}, two {item:2678} and an {item:3371}) is orange to 85."] = "{item:2581}从50开始为黄色（50变黄，75变绿，100变灰）：约制作46次到80。绷带不需要火：随处都能制作。草药师：{item:858}（55起，1银50铜；{item:2450}、两份{item:2678}和一个{item:3371}）在85前为橙色。",

	-- Step 9: Wool Bandage: cloth
	-- {spell:3277} Wool Bandage
	["{spell:3277}: cloth"] = "{spell:3277}：布料",
	-- {item:2592} Wool Cloth
	["humanoids of level 15-30 drop {item:2592} (or buy it at the Auction House)."] = "15-30级的人型生物会掉落{item:2592}（或在拍卖行购买）。",

	-- Step 10: Wool Bandage (80-115)
	-- {spell:3277} Wool Bandage · {skill:129} First Aid · {item:6452} Anti-Venom · {item:1475} Small Venom Sac · {spell:9810} Touch of Zanzil
	["{spell:3277} is yellow from 80 (yellow at 80, green at 115, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 80 for 2s 50c; the arrow picks the nearest. {item:6452} ({item:1475}, from spiders) is taught at 80 too: Rogues need it for {spell:9810}, and it sells."] = "{spell:3277}从80开始为黄色（80变黄，115变绿，150变灰）：约制作49次到115。绷带不需要火：随处都能制作。你所在阵营的任何{skill:129}训练师在技能80时教授，花费2银50铜；箭头会指向最近的一位。{item:6452}（{item:1475}，蜘蛛掉落）也在80时教授：盗贼的{spell:9810}需要它，也能卖钱。",

	-- Step 11: Heavy Wool Bandage: cloth
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: cloth"] = "{spell:3278}：布料",

	-- Step 12: Heavy Wool Bandage (115-125)
	-- {spell:3278} Heavy Wool Bandage · {skill:129} First Aid · {item:929} Healing Potion · {item:2453} Bruiseweed · {item:2692} Hot Spices · {item:3372} Leaded Vial
	["{spell:3278} is yellow from 115 (yellow at 115, green at 150, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 115 for 10s; the arrow picks the nearest. Herbalists: {item:929} (from 110, 8s; {item:2453}, {item:2692} and a {item:3372}) is orange to 135."] = "{spell:3278}从115开始为黄色（115变黄，150变绿，185变灰）：约制作11次到125。绷带不需要火：随处都能制作。你所在阵营的任何{skill:129}训练师在技能115时教授，花费10银；箭头会指向最近的一位。草药师：{item:929}（110起，8银；{item:2453}、{item:2692}和一个{item:3372}）在135前为橙色。",

	-- Step 13: Expert First Aid
	-- {skill:129} First Aid
	["Expert {skill:129}"] = "高级{skill:129}",
	-- {skill:129} First Aid · {item:16084} Expert First Aid - Under Wraps · {item:8544} Mageweave Bandage
	["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084} (1g); the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals (22s and 50s): buy both now, you read them at 180 and 210."] = "高级{skill:129}将上限提高到225；需要技能125和角色等级20：这是一本书，{item:16084}（1金）；箭头会指向你所在阵营最近的卖家。购买并阅读。同一商人还出售厚丝绸和{item:8544}的手册（22银和50银）：现在两本都买下，在180和210时阅读。",
	-- {item:16084} Expert First Aid - Under Wraps · {skill:129} First Aid
	["Buy and read {item:16084} (Expert {skill:129})"] = "购买并阅读{item:16084}（高级{skill:129}）",

	-- Step 15: Heavy Wool Bandage (125-150)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 125 (yellow at 115, green at 150, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278}从125开始为黄色（115变黄，150变绿，185变灰）：约制作38次到150。绷带不需要火：随处都能制作。",

	-- Step 16: Silk Bandage: cloth
	-- {item:6450} Silk Bandage
	["{item:6450}: cloth"] = "{item:6450}：布料",
	-- {item:4306} Silk Cloth
	["humanoids of level 25-45 drop {item:4306} (or buy it at the Auction House)."] = "25-45级的人型生物会掉落{item:4306}（或在拍卖行购买）。",

	-- Step 17: Silk Bandage (150-180)
	-- {item:6450} Silk Bandage · {skill:129} First Aid
	["{item:6450} is yellow from 150 (yellow at 150, green at 180, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 150 for 50s; the arrow picks the nearest."] = "{item:6450}从150开始为黄色（150变黄，180变绿，210变灰）：约制作42次到180。绷带不需要火：随处都能制作。你所在阵营的任何{skill:129}训练师在技能150时教授，花费50银；箭头会指向最近的一位。",

	-- Step 18: Heavy Silk Bandage: cloth
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: cloth"] = "{item:6451}：布料",

	-- Step 19: Heavy Silk Bandage (180-210)
	-- {item:6451} Heavy Silk Bandage
	["{item:6451} is yellow from 180 (yellow at 180, green at 210, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451}从180开始为黄色（180变黄，210变绿，240变灰）：约制作42次到210。绷带不需要火：随处都能制作。",

	-- Step 20: Mageweave Bandage: cloth
	-- {item:8544} Mageweave Bandage
	["{item:8544}: cloth"] = "{item:8544}：布料",
	-- {item:4338} Mageweave Cloth
	["humanoids of level 35-50 drop {item:4338} (or buy it at the Auction House)."] = "35-50级的人型生物会掉落{item:4338}（或在拍卖行购买）。",

	-- Step 21: Mageweave Bandage (210-225)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 210 (yellow at 210, green at 240, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544}从210开始为黄色（210变黄，240变绿，270变灰）：约制作18次到225。绷带不需要火：随处都能制作。",

	-- Step 22: Trauma
	["Trauma"] = "创伤",
	-- {skill:129} First Aid · {quest:6624} Triage · {zone:1455} Ironforge · {item:14047} Runecloth
	["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 35; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore. Bring the Mageweave (about 74) and {item:14047} (about 65) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages."] = "专家级{skill:129}来自{quest:6624}任务。需要技能225和等级35；{zone:1455}的{skill:129}训练师会派你去塞拉摩找医生。现在就带上225-300所需的魔纹布（约74）和{item:14047}（约65）：绷带不需要火，所以你可以在教授专家级绷带的医生旁边练到300。",

	-- Step 23: Trauma
	-- {skill:129} First Aid · {quest:6622} Triage · {zone:1454} Orgrimmar · {area:321} Hammerfall · {item:14047} Runecloth
	["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 35; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}. Bring the Mageweave (about 74) and {item:14047} (about 65) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages."] = "专家级{skill:129}来自{quest:6622}任务。需要技能225和等级35；{zone:1454}的{skill:129}训练师会派你去{area:321}找医生。现在就带上225-300所需的魔纹布（约74）和{item:14047}（约65）：绷带不需要火，所以你可以在教授专家级绷带的医生旁边练到300。",

	-- Step 24: Triage
	-- {quest:6624} Triage
	-- plural, as words: Triage Bandages = {item:16991} Triage Bandage
	["{quest:6624}: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie inside: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again."] = "{quest:6624}：医生会给你急救绷带；用这些，不要用你自己的。里面躺着十五名伤兵：在他们死亡前，先包扎危重伤员，再包扎重伤员，最后是伤员（按Ctrl+V显示生命条）。救满十五人后立即交还任务：其他人会继续死亡，死亡过多即使显示已完成也会失败。如果失败，放弃任务并重新接受。",
	-- {skill:129} First Aid
	["Artisan {skill:129}"] = "专家级{skill:129}",

	-- Step 25: Triage
	-- {quest:6622} Triage
	-- plural, as words: Triage Bandages = {item:16991} Triage Bandage
	["{quest:6622}: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie on the floor inside: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again."] = "{quest:6622}：医生会给你急救绷带；用这些，不要用你自己的。里面地上躺着十五名伤兵：在他们死亡前，先包扎危重伤员，再包扎重伤员，最后是伤员（按Ctrl+V显示生命条）。救满十五人后立即交还任务：其他人会继续死亡，死亡过多即使显示已完成也会失败。如果失败，放弃任务并重新接受。",

	-- Step 27: Mageweave Bandage (225-240)
	-- {item:8544} Mageweave Bandage
	-- plural, as words: Mageweave Bandages = {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 225 (yellow at 210, green at 240, grey at 270): about 24 crafts to 240. Bandages need no fire: craft them anywhere. {item:8544} turns green at 240: switch to Heavy Mageweave there, which costs less cloth than green Mageweave Bandages to 260."] = "{item:8544}从225开始为黄色（210变黄，240变绿，270变灰）：约制作24次到240。绷带不需要火：随处都能制作。{item:8544}在240变绿：届时改做厚魔纹绷带，到260比做绿色的魔纹绷带更省布。",

	-- Step 28: Heavy Mageweave Bandage
	-- {spell:10841} Heavy Mageweave Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:10841} (skill 240) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:10841}（技能240）是专家级配方：只有{quest:6622}的医生会教（塞拉摩的{npc:12939}，{area:321}的{npc:12920}）。",

	-- Step 29: Heavy Mageweave Bandage: cloth
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545}: cloth"] = "{item:8545}：布料",

	-- Step 30: Heavy Mageweave Bandage (240-260)
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545} is yellow from 240 (yellow at 240, green at 270, grey at 300): about 25 crafts to 260. Bandages need no fire: craft them anywhere."] = "{item:8545}从240开始为黄色（240变黄，270变绿，300变灰）：约制作25次到260。绷带不需要火：随处都能制作。",

	-- Step 31: Runecloth Bandage
	-- {spell:18629} Runecloth Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:18629}（技能260）是专家级配方：只有{quest:6622}的医生会教（塞拉摩的{npc:12939}，{area:321}的{npc:12920}）。",

	-- Step 32: Runecloth Bandage: cloth
	-- {item:14529} Runecloth Bandage
	["{item:14529}: cloth"] = "{item:14529}：布料",
	-- {item:14047} Runecloth
	["humanoids of level 45-60 drop {item:14047} (or buy it at the Auction House)."] = "45-60级的人型生物会掉落{item:14047}（或在拍卖行购买）。",

	-- Step 33: Runecloth Bandage (260-300)
	-- {item:14529} Runecloth Bandage · {item:14047} Runecloth · {item:14530} Heavy Runecloth Bandage
	["{item:14529} is yellow from 260 (yellow at 260, green at 290, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} turns green at 290, yet to 300 it takes about the same {item:14047} as switching to {item:14530} (the doctor teaches it at 290): one recipe is enough."] = "{item:14529}从260开始为黄色（260变黄，290变绿，320变灰）：约制作65次到300。绷带不需要火：随处都能制作。{item:14529}在290变绿，但到300所需的{item:14047}与改做{item:14530}（医生在290时教授）差不多：一个配方就够了。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5); the arrow picks the nearest."] = "你阵营的任何{skill:129}训练师都能教授初级{skill:129}（角色等级5级）；箭头会选择最近的一位。",
	-- ["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}."] = "专家级{skill:129}来自任务{quest:6622}。需要技能225和40级；{zone:1454}的{skill:129}训练师会让你去{area:321}找医生。",
	-- ["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore."] = "专家级{skill:129}来自任务{quest:6624}。需要技能225和40级；{zone:1455}的{skill:129}训练师会让你去塞拉摩找医生。",
	-- ["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084}; the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals: buy both now, you read them at 180 and 210."] = "高级{skill:129}将上限提高到225；需要技能125和角色等级20级：它是一本书，{item:16084}；箭头会选择你阵营最近的出售者。购买并阅读。同一个商人还出售厚丝质绷带和{item:8544}的手册：现在就把两本都买下，分别在180和210时阅读。",
	-- ["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction. Learn {spell:3276} on the same visit."] = "中级{skill:129}将上限提高到150；需要技能50和角色等级10级：箭头会选择你阵营最近的{skill:129}训练师。同时学习{spell:3276}。",
	-- ["{item:1251} is orange from 1 (yellow at 30, grey at 60): about 61 crafts to 50. Bandages need no fire: craft them anywhere."] = "{item:1251}从1开始为橙色（30变黄，60变灰）：做到50大约需要61次。绷带不需要火：随处都能制作。",
	-- ["{item:14529} is yellow from 260 (yellow at 260, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth."] = "{item:14529}从260开始为黄色（260变黄，320变灰）：做到300大约需要65次。绷带不需要火：随处都能制作。{item:14529}到320前都是黄色，所以不必为厚符文布绷带专程跑一趟就能升到300。",
	-- ["{item:2581} is yellow from 50 (yellow at 50, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere."] = "{item:2581}从50开始为黄色（50变黄，100变灰）：做到80大约需要46次。绷带不需要火：随处都能制作。",
	-- ["{item:6450} is yellow from 150 (yellow at 150, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere."] = "{item:6450}从150开始为黄色（150变黄，210变灰）：做到180大约需要42次。绷带不需要火：随处都能制作。",
	-- ["{item:6451} is yellow from 180 (yellow at 180, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451}从180开始为黄色（180变黄，240变灰）：做到210大约需要42次。绷带不需要火：随处都能制作。",
	-- ["{item:8544} is yellow from 210 (yellow at 210, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544}从210开始为黄色（210变黄，270变灰）：做到225大约需要18次。绷带不需要火：随处都能制作。",
	-- ["{item:8544} is yellow from 225 (yellow at 210, grey at 270): about 88 crafts to 260. Bandages need no fire: craft them anywhere. {item:8544} stays yellow to 270; one recipe to 260 saves two trips to the doctor."] = "{item:8544}从225开始为黄色（210变黄，270变灰）：做到260大约需要88次。绷带不需要火：随处都能制作。{item:8544}到270前都是黄色；用一个配方做到260可以省掉两趟去医生那里。",
	-- ["{quest:6622}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6622}：用医生给你的绷带治疗医生帐篷里的伤兵，先治最危急的，别让任何人死去。",
	-- ["{quest:6624}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6624}：用医生给你的绷带治疗医生帐篷里的伤兵，先治最危急的，别让任何人死去。",
	-- ["{spell:3277} is yellow from 80 (yellow at 80, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it; the arrow picks the nearest."] = "{spell:3277}从80开始为黄色（80变黄，150变灰）：做到115大约需要49次。绷带不需要火：随处都能制作。你阵营的任何{skill:129}训练师都能教授；箭头会选择最近的一位。",
	-- ["{spell:3278} is yellow from 115 (yellow at 115, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere."] = "{spell:3278}从115开始为黄色（115变黄，185变灰）：做到125大约需要11次。绷带不需要火：随处都能制作。",
	-- ["{spell:3278} is yellow from 125 (yellow at 115, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278}从125开始为黄色（115变黄，185变灰）：做到150大约需要38次。绷带不需要火：随处都能制作。",
}
