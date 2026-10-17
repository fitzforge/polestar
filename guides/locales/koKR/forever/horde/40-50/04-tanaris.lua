-- Korean (koKR): the guide forever/horde/40-50/04-tanaris (forever/horde/40-50/04-tanaris.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "{area:976}(으)로 날아가기",
	-- {area:1099} Camp Mojache
	["From {area:1099}'s flight master."] = "{area:1099}의 비행 조련사에게서",

	-- Step 2: Gadgetzan
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "윈드라이더 조련사 옆의 {npc:7876}",
	-- {object:150075} Wanted Poster
	["the {object:150075} in the square"] = "광장의 {object:150075}",

	-- Step 3: Sandsorrow Watch
	-- {item:8584} Untapped Dowsing Widget
	["West of Gadgetzan, use the {item:8584} beside the water hole in the troll camp."] = "가젯잔 서쪽, 트롤 야영지의 물웅덩이 옆에서 {item:8584}을(를) 사용하세요.",

	-- Step 5: Caliph Scorpidsting
	-- {npc:7847} Caliph Scorpidsting
	["South-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp."] = "가젯잔 남동쪽 모래언덕에 사막유랑단 약탈자가 야영하고 있습니다. {npc:7847}은(는) 동쪽 야영지에 서 있습니다.",

	-- Step 6: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:9978} Gahz'ridian Detector · {area:983} Dunemaul Compound
	["West along the road south; {npc:7771} camps by the ruins at the {area:1938}. Put on his {item:9978}: it shows the buried ornaments, here and around the {area:983}."] = "길을 따라 서쪽으로, 남쪽 방향으로 가세요. {npc:7771}은(는) {area:1938}의 폐허 옆에 야영하고 있습니다. 그의 {item:9978}을(를) 착용하면 이곳과 {area:983} 주변에 묻힌 장식품이 보입니다.",

	-- Step 7: The Noxious Lair
	["West, the Centipaar insects swarm around their hives; any of them drops the parts."] = "서쪽에서는 센티파르 곤충이 벌집 주변에 몰려 있습니다. 누구나 부품을 떨어뜨립니다.",

	-- Step 8: Dunemaul Compound
	-- {area:982} The Noxious Lair · {npc:12046} Gor'marok the Ravager · {quest:3161} Gahz'ridian
	["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "{area:982} 남쪽에서 모래망치 오우거가 거주지를 차지하고 있으며, 동쪽 끝에 {npc:12046}이(가) 있습니다. 싸우는 사이사이에 {quest:3161} 장식품을 파내세요.",

	-- Step 9: Thistleshrub Valley
	-- {zone:1446} Tanaris
	["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one."] = "거주지 서쪽 골짜기에는 선인장 괴물이 가득합니다. 이슬먹는 덤불나무괴물만 이슬샘을 지니고 있습니다. {zone:1446}의 몬스터 대부분이 드물게 OOX-17/TN 조난 탐지기를 떨어뜨릴 수 있습니다. 얻으면 보관하세요.",
	-- {item:8623} OOX-17/TN Distress Beacon
	["{item:8623}, a rare drop"] = "드물게 떨어지는 {item:8623}",

	-- Step 10: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "{npc:5955} 호위",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port · {npc:8579} Yeh'kinya
	["{npc:5955} waits in the valley. Walk him all the way to his wife {npc:6015} in {area:977}, north-east across the desert: stay close, slow down for him and fight off what attacks him. Do not mount or hearth out of his reach. {npc:8579} stands in the port too."] = "{npc:5955}은(는) 골짜기에서 기다립니다. 사막을 가로질러 북동쪽 {area:977}에 있는 그의 아내 {npc:6015}에게까지 데려가세요. 가까이 붙어 그의 속도에 맞추고, 그를 공격하는 적을 물리치세요. 그에게서 멀리 떨어진 채 탈것에 오르거나 귀환석을 쓰지 마세요. {npc:8579}도 항구에 있습니다.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan
	["Ride south-west to {area:976}."] = "남서쪽의 {area:976}(으)로 가세요.",
	-- {item:8526} Violet Tragan · {zone:1425} Hinterlands
	["the {item:8526} grows in the {zone:1425}, around level 48"] = "{item:8526}은(는) 48레벨쯤 {zone:1425}에서 자랍니다",

	-- Step 12: Marvon Rivetseeker
	["South down the road again."] = "다시 길을 따라 남쪽으로 가세요.",

	-- Step 13: Scrimshank's gear
	["Scrimshank's gear"] = "스크림섕크의 장비",
	["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive."] = "더 남쪽, 센티파르 벌집 입구에 견습 측량사 스크림섕크의 장비가 있습니다.",

	-- Step 14: OOX-17/TN
	["OOX-17/TN"] = "OOX-17/TN",
	-- {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}."] = "조난 탐지기가 있을 때만: OOX-17/TN은 스크림섕크의 벌집 남동쪽에 있습니다. 북쪽 {area:977}까지 호위하세요. 보상은 {area:35}의 오글소프에게서 받습니다.",

	-- Step 15: Gadgetzan
	-- {npc:7010} Zilzibin Drumlore · {area:1637} Orgrimmar
	["for {npc:7010} in {area:1637}, around level 50"] = "50레벨쯤 {area:1637}의 {npc:7010}에게",

	-- Step 16: Orgrimmar
	-- {area:1637} Orgrimmar · {zone:1458} Undercity · {area:392} Ratchet
	["Fly to {area:1637} and train: the next guide's training stop is the {zone:1458}, which has no Hunter or Shaman trainer. Then fly to {area:392}."] = "{area:1637}(으)로 날아가 기술을 배우세요. 다음 가이드에서 기술을 배울 곳은 {zone:1458}인데, 그곳에는 사냥꾼과 주술사 상급자가 없습니다. 그다음 {area:392}(으)로 날아가세요.",

	-- Step 17: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:392} Ratchet
	["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:392}."] = "{area:1638}(으)로 날아가 {area:1639}의 {npc:3033}에게서 기술을 배운 뒤, {area:392}(으)로 날아가세요.",

	-- Step 18: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "{area:392}(으)로 날아가기",

	-- Step 19: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "{area:35}행 배",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["The boat to {area:35} docks at {area:392}'s pier, below the flight master's hill."] = "{area:35}행 배는 비행 조련사가 있는 언덕 아래, {area:392} 부두에 정박합니다.",
	-- {area:392} Ratchet
	["{area:392} pier"] = "{area:392} 부두",

	-- Step 20: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "{area:340}(으)로 날아가기",
	-- {area:35} Booty Bay
	["From the {area:35} flight master, above the harbour."] = "항구 위쪽, {area:35}의 비행 조련사에게서",

	-- Step 21: The Grimesilt Dig Site
	-- {area:247} Grimesilt Dig Site
	["The {area:247}"] = "{area:247}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {object:173265} Wooden Outhouse · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "{area:340} 서쪽의 고갯길로 {zone:1427}에 들어간 뒤 남서쪽의 발굴지로 가세요. {object:173265}은(는) 발굴지 남쪽 끝에 있고, 검은무쇠단 지질학자는 그 바로 북쪽에서 땅을 팝니다. {item:4306} 15개를 가져오세요(경매장에서 팝니다).",
	-- {object:173265} Wooden Outhouse
	["the {object:173265}"] = "{object:173265}",

	-- Step 22: Thorium Point
	-- {area:1446} Thorium Point
	["Ride north-west across the gorge; {area:1446} is the scaffolded camp in the north-west."] = "북서쪽으로 협곡을 가로지르세요. {area:1446}은(는) 북서쪽의 비계를 두른 야영지입니다.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "{object:179827} 게시판",

	-- Step 23: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "칼라란은 {area:1446} 남쪽, 용광로 가장자리에 홀로 서 있습니다. 그의 이야기를 들으세요.",

	-- Step 24: The Cauldron
	-- {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Blazing Elementals = {npc:5850} Blazing Elemental · Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster
	["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "육중한 전투골렘이 칼라란 아래 용광로를 순찰하며 기름을 떨어뜨리고, 그 사이를 떠다니는 용암 정령과 이글거리는 정령이 심장을 떨어뜨립니다. 검은무쇠단 감독관과 노예상인이 길에서 노예를 부립니다. 노예상인이 {item:11818}을(를) 떨어뜨릴 수 있습니다. 보관하세요.",
	-- {item:11818} Grimesilt Outhouse Key
	["{item:11818}, a rare drop"] = "드물게 떨어지는 {item:11818}",

	-- Step 26: The Steamsmiths' furnaces
	["The Steamsmiths' furnaces"] = "증기기술자의 용광로",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith
	["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "검은무쇠단 증기기술자는 용광로 한가운데의 화로에서 일합니다. 절반은 {item:10551}을(를), 열 명 중 한 명은 {item:18959}을(를) 지니고 있습니다. 노예, 노예상인, 감독관도 단검을 지니고 있습니다.",

	-- Step 27: Kalaran Windblade
	-- {item:10552} Symbol of Ragnaros
	["His next request needs the {item:10552} from elite cultists: leave it."] = "그의 다음 요청에는 정예 이교도가 지닌 {item:10552}이(가) 필요합니다. 받지 마세요.",

	-- Step 28: The Slag Pit
	-- {area:1443} The Slag Pit
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge."] = "{area:1443}은(는) 용광로 북쪽에 있습니다. 인센도사우루스가 용암 웅덩이에서 헤엄칩니다. 가장자리로 끌어오세요. 비밀 설계도는 구덩이 위쪽 바위 턱에 있습니다.",

	-- Step 29: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "거대한 용암거미",
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["The Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge."] = "거대한 용암거미는 협곡 남서쪽의 고원과 용암 웅덩이를 돌아다닙니다.",

	-- Step 30: Dark Iron Lookouts
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["Dark Iron Lookouts"] = "검은무쇠단 망꾼",
	-- {item:18960} Lookout's Spyglass
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "검은무쇠단 망꾼은 용광로 남쪽 감시탑 주변 능선에 서 있습니다. 열 명 중 한 명 정도가 {item:18960}을(를) 지니고 있습니다.",

	-- Step 31: The Key to Freedom
	-- {item:11818} Grimesilt Outhouse Key · {object:173265} Wooden Outhouse
	["Only with the {item:11818}: back east to the {object:173265} at the dig site."] = "{item:11818}이(가) 있을 때만: 동쪽 발굴지의 {object:173265}(으)로 돌아가세요.",

	-- Step 32: Thorium Point
	-- {area:1446} Thorium Point · {area:75} Stonard
	["Ride back north to {area:1446}. Stay here: the next guide starts with the flight to {area:75}."] = "북쪽의 {area:1446}(으)로 돌아가세요. 여기 머무르세요. 다음 가이드는 {area:75}행 비행으로 시작합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "{area:982} 남쪽에서 모래망치 오우거가 거주지를 차지하고 있으며, 동쪽 끝에 {npc:12046}이(가) 있습니다. 싸우는 사이사이에 {quest:3161} 장식품을 파내세요.",
}
