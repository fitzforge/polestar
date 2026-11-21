-- Chinese (simplified) (zhCN): the guide forever/horde/30-40/05-arathi-highlands (forever/horde/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "乘飞艇前往{zone:1458}",

	-- Step 2: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "{zone:1458}的训练师",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "趁在{zone:1458}时训练：训练师在{object:36070}、{object:36073}和{object:36082}（圣骑士：{npc:260093}）。",

	-- Step 3: Calder Gray
	-- {npc:270038} Calder Gray
	["{npc:270038} stands in the Apothecarium."] = "{npc:270038}站在炼金房里。",
	-- {npc:270038} Calder Gray · {zone:1441} Thousand Needles
	["{npc:270038}: Stormheart's heart from {zone:1441}"] = "{npc:270038}：来自{zone:1441}的Stormheart之心",

	-- Step 4: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "飞往{area:272}",
	-- {npc:4486} Genavie Callow · {area:340} Kargath
	["Warriors, Paladins, Rogues, Priests, Mages and Warlocks (not Hunters, Shamans or Druids): {npc:4486} stands beside the flight master. The Dabyrie family's farm lies on the road east through Arathi later in this guide, and your level 40 training brings you back to this flight master from {area:340}: she takes the heads then."] = "",
	-- {npc:4486} Genavie Callow
	["{npc:4486}, beside the flight master"] = "",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "{zone:1458}飞行管理员",

	-- Step 5: Tarren Mill
	-- {npc:2229} Krusk · {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow
	["{npc:2229}, {npc:2410} and {npc:2437} are inside the inn; {npc:2770} stands outside it."] = "{npc:2229}、{npc:2410}和{npc:2437}在旅店里；{npc:2770}站在旅店外。",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}：在屋内",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "{npc:2410}：在屋内",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {item:279469} Grimy Key
	["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "{npc:2410}：{quest:93680}，{item:279469}在叛徒附近",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "{npc:2437}：在屋内",
	-- {npc:2770} Tallow · {npc:2771} Drum Fel · {area:321} Hammerfall
	["{npc:2770}: for {npc:2771} in {area:321}, later in this guide"] = "{npc:2770}：交给{area:321}的{npc:2771}，本指南稍后再做",

	-- Step 6: Southshore Stout
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}，交给{npc:2333}",

	-- Step 7: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik · {npc:2229} Krusk
	["Follow the road north out of {area:272} into the Alterac foothills: {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "沿道路从{area:272}向北进入奥特兰克山麓：{quest:535}在辛迪加营地旁等候。只有当你身上有{npc:2229}的渗透任务时，他才会给你差事：立即把烈性黑啤酒交给他，他的奖励就是克鲁斯克要的辛迪加信件。这里辛迪加掉落的信件效果相同：背包里有一封时，指南会跳过{quest:535}。",

	-- Step 8: Syndicate missives
	["Syndicate missives"] = "辛迪加信件",
	-- {quest:535} Valik
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one."] = "仅当没能从{quest:535}那里拿到信件时：道路以西营地周围的辛迪加劫匪和盗贼（32-34级）也带着信件，大约三只掉一封。",

	-- Step 9: Alterac Mountains
	-- {npc:246848} Kirin Tor Guard
	["West along the foot of the hills, south of the road: a {npc:246848} (55) walks that road from the north-east down into the traitors' camp."] = "沿山脚、道路以南向西走：有一名{npc:246848}（55级）沿那条路从东北方一直走进叛徒营地。",
	-- {area:279} Dalaran
	["South of the {area:279} crater's camp"] = "{area:279}陨坑营地以南",

	-- Step 10: The Dalaran crater
	-- {area:279} Dalaran
	["The {area:279} crater"] = "{area:279} 巨坑",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token · Kirin Tor Guards = {npc:246848} Kirin Tor Guard · Kirin Tor Enforcers = {npc:276215} Kirin Tor Enforcer
	["From the south, walk up into the camp below the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together in the camp, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens: the ones on the camp's west side are furthest from the Guard's road.\nCareful: Kirin Tor Guards (55) attack the Horde on sight, and one of them patrols the road that comes down into the camp from the north-east and walks right up to the traitors: he has killed many players here. Watch for him, let him walk back up the road, then pull the traitors. Many of the camp's guards stand in linked pairs and others patrol alone. Arcane Sentries (55, elite) and Kirin Tor Enforcers (55) stand around the violet dome itself: keep to the camp below the rim."] = "从南边走上{area:279}紫色穹顶下方的营地。{npc:2411}、{npc:2412}和{npc:2413}（33-34级）一起站在营地里，{npc:2414}（35级）在他们稍西边；每人都带着一块血石碎片。他们周围的盾卫和法术师（31-33级）掉落用旧的石雕：营地西侧的离卫兵的路线最远。\n小心：肯瑞托卫兵（55级）见到部落就会攻击，其中一名沿东北方进入营地的道路巡逻，一直走到叛徒身边：他在这里杀过很多玩家。留意他，等他沿路走回去，再去拉叛徒。营地里许多守卫成对关联站立，其他则独自巡逻。奥术哨兵（55级，精英）和肯瑞托执法者（55级）守在紫色穹顶周围：待在边缘下方的营地里。",
	-- {item:279469} Grimy Key
	["{item:279469}: an object to loot, by the traitors"] = "{item:279469}：在叛徒旁边的可拾取物体中",
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Worn Stone Tokens, from the Shield Guards and Theurgists on the camp's west side"] = "用旧的石雕，从营地西侧的盾卫和法术师身上获得",

	-- Step 12: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east along the foothills to {area:272}: everything from the first loop is handed in inside the inn."] = "沿山麓向东返回{area:272}：第一轮的任务都在旅店里交还。",

	-- Step 14: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north up the road past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "沿道路向北经过{quest:535}的营地，前往被辛迪加占据的村庄{area:280}（35-37级）。{npc:2431}携带{item:3704}；{quest:503}被关在北侧房屋的笼子里。\n小心：潜行的辛迪加密探在{area:280}游荡，房屋里也有许多辛迪加怪物，包括法师。",
	["Inside"] = "在里面",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "到顶层找到关押{quest:503}的地方",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "{quest:503}，位于顶层",
	-- {npc:2229} Krusk · {npc:2423} Lord Aliden Perenolde · {area:1339} Lordamere Lake
	["{npc:2229} will offer {npc:2423} (41, in his manor far up {area:1339}) for this: leave it, he is over your level."] = "{npc:2229}会因此给你击杀{npc:2423}的任务（41级，在{area:1339}远处的庄园里）：别接，他等级高于你。",

	-- Step 15: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "{area:17707}：沿途遇到就击杀",
	-- {area:280} Strahnbrad · {area:1357} Gallows' Corner · {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave · Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["From {area:280} follow the road south-west to {area:1357} and on west to the ruins north of the {area:279} crater, along the lake shore. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "从{area:280}沿路向西南前往{area:1357}，再继续向西，沿湖岸前往{area:279}巨坑北面的废墟。达拉然召唤师带着元素奴仆；护腕由奴仆掉落。小心：奥术哨兵（55级，精英）和肯瑞托卫兵（55级）守卫着穹顶本身，并会攻击部落：在废墟外缘活动，不要靠近穹顶。",

	-- Step 16: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "返回{area:272}",
	-- {area:272} Tarren Mill
	["Hearth back to {area:272} (your hearthstone is bound there), or walk back south-east along the road out of Alterac."] = "用炉石返回{area:272}（你的炉石绑定在那里），或沿路向东南走出奥特兰克返回。",

	-- Step 17: Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth back to {area:272}: your hearthstone is bound there."] = "用炉石返回{area:272}：你的炉石绑定在那里。",
	["The magus offers a dungeon errand next: leave it."] = "那位魔导师接下来提供的是一个地下城差事：别接。",

	-- Step 18: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "向东穿过{area:1057}的道路",

	-- Step 19: Boulderfist camp
	["Boulderfist camp"] = "石拳营地",
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "从{area:272}向东出发，穿过{area:1057}后沿路继续向东。石拳食人魔和石拳执行者（32-34级）的营地在路南、{area:313}以南；石拳执行者待在那里的洞穴中。",
	["Below ground"] = "在地下",

	-- Step 20: Dabyrie's Farmstead
	-- {npc:4481} Marcel Dabyrie · {npc:4479} Fardel Dabyrie · {npc:4480} Kenata Dabyrie
	["On along the road east: the Dabyrie farm lies just north of it. {npc:4481} (34) and {npc:4479} (33) Dabyrie walk the farm's western yard among their Laborers and Militia (30-32); {npc:4480} (35) stands at the farm's north-eastern edge."] = "",
	-- {item:5832} Marcel's Head · {npc:4481} Marcel Dabyrie
	["{item:5832}, from {npc:4481}"] = "",
	-- {item:5831} Fardel's Head · {npc:4479} Fardel Dabyrie
	["{item:5831}, from {npc:4479}"] = "",
	-- {item:5830} Kenata's Head · {npc:4480} Kenata Dabyrie
	["{item:5830}, from {npc:4480}"] = "",

	-- Step 21: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "沿路向东。在{area:321}以西不远的路旁，能看到发光的紫色碎片。",

	-- Step 22: Hammerfall
	-- {npc:2851} Urda · {npc:15126} Rutherford Twing · {quest:8263} Defiler's Basic Care Package · {zone:1461} Arathi Basin
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "道路东端的兽人要塞。双足飞龙管理员 {npc:2851} 站在大门旁。\n只有你在 污染者（{zone:1461}）的声望达到友善，{npc:15126} 才会提供 {quest:8263}：若他没有提供，就跳过。",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "{npc:2792}，在大门旁",
	-- {npc:12920} Doctor Gregory Victor · {skill:129} First Aid
	["{npc:12920}, at the south gate. If {npc:12920} offers nothing, another player may be running his {skill:129} quest Triage: he can be busy for a few minutes. Wait, then talk to him again."] = "{npc:12920}在南门。如果{npc:12920}没有提供任何东西，可能是其他玩家正在做他的{skill:129}任务“紧急救护”：他会忙上几分钟。稍等后再和他对话。",

	-- Step 23: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "激流堡组队任务",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "{npc:2703}的{quest:639}由高地西部激流堡废墟中的精英辛迪加（35-38级）掉落。有队伍就很值得做，经验丰厚：这条路线前往内禁锢法阵时会经过激流堡。",

	-- Step 24: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "落锤镇东北面的枯须狗头人在峡谷采矿；洞口的狗头人以及深处的掘地工和勘探员都掉落密斯莱尔的碎片。\n小心：所有类型的狗头人都会在低血量时逃跑求援（狗头人为30%，勘探员和掘地工为15%），可能引来更多敌人。",

	-- Step 25: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701}在峡谷最深处。",

	-- Step 26: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "每个{object:180105}都是一圈竖石；钥匙就在中央的石头上。东部法阵位于{area:321}西北面的山丘上。\n小心：每块中央石头都由约3只接近39级的元素守卫，若不先清怪就点击石头，它们会一起攻击：西部是烈焰流放者，外部是雷霆流放者，东部是水浪流放者。",

	-- Step 27: Witherbark Village
	["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "落锤镇南边，枯木巨魔占据山中的村庄。枯木掷斧者守在外围小屋，枯木巫医和枯木猎头者守在村庄深处。小心：这三种巨魔都会在生命值降到15%时逃跑求援，可能引来附近营地的更多巨魔。",

	-- Step 28: Highland raptors and Plains Creepers
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["Highland raptors and Plains Creepers"] = "高地迅猛龙和平原狼蛛",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider · Plains Creepers = {npc:2563} Plains Creeper
	["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "向北返回的路上，高地阔步龙在 {area:321} 周围的山间游荡，会掉落眼球；南侧的平原狼蛛（32-33 级）在草地间结网，会掉落蛛丝。",
	-- {item:278225} Surgical Spidersilk
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["{item:278225}, from Plains Creepers"] = "{item:278225}，由平原狼蛛掉落",

	-- Step 29: Hammerfall
	-- {area:321} Hammerfall
	["Back north to {area:321}: the doctor stands at the south gate."] = "向北返回{area:321}：医生站在南门。",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate. If he won't take the silk, another player may be running Triage: wait a few minutes and talk to him again."] = "{npc:12920}在南门。如果他不收丝绸，可能是其他玩家正在做“紧急救护”：等几分钟再和他对话。",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "{npc:12920}，在南门",

	-- Step 30: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "石拳蛮兵在{area:321}西南方远处的食人魔大厅外扎营，石拳法师站在它们中间。一次引一个。",

	-- Step 31: Fleshstalker raptors
	["Fleshstalker raptors"] = "猎兽龙",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "高地猎兽龙（36-37级）在南部高地狩猎，一群在{area:316}北边，另一群在其西边的平原上。一次拉一只。",

	-- Step 32: Go'shek Farm
	["Go'shek Farm"] = "格沙克农场",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "{npc:2733}的实验室小屋在格沙克农场，位于迅猛龙平原东北边，返回{area:321}时会经过；装有{item:278462}的箱子就在屋里。",

	-- Step 33: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "回到{area:321}",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "向东北返回{area:321}。",

	-- Step 34: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "石拳组队任务",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "{npc:2771}下一步的{quest:678}和{npc:2772}的{quest:680}，目标都是激流堡食人魔区域内的精英食人魔（38-40级），可与符印任务在同一次组队行程中完成。",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "{npc:2772}，在他旁边",

	-- Step 35: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "向西走；外禁锢法阵位于高地中央。",

	-- Step 36: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "西禁锢法阵在{area:1057}附近，位于外禁锢法阵的西北面。",

	-- Step 37: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "内部法阵在西部法阵南边、激流堡东边。",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "石头的下一步任务需要击败弗兹鲁克，一只在{area:321}以西游荡的42级精英：先别做。",

	-- Step 38: Stromgarde
	["Stromgarde"] = "激流堡",
	-- {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "内禁锢法阵西面是激流堡废墟：辛迪加占据东半边（符印由他们的辛迪咒术师、辛迪加潜伏者和辛迪加占星师掉落）；石拳食人魔占据{area:325}旁的西半边（{npc:2773}在塔旁一间没有屋顶的房子里）。",

	-- Step 39: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "向南前往南部海岸的地精海湾。{npc:2766}在海湾上方的悬崖放哨。",

	-- Step 40: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "护送教授上山，前往海湾上方的洞穴，并在他工作时保护他。两只40级水元素会在那里伏击，而且免疫冰霜。将它们挡在洞口，远离教授：如果在洞内战斗，他就会参战而停止工作，水元素也会不断出现。",

	-- Step 42: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}：沿途击杀以下目标",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["Careful: west of the cove the Daggerspine Raiders and Sorceresses (38-40) stand close together on the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks.\nCareful: the charts and logs lie deep inside the wrecks: watch your breath bar and come up between them; a water breathing potion makes it easy."] = "",
	["Underwater"] = "在水下",

	-- Step 43: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "交给{area:35}的{npc:2487}，约41级时完成",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "下一个指南会穿过{area:880}进入{zone:1437}，再前往{zone:1418}。",

	-- Step 44: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "仅在组队做过激流堡任务时：返回{area:321}交任务，然后前往{area:880}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Head back east to {area:272}."] = "向东返回{area:272}。",
	-- ["Head east out of {area:272} through {area:1057}. The Syndicate hold the walled manor and its farm north of the road; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "从{area:272}向东穿过{area:1057}。辛迪加占据道路北面的围墙庄园及农场；辛迪加路霸、辛迪加雇佣兵和辛迪加巡路者携带血石护符。\n小心：辛迪加路霸（30-31级）可能处于潜行状态，靠近时未必能看到。",
	-- ["Head north past Valik's camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "向北经过瓦里克的营地，前往被辛迪加占据的村庄{area:280}（35-37级）。{npc:2431}携带{item:3704}；{quest:503}被关在北侧房屋的笼子里。\n小心：潜行的辛迪加密探在{area:280}游荡，房屋里也有许多辛迪加怪物，包括法师。",
	-- ["Head north-west through the mountains to the Perenolde manor on the northern shore of {area:1339}. {quest:507} (41) waits in a room upstairs: he shields himself, puts you to sleep and heals below half health. {npc:2317} stands beside him."] = "向西北穿过群山，前往{area:1339}北岸的匹瑞诺德庄园。{quest:507}（41级）在楼上一个房间里：他会给自己套盾、使你沉睡，并在生命值低于一半时治疗自己。{npc:2317}站在他旁边。",
	-- ["Perenolde manor"] = "匹瑞诺德庄园",
	-- ["South along the lake shore to the ruins around the {area:279} crater. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "沿湖岸向南，前往{area:279}巨坑周围的废墟。达拉然召唤师带着元素奴仆；护腕由奴仆掉落。小心：奥术哨兵（55级，精英）和肯瑞托卫兵（55级）守卫着穹顶本身，并会攻击部落：在废墟外缘活动，不要靠近穹顶。",
	-- ["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "石拳蛮兵在{area:321}南边食人魔大厅外扎营；石拳法师站在它们中间。一次拉一个。",
	-- ["The {object:1763} poster by the inn"] = "旅店旁的{object:1763}告示",
	-- ["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "海湾西边，刺脊袭击者和刺脊巫师（38-40级）占据海岸：一次拉一个。两艘沉船在近海浅水中，海图和日志在船里；宝石在沉船周围的海底。",
	-- ["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi; {npc:2783} is among them), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "内禁锢法阵西面是激流堡废墟：辛迪加占据东半边（符印由他们的辛迪咒术师、辛迪加潜伏者和辛迪加占星师掉落，{npc:2783}也在其中）；石拳食人魔占据{area:325}旁的西半边（{npc:2773}在塔旁一间没有屋顶的房子里）。",
	-- ["{npc:2229} waits inside the inn at {area:272}, back south down the road."] = "沿路向南返回{area:272}，{npc:2229}在旅店内。",
	-- ["{npc:2229}, inside the inn"] = "{npc:2229}，在旅店内",
	-- ["{npc:2306} (40) carries the head. He turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village, which lie on your way to the Perenolde manor. If you already met him while freeing {quest:503}, this step is done."] = "{npc:2306}（40级）身上有需要的头颅。他一次只出现在一处：{area:280}旅店的地窖，或村子北边及西北边高地上的某个辛迪加帐篷营地，前往匹瑞诺德庄园时会经过。如果解救{quest:503}时已经遇到过他，这一步就已完成。",
	-- ["{npc:2706}'s next {quest:671} is {npc:2783}, a level 40 elite warlock in Stromgarde's Syndicate quarter."] = "{npc:2706}下一步的{quest:671}目标是{npc:2783}，她是激流堡辛迪加区域内的一名40级精英术士。",
	-- ["{npc:2733}'s lab shack stands at Go'shek Farm, south-west of the raptors' plain; the case of {item:278462} is inside."] = "{npc:2733}的实验棚屋在迅猛龙平原西南的Go'shek Farm；{item:278462}的箱子就在里面。",
	-- ["{quest:671} with a group"] = "组队做{quest:671}",
}
