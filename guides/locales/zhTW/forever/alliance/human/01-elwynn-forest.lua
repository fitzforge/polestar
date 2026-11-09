-- Chinese (traditional) (zhTW): the guide forever/alliance/human/01-elwynn-forest (forever/alliance/human/01-elwynn-forest.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Northshire Abbey
	-- {npc:823} Deputy Willem · {npc:197} Marshal McBride · {npc:951} Brother Paxton · {npc:247229} Daniel · {npc:196} Eagan Peltskinner
	["You start in front of the Abbey. {npc:823} stands at the foot of the steps, {npc:197} inside the hall, {npc:951} and {npc:247229} in the library to the right, {npc:196} outside the north-west corner."] = "你從修道院前開始。{npc:823}站在台階下，{npc:197}在大廳裡，{npc:951}和{npc:247229}在右側的圖書室，{npc:196}在修道院西北角外。",
	-- {npc:197} Marshal McBride
	["{npc:197}, inside"] = "",
	-- {npc:459} Drusilla La Salle
	["{npc:459}, outside the Abbey"] = "{npc:459}，在修道院外",

	-- Step 2: Wolves
	["Wolves"] = "狼",
	["Young Wolves and Timber Wolves roam the fields right around the Abbey."] = "幼狼和森林狼在修道院周圍的田野遊蕩。",

	-- Step 3: Deputy Willem
	-- {npc:198} Khelden Bremen
	["Mages: {npc:198}, the mage trainer, stands upstairs in the Abbey: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:823} Deputy Willem
	["{npc:823}, back at the Abbey steps"] = "{npc:823}，回到修道院台階",

	-- Step 4: The kobold camp
	["The kobold camp"] = "狗頭人營地",
	-- {npc:6} Kobold Vermin · {quest:91741} Nibbled-On Book
	["{npc:6} dig in the vineyards north-east of the Abbey. Now and then one drops a {quest:91741}: right-click it."] = "{npc:6}在修道院東北方的葡萄園挖掘。偶爾會掉落{quest:91741}：右鍵點擊它。",

	-- Step 5: Northshire Abbey
	["Inside"] = "",
	-- {npc:247229} Daniel
	["{npc:247229}, in the library; inside"] = "",

	-- Step 6: Echo Ridge Mine: kill these as you meet them
	-- {area:34} Echo Ridge Mine
	["{area:34}: kill these as you meet them"] = "",
	-- {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["Follow the path north to the mine. Kobold Workers swarm outside it; every kobold in the valley can drop the {object:83763}."] = "沿著小路向北前往礦坑。狗頭人勞工聚集在礦坑外；山谷中的每個狗頭人都可能掉落{object:83763}。",

	-- Step 7: Northshire Abbey
	-- {npc:248415} Tordrin Sternblade · {npc:198} Khelden Bremen
	["{npc:248415} stands behind the Abbey, by the stables. {npc:198}, the mage trainer, stands upstairs in the Abbey: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:911} Llane Beshere
	["{npc:911}, the warrior trainer; inside"] = "",
	-- {npc:925} Brother Sammuel
	["{npc:925}, the paladin trainer"] = "{npc:925}，聖騎士訓練師",
	-- {npc:248415} Tordrin Sternblade
	["{npc:248415}, by the Abbey"] = "{npc:248415}，在修道院旁",
	-- {npc:915} Jorik Kerridan
	["{npc:915}, the rogue trainer"] = "{npc:915}，盜賊訓練師",
	-- {npc:375} Priestess Anetta
	["{npc:375}, the priest trainer"] = "{npc:375}，牧師訓練師",
	-- {npc:198} Khelden Bremen
	["{npc:198}, the mage trainer, inside the Abbey"] = "{npc:198}，法師訓練師，在修道院內",

	-- Step 8: The Defias camp
	["The Defias camp"] = "迪菲亞營地",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["Defias Thugs camp in the clearing east of the Abbey and along the valley's east side."] = "迪菲亞暴徒在修道院東邊的空地及山谷東側紮營。",
	-- plural, as words: Red Burlap Bandanas = {item:752} Red Burlap Bandana
	["Red Burlap Bandanas"] = "紅色粗麻面罩",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}: the {object:83763} in the Defias camp"] = "{item:6785}：迪菲亞營地裡的{object:83763}",

	-- Step 9: Deputy Willem
	["She stands by her cart at the vineyard east of the Abbey."] = "她站在修道院東邊葡萄園的推車旁。",

	-- Step 10: The vineyards and Garrick Padfoot
	-- {npc:103} Garrick Padfoot
	["The vineyards and {npc:103}"] = "葡萄園與{npc:103}",
	-- {npc:103} Garrick Padfoot
	["The crates of grapes lie in the vineyards behind the Defias. {npc:103} waits by the cabin at the east end of the valley."] = "裝葡萄的箱子在迪菲亞後方的葡萄園裡。{npc:103}在山谷東端的小屋旁等候。",

	-- Step 12: Kelsey Fargo
	-- {npc:248362} Shinyfinder Narf
	["She stands outside the mine entrance. {npc:248362}, inside, is elite: grouping up is advised."] = "她站在礦坑入口外。裡面的{npc:248362}是精英：建議組隊。",

	-- Step 14: Inside Echo Ridge Mine
	-- {area:34} Echo Ridge Mine
	["Inside {area:34}"] = "{area:34}內部",
	-- {npc:248362} Shinyfinder Narf
	-- plural, as words: Kobold Laborers = {npc:80} Kobold Laborer
	["Kobold Laborers work the tunnels inside the mine. {npc:248362} waits down the second turn on the right."] = "狗頭人苦力在礦坑隧道裡工作。{npc:248362}在右邊第二個轉角深處等著。",
	-- {npc:80} Kobold Laborer · {area:34} Echo Ridge Mine
	["{npc:80} walks around {area:34}: look inside the circle on the map"] = "",

	-- Step 15: Inside Echo Ridge Mine
	-- {npc:248362} Shinyfinder Narf
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:248362} (level 3 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 16: Northshire Abbey
	-- {npc:823} Deputy Willem
	["{npc:823}, at the Abbey steps"] = "",
	-- {npc:952} Brother Neals
	["{npc:952}, upstairs"] = "{npc:952}，在樓上",
	-- {npc:6774} Falkhaan Isenstrider
	["{npc:6774}, by the stables south of the Abbey"] = "{npc:6774}，在修道院南邊的馬廄旁",

	-- Step 17: Northshire Abbey
	-- {area:87} Goldshire
	["his kobold tracker shows the kobolds to click on the road to {area:87}"] = "他的狗頭人追蹤器會標出通往{area:87}路上可點擊的狗頭人",

	-- Step 18: Level 5.48
	["Level 5.48"] = "",
	-- {quest:91752} The Big Picture
	["If you skipped {quest:91752}, grind here to level 5.48 to stay on the route's plan."] = "",
	-- {npc:80} Kobold Laborer
	["grind on {npc:80}"] = "",

	-- Step 19: Goldshire
	-- {area:87} Goldshire · {npc:240} Marshal Dughan · {npc:241} Remy "Two Times" · {npc:295} Innkeeper Farley · {npc:253} William Pestle
	["Follow the road south out of the valley to {area:87}. {npc:240} stands outside the smithy on the west side of the road, {npc:241} by the road south of it, and {npc:295} and {npc:253} in the Lion's Pride Inn across the road."] = "",
	-- {npc:295} Innkeeper Farley
	["{npc:295}, inside"] = "",
	-- {npc:253} William Pestle
	["{npc:253}, inside"] = "",

	-- Step 22: Level 5.77
	["Level 5.77"] = "",
	-- {quest:91752} The Big Picture
	["If you skipped {quest:91752}, grind here to level 5.77 to stay on the route's plan."] = "",
	-- {npc:40} Kobold Miner
	["grind on {npc:40}"] = "",

	-- Step 23: The lake shore
	["The lake shore"] = "湖岸",
	-- {npc:263399} Sam Sarsaparilla · {npc:6306} Helene Peltskinner · {npc:383} Jason Mathers · {npc:1651} Lee Brown · {area:18} Crystal Lake
	["{npc:263399} camps north-east of the inn; {npc:6306}, {npc:383} and {npc:1651} stand on the shore of {area:18} east of town."] = "{npc:263399}在旅店東北方紮營；{npc:6306}、{npc:383}和{npc:1651}站在鎮東{area:18}的岸邊。",
	-- {spell:1229451} Boosted Rest
	["Sit (/sit) by his campfire until you have {spell:1229451}"] = "在他的營火旁坐下（/sit），直到獲得{spell:1229451}",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}: skinners only, the pelts are skinned; inside"] = "",

	-- Step 24: Crystal Lake
	-- plural, as words: Fishing Traps = {object:694772} Fishing Trap
	["The Fishing Traps sit along the west shore of the lake."] = "捕魚陷阱沿著湖的西岸分布。",

	-- Step 26: Crystal Lake: kill these as you meet them
	-- {area:18} Crystal Lake
	["{area:18}: kill these as you meet them"] = "",
	-- plural, as words: Murloc Streamrunners = {npc:735} Murloc Streamrunner · Junk Piles = {object:694785} Junk Pile
	["Murlocs and Murloc Streamrunners hold the east shore; the Junk Piles lie in their camp."] = "魚人和魚人士兵佔據東岸；垃圾堆在牠們的營地裡。",

	-- Step 28: Goldshire
	-- {npc:1430} Tomas · {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["{npc:1430} cooks in the inn's kitchen. {npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:1430} Tomas
	["{npc:1430}: Camping 101 asks you to learn it; below ground"] = "",

	-- Step 29: Maybell Maclure
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {npc:251} Maybell Maclure
	["Follow the road south out of {area:87} to the {area:64}. {npc:251} waits by the house."] = "沿著道路向南離開{area:87}，前往{area:64}。{npc:251}在房子旁等候。",

	-- Step 30: Tommy Joe Stonefield
	["He stands by the river west of the farm."] = "他站在農場西邊的河邊。",

	-- Step 31: The Stonefield Farm
	["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house.\nShe sits inside the farmhouse."] = "",

	-- Step 32: Billy Maclure
	-- {area:64} Maclure Vineyards
	["Billy plays in the {area:64}, east of the mine."] = "比利在礦坑東邊的{area:64}玩耍。",

	-- Step 33: Elwynn Forest: kill these as you meet them
	-- {zone:1429} Elwynn Forest
	["{zone:1429}: kill these as you meet them"] = "",
	-- {object:694855} Overgrown Duskweed
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood.\nStonetusk Boars graze between the vineyards and the farm."] = "",
	-- {item:286215} Vial of Animal Blood
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{item:286215}: Stonetusk Boars"] = "{item:286215}：石牙野豬",
	["Chunks of Boar Meat"] = "大塊野豬肉",

	-- Step 34: "Auntie" Bernice Stonefield
	["\"Auntie\" Bernice Stonefield"] = "波尼斯·斯通菲爾德姑媽",

	-- Step 36: Maclure Vineyards: kill these as you meet them
	-- {area:64} Maclure Vineyards
	["{area:64}: kill these as you meet them"] = "",
	-- {npc:248464} Nimsy
	-- plural, as words: Kobold Miners = {npc:40} Kobold Miner
	["The mine is west of the vineyards. Kobold Miners and Tunnelers fill both levels; {npc:248464}, a named kobold, holds the picture book in the lower tunnels. {npc:248464} is elite: grouping up is advised."] = "礦坑在葡萄園西邊。狗頭人礦工和狗頭人隧道工遍布上下兩層；有名字的狗頭人{npc:248464}拿著圖畫書，在下層隧道裡。{npc:248464}是精英：建議組隊。",
	["Walk through the mine"] = "穿過礦坑",
	-- plural, as words: Large Candles = {item:772} Large Candle
	["Large Candles"] = "大蠟燭",

	-- Step 37: Maclure Vineyards: kill these as you meet them
	-- {npc:248464} Nimsy
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:248464} (level 6 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",
	-- plural, as words: Lost Books = {item:248001} Lost Book · Kobold Miners = {npc:40} Kobold Miner
	["Lost Books: Kobold Miners and Tunnelers"] = "遺失的書：狗頭人礦工和狗頭人隧道工",
	-- {npc:248464} Nimsy
	["Fun with Elementals: {npc:248464}"] = "快樂玩元素：{npc:248464}",

	-- Step 38: Goldtooth
	-- {quest:87} Goldtooth · {area:57} Fargodeep Mine · {item:1972} Westfall Deed
	-- plural, as words: Defias Bandits = {npc:116} Defias Bandit
	["{quest:87} is inside the {area:57}, not on the hill above it: go in at the mouth and keep left to the back of the mine floor; don't take the stairs up. Defias Bandits around the vineyards drop a {item:1972} now and then: right-click it."] = "{quest:87}在{area:57}裡面，不在上方的山丘上：從入口進去，靠左走到礦坑底層的最深處；不要走樓梯上去。葡萄園周圍的迪菲亞強盜偶爾會掉落{item:1972}：右鍵點擊它。",
	-- {item:981} Bernice's Necklace
	["{item:981}; below ground"] = "",

	-- Step 39: Goldshire
	-- {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["{npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:279} Morgan Pestle · {zone:1453} Stormwind
	["{npc:279} in {zone:1453} takes it (02-westfall)"] = "{zone:1453}的{npc:279}接收此任務（02-westfall）",

	-- Step 41: Level 8.39
	["Level 8.39"] = "",
	-- {quest:91775} Book Return
	["If you skipped {quest:91775}, grind here to level 8.39 to stay on the route's plan."] = "",

	-- Step 42: Class trainer
	["Class trainer"] = "",

	-- Step 43: Shaman trainer
	["Shaman trainer"] = "",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "",

	-- Step 44: Druid trainer
	["Druid trainer"] = "",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "",

	-- Step 45: Jason Mathers
	-- {area:87} Goldshire · {npc:383} Jason Mathers
	["Head east out of {area:87} along the lake shore. {npc:383} stands on the shore north-east of town."] = "",

	-- Step 46: Crystal Lake: kill these as you meet them
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler
	["The murlocs on the east shore drop the kelp. Skinners: Gray Forest Wolves roam the woods between the lake and the {area:91}; Prowlers further east give pelts too."] = "東岸的魚人會掉落海藻。剝皮者：森林灰狼在湖與{area:91}之間的樹林遊蕩；更東邊的覓食的灰狼也能剝下毛皮。",
	-- plural, as words: Crystal Kelp Fronds = {item:1256} Crystal Kelp Frond
	["Crystal Kelp Fronds"] = "水晶藻葉",

	-- Step 47: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["{npc:248242} and {npc:248248} stand at the foot of the tower."] = "{npc:248242}和{npc:248248}站在塔底。",

	-- Step 48: The bridge
	["The bridge"] = "橋",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it."] = "{npc:261}守衛東邊道路上的橋；{npc:248265}就站在橋的另一頭。",

	-- Step 49: Downstream and Princess
	-- {quest:91733} Downstream · {npc:330} Princess
	["{quest:91733} and {npc:330}"] = "{quest:91733}與{npc:330}",
	-- {item:247813} Waterlogged Saw · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch · {npc:390} Porcine Entourage · {npc:248278} Croaky
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way. Careful: {npc:248278} is a level 11 elite on the murloc shore. Only go for his head with a group or once you're level 10; otherwise leave him: it's optional."] = "",

	-- Step 50: Croaky
	-- {npc:248278} Croaky · {quest:91740} Croaky's Head
	["{npc:248278} is a level 11 elite on the murloc shore south of the bridge: grouping up is encouraged, look for people to do it with. {quest:91740} needs a group of 2. Skip it if you are alone: the route has you grind the XP back. Right-click the head for its quest."] = "",

	-- Step 52: Level 8.85
	["Level 8.85"] = "",
	-- {quest:91740} Croaky's Head
	["If you skipped {quest:91740}, grind here to level 8.85 to stay on the route's plan."] = "",
	-- {npc:118} Prowler
	["grind on {npc:118}"] = "",

	-- Step 54: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "營地在橋的東北方。一捆木柴散落在營地周圍及其北邊的樹林裡。",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "",

	-- Step 55: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "它躺在伐木場西北方的河邊。",

	-- Step 56: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "迪菲亞流浪巫師在{area:86}岸邊紮營；他們也會掉落紅色亞麻面罩。{object:56}在東北岸的魚人村裡。",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "紅色亞麻面罩",

	-- Step 57: The gnoll camps
	["The gnoll camps"] = "豺狼人營地",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "河爪豺狼人在{area:86}西邊的山丘紮營；{quest:91725}就在他們的營地裡。",

	-- Step 58: The Jasperlode Mine's entrance
	-- {quest:76} The Jasperlode Mine
	["{quest:76}'s entrance"] = "{quest:76}入口",

	-- Step 59: Jasperlode Mine: kill these as you meet them
	-- {area:54} Jasperlode Mine
	["{area:54}: kill these as you meet them"] = "",
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "礦坑在豺狼人營地西南方。{item:247816}在入口附近；狗頭人地卜師佔據隧道。",
	["Walk into the mine"] = "走進礦坑",
	-- {npc:476} Kobold Geomancer · {area:54} Jasperlode Mine
	["{npc:476} walks around {area:54}: look inside the circle on the map"] = "",

	-- Step 60: The Tower of Azora
	["Follow the hills south to the tower."] = "沿著山丘向南走到塔。",

	-- Step 61: Guard Thomas
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["Follow the road east past the {area:91} to the bridge. Finish the Prowlers and Young Forest Bears around the river south of it."] = "",

	-- Step 63: Stone Cairn Lake
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["North-east of the logging camp. Defias Rogue Wizards camp on the shores of the lake."] = "在伐木場東北方。迪菲亞流浪巫師在湖岸邊紮營。",

	-- Step 64: The Tower of Azora
	["Follow the hills south to the tower, on the road west."] = "沿著山丘向南走到塔，在往西的路上。",

	-- Step 65: Goldshire
	-- {area:87} Goldshire · {npc:6306} Helene Peltskinner · {npc:377} Priestess Josetta · {npc:328} Zaldimar Wefhellt · {npc:917} Keryn Sylvius
	["Follow the road west back to {area:87}; {npc:6306} stands on the lake shore before town. {npc:377} (priests), {npc:328} (mages) and {npc:917} (rogues) stand upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}, inside"] = "",
	-- {npc:240} Marshal Dughan
	["{npc:240}, while William brews"] = "",
	-- {npc:514} Smith Argus · {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["{npc:514}, at the smithy: {npc:1416} in {zone:1453} takes it (02-westfall)"] = "",
	-- {npc:377} Priestess Josetta · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:377}: {npc:376} in {zone:1453} takes it"] = "",
	-- {npc:328} Zaldimar Wefhellt · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{npc:328}: {npc:5497} in {zone:1453} takes it"] = "{npc:328}：由{zone:1453}的{npc:5497}接收",
	-- {npc:6121} Remen Marcot · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6121}: {npc:6122} in {zone:1453} takes it"] = "{npc:6121}：由{zone:1453}的{npc:6122}接收",

	-- Step 67: Jennea Cannon
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["Follow the road north from {area:87} into {zone:1453}. {npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "沿著道路從{area:87}向北進入{zone:1453}。{npc:5497}站在{object:2101}的高塔裡；她會給你一個瓶子，用於{quest:1861}瀑布。",

	-- Step 69: Gakin the Darkbinder
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["Follow the road north from {area:87} into {zone:1453}. {npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "沿著道路從{area:87}向北進入{zone:1453}。{npc:6122}在{object:2101}的{object:2164}地下室等候。",

	-- Step 70: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 71: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "從正門離開{zone:1453}。{quest:1861}瀑布在城門西南方，位於往西前往{zone:1436}的路上：在瀑布底部裝滿{item:7207}。",

	-- Step 72: Surena Caledon
	-- {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Head back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "穿過{area:87}返回，沿路向東到{area:62}。{npc:881}（9級）站在農舍旁。",

	-- Step 73: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls."] = "回到{npc:6122}那裡。在{object:2164}地下室的召喚法陣使用{item:6928}，擊敗被召喚出的虛空行者。",
	["Subdue the voidwalker"] = "制服虛空行者",

	-- Step 74: Back to Elwynn Forest
	-- {zone:1429} Elwynn Forest
	["Back to {zone:1429}"] = "",

	-- Step 75: Taming the Beast
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {item:15908} Taming Rod · {area:64} Maclure Vineyards · {area:18} Crystal Lake
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar · Young Forest Bears = {npc:822} Young Forest Bear
	["{npc:251507} stands with the {area:87} trainers. Each of her quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her. Rockhide Boars and Young Forest Bears roam the hills south of the {area:64}, Gray Forest Wolves the woods east of {area:18}."] = "{npc:251507}和{area:87}的訓練師們站在一起。她的每個任務都會給你一根{item:15908}：對她指定的野獸使用，然後把馴獸棒帶回給她。石皮野豬和小森林熊在{area:64}南邊的山丘遊蕩，森林灰狼在{area:18}東邊的樹林裡。",
	-- {npc:524} Rockhide Boar · {item:15908} Taming Rod
	["{npc:524}: tame it with the {item:15908}"] = "{npc:524}：用{item:15908}馴服牠",
	-- {npc:524} Rockhide Boar
	["Tame {npc:524}"] = "",
	-- {npc:1922} Gray Forest Wolf · {item:15908} Taming Rod
	["{npc:1922}: tame it with the {item:15908}"] = "{npc:1922}：用{item:15908}馴服牠",
	-- {npc:1922} Gray Forest Wolf
	["Tame {npc:1922}"] = "",
	-- {npc:822} Young Forest Bear · {item:15908} Taming Rod
	["{npc:822}: tame it with the {item:15908}"] = "{npc:822}：用{item:15908}馴服牠",
	-- {npc:822} Young Forest Bear
	["Tame {npc:822}"] = "",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}，在她旁邊：{spell:5149}",

	-- Step 76: Maybell Maclure
	-- {area:64} Maclure Vineyards
	["South down the road to the {area:64}."] = "沿著道路向南前往{area:64}。",

	-- Step 77: The Stonefield Farm
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["{npc:894} sells the Shiny Red Apples for the {quest:91736}. Apples looted from kobolds and crates count too: the purchase ticks itself once you have four."] = "",
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Shiny Red Apples, from {npc:894}, for the {quest:91736}"] = "新鮮的紅蘋果，向{npc:894}取得，用於{quest:91736}",

	-- Step 78: The Applejack Still
	-- {quest:91736} Applejack Still
	["The {quest:91736}"] = "{quest:91736}",
	-- {quest:91736} Applejack Still · {area:120} Westbrook Garrison · {item:247824} Thunder Applejack · {npc:955} Sergeant De Vries
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["The {quest:91736} stands north of the {area:120}. Click it with four Shiny Red Apples in your bags: it takes them and gives you a {item:247824} on the spot (the quest never shows in your quest log). Keep the Applejack for {npc:955}: don't drink it."] = "",
	-- {item:247824} Thunder Applejack
	["{item:247824}, from the still"] = "{item:247824}，來自蒸餾器",

	-- Step 79: Westbrook Garrison
	-- {area:120} Westbrook Garrison · {zone:1436} Westfall · {npc:963} Deputy Rainer · {npc:955} Sergeant De Vries · {quest:91738} An Apple Treat · {item:247824} Thunder Applejack
	["Follow the road south to the {area:120}, on the way into {zone:1436}. {npc:963} stands outside the barracks; {npc:955} stands inside. He has {quest:91738} only while you carry the {item:247824}: talk to him and it goes straight to the hand-in."] = "",
	-- {npc:963} Deputy Rainer · {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["{npc:963}: for {npc:234} at {area:108}"] = "{npc:963}：給{area:108}的{npc:234}",
	-- {npc:955} Sergeant De Vries · {item:247824} Thunder Applejack
	["{npc:955}: he wants your {item:247824}; inside"] = "",

	-- Step 80: Forest's Edge
	-- {zone:1436} Westfall
	-- plural, as words: Riverpaw Runts = {npc:97} Riverpaw Runt
	["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border."] = "",
	-- plural, as words: Painted Gnoll Armbands = {item:782} Painted Gnoll Armband
	["Painted Gnoll Armbands"] = "彩色豺狼人臂章",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to the {area:120}, by the road to {zone:1436}. {npc:963} stands outside the barracks, {npc:955} beside him."] = "向南回到{area:120}，在通往{zone:1436}的路旁。{npc:963}站在兵營外，{npc:955}在他旁邊。",
	-- ["Back to the Cathedral of Light."] = "回到光明大教堂。",
	-- ["Bait ingredients"] = "誘餌材料",
	-- ["Boar meat"] = "野豬肉",
	-- ["Follow the road east past the {area:91} to the bridge."] = "沿著道路向東經過{area:91}走到橋邊。",
	-- ["Follow the road north from {area:87} into {zone:1453}. {npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in {object:2100} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "沿著道路從{area:87}向北進入{zone:1453}。{npc:6171}和{npc:6173}在光明大教堂裡；{npc:6174}站在{object:2100}，向你要十塊{item:2589}（人型生物會掉落；拍賣場也有賣）。",
	-- ["Follow the road south out of the valley to {area:87}. {npc:295} is in the Lion's Pride Inn; {npc:240} stands outside the smithy across the road, {npc:253} at the inn's front and {npc:241} by the road south of it."] = "沿著道路向南離開山谷前往{area:87}。{npc:295}在旅店裡；{npc:240}站在路對面的鐵匠鋪外，{npc:253}在旅店門前，{npc:241}在旅店南邊的路旁。",
	-- ["Follow the road west back to {area:87}."] = "沿著道路向西回到{area:87}。",
	-- ["Follow the road west back to {area:87}; {npc:6306} and Jason stand on the lake shore before town."] = "沿著道路向西回到{area:87}；{npc:6306}和傑生站在城鎮前的湖岸邊。",
	-- ["Follow the road west past Westbrook into {zone:1436}, then south along it to {area:108}. {npc:523}, the gryphon master, stands on the hill."] = "沿著道路向西經過西泉要塞進入{zone:1436}，再沿路向南前往{area:108}。獅鷲管理員{npc:523}站在山丘上。",
	-- ["Follow the road west to the {area:120}, on the way into {zone:1436}. {npc:963} stands outside the barracks."] = "沿路向西到{area:120}，途中進入{zone:1436}。{npc:963}站在兵營外面。",
	-- ["From the {quest:2998} he gives you"] = "來自他給你的{quest:2998}",
	-- ["Head back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "穿過{area:87}返回，向東到{area:86}。{npc:6172}躺在湖南邊：對他使用{item:6866}。他周圍的{npc:474}帶著{item:6846}。",
	-- ["Head north-west across the fields to the {quest:91736}, north of the {area:120}. Hand it four Shiny Red Apples for a {item:247824}."] = "向西北穿過田野前往{area:120}北邊的{quest:91736}。交給它四個新鮮的紅蘋果，換取{item:247824}。",
	-- ["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way."] = "魚人強盜和魚人潛伏者分布在橋南邊的河岸。迪菲亞的{npc:473}在橋西邊的{area:62}走動。沿途把覓食的灰狼和小森林熊殺完。",
	-- ["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way. {npc:248278} roams the murloc shore too: right-click the head it drops. {npc:248278} is elite: grouping up is advised."] = "魚人強盜和魚人潛伏者分布在橋南邊的河岸。迪菲亞的{npc:473}在橋西邊的{area:62}走動。沿途把覓食的灰狼和小森林熊殺完。{npc:248278}也在魚人河岸遊蕩：右鍵點擊牠掉落的頭顱。{npc:248278}是精英：建議組隊。",
	-- ["Murlocs and the Collector"] = "魚人與收藏家",
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "騎馬穿過{area:87}，沿著道路向東前往{area:62}。{npc:881}（等級9）站在農舍旁。",
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "騎馬穿過{area:87}，沿著道路向東前往{area:62}。{quest:1688}（等級9）站在農舍旁。",
	-- ["Ride back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "騎馬穿過{area:87}，向東前往{area:86}。{npc:6172}躺在湖的南邊：對他使用{item:6866}。他周圍的迪菲亞流浪巫師身上帶著{item:6846}。",
	-- ["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border. {npc:100}, a level 12 gnoll, walks among them and carries the {item:1307}: right-click it."] = "矮小的河爪豺狼人和河爪豺狼人前鋒佔據要塞南邊、沿著{zone:1436}邊界的山丘。{npc:100}是一個12級的豺狼人，在牠們之中走動，身上帶著{item:1307}：右鍵點擊它。",
	-- ["She sits inside the farmhouse."] = "她坐在農舍裡。",
	-- ["Speak with {npc:1430}"] = "與{npc:1430}交談",
	-- ["Stonetusk Boars graze between the vineyards and the farm."] = "石牙野豬在葡萄園和農場之間覓食。",
	-- ["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house."] = "斯通菲爾德農場在礦坑西邊。斯通菲爾德媽媽和波尼斯·斯通菲爾德姑媽站在房子旁。",
	-- ["The murloc camp"] = "魚人營地",
	-- ["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way."] = "{item:247813}、浸水的斧頭和浸水的工具箱在橋南邊的河裡。{npc:330}是一頭大野豬，和她的{npc:390}在河西邊的{area:62}拱土：先把小豬引開。沿途擊殺覓食的灰狼和小森林熊。",
	-- ["Torn Murloc Fins"] = "破損的魚人鱗片",
	-- ["Use the {item:6866} on {npc:6172}"] = "對{npc:6172}使用{item:6866}",
	-- ["{area:18} and the wolves"] = "{area:18}與狼群",
	-- ["{area:57}'s mouth"] = "{area:57}入口",
	-- ["{item:1006}: Princess"] = "{item:1006}：公主",
	-- ["{item:6846}: Defias Rogue Wizards"] = "{item:6846}：迪菲亞流浪巫師",
	-- ["{npc:1430} cooks in the inn's kitchen."] = "{npc:1430}在旅店廚房裡做菜。",
	-- ["{npc:247229}, in the library"] = "{npc:247229}，在圖書室",
	-- ["{npc:248277} keeps watch at {area:798}, east of the murloc shore. Then head north-west back to the bridge."] = "{npc:248277}在魚人河岸東邊的{area:798}站崗。之後往西北回到橋邊。",
	-- ["{npc:248415} stands behind the Abbey, by the stables."] = "{npc:248415}站在修道院後方的馬廄旁。",
	-- ["{npc:377}: {npc:376} in {zone:1453} takes both"] = "{npc:377}：兩個都由{zone:1453}的{npc:376}接收",
	-- ["{npc:6171}: Redemption"] = "{npc:6171}：救贖",
	-- ["{npc:6306}: skinners only, the pelts are skinned"] = "{npc:6306}：僅限剝皮者，毛皮需剝皮取得",
	-- ["{npc:911}, the warrior trainer"] = "{npc:911}，戰士訓練師",
	-- ["{npc:927}: {npc:6171} in {zone:1453} takes it"] = "{npc:927}：由{zone:1453}的{npc:6171}接收",
	-- ["{npc:955}: he wants your {item:247824}"] = "{npc:955}：他要你的{item:247824}",
	-- ["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood."] = "{object:694855}生長在葡萄園和斯通菲爾德農場周圍的田野；附近的石牙野豬提供血液。",
}
