-- Chinese (simplified) (zhCN): the guide forever/reputation/stormwind (forever/reputation/stormwind.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Stormwind Reputation"] = "暴风城声望",
	-- {zone:1422} Western Plaguelands
	["Cloth, the {zone:1422}' cauldron quests and the Elwynn hubs: the quests pay most while you level."] = "布料、{zone:1422}的大锅任务和艾尔文森林的任务点：升级期间任务给的声望最多。",
	-- {faction:72} Stormwind
	["Exalted with {faction:72}: in Classic, other races may buy the horses"] = "{faction:72}达到崇拜：在经典版中，其他种族可购买马匹",
	-- {faction:72} Stormwind · {area:3197} Chillwind Camp · {zone:1428} Burning Steppes
	["About 1,150 {faction:72} reputation from level 52-58 quests at {area:3197} and in the {zone:1428}"] = "{area:3197}和{zone:1428}的52-58级任务提供约1150点{faction:72}声望",
	-- {faction:72} Stormwind · {area:717} Stockade
	["About 4,500 {faction:72} reputation from low-level quests in Elwynn and the {area:717}"] = "",

	-- Step 1: Clavicus Knavingham, the cloth quartermaster
	-- {npc:14722} Clavicus Knavingham
	["{npc:14722}, the cloth quartermaster"] = "布料军需官{npc:14722}",
	-- {npc:14722} Clavicus Knavingham · {faction:72} Stormwind · {item:14047} Runecloth · {quest:7796} Additional Runecloth · {zone:1436} Westfall · {zone:1431} Duskwood · {zone:1422} Western Plaguelands · {zone:1428} Burning Steppes · {area:717} Stockade · {area:87} Goldshire · {zone:1455} Ironforge · {zone:1457} Darnassus
	["{npc:14722} takes cloth for {faction:72}. The arrow leads to him; he stands upstairs inside his building. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7796} pays 50 for every 20 {item:14047}, as often as you like. The Auction House is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do Elwynn (levels 1-10), {zone:1436} (10-18), Redridge (15-25) and {zone:1431} (20-30) while you level through them. After the donations come the level 52-58 quests of the {zone:1422} and the {zone:1428} (about 1,150), then the optional low-level hubs, best rate first: Northshire and the city errands (about 40 a minute at full value), the {area:717} (30), Eastvale and {area:87} (25). Every {faction:72} gain also gives a quarter as much to {zone:1455}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14722} 接受布料以提升 {faction:72} 声望。箭头会引导你找到他；他站在建筑内楼上。毛料、丝绸、魔纹布和 {item:14047} 的首次捐献各需 60 个，每种一次性提供 150 点声望；完成 {item:14047} 的捐献后，{quest:7796} 可无限重复，每 20 个 {item:14047} 换取 50 点。拍卖行是最快的布料来源。经典旧世中，任务最多比你低 5 级时仍提供全额声望，因此升级经过时就做完艾尔文森林（1-10 级）、{zone:1436}（10-18 级）、赤脊山（15-25 级）和 {zone:1431}（20-30 级）的任务。捐献之后，先做 {zone:1422} 和 {zone:1428} 的 52-58 级任务（约 1,150 点），再做可选低等级任务点，按效率由高到低依次为：北郡和城内跑腿任务（全额奖励时约每分钟 40 点）、{area:717}（30 点）、东谷和 {area:87}（25 点）。除 1-10 级起始地区的任务外，每次获得 {faction:72} 声望还会向 {zone:1455}、{zone:1457} 和诺莫瑞根流亡者各提供四分之一。传承天赋“外交家” 可让每次收益最多提高 10%。",
	-- {item:2592} Wool Cloth · {zone:1436} Westfall
	["{item:2592}: Defias, gnolls and kobolds in {zone:1436} and Redridge"] = "{item:2592}：由 {zone:1436} 和赤脊山的迪菲亚成员、豺狼人及狗头人掉落",

	-- Step 2: Stormwind errands
	-- {faction:72} Stormwind
	["{faction:72} errands"] = "{faction:72} 跑腿任务",
	-- {faction:72} Stormwind
	["Optional: four quick deliveries inside {faction:72} for 200 reputation in about five minutes. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 3: Northshire Valley
	-- {area:87} Goldshire · {npc:823} Deputy Willem · {npc:197} Marshal McBride · {area:24} Northshire Abbey
	["Optional: the Human start valley north of {area:87}: about 1,600 reputation in 40 minutes at 60, the best rate of the hubs. {npc:823} and {npc:197} stand at {area:24}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 4: Northshire: kobolds, wolves and bandanas
	["Northshire: kobolds, wolves and bandanas"] = "北郡：狗头人、狼与头巾",
	-- {npc:6} Kobold Vermin · {item:247834} Nibbled-On Book
	["The {npc:6} dig at the camp north of the abbey; the wolves roam the valley; the Defias at the vineyard east of the abbey drop the bandanas. Keep any {item:247834} a kobold drops: it starts Forever's book chain."] = "{npc:6} 在修道院北边的营地挖掘；狼在山谷中游荡；修道院东边葡萄园的迪菲亚成员会掉落头巾。狗头人掉落的 {item:247834} 要保留：它会开启无限服的书本任务线。",
	-- {item:247834} Nibbled-On Book
	["{item:247834}, from the kobolds"] = "{item:247834}，由狗头人掉落",

	-- Step 5: Northshire: back at the abbey
	["Northshire: back at the abbey"] = "北郡：返回修道院",

	-- Step 6: Northshire: Echo Ridge, Garrick Padfoot and the vineyard
	-- {npc:103} Garrick Padfoot
	["Northshire: Echo Ridge, {npc:103} and the vineyard"] = "北郡：回音山、{npc:103}和葡萄园",
	-- {area:34} Echo Ridge Mine · {npc:103} Garrick Padfoot · {quest:3904} Milly's Harvest · {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["The Kobold Workers are in {area:34} north of the abbey; {npc:103} stands in the Defias camp east of the vineyard; {quest:3904} crates lie in the vineyard; the rats carrying the {object:83763} run about the abbey grounds."] = "狗头人劳工在修道院北边的 {area:34}；{npc:103} 站在葡萄园东边的迪菲亚营地；{quest:3904} 的箱子散落在葡萄园中；携带 {object:83763} 的老鼠在修道院场地内乱跑。",

	-- Step 7: Northshire: second hand-in
	["Northshire: second hand-in"] = "北郡：第二次交还任务",

	-- Step 8: Northshire: the mine and the books
	["Northshire: the mine and the books"] = "北郡：矿洞和书籍",
	-- {npc:80} Kobold Laborer · {area:34} Echo Ridge Mine
	["{npc:80}, deep in {area:34}"] = "{npc:80}，在{area:34}深处",

	-- Step 9: Northshire: last hand-in
	["Northshire: last hand-in"] = "北郡：最后一次交还任务",
	-- {object:563442} Kobold Tracks (no name in this language: may be words)
	["{object:563442}, east of the abbey"] = "{object:563442}，位于修道院东面",

	-- Step 10: Northshire: the books end in Goldshire
	-- {area:87} Goldshire
	["Northshire: the books end in {area:87}"] = "北郡：书籍任务最后在 {area:87} 交还",
	-- {npc:240} Marshal Dughan · {area:87} Goldshire · {area:57} Fargodeep Mine
	-- plural, as words: Lost Books = {item:248001} Lost Book
	["{npc:240} stands in front of the Lion's Pride Inn in {area:87}. The Lost Books drop from the kobolds of {area:57} south of {area:87}; the picture book and the two rare books from the named kobolds there."] = "{npc:240}站在{area:87}狮王之傲旅店前方。{area:87}南面的{area:57}狗头人会掉落遗失的书本；图画书和两本稀有书由那里的有名字的狗头人掉落。",
	["Arcane Explainer"] = "奥术详解",
	-- {npc:951} Brother Paxton
	["{npc:951}, back at the abbey"] = "{npc:951}，回到修道院",

	-- Step 11: Goldshire
	-- {area:87} Goldshire · {npc:240} Marshal Dughan · {npc:241} Remy "Two Times" · {npc:253} William Pestle
	["Optional: {area:87}, Westbrook and the farms south of {area:87}: about 1,450 reputation in an hour at 60. {npc:240}, {npc:241} and {npc:253} stand around the Lion's Pride Inn. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 12: Goldshire: the mines
	-- {area:87} Goldshire
	["{area:87}: the mines"] = "{area:87}：矿洞",
	-- {area:57} Fargodeep Mine · {area:87} Goldshire · {area:54} Jasperlode Mine · {item:773} Gold Dust
	["{area:57} is south of {area:87}, {area:54} north-east of it. The kobolds in both drop the candles and the {item:773}; the wolves around {area:87} the pelts."] = "{area:57} 在 {area:87} 南面，{area:54} 在其东北面。两处的狗头人都掉落蜡烛和 {item:773}；{area:87} 周围的狼掉落毛皮。",

	-- Step 13: Goldshire: back at the inn
	-- {area:87} Goldshire
	["{area:87}: back at the inn"] = "{area:87}：返回旅店。",

	-- Step 14: Goldshire: Jasperlode Mine
	["walk into the mine"] = "走进矿洞",

	-- Step 15: Goldshire: Westbrook and Hogger
	-- {area:87} Goldshire · {npc:448} Hogger
	["{area:87}: Westbrook and {npc:448}"] = "{area:87}：西泉要塞与 {npc:448}",
	-- {npc:448} Hogger · {area:120} Westbrook Garrison
	["{npc:448} is an elite gnoll west of {area:120}; at 60 he is no trouble. The Wanted poster hangs on the garrison."] = "{npc:448} 是 {area:120} 西边的精英豺狼人；60级时很容易对付。通缉告示贴在兵营上。",
	-- {item:782} Painted Gnoll Armband
	["{item:782}, from the Riverpaw gnolls"] = "{item:782}，由河爪豺狼人掉落",
	-- {item:1931} Huge Gnoll Claw · {npc:448} Hogger
	["{item:1931}, from {npc:448}"] = "{item:1931}，由{npc:448}掉落",

	-- Step 16: The farms south of Goldshire
	-- {area:87} Goldshire
	["The farms south of {area:87}"] = "{area:87}南面的农场",
	-- {area:87} Goldshire · {quest:87} Goldtooth · {area:57} Fargodeep Mine · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch
	["The Stonefields' farm and the Maclures' farm lie on either side of the road south of {area:87}. {quest:87} guards the back of {area:57}; {npc:330} the boar roams the {area:62}."] = "斯通菲尔德农场和马科伦农场位于 {area:87} 南边道路两侧。{quest:87} 守在 {area:57} 深处；野猪 {npc:330} 在 {area:62} 游荡。",
	-- {item:1006} Brass Collar · {npc:330} Princess
	["{item:1006}, from {npc:330}"] = "{item:1006}，由{npc:330}掉落",

	-- Step 17: Goldtooth and the kelp
	-- {quest:87} Goldtooth
	["{quest:87} and the kelp"] = "{quest:87} 与海藻",
	-- {item:981} Bernice's Necklace · {quest:87} Goldtooth
	["{item:981}, from {quest:87}"] = "{item:981}，来自{quest:87}",
	-- {item:1256} Crystal Kelp Frond · {area:18} Crystal Lake
	["{item:1256}, from the murlocs of {area:18}"] = "{item:1256}，由 {area:18} 的鱼人掉落",

	-- Step 18: Goldshire: last hand-in
	-- {area:87} Goldshire
	["{area:87}: last hand-in"] = "{area:87}：最后一次交任务",

	-- Step 19: Shipment to Stormwind
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, in the {object:2096}"] = "{npc:279}，在{object:2096}",

	-- Step 20: Eastvale
	["Eastvale"] = "东谷",
	-- {npc:261} Guard Thomas · {area:91} Tower of Azora
	["Optional: eastern Elwynn, around {npc:261} on the bridge and the {area:91}, about 1,000 reputation in 40 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 21: Eastvale: the work
	["Eastvale: the work"] = "东谷：处理事务",
	-- {area:91} Tower of Azora · {area:54} Jasperlode Mine
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear · Kobold Geomancers = {npc:476} Kobold Geomancer
	["The murlocs along the river south of the bridge drop the fins; Prowlers and Young Forest Bears roam the woods; the Defias around the Brackwell farm and the {area:91} carry the bandanas; the enchanting supplies lie in their camps north of the tower; the Kobold Geomancers dig at {area:54}; the tools and the river finds lie along the river north of the logging camp."] = "桥南面的河边鱼人掉落鱼鳍；潜行者和森林熊幼崽在树林游荡；布莱克威尔农场和{area:91}周围的迪菲亚携带头巾；附魔材料在塔楼北面的迪菲亚营地；狗头人地卜师在{area:54}挖掘；工具和河流发现物散落在伐木场北面的河流沿线。",

	-- Step 22: Eastvale: hand in
	["Eastvale: hand in"] = "东谷：交还任务",

	-- Step 23: Eastvale: Defias Rogue Wizards
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["Eastvale: Defias Rogue Wizards"] = "东谷：迪菲亚流浪巫师",
	["opens with Thomas' report"] = "交还托马斯的报告后开放",
	-- {item:780} Torn Murloc Fin
	["{item:780}, from the murlocs south of the bridge"] = "{item:780}，由桥南面的鱼人掉落",

	-- Step 24: Stockade: two quests
	-- {area:717} Stockade
	["{area:717}: two quests"] = "{area:717}：两个任务",
	-- {area:717} Stockade · {faction:72} Stormwind · {object:2101} Mage Quarter · {npc:1719} Warden Thelwater · {npc:1721} Nikova Raskol · {object:2100} Old Town · {npc:1696} Targorr the Dread · {npc:859} Guard Berton · {area:69} Lakeshire · {npc:1663} Dextren Ward · {npc:270} Councilman Millstipe · {area:42} Darkshire · {npc:639} Edwin VanCleef · {area:1581} Deadmines
	["Optional: the {area:717} is {faction:72}'s prison, a dungeon in the canals of the {object:2101}. At 60 you clear it alone in ten minutes: 300 reputation. {npc:1719} stands at the gate, {npc:1721} in {object:2100}. Two more {area:717} quests start outside the city, 100 each, if you pass by: What Comes Around... ({npc:1696}) from {npc:859} in {area:69} and Crime and Punishment ({npc:1663}) from {npc:270} in {area:42}. (The Stockade Riots, 100 more, needs the Unsent Letter from {npc:639} in the {area:1581} first.) Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "",

	-- Step 25: Inside the Stockade
	-- {area:717} Stockade
	["Inside the {area:717}"] = "在{area:717}内部",
	-- {npc:1716} Bazil Thredd
	-- plural, as words: Red Wool Bandanas = {item:2909} Red Wool Bandana
	["Kill the prisoners, convicts and insurgents in the cells; the Red Wool Bandanas drop from the Defias inside. {npc:1716} waits in the far end."] = "击杀牢房中的囚徒、罪犯和叛乱者；红色毛纺面罩由里面的迪菲亚成员掉落。{npc:1716}在最深处等候。",

	-- Step 26: Stockade: hand in
	-- {area:717} Stockade
	["{area:717}: hand in"] = "{area:717}：交任务",

	-- Step 27: A Donation of Silk
	-- {item:4306} Silk Cloth · {area:94} Raven Hill
	["{item:4306} drops from humanoids level 23 to 40: Syndicate in Alterac and Arathi, the Defias of Duskwood's {area:94}, Stranglethorn's trolls."] = "{item:4306} 由23至40级人型生物掉落：奥特兰克和阿拉希的辛迪加、暮色森林 {area:94} 的迪菲亚，以及荆棘谷的巨魔。",

	-- Step 28: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1446} Tanaris · {zone:1444} Feralas · {zone:1418} Badlands
	["{item:4338} drops from humanoids level 35 to 50: the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}, the Shadowforge dwarves of the {zone:1418}."] = "{item:4338}由35到50级人型生物掉落：{zone:1446}的砂槌食人魔、{zone:1444}的憎世纳迦、{zone:1418}的暗炉矮人。",

	-- Step 29: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7796} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60: it all goes to {quest:7796} later."] = "{item:14047} 由 50 级及以上的人型生物掉落：瘟疫之地的天灾教徒和血色十字军、{zone:1448} 的死木熊怪、{zone:1452} 的冬泉熊怪。首批 60 个以外的所有 {item:14047} 都留着：之后全都用来交还 {quest:7796}。",

	-- Step 30: Chillwind Camp: Clear the Way
	-- {npc:10838} Commander Ashlam Valorfist · {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {faction:72} Stormwind · {object:92525} Argent Dawn
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["These quests are level 52 to 58, so they pay in full at 60. {npc:10838} and {npc:11053} at {area:3197}, in the south of the {zone:1422}, send you against the four Scourge cauldrons: 820 {faction:72} reputation in all and 600 {object:92525} on the side. The Skeletal Flayers and Slavering Ghouls roam the fields north of the camp."] = "",

	-- Step 31: Andorhal and Felstone Field
	-- {area:199} Felstone Field
	["Andorhal and {area:199}"] = "安多哈尔和{area:199}",
	-- {item:12815} Beacon Torch · {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field · {npc:10778} Janice Felstone · {faction:72} Stormwind
	["Mark the four watchtowers around Andorhal, north of the camp, with the {item:12815} at each door. {npc:11075} guards the cauldron at {area:199}, west of Andorhal; his key opens it. {npc:10778}'s ghost wanders by the Felstone farmhouse, and her parcel lies inside: it goes to {faction:72} for 150 more."] = "在营地北边安多哈尔周围的四座哨塔门口，分别使用 {item:12815} 做标记。{npc:11075} 看守着安多哈尔西边 {area:199} 的大锅；他的钥匙可以打开大锅。{npc:10778} 的鬼魂在费尔斯通农舍旁游荡，她的包裹就在屋内：送到 {faction:72}，还能获得 150 点声望。",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}标记{npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}标记{npc:10903}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}标记{npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}标记{npc:10905}",
	-- {item:13194} Felstone Field Cauldron Key · {npc:11075} Cauldron Lord Bilemaw
	["{item:13194}, from {npc:11075}"] = "{item:13194}，由{npc:11075}掉落",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "{object:176361}",
	-- {object:175894} Janice's Parcel
	["{object:175894}, in the farmhouse"] = "{object:175894}，在农舍内",

	-- Step 33: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears · {area:199} Felstone Field
	["{npc:11077} guards the cauldron at {area:200}, north-east of {area:199}."] = "{npc:11077}守着{area:199}东北面{area:200}的大锅。",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "{object:177289}",

	-- Step 34: Chillwind Camp: the Writhing Haunt
	-- {area:3197} Chillwind Camp · {area:202} Writhing Haunt
	["{area:3197}: the {area:202}"] = "{area:3197}：{area:202}",

	-- Step 35: Writhing Haunt
	-- {npc:11076} Cauldron Lord Razarch · {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["{npc:11076} guards the cauldron at the {area:202}, the farm east of {area:200}."] = "{npc:11076} 守着 {area:202} 的大锅，该农场在 {area:200} 东侧。",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "{object:176393}",

	-- Step 37: Gahrron's Withering
	-- {npc:11078} Cauldron Lord Soulwrath · {area:201} Gahrron's Withering
	["{npc:11078} guards the cauldron at {area:201}, in the east of the zone."] = "{npc:11078} 守着地区东部 {area:201} 的大锅。",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "{object:176392}",

	-- Step 38: Chillwind Camp: done
	-- {area:3197} Chillwind Camp
	["{area:3197}: done"] = "{area:3197}：完成",
	-- {npc:11056} Alchemist Arbington · {area:2057} Scholomance
	["{npc:11056} in the camp also ends The Key to {area:2057} (200), after a longer chain that needs a {area:2057} group."] = "营地的{npc:11056}也接收“{area:2057}的钥匙”（200），这是较长任务链的终点，需要组队进入{area:2057}。",

	-- Step 39: Stormwind: Janice Felstone's parcel
	-- {faction:72} Stormwind · {npc:10778} Janice Felstone
	["{faction:72}: {npc:10778}'s parcel"] = "{faction:72}：{npc:10778} 的包裹。",
	-- {npc:10782} Royal Factor Bathrilor · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {npc:3520} Ol' Emma
	["{npc:10782} stands in the city hall on {object:2098}, beside {npc:1646}; {npc:3520} walks the canals."] = "{npc:10782}站在{object:2098}的市政厅内、{npc:1646}旁；{npc:3520}沿运河走动。",

	-- Step 40: Morgan's Vigil: Dragonkin Menace
	-- {npc:9562} Helendis Riverhorn · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {area:69} Lakeshire · {object:2117} Stormwind Keep · {faction:72} Stormwind · {zone:1457} Darnassus · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: a chain to {area:69} and {object:2117}, 175 {faction:72} and 175 {zone:1457} reputation (level 54). The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "",

	-- Step 41: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon · {area:69} Lakeshire
	["{npc:344} waits in the town hall of {area:69}."] = "{npc:344}在{area:69}镇公所等候。",

	-- Step 42: Stormwind Keep
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep · {npc:1749} Lady Katrana Prestor
	["{npc:1748} holds court in {object:2117} with {npc:1749} at his side: speak with her for the second of his quests."] = "{npc:1748} 在 {object:2117} 接见来客，{npc:1749} 在他身边：与她交谈，完成他给的第二个任务。",
	-- {npc:1749} Lady Katrana Prestor
	["Speak with {npc:1749}"] = "与 {npc:1749} 交谈",

	-- Step 43: Lakeshire: Solomon again
	-- {area:69} Lakeshire
	["{area:69}: Solomon again"] = "{area:69}：再次找所罗门",
	-- {area:1584} Blackrock Depths · {npc:9023} Marshal Windsor · {faction:72} Stormwind · {area:1583} Blackrock Spire · {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {area:2057} Scholomance
	["With a group the chain goes on into {area:1584}: {npc:9023}, Jail Break! and The Great Masquerade back in {faction:72} pay about 750 {faction:72} more, Maxwell's Mission (Lower {area:1583}) 250, Delivery to Ridgewell 135. Order Must Be Restored ({npc:11878} in the {zone:1423}) pays 200, The Key to {area:2057} 200; Onyxia's head 400 and Nefarian's 200 when the raids open."] = "组队后可继续任务链，进入 {area:1584}：{npc:9023}、“冲破牢笼！”以及回到 {faction:72} 完成的“潜藏者”，还会提供约 750 点 {faction:72} 声望；“麦克斯韦尔的任务”（{area:1583} 下层）提供 250 点，“瑞治维尔的箱子”提供 135 点。“重铸秩序”（{zone:1423} 的 {npc:11878}）提供 200 点，{area:2057} 的钥匙任务提供 200 点；团队副本开放后，奥妮克希亚的头颅提供 400 点，奈法利安的头颅提供 200 点。",

	-- Step 44: Additional Runecloth to Honored
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Honored"] = "{quest:7796}刷到尊敬",
	-- {quest:7796} Additional Runecloth · {item:14047} Runecloth · {faction:72} Stormwind · {zone:1436} Westfall · {area:69} Lakeshire · {zone:1431} Duskwood · {area:42} Darkshire
	["{quest:7796}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a non-Human stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Humans start 900 higher: 88 turn-ins; a Skyborne's Exploring the Alliance paid 100, two fewer). The level 52-58 quests above take 23 turn-ins off; every Elwynn hub you did takes 20 to 30 more off. More quest hubs pay {faction:72}, in full while they are no more than 5 levels below you: {zone:1436} (about 2,500 in all), Redridge's {area:69} (about 3,000) and {zone:1431}'s {area:42} (about 2,900). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "",

	-- Step 45: Additional Runecloth to Revered
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Revered"] = "{quest:7796}刷到崇敬",
	-- {npc:384} Katie Hunter · {item:14047} Runecloth
	["Honored: in Classic Stormwind's vendors take 10% off for you, {npc:384}'s horses (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "尊敬：经典版中，暴风城商人会给你10%折扣，包括{npc:384}出售的马（20金币，迅捷马200金币）；无限服尚无定论，一些指南网站称友善时5%，逐步升至崇拜时20%。尊敬到崇敬需要12,000声望：交还240次、4,800块{item:14047}。",

	-- Step 46: Additional Runecloth to Exalted
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Exalted"] = "{quest:7796}刷到崇拜",
	-- {item:14047} Runecloth · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:384} at {area:88} sells her horses to other races in Classic; the Horse and Swift Horse guides cover them."] = "崇敬到崇拜需要21,000声望：交还420次，共8,400个{item:14047}。经典旧世中，达到崇拜后，{area:88}的{npc:384}会向其他种族出售马匹；“马”和“迅捷马”指南有相应说明。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["About 4,500 {faction:72} reputation from low-level quests in Elwynn and the {area:717} (in Classic, a fifth of it at 60)"] = "艾尔文森林和{area:717}的低等级任务提供约4500点{faction:72}声望（在经典版中，60级时只有五分之一）",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "这里的黑暗教徒和暗影法师（58-60级）会掉落；在这里击杀天灾军团也会提升{object:92525}声望（见该指南）。也可以去拍卖行购买。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "这里的砂槌食人魔（45-48级）会掉落。也可以去拍卖行购买。",
	-- ["Keep handing in {quest:7796} until {faction:72} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7796}，直到{faction:72}达到崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Keep handing in {quest:7796}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7796}，每次20块{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Optional: eastern Elwynn, around {npc:261} on the bridge and the {area:91}, about 1,000 reputation (200 at a fifth) in 40 minutes at 60. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "可选：艾尔文森林东部，桥上的 {npc:261} 及 {area:91} 周围，60 级时约 40 分钟可得 1,000 点声望（按五分之一计算则为 200 点）。经典怀旧服中，比你低 6 级及以上的任务会减少奖励（60 级时只有五分之一）；一份无限测试服报告称仍有全额奖励。第一次交还就能看出实际情况：如果只有五分之一，就跳过这些任务点。跳过本步骤即可略过此任务点。",
	-- ["Optional: four quick deliveries inside {faction:72} for 200 reputation (40 at a fifth) in about five minutes. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "可选：{faction:72} 城内四个快捷送货任务，约五分钟可获得 200 点声望（按五分之一计算为 40 点）。在经典旧世中，比你低至少 6 级的任务声望奖励会减少（60 级时降至五分之一）；一份无限测试版报告称，任务仍提供全额声望。第一次交还任务时就能看出：如果只给五分之一，就跳过这些任务点。跳过本步骤即可跳过这个任务点。",
	-- ["Optional: the Human start valley north of {area:87}: about 1,600 reputation (320 at a fifth) in 40 minutes at 60, the best rate of the hubs. {npc:823} and {npc:197} stand at {area:24}. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "可选：{area:87} 北侧的人类起始山谷，60 级时花约 40 分钟可获得约 1,600 点声望（按五分之一计算为 320 点），是各任务点中效率最高的。{npc:823} 和 {npc:197} 站在 {area:24}。在经典旧世中，比你低至少 6 级的任务声望奖励会减少（60 级时降至五分之一）；一份无限测试版报告称，任务仍提供全额声望。第一次交还任务时就能看出：如果只给五分之一，就跳过这些任务点。跳过本步骤即可跳过这个任务点。",
	-- ["Optional: the {area:717} is {faction:72}'s prison, a dungeon in the canals of the {object:2101}. At 60 you clear it alone in ten minutes: 300 reputation (60 at a fifth). {npc:1719} stands at the gate, {npc:1721} in {object:2100}. Two more {area:717} quests start outside the city, 100 each, if you pass by: What Comes Around... ({npc:1696}) from {npc:859} in {area:69} and Crime and Punishment ({npc:1663}) from {npc:270} in {area:42}. (The Stockade Riots, 100 more, needs the Unsent Letter from {npc:639} in the {area:1581} first.) In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "可选：{area:717}是{faction:72}的监狱，位于{object:2101}运河区的地下城。60级可在10分钟内单刷通关：300声望（五分之一时为60）。{npc:1719}站在大门旁，{npc:1721}在{object:2100}。城外还有两个{area:717}任务，若顺路可接，每个100声望：{area:69}的{npc:859}提供“伸张正义”（{npc:1696}），{area:42}的{npc:270}提供“罪与罚”（{npc:1663}）。（另有“监狱暴动”，再奖励100，但需先取得{area:1581}中{npc:639}掉落的未寄出的信。）经典旧世中，比你低至少6级的任务奖励会减少（60级时为五分之一）；一份无限测试版报告称其奖励全额声望。第一次交还任务即可确认：若只有五分之一，就跳过这些任务区。跳过本步骤即可跳过整个任务区。",
	-- ["Optional: {area:87}, Westbrook and the farms south of {area:87}: about 1,450 reputation (290 at a fifth) in an hour at 60. {npc:240}, {npc:241} and {npc:253} stand around the Lion's Pride Inn. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "可选：{area:87}、西泉要塞和 {area:87} 南面的农场，60级时约一小时可得1,450声望（若按五分之一则为290）。{npc:240}、{npc:241} 和 {npc:253} 站在狮王之傲旅店周围。在经典旧世中，低于你6级及以上的任务奖励会减少（60级时为五分之一）；一份无限服测试版反馈称仍获得全额。第一次交还就能看出实际情况：如果只有五分之一，跳过这些任务据点。跳过此步骤即可跳过这个据点。",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "这里的河爪强盗和河爪监工（16-18级）会掉落。也可以去拍卖行购买。",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "激流堡的辛迪加雇佣兵（31-32级）会掉落。也可以去拍卖行购买。",
	-- ["These quests are level 52 to 58, so they pay in full at 60, or nearly. {npc:10838} and {npc:11053} at {area:3197}, in the south of the {zone:1422}, send you against the four Scourge cauldrons: 820 {faction:72} reputation in all and 600 {object:92525} on the side (in Classic about 690 {faction:72} at 60, as the first quests are level 52 and 53). The Skeletal Flayers and Slavering Ghouls roam the fields north of the camp."] = "这些任务为 52 至 58 级，因此在 60 级仍提供全额或接近全额的声望。{zone:1422} 南部 {area:3197} 的 {npc:10838} 和 {npc:11053} 会让你处理四座天灾大锅：合计提供 820 点 {faction:72} 声望，另有 600 点 {object:92525} 声望（经典旧世中，由于前几个任务是 52 和 53 级，60 级时约获得 690 点 {faction:72} 声望）。骷髅剥皮者和被奴役的食尸鬼在营地北侧的田野游荡。",
	-- ["{npc:14722} takes cloth for {faction:72} in {zone:1453}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7796} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14722}在{zone:1453}收取布料以提升{faction:72}声望。首次捐献毛料、丝绸、魔纹布和{item:14047}（各60块）只能做一次，每块布给的声望最多；之后{quest:7796}可重复做到崇拜。与其他种族的主城达到崇拜后，可购买该种族的坐骑。Forever的传承外交官特权可提高声望获取。",
	-- ["{npc:14722}: {item:14047} delivered"] = "{npc:14722}：已交付{item:14047}",
	-- ["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: a chain to {area:69} and {object:2117}, 175 {faction:72} and 175 {zone:1457} reputation (level 54: in Classic four fifths of it at 60). The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "{zone:1428} 东南部 {area:2418} 的 {npc:9562} 提供 {quest:4183}：任务链会前往 {area:69} 和 {object:2117}，奖励175点 {faction:72} 和175点 {zone:1457} 声望（任务等级54；在经典旧世中，60级时获得五分之四）。黑色小龙和 {npc:7044} 生活在岗哨北面的山坡上；{npc:7040} 和 {npc:7041} 在岗哨西面、地区中央。",
	-- ["{quest:7796} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7796}每次交还需要20块{item:14047}，可无限重复。按20的倍数带上{item:14047}，一次接一次全部交还。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["{quest:7796}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a non-Human stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Humans start 900 higher: 88 turn-ins; a Skyborne's Exploring the Alliance paid 100, two fewer). The level 52-58 quests above take 23 turn-ins off; every Elwynn hub you did takes 20 to 30 more off if it paid in full. More quest hubs pay {faction:72}, in full while they are no more than 5 levels below you: {zone:1436} (about 2,500 in all), Redridge's {area:69} (about 3,000) and {zone:1431}'s {area:42} (about 2,900). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7796}：用20块 {item:14047} 换取50点声望，可无限次交还。完成最初四次捐赠后，非人类角色会达到友善6,000中的700点，距离尊敬还差5,300点：需交还106次，共2,120块 {item:14047}（人类起点高900：需88次；天裔的 联盟之旅 奖励100点，可再少两次）。上面的52—58级任务可减少23次交还；每个已完成的艾尔文森林任务点，若奖励全额声望，还能再减少20到30次。还有更多任务点奖励 {faction:72} 声望，只要任务等级比你低不超过5级，就能获得全额：{zone:1436}（总计约2,500点）、赤脊山的 {area:69}（约3,000点）以及 {zone:1431} 的 {area:42}（约2,900点）。每次主城声望提升还会为其余三座联盟主城提供四分之一的声望（此处未计入）。把所有 {item:14047} 一次交完。",
}
