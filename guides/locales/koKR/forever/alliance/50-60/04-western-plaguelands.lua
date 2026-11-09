-- Korean (koKR): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Argent Officer Pureheart
	-- {quest:5401} Argent Dawn Commission · {spell:437801} Light's Hope · {zone:1452} Winterspring
	["No {quest:5401} yet ({spell:437801} gives it on the {zone:1452} guide's way through)? Pureheart gives you one here: the scourgestone quests need it."] = "",

	-- Step 4: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 5: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "{npc:10927}의 농가는 야영지 동쪽 언덕 위에 있고, {npc:10936}의 기념비는 바로 그 북쪽에 있습니다.",
	["Upstairs"] = "",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "기념비의 {item:12894}",

	-- Step 6: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "북서쪽 달슨 농장으로 가세요. 일기는 헛간에 있고, 떠도는 해골이 옥외 화장실 열쇠를 가지고 있으며, {npc:10836}은(는) 옥외 화장실에서 진열장 열쇠를 가지고 기다립니다.",
	-- {quest:5058} Mrs. Dalson's Diary
	["{quest:5058}, inside"] = "",
	["Inside"] = "",

	-- Step 7: The Writhing Haunt: kill these as you meet them
	-- {area:202} The Writhing Haunt
	["{area:202}: kill these as you meet them"] = "",

	-- Step 8: Dalson's Tears
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "",

	-- Step 9: Chillwind Camp
	["Ride back south to the camp."] = "남쪽 야영지로 돌아가세요.",

	-- Step 10: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "안돌할 감시탑",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "야영지 북쪽, 안돌할 가장자리에 있는 네 감시탑 아래에서 각각 {item:12815}을(를) 사용하세요.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "{item:12815}(으)로 {npc:10902} 표시",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "{item:12815}(으)로 {npc:10903} 표시",

	-- Step 11: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667}은(는) 안돌할 서쪽의 무너진 여관에서 기다립니다.",

	-- Step 12: The Andorhal watchtowers
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "{item:12815}(으)로 {npc:10904} 표시",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "{item:12815}(으)로 {npc:10905} 표시",

	-- Step 13: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852}은(는) 61레벨 정예입니다",

	-- Step 14: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "{area:200} 가마솥",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "가마솥은 펠스톤 북동쪽 {area:200}에 있고, 가마솥군주가 그 옆에 서 있습니다.",

	-- Step 15: Andorhal
	["Andorhal"] = "안돌할",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "곡물 저장고 옆에서 {item:12627}을(를) 사용해 시간의 기생충을 끌어내세요. {quest:5154}은(는) 시청에 있는 낡은 책 중 하나입니다. 마을의 모든 해골이 {quest:5537}을(를) 떨어뜨립니다.",

	-- Step 17: The Writhing Haunt cauldron
	-- {area:202} The Writhing Haunt
	["{area:202} cauldron"] = "{area:202} 가마솥",
	-- {area:202} The Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "가마솥은 {npc:10739}의 농장 옆 {area:202}에 있습니다.",

	-- Step 19: Diseased Grizzlies
	["Diseased Grizzlies"] = "오염된 불곰",

	-- Step 20: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "{zone:1457}의 드루이드용: 보관하세요",

	-- Step 22: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{area:2268}의 {quest:5210}: 보관하세요",

	-- Step 23: Sorrow Hill: kill these as you meet them
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 25: More watches
	["More watches"] = "추가 시계",

	-- Step 27: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "북쪽 길을 따라 북마루 벌목지로 가세요. {npc:11610}은(는) 벌목지 가장자리에 숨어 있습니다.",

	-- Step 28: The Scarlet Crusade
	["The Scarlet Crusade"] = "붉은십자군",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "붉은십자군 의무병, 붉은십자군 사냥꾼, 붉은십자군 기사, 붉은십자군 마법사가 벌목지와 {area:190}(으)로 가는 길을 순찰합니다.",

	-- Step 30: Radley and Durgen
	["Radley and Durgen"] = "래들리와 드루겐",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 32: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "{area:190} 전망 지점",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 34: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "동쪽 경계의 강으로 가세요. {npc:1855}은(는) 강둑의 작은 오두막에 삽니다.",

	-- Step 35: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "{area:201} 가마솥",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "남쪽 {area:201}(으)로 가세요. {npc:11078}이(가) 가마솥을 지킵니다.",

	-- Step 36: Chillwind Camp
	["Ride south-west to the camp."] = "남서쪽 야영지로 가세요.",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{area:976}의 {npc:5411}: 보관하세요",

	-- Step 37: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "{area:2268}(으)로 날아가기",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "",

	-- Step 39: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "북서쪽 {area:2277} 가장자리의 {area:2276}(으)로 가세요.",

	-- Step 40: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "호르구스의 해골은 {area:2624}에, 마르두크의 검은 {area:2623}에 있으며, 둘 다 유령들이 싸우는 곳입니다. 다 자란 역병사냥개가 그 사이 평원을 사냥합니다.",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "",

	-- Step 41: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "서쪽으로 {area:2627}까지 가세요. 숲에는 {npc:8596}, {npc:8600}, {npc:8603}이(가) 돌아다닙니다. 큰 흰개미 둔덕에서 {item:15042}을(를) 채우고, 더 북쪽에서 {npc:8598}을(를) 처치하세요.",

	-- Step 42: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "북쪽으로 {area:2627}까지 가세요. {npc:12384}은(는) 무너진 오두막에 살고, 그의 영수증 장부는 근처의 무너진 여관에 있습니다.",

	-- Step 43: Augustus the Touched
	-- {npc:8598} Frenzied Plaguehound
	["{npc:8598}, 170 yd north-east"] = "",

	-- Step 44: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "",

	-- Step 45: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "강을 건너 서쪽 {npc:1855}의 오두막으로 가세요.",

	-- Step 47: Tirion Fordring
	["Listen to his story"] = "그의 이야기를 들으세요",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886}은(는) 정예이므로 파티를 권장합니다",

	-- Step 48: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954}은(는) {npc:1855} 서쪽 {area:190}의 시청에 있습니다. 붉은십자군 경비병들이 가까이 붙어 서 있습니다.",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "",

	-- Step 49: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955}은(는) {area:201}의 헛간 동쪽에 있습니다.",

	-- Step 51: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "강을 건너 동쪽, 지역 남서쪽의 지하 묘지인 {area:2261}으로 가세요. {object:177667}은(는) 그 안에 있습니다. 열쇠는 북동쪽 끝의 {npc:12248}이(가) 가지고 있으며, 다음 가이드에서 처리합니다.",
	-- {object:177667} Torn Scroll
	["{object:177667}, below ground"] = "",

	-- Step 53: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "{area:271}(으)로 날아가세요",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "",

	-- Step 55: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 56: Rut'theran Village
	-- {zone:1452} Winterspring
	["Ranshalla in {zone:1452}: keep it"] = "{zone:1452}의 란샬라: 보관하세요",

	-- Step 58: The Temple Gardens
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878}와(과) {npc:7740}은(는) 달의 신전 옆에 있습니다. 안쪽 달샘에서 {item:11682}을(를) 채우세요.",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: {area:976}용으로 보관하세요",

	-- Step 59: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus
	["The portal in {area:702} leads up to {zone:1457}."] = "",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{area:1658}의 {npc:9047}",

	-- Step 63: Darnassus
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "다음 가이드에서 훈련하는 {zone:1455}에는 드루이드 상급자가 없습니다",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "{item:11020}에서 {item:11040} 10개",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{zone:1450}의 {quest:6762}: 보관하세요",

	-- Step 64: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "",

	-- Step 65: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "",

	-- Step 66: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "{area:702}에서 {area:1116}(으)로 날아가세요.",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: {zone:1446}용으로 보관하세요",

	-- Step 68: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "",

	-- Step 69: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "배를 타고 본토로 건너가 북동쪽 {area:1119} 옆에 있는 {npc:14637}의 야영지로 가세요.",

	-- Step 70: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "축소된 거인들은 {area:1119}을(를) 돌아다니고, 바다 정령들은 서쪽 해안을 따라 물속을 걷습니다.",

	-- Step 72: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "{npc:7775}의 야영지는 {area:1119} 북쪽에 있습니다. 미끼를 받으면 {item:11243}을(를) 팝니다.",

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
	["Fly to Theramore"] = "테라모어 섬으로 비행",
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "",

	-- Step 79: Ratchet
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "마을 북쪽 해안의 {npc:5901}",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "{zone:1448}용: 보관하세요",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro; inside"] = "",

	-- Step 80: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 82: Donova Snowden
	["Ride west along the road to the hot springs."] = "길을 따라 서쪽 온천으로 가세요.",
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} in {area:976}: keep it"] = "{area:976}의 {npc:9299}: 보관하세요",

	-- Step 84: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "{area:1769}에 들어가 터널의 {zone:1450} 갈림길을 따라 {area:2361}(으)로 가세요.",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "{zone:1451}용: 보관하세요",

	-- Step 85: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "{area:976}(으)로 날아가기",

	-- Step 86: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "{npc:7583}에게",
	-- {area:3197} Chillwind Camp
	["For {area:3197}: keep it"] = "{area:3197}에 쓸 것: 보관하세요",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro, keep it"] = "",

	-- Step 87: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299}은(는) 마을 바로 동쪽 묘지에서 기다리며, 묘비는 그 근처에 서 있습니다.",

	-- Step 88: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "남서쪽으로 {area:1938}의 {npc:7771} 야영지로 가세요.",
	-- {quest:3444} The Stone Circle · {area:392} Ratchet
	["{quest:3444} is in {area:392}"] = "{quest:3444}은(는) {area:392}에 있습니다",

	-- Step 90: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 91: Linken
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:8737} Linken · {area:538} Lakkari Tar Pits · {npc:9117} J.D. Collie · {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "{npc:9997} 옆의 나무 표지판",

	-- Step 92: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "{zone:1451}(으)로",

	-- Step 93: Layo Starstrike
	-- {zone:1451} Silithus · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["Ride out of the crater's north-western pass into {zone:1451}: {npc:13220} stands at {area:3077}, where the pass comes out."] = "",

	-- Step 95: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "{npc:17082}, 얼라이언스 천막",

	-- Step 96: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "{npc:11740}은(는) 요새 북서쪽 모래언덕을 파고, {npc:11735}와(과) {npc:11738}은(는) 사방을 돌아다닙니다.",

	-- Step 97: Level 56.89
	["Level 56.89"] = "",
	-- {item:9328} Super Snapper FX · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "",

	-- Step 98: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 99: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "{npc:11741}은(는) 더 서쪽을 파고, {npc:11736}, 돌꼬리채찍전갈, {npc:11739}이(가) 같은 모래밭에서 사냥합니다.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "",

	-- Step 100: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "고통받는 드루이드와 고통받는 파수꾼이 {npc:13220} 남서쪽의 폐허가 된 마을을 떠돕니다.",

	-- Step 102: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "{area:2742} 탑",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "동쪽으로 {area:2738}의 {area:2742} 탑으로 가세요. 탑에 올라 딱딱한 실리시드 조각을 노리고 나타나는 잠복꾼을 처치하세요.",

	-- Step 103: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "{zone:1450}의 움버: 보관하세요",

	-- Step 105: Krakle
	-- {zone:1451} Silithus · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Coming in from {zone:1451}, {area:543} is just inside the crater: {npc:10302} the goblin sits by the water."] = "",

	-- Step 106: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "",

	-- Step 107: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "동쪽으로 {area:537}까지 가서 올라간 뒤, 꼭대기 근처 용암 분출구에서 {npc:10541}을(를) 사용하세요.",

	-- Step 108: Krakle
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "{zone:1452}의 {npc:9298}에게서 끝납니다: 보관하세요",

	-- Step 109: Northern Pylon
	["Northern Pylon"] = "북쪽 수정탑",

	-- Step 111: The crater
	["The crater"] = "분화구",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "",

	-- Step 112: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "",

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
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "동쪽을 따라 북쪽의 고릴라 고원으로 가세요. 55레벨 고릴라 {npc:9622}은(는) 가장 깊은 동굴에 있습니다. 먼저 동굴 입구의 고릴라를 정리하세요.",
	["Below ground"] = "",

	-- Step 116: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "{npc:9684}의 굴은 {npc:9619} 북쪽, 동쪽 절벽 아래 밀림에 있습니다. 그곳에서 {item:11568}을(를) 사용하세요. {npc:9684}은(는) 56레벨이니 생명력이 가득한 상태로 시작하세요.",

	-- Step 117: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "분화구 남쪽을 가로질러 비탈 옆의 {npc:9619}에게 가세요.",

	-- Step 118: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "",

	-- Step 119: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}은(는) 분화구 한가운데 {area:537}의 남동쪽 비탈에 앉아 있습니다.",

	-- Step 120: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "{npc:9999} 호위",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal Watches"] = "안돌할 시계",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "북쪽 {area:202}(으)로 돌아가세요. 이제 가마솥이 직접 퀘스트를 줍니다. 근처 구울들이 체세포 강화물질을 떨어뜨립니다.",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "출발 직전에 펠스톤 가마솥에 쓸 {item:13320} 하나를 {npc:11056}에게서 구입하세요. 촉매제는 30분 후에 사라집니다.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "{area:202} 가마솥과 달슨 가마솥에 쓸 비전 촉매제를 두 개 더 구입하고 곧장 가세요. 촉매제는 30분 후에 사라집니다.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "{area:190} 서쪽 언덕에 올라 마을을 내려다보세요.",
	-- ["Diseased Wolves"] = "역병에 걸린 늑대",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "{area:618}의 {npc:9298}에게서 끝납니다: 보관하세요",
	-- ["Fly to {area:392}."] = "{area:392}(으)로 날아가세요.",
	-- ["For {area:1377}: keep it"] = "{area:1377}용: 보관하세요",
	-- ["For {zone:1453}: keep it"] = "{zone:1453}용: 보관하세요",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "{area:392}에서 {area:2255}(으)로 날아간 뒤 남쪽 {area:2250}(으)로 가세요.",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "{area:3197}(으)로 돌아가 {area:150}(으)로 날아간 다음, 배를 타고 {area:442}(으)로 가서 {area:702}(으)로 날아가세요. 차원문을 타면 {zone:1457}(으)로 올라갑니다.",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "비탈을 내려가 분화구로 가세요. {npc:9619}은(는) 비탈 아래에 진을 치고 있습니다.",
	-- ["Ride east to {npc:13220}."] = "동쪽으로 {npc:13220}에게 가세요.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "서쪽으로 {area:541}을(를) 지나 서쪽을 따라 남쪽의 {area:543}까지 가세요. 고블린 {npc:10302}이(가) 물가에 앉아 있습니다.",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "해골 타작꾼과 걸신들린 구울이 야영지 북쪽 들판을 배회합니다. 이곳의 스컬지는 모두 스컬지석을 떨어뜨립니다.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "안돌할 곳곳의 잔해 속에 작은 금고가 있고, 각각 시계가 하나씩 들어 있습니다.",
	-- ["Temple of the Moon"] = "달의 신전",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "이제 가마솥이 직접 퀘스트를 줍니다. 주변 해골들이 골성 교반기를 떨어뜨립니다.",
	-- ["The fields"] = "들판",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "다음 가이드는 여기 {area:392}에서 시작해 {area:976}(으)로 날아갑니다.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "가죽은 두 번째 순환 이후, 고릴라 고원에서 모읍니다",
	-- ["Umber in {area:493}: keep it"] = "{area:493}의 움버: 보관하세요",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "{area:1769}에 들어가 터널의 {area:493} 갈림길을 따라 {area:2361}(으)로 가세요.",
	-- ["Zapped giants and sea elementals"] = "축소된 거인과 바다 정령",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "{zone:1422} {area:202}에서 {npc:1796} 사냥",
	-- ["{area:199} cauldron"] = "{area:199} 가마솥",
	-- ["{item:13320}, from {npc:11056}"] = "{npc:11056}에게서 {item:13320}",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: 호위 퀘스트는 경로 후반에 합니다",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739}은(는) 들판 북동쪽, {area:202}의 농장 옆에 있습니다.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}의 유령은 {area:200} 서쪽, {area:199}의 농가 근처를 떠돕니다. 소포는 농가 안에 있습니다.",
	-- ["{npc:11038}, by the graves south of the chapel"] = "예배당 남쪽 무덤 옆의 {npc:11038}",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}이(가) 안돌할 서쪽 {area:199}의 가마솥을 지킵니다.",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140}은(는) {area:2627}의 아우구스투스 오두막 옆에 있습니다.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613}은(는) {npc:11610} 동쪽의 북마루 벌목지를 돌아다니고, {npc:11611}은(는) {area:190} 남쪽 진입로의 탑을 지킵니다.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: 흰개미는 나중에 {area:2627}에서 모읍니다",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852}은(는) 정예이므로 파티를 권장합니다. 안돌할 중앙에서 성물함을 지킵니다.",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900}: {area:440}용으로 보관하세요",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: 운고로용으로 보관하세요",
	-- ["{object:175924}, in the farmhouse"] = "농가 안의 {object:175924}",
	-- ["{quest:6762} in {area:493}: keep it"] = "{area:493}의 {quest:6762}: 보관하세요",
}
