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

	-- Step 3: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "飞往{area:272}",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "{zone:1458}飞行管理员",

	-- Step 4: Tarren Mill
	-- {npc:2229} Krusk
	["{npc:2229}, inside the inn"] = "{npc:2229}，在旅店内",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "旅店旁的{object:1763}告示",

	-- Step 6: Gol'dir
	-- {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north past Valik's camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "向北经过Valik的营地，前往被辛迪加占据的村庄{area:280}（35-37级）。{npc:2431}携带{item:3704}；{quest:503}被关在北侧房屋的笼子里。\n小心：潜行的辛迪加密探在{area:280}游荡，房屋里也有许多辛迪加怪物，包括法师。",
	["Inside"] = "在里面",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "{quest:503}，位于顶层",

	-- Step 8: Tarren Mill
	-- {npc:2229} Krusk · {area:272} Tarren Mill
	["{npc:2229} waits inside the inn at {area:272}, back south down the road."] = "沿路向南返回{area:272}，{npc:2229}在旅店内。",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}：在屋内",

	-- Step 9: Baron Vardus
	-- {npc:2306} Baron Vardus · {area:280} Strahnbrad · {quest:503} Gol'dir
	["{npc:2306} (40) carries the head. He turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village, which lie on your way to the Perenolde manor. If you already met him while freeing {quest:503}, this step is done."] = "",

	-- Step 10: Alterac Mountains
	["Perenolde manor"] = "匹瑞诺德庄园",

	-- Step 11: Lord Aliden Perenolde
	-- {area:1339} Lordamere Lake · {quest:507} Lord Aliden Perenolde · {npc:2317} Elysa
	["Head north-west through the mountains to the Perenolde manor on the northern shore of {area:1339}. {quest:507} (41) waits in a room upstairs: he shields himself, puts you to sleep and heals below half health. {npc:2317} stands beside him."] = "向西北穿过群山，前往{area:1339}北岸的匹瑞诺德庄园。{quest:507}（41级）在楼上一个房间里：他会给自己套盾、使你沉睡，并在生命值低于一半时治疗自己。{npc:2317}站在他旁边。",

	-- Step 12: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "{area:17707}：沿途遇到就击杀",
	-- {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave
	["South along the lake shore to the ruins around the {area:279} crater. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves."] = "沿湖岸向南，前往{area:279}巨坑周围的废墟。达拉然召唤师带着元素奴仆；护腕由奴仆掉落。",

	-- Step 14: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back east to {area:272}."] = "向东返回{area:272}。",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "{npc:2437}：在屋内",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "{npc:2410}：在屋内",
	["The magus offers a dungeon errand next: leave it."] = "那位魔导师接下来提供的是一个地下城差事：别接。",

	-- Step 15: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "",

	-- Step 16: Northfold Manor
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["Head east out of {area:272} through {area:1057}. The Syndicate hold the walled manor and its farm north of the road; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "从{area:272}向东穿过{area:1057}。辛迪加占据道路北面的围墙庄园及农场；辛迪加路霸、辛迪加雇佣兵和Pathstalkers携带血石护符。\n小心：辛迪加路霸（30-31级）可能处于Sneak潜行状态，靠近时未必能看到。",

	-- Step 17: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "沿路向东。在{area:321}以西不远的路旁，能看到发光的紫色碎片。",

	-- Step 18: Hammerfall
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "{npc:12920}，在南门",

	-- Step 19: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "激流堡组队任务",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "{npc:2703}的{quest:639}由高地西部激流堡废墟中的精英辛迪加（35-38级）掉落。有队伍就很值得做，经验丰厚：这条路线前往内禁锢法阵时会经过激流堡。",

	-- Step 20: Foul Magics with a group
	-- {quest:671} Foul Magics
	["{quest:671} with a group"] = "组队做{quest:671}",
	-- {npc:2706} Tor'gan · {quest:671} Foul Magics · {npc:2783} Marez Cowl
	["{npc:2706}'s next {quest:671} is {npc:2783}, a level 40 elite warlock in Stromgarde's Syndicate quarter."] = "{npc:2706}下一步的{quest:671}目标是{npc:2783}，她是激流堡辛迪加区域内的一名40级精英术士。",

	-- Step 21: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "落锤镇东北面的枯须狗头人在峡谷采矿；洞口的狗头人以及深处的掘地工和勘探员都掉落密斯莱尔的碎片。\n小心：所有类型的狗头人都会在低血量时逃跑求援（狗头人为30%，勘探员和掘地工为15%），可能引来更多敌人。",

	-- Step 22: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701}在峡谷最深处。",
	["Below ground"] = "在地下",

	-- Step 23: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "每个{object:180105}都是一圈竖石；钥匙就在中央的石头上。东部法阵位于{area:321}西北面的山丘上。\n小心：每块中央石头都由约3只接近39级的元素守卫，若不先清怪就点击石头，它们会一起攻击：西部是烈焰流放者，外部是雷霆流放者，东部是水浪流放者。",

	-- Step 24: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "",

	-- Step 25: Fleshstalker raptors
	["Fleshstalker raptors"] = "猎兽龙",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "高地猎兽龙（36-37级）在南部高地狩猎，一群在{area:316}北边，另一群在其西边的平原上。一次拉一只。",

	-- Step 26: Go'shek Farm
	["Go'shek Farm"] = "Go'shek Farm",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "",

	-- Step 27: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "回到{area:321}",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "向东北返回{area:321}。",

	-- Step 28: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "石拳组队任务",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "{npc:2771}下一步的{quest:678}和{npc:2772}的{quest:680}，目标都是激流堡食人魔区域内的精英食人魔（38-40级），可与符印任务在同一次组队行程中完成。",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "{npc:2772}，在他旁边",

	-- Step 29: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "向西走；外禁锢法阵位于高地中央。",

	-- Step 30: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "西禁锢法阵在{area:1057}附近，位于外禁锢法阵的西北面。",

	-- Step 31: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "内部法阵在西部法阵南边、激流堡东边。",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "石头的下一步任务需要击败Fozruk，一只在{area:321}以西游荡的42级精英：先别做。",

	-- Step 32: Stromgarde
	["Stromgarde"] = "激流堡",
	-- {npc:2783} Marez Cowl · {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi; {npc:2783} is among them), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "内禁锢法阵西面是激流堡废墟：辛迪加占据东半边（符印由他们的Conjurors、Prowlers和Magi掉落，{npc:2783}也在其中）；石拳食人魔占据{area:325}旁的西半边（{npc:2773}在塔旁一间没有屋顶的房子里）。",

	-- Step 33: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "向南前往南部海岸的地精海湾。{npc:2766}在海湾上方的悬崖放哨。",

	-- Step 34: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "护送教授上山，前往海湾上方的洞穴，并在他工作时保护他。两只40级水元素会在那里伏击，而且免疫冰霜。将它们挡在洞口，远离教授：如果在洞内战斗，他就会参战而停止工作，水元素也会不断出现。",

	-- Step 36: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}：沿途击杀以下目标",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "海湾西边，刺脊袭击者和刺脊巫师（38-40级）占据海岸：一次拉一个。两艘沉船在近海浅水中，海图和日志在船里；宝石在沉船周围的海底。",
	["Underwater"] = "在水下",

	-- Step 37: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "交给{area:35}的{npc:2487}，约41级时完成",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "下一个指南会穿过{area:880}进入{zone:1437}，再前往{zone:1418}。",

	-- Step 38: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "仅在组队做过激流堡任务时：返回{area:321}交任务，然后前往{area:880}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "石拳蛮兵在{area:321}南边食人魔大厅外扎营；石拳法师站在它们中间。一次拉一个。",
	-- ["{npc:2733}'s lab shack stands at Go'shek Farm, south-west of the raptors' plain; the case of {item:278462} is inside."] = "{npc:2733}的实验棚屋在迅猛龙平原西南的Go'shek Farm；{item:278462}的箱子就在里面。",
}
