-- Korean (koKR): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Light's Hope Chapel
	-- {npc:16256} Jessica Chambers
	["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",

	-- Step 2: Chillwind Camp
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: 흰개미는 나중에 {area:2627}에서 모읍니다",

	-- Step 3: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "{npc:10927}의 농가는 야영지 동쪽 언덕 위에 있고, {npc:10936}의 기념비는 바로 그 북쪽에 있습니다.",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "기념비의 {item:12894}",

	-- Step 4: The fields
	["The fields"] = "들판",
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "해골 타작꾼과 걸신들린 구울이 야영지 북쪽 들판을 배회합니다. 이곳의 스컬지는 모두 스컬지석을 떨어뜨립니다.",

	-- Step 5: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739}은(는) 들판 북동쪽, {area:202}의 농장 옆에 있습니다.",

	-- Step 6: Diseased Wolves
	["Diseased Wolves"] = "역병에 걸린 늑대",

	-- Step 8: Diseased Grizzlies
	["Diseased Grizzlies"] = "오염된 불곰",

	-- Step 9: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "{zone:1457}의 드루이드용: 보관하세요",

	-- Step 10: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "북서쪽 달슨 농장으로 가세요. 일기는 헛간에 있고, 떠도는 해골이 옥외 화장실 열쇠를 가지고 있으며, {npc:10836}은(는) 옥외 화장실에서 진열장 열쇠를 가지고 기다립니다.",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse"] = "농가 안의 {object:175924}",

	-- Step 11: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}의 유령은 {area:200} 서쪽, {area:199}의 농가 근처를 떠돕니다. 소포는 농가 안에 있습니다.",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "{zone:1453}용: 보관하세요",

	-- Step 12: Chillwind Camp
	["Ride back south to the camp."] = "남쪽 야영지로 돌아가세요.",

	-- Step 13: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "안돌할 감시탑",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "야영지 북쪽, 안돌할 가장자리에 있는 네 감시탑 아래에서 각각 {item:12815}을(를) 사용하세요.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "{item:12815}(으)로 {npc:10902} 표시",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "{item:12815}(으)로 {npc:10903} 표시",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "{item:12815}(으)로 {npc:10904} 표시",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "{item:12815}(으)로 {npc:10905} 표시",

	-- Step 14: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "{area:199} 가마솥",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}이(가) 안돌할 서쪽 {area:199}의 가마솥을 지킵니다.",

	-- Step 15: Chillwind Camp
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "출발 직전에 펠스톤 가마솥에 쓸 {item:13320} 하나를 {npc:11056}에게서 구입하세요. 촉매제는 30분 후에 사라집니다.",
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["{item:13320}, from {npc:11056}"] = "{npc:11056}에게서 {item:13320}",

	-- Step 16: Felstone Field cauldron
	-- plural, as words: Osseous Agitators = {item:13357} Osseous Agitator
	["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "이제 가마솥이 직접 퀘스트를 줍니다. 주변 해골들이 골성 교반기를 떨어뜨립니다.",

	-- Step 17: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "{area:200} 가마솥",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "가마솥은 펠스톤 북동쪽 {area:200}에 있고, 가마솥군주가 그 옆에 서 있습니다.",

	-- Step 19: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "{area:202} 가마솥",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "가마솥은 {npc:10739}의 농장 옆 {area:202}에 있습니다.",
	-- {npc:1796} Freezing Ghoul · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands
	["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "{zone:1422} {area:202}에서 {npc:1796} 사냥",

	-- Step 20: Chillwind Camp
	-- {area:202} Writhing Haunt
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "{area:202} 가마솥과 달슨 가마솥에 쓸 비전 촉매제를 두 개 더 구입하고 곧장 가세요. 촉매제는 30분 후에 사라집니다.",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852}은(는) 61레벨 정예입니다",

	-- Step 21: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	-- plural, as words: Somatic Intensifiers = {item:13356} Somatic Intensifier
	["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "북쪽 {area:202}(으)로 돌아가세요. 이제 가마솥이 직접 퀘스트를 줍니다. 근처 구울들이 체세포 강화물질을 떨어뜨립니다.",

	-- Step 23: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667}은(는) 안돌할 서쪽의 무너진 여관에서 기다립니다.",

	-- Step 24: Andorhal
	["Andorhal"] = "안돌할",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "곡물 저장고 옆에서 {item:12627}을(를) 사용해 시간의 기생충을 끌어내세요. {quest:5154}은(는) 시청에 있는 낡은 책 중 하나입니다. 마을의 모든 해골이 {quest:5537}을(를) 떨어뜨립니다.",

	-- Step 25: Araj's Phylactery
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852}은(는) 정예이므로 파티를 권장합니다. 안돌할 중앙에서 성물함을 지킵니다.",

	-- Step 26: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{area:2268}의 {quest:5210}: 보관하세요",

	-- Step 27: Andorhal Watches
	["Andorhal Watches"] = "안돌할 시계",
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "안돌할 곳곳의 잔해 속에 작은 금고가 있고, 각각 시계가 하나씩 들어 있습니다.",

	-- Step 29: More watches
	["More watches"] = "추가 시계",

	-- Step 31: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "북쪽 길을 따라 북마루 벌목지로 가세요. {npc:11610}은(는) 벌목지 가장자리에 숨어 있습니다.",

	-- Step 32: The Scarlet Crusade
	["The Scarlet Crusade"] = "붉은십자군",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "붉은십자군 의무병, 붉은십자군 사냥꾼, 붉은십자군 기사, 붉은십자군 마법사가 벌목지와 {area:190}(으)로 가는 길을 순찰합니다.",

	-- Step 34: Radley and Durgen
	["Radley and Durgen"] = "래들리와 드루겐",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613}은(는) {npc:11610} 동쪽의 북마루 벌목지를 돌아다니고, {npc:11611}은(는) {area:190} 남쪽 진입로의 탑을 지킵니다.",

	-- Step 36: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "{area:190} 전망 지점",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town."] = "{area:190} 서쪽 언덕에 올라 마을을 내려다보세요.",

	-- Step 38: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "동쪽 경계의 강으로 가세요. {npc:1855}은(는) 강둑의 작은 오두막에 삽니다.",

	-- Step 39: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "{area:201} 가마솥",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "남쪽 {area:201}(으)로 가세요. {npc:11078}이(가) 가마솥을 지킵니다.",

	-- Step 40: Chillwind Camp
	["Ride south-west to the camp."] = "남서쪽 야영지로 가세요.",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{area:976}의 {npc:5411}: 보관하세요",

	-- Step 41: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen
	["{npc:11038}, by the graves south of the chapel"] = "예배당 남쪽 무덤 옆의 {npc:11038}",

	-- Step 42: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "호르구스의 해골은 {area:2624}에, 마르두크의 검은 {area:2623}에 있으며, 둘 다 유령들이 싸우는 곳입니다. 다 자란 역병사냥개가 그 사이 평원을 사냥합니다.",

	-- Step 44: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "북서쪽 {area:2277} 가장자리의 {area:2276}(으)로 가세요.",

	-- Step 45: Terrordale
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "서쪽으로 {area:2627}까지 가세요. 숲에는 {npc:8596}, {npc:8600}, {npc:8603}이(가) 돌아다닙니다. 큰 흰개미 둔덕에서 {item:15042}을(를) 채우고, 더 북쪽에서 {npc:8598}을(를) 처치하세요.",

	-- Step 46: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140}은(는) {area:2627}의 아우구스투스 오두막 옆에 있습니다.",

	-- Step 47: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "강을 건너 서쪽 {npc:1855}의 오두막으로 가세요.",
	["Listen to his story"] = "그의 이야기를 들으세요",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886}은(는) 정예이므로 파티를 권장합니다",

	-- Step 48: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954}은(는) {npc:1855} 서쪽 {area:190}의 시청에 있습니다. 붉은십자군 경비병들이 가까이 붙어 서 있습니다.",

	-- Step 49: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955}은(는) {area:201}의 헛간 동쪽에 있습니다.",

	-- Step 50: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "강을 건너 동쪽, 지역 남서쪽의 지하 묘지인 {area:2261}으로 가세요. {object:177667}은(는) 그 안에 있습니다. 열쇠는 북동쪽 끝의 {npc:12248}이(가) 가지고 있으며, 다음 가이드에서 처리합니다.",

	-- Step 51: Darnassus
	-- {area:3197} Chillwind Camp · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "{area:3197}(으)로 돌아가 {area:150}(으)로 날아간 다음, 배를 타고 {area:442}(으)로 가서 {area:702}(으)로 날아가세요. 차원문을 타면 {zone:1457}(으)로 올라갑니다.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{area:1658}의 {npc:9047}",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "{item:11020}에서 {item:11040} 10개",
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "다음 가이드에서 훈련하는 {zone:1455}에는 드루이드 상급자가 없습니다",

	-- Step 52: Temple of the Moon
	["Temple of the Moon"] = "달의 신전",
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878}와(과) {npc:7740}은(는) 달의 신전 옆에 있습니다. 안쪽 달샘에서 {item:11682}을(를) 채우세요.",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: {area:976}용으로 보관하세요",

	-- Step 53: Cenarion Enclave
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{zone:1450}의 {quest:6762}: 보관하세요",

	-- Step 54: Rut'theran Village
	-- {npc:10300} Ranshalla · {zone:1452} Winterspring
	["{npc:10300} in {zone:1452}: keep it"] = "{zone:1452}의 {npc:10300}: 보관하세요",

	-- Step 55: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "{area:702}에서 {area:1116}(으)로 날아가세요.",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: {zone:1446}용으로 보관하세요",

	-- Step 56: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "배를 타고 본토로 건너가 북동쪽 {area:1119} 옆에 있는 {npc:14637}의 야영지로 가세요.",

	-- Step 57: Zapped giants and sea elementals
	["Zapped giants and sea elementals"] = "축소된 거인과 바다 정령",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "축소된 거인들은 {area:1119}을(를) 돌아다니고, 바다 정령들은 서쪽 해안을 따라 물속을 걷습니다.",

	-- Step 59: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "{npc:7775}의 야영지는 {area:1119} 북쪽에 있습니다. 미끼를 받으면 {item:11243}을(를) 팝니다.",

	-- Step 60: Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}."] = "{area:392}(으)로 날아가세요.",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: 운고로용으로 보관하세요",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "마을 북쪽 해안의 {npc:5901}",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "{zone:1448}용: 보관하세요",

	-- Step 61: Ranshalla
	-- {area:392} Ratchet · {area:2255} Everlook · {area:2250} Owl Wing Thicket
	["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "{area:392}에서 {area:2255}(으)로 날아간 뒤 남쪽 {area:2250}(으)로 가세요.",
	-- {npc:10300} Ranshalla
	["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: 호위 퀘스트는 경로 후반에 합니다",

	-- Step 62: Donova Snowden
	["Ride west along the road to the hot springs."] = "길을 따라 서쪽 온천으로 가세요.",
	-- {area:976} Gadgetzan
	["Gaeriyan in {area:976}: keep it"] = "{area:976}의 개리얀: 보관하세요",

	-- Step 63: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "{area:1769}에 들어가 터널의 {zone:1450} 갈림길을 따라 {area:2361}(으)로 가세요.",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "{zone:1451}용: 보관하세요",

	-- Step 64: Ratchet
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["The next guide starts here in {area:392} and flies on to {area:976}."] = "다음 가이드는 여기 {area:392}에서 시작해 {area:976}(으)로 날아갑니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "강을 건너 동쪽, 지역 남서쪽의 지하 묘지인 {area:2261}(으)로 가세요. {object:177667}은(는) 그 안에 있습니다. 열쇠는 북동쪽 끝의 {npc:12248}이(가) 가지고 있으며, 다음 가이드에서 처리합니다.",
}
