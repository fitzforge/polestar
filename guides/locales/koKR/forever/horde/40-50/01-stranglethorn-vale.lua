-- Korean (koKR): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1434} Stranglethorn Vale · {zone:1435} Swamp of Sorrows · {object:3202} Grom'gol · {area:35} Booty Bay · {area:75} Stonard
	["{zone:1434} and the {zone:1435} at 40-43: {object:3202}, {area:35}'s pirates, Nesingwary's hunts and {area:75}."] = "40-43레벨 {zone:1434}와(과) {zone:1435}: {object:3202}, {area:35}의 해적, 네싱워리의 사냥, {area:75}.",

	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "{area:1497}(으)로 비행",
	-- {area:1497} Undercity · {area:340} Kargath · {object:3202} Grom'gol
	["Your level 40 training is in the {area:1497}: fly there from {area:340}, train, and take the zeppelin from the towers outside the city to {object:3202}."] = "40레벨 훈련은 {area:1497}에서 합니다. {area:340}에서 그곳으로 날아가 훈련한 뒤, 도시 밖 탑에서 비행선을 타고 {object:3202}(으)로 가십시오.",
	-- {area:340} Kargath
	["{area:340} flight master"] = "{area:340} 비행 조련사",

	-- Step 2: Undercity trainers
	-- {area:1497} Undercity
	["{area:1497} trainers"] = "{area:1497} 상급자",

	-- Step 3: Riding at 40
	["Riding at 40"] = "40레벨 탈것 타기",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "탈것 타기는 40레벨이 필요하며 100골드가 듭니다. 배우면 탈것도 하나 받습니다. 각 종족은 자기 종족의 상급자에게서 배웁니다. 당신의 상급자는 비행선 탑에서 북쪽으로 조금 가면 나오는 {area:159}의 {npc:4773}이며, 그 옆에 {npc:4731}의 해골마(각 20골드)가 있습니다. {object:3202}행 비행선을 타려면 탑으로 돌아가십시오.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, 탈것 상급자",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "해골마: {area:159}의 {npc:4773} 옆에 있는 {npc:4731}.",

	-- Step 4: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "{object:3202}행 비행선",

	-- Step 5: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "{object:3202}(으)로 날아가기",

	-- Step 6: Grom'gol Base Camp
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "",

	-- Step 7: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "줄무늬정글랩터",
	-- {object:3202} Grom'gol
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "줄무늬정글랩터(40-41)는 {object:3202} 남쪽 해안에서 사냥합니다. 레벨이 훨씬 높으니 한 마리씩 끌어오고 전투 사이에 쉬세요.",

	-- Step 9: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "{area:35}(으)로 날아가기",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 10: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "비행 조련사 그링거는 {area:35}의 위쪽 갑판에서 기다립니다. 퀘스트 제공자는 항구 주변 판자길과 여관에 있습니다.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "",
	-- {npc:2495} Drizzlik · {npc:2635} Elder Saltwater Crocolisk · {object:3202} Grom'gol
	["{npc:2495}: the {npc:2635} suns on the coast between Zul'Kunda and {object:3202}, later on this loop"] = "{npc:2495}: {npc:2635}은(는) 줄쿤다와 {object:3202} 사이 해안에서 햇볕을 쬐고 있습니다. 이 경로 후반에 들릅니다",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks: Gazlowe's letter, if you carry it"] = "{npc:4631}, 부두: 가즐로가 보낸 편지를 가지고 있다면",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony beside MacKinley"] = "{npc:2496}, 맥킨리 옆 발코니",
	["Inside"] = "",

	-- Step 11: Baron Revilgaz
	-- {npc:2496} Baron Revilgaz · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["{npc:2496}, on the balcony beside MacKinley, has one more errand: the fuel regulator blueprints from Cozzle's footlocker go to Pozzik at the {area:2240}, on the way to {zone:1446} around level 43."] = "맥킨리 옆 발코니의 {npc:2496}에게 심부름이 하나 더 있습니다. 코즐의 사물함에서 얻는 연료 조절기 설계도를 약 43레벨에 {zone:1446}(으)로 가는 길, {area:2240}의 포직에게 가져갑니다.",

	-- Step 12: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "터널로 마을을 나가세요. 쪽지는 {area:35} 바로 북쪽의 해적 만에 있습니다.",

	-- Step 14: Mistvale gorillas
	["Mistvale gorillas"] = "안개계곡고릴라",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "고릴라는 운바그와 주변 골짜기를 돌아다닙니다. 덩치큰 고릴라가 내장을 떨어뜨리고, 모든 고릴라가 송곳니를 떨어뜨릴 수 있습니다.",

	-- Step 15: Witch Doctor Unbagwa
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "운바그와에게 송곳니를 건네고 곁에 있으세요. 그가 고릴라 세 무리를 부른 뒤 {npc:1514}을(를) 부릅니다. 한 번에 하나씩 싸우세요.",
	-- {area:1742} Spirit Den
	["Inside {area:1742}"] = "",

	-- Step 17: Venture Co. mine
	["Venture Co. mine"] = "투자개발회사 광산",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "더 북쪽, 길 동쪽 광산에서 투자개발회사 고블린이 채굴하고 있습니다. 광부, 현장감독, 감시관, 땜장이 모두 수정을 떨어뜨립니다.\n주의: 은신한 그림자아귀 표범과 가시덤불 암호랑이가 야영지 주변을 돌아다닙니다.",

	-- Step 19: Nesingwary's camp
	["Nesingwary's camp"] = "네싱워리의 야영지",
	["Head north up the road; the hunters camp on the hill above the river."] = "길을 따라 북쪽으로 가세요. 사냥꾼들은 강 위쪽 언덕에 야영하고 있습니다.",

	-- Step 21: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot · {quest:338} The Green Hills of Stranglethorn
	["{npc:716} collects the pages of {quest:338}: the trolls of the vale drop them now and then. Take his quest; each chapter he takes once you have all its pages."] = "{npc:716}은(는) {quest:338}의 책장을 모읍니다. 골짜기의 트롤이 가끔 떨어뜨립니다. 그의 퀘스트를 받으십시오. 각 장은 모든 책장을 모으면 그가 받습니다.",

	-- Step 22: Chapter I
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter I is in your bags"] = "{npc:716}: 1장의 모든 책장이 가방에 있음",

	-- Step 23: Chapter II
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter II is in your bags"] = "{npc:716}: 2장의 모든 책장이 가방에 있음",

	-- Step 24: Chapter III
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter III is in your bags"] = "{npc:716}: 3장의 모든 책장이 가방에 있음",

	-- Step 25: Chapter IV
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter IV is in your bags"] = "{npc:716}: 4장의 모든 책장이 가방에 있음",

	-- Step 26: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot
	["{npc:716}: the four chapters"] = "{npc:716}: 네 개의 장",

	-- Step 27: Zul'Kunda
	["Zul'Kunda"] = "줄쿤다",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {quest:586} Speaking with Gan'zulah · {object:3202} Grom'gol · {npc:2635} Elder Saltwater Crocolisk · {npc:2495} Drizzlik
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "원정대 서쪽, 줄쿤다의 폐허에 붉은머리부족 족장 {npc:1061}와(과) {npc:1062}이(가) 함께 서 있습니다. 먼저 호위병을 처치한 뒤 끌어오세요. 41레벨이 될 때까지 이곳에서 붉은머리부족을 처치하세요. 다음에 가마솥에서 받는 {quest:586}은(는) 41-43레벨 백골가루부족에게 보냅니다.\n줄쿤다와 {object:3202} 사이 해안에서는 {npc:2635}(38레벨 정예)이(가) 일반 악어와 같은 자리에 나타납니다. 나타나 있다면 처치하고 {npc:2495}에게 줄 가죽을 챙기세요.",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "",
	-- {quest:586} Speaking with Gan'zulah
	["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "",

	-- Step 28: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{npc:2497} 옆의 {object:2076}",
	-- {npc:2497} Nimboya · {zone:1425} Hinterlands
	["{npc:2497}: for the {zone:1425}, around level 48"] = "{npc:2497}: 48레벨쯤 {zone:1425}",
	-- {npc:2519} Kin'weelay
	["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "",
	-- {npc:2519} Kin'weelay · {area:104} Vile Reef
	["{npc:2519}: the cavern entrance under the {area:104}, west of the camp"] = "{npc:2519}: 야영지 서쪽, {area:104} 아래의 동굴 입구",

	-- Step 29: The Vile Reef
	-- {quest:95770} Locating the Lost City · {object:3202} Grom'gol · {area:104} Vile Reef
	["{quest:95770}: west of {object:3202}, swim out over the {area:104} and dive to the cavern entrance in the reef; the quest completes as you find it. Leave the cavern for now: the jungle stalkers are south along the coast."] = "{quest:95770}: {object:3202} 서쪽으로 {area:104} 위를 헤엄쳐 나가 암초 속 동굴 입구로 잠수하세요. 입구를 찾으면 퀘스트가 완료됩니다. 동굴은 일단 그냥 두세요. 줄무늬정글랩터는 해안을 따라 남쪽에 있습니다.",
	-- {area:16550} Drowned City
	["the {area:16550}'s entrance, underwater"] = "물속에 있는 {area:16550}의 입구",

	-- Step 30: Jungle stalkers
	["Jungle stalkers"] = "줄무늬정글랩터",
	-- {object:3202} Grom'gol
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "랩터는 {object:3202} 남쪽 정글에서 서쪽 해안 쪽으로 사냥합니다.",

	-- Step 31: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "해안을 따라 남쪽으로 가세요. 나가 탐험가가 물가를 걸어 다니며 갈대 묶음을 지니고 있습니다. {object:759}은(는) 그 바로 동쪽 언덕에서 솟아납니다.",

	-- Step 32: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "남쪽의 {area:35}(으)로 가세요. 겁쟁이 필립이 부두에서 기다립니다.",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "",
	-- {zone:1446} Tanaris
	["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "",
	-- {npc:2495} Drizzlik · {item:4105} Elder Crocolisk Skin
	["{npc:2495}, inside: the {item:4105}"] = "{npc:2495}, 안쪽: {item:4105}",
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "",

	-- Step 33: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "무법항 남쪽, {area:43}에 붉은해적단 칼잡이가 야영하고 있습니다. 해도와 명령서는 천막 안과 더 큰 야영지 옆 보트에 있습니다. 붉은해적단은 누구나 코담배와 {npc:2493}의 눈을 지니고 있을 수 있으니, 둘 다 얻을 때까지 계속 처치하세요.",

	-- Step 35: The Bloodsail ships
	["The Bloodsail ships"] = "붉은해적단 배",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["Optional, and tough at 42: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "나중에 {zone:1435}에 들를 때",

	-- Step 36: Zanzil's camps
	["Zanzil's camps"] = "잔질의 야영지",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "안개계곡 골짜기 북동쪽 정글에 잔질의 추종자들이 야영하고 있습니다. 누구나 혼합물을 지니고 있을 수 있습니다.",

	-- Step 37: Pirate ghosts
	["Pirate ghosts"] = "해적 유령",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "해적 유령 셋은 {area:35} 북쪽, 잔질의 야영지 근처 정글에 출몰합니다. {npc:2535}와(과) {npc:2536}은(는) 함께 있고, {npc:2537}은(는) 더 동쪽에 있습니다.",

	-- Step 38: Zul'Mamwe
	["Zul'Mamwe"] = "줄맘웨",
	-- {npc:1059} Ana'thek the Cruel
	["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "북쪽으로 투자개발회사 광산 동쪽의 백골가루부족 폐허로 가세요. 인간사냥꾼과 광전사를 한 번에 하나씩 끌어오세요. {npc:1059}은(는) 남서쪽 폐허를 지키고, 전리품 해골 더미 하나는 폐허 북쪽에 있습니다. 백골가루부족은 누구나 엄니나 목걸이를 떨어뜨릴 수 있습니다. 목걸이가 오래 걸리니, 모두 모을 때까지 폐허 북쪽 전사 야영지에서 계속 처치하세요.",
	["Skullsplitter warriors"] = "백골가루부족 전사",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "",
	["Below ground"] = "지하",

	-- Step 39: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "",
	-- {object:3202} Grom'gol
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "다음 전리품 해골은 전사 야영지 바로 북쪽의 작은 폐허에 있습니다.\n마지막 해골은 {object:3202}(으)로 돌아가는 길, 서쪽으로 조금 걸어가면 있는 폐허에 있습니다.",

	-- Step 40: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Head west to {object:3202}."] = "서쪽의 {object:3202}(으)로 가세요.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "",

	-- Step 42: Booty Bay
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "{npc:773}, 위층: {area:976}의 {quest:2864}에게",

	-- Step 43: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "무쇠턱 바실리스크",
	-- {area:35} Booty Bay · {object:3202} Grom'gol
	["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "",

	-- Step 44: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Ride on north to {object:3202}."] = "계속 북쪽의 {object:3202}(으)로 가세요.",

	-- Step 46: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "길을 따라 북쪽의 사냥꾼 야영지로 가세요.",

	-- Step 48: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 49: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 53: Level 42.68
	["Level 42.68"] = "",
	-- {quest:192} Panther Mastery · {quest:195} Raptor Mastery
	["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan."] = "",
	-- {npc:667} Skullsplitter Warrior
	["grind on {npc:667}"] = "",

	-- Step 54: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "",

	-- Step 56: Level 42.74
	["Level 42.74"] = "",
	-- {quest:208} Big Game Hunter
	["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan."] = "",

	-- Step 60: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "{zone:1435}(으)로",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "길을 따라 {zone:1431}에서 동쪽으로 {zone:1430}을(를) 지나 늪으로 가세요. {npc:1776}은(는) {zone:1430}에서 들어오는 길 바로 옆의 드레나이 야영지인 {area:657}에서 기다립니다.",

	-- Step 61: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road."] = "동쪽으로 길 남쪽 갈대밭의 {area:75}(으)로 가세요.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 62: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "톱니악어",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "악어는 {npc:5391}의 야영지 주변 웅덩이와 남쪽 {area:75} 쪽에서 뒹굴고 있습니다. 네 마리 중 한 마리 정도가 옆구리살을 떨어뜨립니다.",

	-- Step 63: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "노보루는 {area:76} 남서쪽 빈터를 돌아다닙니다. 그의 곤봉이 퀘스트를 시작합니다.",

	-- Step 64: Draenethyst crystals
	["Draenethyst crystals"] = "드레니시스트 수정",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "북동쪽의 {area:76}(으)로 가세요. 수정은 {npc:5391}의 우리로 올라가는 길을 따라 있습니다.",

	-- Step 65: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391}은(는) 늪 북동쪽 {area:76}에 붙잡혀 있습니다. 풀어 주고 따라가며 그를 쫓는 늪 생물을 물리치세요.",

	-- Step 66: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "그의 금고는 서쪽으로 돌아가는 길, {area:75} 북쪽의 옛 야영지에 있습니다.",

	-- Step 67: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass · {quest:698} Lack of Surplus · {npc:5592} Tok'Kar · {area:1978} Misty Reed Post
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "길을 따라 서쪽으로 {zone:1430}에서 들어오는 길 근처, {area:657}의 드레나이 야영지로 가세요. {quest:698}은(는) 다음 늪 방문 때 {area:1978}의 {npc:5592}에게 가져갑니다. 옆구리살은 보관하세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "{area:35}행 배",
	-- ["Fly to {area:392}"] = "{area:392}(으)로 날아가기",
	-- ["From {area:2408} fly to {area:392}."] = "{area:2408}에서 {area:392}(으)로 날아가세요.",
	-- ["Hearth to {area:35}"] = "귀환석으로 {area:35}에 가기",
	-- ["Hearth to {object:3202}"] = "귀환석으로 {object:3202}에 가기",
	-- ["Into the {area:8}"] = "{area:8}(으)로",
	-- ["Naga shore and the {object:759}"] = "나가 해안과 {object:759}",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "동쪽으로 {area:75}을(를) 지나 길을 따라 남동쪽 해안의 작은 호드 주둔지로 가세요.",
	-- ["Sawtooth snappers"] = "무쇠턱 톱니악어",
	-- ["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "길을 따라 {area:35}에서 북쪽으로 가세요. 운바그와는 길 동쪽 {area:1737}의 언덕에 앉아 있습니다.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "{area:35}행 배는 {area:392} 부두 끝에 정박합니다.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "마지막 해골은 {object:3202}(으)로 돌아가는 길에, 조금 서쪽의 폐허에 있습니다.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "다음 가이드는 여기서 시작해 {zone:1446}(으)로 안내합니다.",
	-- ["The snappers line the strand south of the post."] = "무쇠턱 톱니악어는 주둔지 남쪽 해변에 늘어서 있습니다.",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "배 세 척은 {area:43} 앞바다에 있습니다. 선원은 42-45, 스틸워터는 45, 킬하울은 46, {npc:2546}은(는) 48레벨입니다. 41레벨에서는 파티용이거나 가이드 마지막에 할 싸움입니다. 간다면 헤엄쳐 가서 선원을 한 명씩 난간으로 끌어오세요. 배 갑판에 두루마리 {quest:624}이(가) 있습니다. 챙기세요.",
	-- ["The {area:657}"] = "{area:657}",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "원정대 서쪽, 줄쿤다의 폐허에 붉은머리부족 족장 {npc:1061}와(과) {npc:1062}이(가) 함께 서 있습니다. 먼저 호위병을 처치한 뒤 끌어오세요.",
	-- ["for Stoley in {zone:1446}"] = "{zone:1446}의 스톨리에게",
	-- ["for a later stop in the {area:8}"] = "나중에 {area:8}에 들를 때",
	-- ["the {object:2076}, beside {npc:2497}"] = "{npc:2497} 옆의 {object:2076}",
	-- ["{area:392} pier"] = "{area:392} 부두",
}
