-- Korean (koKR): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aquatic Form
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {item:15885} Pendant of the Sea Lion · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "{area:17203}에서 배를 타고 {area:442}(으)로 가세요. 반쪽 펜던트 두 개를 합쳐 {item:15885}을(를) 만들고 {spell:18960}을(를) 시전하세요. {npc:11802}은(는) {area:2361}에 있습니다. 그런 다음 ({area:442}을(를) 거쳐) {area:702}(으)로 날아가세요.",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the two halves"] = "{item:15885}: 반쪽 두 개를 합치기",

	-- Step 2: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine
	["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "차원문을 타고 {area:1658}(으)로 올라간 뒤, {area:442}(으)로 날아 돌아오세요.",

	-- Step 3: Elune's Grace
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:11401} Priestess Alathea
	["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "{area:17203}에서 배를 타고 {area:442}(으)로 간 뒤 {area:702}(으)로 날아가세요. {npc:11401}은(는) 달의 신전에 있습니다. 그런 다음 {area:442}(으)로 날아 돌아오세요.",

	-- Step 4: Boat to Auberdine
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {npc:3649} Thundris Windweaver · {zone:1439} Darkshore
	["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "{area:17203}에서 배를 타고 {area:442}(으)로 가세요. {npc:3649}은(는) 마을 북쪽 끝에 서 있습니다. 그런 다음 길을 따라 남쪽으로 {zone:1439}을(를) 지나가세요.",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}: Alexston's reply"] = "{npc:3649}: 알렉스톤의 답장",

	-- Step 5: Kerlonian Evershade
	-- {area:448} Grove of the Ancients · {zone:1439} Darkshore · {item:13536} Horn of Awakening · {zone:1440} Ashenvale · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Kerlonian sleeps at the {area:448} in southern {zone:1439}. Use the {item:13536} to wake him and lead him south along the road into {zone:1440} to {npc:11219} at {area:413}; blow the horn again whenever he falls asleep."] = "케를로니안은 {zone:1439} 남부의 {area:448}에서 잠들어 있습니다. {item:13536}을(를) 사용해 그를 깨우고, 길을 따라 남쪽으로 {zone:1440}에 들어가 {area:413}의 {npc:11219}에게 데려가세요. 그가 잠들 때마다 뿔피리를 다시 부세요.",
	-- {area:413} Maestra's Post · {zone:1440} Ashenvale
	["Escort Kerlonian to {area:413} in {zone:1440}."] = "케를로니안을 {zone:1440}의 {area:413}까지 호위하세요.",

	-- Step 7: Bathran's Haunt
	-- {area:411} Bathran's Haunt · {item:5366} Glowing Soul Gem
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "마에스트라 주둔지 북쪽, {area:411} 폐허 주변에 식물 꾸러미가 놓여 있습니다. 암흑이교도는 그 바로 남쪽 폐허를 차지하고 있으며, 누구든 {item:5366}을(를) 떨어뜨릴 수 있습니다.",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}, 식물 꾸러미에서",

	-- Step 9: Astranaar
	-- {area:415} Astranaar
	["Follow the road south-east to {area:415}, on the island in the lake."] = "길을 따라 남동쪽으로 호수 섬에 있는 {area:415}까지 가세요.",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, 여관 안",

	-- Step 10: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "서쪽으로 {area:441} 기슭까지 가세요. 테로니스는 소금거품멀록들 사이에 쓰러져 있습니다. 어느 멀록이든 {item:5463}을(를) 떨어뜨릴 수 있습니다.",

	-- Step 11: Shrine of Aessina
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["South of the murlocs, {npc:3585} waits at the {area:416}."] = "멀록들 남쪽, {area:416}에서 {npc:3585}이(가) 기다립니다.",

	-- Step 12: Ilkrud Magthrull
	-- {npc:3664} Ilkrud Magthrull · {area:412} Ruins of Ordil'Aran
	["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664}와(과) 그의 공허방랑자들은 성소 남쪽의 {area:412}을(를) 차지하고 있습니다. 경비병을 먼저 끌어오세요.",

	-- Step 13: The Zoram Strand
	-- {area:414} The Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "해안을 따라 북쪽으로 {area:414}까지 가세요. {npc:3846}은(는) 해변에 진을 치고 있고, 해안에는 성난지느러미일족 나가가 가득합니다.",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}, 해안의 폐허 안",

	-- Step 15: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} The Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009}은(는) 성난지느러미일족 경비병과 함께 {area:414}의 북쪽 끝을 돌아다닙니다.",

	-- Step 19: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987}(25레벨)이 {area:415} 북쪽 야영지에서 엉겅퀴일족 놀을 이끕니다. 경비병을 하나씩 먼저 처치하세요.",

	-- Step 20: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "눈물은 {area:415} 동쪽의 작은 섬에서 빛납니다.",

	-- Step 22: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "길을 따라 동쪽으로 {area:419}까지 가세요. {npc:3916}은(는) 달샘 옆에 서 있습니다.",

	-- Step 23: The Foulweald
	["The Foulweald"] = "썩은나무 숲",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "썩은나무일족 펄볼그는 길 남쪽, {area:415} 남동쪽 숲에 삽니다. 썩은나무일족 보초와 썩은나무일족 펄볼그가 굴을 지킵니다.",

	-- Step 24: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885}은(는) {area:421} 동쪽 기슭의 {area:420}에 서 있고, {npc:210995}은(는) 서쪽 기슭에 진을 치고 있습니다. 타락한 물의 정령이 그 사이 호수를 걸어다닙니다.",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "정령을 처치해 {item:12220} 5개를 모은 뒤 {item:5456}을(를) 사용하세요",

	-- Step 25: The Ruins of Stardust
	["West of Mystral Lake, the stardust bushes grow among the ruins."] = "미스트랄 호수 서쪽, 폐허 사이에 별가루 덤불이 자랍니다.",

	-- Step 27: Windshear Crag
	-- {area:421} Mystral Lake · {area:1276} Talondeep Path · {area:461} Windshear Crag · {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle · {area:1076} Webwinder Path
	["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "{area:421}을(를) 지나 남쪽으로 {area:1276} 굴에 들어가세요. 굴은 돌발톱 산맥의 {area:461}(으)로 이어집니다. {npc:4080}와(과) {npc:4077}은(는) 바위산 남서쪽 {area:1076}에 진을 치고 있습니다.",
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, in the hut north of them"] = "{npc:4201}, 그들 북쪽의 오두막 안",

	-- Step 28: Venture Co. loggers
	["Venture Co. loggers"] = "투자개발회사 나무꾼",
	-- {area:461} Windshear Crag
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "투자개발회사가 {area:461}의 숲을 베어내고 있습니다. 나무꾼과 벌채꾼이 곳곳에서 일하고, 운전수가 벌목기를 몰며 그중 하나가 설계도를 지니고 있습니다.",

	-- Step 29: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276}은(는) 바위산 동쪽 끝의 {area:2160}에서 채광합니다. 그에게 말을 걸고, 그가 채광하는 동안 투자개발회사 습격자를 막아내세요.",

	-- Step 31: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "{area:150}(으)로",
	-- {area:1276} Talondeep Path
	["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "귀환석이 재사용 대기 중인가요? {area:1276}을(를) 지나 북쪽으로 돌아가세요.",
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "배를 타고 {area:150}(으)로",

	-- Step 32: Menethil Harbor
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, 여관 북쪽 부두 위",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, 여관 안",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep"] = "{npc:2086}, 성채 옆",
	-- {npc:2097} Harlo Barnaby
	["{npc:2097}, by the north gate"] = "{npc:2097}, 북문 옆",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the north gate"] = "{npc:2094}, 북문 옆",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}, 북문 옆",

	-- Step 33: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "목재와 철 더미가 성채 주변과 항구 성벽을 따라 놓여 있습니다.",

	-- Step 35: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "해안을 따라 북쪽으로 메네실 항구를 나가세요. 푸른아가미멀록이 늪에 가득하고, {npc:1259}은(는) 그 한가운데에서 무리와 함께 돌아다닙니다.",

	-- Step 37: The Bluegill hovels
	["The Bluegill hovels"] = "푸른아가미 오두막",
	-- {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "멀록 오두막의 상자 세 개, 남쪽에서 북쪽 순서: {object:261}, 그다음 {object:142151}, 그다음 북쪽 끝의 {object:259}.",

	-- Step 38: Karl Boran
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: 성채 안의 {npc:2104}에게",

	-- Step 39: Captain Stoutfist
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1242} Karl Boran
	["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104}은(는) {npc:1242}에게서 조금 걸어가면 나오는 {area:2103}에 서 있습니다.",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "{object:2117}의 볼바르 폴드라곤에게: 보관하세요",

	-- Step 40: Young crocolisks
	["Young crocolisks"] = "새끼 악어",
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "길을 따라 동쪽으로 가세요. {npc:1417}은(는) 발굴 현장 북쪽 웅덩이에 숨어 있습니다.",

	-- Step 41: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "발굴 현장은 길 남쪽 언덕 위에 있습니다.",

	-- Step 42: The raptor hills
	["The raptor hills"] = "랩터 언덕",
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor
	["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "줄무늬랩터와 긴송곳니 줄무늬랩터가 발굴 현장 서쪽 언덕을 돌아다닙니다.",

	-- Step 44: Raptor valley
	["Raptor valley"] = "랩터 계곡",
	["The bigger raptors hunt in the valley just west of the dig."] = "더 큰 랩터는 발굴지 바로 서쪽 계곡에서 사냥합니다.",

	-- Step 46: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "긴다리동굴거미와 긴다리흡혈거미가 발굴 현장 남동쪽 동굴인 {area:1021}에 가득합니다.",

	-- Step 47: Black Oozes
	-- plural, as words: Black Oozes = {npc:1032} Black Ooze
	["Black Oozes"] = "검은 수액괴물",
	-- {area:1025} Green Belt · {npc:2093} Einar Stonegrip · {npc:2111} Sida
	-- plural, as words: Black Oozes = {npc:1032} Black Ooze
	["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "검은 수액괴물은 {area:1025} 길 북쪽, {npc:2093}의 야영지 서쪽 늪을 기어다닙니다. 어느 수액괴물이든 {npc:2111}의 가방을 지니고 있을 수 있습니다.",

	-- Step 48: Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093}은(는) 길가에 진을 치고 있고, {npc:1244}은(는) 더 동쪽 강가에 서 있습니다.",

	-- Step 49: The Mosshide gnolls
	["The Mosshide gnolls"] = "이끼가죽 놀",
	-- {area:1025} Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "이끼가죽 놀과 이끼가죽일족 싸움꾼이 {area:1025} 남동쪽 언덕을 차지하고 있습니다.",

	-- Step 51: Crude Flint
	-- {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "이끼가죽일족 길잡이와 안개마술사가 {npc:1244} 바로 서쪽과 남쪽 강둑을 돌아다닙니다. 거의 모두가 부싯돌을 떨어뜨립니다.",

	-- Step 53: Fen Creepers
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers"] = "수렁이끼괴물",
	-- {area:1025} Green Belt
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "수렁이끼괴물은 {area:1025} 북서쪽 늪 웅덩이에 숨어 있습니다.",

	-- Step 54: Dun Modr
	-- {area:205} Dun Modr · {area:881} Thandol Span · {npc:1071} Longbraid the Grim
	["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "길을 따라 북쪽으로 {area:881} 기슭의 {area:205}까지 가세요. {npc:1071}은(는) 드워프 야영지에 서 있습니다.",

	-- Step 56: Dragonmaw camp
	["Dragonmaw camp"] = "용아귀부족 야영지",
	-- {area:1025} Green Belt · {npc:2092} Pilot Longbeard · {zone:1426} Dun Morogh
	["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "용아귀부족 야영지는 {area:1025} 바로 서쪽, 길 남쪽에 있습니다. 약탈자, 늪길잡이, 해골감시자가 있습니다. {zone:1426}에서 {npc:2092}의 퀘스트는 28레벨이 필요합니다.",
	-- {zone:1437} Wetlands
	-- plural, as words: Dragonmaw Raiders = {npc:1034} Dragonmaw Raider
	["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "{zone:1437}의 용아귀부족 야영지에서 용아귀부족 약탈자와 늪길잡이를 사냥하세요",

	-- Step 57: Hearth to Menethil
	["Hearth to Menethil"] = "메네실로 귀환",
	["For the giant crocolisks of the north coast, on your next visit"] = "북쪽 해안의 거대한 습지악어는 다음 방문 때",

	-- Step 58: Ironforge
	-- {zone:1437} Wetlands · {area:836} Dun Algaz · {zone:1432} Loch Modan · {zone:1426} Dun Morogh · {area:1537} Ironforge
	["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "{zone:1437} 길을 따라 동쪽으로 가서 남쪽으로 {area:836}을(를) 지나 {zone:1432}에 들어간 뒤, 서쪽 굴을 지나 {zone:1426}의 {area:1537}(으)로 가세요.",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, in the {object:32372}"] = "{npc:1573}, {object:32372} 안",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "{zone:1439}에서 얻은 {item:5352}이(가) 있을 때만: {npc:2786}, {object:32383}",

	-- Step 59: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "{zone:1455} 사제",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406}와(과) {npc:258785}은(는) {object:32362}의 {object:32386}에 있습니다.",

	-- Step 60: Cathedral of Light
	["Cathedral of Light"] = "빛의 대성당",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "{object:171524}에서 {area:2257}을(를) 타고 {zone:1453}의 {object:28027}(으)로 간 뒤, {object:2098}까지 걸어가세요.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, 빛의 대성당 안",
	-- {npc:1444} Brother Kristoff · {object:2098} Cathedral Square
	["{npc:1444}, in the {object:2098}"] = "{npc:1444}, {object:2098}",

	-- Step 61: Stormwind Keep
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, in the Royal Library"] = "{npc:1440}, 왕실 도서관 안",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "{zone:1431}에서 {quest:337}을(를) 획득한 경우에만",

	-- Step 62: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "빛의 대성당으로 돌아가세요. {npc:928}이(가) 안에 서 있습니다.",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "{area:271}의 {npc:2228}에게: 보관하세요",

	-- Step 63: Mage Quarter
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter
	["{object:2164} is in the {object:2101}."] = "{object:2164}은(는) {object:2101}에 있습니다.",

	-- Step 64: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959}와(과) {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, {object:2096}의 치즈 가게",

	-- Step 65: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "다음: {area:42}(으)로 날아가세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "해안을 따라 북쪽으로 {area:414}까지 가세요. {npc:3846}은(는) 해변에 진을 치고 있고, 해안에는 성난지느러미일족 나가가 가득합니다.",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009}은(는) 성난지느러미일족 경비병과 함께 {area:414}의 북쪽 끝을 돌아다닙니다.",
}
