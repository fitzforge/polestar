-- Chinese (simplified) (zhCN): the guide forever/reputation/brood-of-nozdormu (forever/reputation/brood-of-nozdormu.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Brood of Nozdormu Reputation"] = "诺兹多姆的子嗣声望",
	["The Bronze Dragonflight's ring, upgraded at every standing; a long climb from Hated, mostly in raids."] = "青铜龙军团的戒指，每提升一级声望即可升级；从仇恨开始的漫长攀升，主要靠团队副本。",
	-- {item:21175} The Scepter of the Shifting Sands
	["{item:21175} quest chain"] = "{item:21175}任务线",

	-- Step 1: Baristolth in Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Baristolth in {area:3425}"] = "{area:3425} 的流沙守望者巴里斯托尔斯",
	-- {faction:910} Brood of Nozdormu · {npc:15192} Anachronos · {npc:15180} Baristolth of the Shifting Sands · {area:3425} Cenarion Hold · {area:2677} Blackwing Lair · {area:16076} Temple of Ahn'Qiraj
	["The {faction:910} is not in your reputation list until you meet {npc:15192}. {npc:15180}, in the main building of {area:3425}, sends you to him. Meeting him sets you at Hated, 0 of 36,000: Neutral is 42,000 reputation away, and almost all of it comes from raids. {area:2677} and the {area:16076} are not among the first raids Blizzard has announced for Forever: until one of them opens, the 100 from Baristolth's first quest is all the Brood reputation there is. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "见到{npc:15192}之前，声望列表中不会出现{faction:910}。{area:3425}主建筑内的{npc:15180}会派你去找他。见面后声望设为仇恨0/36,000：距离中立还差42,000声望，几乎都要通过团队副本获得。{area:2677}和{area:16076}不在暴雪已公布的无限服首批团队副本之列：在其中一个开放前，流沙守望者巴里斯托尔斯第一个任务奖励的100点就是全部可获取的龙族声望。传承的外交家特长使每次声望获取最多增加10%；本指南数字均未计入此加成。",

	-- Step 2: Anachronos at the Caverns of Time
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time
	["{npc:15192} at the {area:2300}"] = "{area:2300}的{npc:15192}",
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time · {zone:1446} Tanaris · {area:976} Gadgetzan
	["{npc:15192}, a bronze dragon in elf form, stands at the mouth of the {area:2300} in eastern {zone:1446}, south-east of {area:976}. Walk up to him."] = "{npc:15192} 是一条化身精灵的青铜龙，站在 {zone:1446} 东部的 {area:2300} 入口，位于 {area:976} 东南方。走近他。",
	-- {npc:15192} Anachronos
	["Meet {npc:15192}"] = "会见{npc:15192}",

	-- Step 3: Back to Baristolth
	["Back to Baristolth"] = "返回巴里斯托尔处。",
	-- {quest:8288} Only One May Rise · {npc:12017} Broodlord Lashlayer · {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {quest:8286} What Tomorrow Brings
	["{quest:8288} wants the head of {npc:12017}, the third boss of {area:2677} (a 40-player raid in {area:254}). Everything after it needs the head, the fragment turn-ins included: until you have it, {quest:8286} is all the Brood reputation there is, solo or not."] = "{quest:8288} 需要 {npc:12017} 的头颅，他是 {area:2677} 的第三名首领（位于 {area:254} 的 40 人团队副本）。之后所有内容都需要先取得头颅，包括交还碎片：拿到之前，无论是否独自游玩，都只能靠 {quest:8286} 获取青铜龙声望。",

	-- Step 4: Broodlord Lashlayer
	-- {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {npc:12017} Broodlord Lashlayer
	["{area:2677} is a 40-player raid at the top of {area:254}. {npc:12017} always drops his head."] = "{area:2677} 是位于 {area:254} 顶部的 40 人团队副本。{npc:12017} 必定掉落头颅。",
	-- {item:20383} Head of the Broodlord Lashlayer
	["{item:20383}: raid of 40"] = "{item:20383}：40人团队",

	-- Step 5: The Path of the Righteous
	-- {quest:8301} The Path of the Righteous · {area:3425} Cenarion Hold · {area:2743} Hive'Zora · {area:2744} Hive'Regal
	-- plural, as words: Silithid Carapace Fragments = {item:20384} Silithid Carapace Fragment · Hive'Ashi Workers = {npc:11721} Hive'Ashi Worker
	["{quest:8301} wants 200 Silithid Carapace Fragments. Every hive silithid drops one to three on most kills: the Hive'Ashi Workers, Stingers, Swarmers and Defenders north and north-west of {area:3425}, and those of {area:2743} in the west and {area:2744} in the south. Almost all of them are elites of level 57 to 60: one at a time solo, faster in a group."] = "{quest:8301} 需要 200 个异种蝎壳碎片。虫巢中的所有异种虫，大多数击杀都会掉落一至三个：包括 {area:3425} 北侧和西北侧的亚什工蝎、毒蝎、群居蝎与防御者，以及西侧 {area:2743} 和南侧 {area:2744} 的异种虫。它们几乎全是 57 至 60 级精英：单人要逐个击杀，组队则更快。",

	-- Step 6: Hated to Neutral
	["Hated to Neutral"] = "仇恨到中立",
	-- {quest:8302} The Hand of the Righteous · {area:16076} Temple of Ahn'Qiraj · {item:21230} Ancient Qiraji Artifact · {item:21229} Qiraji Lord's Insignia
	["After The Path, Baristolth takes 200 more fragments for {quest:8302}: 200 reputation, again and again, but only until Neutral. From Hated 500 that is 208 turn-ins, 41,600 fragments, 20,000 to 30,000 elite kills: the only way without the Temple, and a very long one. With the {area:16076} open (a 40-player raid) it is far quicker: every Temple trash mob gives 100 until 2,999 of 3,000 Neutral, about 9,500 a full clear, so four to five clears reach Neutral. Save every {item:21230} and {item:21229} you loot until the trash stops counting: they pay the same later."] = "完成 正义之路 后，流沙守望者巴里斯托尔斯会再收200块碎片来完成 {quest:8302}：每次200声望，可反复交还，但只能到中立。从仇恨500开始，需要交还208次、41,600块碎片，约击杀20,000至30,000只精英：这是不打神殿的唯一方式，而且非常漫长。{area:16076} 开放后（40人团队副本）会快得多：神殿每只小怪提供100声望，直到中立2,999/3,000为止，完整清理一次约得9,500，因此四到五次即可达到中立。在小怪不再提供声望之前，保留所有拾取到的 {item:21230} 和 {item:21229}：以后交还的收益相同。",
	-- {quest:8302} The Hand of the Righteous
	["{quest:8302}: 200 fragments, 200"] = "{quest:8302}：200 个碎片，200 点声望",

	-- Step 7: Anachronos's quests
	-- {quest:8303} Anachronos
	["{quest:8303}'s quests"] = "{quest:8303}的任务",
	-- {quest:8303} Anachronos
	["Neutral opens the rest of the Scepter of the Shifting Sands chain. Baristolth sends you back to {quest:8303}."] = "中立后会开放流沙节杖任务链的剩余部分。巴里斯托尔斯会让你返回 {quest:8303}。",

	-- Step 9: The Crystalline Tear
	-- {object:180633} Crystalline Tear
	["The {object:180633}"] = "{object:180633}",
	-- {object:180633} Crystalline Tear · {area:3428} Ahn'Qiraj · {zone:1451} Silithus
	["The {object:180633} is a small red crystal on the ground just outside the gates of {area:3428}, in the far south-west of {zone:1451}. Click it, then stay and watch the vision of the War of the Shifting Sands to its end. If it is cut short, abandon the quest and click the Tear again."] = "{object:180633} 是 {zone:1451} 西南尽头、{area:3428} 大门外地面上的一块小红色水晶。点击后留在原地，将流沙之战的幻象看完。如果幻象中断，放弃任务，再次点击这滴泪。",
	["Watch the vision"] = "观看幻象。",

	-- Step 10: The Charge of the Dragonflights
	-- {npc:15192} Anachronos · {item:21200} Signet Ring of the Bronze Dragonflight · {quest:8555} The Charge of the Dragonflights
	["{npc:15192} now offers the {item:21200} in three kinds: the Path of the Protector (tanks), of the Conqueror (melee fighters) or of the Invoker (casters). Take one: the other two close. Each standing from Friendly to Exalted brings an upgrade of the same ring, 100 reputation each. {quest:8555} sends you after the three shards of the Scepter of the Shifting Sands."] = "{npc:15192}现在提供三种{item:21200}：保护者之路（坦克）、征服者之路（近战）或祈求者之路（施法者）。选一种，另外两种就会关闭。从友善到崇拜，每提升一个声望等级就能升级同一枚戒指，每次奖励100声望。{quest:8555}会让你寻找流沙节杖的3块碎片。",
	["Pick one: The Path of the Protector, the Conqueror or the Invoker, 100"] = "三选一：保护者之路、征服者之路或祈求者之路，100点",

	-- Step 11: The red shard: Vaelastrasz
	["The red shard: Vaelastrasz"] = "红色碎片：堕落的瓦拉斯塔兹",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair · {quest:8730} Nefarius's Corruption · {item:21138} Red Scepter Shard
	["The red shard: {npc:13020}, the second boss of {area:2677}, gives {quest:8730} before his fight; Nefarian, the last boss, drops the {item:21138} for one raider on the quest each kill. The quest lasts five hours."] = "红色碎片：{area:2677} 的第二名首领 {npc:13020} 会在战斗前给予 {quest:8730}；最终首领奈法利安每次击杀会为一名接了任务的团队成员掉落 {item:21138}。任务限时五小时。",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair
	["{npc:13020}, {area:2677}: raid of 40"] = "{npc:13020}，{area:2677}：40 人团队",
	-- {item:21138} Red Scepter Shard
	["{item:21138}, Nefarian"] = "{item:21138}，奈法利安。",

	-- Step 12: The blue shard: Azuregos's ledger
	["The blue shard: Azuregos's ledger"] = "蓝色碎片：艾索雷葛斯的账本",
	-- {npc:15481} Spirit of Azuregos · {zone:1447} Azshara · {npc:11811} Narain Soothfancy · {zone:1446} Tanaris
	["The {npc:15481} stands on the south coast of {zone:1447}. His ledger starts {npc:11811}'s long chain in {zone:1446}."] = "{npc:15481} 站在 {zone:1447} 南部海岸。他的账本会开启 {zone:1446} 的 {npc:11811} 提供的漫长任务链。",

	-- Step 13: Narain Soothfancy
	-- {npc:11811} Narain Soothfancy · {area:976} Gadgetzan · {zone:1421} Silverpine Forest · {zone:1446} Tanaris · {npc:8125} Dirge Quikcleave
	["{npc:11811}, a goblin seer, lives in a hut north-east of {area:976}. He sends you three ways at once: to Stewvul's crate in {zone:1421}, to an island off the south coast of {zone:1446}, and to {npc:8125} in {area:976}."] = "{npc:11811} 是一位地精先知，住在 {area:976} 东北面的小屋里。他会同时派你去三个地方：{zone:1421} 的斯图沃尔箱子、{zone:1446} 南部近海的一座岛屿，以及 {area:976} 的 {npc:8125}。",

	-- Step 14: Stewvul's crate
	["Stewvul's crate"] = "斯图沃尔的箱子",
	-- {object:180642} Inconspicuous Crate · {area:230} Greymane Wall · {zone:1421} Silverpine Forest
	["The {object:180642} leans on the {area:230} at the south end of {zone:1421}, left of the closed gate."] = "{object:180642} 斜靠在 {zone:1421} 最南端的 {area:230} 上，位于紧闭大门左侧。",

	-- Step 15: Meridith the Mermaiden
	-- {object:180652} Freshly Dug Dirt · {area:987} Land's End Beach · {npc:15526} Meridith the Mermaiden · {quest:8599} Love Song for Narain
	["The {object:180652} lies on the farther of two islands south of {area:987}, past the fatigue line. {npc:15526}, on the sea floor south of the beach's crashed gyrocopter, gives {quest:8599} and a three-minute swim-speed blessing that gets you across."] = "{object:180652} 位于 {area:987} 南侧两座岛屿中较远的那一座，在疲劳线之外。{npc:15526} 位于海滩坠毁旋翼机南侧的海底，会给予 {quest:8599} 和持续三分钟的游泳速度祝福，让你能游过去。",

	-- Step 16: The island off Land's End Beach
	-- {area:987} Land's End Beach
	["The island off {area:987}"] = "{area:987}外海的小岛",

	-- Step 17: Back to Narain Soothfancy
	-- {npc:11811} Narain Soothfancy
	["Back to {npc:11811}"] = "返回{npc:11811}处",
	-- {quest:8606} Decoy! · {npc:11811} Narain Soothfancy · {area:2255} Everlook · {zone:1452} Winterspring · {npc:15554} Number Two
	["{quest:8606} sends you, disguised with {npc:11811}'s turban, to a drop-off point south of {area:2255} in {zone:1452}. Leave the bag of gold there: {npc:15554}, a level 61 elite, comes for it (group of 3 to 5)."] = "{quest:8606}会让你戴上{npc:11811}的头巾伪装，前往{zone:1452}的{area:2255}南面交接点。将金币袋留在那里：61级精英{npc:15554}会来取（建议3-5人小队）。",

	-- Step 18: Decoy!
	-- {npc:15554} Number Two
	["{npc:15554}, elite: group of 3 to 5"] = "{npc:15554}，精英：3 至 5 人小队",

	-- Step 19: Dirge Quikcleave
	-- {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {area:1121} Isle of Dread · {zone:1444} Feralas
	["{npc:8125} cooks in {area:976}. He sends you to the {area:1121} off southern {zone:1444} for a Chimaerok feast."] = "{npc:8125} 在 {area:976} 做饭。他会派你前往 {zone:1444} 南部近海的 {area:1121}，筹备奇美洛克盛宴。",

	-- Step 20: The Isle of Dread
	-- {area:1121} Isle of Dread
	["The {area:1121}"] = "{area:1121}",
	-- {npc:12803} Lord Lakmaeran · {area:1121} Isle of Dread
	["{npc:12803} and the Chimaerok on the {area:1121} are elites of level 60 to 62 that respawn every ten minutes: a raid's work. The Chimaerok drop a tenderloin about half the time, Lakmaeran two to four now and then."] = "{npc:12803} 和 {area:1121} 的奇美洛克都是60至62级精英，每十分钟刷新，需要团队应对。奇美洛克约有一半概率掉落一块里脊肉，拉克麦拉偶尔会掉落两至四块。",
	-- {item:21027} Lakmaeran's Carcass · {npc:12803} Lord Lakmaeran
	["{item:21027}, {npc:12803}: raid"] = "{item:21027}，{npc:12803}：需要团队。",

	-- Step 21: Draconic for Dummies, Volume II
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}, Volume II"] = "{quest:8597}，第二卷",
	-- {quest:8620} The Only Prescription · {quest:8597} Draconic for Dummies · {npc:15552} Doctor Weavil · {area:2079} Alcaz Island · {zone:1419} Blasted Lands · {area:2255} Everlook · {zone:1458} Undercity · {npc:11811} Narain Soothfancy
	-- plural, as words: Felguard Elites = {npc:8717} Felguard Elite · Doomguard Commanders = {npc:12396} Doomguard Commander
	["{quest:8620} needs the eight chapters of {quest:8597}, Volume II: from {npc:15552} in his house on {area:2079} (a level 63 elite with guards, raid), the Felguard Elites, Doomguard Commanders and Dreadlords of the {zone:1419}, the Hederine south of {area:2255}, and a book in the {zone:1458}. {npc:11811} hands out the binding when you accept."] = "{quest:8620} 需要 {quest:8597} 第二卷的八个章节：来源包括 {npc:15552} 在 {area:2079} 的房屋（他是 63 级精英，带守卫，需要团队）、{zone:1419} 的地狱卫士精英、末日守卫指挥官和恐惧魔王、{area:2255} 南边的赫达琳恶魔，以及 {zone:1458} 的一本书。接任务时，{npc:11811} 会给你装订用的书壳。",
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}: Volume II"] = "{quest:8597}：第二卷",

	-- Step 22: Dirge Quikcleave's Chops
	-- {npc:8125} Dirge Quikcleave
	["{npc:8125}'s Chops"] = "{npc:8125} 的肉排",
	-- {npc:8125} Dirge Quikcleave · {item:9061} Goblin Rocket Fuel · {item:8150} Deeprock Salt · {npc:11811} Narain Soothfancy · {item:18562} Elementium Ore · {item:21136} Arcanite Buoy · {object:180669} Swirling Maelstrom (no name in this language: may be words) · {zone:1447} Azshara · {area:1227} Bay of Storms · {npc:15571} Maws · {item:21137} Blue Scepter Shard
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar · Azerothian Diamonds = {item:12800} Azerothian Diamond · Blue Sapphires = {item:12361} Blue Sapphire
	["{npc:8125} wants 20 {item:9061} and 20 {item:8150} with the meat. {npc:11811} then wants 20 Arcanite Bars, 10 {item:18562}, 10 Azerothian Diamonds and 10 Blue Sapphires, and gives you an {item:21136}: placed at the {object:180669} in {zone:1447}'s {area:1227}, it calls up {npc:15571}, a level 63 boss for a raid. {npc:15571} drops the {item:21137} for one raider on the quest each kill."] = "{npc:8125} 要求在肉之外再交20份 {item:9061} 和20份 {item:8150}。随后 {npc:11811} 需要20块奥金锭、10份 {item:18562}、10颗艾泽拉斯钻石和10颗蓝宝石，并给你一个 {item:21136}：放在 {zone:1447} 的 {area:1227} 内的 {object:180669} 处，可召出63级团队首领 {npc:15571}。每次击杀 {npc:15571}，只会为一名接有任务的团队成员掉落 {item:21137}。",
	-- {item:12360} Arcanite Bar
	["{item:12360}: Alchemists, or the auction house"] = "{item:12360}：找炼金师，或去拍卖行购买",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}: {area:2677}, or the auction house"] = "{item:18562}：{area:2677}，或拍卖行",

	-- Step 23: Maws
	-- {item:21137} Blue Scepter Shard · {npc:15571} Maws
	["{item:21137}, {npc:15571}: raid"] = "{item:21137}，{npc:15571}：需要团队。",

	-- Step 24: The green shard: Eranikus
	["The green shard: Eranikus"] = "绿色碎片：伊兰尼库斯",
	-- {npc:15362} Malfurion Stormrage · {npc:5709} Shade of Eranikus · {area:1477} Temple of Atal'Hakkar · {npc:15624} Forest Wisp · {zone:1457} Darnassus · {npc:11832} Keeper Remulos · {zone:1450} Moonglade
	["{npc:15362} appears beside the {npc:5709} at the bottom of the {area:1477} (a five-player dungeon). He sends you to a {npc:15624} outside {zone:1457} (Horde players walk past the city's guards), then to {npc:11832} in {zone:1450}."] = "{npc:15362} 出现在 {area:1477}（五人地下城）底部的 {npc:5709} 旁。他会让你去找 {zone:1457} 外的一名 {npc:15624}（部落玩家需从城市守卫旁走过），再去找 {zone:1450} 的 {npc:11832}。",
	-- {npc:15362} Malfurion Stormrage · {area:1477} Temple of Atal'Hakkar
	["{npc:15362}, inside the {area:1477}"] = "{npc:15362}，位于{area:1477}内",

	-- Step 25: The Forest Wisp
	-- {npc:15624} Forest Wisp
	["The {npc:15624}"] = "{npc:15624}",
	-- {npc:15624} Forest Wisp
	["{npc:15624}: 25 (and 25 Cenarion Circle)"] = "{npc:15624}：25声望（另有25点塞纳里奥议会声望）",

	-- Step 26: Keeper Remulos
	-- {quest:8735} The Nightmare's Corruption · {zone:1440} Ashenvale · {zone:1444} Feralas · {zone:1425} Hinterlands · {npc:15625} Twilight Corrupter · {zone:1431} Duskwood
	["{quest:8735} wants a fragment from each of the four Dragons of Nightmare portals: elite dragonkin at the {zone:1440}, {zone:1444} and {zone:1425} portals (5% each) and the {npc:15625} in {zone:1431}. Raid content."] = "{quest:8735} 需要从四座梦魇之龙传送门各获得一块碎片：{zone:1440}、{zone:1444} 和 {zone:1425} 传送门处的精英龙人（各5%），以及 {zone:1431} 的 {npc:15625}。这是团队内容。",
	["10 (and 100 Cenarion Circle)"] = "10 点声望（另有 100 点塞纳里奥议会声望）",

	-- Step 27: The Ashenvale portal
	-- {zone:1440} Ashenvale
	["The {zone:1440} portal"] = "{zone:1440} 的传送门",
	["The four dream portals sit in groves guarded by elite dragonkin of level 60 to 62 that respawn every 30 minutes; each drops the portal's fragment one time in twenty. Raid content."] = "四座翡翠梦境传送门位于林地中，由60至62级精英龙类守卫，每30分钟刷新；每只掉落对应传送门碎片的概率为二十分之一。这是团队内容。",

	-- Step 28: The Duskwood portal
	-- {zone:1431} Duskwood
	["The {zone:1431} portal"] = "{zone:1431} 的传送门",
	-- {npc:15625} Twilight Corrupter
	["The {npc:15625} (level 63 boss) always drops its fragment."] = "{npc:15625}（63级首领）必定掉落其碎片。",

	-- Step 29: The Feralas portal
	-- {zone:1444} Feralas
	["The {zone:1444} portal"] = "{zone:1444} 的传送门",

	-- Step 30: Hinterlands portal
	-- {zone:1425} Hinterlands
	["{zone:1425} portal"] = "{zone:1425}传送门",

	-- Step 31: The Nightmare Manifests
	-- {npc:11832} Keeper Remulos · {area:2361} Nighthaven
	["A raid event: follow {npc:11832} toward {area:2361} and keep him alive against Eranikus and his nightmare adds until Tyrande arrives and redeems Eranikus. Do not kill Eranikus."] = "团队事件：跟随 {npc:11832} 前往 {area:2361}，在伊兰尼库斯及其梦魇随从的攻击下保护他存活，直到泰兰德到来并救赎伊兰尼库斯。不要杀死伊兰尼库斯。",
	["100 (and 100 Cenarion Circle)"] = "100 点声望（另有 100 点塞纳里奥议会声望）。",
	["The Redemption of Eranikus: raid"] = "伊兰尼库斯的救赎：团队",
	["200 (and 200 Cenarion Circle)"] = "200 点声望（另有 200 点塞纳里奥议会声望）",

	-- Step 32: The Scepter of the Shifting Sands
	-- {npc:15192} Anachronos · {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj
	["With the three shards, {npc:15192} makes the Scepter of the Shifting Sands. In Classic its first holder rings the {object:180717} once for the whole realm, opening the gates of {area:3428}, and those who finish within ten hours earn the black qiraji crystal mount; whether Forever's realms get that event is not known."] = "集齐三块碎片后，{npc:15192} 会制作流沙节杖。经典旧世中，第一位持有者可为整个服务器敲响一次 {object:180717}，开启 {area:3428} 大门；在十小时内完成的玩家可获得黑色其拉水晶坐骑；目前尚不清楚无限的服务器是否会开放这一事件。",

	-- Step 33: Scarab Gong
	-- {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj · {npc:15693} Jonathan the Revelator · {quest:8745} Treasure of the Timeless One
	["{object:180717} hangs before the gates of {area:3428}. {npc:15693} appears beside it once the gong has been rung, with {quest:8745}: a weapon and 200 reputation."] = "{object:180717} 悬挂在 {area:3428} 大门前。有人敲响甲虫之锣后，{npc:15693} 会出现在旁边，提供 {quest:8745}：奖励一件武器和200点声望。",

	-- Step 34: Neutral to Friendly in the Temple
	["Neutral to Friendly in the Temple"] = "在神殿内从中立提升到友善。",
	-- {area:16076} Temple of Ahn'Qiraj · {area:2737} Scarab Wall · {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {area:3454} Ruins of Ahn'Qiraj
	["Neutral to Friendly is 3,000 reputation. Every trash mob of the {area:16076} (a 40-player raid behind the {area:2737}) gives 100, and the Twin Emperors 210 each, until 2,999 of 3,000 Neutral, one point short of Friendly; there they stop. Then hand in one saved {item:21230} (1,000, to {npc:15502}) or {item:21229} (500, to {npc:15503}) to tip you over. The shoulder and boot exchanges of the Temple's tier set need no standing: the token, two idols and ten scarabs to {npc:15502} (shoulders) or {npc:15503} (boots) pay 200 each. The {area:3454} (20 players) give a little from bosses: Kurinnaxx, Moam, Buru and Ayamiss 50 each, Rajaxx 34, Ossirian 100, to Exalted."] = "中立到友善需要3,000声望。{area:16076}（{area:2737}后方的40人团队副本）的每只普通怪提供100，双子皇帝各提供210，直到中立进度2,999/3,000，距离友善差一点时停止。此时交还一个留存的{item:21230}（1,000，交给{npc:15502}）或{item:21229}（500，交给{npc:15503}），即可跨过门槛。神殿套装的肩部和鞋子兑换没有声望等级要求：将兑换物、2个雕像和10个圣甲虫交给{npc:15502}（肩部）或{npc:15503}（鞋子），每次奖励200。{area:3454}（20人）的首领提供少量声望：库林纳克斯、莫阿姆、布鲁和阿亚米斯各50，拉贾克斯34，奥斯里安100，可一直到崇拜。",
	-- {item:21229} Qiraji Lord's Insignia
	["{item:21229}, Temple bosses"] = "{item:21229}，由神殿首领掉落",

	-- Step 35: The ring at Friendly
	["The ring at Friendly"] = "友善时的戒指",
	-- {npc:15192} Anachronos
	["At Friendly, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "达到友善后，{npc:15192} 会升级你所选路线的戒指：“保护者之路”、征服者之路或祈求者之路。带上你佩戴的戒指；奖励 100 点声望。",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Friendly ring quest of your path"] = "{npc:15192}：你所选路线的友善戒指任务",

	-- Step 36: Friendly to Honored: the turn-ins
	["Friendly to Honored: the turn-ins"] = "友善到尊敬：交还收集品",
	-- {item:21230} Ancient Qiraji Artifact · {quest:8784} Secrets of the Qiraji · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {quest:8595} Mortal Champions · {npc:15727} C'Thun
	["Now hand in what you saved. Each {item:21230} (any Temple trash, 1% to 9%) starts {quest:8784}: 1,000 reputation from {npc:15502}, one of the three bronze dragons inside the Temple. Each {item:21229} (nearly every Temple boss) goes to {npc:15503} for {quest:8595}: 500 here and 100 Cenarion Circle. {npc:15727} gives 2,500, to Exalted. Friendly to Honored is 6,000: six artifacts or twelve insignias. Friendly also opens the helm and leg exchanges of the Temple's tier set (200 reputation each) at {npc:15502} and {npc:15503}."] = "现在交还你攒下的物品。每个 {item:21230}（神殿任意小怪掉落，概率 1% 至 9%）都会开启 {quest:8784}：交给神殿内三条青铜龙之一的 {npc:15502}，可获 1,000 点声望。每个 {item:21229}（几乎每名神殿首领都会掉落）交给 {npc:15503} 完成 {quest:8595}：本阵营 500 点，另有塞纳里奥议会 100 点。{npc:15727} 会给予 2,500 点声望，直到崇拜都有效。友善到尊敬需要 6,000 点：六件神器或十二枚徽记。友善还会开放神殿套装的头盔和护腿兑换，在 {npc:15502} 和 {npc:15503} 处进行（每件 200 点声望）。",
	-- {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos
	["{item:21230}: right-click it, then {npc:15502}"] = "{item:21230}：右键点击，然后找{npc:15502}",
	-- {quest:8595} Mortal Champions
	["{quest:8595}: 1 insignia, 500"] = "{quest:8595}：1枚徽记，500",

	-- Step 37: The ring at Honored
	["The ring at Honored"] = "尊敬时的戒指",
	-- {npc:15192} Anachronos
	["At Honored, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "尊敬时，{npc:15192} 会升级你所选路线的戒指：保护者之路、征服者之路或祈求者之路。带上正在佩戴的戒指；奖励100点声望。",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Honored ring quest of your path"] = "{npc:15192}：你所选路线的尊敬戒指任务",

	-- Step 38: Honored to Revered
	["Honored to Revered"] = "尊敬到崇敬",
	-- {npc:15727} C'Thun · {quest:8595} Mortal Champions · {quest:8789} Imperial Qiraji Armaments · {npc:15380} Arygos · {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["Honored to Revered is 12,000: twelve artifacts, 24 insignias, or a mix with {npc:15727} (2,500). After the first, each insignia is the repeatable {quest:8595}. Every Temple boss sometimes drops an {quest:8789} or Regalia (about one time in twenty): {npc:15380} and {npc:15378}, inside the Temple once {npc:15727} is dead, take it with 3 {item:18562} for 200 and a weapon. Honored opens the chest exchange of the tier set (200)."] = "尊敬到崇敬需要 12,000 点：十二件神器、24 枚徽记，或混合交还并击杀 {npc:15727}（2,500 点）。首次之后，每枚徽记都通过可重复任务 {quest:8595} 交还。每名神殿首领都有概率掉落 {quest:8789} 或 其拉帝王徽记（约二十分之一）：{npc:15727} 死后，神殿内的 {npc:15380} 和 {npc:15378} 会收取它，再加 3 个 {item:18562}，奖励 200 点声望和一件武器。尊敬后开放套装胸甲兑换（200 点）。",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}, {area:2677} or the auction house"] = "{item:18562}，来自 {area:2677} 或拍卖行",
	-- {npc:15380} Arygos · {item:18562} Elementium Ore
	["{npc:15380}: Armaments and 3 {item:18562}, 200"] = "{npc:15380}：其拉帝王武器 和 3 个 {item:18562}，200 点声望。",
	-- {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["{npc:15378}: Regalia and 3 {item:18562}, 200"] = "{npc:15378}：其拉帝王徽记 和 3 个 {item:18562}，200 点声望。",

	-- Step 39: The ring at Revered
	["The ring at Revered"] = "崇敬时的戒指",
	-- {npc:15192} Anachronos
	["At Revered, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "达到崇敬后，{npc:15192} 会升级你所选路线的戒指：“保护者之路”、征服者之路或祈求者之路。带上你佩戴的戒指；奖励 100 点声望。",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Revered ring quest of your path"] = "{npc:15192}：你所选路线的崇敬戒指任务",

	-- Step 40: Revered to Exalted
	["Revered to Exalted"] = "崇敬到崇拜",
	-- {npc:15727} C'Thun · {quest:8801} C'Thun's Legacy · {npc:15379} Caelestrasz
	["Revered to Exalted is 21,000: 21 artifacts or 42 insignias, with {npc:15727}'s 2,500 a week. {npc:15727}'s eye starts {quest:8801} for {npc:15379} (200, and 200 Cenarion Circle). At Exalted Anachronos gives the last ring: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker."] = "从崇敬到崇拜需要21,000点：相当于21件神器或42枚徽记，另有 {npc:15727} 每周提供的2,500点。{npc:15727} 的眼睛会开启交给 {npc:15379} 的 {quest:8801}（200点，以及200点塞纳里奥议会声望）。崇拜后，阿纳克洛斯会给予最后一枚戒指：卡利姆多的保护者、其拉虫人的征服者或虔诚的祈求者。",

	-- Step 41: The Exalted ring
	["The Exalted ring"] = "崇拜戒指",
	-- {npc:15192} Anachronos
	["At Exalted, {npc:15192} gives the last ring of your path: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker. Bring the Revered ring; 100 reputation."] = "崇拜时，{npc:15192} 会给予所选路线的最后一枚戒指：卡利姆多的保护者、其拉虫人的征服者或虔诚的祈求者。带上崇敬时的戒指；奖励100点声望。",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Exalted ring quest of your path"] = "{npc:15192}：你所选路线的崇拜戒指任务。",
}
