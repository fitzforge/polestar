-- Korean (koKR): the guide forever/professions/first-aid (forever/professions/first-aid.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn First Aid
	-- {skill:129} First Aid
	["Learn {skill:129}"] = "{skill:129} 배우기",
	-- {skill:129} First Aid · {item:118} Minor Healing Potion · {item:2447} Peacebloom · {item:2678} Mild Spices · {item:3371} Empty Vial · {skill:182} Herbalism
	-- plural, as words: Linen Bandages = {item:1251} Linen Bandage
	["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (any character level, 1s); the arrow picks the nearest. Forever teaches {item:118} with it: {item:2447}, {item:2678} and an {item:3371}, orange to 55. With {skill:182} it can replace the Linen Bandages below."] = "진영의 모든 {skill:129} 상급자가 초급 {skill:129}을(를) 가르칩니다(캐릭터 레벨 제한 없음, 1실버). 화살표가 가장 가까운 상급자를 가리킵니다. Forever에서는 이때 {item:118}도 가르쳐 줍니다: {item:2447}, {item:2678}, {item:3371} 1개가 들며, 55까지 주황색입니다. {skill:182}이(가) 있으면 아래의 리넨 붕대 대신 쓸 수 있습니다.",

	-- Step 2: Linen Bandage: Auction House
	-- {item:1251} Linen Bandage
	["{item:1251}: Auction House"] = "{item:1251}: 경매장",
	-- {item:1251} Linen Bandage · {item:2589} Linen Cloth
	["What {item:1251} takes that the Auction House sells: 41 {item:2589}. The counts drop by what your bags, bank and mail hold."] = "{item:1251}에 필요한 것 중 경매장에서 파는 것: {item:2589} 41개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",

	-- Step 3: Linen Bandage: cloth
	-- {item:1251} Linen Bandage
	["{item:1251}: cloth"] = "{item:1251}: 천",
	-- {item:2589} Linen Cloth
	["{item:2589} drops from humanoids of level 5-20: keep what you loot as you level, or take it from your bank."] = "{item:2589}은(는) 5-20레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나 은행에서 꺼내세요.",

	-- Step 4: Linen Bandage (1-40)
	-- {item:1251} Linen Bandage · {item:279968} First Aid Kit · {skill:129} First Aid · {item:159} Refreshing Spring Water
	-- plural, as words: Linen Bandages = {item:1251} Linen Bandage
	["{item:1251} is orange from 1 (yellow at 30, green at 45, grey at 60): about 41 crafts to 40. Bandages need no fire: craft them anywhere. At 20 the trainer also teaches {item:279968} (1s; the Camping 101: {skill:129} quest at your starting area's camp teaches it free), Forever's camping item for {skill:129}: three Linen Bandages and a {item:159}; it gives a few points until 25."] = "",

	-- Step 5: Heavy Linen Bandage: Auction House
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: Auction House"] = "{item:2581}: 경매장",
	-- {item:2581} Heavy Linen Bandage · {item:2589} Linen Cloth
	["What {item:2581} takes that the Auction House sells: 20 {item:2589}. The counts drop by what your bags, bank and mail hold."] = "{item:2581}에 필요한 것 중 경매장에서 파는 것: {item:2589} 20개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",

	-- Step 6: Heavy Linen Bandage: cloth
	-- {item:2581} Heavy Linen Bandage
	["{item:2581}: cloth"] = "{item:2581}: 천",

	-- Step 7: Heavy Linen Bandage (40-50)
	-- {item:2581} Heavy Linen Bandage · {skill:129} First Aid
	["{item:2581} is orange from 40 (yellow at 50, green at 75, grey at 100): about 10 crafts to 50. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 40 for 1s; the arrow picks the nearest."] = "",

	-- Step 8: Journeyman First Aid
	-- {skill:129} First Aid
	["Journeyman {skill:129}"] = "수습 {skill:129}",
	-- {skill:129} First Aid
	["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and no character level: the arrow picks the nearest {skill:129} trainer of your faction; training costs 5s."] = "수습 {skill:129}은(는) 최대 숙련도를 150으로 올립니다. 숙련도 50이 필요하고 캐릭터 레벨 제한은 없습니다. 화살표가 진영의 가장 가까운 {skill:129} 상급자를 가리킵니다. 훈련 비용은 5실버입니다.",

	-- Step 9: Heavy Linen Bandage: Auction House
	-- {item:2581} Heavy Linen Bandage · {item:2589} Linen Cloth
	["What {item:2581} takes that the Auction House sells: 92 {item:2589}. The counts drop by what your bags, bank and mail hold."] = "{item:2581}에 필요한 것 중 경매장에서 파는 것: {item:2589} 92개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",

	-- Step 11: Heavy Linen Bandage (50-80)
	-- {item:2581} Heavy Linen Bandage · {item:858} Lesser Healing Potion · {item:2450} Briarthorn · {item:2678} Mild Spices · {item:3371} Empty Vial
	["{item:2581} is yellow from 50 (yellow at 50, green at 75, grey at 100): about 46 crafts to 80. Bandages need no fire: craft them anywhere. Herbalists: {item:858} (from 55, 1s 50c; {item:2450}, two {item:2678} and an {item:3371}) is orange to 85."] = "",

	-- Step 12: Wool Bandage: Auction House
	-- {spell:3277} Wool Bandage
	["{spell:3277}: Auction House"] = "{spell:3277}: 경매장",
	-- {spell:3277} Wool Bandage · {item:2592} Wool Cloth
	["What {spell:3277} takes that the Auction House sells: 49 {item:2592}. The counts drop by what your bags, bank and mail hold."] = "{spell:3277}에 필요한 것 중 경매장에서 파는 것: {item:2592} 49개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",

	-- Step 13: Wool Bandage: cloth
	-- {spell:3277} Wool Bandage
	["{spell:3277}: cloth"] = "{spell:3277}: 천",
	-- {item:2592} Wool Cloth
	["{item:2592} drops from humanoids of level 15-30: keep what you loot as you level, or take it from your bank."] = "{item:2592}은(는) 15-30레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나 은행에서 꺼내세요.",

	-- Step 14: Wool Bandage (80-115)
	-- {spell:3277} Wool Bandage · {skill:129} First Aid · {item:6452} Anti-Venom · {item:1475} Small Venom Sac · {spell:9810} Touch of Zanzil
	["{spell:3277} is yellow from 80 (yellow at 80, green at 115, grey at 150): about 49 crafts to 115. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 80 for 2s 50c; the arrow picks the nearest. {item:6452} ({item:1475}, from spiders) is taught at 80 too: Rogues need it for {spell:9810}, and it sells."] = "",

	-- Step 15: Heavy Wool Bandage: Auction House
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: Auction House"] = "{spell:3278}: 경매장",
	-- {spell:3278} Heavy Wool Bandage · {item:2592} Wool Cloth
	["What {spell:3278} takes that the Auction House sells: 22 {item:2592}. The counts drop by what your bags, bank and mail hold."] = "{spell:3278}에 필요한 것 중 경매장에서 파는 것: {item:2592} 22개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",

	-- Step 16: Heavy Wool Bandage: cloth
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278}: cloth"] = "{spell:3278}: 천",

	-- Step 17: Heavy Wool Bandage (115-125)
	-- {spell:3278} Heavy Wool Bandage · {skill:129} First Aid · {item:929} Healing Potion · {item:2453} Bruiseweed · {item:2692} Hot Spices · {item:3372} Leaded Vial
	["{spell:3278} is yellow from 115 (yellow at 115, green at 150, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 115 for 10s; the arrow picks the nearest. Herbalists: {item:929} (from 110, 8s; {item:2453}, {item:2692} and a {item:3372}) is orange to 135."] = "",

	-- Step 18: Expert First Aid
	-- {skill:129} First Aid
	["Expert {skill:129}"] = "숙련 {skill:129}",
	-- {skill:129} First Aid · {item:16084} Expert First Aid - Under Wraps · {item:8544} Mageweave Bandage
	["Expert {skill:129} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16084} (1g); the arrow picks its nearest seller for your faction. Buy it and read it. The same vendor sells the Heavy Silk and {item:8544} manuals (22s and 50s): buy both now, you read them at 180 and 210."] = "숙련 {skill:129}은(는) 최대 숙련도를 225로 올립니다. 숙련도 125, 캐릭터 레벨 20이 필요합니다. 책 {item:16084}(1골드)(으)로 배우며, 화살표가 진영의 가장 가까운 판매 상인을 가리킵니다. 사서 읽으세요. 같은 상인이 두꺼운 비단 붕대와 {item:8544} 교본(22실버, 50실버)도 팝니다. 지금 둘 다 사 두고 180과 210에 읽으세요.",
	-- {item:16084} Expert First Aid - Under Wraps · {skill:129} First Aid
	["Buy and read {item:16084} (Expert {skill:129})"] = "{item:16084} 사서 읽기 (숙련 {skill:129})",

	-- Step 19: Heavy Wool Bandage: Auction House
	-- {spell:3278} Heavy Wool Bandage · {item:2592} Wool Cloth
	["What {spell:3278} takes that the Auction House sells: 76 {item:2592}. The counts drop by what your bags, bank and mail hold."] = "{spell:3278}에 필요한 것 중 경매장에서 파는 것: {item:2592} 76개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",

	-- Step 21: Heavy Wool Bandage (125-150)
	-- {spell:3278} Heavy Wool Bandage
	["{spell:3278} is yellow from 125 (yellow at 115, green at 150, grey at 185): about 38 crafts to 150. Bandages need no fire: craft them anywhere."] = "{spell:3278}은(는) 125부터 노란색입니다(노란색 115, 초록색 150, 회색 185). 150까지 약 38번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",

	-- Step 22: Silk Bandage: Auction House
	-- {item:6450} Silk Bandage
	["{item:6450}: Auction House"] = "{item:6450}: 경매장",
	-- {item:6450} Silk Bandage · {item:4306} Silk Cloth
	["What {item:6450} takes that the Auction House sells: 42 {item:4306}. The counts drop by what your bags, bank and mail hold."] = "{item:6450}에 필요한 것 중 경매장에서 파는 것: {item:4306} 42개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",

	-- Step 23: Silk Bandage: cloth
	-- {item:6450} Silk Bandage
	["{item:6450}: cloth"] = "{item:6450}: 천",
	-- {item:4306} Silk Cloth
	["{item:4306} drops from humanoids of level 25-45: keep what you loot as you level, or take it from your bank."] = "{item:4306}은(는) 25-45레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나 은행에서 꺼내세요.",

	-- Step 24: Silk Bandage (150-180)
	-- {item:6450} Silk Bandage · {skill:129} First Aid
	["{item:6450} is yellow from 150 (yellow at 150, green at 180, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere. Any {skill:129} trainer of your faction teaches it from skill 150 for 50s; the arrow picks the nearest."] = "{item:6450}은(는) 150부터 노란색입니다(노란색 150, 초록색 180, 회색 210). 180까지 약 42번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요. 진영의 모든 {skill:129} 상급자가 숙련도 150부터 50실버에 가르칩니다. 화살표가 가장 가까운 곳을 가리킵니다.",

	-- Step 25: Heavy Silk Bandage: Auction House
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: Auction House"] = "{item:6451}: 경매장",
	-- {item:6451} Heavy Silk Bandage · {item:4306} Silk Cloth
	["What {item:6451} takes that the Auction House sells: 84 {item:4306}. The counts drop by what your bags, bank and mail hold."] = "{item:6451}에 필요한 것 중 경매장에서 파는 것: {item:4306} 84개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",

	-- Step 26: Heavy Silk Bandage: cloth
	-- {item:6451} Heavy Silk Bandage
	["{item:6451}: cloth"] = "{item:6451}: 천",

	-- Step 27: Heavy Silk Bandage (180-210)
	-- {item:6451} Heavy Silk Bandage
	["{item:6451} is yellow from 180 (yellow at 180, green at 210, grey at 240): about 42 crafts to 210. Bandages need no fire: craft them anywhere."] = "{item:6451}은(는) 180부터 노란색입니다(노란색 180, 초록색 210, 회색 240). 210까지 약 42번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",

	-- Step 28: Mageweave Bandage: Auction House
	-- {item:8544} Mageweave Bandage
	["{item:8544}: Auction House"] = "{item:8544}: 경매장",
	-- {item:8544} Mageweave Bandage · {item:4338} Mageweave Cloth
	["What {item:8544} takes that the Auction House sells: 18 {item:4338}. The counts drop by what your bags, bank and mail hold."] = "{item:8544}에 필요한 것 중 경매장에서 파는 것: {item:4338} 18개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",

	-- Step 29: Mageweave Bandage: cloth
	-- {item:8544} Mageweave Bandage
	["{item:8544}: cloth"] = "{item:8544}: 천",
	-- {item:4338} Mageweave Cloth
	["{item:4338} drops from humanoids of level 35-50: keep what you loot as you level, or take it from your bank."] = "{item:4338}은(는) 35-50레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나 은행에서 꺼내세요.",

	-- Step 30: Mageweave Bandage (210-225)
	-- {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 210 (yellow at 210, green at 240, grey at 270): about 18 crafts to 225. Bandages need no fire: craft them anywhere."] = "{item:8544}은(는) 210부터 노란색입니다(노란색 210, 초록색 240, 회색 270). 225까지 약 18번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",

	-- Step 31: Trauma
	["Trauma"] = "외상 치료",
	-- {skill:129} First Aid · {quest:6624} Triage · {zone:1455} Ironforge · {item:14047} Runecloth
	["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 35; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore. Bring the Mageweave (about 74) and {item:14047} (about 65) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages."] = "",

	-- Step 32: Trauma
	-- {skill:129} First Aid · {quest:6622} Triage · {zone:1454} Orgrimmar · {area:321} Hammerfall · {item:14047} Runecloth
	["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 35; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}. Bring the Mageweave (about 74) and {item:14047} (about 65) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages."] = "",

	-- Step 33: Triage
	-- {quest:6624} Triage
	-- plural, as words: Triage Bandages = {item:16991} Triage Bandage
	["{quest:6624}: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie inside: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again."] = "",
	-- {skill:129} First Aid
	["Artisan {skill:129}"] = "전문 {skill:129}",

	-- Step 34: Triage
	-- {quest:6622} Triage
	-- plural, as words: Triage Bandages = {item:16991} Triage Bandage
	["{quest:6622}: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie on the floor inside: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again."] = "",

	-- Step 35: Mageweave Bandage: Auction House
	-- {item:8544} Mageweave Bandage · {item:4338} Mageweave Cloth
	["What {item:8544} takes that the Auction House sells: 24 {item:4338}. The counts drop by what your bags, bank and mail hold."] = "{item:8544}에 필요한 것 중 경매장에서 파는 것: {item:4338} 24개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",

	-- Step 37: Mageweave Bandage (225-240)
	-- {item:8544} Mageweave Bandage
	-- plural, as words: Mageweave Bandages = {item:8544} Mageweave Bandage
	["{item:8544} is yellow from 225 (yellow at 210, green at 240, grey at 270): about 24 crafts to 240. Bandages need no fire: craft them anywhere. {item:8544} turns green at 240: switch to Heavy Mageweave there, which costs less cloth than green Mageweave Bandages to 260."] = "",

	-- Step 38: Heavy Mageweave Bandage
	-- {spell:10841} Heavy Mageweave Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:10841} (skill 240) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "",

	-- Step 39: Heavy Mageweave Bandage: Auction House
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545}: Auction House"] = "{item:8545}: 경매장",
	-- {item:8545} Heavy Mageweave Bandage · {item:4338} Mageweave Cloth
	["What {item:8545} takes that the Auction House sells: 50 {item:4338}. The counts drop by what your bags, bank and mail hold."] = "{item:8545}에 필요한 것 중 경매장에서 파는 것: {item:4338} 50개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",

	-- Step 40: Heavy Mageweave Bandage: cloth
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545}: cloth"] = "",

	-- Step 41: Heavy Mageweave Bandage (240-260)
	-- {item:8545} Heavy Mageweave Bandage
	["{item:8545} is yellow from 240 (yellow at 240, green at 270, grey at 300): about 25 crafts to 260. Bandages need no fire: craft them anywhere."] = "{item:8545}은(는) 240부터 노란색입니다(노란색 240, 초록색 270, 회색 300). 260까지 약 25번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",

	-- Step 42: Runecloth Bandage
	-- {spell:18629} Runecloth Bandage · {quest:6622} Triage · {npc:12939} Doctor Gustaf VanHowzen · {npc:12920} Doctor Gregory Victor · {area:321} Hammerfall
	["{spell:18629} (skill 260) is an Artisan recipe: only the {quest:6622} doctor teaches it ({npc:12939} in Theramore, {npc:12920} in {area:321})."] = "{spell:18629}(숙련도 260)은(는) 전문 제조법입니다. {quest:6622}의 의사만 가르칩니다(테라모어 섬의 {npc:12939}, {area:321}의 {npc:12920}).",

	-- Step 43: Runecloth Bandage: Auction House
	-- {item:14529} Runecloth Bandage
	["{item:14529}: Auction House"] = "{item:14529}: 경매장",
	-- {item:14529} Runecloth Bandage · {item:14047} Runecloth
	["What {item:14529} takes that the Auction House sells: 65 {item:14047}. The counts drop by what your bags, bank and mail hold."] = "{item:14529}에 필요한 것 중 경매장에서 파는 것: {item:14047} 65개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",

	-- Step 44: Runecloth Bandage: cloth
	-- {item:14529} Runecloth Bandage
	["{item:14529}: cloth"] = "{item:14529}: 천",
	-- {item:14047} Runecloth
	["{item:14047} drops from humanoids of level 45-60: keep what you loot as you level, or take it from your bank."] = "{item:14047}은(는) 45-60레벨 인간형 몹이 떨어뜨립니다. 레벨을 올리며 얻은 것을 모아 두거나 은행에서 꺼내세요.",

	-- Step 45: Runecloth Bandage (260-300)
	-- {item:14529} Runecloth Bandage · {item:14047} Runecloth · {item:14530} Heavy Runecloth Bandage
	["{item:14529} is yellow from 260 (yellow at 260, green at 290, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} turns green at 290, yet to 300 it takes about the same {item:14047} as switching to {item:14530} (the doctor teaches it at 290): one recipe is enough."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:129} trainer of your faction teaches Apprentice {skill:129} (character level 5); the arrow picks the nearest."] = "진영의 모든 {skill:129} 상급자가 초급 {skill:129}을(를) 가르칩니다(캐릭터 레벨 5). 화살표가 가장 가까운 곳을 가리킵니다.",
	-- ["Artisan {skill:129} comes from the {quest:6622} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1454} sends you to the doctor in {area:321}."] = "전문 {skill:129}은(는) {quest:6622} 퀘스트로 배웁니다. 숙련도 225, 레벨 40이 필요합니다. {zone:1454}의 {skill:129} 상급자가 {area:321}의 의사에게 보냅니다.",
	-- ["Artisan {skill:129} comes from the {quest:6624} quest. It needs skill 225 and level 40; the {skill:129} trainer in {zone:1455} sends you to the doctor in Theramore."] = "전문 {skill:129}은(는) {quest:6624} 퀘스트로 배웁니다. 숙련도 225, 레벨 40이 필요합니다. {zone:1455}의 {skill:129} 상급자가 테라모어 섬의 의사에게 보냅니다.",
	-- ["Journeyman {skill:129} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:129} trainer of your faction. Learn {spell:3276} on the same visit."] = "수습 {skill:129}은(는) 최대 숙련도를 150으로 올립니다. 숙련도 50, 캐릭터 레벨 10이 필요합니다. 화살표가 진영의 가장 가까운 {skill:129} 상급자를 가리킵니다. 같은 방문에 {spell:3276}도 배우세요.",
	-- ["humanoids of level 15-30 drop {item:2592} (or buy it at the Auction House)."] = "15-30레벨 인간형 몹이 {item:2592}을(를) 떨어뜨립니다(경매장에서 사도 됩니다).",
	-- ["humanoids of level 25-45 drop {item:4306} (or buy it at the Auction House)."] = "25-45레벨 인간형 몹이 {item:4306}을(를) 떨어뜨립니다(경매장에서 사도 됩니다).",
	-- ["humanoids of level 35-50 drop {item:4338} (or buy it at the Auction House)."] = "35-50레벨 인간형 몹이 {item:4338}을(를) 떨어뜨립니다(경매장에서 사도 됩니다).",
	-- ["humanoids of level 45-60 drop {item:14047} (or buy it at the Auction House)."] = "45-60레벨 인간형 몹이 {item:14047}을(를) 떨어뜨립니다(경매장에서 사도 됩니다).",
	-- ["humanoids of level 5-20 drop {item:2589} (or buy it at the Auction House)."] = "5-20레벨 인간형 몹이 {item:2589}을(를) 떨어뜨립니다(경매장에서 사도 됩니다).",
	-- ["{item:1251} is orange from 1 (yellow at 30, grey at 60): about 61 crafts to 50. Bandages need no fire: craft them anywhere."] = "{item:1251}은(는) 1부터 주황색입니다(노란색 30, 회색 60). 50까지 약 61번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",
	-- ["{item:14529} is yellow from 260 (yellow at 260, grey at 320): about 65 crafts to 300. Bandages need no fire: craft them anywhere. {item:14529} stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth."] = "{item:14529}은(는) 260부터 노란색입니다(260에서 노란색, 320에서 회색). 300까지 약 65번 만드세요. 붕대는 불이 필요 없어 어디서나 만들 수 있습니다. {item:14529}은(는) 320까지 노란색이라, 두꺼운 룬매듭 붕대를 배우러 가지 않고도 300까지 올릴 수 있습니다.",
	-- ["{item:6450} is yellow from 150 (yellow at 150, grey at 210): about 42 crafts to 180. Bandages need no fire: craft them anywhere."] = "{item:6450}은(는) 150부터 노란색입니다(노란색 150, 회색 210). 180까지 약 42번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",
	-- ["{item:8544} is yellow from 225 (yellow at 210, grey at 270): about 88 crafts to 260. Bandages need no fire: craft them anywhere. {item:8544} stays yellow to 270; one recipe to 260 saves two trips to the doctor."] = "{item:8544}은(는) 225부터 노란색입니다(노란색 210, 회색 270). 260까지 약 88번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요. {item:8544}은(는) 270까지 노란색이라, 이 제조법 하나로 260까지 올리면 의사에게 두 번 갈 필요가 없습니다.",
	-- ["{quest:6622}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6622}: 의사의 천막에 있는 부상병을 의사가 주는 붕대로 치료하세요. 누구도 죽기 전에 가장 위독한 병사부터 치료하세요.",
	-- ["{quest:6624}: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die."] = "{quest:6624}: 의사의 천막에 있는 부상병을 의사가 주는 붕대로 치료하세요. 누구도 죽기 전에 가장 위독한 병사부터 치료하세요.",
	-- ["{spell:3278} is yellow from 115 (yellow at 115, grey at 185): about 11 crafts to 125. Bandages need no fire: craft them anywhere."] = "{spell:3278}은(는) 115부터 노란색입니다(노란색 115, 회색 185). 125까지 약 11번 만드세요. 붕대는 불이 필요 없으니 어디서나 만드세요.",
}
