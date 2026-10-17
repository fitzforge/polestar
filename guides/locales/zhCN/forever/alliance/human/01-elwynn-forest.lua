-- Chinese (simplified) (zhCN): the guide forever/alliance/human/01-elwynn-forest (forever/alliance/human/01-elwynn-forest.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Northshire Abbey
	-- {npc:823} Deputy Willem · {npc:197} Marshal McBride · {npc:951} Brother Paxton · {npc:247229} Daniel · {npc:196} Eagan Peltskinner
	["You start in front of the Abbey. {npc:823} stands at the foot of the steps, {npc:197} inside the hall, {npc:951} and {npc:247229} in the library to the right, {npc:196} outside the north-west corner."] = "你从修道院前方出发。{npc:823}站在台阶下，{npc:197}在大厅里，{npc:951}和{npc:247229}在右边的图书馆，{npc:196}在西北角外面。",
	-- {npc:459} Drusilla La Salle
	["{npc:459}, outside the Abbey"] = "{npc:459}，在修道院外",

	-- Step 2: Wolves
	["Wolves"] = "狼",
	["Young Wolves and Timber Wolves roam the fields right around the Abbey."] = "幼狼和森林狼就在修道院周围的田野里游荡。",

	-- Step 3: Eagan Peltskinner
	-- {npc:823} Deputy Willem
	["{npc:823}, back at the Abbey steps"] = "{npc:823}，回到修道院台阶处",

	-- Step 4: The kobold camp
	["The kobold camp"] = "狗头人营地",
	-- {npc:6} Kobold Vermin · {quest:91741} Nibbled-On Book
	["{npc:6} dig in the vineyards north-east of the Abbey. Now and then one drops a {quest:91741}: right-click it."] = "{npc:6}在修道院东北方的葡萄园里挖掘。偶尔会有一只掉落{quest:91741}：右键点击它。",

	-- Step 5: Northshire Abbey
	-- {npc:247229} Daniel
	["{npc:247229}, in the library"] = "{npc:247229}，在图书馆里",

	-- Step 6: Echo Ridge Mine
	-- {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["Follow the path north to the mine. Kobold Workers swarm outside it; every kobold in the valley can drop the {object:83763}."] = "沿小路向北到矿洞。{npc:257}聚集在矿洞外；山谷里的每个狗头人都可能掉落{object:83763}。",

	-- Step 7: Northshire Abbey
	-- {npc:911} Llane Beshere
	["{npc:911}, the warrior trainer"] = "{npc:911}，战士训练师",
	-- {npc:925} Brother Sammuel
	["{npc:925}, the paladin trainer"] = "{npc:925}，圣骑士训练师",
	-- {npc:248415} Tordrin Sternblade
	["{npc:248415}, by the Abbey"] = "{npc:248415}，在修道院旁",
	-- {npc:915} Jorik Kerridan
	["{npc:915}, the rogue trainer"] = "{npc:915}，潜行者训练师",
	-- {npc:375} Priestess Anetta
	["{npc:375}, the priest trainer"] = "{npc:375}，牧师训练师",
	-- {npc:198} Khelden Bremen
	["{npc:198}, the mage trainer, inside the Abbey"] = "{npc:198}，法师训练师，在修道院里",

	-- Step 8: The Defias camp
	["The Defias camp"] = "迪菲亚营地",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["Defias Thugs camp in the clearing east of the Abbey and along the valley's east side."] = "{npc:38}在修道院东边的空地和山谷东侧扎营。",
	-- plural, as words: Red Burlap Bandanas = {item:752} Red Burlap Bandana
	["Red Burlap Bandanas"] = "{item:752}",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}: the {object:83763} in the Defias camp"] = "{item:6785}：迪菲亚营地里的{object:83763}",

	-- Step 10: Milly Osworth
	["She stands by her cart at the vineyard east of the Abbey."] = "她站在修道院东边葡萄园的推车旁。",

	-- Step 11: The vineyards and Garrick Padfoot
	-- {npc:103} Garrick Padfoot
	["The vineyards and {npc:103}"] = "葡萄园和{npc:103}",
	-- {npc:103} Garrick Padfoot
	["The crates of grapes lie in the vineyards behind the Defias. {npc:103} waits by the cabin at the east end of the valley."] = "装葡萄的箱子在迪菲亚身后的葡萄园里。{npc:103}在山谷东端的小屋旁等候。",

	-- Step 13: Kelsey Fargo
	-- {npc:248362} Shinyfinder Narf
	["She stands outside the mine entrance. {npc:248362}, inside, is elite: grouping up is advised."] = "她站在矿洞入口外。里面的{npc:248362}是精英：建议组队。",

	-- Step 14: Inside Echo Ridge Mine
	-- {area:34} Echo Ridge Mine
	["Inside {area:34}"] = "{area:34}里面",
	-- {npc:248362} Shinyfinder Narf
	-- plural, as words: Kobold Laborers = {npc:80} Kobold Laborer
	["Kobold Laborers work the tunnels inside the mine. {npc:248362} waits down the second turn on the right."] = "{npc:80}在矿洞里的隧道中干活。{npc:248362}在右边第二个转弯处等候。",

	-- Step 15: Northshire Abbey
	-- {npc:248415} Tordrin Sternblade
	["{npc:248415} stands behind the Abbey, by the stables."] = "{npc:248415}站在修道院后面的马厩旁。",
	-- {npc:952} Brother Neals
	["{npc:952}, upstairs"] = "{npc:952}，在楼上",
	-- {area:87} Goldshire
	["his kobold tracker shows the kobolds to click on the road to {area:87}"] = "他的狗头人追踪器会显示前往{area:87}路上可点击的狗头人",
	-- {npc:6774} Falkhaan Isenstrider
	["{npc:6774}, by the stables south of the Abbey"] = "{npc:6774}，在修道院南边的马厩旁",

	-- Step 16: Goldshire
	-- {area:87} Goldshire · {npc:295} Innkeeper Farley · {npc:240} Marshal Dughan · {npc:253} William Pestle · {npc:241} Remy "Two Times"
	["Follow the road south out of the valley to {area:87}. {npc:295} is in the Lion's Pride Inn; {npc:240} stands outside the smithy across the road, {npc:253} at the inn's front and {npc:241} by the road south of it."] = "沿道路向南离开山谷到{area:87}。{npc:295}在狮王之傲旅店里；{npc:240}站在路对面的铁匠铺外，{npc:253}在旅店前，{npc:241}在旅店南边的路旁。",

	-- Step 17: The lake shore
	["The lake shore"] = "湖岸",
	-- {npc:263399} Sam Sarsaparilla · {npc:6306} Helene Peltskinner · {npc:383} Jason Mathers · {npc:1651} Lee Brown · {area:18} Crystal Lake
	["{npc:263399} camps north-east of the inn; {npc:6306}, {npc:383} and {npc:1651} stand on the shore of {area:18} east of town."] = "{npc:263399}在旅店东北方扎营；{npc:6306}、{npc:383}和{npc:1651}站在镇子东边的{area:18}岸边。",
	-- {spell:1229451} Boosted Rest
	["Sit (/sit) by his campfire until you have {spell:1229451}"] = "在他的营火旁坐下（/sit），直到获得{spell:1229451}",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}: skinners only, the pelts are skinned"] = "{npc:6306}：仅限剥皮者，毛皮需要剥皮获得",

	-- Step 18: Crystal Lake
	-- plural, as words: Fishing Traps = {object:694772} Fishing Trap
	["The Fishing Traps sit along the west shore of the lake."] = "{object:694772}分布在湖的西岸。",

	-- Step 20: The murloc camp
	["The murloc camp"] = "鱼人营地",
	-- plural, as words: Murloc Streamrunners = {npc:735} Murloc Streamrunner · Junk Piles = {object:694785} Junk Pile
	["Murlocs and Murloc Streamrunners hold the east shore; the Junk Piles lie in their camp."] = "鱼人和{npc:735}占据着东岸；{object:694785}在它们的营地里。",

	-- Step 22: Goldshire
	-- {npc:1430} Tomas
	["{npc:1430} cooks in the inn's kitchen."] = "{npc:1430}在旅店厨房里做饭。",
	-- {npc:1430} Tomas
	["Speak with {npc:1430}"] = "与{npc:1430}交谈",

	-- Step 23: Maybell Maclure
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {npc:251} Maybell Maclure
	["Follow the road south out of {area:87} to the {area:64}. {npc:251} waits by the house."] = "沿道路向南离开{area:87}到{area:64}。{npc:251}在房子旁等候。",

	-- Step 24: The Fargodeep Mine
	-- {npc:248464} Nimsy
	-- plural, as words: Kobold Miners = {npc:40} Kobold Miner
	["The mine is west of the vineyards. Kobold Miners and Tunnelers fill both levels; {npc:248464}, a named kobold, holds the picture book in the lower tunnels. {npc:248464} is elite: grouping up is advised."] = "矿洞在葡萄园西边。{npc:40}和狗头人隧道工遍布两层；名为{npc:248464}的狗头人在下层隧道里拿着绘本。{npc:248464}是精英：建议组队。",
	["Walk through the mine"] = "走过矿洞",
	-- plural, as words: Large Candles = {item:772} Large Candle
	["Large Candles"] = "{item:772}",
	-- plural, as words: Lost Books = {item:248001} Lost Book · Kobold Miners = {npc:40} Kobold Miner
	["Lost Books: Kobold Miners and Tunnelers"] = "{item:248001}：{npc:40}和狗头人隧道工",
	-- {npc:248464} Nimsy
	["Fun with Elementals: {npc:248464}"] = "绘本：和元素一起玩：{npc:248464}",

	-- Step 25: Bait ingredients
	["Bait ingredients"] = "鱼饵材料",
	-- {object:694855} Overgrown Duskweed (no name in this language: may be words)
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood."] = "{object:694855}生长在葡萄园和斯通菲尔德农场周围的田野里；周围的{npc:113}提供血液。",
	-- {item:286215} Vial of Animal Blood
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{item:286215}: Stonetusk Boars"] = "{item:286215}：{npc:113}",

	-- Step 26: The Stonefield Farm
	["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house."] = "斯通菲尔德农场在矿洞西边。斯通菲尔德妈妈和波尼斯·斯通菲尔德姑妈站在房子旁。",

	-- Step 27: Tommy Joe Stonefield
	["He stands by the river west of the farm."] = "他站在农场西边的河旁。",

	-- Step 28: Gramma Stonefield
	["She sits inside the farmhouse."] = "她坐在农舍里。",

	-- Step 29: Billy Maclure
	-- {area:64} Maclure Vineyards
	["Billy plays in the {area:64}, east of the mine."] = "比利·马科伦在矿洞东边的{area:64}玩耍。",

	-- Step 30: Boar meat
	["Boar meat"] = "野猪肉",
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["Stonetusk Boars graze between the vineyards and the farm."] = "{npc:113}在葡萄园和农场之间吃草。",
	["Chunks of Boar Meat"] = "大块野猪肉",

	-- Step 31: "Auntie" Bernice Stonefield
	["\"Auntie\" Bernice Stonefield"] = "波尼斯·斯通菲尔德姑妈",

	-- Step 33: Goldtooth
	-- {quest:87} Goldtooth · {area:57} Fargodeep Mine · {item:1972} Westfall Deed
	-- plural, as words: Defias Bandits = {npc:116} Defias Bandit
	["{quest:87} is inside the {area:57}, not on the hill above it: go in at the mouth and keep left to the back of the mine floor; don't take the stairs up. Defias Bandits around the vineyards drop a {item:1972} now and then: right-click it."] = "{quest:87}在{area:57}里面，不在上方的山丘上：从入口进去，一直靠左走到矿洞底层的最深处；不要上楼梯。葡萄园周围的{npc:116}偶尔会掉落{item:1972}：右键点击它。",

	-- Step 34: Goldshire
	-- {npc:279} Morgan Pestle · {zone:1453} Stormwind
	["{npc:279} in {zone:1453} takes it (02-westfall)"] = "交给{zone:1453}的{npc:279}（02-westfall）",

	-- Step 35: Crystal Lake and the wolves
	-- {area:18} Crystal Lake
	["{area:18} and the wolves"] = "{area:18}和狼",
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler
	["The murlocs on the east shore drop the kelp. Skinners: Gray Forest Wolves roam the woods between the lake and the {area:91}; Prowlers further east give pelts too."] = "东岸的鱼人掉落海草。剥皮者：森林灰狼在湖和{area:91}之间的树林里游荡；更东边的{npc:118}也能剥出毛皮。",
	-- plural, as words: Crystal Kelp Fronds = {item:1256} Crystal Kelp Frond
	["Crystal Kelp Fronds"] = "{item:1256}",

	-- Step 36: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["{npc:248242} and {npc:248248} stand at the foot of the tower."] = "{npc:248242}和{npc:248248}站在塔脚下。",

	-- Step 37: The bridge
	["The bridge"] = "桥",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it."] = "{npc:261}守卫着向东道路上的桥；{npc:248265}就站在桥对面。",

	-- Step 38: Downstream and Princess
	-- {quest:91733} Downstream · {npc:330} Princess
	["{quest:91733} and {npc:330}"] = "{quest:91733}和{npc:330}",
	-- {item:247813} Waterlogged Saw · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch · {npc:390} Porcine Entourage
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way."] = "{item:247813}、浸水的斧头和浸水的工具箱在桥南边的河里。{npc:330}是一头大野猪，和她的{npc:390}在河西边的{area:62}拱地：先把小猪拉开。沿途击杀{npc:118}和{npc:822}。",

	-- Step 40: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "营地在桥的东北方。一捆木柴散落在营地周围和北边的树林里。",

	-- Step 41: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "它躺在伐木场西北方的河边。",

	-- Step 42: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "{npc:474}在{area:86}岸边扎营；它们也掉落{item:1019}。{object:56}在东北岸的鱼人村里。",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "{item:1019}",

	-- Step 43: The gnoll camps
	["The gnoll camps"] = "豺狼人营地",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "河爪豺狼人在{area:86}西边的山丘上扎营；{quest:91725}在它们的营地里。",

	-- Step 44: The Jasperlode Mine's entrance
	-- {quest:76} The Jasperlode Mine
	["{quest:76}'s entrance"] = "{quest:76}的入口",

	-- Step 45: The Jasperlode Mine
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "矿洞在豺狼人营地西南方。{item:247816}在入口附近；{npc:476}占据着隧道。",
	["Walk into the mine"] = "走进矿洞",

	-- Step 46: The Tower of Azora
	["Follow the hills south to the tower."] = "沿山丘向南走到塔。",

	-- Step 48: Goldshire
	-- {area:87} Goldshire · {npc:6306} Helene Peltskinner
	["Follow the road west back to {area:87}; {npc:6306} and Jason stand on the lake shore before town."] = "沿道路向西返回{area:87}；到镇子前，{npc:6306}和贾森·玛瑟斯站在湖岸上。",

	-- Step 49: Maybell Maclure
	-- {area:64} Maclure Vineyards
	["South down the road to the {area:64}."] = "沿道路向南到{area:64}。",

	-- Step 50: The Stonefield Farm
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Shiny Red Apples, from {npc:894}, for the {quest:91736}"] = "{item:4536}，来自{npc:894}，用于{quest:91736}",

	-- Step 51: The Applejack Still
	-- {quest:91736} Applejack Still
	["The {quest:91736}"] = "{quest:91736}",
	-- {quest:91736} Applejack Still · {area:120} Westbrook Garrison · {item:247824} Thunder Applejack
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Head north-west across the fields to the {quest:91736}, north of the {area:120}. Hand it four Shiny Red Apples for a {item:247824}."] = "向西北穿过田野到{area:120}北边的{quest:91736}。交给它四个{item:4536}，换一瓶{item:247824}。",
	-- {item:247824} Thunder Applejack
	["{item:247824}, from the still"] = "{item:247824}，来自蒸馏器",

	-- Step 52: Westbrook Garrison
	-- {area:120} Westbrook Garrison · {zone:1436} Westfall · {npc:963} Deputy Rainer · {npc:955} Sergeant De Vries
	["Back south to the {area:120}, by the road to {zone:1436}. {npc:963} stands outside the barracks, {npc:955} beside him."] = "向南返回通往{zone:1436}的路旁的{area:120}。{npc:963}站在兵营外，{npc:955}在他旁边。",
	-- {npc:955} Sergeant De Vries · {item:247824} Thunder Applejack
	["{npc:955}: he wants your {item:247824}"] = "{npc:955}：他想要你的{item:247824}",

	-- Step 53: Forest's Edge
	-- {zone:1436} Westfall · {npc:100} Gruff Swiftbite · {item:1307} Gold Pickup Schedule
	-- plural, as words: Riverpaw Runts = {npc:97} Riverpaw Runt
	["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border. {npc:100}, a level 12 gnoll, walks among them and carries the {item:1307}: right-click it."] = "{npc:97}和河爪豺狼人前锋占据着要塞南边、{zone:1436}边境沿线的山丘。12级豺狼人{npc:100}在它们中间巡逻，带着{item:1307}：右键点击它。",
	-- plural, as words: Painted Gnoll Armbands = {item:782} Painted Gnoll Armband
	["Painted Gnoll Armbands"] = "{item:782}",

	-- Step 56: Guard Thomas
	-- {area:91} Tower of Azora
	["Follow the road east past the {area:91} to the bridge."] = "沿道路向东经过{area:91}到桥。",

	-- Step 57: Murlocs and the Collector
	["Murlocs and the Collector"] = "鱼人和收藏家",
	-- {npc:473} Morgan the Collector · {area:62} Brackwell Pumpkin Patch
	-- plural, as words: Murloc Foragers = {npc:46} Murloc Forager · Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way."] = "{npc:46}和鱼人潜伏者遍布桥南边的河岸。迪菲亚成员{npc:473}在河西边的{area:62}巡逻。顺路收集完{npc:118}和{npc:822}。",
	-- plural, as words: Torn Murloc Fins = {item:780} Torn Murloc Fin
	["Torn Murloc Fins"] = "{item:780}",

	-- Step 60: Stone Cairn Lake
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["North-east of the logging camp. Defias Rogue Wizards camp on the shores of the lake."] = "在伐木场东北方。{npc:474}在湖岸边扎营。",

	-- Step 61: The Tower of Azora
	["Follow the hills south to the tower, on the road west."] = "沿山丘向南走到塔，就在向西的路上。",

	-- Step 62: Goldshire
	-- {area:87} Goldshire
	["Follow the road west back to {area:87}."] = "沿道路向西返回{area:87}。",
	-- {npc:6121} Remen Marcot · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6121}: {npc:6122} in {zone:1453} takes it"] = "{npc:6121}：交给{zone:1453}的{npc:6122}",
	-- {npc:927} Brother Wilhelm · {npc:6171} Duthorian Rall · {zone:1453} Stormwind
	["{npc:927}: {npc:6171} in {zone:1453} takes it"] = "{npc:927}：交给{zone:1453}的{npc:6171}",
	-- {npc:377} Priestess Josetta · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:377}: {npc:376} in {zone:1453} takes both"] = "{npc:377}：两个都交给{zone:1453}的{npc:376}",
	-- {npc:328} Zaldimar Wefhellt · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{npc:328}: {npc:5497} in {zone:1453} takes it"] = "{npc:328}：交给{zone:1453}的{npc:5497}",

	-- Step 63: Taming the Beast
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {item:15908} Taming Rod · {area:64} Maclure Vineyards · {area:18} Crystal Lake
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar · Young Forest Bears = {npc:822} Young Forest Bear
	["{npc:251507} stands with the {area:87} trainers. Each of her quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her. Rockhide Boars and Young Forest Bears roam the hills south of the {area:64}, Gray Forest Wolves the woods east of {area:18}."] = "{npc:251507}和{area:87}的训练师站在一起。她的每个任务都会给你一根{item:15908}：对她指定的野兽使用，然后把驯兽棒带回给她。{npc:524}和{npc:822}在{area:64}南边的山丘上游荡，森林灰狼在{area:18}东边的树林里。",
	-- {npc:524} Rockhide Boar · {item:15908} Taming Rod
	["{npc:524}: tame it with the {item:15908}"] = "{npc:524}：用{item:15908}驯服它",
	-- {npc:1922} Gray Forest Wolf · {item:15908} Taming Rod
	["{npc:1922}: tame it with the {item:15908}"] = "{npc:1922}：用{item:15908}驯服它",
	-- {npc:822} Young Forest Bear · {item:15908} Taming Rod
	["{npc:822}: tame it with the {item:15908}"] = "{npc:822}：用{item:15908}驯服它",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}，在她旁边：{spell:5149}",

	-- Step 64: Jennea Cannon
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["Follow the road north from {area:87} into {zone:1453}. {npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "沿道路从{area:87}向北进入{zone:1453}。{npc:5497}站在{object:2101}的法师圣殿塔里；她会给你一个瓶子，用于{quest:1861}的瀑布。",

	-- Step 65: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "从正门离开{zone:1453}。{quest:1861}瀑布在城门西南方，就在向西前往{zone:1436}的路上：在瀑布底部装满{item:7207}。",

	-- Step 66: Gakin the Darkbinder
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["Follow the road north from {area:87} into {zone:1453}. {npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "沿道路从{area:87}向北进入{zone:1453}。{npc:6122}在{object:2101}的{object:2164}地下室等候。",

	-- Step 67: Surena Caledon
	-- {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Ride back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "骑马穿过{area:87}，沿道路向东到{area:62}。{npc:881}（9级）站在农舍旁。",

	-- Step 68: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls."] = "回去找{npc:6122}。在{object:2164}地下室的召唤法阵处使用{item:6928}，击败召唤出的虚空行者。",
	["Subdue the voidwalker"] = "制服虚空行者",

	-- Step 69: The Tome of Divinity
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2100} Old Town · {item:2589} Linen Cloth
	["Follow the road north from {area:87} into {zone:1453}. {npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in {object:2100} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "沿道路从{area:87}向北进入{zone:1453}。{npc:6171}和{npc:6173}在光明大教堂；{npc:6174}站在{object:2100}，要十块{item:2589}（人形生物会掉落；拍卖行也有卖）。",
	-- {quest:2998} Tome of Divinity
	["From the {quest:2998} he gives you"] = "从他给你的{quest:2998}获得",

	-- Step 70: Henze Faulk
	-- {area:87} Goldshire · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["Ride back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "骑马穿过{area:87}，向东到{area:86}。{npc:6172}躺在湖南边：对他使用{item:6866}。他周围的{npc:474}带着{item:6846}。",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "对{npc:6172}使用{item:6866}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}：{npc:474}",

	-- Step 71: Gazin Tenorm
	["Back to the Cathedral of Light."] = "回到光明大教堂。",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}：救赎",

	-- Step 72: Sentinel Hill
	-- {zone:1436} Westfall · {area:108} Sentinel Hill
	["Follow the road west past Westbrook into {zone:1436}, then south along it to {area:108}. Thor, the gryphon master, stands on the hill."] = "沿道路向西经过西泉要塞进入{zone:1436}，再沿路向南到{area:108}。狮鹫管理员索尔站在山丘上。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "骑马穿过{area:87}，沿道路向东到{area:62}。{quest:1688}（9级）站在农舍旁。",
	-- ["{area:57}'s mouth"] = "{area:57}的入口",
	-- ["{item:1006}: Princess"] = "{item:1006}：公主",
}
