-- Chinese (simplified) (zhCN): the guide forever/horde/40-50/04-tanaris (forever/horde/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飞往{area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "{area:1099}的飞行管理员",

	-- Step 3: Gadgetzan
	-- {npc:7876} Tran'rek · {area:979} Sandsorrow Watch
	["The flight lands beside {npc:7876}. Take the town's quests before riding west to {area:979}."] = "",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}，在双足飞龙管理员旁边",

	-- Step 5: Sandsorrow Watch
	-- {item:8584} Untapped Dowsing Widget
	["West of Gadgetzan, use the {item:8584} beside the water hole in the troll camp."] = "在加基森西边，在巨魔营地的水坑旁使用{item:8584}。",

	-- Step 6: Senior Surveyor Fizzledowser
	-- {area:976} Gadgetzan · {npc:7771} Marvon Rivetseeker
	["Back east to Fizzledowser on the west side of {area:976}; {npc:7771} is south from there."] = "",

	-- Step 7: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:9978} Gahz'ridian Detector · {area:983} Dunemaul Compound
	["West along the road south; {npc:7771} camps by the ruins at the {area:1938}. Put on his {item:9978}: it shows the buried ornaments, here and around the {area:983}."] = "沿道路向西再向南；{npc:7771}在{area:1938}的废墟旁扎营。戴上他的{item:9978}：它会显示埋在这里和{area:983}周围的饰物。",

	-- Step 8: Broken Pillar: kill these as you meet them
	-- {area:1938} Broken Pillar
	["{area:1938}: kill these as you meet them"] = "{area:1938}：沿途遇到就击杀",
	-- {area:982} Noxious Lair · {npc:12046} Gor'marok the Ravager · {quest:3161} Gahz'ridian
	["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "在{area:982}南边，砂槌食人魔占据着他们的营地，{npc:12046}在营地东端。在战斗间隙挖出{quest:3161}饰物。",
	["Below ground"] = "在地下",

	-- Step 9: Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["West, the Centipaar insects swarm around their hives; any of them drops the parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "西边的森提帕尔虫群聚集在巢穴周围；每种都会掉落部件。\n小心：森提帕尔群居蝎在战斗内外都会施放 {npc:4196}，召来会打断你的小怪。",

	-- Step 10: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "{quest:3362}：沿途击杀以下目标",
	-- {zone:1446} Tanaris
	["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "营地西侧的山谷遍布仙人掌般的生物；只有露水收集者携带露腺。{zone:1446} 的大多数怪物都有极低概率掉落 OOX-17/TN 的求救信标：看见就留着。\n小心：此地其他灌木怪为 49-50 级，四处游荡，很容易额外引怪。",
	-- {item:8623} OOX-17/TN Distress Beacon
	["{item:8623}, a rare drop"] = "{item:8623}，稀有掉落",

	-- Step 11: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "护送{npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port · {npc:8579} Yeh'kinya
	["{npc:5955} waits in the valley. Walk him all the way to his wife {npc:6015} in {area:977}, north-east across the desert: stay close, slow down for him and fight off what attacks him. Do not mount or hearth out of his reach. {npc:8579} stands in the port too."] = "{npc:5955}在山谷里等候。一路带他到东北方沙漠另一头{area:977}的妻子{npc:6015}那里：紧跟着他，放慢速度等他，击退攻击他的敌人。别骑上坐骑或用炉石离开他的范围。{npc:8579}也站在港口里。",

	-- Step 13: Slake That Thirst
	-- {spell:686} Shadow Bolt
	["Careful: Shadow Mages (level 42-43) call a Voidwalker while out of combat and attack with Immolate and {spell:686}. Thieves can Disarm you, Rogues move around in Sneak, and Assassins use Execute once you are at 20% health or less."] = "小心：暗影法师（42-43级）会在脱战时召唤虚空行者，使用献祭和{spell:686}攻击。窃贼会缴械，潜行者会潜行移动，刺客则会在你生命值不超过20%时使用斩杀。",

	-- Step 14: Gadgetzan
	["Use the Model 4711-FTZ Power Source Bilgewhizzle gave you: a two-hour timer starts"] = "",

	-- Step 15: Gadgetzan
	-- {item:8526} Violet Tragan · {zone:1425} Hinterlands
	["the {item:8526} grows in the {zone:1425}, around level 48"] = "{item:8526}生长在{zone:1425}，大约48级时",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}：在屋内",

	-- Step 16: Tanaris Field Sampling
	-- {area:976} Gadgetzan
	-- plural, as words: Blisterpaw Hyenas = {npc:5426} Blisterpaw Hyena · Glasshide Basilisks = {npc:5419} Glasshide Basilisk · Scorpid Hunters = {npc:5422} Scorpid Hunter
	["Just south of {area:976} the Blisterpaw Hyenas, Glasshide Basilisks and Scorpid Hunters share the dunes. Each can drop an untested sample: use it, and it either passes as an acceptable one or is lost. Keep killing until you have eight of each."] = "",

	-- Step 18: Scrimshank's gear
	["Scrimshank's gear"] = "谢申克的勘探设备",
	["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "再往南，初级勘探员斯克林杰的装备在一个森提帕尔虫巢的入口处。\n注意：装备旁有一只虫子守着。隧道内有许多虫子巡逻，其中一些为50级，因此战斗时经常会引来额外的敌人。",

	-- Step 19: OOX-17/TN
	["OOX-17/TN"] = "OOX-17/TN",
	-- {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}.\nCareful: The escort has two ambushes. Three level 47 scorpids attack near the start. Near the end, by the beach, three Wastewander humans attack: one mage and two assassins, around level 44."] = "仅在持有求救信标时进行：OOX-17/TN 位于斯克林谢尔的虫巢东南方。护送它向北前往 {area:977}；奖励要到 {area:35} 找奥格索普领取。\n小心：护送途中有两次伏击。刚开始不久会有三只 47 级蝎子袭来。快到终点、靠近海滩时，会有三名废土人类袭击：一名法师和两名刺客，约 44 级。",

	-- Step 20: Gadgetzan
	-- {npc:5204} Apothecary Zinge · {zone:1458} Undercity
	["for {npc:5204} in the {zone:1458}, around level 52"] = "",
	-- {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["for {npc:7010} in {zone:1454}, around level 50"] = "交给{zone:1454}的{npc:7010}，大约50级时",

	-- Step 21: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "乘船前往{area:16727}",

	-- Step 22: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "进入{zone:1427}",

	-- Step 23: Searing Gorge
	-- {area:247} Grimesilt Dig Site
	["The {area:247}"] = "{area:247}",

	-- Step 24: The Grimesilt Dig Site
	-- {area:16727} Powderfuse Port · {zone:1427} Searing Gorge · {object:173265} Wooden Outhouse · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:16727}, ride into the {zone:1427} by its eastern pass, then west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "从 {area:16727} 骑行，经东侧山口进入 {zone:1427}，再向西到挖掘场。{object:173265} 在挖掘场南端；黑铁地质学家就在它北边不远处挖掘。带上 15 个 {item:4306}（拍卖行有售）。",
	-- {object:173265} Wooden Outhouse
	["the {object:173265}"] = "{object:173265}",

	-- Step 26: Thorium Point
	-- {area:1446} Thorium Point
	["Ride north-west across the gorge; {area:1446} is the scaffolded camp in the north-west."] = "向西北骑过峡谷；{area:1446}是西北边搭着脚手架的营地。",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "{object:179827}告示板",

	-- Step 27: The Cauldron's slavers and golems
	-- {area:246} The Cauldron
	["{area:246}'s slavers and golems"] = "{area:246} 的奴隶贩子和傀儡",
	-- {area:1446} Thorium Point · {npc:8479} Velarok Windblade
	-- plural, as words: Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Heavy War Golems = {npc:5854} Heavy War Golem
	["Ride south from {area:1446} into the Cauldron: the Dark Iron Taskmasters and Slavers drive the slaves on the paths, and the Heavy War Golems patrol the floor below {npc:8479}."] = "",

	-- Step 28: Velarok Windblade
	-- {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["{npc:8479} stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "",

	-- Step 31: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "{zone:1427}：沿途击杀以下目标",
	-- {npc:8479} Velarok Windblade · {item:11818} Grimesilt Outhouse Key · {area:1443} The Slag Pit
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Blazing Elementals = {npc:5850} Blazing Elemental · Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Greater Lava Spiders = {npc:5858} Greater Lava Spider · Incendosaurs = {npc:9318} Incendosaur · Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Heavy War Golems patrol the Cauldron below {npc:8479} and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it.\nThe Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge.\n{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "",
	-- {item:11818} Grimesilt Outhouse Key
	["{item:11818}, a rare drop"] = "{item:11818}，稀有掉落",

	-- Step 33: Thorium Point
	-- {area:1446} Thorium Point · {npc:8479} Velarok Windblade
	["Ride back north to {area:1446}, just past {npc:8479}."] = "",

	-- Step 34: The Steamsmiths' furnaces
	["The Steamsmiths' furnaces"] = "黑铁锻造师的熔炉",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith
	["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "黑铁锻造师在大熔炉中央的熔炉旁干活；他们一半带着{item:10551}，十分之一带着{item:18959}。奴隶工、黑铁奴隶贩子和黑铁工头也带着匕首。",

	-- Step 35: Velarok Windblade
	-- {item:10552} Symbol of Ragnaros
	["His next request needs the {item:10552} from elite cultists: leave it."] = "他的下一个请求需要精英信徒身上的{item:10552}：别接。",

	-- Step 37: Dark Iron Lookouts
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["Dark Iron Lookouts"] = "黑铁哨兵",
	-- {item:18960} Lookout's Spyglass
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "黑铁哨兵站在大熔炉南边哨塔周围的山脊上；大约十分之一带着{item:18960}。",

	-- Step 38: The Key to Freedom
	-- {item:11818} Grimesilt Outhouse Key · {object:173265} Wooden Outhouse
	["Only with the {item:11818}: back east to the {object:173265} at the dig site."] = "仅当你有{item:11818}时：向东回到挖掘场的{object:173265}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "乘船前往{area:35}",
	-- ["Dark Iron Lookouts"] = "黑铁哨兵",
	-- ["Fly to {area:1637} and train: the next guide's training stop is the {zone:1458}, which has no Hunter or Shaman trainer. Then fly to {area:392}."] = "飞往{area:1637}训练：下一个指南的训练地点是{zone:1458}，那里没有猎人和萨满祭司训练师。然后飞往{area:392}。",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:392}."] = "飞往{area:1638}，在{area:1639}找{npc:3033}训练，然后飞往{area:392}。",
	-- ["Fly to {area:340}"] = "飞往{area:340}",
	-- ["Fly to {area:392}"] = "飞往{area:392}",
	-- ["From the {area:35} flight master, above the harbour."] = "从港口上方的{area:35}飞行管理员处出发。",
	-- ["From {area:1099}'s flight master."] = "从{area:1099}的飞行管理员处出发。",
	-- ["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive."] = "再往南，初级勘察员谢申克的勘探设备在一个森提帕尔巢穴的入口处。",
	-- ["Greater Lava Spiders"] = "灼热熔岩蜘蛛",
	-- ["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "重型作战傀儡在卡拉然下方的大熔炉里巡逻，掉落傀儡之油；在它们中间漂荡的熔岩元素和炽热元素掉落烈焰之心。黑铁工头和黑铁奴隶贩子在小路上驱赶奴隶；黑铁奴隶贩子可能掉落{item:11818}：留着它。",
	-- ["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it.\nThe Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge.\n{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "重型作战傀儡在卡拉然下方的大熔炉巡逻，会掉落油；其间游荡的熔岩元素和炽热元素掉落心脏。黑铁工头和黑铁奴隶贩子在各条小路上驱赶奴隶；奴隶贩子可能掉落 {item:11818}：保留它。\n灼热熔岩蜘蛛在峡谷西南部的高地和熔岩池一带游荡。\n{area:1443} 的入口位于大熔炉北部。熏火龙在其中的熔岩池里游动：将它们引到池边。秘密计划在矿坑上方的平台上。\n注意：黑铁奴隶贩子（45—46级）被引到时会向15码内的盟友求援，可在最远15码外投网，并在近战中使用撕裂。",
	-- ["Kalaran Windblade"] = "卡拉然·温布雷",
	-- ["Kalaran stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "卡拉然独自站在{area:1446}南边，大熔炉的边缘。听他讲他的故事。",
	-- ["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}."] = "仅当你有定位器时：OOX-17/TN在谢申克所在巢穴的东南边。护送它向北前往{area:977}；它的奖励在{area:35}的奥格索普那里。",
	-- ["Ride back north to {area:1446}."] = "向北骑行返回 {area:1446}。",
	-- ["Ride back north to {area:1446}. Stay here: the next guide starts with the flight to {area:75}."] = "向北骑回{area:1446}。留在这里：下一个指南从飞往{area:75}开始。",
	-- ["Ride south from {area:1446} into the Cauldron: the Dark Iron Taskmasters and Slavers drive the slaves on the paths, and the Heavy War Golems patrol the floor below Kalaran."] = "从 {area:1446} 向南骑行进入大熔炉：黑铁工头和黑铁奴隶贩子在小路上驱赶奴隶，重型作战傀儡在卡拉然下方的坑底巡逻。",
	-- ["Ride south-west to {area:976}."] = "向西南骑往{area:976}。",
	-- ["South down the road again."] = "再次沿道路向南。",
	-- ["South-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp."] = "在加基森东南，废土强盗在沙丘里扎营；{npc:7847}站在东边的营地里。",
	-- ["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "从{area:340}西侧的山口进入{zone:1427}，然后向西南骑往挖掘场。{object:173265}在挖掘场南端；黑铁地质学家就在它北边挖掘。带上15块{item:4306}（拍卖行有卖）。",
	-- ["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "黑铁哨兵站在大熔炉南边哨塔周围的山脊上；大约十分之一带着{item:18960}。",
	-- ["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "黑铁锻造师在大熔炉中央的熔炉旁干活；他们一半带着{item:10551}，十分之一带着{item:18959}。奴隶工、黑铁奴隶贩子和黑铁工头也带着匕首。",
	-- ["The Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge."] = "灼热熔岩蜘蛛在峡谷西南的高地和熔岩池一带游荡。",
	-- ["The Steamsmiths' furnaces"] = "黑铁锻造师的熔炉",
	-- ["The boat to {area:35} docks at {area:392}'s pier, below the flight master's hill."] = "前往{area:35}的船停靠在{area:392}的码头，就在飞行管理员所在山丘的下方。",
	-- ["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one."] = "在营地西边，仙人掌生物占满了山谷；只有灌木露水收集者携带露水腺。{zone:1446}的大多数怪物都可能掉落OOX-17/TN定位器，但很少见：如果看到就留着。",
	-- ["West, the Centipaar insects swarm around their hives; any of them drops the parts."] = "向西，森提帕尔虫群聚集在它们的巢穴周围；任何一只都会掉落森提帕尔昆虫肢体。",
	-- ["the {object:150075} in the square"] = "广场上的{object:150075}",
	-- ["{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge."] = "{area:1443}在大熔炉北部。熏火龙在熔岩池里游动：把它们引到池边。秘密设计图在坑的上层岩架上。",
	-- ["{area:392} pier"] = "{area:392}码头",
}
