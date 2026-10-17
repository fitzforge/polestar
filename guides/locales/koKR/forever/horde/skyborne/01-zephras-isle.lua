-- Korean (koKR): the guide forever/horde/skyborne/01-zephras-isle (forever/horde/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Village
	-- {area:16635} Thendal Village · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker
	["You wake in {area:16635}, in the north of the isle. {npc:251362} stands by the path, {npc:251361} at the village centre."] = "섬 북쪽의 {area:16635}에서 깨어납니다. {npc:251362}은(는) 길가에, {npc:251361}은(는) 마을 한가운데에 있습니다.",

	-- Step 2: Thendal Grove
	-- {npc:250873} Juvenile Vuldren
	["Pesky Cirrusflies and {npc:250873} roam the grove just south-east of the village."] = "성가신 구름벌레와 {npc:250873}이(가) 마을 바로 남동쪽 숲을 돌아다닙니다.",

	-- Step 3: Back to Thendal Village
	-- {area:16635} Thendal Village
	["Back to {area:16635}"] = "{area:16635}(으)로 돌아가기",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}: {item:4100}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}: 상급자가 보낸 쪽지",
	-- {npc:251361} Rorian the Dayseeker · {item:282418} Humming Recall Crystal
	["{npc:251361}: examine the {item:282418}"] = "{npc:251361}: {item:282418}을(를) 살펴보세요",
	-- {npc:257554} Halaan Hawk-Eye
	["talk to {npc:257554}"] = "{npc:257554}와(과) 대화하세요",

	-- Step 4: The watchtower
	["The watchtower"] = "감시탑",
	-- {spell:1259416} Walk on Air
	["Climb the watchtower in the village, jump off the top and use {spell:1259416} to float down."] = "마을의 감시탑에 올라 꼭대기에서 뛰어내린 뒤 {spell:1259416}(으)로 천천히 내려오세요.",

	-- Step 5: Rorian the Dayseeker's errands
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}'s errands"] = "{npc:251361}의 심부름",

	-- Step 6: Raw Windstones
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones"] = "{object:613286}",
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones are blue crystals on the slopes around the village."] = "{object:613286}은(는) 마을 주변 비탈에 있는 파란 수정입니다.",

	-- Step 8: The standing stones
	["The standing stones"] = "선돌",
	-- {npc:249363} Yala Windwatcher · {area:17678} Thendal Standing Stones · {npc:251143} Roiling Winds · {object:460001} Elemental Convergence (no name in this language: may be words) · {spell:1259686} Skysight
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} stands at the {area:17678}, east of the village. {npc:251143} and Al'Aketh Converts gather just north of her. The {object:460001} is just north-east of her: cast your {spell:1259686} racial ability next to it."] = "{npc:249363}은(는) 마을 동쪽 {area:17678}에 있습니다. {npc:251143}와(과) 알아케스 전향자가 그녀 바로 북쪽에 모여 있습니다. {object:460001}은(는) 그녀 바로 북동쪽에 있으니, 그 옆에서 종족 특성 {spell:1259686}을(를) 시전하세요.",
	-- {spell:1259686} Skysight · {object:460001} Elemental Convergence (no name in this language: may be words)
	["Cast {spell:1259686} near the {object:460001}"] = "{object:460001} 근처에서 {spell:1259686}을(를) 시전하세요",

	-- Step 9: The Cirrusfly Queen
	["The queen hovers at the south-east end of the grove, on your way back from the stones."] = "구름벌레 여왕은 선돌에서 돌아오는 길, 숲 남동쪽 끝에 떠 있습니다.",

	-- Step 10: Thendal Village turn-ins
	-- {area:16635} Thendal Village
	["{area:16635} turn-ins"] = "{area:16635} 퀘스트 완료",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}: {item:9547}을(를) 읽으세요",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "감시탑 안의 {npc:251389}",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "감시탑 안의 {npc:251964}",
	-- {npc:251374} Windshaper Boro
	["{npc:251374}, at the village centre"] = "마을 한가운데의 {npc:251374}",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "드루이드 상급자 {npc:251373}: {npc:251361} 뒤편 나무의 1층",

	-- Step 11: Windshaper Boro
	-- {npc:251374} Windshaper Boro
	["{npc:251374} stands in the village."] = "{npc:251374}은(는) 마을에 있습니다.",

	-- Step 12: Scrawny Ursera
	-- {npc:250926} Scrawny Ursera · {npc:252095} Hanaa Nightwind
	["{npc:250926} prowl the slopes south-west of the village, on the way to {npc:252095}."] = "{npc:250926}은(는) {npc:252095}에게 가는 길, 마을 남서쪽 비탈을 배회합니다.",

	-- Step 13: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {area:16622} Thendal Grove · {npc:256935} Malduko Cloudcrush
	["{npc:252095} waits in {area:16622}, south-west of the village. The Al'Aketh camp is just beyond her; {npc:256935} leads it."] = "{npc:252095}은(는) 마을 남서쪽 {area:16622}에서 기다립니다. 알아케스 야영지는 그 바로 너머에 있으며, {npc:256935}이(가) 이끕니다.",

	-- Step 14: Signet of Akir
	-- {npc:252095} Hanaa Nightwind
	["The Al'Aketh cultists in the camp beyond {npc:252095} carry the signet."] = "{npc:252095} 너머 야영지의 알아케스 신도들이 아키르의 인장을 지니고 있습니다.",

	-- Step 15: Urs'anah
	-- {npc:251115} Urs'anah
	["The Ursera den is west of the village. {npc:251115}, their matriarch, sits at its far end."] = "우르세라 굴은 마을 서쪽에 있습니다. 우르세라의 어미 {npc:251115}은(는) 굴 맨 안쪽에 있습니다.",

	-- Step 16: Leaving Thendal Village
	-- {area:16635} Thendal Village
	["Leaving {area:16635}"] = "{area:16635} 떠나기",

	-- Step 17: Call of Earth
	-- {npc:251374} Windshaper Boro · {area:16988} Rise of Spirits · {item:6635} Earth Sapta · {npc:251166} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:251374} sends you to the {area:16988}, just east of the village: drink the {item:6635} there to see the {npc:251166}, then take the {item:6656} back to him."] = "{npc:251374}이(가) 마을 바로 동쪽 {area:16988}(으)로 보냅니다. 그곳에서 {item:6635}을(를) 마셔 {npc:251166}을(를) 보고, {item:6656}을(를) 그에게 가져가세요.",
	-- {npc:251374} Windshaper Boro · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:251374}: {npc:5873} and your {item:5175}"] = "{npc:251374}: {npc:5873}와(과) {item:5175}",

	-- Step 18: Shen'dar Village
	-- {area:16624} Shen'dar Village
	["Follow the road south to {area:16624}, in the middle of the isle."] = "길을 따라 남쪽으로 섬 한가운데의 {area:16624}에 가세요.",
	-- {npc:251902} Illaya Amberwind
	["talk to {npc:251902}"] = "{npc:251902}와(과) 대화하세요",

	-- Step 19: Raan Wildwind's campfire
	-- {npc:263664} Raan Wildwind
	["{npc:263664}'s campfire"] = "{npc:263664}의 모닥불",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest · {npc:251905} Zerril Softbreeze
	["Sit by {npc:263664}'s campfire (type /sit) until you get the {spell:1229451} buff, then find {npc:251905} at the cook fire."] = "{spell:1229451} 효과를 얻을 때까지 {npc:263664}의 모닥불 옆에 앉은 뒤(/앉기 입력), 요리용 불가의 {npc:251905}을(를) 찾으세요.",
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "{spell:1229451}을(를) 얻을 때까지 {npc:263664}의 모닥불 옆에서 /앉기 하세요",
	-- {npc:251905} Zerril Softbreeze
	["talk to {npc:251905}"] = "{npc:251905}와(과) 대화하세요",

	-- Step 20: Welcome to Shen'dar Village
	-- {npc:251902} Illaya Amberwind
	["Talk to {npc:251902}"] = "{npc:251902}와(과) 대화하세요",
	-- {npc:254089} Coriella Calmbreeze
	["Talk to {npc:254089}"] = "{npc:254089}와(과) 대화하세요",
	["the bounty board"] = "현상수배 게시판",

	-- Step 21: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "무리발톱과 돌풍타조",
	-- {item:5469} Strider Meat · {npc:251905} Zerril Softbreeze
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders share the meadows south of the village. Keep the {item:5469} for {npc:251905}; the eggs come later from the hippogryphs."] = "무리발톱과 돌풍타조가 마을 남쪽 초원에 함께 있습니다. {item:5469}은(는) {npc:251905}에게 줄 것이니 챙겨 두세요. 알은 나중에 히포그리프에게서 얻습니다.",

	-- Step 22: High Order Apprentices
	-- plural, as words: High Order Apprentices = {npc:257521} High Order Apprentice
	["High Order Apprentices"] = "{npc:257521}",
	["The apprentices practise north-east of the village."] = "수습생들은 마을 북동쪽에서 수련합니다.",

	-- Step 23: The highland bandits
	["The highland bandits"] = "고원 좀도둑",
	["The bandit camps are north-east of the village; \"Badwind\" Bennic holds the top camp. Bandits carry the stolen windstones."] = "좀도둑 야영지는 마을 북동쪽에 있으며, \"사악한 바람\" 베닉이 가장 위쪽 야영지를 차지하고 있습니다. 좀도둑들이 훔친 바람석을 지니고 있습니다.",

	-- Step 24: Shen'dar Village turn-ins
	-- {area:16624} Shen'dar Village
	["{area:16624} turn-ins"] = "{area:16624} 퀘스트 완료",

	-- Step 25: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["{npc:254589} lurks south of the village, among the Prideclaws. {npc:254589} is elite: grouping up is advised."] = "{npc:254589}은(는) 마을 남쪽 무리발톱 사이에 숨어 있습니다. {npc:254589}은(는) 정예이니 파티를 권장합니다.",

	-- Step 26: Falaath Village
	-- {quest:92529} Falaath Village · {npc:257065} Missionary Jasaan
	["{quest:92529} lies south of Shen'dar. {npc:257065} meets you at its edge; search the wardrobe in the house behind him."] = "{quest:92529}은(는) 셴다르 마을 남쪽에 있습니다. 마을 가장자리에서 {npc:257065}을(를) 만나고, 그 뒤편 집의 옷장을 뒤지세요.",
	["search the wardrobe"] = "옷장을 뒤지세요",

	-- Step 27: Constable Aonda
	-- {area:16624} Shen'dar Village
	["Back to {area:16624} with what you found."] = "찾은 것을 가지고 {area:16624}(으)로 돌아가세요.",

	-- Step 28: Havoc in the Highlands
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	-- plural, as words: Supply Caches = {object:576179} Supply Cache
	["Back at {quest:92529}: Stormcallers and {npc:251662} fill the village, the Supply Caches stand among the houses and {npc:251966} waits at its south-east end."] = "다시 {quest:92529}: 알아케스 폭풍소환사와 {npc:251662}이(가) 마을을 메우고 있고, {object:576179}은(는) 집들 사이에 있으며, {npc:251966}은(는) 남동쪽 끝에서 기다립니다.",

	-- Step 29: The West Pylon Watchtower
	-- {area:17674} West Pylon Watchtower
	["The {area:17674}"] = "{area:17674}",
	-- {area:17674} West Pylon Watchtower · {npc:252155} Peacekeeper Vaaniel · {item:254871} Bloody Note
	["Head south-west to the {area:17674}. {npc:252155} is at the top; the {item:254871} lies beside him."] = "남서쪽 {area:17674}(으)로 가세요. {npc:252155}은(는) 꼭대기에 있고, {item:254871}은(는) 그 옆에 있습니다.",
	-- {npc:252155} Peacekeeper Vaaniel
	["talk to {npc:252155}"] = "{npc:252155}와(과) 대화하세요",

	-- Step 30: Skypriest Aanders
	["Aanders and the fallen guards are just south-west of the tower. Take Raani's feather and the Shadowsong signet from the bodies."] = "하늘사제 앤더스와 쓰러진 경비병들은 탑 바로 남서쪽에 있습니다. 시신에서 라니의 행운의 깃털과 섀도송 가문 인장을 챙기세요.",

	-- Step 31: Hippogryph nests
	["Hippogryph nests"] = "히포그리프 둥지",
	-- {quest:92529} Falaath Village · {item:263493} Hippogryph Down
	-- plural, as words: Small Eggs = {item:6889} Small Egg
	["The hippogryph nests are north-west of the tower, west of {quest:92529}; the Matriarch sits at the western end. {item:263493} lies on the ground around them, and the hippogryphs drop the Small Eggs."] = "히포그리프 둥지는 탑 북서쪽, {quest:92529} 서쪽에 있으며, 히포그리프 어미는 서쪽 끝에 있습니다. {item:263493}은(는) 둥지 주변 땅에 있고, 히포그리프가 {item:6889}을(를) 떨어뜨립니다.",

	-- Step 32: Shen'dar Village, last time
	-- {area:16624} Shen'dar Village
	["{area:16624}, last time"] = "마지막으로 {area:16624}",
	-- {area:16624} Shen'dar Village · {item:5469} Strider Meat
	["Walk north to {area:16624}; finish the {item:5469} on the Galestriders along the way if you are short."] = "북쪽 {area:16624}(으)로 가세요. {item:5469}이(가) 모자라면 가는 길에 돌풍타조를 잡아 채우세요.",

	-- Step 33: To Valanaar
	-- {area:16638} Valanaar · {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield
	["Take the road south-east to {area:16638}, the Skyborne town on the south coast. {npc:257006} and {npc:252448} stand at its western edge."] = "남동쪽 길을 따라 남쪽 해안의 스카이본 마을 {area:16638}(으)로 가세요. {npc:257006}와(과) {npc:252448}이(가) 마을 서쪽 끝에 있습니다.",
	-- {npc:252448} Alvarion Windfield
	["Listen to {npc:252448}'s story"] = "{npc:252448}의 이야기를 들으세요",

	-- Step 34: Windsong Crawlers
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers"] = "{npc:254588}",
	["The crawlers scuttle along the shore south-west of town."] = "게들은 마을 남서쪽 해안을 따라 종종걸음 칩니다.",

	-- Step 36: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "하늘폴짝이",
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers hop about the fields just west of Valennia."] = "하늘폴짝이는 발레니아 바로 서쪽 들판을 뛰어다닙니다.",

	-- Step 37: Ayessa Dawnsinger
	-- {npc:251968} Ayessa Dawnsinger
	["talk to {npc:251968}"] = "{npc:251968}와(과) 대화하세요",

	-- Step 38: Riaani Nightwind
	-- {npc:256083} Riaani Nightwind · {area:16626} Gustberry Lowlands
	["{npc:256083} stands in the {area:16626} just north-west of town."] = "{npc:256083}은(는) 마을 바로 북서쪽 {area:16626}에 있습니다.",
	-- {npc:256083} Riaani Nightwind
	["Listen to {npc:256083}"] = "{npc:256083}의 이야기를 들으세요",

	-- Step 39: Wind Hollows and Construct Parts
	-- {object:616467} Construct Parts
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows and {object:616467}"] = "바람의 유령과 {object:616467}",
	-- {area:16638} Valanaar · {object:616467} Construct Parts
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616467} lie west of the orchard road."] = "바람의 유령은 {area:16638} 주변 저지대를 떠다닙니다. 첫 {object:616467}은(는) 과수원 길 서쪽에 있습니다.",

	-- Step 41: Windfield Orchard
	-- {area:16663} Windfield Orchard · {area:16638} Valanaar
	["{area:16663} is west of {area:16638} along the coast road."] = "{area:16663}은(는) 해안 길을 따라 {area:16638} 서쪽에 있습니다.",
	-- {npc:252800} Aamelia Windfield
	["Talk to {npc:252800}"] = "{npc:252800}와(과) 대화하세요",

	-- Step 42: The orchard
	["The orchard"] = "과수원",
	-- plural, as words: Hungry Bandits = {npc:252802} Hungry Bandit
	["Stormapples and flutterfly dust lie all over the orchard; Hungry Bandits raid it. Galestriders graze in the fields east of it. The broken construct floats at the orchard's north edge."] = "잘 익은 폭풍사과와 펄럭날개 가루가 과수원 곳곳에 있고, 굶주린 좀도둑이 과수원을 습격합니다. 돌풍타조는 과수원 동쪽 들판에서 풀을 뜯습니다. 부서진 피조물은 과수원 북쪽 끝에 떠 있습니다.",

	-- Step 44: Bandit Highwaymen
	["Bandit Highwaymen"] = "산적 노상강도",
	-- {object:616468} Construct Parts · {area:16638} Valanaar
	["The highwaymen hold the hills north-east of the orchard. More {object:616468} lie near the road to {area:16638}."] = "노상강도는 과수원 북동쪽 언덕을 차지하고 있습니다. {area:16638}(으)로 가는 길 근처에 {object:616468}이(가) 더 있습니다.",

	-- Step 45: Standing Our Ground
	-- {npc:252800} Aamelia Windfield
	["Tell {npc:252800} you're ready"] = "{npc:252800}에게 준비되었다고 말하세요",

	-- Step 46: Alvarion Windfield and Riaani Nightwind
	-- {npc:252448} Alvarion Windfield · {npc:256083} Riaani Nightwind
	["{npc:252448} and {npc:256083}"] = "{npc:252448}와(과) {npc:256083}",

	-- Step 47: Taming the Beast
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {item:15908} Taming Rod · {npc:254588} Windsong Crawler · {npc:251707} Ornery Galestrider · {npc:250874} Vuldren Alpha · {area:16663} Windfield Orchard · {npc:254411} Quel'dora Quickgale
	["{npc:252389} in {area:16638} hands you a {item:15908} three times: tame a {npc:254588} by the lakes north-west of town, an {npc:251707} in the fields west of town and a {npc:250874} at {area:16663}, returning to her after each. {npc:254411} stands beside her."] = "{area:16638}의 {npc:252389}이(가) {item:15908}을(를) 세 번 줍니다. 마을 북서쪽 호숫가의 {npc:254588}, 마을 서쪽 들판의 {npc:251707}, {area:16663}의 {npc:250874}을(를) 길들이고, 매번 그녀에게 돌아가세요. {npc:254411}은(는) 그녀 옆에 있습니다.",

	-- Step 48: Belathaan Brightwish
	-- {npc:256247} Belathaan Brightwish · {area:16638} Valanaar · {area:16629} Shrine of Akir
	["{npc:256247} waits on the road north of {area:16638}, towards the {area:16629}."] = "{npc:256247}은(는) {area:16629}(으)로 가는 {area:16638} 북쪽 길에서 기다립니다.",

	-- Step 50: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands on {area:16638}'s east side."] = "{npc:252359}은(는) {area:16638} 동쪽에 있습니다.",

	-- Step 51: The East Pylon Watchtower
	-- {area:17675} East Pylon Watchtower
	["The {area:17675}"] = "{area:17675}",
	-- {area:17675} East Pylon Watchtower · {npc:252666} Commander Belguilos
	["Ride north-east to the {area:17675}. The Al'Aketh camp is just west of it, with {npc:252666} at its north end. Every cultist can drop a windstone charm."] = "북동쪽 {area:17675}(으)로 가세요. 알아케스 야영지는 그 바로 서쪽에 있으며, {npc:252666}은(는) 야영지 북쪽 끝에 있습니다. 신도는 모두 알아케스 바람석 부적을 떨어뜨릴 수 있습니다.",

	-- Step 52: Urs'endris
	-- {npc:255853} Urs'endris
	["{npc:255853} waits by the falls just north of the watchtower."] = "{npc:255853}은(는) 감시탑 바로 북쪽 폭포 옆에서 기다립니다.",

	-- Step 53: Back to Valanaar
	-- {area:16638} Valanaar
	["Back to {area:16638}"] = "{area:16638}(으)로 돌아가기",

	-- Step 54: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} stands in the middle of {area:16638}."] = "{npc:252377}은(는) {area:16638} 한가운데에 있습니다.",

	-- Step 55: Sessaria Skystride
	-- {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["{npc:252382} stands on {area:16638}'s west side."] = "{npc:252382}은(는) {area:16638} 서쪽에 있습니다.",

	-- Step 56: The turncoat
	["The turncoat"] = "배신자",
	-- {area:16626} Gustberry Lowlands · {area:16638} Valanaar · {npc:273017} Fendaal Windstone
	["The turncoat's house is in the {area:16626} north-west of {area:16638}. {npc:273017} waits nearby; his assassins lurk around the house."] = "배신자의 집은 {area:16638} 북서쪽 {area:16626}에 있습니다. {npc:273017}이(가) 근처에서 기다리고, 그의 암살자들이 집 주변에 숨어 있습니다.",
	["search the dead cultist in the house"] = "집 안의 죽은 신도를 뒤지세요",

	-- Step 57: Ur'endra
	-- {npc:258443} Ur'endra
	["{npc:258443} roams the slopes just south of the turncoat's house."] = "{npc:258443}은(는) 배신자의 집 바로 남쪽 비탈을 배회합니다.",

	-- Step 58: Olariaan Swiftburn
	-- {npc:268592} Olariaan Swiftburn · {area:16638} Valanaar · {area:16626} Gustberry Lowlands
	["Take the Torch of Dormant Flame to {npc:268592} at the Shrine of Flames, south-west of {area:16638} in the {area:16626}."] = "희미한 불씨의 횃불을 {area:16638} 남서쪽 {area:16626}에 있는 불꽃의 제단의 {npc:268592}에게 가져가세요.",

	-- Step 59: Skypriest Faladiel
	-- {area:16638} Valanaar
	["Faladiel stands on the hill west of the falls, north of {area:16638}."] = "하늘사제 팔라디엘은 {area:16638} 북쪽, 폭포 서쪽 언덕에 있습니다.",

	-- Step 60: Kuramaa
	-- {npc:268592} Olariaan Swiftburn · {area:16623} Shen'dar Highlands · {npc:268605} Kuramaa
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Back to {npc:268592}, then west into the {area:16623}: {npc:268605}'s home is in the hills south of the Windsong Crawlers' lakes."] = "{npc:268592}에게 돌아간 뒤 서쪽 {area:16623}(으)로 가세요. {npc:268605}의 집은 바람노래 집게발 호수 남쪽 언덕에 있습니다.",

	-- Step 61: The Eternal Flame
	-- {object:148418} Eternal Flame
	["The {object:148418}"] = "{object:148418}",
	-- {npc:268592} Olariaan Swiftburn · {npc:268762} Brazier of Offering · {npc:268679} Brazier of Eternal Flame · {npc:252382} Sessaria Skystride · {area:16638} Valanaar
	["Back to {npc:268592}. Wait for him to light the {npc:268762}, then carry the flame straight to the {npc:268679} beside {npc:252382} in {area:16638} before the timer runs out."] = "{npc:268592}에게 돌아가세요. 그가 {npc:268762}에 불을 붙이면, 시간이 끝나기 전에 불꽃을 곧장 {area:16638}의 {npc:252382} 옆 {npc:268679}(으)로 가져가세요.",
	-- {npc:252382} Sessaria Skystride · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:252382}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:252382}: {npc:2523}, {item:5176}, {item:263412}",

	-- Step 62: Unfortunate News
	-- {npc:252476} Talaanis Shadowsong
	["talk to {npc:252476}"] = "{npc:252476}와(과) 대화하세요",

	-- Step 63: Desperate Times
	-- {npc:252383} Valennia Stormfist
	["Talk to {npc:252383}"] = "{npc:252383}와(과) 대화하세요",
	-- {npc:251968} Ayessa Dawnsinger
	["Talk to {npc:251968}"] = "{npc:251968}와(과) 대화하세요",
	-- {npc:252383} Valennia Stormfist
	["talk to {npc:252383}"] = "{npc:252383}와(과) 대화하세요",

	-- Step 64: Strength and Mercy
	-- {npc:255853} Urs'endris
	["On the way north, back to {npc:255853} by the falls."] = "북쪽으로 가는 길에 폭포 옆의 {npc:255853}에게 돌아가세요.",

	-- Step 65: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:253576} Hyusaa Quickbreeze
	["The {area:16629} is north of {area:16638}. Fight through the guards up to {npc:253576} at its east side."] = "{area:16629}은(는) {area:16638} 북쪽에 있습니다. 경비병들을 뚫고 동쪽의 {npc:253576}에게 가세요.",
	-- {npc:253576} Hyusaa Quickbreeze
	["Talk to {npc:253576}"] = "{npc:253576}와(과) 대화하세요",

	-- Step 66: Zaal Stormshield
	-- {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["{npc:257196} holds the {item:263993} on the west side of the shrine."] = "{npc:257196}이(가) 제단 서쪽에서 {item:263993}을(를) 지니고 있습니다.",

	-- Step 67: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}; {npc:257944} camps at its southern edge."] = "북쪽 {area:16631}(으)로 가세요. {npc:257944}이(가) 숲 남쪽 끝에서 야영합니다.",

	-- Step 68: Shadowgale Forest
	-- {item:265105} Lady's Tear Moss · {npc:257944} Elegael Thornpaw · {item:265141} Bloody Heirloom
	["{item:265105} grows around {npc:257944}'s camp and Shriekings fly over it. The Al'Aketh camp east of her holds the {item:265141}."] = "{item:265105}은(는) {npc:257944}의 야영지 주변에 자라고, 그 위로 그늘돌풍 괴성조가 날아다닙니다. {item:265141}은(는) 그녀 동쪽의 알아케스 야영지에 있습니다.",

	-- Step 69: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "다시 {npc:257944}",

	-- Step 70: The Al'Aketh camp
	["The Al'Aketh camp"] = "알아케스 야영지",
	-- {npc:253622} Commander Haalien · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:254151} Vayn Moongaze · {quest:94490} Ripped Missive · {quest:94489} The Wounds of Betrayal
	["{npc:253622}, {npc:258130} and {npc:258134} are in the cult camp east of {npc:257944}. {npc:254151} stands at its edge. Haalien also drops a {quest:94490}: read it to start the next quest. For {quest:94489}, enter the Nightfang Den, heal 7 injured druids and find {npc:258130}."] = "{npc:253622}, {npc:258130}, {npc:258134}은(는) {npc:257944} 동쪽 교단 야영지에 있습니다. {npc:254151}은(는) 야영지 가장자리에 있습니다. 할리엔은 {quest:94490}도 떨어뜨리니 읽어서 다음 퀘스트를 시작하세요. {quest:94489}은(는) 밤송곳니 굴에 들어가 다친 드루이드 7명을 치유하고 {npc:258130}을 찾으세요.",
	-- {npc:258130} Jorel Windsinger
	["Find {npc:258130}"] = "{npc:258130}을(를) 찾으세요",
	["Heal the injured druids in the Nightfang Den"] = "밤송곳니 굴의 다친 드루이드를 치유하세요",

	-- Step 71: Elegael Thornpaw, last time
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, last time"] = "마지막으로 {npc:257944}",

	-- Step 72: Windsong Lake
	-- {area:16625} Windsong Lake · {npc:259013} Resaan Nimbuswalker
	["The refugees' belongings lie along the north shore of {area:16625}; {npc:259013} is at its north-west end."] = "피난민의 소지품은 {area:16625} 북쪽 물가를 따라 놓여 있고, {npc:259013}은(는) 북서쪽 끝에 있습니다.",

	-- Step 73: The Strange Hermit
	-- {area:16625} Windsong Lake · {item:257128} Zephyrseed
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["The hermit lives at {area:16625}'s west shore. {item:257128} cones grow south of him; the Wind Hollows drift east of the lake."] = "은둔자는 {area:16625} 서쪽 물가에 삽니다. {item:257128} 솔방울은 그 남쪽에 자라고, {npc:251676}은(는) 호수 동쪽을 떠다닙니다.",
	-- {npc:251684} Strange Hermit
	["talk to {npc:251684}"] = "{npc:251684}와(과) 대화하세요",

	-- Step 74: Confront Lorthuna
	-- {area:16630} Rohashi Spires · {npc:252475} Elaadrin Evengale · {npc:251968} Ayessa Dawnsinger
	["Take the portal up to the {area:16630} and join {npc:252475} and {npc:251968} against the High Priestess."] = "차원문을 타고 {area:16630}(으)로 올라가 {npc:252475}, {npc:251968}와(과) 함께 대여사제 로르투나와 싸우세요.",

	-- Step 77: The airship
	["The airship"] = "비행선",
	-- {area:16638} Valanaar · {zone:1412} Mulgore
	["The Horde airship docks at the south-west edge of {area:16638}. Ride it to Kalimdor; it lands in northern {zone:1412}."] = "호드 비행선은 {area:16638} 남서쪽 끝에 정박합니다. 타고 칼림도어로 가세요. {zone:1412} 북부에 내립니다.",
	["Horde airship"] = "호드 비행선",

	-- Step 78: Northern Mulgore
	-- {zone:1412} Mulgore
	["Northern {zone:1412}"] = "{zone:1412} 북부",
	-- {npc:259119} Alaana Stormwalker
	["You leave the isle for good. {npc:259119} waits where the airship lands."] = "이제 섬을 완전히 떠납니다. {npc:259119}이(가) 비행선이 내리는 곳에서 기다립니다.",
	-- {npc:259119} Alaana Stormwalker · {zone:1454} Orgrimmar
	["{npc:259119}: keep it, Thrall in {zone:1454} comes two guides later"] = "{npc:259119}: 보관하세요. {zone:1454}의 스랄은 두 가이드 뒤에 나옵니다",
	-- {npc:259118} Muln Earthfury · {npc:3033} Turak Runetotem · {zone:1456} Thunder Bluff
	["{npc:259118}, by the landing: for {npc:3033} in {zone:1456}"] = "착륙장 옆의 {npc:259118}: {zone:1456}의 {npc:3033}에게",

	-- Step 79: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:2995} Tal
	["{area:1638} is beside the landing: ride up a lift and learn the flight path from {npc:2995}, the wind rider master."] = "{area:1638}은(는) 착륙장 옆에 있습니다. 승강기를 타고 올라가 와이번 조련사 {npc:2995}에게서 비행 경로를 배우세요.",

	-- Step 80: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068}은(는) 타우렌 향을 원합{npc:3014}. 약초상 니다, 마법부여 상인 {npc:3012}, 가죽세공 상인 {npc:3005}, 요리 상인 {npc:3027}에게서 재료 네 가지를 사서 {item:278078}(으)로 합치세요.",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{npc:3014}에게서 {item:278079}",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{npc:3012}에게서 {item:278080}",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{npc:3005}에게서 {item:278081}",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{npc:3027}에게서 {item:278083}",

	-- Step 81: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "{area:1641} 남쪽 절벽의 의식용 깔개와 향로에서 {item:278078}을(를) 사용하세요.",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "{area:1641}에서 {item:278078}을(를) 피우세요",

	-- Step 83: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["{npc:3033} trains druids on {area:1639}. He teaches you {spell:18960}; {npc:11802}'s welcome waits for your {spell:499} trip at about 23 (forever/horde/04-the-barrens)."] = "{npc:3033}은(는) {area:1639}에서 드루이드를 가르칩니다. 그에게서 {spell:18960}을(를) 배우세요. {npc:11802}의 환영 인사는 23레벨쯤 {spell:499} 여정 때 받습니다(forever/horde/04-the-barrens).",

	-- Step 84: The Crossroads
	-- {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {zone:1413} Barrens · {area:458} Gold Road · {area:380} The Crossroads
	["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "승강기로 {zone:1456}을(를) 내려가 남쪽 길을 따라 {area:222}을(를) 지나고 동쪽 고개를 넘어 {zone:1413}(으)로 가세요. 고개에서 {area:458}을(를) 따라 북쪽으로 {zone:1413} 한가운데의 호드 마을 {area:380}에 가세요.",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "와이번 조련사 {npc:3615}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Kuramaa"] = "쿠라마",
	-- ["Leave {zone:1456} by a lift and follow the road south past {area:222} and through the eastern pass into the {zone:1413}; from the pass, take the {area:458} north to the {area:380}, the Horde town in the middle of the {zone:1413}."] = "승강기로 {zone:1456}을(를) 내려가 남쪽 길을 따라 {area:222}을(를) 지나고 동쪽 고개를 넘어 {zone:1413}(으)로 가세요. 고개에서 {area:458}을(를) 따라 북쪽으로 {zone:1413} 한가운데의 호드 마을 {area:380}에 가세요.",
	-- ["Rorian: {quest:92485}"] = "로리안: {quest:92485}",
	-- ["The highwaymen hold the hills north-east of the orchard. More {object:616466} lie near the road to {area:16638}."] = "노상강도는 과수원 북동쪽 언덕을 차지하고 있습니다. {area:16638}(으)로 가는 길 근처에 {object:616466}이(가) 더 있습니다.",
	-- ["Wind Hollows and {object:616466}"] = "{npc:251676}와(과) {object:616466}",
	-- ["Wind Hollows drift over the lowlands around {area:16638}. The first {object:616466} lie west of the orchard road."] = "{npc:251676}은(는) {area:16638} 주변 저지대를 떠다닙니다. 첫 {object:616466}은(는) 과수원 길 서쪽에 있습니다.",
}
