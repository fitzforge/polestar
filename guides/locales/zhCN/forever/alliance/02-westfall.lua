-- Chinese (simplified) (zhCN): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Goldshire
	-- {zone:1453} Stormwind · {zone:1436} Westfall · {area:87} Goldshire · {npc:241} Remy "Two Times" · {npc:240} Marshal Dughan · {quest:40} A Fishy Peril · {quest:35} Further Concerns · {quest:109} Report to Gryan Stoutmantle
	["On the road from {zone:1453} to {zone:1436}, {area:87} is the first stop: {npc:241} stands outside the inn, {npc:240} beside him. {npc:241}'s {quest:40} goes straight to Dughan, who then gives {quest:35}; his {quest:109} goes with you to {zone:1436}."] = "从{zone:1453}沿路前往{zone:1436}，第一站是{area:87}。{npc:241}站在旅店外，{npc:240}在他旁边。{npc:241}的{quest:40}直接交给治安官杜汉，随后他会给你{quest:35}；{quest:109}则带到{zone:1436}去。",
	-- {npc:240} Marshal Dughan · {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["{npc:240}: for {npc:234} at {area:108}"] = "{npc:240}：交给{area:108}的{npc:234}",

	-- Step 2: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {area:18} Crystal Lake · {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["East along the road past {area:18}: {npc:248242} and {npc:248248} stand at the foot of the tower."] = "沿路向东，经过{area:18}：{npc:248242}和{npc:248248}站在塔脚下。",

	-- Step 3: The bridge
	["The bridge"] = "桥",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	-- plural, as words: Prowlers = {npc:118} Prowler
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it. His tools and Thomas's Prowlers and bears are south of the bridge, on the way back."] = "{npc:261}守着向东路上的桥，{npc:248265}就站在桥那头。他的工具，还有托马斯提到的{npc:118}和熊，都在桥南边，回程再顺路打。",

	-- Step 4: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "营地在桥的东北方。一捆捆木柴散落在营地周围和北边的树林里。",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "{npc:278}，在里面",

	-- Step 5: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "它躺在伐木场西北方的河边。",

	-- Step 6: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "{npc:474}在{area:86}岸边扎营；它们也掉落{item:1019}。{object:56}在东北岸的鱼人村里。",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "{item:1019}",

	-- Step 7: The gnoll camps
	["The gnoll camps"] = "豺狼人营地",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "河爪豺狼人在{area:86}西边的山丘上扎营，{quest:91725}就在他们的营地里。",

	-- Step 8: The Jasperlode Mine's entrance
	-- {area:54} Jasperlode Mine
	["The {area:54}'s entrance"] = "{area:54}的入口",

	-- Step 9: Jasperlode Mine: kill these as you meet them
	-- {area:54} Jasperlode Mine
	["{area:54}: kill these as you meet them"] = "{area:54}：沿途击杀以下目标",
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "矿洞在豺狼人营地西南方。{item:247816}在入口附近；{npc:476}占据着隧道。",
	-- {npc:476} Kobold Geomancer · {area:54} Jasperlode Mine
	["{npc:476} walks around {area:54}: look inside the circle on the map"] = "{npc:476}在{area:54}附近走动：在地图上的圆圈里找",

	-- Step 10: The Tower of Azora
	["Follow the hills south to the tower."] = "沿山丘向南走到塔。",

	-- Step 11: Downstream
	-- {item:247813} Waterlogged Saw
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["East along the road, then into the river south of the bridge: the {item:247813}, Axe and Toolbox lie in it. Prowlers and Young Forest Bears roam its banks."] = "沿路向东，然后下到桥南边的河里：{item:247813}、斧头和工具箱都在河里。{npc:118}和{npc:822}在两岸游荡。",

	-- Step 14: Goldshire
	-- {area:87} Goldshire · {zone:1436} Westfall · {npc:240} Marshal Dughan
	["Follow the road west to {area:87}, on the way to {zone:1436}: {npc:240} stands outside the inn."] = "沿路向西返回{area:87}，顺路继续去{zone:1436}；{npc:240}站在旅店外。",

	-- Step 15: The Jansen Stead
	-- {zone:1436} Westfall · {object:2724} Sack of Oats
	["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Pick up oats from any {object:2724} you pass on the loop: the rest are gathered in the fields here on the way back."] = "沿着大路从艾尔文森林进入{zone:1436}：法布隆一家就在路边第一座被烧毁的农场旁。这一圈路上碰到的{object:2724}都捡上，剩下的回程时在这边的田里收集。",
	-- {npc:237} Farmer Furlbrow · {npc:963} Deputy Rainer
	["{npc:237}; Humans took it from {npc:963} in Elwynn"] = "{npc:237}；人类角色已在艾尔文森林从{npc:963}处接取此任务",

	-- Step 17: The Jansen Stead
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "仅当你在艾尔文森林拾取了{item:1972}：右键点击它",

	-- Step 18: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["South along the road, past the fork. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west. Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way."] = "沿路向南，过了岔路口。{npc:233}站在屋外，{npc:235}在屋里，{npc:253395}在西边的谷仓里。幼年血牙野猪和碎尸鸟在农场周围的田野游荡：顺路收集肝脏和炖肉用的肉。",
	-- {npc:235} Salma Saldean
	["{npc:235}, inside"] = "{npc:235}，在屋里",

	-- Step 19: Goretusk Snouts
	-- plural, as words: Goretusk Snouts = {item:731} Goretusk Snout
	["Goretusk Snouts"] = "{item:731}",
	-- {area:108} Sentinel Hill
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks root in the fields along the road south from Saldean's to {area:108}: take their snouts on the way."] = "{npc:454}在从萨丁农场向南通往{area:108}的道路沿线田野里拱土：顺路收集它们的鼻子。",

	-- Step 20: Sentinel Hill's tower and Thor
	-- {area:108} Sentinel Hill · {npc:523} Thor
	["{area:108}'s tower and {npc:523}"] = "{area:108}的塔和{npc:523}",
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:523} Thor · {npc:878} Scout Galiaan · {npc:1323} Osric Strang · {zone:1453} Stormwind · {npc:279} Morgan Pestle · {object:2096} Trade District · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town · {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {npc:352} Dungar Longdrink
	["{npc:234} and {npc:821} stand at the top of the stone tower, {npc:491} inside it, {npc:523} the gryphon master on the south side of the hill with {npc:878} beside him. {npc:523} gives you Lewis' note for {npc:1323} with a free flight to {zone:1453}: take it now. In {zone:1453}, {npc:279}'s shop is in the {object:2096} by the gryphons, {npc:1323}'s shop, {object:2156}, in {object:2100}; {npc:1646} stands in {object:2098} on the way back to {npc:352}, the gryphon master."] = "{npc:234}和{npc:821}站在石塔顶上，{npc:491}在塔里，狮鹫管理员{npc:523}在山丘南侧，{npc:878}在他旁边。{npc:523}会给你一封刘易斯写给{npc:1323}的信，还附一次去{zone:1453}的免费飞行：现在就坐。到了{zone:1453}，{npc:279}的店在{object:2096}、狮鹫旁边；{npc:1323}的店，有限无敌，在{object:2100}；回程去找狮鹫管理员{npc:352}的路上，{npc:1646}站在{object:2098}。",
	-- {npc:491} Quartermaster Lewis
	["{npc:491}, inside"] = "{npc:491}，在塔内",
	-- {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:878}, beside {npc:523}"] = "{npc:878}，在{npc:523}旁边",
	-- {npc:523} Thor · {zone:1453} Stormwind
	["{npc:523}: the free flight he offers goes to {zone:1453}"] = "{npc:523}：他提供的免费飞行前往{zone:1453}",

	-- Step 21: Osric Strang
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, {object:2096}, by the gryphons"] = "{npc:279}，{object:2096}，在狮鹫旁",
	-- {npc:1323} Osric Strang · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town
	["{npc:1323}, {object:2156} in {object:2100}"] = "{npc:1323}，有限无敌，在{object:2100}",
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {zone:1436} Westfall
	["{npc:1646}, {object:2098}: his compass is in his old house in {zone:1436}"] = "{npc:1646}，{object:2098}：他的罗盘在他{zone:1436}的老房子里",
	-- {npc:352} Dungar Longdrink
	["{npc:352}, the gryphon master"] = "{npc:352}，狮鹫管理员",

	-- Step 22: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234}和{npc:821}站在石塔顶上。{npc:491}在塔内，{npc:878}在山丘南侧，旅店和狮鹫管理员{npc:523}旁边。",
	-- {npc:234} Gryan Stoutmantle · {npc:963} Deputy Rainer
	["{npc:234}: from {npc:963} at Westbrook"] = "{npc:234}：从西泉要塞的{npc:963}处接取",
	-- {npc:491} Quartermaster Lewis · {zone:1453} Stormwind
	["{npc:491}, inside: back from {zone:1453}"] = "{npc:491}，在里面：从{zone:1453}回来后找他",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}，在{npc:878}旁边",

	-- Step 24: Goretusk Livers as you go
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Goretusk Livers as you go"] = "顺路收集{item:723}",
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Goretusks and Young Goretusks root along every leg of this loop: kill the ones you pass for the pie's livers."] = "{npc:454}在这条路线的每一段游荡：顺路杀掉遇到的，收集馅饼用的肝脏。",

	-- Step 25: Stringy Vulture Meat as you go
	-- {item:729} Stringy Vulture Meat
	["{item:729} as you go"] = "顺路收集{item:729}",
	["Fleshrippers circle the fields along this loop: kill the ones you pass for the stew's meat."] = "碎尸鸟在这条路线的田野上空盘旋：顺路杀掉遇到的，收集炖肉用的肉。",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}：碎尸鸟",

	-- Step 26: Red Leather Bandanas as you go
	-- {quest:153} Red Leather Bandanas
	["{quest:153} as you go"] = "顺路收集{quest:153}",
	-- {item:829} Red Leather Bandana · {object:290} Furlbrow's Wardrobe
	["Every Defias on this loop can drop a {item:829}: the Trappers and Smugglers, and the guards at {object:290}."] = "这条路线上的每个迪菲亚都可能掉落{item:829}：捕兽者和走私者，还有{object:290}处的守卫。",

	-- Step 27: Defias Trappers and Smugglers
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Defias Trappers and Smugglers"] = "{npc:504}和迪菲亚走私者",
	-- {area:108} Sentinel Hill · {area:918} Molsen Farm
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["North-west from {area:108} toward {area:918}: Defias Trappers and Smugglers camp in the fields between them."] = "从{area:108}向西北往{area:918}方向：{npc:504}和迪菲亚走私者在两地之间的田野扎营。",

	-- Step 28: Molsen Farm's well
	-- {area:918} Molsen Farm
	["{area:918}'s well"] = "{area:918}的井",
	["Fill the vial at the farm's well"] = "在农场的井里装满药瓶",

	-- Step 29: Molsen Farm's Harvest Watchers
	-- {area:918} Molsen Farm
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["{area:918}'s Harvest Watchers"] = "{area:918}的{npc:114}",
	-- {area:918} Molsen Farm · {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers and Golems work the fields around {area:918}; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone."] = "{npc:114}和麦田傀儡在{area:918}周围的田里干活；它们掉落同位弹簧、陀螺稳定器、{item:732}，有时还有{item:255155}。{npc:573}是20级稀有怪，在此巡逻：别惹它。",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "{npc:114}",

	-- Step 30: The gnoll hills
	["The gnoll hills"] = "豺狼人山丘",
	-- {area:111} Jangolode Mine · {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["North to the hills above {area:111}: Riverpaw Gnolls and Scouts (level 11-13) roam there, east toward the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer."] = "向北到{area:111}上方的山丘：{npc:117}和河爪斥候（11-13级）在那里游荡，向东一直到{area:916}。更南边和西边的豺狼人是13-19级：待在北边的山丘。\n小心：站得很近的豺狼人往往会成群加入战斗。一次拉一只更安全。",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "{item:725}",

	-- Step 31: The Longshore murlocs
	-- {area:2} Longshore
	["The {area:2} murlocs"] = "{area:2}的鱼人",
	-- {area:916} The Jansen Stead
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the north coast from above the mine east toward the {area:916}: work along the beach eastward. They flee at low health: pull one at a time."] = "{npc:126}和鱼人袭击者沿北部海岸排列，从矿洞上方一直向东到{area:916}：沿海滩向东推进。它们血量低时会逃跑：一次只拉一只。",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "{item:254548}",

	-- Step 32: Furlbrow's Wardrobe
	-- {object:290} Furlbrow's Wardrobe · {area:916} The Jansen Stead · {npc:502} Benny Blaanco
	["{object:290} stands in the ruined house east of the mine, on the way to the {area:916}.\nCareful: Two Defias stand guard inside, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "{object:290}在矿洞东边的废墟房屋里，位于前往{area:916}的路上。\n小心：屋内有两个迪菲亚守卫，其中一个是15级的{npc:502}。它们是关联的，攻击任何一个都会引来两个。",
	-- {object:290} Furlbrow's Wardrobe
	["{object:290}; inside"] = "怀表就在屋里的{object:290}里",

	-- Step 33: The Jansen Stead
	["Sacks of Oats in the fields around the farm"] = "在农场周围收集一袋燕麦",
	["Fill the vial at the well"] = "在井里装满药瓶",

	-- Step 34: Finish the Goretusk Livers
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Finish the Goretusk Livers"] = "凑齐{item:723}",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Still short of eight? Young Goretusks root in the fields just west of {area:107}."] = "还差八个？{npc:454}就在{area:107}西边的田野里拱土。",

	-- Step 35: Finish the Stringy Vulture Meat
	-- {item:729} Stringy Vulture Meat
	["Finish the {item:729}"] = "凑齐{item:729}",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Fleshrippers = {npc:199} Young Fleshripper
	["Still short of three? Young Fleshrippers circle the fields north-west of {area:107}."] = "还差三个？{npc:199}在{area:107}西北边的田野上空盘旋。",

	-- Step 37: Finish the Red Leather Bandanas
	-- {quest:153} Red Leather Bandanas
	["Finish the {quest:153}"] = "凑齐{quest:153}",
	-- {area:108} Sentinel Hill
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Still short of fifteen? Defias Trappers camp in the fields just west of {area:108}."] = "还差十五个？{npc:504}就在{area:108}西边的田野里扎营。",

	-- Step 38: Sentinel Hill
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "交给赤脊山{area:69}的{npc:266}",

	-- Step 39: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "向北经过{area:918}回到矿洞：狗头人掘地工在矿洞内干活。",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "{npc:1236}",

	-- Step 40: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "向西南前往海岸，在{area:918}以西。河爪矿工在采石场干活。",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "{npc:1426}",

	-- Step 41: Moonbrook: kill these as you meet them
	-- {area:20} Moonbrook
	["{area:20}: kill these as you meet them"] = "{area:20}：击杀以下目标，以完成任务",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {object:1166} Alexston's Chest · {area:219} Alexston Farmstead · {npc:1646} Baros Alexston · {area:113} Gold Coast Quarry
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}. {object:1166} stands in the farmhouse at the {area:219}, among them: {npc:1646}' compass is inside.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "迪菲亚抢劫者和迪菲亚匪徒占据了{area:108}西边、海岸道路与{area:20}之间的农场。{object:1166}就在其中{area:219}的农舍里，里面放着{npc:1646}的罗盘。\n小心：{area:113}的洞穴里迪菲亚聚集，很容易一次引到多只。",
	-- {item:2998} A Simple Compass · {object:1166} Alexston's Chest
	["{item:2998}, from {object:1166}"] = "{item:2998}，来自{object:1166}",

	-- Step 44: Defensive Stance
	-- {zone:1436} Westfall · {zone:1453} Stormwind · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["From {zone:1436}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "从{zone:1436}步行前往{zone:1453}；从{zone:1455}出发的地铁到达{object:28027}。{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。如果{npc:5480}没有提供{quest:1638}，直接去找{npc:6089}：不需要那个任务他也会给你{quest:1639}。",

	-- Step 46: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "走去{zone:1453}。{npc:376}在光明大教堂。",

	-- Step 48: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth
	["{npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in the {object:2096} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "{npc:6171}和{npc:6173}在光明大教堂；{npc:6174}在{object:2096}，需要十块{item:2589}（人形怪掉落；拍卖行也有卖）。",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775} he gives you"] = "在包里右键点击他给你的{item:6775}",
	-- {npc:6172} Henze Faulk · {area:86} Stone Cairn Lake
	["{npc:6172}, by {area:86} in Elwynn, on the road to Redridge"] = "{npc:6172}，在艾尔文森林的{area:86}旁，通往赤脊山的路上",

	-- Step 49: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "{zone:1453}的{object:28027}",

	-- Step 50: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "乘地铁去{zone:1455}",

	-- Step 51: Shaman training
	["Shaman training"] = "萨满祭司训练",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Head to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "前往{zone:1453}。那里没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，在{npc:258098}处学习技能，然后乘地铁返回坐船。",

	-- Step 52: Stormwind
	-- {area:1519} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {object:28027} Dwarven District
	["Walk to {area:1519}, or fly if you know its flight path. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:28027} (Hunters), the Park (Druids)."] = "走去{area:1519}，开了飞行点的话也可以飞过去。训练师：{object:2100}（战士、潜行者），大教堂（圣骑士、牧师），{object:2101}（法师、术士），{object:28027}（猎人），公园（德鲁伊）。",
	["In through the main gate (already done if you are in the city)"] = "从正门进城（已经在城里的话，这一步就算完成了）",
	["Level 12, 14 and 16 spells"] = "12、14和16级法术",

	-- Step 53: Back to Stormwind
	-- {zone:1453} Stormwind
	["Back to {zone:1453}"] = "返回{zone:1453}",
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["Ride the tram back: it comes out in {zone:1453}'s {object:28027}, where the errands below start."] = "乘地铁返回：出口在{zone:1453}的{object:28027}，接下来的任务从那里开始。",

	-- Step 54: Stormwind
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "为{zone:1439}的任务“收集解药”（6123）准备{item:2449}：在{npc:1313}的炼金用品店购买；草药师可在那里采集",
	-- {npc:7232} Borgus Steelhand · {object:28027} Dwarven District · {area:442} Auberdine
	["{npc:7232}, {object:28027}: for his brother in {area:442}"] = "{npc:7232}，{object:28027}：为了他在{area:442}的兄弟",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}，法师圣殿：{quest:1861}",

	-- Step 56: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "顺便：找{npc:11867}学习{spell:202}（{object:2096}，10银币）；双手武器能让战士升级最快。",

	-- Step 57: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "顺便：在{npc:11867}处学习{spell:202}（{object:2096}，10银币）；圣骑士用双手武器升级最快。",

	-- Step 58: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "顺路找{npc:11867}学法杖（{object:2096}，10银）。猎人的近战武器主要看属性，双手武器属性最高。",

	-- Step 59: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "顺路找{npc:11867}学剑类武器（{object:2096}，10银），主手拿剑，潜行者升级更稳。",

	-- Step 60: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "顺路找{npc:11867}学法杖（{object:2096}，10银），升级时法杖带的法术属性比单手武器高。",

	-- Step 62: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494}在{object:2096}西边的运河旁出售钓鱼用品；{npc:267118}在港口钓鱼，就在去坐船的路上。",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}，来自{npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back north past Molsen Farm to the mine: Kobold Diggers work inside."] = "向北经过摩尔森农场回到矿洞：{npc:1236}在里面干活。",
	-- ["Back to {area:108}"] = "返回{area:108}",
	-- ["Back to {area:1519}"] = "返回{area:1519}",
	-- ["Back to {object:81}"] = "返回哨兵岭",
	-- ["Defensive Stance"] = "防御姿态",
	-- ["Defias Pathstalkers and Knuckledusters walk Moonbrook; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. The Deadmines entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "{npc:121}和迪菲亚拳匪在月溪镇巡逻；迪菲亚路霸（17级）成对巡逻其南边和东边的山丘：把它们分开拉。铁匠铺里的死亡矿井入口是小队地下城。\n小心：山丘上的营地有混编的迪菲亚，如果你等级低，很容易一次拉到不止一个。",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "迪菲亚巡路者和迪菲亚拳匪在{area:20}巡逻；迪菲亚路霸（17级）成对巡逻其南边和东边的山丘：把它们分开拉。铁匠铺里的{area:1581}入口是团队地下城。",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "{npc:121}和迪菲亚拳匪在{area:20}巡逻；迪菲亚路霸（17级）成对巡逻其南边和东边的山丘：把它们分开拉。铁匠铺里的{area:1581}入口是小队地下城。\n小心：山丘上的营地有混编的迪菲亚，如果你等级低，很容易一次拉到不止一个。",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "迪菲亚抢劫者和迪菲亚强夺者占据了{area:108}以西、海岸道路与{area:20}之间的农场。",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "{npc:589}和迪菲亚强夺者占据了{area:108}以西、海岸道路与{area:20}之间的农场。\n小心：{area:113}洞穴里有许多迪菲亚挤在一起，很容易一次拉到好几个。",
	-- ["Defias Pillagers and Looters hold the farms west of {object:81}, between the coast road and Moonbrook. {object:1166} stands in the farmhouse at the Alexston Farmstead, among them: {npc:1646}' compass is inside.\nCareful: The Gold Coast Quarry cave holds many Defias packed together, so it is easy to pull several at once there."] = "{npc:589}和迪菲亚强夺者占据了哨兵岭以西、海岸道路与月溪镇之间的农场。{object:1166}就在阿历克斯顿农场的农舍里，在他们中间：{npc:1646}的罗盘在箱子里。\n小心：金海岸矿洞的洞穴里有许多迪菲亚挤在一起，很容易一次拉到好几个。",
	-- ["Defias Rogue Wizards camp on the shores of Stone Cairn Lake; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "{npc:474}在石碑湖边扎营，他们也掉{item:1019}。{object:56}在东北岸的鱼人村里。",
	-- ["Defias Trappers and Smugglers camp in the fields between {object:81} and Molsen Farm.\nWest of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone.\nYoung Goretusks and Fleshrippers roam every leg of this loop: their livers and meat are for the pie and the stew."] = "{npc:504}和迪菲亚走私者在哨兵岭与摩尔森农场之间的田野扎营。\n在萨丁农场以西。{npc:114}和麦田傀儡在田里干活；它们掉落同位弹簧、陀螺稳定器、{item:732}，有时还有{item:255155}。{npc:573}是20级稀有怪，在此巡逻：别惹它。\n{npc:454}和碎尸鸟在这条路线的每一段游荡：它们的肝脏和肉用于馅饼和炖肉。",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "飞往或骑往{zone:1453}。训练师：{object:2100}（战士、潜行者），大教堂（圣骑士、牧师），{object:2101}（法师、术士），公园（德鲁伊）。",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "飞往或骑往{zone:1453}。训练师：{object:2100}（战士、潜行者），大教堂（圣骑士、牧师），{object:2101}（法师、术士），公园（德鲁伊）。{npc:11026}在{object:28027}，{npc:279}在{object:2096}。",
	-- ["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "飞往或骑往{zone:1453}。{npc:376}在光明大教堂。",
	-- ["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "飞往或骑往{zone:1453}。{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。",
	-- ["Fly or walk to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "飞往或步行前往{zone:1453}。训练师：{object:2100}（战士、潜行者），大教堂（圣骑士、牧师），{object:2101}（法师、术士），公园（德鲁伊）。",
	-- ["Fly or walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "飞往或步行前往{zone:1453}。{npc:376}在光明大教堂。",
	-- ["Fly or walk to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "飞往或步行前往{zone:1453}。{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Collect the oats from the Sacks of Oats in the fields as you go."] = "沿道路从艾尔文森林进入{zone:1436}：法布隆夫妇坐在被烧毁的农场旁，就是道路边第一座农场。沿途从田里的燕麦袋中收集燕麦。",
	-- ["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "沿道路向北。{npc:233}站在屋外，{npc:235}在屋里，{npc:253395}在西边的谷仓里。",
	-- ["Follow the road west to Goldshire, on the way to {zone:1436}: {npc:240} stands outside the inn."] = "沿路向西回闪金镇，去{zone:1436}的路上正好经过：{npc:240}站在旅店外。",
	-- ["For {npc:11026} in {zone:1453}'s {object:28027}"] = "交给{zone:1453}{object:28027}的{npc:11026}",
	-- ["From {area:40}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "从{area:40}步行前往{zone:1453}；从{zone:1455}来的地铁抵达{object:28027}。{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。如果{npc:5480}没有提供{quest:1638}，直接去找{npc:6089}：没有该任务他也会给你{quest:1639}。",
	-- ["Furlbrow's Pumpkin Farm: kill these as you meet them"] = "法布隆农场：下面这些，遇到了就顺手杀",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "沿道路继续向北。法布隆夫妇坐在被烧毁的农场旁。沿途从田里的一袋燕麦收集燕麦，并在农场的井里装满药瓶。",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "沿道路继续向北。法布隆夫妇坐在被烧毁的农场旁。沿途从田里的一袋燕麦收集燕麦。",
	-- ["Goldshire"] = "闪金镇",
	-- ["Hearthstone on cooldown? Follow the road north-east."] = "炉石在冷却？沿道路向东北走。",
	-- ["Jasperlode Mine"] = "詹戈洛德矿洞",
	-- ["Jasperlode Mine: kill these as you meet them"] = "詹戈洛德矿洞：下面这些，遇到了就顺手杀",
	-- ["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "矿洞北边的海滩上排列着{npc:126}和鱼人袭击者。它们血量低时会逃跑：一次只拉一只。",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "在摩尔森农场以北。{npc:504}和迪菲亚走私者在矿洞外扎营，{npc:1236}在矿洞内干活。{object:290}在矿洞东边的废墟房屋旁。",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "在摩尔森农场以北。迪菲亚捕兽者和迪菲亚走私者在矿洞外扎营。{object:290}在矿洞东边的废墟房屋旁。",
	-- ["On the road from {zone:1453} to {zone:1436}, Goldshire is the first stop: {npc:241} stands outside the inn, {npc:240} beside him. {npc:241}'s {quest:40} goes straight to Dughan, who then gives {quest:35}; his {quest:109} goes with you to {zone:1436}."] = "从{zone:1453}去{zone:1436}的路上，闪金镇是第一站：{npc:241}站在旅店外，{npc:240}在他旁边。{npc:241}的{quest:40}直接找杜汉交，他接着给{quest:35}；杜汉的{quest:109}你顺路带去{zone:1436}。",
	-- ["Only if he takes the isosprings alone"] = "仅当他只收下同位弹簧时",
	-- ["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "骑往{zone:1453}。那里没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，在{npc:258098}处学习，然后乘地铁返回去坐船。",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills."] = "{npc:117}和河爪斥候（11-13级）在海岸南边的山丘上游荡，从{area:111}上方一直到东边的{area:916}。更南边和西边的豺狼人是13-19级：待在北边的山丘。",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {object:83} east to the Jansen Stead. The gnolls further south and west are 13-19: stay in the north hills.\nMurloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer.\nCareful: {object:290} stands in the ruined house east of the mine, on the way to the Jansen Stead. Two Defias stand guard inside, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "{npc:117}和河爪斥候（11-13级）在海岸南边的山丘上游荡，从詹戈洛德矿洞上方一直向东到詹森农场。更南边和西边的豺狼人是13-19级：待在北边的山丘。\n矿洞北边的海滩上排列着{npc:126}和鱼人袭击者。它们血量低时会逃跑：一次只拉一只。\n小心：站得很近的豺狼人往往会成群加入战斗。一次拉一只更安全。\n小心：{object:290}在矿洞东边的废墟房屋里，位于去詹森农场的路上。屋内有两个迪菲亚守卫，其中一个是15级的具名怪{npc:502}。它们是关联的，攻击任何一个都会引来两个。",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "{npc:117}和河爪斥候在海岸与{area:916}之间的山丘上游荡。",
	-- ["Sacks of Oats"] = "一袋燕麦",
	-- ["Saldean's Farm"] = "萨丁农场",
	-- ["South-west to the coast, west of Molsen Farm. Riverpaw Miners work the quarry."] = "向西南到海岸，摩尔森农场以西。{npc:1426}在采石场干活。",
	-- ["Stone Cairn Lake"] = "石碑湖",
	-- ["Stormwind City"] = "暴风城",
	-- ["The Jansen Stead"] = "詹森农场",
	-- ["The Jasperlode Mine's entrance"] = "詹戈洛德矿洞入口",
	-- ["The north coast"] = "北部海岸",
	-- ["The western farms"] = "西部农场",
	-- ["The {object:95}"] = "东谷伐木场",
	-- ["Walk to {zone:1453}, or fly if you know its flight path. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "走去{zone:1453}，知道飞行点的话也可以飞过去。训练师：{object:2100}（战士、潜行者），大教堂（圣骑士、牧师），{object:2101}（法师、术士），公园（德鲁伊）。",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "在摩尔森农场以西，靠近海岸。{npc:1426}在采石场干活。",
	-- ["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "在萨丁农场以西。{npc:114}和麦田傀儡在田里干活；它们掉落同位弹簧、陀螺稳定器、{item:732}，有时还有{item:255155}。{npc:573}是20级稀有怪，在此巡逻：别惹它。在这条路线的每一段都继续击杀血牙野猪和碎尸鸟。",
	-- ["While you're here: learn Two-Handed Swords from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "顺便：在{npc:11867}处学习双手剑（{object:2096}，10银币）；圣骑士用双手武器升级最快。",
	-- ["While you're here: learn Two-Handed Swords from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "顺便：找{npc:11867}学习双手剑（{object:2096}，10银币）；双手武器能让战士升级最快。",
	-- ["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "农场周围的田野里游荡着{npc:454}和碎尸鸟：返程时先收集肝脏和炖肉用的肉。",
	-- ["Young Goretusks root in the fields along the road south from Saldean's to {object:81}: take their snouts on the way."] = "{npc:454}在萨丁农场往南去哨兵岭的路边田里拱土：顺路把它们的鼻子收了。",
	-- ["{area:109}: kill these as you meet them"] = "{area:109}：遇到就击杀",
	-- ["{area:20} and the Defias hills"] = "{area:20}和迪菲亚山丘",
	-- ["{area:918}: kill these as you meet them"] = "{area:918}：下面这些，遇到了就顺手杀",
	-- ["{item:254676}, from the crates around {area:20}"] = "{item:254676}，来自{area:20}周围的箱子",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234}和{npc:821}站在石塔顶上。{npc:491}在塔内，{npc:878}和{npc:253092}在山丘南侧，旅店和狮鹫管理员{npc:523}旁边。",
	-- ["{npc:240}: for {npc:234} at {object:81}"] = "{npc:240}：交给哨兵岭的{npc:234}",
	-- ["{npc:476} walks around Jasperlode Mine: look inside the circle on the map"] = "{npc:476}在詹戈洛德矿洞里四处走动：看地图上圆圈里面",
	-- ["{npc:523}; skip the free flight it offers"] = "{npc:523}；不要乘坐它提供的免费飞行",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089}：防御姿态",
	-- ["{object:81}'s tower and {npc:523}"] = "哨兵岭的塔和{npc:523}",
	-- ["{quest:153}: every Defias drops them"] = "{quest:153}：每个迪菲亚都会掉落",
	-- ["{quest:153}: every Defias drops them, from {area:111} to the {area:916}"] = "{quest:153}：每个迪菲亚都会掉落，从{area:111}到{area:916}",
	-- ["{quest:153}: every Defias drops them, from {object:83} to the Jansen Stead"] = "{quest:153}：每个迪菲亚都会掉落，从詹戈洛德矿洞到詹森农场",
}
