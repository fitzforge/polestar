-- Chinese (simplified) (zhCN): the guide forever/horde/07-ashenvale (forever/horde/07-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zoram'gar Outpost
	-- {area:392} Ratchet · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale
	["Fly from {area:392} to {area:2897} on the {zone:1440} coast."] = "从{area:392}飞往{zone:1440}海岸的{area:2897}。",
	-- {npc:12717} Muglash
	["{npc:12717}: starts his escort at once"] = "{npc:12717}：立即开始护送",

	-- Step 2: Vorsha the Lasher
	-- {npc:12717} Muglash
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead."] = "{npc:12717}沿着海滩向北走到一个纳迦火盆旁。熄灭火盆，然后在纳迦一波波来袭时保护他，直到鞭笞者沃尔沙死去。",
	["Naga brazier"] = "纳迦火盆",

	-- Step 3: Blackfathom Deeps ruins
	-- {area:2797} Blackfathom Deeps
	["{area:2797} ruins"] = "{area:2797}废墟",
	["The way to the Sapphires is through the sunken ruins at the north end of the strand: go down the stairs into the pit."] = "去阿库麦尔蓝宝石的路要穿过海滩北端沉没的废墟：沿台阶下到坑里。",

	-- Step 4: Sapphires of Aku'Mai
	["Sapphires of Aku'Mai"] = "阿库麦尔蓝宝石",
	-- {area:2797} Blackfathom Deeps
	["The Sapphires are blue crystals on the walls of the tunnels leading to the {area:2797} portal, underground and outside the instance: swim down from the pit, under the wall, into the cave. The satyrs and naga in the tunnels are elite: grouping up is advised. The crystals respawn quickly, so there is no need to go deep."] = "阿库麦尔蓝宝石是通往{area:2797}传送门的坑道墙壁上的蓝色水晶，位于地下、副本之外：从坑里潜下去，从墙下游进洞穴。坑道里的萨特和纳迦是精英：建议组队。水晶刷新很快，不用深入。",

	-- Step 5: Zoram'gar Outpost
	-- {npc:12736} Je'neu Sancrea · {area:2797} Blackfathom Deeps
	["{npc:12736} offers a {area:2797} quest next; leave it unless you have a group."] = "{npc:12736}接下来会提供一个{area:2797}任务；除非你有队伍，否则别接。",

	-- Step 6: Thistlefur Village
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold."] = "在佐拉姆加前哨站东边，蓟皮熊怪占满了村庄和它们巢穴周围的山丘。",

	-- Step 7: Thistlefur Hold
	["Thistlefur Hold"] = "蓟皮熊怪的巢穴",
	-- {npc:12818} Ruul Snowhoof · {area:428} Night Run
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}."] = "巢穴里，巨魔的箱子散落在坑道各处。{npc:12818}被关在深处：救出他并一路护送他出去，之后他会跑回{area:428}的家。",

	-- Step 8: Zoram'gar Outpost
	["Back west to Zoram'gar before heading east for good."] = "向西回到佐拉姆加前哨站，然后再彻底向东出发。",

	-- Step 9: Ursangous
	-- {area:415} Astranaar · {npc:12678} Ursangous · {area:418} Ruins of Stardust · {area:421} Mystral Lake
	["Follow the main road east past {area:415} (Alliance: keep to the road). {npc:12678}, a big grizzly, roams the {area:418} south of the road, west of {area:421}. His paw starts the next hunt quest."] = "沿主路向东经过{area:415}（联盟据点：别离开道路）。{npc:12678}是一头巨大的灰熊，在道路南边、{area:421}西边的{area:418}游荡。它的爪子可以开始下一个狩猎任务。",

	-- Step 10: Ruins of Stardust fountain
	-- {area:418} Ruins of Stardust
	["{area:418} fountain"] = "{area:418}的喷泉",
	-- {area:418} Ruins of Stardust · {item:7767} Empty Blue Waterskin
	["The fountain stands in the middle of the {area:418}: use the {item:7767} there."] = "喷泉在{area:418}中央：在那里使用{item:7767}。",

	-- Step 11: Alonso
	-- {npc:210995} Alonso · {area:421} Mystral Lake
	["{npc:210995}, a Forever addition, stands on the west shore of {area:421} with three quick Dragonslayer quests."] = "{npc:210995}是Forever新增的NPC，站在{area:421}西岸，有三个简短的屠龙者任务。",

	-- Step 12: Tideress
	-- {npc:12759} Tideress · {area:421} Mystral Lake · {item:16408} Befouled Water Globe
	["{npc:12759}, a corrupted water elemental, drifts in {area:421}. Her {item:16408} starts a quest for Splintertree."] = "{npc:12759}是一个被腐化的水元素，在{area:421}里漂浮。它掉落的{item:16408}可以开始一个碎木岗哨的任务。",

	-- Step 13: King of the Foulweald
	-- {area:421} Mystral Lake · {item:16972} Karang's Banner · {object:178206} Foulweald Totem Mound (no name in this language: may be words) · {npc:12918} Chief Murgut
	["The Foulweald furbolgs hold the woods east of {area:421}, south of the road. Place {item:16972} on the {object:178206} and guard it: the furbolgs come to tear it down. {npc:12918} comes last; his totem drops in the basket."] = "污林熊怪占据着{area:421}东边、道路南边的树林。把{item:16972}放在{object:178206}上并守护它：熊怪会来摧毁它。{npc:12918}最后出现；他的图腾会掉进篮子里。",

	-- Step 14: Torek's Assault
	-- {npc:12858} Torek · {area:2360} Silverwing Outpost · {npc:12860} Duriel Moonfire
	["Keep east on the road. {npc:12858} waits south-west of the Warsong lumber camp. He and his grunts storm the {area:2360}: let them take aggro and stay with {npc:12858} until {npc:12860} is dead."] = "继续沿道路向东。{npc:12858}在战歌伐木营地西南等候。他和他的步兵会猛攻{area:2360}：让他们吸引仇恨，跟着{npc:12858}直到{npc:12860}死去。",

	-- Step 15: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867}站在伐木营地。暗夜精灵灰谷先驱者在营地东南的树林里潜伏；他们会潜行，所以留意他们。",

	-- Step 16: Splintertree Post
	-- {area:431} Splintertree Post · {area:428} Night Run
	["North up the road to {area:431} and {area:428} beside it."] = "沿道路向北前往{area:431}和旁边的{area:428}。",
	-- {npc:12718} Gurda Ragescar
	["{npc:12718}: only if you carry the manual pages"] = "{npc:12718}：仅当你带着手册书页时",

	-- Step 17: Sharptalon
	-- {npc:12676} Sharptalon
	["{npc:12676}, a big nightsaber, prowls the woods south-east of the Warsong lumber camp. Her claw starts the next hunt quest."] = "{npc:12676}是一只巨大的夜刃豹，在战歌伐木营地东南的树林里潜行。它的爪子可以开始下一个狩猎任务。",

	-- Step 18: Felmusk satyrs
	["Felmusk satyrs"] = "魔草萨特",
	["North-west of Splintertree, the Felmusk satyrs camp in the woods. Every satyr can drop horns."] = "在碎木岗哨西北，魔草萨特在树林里扎营。每个萨特都可能掉落角。",

	-- Step 19: Shadumbra
	-- {npc:12677} Shadumbra · {area:426} Raynewood Retreat
	["{npc:12677}, a shadow panther, stalks the woods around {area:426}, west of the Felmusk camp. Her head starts the next hunt quest."] = "{npc:12677}是一只暗影豹，在魔草萨特营地西边的{area:426}周围的树林里潜行。它的头颅可以开始下一个狩猎任务。",

	-- Step 20: Mystral Lake
	-- {area:421} Mystral Lake
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["Back south-west to {area:421}. Befouled Water Elementals drift around its shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "向西南回到{area:421}。污浊的水元素在湖岸周围漂浮；瞭望台在岛上，俯瞰着联盟的前哨站。",
	["Gazebo"] = "瞭望台",

	-- Step 23: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:222} Bloodhoof Village · {npc:2995} Tal
	["Fly to {area:1638} if you know the flight path. If not, fly to {area:378}, ride west into {zone:1412} past {area:222} to {area:1638} and take its flight path from {npc:2995} on the central rise."] = "如果你知道飞行路线，就飞往{area:1638}。否则飞往{area:378}，向西骑马进入{zone:1412}，经过{area:222}前往{area:1638}，在中央高台的{npc:2995}处开通飞行路线。",
	-- {npc:3057} Cairne Bloodhoof · {area:1638} Thunder Bluff · {quest:93739} Exploring the Horde
	["Speak with {npc:3057}, in {area:1638}: {quest:93739}"] = "与{area:1638}的{npc:3057}交谈：{quest:93739}",

	-- Step 24: The Earthen Ring
	["The Earthen Ring"] = "大地之环",
	-- {zone:1456} Thunder Bluff · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem · {npc:259118} Muln Earthfury
	["Take a lift down from {zone:1456}. The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}."] = "从{zone:1456}乘升降梯下去。大地之环的营地在高崖北边：{npc:264074}、{npc:264072}和{npc:259118}。",

	-- Step 25: Gloomrise
	-- {area:17044} Gloomrise · {npc:264074} Mazu'kon · {item:273015} Toxin Extractor · {item:273181} Crystalline Silk · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["North of the camp, spiders overrun the burial ground at {area:17044}. Use {npc:264074}'s {item:273015} on the Gnawed Corpses; the Spinners drop the {item:273181}. {npc:264082} sits at the north end: her {item:273658} starts {quest:96294}."] = "在营地北边，蜘蛛占据了{area:17044}的墓地。对{npc:264096}使用{npc:264074}的{item:273015}；那里的蜘蛛掉落{item:273181}。{npc:264082}在北端：她的{item:273658}可以开始{quest:96294}。",
	-- plural, as words: Gloomrise Toxin Samples = {item:273001} Gloomrise Toxin Sample · Gnawed Corpses = {npc:264096} Gnawed Corpse
	["Gloomrise Toxin Samples, from the Gnawed Corpses"] = "暮升毒液样本，从{npc:264096}获取",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}，从{npc:264081}获取",
	-- {item:273658} Bloody Parchment · {npc:264082} Broodmother Valraxx
	["{item:273658}, from {npc:264082}"] = "{item:273658}，从{npc:264082}获取",

	-- Step 26: The Earthen Ring
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo
	["Back south to the camp, then up into {zone:1456} for the flight to {area:378}."] = "向南回到营地，然后上到{zone:1456}，飞往{area:378}。",

	-- Step 27: Brine
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {npc:5899} Brine · {area:1718} Great Lift
	["Fly from {zone:1456} to {area:378}. {npc:5899}'s hut stands on the ridge above the quilboar watering hole south of the camp, on the road to the {area:1718}."] = "从{zone:1456}飞往{area:378}。{npc:5899}的小屋在营地南边野猪人水坑上方的山脊上，就在通往{area:1718}的路上。",
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["for {npc:5901}, south of {area:392}: next guide"] = "交给{area:392}南边的{npc:5901}：见下一个指南",

	-- Step 28: Great Lift
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {area:1718} Great Lift · {zone:1413} Barrens
	["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {zone:1413}."] = "从{zone:1456}飞往{area:378}，沿道路向南前往{zone:1413}南端的{area:1718}。",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}，在升降梯顶部",

	-- Step 29: Freewind Post
	-- {area:484} Freewind Post
	["Ride the lift down, then follow the road east through the canyons to {area:484}, a Tauren village on top of the mesas. Its lift is on the north side."] = "乘升降梯下去，然后沿道路向东穿过峡谷前往{area:484}，那是一座建在石柱顶上的牛头人村庄。它的升降梯在北侧。",
	-- {npc:10377} Elu
	["{npc:10377}, by the wind rider master"] = "{npc:10377}，在双足飞龙管理员旁边",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}, the trade supplies vendor: the Screeching harpies of {area:487}"] = "{npc:4877}，商业用品商人：{area:487}的尖啸的鹰身人",
	-- {npc:10537} Cliffwatcher Longhorn
	["The Wanted poster beside {npc:10537}"] = "{npc:10537}旁的通缉告示",

	-- Step 30: Alien Egg
	["Take the lift down. The egg lies in a nest on the canyon floor in one of three spots: south-east of the mesas (52.3,55.2), east (56.4,50.4) or south-west (37.6,56.1)."] = "乘升降梯下去。蛋在峡谷底部的一个巢里，位于三个地点之一：石柱东南（52.3,55.2）、东边（56.4,50.4）或西南（37.6,56.1）。",

	-- Step 32: Galak centaurs
	["Galak centaurs"] = "加拉克半人马",
	-- {npc:10617} Galak Messenger · {area:2237} Whitereach Post
	["The Galak camps fill the canyon north of Freewind; Scouts, Wranglers and Windchasers share every camp. A lone {npc:10617} walks between the camps: kill him when you meet him, his note starts a quest for {area:2237}."] = "加拉克半人马的营地遍布乱风岗北边的峡谷；每个营地都有加拉克斥候、加拉克争斗者和加拉克逐风者。一个落单的{npc:10617}在营地之间走动：遇到就杀死他，他的信件可以开始一个{area:2237}的任务。",

	-- Step 33: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {quest:1149} Test of Faith
	["{npc:2986} stands on a mesa top east of the Galak camps. For the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "{npc:2986}站在加拉克营地东边的一座石柱顶上。做{quest:1149}时，从他旁边的木板尽头走下去：你会安全落地。",

	-- Step 35: Grimtotem camps
	["Grimtotem camps"] = "恐怖图腾营地",
	-- {area:2097} Darkcloud Pinnacle
	-- plural, as words: Document Chests = {object:176344} Document Chest
	["West of Freewind, the Grimtotem camps below {area:2097}. The Secret Notes are in Document Chests at the south-east, south-west and north-west camps."] = "在乱风岗西边，恐怖图腾的营地在{area:2097}下方。密信在东南、西南和西北营地的文件箱里。",
	-- {object:176344} Document Chest
	["{object:176344}, south-east camp"] = "{object:176344}，东南营地",
	-- {object:176344} Document Chest
	["{object:176344}, south-west camp"] = "{object:176344}，西南营地",
	-- {object:176344} Document Chest
	["{object:176344}, north-west camp"] = "{object:176344}，西北营地",

	-- Step 36: Lakota Windsong
	-- {area:2097} Darkcloud Pinnacle · {npc:10646} Lakota Windsong · {npc:10896} Arnak Grimtotem
	["Climb the path to the top of {area:2097}. {npc:10646} is held captive beside {npc:10896} (29): clear the guards and {npc:10896} first, then free her and protect her on the walk down; Grimtotem ambushers come at you on the way."] = "沿小路爬上{area:2097}顶部。{npc:10646}被囚禁在{npc:10896}（29级）旁边：先清掉守卫和{npc:10896}，再救出她并在下山路上保护她；途中会有恐怖图腾伏击者袭击你。",

	-- Step 37: Whitereach Post
	-- {area:2237} Whitereach Post
	["Follow the canyon west to {area:2237}."] = "沿峡谷向西前往{area:2237}。",
	-- {npc:10428} Motega Firemane · {zone:1456} Thunder Bluff
	["{npc:10428}'s next quest, Sacred Fire, ends in {zone:1456}, off this route. Skip it."] = "{npc:10428}的下一个任务（生命圣火）在{zone:1456}结束，不在本路线上。跳过它。",
	-- {npc:10720} Galak Assassin · {npc:10638} Kanati Greycloud
	["Kill the {npc:10720} that comes for {npc:10638}"] = "杀死前来袭击{npc:10638}的{npc:10720}",

	-- Step 38: Highperch
	-- {area:482} Highperch · {npc:10427} Pao'ka Swiftmountain · {area:2237} Whitereach Post
	["West of Whitereach the wyverns nest on the {area:482} cliffs; the eggs lie in the nests. {npc:10427} waits on the east side of the nesting grounds: free him and keep him alive on the walk back to {area:2237}."] = "在白沙岗哨西边，双足飞龙在{area:482}的悬崖上筑巢；蛋就在巢里。{npc:10427}在筑巢地东侧等候：救出他，并在走回{area:2237}的路上保护他。",

	-- Step 40: Roguefeather Den
	-- {area:487} Roguefeather Den · {npc:4490} Grenka Bloodscreech · {npc:4877} Jandia
	["South of Darkcloud, the harpies of {area:487}. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her. The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s."] = "在黑云峰南边是{area:487}的鹰身人。{npc:4490}（31级）在它们中间走动：引她之前先清掉她周围的鹰身人。那里的尖啸的鹰身人、尖啸的游荡者和尖啸的唤风者是{npc:4877}要的。",

	-- Step 43: Rok'Alim the Pounder
	-- {npc:4499} Rok'Alim the Pounder · {area:482} Highperch
	["{npc:4499}, a hard-hitting rock elemental, walks the cliffs of {area:482}. {npc:4499} is elite: grouping up is advised."] = "{npc:4499}是一个攻击力很高的石元素，在{area:482}的悬崖上走动。{npc:4499}是精英：建议组队。",

	-- Step 44: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyon east out of the mesas onto the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "沿峡谷向东离开石柱区，来到盐滩。{area:2240}的地精和侏儒是中立的，为两个阵营提供任务。",
	["His crate is for Stranglethorn, later on the route"] = "他的箱子要送去荆棘谷，在路线后面",

	-- Step 45: The salt flats
	["The salt flats"] = "盐滩",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{object:19868} lies all over the flats north of the raceway. Scorpid Reavers and Sparkleshell Tortoises roam the north half, Salt Flats Scavengers circle overhead, and Saltstone Basilisks graze west of the track. The Crystalhides roam the middle of the flats and the Gazers (34-35, five levels above you: one at a time) the far south."] = "{object:19868}散落在赛道北边的盐滩上。恐蝎劫掠者和盐壳龟在北半部游荡，盐湖食腐鹫在空中盘旋，盐石蜥蜴在赛道西边吃草。盐石水晶蜥蜴在盐滩中部游荡，盐石凝视者（34-35级，比你高五级：一次引一只）在最南边。",

	-- Step 46: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, around level 38"] = "{npc:4454}：他的信要交给{zone:1418}的马特克，大约38级时",

	-- Step 47: Freewind Post
	-- {zone:1454} Orgrimmar
	["The next guide flies on from here to {zone:1454}."] = "下一个指南从这里飞往{zone:1454}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Shadumbra"] = "萨杜布拉",
	-- ["Sharptalon"] = "沙普塔隆",
	-- ["The {area:1718}"] = "{area:1718}",
	-- ["Tideress"] = "泰德雷斯",
	-- ["Ursangous"] = "乌萨苟斯",
}
