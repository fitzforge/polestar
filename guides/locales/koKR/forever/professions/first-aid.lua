-- Korean (koKR): the guide forever/professions/first-aid (forever/professions/first-aid.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn First Aid
	-- {skill:129} First Aid
	["Learn {skill:129}"] = "{skill:129} 배우기",
	-- {skill:129} First Aid
	["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5); the arrow picks the nearest."] = "진영의 모든 {skill:129} 상급자가 초급 {skill:129}을(를) 가르칩니다(캐릭터 레벨 5). 화살표가 가장 가까운 곳을 가리킵니다.",

	-- Step 2: Linen Bandage: cloth
	-- {item:1251} Linen Bandage
	["{item:1251}: cloth"] = "{item:1251}: 천",
	-- {item:2589} Linen Cloth
	["humanoids of level 5-20 drop {item:2589} (or buy it at the Auction House)."] = "5-20레벨 인간형 몹이 {item:2589}을(를) 떨어뜨립니다(경매장에서 사도 됩니다).",

	-- Step 3: Linen Bandage (1-50)
	-- {item:1251} Linen Bandage
	["{item:1251} is orange from 1 (yellow at 30, grey at 60): about 61 crafts to 50. Bandages need no fire: craft them anywhere."] = "{item:1251}은(는) 1부터 주황색입니다(노란색 30, 회색 60). 50까지 약 61번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",

	-- Step 4: Journeyman First Aid
	-- {skill:129} First Aid
	["Journeyman {skill:129}"] = "수습 {skill:129}",
	-- {skill:129} First Aid · {spell:3276} Heavy Linen Bandage
	["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction. Learn {spell:3276} on the same visit."] = "수습 {skill:129}은(는) 최대 숙련도를 150으로 올립니다. 숙련도 50, 캐릭터 레벨 10이 필요합니다. 화살표가 진영의 가장 가까운 {skill:129} 상급자를 가리킵니다. 같은 방문에 {spell:3276}도 배우세요.",

	-- Step 5: Heavy Linen Bandage: cloth
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: cloth"] = "{item:2581}: 천",

	-- Step 6: Heavy Linen Bandage (50-80)
	-- {item:2581} Heavy Linen Bandage
	["{item:2581} is yellow from 50 (yellow at 50, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere."] = "{item:2581}은(는) 50부터 노란색입니다(노란색 50, 회색 100). 80까지 약 46번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",

	-- Step 7: Wool Bandage: cloth
	-- {spell:3277} Wool Bandage
	["{spell:3277}: cloth"] = "{spell:3277}: 천",
	-- {item:2592} Wool Cloth
	["humanoids of level 15-30 drop {item:2592} (or buy it at the Auction House)."] = "15-30레벨 인간형 몹이 {item:2592}을(를) 떨어뜨립니다(경매장에서 사도 됩니다).",

	-- Step 8: Wool Bandage (80-115)
	-- {spell:3277} Wool Bandage · {skill:129} First Aid
	["{spell:3277} is yellow from 80 (yellow at 80, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it; the arrow picks the nearest."] = "{spell:3277}은(는) 80부터 노란색입니다(노란색 80, 회색 150). 115까지 약 49번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요. 진영의 모든 {skill:129} 상급자가 가르칩니다. 화살표가 가장 가까운 곳을 가리킵니다.",

	-- Step 9: Heavy Wool Bandage: cloth
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: cloth"] = "{spell:3278}: 천",

	-- Step 10: Heavy Wool Bandage (115-125)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 115 (yellow at 115, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere."] = "{spell:3278}은(는) 115부터 노란색입니다(노란색 115, 회색 185). 125까지 약 11번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",

	-- Step 11: Expert First Aid
	-- {skill:129} First Aid
	["Expert {skill:129}"] = "숙련 {skill:129}",
	-- {skill:129} First Aid · {item:16084} Expert First Aid - Under Wraps · {item:8544} Mageweave Bandage
	["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084}; the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals: buy both now, you read them at 180 and 210."] = "숙련 {skill:129}은(는) 최대 숙련도를 225로 올립니다. 숙련도 125, 캐릭터 레벨 20이 필요합니다. 책 {item:16084}(으)로 배우며, 화살표가 진영의 가장 가까운 판매 상인을 가리킵니다. 사서 읽으세요. 같은 상인이 두꺼운 비단 붕대와 {item:8544} 교본도 팝니다. 지금 둘 다 사 두고 180과 210에 읽으세요.",
	-- {item:16084} Expert First Aid - Under Wraps · {skill:129} First Aid
	["Buy and read {item:16084} (Expert {skill:129})"] = "{item:16084} 사서 읽기 (숙련 {skill:129})",

	-- Step 13: Heavy Wool Bandage (125-150)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 125 (yellow at 115, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278}은(는) 125부터 노란색입니다(노란색 115, 회색 185). 150까지 약 38번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",

	-- Step 14: Silk Bandage: cloth
	-- {item:6450} Silk Bandage
	["{item:6450}: cloth"] = "{item:6450}: 천",
	-- {item:4306} Silk Cloth
	["humanoids of level 25-45 drop {item:4306} (or buy it at the Auction House)."] = "25-45레벨 인간형 몹이 {item:4306}을(를) 떨어뜨립니다(경매장에서 사도 됩니다).",

	-- Step 15: Silk Bandage (150-180)
	-- {item:6450} Silk Bandage
	["{item:6450} is yellow from 150 (yellow at 150, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere."] = "{item:6450}은(는) 150부터 노란색입니다(노란색 150, 회색 210). 180까지 약 42번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",

	-- Step 16: Heavy Silk Bandage: cloth
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: cloth"] = "{item:6451}: 천",

	-- Step 17: Heavy Silk Bandage (180-210)
	-- {item:6451} Heavy Silk Bandage
	["{item:6451} is yellow from 180 (yellow at 180, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451}은(는) 180부터 노란색입니다(노란색 180, 회색 240). 210까지 약 42번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",

	-- Step 18: Mageweave Bandage: cloth
	-- {item:8544} Mageweave Bandage
	["{item:8544}: cloth"] = "{item:8544}: 천",
	-- {item:4338} Mageweave Cloth
	["humanoids of level 35-50 drop {item:4338} (or buy it at the Auction House)."] = "35-50레벨 인간형 몹이 {item:4338}을(를) 떨어뜨립니다(경매장에서 사도 됩니다).",

	-- Step 19: Mageweave Bandage (210-225)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 210 (yellow at 210, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544}은(는) 210부터 노란색입니다(노란색 210, 회색 270). 225까지 약 18번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",

	-- Step 20: Trauma
	["Trauma"] = "외상 치료",
	-- {skill:129} First Aid · {quest:6624} Triage · {zone:1455} Ironforge
	["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore."] = "전문 {skill:129}은(는) {quest:6624} 퀘스트로 배웁니다. 숙련도 225, 레벨 40이 필요합니다. {zone:1455}의 {skill:129} 상급자가 테라모어 섬의 의사에게 보냅니다.",

	-- Step 21: Trauma
	-- {skill:129} First Aid · {quest:6622} Triage · {zone:1454} Orgrimmar · {area:321} Hammerfall
	["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}."] = "전문 {skill:129}은(는) {quest:6622} 퀘스트로 배웁니다. 숙련도 225, 레벨 40이 필요합니다. {zone:1454}의 {skill:129} 상급자가 {area:321}의 의사에게 보냅니다.",

	-- Step 22: Triage
	-- {quest:6624} Triage
	["{quest:6624}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6624}: 의사의 천막에 있는 부상병을 의사가 주는 붕대로 치료하세요. 누구도 죽기 전에 가장 위독한 병사부터 치료하세요.",
	-- {skill:129} First Aid
	["Artisan {skill:129}"] = "전문 {skill:129}",

	-- Step 23: Triage
	-- {quest:6622} Triage
	["{quest:6622}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6622}: 의사의 천막에 있는 부상병을 의사가 주는 붕대로 치료하세요. 누구도 죽기 전에 가장 위독한 병사부터 치료하세요.",

	-- Step 25: Mageweave Bandage (225-260)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 225 (yellow at 210, grey at 270): about 88 crafts to 260. Bandages need no fire: craft them anywhere. {item:8544} stays yellow to 270; one recipe to 260 saves two trips to the doctor."] = "{item:8544}은(는) 225부터 노란색입니다(노란색 210, 회색 270). 260까지 약 88번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요. {item:8544}은(는) 270까지 노란색이라, 이 제조법 하나로 260까지 올리면 의사에게 두 번 갈 필요가 없습니다.",

	-- Step 26: Runecloth Bandage
	-- {spell:18629} Runecloth Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:18629}(숙련도 260)은(는) 전문 제조법입니다. {quest:6622}의 의사만 가르칩니다(테라모어 섬의 {npc:12939}, {area:321}의 {npc:12920}).",

	-- Step 27: Runecloth Bandage: cloth
	-- {item:14529} Runecloth Bandage
	["{item:14529}: cloth"] = "{item:14529}: 천",
	-- {item:14047} Runecloth
	["humanoids of level 45-60 drop {item:14047} (or buy it at the Auction House)."] = "45-60레벨 인간형 몹이 {item:14047}을(를) 떨어뜨립니다(경매장에서 사도 됩니다).",

	-- Step 28: Runecloth Bandage (260-300)
	-- {item:14529} Runecloth Bandage
	["{item:14529} is yellow from 260 (yellow at 260, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth."] = "{item:14529}은(는) 260부터 노란색입니다(260에서 노란색, 320에서 회색). 300까지 약 65번 만드세요. 붕대는 불이 필요 없어 어디서나 만들 수 있습니다. {item:14529}은(는) 320까지 노란색이라, 두꺼운 룬매듭 붕대를 배우러 가지 않고도 300까지 올릴 수 있습니다.",
}
