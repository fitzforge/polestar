-- Chinese (simplified) (zhCN): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",

	-- Step 2: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "{zone:1454}中央",

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}，交给“沼泽之眼”加尔",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {area:720} Fray Island
	["{npc:3354}, {object:172958}: for {area:720}, later in this guide (offered from level 30)"] = "{object:172958}的{npc:3354}：前往{area:720}的任务，本指南稍后再做（30级可接）",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "飞往十字路口",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428}站在十字路口飞行管理员旁。",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "交给{zone:1454}的{npc:4485}，本指南结尾再做",

	-- Step 6: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "飞往{area:378}",
	["Crossroads flight master"] = "十字路口飞行管理员",

	-- Step 8: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "从 {area:378} 沿道路向东进入沼泽。越过地区边界后不远，道路旁便是被烧毁的 {area:403}；盾牌、徽章和蹄印就在废墟里及附近。",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "在岔路口沿道路向北，前往食人魔村庄蕨墙村。",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}，在道路进入村庄处的南缘",

	-- Step 12: Stinky Ignatz
	["Stinky Ignatz"] = "伊格纳兹",
	-- {area:502} Witch Hill
	["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "向北前往{area:502}。伊格纳兹站在山脚下；护送他去南面不远处采集他要的植物叶片。",

	-- Step 13: Mirefin murlocs
	["Mirefin murlocs"] = "黑鳍鱼人",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "黑鳍鱼人聚集在{area:502}东边和东北边的海岸上；每种都会掉落头。",

	-- Step 14: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "“沼泽之眼”加尔",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "加尔住在{area:502}东南的{area:497}。",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}，在庄园旁边",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "{quest:1218}，如果之前没在{zone:1454}购买",

	-- Step 15: Brackenwall Village: kill these as you meet them
	-- {area:496} Brackenwall Village
	["{area:496}: kill these as you meet them"] = "{area:496}：沿途遇到就击杀",
	-- plural, as words: Darkfang Lurkers = {npc:4411} Darkfang Lurker · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Lurkers (36-37) and Venomspitters (37-38) on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes. Work its outer edge, where the Spiders and Recluses (35-37) stand: the Lurkers and Silkspinners (37-39) deeper in are two or three over you.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "向西返回，穿过沼泽。蕨墙村北面山脊上的暗牙潜伏者（36-37级）和暗牙毒蜘蛛（37-38级）会掉落毒囊。塞拉摩间谍（35-36级）潜行穿行于同一片树林中：它们处于潜行状态，要仔细寻找。\n暗雾蜘蛛聚集在蕨墙村西北面的洞口；所有种类都会掉落眼睛。在外围打蜘蛛和隐士蛛（35-37级）：更深处的潜伏者和织丝蛛（37-39级）比你高两三级。\n小心：暗牙潜伏者（36-37级）会在脱战时使用潜行，战斗时施放毒药。\n小心：同一区域内潜行的蜘蛛看到你就会攻击。\n小心：暗雾潜伏者会潜行移动，进入战斗后使用毒药。蜘蛛站得很密，经常会引到额外怪物；从外围逐个引怪能减少这种情况。",
	-- plural, as words: Giant Darkfang Spiders = {npc:4415} Giant Darkfang Spider
	["Every Darkfang spider drops them: Lurkers, Spiders, Venomspitters and the Giant Darkfang Spiders"] = "",

	-- Step 18: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire · {npc:5046} Lieutenant Caldwell · {npc:5045} Private Hallan
	["On the way east, follow {npc:4983} into the {area:2302} and protect him at Reethe's tent. {npc:5046} (37), {npc:5045} and the skirmishers attack together. If {npc:4983} is away with another party, wait for his return before starting."] = "",

	-- Step 19: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["On east to the {area:497}."] = "继续向东前往{area:497}。",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}，现在{npc:4791}已经读过报告了",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "仅当你带着{item:3853}时（{skill:164}或拍卖行）",

	-- Step 20: The Theramore Docks
	-- {area:513} Theramore Isle · {object:20925} Captain's Footlocker
	-- plural, as words: Young Murk Threshers = {npc:4388} Young Murk Thresher
	["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer. Young Murk Threshers (40-41) circle in the water around the docks: grab the footlocker and swim straight out."] = "从庄园向东南前往{area:513}：{object:20925}在岛东侧码头外的海底。游进游出，远离码头栈桥和城镇：塞拉摩的卫兵是53-57级，在这里死亡的话，从灵魂医者那里跑回来要很久。幼年黑色蛇颈龙（40-41级）在码头周围的水中游弋：拿到手提箱就直接游出去。",
	["Underwater"] = "在水下",

	-- Step 21: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike · {npc:4926} Krog
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} and {npc:4926} in the village."] = "带着头颅向西返回蕨墙村：{npc:4503}站在道路进入村庄处的南缘，{npc:4791}和{npc:4926}在村子里。",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol
	["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "交给{object:3202}的{npc:2519}，在forever/horde/40-50/01-stranglethorn-vale指南中处理",

	-- Step 22: Level 36
	["Level 36"] = "等级 36",
	-- {area:405} Desolace
	-- plural, as words: Drywallow Crocolisks = {npc:4341} Drywallow Crocolisk
	-- was: ["{zone:1443}'s last quests are 36-39. Still below 36 after Brackenwall's hand-ins? The Drywallow Crocolisks (35-36) along the river east of the village are the closest at your level: kill them until level 36."] = "{zone:1443}最后的任务为36-39级。交还蕨墙村的任务后还不到36级？村庄东边河边的尘泥鳄鱼（35-36级）是离你最近的同等级怪物：杀到36级为止。"
	["{area:405}'s last quests are 36-39. Still below 36 after Brackenwall's hand-ins? The Drywallow Crocolisks (35-36) along the river east of the village are the closest at your level: kill them until level 36."] = "",
	-- plural, as words: Drywallow Crocolisks = {npc:4341} Drywallow Crocolisk
	["Drywallow Crocolisks"] = "尘泥鳄鱼",
	-- {npc:4341} Drywallow Crocolisk
	["grind on {npc:4341}"] = "刷{npc:4341}升级",

	-- Step 23: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飞往{area:392}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "{area:496}的飞行管理员",

	-- Step 24: Ratchet
	-- {npc:3446} Mebok Mizzyrix
	["{npc:3446} stands below Gazlowe's house by the flight master, towards the docks."] = "{npc:3446}站在飞行管理员旁加兹鲁维的房子下方、靠码头的一侧。",

	-- Step 25: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "从{area:392}沿海岸向南前往{area:720}。{npc:6236}站在竞技场旁：踩上格栅开始战斗；挑战者会逐个上场，最后是{npc:6238}（33级）。",

	-- Step 26: Hearth to Shadowprey Village
	-- {area:2408} Shadowprey Village
	-- was: ["Hearth to Shadowprey"] = "用炉石回到葬影村"
	["Hearth to {area:2408}"] = "",
	-- {area:392} Ratchet · {area:720} Fray Island
	["Finished in {area:392} or on {area:720}? Use your Hearthstone now, before walking back to a flight master."] = "",

	-- Step 27: Ratchet flight master
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}的飞行管理员",
	-- {area:392} Ratchet
	["Back north along the coast to {area:392}'s flight master."] = "沿海岸向北返回{area:392}的飞行管理员处。",

	-- Step 28: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "飞往{area:2408}",
	-- {area:2408} Shadowprey Village · {area:405} Desolace · {zone:1442} Stonetalon Mountains · {area:465} Charred Vale
	["Ask the flight master for {area:2408}. If there is no connecting flight, head for {area:405} through {zone:1442} and the {area:465}."] = "",

	-- Step 29: Road to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Road to {area:2408}"] = "",
	-- {area:405} Desolace · {zone:1442} Stonetalon Mountains · {area:465} Charred Vale
	["If you don't have a flight to Shadowprey, take an offered flight toward {area:405} or follow the road west through {zone:1442} and the {area:465}. In {area:405}, stay on the road to the Horde village on the south-west coast."] = "",

	-- Step 30: Shadowprey Village
	-- {npc:11624} Taiga Wisemane · {npc:12340} Drulzegar Skraghook
	["{npc:11624} and {npc:12340} stand in the village."] = "{npc:11624}和{npc:12340}站在村里。",
	-- {npc:11624} Taiga Wisemane · {quest:5381} Hand of Iruxos · {area:599} Thunder Axe Fortress
	["{npc:11624}: the {quest:5381}, at {area:599} later on this visit"] = "{npc:11624}：{quest:5381}，本次稍后在{area:599}完成",
	-- {npc:12340} Drulzegar Skraghook · {area:599} Thunder Axe Fortress
	["{npc:12340}: the Slitherblade of Sar'theris Strand, on the way back from {area:599}"] = "{npc:12340}：萨瑟里斯海岸的滑刃鱼人，从{area:599}返回途中完成",

	-- Step 31: Ghost Walker Post
	-- {area:597} Ghost Walker Post · {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["East along the road to {area:597}; {npc:5412} stands beside {npc:5395}."] = "沿道路向东前往{area:597}；{npc:5412}站在{npc:5395}旁。",
	-- {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["{npc:5395}: his {quest:1366}, from the same Maraudine as Gurda's totems"] = "{npc:5395}：他的{quest:1366}，目标和古尔达的图腾一样，都是玛洛迪半人马",

	-- Step 32: Valley of Spears
	-- {area:607} Valley of Spears · {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty · {npc:5402} Khan Hratha
	-- plural, as words: Rock Worms = {npc:11788} Rock Worm
	["West of the post, the Maraudine centaurs hold the {area:607}; every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}. Stay with the Scouts and Wranglers (36-38) at the valley's eastern edge; the Maulers and Windchasers (38-39) a little further in are up to two over you at 37: pull them one at a time.\nCareful: {npc:5402} and the Rock Worms (41-42, elite) hold the valley's north-western end with the Khan Guards and Marauders (39-40), and the Magram's village in the south-east has Necromancers (42-43): keep east of the arrow."] = "哨站以西，玛洛迪半人马占据着{area:607}；每个玛洛迪半人马都可能掉落{item:254432}，以及{npc:5395}的{quest:1366}所需的耳朵。待在山谷东缘打斥候和驯犬者（36-38级）；稍往里一点的重槌手和逐风者（38-39级）比37级的你最多高两级：一次只拉一个。\n小心：{npc:5402}和岩石虫（41-42级，精英）与可汗卫兵、掠夺者（39-40级）一起占据山谷西北端，东南边的玛格拉姆村里还有亡灵巫师（42-43级）：待在箭头以东。",

	-- Step 33: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277}被关在山谷最西端的玛洛迪营地；救出她，向东护送她离开山谷。\n小心：脚本刷出的敌群会一起行动，而且仅在护送期间出现，因此无法提前清理，也无法逐个引出。开始前先清理路上的普通半人马仍有帮助。",

	-- Step 34: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019}在{area:596}西侧的地精营地里等候。",
	-- {npc:6019} Hornizz Brimbuzzle · {area:602} Mannoroc Coven
	["{npc:6019}: the ghost-o-plasm, after {area:602} at the end of this visit"] = "{npc:6019}：幽灵电浆，这一趟最后打完{area:602}后再交",

	-- Step 36: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["North up the road to {area:599}. Clear the middle of the largest building, then use the {item:14523} on the red {object:176581} there. A {npc:11876} (37) comes out: kill it for the {item:13542}. The Burning Blade around it are well under you now."] = "沿道路向北前往{area:599}。清理最大建筑的中间区域，然后对那里红色的{object:176581}使用{item:14523}。会出来一只{npc:11876}（37级）：杀死它获得{item:13542}。周围的火刃怪物现在等级已远低于你。",
	-- {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal
	["{item:14523}, on the {object:176581}"] = "{item:14523}，在{object:176581}上",

	-- Step 37: Sar'theris Strand
	-- {area:598} Sar'theris Strand
	-- plural, as words: Slitherblade Myrmidons = {npc:4714} Slitherblade Myrmidon
	["West from the fortress to the coast at {area:598}: the Slitherblade Myrmidons, Naga and Sorceresses hold the beach. Pull them one at a time; the Sea Witches and Oracles (34-36) cast from range."] = "从要塞向西到{area:598}的海岸：滑刃侍从、纳迦和女巫占据着海滩。一次只拉一个；海妖和神谕者（34-36级）会远程施法。",

	-- Step 38: Shadowprey Village
	-- {npc:11624} Taiga Wisemane · {area:602} Mannoroc Coven · {npc:12340} Drulzegar Skraghook
	["South down the coast to Shadowprey: {npc:11624} takes the box and sends you to {area:602} with it; {npc:12340} takes the naga."] = "沿海岸向南回到葬影村：{npc:11624}收下盒子，并让你带着它去{area:602}；纳迦的任务交给{npc:12340}。",

	-- Step 39: Portals of the Legion
	-- {area:602} Mannoroc Coven · {quest:5381} Hand of Iruxos · {npc:11624} Taiga Wisemane · {npc:11937} Demon Portal Guardian
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. With the {quest:5381} from {npc:11624} in your bags, open a demon portal's ring: a {npc:11937} (38-39) comes out; kill it to close that portal. Six portals. Careful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "向东前往{area:602}。将从{npc:11624}那里取得的{quest:5381}放在背包里，打开恶魔传送门的圆环，就会出现一只{npc:11937}（38-39级）；杀死它即可关闭这座传送门，共需关闭六座。注意：许多传送门附近都有地狱火、末日守卫和火刃召唤师游荡，可能加入战斗；先清掉附近怪物，或把守护者拉远，比如拉到集会所中央的湖边。",

	-- Step 40: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {area:2657} Valley of Bones · {area:405} Desolace · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan
	-- was: ["South-east of the coven, the bone fields of the {area:2657}, where Undead Ravagers roam, at {zone:1443}'s southern edge: keep south of the Magram's village on the way. Use the {item:15848} at the arrow to draw the Magrami Spectres (38-39): they come in numbers, so fight them with your back to the valley's edge. They drop the ghost-o-plasm.\nCareful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields just west of the arrow, well above you: use the crate at the arrow, on the valley's eastern side, and pull the spectres away from them."] = "集会所东南方是{area:2657}的白骨荒地，那里有亡灵劫掠者游荡，位于{zone:1443}的南缘：途中要绕到玛格拉姆村以南。在箭头处使用{item:15848}引来玛格拉姆鬼魂（38-39级）：它们成群而来，所以背靠山谷边缘作战。它们会掉落幽灵电浆。\n小心：玛格拉姆死灵可汗和玛格拉姆食尸者（45级，精英）在箭头正西边的白骨荒地上走动，等级远高于你：在山谷东侧的箭头处使用箱子，并把鬼魂从它们身边引开。"
	["South-east of the coven, the bone fields of the {area:2657}, where Undead Ravagers roam, at {area:405}'s southern edge: keep south of the Magram's village on the way. Use the {item:15848} at the arrow to draw the Magrami Spectres (38-39): they come in numbers, so fight them with your back to the valley's edge. They drop the ghost-o-plasm.\nCareful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields just west of the arrow, well above you: use the crate at the arrow, on the valley's eastern side, and pull the spectres away from them."] = "",

	-- Step 41: Hornizz Brimbuzzle
	-- {area:596} Kodo Graveyard · {area:602} Mannoroc Coven
	["North-west to the goblin camp on the west side of the {area:596}, back past {area:602}: keep west of the Magram's village."] = "向西北返回，经过{area:602}，前往{area:596}西侧的地精营地：保持在玛格拉姆村以西。",

	-- Step 42: Shadowprey
	["Shadowprey"] = "葬影村",
	-- {npc:11624} Taiga Wisemane · {area:2408} Shadowprey Village · {area:596} Kodo Graveyard
	["Return to {npc:11624} in {area:2408}. If your Hearthstone is still bound there and ready, use it; otherwise take the road west around the {area:596}."] = "",

	-- Step 43: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "从{area:2408}飞往{area:1638}，到{area:1639}找{npc:3033}训练；再从那里飞往{zone:1454}。",

	-- Step 44: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408}的飞行管理员",

	-- Step 45: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "返回{area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飞行管理员",

	-- Step 46: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "{npc:4485}站在{object:172958}。",

	-- Step 47: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars · {area:133} Gnomeregan
	["{npc:3412}'s workshop is in the {object:172958} beside {npc:4485}: hand in {quest:2841} if you ran {area:133}."] = "{npc:3412}的工坊在{object:172958}，就在{npc:4485}旁边：如果打过{area:133}，就在这里交还{quest:2841}。",

	-- Step 48: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "{zone:1454}训练师",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "趁在城里先训练；其他人接下来去{zone:1458}训练。",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "下一份指南会在正门外的飞艇塔乘坐前往{zone:1458}的飞艇。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "暗牙蜘蛛",
	-- ["Darkmist cavern"] = "暗雾洞穴",
	-- ["Fly to {area:2408} from the flight master you are next to: {area:392}'s, or Brackenwall's if you had no errand in {area:392}."] = "从你身边的飞行管理员飞往{area:2408}：{area:392}的，或者如果你在{area:392}没有事要办，就用蕨墙村的。",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "交给{object:3202}的{npc:2519}，在下一个指南中",
	-- ["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} in the village."] = "带着头颅向西返回蕨墙村：{npc:4503}站在道路进入村庄处的南缘，{npc:4791}在村子里。",
	-- ["Head east back to the {area:497}."] = "向东返回 {area:497}。",
	-- ["Head east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them.\nCareful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "向东前往 {area:602}。在每座恶魔传送门旁使用放逐法杖，关闭其中六座。\n小心：许多传送门附近都有地狱火、末日守卫和火刃召唤师游荡，可能加入战斗；先杀附近的小怪，或把守护者拉远，比如拉到集会所中央的湖边。",
	-- ["Head south-east to the bone fields of the {area:2657}, where Undead Ravagers roam, at {zone:1443}'s southern edge. Use the {item:15848} at the arrow to draw the Magrami Spectres: they drop the ghost-o-plasm.\nCareful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields just west of the arrow, well above you: use the crate at the arrow, on the valley's eastern side, and pull the spectres away from them."] = "向东南前往{area:2657}的白骨荒地，那里有亡灵劫掠者游荡，位于{zone:1443}的南缘。在箭头处使用{item:15848}引来玛格拉姆鬼魂：它们会掉落幽灵电浆。\n小心：玛格拉姆死灵可汗和玛格拉姆食尸者（45级，精英）在箭头正西边的白骨荒地上走动，等级远高于你：在山谷东侧的箭头处使用箱子，并把鬼魂从它们身边引开。",
	-- ["Head west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "向西返回，穿过沼泽。蕨墙村北面山脊上的暗牙毒蜘蛛会掉落毒囊。塞拉摩间谍（35-36级）潜行穿行于同一片树林中：它们处于潜行状态，要仔细寻找。\n暗雾蜘蛛聚集在蕨墙村西北面的洞口；所有种类都会掉落眼睛。\n小心：暗牙潜伏者（36-37级）会在脱战时使用潜行，战斗时施放毒药。\n小心：同一区域内潜行的蜘蛛看到你就会攻击。\n小心：暗雾潜伏者会潜行移动，进入战斗后使用毒药。蜘蛛站得很密，经常会引到额外怪物；从外围逐个引怪能减少这种情况。",
	-- ["Hearth to Shadowprey"] = "用炉石回到葬影村",
	-- ["Hearth to Shadowprey: your hearthstone is still bound there."] = "用炉石回葬影村：你的炉石仍绑定在那里。",
	-- ["Hearth to {area:392}"] = "用炉石回到{area:392}",
	-- ["Kodo bones and ghosts"] = "科多兽骨和幽灵",
	-- ["Level 37.5"] = "等级37.5",
	-- ["Maraudine totems"] = "玛洛迪图腾",
	-- ["North to the goblin camp on the west side of the {area:596}."] = "向北到{area:596}西侧的地精营地。",
	-- ["North to the post; {npc:5412} stands beside {npc:5395}."] = "向北到哨所；{npc:5412}站在{npc:5395}旁。",
	-- ["On the way east, {npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out: {npc:5045} and Theramore Skirmishers (36) join it."] = "向东途中，{npc:4983}在村庄东边的{area:2302}等候。跟着他去找雷瑟，并在随后爆发的战斗中保护他活下来：{npc:5045}和塞拉摩散兵（36级）会加入战斗。",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "捡起散落在坟场各处的科多兽骨，并在骨头间使用{item:15848}：被吸引来的幽灵会掉落幽灵电浆。",
	-- ["Ride back west to Brackenwall with the head."] = "带着头颅向西骑回蕨墙村。",
	-- ["Ride east back to the {area:497}."] = "向东骑回{area:497}。",
	-- ["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "从{area:378}沿道路向东骑进沼泽。烧毁的{area:403}就在边界过去一点的路旁；盾牌、徽章和蹄印都在废墟里面和旁边。",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "向东骑往{area:602}。在每个恶魔传送门旁使用任务给你的放逐法杖，关闭其中六个。",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "从集会所向北骑往{area:597}的{npc:5412}。",
	-- ["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "向北骑往{area:502}。伊格纳兹站在山脚下；在他到山南边采集叶子时护送他。",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "沿道路向北骑往坟场北边路旁的小屋。",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "向东北骑往{area:607}。{npc:12277}被关在玛洛迪半人马的营地里；救出她，护送她从山谷东边出去。",
	-- ["Ride on south-west to Shadowprey."] = "继续向西南骑往葬影村。",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "从{area:2405}向南骑进{area:607}。玛洛迪斥候、玛洛迪争斗者、玛洛迪虐待者、玛洛迪逐风者和玛洛迪掠夺者（36-39级）掉落{quest:93225}。",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "向西骑回沼泽对面。蕨墙村北边山脊上的暗牙毒蜘蛛掉落毒囊。塞拉摩间谍（35-36级）潜伏在同一片树林里：他们处于潜行状态，所以要仔细看。",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "向西骑往西北海岸{area:2405}的{npc:11863}之塔。",
	-- ["Slitherblade coast"] = "滑刃海岸",
	-- ["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer."] = "从庄园向东南前往{area:513}：{object:20925}在岛东侧码头外的海底。游进游出，远离码头栈桥和城镇：塞拉摩的卫兵是53-57级，在这里死亡的话，从灵魂医者那里跑回来要很久。",
	-- ["South-east of the coven, the bone fields of the {area:2657}, where Undead Ravagers roam, at {zone:1443}'s southern edge: keep south of the Magram's village on the way. Use the {item:15848} at the arrow to draw the Magrami Spectres (38-39): they come in numbers, so fight them with your back to the valley's edge. They drop the ghost-o-plasm.\nCareful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields just west of the arrow, well above you: use the crate at the arrow, on the valley's eastern side, and pull the spectres away from them."] = "集会所东南方是{area:2657}的白骨荒地，那里有亡灵劫掠者游荡，位于{zone:1443}的南缘：途中要绕到玛格拉姆村以南。在箭头处使用{item:15848}引来玛格拉姆鬼魂（38-39级）：它们成群而来，所以背靠山谷边缘作战。它们会掉落幽灵电浆。\n小心：玛格拉姆死灵可汗和玛格拉姆食尸者（45级，精英）在箭头正西边的白骨荒地上走动，等级远高于你：在山谷东侧的箭头处使用箱子，并把鬼魂从它们身边引开。",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "火刃氏族占据着{area:2407}西北的要塞。在要塞里对{npc:11876}使用{item:14523}，获得{item:13542}。",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "黑雾蜘蛛聚集在蕨墙村西北的洞口；每种都会掉落眼球。",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "滑刃纳迦占据着{area:2405}北边直到{area:598}的海岸。{npc:12369}在最北端守护着{quest:6027}。",
	-- ["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "商队终点是{area:596}东侧{npc:11596}的营地。",
	-- ["The next guide takes you back to {zone:1434}."] = "下一个指南会带你回到{zone:1434}。",
	-- ["West of the post, the Maraudine centaurs hold the {area:607}. Every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}. Stay with the Maraudine (36-39) in the valley: the Magram's village in the south-east has the same drops, but its Necromancers (42-43) and Guardians (39-41) are well above you."] = "哨所西边的{area:607}被玛洛迪半人马占据。所有玛洛迪半人马都可能掉落{item:254432}，以及{npc:5395}的{quest:1366}所需的耳朵。待在山谷里的玛洛迪半人马（36-39级）这边：东南方的玛格拉姆村落也掉落同样的东西，但那里的死灵法师（42-43级）和守护者（39-41级）等级远高于你。",
	-- ["West to Shadowprey."] = "向西到葬影村。",
	-- ["grind on {npc:4362}"] = "刷{npc:4362}升级",
	-- ["grind on {npc:4377}"] = "刷{npc:4377}升级",
	-- ["{npc:11624} stands in the village."] = "{npc:11624}站在村里。",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "{npc:11626}的商队停在{area:602}边缘的路上。护送商队向东经过集会所；恶魔会袭击两次。",
	-- ["{npc:3391} waits upstairs in the house by the flight master; {npc:3446} stands below it, towards the docks."] = "{npc:3391}在飞行管理员旁房子的楼上等候；{npc:3446}在房子下方、靠码头的一侧。",
	-- ["{npc:3391}'s next errand takes you to {area:35}, off this part of the route: leave it."] = "{npc:3391}的下一个差事要去{area:35}，偏离这段路线：先不接。",
	-- ["{npc:3391}: for {npc:4631} in {area:35}, on the first {area:35} stop of 40-50"] = "{npc:3391}：交给{area:35}的{npc:4631}，在40-50级指南第一次到{area:35}时处理",
	-- ["{npc:3412}, in the {object:172958} beside {npc:4485}: {quest:2841}, if you ran {area:133}"] = "{npc:3412}，在{object:172958}的{npc:4485}旁：如果刷过{area:133}，可交{quest:2841}",
	-- ["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983}在村庄东边的{area:2302}等候。跟着他去找雷瑟，并在随后爆发的战斗中保护他活下来。",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395}和{npc:5412}站在{npc:11596}营地正西的哨站里。",
	-- ["{npc:5395}: his {quest:1366}, from the same Maraudine"] = "{npc:5395}：他的{quest:1366}，来自同一批玛洛迪半人马",
	-- ["{npc:6236}: Berserker Stance"] = "{npc:6236}：狂暴姿态",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
	-- ["{zone:1443}'s last quests and Alterac are 38-41. Below 37.5? Keep killing the Mirefin murlocs along the north-east coast, past {area:502}, until level 37.5. Or, with a group, run the {area:1316} dungeon or the {area:796} dungeon (Armory) instead."] = "{zone:1443}最后的任务和奥特兰克任务适合38-41级。还没到37.5级？沿东北海岸越过{area:502}，继续击杀泥鳍鱼人，直到37.5级。也可以组队刷{area:1316}地下城或{area:796}地下城的武器库。",
	-- ["{zone:1443}'s last quests and Alterac are 38-41. Still below 37.5 after Brackenwall's hand-ins? The Darkmist spiders and Lurkers (35-38) by the cavern north-west of the village are the closest: kill them until level 37.5."] = "{zone:1443}最后的任务和奥特兰克任务适合38-41级。交还蕨墙村的任务后仍未到37.5级，就在村庄西北侧洞穴附近击杀最近的暗雾蜘蛛和暗雾潜伏者（35-38级），直到37.5级。",
	-- ["{zone:1443}'s last quests are 36-39. Still below 36 after Brackenwall's hand-ins? The Drywallow Crocolisks (35-36) along the river east of the village are the closest at your level: kill them until level 36."] = "{zone:1443}最后的任务为36-39级。交还蕨墙村的任务后还不到36级？村庄东边河边的尘泥鳄鱼（35-36级）是离你最近的同等级怪物：杀到36级为止。",
}
