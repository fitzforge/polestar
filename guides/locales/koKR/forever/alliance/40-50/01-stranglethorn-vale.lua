-- Korean (koKR): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Theramore
	["Theramore"] = "테라모어",
	-- {quest:1260} Morgan Stern · {npc:4897} Helenia Olden
	["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260}은(는) 여관 근처에 서 있습니다. 몇 걸음 남쪽의 거래 물품 상인 {npc:4897}이(가) 자를이 원하는 향신료를 팝니다.",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, \"늪지눈알\" 자를에게 줄 것",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "길을 따라 북서쪽으로 테라모어를 나가 {area:503}의 감시탑으로 가세요. {npc:4398}이(가) 그 주변 습지를 돌아다닙니다.",

	-- Step 3: Archmage Tervosh
	-- {area:514} Foothold Citadel
	["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "테라모어로 돌아가세요. 테르보쉬는 {area:514} 탑에서 제이나와 함께 기다립니다.",

	-- Step 4: Swamplight Manor
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house."] = "길을 따라 북쪽의 폐허가 된 오두막으로 가세요. 자를은 그 옆 판잣집에 살고, 흐트러진 흙은 집 모퉁이에 있습니다.",
	["with the spices from Theramore"] = "테라모어에서 산 향신료를 가지고",

	-- Step 5: Mudrock tortoises
	["Mudrock tortoises"] = "진흙바위거북",
	-- plural, as words: Mudrock Tortoises = {npc:4396} Mudrock Tortoise
	["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "{npc:4396}와(과) 뾰족껍질 진흙바위거북은 오두막 북동쪽 물가에서 햇볕을 쬡니다.",

	-- Step 6: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "\"말썽꾼\" 이그나츠",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "이그나츠는 오두막 서쪽, {area:504} 아래 습지에서 기다립니다. 그를 늪콩 잎사귀가 있는 곳으로 데려가며 늪의 짐승들이 그를 공격하지 못하게 막으세요.",

	-- Step 7: North Point Tower
	-- {npc:4966} Private Hendel
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966}은(는) 탈영병 몇 명과 함께 탑을 지키고 있습니다. 그가 당신에게 덤벼드니 굴복할 때까지 때리세요.",

	-- Step 8: Darkmist Cavern
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "암흑안개 거미는 습지 북서쪽 거미굴 주변에 둥지를 틀고 있습니다. 거미는 모두 눈알을 떨어뜨립니다.",

	-- Step 9: Mudcrush Durtfeet
	["Ride south to the giant's hut in the middle of the marsh."] = "남쪽으로 습지 한가운데의 거인 오두막으로 가세요.",

	-- Step 10: The Shady Rest Inn
	-- {zone:1413} Barrens
	["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "불탄 여관은 서쪽 길, {zone:1413} 방향에 있습니다. 경비병의 휘장은 잿더미 속에, 발굽 자국은 여관 옆 진흙에 있습니다.",

	-- Step 11: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "길을 따라 동쪽으로 테라모어에 돌아가세요. 테르보쉬, 제이나, 장교들은 탑과 {area:514}에 있습니다.",

	-- Step 12: Mirefin murlocs
	["Mirefin murlocs"] = "진흙아가미멀록",
	-- {area:497} Swamplight Manor
	["The Mirefin murlocs crowd the north coast past {area:497}; finish the tongues on the tortoises beside them."] = "진흙아가미멀록은 {area:497} 너머 북쪽 해안에 모여 있습니다. 혀는 그 옆의 거북에게서 마저 모으세요.",

	-- Step 13: Swamplight Manor
	-- {item:3853} Moonsteel Broadsword
	["only if you carry a {item:3853} (a blacksmith's craft)"] = "{item:3853}(대장장이 제작품)을 가지고 있을 때만",

	-- Step 15: Balos Jacken
	-- {npc:4503} Mudcrush Durtfeet
	["The deserters camp south of the road, west of {npc:4503}'s hut."] = "탈영병들은 {npc:4503}의 오두막 서쪽, 길 남쪽에 진을 치고 있습니다.",

	-- Step 17: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {area:391} Merchant Coast · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "{area:392}(으)로 북쪽으로 가는 길에, {area:720}은(는) 마을 남쪽 {area:391} 앞바다에 있습니다. 모래톱 얕은 물을 걸어서 건너가세요. {npc:6236}이(가) 도전자 넷을, 이어서 {npc:6238}(33레벨)을(를) 하나씩 보냅니다.",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "도전자들과 {npc:6238} 물리치기",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236} offers The Windwatcher next (1791): the Whirlwind weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "{npc:6236}은(는) 다음으로 바람의감시자(1791)를 줍니다. 끝에 정예가 나오는 소용돌이 무기 퀘스트 연계는 전사 직업 가이드 소용돌이 무기에 있습니다.",

	-- Step 18: Ratchet
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:16227} Bragok · {area:35} Booty Bay
	["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "테라모어에서 먼지진흙 습지대 길을 따라 서쪽으로 {zone:1413}에 들어간 뒤, 북쪽으로 해안의 {area:392}까지 가세요. {npc:16227}에게서 비행 경로를 배운 뒤 부두에서 배를 타고 {area:35}(으)로 가세요.",
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "배를 타고 {area:35}(으)로",

	-- Step 19: Booty Bay
	-- {object:56910} The Salty Sailor Tavern
	["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910}은(는) 항구 위의 높은 건물입니다. 퀘스트 제공자 대부분이 그 층들이나 아래 부두에 있습니다.",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}: keep it"] = "{zone:1446}의 스톨리에게 줄 것: 보관하세요",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773}: {zone:1446}의 {quest:2864}에게 줄 것, 보관하세요",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "북쪽 순환 경로에서 {area:99}의 {npc:770}에게",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}, 꼭대기 층",
	["Seahorn's next errand goes back to Arathi: skip it."] = "시혼의 다음 심부름은 아라시로 돌아갑니다. 건너뛰세요.",

	-- Step 20: Bloodsail camp
	["Bloodsail camp"] = "붉은해적단 야영지",
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks."] = "터널로 마을을 나가 해안을 따라 북쪽으로 가세요. 편지는 \"꽃미남\" 던컨이 걸어다니는 해변의 붉은해적단 야영지에 있습니다.",

	-- Step 21: Booty Bay
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624}은(는) 북쪽 순환 경로 중 북서쪽 해안 앞바다에서 헤엄칩니다",

	-- Step 22: Bloodsail pirates
	["Bloodsail pirates"] = "붉은해적단 해적",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore · {area:35} Booty Bay
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}."] = "붉은해적단은 모두 코담배를 떨어뜨리고, 그중 하나가 {npc:2493}의 눈을 가지고 있습니다. 붉은해적단 칼잡이는 마을 바로 북쪽 해안을 걸어다닙니다. 해도와 명령서는 {area:35} 남쪽 {area:43}의 해적 야영지에 있습니다.",

	-- Step 24: The Bloodsail captains
	["The Bloodsail captains"] = "붉은해적단 선장들",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon
	["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "선장들은 {area:43} 앞바다에 정박한 배 위에 있으며, 각자 42-45레벨 해적 선원을 거느립니다. 가까운 갑판에는 스틸워터(45)와 킬하울(46), 기함에는 {npc:2546}(48)이 있습니다. 42레벨이라면 파티로 하거나 가이드 끝에 할 전투입니다. 간다면 갑판마다 먼저 정리하세요. 코르텔로의 두루마리는 물가의 난파선에 있습니다.",
	-- {zone:1435} Swamp of Sorrows
	["for the {zone:1435} later"] = "나중에 {zone:1435}에 쓸 것",

	-- Step 26: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "{npc:1907}",
	["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "나가는 붉은해적단 야영지 북쪽 해변을 뒤지고 다니며, 갈대를 떨어뜨립니다.",

	-- Step 27: Gorilla hills
	["Gorilla hills"] = "고릴라 언덕",
	-- {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "내륙의 안개계곡 고릴라 언덕으로 가세요. {npc:1557}이(가) 내장을 떨어뜨리며, {npc:1449}은(는) 그들 사이에 앉아 있습니다.",

	-- Step 28: Unbagwa's ritual
	["Unbagwa's ritual"] = "운바그와의 의식",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "송곳니를 제출하고 그대로 있으세요. 고릴라가 세 차례 몰려오고 마지막에 {npc:1514}이(가) 나옵니다. 생명력이 가득한 상태로 싸우세요.",

	-- Step 29: Booty Bay
	["Ride back down to town; Shaky stands at the tunnel mouth."] = "마을로 다시 내려가세요. 겁쟁이 필립은 터널 입구에 서 있습니다.",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it"] = "테라모어의 {npc:2616}에게 줄 것: 보관하세요",

	-- Step 30: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535}와(과) {npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "북쪽으로 길 서쪽 언덕에 가세요. {npc:2535}와(과) {npc:2536}은(는) 잔질의 마을 바로 북쪽에 함께 서 있습니다.",

	-- Step 31: Zanzil's village
	["Zanzil's village"] = "잔질의 마을",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "잔질의 추종자는 누구나 혼합물을 떨어뜨릴 수 있습니다. {npc:2537}은(는) 야영지 남쪽을 걸어다닙니다.",

	-- Step 32: Crystalvein Mine
	-- {area:310} Crystalvein Mine
	["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "길을 따라 북동쪽 {area:310}의 투자개발회사 야영지로 가세요. 광부, 감시관, 현장감독이 수정을 떨어뜨립니다.",

	-- Step 33: Skullsplitter ruins
	["Skullsplitter ruins"] = "백골가루부족 폐허",
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "백골가루부족 트롤은 광산 바로 동쪽 폐허를 차지하고 있습니다. 누구든 엄니를 떨어뜨릴 수 있고, 그들의 퓨마는 항상 떨어뜨립니다.",

	-- Step 34: Cold Eye Basilisks
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["Cold Eye Basilisks"] = "{npc:690}",
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["The Cold Eye Basilisks lie on the rocks west of the mine."] = "{npc:690}은(는) 광산 서쪽 바위 위에 엎드려 있습니다.",

	-- Step 35: The north-west coast
	["The north-west coast"] = "북서쪽 해안",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "광산에서 북서쪽으로 북서 해안의 만까지 가세요. 바닥에 있는 거대한 대합에 진주가 들어 있습니다. {npc:2624}이(가) 그 사이를 헤엄치며 {item:4034}을(를) 떨어뜨립니다.",

	-- Step 36: Rebel Camp
	-- {npc:217588} Arbor Tarantula
	["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "네싱워리 야영지를 지나 북동쪽으로 간 뒤 길을 따라 북쪽, 골짜기 맨 위의 야영지로 가세요. 가는 길에 네싱워리 야영지 남동쪽 밀림에 {npc:217588}이(가) 기어다닙니다. 초보 곤충학자의 도구로 하나를 잡은 뒤 체크하세요.",
	-- {npc:217588} Arbor Tarantula · {quest:93176} My Little Friends
	["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588}: {quest:93176}을(를) 위해 잡으세요",

	-- Step 37: Booty Bay
	["MacKinley's next task sends you after elite ogres: skip it."] = "맥킨리의 다음 임무는 정예 오우거를 잡으러 보냅니다. 건너뛰세요.",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "{npc:2498}의 다음 잔질 심부름은 {zone:1441}에서 시작합니다. 건너뛰세요.",

	-- Step 38: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141}은(는) {object:2169}에서 요리하고, {npc:5384}은(는) {object:28027}에 있습니다.",
	-- {npc:5694} High Sorcerer Andromath · {area:1438} Nethergarde Keep
	["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694}: {area:1438}에 쓸 것, 보관하세요",
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440}, {object:2117}의 왕실 도서관",

	-- Step 39: Riding at 40
	["Riding at 40"] = "40레벨 탈것 타기",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40레벨에 100골드가 있으면 탈것 타기를 배울 수 있으며, 배우면 탈것도 하나 받습니다. {npc:4732}은(는) {zone:1429} 동부 {area:88}의 {npc:384}의 말 옆에서 인간에게 가르칩니다. Forever에서는 어느 종족이든 아무 탈것 상급자에게 배울 수 있을지도 모릅니다(확인되지 않음). 수집품, 탈것 · 레벨 40에 모든 색상이 나옵니다.",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384}: 다른 색상, 20골드",

	-- Step 40: Riding at 40
	-- {spell:1285849} Galestrider Riding · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {zone:1453} Stormwind · {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "40레벨에 100골드가 있으면 탈것 타기를 배울 수 있으며, 배우면 탈것도 하나 받습니다. 스카이본 탈것 상급자는 알려져 있지 않습니다. Forever 클라이언트는 {spell:1285849}을(를) 하나의 탈것 타기 기술로 분류하므로, {zone:1453}에서 가장 가까운 {zone:1429} 동부 {area:88}의 {npc:4732}이(가) 가르칠 것입니다(확인되지 않음). 돌풍타조는 제프라스 섬 {area:16638}의 {npc:265756}이(가) 팝니다. 수집품, 탈것 · 레벨 40에 나옵니다.",
	-- {npc:265756} Genn Fairweather · {area:16638} Valanaar
	["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "돌풍타조: 제프라스 섬 {area:16638}의 {npc:265756}.",

	-- Step 41: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "40레벨에 100골드가 있으면 탈것 타기를 배울 수 있으며, 배우면 탈것도 하나 받습니다. {npc:4753}은(는) {zone:1457}의 {npc:4730}의 표범 옆에서 나이트 엘프에게 가르칩니다. {area:17203}에서 배를 타고 {area:442}(으)로 간 뒤 {area:702}(으)로 날아가세요. Forever에서는 어느 종족이든 {zone:1429} {area:88}의 {npc:4732} 같은 아무 탈것 상급자에게 배울 수 있을지도 모릅니다(확인되지 않음). 수집품, 탈것 · 레벨 40에 모든 색상이 나옵니다.",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730}: 다른 색상, 20골드",

	-- Step 42: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "성기사: {quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171}, 빛의 대성당 안",

	-- Step 43: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "흑마법사: {quest:3631}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461}, {object:2164} 안: 다음 가이드 끝에 {area:392}의 {npc:6251}이(가) 받습니다",

	-- Step 44: Watcher Biggs
	-- {area:42} Darkshire · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {npc:5476} Watcher Biggs
	["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "{area:42}(으)로 날아간 뒤 동쪽으로 {zone:1430}을(를) 지나 {zone:1435}에 들어가세요. {npc:5476}은(는) 경계를 막 지난 길가에 서 있습니다.",

	-- Step 45: A Soggy Scroll
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "두루마리는 빅스 북쪽 습지에 있습니다. 그 북쪽의 늪괴물이 카드가의 평론을 떨어뜨릴 수 있습니다.",
	["The riddle's next scroll lies in western Dustwallow: skip it."] = "수수께끼의 다음 두루마리는 먼지진흙 습지대 서부에 있습니다. 건너뛰세요.",

	-- Step 46: The sunken temple
	["The sunken temple"] = "가라앉은 사원",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "동쪽으로 가세요. 가는 길의 {npc:766}도 평론을 떨어뜨립니다. 사원 폐허가 수면 위로 드러난 {area:74} 가장자리를 찾아보세요.",

	-- Step 47: Misty Reed Strand
	["The driftwood washes up along the eastern shore."] = "유목은 동쪽 해안을 따라 떠밀려 옵니다.",

	-- Step 48: Watcher Biggs
	-- {npc:217412} Amaryllis Webb
	["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "길을 따라 서쪽으로 돌아가세요. {npc:217412}은(는) 빅스 조금 북쪽에 서 있습니다.",
	-- {area:1438} Nethergarde Keep
	["for {area:1438}: keep it"] = "{area:1438}에 쓸 것: 보관하세요",
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412}: 30-40/05-arathi-highlands에서 받은 {quest:93176}",

	-- Step 49: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "{area:348}의 {npc:5635}에게 줄 것: 보관하세요",

	-- Step 50: Ironforge
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words) · {npc:1356} Prospector Stormpike · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern · {area:144} Thelsamar
	["Take the {area:2257} from the {object:28027}. {npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:1356} in the hall itself, {npc:2786} in the {object:32383}. The next guide flies on to {area:144}."] = "{object:28027}에서 {area:2257}을(를) 타세요. {npc:5637}은(는) {object:32356} 옆 개척자 연맹 전당에, {npc:1356}은(는) 전당 안에, {npc:2786}은(는) {object:32383}에 있습니다. 다음 가이드에서 {area:144}(으)로 날아갑니다.",
	-- {npc:1356} Prospector Stormpike · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356}: {zone:1432}의 {npc:1344}에게 줄 것, 보관하세요",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453}에는 주술사 상급자가 없습니다",

	-- Step 51: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40레벨에 100골드가 있으면 탈것 타기를 배울 수 있으며, 배우면 탈것도 하나 받습니다. {npc:4772}은(는) {area:131} 동쪽, {zone:1432}(으)로 가는 길의 {area:803}에서 {npc:1261}의 산양 옆에서 드워프에게 가르칩니다. Forever에서는 어느 종족이든 아무 탈것 상급자에게 배울 수 있을지도 모릅니다(확인되지 않음). 수집품, 탈것 · 레벨 40에 모든 색상이 나옵니다.",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261}: 다른 색상, 20골드",

	-- Step 52: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40레벨에 100골드가 있으면 탈것 타기를 배울 수 있으며, 배우면 탈것도 하나 받습니다. {npc:7954}은(는) {area:131} 바로 동쪽 {area:189}에서 {npc:7955}의 기계타조 옆에서 노움에게 가르칩니다. Forever에서는 어느 종족이든 아무 탈것 상급자에게 배울 수 있을지도 모릅니다(확인되지 않음). 수집품, 탈것 · 레벨 40에 모든 색상이 나옵니다.",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955}: 다른 색상, 20골드",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Klannoc offers The Windwatcher next (1791): the {spell:1680} weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "클라녹은 다음으로 바람의감시자(1791)를 줍니다. 끝에 정예가 나오는 {spell:1680} 무기 퀘스트 연계는 전사 직업 가이드 소용돌이 무기에 있습니다.",
}
