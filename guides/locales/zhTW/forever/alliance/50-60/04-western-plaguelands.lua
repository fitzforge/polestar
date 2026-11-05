-- Chinese (traditional) (zhTW): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 3: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "{npc:10927}的農舍在營地東邊的山丘上；{npc:10936}的紀念碑就在它北邊。",
	["Upstairs"] = "",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}，在紀念碑旁",

	-- Step 4: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739}站在田野東北方{area:202}的農場旁。",
	["Inside"] = "",

	-- Step 5: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "向西北騎往達爾松的農場。日記在穀倉裡；一具遊蕩的骷髏帶著廁所的鑰匙，{npc:10836}在廁所裡等著，身上有櫃子的鑰匙。",
	-- {quest:5058} Mrs. Dalson's Diary
	["{quest:5058}, inside"] = "",

	-- Step 6: Writhing Haunt: kill these as you meet them
	-- {area:202} Writhing Haunt
	["{area:202}: kill these as you meet them"] = "",

	-- Step 7: Dalson's Tears
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "",

	-- Step 8: Chillwind Camp
	["Ride back south to the camp."] = "向南騎回營地。",

	-- Step 9: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "安多哈爾哨塔",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "在營地北邊、安多哈爾周圍四座哨塔的塔底各使用一次{item:12815}。",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}標記{npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}標記{npc:10903}",

	-- Step 10: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667}在安多哈爾西側的旅店廢墟裡等候。",

	-- Step 11: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "{area:199}的瘟疫之鍋",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}守護著安多哈爾西邊{area:199}的瘟疫之鍋。",

	-- Step 12: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}的鬼魂在{area:200}西邊{area:199}的農舍旁徘徊；她的包裹就在屋裡。",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "給{zone:1453}：保留此任務",

	-- Step 13: The Andorhal watchtowers
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}標記{npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}標記{npc:10905}",

	-- Step 14: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852}是61級精英",

	-- Step 15: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "{area:200}的瘟疫之鍋",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "瘟疫之鍋位於費爾斯通東北方的{area:200}；它的護鍋者就站在旁邊。",

	-- Step 16: Andorhal
	["Andorhal"] = "安多哈爾",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "在穀倉旁使用{item:12627}引出時光寄生蟲。{quest:5154}是市政廳裡發霉的書籍之一。城裡的每具骷髏都會掉落{quest:5537}。",

	-- Step 18: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "{area:202}的瘟疫之鍋",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "瘟疫之鍋位於{area:202}，在{npc:10739}的農場旁。",

	-- Step 20: Diseased Grizzlies
	["Diseased Grizzlies"] = "生病的灰熊",

	-- Step 21: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "給{zone:1457}的德魯伊：保留此任務",

	-- Step 24: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}，在{area:2268}：保留此任務",

	-- Step 25: Sorrow Hill: kill these as you meet them
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 27: More watches
	["More watches"] = "更多懷錶",

	-- Step 29: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "沿著道路向北騎往北山伐木場；{npc:11610}躲在營地邊緣。",

	-- Step 30: Scarlet Knight on the way
	-- {npc:1833} Scarlet Knight
	["{npc:1833} on the way"] = "",
	-- {npc:1833} Scarlet Knight · {npc:11610} Kirsta Deepshadow
	["{npc:1833} along the way to {npc:11610}"] = "",

	-- Step 31: The Scarlet Crusade
	["The Scarlet Crusade"] = "血色十字軍",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "血色醫護員、血色獵人、血色騎士和血色法師在伐木場和通往{area:190}的道路上巡邏。",

	-- Step 33: Radley and Durgen
	["Radley and Durgen"] = "萊德雷與杜爾根",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 35: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "{area:190}瞭望點",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 37: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "向東騎往邊界河：{npc:1855}住在河岸的小屋裡。",

	-- Step 38: Slab of Carrion Worm Meat on the way
	-- {item:13853} Slab of Carrion Worm Meat
	["{item:13853} on the way"] = "",

	-- Step 39: Frenzied Plaguehound on the way
	-- {npc:8598} Frenzied Plaguehound
	["{npc:8598} on the way"] = "",

	-- Step 40: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "{area:201}的瘟疫之鍋",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "向南騎往{area:201}，{npc:11078}在那裡守護著瘟疫之鍋。",

	-- Step 41: Chillwind Camp
	["Ride south-west to the camp."] = "向西南騎回營地。",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{area:976}的{npc:5411}：保留此任務",

	-- Step 42: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 44: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "向西北騎往{area:2277}邊緣的{area:2276}。",

	-- Step 45: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "霍古斯的顱骨在{area:2624}，馬杜克的劍在{area:2623}，各自位於鬼魂交戰之處；成年的瘟疫犬在兩地之間的平原上獵食。",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "",

	-- Step 46: Eastern Plaguelands: kill these as you meet them
	-- {area:139} Eastern Plaguelands
	["{area:139}: kill these as you meet them"] = "",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "向西騎往{area:2627}。瘟疫幼犬、瘟疫蝙蝠和腐肉蟲在樹林中遊蕩；在大白蟻丘裝滿{item:15042}，並擊殺更北邊的狂怒的瘟疫犬。",

	-- Step 47: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched · {npc:11140} Egan
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby.\n{npc:11140} stands by {npc:12384}' hut in {area:2627}."] = "",

	-- Step 49: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "",

	-- Step 50: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "向西渡河前往{npc:1855}的小屋。",

	-- Step 52: Tirion Fordring
	["Listen to his story"] = "聆聽他的故事",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886}是精英：建議組隊",

	-- Step 53: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954}在{npc:1855}西邊{area:190}的市政廳裡：血色衛兵站得很密集。",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "",

	-- Step 54: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955}在{area:201}穀倉的東邊。",

	-- Step 56: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "",
	-- {object:177667} Torn Scroll
	["{object:177667}, below ground"] = "",

	-- Step 58: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 60: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 62: The Temple Gardens
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878}和{npc:7740}站在月神殿旁；在殿內的月井裝滿{item:11682}。",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}：保留給{area:976}",

	-- Step 63: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus
	["The portal in {area:702} leads up to {zone:1457}."] = "",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}，在{area:1658}",
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "下一份指南學習技能的{zone:1455}沒有德魯伊訓練師",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "從{item:11020}取得十個{item:11040}",
	-- {quest:6762} Rabine Saturna · {area:493} Moonglade
	["{quest:6762} in {area:493}: keep it"] = "",

	-- Step 64: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "",

	-- Step 65: Rut'theran Village
	-- {area:618} Winterspring
	["Ranshalla in {area:618}: keep it"] = "",

	-- Step 66: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "從{area:702}飛往{area:1116}。",
	-- {npc:7900} Angelas Moonbreeze · {area:440} Tanaris
	["{npc:7900}: keep it for {area:440}"] = "",

	-- Step 68: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "",

	-- Step 69: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "搭船前往大陸，向東北騎往{area:1119}旁{npc:14637}的營地。",

	-- Step 70: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "被縮小的巨人在{area:1119}遊蕩；海元素沿著西邊的海岸涉水而行。",

	-- Step 72: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "{npc:7775}的營地在{area:1119}北邊。他拿到誘餌後就會販售{item:11243}。",

	-- Step 74: Fly to Theramore
	["Fly to Theramore"] = "",
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "",

	-- Step 76: Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}."] = "飛往{area:392}。",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}，在城鎮北邊的海岸",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "給{zone:1448}：保留此任務",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro; inside"] = "",

	-- Step 77: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 79: Donova Snowden
	["Ride west along the road to the hot springs."] = "沿著道路向西騎往溫泉。",
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} in {area:976}: keep it"] = "",

	-- Step 81: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {area:493} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "",
	-- {area:1377} Silithus
	["For {area:1377}: keep it"] = "",

	-- Step 82: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "",

	-- Step 83: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "",

	-- Step 84: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "",
	-- {area:3197} Chillwind Camp
	["For {area:3197}: keep it"] = "",

	-- Step 85: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "",

	-- Step 86: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "",
	-- {quest:3444} The Stone Circle · {area:392} Ratchet
	["{quest:3444} is in {area:392}"] = "",

	-- Step 88: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 89: Linken
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:8737} Linken · {area:538} Lakkari Tar Pits · {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; J.D.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "",

	-- Step 91: Cenarion Hold
	-- {area:1377} Silithus · {area:3425} Cenarion Hold
	["Ride out of the crater's north-western pass into {area:1377} and on to {area:3425}."] = "",

	-- Step 92: Silithus: kill these as you meet them
	-- {area:1377} Silithus
	["{area:1377}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "",

	-- Step 93: Level 56.89
	["Level 56.89"] = "",
	-- {item:9328} Super Snapper FX
	["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan."] = "",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "",

	-- Step 94: Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Follow the road south-west out of the pass to {area:3425}."] = "",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "",

	-- Step 95: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "",

	-- Step 96: Layo Starstrike
	-- {npc:13220} Layo Starstrike
	["Ride east to {npc:13220}."] = "",

	-- Step 97: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "",

	-- Step 99: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "",

	-- Step 100: Layo Starstrike
	-- {area:493} Moonglade
	["Umber in {area:493}: keep it"] = "",

	-- Step 102: Un'Goro Crater: kill these as you meet them
	-- {area:490} Un'Goro Crater
	["{area:490}: kill these as you meet them"] = "",

	-- Step 103: Krakle
	-- {area:541} Marshal's Refuge · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "",

	-- Step 104: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "",

	-- Step 105: Krakle
	-- {npc:9298} Donova Snowden · {area:618} Winterspring
	["Ends with {npc:9298} in {area:618}: keep it"] = "",

	-- Step 106: Super Sticky Tar on the way
	-- {item:11834} Super Sticky Tar
	["{item:11834} on the way"] = "",

	-- Step 107: Northern Pylon
	["Northern Pylon"] = "",

	-- Step 108: J.D. Collie
	["Collie is up the hill behind it."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",

	-- Step 110: The crater
	["The crater"] = "",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "",

	-- Step 112: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "",
	["The pelts come after loop 2, on the gorilla plateau"] = "",

	-- Step 113: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "",
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "",

	-- Step 115: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "",
	["Below ground"] = "",

	-- Step 116: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "",

	-- Step 117: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "",

	-- Step 118: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "",

	-- Step 119: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "",

	-- Step 120: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal Watches"] = "安多哈爾懷錶",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "向北回到{area:202}：瘟疫之鍋現在會提供自己的任務。附近的食屍鬼會掉落細胞增強劑。",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "出發前才向{npc:11056}購買一個{item:13320}，用於費爾斯通的瘟疫之鍋：催化劑30分鐘後就會消失。",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "為{area:202}和達爾松的瘟疫之鍋再購買兩個{item:13320}，然後直接騎過去：它們30分鐘後就會消失。",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "爬上{area:190}西邊的山丘俯瞰城鎮。",
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "向東渡河前往{area:2261}，也就是本區西南部的地穴。{object:177667}就在裡面：它的鑰匙在遠處東北方的{npc:12248}身上，在下一份指南完成。",
	-- ["Diseased Wolves"] = "生病的狼",
	-- ["For {zone:1451}: keep it"] = "給{zone:1451}：保留此任務",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "從{area:392}飛往{area:2255}，再向南騎往{area:2250}。",
	-- ["Gaeriyan in {area:976}: keep it"] = "{area:976}的加里楊：保留此任務",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "騎回{area:3197}並飛往{area:150}，搭船前往{area:442}，再飛往{area:702}；傳送門通往上方的{zone:1457}。",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "骷髏剝皮者和被奴役的食屍鬼在營地北邊的田野中遊蕩；這裡所有的天譴軍都會掉落天譴石。",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "安多哈爾各處的瓦礫堆中散落著小型保險箱；每個裡面都有一只懷錶。",
	-- ["Temple of the Moon"] = "月神殿",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "瘟疫之鍋現在會提供自己的任務；周圍的骷髏會掉落骨質分離素。",
	-- ["The fields"] = "田野",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "下一份指南從{area:392}這裡開始，然後飛往{area:976}。",
	-- ["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "走進{area:1769}，沿著隧道的{zone:1450}岔路前往{area:2361}。",
	-- ["Zapped giants and sea elementals"] = "被縮小的巨人與海元素",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "在{zone:1422}的{area:202}擊殺{npc:1796}練等",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}，來自{npc:11056}",
	-- ["{npc:10300} in {zone:1452}: keep it"] = "{zone:1452}的{npc:10300}：保留此任務",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}：她的護送任務在路線稍後",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}，在禮拜堂南邊的墳墓旁",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140}站在{area:2627}奧古斯圖斯的小屋旁。",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613}在{npc:11610}東邊的北山營地走動；{npc:11611}守衛著{area:190}南側通道的塔樓。",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}：白蟻稍後在{area:2627}處理",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852}是精英：建議組隊。他在安多哈爾中央守著他的護符匣。",
	-- ["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}：保留給{zone:1446}",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}：保留給安戈洛",
	-- ["{object:175924}, in the farmhouse"] = "{object:175924}，在農舍裡",
	-- ["{quest:6762} in {zone:1450}: keep it"] = "{zone:1450}的{quest:6762}：保留此任務",
}
