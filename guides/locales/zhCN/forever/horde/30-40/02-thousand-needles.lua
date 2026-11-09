-- Chinese (simplified) (zhCN): the guide forever/horde/30-40/02-thousand-needles (forever/horde/30-40/02-thousand-needles.guide).
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

	-- Step 2: Alliance Relations
	-- {zone:1454} Orgrimmar · {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits
	["The zeppelin lands at the tower outside {zone:1454}'s main gate. {npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city."] = "飞艇停靠在{zone:1454}正门外的高塔。{npc:5639}在暗巷区等候；{npc:5640}位于城西的{object:172961}。",
	-- {npc:5639} Craven Drok
	["{npc:5639}: offered from level 30"] = "{npc:5639}：30级起可接",
	-- {npc:5641} Takata Steelblade · {zone:1443} Desolace
	["for {npc:5641} in {zone:1443}, later in this guide"] = "交给{zone:1443}的{npc:5641}，本指南稍后会去",

	-- Step 3: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "{zone:1454}的训练师",
	["Train while you are in the city."] = "趁在城里学习技能。",

	-- Step 4: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892}站在{object:172957}。",
	-- {npc:5892} Searn Firewarder · {npc:5905} Prate Cloudseer · {area:484} Freewind Post
	["{npc:5892}: for {npc:5905} by {area:484}, later in this guide"] = "{npc:5892}：交给{area:484}附近的{npc:5905}，本指南稍后会去",

	-- Step 5: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {quest:2841} Rig Wars · {area:133} Gnomeregan · {zone:1454} Orgrimmar
	["{npc:3412}'s workshop is in the {object:172958}. {quest:2841} is {area:133}'s last boss: great XP if you run it with a group. Run it whenever your group is ready; hand it in on a later {zone:1454} stop."] = "{npc:3412}的工坊位于{object:172958}。{quest:2841}的目标是{area:133}的最终首领，组队完成可获得大量经验。队伍准备好后随时可去，之后途经{zone:1454}时再交任务。",

	-- Step 6: Gnomeregan
	-- {area:133} Gnomeregan · {npc:7800} Mekgineer Thermaplugg · {item:9153} Rig Blueprints
	["Run {area:133} with a group when it suits you: {npc:7800} at the end drops his Safe Combination; open his safe behind the northern bomb pillar for the {item:9153}."] = "方便时组队前往{area:133}：最终首领{npc:7800}会掉落他的Safe Combination；用它打开北侧炸弹柱后方的保险箱，取得{item:9153}。",

	-- Step 7: Orgrimmar flight master
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 8: Thunder Bluff
	-- {zone:1454} Orgrimmar · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {area:484} from there."] = "从{zone:1454}飞往{area:1638}，在{area:1639}向{npc:3033}学习技能，再从那里飞往{area:484}。",

	-- Step 9: Islen Waterseer
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:5901} Islen Waterseer · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to {area:484} from {area:392}."] = "从{zone:1454}飞往{area:392}。{npc:5901}的营地在镇子南边不远的海岸上；之后从{area:392}飞往{area:484}。",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}：{npc:3527}和你的{item:5177}",

	-- Step 10: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "飞往{area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飞行管理员",

	-- Step 11: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}的飞行管理员",

	-- Step 13: Prate Cloudseer
	-- {npc:5905} Prate Cloudseer
	["{npc:5905} hides in a small cave in the canyon wall north-east of the post, on the way east."] = "{npc:5905}藏在岗哨东北方向峡谷岩壁上的小洞穴里，向东走时会经过。",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}：你的{item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905}还会开始元素援助（{area:1717}），这是通往风暴武器的33-40级任务线：见萨满祭司职业指南“空气的召唤和风暴武器（部落）”。",

	-- Step 14: Moktar Krin
	-- {npc:4483} Moktar Krin
	["Take the lift down and follow the canyon east. {npc:4483} camps on the north-western edge of the salt flats."] = "乘升降梯下去，沿峡谷向东。{npc:4483}的营地在盐碱地的西北边缘。",

	-- Step 15: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "{area:2240}的地精和侏儒是中立的，双方阵营都能接他们的任务。",
	-- {npc:4452} Kravel Koalbeard · {quest:5762} Hemet Nesingwary
	["{npc:4452}'s crate for {quest:5762} in Stranglethorn, later on the route"] = "{npc:4452}的箱子，留给荆棘谷的{quest:5762}，后续路线会去",

	-- Step 16: The southern flats
	["The southern flats"] = "南部盐碱地",
	-- plural, as words: Saltstone Crystalhides = {npc:4151} Saltstone Crystalhide
	["South of the raceway, the Saltstone Crystalhides (32-33) and Gazers (34-35) roam the far end of the flats."] = "赛道南方，盐石水晶蜥蜴（32-33）和盐石凝视者（34-35）游荡在盐碱地的远端。",

	-- Step 17: The Rustmaul Dig Site
	-- {item:5877} Cracked Silithid Carapace
	["West of them the silithid swarm the dig site. Searchers and Hive Drones walk among the mounds; the Invaders (34-35) stay inside the hive cave. The first silithid you kill drops a {item:5877}: open it.\nCareful: Hive Drones call for help when they fall to 20% health."] = "它们西边的挖掘场里遍布异种虫。异种搜寻者和异种筑巢蝎在土丘间游荡；异种侵略者（34-35）待在虫巢洞穴里。击杀的第一只异种虫会掉落{item:5877}，打开它。\n小心：异种筑巢蝎生命值降至20%时会呼救。",

	-- Step 18: Parts of the Swarm
	["Keep killing silithid at the dig site for the heart, the talons and the carapaces."] = "继续在挖掘场击杀异种虫，收集心脏、爪子和甲壳。",

	-- Step 19: Moktar Krin
	-- {npc:4483} Moktar Krin
	["North from the dig to {npc:4483}'s camp on the western edge of the flats."] = "从挖掘场向北，前往盐碱地西缘{npc:4483}的营地。",

	-- Step 20: Shimmering Flats: kill these as you meet them
	-- {area:439} Shimmering Flats
	["{area:439}: kill these as you meet them"] = "{area:439}：沿途击杀这些目标",
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger
	["East onto the flats. The Saltstone Basilisks (30-31) sun themselves north-west of it; the Sparkleshell tortoises crowd round a half-buried ship in the north-east, and the Salt Flats Scavengers and Vultures circle the eastern flats. Every vulture drops a bone, about one tortoise in three a shell.\nCareful: Scavengers and Vultures use Execute when your health is low; the Snappers (34-35) hit hardest of the tortoises."] = "向东进入盐碱地。盐石蜥蜴（30-31）在其西北方晒太阳；盐壳海龟聚集在东北方一艘半埋的船旁，盐湖食腐鹫和盐湖秃鹫盘旋在东部盐碱地上空。每只秃鹫都会掉落骨头，海龟约每三只掉一个龟壳。\n小心：盐湖食腐鹫和盐湖秃鹫会在你生命值较低时使用斩杀；盐壳钳嘴龟（34-35）是这些海龟中伤害最高的。",
	-- {object:19868} Rocket Car Rubble
	["{object:19868}, all over the northern flats"] = "{object:19868}，遍布北部盐碱地",
	-- {quest:1104} Salt Flat Venom
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver
	["{quest:1104}, from the Scorpid Reavers of the north half"] = "{quest:1104}，击杀北半部的恐蝎劫掠者获取",

	-- Step 21: Mirage Raceway
	["South-west back to the raceway."] = "向西南返回赛道。",
	-- {npc:4452} Kravel Koalbeard · {quest:1111} Wharfmaster Dizzywig · {area:392} Ratchet
	["{npc:4452}: his parts order goes to {quest:1111} in {area:392}, later on the route"] = "",
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, at 39"] = "{npc:4454}：他的信要交给{zone:1418}的流放者马特克，39级时会去",
	-- {npc:4630} Pozzik · {area:392} Ratchet
	["{npc:4630}: for Gazlowe in {area:392}, later on the route"] = "{npc:4630}：交给{area:392}的加兹鲁维，后续路线会去",

	-- Step 22: Level 32.5
	["Level 32.5"] = "32.5级",
	-- {zone:1443} Desolace · {area:796} Scarlet Monastery
	-- plural, as words: Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper
	["{zone:1443}'s quests are 33-38. Still below 32.5 after the raceway's hand-ins? Keep killing the Sparkleshell Snappers on the flats just north of the raceway until level 32.5. Or, with a group, run the {area:796} dungeon (Graveyard or Library) instead."] = "",
	-- plural, as words: Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper
	["Sparkleshell Snappers"] = "盐壳钳嘴龟",
	-- {npc:4143} Sparkleshell Snapper
	["grind on {npc:4143}"] = "刷{npc:4143}升级",

	-- Step 23: Freewind Post
	-- {area:484} Freewind Post · {npc:10537} Cliffwatcher Longhorn
	["West back to {area:484}. {npc:10537} stands in the middle of the post, on the way to the flight master."] = "向西返回{area:484}。{npc:10537}站在岗哨中央，去飞行管理员的路上会经过。",
	-- {npc:10537} Cliffwatcher Longhorn · {npc:11259} Nataka Longhorn · {zone:1443} Desolace
	["{npc:10537}: for {npc:11259} in {zone:1443}, next"] = "{npc:10537}：交给{zone:1443}的{npc:11259}，接下来会去",

	-- Step 24: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "飞往{area:460}",
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "{area:484}的飞行管理员",

	-- Step 26: Scrabblescrew's Camp
	-- {zone:1443} Desolace · {npc:11596} Smeed Scrabblescrew
	["Head south out of Stonetalon into {zone:1443} and follow the road south to {npc:11596}'s camp."] = "从石爪山向南进入{zone:1443}，沿路向南前往{npc:11596}的营地。",

	-- Step 27: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:11259} Nataka Longhorn · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post, {npc:11259} up on its rise; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395}站在岗哨里，{npc:11259}在岗哨的高地上；{npc:5641}和{npc:4498}在其西边、{area:596}上方的高地等候。",
	-- {npc:11259} Nataka Longhorn
	["{npc:11259}, up on the rise"] = "{npc:11259}，在高地上",

	-- Step 28: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. At his camp, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time."] = "在墓地对老迈的科多兽、濒死的科多兽或{npc:4702}使用{npc:11596}的{item:13892}，把驯服的科多兽带回{npc:11596}身边。到营地后与科多兽对话，才会计入进度并让你驯服下一只。共需五只，每次带一只。",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "",

	-- Step 30: Level 33
	["Level 33"] = "33级",
	-- {quest:5381} Hand of Iruxos · {npc:11596} Smeed Scrabblescrew · {area:796} Scarlet Monastery
	-- plural, as words: Scorpashi Lashers = {npc:4697} Scorpashi Lasher
	["Shadowprey's {quest:5381} and the coast's naga want 33. Below that? The Scorpashi Lashers on the slopes north of {npc:11596}'s camp are on your way west: kill them until level 33. Or, with a group, run the {area:796} dungeon (Library) instead."] = "葬影村的{quest:5381}和海岸上的纳迦需要33级。还没到？向西途中，{npc:11596}营地北边的山坡上有荒土鞭尾蝎，击杀它们直到33级。也可组队挑战{area:796}副本（图书馆）。",
	-- plural, as words: Scorpashi Lashers = {npc:4697} Scorpashi Lasher
	["Scorpashi Lashers"] = "荒土鞭尾蝎",
	-- {npc:4697} Scorpashi Lasher
	["grind on {npc:4697}"] = "刷{npc:4697}升级",

	-- Step 31: Shadowprey Village
	-- {area:606} Gelkis Village · {npc:268705} Aka'rai · {quest:97265} Hate the Hatefury
	["Head west to the troll village on the coast, keeping clear of the {area:606} on the way. {npc:268705} stands on the path just north of the village.\n{npc:268705} may not be here on Forever: if {npc:268705} doesn't offer {quest:97265}, skip it."] = "",
	-- {npc:268705} Aka'rai · {area:603} Sargeron
	["{npc:268705}: the Hatefury satyrs of {area:603}, later in this guide"] = "{npc:268705}：目标是{area:603}的怨怒萨特，本指南稍后会去",
	-- {npc:11877} Roon Wildmane · {quest:5762} Hemet Nesingwary
	["{npc:11877}: for {quest:5762} in Stranglethorn, next guide"] = "{npc:11877}：交给荆棘谷的{quest:5762}，下篇指南会去",
	-- {npc:6726} Thalon
	["{npc:6726}, at the village's south-west end"] = "",

	-- Step 32: Clam beds
	["Clam beds"] = "蚌床",
	-- {item:15874} Soft-shelled Clam
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler
	["Head north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach: each clam you open on the sea floor, and some crawlers, give a {item:15874}. Open each one in your bags for its meat."] = "",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam
	["Giant Softshell Clams, on the sea floor"] = "",
	-- {item:15874} Soft-shelled Clam
	["{item:15874}: open it in your bags"] = "",
	["Underwater"] = "在水下",

	-- Step 33: Sar'theris Strand
	-- {area:598} Sar'theris Strand
	-- plural, as words: Slitherblade Myrmidons = {npc:4714} Slitherblade Myrmidon
	["Keep north to {area:598}. The Slitherblade Myrmidons, Naga and Sorceresses hold the beach; pull them one at a time."] = "继续向北到{area:598}。海滩上有滑刃侍从、滑刃纳迦和滑刃巫师，逐只引来击杀。",

	-- Step 34: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["{npc:11863} waits in the ruined tower of {area:2405}, inland to the east."] = "{npc:11863}在东边内陆{area:2405}的废塔里等候。",

	-- Step 35: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {npc:13019} Burning Blade Seer · {item:20310} Flayed Demon Skin · {quest:5381} Hand of Iruxos · {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal (no name in this language: may be words) · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["Head east to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. The {npc:13019} stands on the fortress's top floor with the Sceptre. The cultists also drop a {item:20310} now and then (1-5%); if one drops, read it. {quest:5381}: clear the middle of the largest building, then use the {item:14523} on the red {object:176581} there. A {npc:11876} (37) comes out: kill it for the {item:13542}."] = "",
	["On the top floor"] = "在最顶层",
	-- {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal (no name in this language: may be words)
	["{item:14523}, on the {object:176581}"] = "",

	-- Step 36: Ethel Rethor
	-- {npc:11863} Azore Aldamort
	["Back west to {npc:11863}."] = "向西返回{npc:11863}身边。",

	-- Step 37: The Book of the Ancients
	-- {quest:6027} Book of the Ancients
	["The {quest:6027}"] = "{quest:6027}",
	-- {area:2405} Ethel Rethor · {area:2406} Ranazjar Isle · {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words) · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the coast north of {area:2405}. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}. He is well above you: rest to full first."] = "",
	-- {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words)
	["{item:15766}, on the {object:177673}"] = "",

	-- Step 39: Sargeron
	-- {area:599} Thunder Axe Fortress · {area:603} Sargeron · {npc:268705} Aka'rai
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue
	["Head east past {area:599} and along the northern hills to the satyrs' ruins of {area:603}. Kill every kind you meet for {npc:268705}; the Shadowstalkers walk unseen.\nCareful: Hatefury Rogues use Hide when they spawn, so they are stealthed until you find them."] = "向东经过{area:599}，沿北部丘陵前往萨特占据的{area:603}废墟。为{npc:268705}击杀遇到的所有种类；怨怒巡影者会隐身游荡。\n小心：怨怒潜行者刷新时就会使用躲藏，在被发现前一直潜行。",
	-- {npc:4671} Hatefury Trickster
	["{npc:4671}, on the way south"] = "{npc:4671}，向南途中击杀",

	-- Step 40: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	-- plural, as words: Kolkar Battle Lords = {npc:4636} Kolkar Battle Lord
	["South to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health.\nCareful: Kolkar Battle Lords call nearby allies within 30 yd once they fall to 20% health."] = "向南到{area:609}。{quest:1365}（35）带着一两名科卡尔队长（32-33）在东侧帐篷间游荡。先清理周围，再以满血状态单独引他。\n小心：科卡尔队长生命值降至20%时，会呼叫30码内的盟友。",

	-- Step 41: Ghost Walker Post
	["South-west down the road to the post."] = "沿路向西南下行，返回岗哨。",
	-- {npc:5641} Takata Steelblade · {npc:5640} Keldran · {zone:1454} Orgrimmar
	["{npc:5641}: for {npc:5640} in {zone:1454}, next guide"] = "{npc:5641}：交给{zone:1454}的{npc:5640}，下篇指南会去",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "{npc:5641}的下一个差事要你去对付一个带着精英护卫的恶魔领主：跳过它。",
	-- {zone:1443} Desolace
	["for the second {zone:1443} visit, in forever/horde/30-40/04-dustwallow-marsh"] = "留到第二次前往{zone:1443}时完成，见forever/horde/30-40/04-dustwallow-marsh",

	-- Step 42: Shadowprey Village
	["West to Shadowprey: your hearthstone is bound there."] = "向西前往葬影村：你的炉石已绑定在那里。",
	-- {npc:268705} Aka'rai
	["{npc:268705}, on the path just north of the village"] = "{npc:268705}，在村子北边不远的小路上",
	-- {npc:11624} Taiga Wisemane · {zone:1443} Desolace · {zone:1454} Orgrimmar · {zone:1434} Stranglethorn Vale
	["{npc:11624}'s Portals of the Legion and {zone:1443}'s other 38-40 quests wait for the second visit, at 38: the next guides fly to {zone:1454} and take the zeppelin to {zone:1434}."] = "{npc:11624}的燃烧军团的传送门，以及{zone:1443}其他38-40级任务，留到38级第二次来时再做。接下来的指南会先飞往{zone:1454}，再乘飞艇前往{zone:1434}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Head east to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. The {npc:13019} stands on the fortress's top floor with the Sceptre; use the {item:14523} on the {npc:11876} for the {item:13542}. The cultists also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "向东前往{area:599}。把一名火刃祭司打至残血，在其死亡前使用{item:6436}，灌满一个{item:6435}。{npc:13019}带着权杖站在堡垒顶层；对{npc:11876}使用{item:14523}，取得{item:13542}。这些祭司偶尔也会掉落{item:20310}（1-5%），掉落后记得阅读。",
	-- ["Head north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "沿海岸向北。巨型软壳蚌分布在浅水中，狂怒的暗礁蟹在沙滩行走；打开背包里的每个蚌壳取出蚌肉。",
	-- ["Head west to the troll village on the coast, keeping clear of the {area:606} on the way. {npc:268705} stands on the path just north of the village."] = "向西前往海岸上的巨魔村庄，途中避开{area:606}。{npc:268705}站在村子北边不远的小路上。",
	-- ["The Slitherblade naga hold the coast north of {area:2405}; {npc:12369} guards the {quest:6027} at the far northern tip."] = "滑刃纳迦占据了{area:2405}北边的海岸；{npc:12369}在最北端守着{quest:6027}。",
	-- ["{zone:1443}'s quests are 33-38. Below 32.5? Keep killing the Sparkleshell Snappers near the silithid dig and the Saltstone Gazers south of it until level 32.5. Or, with a group, run the {area:796} dungeon (Graveyard or Library) instead."] = "{zone:1443}的任务为33-38级。还没到32.5级？继续击杀异种虫挖掘场附近的盐壳钳嘴龟，以及挖掘场南边的盐石凝视者，直到32.5级。也可组队挑战{area:796}副本（墓地或图书馆）。",
}
