-- Korean (koKR): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 2: Apothecary Zinge
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "",

	-- Step 3: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{object:36126}의 {npc:7825}",

	-- Step 4: Riding at 40
	["Riding at 40"] = "40레벨 탈것 타기",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, 탈것 상급자",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "해골마: {area:159}의 {npc:4773} 옆의 {npc:4731}",

	-- Step 5: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "{object:3202}행 비행선",

	-- Step 6: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "{area:75}(으)로 날아가기",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 7: Stonard
	-- {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["Coming from Stranglethorn, you carry these already. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 8: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "길을 따라 서쪽으로 가세요. 두루마리는 늪 맨 서쪽의 물가에 있습니다.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, later in this guide"] = "이 가이드 후반에 {zone:1445}의 {object:2555}을(를) 위해",

	-- Step 9: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "톱니악어",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "",

	-- Step 10: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "{area:75}을(를) 지나 동쪽으로 돌아가세요. 아탈라이 유물은 {quest:1424}의 물속과 기슭에 있습니다.",

	-- Step 11: Misty Reed Post
	-- {npc:5592} Tok'Kar
	["Follow the road south-east to the small Horde post on the shore. {npc:5592} takes the crocolisk flanks from the last swamp visit."] = "",

	-- Step 12: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "",
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too."] = "",
	["Underwater"] = "",

	-- Step 14: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "안개갈대 멀록",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "늪지멀록은 주둔지 남쪽 해변에 삽니다. 먹물쟁이는 주둔지 동쪽 해안을 따라 있고, 청소부는 더 서쪽, 서쪽 해안의 오두막 주변에 있습니다.",
	["Below ground"] = "",

	-- Step 16: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "",

	-- Step 18: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "48레벨쯤 {zone:1425}의 {npc:5598}에게",

	-- Step 19: To Camp Mojache
	-- {area:1099} Camp Mojache
	["To {area:1099}"] = "",

	-- Step 20: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "48레벨쯤 {zone:1425}의 올빼미야수를 위해",

	-- Step 21: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 22: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "",

	-- Step 23: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "",

	-- Step 24: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "",

	-- Step 25: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "",
	-- {area:511} Wyrmbog
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "",

	-- Step 26: Brackenwall Village
	["Ride back north to Brackenwall."] = "북쪽의 담쟁이 마을로 돌아가세요.",

	-- Step 27: Onyxia's eggs
	["Onyxia's eggs"] = "오닉시아의 알",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "오닉시아의 알은 {area:511} 남동쪽의 용 동굴에 있으며, 맹독전사가 지키고 있습니다. 다섯 개를 깨부수세요.",
	["Dragon caves"] = "용 동굴",

	-- Step 29: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "",

	-- Step 30: Level 45.41
	["Level 45.41"] = "",
	-- {quest:1173} Challenge Overlord Mok'Morokk · {area:978} Zul'Farrak · {area:1517} Uldaman
	["If you skipped {quest:1173}, grind here to level 45.41 to stay on the route's plan. Or, with a group, run the {area:978} dungeon or the {area:1517} dungeon instead."] = "",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "",

	-- Step 31: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "{area:1099}(으)로 날아가기",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "",

	-- Step 32: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "화살요정용과 나무정령",
	-- {item:9589} Encrusted Minerals
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs."] = "화살요정용은 야영지 바로 서쪽 숲 위를 날아다니며 {item:9589}을(를) 지니고 있습니다. 조금 더 서쪽의 떠도는 나무정령은 쪼개진 통나무를 지니고 있습니다.",

	-- Step 33: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "공작날개 히포그리프",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "골짜기 남쪽 비탈에 공작날개 히포그리프가 둥지를 틀고 있습니다. 거의 모두 힘줄과 금속 파편을 떨어뜨립니다.",

	-- Step 34: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "북서쪽의 {area:1108}(으)로 가세요. {npc:14637}이(가) 부두에서 기다립니다.",

	-- Step 35: Rogue Vale screechers
	["Rogue Vale screechers"] = "도적의 골짜기 날카로운비명",
	-- {npc:14637} Zorbin Fandazzle · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "",

	-- Step 36: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "부두 주변 해안에는 바다 정령과 바다 물보라 정령이 밀려다닙니다. 거인에게는 먼저 {item:18904}을(를) 쏘세요. 작아지면 정예의 힘을 잃습니다. 성큼걸이 해안거인은 물속을 걷고, 평지거인과 절벽거인은 더 북쪽 언덕을 돌아다닙니다.",

	-- Step 37: Northspring harpies
	["Northspring harpies"] = "바람계곡일족 하피",
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "바람계곡일족 하피는 맨 북서쪽 능선에 둥지를 틀고 있습니다. 48-50레벨로 나보다 몇 레벨 높습니다. 바람마녀가 치유하니 먼저 처치하고, 한 번에 하나씩 끌어오세요.",

	-- Step 38: Rage Scar yetis
	["Rage Scar yetis"] = "분노한 무쇠설인",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "드물게 떨어지는 {quest:7738}",

	-- Step 39: Camp Mojache
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {object:3202}"] = "{object:3202}(으)로 날아가기",
	-- ["Forest walkers"] = "나무정령",
	-- ["Monstrous Crawlers"] = "괴물게",
	-- ["Murlocs of the Misty Reed"] = "안개갈대 멀록",
	-- ["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "길을 따라 북서쪽으로 가면 언덕의 동굴 주변에 분노한 무쇠설인이 삽니다. 누구나 {quest:7738}도 떨어뜨릴 수 있으며, 이것은 별도의 퀘스트를 시작합니다.",
	-- ["Northspring harpies"] = "바람계곡일족 하피",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "동쪽 야영지로 돌아가세요. 여기 머무르세요. 다음 가이드는 {area:976}행 비행으로 시작합니다.",
	-- ["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "남서쪽의 {object:2555}(으)로 간 뒤, 동쪽으로 {area:511}을(를) 지나가세요. 화염갈기혈족 정찰병과 불꽃술사가 갓 부화한 화염 새끼용, 화염 새끼용과 함께 북쪽 가장자리를 돌아다니고, 맹독전사는 더 남동쪽의 용 동굴을 지킵니다. 모크모로크의 코담배, 그로그주, 금고는 용족 야영지에 있습니다.",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "남서쪽 {area:1105}에 설인이 굴을 파고 삽니다. 그곳의 설인은 모두 두꺼운 가죽을 떨어뜨릴 수 있습니다.",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "늪지멀록은 주둔지 남쪽 해변에 삽니다. 먹물쟁이는 주둔지 동쪽 해안을 따라 있고, 청소부는 더 서쪽, 서쪽 해안의 오두막 주변에 있습니다.",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "괴물게는 동쪽 해안의 해변을 드문드문 돌아다닙니다. 남쪽으로 가는 길에 보이는 대로 모두 처치하세요.",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "바람계곡일족 하피는 맨 북서쪽 능선에 둥지를 틀고 있습니다. 48-50레벨로 나보다 몇 레벨 높습니다. 바람마녀가 치유하니 먼저 처치하고, 한 번에 하나씩 끌어오세요.",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "다시 같은 멀록에, 서쪽 해안의 오두막 근처에 머무는 점쟁이까지 더해집니다.",
	-- ["The small Horde post on the southern shore."] = "남쪽 해안의 작은 호드 주둔지입니다.",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "{zone:1454}행 비행선은 {object:3202} 옆의 탑에서 출발하며, {zone:1454} 정문 바로 북동쪽에 도착합니다.",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "{area:75}에서 시작합니다. 여기에 귀환 지점을 정하세요. 해안 다음에 귀환석으로 돌아옵니다.",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "직업 상급자는 {area:1638}에 있습니다. 그곳으로 날아간 뒤(아직 비행 경로가 없다면 {area:378}(으)로 날아가 {zone:1412}을(를) 지나 서쪽으로 가세요), {area:496}(으)로 날아가세요.",
	-- ["Zeppelin to {zone:1454}"] = "{zone:1454}행 비행선",
	-- ["Zeppelin tower"] = "비행선 탑",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "이 가이드 후반에 {area:15}의 {object:2555}을(를) 위해",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500}은(는) 정예입니다. 파티를 권장합니다. 그가 항복할 때까지 때린 뒤 {npc:4501}에게 보고하세요.",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}: 50레벨쯤 {zone:1454}의 {npc:7010}에게",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, 그다음 {object:172960}와(과) {object:172961}.",
}
