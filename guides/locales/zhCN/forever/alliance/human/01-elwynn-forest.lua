-- Chinese (simplified) (zhCN): the guide forever/alliance/human/01-elwynn-forest (forever/alliance/human/01-elwynn-forest.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Northshire Abbey
	-- {npc:823} Deputy Willem · {npc:197} Marshal McBride · {npc:951} Brother Paxton · {npc:247229} Daniel · {npc:196} Eagan Peltskinner
	["You start in front of the Abbey. {npc:823} stands at the foot of the steps, {npc:197} inside the hall, {npc:951} and {npc:247229} in the library to the right, {npc:196} outside the north-west corner."] = "你从修道院前方出发。{npc:823}站在台阶下，{npc:197}在大厅里，{npc:951}和{npc:247229}在右边的图书馆，{npc:196}在西北角外面。",
	-- {npc:197} Marshal McBride
	["{npc:197}, inside"] = "{npc:197}，在里面",
	-- {npc:459} Drusilla La Salle
	["{npc:459}, outside the Abbey"] = "{npc:459}，在修道院外",

	-- Step 2: Wolves
	["Wolves"] = "狼",
	["Young Wolves and Timber Wolves roam the fields right around the Abbey."] = "幼狼和森林狼就在修道院周围的田野里游荡。",

	-- Step 3: Deputy Willem
	-- {npc:198} Khelden Bremen
	["Mages: {npc:198}, the mage trainer, stands upstairs in the Abbey: take the stairs inside, the arrow cannot tell the floors apart."] = "法师：法师训练师{npc:198}在修道院楼上：从里面的楼梯上去，箭头无法区分楼层。",
	-- {npc:823} Deputy Willem
	["{npc:823}, back at the Abbey steps"] = "{npc:823}，回到修道院台阶处",

	-- Step 4: The kobold camp
	["The kobold camp"] = "狗头人营地",
	-- {npc:6} Kobold Vermin · {quest:91741} Nibbled-On Book
	["{npc:6} dig in the vineyards north-east of the Abbey. Now and then one drops a {quest:91741}: right-click it."] = "{npc:6}在修道院东北方的葡萄园里挖掘。偶尔会有一只掉落{quest:91741}：右键点击它。",

	-- Step 5: Northshire Abbey
	["Inside"] = "在里面",
	-- {npc:247229} Daniel
	["{npc:247229}, in the library; inside"] = "{npc:247229}，在图书馆里；在里面",

	-- Step 6: Echo Ridge Mine: kill these as you meet them
	-- {area:34} Echo Ridge Mine
	["{area:34}: kill these as you meet them"] = "{area:34}：遇到就击杀",
	-- {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["Follow the path north to the mine. Kobold Workers swarm outside it; every kobold in the valley can drop the {object:83763}."] = "沿小路向北到矿洞。{npc:257}聚集在矿洞外；山谷里的每个狗头人都可能掉落{object:83763}。",

	-- Step 7: Northshire Abbey
	-- {npc:248415} Tordrin Sternblade · {npc:198} Khelden Bremen
	["{npc:248415} stands behind the Abbey, by the stables. {npc:198}, the mage trainer, stands upstairs in the Abbey: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:248415}站在修道院后面的马厩旁。法师训练师{npc:198}在修道院楼上：从里面的楼梯上去，箭头无法区分楼层。",
	-- {npc:911} Llane Beshere
	["{npc:911}, the warrior trainer; inside"] = "{npc:911}，战士训练师；在里面",
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

	-- Step 9: Deputy Willem
	["She stands by her cart at the vineyard east of the Abbey."] = "她站在修道院东边葡萄园的推车旁。",

	-- Step 10: The vineyards and Garrick Padfoot
	-- {npc:103} Garrick Padfoot
	["The vineyards and {npc:103}"] = "葡萄园和{npc:103}",
	-- {npc:103} Garrick Padfoot
	["The crates of grapes lie in the vineyards behind the Defias. {npc:103} waits by the cabin at the east end of the valley."] = "装葡萄的箱子在迪菲亚身后的葡萄园里。{npc:103}在山谷东端的小屋旁等候。",

	-- Step 12: Kelsey Fargo
	-- {npc:248362} Shinyfinder Narf
	["She stands outside the mine entrance. {npc:248362}, inside, is elite: grouping up is advised."] = "她站在矿洞入口外。里面的{npc:248362}是精英：建议组队。",

	-- Step 14: Inside Echo Ridge Mine
	-- {area:34} Echo Ridge Mine
	["Inside {area:34}"] = "{area:34}里面",
	-- {npc:248362} Shinyfinder Narf
	-- plural, as words: Kobold Laborers = {npc:80} Kobold Laborer
	["Kobold Laborers work the tunnels inside the mine. {npc:248362} waits down the second turn on the right."] = "{npc:80}在矿洞里的隧道中干活。{npc:248362}在右边第二个转弯处等候。",
	-- {npc:80} Kobold Laborer · {area:34} Echo Ridge Mine
	["{npc:80} walks around {area:34}: look inside the circle on the map"] = "{npc:80}在{area:34}附近走动：查看地图上的圆圈范围内",

	-- Step 15: Inside Echo Ridge Mine
	-- {npc:248362} Shinyfinder Narf
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:248362} (level 3 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英怪：建议组队，找人一起做。{npc:248362}（3级精英）需要2人小队。如果你独自一人就跳过：路线会让你把经验值刷回来。",

	-- Step 16: Northshire Abbey
	-- {npc:823} Deputy Willem
	["{npc:823}, at the Abbey steps"] = "{npc:823}，在修道院台阶处",
	-- {npc:952} Brother Neals
	["{npc:952}, upstairs"] = "{npc:952}，在楼上",
	-- {npc:6774} Falkhaan Isenstrider
	["{npc:6774}, by the stables south of the Abbey"] = "{npc:6774}，在修道院南边的马厩旁",

	-- Step 17: Northshire Abbey
	-- {area:87} Goldshire
	["his kobold tracker shows the kobolds to click on the road to {area:87}"] = "他的狗头人追踪器会显示前往{area:87}路上可点击的狗头人",

	-- Step 18: Level 5.48
	["Level 5.48"] = "等级5.48",
	-- {quest:91752} The Big Picture
	["If you skipped {quest:91752}, grind here to level 5.48 to stay on the route's plan."] = "如果你跳过了{quest:91752}，在这里刷到5.48级以跟上路线计划。",
	-- {npc:80} Kobold Laborer
	["grind on {npc:80}"] = "刷{npc:80}",

	-- Step 19: Goldshire
	-- {area:87} Goldshire · {npc:240} Marshal Dughan · {npc:241} Remy "Two Times" · {npc:295} Innkeeper Farley · {npc:253} William Pestle
	["Follow the road south out of the valley to {area:87}. {npc:240} stands outside the smithy on the west side of the road, {npc:241} by the road south of it, and {npc:295} and {npc:253} in the Lion's Pride Inn across the road."] = "沿道路向南离开山谷到{area:87}。{npc:240}站在路西侧的铁匠铺外，{npc:241}在铁匠铺南边的路旁，{npc:295}和{npc:253}在路对面的狮王之傲旅店里。",
	-- {npc:295} Innkeeper Farley
	["{npc:295}, inside"] = "{npc:295}，在里面",
	-- {npc:253} William Pestle
	["{npc:253}, inside"] = "{npc:253}，在里面",

	-- Step 22: Level 5.77
	["Level 5.77"] = "等级5.77",
	-- {quest:91752} The Big Picture
	["If you skipped {quest:91752}, grind here to level 5.77 to stay on the route's plan."] = "如果你跳过了{quest:91752}，在这里刷到5.77级以跟上路线计划。",
	-- {npc:40} Kobold Miner
	["grind on {npc:40}"] = "刷{npc:40}",

	-- Step 23: The lake shore
	["The lake shore"] = "湖岸",
	-- {npc:263399} Sam Sarsaparilla · {npc:6306} Helene Peltskinner · {npc:383} Jason Mathers · {npc:1651} Lee Brown · {area:18} Crystal Lake
	["{npc:263399} camps north-east of the inn; {npc:6306}, {npc:383} and {npc:1651} stand on the shore of {area:18} east of town."] = "{npc:263399}在旅店东北方扎营；{npc:6306}、{npc:383}和{npc:1651}站在镇子东边的{area:18}岸边。",
	-- {spell:1229451} Boosted Rest
	["Sit (/sit) by his campfire until you have {spell:1229451}"] = "在他的营火旁坐下（/sit），直到获得{spell:1229451}",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}: skinners only, the pelts are skinned; inside"] = "{npc:6306}：仅限剥皮者，毛皮需剥皮获得；在里面",

	-- Step 24: Crystal Lake
	-- plural, as words: Fishing Traps = {object:694772} Fishing Trap
	["The Fishing Traps sit along the west shore of the lake."] = "{object:694772}分布在湖的西岸。",

	-- Step 26: Crystal Lake: kill these as you meet them
	-- {area:18} Crystal Lake
	["{area:18}: kill these as you meet them"] = "{area:18}：遇到就击杀",
	-- plural, as words: Murloc Streamrunners = {npc:735} Murloc Streamrunner · Junk Piles = {object:694785} Junk Pile
	["Murlocs and Murloc Streamrunners hold the east shore; the Junk Piles lie in their camp."] = "鱼人和{npc:735}占据着东岸；{object:694785}在它们的营地里。",

	-- Step 28: Goldshire
	-- {npc:1430} Tomas · {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["{npc:1430} cooks in the inn's kitchen. {npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:1430}在旅店厨房里做饭。{npc:377}（牧师）、{npc:328}（法师）和{npc:917}（潜行者）在旅店楼上：走室内楼梯上去，箭头无法区分楼层。",
	-- {npc:1430} Tomas
	["{npc:1430}: Camping 101 asks you to learn it; below ground"] = "{npc:1430}：野营入门要求你学会它；在地下",

	-- Step 29: Maybell Maclure
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {npc:251} Maybell Maclure
	["Follow the road south out of {area:87} to the {area:64}. {npc:251} waits by the house."] = "沿道路向南离开{area:87}到{area:64}。{npc:251}在房子旁等候。",

	-- Step 30: Tommy Joe Stonefield
	["He stands by the river west of the farm."] = "他站在农场西边的河旁。",

	-- Step 31: The Stonefield Farm
	["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house.\nShe sits inside the farmhouse."] = "斯通菲尔德农场在矿洞西边。斯通菲尔德妈妈和波尼斯·斯通菲尔德姑妈站在房子旁。\n她坐在农舍里。",

	-- Step 32: Billy Maclure
	-- {area:64} Maclure Vineyards
	["Billy plays in the {area:64}, east of the mine."] = "比利·马科伦在矿洞东边的{area:64}玩耍。",

	-- Step 33: Elwynn Forest: kill these as you meet them
	-- {zone:1429} Elwynn Forest
	["{zone:1429}: kill these as you meet them"] = "{zone:1429}：遇到就杀",
	-- {object:694855} Overgrown Duskweed (no name in this language: may be words)
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood.\nStonetusk Boars graze between the vineyards and the farm."] = "{object:694855}生长在葡萄园和斯通菲尔德农场周围的田野里；周围的石牙野猪提供血液。\n石牙野猪在葡萄园和农场之间吃草。",
	-- {item:286215} Vial of Animal Blood
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{item:286215}: Stonetusk Boars"] = "{item:286215}：{npc:113}",
	["Chunks of Boar Meat"] = "大块野猪肉",

	-- Step 34: "Auntie" Bernice Stonefield
	["\"Auntie\" Bernice Stonefield"] = "波尼斯·斯通菲尔德姑妈",

	-- Step 36: Maclure Vineyards: kill these as you meet them
	-- {area:64} Maclure Vineyards
	["{area:64}: kill these as you meet them"] = "{area:64}：遇到就杀",
	-- {npc:248464} Nimsy
	-- plural, as words: Kobold Miners = {npc:40} Kobold Miner
	["The mine is west of the vineyards. Kobold Miners and Tunnelers fill both levels; {npc:248464}, a named kobold, holds the picture book in the lower tunnels. {npc:248464} is elite: grouping up is advised."] = "矿洞在葡萄园西边。{npc:40}和狗头人隧道工遍布两层；名为{npc:248464}的狗头人在下层隧道里拿着绘本。{npc:248464}是精英：建议组队。",
	["Walk through the mine"] = "走过矿洞",
	-- plural, as words: Large Candles = {item:772} Large Candle
	["Large Candles"] = "{item:772}",

	-- Step 37: Maclure Vineyards: kill these as you meet them
	-- {npc:248464} Nimsy
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:248464} (level 6 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英怪：建议组队，找人一起做。{npc:248464}（6级精英）需要2人小队。如果你独自一人就跳过：路线会让你把经验刷回来。",
	-- plural, as words: Lost Books = {item:248001} Lost Book · Kobold Miners = {npc:40} Kobold Miner
	["Lost Books: Kobold Miners and Tunnelers"] = "{item:248001}：{npc:40}和狗头人隧道工",
	-- {npc:248464} Nimsy
	["Fun with Elementals: {npc:248464}"] = "绘本：和元素一起玩：{npc:248464}",

	-- Step 38: Goldtooth
	-- {quest:87} Goldtooth · {area:57} Fargodeep Mine · {item:1972} Westfall Deed
	-- plural, as words: Defias Bandits = {npc:116} Defias Bandit
	["{quest:87} is inside the {area:57}, not on the hill above it: go in at the mouth and keep left to the back of the mine floor; don't take the stairs up. Defias Bandits around the vineyards drop a {item:1972} now and then: right-click it."] = "{quest:87}在{area:57}里面，不在上方的山丘上：从入口进去，一直靠左走到矿洞底层的最深处；不要上楼梯。葡萄园周围的{npc:116}偶尔会掉落{item:1972}：右键点击它。",
	-- {item:981} Bernice's Necklace
	["{item:981}; below ground"] = "{item:981}；在地下",

	-- Step 39: Goldshire
	-- {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["{npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:377}（牧师）、{npc:328}（法师）和{npc:917}（潜行者）在旅店楼上：走室内楼梯上去，箭头无法区分楼层。",
	-- {npc:279} Morgan Pestle · {zone:1453} Stormwind
	["{npc:279} in {zone:1453} takes it (02-westfall)"] = "交给{zone:1453}的{npc:279}（02-westfall）",

	-- Step 41: Level 8.39
	["Level 8.39"] = "等级 8.39",
	-- {quest:91775} Book Return
	["If you skipped {quest:91775}, grind here to level 8.39 to stay on the route's plan."] = "如果你跳过了{quest:91775}，在这里刷到8.39级以跟上路线计划。",

	-- Step 42: Class trainer
	["Class trainer"] = "职业训练师",

	-- Step 43: Shaman trainer
	["Shaman trainer"] = "萨满祭司训练师",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "{npc:257446}在{zone:1426}；{area:87}没有萨满祭司训练师",

	-- Step 44: Druid trainer
	["Druid trainer"] = "德鲁伊训练师",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "{npc:5504}在{zone:1453}；{area:87}没有德鲁伊训练师",

	-- Step 45: Jason Mathers
	-- {area:87} Goldshire · {npc:383} Jason Mathers
	["Head east out of {area:87} along the lake shore. {npc:383} stands on the shore north-east of town."] = "沿湖岸向东离开{area:87}。{npc:383}站在镇子东北方的湖岸上。",

	-- Step 46: Crystal Lake: kill these as you meet them
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler
	["The murlocs on the east shore drop the kelp. Skinners: Gray Forest Wolves roam the woods between the lake and the {area:91}; Prowlers further east give pelts too."] = "东岸的鱼人掉落海草。剥皮者：森林灰狼在湖和{area:91}之间的树林里游荡；更东边的{npc:118}也能剥出毛皮。",
	-- plural, as words: Crystal Kelp Fronds = {item:1256} Crystal Kelp Frond
	["Crystal Kelp Fronds"] = "{item:1256}",

	-- Step 47: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["{npc:248242} and {npc:248248} stand at the foot of the tower."] = "{npc:248242}和{npc:248248}站在塔脚下。",

	-- Step 48: The bridge
	["The bridge"] = "桥",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it."] = "{npc:261}守卫着向东道路上的桥；{npc:248265}就站在桥对面。",

	-- Step 49: Downstream and Princess
	-- {quest:91733} Downstream · {npc:330} Princess
	["{quest:91733} and {npc:330}"] = "{quest:91733}和{npc:330}",
	-- {item:247813} Waterlogged Saw · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch · {npc:390} Porcine Entourage · {npc:248278} Croaky
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way. Careful: {npc:248278} is a level 11 elite on the murloc shore. Only go for his head with a group or once you're level 10; otherwise leave him: it's optional."] = "{item:247813}、浸水的斧头和浸水的工具箱在桥南边的河里。{npc:330}是一头大野猪，和她的{npc:390}在河西边的{area:62}拱地：先把小猪拉开。沿途击杀觅食的灰狼和森林熊幼崽。小心：{npc:248278}是鱼人河岸上的11级精英。只有组队或达到10级后再去拿他的头；否则别管他：这是可选的。",

	-- Step 50: Croaky
	-- {npc:248278} Croaky · {quest:91740} Croaky's Head
	["{npc:248278} is a level 11 elite on the murloc shore south of the bridge: grouping up is encouraged, look for people to do it with. {quest:91740} needs a group of 2. Skip it if you are alone: the route has you grind the XP back. Right-click the head for its quest."] = "",

	-- Step 52: Level 8.85
	["Level 8.85"] = "等级 8.85",
	-- {quest:91740} Croaky's Head
	["If you skipped {quest:91740}, grind here to level 8.85 to stay on the route's plan."] = "如果你跳过了{quest:91740}，在这里刷到8.85级以跟上路线计划。",
	-- {npc:118} Prowler
	["grind on {npc:118}"] = "刷{npc:118}",

	-- Step 54: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "营地在桥的东北方。一捆木柴散落在营地周围和北边的树林里。",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "{npc:278}，在里面",

	-- Step 55: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "它躺在伐木场西北方的河边。",

	-- Step 56: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "{npc:474}在{area:86}岸边扎营；它们也掉落{item:1019}。{object:56}在东北岸的鱼人村里。",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "{item:1019}",

	-- Step 57: The gnoll camps
	["The gnoll camps"] = "豺狼人营地",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "河爪豺狼人在{area:86}西边的山丘上扎营；{quest:91725}在它们的营地里。",

	-- Step 58: The Jasperlode Mine's entrance
	-- {quest:76} The Jasperlode Mine
	["{quest:76}'s entrance"] = "{quest:76}的入口",

	-- Step 59: Jasperlode Mine: kill these as you meet them
	-- {area:54} Jasperlode Mine
	["{area:54}: kill these as you meet them"] = "{area:54}：遇到就杀",
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "矿洞在豺狼人营地西南方。{item:247816}在入口附近；{npc:476}占据着隧道。",
	["Walk into the mine"] = "走进矿洞",
	-- {npc:476} Kobold Geomancer · {area:54} Jasperlode Mine
	["{npc:476} walks around {area:54}: look inside the circle on the map"] = "{npc:476}在{area:54}附近走动：在地图上的圆圈里找",

	-- Step 60: The Tower of Azora
	["Follow the hills south to the tower."] = "沿山丘向南走到塔。",

	-- Step 61: Guard Thomas
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["Follow the road east past the {area:91} to the bridge. Finish the Prowlers and Young Forest Bears around the river south of it."] = "沿道路向东经过{area:91}到桥。在桥南边的河边杀完觅食的灰狼和森林熊幼崽。",

	-- Step 63: Stone Cairn Lake
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["North-east of the logging camp. Defias Rogue Wizards camp on the shores of the lake."] = "在伐木场东北方。{npc:474}在湖岸边扎营。",

	-- Step 64: The Tower of Azora
	["Follow the hills south to the tower, on the road west."] = "沿山丘向南走到塔，就在向西的路上。",

	-- Step 65: Goldshire
	-- {area:87} Goldshire · {npc:6306} Helene Peltskinner · {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["Follow the road west back to {area:87}; {npc:6306} stands on the lake shore before town. {npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "沿道路向西返回{area:87}；到镇子前，{npc:6306}站在湖岸上。{npc:377}（牧师）、{npc:328}（法师）和{npc:917}（潜行者）在旅店楼上：从里面的楼梯上去，箭头无法区分楼层。",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}, inside"] = "{npc:6306}，在里面",
	-- {npc:240} Marshal Dughan
	["{npc:240}, while William brews"] = "{npc:240}，趁威廉酿酒时",
	-- {npc:514} Smith Argus · {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["{npc:514}, at the smithy: {npc:1416} in {zone:1453} takes it (02-westfall)"] = "{npc:514}，在铁匠铺：交给 {zone:1453} 的 {npc:1416}（02-westfall）",
	-- {npc:377} Priestess Josetta · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:377}: {npc:376} in {zone:1453} takes it"] = "{npc:377}：交给{zone:1453}的{npc:376}",
	-- {npc:328} Zaldimar Wefhellt · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{npc:328}: {npc:5497} in {zone:1453} takes it"] = "{npc:328}：交给{zone:1453}的{npc:5497}",
	-- {npc:6121} Remen Marcot · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6121}: {npc:6122} in {zone:1453} takes it"] = "{npc:6121}：交给{zone:1453}的{npc:6122}",

	-- Step 67: Jennea Cannon
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["Follow the road north from {area:87} into {zone:1453}. {npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "沿道路从{area:87}向北进入{zone:1453}。{npc:5497}站在{object:2101}的法师圣殿塔里；她会给你一个瓶子，用于{quest:1861}的瀑布。",

	-- Step 69: Gakin the Darkbinder
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["Follow the road north from {area:87} into {zone:1453}. {npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "沿道路从{area:87}向北进入{zone:1453}。{npc:6122}在{object:2101}的{object:2164}地下室等候。",

	-- Step 70: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "顺便：向{npc:11867}（{object:2096}，10银币）学习法杖；升级期间，法杖提供的法术属性比单手武器多。",

	-- Step 71: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "从正门离开{zone:1453}。{quest:1861}瀑布在城门西南方，就在向西前往{zone:1436}的路上：在瀑布底部装满{item:7207}。",

	-- Step 72: Surena Caledon
	-- {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Head back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "穿过{area:87}返回，沿路向东到{area:62}。{npc:881}（9级）站在农舍旁。",

	-- Step 73: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls."] = "回去找{npc:6122}。在{object:2164}地下室的召唤法阵处使用{item:6928}，击败召唤出的虚空行者。",
	["Subdue the voidwalker"] = "制服虚空行者",

	-- Step 74: Back to Elwynn Forest
	-- {zone:1429} Elwynn Forest
	["Back to {zone:1429}"] = "返回{zone:1429}",

	-- Step 75: Taming the Beast
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {item:15908} Taming Rod · {area:64} Maclure Vineyards · {area:18} Crystal Lake
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar · Young Forest Bears = {npc:822} Young Forest Bear
	["{npc:251507} stands with the {area:87} trainers. Each of her quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her. Rockhide Boars and Young Forest Bears roam the hills south of the {area:64}, Gray Forest Wolves the woods east of {area:18}."] = "{npc:251507}和{area:87}的训练师站在一起。她的每个任务都会给你一根{item:15908}：对她指定的野兽使用，然后把驯兽棒带回给她。{npc:524}和{npc:822}在{area:64}南边的山丘上游荡，森林灰狼在{area:18}东边的树林里。",
	-- {npc:524} Rockhide Boar · {item:15908} Taming Rod
	["{npc:524}: tame it with the {item:15908}"] = "{npc:524}：用{item:15908}驯服它",
	-- {npc:524} Rockhide Boar
	["Tame {npc:524}"] = "驯服{npc:524}",
	-- {npc:1922} Gray Forest Wolf · {item:15908} Taming Rod
	["{npc:1922}: tame it with the {item:15908}"] = "{npc:1922}：用{item:15908}驯服它",
	-- {npc:1922} Gray Forest Wolf
	["Tame {npc:1922}"] = "驯服{npc:1922}",
	-- {npc:822} Young Forest Bear · {item:15908} Taming Rod
	["{npc:822}: tame it with the {item:15908}"] = "{npc:822}：用{item:15908}驯服它",
	-- {npc:822} Young Forest Bear
	["Tame {npc:822}"] = "驯服{npc:822}",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}，在她旁边：{spell:5149}",

	-- Step 76: Maybell Maclure
	-- {area:64} Maclure Vineyards
	["South down the road to the {area:64}."] = "沿道路向南到{area:64}。",

	-- Step 77: The Stonefield Farm
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["{npc:894} sells the Shiny Red Apples for the {quest:91736}. Apples looted from kobolds and crates count too: the purchase ticks itself once you have four."] = "{npc:894}出售{quest:91736}所需的新鲜的红苹果。从狗头人和箱子拾取的苹果也算：凑够四个后，购买目标会自动完成。",
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Shiny Red Apples, from {npc:894}, for the {quest:91736}"] = "{item:4536}，来自{npc:894}，用于{quest:91736}",

	-- Step 78: The Applejack Still
	-- {quest:91736} Applejack Still
	["The {quest:91736}"] = "{quest:91736}",
	-- {quest:91736} Applejack Still · {area:120} Westbrook Garrison · {item:247824} Thunder Applejack · {npc:955} Sergeant De Vries
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["The {quest:91736} stands north of the {area:120}. Click it with four Shiny Red Apples in your bags: it takes them and gives you a {item:247824} on the spot (the quest never shows in your quest log). Keep the Applejack for {npc:955}: don't drink it."] = "{quest:91736}在{area:120}北边。背包里有四个新鲜的红苹果时点击它：它会收下苹果，当场给你一瓶{item:247824}（该任务不会出现在任务日志中）。把苹果酒留给{npc:955}：不要喝掉。",
	-- {item:247824} Thunder Applejack
	["{item:247824}, from the still"] = "{item:247824}，来自蒸馏器",

	-- Step 79: Westbrook Garrison
	-- {area:120} Westbrook Garrison · {zone:1436} Westfall · {npc:963} Deputy Rainer · {npc:955} Sergeant De Vries · {quest:91738} An Apple Treat · {item:247824} Thunder Applejack
	["Follow the road south to the {area:120}, on the way into {zone:1436}. {npc:963} stands outside the barracks; {npc:955} stands inside. He has {quest:91738} only while you carry the {item:247824}: talk to him and it goes straight to the hand-in."] = "沿道路向南前往{area:120}，这里位于通往{zone:1436}的路上。{npc:963}站在兵营外；{npc:955}在兵营里。只有当你带着{item:247824}时他才有{quest:91738}：与他交谈，任务会直接进入交还阶段。",
	-- {npc:963} Deputy Rainer · {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["{npc:963}: for {npc:234} at {area:108}"] = "{npc:963}：给{area:108}的{npc:234}",
	-- {npc:955} Sergeant De Vries · {item:247824} Thunder Applejack
	["{npc:955}: he wants your {item:247824}; inside"] = "{npc:955}：他要你的{item:247824}；在里面",

	-- Step 80: Forest's Edge
	-- {zone:1436} Westfall
	-- plural, as words: Riverpaw Runts = {npc:97} Riverpaw Runt
	["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border."] = "{npc:97}和河爪豺狼人前锋占据着要塞南边、{zone:1436}边境沿线的山丘。",
	-- plural, as words: Painted Gnoll Armbands = {item:782} Painted Gnoll Armband
	["Painted Gnoll Armbands"] = "{item:782}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to the {area:120}, by the road to {zone:1436}. {npc:963} stands outside the barracks, {npc:955} beside him."] = "向南返回通往{zone:1436}的路旁的{area:120}。{npc:963}站在兵营外，{npc:955}在他旁边。",
	-- ["Back to the Cathedral of Light."] = "回到光明大教堂。",
	-- ["Bait ingredients"] = "鱼饵材料",
	-- ["Boar meat"] = "野猪肉",
	-- ["Follow the road east past the {area:91} to the bridge."] = "沿道路向东经过{area:91}到桥。",
	-- ["Follow the road north from {area:87} into {zone:1453}. {npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in {object:2100} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "沿道路从{area:87}向北进入{zone:1453}。{npc:6171}和{npc:6173}在光明大教堂；{npc:6174}站在{object:2100}，要十块{item:2589}（人形生物会掉落；拍卖行也有卖）。",
	-- ["Follow the road south out of the valley to {area:87}. {npc:295} is in the Lion's Pride Inn; {npc:240} stands outside the smithy across the road, {npc:253} at the inn's front and {npc:241} by the road south of it."] = "沿道路向南离开山谷到{area:87}。{npc:295}在狮王之傲旅店里；{npc:240}站在路对面的铁匠铺外，{npc:253}在旅店前，{npc:241}在旅店南边的路旁。",
	-- ["Follow the road west back to {area:87}."] = "沿道路向西返回{area:87}。",
	-- ["Follow the road west back to {area:87}; {npc:6306} and Jason stand on the lake shore before town."] = "沿道路向西返回{area:87}；到镇子前，{npc:6306}和贾森·玛瑟斯站在湖岸上。",
	-- ["Follow the road west past Westbrook into {zone:1436}, then south along it to {area:108}. {npc:523}, the gryphon master, stands on the hill."] = "沿道路向西经过西泉要塞进入{zone:1436}，再沿路向南到{area:108}。狮鹫管理员{npc:523}站在山丘上。",
	-- ["Follow the road west to the {area:120}, on the way into {zone:1436}. {npc:963} stands outside the barracks."] = "沿路向西前往{area:120}，这里位于通往{zone:1436}的路上。{npc:963}站在兵营外。",
	-- ["From the {quest:2998} he gives you"] = "从他给你的{quest:2998}获得",
	-- ["Head back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "穿过{area:87}返回，向东到{area:86}。{npc:6172}躺在湖南边：对他使用{item:6866}。他周围的{npc:474}带着{item:6846}。",
	-- ["Head north-west across the fields to the {quest:91736}, north of the {area:120}. Hand it four Shiny Red Apples for a {item:247824}."] = "向西北穿过田野到{area:120}北边的{quest:91736}。交给它四个{item:4536}，换一瓶{item:247824}。",
	-- ["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way."] = "{npc:46}和鱼人潜伏者遍布桥南边的河岸。迪菲亚成员{npc:473}在河西边的{area:62}巡逻。顺路收集完{npc:118}和{npc:822}。",
	-- ["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way. {npc:248278} roams the murloc shore too: right-click the head it drops. {npc:248278} is elite: grouping up is advised."] = "鱼人觅食者和鱼人潜伏者遍布桥南边的河岸。迪菲亚成员{npc:473}在河西边的{area:62}巡逻。顺路杀完潜伏者和小森林熊。{npc:248278}也在鱼人河岸游荡：右键点击它掉落的头颅。{npc:248278}是精英：建议组队。",
	-- ["Murlocs and the Collector"] = "鱼人和收藏家",
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "骑马穿过{area:87}，沿道路向东到{area:62}。{npc:881}（9级）站在农舍旁。",
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "骑马穿过{area:87}，沿道路向东到{area:62}。{quest:1688}（9级）站在农舍旁。",
	-- ["Ride back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "骑马穿过{area:87}，向东到{area:86}。{npc:6172}躺在湖南边：对他使用{item:6866}。他周围的{npc:474}带着{item:6846}。",
	-- ["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border. {npc:100}, a level 12 gnoll, walks among them and carries the {item:1307}: right-click it."] = "{npc:97}和河爪豺狼人前锋占据着要塞南边、{zone:1436}边境沿线的山丘。12级豺狼人{npc:100}在它们中间巡逻，带着{item:1307}：右键点击它。",
	-- ["She sits inside the farmhouse."] = "她坐在农舍里。",
	-- ["Speak with {npc:1430}"] = "与{npc:1430}交谈",
	-- ["Stonetusk Boars graze between the vineyards and the farm."] = "{npc:113}在葡萄园和农场之间吃草。",
	-- ["Tame Beast"] = "驯服野兽",
	-- ["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house."] = "斯通菲尔德农场在矿洞西边。斯通菲尔德妈妈和波尼斯·斯通菲尔德姑妈站在房子旁。",
	-- ["The murloc camp"] = "鱼人营地",
	-- ["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way."] = "{item:247813}、浸水的斧头和浸水的工具箱在桥南边的河里。{npc:330}是一头大野猪，和她的{npc:390}在河西边的{area:62}拱地：先把小猪拉开。沿途击杀{npc:118}和{npc:822}。",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:91740} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英怪：建议组队，找人一起做。{quest:91740}需要2人小队。如果你独自一人就跳过：路线会让你把经验刷回来。",
	-- ["Torn Murloc Fins"] = "{item:780}",
	-- ["Use the {item:6866} on {npc:6172}"] = "对{npc:6172}使用{item:6866}",
	-- ["{area:18} and the wolves"] = "{area:18}和狼",
	-- ["{area:57}'s mouth"] = "{area:57}的入口",
	-- ["{item:1006}: Princess"] = "{item:1006}：公主",
	-- ["{item:6846}: Defias Rogue Wizards"] = "{item:6846}：{npc:474}",
	-- ["{npc:1430} cooks in the inn's kitchen."] = "{npc:1430}在旅店厨房里做饭。",
	-- ["{npc:247229}, in the library"] = "{npc:247229}，在图书馆里",
	-- ["{npc:248277} keeps watch at {area:798}, east of the murloc shore. Then head north-west back to the bridge."] = "{npc:248277}在鱼人河岸东边的{area:798}站岗。之后向西北返回桥边。",
	-- ["{npc:248415} stands behind the Abbey, by the stables."] = "{npc:248415}站在修道院后面的马厩旁。",
	-- ["{npc:377}: {npc:376} in {zone:1453} takes both"] = "{npc:377}：两个都交给{zone:1453}的{npc:376}",
	-- ["{npc:6171}: Redemption"] = "{npc:6171}：救赎",
	-- ["{npc:6306}: skinners only, the pelts are skinned"] = "{npc:6306}：仅限剥皮者，毛皮需要剥皮获得",
	-- ["{npc:911}, the warrior trainer"] = "{npc:911}，战士训练师",
	-- ["{npc:927}: {npc:6171} in {zone:1453} takes it"] = "{npc:927}：交给{zone:1453}的{npc:6171}",
	-- ["{npc:955}: he wants your {item:247824}"] = "{npc:955}：他想要你的{item:247824}",
	-- ["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood."] = "{object:694855}生长在葡萄园和斯通菲尔德农场周围的田野里；周围的{npc:113}提供血液。",
}
