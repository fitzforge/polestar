-- Chinese (traditional) (zhTW): the guide forever/professions/first-aid (forever/professions/first-aid.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn First Aid
	-- {skill:129} First Aid
	["Learn {skill:129}"] = "學習{skill:129}",
	-- {skill:129} First Aid · {item:118} Minor Healing Potion · {item:2447} Peacebloom · {item:2678} Mild Spices · {item:3371} Empty Vial · {skill:182} Herbalism
	-- plural, as words: Linen Bandages = {item:1251} Linen Bandage
	["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5, 1s); the arrow picks the nearest. Forever teaches {item:118} with it: {item:2447}, {item:2678} and an {item:3371}, orange to 55. With {skill:182} it can replace the Linen Bandages below."] = "",

	-- Step 2: Linen Bandage: cloth
	-- {item:1251} Linen Bandage
	["{item:1251}: cloth"] = "{item:1251}：布料",
	-- {item:2589} Linen Cloth
	["humanoids of level 5-20 drop {item:2589} (or buy it at the Auction House)."] = "5-20級的人型生物會掉落{item:2589}（或在拍賣場購買）。",

	-- Step 3: Linen Bandage (1-40)
	-- {item:1251} Linen Bandage · {item:279968} First Aid Kit · {skill:129} First Aid · {item:159} Refreshing Spring Water
	-- plural, as words: Linen Bandages = {item:1251} Linen Bandage
	["{item:1251} is orange from 1 (yellow at 30, green at 45, grey at 60): about 41 crafts to 40. Bandages need no fire: craft them anywhere. At 20 the trainer also teaches {item:279968} (1s; the Camping 101: {skill:129} quest at your starting area's camp teaches it free), Forever's camping item for {skill:129}: three Linen Bandages and a {item:159}; it gives a few points until 25."] = "",

	-- Step 4: Heavy Linen Bandage: cloth
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: cloth"] = "{item:2581}：布料",

	-- Step 5: Heavy Linen Bandage (40-50)
	-- {item:2581} Heavy Linen Bandage · {skill:129} First Aid
	["{item:2581} is orange from 40 (yellow at 50, green at 75, grey at 100): about 10 crafts to 50. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 40 for 1s; the arrow picks the nearest."] = "",

	-- Step 6: Journeyman First Aid
	-- {skill:129} First Aid
	["Journeyman {skill:129}"] = "中級{skill:129}",
	-- {skill:129} First Aid
	["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction; training costs 5s."] = "",

	-- Step 8: Heavy Linen Bandage (50-80)
	-- {item:2581} Heavy Linen Bandage · {item:858} Lesser Healing Potion · {item:2450} Briarthorn · {item:2678} Mild Spices · {item:3371} Empty Vial
	["{item:2581} is yellow from 50 (yellow at 50, green at 75, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere. Herbalists: {item:858} (from 55, 1s 50c; {item:2450}, two {item:2678} and an {item:3371}) is orange to 85."] = "",

	-- Step 9: Wool Bandage: cloth
	-- {spell:3277} Wool Bandage
	["{spell:3277}: cloth"] = "{spell:3277}：布料",
	-- {item:2592} Wool Cloth
	["humanoids of level 15-30 drop {item:2592} (or buy it at the Auction House)."] = "15-30級的人型生物會掉落{item:2592}（或在拍賣場購買）。",

	-- Step 10: Wool Bandage (80-115)
	-- {spell:3277} Wool Bandage · {skill:129} First Aid · {item:6452} Anti-Venom · {item:1475} Small Venom Sac
	["{spell:3277} is yellow from 80 (yellow at 80, green at 115, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 80 for 2s 50c; the arrow picks the nearest. {item:6452} ({item:1475}, from spiders) is taught at 80 too: Rogues need it for Touch of Zanzil, and it sells."] = "",

	-- Step 11: Heavy Wool Bandage: cloth
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: cloth"] = "{spell:3278}：布料",

	-- Step 12: Heavy Wool Bandage (115-125)
	-- {spell:3278} Heavy Wool Bandage · {skill:129} First Aid · {item:929} Healing Potion · {item:2453} Bruiseweed · {item:2692} Hot Spices · {item:3372} Leaded Vial
	["{spell:3278} is yellow from 115 (yellow at 115, green at 150, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 115 for 10s; the arrow picks the nearest. Herbalists: {item:929} (from 110, 8s; {item:2453}, {item:2692} and a {item:3372}) is orange to 135."] = "",

	-- Step 13: Expert First Aid
	-- {skill:129} First Aid
	["Expert {skill:129}"] = "高級{skill:129}",
	-- {skill:129} First Aid · {item:16084} Expert First Aid - Under Wraps · {item:8544} Mageweave Bandage
	["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084} (1g); the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals (22s and 50s): buy both now, you read them at 180 and 210."] = "",
	-- {item:16084} Expert First Aid - Under Wraps · {skill:129} First Aid
	["Buy and read {item:16084} (Expert {skill:129})"] = "購買並閱讀{item:16084}（高級{skill:129}）",

	-- Step 15: Heavy Wool Bandage (125-150)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 125 (yellow at 115, green at 150, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "",

	-- Step 16: Silk Bandage: cloth
	-- {item:6450} Silk Bandage
	["{item:6450}: cloth"] = "{item:6450}：布料",
	-- {item:4306} Silk Cloth
	["humanoids of level 25-45 drop {item:4306} (or buy it at the Auction House)."] = "25-45級的人型生物會掉落{item:4306}（或在拍賣場購買）。",

	-- Step 17: Silk Bandage (150-180)
	-- {item:6450} Silk Bandage · {skill:129} First Aid
	["{item:6450} is yellow from 150 (yellow at 150, green at 180, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 150 for 50s; the arrow picks the nearest."] = "",

	-- Step 18: Heavy Silk Bandage: cloth
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: cloth"] = "{item:6451}：布料",

	-- Step 19: Heavy Silk Bandage (180-210)
	-- {item:6451} Heavy Silk Bandage
	["{item:6451} is yellow from 180 (yellow at 180, green at 210, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "",

	-- Step 20: Mageweave Bandage: cloth
	-- {item:8544} Mageweave Bandage
	["{item:8544}: cloth"] = "{item:8544}：布料",
	-- {item:4338} Mageweave Cloth
	["humanoids of level 35-50 drop {item:4338} (or buy it at the Auction House)."] = "35-50級的人型生物會掉落{item:4338}（或在拍賣場購買）。",

	-- Step 21: Mageweave Bandage (210-225)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 210 (yellow at 210, green at 240, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "",

	-- Step 22: Trauma
	["Trauma"] = "創傷",
	-- {skill:129} First Aid · {quest:6624} Triage · {zone:1455} Ironforge · {item:14047} Runecloth
	["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 35; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore. Bring the Mageweave (about 74) and {item:14047} (about 65) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages."] = "",

	-- Step 23: Trauma
	-- {skill:129} First Aid · {quest:6622} Triage · {zone:1454} Orgrimmar · {item:14047} Runecloth
	["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 35; the {skill:129} trainer in {zone:1454} sends you to the doctor in Hammerfall. Bring the Mageweave (about 74) and {item:14047} (about 65) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages."] = "",

	-- Step 24: Triage
	-- {quest:6624} Triage
	-- plural, as words: Triage Bandages = {item:16991} Triage Bandage
	["{quest:6624}: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie inside: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again."] = "",
	-- {skill:129} First Aid
	["Artisan {skill:129}"] = "專家級{skill:129}",

	-- Step 25: Triage
	-- {quest:6622} Triage
	-- plural, as words: Triage Bandages = {item:16991} Triage Bandage
	["{quest:6622}: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie on the floor inside: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again."] = "",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, Hammerfall"] = "",

	-- Step 27: Mageweave Bandage (225-240)
	-- {item:8544} Mageweave Bandage
	-- plural, as words: Mageweave Bandages = {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 225 (yellow at 210, green at 240, grey at 270): about 24 crafts to 240. Bandages need no fire: craft them anywhere. {item:8544} turns green at 240: switch to Heavy Mageweave there, which costs less cloth than green Mageweave Bandages to 260."] = "",

	-- Step 28: Heavy Mageweave Bandage
	-- {spell:10841} Heavy Mageweave Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor
	["{spell:10841} (skill 240) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in Hammerfall)."] = "",

	-- Step 29: Heavy Mageweave Bandage: cloth
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545}: cloth"] = "",

	-- Step 30: Heavy Mageweave Bandage (240-260)
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545} is yellow from 240 (yellow at 240, green at 270, grey at 300): about 25 crafts to 260. Bandages need no fire: craft them anywhere."] = "",

	-- Step 31: Runecloth Bandage
	-- {spell:18629} Runecloth Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor
	["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in Hammerfall)."] = "",

	-- Step 32: Runecloth Bandage: cloth
	-- {item:14529} Runecloth Bandage
	["{item:14529}: cloth"] = "{item:14529}：布料",
	-- {item:14047} Runecloth
	["humanoids of level 45-60 drop {item:14047} (or buy it at the Auction House)."] = "45-60級的人型生物會掉落{item:14047}（或在拍賣場購買）。",

	-- Step 33: Runecloth Bandage (260-300)
	-- {item:14529} Runecloth Bandage · {item:14047} Runecloth · {item:14530} Heavy Runecloth Bandage
	["{item:14529} is yellow from 260 (yellow at 260, green at 290, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} turns green at 290, yet to 300 it takes about the same {item:14047} as switching to {item:14530} (the doctor teaches it at 290): one recipe is enough."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5); the arrow picks the nearest."] = "你陣營的任何{skill:129}訓練師都能教初級{skill:129}（角色等級5）；箭頭會指向最近的一位。",
	-- ["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}."] = "專家級{skill:129}來自{quest:6622}任務。需要技能225和等級40；{zone:1454}的{skill:129}訓練師會派你去找{area:321}的醫生。",
	-- ["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore."] = "專家級{skill:129}來自{quest:6624}任務。需要技能225和等級40；{zone:1455}的{skill:129}訓練師會派你去找塞拉摩的醫生。",
	-- ["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084}; the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals: buy both now, you read them at 180 and 210."] = "高級{skill:129}將上限提高到225；需要技能125和角色等級20：它是一本書，{item:16084}；箭頭會指向你陣營最近的賣家。買下並閱讀。同一個商人也出售厚絲質繃帶和{item:8544}的手冊：現在兩本都買，你會在180和210時閱讀。",
	-- ["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction. Learn {spell:3276} on the same visit."] = "中級{skill:129}將上限提高到150；需要技能50和角色等級10：箭頭會指向你陣營最近的{skill:129}訓練師。在同一次拜訪中學會{spell:3276}。",
	-- ["{item:1251} is orange from 1 (yellow at 30, grey at 60): about 61 crafts to 50. Bandages need no fire: craft them anywhere."] = "{item:1251}從1起為橘色（30變黃，60變灰）：製作約61次到50。繃帶不需要火堆：隨處都能製作。",
	-- ["{item:14529} is yellow from 260 (yellow at 260, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth."] = "{item:14529}從260起為黃色（260變黃，320變灰）：製作約65次到300。繃帶不需要火堆：隨處都能製作。{item:14529}到320前都是黃色，所以不必為了厚符文布繃帶跑一趟就能練到300。",
	-- ["{item:2581} is yellow from 50 (yellow at 50, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere."] = "{item:2581}從50起為黃色（50變黃，100變灰）：製作約46次到80。繃帶不需要火堆：隨處都能製作。",
	-- ["{item:6450} is yellow from 150 (yellow at 150, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere."] = "{item:6450}從150起為黃色（150變黃，210變灰）：製作約42次到180。繃帶不需要火堆：隨處都能製作。",
	-- ["{item:6451} is yellow from 180 (yellow at 180, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451}從180起為黃色（180變黃，240變灰）：製作約42次到210。繃帶不需要火堆：隨處都能製作。",
	-- ["{item:8544} is yellow from 210 (yellow at 210, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544}從210起為黃色（210變黃，270變灰）：製作約18次到225。繃帶不需要火堆：隨處都能製作。",
	-- ["{item:8544} is yellow from 225 (yellow at 210, grey at 270): about 88 crafts to 260. Bandages need no fire: craft them anywhere. {item:8544} stays yellow to 270; one recipe to 260 saves two trips to the doctor."] = "{item:8544}從225起為黃色（210變黃，270變灰）：製作約88次到260。繃帶不需要火堆：隨處都能製作。{item:8544}到270前都是黃色；用同一個配方練到260，可以少跑兩趟醫生那裡。",
	-- ["{quest:6622}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6622}：用醫生給你的繃帶治療醫生帳篷裡的受傷士兵，先治療最危急的，別讓任何一個死掉。",
	-- ["{quest:6624}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6624}：用醫生給你的繃帶治療醫生帳篷裡的受傷士兵，先治療最危急的，別讓任何一個死掉。",
	-- ["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:18629}（技能260）是專家級配方：只有{quest:6622}的醫生會教（塞拉摩的{npc:12939}，{area:321}的{npc:12920}）。",
	-- ["{spell:3277} is yellow from 80 (yellow at 80, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it; the arrow picks the nearest."] = "{spell:3277}從80起為黃色（80變黃，150變灰）：製作約49次到115。繃帶不需要火堆：隨處都能製作。你陣營的任何{skill:129}訓練師都能教；箭頭會指向最近的一位。",
	-- ["{spell:3278} is yellow from 115 (yellow at 115, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere."] = "{spell:3278}從115起為黃色（115變黃，185變灰）：製作約11次到125。繃帶不需要火堆：隨處都能製作。",
	-- ["{spell:3278} is yellow from 125 (yellow at 115, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278}從125起為黃色（115變黃，185變灰）：製作約38次到150。繃帶不需要火堆：隨處都能製作。",
}
