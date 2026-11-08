-- Chinese (traditional) (zhTW): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Chillwind Camp
	["Chillwind Camp"] = "",

	-- Step 2: Sorrow Hill: kill these as you meet them
	["Sorrow Hill: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 3: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "{npc:10927}的農舍在營地東邊的山丘上；{npc:10936}的紀念碑就在它北邊。",
	["Upstairs"] = "",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}，在紀念碑旁",

	-- Step 4: Dalson's Tears
	["Dalson's Tears"] = "",
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "向西北騎往達爾松的農場。日記在穀倉裡；一具遊蕩的骷髏帶著廁所的鑰匙，{npc:10836}在廁所裡等著，身上有櫃子的鑰匙。",
	-- {quest:5058} Mrs. Dalson's Diary
	["{quest:5058}, inside"] = "",
	["Inside"] = "",

	-- Step 5: The Writhing Haunt: kill these as you meet them
	["The Writhing Haunt: kill these as you meet them"] = "",

	-- Step 6: Dalson's Tears
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "",

	-- Step 7: Chillwind Camp
	["Ride back south to the camp."] = "向南騎回營地。",

	-- Step 8: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "安多哈爾哨塔",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "在營地北邊、安多哈爾周圍四座哨塔的塔底各使用一次{item:12815}。",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "用{item:12815}標記{npc:10902}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "用{item:12815}標記{npc:10903}",

	-- Step 9: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667}在安多哈爾西側的旅店廢墟裡等候。",

	-- Step 10: The Andorhal watchtowers
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "用{item:12815}標記{npc:10904}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "用{item:12815}標記{npc:10905}",

	-- Step 11: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852}是61級精英",

	-- Step 12: Dalson's Tears cauldron
	["Dalson's Tears cauldron"] = "",
	["The cauldron sits at Dalson's Tears, north-east of Felstone; its Cauldron Lord stands beside it."] = "",

	-- Step 13: Andorhal
	["Andorhal"] = "安多哈爾",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "在穀倉旁使用{item:12627}引出時光寄生蟲。{quest:5154}是市政廳裡發霉的書籍之一。城裡的每具骷髏都會掉落{quest:5537}。",

	-- Step 15: Writhing Haunt cauldron
	["Writhing Haunt cauldron"] = "",
	-- {npc:10739} Mulgris Deepriver
	["The cauldron sits at the Writhing Haunt, by {npc:10739}' farm."] = "",

	-- Step 17: Diseased Grizzlies
	["Diseased Grizzlies"] = "生病的灰熊",

	-- Step 18: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "給{zone:1457}的德魯伊：保留此任務",

	-- Step 20: Chromie
	-- {quest:5210} Brother Carlin
	["{quest:5210}, at Light's Hope Chapel: keep it"] = "",

	-- Step 21: Sorrow Hill: kill these as you meet them
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 23: More watches
	["More watches"] = "更多懷錶",

	-- Step 25: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "沿著道路向北騎往北山伐木場；{npc:11610}躲在營地邊緣。",

	-- Step 26: The Scarlet Crusade
	["The Scarlet Crusade"] = "血色十字軍",
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward Hearthglen."] = "",

	-- Step 28: Radley and Durgen
	["Radley and Durgen"] = "萊德雷與杜爾根",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at Hearthglen's southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 30: Hearthglen overlook
	["Hearthglen overlook"] = "",
	["Climb the hill west of Hearthglen to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 32: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "向東騎往邊界河：{npc:1855}住在河岸的小屋裡。",

	-- Step 33: Gahrron's Withering cauldron
	["Gahrron's Withering cauldron"] = "",
	-- {npc:11078} Cauldron Lord Soulwrath
	["Ride south to Gahrron's Withering, where {npc:11078} guards the cauldron."] = "",

	-- Step 34: Chillwind Camp
	["Ride south-west to the camp."] = "向西南騎回營地。",
	-- {npc:5411} Krinkle Goodsteel
	["{npc:5411} in Gadgetzan: keep it"] = "",

	-- Step 35: Fly to Light's Hope Chapel
	["Fly to Light's Hope Chapel"] = "",
	["Chillwind Camp flight master"] = "",

	-- Step 36: Light's Hope Chapel
	["Light's Hope Chapel"] = "",

	-- Step 37: Aurora Skycaller
	["Ride north-west to Quel'Lithien Lodge, at the edge of the Plaguewood."] = "",

	-- Step 38: Villains of Darrowshire
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at Blackwood Lake and Marduk's sword in the Infectis Scar, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "",

	-- Step 39: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "",
	-- {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to Terrordale. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "",

	-- Step 40: Augustus the Touched
	-- {npc:12384} Augustus the Touched
	["Ride north to Terrordale. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "",

	-- Step 41: Augustus the Touched
	-- {npc:8598} Frenzied Plaguehound
	["{npc:8598}, 170 yd north-east"] = "",

	-- Step 42: Plaguewood: kill these as you meet them
	["Plaguewood: kill these as you meet them"] = "",

	-- Step 43: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "向西渡河前往{npc:1855}的小屋。",

	-- Step 45: Tirion Fordring
	["Listen to his story"] = "聆聽他的故事",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886}是精英：建議組隊",

	-- Step 46: Davil's Libram
	-- {item:12954} Davil's Libram · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of Hearthglen, west of {npc:1855}: the Scarlet guards stand close together."] = "",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "",

	-- Step 47: Redpath's Shield
	-- {item:12955} Redpath's Shield
	["{item:12955} lies east of the barn at Gahrron's Withering."] = "",

	-- Step 49: The Undercroft
	["The Undercroft"] = "",
	-- {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the Undercroft, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "",
	-- {object:177667} Torn Scroll
	["{object:177667}, below ground"] = "",

	-- Step 51: Fly to Southshore
	["Fly to Southshore"] = "",
	["Aerie Peak flight master"] = "",

	-- Step 53: Fly to Rut'theran Village
	["Fly to Rut'theran Village"] = "",
	["Auberdine flight master"] = "",

	-- Step 55: The Temple Gardens
	["The Temple Gardens"] = "",
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878}和{npc:7740}站在月神殿旁；在殿內的月井裝滿{item:11682}。",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}: keep it for Gadgetzan"] = "",

	-- Step 56: Darnassus
	-- {zone:1457} Darnassus
	["The portal in Rut'theran Village leads up to {zone:1457}."] = "",
	-- {npc:9047} Jenal
	["{npc:9047}, in the Cenarion Enclave"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "下一份指南學習技能的{zone:1455}沒有德魯伊訓練師",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "從{item:11020}取得十個{item:11040}",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{zone:1450}的{quest:6762}：保留此任務",

	-- Step 57: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "",

	-- Step 58: Rut'theran Village
	["Rut'theran Village"] = "",
	-- {zone:1452} Winterspring
	["Ranshalla in {zone:1452}: keep it"] = "",

	-- Step 59: Feathermoon Stronghold
	-- {object:152576} Feathermoon Stronghold (no name in this language: may be words)
	["From Rut'theran Village, fly to {object:152576}."] = "",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}：保留給{zone:1446}",

	-- Step 61: Boat to The Forgotten Coast
	["Boat to The Forgotten Coast"] = "",

	-- Step 62: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {object:152574} Twin Colossals (no name in this language: may be words)
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {object:152574}."] = "",

	-- Step 63: The Forgotten Coast: kill these as you meet them
	["The Forgotten Coast: kill these as you meet them"] = "",
	-- {object:152574} Twin Colossals (no name in this language: may be words)
	["The shrunken giants roam the {object:152574}; the sea elementals wade along the coast to the west."] = "",

	-- Step 65: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {object:152574} Twin Colossals (no name in this language: may be words) · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {object:152574}. He sells the {item:11243} once he has his bait."] = "",

	-- Step 67: Fly to Theramore
	["Fly to Theramore"] = "飛往塞拉摩",
	["Thalanaar flight master"] = "",

	-- Step 69: Ratchet
	["Ratchet"] = "",
	-- {zone:1413} The Barrens
	["From Theramore, ride west into the {zone:1413} and north up the coast to Ratchet."] = "",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}，在城鎮北邊的海岸",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "給{zone:1448}：保留此任務",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro; inside"] = "",

	-- Step 70: Fly to Everlook
	["Fly to Everlook"] = "",
	["Ratchet flight master"] = "",

	-- Step 72: Donova Snowden
	["Ride west along the road to the hot springs."] = "沿著道路向西騎往溫泉。",
	-- {npc:9299} Gaeriyan
	["{npc:9299} in Gadgetzan: keep it"] = "",

	-- Step 74: Rabine Saturna
	-- {zone:1450} Moonglade
	["Walk into Timbermaw Hold and take the {zone:1450} branch of the tunnel to Nighthaven."] = "",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "給{zone:1451}：保留此任務",

	-- Step 75: Fly to Gadgetzan
	["Fly to Gadgetzan"] = "",

	-- Step 76: Gadgetzan
	["Gadgetzan"] = "",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "關於{npc:7583}",
	["For Chillwind Camp: keep it"] = "",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro, keep it"] = "",

	-- Step 77: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299}在城鎮東邊的墓地等候；墓碑就在附近。",

	-- Step 78: Broken Pillar
	["Broken Pillar"] = "",
	-- {npc:7771} Marvon Rivetseeker
	["Ride south-west to {npc:7771}'s camp at the Broken Pillar."] = "",
	-- {quest:3444} The Stone Circle
	["{quest:3444} is in Ratchet"] = "",

	-- Step 80: Fly to Marshal's Refuge
	["Fly to Marshal's Refuge"] = "",
	["Gadgetzan flight master"] = "",

	-- Step 81: Linken
	-- {npc:8737} Linken · {npc:9117} J.D. Collie · {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["Fly from Gadgetzan to Marshal's Refuge. {npc:8737}'s hut stands at the Lakkari Tar Pits, west of the refuge; {npc:9117} is up the hill behind it.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "{npc:9997}旁邊的木牌",

	-- Step 83: Cenarion Hold
	["Cenarion Hold"] = "",
	-- {zone:1451} Silithus · {npc:15189} Beetix Ficklespragg
	["Ride out of the crater's north-western pass into {zone:1451} and on to Cenarion Hold. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 84: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "掘泥打擊者在要塞西北方的沙丘中挖掘；石鞭蠍和掠沙蜘蛛在四周遊蕩。",

	-- Step 85: Level 56.89
	["Level 56.89"] = "",
	-- {item:9328} Super Snapper FX
	["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan. Or, with a group, run the Blackrock Depths dungeon or the Blackrock Spire dungeon (Lower) instead."] = "",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "",

	-- Step 86: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["Follow the road south-west out of the pass to Cenarion Hold. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "{npc:17082}，在聯盟帳篷旁",

	-- Step 87: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "掘泥摧毀者在更西邊挖掘；石鞭巨鉗蠍、石鞭掠奪者和石行蜘蛛在同一片沙地上狩獵。",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "",

	-- Step 88: Layo Starstrike
	-- {npc:13220} Layo Starstrike
	["Ride east to {npc:13220}."] = "向東騎往{npc:13220}。",

	-- Step 89: Southwind Village
	["Southwind Village"] = "",
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "被折磨的德魯伊和被折磨的哨兵在{npc:13220}西南方的廢墟村莊出沒。",

	-- Step 91: The Hive'Ashi tower
	["The Hive'Ashi tower"] = "",
	["Ride east to the Hive'Ashi tower in Southwind Village; climb it and kill the ambushers that rise for the encrusted object."] = "",

	-- Step 92: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "{zone:1450}的阿姆伯爾：保留此任務",

	-- Step 94: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "",

	-- Step 95: Krakle
	-- {npc:10302} Krakle
	["Ride west past Marshal's Refuge and south down the western side to Golakka Hot Springs: {npc:10302} the goblin sits by the water."] = "",

	-- Step 96: Krakle's Thermometer
	-- {npc:10541} Krakle's Thermometer
	["Ride east to Fire Plume Ridge, climb it and use {npc:10541} at the lava vents near the top."] = "",

	-- Step 97: Krakle
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "在{zone:1452}的{npc:9298}處完成：保留此任務",

	-- Step 98: Northern Pylon
	["Northern Pylon"] = "北部水晶塔",

	-- Step 99: Marshal's Refuge
	["Marshal's Refuge"] = "",

	-- Step 100: The crater
	["The crater"] = "環形山",
	-- {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the Lakkari Tar Pits; the fire elementals of Fire Plume Ridge in the middle carry the ash; the Gorishi wasps of the Slithering Scar in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "",

	-- Step 102: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "沿坡道騎下環形山：{npc:9619}在坡道底部紮營。",
	["The pelts come after loop 2, on the gorilla plateau"] = "毛皮在第二輪之後，到猩猩高地取得",

	-- Step 103: Lakkari Tar Pits: kill these as you meet them
	["Lakkari Tar Pits: kill these as you meet them"] = "",
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on Ironstone Plateau, east of Marshal's Refuge. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "",

	-- Step 105: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "沿東側向北騎往猩猩高地。55級的猩猩{npc:9622}在最深的洞穴裡：先清掉洞口的猩猩。",
	["Below ground"] = "",

	-- Step 106: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "{npc:9684}的巢穴位於{npc:9619}北邊的叢林，在東面懸崖下方：在那裡使用{item:11568}。{npc:9684}是56級：滿血再開打。",

	-- Step 107: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "穿越環形山南部，前往坡道旁的{npc:9619}。",

	-- Step 108: The Marshlands: kill these as you meet them
	["The Marshlands: kill these as you meet them"] = "",

	-- Step 109: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the south-east slope of Fire Plume Ridge, in the middle of the crater."] = "",

	-- Step 110: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "護送{npc:9999}",
	-- {npc:9999} Ringo · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to Marshal's Refuge. When he faints, use {item:11804} on him to wake him."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal Watches"] = "安多哈爾懷錶",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "向北回到{area:202}：瘟疫之鍋現在會提供自己的任務。附近的食屍鬼會掉落細胞增強劑。",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "出發前才向{npc:11056}購買一個{item:13320}，用於費爾斯通的瘟疫之鍋：催化劑30分鐘後就會消失。",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "為{area:202}和達爾松的瘟疫之鍋再購買兩個{item:13320}，然後直接騎過去：它們30分鐘後就會消失。",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "爬上{area:190}西邊的山丘俯瞰城鎮。",
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "向東渡河前往{area:2261}，也就是本區西南部的地穴。{object:177667}就在裡面：它的鑰匙在遠處東北方的{npc:12248}身上，在下一份指南完成。",
	-- ["Diseased Wolves"] = "生病的狼",
	-- ["Fly to {area:392}."] = "飛往{area:392}。",
	-- ["For {zone:1451}: keep it"] = "給{zone:1451}：保留此任務",
	-- ["For {zone:1453}: keep it"] = "給{zone:1453}：保留此任務",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "從{area:392}飛往{area:2255}，再向南騎往{area:2250}。",
	-- ["From {area:702}, fly to {area:1116}."] = "從{area:702}飛往{area:1116}。",
	-- ["Gaeriyan in {area:976}: keep it"] = "{area:976}的加里楊：保留此任務",
	-- ["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "霍古斯的顱骨在{area:2624}，馬杜克的劍在{area:2623}，各自位於鬼魂交戰之處；成年的瘟疫犬在兩地之間的平原上獵食。",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "騎回{area:3197}並飛往{area:150}，搭船前往{area:442}，再飛往{area:702}；傳送門通往上方的{zone:1457}。",
	-- ["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "向西北騎往{area:2277}邊緣的{area:2276}。",
	-- ["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "向南騎往{area:201}，{npc:11078}在那裡守護著瘟疫之鍋。",
	-- ["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "向西騎往{area:2627}。瘟疫幼犬、瘟疫蝙蝠和腐肉蟲在樹林中遊蕩；在大白蟻丘裝滿{item:15042}，並擊殺更北邊的狂怒的瘟疫犬。",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "骷髏剝皮者和被奴役的食屍鬼在營地北邊的田野中遊蕩；這裡所有的天譴軍都會掉落天譴石。",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "安多哈爾各處的瓦礫堆中散落著小型保險箱；每個裡面都有一只懷錶。",
	-- ["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "搭船前往大陸，向東北騎往{area:1119}旁{npc:14637}的營地。",
	-- ["Temple of the Moon"] = "月神殿",
	-- ["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "血色醫護員、血色獵人、血色騎士和血色法師在伐木場和通往{area:190}的道路上巡邏。",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "瘟疫之鍋現在會提供自己的任務；周圍的骷髏會掉落骨質分離素。",
	-- ["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "瘟疫之鍋位於{area:202}，在{npc:10739}的農場旁。",
	-- ["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "瘟疫之鍋位於費爾斯通東北方的{area:200}；它的護鍋者就站在旁邊。",
	-- ["The fields"] = "田野",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "下一份指南從{area:392}這裡開始，然後飛往{area:976}。",
	-- ["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "被縮小的巨人在{area:1119}遊蕩；海元素沿著西邊的海岸涉水而行。",
	-- ["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "走進{area:1769}，沿著隧道的{zone:1450}岔路前往{area:2361}。",
	-- ["Zapped giants and sea elementals"] = "被縮小的巨人與海元素",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "在{zone:1422}的{area:202}擊殺{npc:1796}練等",
	-- ["{area:190} overlook"] = "{area:190}瞭望點",
	-- ["{area:199} cauldron"] = "{area:199}的瘟疫之鍋",
	-- ["{area:200} cauldron"] = "{area:200}的瘟疫之鍋",
	-- ["{area:201} cauldron"] = "{area:201}的瘟疫之鍋",
	-- ["{area:202} cauldron"] = "{area:202}的瘟疫之鍋",
	-- ["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954}在{npc:1855}西邊{area:190}的市政廳裡：血色衛兵站得很密集。",
	-- ["{item:12955} lies east of the barn at {area:201}."] = "{item:12955}在{area:201}穀倉的東邊。",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}，來自{npc:11056}",
	-- ["{npc:10300} in {zone:1452}: keep it"] = "{zone:1452}的{npc:10300}：保留此任務",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}：她的護送任務在路線稍後",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739}站在田野東北方{area:202}的農場旁。",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}的鬼魂在{area:200}西邊{area:199}的農舍旁徘徊；她的包裹就在屋裡。",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}，在禮拜堂南邊的墳墓旁",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}守護著安多哈爾西邊{area:199}的瘟疫之鍋。",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140}站在{area:2627}奧古斯圖斯的小屋旁。",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613}在{npc:11610}東邊的北山營地走動；{npc:11611}守衛著{area:190}南側通道的塔樓。",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}：白蟻稍後在{area:2627}處理",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852}是精英：建議組隊。他在安多哈爾中央守著他的護符匣。",
	-- ["{npc:5411} in {area:976}: keep it"] = "{area:976}的{npc:5411}：保留此任務",
	-- ["{npc:7740}: keep it for {area:976}"] = "{npc:7740}：保留給{area:976}",
	-- ["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "{npc:7775}的營地在{area:1119}北邊。他拿到誘餌後就會販售{item:11243}。",
	-- ["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}：保留給{zone:1446}",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}：保留給安戈洛",
	-- ["{npc:9047}, in the {area:1658}"] = "{npc:9047}，在{area:1658}",
	-- ["{object:175924}, in the farmhouse"] = "{object:175924}，在農舍裡",
	-- ["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}，在{area:2268}：保留此任務",
	-- ["{quest:6762} in {zone:1450}: keep it"] = "{zone:1450}的{quest:6762}：保留此任務",
}
