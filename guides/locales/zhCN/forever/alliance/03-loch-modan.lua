-- Chinese (simplified) (zhCN): the guide forever/alliance/03-loch-modan (forever/alliance/03-loch-modan.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "乘船前往{area:150}",
	-- {area:442} Auberdine
	["Sell and repair in {area:442} first: the next stretch is a long one."] = "先在{area:442}卖杂物并修理装备：接下来有一段很长的路。",

	-- Step 2: Menethil Harbor
	-- {zone:1437} Wetlands
	["Off the boat, walk up the pier to the flight master by the inn. Nothing to take here yet: Menethil's quests are for your {zone:1437} visit at about 22."] = "下船后沿码头前往旅店旁的飞行管理员。这里暂时没有要接的任务：米奈希尔的任务留到约22级来{zone:1437}时再做。",

	-- Step 3: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "进入{zone:1432}",
	-- {area:836} Dun Algaz · {zone:1437} Wetlands
	["Follow the road east out of Menethil and south through the {area:836} pass. Keep to the road: the {zone:1437} crocolisks and raptors beside it are over your level."] = "沿路向东离开米奈希尔，再向南穿过{area:836}山口。沿着大路走：路旁{zone:1437}的鳄鱼和迅猛龙等级都比你高。",

	-- Step 4: Algaz Station
	-- {npc:1343} Mountaineer Stormpike · {area:925} Algaz Station
	["{npc:1343} stands at the {area:925}, at the south end of the pass."] = "{npc:1343}站在山口南端的{area:925}。",

	-- Step 5: Silver Stream Mine
	["East along the hills to the mine: the Miners' League crates sit in its tunnels among the Tunnel Rat kobolds."] = "沿山丘向东前往矿洞：矿工联盟的箱子在洞内坑道中，周围有坑道鼠狗头人。",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates; below ground"] = "{item:2640}，开箱获得；在地下",

	-- Step 6: Back to the Algaz Station
	-- {area:925} Algaz Station
	["Back to the {area:925}"] = "返回{area:925}",

	-- Step 7: Stonewrought Dam
	["Chief Engineer Hinderweir stands on top of the dam, up the ramp at its west end."] = "主工程师辛德维尔七世站在大坝顶上，从西端的坡道上去。",

	-- Step 8: The Suspicious Barrel
	-- {object:257} Suspicious Barrel
	["The {object:257}"] = "{object:257}",
	-- plural, as words: Dark Iron Sappers = {npc:1222} Dark Iron Sapper
	["Walk east along the dam, down its eastern ramp, then back west along the foot of the dam on the land side: two Dark Iron Sappers guard the barrel. Kill them, then open the barrel: it ends this quest and starts the next."] = "沿坝顶向东走，从东端坡道下去，再沿陆地一侧的坝脚向西走：有两名黑铁工兵守着桶。杀掉他们后打开桶，完成此任务并接到下一步。",

	-- Step 10: The loch
	["The loch"] = "洛克湖",
	-- {object:665289} Discarded Fishing Toolbox (no name in this language: may be words) · {area:144} Thelsamar · {item:278051} Monogrammed Silver Hair Clip
	["South along the west shore. The {object:665289} lies on the loch bed at one of several places: east of {area:144} (48.1,39.7), a little south-west of there (45.7,43.4), or at the south end of the loch (48.7,54.4 or 50.6,53.3). If it isn't at the arrow, try the next place. Click it for the quest; the {item:278051} comes with it."] = "",
	-- {object:665289} Discarded Fishing Toolbox (no name in this language: may be words)
	["{object:665289}; underwater"] = "{object:665289}；在水下",

	-- Step 11: Thelsamar
	-- {npc:1684} Khara Deepwater · {npc:1105} Jern Hornhelm
	["{npc:1684} stands on the shore north-east of town, {npc:1105} by the inn."] = "{npc:1684}站在镇子东北的岸边，{npc:1105}在旅店旁。",

	-- Step 12: Ironband's Excavation
	-- {npc:1345} Magmar Fellhew · {npc:1344} Prospector Ironband
	["Round the south end of the loch and head east to the dig. {npc:1345} and {npc:1344} stand together at its west edge."] = "绕过湖南端，向东前往挖掘场。{npc:1345}和{npc:1344}一起站在挖掘场西侧。",

	-- Step 13: The dig site
	["The dig site"] = "挖掘场",
	-- {item:2636} Carved Stone Idol · {quest:86613} Excavation Tools
	-- plural, as words: Stonesplinter Diggers = {npc:1167} Stonesplinter Digger · Berserk Troggs = {npc:1393} Berserk Trogg
	["Stonesplinter Diggers, Geomancers and Berserk Troggs hold the dig east of Ironband; any of them can drop a {item:2636}. Piles of Excavation Tools lie around the dig: open one and right-click the tools to start {quest:86613}, then gather six.\nCareful: Berserk Troggs (19-20) enrage below 40% health."] = "铁环东面的挖掘场被碎石怪掘地工、碎石怪地卜师和狂暴穴居人占据，它们都可能掉落{item:2636}。挖掘场四处分布着挖掘工具堆：打开一堆，右键点击工具接取{quest:86613}，然后收集六份。\n小心：狂暴穴居人（19-20级）在生命值低于40%时会狂暴。",
	-- {quest:86613} Excavation Tools
	["{quest:86613}: open a pile at the dig"] = "{quest:86613}：打开挖掘场的一堆工具",
	-- {quest:86613} Excavation Tools
	["Right-click the {quest:86613}"] = "右键点击{quest:86613}",

	-- Step 15: The Farstrider Lodge
	-- {npc:1154} Marek Ironheart · {npc:1187} Daryl the Youngling
	["North-east to the lodge on the hill. {npc:1154} stands inside, {npc:1187} outside."] = "向东北前往山上的小屋。{npc:1154}在屋内，{npc:1187}在屋外。",
	-- {npc:1154} Marek Ironheart
	["{npc:1154}, inside"] = "{npc:1154}，在屋内",
	-- {npc:1154} Marek Ironheart
	["{npc:1154}: the loch crocolisks below the lodge"] = "",
	-- {npc:1187} Daryl the Youngling
	["{npc:1187}: 15 minutes"] = "{npc:1187}：15分钟",

	-- Step 16: Mountain Buzzards
	-- plural, as words: Mountain Buzzards = {npc:1194} Mountain Buzzard
	["Mountain Buzzards"] = "山鹫",
	-- {quest:257} A Hunter's Boast
	-- plural, as words: Mountain Buzzards = {npc:1194} Mountain Buzzard
	["Mountain Buzzards circle the hills west and south of the lodge, back toward the dig. {quest:257} runs for 15 minutes."] = "山鹫在小屋西面和南面、通往挖掘场的山丘间盘旋。{quest:257}限时15分钟。",

	-- Step 17: Daryl the Youngling
	["12 minutes"] = "12分钟",

	-- Step 18: Elder Mountain Boars, Daggerfang and the loch crocolisks
	-- {npc:270693} Daggerfang
	-- plural, as words: Elder Mountain Boars = {npc:1192} Elder Mountain Boar
	["Elder Mountain Boars, {npc:270693} and the loch crocolisks"] = "",
	-- {quest:258} A Hunter's Challenge · {npc:270693} Daggerfang
	-- plural, as words: Elder Mountain Boars = {npc:1192} Elder Mountain Boar · Loch Crocolisks = {npc:1693} Loch Crocolisk
	["The Elder Mountain Boars roam the hills north-west of the lodge, along the east shore: {quest:258} runs for 12 minutes, so the boars come first. {npc:270693}, a crocolisk, patrols the shore below them among the Loch Crocolisks."] = "",
	-- {item:2924} Crocolisk Meat
	-- plural, as words: Loch Crocolisks = {npc:1693} Loch Crocolisk
	["{item:2924}: Loch Crocolisks"] = "",

	-- Step 20: Thelsamar
	-- {area:144} Thelsamar · {npc:1105} Jern Hornhelm · {npc:1572} Thorgrum Borrelson
	["Back west along the south shore to {area:144}: {npc:1105} by the inn, then {npc:1572} with the gryphons on the west side of town, on the way south."] = "沿南岸向西返回{area:144}：先找旅店旁的{npc:1105}，再找镇子西侧狮鹫旁的{npc:1572}，之后继续向南。",
	-- {npc:1356} Prospector Stormpike · {zone:1455} Ironforge
	["For {npc:1356} in {zone:1455}"] = "交给{zone:1455}的{npc:1356}",

	-- Step 21: Mountaineer Ylva
	-- {npc:269185} Headsplitter
	["South of Thelsamar, Ylva lies dead in the mouth of a trogg cave. Take her banner, raise it beside her and hold the spot: troggs come in waves from both sides, then {npc:269185}."] = "塞尔萨玛南边，伊尔瓦的遗体躺在一个穴居人洞口。拿起她的旗帜，在遗体旁竖起并守住：穴居人会从两侧分波来袭，最后出现{npc:269185}。",

	-- Step 22: The tunnel post
	["The tunnel post"] = "隧道哨所",
	-- {zone:1426} Dun Morogh
	["West to the dwarven post at the tunnel to {zone:1426}."] = "向西前往通往{zone:1426}的隧道口矮人哨所。",

	-- Step 23: Into Dun Morogh
	-- {zone:1426} Dun Morogh
	["Into {zone:1426}"] = "进入{zone:1426}",
	-- {zone:1455} Ironforge
	["Through the South Gate tunnel and west along the road to {zone:1455}."] = "穿过南门隧道，沿路向西前往{zone:1455}。",

	-- Step 24: Into Ironforge
	-- {zone:1455} Ironforge
	["Into {zone:1455}"] = "进入{zone:1455}",

	-- Step 25: Ironforge
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge · {npc:1356} Prospector Stormpike · {object:32356} Hall of Explorers · {object:171524} Tinker Town
	["{npc:1573} keeps the gryphons in the {object:32372}; {npc:1356} is in the {object:32356}, north-east of it, on the way to the tram in {object:171524}."] = "{npc:1573}在{object:32372}照看狮鹫；{npc:1356}在其东北方向的{object:32356}内，前往{object:171524}的地铁时顺路经过。",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}，在{object:32372}",

	-- Step 26: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "乘地铁前往{zone:1453}",

	-- Step 27: Elwynn Forest
	-- {zone:1453} Stormwind · {area:87} Goldshire
	["From the tram, leave {zone:1453} by the main gate and follow the road through {area:87} and east through Elwynn to Redridge."] = "下地铁后从正门离开{zone:1453}，沿路穿过{area:87}，再向东穿越艾尔文森林，前往赤脊山。",
	["The road east to Redridge"] = "",

	-- Step 28: Guard Thomas
	-- {npc:261} Guard Thomas · {area:91} Tower of Azora · {npc:240} Marshal Dughan · {quest:35} Further Concerns · {area:87} Goldshire
	["{npc:261} guards the bridge on this road east, past the {area:91}: {npc:240}'s {quest:35}, from your walk through {area:87}, goes to him."] = "向东沿这条路走，经过{area:91}后，{npc:261}就在桥上值守：路过{area:87}时从{npc:240}处接的{quest:35}交给他。",
	-- {npc:261} Guard Thomas
	["{npc:261}, on the bridge"] = "{npc:261}，在桥上",

	-- Step 29: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker
	["The road crosses into Redridge at {area:1002}. {npc:464} walks around the crossroads."] = "这条路在{area:1002}进入赤脊山。{npc:464}在路口附近走动。",
	-- {npc:464} Guard Parker · {area:1002} Three Corners
	["{npc:464} walks around {area:1002}: look inside the circle on the map"] = "{npc:464}在{area:1002}附近巡逻：在地图标示的圆圈内寻找",

	-- Step 30: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} stands by the road next to her."] = "沿{area:68}南岸的道路前往狮鹫管理员。{npc:1070}就在她旁边的路边。",

	-- Step 31: Lakeshire
	-- {npc:8965} Shawn · {npc:8962} Hilary · {npc:341} Foreman Oslow · {npc:382} Marshal Marris · {npc:415} Verner Osgood · {npc:344} Magistrate Solomon · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:379} Darcy · {npc:343} Chef Breanna
	["Cross the long bridge north into town: {npc:8965} and {npc:8962} play by the shore at its north end, {npc:341} and {npc:382} stand there too, {npc:415} by the smithy, {npc:344} in the town hall, {npc:381} on the docks, {npc:266} upstairs in the inn and {npc:379} and {npc:343} inside it."] = "向北穿过长桥进镇：{npc:8965}和{npc:8962}在桥北端的岸边玩耍，{npc:341}和{npc:382}也在那里；{npc:415}在铁匠铺旁，{npc:344}在镇公所，{npc:381}在码头，{npc:266}在旅店楼上，{npc:379}和{npc:343}也在旅店内。",
	-- {npc:382} Marshal Marris
	["{npc:382}: the Blackrock camps are for your next Redridge visit, at about 24"] = "{npc:382}：黑石营地留到下次约24级来赤脊山时再做",
	-- {npc:415} Verner Osgood · {npc:514} Smith Argus · {area:87} Goldshire
	["{npc:415}: for {npc:514} in {area:87}"] = "{npc:415}：交给{area:87}的{npc:514}",
	-- {npc:344} Magistrate Solomon · {npc:466} General Marcus Jonathan · {zone:1453} Stormwind
	["{npc:344}, in the town hall: for {npc:466} in {zone:1453}"] = "{npc:344}，在镇公所：交给{zone:1453}的{npc:466}",
	-- {npc:266} Wiley the Black
	["{npc:266}, in the inn; upstairs"] = "{npc:266}，在旅店楼上",
	-- {npc:379} Darcy
	["{npc:379}, inside"] = "{npc:379}，在里面",
	-- {npc:343} Chef Breanna
	["{npc:343}, inside"] = "{npc:343}：在屋内",

	-- Step 32: Guard Parker
	-- {area:1002} Three Corners
	["West along the road to {area:1002} first; the gnolls are on the way back east."] = "先沿路向西前往{area:1002}；回来向东走时再打豺狼人。",

	-- Step 33: Lakeridge Highway: kill these as you meet them
	-- {area:1001} Lakeridge Highway
	["{area:1001}: kill these as you meet them"] = "{area:1001}：沿途击杀以下目标",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Great Goretusks = {npc:547} Great Goretusk · Dire Condors = {npc:428} Dire Condor
	["Redridge Mongrels and Thrashers hold the hills east of {area:1002}, north of the road; Poachers camp south of the road. Great Goretusks root around the same hills and Dire Condors circle south of the lake; Tarantulas crawl round {area:1002}."] = "混血赤脊山豺狼人和赤脊山鞭笞者占据{area:1002}东面、道路以北的山丘；赤脊山偷猎者扎营在道路以南。巨型血牙野猪在同一片山丘觅食，恐鹫在湖南面盘旋；狼蛛出没于{area:1002}周围。",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911}：赤脊山鞭笞者",
	-- {item:1081} Crisp Spider Meat
	["{item:1081}: Tarantulas"] = "{item:1081}：狼蛛掉落",

	-- Step 34: Deputy Feldon
	-- {npc:1070} Deputy Feldon
	["East along the road to the gryphon master; {npc:1070} stands beside her."] = "沿路向东前往狮鹫管理员；{npc:1070}站在她旁边。",

	-- Step 35: Sunken Chest
	-- {area:68} Lake Everstill · {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater
	["Back toward town, swim east from the bridge into {area:68}; the chest lies on the lake bed beside a sunken boat. Murloc Flesheaters and Tidecallers line the south shore around it: any of them can carry a {item:1467}."] = "往镇子方向走，从桥边向东游入{area:68}；箱子在湖底的一艘沉船旁。鱼人食腐者和Tidecallers分布在附近南岸，都可能携带{item:1467}。",
	-- {item:1309} Oslow's Toolbox
	["{item:1309}; underwater"] = "{item:1309}：在水下",

	-- Step 36: Hilary's Necklace
	-- {object:154357} Glinting Mud
	["Then west under the bridge: a {object:154357} mound on the lake bed beside town holds the necklace. Only one mound shows at a time, anywhere from under the dock to past the bridge."] = "然后向西游到桥下：镇子旁的湖底有一堆{object:154357}，项链就在里面。每次只出现一堆，可能在码头下方到桥另一侧之间的任何位置。",
	-- {quest:3741} Hilary's Necklace
	["{quest:3741}; underwater"] = "{quest:3741}；在水下",

	-- Step 37: Lakeshire
	-- {npc:8962} Hilary · {npc:341} Foreman Oslow · {npc:381} Dockmaster Baren · {npc:342} Martie Jainrose · {npc:379} Darcy · {npc:343} Chef Breanna
	["Through town east to west: {npc:8962} and {npc:341} at the north end of the bridge, {npc:381} on the docks, then {npc:342}'s garden at the west end; {npc:379} and {npc:343} are in the inn."] = "从东向西穿过镇子：{npc:8962}和{npc:341}在桥北端，{npc:381}在码头，然后去镇子西端{npc:342}的花园；{npc:379}和{npc:343}在旅店内。",
	-- {zone:1436} Westfall
	["Its pikes and rivets come from the gnolls north of the lake, on the loop after {zone:1436}"] = "所需的铁矛和铁铆钉由湖北面的豺狼人掉落，完成{zone:1436}后绕行时再收集",

	-- Step 38: Dockmaster Baren
	-- {npc:381} Dockmaster Baren · {quest:150} Murloc Poachers · {area:69} Lakeshire
	["From level 20 {npc:381} gives {quest:150}: take it now if he offers it (otherwise on the last {area:69} stop). Its murlocs are for your next Redridge visit, at about 24."] = "20级起，{npc:381}会提供{quest:150}：如果现在能接就接下（否则留到最后一次停靠{area:69}时）。任务鱼人留到下次约24级来赤脊山时再打。",
	-- {npc:381} Dockmaster Baren
	["{npc:381}, on the docks"] = "{npc:381}，在码头",

	-- Step 39: Goldshire
	-- {area:1002} Three Corners · {area:87} Goldshire
	["West out of Redridge by {area:1002} and along the road through Elwynn to {area:87}."] = "经{area:1002}向西离开赤脊山，沿路穿过艾尔文森林，前往{area:87}。",

	-- Step 40: Smith Argus
	-- {npc:514} Smith Argus · {area:87} Goldshire
	["{npc:514} works at the {area:87} smithy."] = "{npc:514}在{area:87}的铁匠铺工作。",

	-- Step 41: Stormwind's gate
	-- {zone:1453} Stormwind
	["{zone:1453}'s gate"] = "",
	-- {npc:234} Gryan Stoutmantle · {zone:1436} Westfall · {area:87} Goldshire · {zone:1453} Stormwind · {npc:466} General Marcus Jonathan · {object:2096} Trade District · {area:69} Lakeshire
	["No Defias Brotherhood from Wiley (it starts with {npc:234}'s letter in {zone:1436}): skip {zone:1436}. North along the road from {area:87} to {zone:1453}: {npc:466} sits on his horse at the far end of the bridge outside the main gate. Then the gryphons in the {object:2096}, back to {area:69}."] = "",
	-- {npc:466} General Marcus Jonathan
	["{npc:466}, outside the main gate"] = "{npc:466}，在正门外",

	-- Step 42: Westfall
	-- {zone:1436} Westfall
	["West through Westbrook into {zone:1436}."] = "向西穿过西泉，进入{zone:1436}。",

	-- Step 43: Sentinel Hill
	-- {area:108} Sentinel Hill · {npc:234} Gryan Stoutmantle
	["Down the road to {area:108}. {npc:234} stands at the top of the stone tower."] = "沿路前往{area:108}。{npc:234}站在石塔顶上。",
	-- {npc:332} Master Mathias Shaw · {zone:1453} Stormwind
	["For {npc:332} in {zone:1453}"] = "交给{zone:1453}的{npc:332}",

	-- Step 44: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飞往{zone:1453}",
	-- {area:108} Sentinel Hill
	["{area:108} flight master"] = "{area:108}的飞行管理员",

	-- Step 45: Stormwind
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:466} General Marcus Jonathan · {object:2096} Trade District
	["{npc:332} is upstairs in the SI:7 building in {object:2100}: the stairs are hard to see at first. {npc:466} sits on his horse at the far end of the bridge outside the main gate, then back to the gryphons in the {object:2096}."] = "{npc:332}在{object:2100}的军情七处（SI:7）大楼楼上：楼梯起初不太显眼。{npc:466}骑马站在正门外桥的远端，之后返回{object:2096}的狮鹫处。",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7; upstairs"] = "{npc:332}，军情七处（SI:7）；楼上",

	-- Step 46: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle
	["{npc:234}, at the top of the tower"] = "{npc:234}，在塔顶",

	-- Step 47: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20}和迪菲亚山丘",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "{npc:121}和迪菲亚拳匪在{area:20}巡逻；迪菲亚路霸（17级）成对巡逻其南边和东边的山丘：把它们分开拉。铁匠铺里的{area:1581}入口是小队地下城。\n小心：山丘上的营地有混编的迪菲亚，如果你等级低，很容易一次拉到不止一个。",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}，来自{area:20}周围的箱子",

	-- Step 48: The Defias Messenger
	-- {npc:550} Defias Messenger
	["The {npc:550}"] = "{npc:550}",
	-- {area:20} Moonbrook · {npc:550} Defias Messenger · {area:113} Gold Coast Quarry · {area:111} Jangolode Mine
	["South along the road to {area:20}. The {npc:550} starts in front of the {area:20} smithy and walks north to the {area:113} and the back of the {area:111}, then back: look along his road. Slow him when he runs at 30% health."] = "沿路向南前往{area:20}。{npc:550}从{area:20}铁匠铺前出发，向北走到{area:113}和{area:111}后方，再原路返回：沿这条路线寻找。他在生命值降至30%时会逃跑，记得减速。",
	-- {item:1381} A Mysterious Message · {npc:550} Defias Messenger
	["{item:1381}: the {npc:550}"] = "{item:1381}：{npc:550}掉落",

	-- Step 49: Westfall Lighthouse
	-- {area:20} Moonbrook · {npc:392} Captain Grayson · {npc:391} Old Murk-Eye
	["South-west from {area:20} to the lighthouse on the point: {npc:392} waits on its steps. {npc:391} walks the beach and the shallows north-east of it among the murlocs: pull him away from the Oracles."] = "从{area:20}向西南前往岬角上的灯塔：{npc:392}在台阶上。{npc:391}在灯塔东北的海滩和浅水区、鱼人之间游荡：把他拉离Oracles再打。",
	-- {item:3636} Scale of Old Murk-Eye · {npc:391} Old Murk-Eye
	["{item:3636}: {npc:391}, on the beach north-east of the lighthouse"] = "",

	-- Step 50: Sentinel Hill
	-- {area:108} Sentinel Hill · {npc:467} The Defias Traitor
	["Back north up the road to {area:108}. {npc:467} waits at the foot of the tower ramp; if he is missing, someone is escorting him and he is back within minutes."] = "向北沿路返回{area:108}。{npc:467}在通往塔的坡道底部；如果不在，就是有人正在护送他，几分钟内便会回来。",

	-- Step 51: The Defias Traitor
	-- {area:20} Moonbrook
	["Stay with the traitor as he walks south to {area:20}; he does not stop for fights, so clear what follows him. His walk ends at the Defias hideout below {area:20}."] = "跟着叛徒向南走到{area:20}；他不会停下来等战斗结束，记得清掉追他的怪。他最后会走到{area:20}下方的迪菲亚藏身处。",
	-- {npc:467} The Defias Traitor
	["{npc:467}, at the foot of the tower ramp"] = "{npc:467}，在通往塔的坡道底部",

	-- Step 52: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle
	["Back north to {npc:234} and the gryphons."] = "向北返回{npc:234}和狮鹫处。",

	-- Step 53: Lakeshire
	-- {npc:415} Verner Osgood · {npc:344} Magistrate Solomon
	["From the gryphons, over the bridge into town: {npc:415} by the smithy, {npc:344} in the town hall."] = "从狮鹫处过桥进镇：{npc:415}在铁匠铺旁，{npc:344}在镇公所。",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}，在市政厅",

	-- Step 54: Redridge Canyons
	-- {spell:133} Fireball
	-- plural, as words: Redridge Brutes = {npc:426} Redridge Brute · Iron Pikes = {item:2856} Iron Pike · Black Dragon Whelps = {npc:441} Black Dragon Whelp
	["Redridge Brutes and Mystics hold the hills north and north-west of town; both carry the Iron Pikes and Rivets. Black Dragon Whelps nest in the same hills.\nCareful: The whelps cast {spell:133} from range, and the gnolls run for help at low health."] = "赤脊山蛮兵和赤脊山秘法师占据镇子北面和西北的山丘，两者都携带铁矛和铁铆钉。黑龙雏龙也栖息在这片山丘。\n小心：雏龙会在远处施放{spell:133}，豺狼人则会在生命值低时逃跑求援。",
	-- {item:1221} Underbelly Whelp Scale
	-- plural, as words: Black Dragon Whelps = {npc:441} Black Dragon Whelp
	["{item:1221}: Black Dragon Whelps"] = "{item:1221}：黑龙雏龙掉落",

	-- Step 55: Lakeshire
	-- {npc:415} Verner Osgood · {npc:341} Foreman Oslow · {npc:381} Dockmaster Baren
	["Back down into town: {npc:415} by the smithy, {npc:341} at the north end of the bridge, {npc:381} on the docks."] = "下山回镇：{npc:415}在铁匠铺旁，{npc:341}在桥北端，{npc:381}在码头。",
	-- {npc:341} Foreman Oslow · {quest:98386} Alther's Mill
	["{npc:341}: {quest:98386}, for your next Redridge visit"] = "{npc:341}：{quest:98386}，留到下次来赤脊山时再做",
	-- {npc:381} Dockmaster Baren
	["{npc:381}, on the docks: the murlocs are for your next Redridge visit"] = "{npc:381}，在码头：鱼人留到下次来赤脊山时再打",

	-- Step 56: Fly to Stormwind
	-- {area:442} Auberdine · {zone:1439} Darkshore · {zone:1453} Stormwind
	["Back to {area:442} for {zone:1439}'s southern loops: the gryphon to {zone:1453}, then the boat from the harbour."] = "返回{area:442}，继续{zone:1439}南部的路线：先乘狮鹫到{zone:1453}，再从港口坐船。",
	-- {area:69} Lakeshire
	["{area:69} flight master"] = "{area:69}飞行管理员",

	-- Step 58: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:28027} Dwarven District
	["{npc:1646} stands at the east side of {object:2098}, on the way from the {object:28027} to the harbour."] = "",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}：来自{area:442}的桑迪斯的信",
	-- {npc:3649} Thundris Windweaver
	["For {npc:3649}, where the boat lands"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Elder Mountain Boars and {npc:270693}"] = "老山猪和{npc:270693}",
	-- ["South along the west shore. A {object:665289} lies on the loch bed east of {area:144} (it moves between several spots): open it for the {item:278051}, which starts the quest."] = "沿西岸向南走。{area:144}东面的湖底有一个{object:665289}（会在几处位置间变换）：打开可获得{item:278051}，用它接任务。",
	-- ["The Elder Mountain Boars roam the hills north-west of the lodge, along the east shore. {npc:270693}, a crocolisk, patrols the shore below them. {quest:258} runs for 12 minutes."] = "老山猪出没于小屋西北、东岸沿线的山丘。鳄鱼{npc:270693}在山丘下方的岸边巡逻。{quest:258}限时12分钟。",
}
