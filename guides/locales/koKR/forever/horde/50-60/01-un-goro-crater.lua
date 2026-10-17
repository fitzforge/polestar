-- Korean (koKR): the guide forever/horde/50-60/01-un-goro-crater (forever/horde/50-60/01-un-goro-crater.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Un'Goro Crater
	-- {zone:1449} Un'Goro Crater
	["Into {zone:1449}"] = "{zone:1449}(으)로",
	-- {area:1938} Broken Pillar · {zone:1449} Un'Goro Crater · {area:541} Marshal's Refuge
	["From the {area:1938} ride west to the long ramp that winds down into {zone:1449}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "{area:1938}에서 서쪽으로 가 {zone:1449}(으)로 구불구불 내려가는 긴 비탈길을 타고, 분화구 북쪽 벽을 따라 절벽 동굴 속 야영지인 {area:541}(으)로 가세요. 이곳 주민은 모두 중립입니다.",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "{npc:9997} 옆의 나무 표지판",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave"] = "동굴 안쪽의 {npc:9117}",

	-- Step 2: Out of the refuge
	["Out of the refuge"] = "야영지 밖으로",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "야영지 입구의 {npc:9998}",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "바로 밖의 {npc:9618}",
	-- {quest:3761} Un'Goro Soil
	["From here on pick up every Power Crystal (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "지금부터 지나가는 마력의 수정(파랑, 초록, 빨강, 노랑)과 {quest:3761} 더미를 모두 챙기세요. 흙은 모두 25개로, 하뮬에게 20개, 페슬저그에게 5개입니다.",

	-- Step 3: Lakkari Tar Pits
	-- {item:11834} Super Sticky Tar
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "잿구덩이는 야영지 바로 남쪽에 있습니다. 송진괴물, 송진껍질괴물, 송진이끼괴물이 {item:11834}을(를) 떨어뜨립니다.",

	-- Step 4: Western jungle
	["Western jungle"] = "서쪽 정글",
	-- {npc:9167} Frenzied Pterrordax
	-- plural, as words: Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "서쪽 절벽을 따라 남서쪽으로 가세요. {npc:9167}이(가) 서쪽 위를 날고, 같은 정글에 질긴뿌리 붉은꽃잎덩굴손이 자랍니다.",

	-- Step 5: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "스테고돈과 라바사우루스",
	-- {npc:9998} Shizzle · {npc:8659} Jes'rimon
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon."] = "간헐천 남쪽에서 스테고돈이 풀을 뜯습니다. 공룡 뼈는 스테고돈이 떨어뜨리거나 땅에 놓여 있습니다. 근처 디메트로돈은 {npc:9998}이(가) 원하는 비늘을 지니고 있습니다. 라바사우루스는 남서쪽에서 무리 지어 사냥합니다. 발톱은 {npc:8659}에게 가져가며, 가끔 구겨진 일지를 지닌 개체가 있습니다(희귀 획득물: 얻었을 때만 퀘스트를 받으세요). 레벨 57 스테고돈인 그러프는 피하세요.",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}, 희귀 획득물",
	["Use the Mangled Journal to start it"] = "구겨진 일지를 사용해 시작하세요",

	-- Step 6: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "원정대의 잃어버린 장비는 남서쪽 정글에 있습니다.",

	-- Step 7: The Gorishi hive
	["The Gorishi hive"] = "고리쉬 벌집",
	-- {npc:9166} Pterrordax · {npc:9998} Shizzle
	["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "실리시드 벌집이 분화구 남쪽을 채우고 있습니다. 병정 고리쉬와 일꾼 고리쉬가 향낭을 떨어뜨립니다. 첫 번째 방 안의 알 덩어리에 빈 채집 약병을 사용하세요. 맨 아래의 여왕 고리쉬는 정예 우두머리이니 그 방에는 들어가지 마세요. {npc:9166}은(는) 벌집 위 절벽에 둥지를 틉니다. 그 비늘은 {npc:9998}에게 갑니다.",

	-- Step 8: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "뗏목은 남동쪽 호숫가에 있고, 작은 배낭은 그 옆 물속에 있습니다.",

	-- Step 9: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619}은(는) 분화구 남동쪽 구석에 있습니다.",

	-- Step 10: Fresh Threshadon Carcass
	["North of Torwa, a dead Threshadon lies by the water."] = "토르와 북쪽 물가에 죽은 트레샤돈이 있습니다.",

	-- Step 12: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "라르코르위의 짝",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "라르코르위의 짝은 {npc:9619} 북서쪽 정글을 배회합니다.",

	-- Step 13: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "미끼는 보관하세요. {npc:9684}은(는) 레벨 56이며, 두 번째 순회 때 그 소굴을 지납니다.",

	-- Step 14: Lashers and Threshers
	["Lashers and Threshers"] = "채찍줄기와 덩이줄기",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "동쪽을 따라 북쪽으로 가세요. 채찍줄기 붉은꽃잎덩굴손과 덩이줄기 붉은꽃잎덩굴손이 정글에 가득합니다.",

	-- Step 15: Crate of Foodstuffs
	["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "원정대의 상자는 동쪽 정글의 버려진 야영지에 있습니다.",

	-- Step 16: Gorillas
	["Gorillas"] = "고릴라",
	-- {npc:9622} U'cha
	["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "고릴라는 북동쪽 고원에 삽니다. 가장 깊은 동굴에는 들어가지 마세요. {npc:9622}이(가) 삽니다.",
	-- {npc:9623} A-Me 01
	["{npc:9623}, the robot on the plateau"] = "고원의 로봇 {npc:9623}",
	-- {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "그다음 {npc:9623}은(는) {skill:202} 아이템인 {item:10561}을(를) 원합니다. 가지고 있지 않으면 건너뛰세요.",

	-- Step 17: Bloodpetal Flayers
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer
	["Bloodpetal Flayers"] = "칼날가시 붉은꽃잎덩굴손",
	-- {area:537} Fire Plume Ridge
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer
	["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "남서쪽, 분화구 한가운데의 화산인 {area:537}(으)로 가세요. 기슭에 칼날가시 붉은꽃잎덩굴손이 자랍니다.",

	-- Step 18: Power Crystals and soil
	["Power Crystals and soil"] = "마력의 수정과 흙",
	-- {area:537} Fire Plume Ridge
	["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "수정 무더기는 분화구 곳곳에 있으며 {area:537} 주변에 많습니다. 수정탑용으로 색깔별로 몇 개씩 더 챙기세요.",

	-- Step 19: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999}이(가) 길을 잃고 지친 채 마루에 앉아 있습니다.",

	-- Step 20: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "{npc:9999} 호위",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "{npc:9999}을(를) 북쪽 {area:541}(으)로 데려가세요. 기절하면 {item:11804}을(를) 사용해 깨우세요.",

	-- Step 21: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "입구의 {npc:9998}",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "{npc:9118}의 {quest:4147}과(와) {npc:8737}의 편지는 이후 가이드를 위해 보관하세요.",

	-- Step 22: Northern Pylon
	["Northern Pylon"] = "북쪽 수정탑",
	["The pylon stands on the slope east of the refuge."] = "수정탑은 야영지 동쪽 비탈에 있습니다.",

	-- Step 23: Eastern Pylon
	["Eastern Pylon"] = "동쪽 수정탑",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "분화구 동쪽을 따라 내려가 동쪽 절벽의 수정탑으로 가세요.",

	-- Step 24: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "{npc:9684}의 소굴은 수정탑 바로 남쪽에 있습니다. 그곳에서 {npc:9619}의 미끼를 사용하세요. {npc:9684}은(는) 레벨 56이고 공격이 강하니 생명력을 가득 채우고 시작하세요.",

	-- Step 25: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "이제 {npc:9619}이(가) 북동쪽 동굴에 있는 {npc:9622}의 가죽을 요구합니다. 건너뛰세요.",

	-- Step 26: Western Pylon
	["Western Pylon"] = "서쪽 수정탑",
	["Cross the south of the crater to the pylon on the western cliffs."] = "분화구 남쪽을 가로질러 서쪽 절벽의 수정탑으로 가세요.",

	-- Step 27: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "고블린 {npc:10302}은(는) 수정탑 바로 동쪽 {area:543}에 있습니다.",

	-- Step 28: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "동쪽 {area:537}(으)로 가서 올라가 정상 근처 용암 분출구에서 {npc:10541}을(를) 사용한 뒤, 서쪽 {npc:10302}에게 돌아가세요.",

	-- Step 29: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302}이(가) {zone:1452}의 {npc:9298}에게 보냅니다. 보관하세요.",

	-- Step 30: J.D. Collie
	-- {area:541} Marshal's Refuge
	["Ride north back to {area:541}."] = "북쪽 {area:541}(으)로 돌아가세요.",

	-- Step 31: Lakkari Tar Pits
	-- {area:340} Kargath
	-- plural, as words: Tar Lurkers = {npc:6518} Tar Lurker · Tar Lords = {npc:6519} Tar Lord
	["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "{area:340}의 테오도라 퀘스트는 레벨 52가 필요합니다. 야영지 바로 남쪽의 송진껍질괴물과 우두머리 송진괴물이 가장 가까운 사냥터입니다.",
	-- {area:538} Lakkari Tar Pits · {zone:1449} Un'Goro Crater
	-- plural, as words: Tar Lurkers = {npc:6518} Tar Lurker
	["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "{zone:1449}, {area:538}에서 송진껍질괴물 사냥",

	-- Step 32: Gadgetzan
	-- {npc:10041} Gorishi Hive Queen
	["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "페슬저그의 다음 퀘스트는 정예 우두머리 {npc:10041}이(가) 필요합니다. 건너뛰세요.",

	-- Step 33: Orgrimmar
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol · {zone:1458} Undercity
	["Fly to {area:1637} and train before the {object:3202} zeppelin: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "{object:3202}행 비행선을 타기 전에 {area:1637}(으)로 날아가 기술을 배우세요. 이 가이드 후반의 {zone:1458}에는 사냥꾼과 주술사 상급자가 없습니다.",

	-- Step 34: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:1637} Orgrimmar · {object:3202} Grom'gol
	["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "{area:1638}(으)로 날아가 {area:1639}의 {npc:3033}에게 기술을 배운 뒤, {area:1637}(으)로 날아가 {object:3202}행 비행선을 타세요.",

	-- Step 35: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "{area:340}(으)로 비행",
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol · {area:340} Kargath · {zone:1418} Badlands
	["Fly to {area:1637}, take the zeppelin to {object:3202} and fly from there to {area:340}, built into the cliffs on the {zone:1418}' west edge."] = "{area:1637}(으)로 날아가 {object:3202}행 비행선을 탄 뒤, 그곳에서 {zone:1418} 서쪽 끝 절벽에 지어진 {area:340}(으)로 날아가세요.",

	-- Step 36: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "{zone:1427}(으)로",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {area:254} Blackrock Mountain
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "{area:340} 서쪽 고개를 넘어 {zone:1427}(으)로 간 뒤, 협곡을 가로질러 남쪽 {area:254}(으)로 이어지는 긴 다리로 가세요. 안에서는 사슬 통로를 따라 내려가 남쪽 출구로 나가세요. 던전 입구로 가는 길은 피하세요.",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "{area:254}(으)로 가는 다리",

	-- Step 37: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "산을 나오면 55-57 오크로 가득한 {area:252} 옆입니다. 북쪽 절벽을 따라 동쪽 길로 {area:251}의 호드 야영지로 가세요.",

	-- Step 38: Black Broodlings
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings"] = "검은 새끼용",
	-- {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "검은 새끼용은 {area:251} 바로 동쪽 언덕에 둥지를 틉니다. 새끼용이 거의 죽었을 때 {npc:10267}의 {item:12284}을(를) 사용해 정수를 포획하세요.",

	-- Step 39: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "절벽을 따라 남쪽, 불자루 오우거의 언덕인 {quest:3821}(으)로 가세요. {npc:9136}의 유해는 언덕 기슭에 있습니다.",

	-- Step 40: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822}은(는) {quest:3821}의 동굴과 갱도를 돌아다닙니다. 없으면 돌아올 때까지 입구 주변 오우거를 처치하세요.",

	-- Step 41: Thaurissan dig site
	["Thaurissan dig site"] = "타우릿산 발굴지",
	-- {npc:7039} War Reaver · {quest:4296} Tablet of the Seven
	["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "서쪽 발굴지로 가세요. {npc:7039} 골렘(53)이 주변을 돌아다니며 조각을 자주 떨어뜨립니다. {quest:4296}은(는) 발굴지 한가운데 타우릿산 드워프들 사이에 있습니다. 베껴 쓰세요.",

	-- Step 42: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "북동쪽 {area:251}(으)로 돌아가세요.",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "{npc:10267}의 편지는 보관하세요. {quest:4808}은(는) {zone:1452}의 {area:2255}에 있습니다.",

	-- Step 43: Kargath
	-- {area:1584} Blackrock Depths
	["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "테오도라의 다음 심부름은 마을 동쪽의 로트윌을 거쳐 {area:1584}(으)로 이어집니다. 건너뛰세요.",

	-- Step 44: Undercity
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{object:36078}, 박쥐 조련사 옆의 {npc:10879}",
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522}, the {object:36073}"] = "{object:36073}의 {npc:6522}",
	-- {npc:8390} Chemist Cuely · {zone:1447} Azshara
	["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "연금술 실험실의 {npc:8390}: 약병은 나중에 {zone:1447}에서 채웁니다",

	-- Step 45: The Bulwark
	-- {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "{zone:1458}을(를) 나와 길을 따라 동쪽으로 {zone:1420}을(를) 지나 경계의 포세이큰 요새인 {area:152}로 가세요.",
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions · {quest:5401} Argent Dawn Commission
	["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "{quest:5096}을(를) 위해 델링턴 옆 상자에서 {object:176092}을(를) 챙기세요. 돌아오는 길에 완료합니다. {quest:5401}을(를) 착용하세요. 착용 중에만 스컬지석이 나옵니다.",

	-- Step 46: Augustus the Touched
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "길을 따라 동쪽으로 {zone:1422}을(를) 지나 강을 건너 {zone:1423}(으)로 가세요. 북서쪽의 폐허 마을 {area:2627}(으)로 가려면 길에서 북쪽으로 벗어나세요. {npc:12384}은(는) 마을 가장자리의 오두막에 있습니다.",

	-- Step 47: Augustus' Receipt Book
	-- {area:2627} Terrordale
	["The book lies in the ruined inn of {area:2627}."] = "책은 {area:2627}의 무너진 여관에 있습니다.",

	-- Step 49: Termite mounds
	["Termite mounds"] = "흰개미집",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound
	["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "큰 흰개미집이 {area:2627} 동쪽 언덕 곳곳에 있습니다. 지나가는 흰개미집마다 {item:15042}을(를) 사용하세요.",

	-- Step 50: Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "남쪽 길로 돌아가 지역을 가로질러 동쪽 {area:2268}까지 가세요.",

	-- Step 51: Darrowshire Spirits
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Darrowshire Spirits"] = "다로우샤이어 영혼",
	-- {npc:11063} Carlin Redpath · {npc:11064} Darrowshire Spirit · {area:2262} Darrowshire
	["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "{npc:11063}의 퀘스트가 있으면 처치한 스컬지가 가끔 {npc:11064}을(를) 남깁니다. 말을 걸어 풀어 주세요. 남서쪽 {area:2262}(으)로 가는 길에 언데드를 처치하세요.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "다로우샤이어 영혼 해방: 말 걸기",

	-- Step 52: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "{npc:10926}의 유령은 남서쪽 {area:2262} 폐허에 있습니다.",

	-- Step 53: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "인형의 머리와 양쪽 몸통은 {npc:10926} 주변 집들에 있습니다. 가방에서 합치세요.",

	-- Step 54: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: Marlene lives at {area:197} in the {zone:1422}."] = "{quest:5152}은(는) 보관하세요. 말레네는 {zone:1422}의 {area:197}에 삽니다.",

	-- Step 55: Zaeldarr the Outcast
	-- {npc:12250} Zaeldarr the Outcast · {area:2262} Darrowshire
	["{npc:12250} lurks just west of {area:2262}."] = "{npc:12250}은(는) {area:2262} 바로 서쪽에 숨어 있습니다.",

	-- Step 56: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "{area:2268}(으)로 돌아가기",
	["The next guide starts here, at the chapel's flight master."] = "다음 가이드는 여기 예배당의 비행 조련사에서 시작합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "{zone:1458}을(를) 나와 길을 따라 동쪽으로 {zone:1420}을(를) 지나 경계의 포세이큰 요새인 {area:152}(으)로 가세요.",
}
