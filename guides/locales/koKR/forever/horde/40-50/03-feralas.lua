-- Korean (koKR): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Stonard
	-- {area:75} Stonard
	["You start in {area:75}. Bind here: you hearth back after the coast."] = "{area:75}에서 시작합니다. 여기에 귀환 지점을 정하세요. 해안 다음에 귀환석으로 돌아옵니다.",

	-- Step 2: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "길을 따라 서쪽으로 가세요. 두루마리는 늪 맨 서쪽의 물가에 있습니다.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, later in this guide"] = "이 가이드 후반에 {zone:1445}의 {object:2555}을(를) 위해",

	-- Step 3: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "{area:75}을(를) 지나 동쪽으로 돌아가세요. 아탈라이 유물은 {quest:1424}의 물속과 기슭에 있습니다.",

	-- Step 4: Monstrous Crawlers
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["Monstrous Crawlers"] = "괴물게",
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "괴물게는 동쪽 해안의 해변을 드문드문 돌아다닙니다. 남쪽으로 가는 길에 보이는 대로 모두 처치하세요.",

	-- Step 5: Misty Reed Post
	["The small Horde post on the southern shore."] = "남쪽 해안의 작은 호드 주둔지입니다.",

	-- Step 6: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "안개갈대 멀록",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "늪지멀록은 주둔지 남쪽 해변에 삽니다. 먹물쟁이는 주둔지 동쪽 해안을 따라 있고, 청소부는 더 서쪽, 서쪽 해안의 오두막 주변에 있습니다.",

	-- Step 8: Continued Threat
	["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "다시 같은 멀록에, 서쪽 해안의 오두막 근처에 머무는 점쟁이까지 더해집니다.",

	-- Step 10: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "48레벨쯤 {zone:1425}의 {npc:5598}에게",

	-- Step 11: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "{object:3202}(으)로 날아가기",

	-- Step 12: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "{zone:1454}행 비행선",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "{zone:1454}행 비행선은 {object:3202} 옆의 탑에서 출발하며, {zone:1454} 정문 바로 북동쪽에 도착합니다.",
	["Zeppelin tower"] = "비행선 탑",

	-- Step 13: Orgrimmar
	-- {object:172958} Valley of Honor · {object:172960} Cleft of Shadow · {object:172961} Valley of Spirits
	["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, 그다음 {object:172960}와(과) {object:172961}.",

	-- Step 14: Thunder Bluff
	-- {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:496} Brackenwall Village
	["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "직업 상급자는 {area:1638}에 있습니다. 그곳으로 날아간 뒤(아직 비행 경로가 없다면 {area:378}(으)로 날아가 {zone:1412}을(를) 지나 서쪽으로 가세요), {area:496}(으)로 날아가세요.",

	-- Step 16: The Wyrmbog
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
	-- {object:2555} Musty Scroll · {area:511} Wyrmbog
	["Ride south-west to the {object:2555}, then east through the {area:511}. The Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "남서쪽의 {object:2555}(으)로 간 뒤, 동쪽으로 {area:511}을(를) 지나가세요. 화염갈기혈족 정찰병과 불꽃술사가 갓 부화한 화염 새끼용, 화염 새끼용과 함께 북쪽 가장자리를 돌아다니고, 맹독전사는 더 남동쪽의 용 동굴을 지킵니다. 모크모로크의 코담배, 그로그주, 금고는 용족 야영지에 있습니다.",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",

	-- Step 17: Brackenwall Village
	["Ride back north to Brackenwall."] = "북쪽의 담쟁이 마을로 돌아가세요.",

	-- Step 18: Onyxia's eggs
	["Onyxia's eggs"] = "오닉시아의 알",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "오닉시아의 알은 {area:511} 남동쪽의 용 동굴에 있으며, 맹독전사가 지키고 있습니다. 다섯 개를 깨부수세요.",
	["Dragon caves"] = "용 동굴",

	-- Step 20: Challenge Overlord Mok'Morokk
	-- {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500}은(는) 정예입니다. 파티를 권장합니다. 그가 항복할 때까지 때린 뒤 {npc:4501}에게 보고하세요.",

	-- Step 21: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "48레벨쯤 {zone:1425}의 올빼미야수를 위해",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}: 50레벨쯤 {zone:1454}의 {npc:7010}에게",

	-- Step 22: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "화살요정용과 나무정령",
	-- {item:9589} Encrusted Minerals
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs."] = "화살요정용은 야영지 바로 서쪽 숲 위를 날아다니며 {item:9589}을(를) 지니고 있습니다. 조금 더 서쪽의 떠도는 나무정령은 쪼개진 통나무를 지니고 있습니다.",
	["Forest walkers"] = "나무정령",

	-- Step 23: Feral Scar Vale
	-- {area:1105} Feral Scar Vale
	["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "남서쪽 {area:1105}에 설인이 굴을 파고 삽니다. 그곳의 설인은 모두 두꺼운 가죽을 떨어뜨릴 수 있습니다.",

	-- Step 24: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "공작날개 히포그리프",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "골짜기 남쪽 비탈에 공작날개 히포그리프가 둥지를 틀고 있습니다. 거의 모두 힘줄과 금속 파편을 떨어뜨립니다.",

	-- Step 25: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "북서쪽의 {area:1108}(으)로 가세요. {npc:14637}이(가) 부두에서 기다립니다.",

	-- Step 26: Forgotten Coast
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "부두 주변 해안에는 바다 정령과 바다 물보라 정령이 밀려다닙니다. 거인에게는 먼저 {item:18904}을(를) 쏘세요. 작아지면 정예의 힘을 잃습니다. 성큼걸이 해안거인은 물속을 걷고, 평지거인과 절벽거인은 더 북쪽 언덕을 돌아다닙니다.",

	-- Step 28: Northspring harpies
	["Northspring harpies"] = "바람계곡일족 하피",
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "바람계곡일족 하피는 맨 북서쪽 능선에 둥지를 틀고 있습니다. 48-50레벨로 나보다 몇 레벨 높습니다. 바람마녀가 치유하니 먼저 처치하고, 한 번에 하나씩 끌어오세요.",

	-- Step 30: Rage Scar yetis
	["Rage Scar yetis"] = "분노한 무쇠설인",
	-- {quest:7738} Perfect Yeti Hide
	["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "길을 따라 북서쪽으로 가면 언덕의 동굴 주변에 분노한 무쇠설인이 삽니다. 누구나 {quest:7738}도 떨어뜨릴 수 있으며, 이것은 별도의 퀘스트를 시작합니다.",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "드물게 떨어지는 {quest:7738}",

	-- Step 31: Camp Mojache
	-- {area:976} Gadgetzan
	["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "동쪽 야영지로 돌아가세요. 여기 머무르세요. 다음 가이드는 {area:976}행 비행으로 시작합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:1108}"] = "{area:1108}",
}
