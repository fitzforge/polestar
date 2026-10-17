-- Chinese (simplified) (zhCN): the guide forever/professions/first-aid (forever/professions/first-aid.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn First Aid
	-- {skill:129} First Aid
	["Learn {skill:129}"] = "学习{skill:129}",
	-- {skill:129} First Aid
	["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5); the arrow picks the nearest."] = "你阵营的任何{skill:129}训练师都能教授初级{skill:129}（角色等级5级）；箭头会选择最近的一位。",

	-- Step 2: Linen Bandage: cloth
	-- {item:1251} Linen Bandage
	["{item:1251}: cloth"] = "{item:1251}：布料",
	-- {item:2589} Linen Cloth
	["humanoids of level 5-20 drop {item:2589} (or buy it at the Auction House)."] = "5-20级的人型生物会掉落{item:2589}（或在拍卖行购买）。",

	-- Step 3: Linen Bandage (1-50)
	-- {item:1251} Linen Bandage
	["{item:1251} is orange from 1 (yellow at 30, grey at 60): about 61 crafts to 50. Bandages need no fire: craft them anywhere."] = "{item:1251}从1开始为橙色（30变黄，60变灰）：做到50大约需要61次。绷带不需要火：随处都能制作。",

	-- Step 4: Journeyman First Aid
	-- {skill:129} First Aid
	["Journeyman {skill:129}"] = "中级{skill:129}",
	-- {skill:129} First Aid · {spell:3276} Heavy Linen Bandage
	["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction. Learn {spell:3276} on the same visit."] = "中级{skill:129}将上限提高到150；需要技能50和角色等级10级：箭头会选择你阵营最近的{skill:129}训练师。同时学习{spell:3276}。",

	-- Step 5: Heavy Linen Bandage: cloth
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: cloth"] = "{item:2581}：布料",

	-- Step 6: Heavy Linen Bandage (50-80)
	-- {item:2581} Heavy Linen Bandage
	["{item:2581} is yellow from 50 (yellow at 50, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere."] = "{item:2581}从50开始为黄色（50变黄，100变灰）：做到80大约需要46次。绷带不需要火：随处都能制作。",

	-- Step 7: Wool Bandage: cloth
	-- {spell:3277} Wool Bandage
	["{spell:3277}: cloth"] = "{spell:3277}：布料",
	-- {item:2592} Wool Cloth
	["humanoids of level 15-30 drop {item:2592} (or buy it at the Auction House)."] = "15-30级的人型生物会掉落{item:2592}（或在拍卖行购买）。",

	-- Step 8: Wool Bandage (80-115)
	-- {spell:3277} Wool Bandage · {skill:129} First Aid
	["{spell:3277} is yellow from 80 (yellow at 80, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it; the arrow picks the nearest."] = "{spell:3277}从80开始为黄色（80变黄，150变灰）：做到115大约需要49次。绷带不需要火：随处都能制作。你阵营的任何{skill:129}训练师都能教授；箭头会选择最近的一位。",

	-- Step 9: Heavy Wool Bandage: cloth
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: cloth"] = "{spell:3278}：布料",

	-- Step 10: Heavy Wool Bandage (115-125)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 115 (yellow at 115, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere."] = "{spell:3278}从115开始为黄色（115变黄，185变灰）：做到125大约需要11次。绷带不需要火：随处都能制作。",

	-- Step 11: Expert First Aid
	-- {skill:129} First Aid
	["Expert {skill:129}"] = "高级{skill:129}",
	-- {skill:129} First Aid · {item:16084} Expert First Aid - Under Wraps · {item:8544} Mageweave Bandage
	["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084}; the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals: buy both now, you read them at 180 and 210."] = "高级{skill:129}将上限提高到225；需要技能125和角色等级20级：它是一本书，{item:16084}；箭头会选择你阵营最近的出售者。购买并阅读。同一个商人还出售厚丝质绷带和{item:8544}的手册：现在就把两本都买下，分别在180和210时阅读。",
	-- {item:16084} Expert First Aid - Under Wraps · {skill:129} First Aid
	["Buy and read {item:16084} (Expert {skill:129})"] = "购买并阅读{item:16084}（高级{skill:129}）",

	-- Step 13: Heavy Wool Bandage (125-150)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 125 (yellow at 115, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278}从125开始为黄色（115变黄，185变灰）：做到150大约需要38次。绷带不需要火：随处都能制作。",

	-- Step 14: Silk Bandage: cloth
	-- {item:6450} Silk Bandage
	["{item:6450}: cloth"] = "{item:6450}：布料",
	-- {item:4306} Silk Cloth
	["humanoids of level 25-45 drop {item:4306} (or buy it at the Auction House)."] = "25-45级的人型生物会掉落{item:4306}（或在拍卖行购买）。",

	-- Step 15: Silk Bandage (150-180)
	-- {item:6450} Silk Bandage
	["{item:6450} is yellow from 150 (yellow at 150, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere."] = "{item:6450}从150开始为黄色（150变黄，210变灰）：做到180大约需要42次。绷带不需要火：随处都能制作。",

	-- Step 16: Heavy Silk Bandage: cloth
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: cloth"] = "{item:6451}：布料",

	-- Step 17: Heavy Silk Bandage (180-210)
	-- {item:6451} Heavy Silk Bandage
	["{item:6451} is yellow from 180 (yellow at 180, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451}从180开始为黄色（180变黄，240变灰）：做到210大约需要42次。绷带不需要火：随处都能制作。",

	-- Step 18: Mageweave Bandage: cloth
	-- {item:8544} Mageweave Bandage
	["{item:8544}: cloth"] = "{item:8544}：布料",
	-- {item:4338} Mageweave Cloth
	["humanoids of level 35-50 drop {item:4338} (or buy it at the Auction House)."] = "35-50级的人型生物会掉落{item:4338}（或在拍卖行购买）。",

	-- Step 19: Mageweave Bandage (210-225)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 210 (yellow at 210, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544}从210开始为黄色（210变黄，270变灰）：做到225大约需要18次。绷带不需要火：随处都能制作。",

	-- Step 20: Trauma
	["Trauma"] = "创伤",
	-- {skill:129} First Aid · {quest:6624} Triage · {zone:1455} Ironforge
	["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore."] = "专家级{skill:129}来自任务{quest:6624}。需要技能225和40级；{zone:1455}的{skill:129}训练师会让你去塞拉摩找医生。",

	-- Step 21: Trauma
	-- {skill:129} First Aid · {quest:6622} Triage · {zone:1454} Orgrimmar · {area:321} Hammerfall
	["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}."] = "专家级{skill:129}来自任务{quest:6622}。需要技能225和40级；{zone:1454}的{skill:129}训练师会让你去{area:321}找医生。",

	-- Step 22: Triage
	-- {quest:6624} Triage
	["{quest:6624}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6624}：用医生给你的绷带治疗医生帐篷里的伤兵，先治最危急的，别让任何人死去。",
	-- {skill:129} First Aid
	["Artisan {skill:129}"] = "专家级{skill:129}",

	-- Step 23: Triage
	-- {quest:6622} Triage
	["{quest:6622}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6622}：用医生给你的绷带治疗医生帐篷里的伤兵，先治最危急的，别让任何人死去。",

	-- Step 25: Mageweave Bandage (225-260)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 225 (yellow at 210, grey at 270): about 88 crafts to 260. Bandages need no fire: craft them anywhere. {item:8544} stays yellow to 270; one recipe to 260 saves two trips to the doctor."] = "{item:8544}从225开始为黄色（210变黄，270变灰）：做到260大约需要88次。绷带不需要火：随处都能制作。{item:8544}到270前都是黄色；用一个配方做到260可以省掉两趟去医生那里。",

	-- Step 26: Runecloth Bandage
	-- {spell:18629} Runecloth Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:18629}（技能260）是专家级配方：只有{quest:6622}的医生会教（塞拉摩的{npc:12939}，{area:321}的{npc:12920}）。",

	-- Step 27: Runecloth Bandage: cloth
	-- {item:14529} Runecloth Bandage
	["{item:14529}: cloth"] = "{item:14529}：布料",
	-- {item:14047} Runecloth
	["humanoids of level 45-60 drop {item:14047} (or buy it at the Auction House)."] = "45-60级的人型生物会掉落{item:14047}（或在拍卖行购买）。",

	-- Step 28: Runecloth Bandage (260-300)
	-- {item:14529} Runecloth Bandage
	["{item:14529} is yellow from 260 (yellow at 260, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth."] = "{item:14529}从260开始为黄色（260变黄，320变灰）：做到300大约需要65次。绷带不需要火：随处都能制作。{item:14529}到320前都是黄色，所以不必为厚符文布绷带专程跑一趟就能升到300。",
}
