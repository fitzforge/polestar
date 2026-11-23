-- Korean (koKR): the guide forever/horde/30-40/05-arathi-highlands (forever/horde/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "{zone:1458}행 비행선",

	-- Step 2: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "{zone:1458} 상급자",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "{zone:1458}에 있는 동안 기술을 배우세요. 상급자는 {object:36070}, {object:36073}, {object:36082}에 있습니다(성기사: {npc:260093}).",

	-- Step 3: Calder Gray
	-- {npc:270038} Calder Gray
	["{npc:270038} stands in the Apothecarium."] = "{npc:270038}은(는) 연금술 실험실에 서 있습니다.",
	-- {npc:270038} Calder Gray · {zone:1441} Thousand Needles
	["{npc:270038}: Stormheart's heart from {zone:1441}"] = "{npc:270038}: {zone:1441}에서 얻은 Stormheart의 심장",

	-- Step 4: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "{area:272}(으)로 날아가기",
	-- {npc:4486} Genavie Callow · {area:340} Kargath
	["Warriors, Paladins, Rogues, Priests, Mages and Warlocks (not Hunters, Shamans or Druids): {npc:4486} stands beside the flight master. The Dabyrie family's farm lies on the road east through Arathi later in this guide, and your level 40 training brings you back to this flight master from {area:340}: she takes the heads then."] = "",
	-- {npc:4486} Genavie Callow
	["{npc:4486}, beside the flight master"] = "",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 5: Tarren Mill
	-- {npc:2229} Krusk · {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow
	["{npc:2229}, {npc:2410} and {npc:2437} are inside the inn; {npc:2770} stands outside it."] = "{npc:2229}, {npc:2410}, {npc:2437}은(는) 여관 안에 있고, {npc:2770}은(는) 여관 밖에 서 있습니다.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {item:279469} Grimy Key
	["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "",
	-- {npc:2770} Tallow · {npc:2771} Drum Fel · {area:321} Hammerfall
	["{npc:2770}: for {npc:2771} in {area:321}, later in this guide"] = "{npc:2770}: 이 가이드 후반에 {area:321}의 {npc:2771}에게 줄 것",

	-- Step 6: Southshore Stout
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{npc:2333}에게 줄 {item:3703}",

	-- Step 7: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik · {npc:2229} Krusk
	["Follow the road north out of {area:272} into the Alterac foothills: {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "{area:272}에서 길을 따라 북쪽으로 알터랙 산기슭에 들어가세요. {quest:535}은(는) 비밀결사 야영지 옆에서 기다립니다. 그는 {npc:2229}의 잠입 퀘스트를 가지고 있을 때만 심부름을 줍니다. 곧바로 흑맥주를 건네면 그 보상이 크루스크가 원하는 비밀결사 명령서입니다. 이곳 비밀결사에게서 얻은 명령서도 마찬가지입니다. 가방에 하나 있으면 가이드가 {quest:535}을(를) 건너뜁니다.",

	-- Step 8: Syndicate missives
	["Syndicate missives"] = "비밀결사대 서신",
	-- {quest:535} Valik
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one."] = "{quest:535}의 명령서를 얻지 못한 경우에만: 길 서쪽 야영지 주변의 비밀결사대 노상강도와 도둑(32-34)도 명령서를 가지고 있습니다. 약 3마리 중 1마리가 떨어뜨립니다.",

	-- Step 9: Alterac Mountains
	-- {npc:246848} Kirin Tor Guard
	["West along the foot of the hills, south of the road: a {npc:246848} (55) walks that road from the north-east down into the traitors' camp."] = "길 남쪽, 언덕 기슭을 따라 서쪽으로 가세요. {npc:246848}(55)이(가) 북동쪽에서 그 길을 따라 배신자 야영지로 내려옵니다.",
	-- {area:279} Dalaran
	["South of the {area:279} crater's camp"] = "{area:279} 분화구 야영지 남쪽",

	-- Step 10: The Dalaran crater
	-- {area:279} Dalaran
	["The {area:279} crater"] = "",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token · Kirin Tor Guards = {npc:246848} Kirin Tor Guard · Kirin Tor Enforcers = {npc:276215} Kirin Tor Enforcer
	["From the south, walk up into the camp below the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together in the camp, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens: the ones on the camp's west side are furthest from the Guard's road.\nCareful: Kirin Tor Guards (55) attack the Horde on sight, and one of them patrols the road that comes down into the camp from the north-east and walks right up to the traitors: he has killed many players here. Watch for him, let him walk back up the road, then pull the traitors. Many of the camp's guards stand in linked pairs and others patrol alone. Arcane Sentries (55, elite) and Kirin Tor Enforcers (55) stand around the violet dome itself: keep to the camp below the rim."] = "남쪽에서 {area:279}의 보랏빛 돔 아래 야영지로 올라가세요. {npc:2411}, {npc:2412}, {npc:2413}(33-34)은(는) 야영지에 함께 서 있고, {npc:2414}(35)은(는) 그 조금 서쪽에 있습니다. 각자 혈석 조각을 하나씩 가지고 있습니다. 주변의 방패 경비병과 마법사(31-33)는 닳아해진 징표의 돌을 떨어뜨립니다. 야영지 서쪽의 것들이 경비병의 길에서 가장 멉니다.\n주의: 키린 토 경비병(55)은 호드를 보자마자 공격하며, 그중 하나는 북동쪽에서 야영지로 내려오는 길을 순찰하다가 배신자들 바로 앞까지 옵니다. 이곳에서 많은 플레이어를 죽였습니다. 그를 주시하다가 길을 따라 다시 올라가면 배신자들을 끌어오세요. 야영지 경비병 중 다수는 짝지어 서 있고 일부는 혼자 순찰합니다. 비전 파수병(55, 정예)과 키린 토 집행자(55)는 보랏빛 돔 주위에 서 있습니다. 가장자리 아래 야영지에 머무르세요.",
	-- {item:279469} Grimy Key
	["{item:279469}: an object to loot, by the traitors"] = "",
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Worn Stone Tokens, from the Shield Guards and Theurgists on the camp's west side"] = "야영지 서쪽의 방패 경비병과 마법사에게서 얻는 닳아해진 징표의 돌",

	-- Step 12: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east along the foothills to {area:272}: everything from the first loop is handed in inside the inn."] = "산기슭을 따라 다시 동쪽의 {area:272}(으)로 가세요. 첫 번째 경로의 퀘스트는 모두 여관 안에서 제출합니다.",

	-- Step 14: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north up the road past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "{quest:535}의 야영지를 지나 길을 따라 북쪽으로 비밀결사가 점령한 마을 {area:280}(35-37)(으)로 가세요. {npc:2431}이(가) {item:3704}을(를) 가지고 있고, {quest:503}은(는) 북쪽 집의 우리에 갇혀 있습니다.\n주의: {area:280}에는 은신한 비밀결사 첩자가 돌아다니며, 건물 안에는 마법사를 포함한 비밀결사 몹이 많습니다.",
	["Inside"] = "",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "",
	-- {npc:2229} Krusk · {npc:2423} Lord Aliden Perenolde · {area:1339} Lordamere Lake
	["{npc:2229} will offer {npc:2423} (41, in his manor far up {area:1339}) for this: leave it, he is over your level."] = "{npc:2229}이(가) 이 퀘스트 후 {npc:2423}(41, {area:1339} 위쪽 멀리 있는 저택)을(를) 줍니다. 레벨이 너무 높으니 받지 마세요.",

	-- Step 15: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "",
	-- {area:280} Strahnbrad · {area:1357} Gallows' Corner · {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave · Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["From {area:280} follow the road south-west to {area:1357} and on west to the ruins north of the {area:279} crater, along the lake shore. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "{area:280}에서 길을 따라 남서쪽으로 {area:1357}까지 간 뒤, 호숫가를 따라 계속 서쪽으로 {area:279} 분화구 북쪽 폐허까지 가세요. 달라란 소환사가 노예 바위 정령을 이끌며, 팔보호구는 노예 바위 정령이 떨어뜨립니다. 주의: 비전 파수병(55, 정예)과 키린 토 경비병(55)이 돔을 지키며 호드를 공격합니다. 폐허 바깥쪽에서만 사냥하고 돔으로 올라가지 마세요.",

	-- Step 16: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "{area:272}(으)로 돌아가기",
	-- {area:272} Tarren Mill
	["Hearth back to {area:272} (your hearthstone is bound there), or walk back south-east along the road out of Alterac."] = "귀환석으로 {area:272}(으)로 돌아가거나(귀환석이 그곳에 귀속되어 있습니다), 알터랙에서 나가는 길을 따라 남동쪽으로 걸어서 돌아가세요.",

	-- Step 17: Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth back to {area:272}: your hearthstone is bound there."] = "귀환석으로 {area:272}(으)로 돌아가세요. 귀환석이 그곳에 귀속되어 있습니다.",
	["The magus offers a dungeon errand next: leave it."] = "",

	-- Step 18: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "",

	-- Step 19: Boulderfist camp
	["Boulderfist camp"] = "돌주먹일족 야영지",
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "",
	["Below ground"] = "지하",

	-- Step 20: Dabyrie's Farmstead
	-- {npc:4481} Marcel Dabyrie · {npc:4479} Fardel Dabyrie · {npc:4480} Kenata Dabyrie
	["On along the road east: the Dabyrie farm lies just north of it. {npc:4481} (34) and {npc:4479} (33) Dabyrie walk the farm's western yard among their Laborers and Militia (30-32); {npc:4480} (35) stands at the farm's north-eastern edge."] = "",
	-- {item:5832} Marcel's Head · {npc:4481} Marcel Dabyrie
	["{item:5832}, from {npc:4481}"] = "",
	-- {item:5831} Fardel's Head · {npc:4479} Fardel Dabyrie
	["{item:5831}, from {npc:4479}"] = "",
	-- {item:5830} Kenata's Head · {npc:4480} Kenata Dabyrie
	["{item:5830}, from {npc:4480}"] = "",

	-- Step 21: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "",

	-- Step 22: Hammerfall
	-- {npc:2851} Urda · {npc:15126} Rutherford Twing · {quest:8263} Defiler's Basic Care Package · {zone:1461} Arathi Basin
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "{npc:2792}, 성문 옆",
	-- {npc:12920} Doctor Gregory Victor · {skill:129} First Aid
	["{npc:12920}, at the south gate. If {npc:12920} offers nothing, another player may be running his {skill:129} quest Triage: he can be busy for a few minutes. Wait, then talk to him again."] = "{npc:12920}, 남쪽 관문. {npc:12920}이(가) 아무것도 주지 않으면 다른 플레이어가 {skill:129} 퀘스트 '환자 분류'를 진행 중일 수 있으며, 몇 분간 바쁠 수 있습니다. 기다렸다가 다시 말을 거세요.",

	-- Step 23: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "",

	-- Step 24: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "",

	-- Step 25: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701}은(는) 골짜기 맨 끝에 있습니다.",

	-- Step 26: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "",

	-- Step 27: Witherbark Village
	["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "",

	-- Step 28: Highland raptors and Plains Creepers
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["Highland raptors and Plains Creepers"] = "",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider · Plains Creepers = {npc:2563} Plains Creeper
	["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "",
	-- {item:278225} Surgical Spidersilk
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["{item:278225}, from Plains Creepers"] = "",

	-- Step 29: Hammerfall
	-- {area:321} Hammerfall
	["Back north to {area:321}: the doctor stands at the south gate."] = "북쪽 {area:321}(으)로 돌아가세요. 의사는 남쪽 관문에 서 있습니다.",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate. If he won't take the silk, another player may be running Triage: wait a few minutes and talk to him again."] = "{npc:12920}, 남쪽 관문. 비단을 받지 않으면 다른 플레이어가 '환자 분류'를 진행 중일 수 있습니다. 몇 분 기다렸다가 다시 말을 거세요.",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "",

	-- Step 30: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "돌주먹일족 투사는 {area:321} 남서쪽 멀리 있는 오우거 전당 밖에 야영하고 있으며, 사제가 그들 사이에 있습니다. 한 번에 하나씩 끌어오세요.",

	-- Step 31: Fleshstalker raptors
	["Fleshstalker raptors"] = "식인 고원랩터",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "식인 고원랩터(36-37)는 고원 남부에서 사냥합니다. 한 무리는 {area:316} 북쪽에, 다른 무리는 그 서쪽 평원에 있습니다. 한 번에 한 마리씩 끌어오세요.",

	-- Step 32: Go'shek Farm
	["Go'shek Farm"] = "",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "",

	-- Step 33: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "{area:321}(으)로 돌아가기",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "",

	-- Step 34: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "",

	-- Step 35: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "",

	-- Step 36: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "",

	-- Step 37: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "안쪽 결속의 원은 서쪽 결속의 원 남쪽, 스트롬가드 동쪽에 있습니다.",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "",

	-- Step 38: Stromgarde
	["Stromgarde"] = "",
	-- {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "안쪽 성벽 서쪽은 스트롬가드 폐허입니다. 동쪽 절반은 신디케이트가 차지하고 있으며(인장은 신디케이트 요술사, 배회자, 마법사가 떨어뜨립니다), 서쪽 절반은 {area:325} 옆으로 돌주먹일족이 차지하고 있습니다({npc:2773}은(는) 그 옆 지붕 없는 집 중 하나에서 기다립니다).",

	-- Step 39: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "",

	-- Step 40: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "",

	-- Step 42: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["Careful: west of the cove the Daggerspine Raiders and Sorceresses (38-40) stand close together on the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks.\nCareful: the charts and logs lie deep inside the wrecks: watch your breath bar and come up between them; a water breathing potion makes it easy."] = "",
	["Underwater"] = "물속",

	-- Step 43: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "",

	-- Step 44: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {object:1763} poster by the inn"] = "여관 옆의 {object:1763} 게시판",
	-- ["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "만 서쪽 해안은 비수가시일족 침략자와 여마법사(38-40)가 차지하고 있습니다. 한 번에 하나씩 끌어오세요. 난파선 두 척은 앞바다 얕은 물에 있으며, 해도와 항해일지는 그 안에, 보석은 난파선 주변 해저에 있습니다.",
}
