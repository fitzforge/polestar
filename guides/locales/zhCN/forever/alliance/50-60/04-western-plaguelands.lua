-- Chinese (simplified) (zhCN): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Argent Officer Pureheart
	-- {quest:5401} Argent Dawn Commission · {spell:437801} Light's Hope · {zone:1452} Winterspring
	["No {quest:5401} yet ({spell:437801} gives it on the {zone:1452} guide's way through)? Pureheart gives you one here: the scourgestone quests need it."] = "",

	-- Step 4: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}：沿途击杀以下目标",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "骷髅剥皮者和被奴役的食尸鬼在营地北侧田野活动，这里的天灾亡灵都会掉落天灾石。\n注意：这些亡灵的警戒距离很远，拉到一只时，周围亡灵也会参战。\n注意：{npc:10411}有三个刷新点，每 15 分钟刷新一次，非战斗时会隐形，开战后召唤石翼石像鬼。",

	-- Step 5: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "{npc:10927}的农舍在营地东边的山丘上；{npc:10936}的纪念碑就在它北边。",
	["Upstairs"] = "在楼上",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}，在纪念碑旁",

	-- Step 6: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "向西北骑到达尔松农场。日记在谷仓里；一个游荡的骷髅带着厕所钥匙，{npc:10836}在厕所里等候，身上有柜子钥匙。",
	-- {quest:5058} Mrs. Dalson's Diary
	["{quest:5058}, inside"] = "{quest:5058}：在屋内",
	["Inside"] = "在里面",

	-- Step 7: The Writhing Haunt: kill these as you meet them
	-- {area:202} The Writhing Haunt
	["{area:202}: kill these as you meet them"] = "{area:202}：沿途击杀以下目标",

	-- Step 8: Dalson's Tears
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "{object:175924}，位于农舍内",

	-- Step 9: Chillwind Camp
	["Ride back south to the camp."] = "向南骑回营地。",

	-- Step 10: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "安多哈尔瞭望塔",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "在营地北边、安多哈尔外围的四座瞭望塔脚下各使用一次{item:12815}。",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}标记{npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}标记{npc:10903}",

	-- Step 11: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667}在安多哈尔西侧的废弃旅店里等候。",

	-- Step 12: The Andorhal watchtowers
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}标记{npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}标记{npc:10905}",

	-- Step 13: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852}是61级精英",

	-- Step 14: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "{area:200}的大锅",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "大锅在费尔斯通农场东北方的{area:200}；护锅者拉扎奇站在旁边。",

	-- Step 15: Andorhal
	["Andorhal"] = "安多哈尔",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "在粮仓旁使用{item:12627}引出{npc:10717}。{quest:5154}是市政厅里的发霉的书籍之一。镇上的每个骷髅都会掉落{quest:5537}。",

	-- Step 17: The Writhing Haunt cauldron
	-- {area:202} The Writhing Haunt
	["{area:202} cauldron"] = "{area:202}的大锅",
	-- {area:202} The Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "大锅在{area:202}，{npc:10739}的农场旁。",

	-- Step 19: Diseased Grizzlies
	["Diseased Grizzlies"] = "生病的灰熊",

	-- Step 20: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "交给{zone:1457}的德鲁伊：先留着",

	-- Step 22: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}，在{area:2268}：先留着",

	-- Step 23: Sorrow Hill: kill these as you meet them
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "{npc:1852}是精英，建议组队。他在安多哈尔中央守卫自己的护命匣。\n安多哈尔各处废墟中散落着小保险箱，每个箱子里有一只怀表。\n注意：食尸鬼和骷髅通常就在箱子旁，接近时会攻击。灼热食尸鬼还会伤害附近所有人，打破潜行。",

	-- Step 25: More watches
	["More watches"] = "更多怀表",

	-- Step 27: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "沿道路向北骑到北山伐木场；{npc:11610}躲在营地边缘。",

	-- Step 28: The Scarlet Crusade
	["The Scarlet Crusade"] = "血色十字军",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "{npc:10605}、血色猎人、血色骑士和血色法师在伐木场和通往{area:190}的道路上巡逻。",

	-- Step 30: Radley and Durgen
	["Radley and Durgen"] = "猎人莱德雷和骑士杜尔根",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613}在{npc:11610}东边的北山营地内走动；{npc:11611}看守着{area:190}南部入口处的塔楼。\n小心：塔楼底部有守卫，另有一名绕塔巡逻。与杜根·挽锤交战前先清理这些守卫，免得他们加入战斗。",

	-- Step 32: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "{area:190}瞭望点",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "爬上{area:190}西侧山丘，俯瞰城镇。\n注意：大门处的哨兵能够侦测潜行玩家，镇内也有更多哨兵，附近还有一名精英巡逻。",

	-- Step 34: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "向东骑到边界河：{npc:1855}住在河岸边的小屋里。",

	-- Step 35: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "{area:201}的大锅",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "向南骑到{area:201}，{npc:11078}守卫着那里的大锅。",

	-- Step 36: Chillwind Camp
	["Ride south-west to the camp."] = "向西南骑回营地。",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{area:976}的{npc:5411}：先留着",

	-- Step 37: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "飞往{area:2268}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "{area:3197}的飞行管理员",

	-- Step 39: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "向西北骑到{area:2277}边缘的{area:2276}。",

	-- Step 40: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "掠夺者霍古斯的头骨在{area:2624}，马杜克·布莱克波尔的剑在{area:2623}，各在鬼魂交战的地方；成年的{npc:8597}在两地之间的平原上捕猎。",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "{item:12956}：在水下",

	-- Step 41: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}：沿途击杀以下目标",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "向西骑到{area:2627}。{npc:8596}、{npc:8600}和{npc:8603}在树林里游荡；在大白蚁丘装满{item:15042}，然后击杀更北边的{npc:8598}。",

	-- Step 42: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "向北骑到{area:2627}。{npc:12384}住在破屋里，他的收据簿在附近的废弃旅店里。",

	-- Step 43: Augustus the Touched
	-- {npc:8598} Frenzied Plaguehound
	["{npc:8598}, 170 yd north-east"] = "{npc:8598}，东北方170码",

	-- Step 44: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}：沿途击杀以下目标",

	-- Step 45: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "向西过河到{npc:1855}的小屋。",

	-- Step 47: Tirion Fordring
	["Listen to his story"] = "听他讲述他的故事",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886}是精英：建议组队",

	-- Step 48: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954}在{npc:1855}西边{area:190}的市政厅里：血色卫兵站得很近。",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "{item:12954}：在屋内",

	-- Step 49: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955}在{area:201}谷仓东边。",

	-- Step 51: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "向东过河到{area:2261}，即区域西南部的地穴。{object:177667}在里面：它的钥匙在东北远端的{npc:12248}身上，在下一份指南中完成。",
	-- {object:177667} Torn Scroll
	["{object:177667}, below ground"] = "{object:177667}：在地下",

	-- Step 53: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飞往{area:271}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "{area:348}的飞行管理员",

	-- Step 55: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "飞往{area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "{area:442}的飞行管理员",

	-- Step 56: Rut'theran Village
	-- {zone:1452} Winterspring
	["Ranshalla in {zone:1452}: keep it"] = "兰莎尔拉在{zone:1452}，保留任务",

	-- Step 58: The Temple Gardens
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878}和{npc:7740}站在月神殿旁；在殿内的月亮井装满{item:11682}。",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}：留到{area:976}",

	-- Step 59: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus
	["The portal in {area:702} leads up to {zone:1457}."] = "{area:702}的传送门通往上方的{zone:1457}。",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}，在{area:1658}",

	-- Step 63: Darnassus
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "下一份指南学习技能的{zone:1455}没有德鲁伊训练师",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "从{item:11020}获得十个{item:11040}",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{zone:1450}的{quest:6762}：先留着",

	-- Step 64: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "传送至{zone:1438}",

	-- Step 65: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702}的飞行管理员",

	-- Step 66: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "从{area:702}飞往{area:1116}。",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}：留到{zone:1446}",

	-- Step 68: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "乘船前往{area:1108}",

	-- Step 69: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "乘船到大陆，向东北骑到{area:1119}旁{npc:14637}的营地。",

	-- Step 70: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}：沿途击杀以下目标",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "缩小的巨人在{area:1119}游荡；海元素在西边的海岸涉水。",

	-- Step 72: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "{npc:7775}的营地在{area:1119}北边。拿到诱饵后，他会出售{item:11243}。",

	-- Step 73: Rockbiter
	-- {npc:7765} Rockbiter · {npc:7775} Gregan Brewspewer
	["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "",

	-- Step 74: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {item:9189} Shay's Bell
	["Ride north into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "",

	-- Step 75: Wandering Shay
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "",

	-- Step 77: Fly to Theramore
	["Fly to Theramore"] = "飞往塞拉摩岛",
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "{area:489}的飞行管理员",

	-- Step 79: Ratchet
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "从塞拉摩出发，向西骑入{zone:1413}，再沿海岸向北到{area:392}。",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}，在镇子北边的海岸",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "交给{zone:1448}：先留着",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro; inside"] = "{npc:8496}位于屋内：保留任务，留待安戈洛处理",

	-- Step 80: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "飞往{area:2255}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}的飞行管理员",

	-- Step 82: Donova Snowden
	["Ride west along the road to the hot springs."] = "沿道路向西骑到温泉。",
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} in {area:976}: keep it"] = "{npc:9299}位于{area:976}，保留任务",

	-- Step 84: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "走进{area:1769}，沿隧道的{zone:1450}分支到{area:2361}。",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "交给{zone:1451}：先留着",

	-- Step 85: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飞往{area:976}",

	-- Step 86: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}：在屋内",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "对{npc:7583}使用",
	-- {area:3197} Chillwind Camp
	["For {area:3197}: keep it"] = "留到{area:3197}：留着",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro, keep it"] = "{npc:7876}，在镇子北侧：焦油在安戈洛，保留任务",

	-- Step 87: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299}在镇子东边不远的墓地等候；墓碑就在附近。",

	-- Step 88: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "向西南骑行到{area:1938}的{npc:7771}营地。",
	-- {quest:3444} The Stone Circle · {area:392} Ratchet
	["{quest:3444} is in {area:392}"] = "{quest:3444}在{area:392}",

	-- Step 90: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "飞往{area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976}的飞行管理员",

	-- Step 91: Linken
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:8737} Linken · {area:538} Lakkari Tar Pits · {npc:9117} J.D. Collie · {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "从 {area:976} 飞往 {area:541}。{npc:8737} 的小屋位于避难所西侧的 {area:538}；{npc:9117} 在屋后山坡上。\n{npc:9997} 的朋友 {npc:9999} 失踪了。",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}：在地下",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "{npc:9997}旁边的木牌",

	-- Step 92: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "进入{zone:1451}",

	-- Step 93: Layo Starstrike
	-- {zone:1451} Silithus · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["Ride out of the crater's north-western pass into {zone:1451}: {npc:13220} stands at {area:3077}, where the pass comes out."] = "",

	-- Step 95: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "{npc:17082}，在联盟帐篷处",

	-- Step 96: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}：沿途击杀以下目标",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "掘泥打击者在要塞西北方的沙丘中挖掘；石鞭蝎和掠沙蜘蛛在四周游荡。",

	-- Step 97: Level 56.89
	["Level 56.89"] = "等级 56.89",
	-- {item:9328} Super Snapper FX · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "如果跳过了{item:9328}相关任务，就在这里刷怪到56.89级，跟上路线的等级规划。也可组队挑战{area:1584}副本或{area:1583}副本（下层）。",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "反复击杀{npc:11740}补足经验",

	-- Step 98: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 99: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "掘泥摧毁者在更西边挖掘；石鞭巨钳蝎、石鞭掠夺者和石行蜘蛛在同一片沙地狩猎。",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "{npc:11741}在附近巡逻，请在地图标示的圆圈内寻找",

	-- Step 100: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "被折磨的德鲁伊和被折磨的哨兵在{npc:13220}西南方的废弃村庄中游荡。",

	-- Step 102: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "{area:2742}高塔",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "向东骑行到{area:2738}的{area:2742}高塔；爬上去，杀死为硬壳物品涌出的亚什伏击者。",

	-- Step 103: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "{zone:1450}的阿姆伯尔：留着",

	-- Step 105: Krakle
	-- {zone:1451} Silithus · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Coming in from {zone:1451}, {area:543} is just inside the crater: {npc:10302} the goblin sits by the water."] = "",

	-- Step 106: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "{zone:1449}：沿途击杀以下目标",

	-- Step 107: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "向东骑行到{area:537}，爬上去，在山顶附近的熔岩喷口使用{npc:10541}。",

	-- Step 108: Krakle
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "在{zone:1452}的{npc:9298}处结束：留着",

	-- Step 109: Northern Pylon
	["Northern Pylon"] = "北部水晶塔",

	-- Step 111: The crater
	["The crater"] = "环形山",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "焦油兽在{area:538}打滚，中央{area:537}的火元素携带灰烬，南侧{area:540}的格里什毒蜂携带腺体。环形山内所有生物都有几率掉落{item:11018}。\n注意：格里什工蝎生命值低于 45% 时，有 50% 几率呼叫 25 码内盟友支援。",

	-- Step 112: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "",

	-- Step 113: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}：沿途击杀以下目标",
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "猩猩生活在{area:541}以东的{area:1943}，保留毛皮交给{npc:9619}。不要进入最深处的洞穴，里面的{npc:9622}为 55 级。\n注意：50–51 级的安戈洛猩猩生命值降到 25% 时，会召集 20 码内盟友支援。这里有一座满是猩猩的洞穴，在洞内战斗会引来许多额外敌人。",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "{item:11478}：在地下",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "{item:11479}：在地下",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "{item:11480}：在地下",

	-- Step 115: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "沿东侧向北骑行到猩猩高地。55级的猩猩{npc:9622}坐在最深的洞里：先清理洞口的猩猩。",
	["Below ground"] = "在地下",

	-- Step 116: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "{npc:9684}的巢穴在{npc:9619}北边的丛林中，东部悬崖下方：在那里使用{item:11568}。{npc:9684}是56级：满血开打。",

	-- Step 117: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "穿过环形山南部，到坡道旁找{npc:9619}。",

	-- Step 118: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "{area:1942}：沿途击杀以下目标",

	-- Step 119: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}坐在环形山中央{area:537}的东南坡上。",

	-- Step 120: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "护送{npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "向北护送{npc:9999}前往{area:541}。他昏倒时，对他使用{item:11804}唤醒。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal Watches"] = "安多哈尔怀表",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "向北回到{area:202}：大锅现在会提供它自己的任务。附近的食尸鬼掉落{item:13356}。",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "出发前从{npc:11056}处买一个{item:13320}用于费尔斯通农场的大锅：它在30分钟后消失。",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "再买两个{item:13320}，用于{area:202}和达尔松之泪的大锅，然后直接骑过去：它们在30分钟后消失。",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "爬上{area:190}西边的山丘俯瞰小镇。",
	-- ["Diseased Wolves"] = "生病的狼",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "在{area:618}的{npc:9298}处结束：留着",
	-- ["Fly to {area:392}."] = "飞往{area:392}。",
	-- ["Follow the road south-west out of the pass to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "沿道路向西南出山口，前往{area:3425}。{npc:15189}在他那栋建筑的楼上：从室内上楼，箭头无法区分楼层。",
	-- ["For {area:1377}: keep it"] = "留到{area:1377}：先留着",
	-- ["For {zone:1453}: keep it"] = "交给{zone:1453}：先留着",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "从{area:392}飞往{area:2255}，向南骑到{area:2250}。",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "骑回{area:3197}，飞往{area:150}，乘船前往{area:442}，再飞往{area:702}；传送门通往{zone:1457}。",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "沿坡道下到环形山：{npc:9619}在坡道脚下扎营。",
	-- ["Ride east to {npc:13220}."] = "向东骑行到{npc:13220}处。",
	-- ["Ride out of the crater's north-western pass into {area:1377} and on to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "从环形山西北的山口骑出，进入{area:1377}，继续前往{area:3425}。{npc:15189}在他那栋建筑的楼上：从室内上楼，箭头无法区分楼层。",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "向西经过{area:541}，再沿西侧向南到{area:543}：地精{npc:10302}坐在水边。",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "{npc:1783}和{npc:1791}在营地北边的田野里游荡；这里的所有天灾军团都会掉落天灾石。",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "安多哈尔各处的瓦砾中散落着小箱子；每个里面有一块怀表。",
	-- ["Temple of the Moon"] = "月神殿",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "大锅现在会提供它自己的任务；周围的骷髅掉落{item:13357}。",
	-- ["The fields"] = "田野",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "下一份指南从{area:392}开始，然后飞往{area:976}。",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "毛皮在第2圈之后，在猩猩高地上",
	-- ["Umber in {area:493}: keep it"] = "{area:493}的阿姆伯尔：留着",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "走进{area:1769}，沿隧道的{area:493}分支到{area:2361}。",
	-- ["Zapped giants and sea elementals"] = "被电过的巨人和海元素",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "在{zone:1422}的{area:202}刷{npc:1796}",
	-- ["{area:1377}: kill these as you meet them"] = "{area:1377}：沿途击杀以下目标",
	-- ["{area:139}: kill these as you meet them"] = "{area:139}：沿途击杀以下目标",
	-- ["{area:199} cauldron"] = "{area:199}的大锅",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}，来自{npc:11056}",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}：她的护送任务在路线后面",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739}站在田野东北方{area:202}的农场旁。",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}的鬼魂在{area:200}西边、{area:199}的农舍旁游荡；她的包裹在屋里。",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}，在礼拜堂南边的墓地旁",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}守卫着安多哈尔西边{area:199}的大锅。",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140}站在{area:2627}被感动的奥古斯图斯的小屋旁。",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613}在{npc:11610}东边的北山营地巡逻；{npc:11611}守卫着{area:190}南边入口的塔。",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}：白蚁之后在{area:2627}收集",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852}是精英：建议组队。他在安多哈尔中央守护着他的护命匣。",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900}：留到{area:440}",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}：留到安戈洛环形山",
	-- ["{object:175924}, in the farmhouse"] = "{object:175924}，在农舍里",
	-- ["{quest:6762} in {area:493}: keep it"] = "{area:493}的{quest:6762}：先留着",
}
