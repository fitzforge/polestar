-- Korean (koKR): the guide forever/alliance/skyborne/01-zephras-isle (forever/alliance/skyborne/01-zephras-isle.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thendal Grove
	-- {area:16622} Thendal Grove · {npc:251362} Ailee Farheart · {npc:251361} Rorian the Dayseeker · {npc:251368} Elatrell Featherlight
	["You wake in {area:16622}. {npc:251362} stands beside you; {npc:251361} is a few steps west, {npc:251368} by the south edge of the grove."] = "{area:16622}에서 깨어납니다. {npc:251362}이(가) 곁에 서 있고, {npc:251361}은(는) 몇 걸음 서쪽에, {npc:251368}은(는) 숲 남쪽 가장자리에 있습니다.",

	-- Step 2: Vuldren and Cirrusflies
	["Vuldren and Cirrusflies"] = "벌드렌과 구름벌레",
	-- {npc:250873} Juvenile Vuldren
	["{npc:250873} and Pesky Cirrusflies roam the meadow just south-east of the grove."] = "{npc:250873}와(과) 성가신 구름벌레가 숲 바로 남동쪽 초원을 돌아다닙니다.",

	-- Step 3: Back to Thendal Grove
	-- {area:16622} Thendal Grove
	["Back to {area:16622}"] = "{area:16622}(으)로 돌아가기",
	-- {npc:251361} Rorian the Dayseeker · {item:4100} Crumpled Note
	["{npc:251361}: the {item:4100}"] = "{npc:251361}: {item:4100}",
	-- {npc:251964} Blademaster Ren
	["{npc:251964}, in the watchtower"] = "감시탑 안의 {npc:251964}",
	-- {npc:251361} Rorian the Dayseeker
	["{npc:251361}: a note from your trainer"] = "{npc:251361}: 상급자가 보낸 쪽지",
	-- {npc:251361} Rorian the Dayseeker · {item:9547} Simple Note
	["{npc:251361}: read the {item:9547}"] = "{npc:251361}: {item:9547}을(를) 읽으세요",
	-- {npc:251389} Akeri Duskblade
	["{npc:251389}, in the watchtower"] = "감시탑 안의 {npc:251389}",
	-- {npc:251379} Dorii Brightwhisper · {item:282416} Glowing Recall Crystal
	["{npc:251379}, the mage trainer: read the {item:282416} first"] = "마법사 상급자 {npc:251379}: 먼저 {item:282416}을(를) 읽으세요",
	-- {npc:251373} Xyton Silverwind · {npc:251361} Rorian the Dayseeker
	["{npc:251373}, the druid trainer, on the ground floor of the tree behind {npc:251361}"] = "드루이드 상급자 {npc:251373}: {npc:251361} 뒤편 나무의 1층",
	["The class trainers stand together in the grove"] = "직업 상급자들은 숲에 함께 모여 있습니다",
	-- {npc:257554} Halaan Hawk-Eye
	["Listen to {npc:257554}"] = "{npc:257554}의 말을 들으세요",
	-- {spell:1259416} Walk on Air
	["Use {spell:1259416}"] = "{spell:1259416} 사용",

	-- Step 4: Raw Windstones and the Cirrusfly Queen
	-- {npc:251404} Cirrusfly Queen
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["Raw Windstones and the {npc:251404}"] = "바람석 원석과 {npc:251404}",
	-- {quest:92463} The Cirrusfly Queen · {npc:249363} Yala Windwatcher
	-- plural, as words: Raw Windstones = {object:613286} Raw Windstone
	["The Raw Windstones glitter on the ground just south of the grove. {quest:92463} hovers over the meadow further east, on the way to {npc:249363}."] = "바람석 원석은 숲 바로 남쪽 땅에서 반짝입니다. {quest:92463}은(는) 더 동쪽, {npc:249363}에게 가는 길의 초원 위를 맴돕니다.",

	-- Step 5: Yala Windwatcher
	-- {npc:249363} Yala Windwatcher · {npc:251143} Roiling Winds · {object:460002} Ley Line (no name in this language: may be words) · {spell:1259705} Read Leyline
	-- plural, as words: Al'Aketh Converts = {npc:251160} Al'Aketh Convert
	["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your {spell:1259705} racial ability at it."] = "{npc:249363}은(는) 숲 동쪽에서 망을 봅니다. {npc:251143}와(과) {npc:251160}이(가) 그녀 바로 북쪽에 모여 있고, 지맥은 더 북쪽에서 솟아오릅니다. 그곳에 종족 능력 {spell:1259705}을(를) 시전하세요.",
	-- {spell:1259705} Read Leyline · {object:460002} Ley Line (no name in this language: may be words)
	["Cast {spell:1259705} at the {object:460002}"] = "지맥에 {spell:1259705} 시전",

	-- Step 6: Thendal Grove turn-ins
	-- {area:16622} Thendal Grove
	["{area:16622} turn-ins"] = "{area:16622} 퀘스트 제출",
	["Level 4 spells"] = "4레벨 주문",

	-- Step 7: Scrawny Ursera and Urs'anah
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	["{npc:250926} and {npc:251115}"] = "{npc:250926}와(과) {npc:251115}",
	-- {npc:250926} Scrawny Ursera · {npc:251115} Urs'anah
	-- plural, as words: Ursera Scavengers = {npc:250937} Ursera Scavenger
	["{npc:250926} prowl the woods just west of the grove; the Ursera Scavengers den further west, with {npc:251115}, the matriarch, at the back of the den."] = "{npc:250926}은(는) 숲 바로 서쪽 숲속을 배회합니다. 우르세라 청소부는 더 서쪽에 굴을 틀고 있으며, 우두머리인 {npc:251115}은(는) 굴 안쪽에 있습니다.",

	-- Step 8: Hanaa Nightwind
	-- {npc:252095} Hanaa Nightwind · {npc:256935} Malduko Cloudcrush
	["{npc:252095} camps south of the Ursera den. The Al'Aketh thugs hold the camp south-west of her; {npc:256935} stands in its middle."] = "{npc:252095}은(는) 우르세라 굴 남쪽에 야영합니다. 알아케스 폭력배가 그녀 남서쪽 야영지를 점거하고 있으며, {npc:256935}은(는) 그 한가운데에 서 있습니다.",

	-- Step 9: Aetheen of the Gales
	["Level 6 spells"] = "6레벨 주문",

	-- Step 10: Shen'dar Village
	-- {area:16624} Shen'dar Village · {npc:263664} Raan Wildwind · {npc:251523} Constable Aonda · {npc:251903} Rathiril Sunlance
	["Follow the road south to {area:16624}. {npc:263664} camps by the fire west of the village; {npc:251523} and {npc:251903} stand in its middle."] = "길을 따라 남쪽 {area:16624}(으)로 가세요. {npc:263664}은(는) 마을 서쪽 모닥불 옆에 야영하고, {npc:251523}와(과) {npc:251903}은(는) 마을 한가운데에 서 있습니다.",
	-- {npc:251903} Rathiril Sunlance · {npc:254089} Coriella Calmbreeze
	["Speak with {npc:251903} and {npc:254089}, north-west of the village"] = "마을 북서쪽의 {npc:251903}, {npc:254089}와(과) 대화하세요",

	-- Step 11: Raan Wildwind
	-- {npc:263664} Raan Wildwind · {spell:1229451} Boosted Rest
	["/sit by {npc:263664}'s campfire until you get {spell:1229451}"] = "{spell:1229451} 효과를 얻을 때까지 {npc:263664}의 모닥불 옆에 앉으세요(/앉기)",

	-- Step 12: Village quests
	["Village quests"] = "마을 퀘스트",
	["The bounty board"] = "현상금 게시판",

	-- Step 13: Prideclaws and Galestriders
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders"] = "무리발톱과 돌풍타조",
	-- plural, as words: Prideclaws = {npc:251245} Prideclaw
	["Prideclaws and Galestriders roam the grasslands south of the village. Galestriders drop both the eggs and the meat."] = "무리발톱과 돌풍타조가 마을 남쪽 초원을 돌아다닙니다. 돌풍타조는 알과 고기를 모두 떨어뜨립니다.",

	-- Step 14: Back to Shen'dar
	["Back to Shen'dar"] = "셴다르로 돌아가기",

	-- Step 15: The Highlands bandits
	["The Highlands bandits"] = "고원 좀도둑",
	-- plural, as words: Highlands Bandits = {npc:251918} Highlands Bandit
	["The Highlands Bandits camp north-east of the village. \"Badwind\" Bennic waits at the far north end of their camp."] = "고원 좀도둑은 마을 북동쪽에 야영합니다. \"사악한 바람\" 베닉은 야영지 북쪽 끝에서 기다립니다.",

	-- Step 16: Shen'dar turn-ins
	["Shen'dar turn-ins"] = "셴다르 퀘스트 제출",

	-- Step 17: Falaath Village
	-- {npc:257065} Missionary Jasaan · {quest:92529} Falaath Village · {spell:1254832} Mark of Akir
	["{npc:257065} waits at the entrance to {quest:92529}, south of Shen'dar. The {spell:1254832} lets you walk in among the faithful."] = "{npc:257065}은(는) 셴다르 남쪽 {quest:92529} 입구에서 기다립니다. {spell:1254832}이(가) 있으면 신도들 사이로 걸어 들어갈 수 있습니다.",
	["Search the wardrobe"] = "옷장을 뒤지세요",

	-- Step 19: Havoc in Falaath
	["Havoc in Falaath"] = "팔라스의 혼란",
	-- {quest:92529} Falaath Village · {npc:251662} Living Lightning · {npc:251966} Commander Cyclas
	["Back in {quest:92529}: Stormcallers and {npc:251662} fill the village, the Stormcallers carry the stolen supplies, and {npc:251966} stands at its south end."] = "다시 {quest:92529}: 폭풍소환사와 {npc:251662}이(가) 마을을 메우고 있고, 폭풍소환사가 도난당한 보급품을 가지고 있으며, {npc:251966}은(는) 마을 남쪽 끝에 서 있습니다.",

	-- Step 20: The Western Watch
	-- {npc:252155} Peacekeeper Vaaniel · {npc:256966} Skypriest Aanders
	["{npc:252155} holds the western watch, south-west of Falaath. {npc:256966} and the fallen guards lie just south of her."] = "{npc:252155}은(는) 팔라스 남서쪽의 서부 감시터를 지킵니다. {npc:256966}와(과) 쓰러진 경비병들은 그녀 바로 남쪽에 누워 있습니다.",
	-- {item:254871} Bloody Note
	["The {item:254871}"] = "{item:254871}",

	-- Step 21: The hippogryph roost
	["The hippogryph roost"] = "히포그리프 둥지",
	-- {item:263493} Hippogryph Down
	["Head north-west to the hippogryph nests on the western cliffs. {item:263493} lies around the nests; the Matriarch patrols among them."] = "북서쪽 서부 절벽의 히포그리프 둥지로 가세요. {item:263493}은(는) 둥지 주변에 있고, 히포그리프 어미가 둥지 사이를 순찰합니다.",

	-- Step 22: Vulgara the Insatiable
	-- {npc:254589} Vulgara the Insatiable
	["{npc:254589} lurks in the hills south-west of the village, on the way back. {npc:254589} is elite: grouping up is advised."] = "{npc:254589}는 돌아가는 길에, 마을 남서쪽 언덕에 숨어 있습니다. {npc:254589}은(는) 정예이므로 파티를 권장합니다.",

	-- Step 23: Windshaper Novice Seers
	-- plural, as words: Windshaper Novice Seers = {npc:257532} Windshaper Novice Seer
	["Windshaper Novice Seers"] = "바람구체자 수습 선견자",
	["The Novice Seers practise in the clearing west of Shen'dar."] = "수습 선견자들은 셴다르 서쪽 빈터에서 수련합니다.",

	-- Step 24: Shen'dar Village again
	-- {area:16624} Shen'dar Village
	["{area:16624} again"] = "다시 {area:16624}",

	-- Step 25: The road to Valanaar
	-- {area:16638} Valanaar
	["The road to {area:16638}"] = "{area:16638}(으)로 가는 길",
	-- {npc:257006} Nyalah Brightfire · {npc:252448} Alvarion Windfield · {area:16638} Valanaar
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Take the road south-east. {npc:257006} and {npc:252448} stand by the road west of {area:16638}; Windsong Crawlers line the shore further west, around 51,70."] = "남동쪽 길을 따라가세요. {npc:257006}와(과) {npc:252448}은(는) {area:16638} 서쪽 길가에 서 있고, 바람노래 집게발은 더 서쪽 해안, 51,70 근처에 늘어서 있습니다.",

	-- Step 26: Valanaar
	-- {npc:252383} Valennia Stormfist · {npc:252476} Talaanis Shadowsong · {area:16638} Valanaar · {npc:252475} Elaadrin Evengale · {npc:253204} Dondallion Whisperwind
	["{npc:252383} and {npc:252476} stand at the north end of {area:16638}, {npc:252475} and {npc:253204} at the south end."] = "{npc:252383}와(과) {npc:252476}은(는) {area:16638} 북쪽 끝에, {npc:252475}와(과) {npc:253204}은(는) 남쪽 끝에 서 있습니다.",

	-- Step 27: Skyhoppers
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers"] = "하늘폴짝이",
	-- {area:16638} Valanaar
	-- plural, as words: Skyhoppers = {npc:251727} Skyhopper
	["Skyhoppers swarm the fields west of {area:16638}."] = "하늘폴짝이가 {area:16638} 서쪽 들판에 떼지어 있습니다.",

	-- Step 28: The missing scholar
	["The missing scholar"] = "사라진 학자",
	-- {object:581822} Bloodstained Satchel · {area:16638} Valanaar
	-- plural, as words: Shriekling Matriarchs = {npc:253283} Shriekling Matriarch
	["The {object:581822} lies by the path west of {area:16638}; Fillion's camp is north-west of it, and the Shriekling Matriarchs nest just west of the camp."] = "{object:581822}은(는) {area:16638} 서쪽 길가에 있습니다. 필리온의 야영지는 그 북서쪽에 있고, 괴성조 어미는 야영지 바로 서쪽에 둥지를 틀고 있습니다.",
	-- {object:581822} Bloodstained Satchel
	["The {object:581822}"] = "{object:581822}",
	["Find Fillion and his bedroll"] = "필리온과 그의 침낭을 찾으세요",

	-- Step 29: Aamelia Windfield
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} runs the farm in the south-west lowlands."] = "{npc:252800}은(는) 남서쪽 저지대의 농장을 운영합니다.",

	-- Step 30: The Windfield farm
	["The Windfield farm"] = "윈드필드 농장",
	-- {quest:92683} Flutterfly Dust · {npc:250929} Malfunctioning Cyclone Construct
	-- plural, as words: Ripe Stormapples = {item:253591} Ripe Stormapple · Hungry Bandits = {npc:252802} Hungry Bandit · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Ripe Stormapples and Hungry Bandits are in the orchard by the farm, {quest:92683} in the fields north-east of it, Ornery Galestriders all around. The {npc:250929} stands in the field north-east of the farm."] = "잘 익은 폭풍사과와 굶주린 좀도둑은 농장 옆 과수원에, {quest:92683}은(는) 농장 북동쪽 들판에 있고, 심술궂은 돌풍타조는 사방에 있습니다. {npc:250929}은(는) 농장 북동쪽 들판에 서 있습니다.",

	-- Step 31: Aamelia Windfield again
	-- {npc:252800} Aamelia Windfield
	["{npc:252800} again"] = "다시 {npc:252800}",

	-- Step 32: Bandit Highwaymen
	["Bandit Highwaymen"] = "산적 노상강도",
	["The Bandit Highwaymen hold the hills north of the farm."] = "산적 노상강도는 농장 북쪽 언덕을 점거하고 있습니다.",

	-- Step 33: Standing our ground
	["Standing our ground"] = "자리를 지키며",
	-- {npc:252800} Aamelia Windfield · {npc:252863} Ferauu the Bludgeon
	["Stand with {npc:252800} against {npc:252863}"] = "{npc:252800}와(과) 함께 {npc:252863}에 맞서 싸우세요",

	-- Step 34: Valanaar turn-ins
	-- {area:16638} Valanaar
	["{area:16638} turn-ins"] = "{area:16638} 퀘스트 제출",
	-- {npc:252377} Seena Skybreaker · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["{npc:252377}: {npc:257196} waits at the {area:16629}"] = "{npc:252377}: {npc:257196}이(가) {area:16629}에서 기다립니다",
	-- {npc:252373} Anathamaas Aetherwind
	["{npc:252373}, the mage trainer"] = "마법사 상급자 {npc:252373}",

	-- Step 35: Taming the Beast
	-- {item:15908} Taming Rod · {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {npc:254411} Quel'dora Quickgale
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler · Vuldren Alphas = {npc:250874} Vuldren Alpha · Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Each of Quel'ana's quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her in {area:16638}. Windsong Crawlers line the shore west of town; Vuldren Alphas and Ornery Galestriders roam the {area:16626} around the Windfield farm. Her sister {npc:254411} stands beside her."] = "퀠라나의 퀘스트는 각각 {item:15908}을(를) 줍니다. 그녀가 말한 야수에게 사용한 뒤, 막대를 {area:16638}에 있는 그녀에게 다시 가져가세요. 바람노래 집게발은 마을 서쪽 해안에 늘어서 있고, 벌드렌 우두머리와 심술궂은 돌풍타조는 윈드필드 농장 주변 {area:16626}을(를) 돌아다닙니다. 그녀의 자매 {npc:254411}이(가) 곁에 서 있습니다.",
	-- {npc:254588} Windsong Crawler · {item:15908} Taming Rod
	["{npc:254588}: tame it with the {item:15908}"] = "{npc:254588}: {item:15908}(으)로 길들이세요",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "{item:15908}(으)로 길들이세요",

	-- Step 36: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "Windstone Formation",
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations stand on the rise west of Fillion's camp."] = "Windstone Formation은 필리온의 야영지 서쪽 언덕 위에 있습니다.",
	-- {item:262668} Wind-Infused Bough · {quest:92529} Falaath Village
	["{item:262668}: by the wind shrine south of {quest:92529}"] = "{item:262668}: {quest:92529} 남쪽 바람 사당 옆",

	-- Step 38: The eastern watchtower
	["The eastern watchtower"] = "동쪽 감시탑",
	-- {npc:252378} Yorana Windyreed · {area:16638} Valanaar · {npc:252666} Commander Belguilos
	["{npc:252378} holds the watchtower north of {area:16638}. The Al'Aketh camp is just west of the tower, its healers around 65,68 and 65,65; {npc:252666} stands at its north end. The Al'Aketh there drop Windstone Charms."] = "{npc:252378}은(는) {area:16638} 북쪽 감시탑을 지킵니다. 알아케스 야영지는 탑 바로 서쪽에 있으며, 치유사들은 65,68과 65,65 근처에 있고 {npc:252666}은(는) 야영지 북쪽 끝에 서 있습니다. 그곳의 알아케스는 알아케스 바람석 부적을 떨어뜨립니다.",

	-- Step 39: Valanaar, the turncoat
	-- {area:16638} Valanaar
	["{area:16638}, the turncoat"] = "{area:16638}, 배신자",

	-- Step 40: Urs'endris
	-- {npc:255853} Urs'endris · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands
	["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623} west of {area:16638}, by the road you take next."] = "{npc:255853}은(는) {area:16638} 북동쪽 폭포 옆에서 기다립니다. {npc:258443}은(는) {area:16638} 서쪽 {area:16623}, 다음에 갈 길가를 배회합니다.",

	-- Step 41: The dead cultist
	["The dead cultist"] = "죽은 광신도",
	-- {npc:273017} Fendaal Windstone · {quest:98512} Al'Aketh Assassins
	["North-west of Valanaar along the road: {npc:273017} watches the {quest:98512}; the dead cultist lies just north of him."] = "발라나르 북서쪽 길가: {npc:273017}이(가) {quest:98512}을(를) 감시하고 있고, 죽은 광신도는 그 바로 북쪽에 쓰러져 있습니다.",
	["Search the dead cultist"] = "죽은 광신도를 조사하세요",
	-- {npc:258443} Ur'endra
	["{npc:258443}, in the highlands south-west of the cultist"] = "광신도 남서쪽 고원의 {npc:258443}",

	-- Step 42: Desperate times
	["Desperate times"] = "절박한 시기",
	-- {npc:251968} Ayessa Dawnsinger · {npc:252475} Elaadrin Evengale
	["Rally Valennia, {npc:251968} (west of town) and {npc:252475}"] = "발레니아, {npc:251968}(마을 서쪽), {npc:252475}을(를) 모으세요",
	["Meet Valennia at the gate"] = "성문에서 발레니아를 만나세요",

	-- Step 43: Strength and Mercy
	-- {npc:255853} Urs'endris · {area:16638} Valanaar
	["Back to {npc:255853} by the falls north-east of {area:16638}, on the way north to the shrine."] = "북쪽 사당으로 가는 길에, {area:16638} 북동쪽 폭포 옆의 {npc:255853}에게 돌아가세요.",

	-- Step 44: The Shrine of Akir
	-- {area:16629} Shrine of Akir
	["The {area:16629}"] = "{area:16629}",
	-- {area:16629} Shrine of Akir · {npc:253576} Hyusaa Quickbreeze · {npc:253590} Valennia Stormfist
	["Fight north to the {area:16629}. Guardians, Spiritcallers and Blademasters hold the approach; {npc:253576} waits at the shrine's door, {npc:253590} inside the inner sanctum."] = "싸우며 북쪽 {area:16629}(으)로 가세요. 알아케스 수호자, 알아케스 영혼소환사, 알아케스 검귀가 진입로를 지키고 있습니다. {npc:253576}은(는) 사당 문 앞에서, {npc:253590}은(는) 안쪽 성소에서 기다립니다.",
	-- {npc:253590} Valennia Stormfist
	["{npc:253590}, in the sanctum"] = "성소 안의 {npc:253590}",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}: {npc:257196}, west of the shrine's approach"] = "{item:263993}: 사당 진입로 서쪽의 {npc:257196}",

	-- Step 45: Elegael Thornpaw
	-- {area:16631} Shadowgale Forest · {npc:257944} Elegael Thornpaw
	["Head north into {area:16631}. {npc:257944} camps in its east."] = "북쪽 {area:16631}(으)로 가세요. {npc:257944}은(는) 그 동쪽에 야영합니다.",

	-- Step 46: Shadowgale Forest
	-- {npc:257944} Elegael Thornpaw · {item:265105} Lady's Tear Moss
	-- plural, as words: Al'Aketh Stormchasers = {npc:252664} Al'Aketh Stormchaser
	["Al'Aketh Stormchasers and Footsoldiers camp just north of {npc:257944} and drop the heirloom; the Shrieklings west of her drop the feathers and talons; the {item:265105} grows along the stream west of her."] = "알아케스 폭풍추격자와 알아케스 보병이 {npc:257944} 바로 북쪽에 야영하며 가보를 떨어뜨립니다. 그녀 서쪽의 괴성조는 깃털과 갈퀴발톱을 떨어뜨리고, {item:265105}은(는) 그녀 서쪽 개울을 따라 자랍니다.",

	-- Step 47: Elegael Thornpaw again
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944} again"] = "다시 {npc:257944}",

	-- Step 48: Vayn Moongaze
	-- {npc:254151} Vayn Moongaze · {npc:258130} Jorel Windsinger · {npc:258134} Naaleos Leafwhisper · {npc:257944} Elegael Thornpaw · {npc:253622} Commander Haalien · {quest:94490} Ripped Missive
	["{npc:254151}, {npc:258130} and {npc:258134} are north-east of {npc:257944}; {npc:253622} stands east of them. Haalien also drops a {quest:94490}."] = "{npc:254151}, {npc:258130}, {npc:258134}은(는) {npc:257944} 북동쪽에 있고, {npc:253622}은(는) 그들 동쪽에 서 있습니다. 할리엔은 {quest:94490}도 떨어뜨립니다.",
	-- {npc:258130} Jorel Windsinger
	["Heal 7 druids in the Nightfang Den, then find {npc:258130}"] = "Nightfang Den에서 드루이드 7명을 치유한 뒤 {npc:258130}을(를) 찾으세요",

	-- Step 49: Elegael Thornpaw, the missive
	-- {npc:257944} Elegael Thornpaw
	["{npc:257944}, the missive"] = "{npc:257944}: 전갈",

	-- Step 50: The Strange Hermit
	-- {quest:93159} The Strange Hermit · {npc:257944} Elegael Thornpaw
	-- plural, as words: Zephyrseed Cones = {object:613238} Zephyrseed Cone
	["{quest:93159} lives west of {npc:257944}. The Zephyrseed Cones lie in the woods between his hut and {npc:257944}."] = "{quest:93159}은(는) {npc:257944} 서쪽에 삽니다. {object:613238}은(는) 그의 오두막과 {npc:257944} 사이 숲에 있습니다.",

	-- Step 51: The refugees' camp
	["The refugees' camp"] = "피난민 야영지",
	-- {item:266433} Abandoned Belongings · {npc:259013} Resaan Nimbuswalker
	-- plural, as words: Wind Hollows = {npc:251676} Wind Hollow
	["North of the cones: the Wind Hollows drift around the refugees' camp, the {item:266433} lie between the tents, and {npc:259013} lies at its north end."] = "솔방울 북쪽: 바람의 유령이 피난민 야영지 주변을 떠돌고, {item:266433}은(는) 천막 사이에 있으며, {npc:259013}은(는) 야영지 북쪽 끝에 쓰러져 있습니다.",

	-- Step 52: Back to the Hermit
	["Back to the Hermit"] = "수상한 은둔자에게 돌아가기",

	-- Step 53: High Priestess Lorthuna
	-- {area:16629} Shrine of Akir
	["Lorthuna waits on the eastern shore of the isle, east of the {area:16629}."] = "로르투나는 {area:16629} 동쪽, 섬의 동쪽 해안에서 기다립니다.",

	-- Step 54: Valanaar, the fate of Zephras
	-- {area:16638} Valanaar
	["{area:16638}, the fate of Zephras"] = "{area:16638}, 제프라스의 운명",
	-- {npc:252475} Elaadrin Evengale · {npc:259084} Denaaris Stargale
	["{npc:252475}: {npc:259084} waits by the Skyborne portal"] = "{npc:252475}: {npc:259084}이(가) 스카이본 차원문 옆에서 기다립니다",

	-- Step 55: The skycutter
	["The skycutter"] = "비행정",
	-- {area:16638} Valanaar · {area:279} Dalaran
	["The skycutter docks at the tower south of {area:16638}. It lands by the Kirin Tor camp on the lake shore west of {area:279}."] = "비행정은 {area:16638} 남쪽 탑에 정박합니다. {area:279} 서쪽 호숫가의 키린 토 야영지 옆에 내립니다.",
	-- {area:279} Dalaran
	["Skycutter to {area:279}"] = "비행정으로 {area:279}에 가기",

	-- Step 56: Denaaris Stargale
	-- {npc:259084} Denaaris Stargale · {zone:1453} Stormwind
	["{npc:259084} stands beside the Skyborne Portal where the zeppelin lands. The portal takes you to {zone:1453}."] = "{npc:259084}은(는) 비행선이 내리는 곳의 스카이본 차원문 옆에 서 있습니다. 차원문은 {zone:1453}(으)로 연결됩니다.",
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind
	["{npc:270459}, beside {npc:259084}: for {npc:5504} in {zone:1453}"] = "{npc:259084} 옆의 {npc:270459}: {zone:1453}의 {npc:5504}용",

	-- Step 57: Stormwind Keep
	-- {object:2117} Stormwind Keep · {zone:1436} Westfall
	["Bolvar Fordragon stands in the throne room of {object:2117}, at the north end of the city. Then leave by the main gate for {zone:1436}."] = "볼바르 폴드라곤은 도시 북쪽 끝 {object:2117}의 왕좌실에 서 있습니다. 그런 다음 정문으로 나가 {zone:1436}(으)로 가세요.",
	-- {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["For {npc:234} at {area:108}"] = "{area:108}의 {npc:234}용",

	-- Step 58: Sheldras Moontree
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form · {zone:1439} Darkshore
	["{npc:5504}, {zone:1453}'s druid trainer, teaches you {spell:18960}. {npc:11802}'s welcome waits for your {spell:499} trip at the end of {zone:1439}."] = "{zone:1453}의 드루이드 상급자 {npc:5504}이(가) {spell:18960}을(를) 가르쳐 줍니다. {npc:11802}의 환영 인사는 {zone:1439} 끝의 {spell:499} 여정에서 기다립니다.",

	-- Step 59: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497}은(는) {object:2101}의 탑인 마법사의 성소에 있습니다. 그녀는 {quest:1861} 폭포에 쓸 병을 줍니다.",

	-- Step 60: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "정문으로 {zone:1453}을(를) 나가세요. {quest:1861} 폭포는 성문 남서쪽, 서쪽 {zone:1436}(으)로 가는 길에 있습니다. 폭포 아래에서 {item:7207}을(를) 채우세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Read Ley Line at the {object:460002}"] = "{object:460002}에 Read Ley Line 시전",
	-- ["Rorian: {quest:92485}"] = "로리안: {quest:92485}",
	-- ["{npc:249363} keeps watch east of the grove. The {npc:251143} and Al'Aketh Converts gather just north of her; the {object:460002} rises further north: cast your Read Ley Line racial ability at it."] = "{npc:249363}은(는) 숲 동쪽에서 망을 봅니다. {npc:251143}와(과) {npc:251160}이(가) 그녀 바로 북쪽에 모여 있고, {object:460002}은(는) 더 북쪽에서 솟아오릅니다. 그곳에 종족 능력 Read Ley Line을(를) 시전하세요.",
}
