-- Chinese (simplified) (zhCN): the guide forever/reputation/cenarion-circle (forever/reputation/cenarion-circle.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Cenarion Circle Reputation"] = "塞纳里奥议会声望",
	-- {zone:1451} Silithus
	["Nature resistance enchants and patterns, badge gear and Forever's new {zone:1451} patterns, from {zone:1451}'s camps."] = "自然抗性附魔和图样、徽章装备以及无限新增的{zone:1451}图样，来自{zone:1451}的营地。",
	-- {zone:1451} Silithus
	["Forever's new {zone:1451} patterns for Tailors, Leatherworkers and Blacksmiths, Friendly and Honored"] = "无限为裁缝、制皮和锻造新增的{zone:1451}图样，友善和尊敬",

	-- Step 1: The emissary in Ironforge
	-- {zone:1455} Ironforge
	["The emissary in {zone:1455}"] = "{zone:1455}的使者",
	-- {npc:15187} Cenarion Emissary Jademoon · {zone:1451} Silithus · {quest:8275} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15187} sends you to {zone:1451} with {quest:8275}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "可选，仅后续掘泥虫任务需要：{npc:15187} 会给你 {quest:8275}，一封让你前往 {zone:1451} 的信，奖励 10 点声望。如果已经在 {zone:1451}，可以跳过。",

	-- Step 2: The emissary in Orgrimmar
	-- {zone:1454} Orgrimmar
	["The emissary in {zone:1454}"] = "{zone:1454}的使者",
	-- {npc:15188} Cenarion Emissary Blackhoof · {zone:1451} Silithus · {quest:8275} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15188} sends you to {zone:1451} with {quest:8275}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "可选，仅后续掘泥虫任务需要：{npc:15188} 会给你 {quest:8275}，一封让你前往 {zone:1451} 的信，奖励 10 点声望。如果已经在 {zone:1451}，可以跳过。",

	-- Step 3: Cenarion Hold
	-- {area:3425} Cenarion Hold · {zone:1451} Silithus · {faction:609} Cenarion Circle · {npc:15270} Huum Wildmane · {quest:8318} Secret Communication · {item:20404} Encrypted Twilight Text
	["{area:3425} is the walled druid camp in north-central {zone:1451}, with flight points for both sides. Everyone starts Neutral with the {faction:609} (druids at 2,000 of 3,000). Bor and {npc:15270} stand together in the main building. {quest:8318} opens the {item:20404} turn-ins for good. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{area:3425} 是 {zone:1451} 中北部有围墙的德鲁伊营地，两个阵营都有飞行点。所有角色的 {faction:609} 初始声望都是中立（德鲁伊起始为 2,000/3,000）。鲍尔和 {npc:15270} 一起站在主建筑中。{quest:8318} 会永久解锁 {item:20404} 交还任务。传承特权外交家可让每次声望收益最多提高 10%；本指南中的数值均未计入此加成。",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, level 60"] = "{npc:15270}，60级",

	-- Step 4: The cultist camp west of Cenarion Hold
	-- {area:3425} Cenarion Hold
	["The cultist camp west of {area:3425}"] = "{area:3425}西面的教徒营地",
	-- {item:20404} Encrypted Twilight Text · {npc:11804} Twilight Keeper Havunth
	-- plural, as words: Wind Stones = {object:180461} Wind Stone
	["The nearest Twilight's Hammer camp lies just south-west of the Hold. Avengers, Geolords and Stonecallers (level 57 to 59) each drop an {item:20404} about a third of the time, and every cultist kill is 1 reputation. {npc:11804} walks the edge of the camp. Keep every cultist robe, cowl and mantle you loot: they are the Twilight Trappings for the Wind Stones later."] = "最近的暮光之锤营地就在要塞西南方不远。复仇者、地领主和召石者（57到59级）每只约有三分之一概率掉落一个 {item:20404}，每次击杀教徒还会获得1点声望。{npc:11804} 在营地边缘走动。拾取的教徒长袍、兜帽和披肩都要保留：它们就是之后使用风石所需的暮光套装。",

	-- Step 5: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "回到{area:3425}",

	-- Step 6: Cultists until the top of Friendly, texts saved
	["Cultists until the top of Friendly, texts saved"] = "击杀教徒到友善满，保留暮光密文信",
	-- {npc:11880} Twilight Avenger · {item:20404} Encrypted Twilight Text · {area:2742} Hive'Ashi · {npc:15308} Twilight Prophet · {npc:15306} Bor Wildmane
	["Neutral to Honored is 9,000 reputation (7,000 for druids). Every {npc:11880}, Geolord, Stonecaller, Master and Overlord gives 1 reputation until 5,999 of 6,000 Friendly, one point short of Honored; there they stop. Save every {item:20404} and leave the quests of the next steps for later: each kill below that point is a free point on top of its text, and the texts and quests pay the same at any standing. A text drops about every third kill, so 30 kills make 30 reputation and 10 texts (100 reputation later). Four camps: south-west of the Hold (39,44), the far west (26,34), the far south-west (19,84) and the north-east below {area:2742} (66,18: Overlords, and Flamereavers that count until the top of Honored). The {npc:15308} (87% text) walks between 18,31 and 23,69. Texts sell on the auction house if you would rather buy. At 5,999 Friendly the last point into Honored comes from a Flamereaver, Twilight Keeper or Marauder, or from your first 10 texts at {npc:15306}."] = "中立到尊敬需要9,000声望（德鲁伊为7,000）。每个{npc:11880}、地领主、唤石者、宗主和霸主都提供1点声望，直到友善5,999/6,000、距离尊敬还差一点时停止。留着每个{item:20404}，并把后面几步的任务留到以后：在这个界限前，每次击杀的声望都是文书之外白赚的一点，而交文书和做任务在任何声望阶段奖励相同。文书约每三只掉一本，因此击杀30只可获得30声望和10本文书（之后可换100声望）。有四处营地：要塞西南（39,44）、最西方（26,34）、最西南方（19,84），以及东北方{area:2742}下方（66,18：有霸主，还有击杀声望可持续到尊敬末尾的烈焰掠夺者）。{npc:15308}（文书掉率87%）在18,31与23,69之间走动。不想刷也可从拍卖行买文书。友善5,999时，升入尊敬的最后一点可通过击杀烈焰掠夺者、暮光守护者或掠夺者获得，也可向{npc:15306}交还第一批10本文书。",
	["Kills alone to the top of Friendly is 8,999 kills (6,999 for druids), but the texts they drop (about 3,000) are worth 30,000 more: most of the way to Exalted."] = "仅靠击杀到友善满需要杀 8,999 只（德鲁伊 6,999 只），但掉落的暮光密文（约 3,000 份）还能换取 30,000 点声望：足够完成到崇拜的大部分进度。",
	-- {item:20732} Formula: Enchant Cloak - Greater Fire Resistance · {item:22251} Cenarion Herb Bag · {item:22758} Sylvan Shoulders
	["Friendly (3,000) opens Kania's {item:20732} (10g), Mishta's {item:22251} (2g) and {item:22758} (5g), and Forever's new Friendly gloves patterns (7g 50s)."] = "友善（3,000）后可购买卡妮亚的 {item:20732}（10 金币）、米什塔的 {item:22251}（2 金币）和 {item:22758}（5 金币），以及无限新增的友善手套图样（7 金 50 银）。",
	-- {item:20404} Encrypted Twilight Text
	["{item:20404}: save them"] = "{item:20404}：留着",
	-- {npc:15201} Twilight Flamereaver
	["{npc:15201}: still counts at 5,999 Friendly"] = "{npc:15201}：友善5,999时仍可获得声望",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100, for the last point"] = "{npc:15306}：10 份密文，100 点声望，补上最后一点",

	-- Step 7: Vyral the Vile
	-- {quest:8321} Vyral the Vile · {area:3446} Twilight's Run · {zone:1451} Silithus
	-- plural, as words: Twilight Masters = {npc:11883} Twilight Master
	["{quest:8321} (level 61, not elite) waits at the back of {area:3446}, the cave in the north-east of {zone:1451}. Flamereavers and Twilight Masters guard the way: the Flamereavers count until the top of Honored, the Masters stop at the top of Friendly like the other cultists."] = "{quest:8321}（61级，非精英）位于 {zone:1451} 东北部洞穴 {area:3446} 的最深处。暮光烈焰掠夺者 和暮光主宰守着通路：暮光烈焰掠夺者 直到尊敬上限前都能提供声望，暮光主宰则与其他教徒一样，到友善上限就不再提供。",

	-- Step 8: Silithus quests at Cenarion Hold
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["{zone:1451} quests at {area:3425}"] = "{area:3425}的{zone:1451}任务",
	-- {quest:8280} Securing the Supply Lines · {quest:8275} Taking Back Silithus · {npc:15196} Deathclasp · {npc:15174} Calandrath · {quest:8307} Desert Recipe · {item:20452} Smoked Desert Dumplings · {npc:15189} Beetix Ficklespragg
	["Now cash in the one-time quests: about 1,700 reputation alone, 2,400 with the group quests. They are level 55 to 60, so they pay in full at 60. {quest:8280} needs {quest:8275} first. {npc:15196} is an elite scorpid with two guards (group of 2 or 3). {npc:15174}'s {quest:8307} is for Cooks: its recipe makes the {item:20452} he wants. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "现在去完成一次性任务：单人任务约1,700声望，加上小队任务共2,400。这些任务为55到60级，所以60级时能拿到全额声望。{quest:8280}需要先完成{quest:8275}。{npc:15196}是一只精英蝎子，带两个护卫（需2到3人小队）。{npc:15174}的{quest:8307}是给烹饪者的：其配方可做出他要的{item:20452}。{npc:15189}站在他所在建筑的楼上：从室内上楼，箭头无法区分楼层。",
	-- {npc:15191} Windcaller Proudhorn · {quest:8275} Taking Back Silithus
	["{npc:15191}, after {quest:8275}"] = "{npc:15191}，在 {quest:8275} 之后",
	-- {npc:15196} Deathclasp
	["Wanted poster: {npc:15196}, elite"] = "通缉告示：{npc:15196}，精英",
	-- {npc:15174} Calandrath
	["{npc:15174}, for Cooks"] = "{npc:15174}，适合厨师",

	-- Step 9: Around Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Around {area:3425}"] = "{area:3425}周围",
	-- {object:180503} Sandy Cookbook
	-- plural, as words: Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer · Dredge Strikers = {npc:11740} Dredge Striker
	["Stonelash Scorpids and Sand Skitterers roam the sands around the Hold; Dredge Strikers dig north-east of it. The {object:180503} lies in the cultist camp south-west of the Hold."] = "石鞭蝎和掠沙蜘蛛在要塞周围的沙地游荡；掘泥打击者在东北面掘地。{object:180503}位于要塞西南面的教徒营地。",

	-- Step 10: Back at the Hold
	["Back at the Hold"] = "返回要塞",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}站在他所在建筑的楼上：从室内上楼，箭头无法区分楼层。",

	-- Step 11: Stonelash and Dredge Crushers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash and Dredge Crushers"] = "石鞭系列敌人 与掘泥摧毁者",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker · Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash Flayers, Pincers and Rock Stalkers live south and south-west of the Hold; their stingers and fangs drop about one time in ten. Dredge Crushers dig south and west of the Hold."] = "石鞭掠夺者、石鞭巨钳蝎和石行蜘蛛栖息在要塞南边及西南；毒刺和尖牙掉率约为十分之一。掘泥摧毁者在要塞南边和西边挖掘。",
	-- {item:20452} Smoked Desert Dumplings · {object:180503} Sandy Cookbook
	["{item:20452}, from the {object:180503}"] = "{item:20452}，来自{object:180503}",
	-- {item:20452} Smoked Desert Dumplings · {item:20424} Sandworm Meat · {item:3713} Soothing Spices
	["{item:20452}, from {item:20424} and {item:3713}"] = "{item:20452}，由 {item:20424} 和 {item:3713} 制作",

	-- Step 12: Noggle Ficklespragg and Proudhorn
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} and Proudhorn"] = "{npc:15190} 和傲角。",
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}和{npc:15190}站在他们所在建筑的楼上：从室内上楼，箭头无法区分楼层。",

	-- Step 13: The Ravaged Twilight Camp
	-- {area:3100} Ravaged Twilight Camp
	["The {area:3100}"] = "{area:3100}",
	-- {zone:1451} Silithus
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["The broken camp in the far north-west of {zone:1451}: the Twilight Tablet Fragments lie on the ground among the ruins."] = "{zone:1451} 西北尽头的破败营地：暮光石板碎片散落在废墟间的地面上。",

	-- Step 14: Larksbane
	["Larksbane"] = "拉克斯班",

	-- Step 15: Hermit Ortell
	-- {npc:15194} Hermit Ortell · {zone:1451} Silithus · {quest:8319} Encrypted Twilight Texts · {quest:8349} Bor Wildmane
	["{npc:15194} hides in the hills of eastern {zone:1451}. He also decodes {quest:8319} for a chance at a scroll of beckoning, but {quest:8349} pays the reputation: keep the texts for Bor."] = "{npc:15194}藏在{zone:1451}东部的山丘中。他也能解读{quest:8319}，有机会得到召唤卷轴，但提供声望的是{quest:8349}：将暮光密文信留给鲍尔·蛮鬃。",

	-- Step 16: The three Twilight Keepers
	["The three Twilight Keepers"] = "三名暮光守护者",
	["Each Keeper is a level 60, not elite, alone at a camp edge, and always drops its chapter: Mayna in the far west camp, Havunth in the camp south-west of the Hold, Exeter in the far south-west camp beside the Twilight Lord."] = "每名守护者都是 60 级非精英，独自待在营地边缘，必定掉落对应章节：玛恩在最西侧营地，哈弗斯在要塞西南方的营地，埃克斯特在西南尽头的营地、暮光领主旁边。",

	-- Step 17: Back to Ortell
	["Back to Ortell"] = "返回隐士奥泰尔处",

	-- Step 18: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "铜须营地",
	-- {zone:1451} Silithus · {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {quest:8304} Dearest Natalia · {item:20379} Noggle's Satchel · {npc:15196} Deathclasp · {spell:10101} Knock Away
	["The dwarves' camp in the south of {zone:1451}. Talk {npc:15171} and {npc:15170} through their whole stories for {quest:8304}. {item:20379} lies on the mountain south-east of the camp. {npc:15196} lives up the trail east of the camp: an elite, and his {spell:10101} can throw you off the cliff."] = "矮人营地在 {zone:1451} 南部。与 {npc:15171} 和 {npc:15170} 交谈，听完他们的全部故事，以完成 {quest:8304}。{item:20379} 位于营地东南面的山上。{npc:15196} 在营地东侧的小路上方：他是精英，他的 {spell:10101} 能把你打下悬崖。",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170}"] = "{npc:15171}和{npc:15170}",
	-- {item:20385} Deathclasp's Pincer
	["{item:20385}, elite: group of 2 or 3"] = "{item:20385}，精英：两至三人小队",

	-- Step 19: Back to Cenarion Hold with news
	-- {area:3425} Cenarion Hold
	["Back to {area:3425} with news"] = "带着消息返回{area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190}站在他所在建筑的楼上：从室内上楼，箭头无法区分楼层。",
	["Natalia, elite: group up"] = "纳塔莉亚，精英：请组队",

	-- Step 20: Rubbings and brains
	["Rubbings and brains"] = "拓印和大脑",
	-- {object:210337} Glyphed Crystal (no name in this language: may be words) · {item:20453} Geologist's Transcription Kit · {area:2742} Hive'Ashi · {area:2743} Hive'Zora · {area:2744} Hive'Regal · {quest:8308} Brann Bronzebeard's Lost Letter
	["Rutgar and Frankal hand out the next two quests at their camp. Each hive has a {object:210337} to rub with the {item:20453}, and its silithid drop the brains: {area:2742} north of the Hold, {area:2743} in the west, {area:2744} in the south. Inside {area:2744} waits Mistress Natalia (level 62 elite, mind control and fear; group of 3 to 5). Now and then a hive silithid drops {quest:8308}: it starts a quest for Rutgar worth 100."] = "鲁特加尔·雕石和弗兰卡·石桥在营地里提供接下来的两个任务。每个虫巢都有一个 {object:210337}，需要用 {item:20453} 拓印，巢内异种蝎会掉落大脑：{area:2742} 在要塞北面，{area:2743} 在西面，{area:2744} 在南面。纳塔莉亚·玛尔利斯在 {area:2744} 内等候（62级精英，会精神控制和恐惧；需要三至五人小队）。虫巢异种蝎偶尔掉落 {quest:8308}：可触发交给鲁特加尔·雕石的任务，奖励100声望。",
	-- {item:20456} Hive'Regal Rubbing · {area:2744} Hive'Regal
	["{item:20456}, deep in {area:2744}"] = "{item:20456}，在{area:2744}深处",
	-- {quest:8308} Brann Bronzebeard's Lost Letter
	["{quest:8308}, a rare drop"] = "{quest:8308}，稀有掉落",

	-- Step 21: Mistress Natalia
	["Mistress Natalia"] = "纳塔莉亚·玛尔利斯",
	-- {area:2744} Hive'Regal · {zone:1451} Silithus
	["Optional: Natalia waits deep in {area:2744}, the hive in the south of {zone:1451}. She is a level 62 elite who mind-controls, fears and heals herself below half health: bring a group of 3 to 5 and interrupt her heals."] = "可选：纳塔莉亚在 {area:2744} 深处等候，这是 {zone:1451} 南部的虫巢。她是 62 级精英，会精神控制、恐惧，并在生命值低于一半时治疗自己：带上 3 至 5 人小队，打断她的治疗。",
	["Mistress Natalia: group of 3 to 5"] = "纳塔莉亚女王：三到五人小队",

	-- Step 22: The Calling
	-- {quest:8314} Unraveling the Mystery · {quest:8315} The Calling · {npc:15183} Geologist Larksbane · {area:3257} Bones of Grakkarond · {npc:14862} Emissary Roman'khan
	["{quest:8314} leads to {quest:8315}: {npc:15183} sends you to the {area:3257} to summon {npc:14862}, a level 63 boss for a raid of about 20. Take it only with a raid."] = "{quest:8314} 会开启 {quest:8315}：{npc:15183} 让你去 {area:3257} 召唤 {npc:14862}，这是需要约 20 人团队挑战的 63 级首领。只有组织了团队才接。",
	["raid of 20"] = "20人团队",
	-- {item:20465} Crystal Unlocking Mechanism · {npc:14862} Emissary Roman'khan
	["{item:20465}, {npc:14862}: raid of 20"] = "{item:20465}、{npc:14862}：20人团队",

	-- Step 23: The New Frontier, Thunder Bluff
	-- {quest:1123} Rabine Saturna · {npc:10881} Bluff Runner Windstrider · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:1123}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10881} sends you to {npc:5769} on {area:1639}, who sends you to {quest:1123} in {area:2361}, {zone:1450}."] = "可选：{quest:1123} 任务线包含七个55到57级任务，共奖励525点塞纳里奥声望，60级仍可获得全额奖励。{npc:10881} 会派你找 {area:1639} 的 {npc:5769}，后者再让你去 {zone:1450} 的 {area:2361} 找 {quest:1123}。",

	-- Step 24: The New Frontier, Darnassus
	-- {quest:6762} Rabine Saturna · {npc:10878} Herald Moonstalker · {npc:3516} Arch Druid Fandral Staghelm · {npc:4217} Mathrengyl Bearwalker · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:6762}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10878} sends you to {npc:3516}, who sends you to {npc:4217}, who sends you to {quest:6762} in {area:2361}, {zone:1450}."] = "可选：{quest:6762}任务链包含7个55至57级任务，总计奖励525塞纳里奥声望，60级仍可全额获取。{npc:10878}让你找{npc:3516}，后者让你找{npc:4217}，再由其引导你前往{zone:1450}的{area:2361}做{quest:6762}。",

	-- Step 25: Rabine Saturna
	-- {quest:1123} Rabine Saturna · {area:2361} Nighthaven · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest · {zone:1451} Silithus
	["{quest:1123} lives in {area:2361}. She sends you to {npc:13220} at {area:3077}, the camp in the north-east corner of {zone:1451}."] = "{quest:1123} 住在 {area:2361}。她会派你去 {zone:1451} 东北角的营地 {area:3077} 找 {npc:13220}。",

	-- Step 26: Southwind Village
	-- {area:2738} Southwind Village · {area:3425} Cenarion Hold · {object:178553} Hive'Ashi Pod
	-- plural, as words: Tortured Druids = {npc:12178} Tortured Druid
	["The Tortured Druids and Sentinels roam the ruins of {area:2738}, south-east of {area:3425}; the {object:178553} sits on the top floor of its wasp-circled tower."] = "被折磨的德鲁伊和哨兵在 {area:3425} 东南的 {area:2738} 遗迹内游荡；{object:178553} 位于一座有黄蜂盘旋的塔楼顶层。",

	-- Step 27: Umber in Nighthaven
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} in {area:2361}"] = "{area:2361}的{npc:11939}",

	-- Step 28: Quests elsewhere
	["Quests elsewhere"] = "其他地方的任务",
	-- {faction:609} Cenarion Circle · {zone:1414} Kalimdor · {npc:10739} Mulgris Deepriver · {zone:1422} Western Plaguelands · {area:2100} Maraudon · {quest:1123} Rabine Saturna · {item:18501} Felvine Shard · {area:2577} Dire Maul
	["The {faction:609}'s other quests are spread over {zone:1414} and the Plaguelands. Forever pays them in full at any level: The Wildlife Suffers Too ({npc:10739}, {zone:1422}, levels 54 and 56) 75 and 75, Corruption of Earth and Seed ({area:2100}, level 51) 150. Shards of the Felvine ({quest:1123}, level 60, the {item:18501} from Alzzin in {area:2577}) pays 150 and its Reliquary 100 at any level."] = "",
	-- {zone:1422} Western Plaguelands · {area:2100} Maraudon
	["Do the {zone:1422} and {area:2100} quests while you level; at 60 they may pay a fraction."] = "升级时就完成 {zone:1422} 和 {area:2100} 的任务；到了 60 级，声望奖励可能只剩一小部分。",

	-- Step 29: Encrypted Twilight Texts to Revered
	-- {quest:8319} Encrypted Twilight Texts
	["{quest:8319} to Revered"] = "{quest:8319}刷到崇敬",
	-- {npc:15306} Bor Wildmane · {quest:8319} Encrypted Twilight Texts · {npc:14479} Twilight Lord Everun · {item:20733} Formula: Enchant Cloak - Greater Nature Resistance · {item:22773} Pattern: Sylvan Crown
	["Honored to Revered is 12,000 reputation. {npc:15306} takes 10 {quest:8319} for 100 reputation, again and again, until Exalted: 120 turn-ins (1,200 texts) to Revered without the quests, or about 950 texts after them. Hand in the texts you saved now. The cultists no longer count, but the Flamereavers, Twilight Keepers, Marauders and Templars count until 11,999 of 12,000 Honored, and the {npc:14479} and Prophet until Exalted. Honored opens Kania's {item:20733} (10g), Mishta's {item:22773} (5g) and Forever's new Honored patterns (7g 50s each)."] = "尊敬到崇敬需要 12,000 点声望。{npc:15306} 会反复收取 10 份 {quest:8319}，每次给予 100 点声望，直到崇拜：不算任务，到崇敬需要交还 120 次（1,200 份密文）；做完任务后则约需 950 份。现在交还攒下的密文。击杀教徒已不再给予声望，但烈焰掠夺者、暮光守护者、掠夺者和圣殿骑士能给到尊敬 12,000 点中的 11,999 点，{npc:14479} 和预言者则能给到崇拜。尊敬后可购买卡妮亚的 {item:20733}（10 金币）、米什塔的 {item:22773}（5 金币），以及无限新增的尊敬图样（每张 7 金 50 银）。",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100"] = "{npc:15306}：10 份密文，100 点声望。",

	-- Step 30: Field Duty, level 60
	-- {quest:8507} Field Duty
	["{quest:8507}, level 60"] = "{quest:8507}，60级",
	-- {npc:15540} Windcaller Kaldon · {area:3425} Cenarion Hold · {quest:8507} Field Duty · {npc:15440} Captain Blackanvil · {area:2743} Hive'Zora · {npc:15612} Krug Skullsplit · {area:2744} Hive'Regal · {item:20809} Tactical Assignment · {item:7936} Ornate Mithril Boots · {npc:15542} Twilight Marauder · {quest:9338} Allegiance to Cenarion Circle
	-- plural, as words: Heavy Runecloth Bandages = {item:14530} Heavy Runecloth Bandage
	["{npc:15540} stands by the moonwell of {area:3425}. {quest:8507} (25 reputation, repeatable) sends you with unsigned papers to your side's captain: {npc:15440}'s Ironforge Brigade outside {area:2743} (Alliance) or {npc:15612}'s Orgrimmar Legion outside {area:2744} (Horde). Use the papers first, then talk to the captain: a level 60 elite silithid attacks; keep the captain alive and he signs. Kaldon then lets you pick a Combat, Logistics or {item:20809}, each holding a random briefing worth 50 reputation and a badge: 30 hive silithid kills (elites), goods such as 30 Heavy Runecloth Bandages or 3 {item:7936}, or one Templar, {npc:15542} or scout report. One badge of each kind buys {quest:9338} at Kaldon: 200 reputation, repeatable. A full round is about 375 reputation."] = "{npc:15540}站在{area:3425}的月亮井旁。{quest:8507}（25声望，可重复）让你带着未签字的文件去找本阵营队长：{area:2743}外{npc:15440}的铁炉堡旅（联盟），或{area:2744}外{npc:15612}的奥格瑞玛军团（部落）。先使用文件，再与队长交谈：会有一只60级精英异种虫攻击；保住队长，他就会签字。随后唤风者卡尔东让你从作战、后勤或{item:20809}中选择一种，每份随机简报奖励50声望及一枚徽章：可能要求击杀30只虫巢异种虫（精英），提供物资（例如30个厚符文布绷带或3个{item:7936}），或击杀一名圣殿骑士、{npc:15542}，或提交侦察报告。每种徽章各一枚可在唤风者卡尔东处完成{quest:9338}：200声望，可重复。完整一轮约375声望。",
	["Allegiance: one Combat, Logistics and Tactical badge, 200"] = "塞纳里奥议会的盟友：作战、后勤和战术徽章各一枚，200 点声望",
	-- {quest:8800} Cenarion Battlegear · {npc:15176} Vargus
	["{quest:8800}: {npc:15176}'s badge gear"] = "{quest:8800}：{npc:15176} 的徽章兑换装备",

	-- Step 31: Silithyst
	["Silithyst"] = "水晶尘",
	-- {quest:9419} Scouring the Desert · {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {npc:17079} General Kirika · {area:2744} Hive'Regal
	["Optional, 100 reputation once: {quest:9419}. Your side's camp sits by a hive: {npc:17080}'s by {area:2743} (Alliance), {npc:17079}'s by {area:2744} (Horde). Silithyst rises from glowing geysers around the desert: walk through one, carry the Silithyst to your camp's Silithyst Extractor, then talk to the camp's leader. It is a world PvP objective: players of the other side can take it from you."] = "可选，一次性奖励 100 点声望：{quest:9419}。本方营地位于虫巢旁：{npc:17080} 在 {area:2743} 旁（联盟），{npc:17079} 在 {area:2744} 旁（部落）。沙漠中发光的喷泉会喷出水晶尘：走进去，携带水晶尘回到本方营地的水晶尘提取器，再与营地首领交谈。这是世界 PvP 目标：敌对阵营玩家可以抢走你携带的水晶尘。",
	["deliver Silithyst at the extractor"] = "在提取器处交还 水晶尘",

	-- Step 32: Templars and the Abyssal Council
	["Templars and the Abyssal Council"] = "圣殿骑士与深渊议会",
	-- {object:180456} Lesser Wind Stone (no name in this language: may be words) · {item:20513} Abyssal Crest · {quest:8361} Abyssal Contacts · {npc:15270} Huum Wildmane · {quest:8331} Aurel Goldleaf · {item:14344} Large Brilliant Shard · {object:180461} Wind Stone · {item:20514} Abyssal Signet
	["Wearing a full set of Twilight Trappings (cultist Cowl, Mantle and Robe, about 8%, 8% and 6% per cultist) lets you use a {object:180456}: two stand in each of the three western camps. A random Abyssal Templar appears: a level 60 elite for 1 to 3 players, 5 reputation until the top of Honored and an {item:20513} 93% of the time. The summon uses up the set (and later the medallion and ring too), and if the elemental gets away they are gone: summon only when you can win. {quest:8361} pays 100 for the first crest; after that Bor takes 3 crests for 50. From Friendly, {npc:15270} sends you to {quest:8331}: 3 crests and a {item:14344} buy the Medallion of Station that, worn with a set, opens the larger {object:180461} for a Duke (level 62 elite, group of 5; 25 reputation, {item:20514} 85%)."] = "穿齐暮光套装（教徒的兜帽、披肩和长袍，每个教徒的掉率分别约为8%、8%和6%）后，就能使用 {object:180456}：西边三个营地中每个都有两块。会随机出现一名深渊圣殿骑士：60级精英，适合一到三名玩家，击杀奖励5点声望，直到尊敬封顶，并有93%概率掉落一个 {item:20513}。召唤会消耗整套装备（之后还会消耗勋章和戒指），元素逃走后这些也无法找回：有把握获胜时再召唤。{quest:8361} 首次交还纹章奖励100点；之后鲍尔·蛮鬃每收取3个纹章奖励50点。从友善起，{npc:15270} 会指引你做 {quest:8331}：用3个纹章和一块 {item:14344} 换取身份勋章，佩戴它并穿齐套装即可使用更大的 {object:180461}，召唤公爵（62级精英，五人小队；25点声望，{item:20514} 掉率85%）。",
	-- {item:20513} Abyssal Crest
	["{item:20513}: Templar, group of 1 to 3"] = "{item:20513}：圣殿骑士，1 至 3 人小队。",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Friendly"] = "{npc:15270}，友善。",
	-- {item:14344} Large Brilliant Shard
	["3 crests and a {item:14344}: the Medallion of Station"] = "3个纹章和1个{item:14344}：身份勋章",
	-- {item:20514} Abyssal Signet
	["{item:20514}: Duke, group of 5"] = "{item:20514}：公爵，五人小队",

	-- Step 33: Signets and scepters to Exalted
	["Signets and scepters to Exalted"] = "用徽记和节杖提升到崇拜",
	-- {quest:8363} Abyssal Signets · {npc:15282} Aurel Goldleaf · {item:20515} Abyssal Scepter · {quest:9248} A Humble Offering · {quest:8343} Goldleaf's Discovery · {quest:8341} Lords of the Council · {object:180466} Greater Wind Stone (no name in this language: may be words) · {item:22252} Satchel of Cenarius · {item:22660} Gaea's Embrace · {item:22756} Sylvan Vest · {npc:15176} Vargus
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["Revered to Exalted is 21,000 reputation: 210 text turn-ins (2,100 texts), or less with the rest. From Honored, Bor takes 3 {quest:8363} for 100 (each Duke also gives 25, to Exalted), and {npc:15282} takes one {item:20515} for {quest:9248} (200, once). From Revered, {quest:8343} leads to {quest:8341}: 3 signets and 5 Large Brilliant Shards buy the Ring of Lordship, and set, medallion and ring open the {object:180466} for an Abyssal Lord: a level 63 boss for a raid of about 20, 50 reputation, and an {item:20515}. Bor pays 200 for the first scepter and 150 for each 3 after. Revered opens Mishta's {item:22252} (5g), {item:22660} (9g) and {item:22756} (5g); Exalted is the standing for Champion's Battlegear at {npc:15176}."] = "从崇敬到崇拜需要21,000点声望：相当于210次交还密文（2,100份密文），配合其他方式则更少。从尊敬起，鲍尔·蛮鬃每收取3个 {quest:8363} 奖励100点（每名公爵还提供25点，直到崇拜），{npc:15282} 则收取一个 {item:20515} 来完成 {quest:9248}（200点，仅一次）。从崇敬起，{quest:8343} 会引出 {quest:8341}：用3个徽记和5块大块魔光碎片换取统御之戒，穿齐套装并佩戴勋章和戒指，即可使用 {object:180466} 召唤深渊领主：63级首领，适合约20人的团队，击杀奖励50点声望和一个 {item:20515}。鲍尔·蛮鬃首次收取节杖奖励200点，之后每3根奖励150点。崇敬可向米什塔购买 {item:22252}（5金币）、{item:22660}（9金币）和 {item:22756}（5金币）；向 {npc:15176} 兑换“勇士的装备”则需要崇拜。",
	["10 texts: 100"] = "10 份密文：100 点声望。",
	-- {quest:8363} Abyssal Signets
	["3 {quest:8363}: 100, Honored"] = "3个{quest:8363}：100，尊敬",
	-- {item:20515} Abyssal Scepter
	["{item:20515}: Lord, raid of 20"] = "{item:20515}：领主，20人团队",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Revered"] = "{npc:15270}，崇敬。",
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["3 signets and 5 Large Brilliant Shards: the Ring of Lordship"] = "3枚徽记和5块大块魔光碎片：暮光贵族之戒",
	-- {quest:8364} Abyssal Scepters
	["3 {quest:8364}: 150, Revered"] = "3个 {quest:8364}：150，崇敬",

	-- Step 34: The Ruins of Ahn'Qiraj, when they open
	-- {area:3454} Ruins of Ahn'Qiraj
	["The {area:3454}, when they open"] = "{area:3454}，开放后再去",
	-- {area:2737} Scarab Wall · {zone:1451} Silithus · {quest:8791} The Fall of Ossirian · {npc:15185} Brood of Nozdormu · {npc:15498} Windcaller Yessendra · {npc:15500} Keyl Swiftclaw · {npc:15499} Warden Haro · {npc:16091} Dirk Thunderwood · {quest:9023} The Perfect Poison · {item:22217} Kurinnaxx's Venom Sac · {area:19} Zul'Gurub · {npc:15471} Lieutenant General Andorov · {item:22219} Plans: Jagged Obsidian Shield · {item:22191} Obsidian Mail Tunic
	["A 20-player raid behind the {area:2737} in the far south-west of {zone:1451}. A full clear is about 1,600 Cenarion reputation: the trash 3 each until 20,999 of 21,000 Revered, Kurinnaxx, Moam, Buru and Ayamiss 150 each and Ossirian 300, to Exalted. Ossirian's head starts {quest:8791} (200 here and 200 {npc:15185}). Their drops buy the ring (Honored), cloak (Revered) and weapon (Exalted) quests of {npc:15498}, {npc:15500} and {npc:15499} in the Hold, 100 reputation each. {npc:16091} in the Hold pays 100 once for {quest:9023}: {item:22217} from here and Venoxis's from {area:19}. {npc:15471} sells {item:22219} (Revered, 5g) and {item:22191} (Exalted, 8g) inside."] = "这是位于 {zone:1451} 最西南端 {area:2737} 后方的20人团队副本。完整通关一次约获得1,600塞纳里奥声望：小怪每只3点，直到崇敬20,999/21,000；库林纳克斯、莫阿姆、布鲁和阿亚米斯各150点，奥斯里安300点，首领声望可到崇拜。奥斯里安的头颅触发 {quest:8791}（此处200点，另有200点 {npc:15185}）。他们的掉落可用于要塞内 {npc:15498}、{npc:15500} 和 {npc:15499} 的戒指（尊敬）、披风（崇敬）和武器（崇拜）任务，每个任务100声望。要塞内的 {npc:16091} 为一次性的 {quest:9023} 奖励100声望：需要这里的 {item:22217} 和 {area:19} 的高阶祭司温诺希斯对应物品。副本内 {npc:15471} 出售 {item:22219}（崇敬，5金币）和 {item:22191}（崇拜，8金币）。",

	-- Step 35: Venoxis's Venom Sac, Zul'Gurub
	-- {quest:9023} The Perfect Poison · {npc:14507} High Priest Venoxis · {area:19} Zul'Gurub · {zone:1434} Stranglethorn Vale
	["Optional, for {quest:9023}: {npc:14507} is the first boss of {area:19}, a 20-player raid in north-east {zone:1434}."] = "可选，供{quest:9023}使用：{npc:14507}是{area:19}的第一个首领，该副本是位于{zone:1434}东北部的20人团队副本。",
	-- {item:22216} Venoxis's Venom Sac
	["{item:22216}: raid of 20"] = "{item:22216}：20 人团队。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Abyssal Crests, Abyssal Signets and Abyssal Scepters are repeatable at {npc:15306} once their opening quests are done."] = "完成初始任务后，{item:20513}、{item:20514}和{item:20515}都可以在{npc:15306}处重复上交。",
	-- ["Encrypted Twilight Texts repeats: {npc:15306} takes more texts again and again. The cultist camps are the place to farm them."] = "“暮光密文信”可重复：{npc:15306}会一次又一次收取更多密文。信徒营地就是刷它们的地方。",
	-- ["Encrypted Twilight Texts to Friendly"] = "用{item:20404}刷到友善",
	-- ["From here on, the {area:3454} raid and the Abyssal Council turn-ins (crests, signets, scepters) carry most of the reputation."] = "从这里开始，{area:3454}团队副本和深渊议会的上交物品（纹章、徽记、节杖）提供大部分声望。",
	-- ["Keep farming the Twilight camps. Wearing the Twilight Trappings (the Twilight cultist set plus a Medallion of Station, from {npc:15282}'s Medallion of Station quest) lets you summon Abyssal Templars at the Wind Stones; their Abyssal Crests go to {npc:15306}."] = "继续刷暮光营地。穿上暮光信徒套装并带上暮光信徒身份勋章（来自{npc:15282}的“身份勋章”任务），就能在{object:180461}召唤深渊圣殿骑士；它们的{item:20513}交给{npc:15306}。",
	-- ["Keep running the {area:3454} and turning in Abyssal Council insignia until Exalted."] = "继续刷{area:3454}并上交深渊议会的徽章，直到崇拜。",
	-- ["The {faction:609}'s other quests are spread over {zone:1414} and the Plaguelands. In Classic a quest pays less once it is 6 or more levels below you (a fifth less per level, down to a fifth): at 60, The Wildlife Suffers Too ({npc:10739}, {zone:1422}, levels 54 and 56) would pay 60 and 75 instead of 75 and 75, and Corruption of Earth and Seed ({area:2100}, level 51) 30 instead of 150. Your first turn-in shows which rule Forever uses. Shards of the Felvine ({quest:1123}, level 60, the {item:18501} from Alzzin in {area:2577}) pays 150 and its Reliquary 100 at any level."] = "{faction:609} 的其他任务分布在 {zone:1414} 和瘟疫之地。在经典旧世中，任务比你低 6 级及以上时，声望奖励会减少（每低一级减少五分之一，最低降至五分之一）：60 级时，“大自然的苦楚”（{npc:10739}，{zone:1422}，54 和 56 级）会从 75 和 75 点变为 60 和 75 点，“大地的污染”（{area:2100}，51 级）则从 150 点变为 30 点。第一次交还任务时，就能看出无限采用哪种规则。“魔藤碎片”（{quest:1123}，60 级，在 {area:2577} 从奥兹恩处取得 {item:18501}）在任何等级都提供 150 点，其圣物匣任务提供 100 点。",
	-- ["Twilight's Hammer cultists hold the camps in western {zone:1451}. {quest:8320} and Stonecallers mix here; any cultist can drop an {item:20404}. Every cultist kill also counts toward the {faction:609}. The Geolords count for {quest:8320} only if you are 60 and took it."] = "暮光之锤的信徒占据着{zone:1451}西部的营地。{quest:8320}和暮光唤石者混在这里；任何信徒都可能掉落{item:20404}。每次击杀信徒也会提升{faction:609}声望。只有你60级并接了{quest:8320}时，击杀暮光地王才算数。",
	-- ["{area:3425} is the walled town in north-central {zone:1451}. Bor and {npc:15270} stand together inside. The {faction:609} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:3425}是{zone:1451}中北部有城墙的城镇。博尔和{npc:15270}一起站在里面。{faction:609}初始为中立。Forever的传承外交官特权可提高声望获取。",
	-- ["{faction:609} to Exalted"] = "{faction:609}刷到崇拜",
	-- ["{faction:609} to Honored"] = "{faction:609}刷到尊敬",
	-- ["{faction:609} to Revered"] = "{faction:609}刷到崇敬",
	-- ["{npc:15306}: Encrypted Twilight Texts"] = "{npc:15306}：暮光密文信",
	-- ["{quest:8320} needs level 60"] = "{quest:8320}需要60级",
}
