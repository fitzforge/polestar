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
	["The zeppelin lands at the tower outside {zone:1454}'s main gate. {npc:5639} walks the Drag: if he isn't at the arrow, look along its streets to the south-west. {npc:5640} stands in the {object:172961} on the west side of the city."] = "飞艇停靠在{zone:1454}正门外的高塔。{npc:5639}在暗巷区四处走动：如果他不在箭头处，就沿暗巷区西南方向的街道找找。{npc:5640}位于城西的{object:172961}。",
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

	-- Step 5: Fly to the Crossroads
	["Fly to the Crossroads"] = "飞往十字路口",
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows
	["{npc:3428}'s {quest:1145} needed level 29 on the last guide's Crossroads stop: take it now, on a short flight to the Crossroads and back."] = "上一份指南经过十字路口时，{npc:3428}的{quest:1145}需要29级：现在接取，飞去十字路口再飞回来，路程很短。",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 6: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428}站在十字路口的飞行管理员旁边。",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "{npc:3428}：交给 {zone:1454} 的 {npc:4485}",

	-- Step 7: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "返回{area:1637}",
	["Crossroads flight master"] = "十字路口飞行管理员",

	-- Step 8: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "{npc:4485}站在{object:172958}。",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, later in this guide"] = "本指南稍后交给{area:439}的{npc:4483}",

	-- Step 10: Thunder Bluff
	-- {zone:1454} Orgrimmar · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {area:484} from there."] = "从{zone:1454}飞往{area:1638}，在{area:1639}向{npc:3033}学习技能，再从那里飞往{area:484}。",

	-- Step 11: Islen Waterseer
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:5901} Islen Waterseer · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to {area:484} from {area:392}."] = "从{zone:1454}飞往{area:392}。{npc:5901}的营地在镇子南边不远的海岸上；之后从{area:392}飞往{area:484}。",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}：{npc:3527}和你的{item:5177}",

	-- Step 12: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "飞往{area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飞行管理员",

	-- Step 13: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}的飞行管理员",

	-- Step 15: Prate Cloudseer
	-- {npc:5905} Prate Cloudseer
	["{npc:5905} hides in a small cave in the canyon wall north-east of the post, on the way east."] = "{npc:5905}藏在岗哨东北方向峡谷岩壁上的小洞穴里，向东走时会经过。",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}：你的{item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905}还会开始元素援助（{area:1717}），这是通往风暴武器的33-40级任务线：见萨满祭司职业指南“空气的召唤和风暴武器（部落）”。",

	-- Step 16: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {area:484} Freewind Post · {quest:1149} Test of Faith
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\n{npc:2986} waits on the mesa just north-east of {area:484}, across the rope bridges.\nFor the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "你在路线之前来这里时错过了这一步：现在先做它。它很快，还会开启后面的任务。\n{npc:2986}在{area:484}东北方不远的平顶山上等候，要过几座绳桥。\n做{quest:1149}时，从他旁边的木板尽头走下去：你会安全落地。",

	-- Step 17: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {area:484} Freewind Post
	["{npc:2986} waits on the mesa just north-east of {area:484}, across the rope bridges."] = "{npc:2986}在{area:484}东北方不远的平顶山上等候，要过几座绳桥。",
	-- {npc:2986} Dorn Plainstalker · {npc:4490} Grenka Bloodscreech
	["{npc:2986}: {npc:4490}, in the harpy den west of the post"] = "{npc:2986}：{npc:4490}，在岗哨西边的鹰身人巢穴",

	-- Step 18: Jandia
	-- {npc:4877} Jandia · {area:484} Freewind Post
	["{npc:4877}, the trade supplies vendor, stands inside {area:484}'s inn."] = "商业用品商人{npc:4877}站在{area:484}的旅店里。",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}: the Screeching harpies of {area:487}"] = "{npc:4877}：{area:487}的尖啸鹰身人",
	-- {npc:4877} Jandia
	["{npc:4877}: her stolen supplies lie in the same harpy den"] = "{npc:4877}：她被偷的物资也在同一处鹰身人巢穴",

	-- Step 19: The Screeching Canyon: kill these as you meet them
	-- {area:483} The Screeching Canyon
	["{area:483}: kill these as you meet them"] = "{area:483}：沿途遇到就击杀",
	-- {area:2097} Darkcloud Pinnacle · {area:487} Roguefeather Den · {npc:4877} Jandia · {quest:98069} Stolen Freewind Supplies · {npc:4490} Grenka Bloodscreech · {npc:2986} Dorn Plainstalker
	["West of Freewind Post, below {area:2097}, the harpies of {area:487} (28-30). The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s; her {quest:98069} lie on the ground along the foot of the cliff and in the cave up on top. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her, for {npc:2986}'s claw."] = "乱风岗西边、{area:2097}下方，是{area:487}的鹰身人（28-30）。那里的尖啸鹰身人、乱羽鹰身人和唤风者都是{npc:4877}的任务目标；她的{quest:98069}散落在悬崖脚下的地上和崖顶的洞穴里。{npc:4490}（31）在它们中间走动：拉她之前先清掉她周围的鹰身人，她的爪子交给{npc:2986}。",
	-- {quest:98069} Stolen Freewind Supplies
	["{quest:98069}, on the ground around the den"] = "{quest:98069}，在巢穴周围的地面上",
	-- {item:5843} Grenka's Claw · {npc:4490} Grenka Bloodscreech
	["{item:5843}, from {npc:4490}"] = "{item:5843}，由{npc:4490}掉落",

	-- Step 20: Jandia
	-- {area:484} Freewind Post
	["Back east to {area:484}."] = "向东返回{area:484}。",
	-- {npc:4877} Jandia
	["{npc:4877}, inside the inn"] = "{npc:4877}，在旅店里",

	-- Step 21: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {npc:4499} Rok'Alim the Pounder
	["Back across to {npc:2986}'s mesa north-east of the post, then take the lift down to the canyon floor. {npc:2986}'s next test, {npc:4499}, is an elite: leave it."] = "返回岗哨东北方{npc:2986}所在的平顶山，然后乘升降梯下到峡谷底部。{npc:2986}的下一个试炼{npc:4499}是精英：先不接。",

	-- Step 22: Stormheart
	-- {npc:270094} Stormheart · {area:484} Freewind Post
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:270094} is a level 30 elite: most classes solo it at level 32, but you may need help. Skip it if you are alone: the route has you grind the XP back.\n{npc:270094} walks the canyon road east of {area:484}'s lift, on the way to the salt flats: kill him for his heart."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:270094}是30级精英，多数职业到32级可以单刷，但你可能需要帮手。如果你是单人，就跳过：路线会让你把经验刷回来。\n{npc:270094}在{area:484}升降梯东边的峡谷道路上走动，就在去盐滩的路上：杀死他取得他的心脏。",
	-- {item:279186} Stormheart's Still-beating Heart · {npc:270094} Stormheart
	["{item:279186}, from {npc:270094}"] = "{item:279186}，来自{npc:270094}",

	-- Step 23: Moktar Krin
	-- {npc:4483} Moktar Krin
	["Take the lift down and follow the canyon east. {npc:4483} camps on the north-western edge of the salt flats."] = "乘升降梯下去，沿峡谷向东。{npc:4483}的营地在盐碱地的西北边缘。",

	-- Step 24: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "{area:2240}的地精和侏儒是中立的，双方阵营都能接他们的任务。",
	-- {npc:4452} Kravel Koalbeard · {quest:5762} Hemet Nesingwary
	["{npc:4452}'s crate for {quest:5762} in Stranglethorn, later on the route"] = "{npc:4452}的箱子，留给荆棘谷的{quest:5762}，后续路线会去",

	-- Step 25: Shimmering Flats: kill these as you meet them
	-- {area:439} Shimmering Flats
	["{area:439}: kill these as you meet them"] = "{area:439}：沿途击杀这些目标",
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Scorpid Terrors = {npc:4139} Scorpid Terror
	["North-east of the raceway onto the flats. The Saltstone Basilisks (30-31) sun themselves north-west of it, and the Sparkleshell Tortoises (30-31) wander among them on the western flats; the Salt Flats Scavengers and Vultures circle the eastern flats. Every vulture drops a bone, about one tortoise in three a shell.\nCareful: Scavengers and Vultures use Execute when your health is low. The Sparkleshell Snappers (34-35) crowd round a half-buried ship in the north-east and are over you here: the Tortoises of the western flats drop the shells just as often, so stay with them. Take the venom from the Reavers (31-32) of the north half and leave the Scorpid Terrors (33-34) further south."] = "从赛道往东北进入盐碱地。盐石蜥蜴（30-31）在赛道西北方晒太阳，盐壳龟（30-31）在西部盐碱地的蜥蜴之间游荡；盐湖食腐鹫和秃鹫在东部盐碱地盘旋。每只秃鹫都掉骨头，约三只盐壳龟掉一个龟壳。\n小心：食腐鹫和秃鹫会在你生命值低时使用斩杀。盐壳钳嘴龟（34-35）聚集在东北方一艘半埋的船周围，对你来说等级过高：西部盐碱地的盐壳龟掉龟壳的几率一样，所以就打它们。毒液从北半部的恐蝎劫掠者（31-32）身上拿，别碰更南边的恐蝎（33-34）。",
	-- {item:5795} Hardened Tortoise Shell
	-- plural, as words: Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise
	["{item:5795}, from the Sparkleshell Tortoises of the western flats"] = "{item:5795}，由西部盐碱地的盐壳龟掉落",
	-- {object:19868} Rocket Car Rubble
	["{object:19868}, all over the northern flats: pick it on the western flats, away from the Snappers"] = "{object:19868}，遍布北部盐碱地：在西部盐碱地拾取，远离钳嘴龟",
	-- {quest:1104} Salt Flat Venom
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver
	["{quest:1104}, from the Scorpid Reavers of the north half"] = "{quest:1104}，击杀北半部的恐蝎劫掠者获取",

	-- Step 26: Mirage Raceway
	["South-west back to the raceway."] = "向西南返回赛道。",
	-- {npc:4452} Kravel Koalbeard · {quest:1111} Wharfmaster Dizzywig · {area:392} Ratchet
	["{npc:4452}: his parts order goes to {quest:1111} in {area:392}, later on the route"] = "{npc:4452}：他的零件订单要交给{area:392}的{quest:1111}，后续路线会去",
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, at 39"] = "{npc:4454}：他的信要交给{zone:1418}的流放者马特克，39级时会去",
	-- {npc:4630} Pozzik · {area:392} Ratchet
	["{npc:4630}: for Gazlowe in {area:392}, later on the route"] = "{npc:4630}：交给{area:392}的加兹鲁维，后续路线会去",

	-- Step 27: Level 32
	["Level 32"] = "32级",
	-- {zone:1443} Desolace · {area:1717} Razorfen Kraul
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Scorpid Terrors = {npc:4139} Scorpid Terror
	["The flats' south and the silithid dig are 32-35, {zone:1443}'s quests 32-38. Still below 32 after the raceway's hand-ins? Back north on the flats, the Scorpid Reavers (31-32) roam among the basilisks and tortoises: kill them until level 32; leave the Sparkleshell Snappers (34-35) and the Scorpid Terrors (33-34) alone. Or, with a group, run the {area:1717} dungeon instead."] = "盐碱地南部和异种虫挖掘场是32-35级，{zone:1443}的任务是32-38级。交完赛道的任务后还不到32级？回到北边的盐碱地，恐蝎劫掠者（31-32）在蜥蜴和龟之间游荡：刷它们到32级；别碰盐壳钳嘴龟（34-35）和恐蝎（33-34）。或者组队去刷{area:1717}地下城。",
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver
	["Scorpid Reavers"] = "恐蝎劫掠者",
	-- {npc:4140} Scorpid Reaver
	["grind on {npc:4140}"] = "刷{npc:4140}升级",

	-- Step 28: The southern flats
	["The southern flats"] = "南部盐碱地",
	-- plural, as words: Saltstone Crystalhides = {npc:4151} Saltstone Crystalhide
	["South of the raceway, the Saltstone Crystalhides (32-33) and Gazers (34-35) roam the far end of the flats.\nCareful: the level 35 Gazers can still be two over you: pull them one at a time from the camp's edge, never two together."] = "赛道南方，盐石水晶蜥蜴（32-33）和盐石凝视者（34-35）游荡在盐碱地的远端。\n小心：35级的凝视者可能仍比你高两级：从营地边缘一次拉一只，绝不要同时拉两只。",

	-- Step 29: The Rustmaul Dig Site
	-- {item:5877} Cracked Silithid Carapace · {npc:4132} Silithid Ravager
	["West of them the silithid swarm the dig site. Searchers and Hive Drones walk among the mounds; the Invaders (34-35) stay inside the hive cave. The first silithid you kill drops a {item:5877}: open it.\nCareful: Hive Drones call for help when they fall to 20% health, and the {npc:4132} (37, rare) walks the dig: take the Searchers and Drones (32-34) outside first, then pull the Invaders (34-35) one at a time from the cave mouth."] = "它们西边的挖掘场里遍布异种虫。异种搜寻者和异种筑巢蝎在土丘间游荡；异种侵略者（34-35）待在虫巢洞穴里。击杀的第一只异种虫会掉落{item:5877}，打开它。\n小心：异种筑巢蝎生命值降至20%时会呼救，{npc:4132}（37，稀有）在挖掘场里走动：先清掉外面的搜寻者和筑巢蝎（32-34），再从洞口一次拉一只侵略者（34-35）。",

	-- Step 30: Parts of the Swarm
	["Keep killing silithid at the dig site for the heart, the talons and the carapaces."] = "继续在挖掘场击杀异种虫，收集心脏、爪子和甲壳。",

	-- Step 31: Moktar Krin
	-- {npc:4483} Moktar Krin
	["North from the dig to {npc:4483}'s camp on the western edge of the flats."] = "从挖掘场向北，前往盐碱地西缘{npc:4483}的营地。",

	-- Step 32: Mirage Raceway
	-- {area:976} Gadgetzan
	["East to the raceway, on the way south to {area:976}."] = "向东前往赛道，顺路向南去{area:976}。",

	-- Step 33: Gadgetzan
	-- {zone:1446} Tanaris · {area:976} Gadgetzan · {area:484} Freewind Post
	["South from the raceway over the {zone:1446} border to {area:976}, the walled goblin town: learn its flight path and fly back to {area:484} from there, which is quicker than the walk west across the flats, and the next guides fly straight to {area:976}."] = "从赛道向南越过{zone:1446}边界到达有城墙的地精城镇{area:976}：学习那里的飞行路线，再从那里飞回{area:484}，这比向西穿过盐滩走回去更快，而且之后的指南会直接飞往{area:976}。",

	-- Step 35: Freewind Post
	-- {npc:10537} Cliffwatcher Longhorn
	["{npc:10537} stands in the middle of the post, on the way to the flight master."] = "{npc:10537}站在岗哨中央，去飞行管理员的路上会经过。",
	-- {npc:10537} Cliffwatcher Longhorn · {npc:11259} Nataka Longhorn · {zone:1443} Desolace
	["{npc:10537}: for {npc:11259} in {zone:1443}, next"] = "{npc:10537}：交给{zone:1443}的{npc:11259}，接下来会去",

	-- Step 36: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "飞往{area:460}",
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "{area:484}的飞行管理员",

	-- Step 38: Scrabblescrew's Camp
	-- {zone:1443} Desolace · {npc:11596} Smeed Scrabblescrew
	["Head south out of Stonetalon into {zone:1443} and follow the road south to {npc:11596}'s camp."] = "从石爪山向南进入{zone:1443}，沿路向南前往{npc:11596}的营地。",

	-- Step 39: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:11259} Nataka Longhorn · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post, {npc:11259} up on its rise; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395}站在岗哨里，{npc:11259}在岗哨的高地上；{npc:5641}和{npc:4498}在其西边、{area:596}上方的高地等候。",
	-- {npc:11259} Nataka Longhorn
	["{npc:11259}, up on the rise"] = "{npc:11259}，在高地上",

	-- Step 41: Takata Steelblade and Maurin Bonesplitter
	-- {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter
	["{npc:5641} and {npc:4498}"] = "{npc:5641}和{npc:4498}",

	-- Step 42: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo · {npc:11521} Kodo Apparition
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. At his camp, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time. Careful: leave the kodo skulls on the ground alone: opening one raises a {npc:11521} (37-38) that hits hard."] = "在墓地对老迈的科多兽、濒死的科多兽或{npc:4702}使用{npc:11596}的{item:13892}，把驯服的科多兽带回{npc:11596}身边。到营地后与科多兽对话，才会计入进度并让你驯服下一只。共需五只，每次带一只。小心：不要碰地上的科多兽头骨：打开后会出现一只伤害很高的{npc:11521}（37-38级）。",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "对墓地里的老迈的科多兽、濒死的科多兽或{npc:4702}使用；不要击杀",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "把驯服的科多兽带到{npc:11596}的营地，与它交谈；重复五次",

	-- Step 44: Shadowprey Village
	-- {area:606} Gelkis Village · {npc:268705} Aka'rai · {quest:97265} Hate the Hatefury
	["Head west to the troll village on the coast, keeping clear of the {area:606} on the way. {npc:268705} stands on the path just north of the village.\n{npc:268705} may not be here on Forever: if {npc:268705} doesn't offer {quest:97265}, skip it."] = "向西前往海岸上的巨魔村庄，途中避开 {area:606}。{npc:268705} 站在村子北边不远的小路上。\n{npc:268705} 在Forever中可能不在这里：如果 {npc:268705} 没有提供 {quest:97265}，就跳过。",
	-- {npc:268705} Aka'rai · {area:603} Sargeron
	["{npc:268705}: the Hatefury satyrs of {area:603}, later in this guide"] = "{npc:268705}：目标是{area:603}的怨怒萨特，本指南稍后会去",
	-- {npc:11877} Roon Wildmane · {quest:5762} Hemet Nesingwary
	["{npc:11877}: for {quest:5762} in Stranglethorn, next guide"] = "{npc:11877}：交给荆棘谷的{quest:5762}，下篇指南会去",
	-- {npc:6726} Thalon
	["{npc:6726}, at the village's south-west end"] = "{npc:6726}，在村庄西南端",

	-- Step 45: Drulzegar Skraghook
	-- {npc:12340} Drulzegar Skraghook · {npc:12031} Mai'Lahii · {quest:6143} Other Fish to Fry · {area:598} Sar'theris Strand
	["{npc:12340} stands at the village's south end, near {npc:12031}. At your level his {quest:6143} fits the walk north along the coast: the southern half of {area:598}, from level 34."] = "{npc:12340}站在村庄南端，靠近{npc:12031}。在你的等级，他的{quest:6143}正好并入沿海岸向北的行程：{area:598}的南半部，从34级开始。",

	-- Step 46: Ethel Rethor
	-- {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress · {area:2406} Ranazjar Isle
	["Head north along the coast, then inland to the ruined tower of {area:2405}: {npc:11863} waits inside. The coast's clams and naga come after {area:599}, on one walk north to {area:2406}."] = "沿海岸向北，再转向内陆前往{area:2405}的废塔：{npc:11863}在塔内等候。海岸上的蚌和纳迦留到{area:599}之后，一路向北前往{area:2406}时再做。",

	-- Step 47: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {npc:13019} Burning Blade Seer · {item:20310} Flayed Demon Skin · {object:176581} Hand of Iruxos Crystal · {npc:11876} Demon Spirit · {zone:1443} Desolace
	["Head east to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. The {npc:13019} stands on the fortress's top floor with the Sceptre. The cultists also drop a {item:20310} now and then (1-5%); if one drops, read it. Leave the red {object:176581} for now: its {npc:11876} is 37, and the second {zone:1443} visit comes back for it."] = "向东前往{area:599}。将一名火刃教徒打至残血，在其死亡前使用{item:6436}，灌满一个{item:6435}。{npc:13019}带着权杖站在堡垒顶层。教徒偶尔也会掉落{item:20310}（1-5%）；拾取后阅读。红色的{object:176581}先别碰：它召出的{npc:11876}是37级，第二次来{zone:1443}时再回来处理。",
	["On the top floor"] = "在最顶层",

	-- Step 48: Ethel Rethor
	-- {npc:11863} Azore Aldamort
	["Back west to {npc:11863}."] = "向西返回{npc:11863}身边。",
	-- {npc:11863} Azore Aldamort · {item:15803} Book of the Ancients · {npc:12369} Lord Kragaru · {area:2406} Ranazjar Isle
	["{npc:11863}'s next errand, the {item:15803}, needs {npc:12369} (38) out on {area:2406}: leave it, he is over your level."] = "{npc:11863}的下一个差事{item:15803}需要击杀{area:2406}上的{npc:12369}（38级）：先放着，他比你等级高。",

	-- Step 49: Rackmore's Log
	-- {object:177787} Rackmore's Log · {npc:11863} Azore Aldamort
	["{object:177787} lies on the ground just south-west of {npc:11863}'s tower, on the way down to the shore: read it. Its two keys drop only while you have the quest."] = "{object:177787}就在{npc:11863}所在高塔西南方不远的地上，在下行前往海岸的路上：阅读它。它所需的两把钥匙只有在接了任务后才会掉落。",

	-- Step 50: Clam beds
	["Clam beds"] = "蚌床",
	-- {item:15874} Soft-shelled Clam · {item:15878} Rackmore's Silver Key
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler · Drysnap Crawlers = {npc:11562} Drysnap Crawler
	["West to the shore. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach: each clam you open on the sea floor, and some crawlers, give a {item:15874}. Open each one in your bags for its meat.\nThe Drysnap Crawlers and Pincers on the same beach carry {item:15878}, about one in seven."] = "向西前往海岸。巨型软壳蚌分布在浅水中，狂怒的暗礁蟹在沙滩上行走：在海底打开的每个蚌，以及部分暗礁蟹，都会给你一个{item:15874}。在背包里逐个打开，取出蚌肉。\n同一片沙滩上的旱钳蟹和旱钳巨蟹身上带着{item:15878}，大约每七只掉一把。",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam
	["Giant Softshell Clams, on the sea floor"] = "巨型软壳蚌，在海底",
	-- {item:15874} Soft-shelled Clam
	["{item:15874}: open it in your bags"] = "{item:15874}：在背包中打开",
	["Underwater"] = "在水下",
	-- {item:15878} Rackmore's Silver Key
	["{item:15878}, from the Drysnap crabs"] = "{item:15878}，击杀干钳蟹获取",

	-- Step 51: Sar'theris Strand
	-- {area:598} Sar'theris Strand · {item:15881} Rackmore's Golden Key · {zone:1443} Desolace
	["Keep north to {area:598} for {item:15881}: any Slitherblade can drop it.\nCareful: the Myrmidons (34-35) hold the beach's northern half with the Sea Witches and Oracles (34-36, casters), up to two over you at 33: work the Naga and Sorceresses (32-33) of the southern half until the key drops, and leave the north for the second {zone:1443} visit, at 38."] = "继续向北前往{area:598}获取{item:15881}：任何滑刃纳迦都可能掉落。\n小心：海滩北半部有侍从（34-35级）以及海巫和神谕者（34-36级，施法者），在33级时最多比你高两级：先在南半部打纳迦和女巫（32-33级）直到钥匙掉落，北边留到38级第二次来{zone:1443}时再去。",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}，击杀滑刃纳迦获取",

	-- Step 52: Sar'theris Strand: Other Fish to Fry
	["Stay in the southern half of the strand, where Rackmore's key drops: eight Myrmidons (34-35) walk there among the Naga, Sorceresses and Warriors (32-34).\nCareful: the northern half belongs to the Sea Witches (35-36, casters) and, at its tip, the Tidehunters (36-37): keep south of the middle of the beach."] = "留在海滩南半部，拉克摩尔的钥匙就在那里掉落：八只侍从（34-35级）在纳迦、女巫和战士（32-34级）之间游荡。\n小心：北半部是海巫（35-36级，施法者）的地盘，其顶端还有潮行者（36-37级）：待在海滩中部以南。",
	-- {npc:4714} Slitherblade Myrmidon
	["{npc:4714}, in the strand's southern half"] = "{npc:4714}，在海滩南半部",

	-- Step 53: Rackmore's Chest
	-- {area:2406} Ranazjar Isle · {object:177786} Rackmore's Chest · {object:177673} Serpent Statue
	["Swim out to {area:2406} off the far northern tip: {object:177786} stands on the shore beside the {object:177673}. Open it with both keys; leave the statue alone."] = "从最北端游到{area:2406}：{object:177786}在岸边的{object:177673}旁。用两把钥匙打开它；别碰雕像。",

	-- Step 54: Sargeron
	-- {area:599} Thunder Axe Fortress · {area:603} Sargeron · {npc:268705} Aka'rai
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue
	["Head east past {area:599} and along the northern hills to the satyrs' ruins of {area:603}. Kill every kind you meet for {npc:268705}; the Shadowstalkers walk unseen.\nCareful: Hatefury Rogues use Hide when they spawn, so they are stealthed until you find them."] = "向东经过{area:599}，沿北部丘陵前往萨特占据的{area:603}废墟。为{npc:268705}击杀遇到的所有种类；怨怒巡影者会隐身游荡。\n小心：怨怒潜行者刷新时就会使用躲藏，在被发现前一直潜行。",
	-- {npc:4671} Hatefury Trickster
	["{npc:4671}, on the way south"] = "{npc:4671}，向南途中击杀",

	-- Step 55: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	-- plural, as words: Kolkar Battle Lords = {npc:4636} Kolkar Battle Lord
	["South to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health.\nCareful: Kolkar Battle Lords call nearby allies within 30 yd once they fall to 20% health."] = "向南到{area:609}。{quest:1365}（35）带着一两名科卡尔队长（32-33）在东侧帐篷间游荡。先清理周围，再以满血状态单独引他。\n小心：科卡尔队长生命值降至20%时，会呼叫30码内的盟友。",

	-- Step 56: Ghost Walker Post
	["South-west down the road to the post."] = "沿路向西南下行，返回岗哨。",
	-- {npc:5641} Takata Steelblade · {npc:5640} Keldran · {zone:1454} Orgrimmar
	["{npc:5641}: for {npc:5640} in {zone:1454}, next guide"] = "{npc:5641}：交给{zone:1454}的{npc:5640}，下篇指南会去",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "{npc:5641}的下一个差事要你去对付一个带着精英护卫的恶魔领主：跳过它。",
	-- {npc:5395} Felgur Twocuts · {zone:1443} Desolace · {area:607} Valley of Spears
	["{npc:5395} now offers Centaur Bounty: the second {zone:1443} visit, at 38, takes it on its way to the {area:607}."] = "{npc:5395}现在会提供“半人马赏金”：第二次来{zone:1443}时（38级），前往{area:607}的路上会接取它。",

	-- Step 57: Shadowprey Village
	["West to Shadowprey: your hearthstone is bound there."] = "向西前往葬影村：你的炉石已绑定在那里。",
	-- {npc:268705} Aka'rai
	["{npc:268705}, on the path just north of the village"] = "{npc:268705}，在村子北边不远的小路上",
	-- {item:14547} Hand of Iruxos · {npc:12340} Drulzegar Skraghook · {quest:6143} Other Fish to Fry · {zone:1443} Desolace · {zone:1454} Orgrimmar · {zone:1434} Stranglethorn Vale
	-- was: ["Taiga's {item:14547}, Drulzegar's Other Fish to Fry and {zone:1443}'s other 37-40 quests wait for the second visit, at 38: the next guides fly to {zone:1454} and take the zeppelin to {zone:1434}."] = "泰加的{item:14547}、德鲁泽加的另有要事，以及{zone:1443}其他37-40级任务，留到38级第二次来时再做。接下来的指南会先飞往{zone:1454}，再乘飞艇前往{zone:1434}。"
	["Taiga's {item:14547}, {npc:12340}'s {quest:6143} (unless you did it on the strand) and {zone:1443}'s other 37-40 quests wait for the second visit, at 38: the next guides fly to {zone:1454} and take the zeppelin to {zone:1434}."] = "泰加的{item:14547}、{npc:12340}的{quest:6143}（除非你已在海滩上完成）以及{zone:1443}其他37-40级任务，留到38级第二次来时再做。接下来的指南会先飞往{zone:1454}，再乘飞艇前往{zone:1434}。",

	-- Step 58: Drulzegar Skraghook
	-- {npc:12340} Drulzegar Skraghook · {npc:12031} Mai'Lahii
	["{npc:12340}, near {npc:12031}"] = "{npc:12340}，靠近{npc:12031}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to {npc:11863}'s tower."] = "向南返回{npc:11863}所在的高塔。",
	-- ["East onto the flats. The Saltstone Basilisks (30-31) sun themselves north-west of it; the Sparkleshell tortoises crowd round a half-buried ship in the north-east, and the Salt Flats Scavengers and Vultures circle the eastern flats. Every vulture drops a bone, about one tortoise in three a shell.\nCareful: Scavengers and Vultures use Execute when your health is low; the Snappers (34-35) hit hardest of the tortoises."] = "向东进入盐碱地。盐石蜥蜴（30-31）在其西北方晒太阳；盐壳海龟聚集在东北方一艘半埋的船旁，盐湖食腐鹫和盐湖秃鹫盘旋在东部盐碱地上空。每只秃鹫都会掉落骨头，海龟约每三只掉一个龟壳。\n小心：盐湖食腐鹫和盐湖秃鹫会在你生命值较低时使用斩杀；盐壳钳嘴龟（34-35）是这些海龟中伤害最高的。",
	-- ["Head east to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. The {npc:13019} stands on the fortress's top floor with the Sceptre. The cultists also drop a {item:20310} now and then (1-5%); if one drops, read it. {quest:5381}: clear the middle of the largest building, then use the {item:14523} on the red {object:176581} there. A {npc:11876} (37) comes out: kill it for the {item:13542}."] = "向东前往{area:599}。将一名火刃教徒打至残血，在其死亡前使用{item:6436}，灌满一个{item:6435}。{npc:13019}带着权杖站在堡垒顶层。教徒偶尔也会掉落{item:20310}（1-5%）；拾取后阅读。{quest:5381}：先清理最大建筑中央的怪物，再对那里的红色{object:176581}使用{item:14523}。随后会出现一只{npc:11876}（37级），击杀它取得{item:13542}。",
	-- ["Head east to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. The {npc:13019} stands on the fortress's top floor with the Sceptre; use the {item:14523} on the {npc:11876} for the {item:13542}. The cultists also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "向东前往{area:599}。把一名火刃祭司打至残血，在其死亡前使用{item:6436}，灌满一个{item:6435}。{npc:13019}带着权杖站在堡垒顶层；对{npc:11876}使用{item:14523}，取得{item:13542}。这些祭司偶尔也会掉落{item:20310}（1-5%），掉落后记得阅读。",
	-- ["Head north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "沿海岸向北。巨型软壳蚌分布在浅水中，狂怒的暗礁蟹在沙滩行走；打开背包里的每个蚌壳取出蚌肉。",
	-- ["Head west to the troll village on the coast, keeping clear of the {area:606} on the way. {npc:268705} stands on the path just north of the village."] = "向西前往海岸上的巨魔村庄，途中避开{area:606}。{npc:268705}站在村子北边不远的小路上。",
	-- ["Keep north to {area:598}. The Slitherblade Myrmidons, Naga and Sorceresses hold the beach; pull them one at a time."] = "继续向北到{area:598}。海滩上有滑刃侍从、滑刃纳迦和滑刃巫师，逐只引来击杀。",
	-- ["Keep north to {area:598}. The Slitherblade Myrmidons, Naga and Sorceresses hold the beach; pull them one at a time. Any Slitherblade can drop {item:15881}."] = "继续向北到{area:598}。海滩上有滑刃侍从、滑刃纳迦和滑刃巫师，逐只引来击杀。任何滑刃纳迦都可能掉落{item:15881}。",
	-- ["Level 32.5"] = "32.5级",
	-- ["Level 33"] = "33级",
	-- ["Run {area:133} with a group when it suits you: {npc:7800} at the end drops his Safe Combination; open his safe behind the northern bomb pillar for the {item:9153}."] = "方便时组队前往{area:133}：最终首领{npc:7800}会掉落他的保险箱密码；用它打开北侧炸弹柱后方的保险箱，取得{item:9153}。",
	-- ["Scorpashi Lashers"] = "荒土鞭尾蝎",
	-- ["Shadowprey's {quest:5381} and the coast's naga want 33. Below that? The Kolkar centaurs (30-32) of {area:609}, a short way east of {npc:11596}'s camp, are the nearest camp at your level: kill them until level 33. The Scorpashi Lashers (34-35) on the slopes north of the camp are higher. Or, with a group, run the {area:1717} dungeon instead."] = "葬影村的{quest:5381}和海岸上的纳迦需要33级。还没到？{npc:11596}营地东边不远处{area:609}的科卡尔半人马（30-32级）是离你最近、等级合适的营地：击杀它们直到33级。营地北边山坡上的荒土鞭尾蝎（34-35级）等级更高。也可组队挑战{area:1717}地下城。",
	-- ["South of the raceway, the Saltstone Crystalhides (32-33) and Gazers (34-35) roam the far end of the flats."] = "赛道南方，盐石水晶蜥蜴（32-33）和盐石凝视者（34-35）游荡在盐碱地的远端。",
	-- ["Sparkleshell Snappers"] = "盐壳钳嘴龟",
	-- ["Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}. He is well above you: rest to full first. {object:177786} stands on the shore beside the statue: open it with both keys."] = "从最北端游到{area:2406}，对{object:177673}使用{item:15766}：{npc:12369}（38）会现身，击杀他取得{quest:6027}。他等级比你高不少，先休息至满状态。{object:177786}就在雕像旁的岸边，用两把钥匙打开它。",
	-- ["Taiga's {item:14547}, Drulzegar's Other Fish to Fry and {zone:1443}'s other 37-40 quests wait for the second visit, at 38: the next guides fly to {zone:1454} and take the zeppelin to {zone:1434}."] = "泰加的{item:14547}、德鲁泽加的另有要事，以及{zone:1443}其他37-40级任务，留到38级第二次来时再做。接下来的指南会先飞往{zone:1454}，再乘飞艇前往{zone:1434}。",
	-- ["The Slitherblade naga hold the coast north of {area:2405}; {npc:12369} guards the {quest:6027} at the far northern tip."] = "滑刃纳迦占据了{area:2405}北边的海岸；{npc:12369}在最北端守着{quest:6027}。",
	-- ["The zeppelin lands at the tower outside {zone:1454}'s main gate. {npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city."] = "飞艇停靠在{zone:1454}正门外的高塔。{npc:5639}在暗巷区等候；{npc:5640}位于城西的{object:172961}。",
	-- ["The {quest:6027}"] = "{quest:6027}",
	-- ["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. At his camp, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time."] = "在墓地对老迈的科多兽、濒死的科多兽或{npc:4702}使用{npc:11596}的{item:13892}，把驯服的科多兽带回{npc:11596}身边。到营地后与科多兽对话，才会计入进度并让你驯服下一只。共需五只，每次带一只。",
	-- ["West of them the silithid swarm the dig site. Searchers and Hive Drones walk among the mounds; the Invaders (34-35) stay inside the hive cave. The first silithid you kill drops a {item:5877}: open it.\nCareful: Hive Drones call for help when they fall to 20% health."] = "它们西边的挖掘场里遍布异种虫。异种搜寻者和异种筑巢蝎在土丘间游荡；异种侵略者（34-35）待在虫巢洞穴里。击杀的第一只异种虫会掉落{item:5877}，打开它。\n小心：异种筑巢蝎生命值降至20%时会呼救。",
	-- ["for the second {zone:1443} visit, in forever/horde/30-40/04-dustwallow-marsh"] = "留到第二次前往{zone:1443}时完成，见forever/horde/30-40/04-dustwallow-marsh",
	-- ["grind on {npc:4143}"] = "刷{npc:4143}升级",
	-- ["grind on {npc:4635}"] = "刷{npc:4635}升级",
	-- ["{item:14523}, on the {object:176581}"] = "{item:14523}，在{object:176581}上",
	-- ["{item:15766}, on the {object:177673}"] = "{item:15766}，对{object:177673}使用",
	-- ["{npc:11624}'s Portals of the Legion and {zone:1443}'s other 38-40 quests wait for the second visit, at 38: the next guides fly to {zone:1454} and take the zeppelin to {zone:1434}."] = "{npc:11624}的燃烧军团的传送门，以及{zone:1443}其他38-40级任务，留到38级第二次来时再做。接下来的指南会先飞往{zone:1454}，再乘飞艇前往{zone:1434}。",
	-- ["{npc:11863} waits in the ruined tower of {area:2405}, inland to the east."] = "{npc:11863}在东边内陆{area:2405}的废塔里等候。",
	-- ["{npc:3412}'s workshop is in the {object:172958}. {quest:2841} is {area:133}'s last boss: great XP if you run it with a group. Run it whenever your group is ready; hand it in on a later {zone:1454} stop."] = "{npc:3412}的工坊位于{object:172958}。{quest:2841}的目标是{area:133}的最终首领，组队完成可获得大量经验。队伍准备好后随时可去，之后途经{zone:1454}时再交任务。",
	-- ["{object:19868}, all over the northern flats"] = "{object:19868}，遍布北部盐碱地",
	-- ["{zone:1443}'s quests are 33-38. Below 32.5? Keep killing the Sparkleshell Snappers near the silithid dig and the Saltstone Gazers south of it until level 32.5. Or, with a group, run the {area:796} dungeon (Graveyard or Library) instead."] = "{zone:1443}的任务为33-38级。还没到32.5级？继续击杀异种虫挖掘场附近的盐壳钳嘴龟，以及挖掘场南边的盐石凝视者，直到32.5级。也可组队挑战{area:796}副本（墓地或图书馆）。",
	-- ["{zone:1443}'s quests are 33-38. Still below 32.5 after the raceway's hand-ins? Keep killing the Sparkleshell Snappers on the flats just north of the raceway until level 32.5. Or, with a group, run the {area:1717} dungeon instead."] = "{zone:1443}的任务适合33-38级。交还赛道的任务后仍未到32.5级，就在赛道正北的平原上继续击杀盐壳钳嘴龟，直到32.5级；也可以组队刷{area:1717}地下城。",
}
