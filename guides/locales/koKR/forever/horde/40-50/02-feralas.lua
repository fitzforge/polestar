-- Korean (koKR): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "{object:3202}(으)로 날아가기",
	-- {zone:2548} Riverglades · {area:340} Kargath
	["Coming from the {zone:2548}: {area:340}'s flight master stands at the foot of the fortress."] = "{zone:2548}에서 오는 경우: {area:340}의 비행 조련사는 요새 아래에 서 있습니다.",
	-- {area:340} Kargath
	["{area:340} flight master"] = "{area:340} 비행 조련사",

	-- Step 2: Fly to Grom'gol
	-- {area:75} Stonard
	["{area:75} flight master"] = "",

	-- Step 3: Grom'gol Base Camp
	-- {object:3202} Grom'gol · {area:35} Booty Bay · {npc:1514} Mokk the Savage · {zone:1454} Orgrimmar · {object:2076} Bubbling Cauldron
	["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "{object:3202}에 착륙합니다. 첫 방문 때 받아 둔 가시덤불 골짜기의 어려운 퀘스트들을 이제 할 수 있습니다: 해골망치부족 족장, 잔질의 야영지, {area:35}의 해적, 나가 해안, {npc:1514}. 그 뒤 {zone:1454}행 비행선을 타세요. 님보야 옆의 {object:2076}에서 해골망치부족 족장 퀘스트를 받을 수 있습니다.",
	-- {object:2076} Bubbling Cauldron · {quest:586} Speaking with Gan'zulah
	["the {object:2076}: {quest:586}"] = "{object:2076}: {quest:586}",

	-- Step 4: Zul'Mamwe
	["Zul'Mamwe"] = "줄맘웨",
	-- {npc:1059} Ana'thek the Cruel · {quest:586} Speaking with Gan'zulah · {npc:1060} Mogh the Undying
	["Ride east to the Skullsplitter ruins east of the Venture Co. mine. The headhunters, berserkers and hunters roam the ruins.\n{npc:1059} (45) carries the Broken Armor for {quest:586}: he walks the south-western ruins with two guards and sometimes stands in a small cave there. Pull the guards first.\nCareful: {npc:1060}, an elite troll (level 44), stands in the southern ruins around 47.7,44.3: pull the headhunters and berserkers away from him."] = "동쪽으로 가서 투자개발회사 광산 동쪽의 해골망치부족 폐허로 가세요. 머리사냥꾼, 광전사, 사냥꾼이 폐허를 돌아다닙니다.\n{npc:1059}(45)이(가) {quest:586}에 필요한 부서진 갑옷을 지니고 있습니다. 경비병 둘과 함께 남서쪽 폐허를 돌아다니며, 가끔 그곳의 작은 동굴에 서 있습니다. 경비병부터 끌어내세요.\n주의: 정예 트롤 {npc:1060}(44레벨)이(가) 남쪽 폐허 47.7,44.3 부근에 서 있습니다. 머리사냥꾼과 광전사를 그에게서 떨어진 곳으로 끌어내세요.",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "",

	-- Step 5: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Back west to {object:3202}."] = "서쪽의 {object:3202}(으)로 돌아가세요.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks bask beside the road south, on the ride to {area:35}"] = "{npc:2519}: 바실리스크는 {area:35}(으)로 가는 남쪽 길가에서 햇볕을 쬐고 있습니다",

	-- Step 6: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "무쇠턱 바실리스크",
	-- {area:35} Booty Bay
	["Ride south along the road towards {area:35}; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "길을 따라 남쪽 {area:35} 방향으로 가세요. 바실리스크는 정글 한가운데 길 동쪽 바위 위에서 햇볕을 쬐고 있습니다. 파편을 자주 떨어뜨립니다.",
	["Below ground"] = "지하",

	-- Step 7: Pirate ghosts and Zanzil's camps
	["Pirate ghosts and Zanzil's camps"] = "해적 유령과 잔질의 야영지",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs" · {npc:2534} Zanzil the Outcast
	-- plural, as words: Zanzil Witch Doctors = {npc:1490} Zanzil Witch Doctor
	["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "남서쪽으로 계속 가서 안개골짜기 북동쪽 정글로 가세요. 해적 유령 셋이 잔질의 야영지 옆을 떠돌고 있습니다. {npc:2535}와(과) {npc:2536}은(는) 함께 있고, {npc:2537}은(는) 더 동쪽에 있습니다. 잔질의 추종자는 모두 혼합물을 떨어뜨릴 수 있습니다.\n주의: 잔질 의술사(44)는 주문을 쓰고 야영지는 몹이 빽빽합니다. 가장자리에서 하나씩 끌어내세요. {npc:2534}(46) 본인은 남쪽 야영지 39.6,58.6 부근, {npc:2537} 유령과 몇 걸음 거리에 서 있습니다. 그와 싸우기 전에 {npc:2537}을(를) 북쪽이나 동쪽으로 끌어내세요.",

	-- Step 8: Witch Doctor Unbagwa
	-- {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["West into Mistvale: {npc:1449} sits among the gorillas. Any gorilla can drop a fang: hand him ten and stay by him, he calls three waves of gorillas, then {npc:1514}.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "서쪽 안개골짜기로 가세요. {npc:1449}이(가) 고릴라들 사이에 앉아 있습니다. 모든 고릴라가 송곳니를 떨어뜨릴 수 있습니다. 열 개를 건네고 곁에 있으면 고릴라 세 무리를 불러낸 뒤 {npc:1514}을(를) 부릅니다.\n주의: 고릴라 세 무리가 쉴 틈 없이 연달아 나온 뒤 {npc:1514}이(가) 나옵니다. 생명력과 마나를 가득 채우고 시작하고, 운바그와 가까이 있으세요. 일부 직업은 혼자 하기 어렵습니다. 동료가 있으면 쉽습니다.",

	-- Step 9: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "",
	-- {object:759} Holy Spring · {area:43} Wild Shore · {area:35} Booty Bay
	["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them.\nFollow the coast south. If you still need the {area:43} pirates, take the road past the {area:35} tunnel to the beach before going into town."] = "",

	-- Step 10: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	["Stay on the beach with the swashbucklers (41-43); the charts and the orders lie in their tents and in the rowboat beside the larger camp. Leave the ships alone."] = "",

	-- Step 12: Dudd Fizzlescroll
	-- {quest:95384} Partial Mystical Notes · {npc:260873} Dudd Fizzlescroll · {area:35} Booty Bay
	["If you already have the {quest:95384}, give them to {npc:260873} here in {area:35}."] = "",

	-- Step 14: Booty Bay
	-- {area:35} Booty Bay · {npc:2494} Privateer Bloads · {npc:2486} Fin Fizracket · {npc:2498} Crank Fizzlebub · {npc:737} Kebok · {npc:773} Krazek
	["In {area:35}: {npc:2494} on the docks, {npc:2486} by the inn, {npc:2498} inside it, MacKinley, {npc:737} and {npc:773} upstairs."] = "{area:35}: 부두의 {npc:2494}, 여관 옆의 {npc:2486}, 여관 안의 {npc:2498}, 위층의 맥킨리, {npc:737}, {npc:773}.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}, later in this guide"] = "위층의 {npc:773}: 이 가이드 후반 {area:976}의 {quest:2864}용",

	-- Step 17: Unfinished Wild Shore errands
	-- {area:43} Wild Shore
	["Unfinished {area:43} errands"] = "",
	["If the town rewards just brought you to 42 and you still owe pirate work, use the shore tents, not the ships."] = "",

	-- Step 21: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 22: Grom'gol Base Camp
	-- {object:3202} Grom'gol · {npc:2519} Kin'weelay · {npc:2465} Far Seer Mok'thardin
	["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then the zeppelin tower."] = "비행 경로를 타면 {object:3202}에 내립니다: {npc:2519}와(과) {npc:2465}을(를) 만난 뒤 비행선 탑으로 가세요.",

	-- Step 24: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "{zone:1454}행 비행선",

	-- Step 25: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 27: Riding at 40
	["Riding at 40"] = "40레벨 탈것 타기",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "탈것 타기는 40레벨이 필요하고 100골드가 듭니다. 배우면 탈것을 하나 받습니다. {npc:4752}은(는) {object:172958}의 {npc:3362} 우리 옆에서 오크에게 가르칩니다. 스카이본은 제프라스 섬 {area:16638}의 {area:17684}에 있는 {npc:265756}에게서 돌풍타조와 함께 배웁니다. 섬으로 가는 하늘배는 {zone:1456} 북쪽, {area:17045} 남쪽 절벽에서 약 5분마다 출발합니다. 종족의 다른 탈것은 각각 20골드입니다: 수집품, 탈것 · 40레벨에 각각의 가이드가 있습니다.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "탈것 타기 상급자 {npc:4752}",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "늑대: {npc:4752} 옆의 {npc:3362}",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "탈것 타기와 돌풍타조: 제프라스 섬 {area:16638}의 {area:17684}에 있는 {npc:265756}",

	-- Step 29: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, 탈것 상급자",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "랩터: {area:367}의 {npc:7953} 옆의 졸니르",

	-- Step 30: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "{area:1638}(으)로 날아가기",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454} 비행 조련사",

	-- Step 32: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins)."] = "직업 상급자는 {zone:1456}에 있습니다: {area:1639}의 {npc:3033}(드루이드), {npc:246344}(성기사).",

	-- Step 34: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "탈것 타기는 40레벨이 필요하고 100골드가 듭니다. 배우면 탈것을 하나 받습니다. 각 종족은 자기 종족의 상급자에게서 배웁니다. 당신의 상급자는 {area:222}의 {npc:3690}이며, 그 옆에서 {npc:3685}이(가) 코도(각 20골드)를 팝니다. 그 뒤에 {zone:1456}의 비행 조련사에게 다시 올라가세요.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "탈것 타기 상급자 {npc:3690}",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "코도: {area:222}의 {npc:3690} 옆의 {npc:3685}",

	-- Step 35: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "{area:484}(으)로 날아가기",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 36: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "{area:976}(으)로 비행",

	-- Step 39: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "지옥마를 위해 {area:392}(으)로",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to {area:392}; {npc:6251} stands on the hill above the docks."] = "",

	-- Step 40: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 46: Gadgetzan
	-- {area:976} Gadgetzan · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["Flown in: {area:976}'s quests first, by the flight master, then the {area:2240} is a short ride north over the {zone:1446} border."] = "비행으로 도착: 먼저 비행 조련사 옆에서 {area:976}의 퀘스트를 처리하십시오. 그다음 {area:2240}은(는) 북쪽으로 {zone:1446} 경계를 넘어 조금만 가면 됩니다.",

	-- Step 47: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7804} Trenton Lighthammer · {quest:3042} Troll Temper
	["For your {area:978} run, in the next guide: {quest:2864} wants scarab shells, and {npc:7804}, a short walk from the flight master, {quest:3042} from the Sandfury trolls."] = "{area:978} 공략용(다음 가이드): {quest:2864}은(는) 풍뎅이 껍질을, 비행 조련사에게서 조금 떨어진 {npc:7804}은(는) 성난모래부족 트롤의 {quest:3042}을(를) 원합니다.",

	-- Step 48: Mirage Raceway
	-- {area:976} Gadgetzan · {zone:1446} Tanaris · {area:484} Freewind Post · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["Flown in to {area:976}: the raceway is a short ride north over the {zone:1446} border.\nThe road from {area:484} to {zone:1446} runs past the {area:2240} on the {area:439}: {npc:4454} is in the gnomes' camp beside the track, {npc:4630} and {npc:4709} by the goblins' camp. {npc:4630} first, then {npc:4709}, who runs off to keep Rizzle busy; then take Rizzle's plans from the gnomes' camp and bring them back to {npc:4630}."] = "",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "",

	-- Step 49: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "",

	-- Step 50: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976}은(는) {zone:1446} 경계를 막 지나서 있는 담장 두른 고블린 마을입니다.",

	-- Step 52: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "약탈자와 좀도둑은 {area:976} 동쪽 모래언덕에 야영하고 있습니다. 사막유랑단은 누구나 물주머니를 지니고 있을 수 있습니다. 루글룬켓에게 다섯 개가 필요합니다.\n주의: 사막유랑단 도적(43-44레벨)은 은신한 채 움직이므로 보이지 않게 다가올 수 있습니다.",

	-- Step 54: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "북동쪽 해안의 고블린 항구로 가세요.",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "{npc:8579}: 날카로운비명은 {zone:1444}에 삽니다. 다음 {zone:1444} 방문 때",
	-- {npc:260405} Wharfmaster Steamfizzle · {zone:2548} Riverglades
	["{npc:260405}, on the pier: Friz's errand from the {zone:2548}, if you carry it"] = "부두의 {npc:260405}: {zone:2548}에서 받은 프리즈의 심부름이 있다면",

	-- Step 55: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "",
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "해안을 따라 남쪽으로 가면 남쪽바다해적단이 만을 차지하고 있습니다. {npc:7883}와(과) 도난당한 화물은 만 맨 끝 부두에 있습니다. 해적은 누구나 모자를 떨어뜨릴 수 있으며, 납치범이 가장 자주 떨어뜨립니다.\n주의: {npc:7883}(45) 곁에는 해적 두세 명이 서 있고, 싸움이 시작되면 마을의 해적이 훨씬 더 많이 합류합니다. 먼저 호위병을 그에게서 떼어 끌어오세요.",
	["Upstairs"] = "위층",

	-- Step 56: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "",

	-- Step 57: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what {area:1336} gave you. {area:976} is west of it."] = "",
	-- {area:35} Booty Bay
	["for {area:35}, around level 51 (40-50/06)"] = "51레벨쯤 {area:35}에서 (40-50/06)",

	-- Step 59: Fly to Freewind Post
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976} 비행 조련사",

	-- Step 61: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "",
	-- {npc:8115} Witch Doctor Uzer'i · {npc:263190} Tan'jani · {zone:2548} Riverglades
	["{npc:8115}: {npc:263190}'s errand from the {zone:2548}, if you carry it"] = "{npc:8115}: {zone:2548}에서 받은 {npc:263190}의 심부름이 있다면",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: 45레벨쯤 {zone:1454}에서",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "",

	-- Step 62: Gordunni Outpost
	-- {npc:222233} Ohk'zi
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "놀 북쪽에서 오우거들이 언덕 위 전초기지를 차지하고 있습니다. 오우거 마법사는 끌어와서 처치하세요. 코발트는 전초기지 주변 흙더미에 있고, 두루마리는 그 안의 땅에 있습니다.\n주의: 전초기지에 {npc:222233}(43레벨 정예)이(가) 있습니다. 오우거를 그에게서 떨어진 곳으로 끌어내세요.",

	-- Step 63: Woodpaw north camp
	["Woodpaw north camp"] = "덩굴발일족 북쪽 야영지",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "덩굴발일족 놀은 모자케 야영지 바로 북서쪽 언덕에 야영하고 있습니다. 누구나 갈기를 떨어뜨릴 수 있습니다.\n주의: 우두머리를 제외한 모든 덩굴발일족 놀은 생명력이 15%가 되면 도움을 청하러 달아나 놀을 더 끌어올 수 있습니다.",

	-- Step 64: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}: 지금부터 한 시간",

	-- Step 65: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "화살요정용은 모자케 야영지 바로 서쪽 숲 위를 날아다닙니다. 거의 모두 날개를 떨어뜨립니다. 덩굴발일족 우두머리는 그 남서쪽 야영지를 이끌고 있습니다. 한 시간 안에 처치하세요.\n주의: 우두머리 대부분은 작은 천막 야영지에 다른 놀 2-4마리와 함께 있어 함께 싸우며, 다른 놀이 야영지 사이를 순찰합니다.",

	-- Step 67: Grimtotem camp
	["Grimtotem camp"] = "그림토템부족 야영지",
	-- {npc:222286} Namida Grimtotem
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns.\nCareful: {npc:222286} (level 43, elite) stands in the camp: pull the raiders and shamans away from her."] = "그림토템부족 타우렌은 화살요정용의 숲 옆에 야영하고 있습니다. 침략자, 식물학자, 주술사 모두 뿔을 지니고 있습니다.\n주의: 야영지에 {npc:222286}(43레벨 정예)이(가) 있습니다. 침략자와 주술사를 그녀에게서 떼어 끌어오세요.",

	-- Step 68: Woodpaw battle map
	["Woodpaw battle map"] = "덩굴발일족 전투 지도",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "전투 지도는 모자케 야영지 남쪽의 덩굴발일족 야영지에 있습니다.",

	-- Step 69: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "45레벨쯤 {zone:1454}에서",

	-- Step 70: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber.\nCareful: {quest:7731} is level 47: clear the hive around him and pull him alone at full health."] = "주크애쉬 벌집은 야영지 남동쪽 언덕 속으로 파고들어 있습니다. {quest:7731}은(는) 가장 깊은 방에서 기다립니다.\n주의: {quest:7731}은(는) 47레벨입니다. 주변 벌집을 정리하고 생명력이 가득 찬 상태에서 혼자 끌어오세요.",

	-- Step 71: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "",
	-- {area:1105} Feral Scar Vale
	["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb.\nCareful: the Mage-Lords (45-46) and the Shamans cast from range and the ruins are packed: pull one at a time from the edge."] = "벌집에서 서쪽으로 {area:1105} 아래의 오우거 폐허로 가세요. 주술사, 흑마법사, 싸움꾼이 가득하며, 남쪽 끝의 대마법사가 구슬을 지니고 있습니다.\n주의: 대마법사(45-46)와 주술사는 원거리에서 주문을 쓰고 폐허는 빽빽하니, 가장자리에서 하나씩 끌어오세요.",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "",

	-- Step 72: Feral Scar Vale yetis
	-- {area:1105} Feral Scar Vale
	["{area:1105} yetis"] = "",
	-- {area:1105} Feral Scar Vale · {npc:5346} Bloodroar the Stalker
	["North-west of the ruins, pull one yeti at a time at the eastern mouth of {area:1105} for thick hides. Careful: larger yetis crowd the cave further west, and {npc:5346}, a level 48 rare, lurks at the far end."] = "",

	-- Step 73: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "",

	-- Step 74: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "",
	-- {zone:1454} Orgrimmar · {zone:2652} Shen'dralas
	["for {zone:1454}, after {zone:2652}"] = "{zone:2652} 이후 {zone:1454}에서",
	-- {zone:2652} Shen'dralas · {area:1099} Camp Mojache · {zone:1443} Desolace · {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {npc:7311} Uthel'nay
	["{zone:2652} is next, a ride north from {area:1099} into {zone:1443}: keep your {zone:1454} hand-ins (Neeru, Zilzibin, {npc:4485}, {npc:7311}) for the flight there after it."] = "다음은 {zone:2652}입니다. {area:1099}에서 북쪽으로 {zone:1443}까지 가면 됩니다. {zone:1454} 제출 퀘스트(니루, 질지빈, {npc:4485}, {npc:7311})는 그 뒤 그곳으로 비행할 때를 위해 남겨 두세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into town. The ships' captains, Seahorn's next request, are for your Stranglethorn stop at about 50."] = "마을로 돌아가세요. 시혼의 다음 의뢰인 선장들은 50레벨쯤 가시덤불 골짜기에 들를 때 처리합니다.",
	-- ["Eastern Wastewander camps"] = "동쪽 사막유랑단 야영지",
	-- ["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "{area:1637}(으)로 날아가세요. 드로퍼스 형제는 골목길에서 상점을 운영합니다.",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "{area:484}(으)로 날아가 주둔지 동쪽 승강기를 타고 내려간 뒤, 소금 평원을 가로질러 남쪽 {zone:1446}(으)로 가세요.",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "{area:484}(으)로 날아간 뒤 서쪽으로 협곡을 지나 {area:2237}을(를) 지나가세요. 길은 {zone:1444} 정글로 올라가 {area:1099}까지 이어집니다.",
	-- ["Fly to {area:75}"] = "{area:75}(으)로 날아가기",
	-- ["Fly to {zone:1454}. From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "{zone:1454}(으)로 날아가세요. 비행 조련사에서부터: {object:172960}, 그다음 골목길, 그다음 {object:172958}.",
	-- ["Hearth to {area:1099}"] = "귀환석으로 {area:1099}에 가기",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "계속 서쪽 해안으로 가세요. 해변의 점쟁이 바다마크루라와 집게발 바다마크루라는 마흔 마리에 한 번꼴로 OOX-22/FE 조난 탐지기를 떨어뜨립니다. 얻으면 사용해 퀘스트를 시작하세요.",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "조난 탐지기가 있을 때만: 로봇은 {area:1105} 북쪽의 작은 동굴에 있습니다. {area:1108}의 부두까지 호위하세요. 가는 길에 설인과 고릴라가 습격합니다. 보상은 나중에 {area:35}에 들를 때 받습니다.",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "{area:1978}에서 북서쪽의 {area:75}(으)로 돌아가 {object:3202}(으)로 날아가세요.",
	-- ["Ride back west to {area:976}."] = "서쪽의 {area:976}(으)로 돌아가세요.",
	-- ["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "벌집에서 서쪽으로 {area:1105} 아래의 오우거 폐허로 가세요. 주술사, 흑마법사, 싸움꾼이 가득하며, 남쪽 끝의 대마법사가 구슬을 지니고 있습니다.",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "서쪽으로 {zone:1444} 한가운데로 가세요. {npc:5308}을(를) 처치하고 시체에 {item:10699}을(를) 사용한 뒤, 떠오르는 영혼을 처치하세요.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "탈것 타기는 40레벨이 필요하고 100골드가 듭니다. 배우면 탈것을 하나 받습니다. 클래식에서는 각 종족이 자기 종족의 상급자에게서 배웁니다. 당신의 상급자는 {area:159}의 {npc:4773}이며, 그 옆에서 {npc:4731}이(가) 해골마(각 20골드)를 팝니다. Forever에서는 어느 종족이든 아무 탈것 타기 상급자에게서 배울 수 있을지도 모릅니다(확인되지 않음). 가장 가까운 {zone:1454} {object:172958}의 {npc:4752}에게 먼저 시도하고, 그가 가르쳐 주면 이 단계는 건너뛰세요.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "탈것 타기는 40레벨이 필요하고 100골드가 듭니다. 배우면 탈것을 하나 받습니다. 클래식에서는 각 종족이 자기 종족의 상급자에게서 배웁니다. 당신의 상급자는 {zone:1411} 해안 {area:367}의 {npc:7953}이며, 그 옆에서 졸니르가 랩터(각 20골드)를 팝니다. Forever에서는 어느 종족이든 아무 탈것 타기 상급자에게서 배울 수 있을지도 모릅니다(확인되지 않음). 가장 가까운 {zone:1454} {object:172958}의 {npc:4752}에게 먼저 시도하고, 그가 가르쳐 주면 이 단계는 건너뛰세요.",
	-- ["Rogue Vale screechers"] = "도적의 골짜기 날카로운비명",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "해골마: {area:159}의 {npc:4773} 옆의 {npc:4731}",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "해안을 따라 남쪽으로 가면 남쪽바다해적단이 만을 차지하고 있습니다. {npc:7883}와(과) 도난당한 화물은 만 맨 끝 부두에 있습니다. 해적은 누구나 모자를 떨어뜨릴 수 있으며, 납치범이 가장 자주 떨어뜨립니다.\n주의: {npc:7883} 곁에는 해적 두세 명이 서 있고, 싸움이 시작되면 마을의 해적이 훨씬 더 많이 합류합니다.",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "무법항 남쪽, {area:43}에 붉은해적단 칼잡이가 야영하고 있습니다. 해도와 명령서는 천막 안과 더 큰 야영지 옆 보트에 있습니다. 붉은해적단은 누구나 코담배와 {npc:2493}의 눈을 지니고 있을 수 있으니, 둘 다 얻을 때까지 계속 처치하세요.",
	-- ["Southern Gordunni ruins"] = "남쪽 골두니 폐허",
	-- ["Southern Wastewander camps"] = "남쪽 사막유랑단 야영지",
	-- ["Sprite darters and Woodpaw alphas"] = "화살요정용과 덩굴발일족 우두머리",
	-- ["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "주크애쉬 벌집은 야영지 남동쪽 언덕 속으로 파고들어 있습니다. {quest:7731}은(는) 가장 깊은 방에서 기다립니다.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "약탈자와 좀도둑은 {area:976} 동쪽 모래언덕에 야영하고 있습니다. 사막유랑단은 누구나 물주머니를 지니고 있을 수 있습니다. 루글룬켓의 현상금 퀘스트 두 개에 다섯 개씩, 열 개를 보관하세요.\n주의: 사막유랑단 도적(43-44레벨)은 은신한 채 움직이므로 보이지 않게 다가올 수 있습니다.",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "어둠마법사, 도적, 암살자는 {area:976} 남동쪽에 야영하고 있습니다.",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "{object:3202}행 비행선은 {zone:1454} 정문 바로 북동쪽의 탑에서 출발합니다.",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "{zone:1454}행 비행선은 {object:3202} 옆의 탑에서 출발하며, {zone:1454} 정문 바로 밖에 도착합니다.",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "비행 조련사 시스타는 비행선 탑 바로 동쪽에 서 있습니다. {area:75}(으)로 날아가세요. 다음 가이드는 그곳에서 시작합니다.",
	-- ["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them. Then follow the coast south to {area:35}."] = "서쪽 해안으로 가세요. 나가 탐험가가 해안을 따라 걸어다니며 갈대 묶음을 지니고 있습니다. {object:759}은(는) 그 바로 동쪽 언덕에서 솟아납니다. 그 뒤 해안을 따라 남쪽 {area:35}(으)로 가세요.",
	-- ["Zeppelin to {object:3202}"] = "{object:3202}행 비행선",
	-- ["Zeppelin tower"] = "비행선 탑",
	-- ["for the {zone:1425}, around level 48"] = "48레벨쯤 {zone:1425}에서",
	-- ["for {area:35}, around level 50"] = "50레벨쯤 {area:35}에서",
	-- ["the {object:150075} in the square"] = "광장의 {object:150075}",
	-- ["water pouches in your bags"] = "가방 속 물주머니",
	-- ["{area:1099} flight master"] = "{area:1099}의 비행 조련사",
	-- ["{area:976} is the walled goblin town just past the {area:440} border."] = "{area:976}은(는) {area:440} 경계를 막 지나서 있는 담장 두른 고블린 마을입니다.",
	-- ["{npc:4630}: the {item:5852} from {npc:2496}, if you carry them"] = "{npc:4630}: 가지고 있다면 {npc:2496}에게서 받은 {item:5852}",
	-- ["{npc:4706}, beside {npc:4630}"] = "{npc:4630} 옆의 {npc:4706}",
	-- ["{npc:4773}, riding trainer"] = "탈것 타기 상급자 {npc:4773}",
	-- ["{npc:6986}, the Drag"] = "골목길의 {npc:6986}",
	-- ["{npc:7010}, the Drag"] = "{npc:7010}, 골목길",
	-- ["{npc:7953}, riding trainer"] = "탈것 타기 상급자 {npc:7953}",
}
