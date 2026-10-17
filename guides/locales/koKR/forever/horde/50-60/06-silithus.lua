-- Korean (koKR): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "운고로 분화구에서 오는 고갯길은 {zone:1451} 북동쪽의 묘지인 {area:3077}(으)로 이어집니다. {npc:13220}은(는) 무덤 사이에 서 있습니다.",

	-- Step 2: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "남서쪽의 {area:2738} 폐허로 가세요. {npc:11801}을(를) 위한 {object:179565}은(는) 무너진 집 중 한 곳 안에 있습니다.",

	-- Step 4: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "마파람 마을로 돌아가 탑에 오르세요. 꼭대기의 벌집을 건드리면 잠복꾼 하이브아쉬가 나옵니다. 그중 하나가 {item:17346}을(를) 지니고 있습니다.",

	-- Step 5: Cenarion Hold
	["Ride west to the walled hold in the middle of the desert."] = "서쪽으로 사막 한가운데의 성벽 두른 요새로 가세요.",

	-- Step 6: Dredge and scorpids
	["Dredge and scorpids"] = "미늘벌레와 전갈",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "작살미늘벌레, 돌꼬리전갈, 모래그물 바위거미가 요새 바로 북쪽 모래밭에 함께 있습니다.",

	-- Step 7: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "빛나는 서판 조각은 맨 북서쪽 황혼의 망치단 야영지 주변에 있습니다. 그곳의 먼지 폭풍과 우레의 모래정령도 조각을 떨어뜨립니다.",

	-- Step 9: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "남동쪽으로 운고로 절벽 아래의 {area:3447}(으)로 가세요.",

	-- Step 10: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "서쪽으로 {area:2744} 북쪽의 호드 야영지로 가세요.",

	-- Step 11: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "남부 사막 곳곳에서 실리시스트 모래기둥이 솟아오릅니다. 모래기둥이 남긴 실리시스트 속으로 걸어 들어가, 키리카의 야영지에 있는 호드의 실리시스트 추출기까지 가져가세요. 싸우거나 탈것에 오르면 떨어뜨립니다.",

	-- Step 12: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "채찍전갈과 바위거미",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "돌꼬리채찍전갈과 긴다리 바위거미는 키리카의 야영지 남서쪽 모래언덕을 돌아다닙니다.",

	-- Step 13: Twilight Vanguard
	["Twilight Vanguard"] = "황혼의 선봉대",
	-- {npc:11803} Twilight Keeper Exeter · {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803}은(는) 맨 남서쪽의 선봉대 야영지를 돌아다닙니다. 이곳의 이교도는 퀘스트와 상관없이 모두 암호화된 황혼의 문서를 떨어뜨립니다. {npc:15306}에게 열 개, 오르텔에게 열 개, 모두 스무 개를 모으세요.",

	-- Step 14: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "망치미늘벌레와 집게전갈",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "서쪽 모래언덕을 따라 북쪽으로 가세요. 망치미늘벌레와 돌꼬리집게전갈은 여기서부터 요새 쪽까지 퍼져 있습니다.",

	-- Step 15: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200}은(는) 서쪽 야영지를 차지하고 있습니다.",

	-- Step 16: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804}은(는) {area:3425} 서쪽 전초기지에 서 있습니다. 이곳 이교도에게서 암호화된 황혼의 문서를 스무 개까지 채우세요.",

	-- Step 17: Cenarion Hold
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "요새 서쪽의 {npc:15306}",

	-- Step 18: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "가방은 남쪽 끝 산속, 브론즈비어드 야영지 너머에 있습니다. 정예 전갈 죽음의 갈고리가 근처를 순찰합니다. 그가 떠나 있을 때 챙기세요.",

	-- Step 19: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "북동쪽의 {area:3447}(으)로 가세요.",
	["The spare texts from the cultists"] = "이교도에게서 얻은 남는 문서",

	-- Step 20: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "{area:3425}(으)로 돌아가기",
	-- {area:2744} Hive'Regal
	["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "마랄리스의 사랑하는 여군주 나탈리아는 58레벨이 필요하고 정예가 있는 {area:2744} 안으로 이어집니다. 건너뛰세요.",

	-- Step 21: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "북동쪽의 {area:3077}(으)로 가세요. 그 옆의 고갯길로 {zone:1451}을(를) 떠납니다.",

	-- Step 22: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:8737} Linken · {npc:9117} J.D. Collie
	["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "고갯길을 지나 북쪽 절벽을 따라 동쪽의 {area:541}(으)로 가세요. {npc:8737}은(는) 동굴 옆에 서 있고, {npc:9117}은(는) 그 안에 있습니다.",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {npc:10980} on {npc:10977}"] = "{npc:10977}에게 {npc:10980} 사용",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "{quest:3942}을(를) 보관하세요: {npc:9116}은(는) 다음 가이드에서 {zone:1448}을(를) 지나는 길의 {area:2479}에 있습니다.",

	-- Step 23: Gadgetzan
	-- {area:976} Gadgetzan · {object:142071} Egg-O-Matic
	["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "{area:976}(으)로 날아가세요. {object:142071}은(는) 마을 한가운데에 있습니다.",

	-- Step 24: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637} and train."] = "{area:1637}(으)로 날아가 기술을 배우세요.",

	-- Step 25: The Undercity
	-- {area:1637} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {object:36126} Royal Quarter
	["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "{area:1637} 밖의 탑에서 {zone:1420}행 비행선을 타고 {zone:1458}(으)로 들어가세요. 실바나스는 {object:36126}에 있습니다.",

	-- Step 26: The Bulwark
	-- {area:152} The Bulwark
	["Ride east along the road to the {area:152} on the border."] = "길을 따라 동쪽으로 경계의 {area:152}로 가세요.",

	-- Step 27: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "{npc:10778}의 농장은 {area:152} 동쪽으로 첫 번째 농장입니다. 농장의 비명소리 구울이 그녀의 부적 나머지 반쪽을 지니고 있고, {npc:11075}은(는) 들판의 가마솥을 지키고 있습니다.",

	-- Step 28: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "안돌할 감시탑과 저장고",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "남쪽의 안돌할로 가세요. {npc:10667}은(는) 마을 서쪽의 무너진 여관에서 기다립니다. {item:12815}을(를) 들고 탑 네 개의 출입구에 각각 서서 표시하세요. 마을 가장자리로만 다니세요. 마을 한가운데의 저장고 옆에서 {item:12627}을(를) 사용하면 시간의 기생충이 나옵니다.",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "{item:12815}(으)로 {npc:10904} 표시",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "{item:12815}(으)로 {npc:10903} 표시",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "{item:12815}(으)로 {npc:10902} 표시",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "{item:12815}(으)로 {npc:10905} 표시",

	-- Step 29: The Bulwark
	-- {item:14619} Skeletal Fragments · {quest:838} Scholomance
	["Dithers offers {item:14619} ({quest:838}). Skip it."] = "디더스가 {item:14619}({quest:838})을(를) 줍니다. 건너뛰세요.",

	-- Step 30: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "길을 따라 동쪽으로 가면 {npc:11077}이(가) {area:200}의 가마솥을 지키고 있습니다.",

	-- Step 31: Northridge Lumber Camp
	["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "북쪽의 벌목지로 가서 흰개미 통을 제재소 한가운데에 내려놓으세요.",

	-- Step 32: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "성서는 더 북쪽, {area:190}(으)로 가는 길에 있습니다.",

	-- Step 33: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "동쪽으로 {area:2619} 옆 {npc:1855}의 오두막으로 가서 그의 이야기를 들으세요.",

	-- Step 34: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "방패는 {npc:1855}의 오두막 남쪽 {area:201}에 있습니다.",

	-- Step 35: Light's Hope Chapel
	["Ride east across the plaguelands to the chapel."] = "동쪽으로 역병지대를 가로질러 예배당으로 가세요.",

	-- Step 36: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "스컬지 용사",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "스컬지 용사는 예배당 북쪽 {area:2270}을(를) 돌아다닙니다. 처치한 용사마다 {npc:11063}의 {item:13156}을(를) 대 보세요. 공명하는 해골이 그가 원하는 것입니다.",

	-- Step 38: Pamela Redpath and the Undercroft
	-- {npc:10926} Pamela Redpath · {area:2261} Undercroft
	["{npc:10926} and the {area:2261}"] = "{npc:10926}와(과) {area:2261}",
	-- {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "남서쪽의 {area:2262}(으)로 가세요. {npc:10926}은(는) 집들 사이에서 놀고 있습니다. {npc:11886}은(는) 마을 바로 서쪽의 납골당인 {area:2261}에 숨어 있습니다.",
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s own errand is not on this route. Skip it."] = "{npc:10926}의 심부름은 이 경로에 없습니다. 건너뛰세요.",

	-- Step 39: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "{npc:15193}의 용사가 {area:2261} 북쪽의 {area:2260} 농가를 차지하고 있습니다.",
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}' errands are not on this route. Skip them."] = "{npc:11878}의 심부름은 이 경로에 없습니다. 건너뛰세요.",

	-- Step 40: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "북서쪽의 {npc:1855} 오두막으로 가세요.",
	-- {npc:1855} Tirion Fordring
	["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "{npc:1855}의 다음 임무인 명예의 상징은 이 경로에 없습니다. 건너뛰세요.",

	-- Step 41: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "남서쪽 안돌할의 {npc:10667}에게 가세요.",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "{npc:10667}의 다로우샤이어 전투는 정예와 싸우며 끝납니다. 건너뛰세요.",

	-- Step 42: The Bulwark
	-- {area:152} The Bulwark · {zone:1458} Undercity
	["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "서쪽의 {area:152}로 가세요. 다음 가이드는 조금 서쪽의 {zone:1458}에서 시작합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride east along the road to the {area:152} on the border."] = "길을 따라 동쪽으로 경계의 {area:152}(으)로 가세요.",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "서쪽의 {area:152}(으)로 가세요. 다음 가이드는 조금 서쪽의 {zone:1458}에서 시작합니다.",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "{npc:10778}의 농장은 {area:152} 동쪽으로 첫 번째 농장입니다. 농장의 비명소리 구울이 그녀의 부적 나머지 반쪽을 지니고 있고, {npc:11075}은(는) 들판의 가마솥을 지키고 있습니다.",
}
