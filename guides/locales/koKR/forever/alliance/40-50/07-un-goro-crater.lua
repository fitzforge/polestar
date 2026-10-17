-- Korean (koKR): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Gadgetzan
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:976} Gadgetzan · {npc:9619} Torwa Pathfinder
	["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "{area:144}에서 {area:150}(으)로 날아가 배를 타고 테라모어로 간 뒤, {area:976}(으)로 날아가세요. 분화구에서 {npc:9619}의 첫 퀘스트는 48레벨이 필요합니다. 부족하면 여기서 레벨을 채우세요.",
	-- {area:976} Gadgetzan
	["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "{area:976} 주변의 황무지유랑단이나 모래망치 오우거를 사냥하세요",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "{area:976}에서 서쪽으로 나가 {zone:1449}(으)로 내려가는 긴 비탈로 가세요. {npc:9619}은(는) 분화구 남동쪽 구석, 비탈 아래에 진을 치고 있습니다.",

	-- Step 3: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder
	["The dead Threshadon lies by the water north of {npc:9619}."] = "죽은 트레샤돈은 {npc:9619} 북쪽 물가에 있습니다.",

	-- Step 5: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "{npc:9683}와(과) 뗏목",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "{npc:9683}은(는) {npc:9619} 서쪽 밀림을 어슬렁거립니다. 부서진 뗏목은 그곳 호숫가에 있고, 작은 꾸러미는 그 옆 물속에 있습니다. 나침반, 지도, 열쇠는 {npc:8737}에게 주도록 보관하세요. 분화구의 어떤 야수든 {item:11116}을(를) 떨어뜨릴 수 있습니다. 오른쪽 클릭하세요.",

	-- Step 7: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {object:157936} Un'Goro Dirt Pile
	["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "분화구 동쪽을 따라 북쪽으로 북쪽 절벽 동굴 속 야영지인 {area:541}까지 가세요. 정예 데빌사우루스와 스테고돈은 멀리 피하세요. 여기서부터 지나가는 마력의 수정과 {object:157936}을(를) 모두 챙기세요.",
	["Gryfe"] = "그리페",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "{zone:1452}의 {npc:9298}에게서 끝납니다: 보관하세요",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave"] = "{npc:9117}, 동굴 안쪽",

	-- Step 8: Karna Remtravel
	-- {npc:9618} Karna Remtravel
	["{npc:9618} stands just outside the refuge."] = "{npc:9618}은(는) 야영지 바로 바깥에 서 있습니다.",

	-- Step 9: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537}와(과) 동쪽 밀림",
	-- {area:537} Fire Plume Ridge · {item:11113} Crate of Foodstuffs
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "남쪽으로 분화구 한가운데의 {area:537}까지 간 뒤 동쪽 밀림으로 가세요. 수정 무더기는 분화구 곳곳에, 특히 {area:537} 주변에 많습니다. 색깔마다 몇 개씩 더 챙기세요. {npc:6509}와(과) 덩이줄기 붉은꽃잎덩굴손이 꽃잎을 떨어뜨립니다. 탐험대의 {item:11113}은(는) 동쪽 밀림의 버려진 야영지에 있습니다.",

	-- Step 10: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "북쪽으로 {area:1943}까지 가세요. 로봇은 고릴라들 사이에 서 있습니다. 그곳의 깊은 동굴에는 들어가지 마세요.",

	-- Step 11: Zul'Farrak (optional)
	-- {area:978} Zul'Farrak
	["{area:978} (optional)"] = "{area:978}(선택)",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "파티라면 사냥 대신 {area:978}을(를) 도는 편이 더 빠릅니다. 트롤 도시는 {zone:1446} 북서부, {area:976} 바로 북쪽에 있습니다.",

	-- Step 12: Grind to 50
	["Grind to 50"] = "50레벨까지 사냥",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "{area:1943}의 고릴라는 작은 무리로 다니며 아직은 필요한 것을 떨어뜨리지 않습니다. {npc:9619}의 가죽 퀘스트는 나중에 나옵니다. 가장 깊은 동굴에는 들어가지 마세요. {npc:9622}은(는) 55레벨입니다.",
	-- {npc:6514} Un'Goro Gorilla · {area:1943} Ironstone Plateau · {zone:1449} Un'Goro Crater
	["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "{zone:1449} {area:1943}에서 {npc:6514} 사냥",

	-- Step 13: Marshal's Refuge
	["Ride west back to the refuge."] = "서쪽으로 야영지에 돌아가세요.",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "{zone:1444}의 {npc:7775}에게 줄 것: 보관하세요",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "{npc:9997} 옆의 나무 표지판",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, 야영지 입구",

	-- Step 14: Northern Pylon
	["Northern Pylon"] = "북쪽 수정탑",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:9998} Shizzle
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "수정탑은 야영지 동쪽 비탈에 서 있습니다. {npc:9166}이(가) 그 주변 비탈을 맴돕니다. {npc:9997}의 처치 수에 포함되며 {npc:9998}에게 줄 비늘을 떨어뜨립니다.",

	-- Step 15: The east side
	["The east side"] = "동쪽 지역",
	-- {npc:9165} Fledgling Pterrordax · {npc:9998} Shizzle
	-- plural, as words: Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales."] = "동쪽을 따라 남쪽으로 내려가세요. {npc:9162}은(는) 동쪽 밀림에서 풀을 뜯고, {npc:9165}은(는) 동쪽 절벽 근처를 납니다. 둘 다 {npc:9998}에게 줄 비늘을 떨어뜨립니다.",

	-- Step 16: Eastern Pylon
	["Eastern Pylon"] = "동쪽 수정탑",
	["The pylon stands on the eastern cliffs."] = "수정탑은 동쪽 절벽 위에 서 있습니다.",

	-- Step 17: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "동쪽 절벽을 따라 남쪽으로, 비탈 아래의 {npc:9619}에게 가세요.",
	["The pelts come after loop 2, on the gorilla plateau"] = "가죽은 두 번째 순환 이후, 고릴라 고원에서 모읍니다",

	-- Step 18: The Gorishi hive
	["The Gorishi hive"] = "고리쉬 벌집",
	-- {npc:9619} Torwa Pathfinder · {quest:3764} Un'Goro Soil · {npc:9166} Pterrordax
	["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "{npc:9619}에게서 서쪽으로 가세요. 실리시드 벌집이 분화구 남쪽을 채우고 있습니다. 유충이 매달린 방인 부화실에 긁개 유리병을 사용하세요. 병정 고리쉬와 일꾼 고리쉬가 {quest:3764}을(를) 떨어뜨립니다. 처치 수가 아직 필요하면 남쪽 절벽에 {npc:9166}이(가) 둥지를 틀고 있습니다.",

	-- Step 19: Bones and equipment
	["Bones and equipment"] = "뼈와 장비",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "{item:11114}은(는) 남서쪽 스테고돈 사이 땅바닥에 있습니다. 스테고돈은 정예이니 그 주변의 뼈만 줍고 나머지는 디메트로돈에게서 얻으세요. 탐험대의 {item:11112}은(는) 남서쪽 밀림에 있습니다.",

	-- Step 20: Western Pylon
	["Western Pylon"] = "서쪽 수정탑",
	-- {npc:9167} Frenzied Pterrordax
	["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "수정탑은 서쪽 절벽 위에 서 있습니다. {npc:9167}이(가) 서쪽 전역을 날아다닙니다.",

	-- Step 21: Marshal's Refuge
	["Ride north along the western jungle back to the refuge."] = "서쪽 밀림을 따라 북쪽으로 야영지에 돌아가세요.",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge's entrance"] = "{npc:9998}, 야영지 입구",

	-- Step 22: Spraggle Frock
	-- {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9997}의 친구 {npc:9999}이(가) 실종되었습니다.",

	-- Step 23: Ironstone Plateau
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "고릴라는 {area:541} 동쪽의 {area:1943}에 삽니다. 가죽은 {npc:9619}에게 주도록 보관하세요. 가장 깊은 동굴에는 들어가지 마세요. {npc:9622}은(는) 55레벨입니다.",

	-- Step 24: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999}은(는) 분화구 한가운데 {area:537}의 남동쪽 비탈에 앉아 있습니다.",

	-- Step 25: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "{npc:9999} 호위",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "{npc:9999}을(를) 북쪽 {area:541}까지 데려가세요. 그가 기절하면 {item:11804}을(를) 사용해 깨우세요.",

	-- Step 27: Sunken Temple
	-- {area:1417} Sunken Temple
	["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "파티라면 사냥 대신 {area:1417}을(를) 도는 편이 더 빠릅니다. 혼자 사냥하려면 이 단계를 건너뛰세요.",

	-- Step 28: Grind to 51
	["Grind to 51"] = "51레벨까지 사냥",
	-- {area:982} Noxious Lair · {zone:1446} Tanaris
	["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "센티파르 실리시드가 분화구 비탈 바로 동쪽, {zone:1446} 서부의 {area:982} 주변을 기어다닙니다. 일꾼이 가장 쉽게 끌어올 수 있습니다.",
	-- {npc:5458} Centipaar Worker · {area:982} Noxious Lair · {zone:1446} Tanaris
	["grind on {npc:5458} at {area:982}, {zone:1446}"] = "{zone:1446} {area:982}에서 {npc:5458} 사냥",

	-- Step 29: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "비탈을 내려가 분화구로 가세요. {npc:9619}은(는) 비탈 아래에 진을 치고 있습니다.",

	-- Step 30: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "{npc:9684}의 굴은 {npc:9619} 북쪽, 동쪽 절벽 아래 밀림에 있습니다. 그곳에서 {item:11568}을(를) 사용하세요. {npc:9684}은(는) 56레벨이니 생명력이 가득한 상태로 시작하세요.",

	-- Step 32: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "동쪽을 따라 북쪽의 고릴라 고원으로 가세요. 55레벨 고릴라 {npc:9622}은(는) 가장 깊은 동굴에 있습니다. 먼저 동굴 입구의 고릴라를 정리하세요.",

	-- Step 33: Krakle
	-- {area:541} Marshal's Refuge · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "서쪽으로 {area:541}을(를) 지나 서쪽을 따라 남쪽의 {area:543}까지 가세요. 고블린 {npc:10302}이(가) 물가에 앉아 있습니다.",

	-- Step 34: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "동쪽으로 {area:537}까지 가서 올라간 뒤, 꼭대기 근처 용암 분출구에서 {npc:10541}을(를) 사용하세요.",

	-- Step 36: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "분화구 남쪽을 가로질러 비탈 옆의 {npc:9619}에게 가세요.",

	-- Step 38: Ironforge
	-- {area:144} Thelsamar · {area:1537} Ironforge
	["Fly from {area:144} to {area:1537}."] = "{area:144}에서 {area:1537}(으)로 날아가세요.",

	-- Step 40: Tinker Town
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: 수액괴물은 {zone:1448}에 있습니다. 보관하세요",

	-- Step 41: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "{zone:1447}의 룬 탁본 네 개: 보관하세요",
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}: {zone:1447}의 오그틴크에게 줄 것, 보관하세요",

	-- Step 42: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "아케소누스는 {object:171709}에서 국왕 마그니 브론즈비어드 옆에 서 있습니다.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "유물은 {zone:1428}에 있습니다: 보관하세요",

	-- Step 43: Bind and train
	["Bind and train"] = "귀환 장소 설정 및 수련",

	-- Step 44: Xiggs Fuselighter
	-- {object:32359} Military Ward (no name in this language: may be words)
	["Xiggs waits in the {object:32359}."] = "시그스는 {object:32359}에서 기다립니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "{zone:1446} {area:982}에서 {npc:5458} 사냥",
}
