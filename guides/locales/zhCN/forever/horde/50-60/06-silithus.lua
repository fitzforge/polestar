-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "向西骑往沙漠中央有城墙环绕的要塞。{npc:15189}站在他那座建筑的楼上：从里面上楼，箭头分不清楼层。",

	-- Step 2: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}：沿途击杀以下目标",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "掘泥打击者、石鞭蝎和掠沙蜘蛛共处于要塞正北的沙地上。",

	-- Step 3: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "发光的石板碎片散落在遥远西北的暮光营地周围；那里的灰尘风暴和沙漠奔行者也会掉落碎片。",

	-- Step 4: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}站在他那座建筑的楼上：从里面上楼，箭头分不清楼层。",

	-- Step 5: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "回到南风村，爬上塔。搅动塔顶的虫巢会引出亚什伏击者；其中一个携带{item:17346}。",

	-- Step 6: The Spirits of Southwind
	["The Spirits of Southwind"] = "",
	["Inside"] = "在里面",

	-- Step 7: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "向东南骑往安戈洛悬崖下的{area:3447}。",
	["Below ground"] = "在地下",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "从{npc:11739}身上获取{item:20377}，在西南130码处",

	-- Step 8: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "掘泥摧毁者和巨钳蝎",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "沿西部沙丘向北；掘泥摧毁者和石鞭巨钳蝎分布在从这里到要塞的一带。",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "{npc:11741}在{area:2738}附近巡逻，请在地图标出的圆圈内寻找",

	-- Step 9: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "向西骑往{area:2744}北边的部落营地。",

	-- Step 10: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "水晶尘喷泉在南部沙漠各处喷发。走进喷泉留下的水晶尘，把它带到吉里卡营地的部落水晶尘提取器；战斗或骑上坐骑都会让它掉落。",

	-- Step 11: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "石鞭掠夺者和石行蜘蛛",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "石鞭掠夺者和石行蜘蛛在吉里卡营地西南的沙丘上游荡。",

	-- Step 12: Twilight Vanguard
	["Twilight Vanguard"] = "暮光先锋军营地",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "",

	-- Step 14: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200}占据着西边的营地。",

	-- Step 15: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "",

	-- Step 16: Level 58
	["Level 58"] = "58 级",
	-- {npc:15181} Commander Mar'alith · {quest:8304} Dearest Natalia · {area:3425} Cenarion Hold · {area:1583} Blackrock Spire · {quest:838} Scholomance
	-- plural, as words: Twilight Avengers = {npc:11880} Twilight Avenger
	["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Twilight Avengers, Geolords and Stonecallers west of the outpost. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "{area:3425} 的 {npc:15181} 提供的 {quest:8304} 需要 58 级：击杀前哨站西侧的暮光复仇者、暮光地王和暮光唤石者补足经验。也可组队前往 {area:1583} 副本（下层）或 {quest:838} 副本。",
	-- {npc:11880} Twilight Avenger
	["grind on {npc:11880}"] = "击杀 {npc:11880} 刷经验",

	-- Step 17: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}和{npc:15190}站在他们那座建筑的楼上：从里面上楼，箭头分不清楼层。",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}，在要塞西侧",

	-- Step 18: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "向东北骑往{area:3447}。",

	-- Step 19: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "诺格的背包在遥远南方的山里，过了铜须营地。精英蝎子死亡弯钩在附近巡逻：趁它走开时拿走背包。",

	-- Step 20: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "{npc:15171} 和 {npc:15170} 在 Bronzebeard's Encampment 扎营，就在丢失背包所在山地的北边。询问他们：与两人分别完成全部对话；无需战斗。",

	-- Step 21: Twilight Base Camp
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell."] = "",
	-- {npc:15306} Bor Wildmane
	["ten for each quest: {npc:15306} takes his ten before Ortell"] = "",

	-- Step 22: Twilight Base Camp
	["The spare texts from the cultists"] = "信徒身上多出来的密文信",

	-- Step 23: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "返回{area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190}站在他那座建筑的楼上：从里面上楼，箭头分不清楼层。",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "玛尔利斯接下来的任务“深入疯狂之口”会带你进入精英遍布的 {area:2744}。跳过它。",

	-- Step 25: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "向东北骑往{area:3077}；你从旁边的山口离开{zone:1451}。",

	-- Step 27: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock
	["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "",

	-- Step 28: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "地精{npc:10302}坐在水晶塔正东的{area:543}。",

	-- Step 29: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "向东骑往{area:537}，爬上去，在接近山顶的熔岩口使用{npc:10541}，然后向西骑回{npc:10302}那里。",

	-- Step 30: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302}让你去找{zone:1452}的{npc:9298}：留着它。",

	-- Step 31: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "在 {area:540} 的格里什虫巢内、箭头所指的位置使用 {item:11833}，召唤 {npc:10041}（56 级）。",

	-- Step 32: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "留着诱饵：{npc:9684}是56级，第二圈会经过它的巢穴。",

	-- Step 33: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "{npc:9684}的巢穴就在水晶塔正南。在那里使用{npc:9619}的诱饵；{npc:9684}是56级，攻击很重，所以满血再开始。",

	-- Step 34: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "{zone:1449}：沿途击杀以下目标",
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["Careful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "小心：安戈洛猩猩（50-51 级）的生命值降到 25% 时，会呼叫 20 码内的同伴援助。此地有一座满是猩猩的洞穴，在里面战斗会引来许多额外怪物。",

	-- Step 35: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117} is inside the cave."] = "{npc:9117} 在洞穴内。",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}：在地下",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "留着{quest:3942}：{npc:9116}在{area:2479}，下一个指南穿过{zone:1448}时会经过。",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {npc:10980} on {npc:10977}"] = "对{npc:10977}使用{npc:10980}",
	-- {npc:10977} Quixxil · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10977} with {npc:10980}"] = "",

	-- Step 36: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999}坐在山脊上，迷路了，筋疲力尽。",

	-- Step 37: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "护送{npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "向北护送{npc:9999}前往{area:541}。他昏倒时，对他使用{item:11804}唤醒。",

	-- Step 39: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "{npc:9619}接下来要东北洞穴里{npc:9622}的毛皮：跳过它。",

	-- Step 41: Gadgetzan
	-- {area:976} Gadgetzan · {object:142071} Egg-O-Matic
	["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "飞往{area:976}。{object:142071}立在镇中央。",

	-- Step 42: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}的飞行管理员",

	-- Step 43: Class trainer
	["Class trainer"] = "职业训练师",

	-- Step 44: Paladin trainer
	["Paladin trainer"] = "圣骑士训练师",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{zone:1456}的{npc:246344}；{zone:1454}没有圣骑士训练师",

	-- Step 47: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "乘飞艇前往{zone:1458}",

	-- Step 50: Radley and Durgen
	["Radley and Durgen"] = "猎人莱德雷和骑士杜尔根",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} 站在伐木营地东边；{npc:11611} 守在 {npc:11610} 东北、通往 {area:190} 的道路旁。\n小心：塔底有守卫，另有一名绕塔巡逻。与杜根·挽锤交战前先清掉它们，避免它们加入战斗。",

	-- Step 51: Northridge Lumber Camp
	-- {npc:11615} Mickey Levine
	["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "",

	-- Step 53: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "圣契在更北边，通往{area:190}的路上。",

	-- Step 54: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "{area:190} 的血色十字军是 58-60 级。骑马进去，到地图标记的高点俯瞰镇子，然后离开。\n小心：门口的哨兵能侦测潜行玩家。镇内还有更多哨兵，附近也有一名精英巡逻。",

	-- Step 56: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "安多哈尔的哨塔和粮仓",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "向南骑进安多哈尔。{npc:10667}在城镇西侧被毁的旅店里等候。拿着{item:12815}站在四座塔的每一个门口来标记它；沿城镇边缘走。在镇中央的粮仓旁使用{item:12627}引出时光寄生虫。",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}：在楼上",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}标记{npc:10903}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}标记{npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}标记{npc:10905}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}标记{npc:10902}",

	-- Step 57: Chromie
	["Upstairs"] = "在楼上",

	-- Step 58: Counting Out Time
	-- {npc:10667} Chromie
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "锁箱放在{npc:10667}所在旅店周围的安多哈尔废弃房屋里。小心：食尸鬼和骷髅通常站在箱子旁，你靠近时会发动攻击。灼热食尸鬼还会伤害附近所有人，并会打破潜行。",

	-- Step 63: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "沿道路向东，{npc:11077}守着{area:200}的瘟疫之锅。",

	-- Step 65: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "盾牌在{npc:1855}小屋南边的{area:201}。",

	-- Step 66: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "向东骑往{area:2619}旁{npc:1855}的小屋，听他把话说完。",

	-- Step 69: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "天灾勇士",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "天灾勇士在教堂北边的{area:2270}游荡。在你杀死的每一个身上晃一晃{npc:11063}的{item:13156}：产生共鸣的头骨就是他要的。",

	-- Step 71: Hameya's scroll
	["Hameya's scroll"] = "哈米亚的卷轴",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "一张破损的卷轴在{area:2260}南边的墓穴{area:2261}的入口处。",

	-- Step 72: Pamela and the Undercroft
	-- {area:2261} Undercroft
	["Pamela and the {area:2261}"] = "帕米拉和 {area:2261}",
	-- {area:2262} Darrowshire · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "骑马前往西南的 {area:2262}；帕米拉在房屋之间玩耍。{npc:11886} 潜伏在 {area:2261}，也就是镇子正西边的墓穴。\n小心：墨丘利奥会带来约四只非精英小怪。它们会走到墓前，而不是直接在原地出现。",

	-- Step 74: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "向西北骑往{npc:1855}的小屋。",

	-- Step 77: Level 59.14
	["Level 59.14"] = "等级 59.14",
	-- {quest:6135} Duskwing, Oh How I Hate Thee... · {quest:838} Scholomance · {area:2279} Stratholme
	["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan. Or, with a group, run the {quest:838} dungeon or the {area:2279} dungeon instead."] = "如果跳过了 {quest:6135}，就在此刷到 59.14 级，跟上路线规划。也可组队前往 {quest:838} 副本或 {area:2279} 副本。",
	-- {npc:10717} Temporal Parasite
	["grind on {npc:10717}"] = "击杀{npc:10717}刷经验",

	-- Step 78: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "向西南骑往安多哈尔的{npc:10667}那里。",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "{npc:10667}的达隆郡之战最后要对付精英。跳过它。",

	-- Step 79: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "向西前往 {area:152}。",

	-- Step 80: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "进入{zone:1423}",

	-- Step 81: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "",

	-- Step 82: Of Lost Honor
	["Underwater"] = "在水下",

	-- Step 83: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "哈米亚 藏在东北角{area:2273}的烂苔巨魔之中。\n小心：通往{area:2273}的路上，巨魔为57-59级。它们低血量时会逃跑求援，经常引来额外怪物。",

	-- Step 85: Hameya's mound
	["Hameya's mound"] = "哈米亚的土堆",
	-- {npc:1855} Tirion Fordring · {area:2261} Undercroft · {object:177675} Mound of Dirt
	["Ride south-east from {npc:1855} to the {area:2261}; the {object:177675} is just behind it."] = "",

	-- Step 86: Into Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Into {zone:1422}"] = "进入{zone:1422}",

	-- Step 89: Target: Writhing Haunt
	-- {npc:11055} Shadow Priestess Vandis · {area:152} The Bulwark
	["from the cauldron, for {npc:11055} at the {area:152}"] = "",

	-- Step 91: Target: Gahrron's Withering
	-- {area:202} Writhing Haunt · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Back east past the {area:202} to {area:201}, the farm under the eastern hills: {npc:11078} guards its cauldron. Kill him for the key, then use the cauldron."] = "",

	-- Step 92: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152} one last time."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "迪瑟斯提供{item:14619}（{quest:838}）。跳过它。",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "掘泥打击者、石鞭蝎和掠沙蜘蛛共处于要塞正北的沙地上。",
	-- ["Dredge and scorpids"] = "掘泥者和蝎子",
	-- ["Fly to {area:1637} and train."] = "飞往{area:1637}训练。",
	-- ["Fly to {area:541}"] = "飞往{area:541}",
	-- ["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "玛尔利斯的“最亲爱的纳塔莉亚”需要58级，而且要进入满是精英的{area:2744}。跳过它。",
	-- ["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "向北前往伐木场；把白蚁桶放在锯木厂中央。",
	-- ["Ride east across the plaguelands to the chapel."] = "向东骑过瘟疫之地前往教堂。",
	-- ["Ride east along the road to the {area:152} on the border."] = "沿道路向东骑往边境上的{area:152}。",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "向西南骑往{area:2738}的废墟。给{npc:11801}的{object:179565}在其中一座毁坏的房子里。",
	-- ["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "骑往西南的{area:2262}；{npc:10926}在房子间玩耍。{npc:11886}潜伏在城镇正西的墓穴{area:2261}里。",
	-- ["Ride west to the walled hold in the middle of the desert."] = "向西骑往沙漠中央有城墙环绕的塞纳里奥要塞。",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "在{area:1637}外的塔上乘飞艇前往{zone:1420}，再骑进{zone:1458}。希尔瓦娜斯·风行者在{object:36126}。",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "发光的石板碎片散落在遥远西北的暮光营地周围；那里的灰尘风暴和沙漠奔行者也会掉落碎片。",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "从安戈洛环形山出来的山口通往{area:3077}，那是{zone:1451}东北部的墓地。{npc:13220}站在坟墓之间。",
	-- ["The wooden sign beside {npc:9997}"] = "{npc:9997}旁边的木牌",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675}就在{area:2261}后面。",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave."] = "穿过山口，沿北侧峭壁向东到 {area:541}。{npc:8737} 就站在洞口旁。",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "穿过山口，沿北边的悬崖向东前往{area:541}。{npc:8737}站在洞穴旁；{npc:9117}在洞里。",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "向西前往{area:152}。下一个指南从西边不远的{zone:1458}开始。",
	-- ["{area:1099} flight master"] = "{area:1099}的飞行管理员",
	-- ["{item:20375} on the way"] = "顺路获取{item:20375}",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "{npc:10778}的农场是{area:152}东边的第一座农场。农场上的{npc:10801}携带她护身符的另一半；{npc:11075}守着田里的瘟疫之锅。",
	-- ["{npc:10926} and the {area:2261}"] = "{npc:10926}和{area:2261}",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "{npc:10926}自己的差事不在本路线上。跳过它。",
	-- ["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803}在遥远西南的暮光先锋军营地里走动。这里的每个信徒都会掉落暮光密文信，不管你有没有任务：收集二十份，十份给{npc:15306}，十份给奥泰尔。",
	-- ["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804}站在{area:3425}西边的前哨站里。在这里的信徒身上把暮光密文信补到二十份。",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "{npc:11878}的差事不在本路线上。跳过它们。",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "{npc:15193}的勇士占据着{area:2261}北边{area:2260}的农舍。",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}，在要塞西侧",
	-- ["{npc:15306}, on the west side of the Hold: the texts are already in your bags"] = "{npc:15306}，在要塞西侧：密文信已经在你的背包里",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "{npc:1855}的下一个任务（失落的荣耀）不在本路线上。跳过它。",
	-- ["{npc:9167} walks around here: look inside the circle on the map"] = "{npc:9167}在附近巡逻，请在地图标示的圆圈内寻找",
}
