-- Chinese (simplified) (zhCN): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Theramore
	["Theramore"] = "塞拉摩",
	-- {quest:1260} Morgan Stern · {npc:4897} Helenia Olden
	["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260}站在旅店附近；往南几步的商人{npc:4897}出售加尔要的香料。",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}，交给“沼泽之眼”加尔",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "沿道路向西北离开塞拉摩，前往{area:503}的瞭望塔。泥石穴居龟在周围的沼泽中游荡。",

	-- Step 3: Archmage Tervosh
	-- {area:514} Foothold Citadel
	["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "回到塞拉摩：特沃什和吉安娜女士在{area:514}的塔里等候。",

	-- Step 4: Swamplight Manor
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house."] = "沿道路向北前往废弃的庄园；加尔住在旁边的棚屋里，松土就在房子的拐角处。",
	["with the spices from Theramore"] = "带上从塞拉摩买的香料",

	-- Step 5: Mudrock tortoises
	["Mudrock tortoises"] = "泥石海龟",
	-- plural, as words: Mudrock Tortoises = {npc:4396} Mudrock Tortoise
	["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "泥石海龟和泥石刺壳龟在庄园东北方的岸边晒太阳。",

	-- Step 6: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "伊格纳兹",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "伊格纳兹在庄园西边、{area:504}下方的沼泽中等候。带他去找Bogbean叶子，别让沼泽生物靠近他。",

	-- Step 7: North Point Tower
	-- {npc:4966} Private Hendel
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966}和几个逃兵占据着塔楼。他会攻击你：打到他投降为止。",

	-- Step 8: Darkmist Cavern
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "黑雾蜘蛛在沼泽西北部的洞穴周围筑巢；每只蜘蛛都会掉落眼睛。",

	-- Step 9: Mudcrush Durtfeet
	["Ride south to the giant's hut in the middle of the marsh."] = "向南骑行到沼泽中央巨人的小屋。",

	-- Step 10: The Shady Rest Inn
	-- {zone:1413} Barrens
	["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "烧毁的旅店在向西通往{zone:1413}的路上；卫兵的徽章在灰烬中，蹄印在旅店旁的泥地里。",

	-- Step 11: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "沿道路向东返回塞拉摩。特沃什、吉安娜女士和军官们在塔楼和{area:514}里。",

	-- Step 12: Mirefin murlocs
	["Mirefin murlocs"] = "黑鳍鱼人",
	-- {area:497} Swamplight Manor
	["The Mirefin murlocs crowd the north coast past {area:497}; finish the tongues on the tortoises beside them."] = "黑鳍鱼人聚集在{area:497}以外的北部海岸；在旁边的海龟身上收集完舌头。",

	-- Step 13: Swamplight Manor
	-- {item:3853} Moonsteel Broadsword
	["only if you carry a {item:3853} (a blacksmith's craft)"] = "仅当你携带{item:3853}（铁匠制造品）时",

	-- Step 15: Balos Jacken
	-- {npc:4503} Mudcrush Durtfeet
	["The deserters camp south of the road, west of {npc:4503}'s hut."] = "逃兵在道路南边、{npc:4503}小屋西边扎营。",

	-- Step 17: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {area:391} Merchant Coast · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "向北骑往{area:392}的路上，{area:720}位于镇子南边的{area:391}近海：涉水穿过沙洲浅滩。{npc:6236}会让四名挑战者和{npc:6238}（33级）依次与你交战。",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "击败挑战者和{npc:6238}",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236} offers The Windwatcher next (1791): the Whirlwind weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "{npc:6236}接下来提供“捕风者”（1791）：旋风武器任务线最后有一个精英，见战士职业指南“旋风武器”。",

	-- Step 18: Ratchet
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:16227} Bragok · {area:35} Booty Bay
	["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "从塞拉摩沿尘泥沼泽的道路向西进入{zone:1413}，再向北到海岸上的{area:392}。向{npc:16227}学习飞行路线，然后在码头乘船前往{area:35}。",
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "乘船前往{area:35}",

	-- Step 19: Booty Bay
	-- {object:56910} The Salty Sailor Tavern
	["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910}是港口上方的高楼；大多数任务给予者在它的各层或下方码头。",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}: keep it"] = "交给{zone:1446}的斯杜雷：留着",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773}：交给{zone:1446}的{quest:2864}，留着",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "交给{area:99}的{npc:770}，在北部环线上",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}，顶楼",
	["Seahorn's next errand goes back to Arathi: skip it."] = "海角的下一个差事要回阿拉希：跳过。",

	-- Step 20: Bloodsail camp
	["Bloodsail camp"] = "血帆营地",
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks."] = "从隧道出城，沿海岸向北；信在沙滩上的血帆营地里，帅小伙子邓肯在那里走动。",

	-- Step 21: Booty Bay
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624}在西北海岸外游动，在北部环线上",

	-- Step 22: Bloodsail pirates
	["Bloodsail pirates"] = "血帆海盗",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore · {area:35} Booty Bay
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}."] = "每个血帆海盗都掉落鼻烟，其中一个携带{npc:2493}的眼睛；血帆流氓在镇子北边的岸上游荡。海图和命令在{area:35}南边{area:43}的海盗营地里。",

	-- Step 24: The Bloodsail captains
	["The Bloodsail captains"] = "血帆船长",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon
	["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "船长们站在停泊于{area:43}外的船上，每艘有42-45级的海盗船员：斯蒂沃特（45）和尼哈鲁（46）在较近的甲板上，{npc:2546}（48）在旗舰上。42级时这需要组队，或留到指南最后；如果要去，先清理每层甲板。科泰罗的卷轴在岸边的沉船上。",
	-- {zone:1435} Swamp of Sorrows
	["for the {zone:1435} later"] = "之后用于{zone:1435}",

	-- Step 26: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "纳迦探险者",
	["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "纳迦在血帆营地北边的海滩上搜寻；它们掉落芦苇。",

	-- Step 27: Gorilla hills
	["Gorilla hills"] = "猩猩山丘",
	-- {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "向内陆骑行到迷雾谷猩猩所在的山丘。老迈的迷雾谷猩猩掉落内脏；{npc:1449}坐在它们中间。",

	-- Step 28: Unbagwa's ritual
	["Unbagwa's ritual"] = "安巴格瓦的仪式",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "交还牙齿后留下：会来三波猩猩，最后是{npc:1514}。满血再战。",

	-- Step 29: Booty Bay
	["Ride back down to town; Shaky stands at the tunnel mouth."] = "骑回镇上；“病鬼”菲利普站在隧道口。",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it"] = "交给塞拉摩的{npc:2616}：留着",

	-- Step 30: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535}和{npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "向北骑行到道路西边的山丘。{npc:2535}和{npc:2536}一起站在赞吉尔村子北边不远处。",

	-- Step 31: Zanzil's village
	["Zanzil's village"] = "赞吉尔的村子",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "每个赞吉尔的追随者都可能掉落药剂；{npc:2537}在营地南部走动。",

	-- Step 32: Crystalvein Mine
	-- {area:310} Crystalvein Mine
	["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "沿道路向东北前往{area:310}的风险投资公司营地；矿工、勘探员和工头掉落水晶。",

	-- Step 33: Skullsplitter ruins
	["Skullsplitter ruins"] = "劈颅巨魔废墟",
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "劈颅巨魔占据矿井东边不远的废墟；任何巨魔都可能掉落獠牙，它们的猎豹必定掉落。",

	-- Step 34: Cold Eye Basilisks
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["Cold Eye Basilisks"] = "冷眼蜥蜴",
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["The Cold Eye Basilisks lie on the rocks west of the mine."] = "冷眼蜥蜴趴在矿井西边的岩石上。",

	-- Step 35: The north-west coast
	["The north-west coast"] = "西北海岸",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "从矿井向西北骑行到西北海岸的海湾。{object:2744}在海底，里面有珍珠；{npc:2624}在它们中间游动，掉落{item:4034}。",

	-- Step 36: Rebel Camp
	-- {npc:217588} Arbor Tarantula
	["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "向东北经过奈辛瓦里营地，沿道路向北前往山谷顶端的营地。途中，奈辛瓦里营地东南方的丛林里有一只{npc:217588}：用昆虫学入门工具包捕捉一只，然后勾选。",
	-- {npc:217588} Arbor Tarantula · {quest:93176} My Little Friends
	["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588}：捕捉它，用于{quest:93176}",

	-- Step 37: Booty Bay
	["MacKinley's next task sends you after elite ogres: skip it."] = "马克基雷的下一个任务要你对付精英食人魔：跳过。",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "{npc:2498}的下一个赞吉尔差事从{zone:1441}开始：跳过。",

	-- Step 38: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141}在{object:2169}做饭；{npc:5384}在{object:28027}。",
	-- {npc:5694} High Sorcerer Andromath · {area:1438} Nethergarde Keep
	["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694}：交给{area:1438}，留着",
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440}，在{object:2117}的皇家图书馆",

	-- Step 39: Riding at 40
	["Riding at 40"] = "40级骑术",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40级且有100金时可以学习骑术，学会后会获得一匹坐骑。{npc:4732}在{zone:1429}东部的{area:88}教授人类，旁边是{npc:384}的马。Forever 可能允许任何种族向任何骑术训练师学习（未确认）。收藏指南“坐骑 · 40级”列出了所有颜色。",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384}：其他颜色，20金",

	-- Step 40: Riding at 40
	-- {spell:1285849} Galestrider Riding · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {zone:1453} Stormwind · {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "40级且有100金币时即可学习骑术，学会后会获得一匹坐骑。目前不知道天裔的骑术训练师在哪；Forever 客户端把{spell:1285849}归入同一个骑术技能，所以{zone:1429}东部{area:88}的{npc:4732}（离{zone:1453}最近的训练师）应该能教（未确认）。疾风陆行鸟由泽风岛{area:16638}的{npc:265756}出售；见“收藏品”中的“坐骑 · 40级”。",
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "疾风陆行鸟：{npc:265756}，在泽风岛的{area:16638}。",

	-- Step 41: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "40级且有100金时可以学习骑术，学会后会获得一匹坐骑。{npc:4753}在{zone:1457}教授暗夜精灵，旁边是{npc:4730}的豹：从{area:17203}乘船前往{area:442}，再飞往{area:702}。Forever 可能允许任何种族向任何骑术训练师学习（未确认），例如{zone:1429}{area:88}的{npc:4732}。收藏指南“坐骑 · 40级”列出了所有颜色。",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730}：其他颜色，20金",

	-- Step 42: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "圣骑士：{quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171}，在光明大教堂",

	-- Step 43: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "术士：{quest:3631}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461}，在{object:2164}：{area:392}的{npc:6251}在下一份指南结尾接收",

	-- Step 44: Watcher Biggs
	-- {area:42} Darkshire · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {npc:5476} Watcher Biggs
	["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "飞往{area:42}，向东骑行穿过{zone:1430}进入{zone:1435}；{npc:5476}站在刚过边界的路旁。",

	-- Step 45: A Soggy Scroll
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "卷轴在比格斯北边的沼泽里。其北边的沼泽漫步者可能掉落卡德加的空间收敛研究笔记。",
	["The riddle's next scroll lies in western Dustwallow: skip it."] = "谜题的下一张卷轴在尘泥沼泽西部：跳过。",

	-- Step 46: The sunken temple
	["The sunken temple"] = "沉没的神庙",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "向东骑行；沿途的纠缠恐兽也会掉落研究笔记。在{area:74}边缘搜寻，神庙的废墟在那里露出水面。",

	-- Step 47: Misty Reed Strand
	["The driftwood washes up along the eastern shore."] = "浮木冲上东岸。",

	-- Step 48: Watcher Biggs
	-- {npc:217412} Amaryllis Webb
	["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "沿道路向西骑回；{npc:217412}站在比格斯北边不远处。",
	-- {area:1438} Nethergarde Keep
	["for {area:1438}: keep it"] = "交给{area:1438}：留着",
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412}：{quest:93176}，来自 30-40/05-arathi-highlands",

	-- Step 49: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "交给{area:348}的{npc:5635}：留着",

	-- Step 50: Ironforge
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers · {npc:1356} Prospector Stormpike · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern · {area:144} Thelsamar
	["Take the {area:2257} from the {object:28027}. {npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:1356} in the hall itself, {npc:2786} in the {object:32383}. The next guide flies on to {area:144}."] = "从{object:28027}乘{area:2257}。{npc:5637}在{object:32356}旁的寻物公司大厅，{npc:1356}在大厅内，{npc:2786}在{object:32383}。下一份指南飞往{area:144}。",
	-- {npc:1356} Prospector Stormpike · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356}：交给{zone:1432}的{npc:1344}，留着",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453}没有萨满祭司训练师",

	-- Step 51: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40级且有100金时可以学习骑术，学会后会获得一匹坐骑。{npc:4772}在{area:803}教授矮人，位于{area:131}东边通往{zone:1432}的路上，旁边是{npc:1261}的山羊。Forever 可能允许任何种族向任何骑术训练师学习（未确认）。收藏指南“坐骑 · 40级”列出了所有颜色。",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261}：其他颜色，20金",

	-- Step 52: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40级且有100金时可以学习骑术，学会后会获得一匹坐骑。{npc:7954}在{area:131}东边不远的{area:189}教授侏儒，旁边是{npc:7955}的机械陆行鸟。Forever 可能允许任何种族向任何骑术训练师学习（未确认）。收藏指南“坐骑 · 40级”列出了所有颜色。",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955}：其他颜色，20金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Klannoc offers The Windwatcher next (1791): the {spell:1680} weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "克兰诺克·马克雷德接下来提供“捕风者”（1791）：{spell:1680}武器任务线最后有一个精英，见战士职业指南“旋风武器”。",
	-- ["{npc:6236}: Berserker Stance"] = "{npc:6236}：狂暴姿态",
}
