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
	["The middle of {zone:1454}"] = "",

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

	-- Step 11: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983}在村庄东边的{area:2302}等候。跟着他去找雷瑟，并在随后爆发的战斗中保护他活下来。",

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
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkfang Lurkers = {npc:4411} Darkfang Lurker · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "向西返回，穿过沼泽。蕨墙村北面山脊上的暗牙毒蜘蛛会掉落毒囊。塞拉摩间谍（35-36级）潜行穿行于同一片树林中：它们处于潜行状态，要仔细寻找。\n暗雾蜘蛛聚集在蕨墙村西北面的洞口；所有种类都会掉落眼睛。\n小心：暗牙潜伏者（36-37级）会在脱战时使用潜行，战斗时施放毒药。\n小心：同一区域内潜行的蜘蛛看到你就会攻击。\n小心：暗雾潜伏者会潜行移动，进入战斗后使用毒药。蜘蛛站得很密，经常会引到额外怪物；从外围逐个引怪能减少这种情况。",

	-- Step 17: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Head east back to the {area:497}."] = "向东返回 {area:497}。",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}，现在{npc:4791}已经读过报告了",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "仅当你带着{item:3853}时（{skill:164}或拍卖行）",

	-- Step 18: The Theramore Docks
	["Underwater"] = "在水下",

	-- Step 19: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} in the village."] = "带着头颅向西返回蕨墙村：{npc:4503}站在道路进入村庄处的南缘，{npc:4791}在村子里。",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol
	["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "交给{object:3202}的{npc:2519}，在forever/horde/40-50/01-stranglethorn-vale指南中处理",

	-- Step 20: Level 37.5
	["Level 37.5"] = "等级37.5",
	-- {zone:1443} Desolace · {area:1316} Razorfen Downs · {area:796} Scarlet Monastery
	["{zone:1443}'s last quests and Alterac are 38-41. Still below 37.5 after Brackenwall's hand-ins? The Darkmist spiders and Lurkers (35-38) by the cavern north-west of the village are the closest: kill them until level 37.5. Or, with a group, run the {area:1316} dungeon or the {area:796} dungeon (Armory) instead."] = "",
	["Darkmist cavern"] = "",
	-- {npc:4377} Darkmist Lurker
	["grind on {npc:4377}"] = "",

	-- Step 21: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飞往{area:392}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "{area:496}的飞行管理员",

	-- Step 22: Ratchet
	-- {npc:3391} Gazlowe · {npc:3446} Mebok Mizzyrix
	["{npc:3391} waits upstairs in the house by the flight master; {npc:3446} stands below it, towards the docks."] = "{npc:3391}在飞行管理员旁房子的楼上等候；{npc:3446}在房子下方、靠码头的一侧。",
	-- {npc:3391} Gazlowe · {area:35} Booty Bay
	["{npc:3391}'s next errand takes you to {area:35}, off this part of the route: leave it."] = "{npc:3391}的下一个差事要去{area:35}，偏离这段路线：先不接。",
	-- {quest:1111} Wharfmaster Dizzywig
	["{quest:1111}, on the docks"] = "",
	-- {area:439} Shimmering Flats
	["Dizzywig's parts go back to Kravel in the {area:439}, off the route: leave them."] = "",

	-- Step 23: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "从{area:392}沿海岸向南前往{area:720}。{npc:6236}站在竞技场旁：踩上格栅开始战斗；挑战者会逐个上场，最后是{npc:6238}（33级）。",

	-- Step 24: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "飞往{area:2408}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}的飞行管理员",

	-- Step 25: Shadowprey Village
	-- {npc:11624} Taiga Wisemane
	["{npc:11624} stands in the village."] = "{npc:11624}站在村里。",

	-- Step 26: Portals of the Legion
	-- {area:602} Mannoroc Coven · {quest:5381} Hand of Iruxos · {npc:11624} Taiga Wisemane · {npc:11937} Demon Portal Guardian
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. With the {quest:5381} from {npc:11624} in your bags, open a demon portal's ring: a {npc:11937} (38-39) comes out; kill it to close that portal. Six portals. Careful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "",

	-- Step 27: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["North to the post; {npc:5412} stands beside {npc:5395}."] = "向北到哨所；{npc:5412}站在{npc:5395}旁。",

	-- Step 28: Valley of Spears
	-- {area:607} Valley of Spears · {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["West of the post, the Maraudine centaurs hold the {area:607}. Every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}."] = "哨所西边的{area:607}被玛洛迪半人马占据。所有玛洛迪半人马都可能掉落{item:254432}，以及{npc:5395}的{quest:1366}所需的耳朵。",

	-- Step 29: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277}被关在山谷最西端的玛洛迪营地；救出她，向东护送她离开山谷。\n小心：脚本刷出的敌群会一起行动，而且仅在护送期间出现，因此无法提前清理，也无法逐个引出。开始前先清理路上的普通半人马仍有帮助。",

	-- Step 30: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019}在{area:596}西侧的地精营地里等候。",

	-- Step 31: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {area:2657} Valley of Bones · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Head south-east to the bone fields of the {area:2657}, where Undead Ravagers roam. At the far south-east, use the {item:15848} to draw the Magrami Spectres: they drop the ghost-o-plasm."] = "向东南前往{area:2657}的白骨荒地，那里有亡灵劫掠者游荡。在最东南边使用{item:15848}引来玛格拉姆鬼魂：它们会掉落幽灵电浆。",

	-- Step 32: Hornizz Brimbuzzle
	-- {area:596} Kodo Graveyard
	["North to the goblin camp on the west side of the {area:596}."] = "向北到{area:596}西侧的地精营地。",

	-- Step 34: Shadowprey
	["Shadowprey"] = "葬影村",
	["West to Shadowprey."] = "向西到葬影村。",

	-- Step 35: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "从{area:2408}飞往{area:1638}，到{area:1639}找{npc:3033}训练；再从那里飞往{zone:1454}。",

	-- Step 36: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408}的飞行管理员",

	-- Step 37: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "返回{area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飞行管理员",

	-- Step 38: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "{npc:4485}站在{object:172958}。",

	-- Step 39: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars · {area:133} Gnomeregan
	["{npc:3412}'s workshop is in the {object:172958} beside {npc:4485}: hand in {quest:2841} if you ran {area:133}."] = "",

	-- Step 40: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "{zone:1454}训练师",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "趁在城里先训练；其他人接下来去{zone:1458}训练。",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "下一份指南会在正门外的飞艇塔乘坐前往{zone:1458}的飞艇。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "暗牙蜘蛛",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "交给{object:3202}的{npc:2519}，在下一个指南中",
	-- ["Head east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them.\nCareful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "向东前往 {area:602}。在每座恶魔传送门旁使用放逐法杖，关闭其中六座。\n小心：许多传送门附近都有地狱火、末日守卫和火刃召唤师游荡，可能加入战斗；先杀附近的小怪，或把守护者拉远，比如拉到集会所中央的湖边。",
	-- ["Hearth to Shadowprey"] = "用炉石回到葬影村",
	-- ["Hearth to {area:392}"] = "用炉石回到{area:392}",
	-- ["Kodo bones and ghosts"] = "科多兽骨和幽灵",
	-- ["Maraudine totems"] = "玛洛迪图腾",
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
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "火刃氏族占据着{area:2407}西北的要塞。在要塞里对{npc:11876}使用{item:14523}，获得{item:13542}。",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "黑雾蜘蛛聚集在蕨墙村西北的洞口；每种都会掉落眼球。",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "滑刃纳迦占据着{area:2405}北边直到{area:598}的海岸。{npc:12369}在最北端守护着{quest:6027}。",
	-- ["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "商队终点是{area:596}东侧{npc:11596}的营地。",
	-- ["The next guide takes you back to {zone:1434}."] = "下一个指南会带你回到{zone:1434}。",
	-- ["grind on {npc:4362}"] = "刷{npc:4362}升级",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "{npc:11626}的商队停在{area:602}边缘的路上。护送商队向东经过集会所；恶魔会袭击两次。",
	-- ["{npc:3412}, in the {object:172958} beside {npc:4485}: {quest:2841}, if you ran {area:133}"] = "{npc:3412}，在{object:172958}的{npc:4485}旁：如果刷过{area:133}，可交{quest:2841}",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395}和{npc:5412}站在{npc:11596}营地正西的哨站里。",
	-- ["{npc:6236}: Berserker Stance"] = "{npc:6236}：狂暴姿态",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
	-- ["{zone:1443}'s last quests and Alterac are 38-41. Below 37.5? Keep killing the Mirefin murlocs along the north-east coast, past {area:502}, until level 37.5. Or, with a group, run the {area:1316} dungeon or the {area:796} dungeon (Armory) instead."] = "{zone:1443}最后的任务和奥特兰克任务适合38-41级。还没到37.5级？沿东北海岸越过{area:502}，继续击杀泥鳍鱼人，直到37.5级。也可以组队刷{area:1316}地下城或{area:796}地下城的武器库。",
}
