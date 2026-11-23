-- Korean (koKR): the guide forever/reputation/darnassus (forever/reputation/darnassus.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darnassus Reputation"] = "다르나서스 평판",
	-- {item:11040} Morrowgrain · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["Cloth, {item:11040} and the {zone:1438} and {zone:1439} hubs: the quests pay most while you level."] = "옷감, {item:11040}, 그리고 {zone:1438}와(과) {zone:1439} 허브: 레벨을 올리는 동안 퀘스트가 가장 많이 줍니다.",
	-- {faction:69} Darnassus
	["Exalted with {faction:69}: in Classic, other races may buy the nightsabers"] = "{faction:69}과(와) 확고한 동맹: 고전에서는 다른 종족도 밤호랑이를 살 수 있습니다",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain
	["{quest:3803}: 50 reputation for every 10 {item:11040}, as often as you like"] = "{quest:3803}: {item:11040} 10개에 평판 50, 제한 없이",
	-- {faction:69} Darnassus · {zone:1438} Teldrassil · {zone:1439} Darkshore
	["About 3,700 {faction:69} reputation from low-level quests in {zone:1438} and {zone:1439}"] = "{zone:1438}와(과) {zone:1439}의 저레벨 퀘스트로 {faction:69} 평판 약 3,700",

	-- Step 1: Raedon Duskstriker, the cloth quartermaster
	-- {npc:14725} Raedon Duskstriker
	["{npc:14725}, the cloth quartermaster"] = "{npc:14725}, 옷감 병참장교",
	-- {npc:14725} Raedon Duskstriker · {faction:69} Darnassus · {area:1659} Craftsmen's Terrace · {item:14047} Runecloth · {quest:7801} Additional Runecloth · {area:1662} Tradesmen's Terrace · {zone:1438} Teldrassil · {zone:1439} Darkshore · {zone:1440} Ashenvale · {quest:4183} The True Masters · {zone:1428} Burning Steppes · {item:11040} Morrowgrain · {area:188} Shadowglen · {area:186} Dolanaar · {area:442} Auberdine · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{npc:14725} takes cloth for {faction:69}; he stands in the {area:1659}, in the north-east of {faction:69}, by the tailors. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7801} pays 50 for every 20 {item:14047}, as often as you like. The Auction House in the {area:1662} is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do {zone:1438} (levels 1-12), {zone:1439} (11-20) and {zone:1440} (18-30) while you level through them. After the donations come {quest:4183} in the {zone:1428} and {item:11040}, a second repeatable turn-in; then the optional hubs, best rate first: {area:188} (about 35 a minute at full value), {area:186} (28), {area:442} (23). Every {faction:69} gain also gives a quarter as much to {zone:1453}, {zone:1455} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14725}가 {faction:69}을(를) 위해 옷감을 받습니다. 그는 재단사들 옆, {faction:69} 북동부의 {area:1659}에 서 있습니다. 양모, 비단, 마법천, {item:14047}을(를) 각각 처음 60개씩 기부하면 한 번에 평판 150을 주고, {item:14047} 이후로는 {quest:7801}이(가) {item:14047} 20개당 50을 제한 없이 줍니다. {area:1662}의 경매장이 옷감의 가장 빠른 수급처입니다. 고전에서는 퀘스트가 자신보다 최대 5레벨 낮을 때 정액을 주므로 {zone:1438}(1~12), {zone:1439}(11~20), {zone:1440}(18~30)을(를) 레벨을 올리며 진행하세요. 기부 다음에는 {zone:1428}의 {quest:4183}과 {item:11040}, 즉 두 번째 반복 반납이 오고, 그다음 선택 허브, 가장 좋은 비율부터: {area:188}(정액 기준 분당 약 35), {area:186}(28), {area:442}(23). {faction:69}의 모든 획득량은 1~10레벨 시작 지역의 퀘스트를 제외하고 {zone:1453}, {zone:1455}, 노움리건 추방자에게 4분의 1을 더 줍니다. 유산 특성 외교관이 모든 획득량에 최대 10%를 더합니다.",
	-- {item:2592} Wool Cloth · {zone:1439} Darkshore · {zone:1440} Ashenvale
	["{item:2592}: furbolgs, satyrs and naga in {zone:1439} and {zone:1440}"] = "{item:2592}: {zone:1439}와(과) {zone:1440}의 펄볼그, 사티로스, 나가",

	-- Step 2: Shadowglen
	-- {zone:1438} Teldrassil · {area:256} Aldrassil
	["Optional: the Night Elf start glade in north-east {zone:1438}, about 1,050 reputation in 30 minutes at 60. The givers stand around {area:256}, the great tree. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "선택 사항: 북동부 {zone:1438}의 나이트엘프 시작 숲, 60에서 30분에 약 1,050 평판. 주는 이들이 거대 나무 {area:256} 주변에 서 있습니다. Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. 이 단계를 건너뛰면 허브도 건너뛰게 됩니다.",

	-- Step 3: Shadowglen: the glade and the spider den
	-- {area:188} Shadowglen
	["{area:188}: the glade and the spider den"] = "{area:188}: 숲과 거미 소굴",
	-- {area:256} Aldrassil · {item:3297} Fel Moss · {npc:8584} Iverron
	["The nightsabers and boars roam the glade; the grells around {area:256} drop the {item:3297}; the totems stand in the furbolg camp north-west of the tree; the Webwood spiders live in the cave north of the glade. {npc:8584} waits outside that cave."] = "밤호랑이와 멧돼지가 숲을 떠돌고, {area:256} 주변의 그렐이 {item:3297}을(를) 떨어뜨리고, 토템은 나무 북서쪽 펄볼그 야영지에 서고, 웹우드 거미는 숲 북쪽 동굴에 삽니다. {npc:8584}이(가) 그 동굴 밖에서 기다립니다.",

	-- Step 4: Shadowglen: first hand-in
	-- {area:188} Shadowglen
	["{area:188}: first hand-in"] = "{area:188}: 첫 반납",

	-- Step 5: Shadowglen: the egg and the antidote
	-- {area:188} Shadowglen
	["{area:188}: the egg and the antidote"] = "{area:188}: 알과 해독제",
	-- {quest:917} Webwood Egg · {item:10640} Webwood Ichor
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["The {quest:917} lies at the back of the spider cave; the mushrooms grow by the trees, the lilies by the pools, and the {item:10640} drops from the Webwood Lurkers."] = "{quest:917}은(는) 거미 동굴 안쪽에 있습니다. 버섯은 나무 곁에, 백합은 웅덩이 곁에 자라고, {item:10640}은(는) 나무그물 늑대거미에게서 떨어집니다.",

	-- Step 6: Shadowglen: last hand-in
	-- {area:188} Shadowglen
	["{area:188}: last hand-in"] = "{area:188}: 마지막 반납",
	-- {npc:8584} Iverron
	["{npc:8584}, outside the spider cave"] = "{npc:8584}, 거미 동굴 밖",

	-- Step 7: Dolanaar
	-- {faction:69} Darnassus · {npc:2151} Moon Priestess Amara
	["Optional: the village on the road to {faction:69}, about 1,250 reputation in 45 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub.\n{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "선택 사항: {faction:69}(으)로 가는 도로의 마을, 60에서 45분에 약 1,250 평판. Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. 이 단계를 건너뛰면 허브도 건너뛰게 됩니다.\n{npc:2151}이(가) 마을 서쪽 도로를 순찰합니다. 화살표 자리에 없으면 만날 때까지 도로를 따라가세요.",

	-- Step 8: Dolanaar: Denalan and the lake
	-- {area:186} Dolanaar · {npc:2080} Denalan
	["{area:186}: {npc:2080} and the lake"] = "{area:186}: {npc:2080}과(와) 호수",
	-- {npc:2080} Denalan · {area:259} Lake Al'Ameth · {npc:2107} Gaerolas Talvethren · {area:260} Starbreeze Village · {area:186} Dolanaar
	["{npc:2080} tends his garden on the south-east shore of {area:259}; {npc:2107} stands upstairs in a house in {area:260}, east of {area:186}: go up inside, the arrow cannot tell the floors apart."] = "{npc:2080}이(가) {area:259} 남동쪽 기슭에서 밭을 가꾸고, {npc:2107}이(가) {area:186} 동쪽 {area:260}의 집 위층에 서 있습니다. 안쪽으로 올라가세요. 화살표는 층을 구분하지 못합니다.",

	-- Step 9: Dolanaar: the woods around the village
	-- {area:186} Dolanaar
	["{area:186}: the woods around the village"] = "{area:186}: 마을 주변 숲",
	-- {faction:69} Darnassus · {npc:2038} Lord Melenas · {area:258} Fel Rock · {npc:2107} Gaerolas Talvethren
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["The timberlings by the lake drop seeds and sprouts; the Gnarlpine Ambushers lurk on the road west to {faction:69}; {npc:2038} waits deep in {area:258}, north-west of the village; the dreamcatcher lies in the furbolg camp east of the village, by {npc:2107}; the Nightsabers west of the village carry the pelts."] = "호숫가의 나무정령이 씨앗과 새싹을 떨어뜨리고, 나무옹이일족 복병가 {faction:69} 서쪽 도로에 숨어들고, {npc:2038}이(가) 마을 북서쪽 {area:258} 깊은 곳에서 기다리고, 꿈그물은 마을 동쪽 펄볼그 야영지의 {npc:2107} 곁에 있고, 마을 서쪽 밤호랑이가 가죽을 지니고 있습니다.",

	-- Step 10: Dolanaar: first hand-in
	-- {area:186} Dolanaar
	["{area:186}: first hand-in"] = "{area:186}: 첫 반납",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151}은(는) 마을 서쪽 길을 순찰합니다. 화살표 위치에 없으면 만날 때까지 길을 따라가세요.",

	-- Step 11: Dolanaar: the Ban'ethil Barrow Den's entrance
	-- {area:186} Dolanaar · {area:262} Ban'ethil Barrow Den
	["{area:186}: the {area:262}'s entrance"] = "{area:186}: {area:262} 입구",

	-- Step 12: Dolanaar: the relics and Ferocitas
	-- {area:186} Dolanaar
	["{area:186}: the relics and Ferocitas"] = "{area:186}: 유물과 페로시타스",
	-- {area:262} Ban'ethil Barrow Den · {area:186} Dolanaar
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["The four relics of Wakening lie in the {area:262}, south-west of {area:186}; Ferocitas and the Gnarlpine Mystics camp east of the village."] = "깨어남의 유물 넷이 {area:186} 남서쪽 {area:262}에 있습니다. 페로시타스와 나무옹이일족 비술사가 마을 동쪽에 야영합니다.",
	-- {item:8050} Tallonkai's Jewel · {quest:2459} Ferocitas the Dream Eater
	["{item:8050}, from {quest:2459}"] = "{item:8050}, {quest:2459}에게서",

	-- Step 13: Dolanaar: Ursal the Mauler
	-- {quest:486} Ursal the Mauler · {area:478} Pools of Arlithrien · {zone:1438} Teldrassil
	["{quest:486}, a big bear, roams the {area:478} in south-west {zone:1438}."] = "{quest:486}, 커다란 곰이 남서부 {zone:1438}의 {area:478}를 떠돕니다.",

	-- Step 14: Auberdine
	-- {area:442} Auberdine · {zone:1439} Darkshore · {area:702} Rut'theran Village
	["Optional: {area:442} in {zone:1439}, a boat trip from {area:702}, about 1,400 reputation in an hour at 60. The givers stand along the town's street and pier. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "선택 사항: {zone:1439}의 {area:442}, {area:702}에서 배를 타고 가며 60에서 한 시간에 약 1,400 평판. 주는 이들이 마을 거리와 부두를 따라 서 있습니다. Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. 이 단계를 건너뛰면 허브도 건너뛰게 됩니다.",

	-- Step 15: Auberdine: the coast and the woods
	-- {area:442} Auberdine
	["{area:442}: the coast and the woods"] = "{area:442}: 해안과 숲",
	-- {area:445} Cliffspring Falls
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["The furbolg camp south of town counts for How Big a Threat; the Rabid Thistle Bears roam the woods south of town; the Highborne ghosts of the Ruins of Ameth'Aran, south-east of town, carry the relics, and Anaya's ghost walks there too; the bones lie on the beach south of town; the mushrooms grow in the {area:445} cave to the north-east."] = "마을 남쪽 펄볼그 야영지가 '위협이 얼마나 되나'를 셉니다. 광포한 엉겅퀴곰이 마을 남쪽 숲을 떠돌고, 마을 남동쪽 아메스아란 폐허의 고귀뼈 망령이 유물을 지니고 있으며 아나야의 망령도 그곳을 거니고, 뼛가지는 마을 남쪽 해변에 있고, 버섯은 북동쪽 {area:445} 동굴에 자랍니다.",
	["the corrupt furbolg camp south of town"] = "마을 남쪽의 타락한 펄볼그 야영지",
	-- {npc:2164} Rabid Thistle Bear · {quest:2139} Tharnariun's Hope · {npc:3701} Tharnariun Treetender
	["{npc:2164}: use {quest:2139} on it and lead it back to {npc:3701}"] = "{npc:2164}: 그것에게 {quest:2139}를 사용하고 {npc:3701}에게 이끌고 돌아가세요",
	-- {npc:2164} Rabid Thistle Bear
	["Capture a {npc:2164}"] = "{npc:2164} 포획",
	-- {quest:954} Bashal'Aran
	["the blue aura in the ruins of {quest:954}"] = "{quest:954} 폐허의 푸른 기운",

	-- Step 16: Auberdine: first hand-in
	-- {area:442} Auberdine
	["{area:442}: first hand-in"] = "{area:442}: 첫 반납",

	-- Step 17: Auberdine: the furbolgs, the bears and the grells
	-- {area:442} Auberdine
	["{area:442}: the furbolgs, the bears and the grells"] = "{area:442}: 펄볼그, 곰, 그렐",
	-- {quest:955} Bashal'Aran
	["The Blackwood furbolgs camp south of town; the grells of {quest:955}, east of town, drop the earrings; the sea turtle remains lie on the beach west of town."] = "블랙우드 펄볼그가 마을 남쪽에 야영하고, 마을 동쪽 {quest:955}의 그렐이 귀걸이를 떨어뜨리고, 바다거북 유해는 마을 서쪽 해변에 있습니다.",

	-- Step 18: Auberdine: second hand-in
	-- {area:442} Auberdine
	["{area:442}: second hand-in"] = "{area:442}: 두 번째 반납",

	-- Step 19: Auberdine: the seal, the Den Mother and the pelts
	-- {area:442} Auberdine · {npc:6788} Den Mother
	["{area:442}: the seal, the {npc:6788} and the pelts"] = "{area:442}: 인장, {npc:6788}과(와) 가죽",
	-- {item:5338} Ancient Moonstone Seal · {quest:956} Bashal'Aran · {npc:6788} Den Mother · {zone:1439} Darkshore
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["The {item:5338} drops from the satyrs of {quest:956}; destroy the seal at the flame there. The {npc:6788} lairs north-east of {quest:956}; the Moonstalker Sires and Matriarchs roam the south of {zone:1439}."] = "{item:5338}은(는) {quest:956}의 사티로스에게서 떨어집니다. 그곳의 불꽃에서 인장을 부수세요. {npc:6788}이(가) {quest:956} 북동쪽에 둥지를 틀고, 덩치큰 달표범과 암컷이 {zone:1439} 남부를 떠돕니다.",
	["the seal at the ancient flame"] = "고대 불꽃의 인장",

	-- Step 20: A Donation of Silk
	-- {item:4306} Silk Cloth · {zone:1440} Ashenvale
	["{item:4306} drops from humanoids level 23 to 40: the satyrs and furbolgs of {zone:1440}, the Thistlefur and Foulweald camps, the Grimtotem of Stonetalon."] = "{item:4306}은(는) 23~40레벨 인간형에게서 떨어집니다: {zone:1440}의 사티로스와 펄볼그, 가시부리와 부패숲 야영지, 돌바위 그림토템.",

	-- Step 21: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1444} Feralas · {zone:1446} Tanaris
	["{item:4338} drops from humanoids level 35 to 50: the Hatecrest naga and Gordunni ogres of {zone:1444}, the Dunemaul ogres of {zone:1446}."] = "{item:4338}은(는) 35~50레벨 인간형에게서 떨어집니다: {zone:1444}의 증오의갈기 나가와 고르둔니 오우거, {zone:1446}의 둔모울 오우거.",

	-- Step 22: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7801} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}, the Scourge cultists of the Plaguelands. Keep any {item:14047} past the first 60 for {quest:7801}."] = "{item:14047}은(는) 50레벨 이상 인간형에게서 떨어집니다: {zone:1448}의 마른가지일족 펄볼그, {zone:1452}의 겨울서리 펄볼그, 역병지대의 스컬지 신도. {quest:7801}을(를) 위해 처음 60개 이후의 {item:14047}은(는) 모두 보관하세요.",

	-- Step 23: Morgan's Vigil: Dragonkin Menace
	-- {npc:9562} Helendis Riverhorn · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {faction:69} Darnassus · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: 175 {faction:69} reputation for two quests (level 54: in Classic 140 at 60), and the chain goes on to {object:2117} for 175 {zone:1453}. The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "{npc:9562}, {zone:1428} 남동부 {area:2418}에 서서 {quest:4183}을(를) 시작합니다: 퀘스트 둘에 {faction:69} 평판 175(54레벨, 고전에서는 60에서 140), 사슬은 {object:2117}까지 이어져 {zone:1453} 175을 줍니다. 검은 새끼용와 {npc:7044}는 망루 북쪽 비탈에 살고, {npc:7040}과(와) {npc:7041}은(는) 그 서쪽, 지역 한가운데에 있습니다.",

	-- Step 24: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon · {area:69} Lakeshire · {object:2117} Stormwind Keep · {zone:1453} Stormwind · {faction:69} Darnassus · {npc:7916} Erelas Ambersky · {area:702} Rut'theran Village · {zone:1452} Winterspring · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands · {item:12663} Glyphed Oaken Branch
	["{npc:344} waits in the town hall of {area:69}; his next quest takes you to {object:2117} (the {zone:1453} guide follows it). Other {faction:69} quests at this level, for when you pass by: {npc:7916} in {area:702} has a wildkin chain into {zone:1452} (325 in all, with Ranshalla's escort), Arei's escort in {zone:1448} pays 150 after the {area:2479}'s chain, {npc:10739} at the {area:202} in the {zone:1422} 100 for the {item:12663}, and Put Her Down in Upper Blackrock Spire 100 with a group."] = "{npc:344}가 {area:69} 시청에서 기다립니다. 그의 다음 퀘스트는 {object:2117}(으)로 보냅니다({zone:1453} 가이드가 이어집니다). 지나가는 길에 할 이 레벨대의 다른 {faction:69} 퀘스트: {area:702}의 {npc:7916}이(가) {zone:1452}로 이어지는 야생수 사슬(모두 325, 랜샬라 호위 포함), {zone:1448}의 아레이 호위가 {area:2479} 사슬 이후 150, {zone:1422}의 {area:202}에 있는 {npc:10739}가 {item:12663}에 100, 그리고 검은바위 첨탑 상부의 「그녀를 처치하라」가 파티로 100.",

	-- Step 25: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "{item:11040} (선택)",
	-- {quest:3803} Morrowgrain to Darnassus · {item:11040} Morrowgrain · {npc:6735} Innkeeper Saelienne · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:3764} Un'Goro Soil · {zone:1453} Stormwind · {zone:1455} Ironforge
	["{quest:3803} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60. The chain before it is level 50: 220. {npc:6735} sends you to {npc:3516} in the {area:1658}; he wants 20 {quest:3764}. (The innkeepers of {zone:1453} and {zone:1455} give the same start.)"] = "{quest:3803}이(가) {item:11040} 10개를 50에 제한 없이 받고 60에서 정액을 줍니다. 앞의 사슬은 50레벨: 220. {npc:6735}이(가) {area:1658}의 {npc:3516}에게 보내고, 그는 {quest:3764} 20개를 원합니다. ({zone:1453}와(과) {zone:1455}의 여주인도 같은 시작을 줍니다.)",

	-- Step 28: Un'Goro Crater: Un'Goro Soil
	-- {quest:3764} Un'Goro Soil · {item:11040} Morrowgrain
	["Dig {quest:3764} from the dirt mounds all over the crater; most of the crater's beasts and the Gorishi silithids drop it too, about one kill in three. Take far more than 20: every pouch use takes 2, about 18 for each 10 {item:11040}."] = "분화구 곳곳의 흙 더미에서 {quest:3764}을(를) 파내고, 분화구의 야수 대부분과 고리시 실리시드도 떨어뜨리는데 처치 셋 중 하나 꼴입니다. 20개보다 훨씬 더 가져가세요. 주머니 사용마다 2개, {item:11040} 10개마다 약 18개를 씁니다.",

	-- Step 29: Darnassus: Morrowgrain Research
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave · {npc:4217} Mathrengyl Bearwalker · {item:11020} Evergreen Pouch · {quest:3764} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9047}, beside Fandral in the {area:1658}, takes the soil. {npc:4217} sells the {item:11020} and Packets of Tharlendris Seeds. With a seed packet and 2 {quest:3764} in your bags, use the pouch to grow an {item:11024} and open it: about one casing in three holds {item:11040} (1 to 5), the rest other herbs. The pouch works once every 10 minutes, so use it whenever it is ready while you do other things."] = "{area:1658}에서 판드랄 옆의 {npc:9047}이(가) 흙을 받습니다. {npc:4217}이(가) {item:11020}과(와) 탈렌드리스 씨앗 봉지를 팝니다. 씨앗 봉지 하나와 가방에 {quest:3764} 둘을 넣고 주머니를 사용해 {item:11024}를 키운 뒤 여세요. 셋 중 하나꼴로 {item:11040}(1~5개), 나머지는 다른 약초입니다. 주머니는 10분마다 작동하니 다른 일을 하는 동안 준비되는 대로 사용하세요.",

	-- Step 33: Darnassus: Morrowgrain Research
	-- {item:11040} Morrowgrain
	["{item:11040}: grow it here and open the casings"] = "{item:11040}: 여기서 기르고 껍질을 여세요",

	-- Step 34: Morrowgrain to Darnassus
	-- {item:11040} Morrowgrain · {npc:4217} Mathrengyl Bearwalker · {quest:3764} Un'Goro Soil · {item:14047} Runecloth · {npc:7879} Quintis Jonespyre · {area:1116} Feathermoon Stronghold · {zone:1444} Feralas
	["Every 10 {item:11040}: 50 reputation at {npc:4217}. Keep the pouch and buy seeds as you go. It is slow: about 9 casings, 90 minutes of pouch waits, 18 {quest:3764} and 9 seed packets for each hand-in, a little over 30 reputation an hour, so run it beside the {item:14047}. {npc:7879} at {area:1116} in {zone:1444} takes {item:11040} at the same rate, 25 for 5, after his own quest."] = "{item:11040} 10개마다 {npc:4217}에게 평판 50. 주머니를 간수하고 씨앗은 가는 길에 사세요. 느립니다. 반납마다 껍질 약 9개, 주머니 대기 90분, {quest:3764} 18개, 씨앗 봉지 9개, 시간당 30 평판이 조금 넘습니다. 그러니 {item:14047} 곁에서 병행하세요. {zone:1444}의 {area:1116}에 있는 {npc:7879}가 자기 퀘스트 이후 같은 비율로 {item:11040} 5개에 25를 받습니다.",

	-- Step 35: Additional Runecloth to Honored
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Honored"] = "{quest:7801}: 우호적까지",
	-- {quest:7801} Additional Runecloth · {item:14047} Runecloth · {quest:4183} The True Masters · {item:11040} Morrowgrain · {faction:69} Darnassus · {zone:1439} Darkshore · {area:415} Astranaar · {zone:1440} Ashenvale · {zone:1444} Feralas
	["{quest:7801}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a Human, Dwarf or Gnome stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Night Elves start 900 higher: 88 turn-ins; Skyborne start at Neutral 500, so 7,900 away: 158, two fewer after Exploring the Alliance). {quest:4183} and the {item:11040} chain above take 8 turn-ins off, and every 10 {item:11040} you hand in counts as one more; each hub you did takes 20 to 28 more off. More quests pay {faction:69}, in full while they are no more than 5 levels below you: the rest of {zone:1439} (about 3,400 more), {area:415} in {zone:1440} (about 3,900) and Feathermoon in {zone:1444} (about 1,700). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7801}: {item:14047} 20개에 평판 50, 제한 없이. 첫 네 번의 기부 이후 인간, 드워프, 노움은 약간 우호적 6,000 중 700 지점에 있으니 우호적까지 5,300: 106번, {item:14047} 2,120개(나이트엘프는 900에서 시작해 88번. 천공의 후손은 중립 500에서 시작해 7,900: 158번, 「얼라이언스 탐험」 이후 두 번 적게). {quest:4183}과 위의 {item:11040} 사슬이 8번을 덜어 주고, {item:11040} 10개 반납마다 한 번씩 더 세며, 지나친 허브마다 20~28번을 더 덜어 줍니다. 더 많은 퀘스트가 {faction:69}을(를) 주는데 자신보다 최대 5레벨 낮을 때 정액입니다: {zone:1439}의 나머지(약 3,400), {zone:1440}의 {area:415}(약 3,900), {zone:1444}의 페더문(약 1,700). 도시 획득은 다른 세 도시에도 4분의 1을 줍니다(여기엔 세지 않음). {item:14047}은(는) 한꺼번에 모두 반납하세요.",

	-- Step 36: Additional Runecloth to Revered
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Revered"] = "{quest:7801}: 매우 우호적까지",
	-- {item:14047} Runecloth
	["Honored: in Classic Darnassus's vendors take 10% off for you, Lelanai's nightsabers (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "우호적: 고전에서는 다르나서스 상인이 10% 할인해 주고 레라나이의 밤호랑이(20골, 빠른 것 200골)도 포함됩니다. Forever는 정하지 않았고 가이드 사이트들은 약간 우호적에서 5%, 확고한 동맹에서 20%까지 오른다고 합니다. 우호적에서 매우 우호적은 평판 12,000: 240번, {item:14047} 4,800개.",

	-- Step 37: Additional Runecloth to Exalted
	-- {quest:7801} Additional Runecloth
	["{quest:7801} to Exalted"] = "{quest:7801}: 확고한 동맹까지",
	-- {item:14047} Runecloth · {area:1658} Cenarion Enclave · {faction:69} Darnassus
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, Lelanai at the {area:1658} in {faction:69} sells her nightsabers to other races in Classic; the Saber and Swift Saber guides cover them."] = "매우 우호적에서 확고한 동맹은 평판 21,000: 420번, {item:14047} 8,400개. 확고한 동맹이면 {faction:69}의 {area:1658}에 있는 레라나이가 고전에서는 다른 종족에게 자기 밤호랑이를 팝니다. 호랑이와 빠른 호랑이 가이드가 그것을 다룹니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "{npc:8546}와(과) 어둠마법사(58-60레벨)가 이곳에서 떨어뜨립니다. 여기서 스컬지를 처치할 때마다 {object:92525} 평판에도 반영됩니다(해당 가이드 참고). 경매장도 이용할 수 있습니다.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "모래망치 오우거(45-48레벨)가 이곳에서 떨어뜨립니다. 경매장도 이용할 수 있습니다.",
	-- ["Keep handing in {quest:7801} until {faction:69} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{faction:69}와(과) 확고한 동맹이 될 때까지 {quest:7801}을(를) 계속 제출하세요. {item:14047}: {zone:1423}의 {npc:8546}와(과) 어둠마법사(58-60레벨), 또는 경매장.",
	-- ["Keep handing in {quest:7801}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7801}을(를) {item:14047} 20장씩 계속 제출하세요. {item:14047}: {zone:1423}의 {npc:8546}와(과) 어둠마법사(58-60레벨), 또는 경매장.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "{npc:452}와(과) 갈퀴발일족 전사(16-18레벨)이 이곳에서 떨어뜨립니다. 경매장도 이용할 수 있습니다.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "스트롬가드의 비밀결사대 용병(31-32레벨)이 이곳에서 떨어뜨립니다. 경매장도 이용할 수 있습니다.",
	-- ["{npc:14725} takes cloth for {faction:69} in {faction:69}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7801} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14725}은(는) {faction:69}을(를) 위해 {faction:69}에서 옷감을 받습니다. 양모, 비단, 마법 옷감, {item:14047}의 첫 기부(각 60장)는 한 번만 할 수 있으며 옷감당 평판이 가장 높습니다. 그 뒤에는 {quest:7801}을(를) 확고한 동맹까지 반복합니다. 다른 종족의 도시와 확고한 동맹이 되면 그 종족의 탈것을 살 수 있습니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{npc:14725}: {item:14047} delivered"] = "{npc:14725}: {item:14047} 기부 완료",
	-- ["{quest:7801} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7801}은(는) 제출할 때마다 {item:14047} 20장을 받으며 원하는 만큼 반복할 수 있습니다. {item:14047}을(를) 20장 단위로 가져와 한 번에 연달아 모두 제출하세요. {item:14047}: {zone:1423}의 {npc:8546}와(과) 어둠마법사(58-60레벨), 또는 경매장.",
}
