-- Korean (koKR): the guide forever/alliance/human/01-elwynn-forest (forever/alliance/human/01-elwynn-forest.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Northshire Abbey
	-- {npc:823} Deputy Willem · {npc:197} Marshal McBride · {npc:951} Brother Paxton · {npc:247229} Daniel · {npc:196} Eagan Peltskinner
	["You start in front of the Abbey. {npc:823} stands at the foot of the steps, {npc:197} inside the hall, {npc:951} and {npc:247229} in the library to the right, {npc:196} outside the north-west corner."] = "대성당 앞에서 시작합니다. {npc:823}은(는) 계단 아래에, {npc:197}은(는) 홀 안에, {npc:951}와(과) {npc:247229}은(는) 오른쪽 도서관에, {npc:196}은(는) 북서쪽 모퉁이 밖에 있습니다.",
	-- {npc:459} Drusilla La Salle
	["{npc:459}, outside the Abbey"] = "{npc:459}, 대성당 밖",

	-- Step 2: Wolves
	["Wolves"] = "늑대",
	["Young Wolves and Timber Wolves roam the fields right around the Abbey."] = "새끼 늑대와 회색 늑대가 대성당 바로 주변 들판을 돌아다닙니다.",

	-- Step 3: Eagan Peltskinner
	-- {npc:823} Deputy Willem
	["{npc:823}, back at the Abbey steps"] = "{npc:823}, 대성당 계단으로 돌아가기",

	-- Step 4: The kobold camp
	["The kobold camp"] = "코볼트 야영지",
	-- {npc:6} Kobold Vermin · {quest:91741} Nibbled-On Book
	["{npc:6} dig in the vineyards north-east of the Abbey. Now and then one drops a {quest:91741}: right-click it."] = "{npc:6}이(가) 대성당 북동쪽 포도밭을 파헤치고 있습니다. 가끔 {quest:91741}을(를) 떨어뜨리니 오른쪽 클릭하십시오.",

	-- Step 5: Northshire Abbey
	-- {npc:247229} Daniel
	["{npc:247229}, in the library"] = "{npc:247229}, 도서관 안",

	-- Step 6: Echo Ridge Mine
	-- {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["Follow the path north to the mine. Kobold Workers swarm outside it; every kobold in the valley can drop the {object:83763}."] = "길을 따라 북쪽 광산으로 가십시오. 코볼트 잡역부가 광산 밖에 몰려 있으며, 골짜기의 모든 코볼트가 {object:83763}을(를) 떨어뜨릴 수 있습니다.",

	-- Step 7: Northshire Abbey
	-- {npc:911} Llane Beshere
	["{npc:911}, the warrior trainer"] = "{npc:911}, 전사 상급자",
	-- {npc:925} Brother Sammuel
	["{npc:925}, the paladin trainer"] = "{npc:925}, 성기사 상급자",
	-- {npc:248415} Tordrin Sternblade
	["{npc:248415}, by the Abbey"] = "{npc:248415}, 대성당 옆",
	-- {npc:915} Jorik Kerridan
	["{npc:915}, the rogue trainer"] = "{npc:915}, 도적 상급자",
	-- {npc:375} Priestess Anetta
	["{npc:375}, the priest trainer"] = "{npc:375}, 사제 상급자",
	-- {npc:198} Khelden Bremen
	["{npc:198}, the mage trainer, inside the Abbey"] = "{npc:198}, 마법사 상급자, 대성당 안",

	-- Step 8: The Defias camp
	["The Defias camp"] = "데피아즈단 야영지",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["Defias Thugs camp in the clearing east of the Abbey and along the valley's east side."] = "데피아즈단원이 대성당 동쪽 빈터와 골짜기 동쪽을 따라 야영하고 있습니다.",
	-- plural, as words: Red Burlap Bandanas = {item:752} Red Burlap Bandana
	["Red Burlap Bandanas"] = "붉은 삼베 복면",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}: the {object:83763} in the Defias camp"] = "{item:6785}: 데피아즈단 야영지의 {object:83763}",

	-- Step 10: Milly Osworth
	["She stands by her cart at the vineyard east of the Abbey."] = "그녀는 대성당 동쪽 포도밭의 수레 옆에 있습니다.",

	-- Step 11: The vineyards and Garrick Padfoot
	-- {npc:103} Garrick Padfoot
	["The vineyards and {npc:103}"] = "포도밭과 {npc:103}",
	-- {npc:103} Garrick Padfoot
	["The crates of grapes lie in the vineyards behind the Defias. {npc:103} waits by the cabin at the east end of the valley."] = "포도 상자는 데피아즈단 뒤쪽 포도밭에 있습니다. {npc:103}은(는) 골짜기 동쪽 끝 오두막 옆에서 기다립니다.",

	-- Step 13: Kelsey Fargo
	-- {npc:248362} Shinyfinder Narf
	["She stands outside the mine entrance. {npc:248362}, inside, is elite: grouping up is advised."] = "그녀는 광산 입구 밖에 있습니다. 안에 있는 {npc:248362}은(는) 정예이므로 파티를 권장합니다.",

	-- Step 14: Inside Echo Ridge Mine
	-- {area:34} Echo Ridge Mine
	["Inside {area:34}"] = "{area:34} 안",
	-- {npc:248362} Shinyfinder Narf
	-- plural, as words: Kobold Laborers = {npc:80} Kobold Laborer
	["Kobold Laborers work the tunnels inside the mine. {npc:248362} waits down the second turn on the right."] = "코볼트 일꾼이 광산 안 터널에서 일합니다. {npc:248362}은(는) 두 번째 오른쪽 굽이 아래에서 기다립니다.",

	-- Step 15: Northshire Abbey
	-- {npc:248415} Tordrin Sternblade
	["{npc:248415} stands behind the Abbey, by the stables."] = "{npc:248415}은(는) 대성당 뒤 마구간 옆에 있습니다.",
	-- {npc:952} Brother Neals
	["{npc:952}, upstairs"] = "{npc:952}, 위층",
	-- {area:87} Goldshire
	["his kobold tracker shows the kobolds to click on the road to {area:87}"] = "그의 코볼트 추적기가 {area:87}(으)로 가는 길에 클릭할 코볼트를 보여 줍니다",
	-- {npc:6774} Falkhaan Isenstrider
	["{npc:6774}, by the stables south of the Abbey"] = "{npc:6774}, 대성당 남쪽 마구간 옆",

	-- Step 16: Goldshire
	-- {area:87} Goldshire · {npc:295} Innkeeper Farley · {npc:240} Marshal Dughan · {npc:253} William Pestle · {npc:241} Remy "Two Times"
	["Follow the road south out of the valley to {area:87}. {npc:295} is in the Lion's Pride Inn; {npc:240} stands outside the smithy across the road, {npc:253} at the inn's front and {npc:241} by the road south of it."] = "길을 따라 남쪽으로 골짜기를 빠져나가 {area:87}(으)로 가십시오. {npc:295}은(는) 사자무리 여관에, {npc:240}은(는) 길 건너 대장간 밖에, {npc:253}은(는) 여관 앞에, {npc:241}은(는) 그 남쪽 길가에 있습니다.",

	-- Step 17: The lake shore
	["The lake shore"] = "호숫가",
	-- {npc:263399} Sam Sarsaparilla · {npc:6306} Helene Peltskinner · {npc:383} Jason Mathers · {npc:1651} Lee Brown · {area:18} Crystal Lake
	["{npc:263399} camps north-east of the inn; {npc:6306}, {npc:383} and {npc:1651} stand on the shore of {area:18} east of town."] = "{npc:263399}은(는) 여관 북동쪽에 야영하고 있으며, {npc:6306}, {npc:383}, {npc:1651}은(는) 마을 동쪽 {area:18} 호숫가에 있습니다.",
	-- {spell:1229451} Boosted Rest
	["Sit (/sit) by his campfire until you have {spell:1229451}"] = "{spell:1229451} 효과를 얻을 때까지 그의 모닥불 옆에 앉으세요(/앉기)",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}: skinners only, the pelts are skinned"] = "{npc:6306}: 무두질 전용, 가죽은 무두질로 얻습니다",

	-- Step 18: Crystal Lake
	-- plural, as words: Fishing Traps = {object:694772} Fishing Trap
	["The Fishing Traps sit along the west shore of the lake."] = "{object:694772}은(는) 호수 서쪽 기슭을 따라 놓여 있습니다.",

	-- Step 20: The murloc camp
	["The murloc camp"] = "멀록 야영지",
	-- plural, as words: Murloc Streamrunners = {npc:735} Murloc Streamrunner · Junk Piles = {object:694785} Junk Pile
	["Murlocs and Murloc Streamrunners hold the east shore; the Junk Piles lie in their camp."] = "멀록과 멀록 길잡이가 동쪽 기슭을 차지하고 있으며, 잡동사니 더미는 그들의 야영지에 있습니다.",

	-- Step 22: Goldshire
	-- {npc:1430} Tomas
	["{npc:1430} cooks in the inn's kitchen."] = "{npc:1430}은(는) 여관 부엌에서 요리합니다.",
	-- {npc:1430} Tomas
	["Speak with {npc:1430}"] = "{npc:1430}와(과) 대화",

	-- Step 23: Maybell Maclure
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {npc:251} Maybell Maclure
	["Follow the road south out of {area:87} to the {area:64}. {npc:251} waits by the house."] = "길을 따라 남쪽으로 {area:87}을(를) 빠져나가 {area:64}(으)로 가십시오. {npc:251}이(가) 집 옆에서 기다립니다.",

	-- Step 24: The Fargodeep Mine
	-- {npc:248464} Nimsy
	-- plural, as words: Kobold Miners = {npc:40} Kobold Miner
	["The mine is west of the vineyards. Kobold Miners and Tunnelers fill both levels; {npc:248464}, a named kobold, holds the picture book in the lower tunnels. {npc:248464} is elite: grouping up is advised."] = "광산은 포도밭 서쪽에 있습니다. 코볼트 광부와 코볼트 굴착꾼이 두 층 모두에 가득합니다. 이름 있는 코볼트 {npc:248464}이(가) 아래쪽 터널에서 그림책을 가지고 있습니다. {npc:248464}은(는) 정예이므로 파티를 권장합니다.",
	["Walk through the mine"] = "광산 안을 걸어가기",
	-- plural, as words: Large Candles = {item:772} Large Candle
	["Large Candles"] = "큰 양초",
	-- plural, as words: Lost Books = {item:248001} Lost Book · Kobold Miners = {npc:40} Kobold Miner
	["Lost Books: Kobold Miners and Tunnelers"] = "잃어버린 책: 코볼트 광부와 코볼트 채굴꾼",
	-- {npc:248464} Nimsy
	["Fun with Elementals: {npc:248464}"] = "그림책: 정령과 놀기: {npc:248464}",

	-- Step 25: Bait ingredients
	["Bait ingredients"] = "미끼 재료",
	-- {object:694855} Overgrown Duskweed
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood."] = "{object:694855}은(는) 포도밭과 스톤필드 농장 주변 밭에서 자라며, 주변의 돌엄니멧돼지가 피를 줍니다.",
	-- {item:286215} Vial of Animal Blood
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{item:286215}: Stonetusk Boars"] = "{item:286215}: 돌엄니멧돼지",

	-- Step 26: The Stonefield Farm
	["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house."] = "스톤필드 농장은 광산 서쪽에 있습니다. 스톤필드 부인과 버니스 \"아줌마\"가 집 옆에 있습니다.",

	-- Step 27: Tommy Joe Stonefield
	["He stands by the river west of the farm."] = "그는 농장 서쪽 강가에 있습니다.",

	-- Step 28: Gramma Stonefield
	["She sits inside the farmhouse."] = "그녀는 농가 안에 앉아 있습니다.",

	-- Step 29: Billy Maclure
	-- {area:64} Maclure Vineyards
	["Billy plays in the {area:64}, east of the mine."] = "빌리는 광산 동쪽 {area:64}에서 놀고 있습니다.",

	-- Step 30: Boar meat
	["Boar meat"] = "멧돼지 고기",
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["Stonetusk Boars graze between the vineyards and the farm."] = "돌엄니멧돼지가 포도밭과 농장 사이에서 풀을 뜯습니다.",
	["Chunks of Boar Meat"] = "멧돼지 고기",

	-- Step 31: "Auntie" Bernice Stonefield
	["\"Auntie\" Bernice Stonefield"] = "버니스 \"아줌마\" 스톤필드",

	-- Step 33: Goldtooth
	-- {quest:87} Goldtooth · {area:57} Fargodeep Mine · {item:1972} Westfall Deed
	-- plural, as words: Defias Bandits = {npc:116} Defias Bandit
	["{quest:87} is inside the {area:57}, not on the hill above it: go in at the mouth and keep left to the back of the mine floor; don't take the stairs up. Defias Bandits around the vineyards drop a {item:1972} now and then: right-click it."] = "{quest:87}은(는) 언덕 위가 아니라 {area:57} 안에 있습니다. 입구로 들어가 왼쪽을 따라 광산 바닥 안쪽까지 가십시오. 위층 계단은 오르지 마십시오. 포도밭 주변의 데피아즈단 좀도둑이 가끔 {item:1972}을(를) 떨어뜨리니 오른쪽 클릭하십시오.",

	-- Step 34: Goldshire
	-- {npc:279} Morgan Pestle · {zone:1453} Stormwind
	["{npc:279} in {zone:1453} takes it (02-westfall)"] = "{zone:1453}의 {npc:279}이(가) 받습니다 (02-westfall)",

	-- Step 35: Crystal Lake and the wolves
	-- {area:18} Crystal Lake
	["{area:18} and the wolves"] = "{area:18}와(과) 늑대",
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler
	["The murlocs on the east shore drop the kelp. Skinners: Gray Forest Wolves roam the woods between the lake and the {area:91}; Prowlers further east give pelts too."] = "동쪽 기슭의 멀록이 해초를 떨어뜨립니다. 무두질: 회색 숲늑대가 호수와 {area:91} 사이 숲을 돌아다니며, 더 동쪽의 굶주린 늑대도 가죽을 줍니다.",
	-- plural, as words: Crystal Kelp Fronds = {item:1256} Crystal Kelp Frond
	["Crystal Kelp Fronds"] = "투명한 해초 잎",

	-- Step 36: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["{npc:248242} and {npc:248248} stand at the foot of the tower."] = "{npc:248242}와(과) {npc:248248}은(는) 탑 아래에 있습니다.",

	-- Step 37: The bridge
	["The bridge"] = "다리",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it."] = "{npc:261}이(가) 동쪽 길의 다리를 지키며, {npc:248265}은(는) 바로 건너편에 있습니다.",

	-- Step 38: Downstream and Princess
	-- {quest:91733} Downstream · {npc:330} Princess
	["{quest:91733} and {npc:330}"] = "{quest:91733}와(과) {npc:330}",
	-- {item:247813} Waterlogged Saw · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch · {npc:390} Porcine Entourage
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way."] = "{item:247813}, 도끼, 연장통은 다리 남쪽 강에 있습니다. 큰 멧돼지인 {npc:330}은(는) 강 서쪽 {area:62}에서 {npc:390}와(과) 함께 땅을 파헤칩니다. 새끼 돼지부터 떼어 내십시오. 가는 길에 굶주린 늑대와 새끼 숲곰을 처치하십시오.",

	-- Step 40: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "야영지는 다리 북동쪽에 있습니다. 장작 더미는 야영지 주변과 북쪽 숲에 있습니다.",

	-- Step 41: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "벌목장 북서쪽 강가에 있습니다.",

	-- Step 42: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "데피아즈단 견습마술사가 {area:86} 기슭에 야영하며, 붉은 리넨 복면도 떨어뜨립니다. {object:56}은(는) 북동쪽 기슭의 멀록 마을에 있습니다.",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "붉은 리넨 복면",

	-- Step 43: The gnoll camps
	["The gnoll camps"] = "놀 야영지",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "갈퀴발일족 놀이 {area:86} 서쪽 언덕에 야영하며, {quest:91725}은(는) 그들의 야영지에 있습니다.",

	-- Step 44: The Jasperlode Mine's entrance
	-- {quest:76} The Jasperlode Mine
	["{quest:76}'s entrance"] = "{quest:76} 입구",

	-- Step 45: The Jasperlode Mine
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "광산은 놀 야영지 남서쪽에 있습니다. {item:247816}은(는) 입구 근처에 있으며, 코볼트 흙점쟁이가 터널을 차지하고 있습니다.",
	["Walk into the mine"] = "광산 안으로 걸어가기",

	-- Step 46: The Tower of Azora
	["Follow the hills south to the tower."] = "언덕을 따라 남쪽 탑으로 가십시오.",

	-- Step 48: Goldshire
	-- {area:87} Goldshire · {npc:6306} Helene Peltskinner
	["Follow the road west back to {area:87}; {npc:6306} and Jason stand on the lake shore before town."] = "길을 따라 서쪽 {area:87}(으)로 돌아가십시오. {npc:6306}와(과) 제이슨은 마을 앞 호숫가에 있습니다.",

	-- Step 49: Maybell Maclure
	-- {area:64} Maclure Vineyards
	["South down the road to the {area:64}."] = "길을 따라 남쪽 {area:64}(으)로 가십시오.",

	-- Step 50: The Stonefield Farm
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Shiny Red Apples, from {npc:894}, for the {quest:91736}"] = "윤기나는 빨간 사과, {npc:894}에게서, {quest:91736}용",

	-- Step 51: The Applejack Still
	-- {quest:91736} Applejack Still
	["The {quest:91736}"] = "{quest:91736}",
	-- {quest:91736} Applejack Still · {area:120} Westbrook Garrison · {item:247824} Thunder Applejack
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Head north-west across the fields to the {quest:91736}, north of the {area:120}. Hand it four Shiny Red Apples for a {item:247824}."] = "들판을 가로질러 북서쪽, {area:120} 북쪽의 {quest:91736}(으)로 가십시오. 윤기나는 빨간 사과 네 개를 넣으면 {item:247824}이(가) 나옵니다.",
	-- {item:247824} Thunder Applejack
	["{item:247824}, from the still"] = "{item:247824}, 증류기에서",

	-- Step 52: Westbrook Garrison
	-- {area:120} Westbrook Garrison · {zone:1436} Westfall · {npc:963} Deputy Rainer · {npc:955} Sergeant De Vries
	["Back south to the {area:120}, by the road to {zone:1436}. {npc:963} stands outside the barracks, {npc:955} beside him."] = "{zone:1436}(으)로 가는 길가의 {area:120}(으)로 남쪽으로 돌아가십시오. {npc:963}은(는) 병영 밖에, {npc:955}은(는) 그 옆에 있습니다.",
	-- {npc:955} Sergeant De Vries · {item:247824} Thunder Applejack
	["{npc:955}: he wants your {item:247824}"] = "{npc:955}: {item:247824}을(를) 원합니다",

	-- Step 53: Forest's Edge
	-- {zone:1436} Westfall · {npc:100} Gruff Swiftbite · {item:1307} Gold Pickup Schedule
	-- plural, as words: Riverpaw Runts = {npc:97} Riverpaw Runt
	["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border. {npc:100}, a level 12 gnoll, walks among them and carries the {item:1307}: right-click it."] = "갈퀴발일족 심부름꾼과 갈퀴발일족 길잡이가 주둔지 남쪽, {zone:1436} 경계를 따라 언덕을 차지하고 있습니다. 12레벨 놀 {npc:100}이(가) 그들 사이를 걸으며 {item:1307}을(를) 가지고 있으니 오른쪽 클릭하십시오.",
	-- plural, as words: Painted Gnoll Armbands = {item:782} Painted Gnoll Armband
	["Painted Gnoll Armbands"] = "놀의 화려한 완장",

	-- Step 56: Guard Thomas
	-- {area:91} Tower of Azora
	["Follow the road east past the {area:91} to the bridge."] = "길을 따라 동쪽으로 {area:91}을(를) 지나 다리로 가십시오.",

	-- Step 57: Murlocs and the Collector
	["Murlocs and the Collector"] = "멀록과 수집가",
	-- {npc:473} Morgan the Collector · {area:62} Brackwell Pumpkin Patch
	-- plural, as words: Murloc Foragers = {npc:46} Murloc Forager · Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way."] = "멀록 채집꾼과 멀록 잠복꾼이 다리 남쪽 강을 따라 있습니다. 데피아즈단인 {npc:473}이(가) 그 서쪽 {area:62}을(를) 돌아다닙니다. 가는 길에 굶주린 늑대와 새끼곰을 마저 처치하십시오.",
	-- plural, as words: Torn Murloc Fins = {item:780} Torn Murloc Fin
	["Torn Murloc Fins"] = "찢어진 멀록 지느러미",

	-- Step 60: Stone Cairn Lake
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["North-east of the logging camp. Defias Rogue Wizards camp on the shores of the lake."] = "벌목장 북동쪽입니다. 데피아즈단 견습마술사가 호숫가에 야영하고 있습니다.",

	-- Step 61: The Tower of Azora
	["Follow the hills south to the tower, on the road west."] = "언덕을 따라 남쪽, 서쪽 길가의 탑으로 가십시오.",

	-- Step 62: Goldshire
	-- {area:87} Goldshire
	["Follow the road west back to {area:87}."] = "길을 따라 서쪽 {area:87}(으)로 돌아가십시오.",
	-- {npc:6121} Remen Marcot · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6121}: {npc:6122} in {zone:1453} takes it"] = "{npc:6121}: {zone:1453}의 {npc:6122}이(가) 받습니다",
	-- {npc:927} Brother Wilhelm · {npc:6171} Duthorian Rall · {zone:1453} Stormwind
	["{npc:927}: {npc:6171} in {zone:1453} takes it"] = "{npc:927}: {zone:1453}의 {npc:6171}이(가) 받습니다",
	-- {npc:377} Priestess Josetta · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:377}: {npc:376} in {zone:1453} takes both"] = "{npc:377}: {zone:1453}의 {npc:376}이(가) 둘 다 받습니다",
	-- {npc:328} Zaldimar Wefhellt · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{npc:328}: {npc:5497} in {zone:1453} takes it"] = "{npc:328}: {zone:1453}의 {npc:5497}이(가) 받습니다",

	-- Step 63: Taming the Beast
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {item:15908} Taming Rod · {area:64} Maclure Vineyards · {area:18} Crystal Lake
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar · Young Forest Bears = {npc:822} Young Forest Bear
	["{npc:251507} stands with the {area:87} trainers. Each of her quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her. Rockhide Boars and Young Forest Bears roam the hills south of the {area:64}, Gray Forest Wolves the woods east of {area:18}."] = "{npc:251507}은(는) {area:87} 상급자들과 함께 있습니다. 퀘스트마다 {item:15908}을(를) 주니, 지정한 야수에게 사용한 뒤 막대를 그녀에게 가져가십시오. 돌가죽멧돼지와 새끼곰은 {area:64} 남쪽 언덕에, 회색 숲늑대는 {area:18} 동쪽 숲에 있습니다.",
	-- {npc:524} Rockhide Boar · {item:15908} Taming Rod
	["{npc:524}: tame it with the {item:15908}"] = "{npc:524}: {item:15908}(으)로 길들이기",
	-- {npc:1922} Gray Forest Wolf · {item:15908} Taming Rod
	["{npc:1922}: tame it with the {item:15908}"] = "{npc:1922}: {item:15908}(으)로 길들이기",
	-- {npc:822} Young Forest Bear · {item:15908} Taming Rod
	["{npc:822}: tame it with the {item:15908}"] = "{npc:822}: {item:15908}(으)로 길들이기",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}, 그녀 옆: {spell:5149}",

	-- Step 64: Jennea Cannon
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:5497} Jennea Cannon · {object:2101} Mage Quarter (no name in this language: may be words) · {quest:1861} Mirror Lake
	["Follow the road north from {area:87} into {zone:1453}. {npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "길을 따라 북쪽으로 {area:87}에서 {zone:1453}(으)로 가십시오. {npc:5497}은(는) {object:2101}의 탑인 마법사의 성소에 있으며, {quest:1861} 폭포용 플라스크를 줍니다.",

	-- Step 65: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "정문으로 {zone:1453}을(를) 나가십시오. {quest:1861} 폭포는 성문 남서쪽, 서쪽 {zone:1436}(으)로 가는 길에 있습니다. 폭포 아래에서 {item:7207}을(를) 채우십시오.",

	-- Step 66: Gakin the Darkbinder
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb (no name in this language: may be words) · {object:2101} Mage Quarter (no name in this language: may be words)
	["Follow the road north from {area:87} into {zone:1453}. {npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "길을 따라 북쪽으로 {area:87}에서 {zone:1453}(으)로 가십시오. {npc:6122}은(는) {object:2101} {object:2164}의 지하실에서 기다립니다.",

	-- Step 67: Surena Caledon
	-- {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Ride back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "{area:87}을(를) 지나 다시 나가 동쪽 길을 따라 {area:62}(으)로 가십시오. {npc:881}(9레벨)은(는) 농가 옆에 있습니다.",

	-- Step 68: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb (no name in this language: may be words)
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls."] = "{npc:6122}에게 돌아가십시오. {object:2164} 지하실의 소환진에서 {item:6928}을(를) 사용하고 소환된 공허방랑자를 쓰러뜨리십시오.",
	["Subdue the voidwalker"] = "공허방랑자 제압",

	-- Step 69: The Tome of Divinity
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2100} Old Town (no name in this language: may be words) · {item:2589} Linen Cloth
	["Follow the road north from {area:87} into {zone:1453}. {npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in {object:2100} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "길을 따라 북쪽으로 {area:87}에서 {zone:1453}(으)로 가십시오. {npc:6171}와(과) {npc:6173}은(는) 빛의 대성당에 있으며, {npc:6174}은(는) {object:2100}에서 {item:2589} 10개를 요구합니다(인간형 몹이 떨어뜨리고, 경매장에서도 판매합니다).",
	-- {quest:2998} Tome of Divinity
	["From the {quest:2998} he gives you"] = "그가 주는 {quest:2998}에서",

	-- Step 70: Henze Faulk
	-- {area:87} Goldshire · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["Ride back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "{area:87}을(를) 지나 다시 나가 동쪽 {area:86}(으)로 가십시오. {npc:6172}은(는) 호수 남쪽에 쓰러져 있으니 {item:6866}을(를) 사용하십시오. 주변의 데피아즈단 견습마술사가 {item:6846}을(를) 가지고 있습니다.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "{npc:6172}에게 {item:6866} 사용",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: 데피아즈단 견습마술사",

	-- Step 71: Gazin Tenorm
	["Back to the Cathedral of Light."] = "빛의 대성당으로 돌아가십시오.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}: 구원",

	-- Step 72: Sentinel Hill
	-- {zone:1436} Westfall · {area:108} Sentinel Hill
	["Follow the road west past Westbrook into {zone:1436}, then south along it to {area:108}. Thor, the gryphon master, stands on the hill."] = "길을 따라 서쪽으로 서부 주둔지를 지나 {zone:1436}(으)로 간 뒤, 남쪽으로 따라가 {area:108}(으)로 가십시오. 그리폰 조련사 토르가 언덕 위에 있습니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Gakin. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls."] = "가킨에게 돌아가십시오. {object:2164} 지하실의 소환진에서 {item:6928}을(를) 사용하고 소환된 공허방랑자를 쓰러뜨리십시오.",
	-- ["Ride back out through {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "{area:87}을(를) 지나 다시 나가 동쪽 길을 따라 {area:62}(으)로 가십시오. {quest:1688}(9레벨)은(는) 농가 옆에 있습니다.",
	-- ["{area:57}'s mouth"] = "{area:57} 입구",
	-- ["{item:1006}: Princess"] = "{item:1006}: 공주",
}
