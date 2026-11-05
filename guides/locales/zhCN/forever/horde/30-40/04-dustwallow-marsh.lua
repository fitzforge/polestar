-- Chinese (simplified) (zhCN): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "飞往{area:378}",
	-- {area:380} Crossroads
	["{area:380} flight master"] = "",

	-- Step 3: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "",

	-- Step 5: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "",

	-- Step 7: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "在岔路口沿道路向北，前往食人魔村庄蕨墙村。",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}，在道路进入村庄处的南缘",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "",

	-- Step 8: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983}在村庄东边的{area:2302}等候。跟着他去找雷瑟，并在随后爆发的战斗中保护他活下来。",

	-- Step 9: Brackenwall Village flight master
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "",

	-- Step 10: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:496} Brackenwall Village
	["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and head west through {zone:1412}), then on to {area:496}."] = "",

	-- Step 11: Back to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Back to {area:496}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 12: Stinky Ignatz
	["Stinky Ignatz"] = "伊格纳兹",
	-- {area:502} Witch Hill
	["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "",

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
	-- {quest:1218} Soothing Spices
	["{quest:1218}, for \"Swamp Eye\" Jarl"] = "",

	-- Step 15: Theramore Infiltrator on the way
	-- {npc:4834} Theramore Infiltrator
	["{npc:4834} on the way"] = "",
	-- {npc:4834} Theramore Infiltrator · {area:496} Brackenwall Village
	["{npc:4834} along the way to {area:496}"] = "",

	-- Step 16: Brackenwall Village: kill these as you meet them
	-- {area:496} Brackenwall Village
	["{area:496}: kill these as you meet them"] = "",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkfang Lurkers = {npc:4411} Darkfang Lurker · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "",

	-- Step 18: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Head east back to the {area:497}."] = "",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}，现在{npc:4791}已经读过报告了",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "仅当你带着{item:3853}时（{skill:164}或拍卖行）",

	-- Step 19: The Theramore Docks
	["Underwater"] = "",

	-- Step 21: Nazeer Bloodpike
	["Head back west to Brackenwall with the head."] = "",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol
	["For {npc:2519} at {object:3202}, in the next guide"] = "交给{object:3202}的{npc:2519}，在下一个指南中",

	-- Step 22: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",

	-- Step 24: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 26: Melizza Brimbuzzle
	-- {area:607} Valley of Spears · {npc:12277} Melizza Brimbuzzle
	["Head north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",

	-- Step 27: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019}在{area:596}西侧的地精营地里等候。",

	-- Step 28: Kormek's Hut
	["Head north up the road to the hut by the road north of the graveyard."] = "",

	-- Step 29: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5412} Gurda Wildmane
	["{npc:5395} and {npc:5412} stand in the post just west of Smeed's camp."] = "",

	-- Step 30: Kodo bones
	["Kodo bones"] = "",
	["Pick up the kodo bones scattered across the graveyard."] = "",

	-- Step 32: Burning Blade Seer
	-- {area:599} Thunder Axe Fortress · {area:2405} Ethel Rethor
	["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "",
	["On the top floor"] = "",

	-- Step 33: Thunder Axe Fortress
	-- {area:2407} Kormek's Hut · {item:14523} Demon Pick · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "火刃氏族占据着{area:2407}西北的要塞。在要塞里对{npc:11876}使用{item:14523}，获得{item:13542}。",

	-- Step 34: Ethel Rethor
	["His next errand is not on this route."] = "",

	-- Step 35: Slitherblade coast
	["Slitherblade coast"] = "滑刃海岸",
	-- {area:2405} Ethel Rethor · {area:598} Sar'theris Strand · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "滑刃纳迦占据着{area:2405}北边直到{area:598}的海岸。{npc:12369}在最北端守护着{quest:6027}。",
	-- {npc:4711} Slitherblade Naga · {area:598} Sar'theris Strand
	["{npc:4711} walks around {area:598}: look inside the circle on the map"] = "",
	-- {npc:4714} Slitherblade Myrmidon · {area:598} Sar'theris Strand
	["{npc:4714} walks around {area:598}: look inside the circle on the map"] = "",

	-- Step 37: Maraudine totems
	["Maraudine totems"] = "玛洛迪图腾",
	-- {area:2405} Ethel Rethor · {area:607} Valley of Spears · {quest:93225} Carved Centaur Totems
	-- plural, as words: Maraudine Scouts = {npc:4654} Maraudine Scout
	["Head south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "",

	-- Step 38: Shadowprey Village
	["Head on south-west to Shadowprey."] = "",

	-- Step 39: Portals of the Legion
	-- {area:602} Mannoroc Coven
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them.\nCareful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "",

	-- Step 40: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "",
	-- {area:2657} Valley of Bones · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Head south-east from the coven to the bone fields of the {area:2657}, where Undead Ravagers roam. At the far south-east, use the {item:15848} to draw the Magrami Spectres: they drop the ghost-o-plasm."] = "",

	-- Step 41: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {area:597} Ghost Walker Post
	["Head north to {npc:5412} at {area:597}."] = "",

	-- Step 43: Shadowprey
	["Shadowprey"] = "",
	-- {zone:1434} Stranglethorn Vale
	["The next guide takes you back to {zone:1434}."] = "下一个指南会带你回到{zone:1434}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "暗牙蜘蛛",
	-- ["Hearth to Shadowprey"] = "用炉石回到葬影村",
	-- ["Hearth to {area:392}"] = "用炉石回到{area:392}",
	-- ["Kodo bones and ghosts"] = "科多兽骨和幽灵",
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
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "黑雾蜘蛛聚集在蕨墙村西北的洞口；每种都会掉落眼球。",
	-- ["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "商队终点是{area:596}东侧{npc:11596}的营地。",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "{npc:11626}的商队停在{area:602}边缘的路上。护送商队向东经过集会所；恶魔会袭击两次。",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395}和{npc:5412}站在{npc:11596}营地正西的哨站里。",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
}
