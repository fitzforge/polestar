-- Korean (koKR): the guide forever/horde/orc/01-durotar (forever/horde/orc/01-durotar.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143}은(는) {npc:10176} 바로 서쪽 건물인 동굴 막사 안에서 기다립니다.",
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}, 시작 지점",
	["Inside"] = "",

	-- Step 2: Training weapons and boars
	["Training weapons and boars"] = "훈련용 무기와 멧돼지",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "무기는 동굴 막사와 훈련장 주변에 있고, {npc:3098}은(는) 골짜기 바닥 전체를 돌아다닙니다.",

	-- Step 3: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143}은(는) 동굴 입구 바로 안쪽에, {npc:3159}은(는) 그 뒤 동굴 안쪽에 서 있습니다.",
	-- {npc:3143} Gornek
	["{npc:3143}, inside"] = "",
	-- {npc:3156} Nartok
	["{npc:3156}, the warlock trainer at the back of the cave"] = "{npc:3156}, 동굴 안쪽의 흑마법사 상급자",
	-- {npc:3155} Rwag
	["{npc:3155}, the rogue trainer in the Den"] = "{npc:3155}, 동굴 막사의 도적 상급자",
	-- {npc:3153} Frang
	["{npc:3153}, the warrior trainer beside the Den"] = "{npc:3153}, 동굴 막사 옆의 전사 상급자",
	-- {npc:3154} Jen'shan
	["{npc:3154}, the hunter trainer beside the Den"] = "{npc:3154}, 동굴 막사 옆의 사냥꾼 상급자",
	-- {npc:3157} Shikrik
	["{npc:3157}, the shaman trainer beside the Den"] = "{npc:3157}, 동굴 막사 옆의 주술사 상급자",
	-- {npc:5884} Mai'ah
	["{npc:5884}, the mage trainer, at the entrance to the Den"] = "{npc:5884}, 동굴 막사 입구의 마법사 상급자",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave; below ground"] = "",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}, 요리용 모닥불 옆",

	-- Step 4: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287}은(는) 동굴 막사 북서쪽 언덕 기슭에 부상당한 채 누워 있습니다.",

	-- Step 5: Valley of Trials: kill these as you meet them
	-- {area:363} Valley of Trials
	["{area:363}: kill these as you meet them"] = "",
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua · {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["{quest:790}, a large scorpid, prowls the slope south of {npc:3287} among the Scorpid Workers; pick the Cactus Apples by the cactuses on the way.\nThe {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "",

	-- Step 6: Class trainer
	["Class trainer"] = "직업 전문가",

	-- Step 7: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:363} Valley of Trials
	["{npc:246344} in {zone:1456}; {area:363} has no paladin trainer"] = "",

	-- Step 8: Druid trainer
	["Druid trainer"] = "",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:363} Valley of Trials
	["{npc:3034} in {zone:1412}; {area:363} has no druid trainer"] = "",

	-- Step 9: Back to the Den
	["Back to the Den"] = "동굴 막사로 돌아가기",
	-- {npc:11378} Foreman Thazz'ril
	["{npc:11378}, at the lumber pile east of the Den"] = "",

	-- Step 10: Lazy Peons
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "{item:16114}(으)로 {quest:5441} 깨우기",

	-- Step 13: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "동굴 안에서 첫 갈림길은 직진하고, 이어서 오른쪽으로 가 왼편 개울을 따라 폭포까지 가세요. 곡괭이는 바위 기둥 뒤 물가에서 빛나고 있습니다.",

	-- Step 14: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "동굴 안에서 개울을 건너 오른쪽 벽을 따라 끝까지 돌아가세요. {npc:3183}이(가) 끝에서 기다립니다.",
	["Below ground"] = "지하",

	-- Step 15: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "{npc:3102} 발굽",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "하급 지옥사냥개는 골짜기 북쪽, 동굴 아래 비탈을 돌아다닙니다.",

	-- Step 16: Back to the Den
	-- {object:654925} Lost Journal (no name in this language: may be words)
	["the {object:654925} on the ground beside her"] = "그녀 옆 땅바닥의 {object:654925}",

	-- Step 17: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887}은(는) 동굴 막사 바깥에 서 있습니다. {area:639}은(는) 그 바로 남쪽 언덕입니다. 그곳에서 {item:6635}을(를) 마셔 {npc:5891}을(를) 보고, {item:6656}을(를) {npc:5887}에게 가져가세요.",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}, {area:639} 위",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}: {npc:5873}, {item:5175}",

	-- Step 18: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786}은(는) 골짜기 동쪽 출구의 길 위에 서 있습니다.",

	-- Step 19: Sen'jin Village
	-- {area:362} Razor Hill
	["Careful: Ukorsbane (8) is elite and walks among the Ridgeshade spiders in the camp south of {area:362}: pull the spiders away from him."] = "주의: Ukorsbane(8)은(는) 정예이며 {area:362} 남쪽 야영지의 Ridgeshade 거미 사이를 걸어 다닙니다. 거미를 그에게서 멀리 끌어내십시오.",
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}: 마법부여사 전용, 잔여물은 {item:275724}을(를) 마력 추출해서 얻습니다",
	-- {npc:5880} Un'Thuwa
	["{npc:5880}, the mage trainer in Sen'jin"] = "",

	-- Step 20: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "{npc:265809}의 모닥불",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest · {zone:1454} Orgrimmar
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears. With a profession learned, {npc:265809} also offers its Camping 101, which its trainer takes: in {area:362} or in {zone:1454} at the start of the next guide."] = "{npc:265809}은(는) {area:362} 바로 남쪽에 야영하고 있습니다. {spell:1229451} 효과가 나타날 때까지 그의 모닥불 옆에 앉으세요(/sit). 전문 기술을 배웠다면 {npc:265809}에게서 해당 기술의 야영 기초(Camping 101) 퀘스트도 받을 수 있으며, 그 기술의 상급자에게 완료하세요. {area:362} 또는 다음 가이드 시작 지점인 {zone:1454}에 있습니다.",

	-- Step 21: Camping 101: Mining
	-- {npc:3175} Krunn · {skill:186} Mining
	["{npc:3175} takes it once your {skill:186} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{skill:186} 숙련도가 20이 되면 {npc:3175}이(가) 받습니다. 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속 진행됩니다.",
	-- {npc:265809} Brakk · {npc:3175} Krunn
	["{npc:265809}: for {npc:3175}"] = "{npc:265809}: {npc:3175}에게 전달",

	-- Step 22: Camping 101: Engineering
	-- {npc:11025} Mukdrak · {skill:202} Engineering
	["{npc:11025} takes it once your {skill:202} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{skill:202} 숙련도가 20이 되면 {npc:11025}이(가) 받습니다. 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속 진행됩니다.",
	-- {npc:265809} Brakk · {npc:11025} Mukdrak
	["{npc:265809}: for {npc:11025}"] = "{npc:265809}: {npc:11025}에게 전달",

	-- Step 23: Camping 101: First Aid
	-- {npc:5943} Rawrk · {skill:129} First Aid
	["{npc:5943} takes it once your {skill:129} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{skill:129} 숙련도가 20이 되면 {npc:5943}이(가) 받습니다. 그때까지 채집하거나 제작하십시오. 그동안 가이드는 계속 진행됩니다.",
	-- {npc:265809} Brakk · {npc:5943} Rawrk
	["{npc:265809}: for {npc:5943}"] = "{npc:265809}: {npc:5943}에게 전달",

	-- Step 24: Camping 101: Skinning
	-- {npc:265809} Brakk · {npc:7088} Thuwd
	["{npc:265809}: for {npc:7088}"] = "{npc:265809}: {npc:7088}에게 전달",

	-- Step 25: Camping 101: Leatherworking
	-- {npc:265809} Brakk · {npc:3365} Karolek
	["{npc:265809}: for {npc:3365}"] = "{npc:265809}: {npc:3365}에게 전달",

	-- Step 26: Camping 101: Tailoring
	-- {npc:265809} Brakk · {npc:2855} Snang
	["{npc:265809}: for {npc:2855}"] = "{npc:265809}: {npc:2855}에게 전달",

	-- Step 27: Camping 101: Herbalism
	-- {npc:265809} Brakk · {npc:3404} Jandi
	["{npc:265809}: for {npc:3404}"] = "{npc:265809}: {npc:3404}에게 전달",

	-- Step 28: Camping 101: Enchanting
	-- {npc:265809} Brakk · {npc:11066} Jhag
	["{npc:265809}: for {npc:11066}"] = "{npc:265809}: {npc:11066}에게 전달",

	-- Step 29: Camping 101: Alchemy
	-- {npc:265809} Brakk · {npc:11046} Whuut
	["{npc:265809}: for {npc:11046}"] = "{npc:265809}: {npc:11046}에게 전달",

	-- Step 30: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town; inside"] = "",

	-- Step 31: Razor Hill
	-- {npc:3191} Cook Torka
	["{npc:3191}: Camping 101 asks you to learn it"] = "",
	-- {npc:6928} Innkeeper Grosk
	["{npc:6928}, inside"] = "",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}, 감시탑 안",

	-- Step 35: Prickly pears
	["Prickly pears"] = "가시투성이 배",
	["The prickly pears grow among the quilboar huts just west of town."] = "가시투성이 배는 마을 바로 서쪽의 멧돼지인간 오두막 사이에 자랍니다.",

	-- Step 37: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps · {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "요새는 {area:362} 남동쪽 해안에 있습니다. 약탈자의 도끼, 활, 방패는 요새 외곽에 있습니다. 선원과 해병이 {item:4870}을(를) 떨어뜨립니다. {npc:3192}은(는) 요새 꼭대기에서 기다리며, 그의 열쇠로 옆 상자를 열면 {item:4881}이(가) 들어 있습니다.",
	["Upstairs"] = "위층",

	-- Step 38: Razor Hill
	-- {area:362} Razor Hill · {npc:3139} Gar'Thok · {npc:3147} Furl Scornbrow · {npc:3142} Orgnil Soulscar · {npc:266940} Turroc
	["Back north-west to {area:362}: {npc:3139} first, then {npc:3147} in the watchtower, then {npc:3142} and {npc:266940} on the way out east to the shore."] = "",
	-- {npc:266940} Turroc
	["{npc:266940}, inside"] = "",

	-- Step 39: Scuttle Coast: kill these as you meet them
	-- {area:373} Scuttle Coast
	["{area:373}: kill these as you meet them"] = "",
	-- {area:362} Razor Hill
	["The gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin.\nMakrura and surf crawlers line the beaches north-east of Sen'jin."] = "",
	["Underwater"] = "",

	-- Step 40: Echo Isles: kill these as you meet them
	-- {area:368} Echo Isles
	["{area:368}: kill these as you meet them"] = "",
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there.\nDurotar Tigers roam the isle as well as the shore south of Sen'jin, and the Taillasher eggs sit in nests on the isles and along the beach."] = "얕은 물을 건너 북쪽 메아리 섬으로 가세요. 그곳의 랩터들 사이를 우두머리 암컷이 배회합니다.\n듀로타 호랑이는 섬과 센진 남쪽 해안을 돌아다니며, 채찍꼬리 알은 섬과 해변을 따라 둥지에 있습니다.",

	-- Step 41: Echo Isles: kill these as you meet them
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle."] = "섬들을 지나 남쪽으로 가세요. 로아 우상은 남쪽 섬 곳곳에 있으며, 부두교 트롤과 {npc:3207}이(가) 이를 지키고 {item:275724}을(를) 떨어뜨립니다. {quest:826}와(과) 민시나의 우리는 가장 남쪽 섬에 있습니다.",

	-- Step 42: Deathskip to Sen'jin Village
	-- {area:367} Sen'jin Village
	["Deathskip to {area:367}"] = "",
	-- {npc:3206} Voodoo Troll · {npc:6491} Spirit Healer
	["Die to the mobs at 66.9,87.2 ({npc:3206}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "",

	-- Step 44: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "{area:366}은(는) 센진 서쪽에 있습니다. 공격 계획서 세 개는 켄타우로스 천막 사이 땅바닥에 있습니다. {npc:275811}도 그곳에 붙잡혀 있습니다.",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "{npc:275811}을(를) 풀어 주고 무사히 밖으로 데려가세요",

	-- Step 47: Level 10
	["Level 10"] = "",
	-- {quest:840} Conscript of the Horde · {area:362} Razor Hill
	["Top up here to level 10: {quest:840}, at {area:362}, needs level 10."] = "",
	-- {npc:3111} Razormane Quilboar
	["grind on {npc:3111}"] = "",

	-- Step 48: Razor Hill
	-- {npc:3169} Tarshaw Jaggedscar
	["{npc:3169}, inside"] = "",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}, 여관 옆",

	-- Step 49: Far Watch Post
	-- {area:814} Southfury River · {npc:3337} Kargal Battlescar · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge: {npc:3337} stands at {area:379} above it, on your way to {npc:5907}."] = "",

	-- Step 54: Kranal Fiss
	-- {area:814} Southfury River · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge, past {area:379} and on along the ridge: {npc:5907} stands alone above the Razormane camp."] = "",

	-- Step 55: Telf Joolam
	-- {zone:1411} Durotar · {npc:5900} Telf Joolam
	["Back over the bridge and south along the {zone:1411} bank of the river to where a narrow trail climbs the mountain: {npc:5900} keeps the shrine at the top. Mind the edges on the way up, and come back down the same trail."] = "",

	-- Step 56: Razormane Grounds
	["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "가시멧돼지와 정찰병이 마을 서쪽 오두막을, 사막길잡이와 전투호위병이 더 서쪽의 야영지를 차지하고 있습니다.",

	-- Step 57: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Head north-east to the road toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "",

	-- Step 58: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb · {area:371} Dustwind Cave · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}. Shamans: the Burning Blade Cultists by {area:371}, at the ravine's south end, drop the {item:6652}."] = "",

	-- Step 59: Deathskip to Northern Durotar
	["Deathskip to Northern Durotar"] = "",
	-- {npc:3118} Dustwind Storm Witch · {npc:6491} Spirit Healer
	["Die to the mobs at 52.0,21.4 ({npc:3118}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "",

	-- Step 62: Thunder Ridge: kill these as you meet them
	-- {area:369} Thunder Ridge
	["{area:369}: kill these as you meet them"] = "",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}.\nFizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way.\nCareful: Burning Blade cultists surround Fizzle, some linked so they aggro in pairs, and they respawn quickly.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "천둥도마뱀과 번개도마뱀은 {npc:3293} 바로 서쪽과 남서쪽의 {area:369}에서 풀을 뜯습니다.\n피즐은 {area:362} 북서쪽 {area:369}의 불타는칼날단 야영지를 차지하고 있습니다. 사냥꾼: 가는 길에 {item:15908}(으)로 {npc:3099}을(를) 길들이세요.\n주의: 불타는칼날단 이교도들이 피즐을 둘러싸고 있으며, 일부는 연결되어 있어 두 마리씩 덤비고, 빨리 다시 나타납니다.\n주의: 12레벨 정예 할리코르가 도마뱀들 사이로 {area:369}을(를) 돌아다닙니다. 끌어오기 전에 그를 살피세요.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "{item:15908}(으)로 길들이세요",

	-- Step 63: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "미샤의 오두막은 도마뱀들의 남쪽에 있습니다. 서쪽 {area:814}을(를) 따라 있는 악어가 {item:4891}을(를) 가지고 있습니다.",

	-- Step 65: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657}은(는) {area:362} 동쪽 해안에 서 있습니다. 삼지창, 깃발, 단검은 그 주변 해변에 있습니다.",

	-- Step 67: Paladin trainer
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:362} Razor Hill
	["{npc:246344} in {zone:1456}; {area:362} has no paladin trainer"] = "",

	-- Step 68: Druid trainer
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:362} Razor Hill
	["{npc:3034} in {zone:1412}; {area:362} has no druid trainer"] = "",

	-- Step 69: Razor Hill
	-- {area:362} Razor Hill · {npc:3139} Gar'Thok · {npc:3142} Orgnil Soulscar
	["Back to {area:362}: {npc:3139}, then {npc:3142}."] = "",

	-- Step 70: Spitelash naga
	["Spitelash naga"] = "원한의꼬리일족 나가",
	-- {area:370} Drygulch Ravine · {npc:275657} Heglan Shadeeye · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["North-east to the beach below {area:370}, north of {npc:275657}: Spitelash Scouts and Attendants hold it. Hunters: tame a {npc:3107} on the beach."] = "북동쪽으로 {npc:275657} 북쪽, {area:370} 아래 해변으로 가세요. 원한의꼬리일족 정찰병과 수행원이 그곳을 차지하고 있습니다. 사냥꾼: 해변에서 {npc:3107}을(를) 길들이세요.",

	-- Step 71: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828}은(는) 나가 해변 서쪽, {quest:827} 남쪽 언덕에 진을 치고 있습니다.",

	-- Step 73: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "{zone:1454} 정문은 {area:817} 바로 서쪽에 있습니다. {npc:5875}은(는) {object:172982} 아래 협곡인 {object:172960}에 서 있습니다.",

	-- Step 74: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 75: Back to Durotar
	-- {zone:1411} Durotar
	["Back to {zone:1411}"] = "",

	-- Step 76: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "{area:817} 입구",

	-- Step 77: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}.\nCareful: voidwalkers fight beside the Burning Blade cultists in {quest:827} and {npc:3204} (14) waits at the back with his own: pull one cultist at a time near the entrance for the collars. The {item:4903} is optional: leave {npc:3204} unless you are 13 or have a friend."] = "불타는 칼날단 이교도가 {quest:827}의 동굴을 차지하고 있으며, 누구든 {item:4871}을(를) 떨어뜨립니다. 14레벨 흑마법사 {npc:3204}은(는) 깊숙한 곳에 서 있으며 {item:4903}을(를) 떨어뜨립니다.\n주의: {quest:827}에서는 공허방랑자가 불타는 칼날단 이교도 옆에서 싸우고, {npc:3204}(14)은(는) 자기 공허방랑자와 함께 안쪽에서 기다립니다. 목걸이는 입구 근처에서 이교도를 하나씩 끌어와 얻으세요. {item:4903}은(는) 선택 사항입니다. 13레벨이 아니고 함께할 친구도 없다면 {npc:3204}은(는) 건드리지 마세요.",

	-- Step 78: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "{object:58595}은(는) 방금 싸운 이교도들 사이, {area:817} 안에 있습니다.",

	-- Step 80: Razor Hill
	-- {area:362} Razor Hill
	["Back to {area:362}."] = "{area:362}(으)로 돌아가세요.",

	-- Step 81: Razor Hill
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}: 정예 바다 거인 {npc:275666}",

	-- Step 82: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}, {area:362}에 돌아가서",

	-- Step 83: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "{npc:3126}은(는) {area:362} 서쪽 평원을 기어다닙니다. 하나를 길들인 뒤 {npc:3171}에게 돌아가세요.",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "",

	-- Step 84: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {npc:3337} Kargal Battlescar · {npc:5810} Uzzek · {area:379} Far Watch Post · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["West from {area:362} over the {area:814} bridge: {npc:3337} and {npc:5810} stand together at {area:379} above it. From there the road north through {zone:1411} leads to {zone:1454}."] = "",

	-- Step 85: Thunder lizards on the way north
	["Thunder lizards on the way north"] = "",
	-- {area:369} Thunder Ridge · {zone:1454} Orgrimmar · {item:6486} Singed Scale · {npc:5810} Uzzek · {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, beside the road north to {zone:1454}; any of them can drop a {item:6486}. {npc:5810} takes it when the next guide passes {area:379}.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "천둥도마뱀과 번개도마뱀은 {zone:1454}(으)로 가는 북쪽 길가의 {area:369}에서 풀을 뜯으며, 어느 것이든 {item:6486}을(를) 떨어뜨릴 수 있습니다. 다음 가이드가 {area:379}을(를) 지날 때 {npc:5810}이(가) 받습니다.\n주의: 12레벨 정예 할리코르가 도마뱀들 사이로 {area:369}을(를) 돌아다닙니다. 끌어오기 전에 그를 살피세요.",

	-- Step 87: Ormak Grimshot
	-- {area:379} Far Watch Post · {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor
	["Follow the road north from {area:379} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "길을 따라 {area:379}에서 북쪽 {area:817} 바로 서쪽의 {zone:1454} 정문까지 가세요. {npc:3352}은(는) {object:172958}에서 사냥꾼 상급자들과 함께 서 있습니다.",

	-- Step 88: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 89: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "{zone:1454}(으)로",
	-- {area:379} Far Watch Post · {zone:1454} Orgrimmar · {quest:829} Neeru Fireblade · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Follow the road north from {area:379} to {zone:1454}'s main gate. The next guide starts in {zone:1454}: {quest:829} takes the cultists' quest, the trainers teach your new ranks, and the zeppelin leaves from the towers outside the gate for {zone:1420} and {zone:1421}. {zone:1413} come after Silverpine."] = "",
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "",

	-- Step 90: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {item:6535} Tablet of Verga · {item:7464} Glyphs of Summoning · {zone:1454} Orgrimmar
	["{npc:5875} stands in the {object:172960}, the canyon under the {object:172982}. Hand him the {item:6535}, then use the {item:7464} on the summoning circle beside him and defeat the voidwalker to bind it.\nCareful: the voidwalker you summon hits hard and it is the fight Warlocks die to most in {zone:1454}: start at full health and mana, send your imp in, keep Corruption and Immolate on it, and use a healthstone if you have one."] = "{npc:5875}은(는) {object:172982} 아래 협곡인 {object:172960}에 있습니다. 그에게 {item:6535}을(를) 건넨 뒤, 옆의 소환진에서 {item:7464}을(를) 사용하고 공허방랑자를 물리쳐 속박하세요.\n주의: 소환한 공허방랑자는 강하게 공격하며, {zone:1454}에서 흑마법사가 가장 많이 죽는 전투입니다. 생명력과 마나를 가득 채우고 시작하고, 임프를 먼저 보내고, 부패와 제물을 계속 걸어 두고, 생명석이 있다면 사용하세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to {area:362}."] = "남쪽 {area:362}(으)로 돌아가세요.",
	-- ["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "{object:172960}의 {npc:5875}에게 돌아가세요. 그곳 소환진에서 {item:7464}을(를) 사용하고 공허방랑자를 물리쳐 속박하세요.",
	-- ["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "{npc:3130}와(과) {npc:3131}이(가) 다리 건너 {area:369}에서 풀을 뜯으며, 누구든 {item:6486}을(를) 떨어뜨릴 수 있습니다.",
	-- ["Thunder lizards across the river"] = "강 건너 천둥도마뱀",
	-- ["With {skill:129} learned, {npc:265809} also offers its Camping 101: {npc:5943} in {area:362} takes it."] = "{skill:129}을(를) 배웠다면 {npc:265809}에게서 해당 기술의 야영 기초(Camping 101) 퀘스트도 받을 수 있습니다. {area:362}의 {npc:5943}에게 완료하세요.",
	-- ["With {skill:165} learned, {npc:265809} also offers its Camping 101: {npc:3365} in {zone:1454} (next guide) takes it."] = "{skill:165}을(를) 배웠다면 {npc:265809}에게서 해당 기술의 야영 기초(Camping 101) 퀘스트도 받을 수 있습니다. {zone:1454}의 {npc:3365}에게 완료하세요(다음 가이드).",
	-- ["With {skill:171} learned, {npc:265809} also offers its Camping 101: {npc:11046} in {zone:1454} (next guide) takes it."] = "{skill:171}을(를) 배웠다면 {npc:265809}에게서 해당 기술의 야영 기초(Camping 101) 퀘스트도 받을 수 있습니다. {zone:1454}의 {npc:11046}에게 완료하세요(다음 가이드).",
	-- ["With {skill:182} learned, {npc:265809} also offers its Camping 101: {npc:3404} in {zone:1454} (next guide) takes it."] = "{skill:182}을(를) 배웠다면 {npc:265809}에게서 해당 기술의 야영 기초(Camping 101) 퀘스트도 받을 수 있습니다. {zone:1454}의 {npc:3404}에게 완료하세요(다음 가이드).",
	-- ["With {skill:186} learned, {npc:265809} also offers its Camping 101: {npc:3175} in {area:362} takes it."] = "{skill:186}을(를) 배웠다면 {npc:265809}에게서 해당 기술의 야영 기초(Camping 101) 퀘스트도 받을 수 있습니다. {area:362}의 {npc:3175}에게 완료하세요.",
	-- ["With {skill:197} learned, {npc:265809} also offers its Camping 101: {npc:2855} in {zone:1454} (next guide) takes it."] = "{skill:197}을(를) 배웠다면 {npc:265809}에게서 해당 기술의 야영 기초(Camping 101) 퀘스트도 받을 수 있습니다. {zone:1454}의 {npc:2855}에게 완료하세요(다음 가이드).",
	-- ["With {skill:202} learned, {npc:265809} also offers its Camping 101: {npc:11025} in {area:362} takes it."] = "{skill:202}을(를) 배웠다면 {npc:265809}에게서 해당 기술의 야영 기초(Camping 101) 퀘스트도 받을 수 있습니다. {area:362}의 {npc:11025}에게 완료하세요.",
	-- ["With {skill:333} learned, {npc:265809} also offers its Camping 101: {npc:11066} in {zone:1454} (next guide) takes it."] = "{skill:333}을(를) 배웠다면 {npc:265809}에게서 해당 기술의 야영 기초(Camping 101) 퀘스트도 받을 수 있습니다. {zone:1454}의 {npc:11066}에게 완료하세요(다음 가이드).",
	-- ["With {skill:393} learned, {npc:265809} also offers its Camping 101: {npc:7088} in {zone:1454} (next guide) takes it."] = "{skill:393}을(를) 배웠다면 {npc:265809}에게서 해당 기술의 야영 기초(Camping 101) 퀘스트도 받을 수 있습니다. {zone:1454}의 {npc:7088}에게 완료하세요(다음 가이드).",
}
