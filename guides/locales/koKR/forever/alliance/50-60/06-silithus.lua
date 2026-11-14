-- Korean (koKR): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring
	["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452}와(과) 역병지대",
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring · {zone:1453} Stormwind · {zone:1455} Ironforge · {spell:437801} Light's Hope
	["The main route to 60: {zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands, with the hand-ins in {zone:1453}, {zone:1455} and {spell:437801} on the way."] = "60레벨까지의 주 경로: {zone:1451}, {zone:1448}, {zone:1452}와(과) 역병지대이며, 도중에 {zone:1453}, {zone:1455}, {spell:437801}에서 퀘스트를 제출합니다.",

	-- Step 1: Ratchet
	-- {area:541} Marshal's Refuge · {area:392} Ratchet
	["Fly from {area:541} to {area:392}."] = "{area:541}에서 {area:392}(으)로 비행하십시오.",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}, 내부",

	-- Step 2: Fly to Talrendis Point
	-- {area:3137} Talrendis Point
	["Fly to {area:3137}"] = "{area:3137}(으)로 날아가기",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 3: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 4: The Emerald Sanctuary
	-- {area:3137} Talrendis Point · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "{area:3137}에서 {zone:1448}(으)로 들어가세요. {area:2479}은(는) {zone:1440} 경계를 막 지난 길가의 드루이드 야영지입니다.",
	["Inside"] = "",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "{npc:9116}을(를) 잠시 기다리세요",

	-- Step 5: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "{area:1770} 화로",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws · {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Darkweavers = {npc:7118} Jaedenar Darkweaver
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "",
	["Angerclaw bears and Felpaw wolves"] = "성난발톱곰과 악령발늑대",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "",
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, in her cell; below ground"] = "",

	-- Step 6: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "",

	-- Step 8: Irontree Woods
	-- {area:1767} Irontree Woods
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper · Felpaw Ravagers = {npc:8961} Felpaw Ravager · Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north.\nCareful: Ancient Irontree Walkers, level 59 elites, stand among the treants in the middle of {area:1767}: take the Stompers on the north side (about 48,21)."] = "길을 따라 북쪽 {area:1767}(으)로 가세요. 무쇠나무 발구르미가 심장을 가지고 있습니다. 발톱은 북쪽의 성난발톱불곰과 지옥발 약탈자에게서 마저 모으세요.\n주의: 59레벨 정예인 고대 무쇠나무 파수꾼이 {area:1767} 한가운데의 나무정령 사이에 서 있습니다. 발구르미는 북쪽(약 48,21)에서 처치하세요.",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "{npc:7139}",

	-- Step 9: Arei
	-- {npc:9598} Arei · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "{npc:9598}이(가) {area:1767}에서 기다립니다. 숲 밖까지 그녀를 호위하고 살려 두세요.\n주의: 호위가 시작되고 곧 {quest:5086} 셋이 습격합니다.",

	-- Step 10: Felpaw Village
	-- {area:1769} Timbermaw Hold
	["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "북쪽으로 {area:1769} 동굴 입구 옆 마른가지일족 펄볼그 마을로 가세요.",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {zone:1452}의 {npc:9298}, 보관하세요",

	-- Step 11: A Final Blow
	-- {area:1770} Shadow Hold · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {npc:9518} Rakaiah
	["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber. The succubus {npc:9518} waits on the way, with Trey Lightforge's remains beside her.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9518} Rakaiah
	["{npc:9518}, below ground"] = "",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "",

	-- Step 12: The Emerald Sanctuary
	["Ride back south along the road to the Sanctuary."] = "길을 따라 남쪽으로 성소에 돌아가세요.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "그가 돌려주는 {item:11169}, 발톱, 심장은 보관하세요",

	-- Step 13: Forest Song
	-- {zone:1448} Felwood · {area:3137} Talrendis Point · {npc:3848} Kayneth Stillwind · {area:2358} Forest Song · {zone:1440} Ashenvale
	["Ride south out of {zone:1448} toward {area:3137}: {npc:3848}'s camp at {area:2358} is just over the {zone:1440} border, on the way."] = "{zone:1448}에서 남쪽 {area:3137} 방향으로 가십시오. {npc:3848}의 {area:2358} 야영지는 가는 길, {zone:1440} 경계 바로 너머에 있습니다.",

	-- Step 15: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "{area:442}(으)로 비행",
	-- {area:3137} Talrendis Point
	["{area:3137} flight master"] = "",

	-- Step 16: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "배를 타고 {area:150}(으)로",

	-- Step 17: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "{area:1537}(으)로 비행",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 18: Laris Geardawdle
	["Its jars are filled on the Un'Goro visit"] = "단지는 운고로 방문 때 채웁니다",

	-- Step 19: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "{area:150}(으)로 비행",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455} 비행 조련사",

	-- Step 21: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "{area:976}(으)로 날아가기",
	["Theramore flight master"] = "테라모어 섬 비행 조련사",

	-- Step 22: Gadgetzan
	-- {area:976} Gadgetzan · {quest:5801} Fire Plume Forged
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "{area:976}(으)로 날아가세요. {quest:5801}에 쓸 토륨 주괴 2개를 이곳 경매장에서 사세요.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 23: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "동쪽 언덕으로 가세요. {item:11169}을(를) 사용해 {quest:4005}을(를) 소환한 뒤 처치해 토템을 얻으세요.",

	-- Step 24: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "남서쪽으로 {area:1938}의 {npc:7771} 야영지로 가세요.",

	-- Step 26: The Slithering Scar
	-- {area:540} The Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "길을 따라 서쪽 분화구로 내려가 남쪽의 실리시드 동굴인 {area:540}으로 가세요. {npc:10041}이(가) 가장 깊은 방에서 기다립니다.",

	-- Step 27: Fire Plume Ridge
	-- {area:537} Fire Plume Ridge · {item:14644} Skeleton Key Mold · {npc:9616} Laris Geardawdle
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Empty Pure Sample Jars = {item:11953} Empty Pure Sample Jar · Primal Oozes = {npc:6557} Primal Ooze
	["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "분화구 한가운데의 {area:537}에 올라, {item:12359} 2개를 가방에 넣은 채 꼭대기 용암 호수 옆에서 {item:14644}을(를) 사용하세요. 마루 주변 웅덩이의 {npc:6557}에게 {npc:9616}의 {item:11953}을(를) 채우세요.",
	["Use the jars on slain oozes"] = "처치한 수액괴물에게 단지를 사용하세요",

	-- Step 28: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "북쪽으로 {area:541}까지 가세요. {npc:10977} 옆에서 {npc:10980}을(를) 사용하세요.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, 야영지 안쪽",
	-- {npc:10977} Quixxil · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10977} with {npc:10980}"] = "",

	-- Step 29: Fly to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Fly to {area:3425}"] = "",
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "{area:541} 비행 조련사",

	-- Step 30: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:15190} Noggle Ficklespragg · {npc:15189} Beetix Ficklespragg
	["{npc:15190}, upstairs beside {npc:15189}"] = "",

	-- Step 31: Hive'Ashi: kill these as you meet them
	-- {area:2742} Hive'Ashi
	["{area:2742}: kill these as you meet them"] = "",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "황혼의 망치단 발굴지가 북서쪽 구석을 채우고 있습니다. 서판 조각은 땅바닥에 있고, {npc:11744}와(과) {npc:11746}도 가지고 있습니다. 이교도는 누구나 {item:20404}을(를) 떨어뜨릴 수 있습니다. 20개를 보관하세요. 10개는 {npc:15306}에게, 10개는 나중에 {npc:15194}에게 줍니다.",
	["Twilight's Hammer cultists"] = "황혼의 망치단 이교도",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "{item:20378}",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "{quest:8323}에 10개 더",

	-- Step 32: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {spell:642} Divine Shield · {spell:5384} Feign Death · {spell:17} Power Word: Shield
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use {spell:642}, {spell:5384} or Vanish. Blink and {spell:17} do not drop it."] = "{npc:17080}은(는) 서쪽 벌집인 {area:2743} 바깥에 진을 치고 있습니다. 근처 붉은 간헐천에서 실리시스트를 집어 그의 야영지에 있는 얼라이언스 추출기로 가져가세요.\n주의: 탈것을 타거나, 은신하거나, {spell:642}, {spell:5384}, 소멸을 사용하면 실리시스트를 잃습니다. 점멸과 {spell:17}은(는) 떨어뜨리지 않습니다.",

	-- Step 34: Southwind Village
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "동쪽으로 {area:2738}의 폐허로 가세요. {object:179565}은(는) 무너진 건물 사이에 있으며 {npc:12179}이(가) 지키고 있습니다.",
	-- {object:179565} Dusty Reliquary
	["{object:179565}; inside"] = "",

	-- Step 35: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "은둔자는 {area:2738} 남동쪽 바위 사이에 숨어 있습니다.",
	["Below ground"] = "지하",

	-- Step 36: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "브론즈비어드 야영지",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand south-east of the camp, where Deathclasp, an elite scorpid, patrols: grab it while he is away."] = "남서쪽으로 남쪽 산맥 근처의 드워프 야영지에 가서 {npc:15171}와(과) {npc:15170}에게 물어보세요. {npc:15190}의 가방은 야영지 남동쪽 모래 속에 있는데, 그곳에는 정예 전갈 Deathclasp이(가) 순찰합니다. 그가 자리를 비운 사이에 챙기세요.",

	-- Step 37: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803}이(가) 맨 남서쪽의 이교도 야영지를 지킵니다.",

	-- Step 38: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp."] = "서쪽을 따라 북쪽으로 메이나의 작은 야영지에 가세요.",

	-- Step 39: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}."] = "하분스의 야영지는 {area:3425} 바로 서쪽에 있습니다.",

	-- Step 40: Hermit Ortell
	["Ride back south-east to the hermit."] = "남동쪽으로 은둔자에게 돌아가세요.",
	["Hand him the ten texts you kept"] = "보관해 둔 문서 10개를 그에게 건네세요",

	-- Step 41: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 42: Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}."] = "{area:976}(으)로 날아가세요.",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{zone:1457}의 {npc:7740}: 보관하세요",

	-- Step 43: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976} 비행 조련사",

	-- Step 46: Starfall Village
	-- {area:2253} Starfall Village
	["Ride north-west up the road to {area:2253}."] = "길을 따라 북서쪽 {area:2253}(으)로 가세요.",

	-- Step 48: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "{npc:10301}의 야영지",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride back east past {area:2255} and south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "",

	-- Step 49: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "{npc:10301}의 보급품",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "마차 주변의 보급품을 줍고, 근처 올빼미야수에게서 {npc:10301}의 목걸이를 되찾으세요.",

	-- Step 50: Ranshalla
	-- {npc:10300} Ranshalla · {area:2250} Owl Wing Thicket · {area:2255} Everlook · {object:177404} Altar of Elune
	["{npc:10300} waits at {area:2250}, south of {area:2255}.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "{npc:10300}이(가) {area:2255} 남쪽 {area:2250}에서 기다립니다.\n{npc:10300}이(가) {object:177404}(으)로 가는 길에 횃불을 켜는 동안 그녀를 보호하세요.",

	-- Step 51: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "{npc:9298}의 안내를 따라 서리망치거인들을 지나 {area:2256} 입구로 가세요. 거인은 하나씩 지나가세요.",

	-- Step 52: Starfall Village
	-- {area:2255} Everlook · {area:2253} Starfall Village
	["Ride north up the valley, past {area:2255}, to {area:2253}."] = "",

	-- Step 54: Felwood
	-- {quest:5086} Toxic Horrors
	["The {quest:5086}"] = "",

	-- Step 55: Toxic Horrors
	-- {quest:5086} Toxic Horrors
	-- plural, as words: Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "주의: 59레벨 정예 Ancient Irontree Walker가 {quest:5086} 사이에 서 있습니다. 야영지 북동쪽 끝(약 50.6,22.4)의 소산물을 하나씩 처치하고, 끌어오기 전마다 보행자가 있는지 살피십시오.",

	-- Step 56: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["{npc:11558} stands just inside the {area:1769} cave: she speaks to you from Neutral with the Timbermaw, which the Winterfall furbolgs you ground in {zone:1452} brought you to."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}, just inside the cave: walks around here: look inside the circle on the map"] = "{npc:11558}, 동굴 바로 안쪽: 이 주변을 돌아다닙니다. 지도의 원 안을 살펴보세요",

	-- Step 57: Kernda
	-- {area:1762} Felpaw Village · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "",

	-- Step 58: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth · {zone:1452} Winterspring
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw: the {zone:1452} top-up on the Winterfall furbolgs gets you both."] = "",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "",

	-- Step 62: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "",
	-- {spell:5384} Feign Death
	["The western Winterfall furbolgs drop the beads.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "",

	-- Step 66: Umber
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {area:493} Moonglade · {area:2361} Nighthaven · {npc:11939} Umber
	["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "{npc:9298} 서쪽의 {zone:1452} 쪽 입구에서 {area:1769} 터널을 타고 {area:493} 갈림길을 따라 {area:2361}(으)로 가세요. {npc:11939}은(는) 호숫가에서 연구 중입니다.",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "",

	-- Step 67: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {npc:11939} Umber
	["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "{npc:11801}의 집은 {area:2361}, {npc:11939}의 동쪽에 있습니다.",

	-- Step 69: Nighthaven
	-- {area:2361} Nighthaven
	["Learn the flight path in {area:2361}."] = "",

	-- Step 70: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",

	-- Step 71: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:7916} Erelas Ambersky
	["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "",

	-- Step 73: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "차원문을 타고 {zone:1457}(으)로 올라가세요.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}, 달의 신전 안",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155}, 은행 안",

	-- Step 75: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, atop the {area:1658}"] = "{npc:3516}, {area:1658} 꼭대기",

	-- Step 76: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "{zone:1438}행 차원문",

	-- Step 77: Fly to Auberdine
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702} 비행 조련사",

	-- Step 79: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "{zone:1453}로 비행",

	-- Step 80: Stormwind
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, 운하를 걸어다님",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "{npc:10778}에게 줄 것: 보관하세요",

	-- Step 81: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, SI:7 안",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{area:3197}의 {quest:6184}: 보관하세요",

	-- Step 82: Stormwind
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, {object:2096} 안",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "",

	-- Step 83: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 84: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453}에는 주술사 상급자가 없습니다",

	-- Step 85: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "{area:271}(으)로 날아가세요",

	-- Step 89: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852}은(는) 61레벨 정예입니다",
	-- {quest:6184} Flint Shadowmore · {area:2260} Marris Stead · {zone:1423} Eastern Plaguelands
	["{quest:6184}: the agents' remains lie at the {area:2260} in the {zone:1423}"] = "",

	-- Step 90: Andorhal
	["Andorhal"] = "안돌할",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667}은(는) 야영지 북쪽의 폐허 도시 안돌할 서쪽, 무너진 여관에서 기다립니다. {npc:1852}은(는) 마을 한가운데에서 성물함을 지킵니다.",
	["Araj is elite: grouping up is advised."] = "아라즈는 정예이니 파티를 권합니다.",

	-- Step 91: Felstone Field
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "{npc:10778}의 유령은 안돌할 서쪽 {area:199}의 농가 옆을 떠돕니다. 들판의 {npc:10801}이(가) 부적의 나머지 반쪽을 가지고 있습니다. 두 반쪽을 합치세요.",
	["Upstairs"] = "위층",

	-- Step 92: Northridge Lumber Camp
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "길을 따라 북쪽의 제재소로 가서 한가운데에 흰개미 통을 내려놓으세요.",

	-- Step 93: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855}(선택)",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855}은(는) 벌목지 북동쪽, 경계 강가의 작은 오두막에 삽니다. {quest:5781}을(를) 완료했다면 제출하세요.",

	-- Step 94: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "",

	-- Step 95: Of Lost Honor
	["Underwater"] = "물속",

	-- Step 96: Light's Hope Chapel
	["Ride south-east from the lake to the chapel."] = "호수에서 남동쪽 예배당으로 가십시오.",
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, keep it"] = "예배당 남쪽 무덤 옆의 {npc:11038}: {npc:11140}은(는) {area:2627}에 있습니다. 보관하십시오",

	-- Step 97: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "스컬지 용사",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "{npc:8529}(59)은(는) {area:2268} 북쪽 {area:2270}을(를) 돌아다닙니다. 처치할 때마다 {npc:11063}의 {item:13156}을(를) 갖다 대세요. 공명하는 해골이 그가 원하는 것입니다. 하나씩 끌어오세요.",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}, {npc:8529}에게서",

	-- Step 98: Light's Hope Chapel
	-- {npc:10667} Chromie
	["{npc:10667} in Andorhal: keep it"] = "안돌할의 {npc:10667}: 보관하세요",

	-- Step 99: Infiltrator Hameya
	-- {area:2277} Plaguewood · {area:2273} Zul'Mashar
	["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "북쪽 {area:2277}의 북동쪽 가장자리로 가십시오.\n주의: {area:2273}(으)로 가는 길의 트롤은 57-59레벨입니다. 생명력이 낮아지면 도망쳐 도움을 청하므로 종종 다른 몹을 끌고 옵니다.",

	-- Step 100: Tirion Fordring
	-- {quest:5845} Of Lost Honor
	["{quest:5845}: the route takes it and fetches the Symbol, so its hand-in holds"] = "{quest:5845}: 경로에서 이 퀘스트를 받고 상징을 가져오므로 제출이 유지됩니다",

	-- Step 101: Egan
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {npc:11140} Egan
	["Cross the river east of {npc:1855}'s hut into {area:2627}: {npc:11140} stands by Augustus' ruined hut."] = "{npc:1855}의 오두막 동쪽의 강을 건너 {area:2627}에 들어가세요. {npc:11140}은(는) 아우구스투스의 폐허가 된 오두막 옆에 서 있습니다.",

	-- Step 102: Level 59.85
	["Level 59.85"] = "",
	-- {npc:11140} Egan · {area:2627} Terrordale · {area:2261} Undercroft · {area:2298} Caer Darrow · {npc:10667} Chromie · {area:3197} Chillwind Camp · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["The Terrordale Spirits haunt the woods around {npc:11140}. Top up here to level 59.85 while you stand in {area:2627}: the hand-ins still to come (the {area:2261}, {area:2298}, {npc:10667} and {area:3197}) take you to level 60. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:14564} Terrordale Spirit · {area:2627} Terrordale · {zone:1423} Eastern Plaguelands
	["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "{zone:1423} {area:2627}에서 {npc:14564} 사냥",

	-- Step 103: Marris Stead
	-- {area:2260} Marris Stead · {area:2262} Darrowshire · {npc:11878} Nathanos Blightcaller
	["Ride south to the {area:2260}, the farm north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it. Coming close enough to see the Blightcaller in front of the house completes the scouting.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "",

	-- Step 104: Undercroft
	-- {area:2261} Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "남서쪽 {area:2261}(으)로 가십시오. 흙더미는 안에 있습니다. {npc:11886}은(는) 정예이므로 파티를 권장합니다.\n주의: 머큐시오와 함께 정예가 아닌 몹 약 넷이 나옵니다. 그 자리에 나타나지 않고 무덤까지 걸어옵니다.",

	-- Step 106: Chromie
	-- {npc:10667} Chromie · {area:3197} Chillwind Camp
	["{npc:10667} waits upstairs in the ruined inn on the west side of Andorhal, on the way back to {area:3197}."] = "{npc:10667}은(는) {area:3197}(으)로 돌아가는 길, 안돌할 서쪽의 폐허가 된 여관 위층에서 기다립니다.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "",

	-- Step 108: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Ride back south-west to {area:3197}."] = "남서쪽으로 {area:3197}에 돌아가세요.",
	-- {zone:1453} Stormwind
	["Flint's next task goes to {zone:1453}: you are level 60 now, skip it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "다시 {area:1770}(으)로: 가장 깊은 방에서 {npc:9861}와(과) {npc:9860}이(가) {npc:9517}을(를) 지킵니다.",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "{npc:11741}은(는) 돌아가는 길의 {area:2743}와(과) {area:3425} 사이 모래언덕을 돌아다닙니다. {npc:15181}은(는) 58레벨부터 {quest:8304}을(를) 줍니다.",
	-- ["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "{area:16}의 {area:3137}(으)로 날아간 뒤 길을 따라 서쪽으로 {zone:1440} 경계를 막 넘은 {area:2358}까지 가세요.",
	-- ["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "{zone:1447}의 {area:3137}(으)로 날아간 뒤 길을 따라 서쪽으로 {zone:1440} 경계를 막 넘은 {area:2358}까지 가세요.",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "고개에서 길을 따라 남서쪽 {area:3425}(으)로 가세요.",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "{area:702}(으)로 내려가 배를 타고 {area:442}(으)로, 다시 배를 타고 {area:17203}(으)로 가세요. {npc:14722}에게 줄 비단 옷감 60장, 마법 옷감 60장, {item:14047} 60장을 가져가세요. 부족한 것은 경매장에서 사세요.",
	-- ["Grind to 58"] = "58레벨까지 사냥",
	-- ["Grind to 59"] = "59레벨까지 사냥",
	-- ["Grind to 60"] = "60레벨까지 사냥",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "{area:1519}(으)로 귀환해 60레벨 주문을 배우세요. 레벨업 경로는 여기서 끝납니다. 다음으로 평판과 던전 가이드를 보세요.",
	-- ["Into {zone:1451}"] = "{zone:1451}(으)로",
	-- ["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "길을 따라 계속 서쪽으로 온천 옆 {npc:9298}의 야영지로 가세요.",
	-- ["Level 60"] = "60레벨",
	-- ["Ride back to {area:3137} and fly to {area:2255}."] = "{area:3137}(으)로 돌아가 {area:2255}(으)로 날아가세요.",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "분화구 북쪽 벽을 따라 서쪽으로 가서, 북서쪽 구석의 {zone:1451}(으)로 올라가는 고개로 가세요.",
	-- ["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "파티라면 사냥 대신 {area:2057}({area:28} 남동쪽 {area:2298})이나 {area:2279}을(를) 도는 편이 더 빠릅니다. 혼자 사냥하려면 이 단계를 건너뛰세요.",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "파티라면 사냥 대신 {area:2057}({zone:1422} 남동쪽 {area:2298})이나 {area:2279}을(를) 도는 편이 더 빠릅니다. 혼자 사냥하려면 이 단계를 건너뛰세요.",
	-- ["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "파티라면 사냥 대신 {zone:1444}의 {area:2577}을(를) 도는 편이 더 빠릅니다. 혼자 사냥하려면 이 단계를 건너뛰세요.",
	-- ["Shaman training"] = "주술사 수련",
	-- ["Take the boat from {area:442} to {area:702}."] = "{area:442}에서 배를 타고 {area:702}(으)로 가세요.",
	-- ["Take the flight path in {area:2361} and fly to {area:442}."] = "{area:2361}에서 비행 경로를 타고 {area:442}(으)로 날아가세요.",
	-- ["Take the {area:1769} tunnel from its {area:618} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "{npc:9298} 서쪽의 {area:618} 쪽 입구에서 {area:1769} 터널을 타고 {area:493} 갈림길을 따라 {area:2361}(으)로 가세요. {npc:11939}은(는) 호숫가에서 연구 중입니다.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "{area:2257}을(를) 타고 {zone:1455}(으)로 가세요. {npc:14724}와(과) {npc:14723}은(는) 각각 양모 옷감 60장, 비단 옷감 60장, 마법 옷감 60장, 그다음 {item:14047} 60장을 원합니다. 종류별로 총 120장이며, 가방에 있는 것이나 경매장에서 구하세요.",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "{npc:7446} 곰은 {area:2250} 남쪽의 눈 덮인 골짜기를 돌아다닙니다.",
	-- ["Toward the north-west pass"] = "북서쪽 고개 방향",
	-- ["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "이전 가이드에서 귀환석으로 돌아온 {area:392}에서 시작합니다. {area:415}(으)로 날아가세요.",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "{zone:1451} {area:2743} 동쪽 모래언덕에서 {npc:11741} 사냥",
	-- ["grind on {npc:14564} at {area:2627}, {area:139}"] = "{area:139} {area:2627}에서 {npc:14564} 사냥",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "{zone:1452} {area:2250} 남쪽 골짜기에서 {npc:7446} 사냥",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770}은(는) 길 서쪽 {area:1763} 안쪽의 동굴입니다. 안에 있는 화로 네 개에 {item:12906}을(를) 사용하세요. 지나가며 만나는 성난발톱곰과 악령발늑대를 처치해 {item:11172}을(를) 모으세요.",
	-- ["{area:2057} (optional)"] = "{area:2057}(선택)",
	-- ["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057}은(는) 58-60레벨에 맞습니다. {quest:5505}은(는) 아래 {area:3197}에서 제출합니다.",
	-- ["{area:2577} (optional)"] = "{area:2577}(선택)",
	-- ["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577}은(는) 55-60레벨에 맞습니다. 아래의 {npc:7446} 사냥만으로도 혼자 59레벨까지 오를 수 있습니다.",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}: {zone:1452}에서 끝납니다, 보관하세요",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, {quest:6031} 30장이 있다면",
	-- ["{npc:15174}, the innkeeper"] = "여관주인 {npc:15174}",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, 얼라이언스 천막",
	-- ["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791}: 이전 가이드가 귀환석으로 이곳에 데려오므로 보통 바로 완료됩니다",
	-- ["{object:176091}, if you found the Firewater flask in {area:618}"] = "{object:176091}, {area:618}에서 화주 병을 찾았다면",
	-- ["{quest:5085}: {npc:9298} in {area:618}, keep it"] = "{quest:5085}: {area:618}의 {npc:9298}, 보관하세요",
	-- ["{zone:1451}, {area:361}, {area:618} & the Plaguelands"] = "{zone:1451}, {area:361}, {area:618}와(과) 역병지대",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453}에는 주술사 상급자가 없습니다. {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가서 {npc:258098}에게 60레벨 주문을 배우세요.",
}
