-- Korean (koKR): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. This first visit keeps to the crater's eastern half, where the beasts are 48-52, so pull them one at a time; the pylons, the bones and the hive wait for the later Un'Goro visit at about 56."] = "49~50레벨 캐릭터용이지만, 여기 퀘스트 대부분은 51-53레벨입니다. 경험치를 위해 일부러 넣었습니다. 이번 첫 방문은 야수가 48-52레벨인 분화구 동쪽 절반만 다니니 하나씩 끌어오세요. 수정탑, 뼈, 벌집은 약 56레벨의 나중 운고로 방문 때 합니다.",

	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "{area:150}(으)로 비행",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455} 비행 조련사",

	-- Step 3: Theramore
	["Theramore"] = "",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616}은(는) 배가 도착하는 부두에 있습니다.",

	-- Step 4: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "{area:976}(으)로 날아가기",
	["Theramore flight master"] = "테라모어 섬 비행 조련사",

	-- Step 5: Gadgetzan
	-- {area:976} Gadgetzan
	["The flight from Theramore lands in {area:976}."] = "",

	-- Step 6: Marin Noggenfogger
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "경로의 이전 방문 때 이것을 놓쳤습니다. 지금 이것부터 합니다. 금방 끝나며 뒤에 이어지는 퀘스트를 열어 줍니다.",

	-- Step 8: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "서쪽 모래언덕의 센티파르 벌집으로 가세요. 센티파르는 모두 곤충 부위를 떨어뜨릴 수 있습니다.\n주의: 우두머리 센티파르는 전투 중이든 아니든 {npc:4196}을(를) 시전해 작은 몹을 불러내며, 이들이 행동을 방해합니다.",

	-- Step 9: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "남쪽 오우거 주둔지로 가세요. 야수와 집행자(46-48)로 가득하고, {npc:12046}(49)이(가) 한가운데에 경비병에 둘러싸여 서 있습니다. 경비병부터 처리하세요.",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "",

	-- Step 10: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride west into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley.\nCareful: the thistleshrubs wander a lot, so you can easily pull extra mobs."] = "서쪽 {quest:3362}(으)로 가세요. 이슬 수집가가 분비샘을 떨어뜨리는데, 가득 찬 것은 일부뿐이니 가득 찬 것을 챙기세요. 옹이진 덤불나무괴물과 뿌리조각가도 골짜기에 있습니다.\n주의: 덤불나무괴물은 많이 돌아다니므로 몹을 더 끌기 쉽습니다.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back north-east to {area:976}: {npc:11758} stands on the east side of town."] = "북동쪽 {area:976}(으)로 돌아가세요. {npc:11758}은(는) 마을 동쪽에 서 있습니다.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 12: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "남쪽으로 {area:1938}을(를) 지나 하잘리 굴인 {area:981}으로 가십시오. 슈섕크의 측량 장비는 깊숙한 곳에 있습니다.\n주의: 벌레 하나가 장비를 지킵니다. 많은 벌레가 굴을 순찰하며 일부는 50레벨이라, 싸우면 몹이 추가로 끌려오는 경우가 많습니다.",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "",

	-- Step 13: Gadgetzan
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus · {zone:1428} Burning Steppes
	["For {npc:7740} in {zone:1457}, at the end of the {zone:1428} guide: keep it"] = "{zone:1428} 가이드 마지막에 {zone:1457}의 {npc:7740}에게: 간직하세요",

	-- Step 15: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "{area:976}에서 서쪽으로 나가 {zone:1449}(으)로 내려가는 긴 비탈로 가세요. {npc:9619}은(는) 분화구 남동쪽 구석, 비탈 아래에 진을 치고 있습니다.",

	-- Step 16: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder · {item:280459} Crystal Infused Scale
	-- plural, as words: Venomhide Ravasaurs = {npc:6508} Venomhide Ravasaur
	["The dead Threshadon lies by the water north of {npc:9619}.\nCareful: Venomhide Ravasaurs (50-51) hunt along the water there: pull them one at a time before you loot the carcass.\nAny ravasaur may drop a {item:280459}: right-click it, {npc:9619} takes it."] = "죽은 쓰레샤돈은 {npc:9619} 북쪽 물가에 있습니다.\n주의: 맹독가죽 라바사우루스(50-51)가 그 물가를 따라 사냥합니다. 사체를 뒤지기 전에 하나씩 끌어 처리하세요.\n라바사우루스는 {item:280459}을(를) 떨어뜨릴 수 있습니다. 우클릭하면 {npc:9619}이(가) 받습니다.",

	-- Step 17: Torwa Pathfinder
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale"] = "{quest:87494}, 라바사우루스가 비늘을 떨어뜨렸다면",
	-- {area:1943} Ironstone Plateau
	["The gorillas on {area:1943} carry the pelts: keep it for the second Un'Goro visit, around 56"] = "{area:1943}의 고릴라가 가죽을 지니고 있습니다: 56레벨 무렵 두 번째로 운고로에 올 때까지 보관하세요",

	-- Step 18: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "{npc:9683}와(과) 뗏목",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "{npc:9683}은(는) {npc:9619} 서쪽 밀림을 어슬렁거립니다. 부서진 뗏목은 그곳 호숫가에 있고, 작은 꾸러미는 그 옆 물속에 있습니다. 나침반, 지도, 열쇠는 {npc:8737}에게 주도록 보관하세요. 분화구의 어떤 야수든 {item:11116}을(를) 떨어뜨릴 수 있습니다. 오른쪽 클릭하세요.",
	-- {object:161504} A Small Pack
	["{object:161504}, underwater"] = "",

	-- Step 19: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Back east to {npc:9619} with the glands."] = "분비샘을 들고 동쪽 {npc:9619}에게 돌아가세요.",

	-- Step 20: Marshal's Refuge
	-- {npc:271301} Power Crystal · {object:157936} Un'Goro Dirt Pile
	["Ride north-west to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "북서쪽 야영지로 가세요.\n정예 데빌사우루스와 스테고돈은 멀리 피하세요. 여기서부터 지나가는 {npc:271301}와(과) {object:157936}을(를) 모두 챙기세요.",
	-- {npc:9998} Shizzle
	["{npc:9998}: his scales come from the young beasts of the eastern jungle"] = "{npc:9998}: 비늘은 동쪽 밀림의 어린 야수에게서 얻습니다",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, 야영지 안쪽",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "{zone:1452}의 {npc:9298}에게서 끝납니다: 보관하세요",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117}, 동굴 안쪽, 지하",
	-- {npc:9272} Spark Nilminer · {npc:9271} Hol'anyee Marshal · {npc:9270} Williden Marshal · {npc:9618} Karna Remtravel
	["{npc:9272}, {npc:9271}, {npc:9270} and {npc:9618} have quests among mobs of 51-55: leave them for the later Un'Goro visit, at about 56."] = "{npc:9272}, {npc:9271}, {npc:9270}, {npc:9618}의 퀘스트는 51-55레벨 몹 사이에서 진행됩니다: 56레벨 무렵 운고로에 다시 올 때로 미루세요.",

	-- Step 21: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537}와(과) 동쪽 밀림",
	-- {quest:3764} Un'Goro Soil · {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:9165} Fledgling Pterrordax
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher · Living Blazes = {npc:6521} Living Blaze · Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride east into the eastern jungle: Bloodpetal Lashers and Threshers (48-50) drop the petals and {quest:3764}. Crystal clusters stand all over the crater, many around the foot of {area:537}: take a few extra of each colour.\nCareful: the Living Blazes (54-55) walk the top of {area:537}, and the Bloodpetal Flayers and Trappers (51-53) hold the jungle's south: take your crystals from the ridge's foot and your petals in the north.\n{npc:9998}'s scales: the {npc:9165} (48-50) glide over the north-east of the jungle and the Young Diemetradons (49-50) graze beside them. There are only ten of those: the Diemetradons (51) on the jungle's western edge, a short way west of the Threshers, drop the scales too. They are a level over you: take them one at a time."] = "동쪽으로 동쪽 밀림에 들어가세요: 채찍줄기 붉은꽃잎덩굴손과 타작 붉은꽃잎덩굴손(48-50)이 꽃잎과 {quest:3764}을(를) 떨어뜨립니다. 수정 무더기는 분화구 곳곳에 있으며, {area:537} 기슭 주변에 많습니다: 색깔별로 몇 개씩 더 챙기세요.\n주의: 살아있는 불길(54-55)이 {area:537} 꼭대기를 돌아다니고, 칼날가시 붉은꽃잎덩굴손과 덫 붉은꽃잎덩굴손(51-53)이 밀림 남쪽을 차지하고 있습니다: 수정은 산마루 기슭에서, 꽃잎은 북쪽에서 구하세요.\n{npc:9998}의 비늘: {npc:9165}(48-50)가 밀림 북동쪽 위를 날고, 새끼 디메트로돈(49-50)이 그 옆에서 풀을 뜯습니다. 새끼 디메트로돈은 열 마리뿐입니다: 타작 덩굴손에서 조금 서쪽, 밀림 서쪽 가장자리의 디메트로돈(51)도 비늘을 떨어뜨립니다. 레벨이 하나 높으니 한 마리씩 잡으세요.",
	-- {item:11316} Bloodpetal
	["{item:11316}, from the Lashers and Threshers"] = "{item:11316}, 붉은꽃잎덩굴손에게서 획득",
	-- {quest:3764} Un'Goro Soil
	["{quest:3764}, from the Threshers and the dirt piles"] = "{quest:3764}, 타작 덩굴손과 흙더미에서 획득",

	-- Step 22: Lakkari Tar Pits
	-- plural, as words: Tar Lords = {npc:6519} Tar Lord
	["Crystal clusters stand all over the crater. The pits' Tar Lords (53-54) and the oozes around them (50-54) are over you: take the clusters on the jungle's north-eastern edge, among the Lashers and young beasts (48-50)."] = "수정 무더기는 분화구 곳곳에 있습니다. 구덩이의 우두머리 송진괴물(53-54)과 주변의 수액괴물(50-54)은 레벨이 높습니다: 붉은꽃잎덩굴손과 어린 야수(48-50) 사이, 밀림 북동쪽 가장자리의 수정 무더기를 노리세요.",

	-- Step 23: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "{zone:1444}의 {npc:7775}에게 줄 것: 보관하세요",

	-- Step 24: Level 49.79
	["Level 49.79"] = "",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Still short of level 49.79 after the refuge's hand-ins? Top up on the Bloodpetal Lashers and Threshers (48-50) of the eastern jungle, where you took the petals, before you leave the crater."] = "야영지 퀘스트를 제출한 뒤에도 49.79레벨이 안 됩니까? 분화구를 떠나기 전에 꽃잎을 모았던 동쪽 밀림의 채찍줄기 붉은꽃잎덩굴손과 타작 붉은꽃잎덩굴손(48-50)을 잡아 경험치를 채우세요.",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "",

	-- Step 25: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",
	-- {zone:1455} Ironforge · {zone:1427} Searing Gorge · {zone:1440} Ashenvale · {zone:1447} Azshara
	["The {zone:1455} quests were taken at the end of the {zone:1427} guide: fly straight on to {zone:1440} for {zone:1447}."] = "{zone:1455} 퀘스트는 {zone:1427} 가이드 끝에서 받았습니다: {zone:1447}에 가려면 곧장 {zone:1440}(으)로 날아가세요.",
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "{area:541} 비행 조련사",

	-- Step 26: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "{zone:1455}(으)로",

	-- Step 27: Mystic Ward
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}: {zone:1447}의 오그틴크에게 줄 것, 보관하세요",
	-- {npc:7312} Dink · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara
	["{npc:7312}, the mage trainer: for {npc:8395} in {zone:1447}, keep it"] = "",

	-- Step 30: Fly to Astranaar
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Archesonus stands beside King Magni in the {object:171709}."] = "아케소누스는 {object:171709}에서 국왕 마그니 브론즈비어드 옆에 서 있습니다.",
	-- ["Below ground"] = "지하",
	-- ["Bind and train"] = "귀환 장소 설정 및 수련",
	-- ["Bones and equipment"] = "뼈와 장비",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "분화구 남쪽을 가로질러 비탈 옆의 {npc:9619}에게 가세요.",
	-- ["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "{item:11114}은(는) 남서쪽 스테고돈 사이 땅바닥에 있습니다. 스테고돈은 정예이니 그 주변의 뼈만 줍고 나머지는 디메트로돈에게서 얻으세요. 탐험대의 {item:11112}은(는) 남서쪽 밀림에 있습니다.",
	-- ["Eastern Pylon"] = "동쪽 수정탑",
	-- ["Escort {npc:9999}"] = "{npc:9999} 호위",
	-- ["Fly from {area:144} to {area:1537}."] = "{area:144}에서 {area:1537}(으)로 날아가세요.",
	-- ["Fly to {area:1537}"] = "{area:1537}(으)로 비행",
	-- ["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. The crater's beasts are 48-55 and the Gorishi silithids 51-54, so pull them one at a time."] = "49~50레벨 캐릭터용이지만, 여기 퀘스트 대부분은 51-53레벨입니다. 경험치를 위해 일부러 넣었습니다. 분화구의 야수는 48-55레벨, 고리쉬 실리시드는 51-54레벨이니 하나씩 끌어오세요.",
	-- ["Four rune rubbings in {zone:1447}: keep it"] = "{zone:1447}의 룬 탁본 네 개: 보관하세요",
	-- ["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "{area:144}에서 {area:150}(으)로 날아가 배를 타고 테라모어로 간 뒤, {area:976}(으)로 날아가세요. 분화구에서 {npc:9619}의 첫 퀘스트는 48레벨이 필요합니다. 부족하면 여기서 레벨을 채우세요.",
	-- ["Grind to 50"] = "50레벨까지 사냥",
	-- ["Grind to 51"] = "51레벨까지 사냥",
	-- ["Gryfe"] = "그리페",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "{npc:9999}을(를) 북쪽 {area:541}까지 데려가세요. 그가 기절하면 {item:11804}을(를) 사용해 깨우세요.",
	-- ["Northern Pylon"] = "북쪽 수정탑",
	-- ["Pterrordax"] = "테러닥스",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "비탈을 내려가 분화구로 가세요. {npc:9619}은(는) 비탈 아래에 진을 치고 있습니다.",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "동쪽으로 {area:1943}까지 가세요. 로봇은 고릴라들 사이에 서 있습니다. 그곳의 깊은 동굴에는 들어가지 마세요.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "동쪽으로 {area:537}까지 가서 올라간 뒤, 꼭대기 근처 용암 분출구에서 {npc:10541}을(를) 사용하세요.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "동쪽을 따라 북쪽의 고릴라 고원으로 가세요. 55레벨 고릴라 {npc:9622}은(는) 가장 깊은 동굴에 있습니다. 먼저 동굴 입구의 고릴라를 정리하세요.",
	-- ["Ride north along the western jungle back to the refuge."] = "서쪽 밀림을 따라 북쪽으로 야영지에 돌아가세요.",
	-- ["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "북쪽으로 {area:1943}까지 가세요. 로봇은 고릴라들 사이에 서 있습니다. 그곳의 깊은 동굴에는 들어가지 마세요.",
	-- ["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "동쪽 절벽을 따라 남쪽으로, 비탈 아래의 {npc:9619}에게 가세요.",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales. The crate sits at the abandoned camp in the eastern jungle."] = "동쪽을 따라 남쪽으로 내려가세요. 어린 디메트라돈은 동쪽 밀림에서 풀을 뜯고, {npc:9165}은(는) 동쪽 절벽 근처를 납니다. 둘 다 {npc:9998}에게 줄 비늘을 떨어뜨립니다. 상자는 동쪽 밀림의 버려진 야영지에 있습니다.",
	-- ["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "남쪽으로 분화구 한가운데의 {area:537}까지 간 뒤 동쪽 밀림으로 가세요. 수정 무더기는 분화구 곳곳에, 특히 {area:537} 주변에 많습니다. 색깔마다 몇 개씩 더 챙기세요. {npc:6509}와(과) 덩이줄기 붉은꽃잎덩굴손이 꽃잎을 떨어뜨립니다. 탐험대의 {item:11113}은(는) 동쪽 밀림의 버려진 야영지에 있습니다.",
	-- ["Ride west back to the refuge."] = "서쪽으로 야영지에 돌아가세요.",
	-- ["Ride west back to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "서쪽 야영지로 돌아가세요.\n정예 데빌사우루스와 스테고돈은 멀리 피하세요. 여기서부터 지나가는 {npc:271301}와(과) {object:157936}을(를) 모두 챙기세요.",
	-- ["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "{npc:9619}에게서 서쪽으로 가세요. 실리시드 벌집이 분화구 남쪽을 채우고 있습니다. 유충이 매달린 방인 부화실에 긁개 유리병을 사용하세요. 병정 고리쉬와 일꾼 고리쉬가 {quest:3764}을(를) 떨어뜨립니다. 처치 수가 아직 필요하면 남쪽 절벽에 {npc:9166}이(가) 둥지를 틀고 있습니다.",
	-- ["Ride west out of {area:976} to the long ramp down into {area:490}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "{area:976}에서 서쪽으로 나가 {area:490}(으)로 내려가는 긴 비탈로 가세요. {npc:9619}은(는) 분화구 남동쪽 구석, 비탈 아래에 진을 치고 있습니다.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "서쪽으로 {area:541}을(를) 지나 서쪽을 따라 남쪽의 {area:543}까지 가세요. 고블린 {npc:10302}이(가) 물가에 앉아 있습니다.",
	-- ["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "파티라면 사냥 대신 {area:1417}을(를) 도는 편이 더 빠릅니다. 혼자 사냥하려면 이 단계를 건너뛰세요.",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "파티라면 사냥 대신 {area:978}을(를) 도는 편이 더 빠릅니다. 트롤 도시는 {zone:1446} 북서부, {area:976} 바로 북쪽에 있습니다.",
	-- ["Still short of level 49.79 after the refuge's hand-ins? Top up on the Pterrordax on the slopes east of {area:541} before you leave the crater."] = "야영지 퀘스트를 제출한 뒤에도 49.79레벨이 안 됩니까? 분화구를 떠나기 전에 {area:541} 동쪽 비탈의 테러닥스를 잡아 경험치를 채우십시오.",
	-- ["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "센티파르 실리시드가 분화구 비탈 바로 동쪽, {zone:1446} 서부의 {area:982} 주변을 기어다닙니다. 일꾼이 가장 쉽게 끌어올 수 있습니다.",
	-- ["The Gorishi hive"] = "고리쉬 벌집",
	-- ["The dead Threshadon lies by the water north of {npc:9619}."] = "죽은 트레샤돈은 {npc:9619} 북쪽 물가에 있습니다.",
	-- ["The east side"] = "동쪽 지역",
	-- ["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "고릴라는 {area:541} 동쪽의 {area:1943}에 삽니다. 가죽은 {npc:9619}에게 주도록 보관하세요. 가장 깊은 동굴에는 들어가지 마세요. {npc:9622}은(는) 55레벨입니다.",
	-- ["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "{area:1943}의 고릴라는 작은 무리로 다니며 아직은 필요한 것을 떨어뜨리지 않습니다. {npc:9619}의 가죽 퀘스트는 나중에 나옵니다. 가장 깊은 동굴에는 들어가지 마세요. {npc:9622}은(는) 55레벨입니다.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "가죽은 두 번째 순환 이후, 고릴라 고원에서 모읍니다",
	-- ["The pylon stands on the eastern cliffs."] = "수정탑은 동쪽 절벽 위에 서 있습니다.",
	-- ["The pylon stands on the slope east of the refuge. Pterrordax circle the slopes around it: they count for Spraggle and drop {npc:9998}'s scales."] = "수정탑은 야영지 동쪽 비탈에 서 있습니다. 테러닥스가 그 주변 비탈을 맴돕니다. 스프래글의 처치 수에 포함되며 {npc:9998}에게 줄 비늘을 떨어뜨립니다.",
	-- ["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "수정탑은 서쪽 절벽 위에 서 있습니다. {npc:9167}이(가) 서쪽 전역을 날아다닙니다.",
	-- ["The relics are in the {zone:1428}: keep it"] = "유물은 {zone:1428}에 있습니다: 보관하세요",
	-- ["The wooden sign beside {npc:9997}"] = "{npc:9997} 옆의 나무 표지판",
	-- ["Western Pylon"] = "서쪽 수정탑",
	-- ["Xiggs waits in the {object:32359}."] = "시그스는 {object:32359}에서 기다립니다.",
	-- ["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "{area:976} 주변의 황무지유랑단이나 모래망치 오우거를 사냥하세요",
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "{zone:1446} {area:982}에서 {npc:5458} 사냥",
	-- ["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "{zone:1449} {area:1943}에서 {npc:6514} 사냥",
	-- ["{area:978} (optional)"] = "{area:978}(선택)",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: 이전 가이드가 귀환석으로 이곳에 데려오므로 보통 바로 완료됩니다",
	-- ["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: 수액괴물은 {zone:1448}에 있습니다. 보관하세요",
	-- ["{npc:9618} stands just outside the refuge."] = "{npc:9618}은(는) 야영지 바로 바깥에 서 있습니다.",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "{npc:9684}의 굴은 {npc:9619} 북쪽, 동쪽 절벽 아래 밀림에 있습니다. 그곳에서 {item:11568}을(를) 사용하세요. {npc:9684}은(는) 56레벨이니 생명력이 가득한 상태로 시작하세요.",
	-- ["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9997}의 친구 {npc:9999}이(가) 실종되었습니다.",
	-- ["{npc:9998}, at the refuge entrance"] = "{npc:9998}, 야영지 입구",
	-- ["{npc:9998}, at the refuge's entrance"] = "{npc:9998}, 야영지 입구",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}은(는) 분화구 한가운데 {area:537}의 남동쪽 비탈에 앉아 있습니다.",
}
