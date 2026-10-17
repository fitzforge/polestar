-- Chinese (simplified) (zhCN): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Chillwind Camp
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}：白蚁之后在{area:2627}收集",

	-- Step 2: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "{npc:10927}的农舍在营地东边的山丘上；{npc:10936}的纪念碑就在它北边。",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}，在纪念碑旁",

	-- Step 3: The fields
	["The fields"] = "田野",
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "{npc:1783}和{npc:1791}在营地北边的田野里游荡；这里的所有天灾军团都会掉落天灾石。",

	-- Step 4: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739}站在田野东北方{area:202}的农场旁。",

	-- Step 5: Diseased Wolves
	["Diseased Wolves"] = "生病的狼",

	-- Step 7: Diseased Grizzlies
	["Diseased Grizzlies"] = "生病的灰熊",

	-- Step 8: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "交给{zone:1457}的德鲁伊：先留着",

	-- Step 9: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "向西北骑到达尔松农场。日记在谷仓里；一个游荡的骷髅带着厕所钥匙，{npc:10836}在厕所里等候，身上有柜子钥匙。",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse"] = "{object:175924}，在农舍里",

	-- Step 10: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}的鬼魂在{area:200}西边、{area:199}的农舍旁游荡；她的包裹在屋里。",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "交给{zone:1453}：先留着",

	-- Step 11: Chillwind Camp
	["Ride back south to the camp."] = "向南骑回营地。",

	-- Step 12: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "安多哈尔瞭望塔",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "在营地北边、安多哈尔外围的四座瞭望塔脚下各使用一次{item:12815}。",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}标记{npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}标记{npc:10903}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}标记{npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}标记{npc:10905}",

	-- Step 13: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "{area:199}的大锅",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}守卫着安多哈尔西边{area:199}的大锅。",

	-- Step 14: Chillwind Camp
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "出发前从{npc:11056}处买一个{item:13320}用于费尔斯通农场的大锅：它在30分钟后消失。",
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["{item:13320}, from {npc:11056}"] = "{item:13320}，来自{npc:11056}",

	-- Step 15: Felstone Field cauldron
	-- plural, as words: Osseous Agitators = {item:13357} Osseous Agitator
	["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "大锅现在会提供它自己的任务；周围的骷髅掉落{item:13357}。",

	-- Step 16: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "{area:200}的大锅",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "大锅在费尔斯通农场东北方的{area:200}；护锅者拉扎奇站在旁边。",

	-- Step 18: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "{area:202}的大锅",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "大锅在{area:202}，{npc:10739}的农场旁。",
	-- {npc:1796} Freezing Ghoul · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands
	["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "在{zone:1422}的{area:202}刷{npc:1796}",

	-- Step 19: Chillwind Camp
	-- {area:202} Writhing Haunt
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "再买两个{item:13320}，用于{area:202}和达尔松之泪的大锅，然后直接骑过去：它们在30分钟后消失。",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852}是61级精英",

	-- Step 20: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	-- plural, as words: Somatic Intensifiers = {item:13356} Somatic Intensifier
	["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "向北回到{area:202}：大锅现在会提供它自己的任务。附近的食尸鬼掉落{item:13356}。",

	-- Step 22: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667}在安多哈尔西侧的废弃旅店里等候。",

	-- Step 23: Andorhal
	["Andorhal"] = "安多哈尔",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "在粮仓旁使用{item:12627}引出{npc:10717}。{quest:5154}是市政厅里的发霉的书籍之一。镇上的每个骷髅都会掉落{quest:5537}。",

	-- Step 24: Araj's Phylactery
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852}是精英：建议组队。他在安多哈尔中央守护着他的护命匣。",

	-- Step 25: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}，在{area:2268}：先留着",

	-- Step 26: Andorhal Watches
	["Andorhal Watches"] = "安多哈尔怀表",
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "安多哈尔各处的瓦砾中散落着小箱子；每个里面有一块怀表。",

	-- Step 28: More watches
	["More watches"] = "更多怀表",

	-- Step 30: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "沿道路向北骑到北山伐木场；{npc:11610}躲在营地边缘。",

	-- Step 31: The Scarlet Crusade
	["The Scarlet Crusade"] = "血色十字军",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "{npc:10605}、血色猎人、血色骑士和血色法师在伐木场和通往{area:190}的道路上巡逻。",

	-- Step 33: Radley and Durgen
	["Radley and Durgen"] = "猎人莱德雷和骑士杜尔根",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613}在{npc:11610}东边的北山营地巡逻；{npc:11611}守卫着{area:190}南边入口的塔。",

	-- Step 35: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "{area:190}瞭望点",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town."] = "爬上{area:190}西边的山丘俯瞰小镇。",

	-- Step 37: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "向东骑到边界河：{npc:1855}住在河岸边的小屋里。",

	-- Step 38: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "{area:201}的大锅",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "向南骑到{area:201}，{npc:11078}守卫着那里的大锅。",

	-- Step 39: Chillwind Camp
	["Ride south-west to the camp."] = "向西南骑回营地。",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{area:976}的{npc:5411}：先留着",

	-- Step 40: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen
	["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}，在礼拜堂南边的墓地旁",

	-- Step 41: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "掠夺者霍古斯的头骨在{area:2624}，Marduk的剑在{area:2623}，各在鬼魂交战的地方；成年的{npc:8597}在两地之间的平原上捕猎。",

	-- Step 43: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "向西北骑到{area:2277}边缘的{area:2276}。",

	-- Step 44: Terrordale
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "向西骑到{area:2627}。{npc:8596}、{npc:8600}和{npc:8603}在树林里游荡；在大白蚁丘装满{item:15042}，然后击杀更北边的{npc:8598}。",

	-- Step 45: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140}站在{area:2627}被感动的奥古斯图斯的小屋旁。",

	-- Step 46: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "向西过河到{npc:1855}的小屋。",
	["Listen to his story"] = "听他讲述他的故事",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886}是精英：建议组队",

	-- Step 47: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954}在{npc:1855}西边{area:190}的市政厅里：血色卫兵站得很近。",

	-- Step 48: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955}在{area:201}谷仓东边。",

	-- Step 49: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "向东过河到{area:2261}，即区域西南部的地穴。{object:177667}在里面：它的钥匙在东北远端的{npc:12248}身上，在下一份指南中完成。",

	-- Step 50: Darnassus
	-- {area:3197} Chillwind Camp · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "骑回{area:3197}，飞往{area:150}，乘船前往{area:442}，再飞往{area:702}；传送门通往{zone:1457}。",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}，在{area:1658}",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "从{item:11020}获得十个{item:11040}",
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "下一份指南学习技能的{zone:1455}没有德鲁伊训练师",

	-- Step 51: Temple of the Moon
	["Temple of the Moon"] = "月神殿",
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878}和{npc:7740}站在月神殿旁；在殿内的月亮井装满{item:11682}。",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}：留到{area:976}",

	-- Step 52: Cenarion Enclave
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{zone:1450}的{quest:6762}：先留着",

	-- Step 53: Rut'theran Village
	-- {npc:10300} Ranshalla · {zone:1452} Winterspring
	["{npc:10300} in {zone:1452}: keep it"] = "{zone:1452}的{npc:10300}：先留着",

	-- Step 54: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "从{area:702}飞往{area:1116}。",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}：留到{zone:1446}",

	-- Step 55: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "乘船到大陆，向东北骑到{area:1119}旁{npc:14637}的营地。",

	-- Step 56: Zapped giants and sea elementals
	["Zapped giants and sea elementals"] = "被电过的巨人和海元素",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "缩小的巨人在{area:1119}游荡；海元素在西边的海岸涉水。",

	-- Step 58: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "{npc:7775}的营地在{area:1119}北边。拿到诱饵后，他会出售{item:11243}。",

	-- Step 59: Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}."] = "飞往{area:392}。",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}：留到安戈洛环形山",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}，在镇子北边的海岸",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "交给{zone:1448}：先留着",

	-- Step 60: Ranshalla
	-- {area:392} Ratchet · {area:2255} Everlook · {area:2250} Owl Wing Thicket
	["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "从{area:392}飞往{area:2255}，向南骑到{area:2250}。",
	-- {npc:10300} Ranshalla
	["{npc:10300}: her escort comes later on the route"] = "{npc:10300}：她的护送任务在路线后面",

	-- Step 61: Donova Snowden
	["Ride west along the road to the hot springs."] = "沿道路向西骑到温泉。",
	-- {area:976} Gadgetzan
	["Gaeriyan in {area:976}: keep it"] = "{area:976}的加里杨：先留着",

	-- Step 62: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "走进{area:1769}，沿隧道的{zone:1450}分支到{area:2361}。",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "交给{zone:1451}：先留着",

	-- Step 63: Ratchet
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["The next guide starts here in {area:392} and flies on to {area:976}."] = "下一份指南从{area:392}开始，然后飞往{area:976}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "向东过河到{area:2261}，即区域西南部的地穴。{object:177667}在里面：它的钥匙在东北远端的{npc:12248}身上，在下一份指南中完成。",
}
