-- Korean (koKR): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "{area:75}(으)로 날아가기",
	-- {area:1446} Thorium Point
	["From {area:1446}'s flight master."] = "{area:1446}의 비행 조련사에게서",

	-- Step 2: The bloodmages
	["The bloodmages"] = "피의 마법사",
	-- {area:75} Stonard · {zone:1419} Blasted Lands
	["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "{area:75}에서 서쪽으로 나가 협곡을 지나 남쪽 {zone:1419}(으)로 가세요. 피의 마법사 둘은 들어가자마자 길가에 서 있습니다.",

	-- Step 3: The northern beasts
	["The northern beasts"] = "북쪽의 짐승들",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "퀘스트 다섯 개가 같은 재료를 요구합니다. 한 번에 모두 모으세요. 길 서쪽 언덕에는 {npc:5982}, 굶주린 칼송곳니하이에나, 스콜포크 독침전갈, 죽음의 눈 바실리스크가 함께 있습니다.",

	-- Step 4: The eastern slopes
	["The eastern slopes"] = "동쪽 비탈",
	["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "길 동쪽 비탈에서는 잿빛갈기멧돼지와 꿀꿀이가 붉은바위 바실리스크 옆에서 땅을 뒤집니다. 더 남쪽의 52레벨 지옥멧돼지는 피하세요.",

	-- Step 5: The bloodmages
	["Ride back north to the bloodmages."] = "북쪽의 피의 마법사에게 돌아가세요.",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "후속 퀘스트는 강화 아이템을 위해 같은 재료를 다시 요구하며 경험치를 주지 않습니다. 받지 마세요.",

	-- Step 6: Grind to 48
	["Grind to 48"] = "48레벨까지 사냥",
	["Only if you are not level 48 yet."] = "아직 48레벨이 아닐 때만",
	["Vulture hills"] = "대머리수리 언덕",
	-- {npc:5982} Black Slayer · {zone:1419} Blasted Lands
	["grind on {npc:5982} at the northern hills, {zone:1419}"] = "{zone:1419} 북쪽 언덕에서 {npc:5982} 사냥",

	-- Step 7: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "{area:1497}(으)로 날아가기",
	-- {area:75} Stonard · {area:1497} Undercity
	["Ride north back to {area:75} and fly to the {area:1497}."] = "북쪽의 {area:75}(으)로 돌아가 {area:1497}(으)로 날아가세요.",

	-- Step 8: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{object:36126}의 {npc:7825}",
	-- {npc:6741} Innkeeper Norman · {zone:1456} Thunder Bluff
	["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741}: 50레벨쯤 {zone:1456}에서",

	-- Step 9: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "{area:272}(으)로 날아가기",

	-- Step 10: Gilveradin Sunchaser's camp
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "{npc:7801}의 야영지",
	-- {area:272} Tarren Mill · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser · {area:350} Quel'Danil Lodge
	["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "{area:272}에서 북동쪽 {zone:1425}로 들어가 길을 따라 동쪽으로 가세요. {npc:7801}은(는) 엘프의 {area:350} 남쪽 언덕에 야영하고 있습니다.",

	-- Step 11: Highvale
	["Highvale"] = "깊은골짜기",
	-- {area:350} Quel'Danil Lodge · {npc:7780} Rin'ji
	["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "깊은골짜기 엘프는 {area:350} 주변에 야영하고 있습니다. 그들의 야영지에서 보고서, 쪽지, 기록을 불태우세요. {npc:7780}은(는) 산장 안에 갇혀 있습니다. 밖으로 데리고 나오며 도중의 매복을 물리치세요.",

	-- Step 12: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "산장 남쪽에서 마른나무껍질부족 트롤이 마을을 차지하고 있습니다. 모두 해골을 지니고 있습니다. 스무 개를 모아 {item:15002}을(를) 사용해 님보야의 무거운 창을 만든 뒤 마을 안에 꽂으세요.",

	-- Step 13: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "마을 동쪽 언덕에 보라색 꽃이 자랍니다.",

	-- Step 14: The Atal'ai Exile
	-- {area:353} Shadra'Alor
	["South-west again, the exile hides by the ruins of {area:353}."] = "다시 남서쪽으로 가면 추방자가 {area:353} 폐허 옆에 숨어 있습니다.",

	-- Step 15: Revantusk Village
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "길을 따라 동쪽으로 {zone:1425}을(를) 가로질러 동쪽 해안의 트롤 마을로 가세요.",

	-- Step 16: Saltwater Snapjaws
	-- plural, as words: Saltwater Snapjaws = {npc:2505} Saltwater Snapjaw
	["Saltwater Snapjaws"] = "무쇠턱바다거북",
	-- {npc:2491} Whiskey Slim
	["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "큰 거북은 마을 북쪽 해변을 기어다닙니다. {npc:2491}의 포트와인 병도 이 해변에 있지만, 그의 퀘스트는 이 경로에 없습니다. 무쇠턱바다거북이 드물게 OOX-09/HL 조난 탐지기를 떨어뜨릴 수 있습니다. 보관하세요.",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "드물게 떨어지는 {item:8704}",

	-- Step 17: Rin'ji's Secret
	-- {area:307} Overlook Cliffs
	["The secret lies on the {area:307}, above the beach."] = "비밀은 해변 위쪽 {area:307}에 있습니다.",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "50레벨쯤 {zone:1458}의 {npc:7825}에게",

	-- Step 18: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "{npc:14731}의 점심",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "해안을 따라 북쪽으로 가면 작은 섬에 {npc:14731}의 소풍 바구니가 있습니다. {npc:14748}이(가) 지키고 있습니다.",

	-- Step 19: The Vilebranch temples
	["The Vilebranch temples"] = "썩은가지부족 사원",
	-- {area:1884} Agol'watha · {area:1917} Shaol'watha
	["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "섬 서쪽에서 썩은가지부족 무두장이가 {area:1884}와(과) {area:1917}의 사원을 차지하고 있습니다. 슬래그트리의 도구는 사원 중 한 곳에 있습니다.",

	-- Step 20: The central hills
	["The central hills"] = "중앙 언덕",
	-- {area:351} Skulk Rock · {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "긴발톱 은빛갈기늑대, 포악한 올빼미야수, 우두머리 뾰족부리그리핀이 사원과 {area:351} 사이 언덕에 함께 있습니다. 처치한 올빼미야수에 {item:9618}을(를) 사용하세요. 우두머리 뾰족부리그리핀은 길고 고운 깃털도 떨어뜨립니다. {npc:14738}의 두 번째 전갈을 위해 열 개를 보관하세요.",

	-- Step 21: Skulk Rock
	-- {item:8684} Hinterlands Honey Ripple · {area:351} Skulk Rock
	["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "{item:8684} 상자는 {area:351}의 버려진 호드 야영지 주변, 수액괴물 사이에 있습니다.",

	-- Step 22: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {area:351} Skulk Rock · {area:307} Overlook Cliffs · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "조난 탐지기가 있을 때만: 로봇은 {area:351} 서쪽 강의 상류에 있습니다. 동쪽으로 {area:307} 너머 해안까지 호위하세요. 보상은 {area:35}의 오글소프에게서 받습니다.",

	-- Step 23: Silvermane Howlers
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["Silvermane Howlers"] = "긴울음 은빛갈기늑대",
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "남서쪽, 마른나무껍질부족 마을 동쪽 언덕에 긴울음 은빛갈기늑대가 돌아다닙니다.",

	-- Step 24: Highvale
	-- {area:350} Quel'Danil Lodge
	["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "서쪽의 {area:350}(으)로 돌아가세요. 순찰대와 명사수는 산장 근처에, 정찰대와 길잡이는 그 남쪽 비탈에 있습니다.",

	-- Step 25: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "50레벨쯤 {zone:1454}의 {npc:6986}에게",

	-- Step 26: Vilebranch soothsayers
	["Vilebranch soothsayers"] = "썩은가지부족 예언자",
	-- {area:355} Altar of Zul · {npc:8636} Morta'gya the Keeper
	["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "동쪽으로 돌아가는 길에, 중앙 언덕 남쪽의 트롤 사원인 {area:355}을(를) 썩은가지부족 예언자가 차지하고 있습니다. 퀴아가와 {npc:8636}(정예, 50)은(는) 꼭대기에 있습니다. 아래 계단의 예언자를 상대하세요.",

	-- Step 27: Jintha'Alor
	-- {area:354} Jintha'Alor · {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "사냥꾼 마코르의 해골은 썩은가지부족 폐허 아래 더미에, 뼈는 {area:354} 기슭의 더미에 있습니다. 오염된 피가 담긴 용기는 아래쪽 계단식 단에 있고, {npc:14757}은(는) 꼭대기에 갇혀 있습니다. 길에서 벗어나지 마세요. 안쪽의 트롤은 정예입니다.",
	-- {npc:14757} Elder Torntusk · {area:354} Jintha'Alor
	["{npc:14757}, at the top of {area:354}"] = "{area:354} 꼭대기의 {npc:14757}",
	-- {area:355} Altar of Zul
	["His next request, going on to the {area:355}, is for a group."] = "그의 다음 요청인 {area:355} 진입은 파티용입니다.",

	-- Step 29: Aerie Peak
	-- {area:348} Aerie Peak
	["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "서쪽 끝까지 가서 와일드해머 마을 {area:348}에 들어가 중앙 우물 옆에 전갈을 놓으세요. 마을에는 얼라이언스 경비병이 가득합니다. 들어가서 놓고 바로 나오세요.",
	-- {area:348} Aerie Peak
	["{area:348} well"] = "{area:348} 우물",

	-- Step 30: Revantusk Village
	-- {area:3317} Revantusk Village
	["The next guide starts here, at {area:3317}."] = "다음 가이드는 여기 {area:3317}에서 시작합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "길을 따라 동쪽으로 {zone:1425}을(를) 가로질러 동쪽 해안의 트롤 마을로 가세요.",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of {spell:19478} sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "사냥꾼 마코르의 해골은 썩은가지부족 폐허 아래 더미에, 뼈는 {area:354} 기슭의 더미에 있습니다. {spell:19478}이(가) 담긴 용기는 아래쪽 계단식 단에 있고, {npc:14757}은(는) 꼭대기에 갇혀 있습니다. 길에서 벗어나지 마세요. 안쪽의 트롤은 정예입니다.",
	-- ["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "{area:272}에서 북동쪽 {zone:1425}(으)로 들어가 길을 따라 동쪽으로 가세요. {npc:7801}은(는) 엘프의 {area:350} 남쪽 언덕에 야영하고 있습니다.",
}
