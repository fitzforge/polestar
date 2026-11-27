-- Korean (koKR): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:976} Gadgetzan · {zone:1451} Silithus · {zone:1446} Tanaris
	["{area:976} first, then {zone:1451}, Un'Goro and back to {zone:1446}."] = "먼저 {area:976}, 그다음 {zone:1451}, 운고로, 그리고 다시 {zone:1446}.",

	-- Step 1: Innkeeper Vizzie
	-- {npc:11118} Innkeeper Vizzie · {area:2255} Everlook · {area:2249} Frostwhisper Gorge
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["{npc:11118}, in {area:2255}'s inn, has more mail for you: the Ice Thistle Yetis in the hills south-east of town carry it. Keep it for the last guide, whose ride back north from {area:2249} crosses those hills."] = "",

	-- Step 2: Back from Mount Hyjal
	-- {zone:2482} Mount Hyjal
	["Back from {zone:2482}"] = "{zone:2482}에서 돌아와서",
	-- {zone:2482} Mount Hyjal · {area:2255} Everlook · {area:976} Gadgetzan · {npc:9299} Gaeriyan · {npc:7583} Sprinkle · {area:541} Marshal's Refuge · {zone:1451} Silithus
	["Back from {zone:2482}: fly from {area:2255} to {area:976} for {npc:9299}, {npc:7583} and Pestlezugg, then on to {area:541} and {zone:1451}."] = "",
	["Yugrek, the Horde flight master"] = "",

	-- Step 3: Gaeriyan
	-- {item:11243} Videre Elixir · {area:976} Gadgetzan · {npc:9299} Gaeriyan
	["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "{area:976} 바로 동쪽 묘지에서 {item:11243}을(를) 마시세요. 마시면 죽으며, 유령 상태에서만 그 정북쪽 언덕의 바위 틈에 있는 {npc:9299}을(를) 볼 수 있습니다. 그곳에서 그에게 말을 건 뒤 시체로 달려가 부활하세요. 그가 알려 주는 눈에 띄는 묘비는 그 묘지에 있습니다.",

	-- Step 4: Gaeriyan
	-- {npc:9299} Gaeriyan · {item:11243} Videre Elixir · {area:976} Gadgetzan
	["{npc:9299} has already met you: drink the {item:11243} at the graveyard just east of {area:976} and find him, as a ghost, in the rocky crevice due north of it."] = "{npc:9299}은(는) 이미 당신을 만났습니다: {area:976} 바로 동쪽 묘지에서 {item:11243}을(를) 마시고, 영혼 상태로 그 정북쪽 바위 틈에서 그를 찾으십시오.",

	-- Step 5: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "{area:976}의 고블린 소녀 {npc:7583}에게 {item:12928}을(를) 사용하세요. {npc:10977}와(과) {npc:10978}은(는) 나중에 경로 중 놀래 줍니다.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "{item:12928}(으)로 {npc:7583} 겁주기",

	-- Step 6: Alchemist Pestlezugg
	-- {quest:4493} March of the Silithid · {zone:1454} Orgrimmar · {zone:1447} Azshara
	["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1447} guide"] = "안쪽: {zone:1447} 가이드 중 {zone:1454}에서 {quest:4493}을(를) 받았다면",

	-- Step 7: Alchemist Pestlezugg
	["Inside"] = "내부",

	-- Step 9: Gaeriyan
	-- {object:148504} A Conspicuous Gravestone · {area:976} Gadgetzan · {npc:8737} Linken
	["Alive again, go to {object:148504} in the graveyard just east of {area:976} and use it: it takes the quest. {npc:8737}'s sword goes back to {npc:8737} in Un'Goro: keep it."] = "",
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914}은(는) 운고로 분화구의 {npc:8737}에게 돌아갑니다. 보관하세요.",

	-- Step 10: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771}은(는) {area:976} 남쪽, {area:1336}(으)로 가는 길가에 야영하고 있습니다.",

	-- Step 11: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "{area:541}(으)로 날아가기",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "{area:976} 비행 조련사",

	-- Step 12: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:8737} Linken · {npc:9117} J.D. Collie
	["The flight lands at {area:541}: {npc:8737} stands by the cave a few steps from the flight master, {npc:9117} inside it."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, 지하",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	-- was: ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "{quest:3942}을(를) 보관하세요: {npc:9116}은(는) 다음 가이드에서 {zone:1448}을(를) 지나는 길의 {area:2479}에 있습니다."
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the last guide's way through {zone:1448}."] = "",
	-- {item:12928} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {item:12928} on {npc:10977}"] = "",
	-- {npc:10977} Quixxil · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:10977} with {item:12928}"] = "",

	-- Step 13: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "운고로 분화구에서 오는 고갯길은 {zone:1451} 북동쪽의 묘지인 {area:3077}(으)로 이어집니다. {npc:13220}은(는) 무덤 사이에 서 있습니다.",

	-- Step 14: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "남서쪽의 {area:2738} 폐허로 가세요. {npc:11801}을(를) 위한 {object:179565}은(는) 무너진 집 중 한 곳 안에 있습니다.",

	-- Step 16: Cenarion Hold
	-- {area:3077} Valor's Rest · {npc:15189} Beetix Ficklespragg
	["Ride west from {area:3077} to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 17: Calandrath
	-- {skill:185} Cooking · {npc:15174} Calandrath
	["Cooks with 285 {skill:185} or more: {npc:15174}, the innkeeper you just bound with, wants word of the Twilight's Hammer's sandworm recipe; the cookbook lies in the outpost west of the Hold, where this guide goes later."] = "",

	-- Step 18: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}: 길에서 만나는 대로 잡으세요",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "작살미늘벌레, 돌꼬리전갈, 모래그물 바위거미가 요새 바로 북쪽 모래밭에 함께 있습니다.",

	-- Step 19: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Whirling Invaders = {npc:14455} Whirling Invader
	-- was: ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "빛나는 서판 조각은 맨 북서쪽 황혼의 망치단 야영지 주변에 있습니다. 그곳의 먼지 폭풍과 우레의 모래정령도 조각을 떨어뜨립니다. 주의: 가장 높은 우레의 모래정령과 회오리치는 침략자는 58레벨이니 한 번에 한 마리씩 끌어오세요."
	["The glowing tablet fragments lie on the ground around the Twilight camp in the far north-west: pick them up. The Dust Stormers and Desert Rumblers there may carry them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "",

	-- Step 20: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}은(는) 자기 건물 위층에 서 있습니다: 안쪽으로 올라가세요. 화살표는 층을 구분하지 못합니다.",

	-- Step 21: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "마파람 마을로 돌아가 탑에 오르세요. 꼭대기의 벌집을 건드리면 잠복꾼 하이브아쉬가 나옵니다. 그중 하나가 {item:17346}을(를) 지니고 있습니다.",
	-- {quest:8308} Brann Bronzebeard's Lost Letter · {area:2742} Hive'Ashi
	["{quest:8308}: now and then a {area:2742} silithid carries one; right-click it if it drops"] = "",
	-- {npc:15170} Rutgar Glyphshaper
	["for {npc:15170} at Bronzebeard's Encampment, later in this guide"] = "",

	-- Step 23: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "남동쪽으로 운고로 절벽 아래의 {area:3447}(으)로 가세요.",
	["Below ground"] = "지하",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "",

	-- Step 24: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "망치미늘벌레와 집게전갈",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "서쪽 모래언덕을 따라 북쪽으로 가세요. 망치미늘벌레와 돌꼬리집게전갈은 여기서부터 요새 쪽까지 퍼져 있습니다.",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "",

	-- Step 25: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "채찍전갈과 긴다리 긴다리 바위거미",
	-- {area:2744} Hive'Regal · {zone:1451} Silithus
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes north of {area:2744}, in the south-east of {zone:1451}."] = "돌채찍 가죽벗기개({npc:11737})와 바위 추적자({npc:11739})가 {zone:1451} 남동쪽, {area:2744} 북쪽 모래언덕을 돌아다닙니다.",

	-- Step 26: Twilight Vanguard
	["Twilight Vanguard"] = "황혼의 선봉대",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "{npc:11803}은(는) 맨 남서쪽의 선봉대 야영지를 돌아다닙니다. 이교도가 떨어뜨리는 {item:20404}은(는) 모두 보관하세요. 나중에 {npc:15306}와(과) 오르텔이 각각 열 개씩 원합니다.",

	-- Step 28: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200}은(는) 서쪽 야영지를 차지하고 있습니다.",

	-- Step 29: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "{npc:11804}은(는) {area:3425} 서쪽 전초기지에 서 있습니다. 이곳에서 떨어지는 암호화된 황혼의 문서도 보관하세요.",

	-- Step 30: Sandy Cookbook
	-- {object:180503} Sandy Cookbook · {npc:15174} Calandrath
	["The {object:180503} lies in the outpost: read it and take its torn page back to {npc:15174}."] = "",

	-- Step 31: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}과(와) {npc:15190}은(는) 자기 건물 위층에 서 있습니다: 안쪽으로 올라가세요. 화살표는 층을 구분하지 못합니다.",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "요새 서쪽의 {npc:15306}",

	-- Step 32: Calandrath
	-- {npc:15174} Calandrath · {object:180503} Sandy Cookbook
	["{npc:15174}, the innkeeper, takes the {object:180503}'s torn page."] = "",

	-- Step 33: Wanted: Deathclasp
	-- {npc:15196} Deathclasp
	["Wanted: {npc:15196}"] = "",
	-- {npc:15196} Deathclasp · {npc:15190} Noggle Ficklespragg · {npc:15182} Vish Kozus
	["{npc:15196}, Terror of the Sands, is a level 59 elite scorpid patrolling the mountains by {npc:15190}'s satchel, at your level: a group choice. The wanted poster stands in the middle of the Hold; {npc:15182} pays out."] = "",

	-- Step 34: Hermit Ortell
	-- {area:3447} Ortell's Hideout · {area:2738} Southwind Village
	["Ride south-east to {area:3447}, in the mountains south of {area:2738}."] = "",

	-- Step 35: Noggle's Lost Satchel
	-- {npc:15196} Deathclasp
	-- was: ["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "가방은 남쪽 끝 산속, 브론즈비어드 야영지 너머에 있습니다. 정예 전갈 죽음의 갈고리가 근처를 순찰합니다. 그가 떠나 있을 때 챙기세요."
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. {npc:15196}, an elite scorpid, patrols near it: grab it while he is away."] = "",

	-- Step 36: Deathclasp
	-- {npc:15196} Deathclasp
	["With your group: {npc:15196} walks the mountains around the satchel. Pull him away from the other scorpids."] = "",

	-- Step 37: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "",
	-- {npc:15170} Rutgar Glyphshaper
	["{npc:15170}, if Brann's letter dropped for you"] = "",

	-- Step 38: Twilight Base Camp
	-- {npc:15306} Bor Wildmane · {area:2739} Twilight Base Camp · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text · Twilight Avengers = {npc:11880} Twilight Avenger
	["Collect twenty Encrypted Twilight Texts, ten for {npc:15306} and ten for Ortell. The {area:2739} holds only elementals: the texts drop from the Twilight's Hammer cultists of the Vanguard in the far south-west, the Post in the west and the Outpost west of {area:3425}. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "",
	-- {npc:15306} Bor Wildmane
	["ten for each quest: {npc:15306} takes his ten before Ortell"] = "",

	-- Step 39: Twilight Base Camp
	["The spare texts from the cultists"] = "이교도에게서 얻은 남는 문서",

	-- Step 40: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "{area:3425}(으)로 돌아가기",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190}은(는) 자기 건물 위층에 서 있습니다: 안쪽으로 올라가세요. 화살표는 층을 구분하지 못합니다.",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "마랄리스의 다음 심부름인 '광기의 아가리 속으로'는 정예가 있는 {area:2744} 안으로 이어집니다. 건너뛰세요.",

	-- Step 41: Vish Kozus
	-- {npc:15182} Vish Kozus · {npc:15196} Deathclasp
	["{npc:15182}, Captain of the Guard, pays out for {npc:15196}'s pincer."] = "",

	-- Step 43: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "북동쪽의 {area:3077}(으)로 가세요. 그 옆의 고갯길로 {zone:1451}을(를) 떠납니다.",

	-- Step 45: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock
	-- was: ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "고갯길을 지나 북쪽 절벽을 따라 동쪽의 {area:541}(으)로 가세요. {npc:9997}은(는) 비행 조련사 옆에 서 있습니다."
	["You missed this on the Un'Goro guide's loop: through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "",

	-- Step 46: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["You missed this on the Un'Goro guide's loop: {npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "",

	-- Step 47: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "동쪽 {area:537}(으)로 가서 올라가 정상 근처 용암 분출구에서 {npc:10541}을(를) 사용한 뒤, 서쪽 {npc:10302}에게 돌아가세요.",

	-- Step 48: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302}이(가) {zone:1452}의 {npc:9298}에게 보냅니다. 보관하세요.",

	-- Step 49: Bungle in the Jungle
	-- {quest:4496} Bungle in the Jungle · {area:976} Gadgetzan · {area:540} Slithering Scar · {area:537} Fire Plume Ridge · {item:11018} Un'Goro Soil
	["Only if you took {quest:4496} in {area:976} on the way here: the Gorishi of the {area:540}, south of {area:537}, drop the Scent Gland, and most of the crater's beasts and plants drop {item:11018}."] = "이곳으로 오는 길에 {area:976}에서 {quest:4496}을(를) 수락한 경우에만: {area:537} 남쪽 {area:540}의 고리시 벌레가 향기샘을 떨어뜨리고, 분화구의 야수와 식물 대부분이 {item:11018}을(를) 떨어뜨립니다.",

	-- Step 50: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "",

	-- Step 51: Torwa Pathfinder
	-- {quest:4301} The Mighty U'cha · {area:541} Marshal's Refuge
	["{quest:4301}: his north-east cave is on your way back here from {area:541}"] = "",
	-- {npc:9684} Lar'korwi
	["Keep the bait for {npc:9684}'s lair, next (he is level 56)."] = "",

	-- Step 52: Lar'korwi
	-- {item:11568} Torwa's Pouch · {npc:9684} Lar'korwi
	["Open {item:11568}: it holds the meat and the pheromone mixture. {npc:9684}'s lair is the bone-strewn valley just south of the pylon: place the meat among the bones, then use the mixture on it to call {npc:9684}. He is level 56 and hits hard, so start at full health."] = "",

	-- Step 53: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999}이(가) 길을 잃고 지친 채 마루에 앉아 있습니다.",

	-- Step 54: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "{npc:9999} 호위",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 56: The Mighty U'cha
	-- {area:541} Marshal's Refuge · {npc:9622} U'cha · {npc:9619} Torwa Pathfinder
	["From {area:541} ride east to the cave in the crater's north-east corner: {npc:9622} (55) sits at its back among his gorillas, well under you now. Then south down the crater's east side to {npc:9619}."] = "",

	-- Step 58: Tanaris
	-- {npc:9619} Torwa Pathfinder · {area:541} Marshal's Refuge · {area:976} Gadgetzan
	["{npc:9619}'s corner has no flight master: ride north to {area:541} and fly to {area:976}."] = "",

	-- Step 59: Gadgetzan
	-- {quest:2741} The Super Egg-O-Matic · {area:976} Gadgetzan
	-- was: ["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "{area:976}(으)로 날아가세요. 아직 {quest:2741}을(를) 가지고 있나요? 기계는 마을 한가운데에 있습니다."
	["Still carrying {quest:2741}? The machine stands in the middle of {area:976}."] = "",

	-- Step 62: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",

	-- Step 63: Class trainer
	["Class trainer"] = "직업 전문가",

	-- Step 64: Paladin trainer
	["Paladin trainer"] = "성기사 상급자",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344}은(는) {zone:1456}에 있습니다. {zone:1454}에는 성전사 교관이 없습니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "찢어진 두루마리는 {area:2260} 남쪽의 납골당인 {area:2261} 입구에 있습니다.",
	-- ["Andorhal watchtowers and silos"] = "안돌할 감시탑과 저장고",
	-- ["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "이곳 이교도에게서 암호화된 황혼의 문서 스무 개를 모으세요. {npc:15306}에게 열 개, 오르텔에게 열 개입니다. 황혼의 복수자와 대지군주에게서 얻고, 화염약탈자와 돌소환사(59-60)는 피하세요.",
	-- ["Diseased Grizzlies"] = "오염된 불곰",
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "디더스가 {item:14619}({quest:838})을(를) 줍니다. 건너뛰세요.",
	-- ["Dredge Strikers"] = "작살미늘벌레",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "작살미늘벌레, 돌꼬리전갈, 모래그물 바위거미가 요새 바로 북쪽 모래밭에 함께 있습니다.",
	-- ["Dredge and scorpids"] = "미늘벌레와 전갈",
	-- ["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "길을 따라 동쪽으로 가면 {npc:11077}이(가) {area:200}의 가마솥을 지키고 있습니다.",
	-- ["Fly to {area:1637} and train."] = "{area:1637}(으)로 날아가 기술을 배우세요.",
	-- ["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "{area:976}(으)로 날아가세요. 아직 {quest:2741}을(를) 가지고 있나요? 기계는 마을 한가운데에 있습니다.",
	-- ["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "{area:976}(으)로 날아가세요. {object:142071}은(는) 마을 한가운데에 있습니다.",
	-- ["From the zeppelin tower ride east along the road to the {area:152}, on the way into the {zone:1422}."] = "비행선 탑에서 길을 따라 동쪽의 {area:152}(으)로 가세요. {zone:1422}(으)로 들어가는 길에 있습니다.",
	-- ["Hameya's mound"] = "하메야의 흙더미",
	-- ["Hameya's scroll"] = "하메야의 두루마리",
	-- ["Into {zone:1422}"] = "{zone:1422}(으)로",
	-- ["Into {zone:1423}"] = "{zone:1423}(으)로",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "미끼는 보관하세요. {npc:9684}은(는) 레벨 56이며, 두 번째 순회 때 그 소굴을 지납니다.",
	-- ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "{quest:3942}을(를) 보관하세요: {npc:9116}은(는) 다음 가이드에서 {zone:1448}을(를) 지나는 길의 {area:2479}에 있습니다.",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it. Set {npc:11615}'s termite barrel down in the middle of the lumber mill while you are there.\nCareful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "기사와 마법사는 {area:192}에서 일하고, 의무병과 사냥꾼은 그 남쪽에 야영합니다. 간 김에 제재소 한가운데에 {npc:11615}의 흰개미 통을 내려놓으세요.\n주의: {zone:1422}의 다른 여러 곳처럼 벌목지에도 58-59레벨 정예인 {npc:10996}이(가) 서 있을 수 있으니 거리를 두세요.",
	-- ["Level 57"] = "57레벨",
	-- ["Mark {npc:10902} with the {item:12815}"] = "{item:12815}(으)로 {npc:10902} 표시",
	-- ["Mark {npc:10903} with the {item:12815}"] = "{item:12815}(으)로 {npc:10903} 표시",
	-- ["Mark {npc:10904} with the {item:12815}"] = "{item:12815}(으)로 {npc:10904} 표시",
	-- ["Mark {npc:10905} with the {item:12815}"] = "{item:12815}(으)로 {npc:10905} 표시",
	-- ["Pamela and the {area:2261}"] = "파멜라와 {area:2261}",
	-- ["Radley and Durgen"] = "래들리와 드루겐",
	-- ["Ride east across the plaguelands to the chapel."] = "동쪽으로 역병지대를 가로질러 예배당으로 가세요.",
	-- ["Ride east along the road to the {area:152} on the border."] = "길을 따라 동쪽으로 경계의 {area:152}로 가세요.",
	-- ["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "동쪽으로 {area:2619} 옆 {npc:1855}의 오두막으로 가서 그의 이야기를 들으세요.",
	-- ["Ride north-east to {area:2276} by {area:2275}: the high elf Rangers, Pathstriders and Woodsmen guard it and the Registry lies inside. Careful: the Pathstriders are 57-58 but the Rangers reach 60: pull one at a time and take the Rangers last."] = "북동쪽 {area:2275} 옆의 {area:2276}(으)로 가세요. 하이 엘프 순찰자, 길잡이, 나무꾼이 지키고 있고 명부는 안에 있습니다. 주의: 길잡이는 57-58이지만 순찰자는 60까지 됩니다. 하나씩 끌고 순찰자는 마지막에 처치하세요.",
	-- ["Ride north-east to {area:3447}."] = "북동쪽의 {area:3447}(으)로 가세요.",
	-- ["Ride north-west to {npc:1855}'s hut."] = "북서쪽의 {npc:1855} 오두막으로 가세요.",
	-- ["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "남쪽의 안돌할로 가세요. {npc:10667}은(는) 마을 서쪽의 무너진 여관에서 기다립니다. {item:12815}을(를) 들고 탑 네 개의 출입구에 각각 서서 표시하세요. 마을 가장자리로만 다니세요. 마을 한가운데의 저장고 옆에서 {item:12627}을(를) 사용하면 시간의 기생충이 나옵니다.",
	-- ["Ride south-east from {npc:1855} to the {area:2260} farmhouse."] = "{npc:1855}에게서 남동쪽의 {area:2260} 농가로 가세요.",
	-- ["Ride south-west to {npc:10667} in Andorhal."] = "남서쪽 안돌할의 {npc:10667}에게 가세요.",
	-- ["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "남서쪽의 {area:2262}(으)로 가세요. 파멜라는 집들 사이에서 놀고 있습니다. {npc:11886}은(는) 마을 바로 서쪽의 납골당인 {area:2261}에 숨어 있습니다.\n주의: 머큐시오와 함께 정예가 아닌 몹 약 넷이 나옵니다. 그 자리에 나타나지 않고 무덤까지 걸어옵니다.",
	-- ["Ride west to the Horde camp north of {area:2744}."] = "서쪽으로 {area:2744} 북쪽의 호드 야영지로 가세요.",
	-- ["Ride west to the walled hold in the middle of the desert."] = "서쪽으로 사막 한가운데의 성벽 두른 요새로 가세요.",
	-- ["Scare {npc:10977} with {npc:10980}"] = "{npc:10980}(으)로 {npc:10977}을(를) 겁주세요",
	-- ["Scarlet Crusade"] = "붉은십자군",
	-- ["Scourge Champions"] = "스컬지 용사",
	-- ["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "스컬지 용사는 예배당 북쪽 {area:2270}을(를) 돌아다닙니다. 처치한 용사마다 {npc:11063}의 {item:13156}을(를) 대 보세요. 공명하는 해골이 그가 원하는 것입니다.",
	-- ["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "남부 사막 곳곳에서 실리시스트 모래기둥이 솟아오릅니다. 모래기둥이 남긴 실리시스트 속으로 걸어 들어가, 키리카의 야영지에 있는 호드의 실리시스트 추출기까지 가져가세요. 싸우거나 탈것에 오르면 떨어뜨립니다.",
	-- ["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "돌꼬리채찍전갈과 긴다리 바위거미는 키리카의 야영지 남서쪽 모래언덕을 돌아다닙니다.",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "{area:1637} 밖의 탑에서 {zone:1420}행 비행선을 타고 {zone:1458}(으)로 들어가세요. 실바나스는 {object:36126}에 있습니다.",
	-- ["The Dredge Crushers (57-58) of the south-east are two over you below 57. First top up to 57 on the Dredge Strikers (55-56) on the sands east of {area:3425}, where Sand Skitterers and Stonelash Scorpids (54-56) roam among them, away from the Silithid Darters of the northern sands. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "남동쪽의 망치미늘벌레(57-58)는 57 미만이면 두 레벨 위입니다. 먼저 {area:3425} 동쪽 모래밭의 작살미늘벌레(55-56)로 57까지 채우세요. 그 사이에 모래그물 바위거미와 돌꼬리전갈(54-56)이 돌아다니며, 북쪽 모래밭의 실리시드 투창벌레와는 떨어져 있습니다. 또는 파티와 함께 {area:1583} 던전(하층)이나 {quest:838} 던전을 도세요.",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "빛나는 서판 조각은 맨 북서쪽 황혼의 망치단 야영지 주변에 있습니다. 그곳의 먼지 폭풍과 우레의 모래정령도 조각을 떨어뜨립니다.",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "빛나는 서판 조각은 맨 북서쪽 황혼의 망치단 야영지 주변에 있습니다. 그곳의 먼지 폭풍과 우레의 모래정령도 조각을 떨어뜨립니다. 주의: 가장 높은 우레의 모래정령과 회오리치는 침략자는 58레벨이니 한 번에 한 마리씩 끌어오세요.",
	-- ["The lake for {quest:5845}"] = "{quest:5845}용 호수",
	-- ["The libram lies further north, on the way to {area:190}."] = "성서는 더 북쪽, {area:190}(으)로 가는 길에 있습니다.",
	-- ["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "제재소는 래들리 바로 옆에 있습니다. {npc:11615}의 흰개미 통을 제재소 한가운데에 내려놓으세요.",
	-- ["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "가방은 남쪽 끝 산속, 브론즈비어드 야영지 너머에 있습니다. 정예 전갈 죽음의 갈고리가 근처를 순찰합니다. 그가 떠나 있을 때 챙기세요.",
	-- ["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "방패는 {npc:1855}의 오두막 남쪽 {area:201}에 있습니다.",
	-- ["The wooden sign beside {npc:9997}"] = "{npc:9997} 옆의 나무 표지판",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675}은(는) {area:2261} 바로 뒤에 있습니다.",
	-- ["The {object:177675} is just south, behind the {area:2261}."] = "{object:177675}은(는) 바로 남쪽, {area:2261} 뒤에 있습니다.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: skip it if you are alone."] = "정예 몹입니다. 파티를 권장하니 함께할 사람을 찾으세요. {npc:11897}은(는) 60레벨 정예이므로 혼자라면 건너뛰세요.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "고갯길을 지나 북쪽 절벽을 따라 동쪽의 {area:541}(으)로 가세요. {npc:9997}은(는) 비행 조련사 옆에 서 있습니다.",
	-- ["Top up here to level 58 before Ortell's Rock Stalkers (57-59) and the south; {npc:15181}'s {quest:8304}, back at {area:3425}, needs level 58 too. The Dredge Crushers (57-58) on the way south-east are the ones {npc:15191} wants: leave the Twilight cultists around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "오르텔의 긴다리 바위거미(57-59)와 남쪽으로 가기 전에 여기서 58레벨까지 채우세요. {area:3425}에 있는 {npc:15181}의 {quest:8304}도 58레벨이 필요합니다. 남동쪽으로 가는 길의 망치미늘벌레(57-58)가 {npc:15191}이(가) 원하는 몹입니다. 그 주변의 황혼의 망치 이교도는 건드리지 마세요. 또는 파티와 함께 {area:1583} 던전(하층)이나 {quest:838} 던전을 도세요.",
	-- ["Underwater"] = "물속",
	-- ["Upstairs"] = "위층",
	-- ["Use {npc:10980} on {npc:10977}"] = "{npc:10977}에게 {npc:10980} 사용",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "서쪽의 {area:152}로 가세요. 다음 가이드는 조금 서쪽의 {zone:1458}에서 시작합니다.",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "경로의 이전 방문 때 이것을 놓쳤습니다. 지금 이것부터 합니다. 금방 끝나며 뒤에 이어지는 퀘스트를 열어 줍니다.",
	-- ["Zeppelin to {zone:1458}"] = "{zone:1458}행 비행선",
	-- ["grind on {npc:11740}"] = "{npc:11740} 사냥",
	-- ["grind on {npc:11741}"] = "{npc:11741} 사냥",
	-- ["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "고블린 {npc:10302}은(는) 수정탑 바로 동쪽 {area:543}에 있습니다.",
	-- ["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "{npc:10667}의 다로우샤이어 전투는 정예와 싸우며 끝납니다. 건너뛰세요.",
	-- ["{npc:10667}, upstairs"] = "{npc:10667}, 위층",
	-- ["{npc:10739} camps by the {area:202}, beside the cauldron; his bears roam the hills north and east of it, on the way to {area:201}."] = "{npc:10739}은(는) {area:202}의 가마솥 옆에 있습니다. 그의 곰들은 그 북쪽과 동쪽 언덕, {area:201}(으)로 가는 길에 돌아다닙니다.",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "{npc:10778}의 농장은 {area:152} 동쪽으로 첫 번째 농장입니다. 농장의 비명소리 구울이 그녀의 부적 나머지 반쪽을 지니고 있고, {npc:11075}은(는) 들판의 가마솥을 지키고 있습니다.",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "{npc:10926}의 심부름은 이 경로에 없습니다. 건너뛰세요.",
	-- ["{npc:11610} hides on the hill north-east of the {area:192}."] = "{npc:11610}은(는) {area:192} 북동쪽 언덕에 숨어 있습니다.",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "{npc:11878}의 심부름은 이 경로에 없습니다. 건너뛰세요.",
	-- ["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Dredge Crushers (57-58) west of the outpost, and leave the Twilight Avengers, Geolords and Stonecallers (57-61) around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "{area:3425}에 있는 {npc:15181}의 {quest:8304}에는 58레벨이 필요합니다. 전초기지 서쪽의 망치미늘벌레(57-58)로 레벨을 채우고, 그 주변의 Twilight Avengers, Geolords, Stonecallers(57-61)는 건드리지 마십시오. 또는 파티와 함께 대신 {area:1583} 던전(아래쪽)이나 {quest:838} 던전을 도십시오.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "{npc:15193}의 용사가 {area:2261} 북쪽의 {area:2260} 농가를 차지하고 있습니다.",
	-- ["{npc:15306}, on the west side of the Hold"] = "요새 서쪽의 {npc:15306}",
	-- ["{npc:1852} (61, elite) stands in the middle of Andorhal among Skeletal Warlords (56-57, elite): kill him with your group, then take the shard from {object:177241} there."] = "{npc:1852}(61, 정예)은(는) 안돌할 한가운데에서 해골 전쟁군주(56-57, 정예) 사이에 서 있습니다. 파티와 함께 처치한 뒤 그곳의 {object:177241}에서 파편을 가져가십시오.",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "{npc:1855}의 다음 임무인 명예의 상징은 이 경로에 없습니다. 건너뛰세요.",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "이제 {npc:9619}이(가) 북동쪽 동굴에 있는 {npc:9622}의 가죽을 요구합니다. 건너뛰세요.",
	-- ["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "{npc:9684}의 소굴은 수정탑 바로 남쪽에 있습니다. 그곳에서 {npc:9619}의 미끼를 사용하세요. {npc:9684}은(는) 레벨 56이고 공격이 강하니 생명력을 가득 채우고 시작하세요.",
	-- ["{quest:105}'s shard lies at {npc:1852}'s feet, in the middle of Andorhal: he is a level 61 elite with elite Skeletal Warlords about him, a fight for a group."] = "{quest:105}의 파편은 안돌할 한가운데, {npc:1852}의 발밑에 있습니다. 그는 정예 해골 전쟁군주에 둘러싸인 61레벨 정예이므로 파티용 전투입니다.",
}
