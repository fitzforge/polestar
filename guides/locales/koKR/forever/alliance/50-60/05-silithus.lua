-- Korean (koKR): the guide forever/alliance/50-60/05-silithus (forever/alliance/50-60/05-silithus.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Gadgetzan
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["From {area:392}, fly to {area:976}."] = "{area:392}에서 {area:976}(으)로 날아가세요.",
	-- {area:3197} Chillwind Camp
	["For {area:3197}: keep it"] = "{area:3197}에 쓸 것: 보관하세요",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "{npc:7583}에게",

	-- Step 2: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299}은(는) 마을 바로 동쪽 묘지에서 기다리며, 묘비는 그 근처에 서 있습니다.",

	-- Step 3: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "남서쪽으로 {area:1938}의 {npc:7771} 야영지로 가세요.",
	-- {quest:3444} The Stone Circle · {area:392} Ratchet
	["{quest:3444} is in {area:392}"] = "{quest:3444}은(는) {area:392}에 있습니다",

	-- Step 4: Linken
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:8737} Linken · {area:538} Lakkari Tar Pits · {npc:9117} J.D. Collie
	["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it."] = "{area:976}에서 {area:541}(으)로 날아가세요. {npc:8737}의 오두막은 야영지 서쪽 {area:538}에 있고, {npc:9117}은(는) 그 뒤 언덕 위에 있습니다.",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "{zone:1448}에 쓸 것: 보관하세요",

	-- Step 5: The crater
	["The crater"] = "분화구",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}."] = "{npc:6517}은(는) {area:538}에서 뒹굴고, 한가운데 {area:537}의 불의 정령이 재를, 남쪽 {area:540}의 고리쉬 말벌이 분비샘을 가지고 있습니다. 분화구의 모든 생물이 {item:11018}을(를) 떨어뜨릴 수 있습니다.",

	-- Step 6: Cenarion Hold
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["Ride out of the crater's north-western pass into {zone:1451} and on to {area:3425}."] = "분화구 북서쪽 고개로 나가 {zone:1451}에 들어가 {area:3425}까지 가세요.",

	-- Step 7: Dredge and scorpids
	["Dredge and scorpids"] = "미늘벌레와 전갈",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "{npc:11740}은(는) 요새 북서쪽 모래언덕을 파고, {npc:11735}와(과) {npc:11738}은(는) 사방을 돌아다닙니다.",

	-- Step 9: The western dunes
	["The western dunes"] = "서쪽 모래언덕",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "{npc:11741}은(는) 더 서쪽을 파고, {npc:11736}, 돌꼬리채찍전갈, {npc:11739}이(가) 같은 모래밭에서 사냥합니다.",

	-- Step 11: Layo Starstrike
	-- {npc:13220} Layo Starstrike
	["Ride east to {npc:13220}."] = "동쪽으로 {npc:13220}에게 가세요.",

	-- Step 12: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "고통받는 드루이드와 고통받는 파수꾼이 {npc:13220} 남서쪽의 폐허가 된 마을을 떠돕니다.",

	-- Step 14: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "{area:2742} 탑",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "동쪽으로 {area:2738}의 {area:2742} 탑으로 가세요. 탑에 올라 딱딱한 실리시드 조각을 노리고 나타나는 잠복꾼을 처치하세요.",

	-- Step 15: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "{zone:1450}의 움버: 보관하세요",

	-- Step 16: Ratchet
	-- {area:3425} Cenarion Hold · {area:392} Ratchet
	["Ride back to {area:3425} and fly to {area:392}."] = "{area:3425}(으)로 돌아가 {area:392}(으)로 날아가세요.",

	-- Step 17: Stormwind City
	-- {area:392} Ratchet · {area:35} Booty Bay · {zone:1453} Stormwind City
	["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "{area:392}에서 배를 타고 {area:35}(으)로 간 뒤 {zone:1453}로 날아가세요.",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, 운하를 걸어다님",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "{npc:10778}에게 줄 것: 보관하세요",
	-- {item:2592} Wool Cloth
	["Sixty {item:2592}, if you carry them"] = "{item:2592} 60장, 가지고 있다면",

	-- Step 18: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, SI:7 안",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{area:3197}의 {quest:6184}: 보관하세요",

	-- Step 19: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge
	["Take the {area:2257} to {zone:1455}."] = "{area:2257}을(를) 타고 {zone:1455}(으)로 가세요.",
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, by the tram"] = "{npc:14724}, 지하철 옆",
	["Its jars are filled on the next Un'Goro visit"] = "단지는 다음 운고로 방문 때 채웁니다",

	-- Step 20: Lieutenant Haggerdin
	-- {area:271} Southshore · {area:1056} Darrow Hill
	["Fly to {area:271} and ride north up the road toward Alterac: Haggerdin camps at {area:1056} beside it."] = "{area:271}(으)로 날아가 길을 따라 북쪽 알터랙 쪽으로 가세요. 해거딘은 길 옆 {area:1056}에 진을 치고 있습니다.",

	-- Step 21: Light's Hope Chapel
	-- {area:3197} Chillwind Camp · {area:2268} Light's Hope Chapel
	["Ride on north to {area:3197} and fly to {area:2268}."] = "계속 북쪽으로 {area:3197}까지 가서 {area:2268}(으)로 날아가세요.",

	-- Step 22: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "{npc:8529}",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "{npc:8529}(59)은(는) {area:2268} 북쪽 {area:2270}을(를) 돌아다닙니다. 처치할 때마다 {npc:11063}의 {item:13156}을(를) 갖다 대세요. 공명하는 해골이 그가 원하는 것입니다. 하나씩 끌어오세요.",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}, {npc:8529}에게서",

	-- Step 23: Light's Hope Chapel
	["Chromie in Andorhal: keep it"] = "안돌할의 크로미: 보관하세요",

	-- Step 24: Infiltrator Hameya
	-- {area:2277} Plaguewood
	["Ride north to the {area:2277}'s north-eastern edge."] = "북쪽으로 {area:2277}의 북동쪽 끝까지 가세요.",

	-- Step 25: The Undercroft
	-- {area:2261} The Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "남서쪽으로 {area:2261}까지 가세요. 흙더미는 안쪽에 있습니다. {npc:11886}은(는) 정예이니 파티를 권합니다.",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886}"] = "{item:14613}, {npc:11886}에게서",

	-- Step 26: The Fungal Vale
	-- {npc:8532} Diseased Flayer · {area:2258} The Fungal Vale · {zone:1423} Eastern Plaguelands
	["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "{zone:1423} {area:2258}에서 {npc:8532} 사냥",

	-- Step 27: Ratchet
	-- {area:392} Ratchet
	["The next guide starts here in {area:392}."] = "다음 가이드는 여기 {area:392}에서 시작합니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "남서쪽으로 {area:2261}까지 가세요. 흙더미는 안쪽에 있습니다. {npc:11886}은(는) 정예이니 파티를 권합니다.",
	-- ["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "{area:392}에서 배를 타고 {area:35}(으)로 간 뒤 {zone:1453}(으)로 날아가세요.",
	-- ["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "{zone:1423} {area:2258}에서 {npc:8532} 사냥",
}
