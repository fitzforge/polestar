-- Korean (koKR): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kadrak
	-- {area:380} Crossroads · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale · {item:16783} Bundle of Reports
	["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "{area:380}에서 길을 따라 북쪽으로 가세요. {npc:8582}은(는) 길이 {zone:1440}(으)로 들어가는 {area:1703}의 감시탑 위에 서 있습니다. 그가 주는 {item:16783}을(를) 열어 보세요.",

	-- Step 2: Warsong Scout
	-- {npc:12862} Warsong Scout
	["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "길을 따라 계속 북쪽으로 가세요. {npc:12862}은(는) 토막나무 주둔지 남쪽의 전쟁노래부족 벌목기지에서 기다립니다.",

	-- Step 3: Splintertree Post
	-- {area:431} Splintertree Post
	["{area:431} is just north up the road."] = "{area:431}은(는) 길을 따라 바로 북쪽에 있습니다.",

	-- Step 4: Night Run
	-- {npc:12696} Senani Thunderheart · {area:428} Night Run
	["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696}은(는) 토막나무 주둔지 바로 북동쪽의 전쟁노래부족 야영지인 {area:428}에서 사냥 게시판 옆에 서 있습니다.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "{npc:12696}의 사냥 대상(우르산고우스, 샤둠브라, 뾰족발톱)은 27레벨에 다음으로 {zone:1440}에 올 때 처리합니다.",

	-- Step 5: Warsong Outrider
	-- {npc:12864} Warsong Outrider · {area:428} Night Run · {area:430} Satyrnaar
	["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864}은(는) {area:428} 동쪽에서 {area:430} 쪽으로 길을 순찰합니다.",

	-- Step 6: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "서쪽으로 가는 길에, {npc:267214}이(가) {area:415} 남동쪽, 큰길 남쪽의 협곡에 갇혀 있습니다. 검은뿔순록과 잿빛골짜기곰이 주변 숲을 돌아다닙니다.",

	-- Step 7: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "{npc:267214}의 {npc:271181}을(를) 조종해 4분 안에 협곡에서 큰길까지 데려가세요. 정신 집중이 끊기면 {npc:267214}에게 다시 부탁하세요.",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "길 위의 {npc:271181}",

	-- Step 8: Zoram'gar Outpost
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand
	["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "큰길을 따라 서쪽으로 {zone:1440}을(를) 가로질러 {area:415}(얼라이언스: 길에서 벗어나지 마세요)을(를) 지나 해안까지 가세요. {area:2897}은(는) 북서쪽 {area:414}에 있습니다. 그곳의 다른 퀘스트는 27레벨에 다음으로 올 때 처리합니다.",

	-- Step 9: Naga heads
	["Naga heads"] = "나가 머리",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "전초기지 북쪽 해안을 따라 있는 성난지느러미일족 나가는 모두 머리를 떨어뜨립니다.",

	-- Step 11: Back to Kadrak
	-- {npc:8582} Kadrak
	["Back to {npc:8582}"] = "{npc:8582}에게 돌아가기",
	-- {area:431} Splintertree Post · {area:1703} Mor'shan Rampart
	["Fly to {area:431} and ride south down the road to the {area:1703}."] = "{area:431}(으)로 날아간 뒤 길을 따라 남쪽의 {area:1703}(으)로 가세요.",

	-- Step 12: Malaka'jin
	-- {area:380} Crossroads · {zone:1413} Barrens · {area:2539} Malaka'jin
	["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "남쪽의 {area:380}(으)로 간 뒤, 길을 따라 서쪽으로 {zone:1413}을(를) 벗어나 돌발톱 산맥으로 들어가세요. 트롤 마을 {area:2539}은(는) 협곡 입구에 있습니다.",

	-- Step 13: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "길은 {area:1076}(이)라는 이름으로 북쪽으로 올라갑니다. {quest:1483}의 오두막은 길이 동쪽 {area:461}(으)로 갈라지는 곳에 있습니다.",

	-- Step 14: Windshear Crag
	-- {area:461} Windshear Crag · {npc:4276} Piznik
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "지즈의 동쪽에서 투자개발회사가 {area:461}의 나무를 베어내고 있습니다. 운전수 중 하나가 설계도를 지니고 있습니다. {npc:4276}은(는) 동쪽의 작은 광산에서 채굴합니다. 그가 채굴하는 동안 곁에 있으세요. 투자개발회사 불량배가 그를 노리고 옵니다.",

	-- Step 15: Ziz Fizziks
	-- {area:392} Ratchet
	["Sputtervalve in {area:392}: the next guide passes there"] = "{area:392}의 스퍼터밸브: 다음 가이드에서 그곳을 지납니다",

	-- Step 16: Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Follow the road west to {area:460}."] = "길을 따라 서쪽의 {area:460}(으)로 가세요.",
	-- {npc:11860} Maggran Earthbinder · {object:19844} Great Lift
	["{npc:11860}: Grish is at the {object:19844}, in the next guide"] = "{npc:11860}: 그리쉬는 다음 가이드에서 {object:19844}에 있습니다",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: 혈폭풍하피에게서 얻는 {item:277936}",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "정문 밖의 {npc:4198}",
	-- {npc:12736} Je'neu Sancrea
	["{npc:12736} at Zoram'gar, at 27"] = "27레벨에 조람가르의 {npc:12736}",

	-- Step 17: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "가이아 씨앗",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "가이아 씨앗은 해바위 야영지 북쪽, {area:464} 남쪽 기슭 주변의 풀밭에 있습니다.",

	-- Step 18: Stonetalon Peak
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "길을 따라 북쪽의 {area:467}(으)로 가세요. 가는 길에 순록이 풀을 뜯고, 수액괴물, 황혼의 흑표범, 마룡은 봉우리 아래 숲을 돌아다니며, 세나리온 드루이드가 그곳 숲을 차지하고 있습니다.",

	-- Step 19: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "{npc:4198}의 다음 퀘스트인 오르다누스는 {zone:1440}의 얼라이언스 지역에 있습니다. 건너뛰세요.",

	-- Step 20: The Charred Vale
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "해바위 야영지 남서쪽에 불타 버린 {area:465}이(가) 있습니다. 골짜기 바닥의 흙더미에 가이아 씨앗을 심으세요. 불의 정령은 {item:16312}을(를) 떨어뜨립니다. 혈폭풍하피와 복병은 북쪽에, 암살자와 약탈자는 남쪽에 둥지를 틀고 있습니다.",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "가이아 흙더미",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "혈폭풍하피 누구에게서나 얻는 {item:277936}",

	-- Step 21: Sun Rock Retreat
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "바위 턱 위의 {npc:11862}",
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11862} 옆의 {npc:11861}",

	-- Step 22: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Ride back down the {area:1076} to {area:2539}."] = "{area:1076}을(를) 따라 {area:2539}(으)로 돌아가세요.",

	-- Step 23: To the Undercity
	-- {area:1497} Undercity
	["To the {area:1497}"] = "{area:1497}(으)로",
	-- {area:380} Crossroads · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {area:1497} Undercity · {area:153} Ruins of Lordaeron · {object:36078} Trade Quarter
	["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "동쪽의 {area:380}(으)로 가서 {zone:1454}(으)로 날아가세요. {zone:1454} 밖의 탑에서 {zone:1420}행 비행선을 타세요. {area:1497}은(는) {area:153} 아래에 있습니다. 박쥐 조련사는 {object:36078}에 있습니다.",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "{object:36126}의 {npc:10181}와(과) 대화하세요: {quest:93739}",

	-- Step 24: Aelthalyste
	-- {npc:4606} Aelthalyste · {object:36070} War Quarter
	["{npc:4606} stands in the {object:36070}."] = "{npc:4606}은(는) {object:36070}에 서 있습니다.",

	-- Step 25: Beren's Peril
	-- {area:272} Tarren Mill · {zone:1458} Undercity · {area:228} Sepulcher · {area:231} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone
	["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "이미 {area:272} 비행 경로를 안다면 그곳으로 날아가 {area:272} 단계로 건너뛰세요. 아니라면 {zone:1458}에서 {area:228}(으)로 날아가 길을 따라 남쪽으로 장작나무 마을을 지나가세요. 까마귀발톱 언데드는 숲 남동쪽, 길 동쪽의 {area:231} 폐허를 떠돕니다. {npc:1973}이(가) {object:645153}(으)로 이어지는 {item:271343}을(를) 떨어뜨립니다.",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{npc:1973}에게서 얻는 {item:271343}",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins"] = "폐허의 괴로워하는 영혼에게서 얻는 {item:271350}",

	-- Step 26: The Offering of Blood
	-- {npc:212753} Tortured Soul · {object:645153} Offering Stone · {quest:95883} The Tortured Soul
	["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "{object:645153}에서 {npc:212753}을(를) 사용해 자발적인 제물로 바치고, 응답하는 {npc:212753}을(를) 처치하세요. {quest:95883}은(는) 정예 퀘스트입니다. 파티를 권장합니다.",

	-- Step 27: Southpoint Tower
	-- {area:287} Hillsbrad · {npc:2214} Deathstalker Lesh · {area:285} Southpoint Tower
	["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "다시 길을 따라 남쪽으로 가세요. 길이 동쪽 {area:287}(으)로 꺾이는 곳의 {area:285}에서 {npc:2214}이(가) 기다립니다.",
	-- {npc:2214} Deathstalker Lesh · {area:272} Tarren Mill
	["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}: {area:272}의 다르탈리아",

	-- Step 28: Tarren Mill
	-- {area:272} Tarren Mill
	["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "길을 따라 강을 끼고 동쪽으로 간 뒤, 북동쪽 언덕을 올라 {area:272}(으)로 가세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "해바위 야영지 남서쪽에 불타 버린 {area:465}이(가) 있습니다. 골짜기 바닥의 흙더미에 가이아 씨앗을 심으세요. 불의 정령은 {item:16312}을(를) 떨어뜨립니다. 혈폭풍하피와 복병은 북쪽에, 암살자와 약탈자는 남쪽에 둥지를 틀고 있습니다.",
}
