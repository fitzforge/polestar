-- Korean (koKR): the guide forever/alliance/03-loch-modan (forever/alliance/03-loch-modan.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "배를 타고 {area:150}(으)로",
	-- {area:442} Auberdine
	["Sell and repair in {area:442} first: the next stretch is a long one."] = "먼저 {area:442}에서 판매하고 수리하세요: 다음 구간은 깁니다.",

	-- Step 2: Menethil Harbor
	-- {zone:1437} Wetlands · {zone:1440} Ashenvale · {zone:1442} Stonetalon Mountains
	["Off the boat, walk up the pier to the flight master by the inn. Nothing to take here yet: Menethil's quests are for your {zone:1437} visit, after {zone:1440} and the {zone:1442}."] = "배에서 내려 부두를 따라 여관 옆 비행 조련사까지 가세요. 여기서 가질 것은 아직 없습니다: 메네실의 퀘스트는 {zone:1440}와 {zone:1442} 다음의 {zone:1437} 방문을 위한 것입니다.",

	-- Step 3: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "{zone:1432}(으)로 이동",
	-- {area:836} Dun Algaz · {zone:1437} Wetlands
	["Follow the road east out of Menethil and south through the {area:836} pass. Keep to the road: the {zone:1437} crocolisks and raptors beside it are over your level."] = "메네실 동쪽 밖으로 나가 {area:836} 고개를 남쪽으로 지나세요. 길을 따르세요: 그 옆 {zone:1437}의 악어와 랩터는 당신보다 레벨이 높습니다.",

	-- Step 4: Algaz Station
	-- {npc:1343} Mountaineer Stormpike · {area:925} Algaz Station
	["{npc:1343} stands at the {area:925}, at the south end of the pass."] = "{npc:1343}은(는) 고개 남쪽 끝에 있는 {area:925}에 서 있습니다.",

	-- Step 5: Mountaineer Stormpike
	-- {npc:1343} Mountaineer Stormpike · {npc:1416} Grimand Elmore
	["{npc:1343}: {npc:1416}'s package"] = "{npc:1343}: {npc:1416}의 소포",

	-- Step 6: Silver Stream Mine
	["East along the hills to the mine: the Miners' League crates sit in its tunnels among the Tunnel Rat kobolds."] = "언덕을 따라 동쪽으로 광산까지 가세요: 광부 협회의 상자들은 터널 쥐 코볼트 사이의 갱도 안에 있습니다.",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates; below ground"] = "{item:2640}, 상자에서; 지하",

	-- Step 7: Back to the Algaz Station
	-- {area:925} Algaz Station
	["Back to the {area:925}"] = "{area:925}(으)로 돌아가기",

	-- Step 8: Stonewrought Dam
	["Chief Engineer Hinderweir stands on top of the dam, up the ramp at its west end."] = "수석 기술자 힌더와이어는 댐 서쪽 끝의 경사로를 올라 댐 꼭대기에 서 있습니다.",

	-- Step 9: The Suspicious Barrel
	-- {object:257} Suspicious Barrel
	["The {object:257}"] = "{object:257}",
	-- plural, as words: Dark Iron Sappers = {npc:1222} Dark Iron Sapper
	["Walk east along the dam, down its eastern ramp, then back west along the foot of the dam on the land side: two Dark Iron Sappers guard the barrel. Kill them, then open the barrel: it ends this quest and starts the next."] = "댐을 따라 동쪽으로 걸어가 동쪽 경사로를 내려와 댐 아래 육지 쪽을 따라 다시 서쪽으로 가세요: 검은무쇠 공병 두 명이 통을 지킵니다. 그들을 죽인 뒤 통을 여세요: 이 퀘스트가 끝나고 다음 퀘스트가 시작됩니다.",

	-- Step 11: The loch
	["The loch"] = "호수",
	-- {object:665289} Discarded Fishing Toolbox (no name in this language: may be words) · {area:144} Thelsamar · {item:278051} Monogrammed Silver Hair Clip
	["South along the west shore. The {object:665289} lies on the loch bed at one of several places: east of {area:144} (48.1,39.7), a little south-west of there (45.7,43.4), or at the south end of the loch (48.7,54.4 or 50.6,53.3). If it isn't at the arrow, try the next place. Click it for the quest; the {item:278051} comes with it."] = "서쪽 기슭을 따라 남쪽으로 가세요. {object:665289}은(는) 여러 곳 중 하나의 호수 바닥에 있습니다: {area:144} 동쪽(48.1,39.7), 그곳에서 조금 남서쪽(45.7,43.4), 또는 호수 남쪽 끝(48.7,54.4 또는 50.6,53.3). 화살표 위치에 없으면 다음 곳을 시도하세요. 클릭하면 퀘스트가 시작되고 {item:278051}이(가) 함께 나옵니다.",
	-- {object:665289} Discarded Fishing Toolbox (no name in this language: may be words)
	["{object:665289}; underwater"] = "{object:665289}; 수중",

	-- Step 12: Thelsamar
	-- {npc:1684} Khara Deepwater · {npc:1105} Jern Hornhelm
	["{npc:1684} stands on the shore north-east of town, {npc:1105} by the inn."] = "{npc:1684}은(는) 마을 북동쪽 기슭에, {npc:1105}은(는) 여관 옆에 서 있습니다.",

	-- Step 13: Ironband's Excavation
	-- {npc:1345} Magmar Fellhew · {npc:1344} Prospector Ironband
	["Round the south end of the loch and head east to the dig. {npc:1345} and {npc:1344} stand together at its west edge."] = "호수 남쪽 끝을 돌아 동쪽 발굴지로 가세요. {npc:1345}와 {npc:1344}은(는) 그 서쪽 가장자리에서 함께 서 있습니다.",

	-- Step 14: The dig site
	["The dig site"] = "발굴지",
	-- {item:2636} Carved Stone Idol · {quest:86613} Excavation Tools
	-- plural, as words: Stonesplinter Diggers = {npc:1167} Stonesplinter Digger · Berserk Troggs = {npc:1393} Berserk Trogg
	["Stonesplinter Diggers, Geomancers and Berserk Troggs hold the dig east of Ironband; any of them can drop a {item:2636}. Piles of Excavation Tools lie around the dig: open one and right-click the tools to start {quest:86613}, then gather six.\nCareful: Berserk Troggs (19-20) enrage below 40% health."] = "가루바위일족 굴착꾼, 점성술사, 광전사 트로그가 아이언밴드 동쪽 발굴지를 지키고 있습니다: 그중 아무나 {item:2636}을(를) 떨어뜨릴 수 있습니다. 발굴 도구 더미가 발굴지 주변에 있습니다: 하나를 열어 도구를 마우스 오른쪽 단추로 클릭해 {quest:86613}을(를) 시작하고 여섯 개를 모으세요.\n주의: 광전사 트로그(19-20)는 생명력 40% 아래에서 광폭해집니다.",
	-- {quest:86613} Excavation Tools
	["{quest:86613}: open a pile at the dig"] = "{quest:86613}: 발굴지에서 더미 열기",
	-- {quest:86613} Excavation Tools
	["Right-click the {quest:86613}"] = "{quest:86613}을(를) 마우스 오른쪽 단추로 클릭",

	-- Step 16: The Farstrider Lodge
	-- {npc:1154} Marek Ironheart · {npc:1187} Daryl the Youngling
	["North-east to the lodge on the hill. {npc:1154} stands inside, {npc:1187} outside."] = "북동쪽 언덕의 오두막까지 가세요. {npc:1154}은(는) 안에, {npc:1187}은(는) 밖에 서 있습니다.",
	-- {npc:1154} Marek Ironheart
	["{npc:1154}, inside"] = "{npc:1154}, 안",
	-- {npc:1154} Marek Ironheart
	["{npc:1154}: the loch crocolisks below the lodge"] = "{npc:1154}: 오두막 아래 호수 악어",
	-- {npc:1187} Daryl the Youngling
	["{npc:1187}: 15 minutes"] = "{npc:1187}: 15분",

	-- Step 17: Mountain Buzzards
	-- plural, as words: Mountain Buzzards = {npc:1194} Mountain Buzzard
	["Mountain Buzzards"] = "산대머리수리",
	-- {quest:257} A Hunter's Boast
	-- plural, as words: Mountain Buzzards = {npc:1194} Mountain Buzzard
	["Mountain Buzzards circle the hills west and south of the lodge, back toward the dig. {quest:257} runs for 15 minutes."] = "산대머리수리는 오두막 서쪽과 남쪽, 발굴지 쪽 언덕을 선회합니다. {quest:257}은(는) 15분 동안 이어집니다.",

	-- Step 18: Daryl the Youngling
	["12 minutes"] = "12분",

	-- Step 19: Elder Mountain Boars
	-- plural, as words: Elder Mountain Boars = {npc:1192} Elder Mountain Boar
	["Elder Mountain Boars"] = "늙은 산멧돼지",
	-- {quest:258} A Hunter's Challenge
	-- plural, as words: Elder Mountain Boars = {npc:1192} Elder Mountain Boar
	["The Elder Mountain Boars roam the hills north-west of the lodge, along the east shore. {quest:258} runs for 12 minutes: kill five and go straight back to Daryl; the crocolisks come after."] = "늙은 산멧돼지는 오두막 북서쪽, 동쪽 기슭을 따라 언덕을 배회합니다. {quest:258}은(는) 12분 동안 이어집니다: 다섯 마리를 죽이고 데릴에게 바로 돌아가세요; 악어는 그다음입니다.",

	-- Step 21: Daggerfang and the loch crocolisks
	-- {npc:270693} Daggerfang
	["{npc:270693} and the loch crocolisks"] = "{npc:270693}과(와) 호수 악어",
	-- {npc:270693} Daggerfang
	-- plural, as words: Loch Crocolisks = {npc:1693} Loch Crocolisk
	["Back down to the east shore below the boars' hills: {npc:270693}, a crocolisk, patrols it among the Loch Crocolisks."] = "멧돼지 언덕 아래 동쪽 기슭으로 다시 내려가십시오. 악어인 {npc:270693}이(가) 호수 악어 사이를 순찰합니다.",
	-- {item:2924} Crocolisk Meat
	-- plural, as words: Loch Crocolisks = {npc:1693} Loch Crocolisk
	["{item:2924}: Loch Crocolisks"] = "{item:2924}: 호수 악어",

	-- Step 23: Thelsamar
	-- {area:144} Thelsamar · {npc:1105} Jern Hornhelm · {npc:1572} Thorgrum Borrelson
	["Back west along the south shore to {area:144}: {npc:1105} by the inn, then {npc:1572} with the gryphons on the west side of town, on the way south."] = "남쪽 기슭을 따라 서쪽으로 {area:144}까지 돌아가세요: {npc:1105}은(는) 여관 옆에, {npc:1572}은(는) 마을 서쪽 그리폰들과 함께 남쪽으로 가는 길에 있습니다.",
	-- {npc:1356} Prospector Stormpike · {zone:1455} Ironforge
	["For {npc:1356} in {zone:1455}"] = "{zone:1455}의 {npc:1356}에게 줄 것",

	-- Step 24: Mountaineer Ylva
	-- {npc:269185} Headsplitter · {zone:1418} Badlands
	-- plural, as words: Stonevault Cave Hunters = {npc:4856} Stonevault Cave Hunter
	["South of Thelsamar, Ylva lies dead in the mouth of a trogg cave. Take her banner, raise it beside her and hold the spot: troggs come in waves from both sides, then {npc:269185}.\nCareful: Stonevault Cave Hunters (36, elite) hold the pass just south of Ylva, toward the {zone:1418}: stay by the banner and don't chase troggs south."] = "텔사마 남쪽, 일바는 트로그 동굴 입구에서 죽어 있습니다. 그녀의 깃발을 들어 그녀 옆에 세우고 그 자리를 지키세요: 트로그가 양쪽에서 물결처럼 오고, 이어서 {npc:269185}이(가) 옵니다.\n주의: 바위동굴 사냥꾼(36, 정예)이 일바 바로 남쪽, {zone:1418} 방면 고개를 지키고 있습니다: 깃발 곁에 머물며 트로그를 남쪽으로 쫓지 마세요.",

	-- Step 25: The tunnel post
	["The tunnel post"] = "터널 초소",
	-- {zone:1426} Dun Morogh
	["West to the dwarven post at the tunnel to {zone:1426}."] = "{zone:1426}으로 가는 터널의 그놈 전초기지까지 서쪽으로 가세요.",

	-- Step 26: Captain Rugelfuss
	-- {npc:1092} Captain Rugelfuss
	["{npc:1092} is inside the bunker at the tunnel post: go in by its door on the south-east side."] = "{npc:1092}은(는) 터널 초소의 벙커 안에 있습니다. 남동쪽 문으로 들어가십시오.",
	-- {npc:1092} Captain Rugelfuss
	["{npc:1092}, inside"] = "{npc:1092}, 내부",

	-- Step 27: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "{area:1537}(으)로 비행",
	-- {area:1537} Ironforge · {area:144} Thelsamar · {zone:1426} Dun Morogh
	["You have the {area:1537} flight path: back north to {area:144}'s gryphons, quicker than walking through the tunnel and across {zone:1426}."] = "{area:1537} 비행 경로를 이미 알고 있습니다: 북쪽의 {area:144} 그리폰으로 돌아가세요. 터널을 지나 {zone:1426}을(를) 가로질러 걷는 것보다 빠릅니다.",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144} 비행 조련사",

	-- Step 28: Into Dun Morogh
	-- {zone:1426} Dun Morogh
	["Into {zone:1426}"] = "{zone:1426}(으)로 이동",
	-- {zone:1455} Ironforge · {area:144} Thelsamar
	["Through the South Gate tunnel and west along the road to {zone:1455}. Know the {zone:1455} flight path already? Fly from {area:144} instead: these two waypoints drop once you are in the city."] = "남쪽 관문 터널을 지나 길을 따라 서쪽으로 {zone:1455}까지 가세요. {zone:1455} 비행 경로를 이미 알고 있나요? 대신 {area:144}에서 비행하세요: 도시에 들어서면 이 두 경유지는 사라집니다.",

	-- Step 29: Into Ironforge
	-- {zone:1455} Ironforge
	["Into {zone:1455}"] = "{zone:1455}(으)로 이동",

	-- Step 30: Ironforge
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words) · {npc:1356} Prospector Stormpike · {object:32356} Hall of Explorers (no name in this language: may be words) · {object:171524} Tinker Town
	["{npc:1573} keeps the gryphons in the {object:32372}; {npc:1356} is in the {object:32356}, north-east of it, on the way to the tram in {object:171524}."] = "{npc:1573}은(는) {object:32372}에서 그리폰을 돌보고, {npc:1356}은(는) 그 북동쪽 {object:32356}에 있으며 {object:171524}의 트램으로 가는 길에 있습니다.",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}, {object:32372} 안",

	-- Step 31: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "지하철을 타고 {zone:1453}(으)로",

	-- Step 32: Elwynn Forest
	-- {zone:1453} Stormwind · {area:87} Goldshire
	["From the tram, leave {zone:1453} by the main gate and follow the road through {area:87} and east through Elwynn to Redridge."] = "트램에서 내려 정문으로 {zone:1453}을(를) 나와 {area:87}을(를) 지나 엘윈 동쪽을 따라 레드릿지까지 가세요.",
	["The road east to Redridge"] = "레드릿지로 가는 동쪽 길",

	-- Step 33: Henze Faulk
	-- {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["From the bridge, head north to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "다리에서 북쪽 {area:86}(으)로 가세요. {npc:6172}은(는) 호수 남쪽에 누워 있습니다: 그에게 {item:6866}을(를) 사용하세요. 그 주변의 데피아즈단 견습마술사들이 {item:6846}을(를) 지니고 있습니다.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "{npc:6172}에게 {item:6866} 사용",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: 데피아즈단 견습마술사",

	-- Step 34: Three Corners
	-- {area:1002} Three Corners · {npc:464} Guard Parker
	["The road crosses into Redridge at {area:1002}. {npc:464} walks around the crossroads."] = "길은 {area:1002}에서 레드릿지로 건너갑니다. {npc:464}은(는) 십자길을 돌아다닙니다.",
	-- {npc:464} Guard Parker · {area:1002} Three Corners
	["{npc:464} walks around {area:1002}: look inside the circle on the map"] = "{npc:464}은(는) {area:1002}를 돌아다닙니다: 지도의 원 안을 보세요",

	-- Step 35: Lakeridge Highway
	-- {area:68} Lake Everstill · {npc:1070} Deputy Feldon
	["Follow the road along the south shore of {area:68} to the gryphon master. {npc:1070} stands by the road next to her."] = "{area:68} 남쪽 기슭을 따라 그리폰 조련사까지 가세요. {npc:1070}은(는) 그녀 옆 길가에 서 있습니다.",

	-- Step 36: Lakeshire
	-- {npc:8965} Shawn · {npc:8962} Hilary · {npc:341} Foreman Oslow · {npc:415} Verner Osgood · {npc:344} Magistrate Solomon · {npc:381} Dockmaster Baren · {npc:266} Wiley the Black · {npc:379} Darcy · {npc:343} Chef Breanna
	["Cross the long bridge north into town: {npc:8965} and {npc:8962} play by the shore at its north end, {npc:341} stands there too, {npc:415} by the smithy, {npc:344} in the town hall, {npc:381} on the docks, {npc:266} upstairs in the inn and {npc:379} and {npc:343} inside it."] = "긴 다리를 건너 북쪽 마을로 들어가세요: {npc:8965}와 {npc:8962}은(는) 북쪽 끝 기슭에서 놀고, {npc:341}도(도) 거기에 서 있으며, {npc:415}는(은) 대장간 옆에, {npc:344}는(은) 시청 안에, {npc:381}은(는) 부두에, {npc:266}은(는) 여관 위층에, {npc:379}와 {npc:343}은(는) 그 안에 있습니다.",
	-- {npc:415} Verner Osgood · {npc:514} Smith Argus · {area:87} Goldshire
	["{npc:415}: for {npc:514} in {area:87}"] = "{npc:415}: {area:87}의 {npc:514}에게 줄 것",
	-- {npc:344} Magistrate Solomon · {npc:466} General Marcus Jonathan · {zone:1453} Stormwind
	["{npc:344}, in the town hall: for {npc:466} in {zone:1453}"] = "{npc:344}, 시청 안: {zone:1453}의 {npc:466}에게 줄 것",
	-- {npc:266} Wiley the Black
	["{npc:266}, in the inn; upstairs"] = "{npc:266}, 여관 안; 위층",
	-- {npc:379} Darcy
	["{npc:379}, inside"] = "{npc:379}, 안",
	-- {npc:343} Chef Breanna
	["{npc:343}, inside"] = "{npc:343}, 안",

	-- Step 37: Guard Parker
	-- {area:1002} Three Corners
	["West along the road to {area:1002} first; the gnolls are on the way back east."] = "먼저 서쪽 길을 따라 {area:1002}까지 가세요; 그놀들은 동쪽으로 돌아오는 길에 있습니다.",

	-- Step 38: Lakeridge Highway: kill these as you meet them
	-- {area:1001} Lakeridge Highway
	["{area:1001}: kill these as you meet them"] = "{area:1001}: 만나는 대로 처치하십시오",
	-- {area:1002} Three Corners
	-- plural, as words: Redridge Mongrels = {npc:423} Redridge Mongrel · Great Goretusks = {npc:547} Great Goretusk · Dire Condors = {npc:428} Dire Condor
	["Redridge Mongrels and Thrashers hold the hills east of {area:1002}, north of the road; Poachers camp south of the road. Great Goretusks root around the same hills and Dire Condors circle south of the lake; Tarantulas crawl round {area:1002}."] = "레드릿지 개들과 구타자들이 {area:1002} 동쪽, 길 북쪽 언덕을 지키고 있습니다; 밀렵꾼들은 길 남쪽에 진을 칩니다. 큰 살찢이가 같은 언덕에서 파고들고 지독한 콘도르가 호수 남쪽을 선회합니다; 타란툴라가 {area:1002} 주변을 기어다닙니다.",
	-- {item:280911} Spiked Collar
	-- plural, as words: Redridge Thrashers = {npc:712} Redridge Thrasher
	["{item:280911}: Redridge Thrashers"] = "{item:280911}: 붉은마루일족 약탈자",
	-- {item:1081} Crisp Spider Meat
	["{item:1081}: Tarantulas"] = "{item:1081}: 타란툴라",

	-- Step 39: Deputy Feldon
	-- {npc:1070} Deputy Feldon
	["East along the road to the gryphon master; {npc:1070} stands beside her."] = "동쪽 길을 따라 그리폰 조련사까지 가세요; {npc:1070}은(는) 그녀 옆에 서 있습니다.",

	-- Step 40: Sunken Chest
	-- {area:68} Lake Everstill · {item:1467} Spotted Sunfish
	-- plural, as words: Murloc Flesheaters = {npc:422} Murloc Flesheater · Lake Threshers = {npc:14357} Lake Thresher
	["Back toward town, swim east from the bridge into {area:68}; the chest lies on the lake bed beside a sunken boat. Murloc Flesheaters and Tidecallers line the south shore around it: any of them can carry a {item:1467}.\nCareful: Lake Threshers, level 25 elites, swim in the lake: keep your distance from them while you dive for the chest."] = "마을 쪽으로 돌아가며 다리에서 동쪽 {area:68}(으)로 헤엄쳐 가십시오. 상자는 가라앉은 배 옆 호수 바닥에 있습니다. 주변 남쪽 호숫가에 멀록 청소부와 멀록 파도술사가 늘어서 있으며, 누구든 {item:1467}을(를) 지니고 있을 수 있습니다.\n주의: 25레벨 정예 호수 트레샤돈이 호수에서 헤엄치니 상자를 찾아 잠수하는 동안 거리를 두십시오.",
	-- {item:1309} Oslow's Toolbox
	["{item:1309}; underwater"] = "{item:1309}; 수중",

	-- Step 41: Hilary's Necklace
	-- {object:154357} Glinting Mud
	["Then west under the bridge: a {object:154357} mound on the lake bed beside town holds the necklace. Only one mound shows at a time, anywhere from under the dock to past the bridge."] = "이제 다리 아래 서쪽으로 가세요: 마을 옆 호수 바닥의 {object:154357} 언덕이 목걸이를 지니고 있습니다. 언덕은 한 번에 하나만 보이며, 부두 아래부터 다리 너머까지 어디에나 나타납니다.",
	-- {quest:3741} Hilary's Necklace
	["{quest:3741}; underwater"] = "{quest:3741}; 수중",

	-- Step 42: Lakeshire
	-- {npc:8962} Hilary · {npc:341} Foreman Oslow · {npc:381} Dockmaster Baren · {npc:342} Martie Jainrose · {npc:379} Darcy · {npc:343} Chef Breanna
	["Through town east to west: {npc:8962} and {npc:341} at the north end of the bridge, {npc:381} on the docks, then {npc:342}'s garden at the west end; {npc:379} and {npc:343} are in the inn."] = "마을을 동쪽에서 서쪽으로 관통하세요: {npc:8962}와 {npc:341}은(는) 다리 북쪽 끝에, {npc:381}은(는) 부두에, 이어서 {npc:342}의 정원이 서쪽 끝에 있습니다; {npc:379}와 {npc:343}은(는) 여관 안에 있습니다.",
	-- {zone:1436} Westfall
	["Its pikes and rivets come from the gnolls north of the lake, on the loop after {zone:1436}"] = "창과 리벳은 호수 북쪽 그놀들에게서 나오며, {zone:1436} 다음 순환에 있습니다",

	-- Step 43: Dockmaster Baren
	-- {npc:381} Dockmaster Baren · {quest:150} Murloc Poachers · {area:69} Lakeshire
	["From level 20 {npc:381} gives {quest:150}: take it now if he offers it (otherwise on the last {area:69} stop). Its murlocs are for your next Redridge visit, at about 24."] = "20레벨부터 {npc:381}이(가) {quest:150}을(를) 줍니다: 그가 제안하면 지금 받으세요(아니면 마지막 {area:69} 들름새에서). 그 멀록들은 약 24레벨의 다음 레드릿지 방문을 위한 것입니다.",
	-- {npc:381} Dockmaster Baren
	["{npc:381}, on the docks"] = "{npc:381}, 부두 위",

	-- Step 44: Goldshire
	-- {area:1002} Three Corners · {area:87} Goldshire
	["West out of Redridge by {area:1002} and along the road through Elwynn to {area:87}."] = "{area:1002}를 통해 레드릿지 서쪽 밖으로 나와 엘윈 동쪽 길을 따라 {area:87}까지 가세요.",

	-- Step 45: Smith Argus
	-- {npc:514} Smith Argus · {area:87} Goldshire
	["{npc:514} works at the {area:87} smithy."] = "{npc:514}은(는) {area:87} 대장간에서 일합니다.",

	-- Step 46: Stormwind's gate
	-- {zone:1453} Stormwind
	["{zone:1453}'s gate"] = "{zone:1453}의 문",
	-- {npc:234} Gryan Stoutmantle · {zone:1436} Westfall · {area:87} Goldshire · {zone:1453} Stormwind · {npc:466} General Marcus Jonathan · {object:2096} Trade District · {area:69} Lakeshire
	["No Defias Brotherhood from Wiley (it starts with {npc:234}'s letter in {zone:1436}): skip {zone:1436}. North along the road from {area:87} to {zone:1453}: {npc:466} sits on his horse at the far end of the bridge outside the main gate. Then the gryphons in the {object:2096}, back to {area:69}."] = "와일리에게는 데피아즈단 결사대가 없습니다({zone:1436}, {npc:234}의 편지에서 시작): {zone:1436}은(는) 건너뛰세요. {area:87}에서 {zone:1453}으로 가는 길을 따라 북쪽으로 가세요: {npc:466}은(는) 정문 밖 다리 맞은편 끝에 말을 타고 앉아 있습니다. 이어서 {object:2096}의 그리폰으로 {area:69}까지 돌아가세요.",
	-- {npc:466} General Marcus Jonathan
	["{npc:466}, outside the main gate"] = "{npc:466}, 정문 밖",

	-- Step 47: Westfall
	-- {zone:1436} Westfall
	["West through Westbrook into {zone:1436}."] = "웨스트브룩을 서쪽으로 지나 {zone:1436}(으)로 가세요.",

	-- Step 48: Sentinel Hill
	-- {area:108} Sentinel Hill · {npc:234} Gryan Stoutmantle
	["Down the road to {area:108}. {npc:234} stands at the top of the stone tower."] = "길을 따라 {area:108}까지 내려가세요. {npc:234}은(는) 돌탑 꼭대기에 서 있습니다.",
	-- {npc:332} Master Mathias Shaw · {zone:1453} Stormwind
	["For {npc:332} in {zone:1453}"] = "{zone:1453}의 {npc:332}에게 줄 것",

	-- Step 49: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "{zone:1453}로 비행",
	-- {area:108} Sentinel Hill
	["{area:108} flight master"] = "{area:108} 비행 조련사",

	-- Step 50: Stormwind
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:466} General Marcus Jonathan · {object:2096} Trade District
	["{npc:332} is upstairs in the SI:7 building in {object:2100}: the stairs are hard to see at first. {npc:466} sits on his horse at the far end of the bridge outside the main gate, then back to the gryphons in the {object:2096}."] = "{npc:332}은(는) {object:2100}의 SI:7 건물 위층에 있습니다: 계단은 처음에 잘 보이지 않습니다. {npc:466}은(는) 정문 밖 다리 맞은편 끝에 말을 타고 앉아 있고, 이어서 {object:2096}의 그리폰으로 돌아가세요.",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7; upstairs"] = "{npc:332}, SI:7; 위층",

	-- Step 51: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle
	["{npc:234}, at the top of the tower"] = "{npc:234}, 탑 꼭대기",

	-- Step 52: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20}와(과) 데피아즈단 언덕",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "데피아즈단 길잡이와 너클더스트가 {area:20}을(를) 걷고, 고속도로 강도(17레벨)가 그 남쪽과 동쪽 언덕을 두 명씩 순찰합니다: 따로 유인하세요. 대장간의 {area:1581} 입구는 파티 던전입니다.\n주의: 언덕의 야영지에는 데피아즈단 무리가 섞여 있어, 레벨이 낮으면 한 번에 여러 마리를 끌어들이기 쉽습니다.",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}, {area:20} 주변 상자에서",

	-- Step 53: The Defias Messenger
	-- {npc:550} Defias Messenger
	["The {npc:550}"] = "{npc:550}",
	-- {area:20} Moonbrook · {npc:550} Defias Messenger · {area:113} Gold Coast Quarry · {area:111} Jangolode Mine
	["South along the road to {area:20}. The {npc:550} starts in front of the {area:20} smithy and walks north to the {area:113} and the back of the {area:111}, then back: look along his road. Slow him when he runs at 30% health."] = "남쪽 길을 따라 {area:20}까지 가세요. {npc:550}은(는) {area:20} 대장간 앞에서 시작해 {area:113}과 {area:111} 뒤쪽까지 북쪽으로 걸었다가 되돌아옵니다: 그의 길을 따라 보세요. 생명력 30%에서 도망가면 둘러싸세요.",
	-- {item:1381} A Mysterious Message · {npc:550} Defias Messenger
	["{item:1381}: the {npc:550}"] = "{item:1381}: {npc:550}",

	-- Step 54: Half Pendant of Aquatic Endurance
	-- {area:113} Gold Coast Quarry · {object:177790} Strange Lockbox
	["Druids on Trial of the Sea Lion: from the {area:113}, west to the shore and north along it. The {object:177790} lies on the sea floor off the coast (about 18,33); then back south along the coast to the lighthouse."] = "바다사자의 시험 중인 드루이드: {area:113}에서 서쪽 해안으로 가서 해안을 따라 북쪽으로 가십시오. {object:177790}은(는) 앞바다 해저(약 18,33)에 있습니다. 그런 다음 해안을 따라 남쪽 등대로 돌아가십시오.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}: the {object:177790}"] = "{item:15882}: {object:177790}",

	-- Step 55: Westfall Lighthouse
	-- {area:20} Moonbrook · {npc:392} Captain Grayson · {npc:391} Old Murk-Eye
	["South-west from {area:20} to the lighthouse on the point: {npc:392} waits on its steps. {npc:391} walks the beach and the shallows north-east of it among the murlocs: pull him away from the Oracles."] = "{area:20}에서 남서쪽으로 곶의 등대까지 가세요: {npc:392}은(는) 그 계단에서 기다립니다. {npc:391}은(는) 그 북동쪽 해변과 여울에서 멀록 사이를 걷습니다: 예언자들에서 그를 떼어내세요.",
	-- {item:3636} Scale of Old Murk-Eye · {npc:391} Old Murk-Eye
	["{item:3636}: {npc:391}, on the beach north-east of the lighthouse"] = "{item:3636}: {npc:391}, 등대 북동쪽 해변",

	-- Step 56: Captain Grayson
	-- {zone:1436} Westfall · {npc:392} Captain Grayson
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Kept five Flasks of Oil from {zone:1436}'s Harvest Watchers? {npc:392} takes them for his lighthouse fire."] = "{zone:1436}의 수확 감시자에게서 기름 병 다섯 개를 남겨 두었나요? {npc:392}이(가) 등대 불을 위해 그것을 가져갑니다.",

	-- Step 57: Sentinel Hill
	-- {area:108} Sentinel Hill · {npc:467} The Defias Traitor
	["Back north up the road to {area:108}. {npc:467} waits at the foot of the tower ramp; if he is missing, someone is escorting him and he is back within minutes."] = "길을 따라 북쪽 {area:108}까지 돌아가세요. {npc:467}은(는) 탑 경사로 아래에서 기다립니다; 그가 없으면 누군가 그를 호위 중이며 몇 분 안에 돌아옵니다.",

	-- Step 58: The Defias Traitor
	-- {area:20} Moonbrook
	["Stay with the traitor as he walks south to {area:20}; he does not stop for fights, so clear what follows him. His walk ends at the Defias hideout below {area:20}."] = "배신자가 {area:20}으로 남쪽으로 걷는 동안 그와 함께 있으세요; 그는 전투 때문에 멈추지 않으니, 그를 따르는 것들을 정리하세요. 그의 행군은 {area:20} 아래의 데피아즈단 은신처에서 끝납니다.",
	-- {npc:467} The Defias Traitor
	["{npc:467}, at the foot of the tower ramp"] = "{npc:467}, 탑 경사로 아래",

	-- Step 59: Gryan Stoutmantle
	-- {npc:234} Gryan Stoutmantle · {area:1581} The Deadmines · {npc:639} Edwin VanCleef · {npc:820} Scout Riell · {quest:214} Red Silk Bandanas
	["Back north to {npc:234}. For your {area:1581} run he then sends you after {npc:639}, and {npc:820}, beside him at the top of the tower, wants {quest:214}. Look for a group now if you have none yet."] = "북쪽 {npc:234}에게 돌아가십시오. {area:1581} 공략을 위해 그가 {npc:639}을(를) 쫓으라고 보내며, 탑 꼭대기 그의 옆에 있는 {npc:820}은(는) {quest:214}을(를) 원합니다. 아직 파티가 없다면 지금 구하십시오.",
	-- {npc:820} Scout Riell
	["{npc:820}, at the top of the tower"] = "{npc:820}, 탑 꼭대기",

	-- Step 60: The Deadmines
	-- {area:1581} The Deadmines · {area:20} Moonbrook · {quest:214} Red Silk Bandanas · {npc:639} Edwin VanCleef · {zone:1453} Stormwind
	["{area:1581} is a dungeon for a group of five, about levels 17 to 24, and a full run takes about an hour. Its door is the mine below {area:20}, where the traitor led you: the portal is at the far end of the mine's tunnels.\nInside: the Defias drop the {quest:214}, and {npc:639} waits on the ship at the end. Open the Unsent Letter he drops: its quest goes to {zone:1453}, where this guide hands it in."] = "{area:1581}은(는) 약 17~24레벨 5인 파티용 던전이며, 전체 공략에 약 1시간이 걸립니다. 입구는 배신자가 당신을 데려갔던 {area:20} 아래 광산입니다. 차원문은 광산 터널 맨 끝에 있습니다.\n내부: 데피아즈단이 {quest:214}을(를) 떨어뜨리고, {npc:639}은(는) 끝의 배에서 기다립니다. 그가 떨어뜨리는 부치지 않은 편지를 여십시오. 그 퀘스트는 {zone:1453}(으)로 이어지며, 이 가이드가 그곳에서 제출합니다.",
	-- {item:915} Red Silk Bandana
	["{item:915}: the Defias"] = "{item:915}: 데피아즈단",

	-- Step 61: Gryan Stoutmantle
	-- {area:108} Sentinel Hill · {npc:234} Gryan Stoutmantle
	["Out of the mine and north up the road to {area:108}: {npc:234} stands at the top of the tower."] = "광산에서 나와 길을 따라 북쪽 {area:108}(으)로 가십시오. {npc:234}은(는) 탑 꼭대기에 서 있습니다.",

	-- Step 62: Scout Riell
	-- {npc:820} Scout Riell · {area:108} Sentinel Hill
	["{npc:820} keeps watch at the top of the {area:108} tower."] = "{npc:820}은(는) {area:108} 탑 꼭대기에서 망을 보고 있습니다.",

	-- Step 63: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "{area:69}(으)로 비행",

	-- Step 64: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle
	["Back north to {npc:234} and the gryphons."] = "북쪽 {npc:234}와(과) 그리폰으로 돌아가세요.",

	-- Step 65: Lakeshire
	-- {npc:415} Verner Osgood · {npc:344} Magistrate Solomon
	["From the gryphons, over the bridge into town: {npc:415} by the smithy, {npc:344} in the town hall."] = "그리폰에서 다리를 건너 마을로 들어가세요: {npc:415}는(은) 대장간 옆에, {npc:344}는(은) 시청 안에 있습니다.",
	-- {npc:344} Magistrate Solomon
	["{npc:344}, in the town hall"] = "{npc:344}, 마을 회관 안",

	-- Step 66: Redridge Canyons
	-- {spell:133} Fireball
	-- plural, as words: Redridge Brutes = {npc:426} Redridge Brute · Iron Pikes = {item:2856} Iron Pike · Black Dragon Whelps = {npc:441} Black Dragon Whelp
	["Redridge Brutes and Mystics hold the hills north and north-west of town; both carry the Iron Pikes and Rivets. Black Dragon Whelps nest in the same hills.\nCareful: The whelps cast {spell:133} from range, and the gnolls run for help at low health."] = "레드릿지 깡패와 신비주의자가 마을 북쪽과 북서쪽 언덕을 지키고 있습니다; 둘 다 철 창과 리벳을 지니고 있습니다. 새끼 검은용이 같은 언덕에 둥지를 틉니다.\n주의: 새끼용은 원거리에서 {spell:133}을(를) 시전하고, 놀은 생명력이 낮으면 도움을 부르러 달아납니다.",
	-- {item:1221} Underbelly Whelp Scale
	-- plural, as words: Black Dragon Whelps = {npc:441} Black Dragon Whelp
	["{item:1221}: Black Dragon Whelps"] = "{item:1221}: 새끼 검은용",

	-- Step 67: Lakeshire
	-- {npc:415} Verner Osgood · {npc:341} Foreman Oslow · {npc:381} Dockmaster Baren
	["Back down into town: {npc:415} by the smithy, {npc:341} at the north end of the bridge, {npc:381} on the docks."] = "다시 마을 아래로 들어가세요: {npc:415}는(은) 대장간 옆에, {npc:341}은(는) 다리 북쪽 끝에, {npc:381}은(는) 부두에 있습니다.",
	-- {npc:381} Dockmaster Baren
	["{npc:381}, on the docks: the murlocs are for your next Redridge visit"] = "{npc:381}, 부두 위: 멀록은 다음 레드릿지 방문을 위한 것입니다",

	-- Step 68: Fly to Stormwind
	-- {area:442} Auberdine · {zone:1439} Darkshore · {zone:1453} Stormwind
	["Back to {area:442} for {zone:1439}'s southern loops: the gryphon to {zone:1453}, then the boat from the harbour. Hearthstone ready (bound in {area:442} since the first {zone:1439} visit)? Use it instead: these steps drop once you are in {zone:1439}."] = "{zone:1439}의 남부 순환을 위해 {area:442}로 돌아가세요: 그리폰으로 {zone:1453}(으)로 가고, 이어서 항구에서 배를 타세요. 귀환석 준비됐나요(첫 {zone:1439} 방문 때 {area:442}에 묶였습니다)? 대신 사용하세요: 이 단계들은 {zone:1439}에 들어오면 사라집니다.",
	-- {area:69} Lakeshire
	["{area:69} flight master"] = "{area:69} 비행 조련사",

	-- Step 70: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:28027} Dwarven District
	["{npc:1646} stands at the east side of {object:2098}, on the way from the {object:28027} to the harbour."] = "{npc:1646}은(는) {object:28027}에서 항구로 가는 길, {object:2098} 동쪽에 서 있습니다.",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: {area:442}에서 온 툰드리스의 편지",
	-- {npc:3649} Thundris Windweaver
	["For {npc:3649}, where the boat lands"] = "{npc:3649}에게 줄 것, 배가 도착하는 곳",

	-- Step 71: Gazin Tenorm
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall · {object:2098} Cathedral Square
	["{npc:6173} and {npc:6171} are in the Cathedral of Light, on {object:2098}, on the way to the harbour."] = "{npc:6173}와 {npc:6171}은(는) {object:2098}, 빛의 대성당 안에 있으며 항구로 가는 길에 있습니다.",
	["Cathedral of Light"] = "빛의 대성당",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}: 구원",

	-- Step 72: Class trainer
	["Class trainer"] = "직업 상급자",
	-- {object:2100} Old Town · {object:2101} Mage Quarter · {object:28027} Dwarven District
	["Train on the way to the harbour: {object:2100} (Warriors, Rogues), the Cathedral of Light (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:28027} (Hunters)."] = "항구로 가는 길에 훈련하십시오: {object:2100}(전사, 도적), 빛의 대성당(성기사, 사제), {object:2101}(마법사, 흑마법사), {object:28027}(사냥꾼).",

	-- Step 73: Baros Alexston
	-- {npc:1646} Baros Alexston · {quest:389} Bazil Thredd · {area:717} Stockade
	["{npc:1646}, the city architect, is on your way west to the harbour. His next errand, {quest:389}, leads into the {area:717}: it is for a {area:717} run at about 29, so leave it unless you chose that dungeon."] = "도시 건축가 {npc:1646}은(는) 서쪽 항구로 가는 길에 있습니다. 그의 다음 심부름인 {quest:389}은(는) {area:717}(으)로 이어집니다. 약 29레벨의 {area:717} 공략용이므로, 그 던전을 고르지 않았다면 받지 마십시오.",

	-- Step 74: Baros Alexston
	-- {area:717} Stockade · {zone:1453} Stormwind
	["For your {area:717} run, later in {zone:1453}: keep it until then."] = "{area:717} 공략용(나중에 {zone:1453}에서): 그때까지 보관하십시오.",
	-- {npc:1646} Baros Alexston · {npc:1719} Warden Thelwater · {area:717} Stockade
	["{npc:1646}: for {npc:1719}, at the {area:717}'s gate"] = "{npc:1646}: {area:717} 입구의 {npc:1719}에게",
}
