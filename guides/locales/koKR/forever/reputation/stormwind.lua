-- Korean (koKR): the guide forever/reputation/stormwind (forever/reputation/stormwind.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Stormwind Reputation"] = "스톰윈드 평판",
	-- {zone:1422} Western Plaguelands
	["Cloth, the {zone:1422}' cauldron quests and the Elwynn hubs: the quests pay most while you level."] = "옷감, {zone:1422}의 가마솥 퀘스트, 엘윈 허브: 레벨을 올리는 동안 퀘스트가 가장 많이 줍니다.",
	-- {faction:72} Stormwind
	["Exalted with {faction:72}: in Classic, other races may buy the horses"] = "{faction:72}과(와) 확고한 동맹: Classic에서는 다른 종족도 말을 살 수 있습니다",
	-- {faction:72} Stormwind · {area:3197} Chillwind Camp · {zone:1428} Burning Steppes
	["About 1,150 {faction:72} reputation from level 52-58 quests at {area:3197} and in the {zone:1428}"] = "{area:3197}과(와) {zone:1428}의 52~58레벨 퀘스트로 {faction:72} 평판 약 1,150",
	-- {faction:72} Stormwind · {area:717} Stockade
	["About 4,500 {faction:72} reputation from low-level quests in Elwynn and the {area:717}"] = "엘윈과 {area:717}의 저레벨 퀘스트로 {faction:72} 평판 약 4,500",

	-- Step 1: Clavicus Knavingham, the cloth quartermaster
	-- {npc:14722} Clavicus Knavingham
	["{npc:14722}, the cloth quartermaster"] = "{npc:14722}, 옷감 병참장교",
	-- {npc:14722} Clavicus Knavingham · {faction:72} Stormwind · {item:14047} Runecloth · {quest:7796} Additional Runecloth · {zone:1436} Westfall · {zone:1431} Duskwood · {zone:1422} Western Plaguelands · {zone:1428} Burning Steppes · {area:717} Stockade · {area:87} Goldshire · {zone:1455} Ironforge · {zone:1457} Darnassus
	["{npc:14722} takes cloth for {faction:72}. The arrow leads to him; he stands upstairs inside his building. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7796} pays 50 for every 20 {item:14047}, as often as you like. The Auction House is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do Elwynn (levels 1-10), {zone:1436} (10-18), Redridge (15-25) and {zone:1431} (20-30) while you level through them. After the donations come the level 52-58 quests of the {zone:1422} and the {zone:1428} (about 1,150), then the optional low-level hubs, best rate first: Northshire and the city errands (about 40 a minute at full value), the {area:717} (30), Eastvale and {area:87} (25). Every {faction:72} gain also gives a quarter as much to {zone:1455}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14722}이(가) {faction:72}을(를) 위해 옷감을 받습니다. 화살표가 그에게 이어집니다. 그는 자기 건물 안쪽 위층에 서 있습니다. 양모, 비단, 마법천, {item:14047}을(를) 각각 처음 60개씩 기부하면 한 번에 평판 150을 주고, {item:14047} 이후로는 {quest:7796}이(가) {item:14047} 20개당 50을 제한 없이 줍니다. 경매장이 옷감의 가장 빠른 수급처입니다. Classic에서는 퀘스트가 자신보다 최대 5레벨 낮을 때 정액을 주므로, 엘윈(1~10), {zone:1436}(10~18), 붉은마루(15~25), {zone:1431}(20~30)을(를) 레벨을 올리며 진행하세요. 기부 다음에는 {zone:1422}와 {zone:1428}의 52~58레벨 퀘스트(약 1,150)가 오고, 그다음 선택인 저레벨 허브, 가장 좋은 비율부터: 노스셔와 도시 잔업(정액 기준 분당 약 40), {area:717}(30), 이스트베일과 {area:87}(25). {faction:72}의 모든 획득량은 1~10레벨 시작 지역의 퀘스트를 제외하고 {zone:1455}, {zone:1457}, 노움리건 추방자에게 4분의 1을 더 줍니다. 유산 특성 외교관은 모든 획득량에 최대 10%를 더합니다.",
	-- {item:2592} Wool Cloth · {zone:1436} Westfall
	["{item:2592}: Defias, gnolls and kobolds in {zone:1436} and Redridge"] = "{item:2592}: {zone:1436}과(와) 붉은마루의 데피아즈단, 그놀, 코볼트",

	-- Step 2: Stormwind errands
	-- {faction:72} Stormwind
	["{faction:72} errands"] = "{faction:72} 잔업",
	-- {faction:72} Stormwind
	["Optional: four quick deliveries inside {faction:72} for 200 reputation in about five minutes. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "선택 사항: {faction:72} 안에서 약 5분에 평판 200짜리 빠른 배달 넷. Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. 이 단계를 건너뛰면 허브도 건너뛰게 됩니다.",

	-- Step 3: Northshire Valley
	-- {area:87} Goldshire · {npc:823} Deputy Willem · {npc:197} Marshal McBride · {area:24} Northshire Abbey
	["Optional: the Human start valley north of {area:87}: about 1,600 reputation in 40 minutes at 60, the best rate of the hubs. {npc:823} and {npc:197} stand at {area:24}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "선택 사항: {area:87} 북쪽의 인간 시작 계곡: 60에서 40분에 약 1,600 평판으로 허브 중 가장 좋은 비율입니다. {npc:823}과(와) {npc:197}이(가) {area:24}에 서 있습니다. Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. 이 단계를 건너뛰면 허브도 건너뛰게 됩니다.",

	-- Step 4: Northshire: kobolds, wolves and bandanas
	["Northshire: kobolds, wolves and bandanas"] = "노스셔: 코볼트, 늑대, 복면",
	-- {npc:6} Kobold Vermin · {item:247834} Nibbled-On Book
	["The {npc:6} dig at the camp north of the abbey; the wolves roam the valley; the Defias at the vineyard east of the abbey drop the bandanas. Keep any {item:247834} a kobold drops: it starts Forever's book chain."] = "{npc:6}은(는) 수도원 북쪽 야영지에서 땅을 파고, 늑대는 계곡을 떠돌며, 수도원 동쪽 포도밭의 데피아즈단이 복면을 떨어뜨립니다. 코볼트가 떨어뜨리는 {item:247834}은(는) 모두 보관하세요: Forever의 책 사슬을 시작합니다.",
	-- {item:247834} Nibbled-On Book
	["{item:247834}, from the kobolds"] = "{item:247834}, 코볼트에게서",

	-- Step 5: Northshire: back at the abbey
	["Northshire: back at the abbey"] = "노스셔: 수도원으로 돌아가기",

	-- Step 6: Northshire: the Nibbled-On Book
	-- {quest:91741} Nibbled-On Book
	["Northshire: the {quest:91741}"] = "노스셔: {quest:91741}",
	-- {quest:91741} Nibbled-On Book
	["Right-click the {quest:91741} a kobold dropped: it starts its quest."] = "코볼트가 떨어뜨린 {quest:91741}을(를) 우클릭하세요: 퀘스트가 시작됩니다.",

	-- Step 7: Northshire: Brother Paxton's books
	-- {npc:951} Brother Paxton
	["Northshire: {npc:951}'s books"] = "노스셔: {npc:951}의 책들",

	-- Step 8: Northshire: Echo Ridge, Garrick Padfoot and the vineyard
	-- {npc:103} Garrick Padfoot
	["Northshire: Echo Ridge, {npc:103} and the vineyard"] = "노스셔: 메아리 마루, {npc:103}, 포도밭",
	-- {area:34} Echo Ridge Mine · {npc:103} Garrick Padfoot · {quest:3904} Milly's Harvest · {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["The Kobold Workers are in {area:34} north of the abbey; {npc:103} stands in the Defias camp east of the vineyard; {quest:3904} crates lie in the vineyard; the rats carrying the {object:83763} run about the abbey grounds."] = "코볼트 잡역부은 수도원 북쪽 {area:34}에 있고, {npc:103}은(는) 포도밭 동쪽 데피아즈단 야영지에 서 있으며, {quest:3904} 상자는 포도밭에 놓여 있고, {object:83763}을(를) 가지고 다니는 쥐들이 수도원 터를 돌아다닙니다.",

	-- Step 9: Northshire: second hand-in
	["Northshire: second hand-in"] = "노스셔: 두 번째 반납",

	-- Step 10: Northshire: the mine and the books
	["Northshire: the mine and the books"] = "노스셔: 광산과 책들",
	-- {npc:80} Kobold Laborer · {area:34} Echo Ridge Mine
	["{npc:80}, deep in {area:34}"] = "{npc:80}, {area:34} 깊은 곳",

	-- Step 11: Northshire: last hand-in
	["Northshire: last hand-in"] = "노스셔: 마지막 반납",
	-- {object:563442} Kobold Tracks
	["{object:563442}, east of the abbey"] = "{object:563442}, 수도원 동쪽",

	-- Step 12: Northshire: the books end in Goldshire
	-- {area:87} Goldshire
	["Northshire: the books end in {area:87}"] = "노스셔: 책은 {area:87}에서 끝납니다",
	-- {npc:240} Marshal Dughan · {area:87} Goldshire · {area:57} Fargodeep Mine
	-- plural, as words: Lost Books = {item:248001} Lost Book
	["{npc:240} stands in front of the Lion's Pride Inn in {area:87}. The Lost Books drop from the kobolds of {area:57} south of {area:87}; the picture book and the two rare books from the named kobolds there."] = "{npc:240}은(는) {area:87}의 사자 자부심 여관 앞에 서 있습니다. 잃어버린 책은 {area:87} 남쪽 {area:57}의 코볼트에게서 떨어지고, 그림책과 귀한 책 두 권은 그곳의 이름 붙은 코볼트에게서 떨어집니다.",
	["Arcane Explainer"] = "비전 설명자",
	-- {npc:951} Brother Paxton
	["{npc:951}, back at the abbey"] = "{npc:951}, 수도원으로 돌아가기",

	-- Step 13: Goldshire
	-- {area:87} Goldshire · {npc:240} Marshal Dughan · {npc:241} Remy "Two Times" · {npc:253} William Pestle
	["Optional: {area:87}, Westbrook and the farms south of {area:87}: about 1,450 reputation in an hour at 60. {npc:240}, {npc:241} and {npc:253} stand around the Lion's Pride Inn. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "선택 사항: {area:87}, 웨스트브룩, 그리고 {area:87} 남쪽의 농장: 60에서 한 시간에 약 1,450 평판. {npc:240}, {npc:241}, {npc:253}이(가) 사자 자부심 여관 주변에 서 있습니다. Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. 이 단계를 건너뛰면 허브도 건너뛰게 됩니다.",

	-- Step 14: Goldshire: the mines
	-- {area:87} Goldshire
	["{area:87}: the mines"] = "{area:87}: 광산",
	-- {area:57} Fargodeep Mine · {area:87} Goldshire · {area:54} Jasperlode Mine · {item:773} Gold Dust
	["{area:57} is south of {area:87}, {area:54} north-east of it. The kobolds in both drop the candles and the {item:773}; the wolves around {area:87} the pelts."] = "{area:57}은(는) {area:87} 남쪽, {area:54}은(는) 그 북동쪽입니다. 둘의 코볼트가 촛불과 {item:773}을(를) 떨어뜨리고, {area:87} 주변의 늑대가 가죽을 떨어뜨립니다.",

	-- Step 15: Goldshire: back at the inn
	-- {area:87} Goldshire
	["{area:87}: back at the inn"] = "{area:87}: 여관으로 돌아가기",

	-- Step 16: Goldshire: Jasperlode Mine
	["walk into the mine"] = "광산으로 들어가세요",

	-- Step 17: Goldshire: Westbrook and Hogger
	-- {area:87} Goldshire · {npc:448} Hogger
	["{area:87}: Westbrook and {npc:448}"] = "{area:87}: 웨스트브룩과 {npc:448}",
	-- {npc:448} Hogger · {area:120} Westbrook Garrison
	["{npc:448} is an elite gnoll west of {area:120}; at 60 he is no trouble. The Wanted poster hangs on the garrison."] = "{npc:448}은(는) {area:120} 서쪽의 정예 그놀입니다. 60이면 문제없습니다. 현상수배 전단은 주둔지에 걸려 있습니다.",
	-- {item:782} Painted Gnoll Armband
	["{item:782}, from the Riverpaw gnolls"] = "{item:782}, 강아지발 그놀에게서",
	-- {item:1931} Huge Gnoll Claw · {npc:448} Hogger
	["{item:1931}, from {npc:448}"] = "{item:1931}, {npc:448}에게서",

	-- Step 18: The farms south of Goldshire
	-- {area:87} Goldshire
	["The farms south of {area:87}"] = "{area:87} 남쪽의 농장",
	-- {area:87} Goldshire · {quest:87} Goldtooth · {area:57} Fargodeep Mine · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch
	["The Stonefields' farm and the Maclures' farm lie on either side of the road south of {area:87}. {quest:87} guards the back of {area:57}; {npc:330} the boar roams the {area:62}."] = "스톤필드 농장과 맥클루어 농장이 {area:87} 남쪽 도로 양쪽에 있습니다. {quest:87}이(가) {area:57} 뒤를 지키고, {npc:330} 멧돼지는 {area:62}를 거닐어 떠돕니다.",
	-- {item:1006} Brass Collar · {npc:330} Princess
	["{item:1006}, from {npc:330}"] = "{item:1006}, {npc:330}에게서",

	-- Step 19: Goldtooth and the kelp
	-- {quest:87} Goldtooth
	["{quest:87} and the kelp"] = "{quest:87}과(와) 다시마",
	-- {item:981} Bernice's Necklace · {quest:87} Goldtooth
	["{item:981}, from {quest:87}"] = "{item:981}, {quest:87}에게서",
	-- {item:1256} Crystal Kelp Frond · {area:18} Crystal Lake
	["{item:1256}, from the murlocs of {area:18}"] = "{item:1256}, {area:18}의 멀록에게서",

	-- Step 20: Goldshire: last hand-in
	-- {area:87} Goldshire
	["{area:87}: last hand-in"] = "{area:87}: 마지막 반납",

	-- Step 21: Shipment to Stormwind
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, in the {object:2096}"] = "{npc:279}, {object:2096} 안",

	-- Step 22: Eastvale
	["Eastvale"] = "이스트베일",
	-- {npc:261} Guard Thomas · {area:91} Tower of Azora
	["Optional: eastern Elwynn, around {npc:261} on the bridge and the {area:91}, about 1,000 reputation in 40 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "선택 사항: 동부 엘윈, 다리 위 {npc:261}과(와) {area:91} 주변으로 60에서 40분에 약 1,000 평판. Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. 이 단계를 건너뛰면 허브도 건너뛰게 됩니다.",

	-- Step 23: Eastvale: the work
	["Eastvale: the work"] = "이스트베일: 일",
	-- {area:91} Tower of Azora · {area:54} Jasperlode Mine
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear · Kobold Geomancers = {npc:476} Kobold Geomancer
	["The murlocs along the river south of the bridge drop the fins; Prowlers and Young Forest Bears roam the woods; the Defias around the Brackwell farm and the {area:91} carry the bandanas; the enchanting supplies lie in their camps north of the tower; the Kobold Geomancers dig at {area:54}; the tools and the river finds lie along the river north of the logging camp."] = "다리 남쪽 강변의 멀록이 지느러미를 떨어뜨리고, 굶주린 늑대와 새끼곰이 숲을 떠돌며, 브렉웰 농장과 {area:91} 주변의 데피아즈단이 복면을 지니고, 마법부여 재료는 탑 북쪽 그들의 야영지에 있고, 코볼트 흙점쟁이가 {area:54}에서 땅을 파고, 도구와 강변 전리품은 벌목소 북쪽 강변을 따라 있습니다.",

	-- Step 24: Eastvale: hand in
	["Eastvale: hand in"] = "이스트베일: 반납",

	-- Step 25: Eastvale: Defias Rogue Wizards
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["Eastvale: Defias Rogue Wizards"] = "이스트베일: 데피아즈단 견습마술사",
	["opens with Thomas' report"] = "토마스의 보고로 시작합니다",
	-- {item:780} Torn Murloc Fin
	["{item:780}, from the murlocs south of the bridge"] = "{item:780}, 다리 남쪽 멀록에게서",

	-- Step 26: Stockade: two quests
	-- {area:717} Stockade
	["{area:717}: two quests"] = "{area:717}: 퀘스트 둘",
	-- {area:717} Stockade · {faction:72} Stormwind · {object:2101} Mage Quarter · {npc:1719} Warden Thelwater · {npc:1721} Nikova Raskol · {object:2100} Old Town · {npc:1696} Targorr the Dread · {npc:859} Guard Berton · {area:69} Lakeshire · {npc:1663} Dextren Ward · {npc:270} Councilman Millstipe · {area:42} Darkshire · {npc:639} Edwin VanCleef · {area:1581} Deadmines
	["Optional: the {area:717} is {faction:72}'s prison, a dungeon in the canals of the {object:2101}. At 60 you clear it alone in ten minutes: 300 reputation. {npc:1719} stands at the gate, {npc:1721} in {object:2100}. Two more {area:717} quests start outside the city, 100 each, if you pass by: What Comes Around... ({npc:1696}) from {npc:859} in {area:69} and Crime and Punishment ({npc:1663}) from {npc:270} in {area:42}. (The Stockade Riots, 100 more, needs the Unsent Letter from {npc:639} in the {area:1581} first.) Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "선택 사항: {area:717}은(는) {faction:72}의 감옥으로, {object:2101} 운하에 있는 던전입니다. 60이면 열 분에 혼자 공략합니다: 평판 300. {npc:1719}이(가) 문에, {npc:1721}이(가) {object:2100}에 서 있습니다. 지나가는 길이라면 {area:717} 퀘스트가 도시 밖에 두 개 더 있고 각각 100입니다: 「전 세계가 돌고 돌아」({npc:1696})는 {area:69}의 {npc:859}에게서, 「범죄와 벌」({npc:1663})은(는) {area:42}의 {npc:270}에게서. (「스토케이드 폭동」은(는) 100을 더 주지만 먼저 {area:1581}의 {npc:639}에게서 부치지 않은 편지가 필요합니다.) Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. 이 단계를 건너뛰면 허브도 건너뛰게 됩니다.",

	-- Step 27: Inside the Stockade
	-- {area:717} Stockade
	["Inside the {area:717}"] = "{area:717} 안쪽",
	-- {npc:1716} Bazil Thredd
	-- plural, as words: Red Wool Bandanas = {item:2909} Red Wool Bandana
	["Kill the prisoners, convicts and insurgents in the cells; the Red Wool Bandanas drop from the Defias inside. {npc:1716} waits in the far end."] = "감방의 죄수, 죄수, 반역자를 죽이세요. 붉은 양모 복면은 안쪽 데피아즈단에게서 떨어집니다. {npc:1716}이(가) 맨 끝에서 기다립니다.",

	-- Step 28: Stockade: hand in
	-- {area:717} Stockade
	["{area:717}: hand in"] = "{area:717}: 반납",

	-- Step 29: A Donation of Silk
	-- {item:4306} Silk Cloth · {area:94} Raven Hill
	["{item:4306} drops from humanoids level 23 to 40: Syndicate in Alterac and Arathi, the Defias of Duskwood's {area:94}, Stranglethorn's trolls."] = "{item:4306}은(는) 23~40레벨 인간형에게서 떨어집니다: 알터랙과 아라시의 비밀결사대, 그늘숲 {area:94}의 데피아즈단, 가시덤불 골짜기의 트롤.",

	-- Step 30: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1446} Tanaris · {zone:1444} Feralas · {zone:1418} Badlands
	["{item:4338} drops from humanoids level 35 to 50: the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}, the Shadowforge dwarves of the {zone:1418}."] = "{item:4338}은(는) 35~50레벨 인간형에게서 떨어집니다: {zone:1446}의 둔모울 오우거, {zone:1444}의 증오의갈기일족 나가, {zone:1418}의 암흑철 드워프.",

	-- Step 31: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7796} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60: it all goes to {quest:7796} later."] = "{item:14047}은(는) 50레벨 이상 인간형에게서 떨어집니다: 역병지대의 스컬지 신도와 붉은십자군, {zone:1448}의 마른가지일족 펄볼그, {zone:1452}의 겨울서리 펄볼그. 처음 60개 이후의 {item:14047}은(는) 모두 나중의 {quest:7796}에 갑니다.",

	-- Step 32: Chillwind Camp: Clear the Way
	-- {npc:10838} Commander Ashlam Valorfist · {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {faction:72} Stormwind · {object:92525} Argent Dawn
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["These quests are level 52 to 58, so they pay in full at 60. {npc:10838} and {npc:11053} at {area:3197}, in the south of the {zone:1422}, send you against the four Scourge cauldrons: 820 {faction:72} reputation in all and 600 {object:92525} on the side. The Skeletal Flayers and Slavering Ghouls roam the fields north of the camp."] = "이 퀘스트는 52~58레벨이니 60에서 정액을 받습니다. {zone:1422} 남부 {area:3197}의 {npc:10838}과(와) {npc:11053}이(가) 스컬지 가마솥 넷에 대적하라고 보냅니다: 모두 {faction:72} 평판 820, 덤으로 {object:92525} 600입니다. 해골 타작꾼와 걸신들린 구울이 야영지 북쪽 들을 떠돕니다.",

	-- Step 33: Andorhal and Felstone Field
	-- {area:199} Felstone Field
	["Andorhal and {area:199}"] = "안도르할과 {area:199}",
	-- {item:12815} Beacon Torch · {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field · {npc:10778} Janice Felstone · {faction:72} Stormwind
	["Mark the four watchtowers around Andorhal, north of the camp, with the {item:12815} at each door. {npc:11075} guards the cauldron at {area:199}, west of Andorhal; his key opens it. {npc:10778}'s ghost wanders by the Felstone farmhouse, and her parcel lies inside: it goes to {faction:72} for 150 more."] = "야영지 북쪽 안도르할 주변의 망루 네 개를 각 문에 {item:12815}으로 표시하세요. {npc:11075}이(가) 안도르할 서쪽 {area:199}의 가마솥을 지키는데, 그의 열쇠가 그것을 엽니다. {npc:10778}의 유령이 펠스톤 농가 곁을 거니는데, 그녀의 소포는 안에 있습니다: {faction:72}에 150을 더 줍니다.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "{item:12815}(으)로 {npc:10902} 표시",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "{item:12815}(으)로 {npc:10903} 표시",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "{item:12815}(으)로 {npc:10904} 표시",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "{item:12815}(으)로 {npc:10905} 표시",
	-- {item:13194} Felstone Field Cauldron Key · {npc:11075} Cauldron Lord Bilemaw
	["{item:13194}, from {npc:11075}"] = "{item:13194}, {npc:11075}에게서",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "{object:176361}",
	-- {object:175894} Janice's Parcel
	["{object:175894}, in the farmhouse"] = "{object:175894}, 농가 안",

	-- Step 35: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears · {area:199} Felstone Field
	["{npc:11077} guards the cauldron at {area:200}, north-east of {area:199}."] = "{npc:11077}이(가) {area:199} 북동쪽 {area:200}의 가마솥을 지킵니다.",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "{object:177289}",

	-- Step 36: Chillwind Camp: the Writhing Haunt
	-- {area:3197} Chillwind Camp · {area:202} Writhing Haunt
	["{area:3197}: the {area:202}"] = "{area:3197}: {area:202}",

	-- Step 37: Writhing Haunt
	-- {npc:11076} Cauldron Lord Razarch · {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["{npc:11076} guards the cauldron at the {area:202}, the farm east of {area:200}."] = "{npc:11076}이(가) {area:200} 동쪽 농장 {area:202}의 가마솥을 지킵니다.",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "{object:176393}",

	-- Step 39: Gahrron's Withering
	-- {npc:11078} Cauldron Lord Soulwrath · {area:201} Gahrron's Withering
	["{npc:11078} guards the cauldron at {area:201}, in the east of the zone."] = "{npc:11078}이(가) 지역 동부 {area:201}의 가마솥을 지킵니다.",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "{object:176392}",

	-- Step 40: Chillwind Camp: done
	-- {area:3197} Chillwind Camp
	["{area:3197}: done"] = "{area:3197}: 완료",
	-- {npc:11056} Alchemist Arbington · {area:2057} Scholomance
	["{npc:11056} in the camp also ends The Key to {area:2057} (200), after a longer chain that needs a {area:2057} group."] = "야영지의 {npc:11056}도 {area:2057}의 열쇠(200)를 끝냅니다. 다만 {area:2057} 파티가 필요한 더 긴 사슬 이후입니다.",

	-- Step 41: Stormwind: Janice Felstone's parcel
	-- {faction:72} Stormwind · {npc:10778} Janice Felstone
	["{faction:72}: {npc:10778}'s parcel"] = "{faction:72}: {npc:10778}의 소포",
	-- {npc:10782} Royal Factor Bathrilor · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {npc:3520} Ol' Emma
	["{npc:10782} stands in the city hall on {object:2098}, beside {npc:1646}; {npc:3520} walks the canals."] = "{npc:10782}은(는) {object:2098}의 시청에 {npc:1646} 옆에 서 있고, {npc:3520}은(는) 운하를 거닙니다.",

	-- Step 42: Morgan's Vigil: Dragonkin Menace
	-- {npc:9562} Helendis Riverhorn · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {area:69} Lakeshire · {object:2117} Stormwind Keep · {faction:72} Stormwind · {zone:1457} Darnassus · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: a chain to {area:69} and {object:2117}, 175 {faction:72} and 175 {zone:1457} reputation (level 54). The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "{zone:1428} 남동부 {area:2418}의 {npc:9562}이(가) {quest:4183}을(를) 시작합니다: {area:69}과(와) {object:2117}로 이어지는 사슬로, {faction:72} 평판 175와 {zone:1457} 175(54레벨)입니다. 검은 새끼용와 {npc:7044}는 망루 북쪽 비탈에 살고, {npc:7040}과(와) {npc:7041}은(는) 그 서쪽, 지역 한가운데에 있습니다.",

	-- Step 43: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon · {area:69} Lakeshire
	["{npc:344} waits in the town hall of {area:69}."] = "{npc:344}가 {area:69} 시청에서 기다립니다.",

	-- Step 44: Stormwind Keep
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep · {npc:1749} Lady Katrana Prestor
	["{npc:1748} holds court in {object:2117} with {npc:1749} at his side: speak with her for the second of his quests."] = "{npc:1748}이(가) {npc:1749}를 옆에 두고 {object:2117}에서 압정을 받습니다. 그의 두 번째 퀘스트를 위해 그녀와 말을 거세요.",
	-- {npc:1749} Lady Katrana Prestor
	["Speak with {npc:1749}"] = "{npc:1749}과(와) 말을 거세요",

	-- Step 45: Lakeshire: Solomon again
	-- {area:69} Lakeshire
	["{area:69}: Solomon again"] = "{area:69}: 솔로몬 다시",
	-- {area:1584} Blackrock Depths · {npc:9023} Marshal Windsor · {faction:72} Stormwind · {area:1583} Blackrock Spire · {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {area:2057} Scholomance
	["With a group the chain goes on into {area:1584}: {npc:9023}, Jail Break! and The Great Masquerade back in {faction:72} pay about 750 {faction:72} more, Maxwell's Mission (Lower {area:1583}) 250, Delivery to Ridgewell 135. Order Must Be Restored ({npc:11878} in the {zone:1423}) pays 200, The Key to {area:2057} 200; Onyxia's head 400 and Nefarian's 200 when the raids open."] = "파티와 함께라면 사슬이 {area:1584}로 이어집니다: {npc:9023}, 「탈옥!」과 「위대한 가장무도회」가 {faction:72}에서 {faction:72} 평판 약 750을 더 주고, 맥스웰의 임무(하부 {area:1583}) 250, 리지웰 배달 135. 「질서는 회복되어야 한다」({zone:1423}의 {npc:11878})가 200, {area:2057}의 열쇠 200을 줍니다. 레이드가 열리면 오닉시아의 머리 400, 네파리안의 머리 200입니다.",

	-- Step 46: Additional Runecloth to Honored
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Honored"] = "{quest:7796}(으)로 우대까지",
	-- {quest:7796} Additional Runecloth · {item:14047} Runecloth · {faction:72} Stormwind · {zone:1436} Westfall · {area:69} Lakeshire · {zone:1431} Duskwood · {area:42} Darkshire
	["{quest:7796}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a non-Human stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Humans start 900 higher: 88 turn-ins; a Skyborne's Exploring the Alliance paid 100, two fewer). The level 52-58 quests above take 23 turn-ins off; every Elwynn hub you did takes 20 to 30 more off. More quest hubs pay {faction:72}, in full while they are no more than 5 levels below you: {zone:1436} (about 2,500 in all), Redridge's {area:69} (about 3,000) and {zone:1431}'s {area:42} (about 2,900). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7796}: 20개 {item:14047}에 평판 50, 제한 없이. 첫 네 번의 기부 이후 비인간은 약간 우호적 6,000 중 700 지점에 있으니 우호적까지 5,300: 106번, {item:14047} 2,120개(인간은 900에서 시작해 88번, 천공의 후손의 「얼라이언스 탐험」이 100을 줘 두 번 적게). 위의 52~58레벨 퀘스트가 23번을 덜어 주고, 거친 엘윈 허브마다 20~30번을 더 덜어 줍니다. 더 많은 퀘스트 허브가 {faction:72}을(를) 주는데, 자신보다 최대 5레벨 낮을 때 정액입니다: {zone:1436}(모두 약 2,500), 붉은마루의 {area:69}(약 3,000), {zone:1431}의 {area:42}(약 2,900). 도시 획득은 다른 세 도시에도 4분의 1을 줍니다(여기엔 세지 않음). {item:14047}은(는) 한꺼번에 모두 반납하세요.",

	-- Step 47: Additional Runecloth to Revered
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Revered"] = "{quest:7796}(으)로 존경까지",
	-- {npc:384} Katie Hunter · {item:14047} Runecloth
	["Honored: in Classic Stormwind's vendors take 10% off for you, {npc:384}'s horses (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "우호적: Classic에서는 스톰윈드 상인이 10% 할인해 주며 {npc:384}의 말(20골, 빠른 말 200골)도 포함됩니다. Forever는 정하지 않았고, 가이드 사이트들은 약간 우호적에서 5%, 확고한 동맹에서 20%까지 오른다고 합니다. 우호적에서 매우 우호적은 평판 12,000: 240번, {item:14047} 4,800개.",

	-- Step 48: Additional Runecloth to Exalted
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Exalted"] = "{quest:7796}(으)로 확고한 동맹까지",
	-- {item:14047} Runecloth · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:384} at {area:88} sells her horses to other races in Classic; the Horse and Swift Horse guides cover them."] = "매우 우호적에서 확고한 동맹은 평판 21,000: 420번, {item:14047} 8,400개. 확고한 동맹이 되면 {area:88}의 {npc:384}이(가) Classic에서는 다른 종족에게 자기 말을 팝니다. 말과 빠른 말 가이드가 그것을 다룹니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "이곳의 암흑의 수행사제와 어둠마법사(58-60레벨)가 떨어뜨립니다. 이곳의 스컬지 처치는 {object:92525}에도 집계됩니다(해당 가이드 참고). 경매장도 이용할 수 있습니다.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "이곳의 모래망치 오우거(45-48레벨)가 떨어뜨립니다. 경매장도 이용할 수 있습니다.",
	-- ["Keep handing in {quest:7796} until {faction:72} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{faction:72} 평판이 확고한 동맹이 될 때까지 {quest:7796}을(를) 계속 제출하십시오. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(58-60레벨), 또는 경매장.",
	-- ["Keep handing in {quest:7796}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7796}을(를) 계속 제출하십시오. 한 번에 {item:14047} 20개입니다. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(58-60레벨), 또는 경매장.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "이곳의 갈퀴발일족 무법자와 갈퀴발일족 전사(16-18레벨)가 떨어뜨립니다. 경매장도 이용할 수 있습니다.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "스트롬가드의 비밀결사대 용병(31-32레벨)이 떨어뜨립니다. 경매장도 이용할 수 있습니다.",
	-- ["{npc:14722} takes cloth for {faction:72} in {zone:1453}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7796} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{zone:1453}의 {npc:14722}이(가) {faction:72}을(를) 위한 옷감을 받습니다. 양모, 비단, 마법 직물, {item:14047}의 첫 기부(각 60개)는 한 번만 할 수 있으며 옷감당 평판이 가장 높습니다. 그 후에는 확고한 동맹까지 {quest:7796}이(가) 반복됩니다. 다른 종족의 도시와 확고한 동맹이 되면 그 종족의 탈것을 구매할 수 있습니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{npc:14722}: {item:14047} delivered"] = "{npc:14722}: {item:14047} 전달 완료",
	-- ["{quest:7796} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7796}은(는) 제출당 {item:14047} 20개를 받으며 원하는 만큼 반복할 수 있습니다. {item:14047}을(를) 20의 배수로 가져와 연달아 한꺼번에 제출하십시오. {item:14047}: {zone:1423}의 암흑의 수행사제와 어둠마법사(58-60레벨), 또는 경매장.",
}
