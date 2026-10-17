-- Korean (koKR): the guide forever/alliance/40-50/03-feralas (forever/alliance/40-50/03-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Feathermoon Stronghold
	-- {area:608} Nijel's Point · {zone:1443} Desolace · {zone:1444} Feralas · {area:1108} Forgotten Coast · {area:1120} Sardor Isle
	["From Theramore, fly to {area:608} and ride south out of {zone:1443} into {zone:1444}; the road leads west to the {area:1108} dock, where the boat crosses to Feathermoon on {area:1120}."] = "테라모어 섬에서 {area:608}(으)로 날아간 다음, 남쪽으로 {zone:1443}을(를) 벗어나 {zone:1444}(으)로 가십시오. 길은 서쪽 {area:1108} 부두로 이어지고, 그곳에서 배를 타고 {area:1120}의 페더문 요새로 건너갑니다.",
	-- {npc:7877} Latronicus Moonspear
	["{npc:7877}, at the top of the stronghold"] = "{npc:7877}, 요새 꼭대기",
	-- {npc:3936} Shandris Feathermoon
	["{npc:3936}, beside him"] = "{npc:3936}, 그의 옆",
	-- {npc:7764} Troyas Moonbreeze · {area:702} Rut'theran Village
	["{npc:7764}: his answer waits in {area:702}, later"] = "{npc:7764}: 답장은 나중에 {area:702}에서 받습니다",

	-- Step 2: Ruins of Solarsal
	["Walk south along the island to the naga ruins; the gazebo stands among them."] = "섬을 따라 남쪽의 나가 폐허로 걸어가십시오. 정자는 폐허 사이에 있습니다.",

	-- Step 4: Hatecrest naga
	["Hatecrest naga"] = "증오의갈기일족 나가",
	-- {area:1117} Ruins of Solarsal
	["Back to the {area:1117}. Every Hatecrest naga there can drop scales."] = "{area:1117}(으)로 돌아가십시오. 그곳의 증오의갈기일족 나가는 모두 비늘을 떨어뜨릴 수 있습니다.",

	-- Step 5: Feathermoon Stronghold
	-- {npc:8136} Lord Shalzaru
	["{npc:8136} waits for the end of the mainland loop."] = "{npc:8136}은(는) 본토를 한 바퀴 돈 뒤에 처치합니다.",

	-- Step 6: The courier's boat
	["The courier's boat"] = "전령의 배",
	-- {area:1108} Forgotten Coast
	["Take the boat to the {area:1108} and follow the shore south to the wrecked row boat on the beach."] = "배를 타고 {area:1108}(으)로 가서 해안을 따라 남쪽으로, 해변에 부서진 나룻배까지 가십시오.",

	-- Step 7: Gordunni ogres
	["Gordunni ogres"] = "골두니일족 오우거",
	["Ride east to the Gordunni camp in the hills south-east of the yeti valley: Warlocks and Shaman hold the camp, Brutes wander the slopes around it and further north."] = "동쪽으로 설인 골짜기 남동쪽 언덕의 골두니 전초기지까지 가십시오. 골두니일족 흑마법사와 골두니일족 주술사가 야영지를 지키고, 골두니일족 투사는 주변 비탈과 더 북쪽을 돌아다닙니다.",

	-- Step 8: Feral Scar Vale
	-- {npc:5346} Bloodroar the Stalker
	["Ride north into the yeti valley. Every Feral Scar yeti can drop a thick hide; {npc:5346} (level 48) prowls the middle."] = "북쪽 설인 골짜기로 들어가십시오. 원시설인은 모두 두꺼운 설인 가죽을 떨어뜨릴 수 있습니다. {npc:5346}(48레벨)은(는) 한가운데를 배회합니다.",

	-- Step 9: Feathermoon Stronghold
	-- {area:1108} Forgotten Coast
	["Ride back north-west to the {area:1108} dock and take the boat to the island."] = "북서쪽 {area:1108} 부두로 돌아가 배를 타고 섬으로 가십시오.",

	-- Step 10: Lord Shalzaru
	-- {area:1121} Isle of Dread · {npc:8136} Lord Shalzaru
	-- plural, as words: Hatecrest Serpent Guards = {npc:5333} Hatecrest Serpent Guard
	["Swim south from the island to the {area:1121}. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "섬에서 남쪽으로 헤엄쳐 {area:1121}(으)로 가십시오. 증오의갈기일족 수호병과 증오의갈기일족 여마법사가 지키고 있으며, {npc:8136}(47레벨)은(는) 남쪽 끝 동굴에 있습니다. 경비병부터 끌어내십시오.",

	-- Step 11: Feathermoon Stronghold
	["Hearth to Feathermoon."] = "귀환석으로 페더문 요새에 가십시오.",

	-- Step 12: Grimtotem camp
	["Grimtotem camp"] = "그림토템 야영지",
	-- {area:1108} Forgotten Coast · {zone:1444} Feralas · {npc:7956} Kindal Moonweaver
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Boat to the {area:1108} and ride east across {zone:1444} to the Grimtotem camp north of the road. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "배를 타고 {area:1108}(으)로 가서 {zone:1444}을(를) 가로질러 동쪽, 길 북쪽의 그림토템 주둔지까지 가십시오. {npc:7956}은(는) 그 밖에서 기다립니다. 한가운데 우리에서 화살요정용을 풀어 주고, {npc:7956}과 화살요정용을 적어도 여섯 마리 살려 두십시오.",

	-- Step 13: Grimtotem tauren
	["Grimtotem tauren"] = "그림토템 타우렌",

	-- Step 14: Jer'kai Moonweaver
	-- {zone:1457} Darnassus
	["for Tyrande in {zone:1457}: the route takes you there at 47"] = "{zone:1457}의 티란데 위스퍼윈드에게: 경로상 47레벨에 그곳에 갑니다",

	-- Step 15: The Writhing Deep
	-- {area:489} Thalanaar
	["Ride south-east to the Woodpaw gnolls; the courier's backpacks lie in their southern camp, and a parcel inside them starts a delivery to {area:489}. The Zukk'ash hive is just south: fight down to the pod that holds Raschal, free him and keep him alive on the way out."] = "남동쪽의 덩굴발일족 놀에게 가십시오. 전령의 배낭은 남쪽 야영지에 있고, 그 안의 꾸러미로 {area:489} 배달이 시작됩니다. 바로 남쪽이 고통의 구덩이입니다: 안내원 라스칼이 갇힌 고치까지 싸우며 내려가 그를 풀어 주고, 나가는 동안 살려 두십시오.",
	-- {item:11463} Undelivered Parcel
	["{item:11463}, from the backpacks"] = "{item:11463}, 배낭에서",

	-- Step 16: Thalanaar
	-- {zone:1441} Thousand Needles
	["Ride north-east to the night elf outpost on the {zone:1441} border."] = "북동쪽으로 {zone:1441} 경계의 나이트 엘프 전초기지까지 가십시오.",
	-- {quest:1100} Lonebrow's Journal · {zone:1441} Thousand Needles
	["if you carry {quest:1100} from {zone:1441}"] = "{zone:1441}에서 {quest:1100}을(를) 가져왔다면",

	-- Step 17: Rage Scar yetis
	["Rage Scar yetis"] = "분노한 무쇠설인",
	-- {quest:7735} Pristine Yeti Hide · {npc:7852} Pratt McGrubben
	["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide; one may drop a {quest:7735}, which {npc:7852} pays for too."] = "길을 따라 서쪽으로 돌아간 다음 북쪽 무쇠설인 소굴 언덕으로 가십시오. 이곳의 설인은 모두 가죽을 떨어뜨릴 수 있고, {quest:7735}이(가) 나올 수도 있습니다. 이것도 {npc:7852}이(가) 값을 쳐 줍니다.",

	-- Step 18: Rockbiter
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["Ride west to the friendly mountain giant at the foot of the hills. Land Walkers and Cliff Giants around him are elite: give them room."] = "서쪽으로 언덕 기슭의 우호적인 산거인에게 가십시오. 주변의 평지거인과 절벽거인은 정예이니 거리를 두십시오.",

	-- Step 19: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["{npc:7774} wanders the hills north of {npc:7765}, among the Northspring harpies; her bell is in the chest beside her."] = "{npc:7774}은(는) {npc:7765} 북쪽 언덕의 바람계곡일족 하피 사이를 떠돕니다. 샤이의 종은 그녀 옆 상자에 있습니다.",

	-- Step 20: Shay Leafrunner's escort
	-- {npc:7774} Shay Leafrunner
	["{npc:7774}'s escort"] = "{npc:7774} 호위",
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Ring the bell whenever {npc:7774} stops to wander, and lead her south to {npc:7765}."] = "{npc:7774}이(가) 멈춰서 헤맬 때마다 종을 울리고, 남쪽의 {npc:7765}에게 데려가십시오.",

	-- Step 21: Feathermoon Stronghold
	-- {npc:3936} Shandris Feathermoon · {zone:1457} Darnassus · {area:976} Gadgetzan
	["{npc:3936} then asks you to carry news to {zone:1457}: skip it, {area:976} sends you there instead."] = "이어서 {npc:3936}이(가) {zone:1457}에 소식을 전해 달라고 합니다: 건너뛰십시오. 대신 {area:976}에서 그곳으로 보내 줍니다.",

	-- Step 22: Zul'Farrak instead of grinding
	-- {area:978} Zul'Farrak
	["{area:978} instead of grinding"] = "사냥 대신 {area:978}",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {npc:14637} Zorbin Fandazzle · {area:1108} Forgotten Coast
	["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in northern {zone:1446}, the next zone on the route; come back to {npc:14637} on the {area:1108} afterwards."] = "파티로 사냥 대신 {area:978}을(를) 돌면 더 빨리 도달합니다. 트롤 도시는 경로상 다음 지역인 {zone:1446} 북쪽에 있습니다. 그 후 {area:1108}의 {npc:14637}에게 돌아오십시오.",

	-- Step 23: Grind to 45
	["Grind to 45"] = "45레벨까지 사냥",
	-- {area:1108} Forgotten Coast · {area:1105} Feral Scar Vale · {npc:14637} Zorbin Fandazzle
	["Boat to the {area:1108} and ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45."] = "배를 타고 {area:1108}(으)로 가서 동쪽 {area:1105}(으)로 가십시오. 해안에 있는 {npc:14637}의 퀘스트는 45레벨이 필요합니다.",
	-- {npc:5292} Feral Scar Yeti · {area:1105} Feral Scar Vale · {zone:1444} Feralas
	["grind on {npc:5292} at {area:1105}, {zone:1444}"] = "{zone:1444} {area:1105}에서 {npc:5292} 사냥",

	-- Step 24: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast
	["Ride back to the {area:1108}; the goblin stands by the dock."] = "{area:1108}(으)로 돌아가십시오. 고블린은 부두 옆에 있습니다.",

	-- Step 25: Giants and elementals
	["Giants and elementals"] = "거인과 정령",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Shore Striders = {npc:5359} Shore Strider · Deep Striders = {npc:5360} Deep Strider · Wave Striders = {npc:5361} Wave Strider · Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Shore Striders, Deep Striders and Wave Striders (elite giants) wade along the coast north of the dock: zap one with {item:18904} and kill the shrunken giant. Sea Elementals and Sea Sprays drift in the same surf."] = "성큼걸이 해안거인, 성큼걸이 바다거인, 성큼걸이 파도거인(정예 거인)이 부두 북쪽 해안을 걸어다닙니다: {item:18904}(으)로 하나를 쏘고 작아진 거인을 처치하십시오. 바다 정령과 바다 물보라 정령도 같은 파도 속을 떠다닙니다.",

	-- Step 26: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["{npc:14637}'s refills are level 55: skip them."] = "{npc:14637}의 재충전 퀘스트는 55레벨입니다: 건너뛰십시오.",
	-- {area:1108} Forgotten Coast · {zone:1446} Tanaris
	["You end at the {area:1108} dock: the {zone:1446} guide starts with the trip east from here."] = "{area:1108} 부두에서 끝납니다: {zone:1446} 가이드는 여기서 동쪽으로 가는 길로 시작합니다.",
}
