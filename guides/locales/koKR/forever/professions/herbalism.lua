-- Korean (koKR): the guide forever/professions/herbalism (forever/professions/herbalism.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Herbalism
	-- {skill:182} Herbalism
	["Learn {skill:182}"] = "{skill:182} 배우기",
	-- {zone:2521} Zephras Isle · {item:247841} Wild Harvest
	["No character level needed. On {zone:2521}, {item:247841} from Harvesting Windstones teaches it too."] = "",

	-- Step 2: Turn on Find Herbs · Professions tab (K by default)
	-- {spell:2383} Find Herbs
	["Turn on {spell:2383} · Professions tab (K by default)"] = "",
	["Herbs show on the minimap. Dying turns it off, and only one kind of tracking is on at a time."] = "",

	-- Step 3: Pick Peacebloom and Silverleaf until 15
	-- {item:2447} Peacebloom · {item:765} Silverleaf
	["Pick {item:2447} and {item:765} until 15"] = "",
	["Herbs grow everywhere in the starting areas and come back fast."] = "",

	-- Step 4: Pick Peacebloom, Silverleaf and Earthroot until 50
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot
	["Pick {item:2447}, {item:765} and {item:2449} until 50"] = "",
	["Herbs come back fast here."] = "",

	-- Step 5: Train Journeyman Herbalism
	-- {skill:182} Herbalism
	["Train Journeyman {skill:182}"] = "",
	-- {skill:182} Herbalism
	["Needs {skill:182} skill 50. The trainers in the starting areas teach only up to 75."] = "",

	-- Step 6: Pick Peacebloom, Silverleaf and Earthroot until 70
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot
	["Pick {item:2447}, {item:765} and {item:2449} until 70"] = "",

	-- Step 7: Pick Peacebloom, Silverleaf and Earthroot until 100
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot
	["Pick {item:2447}, {item:765} and {item:2449} until 100"] = "",
	["The areas get busier with herbs as the skill rises."] = "",

	-- Step 8: Pick Peacebloom, Silverleaf, Earthroot, Mageroyal, Briarthorn, Stranglekelp and Bruiseweed until 115
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed
	["Pick {item:2447}, {item:765}, {item:2449}, {item:785}, {item:2450}, {item:3820} and {item:2453} until 115"] = "",
	-- {item:3820} Stranglekelp
	["{item:3820} grows underwater along the shore."] = "",

	-- Step 9: Pick Mageroyal, Briarthorn, Stranglekelp, Bruiseweed and Wild Steelbloom until 125
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed
	["Pick {item:785}, {item:2450}, {item:3820}, {item:2453} and Wild Steelbloom until 125"] = "",

	-- Step 10: Train Expert Herbalism
	-- {skill:182} Herbalism
	["Train Expert {skill:182}"] = "",
	-- {skill:182} Herbalism
	["Needs {skill:182} skill 125; past 150 nothing gives points without it."] = "",

	-- Step 11: Pick Mageroyal, Briarthorn, Stranglekelp, Bruiseweed, Wild Steelbloom and Kingsblood until 150
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed · {item:3356} Kingsblood
	["Pick {item:785}, {item:2450}, {item:3820}, {item:2453}, Wild Steelbloom and {item:3356} until 150"] = "",

	-- Step 12: Pick Briarthorn, Bruiseweed, Wild Steelbloom, Kingsblood and Liferoot until 160
	-- {item:2450} Briarthorn · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3357} Liferoot
	["Pick {item:2450}, {item:2453}, {object:1623}, {item:3356} and {item:3357} until 160"] = "",

	-- Step 13: Pick Briarthorn, Stranglekelp, Bruiseweed, Wild Steelbloom, Kingsblood and Liferoot until 170
	-- {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3357} Liferoot
	["Pick {item:2450}, {item:3820}, {item:2453}, {object:1623}, {item:3356} and {item:3357} until 170"] = "",

	-- Step 14: Pick Stranglekelp, Bruiseweed, Wild Steelbloom, Kingsblood, Liferoot, Fadeleaf and Goldthorn until 185
	-- {item:3820} Stranglekelp · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn
	["Pick {item:3820}, {item:2453}, {object:1623}, {item:3356}, {item:3357}, {item:3818} and {item:3821} until 185"] = "",

	-- Step 15: Pick Bruiseweed, Wild Steelbloom, Kingsblood, Liferoot, Fadeleaf, Goldthorn and Khadgar's Whisker until 200
	-- {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn
	["Pick {item:2453}, {object:1623}, {item:3356}, {item:3357}, {item:3818}, {item:3821} and Khadgar's Whisker until 200"] = "",

	-- Step 16: Train Artisan Herbalism
	-- {skill:182} Herbalism
	["Train Artisan {skill:182}"] = "",
	-- {skill:182} Herbalism · {zone:1446} Tanaris · {zone:1427} Searing Gorge
	["Needs {skill:182} skill 200. {zone:1446} and {zone:1427} have no {skill:182} trainer."] = "",

	-- Step 17: Pick Wild Steelbloom, Kingsblood, Liferoot, Fadeleaf, Goldthorn and Khadgar's Whisker until 210
	-- {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn
	["Pick {object:1623}, {item:3356}, {item:3357}, {item:3818}, {item:3821} and Khadgar's Whisker until 210"] = "",
	-- {zone:1446} Tanaris
	["{zone:1446} comes next, at 210, once the areas there suit your level."] = "",

	-- Step 18: Pick Kingsblood, Liferoot, Fadeleaf, Goldthorn, Khadgar's Whisker and Purple Lotus until 230
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {item:8831} Purple Lotus
	["Pick {item:3356}, {item:3357}, {item:3818}, {item:3821}, Khadgar's Whisker and {item:8831} until 230"] = "",

	-- Step 19: Pick Liferoot, Fadeleaf, Goldthorn, Khadgar's Whisker, Purple Lotus and Sungrass until 260
	-- {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {item:8831} Purple Lotus · {item:8838} Sungrass
	["Pick {item:3357}, {item:3818}, {item:3821}, {object:2043}, {item:8831} and {item:8838} until 260"] = "",
	["Many herbs here grow in caves."] = "",

	-- Step 20: Pick Khadgar's Whisker, Purple Lotus, Sungrass, Golden Sansam, Dreamfoil and Mountain Silversage until 285
	-- {object:2043} Khadgar's Whisker · {item:8831} Purple Lotus · {item:8838} Sungrass · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage
	["Pick {object:2043}, {item:8831}, {item:8838}, {item:13464}, {item:13463} and {item:13465} until 285"] = "",

	-- Step 21: Pick Purple Lotus, Sungrass, Golden Sansam, Dreamfoil, Mountain Silversage and Plaguebloom until 300
	-- {item:8831} Purple Lotus · {item:8838} Sungrass · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage · {item:13466} Plaguebloom
	["Pick {item:8831}, {item:8838}, {item:13464}, {item:13463}, {item:13465} and {item:13466} until 300"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any {skill:182} trainer of your faction teaches Apprentice {skill:182} (character level 5); the arrow picks the nearest."] = "진영의 {skill:182} 상급자 누구에게서나 초급 {skill:182}을(를) 배울 수 있습니다(캐릭터 레벨 5). 화살표가 가장 가까운 상급자를 가리킵니다.",
	-- ["Any {skill:182} trainer of your faction teaches Apprentice {skill:182} at any level (10c), and so does the Junior Herbalism Trainer in each starting area; the arrow picks the nearest. Turn on {spell:2383} (spellbook, General tab) so herbs show on the minimap. Forever's starting areas also have {object:656160} and {object:656161} (skill 1). The first-hour quest of each starting area (Rascally Rodents, Coldridge Valley Mail Delivery, The Woodland Protector, Galgar's {item:11584}, A Humble Task, Marla's Last Wish) offers {item:247841} as a reward: reading it gives 2 skill, up to 15. Trade goods vendors sell the {item:277113}, a four-slot bag for herbs (25c). If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: {skill:182}: hand it in to the herbalism trainer it names once you reach skill 20, for the {spell:1229705} recipe."] = "당신 진영의 어떤 {skill:182} 상급자든 초급 {skill:182}을(를) 어떤 레벨에서나 가르치며(10코퍼), 각 시작 지역의 견습 약초채집 상급자도 가르칩니다. 화살표가 가장 가까운 이를 가리킵니다. {spell:2383}을(를) 켜면(마법책, 일반 탭) 약초가 미니맵에 표시됩니다. Forever의 시작 지역에는 {object:656160}과(와) {object:656161}(숙련도 1)도 있습니다. 각 시작 지역의 첫 한 시간 퀘스트(건방진 설치류, 콜드리지 계곡 우편 배달, 숲의 수호자, 갈가르의 {item:11584}, 겸손한 부탁, 말라의 마지막 소원)가 보상으로 {item:247841}을(를) 주며, 읽으면 숙련도 2가 오르고 15까지 오릅니다. 무역 용품 상인이 약초용 4칸 가방 {item:277113}(25코퍼)을 팝니다. 시작 지역 모닥불에서 위대한 야외를 했다면, 그곳의 야영 가이드도 야영 기초 101: {skill:182}을(를) 줍니다. 숙련도 20에 도달하면 그 가이드가 적어준 약초채집 상급자에게 제출해 {spell:1229705} 제조법을 받으세요.",
	-- ["Artisan {skill:182}"] = "전문 {skill:182}",
	-- ["Artisan {skill:182} raises the cap to 300; it needs skill 200 and no character level, and costs 5g: train it as soon as you reach 200. The arrow picks the nearest {skill:182} trainer of your faction."] = "전문 {skill:182}은(는) 최대 숙련도를 300(으)로 올립니다. 숙련도 200이 필요하고 캐릭터 레벨 제한은 없으며, 5골드가 듭니다. 200이 되면 바로 배우세요. 화살표는 진영의 가장 가까운 {skill:182} 상급자를 가리킵니다.",
	-- ["Expert {skill:182}"] = "숙련 {skill:182}",
	-- ["Expert {skill:182} raises the cap to 225; it needs skill 125 and no character level, and costs 50s: train it as soon as you reach 125. The arrow picks the nearest {skill:182} trainer of your faction."] = "숙련 {skill:182}은(는) 최대 숙련도를 225(으)로 올립니다. 숙련도 125가 필요하고 캐릭터 레벨 제한은 없으며, 50실버가 듭니다. 125가 되면 바로 배우세요. 화살표는 진영의 가장 가까운 {skill:182} 상급자를 가리킵니다.",
	-- ["Journeyman {skill:182}"] = "수습 {skill:182}",
	-- ["Journeyman {skill:182} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:182} trainer of your faction."] = "수습 {skill:182}은(는) 최대 숙련도를 150(으)로 올립니다. 숙련도 50, 캐릭터 레벨 10이(가) 필요합니다. 화살표는 진영의 가장 가까운 {skill:182} 상급자를 가리킵니다.",
	-- ["Journeyman {skill:182} raises the cap to 150; it needs skill 50 and no character level, and costs 5s: train it as soon as you reach 50. The arrow picks the nearest {skill:182} trainer of your faction. {spell:1229705}, Forever's camping item for {skill:182}, is taught from skill 20 (1s, or free from Camping 101: {skill:182}): a {item:2447} and a {item:765} each, it gives points until 25; placed beside a campfire it gives everyone at the camp a buff for an hour."] = "{skill:182} 수습 단계는 150으로 상한을 올립니다. 숙련도 50과 캐릭터 레벨 제한이 없고 5실버입니다. 50에 도달하면 바로 배우세요. 화살표가 당신 진영의 가장 가까운 {skill:182} 상급자를 가리킵니다. {spell:1229705}, Forever의 {skill:182} 야영 아이템은 숙련도 20부터 배웁니다(1실버, 야영 기초 101: {skill:182}에서 무료). {item:2447} 하나와 {item:765} 하나가 들고 25까지 포인트를 주며, 모닥불 옆에 설치하면 한 시간 동안 야영지의 모두에게 강화 효과를 줍니다.",
	-- ["Pick every {item:2447} (1, green), {item:765} (1, green), {item:2449} (15, green), {item:785} (50, green), {item:2450} (70, yellow), {item:3820} (85, orange), {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. Zone level 20-30."] = "지나가는 {item:2447}(1, 초록색), {item:765}(1, 초록색), {item:2449}(15, 초록색), {item:785}(50, 초록색), {item:2450}(70, 노란색), {item:3820}(85, 주황색), {item:2453}(100, 주황색), {object:1623}(115부터)을(를) 모두 채집하고, {skill:182} 125까지 경유지를 도세요. 지역 레벨 20-30.",
	-- ["Pick every {item:2447} (1, orange), {item:765} (1, orange), {item:2449} (from 15) you pass and circle the waypoints until {skill:182} 50. Zone level 1-15. Expect about 60 herbs for these 49 points."] = "지나가는 {item:2447}(1, 주황색), {item:765}(1, 주황색), {item:2449}(15부터)을(를) 모두 채집하고, {skill:182} 50까지 경유지를 도세요. 지역 레벨 1-15. 이번 49점에는 약초 약 60개가 필요합니다.",
	-- ["Pick every {item:2447} (1, orange), {item:765} (1, orange), {object:656161} (1, orange), {object:656160} (1, orange), {item:2449} (from 15) you pass and circle the waypoints until {skill:182} 50. Zone level 1-10. Expect about 60 herbs for these 49 points."] = "지나는 {item:2447} (1, 주황색), {item:765} (1, 주황색), {object:656161} (1, 주황색), {object:656160} (1, 주황색), {item:2449} (15부터)을(를) 모두 채집하고 경유지를 돌아 {skill:182} 50까지 가세요. 지역 레벨 1-10. 이 49포인트에는 약초 약 60개가 필요합니다.",
	-- ["Pick every {item:2447} (1, orange), {item:765} (1, orange), {object:656161} (1, orange, rare), {object:656160} (1, orange), {item:2449} (from 15) you pass and circle the waypoints until {skill:182} 50. Zone level 1-10. Expect about 60 herbs for these 49 points."] = "지나는 {item:2447} (1, 주황색), {item:765} (1, 주황색), {object:656161} (1, 주황색, 희귀), {object:656160} (1, 주황색), {item:2449} (15부터)을(를) 모두 채집하고 경유지를 돌아 {skill:182} 50까지 가세요. 지역 레벨 1-10. 이 49포인트에는 약초 약 60개가 필요합니다.",
	-- ["Pick every {item:2447} (1, orange), {item:765} (1, orange), {object:656161} (1, orange, rare), {object:656160} (1, orange, rare), {item:2449} (from 15) you pass and circle the waypoints until {skill:182} 50. Zone level 1-10. Expect about 60 herbs for these 49 points."] = "지나가는 {item:2447}(1, 주황색), {item:765}(1, 주황색), 왜소한 은엽수잎(1, 주황색, 희귀), 시든 평온초(1, 주황색, 희귀), {item:2449}(15부터)을(를) 모두 채집하고, {skill:182} 50까지 경유지를 도세요. 지역 레벨 1-10. 이 49포인트에 약초 60개쯤 예상하세요.",
	-- ["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70) you pass and circle the waypoints until {skill:182} 100. {item:785} and {item:2450} sometimes give a {item:2452} as well. Zone level 10-20. Expect about 140 herbs for these 50 points."] = "지나가는 {item:2447}(1, 노란색), {item:765}(1, 노란색), {item:2449}(15, 노란색), {item:785}(50, 주황색), {item:2450}(70부터)을(를) 모두 채집하고, {skill:182} 100까지 경유지를 도세요. {item:785}와(과) {item:2450}에서 가끔 {item:2452}도 나옵니다. 지역 레벨 10-20. 이번 50점에는 약초 약 140개가 필요합니다.",
	-- ["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. {item:785} and {item:2450} sometimes give a {item:2452} as well. {item:3820} grows underwater along the shore: watch your breath. A quest here needs {skill:182}: Root Samples (level 16, {npc:3446}). Zone level 10-25. Expect about 110 herbs for these 50 points."] = "지나는 {item:2447} (1, 노란색), {item:765} (1, 노란색), {item:2449} (15, 노란색), {item:785} (50, 주황색), {item:2450} (70부터), {item:3820} (85부터)을(를) 모두 채집하고 경유지를 돌아 {skill:182} 100까지 가세요. {item:785}와(과) {item:2450}에서 {item:2452}가 나올 때도 있습니다. {item:3820}은 해안가 물속에서 자랍니다. 숨에 주의하세요. 여기에는 {skill:182}: 뿌리 표본 퀘스트가 있습니다(16레벨, {npc:3446}). 지역 레벨 10-25. 이 50포인트에는 약초 약 110개가 필요합니다.",
	-- ["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. {item:785} and {item:2450} sometimes give a {item:2452} as well. {item:3820} grows underwater along the shore: watch your breath. Zone level 10-20. Expect about 130 herbs for these 50 points."] = "지나가는 {item:2447}(1, 노란색), {item:765}(1, 노란색), {item:2449}(15, 노란색), {item:785}(50, 주황색), {item:2450}(70부터), {item:3820}(85부터)을(를) 모두 채집하고, {skill:182} 100까지 경유지를 도세요. {item:785}와(과) {item:2450}에서 가끔 {item:2452}도 나옵니다. {item:3820}은(는) 해안을 따라 물속에서 자랍니다. 숨에 주의하세요. 지역 레벨 10-20. 이번 50점에는 약초 약 130개가 필요합니다.",
	-- ["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. {item:785} and {item:2450} sometimes give a {item:2452} as well. {item:3820} grows underwater along the shore: watch your breath. Zone level 10-20. Expect about 140 herbs for these 50 points."] = "지나가는 {item:2447}(1, 노란색), {item:765}(1, 노란색), {item:2449}(15, 노란색), {item:785}(50, 주황색), {item:2450}(70부터), {item:3820}(85부터)을(를) 모두 채집하고, {skill:182} 100까지 경유지를 도세요. {item:785}와(과) {item:2450}에서 가끔 {item:2452}도 나옵니다. {item:3820}은(는) 해안을 따라 물속에서 자랍니다. 숨에 주의하세요. 지역 레벨 10-20. 이번 50점에는 약초 약 140개가 필요합니다.",
	-- ["Pick every {item:2449} (15, green), {item:785} (50, green), {item:2450} (70, yellow), {item:2453} (100, orange) you pass and circle the waypoints until {skill:182} 125. {item:785} and {item:2450} sometimes give a {item:2452} as well. Zone level 15-25. Expect about 60 herbs for these 25 points."] = "지나가는 {item:2449}(15, 초록색), {item:785}(50, 초록색), {item:2450}(70, 노란색), {item:2453}(100, 주황색)을(를) 모두 채집하고, {skill:182} 125까지 경유지를 도세요. {item:785}와(과) {item:2450}에서 가끔 {item:2452}도 나옵니다. 지역 레벨 15-25. 이번 25점에는 약초 약 60개가 필요합니다.",
	-- ["Pick every {item:2450} (70, green, rare), {item:3820} (85, green), {item:2453} (100, green, rare), {object:1623} (115, yellow, rare), {item:3356} (125, yellow), {item:3357} (150, orange), {item:3818} (160, orange), {item:3821} (from 170) you pass and circle the waypoints until {skill:182} 185. {item:785} and {item:2450} sometimes give a {item:2452} as well. {item:3820} grows underwater along the shore: watch your breath. Zone level 35-45. Expect about 40 herbs for these 25 points."] = "지나가는 {item:2450}(70, 초록색, 희귀), {item:3820}(85, 초록색), {item:2453}(100, 초록색, 희귀), {object:1623}(115, 노란색, 희귀), {item:3356}(125, 노란색), {item:3357}(150, 주황색), {item:3818}(160, 주황색), {item:3821}(170부터)을(를) 모두 채집하고, {skill:182} 185까지 경유지를 도세요. {item:785}와(과) {item:2450}에서 가끔 {item:2452}도 나옵니다. {item:3820}은(는) 해안을 따라 물속에서 자랍니다. 숨에 주의하세요. 지역 레벨 35-45. 이번 25점에는 약초 약 40개가 필요합니다.",
	-- ["Pick every {item:2453} (100, green, rare), {object:1623} (115, green, rare), {item:3356} (125, green), {item:3357} (150, yellow), {item:3818} (160, yellow), {item:3821} (170, orange), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 200. Zone level 35-45. Expect about 20 herbs for these 15 points."] = "지나가는 {item:2453}(100, 초록색, 희귀), {object:1623}(115, 초록색, 희귀), {item:3356}(125, 초록색), {item:3357}(150, 노란색), {item:3818}(160, 노란색), {item:3821}(170, 주황색), {object:2043}(185, 주황색)을(를) 모두 채집하고, {skill:182} 200까지 경유지를 도세요. 지역 레벨 35-45. 이번 15점에는 약초 약 20개가 필요합니다.",
	-- ["Pick every {item:3356} (125, green), {item:3357} (150, green), {item:3818} (160, yellow), {item:3821} (170, yellow), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 210. Zone level 35-45. Expect about 20 herbs for these 10 points."] = "지나가며 {item:3356}(125, 초록색), {item:3357}(150, 초록색), {item:3818}(160, 노란색), {item:3821}(170, 노란색), {object:2043}(185, 주황색)을(를) 모두 채집하고 {skill:182}이(가) 210이 될 때까지 경유지를 도십시오. 지역 레벨 35-45. 이 10점에 약초 약 20개가 듭니다.",
	-- ["Pick every {item:3356} (125, green), {item:3357} (150, yellow), {item:3818} (160, yellow), {item:3821} (170, orange), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 200. Zone level 35-45. Expect about 20 herbs for these 15 points."] = "지나가며 {item:3356}(125, 초록색), {item:3357}(150, 노란색), {item:3818}(160, 노란색), {item:3821}(170, 주황색), {object:2043}(185, 주황색)을(를) 모두 채집하고 {skill:182}이(가) 200이 될 때까지 경유지를 도십시오. 지역 레벨 35-45. 이 15점에 약초 약 20개가 듭니다.",
	-- ["Pick every {item:3357} (150, green, rare), {item:3818} (160, green, rare), {item:3821} (170, green), {object:2043} (185, yellow, rare), {item:8831} (210, orange), {item:8838} (230, orange), {item:8845} (from 245) you pass and circle the waypoints until {skill:182} 260. {item:8845} grows in caves and dark hollows: look inside as well. {item:8831} sometimes gives a {item:8153} as well. Zone level 40-50. Expect about 50 herbs for these 30 points."] = "지나는 {item:3357} (150, 초록색, 희귀), {item:3818} (160, 초록색, 희귀), {item:3821} (170, 초록색), {object:2043} (185, 노란색, 희귀), {item:8831} (210, 주황색), {item:8838} (230, 주황색), {item:8845} (245부터)을(를) 모두 채집하고 경유지를 돌아 {skill:182} 260까지 가세요. {item:8845}은(는) 동굴과 어두운 굴속에서 자랍니다. 안쪽도 살펴보세요. {item:8831}에서 {item:8153}이(가) 나올 때도 있습니다. 지역 레벨 40-50. 이 30포인트에는 약초 약 50개가 필요합니다.",
	-- ["Pick every {item:3820} (85, green), {item:3356} (125, yellow), {item:3357} (150, orange), {item:3818} (160, orange), {item:3821} (from 170) you pass and circle the waypoints until {skill:182} 185. {item:3820} grows underwater along the shore: watch your breath. Zone level 35-45. Expect about 40 herbs for these 25 points."] = "지나가는 {item:3820}(85, 초록색), {item:3356}(125, 노란색), {item:3357}(150, 주황색), {item:3818}(160, 주황색), {item:3821}(170부터)을(를) 모두 채집하고, {skill:182} 185까지 경유지를 도세요. {item:3820}은(는) 해안을 따라 물속에서 자랍니다. 숨에 주의하세요. 지역 레벨 35-45. 이번 25점에는 약초 약 40개가 필요합니다.",
	-- ["Pick every {item:3820} (85, yellow), {object:1623} (115, orange), {item:3356} (125, orange), {item:3357} (from 150) you pass and circle the waypoints until {skill:182} 160. {item:3820} grows underwater along the shore: watch your breath. Zone level 30-45. Expect about 70 herbs for these 35 points."] = "지나는 {item:3820} (85, 노란색), {object:1623} (115, 주황색), {item:3356} (125, 주황색), {item:3357} (150부터)을(를) 모두 채집하고 경유지를 돌아 {skill:182} 160까지 가세요. {item:3820}은 해안가 물속에서 자랍니다. 숨에 주의하세요. 지역 레벨 30-45. 이 35포인트에는 약초 약 70개가 필요합니다.",
	-- ["Pick every {item:3821} (170, green), {object:2043} (185, green, rare), {item:8831} (210, green), {item:8838} (230, yellow), {item:8845} (245, orange), {item:13464} (260, orange) you pass and circle the waypoints until {skill:182} 285. {item:8845} grows in caves and dark hollows: look inside as well. {item:8831} sometimes gives a {item:8153} as well. Zone level 40-50. Expect about 70 herbs for these 25 points."] = "지나는 {item:3821} (170, 초록색), {object:2043} (185, 초록색, 희귀), {item:8831} (210, 초록색), {item:8838} (230, 노란색), {item:8845} (245, 주황색), {item:13464} (260, 주황색)을(를) 모두 채집하고 경유지를 돌아 {skill:182} 285까지 가세요. {item:8845}은(는) 동굴과 어두운 굴속에서 자랍니다. 안쪽도 살펴보세요. {item:8831}에서 {item:8153}이(가) 나올 때도 있습니다. 지역 레벨 40-50. 이 25포인트에는 약초 약 70개가 필요합니다.",
	-- ["Pick every {item:4625} (205, yellow), {item:8838} (230, orange), {item:8846} (from 250) you pass and circle the waypoints until {skill:182} 260. Zone level 45-55."] = "지나가는 {item:4625}(205, 노란색), {item:8838}(230, 주황색), {item:8846}(250부터)을(를) 모두 채집하고, {skill:182} 260까지 경유지를 도세요. 지역 레벨 45-55.",
	-- ["Pick every {item:765} (1, green, rare), {item:2449} (15, green, rare), {item:785} (50, green), {item:2450} (70, yellow), {item:3820} (85, orange), {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. {item:785} and {item:2450} sometimes give a {item:2452} as well. {item:3820} grows underwater along the shore: watch your breath. Zone level 20-30. Expect about 40 herbs for these 25 points."] = "지나는 {item:765} (1, 초록색, 희귀), {item:2449} (15, 초록색, 희귀), {item:785} (50, 초록색), {item:2450} (70, 노란색), {item:3820} (85, 주황색), {item:2453} (100, 주황색), {object:1623} (115부터)을(를) 모두 채집하고 경유지를 돌아 {skill:182} 125까지 가세요. {item:785}와(과) {item:2450}에서 {item:2452}가 나올 때도 있습니다. {item:3820}은 해안가 물속에서 자랍니다. 숨에 주의하세요. 지역 레벨 20-30. 이 25포인트에는 약초 약 40개가 필요합니다.",
	-- ["Pick every {item:785} (50, green), {item:2450} (70, green), {item:2453} (100, yellow), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange) you pass and circle the waypoints until {skill:182} 160. Zone level 18-30."] = "지나가는 {item:785}(50, 초록색), {item:2450}(70, 초록색), {item:2453}(100, 노란색), {object:1623}(115, 주황색), {object:1628}(120, 주황색), {item:3356}(125, 주황색)을(를) 모두 채집하고, {skill:182} 160까지 경유지를 도세요. 지역 레벨 18-30.",
	-- ["Pick every {item:785} (50, green), {item:2450} (70, green), {item:3820} (85, yellow), {item:2453} (100, yellow), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange), {item:3357} (from 150) you pass and circle the waypoints until {skill:182} 160. Zone level 30-40."] = "지나가는 {item:785}(50, 초록색), {item:2450}(70, 초록색), {item:3820}(85, 노란색), {item:2453}(100, 노란색), {object:1623}(115, 주황색), {object:1628}(120, 주황색), {item:3356}(125, 주황색), {item:3357}(150부터)을(를) 모두 채집하고, {skill:182} 160까지 경유지를 도세요. 지역 레벨 30-40.",
	-- ["Pick every {item:785} (50, green), {item:2450} (70, yellow), {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. {item:785} and {item:2450} sometimes give a {item:2452} as well. Zone level 15-27. Expect about 40 herbs for these 25 points."] = "지나가는 {item:785}(50, 초록색), {item:2450}(70, 노란색), {item:2453}(100, 주황색), {object:1623}(115부터)을(를) 모두 채집하고, {skill:182} 125까지 경유지를 도세요. {item:785}와(과) {item:2450}에서 가끔 {item:2452}도 나옵니다. 지역 레벨 15-27. 이번 25점에는 약초 약 40개가 필요합니다.",
	-- ["Pick every {item:8836} (220, green), {item:8838} (230, green), {item:13463} (270, orange), {item:13465} (280, orange), {item:13466} (285, orange) you pass and circle the waypoints until {skill:182} 300. Zone level 51-58. Expect about 20 herbs for these 15 points."] = "지나는 {item:8836} (220, 초록색), {item:8838} (230, 초록색), {item:13463} (270, 주황색), {item:13465} (280, 주황색), {item:13466} (285, 주황색)을(를) 모두 채집하고 경유지를 돌아 {skill:182} 300까지 가세요. 지역 레벨 51-58. 이 15포인트에는 약초 약 20개가 필요합니다.",
	-- ["Pick every {item:8836} (220, green), {item:8838} (230, green), {item:8846} (250, yellow), {item:13464} (260, yellow), {item:13463} (270, orange), {item:13465} (280, orange), {item:13466} (285, orange) you pass and circle the waypoints until {skill:182} 300. Zone level 48-55."] = "지나가는 {item:8836}(220, 초록색), {item:8838}(230, 초록색), {item:8846}(250, 노란색), {item:13464}(260, 노란색), {item:13463}(270, 주황색), {item:13465}(280, 주황색), {item:13466}(285, 주황색)을(를) 모두 채집하고, {skill:182} 300까지 경유지를 도세요. 지역 레벨 48-55.",
	-- ["Pick every {item:8836} (220, green), {item:8838} (230, green), {item:8846} (250, yellow), {item:13464} (260, yellow), {item:13463} (270, orange), {item:13465} (280, orange), {item:13466} (285, orange) you pass and circle the waypoints until {skill:182} 300. {item:8846} grows near demon and satyr camps: pull carefully. Quests here that need {skill:182}: Salve via Gathering (level 55, {npc:9528}; Alliance), Salve via Gathering (level 55, {npc:9529}; Horde). Zone level 48-55. Expect about 20 herbs for these 15 points."] = "지나가며 {item:8836}(220, 초록색), {item:8838}(230, 초록색), {item:8846}(250, 노란색), {item:13464}(260, 노란색), {item:13463}(270, 주황색), {item:13465}(280, 주황색), {item:13466}(285, 주황색)을(를) 모두 채집하고 {skill:182}이(가) 300이 될 때까지 경유지를 도십시오. {item:8846}은(는) 악마와 사티로스 야영지 근처에서 자랍니다: 조심해서 끌어내십시오. 이곳에서 {skill:182}이(가) 필요한 퀘스트: 채집한 약초로 만드는 연고(55레벨, {npc:9528}; 얼라이언스), 채집한 약초로 만드는 연고(55레벨, {npc:9529}; 호드). 지역 레벨 48-55. 이 15점에 약초 약 20개가 듭니다.",
	-- ["Pick every {item:8836} (220, yellow), {item:8838} (230, yellow), {item:8846} (250, orange), {item:13464} (260, orange), {item:13463} (from 270), {item:13465} (from 280) you pass and circle the waypoints until {skill:182} 285. Zone level 48-55."] = "지나가는 {item:8836}(220, 노란색), {item:8838}(230, 노란색), {item:8846}(250, 주황색), {item:13464}(260, 주황색), {item:13463}(270부터), {item:13465}(280부터)을(를) 모두 채집하고, {skill:182} 285까지 경유지를 도세요. 지역 레벨 48-55.",
	-- ["Pick every {object:1623} (115, green, rare), {item:3356} (125, green), {item:3357} (150, green), {item:3818} (160, yellow), {item:3821} (170, yellow), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 210. Zone level 35-45. Expect about 20 herbs for these 10 points."] = "지나가는 {object:1623}(115, 초록색, 희귀), {item:3356}(125, 초록색), {item:3357}(150, 초록색), {item:3818}(160, 노란색), {item:3821}(170, 노란색), {object:2043}(185, 주황색)을(를) 모두 채집하고, {skill:182} 210까지 경유지를 도세요. 지역 레벨 35-45. 이번 10점에는 약초 약 20개가 필요합니다.",
	-- ["Pick every {object:1623} (115, green, rare), {item:3357} (150, green), {item:3818} (160, green, rare), {item:3821} (170, yellow), {object:2043} (185, yellow), {item:8831} (210, orange) you pass and circle the waypoints until {skill:182} 230. {item:8831} sometimes gives a {item:8153} as well. Zone level 40-50. Expect about 30 herbs for these 20 points."] = "지나가는 {object:1623}(115, 초록색, 희귀), {item:3357}(150, 초록색), {item:3818}(160, 초록색, 희귀), {item:3821}(170, 노란색), {object:2043}(185, 노란색), {item:8831}(210, 주황색)을(를) 모두 채집하고, {skill:182} 230까지 경유지를 도세요. {item:8831}에서 가끔 {item:8153}도 나옵니다. 지역 레벨 40-50. 이번 20점에는 약초 약 30개가 필요합니다.",
	-- ["Pick every {object:1623} (115, green, rare), {item:3357} (150, green), {item:3821} (170, yellow), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 210. Zone level 40-50. Expect about 20 herbs for these 10 points."] = "지나가는 {object:1623}(115, 초록색, 희귀), {item:3357}(150, 초록색), {item:3821}(170, 노란색), {object:2043}(185, 주황색)을(를) 모두 채집하고, {skill:182} 210까지 경유지를 도세요. 지역 레벨 40-50. 이번 10점에는 약초 약 20개가 필요합니다.",
	-- ["Pick every {object:1623} (115, green, rare), {item:3357} (150, yellow), {item:3821} (170, orange), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 200. Zone level 40-50. Expect about 20 herbs for these 15 points."] = "지나가는 {object:1623}(115, 초록색, 희귀), {item:3357}(150, 노란색), {item:3821}(170, 주황색), {object:2043}(185, 주황색)을(를) 모두 채집하고, {skill:182} 200까지 경유지를 도세요. 지역 레벨 40-50. 이번 15점에는 약초 약 20개가 필요합니다.",
	-- ["{item:3818} & {object:2043}: {zone:1445} (200-210) cont."] = "{item:3818} & {object:2043}: {zone:1445} (200-210) (계속)",
	-- ["{item:3821} & {object:2043}: {zone:1435} (200-210) cont."] = "{item:3821} & {object:2043}: {zone:1435} (200-210) 계속",
	-- ["{item:3821} & {object:2043}: {zone:1444} (200-210) cont."] = "{item:3821} & {object:2043}: {zone:1444} (200-210) (계속)",
}
