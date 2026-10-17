-- Chinese (traditional) (zhTW): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Light's Hope Chapel
	-- {npc:16256} Jessica Chambers
	["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",

	-- Step 2: Chillwind Camp
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}：白蟻稍後在{area:2627}處理",

	-- Step 3: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "{npc:10927}的農舍在營地東邊的山丘上；{npc:10936}的紀念碑就在它北邊。",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}，在紀念碑旁",

	-- Step 4: The fields
	["The fields"] = "田野",
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "骷髏剝皮者和被奴役的食屍鬼在營地北邊的田野中遊蕩；這裡所有的天譴軍都會掉落天譴石。",

	-- Step 5: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739}站在田野東北方{area:202}的農場旁。",

	-- Step 6: Diseased Wolves
	["Diseased Wolves"] = "生病的狼",

	-- Step 8: Diseased Grizzlies
	["Diseased Grizzlies"] = "生病的灰熊",

	-- Step 9: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "給{zone:1457}的德魯伊：保留此任務",

	-- Step 10: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "向西北騎往達爾松的農場。日記在穀倉裡；一具遊蕩的骷髏帶著廁所的鑰匙，{npc:10836}在廁所裡等著，身上有櫃子的鑰匙。",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse"] = "{object:175924}，在農舍裡",

	-- Step 11: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}的鬼魂在{area:200}西邊{area:199}的農舍旁徘徊；她的包裹就在屋裡。",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "給{zone:1453}：保留此任務",

	-- Step 12: Chillwind Camp
	["Ride back south to the camp."] = "向南騎回營地。",

	-- Step 13: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "安多哈爾哨塔",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "在營地北邊、安多哈爾周圍四座哨塔的塔底各使用一次{item:12815}。",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}標記{npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}標記{npc:10903}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}標記{npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}標記{npc:10905}",

	-- Step 14: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "{area:199}的瘟疫之鍋",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}守護著安多哈爾西邊{area:199}的瘟疫之鍋。",

	-- Step 15: Chillwind Camp
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "出發前才向{npc:11056}購買一個{item:13320}，用於費爾斯通的瘟疫之鍋：催化劑30分鐘後就會消失。",
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["{item:13320}, from {npc:11056}"] = "{item:13320}，來自{npc:11056}",

	-- Step 16: Felstone Field cauldron
	-- plural, as words: Osseous Agitators = {item:13357} Osseous Agitator
	["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "瘟疫之鍋現在會提供自己的任務；周圍的骷髏會掉落骨質分離素。",

	-- Step 17: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "{area:200}的瘟疫之鍋",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "瘟疫之鍋位於費爾斯通東北方的{area:200}；它的護鍋者就站在旁邊。",

	-- Step 19: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "{area:202}的瘟疫之鍋",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "瘟疫之鍋位於{area:202}，在{npc:10739}的農場旁。",
	-- {npc:1796} Freezing Ghoul · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands
	["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "在{zone:1422}的{area:202}擊殺{npc:1796}練等",

	-- Step 20: Chillwind Camp
	-- {area:202} Writhing Haunt
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "為{area:202}和達爾松的瘟疫之鍋再購買兩個{item:13320}，然後直接騎過去：它們30分鐘後就會消失。",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852}是61級精英",

	-- Step 21: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	-- plural, as words: Somatic Intensifiers = {item:13356} Somatic Intensifier
	["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "向北回到{area:202}：瘟疫之鍋現在會提供自己的任務。附近的食屍鬼會掉落細胞增強劑。",

	-- Step 23: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667}在安多哈爾西側的旅店廢墟裡等候。",

	-- Step 24: Andorhal
	["Andorhal"] = "安多哈爾",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "在穀倉旁使用{item:12627}引出時光寄生蟲。{quest:5154}是市政廳裡發霉的書籍之一。城裡的每具骷髏都會掉落{quest:5537}。",

	-- Step 25: Araj's Phylactery
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852}是精英：建議組隊。他在安多哈爾中央守著他的護符匣。",

	-- Step 26: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}，在{area:2268}：保留此任務",

	-- Step 27: Andorhal Watches
	["Andorhal Watches"] = "安多哈爾懷錶",
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "安多哈爾各處的瓦礫堆中散落著小型保險箱；每個裡面都有一只懷錶。",

	-- Step 29: More watches
	["More watches"] = "更多懷錶",

	-- Step 31: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "沿著道路向北騎往北山伐木場；{npc:11610}躲在營地邊緣。",

	-- Step 32: The Scarlet Crusade
	["The Scarlet Crusade"] = "血色十字軍",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "血色醫護員、血色獵人、血色騎士和血色法師在伐木場和通往{area:190}的道路上巡邏。",

	-- Step 34: Radley and Durgen
	["Radley and Durgen"] = "萊德雷與杜爾根",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613}在{npc:11610}東邊的北山營地走動；{npc:11611}守衛著{area:190}南側通道的塔樓。",

	-- Step 36: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "{area:190}瞭望點",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town."] = "爬上{area:190}西邊的山丘俯瞰城鎮。",

	-- Step 38: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "向東騎往邊界河：{npc:1855}住在河岸的小屋裡。",

	-- Step 39: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "{area:201}的瘟疫之鍋",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "向南騎往{area:201}，{npc:11078}在那裡守護著瘟疫之鍋。",

	-- Step 40: Chillwind Camp
	["Ride south-west to the camp."] = "向西南騎回營地。",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{area:976}的{npc:5411}：保留此任務",

	-- Step 41: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen
	["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}，在禮拜堂南邊的墳墓旁",

	-- Step 42: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "霍古斯的顱骨在{area:2624}，馬杜克的劍在{area:2623}，各自位於鬼魂交戰之處；成年的瘟疫犬在兩地之間的平原上獵食。",

	-- Step 44: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "向西北騎往{area:2277}邊緣的{area:2276}。",

	-- Step 45: Terrordale
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "向西騎往{area:2627}。瘟疫幼犬、瘟疫蝙蝠和腐肉蟲在樹林中遊蕩；在大白蟻丘裝滿{item:15042}，並擊殺更北邊的狂怒的瘟疫犬。",

	-- Step 46: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140}站在{area:2627}奧古斯圖斯的小屋旁。",

	-- Step 47: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "向西渡河前往{npc:1855}的小屋。",
	["Listen to his story"] = "聆聽他的故事",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886}是精英：建議組隊",

	-- Step 48: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954}在{npc:1855}西邊{area:190}的市政廳裡：血色衛兵站得很密集。",

	-- Step 49: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955}在{area:201}穀倉的東邊。",

	-- Step 50: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "向東渡河前往{area:2261}，也就是本區西南部的地穴。{object:177667}就在裡面：它的鑰匙在遠處東北方的{npc:12248}身上，在下一份指南完成。",

	-- Step 51: Darnassus
	-- {area:3197} Chillwind Camp · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "騎回{area:3197}並飛往{area:150}，搭船前往{area:442}，再飛往{area:702}；傳送門通往上方的{zone:1457}。",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}，在{area:1658}",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "從{item:11020}取得十個{item:11040}",
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "下一份指南學習技能的{zone:1455}沒有德魯伊訓練師",

	-- Step 52: Temple of the Moon
	["Temple of the Moon"] = "月神殿",
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878}和{npc:7740}站在月神殿旁；在殿內的月井裝滿{item:11682}。",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}：保留給{area:976}",

	-- Step 53: Cenarion Enclave
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{zone:1450}的{quest:6762}：保留此任務",

	-- Step 54: Rut'theran Village
	-- {npc:10300} Ranshalla · {zone:1452} Winterspring
	["{npc:10300} in {zone:1452}: keep it"] = "{zone:1452}的{npc:10300}：保留此任務",

	-- Step 55: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "從{area:702}飛往{area:1116}。",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}：保留給{zone:1446}",

	-- Step 56: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "搭船前往大陸，向東北騎往{area:1119}旁{npc:14637}的營地。",

	-- Step 57: Zapped giants and sea elementals
	["Zapped giants and sea elementals"] = "被縮小的巨人與海元素",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "被縮小的巨人在{area:1119}遊蕩；海元素沿著西邊的海岸涉水而行。",

	-- Step 59: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "{npc:7775}的營地在{area:1119}北邊。他拿到誘餌後就會販售{item:11243}。",

	-- Step 60: Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}."] = "飛往{area:392}。",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}：保留給安戈洛",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}，在城鎮北邊的海岸",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "給{zone:1448}：保留此任務",

	-- Step 61: Ranshalla
	-- {area:392} Ratchet · {area:2255} Everlook · {area:2250} Owl Wing Thicket
	["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "從{area:392}飛往{area:2255}，再向南騎往{area:2250}。",
	-- {npc:10300} Ranshalla
	["{npc:10300}: her escort comes later on the route"] = "{npc:10300}：她的護送任務在路線稍後",

	-- Step 62: Donova Snowden
	["Ride west along the road to the hot springs."] = "沿著道路向西騎往溫泉。",
	-- {area:976} Gadgetzan
	["Gaeriyan in {area:976}: keep it"] = "{area:976}的加里楊：保留此任務",

	-- Step 63: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "走進{area:1769}，沿著隧道的{zone:1450}岔路前往{area:2361}。",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "給{zone:1451}：保留此任務",

	-- Step 64: Ratchet
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["The next guide starts here in {area:392} and flies on to {area:976}."] = "下一份指南從{area:392}這裡開始，然後飛往{area:976}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "向東渡河前往{area:2261}，也就是本區西南部的地穴。{object:177667}就在裡面：它的鑰匙在遠處東北方的{npc:12248}身上，在下一份指南完成。",
}
