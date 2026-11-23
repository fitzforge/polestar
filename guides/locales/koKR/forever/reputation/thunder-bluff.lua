-- Korean (koKR): the guide forever/reputation/thunder-bluff (forever/reputation/thunder-bluff.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thunder Bluff Reputation"] = "썬더 블러프 평판",
	-- {zone:1412} Mulgore · {zone:1452} Winterspring · {item:11040} Morrowgrain · {item:14047} Runecloth
	["{zone:1412} quests while you level, {zone:1452} quests and {item:11040} from 55, then {item:14047} to Exalted."] = "레벨을 올리며 {zone:1412} 퀘스트, 55부터 {zone:1452} 퀘스트와 {item:11040}, 그다음 {item:14047}로 확고한 동맹까지.",
	-- {faction:81} Thunder Bluff
	["Exalted with {faction:81}"] = "{faction:81}과(와) 확고한 동맹",

	-- Step 1: Thunder Bluff: how it works
	-- {faction:81} Thunder Bluff
	["{faction:81}: how it works"] = "{faction:81}: 작동 방식",
	-- {faction:81} Thunder Bluff · {item:11040} Morrowgrain · {npc:14728} Rumstag Proudstrider · {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1412} Mulgore · {area:378} Camp Taurajo · {zone:1441} Thousand Needles
	["{faction:81} reputation comes from quests, {item:11040} and cloth. {npc:14728}, the cloth quartermaster, stands on the central rise among the leatherworkers' and tailors' tents. He takes four one-time donations of 60 cloth (150 each) and then {quest:7825}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:81} also gives a quarter as much to {zone:1454}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:81}'s quests within 5 levels of them: {zone:1412} at 1 to 12, {area:378} and the Crossroads at 13 to 22, {zone:1441} at 25 to 30. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Thunder Bluff's merchants sell to you for 10% less (the Classic rule), the kodo vendor included; at Exalted other races can buy the kodos: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60, once you have mount training. {faction:81} has no tabard or other reward."] = "{faction:81} 평판은 퀘스트, {item:11040}, 옷감에서 옵니다. 옷감 병참장교 {npc:14728}은(는) 가죽세공인과 재단사 천막 사이 중앙 언덕에 서 있습니다. 그는 옷감 60개 기부 넷(각 150)을 받고, 이어서 {item:14047} 20개당 50의 {quest:7825}를 제한 없이 받습니다. {faction:81}에서 얻는 포인트마다 {zone:1454}, {zone:1458}, 다크스펠 트롤에게 4분의 1을 더 줍니다. 레벨을 올리며 자신과 5레벨 차 안의 {faction:81} 퀘스트를 하세요: {zone:1412} 1~12, {area:378}와 십자로 13~22, {zone:1441} 25~30. 유산 특성 외교관이 최대 10%를 더합니다. 보상: 우호적이면 썬더 블러프 상인이 10% 할인해 주고(고전 규칙) 코도 상인도 포함되며, 확고한 동맹이면 다른 종족도 코도를 삽니다. 40레벨 코도 20골, 60레벨 거대 코도 200골로 탈것 훈련을 마친 뒤입니다. {faction:81}에게는 문장이나 다른 보상이 없습니다.",
	["his donations are handed in from his window and never enter the log"] = "그에게 하는 기부는 대화창에서 바로 제출하며 퀘스트 목록에 들어가지 않습니다",

	-- Step 2: Camp Narache (optional hub)
	-- {area:221} Camp Narache
	["{area:221} (optional hub)"] = "{area:221} (선택 허브)",
	-- {area:221} Camp Narache · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2980} Grull Hawkwind · {npc:2981} Chief Hawkwind · {npc:3209} Brave Windfeather
	["Forever pays these old quests in full at any level. {area:221}, at the south end of {zone:1412}: about 1,100 {faction:81} reputation in 25 minutes. Starting-zone quests give the other cities no share. {npc:2980} and {npc:2981} stand in the camp, {npc:3209} at its edge."] = "Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. {zone:1412} 남쪽 끝의 {area:221}: 25분에 약 1,100 {faction:81} 평판. 시작 지역 퀘스트는 다른 도시에 몫을 주지 않습니다. {npc:2980}과(와) {npc:2981}이(가) 야영지에, {npc:3209}이(가) 가장자리에 서 있습니다.",

	-- Step 3: Greatmother Hawkwind and the plains
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991} and the plains"] = "{npc:2991}과(와) 평원",
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991}'s tent is south-east of the camp; the water pitcher stands at the well beside it. Plainstriders graze all around."] = "{npc:2991}의 천막은 야영지 남동쪽에 있고 물항아리는 그 옆 우물에 있습니다. 평원뛰기가 주변에 모두 풀을 뜯습니다.",

	-- Step 4: Camp Narache: hand in
	-- {area:221} Camp Narache
	["{area:221}: hand in"] = "{area:221}: 반납",

	-- Step 5: Seer Graytongue and the cougars
	-- {npc:2982} Seer Graytongue
	["{npc:2982} and the cougars"] = "{npc:2982}와(과) 쿠거",
	-- {npc:2982} Seer Graytongue
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:2982} sits on the hill south of the camp; the Mountain Cougars live in those hills."] = "{npc:2982}은(는) 야영지 남쪽 언덕에 앉아 있고, 산지퓨마는 그 언덕에 삽니다.",

	-- Step 6: Camp Narache: the Battleboars
	-- {area:221} Camp Narache
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["{area:221}: the Battleboars"] = "{area:221}: 전투멧돼지",

	-- Step 7: Brambleblade Ravine
	-- {quest:780} The Battleboars · {npc:8554} Chief Sharptusk Thornmantle · {area:358} Brambleblade Ravine · {item:4851} Dirt-stained Map · {quest:781} Attack on Camp Narache
	["{quest:780} graze east of the camp; the Bristleback quilboar and {npc:8554} hold {area:358} beyond them. A {item:4851} lies in the ravine: reading it starts {quest:781}."] = "{quest:780}은(는) 야영지 동쪽에서 풀을 뜯고, 가시등골 퀼보어와 {npc:8554}이(가) 그 너머 {area:358}을(를) 지킵니다. {item:4851}이(가) 협곡에 있습니다. 읽으면 {quest:781}이(가) 시작됩니다.",

	-- Step 8: Camp Narache: last hand-in
	-- {area:221} Camp Narache
	["{area:221}: last hand-in"] = "{area:221}: 마지막 반납",
	-- {quest:763} Rites of the Earthmother · {npc:2993} Baine Bloodhoof
	["{quest:763}, +75: to {npc:2993}"] = "{quest:763}, +75: {npc:2993}에게",

	-- Step 10: Bloodhoof Village (optional hub)
	-- {area:222} Bloodhoof Village
	["{area:222} (optional hub)"] = "{area:222} (선택 허브)",
	-- {area:222} Bloodhoof Village · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2993} Baine Bloodhoof · {npc:2947} Harken Windtotem · {npc:2985} Ruul Eagletalon · {npc:3222} Brave Wildrunner · {npc:2988} Morin Cloudstalker
	["Forever pays these old quests in full at any level. {area:222} and eastern {zone:1412}: about 1,000 {faction:81} reputation in 45 minutes. {npc:2993} stands in the middle of the village; {npc:2947}, {npc:2985} and {npc:3222} close by; {npc:2988} waits east of the village by the road."] = "Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. {area:222}와(과) 동부 {zone:1412}: 45분에 약 1,000 {faction:81} 평판. {npc:2993}이(가) 마을 한가운데 서 있고, {npc:2947}, {npc:2985}, {npc:3222}이(가) 가까이, {npc:2988}이(가) 마을 동쪽 길가에서 기다립니다.",

	-- Step 11: Eastern Mulgore
	-- {zone:1412} Mulgore
	["Eastern {zone:1412}"] = "동부 {zone:1412}",
	-- {quest:99079} Longwalker Malah · {object:2908} Sealed Supply Crate
	["{quest:99079} waits by the eastern border. The {object:2908} of the ravaged caravan lies north-east of the village: open it to start the next quest."] = "{quest:99079}이(가) 동쪽 경계에서 기다립니다. 약탈당한 상단의 {object:2908}이(가) 마을 북동쪽에 있습니다. 열면 다음 퀘스트가 시작됩니다.",
	-- {object:2908} Sealed Supply Crate
	["the {object:2908}"] = "{object:2908}",

	-- Step 12: Bloodhoof Village: hand in
	-- {area:222} Bloodhoof Village
	["{area:222}: hand in"] = "{area:222}: 반납",

	-- Step 13: The mine, the centaurs and the plains
	["The mine, the centaurs and the plains"] = "광산, 켄타우로스, 평원",
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes · {zone:1412} Mulgore
	["Back to the mine for the workers, supervisors and {quest:765} in the back: his {item:281031} start {quest:98424}, and its other pages lie inside the mine. The Galak centaurs and Herak camp east of the village. Swoops fly all over {zone:1412}; the Windfury harpies roost south-east of the village; the Palemane gnolls camp west of it."] = "일꾼, 감독, 안쪽의 {quest:765}를 위해 다시 광산으로: 그의 {item:281031}이(가) {quest:98424}를 시작하고 나머지 페이지는 광산 안에 있습니다. 갤락 켄타우로스와 헤라크 야영지가 마을 동쪽에 있습니다. 스윕은 {zone:1412} 전역을 날고, 바람분노 하피는 마을 남동쪽에 둥지를 틀고, 창백가죽 그놀은 서쪽에 야영합니다.",
	-- {item:281031} Mulgore Expansion Plans · {quest:765} Supervisor Fizsprocket
	["{item:281031}, from {quest:765}"] = "{item:281031}, {quest:765}에게서",
	-- {item:281035} Shredder Operation Instructions
	["{item:281035}, inside the mine"] = "{item:281035}, 광산 안",

	-- Step 14: Morin Cloudstalker
	-- {quest:98427} Ceasing Operations · {quest:98424} Fizsprocket's Notes
	["{quest:98427}, +150: needs {quest:98424}"] = "{quest:98427}, +150: {quest:98424}가 필요",

	-- Step 15: The Venture Co. Mine: the Clearcutter
	-- {area:360} The Venture Co. Mine
	["{area:360}: the Clearcutter"] = "{area:360}: 클리어커터",
	-- {npc:272173} Venture Co. Clearclutter · {quest:98427} Ceasing Operations
	-- was: ["The elite shredder Venture Co. Clearcutter works deep inside the mine, beyond where Fizsprocket stood: its key is for {quest:98427}."] = "정예 파쇄기계 투자개발회사 클리어커터가 피즈스프로킷이 서 있던 곳 너머 광산 깊은 곳에서 일합니다. 그 열쇠가 {quest:98427}용입니다."
	["The elite shredder {npc:272173} works deep inside the mine, beyond where Fizsprocket stood: its key is for {quest:98427}."] = "",

	-- Step 16: Bloodhoof Village: last hand-in
	-- {area:222} Bloodhoof Village
	["{area:222}: last hand-in"] = "{area:222}: 마지막 반납",
	-- {quest:99082} The High Chieftain · {npc:3057} Cairne Bloodhoof · {faction:81} Thunder Bluff
	["{quest:99082}, +10: to {npc:3057} in {faction:81}"] = "{quest:99082}, +10: {faction:81}의 {npc:3057}에게",

	-- Step 18: Gloomrise (optional hub)
	-- {area:17044} Gloomrise
	["{area:17044} (optional hub)"] = "{area:17044} (선택 허브)",
	-- {area:17045} Skywatcher Plateau · {faction:81} Thunder Bluff · {zone:1454} Orgrimmar · {npc:259118} Muln Earthfury · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem
	["Forever pays these old quests in full at any level. The Earthen Ring camp on the {area:17045}, north-west of {faction:81}: 300 {faction:81} reputation in 20 minutes, plus 100 each for {zone:1454} and the Darkspear Trolls and 450 Earthen Ring. {npc:259118}, {npc:264074} and {npc:264072} stand in the camp."] = "Forever는 이 오래된 퀘스트를 어떤 레벨에서도 정액으로 줍니다. {faction:81} 북서쪽 {area:17045}의 대지의 고리 야영지: 20분에 {faction:81} 평판 300, 덤으로 {zone:1454}와(과) 다크스펠 트롤에 각각 100, 대지의 고리에 450. {npc:259118}, {npc:264074}, {npc:264072}이(가) 야영지에 서 있습니다.",
	-- {npc:259118} Muln Earthfury · {quest:96259} Defending the Dead · {quest:96261} The Broodmother
	["{npc:259118}: {quest:96259}, +100 ({quest:96261} comes once it is handed in)"] = "{npc:259118}: {quest:96259}, +100 ({quest:96261}은(는) 반납하면 온다)",
	-- {npc:264074} Mazu'kon · {quest:96241} Talkin' bout Toxins, Mon
	["{npc:264074}: {quest:96241} (Darkspear +100)"] = "{npc:264074}: {quest:96241} (다크스펠 +100)",

	-- Step 19: Gloomrise
	-- {area:17044} Gloomrise · {faction:81} Thunder Bluff · {item:273015} Toxin Extractor · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["{area:17044} is the tauren burial ground north of {faction:81}. Use the {item:273015} on the Gnawed Corpses. {npc:264082} waits at the heart of it; her body carries a {item:273658}: read it to start {quest:96294}."] = "{area:17044}은(는) {faction:81} 북쪽의 타우렌 매지터입니다. 갉아먹힌 시체에게 {item:273015}을(를) 사용하세요. {npc:264082}이(가) 그 심장부에서 기다리고, 그녀의 몸에는 {item:273658}이(가) 있습니다. 읽으면 {quest:96294}가 시작됩니다.",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{npc:264081}에게서 얻는 {item:273181}",

	-- Step 20: The Skywatcher camp: hand in
	["The Skywatcher camp: hand in"] = "하늘감시 야영지: 반납",
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother · {quest:96259} Defending the Dead
	["{npc:259118} offers {quest:96261} only once {quest:96259} is handed in."] = "{npc:259118}은(는) {quest:96259}을(를) 반납한 뒤에만 {quest:96261}을(를) 줍니다.",

	-- Step 21: Broodmother Valraxx
	-- {npc:264082} Broodmother Valraxx · {area:17044} Gloomrise
	["{npc:264082}, at the heart of {area:17044}"] = "{npc:264082}, {area:17044} 심장부",

	-- Step 23: Rumstag Proudstrider: A Donation of Wool
	-- {npc:14728} Rumstag Proudstrider · {item:14047} Runecloth · {quest:7825} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14728} offers the {item:14047} donation, and {quest:7825} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "여기부터는 옷감입니다. 양모, 비단, 마법천은 {npc:14728}이(가) {item:14047} 기부를 제공하기 전에 모두 반납해야 하고, {quest:7825}은(는) {item:14047} 기부가 필요합니다. 경매장에서 옷감을 사거나 직접 모으세요. 인간형이 떨어뜨리는데 양모는 15~25레벨, 비단은 25~40, 마법천은 40~50, {item:14047}은(는) 50 이상입니다. 60이면 52레벨 이상 몹을 사냥하세요. 낮은 것은 회색입니다.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}: 가시털일족 퓨볼그가 4킬에 한 번꼴로 떨어뜨립니다",

	-- Step 24: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "비단: {area:287}과(와) 알터랙의 신디케이트가 3킬에 한 번꼴로 떨어뜨리거나 삽니다.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}: 신디케이트",

	-- Step 25: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "마법 옷감: {zone:1448} 남부의 비취불 사티로스와 {zone:1446}의 모래망치 오우거가 3킬에 한 번꼴로 떨어뜨리거나 삽니다.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}: 비취불 사티로스",

	-- Step 26: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}: {zone:1423}의 {area:2266}에 있는 스칼렛, {zone:1444}의 {area:2577} 밖 고르독 오우거, {zone:1451}의 황혼 야영지가 3킬에 한 번꼴로 떨어뜨립니다. 골드가 있다면 경매장이 더 빠릅니다.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}: {area:2266} 바깥의 스칼렛",

	-- Step 27: Everlook: Storm Shadowhoof
	-- {npc:10303} Storm Shadowhoof · {faction:81} Thunder Bluff · {npc:10806} Ursius · {area:2255} Everlook
	["{npc:10303}'s four quests are level 56 to 60, so they pay in full: 400 {faction:81} reputation. {npc:10806}, an elite bear, walks a loop over the four hills north of {area:2255}: wait on a hilltop for him."] = "{npc:10303}의 퀘스트 넷은 56~60레벨이니 정액을 줍니다: {faction:81} 평판 400. 정예 곰 {npc:10806}은(는) {area:2255} 북쪽 언덕 넷을 순회합니다. 언덕꼭대기에서 그를 기다리세요.",
	-- {npc:10806} Ursius
	["{npc:10806}, elite"] = "{npc:10806}, 정예",

	-- Step 28: Brumeran and Shy-Rotam
	-- {npc:10807} Brumeran · {quest:5056} Shy-Rotam
	["{npc:10807} and {quest:5056}"] = "{npc:10807}와(과) {quest:5056}",
	-- {npc:10807} Brumeran · {area:2255} Everlook · {quest:5056} Shy-Rotam · {item:12733} Sacred Frostsaber Meat · {object:103819} Stone of Shy-Rotam (no name in this language: may be words) · {npc:10306} Trull Failbane · {zone:1454} Orgrimmar · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets · {faction:81} Thunder Bluff
	["{npc:10807}, an elite chimera, spawns south of {area:2255}. For {quest:5056}, kill frostsabers north of {area:2255} until one drops {item:12733} (about one in ten), then use the meat at the {object:103819}, far to the north, and kill the great cat that comes. If you have done {npc:10306}'s Wild Guardians quests (the {zone:1454} guide), the Crazed, Moontouched and Berserk owlbeasts around {area:2255} sometimes drop a {item:12558}: it starts {quest:4882}, 50 {zone:1454} and then 100 {faction:81} reputation in full."] = "{npc:10807}, 정예 키메라가 {area:2255} 남쪽에 나타납니다. {quest:5056}을(는) 위해 {area:2255} 북쪽의 서리갈기를 열 명 중 한 명 꼴로 {item:12733}이(가) 떨어질 때까지 잡은 뒤, 그 고기를 아주 북쪽의 {object:103819}에서 사용하고 나타나는 큰 고양이를 잡으세요. {npc:10306}의 야생 수호 퀘스트({zone:1454} 가이드)를 했다면 {area:2255} 주변의 미친, 달빛받은, 광포한 올빼미야수가 가끔 {item:12558}을(를) 떨어뜨립니다. 그것이 {quest:4882}를 시작하고, {zone:1454} 50과 이어서 {faction:81} 100을 정액으로 줍니다.",
	-- {npc:10807} Brumeran
	["{npc:10807}, elite"] = "{npc:10807}, 정예",
	-- {item:12733} Sacred Frostsaber Meat
	["{item:12733}, from the frostsabers"] = "{item:12733}, 서리갈기에게서",

	-- Step 29: Bloodvenom Post: Trull Failbane
	-- {npc:10306} Trull Failbane · {area:1997} Bloodvenom Post · {zone:1452} Winterspring
	["{npc:10306} stands at {area:1997}, through the Timbermaw tunnel south of {zone:1452}."] = "{npc:10306}이(가) {zone:1452} 남쪽 나무굴 터널을 지나 {area:1997}에 서 있습니다.",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {faction:81} Thunder Bluff
	["{quest:4882}, +100: to {npc:5770} in {faction:81}"] = "{quest:4882}, +100: {faction:81}의 {npc:5770}에게",

	-- Step 31: Thunder Bluff: Nara Wildmane
	-- {npc:5770} Nara Wildmane · {area:1639} Elder Rise · {npc:5769} Arch Druid Hamuul Runetotem
	["{npc:5770} stands on {area:1639}, beside {npc:5769}."] = "{npc:5770}이(가) {npc:5769} 옆 {area:1639}에 서 있습니다.",

	-- Step 32: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "{item:11040} (선택)",
	-- {quest:3804} Morrowgrain to Thunder Bluff · {item:11040} Morrowgrain · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {npc:6746} Innkeeper Pala · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{quest:3804} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60, but it is slow: the {item:11020} grows one casing every 10 minutes and a casing holds about one {item:11040} on average, so each hand-in takes about 90 minutes of waiting, 18 {quest:3761} and 9 seed packets (90 silver). It runs beside whatever else you do: a little over 30 reputation an hour. The chain before it is level 50. {npc:6746} sends you to {npc:5769} on {area:1639}; he wants 20 {quest:3761}."] = "{quest:3804}이(가) {item:11040} 10개를 50에 제한 없이 받고 60에서 정액을 주지만 느립니다. {item:11020}이(가) 10분마다 껍질 하나를 키우고 껍질에는 평균 {item:11040} 하나가 들어 있으니 반납마다 약 90분을, {quest:3761} 18개와 씨앗 봉지 9개(90실버)를 기다려야 합니다. 다른 일과 함께 진행됩니다: 시간당 약 30 평판이 조금 넘습니다. 앞의 사슬은 50레벨입니다. {npc:6746}이(가) {area:1639}의 {npc:5769}에게 보내고, 그는 {quest:3761} 20개를 원합니다.",

	-- Step 33: Un'Goro Crater: Un'Goro Soil
	-- {quest:3761} Un'Goro Soil · {item:11040} Morrowgrain
	["Nearly every beast, plant and silithid in the crater drops {quest:3761}, about one kill in three (the Bloodpetals and the Gorishi wasps about one in two), and the dirt mounds give it too. Take far more than 20: every casing uses 2, about 18 for each {item:11040} hand-in."] = "분화구의 야수, 식물, 실리시드 거의 모두가 {quest:3761}을(를) 떨어뜨리고 처치 셋 중 하나 꼴입니다(피잎과 고리시 말벌은 둘 중 하나). 흙 더미도 줍니다. 20개보다 훨씬 더 가져가세요. 껍질마다 2개, {item:11040} 반납마다 약 18개를 씁니다.",

	-- Step 34: Thunder Bluff: Morrowgrain Research
	-- {npc:9076} Ghede · {npc:9087} Bashana Runetotem · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9076} takes the soil. {npc:9087} sells the {item:11020} (1 gold) and Packets of Tharlendris Seeds (10 silver each). With a seed packet and 2 {quest:3761} in your bags, use the pouch: it grows an {item:11024}, once every 10 minutes. Open each casing: about one in three holds 1 to 5 {item:11040}, the rest common herbs. Use the pouch whenever it is ready while you follow the rest of this guide."] = "{npc:9076}이(가) 흙을 받습니다. {npc:9087}이(가) {item:11020}(1골)과 탈렌드리스 씨앗 봉지(개당 10실버)를 팝니다. 씨앗 봉지 하나와 가방에 {quest:3761} 둘을 넣고 주머니를 사용하세요. 10분마다 {item:11024}를 하나 키웁니다. 각 껍질을 열면 셋 중 하나꼴로 {item:11040} 1~5개, 나머지는 일반 약초입니다. 이 가이드의 나머지를 따라가며 준비되는 대로 주머니를 사용하세요.",
	-- {item:11020} Evergreen Pouch
	["{item:11020}, 1 gold"] = "{item:11020}, 1골",
	-- {item:11022} Packet of Tharlendris Seeds
	["{item:11022}, 10 silver each"] = "{item:11022}, 개당 10실버",

	-- Step 35: Morrowgrain as you go
	-- {item:11040} Morrowgrain
	["{item:11040} as you go"] = "이동하며 {item:11040} 모으기",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}: use the pouch every 10 minutes and open the casings; {npc:9087} takes it"] = "{item:11040}: 10분마다 주머니를 사용하고 껍질을 열 것. {npc:9087}이(가) 받습니다",

	-- Step 36: Bashana Runetotem: Morrowgrain Research
	-- {npc:9087} Bashana Runetotem · {area:1639} Elder Rise · {item:11040} Morrowgrain
	["{npc:9087} stands on {area:1639}. If your 10 {item:11040} are not ready yet, skip this step and go on with the cloth: the cloth steps below list the {item:11040} hand-in too."] = "{npc:9087}이(가) {area:1639}에 서 있습니다. {item:11040} 10개가 아직 준비되지 않았다면 이 단계를 건너뛰고 옷감을 이어가세요. 아래 옷감 단계에도 {item:11040} 반납이 나옵니다.",

	-- Step 37: Additional Runecloth to Honored
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Honored"] = "{quest:7825}: 우호적까지",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth
	["{quest:7825}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (a tauren starts at Friendly 1,000: 100 hand-ins; an Undead at Neutral 500 first needs 50 more to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7825}: {item:14047} 20개에 평판 50, 제한 없이. 약간 우호적에서 우호적은 6,000: 120번, {item:14047} 2,400개. 퀘스트가 준 만큼은 덜습니다(타우렌은 약간 우호적 1,000에서 시작: 100번. 언데드는 중립 500이라 약간 우호적까지 50을 더 모아야 합니다). 가지고 있는 20개를 계속 반납하세요.",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}, if you grow it: {npc:9087} takes it"] = "{item:11040}, 기르는 경우: {npc:9087}이(가) 받습니다",

	-- Step 38: Additional Runecloth to Revered
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Revered"] = "{quest:7825}: 매우 우호적까지",
	-- {item:14047} Runecloth · {item:11040} Morrowgrain · {area:1584} Blackrock Depths · {area:340} Kargath · {npc:9017} Lord Incendius
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}, fewer if you also hand in {item:11040}. {area:1584} pays too: Disharmony of Flame and Disharmony of Fire from Thunderheart at {area:340} ({npc:9017}, 150 in full)."] = "우호적에서 매우 우호적은 12,000: 240번, {item:14047} 4,800개. {item:11040}도 반납하면 더 적습니다. {area:1584}도 줍니다: {area:340}의 선흐르는가슴에서 {npc:9017}에게 불의 부조화와 불의 이견(정액 150).",
	-- {item:11040} Morrowgrain
	["{item:11040}, if you grow it"] = "{item:11040}, 기르는 경우",

	-- Step 39: Additional Runecloth to Exalted
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Exalted"] = "{quest:7825}: 확고한 동맹까지",
	-- {item:14047} Runecloth · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:3685} in {area:222} sells the kodos to every Horde race: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "매우 우호적에서 확고한 동맹은 21,000: 420번, {item:14047} 8,400개. 「호드를 위하여!」(렌드의 머리)와 검은바위의 군주(네파리안의 머리)가 모든 호드 도시에 200을 줍니다. 확고한 동맹이면 {area:222}의 {npc:3685}이(가) 모든 호드 종족에게 코도를 팝니다. 40레벨 코도 20골, 60레벨 거대 코도 200골(Forever 가격)입니다. 고전에서는 다른 종족이 사려면 확고한 동맹이 필요했습니다.",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685}: the kodos"] = "{npc:3685}: 코도",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "{npc:8546}와(과) 어둠마법사(58-60레벨)가 이곳에서 떨어뜨립니다. 여기서 스컬지를 처치할 때마다 {object:92525} 평판에도 반영됩니다(해당 가이드 참고). 경매장도 이용할 수 있습니다.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "모래망치 오우거(45-48레벨)가 이곳에서 떨어뜨립니다. 경매장도 이용할 수 있습니다.",
	-- ["Keep handing in {quest:7825} until {faction:81} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{faction:81}와(과) 확고한 동맹이 될 때까지 {quest:7825}을(를) 계속 제출하세요. {item:14047}: {zone:1423}의 {npc:8546}와(과) 어둠마법사(58-60레벨), 또는 경매장.",
	-- ["Keep handing in {quest:7825}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7825}을(를) {item:14047} 20장씩 계속 제출하세요. {item:14047}: {zone:1423}의 {npc:8546}와(과) 어둠마법사(58-60레벨), 또는 경매장.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "콜카르 켄타우로스(30-33레벨)가 이곳에서 떨어뜨립니다. 경매장도 이용할 수 있습니다.",
	-- ["The elite shredder Venture Co. Clearcutter works deep inside the mine, beyond where Fizsprocket stood: its key is for {quest:98427}."] = "정예 파쇄기계 투자개발회사 클리어커터가 피즈스프로킷이 서 있던 곳 너머 광산 깊은 곳에서 일합니다. 그 열쇠가 {quest:98427}용입니다.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}의 {npc:3283}(16-17레벨)이 이곳에서 떨어뜨립니다. 경매장도 이용할 수 있습니다.",
	-- ["{npc:14728} takes cloth for {faction:81} in {faction:81}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7825} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14728}은(는) {faction:81}을(를) 위해 {faction:81}에서 옷감을 받습니다. 양모, 비단, 마법 옷감, {item:14047}의 첫 기부(각 60장)는 한 번만 할 수 있으며 옷감당 평판이 가장 높습니다. 그 뒤에는 {quest:7825}을(를) 확고한 동맹까지 반복합니다. 다른 종족의 도시와 확고한 동맹이 되면 그 종족의 탈것을 살 수 있습니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{npc:14728}: {item:14047} delivered"] = "{npc:14728}: {item:14047} 기부 완료",
	-- ["{quest:7825} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7825}은(는) 제출할 때마다 {item:14047} 20장을 받으며 원하는 만큼 반복할 수 있습니다. {item:14047}을(를) 20장 단위로 가져와 한 번에 연달아 모두 제출하세요. {item:14047}: {zone:1423}의 {npc:8546}와(과) 어둠마법사(58-60레벨), 또는 경매장.",
}
