-- Korean (koKR): the guide forever/horde/07-ashenvale (forever/horde/07-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zoram'gar Outpost
	-- {area:392} Ratchet · {area:2897} Zoram'gar Outpost · {zone:1440} Ashenvale
	["Fly from {area:392} to {area:2897} on the {zone:1440} coast."] = "{area:392}에서 {zone:1440} 해안의 {area:2897}(으)로 날아가세요.",
	-- {npc:12717} Muglash
	["{npc:12717}: starts his escort at once"] = "{npc:12717}: 바로 호위를 시작합니다",

	-- Step 2: Vorsha the Lasher
	-- {npc:12717} Muglash
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead."] = "{npc:12717}은(는) 해안을 따라 북쪽의 나가 화로로 걸어갑니다. 화로를 끄고, 보르샤가 죽을 때까지 나가의 공격을 막으며 그를 지키세요.",
	["Naga brazier"] = "나가 화로",

	-- Step 3: Blackfathom Deeps ruins
	-- {area:2797} Blackfathom Deeps
	["{area:2797} ruins"] = "{area:2797} 폐허",
	["The way to the Sapphires is through the sunken ruins at the north end of the strand: go down the stairs into the pit."] = "사파이어로 가는 길은 해안 북쪽 끝의 가라앉은 폐허를 지납니다. 계단을 내려가 구덩이로 들어가세요.",

	-- Step 4: Sapphires of Aku'Mai
	["Sapphires of Aku'Mai"] = "아쿠마이의 사파이어",
	-- {area:2797} Blackfathom Deeps
	["The Sapphires are blue crystals on the walls of the tunnels leading to the {area:2797} portal, underground and outside the instance: swim down from the pit, under the wall, into the cave. The satyrs and naga in the tunnels are elite: grouping up is advised. The crystals respawn quickly, so there is no need to go deep."] = "사파이어는 {area:2797} 차원문으로 이어지는 터널 벽에 박힌 푸른 수정으로, 인스턴스 밖 지하에 있습니다. 구덩이에서 헤엄쳐 내려가 벽 아래를 지나 동굴로 들어가세요. 터널의 사티로스와 나가는 정예입니다. 파티를 권장합니다. 수정은 빨리 다시 생기므로 깊이 들어갈 필요는 없습니다.",

	-- Step 5: Zoram'gar Outpost
	-- {npc:12736} Je'neu Sancrea · {area:2797} Blackfathom Deeps
	["{npc:12736} offers a {area:2797} quest next; leave it unless you have a group."] = "다음으로 {npc:12736}이(가) {area:2797} 퀘스트를 줍니다. 파티가 없다면 두세요.",

	-- Step 6: Thistlefur Village
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold."] = "조람가르 동쪽에서는 엉겅퀴일족 털보숭이가 마을과 소굴 주변 언덕을 가득 메우고 있습니다.",

	-- Step 7: Thistlefur Hold
	["Thistlefur Hold"] = "엉겅퀴일족 소굴",
	-- {npc:12818} Ruul Snowhoof · {area:428} Night Run
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}."] = "소굴 안의 터널을 따라 트롤 궤짝이 있습니다. {npc:12818}은(는) 깊숙한 곳에 갇혀 있습니다. 풀어 주고 밖으로 나갈 때까지 보호하세요. 그러면 그는 {area:428}(으)로 달려갑니다.",

	-- Step 8: Zoram'gar Outpost
	["Back west to Zoram'gar before heading east for good."] = "완전히 동쪽으로 떠나기 전에 서쪽의 조람가르로 돌아가세요.",

	-- Step 9: Ursangous
	-- {area:415} Astranaar · {npc:12678} Ursangous · {area:418} Ruins of Stardust · {area:421} Mystral Lake
	["Follow the main road east past {area:415} (Alliance: keep to the road). {npc:12678}, a big grizzly, roams the {area:418} south of the road, west of {area:421}. His paw starts the next hunt quest."] = "큰길을 따라 동쪽으로 {area:415}을(를) 지나가세요(얼라이언스: 길에서 벗어나지 마세요). 커다란 회색곰 {npc:12678}은(는) 길 남쪽, {area:421} 서쪽의 {area:418}을(를) 돌아다닙니다. 그의 발이 다음 사냥 퀘스트를 시작합니다.",

	-- Step 10: Ruins of Stardust fountain
	-- {area:418} Ruins of Stardust
	["{area:418} fountain"] = "{area:418} 분수",
	-- {area:418} Ruins of Stardust · {item:7767} Empty Blue Waterskin
	["The fountain stands in the middle of the {area:418}: use the {item:7767} there."] = "분수는 {area:418} 한가운데에 있습니다. 그곳에서 {item:7767}을(를) 사용하세요.",

	-- Step 11: Alonso
	-- {npc:210995} Alonso · {area:421} Mystral Lake
	["{npc:210995}, a Forever addition, stands on the west shore of {area:421} with three quick Dragonslayer quests."] = "Forever에서 추가된 {npc:210995}은(는) {area:421} 서쪽 기슭에서 간단한 용 사냥꾼 퀘스트 세 개를 줍니다.",

	-- Step 12: Tideress
	-- {npc:12759} Tideress · {area:421} Mystral Lake · {item:16408} Befouled Water Globe
	["{npc:12759}, a corrupted water elemental, drifts in {area:421}. Her {item:16408} starts a quest for Splintertree."] = "타락한 물의 정령 {npc:12759}은(는) {area:421}을(를) 떠다닙니다. 그녀의 {item:16408}은(는) 토막나무 주둔지 퀘스트를 시작합니다.",

	-- Step 13: King of the Foulweald
	-- {area:421} Mystral Lake · {item:16972} Karang's Banner · {object:178206} Foulweald Totem Mound (no name in this language: may be words) · {npc:12918} Chief Murgut
	["The Foulweald furbolgs hold the woods east of {area:421}, south of the road. Place {item:16972} on the {object:178206} and guard it: the furbolgs come to tear it down. {npc:12918} comes last; his totem drops in the basket."] = "썩은나무일족 털보숭이는 {area:421} 동쪽, 길 남쪽의 숲을 차지하고 있습니다. {object:178206}에 {item:16972}을(를) 놓고 지키세요. 털보숭이들이 깃발을 쓰러뜨리러 옵니다. {npc:12918}은(는) 마지막에 오며, 그의 토템은 바구니에 떨어집니다.",

	-- Step 14: Torek's Assault
	-- {npc:12858} Torek · {area:2360} Silverwing Outpost · {npc:12860} Duriel Moonfire
	["Keep east on the road. {npc:12858} waits south-west of the Warsong lumber camp. He and his grunts storm the {area:2360}: let them take aggro and stay with {npc:12858} until {npc:12860} is dead."] = "길을 따라 계속 동쪽으로 가세요. {npc:12858}은(는) 전쟁노래부족 벌목기지 남서쪽에서 기다립니다. 그와 그의 부하들이 {area:2360}을(를) 습격합니다. 그들이 어그로를 끌게 하고 {npc:12860}이(가) 죽을 때까지 {npc:12858} 곁에 있으세요.",

	-- Step 15: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867}은(는) 벌목기지에 서 있습니다. 나이트 엘프 정찰병은 그 남동쪽 숲에 숨어 있습니다. 은신하므로 주의하세요.",

	-- Step 16: Splintertree Post
	-- {area:431} Splintertree Post · {area:428} Night Run
	["North up the road to {area:431} and {area:428} beside it."] = "길을 따라 북쪽의 {area:431}와(과) 그 옆의 {area:428}(으)로 가세요.",
	-- {npc:12718} Gurda Ragescar
	["{npc:12718}: only if you carry the manual pages"] = "{npc:12718}: 교본 쪽지를 가지고 있을 때만",

	-- Step 17: Sharptalon
	-- {npc:12676} Sharptalon
	["{npc:12676}, a big nightsaber, prowls the woods south-east of the Warsong lumber camp. Her claw starts the next hunt quest."] = "커다란 밤호랑이 {npc:12676}은(는) 전쟁노래부족 벌목기지 남동쪽 숲을 돌아다닙니다. 그녀의 발톱이 다음 사냥 퀘스트를 시작합니다.",

	-- Step 18: Felmusk satyrs
	["Felmusk satyrs"] = "검은유혹의 사티로스",
	["North-west of Splintertree, the Felmusk satyrs camp in the woods. Every satyr can drop horns."] = "토막나무 주둔지 북서쪽 숲에 검은유혹의 사티로스가 야영하고 있습니다. 사티로스는 누구나 뿔을 떨어뜨릴 수 있습니다.",

	-- Step 19: Shadumbra
	-- {npc:12677} Shadumbra · {area:426} Raynewood Retreat
	["{npc:12677}, a shadow panther, stalks the woods around {area:426}, west of the Felmusk camp. Her head starts the next hunt quest."] = "그림자 표범 {npc:12677}은(는) 검은유혹의 사티로스 야영지 서쪽, {area:426} 주변 숲에 숨어 있습니다. 그녀의 머리가 다음 사냥 퀘스트를 시작합니다.",

	-- Step 20: Mystral Lake
	-- {area:421} Mystral Lake
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["Back south-west to {area:421}. Befouled Water Elementals drift around its shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "남서쪽의 {area:421}(으)로 돌아가세요. 타락한 물의 정령이 호숫가를 떠다닙니다. 정자는 얼라이언스 전초기지가 내려다보이는 섬에 있습니다.",
	["Gazebo"] = "정자",

	-- Step 23: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:222} Bloodhoof Village · {npc:2995} Tal
	["Fly to {area:1638} if you know the flight path. If not, fly to {area:378}, ride west into {zone:1412} past {area:222} to {area:1638} and take its flight path from {npc:2995} on the central rise."] = "비행 경로를 안다면 {area:1638}(으)로 날아가세요. 모른다면 {area:378}(으)로 날아가 서쪽 {zone:1412}(으)로 {area:222}을(를) 지나 {area:1638}까지 간 뒤, 중앙 고지의 {npc:2995}에게서 비행 경로를 얻으세요.",
	-- {npc:3057} Cairne Bloodhoof · {area:1638} Thunder Bluff · {quest:93739} Exploring the Horde
	["Speak with {npc:3057}, in {area:1638}: {quest:93739}"] = "{area:1638}의 {npc:3057}와(과) 대화하세요: {quest:93739}",

	-- Step 24: The Earthen Ring
	["The Earthen Ring"] = "대지 고리회",
	-- {area:1638} Thunder Bluff · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem · {npc:259118} Muln Earthfury
	["Take a lift down from {area:1638}. The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}."] = "{area:1638}에서 승강기를 타고 내려가세요. 대지 고리회 야영지는 절벽 북쪽에 있습니다: {npc:264074}, {npc:264072}, {npc:259118}.",

	-- Step 25: Gloomrise
	-- {area:17044} Gloomrise · {npc:264074} Mazu'kon · {item:273015} Toxin Extractor · {item:273181} Crystalline Silk · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["North of the camp, spiders overrun the burial ground at {area:17044}. Use {npc:264074}'s {item:273015} on the Gnawed Corpses; the Spinners drop the {item:273181}. {npc:264082} sits at the north end: her {item:273658} starts {quest:96294}."] = "야영지 북쪽에서 거미들이 {area:17044}의 매장지를 뒤덮고 있습니다. {npc:264096}에 {npc:264074}의 {item:273015}을(를) 사용하세요. 거미들은 {item:273181}을(를) 떨어뜨립니다. {npc:264082}은(는) 북쪽 끝에 있으며, 그녀의 {item:273658}이(가) {quest:96294}을(를) 시작합니다.",
	-- plural, as words: Gloomrise Toxin Samples = {item:273001} Gloomrise Toxin Sample · Gnawed Corpses = {npc:264096} Gnawed Corpse
	["Gloomrise Toxin Samples, from the Gnawed Corpses"] = "{npc:264096}에게서 얻는 {item:273001}",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{npc:264081}에게서 얻는 {item:273181}",
	-- {item:273658} Bloody Parchment · {npc:264082} Broodmother Valraxx
	["{item:273658}, from {npc:264082}"] = "{npc:264082}에게서 얻는 {item:273658}",

	-- Step 26: The Earthen Ring
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo
	["Back south to the camp, then up into {area:1638} for the flight to {area:378}."] = "남쪽 야영지로 돌아간 뒤, {area:1638}에 올라가 {area:378}(으)로 날아가세요.",

	-- Step 27: Brine
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {npc:5899} Brine · {area:1718} Great Lift
	["Fly from {area:1638} to {area:378}. {npc:5899}'s hut stands on the ridge above the quilboar watering hole south of the camp, on the road to the {area:1718}."] = "{area:1638}에서 {area:378}(으)로 날아가세요. {npc:5899}의 오두막은 야영지 남쪽, {area:1718}(으)로 가는 길가의 가시멧돼지 물웅덩이 위 능선에 있습니다.",
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["for {npc:5901}, south of {area:392}: next guide"] = "{area:392} 남쪽의 {npc:5901}에게: 다음 가이드",

	-- Step 28: Great Lift
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {area:1718} Great Lift · {zone:1413} Barrens
	["Fly from {area:1638} to {area:378} and take the road south to the {area:1718} at the bottom of the {zone:1413}."] = "{area:1638}에서 {area:378}(으)로 날아가 길을 따라 남쪽, {zone:1413} 맨 아래의 {area:1718}(으)로 가세요.",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "승강기 꼭대기의 {npc:10079}",

	-- Step 29: Freewind Post
	-- {area:484} Freewind Post
	["Ride the lift down, then follow the road east through the canyons to {area:484}, a Tauren village on top of the mesas. Its lift is on the north side."] = "승강기를 타고 내려가 길을 따라 동쪽으로 협곡을 지나 고원 꼭대기의 타우렌 마을인 {area:484}(으)로 가세요. 그곳 승강기는 북쪽에 있습니다.",
	-- {npc:10377} Elu
	["{npc:10377}, by the wind rider master"] = "윈드라이더 조련사 옆의 {npc:10377}",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}, the trade supplies vendor: the Screeching harpies of {area:487}"] = "교역품 상인 {npc:4877}: {area:487}의 회오리 하피",
	-- {npc:10537} Cliffwatcher Longhorn
	["The Wanted poster beside {npc:10537}"] = "{npc:10537} 옆의 현상수배 게시판",

	-- Step 30: Alien Egg
	["Take the lift down. The egg lies in a nest on the canyon floor in one of three spots: south-east of the mesas (52.3,55.2), east (56.4,50.4) or south-west (37.6,56.1)."] = "승강기를 타고 내려가세요. 알은 협곡 바닥의 둥지에 있으며, 위치는 세 곳 중 하나입니다: 고원 남동쪽(52.3,55.2), 동쪽(56.4,50.4), 남서쪽(37.6,56.1).",

	-- Step 32: Galak centaurs
	["Galak centaurs"] = "갈라크일족 켄타우로스",
	-- {npc:10617} Galak Messenger · {area:2237} Whitereach Post
	["The Galak camps fill the canyon north of Freewind; Scouts, Wranglers and Windchasers share every camp. A lone {npc:10617} walks between the camps: kill him when you meet him, his note starts a quest for {area:2237}."] = "갈라크일족 야영지가 높새바람 봉우리 북쪽 협곡을 가득 메우고 있으며, 모든 야영지에 척후병, 사냥꾼, 바람전사가 함께 있습니다. 홀로 다니는 {npc:10617}이(가) 야영지 사이를 오갑니다. 만나면 처치하세요. 그의 쪽지가 {area:2237} 퀘스트를 시작합니다.",

	-- Step 33: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {quest:1149} Test of Faith
	["{npc:2986} stands on a mesa top east of the Galak camps. For the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "{npc:2986}은(는) 갈라크일족 야영지 동쪽 고원 꼭대기에 서 있습니다. {quest:1149}에서는 그 옆 널빤지 끝에서 걸어 떨어지세요. 안전하게 착지합니다.",

	-- Step 35: Grimtotem camps
	["Grimtotem camps"] = "그림토템부족 야영지",
	-- {area:2097} Darkcloud Pinnacle
	-- plural, as words: Document Chests = {object:176344} Document Chest
	["West of Freewind, the Grimtotem camps below {area:2097}. The Secret Notes are in Document Chests at the south-east, south-west and north-west camps."] = "높새바람 봉우리 서쪽, {area:2097} 아래에 그림토템부족 야영지가 있습니다. 비밀 쪽지는 남동쪽, 남서쪽, 북서쪽 야영지의 {object:176344}에 있습니다.",
	-- {object:176344} Document Chest
	["{object:176344}, south-east camp"] = "{object:176344}, 남동쪽 야영지",
	-- {object:176344} Document Chest
	["{object:176344}, south-west camp"] = "{object:176344}, 남서쪽 야영지",
	-- {object:176344} Document Chest
	["{object:176344}, north-west camp"] = "{object:176344}, 북서쪽 야영지",

	-- Step 36: Lakota Windsong
	-- {area:2097} Darkcloud Pinnacle · {npc:10646} Lakota Windsong · {npc:10896} Arnak Grimtotem
	["Climb the path to the top of {area:2097}. {npc:10646} is held captive beside {npc:10896} (29): clear the guards and {npc:10896} first, then free her and protect her on the walk down; Grimtotem ambushers come at you on the way."] = "길을 따라 {area:2097} 꼭대기로 올라가세요. {npc:10646}은(는) {npc:10896}(29) 옆에 붙잡혀 있습니다. 먼저 경비병과 {npc:10896}을 처치한 뒤 그녀를 풀어 주고, 내려가는 동안 보호하세요. 가는 길에 그림토템부족 복병이 덤벼듭니다.",

	-- Step 37: Whitereach Post
	-- {area:2237} Whitereach Post
	["Follow the canyon west to {area:2237}."] = "협곡을 따라 서쪽의 {area:2237}(으)로 가세요.",
	-- {npc:10428} Motega Firemane · {area:1638} Thunder Bluff
	["{npc:10428}'s next quest, Sacred Fire, ends in {area:1638}, off this route. Skip it."] = "{npc:10428}의 다음 퀘스트인 신성한 불은 이 경로에서 벗어난 {area:1638}에서 끝납니다. 건너뛰세요.",
	-- {npc:10720} Galak Assassin · {npc:10638} Kanati Greycloud
	["Kill the {npc:10720} that comes for {npc:10638}"] = "{npc:10638}을(를) 노리고 오는 {npc:10720}을(를) 처치하세요",

	-- Step 38: Highperch
	-- {area:482} Highperch · {npc:10427} Pao'ka Swiftmountain · {area:2237} Whitereach Post
	["West of Whitereach the wyverns nest on the {area:482} cliffs; the eggs lie in the nests. {npc:10427} waits on the east side of the nesting grounds: free him and keep him alive on the walk back to {area:2237}."] = "백사장 야영지 서쪽, {area:482} 절벽에 와이번이 둥지를 틀고 있으며, 알은 둥지에 있습니다. {npc:10427}은(는) 둥지 동쪽에서 기다립니다. 풀어 주고 {area:2237}(으)로 돌아가는 동안 살려 두세요.",

	-- Step 40: Roguefeather Den
	-- {area:487} Roguefeather Den · {npc:4490} Grenka Bloodscreech · {npc:4877} Jandia
	["South of Darkcloud, the harpies of {area:487}. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her. The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s."] = "먹구름 봉우리 남쪽에 {area:487}의 하피들이 있습니다. {npc:4490}(31)은(는) 그들 사이를 돌아다닙니다. 끌어오기 전에 주변 하피를 줄이세요. 그곳의 회오리 하피, 약탈자, 바람마녀는 {npc:4877}의 퀘스트 대상입니다.",

	-- Step 43: Rok'Alim the Pounder
	-- {npc:4499} Rok'Alim the Pounder · {area:482} Highperch
	["{npc:4499}, a hard-hitting rock elemental, walks the cliffs of {area:482}. {npc:4499} is elite: grouping up is advised."] = "강하게 때리는 바위 정령 {npc:4499}이 {area:482} 절벽을 돌아다닙니다. {npc:4499}은(는) 정예입니다. 파티를 권장합니다.",

	-- Step 44: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyon east out of the mesas onto the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "협곡을 따라 동쪽으로 고원을 벗어나 소금 평원으로 가세요. {area:2240}의 고블린과 노움은 중립이며 양 진영 모두에게 퀘스트를 줍니다.",
	["His crate is for Stranglethorn, later on the route"] = "그의 상자는 나중에 경로상의 가시덤불 골짜기용입니다",

	-- Step 45: The salt flats
	["The salt flats"] = "소금 평원",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{object:19868} lies all over the flats north of the raceway. Scorpid Reavers and Sparkleshell Tortoises roam the north half, Salt Flats Scavengers circle overhead, and Saltstone Basilisks graze west of the track. The Crystalhides roam the middle of the flats and the Gazers (34-35, five levels above you: one at a time) the far south."] = "{object:19868}은(는) 경주장 북쪽 평원 곳곳에 있습니다. 붉은독전갈과 소금껍질거북은 북쪽 절반을 돌아다니고, 소금 평원 청소부독수리는 하늘을 맴돌며, 소금바위 바실리스크는 경주장 서쪽에서 풀을 뜯습니다. 수정바실리스크는 평원 중앙을, 큰눈바실리스크(34-35, 나보다 다섯 레벨 높음: 한 번에 하나씩)는 남쪽 끝을 돌아다닙니다.",

	-- Step 46: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, around level 38"] = "{npc:4454}: 그의 편지는 38레벨쯤 {zone:1418}의 마르텍에게 전합니다",

	-- Step 47: Freewind Post
	-- {zone:1454} Orgrimmar
	["The next guide flies on from here to {zone:1454}."] = "다음 가이드는 여기서 {zone:1454}(으)로 날아갑니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Shadumbra"] = "샤둠브라",
	-- ["Sharptalon"] = "뾰족발톱",
	-- ["The {area:1718}"] = "{area:1718}",
	-- ["Tideress"] = "타이더레스",
	-- ["Ursangous"] = "우르산고우스",
}
