-- Korean (koKR): the guide forever/horde/50-60/01-un-goro-crater (forever/horde/50-60/01-un-goro-crater.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Into Un'Goro Crater
	-- {zone:1449} Un'Goro Crater
	["Into {zone:1449}"] = "{zone:1449}(으)로",
	-- {area:1938} Broken Pillar · {zone:1449} Un'Goro Crater · {area:541} Marshal's Refuge
	["From the {area:1938} ride west to the long ramp that winds down into {zone:1449}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "{area:1938}에서 서쪽으로 가 {zone:1449}(으)로 구불구불 내려가는 긴 비탈길을 타고, 분화구 북쪽 벽을 따라 절벽 동굴 속 야영지인 {area:541}(으)로 가세요. 이곳 주민은 모두 중립입니다.",
	-- {npc:9997} Spraggle Frock
	["the wooden sign beside {npc:9997}, by the flight master: the pterrordax are on this guide's ground"] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "",

	-- Step 3: Out of the refuge
	["Out of the refuge"] = "야영지 밖으로",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "야영지 입구의 {npc:9998}",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "바로 밖의 {npc:9618}",
	-- {quest:3761} Un'Goro Soil
	["From here on pick up every Power Crystal (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "지금부터 지나가는 마력의 수정(파랑, 초록, 빨강, 노랑)과 {quest:3761} 더미를 모두 챙기세요. 흙은 모두 25개로, 하뮬에게 20개, 페슬저그에게 5개입니다.",

	-- Step 4: Lakkari Tar Pits
	-- {item:11834} Super Sticky Tar
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "잿구덩이는 야영지 바로 남쪽에 있습니다. 송진괴물, 송진껍질괴물, 송진이끼괴물이 {item:11834}을(를) 떨어뜨립니다.",

	-- Step 5: Pterrordax
	["Pterrordax"] = "테러닥스",
	-- {npc:9998} Shizzle
	["Pterrordax fly over the east of the crater, from the slopes below the refuge southward; their webbed scales are for {npc:9998}."] = "",
	["grind on Pterrordax"] = "",

	-- Step 6: Power Crystals and soil
	["Power Crystals and soil"] = "마력의 수정과 흙",
	-- {area:537} Fire Plume Ridge
	["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "수정 무더기는 분화구 곳곳에 있으며 {area:537} 주변에 많습니다. 수정탑용으로 색깔별로 몇 개씩 더 챙기세요.",

	-- Step 7: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "",
	-- {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:8659} Jes'rimon · {npc:9167} Frenzied Pterrordax
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Dinosaur Bones = {item:11114} Dinosaur Bone · Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot.\nSouth of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon.\nRide south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "",

	-- Step 8: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "원정대의 잃어버린 장비는 남서쪽 정글에 있습니다.",

	-- Step 9: The Slithering Scar
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "",
	-- {npc:6551} Gorishi Wasp
	["grind on {npc:6551}"] = "",

	-- Step 11: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "스테고돈과 라바사우루스",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}, 희귀 획득물",
	["Use the Mangled Journal to start it"] = "구겨진 일지를 사용해 시작하세요",

	-- Step 12: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619}은(는) 분화구 남동쪽 구석에 있습니다.",

	-- Step 13: Fresh Threshadon Carcass
	["North of Torwa, a dead Threshadon lies by the water."] = "토르와 북쪽 물가에 죽은 트레샤돈이 있습니다.",

	-- Step 15: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "라르코르위의 짝",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "라르코르위의 짝은 {npc:9619} 북서쪽 정글을 배회합니다.",

	-- Step 16: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "뗏목은 남동쪽 호숫가에 있고, 작은 배낭은 그 옆 물속에 있습니다.",
	["Underwater"] = "",

	-- Step 18: Lashers and Threshers
	["Lashers and Threshers"] = "채찍줄기와 덩이줄기",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "동쪽을 따라 북쪽으로 가세요. 채찍줄기 붉은꽃잎덩굴손과 덩이줄기 붉은꽃잎덩굴손이 정글에 가득합니다.",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "",

	-- Step 19: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "",
	["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "원정대의 상자는 동쪽 정글의 버려진 야영지에 있습니다.",

	-- Step 20: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "입구의 {npc:9998}",
	-- {npc:9997} Spraggle Frock
	["{npc:9997}, beside the flight master"] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "{npc:9118}의 {quest:4147}과(와) {npc:8737}의 편지는 이후 가이드를 위해 보관하세요.",

	-- Step 21: Northern Pylon
	["Northern Pylon"] = "북쪽 수정탑",
	["The pylon stands on the slope east of the refuge."] = "수정탑은 야영지 동쪽 비탈에 있습니다.",

	-- Step 22: Gorillas
	["Gorillas"] = "고릴라",
	-- {npc:9622} U'cha
	["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "고릴라는 북동쪽 고원에 삽니다. 가장 깊은 동굴에는 들어가지 마세요. {npc:9622}이(가) 삽니다.",
	-- {npc:9623} A-Me 01
	["{npc:9623}, the robot on the plateau; below ground"] = "",
	-- {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "그다음 {npc:9623}은(는) {skill:202} 아이템인 {item:10561}을(를) 원합니다. 가지고 있지 않으면 건너뛰세요.",

	-- Step 23: Un'Goro Crater: kill these as you meet them
	-- {spell:8137} Silithid Pox · {spell:14120} Tunneler Acid
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers may call for help within 25 yd when below 45% health; silithids cast {spell:8137} and Tunnelers and the Hive Guard use {spell:14120}."] = "",

	-- Step 24: Eastern Pylon
	["Eastern Pylon"] = "동쪽 수정탑",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "분화구 동쪽을 따라 내려가 동쪽 절벽의 수정탑으로 가세요.",

	-- Step 25: The Marshlands
	-- {quest:4061} The Rise of the Machines · {area:340} Kargath · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time.\nBelow level 52, keep hunting the ravasaurs here after the eighth claw: {quest:4061} at {area:340} needs level 52, and the Plaguelands quests at the end of this guide are level 55. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "",
	["grind on Ravasaur"] = "",

	-- Step 26: Western Pylon
	["Western Pylon"] = "서쪽 수정탑",
	["Cross the south of the crater to the pylon on the western cliffs."] = "분화구 남쪽을 가로질러 서쪽 절벽의 수정탑으로 가세요.",

	-- Step 27: J.D. Collie
	-- {area:541} Marshal's Refuge
	["Ride north back to {area:541}."] = "북쪽 {area:541}(으)로 돌아가세요.",
	["Below ground"] = "",

	-- Step 28: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "",

	-- Step 29: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 30: Orgrimmar
	-- {area:1637} Orgrimmar · {area:16727} Powderfuse Port · {zone:1458} Undercity
	["Fly to {area:1637} and train before the boat to {area:16727}: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "",

	-- Step 31: Back to Gadgetzan
	-- {area:976} Gadgetzan
	["Back to {area:976}"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 32: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "",
	-- {npc:9706} Yorba Screwspigot · {quest:4324} Yuka Screwspigot · {area:251} Flame Crest
	["{npc:9706}, by the dock: for {quest:4324} at {area:251}, later in this guide"] = "",

	-- Step 33: Badlands
	-- {zone:2548} Riverglades · {area:16685} Twilight's Shroud · {zone:1418} Badlands
	["Leave {zone:2548} on foot to the north-west, north of {area:16685}, into the {zone:1418}."] = "",

	-- Step 34: Kargath
	-- {area:340} Kargath · {zone:1418} Badlands
	["{area:340} is built into the cliffs on the {zone:1418}' west edge."] = "",

	-- Step 35: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "{zone:1427}(으)로",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {area:254} Blackrock Mountain
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "{area:340} 서쪽 고개를 넘어 {zone:1427}(으)로 간 뒤, 협곡을 가로질러 남쪽 {area:254}(으)로 이어지는 긴 다리로 가세요. 안에서는 사슬 통로를 따라 내려가 남쪽 출구로 나가세요. 던전 입구로 가는 길은 피하세요.",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "{area:254}(으)로 가는 다리",

	-- Step 36: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "산을 나오면 55-57 오크로 가득한 {area:252} 옆입니다. 북쪽 절벽을 따라 동쪽 길로 {area:251}의 호드 야영지로 가세요.",

	-- Step 37: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "절벽을 따라 남쪽, 불자루 오우거의 언덕인 {quest:3821}(으)로 가세요. {npc:9136}의 유해는 언덕 기슭에 있습니다.",

	-- Step 38: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822}은(는) {quest:3821}의 동굴과 갱도를 돌아다닙니다. 없으면 돌아올 때까지 입구 주변 오우거를 처치하세요.",

	-- Step 39: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "",
	-- {npc:7039} War Reaver · {quest:4296} Tablet of the Seven · {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "",

	-- Step 40: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "북동쪽 {area:251}(으)로 돌아가세요.",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "{npc:10267}의 편지는 보관하세요. {quest:4808}은(는) {zone:1452}의 {area:2255}에 있습니다.",

	-- Step 41: Kargath
	-- {area:1584} Blackrock Depths
	["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "테오도라의 다음 심부름은 마을 동쪽의 로트윌을 거쳐 {area:1584}(으)로 이어집니다. 건너뛰세요.",

	-- Step 42: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "{area:272}(으)로 날아가기",
	-- {area:340} Kargath
	["{area:340} flight master"] = "",

	-- Step 43: Apothecary Lydon
	["Inside"] = "",

	-- Step 44: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 45: Harbinger Balthazad
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{object:36078}, 박쥐 조련사 옆의 {npc:10879}",

	-- Step 46: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825}은(는) {object:36082}에 있습니다.",

	-- Step 47: Undercity
	-- {npc:8390} Chemist Cuely · {zone:1447} Azshara
	["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "연금술 실험실의 {npc:8390}: 약병은 나중에 {zone:1447}에서 채웁니다",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, near Cuely in the Apothecarium"] = "",
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522}, the {object:36073}"] = "{object:36073}의 {npc:6522}",

	-- Step 49: The Bulwark
	-- {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "{zone:1458}을(를) 나와 길을 따라 동쪽으로 {zone:1420}을(를) 지나 경계의 포세이큰 요새인 {area:152}로 가세요.",
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions · {quest:5401} Argent Dawn Commission
	["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "{quest:5096}을(를) 위해 델링턴 옆 상자에서 {object:176092}을(를) 챙기세요. 돌아오는 길에 완료합니다. {quest:5401}을(를) 착용하세요. 착용 중에만 스컬지석이 나옵니다.",

	-- Step 50: Janice Felstone
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands · {npc:10778} Janice Felstone
	["From the {area:152}, follow the road east into the {zone:1422}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "",
	["Upstairs"] = "",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house; inside"] = "",
	-- {npc:10781} Royal Overseer Bauhaus · {zone:1458} Undercity
	["Keep the parcel: {npc:10781} is in the {zone:1458}."] = "",

	-- Step 51: Scarlet forward camp
	["Scarlet forward camp"] = "붉은십자군 전진 야영지",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "붉은십자군의 천막은 {area:199}와(과) {area:200} 사이에 있습니다. {object:176092}(으)로 지휘 천막을 불태우고 스컬지 깃발을 꽂으세요.",

	-- Step 53: Augustus the Touched
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "길을 따라 동쪽으로 {zone:1422}을(를) 지나 강을 건너 {zone:1423}(으)로 가세요. 북서쪽의 폐허 마을 {area:2627}(으)로 가려면 길에서 북쪽으로 벗어나세요. {npc:12384}은(는) 마을 가장자리의 오두막에 있습니다.",

	-- Step 54: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound
	["The book lies in the ruined inn of {area:2627}.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "",

	-- Step 55: Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "남쪽 길로 돌아가 지역을 가로질러 동쪽 {area:2268}까지 가세요.",

	-- Step 56: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "",
	-- {npc:11063} Carlin Redpath · {npc:11064} Darrowshire Spirit · {area:2262} Darrowshire
	["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "{npc:11063}의 퀘스트가 있으면 처치한 스컬지가 가끔 {npc:11064}을(를) 남깁니다. 말을 걸어 풀어 주세요. 남서쪽 {area:2262}(으)로 가는 길에 언데드를 처치하세요.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "다로우샤이어 영혼 해방: 말 걸기",

	-- Step 57: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "{npc:10926}의 유령은 남서쪽 {area:2262} 폐허에 있습니다.",

	-- Step 58: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "인형의 머리와 양쪽 몸통은 {npc:10926} 주변 집들에 있습니다. 가방에서 합치세요.",

	-- Step 59: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}, where this guide ends"] = "",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "",

	-- Step 60: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "",

	-- Step 61: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "",

	-- Step 62: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "{area:2268}(으)로 돌아가기",

	-- Step 63: Fly to Tarren Mill
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "",

	-- Step 64: The road north
	["The road north"] = "",
	-- {area:197} Sorrow Hill
	["The road north to {area:197}"] = "",

	-- Step 65: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "",

	-- Step 66: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "북서쪽의 안돌할로 가세요. {npc:10667}은(는) 마을 서쪽의 무너진 여관에서 기다립니다. 안쪽의 해골은 54-57레벨이니 가장자리로만 다니세요.",

	-- Step 67: The Annals of Darrowshire
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "연대기는 안돌할 시청의 곰팡이 슨 고서 사이에 있습니다. 맞는 것을 찾을 때까지 열어 보세요.",

	-- Step 68: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{quest:5210} goes to {area:2268}: keep it for later. The next guide starts with {npc:10739} by the {area:202}, east of Andorhal."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Black Broodlings"] = "검은 새끼용",
	-- ["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "검은 새끼용은 {area:251} 바로 동쪽 언덕에 둥지를 틉니다. 새끼용이 거의 죽었을 때 {npc:10267}의 {item:12284}을(를) 사용해 정수를 포획하세요.",
	-- ["Bloodpetal Flayers"] = "칼날가시 붉은꽃잎덩굴손",
	-- ["Darrowshire Spirits"] = "다로우샤이어 영혼",
	-- ["Escort {npc:9999}"] = "{npc:9999} 호위",
	-- ["Fly to {area:1637} and train before the {object:3202} zeppelin: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "{object:3202}행 비행선을 타기 전에 {area:1637}(으)로 날아가 기술을 배우세요. 이 가이드 후반의 {zone:1458}에는 사냥꾼과 주술사 상급자가 없습니다.",
	-- ["Fly to {area:1637}, take the zeppelin to {object:3202} and fly from there to {area:340}, built into the cliffs on the {zone:1418}' west edge."] = "{area:1637}(으)로 날아가 {object:3202}행 비행선을 탄 뒤, 그곳에서 {zone:1418} 서쪽 끝 절벽에 지어진 {area:340}(으)로 날아가세요.",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "{area:1638}(으)로 날아가 {area:1639}의 {npc:3033}에게 기술을 배운 뒤, {area:1637}(으)로 날아가 {object:3202}행 비행선을 타세요.",
	-- ["Fly to {area:340}"] = "{area:340}(으)로 비행",
	-- ["Follow the road east through the {area:28} and across the river into the {area:139}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "길을 따라 동쪽으로 {area:28}을(를) 지나 강을 건너 {area:139}(으)로 가세요. 북서쪽의 폐허 마을 {area:2627}(으)로 가려면 길에서 북쪽으로 벗어나세요. {npc:12384}은(는) 마을 가장자리의 오두막에 있습니다.",
	-- ["From the {area:1938} ride west to the long ramp that winds down into {area:490}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "{area:1938}에서 서쪽으로 가 {area:490}(으)로 구불구불 내려가는 긴 비탈길을 타고, 분화구 북쪽 벽을 따라 절벽 동굴 속 야영지인 {area:541}(으)로 가세요. 이곳 주민은 모두 중립입니다.",
	-- ["Gorillas"] = "고릴라",
	-- ["Into {area:490}"] = "{area:490}(으)로",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "미끼는 보관하세요. {npc:9684}은(는) 레벨 56이며, 두 번째 순회 때 그 소굴을 지납니다.",
	-- ["Keep {quest:5152}: Marlene lives at {area:197} in the {zone:1422}."] = "{quest:5152}은(는) 보관하세요. 말레네는 {zone:1422}의 {area:197}에 삽니다.",
	-- ["Lashers and Threshers"] = "채찍줄기와 덩이줄기",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "{npc:9999}을(를) 북쪽 {area:541}(으)로 데려가세요. 기절하면 {item:11804}을(를) 사용해 깨우세요.",
	-- ["Leave the {zone:1458} and ride east along the road through {area:85} to the {area:152}, the Forsaken fort on the border."] = "{zone:1458}을(를) 나와 길을 따라 동쪽으로 {area:85}을(를) 지나 경계의 포세이큰 요새인 {area:152}로 가세요.",
	-- ["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "페슬저그의 다음 퀘스트는 정예 우두머리 {npc:10041}이(가) 필요합니다. 건너뛰세요.",
	-- ["Power Crystals and soil"] = "마력의 수정과 흙",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "동쪽 {area:537}(으)로 가서 올라가 정상 근처 용암 분출구에서 {npc:10541}을(를) 사용한 뒤, 서쪽 {npc:10302}에게 돌아가세요.",
	-- ["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "동쪽을 따라 북쪽으로 가세요. 채찍줄기 붉은꽃잎덩굴손과 덩이줄기 붉은꽃잎덩굴손이 정글에 가득합니다.",
	-- ["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "서쪽 절벽을 따라 남서쪽으로 가세요. {npc:9167}이(가) 서쪽 위를 날고, 같은 정글에 질긴뿌리 붉은꽃잎덩굴손이 자랍니다.",
	-- ["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "남서쪽, 분화구 한가운데의 화산인 {area:537}(으)로 가세요. 기슭에 칼날가시 붉은꽃잎덩굴손이 자랍니다.",
	-- ["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "서쪽 발굴지로 가세요. {npc:7039} 골렘(53)이 주변을 돌아다니며 조각을 자주 떨어뜨립니다. {quest:4296}은(는) 발굴지 한가운데 타우릿산 드워프들 사이에 있습니다. 베껴 쓰세요.",
	-- ["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon."] = "간헐천 남쪽에서 스테고돈이 풀을 뜯습니다. 공룡 뼈는 스테고돈이 떨어뜨리거나 땅에 놓여 있습니다. 근처 디메트로돈은 {npc:9998}이(가) 원하는 비늘을 지니고 있습니다. 라바사우루스는 남서쪽에서 무리 지어 사냥합니다. 발톱은 {npc:8659}에게 가져가며, 가끔 구겨진 일지를 지닌 개체가 있습니다(희귀 획득물: 얻었을 때만 퀘스트를 받으세요). 레벨 57 스테고돈인 그러프는 피하세요.",
	-- ["Termite mounds"] = "흰개미집",
	-- ["Thaurissan dig site"] = "타우릿산 발굴지",
	-- ["The Gorishi hive"] = "고리쉬 벌집",
	-- ["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "큰 흰개미집이 {area:2627} 동쪽 언덕 곳곳에 있습니다. 지나가는 흰개미집마다 {item:15042}을(를) 사용하세요.",
	-- ["The book lies in the ruined inn of {area:2627}."] = "책은 {area:2627}의 무너진 여관에 있습니다.",
	-- ["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "원정대의 상자는 동쪽 정글의 버려진 야영지에 있습니다.",
	-- ["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "고릴라는 북동쪽 고원에 삽니다. 가장 깊은 동굴에는 들어가지 마세요. {npc:9622}이(가) 삽니다.",
	-- ["The next guide starts here, at the chapel's flight master."] = "다음 가이드는 여기 예배당의 비행 조련사에서 시작합니다.",
	-- ["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "실리시드 벌집이 분화구 남쪽을 채우고 있습니다. 병정 고리쉬와 일꾼 고리쉬가 향낭을 떨어뜨립니다. 첫 번째 방 안의 알 덩어리에 빈 채집 약병을 사용하세요. 맨 아래의 여왕 고리쉬는 정예 우두머리이니 그 방에는 들어가지 마세요. {npc:9166}은(는) 벌집 위 절벽에 둥지를 틉니다. 그 비늘은 {npc:9998}에게 갑니다.",
	-- ["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "잿구덩이는 야영지 바로 남쪽에 있습니다. 송진괴물, 송진껍질괴물, 송진이끼괴물이 {item:11834}을(를) 떨어뜨립니다.",
	-- ["The wooden sign beside {npc:9997}"] = "{npc:9997} 옆의 나무 표지판",
	-- ["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "{area:340}의 테오도라 퀘스트는 레벨 52가 필요합니다. 야영지 바로 남쪽의 송진껍질괴물과 우두머리 송진괴물이 가장 가까운 사냥터입니다.",
	-- ["Western jungle"] = "서쪽 정글",
	-- ["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "{zone:1449}, {area:538}에서 송진껍질괴물 사냥",
	-- ["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302}이(가) {zone:1452}의 {npc:9298}에게 보냅니다. 보관하세요.",
	-- ["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "고블린 {npc:10302}은(는) 수정탑 바로 동쪽 {area:543}에 있습니다.",
	-- ["{npc:12250} lurks just west of {area:2262}."] = "{npc:12250}은(는) {area:2262} 바로 서쪽에 숨어 있습니다.",
	-- ["{npc:9117}, at the back of the cave"] = "동굴 안쪽의 {npc:9117}",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "이제 {npc:9619}이(가) 북동쪽 동굴에 있는 {npc:9622}의 가죽을 요구합니다. 건너뛰세요.",
	-- ["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "그다음 {npc:9623}은(는) {skill:202} 아이템인 {item:10561}을(를) 원합니다. 가지고 있지 않으면 건너뛰세요.",
	-- ["{npc:9623}, the robot on the plateau"] = "고원의 로봇 {npc:9623}",
	-- ["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "{npc:9684}의 소굴은 수정탑 바로 남쪽에 있습니다. 그곳에서 {npc:9619}의 미끼를 사용하세요. {npc:9684}은(는) 레벨 56이고 공격이 강하니 생명력을 가득 채우고 시작하세요.",
	-- ["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999}이(가) 길을 잃고 지친 채 마루에 앉아 있습니다.",
}
