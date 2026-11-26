-- Korean (koKR): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:35} Booty Bay · {zone:1447} Azshara · {zone:1444} Feralas · {zone:1446} Tanaris
	["{area:35} first, then {zone:1447}, {zone:1444} and {zone:1446}."] = "먼저 {area:35}, 그다음 {zone:1447}, {zone:1444}, {zone:1446}.",

	-- Step 2: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "{area:35}(으)로 날아가기",

	-- Step 3: Booty Bay
	-- {area:75} Stonard · {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["The flight from {area:75} lands on {area:35}'s upper deck. {npc:7406} has his workshop on the upper ring of the bay."] = "{area:75}에서 출발한 비행은 {area:35}의 위층 갑판에 내립니다. {npc:7406}의 작업장은 항구 위층 둘레에 있습니다.",
	-- {npc:7406} Oglethorpe Obnoticus
	["{npc:7406}, inside"] = "{npc:7406}, 내부",
	-- {zone:1446} Tanaris
	["\"Sea Wolf\" MacKinley, on the top floor: Stoley's shipment from {zone:1446}"] = "꼭대기 층의 \"바다늑대\" 매킨리: {zone:1446}에서 온 스톨리의 화물",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, on the balcony of the same building"] = "{npc:2487}, 같은 건물 발코니에 있습니다.",

	-- Step 4: Whiskey Slim
	-- {npc:2491} Whiskey Slim · {area:35} Booty Bay
	["{npc:2491} sits in the {area:35} inn."] = "{npc:2491}은(는) {area:35} 여관에 앉아 있습니다.",
	-- {npc:2491} Whiskey Slim
	["{npc:2491}, in the inn"] = "{npc:2491}, 여관 안",

	-- Step 5: The Bloodsail ships
	["The Bloodsail ships"] = "붉은해적단 배",
	-- {area:43} Wild Shore · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["South of Booty Bay, three Bloodsail ships lie off the {area:43}: {npc:2550}, {npc:2548} and {npc:2546} each stand on a deck with their crews. Swim out and work from ship to ship."] = "무법항 남쪽, {area:43} 앞바다에 블러드세일 선박 세 척이 있습니다. {npc:2550}, {npc:2548}, {npc:2546}이(가) 각각 선원들과 함께 갑판에 서 있습니다. 헤엄쳐 나가 배에서 배로 옮겨 다니세요.",

	-- Step 7: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "정예 몹입니다. 파티를 권장하니 사람을 구하세요. {quest:8552}은(는) 2인 파티가 필요합니다. 혼자라면 건너뛰세요. 경로에서 경험치를 다시 채워 줍니다.",

	-- Step 12: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "{object:3202}(으)로 날아가기",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35} 비행 조련사",

	-- Step 13: Grom'gol Base Camp
	-- {area:117} Grom'gol Base Camp · {npc:2497} Nimboya · {object:2076} Bubbling Cauldron
	["The flight lands at {area:117}; {npc:2497} stands by the {object:2076}."] = "비행기는 {area:117}에 착륙합니다. {npc:2497}은(는) {object:2076} 곁에 서 있습니다.",

	-- Step 14: Back to Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}"] = "{object:3202}(으)로 돌아가기",

	-- Step 15: The Mind's Eye
	-- {npc:818} Mai'Zoth
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:818} (level 47 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\nCareful: Two elite caster guards, around level 45, stand with {npc:818} and join the fight together with him."] = "정예 몹입니다. 파티를 권장하니 사람을 구하세요. {npc:818}(47레벨 정예)은 2인 파티가 필요합니다. 혼자라면 건너뛰세요. 경로에서 경험치를 다시 채워 줍니다.\n주의: 45레벨쯤의 정예 마법사 경호원 두 명이 {npc:818}과(와) 함께 서 있으며 그와 같이 전투에 참여합니다.",
	["Below ground"] = "지하",

	-- Step 17: Saving Yenniku
	["while he is alive: the gem fills; don't kill him"] = "그가 살아 있는 동안: 보석이 찹니다. 죽이지 마십시오",
	-- {item:3912} Soul Gem
	["Use the {item:3912} on Yenniku"] = "옌니쿠에게 {item:3912} 사용",

	-- Step 19: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "비행선 타고 {zone:1454}(으)로",

	-- Step 20: Zilzibin Drumlore
	-- {zone:1454} Orgrimmar · {npc:7010} Zilzibin Drumlore · {zone:1446} Tanaris
	["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}."] = "{zone:1454}을(를) 지나 비행 조련사로 가는 길에 골목길에 들르세요. {npc:7010}이(가) {zone:1446}의 곤충 보고서를 받습니다.",
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag"] = "{npc:7010}, 골목길",

	-- Step 21: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {zone:1447} Azshara · {area:1237} Valormok
	["{quest:4494} needs level 50: {npc:7010}, in the Drag, gives it from then on. Under 50, it waits: if you reach 50 in {zone:1447}, this guide brings you back for it from {area:1237}; else the {zone:1447} guide at 55 offers it again."] = "",

	-- Step 22: Dran Droffers
	["The Droffers' shop is a few steps further into the Drag."] = "드로퍼 가게는 골목길로 몇 걸음 더 들어간 곳에 있습니다.",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "골목길의 {npc:6986}",

	-- Step 23: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172959} The Drag · {quest:4300} Bone-Bladed Weapons · {zone:1447} Azshara
	["{npc:8659}, in {object:172959}, upstairs in one of its tallest buildings, has {quest:4300} for later; then your class trainer before you leave for {zone:1447}."] = "",
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659}, upstairs in {object:172959}"] = "",

	-- Step 24: Zor Lonetree
	-- {npc:4047} Zor Lonetree · {object:172957} Valley of Wisdom · {npc:4791} Nazeer Bloodpike · {zone:1445} Dustwallow Marsh
	["{npc:4047} stands in the {object:172957}: {npc:4791}'s report from {zone:1445}."] = "",

	-- Step 26: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "{zone:1447}(으)로 이동",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "토막나무 주둔지에서 길을 따라 동쪽으로 가세요. {npc:11548}은(는) 길에서 조금 벗어난 {area:1235}, 얼라이언스의 {area:3137} 바로 서쪽에서 기다립니다. 서쪽에서 접근하고 아즈샤라 파수꾼과 자로데누스(정예)를 피하세요.",

	-- Step 27: Haldarr Encampment: kill these as you meet them
	-- {area:1236} Haldarr Encampment
	["{area:1236}: kill these as you meet them"] = "{area:1236}: 만나는 대로 처치하세요",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "명가 유령은 제단 바로 북쪽의 폐허를 떠돌고, 할다르 사티로스는 조금 더 북쪽에 진을 치고 있습니다.",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} walks around {area:1235}: look inside the circle on the map"] = "{npc:6117}은(는) {area:1235}을(를) 배회합니다. 지도 원 안을 살펴보세요.",

	-- Step 28: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "제단의 {npc:11548}에게 돌아가세요. {area:3137} 경비병의 서쪽으로 다니세요.",

	-- Step 29: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "길을 따라 북쪽의 호드 야영지 {area:1237}(으)로 가세요.",

	-- Step 30: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",
	-- {zone:1447} Azshara · {area:1637} Orgrimmar · {quest:4493} March of the Silithid · {zone:1456} Thunder Bluff
	["You reached 50 in {zone:1447}: fly back to {area:1637} for {quest:4493} and your level 50 training, then on to {zone:1456}."] = "",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "{area:1237} 비행 조련사",

	-- Step 31: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} is in the Drag; your class trainer next."] = "",

	-- Step 32: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "{area:1638}(으)로 날아가기",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454} 비행 조련사",

	-- Step 34: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and Magatha are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "{zone:1456}(으)로 날아가세요. {area:1099}(으)로 가는 길목입니다. 아직 비행 경로가 없다면 {area:378}(으)로 날아가 {zone:1412}을(를) 지나 서쪽으로 가세요. 하뮬과 마가사는 {area:1639}에 있습니다. 드루이드와 성기사는 여기서 기술을 배웁니다({npc:3033}, {npc:246344}).",
	-- {npc:6746} Innkeeper Pala
	["{npc:6746}, at the inn: for Hamuul"] = "여관의 {npc:6746}: 하뮬에게",
	-- {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{npc:5769}, on the {area:1639}"] = "{npc:5769}, {area:1639}",

	-- Step 35: Thunder Bluff
	-- {quest:3761} Un'Goro Soil
	["{quest:3761} is gathered in the next guide."] = "{quest:3761}은(는) 다음 가이드에서 모읍니다.",

	-- Step 36: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "{area:1099}(으)로 날아가기",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456} 비행 조련사",

	-- Step 38: Camp Mojache
	-- {npc:8115} Witch Doctor Uzer'i
	["{npc:8115}, if you don't carry it yet: the materials come on this loop"] = "",
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: 곰은 {zone:1448}에 있음",
	-- {npc:7776} Talo Thornhoof
	["{npc:7776}: the Northspring harpies, at the far end of this loop"] = "",

	-- Step 39: Talo Thornhoof
	-- {quest:3062} Dark Heart · {npc:8075} Edana Hatetalon
	["{quest:3062}: {npc:8075} (level 50, elite) roosts above the Northspring harpies this loop ends at. Grouping up is advised: skip it if you are alone."] = "",

	-- Step 40: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "공작날개 히포그리프",
	-- {quest:3128} Natural Materials
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body. Nearly every one also drops the sinew and metallic fragments for {quest:3128}."] = "",

	-- Step 41: Hippogryph nests
	["Hippogryph nests"] = "히포그리프 둥지",
	-- {area:2522} Ruins of Isildien · {object:142071} Egg-O-Matic
	["The hippogryph nests are on the hills to the south, around the {area:2522}; each holds an egg for the {object:142071}."] = "히포그리프 둥지는 남쪽 언덕, {area:2522} 주변에 있습니다. 둥지마다 {object:142071}에 넣을 알이 하나씩 있습니다.",

	-- Step 43: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "화살요정용",
	-- {item:9589} Encrusted Minerals
	-- was: ["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "요정용은 야영지 바로 서쪽 숲을 날아다닙니다. 처치할 때마다 단지를 사용하세요."
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill; they carry the {item:9589} too."] = "",

	-- Step 45: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "떠도는 나무정령",
	-- {zone:1444} Feralas · {npc:272401} Vale Screamer
	-- plural, as words: Splintered Logs = {item:9590} Splintered Log
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths. They carry the Splintered Logs too.\nCareful: a {npc:272401} (level 60) flies over the forest west of the camp: keep clear of it."] = "",

	-- Step 47: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	-- was: ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "북서쪽 {area:1108}(으)로 가세요. {npc:14637}이(가) 부두에서 기다립니다."
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "",

	-- Step 48: Forgotten Coast: the water and the shore
	-- {area:1108} Forgotten Coast
	["{area:1108}: the water and the shore"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-48) wash along the shore just south of the dock and drop the Water Elemental Cores, as the Sea Elementals (47-49) do. The Wave and Deep Striders (47-49) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: {npc:14637} has a second round once these are done."] = "",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958}, 바다 물보라 정령에게서",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}, 물속의 파도 거인과 성큼걸이 바다거인에게 사용",

	-- Step 50: Forgotten Coast: the giants' hills
	-- {area:1108} Forgotten Coast
	["{area:1108}: the giants' hills"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant · Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	-- was: ["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "바다 정령과 바다 물보라 정령 정령가 부두 주변 해안을 따라 밀려다닙니다.\n평지거인과 절벽거인이 부두 북쪽 언덕을 돌아다닙니다. 먼저 각각에게 {item:18904}을(를) 쏘세요. 줄어들면 더 이상 정예가 아닙니다. 축소된 거인은 모두 잔여물을 떨어뜨립니다. 시체에 뮤세크 단지도 사용하세요."
	["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too.\nThe Sea Elementals and Sea Sprays along the shore have the last cores."] = "",

	-- Step 52: Northspring harpies
	["Northspring harpies"] = "바람계곡일족 하피",
	["The Northspring harpies nest on the ridges in the far north-west, past the giants' hills. The Windcallers heal, so kill them first and pull one at a time."] = "북녘골 하피는 거인 언덕 너머 북서쪽 끝 능선에 둥지를 틉니다. 바람소환사는 치유를 하니 먼저 처치하고, 하나씩 끌어오세요.",

	-- Step 53: Edana Hatetalon
	-- {npc:8075} Edana Hatetalon
	["{npc:8075} (level 50, elite) roosts on the cliff just north of the harpies' nests. Clear the harpies around her first."] = "",

	-- Step 54: Rage Scar yetis
	["Rage Scar yetis"] = "분노한 무쇠설인",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east towards the camp, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "드물게 떨어지는 {quest:7738}",

	-- Step 55: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "{area:1099}(으)로 돌아가기",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, 내부",

	-- Step 57: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "{area:976}(으)로 날아가기",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "{area:1099}의 비행 조련사",

	-- Step 58: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, 내부",

	-- Step 61: Gadgetzan
	-- {area:976} Gadgetzan · {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{area:976}'s Auction House is the last one before Un'Goro. There, {npc:9623} (Chasing {npc:9623}) asks for a {item:10561}, an {skill:202} item, before her escort: buy one here if you want that chain."] = "{area:976}의 경매장은 운고로 전 마지막 경매장입니다. 그곳에서 {npc:9623}({npc:9623} 추적)이(가) 호위 전에 {skill:202} 아이템인 {item:10561}을(를) 요구합니다: 이 연계를 하려면 여기서 하나 사십시오.",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "와이번 조련사 옆의 {npc:7876}",

	-- Step 62: The Egg-O-Matic
	-- {object:142071} Egg-O-Matic
	["The {object:142071}"] = "{object:142071}",
	-- {object:142071} Egg-O-Matic
	["The {object:142071}, in the middle of town"] = "마을 한가운데의 {object:142071}",

	-- Step 63: Marin Noggenfogger
	-- {zone:1449} Un'Goro Crater
	["Pestlezugg's samples come from {zone:1449}."] = "페슬저그의 표본은 {zone:1449}에서 구합니다.",

	-- Step 64: Marvon Rivetseeker
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "길을 따라 남쪽 {area:1938}(으)로 가세요. {npc:7771}이(가) 그 옆에 있습니다. 여기서 서쪽 길을 따라 내려가면 다음 가이드가 시작되는 {zone:1449}입니다.",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "{quest:3444}은(는) 보관하세요. {npc:7771}의 상자는 나중에 다시 와서 엽니다.",

	-- Step 65: The Dunemaul Compound
	-- {area:1938} Broken Pillar · {npc:12046} Gor'marok the Ravager · {npc:11758} Andi Lynn · {zone:1446} Tanaris
	["South of the {area:1938} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end: {npc:11758}'s quest, if you still carry it from {zone:1446}."] = "",

	-- Step 66: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley · {npc:7876} Tran'rek · {zone:1446} Tanaris · {area:976} Gadgetzan
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	-- was: ["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (48-50) are {npc:7876}'s, carried from your first {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop, with {npc:11758}'s."] = "주둔지에서 서쪽, 운고로 비탈길로 가는 길목입니다. {quest:3362}의 옹이진 덤불나무괴물과 뿌리조각사(48-50)는 처음 {zone:1446}에 왔을 때 받아 둔 {npc:7876}의 퀘스트입니다. 많이 돌아다니니 하나씩 끌어오세요. 다음 가이드에서 {area:976}에 들를 때 {npc:11758}의 퀘스트와 함께 {npc:7876}에게 제출합니다."
	["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (49-50) are {npc:7876}'s, carried from your second {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back north-east to {npc:8420}."] = "북동쪽 {npc:8420}에게 돌아가세요.",
	-- ["Class trainer"] = "직업 전문가",
	-- ["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "{area:1237}에서 {zone:1454}(으)로 날아간 뒤, 정문으로 나가 비행선 탑에서 {object:3202}행 비행선을 타세요.",
	-- ["Fly to the {area:1497}"] = "{area:1497}(으)로 비행",
	-- ["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "{zone:1456}(으)로 날아가세요. {area:1099}(으)로 가는 길목입니다. 아직 비행 경로가 없다면 {area:378}(으)로 날아가 {zone:1412}을(를) 지나 서쪽으로 가세요. 하뮬과 {npc:4046}은(는) {area:1639}에 있습니다. 드루이드와 성기사는 여기서 기술을 배웁니다({npc:3033}, {npc:246344}).",
	-- ["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "길을 따라 남쪽으로 가세요. 바실리스크는 정글 한가운데, 길 동쪽 바위 위에서 햇볕을 쬡니다. 조각은 자주 나옵니다.",
	-- ["From {area:3317}'s flight master, fly to the {area:1497}."] = "{area:3317}의 비행 조련사에게서 {area:1497}(으)로 날아가세요.",
	-- ["Highborne and Haldarr satyrs"] = "명가 유령과 할다르 사티로스",
	-- ["Ironjaw Basilisks"] = "무쇠턱 바실리스크",
	-- ["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "{npc:4046}, {npc:8659}, {npc:6522}에게 줄 배달품은 보관하세요. 나중에 {zone:1456}, {zone:1454}, {zone:1458}을(를) 지나갑니다.",
	-- ["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "{area:1417}은(는) {zone:1446}의 {npc:7771}을(를) 위해 보관하세요.",
	-- ["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "{npc:8659}의 대금과 아그토르의 {quest:3504}은(는) 보관하세요. 나중에 {area:1237}에 다시 갈 때 가져갑니다.",
	-- ["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}, and its experience shortens the top-up to 50 in {zone:1447}."] = "{zone:1454}을(를) 지나 비행 조련사로 가는 길에 골목길에 들르세요. {npc:7010}이(가) {zone:1446}의 곤충 보고서를 받으며, 그 경험치로 {zone:1447}에서 50 레벨까지 채우는 사냥이 줄어듭니다.",
	-- ["Only once all three robots are home"] = "로봇 세 대가 모두 돌아온 뒤에만",
	-- ["Paladin trainer"] = "성기사 상급자",
	-- ["Ride into {area:16}"] = "{area:16}(으)로 이동",
	-- ["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "북동쪽 {area:1227} 위 절벽의 고블린 야영지로 가세요.",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "북서쪽 {area:1108}(으)로 가세요. {npc:14637}이(가) 부두에서 기다립니다.",
	-- ["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "남서쪽 폐허로 가세요. 석판 네 개가 폐허 곳곳에 있고 원한의꼬리일족 나가가 지킵니다. 원한의꼬리일족 세이렌이나 원한의꼬리일족 미르미돈 누구나 {npc:8420}의 룬을 지니고 있을 수 있습니다.",
	-- ["Ride west back to {area:1237}."] = "서쪽 {area:1237}(으)로 돌아가세요.",
	-- ["Sea elementals"] = "바다 정령",
	-- ["South of the {area:1938} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end: {npc:11758}'s quest, carried from your first {zone:1446} visit."] = "{area:1938} 남쪽에 모래망치 오우거의 주둔지가 있고, 동쪽 끝에 {npc:12046}이(가) 있습니다. 처음 {zone:1446}에 왔을 때 받아 둔 {npc:11758}의 퀘스트입니다.",
	-- ["Take the zeppelin back to {zone:1454}."] = "비행선을 타고 {zone:1454}(으)로 돌아가세요.",
	-- ["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "{zone:1458} 밖의 탑에서 비행선을 타고 {zone:1454}(으)로 간 뒤 {area:431}(으)로 날아가세요.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "바다 정령과 바다 물보라 정령이 부두 주변 해안을 따라 밀려다닙니다.",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "바다 정령과 바다 물보라 정령 정령가 부두 주변 해안을 따라 밀려다닙니다.\n평지거인과 절벽거인이 부두 북쪽 언덕을 돌아다닙니다. 먼저 각각에게 {item:18904}을(를) 쏘세요. 줄어들면 더 이상 정예가 아닙니다. 축소된 거인은 모두 잔여물을 떨어뜨립니다. 시체에 뮤세크 단지도 사용하세요.",
	-- ["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "천둥뿔 히포그리프가 {area:1237} 바로 남쪽 언덕 위를 날아다닙니다.",
	-- ["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "블러드 엘프 야영지는 {npc:8420} 바로 남쪽에 있습니다. 그의 장비 네 개는 야영지 주변 상자에 있습니다.",
	-- ["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "요정용은 야영지 바로 서쪽 숲을 날아다닙니다. 처치할 때마다 단지를 사용하세요.",
	-- ["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "히포그리프는 야영지 남서쪽 언덕에 둥지를 틉니다. 하나를 처치한 뒤 시체에 뮤세크 단지를 사용하세요.",
	-- ["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "나무정령은 야영지와 {zone:1444} 중앙 사이의 숲길을 떠돕니다. 수가 적으니 길을 따라 찾아보세요.",
	-- ["The {object:2076} beside {npc:2519}"] = "{npc:2519} 옆의 {object:2076}",
	-- ["To {object:3202}"] = "{object:3202}(으)로",
	-- ["Undamaged Hippogryph Feathers"] = "온전한 히포그리프 깃털",
	-- ["Upstairs"] = "위층",
	-- ["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (48-50) are {npc:7876}'s, carried from your first {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop, with {npc:11758}'s."] = "주둔지에서 서쪽, 운고로 비탈길로 가는 길목입니다. {quest:3362}의 옹이진 덤불나무괴물과 뿌리조각사(48-50)는 처음 {zone:1446}에 왔을 때 받아 둔 {npc:7876}의 퀘스트입니다. 많이 돌아다니니 하나씩 끌어오세요. 다음 가이드에서 {area:976}에 들를 때 {npc:11758}의 퀘스트와 함께 {npc:7876}에게 제출합니다.",
	-- ["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "실렘의 탑은 {area:1237} 바로 북쪽 절벽 위에 있습니다. 길은 북쪽 면을 따라 구불구불 올라갑니다.",
	-- ["Zapped giants"] = "축소된 거인",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108}: 만나는 대로 처치하세요",
	-- ["{area:75} flight master"] = "{area:75} 비행 조련사",
	-- ["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344}은(는) {zone:1456}에 있습니다. {zone:1454}에는 성전사 교관이 없습니다.",
	-- ["{npc:7010}, the Drag: if you still carry it"] = "{npc:7010}, 골목길: 아직 가지고 있다면",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}: 곰은 {zone:1448}에 있음",
	-- ["{npc:7825} stands in the {object:36082}."] = "{npc:7825}은(는) {object:36082}에 있습니다.",
	-- ["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "{npc:7876}의 타르와 페슬저그의 표본은 {zone:1449}에서 구합니다.",
	-- ["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "야영지 동쪽 끝의 {npc:8395}: 경험치 없음, 아즈샤라 탑으로 순간이동만 가능",
	-- ["{npc:8659}, the {object:172960}"] = "{object:172960}의 {npc:8659}",
	-- ["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761}은(는) 다음 가이드에서 모읍니다. {npc:4046}의 대금은 나중에 {npc:8587}에게 가져갑니다.",
	-- ["{quest:4494} needs level 50: {npc:7010}, in the Drag, gives it from then on. Under 50, the {zone:1447} guide at 55 offers it again."] = "{quest:4494}은(는) 50레벨이 필요합니다. 그때부터 골목길의 {npc:7010}이(가) 줍니다. 50레벨 미만이면 55레벨 {zone:1447} 가이드에서 다시 받을 수 있습니다.",
}
