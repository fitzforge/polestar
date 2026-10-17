-- Korean (koKR): the guide forever/horde/06-hillsbrad-foothills (forever/horde/06-hillsbrad-foothills.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Tarren Mill
	-- {area:272} Tarren Mill
	["You arrive bound at the {area:272} inn. Everyone stands around the town square."] = "{area:272} 여관에 귀환 지점을 정한 상태로 도착합니다. 모두 마을 광장 주변에 있습니다.",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "여관 옆의 {object:1763} 게시판",
	-- {quest:567} Dangerous!
	["The {quest:567} poster: its targets come up along the way"] = "{quest:567} 게시판: 대상은 가는 길에 나옵니다",
	-- {item:7768} Empty Red Waterskin · {object:107045} Spring Well
	["Fill the {item:7768} at the {object:107045} beside the inn"] = "여관 옆의 {object:107045}에서 {item:7768}을(를) 채우세요",

	-- Step 2: Serge Hinott
	-- {zone:1413} The Barrens · {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: Poisons."] = "{zone:1413}에서 갤리윅스를 처치했을 때만(미션 임파서블: 잘하면 가능): {npc:2391}은(는) {area:272}에 있습니다. 해독제를 만드는 동안 옆에서 기다린 뒤 보상을 받으세요: 독 조제.",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}: 독 조제",
	["No Gallywix yet? The Class guide Poisons (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "아직 갤리윅스를 처치하지 않았나요? 직업 가이드 독 조제 (호드)에서 셴툴부터 연계 퀘스트를 다시 진행하며, 갤리윅스는 파티와 함께 처치합니다.",

	-- Step 3: Bears, creepers and lions
	["Bears, creepers and lions"] = "곰, 거미, 사자",
	-- {item:3477} Creeper Ichor
	-- plural, as words: Gray Bears = {npc:2351} Gray Bear · Forest Moss Creepers = {npc:2350} Forest Moss Creeper · Starving Mountain Lions = {npc:2384} Starving Mountain Lion
	["West of Tarren Mill, Gray Bears, Forest Moss Creepers and Starving Mountain Lions roam the hills on the way down to the farms. The creepers drop {item:3477} rarely; you need only one."] = "타렌 밀농장 서쪽, 농장으로 내려가는 길의 언덕에 회색곰, 숲이끼거미, 굶주린 산사자가 돌아다닙니다. 숲이끼거미는 {item:3477}을(를) 드물게 떨어뜨리며, 하나만 있으면 됩니다.",

	-- Step 4: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz · {npc:2451} Farmer Kalaba
	["The farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere. {npc:2451} tends the field south of the farms."] = "{area:287} 마을 동쪽의 농장입니다. {npc:232}은(는) 북쪽 농가 옆 밭에서, {npc:2403}은(는) 더 남동쪽 밭에서 일합니다. 힐스브래드 농노와 힐스브래드 농부는 곳곳에 있습니다. {npc:2451}은(는) 농장 남쪽 밭을 돌봅니다.",

	-- Step 5: Tarren Mill
	-- {npc:2230} Umpi
	["{npc:2230}, next to Lydon"] = "라이던 옆의 {npc:2230}",
	-- {npc:2215} High Executor Darthalia · {npc:270438} Deathstalker Masoj
	["{npc:2215}: orders for {npc:270438}, on the way to Durnholde"] = "{npc:2215}: 던홀드로 가는 길에 있는 {npc:270438}에게 전할 명령",

	-- Step 6: Syndicate camps
	["Syndicate camps"] = "비밀결사대 야영지",
	-- {area:272} Tarren Mill · {area:275} Durnholde Keep
	["From {area:272} go south-east into the hills on the way to {area:275}. Rogues and Watchmen hold the camps along the way."] = "{area:272}에서 남동쪽으로 {area:275}(으)로 가는 길의 언덕으로 가세요. 길목의 야영지에는 비밀결사대 도적과 비밀결사대 경비병이 있습니다.",

	-- Step 7: Durnholde Keep
	-- {npc:2238} Tog'thar · {area:275} Durnholde Keep
	["Drull and {npc:2238} are chained inside {area:275}'s courtyard buildings; open both locks."] = "드럴과 {npc:2238}은(는) {area:275} 안뜰 건물 안에 사슬로 묶여 있습니다. 자물쇠 두 개를 모두 여세요.",
	["Drull's ball and chain"] = "드럴의 족쇄",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "{npc:2238}의 족쇄",

	-- Step 8: Deathstalker Masoj
	-- {area:290} Dun Garok
	["Masoj hides on the hillside above {area:290}, south of Durnholde, on the way down to the blossoms."] = "Masoj는 던홀드 남쪽, 꽃이 있는 곳으로 내려가는 길의 {area:290} 위 언덕에 숨어 있습니다.",

	-- Step 9: Mudsnout Blossoms
	-- {item:3502} Mudsnout Blossoms
	["South-west of Durnholde, the {item:3502} grow on the hillsides above the river."] = "던홀드 남서쪽, 강 위 언덕에 {item:3502}이(가) 자랍니다.",

	-- Step 10: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["{npc:2055}, in the {zone:1458}"] = "{zone:1458}의 {npc:2055}",

	-- Step 11: Stanley
	-- {npc:2274} Stanley · {npc:232} Farmer Ray · {area:286} Hillsbrad Fields
	["{npc:2274} is {npc:232}'s dog, at the northern farmhouse in {area:286}."] = "{npc:2274}은(는) {npc:232}의 개로, {area:286}의 북쪽 농가에 있습니다.",

	-- Step 12: Peasants and skulls
	["Peasants and skulls"] = "소작농과 해골",
	-- {area:287} Hillsbrad
	["The Peasants work the fields south of the farmhouses. Every {area:287} human drops skulls; the Peasants drop them most often."] = "힐스브래드 소작농은 농가 남쪽 밭에서 일합니다. {area:287}의 인간은 모두 해골을 떨어뜨리며, 힐스브래드 소작농이 가장 자주 떨어뜨립니다.",

	-- Step 14: The smithy
	["The smithy"] = "대장간",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes
	["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks the street north of it."] = "대장간은 {area:287} 마을 한가운데에 있습니다. {npc:2404}와(과) 견습생들이 화로에서 일하고, {object:1736}은(는) 그 옆에 쌓여 있습니다. {npc:2449}은(는) 그 북쪽 거리를 걸어 다닙니다.",

	-- Step 16: Town hall
	["Town hall"] = "마을 회관",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["The town hall is on the west side of {area:287}. {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "마을 회관은 {area:287} 서쪽에 있습니다. {npc:2335} (30)와(과) {npc:2448}은(는) 힐스브래드 마을의 기록부와 함께 안에 있고, 힐스브래드 선언문은 그 옆에 붙어 있습니다. 힐스브래드 원로는 마을을 돌아다닙니다.",

	-- Step 18: Azurelode Mine
	-- {area:288} Azurelode Mine · {area:287} Hillsbrad · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["The {area:288} lies south of {area:287} town. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "{area:288}은(는) {area:287} 마을 남쪽에 있습니다. 힐스브래드 광부가 갱도에서 일하고, {npc:2305} (30)와(과) {npc:2450} (29)은(는) 깊숙한 곳에 있습니다.",

	-- Step 20: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell
	["{npc:2055}, in the Apothecarium"] = "연금술 실험실의 {npc:2055}",
	-- {area:287} Hillsbrad
	["Keep it: the {area:287} coast, later on the route"] = "보관하세요: 경로 후반의 {area:287} 해안",

	-- Step 21: Orgrimmar
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar
	["Take the zeppelin from the towers outside the {zone:1458} to {zone:1454} and train before you fly on."] = "{zone:1458} 바깥 탑에서 비행선을 타고 {zone:1454}(으)로 가서, 다시 날아가기 전에 기술을 배우세요.",

	-- Step 22: Thunder Bluff
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:1638} Thunder Bluff · {area:1639} Elder Rise · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:1638} and train on {area:1639}, then fly on to {area:378}."] = "{zone:1454}에서({zone:1458} 바깥 탑에서 비행선) {area:1638}(으)로 날아가 {area:1639}에서 기술을 배운 뒤 {area:378}(으)로 날아가세요.",

	-- Step 23: Camp Taurajo
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:378} Camp Taurajo
	["From {zone:1454} (zeppelin from the towers outside the {zone:1458}) fly to {area:378}."] = "{zone:1454}에서({zone:1458} 바깥 탑에서 비행선) {area:378}(으)로 날아가세요.",

	-- Step 24: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "{npc:5899}의 오두막은 {area:378} 남쪽, {area:359}(으)로 가는 길에 있는 가시멧돼지 물웅덩이 위 능선에 있습니다.",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}: {area:272}에서 채운 빨간 물주머니",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}: 파란 물주머니는 다음 가이드에서 {zone:1440}에서 채웁니다",

	-- Step 25: Tear of the Moons
	-- {area:359} Bael Modan · {npc:3421} Feegly the Exiled · {object:3646} General Twinbraid's Strongbox
	["Follow the road south to the dwarf dig site at {area:359}. {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "길을 따라 남쪽의 {area:359} 드워프 발굴지로 가세요. {npc:3421}은(는) 발굴지 남쪽 가장자리에 숨어 있고, {object:3646}은(는) 발굴 구덩이 바닥에 있습니다.",

	-- Step 26: Great Lift
	-- {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "바엘 모단 남서쪽, {area:1718} 꼭대기에서 {npc:12576}이(가) 기다립니다.",

	-- Step 27: Merchant Coast
	-- {area:378} Camp Taurajo · {area:392} Ratchet · {quest:874} Mahren Skyseer
	["Hearth to {area:378} and fly to {area:392}. {quest:874} camps on the shore north of {area:392}."] = "귀환석으로 {area:378}에 간 뒤 {area:392}(으)로 날아가세요. {quest:874}은(는) {area:392} 북쪽 해안에 야영하고 있습니다.",

	-- Step 28: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "큰 쓰레샤돈인 {quest:873}은(는) {npc:3388} 동쪽, {area:391} 앞바다 얕은 곳에서 헤엄칩니다.",

	-- Step 29: Ratchet
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442}, by the docks in {area:392}"] = "{area:392} 부두 옆의 {npc:3442}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["No Gallywix yet? The Class guide {spell:2842} (Horde) runs the chain from Shenthul again, with a group for Gallywix."] = "아직 갤리윅스를 처치하지 않았나요? 직업 가이드 {spell:2842} (호드)에서 셴툴부터 연계 퀘스트를 다시 진행하며, 갤리윅스는 파티와 함께 처치합니다.",
	-- ["Only if Gallywix fell in the {zone:1413} (Mission: Possible But Not Probable): {npc:2391} stands in {area:272}. Wait beside him while he brews the cure, then take your reward: {spell:2842}."] = "{zone:1413}에서 갤리윅스를 처치했을 때만(미션 임파서블: 잘하면 가능): {npc:2391}은(는) {area:272}에 있습니다. 해독제를 만드는 동안 옆에서 기다린 뒤 보상을 받으세요: {spell:2842}.",
	-- ["The smithy stands in the middle of {area:287} town. {npc:2404} and his apprentices work at the forge; the {item:3564} is stacked beside it. {npc:2449} walks the street north of it."] = "대장간은 {area:287} 마을 한가운데에 있습니다. {npc:2404}와(과) 견습생들이 화로에서 일하고, {item:3564}은(는) 그 옆에 쌓여 있습니다. {npc:2449}은(는) 그 북쪽 거리를 걸어 다닙니다.",
}
