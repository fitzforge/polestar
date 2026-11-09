-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/01-un-goro-crater (forever/horde/50-60/01-un-goro-crater.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Into Un'Goro Crater
	-- {zone:1449} Un'Goro Crater
	["Into {zone:1449}"] = "进入{zone:1449}",
	-- {area:1938} Broken Pillar · {zone:1449} Un'Goro Crater · {area:541} Marshal's Refuge
	["From the {area:1938} ride west to the long ramp that winds down into {zone:1449}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "从{area:1938}向西骑到蜿蜒下降进入{zone:1449}的长坡道，然后沿着环形山的北壁前往{area:541}，那是建在悬崖洞穴里的营地。这里的所有人都是中立的。",
	-- {npc:9997} Spraggle Frock
	["the wooden sign beside {npc:9997}, by the flight master: the pterrordax are on this guide's ground"] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117}，位于洞穴深处的地下",

	-- Step 3: Out of the refuge
	["Out of the refuge"] = "离开避难所",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}，在避难所入口",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "{npc:9618}，就在外面",
	-- {quest:3761} Un'Goro Soil
	["From here on pick up every Power Crystal (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "从现在起，捡起路过的每一块能量水晶（蓝色、绿色、红色、黄色）和每一堆{quest:3761}：总共25份土壤，20份给哈缪尔，5份给匹斯特苏格。",

	-- Step 4: Lakkari Tar Pits
	-- {item:11834} Super Sticky Tar
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "焦油池就在避难所正南。焦油兽、焦油潜伏者和焦油爬行者掉落{item:11834}。",

	-- Step 5: Pterrordax
	["Pterrordax"] = "翼手龙",
	-- {npc:9998} Shizzle
	["Pterrordax fly over the east of the crater, from the slopes below the refuge southward; their webbed scales are for {npc:9998}."] = "翼手龙在环形山东部飞行，从避难所下方的山坡一直分布到南边；它们的翼膜鳞片要交给{npc:9998}。",
	["grind on Pterrordax"] = "反复击杀翼手龙补足经验",

	-- Step 6: Power Crystals and soil
	["Power Crystals and soil"] = "能量水晶和土壤",
	-- {area:537} Fire Plume Ridge
	["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "水晶簇遍布整个环形山，{area:537}周围很多。每种颜色多拿几块给水晶塔用。",

	-- Step 7: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}：沿途击杀以下目标",
	-- {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:8659} Jes'rimon · {npc:9167} Frenzied Pterrordax
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Dinosaur Bones = {item:11114} Dinosaur Bone · Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot.\nSouth of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon.\nRide south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "骑乘向西南前往环形山中央的火山 {area:537}。血瓣花掠夺者生长在山脚周围。\n温泉南面有剑龙吃草，它们会掉落恐龙骨头，地上也能捡到；附近的双帆龙携带 {npc:9998} 所需的鳞片。暴掠龙成群在西南部捕猎：爪子要交给 {npc:8659}，偶尔还有一只携带 被撕破的日记（稀有掉落：拿到后再接它触发的任务）。避开 格鲁夫，它是一只57级剑龙。\n沿西侧悬崖向西南骑行。{npc:9167} 在西侧上空飞行，血瓣花捕兽者也生长在这片丛林里。",

	-- Step 8: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "考察队丢失的研究设备在西南丛林里。",

	-- Step 9: The Slithering Scar
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "小心：格里什工蝎生命值降到45%以下时，有50%概率向25码内的同伴呼救。",
	-- {npc:6551} Gorishi Wasp
	["grind on {npc:6551}"] = "击杀{npc:6551}刷经验",

	-- Step 11: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "剑龙和暴掠龙",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}，稀有掉落",
	["Use the Mangled Journal to start it"] = "使用被撕破的日记开始任务",

	-- Step 12: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619}在环形山的东南角扎营。",

	-- Step 13: Fresh Threshadon Carcass
	["North of Torwa, a dead Threshadon lies by the water."] = "在托尔瓦北边，一头死去的蛇颈龙躺在水边。",

	-- Step 15: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "拉克维的配偶",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "拉克维的配偶在{npc:9619}西北的丛林里潜行。",

	-- Step 16: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "破碎的木筏在东南湖泊的岸边；小背包就在旁边的水里。",
	["Underwater"] = "在水下",

	-- Step 18: Lashers and Threshers
	["Lashers and Threshers"] = "鞭笞者和猛击者",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "沿东侧向北骑行。血瓣花鞭笞者和血瓣花猛击者占满了丛林。",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "击杀{npc:6511}刷经验",

	-- Step 19: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "{zone:1449}：沿途击杀以下目标",
	["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "考察队的食物箱在东部丛林一个废弃的营地里。",

	-- Step 20: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "{npc:9998}，在入口",
	-- {npc:9997} Spraggle Frock
	["{npc:9997}, beside the flight master"] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}：在地下",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "留着{npc:9118}的{quest:4147}和{npc:8737}的信，在之后的指南中使用。",

	-- Step 21: Northern Pylon
	["Northern Pylon"] = "北部水晶塔",
	["The pylon stands on the slope east of the refuge."] = "水晶塔在避难所东边的山坡上。",

	-- Step 22: Gorillas
	["Gorillas"] = "猩猩",
	-- {npc:9622} U'cha
	["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "猩猩住在东北的高地上。别进入最深的洞穴：{npc:9622}住在那里。",
	-- {npc:9623} A-Me 01
	["{npc:9623}, the robot on the plateau; below ground"] = "{npc:9623}，高地上的机器人；位于地下",
	-- {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "{npc:9623}接着要一个{item:10561}，这是{skill:202}物品。除非你有，否则跳过。",

	-- Step 23: Un'Goro Crater: kill these as you meet them
	-- {spell:8137} Silithid Pox · {spell:14120} Tunneler Acid
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers may call for help within 25 yd when below 45% health; silithids cast {spell:8137} and Tunnelers and the Hive Guard use {spell:14120}."] = "小心：格里什工蝎在生命值低于 45% 时，可能呼叫 25 码内的同伴支援；异种虫会施放 {spell:8137}，坑道虫和虫巢卫士会使用 {spell:14120}。",

	-- Step 24: Eastern Pylon
	["Eastern Pylon"] = "东部水晶塔",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "沿环形山东侧骑下去，前往东边悬崖上的水晶塔。",

	-- Step 25: The Marshlands
	-- {quest:4061} The Rise of the Machines · {area:340} Kargath · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time.\nBelow level 52, keep hunting the ravasaurs here after the eighth claw: {quest:4061} at {area:340} needs level 52, and the Plaguelands quests at the end of this guide are level 55. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	["grind on Ravasaur"] = "",

	-- Step 26: Western Pylon
	["Western Pylon"] = "西部水晶塔",
	["Cross the south of the crater to the pylon on the western cliffs."] = "穿过环形山南部，前往西边悬崖上的水晶塔。",

	-- Step 27: J.D. Collie
	-- {area:541} Marshal's Refuge
	["Ride north back to {area:541}."] = "向北骑回{area:541}。",
	["Below ground"] = "在地下",

	-- Step 28: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "前往{area:976}",

	-- Step 29: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}：在屋内",

	-- Step 30: Orgrimmar
	-- {area:1637} Orgrimmar · {area:16727} Powderfuse Port · {zone:1458} Undercity
	["Fly to {area:1637} and train before the boat to {area:16727}: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "飞往{area:1637}，先学习技能，再乘船前往{area:16727}；本指南稍后途经的{zone:1458}没有猎人或萨满训练师。",

	-- Step 31: Back to Gadgetzan
	-- {area:976} Gadgetzan
	["Back to {area:976}"] = "返回{area:976}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 32: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "乘船前往{area:16727}",
	-- {npc:9706} Yorba Screwspigot · {quest:4324} Yuka Screwspigot · {area:251} Flame Crest
	["{npc:9706}, by the dock: for {quest:4324} at {area:251}, later in this guide"] = "",

	-- Step 33: Badlands
	-- {zone:2548} Riverglades · {area:16685} Twilight's Shroud · {zone:1418} Badlands
	["Leave {zone:2548} on foot to the north-west, north of {area:16685}, into the {zone:1418}."] = "从 {area:16685} 北面步行向西北离开 {zone:2548}，进入 {zone:1418}。",

	-- Step 34: Kargath
	-- {area:340} Kargath · {zone:1418} Badlands
	["{area:340} is built into the cliffs on the {zone:1418}' west edge."] = "{area:340}建在{zone:1418}西缘的峭壁中。",

	-- Step 35: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "进入{zone:1427}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {area:254} Blackrock Mountain
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "从{area:340}西侧的山口进入{zone:1427}，然后向南穿过峡谷，走上通往{area:254}的长桥。进去后沿着铁链走道往下走，从南边的出口离开；别走通往地下城传送门的路。",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "通往{area:254}的桥",

	-- Step 36: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "从山里出来就在{area:252}旁边，那里满是55-57级的兽人。沿北边悬崖的道路向东，前往部落营地{area:251}。",

	-- Step 37: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "沿悬崖向南前往火腹食人魔的山丘{quest:3821}。{npc:9136}的遗骸在山脚下。",

	-- Step 38: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822}在{quest:3821}的洞穴和矿道里走动；如果他不在，就清理入口周围的食人魔，直到他回来。",

	-- Step 39: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250}：沿途击杀以下目标",
	-- {npc:7039} War Reaver · {quest:4296} Tablet of the Seven · {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "骑马向西前往挖掘场。{npc:7039} 傀儡（53级）在周围踏步巡逻，经常掉落碎片；{quest:4296} 矗立在挖掘场中央的索瑞森矮人之间。拓印它。\n黑色小龙在 {area:251} 正东的山丘中筑巢。将小龙打到濒死后，对它使用 {npc:10267} 的 {item:12284}，捕获其精华。",

	-- Step 40: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "向东北回到{area:251}。",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "留着{npc:10267}的信：{quest:4808}在{zone:1452}的{area:2255}。",

	-- Step 41: Kargath
	-- {area:1584} Blackrock Depths
	["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "塞朵拉的下一个差事要去镇东边找鲁特维尔，然后进入{area:1584}：跳过它。",

	-- Step 42: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "飞往{area:272}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "{area:340}的飞行管理员",

	-- Step 43: Apothecary Lydon
	["Inside"] = "在里面",

	-- Step 44: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "飞往{area:1497}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "{area:272}的飞行管理员",

	-- Step 45: Harbinger Balthazad
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{npc:10879}，在{object:36078}的蝙蝠管理员旁边",

	-- Step 46: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825}站在{object:36082}。",

	-- Step 47: Undercity
	-- {npc:8390} Chemist Cuely · {zone:1447} Azshara
	["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "{npc:8390}，在炼金房：瓶子之后在{zone:1447}装满",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, near Cuely in the Apothecarium"] = "",
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522}, the {object:36073}"] = "{npc:6522}，在{object:36073}",

	-- Step 49: The Bulwark
	-- {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "离开{zone:1458}，沿道路向东穿过{zone:1420}，前往边境上的被遗忘者要塞{area:152}。",
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions · {quest:5401} Argent Dawn Commission
	["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "从德灵顿旁边的箱子里拿一个{object:176092}，用于{quest:5096}，在回程时完成。装备{quest:5401}：只有佩戴它时才会掉落天灾石。",

	-- Step 50: Janice Felstone
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands · {npc:10778} Janice Felstone
	["From the {area:152}, follow the road east into the {zone:1422}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "从{area:152}沿路向东进入{zone:1422}。费尔斯通农场是沿途第一座农场，{npc:10778}在房子里等候。",
	["Upstairs"] = "在楼上",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house; inside"] = "{object:175894}，在房屋旁；位于内部",
	-- {npc:10781} Royal Overseer Bauhaus · {zone:1458} Undercity
	["Keep the parcel: {npc:10781} is in the {zone:1458}."] = "保留包裹：{npc:10781}在{zone:1458}。",

	-- Step 51: Scarlet forward camp
	["Scarlet forward camp"] = "血色十字军前线营地",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "血色十字军的帐篷在{area:199}和{area:200}之间。用{object:176092}点燃指挥帐篷，并插上天灾战旗。",

	-- Step 53: Augustus the Touched
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "沿道路向东穿过{zone:1422}，过河进入{zone:1423}；然后离开道路向北前往西北的废墟城镇{area:2627}。{npc:12384}坐在城镇边缘的一间小屋里。",

	-- Step 54: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "{area:2627}：沿途遇到就击杀",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound
	["The book lies in the ruined inn of {area:2627}.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "书在 {area:2627} 被毁的旅店里。\n大白蚁丘遍布 {area:2627} 东侧的丘陵。对沿途经过的每个蚁丘使用 {item:15042}。",

	-- Step 55: Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "向南骑回道路，沿路向东穿过整个地区前往{area:2268}。",

	-- Step 56: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}：沿途击杀以下目标",
	-- {npc:11063} Carlin Redpath · {npc:11064} Darrowshire Spirit · {area:2262} Darrowshire
	["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "任务日志里有{npc:11063}的任务时，被杀死的天灾军团有时会留下一个{npc:11064}；和它交谈来释放它。在向西南骑往{area:2262}的路上击杀亡灵。",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "释放达隆郡居民的灵魂：和它们交谈",

	-- Step 57: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "{npc:10926}的鬼魂站在西南边{area:2262}的废墟里。",

	-- Step 58: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "洋娃娃的脑袋和两半身体在{npc:10926}周围的房子里；在背包里把它们拼起来。",

	-- Step 59: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}, where this guide ends"] = "",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "",

	-- Step 60: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "流亡者塞达尔潜伏在{area:2262}西面不远处。",

	-- Step 61: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "注意：{npc:10411}在非战斗状态下会隐形，开战后会召唤石翼石像鬼。总共只有三个刷新点，刷新间隔为 15 分钟。",

	-- Step 62: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "返回{area:2268}",

	-- Step 63: Fly to Tarren Mill
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "{area:2268}的飞行管理员",

	-- Step 64: The road north
	["The road north"] = "",
	-- {area:197} Sorrow Hill
	["The road north to {area:197}"] = "",

	-- Step 65: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "{npc:10927}：在楼上",

	-- Step 66: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "向西北骑进安多哈尔。{npc:10667}在城镇西侧被毁的旅店里等候；里面的骷髅是54-57级，所以沿着边缘走。",

	-- Step 67: The Annals of Darrowshire
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "达隆郡的历史就在安多哈尔市政厅里的发霉的书籍中间；一本本打开，直到找到正确的那本。",

	-- Step 68: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{quest:5210} goes to {area:2268}: keep it for later. The next guide starts with {npc:10739} by the {area:202}, east of Andorhal."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Black Broodlings"] = "黑色小龙",
	-- ["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "黑色小龙在{area:251}正东的山丘上筑巢。在小龙快死时对它使用{npc:10267}的{item:12284}来捕获它的精华。",
	-- ["Bloodpetal Flayers"] = "血瓣花掠夺者",
	-- ["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time."] = "小心：这一带有许多暴掠龙游荡，很容易同时引到多只。",
	-- ["Darrowshire Spirits"] = "达隆郡居民的灵魂",
	-- ["Escort {npc:9999}"] = "护送{npc:9999}",
	-- ["Fly to {area:1637} and train before the {object:3202} zeppelin: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "在乘坐前往{object:3202}的飞艇前，先飞往{area:1637}训练：本指南稍后经过的{zone:1458}没有猎人和萨满祭司训练师。",
	-- ["Fly to {area:1637}, take the zeppelin to {object:3202} and fly from there to {area:340}, built into the cliffs on the {zone:1418}' west edge."] = "飞往{area:1637}，乘飞艇前往{object:3202}，再从那里飞往{zone:1418}西缘依悬崖而建的{area:340}。",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "飞往{area:1638}，在{area:1639}找{npc:3033}训练，然后飞往{area:1637}乘坐前往{object:3202}的飞艇。",
	-- ["Fly to {area:340}"] = "飞往{area:340}",
	-- ["Follow the road east through the {area:28} and across the river into the {area:139}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "沿道路向东穿过{area:28}，过河进入{area:139}；然后离开道路向北前往西北的废墟城镇{area:2627}。{npc:12384}坐在城镇边缘的一间小屋里。",
	-- ["From the {area:1938} ride west to the long ramp that winds down into {area:490}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "从{area:1938}向西骑到蜿蜒下降进入{area:490}的长坡道，然后沿着环形山的北壁前往{area:541}，那是建在悬崖洞穴里的营地。这里的所有人都是中立的。",
	-- ["Gorillas"] = "猩猩",
	-- ["Into {area:490}"] = "进入{area:490}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "留着诱饵：{npc:9684}是56级，第二圈会经过它的巢穴。",
	-- ["Keep {quest:5152}: Marlene lives at {area:197} in the {zone:1422}."] = "留着{quest:5152}：玛莱恩住在{zone:1422}的{area:197}。",
	-- ["Lashers and Threshers"] = "鞭笞者和猛击者",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "带{npc:9999}向北前往{area:541}。他晕倒时，对他使用{item:11804}把他叫醒。",
	-- ["Leave the {zone:1458} and ride east along the road through {area:85} to the {area:152}, the Forsaken fort on the border."] = "离开{zone:1458}，沿道路向东穿过{area:85}，前往边境上的被遗忘者要塞{area:152}。",
	-- ["Level 52"] = "等级 52",
	-- ["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "匹斯特苏格的下一个任务需要击败精英首领{npc:10041}。跳过它。",
	-- ["Power Crystals and soil"] = "能量水晶和土壤",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "向东骑往{area:537}，爬上去，在接近山顶的熔岩口使用{npc:10541}，然后向西骑回{npc:10302}那里。",
	-- ["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "沿东侧向北骑行。血瓣花鞭笞者和血瓣花猛击者占满了丛林。",
	-- ["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "沿西边的悬崖向西南骑行。{npc:9167}在西侧上空飞翔，血瓣花捕兽者生长在同一片丛林里。",
	-- ["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "向西南骑往环形山中央的火山{area:537}。血瓣花掠夺者生长在山脚周围。",
	-- ["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "向西骑往挖掘场。{npc:7039}傀儡（53级）在周围走动，经常掉落碎片；{quest:4296}立在挖掘场中央的索瑞森矮人中间。抄录它。",
	-- ["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon."] = "在温泉南边，剑龙在吃草，恐龙骨头从它们身上掉落或散落在地上；附近的双帆龙携带{npc:9998}想要的鳞片。暴掠龙在西南成群捕猎：它们的爪子是给{npc:8659}的，偶尔会有一只携带被撕破的日记（稀有掉落：只有拿到了才接它的任务）。避开57级的剑龙格鲁夫。",
	-- ["Termite mounds"] = "白蚁丘",
	-- ["Thaurissan dig site"] = "索瑞森挖掘场",
	-- ["The Gorishi hive"] = "格里什虫巢",
	-- ["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "大白蚁丘遍布{area:2627}东边的山丘。对路过的每个白蚁丘使用{item:15042}。",
	-- ["The book lies in the ruined inn of {area:2627}."] = "收据册在{area:2627}被毁的旅店里。",
	-- ["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "考察队的食物箱在东部丛林一个废弃的营地里。",
	-- ["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "猩猩住在东北的高地上。别进入最深的洞穴：{npc:9622}住在那里。",
	-- ["The next guide starts here, at the chapel's flight master."] = "下一个指南从这里的教堂飞行管理员处开始。",
	-- ["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "异种蝎的巢穴占据着环形山南部。格里什异种蝎和格里什工蝎掉落格里什信息素；在第一个洞室里对卵块使用采集瓶。底部的格里什皇后是精英首领：别进入她的洞室。{npc:9166}在虫巢上方的悬崖上筑巢；它们的鳞片是给{npc:9998}的。",
	-- ["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "焦油池就在避难所正南。焦油兽、焦油潜伏者和焦油爬行者掉落{item:11834}。",
	-- ["The wooden sign beside {npc:9997}"] = "{npc:9997}旁边的木牌",
	-- ["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "塞朵拉在{area:340}的任务需要52级。避难所正南的焦油潜伏者和焦油兽王是最近的刷怪点。",
	-- ["Top up here to level 52: {quest:4061} at {area:340} needs it, and the Plaguelands quests at the end of this guide are level 55. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "在这里补到52级：{area:340}的{quest:4061}要求这个等级，本指南末尾的瘟疫之地任务则为55级。也可组队挑战{area:1417}或{area:2100}副本。",
	-- ["Western jungle"] = "西部丛林",
	-- ["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "在{zone:1449}的{area:538}刷焦油潜伏者",
	-- ["grind on {npc:6509}"] = "击杀{npc:6509}刷经验",
	-- ["{area:139}: kill these as you meet them"] = "{area:139}：沿途击杀以下目标",
	-- ["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302}让你去找{zone:1452}的{npc:9298}：留着它。",
	-- ["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "地精{npc:10302}坐在水晶塔正东的{area:543}。",
	-- ["{npc:12250} lurks just west of {area:2262}."] = "{npc:12250}潜伏在{area:2262}正西。",
	-- ["{npc:9117}, at the back of the cave"] = "{npc:9117}，在洞穴深处",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "{npc:9619}接下来要东北洞穴里{npc:9622}的毛皮：跳过它。",
	-- ["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "{npc:9623}接着要一个{item:10561}，这是{skill:202}物品。除非你有，否则跳过。",
	-- ["{npc:9623}, the robot on the plateau"] = "{npc:9623}，高地上的机器人",
	-- ["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "{npc:9684}的巢穴就在水晶塔正南。在那里使用{npc:9619}的诱饵；{npc:9684}是56级，攻击很重，所以满血再开始。",
	-- ["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999}坐在山脊上，迷路了，筋疲力尽。",
}
