-- Chinese (traditional) (zhTW): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "飛往{area:75}",
	-- {area:1446} Thorium Point
	["From {area:1446}'s flight master."] = "從{area:1446}的飛行管理員出發。",

	-- Step 2: The bloodmages
	["The bloodmages"] = "血法師",
	-- {area:75} Stonard · {zone:1419} Blasted Lands
	["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "從{area:75}向西騎出，再向南穿過峽谷進入{zone:1419}；兩名血法師就站在入口處的道路旁。",

	-- Step 3: The northern beasts
	["The northern beasts"] = "北方的野獸",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "五個任務需要相同的材料：一趟全部收集。道路西邊，{npc:5982}禿鷲、饑餓的彎牙土狼、厚甲毒刺蠍和死眼蜥蜴共同分布在丘陵上。",

	-- Step 4: The eastern slopes
	["The eastern slopes"] = "東坡",
	["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "道路東邊，灰鬃野豬和格朗特在紅石蜥蜴旁的山坡上拱土。遠離更南邊52級的地獄野豬。",

	-- Step 5: The bloodmages
	["Ride back north to the bloodmages."] = "向北騎回血法師那裡。",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "他們的後續任務要你再交一次同樣的材料換取增益物品，不給經驗值：不用理會。",

	-- Step 6: Grind to 48
	["Grind to 48"] = "刷到48級",
	["Only if you are not level 48 yet."] = "只有在你還沒48級時。",
	["Vulture hills"] = "禿鷲丘陵",
	-- {npc:5982} Black Slayer · {zone:1419} Blasted Lands
	["grind on {npc:5982} at the northern hills, {zone:1419}"] = "在{zone:1419}北部丘陵刷{npc:5982}",

	-- Step 7: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "飛往{area:1497}",
	-- {area:75} Stonard · {area:1497} Undercity
	["Ride north back to {area:75} and fly to the {area:1497}."] = "向北騎回{area:75}，飛往{area:1497}。",

	-- Step 8: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}，{object:36126}",
	-- {npc:6741} Innkeeper Norman · {zone:1456} Thunder Bluff
	["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741}：給{zone:1456}，約50級",

	-- Step 9: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "飛往{area:272}",

	-- Step 10: Gilveradin Sunchaser's camp
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "{npc:7801}的營地",
	-- {area:272} Tarren Mill · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser · {area:350} Quel'Danil Lodge
	["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "從{area:272}向東北騎進{zone:1425}，再沿道路向東；{npc:7801}在精靈的{area:350}南邊的山丘上紮營。",

	-- Step 11: Highvale
	["Highvale"] = "高原精靈",
	-- {area:350} Quel'Danil Lodge · {npc:7780} Rin'ji
	["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "高原精靈在{area:350}周圍紮營。燒掉他們營地中的報告、筆記和紀錄。{npc:7780}被關在小屋裡：帶他出來，途中擊退伏擊。",

	-- Step 12: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "小屋南邊，枯木食人妖佔據他們的村落。每一隻身上都帶著頭骨：收集二十個後，使用{item:15002}製作尼姆布亞的長矛，然後插在村子裡。",

	-- Step 13: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "村子東邊的丘陵上長著紫色水生菇。",

	-- Step 14: The Atal'ai Exile
	-- {area:353} Shadra'Alor
	["South-west again, the exile hides by the ruins of {area:353}."] = "再往西南，流放者躲在{area:353}的廢墟旁。",

	-- Step 15: Revantusk Village
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "沿道路向東穿過{zone:1425}，前往東海岸的食人妖村落。",

	-- Step 16: Saltwater Snapjaws
	-- plural, as words: Saltwater Snapjaws = {npc:2505} Saltwater Snapjaw
	["Saltwater Snapjaws"] = "海水鉗嘴龜",
	-- {npc:2491} Whiskey Slim
	["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "大海龜在村子北邊的海灘上爬行。{npc:2491}的波特酒瓶也在這些海灘上，但他的任務不在本路線上。鉗嘴龜偶爾會掉落OOX-09/HL的求救信標：留著它。",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}，稀有掉落",

	-- Step 17: Rin'ji's Secret
	-- {area:307} Overlook Cliffs
	["The secret lies on the {area:307}, above the beach."] = "秘密在海灘上方的{area:307}。",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "之後給{zone:1458}的{npc:7825}，約50級",

	-- Step 18: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "{npc:14731}的午餐",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "沿海岸向北，{npc:14731}的野餐籃在小島上；由一個{npc:14748}看守。",

	-- Step 19: The Vilebranch temples
	["The Vilebranch temples"] = "邪枝神廟",
	-- {area:1884} Agol'watha · {area:1917} Shaol'watha
	["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "小島西邊，邪枝割顱者佔據{area:1884}和{area:1917}的神廟。斯拉提的工具在其中一座神廟。",

	-- Step 20: The central hills
	["The central hills"] = "中部丘陵",
	-- {area:351} Skulk Rock · {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "銀鬃捕獵者、野蠻的梟獸和翱翔的鋒喙獅鷲獸共同分布在神廟與{area:351}之間的丘陵。對你殺死的梟獸使用{item:9618}。翱翔的鋒喙獅鷲獸也會掉落細長的獅鷲獸羽毛：留十根給{npc:14738}的第二個訊息。",

	-- Step 21: Skulk Rock
	-- {item:8684} Hinterlands Honey Ripple · {area:351} Skulk Rock
	["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "{item:8684}的箱子散落在{area:351}廢棄的部落營地周圍，在軟泥怪之間。",

	-- Step 22: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {area:351} Skulk Rock · {area:307} Overlook Cliffs · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "只有在持有求救信標時：機器人在{area:351}西邊的河流源頭。護送它向東到{area:307}之外的海岸；獎勵在{area:35}的奧格索普·奧布諾提斯那裡。",

	-- Step 23: Silvermane Howlers
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["Silvermane Howlers"] = "銀鬃嗥狼",
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "往西南，銀鬃嗥狼在枯木村落東邊的丘陵遊蕩。",

	-- Step 24: Highvale
	-- {area:350} Quel'Danil Lodge
	["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "向西回到{area:350}；高原遊俠和高原神射手待在小屋附近，高原斥候和高原前鋒在小屋南邊的山坡上。",

	-- Step 25: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "之後給{zone:1454}的{npc:6986}，約50級",

	-- Step 26: Vilebranch soothsayers
	["Vilebranch soothsayers"] = "邪枝占卜者",
	-- {area:355} Altar of Zul · {npc:8636} Morta'gya the Keeper
	["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "在往東回去的路上，邪枝占卜者佔據中部丘陵南邊的食人妖神廟{area:355}。守護者奇爾加和{npc:8636}（精英，50級）站在頂端：在下層階梯對付占卜者。",

	-- Step 27: Jintha'Alor
	-- {area:354} Jintha'Alor · {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "獵戶莫克霍爾的顱骨在邪枝廢墟下方的一堆東西上，他的骨頭在{area:354}山腳的另一堆上。污染之血之瓶放在下層平台，{npc:14757}被關在頂端。走在小路上：裡面的食人妖是精英。",
	-- {npc:14757} Elder Torntusk · {area:354} Jintha'Alor
	["{npc:14757}, at the top of {area:354}"] = "{npc:14757}，在{area:354}頂端",
	-- {area:355} Altar of Zul
	["His next request, going on to the {area:355}, is for a group."] = "他的下一個要求是前往{area:355}，需要組隊。",

	-- Step 29: Aerie Peak
	-- {area:348} Aerie Peak
	["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "一路向西騎到蠻錘矮人的城鎮{area:348}，把訊息放在鎮中央的井邊。鎮上滿是聯盟守衛：進去、放下、離開。",
	-- {area:348} Aerie Peak
	["{area:348} well"] = "{area:348}的井",

	-- Step 30: Revantusk Village
	-- {area:3317} Revantusk Village
	["The next guide starts here, at {area:3317}."] = "下一份指南從{area:3317}開始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "沿道路向東穿過{zone:1425}，前往東海岸的食人妖村落。",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of {spell:19478} sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "獵戶莫克霍爾的顱骨在邪枝廢墟下方的一堆東西上，他的骨頭在{area:354}山腳的另一堆上。{spell:19478}之瓶放在下層平台，{npc:14757}被關在頂端。走在小路上：裡面的食人妖是精英。",
	-- ["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "從{area:272}向東北騎進{zone:1425}，再沿道路向東；{npc:7801}在精靈的{area:350}南邊的山丘上紮營。",
}
