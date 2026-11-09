-- Korean (koKR): the guide forever/horde/05-stonetalon-mountains (forever/horde/05-stonetalon-mountains.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Taskmaster Fizzule
	-- {area:382} Sludge Fen · {item:8051} Flare Gun
	["On the way north from Seereth's camp, keep east of the road to the Venture Co. tower north of the {area:382}. Before you go near Fizzule, use {item:8051} to fire two flares, then target him and /salute: he attacks anyone who comes in without signalling first."] = "",
	-- {quest:2478} Mission: Possible But Not Probable
	["{quest:2478} is for level 23 or more: the tower's drones are 25 and Gallywix a 23 elite. Do it when you can, with a group, from the Class guide Poisons (Horde)."] = "",

	-- Step 2: Kadrak
	-- {zone:1413} Barrens · {npc:8582} Kadrak · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["From Seereth's camp head north-east across the {zone:1413} to the road north of the Crossroads. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}."] = "",

	-- Step 3: Into Ashenvale
	-- {zone:1440} Ashenvale
	["Into {zone:1440}"] = "",
	-- {area:431} Splintertree Post
	["The road north to {area:431}"] = "",

	-- Step 4: Splintertree Post
	-- {area:431} Splintertree Post · {npc:12696} Senani Thunderheart · {area:428} Night Run · {npc:12867} Kuray'bin · {quest:6503} Ashenvale Outrunners
	["{area:431} is just north up the road. Coming in from the south, the flight master and {npc:12696}'s hunt board at {area:428} come first, then the vendors. {npc:12867} at the lumber camp offers {quest:6503}: leave it for the way back, at 22."] = "",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 26."] = "",

	-- Step 5: Va'xug Firefure
	-- {npc:267214} Va'xug Firefure · {area:415} Astranaar
	-- plural, as words: Shadowhorn Stags = {npc:3817} Shadowhorn Stag · Ashenvale Bears = {npc:3809} Ashenvale Bear
	["On the way west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "",

	-- Step 6: A Void Path
	-- {npc:267214} Va'xug Firefure · {npc:271181} Eye of Kilrogg
	["Steer {npc:267214}'s {npc:271181} out of the ravine to the main road within four minutes; if the channel breaks, ask {npc:267214} again."] = "{npc:267214}의 {npc:271181}을(를) 조종해 4분 안에 협곡에서 큰길까지 데려가세요. 정신 집중이 끊기면 {npc:267214}에게 다시 부탁하세요.",
	-- {npc:271181} Eye of Kilrogg
	["{npc:271181}, on the road"] = "길 위의 {npc:271181}",

	-- Step 7: Zoram'gar Outpost
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {area:2897} Zoram'gar Outpost · {area:414} Zoram Strand · {npc:12719} Marukai · {npc:12721} Mitsuwa · {npc:12757} Karang Amakkar · {npc:12863} Warsong Runner
	["Head west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west: {npc:12719}, {npc:12721} and {npc:12757} stand around it, the {npc:12863} beside the flight master. Its other quests are for the next visit, at 26."] = "",
	-- {npc:12721} Mitsuwa
	["{npc:12721}: the troll charms are in Thistlefur Hold, east of the outpost"] = "",
	-- {npc:12717} Muglash
	["{npc:12717}: take it last, his escort starts at once"] = "",

	-- Step 8: Vorsha the Lasher
	-- {npc:12717} Muglash · {npc:12719} Marukai
	["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead; the Wrathtail naga drop the heads {npc:12719} wants."] = "",
	["Naga brazier"] = "나가 화로",

	-- Step 9: Naga heads
	["Naga heads"] = "나가 머리",
	["Every Wrathtail naga along the strand north of the outpost drops heads."] = "전초기지 북쪽 해안을 따라 있는 성난지느러미일족 나가는 모두 머리를 떨어뜨립니다.",

	-- Step 10: Zoram'gar Outpost
	["Back to the outpost before heading east to Thistlefur."] = "",

	-- Step 11: Thistlefur Village
	["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold.\nCareful: A Shaman at 15% health or lower runs off to find help, which can pull extra furbolgs."] = "",

	-- Step 12: Thistlefur Hold
	["Thistlefur Hold"] = "엉겅퀴일족 소굴",
	-- {npc:12818} Ruul Snowhoof · {area:428} Night Run · {npc:3987} Dal Bloodclaw
	-- plural, as words: Troll Chests = {object:178144} Troll Chest
	["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}.\nCareful: Two scripted ambushes occur, each made up of three Thistlefurs (a Shaman, a Pathfinder and an Avenger, Ursa or Den Watcher): the first when you come back to the tunnel's fork inside the cave, the second just beyond the gate where {npc:3987} roams."] = "",
	["Below ground"] = "",
	-- {npc:12818} Ruul Snowhoof
	["{npc:12818}, below ground"] = "",

	-- Step 13: Zoram'gar Outpost
	-- {npc:12757} Karang Amakkar · {zone:1440} Ashenvale
	["Back west to Zoram'gar. {npc:12757} offers King of the Foulweald now; leave it for the next {zone:1440} visit at 26, when the walk east passes the Foulweald."] = "",

	-- Step 14: Splintertree Post
	-- {area:431} Splintertree Post · {npc:12837} Yama Snowhoof
	["Fly to {area:431}: {npc:12837} waits in the inn for news of Ruul."] = "",
	-- {npc:12837} Yama Snowhoof
	["{npc:12837}, inside the inn"] = "",

	-- Step 15: Ashenvale Outrunners
	-- {npc:12867} Kuray'bin
	["Out of the inn and south down the road to the lumber camp: {npc:12867} stands there. The night elf Outrunners (23-24) stalk the woods south-east of it; they stealth, so watch for them."] = "",

	-- Step 16: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",
	-- {area:431} Splintertree Post · {area:1637} Orgrimmar
	["Back north up the road to the {area:431} flight master and fly to {area:1637}."] = "",
	-- {area:431} Splintertree Post
	["{area:431} flight master"] = "",

	-- Step 17: Druid trainer
	["Druid trainer"] = "",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "",

	-- Step 19: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875}은(는) {object:172960}에 있습니다. 그곳 소환진에서 {item:6626}을(를) 사용하고 서큐버스를 쓰러뜨려 속박하십시오.",

	-- Step 20: Shenthul
	-- {quest:2478} Mission: Possible But Not Probable · {npc:3401} Shenthul · {object:172960} Cleft of Shadow
	["If you did {quest:2478} with a group, {npc:3401} in the {object:172960} takes it now."] = "",
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{area:272}의 {npc:2391}이(가) 독 조제를 가르칩니다: 보관하세요",

	-- Step 21: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 22: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152}은(는) 비행선 탑에서 길을 따라 북쪽으로 조금 걸어가면 나오는 {area:159}에서 성기사를 훈련시킵니다. 은빛소나무 숲으로 가려면 같은 길로 다시 내려오세요.",

	-- Step 23: Strange Lockbox
	-- {area:240} Dead Field · {object:177790} Strange Lockbox · {item:15882} Half Pendant of Aquatic Endurance · {area:228} Sepulcher
	["From the zeppelin towers, run south into Silverpine and west past the {area:240} to the coast: the {object:177790} lies at the bottom of very deep water there, beside an air fissure where you can breathe. Watch your breath on the way down. It holds the {item:15882} for Trial of the Sea Lion. Then on to the {area:228}."] = "",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}, from the {object:177790}"] = "",

	-- Step 24: Sepulcher
	-- {area:228} Sepulcher · {npc:2121} Shadow Priest Allister · {npc:1937} Apothecary Renferrel
	["From the zeppelin towers, run south through Tirisfal into Silverpine and down the road to the {area:228}. {npc:2121} and {npc:1937} stand by the crypt entrance."] = "",
	-- {npc:1937} Apothecary Renferrel · {area:272} Tarren Mill
	["{npc:1937}: Lydon in {area:272}, next guide"] = "",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril · {area:233} Ambermill
	["{npc:2121}: {quest:516}, south-east of {area:233}"] = "",

	-- Step 25: Silverpine Forest: kill these as you meet them
	-- {zone:1421} Silverpine Forest
	["{zone:1421}: kill these as you meet them"] = "",
	-- {area:233} Ambermill · {quest:516} Beren's Peril
	-- plural, as words: Dalaran Watchers = {npc:1888} Dalaran Watcher · Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["South down the road past Pyrewood: Dalaran Watchers and Wizards patrol the roads around {area:233}, and south-west of the town the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "",

	-- Step 26: Beren's Peril
	-- {quest:516} Beren's Peril · {npc:1973} Ravenclaw Guardian · {item:271343} Note Scrap · {object:645153} Offering Stone
	["The Ravenclaw undead haunt the ruins of {quest:516}, east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}.\nAn elite spirit (20) often stands beside the {object:645153}: pull the Ravenclaws away from the stone before you fight them."] = "",
	-- {item:271343} Note Scrap · {npc:1973} Ravenclaw Guardian
	["{item:271343}, from a {npc:1973}"] = "{npc:1973}에게서 얻는 {item:271343}",
	-- {object:645153} Offering Stone · {quest:95883} The Tortured Soul · {item:271343} Note Scrap
	["the {object:645153} offers {quest:95883} once the {item:271343} is in; below ground"] = "",
	-- {item:271350} Tortured Soul
	-- plural, as words: Tortured Souls = {item:271350} Tortured Soul
	["{item:271350}, from the Tortured Souls among the ruins; below ground"] = "",

	-- Step 27: The Offering of Blood
	-- {item:210713} Tortured Soul · {object:645153} Offering Stone · {quest:95883} The Tortured Soul
	["The quest hands you a {item:210713}: use it beside the {object:645153} to offer your blood, then kill the elite spirit that answers.\n{quest:95883} is elite: grouping up is advised."] = "",
	-- {item:210713} Tortured Soul · {object:645153} Offering Stone
	["{item:210713}, beside the {object:645153}: summons the elite spirit"] = "",

	-- Step 28: Into Hillsbrad
	-- {area:287} Hillsbrad
	["Into {area:287}"] = "",
	-- {area:285} Southpoint Tower
	["The road east to {area:285}"] = "",

	-- Step 29: Southpoint Tower
	-- {area:287} Hillsbrad · {npc:2214} Deathstalker Lesh · {area:285} Southpoint Tower
	["Back on the road south. Where it turns east into {area:287}, {npc:2214} waits at {area:285}."] = "다시 길을 따라 남쪽으로 가세요. 길이 동쪽 {area:287}(으)로 꺾이는 곳의 {area:285}에서 {npc:2214}이(가) 기다립니다.",
	-- {npc:2214} Deathstalker Lesh · {area:272} Tarren Mill
	["{npc:2214}: Darthalia in {area:272}"] = "{npc:2214}: {area:272}의 다르탈리아",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:8582}"] = "{npc:8582}에게 돌아가기",
	-- ["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him."] = "지즈의 동쪽에서 투자개발회사가 {area:461}의 나무를 베어내고 있습니다. 운전수 중 하나가 설계도를 지니고 있습니다. {npc:4276}은(는) 동쪽의 작은 광산에서 채굴합니다. 그가 채굴하는 동안 곁에 있으세요. 투자개발회사 불량배가 그를 노리고 옵니다.",
	-- ["Fly to {area:431} and ride south down the road to the {area:1703}."] = "{area:431}(으)로 날아간 뒤 길을 따라 남쪽의 {area:1703}(으)로 가세요.",
	-- ["Follow the road east along the river, then north-east up into the hills to {area:272}."] = "길을 따라 강을 끼고 동쪽으로 간 뒤, 북동쪽 언덕을 올라 {area:272}(으)로 가세요.",
	-- ["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "길을 따라 북쪽의 {area:467}(으)로 가세요. 가는 길에 순록이 풀을 뜯고, 수액괴물, 황혼의 흑표범, 마룡은 봉우리 아래 숲을 돌아다니며, 세나리온 드루이드가 그곳 숲을 차지하고 있습니다.",
	-- ["Follow the road west to {area:460}."] = "길을 따라 서쪽의 {area:460}(으)로 가세요.",
	-- ["From the {area:380} follow the road north. {npc:8582} stands on the watch tower of the {area:1703} where the road enters {zone:1440}. Open the {item:16783} he gives you."] = "{area:380}에서 길을 따라 북쪽으로 가세요. {npc:8582}은(는) 길이 {zone:1440}(으)로 들어가는 {area:1703}의 감시탑 위에 서 있습니다. 그가 주는 {item:16783}을(를) 열어 보세요.",
	-- ["Gaea Dirt Mounds"] = "가이아 흙더미",
	-- ["Gaea Seeds"] = "가이아 씨앗",
	-- ["If you already know the {area:272} flight path, fly there and skip to {area:272}. Otherwise fly from the {zone:1458} to the {area:228} and ride south down the road past Pyrewood. The Ravenclaw undead haunt the ruins of {area:231} east of the road in the south-east of the forest; a {npc:1973} drops the {item:271343} that leads to the {object:645153}."] = "이미 {area:272} 비행 경로를 안다면 그곳으로 날아가 {area:272} 단계로 건너뛰세요. 아니라면 {zone:1458}에서 {area:228}(으)로 날아가 길을 따라 남쪽으로 장작나무 마을을 지나가세요. 까마귀발톱 언데드는 숲 남동쪽, 길 동쪽의 {area:231} 폐허를 떠돕니다. {npc:1973}이(가) {object:645153}(으)로 이어지는 {item:271343}을(를) 떨어뜨립니다.",
	-- ["Keep north on the road. The {npc:12862} waits at the Warsong lumber camp, south of Splintertree."] = "길을 따라 계속 북쪽으로 가세요. {npc:12862}은(는) 토막나무 주둔지 남쪽의 전쟁노래부족 벌목기지에서 기다립니다.",
	-- ["On the ride west, {npc:267214} is stuck in a ravine south of the main road, south-east of {area:415}. Shadowhorn Stags and Ashenvale Bears roam the woods all around it."] = "서쪽으로 가는 길에, {npc:267214}이(가) {area:415} 남동쪽, 큰길 남쪽의 협곡에 갇혀 있습니다. 검은뿔순록과 잿빛골짜기곰이 주변 숲을 돌아다닙니다.",
	-- ["Ride back down the {area:1076} to {area:2539}."] = "{area:1076}을(를) 따라 {area:2539}(으)로 돌아가세요.",
	-- ["Ride east to the {area:380} and fly to {zone:1454}. Take the zeppelin from the towers outside {zone:1454} to {zone:1420}; the {area:1497} lies below the {area:153}. The bat handler is in the {object:36078}."] = "동쪽의 {area:380}(으)로 가서 {zone:1454}(으)로 날아가세요. {zone:1454} 밖의 탑에서 {zone:1420}행 비행선을 타세요. {area:1497}은(는) {area:153} 아래에 있습니다. 박쥐 조련사는 {object:36078}에 있습니다.",
	-- ["Ride south to the {area:380}, then west along the road out of the {zone:1413} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "남쪽의 {area:380}(으)로 간 뒤, 길을 따라 서쪽으로 {zone:1413}을(를) 벗어나 돌발톱 산맥으로 들어가세요. 트롤 마을 {area:2539}은(는) 협곡 입구에 있습니다.",
	-- ["Ride west along the main road across {zone:1440}, past {area:415} (Alliance: keep to the road), to the coast. {area:2897} is on the {area:414} in the north-west. Its other quests are for the next visit, at 27."] = "큰길을 따라 서쪽으로 {zone:1440}을(를) 가로질러 {area:415}(얼라이언스: 길에서 벗어나지 마세요)을(를) 지나 해안까지 가세요. {area:2897}은(는) 북서쪽 {area:414}에 있습니다. 그곳의 다른 퀘스트는 27레벨에 다음으로 올 때 처리합니다.",
	-- ["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "해바위 야영지 남서쪽에 불타 버린 {area:465}이(가) 있습니다. 골짜기 바닥의 흙더미에 가이아 씨앗을 심으세요. 불의 정령은 {item:16312}을(를) 떨어뜨립니다. 혈폭풍하피와 복병은 북쪽에, 암살자와 약탈자는 남쪽에 둥지를 틀고 있습니다.",
	-- ["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "{object:36126}의 {npc:10181}와(과) 대화하세요: {quest:93739}",
	-- ["Sputtervalve in {area:392}: the next guide passes there"] = "{area:392}의 스퍼터밸브: 다음 가이드에서 그곳을 지납니다",
	-- ["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock."] = "가이아 씨앗은 해바위 야영지 북쪽, {area:464} 남쪽 기슭 주변의 풀밭에 있습니다.",
	-- ["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "길은 {area:1076}(이)라는 이름으로 북쪽으로 올라갑니다. {quest:1483}의 오두막은 길이 동쪽 {area:461}(으)로 갈라지는 곳에 있습니다.",
	-- ["The {npc:12864} patrols the road east of {area:428} toward the {area:430}."] = "{npc:12864}은(는) {area:428} 동쪽에서 {area:430} 쪽으로 길을 순찰합니다.",
	-- ["To the {area:1497}"] = "{area:1497}(으)로",
	-- ["Use the {npc:212753} at the {object:645153} for a willing sacrifice and kill the {npc:212753} that answers. {quest:95883} is elite: grouping up is advised."] = "{object:645153}에서 {npc:212753}을(를) 사용해 자발적인 제물로 바치고, 응답하는 {npc:212753}을(를) 처치하세요. {quest:95883}은(는) 정예 퀘스트입니다. 파티를 권장합니다.",
	-- ["{area:431} is just north up the road."] = "{area:431}은(는) 길을 따라 바로 북쪽에 있습니다.",
	-- ["{item:271350}, from the Tortured Souls among the ruins"] = "폐허의 괴로워하는 영혼에게서 얻는 {item:271350}",
	-- ["{item:277936}, from any Bloodfury harpy"] = "혈폭풍하피 누구에게서나 얻는 {item:277936}",
	-- ["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}: 혈폭풍하피에게서 얻는 {item:277936}",
	-- ["{npc:11860}: Grish is at the {area:1718}, in the next guide"] = "{npc:11860}: 그리쉬는 다음 가이드에서 {area:1718}에 있습니다",
	-- ["{npc:11861}, beside {npc:11862}"] = "{npc:11862} 옆의 {npc:11861}",
	-- ["{npc:11862}, up on the ledge"] = "바위 턱 위의 {npc:11862}",
	-- ["{npc:12696} stands at {area:428}, the Warsong camp just north-east of Splintertree, beside the hunt board."] = "{npc:12696}은(는) 토막나무 주둔지 바로 북동쪽의 전쟁노래부족 야영지인 {area:428}에서 사냥 게시판 옆에 서 있습니다.",
	-- ["{npc:12696}'s hunt targets (Ursangous, Shadumbra, Sharptalon) are for the next {zone:1440} visit, at 27."] = "{npc:12696}의 사냥 대상(우르산고우스, 샤둠브라, 뾰족발톱)은 27레벨에 다음으로 {zone:1440}에 올 때 처리합니다.",
	-- ["{npc:12736} at Zoram'gar, at 27"] = "27레벨에 조람가르의 {npc:12736}",
	-- ["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867}은(는) 벌목기지에 서 있습니다. 나이트 엘프 정찰병은 그 남동쪽 숲에 숨어 있습니다. 은신하므로 주의하세요.",
	-- ["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "{npc:4198}의 다음 퀘스트인 오르다누스는 {zone:1440}의 얼라이언스 지역에 있습니다. 건너뛰세요.",
	-- ["{npc:4198}, outside the gate"] = "정문 밖의 {npc:4198}",
	-- ["{npc:4606} stands in the {object:36070}."] = "{npc:4606}은(는) {object:36070}에 서 있습니다.",
}
